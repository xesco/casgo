# Limits

CASGO loads a tape by giving the game's loader the tape's bytes from RAM, in place
of the cassette routines of the MSX's BIOS. A tape fails when its loader or its game
reaches the tape, or the memory, in a way that CASGO does not cover. This page lists
those kinds of tape, for anyone whose game does not load.

## Tapes that do not load

| Tape | What you see |
|---|---|
| The loader reads the cassette signal itself, not through the BIOS. A CAS file does not hold that signal, so these tapes fail in an emulator's cassette player too | The load stops, or reports a tape error |
| The loader decodes or builds its tape calls in memory as it runs, where CASGO cannot find them | The load hangs |
| The game writes into the first 16 KB of RAM, where CASGO keeps its copy of the BIOS during the load. On an MSX1, CASGO keeps the copy out of the way of most such games | The game crashes |
| The game looks for RAM for the first 16 KB itself and copies its code there, on an MSX2 whose only RAM is the mapper, such as a Philips NMS 8245 or 8250 with no RAM cartridge. An MSX2 with a memory cartridge, a Carnivore2 or a MegaFlashROM SD loads these games | The load stops partway |
| The game's slot code is wrong on machines whose slot 0 is expanded, such as the Panasonic FS-A1WX and FS-A1WSX, the Sony HB-F1XV (MSX2+) and the Sony HB-F700P (MSX2) | The game hangs, as it does when it loads from a real tape on such a machine |
| The game uses a cartridge slot by its number and expects RAM there | The load fails. Put your disk interface in the other slot |
| The game puts a cartridge image in RAM and resets the machine to start it | The machine boots DOS again, or stays on the MSX logo, because the disk interface starts first |
| The CAS file is larger than the free mapper RAM | CASGO stops before the load and says how many 16 KB blocks the file needs and how many are free |

## What CASGO does not do

- Save to tape.
- Load two CAS files in one run. Join them into one file first
  ([Games on two sides](README.md#games-on-two-sides)).
- Choose which file on the tape to start. CASGO starts at the beginning, as a
  rewound tape does.
- Return to DOS. The game ends with a reset, as on a cassette machine.

If you have a CAS file that does not load, open an issue on
[GitHub](https://github.com/xesco/casgo/issues) with the game's name, and I will add
support for it.
