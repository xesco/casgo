# How CASGO works

This page explains how CASGO loads a tape, for anyone who wants to read or change
its source. It gives the idea of each part and names the source file that holds it;
the comments in the source give the details.

## The idea

A cassette game loads through the BIOS's tape routines, which read the cassette's
signal one byte at a time. CASGO reads the whole CAS file into RAM first, and then
puts its own tape routines where the BIOS's are, so that each call gets the next
byte of the file instead. The game's own loader runs unchanged, and so do loaders
that load several parts one after the other. Because the file is in RAM before the
game starts, the game never calls DOS.

## Names

The page and the source use these names for the RAM that CASGO works with. An MSX
sees its 64 KB as four pages of 16 KB, and a memory mapper fills each page with a 16
KB segment of RAM.

| Name | What it is |
|---|---|
| T0 | The segment in page 0 (`0000h`–`3FFFh`) that holds CASGO's copy of the BIOS, with CASGO's tape routines in place of the BIOS's |
| P3 | The segment in page 3 (`C000h`–`FFFFh`), cleaned of the disk system, so that the game finds the page 3 of a machine without disk |
| Data segments | The segments that hold the CAS file, 16,381 bytes in each |

## A load, step by step

CASGO works in three stages, one after the other.

1. **In DOS.** CASGO checks that the BIOS is one it knows, opens the CAS file, and
   reads the whole file into free mapper segments. It changes a few bytes of the
   loaders that need it ([Loader cases](#loader-cases)), then starts BASIC.
2. **In BASIC.** CASGO cleans P3 of the disk system, copies the BIOS into T0 with
   its own tape routines, and puts T0 in page 0. It then types the load command that
   the tape's first file needs, such as `BLOAD"CAS:",R`.
3. **While the game loads.** Each call to the tape routines takes the next bytes
   from the data segments. To read a byte, TAPIN puts the byte's data segment in
   page 0 for two instructions, and every data segment holds those two instructions
   at the same address, so the code goes on in T0 afterwards.

## The detector and the variants

`CASGO.COM` holds a small program, the detector, and four versions of CASGO, the
variants. The detector reads the CAS file, picks the variant and the loader cases
the tape needs, copies that variant over itself and runs it. It prints what it
picked, such as `GAME.CAS: CASGOR /CB`. You can force a pick with an option before
the file's name, such as `CASGO /SM GAME.CAS`.

The detector picks by rules: it looks for byte patterns in the file that tell which
kind of loader the tape has. A few tapes have code that no rule tells apart, and
[tools/known.tsv](tools/known.tsv) lists them, with the cases each needs and the
bytes CASGO patches in some of them.

### Loader cases

A loader case is a kind of loader that reaches the tape in a way the plain BIOS
routines do not catch. Each has a letter.

| Letter | The loader | What CASGO does |
|---|---|---|
| `P` | Reads the tape through the BIOS | Nothing more: CASGO's tape routines answer |
| `C` | Puts the BIOS ROM back in page 0 and calls the tape directly | Points each such call at a table of CASGO's tape entries in page 3 |
| `N` | Builds its tape call at run time, as the Namco titles do | Gives the call the same table |
| `S` | Calls the tape through a small stub it builds in page 3, as many Erbe, Dro and Topo tapes do | Changes the stub so that it puts T0 in page 0 |
| `B` | Puts the ROM back in page 0, then loads its next part with BASIC's `BLOAD` | Puts T0 back in page 0 before each `BLOAD` |

### Memory cases

A memory case says where the game's pages 2 and 3 and T0 are. On a cassette machine,
all RAM is in one slot. Some games search the slots for RAM and take the first they
find, and the memory case keeps T0 out of their way. Each variant is one memory
case.

| Letter | Game's pages 2 and 3 | T0 |
|---|---|---|
| `M` | The mapper | The mapper |
| `R` | An MSX1's own RAM, apart from the mapper | The mapper |
| `I` | An MSX1's own RAM | That RAM's page 0 |
| `T` | The mapper | An MSX1's own RAM's page 0, or on an MSX2, page 0 of a second RAM slot such as the machine's own RAM beside a RAM cartridge |

## The source

The source is Z80 assembly, assembled with sjasmplus. `make` builds the four
variants and the detector.

| File | What it holds |
|---|---|
| `src/casgo.asm` | A variant: stage 1 and stage 2, and the files it includes |
| `src/detect.asm` | The detector |
| `src/scan.asm` | The scan of the CAS file in stage 1, and the patches of the loader cases |
| `src/calls.asm`, `src/namco.asm`, `src/stub.asm`, `src/basic.asm` | The rule and the patch of each loader case |
| `src/patterns.asm` | The byte patterns that the detector's rules and the variants' patches share |
| `src/tape.asm` | The tape routines of stage 3 |
| `src/slots.asm`, `src/t0.asm`, `src/trampolines.asm`, `src/entries.asm` | The code CASGO puts in page 3 for the game: the slot wrappers, the routine that puts T0 in page 0, and the table of tape entries |
| `src/iram.asm`, `src/t0iram.asm` | The memory cases that use a second RAM: the search for it, and T0 in it |
| `tools/known.py`, `tools/known.tsv` | The known tapes, which the build turns into the detector's table and the variants' patches |
