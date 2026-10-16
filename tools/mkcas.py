#!/usr/bin/env python3
"""Write a CAS file that holds one file, as the MSX BASIC would save it to tape.

Usage:
  mkcas.py [--type HH] [--skew N] [--short] OUT.CAS binary NAME START EXEC FILE
  mkcas.py [--type HH] [--skew N] OUT.CAS basic NAME FILE
  mkcas.py [--type HH] [--skew N] OUT.CAS ascii NAME FILE
  mkcas.py OUT.CAS raw FILE

NAME is the tape name, up to 6 characters. Every block of the CAS follows the
8-byte CAS header, and each header starts at a multiple of 8, as in CAS files
saved by emulators. The first block identifies the file: ten type bytes and the
name. The blocks after it depend on the type (Red Book ch. 5):

  binary  (D0h, BSAVE)  One block: the START, stop and EXEC addresses, low byte
          first, then FILE. START and EXEC are hexadecimal. The Red Book leaves
          open whether BLOAD also loads the byte at the stop address, so FILE
          gets one spare zero byte, the stop address is that byte's, and the
          file loads whole either way.
  basic   (D3h, CSAVE)  One block: FILE, a tokenized program ending in its zero
          end link, then seven zero bytes.
  ascii   (EAh, SAVE)   FILE in blocks of 256 bytes, the last one ending in 1Ah
          and padded with 1Ah.

A raw file is one block that holds FILE, with no identification block, as a
machine-code loader reads it after its own file.

Three options make files for the tests: --type HH writes the type byte HH
(hexadecimal) in place of the type's own; --skew N puts N zero bytes before the
first header, so that no header starts at a multiple of 8; and --short leaves
the spare zero byte out of a binary file but keeps its stop address, so that
BLOAD reads one byte past the block, as in Transball's CAS file.
"""
import argparse
import sys

CAS_HEADER = bytes.fromhex("1FA6DEBACC137D74")
TYPES = {"binary": 0xD0, "basic": 0xD3, "ascii": 0xEA}
EOF = 0x1A


def add_block(cas, data):
    """Pad the CAS to a multiple of 8, then add a header and the block's data."""
    cas += bytes(-len(cas) % 8)
    cas += CAS_HEADER + data


def data_blocks(args, content):
    """The blocks after the identification block, for the file's type."""
    if args.kind == "binary":
        start, exec_ = int(args.start, 16), int(args.exec_, 16)
        data = content + b"\0"
        stop = start + len(data) - 1
        if args.short:
            data = content
        if stop > 0xFFFF:
            sys.exit(f"error: {args.file}: does not fit below 10000h from {start:04X}h")
        return [start.to_bytes(2, "little") + stop.to_bytes(2, "little")
                + exec_.to_bytes(2, "little") + data]
    if args.kind == "basic":
        return [content + bytes(7)]
    text = content + bytes([EOF])
    text += bytes([EOF]) * (-len(text) % 256)
    return [text[i:i + 256] for i in range(0, len(text), 256)]


def main():
    parser = argparse.ArgumentParser(usage=__doc__.split("Usage:")[1].split("\n\n")[0])
    parser.add_argument("--type")
    parser.add_argument("--skew", type=int, default=0)
    parser.add_argument("--short", action="store_true")
    parser.add_argument("out")
    kinds = parser.add_subparsers(dest="kind", required=True)
    binary = kinds.add_parser("binary")
    binary.add_argument("name")
    binary.add_argument("start")
    binary.add_argument("exec_")
    binary.add_argument("file")
    for kind in ("basic", "ascii"):
        k = kinds.add_parser(kind)
        k.add_argument("name")
        k.add_argument("file")
    kinds.add_parser("raw").add_argument("file")
    args = parser.parse_args()
    if args.kind == "raw":
        with open(args.file, "rb") as f:
            cas = bytearray()
            add_block(cas, f.read())
        with open(args.out, "wb") as f:
            f.write(cas)
        return
    if len(args.name) > 6:
        parser.error(f"{args.name}: a tape name has at most 6 characters")
    type_byte = int(args.type, 16) if args.type else TYPES[args.kind]
    with open(args.file, "rb") as f:
        content = f.read()

    cas = bytearray()
    add_block(cas, bytes([type_byte]) * 10 + args.name.ljust(6).encode("ascii"))
    for block in data_blocks(args, content):
        add_block(cas, block)
    with open(args.out, "wb") as f:
        f.write(bytes(args.skew) + cas)


if __name__ == "__main__":
    main()
