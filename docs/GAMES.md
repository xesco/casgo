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
| Loads | 1646 |
| Does not load, but CASGO with other cases forced loads it | 2 |
| Does not load with any variant | 5 |
| All | 1653 |

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

The table lists the tapes by their file name on File-Hunter.

| Game | Loads | Variant | Code | Run instead |
|---|---|---|---|---|
| 001 - Aritmo.cas | Yes | `CASGOR` |  |  |
| 001-Aritmo.cas | Yes | `CASGOR` |  |  |
| 002 - Black Jack  [Dimesion New].cas | Yes | `CASGOR` |  |  |
| 002-Black Jack.cas | Yes | `CASGOR` |  |  |
| 003 - Test de capacidad.cas | Yes | `CASGOR` |  |  |
| 003-Test de capacidad.cas | Yes | `CASGOR` |  |  |
| 004 - Test de adaptacion.cas | Yes | `CASGOR` |  |  |
| 004-Test de adaptacion.cas | Yes | `CASGOR` |  |  |
| 005 - El gerente.cas | Yes | `CASGOR` |  |  |
| 005-El gerente.cas | Yes | `CASGOR` |  |  |
| 006 - Domino.cas | Yes | `CASGOR` |  |  |
| 006-Domino.cas | Yes | `CASGOR` |  |  |
| 007 - A View to a Kill (1986)(Domark)[a][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| 007 - A View to a Kill (1986)(Domark)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| 007 - Damas  [Dimesion New].cas | Yes | `CASGOR` |  |  |
| 007 - Licence to Kill (1989)(Domark)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| 007 - The Living Daylights (1987)(Domark)[RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| 007 Agente Especial (1985)(Erbe Software)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| 007-Graficos de gestion.cas | Yes | `CASGOR` |  |  |
| 008 - Test de caracter.cas | Yes | `CASGOR` |  |  |
| 008-Hoja de calculo.cas | Yes | `CASGOR` |  |  |
| 009 - Mini Super Sprites.cas | Yes | `CASGOI` |  |  |
| 009-Calculator new.cas | Yes | `CASGOR` |  |  |
| 010 - Comecocos [Idealogic].cas | Yes | `CASGOR` |  |  |
| 010-Base de datos.cas | Yes | `CASGOI` |  |  |
| 011 - Invierte y gana.cas | Yes | `CASGOI /B` |  |  |
| 011-Damas.cas | Yes | `CASGOR` |  |  |
| 012 - Compra y Venta [Idealogic].cas | Yes | `CASGOR` |  |  |
| 012-Test de caracter.cas | Yes | `CASGOR` |  |  |
| 013 - Smack Wacker.cas | Yes | `CASGOR /CB` |  |  |
| 013-Pert.cas | Yes | `CASGOR` |  |  |
| 014 - Moonrider.cas | Yes | `CASGOR /CB` |  |  |
| 014-Risky Holding.cas | Yes | `CASGOR` |  |  |
| 015 - Juego de la moncloa.cas | Yes | `CASGOR` |  |  |
| 015-Bouncing Blocks.cas | Yes | `CASGOR` |  |  |
| 016-Roberto Mate.cas | Yes | `CASGOR` |  |  |
| 017 - Los Pe╠ütalos Locos.cas | Yes | `CASGOR` |  |  |
| 017-Mini Super Sprites.cas | Yes | `CASGOI` |  |  |
| 018 - Geometria, figuras planas y volumenes.cas | Yes | `CASGOR` |  |  |
| 018-Comecocos.cas | Yes | `CASGOR` |  |  |
| 019 - Galaxians.cas | Yes | `CASGOR` |  |  |
| 019-Invierte y gana.cas | Yes | `CASGOI /B` |  |  |
| 020 - Tratamiento de textos.cas | Yes | `CASGOI /B` |  |  |
| 020-Compra y vende.cas | Yes | `CASGOR` |  |  |
| 021 - Rios de Espana.cas | Yes | `CASGOR` |  |  |
| 021-Smack Wacker.cas | Yes | `CASGOR /CB` |  |  |
| 022 - Capitales de Espana.cas | Yes | `CASGOR` |  |  |
| 022-Moonrider.cas | Yes | `CASGOR /CB` |  |  |
| 023 - Idea Type I.cas | Yes | `CASGOR` |  |  |
| 023-Vestron.cas | Yes | `CASGOR` |  |  |
| 024 - Idea Type II.cas | Yes | `CASGOR` |  |  |
| 024-Foot Volley.cas | Yes | `CASGOR` |  |  |
| 025 - Memorion.cas | Yes | `CASGOR` |  |  |
| 025-Fire Hawk.cas | Yes | `CASGOR` |  |  |
| 026 - 007 Agente Especial [Monser].cas | Yes | `CASGOR` |  |  |
| 026-Sea King.cas | Yes | `CASGOR` |  |  |
| 027 - Rocket.cas | Yes | `CASGOR` |  |  |
| 027-Faraon.cas | Yes | `CASGOR` |  |  |
| 028 - Pucky.cas | Yes | `CASGOR` |  |  |
| 029 - Drum.cas | Yes | `CASGOR` |  |  |
| 030 - Kitchen.cas | Yes | `CASGOR` |  |  |
| 031 - Heli.cas | Yes | `CASGOR` |  |  |
| 031-Mazes Unlimited.cas | Yes | `CASGOR /CB` |  |  |
| 032 - Crossing.cas | Yes | `CASGOR` |  |  |
| 032-Robot Wars.cas | Yes | `CASGOT /B` |  |  |
| 033 - Snack-Bar.cas | Yes | `CASGOR` |  |  |
| 033-Juego de la moncloa (cload).cas | Yes | `CASGOR` |  |  |
| 034 - Mouse.cas | Yes | `CASGOR` |  |  |
| 035 - Pyramid (Jojosoft).CAS | Yes | `CASGOR` |  |  |
| 035-Edgy.cas | Yes | `CASGOR` |  |  |
| 036 - Space.cas | Yes | `CASGOR` |  |  |
| 036-Contabilidad domestica (Philips, 1987).cas | Yes | `CASGOR` |  |  |
| 037 - Alpha Blaster.cas | Yes | `CASGOR /CB` |  |  |
| 037-Los Petalos locos.cas | Yes | `CASGOR` |  |  |
| 038 - Mac Attack.cas | Yes | `CASGOR /CB` |  |  |
| 038-Geometria, figuras planas y volumenes.cas | Yes | `CASGOR` |  |  |
| 039 - Choper I.cas | Yes | `CASGOR /CB` |  |  |
| 039-War Chess.cas | Yes | `CASGOR` |  |  |
| 040 - Scentipede.cas | Yes | `CASGOR /CB` |  |  |
| 040-Skate Dragon.cas | Yes | `CASGOR` |  |  |
| 041 - Editor de Sprites.cas | Yes | `CASGOR` |  |  |
| 041-Galaxians.cas | Yes | `CASGOR` |  |  |
| 042 - Othello.cas | Yes | `CASGOR` |  |  |
| 042-Tratamiento de textos.cas | Yes | `CASGOI /B` |  |  |
| 043 - Ice.cas | Yes | `CASGOR /CB` |  |  |
| 043-Rios de Espana.cas | Yes | `CASGOR` |  |  |
| 044 - Demand.cas | Yes | `CASGOR` |  |  |
| 044-Capitales de Espa+a.cas | Yes | `CASGOR` |  |  |
| 045 - Treppy.cas | Yes | `CASGOR` |  |  |
| 045-Idea Type.cas | Yes | `CASGOR` |  |  |
| 046 - Glider.cas | Yes | `CASGOR` |  |  |
| 046-Idea Type.cas | Yes | `CASGOR` |  |  |
| 047 - Micky-Lucky.cas | Yes | `CASGOR` |  |  |
| 047-Gusanoco.cas | Yes | `CASGOR` |  |  |
| 048 - Racer.cas | Yes | `CASGOR` |  |  |
| 048-VG Estrella.cas | Yes | `CASGOR` |  |  |
| 049 - Alcyon.cas | Yes | `CASGOR` |  |  |
| 049-Memorion.cas | Yes | `CASGOR` |  |  |
| 050 - Artillero.cas | Yes | `CASGOR` |  |  |
| 050-Agente Especial.cas | Yes | `CASGOR` |  |  |
| 052-Editor de caracteres.cas | Yes | `CASGOR` |  |  |
| 053-Formula 1.cas | Yes | `CASGOR` |  |  |
| 054-Ovni.cas | Yes | `CASGOR` |  |  |
| 055-Rocket.cas | Yes | `CASGOR` |  |  |
| 056-Pucky.cas | Yes | `CASGOR` |  |  |
| 057-Azul y rosa.cas | Yes | `CASGOR` |  |  |
| 058-Escape.cas | Yes | `CASGOR` |  |  |
| 059-Invasores.cas | Yes | `CASGOR` |  |  |
| 060-Break.cas | Yes | `CASGOR` |  |  |
| 061-Drum.cas | Yes | `CASGOR` |  |  |
| 062-Kitchen.cas | Yes | `CASGOR` |  |  |
| 063-Heli.cas | Yes | `CASGOR` |  |  |
| 064-Crossing.cas | Yes | `CASGOR` |  |  |
| 065-Snack-Bar.cas | Yes | `CASGOR` |  |  |
| 066-Mouse.cas | Yes | `CASGOR` |  |  |
| 068-Space.cas | Yes | `CASGOR` |  |  |
| 069-Car Race.cas | Yes | `CASGOR` |  |  |
| 070-Poker.cas | Yes | `CASGOR` |  |  |
| 071-Fruit.cas | Yes | `CASGOR` |  |  |
| 072-Jetfighter.cas | Yes | `CASGOR /CB` |  |  |
| 073-Alpha Blaster.cas | Yes | `CASGOR /CB` |  |  |
| 074-Mac Attack.cas | Yes | `CASGOR /CB` |  |  |
| 075-Choper 1.cas | Yes | `CASGOR /CB` |  |  |
| 076-Scentipede.cas | Yes | `CASGOR /CB` |  |  |
| 077-Space Rescue.cas | Yes | `CASGOR /CB` |  |  |
| 078-Time Curb.cas | Yes | `CASGOR /CB` |  |  |
| 079 - Editor de Sprites.cas | Yes | `CASGOR` |  |  |
| 080-Othello.cas | Yes | `CASGOR` |  |  |
| 081-Kick It.cas | Yes | `CASGOR /CB` |  |  |
| 082-Panique.cas | Yes | `CASGOR /CB` |  |  |
| 083-Ruleta.cas | Yes | `CASGOR` |  |  |
| 087-Panel Panique.cas | Yes | `CASGOI /B` |  |  |
| 088 - Rompeladrillos.cas | Yes | `CASGOR` |  |  |
| 089-Solfeo.cas | Yes | `CASGOR` |  |  |
| 090-Maziacs.cas | Yes | `CASGOR` |  |  |
| 091-Space Buster.cas | Yes | `CASGOR /CB` |  |  |
| 092-Cubo de Rubick.cas | Yes | `CASGOR` |  |  |
| 093-Ice.cas | Yes | `CASGOR /CB` |  |  |
| 094-Demand.cas | Yes | `CASGOR` |  |  |
| 095-Treppy.cas | Yes | `CASGOR` |  |  |
| 096-Glider.cas | Yes | `CASGOR` |  |  |
| 097-Micky-Lucky.cas | Yes | `CASGOR` |  |  |
| 098-Racer.cas | Yes | `CASGOR` |  |  |
| 099-Alcyon.cas | Yes | `CASGOR` |  |  |
| 100-Artillero.cas | Yes | `CASGOR` |  |  |
| 10th Frame (1986)(US Gold)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| 180 (1987)(Mastertronic Added Dimension)[RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| 3D Golf Simulation - High Speed Edition (1984)(T&E Soft)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| 4x4 Off-Road Racing (1988)(US Gold)(Side A)[a][BLOAD'CAS-',R].cas | Yes | `CASGOI /S` |  |  |
| 4x4 Off-Road Racing (1988)(US Gold)(Side A)[BLOAD'CAS-',R].cas | Yes | `CASGOI /S` |  |  |
| 7 Card Stud (1986)(Martech Games)[a][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| 7 Card Stud (1986)(Martech Games)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| 737 Flight Simulator (1984)(Mirrorsoft)[a][BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| 737 Flight Simulator (1984)(Mirrorsoft)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| 747 400b Flight Simulator (1988)(Eurosoft)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| A-TEAM (1988)(Zafiro)[CLOAD + RUN].cas | Yes | `CASGOR /B` |  |  |
| Aaargh! (1989)(Dro Soft)(es)[a][RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Aaargh! (1989)(Dro Soft)(es)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Aackobase II (1985)(Aackosoft)(nl)[a][RUN'CAS-'].cas | Yes | `CASGOR /P16` |  |  |
| Aackobase II (1985)(Aackosoft)(nl)[RUN'CAS-'].cas | Yes | `CASGOR /P17` |  |  |
| Aackodraw & Paint (1985)(Aackosoft)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Abadia del Crimen, La (1988)(Opera Soft)(es)[BLOAD'CAS-',R].cas | Yes | `CASGOR /C` |  |  |
| Abeja Sabia 2, La (1986)(Anaya Multimedia)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Abeja Sabia 3, La (1986)(Anaya Multimedia)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Abracadabra (1988)(Proein Soft Line)(es)(Side A)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Abu Simbel Profanation (1986)(Dinamic Software)(es)[a2][BLOAD'CAS-',R].cas | Yes | `CASGOI /CB` |  |  |
| Abu Simbel Profanation (1986)(Dinamic Software)(es)[a][BLOAD'CAS-',R].cas | Yes | `CASGOI /CB` |  |  |
| Abu Simbel Profanation (1986)(Dinamic Software)(es)[BLOAD'CAS-',R].cas | Yes | `CASGOI /CB` |  |  |
| Abu Simbel Profanation (1986)(Dinamic Software)(es)[RUN'CAS-'].cas | Yes | `CASGOI /CB` |  |  |
| Ace of Aces (1986)(US Gold)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Addictaball (1988)(Alligata Software)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Addictaball (1988)(Alligata)(GB)[RUN'CAS-']-FX3-Cursores.cas | Yes | `CASGOR /CB` |  |  |
| Addictaball (1988)(Alligata)(GB)[RUN'CAS-']-FX3.cas | Yes | `CASGOR /CB` |  |  |
| Adel (1986)(Mind Games Espana)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Adventure Quest (1983)(Level 9 Computing)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Aerial (2021)(Inufuto).cas | Yes | `CASGOR` |  |  |
| African Trail Simulator (1990)(Positive)(es)[RUN'CAS-'].cas | Yes | `CASGOT /CB` |  |  |
| After the War (1989)(Dinamic Software)(es)(Side A)[RUN'CAS-'].cas | Yes | `CASGOT /B` |  |  |
| Afterburner (1988)(Activision)(Side A)[BLOAD'CAS-',R].cas | Yes | `CASGOR /N` |  |  |
| Afteroids (1988)(Zigurat Software)(es)[a][RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Afteroids (1988)(Zigurat Software)(es)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Akalabeth (1980)(California Pacific).cas | Yes | `CASGOR` |  |  |
| Akarui Nouen (1983) (Hudson Soft)[BLOAD'CAS-',R].CAS | Yes | `CASGOR` |  |  |
| Akujo Legend (1986)(Dream Soft)(jp)[CLOAD+RUN].cas | Yes | `CASGOR` |  |  |
| Ale Hop! (1988)(Topo Soft)(es)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Alfamat (1985)(Anaya Multimedia)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Aliantantor dump di Andrea bendoni.cas | Yes | `CASGOM /B` |  |  |
| Alice's Adventure in Wonderland (1984)(MicroCabin)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Alien 8 (1985)(Ultimate Play The Game)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Alien 8 Remake (2008) [BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Alien Attack (2020) (Marcos Daniel Blanco) [1.03] [BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Alien Sunday... (1986)(Soft Studio WING)(Side A).cas | Yes | `CASGOR` |  |  |
| Alien Syndrome (1988)(Dro Soft)(es)(Side A)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Aliens (1987)(Mr. Micro)[BLOAD'CAS-',R].cas | Yes | `CASGOR /N` |  |  |
| Almanaque (1986)(Load 'n' Run)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Alpha Blaster (1984)(Aackosoft)[a2][RUN'CAS-'].cas | Yes | `CASGOI /CB` |  |  |
| Alpha Blaster (1984)(Aackosoft)[a][RUN'CAS-'].cas | Yes | `CASGOI /CB` |  |  |
| Alpha Blaster (1984)(Aackosoft)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Alpha Blaster (1987)(Eaglesoft)[a][RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Alpha Blaster (1987)(Eaglesoft)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Altered Beast (1988)(Activision)(Side A)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Amaurote (1987)(Mastertronic Added Dimension)[RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| American Truck - Hi-Speed Scroll Action (1985)(Telenet Japan)(Japan)[CLOAD-RUN].cas | Yes | `CASGOI` |  |  |
| Amoto's Puf (1988)(SPE)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| An Adventure Of The Blue Universe (1985)(Leben Pro IO)(ja)[Side A][CLOAD+RUN].cas | Yes | `CASGOR` |  |  |
| Ananas (1989)(Eurosoft)[aka Pine Applin][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Andrea Petkovic Tennis [En] (2017)[BLOAD'CAS-',R].cas | Yes | `CASGOI /C` |  |  |
| Andrea Petkovic Tennis [Es] (2017)[BLOAD'CAS-',R].cas | Yes | `CASGOI /C` |  |  |
| Anexo 01, El Algoritmo [En] (2018) [BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Anexo 01, El Algoritmo [Es] (2018) [BLOAD'CAS-',R].cas | Yes | `CASGOI /C` |  |  |
| Anexo 01, El Algoritmo [Es][v1.2] (2018) [BLOAD'CAS-',R].cas | Yes | `CASGOI /C` |  |  |
| Angel Nieto Pole 500cc (1990)(Opera Soft)(es)[BLOAD'CAS-',R].cas | Yes | `CASGOR /C` |  |  |
| Angleball (1987)(Mastertronic Added Dimension)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Antarctic Adventure (Microbyte) (Argentina) [RUN'CAS-'] [\_].cas | Yes | `CASGOI /B` |  |  |
| Antarctic Adventure (Pinguin) (Italy) [BLOAD'CAS-',R] [\_].cas | Yes | `CASGOI /B` |  |  |
| Antarctic Adventure (Pinguin) (Italy) [BLOAD'CAS-',R] [A].cas | Yes | `CASGOI /S` |  |  |
| Antarctic Adventure-eu[BLOAD'CAS-',r].cas | Yes | `CASGOR` |  |  |
| Antarctica (1983) (Pony Canyon) [cload''NA''].cas | Yes | `CASGOR` |  |  |
| AntiAir (2024)(inufuto).cas | Yes | `CASGOR` |  |  |
| Any Treasure Day (2018) (Timmy) [BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Arithmetic, Mathematics and English for Elementary and Junior High School Students, 2 Volumes, Learning Software (198x)(Soft & Soft)[CLOAD'ENG-1'],R.CAS | Yes | `CASGOR` |  |  |
| Arithmetic, Mathematics and English for Elementary and Junior High School Students, 2 Volumes, Learning Software (198x)(Soft & Soft)[CLOAD'ENG-2'],R.CAS | Yes | `CASGOR` |  |  |
| Arithmetic, Mathematics and English for Elementary and Junior High School Students, 2 Volumes, Learning Software (198x)(Soft & Soft)[CLOAD'MAT-1'],R.CAS | Yes | `CASGOR` |  |  |
| Arithmetic, Mathematics and English for Elementary and Junior High School Students, 2 Volumes, Learning Software (198x)(Soft & Soft)[CLOAD'MAT-2'],R.CAS | Yes | `CASGOR` |  |  |
| Aritmo (1985)(DIMensionNEW)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Arkanoid (1986)(Taito)[RUN'CAS-'].cas | Yes | `CASGOI /CB` |  |  |
| Arkanoid (Imagine) [BLOAD'CAS-',R] [\_].cas | Yes | `CASGOI /C` |  |  |
| Arkos I (1988)(Zigurat Software)(es)[RUN'CAS-'].cas | Yes | `CASGOR /B` |  |  |
| Arkos II (1988)(Zigurat Software)(es)[RUN'CAS-'].cas | Yes | `CASGOR /B` |  |  |
| Arkos III (1988)(Zigurat Software)(es)[RUN'CAS-'].cas | Yes | `CASGOR /B` |  |  |
| Army Moves (1987)(Dinamic Software)(es)(Side A)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Army Moves (1987)(Imagine Software)(Side A)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Arquimedes XXI (1986)(Dinamic Software)(es)[BLOAD'CAS-',R].cas | Yes | `CASGOT /B` |  |  |
| Arquimedes XXI (1986)(Dinamic Software)(es)[RUN'CAS-'].cas | Yes | `CASGOT /B` |  |  |
| Aspar GP Master (1988)(Dinamic Software)(es)[a2][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Aspar GP Master (1988)(Dinamic Software)(es)[a][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Aspar GP Master (1988)(Dinamic Software)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Aspar GP Master (1989)(Dinamic Software)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Astro Blaster (1988)(Eurosoft)[a2][RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Astro Blaster (1988)(Eurosoft)[a][RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Astro Blaster (1988)(Eurosoft)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Astro Marine Corps (1989)(Dinamic Software)(es)(Side A)[a][RUN'CAS-'].cas | Yes | `CASGOT /B` |  |  |
| Astro Marine Corps (1989)(Dinamic Software)(es)(Side A)[RUN'CAS-'].cas | Yes | `CASGOT /B` |  |  |
| Astronauta (1986)(Load 'n' Run)(es)[aka Space Walk][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Attacked (19xx)(Tynesoft)[RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Attacked (Tynesoft).cas | Yes | `CASGOI /B` |  |  |
| Auf Wiedersehen Monty (1987)(Gremlin Graphics Software)[BLOAD'CAS-',R].cas | Yes | `CASGOI /S` |  |  |
| Avenger (1986)(Erbe Software)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Avenger (1986)(Gremlin Graphics Software)[BLOAD'CAS-',R].cas | Yes | `CASGOI /S` |  |  |
| Aventura Espacial, La (1990)(Aventuras AD)(es)(Side A)[RUN'CAS-'].cas | Yes | `CASGOI /CB` |  |  |
| Aventura Original, La (1989)(Aventuras AD)(es)(Side A)[RUN'CAS-'].cas | Yes | `CASGOT /CB` |  |  |
| Averno (1989)(Proein Soft Line)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Awass (2026)(inufuto).cas | Yes | `CASGOR` |  |  |
| Bakerman (2023)(AG Software)[RUN'CAS-'][b].CAS | Yes | `CASGOI /B` |  |  |
| Bal - Game Pack 1 (Aackosoft - Eaglesoft) [RUN'CAS-'] [\_].cas | Yes | `CASGOR` |  |  |
| Bang! Bang! (1985)(Ample, Mel Software)(JP)(en)[!][BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Bang! Bang! (1985)(Ample, Mel Software)(JP)(en)[GDX Fixed][BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Barbarian (1988)(Mastertronic)(es)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Barbarian II - The Dungeon of Drax (1988)(Erbe Software)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Barn Stormer (1985)(Electric Software)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Base de Datos (1985)(DIMensionNEW)(es)[RUN'CAS-'].cas | Yes | `CASGOI` |  |  |
| Base de Datos (19xx)(Toshiba)(es)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Baseball - Game Pack 1 (Aackosoft - Eaglesoft) [RUN'CAS-'] [\_].cas | Yes | `CASGOR` |  |  |
| BASICODE-3(1987)(NOS)(NL).cas | Yes | `CASGOI` |  |  |
| Batalla Espacial (19xx)(Grupo de Trabajo Software)(es)[aka Valkyr][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Batman (1986)(Erbe Software)[RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Batman (1986)(Ocean Software)[a][RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Batman (1986)(Ocean Software)[RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Batman - The Movie (1989)(Ocean Software)(Side A)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Battle Chopper (1985)(Methodic Solutions)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Battle Mecha Xabungle Blue Gale Part 1 (1985) (Pony Canyon)[CLOAD + RUN).CAS | Yes | `CASGOR` |  |  |
| Battleship Clapton II (1983)(T&E Soft)[BLOAD'CAS'-',R].cas | Yes | `CASGOR` |  |  |
| Battlot (2021)(Inufuto).cas | Yes | `CASGOR` |  |  |
| BC's Quest for Tires II - Grog's Revenge (1985)(US Gold)[a][RUN'CAS-'].cas | Yes | `CASGOM /B` |  |  |
| BC's Quest for Tires II - Grog's Revenge (1985)(US Gold)[RUN'CAS-'].cas | Yes | `CASGOM /B` |  |  |
| BC's Quest for Tires II - Grog's Revenge (1987)(Eaglesoft)[RUN'CAS-'].cas | Yes | `CASGOI /CB` |  |  |
| BCs Quest For Tyres [BLOAD'CAS-',r].cas | Yes | `CASGOR` |  |  |
| Beach-Head (1985)(US Gold)[RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Beamrider (1984)(Activision)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Bear George (1985)(Soft Bee)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Berlin (1985)(Omega System)[CLOAD+RUN].cas | Yes | `CASGOR` |  |  |
| Bestial Warrior (1989)(Dinamic Software)(es)[a][RUN'CAS-'].cas | Yes | `CASGOR /B11` |  |  |
| Bestial Warrior (1989)(Dinamic Software)(es)[RUN'CAS-'].cas | Yes | `CASGOR /B10` |  |  |
| Binary Land (HoneyBee Soft) (Hudson Soft) (Japan) [BLOAD'CAS-',R] [\_].cas | Yes | `CASGOR` |  |  |
| Biotech (1983) (Hudson Soft)[BLOAD'CAS-',R].CAS | Yes | `CASGOR` |  |  |
| Birds And Chairs (2017) [BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Bit Byter (19xx)(Spectravideo)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Black Bass, The (1986)(Hot-B)(ja)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Blackbeard (1988)(Topo Soft)(es)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Blackjack (1985)(DIMensionNEW)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Blagger Enhanced [BLOAD'CAS',R].cas | Yes | `CASGOR` |  |  |
| Blagger Enhanced [Bload'CAS-',r].cas | Yes | `CASGOR` |  |  |
| Blasteroids (1987)(Image Works)[BLOAD'CAS-',R].cas | Yes | `CASGOI /S` |  |  |
| Blitz Krieg (1985)(Omega System).cas | Yes | `CASGOR` |  |  |
| Blocker (19xx)(Grupo de Trabajo Software)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Bloody (1987)(P.J. Software)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Blow Up (1988)(Eurosoft)[a][RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Blow Up (1988)(Eurosoft)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| BMX Simulator (1987)(Codemasters)[RUN'CAS-'].cas | Yes | `CASGOT /B9` |  |  |
| Boardello (1985)(Bubblebus Software)[a][RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Boardello (1985)(Bubblebus Software)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Bob 007 - Infiltrado (1986)(Grupo de Trabajo Software)(es)[a][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Bob 007 - Infiltrado (1986)(Grupo de Trabajo Software)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Bomberman [BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Booga-Boo the Flea (1986)(Quicksilva)[a][BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Booga-Boo the Flea (1986)(Quicksilva)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Boom (1986)(Aackosoft)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Boom (1988)(Eurosoft)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Boom! - MSX Compilation 4 (ByteBusters) (Aackosoft - Eaglesoft) [RUN'CAS-'] [\_].cas | Yes | `CASGOR /CB` |  |  |
| Bootskell (2021)(Inufuto).cas | Yes | `CASGOR` |  |  |
| Booty (1988)(Eurosoft)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Bop! (1986)(Bug-Byte Software)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Boulder Dash (1985)(Databyte)[a][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Boulder Dash (1985)(Databyte)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Boulder Dash II - Rockford's Revenge (First Star) (Databyte) (Side A) [RUN'CAS-'] [\_].cas | Yes | `CASGOR` |  |  |
| Boulder Dash II - Rockford's Revenge (First Star) (Databyte) [RUN'CAS-'] [\_].cas | Yes | `CASGOR` |  |  |
| Boulder Dash II - Rockford's Riot (1986)(Databyte)[a][RUN'CAS-'].cas | Yes | `CASGOI /CB` |  |  |
| Boulder Dash II - Rockford's Riot (1986)(Databyte)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Bounce (1987)(Methodic Solutions)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Bound Rescue (1984)(Shouji Ogawa).cas | Yes | `CASGOR` |  |  |
| Bounder (1987)(Gremlin Graphics Software)[a][BLOAD'CAS-',R].cas | Yes | `CASGOI /S` |  |  |
| Bounder (1987)(Gremlin Graphics Software)[BLOAD'CAS-',R].cas | Yes | `CASGOI /S` |  |  |
| Break In (1987)(Eaglesoft)[a][RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Break In (1987)(Eaglesoft)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Break Out! (1985)(Toshiba-EMI)[a2][needs 64k in slot 2][RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Break Out! (1985)(Toshiba-EMI)[a][needs 64k in slot 2][RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Break Out! (1985)(Toshiba-EMI)[needs 64k in slot 2][RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| BreakBomb (2021)(Gamecast).cas | Yes | `CASGOR` |  |  |
| Breaker Breaker (1988)(Eurosoft)[a][RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Breaker Breaker (1988)(Eurosoft)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Breakout(1985)(Toshiba)[RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Brian Jacks Superstar Challenge (1985)(Martech Games)(Side A)[a][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Brian Jacks Superstar Challenge (1985)(Martech Games)(Side A)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| British Bob [BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Bronx (1989)(Animagic)(es)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Bruce Lee (1985)(Comptiq)[RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Bubblekund 1999 (1984)(Softbank)(ja).cas | Yes | `CASGOR` |  |  |
| Bubbler (1987)(Ultimate Play The Game)[BLOAD'CAS-',R].cas | Yes | `CASGOT /C` |  |  |
| Bubbo World 2 [RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Bubbo World [RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Buck Rogers - Planet of Zoom (1983)(Sega)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Buddhagillie (2018) (GW's Workshop) [BLOAD'CAS-',r].cas | Yes | `CASGOR` |  |  |
| Budokan (1991)(Dro Soft)(Side A)[RUN'CAS-'].cas | Yes | `CASGOT /S` |  |  |
| Buggy Ranger (1990)(Dinamic Software)(es)[RUN'CAS-'].cas | Yes | `CASGOT /B` |  |  |
| Bumper Ship Racing (2018) (Uninteresting) [BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Bumpy (1989)(Loriciels)[a][RUN'CAS-'].cas | Yes | `CASGOT /B` |  |  |
| Bumpy (1989)(Loriciels)[RUN'CAS-'].cas | Yes | `CASGOT /B` |  |  |
| Bumpy (19xx)(Grupo de Trabajo Software)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Burn Us (2018) (Carambalan Studios)[Bload'CAS-',R.cas | Yes | `CASGOR /B` |  |  |
| Buster Block (1985)(Kuma Computers)[RUN'CAS-'].cas | Yes | `CASGOM /B` |  |  |
| Busy Rainy Day (1983)(Hudson Soft)[BLOAD'CAS',r].cas | Yes | `CASGOR` |  |  |
| Buzz Off! (1984)(Electric Software)[a][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Buzz Off! (1984)(Electric Software)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Buzz Off! (1984)(Electric Software)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Bytebusters (1984)(Aackosoft)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Cacorm (2022)(Inufuto).cas | Yes | `CASGOR` |  |  |
| Calculator New (1985)(DIMensionNEW)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Caldero Magico, El (1986)(Grupo de Trabajo Software)(es)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| California Games (1987)(US Gold)(Side A)[RUN'CAS-'].cas | Yes | `CASGOR /N` |  |  |
| Camelot Warriors (1986)(Dinamic Software)(es)[a][BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Camelot Warriors (1986)(Dinamic Software)(es)[BLOAD'CAS-',R].cas | Yes | `CASGOI /C` |  |  |
| Camelot Warriors (1986)(Dinamic Software)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Can of Worms (1986)(LiveWire Software)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Cannon Ball (1983)(Hudson Soft).cas | Yes | `CASGOR` |  |  |
| Cannon Fighter (1984) (Moorwood Software)[BLOAD'CAS-',R].cas | Yes | `CASGOI` |  |  |
| Capitan Sevilla (1988)(Dinamic Software)(es)(Side A)[RUN'CAS-'].cas | Yes | `CASGOR /B` |  |  |
| Capitan Sevilla (1988)(Dinamic Software)(Side A)[RUN'CAS-'].cas | Yes | `CASGOR /B` |  |  |
| Capitan Trueno (1989)(Dinamic Software)(es)(Side A)[RUN'CAS-'].cas | Yes | `CASGOM /B` |  |  |
| Carlos Sainz (1990)(Zigurat Software)(es)[RUN'CAS-'].cas | Yes | `CASGOR /B` |  |  |
| Casanova (1989)(Iber Soft)(es)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Castle Combat (1985)(Spectravideo)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Catle Tomb (2023)(Gamecast Entertainment).CAS | Yes | `CASGOI /B` |  |  |
| Cave Adventure (Chitai Tanken)(1984)(Ample Software).cas | Yes | `CASGOR` |  |  |
| Cavern of Death (1987)(Dro Soft)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Caverns Of Titan 2[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Caverns Of Titan [BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Cavit (2021)(Inufuto).cas | Yes | `CASGOR` |  |  |
| Caza (1986)(Load 'n' Run)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Cetus (1986)(Tynesoft)[CLOAD+RUN].cas | Yes | `CASGOR` |  |  |
| Chack 'n Pop (1984)(Taito)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Champ (1984)(PSS)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Champions Grand National (1984)(Pony Canyon)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Chase H.Q. (1988)(Ocean Software)(Side A)[b][RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Chase H.Q. (1988)(Ocean Software)(Side A)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Checkmate! First Moves in Chess (1985)(Toshiba-EMI)[a2][needs 64k in slot 2][RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Checkmate! First Moves in Chess (1985)(Toshiba-EMI)[a][needs 64k in slot 2][RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Checkmate! First Moves in Chess (1985)(Toshiba-EMI)[needs 64k in slot 2][RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Checkmate!(1985)(Toshiba)[RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Chess Game, The (1985)(Eaglesoft).cas | Yes | `CASGOR` |  |  |
| Chicago 30's (1988)(Topo Soft)(es)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Chicken Chase (1986)(Bug-Byte Software)[RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Chiemi Hori Strawberry Puzzle (1984)(Pony Canyon)(ja).cas | Yes | `CASGOR` |  |  |
| Chiller (1985)(Mastertronic)[a2][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Chiller (1985)(Mastertronic)[a3][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Chiller (1985)(Mastertronic)[a4][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Chiller (1985)(Mastertronic)[a5][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Chiller (1985)(Mastertronic)[a][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Chiller (1985)(Mastertronic)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Chopper (1986)(Eaglesoft)[a][RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Chopper (1986)(Eaglesoft)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Chopper One (1988)(Eurosoft)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Choro Q (1984)(Taito)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Choy-Lee-Fut Kung-Fu Warrior (1990)(Positive)(es)[RUN'CAS-'].cas | Yes | `CASGOT /B` |  |  |
| Chubby Gristle (1987)(Grandslam Entertainment).cas | Yes | `CASGOI /S` |  |  |
| Chuck Yeager's Advanced Flight Trainer (1989)(Dro Soft)[RUN'CAS-'].cas | Yes | `CASGOI /S7` |  |  |
| Chuckie Egg (1984)(A & F Software)[a2][BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Chuckie Egg (1984)(A & F Software)[a3][BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Chuckie Egg (1984)(A & F Software)[a][BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Chuckie Egg (1984)(A & F Software)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Chuckie Egg (1985)(Aackosoft)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Chuckie Egg [MSX support fix].cas | Yes | `CASGOR` |  |  |
| Ci-U-Than Trilogy I - La Diosa de Cozumel (1990)(Aventuras AD)(es)(Side A)[a][RUN'CAS-'].cas | Yes | `CASGOI /CB` |  |  |
| Ci-U-Than Trilogy I - La Diosa de Cozumel (1990)(Aventuras AD)(es)(Side A)[RUN'CAS-'].cas | Yes | `CASGOI /CB` |  |  |
| Ci-U-Than Trilogy II - Los Templos Sagrados (1991)(Aventuras AD)(es)(Side A)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Ci-U-Than Trilogy III - Chichen Itza (1992)(Aventuras AD)(es)(Side A)[RUN'CAS-'].cas | Yes | `CASGOI /CB` |  |  |
| Cid, El (1987)(Dro Soft)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| City Connection (1986)(Jaleco)[RUN'CAS-'].cas | Yes | `CASGOI /CB` |  |  |
| City Connection (1987)(Eaglesoft)[RUN'CAS-'].cas | Yes | `CASGOI /CB` |  |  |
| Cobra's Arc (1986)(Dinamic Software)(es)[RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Coliseum (1988)(Topo Soft)(es)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Colony (1987)(Bulldog)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Colossal Adventure  - B-Version - Text Only (1984)(Level 9 Computing)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Colossal Adventure - Text Only (1984)(Level 9 Computing)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Colossus 4 Chess (1986)(CDS Microsystems)[BLOAD'CAS-',R].cas | Yes | `CASGOI /S` |  |  |
| Colt 36 (1987)(Topo Soft)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Comando Quatro (1989)(Zigurat Software)(es)[RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Comando Tracer (1989)(Dinamic Software)(es)[a][RUN'CAS-'].cas | Yes | `CASGOM /B` |  |  |
| Comando Tracer (1989)(Dinamic Software)(es)[b][RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Comando Tracer (1989)(Dinamic Software)(es)[RUN'CAS-'].cas | Yes | `CASGOM /B` |  |  |
| Comecocos (19xx)(Idealogic)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Cometa Halley (1985)(Sony)(es)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Compra y Vende (1985)(Idealogic)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Computadora Adivina (1985)(Sony)(es)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Computer Fan Tan (1985)(Login Soft)[CLOAD+RUN].cas | Yes | `CASGOR` |  |  |
| Confused (1986)(Eaglesoft)[a][RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Confused (1986)(Eaglesoft)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Congo (1986)(LiveWire Software)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Congo Bongo (1983)(Sega)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Contabilidad (1985)(Sony)(es)[CLOAD + RUN].cas | Yes | `CASGOI /CB` |  |  |
| Contabilidad Domestica (1985)(DIMensionNEW)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Contabilidad I (19xx)(Mind Games Espana)(es)[a][CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Contabilidad I (19xx)(Mind Games Espana)(es)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Continental Circus (1989)(Virgin Mastertronic)(Side A)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Contract Bridge (1984)(Alligata Software)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Corsarios (1989)(Opera Soft)(es)(Side A)[BLOAD'CAS-',R].cas | Yes | `CASGOR /C` |  |  |
| Cosa Nostra (1986)(Opera Soft)(es)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Cosmic Sheriff (1989)(Dinamic Software)(es)[RUN'CAS-'].cas | Yes | `CASGOT /B` |  |  |
| Cosmic Shock Absorber (1986)(Martech Games)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Cosmix Shock Absorber (1987)(Martech Games).cas | Yes | `CASGOR` |  |  |
| Cosmo Traveler (1983)(Colpax)[Side A][BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Cosmos (1985)(Sony)(es)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Cracky (2023)(Inufuto).cas | Yes | `CASGOR` |  |  |
| Crash Together - Butsukekko (1983)(Central Education).cas | Yes | `CASGOR` |  |  |
| Crazy Cars [BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Crazy Golf (1984)(Mr. Micro)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Cross Chase (2018) (Fabrizio Caruso) [BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Crusader (1987)(Eaglesoft)[a][RUN'CAS-'].cas | Yes | `CASGOI /CB` |  |  |
| Crusader (1987)(Eaglesoft)[RUN'CAS-'].cas | Yes | `CASGOI /CB` |  |  |
| Cryptic Cube (Spectravideo) [\_] [CLOAD-RUN].cas | Yes | `CASGOR` |  |  |
| Cubik. Cubo de Rubik (1985)(Monser)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Cubit (1986)(Mr. Micro)[a][BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Cubit (1986)(Mr. Micro)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Curro Jimenez (1989)(Zigurat Software)(es)[RUN'CAS-'].cas | Yes | `CASGOR /B` |  |  |
| Curso de BASIC (1985)(Sony)(es)(Side A)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Cyberbig (1989)(Animagic)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Cyberun (1985)(Ultimate Play The Game)[BLOAD'CAS-',R].cas | Yes | `CASGOT /C` |  |  |
| D-Day (1984)(Jaleco).cas | Yes | `CASGOI /CB` |  |  |
| Daidasso. Great Escape (1985)(Carry Lab)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Dam Busters, The (1985)(Erbe Software)[RUN'CAS-'].cas | Yes | `CASGOT /B` |  |  |
| Dam Busters, The[RUN'-CAS'].cas | Yes | `CASGOT /B` |  |  |
| Damas (1985)(DIMensionNEW)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Darkwood Manor (19xx)(Kuma Computers)[a][CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Darkwood Manor (19xx)(Kuma Computers)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Databa (19xx)(Philips)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Datilografia (1986)(Sysout).CAS | Yes | `CASGOR` |  |  |
| Dawn Patrol (1987)(Eaglesoft)(NL)[RUN'CAS-'][Martos].cas | Yes | `CASGOR /CB` |  |  |
| Death Valley Gold Rush (1985)(Kuma Computers)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Death Wish 3 (1987)(Gremlin Graphics Software)[BLOAD'CAS-',R].cas | Yes | `CASGOI /S` |  |  |
| Decathlon (1984)(Activision)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Deep Core Raider (P. Jenkinson) [BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Defcom 1 (1989)(Iber Soft)(Side A)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Demand (1984)(Login Soft).cas | Yes | `CASGOI` |  |  |
| Demand (1985)(Login Soft)[CLOAD+RUN].cas | Yes | `CASGOR` |  |  |
| Demo, De (1985)(Philips)(nl)[position tape + RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Demo, De - Adres Boek (1985)(Philips)(nl)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Demo, De - Hexapion (1985)(Philips)(nl)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Demo, De - Lanceer (1985)(Philips)(nl)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Demo, De - Nederland (1985)(Philips)(nl)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| demo\_rodman\_msx[File-Hunter.com].cas | Yes | `CASGOR` |  |  |
| Demonia (1986)(Microids)(fr)[RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Desolator (1986)(Gremlin Graphics Software)[a][BLOAD'CAS-',R].cas | Yes | `CASGOT /S` |  |  |
| Desolator (1986)(Gremlin Graphics Software)[BLOAD'CAS-',R].cas | Yes | `CASGOT /S` |  |  |
| Desperado (1987)(Topo Soft)(es)(Side A)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Desperado 2 (1991)(Topo Soft)(es)[a][RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Desperado 2 (1991)(Topo Soft)(es)[RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Destroyer (1986)(Mind Games Espana)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Deus Ex Machina (1985)(Mind Games Espana)(es)(Side A)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Dezeni Land (1984)(Hudson Soft)(ja)(Side A)[position tape + BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Dial Number (1985)(Nippon Columbia).cas | Yes | `CASGOR` |  |  |
| Dial Number (1985)(Nippon Columbia)[PSG Port fix by GDX].cas | Yes | `CASGOR` |  |  |
| Diamond Adventure (1983)(MicroCabin)(JP)[!][CLOAD+RUN].cas | Yes | `CASGOR` |  |  |
| Dieet (1986)(Philips)(nl)(Side A)[a][BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Dieet (1986)(Philips)(nl)(Side A)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Dig Dug (1984)(Bug-Byte Software)[BLOAD'CAS-',R].cas | Yes | `CASGOR /N` |  |  |
| Dim-Calc (1985)(DIMensionNEW)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Dimensional Wars (1984)(SoftBank).cas | Yes | `CASGOI /C` |  |  |
| Disc Warrior (1984)(Alligata Software)[a][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Disc Warrior (1984)(Alligata Software)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Disc Warrior (1984)(Micro Cabin)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Discovery (1988)(Eurosoft)[a2][RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Discovery (1988)(Eurosoft)[a][RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Discovery (1988)(Eurosoft)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Disenador de Graficos (1985)(Advance)(es)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Dizzy Ball (1984)(Pony Canyon).cas | Yes | `CASGOR` |  |  |
| Dizzy Balloon (1985)(Pony Canyon)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Dizzy Dice (1988)(Players Software)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Dog Fighter (1986)(Kuma Computers)[a][BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Dog Fighter (1986)(Kuma Computers)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Doki Doki Penguinland (1985)(Sega)(Bitgame Release)[BLOAD'CAS-',R].cas | Yes | `CASGOI /B` |  |  |
| Domino (1985)(DIMensionNEW)(es)[a][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Domino (1985)(DIMensionNEW)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Don Quijote (1987)(Dinamic Software)(es)(Side A)[RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Donkey Kong (1986)(Erbe Software)[RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Donkey Kong (1986)(Ocean Software)[a][RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Donkey Kong (1986)(Ocean Software)[RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Donpan (1983)(Tomy).cas | Yes | `CASGOR` |  |  |
| Doopm Community [BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Double Dragon (1988)(Dro Soft)(es)(Side A)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Double Dragon II - The Revenge (1990)(Dro Soft)(es)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Dr. Jackle and Mr. Wide (1987)(Bulldog)[a][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Dr. Jackle and Mr. Wide (1987)(Bulldog)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Draconic Throne (2017) (GW's Workshop) (1.02) [BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Dracula (1986)(Grupo de Trabajo Software)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Dragon Ninja (1988)(Imagine Software)(Side A)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Dragon Ninja (1988)(Imagine Software)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Dragon Slayer (1985)(Square)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Drazen Petrovic Basket (1989)(Topo Soft)(es)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Driller Tanks (1984)(Hudson Soft).cas | Yes | `CASGOR` |  |  |
| Drome (1987)(Eaglesoft)[a2][RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Drome (1987)(Eaglesoft)[a3][RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Drome (1987)(Eaglesoft)[a][RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Drome (1987)(Eaglesoft)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Dungeon Adventure - Text Only (1984)(Level 9 Computing)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Dustin (1987)(Dinamic Software)(es)[RUN'CAS-'].cas | Yes | `CASGOM /B` |  |  |
| Dynamite Dan (1986)(Mirrorsoft)[BLOAD'CAS-',R].cas | Yes | `CASGOI /N` |  |  |
| Eagle (1987)(Juliet Software).cas | Yes | `CASGOR` |  |  |
| Echec (1985)(Loriciels)(en)[Side A - Library)[Fixed & Translated by GDX, MSX1 Only][RUN'CAS-',r].cas | Yes | `CASGOI /B` |  |  |
| Echec (1985)(Loriciels)(fr)[Side A - Bibliotheque)[Fixed by  GDX, MSX1 Only][RUN'CAS-',r].cas | Yes | `CASGOI /B` |  |  |
| Echec (1985)(Loriciels)[Side A)[RUN'CAS-',r].CAS | Yes | `CASGOI /B` |  |  |
| Eddie Kidd Jump Challenge (1985)(Martech Games)[a][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Eddie Kidd Jump Challenge (1985)(Martech Games)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Eddy - Animation Editor (1984)(Hal Laboratory).CAS | Yes | `CASGOR` |  |  |
| Eggerland Mystery (Microbyte) (Argentina) [RUN'CAS-'] [\_].cas | Yes | `CASGOR /B` |  |  |
| Elevator Action.cas | Yes | `CASGOR /B` |  |  |
| Elidon (1986)(Aackosoft)[a2][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Elidon (1986)(Aackosoft)[a][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Elidon (1986)(Aackosoft)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Eliza - Game Pack 1 (Aackosoft - Eaglesoft) [RUN'CAS-'] [\_].cas | Yes | `CASGOR` |  |  |
| Emerald Isle (1985)(Level 9 Computing)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Emilio Butragueno Futbol (1988)(Topo Soft - Ocean Software)(es)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Emilio Butragueno Futbol II (1989)(Erbe Software - Ocean Software)(es)(Side A)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Emilio Sanchez Vicario Grand Slam (1989)(Zigurat Software)(es)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Enchanted (1989)(Positive)(es)[RUN'CAS-'].cas | Yes | `CASGOR /B` |  |  |
| Engesoft MSXF-07 - Lado A.cas | Yes | `CASGOI /B` |  |  |
| Engesoft MSXF-07 - Lado B.cas | Yes | `CASGOI /CB` |  |  |
| Engesoft MSXF-18- Lado A.cas | Yes | `CASGOI /B` |  |  |
| Engesoft MSXF-18- Lado B.cas | Yes | `CASGOI /B` |  |  |
| Engesoft MSXF-19 - Lado A.cas | Yes | `CASGOR` |  |  |
| Engesoft MSXF-19 - Lado B.cas | Yes | `CASGOR` |  |  |
| Engesoft MSXK-06 - Lado A.cas | Yes | `CASGOI /B` |  |  |
| Engesoft MSXK-06 - Lado B.cas | Yes | `CASGOI /B12` |  |  |
| Engesoft MSXK-13 - Lado A.cas | Yes | `CASGOI /B` |  |  |
| Engesoft MSXK-13 - Lado B.cas | Yes | `CASGOI /B` |  |  |
| English Words (1986)(Aschcom).cas | Yes | `CASGOR` |  |  |
| Enjoy Triangle v3 tape 1 side A - Sky Cleaning.cas | Yes | `CASGOR` |  |  |
| Eric and the Floaters (1983)(Hudson Soft).cas | Yes | `CASGOR` |  |  |
| Erik the Viking (1984)(Level 9 Computing)[fixed][RUN'CAS'].cas | Yes | `CASGOR /CB` |  |  |
| Erik the Viking (1984)(Level 9 Computing)[RUN'CAS'].cas | Yes | `CASGOR /CB` |  |  |
| Erik the Viking Text Ony (1984)(Level 9 Computing)[RUN'CAS'].cas | Yes | `CASGOI /CB` |  |  |
| European Games (1987)(Tynesoft)(Side A)[a][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| European Games (1987)(Tynesoft)(Side A)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| European Games (1987)(Tynesoft)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Exerion (1987)(Eaglesoft)[RUN'CAS-'].cas | Yes | `CASGOI /CB` |  |  |
| Exerion II - Zorni (1987)(Eaglesoft)[RUN'CAS-'].cas | Yes | `CASGOI /CB` |  |  |
| Exploding Atoms (1985)(Sanyo)[a][CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Exploding Atoms (1985)(Sanyo)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Exterminator (1987)(The Bytebusters).cas | Yes | `CASGOR /CB` |  |  |
| Fall Out (1984)(Policy)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Fanky Punky (1987)(P.J. Software)(es)[a][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Fanky Punky (1987)(P.J. Software)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Fantastic Footbal v1.0 (2021).cas | Yes | `CASGOR /B` |  |  |
| Farm (2019) (N.I.) [RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Fernando Martin Basket Master (1987)(Dinamic Software)(es)[BLOAD'CAS-',R].cas | Yes | `CASGOI /C` |  |  |
| Fernando Martin Basket Master - Executive (1987)(Dinamic Software)(es)[a][RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Fernando Martin Basket Master - Executive (1987)(Dinamic Software)(es)[RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Fernando Martin Basket Master - Executive (1987)(Dinamic Software)[RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Feud (1987)(Bulldog)[RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Fharanx (1985)(Enix)[By Django][BLOAD'CAS-',r].cas | Yes | `CASGOR` |  |  |
| Field Master (1985)(Login Soft)[CLOAD+RUN].cas | Yes | `CASGOR` |  |  |
| Fin Pack (1986)(Aackosoft)[a][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Fin Pack (1986)(Aackosoft)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Final Countdown (1988)(Methodic Solutions)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Finders Keepers (1986)(Mastertronic)[needs 64k in slot 2][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Finders Keepers (1986)(Mastertronic)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Fireball (1983) (Hudson Soft)[BLOAD'CAS-',R].CAS | Yes | `CASGOI /C` |  |  |
| Firehawk (1987)(Players Software)[a][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Firehawk (1987)(Players Software)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Fisica I - Magnitudes (1986)(Sony)(es)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Fisica II - Movimientos (1986)(Sony)(es)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Five Holy Girls (1987)(Studio Blue)[BLOAD'CAS-',R].CAS | Yes | `CASGOR` |  |  |
| Flappy (1984)(dB-Soft)(CLOAD+RUN).CAS | Yes | `CASGOR` |  |  |
| Flappy Birds [BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Flash Gordon (1987)(Mastertronic Added Dimension)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Flight Deck II (1986)(Aackosoft)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Flight Path 737 (1985)(Anirog Software)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Flintstones, The (1988)(Grandslam Entertainments)[BLOAD'CAS-',R].cas | Yes | `CASGOI /S` |  |  |
| Floppy el pregunton (19xx)(Manhattan Transfer)(ES)[RUN'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Flower Card (1984)(Central Education).cas | Yes | `CASGOR` |  |  |
| Fnick Li- Fnick La (1986) LOGiN(Sony & Klon).cas | Yes | `CASGOR` |  |  |
| Foggys Quest (2017) (John Blythe) [BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Foot Volley (1986)(Players Software)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Football Manager (1987)(Addictive Games)(GB)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Football Manager - World Cup Edition (1990)(Addictive Games)(es)[RUN'CAS-'].cas | Yes | `CASGOI` |  |  |
| Football Manager - World Cup Edition (1990)(Addictive)[RUN'CAS-'].cas | Yes | `CASGOI` |  |  |
| For MSX Special (1985)(Technopolis Soft).cas | Yes | `CASGOR` |  |  |
| Forbidden Fruit (1985)(Mind Games Espana)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Formation Z (1987)(Eaglesoft)[RUN'CAS-'].cas | Yes | `CASGOI /CB` |  |  |
| Formula 1 Simulator (1985)(Mastertronic)[a][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Formula 1 Simulator (1985)(Mastertronic)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Frankie (1988)(System 4)(ES)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Freddy Hardest (1987)(Dinamic Software)(es)(Side A)[a][RUN'CAS-'].cas | Yes | `CASGOR /B` |  |  |
| Freddy Hardest (1987)(Dinamic Software)(es)(Side A)[RUN'CAS-'].cas | Yes | `CASGOR /B` |  |  |
| Freddy Hardest in South Manhattan (1989)(Dinamic Software)(es)[RUN'CAS-'].cas | Yes | `CASGOT /B` |  |  |
| Freddy Hardest Side A[RUN'CAS-'].cas | Yes | `CASGOR /B` |  |  |
| French is Fun (1984)(CDS Microsystems)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| French is Fun (1984)(CDS Software).cas | Yes | `CASGOR` |  |  |
| Frog (1985)(Advance)(es)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Frogger [BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Front Line (1984)(Taito).cas | Yes | `CASGOR` |  |  |
| Front Line (1984)(Taito)[a].cas | Yes | `CASGOR` |  |  |
| Fruit Machine (1985)(DK'Tronics)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Fruit Panic (1984)(Pony Canyon)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Fun Math for Elementary School Year 4 Vol 2 (1984)(Stratford Computer Center Corporation).cas | Yes | `CASGOI` |  |  |
| Fun Math for Elementary School Year 5 Vol 2 (1984)(Stratford Computer Center Corporation).cas | Yes | `CASGOR` |  |  |
| Fupper (1985)(Login Soft)[CLOAD+BLOAD'CAS-'+RUN].cas | Yes | `CASGOR` |  |  |
| Future Knight (1986)(Erbe Software)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Future Knight (1986)(Gremlin Graphics Software)[BLOAD'CAS-',R].cas | Yes | `CASGOI /S` |  |  |
| Fuzzball (ByteBusters) (Eaglesoft - Premium III Software Distribution) [RUN'CAS-'] [\_].cas | Yes | `CASGOR /CB` |  |  |
| Gagnant (1986) (Humming Bird Soft)[BLOAD'CAS-',r].cas | Yes | `CASGOR` |  |  |
| Galaga (1984)(Bug-Byte Software)[BLOAD'CAS-',R].cas | Yes | `CASGOR /N` |  |  |
| Galaxian (1984)(Bug-Byte Software)[BLOAD'CAS-',R].cas | Yes | `CASGOR /N` |  |  |
| Game Over (1988)(Dinamic Software)(es)(Side A)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Game Over (1988)(Dinamic Software)(Side A)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Game Over II (1988)(Dinamic Software)(Side A)[re-release of Phantis][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Game Pack 2 (1986)(Aackosoft).cas | Yes | `CASGOR` |  |  |
| Games Designer (1985)(Quicksilva)[BLOAD'CAS-',R].cas | Yes | `CASGOI /S` |  |  |
| Games, The - Winter Edition (1988)(US Gold)(Side A)[RUN'CAS-'].cas | Yes | `CASGOI /CB` |  |  |
| Gang Man (1988)(Armati Software)[RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Gangman (1984)(Hudson Soft)[a][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Gangman (1984)(Hudson Soft)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Gauntlet (1986)(US Gold)(Side A)[a][RUN'CAS-'].cas | Yes | `CASGOT /CB` |  |  |
| Gauntlet (1986)(US Gold)(Side A)[RUN'CAS-'].cas | Yes | `CASGOT /CB` |  |  |
| Gemini Wing (1989)(Virgin Mastertronic)(Side A)[Fixed][RUN'CAS-'].cas | Yes | `CASGOI /S8` |  |  |
| Gemini Wing (1989)(Virgin Mastertronic)(Side A)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Genghis Khan (1991)(Positive)[RUN'CAS-'].cas | Yes | `CASGOT /B` |  |  |
| Geo (19xx)(Mind Games Espana)(es)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Geografia de Espana (1985)(Advance)(es)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Gerente, El (1984)(DIMensionNEW)(es)[a][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Gerente, El (1984)(DIMensionNEW)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| GESTE-A.CAS | No | `CASGOR` | X |  |
| Gestion Familiar (1986)(Load 'n' Run)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Ghost (1989)(Mind Games Espana)(es)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Ghostbusters (1985)(Activision)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Ghostbusters II (1989)(Activision)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Glass (1985)(Quicksilva)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Gnome Ranger - Part 1 (1987)(Level 9 Computing)[Cracked][RUN'CAS-'].cas | Yes | `CASGOT /CB` |  |  |
| Gnome Ranger - Part 1 (1987)(Level 9 Computing)[Protected][RUN'CAS-'].cas | Yes | `CASGOT /CB` |  |  |
| Gnome Ranger - Part 2 (1987)(Level 9 Computing)[Cracked][RUN'CAS-'].cas | Yes | `CASGOT /CB` |  |  |
| Gnome Ranger - Part 2 (1987)(Level 9 Computing)[Protected][RUN'CAS-'].cas | Yes | `CASGOT /CB` |  |  |
| Gnome Ranger - Part 3 (1987)(Level 9 Computing)[Cracked][RUN'CAS-'].cas | Yes | `CASGOT /CB` |  |  |
| Gnome Ranger - Part 3 (1987)(Level 9 Computing)[Protected][RUN'CAS-'].cas | Yes | `CASGOT /CB` |  |  |
| GOAL Complete (2019) (G.G.G. Software) [CLOAD + RUN + RUN].cas | Yes | `CASGOR` |  |  |
| GOAL Part 1 (2019) (G.G.G. Software) [CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Golden Basket (1990)(Opera Soft)(es)[BLOAD'CAS-',R].cas | Yes | `CASGOR /C` |  |  |
| Golden Basket (1990)(Opera Soft)(es)[passworded][BLOAD'CAS-',R].cas | Yes | `CASGOR /C` |  |  |
| Golden Grave II (Stratford Computer Center, 1985)(jp)[CLOAD + RUN].CAS | Yes | `CASGOR` |  |  |
| Gonzzalezz (1989)(Opera Soft)(es)(Side A)[BLOAD'CAS-',R].cas | Yes | `CASGOR /C` |  |  |
| Goody (1987)(Opera Soft)(es)[a][BLOAD'CAS-',R].cas | Yes | `CASGOR /C` |  |  |
| Goody (1987)(Opera Soft)(es)[BLOAD'CAS-',R].cas | Yes | `CASGOR /C` |  |  |
| Goonies  [BLOAD'CAS-',R].cas | Yes | `CASGOR /B` |  |  |
| Graficas de Gestion (1985)(DIMensionNEW)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Grand Prix Master (1988)(Dinamic).cas | Yes | `CASGOR` |  |  |
| Graphic Editor (1984)(HAL Laboratories)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Gravitica (2018) (Yusuke Miyauchi) [BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Green Cat Chronical (2018) (N.I.) [Bload'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Gremlins 2 - La Nueva Generacion (1990)(Topo Soft)(es)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Grid Trap (1985)(LiveWire Software)[a][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Grid Trap (1985)(LiveWire Software)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Grog's Revenge (1985)(US Gold)(GB)[RUN'CAS-']-FX2.cas | Yes | `CASGOM /B` |  |  |
| Guillermo Tell (1989)(Opera Soft)(es)[gunstick][BLOAD'CAS-',R].cas | Yes | `CASGOR /C` |  |  |
| Gunfright (1985)(Ultimate Play The Game)[a][BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Gunfright (1985)(Ultimate Play The Game)[BLOAD'CAS-',R].cas | Yes | `CASGOT /C` |  |  |
| Gunman (1983)(Hudson Soft)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Gunsmoke (1987)(Go!)(Side A)[aka Desperado][RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Guntus (2022)(inufuto).cas | Yes | `CASGOR` |  |  |
| Gusano (1985)(Advance)(es)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Gusano (1985)(Advance)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Guttblaster (1988)(Eurosoft)[a][RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Guttblaster (1988)(Eurosoft)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| H.E.R.O. (1984)(Activision)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| H.E.R.O. (1984)(Disprosoft)[Fixed][BLOAD'CAS-',R].CAS | Yes | `CASGOR` |  |  |
| Habilit (1988)(Iber Soft)(es)[RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Hades (1985)(Sony)(ES)[h CEZ][RUN'CAS-'].cas | Yes | `CASGOR /B` |  |  |
| Hammer Boy (1991)(Dinamic Software)(Side A)[RUN'CAS-'].cas | Yes | `CASGOT /S` |  |  |
| Hang-On [BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Hanggliding Game (1985)(Login Soft)[CLOAD+RUN].cas | Yes | `CASGOR` |  |  |
| Happy Fret (1985)(Eaglesoft)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Happy Fret (1985)(Micro Cabin)[a][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Hard Boiled (1987)(Methodic Solutions)[a][RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Hard Boiled (1987)(Methodic Solutions)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Harry Fox Yki no Maoh (1985)(Micro Cabin)(ja)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Harvey Smith's Showjumper (1985)(Software Projects)[passworded][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Harvey Smith's Showjumper (1985)(Software Projects)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Haunted House (1988)(Eurosoft)[a][RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Haunted House (1988)(Eurosoft)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Head Alignment Kit (1985)(Aackosoft)[a][RUN'CAS-'].cas | No | `CASGOI /B` | I | `CASGO /BT` |
| Head Alignment Kit (1985)(Aackosoft)[RUN'CAS-'].cas | No | `CASGOI /B` | I | `CASGO /BT` |
| Head over Heels (1987)(Erbe Software)[RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Head over Heels (1987)(Ocean Software)[a][RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Head over Heels (1987)(Ocean Software)[RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Heist, The (1985)(Aackosoft)[RUN'CAS-'].cas | Yes | `CASGOI /CB` |  |  |
| HELP (1983)(Hudson Soft)[BLOAD'CAS-',R].cas | Yes | `CASGOI /C` |  |  |
| Hercules - Slayer of the Damned (1988)(Gremlin Graphics Software)[BLOAD'CAS-',R].cas | Yes | `CASGOT /S` |  |  |
| Highway Encounter (1985)(Dinamic Software)(es)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Hikohiko Ace (From Valis Club Vol. 1)(1989)(Telenet Japan)(ja).cas | Yes | `CASGOR` |  |  |
| Hique - Game Pack 1 (Aackosoft - Eaglesoft) [RUN'CAS-'] [\_].cas | Yes | `CASGOR` |  |  |
| HiSoft Devpac GENS (1984)(HiSoft)[a][RUN'CAS-'].cas | Yes | `CASGOI /CB` |  |  |
| HiSoft Devpac GENS (1984)(HiSoft)[RUN'CAS-'].cas | Yes | `CASGOI /CB` |  |  |
| HiSoft Devpac MONS (1984)(HiSoft)[RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Hopman (2023) (Inufuto).cas | Yes | `CASGOR` |  |  |
| Hopper (1986)(Eaglesoft)[RUN'CAS-'].cas | Yes | `CASGOR /B` |  |  |
| Hopper - MSX Compilation 5 (ByteBusters) (Aackosoft - Eaglesoft) [RUN'CAS-'] [\_].cas | Yes | `CASGOR /CB` |  |  |
| Hostages (1990)(Infogrames)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Howard the Duck (1987)(Activision)[BLOAD'CAS-',R].cas | Yes | `CASGOI /N` |  |  |
| Humphrey (1984)(Mr. Micro)[a][BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Humphrey (1984)(Mr. Micro)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Humphrey (1988)(Zigurat Software)(es)[a][RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Humphrey (1988)(Zigurat Software)(es)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Hunchback (1984)(Ocean Software)[a][BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Hunchback (1984)(Ocean Software)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Hundra (1988)(Dinamic Software)(es)[a][RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Hundra (1988)(Dinamic Software)(es)[RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Hunt for Red October, The (1988)(Grandslam Entertainments)[BLOAD'CAS-',R].cas | Yes | `CASGOI /S` |  |  |
| Hustler (1984)(Bubblebus Software)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Hydlide (1985)(T&E Soft)[a][BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Hydlide (1985)(T&E Soft)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Hype (1987)(Methodic Solutions)[RUN'CAS-'].cas | Yes | `CASGOI /CB` |  |  |
| HyperSports1[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| HyperSports2[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| HyperSports3[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Hypsys (1989)(Techno Arts)(Side A)[a][RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Hypsys (1989)(Techno Arts)(Side A)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Ice (1986)(Eaglesoft)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Ice-Breaker (1990)(Topo Soft)(es)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| IdeaType - Instructor Mecanografico (1985)(Idealogic)(es)(Side A)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Igloo (1985)(Garbi Soft)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Illusions (1985)(Nice Ideas)(fr)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Impetus (2021)(Inufuto).cas | Yes | `CASGOR` |  |  |
| Impetus+ (2025)(Inufuto).cas | Yes | `CASGOR` |  |  |
| Inca (1987)(Eaglesoft)[a][RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Inca (1987)(Eaglesoft)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Indiana Jones and the Last Crusade (1989)(Erbe Software)(es)(Side A)[a][RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Indiana Jones and the Last Crusade (1989)(Erbe Software)(es)(Side A)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Indiana Jones and the Temple of Doom (1987)(US Gold)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Ingrid's Back  Part 1 (1988)(Level 9 Computing)[Corrupt][RUN'CAS-',R].cas | Yes | `CASGOT /CB` |  |  |
| Ingrid's Back  Part 1 (1988)(Level 9 Computing)[Cracked][RUN'CAS-',R].cas | Yes | `CASGOT /CB` |  |  |
| Ingrid's Back  Part 1 (1988)(Level 9 Computing)[Protected][RUN'CAS-',R].cas | Yes | `CASGOT /CB` |  |  |
| Ingrid's Back  Part 2 (1988)(Level 9 Computing)[Cracked][RUN'CAS-',R].cas | Yes | `CASGOT /CB` |  |  |
| Ingrid's Back  Part 2 (1988)(Level 9 Computing)[Protected][RUN'CAS-',R].cas | Yes | `CASGOT /CB` |  |  |
| Ingrid's Back  Part 3 (1988)(Level 9 Computing)[Cracked][RUN'CAS-',R].cas | Yes | `CASGOT /CB` |  |  |
| Ingrid's Back  Part 3 (1988)(Level 9 Computing)[Protected][RUN'CAS-',R].cas | Yes | `CASGOT /CB` |  |  |
| Ink (2005)(INK TEAM).cas | Yes | `CASGOR` |  |  |
| International Karate (1986)(Endurance Games)[a2][RUN'CAS-'].cas | Yes | `CASGOR /B` |  |  |
| International Karate (1986)(Endurance Games)[a][RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| International Karate (1986)(Endurance Games)[RUN'CAS-'].cas | Yes | `CASGOR /B` |  |  |
| Invaders (1986)(LiveWire Software)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Invierte y Gana (1986)(DIMensionNEW)(es)[RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Iron of the War (19xx)(Mind Games Espana)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Isitar 7 (2019) (N.I.) [RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Italia '90 - World Cup Soccer (1989)(Dro Soft)(es)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Jabato (1989)(Aventuras AD)(es)(Side A)[RUN'CAS-'].cas | Yes | `CASGOT /CB` |  |  |
| Jack the Nipper (1986)(Gremlin Graphics Software)[a][BLOAD'CAS-',R].cas | Yes | `CASGOI /S` |  |  |
| Jack the Nipper (1986)(Gremlin Graphics Software)[BLOAD'CAS-',R].cas | Yes | `CASGOI /S` |  |  |
| Jack the Nipper II - In Coconut Capers (1987)(Gremlin Graphics Software)[BLOAD'CAS-',R].cas | Yes | `CASGOI /S` |  |  |
| Jai Alai (Opera Soft, 1991).cas | Yes | `CASGOR /CB` |  |  |
| Jaws (1989)(Screen 7)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Jet Bomber (1985)(Aackosoft)[a][RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Jet Bomber (1985)(Aackosoft)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Jet Fighter (1985)(Aackosoft)(NL)(en)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Jet Fighter (1988)(Eurosoft)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Jet Fighter - Compilation Tape 1 (ByteBusters) (Aackosoft - Eaglesoft) [RUN'CAS-'] [\_].cas | Yes | `CASGOR /CB` |  |  |
| Jet Set Willy II - The Final Frontier (1985)(Software Projects)[passworded][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Jet Set Willy II - The Final Frontier (1985)(Software Projects)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Jewels of Darkness I - Colossal Adventure v2 (1986)(Level 9 Computing)[a2 - Cracked][RUN'CAS-'].cas | Yes | `CASGOT /CB` |  |  |
| Jewels of Darkness I - Colossal Adventure v2 (1986)(Level 9 Computing)[a2 - Protected][RUN'CAS-'].cas | Yes | `CASGOT /CB` |  |  |
| Jewels of Darkness I - Colossal Adventure v2 (1986)(Level 9 Computing)[a][RUN'CAS-'].cas | Yes | `CASGOT /CB` |  |  |
| Jewels of Darkness I - Colossal Adventure v2 (1986)(Level 9 Computing)[RUN'CAS-'].cas | Yes | `CASGOT /CB` |  |  |
| Jewels of Darkness II - Adventure Quest v2 (1986)(Level 9 Computing)[a2 - Cracked][RUN'CAS-'].cas | Yes | `CASGOT /CB` |  |  |
| Jewels of Darkness II - Adventure Quest v2 (1986)(Level 9 Computing)[a2 - Protected][RUN'CAS-'].cas | Yes | `CASGOT /CB` |  |  |
| Jewels of Darkness II - Adventure Quest v2 (1986)(Level 9 Computing)[a][RUN'CAS-'].cas | Yes | `CASGOT /CB` |  |  |
| Jewels of Darkness II - Adventure Quest v2 (1986)(Level 9 Computing)[RUN'CAS-'].cas | Yes | `CASGOT /CB` |  |  |
| Jewels of Darkness III - Dungeon Adventure v2 (1986)(Level 9 Computing)[a2 - Cracked][RUN'CAS-'].cas | Yes | `CASGOT /CB` |  |  |
| Jewels of Darkness III - Dungeon Adventure v2 (1986)(Level 9 Computing)[a2 - Protected][RUN'CAS-'].cas | Yes | `CASGOT /CB` |  |  |
| Jewels of Darkness III - Dungeon Adventure v2 (1986)(Level 9 Computing)[a][RUN'CAS-'].cas | Yes | `CASGOT /CB` |  |  |
| Jewels of Darkness III - Dungeon Adventure v2 (1986)(Level 9 Computing)[RUN'CAS-'].cas | Yes | `CASGOT /CB` |  |  |
| Joe Blade (1989)(Players Software)[BLOAD'CAS-',R].cas | Yes | `CASGOI` |  |  |
| Johny Comomolo in 3-2-1 Fire (1986)(Dro Soft)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Journey to the Centre of the Earth (1985)(Bug-Byte Software)(Side A)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Jump Jet (1985)(Anirog)(GB)[Run'CAS-'].cas | Yes | `CASGOR` |  |  |
| Jumping Jack (1986)(Livewire).cas | Yes | `CASGOR` |  |  |
| Jungle Warrior (1990)(Zigurat Software)(es)[RUN'CAS-'].cas | Yes | `CASGOR /B` |  |  |
| Juno Lander (1983)(SIL)[CLOAD+RUN].cas | Yes | `CASGOR` |  |  |
| Kaereltje Leert Wiskunde ~ Charlie's Maths Class - Compilation Tape 1 (ByteBusters) (Aackosoft - Eaglesoft) [RUN'CAS-'] [\_].cas | Yes | `CASGOR` |  |  |
| Kamikaze (1984)(Omega Systems)(jp)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Katori Sensō (Mosquito Wars)(UCHUDO)(1984)[BLOAD'CAS-',r].CAS | Yes | `CASGOR` |  |  |
| Ke Rulen los Petas (1989)(Iber Soft)(es)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Keystone Kapers (1984)(Activision).cas | Yes | `CASGOR` |  |  |
| Keystone Kapers(1984)(Activision)[a].cas | Yes | `CASGOR` |  |  |
| Khazzad-Dum (1989)(SPE)(es)[RUN'CAS-'].cas | Yes | `CASGOR /B` |  |  |
| Kick It - MSX Compilation 5 (ByteBusters) (Aackosoft - Eaglesoft) [RUN'CAS-'] [\_].cas | Yes | `CASGOR /CB` |  |  |
| Killer Station (1983) (Hudson Soft)[BLOAD'CAS-',R].CAS | Yes | `CASGOR` |  |  |
| King Leonard (1986)(Mind Games Espana)(es)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| KingsVally[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Klax (1990)(Domark)[BLOAD'CAS-',R].cas | Yes | `CASGOI /S` |  |  |
| Knight Ghost (1987)(Dro Soft)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Knight Lore (1985)(Ultimate Play The Game)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Knight Lore (Ultimate Play The Game)[BLOAD'CAS-',R] [\_].cas | Yes | `CASGOR` |  |  |
| Knight Lore Remake (2009) [BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Knight Orc - Part 1 - Loosed Orc (1987)(Level 9 Computing)[a3 - Cracked][RUN'CAS-'].cas | Yes | `CASGOT /CB` |  |  |
| Knight Orc - Part 1 - Loosed Orc (1987)(Level 9 Computing)[a3 - Protected][RUN'CAS-'].cas | Yes | `CASGOT /CB` |  |  |
| Knight Orc - Part 1 - Loosed Orc (1987)(Rainbird Software)[a2][RUN'CAS-'].cas | Yes | `CASGOT /CB` |  |  |
| Knight Orc - Part 1 - Loosed Orc (1987)(Rainbird Software)[a][RUN'CAS-'].cas | Yes | `CASGOT /CB` |  |  |
| Knight Orc - Part 1 - Loosed Orc (1987)(Rainbird Software)[RUN'CAS-'].cas | Yes | `CASGOT /CB` |  |  |
| Knight Orc - Part 2 - A Kind of Magic (1987)(Level 9 Computing)[a1 - Cracked][RUN'CAS-'].cas | Yes | `CASGOT /CB` |  |  |
| Knight Orc - Part 2 - A Kind of Magic (1987)(Level 9 Computing)[a1 - Protected][RUN'CAS-'].cas | Yes | `CASGOT /CB` |  |  |
| Knight Orc - Part 2 - A Kind of Magic (1987)(Rainbird Software)[passworded][RUN'CAS-'].cas | Yes | `CASGOT /CB` |  |  |
| Knight Orc - Part 2 - A Kind of Magic (1987)(Rainbird Software)[RUN'CAS-'].cas | Yes | `CASGOT /CB` |  |  |
| Knight Orc - Part 3 - Hordes of the Mountain King (1987)(Level 9 Computing)[a1 - Cracked][RUN'CAS-'].cas | Yes | `CASGOT /CB` |  |  |
| Knight Orc - Part 3 - Hordes of the Mountain King (1987)(Level 9 Computing)[a1 - Protected][RUN'CAS-'].cas | Yes | `CASGOT /CB` |  |  |
| Knight Orc - Part 3 - Hordes of the Mountain King (1987)(Rainbird Software)[passworded][RUN'CAS-'].cas | Yes | `CASGOT /CB` |  |  |
| Knight Orc - Part 3 - Hordes of the Mountain King (1987)(Rainbird Software)[RUN'CAS-'].cas | Yes | `CASGOT /CB` |  |  |
| Knight Tyme (1986)(Mastertronic Added Dimension)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Knightmare[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Knockout (1985)(Alligata Software)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Konami's Soccer (1985)(Konami)[h Onaki][RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Kong (1988)(Eurosoft)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Kong (Eurosoft) (VA Holding) (Side A) [RUN'CAS-'] [\_].cas | Yes | `CASGOR /CB` |  |  |
| Kong's Revenge (1991)(Zigurat Software)(es)(Side A)[RUN'CAS-'].cas | Yes | `CASGOM /CB` |  |  |
| Krakout (1987)(Gremlin Graphics Software)[a][BLOAD'CAS-',R].cas | Yes | `CASGOI /S` |  |  |
| Krakout (1987)(Gremlin Graphics Software)[BLOAD'CAS-',R].cas | Yes | `CASGOI /S` |  |  |
| Krom - El Guerrero Invencible (1989)(OMK Software)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Kubus (1985)(Kuma Computers)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Kuma Forth (1984)(Kuma Computers)[a][CLEAR200,&H87FF + BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Kuma Forth (1984)(Kuma Computers)[CLEAR200,&H87FF + BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Kuma Logo (1984)(Kuma Computers)[a][CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Kuma Logo (1984)(Kuma Computers)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Laberinto (1985)(Advance)(es)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Laberinto Binario - Binary Land (Sony Spain) (Indescomp) [BLOAD'CAS-',R] [\_].cas | Yes | `CASGOR` |  |  |
| Lady Safary (1988)(OMK Software)(es)[RUN'CAS-'].cas | Yes | `CASGOR /P3` |  |  |
| Lancelot - Part 1 (1988)(Level 9 Computing)(RUN'CAS-',R].cas | Yes | `CASGOT /CB` |  |  |
| Lancelot - Part 2 (1988)(Level 9 Computing)(RUN'CAS-',R].cas | Yes | `CASGOT /CB` |  |  |
| Lancelot - Part 3 (1988)(Level 9 Computing)(RUN'CAS-',R].cas | Yes | `CASGOT /CB` |  |  |
| Last Dungeon, The (19xx)(Grupo de Trabajo Software)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Last Mission, The (1987)(Opera Soft)(es)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Lazer Bykes (1985)(PSS)[a2][BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Lazer Bykes (1985)(PSS)[a][BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Lazer Bykes (1985)(PSS)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Lazy Jones (1985)(Terminal Software)[a2][RUN'CAS-'].cas | Yes | `CASGOR /B` |  |  |
| Lazy Jones (1985)(Terminal Software)[a][RUN'CAS-'].cas | Yes | `CASGOR /B` |  |  |
| Lazy Jones (1985)(Terminal Software)[RUN'CAS-'].cas | Yes | `CASGOR /B` |  |  |
| Le Mans (1984)(Electric Software)[a][BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Le Mans (1984)(Electric Software)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Legend of White and Black - Ringo Tensei Hen - Tape 1 Side A (1986)(Soft Studio WING).cas | Yes | `CASGOR` |  |  |
| Legends of Star Arthur - Planet Mephius (1985)(T&E Soft)(ja)(Side A)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Let's Computer (1984)(Melsoft & Three Quarter)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Leyendas (19xx)(Mind Games Espana)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Life in the Fast Lane (1987)(Methodic Solutions)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Lift (2021)(Inufuto).cas | Yes | `CASGOR` |  |  |
| Light Corridor, The (1990)(Infogrames)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Like The Monkey King (1984)(Ample Software)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Linez (2018) [Wim Dewijngaert] [BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Linez (2018) [Wim Dewijngaert] [fixed] [BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Livingstone Supongo (1986)(Opera Soft)(es)[BLOAD'CAS-',R].cas | Yes | `CASGOI /C` |  |  |
| Livingstone Supongo (1986)(Opera Soft)(es)[RUN'CAS-'].cas | Yes | `CASGOI /CB` |  |  |
| Livingstone Supongo II (1989)(Opera Soft)(Side A)[BLOAD'CAS-',R].cas | Yes | `CASGOR /C` |  |  |
| Lizard (1985)(Micro Cabin)(ja)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Lizard Willy [BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Lizard Willy [BLOAD'CAS-',R]\_\_Lizard Willy [BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Locke the Superman - Asteroid Kahn  (1984)(Pony Canyon)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Lords Of Time (1983)(Level 9 Computing)[RUN'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Lorna (1990)(Topo Soft)(es)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Los Elfos de Maroland (2023)(Dwalin)(es)(Side A).cas | Yes | `CASGOI /S` |  |  |
| Loto (19xx)(Manhattan Transfer)(es)[a][BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Loto (19xx)(Manhattan Transfer)(es)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Lucky Luke (1985)(Javier Laguna García)(es).cas | Yes | `CASGOR` |  |  |
| Lunar Ball [BLOAD'CAS-',r].cas | Yes | `CASGOR` |  |  |
| M-Droid (19xx)(Blue Ribbon Software)[a][RUN'CAS-'].cas | Yes | `CASGOR /P6` |  |  |
| M-Droid (19xx)(Blue Ribbon Software)[RUN'CAS-'].cas | Yes | `CASGOR /P5` |  |  |
| Mac Attack (1986)(Eaglesoft)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Macadam Bumper (1985)(Players Software)[a2][BLOAD'CAS-',R].cas | No | `CASGOI /S` | X |  |
| Macadam Bumper (1985)(Players Software)[a][BLOAD'CAS-',R].cas | No | `CASGOI /S` | X |  |
| Macadam Bumper (1985)(Players Software)[BLOAD'CAS-',R].cas | No | `CASGOI /S` | X |  |
| Mad Mix 2 - En el Castillo de los Fantasmas (1990)(Topo Soft)(es)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Mad Mix Game (1988)(Topo Soft)(es)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Made in Spain - 5 Estrellas (1985)(Zigurat Software)(es)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Magic Johnson's Basketball (1990)(Dro Soft)(es)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Magic Pinball (1987)(OMK Software)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Magic Tower Adventure (2017)[Timmy] [BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Magical Computer Music L5 Demo (1985)(CBS & Sony)[CLOAD].cas | Yes | `CASGOR` |  |  |
| Mandragore (Infogrames)(1987)(en)(Tape 1 Side A)[BLOAD'CAS-',R].cas | Yes | `CASGOM /C` |  |  |
| Manes (1984)(Ascii)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Manic Miner (1984)(Software Projects)[a][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Manic Miner (1984)(Software Projects)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Map Game (1985)(Erbe Software)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Mappy (1984)(Bug-Byte Software)[BLOAD'CAS-',R].cas | Yes | `CASGOR /N` |  |  |
| Martianoids (1987)(Ultimate Play The Game)[BLOAD'CAS-',R].cas | Yes | `CASGOT /C` |  |  |
| Mask II (1987)(Gremlin Graphics Software)[BLOAD'CAS-',R].cas | Yes | `CASGOI /S` |  |  |
| Mask III - Venom Strikes Back (1988)(Gremlin Graphics Software)[BLOAD'CAS-',R].cas | Yes | `CASGOI /S` |  |  |
| Master Chess (1987)(Mastertronic)[a][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Master Chess (1987)(Mastertronic)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Master of the Lamps (1985)(Activision)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Master Voice (1985)(Aackosoft)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Mastermind - Game Pack 1 (Aackosoft - Eaglesoft) [RUN'CAS-'] [\_].cas | Yes | `CASGOR` |  |  |
| Matamarcianos. Batalla Espacial (1986)(Manhattan Transfer)(es)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Match Day II (1987)(Ocean Software)[RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Maths Invaders (1985)(Aackosoft)[a][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Maths Invaders (1985)(Aackosoft)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Maxima (1984)(PSS)[a][BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Maxima (1984)(PSS)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Mayhem (1985)(Mr. Micro)[BLOAD'CAS-',R].cas | Yes | `CASGOR /C` |  |  |
| Maze Master (1988)(Eurosoft)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Maze Max (1985)(Loriciels)(fr)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Mazes Unlimited (1986)(Eaglesoft)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Maziacs (1985)(DK'Tronics)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Mazogs (2017)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Mazy (2021)(Inufuto).cas | Yes | `CASGOR` |  |  |
| Mazy 2 (2025)(inufuto).cas | Yes | `CASGOR` |  |  |
| Mean Streets (19xx)(Kuma Computers)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Mecom (1988)(Iber Soft)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Mega Chess (1988)(Iber Soft)(es)[aka Super Chess][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Meganova (1988)(Dinamic Software)(es)(Side A)[RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Meganova (1988)(Dinamic Software)(es)[RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Megaphoenix (1991)(Dinamic Software)[RUN'CAS-'].cas | Yes | `CASGOT /B` |  |  |
| Mejor Software - Issue 01 - Guss en la Atlantida (19xx)(Creativos Editoriales)(ES)[a][CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Mejor Software - Issue 01 - Guss en la Atlantida (19xx)(Creativos Editoriales)(ES)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Memory - C.04 (1985)(Computer Users Club)(nl)[position tape + CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Merlin (1987)(Mind Games Espana)(es)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Metropolis (1989)(Topo Soft)(es)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Michel Futbol Master (1989)(Dinamic Software)(es)(Side A)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Michel Futbol Master (1989)(Dinamic Software)(Side A)[RUN'CAS-'].cas | Yes | `CASGOT /B` |  |  |
| Micky-Lucky (Unknown, 198x).cas | Yes | `CASGOR` |  |  |
| Midnight Commander (1983)(Microcabin)(JP)[!][CLOAD   RUN].cas | Yes | `CASGOR` |  |  |
| Milk Race (1987)(Mastertronic)[a][RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Milk Race (1987)(Mastertronic)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Minder (1985) (dK'Tronics) [RUN'CAS-'].cas | Yes | `CASGOR /B` |  |  |
| Miner Machine (1987)(Eaglesoft)[a][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Miner Machine (1987)(Eaglesoft)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Mini-Golf (1984)(Advance)(es)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Mision en Espana (19xx)(Mind Games Espana)(es)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Mision Rescate (1986)(Anaya Multimedia)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Missing In The Okhotsk - Scene 1 (1985)(Login Soft)(Tape 1 - Side A)(ja)[BLOAD'CAS-',r].cas | Yes | `CASGOI` |  |  |
| Misterio del Nilo, El (1987)(Zigurat Software)(es)[a][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Misterio del Nilo, El (1987)(Zigurat Software)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Miyuki Memorial Doors (1984)(Kitty Records)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Miyuki Memorial Doors (1984)(Kitty Records)[CLOAD + RUN]\_\_Miyuki Memorial Full Archive (.CAS, LP & Listing).cas | Yes | `CASGOR` |  |  |
| Miyuki Memorial Graphics & Doors (1984)(Kitty Records)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Miyuki Memorial Graphics & Doors (1984)(Kitty Records)[CLOAD + RUN]\_\_Miyuki Memorial Graphics & Doors (1984)(Kitty Records)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Miyuki Memorial Graphics (1984)(Kitty Records)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Miyuki Memorial Graphics (1984)(Kitty Records)[CLOAD + RUN]\_\_Miyuki Memorial Graphics (1984)(Kitty Records)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Miyuki The Gambler (1984)(Central Education)(ja){Side A).cas | Yes | `CASGOR` |  |  |
| Mocky (1985)(Login Soft)[CLOAD+BLOAD'CAS-'+RUN].cas | Yes | `CASGOR` |  |  |
| Molecule Man (1986)(Mastertronic)[a][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Molecule Man (1986)(Mastertronic)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Monopoly (1986)(Leisure Genius)[RUN'CAS-'].cas | Yes | `CASGOI /CB` |  |  |
| Moon Rider (1986)(Eaglesoft)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Moonwalker (1989)(US Gold)[a][RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Moonwalker (1989)(US Gold)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Mortadelo y Filemon (1988)(Dro Soft)(es)[RUN'CAS-'].cas | Yes | `CASGOI /S2` |  |  |
| Mortadelo y Filemon II - Safari Callejero (1990)(Dro Soft)(es)(Side A)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Most Amazing Memory Game, The (1986)(Idealogic)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Mot (1989)(Opera Soft)(es)(Side A)[BLOAD'CAS-',R].cas | Yes | `CASGOR /C` |  |  |
| Motkonqe (2017) (N.I.)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Motorista Sideral, El (1986)(Anaya Multimedia)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Mountain Bike Racer (1990)(Positive)[RUN'CAS-'].cas | Yes | `CASGOT /B` |  |  |
| Mr. Jaws (1987)(The Bytebusters).cas | Yes | `CASGOR /CB` |  |  |
| Mr. Wong's Loopy Laundry (1984)(Artic Computing)[a][BLOAD'CAS-',R].cas | Yes | `CASGOI /B` |  |  |
| Mr. Wong's Loopy Laundry (1984)(Artic Computing)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| MST-Calc (1985)(MST Consultants)[CLOAD+RUN].cas | Yes | `CASGOR` |  |  |
| MSX Screendump (1986)(Philips)(nl)[a][BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| MSX Screendump (1986)(Philips)(nl)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| MSX Tank alkuperN╠âisen taso 2 korjattu.cas | Yes | `CASGOR` |  |  |
| MSX Tank.cas | Yes | `CASGOR` |  |  |
| MSXtra - 3D Knockout (1986)[Alligata][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| MSXtra - Blagger (1986)[Alligata][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| MSXtra - Disc Warrior (1986)[Alligata][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| MSXtra - Superbowl (1986)[Alligata][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Mundial de Futbol (1990)(Opera Soft)(es)(Side A)[BLOAD'CAS-',R].cas | Yes | `CASGOR /C` |  |  |
| Mundo Perdido, El (1988)(Topo Soft)(es)[RUN'CAS-'].cas | Yes | `CASGOR /S` |  |  |
| Mutan Zone (1989)(Opera Soft)(es)(Side A)[a][BLOAD'CAS-',R].cas | Yes | `CASGOR /C` |  |  |
| Mutan Zone (1989)(Opera Soft)(es)(Side A)[BLOAD'CAS-',R].cas | Yes | `CASGOR /C` |  |  |
| Mutant Monty (1985)(Artic Computing)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Mystery House (1983)(Micro Cabin)(ja)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Mystery House II (1984)(Micro Cabin)(en)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Mystery House II (1984)(Micro Cabin)(ja)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Mystery Of The Mu Continent (1984)(Stratford Computer Center Corporation)(ja)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Mystical (1991)(Infogrames)(Side A)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Mythos (1990)(Opera Soft)[a][BLOAD'CAS-',R].cas | Yes | `CASGOR /C` |  |  |
| Mythos (1990)(Opera Soft)[BLOAD'CAS-',R].cas | Yes | `CASGOR /C` |  |  |
| Naitou Kunio no Tsume Shougi (1984)(Apollo Technica)(Side A)(JP)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| NAMPA-A.CAS | Yes | `CASGOR` |  |  |
| Narco Police (1990)(Dinamic Software)(Side A)[a][RUN'CAS-'].cas | Yes | `CASGOI /B15` |  |  |
| Narco Police (1990)(Dinamic Software)(Side A)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Navy Moves (1988)(Dinamic Software)(es)(Side A)[a][RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Navy Moves (1988)(Dinamic Software)(es)(Side A)[RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Navy Moves (1988)(Dinamic Software)(Side A)[RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Neuras (2021)(Inufuto).cas | Yes | `CASGOR` |  |  |
| Nick Neaker (1983)(Colpax).cas | Yes | `CASGOR` |  |  |
| Night Flight (1982)(Nippon Columbia - Colpax - Universal)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Nightlife (1985)(Koei)(ja).cas | Yes | `CASGOR` |  |  |
| Nightshade (1985)(Ultimate Play The Game)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Nikonikopun What Is It (1984)(NHK Gakuen)(ja).cas | Yes | `CASGOR` |  |  |
| Ninja 2. Ninja Jaja Maru Kun (1987)(Eaglesoft)[RUN'CAS-'].cas | Yes | `CASGOI /CB` |  |  |
| Ninja-kun - Magic Castle Adventure (1985)(Jaleco).cas | Yes | `CASGOI /CB` |  |  |
| Ninjya Kage (1984)(Hudson Soft).cas | Yes | `CASGOR` |  |  |
| Nohzdyve (2019) (Giovanni Nunes Matt Wescott)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Nonamed (1986)(Dinamic Software)(es)[a][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Nonamed (1986)(Dinamic Software)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| North & South (1991)(Infogrames)(M3)(Side A)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| North Sea Bullion Adventure (1985)(Kuma Computers)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| North Sea Helicopter (1987)(Aackosoft)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| North Sea Helicopter (Aackosoft, 1985).cas | Yes | `CASGOR /CB` |  |  |
| Nuclear Bowls (1986)(Zigurat Software)(es)[RUN'CAS-'].cas | Yes | `CASGOI /CB` |  |  |
| Obliterator (1989)(Dro Soft)(es)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Ocean Conqueror (1987)(Mastertronic)[RUN'CAS-'].cas | Yes | `CASGOR /B` |  |  |
| Oceano (2015) (EgoTrip) [BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Octagon Squad (1986)(Mastertronic)[a2][RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Octagon Squad (1986)(Mastertronic)[a][RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Octagon Squad (1986)(Mastertronic)[RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Octopuss MSX Panic (1986)(Eoe)(fr)[Fixed][BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Offering (1984)(AI Inc.)[RUN'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Oh Mummy!! (1984)(Longman Software)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Oh no! (Aka Oh Shit!) [Aackosoft] [Disprosoft] [1986][CLOAD+RUN].CAS | Yes | `CASGOR` |  |  |
| Oh Shit! (1986)(Aackosoft)[a][RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Oh Shit! (1986)(Aackosoft)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Oh Shit! (ByteBusters) (Aackosoft - Eaglesoft) [RUN'CAS-'] [\_].cas | Yes | `CASGOR /CB` |  |  |
| Oh Shit! - MSX Compilation 5 (ByteBusters) (Aackosoft - Eaglesoft) [RUN'CAS-'] [\_].cas | Yes | `CASGOR /CB` |  |  |
| OhShit![File-Hunter.com].cas | Yes | `CASGOR` |  |  |
| Oil's Well (1985)(Eaglesoft)[RUN'CAS-'].cas | Yes | `CASGOI /CB` |  |  |
| Operation Wolf (1988)(Ocean Software)(Side A)[a][BLOAD'CAS-',R].cas | Yes | `CASGOI /C` |  |  |
| Operation Wolf (1988)(Ocean Software)(Side A)[BLOAD'CAS-',R].cas | Yes | `CASGOI /C` |  |  |
| Operation Wolf (1988)(Ocean Software)[BLOAD'CAS-',R].cas | Yes | `CASGOI /C` |  |  |
| Oregon Trail  (2020) (Cobinee and Jitursan) [BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Ormuz (1988)(Iber Soft)(es)[a][RUN'CAS-'].cas | Yes | `CASGOR /B` |  |  |
| Ormuz (1988)(Iber Soft)(es)[RUN'CAS-'].cas | Yes | `CASGOR /B` |  |  |
| Ortografia I - Vocabulario (19xx)(Mind Games Espana)(es)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Ortografia II - Verbos (19xx)(Mind Games Espana)(es)[a][CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Ortografia II - Verbos (19xx)(Mind Games Espana)(es)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Ortografia III - Frases (19xx)(Mind Games Espana)(es)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Ostrich (1985)(Columbia) [CLOAD-RUN].cas | Yes | `CASGOR` |  |  |
| Otto e Trenta (1985)(Melchioni Informatica)(it).cas | Yes | `CASGOR` |  |  |
| Ougon no Haka. Golden Tomb. Mystery of Egypt (1984)(Magical Zoo)(ja)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Oushou (King) (1984)(Microcabin)(ja).cas | Yes | `CASGOR` |  |  |
| Out Run (1988)(US Gold)[a][BLOAD'CAS-',R].cas | Yes | `CASGOI /S` |  |  |
| Out Run (1988)(US Gold)[a][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Out Run (1988)(US Gold)[BLOAD'CAS-',R].cas | Yes | `CASGOI /S` |  |  |
| Out Run (1988)(US Gold)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Outroyd (1985)(Magical Zoo)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Outroyd (1985)(Magical Zoo)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| PAC-01 - Arcs (2021).cas | Yes | `CASGOR` |  |  |
| Pac-Land (1988)(Grandslam Entertainments)[BLOAD'CAS-',R].cas | Yes | `CASGOI /S` |  |  |
| Pac-Man (1984)(Bug-Byte Software)[BLOAD'CAS-',R].cas | Yes | `CASGOR /N` |  |  |
| Pac-Mania (1988)(Grandslam Entertainments)[BLOAD'CAS-',R].cas | Yes | `CASGOI /S` |  |  |
| Pac-Mania (1988)(Grandslam Entertainments)[BLOAD'CAS-',R]\_\_Pac-Mania (Grandslam) (Zafiro) [BLOAD'CAS-',R] [\_].cas | Yes | `CASGOI /S` |  |  |
| Pac-Mania (1988)(Grandslam Entertainments)[BLOAD'CAS-',R]\_\_Pac-Mania (Grandslam) (Zafiro).cas | Yes | `CASGOI /S` |  |  |
| Pac-Mania (Grandslam) (Zafiro) [\_] [LOADERFIX].cas | Yes | `CASGOI /S` |  |  |
| Pac-Mania (Grandslam) (Zafiro) [BLOAD'CAS-',R] [\_] [LOADERFIX].cas | Yes | `CASGOI /S` |  |  |
| Paises de America (1984)(Sony)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Paises de Asia (1984)(Sony)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Panel Panic (1986)(Eaglesoft)[a][RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Panel Panic (1986)(Eaglesoft)[RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Panic The Train (1984)(Centralsoft).cas | Yes | `CASGOR` |  |  |
| Panique (1986)(Eaglesoft)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Paris-Dakar (1988)(Zigurat Software)(es)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Passing Shot (1989)(Image Works)[BLOAD'CAS-',R].cas | Yes | `CASGOI /S` |  |  |
| Pastfinder (1984)(Activision)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Payaso Explorador, El (1986)(Anaya Multimedia)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Pentagram (1986)(Ultimate Play The Game)[BLOAD'CAS-',R].cas | Yes | `CASGOT /C` |  |  |
| Pepe Saltarin (1986)(Grupo de Trabajo Software)(es)[a][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Pepe Saltarin (1986)(Grupo de Trabajo Software)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Perico Delgado Maillot Amarillo (1989)(Topo Soft)(es)(Side A)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| PERT (1986)(DIMensionNEW)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Pescador Espacial, El (1986)(Anaya Multimedia)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Peter Beardsley's International Football (1988)(Grandslam Entertainments)[BLOAD'CAS-',R].cas | Yes | `CASGOI /S` |  |  |
| Phantis (1987)(Dinamic Software)(es)(Side A)[a][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Phantis (1987)(Dinamic Software)(es)(Side A)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Phantomas 2 (1986)(Dinamic)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Phantomas 2 (1987)(Dinamic Software)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Pharaoh's Revenge (1988)(Eurosoft)[a][RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Pharaoh's Revenge (1988)(Eurosoft)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Phfile (19xx)(Philips)(es)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Pico Pico (1983)(Micro Cabin)[a][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Pico Pico (1983)(Micro Cabin)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Pico Pico (Micro Cabin) (Toshiba) (Japan) [CLOAD-RUN] [\_].cas | Yes | `CASGOR` |  |  |
| Pico Pico (Side A) (Micro Cabin) (Toshiba) (Japan) [CLOAD-RUN] [\_].cas | Yes | `CASGOR` |  |  |
| picopico\_toshiba.cas | Yes | `CASGOR` |  |  |
| picopico\_toshiba\_a.cas | Yes | `CASGOR` |  |  |
| picopico\_toshiba\_b.cas | Yes | `CASGOR` |  |  |
| Pinball Blaster (1988)(Eurosoft)[a][RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Pinball Blaster (1988)(Eurosoft)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Pink Panther (1988)(Dro Soft)[RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Pippo La Scopa Ficcanaso (2021)(Gamecast).CAS | Yes | `CASGOR` |  |  |
| Pirates (1988)(Halley Software)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Pitfall II - Lost Caverns (1985)(Activision)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Playhouse Strippoker (1988)(Eurosoft)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Poder Oscuro, El (1988)(Zigurat Software)(es)[RUN'CAS-'].cas | Yes | `CASGOR /B` |  |  |
| Polar Star (1984)(Micro Cabin)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Polar Star (1984)(Micro Cabin)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Police Academy (1986)(Eaglesoft)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Police Academy II (1987)(Methodic Solutions)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Police Dog (1984)(Hudson Soft).cas | Yes | `CASGOR` |  |  |
| Poogaboo (1991)(Opera Soft)(es)[a][passworded][BLOAD'CAS-',R].cas | Yes | `CASGOR /C` |  |  |
| Poogaboo (1991)(Opera Soft)(es)[BLOAD'CAS-',R].cas | Yes | `CASGOR /C` |  |  |
| Poogaboo (1991)(Opera Soft)(es)[passworded][BLOAD'CAS-',R].cas | Yes | `CASGOR /C` |  |  |
| Portopia Serial Murder Case (1985)(Enix)(ja)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Post Mortem (1988)(Iber Soft)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Power and Magic (1990)(Zigurat Software)(es)[a][RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Power and Magic (1990)(Zigurat Software)(es)[RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Power Drift (1989)(Activision)(Side A)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Previsiones (1986)(Load 'n' Run)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Principe y el Dragon, El (1985)(Advance)(es)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Professional Baseball Super Simulation (1984)(JDS)(ja)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Professional Snooker Simulator (1987)(Codemasters)(M3)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Professional Tennis Simulator (1990)(Dinamic Software)[aka Simulador Profesional de Tenis][RUN'CAS-'].cas | Yes | `CASGOT /B` |  |  |
| Project A (1984)(Pony Canyon)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Protector, The (1987)(Eaglesoft)[a][RUN'CAS-'].cas | Yes | `CASGOI /CB` |  |  |
| Protector, The (1987)(Eaglesoft)[RUN'CAS-'].cas | Yes | `CASGOI /CB` |  |  |
| Psychedelia (1984)(Aackosoft)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Psycho Pig U.X.B. (1988)(US Gold)[RUN'CAS-'].cas | Yes | `CASGOR /B` |  |  |
| Punch And Judy (1989)(Alternative Software)[run'CAS-'].cas | Yes | `CASGOI /CB` |  |  |
| Punchy (1984)(Mr. Micro)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Puzzybox (2021)(Gamecast).cas | Yes | `CASGOR` |  |  |
| Pwnd 3 (2019) (Metal Soft) (v1.1) [BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Pyramid Warp (1983)(T&E Soft)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Pyro-Man (Nice Ideas)(1985)(Fr)[Cload + Run].cas | Yes | `CASGOR` |  |  |
| Quartet (2019) (Ilkke and bitsofbas) (v1.1) [BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Quartet (2019) (Ilkke and bitsofbas) [BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Quebert (1988)(Eurosoft)[a2][RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Quebert (1988)(Eurosoft)[a][RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Quebert (1988)(Eurosoft)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Queen's Golf (1984)(Ascii)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| QUEEN.CAS | Yes | `CASGOR` |  |  |
| R.A.M. (1990)(Topo Soft)(es)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Race City (1988)(Iber Soft)(es)[RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Rally-X (1984)(Bug-Byte Software)[BLOAD'CAS-',R].cas | Yes | `CASGOR /N` |  |  |
| Rambo III (1988)(Ocean Software)(Side A)[a][BLOAD'CAS-',R].cas | Yes | `CASGOI /C` |  |  |
| Rambo III (1988)(Ocean Software)(Side A)[BLOAD'CAS-',R].cas | Yes | `CASGOI /C` |  |  |
| Rambo III (1988)(Ocean Software)[BLOAD'CAS-',R].cas | Yes | `CASGOI /C` |  |  |
| Rampart, The (1988)(Iber Soft)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Rath-Tha (1989)(Positive)(es)[RUN'CAS-'].cas | Yes | `CASGOR /B` |  |  |
| Red Dawn (1988)(Eurosoft)[a][RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Red Dawn (1988)(Eurosoft)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Red Moon (1985)(Level 9 Computing)[RUN'CAS-',R].cas | Yes | `CASGOR /B` |  |  |
| Reflex (1987)(Players Software)(Side A)[a2][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Reflex (1987)(Players Software)(Side A)[a][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Reflex (1987)(Players Software)(Side A)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Relics (1986)(Bothtec)(Side A)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Renegade III - The Final Chapter (1989)(Imagine Software)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Rescate Atlantida (1989)(Dinamic Software)(es)(Side A)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Rescate Atlantida (1989)(Dinamic Software)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Rescate en el Golfo (1990)(Opera Soft)(es)(Side A)[a][BLOAD'CAS-',R].cas | Yes | `CASGOR /C` |  |  |
| Rescate en el Golfo (1990)(Opera Soft)(es)(Side A)[BLOAD'CAS-',R].cas | Yes | `CASGOR /C` |  |  |
| Rescate en el Golfo (1990)(Opera Soft)(es)(Side A)[passworded][BLOAD'CAS-',R].cas | Yes | `CASGOR /C` |  |  |
| Return To Eden (1984)(Level 9 Computing)[RUN'CAS-',R].cas | Yes | `CASGOR /CB` |  |  |
| Risky Holding (1986)(DIMensionNEW)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| River Chase (1984)(Soft Pro International)(JP)(en)[!][CLOAD + RUN][v0.8.5b].cas | Yes | `CASGOR` |  |  |
| River Chase (Soft Pro International) [v0.8.5b fixed] [CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| River Raid (1984)(Activision)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Robocop (1988)(Ocean Software)(Side A)[BLOAD'CAS-',R].cas | Yes | `CASGOI /C` |  |  |
| Robot Wars (1986)(Eaglesoft)[RUN'CAS-'].cas | Yes | `CASGOT /B` |  |  |
| Robot Wars (ByteBusters) (Aackosoft - Eaglesoft) (Compulogical) [\_].cas | Yes | `CASGOT /B` |  |  |
| Roboy (1987)(Methodic Solutions)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Rock 'n Roller (1988)(Topo Soft)(es)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Rocky (1985)(Dinamic Software)(es)[a][RUN'CAS-'].cas | Yes | `CASGOI /B14` |  |  |
| Rocky (1985)(Dinamic Software)(es)[RUN'CAS-'].cas | Yes | `CASGOI /B14` |  |  |
| Roller (1987)(Triosoft)[RUN'CAS-',r].cas | Yes | `CASGOI /B` |  |  |
| Roma - La Conquista del Imperio (1986)(Idealogic)(es)[RUN'CAS-'].cas | Yes | `CASGOR /B` |  |  |
| Roulette (Side A) (Spectravideo) [\_] [CLOAD-RUN].cas | Yes | `CASGOR` |  |  |
| Roulette (Spectravideo) [\_] [CLOAD-RUN].cas | Yes | `CASGOR` |  |  |
| Roulette - Game Pack 1 (Aackosoft - Eaglesoft) [RUN'CAS-'] [\_].cas | Yes | `CASGOR` |  |  |
| RSC Ensamblador (19xx)(Manhattan Transfer)(es)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Runner (1986)(Loriciels)(fr)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Running Man, The (1989)(Grandslam Entertainments)(es)(Side A)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Ruptus (2021)(Inufuto).cas | Yes | `CASGOR` |  |  |
| RUR1.cas | Yes | `CASGOI /S` |  |  |
| RUR2.cas | Yes | `CASGOI /S` |  |  |
| Sabotaje (1988)(P.J. Software)(es)[a][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Sabotaje (1988)(P.J. Software)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Saboteur 2 (2026)(Clive Townsend)(Port by Thealfest).cas | Yes | `CASGOR /CB` |  |  |
| Saboteur 2 v1.02 (2026)(Clive Townsend)(Port by Thealfest).cas | Yes | `CASGOR /CB` |  |  |
| Sabrina (1989)(Iber Soft)(es)[RUN'CAS-'].cas | Yes | `CASGOM` |  |  |
| Saint Dragon (1990)(Dro Soft)(Side A)[RUN'CAS-'].cas | Yes | `CASGOT /S` |  |  |
| Samantha Fox Strip Poker (1986)(Martech Games)[a][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Satan (1989)(Dinamic Software)(es)(Side A)[RUN'CAS-'].cas | Yes | `CASGOR /B` |  |  |
| Satan (1989)(Dinamic Software)(Side A)[RUN'CAS-'].cas | Yes | `CASGOR /B` |  |  |
| Scapeghost - Part 1 (1989)(Level 9 Computing)[RUN'CAS-',R].cas | Yes | `CASGOT /CB` |  |  |
| Scapeghost - Part 2 (1989)(Level 9 Computing)[RUN'CAS-',R].cas | Yes | `CASGOT /CB` |  |  |
| Scapeghost - Part 3 (1989)(Level 9 Computing)[RUN'CAS-',R].cas | Yes | `CASGOT /CB` |  |  |
| Scentipede (1986)(Eaglesoft)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Science Fiction (1986)(Eaglesoft)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Score 3020 (1988)(Topo Soft)(es)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Scrabble(1986)[Leisure Games][RUN'CAS-'].cas | Yes | `CASGOI /CB` |  |  |
| Scrabble(1986)[Leisure Genius][RUN'CAS-'].cas | Yes | `CASGOI /CB` |  |  |
| Scramble Spirits (1990)(Grandslam Entertainments)(Side A)[a][BLOAD'CAS-',R].cas | Yes | `CASGOI /S` |  |  |
| Scramble Spirits (1990)(Grandslam Entertainments)(Side A)[BLOAD'CAS-',R].cas | Yes | `CASGOI /S` |  |  |
| Sea Bomber (1983)(Hudson Soft)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Sea Hunter (1985)(Spectravideo).cas | Yes | `CASGOR` |  |  |
| Sea King (1986)(Players Software)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Senda Salvaje (1990)(Zigurat Software)(es)(Side A)[RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Shark Hunter (1984)(Electric Software)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Shinobi (1989)(Virgin Games)(Side A)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Ship (1989)(Eurosoft)(es)[BLOAD'CAS-',R].cas | Yes | `CASGOR /P4` |  |  |
| Shup. Trebol (1986)(Mind Games Espana)(es)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Silent Shadow (1988)(Topo Soft)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Silfi (1988)(Iber Soft)(es)[aka Elidon][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Silicon Dreams I - Snowball v2 (1986)(Level 9 Computing)[a1 - Cracked][RUN'CAS-'].cas | Yes | `CASGOT /CB` |  |  |
| Silicon Dreams I - Snowball v2 (1986)(Level 9 Computing)[a1 - Protected][RUN'CAS-'].cas | Yes | `CASGOT /CB` |  |  |
| Silicon Dreams I - Snowball v2 (1986)(Level 9 Computing)[a][RUN'CAS-'].cas | Yes | `CASGOT /CB` |  |  |
| Silicon Dreams I - Snowball v2 (1986)(Level 9 Computing)[RUN'CAS-'].cas | Yes | `CASGOT /CB` |  |  |
| Silicon Dreams II - Return to Eden (1984)(Level 9 Computing)[BLOAD'CAS-',R].cas | Yes | `CASGOI /B` |  |  |
| Silicon Dreams II - Return to Eden (1984)(Level 9 Computing)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Silicon Dreams II - Return to Eden v2 (1986)(Level 9 Computing)[a1 - Cracked][RUN'CAS-'].cas | Yes | `CASGOT /CB` |  |  |
| Silicon Dreams II - Return to Eden v2 (1986)(Level 9 Computing)[a1 - Protected][RUN'CAS-'].cas | Yes | `CASGOT /CB` |  |  |
| Silicon Dreams II - Return to Eden v2 (1986)(Level 9 Computing)[a][RUN'CAS-'].cas | Yes | `CASGOT /CB` |  |  |
| Silicon Dreams II - Return to Eden v2 (1986)(Level 9 Computing)[RUN'CAS-'].cas | Yes | `CASGOT /CB` |  |  |
| Silicon Dreams III - The Worm in Paradise v2 (1986)(Level 9 Computing)[a1 - Cracked][RUN'CAS-'].cas | Yes | `CASGOT /CB` |  |  |
| Silicon Dreams III - The Worm in Paradise v2 (1986)(Level 9 Computing)[a1 - Protected][RUN'CAS-'].cas | Yes | `CASGOT /CB` |  |  |
| Silicon Dreams III - The Worm in Paradise v2 (1986)(Level 9 Computing)[a][RUN'CAS-'].cas | Yes | `CASGOT /CB` |  |  |
| Silicon Dreams III - The Worm in Paradise v2 (1986)(Level 9 Computing)[RUN'CAS-'].cas | Yes | `CASGOT /CB` |  |  |
| Silvestro Spazzino Maldestro - Gianluca Barfi (1986)(it).cas | Yes | `CASGOR` |  |  |
| Simulador Profesional de Tenis (1990)(Dinamic Software)(es)[RUN'CAS-'].cas | Yes | `CASGOT /B` |  |  |
| Sir Fred (1986)(Zigurat Software)(es)[RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Sirwood (1990)(Opera Soft)(Side A)[BLOAD'CAS-',R].cas | Yes | `CASGOR /C` |  |  |
| Sito Pons 500cc Grand Prix (1990)(Zigurat Software)(es)[RUN'CAS-'].cas | Yes | `CASGOM /CB` |  |  |
| Skate Dragon (1986)(Idealogic)(es)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Skooter (1987)(Eaglesoft)[RUN'CAS-'].cas | Yes | `CASGOI /C` |  |  |
| Skramble (1985)(Aackosoft)[RUN'CAS-'].cas | Yes | `CASGOI /CB` |  |  |
| Skramble - Compilation Tape 1 (ByteBusters) (Aackosoft - Eaglesoft) [RUN'CAS-'] [\_].cas | Yes | `CASGOR /CB` |  |  |
| Skull Exilon (1988)(Iber Soft)[aka Safari X][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Sky Diver (1984)(Hudson Soft).cas | Yes | `CASGOR` |  |  |
| Sky Vision (1987)(Eaglesoft)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Sky War (1988)(OMK Software)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Skyhawk (1986)(Bug-Byte Software)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Slapshot (1985)(Anirog Software)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Slime Center (2014)(N.I.)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Slot-Machine (1985)(Creating Soft).cas | Yes | `CASGOR` |  |  |
| sm221.cas | Yes | `CASGOR` |  |  |
| sm221\_a.cas | Yes | `CASGOR` |  |  |
| sm221\_b.cas | Yes | `CASGOR` |  |  |
| sm245.cas | Yes | `CASGOR` |  |  |
| sm245\_b.cas | Yes | `CASGOR` |  |  |
| sm330.cas | Yes | `CASGOR` |  |  |
| sm330\_a.cas | Yes | `CASGOR` |  |  |
| sm330\_b.cas | Yes | `CASGOR` |  |  |
| Smack Wacker (1986)(Eaglesoft)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Smash (1984)(Spectravideo)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Snake It (1986)(Eaglesoft)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Snowball (1986)(Level 9 Computing)[RUN'CAS-',R].cas | Yes | `CASGOI /CB` |  |  |
| Snowman, The (1984)(Quicksilva)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Soccer Boss (The Boss) (1987)(Alternative Software[CLOAD+RUN].cas | Yes | `CASGOR` |  |  |
| Sol Negro (1989)(Opera Soft)(es)(Side A)[a][BLOAD'CAS-',R].cas | Yes | `CASGOR /C` |  |  |
| Sol Negro (1989)(Opera Soft)(es)(Side A)[BLOAD'CAS-',R].cas | Yes | `CASGOR /C` |  |  |
| Soldier of Light (1989)(Dro Soft)(es)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Solfeggietto - Game Pack 1 (Aackosoft - Eaglesoft) [RUN'CAS-'] [\_].cas | Yes | `CASGOR` |  |  |
| Solo (1989)(Opera Soft)(es)[gunstick][BLOAD'CAS-',R].cas | Yes | `CASGOR /C` |  |  |
| Sootland (1988)(Zafiro Software Division)(es)(Side A)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Sorcery (1985)(Virgin Games)[a][RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Sorcery (1985)(Virgin Games)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Soul of a Robot (1987)(Mastertronic)[RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Soviet (1990)(Opera Soft)(Side A)[BLOAD'CAS-',R]-FX2A.cas | Yes | `CASGOR /C` |  |  |
| Soviet (1990)(Opera Soft)(Side A)[BLOAD'CAS-',R].cas | Yes | `CASGOR /C` |  |  |
| Space Busters (1985)(Aackosoft)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Space Busters (1986)(Eaglesoft)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Space Busters - Compilation Tape 1 (ByteBusters) (Aackosoft - Eaglesoft) [RUN'CAS-'] [\_].cas | Yes | `CASGOR` |  |  |
| Space Harrier II (1990)(Grandslam)(GB)(Side A)[BLOAD'CAS\_',R].cas | Yes | `CASGOI /S` |  |  |
| Space Rescue (1988)(Eurosoft)[a2][RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Space Rescue (1988)(Eurosoft)[a][RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Space Rescue (1988)(Eurosoft)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Space Rescue - MSX Compilation 5 (ByteBusters) (Aackosoft - Eaglesoft) [RUN'CAS-'] [\_].cas | Yes | `CASGOR /CB` |  |  |
| Space Shuttle - A Journey into Space (1986)(Activision)[b][BLOAD'CAS-',R].cas | Yes | `CASGOI /N` |  |  |
| Space Smugglers (1989)(MHT Ingenieros)(es)[gunstick][RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Space Walk (1985)(Mastertronic)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Spartan X (1985)(Pony Canyon)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Special Operations (1985)(MC Lothlorien)[a][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Special Operations (1985)(MC Lothlorien)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Spectravideo SVI-728 Introduction-Demonstration (1984)(Spectravideo).cas | Yes | `CASGOR` |  |  |
| Speed King (1986)(Mastertronic)[a][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Speed King (1986)(Mastertronic)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Speedboat Racer (1987)(Methodic Solutions)[RUN'CAS-'].cas | Yes | `CASGOR /B` |  |  |
| Spellbound (2023)(Mastropiero).cas | Yes | `CASGOR` |  |  |
| Spellbound (2023)(Mastropiero)[BLOAD'CAS-',R][Bugfix 11-02-2024].cas | Yes | `CASGOR /B` |  |  |
| Spirits (1987)(Topo Soft)(es)[RUN'CAS-'].cas | Yes | `CASGOI /CB` |  |  |
| Spitfire '40 (1986)(Mirrorsoft)[RUN'CAS-'].cas | Yes | `CASGOM /CB` |  |  |
| Splash (1986)(Mind Games Espana)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Spy Story (1986)(Aackosoft)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Spy vs Spy II - The Island Caper (1987)(Databyte)[a][RUN'CAS-'].cas | Yes | `CASGOM /CB` |  |  |
| Spy vs Spy II - The Island Caper (1987)(Databyte)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Squash 1986 (Robtek Software) [CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Star Bowls (1991)(Zigurat Software)(es)[RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Star Fighter (1986)(Eaglesoft)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Star Fighter (Battleship Clapton II Hack) (1986)(Visiogame)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Star Maps - Game Pack 1 (Aackosoft - Eaglesoft) [RUN'CAS-'] [\_].cas | Yes | `CASGOR` |  |  |
| Star Runner (1986)(Manhattan Transfer)(es)[a][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Star Runner (1986)(Manhattan Transfer)(es)[b][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Star Runner (1986)(Manhattan Transfer)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Star Wars (1986)(Eaglesoft)[a][RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Star Wars (1986)(Eaglesoft)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Starbuggy (1988)(Eurosoft)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Starbuster (1988)(Methodic Solutions)[RUN'CAS-'].cas | Yes | `CASGOI /CB` |  |  |
| Starbyte (1987)(Mister Chip)(es)[RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Stardust (1987)(Topo Soft)(es)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Starquake (1986)(Bubblebus Software)[a][RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Starquake (1986)(Bubblebus Software)[RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Steve Davis Snooker (1985)(CDS Microsystems)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Stoneville Manor - Game Pack 1 (Aackosoft - Eaglesoft) [RUN'CAS-'] [\_].cas | Yes | `CASGOR` |  |  |
| Stop Ball (1987)(Dro Soft)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Stop the Express (Hudson) (Aackosoft - Eaglesoft) [RUN'CAS-'] [\_].cas | Yes | `CASGOR` |  |  |
| Storm - Una's Lair (1986)(Mastertronic)[a][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Storm - Una's Lair (1986)(Mastertronic)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Stormbringer (1987)(Mastertronic Added Dimension)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Stormbringer (1987)(Mastertronic).cas | Yes | `CASGOR` |  |  |
| Streaker (1987)(Bulldog)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Strip Poker II+ (1988)(Anco Software)(Side A)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Strip Poker II+ (1988)(Anco Software)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Submarine Shooter (1983)(Hudson Soft)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Super Boy I  [BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Super Boy II  [BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Super Chess (1984)(Kuma Computers)[a][BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Super Chess (1984)(Kuma Computers)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Super Difficult Theseus (1985)(Login Soft)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Super Doors (1983)[BLOAD'CAS',r].cas | Yes | `CASGOR` |  |  |
| Super Ilevan (POPCOM 1987-04).cas | Yes | `CASGOR` |  |  |
| super msx 12a.cas | Yes | `CASGOI /S` |  |  |
| super msx 12b.cas | Yes | `CASGOI /S` |  |  |
| super msx 19 lato A.cas | Yes | `CASGOM /B` |  |  |
| super msx 19 lato B.cas | Yes | `CASGOI /CB` |  |  |
| super msx 2a.cas | Yes | `CASGOR` |  |  |
| super msx 2b.cas | Yes | `CASGOR` |  |  |
| super msx 3.cas | Yes | `CASGOR` |  |  |
| Super Pac-Man (1982 & 2026)(Namco & Mastropiero).CAS | Yes | `CASGOR` |  |  |
| Super Pachinko (Columbia) (Japan) [BLOAD'CAS-',R] [\_].cas | Yes | `CASGOR` |  |  |
| Super Racer (1985)(Login Soft)[BLOAD'CAS-',R or BLOAD'CAS-'+CLOAD+RUN].cas | Yes | `CASGOR` |  |  |
| Super Sprites (1986)(Idealogic)(es)[RUN'CAS-'].cas | Yes | `CASGOI` |  |  |
| SUPER05A.CAS | Yes | `CASGOI /S18` |  |  |
| SUPER09A.CAS | Yes | `CASGOI /S` |  |  |
| SUPER09B.CAS | Yes | `CASGOM /S` |  |  |
| SUPER1.CAS | Yes | `CASGOT /B` |  |  |
| SUPER15A.CAS | Yes | `CASGOI /S` |  |  |
| SUPER15B.CAS | Yes | `CASGOI /S` |  |  |
| SUPER15B\_\_Super MSX n.5 (ottobre 1987) - cas\_5.CAS | Yes | `CASGOI /S` |  |  |
| SUPER22.CAS | Yes | `CASGOI /S` |  |  |
| SUPER22B.CAS | Yes | `CASGOI /CB` |  |  |
| super24latoa.cas | Yes | `CASGOI /B` |  |  |
| super24latob.cas | Yes | `CASGOI /B` |  |  |
| super26max.cas | Yes | `CASGOI /B` |  |  |
| super26max2.cas | Yes | `CASGOI /CB` |  |  |
| SUPER27.CAS | Yes | `CASGOR /CB` |  |  |
| super\_msx\_10\_lato\_A.cas | Yes | `CASGOI /S` |  |  |
| super\_msx\_10\_lato\_B.cas | Yes | `CASGOI /S` |  |  |
| super\_msx\_11\_lato\_A.cas | Yes | `CASGOI /S` |  |  |
| super\_msx\_11\_lato\_B.cas | Yes | `CASGOI /S` |  |  |
| super\_msx\_13\_lato\_A.cas | Yes | `CASGOI /S` |  |  |
| super\_msx\_13\_lato\_B.cas | Yes | `CASGOI /S` |  |  |
| super\_msx\_14\_lato\_A.cas | Yes | `CASGOI /S` |  |  |
| super\_msx\_14\_lato\_B.cas | Yes | `CASGOI /S` |  |  |
| super\_msx\_16\_lato\_A.cas | Yes | `CASGOI /S` |  |  |
| super\_msx\_16\_lato\_B.cas | Yes | `CASGOI /S` |  |  |
| super\_msx\_17\_lato\_A.cas | Yes | `CASGOI /B` |  |  |
| super\_msx\_17\_lato\_B.cas | Yes | `CASGOI /CB` |  |  |
| super\_msx\_21\_lato\_A.cas | Yes | `CASGOI /S` |  |  |
| super\_msx\_21\_lato\_B.cas | Yes | `CASGOI /CB` |  |  |
| super\_msx\_23\_lato\_A.CAS | Yes | `CASGOI /CB` |  |  |
| super\_msx\_23\_lato\_B.CAS | Yes | `CASGOI /CB` |  |  |
| super\_msx\_25\_lato\_A.cas | Yes | `CASGOI /B` |  |  |
| super\_msx\_25\_lato\_B.cas | Yes | `CASGOR /CB` |  |  |
| super\_msx\_4\_lato\_A.cas | Yes | `CASGOI /S` |  |  |
| super\_msx\_4\_lato\_B.cas | Yes | `CASGOI /S` |  |  |
| super\_msx\_6\_lato\_A.cas | Yes | `CASGOT /S` |  |  |
| super\_msx\_7\_lato\_A.cas | No | `CASGOI /S` | Q |  |
| super\_msx\_7\_lato\_B.cas | Yes | `CASGOI /S` |  |  |
| super\_msx\_8\_lato\_A.cas | Yes | `CASGOI /S` |  |  |
| super\_msx\_8\_lato\_B.cas | Yes | `CASGOI /S` |  |  |
| Superbowl (1985)(Budgie Budget Software)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Supermaze (1984)[Morwood Software][CLOAD].cas | Yes | `CASGOR` |  |  |
| SuperMSX18-LatoA.CAS | Yes | `CASGOI /B13` |  |  |
| SuperMSX18-LatoB.CAS | Yes | `CASGOR /CB` |  |  |
| SuperMSX20-LatoA.cas | Yes | `CASGOI /B` |  |  |
| SuperMSX20-LatoB.cas | Yes | `CASGOI /B` |  |  |
| Survivor (1987)(Topo Soft)(es)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Survivors (1986)(Atlantis Software)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Swing Man (Side A) (Spectravideo) [\_] [CLOAD-RUN].cas | Yes | `CASGOR` |  |  |
| Swing Man (Spectravideo) [\_] [CLOAD-RUN].cas | Yes | `CASGOR` |  |  |
| SWIV (1991)(Dro Soft)(Side A)[needs 128k][RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| SwordWork (2026)(Inufuto).cas | Yes | `CASGOR` |  |  |
| Tai-Pan (1987)(Ocean Software)(Side A)[RUN'CAS-'].cas | Yes | `CASGOI /CB` |  |  |
| Take the B Train (198x)(Atorasu).CAS | Yes | `CASGOR` |  |  |
| Tales of Popolon (2017)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Tales Of Popolon (v1.2)(2017)(EN) [BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Tales Of Popolon (v1.2)(2017)(ES)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Tales Of Popolon (v1.3)(2017)(EN) [BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Tales Of Popolon (v1.3)(2017)(ES)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Tank Battalion (1984)(Bug-Byte Software)[BLOAD'CAS-',R].cas | Yes | `CASGOR /N` |  |  |
| Target Plus (1988)(Dinamic Software)(es)[gunstick][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Tasword (1985)(Sony)(es)[RUN'CAS-'].cas | Yes | `CASGOI /CB` |  |  |
| Tawara (1984)(Ascii)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Teach Yourself Basic(1985)(Toshiba)(Side A).cas | Yes | `CASGOR` |  |  |
| Teach Yourself Basic(1985)(Toshiba)(Side A)\_\_Teach Yourself Basic(1985)(Toshiba)(Side A)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Teenage Mutant Hero Turtles (1990)(Image Works)[passworded][RUN'CAS-'].cas | Yes | `CASGOT /B` |  |  |
| Teenage Mutant Hero Turtles (1990)(Image Works)[RUN'CAS-'].cas | Yes | `CASGOT /B` |  |  |
| Temptations (1988)(Topo Soft)(es)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Temptations - Toposoft (1988)(Alternative version by Xesco).cas | Yes | `CASGOI /S` |  |  |
| Tenebra (2023)(Haplo).cas | Yes | `CASGOR` |  |  |
| Tenebra (2023)(Haplo)[No Keyclick].cas | Yes | `CASGOR` |  |  |
| Tension (1988)(System 4)(es)[RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Terminus - The Prison Planet (1987)(Mastertronic).cas | Yes | `CASGOR` |  |  |
| Terrahawks (2020) (Anemotionalfish) [BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Terramex (1988)(Grandslam Entertainments)[BLOAD'CAS-',R].cas | Yes | `CASGOI /S` |  |  |
| Terrorpods (1989)(Dro Soft)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Test de Adaptacion (1984)(DIMensionNEW)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Test de Capacidad de Concentracion (1984)(DIMensionNEW)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Test de Caracter (1984)(DIMensionNEW)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Test Drive II - The Duel (1989)(Dro Soft)[a][RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Test Drive II - The Duel (1989)(Dro Soft)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Tetris (MirrorSoft) (MCM) [RUN'CAS-'] [\_].cas | Yes | `CASGOR` |  |  |
| Tetris (MirrorSoft) (MCM) [RUN'CAS-'] [\_].cas | Yes | `CASGOR` |  |  |
| The Archers - Part 1 (1985)(Level 9 Computing)[RUN'CAS-',R].cas | Yes | `CASGOT /CB` |  |  |
| The Archers - Part 2 (1985)(Level 9 Computing)[RUN'CAS-',R].cas | Yes | `CASGOT /CB` |  |  |
| The Archers - Part 3 (1985)(Level 9 Computing)[RUN'CAS-',R].cas | Yes | `CASGOT /CB` |  |  |
| The Archers - Part 4 (1985)(Level 9 Computing)[RUN'CAS-',R].cas | Yes | `CASGOT /CB` |  |  |
| The Elves of Maroland (2024)(Kame Soft)[Tape 1].cas | Yes | `CASGOI /S` |  |  |
| The Growing Pains Of Adrian Mole - Part 1 (1987) (Level 9 Computing)[RUN'CAS-',R].cas | Yes | `CASGOT /CB` |  |  |
| The Growing Pains Of Adrian Mole - Part 2 (1987) (Level 9 Computing)[RUN'CAS-',R].cas | Yes | `CASGOT /B` |  |  |
| The Growing Pains Of Adrian Mole - Part 3 (1987) (Level 9 Computing)[RUN'CAS-',R].cas | Yes | `CASGOT /CB` |  |  |
| The Growing Pains Of Adrian Mole - Part 4 (1987) (Level 9 Computing)[RUN'CAS-',R].cas | Yes | `CASGOT /CB` |  |  |
| The Growing Pains of Adrian Mole 1 y 2.CAS | Yes | `CASGOT /CB` |  |  |
| The Growing Pains of Adrian Mole 3 y 4.CAS | Yes | `CASGOT /CB` |  |  |
| The Ice King (1986)(CDS Software).cas | Yes | `CASGOM /B` |  |  |
| The Keiba - Champion Soft (1986) [Push F5 After 2nd Load].cas | Yes | `CASGOR` |  |  |
| The Munsters (1988)(Alternative Software).cas | Yes | `CASGOI /S` |  |  |
| The Price Of Magik (1986)(Level 9 Computing)[RUN'CAS-',R].cas | Yes | `CASGOT /CB` |  |  |
| The Queens Footsteps Part 1 (2020)(Davide Bucci)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| The Queens Footsteps Part 2 (2020)(Davide Bucci)[BLOAD'CAS-',R].cas.cas | Yes | `CASGOR` |  |  |
| The Queens Footsteps Part 3 (2020)(Davide Bucci)[BLOAD'CAS-',R].cas.cas | Yes | `CASGOR` |  |  |
| The Scramble (1983) (Marufune FSL).cas | Yes | `CASGOI /B` |  |  |
| The Secret Diary of Adrian Mole Aged 13≤ - Part I (1985)(Level 9 Computing)[a][RUN'CAS-'].cas | Yes | `CASGOR /B` |  |  |
| The Secret Diary of Adrian Mole Aged 13≤ - Part I (1985)(Level 9 Computing)[RUN'CAS-'].cas | Yes | `CASGOR /B` |  |  |
| The Secret Diary of Adrian Mole Aged 13≤ - Part II (1985)(Level 9 Computing)[a][RUN'CAS-'].cas | Yes | `CASGOR /B` |  |  |
| The Secret Diary of Adrian Mole Aged 13≤ - Part II (1985)(Level 9 Computing)[RUN'CAS-'].cas | Yes | `CASGOR /B` |  |  |
| The Secret Diary of Adrian Mole Aged 13≤ - Part III (1985)(Level 9 Computing)[a][RUN'CAS-'].cas | Yes | `CASGOR /B` |  |  |
| The Secret Diary of Adrian Mole Aged 13≤ - Part III (1985)(Level 9 Computing)[RUN'CAS-'].cas | Yes | `CASGOR /B` |  |  |
| The Secret Diary of Adrian Mole Aged 13≤ - Part IV (1985)(Level 9 Computing)[a][RUN'CAS-'].cas | Yes | `CASGOR /B` |  |  |
| The Secret Diary of Adrian Mole Aged 13≤ - Part IV (1985)(Level 9 Computing)[RUN'CAS-'].cas | Yes | `CASGOR /B` |  |  |
| The Storekeeper [RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| The Temptation Of The Apartment Wife (1986)(Koei)[CLOAD + RUN].CAS | Yes | `CASGOR` |  |  |
| The Tomato Princess From Salad Land Part 1 (Side 1A)(1985)(Hudson Soft)(BLOAD'CAS-',R).cas | Yes | `CASGOR` |  |  |
| The Tomato Princess From Salad Land Part 2 (Side 1B)(1985)(Hudson Soft)(BLOAD'CAS-',R).cas | Yes | `CASGOR` |  |  |
| The Tomato Princess From Salad Land Part 3 (Side 2A)(1985)(Hudson Soft)(BLOAD'CAS-',R).cas | Yes | `CASGOR` |  |  |
| The Tomato Princess From Salad Land Part 4 (Side 2B)(1985)(Hudson Soft)(BLOAD'CAS-',R).cas | Yes | `CASGOR` |  |  |
| The Way Of The Tiger (1986)(Gremlin Graphics Software)(GB)(Tape 1 of 2 Side A - Master Program)[BLOAD'CAS-',R].cas | Yes | `CASGOI /S` |  |  |
| The Way Of The Tiger (忍者タイガー) (1986)(Tomo Soft International)(Tape 1 Side A - Master Program)[BLOAD'CAS-',R].CAS | Yes | `CASGOI /S` |  |  |
| The Worm In Paradise (1985)(Level 9 Computing)[RUN'CAS-',R].cas | Yes | `CASGOR /B` |  |  |
| Thexder (1986)(Eaglesoft)[RUN'CAS-'].cas | Yes | `CASGOI /CB` |  |  |
| Thing Bounces Back (1987)(Gremlin Graphics Software)[BLOAD'CAS-',R].cas | Yes | `CASGOI /S` |  |  |
| Thor (1988)(Proein Soft Line)(es)[RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Thunder Blade (1988)(US Gold)(Side A)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Time and Magik I - Lords of Time v2 (1988)(Level 9 Computing)[Cracked][RUN'CAS-'].cas | Yes | `CASGOT /CB` |  |  |
| Time and Magik I - Lords of Time v2 (1988)(Level 9 Computing)[Protected][RUN'CAS-'].cas | Yes | `CASGOT /CB` |  |  |
| Time and Magik I - Lords of Time v2(1988)(Level 9 Computing)[RUN'CAS-',r].cas | Yes | `CASGOT /CB` |  |  |
| Time and Magik II - Red Moon (1985)(Level 9 Computing)[RUN'CAS-'].cas | Yes | `CASGOR /B` |  |  |
| Time and Magik II - Red Moon v2 (1988)(Level 9 Computing)[Cracked][RUN'CAS-'].cas | Yes | `CASGOT /CB` |  |  |
| Time and Magik II - Red Moon v2 (1988)(Level 9 Computing)[Protected][RUN'CAS-'].cas | Yes | `CASGOT /CB` |  |  |
| Time and Magik II - Red Moon v2(1988)(Level 9 Computing)[RUN'CAS-',r].cas | Yes | `CASGOT /CB` |  |  |
| Time and Magik III - The Price of Magik v2 (1988)(Level 9 Computing)[Cracked][RUN'CAS-'].cas | Yes | `CASGOT /CB` |  |  |
| Time and Magik III - The Price of Magik v2 (1988)(Level 9 Computing)[Protected][RUN'CAS-'].cas | Yes | `CASGOT /CB` |  |  |
| Time and Magik III - The Price of Magik v2(1988)(Level 9 Computing)[RUN'CAS-',r].cas | Yes | `CASGOT /CB` |  |  |
| Time Bandits (1984)(PSS)[a][BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Time Bandits (1984)(PSS)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Time Bomb (1987)(Methodic Solutions)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Time Curb (1986)(Aackosoft)[a][RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Time Curb (1986)(Aackosoft)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Time Out (1988)(Zafiro Software Division)(es)[RUN'CAS-'].cas | Yes | `CASGOR /S` |  |  |
| Time Rider (1988)(Eurosoft)[a][RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Time Rider (1988)(Eurosoft)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Time Scanner (1989)(Activision)[BLOAD'CAS-',R].cas | Yes | `CASGOI /S` |  |  |
| Time Trax (1986)(Bug-Byte Software)[a][RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Time Trax (1986)(Bug-Byte Software)[RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Tiny Rise Out (1983)(ASCII).cas | Yes | `CASGOR` |  |  |
| Titanic (1988)(Topo Soft)(es)(Side A)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Toi Acid Game (1989)(Iber Soft)(es)(Side A)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Tokyo Gang (1990)(G.LL. Software)(es)[RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Tom & Jerry (1989)(Erbe Software)(es)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Toobin' (1989)(Domark)[a][BLOAD'CAS-',R].cas | Yes | `CASGOI /S` |  |  |
| Toobin' (1989)(Domark)[BLOAD'CAS-',R].cas | Yes | `CASGOI /S` |  |  |
| Torreoscura - Part 1 (Bieno Marti & Pedro Fernández)(es).cas | Yes | `CASGOI /S` |  |  |
| Torreoscura - Part 2 (Bieno Marti & Pedro Fernández)(es).cas | Yes | `CASGOI /S` |  |  |
| Tour 91 (1991)(Topo Soft)(es)(Side A)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| TrackAndField1[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| TrackAndField2[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Trailblazer (1986)(Gremlin Graphics Software)[BLOAD'CAS-',R].cas | Yes | `CASGOT /S` |  |  |
| Trailblazer (1986)(Gremlin Graphics Software)[RUN'CAS-'].cas | Yes | `CASGOT /B` |  |  |
| Transball (2016)(Santi Ontanon)[RUN'CAS-'].cas | Yes | `CASGOT /B` |  |  |
| transball-en [Bload'cas-',r].cas | Yes | `CASGOT /B` |  |  |
| Trantor - The Last Stormtrooper (1987)(Go!)[a2][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Trantor - The Last Stormtrooper (1987)(Go!)[a][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Trantor - The Last Stormtrooper (1987)(Go!)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Trap - Game Pack 1 (Aackosoft - Eaglesoft) [RUN'CAS-'] [\_].cas | Yes | `CASGOR` |  |  |
| Trapox (2021)(Gamecast).CAS | Yes | `CASGOR` |  |  |
| Tras el Unicornio.cas | Yes | `CASGOR` |  |  |
| Tres Luces de Glaurung, Las (1986)(Erbe Software)(es)[RUN'CAS-'].cas | Yes | `CASGOI /CB` |  |  |
| Trick Boy. Pinball (1984)(T&E Soft)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Triple Comando (1988)(Dro Soft)(es)(Side A)[RUN'CAS-'].cas | Yes | `CASGOM /S` |  |  |
| Tritorn (1986)(Xain)[CLOAD + RUN].cas | Yes | `CASGOM` |  |  |
| Trivial Pursuit (1986)(Domark)(es)(Side A)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| TT Racer (1987)(Methodic Solutions)[a][RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| TT Racer (1987)(Methodic Solutions)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Tuareg (1988)(Topo Soft)(es)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Turbo Girl (1988)(Dinamic Software)(es)[a2][RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Turbo Girl (1988)(Dinamic Software)(es)[a][RUN'CAS-'].cas | Yes | `CASGOI` |  |  |
| Turbo Girl (1988)(Dinamic Software)(es)[RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Turmoil (1986)(Bug-Byte Software)[a][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Turmoil (1986)(Bug-Byte Software)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Turtles - Konami (1981)[MSX version by André de la Rocha v2].cas | Yes | `CASGOR` |  |  |
| Turtles - Konami (1981)[MSX version by André de la Rocha].cas | Yes | `CASGOR` |  |  |
| Tutor (1985)(Sony)(es)(Side A)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Twinlight (2019) (Retrosouls) [BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Typing Tutor (1985)(Sanyo)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| U Boat (1985)(Omega Systems)(ja).cas | Yes | `CASGOR` |  |  |
| U-Boot (1985)(Manhattan Transfer)(es)[a][CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| U-Boot (1985)(Manhattan Transfer)(es)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Uchi Mata (1987)(Martech Games)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Uchi Mata (1987)(Martech Games)[Fixed][CLOAD + RUN].cas | Yes | `CASGOI /B` |  |  |
| Uchi Mata (1987)(Martech Games)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| UchiMata[+3][NR].cas | Yes | `CASGOR` |  |  |
| Uchusen Gamma - Usebox.net (2019).cas | Yes | `CASGOR /CB` |  |  |
| Ulises (1989)(Opera Soft)[BLOAD'CAS-',R].cas | Yes | `CASGOR /C` |  |  |
| Ultra Chess (1985)(Aackosoft)[a][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Ultra Chess (1985)(Aackosoft)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Underground (1988)(System 4)(es)[RUN'CAS-'].cas | Yes | `CASGOT /CB` |  |  |
| Untouchables, The (1989)(Erbe Software)(Side A)[a][RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Untouchables, The (1989)(Erbe Software)(Side A)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Vacuumania (1984)(PSS)[a][BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Vacuumania (1984)(PSS)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Valkyr (1985)(Gremlin Graphics Software)[BLOAD'CAS-',R].cas | Yes | `CASGOI /S` |  |  |
| Vampire (1987)(Codemasters)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Vampire's Empire (1988)(Dro Soft)(es)[a][RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Vampire's Empire (1988)(Dro Soft)(es)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Vampire(1987)(Codemasters)[a][Run'CAS-'].cas | Yes | `CASGOR` |  |  |
| Vampire(1987)(Codemasters)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Vampiro (1987)(Manhattan Transfer)(es)[RUN'CAS-'].cas | Yes | `CASGOI` |  |  |
| Vegetable Crash (HoneyBee Soft) (Hudson Soft) (Japan) [BLOAD'CAS-',R] [\_].cas | Yes | `CASGOR` |  |  |
| Vestron (1986)(Players Software)[a][BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Vestron (1986)(Players Software)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Viaje al Centro de la Tierra (1989)(Topo Soft)(es)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Viaje por Europa (19xx)(Mind Games Espana)(es)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Vicious Viper (1985)(Sanyo)[a2][CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Vicious Viper (1985)(Sanyo)[a][CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Vicious Viper (1985)(Sanyo)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Video Poker (1986)(Disprosoft)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Video Poker (1986)(Mastertronic)[RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Vilzam - Cosmic Struggle (1985) (Yuichi Toyama)(en).CAS | Yes | `CASGOR` |  |  |
| Vilzam - Cosmic Struggle (1985) (Yuichi Toyama).CAS | Yes | `CASGOR` |  |  |
| Virus LQP-79 (2018) (Pentacour) [BLOAD'CAS-',R].cas | Yes | `CASGOR /B` |  |  |
| Voidrunner (1987)(Mastertronic Added Dimension)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Volguard (1985)(dB-Soft)[RUN'CAS-']-patched.cas | Yes | `CASGOR` |  |  |
| Volguard (1985)(dB-Soft)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Vortex Raider (1988)(Eurosoft)[a][RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Vortex Raider (1988)(Eurosoft)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| W Series 1 (1983) (Hudson Soft)[Side A - Biotech, Killer Station][BLOAD'CAS-',R].CAS | Yes | `CASGOR` |  |  |
| W Series 2 (1983) (Hudson Soft)[Side A - HELP, Sea Bomber][BLOAD'CAS-',R].cas | Yes | `CASGOI /C` |  |  |
| W Series 3 (1983) (Hudson Soft)[Side A - Fireball, Akarui Nouen][BLOAD'CAS-',R].CAS | Yes | `CASGOI /C` |  |  |
| W Series 4 (1983) (Hudson Soft)( Side A - Super Doors)[BLOAD'CAS',r].cas | Yes | `CASGOR` |  |  |
| W Series 5 (1983) (Hudson Soft)(Side A - Submarine Shooter, Gunman)[BLOAD'CAS-',R]..cas | Yes | `CASGOR` |  |  |
| Wall, The (1987)(Erbe Software)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Wallball (19xx)(Tynesoft)[a][BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Wallball (19xx)(Tynesoft)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Wamp Cola (1988)(Iber Soft)(es)[aka Dracula][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| War Chess (1986)(Idealogic)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| War in Middle Earth (1989)(Dro Soft)(es)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Warp & Warp (1984)(Bug-Byte Software)[BLOAD'CAS-',R].cas | Yes | `CASGOR /N` |  |  |
| WATSON1.CAS | Yes | `CASGOR` |  |  |
| WEC Le Mans (1988)(Imagine Software)[a][RUN'CAS-'].cas | Yes | `CASGOI /CB` |  |  |
| WEC Le Mans (1988)(Imagine Software)[RUN'CAS-'].cas | Yes | `CASGOI /CB` |  |  |
| Wells & Fargo (1988)(Topo Soft)(es)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| West Bank (1989)(Dinamic Software)(es)[a][RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| West Bank (1989)(Dinamic Software)(es)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Who Dares Wins II (1986)(Alligata Software)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Wild Cat (1984)(Nippon Columbia).cas | Yes | `CASGOR` |  |  |
| Wing Man (1985)(Enix)(ja)(Side A)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Winter Events (1987)(Anco Software)[a][CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Winter Olympics (1986)(Tynesoft)(Side A)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Winterhawk (1988)(Eurosoft)[a][RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Winterhawk (1988)(Eurosoft)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| Wizard's Lair (1986)(Bubblebus Software)(M3)[a][CLOAD + RUN].cas | Yes | `CASGOI` |  |  |
| Wizard's Lair (1986)(Bubblebus Software)(M3)[CLOAD + RUN].cas | Yes | `CASGOI` |  |  |
| Word Pro v2.60 (1985)(Kuma Computers)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| World Cup Soccer (1986)(Eaglesoft)[a][RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| World Cup Soccer (1986)(Eaglesoft)[RUN'CAS-'].cas | Yes | `CASGOR /CB` |  |  |
| World Games (1987)(US Gold)(Side A)[RUN'CAS-'].cas | Yes | `CASGOR /N` |  |  |
| World Map Software For Color Plotter Printer (1985)(Matsushita Electric Industrial)(Side A)[CLOAD].cas | Yes | `CASGOR` |  |  |
| Worry (1985)(Microcabin).cas | Yes | `CASGOR` |  |  |
| Wreck, The (1984)(Electric Software).cas | Yes | `CASGOR` |  |  |
| Wrestling (198x)(Grupo de Trabajo Software)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| X-Racing (2019)(Brain Games)(v1.0)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| X-Racing (2019)(Brain Games)(v1.0.1)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| X-Racing (2019)(Brain Games)(v1.0.2)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| X-Racing (2019)(Brain Games)(v1.0.3)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| X-Racing (2019)(Brain Games)(v1.0.4)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| X-Spellunker (2017)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| X-Spelunker (2017)(Brain Games)(v1.4.2)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Xenon (1988)(Dro Soft)(es)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Xenon(1988)(Melbourne House)[EN][RUN'CAS-'].cas | Yes | `CASGOI /B` |  |  |
| Xybots (1989)(Domark)[a][BLOAD'CAS-',R].cas | Yes | `CASGOI /S` |  |  |
| Xybots (1989)(Domark)[BLOAD'CAS-',R].cas | Yes | `CASGOI /S` |  |  |
| Xyxolog. Xyzolog (1985)(Electric Software)[a][BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Xyxolog. Xyzolog (1985)(Electric Software)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Xyzolog (Electric Software) (Aackosoft) (Side 1) [BLOAD'CAS-',R] [\_].cas | Yes | `CASGOR` |  |  |
| Yazzie (2019) (Retrosouls) [BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Yazzie MSX Remix (2020) (Retrosouls) [BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Yie Ar Kung Fu [BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Yie Ar Kung Fu II[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Yo Calculo (1986)(Anaya Multimedia)(es)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Zakil Wood (1985)(Mr. Micro)[BLOAD'CAS-',R].cas | Yes | `CASGOR /C` |  |  |
| Zalbar 2784 (1985)(Login Soft)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Zanac (1987)(Eaglesoft)[RUN'CAS-'].cas | Yes | `CASGOI /CB` |  |  |
| Zarth (1985)(Enix)(ja)(Side A)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Zaxxon (1985)(Electric Software)[BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Zero Fighter (1984)(Hudson Soft)[BLOAD'CAS-',R].CAS | Yes | `CASGOR` |  |  |
| Zexas (1984)(dB-Soft)[CLOAD + RUN].cas | Yes | `CASGOR` |  |  |
| Zipi y Zape (1989)(Dro Soft)(es)(Side A)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Zoids - The Battle Begins (1985)(Martech Games)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Zombie Calavera Prologue (2021) (conv Nanochess) [BLOAD'CAS-',R].cas | Yes | `CASGOR` |  |  |
| Zona 0 (1991)(Topo Soft)(es)[RUN'CAS-'].cas | Yes | `CASGOI /S` |  |  |
| Zond (1988)(Iber Soft)(es)[aka Zexas][RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
| Zoot (1986)(Bug-Byte Software)[RUN'CAS-'].cas | Yes | `CASGOR` |  |  |
