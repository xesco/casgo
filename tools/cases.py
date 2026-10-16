#!/usr/bin/env python3
"""Apply the detector's rules to CAS files, as src/detect.asm does.

Usage:
  cases.py FILE.CAS...

For each file it prints a TSV line: the file's name, the letters of the loader
cases whose rule the file matches (C calls, N Namco, S stub, B BASIC; P when none
does), and the cases the detector picks on a machine with internal RAM that has RAM
in its page 0 and on a machine without internal RAM, each as CASGO and the loader
and memory letters: CASGOCBR is the variant CASGOR with the option /CB. The
rules (docs/DESIGN.md, The detector and the variants):

- C: a block holds OUT (0A8h),A, and the same block or the one before holds a
  CALL or JP to 00E1h, 00E4h or 00E7h, and the file does not hold CasLink3's
  text [CasLink3]. Blocks end at block headers.
- N: the file holds D3 A8 E1 F1 E5 CD 00 00.
- S: the file holds the stub's build sequence 11 E1 00 D5 11 D9 CD D5, or the
  same with HL, 21 E1 00 E5 21 D9 CD E5.
- B: the file holds BLOAD, as the text or as the token CF followed by a quote,
  and either OUT (0A8h),A or a binary file that starts below 4000h and ends at
  4000h or above.
- The loader case is S for C and S, CB for C and B, else the first of C, N, S
  and B, else P.
- The memory case is M without internal RAM, or for a file that holds the slot
  module SLOT_MODULE or the Sydney engine's search SYDNEY_SEARCH. With internal
  RAM, T for a file that holds LEVEL9_SEARCH, PAGE2_TO_1 or PAGE1_SEARCH; R for
  a file that holds SLOT3_COPY; I for S; R when the file holds IN A,(0A8h)
  followed, at most 6 bytes later, by code that puts the slot of page 2 or 3, or
  slot 3, in page 0 (SLOT_MOVE), or the BASIC case's slot calls (SLOT_CALLS); I
  when it holds OUT (0A8h),A and no LD A,(0FCC1h); else R.
- A known tape, one of tools/known.tsv, gets the cases of its entry instead: the
  loader letters, and the memory letter when it is M or the machine has internal
  RAM with RAM in its page 0 (docs/DESIGN.md, The detector and the variants).
- No rule looks at the bytes that a binary file (BSAVE) loads below 8000h:
  BLOAD puts them into ROM on a cassette machine, so they never run.
"""
import re
import sys

HEADER = bytes.fromhex("1FA6DEBACC137D74")
NAMCO = bytes.fromhex("D3A8E1F1E5CD0000")
STUB_BUILD = bytes.fromhex("11E100D511D9CDD5")
STUB_BUILD_HL = bytes.fromhex("21E100E521D9CDE5")
OUT_A8 = bytes.fromhex("D3A8")
LD_EXPTBL = bytes.fromhex("3AC1FC")
BLOAD_TOKEN = bytes.fromhex("CF22")
# The text of CasLink3, a loader that reads the tape through the BIOS and checks
# its data with a CRC: the tape calls in the data never run, and the calls
# case's rewrite would break the CRC.
CASLINK = b"[CasLink3]"
# IN A,(0A8h), then at most 6 bytes, then code that puts the slot of page 2
# or 3, or slot 3, in page 0: SRA A, SRL A, RRC A, RRCA, RLCA, RRA or SRL E
# four times; RLCA, RLCA, AND 03h; AND 0F0h, LD C,A, OR 0Fh; AND 0F0h, LD C,A,
# LD B,0Fh, LD A,B, OR C; or AND 0F0h, LD B,03h, PUSH AF, ADD A,B.
SLOT_MOVE = re.compile(
    rb"\xDB\xA8.{0,6}(?:(?:\xCB\x2F){4}|(?:\xCB\x3F){4}|(?:\xCB\x0F){4}"
    rb"|\x0F{4}|\x07{4}|\x1F{4}|\x07\x07\xE6\x03|\xE6\xF0\x4F\xF6\x0F|(?:\xCB\x3B){4}"
    rb"|\xE6\xF0\x4F\x06\x0F\x78\xB1|\xE6\xF0\x06\x03\xF5\x80)", re.S)
# The BASIC case's slot calls: LD A,(nn), LD HL,0000h, CALL nn, LD HL,4000h,
# CALL nn with the same nn. A loader with them copies code into the RAM it
# finds for page 0, from slot 3 down, which is the internal RAM.
# The end of a slot module's copy of ENASLT, LD B,A, POP AF, AND A, RET, then
# CALL 0138h, RSLREG: the module runs ENASLT from page 3, so it needs page 3 in
# the mapper's slot, M.
SLOT_MODULE = bytes.fromhex("47F1A7C9CD3801")
# LD A,0FFh, OUT (0A8h),A, then within 8 bytes LD DE,nn below 4000h: slot 3
# in every page, then a copy into page 0 of slot 3, the internal RAM, so R,
# even for the stub case.
SLOT3_COPY = re.compile(rb"\x3E\xFF\xD3\xA8.{0,7}?\x11.[\x00-\x3F]", re.S)
# The start of the Sydney engine's search for RAM for page 1, IN A,(0A8h),
# AND 0F3h, PUSH AF, AND 30h, LD B,A, POP AF, SUB 04h: from slot 0 up it finds
# the mapper first, and the game later puts page 2 there too, so M.
SYDNEY_SEARCH = bytes.fromhex("DBA8E6F3F5E63047F1D604")
# Level 9's search for RAM: IN A,(0A8h) / AND E / LD B,A / LD A,D / AND (HL) /
# OR B / OUT (0A8h),A, for pages 2, 1 and 0 from slot 0 up. It needs T.
LEVEL9_SEARCH = bytes.fromhex("DBA8A3477AA6B0D3A8")
# Page 2's slot put in page 1: IN A,(0A8h) / LD C,A / SRL A / SRL A / AND 0Ch /
# OR C. It needs T.
PAGE2_TO_1 = bytes.fromhex("DBA84FCB3FCB3FE60CB1")
# The search for RAM for page 1 alone, keeping page 2's slot: LD A,B / AND 30h /
# LD B,A / IN A,(0A8h) / AND 0F3h / SUB 04h. It needs T.
PAGE1_SEARCH = bytes.fromhex("78E63047DBA8E6F3D604")
# A slot search from slot 3 down, LD C,03h, LD B,00h, LD HL,0FCC1h, ADD HL,BC,
# BIT 7,(HL), whose RAM test finds the internal RAM's page 0 first.
SLOT_SEARCH = bytes.fromhex("0E03060021C1FC09CB7E")
SLOT_CALLS = re.compile(rb"\x3A..\x21\x00\x00\xCD(..)\x21\x00\x40\xCD\1", re.S)


def find_all(data, pattern):
    """The offsets where pattern starts in data."""
    i = data.find(pattern)
    while i >= 0:
        yield i
        i = data.find(pattern, i + 1)


def tape_call(block):
    """Whether block holds a CALL or JP to TAPION, TAPIN or TAPIOF."""
    return any(bytes([op, low, 0]) in block for low in (0xE1, 0xE4, 0xE7) for op in (0xCD, 0xC3))


def loader_cases(data):
    """The letters of the loader cases whose rule data matches."""
    found = ""
    ends = [i for i in find_all(data, HEADER)] + [len(data)]
    start = 0
    prev_call = False
    calls = False
    for end in ends:
        block = data[start:end + len(HEADER)]
        call = tape_call(block)
        if OUT_A8 in block and (call or prev_call):
            calls = True
        prev_call = call
        start = end + len(HEADER)
    if calls and CASLINK not in data:
        found += "C"
    if NAMCO in data:
        found += "N"
    if STUB_BUILD in data or STUB_BUILD_HL in data:
        found += "S"
    if (b"BLOAD" in data or BLOAD_TOKEN in data) and (OUT_A8 in data or page0_file(data)):
        found += "B"
    return found


def variant(data, iram):
    """The variant the detector picks; iram says the machine has internal RAM."""
    found = loader_cases(data)
    if "C" in found and "S" in found:
        loader = "S"
    elif "C" in found and "B" in found:
        loader = "CB"
    else:
        loader = found[:1] or "P"
    if not iram or SLOT_MODULE in data or SYDNEY_SEARCH in data:
        memory = "M"
    elif LEVEL9_SEARCH in data or PAGE2_TO_1 in data or PAGE1_SEARCH in data:
        memory = "T"
    elif SLOT3_COPY.search(data):
        memory = "R"
    elif loader == "S":
        memory = "I"
    elif SLOT_MOVE.search(data) or SLOT_CALLS.search(data) or SLOT_SEARCH in data:
        memory = "R"
    elif OUT_A8 in data and LD_EXPTBL not in data:
        memory = "I"
    else:
        memory = "R"
    return "CASGO" + loader + memory


def page0_file(data):
    """Whether a binary file of data starts below 4000h and ends at 4000h or above."""
    starts = list(find_all(data, HEADER))
    binary = False
    for k, h in enumerate(starts):
        block = data[h + 8:starts[k + 1] if k + 1 < len(starts) else len(data)]
        if block[:10] in (bytes([0xD0]) * 10, bytes([0xD3]) * 10, bytes([0xEA]) * 10):
            binary = block[0] == 0xD0
            continue
        if binary and len(block) >= 6:
            start = block[0] | block[1] << 8
            end = block[2] | block[3] << 8
            if start < 0x4000 <= end:
                return True
        binary = False
    return False


def without_rom_bytes(data):
    """data with the bytes that binary files load below 8000h set to 0."""
    out = bytearray(data)
    starts = list(find_all(data, HEADER))
    binary = False
    for k, h in enumerate(starts):
        block = data[h + 8:starts[k + 1] if k + 1 < len(starts) else len(data)]
        if block[:10] in (bytes([0xD0]) * 10, bytes([0xD3]) * 10, bytes([0xEA]) * 10):
            binary = block[0] == 0xD0
            continue
        if binary and len(block) >= 6:
            start = block[0] | block[1] << 8
            end = block[2] | block[3] << 8
            if start < 0x8000 and end >= start:
                first = h + 8 + 6
                for i in range(first, min(first + min(end, 0x7FFF) - start + 1, len(out))):
                    out[i] = 0
        binary = False
    return bytes(out)


KNOWN_TSV = __file__.rsplit("/", 1)[0] + "/known.tsv"


def known_entries():
    """The known tapes' (kind, block, values, cases) from tools/known.tsv."""
    out = []
    for line in open(KNOWN_TSV):
        if line.strip() and not line.startswith("#"):
            f, cases, block, kind, values = line.rstrip("\n").split("\t")[:5]
            if kind == "len":
                vals = tuple(int(v) for v in values.split(","))
            else:
                vals = bytes.fromhex(values)
            out.append((kind, int(block), vals, cases))
    return out


def known_cases(raw):
    """The cases of the known tape that raw is, or None, as the detector looks
    them up: the lengths of blocks N on, or the first bytes of block N, counted
    from the first header. The last entry that matches counts."""
    starts = list(find_all(raw, HEADER)) + [len(raw)]
    blocks = [raw[starts[k] + 8:starts[k + 1]] for k in range(len(starts) - 1)][:255]
    lengths = [len(b) for b in blocks]
    found = None
    for kind, block, vals, cases in known_entries():
        if kind == "len":
            if tuple(lengths[block:block + len(vals)]) == vals:
                found = cases
        elif block < len(blocks) and blocks[block][:8] == vals:
            found = cases
    return found


def with_known(picked, cases, iram):
    """picked with a known tape's cases: its loader letters, and its memory
    letter when it is M or the machine has internal RAM with RAM in page 0."""
    if cases is None:
        return picked
    memory = cases[-1] if cases[-1] == "M" or iram else picked[-1]
    return "CASGO" + cases[:-1] + memory


def main():
    for path in sys.argv[1:]:
        raw = open(path, "rb").read()
        data = without_rom_bytes(raw)
        name = path.rsplit("/", 1)[-1]
        known = known_cases(raw)
        print(f"{name}\t{loader_cases(data) or 'P'}\t{with_known(variant(data, True), known, True)}\t"
              f"{with_known(variant(data, False), known, False)}")


if __name__ == "__main__":
    main()
