#!/usr/bin/env python3
"""Write the detector's table of known tapes, and the variants' table of their
patches, from tools/known.tsv.

Usage:
  known.py KNOWN.TSV OUT.ASM PATCHES.ASM

Each entry of the detector's table starts with its kind, 0 for block lengths and
1 for a block's first bytes, then the first block's number and the count of
values. A lengths entry then holds that many lengths in 3 bytes each, low byte
first, and a bytes entry that many bytes. The loader letters, padded with 0 to 2
bytes, the memory letter and the patch number, 0 for none, end each entry. Equal
entries are written once, and 0FFh ends the table.

The tapes with patches get the numbers 1, 2 and on, in file order. The variants'
table holds the count of patch sets, then for each a word that points to it. A
set holds its count of patches, then for each the file offset in 3 bytes, low
byte first, the old byte, the new byte and a flag, 1 when T0's slot is XORed
into the new byte.
"""
import sys


def patches(path, f, text):
    """The (offset, old, new, flag) of each patch in a patches column, or ()."""
    if text == "-":
        return ()
    out = []
    for p in text.split(","):
        try:
            where, change = p.split("=")
            old, new = change.split(">")
            flag = 0
            if new.startswith("S"):
                flag = 1
                new = new[2:] if new.startswith("S^") else "00"
            out.append((int(where, 16), int(old, 16), int(new, 16), flag))
        except ValueError:
            sys.exit(f"error: {path}: {f}: bad patch {p}")
        where, old, new, _ = out[-1]
        if not (0 <= where < 1 << 24 and 0 <= old < 256 and 0 <= new < 256):
            sys.exit(f"error: {path}: {f}: bad patch {p}")
    return tuple(out)


def entries(path):
    """The (kind, block, values, loader, memory, patch number) of each line, in
    file order, and the patch sets, the first for patch number 1."""
    seen = []
    sets = []
    for line in open(path):
        if not line.strip() or line.startswith("#"):
            continue
        f, cases, block, kind, values, text = line.rstrip("\n").split("\t")[:6]
        ps = patches(path, f, text)
        number = 0
        if ps:
            sets.append(ps)
            number = len(sets)
            if number > 255:
                sys.exit(f"error: {path}: more than 255 patch sets")
        if kind == "len":
            vals = tuple(int(v) for v in values.split(","))
            if not 2 <= len(vals) <= 6:
                sys.exit(f"error: {path}: {f}: 2 to 6 lengths")
            e = (0, int(block), vals, cases[:-1], cases[-1], number)
        elif kind == "bytes":
            vals = tuple(bytes.fromhex(values))
            if len(vals) != 8:
                sys.exit(f"error: {path}: {f}: 8 bytes")
            e = (1, int(block), vals, cases[:-1], cases[-1], number)
        else:
            sys.exit(f"error: {path}: {f}: unknown kind {kind}")
        if not 0 <= e[1] < 255 or len(e[3]) > 2:
            sys.exit(f"error: {path}: {f}: bad block or cases")
        if e not in seen:
            seen.append(e)
    return seen, sets


def main():
    src, out, pout = sys.argv[1:4]
    table, sets = entries(src)
    with open(out, "w") as o:
        o.write("; The known tapes, written by tools/known.py from tools/known.tsv.\n")
        o.write("known_table:\n")
        for kind, block, vals, loader, memory, number in table:
            o.write(f"        db {kind}, {block}, {len(vals)}\n")
            if kind == 0:
                o.write("        d24 " + ", ".join(str(v) for v in vals) + "\n")
            else:
                o.write("        db " + ", ".join(f"{v:03X}h" for v in vals) + "\n")
            letters = [f'"{c}"' for c in loader] + ["0"] * (2 - len(loader))
            o.write(f"        db {', '.join(letters)}, \"{memory}\", {number}\n")
        o.write("        db 0FFh\n")
    with open(pout, "w") as o:
        o.write("; The known tapes' patches, written by tools/known.py from tools/known.tsv.\n")
        o.write("patch_table:\n")
        o.write(f"        db {len(sets)}\n")
        for k in range(len(sets)):
            o.write(f"        dw patch_set_{k + 1}\n")
        for k, ps in enumerate(sets):
            o.write(f"patch_set_{k + 1}:\n")
            o.write(f"        db {len(ps)}\n")
            for where, old, new, flag in ps:
                o.write(f"        d24 0{where:X}h\n")
                o.write(f"        db 0{old:02X}h, 0{new:02X}h, {flag}\n")


if __name__ == "__main__":
    main()
