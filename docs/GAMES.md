# Games

This page lists each tape of the test corpus, whether CASGO loads it and the variant
that CASGO picks for it. For a tape that does not load, it gives a code for why and,
where one exists, the command that loads the tape by forcing other cases name. It is
for players looking up a game, and for anyone working on CASGO, who can see which
kinds of tape still fail. The tapes ran in openMSX on a Philips VG-8020 with a
Carnivore2, the machine CASGO is tested on, and `tools/games_table.py` writes this
page from the runs.

## How a tape is judged

Each tape ran with `CASGO`, which picks a variant for it
([README.md](../README.md#loading-a-game)), and the tape loads when that variant
loads it. A run waits until the load is over, then presses space, and then `1`,
which starts many games from their menu. It holds each key down as a person would
and presses it up to three times, because a game that is still setting up misses a
short press. A tape loads when the screen changes during the key presses
(`test/game.tcl`). Many games wait at a menu for a key that is neither space nor
`1`, so a tape whose screen does not change ran in openMSX's own cassette player
too: it loads when CASGO's screen at the end of the load is the same as the cassette
player's, at least 90% of its pixels (`tools/screens.py`). The screen also changes
when a game crashes into other code or resets the machine, so a tape whose
investigation found such a run does not load, and gets the code of its cause. A tape
that did not load ran with the other cases forced too, and the column Run instead
names a command whose screen at the end of the load is the same as the cassette
player's. A number after the letters, as in `CASGOR /P3`, is a known tape's patch,
which changes a few of its bytes as it loads ([DESIGN.md](DESIGN.md#the-detector-and-the-variants)). A
game whose screen depends on chance, such as one that deals its cards at random,
loads when an investigation found it running (`test/true_loads.tsv`). So does a game
that draws its menu slowly, when CASGO's run drew more of the menu than the cassette
player's run did. The corpus holds side A tapes that openMSX's cassette player
loads: a second side needs the first one before it, and a tape whose cassette run
ends in an error or at BASIC's prompt cannot be compared, so both are left out.

## Summary

The table counts the tapes by result.

| Result | Tapes |
|---|---|
| Loads | 1599 |
| Does not load, but CASGO with other cases forced loads it | 2 |
| Does not load with any variant | 5 |
| All | 1606 |

## Codes

A tape that does not load gets one code. The codes A to G say what the run with
`CASGO` showed, and the codes H to X say why, where an investigation found the
cause.

| Code | Meaning | Tapes |
|---|---|---|
| I | Reads the cassette input itself, from the sound chip, where CASGO has no signal: a tool for a real cassette | 2 |
| Q | A stub loader that puts the internal RAM in page 0, where `I` keeps T0, and that the stub's slots cannot take out of page 0 for its tape calls in `R` ([LIMITS.md](LIMITS.md#tapes-that-do-not-load)) | 1 |
| X | The loader builds its tape calls in memory, from code it decodes, where CASGO cannot see them | 4 |

## Games

The table lists the tapes by their file name on File-Hunter. A tape from a pack is
named by the pack and its CAS file, and a tape that File-Hunter does not hold keeps
the name of its CAS file.

| Game | Loads | Variant | Code | Run instead |
|---|---|---|---|---|
| 007 - A View to a Kill (1986)(Domark)[a][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| 007 - A View to a Kill (1986)(Domark)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| 007 - Licence to Kill (1989)(Domark)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| 007 - The Living Daylights (1987)(Domark)[RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| 007 Agente Especial (1985)(Erbe Software)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| 10th Frame (1986)(US Gold)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| 180 (1987)(Mastertronic Added Dimension)[RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| 3D Golf Simulation - High Speed Edition (1984)(T&E Soft)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| 4x4 Off-Road Racing (1988)(US Gold)(Side A)[a][BLOAD'CAS-',R] | Yes | `CASGOI /S` |  |  |
| 4x4 Off-Road Racing (1988)(US Gold)(Side A)[BLOAD'CAS-',R] | Yes | `CASGOI /S` |  |  |
| 7 Card Stud (1986)(Martech Games)[a][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| 7 Card Stud (1986)(Martech Games)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| 737 Flight Simulator (1984)(Mirrorsoft)[a][BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| 737 Flight Simulator (1984)(Mirrorsoft)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| 747 400b Flight Simulator (1988)(Eurosoft)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| A-TEAM (1988)(Zafiro)[CLOAD + RUN] | Yes | `CASGOR /B` |  |  |
| Aaargh! (1989)(Dro Soft)(es)[a][RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Aaargh! (1989)(Dro Soft)(es)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Aackobase II (1985)(Aackosoft)(nl)[a][RUN'CAS-'] | Yes | `CASGOR /P16` |  |  |
| Aackobase II (1985)(Aackosoft)(nl)[RUN'CAS-'] | Yes | `CASGOR /P17` |  |  |
| Aackodraw & Paint (1985)(Aackosoft)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Abadia del Crimen, La (1988)(Opera Soft)(es)[BLOAD'CAS-',R] | Yes | `CASGOR /C` |  |  |
| Abeja Sabia 2, La (1986)(Anaya Multimedia)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Abeja Sabia 3, La (1986)(Anaya Multimedia)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Abracadabra (1988)(Proein Soft Line)(es)(Side A)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Abu Simbel Profanation (1986)(Dinamic Software)(es)[a2][BLOAD'CAS-',R] | Yes | `CASGOI /CB` |  |  |
| Abu Simbel Profanation (1986)(Dinamic Software)(es)[a][BLOAD'CAS-',R] | Yes | `CASGOI /CB` |  |  |
| Abu Simbel Profanation (1986)(Dinamic Software)(es)[BLOAD'CAS-',R] | Yes | `CASGOI /CB` |  |  |
| Abu Simbel Profanation (1986)(Dinamic Software)(es)[RUN'CAS-'] | Yes | `CASGOI /CB` |  |  |
| Ace of Aces (1986)(US Gold)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Addictaball (1988)(Alligata Software)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Addictaball (1988)(Alligata)(GB)[RUN'CAS-']-FX3 | Yes | `CASGOR /CB` |  |  |
| Addictaball (1988)(Alligata)(GB)[RUN'CAS-']-FX3-Cursores | Yes | `CASGOR /CB` |  |  |
| Adel (1986)(Mind Games Espana)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Adventure Quest - Text Only (1983)(Level 9 Computing)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Aerial (2021)(Inufuto) | Yes | `CASGOR` |  |  |
| African Trail Simulator (1990)(Positive)(es)[RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| After the War (1989)(Dinamic Software)(es)(Side A)[RUN'CAS-'] | Yes | `CASGOT /B` |  |  |
| Afterburner (1988)(Activision)(Side A)[BLOAD'CAS-',R] | Yes | `CASGOR /N` |  |  |
| Afteroids (1988)(Zigurat Software)(es)[a][RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Afteroids (1988)(Zigurat Software)(es)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Akalabeth (1980)(California Pacific) | Yes | `CASGOR` |  |  |
| Akarui Nouen (1983) (Hudson Soft)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Akujo Legend (1986)(Dream Soft)(jp)[CLOAD+RUN] | Yes | `CASGOR` |  |  |
| Ale Hop! (1988)(Topo Soft)(es)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Alfamat (1985)(Anaya Multimedia)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Alice's Adventure in Wonderland (1984)(MicroCabin)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Alien 8 (1985)(Ultimate Play The Game)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Alien 8 Remake (2008) [BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Alien Attack (2020) (Marcos Daniel Blanco) [1.03] [BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Alien Sunday... (1986)(Soft Studio WING)(Side A) | Yes | `CASGOR` |  |  |
| Alien Syndrome (1988)(Dro Soft)(es)(Side A)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Aliens (1987)(Mr. Micro)[BLOAD'CAS-',R] | Yes | `CASGOR /N` |  |  |
| Almanaque (1986)(Load 'n' Run)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Alpha Blaster (1984)(Aackosoft)[a2][RUN'CAS-'] | Yes | `CASGOI /CB` |  |  |
| Alpha Blaster (1984)(Aackosoft)[a][RUN'CAS-'] | Yes | `CASGOI /CB` |  |  |
| Alpha Blaster (1984)(Aackosoft)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Alpha Blaster (1987)(Eaglesoft)[a][RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Alpha Blaster (1987)(Eaglesoft)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Altered Beast (1988)(Activision)(Side A)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Amaurote (1987)(Mastertronic Added Dimension)[RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| American Truck - Hi-Speed Scroll Action (1985)(Telenet Japan)(Japan)[CLOAD-RUN] | Yes | `CASGOI` |  |  |
| Amoto's Puf (1988)(SPE)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| An Adventure Of The Blue Universe (1985)(Leben Pro IO)(ja)[Side A][CLOAD+RUN] | Yes | `CASGOR` |  |  |
| Ananas (1989)(Eurosoft)[aka Pine Applin][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Andrea Petkovic Tennis [En] (2017)[BLOAD'CAS-',R] | Yes | `CASGOI /C` |  |  |
| Andrea Petkovic Tennis [Es] (2017)[BLOAD'CAS-',R] | Yes | `CASGOI /C` |  |  |
| Anexo 01, El Algoritmo [En] (2018) [BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Anexo 01, El Algoritmo [Es] (2018) [BLOAD'CAS-',R] | Yes | `CASGOI /C` |  |  |
| Anexo 01, El Algoritmo [Es][v1.2] (2018) [BLOAD'CAS-',R] | Yes | `CASGOI /C` |  |  |
| Angel Nieto Pole 500cc (1990)(Opera Soft)(es)[BLOAD'CAS-',R] | Yes | `CASGOR /C` |  |  |
| Angleball (1987)(Mastertronic Added Dimension)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Antarctic Adventure (Microbyte) (Argentina) [RUN'CAS-'] [\_] | Yes | `CASGOI /B` |  |  |
| Antarctic Adventure (Pinguin) (Italy) [BLOAD'CAS-',R] [\_] | Yes | `CASGOI /B` |  |  |
| Antarctic Adventure (Pinguin) (Italy) [BLOAD'CAS-',R] [A] | Yes | `CASGOI /S` |  |  |
| Antarctic Adventure-eu[BLOAD'CAS-',r] | Yes | `CASGOR` |  |  |
| Antarctica (1983) (Pony Canyon) [cload''NA''] | Yes | `CASGOR` |  |  |
| AntiAir (2024)(inufuto) | Yes | `CASGOR` |  |  |
| Any Treasure Day (2018) (Timmy) [BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Arithmetic, Mathematics and English for Elementary and Junior High School Students, 2 Volumes, Learning Software (198x)(Soft & Soft)[CLOAD'ENG-1'],R | Yes | `CASGOR` |  |  |
| Arithmetic, Mathematics and English for Elementary and Junior High School Students, 2 Volumes, Learning Software (198x)(Soft & Soft)[CLOAD'ENG-2'],R | Yes | `CASGOR` |  |  |
| Arithmetic, Mathematics and English for Elementary and Junior High School Students, 2 Volumes, Learning Software (198x)(Soft & Soft)[CLOAD'MAT-1'],R | Yes | `CASGOR` |  |  |
| Arithmetic, Mathematics and English for Elementary and Junior High School Students, 2 Volumes, Learning Software (198x)(Soft & Soft)[CLOAD'MAT-2'],R | Yes | `CASGOR` |  |  |
| Aritmo (1985)(DIMensionNEW)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Arkanoid (1986)(Taito)[RUN'CAS-'] | Yes | `CASGOI /CB` |  |  |
| Arkanoid (Imagine) [BLOAD'CAS-',R] [\_] | Yes | `CASGOI /C` |  |  |
| Arkos I (1988)(Zigurat Software)(es)[RUN'CAS-'] | Yes | `CASGOR /B` |  |  |
| Arkos II (1988)(Zigurat Software)(es)[RUN'CAS-'] | Yes | `CASGOR /B` |  |  |
| Arkos III (1988)(Zigurat Software)(es)[RUN'CAS-'] | Yes | `CASGOR /B` |  |  |
| Army Moves (1987)(Dinamic Software)(es)(Side A)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Army Moves (1987)(Imagine Software)(Side A)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Arquimedes XXI (1986)(Dinamic Software)(es)[BLOAD'CAS-',R] | Yes | `CASGOT /B` |  |  |
| Arquimedes XXI (1986)(Dinamic Software)(es)[RUN'CAS-'] | Yes | `CASGOT /B` |  |  |
| Aspar GP Master (1988)(Dinamic Software)(es)[a2][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Aspar GP Master (1988)(Dinamic Software)(es)[a][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Aspar GP Master (1988)(Dinamic Software)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Aspar GP Master (1989)(Dinamic Software)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Astro Blaster (1988)(Eurosoft)[a2][RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Astro Blaster (1988)(Eurosoft)[a][RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Astro Blaster (1988)(Eurosoft)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Astro Marine Corps (1989)(Dinamic Software)(es)(Side A)[a][RUN'CAS-'] | Yes | `CASGOT /B` |  |  |
| Astro Marine Corps (1989)(Dinamic Software)(es)(Side A)[RUN'CAS-'] | Yes | `CASGOT /B` |  |  |
| Astronauta (1986)(Load 'n' Run)(es)[aka Space Walk][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Attacked (19xx)(Tynesoft)[RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Attacked (Tynesoft) | Yes | `CASGOI /B` |  |  |
| Auf Wiedersehen Monty (1987)(Gremlin Graphics Software)[BLOAD'CAS-',R] | Yes | `CASGOI /S` |  |  |
| Avenger (1986)(Erbe Software)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Avenger (1986)(Gremlin Graphics Software)[BLOAD'CAS-',R] | Yes | `CASGOI /S` |  |  |
| Aventura Espacial, La (1990)(Aventuras AD)(es)(Side A)[RUN'CAS-'] | Yes | `CASGOI /CB` |  |  |
| Aventura Original, La (1989)(Aventuras AD)(es)(Side A)[RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| Averno (1989)(Proein Soft Line)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Awass (2026)(inufuto) | Yes | `CASGOR` |  |  |
| Babbulkund (Bubblekund) 1999 (1984)(Softbank)(ja) | Yes | `CASGOR` |  |  |
| Bakerman (2023)(AG Software)[RUN'CAS-'][b] | Yes | `CASGOI /B` |  |  |
| Bang! Bang! (1985)(Ample, Mel Software)(JP)(en)[!][BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Bang! Bang! (1985)(Ample, Mel Software)(JP)(en)[GDX Fixed][BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Barbarian (1988)(Mastertronic)(es)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Barbarian II - The Dungeon of Drax (1988)(Erbe Software)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Barn Stormer (1985)(Electric Software)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Base de Datos (1985)(DIMensionNEW)(es)[RUN'CAS-'] | Yes | `CASGOI` |  |  |
| Base de Datos (19xx)(Toshiba)(es)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| BASICODE-3(1987)(NOS)(NL) | Yes | `CASGOI` |  |  |
| Batalla Espacial (19xx)(Grupo de Trabajo Software)(es)[aka Valkyr][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Batman (1986)(Erbe Software)[RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Batman (1986)(Ocean Software)[a][RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Batman (1986)(Ocean Software)[RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Batman - The Movie (1989)(Ocean Software)(Side A)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Battle Chopper (1985)(Methodic Solutions)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Battle Mecha Xabungle Blue Gale Part 1 (1985) (Pony Canyon)[CLOAD + RUN) | Yes | `CASGOR` |  |  |
| Battleship Clapton II (1983)(T&E Soft)[BLOAD'CAS'-',R] | Yes | `CASGOR` |  |  |
| Battlot (2021)(Inufuto) | Yes | `CASGOR` |  |  |
| BC's Quest for Tires II - Grog's Revenge (1985)(US Gold)[a][RUN'CAS-'] | Yes | `CASGOM /B` |  |  |
| BC's Quest for Tires II - Grog's Revenge (1985)(US Gold)[RUN'CAS-'] | Yes | `CASGOM /B` |  |  |
| BC's Quest for Tires II - Grog's Revenge (1987)(Eaglesoft)[RUN'CAS-'] | Yes | `CASGOI /CB` |  |  |
| BCs Quest For Tyres [BLOAD'CAS-',r] | Yes | `CASGOR` |  |  |
| Beach-Head (1985)(US Gold)[RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Beamrider (1984)(Activision)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Bear George (1985)(Soft Bee)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Berlin (1985)(Omega System)[CLOAD+RUN] | Yes | `CASGOR` |  |  |
| Bestial Warrior (1989)(Dinamic Software)(es)[a][RUN'CAS-'] | Yes | `CASGOR /B11` |  |  |
| Bestial Warrior (1989)(Dinamic Software)(es)[RUN'CAS-'] | Yes | `CASGOR /B10` |  |  |
| Binary Land (HoneyBee Soft) (Hudson Soft) (Japan) [BLOAD'CAS-',R] [\_] | Yes | `CASGOR` |  |  |
| Biotech (1983) (Hudson Soft)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Birds And Chairs (2017) [BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Bit Byter (19xx)(Spectravideo)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Black Bass, The (1986)(Hot-B)(ja)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Blackbeard (1988)(Topo Soft)(es)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Blackjack (1985)(DIMensionNEW)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Blagger Enhanced [BLOAD'CAS',R] | Yes | `CASGOR` |  |  |
| Blagger Enhanced [Bload'CAS-',r] | Yes | `CASGOR` |  |  |
| Blasteroids (1987)(Image Works)[BLOAD'CAS-',R] | Yes | `CASGOI /S` |  |  |
| Blitz Krieg (1985)(Omega System) | Yes | `CASGOR` |  |  |
| Blocker (19xx)(Grupo de Trabajo Software)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Bloody (1987)(P.J. Software)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Blow Up (1988)(Eurosoft)[a][RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Blow Up (1988)(Eurosoft)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| BMX Simulator (1987)(Codemasters)[RUN'CAS-'] | Yes | `CASGOT /B9` |  |  |
| Boardello (1985)(Bubblebus Software)[a][RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Boardello (1985)(Bubblebus Software)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Bob 007 - Infiltrado (1986)(Grupo de Trabajo Software)(es)[a][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Bob 007 - Infiltrado (1986)(Grupo de Trabajo Software)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Bomberman [BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Booga-Boo the Flea (1986)(Quicksilva)[a][BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Booga-Boo the Flea (1986)(Quicksilva)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Boom (1986)(Aackosoft)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Boom (1988)(Eurosoft)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Boom! - MSX Compilation 4 (ByteBusters) (Aackosoft - Eaglesoft) [RUN'CAS-'] [\_] | Yes | `CASGOR /CB` |  |  |
| Bootskell (2021)(Inufuto) | Yes | `CASGOR` |  |  |
| Booty (1988)(Eurosoft)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Bop! (1986)(Bug-Byte Software)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Boulder Dash (1985)(Databyte)[a][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Boulder Dash (1985)(Databyte)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Boulder Dash II - Rockford's Revenge (First Star) (Databyte) / Boulder Dash II - Rockford's Revenge (First Star) (Databyte) (Side A) [RUN'CAS-'] [\_].cas | Yes | `CASGOR` |  |  |
| Boulder Dash II - Rockford's Revenge (First Star) (Databyte) [RUN'CAS-'] [\_] | Yes | `CASGOR` |  |  |
| Boulder Dash II - Rockford's Riot (1986)(Databyte)[a][RUN'CAS-'] | Yes | `CASGOI /CB` |  |  |
| Boulder Dash II - Rockford's Riot (1986)(Databyte)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Bounce (1987)(Methodic Solutions)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Bound Rescue (1984)(Shouji Ogawa) | Yes | `CASGOR` |  |  |
| Bounder (1987)(Gremlin Graphics Software)[a][BLOAD'CAS-',R] | Yes | `CASGOI /S` |  |  |
| Bounder (1987)(Gremlin Graphics Software)[BLOAD'CAS-',R] | Yes | `CASGOI /S` |  |  |
| Break In (1987)(Eaglesoft)[a][RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Break In (1987)(Eaglesoft)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Break Out! (1985)(Toshiba-EMI)[a2][needs 64k in slot 2][RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Break Out! (1985)(Toshiba-EMI)[a][needs 64k in slot 2][RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Break Out! (1985)(Toshiba-EMI)[needs 64k in slot 2][RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| BreakBomb (2021)(Gamecast) | Yes | `CASGOR` |  |  |
| Breaker Breaker (1988)(Eurosoft)[a][RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Breaker Breaker (1988)(Eurosoft)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Breakout(1985)(Toshiba)[RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Brian Jacks Superstar Challenge (1985)(Martech Games)(Side A)[a][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Brian Jacks Superstar Challenge (1985)(Martech Games)(Side A)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| British Bob [BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Bronx (1989)(Animagic)(es)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Bruce Lee (1985)(Comptiq)[RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Bubbler (1987)(Ultimate Play The Game)[BLOAD'CAS-',R] | Yes | `CASGOT /C` |  |  |
| Bubbo World 2 [RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Bubbo World [RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Buck Rogers - Planet of Zoom (1983)(Sega)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Buddhagillie (2018) (GW's Workshop) [BLOAD'CAS-',r] | Yes | `CASGOR` |  |  |
| Budokan (1991)(Dro Soft)(Side A)[RUN'CAS-'] | Yes | `CASGOT /S` |  |  |
| Buggy Ranger (1990)(Dinamic Software)(es)[RUN'CAS-'] | Yes | `CASGOT /B` |  |  |
| Bumper Ship Racing (2018) (Uninteresting) [BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Bumpy (1989)(Loriciels)[a][RUN'CAS-'] | Yes | `CASGOT /B` |  |  |
| Bumpy (1989)(Loriciels)[b][RUN'CAS-'] | Yes | `CASGOT /B` |  |  |
| Bumpy (19xx)(Grupo de Trabajo Software)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Burn Us (2018) (Carambalan Studios)[Bload'CAS-',R | Yes | `CASGOR /B` |  |  |
| Buster Block (1985)(Kuma Computers)[RUN'CAS-'] | Yes | `CASGOM /B` |  |  |
| Busy Rainy Day (1983)(Hudson Soft)[BLOAD'CAS',r] | Yes | `CASGOR` |  |  |
| Buzz Off! (1984)(Electric Software)[a][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Buzz Off! (1984)(Electric Software)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Buzz Off! (1984)(Electric Software)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Bytebusters (1984)(Aackosoft)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Cacorm (2022)(Inufuto) | Yes | `CASGOR` |  |  |
| Calculator New (1985)(DIMensionNEW)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Caldero Magico, El (1986)(Grupo de Trabajo Software)(es)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| California Games (1987)(US Gold)(Side A)[RUN'CAS-'] | Yes | `CASGOR /N` |  |  |
| Camelot Warriors (1986)(Dinamic Software)(es)[a][BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Camelot Warriors (1986)(Dinamic Software)(es)[BLOAD'CAS-',R] | Yes | `CASGOI /C` |  |  |
| Camelot Warriors (1986)(Dinamic Software)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Can of Worms (1986)(LiveWire Software)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Cannon Ball (1983)(Hudson Soft) | Yes | `CASGOR` |  |  |
| Cannon Fighter (1984) (Moorwood Software)[BLOAD'CAS-',R] | Yes | `CASGOI` |  |  |
| Capitan Sevilla (1988)(Dinamic Software)(es)(Side A)[RUN'CAS-'] | Yes | `CASGOR /B` |  |  |
| Capitan Sevilla (1988)(Dinamic Software)(Side A)[RUN'CAS-'] | Yes | `CASGOR /B` |  |  |
| Capitan Trueno (1989)(Dinamic Software)(es)(Side A)[RUN'CAS-'] | Yes | `CASGOM /B` |  |  |
| Carlos Sainz (1990)(Zigurat Software)(es)[RUN'CAS-'] | Yes | `CASGOR /B` |  |  |
| Casanova (1989)(Iber Soft)(es)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Castle Combat (1985)(Spectravideo)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Catle Tomb (2023)(Gamecast Entertainment) | Yes | `CASGOI /B` |  |  |
| Cave Adventure (Chitai Tanken)(1984)(Ample Software) | Yes | `CASGOR` |  |  |
| Cavern of Death (1987)(Dro Soft)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Caverns Of Titan 2[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Caverns Of Titan [BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Cavit (2021)(Inufuto) | Yes | `CASGOR` |  |  |
| Caza (1986)(Load 'n' Run)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Cetus (1986)(Tynesoft)[CLOAD+RUN] | Yes | `CASGOR` |  |  |
| Chack 'n Pop (1984)(Taito)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Champ (1984)(PSS)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Champions Grand National (1984)(Pony Canyon)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Chase H.Q. (1988)(Ocean Software)(Side A)[b][RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Chase H.Q. (1988)(Ocean Software)(Side A)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Checkmate! First Moves in Chess (1985)(Toshiba-EMI)[a2][needs 64k in slot 2][RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Checkmate! First Moves in Chess (1985)(Toshiba-EMI)[a][needs 64k in slot 2][RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Checkmate! First Moves in Chess (1985)(Toshiba-EMI)[needs 64k in slot 2][RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Checkmate!(1985)(Toshiba)[RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Chess Game, The (1985)(Eaglesoft) | Yes | `CASGOR` |  |  |
| Chicago 30's (1988)(Topo Soft)(es)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Chicken Chase (1986)(Bug-Byte Software)[RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Chiemi Hori Strawberry Puzzle (1984)(Pony Canyon)(ja)[b] | Yes | `CASGOR` |  |  |
| Chiller (1985)(Mastertronic)[a2][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Chiller (1985)(Mastertronic)[a3][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Chiller (1985)(Mastertronic)[a4][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Chiller (1985)(Mastertronic)[a5][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Chiller (1985)(Mastertronic)[a][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Chiller (1985)(Mastertronic)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Chopper (1986)(Eaglesoft)[a][RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Chopper (1986)(Eaglesoft)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Chopper One (1988)(Eurosoft)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Choro Q (1984)(Taito)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Choy-Lee-Fut Kung-Fu Warrior (1990)(Positive)(es)[RUN'CAS-'] | Yes | `CASGOT /B` |  |  |
| Chubby Gristle (1987)(Grandslam Entertainment) | Yes | `CASGOI /S` |  |  |
| Chuck Yeager's Advanced Flight Trainer (1989)(Dro Soft)[RUN'CAS-'] | Yes | `CASGOI /S7` |  |  |
| Chuckie Egg (1984)(A & F Software)[a2][BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Chuckie Egg (1984)(A & F Software)[a3][BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Chuckie Egg (1984)(A & F Software)[a][BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Chuckie Egg (1984)(A & F Software)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Chuckie Egg (1984)(A & F Software)[PSG & Memory Fixed] | Yes | `CASGOR` |  |  |
| Chuckie Egg (1985)(Aackosoft)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Ci-U-Than Trilogy I - La Diosa de Cozumel (1990)(Aventuras AD)(es)(Side A)[a][RUN'CAS-'] | Yes | `CASGOI /CB` |  |  |
| Ci-U-Than Trilogy I - La Diosa de Cozumel (1990)(Aventuras AD)(es)(Side A)[RUN'CAS-'] | Yes | `CASGOI /CB` |  |  |
| Ci-U-Than Trilogy II - Los Templos Sagrados (1991)(Aventuras AD)(es)(Side A)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Ci-U-Than Trilogy III - Chichen Itza (1992)(Aventuras AD)(es)(Side A)[RUN'CAS-'] | Yes | `CASGOI /CB` |  |  |
| Cid, El (1987)(Dro Soft)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| City Connection (1986)(Jaleco)[RUN'CAS-'] | Yes | `CASGOI /CB` |  |  |
| City Connection (1987)(Eaglesoft)[RUN'CAS-'] | Yes | `CASGOI /CB` |  |  |
| Cobra's Arc (1986)(Dinamic Software)(es)[RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Coliseum (1988)(Topo Soft)(es)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Colony (1987)(Bulldog)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Colossal Adventure  - B-Version - Text Only (1984)(Level 9 Computing)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Colossal Adventure - Text Only (1984)(Level 9 Computing)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Colossus 4 Chess (1986)(CDS Microsystems)[BLOAD'CAS-',R] | Yes | `CASGOI /S` |  |  |
| Colt 36 (1987)(Topo Soft)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Comando Quatro (1989)(Zigurat Software)(es)[RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Comando Tracer (1989)(Dinamic Software)(es)[a][RUN'CAS-'] | Yes | `CASGOM /B` |  |  |
| Comando Tracer (1989)(Dinamic Software)(es)[b][RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Comando Tracer (1989)(Dinamic Software)(es)[RUN'CAS-'] | Yes | `CASGOM /B` |  |  |
| Comecocos (19xx)(Idealogic)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Cometa Halley (1985)(Sony)(es)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Compra y Vende (1985)(Idealogic)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Computadora Adivina (1985)(Sony)(es)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Computer Fan Tan (1985)(Login Soft)[CLOAD+RUN] | Yes | `CASGOR` |  |  |
| Confused (1986)(Eaglesoft)[a][RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Confused (1986)(Eaglesoft)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Congo (1986)(LiveWire Software)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Congo Bongo (1983)(Sega)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Contabilidad (1985)(Sony)(es)[CLOAD + RUN] | Yes | `CASGOI /CB` |  |  |
| Contabilidad Domestica (1985)(DIMensionNEW)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Contabilidad I (19xx)(Mind Games Espana)(es)[a][CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Contabilidad I (19xx)(Mind Games Espana)(es)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Continental Circus (1989)(Virgin Mastertronic)(Side A)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Contract Bridge (1984)(Alligata Software)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Corsarios (1989)(Opera Soft)(es)(Side A)[BLOAD'CAS-',R] | Yes | `CASGOR /C` |  |  |
| Cosa Nostra (1986)(Opera Soft)(es)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Cosmic Sheriff (1989)(Dinamic Software)(es)[RUN'CAS-'] | Yes | `CASGOT /B` |  |  |
| Cosmic Shock Absorber (1986)(Martech Games)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Cosmix Shock Absorber (1987)(Martech Games) | Yes | `CASGOR` |  |  |
| Cosmo Traveler (1983)(Colpax)[Side A][BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Cosmos (1985)(Sony)(es)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Cracky (2023)(Inufuto) | Yes | `CASGOR` |  |  |
| Crash Together - Butsukekko (1983)(Central Education) | Yes | `CASGOR` |  |  |
| Crazy Cars [BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Crazy Golf (1984)(Mr. Micro)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Cross Chase (2018) (Fabrizio Caruso) [BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Crusader (1987)(Eaglesoft)[a][RUN'CAS-'] | Yes | `CASGOI /CB` |  |  |
| Crusader (1987)(Eaglesoft)[RUN'CAS-'] | Yes | `CASGOI /CB` |  |  |
| Cryptic Cube (Spectravideo) [\_] [CLOAD-RUN] | Yes | `CASGOR` |  |  |
| Cubik. Cubo de Rubik (1985)(Monser)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Cubit (1986)(Mr. Micro)[a][BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Cubit (1986)(Mr. Micro)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Curro Jimenez (1989)(Zigurat Software)(es)[RUN'CAS-'] | Yes | `CASGOR /B` |  |  |
| Curso de BASIC (1985)(Sony)(es)(Side A)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Cyberbig (1989)(Animagic)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Cyberun (1985)(Ultimate Play The Game)[BLOAD'CAS-',R] | Yes | `CASGOT /C` |  |  |
| D-Day (1984)(Jaleco) | Yes | `CASGOI /CB` |  |  |
| Daidasso. Great Escape (1985)(Carry Lab)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Dam Busters, The (1985)(Erbe Software)[RUN'CAS-'] | Yes | `CASGOT /B` |  |  |
| Dam Busters, The[RUN'-CAS'] | Yes | `CASGOT /B` |  |  |
| Damas (1985)(DIMensionNEW)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Darkwood Manor (19xx)(Kuma Computers)[a][CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Darkwood Manor (19xx)(Kuma Computers)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Databa (19xx)(Philips)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Datilografia (1986)(Sysout) | Yes | `CASGOR` |  |  |
| Dawn Patrol (1987)(Eaglesoft)(NL)[RUN'CAS-'][Martos] | Yes | `CASGOR /CB` |  |  |
| Death Valley Gold Rush (1985)(Kuma Computers)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Death Wish 3 (1987)(Gremlin Graphics Software)[BLOAD'CAS-',R] | Yes | `CASGOI /S` |  |  |
| Decathlon (1984)(Activision)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Deep Core Raider (P. Jenkinson) [BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Defcom 1 (1989)(Iber Soft)(Side A)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Demand (1984)(Login Soft) | Yes | `CASGOI` |  |  |
| Demand (1985)(Login Soft)[CLOAD+RUN] | Yes | `CASGOR` |  |  |
| Demo, De (1985)(Philips)(nl)[position tape + RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Demo, De - Adres Boek (1985)(Philips)(nl)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Demo, De - Hexapion (1985)(Philips)(nl)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Demo, De - Lanceer (1985)(Philips)(nl)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Demo, De - Nederland (1985)(Philips)(nl)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Demonia (1986)(Microids)(fr)[RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Desolator (1986)(Gremlin Graphics Software)[a][BLOAD'CAS-',R] | Yes | `CASGOT /S` |  |  |
| Desolator (1986)(Gremlin Graphics Software)[BLOAD'CAS-',R] | Yes | `CASGOT /S` |  |  |
| Desperado (1987)(Topo Soft)(es)(Side A)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Desperado 2 (1991)(Topo Soft)(es)[a][RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Desperado 2 (1991)(Topo Soft)(es)[RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Destroyer (1986)(Mind Games Espana)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Deus Ex Machina (1985)(Mind Games Espana)(es)(Side A)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Dezeni Land (1984)(Hudson Soft)(ja)(Side A)[position tape + BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Dial Number (1985)(Nippon Columbia) | Yes | `CASGOR` |  |  |
| Dial Number (1985)(Nippon Columbia)[PSG Port fix by GDX] | Yes | `CASGOR` |  |  |
| Diamond Adventure (1983)(MicroCabin)(JP)[!][CLOAD+RUN] | Yes | `CASGOR` |  |  |
| Dieet (1986)(Philips)(nl)(Side A)[a][BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Dieet (1986)(Philips)(nl)(Side A)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Dig Dug (1984)(Bug-Byte Software)[BLOAD'CAS-',R] | Yes | `CASGOR /N` |  |  |
| Dim-Calc (1985)(DIMensionNEW)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Dimensional Wars (1984)(SoftBank) | Yes | `CASGOI /C` |  |  |
| Disc Warrior (1984)(Alligata Software)[a][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Disc Warrior (1984)(Alligata Software)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Disc Warrior (1984)(Micro Cabin)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Discovery (1988)(Eurosoft)[a2][RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Discovery (1988)(Eurosoft)[a][RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Discovery (1988)(Eurosoft)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Disenador de Graficos (1985)(Advance)(es)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Dizzy Ball (1984)(Pony Canyon) | Yes | `CASGOR` |  |  |
| Dizzy Balloon (1985)(Pony Canyon & Philips Spain)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Dizzy Dice (1988)(Players Software)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Dog Fighter (1986)(Kuma Computers)[a][BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Dog Fighter (1986)(Kuma Computers)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Doki Doki Penguinland (1985)(Sega)(Bitgame Release)[BLOAD'CAS-',R] | Yes | `CASGOI /B` |  |  |
| Domino (1985)(DIMensionNEW)(es)[a][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Domino (1985)(DIMensionNEW)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Don Quijote (1987)(Dinamic Software)(es)(Side A)[RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Donkey Kong (1986)(Erbe Software)[RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Donkey Kong (1986)(Ocean Software)[a][RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Donkey Kong (1986)(Ocean Software)[RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Donpan (1983)(Tomy) | Yes | `CASGOR` |  |  |
| Doopm Community [BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Double Dragon (1988)(Dro Soft)(es)(Side A)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Double Dragon II - The Revenge (1990)(Dro Soft)(es)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Dr. Jackle and Mr. Wide (1987)(Bulldog)[a][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Dr. Jackle and Mr. Wide (1987)(Bulldog)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Draconic Throne (2017) (GW's Workshop) (1.02) [BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Dracula (1986)(Grupo de Trabajo Software)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Dragon Ninja (1988)(Imagine Software)(Side A)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Dragon Ninja (1988)(Imagine Software)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Dragon Slayer (1985)(Square)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Drazen Petrovic Basket (1989)(Topo Soft)(es)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Driller Tanks (1984)(Hudson Soft) | Yes | `CASGOR` |  |  |
| Drome (1987)(Eaglesoft)[a2][RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Drome (1987)(Eaglesoft)[a3][RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Drome (1987)(Eaglesoft)[a][RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Drome (1987)(Eaglesoft)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Dungeon Adventure - Text Only (1984)(Level 9 Computing)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Dustin (1987)(Dinamic Software)(es)[RUN'CAS-'] | Yes | `CASGOM /B` |  |  |
| Dynamite Dan (1986)(Mirrorsoft)[BLOAD'CAS-',R] | Yes | `CASGOI /N` |  |  |
| Eagle (1987)(Juliet Software) | Yes | `CASGOR` |  |  |
| Echec (1985)(Loriciels)(en)[Side A - Library)[Fixed & Translated by GDX, MSX1 Only][RUN'CAS-',r] | Yes | `CASGOI /B` |  |  |
| Echec (1985)(Loriciels)(fr)[Side A - Bibliotheque)[Fixed by  GDX, MSX1 Only][RUN'CAS-',r] | Yes | `CASGOI /B` |  |  |
| Echec (1985)(Loriciels)[Side A)[RUN'CAS-',r] | Yes | `CASGOI /B` |  |  |
| Eddie Kidd Jump Challenge (1985)(Martech Games)[a][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Eddie Kidd Jump Challenge (1985)(Martech Games)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Eddy - Animation Editor (1984)(Hal Laboratory) | Yes | `CASGOR` |  |  |
| Eggerland Mystery (Microbyte) (Argentina) [RUN'CAS-'] [\_] | Yes | `CASGOR /B` |  |  |
| Elevator Action (1985)(TAITO)[RUN'CAS'] | Yes | `CASGOR /B` |  |  |
| Elidon (1986)(Aackosoft)[a2][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Elidon (1986)(Aackosoft)[a][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Elidon (1986)(Aackosoft)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Emerald Isle (1985)(Level 9 Computing)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Emilio Butragueno Futbol (1988)(Topo Soft - Ocean Software)(es)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Emilio Butragueno Futbol II (1989)(Erbe Software - Ocean Software)(es)(Side A)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Emilio Sanchez Vicario Grand Slam (1989)(Zigurat Software)(es)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Enchanted (1989)(Positive)(es)[RUN'CAS-'] | Yes | `CASGOR /B` |  |  |
| Engesoft msxf-07 / Engesoft MSXF-07 - Lado A.cas | Yes | `CASGOI /B` |  |  |
| Engesoft msxf-07 / Engesoft MSXF-07 - Lado B.cas | Yes | `CASGOI /CB` |  |  |
| Engesoft msxf-18 / Engesoft MSXF-18- Lado A.cas | Yes | `CASGOI /B` |  |  |
| Engesoft msxf-18 / Engesoft MSXF-18- Lado B.cas | Yes | `CASGOI /B` |  |  |
| Engesoft msxf-19 / Engesoft MSXF-19 - Lado A.cas | Yes | `CASGOR` |  |  |
| Engesoft msxf-19 / Engesoft MSXF-19 - Lado B.cas | Yes | `CASGOR` |  |  |
| Engesoft msxk-06 / Engesoft MSXK-06 - Lado A.cas | Yes | `CASGOI /B` |  |  |
| Engesoft msxk-06 / Engesoft MSXK-06 - Lado B.cas | Yes | `CASGOI /B12` |  |  |
| Engesoft msxk-13 / Engesoft MSXK-13 - Lado A.cas | Yes | `CASGOI /B` |  |  |
| Engesoft msxk-13 / Engesoft MSXK-13 - Lado B.cas | Yes | `CASGOI /B` |  |  |
| English Words (1986)(Aschcom) | Yes | `CASGOR` |  |  |
| Enjoy Triangle volume 3 (1986)(BAIT-AL-HIKMA)(ja)[cas] / Enjoy Triangle v3 tape 1 side A - Sky Cleaning.cas | Yes | `CASGOR` |  |  |
| Eric and the Floaters (1983)(Hudson Soft) | Yes | `CASGOR` |  |  |
| Erik the Viking (1984)(Level 9 Computing)[fixed][RUN'CAS'] | Yes | `CASGOR /CB` |  |  |
| Erik the Viking (1984)(Level 9 Computing)[RUN'CAS'] | Yes | `CASGOR /CB` |  |  |
| Erik the Viking Text Ony (1984)(Level 9 Computing)[RUN'CAS'] | Yes | `CASGOI /CB` |  |  |
| European Games (1987)(Tynesoft)(Side A)[a][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| European Games (1987)(Tynesoft)(Side A)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| European Games (1987)(Tynesoft)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Exerion (1987)(Eaglesoft)[RUN'CAS-'] | Yes | `CASGOI /CB` |  |  |
| Exerion II - Zorni (1987)(Eaglesoft)[RUN'CAS-'] | Yes | `CASGOI /CB` |  |  |
| Exploding Atoms (1985)(Sanyo)[a][CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Exploding Atoms (1985)(Sanyo)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Exterminator (1987)(The Bytebusters) | Yes | `CASGOR /CB` |  |  |
| Fall Out (1984)(Policy)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Fanky Punky (1987)(P.J. Software)(es)[a][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Fanky Punky (1987)(P.J. Software)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Fantastic Footbal v1.0 (2021) | Yes | `CASGOR /B` |  |  |
| Farm (2019) (N.I.) [RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Fernando Martin Basket Master (1987)(Dinamic Software)(es)[BLOAD'CAS-',R] | Yes | `CASGOI /C` |  |  |
| Fernando Martin Basket Master - Executive (1987)(Dinamic Software)(es)[a][RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Fernando Martin Basket Master - Executive (1987)(Dinamic Software)(es)[RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Fernando Martin Basket Master - Executive (1987)(Dinamic Software)[RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Feud (1987)(Bulldog)[RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Fharanx (1985)(Enix)[By Django][BLOAD'CAS-',r] | Yes | `CASGOR` |  |  |
| Field Master (1985)(Login Soft)[CLOAD+RUN] | Yes | `CASGOR` |  |  |
| Fin Pack (1986)(Aackosoft)[a][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Fin Pack (1986)(Aackosoft)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Final Countdown (1988)(Methodic Solutions)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Finders Keepers (1986)(Mastertronic)[needs 64k in slot 2][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Finders Keepers (1986)(Mastertronic)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Fireball (1983) (Hudson Soft)[BLOAD'CAS-',R] | Yes | `CASGOI /C` |  |  |
| Firehawk (1987)(Players Software)[a][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Firehawk (1987)(Players Software)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Fisica I - Magnitudes (1986)(Sony)(es)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Fisica II - Movimientos (1986)(Sony)(es)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Five Holy Girls (1987)(Studio Blue)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Flappy (1984)(dB-Soft)(CLOAD+RUN) | Yes | `CASGOR` |  |  |
| Flappy Birds [BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Flash Gordon (1987)(Mastertronic Added Dimension)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Flight Deck II (1986)(Aackosoft)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Flight Path 737 (1985)(Anirog Software)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Flintstones, The (1988)(Grandslam Entertainments)[BLOAD'CAS-',R] | Yes | `CASGOI /S` |  |  |
| Floppy el pregunton (19xx)(Manhattan Transfer)(ES)[RUN'CAS-',R] | Yes | `CASGOR` |  |  |
| Flower Card (1984)(Central Education) | Yes | `CASGOR` |  |  |
| Fnick Li- Fnick La (1986) LOGiN(Sony & Klon) | Yes | `CASGOR` |  |  |
| Foggys Quest (2017) (John Blythe) [BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Foot Volley (1986)(Players Software)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Football Manager (1987)(Addictive Games)(GB)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Football Manager - World Cup Edition (1990)(Addictive Games)(es)[RUN'CAS-'] | Yes | `CASGOI` |  |  |
| Football Manager - World Cup Edition (1990)(Addictive)[RUN'CAS-'] | Yes | `CASGOI` |  |  |
| For MSX Special (1985)(Technopolis Soft) | Yes | `CASGOR` |  |  |
| Forbidden Fruit (1985)(Mind Games Espana)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Formation Z (1987)(Eaglesoft)[RUN'CAS-'] | Yes | `CASGOI /CB` |  |  |
| Formula 1 Simulator (1985)(Mastertronic)[a][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Formula 1 Simulator (1985)(Mastertronic)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Frankie (System 4, 1988) | Yes | `CASGOR` |  |  |
| Freddy Hardest (1987)(Dinamic Software)(es)(Side A)[a][RUN'CAS-'] | Yes | `CASGOR /B` |  |  |
| Freddy Hardest (1987)(Dinamic Software)(es)(Side A)[RUN'CAS-'] | Yes | `CASGOR /B` |  |  |
| Freddy Hardest in South Manhattan (1989)(Dinamic Software)(es)[RUN'CAS-'] | Yes | `CASGOT /B` |  |  |
| Freddy Hardest Side A[RUN'CAS-'] | Yes | `CASGOR /B` |  |  |
| French is Fun (1984)(CDS Microsystems)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| French is Fun (1984)(CDS Software) | Yes | `CASGOR` |  |  |
| Frog (1985)(Advance)(es)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Frogger [BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Front Line (1984)(Taito) | Yes | `CASGOR` |  |  |
| Front Line (1984)(Taito)[a] | Yes | `CASGOR` |  |  |
| Fruit Machine (1985)(DK'Tronics)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Fruit Panic (1984)(Pony Canyon & Philips Spain)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Fun Math for Elementary School Year 4 Vol 2 (1984)(Stratford Computer Center Corporation) | Yes | `CASGOI` |  |  |
| Fun Math for Elementary School Year 5 Vol 2 (1984)(Stratford Computer Center Corporation) | Yes | `CASGOR` |  |  |
| Fupper (1985)(Login Soft)[CLOAD+BLOAD'CAS-'+RUN] | Yes | `CASGOR` |  |  |
| Future Knight (1986)(Erbe Software)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Future Knight (1986)(Gremlin Graphics Software)[BLOAD'CAS-',R] | Yes | `CASGOI /S` |  |  |
| Fuzzball (ByteBusters) (Eaglesoft - Premium III Software Distribution) [RUN'CAS-'] [\_] | Yes | `CASGOR /CB` |  |  |
| Gagnant (1986) (Humming Bird Soft)[BLOAD'CAS-',r] | Yes | `CASGOR` |  |  |
| Galaga (1984)(Bug-Byte Software)[BLOAD'CAS-',R] | Yes | `CASGOR /N` |  |  |
| Galaxian (1984)(Bug-Byte Software)[BLOAD'CAS-',R] | Yes | `CASGOR /N` |  |  |
| Game Over (1988)(Dinamic Software)(es)(Side A)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Game Over (1988)(Dinamic Software)(Side A)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Game Over II (1988)(Dinamic Software)(Side A)[re-release of Phantis][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Game Pack 1 (Aackosoft - Eaglesoft)[BASIC] / Bal - Game Pack 1 (Aackosoft - Eaglesoft) [RUN'CAS-'] [\_].cas | Yes | `CASGOR` |  |  |
| Game Pack 1 (Aackosoft - Eaglesoft)[BASIC] / Baseball - Game Pack 1 (Aackosoft - Eaglesoft) [RUN'CAS-'] [\_].cas | Yes | `CASGOR` |  |  |
| Game Pack 1 (Aackosoft - Eaglesoft)[BASIC] / Eliza - Game Pack 1 (Aackosoft - Eaglesoft) [RUN'CAS-'] [\_].cas | Yes | `CASGOR` |  |  |
| Game Pack 1 (Aackosoft - Eaglesoft)[BASIC] / Hique - Game Pack 1 (Aackosoft - Eaglesoft) [RUN'CAS-'] [\_].cas | Yes | `CASGOR` |  |  |
| Game Pack 1 (Aackosoft - Eaglesoft)[BASIC] / Mastermind - Game Pack 1 (Aackosoft - Eaglesoft) [RUN'CAS-'] [\_].cas | Yes | `CASGOR` |  |  |
| Game Pack 1 (Aackosoft - Eaglesoft)[BASIC] / Roulette - Game Pack 1 (Aackosoft - Eaglesoft) [RUN'CAS-'] [\_].cas | Yes | `CASGOR` |  |  |
| Game Pack 1 (Aackosoft - Eaglesoft)[BASIC] / Solfeggietto - Game Pack 1 (Aackosoft - Eaglesoft) [RUN'CAS-'] [\_].cas | Yes | `CASGOR` |  |  |
| Game Pack 1 (Aackosoft - Eaglesoft)[BASIC] / Star Maps - Game Pack 1 (Aackosoft - Eaglesoft) [RUN'CAS-'] [\_].cas | Yes | `CASGOR` |  |  |
| Game Pack 1 (Aackosoft - Eaglesoft)[BASIC] / Stoneville Manor - Game Pack 1 (Aackosoft - Eaglesoft) [RUN'CAS-'] [\_].cas | Yes | `CASGOR` |  |  |
| Game Pack 1 (Aackosoft - Eaglesoft)[BASIC] / Trap - Game Pack 1 (Aackosoft - Eaglesoft) [RUN'CAS-'] [\_].cas | Yes | `CASGOR` |  |  |
| Game Pack 2 (1986)(Aackosoft) | Yes | `CASGOR` |  |  |
| Games Designer (1985)(Quicksilva)[BLOAD'CAS-',R] | Yes | `CASGOI /S` |  |  |
| Games, The - Winter Edition (1988)(US Gold)(Side A)[RUN'CAS-'] | Yes | `CASGOI /CB` |  |  |
| Gang Man (1988)(Armati Software)[RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Gangman (1984)(Hudson Soft)[a][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Gangman (1984)(Hudson Soft)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Gauntlet (1986)(US Gold)(Side A)[a][RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| Gauntlet (1986)(US Gold)(Side A)[RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| Gemini Wing (1989)(Virgin Mastertronic)(Side A)[Fixed][RUN'CAS-'] | Yes | `CASGOI /S8` |  |  |
| Gemini Wing (1989)(Virgin Mastertronic)(Side A)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Genghis Khan (1991)(Positive)[RUN'CAS-'] | Yes | `CASGOT /B` |  |  |
| Geo (19xx)(Mind Games Espana)(es)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Geografia de Espana (1985)(Advance)(es)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Gerente, El (1984)(DIMensionNEW)(es)[a][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Gerente, El (1984)(DIMensionNEW)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Gestion Familiar (1986)(Load 'n' Run)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Ghost (1989)(Mind Games Espana)(es)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Ghostbusters (1985)(Activision)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Ghostbusters II (1989)(Activision)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Glass (1985)(Quicksilva)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Gnome Ranger - Part 1 (1987)(Level 9 Computing)[Cracked][RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| Gnome Ranger - Part 1 (1987)(Level 9 Computing)[Protected][RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| Gnome Ranger - Part 2 (1987)(Level 9 Computing)[Cracked][RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| Gnome Ranger - Part 2 (1987)(Level 9 Computing)[Protected][RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| Gnome Ranger - Part 3 (1987)(Level 9 Computing)[Cracked][RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| Gnome Ranger - Part 3 (1987)(Level 9 Computing)[Protected][RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| GOAL Complete (2019) (G.G.G. Software) [CLOAD + RUN + RUN] | Yes | `CASGOR` |  |  |
| GOAL Part 1 (2019) (G.G.G. Software) [CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Golden Basket (1990)(Opera Soft)(es)[BLOAD'CAS-',R] | Yes | `CASGOR /C` |  |  |
| Golden Basket (1990)(Opera Soft)(es)[passworded][BLOAD'CAS-',R] | Yes | `CASGOR /C` |  |  |
| Golden Grave II (Stratford Computer Center, 1985)(jp)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Gonzzalezz (1989)(Opera Soft)(es)(Side A)[BLOAD'CAS-',R] | Yes | `CASGOR /C` |  |  |
| Goody (1987)(Opera Soft)(es)[a][BLOAD'CAS-',R] | Yes | `CASGOR /C` |  |  |
| Goody (1987)(Opera Soft)(es)[BLOAD'CAS-',R] | Yes | `CASGOR /C` |  |  |
| Goonies  [BLOAD'CAS-',R] | Yes | `CASGOR /B` |  |  |
| Graficas de Gestion (1985)(DIMensionNEW)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Grand Prix Master (1988)(Dinamic) | Yes | `CASGOR` |  |  |
| Graphic Editor (1984)(HAL Laboratories)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Gravitica (2018) (Yusuke Miyauchi) [BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Green Cat Chronical (2018) (N.I.) [Bload'CAS-',R] | Yes | `CASGOR` |  |  |
| Gremlins 2 - La Nueva Generacion (1990)(Topo Soft)(es)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Grid Trap (1985)(LiveWire Software)[a][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Grid Trap (1985)(LiveWire Software)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Grog's Revenge (1985)(US Gold)(GB)[RUN'CAS-']-FX2 | Yes | `CASGOM /B` |  |  |
| Guillermo Tell (1989)(Opera Soft)(es)[gunstick][BLOAD'CAS-',R] | Yes | `CASGOR /C` |  |  |
| Gunfright (1985)(Ultimate Play The Game)[a][BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Gunfright (1985)(Ultimate Play The Game)[BLOAD'CAS-',R] | Yes | `CASGOT /C` |  |  |
| Gunman (1983)(Hudson Soft)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Gunsmoke (1987)(Go!)(Side A)[aka Desperado][RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Guntus (2022)(inufuto) | Yes | `CASGOR` |  |  |
| Gusano (1985)(Advance)(es)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Gusano (1985)(Advance)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Guss en la Atlantida (1985)(Creativos Editoriales) / Mejor Software - Issue 01 - Guss en la Atlantida (19xx)(Creativos Editoriales)(ES)[a][CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Guss en la Atlantida (1985)(Creativos Editoriales) / Mejor Software - Issue 01 - Guss en la Atlantida (19xx)(Creativos Editoriales)(ES)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Guttblaster (1988)(Eurosoft)[a][RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Guttblaster (1988)(Eurosoft)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| H.E.R.O. (1984)(Activision)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| H.E.R.O. (1984)(Disprosoft)[Fixed][BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Habilit (1988)(Iber Soft)(es)[RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Hades (1985)(Sony)(ES)[h CEZ][RUN'CAS-'] | Yes | `CASGOR /B` |  |  |
| Hammer Boy (1991)(Dinamic Software)(Side A)[RUN'CAS-'] | Yes | `CASGOT /S` |  |  |
| Hang-On [BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Hanggliding Game (1985)(Login Soft)[CLOAD+RUN] | Yes | `CASGOR` |  |  |
| Happy Fret (1985)(Eaglesoft)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Happy Fret (1985)(Micro Cabin)[a][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Hard Boiled (1987)(Methodic Solutions)[a][RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Hard Boiled (1987)(Methodic Solutions)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Harry Fox Yki no Maoh (1985)(Micro Cabin)(ja)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Harvey Smith's Showjumper (1985)(Software Projects)[passworded][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Harvey Smith's Showjumper (1985)(Software Projects)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Haunted House (1988)(Eurosoft)[a][RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Haunted House (1988)(Eurosoft)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Head Alignment Kit (1985)(Aackosoft)[a][RUN'CAS-'] | No | `CASGOI /B` | I | `CASGO /BT` |
| Head Alignment Kit (1985)(Aackosoft)[RUN'CAS-'] | No | `CASGOI /B` | I | `CASGO /BT` |
| Head over Heels (1987)(Erbe Software)[RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Head over Heels (1987)(Ocean Software)[a][RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Head over Heels (1987)(Ocean Software)[RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Heist, The (1985)(Aackosoft)[RUN'CAS-'] | Yes | `CASGOI /CB` |  |  |
| HELP (1983)(Hudson Soft)[BLOAD'CAS-',R] | Yes | `CASGOI /C` |  |  |
| Hercules - Slayer of the Damned (1988)(Gremlin Graphics Software)[BLOAD'CAS-',R] | Yes | `CASGOT /S` |  |  |
| Highway Encounter (1985)(Dinamic Software)(es)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Hikohiko Ace (From Valis Club Vol. 1)(1989)(Telenet Japan)(ja) | Yes | `CASGOR` |  |  |
| HiSoft Devpac GENS (1984)(HiSoft)[a][RUN'CAS-'] | Yes | `CASGOI /CB` |  |  |
| HiSoft Devpac GENS (1984)(HiSoft)[RUN'CAS-'] | Yes | `CASGOI /CB` |  |  |
| HiSoft Devpac MONS (1984)(HiSoft)[RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Hopman (2023) (Inufuto) | Yes | `CASGOR` |  |  |
| Hopper (1986)(Eaglesoft)[RUN'CAS-'] | Yes | `CASGOR /B` |  |  |
| Hopper - MSX Compilation 5 (ByteBusters) (Aackosoft - Eaglesoft) [RUN'CAS-'] [\_] | Yes | `CASGOR /CB` |  |  |
| Hostages (1990)(Infogrames)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Howard the Duck (1987)(Activision)[BLOAD'CAS-',R] | Yes | `CASGOI /N` |  |  |
| Humphrey (1984)(Mr. Micro)[a][BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Humphrey (1984)(Mr. Micro)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Humphrey (1988)(Zigurat Software)(es)[a][RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Humphrey (1988)(Zigurat Software)(es)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Hunchback (1984)(Ocean Software)[a][BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Hunchback (1984)(Ocean Software)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Hundra (1988)(Dinamic Software)(es)[a][RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Hundra (1988)(Dinamic Software)(es)[RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Hunt for Red October, The (1988)(Grandslam Entertainments)[BLOAD'CAS-',R] | Yes | `CASGOI /S` |  |  |
| Hustler (1984)(Bubblebus Software)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Hydlide (1985)(T&E Soft)[a][BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Hydlide (1985)(T&E Soft)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Hype (1987)(Methodic Solutions)[RUN'CAS-'] | Yes | `CASGOI /CB` |  |  |
| HyperSports1[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| HyperSports2[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| HyperSports3[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Hypsys (1989)(Techno Arts)(Side A)[a][RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Hypsys (1989)(Techno Arts)(Side A)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Ice (1986)(Eaglesoft)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Ice-Breaker (1990)(Topo Soft)(es)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| IdeaType - Instructor Mecanografico (1985)(Idealogic)(es)(Side A)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Igloo (1985)(Garbi Soft)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Illusions (1985)(Nice Ideas)(fr)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Impetus (2021)(Inufuto) | Yes | `CASGOR` |  |  |
| Impetus+ (2025)(Inufuto) | Yes | `CASGOR` |  |  |
| Inca (1987)(Eaglesoft)[a][RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Inca (1987)(Eaglesoft)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Indiana Jones and the Last Crusade (1989)(Erbe Software)(es)(Side A)[a][RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Indiana Jones and the Last Crusade (1989)(Erbe Software)(es)(Side A)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Indiana Jones and the Temple of Doom (1987)(US Gold)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Ingrid's Back  Part 1 (1988)(Level 9 Computing)[Corrupt][RUN'CAS-',R] | Yes | `CASGOT /CB` |  |  |
| Ingrid's Back  Part 1 (1988)(Level 9 Computing)[Cracked][RUN'CAS-',R] | Yes | `CASGOT /CB` |  |  |
| Ingrid's Back  Part 1 (1988)(Level 9 Computing)[Protected][RUN'CAS-',R] | Yes | `CASGOT /CB` |  |  |
| Ingrid's Back  Part 2 (1988)(Level 9 Computing)[Cracked][RUN'CAS-',R] | Yes | `CASGOT /CB` |  |  |
| Ingrid's Back  Part 2 (1988)(Level 9 Computing)[Protected][RUN'CAS-',R] | Yes | `CASGOT /CB` |  |  |
| Ingrid's Back  Part 3 (1988)(Level 9 Computing)[Cracked][RUN'CAS-',R] | Yes | `CASGOT /CB` |  |  |
| Ingrid's Back  Part 3 (1988)(Level 9 Computing)[Protected][RUN'CAS-',R] | Yes | `CASGOT /CB` |  |  |
| Ink (2005)(INK TEAM) | Yes | `CASGOR` |  |  |
| International Karate (1986)(Endurance Games)[a2][RUN'CAS-'] | Yes | `CASGOR /B` |  |  |
| International Karate (1986)(Endurance Games)[a][RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| International Karate (1986)(Endurance Games)[RUN'CAS-'] | Yes | `CASGOR /B` |  |  |
| Invaders (1986)(LiveWire Software)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Invierte y Gana (1986)(DIMensionNEW)(es)[RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Iron of the War (19xx)(Mind Games Espana)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Isitar 7 (2019) (N.I.) [RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Italia '90 - World Cup Soccer (1989)(Dro Soft)(es)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Jabato (1989)(Aventuras AD)(es)(Side A)[RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| Jack the Nipper (1986)(Gremlin Graphics Software)[a][BLOAD'CAS-',R] | Yes | `CASGOI /S` |  |  |
| Jack the Nipper (1986)(Gremlin Graphics Software)[BLOAD'CAS-',R] | Yes | `CASGOI /S` |  |  |
| Jack the Nipper II - In Coconut Capers (1987)(Gremlin Graphics Software)[BLOAD'CAS-',R] | Yes | `CASGOI /S` |  |  |
| Jai Alai (Opera Soft, 1991) | Yes | `CASGOR /CB` |  |  |
| Jaws (1989)(Screen 7)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Jet Bomber (1985)(Aackosoft)[a][RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Jet Bomber (1985)(Aackosoft)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Jet Fighter (1985)(Aackosoft)(NL)(en)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Jet Fighter (1988)(Eurosoft)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Jet Fighter - Compilation Tape 1 (ByteBusters) (Aackosoft - Eaglesoft) [RUN'CAS-'] [\_] | Yes | `CASGOR /CB` |  |  |
| Jet Set Willy II - The Final Frontier (1985)(Software Projects)[passworded][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Jet Set Willy II - The Final Frontier (1985)(Software Projects)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Jewels of Darkness I - Colossal Adventure v2 (1986)(Level 9 Computing)[a2 - Cracked][RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| Jewels of Darkness I - Colossal Adventure v2 (1986)(Level 9 Computing)[a2 - Protected][RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| Jewels of Darkness I - Colossal Adventure v2 (1986)(Level 9 Computing)[a][RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| Jewels of Darkness I - Colossal Adventure v2 (1986)(Level 9 Computing)[RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| Jewels of Darkness II - Adventure Quest v2 (1986)(Level 9 Computing)[a2 - Cracked][RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| Jewels of Darkness II - Adventure Quest v2 (1986)(Level 9 Computing)[a2 - Protected][RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| Jewels of Darkness II - Adventure Quest v2 (1986)(Level 9 Computing)[a][RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| Jewels of Darkness II - Adventure Quest v2 (1986)(Level 9 Computing)[RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| Jewels of Darkness III - Dungeon Adventure v2 (1986)(Level 9 Computing)[a2 - Cracked][RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| Jewels of Darkness III - Dungeon Adventure v2 (1986)(Level 9 Computing)[a2 - Protected][RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| Jewels of Darkness III - Dungeon Adventure v2 (1986)(Level 9 Computing)[a][RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| Jewels of Darkness III - Dungeon Adventure v2 (1986)(Level 9 Computing)[RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| Joe Blade (1989)(Players Software)[BLOAD'CAS-',R] | Yes | `CASGOI` |  |  |
| Johny Comomolo in 3-2-1 Fire (1986)(Dro Soft)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Journey to the Centre of the Earth (1985)(Bug-Byte Software)(Side A)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Jump Jet (1985)(Anirog)(GB)[Run'CAS-'] | Yes | `CASGOR` |  |  |
| Jumping Jack (1986)(Livewire) | Yes | `CASGOR` |  |  |
| Jungle Warrior (1990)(Zigurat Software)(es)[RUN'CAS-'] | Yes | `CASGOR /B` |  |  |
| Juno Lander (1983)(SIL)[CLOAD+RUN] | Yes | `CASGOR` |  |  |
| Kaereltje Leert Wiskunde ~ Charlie's Maths Class - Compilation Tape 1 (ByteBusters) (Aackosoft - Eaglesoft) [RUN'CAS-'] [\_] | Yes | `CASGOR` |  |  |
| Kamikaze (1984)(Omega Systems)(jp)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Katori Sensō (Mosquito Wars)(UCHUDO)(1984)[BLOAD'CAS-',r] | Yes | `CASGOR` |  |  |
| Ke Rulen los Petas (1989)(Iber Soft)(es)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Keystone Kapers (1984)(Activision) | Yes | `CASGOR` |  |  |
| Keystone Kapers(1984)(Activision)[a] | Yes | `CASGOR` |  |  |
| Khazzad-Dum (1989)(SPE)(es)[RUN'CAS-'] | Yes | `CASGOR /B` |  |  |
| Kick It - MSX Compilation 5 (ByteBusters) (Aackosoft - Eaglesoft) [RUN'CAS-'] [\_] | Yes | `CASGOR /CB` |  |  |
| Killer Station (1983) (Hudson Soft)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| King Leonard (1986)(Mind Games Espana)(es)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| KingsVally[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Klax (1990)(Domark)[BLOAD'CAS-',R] | Yes | `CASGOI /S` |  |  |
| Knight Ghost (1987)(Dro Soft)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Knight Lore (1985)(Ultimate Play The Game)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Knight Lore (Ultimate Play The Game)[BLOAD'CAS-',R] [\_] | Yes | `CASGOR` |  |  |
| Knight Lore Remake (2009) [BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Knight Orc - Part 1 - Loosed Orc (1987)(Level 9 Computing)[a3 - Cracked][RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| Knight Orc - Part 1 - Loosed Orc (1987)(Level 9 Computing)[a3 - Protected][RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| Knight Orc - Part 1 - Loosed Orc (1987)(Rainbird Software)[a2][RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| Knight Orc - Part 1 - Loosed Orc (1987)(Rainbird Software)[a][RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| Knight Orc - Part 1 - Loosed Orc (1987)(Rainbird Software)[RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| Knight Orc - Part 2 - A Kind of Magic (1987)(Level 9 Computing)[a1 - Cracked][RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| Knight Orc - Part 2 - A Kind of Magic (1987)(Level 9 Computing)[a1 - Protected][RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| Knight Orc - Part 2 - A Kind of Magic (1987)(Rainbird Software)[passworded][RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| Knight Orc - Part 2 - A Kind of Magic (1987)(Rainbird Software)[RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| Knight Orc - Part 3 - Hordes of the Mountain King (1987)(Level 9 Computing)[a1 - Cracked][RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| Knight Orc - Part 3 - Hordes of the Mountain King (1987)(Level 9 Computing)[a1 - Protected][RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| Knight Orc - Part 3 - Hordes of the Mountain King (1987)(Rainbird Software)[passworded][RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| Knight Orc - Part 3 - Hordes of the Mountain King (1987)(Rainbird Software)[RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| Knight Tyme (1986)(Mastertronic Added Dimension)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Knightmare[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Knockout (1985)(Alligata Software)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Konami's Soccer (1985)(Konami)[h Onaki][RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Kong (1988)(Eurosoft)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Kong (Eurosoft) (VA Holding) (Side A) [RUN'CAS-'] [\_] | Yes | `CASGOR /CB` |  |  |
| Kong's Revenge (1991)(Zigurat Software)(es)(Side A)[RUN'CAS-'] | Yes | `CASGOM /CB` |  |  |
| Krakout (1987)(Gremlin Graphics Software)[a][BLOAD'CAS-',R] | Yes | `CASGOI /S` |  |  |
| Krakout (1987)(Gremlin Graphics Software)[BLOAD'CAS-',R] | Yes | `CASGOI /S` |  |  |
| Krom - El Guerrero Invencible (1989)(OMK Software)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Kubus (1985)(Kuma Computers)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Kuma Forth (1984)(Kuma Computers)[a][CLEAR200,&H87FF + BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Kuma Forth (1984)(Kuma Computers)[CLEAR200,&H87FF + BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Kuma Logo (1984)(Kuma Computers)[a][CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Kuma Logo (1984)(Kuma Computers)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| La Geste d'Artillac Cas A (1985) Infogrames | No | `CASGOR` | X |  |
| Laberinto (1985)(Advance)(es)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Laberinto Binario - Binary Land (Sony Spain) (Indescomp) [BLOAD'CAS-',R] [\_] | Yes | `CASGOR` |  |  |
| Lady Safary (1988)(OMK Software)(es)[RUN'CAS-'] | Yes | `CASGOR /P3` |  |  |
| Lancelot - Part 1 (1988)(Level 9 Computing)(RUN'CAS-',R] | Yes | `CASGOT /CB` |  |  |
| Lancelot - Part 2 (1988)(Level 9 Computing)(RUN'CAS-',R] | Yes | `CASGOT /CB` |  |  |
| Lancelot - Part 3 (1988)(Level 9 Computing)(RUN'CAS-',R] | Yes | `CASGOT /CB` |  |  |
| Las Aventuras de Rudolphine Rur (2020)(Dwalin & Domingo) / RUR1.cas | Yes | `CASGOI /S` |  |  |
| Las Aventuras de Rudolphine Rur (2020)(Dwalin & Domingo) / RUR2.cas | Yes | `CASGOI /S` |  |  |
| Last Dungeon, The (19xx)(Grupo de Trabajo Software)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Last Mission, The (1987)(Opera Soft)(es)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Lazer Bykes (1985)(PSS)[a2][BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Lazer Bykes (1985)(PSS)[a][BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Lazer Bykes (1985)(PSS)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Lazy Jones (1985)(Terminal Software)[a2][RUN'CAS-'] | Yes | `CASGOR /B` |  |  |
| Lazy Jones (1985)(Terminal Software)[a][RUN'CAS-'] | Yes | `CASGOR /B` |  |  |
| Lazy Jones (1985)(Terminal Software)[RUN'CAS-'] | Yes | `CASGOR /B` |  |  |
| Le Mans (1984)(Electric Software)[a][BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Le Mans (1984)(Electric Software)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Legend of White and Black - Ringo Tensei Hen - Tape 1 Side A (1986)(Soft Studio WING) | Yes | `CASGOR` |  |  |
| Legends of Star Arthur - Planet Mephius (1985)(T&E Soft)(ja)(Side A)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Let's Computer (1984)(Melsoft & Three Quarter)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Leyendas (19xx)(Mind Games Espana)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Life in the Fast Lane (1987)(Methodic Solutions)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Lift (2021)(Inufuto) | Yes | `CASGOR` |  |  |
| Light Corridor, The (1990)(Infogrames)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Like The Monkey King (1984)(Ample Software)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Linez (2018) [Wim Dewijngaert] [BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Linez (2018) [Wim Dewijngaert] [fixed] [BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Livingstone Supongo (1986)(Opera Soft)(es)[BLOAD'CAS-',R] | Yes | `CASGOI /C` |  |  |
| Livingstone Supongo (1986)(Opera Soft)(es)[RUN'CAS-'] | Yes | `CASGOI /CB` |  |  |
| Livingstone Supongo II (1989)(Opera Soft)(Side A)[BLOAD'CAS-',R] | Yes | `CASGOR /C` |  |  |
| Lizard (1985)(Micro Cabin)(ja)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Lizard Willy (2016)(sfranck72) [BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Lizard Willy [BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Locke the Superman - Asteroid Kahn  (1984)(Pony Canyon)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Lord Watson (Manhattan Transfer, 198x) | Yes | `CASGOR` |  |  |
| Lords Of Time (1983)(Level 9 Computing)[RUN'CAS-',R] | Yes | `CASGOR` |  |  |
| Lorna (1990)(Topo Soft)(es)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Los Elfos de Maroland (2023)(Dwalin)(es)(Side A) | Yes | `CASGOI /S` |  |  |
| Loto (19xx)(Manhattan Transfer)(es)[a][BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Loto (19xx)(Manhattan Transfer)(es)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Lucky Luke (1985)(Javier Laguna García)(es) | Yes | `CASGOR` |  |  |
| Lunar Ball [BLOAD'CAS-',r] | Yes | `CASGOR` |  |  |
| M-Droid (19xx)(Blue Ribbon Software)[a][RUN'CAS-'] | Yes | `CASGOR /P6` |  |  |
| M-Droid (19xx)(Blue Ribbon Software)[RUN'CAS-'] | Yes | `CASGOR /P5` |  |  |
| Mac Attack (1986)(Eaglesoft)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Macadam Bumper (1985)(Players Software)[a2][BLOAD'CAS-',R] | No | `CASGOI /S` | X |  |
| Macadam Bumper (1985)(Players Software)[a][BLOAD'CAS-',R] | No | `CASGOI /S` | X |  |
| Macadam Bumper (1985)(Players Software)[BLOAD'CAS-',R] | No | `CASGOI /S` | X |  |
| Mad Mix 2 - En el Castillo de los Fantasmas (1990)(Topo Soft)(es)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Mad Mix Game (1988)(Topo Soft)(es)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Made in Spain - 5 Estrellas (1985)(Zigurat Software)(es)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Magic Johnson's Basketball (1990)(Dro Soft)(es)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Magic Pinball (1987)(OMK Software)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Magic Tower Adventure (2017)[Timmy] [BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Magical Computer Music L5 Demo (1985)(CBS & Sony)[CLOAD] | Yes | `CASGOR` |  |  |
| Mandragore (Infogrames)(1987)(en)(Tape 1 Side A)[BLOAD'CAS-',R] | Yes | `CASGOM /C` |  |  |
| Manes (1984)(Ascii)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Manic Miner (1984)(Software Projects)[a][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Manic Miner (1984)(Software Projects)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Map Game (1985)(Erbe Software)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Mappy (1984)(Bug-Byte Software)[BLOAD'CAS-',R] | Yes | `CASGOR /N` |  |  |
| Martianoids (1987)(Ultimate Play The Game)[BLOAD'CAS-',R] | Yes | `CASGOT /C` |  |  |
| Mask II (1987)(Gremlin Graphics Software)[BLOAD'CAS-',R] | Yes | `CASGOI /S` |  |  |
| Mask III - Venom Strikes Back (1988)(Gremlin Graphics Software)[BLOAD'CAS-',R] | Yes | `CASGOI /S` |  |  |
| Master Chess (1987)(Mastertronic)[a][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Master Chess (1987)(Mastertronic)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Master of the Lamps (1985)(Activision)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Master Voice (1985)(Aackosoft)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Matamarcianos. Batalla Espacial (1986)(Manhattan Transfer)(es)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Match Day II (1987)(Ocean Software)[RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Maths Invaders (1985)(Aackosoft)[a][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Maths Invaders (1985)(Aackosoft)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Maxima (1984)(PSS)[a][BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Maxima (1984)(PSS)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Mayhem (1985)(Mr. Micro)[BLOAD'CAS-',R] | Yes | `CASGOR /C` |  |  |
| Maze Master (1988)(Eurosoft)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Maze Max (1985)(Loriciels)(fr)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Mazes Unlimited (1986)(Eaglesoft)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Maziacs (1985)(DK'Tronics)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Mazogs (2017)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Mazy (2021)(Inufuto) | Yes | `CASGOR` |  |  |
| Mazy 2 (2025)(inufuto) | Yes | `CASGOR` |  |  |
| Mean Streets (19xx)(Kuma Computers)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Mecom (1988)(Iber Soft)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Mega Chess (1988)(Iber Soft)(es)[aka Super Chess][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Meganova (1988)(Dinamic Software)(es)(Side A)[RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Meganova (1988)(Dinamic Software)(es)[RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Megaphoenix (1991)(Dinamic Software)[RUN'CAS-'] | Yes | `CASGOT /B` |  |  |
| Memory - C.04 (1985)(Computer Users Club)(nl)[position tape + CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Merlin (1987)(Mind Games Espana)(es)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Metropolis (1989)(Topo Soft)(es)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Michel Futbol Master (1989)(Dinamic Software)(es)(Side A)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Michel Futbol Master (1989)(Dinamic Software)(Side A)[RUN'CAS-'] | Yes | `CASGOT /B` |  |  |
| Micky-Lucky (MSX Magazine, 1985) | Yes | `CASGOR` |  |  |
| Midnight Commander (1983)(Microcabin)(JP)[!][CLOAD   RUN] | Yes | `CASGOR` |  |  |
| Milk Race (1987)(Mastertronic)[a][RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Milk Race (1987)(Mastertronic)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Minder (1985) (dK'Tronics) [RUN'CAS-'] | Yes | `CASGOR /B` |  |  |
| Miner Machine (1987)(Eaglesoft)[a][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Miner Machine (1987)(Eaglesoft)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Mini-Golf (1984)(Advance)(es)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Mision en Espana (19xx)(Mind Games Espana)(es)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Mision Rescate (1986)(Anaya Multimedia)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Missing In The Okhotsk - Scene 1 (1985)(Login Soft)(Tape 1 - Side A)(ja)[BLOAD'CAS-',r] | Yes | `CASGOI` |  |  |
| Misterio del Nilo, El (1987)(Zigurat Software)(es)[a][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Misterio del Nilo, El (1987)(Zigurat Software)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Miyuki Memorial Doors (1984)(Kitty Records)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Miyuki Memorial Full Archive (.CAS, LP & Listing) / Miyuki Memorial Doors (1984)(Kitty Records)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Miyuki Memorial Full Archive (.CAS, LP & Listing) / Miyuki Memorial Graphics & Doors (1984)(Kitty Records)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Miyuki Memorial Full Archive (.CAS, LP & Listing) / Miyuki Memorial Graphics (1984)(Kitty Records)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Miyuki Memorial Graphics & Doors (1984)(Kitty Records)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Miyuki Memorial Graphics (1984)(Kitty Records)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Miyuki The Gambler (1984)(Central Education)(ja){Side A) | Yes | `CASGOR` |  |  |
| Mocky (1985)(Login Soft)[CLOAD+BLOAD'CAS-'+RUN] | Yes | `CASGOR` |  |  |
| Molecule Man (1986)(Mastertronic)[a][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Molecule Man (1986)(Mastertronic)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Monopoly (1986)(Leisure Genius)[RUN'CAS-'] | Yes | `CASGOI /CB` |  |  |
| Moon Rider (1986)(Eaglesoft)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Moonwalker (1989)(US Gold)[a][RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Moonwalker (1989)(US Gold)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Mortadelo y Filemon (1988)(Dro Soft)(es)[RUN'CAS-'] | Yes | `CASGOI /S2` |  |  |
| Mortadelo y Filemon II - Safari Callejero (1990)(Dro Soft)(es)(Side A)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Most Amazing Memory Game, The (1986)(Idealogic)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Mot (1989)(Opera Soft)(es)(Side A)[BLOAD'CAS-',R] | Yes | `CASGOR /C` |  |  |
| Motkonqe (2017) (N.I.)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Motorista Sideral, El (1986)(Anaya Multimedia)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Mountain Bike Racer (1990)(Positive)[RUN'CAS-'] | Yes | `CASGOT /B` |  |  |
| Mr. Jaws (1987)(The Bytebusters) | Yes | `CASGOR /CB` |  |  |
| Mr. Wong's Loopy Laundry (1984)(Artic Computing)[a][BLOAD'CAS-',R] | Yes | `CASGOI /B` |  |  |
| Mr. Wong's Loopy Laundry (1984)(Artic Computing)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| MST-Calc (1985)(MST Consultants)[CLOAD+RUN] | Yes | `CASGOR` |  |  |
| MSX Screendump (1986)(Philips)(nl)[a][BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| MSX Screendump (1986)(Philips)(nl)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| MSXtra - 3D Knockout (1986)[Alligata][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| MSXtra - Blagger (1986)[Alligata][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| MSXtra - Disc Warrior (1986)[Alligata][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| MSXtra - Superbowl (1986)[Alligata][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Mundial de Futbol (1990)(Opera Soft)(es)(Side A)[BLOAD'CAS-',R] | Yes | `CASGOR /C` |  |  |
| Mundo Perdido, El (1988)(Topo Soft)(es)[RUN'CAS-'] | Yes | `CASGOR /S` |  |  |
| Mutan Zone (1989)(Opera Soft)(es)(Side A)[a][BLOAD'CAS-',R] | Yes | `CASGOR /C` |  |  |
| Mutan Zone (1989)(Opera Soft)(es)(Side A)[BLOAD'CAS-',R] | Yes | `CASGOR /C` |  |  |
| Mutant Monty (1985)(Artic Computing)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Mystery House (1983)(Micro Cabin)(ja)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Mystery House II (1984)(Micro Cabin)(en)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Mystery House II (1984)(Micro Cabin)(ja)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Mystery Of The Mu Continent (1984)(Stratford Computer Center Corporation)(ja)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Mystical (1991)(Infogrames)(Side A)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Mythos (1990)(Opera Soft)[a][BLOAD'CAS-',R] | Yes | `CASGOR /C` |  |  |
| Mythos (1990)(Opera Soft)[BLOAD'CAS-',R] | Yes | `CASGOR /C` |  |  |
| Naitou Kunio no Tsume Shougi (1984)(Apollo Technica)(Side A)(JP)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Narco Police (1990)(Dinamic Software)(Side A)[a][RUN'CAS-'] | Yes | `CASGOI /B15` |  |  |
| Narco Police (1990)(Dinamic Software)(Side A)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Navy Moves (1988)(Dinamic Software)(es)(Side A)[a][RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Navy Moves (1988)(Dinamic Software)(es)(Side A)[RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Navy Moves (1988)(Dinamic Software)(Side A)[RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Neuras (2021)(Inufuto) | Yes | `CASGOR` |  |  |
| Nick Neaker (1983)(Colpax) | Yes | `CASGOR` |  |  |
| Night Flight (1982)(Nippon Columbia - Colpax - Universal)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Nightlife (1985)(Koei)(ja) | Yes | `CASGOR` |  |  |
| Nightshade (1985)(Ultimate Play The Game)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Nikonikopun What Is It (1984)(NHK Gakuen)(ja) | Yes | `CASGOR` |  |  |
| Ninja 2. Ninja Jaja Maru Kun (1987)(Eaglesoft)[RUN'CAS-'] | Yes | `CASGOI /CB` |  |  |
| Ninja-kun - Magic Castle Adventure (1985)(Jaleco) | Yes | `CASGOI /CB` |  |  |
| Ninjya Kage (1984)(Hudson Soft) | Yes | `CASGOR` |  |  |
| Nohzdyve (2019) (Giovanni Nunes Matt Wescott)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Nonamed (1986)(Dinamic Software)(es)[a][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Nonamed (1986)(Dinamic Software)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| North & South (1991)(Infogrames)(M3)(Side A)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| North Sea Bullion Adventure (1985)(Kuma Computers)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| North Sea Helicopter (1987)(Aackosoft)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| North Sea Helicopter (Aackosoft, 1985) | Yes | `CASGOR /CB` |  |  |
| Nuclear Bowls (1986)(Zigurat Software)(es)[RUN'CAS-'] | Yes | `CASGOI /CB` |  |  |
| Obliterator (1989)(Dro Soft)(es)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Ocean Conqueror (1987)(Mastertronic)[RUN'CAS-'] | Yes | `CASGOR /B` |  |  |
| Oceano (2015) (EgoTrip) [BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Octagon Squad (1986)(Mastertronic)[a2][RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Octagon Squad (1986)(Mastertronic)[a][RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Octagon Squad (1986)(Mastertronic)[RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Octopuss MSX Panic (1986)(Eoe)(fr)[Fixed][BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Offering (1984)(AI Inc.)[RUN'CAS-',R] | Yes | `CASGOR` |  |  |
| Oh Mummy!! (1984)(Longman Software)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Oh no! (Aka Oh Shit!) [Aackosoft] [Disprosoft] [1986][CLOAD+RUN] | Yes | `CASGOR` |  |  |
| Oh Shit! (1986)(Aackosoft)[a][RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Oh Shit! (1986)(Aackosoft)[b][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Oh Shit! (1986)(Aackosoft)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Oh Shit! (ByteBusters) (Aackosoft - Eaglesoft) [RUN'CAS-'] [\_] | Yes | `CASGOR /CB` |  |  |
| Oh Shit! - MSX Compilation 5 (ByteBusters) (Aackosoft - Eaglesoft) [RUN'CAS-'] [\_] | Yes | `CASGOR /CB` |  |  |
| Oil's Well (1985)(Eaglesoft)[RUN'CAS-'] | Yes | `CASGOI /CB` |  |  |
| Operation Wolf (1988)(Ocean Software)(Side A)[a][BLOAD'CAS-',R] | Yes | `CASGOI /C` |  |  |
| Operation Wolf (1988)(Ocean Software)(Side A)[BLOAD'CAS-',R] | Yes | `CASGOI /C` |  |  |
| Operation Wolf (1988)(Ocean Software)[BLOAD'CAS-',R] | Yes | `CASGOI /C` |  |  |
| Oregon Trail  (2020) (Cobinee and Jitursan) [BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Ormuz (1988)(Iber Soft)(es)[a][RUN'CAS-'] | Yes | `CASGOR /B` |  |  |
| Ormuz (1988)(Iber Soft)(es)[RUN'CAS-'] | Yes | `CASGOR /B` |  |  |
| Ortografia I - Vocabulario (19xx)(Mind Games Espana)(es)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Ortografia II - Verbos (19xx)(Mind Games Espana)(es)[a][CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Ortografia II - Verbos (19xx)(Mind Games Espana)(es)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Ortografia III - Frases (19xx)(Mind Games Espana)(es)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Ostrich (1985)(Columbia) [CLOAD-RUN] | Yes | `CASGOR` |  |  |
| Otto e Trenta (1985)(Melchioni Informatica)(it) | Yes | `CASGOR` |  |  |
| Ougon no Haka. Golden Tomb. Mystery of Egypt (1984)(Magical Zoo)(ja)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Oushou (King) (1984)(Microcabin)(ja) | Yes | `CASGOR` |  |  |
| Out Run (1988)(US Gold)[a][BLOAD'CAS-',R] | Yes | `CASGOI /S` |  |  |
| Out Run (1988)(US Gold)[a][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Out Run (1988)(US Gold)[BLOAD'CAS-',R] | Yes | `CASGOI /S` |  |  |
| Out Run (1988)(US Gold)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Outroyd (1985)(Magical Zoo)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Outroyd (1985)(Magical Zoo)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| PAC-01 - Arcs (2021) | Yes | `CASGOR` |  |  |
| Pac-Land (1988)(Grandslam Entertainments)[BLOAD'CAS-',R] | Yes | `CASGOI /S` |  |  |
| Pac-Man (1984)(Bug-Byte Software)[BLOAD'CAS-',R] | Yes | `CASGOR /N` |  |  |
| Pac-Mania (1988)(Grandslam Entertainments)[BLOAD'CAS-',R] | Yes | `CASGOI /S` |  |  |
| Pac-Mania (Grandslam) (Zafiro) / Pac-Mania (Grandslam) (Zafiro) [\_] [LOADERFIX].cas | Yes | `CASGOI /S` |  |  |
| Pac-Mania (Grandslam) (Zafiro) [BLOAD'CAS-',R] [\_] / Pac-Mania (Grandslam) (Zafiro) [BLOAD'CAS-',R] [\_] [LOADERFIX].cas | Yes | `CASGOI /S` |  |  |
| Paises de America (1984)(Sony)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Paises de Asia (1984)(Sony)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Panel Panic (1986)(Eaglesoft)[a][RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Panel Panic (1986)(Eaglesoft)[RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Panic The Train (1984)(Centralsoft) | Yes | `CASGOR` |  |  |
| Panique (1986)(Eaglesoft)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Paris-Dakar (1988)(Zigurat Software)(es)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Passing Shot (1989)(Image Works)[BLOAD'CAS-',R] | Yes | `CASGOI /S` |  |  |
| Pastfinder (1984)(Activision)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Payaso Explorador, El (1986)(Anaya Multimedia)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Pentagram (1986)(Ultimate Play The Game)[BLOAD'CAS-',R] | Yes | `CASGOT /C` |  |  |
| Pepe Saltarin (1986)(Grupo de Trabajo Software)(es)[a][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Pepe Saltarin (1986)(Grupo de Trabajo Software)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Perico Delgado Maillot Amarillo (1989)(Topo Soft)(es)(Side A)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| PERT (1986)(DIMensionNEW)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Pescador Espacial, El (1986)(Anaya Multimedia)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Peter Beardsley's International Football (1988)(Grandslam Entertainments)[BLOAD'CAS-',R] | Yes | `CASGOI /S` |  |  |
| Phantis (1987)(Dinamic Software)(es)(Side A)[a][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Phantis (1987)(Dinamic Software)(es)(Side A)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Phantomas 2 (1986)(Dinamic)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Phantomas 2 (1987)(Dinamic Software)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Pharaoh's Revenge (1988)(Eurosoft)[a][RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Pharaoh's Revenge (1988)(Eurosoft)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Phfile (19xx)(Philips)(es)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Pico Pico (1983)(Micro Cabin)[a][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Pico Pico (1983)(Micro Cabin)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Pico Pico (Micro Cabin) (Toshiba) (Japan) [CLOAD-RUN] [\_] | Yes | `CASGOR` |  |  |
| Pico Pico (Side A) (Micro Cabin) (Toshiba) (Japan) [CLOAD-RUN] [\_] | Yes | `CASGOR` |  |  |
| picopico\_toshiba | Yes | `CASGOR` |  |  |
| picopico\_toshiba\_a | Yes | `CASGOR` |  |  |
| picopico\_toshiba\_b | Yes | `CASGOR` |  |  |
| Pinball Blaster (1988)(Eurosoft)[a][RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Pinball Blaster (1988)(Eurosoft)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Pink Panther (1988)(Dro Soft)[RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Pippo La Scopa Ficcanaso (2021)(Gamecast) | Yes | `CASGOR` |  |  |
| Pirates (1988)(Halley Software)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Pitfall II - Lost Caverns (1985)(Activision)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Playhouse Strippoker (1988)(Eurosoft)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Poder Oscuro, El (1988)(Zigurat Software)(es)[RUN'CAS-'] | Yes | `CASGOR /B` |  |  |
| Polar Star (1984)(Micro Cabin)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Polar Star (1984)(Micro Cabin)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Police Academy (1986)(Eaglesoft)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Police Academy II (1987)(Methodic Solutions)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Police Dog (1984)(Hudson Soft) | Yes | `CASGOR` |  |  |
| Poogaboo (1991)(Opera Soft)(es)[a][passworded][BLOAD'CAS-',R] | Yes | `CASGOR /C` |  |  |
| Poogaboo (1991)(Opera Soft)(es)[BLOAD'CAS-',R] | Yes | `CASGOR /C` |  |  |
| Poogaboo (1991)(Opera Soft)(es)[passworded][BLOAD'CAS-',R] | Yes | `CASGOR /C` |  |  |
| Portopia Serial Murder Case (1985)(Enix)(ja)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Post Mortem (1988)(Iber Soft)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Power and Magic (1990)(Zigurat Software)(es)[a][RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Power and Magic (1990)(Zigurat Software)(es)[RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Power Drift (1989)(Activision)(Side A)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Previsiones (1986)(Load 'n' Run)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Principe y el Dragon, El (1985)(Advance)(es)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Professional Baseball Super Simulation (1984)(JDS)(ja)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Professional Snooker Simulator (1987)(Codemasters)(M3)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Professional Tennis Simulator (1990)(Dinamic Software)[aka Simulador Profesional de Tenis][RUN'CAS-'] | Yes | `CASGOT /B` |  |  |
| Project A (1984)(Pony Canyon & Microbyte)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Protector, The (1987)(Eaglesoft)[a][RUN'CAS-'] | Yes | `CASGOI /CB` |  |  |
| Protector, The (1987)(Eaglesoft)[RUN'CAS-'] | Yes | `CASGOI /CB` |  |  |
| Psychedelia (1984)(Aackosoft)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Psycho Pig U.X.B. (1988)(US Gold)[RUN'CAS-'] | Yes | `CASGOR /B` |  |  |
| Punch And Judy (1989)(Alternative Software)[run'CAS-'] | Yes | `CASGOI /CB` |  |  |
| Punchy (1984)(Mr. Micro)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Puzzybox (2021)(Gamecast) | Yes | `CASGOR` |  |  |
| Pwnd 3 (2019) (Metal Soft) (v1.1) [BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Pyramid Warp (1983)(T&E Soft)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Pyro-Man (Nice Ideas)(1985)(Fr)[Cload + Run] | Yes | `CASGOR` |  |  |
| Quartet (2019) (Ilkke and bitsofbas) (v1.1) [BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Quartet (2019) (Ilkke and bitsofbas) [BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Quebert (1988)(Eurosoft)[a2][RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Quebert (1988)(Eurosoft)[a][RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Quebert (1988)(Eurosoft)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Queen's Golf (1984)(Ascii)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| R.A.M. (1990)(Topo Soft)(es)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Race City (1988)(Iber Soft)(es)[RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Rally-X (1984)(Bug-Byte Software)[BLOAD'CAS-',R] | Yes | `CASGOR /N` |  |  |
| Rambo III (1988)(Ocean Software)(Side A)[a][BLOAD'CAS-',R] | Yes | `CASGOI /C` |  |  |
| Rambo III (1988)(Ocean Software)(Side A)[BLOAD'CAS-',R] | Yes | `CASGOI /C` |  |  |
| Rambo III (1988)(Ocean Software)[BLOAD'CAS-',R] | Yes | `CASGOI /C` |  |  |
| Rampart, The (1988)(Iber Soft)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Rath-Tha (1989)(Positive)(es)[RUN'CAS-'] | Yes | `CASGOR /B` |  |  |
| Red Dawn (1988)(Eurosoft)[a][RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Red Dawn (1988)(Eurosoft)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Red Moon (1985)(Level 9 Computing)[RUN'CAS-',R] | Yes | `CASGOR /B` |  |  |
| Reflex (1987)(Players Software)(Side A)[a2][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Reflex (1987)(Players Software)(Side A)[a][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Reflex (1987)(Players Software)(Side A)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Relics (1986)(Bothtec)(Side A)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Renegade III - The Final Chapter (1989)(Imagine Software)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Rescate Atlantida (1989)(Dinamic Software)(es)(Side A)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Rescate Atlantida (1989)(Dinamic Software)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Rescate en el Golfo (1990)(Opera Soft)(es)(Side A)[a][BLOAD'CAS-',R] | Yes | `CASGOR /C` |  |  |
| Rescate en el Golfo (1990)(Opera Soft)(es)(Side A)[BLOAD'CAS-',R] | Yes | `CASGOR /C` |  |  |
| Rescate en el Golfo (1990)(Opera Soft)(es)(Side A)[passworded][BLOAD'CAS-',R] | Yes | `CASGOR /C` |  |  |
| Return To Eden (1984)(Level 9 Computing)[RUN'CAS-',R] | Yes | `CASGOR /CB` |  |  |
| Risky Holding (1986)(DIMensionNEW)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| River Chase (1984)(Soft Pro International)(JP)(en)[!][CLOAD + RUN][v0.8.5b] | Yes | `CASGOR` |  |  |
| River Chase (Soft Pro International) [v0.8.5b fixed] [CLOAD + RUN] | Yes | `CASGOR` |  |  |
| River Raid (1984)(Activision)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Robocop (1988)(Ocean Software)(Side A)[BLOAD'CAS-',R] | Yes | `CASGOI /C` |  |  |
| Robot Wars (1986)(Eaglesoft)[RUN'CAS-'] | Yes | `CASGOT /B` |  |  |
| Robot Wars (ByteBusters) (Aackosoft - Eaglesoft) (Compulogical) [\_] | Yes | `CASGOT /B` |  |  |
| Roboy (1987)(Methodic Solutions)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Rock 'n Roller (1988)(Topo Soft)(es)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Rocky (1985)(Dinamic Software)(es)[a][RUN'CAS-'] | Yes | `CASGOI /B14` |  |  |
| Rocky (1985)(Dinamic Software)(es)[RUN'CAS-'] | Yes | `CASGOI /B14` |  |  |
| Rodman demo - Misfit (2018) | Yes | `CASGOR` |  |  |
| Roller (1987)(Triosoft)[RUN'CAS-',r] | Yes | `CASGOI /B` |  |  |
| Roma - La Conquista del Imperio (1986)(Idealogic)(es)[RUN'CAS-'] | Yes | `CASGOR /B` |  |  |
| Roulette (Side A) (Spectravideo) [\_] [CLOAD-RUN] | Yes | `CASGOR` |  |  |
| Roulette (Spectravideo) [\_] [CLOAD-RUN] | Yes | `CASGOR` |  |  |
| RSC Ensamblador (19xx)(Manhattan Transfer)(es)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Runner (1986)(Loriciels)(fr)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Running Man, The (1989)(Grandslam Entertainments)(es)(Side A)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Ruptus (2021)(Inufuto) | Yes | `CASGOR` |  |  |
| Sabotaje (1988)(P.J. Software)(es)[a][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Sabotaje (1988)(P.J. Software)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Saboteur 2 (2026)(Clive Townsend)(Port by Thealfest) | Yes | `CASGOR /CB` |  |  |
| Saboteur 2 v1.02 (2026)(Clive Townsend)(Port by Thealfest) | Yes | `CASGOR /CB` |  |  |
| Sabrina (1989)(Iber Soft)(es)[RUN'CAS-'] | Yes | `CASGOM` |  |  |
| Saint Dragon (1990)(Dro Soft)(Side A)[RUN'CAS-'] | Yes | `CASGOT /S` |  |  |
| Samantha Fox Strip Poker (1986)(Martech Games)[a][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Satan (1989)(Dinamic Software)(es)(Side A)[RUN'CAS-'] | Yes | `CASGOR /B` |  |  |
| Satan (1989)(Dinamic Software)(Side A)[RUN'CAS-'] | Yes | `CASGOR /B` |  |  |
| Scapeghost - Part 1 (1989)(Level 9 Computing)[RUN'CAS-',R] | Yes | `CASGOT /CB` |  |  |
| Scapeghost - Part 2 (1989)(Level 9 Computing)[RUN'CAS-',R] | Yes | `CASGOT /CB` |  |  |
| Scapeghost - Part 3 (1989)(Level 9 Computing)[RUN'CAS-',R] | Yes | `CASGOT /CB` |  |  |
| Scentipede (1986)(Eaglesoft)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Science Fiction (1986)(Eaglesoft)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Score 3020 (1988)(Topo Soft)(es)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Scrabble(1986)[Leisure Games][RUN'CAS-'] | Yes | `CASGOI /CB` |  |  |
| Scrabble(1986)[Leisure Genius][RUN'CAS-'] | Yes | `CASGOI /CB` |  |  |
| Scramble Spirits (1990)(Grandslam Entertainments)(Side A)[a][BLOAD'CAS-',R] | Yes | `CASGOI /S` |  |  |
| Scramble Spirits (1990)(Grandslam Entertainments)(Side A)[BLOAD'CAS-',R] | Yes | `CASGOI /S` |  |  |
| Sea Bomber (1983)(Hudson Soft)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Sea Hunter (1985)(Spectravideo) | Yes | `CASGOR` |  |  |
| Sea King (1986)(Players Software)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Senda Salvaje (1990)(Zigurat Software)(es)(Side A)[RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Shark Hunter (1984)(Electric Software)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Shinobi (1989)(Virgin Games)(Side A)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Ship (1989)(Eurosoft)(es)[BLOAD'CAS-',R] | Yes | `CASGOR /P4` |  |  |
| Shup. Trebol (1986)(Mind Games Espana)(es)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Silent Shadow (1988)(Topo Soft)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Silfi (1988)(Iber Soft)(es)[aka Elidon][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Silicon Dreams I - Snowball v2 (1986)(Level 9 Computing)[a1 - Cracked][RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| Silicon Dreams I - Snowball v2 (1986)(Level 9 Computing)[a1 - Protected][RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| Silicon Dreams I - Snowball v2 (1986)(Level 9 Computing)[a][RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| Silicon Dreams I - Snowball v2 (1986)(Level 9 Computing)[RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| Silicon Dreams II - Return to Eden (1984)(Level 9 Computing)[BLOAD'CAS-',R] | Yes | `CASGOI /B` |  |  |
| Silicon Dreams II - Return to Eden (1984)(Level 9 Computing)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Silicon Dreams II - Return to Eden v2 (1986)(Level 9 Computing)[a1 - Cracked][RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| Silicon Dreams II - Return to Eden v2 (1986)(Level 9 Computing)[a1 - Protected][RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| Silicon Dreams II - Return to Eden v2 (1986)(Level 9 Computing)[a][RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| Silicon Dreams II - Return to Eden v2 (1986)(Level 9 Computing)[RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| Silicon Dreams III - The Worm in Paradise v2 (1986)(Level 9 Computing)[a1 - Cracked][RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| Silicon Dreams III - The Worm in Paradise v2 (1986)(Level 9 Computing)[a1 - Protected][RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| Silicon Dreams III - The Worm in Paradise v2 (1986)(Level 9 Computing)[a][RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| Silicon Dreams III - The Worm in Paradise v2 (1986)(Level 9 Computing)[RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| Silvestro Spazzino Maldestro - Gianluca Barfi (1986)(it) | Yes | `CASGOR` |  |  |
| Simulador Profesional de Tenis (1990)(Dinamic Software)(es)[RUN'CAS-'] | Yes | `CASGOT /B` |  |  |
| Sir Fred (1986)(Zigurat Software)(es)[RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Sirwood (1990)(Opera Soft)(Side A)[BLOAD'CAS-',R] | Yes | `CASGOR /C` |  |  |
| Sito Pons 500cc Grand Prix (1990)(Zigurat Software)(es)[RUN'CAS-'] | Yes | `CASGOM /CB` |  |  |
| Skate Dragon (1986)(Idealogic)(es)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Skooter (1987)(Eaglesoft)[RUN'CAS-'] | Yes | `CASGOI /C` |  |  |
| Skramble (1985)(Aackosoft)[RUN'CAS-'] | Yes | `CASGOI /CB` |  |  |
| Skramble - Compilation Tape 1 (ByteBusters) (Aackosoft - Eaglesoft) [RUN'CAS-'] [\_] | Yes | `CASGOR /CB` |  |  |
| Skull Exilon (1988)(Iber Soft)[aka Safari X][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Sky Diver (1984)(Hudson Soft) | Yes | `CASGOR` |  |  |
| Sky Vision (1987)(Eaglesoft)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Sky War (1988)(OMK Software)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Skyhawk (1986)(Bug-Byte Software)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Slapshot (1985)(Anirog Software)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Slime Center (2014)(N.I.)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Slot-Machine (1985)(Creating Soft) | Yes | `CASGOR` |  |  |
| sm221 | Yes | `CASGOR` |  |  |
| sm221\_a | Yes | `CASGOR` |  |  |
| sm221\_b | Yes | `CASGOR` |  |  |
| sm245 | Yes | `CASGOR` |  |  |
| sm245\_b | Yes | `CASGOR` |  |  |
| sm330 | Yes | `CASGOR` |  |  |
| sm330\_a | Yes | `CASGOR` |  |  |
| sm330\_b | Yes | `CASGOR` |  |  |
| Smack Wacker (1986)(Eaglesoft)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Smash (1984)(Spectravideo)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Snake It (1986)(Eaglesoft)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Snowball (1986)(Level 9 Computing)[RUN'CAS-',R] | Yes | `CASGOI /CB` |  |  |
| Snowman, The (1984)(Quicksilva)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Soccer Boss (The Boss) (1987)(Alternative Software[CLOAD+RUN] | Yes | `CASGOR` |  |  |
| Sol Negro (1989)(Opera Soft)(es)(Side A)[a][BLOAD'CAS-',R] | Yes | `CASGOR /C` |  |  |
| Sol Negro (1989)(Opera Soft)(es)(Side A)[BLOAD'CAS-',R] | Yes | `CASGOR /C` |  |  |
| Soldier of Light (1989)(Dro Soft)(es)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Solo (1989)(Opera Soft)(es)[gunstick][BLOAD'CAS-',R] | Yes | `CASGOR /C` |  |  |
| Sootland (1988)(Zafiro Software Division)(es)(Side A)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Sorcery (1985)(Virgin Games)[a][RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Sorcery (1985)(Virgin Games)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Soul of a Robot (1987)(Mastertronic)[RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Soviet (1990)(Opera Soft)(Side A)[BLOAD'CAS-',R] | Yes | `CASGOR /C` |  |  |
| Soviet (1990)(Opera Soft)(Side A)[BLOAD'CAS-',R]-FX2A | Yes | `CASGOR /C` |  |  |
| Space Busters (1985)(Aackosoft)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Space Busters (1986)(Eaglesoft)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Space Busters - Compilation Tape 1 (ByteBusters) (Aackosoft - Eaglesoft) [RUN'CAS-'] [\_] | Yes | `CASGOR` |  |  |
| Space Harrier II (1990)(Grandslam)(GB)(Side A)[BLOAD'CAS\_',R] | Yes | `CASGOI /S` |  |  |
| Space Rescue (1988)(Eurosoft)[a2][RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Space Rescue (1988)(Eurosoft)[a][RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Space Rescue (1988)(Eurosoft)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Space Rescue - MSX Compilation 5 (ByteBusters) (Aackosoft - Eaglesoft) [RUN'CAS-'] [\_] | Yes | `CASGOR /CB` |  |  |
| Space Shuttle - A Journey into Space (1986)(Activision)[b][BLOAD'CAS-',R] | Yes | `CASGOI /N` |  |  |
| Space Smugglers (1989)(MHT Ingenieros)(es)[gunstick][RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Space Walk (1985)(Mastertronic)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Spartan X (1985)(Pony Canyon)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Special Operations (1985)(MC Lothlorien)[a][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Special Operations (1985)(MC Lothlorien)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Spectravideo SVI-728 Introduction-Demonstration (1984)(Spectravideo) | Yes | `CASGOR` |  |  |
| Speed King (1986)(Mastertronic)[a][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Speed King (1986)(Mastertronic)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Speedboat Racer (1987)(Methodic Solutions)[RUN'CAS-'] | Yes | `CASGOR /B` |  |  |
| Spellbound (2023)(Mastropiero) | Yes | `CASGOR` |  |  |
| Spellbound (2023)(Mastropiero)[BLOAD'CAS-',R][Bugfix 11-02-2024] | Yes | `CASGOR /B` |  |  |
| Spirits (1987)(Topo Soft)(es)[RUN'CAS-'] | Yes | `CASGOI /CB` |  |  |
| Spitfire '40 (1986)(Mirrorsoft)[RUN'CAS-'] | Yes | `CASGOM /CB` |  |  |
| Splash (1986)(Mind Games Espana)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Spy Story (1986)(Aackosoft)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Spy vs Spy II - The Island Caper (1987)(Databyte)[a][RUN'CAS-'] | Yes | `CASGOM /CB` |  |  |
| Spy vs Spy II - The Island Caper (1987)(Databyte)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Squash 1986 (Robtek Software) [CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Star Bowls (1991)(Zigurat Software)(es)[RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Star Fighter (1986)(Eaglesoft)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Star Fighter (Battleship Clapton II Hack) (1986)(Visiogame)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Star Runner (1986)(Manhattan Transfer)(es)[a][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Star Runner (1986)(Manhattan Transfer)(es)[b][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Star Runner (1986)(Manhattan Transfer)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Star Wars (1986)(Eaglesoft)[a][RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Star Wars (1986)(Eaglesoft)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Starbuggy (1988)(Eurosoft)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Starbuster (1988)(Methodic Solutions)[RUN'CAS-'] | Yes | `CASGOI /CB` |  |  |
| Starbyte (1987)(Mister Chip)(es)[RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Stardust (1987)(Topo Soft)(es)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Starquake (1986)(Bubblebus Software)[a][RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Starquake (1986)(Bubblebus Software)[RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Steve Davis Snooker (1985)(CDS Microsystems)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Stop Ball (1987)(Dro Soft)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Stop the Express (Hudson) (Aackosoft - Eaglesoft) [RUN'CAS-'] [\_] | Yes | `CASGOR` |  |  |
| Storm - Una's Lair (1986)(Mastertronic)[a][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Storm - Una's Lair (1986)(Mastertronic)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Stormbringer (1987)(Mastertronic Added Dimension)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Stormbringer (1987)(Mastertronic)[a] | Yes | `CASGOR` |  |  |
| Streaker (1987)(Bulldog)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Strip Poker II+ (1988)(Anco Software)(Side A)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Strip Poker II+ (1988)(Anco Software)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Submarine Shooter (1983)(Hudson Soft)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Super Boy I  [BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Super Boy II  [BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Super Chess (1984)(Kuma Computers)[a][BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Super Chess (1984)(Kuma Computers)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Super Difficult Theseus (1985)(Login Soft)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Super Doors (1983)[BLOAD'CAS',r] | Yes | `CASGOR` |  |  |
| Super Ilevan (POPCOM 1987-04) | Yes | `CASGOR` |  |  |
| Super MSX n.1 (maggio 1987) - cas\_1 | Yes | `CASGOT /B` |  |  |
| Super MSX n.10 (marzo 1988) - cas\_10 / super\_msx\_10\_lato\_A.cas | Yes | `CASGOI /S` |  |  |
| Super MSX n.10 (marzo 1988) - cas\_10 / super\_msx\_10\_lato\_B.cas | Yes | `CASGOI /S` |  |  |
| Super MSX n.11 (Aprile 1988) - cas\_11 / super\_msx\_11\_lato\_A.cas | Yes | `CASGOI /S` |  |  |
| Super MSX n.11 (Aprile 1988) - cas\_11 / super\_msx\_11\_lato\_B.cas | Yes | `CASGOI /S` |  |  |
| Super MSX n.12 (Maggio 1988) - cas\_12 / super msx 12a.cas | Yes | `CASGOI /S` |  |  |
| Super MSX n.12 (Maggio 1988) - cas\_12 / super msx 12b.cas | Yes | `CASGOI /S` |  |  |
| Super MSX n.13 (Giugno 1988) - cas\_13 / super\_msx\_13\_lato\_A.cas | Yes | `CASGOI /S` |  |  |
| Super MSX n.13 (Giugno 1988) - cas\_13 / super\_msx\_13\_lato\_B.cas | Yes | `CASGOI /S` |  |  |
| Super MSX n.14 (settembre 1988) - cas\_14 / super\_msx\_14\_lato\_A.cas | Yes | `CASGOI /S` |  |  |
| Super MSX n.14 (settembre 1988) - cas\_14 / super\_msx\_14\_lato\_B.cas | Yes | `CASGOI /S` |  |  |
| Super MSX n.15 (ottobre 1988) - cas\_15 / SUPER15A.CAS | Yes | `CASGOI /S` |  |  |
| Super MSX n.15 (ottobre 1988) - cas\_15 / SUPER15B.CAS | Yes | `CASGOI /S` |  |  |
| Super MSX n.16 (novembre 1988) - cas\_16 / super\_msx\_16\_lato\_A.cas | Yes | `CASGOI /S` |  |  |
| Super MSX n.16 (novembre 1988) - cas\_16 / super\_msx\_16\_lato\_B.cas | Yes | `CASGOI /S` |  |  |
| Super MSX n.17 (dicembre 1988) - cas\_17 / super\_msx\_17\_lato\_A.cas | Yes | `CASGOI /B` |  |  |
| Super MSX n.17 (dicembre 1988) - cas\_17 / super\_msx\_17\_lato\_B.cas | Yes | `CASGOI /CB` |  |  |
| Super MSX n.18 (gennaio 1989) - cas\_18 / SuperMSX18-LatoA.CAS | Yes | `CASGOI /B13` |  |  |
| Super MSX n.18 (gennaio 1989) - cas\_18 / SuperMSX18-LatoB.CAS | Yes | `CASGOR /CB` |  |  |
| Super MSX n.19 (febbraio 1989) - cas\_19 / super msx 19 lato A.cas | Yes | `CASGOM /B` |  |  |
| Super MSX n.19 (febbraio 1989) - cas\_19 / super msx 19 lato B.cas | Yes | `CASGOI /CB` |  |  |
| Super MSX n.2 (giugno 1987) - cas\_2 / super msx 2a.cas | Yes | `CASGOR` |  |  |
| Super MSX n.2 (giugno 1987) - cas\_2 / super msx 2b.cas | Yes | `CASGOR` |  |  |
| Super MSX n.20 (aprile 1989) - cas\_20 / SuperMSX20-LatoA.cas | Yes | `CASGOI /B` |  |  |
| Super MSX n.20 (aprile 1989) - cas\_20 / SuperMSX20-LatoB.cas | Yes | `CASGOI /B` |  |  |
| Super MSX n.21 (maggio 1989) - cas\_21 / super\_msx\_21\_lato\_A.cas | Yes | `CASGOI /S` |  |  |
| Super MSX n.21 (maggio 1989) - cas\_21 / super\_msx\_21\_lato\_B.cas | Yes | `CASGOI /CB` |  |  |
| Super MSX n.22 (giugno 1989) - cas\_22 / Aliantantor dump di Andrea bendoni.cas | Yes | `CASGOM /B` |  |  |
| Super MSX n.22 (giugno 1989) - cas\_22 / SUPER22.CAS | Yes | `CASGOI /S` |  |  |
| Super MSX n.22 (giugno 1989) - cas\_22 / SUPER22B.CAS | Yes | `CASGOI /CB` |  |  |
| Super MSX n.23 (settembre 1989) - cas\_23 / super\_msx\_23\_lato\_A.CAS | Yes | `CASGOI /CB` |  |  |
| Super MSX n.23 (settembre 1989) - cas\_23 / super\_msx\_23\_lato\_B.CAS | Yes | `CASGOI /CB` |  |  |
| Super MSX n.24 (ottobre 1989) - cas\_24 / super24latoa.cas | Yes | `CASGOI /B` |  |  |
| Super MSX n.24 (ottobre 1989) - cas\_24 / super24latob.cas | Yes | `CASGOI /B` |  |  |
| Super MSX n.25 (Dicembre 1989) - cas\_25 / super\_msx\_25\_lato\_A.cas | Yes | `CASGOI /B` |  |  |
| Super MSX n.25 (Dicembre 1989) - cas\_25 / super\_msx\_25\_lato\_B.cas | Yes | `CASGOR /CB` |  |  |
| Super MSX n.26 (Gennaio 1990) - cas\_26 / super26max.cas | Yes | `CASGOI /B` |  |  |
| Super MSX n.26 (Gennaio 1990) - cas\_26 / super26max2.cas | Yes | `CASGOI /CB` |  |  |
| Super MSX n.27 (febbraio 1990) - cas\_27 | Yes | `CASGOR /CB` |  |  |
| Super MSX n.3 (luglio-agosto 1987) - cas\_3 | Yes | `CASGOR` |  |  |
| Super MSX n.4 (settembre 1987) - cas\_4 / super\_msx\_4\_lato\_A.cas | Yes | `CASGOI /S` |  |  |
| Super MSX n.4 (settembre 1987) - cas\_4 / super\_msx\_4\_lato\_B.cas | Yes | `CASGOI /S` |  |  |
| Super MSX n.5 (ottobre 1987) - cas\_5 / SUPER05A.CAS | Yes | `CASGOI /S18` |  |  |
| Super MSX n.5 (ottobre 1987) - cas\_5 / SUPER15B.CAS | Yes | `CASGOI /S` |  |  |
| Super MSX n.6 (novembre 1987) - cas\_6 / super\_msx\_6\_lato\_A.cas | Yes | `CASGOT /S` |  |  |
| Super MSX n.7 (dicembre 1987) - cas\_7 / super\_msx\_7\_lato\_A.cas | No | `CASGOI /S` | Q |  |
| Super MSX n.7 (dicembre 1987) - cas\_7 / super\_msx\_7\_lato\_B.cas | Yes | `CASGOI /S` |  |  |
| Super MSX n.8 (gennaio 1988) - cas\_8 / super\_msx\_8\_lato\_A.cas | Yes | `CASGOI /S` |  |  |
| Super MSX n.8 (gennaio 1988) - cas\_8 / super\_msx\_8\_lato\_B.cas | Yes | `CASGOI /S` |  |  |
| Super MSX n.9 (febbraio 1988) - cas\_9 / SUPER09A.CAS | Yes | `CASGOI /S` |  |  |
| Super MSX n.9 (febbraio 1988) - cas\_9 / SUPER09B.CAS | Yes | `CASGOM /S` |  |  |
| Super Pac-Man (1982 & 2026)(Namco & Mastropiero) | Yes | `CASGOR` |  |  |
| Super Pachinko (Columbia) (Japan) [BLOAD'CAS-',R] [\_] | Yes | `CASGOR` |  |  |
| Super Racer (1985)(Login Soft)[BLOAD'CAS-',R or BLOAD'CAS-'+CLOAD+RUN] | Yes | `CASGOR` |  |  |
| Super Sprites (1986)(Idealogic)(es)[RUN'CAS-'] | Yes | `CASGOI` |  |  |
| Superbowl (1985)(Budgie Budget Software)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Supermaze (1984)[Morwood Software][CLOAD] | Yes | `CASGOR` |  |  |
| Survivor (1987)(Topo Soft)(es)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Survivors (1986)(Atlantis Software)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Swing Man (Side A) (Spectravideo) [\_] [CLOAD-RUN] | Yes | `CASGOR` |  |  |
| Swing Man (Spectravideo) [\_] [CLOAD-RUN] | Yes | `CASGOR` |  |  |
| SWIV (1991)(Dro Soft)(Side A)[needs 128k][RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| SwordWork (2026)(Inufuto) | Yes | `CASGOR` |  |  |
| Tai-Pan (1987)(Ocean Software)(Side A)[RUN'CAS-'] | Yes | `CASGOI /CB` |  |  |
| Take the B Train (198x)(Atorasu) | Yes | `CASGOR` |  |  |
| Tales of Popolon (2017)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Tales Of Popolon (v1.2)(2017)(EN) [BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Tales Of Popolon (v1.2)(2017)(ES)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Tales Of Popolon (v1.3)(2017)(EN) [BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Tales Of Popolon (v1.3)(2017)(ES)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Tank (1986)[Run'cas-',r / MSX Tank alkuperN╠âisen taso 2 korjattu.cas | Yes | `CASGOR` |  |  |
| Tank (1986)[Run'cas-',r / MSX Tank.cas | Yes | `CASGOR` |  |  |
| Tank Battalion (1984)(Bug-Byte Software)[BLOAD'CAS-',R] | Yes | `CASGOR /N` |  |  |
| Target Plus (1988)(Dinamic Software)(es)[gunstick][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Tasword (1985)(Sony)(es)[RUN'CAS-'] | Yes | `CASGOI /CB` |  |  |
| Tawara (1984)(Ascii)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Teach Yourself Basic(1985)(Toshiba)(Side A) | Yes | `CASGOR` |  |  |
| Teach Yourself Basic(1985)(Toshiba)(Side A)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Teenage Mutant Hero Turtles (1990)(Image Works)[passworded][RUN'CAS-'] | Yes | `CASGOT /B` |  |  |
| Teenage Mutant Hero Turtles (1990)(Image Works)[RUN'CAS-'] | Yes | `CASGOT /B` |  |  |
| Temptations (1988)(Topo Soft)(es)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Temptations - Toposoft (1988)(Alternative version by Xesco) | Yes | `CASGOI /S` |  |  |
| Tenebra (2023)(Haplo) | Yes | `CASGOR` |  |  |
| Tenebra (2023)(Haplo)[No Keyclick] | Yes | `CASGOR` |  |  |
| Tension (1988)(System 4)(es)[RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Terminus - The Prison Planet (1987)(Mastertronic)[RUN'CAS',R] | Yes | `CASGOR` |  |  |
| Terrahawks (2020) (Anemotionalfish) [BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Terramex (1988)(Grandslam Entertainments)[BLOAD'CAS-',R] | Yes | `CASGOI /S` |  |  |
| Terrorpods (1989)(Dro Soft)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Test de Adaptacion (1984)(DIMensionNEW)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Test de Capacidad de Concentracion (1984)(DIMensionNEW)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Test de Caracter (1984)(DIMensionNEW)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Test Drive II - The Duel (1989)(Dro Soft)[a][RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Test Drive II - The Duel (1989)(Dro Soft)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Tetris (MirrorSoft) (MCM) [RUN'CAS-'] [\_] | Yes | `CASGOR` |  |  |
| The Archers - Part 1 (1985)(Level 9 Computing)[RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| The Archers - Part 2 (1985)(Level 9 Computing)[RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| The Archers - Part 3 (1985)(Level 9 Computing)[RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| The Archers - Part 4 (1985)(Level 9 Computing)[RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| The Elves of Maroland (2024)(Kame Soft)[Tape 1] | Yes | `CASGOI /S` |  |  |
| The Growing Pains Of Adrian Mole (1987) (Level 9 Computing) / The Growing Pains of Adrian Mole 1 y 2.CAS | Yes | `CASGOT /CB` |  |  |
| The Growing Pains Of Adrian Mole (1987) (Level 9 Computing) / The Growing Pains of Adrian Mole 3 y 4.CAS | Yes | `CASGOT /CB` |  |  |
| The Growing Pains Of Adrian Mole - Part 1 (1987) (Level 9 Computing)[RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| The Growing Pains Of Adrian Mole - Part 2 (1987) (Level 9 Computing)[RUN'CAS-'] | Yes | `CASGOT /B` |  |  |
| The Growing Pains Of Adrian Mole - Part 3 (1987) (Level 9 Computing)[RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| The Growing Pains Of Adrian Mole - Part 4 (1987) (Level 9 Computing)[RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| The Ice King (1986)(CDS Software) | Yes | `CASGOM /B` |  |  |
| The Keiba - Champion Soft (1986) [Push F5 After 2nd Load] | Yes | `CASGOR` |  |  |
| The Munsters (1988)(Alternative Software) | Yes | `CASGOI /S` |  |  |
| The Price Of Magik (1986)(Level 9 Computing)[RUN'CAS-',R] | Yes | `CASGOT /CB` |  |  |
| The Queens Footsteps (2020) (Davide Bucci)[RUN'CAS-',R] | Yes | `CASGOR` |  |  |
| The Queens Footsteps Part 1 (2020)(Davide Bucci)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| The Queens Footsteps Part 2 (2020)(Davide Bucci)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| The Queens Footsteps Part 3 (2020)(Davide Bucci)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| The Scramble (1983) (Marufune FSL) | Yes | `CASGOI /B` |  |  |
| The Secret Diary of Adrian Mole Aged 13¾ - Part I (1985)(Level 9 Computing)[a][RUN'CAS-'] | Yes | `CASGOR /B` |  |  |
| The Secret Diary of Adrian Mole Aged 13¾ - Part I (1985)(Level 9 Computing)[RUN'CAS-'] | Yes | `CASGOR /B` |  |  |
| The Secret Diary of Adrian Mole Aged 13¾ - Part II (1985)(Level 9 Computing)[a][RUN'CAS-'] | Yes | `CASGOR /B` |  |  |
| The Secret Diary of Adrian Mole Aged 13¾ - Part II (1985)(Level 9 Computing)[RUN'CAS-'] | Yes | `CASGOR /B` |  |  |
| The Secret Diary of Adrian Mole Aged 13¾ - Part III (1985)(Level 9 Computing)[a][RUN'CAS-'] | Yes | `CASGOR /B` |  |  |
| The Secret Diary of Adrian Mole Aged 13¾ - Part III (1985)(Level 9 Computing)[RUN'CAS-'] | Yes | `CASGOR /B` |  |  |
| The Secret Diary of Adrian Mole Aged 13¾ - Part IV (1985)(Level 9 Computing)[a][RUN'CAS-'] | Yes | `CASGOR /B` |  |  |
| The Secret Diary of Adrian Mole Aged 13¾ - Part IV (1985)(Level 9 Computing)[RUN'CAS-'] | Yes | `CASGOR /B` |  |  |
| The Storekeeper [RUN'CAS-'] | Yes | `CASGOR` |  |  |
| The Temptation Of The Apartment Wife (1986)(Koei)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| The Tomato Princess From Salad Land Part 1 (Side 1A)(1985)(Hudson Soft)(BLOAD'CAS-',R) | Yes | `CASGOR` |  |  |
| The Tomato Princess From Salad Land Part 2 (Side 1B)(1985)(Hudson Soft)(BLOAD'CAS-',R) | Yes | `CASGOR` |  |  |
| The Tomato Princess From Salad Land Part 3 (Side 2A)(1985)(Hudson Soft)(BLOAD'CAS-',R) | Yes | `CASGOR` |  |  |
| The Tomato Princess From Salad Land Part 4 (Side 2B)(1985)(Hudson Soft)(BLOAD'CAS-',R) | Yes | `CASGOR` |  |  |
| The Way Of The Tiger (1986)(Gremlin Graphics Software)(GB)(Tape 1 of 2 Side A - Master Program)[BLOAD'CAS-',R] | Yes | `CASGOI /S` |  |  |
| The Way Of The Tiger (忍者タイガー) (1986)(Tomo Soft International)(Tape 1 Side A - Master Program)[BLOAD'CAS-',R] | Yes | `CASGOI /S` |  |  |
| The Worm In Paradise (1985)(Level 9 Computing)[RUN'CAS-',R] | Yes | `CASGOR /B` |  |  |
| Thexder (1986)(Eaglesoft)[RUN'CAS-'] | Yes | `CASGOI /CB` |  |  |
| Thing Bounces Back (1987)(Gremlin Graphics Software)[BLOAD'CAS-',R] | Yes | `CASGOI /S` |  |  |
| Thor (1988)(Proein Soft Line)(es)[RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Thunder Blade (1988)(US Gold)(Side A)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Time and Magik I - Lords of Time v2 (1988)(Level 9 Computing)[Cracked][RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| Time and Magik I - Lords of Time v2 (1988)(Level 9 Computing)[Protected][RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| Time and Magik I - Lords of Time v2(1988)(Level 9 Computing)[RUN'CAS-',r] | Yes | `CASGOT /CB` |  |  |
| Time and Magik II - Red Moon (1985)(Level 9 Computing)[RUN'CAS-'] | Yes | `CASGOR /B` |  |  |
| Time and Magik II - Red Moon v2 (1988)(Level 9 Computing)[Cracked][RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| Time and Magik II - Red Moon v2 (1988)(Level 9 Computing)[Protected][RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| Time and Magik II - Red Moon v2(1988)(Level 9 Computing)[RUN'CAS-',r] | Yes | `CASGOT /CB` |  |  |
| Time and Magik III - The Price of Magik v2 (1988)(Level 9 Computing)[Cracked][RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| Time and Magik III - The Price of Magik v2 (1988)(Level 9 Computing)[Protected][RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| Time and Magik III - The Price of Magik v2(1988)(Level 9 Computing)[RUN'CAS-',r] | Yes | `CASGOT /CB` |  |  |
| Time Bandits (1984)(PSS)[a][BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Time Bandits (1984)(PSS)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Time Bomb (1987)(Methodic Solutions)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Time Curb (1986)(Aackosoft)[a][RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Time Curb (1986)(Aackosoft)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Time Out (1988)(Zafiro Software Division)(es)[RUN'CAS-'] | Yes | `CASGOR /S` |  |  |
| Time Rider (1988)(Eurosoft)[a][RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Time Rider (1988)(Eurosoft)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Time Scanner (1989)(Activision)[BLOAD'CAS-',R] | Yes | `CASGOI /S` |  |  |
| Time Trax (1986)(Bug-Byte Software)[a][RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Time Trax (1986)(Bug-Byte Software)[RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Tiny Rise Out (1983)(ASCII) | Yes | `CASGOR` |  |  |
| Titanic (1988)(Topo Soft)(es)(Side A)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Toi Acid Game (1989)(Iber Soft)(es)(Side A)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Tokyo Gang (1990)(G.LL. Software)(es)[RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Tokyo Nampa Street (ENIX, 1986) / NAMPA-A.CAS | Yes | `CASGOR` |  |  |
| Tom & Jerry (1989)(Erbe Software)(es)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Toobin' (1989)(Domark)[a][BLOAD'CAS-',R] | Yes | `CASGOI /S` |  |  |
| Toobin' (1989)(Domark)[BLOAD'CAS-',R] | Yes | `CASGOI /S` |  |  |
| Torreoscura - Part 1 (Bieno Marti & Pedro Fernández)(es) | Yes | `CASGOI /S` |  |  |
| Torreoscura - Part 2 (Bieno Marti & Pedro Fernández)(es) | Yes | `CASGOI /S` |  |  |
| Tour 91 (1991)(Topo Soft)(es)(Side A)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| TrackAndField1[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| TrackAndField2[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Trailblazer (1986)(Gremlin Graphics Software)[BLOAD'CAS-',R] | Yes | `CASGOT /S` |  |  |
| Trailblazer (1986)(Gremlin Graphics Software)[RUN'CAS-'] | Yes | `CASGOT /B` |  |  |
| Transball (2016)(Santi Ontanon)[RUN'CAS-'] | Yes | `CASGOT /B` |  |  |
| transball-en [Bload'cas-',r] | Yes | `CASGOT /B` |  |  |
| Trantor - The Last Stormtrooper (1987)(Go!)[a2][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Trantor - The Last Stormtrooper (1987)(Go!)[a][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Trantor - The Last Stormtrooper (1987)(Go!)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Trapox (2021)(Gamecast) | Yes | `CASGOR` |  |  |
| Tras El Unicornio (1987)(Azimut Soft) | Yes | `CASGOR` |  |  |
| Tres Luces de Glaurung, Las (1986)(Erbe Software)(es)[RUN'CAS-'] | Yes | `CASGOI /CB` |  |  |
| Trick Boy. Pinball (1984)(T&E Soft)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Triple Comando (1988)(Dro Soft)(es)(Side A)[RUN'CAS-'] | Yes | `CASGOM /S` |  |  |
| Tritorn (1986)(Xain)[CLOAD + RUN] | Yes | `CASGOM` |  |  |
| Trivial Pursuit (1986)(Domark)(es)(Side A)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| TT Racer (1987)(Methodic Solutions)[a][RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| TT Racer (1987)(Methodic Solutions)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Tuareg (1988)(Topo Soft)(es)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Turbo Girl (1988)(Dinamic Software)(es)[a2][RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Turbo Girl (1988)(Dinamic Software)(es)[a][RUN'CAS-'] | Yes | `CASGOI` |  |  |
| Turbo Girl (1988)(Dinamic Software)(es)[RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Turbo Pack A (1987)(Philips)(es) / 001-Aritmo.cas | Yes | `CASGOR` |  |  |
| Turbo Pack A (1987)(Philips)(es) / 002-Black Jack.cas | Yes | `CASGOR` |  |  |
| Turbo Pack A (1987)(Philips)(es) / 003-Test de capacidad.cas | Yes | `CASGOR` |  |  |
| Turbo Pack A (1987)(Philips)(es) / 004-Test de adaptacion.cas | Yes | `CASGOR` |  |  |
| Turbo Pack A (1987)(Philips)(es) / 005-El gerente.cas | Yes | `CASGOR` |  |  |
| Turbo Pack A (1987)(Philips)(es) / 006-Domino.cas | Yes | `CASGOR` |  |  |
| Turbo Pack A (1987)(Philips)(es) / 007-Graficos de gestion.cas | Yes | `CASGOR` |  |  |
| Turbo Pack A (1987)(Philips)(es) / 008-Hoja de calculo.cas | Yes | `CASGOR` |  |  |
| Turbo Pack A (1987)(Philips)(es) / 009-Calculator new.cas | Yes | `CASGOR` |  |  |
| Turbo Pack A (1987)(Philips)(es) / 010-Base de datos.cas | Yes | `CASGOI` |  |  |
| Turbo Pack A (1987)(Philips)(es) / 011-Damas.cas | Yes | `CASGOR` |  |  |
| Turbo Pack A (1987)(Philips)(es) / 012-Test de caracter.cas | Yes | `CASGOR` |  |  |
| Turbo Pack A (1987)(Philips)(es) / 013-Pert.cas | Yes | `CASGOR` |  |  |
| Turbo Pack A (1987)(Philips)(es) / 014-Risky Holding.cas | Yes | `CASGOR` |  |  |
| Turbo Pack A (1987)(Philips)(es) / 015-Bouncing Blocks.cas | Yes | `CASGOR` |  |  |
| Turbo Pack A (1987)(Philips)(es) / 016-Roberto Mate.cas | Yes | `CASGOR` |  |  |
| Turbo Pack A (1987)(Philips)(es) / 017-Mini Super Sprites.cas | Yes | `CASGOI` |  |  |
| Turbo Pack A (1987)(Philips)(es) / 018-Comecocos.cas | Yes | `CASGOR` |  |  |
| Turbo Pack A (1987)(Philips)(es) / 019-Invierte y gana.cas | Yes | `CASGOI /B` |  |  |
| Turbo Pack A (1987)(Philips)(es) / 020-Compra y vende.cas | Yes | `CASGOR` |  |  |
| Turbo Pack A (1987)(Philips)(es) / 021-Smack Wacker.cas | Yes | `CASGOR /CB` |  |  |
| Turbo Pack A (1987)(Philips)(es) / 022-Moonrider.cas | Yes | `CASGOR /CB` |  |  |
| Turbo Pack A (1987)(Philips)(es) / 023-Vestron.cas | Yes | `CASGOR` |  |  |
| Turbo Pack A (1987)(Philips)(es) / 024-Foot Volley.cas | Yes | `CASGOR` |  |  |
| Turbo Pack A (1987)(Philips)(es) / 025-Fire Hawk.cas | Yes | `CASGOR` |  |  |
| Turbo Pack A (1987)(Philips)(es) / 026-Sea King.cas | Yes | `CASGOR` |  |  |
| Turbo Pack A (1987)(Philips)(es) / 027-Faraon.cas | Yes | `CASGOR` |  |  |
| Turbo Pack A (1987)(Philips)(es) / 031-Mazes Unlimited.cas | Yes | `CASGOR /CB` |  |  |
| Turbo Pack A (1987)(Philips)(es) / 032-Robot Wars.cas | Yes | `CASGOT /B` |  |  |
| Turbo Pack A (1987)(Philips)(es) / 033-Juego de la moncloa (cload).cas | Yes | `CASGOR` |  |  |
| Turbo Pack A (1987)(Philips)(es) / 035-Edgy.cas | Yes | `CASGOR` |  |  |
| Turbo Pack A (1987)(Philips)(es) / 036-Contabilidad domestica (Philips, 1987).cas | Yes | `CASGOR` |  |  |
| Turbo Pack A (1987)(Philips)(es) / 037-Los Petalos locos.cas | Yes | `CASGOR` |  |  |
| Turbo Pack A (1987)(Philips)(es) / 038-Geometria, figuras planas y volumenes.cas | Yes | `CASGOR` |  |  |
| Turbo Pack A (1987)(Philips)(es) / 039-War Chess.cas | Yes | `CASGOR` |  |  |
| Turbo Pack A (1987)(Philips)(es) / 040-Skate Dragon.cas | Yes | `CASGOR` |  |  |
| Turbo Pack A (1987)(Philips)(es) / 041-Galaxians.cas | Yes | `CASGOR` |  |  |
| Turbo Pack A (1987)(Philips)(es) / 042-Tratamiento de textos.cas | Yes | `CASGOI /B` |  |  |
| Turbo Pack A (1987)(Philips)(es) / 043-Rios de Espana.cas | Yes | `CASGOR` |  |  |
| Turbo Pack A (1987)(Philips)(es) / 044-Capitales de Espa+a.cas | Yes | `CASGOR` |  |  |
| Turbo Pack A (1987)(Philips)(es) / 045-Idea Type.cas | Yes | `CASGOR` |  |  |
| Turbo Pack A (1987)(Philips)(es) / 046-Idea Type.cas | Yes | `CASGOR` |  |  |
| Turbo Pack A (1987)(Philips)(es) / 047-Gusanoco.cas | Yes | `CASGOR` |  |  |
| Turbo Pack A (1987)(Philips)(es) / 048-VG Estrella.cas | Yes | `CASGOR` |  |  |
| Turbo Pack A (1987)(Philips)(es) / 049-Memorion.cas | Yes | `CASGOR` |  |  |
| Turbo Pack A (1987)(Philips)(es) / 050-Agente Especial.cas | Yes | `CASGOR` |  |  |
| Turbo Pack B (1987)(Philips)(es) / 052-Editor de caracteres.cas | Yes | `CASGOR` |  |  |
| Turbo Pack B (1987)(Philips)(es) / 053-Formula 1.cas | Yes | `CASGOR` |  |  |
| Turbo Pack B (1987)(Philips)(es) / 054-Ovni.cas | Yes | `CASGOR` |  |  |
| Turbo Pack B (1987)(Philips)(es) / 055-Rocket.cas | Yes | `CASGOR` |  |  |
| Turbo Pack B (1987)(Philips)(es) / 057-Azul y rosa.cas | Yes | `CASGOR` |  |  |
| Turbo Pack B (1987)(Philips)(es) / 058-Escape.cas | Yes | `CASGOR` |  |  |
| Turbo Pack B (1987)(Philips)(es) / 059-Invasores.cas | Yes | `CASGOR` |  |  |
| Turbo Pack B (1987)(Philips)(es) / 060-Break.cas | Yes | `CASGOR` |  |  |
| Turbo Pack B (1987)(Philips)(es) / 061-Drum.cas | Yes | `CASGOR` |  |  |
| Turbo Pack B (1987)(Philips)(es) / 062-Kitchen.cas | Yes | `CASGOR` |  |  |
| Turbo Pack B (1987)(Philips)(es) / 063-Heli.cas | Yes | `CASGOR` |  |  |
| Turbo Pack B (1987)(Philips)(es) / 064-Crossing.cas | Yes | `CASGOR` |  |  |
| Turbo Pack B (1987)(Philips)(es) / 065-Snack-Bar.cas | Yes | `CASGOR` |  |  |
| Turbo Pack B (1987)(Philips)(es) / 066-Mouse.cas | Yes | `CASGOR` |  |  |
| Turbo Pack B (1987)(Philips)(es) / 068-Space.cas | Yes | `CASGOR` |  |  |
| Turbo Pack B (1987)(Philips)(es) / 069-Car Race.cas | Yes | `CASGOR` |  |  |
| Turbo Pack B (1987)(Philips)(es) / 070-Poker.cas | Yes | `CASGOR` |  |  |
| Turbo Pack B (1987)(Philips)(es) / 071-Fruit.cas | Yes | `CASGOR` |  |  |
| Turbo Pack B (1987)(Philips)(es) / 072-Jetfighter.cas | Yes | `CASGOR /CB` |  |  |
| Turbo Pack B (1987)(Philips)(es) / 073-Alpha Blaster.cas | Yes | `CASGOR /CB` |  |  |
| Turbo Pack B (1987)(Philips)(es) / 075-Choper 1.cas | Yes | `CASGOR /CB` |  |  |
| Turbo Pack B (1987)(Philips)(es) / 076-Scentipede.cas | Yes | `CASGOR /CB` |  |  |
| Turbo Pack B (1987)(Philips)(es) / 077-Space Rescue.cas | Yes | `CASGOR /CB` |  |  |
| Turbo Pack B (1987)(Philips)(es) / 078-Time Curb.cas | Yes | `CASGOR /CB` |  |  |
| Turbo Pack B (1987)(Philips)(es) / 079 - Editor de Sprites.cas | Yes | `CASGOR` |  |  |
| Turbo Pack B (1987)(Philips)(es) / 080-Othello.cas | Yes | `CASGOR` |  |  |
| Turbo Pack B (1987)(Philips)(es) / 081-Kick It.cas | Yes | `CASGOR /CB` |  |  |
| Turbo Pack B (1987)(Philips)(es) / 082-Panique.cas | Yes | `CASGOR /CB` |  |  |
| Turbo Pack B (1987)(Philips)(es) / 083-Ruleta.cas | Yes | `CASGOR` |  |  |
| Turbo Pack B (1987)(Philips)(es) / 087-Panel Panique.cas | Yes | `CASGOI /B` |  |  |
| Turbo Pack B (1987)(Philips)(es) / 088 - Rompeladrillos.cas | Yes | `CASGOR` |  |  |
| Turbo Pack B (1987)(Philips)(es) / 089-Solfeo.cas | Yes | `CASGOR` |  |  |
| Turbo Pack B (1987)(Philips)(es) / 090-Maziacs.cas | Yes | `CASGOR` |  |  |
| Turbo Pack B (1987)(Philips)(es) / 091-Space Buster.cas | Yes | `CASGOR /CB` |  |  |
| Turbo Pack B (1987)(Philips)(es) / 092-Cubo de Rubick.cas | Yes | `CASGOR` |  |  |
| Turbo Pack B (1987)(Philips)(es) / 093-Ice.cas | Yes | `CASGOR /CB` |  |  |
| Turbo Pack B (1987)(Philips)(es) / 094-Demand.cas | Yes | `CASGOR` |  |  |
| Turbo Pack B (1987)(Philips)(es) / 095-Treppy.cas | Yes | `CASGOR` |  |  |
| Turbo Pack B (1987)(Philips)(es) / 096-Glider.cas | Yes | `CASGOR` |  |  |
| Turbo Pack B (1987)(Philips)(es) / 098-Racer.cas | Yes | `CASGOR` |  |  |
| Turbo Pack B (1987)(Philips)(es) / 099-Alcyon.cas | Yes | `CASGOR` |  |  |
| Turbo Pack B (1987)(Philips)(es) / 100-Artillero.cas | Yes | `CASGOR` |  |  |
| Turbo Pack C (1987)(Philips)(es) / 010 - Comecocos [Idealogic].cas | Yes | `CASGOR` |  |  |
| Turbo Pack C (1987)(Philips)(es) / 017 - Los Pe╠ütalos Locos.cas | Yes | `CASGOR` |  |  |
| Turbo Pack C (1987)(Philips)(es) / 028 - Pucky.cas | Yes | `CASGOR` |  |  |
| Turbo Pack C (1987)(Philips)(es) / 032 - Crossing.cas | Yes | `CASGOR` |  |  |
| Turbo Pack C (1987)(Philips)(es) / 035 - Pyramid (Jojosoft).CAS | Yes | `CASGOR` |  |  |
| Turbo Pack C (1987)(Philips)(es) / 038 - Mac Attack.cas | Yes | `CASGOR /CB` |  |  |
| Turbo Pack C (1987)(Philips)(es) / 039 - Choper I.cas | Yes | `CASGOR /CB` |  |  |
| Turbo Pack C (1987)(Philips)(es) / 040 - Scentipede.cas | Yes | `CASGOR /CB` |  |  |
| Turmoil (1986)(Bug-Byte Software)[a][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Turmoil (1986)(Bug-Byte Software)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Turtles - Konami (1981)[MSX version by André de la Rocha v2] | Yes | `CASGOR` |  |  |
| Turtles - Konami (1981)[MSX version by André de la Rocha] | Yes | `CASGOR` |  |  |
| Tutor (1985)(Sony)(es)(Side A)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Twinlight (2019) (Retrosouls) [BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Typing Tutor (1985)(Sanyo)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| U Boat (1985)(Omega Systems)(ja) | Yes | `CASGOR` |  |  |
| U-Boot (1985)(Manhattan Transfer)(es)[a][CLOAD + RUN] | Yes | `CASGOR` |  |  |
| U-Boot (1985)(Manhattan Transfer)(es)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Uchi Mata (1987)(Martech Games)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Uchi Mata (1987)(Martech Games)[Fixed][CLOAD + RUN] | Yes | `CASGOI /B` |  |  |
| Uchi Mata (1987)(Martech Games)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| UchiMata[+3][NR] | Yes | `CASGOR` |  |  |
| Uchusen Gamma - Usebox.net (2019) | Yes | `CASGOR /CB` |  |  |
| Ulises (1989)(Opera Soft)[BLOAD'CAS-',R] | Yes | `CASGOR /C` |  |  |
| Ultra Chess (1985)(Aackosoft)[a][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Ultra Chess (1985)(Aackosoft)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Underground (1988)(System 4)(es)[RUN'CAS-'] | Yes | `CASGOT /CB` |  |  |
| Untouchables, The (1989)(Erbe Software)(Side A)[a][RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Untouchables, The (1989)(Erbe Software)(Side A)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Vacuumania (1984)(PSS)[a][BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Vacuumania (1984)(PSS)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Valkyr (1985)(Gremlin Graphics Software)[BLOAD'CAS-',R] | Yes | `CASGOI /S` |  |  |
| Vampire (1987)(Codemasters)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Vampire's Empire (1988)(Dro Soft)(es)[a][RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Vampire's Empire (1988)(Dro Soft)(es)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Vampire(1987)(Codemasters)[a][Run'CAS-'] | Yes | `CASGOR` |  |  |
| Vampire(1987)(Codemasters)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Vampiro (1987)(Manhattan Transfer)(es)[RUN'CAS-'] | Yes | `CASGOI` |  |  |
| Vegetable Crash (HoneyBee Soft) (Hudson Soft) (Japan) [BLOAD'CAS-',R] [\_] | Yes | `CASGOR` |  |  |
| Vestron (1986)(Players Software)[a][BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Vestron (1986)(Players Software)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Viaje al Centro de la Tierra (1989)(Topo Soft)(es)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Viaje por Europa (19xx)(Mind Games Espana)(es)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Vicious Viper (1985)(Sanyo)[a2][CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Vicious Viper (1985)(Sanyo)[a][CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Vicious Viper (1985)(Sanyo)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Video Poker (1986)(Disprosoft)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Video Poker (1986)(Mastertronic)[RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Vilzam - Cosmic Struggle (1985) (Yuichi Toyama) | Yes | `CASGOR` |  |  |
| Vilzam - Cosmic Struggle (1985) (Yuichi Toyama)(en) | Yes | `CASGOR` |  |  |
| Virus LQP-79 (2018) (Pentacour) [BLOAD'CAS-',R] | Yes | `CASGOR /B` |  |  |
| Voidrunner (1987)(Mastertronic Added Dimension)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Volguard (1985)(dB-Soft)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Volguard (1985)(dB-Soft)[RUN'CAS-']-patched | Yes | `CASGOR` |  |  |
| Vortex Raider (1988)(Eurosoft)[a][RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Vortex Raider (1988)(Eurosoft)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| W Series 1 (1983) (Hudson Soft)[Side A - Biotech, Killer Station][BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| W Series 2 (1983) (Hudson Soft)[Side A - HELP, Sea Bomber][BLOAD'CAS-',R] | Yes | `CASGOI /C` |  |  |
| W Series 3 (1983) (Hudson Soft)[Side A - Fireball, Akarui Nouen][BLOAD'CAS-',R] | Yes | `CASGOI /C` |  |  |
| W Series 4 (1983) (Hudson Soft)( Side A - Super Doors)[BLOAD'CAS',r] | Yes | `CASGOR` |  |  |
| W Series 5 (1983) (Hudson Soft)(Side A - Submarine Shooter, Gunman)[BLOAD'CAS-',R]. | Yes | `CASGOR` |  |  |
| Wall, The (1987)(Erbe Software)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Wallball (19xx)(Tynesoft)[a][BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Wallball (19xx)(Tynesoft)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Wamp Cola (1988)(Iber Soft)(es)[aka Dracula][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| War Chess (1986)(Idealogic)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| War in Middle Earth (1989)(Dro Soft)(es)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Warp & Warp (1984)(Bug-Byte Software)[BLOAD'CAS-',R] | Yes | `CASGOR /N` |  |  |
| WEC Le Mans (1988)(Imagine Software)[a][RUN'CAS-'] | Yes | `CASGOI /CB` |  |  |
| WEC Le Mans (1988)(Imagine Software)[RUN'CAS-'] | Yes | `CASGOI /CB` |  |  |
| Wells & Fargo (1988)(Topo Soft)(es)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| West Bank (1989)(Dinamic Software)(es)[a][RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| West Bank (1989)(Dinamic Software)(es)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Who Dares Wins II (1986)(Alligata Software)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Wild Cat (1984)(Nippon Columbia) | Yes | `CASGOR` |  |  |
| Wing Man (1985)(Enix)(ja)(Side A)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Winter Events (1987)(Anco Software)[a][CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Winter Olympics (1986)(Tynesoft)(Side A)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Winterhawk (1988)(Eurosoft)[a][RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Winterhawk (1988)(Eurosoft)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| Wizard's Lair (1986)(Bubblebus Software)(M3)[a][CLOAD + RUN] | Yes | `CASGOI` |  |  |
| Wizard's Lair (1986)(Bubblebus Software)(M3)[CLOAD + RUN] | Yes | `CASGOI` |  |  |
| Word Pro v2.60 (1985)(Kuma Computers)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| World Cup Soccer (1986)(Eaglesoft)[a][RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| World Cup Soccer (1986)(Eaglesoft)[RUN'CAS-'] | Yes | `CASGOR /CB` |  |  |
| World Games (1987)(US Gold)(Side A)[RUN'CAS-'] | Yes | `CASGOR /N` |  |  |
| World Map Software For Color Plotter Printer (1985)(Matsushita Electric Industrial)(Side A)[CLOAD] | Yes | `CASGOR` |  |  |
| Worry (1985)(Microcabin) | Yes | `CASGOR` |  |  |
| Wreck, The (1984)(Electric Software) | Yes | `CASGOR` |  |  |
| Wrestling (198x)(Grupo de Trabajo Software)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| X-Racing (2019)(Brain Games)(v1.0)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| X-Racing (2019)(Brain Games)(v1.0.1)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| X-Racing (2019)(Brain Games)(v1.0.2)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| X-Racing (2019)(Brain Games)(v1.0.3)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| X-Racing (2019)(Brain Games)(v1.0.4)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| X-Spellunker (2017)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| X-Spelunker (2017)(Brain Games)(v1.4.2)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Xenon (1988)(Dro Soft)(es)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Xenon(1988)(Melbourne House)[EN][RUN'CAS-'] | Yes | `CASGOI /B` |  |  |
| Xybots (1989)(Domark)[a][BLOAD'CAS-',R] | Yes | `CASGOI /S` |  |  |
| Xybots (1989)(Domark)[BLOAD'CAS-',R] | Yes | `CASGOI /S` |  |  |
| Xyxolog. Xyzolog (1985)(Electric Software)[a][BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Xyxolog. Xyzolog (1985)(Electric Software)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Xyzolog (Electric Software) (Aackosoft) (Side 1) [BLOAD'CAS-',R] [\_] | Yes | `CASGOR` |  |  |
| Yazzie (2019) (Retrosouls) [BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Yazzie MSX Remix (2020) (Retrosouls) [BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Yie Ar Kung Fu [BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Yie Ar Kung Fu II[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Yo Calculo (1986)(Anaya Multimedia)(es)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Zakil Wood (1985)(Mr. Micro)[BLOAD'CAS-',R] | Yes | `CASGOR /C` |  |  |
| Zalbar 2784 (1985)(Login Soft)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Zanac (1987)(Eaglesoft)[RUN'CAS-'] | Yes | `CASGOI /CB` |  |  |
| Zarth (1985)(Enix)(ja)(Side A)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Zaxxon (1985)(Electric Software)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Zero Fighter (1984)(Hudson Soft)[BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Zexas (1984)(dB-Soft)[CLOAD + RUN] | Yes | `CASGOR` |  |  |
| Zipi y Zape (1989)(Dro Soft)(es)(Side A)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Zoids - The Battle Begins (1985)(Martech Games)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Zombie Calavera Prologue (2021) (conv Nanochess) [BLOAD'CAS-',R] | Yes | `CASGOR` |  |  |
| Zona 0 (1991)(Topo Soft)(es)[RUN'CAS-'] | Yes | `CASGOI /S` |  |  |
| Zond (1988)(Iber Soft)(es)[aka Zexas][RUN'CAS-'] | Yes | `CASGOR` |  |  |
| Zoot (1986)(Bug-Byte Software)[RUN'CAS-'] | Yes | `CASGOR` |  |  |
