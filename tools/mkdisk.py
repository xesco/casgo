#!/usr/bin/env python3
"""Write a FAT12 disk image that holds the given files in its root directory.

Usage: mkdisk.py IMAGE FILE...

The image has no partition table. Nextor maps a device without one to its
sector 0 (Nextor 2.1 User Manual, "the drive is mapped to its absolute sector
zero"), so the FAT12 volume starts there. Its layout is the standard 720 KB
double-sided disk, which MSX-DOS 1, MSX-DOS 2 and Nextor all read.

Each file keeps its name, upper-cased, and must be a valid 8.3 name. Files are
stored one after another in consecutive clusters, with a fixed date, so the
same inputs always give the same image.
"""
import os
import struct
import sys

SECTOR = 512
SECTORS_PER_CLUSTER = 2
RESERVED_SECTORS = 1        # the boot sector
FATS = 2
SECTORS_PER_FAT = 3
ROOT_ENTRIES = 112
TOTAL_SECTORS = 1440
MEDIA = 0xF9                # 720 KB, double-sided, 9 sectors per track

ROOT_SECTORS = ROOT_ENTRIES * 32 // SECTOR
FIRST_DATA_SECTOR = RESERVED_SECTORS + FATS * SECTORS_PER_FAT + ROOT_SECTORS
CLUSTER = SECTOR * SECTORS_PER_CLUSTER
CLUSTERS = (TOTAL_SECTORS - FIRST_DATA_SECTOR) // SECTORS_PER_CLUSTER
DATE_1980_01_01 = (0 << 9) | (1 << 5) | 1


def boot_sector():
    """A standard boot sector: the BIOS parameter block and a boot code of RET.

    Nextor runs the boot code of a sector it takes for MSX-DOS 1 or 2, and
    leaves alone a "standard" one: one with the extended boot signature (29h)
    and a file system name starting with "FAT1" (Nextor source,
    kernel/bank0/init.mac, BSEC_TYPE). The boot code is a RET, so a DOS that
    does run it carries on.
    """
    s = bytearray(SECTOR)
    s[0:3] = b"\xEB\x3C\x90"            # JR to the boot code at 3Eh, NOP
    s[3:11] = b"CASGO   "
    struct.pack_into("<HBHBHHBHHHI", s, 11,
                     SECTOR, SECTORS_PER_CLUSTER, RESERVED_SECTORS, FATS,
                     ROOT_ENTRIES, TOTAL_SECTORS, MEDIA, SECTORS_PER_FAT,
                     9, 2, 0)           # sectors per track, heads, hidden
    struct.pack_into("<IBBBI11s8s", s, 32,
                     0,                 # large sector count: unused
                     0, 0, 0x29,        # drive number, reserved, signature
                     0x0CA5600, b"CASGO      ", b"FAT12   ")
    s[0x3E] = 0xC9                      # RET
    s[510:512] = b"\x55\xAA"
    return s


def dos_name(path):
    """The 11-byte directory name of a file, or an error for a non-8.3 name."""
    base, _, ext = os.path.basename(path).upper().partition(".")
    if not 1 <= len(base) <= 8 or len(ext) > 3 or "." in ext:
        sys.exit(f"error: {path}: not an 8.3 file name")
    return f"{base:<8}{ext:<3}".encode("ascii")


def set_fat12(fat, cluster, value):
    """Store a 12-bit FAT entry: two entries share three bytes."""
    i = cluster * 3 // 2
    if cluster % 2 == 0:
        fat[i] = value & 0xFF
        fat[i + 1] = (fat[i + 1] & 0xF0) | (value >> 8)
    else:
        fat[i] = (fat[i] & 0x0F) | ((value & 0x0F) << 4)
        fat[i + 1] = value >> 4


def main():
    if len(sys.argv) < 3:
        sys.exit(__doc__.strip().splitlines()[2])
    image_path, files = sys.argv[1], sys.argv[2:]
    if len(files) > ROOT_ENTRIES:
        sys.exit(f"error: {len(files)} files, the root directory holds {ROOT_ENTRIES}")

    fat = bytearray(SECTORS_PER_FAT * SECTOR)
    fat[0:3] = bytes([MEDIA, 0xFF, 0xFF])   # entries 0 and 1 are reserved
    root = bytearray(ROOT_SECTORS * SECTOR)
    data = bytearray()
    next_cluster = 2                         # the first data cluster

    for n, path in enumerate(files):
        with open(path, "rb") as f:
            content = f.read()
        count = max(1, -(-len(content) // CLUSTER))
        if next_cluster + count - 2 > CLUSTERS:
            sys.exit(f"error: {path}: the image is full")
        for c in range(next_cluster, next_cluster + count):
            set_fat12(fat, c, c + 1 if c < next_cluster + count - 1 else 0xFFF)
        entry = dos_name(path) + bytes([0x20]) + bytes(10)   # archive attribute
        entry += struct.pack("<HHHI", 0, DATE_1980_01_01,
                             next_cluster if content else 0, len(content))
        root[n * 32:(n + 1) * 32] = entry
        data += content.ljust(count * CLUSTER, b"\0")
        next_cluster += count

    image = boot_sector() + fat * FATS + root + data
    image = image.ljust(TOTAL_SECTORS * SECTOR, b"\0")
    with open(image_path, "wb") as f:
        f.write(image)


if __name__ == "__main__":
    main()
