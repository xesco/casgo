# CASGO

CASGO loads a cassette game on a real MSX from a CAS file, which is the usual image
of an MSX tape, on any drive that DOS can read. You start CASGO at the Nextor or
MSX-DOS 2 prompt with the CAS file's name, and the game then loads as it would from
tape, but in seconds. This page tells MSX owners how to run it.

## Requirements

CASGO needs the following.

| Requirement | Note |
|---|---|
| An MSX1 or later with at least 128 KB of mapper RAM, in any slot | A Carnivore2 or a memory cartridge provides it on an MSX1 |
| Nextor 2.1, or MSX-DOS 2 on an MSX2 or later | MSX-DOS 2 does not run on an MSX1 |
| Free mapper RAM for the whole CAS file | 512 KB loads every tape tested |

## Loading a game

Copy [CASGO.COM](CASGO.COM) to your disk, and type `CASGO` and the CAS file's name
at the DOS prompt. CASGO answers on the next line with the loading method it picked
for the tape:

```
A>CASGO GAME.CAS
GAME.CAS: CASGOR /CB
```

You type only the first line. CASGO then switches to BASIC and types the load
command itself.

## Games on two sides

A game that fills both sides of a tape comes as one CAS file for each side, and
CASGO reads one file. You join the sides into one file, in their order on the tape,
with MSX-DOS 2's `CONCAT`:

```
A>CONCAT /B THUNDER.CAS+THUNDERB.CAS THUNDAB.CAS
A>CASGO THUNDAB.CAS
```

## License

CASGO is released under the MIT license. Copyright (c) 2026 Xesco.
