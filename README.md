# CASGO

CASGO loads a cassette game on a real MSX from a CAS file, which is the usual image
of an MSX tape, on any drive that DOS can read. You start CASGO at the Nextor or
MSX-DOS 2 prompt with the CAS file's name, and the game then loads as it would from
tape, but in seconds. This page tells MSX owners how to run it, and two more pages
cover the rest:

- [DESIGN.md](DESIGN.md) explains how CASGO works, for anyone who reads or changes
  its source.
- [LIMITS.md](LIMITS.md) lists the kinds of tape that do not load, and why.

## Requirements

CASGO needs the following.

| Requirement | Note |
|---|---|
| An MSX1 or later with at least 128 KB of mapper RAM, in any slot | A Carnivore2 or a memory cartridge provides it on an MSX1 |
| Nextor 2.1, or MSX-DOS 2 on an MSX2 or later | MSX-DOS 2 does not run on an MSX1 |
| Free mapper RAM for the whole CAS file | 512 KB loads every tape tested |

## Loading a game

Download `CASGO.COM` from the newest release on the
[Releases](https://github.com/xesco/casgo/releases) page, and copy it to your disk.
Then type `CASGO` and the CAS file's name at the DOS prompt. CASGO answers on the
next line with the loading method it picked for the tape:

```
A>CASGO GAME.CAS
GAME.CAS: CASGOR /CB
```

CASGO then switches to BASIC and types the load command itself. CASGO reads the
whole CAS file into RAM before the game starts, so the game reads its tape from RAM
and never calls DOS, which would disturb the game's timing and state and could stop
the game with a disk error.

## Forcing the loading method

CASGO picks the loading method from the CAS file. When a game does not load with
that method, you can force another with an option before the file's name: up to two
loader letters, a memory letter, or both. CASGO picks what the option leaves out:

```
A>CASGO /M GAME.CAS
GAME.CAS: CASGOM /CB
```

| Letters | What they choose |
|---|---|
| `P`, `C`, `N`, `S`, `B` | How the tape's loader reaches the tape |
| `M`, `R`, `I`, `T` | Where the game's memory and CASGO's copy of the BIOS go |

[DESIGN.md](DESIGN.md#loader-cases) describes each letter. On an MSX2 with a RAM
cartridge, a few games load only with `/M`.

## Games on two sides

A game that fills both sides of a tape comes as one CAS file for each side, and
CASGO reads one file. You join the sides into one file, in their order on the tape,
with MSX-DOS 2's `CONCAT`:

```
A>CONCAT /B THUNDER.CAS+THUNDERB.CAS THUNDAB.CAS
A>CASGO THUNDAB.CAS
```

## Trying CASGO in openMSX

You can try CASGO in the openMSX emulator on the machine it is tested on, a Philips
VG-8020 with a Carnivore2 cartridge. The folder [openmsx](openmsx) holds
`casgo.tcl`, a script that starts it. Each release holds `casgo.dsk`, a disk image
with Nextor and that release's `CASGO.COM` ([NEXTOR-LICENSE.md](NEXTOR-LICENSE.md)),
for the script. openMSX needs two ROM files in its system ROMs folder, which this
repository cannot hold:

| ROM | Note |
|---|---|
| The Philips VG-8020's BIOS and BASIC | openMSX's machine `Philips_VG_8020` names it `vg8020_basic-bios1.rom` |
| The Carnivore2's firmware, version 2.40, 2.50 or 2.52 | The versions that openMSX's extension `Carnivore2` accepts |

Then follow these steps:

1. Download `casgo.dsk` from the newest release into the folder `openmsx`.
2. Copy your CAS files into the folder `openmsx`. Give them names of up to 8
   characters before `.CAS`, because a longer name is cut short on the disk.
3. In the folder `openmsx`, start openMSX with the script:

   ```
   openmsx -machine Philips_VG_8020 -ext Carnivore2 -script casgo.tcl
   ```

4. Wait for the `A>` prompt, and type `CASGO GAME.CAS`. `DIR` lists the files on the
   disk.

The script copies `casgo.dsk` to `work.dsk` and adds the CAS files to the copy, so
`casgo.dsk` never changes. It also gets past the Carnivore2's boot menu by starting
the menu's first entry.

## Building

CASGO is written in Z80 assembly, in the folder [src](src). `make` builds
`build/CASGO.COM`, and `make release` also builds `build/casgo.dsk`, the disk image
for openMSX. The build downloads the source of the sjasmplus assembler, pinned by
version and checksum, builds the assembler, and then assembles CASGO. The build
needs make, curl, a C++ compiler and Python 3. [tools/known.tsv](tools/known.tsv)
lists the tapes that CASGO recognises by their blocks, with the loading method each
needs and the bytes it patches in some of them.

## Author and license

I wrote CASGO with Claude, Anthropic's AI, because I wanted a loader that handles
more CAS files than the ones I had used. CASGO is released under the MIT license
([LICENSE](LICENSE)). Copyright (c) 2026 Xesco.
