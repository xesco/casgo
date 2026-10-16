#!/usr/bin/env python3
"""Compare two MSX screens saved by test/game.tcl (CASGO_SCREEN).

Usage:
  screens.py SCREEN1 SCREEN2

Each SCREEN is the path that CASGO_SCREEN named: SCREEN.vram holds video RAM and
SCREEN.regs the VDP registers 0 to 7. The script draws both screens as 256 x 192
colour indices, in the TMS9918 modes that MSX1 games use (text, graphic 1,
graphic 2 and multicolour), and prints the fraction of pixels that are the same
colour in both, then SAME when that fraction is at least THRESHOLD, else
DIFFERENT. Two screens in different modes are DIFFERENT.
"""
import sys

THRESHOLD = 0.9


def load(path):
    """The video RAM and the VDP registers of a saved screen."""
    vram = open(path + ".vram", "rb").read()
    regs = [int(x) for x in open(path + ".regs").readline().split()]
    return vram, regs


def mode(regs):
    """The screen mode: text, graphic1, graphic2 or multicolour."""
    m1, m2, m3 = (regs[1] >> 4) & 1, (regs[1] >> 3) & 1, (regs[0] >> 1) & 1
    if m1:
        return "text"
    if m2:
        return "multicolour"
    return "graphic2" if m3 else "graphic1"


def draw(vram, regs):
    """The screen as 192 rows of 256 colour indices."""
    kind = mode(regs)
    border = regs[7] & 15
    img = [[border] * 256 for _ in range(192)]
    name = (regs[2] & 0x0F) * 0x400
    if kind == "text":
        pat = (regs[4] & 7) * 0x800
        fg, bg = regs[7] >> 4, regs[7] & 15
        for row in range(24):
            for col in range(40):
                ch = vram[name + row * 40 + col]
                for y in range(8):
                    bits = vram[pat + ch * 8 + y]
                    for x in range(6):
                        img[row * 8 + y][8 + col * 6 + x] = fg if bits & (0x80 >> x) else bg
        return img
    if kind == "multicolour":
        pat = (regs[4] & 7) * 0x800
        for row in range(24):
            for col in range(32):
                ch = vram[name + row * 32 + col]
                for half in range(2):
                    c = vram[pat + ch * 8 + (row % 4) * 2 + half]
                    for y in range(4):
                        for x in range(8):
                            img[row * 8 + half * 4 + y][col * 8 + x] = c >> 4 if x < 4 else c & 15
        return img
    if kind == "graphic2":
        colours = 0x2000 if regs[3] & 0x80 else 0
        pat = 0x2000 if regs[4] & 4 else 0
    else:
        colours = regs[3] * 0x40
        pat = (regs[4] & 7) * 0x800
    for row in range(24):
        for col in range(32):
            ch = vram[name + row * 32 + col]
            for y in range(8):
                if kind == "graphic2":
                    third = (row // 8) * 0x800
                    bits = vram[pat + third + ch * 8 + y]
                    c = vram[colours + third + ch * 8 + y]
                else:
                    bits = vram[pat + ch * 8 + y]
                    c = vram[colours + ch // 8]
                for x in range(8):
                    img[row * 8 + y][col * 8 + x] = c >> 4 if bits & (0x80 >> x) else c & 15
    return img


def same_fraction(a, b):
    """The fraction of pixels of the same colour in screens a and b, 0 when their modes differ."""
    (va, ra), (vb, rb) = a, b
    if mode(ra) != mode(rb):
        return 0.0
    ia, ib = draw(va, ra), draw(vb, rb)
    same = sum(pa == pb for la, lb in zip(ia, ib) for pa, pb in zip(la, lb))
    return same / (256 * 192)


def main():
    fraction = same_fraction(load(sys.argv[1]), load(sys.argv[2]))
    print(f"{fraction:.3f}\t{'SAME' if fraction >= THRESHOLD else 'DIFFERENT'}")


if __name__ == "__main__":
    main()
