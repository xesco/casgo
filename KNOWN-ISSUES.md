# Known issues

CASGO was tested on 1,653 cassette tapes in openMSX, on a Philips VG-8020 with a
Carnivore2, and `CASGO GAME.CAS` loads all but 7 of them. The table lists those 7
tapes' games: the games that do not load, and the game that needs an option,
each with the reason.

| Game | Result | Why |
|---|---|---|
| Macadam Bumper (1985, Players Software) | Does not load | Its loader decodes its tape calls in memory as it runs, where CASGO cannot find them |
| La Geste d'Artillac (1985, Infogrames), tape A | Does not load | Its loader decodes its tape calls in memory as it runs, where CASGO cannot find them |
| The Wall, on Super MSX n.7 (1987), side A | Does not load | Its loader puts the MSX1's own RAM in all four 16 KB pages and loads into the first one, where CASGO keeps its copy of the BIOS |
| Head Alignment Kit (1985, Aackosoft) | Starts with `CASGO /BT GAME.CAS` | It is a tool for adjusting a cassette deck, and it reads the cassette signal itself, which a CAS file does not hold |

If you have a CAS file that does not load, open an issue on
[GitHub](https://github.com/xesco/casgo/issues) with the game's name, and I will add
support for it.
