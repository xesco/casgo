#!/usr/bin/env python3
"""Write the detector's table of known tapes, and the variants' table of their
patches, from tools/known.tsv.

Usage:
  known.py KNOWN.TSV OUT.ASM PATCHES.ASM

known.tsv lists the tapes that the detector's rules give the wrong cases, and
the tapes that load only with a patch, one per row after a header row. Its
columns: title, cases (loader letters and a memory letter), block, kind, values,
patches and notes; the title and notes are for people. A cell that spans lines,
as a long note does, is in double quotes. Blocks are counted
from 0 at the first header. A len row matches when the blocks from BLOCK on have
the lengths in VALUES, 2 to 6 of them, comma-separated, in bytes after their
headers; a bytes row matches when block BLOCK starts with the 8 bytes in VALUES,
in hexadecimal. PATCHES is - for none, or comma-separated changes OFFSET=OLD>NEW
in hexadecimal: the file's bytes from OFFSET on, OLD, become NEW when every OLD of
the row matches. NEW has as many bytes as OLD, or one byte that each of them
becomes. NEW is S for T0's slot, or S^NN for T0's slot XOR NN, with one byte of
OLD. The notes say why a tape needs its patch.

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
import csv
import sys


def patches(path, f, text):
    """The (offset, old, new, flag) of each byte a patches column changes, or ()."""
    if text == "-":
        return ()
    out = []
    for p in text.split(","):
        try:
            where, change = p.split("=")
            old, new = change.split(">")
            where = int(where, 16)
            old = bytes.fromhex(old)
            flag = 0
            if new.startswith("S"):
                flag = 1
                new = new[2:] if new.startswith("S^") else "00"
            new = bytes.fromhex(new)
        except ValueError:
            sys.exit(f"error: {path}: {f}: bad patch {p}")
        if len(new) == 1:
            new = new * len(old)
        if not old or len(new) != len(old) or not 0 <= where < (1 << 24) - len(old):
            sys.exit(f"error: {path}: {f}: bad patch {p}")
        out += [(where + i, old[i], new[i], flag) for i in range(len(old))]
    return tuple(out)


def entries(path):
    """The (kind, block, values, loader, memory, patch number) of each line, in
    file order, and the patch sets, the first for patch number 1."""
    seen = []
    sets = []
    with open(path, newline="") as fh:
        rows = list(csv.reader(fh, delimiter="\t"))
    for row in rows[1:]:                # the first row holds the column names
        if not row or row[0].startswith("#"):
            continue
        f, cases, block, kind, values, text = row[:6]
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
