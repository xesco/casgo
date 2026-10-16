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

The table lists the tapes by title.

| Game | File | Loads | Variant | Code | Run instead |
|---|---|---|---|---|---|
| 001 - Aritmo | 001-ARIT.CAS | Yes | `CASGOR` |  |  |
| 001-Aritmo | 001-ARIO.CAS | Yes | `CASGOR` |  |  |
| 002 - Black Jack | 002NEW.CAS | Yes | `CASGOR` |  |  |
| 002-Black Jack | 002-BLAC.CAS | Yes | `CASGOR` |  |  |
| 003 - Test de capacidad | 003-TEST.CAS | Yes | `CASGOR` |  |  |
| 003-Test de capacidad | 003-TEDE.CAS | Yes | `CASGOR` |  |  |
| 004 - Test de adaptacion | 004-TEST.CAS | Yes | `CASGOR` |  |  |
| 004-Test de adaptacion | 004-TEDE.CAS | Yes | `CASGOR` |  |  |
| 005 - El gerente | 005-EL.CAS | Yes | `CASGOR` |  |  |
| 005-El gerente | 005-ELE.CAS | Yes | `CASGOR` |  |  |
| 006 - Domino | 006-DOMI.CAS | Yes | `CASGOR` |  |  |
| 006-Domino | 006-DOMO.CAS | Yes | `CASGOR` |  |  |
| 007 - A View to a Kill (1986)(Domark) | 007-A-VI.CAS | Yes | `CASGOR` |  |  |
| 007 - A View to a Kill (1986)(Domark) | 007-AA.CAS | Yes | `CASGOR` |  |  |
| 007 - Damas | 007-DAMA.CAS | Yes | `CASGOR` |  |  |
| 007 - Licence to Kill (1989)(Domark) | 007-LICE.CAS | Yes | `CASGOI /S` |  |  |
| 007 - The Living Daylights (1987)(Domark) | 007-THE.CAS | Yes | `CASGOI /B` |  |  |
| 007 Agente Especial (1985)(Erbe Software)(es) | 007-AGEN.CAS | Yes | `CASGOR` |  |  |
| 007-Graficos de gestion | 007-GRAF.CAS | Yes | `CASGOR` |  |  |
| 008 - Test de caracter | 008-TEST.CAS | Yes | `CASGOR` |  |  |
| 008-Hoja de calculo | 008-HOJA.CAS | Yes | `CASGOR` |  |  |
| 009 - Mini Super Sprites | 009-MINI.CAS | Yes | `CASGOI` |  |  |
| 009-Calculator new | 009-CALC.CAS | Yes | `CASGOR` |  |  |
| 010 - Comecocos | 010-COME.CAS | Yes | `CASGOR` |  |  |
| 010-Base de datos | 010-BASE.CAS | Yes | `CASGOI` |  |  |
| 011 - Invierte y gana | 011-INVI.CAS | Yes | `CASGOI /B` |  |  |
| 011-Damas | 011-DAMA.CAS | Yes | `CASGOR` |  |  |
| 012 - Compra y Venta | 012-COMP.CAS | Yes | `CASGOR` |  |  |
| 012-Test de caracter | 012-TEST.CAS | Yes | `CASGOR` |  |  |
| 013 - Smack Wacker | 013-SMAC.CAS | Yes | `CASGOR /CB` |  |  |
| 013-Pert | 013-PERT.CAS | Yes | `CASGOR` |  |  |
| 014 - Moonrider | 014-MOON.CAS | Yes | `CASGOR /CB` |  |  |
| 014-Risky Holding | 014-RISK.CAS | Yes | `CASGOR` |  |  |
| 015 - Juego de la moncloa | 015-JUEG.CAS | Yes | `CASGOR` |  |  |
| 015-Bouncing Blocks | 015-BOUN.CAS | Yes | `CASGOR` |  |  |
| 016-Roberto Mate | 016-ROBE.CAS | Yes | `CASGOR` |  |  |
| 017 - Los Pe╠ütalos Locos | 017-LOS.CAS | Yes | `CASGOR` |  |  |
| 017-Mini Super Sprites | 017-MINI.CAS | Yes | `CASGOI` |  |  |
| 018 - Geometria, figuras planas y volumenes | 018-GEOM.CAS | Yes | `CASGOR` |  |  |
| 018-Comecocos | 018-COME.CAS | Yes | `CASGOR` |  |  |
| 019 - Galaxians | 019-GALA.CAS | Yes | `CASGOR` |  |  |
| 019-Invierte y gana | 019-INVI.CAS | Yes | `CASGOI /B` |  |  |
| 020 - Tratamiento de textos | 020-TRAT.CAS | Yes | `CASGOI /B` |  |  |
| 020-Compra y vende | 020-COMP.CAS | Yes | `CASGOR` |  |  |
| 021 - Rios de Espana | 021-RIOS.CAS | Yes | `CASGOR` |  |  |
| 021-Smack Wacker | 021-SMAC.CAS | Yes | `CASGOR /CB` |  |  |
| 022 - Capitales de Espana | 022-CAPI.CAS | Yes | `CASGOR` |  |  |
| 022-Moonrider | 022-MOON.CAS | Yes | `CASGOR /CB` |  |  |
| 023 - Idea Type I | 023-IDEA.CAS | Yes | `CASGOR` |  |  |
| 023-Vestron | 023-VEST.CAS | Yes | `CASGOR` |  |  |
| 024 - Idea Type II | 024-IDEA.CAS | Yes | `CASGOR` |  |  |
| 024-Foot Volley | 024-FOOT.CAS | Yes | `CASGOR` |  |  |
| 025 - Memorion | 025-MEMO.CAS | Yes | `CASGOR` |  |  |
| 025-Fire Hawk | 025-FIRE.CAS | Yes | `CASGOR` |  |  |
| 026 - 007 Agente Especial | 026-007.CAS | Yes | `CASGOR` |  |  |
| 026-Sea King | 026-SEA.CAS | Yes | `CASGOR` |  |  |
| 027 - Rocket | 027-ROCK.CAS | Yes | `CASGOR` |  |  |
| 027-Faraon | 027-FARA.CAS | Yes | `CASGOR` |  |  |
| 028 - Pucky | 028-PUCK.CAS | Yes | `CASGOR` |  |  |
| 029 - Drum | 029-DRUM.CAS | Yes | `CASGOR` |  |  |
| 030 - Kitchen | 030-KITC.CAS | Yes | `CASGOR` |  |  |
| 031 - Heli | 031-HELI.CAS | Yes | `CASGOR` |  |  |
| 031-Mazes Unlimited | 031-MAZE.CAS | Yes | `CASGOR /CB` |  |  |
| 032 - Crossing | 032-CROS.CAS | Yes | `CASGOR` |  |  |
| 032-Robot Wars | 032-ROBO.CAS | Yes | `CASGOT /B` |  |  |
| 033 - Snack-Bar | 033-SNAC.CAS | Yes | `CASGOR` |  |  |
| 033-Juego de la moncloa (cload) | 033-JUEG.CAS | Yes | `CASGOR` |  |  |
| 034 - Mouse | 034-MOUS.CAS | Yes | `CASGOR` |  |  |
| 035 - Pyramid (Jojosoft) | 035-PYRA.CAS | Yes | `CASGOR` |  |  |
| 035-Edgy | 035-EDGY.CAS | Yes | `CASGOR` |  |  |
| 036 - Space | 036-SPAC.CAS | Yes | `CASGOR` |  |  |
| 036-Contabilidad domestica (Philips, 1987) | 036-CONT.CAS | Yes | `CASGOR` |  |  |
| 037 - Alpha Blaster | 037-ALPH.CAS | Yes | `CASGOR /CB` |  |  |
| 037-Los Petalos locos | 037-LOS.CAS | Yes | `CASGOR` |  |  |
| 038 - Mac Attack | 038-MAC.CAS | Yes | `CASGOR /CB` |  |  |
| 038-Geometria, figuras planas y volumenes | 038-GEOM.CAS | Yes | `CASGOR` |  |  |
| 039 - Choper I | 039-CHOP.CAS | Yes | `CASGOR /CB` |  |  |
| 039-War Chess | 039-WAR.CAS | Yes | `CASGOR` |  |  |
| 040 - Scentipede | 040-SCEN.CAS | Yes | `CASGOR /CB` |  |  |
| 040-Skate Dragon | 040-SKAT.CAS | Yes | `CASGOR` |  |  |
| 041 - Editor de Sprites | 041-EDIT.CAS | Yes | `CASGOR` |  |  |
| 041-Galaxians | 041-GALA.CAS | Yes | `CASGOR` |  |  |
| 042 - Othello | 042-OTHE.CAS | Yes | `CASGOR` |  |  |
| 042-Tratamiento de textos | 042-TRAT.CAS | Yes | `CASGOI /B` |  |  |
| 043 - Ice | 043-ICE.CAS | Yes | `CASGOR /CB` |  |  |
| 043-Rios de Espana | 043-RIOS.CAS | Yes | `CASGOR` |  |  |
| 044 - Demand | 044-DEMA.CAS | Yes | `CASGOR` |  |  |
| 044-Capitales de Espa+a | 044-CAPI.CAS | Yes | `CASGOR` |  |  |
| 045 - Treppy | 045-TREP.CAS | Yes | `CASGOR` |  |  |
| 045-Idea Type | 045-IDEA.CAS | Yes | `CASGOR` |  |  |
| 046 - Glider | 046-GLID.CAS | Yes | `CASGOR` |  |  |
| 046-Idea Type | 046-IDEA.CAS | Yes | `CASGOR` |  |  |
| 047 - Micky-Lucky | 047-MICK.CAS | Yes | `CASGOR` |  |  |
| 047-Gusanoco | 047-GUSA.CAS | Yes | `CASGOR` |  |  |
| 048 - Racer | 048-RACE.CAS | Yes | `CASGOR` |  |  |
| 048-VG Estrella | 048-VG.CAS | Yes | `CASGOR` |  |  |
| 049 - Alcyon | 049-ALCY.CAS | Yes | `CASGOR` |  |  |
| 049-Memorion | 049-MEMO.CAS | Yes | `CASGOR` |  |  |
| 050 - Artillero | 050-ARTI.CAS | Yes | `CASGOR` |  |  |
| 050-Agente Especial | 050-AGEN.CAS | Yes | `CASGOR` |  |  |
| 052-Editor de caracteres | 052-EDIT.CAS | Yes | `CASGOR` |  |  |
| 053-Formula 1 | 053-FORM.CAS | Yes | `CASGOR` |  |  |
| 054-Ovni | 054-OVNI.CAS | Yes | `CASGOR` |  |  |
| 055-Rocket | 055-ROCK.CAS | Yes | `CASGOR` |  |  |
| 056-Pucky | 056-PUCK.CAS | Yes | `CASGOR` |  |  |
| 057-Azul y rosa | 057-AZUL.CAS | Yes | `CASGOR` |  |  |
| 058-Escape | 058-ESCA.CAS | Yes | `CASGOR` |  |  |
| 059-Invasores | 059-INVA.CAS | Yes | `CASGOR` |  |  |
| 060-Break | 060-BREA.CAS | Yes | `CASGOR` |  |  |
| 061-Drum | 061-DRUM.CAS | Yes | `CASGOR` |  |  |
| 062-Kitchen | 062-KITC.CAS | Yes | `CASGOR` |  |  |
| 063-Heli | 063-HELI.CAS | Yes | `CASGOR` |  |  |
| 064-Crossing | 064-CROS.CAS | Yes | `CASGOR` |  |  |
| 065-Snack-Bar | 065-SNAC.CAS | Yes | `CASGOR` |  |  |
| 066-Mouse | 066-MOUS.CAS | Yes | `CASGOR` |  |  |
| 068-Space | 068-SPAC.CAS | Yes | `CASGOR` |  |  |
| 069-Car Race | 069-CAR.CAS | Yes | `CASGOR` |  |  |
| 070-Poker | 070-POKE.CAS | Yes | `CASGOR` |  |  |
| 071-Fruit | 071-FRUI.CAS | Yes | `CASGOR` |  |  |
| 072-Jetfighter | 072-JETF.CAS | Yes | `CASGOR /CB` |  |  |
| 073-Alpha Blaster | 073-ALPH.CAS | Yes | `CASGOR /CB` |  |  |
| 074-Mac Attack | 074-MAC.CAS | Yes | `CASGOR /CB` |  |  |
| 075-Choper 1 | 075-CHOP.CAS | Yes | `CASGOR /CB` |  |  |
| 076-Scentipede | 076-SCEN.CAS | Yes | `CASGOR /CB` |  |  |
| 077-Space Rescue | 077-SPAC.CAS | Yes | `CASGOR /CB` |  |  |
| 078-Time Curb | 078-TIME.CAS | Yes | `CASGOR /CB` |  |  |
| 079 - Editor de Sprites | 079-EDIT.CAS | Yes | `CASGOR` |  |  |
| 080-Othello | 080-OTHE.CAS | Yes | `CASGOR` |  |  |
| 081-Kick It | 081-KICK.CAS | Yes | `CASGOR /CB` |  |  |
| 082-Panique | 082-PANI.CAS | Yes | `CASGOR /CB` |  |  |
| 083-Ruleta | 083-RULE.CAS | Yes | `CASGOR` |  |  |
| 087-Panel Panique | 087-PANE.CAS | Yes | `CASGOI /B` |  |  |
| 088 - Rompeladrillos | 088-ROMP.CAS | Yes | `CASGOR` |  |  |
| 089-Solfeo | 089-SOLF.CAS | Yes | `CASGOR` |  |  |
| 090-Maziacs | 090-MAZI.CAS | Yes | `CASGOR` |  |  |
| 091-Space Buster | 091-SPAC.CAS | Yes | `CASGOR /CB` |  |  |
| 092-Cubo de Rubick | 092-CUBO.CAS | Yes | `CASGOR` |  |  |
| 093-Ice | 093-ICE.CAS | Yes | `CASGOR /CB` |  |  |
| 094-Demand | 094-DEMA.CAS | Yes | `CASGOR` |  |  |
| 095-Treppy | 095-TREP.CAS | Yes | `CASGOR` |  |  |
| 096-Glider | 096-GLID.CAS | Yes | `CASGOR` |  |  |
| 097-Micky-Lucky | 097-MICK.CAS | Yes | `CASGOR` |  |  |
| 098-Racer | 098-RACE.CAS | Yes | `CASGOR` |  |  |
| 099-Alcyon | 099-ALCY.CAS | Yes | `CASGOR` |  |  |
| 100-Artillero | 100-ARTI.CAS | Yes | `CASGOR` |  |  |
| 10th Frame (1986)(US Gold) | 10-TH-FR.CAS | Yes | `CASGOR` |  |  |
| 180 (1987)(Mastertronic Added Dimension) | 180.CAS | Yes | `CASGOI /B` |  |  |
| 3D Golf Simulation - High Speed Edition (1984)(T&E Soft) | 3-D-GOLF.CAS | Yes | `CASGOR` |  |  |
| 4x4 Off-Road Racing (1988)(US Gold)(Side A) | 4-X-4-OF.CAS | Yes | `CASGOI /S` |  |  |
| 4x4 Off-Road Racing (1988)(US Gold)(Side A) | 4-X-4A.CAS | Yes | `CASGOI /S` |  |  |
| 7 Card Stud (1986)(Martech Games) | 7-CARD.CAS | Yes | `CASGOR` |  |  |
| 7 Card Stud (1986)(Martech Games) | 7-CARDA.CAS | Yes | `CASGOR` |  |  |
| 737 Flight Simulator (1984)(Mirrorsoft) | 737-FLIA.CAS | Yes | `CASGOR` |  |  |
| 737 Flight Simulator (1984)(Mirrorsoft) | 737-FLIG.CAS | Yes | `CASGOR` |  |  |
| 747 400b Flight Simulator (1988)(Eurosoft) | 747-400.CAS | Yes | `CASGOR /CB` |  |  |
| A-TEAM (1988)(Zafiro) | A-TEAM.CAS | Yes | `CASGOR /B` |  |  |
| Aaargh! (1989)(Dro Soft)(es) | AAARGH.CAS | Yes | `CASGOI /S` |  |  |
| Aaargh! (1989)(Dro Soft)(es) | AAARGHA.CAS | Yes | `CASGOI /S` |  |  |
| Aackobase II (1985)(Aackosoft)(nl) | AACKOBAA.CAS | Yes | `CASGOR /P16` |  |  |
| Aackobase II (1985)(Aackosoft)(nl) | AACKOBAS.CAS | Yes | `CASGOR /P17` |  |  |
| Aackodraw & Paint (1985)(Aackosoft) | AACKODRA.CAS | Yes | `CASGOR /CB` |  |  |
| Abadia del Crimen, La (1988)(Opera Soft)(es) | ABADIA.CAS | Yes | `CASGOR /C` |  |  |
| Abeja Sabia 2, La (1986)(Anaya Multimedia)(es) | ABEJA-SA.CAS | Yes | `CASGOR` |  |  |
| Abeja Sabia 3, La (1986)(Anaya Multimedia)(es) | ABEJA3.CAS | Yes | `CASGOR` |  |  |
| Abracadabra (1988)(Proein Soft Line)(es)(Side A) | ABRACADA.CAS | Yes | `CASGOR /CB` |  |  |
| Abu Simbel Profanation (1986)(Dinamic Software)(es) | ABU-SIM2.CAS | Yes | `CASGOI /CB` |  |  |
| Abu Simbel Profanation (1986)(Dinamic Software)(es) | ABU-SIMA.CAS | Yes | `CASGOI /CB` |  |  |
| Abu Simbel Profanation (1986)(Dinamic Software)(es) | ABU-SIMB.CAS | Yes | `CASGOI /CB` |  |  |
| Abu Simbel Profanation (1986)(Dinamic Software)(es) | ABU-SIMR.CAS | Yes | `CASGOI /CB` |  |  |
| Ace of Aces (1986)(US Gold) | ACE-OF.CAS | Yes | `CASGOR` |  |  |
| Addictaball (1988)(Alligata Software) | ADDICTAB.CAS | Yes | `CASGOR /CB` |  |  |
| Addictaball (1988)(Alligata)(GB)-FX3 | ADDICTFX.CAS | Yes | `CASGOR /CB` |  |  |
| Addictaball (1988)(Alligata)(GB)-FX3-Cursores | ADDICTGB.CAS | Yes | `CASGOR /CB` |  |  |
| Adel (1986)(Mind Games Espana)(es) | ADEL.CAS | Yes | `CASGOR` |  |  |
| Adventure Quest (1983)(Level 9 Computing) | ADVENTUR.CAS | Yes | `CASGOR` |  |  |
| Aerial (2021)(Inufuto) | AERIAL.CAS | Yes | `CASGOR` |  |  |
| African Trail Simulator (1990)(Positive)(es) | AFRICAN.CAS | Yes | `CASGOT /CB` |  |  |
| After the War (1989)(Dinamic Software)(es)(Side A) | AFTER-TH.CAS | Yes | `CASGOT /B` |  |  |
| Afterburner (1988)(Activision)(Side A) | AFTERBUR.CAS | Yes | `CASGOR /N` |  |  |
| Afteroids (1988)(Zigurat Software)(es) | AFTEROIA.CAS | Yes | `CASGOR /CB` |  |  |
| Afteroids (1988)(Zigurat Software)(es) | AFTEROID.CAS | Yes | `CASGOR /CB` |  |  |
| Akalabeth (1980)(California Pacific) | AKALABET.CAS | Yes | `CASGOR` |  |  |
| Akarui Nouen (1983) (Hudson Soft) | AKARUI.CAS | Yes | `CASGOR` |  |  |
| Akujo Legend (1986)(Dream Soft)(jp) | AKUJO-LE.CAS | Yes | `CASGOR` |  |  |
| Ale Hop! (1988)(Topo Soft)(es) | ALE-HOP.CAS | Yes | `CASGOI /S` |  |  |
| Alfamat (1985)(Anaya Multimedia)(es) | ALFAMAT.CAS | Yes | `CASGOR` |  |  |
| Aliantantor dump di Andrea bendoni | ALIANTAN.CAS | Yes | `CASGOM /B` |  |  |
| Alice's Adventure in Wonderland (1984)(MicroCabin) | ALICE-S.CAS | Yes | `CASGOR` |  |  |
| Alien 8 (1985)(Ultimate Play The Game) | ALIENTHE.CAS | Yes | `CASGOR` |  |  |
| Alien 8 Remake (2008) | ALIEN-8.CAS | Yes | `CASGOR` |  |  |
| Alien Attack (2020) (Marcos Daniel Blanco) | ALIEN-AT.CAS | Yes | `CASGOR` |  |  |
| Alien Sunday... (1986)(Soft Studio WING)(Side A) | ALIEN-SU.CAS | Yes | `CASGOR` |  |  |
| Alien Syndrome (1988)(Dro Soft)(es)(Side A) | ALIEN-SY.CAS | Yes | `CASGOI /S` |  |  |
| Aliens (1987)(Mr. Micro) | ALIENS.CAS | Yes | `CASGOR /N` |  |  |
| Almanaque (1986)(Load 'n' Run)(es) | ALMANAQU.CAS | Yes | `CASGOR` |  |  |
| Alpha Blaster (1984)(Aackosoft) | ALPHA-BL.CAS | Yes | `CASGOR /CB` |  |  |
| Alpha Blaster (1984)(Aackosoft) | ALPHA2.CAS | Yes | `CASGOI /CB` |  |  |
| Alpha Blaster (1984)(Aackosoft) | ALPHA84.CAS | Yes | `CASGOI /CB` |  |  |
| Alpha Blaster (1987)(Eaglesoft) | ALPHA87.CAS | Yes | `CASGOR /CB` |  |  |
| Alpha Blaster (1987)(Eaglesoft) | ALPHAA.CAS | Yes | `CASGOR /CB` |  |  |
| Altered Beast (1988)(Activision)(Side A) | ALTERED.CAS | Yes | `CASGOI /S` |  |  |
| Amaurote (1987)(Mastertronic Added Dimension) | AMAUROTE.CAS | Yes | `CASGOI /B` |  |  |
| American Truck - Hi-Speed Scroll Action (1985)(Telenet Japan)(Japan) | AMERICAN.CAS | Yes | `CASGOI` |  |  |
| Amoto's Puf (1988)(SPE)(es) | AMOTO-S.CAS | Yes | `CASGOR` |  |  |
| An Adventure Of The Blue Universe (1985)(Leben Pro IO)(ja) | AN-ADVEN.CAS | Yes | `CASGOR` |  |  |
| Ananas (1989)(Eurosoft) | ANANAS.CAS | Yes | `CASGOR` |  |  |
| Andrea Petkovic Tennis (2017) | ANDREA.CAS | Yes | `CASGOI /C` |  |  |
| Andrea Petkovic Tennis (2017) | ANDREAES.CAS | Yes | `CASGOI /C` |  |  |
| Anexo 01, El Algoritmo (2018) | ANEXO-01.CAS | Yes | `CASGOR` |  |  |
| Anexo 01, El Algoritmo (2018) | ANEXOES.CAS | Yes | `CASGOI /C` |  |  |
| Anexo 01, El Algoritmo (2018) | ANEXOV.CAS | Yes | `CASGOI /C` |  |  |
| Angel Nieto Pole 500cc (1990)(Opera Soft)(es) | ANGEL-NI.CAS | Yes | `CASGOR /C` |  |  |
| Angleball (1987)(Mastertronic Added Dimension) | ANGLEBAL.CAS | Yes | `CASGOR` |  |  |
| Antarctic Adventure (Microbyte) (Argentina) | ANTARCTI.CAS | Yes | `CASGOI /B` |  |  |
| Antarctic Adventure (Pinguin) (Italy) | ANTARCAS.CAS | Yes | `CASGOI /B` |  |  |
| Antarctic Adventure (Pinguin) (Italy) | ANTARCTA.CAS | Yes | `CASGOI /S` |  |  |
| Antarctic Adventure-eu | ANTARCEU.CAS | Yes | `CASGOR` |  |  |
| Antarctica (1983) (Pony Canyon) | ANTARC83.CAS | Yes | `CASGOR` |  |  |
| AntiAir (2024)(inufuto) | ANTIAIR.CAS | Yes | `CASGOR` |  |  |
| Any Treasure Day (2018) (Timmy) | ANY-TREA.CAS | Yes | `CASGOR` |  |  |
| Arithmetic, Mathematics and English for Elementary and Junior High School Students, 2 Volumes, Learning Software (198x)(Soft & Soft),R | ARITHAND.CAS | Yes | `CASGOR` |  |  |
| Arithmetic, Mathematics and English for Elementary and Junior High School Students, 2 Volumes, Learning Software (198x)(Soft & Soft),R | ARITHMER.CAS | Yes | `CASGOR` |  |  |
| Arithmetic, Mathematics and English for Elementary and Junior High School Students, 2 Volumes, Learning Software (198x)(Soft & Soft),R | ARITHMET.CAS | Yes | `CASGOR` |  |  |
| Arithmetic, Mathematics and English for Elementary and Junior High School Students, 2 Volumes, Learning Software (198x)(Soft & Soft),R | ARITHMEX.CAS | Yes | `CASGOR` |  |  |
| Aritmo (1985)(DIMensionNEW)(es) | ARITMO.CAS | Yes | `CASGOR` |  |  |
| Arkanoid (1986)(Taito) | ARKANOID.CAS | Yes | `CASGOI /CB` |  |  |
| Arkanoid (Imagine) | ARKANOIR.CAS | Yes | `CASGOI /C` |  |  |
| Arkos I (1988)(Zigurat Software)(es) | ARKOS-I.CAS | Yes | `CASGOR /B` |  |  |
| Arkos II (1988)(Zigurat Software)(es) | ARKOS-II.CAS | Yes | `CASGOR /B` |  |  |
| Arkos III (1988)(Zigurat Software)(es) | ARKOSIII.CAS | Yes | `CASGOR /B` |  |  |
| Army Moves (1987)(Dinamic Software)(es)(Side A) | ARMY-MOA.CAS | Yes | `CASGOR` |  |  |
| Army Moves (1987)(Imagine Software)(Side A) | ARMY-MOV.CAS | Yes | `CASGOR` |  |  |
| Arquimedes XXI (1986)(Dinamic Software)(es) | ARQUIMED.CAS | Yes | `CASGOT /B` |  |  |
| Arquimedes XXI (1986)(Dinamic Software)(es) | ARQUIMER.CAS | Yes | `CASGOT /B` |  |  |
| Aspar GP Master (1988)(Dinamic Software)(es) | ASPAR2.CAS | Yes | `CASGOR` |  |  |
| Aspar GP Master (1988)(Dinamic Software)(es) | ASPAR88.CAS | Yes | `CASGOR` |  |  |
| Aspar GP Master (1988)(Dinamic Software)(es) | ASPARES.CAS | Yes | `CASGOR` |  |  |
| Aspar GP Master (1989)(Dinamic Software) | ASPAR-GP.CAS | Yes | `CASGOR` |  |  |
| Astro Blaster (1988)(Eurosoft) | ASTRO-BL.CAS | Yes | `CASGOR /CB` |  |  |
| Astro Blaster (1988)(Eurosoft) | ASTRO2.CAS | Yes | `CASGOR /CB` |  |  |
| Astro Blaster (1988)(Eurosoft) | ASTROA.CAS | Yes | `CASGOR /CB` |  |  |
| Astro Marine Corps (1989)(Dinamic Software)(es)(Side A) | ASTRO-MA.CAS | Yes | `CASGOT /B` |  |  |
| Astro Marine Corps (1989)(Dinamic Software)(es)(Side A) | ASTROES.CAS | Yes | `CASGOT /B` |  |  |
| Astronauta (1986)(Load 'n' Run)(es) | ASTRONAU.CAS | Yes | `CASGOR` |  |  |
| Attacked (19xx)(Tynesoft) | ATTACKXX.CAS | Yes | `CASGOI /B` |  |  |
| Attacked (Tynesoft) | ATTACKED.CAS | Yes | `CASGOI /B` |  |  |
| Auf Wiedersehen Monty (1987)(Gremlin Graphics Software) | AUF-WIED.CAS | Yes | `CASGOI /S` |  |  |
| Avenger (1986)(Erbe Software) | AVENGER.CAS | Yes | `CASGOI /S` |  |  |
| Avenger (1986)(Gremlin Graphics Software) | AVENGERR.CAS | Yes | `CASGOI /S` |  |  |
| Aventura Espacial, La (1990)(Aventuras AD)(es)(Side A) | AVENTURA.CAS | Yes | `CASGOI /CB` |  |  |
| Aventura Original, La (1989)(Aventuras AD)(es)(Side A) | AVENTU89.CAS | Yes | `CASGOT /CB` |  |  |
| Averno (1989)(Proein Soft Line)(es) | AVERNO.CAS | Yes | `CASGOR` |  |  |
| Awass (2026)(inufuto) | AWASS.CAS | Yes | `CASGOR` |  |  |
| Bakerman (2023)(AG Software) | BAKERMAN.CAS | Yes | `CASGOI /B` |  |  |
| Bal - Game Pack 1 (Aackosoft - Eaglesoft) | BAL-GAME.CAS | Yes | `CASGOR` |  |  |
| Bang! Bang! (1985)(Ample, Mel Software)(JP)(en) | BANG-BAN.CAS | Yes | `CASGOR` |  |  |
| Bang! Bang! (1985)(Ample, Mel Software)(JP)(en) | BANGGDX.CAS | Yes | `CASGOR` |  |  |
| Barbarian (1988)(Mastertronic)(es) | BARBARIA.CAS | Yes | `CASGOI /S` |  |  |
| Barbarian II - The Dungeon of Drax (1988)(Erbe Software) | BARBARII.CAS | Yes | `CASGOI /S` |  |  |
| Barn Stormer (1985)(Electric Software) | BARN-STO.CAS | Yes | `CASGOR` |  |  |
| Base de Datos (1985)(DIMensionNEW)(es) | BASE-DE.CAS | Yes | `CASGOI` |  |  |
| Base de Datos (19xx)(Toshiba)(es) | BASEXX.CAS | Yes | `CASGOR` |  |  |
| Baseball - Game Pack 1 (Aackosoft - Eaglesoft) | BASEBALL.CAS | Yes | `CASGOR` |  |  |
| BASICODE-3(1987)(NOS)(NL) | BASICODE.CAS | Yes | `CASGOI` |  |  |
| Batalla Espacial (19xx)(Grupo de Trabajo Software)(es) | BATALLA.CAS | Yes | `CASGOR` |  |  |
| Batman (1986)(Erbe Software) | BATMAN.CAS | Yes | `CASGOI /B` |  |  |
| Batman (1986)(Ocean Software) | BATMAN86.CAS | Yes | `CASGOI /B` |  |  |
| Batman (1986)(Ocean Software) | BATMANA.CAS | Yes | `CASGOI /B` |  |  |
| Batman - The Movie (1989)(Ocean Software)(Side A) | BATMATHE.CAS | Yes | `CASGOI /S` |  |  |
| Battle Chopper (1985)(Methodic Solutions) | BATTLE.CAS | Yes | `CASGOR /CB` |  |  |
| Battle Mecha Xabungle Blue Gale Part 1 (1985) (Pony Canyon)[CLOAD + RUN) | BATTLE1.CAS | Yes | `CASGOR` |  |  |
| Battleship Clapton II (1983)(T&E Soft) | BATTLESH.CAS | Yes | `CASGOR` |  |  |
| Battlot (2021)(Inufuto) | BATTLOT.CAS | Yes | `CASGOR` |  |  |
| BC's Quest for Tires II - Grog's Revenge (1985)(US Gold) | BC-S85.CAS | Yes | `CASGOM /B` |  |  |
| BC's Quest for Tires II - Grog's Revenge (1985)(US Gold) | BC-SUS.CAS | Yes | `CASGOM /B` |  |  |
| BC's Quest for Tires II - Grog's Revenge (1987)(Eaglesoft) | BC-S-QUE.CAS | Yes | `CASGOI /CB` |  |  |
| BCs Quest For Tyres | BCS-QUES.CAS | Yes | `CASGOR` |  |  |
| Beach-Head (1985)(US Gold) | BEACH-HE.CAS | Yes | `CASGOI /B` |  |  |
| Beamrider (1984)(Activision) | BEAMRIDE.CAS | Yes | `CASGOR` |  |  |
| Bear George (1985)(Soft Bee) | BEAR-GEO.CAS | Yes | `CASGOR` |  |  |
| Berlin (1985)(Omega System) | BERLIN.CAS | Yes | `CASGOR` |  |  |
| Bestial Warrior (1989)(Dinamic Software)(es) | BESTIAL.CAS | Yes | `CASGOR /B10` |  |  |
| Bestial Warrior (1989)(Dinamic Software)(es) | BESTIALA.CAS | Yes | `CASGOR /B11` |  |  |
| Binary Land (HoneyBee Soft) (Hudson Soft) (Japan) | BINARY.CAS | Yes | `CASGOR` |  |  |
| Biotech (1983) (Hudson Soft) | BIOTECH.CAS | Yes | `CASGOR` |  |  |
| Birds And Chairs (2017) | BIRDS-AN.CAS | Yes | `CASGOR` |  |  |
| Bit Byter (19xx)(Spectravideo) | BIT-BYTE.CAS | Yes | `CASGOR` |  |  |
| Black Bass, The (1986)(Hot-B)(ja) | BLACK-BA.CAS | Yes | `CASGOR` |  |  |
| Blackbeard (1988)(Topo Soft)(es) | BLACKBEA.CAS | Yes | `CASGOI /S` |  |  |
| Blackjack (1985)(DIMensionNEW)(es) | BLACKJAC.CAS | Yes | `CASGOR` |  |  |
| Blagger Enhanced | BLAGGER.CAS | Yes | `CASGOR` |  |  |
| Blagger Enhanced | BLAGGERR.CAS | Yes | `CASGOR` |  |  |
| Blasteroids (1987)(Image Works) | BLASTERO.CAS | Yes | `CASGOI /S` |  |  |
| Blitz Krieg (1985)(Omega System) | BLITZ-KR.CAS | Yes | `CASGOR` |  |  |
| Blocker (19xx)(Grupo de Trabajo Software) | BLOCKER.CAS | Yes | `CASGOR` |  |  |
| Bloody (1987)(P.J. Software)(es) | BLOODY.CAS | Yes | `CASGOR` |  |  |
| Blow Up (1988)(Eurosoft) | BLOW-UP.CAS | Yes | `CASGOR /CB` |  |  |
| Blow Up (1988)(Eurosoft) | BLOW-UPA.CAS | Yes | `CASGOR /CB` |  |  |
| BMX Simulator (1987)(Codemasters) | BMX-SIMU.CAS | Yes | `CASGOT /B9` |  |  |
| Boardello (1985)(Bubblebus Software) | BOARDELA.CAS | Yes | `CASGOR /CB` |  |  |
| Boardello (1985)(Bubblebus Software) | BOARDELL.CAS | Yes | `CASGOR` |  |  |
| Bob 007 - Infiltrado (1986)(Grupo de Trabajo Software)(es) | BOB-007.CAS | Yes | `CASGOR` |  |  |
| Bob 007 - Infiltrado (1986)(Grupo de Trabajo Software)(es) | BOB-007A.CAS | Yes | `CASGOR` |  |  |
| Bomberman | BOMBERMA.CAS | Yes | `CASGOR` |  |  |
| Booga-Boo the Flea (1986)(Quicksilva) | BOOGA-BO.CAS | Yes | `CASGOR` |  |  |
| Booga-Boo the Flea (1986)(Quicksilva) | BOOGAA.CAS | Yes | `CASGOR` |  |  |
| Boom (1986)(Aackosoft) | BOOM.CAS | Yes | `CASGOR` |  |  |
| Boom (1988)(Eurosoft) | BOOM88.CAS | Yes | `CASGOR /CB` |  |  |
| Boom! - MSX Compilation 4 (ByteBusters) (Aackosoft - Eaglesoft) | BOOM-MSX.CAS | Yes | `CASGOR /CB` |  |  |
| Bootskell (2021)(Inufuto) | BOOTSKEL.CAS | Yes | `CASGOR` |  |  |
| Booty (1988)(Eurosoft) | BOOTY.CAS | Yes | `CASGOR /CB` |  |  |
| Bop! (1986)(Bug-Byte Software) | BOP.CAS | Yes | `CASGOR` |  |  |
| Boulder Dash (1985)(Databyte) | BOULDE85.CAS | Yes | `CASGOR` |  |  |
| Boulder Dash (1985)(Databyte) | BOULDER.CAS | Yes | `CASGOR` |  |  |
| Boulder Dash II - Rockford's Revenge (First Star) (Databyte) | BOULDEII.CAS | Yes | `CASGOR` |  |  |
| Boulder Dash II - Rockford's Revenge (First Star) (Databyte) (Side A) | BOULDERS.CAS | Yes | `CASGOR` |  |  |
| Boulder Dash II - Rockford's Riot (1986)(Databyte) | BOULDE86.CAS | Yes | `CASGOR` |  |  |
| Boulder Dash II - Rockford's Riot (1986)(Databyte) | BOULDERA.CAS | Yes | `CASGOI /CB` |  |  |
| Bounce (1987)(Methodic Solutions) | BOUNCE.CAS | Yes | `CASGOR` |  |  |
| Bound Rescue (1984)(Shouji Ogawa) | BOUND-RE.CAS | Yes | `CASGOR` |  |  |
| Bounder (1987)(Gremlin Graphics Software) | BOUNDER.CAS | Yes | `CASGOI /S` |  |  |
| Bounder (1987)(Gremlin Graphics Software) | BOUNDERA.CAS | Yes | `CASGOI /S` |  |  |
| Break In (1987)(Eaglesoft) | BREAK-IN.CAS | Yes | `CASGOR /CB` |  |  |
| Break In (1987)(Eaglesoft) | BREAKA.CAS | Yes | `CASGOR /CB` |  |  |
| Break Out! (1985)(Toshiba-EMI) | BREAK-OU.CAS | Yes | `CASGOI /B` |  |  |
| Break Out! (1985)(Toshiba-EMI) | BREAKIN.CAS | Yes | `CASGOI /B` |  |  |
| Break Out! (1985)(Toshiba-EMI) | BREAKK.CAS | Yes | `CASGOI /B` |  |  |
| BreakBomb (2021)(Gamecast) | BREAKBOM.CAS | Yes | `CASGOR` |  |  |
| Breaker Breaker (1988)(Eurosoft) | BREAKER.CAS | Yes | `CASGOR /CB` |  |  |
| Breaker Breaker (1988)(Eurosoft) | BREAKERA.CAS | Yes | `CASGOR /CB` |  |  |
| Breakout(1985)(Toshiba) | BREAKOUT.CAS | Yes | `CASGOI /B` |  |  |
| Brian Jacks Superstar Challenge (1985)(Martech Games)(Side A) | BRIAN-JA.CAS | Yes | `CASGOR` |  |  |
| Brian Jacks Superstar Challenge (1985)(Martech Games)(Side A) | BRIANA.CAS | Yes | `CASGOR` |  |  |
| British Bob | BRITISH.CAS | Yes | `CASGOR` |  |  |
| Bronx (1989)(Animagic)(es) | BRONX.CAS | Yes | `CASGOI /S` |  |  |
| Bruce Lee (1985)(Comptiq) | BRUCE-LE.CAS | Yes | `CASGOI /B` |  |  |
| Bubblekund 1999 (1984)(Softbank)(ja) | BUBBLEKU.CAS | Yes | `CASGOR` |  |  |
| Bubbler (1987)(Ultimate Play The Game) | BUBBLER.CAS | Yes | `CASGOT /C` |  |  |
| Bubbo World | BUBBO-WO.CAS | Yes | `CASGOR` |  |  |
| Bubbo World 2 | BUBBO2.CAS | Yes | `CASGOR` |  |  |
| Buck Rogers - Planet of Zoom (1983)(Sega) | BUCK-ROG.CAS | Yes | `CASGOR` |  |  |
| Buddhagillie (2018) (GW's Workshop) | BUDDHAGI.CAS | Yes | `CASGOR` |  |  |
| Budokan (1991)(Dro Soft)(Side A) | BUDOKAN.CAS | Yes | `CASGOT /S` |  |  |
| Buggy Ranger (1990)(Dinamic Software)(es) | BUGGY-RA.CAS | Yes | `CASGOT /B` |  |  |
| Bumper Ship Racing (2018) (Uninteresting) | BUMPER.CAS | Yes | `CASGOR` |  |  |
| Bumpy (1989)(Loriciels) | BUMPY.CAS | Yes | `CASGOT /B` |  |  |
| Bumpy (1989)(Loriciels) | BUMPY89.CAS | Yes | `CASGOT /B` |  |  |
| Bumpy (19xx)(Grupo de Trabajo Software)(es) | BUMPYDE.CAS | Yes | `CASGOR` |  |  |
| Burn Us (2018) (Carambalan Studios)[Bload'CAS-',R | BURN-US.CAS | Yes | `CASGOR /B` |  |  |
| Buster Block (1985)(Kuma Computers) | BUSTER.CAS | Yes | `CASGOM /B` |  |  |
| Busy Rainy Day (1983)(Hudson Soft) | BUSY-RAI.CAS | Yes | `CASGOR` |  |  |
| Buzz Off! (1984)(Electric Software) | BUZZ-OFF.CAS | Yes | `CASGOR` |  |  |
| Buzz Off! (1984)(Electric Software) | BUZZ-OFR.CAS | Yes | `CASGOR` |  |  |
| Buzz Off! (1984)(Electric Software) | BUZZRUN.CAS | Yes | `CASGOR` |  |  |
| Bytebusters (1984)(Aackosoft) | BYTEBUST.CAS | Yes | `CASGOR` |  |  |
| Cacorm (2022)(Inufuto) | CACORM.CAS | Yes | `CASGOR` |  |  |
| Calculator New (1985)(DIMensionNEW)(es) | CALCULAT.CAS | Yes | `CASGOR` |  |  |
| Caldero Magico, El (1986)(Grupo de Trabajo Software)(es) | CALDERO.CAS | Yes | `CASGOR` |  |  |
| California Games (1987)(US Gold)(Side A) | CALIFORN.CAS | Yes | `CASGOR /N` |  |  |
| Camelot Warriors (1986)(Dinamic Software)(es) | CAMELOT.CAS | Yes | `CASGOR` |  |  |
| Camelot Warriors (1986)(Dinamic Software)(es) | CAMELOTA.CAS | Yes | `CASGOR` |  |  |
| Camelot Warriors (1986)(Dinamic Software)(es) | CAMELOTR.CAS | Yes | `CASGOI /C` |  |  |
| Can of Worms (1986)(LiveWire Software) | CAN-OF.CAS | Yes | `CASGOR` |  |  |
| Cannon Ball (1983)(Hudson Soft) | CANNON.CAS | Yes | `CASGOR` |  |  |
| Cannon Fighter (1984) (Moorwood Software) | CANNONR.CAS | Yes | `CASGOI` |  |  |
| Capitan Sevilla (1988)(Dinamic Software)(es)(Side A) | CAPITA88.CAS | Yes | `CASGOR /B` |  |  |
| Capitan Sevilla (1988)(Dinamic Software)(Side A) | CAPITAN.CAS | Yes | `CASGOR /B` |  |  |
| Capitan Trueno (1989)(Dinamic Software)(es)(Side A) | CAPITA89.CAS | Yes | `CASGOM /B` |  |  |
| Carlos Sainz (1990)(Zigurat Software)(es) | CARLOS.CAS | Yes | `CASGOR /B` |  |  |
| Casanova (1989)(Iber Soft)(es) | CASANOVA.CAS | Yes | `CASGOI /S` |  |  |
| Castle Combat (1985)(Spectravideo) | CASTLE.CAS | Yes | `CASGOR` |  |  |
| Catle Tomb (2023)(Gamecast Entertainment) | CATLE-TO.CAS | Yes | `CASGOI /B` |  |  |
| Cave Adventure (Chitai Tanken)(1984)(Ample Software) | CAVE-ADV.CAS | Yes | `CASGOR` |  |  |
| Cavern of Death (1987)(Dro Soft)(es) | CAVERN.CAS | Yes | `CASGOR` |  |  |
| Caverns Of Titan | CAVERNS.CAS | Yes | `CASGOR` |  |  |
| Caverns Of Titan 2 | CAVERNS2.CAS | Yes | `CASGOR` |  |  |
| Cavit (2021)(Inufuto) | CAVIT.CAS | Yes | `CASGOR` |  |  |
| Caza (1986)(Load 'n' Run)(es) | CAZA.CAS | Yes | `CASGOR` |  |  |
| Cetus (1986)(Tynesoft) | CETUS.CAS | Yes | `CASGOR` |  |  |
| Chack 'n Pop (1984)(Taito) | CHACK-N.CAS | Yes | `CASGOR` |  |  |
| Champ (1984)(PSS) | CHAMP.CAS | Yes | `CASGOR` |  |  |
| Champions Grand National (1984)(Pony Canyon) | CHAMPION.CAS | Yes | `CASGOR` |  |  |
| Chase H.Q. (1988)(Ocean Software)(Side A) | CHASE-H.CAS | Yes | `CASGOI /S` |  |  |
| Chase H.Q. (1988)(Ocean Software)(Side A) | CHASEA.CAS | Yes | `CASGOI /S` |  |  |
| Checkmate! First Moves in Chess (1985)(Toshiba-EMI) | CHECKEMI.CAS | Yes | `CASGOI /B` |  |  |
| Checkmate! First Moves in Chess (1985)(Toshiba-EMI) | CHECKMA2.CAS | Yes | `CASGOI /B` |  |  |
| Checkmate! First Moves in Chess (1985)(Toshiba-EMI) | CHECKMIN.CAS | Yes | `CASGOI /B` |  |  |
| Checkmate!(1985)(Toshiba) | CHECKMAT.CAS | Yes | `CASGOI /B` |  |  |
| Chess Game, The (1985)(Eaglesoft) | CHESS-GA.CAS | Yes | `CASGOR` |  |  |
| Chicago 30's (1988)(Topo Soft)(es) | CHICAGO.CAS | Yes | `CASGOI /S` |  |  |
| Chicken Chase (1986)(Bug-Byte Software) | CHICKEN.CAS | Yes | `CASGOI /B` |  |  |
| Chiemi Hori Strawberry Puzzle (1984)(Pony Canyon)(ja) | CHIEMI.CAS | Yes | `CASGOR` |  |  |
| Chiller (1985)(Mastertronic) | CHILLCAS.CAS | Yes | `CASGOR` |  |  |
| Chiller (1985)(Mastertronic) | CHILLER.CAS | Yes | `CASGOR` |  |  |
| Chiller (1985)(Mastertronic) | CHILLER2.CAS | Yes | `CASGOR` |  |  |
| Chiller (1985)(Mastertronic) | CHILLER3.CAS | Yes | `CASGOR` |  |  |
| Chiller (1985)(Mastertronic) | CHILLER4.CAS | Yes | `CASGOR` |  |  |
| Chiller (1985)(Mastertronic) | CHILLERA.CAS | Yes | `CASGOR` |  |  |
| Chopper (1986)(Eaglesoft) | CHOPPE86.CAS | Yes | `CASGOR /CB` |  |  |
| Chopper (1986)(Eaglesoft) | CHOPPER.CAS | Yes | `CASGOR /CB` |  |  |
| Chopper One (1988)(Eurosoft) | CHOPPONE.CAS | Yes | `CASGOR /CB` |  |  |
| Choro Q (1984)(Taito) | CHORO-Q.CAS | Yes | `CASGOR` |  |  |
| Choy-Lee-Fut Kung-Fu Warrior (1990)(Positive)(es) | CHOY-LEE.CAS | Yes | `CASGOT /B` |  |  |
| Chubby Gristle (1987)(Grandslam Entertainment) | CHUBBY.CAS | Yes | `CASGOI /S` |  |  |
| Chuck Yeager's Advanced Flight Trainer (1989)(Dro Soft) | CHUCK-YE.CAS | Yes | `CASGOI /S7` |  |  |
| Chuckie Egg | CHUCKIE.CAS | Yes | `CASGOR` |  |  |
| Chuckie Egg (1984)(A & F Software) | CHUCKCAS.CAS | Yes | `CASGOR` |  |  |
| Chuckie Egg (1984)(A & F Software) | CHUCKI84.CAS | Yes | `CASGOR` |  |  |
| Chuckie Egg (1984)(A & F Software) | CHUCKIE2.CAS | Yes | `CASGOR` |  |  |
| Chuckie Egg (1984)(A & F Software) | CHUCKIEA.CAS | Yes | `CASGOR` |  |  |
| Chuckie Egg (1985)(Aackosoft) | CHUCKI85.CAS | Yes | `CASGOR` |  |  |
| Ci-U-Than Trilogy I - La Diosa de Cozumel (1990)(Aventuras AD)(es)(Side A) | CI-U90.CAS | Yes | `CASGOI /CB` |  |  |
| Ci-U-Than Trilogy I - La Diosa de Cozumel (1990)(Aventuras AD)(es)(Side A) | CI-ULA.CAS | Yes | `CASGOI /CB` |  |  |
| Ci-U-Than Trilogy II - Los Templos Sagrados (1991)(Aventuras AD)(es)(Side A) | CI-ULOS.CAS | Yes | `CASGOI /S` |  |  |
| Ci-U-Than Trilogy III - Chichen Itza (1992)(Aventuras AD)(es)(Side A) | CI-U-THA.CAS | Yes | `CASGOI /CB` |  |  |
| Cid, El (1987)(Dro Soft)(es) | CID-EL.CAS | Yes | `CASGOR` |  |  |
| City Connection (1986)(Jaleco) | CITY-CON.CAS | Yes | `CASGOI /CB` |  |  |
| City Connection (1987)(Eaglesoft) | CITY87.CAS | Yes | `CASGOI /CB` |  |  |
| Cobra's Arc (1986)(Dinamic Software)(es) | COBRA-S.CAS | Yes | `CASGOI /B` |  |  |
| Coliseum (1988)(Topo Soft)(es) | COLISEUM.CAS | Yes | `CASGOI /S` |  |  |
| Colony (1987)(Bulldog) | COLONY.CAS | Yes | `CASGOR` |  |  |
| Colossal Adventure  - B-Version - Text Only (1984)(Level 9 Computing) | COLOSSAB.CAS | Yes | `CASGOR` |  |  |
| Colossal Adventure - Text Only (1984)(Level 9 Computing) | COLOSSAL.CAS | Yes | `CASGOR` |  |  |
| Colossus 4 Chess (1986)(CDS Microsystems) | COLOSSUS.CAS | Yes | `CASGOI /S` |  |  |
| Colt 36 (1987)(Topo Soft)(es) | COLT-36.CAS | Yes | `CASGOR` |  |  |
| Comando Quatro (1989)(Zigurat Software)(es) | COMANDO.CAS | Yes | `CASGOI /B` |  |  |
| Comando Tracer (1989)(Dinamic Software)(es) | COMANDES.CAS | Yes | `CASGOM /B` |  |  |
| Comando Tracer (1989)(Dinamic Software)(es) | COMANDOA.CAS | Yes | `CASGOM /B` |  |  |
| Comando Tracer (1989)(Dinamic Software)(es) | COMANDOB.CAS | Yes | `CASGOI /B` |  |  |
| Comecocos (19xx)(Idealogic)(es) | COMECOCO.CAS | Yes | `CASGOR` |  |  |
| Cometa Halley (1985)(Sony)(es) | COMETA.CAS | Yes | `CASGOR` |  |  |
| Compra y Vende (1985)(Idealogic)(es) | COMPRA.CAS | Yes | `CASGOR` |  |  |
| Computadora Adivina (1985)(Sony)(es) | COMPUTAD.CAS | Yes | `CASGOR` |  |  |
| Computer Fan Tan (1985)(Login Soft) | COMPUTER.CAS | Yes | `CASGOR` |  |  |
| Confused (1986)(Eaglesoft) | CONFUSEA.CAS | Yes | `CASGOR /CB` |  |  |
| Confused (1986)(Eaglesoft) | CONFUSED.CAS | Yes | `CASGOR /CB` |  |  |
| Congo (1986)(LiveWire Software) | CONGO.CAS | Yes | `CASGOR` |  |  |
| Congo Bongo (1983)(Sega) | CONGO-BO.CAS | Yes | `CASGOR` |  |  |
| Contabilidad (1985)(Sony)(es) | CONTABIL.CAS | Yes | `CASGOI /CB` |  |  |
| Contabilidad Domestica (1985)(DIMensionNEW)(es) | CONTACAS.CAS | Yes | `CASGOR` |  |  |
| Contabilidad I (19xx)(Mind Games Espana)(es) | CONTAB19.CAS | Yes | `CASGOR` |  |  |
| Contabilidad I (19xx)(Mind Games Espana)(es) | CONTABXX.CAS | Yes | `CASGOR` |  |  |
| Continental Circus (1989)(Virgin Mastertronic)(Side A) | CONTINEN.CAS | Yes | `CASGOI /S` |  |  |
| Contract Bridge (1984)(Alligata Software) | CONTRACT.CAS | Yes | `CASGOR` |  |  |
| Corsarios (1989)(Opera Soft)(es)(Side A) | CORSARIO.CAS | Yes | `CASGOR /C` |  |  |
| Cosa Nostra (1986)(Opera Soft)(es) | COSA-NOS.CAS | Yes | `CASGOR` |  |  |
| Cosmic Sheriff (1989)(Dinamic Software)(es) | COSMIC.CAS | Yes | `CASGOT /B` |  |  |
| Cosmic Shock Absorber (1986)(Martech Games) | COSMIC86.CAS | Yes | `CASGOR` |  |  |
| Cosmix Shock Absorber (1987)(Martech Games) | COSMIX.CAS | Yes | `CASGOR` |  |  |
| Cosmo Traveler (1983)(Colpax) | COSMO-TR.CAS | Yes | `CASGOR` |  |  |
| Cosmos (1985)(Sony)(es) | COSMOS.CAS | Yes | `CASGOR` |  |  |
| Cracky (2023)(Inufuto) | CRACKY.CAS | Yes | `CASGOR` |  |  |
| Crash Together - Butsukekko (1983)(Central Education) | CRASH-TO.CAS | Yes | `CASGOR` |  |  |
| Crazy Cars | CRAZY-CA.CAS | Yes | `CASGOR` |  |  |
| Crazy Golf (1984)(Mr. Micro) | CRAZY-GO.CAS | Yes | `CASGOR` |  |  |
| Cross Chase (2018) (Fabrizio Caruso) | CROSS-CH.CAS | Yes | `CASGOR` |  |  |
| Crusader (1987)(Eaglesoft) | CRUSADEA.CAS | Yes | `CASGOI /CB` |  |  |
| Crusader (1987)(Eaglesoft) | CRUSADER.CAS | Yes | `CASGOI /CB` |  |  |
| Cryptic Cube (Spectravideo) | CRYPTIC.CAS | Yes | `CASGOR` |  |  |
| Cubik. Cubo de Rubik (1985)(Monser)(es) | CUBIK-CU.CAS | Yes | `CASGOR` |  |  |
| Cubit (1986)(Mr. Micro) | CUBIT.CAS | Yes | `CASGOR` |  |  |
| Cubit (1986)(Mr. Micro) | CUBITA.CAS | Yes | `CASGOR` |  |  |
| Curro Jimenez (1989)(Zigurat Software)(es) | CURRO-JI.CAS | Yes | `CASGOR /B` |  |  |
| Curso de BASIC (1985)(Sony)(es)(Side A) | CURSO-DE.CAS | Yes | `CASGOR` |  |  |
| Cyberbig (1989)(Animagic) | CYBERBIG.CAS | Yes | `CASGOI /S` |  |  |
| Cyberun (1985)(Ultimate Play The Game) | CYBERUN.CAS | Yes | `CASGOT /C` |  |  |
| D-Day (1984)(Jaleco) | D-DAY.CAS | Yes | `CASGOI /CB` |  |  |
| Daidasso. Great Escape (1985)(Carry Lab) | DAIDASSO.CAS | Yes | `CASGOR` |  |  |
| Dam Busters, The | DAM-BUST.CAS | Yes | `CASGOT /B` |  |  |
| Dam Busters, The (1985)(Erbe Software) | DAM-BU85.CAS | Yes | `CASGOT /B` |  |  |
| Damas (1985)(DIMensionNEW)(es) | DAMAS.CAS | Yes | `CASGOR` |  |  |
| Darkwood Manor (19xx)(Kuma Computers) | DARKWOOA.CAS | Yes | `CASGOR` |  |  |
| Darkwood Manor (19xx)(Kuma Computers) | DARKWOOD.CAS | Yes | `CASGOR` |  |  |
| Databa (19xx)(Philips) | DATABA.CAS | Yes | `CASGOR` |  |  |
| Datilografia (1986)(Sysout) | DATILOGR.CAS | Yes | `CASGOR` |  |  |
| Dawn Patrol (1987)(Eaglesoft)(NL) | DAWN-PAT.CAS | Yes | `CASGOR /CB` |  |  |
| Death Valley Gold Rush (1985)(Kuma Computers) | DEATH-VA.CAS | Yes | `CASGOR` |  |  |
| Death Wish 3 (1987)(Gremlin Graphics Software) | DEATH-WI.CAS | Yes | `CASGOI /S` |  |  |
| Decathlon (1984)(Activision) | DECATHLO.CAS | Yes | `CASGOR` |  |  |
| Deep Core Raider (P. Jenkinson) | DEEP-COR.CAS | Yes | `CASGOR` |  |  |
| Defcom 1 (1989)(Iber Soft)(Side A) | DEFCOM-1.CAS | Yes | `CASGOI /S` |  |  |
| Demand (1984)(Login Soft) | DEMAND.CAS | Yes | `CASGOI` |  |  |
| Demand (1985)(Login Soft) | DEMANRUN.CAS | Yes | `CASGOR` |  |  |
| Demo, De (1985)(Philips)(nl) | DEMO85.CAS | Yes | `CASGOR` |  |  |
| Demo, De - Adres Boek (1985)(Philips)(nl) | DEMORUN.CAS | Yes | `CASGOR` |  |  |
| Demo, De - Hexapion (1985)(Philips)(nl) | DEMO-DE.CAS | Yes | `CASGOR` |  |  |
| Demo, De - Lanceer (1985)(Philips)(nl) | DEMONL.CAS | Yes | `CASGOR` |  |  |
| Demo, De - Nederland (1985)(Philips)(nl) | DEMOCAS.CAS | Yes | `CASGOR` |  |  |
| demo_rodman_msx | DEMO-ROD.CAS | Yes | `CASGOR` |  |  |
| Demonia (1986)(Microids)(fr) | DEMONIA.CAS | Yes | `CASGOI /B` |  |  |
| Desolator (1986)(Gremlin Graphics Software) | DESOLATA.CAS | Yes | `CASGOT /S` |  |  |
| Desolator (1986)(Gremlin Graphics Software) | DESOLATO.CAS | Yes | `CASGOT /S` |  |  |
| Desperado (1987)(Topo Soft)(es)(Side A) | DESPER87.CAS | Yes | `CASGOI /S` |  |  |
| Desperado 2 (1991)(Topo Soft)(es) | DESPERA2.CAS | Yes | `CASGOI /S` |  |  |
| Desperado 2 (1991)(Topo Soft)(es) | DESPERAD.CAS | Yes | `CASGOI /B` |  |  |
| Destroyer (1986)(Mind Games Espana) | DESTROYE.CAS | Yes | `CASGOR` |  |  |
| Deus Ex Machina (1985)(Mind Games Espana)(es)(Side A) | DEUS-EX.CAS | Yes | `CASGOR` |  |  |
| Dezeni Land (1984)(Hudson Soft)(ja)(Side A) | DEZENI.CAS | Yes | `CASGOR` |  |  |
| Dial Number (1985)(Nippon Columbia) | DIAL-NUM.CAS | Yes | `CASGOR` |  |  |
| Dial Number (1985)(Nippon Columbia) | DIALBY.CAS | Yes | `CASGOR` |  |  |
| Diamond Adventure (1983)(MicroCabin)(JP) | DIAMOND.CAS | Yes | `CASGOR` |  |  |
| Dieet (1986)(Philips)(nl)(Side A) | DIEET.CAS | Yes | `CASGOR` |  |  |
| Dieet (1986)(Philips)(nl)(Side A) | DIEETA.CAS | Yes | `CASGOR` |  |  |
| Dig Dug (1984)(Bug-Byte Software) | DIG-DUG.CAS | Yes | `CASGOR /N` |  |  |
| Dim-Calc (1985)(DIMensionNEW)(es) | DIM-CALC.CAS | Yes | `CASGOR` |  |  |
| Dimensional Wars (1984)(SoftBank) | DIMENSIO.CAS | Yes | `CASGOI /C` |  |  |
| Disc Warrior (1984)(Alligata Software) | DISC84.CAS | Yes | `CASGOR` |  |  |
| Disc Warrior (1984)(Alligata Software) | DISCCAS.CAS | Yes | `CASGOR` |  |  |
| Disc Warrior (1984)(Micro Cabin) | DISCRUN.CAS | Yes | `CASGOR` |  |  |
| Discovery (1988)(Eurosoft) | DISCOVE2.CAS | Yes | `CASGOR /CB` |  |  |
| Discovery (1988)(Eurosoft) | DISCOVEA.CAS | Yes | `CASGOR /CB` |  |  |
| Discovery (1988)(Eurosoft) | DISCOVER.CAS | Yes | `CASGOR /CB` |  |  |
| Disenador de Graficos (1985)(Advance)(es) | DISENADO.CAS | Yes | `CASGOR` |  |  |
| Dizzy Ball (1984)(Pony Canyon) | DIZZY-BA.CAS | Yes | `CASGOR` |  |  |
| Dizzy Balloon (1985)(Pony Canyon) | DIZZYCAS.CAS | Yes | `CASGOR` |  |  |
| Dizzy Dice (1988)(Players Software) | DIZZY-DI.CAS | Yes | `CASGOR` |  |  |
| Dog Fighter (1986)(Kuma Computers) | DOG-FIGA.CAS | Yes | `CASGOR` |  |  |
| Dog Fighter (1986)(Kuma Computers) | DOG-FIGH.CAS | Yes | `CASGOR` |  |  |
| Doki Doki Penguinland (1985)(Sega)(Bitgame Release) | DOKI-DOK.CAS | Yes | `CASGOI /B` |  |  |
| Domino (1985)(DIMensionNEW)(es) | DOMINO.CAS | Yes | `CASGOR` |  |  |
| Domino (1985)(DIMensionNEW)(es) | DOMINOA.CAS | Yes | `CASGOR` |  |  |
| Don Quijote (1987)(Dinamic Software)(es)(Side A) | DON-QUIJ.CAS | Yes | `CASGOI /B` |  |  |
| Donkey Kong (1986)(Erbe Software) | DONKEY.CAS | Yes | `CASGOI /B` |  |  |
| Donkey Kong (1986)(Ocean Software) | DONKECAS.CAS | Yes | `CASGOI /B` |  |  |
| Donkey Kong (1986)(Ocean Software) | DONKEYA.CAS | Yes | `CASGOI /B` |  |  |
| Donpan (1983)(Tomy) | DONPAN.CAS | Yes | `CASGOR` |  |  |
| Doopm Community | DOOPM-CO.CAS | Yes | `CASGOR` |  |  |
| Double Dragon (1988)(Dro Soft)(es)(Side A) | DOUBLE88.CAS | Yes | `CASGOI /S` |  |  |
| Double Dragon II - The Revenge (1990)(Dro Soft)(es) | DOUBLE.CAS | Yes | `CASGOI /S` |  |  |
| Dr. Jackle and Mr. Wide (1987)(Bulldog) | DR-JACKA.CAS | Yes | `CASGOR` |  |  |
| Dr. Jackle and Mr. Wide (1987)(Bulldog) | DR-JACKL.CAS | Yes | `CASGOR` |  |  |
| Draconic Throne (2017) (GW's Workshop) (1.02) | DRACONIC.CAS | Yes | `CASGOR` |  |  |
| Dracula (1986)(Grupo de Trabajo Software)(es) | DRACULA.CAS | Yes | `CASGOR` |  |  |
| Dragon Ninja (1988)(Imagine Software) | DRAGON.CAS | Yes | `CASGOI /S` |  |  |
| Dragon Ninja (1988)(Imagine Software)(Side A) | DRAGORUN.CAS | Yes | `CASGOI /S` |  |  |
| Dragon Slayer (1985)(Square) | DRAGON85.CAS | Yes | `CASGOR` |  |  |
| Drazen Petrovic Basket (1989)(Topo Soft)(es) | DRAZEN.CAS | Yes | `CASGOI /S` |  |  |
| Driller Tanks (1984)(Hudson Soft) | DRILLER.CAS | Yes | `CASGOR` |  |  |
| Drome (1987)(Eaglesoft) | DROME.CAS | Yes | `CASGOR /CB` |  |  |
| Drome (1987)(Eaglesoft) | DROME2.CAS | Yes | `CASGOR /CB` |  |  |
| Drome (1987)(Eaglesoft) | DROME3.CAS | Yes | `CASGOR /CB` |  |  |
| Drome (1987)(Eaglesoft) | DROMEA.CAS | Yes | `CASGOR /CB` |  |  |
| Dungeon Adventure - Text Only (1984)(Level 9 Computing) | DUNGEON.CAS | Yes | `CASGOR` |  |  |
| Dustin (1987)(Dinamic Software)(es) | DUSTIN.CAS | Yes | `CASGOM /B` |  |  |
| Dynamite Dan (1986)(Mirrorsoft) | DYNAMITE.CAS | Yes | `CASGOI /N` |  |  |
| Eagle (1987)(Juliet Software) | EAGLE.CAS | Yes | `CASGOR` |  |  |
| Echec (1985)(Loriciels) | ECHEC.CAS | Yes | `CASGOI /B` |  |  |
| Echec (1985)(Loriciels)(en) | ECHECEN.CAS | Yes | `CASGOI /B` |  |  |
| Echec (1985)(Loriciels)(fr) | ECHECFR.CAS | Yes | `CASGOI /B` |  |  |
| Eddie Kidd Jump Challenge (1985)(Martech Games) | EDDIE-KI.CAS | Yes | `CASGOR` |  |  |
| Eddie Kidd Jump Challenge (1985)(Martech Games) | EDDIE85.CAS | Yes | `CASGOR` |  |  |
| Eddy - Animation Editor (1984)(Hal Laboratory) | EDDY-ANI.CAS | Yes | `CASGOR` |  |  |
| Eggerland Mystery (Microbyte) (Argentina) | EGGERLAN.CAS | Yes | `CASGOR /B` |  |  |
| Elevator Action | ELEVATOR.CAS | Yes | `CASGOR /B` |  |  |
| Elidon (1986)(Aackosoft) | ELIDON.CAS | Yes | `CASGOR` |  |  |
| Elidon (1986)(Aackosoft) | ELIDON2.CAS | Yes | `CASGOR` |  |  |
| Elidon (1986)(Aackosoft) | ELIDONA.CAS | Yes | `CASGOR` |  |  |
| Eliza - Game Pack 1 (Aackosoft - Eaglesoft) | ELIZA-GA.CAS | Yes | `CASGOR` |  |  |
| Emerald Isle (1985)(Level 9 Computing) | EMERALD.CAS | Yes | `CASGOR /CB` |  |  |
| Emilio Butragueno Futbol (1988)(Topo Soft - Ocean Software)(es) | EMILIO.CAS | Yes | `CASGOI /S` |  |  |
| Emilio Butragueno Futbol II (1989)(Erbe Software - Ocean Software)(es)(Side A) | EMILIOII.CAS | Yes | `CASGOI /S` |  |  |
| Emilio Sanchez Vicario Grand Slam (1989)(Zigurat Software)(es) | EMILIO89.CAS | Yes | `CASGOR /CB` |  |  |
| Enchanted (1989)(Positive)(es) | ENCHANTE.CAS | Yes | `CASGOR /B` |  |  |
| Engesoft MSXF-07 - Lado A | ENGESOFT.CAS | Yes | `CASGOI /B` |  |  |
| Engesoft MSXF-07 - Lado B | ENGESO07.CAS | Yes | `CASGOI /CB` |  |  |
| Engesoft MSXF-18- Lado A | ENGESO18.CAS | Yes | `CASGOI /B` |  |  |
| Engesoft MSXF-18- Lado B | ENGESOFB.CAS | Yes | `CASGOI /B` |  |  |
| Engesoft MSXF-19 - Lado A | ENGESO19.CAS | Yes | `CASGOR` |  |  |
| Engesoft MSXF-19 - Lado B | ENGES19B.CAS | Yes | `CASGOR` |  |  |
| Engesoft MSXK-06 - Lado A | ENGESO06.CAS | Yes | `CASGOI /B` |  |  |
| Engesoft MSXK-06 - Lado B | ENGES06B.CAS | Yes | `CASGOI /B12` |  |  |
| Engesoft MSXK-13 - Lado A | ENGESO13.CAS | Yes | `CASGOI /B` |  |  |
| Engesoft MSXK-13 - Lado B | ENGES13B.CAS | Yes | `CASGOI /B` |  |  |
| English Words (1986)(Aschcom) | ENGLISH.CAS | Yes | `CASGOR` |  |  |
| Enjoy Triangle v3 tape 1 side A - Sky Cleaning | ENJOY-TR.CAS | Yes | `CASGOR` |  |  |
| Eric and the Floaters (1983)(Hudson Soft) | ERIC-AND.CAS | Yes | `CASGOR` |  |  |
| Erik the Viking (1984)(Level 9 Computing) | ERIK-THE.CAS | Yes | `CASGOR /CB` |  |  |
| Erik the Viking (1984)(Level 9 Computing) | ERIKCAS.CAS | Yes | `CASGOR /CB` |  |  |
| Erik the Viking Text Ony (1984)(Level 9 Computing) | ERIKONY.CAS | Yes | `CASGOI /CB` |  |  |
| European Games (1987)(Tynesoft) | EUROPEAN.CAS | Yes | `CASGOR` |  |  |
| European Games (1987)(Tynesoft)(Side A) | EUROPCAS.CAS | Yes | `CASGOR` |  |  |
| European Games (1987)(Tynesoft)(Side A) | EUROPEAA.CAS | Yes | `CASGOR` |  |  |
| Exerion (1987)(Eaglesoft) | EXERION.CAS | Yes | `CASGOI /CB` |  |  |
| Exerion II - Zorni (1987)(Eaglesoft) | EXERIOII.CAS | Yes | `CASGOI /CB` |  |  |
| Exploding Atoms (1985)(Sanyo) | EXPLODIA.CAS | Yes | `CASGOR` |  |  |
| Exploding Atoms (1985)(Sanyo) | EXPLODIN.CAS | Yes | `CASGOR` |  |  |
| Exterminator (1987)(The Bytebusters) | EXTERMIN.CAS | Yes | `CASGOR /CB` |  |  |
| Fall Out (1984)(Policy) | FALL-OUT.CAS | Yes | `CASGOR` |  |  |
| Fanky Punky (1987)(P.J. Software)(es) | FANKY-PU.CAS | Yes | `CASGOR` |  |  |
| Fanky Punky (1987)(P.J. Software)(es) | FANKYA.CAS | Yes | `CASGOR` |  |  |
| Fantastic Footbal v1.0 (2021) | FANTASTI.CAS | Yes | `CASGOR /B` |  |  |
| Farm (2019) (N.I.) | FARM.CAS | Yes | `CASGOR` |  |  |
| Fernando Martin Basket Master (1987)(Dinamic Software)(es) | FERNANDR.CAS | Yes | `CASGOI /C` |  |  |
| Fernando Martin Basket Master - Executive (1987)(Dinamic Software) | FERNANDO.CAS | Yes | `CASGOI /B` |  |  |
| Fernando Martin Basket Master - Executive (1987)(Dinamic Software)(es) | FERNANES.CAS | Yes | `CASGOI /B` |  |  |
| Fernando Martin Basket Master - Executive (1987)(Dinamic Software)(es) | FERNARUN.CAS | Yes | `CASGOI /B` |  |  |
| Feud (1987)(Bulldog) | FEUD.CAS | Yes | `CASGOI /B` |  |  |
| Fharanx (1985)(Enix) | FHARANX.CAS | Yes | `CASGOR` |  |  |
| Field Master (1985)(Login Soft) | FIELD-MA.CAS | Yes | `CASGOR` |  |  |
| Fin Pack (1986)(Aackosoft) | FIN-PACA.CAS | Yes | `CASGOR` |  |  |
| Fin Pack (1986)(Aackosoft) | FIN-PACK.CAS | Yes | `CASGOR` |  |  |
| Final Countdown (1988)(Methodic Solutions) | FINAL-CO.CAS | Yes | `CASGOR /CB` |  |  |
| Finders Keepers (1986)(Mastertronic) | FINDERIN.CAS | Yes | `CASGOR` |  |  |
| Finders Keepers (1986)(Mastertronic) | FINDERS.CAS | Yes | `CASGOR` |  |  |
| Fireball (1983) (Hudson Soft) | FIREBALL.CAS | Yes | `CASGOI /C` |  |  |
| Firehawk (1987)(Players Software) | FIREHAWA.CAS | Yes | `CASGOR` |  |  |
| Firehawk (1987)(Players Software) | FIREHAWK.CAS | Yes | `CASGOR` |  |  |
| Fisica I - Magnitudes (1986)(Sony)(es) | FISICAI.CAS | Yes | `CASGOR` |  |  |
| Fisica II - Movimientos (1986)(Sony)(es) | FISICA.CAS | Yes | `CASGOR` |  |  |
| Five Holy Girls (1987)(Studio Blue) | FIVE-HOL.CAS | Yes | `CASGOR` |  |  |
| Flappy (1984)(dB-Soft)(CLOAD+RUN) | FLAPPYDB.CAS | Yes | `CASGOR` |  |  |
| Flappy Birds | FLAPPY.CAS | Yes | `CASGOR` |  |  |
| Flash Gordon (1987)(Mastertronic Added Dimension) | FLASH-GO.CAS | Yes | `CASGOR /CB` |  |  |
| Flight Deck II (1986)(Aackosoft) | FLIGHT.CAS | Yes | `CASGOR /CB` |  |  |
| Flight Path 737 (1985)(Anirog Software) | FLIGHT85.CAS | Yes | `CASGOR` |  |  |
| Flintstones, The (1988)(Grandslam Entertainments) | FLINTSTO.CAS | Yes | `CASGOI /S` |  |  |
| Floppy el pregunton (19xx)(Manhattan Transfer)(ES) | FLOPPY.CAS | Yes | `CASGOR` |  |  |
| Flower Card (1984)(Central Education) | FLOWER.CAS | Yes | `CASGOR` |  |  |
| Fnick Li- Fnick La (1986) LOGiN(Sony & Klon) | FNICK-LI.CAS | Yes | `CASGOR` |  |  |
| Foggys Quest (2017) (John Blythe) | FOGGYS.CAS | Yes | `CASGOR` |  |  |
| Foot Volley (1986)(Players Software) | FOOT-VOL.CAS | Yes | `CASGOR` |  |  |
| Football Manager (1987)(Addictive Games)(GB) | FOOTBALL.CAS | Yes | `CASGOR` |  |  |
| Football Manager - World Cup Edition (1990)(Addictive Games)(es) | FOOTBAES.CAS | Yes | `CASGOI` |  |  |
| Football Manager - World Cup Edition (1990)(Addictive) | FOOTBCUP.CAS | Yes | `CASGOI` |  |  |
| For MSX Special (1985)(Technopolis Soft) | FOR-MSX.CAS | Yes | `CASGOR` |  |  |
| Forbidden Fruit (1985)(Mind Games Espana) | FORBIDDE.CAS | Yes | `CASGOR` |  |  |
| Formation Z (1987)(Eaglesoft) | FORMATIO.CAS | Yes | `CASGOI /CB` |  |  |
| Formula 1 Simulator (1985)(Mastertronic) | FORMULA.CAS | Yes | `CASGOR` |  |  |
| Formula 1 Simulator (1985)(Mastertronic) | FORMULAA.CAS | Yes | `CASGOR` |  |  |
| Frankie (1988)(System 4)(ES) | FRANKIE.CAS | Yes | `CASGOR` |  |  |
| Freddy Hardest (1987)(Dinamic Software)(es)(Side A) | FREDDY87.CAS | Yes | `CASGOR /B` |  |  |
| Freddy Hardest (1987)(Dinamic Software)(es)(Side A) | FREDDYA.CAS | Yes | `CASGOR /B` |  |  |
| Freddy Hardest in South Manhattan (1989)(Dinamic Software)(es) | FREDDY89.CAS | Yes | `CASGOT /B` |  |  |
| Freddy Hardest Side A | FREDDY.CAS | Yes | `CASGOR /B` |  |  |
| French is Fun (1984)(CDS Microsystems) | FRENCRUN.CAS | Yes | `CASGOR` |  |  |
| French is Fun (1984)(CDS Software) | FRENCH.CAS | Yes | `CASGOR` |  |  |
| Frog (1985)(Advance)(es) | FROG.CAS | Yes | `CASGOR` |  |  |
| Frogger | FROGGER.CAS | Yes | `CASGOR` |  |  |
| Front Line (1984)(Taito) | FRONT-LI.CAS | Yes | `CASGOR` |  |  |
| Front Line (1984)(Taito) | FRONTA.CAS | Yes | `CASGOR` |  |  |
| Fruit Machine (1985)(DK'Tronics) | FRUIT-MA.CAS | Yes | `CASGOR` |  |  |
| Fruit Panic (1984)(Pony Canyon) | FRUIT-PA.CAS | Yes | `CASGOR` |  |  |
| Fun Math for Elementary School Year 4 Vol 2 (1984)(Stratford Computer Center Corporation) | FUN-MATH.CAS | Yes | `CASGOI` |  |  |
| Fun Math for Elementary School Year 5 Vol 2 (1984)(Stratford Computer Center Corporation) | FUN-MAT5.CAS | Yes | `CASGOR` |  |  |
| Fupper (1985)(Login Soft) | FUPPER.CAS | Yes | `CASGOR` |  |  |
| Future Knight (1986)(Erbe Software) | FUTURE.CAS | Yes | `CASGOI /S` |  |  |
| Future Knight (1986)(Gremlin Graphics Software) | FUTURER.CAS | Yes | `CASGOI /S` |  |  |
| Fuzzball (ByteBusters) (Eaglesoft - Premium III Software Distribution) | FUZZBALL.CAS | Yes | `CASGOR /CB` |  |  |
| Gagnant (1986) (Humming Bird Soft) | GAGNANT.CAS | Yes | `CASGOR` |  |  |
| Galaga (1984)(Bug-Byte Software) | GALAGA.CAS | Yes | `CASGOR /N` |  |  |
| Galaxian (1984)(Bug-Byte Software) | GALAXIAN.CAS | Yes | `CASGOR /N` |  |  |
| Game Over (1988)(Dinamic Software)(es)(Side A) | GAME-OVA.CAS | Yes | `CASGOR` |  |  |
| Game Over (1988)(Dinamic Software)(Side A) | GAME-OVE.CAS | Yes | `CASGOR` |  |  |
| Game Over II (1988)(Dinamic Software)(Side A) | GAMEII.CAS | Yes | `CASGOR` |  |  |
| Game Pack 2 (1986)(Aackosoft) | GAME-PAC.CAS | Yes | `CASGOR` |  |  |
| Games Designer (1985)(Quicksilva) | GAMES-DE.CAS | Yes | `CASGOI /S` |  |  |
| Games, The - Winter Edition (1988)(US Gold)(Side A) | GAMES-TH.CAS | Yes | `CASGOI /CB` |  |  |
| Gang Man (1988)(Armati Software) | GANG-MAN.CAS | Yes | `CASGOI /B` |  |  |
| Gangman (1984)(Hudson Soft) | GANGMAN.CAS | Yes | `CASGOR` |  |  |
| Gangman (1984)(Hudson Soft) | GANGMANA.CAS | Yes | `CASGOR` |  |  |
| Gauntlet (1986)(US Gold)(Side A) | GAUNTCAS.CAS | Yes | `CASGOT /CB` |  |  |
| Gauntlet (1986)(US Gold)(Side A) | GAUNTLET.CAS | Yes | `CASGOT /CB` |  |  |
| Gemini Wing (1989)(Virgin Mastertronic)(Side A) | GEMINI.CAS | Yes | `CASGOI /S` |  |  |
| Gemini Wing (1989)(Virgin Mastertronic)(Side A) | GEMINIA.CAS | Yes | `CASGOI /S8` |  |  |
| Genghis Khan (1991)(Positive) | GENGHIS.CAS | Yes | `CASGOT /B` |  |  |
| Geo (19xx)(Mind Games Espana)(es) | GEO.CAS | Yes | `CASGOR` |  |  |
| Geografia de Espana (1985)(Advance)(es) | GEOGRAFI.CAS | Yes | `CASGOR` |  |  |
| Gerente, El (1984)(DIMensionNEW)(es) | GERENTE.CAS | Yes | `CASGOR` |  |  |
| Gerente, El (1984)(DIMensionNEW)(es) | GERENTEA.CAS | Yes | `CASGOR` |  |  |
| GESTE-A | GESTE-A.CAS | No | `CASGOR` | X |  |
| Gestion Familiar (1986)(Load 'n' Run)(es) | GESTION.CAS | Yes | `CASGOR` |  |  |
| Ghost (1989)(Mind Games Espana)(es) | GHOST.CAS | Yes | `CASGOR /CB` |  |  |
| Ghostbusters (1985)(Activision) | GHOSTB85.CAS | Yes | `CASGOR` |  |  |
| Ghostbusters II (1989)(Activision) | GHOSTBUS.CAS | Yes | `CASGOI /S` |  |  |
| Glass (1985)(Quicksilva)(es) | GLASS.CAS | Yes | `CASGOR` |  |  |
| Gnome Ranger - Part 1 (1987)(Level 9 Computing) | GNOME-RA.CAS | Yes | `CASGOT /CB` |  |  |
| Gnome Ranger - Part 1 (1987)(Level 9 Computing) | GNOME1.CAS | Yes | `CASGOT /CB` |  |  |
| Gnome Ranger - Part 2 (1987)(Level 9 Computing) | GNOME2.CAS | Yes | `CASGOT /CB` |  |  |
| Gnome Ranger - Part 2 (1987)(Level 9 Computing) | GNOMECAS.CAS | Yes | `CASGOT /CB` |  |  |
| Gnome Ranger - Part 3 (1987)(Level 9 Computing) | GNOME3.CAS | Yes | `CASGOT /CB` |  |  |
| Gnome Ranger - Part 3 (1987)(Level 9 Computing) | GNOMERUN.CAS | Yes | `CASGOT /CB` |  |  |
| GOAL Complete (2019) (G.G.G. Software) | GOAL-COM.CAS | Yes | `CASGOR` |  |  |
| GOAL Part 1 (2019) (G.G.G. Software) | GOAL-PAR.CAS | Yes | `CASGOR` |  |  |
| Golden Basket (1990)(Opera Soft)(es) | GOLDECAS.CAS | Yes | `CASGOR /C` |  |  |
| Golden Basket (1990)(Opera Soft)(es) | GOLDENES.CAS | Yes | `CASGOR /C` |  |  |
| Golden Grave II (Stratford Computer Center, 1985)(jp) | GOLDEN.CAS | Yes | `CASGOR` |  |  |
| Gonzzalezz (1989)(Opera Soft)(es)(Side A) | GONZZALE.CAS | Yes | `CASGOR /C` |  |  |
| Goody (1987)(Opera Soft)(es) | GOODY.CAS | Yes | `CASGOR /C` |  |  |
| Goody (1987)(Opera Soft)(es) | GOODYA.CAS | Yes | `CASGOR /C` |  |  |
| Goonies | GOONIES.CAS | Yes | `CASGOR /B` |  |  |
| Graficas de Gestion (1985)(DIMensionNEW)(es) | GRAFICAS.CAS | Yes | `CASGOR` |  |  |
| Grand Prix Master (1988)(Dinamic) | GRAND-PR.CAS | Yes | `CASGOR` |  |  |
| Graphic Editor (1984)(HAL Laboratories) | GRAPHIC.CAS | Yes | `CASGOR` |  |  |
| Gravitica (2018) (Yusuke Miyauchi) | GRAVITIC.CAS | Yes | `CASGOR` |  |  |
| Green Cat Chronical (2018) (N.I.) | GREEN-CA.CAS | Yes | `CASGOR` |  |  |
| Gremlins 2 - La Nueva Generacion (1990)(Topo Soft)(es) | GREMLINS.CAS | Yes | `CASGOI /S` |  |  |
| Grid Trap (1985)(LiveWire Software) | GRID-TRA.CAS | Yes | `CASGOR` |  |  |
| Grid Trap (1985)(LiveWire Software) | GRIDCAS.CAS | Yes | `CASGOR` |  |  |
| Grog's Revenge (1985)(US Gold)(GB)-FX2 | GROG-S.CAS | Yes | `CASGOM /B` |  |  |
| Guillermo Tell (1989)(Opera Soft)(es) | GUILLERM.CAS | Yes | `CASGOR /C` |  |  |
| Gunfright (1985)(Ultimate Play The Game) | GUNFRCAS.CAS | Yes | `CASGOT /C` |  |  |
| Gunfright (1985)(Ultimate Play The Game) | GUNFRTHE.CAS | Yes | `CASGOR` |  |  |
| Gunman (1983)(Hudson Soft) | GUNMAN.CAS | Yes | `CASGOR` |  |  |
| Gunsmoke (1987)(Go!)(Side A) | GUNSMOKE.CAS | Yes | `CASGOI /S` |  |  |
| Guntus (2022)(inufuto) | GUNTUS.CAS | Yes | `CASGOR` |  |  |
| Gusano (1985)(Advance)(es) | GUSANO.CAS | Yes | `CASGOR` |  |  |
| Gusano (1985)(Advance)(es) | GUSANOES.CAS | Yes | `CASGOR` |  |  |
| Guttblaster (1988)(Eurosoft) | GUTTBLAA.CAS | Yes | `CASGOR /CB` |  |  |
| Guttblaster (1988)(Eurosoft) | GUTTBLAS.CAS | Yes | `CASGOR /CB` |  |  |
| H.E.R.O. (1984)(Activision) | H-E-R-O.CAS | Yes | `CASGOR` |  |  |
| H.E.R.O. (1984)(Disprosoft) | H-E-R-OR.CAS | Yes | `CASGOR` |  |  |
| Habilit (1988)(Iber Soft)(es) | HABILIT.CAS | Yes | `CASGOI /B` |  |  |
| Hades (1985)(Sony)(ES) | HADES.CAS | Yes | `CASGOR /B` |  |  |
| Hammer Boy (1991)(Dinamic Software)(Side A) | HAMMER.CAS | Yes | `CASGOT /S` |  |  |
| Hang-On | HANG-ON.CAS | Yes | `CASGOR` |  |  |
| Hanggliding Game (1985)(Login Soft) | HANGGLID.CAS | Yes | `CASGOR` |  |  |
| Happy Fret (1985)(Eaglesoft) | HAPPY-FR.CAS | Yes | `CASGOR` |  |  |
| Happy Fret (1985)(Micro Cabin) | HAPPYA.CAS | Yes | `CASGOR` |  |  |
| Hard Boiled (1987)(Methodic Solutions) | HARD-BOA.CAS | Yes | `CASGOR /CB` |  |  |
| Hard Boiled (1987)(Methodic Solutions) | HARD-BOI.CAS | Yes | `CASGOR /CB` |  |  |
| Harry Fox Yki no Maoh (1985)(Micro Cabin)(ja) | HARRY-FO.CAS | Yes | `CASGOR` |  |  |
| Harvey Smith's Showjumper (1985)(Software Projects) | HARVEY.CAS | Yes | `CASGOR` |  |  |
| Harvey Smith's Showjumper (1985)(Software Projects) | HARVEYS.CAS | Yes | `CASGOR` |  |  |
| Haunted House (1988)(Eurosoft) | HAUNTED.CAS | Yes | `CASGOR /CB` |  |  |
| Haunted House (1988)(Eurosoft) | HAUNTEDA.CAS | Yes | `CASGOR /CB` |  |  |
| Head Alignment Kit (1985)(Aackosoft) | HEAD-ALA.CAS | No | `CASGOI /B` | I | `CASGO /BT` |
| Head Alignment Kit (1985)(Aackosoft) | HEAD-ALI.CAS | No | `CASGOI /B` | I | `CASGO /BT` |
| Head over Heels (1987)(Erbe Software) | HEAD-OVE.CAS | Yes | `CASGOI /B` |  |  |
| Head over Heels (1987)(Ocean Software) | HEAD-OVA.CAS | Yes | `CASGOI /B` |  |  |
| Head over Heels (1987)(Ocean Software) | HEADCAS.CAS | Yes | `CASGOI /B` |  |  |
| Heist, The (1985)(Aackosoft) | HEIST-TH.CAS | Yes | `CASGOI /CB` |  |  |
| HELP (1983)(Hudson Soft) | HELP.CAS | Yes | `CASGOI /C` |  |  |
| Hercules - Slayer of the Damned (1988)(Gremlin Graphics Software) | HERCULES.CAS | Yes | `CASGOT /S` |  |  |
| Highway Encounter (1985)(Dinamic Software)(es) | HIGHWAY.CAS | Yes | `CASGOR /CB` |  |  |
| Hikohiko Ace (From Valis Club Vol. 1)(1989)(Telenet Japan)(ja) | HIKOHIKO.CAS | Yes | `CASGOR` |  |  |
| Hique - Game Pack 1 (Aackosoft - Eaglesoft) | HIQUE-GA.CAS | Yes | `CASGOR` |  |  |
| HiSoft Devpac GENS (1984)(HiSoft) | HISOFCAS.CAS | Yes | `CASGOI /CB` |  |  |
| HiSoft Devpac GENS (1984)(HiSoft) | HISOFTA.CAS | Yes | `CASGOI /CB` |  |  |
| HiSoft Devpac MONS (1984)(HiSoft) | HISOFRUN.CAS | Yes | `CASGOI /B` |  |  |
| Hopman (2023) (Inufuto) | HOPMAN.CAS | Yes | `CASGOR` |  |  |
| Hopper (1986)(Eaglesoft) | HOPPER.CAS | Yes | `CASGOR /B` |  |  |
| Hopper - MSX Compilation 5 (ByteBusters) (Aackosoft - Eaglesoft) | HOPPEMSX.CAS | Yes | `CASGOR /CB` |  |  |
| Hostages (1990)(Infogrames) | HOSTAGES.CAS | Yes | `CASGOI /S` |  |  |
| Howard the Duck (1987)(Activision) | HOWARD.CAS | Yes | `CASGOI /N` |  |  |
| Humphrey (1984)(Mr. Micro) | HUMPHR84.CAS | Yes | `CASGOR` |  |  |
| Humphrey (1984)(Mr. Micro) | HUMPHRMR.CAS | Yes | `CASGOR` |  |  |
| Humphrey (1988)(Zigurat Software)(es) | HUMPHRES.CAS | Yes | `CASGOR /CB` |  |  |
| Humphrey (1988)(Zigurat Software)(es) | HUMPHREY.CAS | Yes | `CASGOR /CB` |  |  |
| Hunchback (1984)(Ocean Software) | HUNCHBAA.CAS | Yes | `CASGOR` |  |  |
| Hunchback (1984)(Ocean Software) | HUNCHBAC.CAS | Yes | `CASGOR` |  |  |
| Hundra (1988)(Dinamic Software)(es) | HUNDRA.CAS | Yes | `CASGOI /B` |  |  |
| Hundra (1988)(Dinamic Software)(es) | HUNDRAA.CAS | Yes | `CASGOI /B` |  |  |
| Hunt for Red October, The (1988)(Grandslam Entertainments) | HUNT-FOR.CAS | Yes | `CASGOI /S` |  |  |
| Hustler (1984)(Bubblebus Software) | HUSTLER.CAS | Yes | `CASGOR` |  |  |
| Hydlide (1985)(T&E Soft) | HYDLIDE.CAS | Yes | `CASGOR` |  |  |
| Hydlide (1985)(T&E Soft) | HYDLIDEA.CAS | Yes | `CASGOR` |  |  |
| Hype (1987)(Methodic Solutions) | HYPE.CAS | Yes | `CASGOI /CB` |  |  |
| HyperSports1 | HYPERSPO.CAS | Yes | `CASGOR` |  |  |
| HyperSports2 | HYPERSP2.CAS | Yes | `CASGOR` |  |  |
| HyperSports3 | HYPERSP3.CAS | Yes | `CASGOR` |  |  |
| Hypsys (1989)(Techno Arts)(Side A) | HYPSYS.CAS | Yes | `CASGOI /S` |  |  |
| Hypsys (1989)(Techno Arts)(Side A) | HYPSYSA.CAS | Yes | `CASGOI /S` |  |  |
| Ice (1986)(Eaglesoft) | ICE.CAS | Yes | `CASGOR /CB` |  |  |
| Ice-Breaker (1990)(Topo Soft)(es) | ICE-BREA.CAS | Yes | `CASGOI /S` |  |  |
| IdeaType - Instructor Mecanografico (1985)(Idealogic)(es)(Side A) | IDEATYPE.CAS | Yes | `CASGOR` |  |  |
| Igloo (1985)(Garbi Soft)(es) | IGLOO.CAS | Yes | `CASGOR` |  |  |
| Illusions (1985)(Nice Ideas)(fr) | ILLUSION.CAS | Yes | `CASGOR` |  |  |
| Impetus (2021)(Inufuto) | IMPETUS.CAS | Yes | `CASGOR` |  |  |
| Impetus+ (2025)(Inufuto) | IMPETUS5.CAS | Yes | `CASGOR` |  |  |
| Inca (1987)(Eaglesoft) | INCA.CAS | Yes | `CASGOR /CB` |  |  |
| Inca (1987)(Eaglesoft) | INCAA.CAS | Yes | `CASGOR /CB` |  |  |
| Indiana Jones and the Last Crusade (1989)(Erbe Software)(es)(Side A) | INDIAN89.CAS | Yes | `CASGOI /S` |  |  |
| Indiana Jones and the Last Crusade (1989)(Erbe Software)(es)(Side A) | INDIANAA.CAS | Yes | `CASGOI /S` |  |  |
| Indiana Jones and the Temple of Doom (1987)(US Gold) | INDIANA.CAS | Yes | `CASGOR` |  |  |
| Ingrid's Back  Part 1 (1988)(Level 9 Computing) | INGRID.CAS | Yes | `CASGOT /CB` |  |  |
| Ingrid's Back  Part 1 (1988)(Level 9 Computing) | INGRID1.CAS | Yes | `CASGOT /CB` |  |  |
| Ingrid's Back  Part 1 (1988)(Level 9 Computing) | INGRIDR.CAS | Yes | `CASGOT /CB` |  |  |
| Ingrid's Back  Part 2 (1988)(Level 9 Computing) | INGRID2.CAS | Yes | `CASGOT /CB` |  |  |
| Ingrid's Back  Part 2 (1988)(Level 9 Computing) | INGRIDS.CAS | Yes | `CASGOT /CB` |  |  |
| Ingrid's Back  Part 3 (1988)(Level 9 Computing) | INGRICAS.CAS | Yes | `CASGOT /CB` |  |  |
| Ingrid's Back  Part 3 (1988)(Level 9 Computing) | INGRID3.CAS | Yes | `CASGOT /CB` |  |  |
| Ink (2005)(INK TEAM) | INK.CAS | Yes | `CASGOR` |  |  |
| International Karate (1986)(Endurance Games) | INTERNA2.CAS | Yes | `CASGOR /B` |  |  |
| International Karate (1986)(Endurance Games) | INTERNAA.CAS | Yes | `CASGOI /B` |  |  |
| International Karate (1986)(Endurance Games) | INTERNAT.CAS | Yes | `CASGOR /B` |  |  |
| Invaders (1986)(LiveWire Software) | INVADERS.CAS | Yes | `CASGOR` |  |  |
| Invierte y Gana (1986)(DIMensionNEW)(es) | INVIERTE.CAS | Yes | `CASGOI /B` |  |  |
| Iron of the War (19xx)(Mind Games Espana)(es) | IRON-OF.CAS | Yes | `CASGOR` |  |  |
| Isitar 7 (2019) (N.I.) | ISITAR-7.CAS | Yes | `CASGOR` |  |  |
| Italia '90 - World Cup Soccer (1989)(Dro Soft)(es) | ITALIA.CAS | Yes | `CASGOI /S` |  |  |
| Jabato (1989)(Aventuras AD)(es)(Side A) | JABATO.CAS | Yes | `CASGOT /CB` |  |  |
| Jack the Nipper (1986)(Gremlin Graphics Software) | JACK-THE.CAS | Yes | `CASGOI /S` |  |  |
| Jack the Nipper (1986)(Gremlin Graphics Software) | JACK86.CAS | Yes | `CASGOI /S` |  |  |
| Jack the Nipper II - In Coconut Capers (1987)(Gremlin Graphics Software) | JACKII.CAS | Yes | `CASGOI /S` |  |  |
| Jai Alai (Opera Soft, 1991) | JAI-ALAI.CAS | Yes | `CASGOR /CB` |  |  |
| Jaws (1989)(Screen 7) | JAWS.CAS | Yes | `CASGOI /S` |  |  |
| Jet Bomber (1985)(Aackosoft) | JET-BOMA.CAS | Yes | `CASGOR /CB` |  |  |
| Jet Bomber (1985)(Aackosoft) | JET-BOMB.CAS | Yes | `CASGOR /CB` |  |  |
| Jet Fighter (1985)(Aackosoft)(NL)(en) | JET-FIEN.CAS | Yes | `CASGOR /CB` |  |  |
| Jet Fighter (1988)(Eurosoft) | JET-FIGH.CAS | Yes | `CASGOR /CB` |  |  |
| Jet Fighter - Compilation Tape 1 (ByteBusters) (Aackosoft - Eaglesoft) | JET-FIG1.CAS | Yes | `CASGOR /CB` |  |  |
| Jet Set Willy II - The Final Frontier (1985)(Software Projects) | JET-SEII.CAS | Yes | `CASGOR` |  |  |
| Jet Set Willy II - The Final Frontier (1985)(Software Projects) | JET-SET.CAS | Yes | `CASGOR` |  |  |
| Jewels of Darkness I - Colossal Adventure v2 (1986)(Level 9 Computing) | JEWELCAS.CAS | Yes | `CASGOT /CB` |  |  |
| Jewels of Darkness I - Colossal Adventure v2 (1986)(Level 9 Computing) | JEWELS86.CAS | Yes | `CASGOT /CB` |  |  |
| Jewels of Darkness I - Colossal Adventure v2 (1986)(Level 9 Computing) | JEWELS9.CAS | Yes | `CASGOT /CB` |  |  |
| Jewels of Darkness I - Colossal Adventure v2 (1986)(Level 9 Computing) | JEWELSI.CAS | Yes | `CASGOT /CB` |  |  |
| Jewels of Darkness II - Adventure Quest v2 (1986)(Level 9 Computing) | JEWELRUN.CAS | Yes | `CASGOT /CB` |  |  |
| Jewels of Darkness II - Adventure Quest v2 (1986)(Level 9 Computing) | JEWELS2.CAS | Yes | `CASGOT /CB` |  |  |
| Jewels of Darkness II - Adventure Quest v2 (1986)(Level 9 Computing) | JEWELSII.CAS | Yes | `CASGOT /CB` |  |  |
| Jewels of Darkness II - Adventure Quest v2 (1986)(Level 9 Computing) | JEWELSOF.CAS | Yes | `CASGOT /CB` |  |  |
| Jewels of Darkness III - Dungeon Adventure v2 (1986)(Level 9 Computing) | JEWELIII.CAS | Yes | `CASGOT /CB` |  |  |
| Jewels of Darkness III - Dungeon Adventure v2 (1986)(Level 9 Computing) | JEWELS.CAS | Yes | `CASGOT /CB` |  |  |
| Jewels of Darkness III - Dungeon Adventure v2 (1986)(Level 9 Computing) | JEWELSA.CAS | Yes | `CASGOT /CB` |  |  |
| Jewels of Darkness III - Dungeon Adventure v2 (1986)(Level 9 Computing) | JEWELSV.CAS | Yes | `CASGOT /CB` |  |  |
| Joe Blade (1989)(Players Software) | JOE-BLAD.CAS | Yes | `CASGOI` |  |  |
| Johny Comomolo in 3-2-1 Fire (1986)(Dro Soft) | JOHNY-CO.CAS | Yes | `CASGOR` |  |  |
| Journey to the Centre of the Earth (1985)(Bug-Byte Software)(Side A) | JOURNEY.CAS | Yes | `CASGOR` |  |  |
| Jump Jet (1985)(Anirog)(GB) | JUMPGB.CAS | Yes | `CASGOR` |  |  |
| Jumping Jack (1986)(Livewire) | JUMPING.CAS | Yes | `CASGOR` |  |  |
| Jungle Warrior (1990)(Zigurat Software)(es) | JUNGLE.CAS | Yes | `CASGOR /B` |  |  |
| Juno Lander (1983)(SIL) | JUNO-LAN.CAS | Yes | `CASGOR` |  |  |
| Kaereltje Leert Wiskunde ~ Charlie's Maths Class - Compilation Tape 1 (ByteBusters) (Aackosoft - Eaglesoft) | KAERELTJ.CAS | Yes | `CASGOR` |  |  |
| Kamikaze (1984)(Omega Systems)(jp) | KAMIKAZE.CAS | Yes | `CASGOR` |  |  |
| Katori Sensō (Mosquito Wars)(UCHUDO)(1984) | KATORI.CAS | Yes | `CASGOR` |  |  |
| Ke Rulen los Petas (1989)(Iber Soft)(es) | KE-RULEN.CAS | Yes | `CASGOI /S` |  |  |
| Keystone Kapers (1984)(Activision) | KEYSTONE.CAS | Yes | `CASGOR` |  |  |
| Keystone Kapers(1984)(Activision) | KEYSTONA.CAS | Yes | `CASGOR` |  |  |
| Khazzad-Dum (1989)(SPE)(es) | KHAZZAD.CAS | Yes | `CASGOR /B` |  |  |
| Kick It - MSX Compilation 5 (ByteBusters) (Aackosoft - Eaglesoft) | KICK-IT.CAS | Yes | `CASGOR /CB` |  |  |
| Killer Station (1983) (Hudson Soft) | KILLER.CAS | Yes | `CASGOR` |  |  |
| King Leonard (1986)(Mind Games Espana)(es) | KING-LEO.CAS | Yes | `CASGOR` |  |  |
| KingsVally | KINGSVAL.CAS | Yes | `CASGOR` |  |  |
| Klax (1990)(Domark) | KLAX.CAS | Yes | `CASGOI /S` |  |  |
| Knight Ghost (1987)(Dro Soft)(es) | KNIGHT.CAS | Yes | `CASGOR` |  |  |
| Knight Lore (1985)(Ultimate Play The Game) | KNIGHT85.CAS | Yes | `CASGOR` |  |  |
| Knight Lore (Ultimate Play The Game) | KNIGHTHE.CAS | Yes | `CASGOR` |  |  |
| Knight Lore Remake (2009) | KNIGHTR.CAS | Yes | `CASGOR` |  |  |
| Knight Orc - Part 1 - Loosed Orc (1987)(Level 9 Computing) | KNIGHT9.CAS | Yes | `CASGOT /CB` |  |  |
| Knight Orc - Part 1 - Loosed Orc (1987)(Level 9 Computing) | KNIGHTA.CAS | Yes | `CASGOT /CB` |  |  |
| Knight Orc - Part 1 - Loosed Orc (1987)(Rainbird Software) | KNIGHORC.CAS | Yes | `CASGOT /CB` |  |  |
| Knight Orc - Part 1 - Loosed Orc (1987)(Rainbird Software) | KNIGHT1.CAS | Yes | `CASGOT /CB` |  |  |
| Knight Orc - Part 1 - Loosed Orc (1987)(Rainbird Software) | KNIGHT2.CAS | Yes | `CASGOT /CB` |  |  |
| Knight Orc - Part 2 - A Kind of Magic (1987)(Level 9 Computing) | KNIGHCAS.CAS | Yes | `CASGOT /CB` |  |  |
| Knight Orc - Part 2 - A Kind of Magic (1987)(Level 9 Computing) | KNIGHT12.CAS | Yes | `CASGOT /CB` |  |  |
| Knight Orc - Part 2 - A Kind of Magic (1987)(Rainbird Software) | KNIGHRUN.CAS | Yes | `CASGOT /CB` |  |  |
| Knight Orc - Part 2 - A Kind of Magic (1987)(Rainbird Software) | KNIGHTOF.CAS | Yes | `CASGOT /CB` |  |  |
| Knight Orc - Part 3 - Hordes of the Mountain King (1987)(Level 9 Computing) | KNIGHT13.CAS | Yes | `CASGOT /CB` |  |  |
| Knight Orc - Part 3 - Hordes of the Mountain King (1987)(Level 9 Computing) | KNIGHT19.CAS | Yes | `CASGOT /CB` |  |  |
| Knight Orc - Part 3 - Hordes of the Mountain King (1987)(Rainbird Software) | KNIGHT3.CAS | Yes | `CASGOT /CB` |  |  |
| Knight Orc - Part 3 - Hordes of the Mountain King (1987)(Rainbird Software) | KNIGHT87.CAS | Yes | `CASGOT /CB` |  |  |
| Knight Tyme (1986)(Mastertronic Added Dimension) | KNIGHT86.CAS | Yes | `CASGOR` |  |  |
| Knightmare | KNIGHTMA.CAS | Yes | `CASGOR` |  |  |
| Knockout (1985)(Alligata Software) | KNOCKOUT.CAS | Yes | `CASGOR` |  |  |
| Konami's Soccer (1985)(Konami) | KONAMI.CAS | Yes | `CASGOI /B` |  |  |
| Kong (1988)(Eurosoft) | KONG.CAS | Yes | `CASGOR /CB` |  |  |
| Kong (Eurosoft) (VA Holding) (Side A) | KONGVA.CAS | Yes | `CASGOR /CB` |  |  |
| Kong's Revenge (1991)(Zigurat Software)(es)(Side A) | KONG-S.CAS | Yes | `CASGOM /CB` |  |  |
| Krakout (1987)(Gremlin Graphics Software) | KRAKOUT.CAS | Yes | `CASGOI /S` |  |  |
| Krakout (1987)(Gremlin Graphics Software) | KRAKOUTA.CAS | Yes | `CASGOI /S` |  |  |
| Krom - El Guerrero Invencible (1989)(OMK Software)(es) | KROM-EL.CAS | Yes | `CASGOR` |  |  |
| Kubus (1985)(Kuma Computers) | KUBUS.CAS | Yes | `CASGOR` |  |  |
| Kuma Forth (1984)(Kuma Computers) | KUMA-FOA.CAS | Yes | `CASGOR` |  |  |
| Kuma Forth (1984)(Kuma Computers) | KUMA-FOR.CAS | Yes | `CASGOR` |  |  |
| Kuma Logo (1984)(Kuma Computers) | KUMA-LOA.CAS | Yes | `CASGOR` |  |  |
| Kuma Logo (1984)(Kuma Computers) | KUMA-LOG.CAS | Yes | `CASGOR` |  |  |
| Laberinto (1985)(Advance)(es) | LABERINT.CAS | Yes | `CASGOR` |  |  |
| Laberinto Binario - Binary Land (Sony Spain) (Indescomp) | LABERCAS.CAS | Yes | `CASGOR` |  |  |
| Lady Safary (1988)(OMK Software)(es) | LADY-SAF.CAS | Yes | `CASGOR /P3` |  |  |
| Lancelot - Part 1 (1988)(Level 9 Computing)(RUN'CAS-',R] | LANCELOT.CAS | Yes | `CASGOT /CB` |  |  |
| Lancelot - Part 2 (1988)(Level 9 Computing)(RUN'CAS-',R] | LANCELO2.CAS | Yes | `CASGOT /CB` |  |  |
| Lancelot - Part 3 (1988)(Level 9 Computing)(RUN'CAS-',R] | LANCELO3.CAS | Yes | `CASGOT /CB` |  |  |
| Last Dungeon, The (19xx)(Grupo de Trabajo Software) | LAST-DUN.CAS | Yes | `CASGOR` |  |  |
| Last Mission, The (1987)(Opera Soft)(es) | LAST-MIS.CAS | Yes | `CASGOR` |  |  |
| Lazer Bykes (1985)(PSS) | LAZER-BY.CAS | Yes | `CASGOR` |  |  |
| Lazer Bykes (1985)(PSS) | LAZER2.CAS | Yes | `CASGOR` |  |  |
| Lazer Bykes (1985)(PSS) | LAZERA.CAS | Yes | `CASGOR` |  |  |
| Lazy Jones (1985)(Terminal Software) | LAZY-JO2.CAS | Yes | `CASGOR /B` |  |  |
| Lazy Jones (1985)(Terminal Software) | LAZY-JOA.CAS | Yes | `CASGOR /B` |  |  |
| Lazy Jones (1985)(Terminal Software) | LAZY-JON.CAS | Yes | `CASGOR /B` |  |  |
| Le Mans (1984)(Electric Software) | LE-MANS.CAS | Yes | `CASGOR` |  |  |
| Le Mans (1984)(Electric Software) | LE-MANSA.CAS | Yes | `CASGOR` |  |  |
| Legend of White and Black - Ringo Tensei Hen - Tape 1 Side A (1986)(Soft Studio WING) | LEGEND.CAS | Yes | `CASGOR` |  |  |
| Legends of Star Arthur - Planet Mephius (1985)(T&E Soft)(ja)(Side A) | LEGENDS.CAS | Yes | `CASGOR` |  |  |
| Let's Computer (1984)(Melsoft & Three Quarter) | LET-S-CO.CAS | Yes | `CASGOR` |  |  |
| Leyendas (19xx)(Mind Games Espana)(es) | LEYENDAS.CAS | Yes | `CASGOR` |  |  |
| Life in the Fast Lane (1987)(Methodic Solutions) | LIFE-IN.CAS | Yes | `CASGOR /CB` |  |  |
| Lift (2021)(Inufuto) | LIFT.CAS | Yes | `CASGOR` |  |  |
| Light Corridor, The (1990)(Infogrames) | LIGHT-CO.CAS | Yes | `CASGOI /S` |  |  |
| Like The Monkey King (1984)(Ample Software) | LIKE-THE.CAS | Yes | `CASGOR` |  |  |
| Linez (2018) | LINEZ.CAS | Yes | `CASGOR` |  |  |
| Linez (2018) | LINEZR.CAS | Yes | `CASGOR` |  |  |
| Livingstone Supongo (1986)(Opera Soft)(es) | LIVING86.CAS | Yes | `CASGOI /C` |  |  |
| Livingstone Supongo (1986)(Opera Soft)(es) | LIVINGST.CAS | Yes | `CASGOI /CB` |  |  |
| Livingstone Supongo II (1989)(Opera Soft)(Side A) | LIVINGII.CAS | Yes | `CASGOR /C` |  |  |
| Lizard (1985)(Micro Cabin)(ja) | LIZARDJA.CAS | Yes | `CASGOR` |  |  |
| Lizard Willy | LIZARD.CAS | Yes | `CASGOR` |  |  |
| Lizard Willy__Lizard Willy | LIZARCAS.CAS | Yes | `CASGOR` |  |  |
| Locke the Superman - Asteroid Kahn  (1984)(Pony Canyon) | LOCKE-TH.CAS | Yes | `CASGOR` |  |  |
| Lords Of Time (1983)(Level 9 Computing) | LORDS-OF.CAS | Yes | `CASGOR` |  |  |
| Lorna (1990)(Topo Soft)(es) | LORNA.CAS | Yes | `CASGOI /S` |  |  |
| Los Elfos de Maroland (2023)(Dwalin)(es)(Side A) | LOS-ELFO.CAS | Yes | `CASGOI /S` |  |  |
| Loto (19xx)(Manhattan Transfer)(es) | LOTO.CAS | Yes | `CASGOR` |  |  |
| Loto (19xx)(Manhattan Transfer)(es) | LOTOA.CAS | Yes | `CASGOR` |  |  |
| Lucky Luke (1985)(Javier Laguna García)(es) | LUCKY-LU.CAS | Yes | `CASGOR` |  |  |
| Lunar Ball | LUNAR-BA.CAS | Yes | `CASGOR` |  |  |
| M-Droid (19xx)(Blue Ribbon Software) | M-DROID.CAS | Yes | `CASGOR /P5` |  |  |
| M-Droid (19xx)(Blue Ribbon Software) | M-DROIDA.CAS | Yes | `CASGOR /P6` |  |  |
| Mac Attack (1986)(Eaglesoft) | MAC-ATTA.CAS | Yes | `CASGOR /CB` |  |  |
| Macadam Bumper (1985)(Players Software) | MACADAM.CAS | No | `CASGOI /S` | X |  |
| Macadam Bumper (1985)(Players Software) | MACADAM2.CAS | No | `CASGOI /S` | X |  |
| Macadam Bumper (1985)(Players Software) | MACADAMA.CAS | No | `CASGOI /S` | X |  |
| Mad Mix 2 - En el Castillo de los Fantasmas (1990)(Topo Soft)(es) | MAD-MIDE.CAS | Yes | `CASGOI /S` |  |  |
| Mad Mix Game (1988)(Topo Soft)(es) | MAD-MIX.CAS | Yes | `CASGOI /S` |  |  |
| Made in Spain - 5 Estrellas (1985)(Zigurat Software)(es) | MADE-IN.CAS | Yes | `CASGOR /CB` |  |  |
| Magic Johnson's Basketball (1990)(Dro Soft)(es) | MAGIC-JO.CAS | Yes | `CASGOI /S` |  |  |
| Magic Pinball (1987)(OMK Software)(es) | MAGIC-PI.CAS | Yes | `CASGOR` |  |  |
| Magic Tower Adventure (2017) | MAGIC-TO.CAS | Yes | `CASGOR` |  |  |
| Magical Computer Music L5 Demo (1985)(CBS & Sony) | MAGICAL.CAS | Yes | `CASGOR` |  |  |
| Mandragore (Infogrames)(1987)(en)(Tape 1 Side A) | MANDRAGO.CAS | Yes | `CASGOM /C` |  |  |
| Manes (1984)(Ascii) | MANES.CAS | Yes | `CASGOR` |  |  |
| Manic Miner (1984)(Software Projects) | MANIC-MI.CAS | Yes | `CASGOR` |  |  |
| Manic Miner (1984)(Software Projects) | MANICA.CAS | Yes | `CASGOR` |  |  |
| Map Game (1985)(Erbe Software)(es) | MAP-GAME.CAS | Yes | `CASGOR` |  |  |
| Mappy (1984)(Bug-Byte Software) | MAPPY.CAS | Yes | `CASGOR /N` |  |  |
| Martianoids (1987)(Ultimate Play The Game) | MARTIANO.CAS | Yes | `CASGOT /C` |  |  |
| Mask II (1987)(Gremlin Graphics Software) | MASK-II.CAS | Yes | `CASGOI /S` |  |  |
| Mask III - Venom Strikes Back (1988)(Gremlin Graphics Software) | MASK-III.CAS | Yes | `CASGOI /S` |  |  |
| Master Chess (1987)(Mastertronic) | MASTER.CAS | Yes | `CASGOR` |  |  |
| Master Chess (1987)(Mastertronic) | MASTER87.CAS | Yes | `CASGOR` |  |  |
| Master of the Lamps (1985)(Activision) | MASTETHE.CAS | Yes | `CASGOR` |  |  |
| Master Voice (1985)(Aackosoft) | MASTER85.CAS | Yes | `CASGOR /CB` |  |  |
| Mastermind - Game Pack 1 (Aackosoft - Eaglesoft) | MASTERMI.CAS | Yes | `CASGOR` |  |  |
| Matamarcianos. Batalla Espacial (1986)(Manhattan Transfer)(es) | MATAMARC.CAS | Yes | `CASGOR` |  |  |
| Match Day II (1987)(Ocean Software) | MATCH-DA.CAS | Yes | `CASGOI /B` |  |  |
| Maths Invaders (1985)(Aackosoft) | MATHS-IN.CAS | Yes | `CASGOR` |  |  |
| Maths Invaders (1985)(Aackosoft) | MATHS85.CAS | Yes | `CASGOR` |  |  |
| Maxima (1984)(PSS) | MAXIMA.CAS | Yes | `CASGOR` |  |  |
| Maxima (1984)(PSS) | MAXIMAA.CAS | Yes | `CASGOR` |  |  |
| Mayhem (1985)(Mr. Micro) | MAYHEM.CAS | Yes | `CASGOR /C` |  |  |
| Maze Master (1988)(Eurosoft) | MAZE-MAS.CAS | Yes | `CASGOR /CB` |  |  |
| Maze Max (1985)(Loriciels)(fr) | MAZE-MAX.CAS | Yes | `CASGOR` |  |  |
| Mazes Unlimited (1986)(Eaglesoft) | MAZES-UN.CAS | Yes | `CASGOR /CB` |  |  |
| Maziacs (1985)(DK'Tronics) | MAZIACS.CAS | Yes | `CASGOR` |  |  |
| Mazogs (2017) | MAZOGS.CAS | Yes | `CASGOR` |  |  |
| Mazy (2021)(Inufuto) | MAZY.CAS | Yes | `CASGOR` |  |  |
| Mazy 2 (2025)(inufuto) | MAZY-2.CAS | Yes | `CASGOR` |  |  |
| Mean Streets (19xx)(Kuma Computers) | MEAN-STR.CAS | Yes | `CASGOR` |  |  |
| Mecom (1988)(Iber Soft)(es) | MECOM.CAS | Yes | `CASGOR` |  |  |
| Mega Chess (1988)(Iber Soft)(es) | MEGA-CHE.CAS | Yes | `CASGOR` |  |  |
| Meganova (1988)(Dinamic Software)(es) | MEGANOVA.CAS | Yes | `CASGOI /B` |  |  |
| Meganova (1988)(Dinamic Software)(es)(Side A) | MEGANOES.CAS | Yes | `CASGOI /B` |  |  |
| Megaphoenix (1991)(Dinamic Software) | MEGAPHOE.CAS | Yes | `CASGOT /B` |  |  |
| Mejor Software - Issue 01 - Guss en la Atlantida (19xx)(Creativos Editoriales)(ES) | MEJOR-SO.CAS | Yes | `CASGOR` |  |  |
| Mejor Software - Issue 01 - Guss en la Atlantida (19xx)(Creativos Editoriales)(ES) | MEJORA.CAS | Yes | `CASGOR` |  |  |
| Memory - C.04 (1985)(Computer Users Club)(nl) | MEMORY.CAS | Yes | `CASGOR` |  |  |
| Merlin (1987)(Mind Games Espana)(es) | MERLIN.CAS | Yes | `CASGOR` |  |  |
| Metropolis (1989)(Topo Soft)(es) | METROPOL.CAS | Yes | `CASGOI /S` |  |  |
| Michel Futbol Master (1989)(Dinamic Software)(es)(Side A) | MICHELA.CAS | Yes | `CASGOR` |  |  |
| Michel Futbol Master (1989)(Dinamic Software)(Side A) | MICHEL.CAS | Yes | `CASGOT /B` |  |  |
| Micky-Lucky (Unknown, 198x) | MICKY-LU.CAS | Yes | `CASGOR` |  |  |
| Midnight Commander (1983)(Microcabin)(JP) | MIDNIGHT.CAS | Yes | `CASGOR` |  |  |
| Milk Race (1987)(Mastertronic) | MILK-RAA.CAS | Yes | `CASGOR /CB` |  |  |
| Milk Race (1987)(Mastertronic) | MILK-RAC.CAS | Yes | `CASGOR /CB` |  |  |
| Minder (1985) (dK'Tronics) | MINDER.CAS | Yes | `CASGOR /B` |  |  |
| Miner Machine (1987)(Eaglesoft) | MINER-MA.CAS | Yes | `CASGOR` |  |  |
| Miner Machine (1987)(Eaglesoft) | MINERA.CAS | Yes | `CASGOR` |  |  |
| Mini-Golf (1984)(Advance)(es) | MINI-GOL.CAS | Yes | `CASGOR` |  |  |
| Mision en Espana (19xx)(Mind Games Espana)(es) | MISIONEN.CAS | Yes | `CASGOR` |  |  |
| Mision Rescate (1986)(Anaya Multimedia)(es) | MISION.CAS | Yes | `CASGOR` |  |  |
| Missing In The Okhotsk - Scene 1 (1985)(Login Soft)(Tape 1 - Side A)(ja) | MISSING.CAS | Yes | `CASGOI` |  |  |
| Misterio del Nilo, El (1987)(Zigurat Software)(es) | MISTERIA.CAS | Yes | `CASGOR` |  |  |
| Misterio del Nilo, El (1987)(Zigurat Software)(es) | MISTERIO.CAS | Yes | `CASGOR` |  |  |
| Miyuki Memorial Doors (1984)(Kitty Records) | MIYUKI.CAS | Yes | `CASGOR` |  |  |
| Miyuki Memorial Doors (1984)(Kitty Records)__Miyuki Memorial Full Archive (.CAS, LP & Listing) | MIYUKILP.CAS | Yes | `CASGOR` |  |  |
| Miyuki Memorial Graphics & Doors (1984)(Kitty Records) | MIYUKI84.CAS | Yes | `CASGOR` |  |  |
| Miyuki Memorial Graphics & Doors (1984)(Kitty Records)__Miyuki Memorial Graphics & Doors (1984)(Kitty Records) | MIYUKUKI.CAS | Yes | `CASGOR` |  |  |
| Miyuki Memorial Graphics (1984)(Kitty Records) | MIYUKRUN.CAS | Yes | `CASGOR` |  |  |
| Miyuki Memorial Graphics (1984)(Kitty Records)__Miyuki Memorial Graphics (1984)(Kitty Records) | MIYUKMIY.CAS | Yes | `CASGOR` |  |  |
| Miyuki The Gambler (1984)(Central Education)(ja){Side A) | MIYUKIJA.CAS | Yes | `CASGOR` |  |  |
| Mocky (1985)(Login Soft) | MOCKY.CAS | Yes | `CASGOR` |  |  |
| Molecule Man (1986)(Mastertronic) | MOLECULA.CAS | Yes | `CASGOR` |  |  |
| Molecule Man (1986)(Mastertronic) | MOLECULE.CAS | Yes | `CASGOR` |  |  |
| Monopoly (1986)(Leisure Genius) | MONOPOLY.CAS | Yes | `CASGOI /CB` |  |  |
| Moon Rider (1986)(Eaglesoft) | MOON-RID.CAS | Yes | `CASGOR /CB` |  |  |
| Moonwalker (1989)(US Gold) | MOONWALA.CAS | Yes | `CASGOI /S` |  |  |
| Moonwalker (1989)(US Gold) | MOONWALK.CAS | Yes | `CASGOI /S` |  |  |
| Mortadelo y Filemon (1988)(Dro Soft)(es) | MORTADEL.CAS | Yes | `CASGOI /S2` |  |  |
| Mortadelo y Filemon II - Safari Callejero (1990)(Dro Soft)(es)(Side A) | MORTADII.CAS | Yes | `CASGOI /S` |  |  |
| Most Amazing Memory Game, The (1986)(Idealogic)(es) | MOST-AMA.CAS | Yes | `CASGOR` |  |  |
| Mot (1989)(Opera Soft)(es)(Side A) | MOT.CAS | Yes | `CASGOR /C` |  |  |
| Motkonqe (2017) (N.I.) | MOTKONQE.CAS | Yes | `CASGOR` |  |  |
| Motorista Sideral, El (1986)(Anaya Multimedia)(es) | MOTORIST.CAS | Yes | `CASGOR` |  |  |
| Mountain Bike Racer (1990)(Positive) | MOUNTAIN.CAS | Yes | `CASGOT /B` |  |  |
| Mr. Jaws (1987)(The Bytebusters) | MR-JAWS.CAS | Yes | `CASGOR /CB` |  |  |
| Mr. Wong's Loopy Laundry (1984)(Artic Computing) | MR-WONG.CAS | Yes | `CASGOR` |  |  |
| Mr. Wong's Loopy Laundry (1984)(Artic Computing) | MR-WONGA.CAS | Yes | `CASGOI /B` |  |  |
| MST-Calc (1985)(MST Consultants) | MST-CALC.CAS | Yes | `CASGOR` |  |  |
| MSX Screendump (1986)(Philips)(nl) | MSX-SCRA.CAS | Yes | `CASGOR` |  |  |
| MSX Screendump (1986)(Philips)(nl) | MSX-SCRE.CAS | Yes | `CASGOR` |  |  |
| MSX Tank | MSX-TANK.CAS | Yes | `CASGOR` |  |  |
| MSX Tank alkuperN╠âisen taso 2 korjattu | MSX-TAN2.CAS | Yes | `CASGOR` |  |  |
| MSXtra - 3D Knockout (1986) | MSXTRA3.CAS | Yes | `CASGOR` |  |  |
| MSXtra - Blagger (1986) | MSXTRA.CAS | Yes | `CASGOR` |  |  |
| MSXtra - Disc Warrior (1986) | MSXTRRUN.CAS | Yes | `CASGOR` |  |  |
| MSXtra - Superbowl (1986) | MSXTRCAS.CAS | Yes | `CASGOR` |  |  |
| Mundial de Futbol (1990)(Opera Soft)(es)(Side A) | MUNDIAL.CAS | Yes | `CASGOR /C` |  |  |
| Mundo Perdido, El (1988)(Topo Soft)(es) | MUNDO-PE.CAS | Yes | `CASGOR /S` |  |  |
| Mutan Zone (1989)(Opera Soft)(es)(Side A) | MUTAN-ZO.CAS | Yes | `CASGOR /C` |  |  |
| Mutan Zone (1989)(Opera Soft)(es)(Side A) | MUTANA.CAS | Yes | `CASGOR /C` |  |  |
| Mutant Monty (1985)(Artic Computing) | MUTANT.CAS | Yes | `CASGOR` |  |  |
| Mystery House (1983)(Micro Cabin)(ja) | MYSTERY.CAS | Yes | `CASGOR` |  |  |
| Mystery House II (1984)(Micro Cabin)(en) | MYSTEREN.CAS | Yes | `CASGOR` |  |  |
| Mystery House II (1984)(Micro Cabin)(ja) | MYSTERII.CAS | Yes | `CASGOR` |  |  |
| Mystery Of The Mu Continent (1984)(Stratford Computer Center Corporation)(ja) | MYSTERMU.CAS | Yes | `CASGOR` |  |  |
| Mystical (1991)(Infogrames)(Side A) | MYSTICAL.CAS | Yes | `CASGOI /S` |  |  |
| Mythos (1990)(Opera Soft) | MYTHOS.CAS | Yes | `CASGOR /C` |  |  |
| Mythos (1990)(Opera Soft) | MYTHOSA.CAS | Yes | `CASGOR /C` |  |  |
| Naitou Kunio no Tsume Shougi (1984)(Apollo Technica)(Side A)(JP) | NAITOU.CAS | Yes | `CASGOR` |  |  |
| NAMPA-A | NAMPA-A.CAS | Yes | `CASGOR` |  |  |
| Narco Police (1990)(Dinamic Software)(Side A) | NARCO-PO.CAS | Yes | `CASGOI /S` |  |  |
| Narco Police (1990)(Dinamic Software)(Side A) | NARCOA.CAS | Yes | `CASGOI /B15` |  |  |
| Navy Moves (1988)(Dinamic Software)(es)(Side A) | NAVY-MOA.CAS | Yes | `CASGOI /B` |  |  |
| Navy Moves (1988)(Dinamic Software)(es)(Side A) | NAVYES.CAS | Yes | `CASGOI /B` |  |  |
| Navy Moves (1988)(Dinamic Software)(Side A) | NAVY-MOV.CAS | Yes | `CASGOI /B` |  |  |
| Neuras (2021)(Inufuto) | NEURAS.CAS | Yes | `CASGOR` |  |  |
| Nick Neaker (1983)(Colpax) | NICK-NEA.CAS | Yes | `CASGOR` |  |  |
| Night Flight (1982)(Nippon Columbia - Colpax - Universal) | NIGHT-FL.CAS | Yes | `CASGOR` |  |  |
| Nightlife (1985)(Koei)(ja) | NIGHTLIF.CAS | Yes | `CASGOR` |  |  |
| Nightshade (1985)(Ultimate Play The Game) | NIGHTSHA.CAS | Yes | `CASGOR` |  |  |
| Nikonikopun What Is It (1984)(NHK Gakuen)(ja) | NIKONIKO.CAS | Yes | `CASGOR` |  |  |
| Ninja 2. Ninja Jaja Maru Kun (1987)(Eaglesoft) | NINJA-2.CAS | Yes | `CASGOI /CB` |  |  |
| Ninja-kun - Magic Castle Adventure (1985)(Jaleco) | NINJA-KU.CAS | Yes | `CASGOI /CB` |  |  |
| Ninjya Kage (1984)(Hudson Soft) | NINJYA.CAS | Yes | `CASGOR` |  |  |
| Nohzdyve (2019) (Giovanni Nunes Matt Wescott) | NOHZDYVE.CAS | Yes | `CASGOR` |  |  |
| Nonamed (1986)(Dinamic Software)(es) | NONAMED.CAS | Yes | `CASGOR` |  |  |
| Nonamed (1986)(Dinamic Software)(es) | NONAMEDA.CAS | Yes | `CASGOR` |  |  |
| North & South (1991)(Infogrames)(M3)(Side A) | NORTH-SO.CAS | Yes | `CASGOI /S` |  |  |
| North Sea Bullion Adventure (1985)(Kuma Computers) | NORTHRUN.CAS | Yes | `CASGOR` |  |  |
| North Sea Helicopter (1987)(Aackosoft) | NORTHCAS.CAS | Yes | `CASGOR /CB` |  |  |
| North Sea Helicopter (Aackosoft, 1985) | NORTH-SE.CAS | Yes | `CASGOR /CB` |  |  |
| Nuclear Bowls (1986)(Zigurat Software)(es) | NUCLEAR.CAS | Yes | `CASGOI /CB` |  |  |
| Obliterator (1989)(Dro Soft)(es) | OBLITERA.CAS | Yes | `CASGOI /S` |  |  |
| Ocean Conqueror (1987)(Mastertronic) | OCEAN-CO.CAS | Yes | `CASGOR /B` |  |  |
| Oceano (2015) (EgoTrip) | OCEANO.CAS | Yes | `CASGOR` |  |  |
| Octagon Squad (1986)(Mastertronic) | OCTAGON.CAS | Yes | `CASGOI /B` |  |  |
| Octagon Squad (1986)(Mastertronic) | OCTAGON2.CAS | Yes | `CASGOI /B` |  |  |
| Octagon Squad (1986)(Mastertronic) | OCTAGONA.CAS | Yes | `CASGOI /B` |  |  |
| Octopuss MSX Panic (1986)(Eoe)(fr) | OCTOPUSS.CAS | Yes | `CASGOR` |  |  |
| Offering (1984)(AI Inc.) | OFFERING.CAS | Yes | `CASGOR` |  |  |
| Oh Mummy!! (1984)(Longman Software) | OH-MUMMY.CAS | Yes | `CASGOR` |  |  |
| Oh no! (Aka Oh Shit!) | OH-NO.CAS | Yes | `CASGOR` |  |  |
| Oh Shit! (1986)(Aackosoft) | OH-SHI86.CAS | Yes | `CASGOR /CB` |  |  |
| Oh Shit! (1986)(Aackosoft) | OH-SHIT.CAS | Yes | `CASGOR` |  |  |
| Oh Shit! (ByteBusters) (Aackosoft - Eaglesoft) | OH-SHCAS.CAS | Yes | `CASGOR /CB` |  |  |
| Oh Shit! - MSX Compilation 5 (ByteBusters) (Aackosoft - Eaglesoft) | OH-SHMSX.CAS | Yes | `CASGOR /CB` |  |  |
| OhShit! | OHSHIT.CAS | Yes | `CASGOR` |  |  |
| Oil's Well (1985)(Eaglesoft) | OIL-S-WE.CAS | Yes | `CASGOI /CB` |  |  |
| Operation Wolf (1988)(Ocean Software) | OPERATIO.CAS | Yes | `CASGOI /C` |  |  |
| Operation Wolf (1988)(Ocean Software)(Side A) | OPERATIA.CAS | Yes | `CASGOI /C` |  |  |
| Operation Wolf (1988)(Ocean Software)(Side A) | OPERATIR.CAS | Yes | `CASGOI /C` |  |  |
| Oregon Trail  (2020) (Cobinee and Jitursan) | OREGON.CAS | Yes | `CASGOR` |  |  |
| Ormuz (1988)(Iber Soft)(es) | ORMUZ.CAS | Yes | `CASGOR /B` |  |  |
| Ormuz (1988)(Iber Soft)(es) | ORMUZA.CAS | Yes | `CASGOR /B` |  |  |
| Ortografia I - Vocabulario (19xx)(Mind Games Espana)(es) | ORTOGRAI.CAS | Yes | `CASGOR` |  |  |
| Ortografia II - Verbos (19xx)(Mind Games Espana)(es) | ORTOGRAA.CAS | Yes | `CASGOR` |  |  |
| Ortografia II - Verbos (19xx)(Mind Games Espana)(es) | ORTOGRII.CAS | Yes | `CASGOR` |  |  |
| Ortografia III - Frases (19xx)(Mind Games Espana)(es) | ORTOGRAF.CAS | Yes | `CASGOR` |  |  |
| Ostrich (1985)(Columbia) | OSTRICH.CAS | Yes | `CASGOR` |  |  |
| Otto e Trenta (1985)(Melchioni Informatica)(it) | OTTO-E.CAS | Yes | `CASGOR` |  |  |
| Ougon no Haka. Golden Tomb. Mystery of Egypt (1984)(Magical Zoo)(ja) | OUGON-NO.CAS | Yes | `CASGOR` |  |  |
| Oushou (King) (1984)(Microcabin)(ja) | OUSHOU.CAS | Yes | `CASGOR` |  |  |
| Out Run (1988)(US Gold) | OUT-RUN.CAS | Yes | `CASGOR` |  |  |
| Out Run (1988)(US Gold) | OUT-RUNA.CAS | Yes | `CASGOI /S` |  |  |
| Out Run (1988)(US Gold) | OUT-RUNR.CAS | Yes | `CASGOI /S` |  |  |
| Out Run (1988)(US Gold) | OUTRUN.CAS | Yes | `CASGOR` |  |  |
| Outroyd (1985)(Magical Zoo) | OUTROCAS.CAS | Yes | `CASGOR` |  |  |
| Outroyd (1985)(Magical Zoo) | OUTROYD.CAS | Yes | `CASGOR` |  |  |
| PAC-01 - Arcs (2021) | PAC-01.CAS | Yes | `CASGOR` |  |  |
| Pac-Land (1988)(Grandslam Entertainments) | PAC-LAND.CAS | Yes | `CASGOI /S` |  |  |
| Pac-Man (1984)(Bug-Byte Software) | PAC-MAN.CAS | Yes | `CASGOR /N` |  |  |
| Pac-Mania (1988)(Grandslam Entertainments) | PAC-MA88.CAS | Yes | `CASGOI /S` |  |  |
| Pac-Mania (1988)(Grandslam Entertainments)__Pac-Mania (Grandslam) (Zafiro) | PAC-MANR.CAS | Yes | `CASGOI /S` |  |  |
| Pac-Mania (1988)(Grandslam Entertainments)__Pac-Mania (Grandslam) (Zafiro) | PACPAC.CAS | Yes | `CASGOI /S` |  |  |
| Pac-Mania (Grandslam) (Zafiro) | PAC-MANI.CAS | Yes | `CASGOI /S` |  |  |
| Pac-Mania (Grandslam) (Zafiro) | PACCAS.CAS | Yes | `CASGOI /S` |  |  |
| Paises de America (1984)(Sony)(es) | PAISES.CAS | Yes | `CASGOR` |  |  |
| Paises de Asia (1984)(Sony)(es) | PAISESDE.CAS | Yes | `CASGOR` |  |  |
| Panel Panic (1986)(Eaglesoft) | PANEL-PA.CAS | Yes | `CASGOI /B` |  |  |
| Panel Panic (1986)(Eaglesoft) | PANELA.CAS | Yes | `CASGOI /B` |  |  |
| Panic The Train (1984)(Centralsoft) | PANIC-TH.CAS | Yes | `CASGOR` |  |  |
| Panique (1986)(Eaglesoft) | PANIQUE.CAS | Yes | `CASGOR /CB` |  |  |
| Paris-Dakar (1988)(Zigurat Software)(es) | PARIS-DA.CAS | Yes | `CASGOR /CB` |  |  |
| Passing Shot (1989)(Image Works) | PASSING.CAS | Yes | `CASGOI /S` |  |  |
| Pastfinder (1984)(Activision) | PASTFIND.CAS | Yes | `CASGOR` |  |  |
| Payaso Explorador, El (1986)(Anaya Multimedia)(es) | PAYASO.CAS | Yes | `CASGOR` |  |  |
| Pentagram (1986)(Ultimate Play The Game) | PENTAGRA.CAS | Yes | `CASGOT /C` |  |  |
| Pepe Saltarin (1986)(Grupo de Trabajo Software)(es) | PEPE-SAA.CAS | Yes | `CASGOR` |  |  |
| Pepe Saltarin (1986)(Grupo de Trabajo Software)(es) | PEPE-SAL.CAS | Yes | `CASGOR` |  |  |
| Perico Delgado Maillot Amarillo (1989)(Topo Soft)(es)(Side A) | PERICO.CAS | Yes | `CASGOI /S` |  |  |
| PERT (1986)(DIMensionNEW)(es) | PERT.CAS | Yes | `CASGOR` |  |  |
| Pescador Espacial, El (1986)(Anaya Multimedia)(es) | PESCADOR.CAS | Yes | `CASGOR` |  |  |
| Peter Beardsley's International Football (1988)(Grandslam Entertainments) | PETER-BE.CAS | Yes | `CASGOI /S` |  |  |
| Phantis (1987)(Dinamic Software)(es)(Side A) | PHANTIS.CAS | Yes | `CASGOR` |  |  |
| Phantis (1987)(Dinamic Software)(es)(Side A) | PHANTISA.CAS | Yes | `CASGOR` |  |  |
| Phantomas 2 (1986)(Dinamic) | PHANTOMA.CAS | Yes | `CASGOR` |  |  |
| Phantomas 2 (1987)(Dinamic Software)(es) | PHANTOES.CAS | Yes | `CASGOR` |  |  |
| Pharaoh's Revenge (1988)(Eurosoft) | PHARAOH.CAS | Yes | `CASGOR /CB` |  |  |
| Pharaoh's Revenge (1988)(Eurosoft) | PHARAOHA.CAS | Yes | `CASGOR /CB` |  |  |
| Phfile (19xx)(Philips)(es) | PHFILE.CAS | Yes | `CASGOR` |  |  |
| Pico Pico (1983)(Micro Cabin) | PICO-PIC.CAS | Yes | `CASGOR` |  |  |
| Pico Pico (1983)(Micro Cabin) | PICOCAS.CAS | Yes | `CASGOR` |  |  |
| Pico Pico (Micro Cabin) (Toshiba) (Japan) | PICORUN.CAS | Yes | `CASGOR` |  |  |
| Pico Pico (Side A) (Micro Cabin) (Toshiba) (Japan) | PICO-PIA.CAS | Yes | `CASGOR` |  |  |
| picopico_toshiba | PICOPICO.CAS | Yes | `CASGOR` |  |  |
| picopico_toshiba_a | PICOPICA.CAS | Yes | `CASGOR` |  |  |
| picopico_toshiba_b | PICOPICB.CAS | Yes | `CASGOR` |  |  |
| Pinball Blaster (1988)(Eurosoft) | PINBALL.CAS | Yes | `CASGOR /CB` |  |  |
| Pinball Blaster (1988)(Eurosoft) | PINBALLA.CAS | Yes | `CASGOR /CB` |  |  |
| Pink Panther (1988)(Dro Soft) | PINK-PAN.CAS | Yes | `CASGOI /B` |  |  |
| Pippo La Scopa Ficcanaso (2021)(Gamecast) | PIPPO-LA.CAS | Yes | `CASGOR` |  |  |
| Pirates (1988)(Halley Software) | PIRATES.CAS | Yes | `CASGOR` |  |  |
| Pitfall II - Lost Caverns (1985)(Activision) | PITFALL.CAS | Yes | `CASGOR` |  |  |
| Playhouse Strippoker (1988)(Eurosoft) | PLAYHOUS.CAS | Yes | `CASGOR /CB` |  |  |
| Poder Oscuro, El (1988)(Zigurat Software)(es) | PODER-OS.CAS | Yes | `CASGOR /B` |  |  |
| Polar Star (1984)(Micro Cabin) | POLAR-ST.CAS | Yes | `CASGOR` |  |  |
| Polar Star (1984)(Micro Cabin) | POLARCAS.CAS | Yes | `CASGOR` |  |  |
| Police Academy (1986)(Eaglesoft) | POLICE86.CAS | Yes | `CASGOR /CB` |  |  |
| Police Academy II (1987)(Methodic Solutions) | POLICEII.CAS | Yes | `CASGOR /CB` |  |  |
| Police Dog (1984)(Hudson Soft) | POLICE.CAS | Yes | `CASGOR` |  |  |
| Poogaboo (1991)(Opera Soft)(es) | POOGABOA.CAS | Yes | `CASGOR /C` |  |  |
| Poogaboo (1991)(Opera Soft)(es) | POOGABOO.CAS | Yes | `CASGOR /C` |  |  |
| Poogaboo (1991)(Opera Soft)(es) | POOGABOR.CAS | Yes | `CASGOR /C` |  |  |
| Portopia Serial Murder Case (1985)(Enix)(ja) | PORTOPIA.CAS | Yes | `CASGOR` |  |  |
| Post Mortem (1988)(Iber Soft)(es) | POST-MOR.CAS | Yes | `CASGOR` |  |  |
| Power and Magic (1990)(Zigurat Software)(es) | POWER-AN.CAS | Yes | `CASGOI /B` |  |  |
| Power and Magic (1990)(Zigurat Software)(es) | POWERA.CAS | Yes | `CASGOI /B` |  |  |
| Power Drift (1989)(Activision)(Side A) | POWER-DR.CAS | Yes | `CASGOI /S` |  |  |
| Previsiones (1986)(Load 'n' Run)(es) | PREVISIO.CAS | Yes | `CASGOR` |  |  |
| Principe y el Dragon, El (1985)(Advance)(es) | PRINCIPE.CAS | Yes | `CASGOR` |  |  |
| Professional Baseball Super Simulation (1984)(JDS)(ja) | PROFESSI.CAS | Yes | `CASGOR` |  |  |
| Professional Snooker Simulator (1987)(Codemasters)(M3) | PROFESS3.CAS | Yes | `CASGOR` |  |  |
| Professional Tennis Simulator (1990)(Dinamic Software) | PROFEAKA.CAS | Yes | `CASGOT /B` |  |  |
| Project A (1984)(Pony Canyon) | PROJECT.CAS | Yes | `CASGOR` |  |  |
| Protector, The (1987)(Eaglesoft) | PROTECTA.CAS | Yes | `CASGOI /CB` |  |  |
| Protector, The (1987)(Eaglesoft) | PROTECTO.CAS | Yes | `CASGOI /CB` |  |  |
| Psychedelia (1984)(Aackosoft) | PSYCHEDE.CAS | Yes | `CASGOR` |  |  |
| Psycho Pig U.X.B. (1988)(US Gold) | PSYCHO.CAS | Yes | `CASGOR /B` |  |  |
| Punch And Judy (1989)(Alternative Software) | PUNCH-AN.CAS | Yes | `CASGOI /CB` |  |  |
| Punchy (1984)(Mr. Micro) | PUNCHY.CAS | Yes | `CASGOR` |  |  |
| Puzzybox (2021)(Gamecast) | PUZZYBOX.CAS | Yes | `CASGOR` |  |  |
| Pwnd 3 (2019) (Metal Soft) (v1.1) | PWND-3.CAS | Yes | `CASGOR` |  |  |
| Pyramid Warp (1983)(T&E Soft) | PYRAMID.CAS | Yes | `CASGOR` |  |  |
| Pyro-Man (Nice Ideas)(1985)(Fr) | PYRO-MAN.CAS | Yes | `CASGOR` |  |  |
| Quartet (2019) (Ilkke and bitsofbas) | QUARTET.CAS | Yes | `CASGOR` |  |  |
| Quartet (2019) (Ilkke and bitsofbas) (v1.1) | QUARTETV.CAS | Yes | `CASGOR` |  |  |
| Quebert (1988)(Eurosoft) | QUEBERT.CAS | Yes | `CASGOR /CB` |  |  |
| Quebert (1988)(Eurosoft) | QUEBERT2.CAS | Yes | `CASGOR /CB` |  |  |
| Quebert (1988)(Eurosoft) | QUEBERTA.CAS | Yes | `CASGOR /CB` |  |  |
| QUEEN | QUEEN.CAS | Yes | `CASGOR` |  |  |
| Queen's Golf (1984)(Ascii) | QUEEN-S.CAS | Yes | `CASGOR` |  |  |
| R.A.M. (1990)(Topo Soft)(es) | R-A-M.CAS | Yes | `CASGOI /S` |  |  |
| Race City (1988)(Iber Soft)(es) | RACE-CIT.CAS | Yes | `CASGOI /B` |  |  |
| Rally-X (1984)(Bug-Byte Software) | RALLY-X.CAS | Yes | `CASGOR /N` |  |  |
| Rambo III (1988)(Ocean Software) | RAMBO-II.CAS | Yes | `CASGOI /C` |  |  |
| Rambo III (1988)(Ocean Software)(Side A) | RAMBOA.CAS | Yes | `CASGOI /C` |  |  |
| Rambo III (1988)(Ocean Software)(Side A) | RAMBOR.CAS | Yes | `CASGOI /C` |  |  |
| Rampart, The (1988)(Iber Soft) | RAMPART.CAS | Yes | `CASGOR` |  |  |
| Rath-Tha (1989)(Positive)(es) | RATH-THA.CAS | Yes | `CASGOR /B` |  |  |
| Red Dawn (1988)(Eurosoft) | RED-DAWA.CAS | Yes | `CASGOR /CB` |  |  |
| Red Dawn (1988)(Eurosoft) | RED-DAWN.CAS | Yes | `CASGOR /CB` |  |  |
| Red Moon (1985)(Level 9 Computing) | RED-MOON.CAS | Yes | `CASGOR /B` |  |  |
| Reflex (1987)(Players Software)(Side A) | REFLEX.CAS | Yes | `CASGOR` |  |  |
| Reflex (1987)(Players Software)(Side A) | REFLEX2.CAS | Yes | `CASGOR` |  |  |
| Reflex (1987)(Players Software)(Side A) | REFLEXA.CAS | Yes | `CASGOR` |  |  |
| Relics (1986)(Bothtec)(Side A) | RELICS.CAS | Yes | `CASGOR` |  |  |
| Renegade III - The Final Chapter (1989)(Imagine Software) | RENEGADE.CAS | Yes | `CASGOI /S` |  |  |
| Rescate Atlantida (1989)(Dinamic Software)(es) | RESCATE.CAS | Yes | `CASGOR` |  |  |
| Rescate Atlantida (1989)(Dinamic Software)(es)(Side A) | RESCARUN.CAS | Yes | `CASGOR` |  |  |
| Rescate en el Golfo (1990)(Opera Soft)(es)(Side A) | RESCATEA.CAS | Yes | `CASGOR /C` |  |  |
| Rescate en el Golfo (1990)(Opera Soft)(es)(Side A) | RESCATEL.CAS | Yes | `CASGOR /C` |  |  |
| Rescate en el Golfo (1990)(Opera Soft)(es)(Side A) | RESCATEN.CAS | Yes | `CASGOR /C` |  |  |
| Return To Eden (1984)(Level 9 Computing) | RETURN.CAS | Yes | `CASGOR /CB` |  |  |
| Risky Holding (1986)(DIMensionNEW)(es) | RISKY-HO.CAS | Yes | `CASGOR` |  |  |
| River Chase (1984)(Soft Pro International)(JP)(en) | RIVEREN.CAS | Yes | `CASGOR` |  |  |
| River Chase (Soft Pro International) | RIVER-CH.CAS | Yes | `CASGOR` |  |  |
| River Raid (1984)(Activision) | RIVER-RA.CAS | Yes | `CASGOR` |  |  |
| Robocop (1988)(Ocean Software)(Side A) | ROBOCOP.CAS | Yes | `CASGOI /C` |  |  |
| Robot Wars (1986)(Eaglesoft) | ROBOT-WA.CAS | Yes | `CASGOT /B` |  |  |
| Robot Wars (ByteBusters) (Aackosoft - Eaglesoft) (Compulogical) | ROBOTAL.CAS | Yes | `CASGOT /B` |  |  |
| Roboy (1987)(Methodic Solutions) | ROBOY.CAS | Yes | `CASGOR /CB` |  |  |
| Rock 'n Roller (1988)(Topo Soft)(es) | ROCK-N.CAS | Yes | `CASGOI /S` |  |  |
| Rocky (1985)(Dinamic Software)(es) | ROCKY.CAS | Yes | `CASGOI /B14` |  |  |
| Rocky (1985)(Dinamic Software)(es) | ROCKYA.CAS | Yes | `CASGOI /B14` |  |  |
| Roller (1987)(Triosoft) | ROLLER.CAS | Yes | `CASGOI /B` |  |  |
| Roma - La Conquista del Imperio (1986)(Idealogic)(es) | ROMA-LA.CAS | Yes | `CASGOR /B` |  |  |
| Roulette (Side A) (Spectravideo) | ROULETTA.CAS | Yes | `CASGOR` |  |  |
| Roulette (Spectravideo) | ROULETTE.CAS | Yes | `CASGOR` |  |  |
| Roulette - Game Pack 1 (Aackosoft - Eaglesoft) | ROULECAS.CAS | Yes | `CASGOR` |  |  |
| RSC Ensamblador (19xx)(Manhattan Transfer)(es) | RSC-ENSA.CAS | Yes | `CASGOR` |  |  |
| Runner (1986)(Loriciels)(fr) | RUNNER.CAS | Yes | `CASGOR` |  |  |
| Running Man, The (1989)(Grandslam Entertainments)(es)(Side A) | RUNNING.CAS | Yes | `CASGOI /S` |  |  |
| Ruptus (2021)(Inufuto) | RUPTUS.CAS | Yes | `CASGOR` |  |  |
| RUR1 | RUR-1.CAS | Yes | `CASGOI /S` |  |  |
| RUR2 | RUR-2.CAS | Yes | `CASGOI /S` |  |  |
| Sabotaje (1988)(P.J. Software)(es) | SABOTAJA.CAS | Yes | `CASGOR` |  |  |
| Sabotaje (1988)(P.J. Software)(es) | SABOTAJE.CAS | Yes | `CASGOR` |  |  |
| Saboteur 2 (2026)(Clive Townsend)(Port by Thealfest) | SABOTEUR.CAS | Yes | `CASGOR /CB` |  |  |
| Saboteur 2 v1.02 (2026)(Clive Townsend)(Port by Thealfest) | SABOTEU1.CAS | Yes | `CASGOR /CB` |  |  |
| Sabrina (1989)(Iber Soft)(es) | SABRINA.CAS | Yes | `CASGOM` |  |  |
| Saint Dragon (1990)(Dro Soft)(Side A) | SAINT-DR.CAS | Yes | `CASGOT /S` |  |  |
| Samantha Fox Strip Poker (1986)(Martech Games) | SAMANCAS.CAS | Yes | `CASGOR` |  |  |
| Satan (1989)(Dinamic Software)(es)(Side A) | SATANA.CAS | Yes | `CASGOR /B` |  |  |
| Satan (1989)(Dinamic Software)(Side A) | SATAN.CAS | Yes | `CASGOR /B` |  |  |
| Scapeghost - Part 1 (1989)(Level 9 Computing) | SCAPEGHO.CAS | Yes | `CASGOT /CB` |  |  |
| Scapeghost - Part 2 (1989)(Level 9 Computing) | SCAPEGH2.CAS | Yes | `CASGOT /CB` |  |  |
| Scapeghost - Part 3 (1989)(Level 9 Computing) | SCAPEGH3.CAS | Yes | `CASGOT /CB` |  |  |
| Scentipede (1986)(Eaglesoft) | SCENTIPE.CAS | Yes | `CASGOR /CB` |  |  |
| Science Fiction (1986)(Eaglesoft) | SCIENCE.CAS | Yes | `CASGOR /CB` |  |  |
| Score 3020 (1988)(Topo Soft)(es) | SCORE-30.CAS | Yes | `CASGOI /S` |  |  |
| Scrabble(1986) | SCRABBLE.CAS | Yes | `CASGOI /CB` |  |  |
| Scrabble(1986) | SCRABCAS.CAS | Yes | `CASGOI /CB` |  |  |
| Scramble Spirits (1990)(Grandslam Entertainments)(Side A) | SCRAMBLA.CAS | Yes | `CASGOI /S` |  |  |
| Scramble Spirits (1990)(Grandslam Entertainments)(Side A) | SCRAMBLE.CAS | Yes | `CASGOI /S` |  |  |
| Sea Bomber (1983)(Hudson Soft) | SEA-BOMB.CAS | Yes | `CASGOR` |  |  |
| Sea Hunter (1985)(Spectravideo) | SEA-HUNT.CAS | Yes | `CASGOR` |  |  |
| Sea King (1986)(Players Software) | SEA-KING.CAS | Yes | `CASGOR` |  |  |
| Senda Salvaje (1990)(Zigurat Software)(es)(Side A) | SENDA-SA.CAS | Yes | `CASGOI /B` |  |  |
| Shark Hunter (1984)(Electric Software) | SHARK-HU.CAS | Yes | `CASGOR` |  |  |
| Shinobi (1989)(Virgin Games)(Side A) | SHINOBI.CAS | Yes | `CASGOI /S` |  |  |
| Ship (1989)(Eurosoft)(es) | SHIP.CAS | Yes | `CASGOR /P4` |  |  |
| Shup. Trebol (1986)(Mind Games Espana)(es) | SHUP-TRE.CAS | Yes | `CASGOR` |  |  |
| Silent Shadow (1988)(Topo Soft) | SILENT.CAS | Yes | `CASGOI /S` |  |  |
| Silfi (1988)(Iber Soft)(es) | SILFI.CAS | Yes | `CASGOR` |  |  |
| Silicon Dreams I - Snowball v2 (1986)(Level 9 Computing) | SILICO86.CAS | Yes | `CASGOT /CB` |  |  |
| Silicon Dreams I - Snowball v2 (1986)(Level 9 Computing) | SILICON1.CAS | Yes | `CASGOT /CB` |  |  |
| Silicon Dreams I - Snowball v2 (1986)(Level 9 Computing) | SILICON2.CAS | Yes | `CASGOT /CB` |  |  |
| Silicon Dreams I - Snowball v2 (1986)(Level 9 Computing) | SILICRUN.CAS | Yes | `CASGOT /CB` |  |  |
| Silicon Dreams II - Return to Eden (1984)(Level 9 Computing) | SILICO84.CAS | Yes | `CASGOI /B` |  |  |
| Silicon Dreams II - Return to Eden (1984)(Level 9 Computing) | SILICON.CAS | Yes | `CASGOR /CB` |  |  |
| Silicon Dreams II - Return to Eden v2 (1986)(Level 9 Computing) | SILICCAS.CAS | Yes | `CASGOT /CB` |  |  |
| Silicon Dreams II - Return to Eden v2 (1986)(Level 9 Computing) | SILICOII.CAS | Yes | `CASGOT /CB` |  |  |
| Silicon Dreams II - Return to Eden v2 (1986)(Level 9 Computing) | SILICON9.CAS | Yes | `CASGOT /CB` |  |  |
| Silicon Dreams II - Return to Eden v2 (1986)(Level 9 Computing) | SILICOTO.CAS | Yes | `CASGOT /CB` |  |  |
| Silicon Dreams III - The Worm in Paradise v2 (1986)(Level 9 Computing) | SILICIII.CAS | Yes | `CASGOT /CB` |  |  |
| Silicon Dreams III - The Worm in Paradise v2 (1986)(Level 9 Computing) | SILICONA.CAS | Yes | `CASGOT /CB` |  |  |
| Silicon Dreams III - The Worm in Paradise v2 (1986)(Level 9 Computing) | SILICONV.CAS | Yes | `CASGOT /CB` |  |  |
| Silicon Dreams III - The Worm in Paradise v2 (1986)(Level 9 Computing) | SILICTHE.CAS | Yes | `CASGOT /CB` |  |  |
| Silvestro Spazzino Maldestro - Gianluca Barfi (1986)(it) | SILVESTR.CAS | Yes | `CASGOR` |  |  |
| Simulador Profesional de Tenis (1990)(Dinamic Software)(es) | SIMULADO.CAS | Yes | `CASGOT /B` |  |  |
| Sir Fred (1986)(Zigurat Software)(es) | SIR-FRED.CAS | Yes | `CASGOI /B` |  |  |
| Sirwood (1990)(Opera Soft)(Side A) | SIRWOOD.CAS | Yes | `CASGOR /C` |  |  |
| Sito Pons 500cc Grand Prix (1990)(Zigurat Software)(es) | SITO-PON.CAS | Yes | `CASGOM /CB` |  |  |
| Skate Dragon (1986)(Idealogic)(es) | SKATE-DR.CAS | Yes | `CASGOR` |  |  |
| Skooter (1987)(Eaglesoft) | SKOOTER.CAS | Yes | `CASGOI /C` |  |  |
| Skramble (1985)(Aackosoft) | SKRAMBLE.CAS | Yes | `CASGOI /CB` |  |  |
| Skramble - Compilation Tape 1 (ByteBusters) (Aackosoft - Eaglesoft) | SKRAMBL1.CAS | Yes | `CASGOR /CB` |  |  |
| Skull Exilon (1988)(Iber Soft) | SKULL-EX.CAS | Yes | `CASGOR` |  |  |
| Sky Diver (1984)(Hudson Soft) | SKY-DIVE.CAS | Yes | `CASGOR` |  |  |
| Sky Vision (1987)(Eaglesoft) | SKY-VISI.CAS | Yes | `CASGOR /CB` |  |  |
| Sky War (1988)(OMK Software)(es) | SKY-WAR.CAS | Yes | `CASGOR` |  |  |
| Skyhawk (1986)(Bug-Byte Software) | SKYHAWK.CAS | Yes | `CASGOR` |  |  |
| Slapshot (1985)(Anirog Software) | SLAPSHOT.CAS | Yes | `CASGOR` |  |  |
| Slime Center (2014)(N.I.) | SLIME-CE.CAS | Yes | `CASGOR` |  |  |
| Slot-Machine (1985)(Creating Soft) | SLOT-MAC.CAS | Yes | `CASGOR` |  |  |
| sm221 | SM-221.CAS | Yes | `CASGOR` |  |  |
| sm221_a | SM-221-A.CAS | Yes | `CASGOR` |  |  |
| sm221_b | SM-221-B.CAS | Yes | `CASGOR` |  |  |
| sm245 | SM-245.CAS | Yes | `CASGOR` |  |  |
| sm245_b | SM-245-B.CAS | Yes | `CASGOR` |  |  |
| sm330 | SM-330.CAS | Yes | `CASGOR` |  |  |
| sm330_a | SM-330-A.CAS | Yes | `CASGOR` |  |  |
| sm330_b | SM-330-B.CAS | Yes | `CASGOR` |  |  |
| Smack Wacker (1986)(Eaglesoft) | SMACK-WA.CAS | Yes | `CASGOR /CB` |  |  |
| Smash (1984)(Spectravideo) | SMASH.CAS | Yes | `CASGOR` |  |  |
| Snake It (1986)(Eaglesoft) | SNAKE-IT.CAS | Yes | `CASGOR /CB` |  |  |
| Snowball (1986)(Level 9 Computing) | SNOWBALL.CAS | Yes | `CASGOI /CB` |  |  |
| Snowman, The (1984)(Quicksilva) | SNOWMAN.CAS | Yes | `CASGOR` |  |  |
| Soccer Boss (The Boss) (1987)(Alternative Software | SOCCER.CAS | Yes | `CASGOR` |  |  |
| Sol Negro (1989)(Opera Soft)(es)(Side A) | SOL-NEGA.CAS | Yes | `CASGOR /C` |  |  |
| Sol Negro (1989)(Opera Soft)(es)(Side A) | SOL-NEGR.CAS | Yes | `CASGOR /C` |  |  |
| Soldier of Light (1989)(Dro Soft)(es) | SOLDIER.CAS | Yes | `CASGOI /S` |  |  |
| Solfeggietto - Game Pack 1 (Aackosoft - Eaglesoft) | SOLFEGGI.CAS | Yes | `CASGOR` |  |  |
| Solo (1989)(Opera Soft)(es) | SOLO.CAS | Yes | `CASGOR /C` |  |  |
| Sootland (1988)(Zafiro Software Division)(es)(Side A) | SOOTLAND.CAS | Yes | `CASGOI /S` |  |  |
| Sorcery (1985)(Virgin Games) | SORCERY.CAS | Yes | `CASGOR` |  |  |
| Sorcery (1985)(Virgin Games) | SORCERYA.CAS | Yes | `CASGOR /CB` |  |  |
| Soul of a Robot (1987)(Mastertronic) | SOUL-OF.CAS | Yes | `CASGOI /B` |  |  |
| Soviet (1990)(Opera Soft)(Side A) | SOVIET.CAS | Yes | `CASGOR /C` |  |  |
| Soviet (1990)(Opera Soft)(Side A)-FX2A | SOVIET2.CAS | Yes | `CASGOR /C` |  |  |
| Space Busters (1985)(Aackosoft) | SPACE-BU.CAS | Yes | `CASGOR` |  |  |
| Space Busters (1986)(Eaglesoft) | SPACE86.CAS | Yes | `CASGOR /CB` |  |  |
| Space Busters - Compilation Tape 1 (ByteBusters) (Aackosoft - Eaglesoft) | SPACE1.CAS | Yes | `CASGOR` |  |  |
| Space Harrier II (1990)(Grandslam)(GB)(Side A) | SPACECAS.CAS | Yes | `CASGOI /S` |  |  |
| Space Rescue (1988)(Eurosoft) | SPACE-RE.CAS | Yes | `CASGOR /CB` |  |  |
| Space Rescue (1988)(Eurosoft) | SPACE2.CAS | Yes | `CASGOR /CB` |  |  |
| Space Rescue (1988)(Eurosoft) | SPACE88.CAS | Yes | `CASGOR /CB` |  |  |
| Space Rescue - MSX Compilation 5 (ByteBusters) (Aackosoft - Eaglesoft) | SPACEMSX.CAS | Yes | `CASGOR /CB` |  |  |
| Space Shuttle - A Journey into Space (1986)(Activision) | SPACE-SH.CAS | Yes | `CASGOI /N` |  |  |
| Space Smugglers (1989)(MHT Ingenieros)(es) | SPACE-SM.CAS | Yes | `CASGOI /S` |  |  |
| Space Walk (1985)(Mastertronic) | SPACE-WA.CAS | Yes | `CASGOR` |  |  |
| Spartan X (1985)(Pony Canyon) | SPARTAN.CAS | Yes | `CASGOR` |  |  |
| Special Operations (1985)(MC Lothlorien) | SPECIAL.CAS | Yes | `CASGOR` |  |  |
| Special Operations (1985)(MC Lothlorien) | SPECIALA.CAS | Yes | `CASGOR` |  |  |
| Spectravideo SVI-728 Introduction-Demonstration (1984)(Spectravideo) | SPECTRAV.CAS | Yes | `CASGOR` |  |  |
| Speed King (1986)(Mastertronic) | SPEED-KI.CAS | Yes | `CASGOR` |  |  |
| Speed King (1986)(Mastertronic) | SPEEDA.CAS | Yes | `CASGOR` |  |  |
| Speedboat Racer (1987)(Methodic Solutions) | SPEEDBOA.CAS | Yes | `CASGOR /B` |  |  |
| Spellbound (2023)(Mastropiero) | SPELLBOU.CAS | Yes | `CASGOR` |  |  |
| Spellbound (2023)(Mastropiero) | SPELLCAS.CAS | Yes | `CASGOR /B` |  |  |
| Spirits (1987)(Topo Soft)(es) | SPIRITS.CAS | Yes | `CASGOI /CB` |  |  |
| Spitfire '40 (1986)(Mirrorsoft) | SPITFIRE.CAS | Yes | `CASGOM /CB` |  |  |
| Splash (1986)(Mind Games Espana) | SPLASH.CAS | Yes | `CASGOR` |  |  |
| Spy Story (1986)(Aackosoft) | SPY-STOR.CAS | Yes | `CASGOR /CB` |  |  |
| Spy vs Spy II - The Island Caper (1987)(Databyte) | SPY-VS.CAS | Yes | `CASGOR` |  |  |
| Spy vs Spy II - The Island Caper (1987)(Databyte) | SPY-VSA.CAS | Yes | `CASGOM /CB` |  |  |
| Squash 1986 (Robtek Software) | SQUASH.CAS | Yes | `CASGOR` |  |  |
| Star Bowls (1991)(Zigurat Software)(es) | STAR-BOW.CAS | Yes | `CASGOI /B` |  |  |
| Star Fighter (1986)(Eaglesoft) | STAR-FIG.CAS | Yes | `CASGOR /CB` |  |  |
| Star Fighter (Battleship Clapton II Hack) (1986)(Visiogame) | STARII.CAS | Yes | `CASGOR` |  |  |
| Star Maps - Game Pack 1 (Aackosoft - Eaglesoft) | STAR-MAP.CAS | Yes | `CASGOR` |  |  |
| Star Runner (1986)(Manhattan Transfer)(es) | STAR-RUA.CAS | Yes | `CASGOR` |  |  |
| Star Runner (1986)(Manhattan Transfer)(es) | STAR-RUB.CAS | Yes | `CASGOR` |  |  |
| Star Runner (1986)(Manhattan Transfer)(es) | STAR-RUN.CAS | Yes | `CASGOR` |  |  |
| Star Wars (1986)(Eaglesoft) | STAR-WAA.CAS | Yes | `CASGOR /CB` |  |  |
| Star Wars (1986)(Eaglesoft) | STAR-WAR.CAS | Yes | `CASGOR /CB` |  |  |
| Starbuggy (1988)(Eurosoft) | STARBUGG.CAS | Yes | `CASGOR /CB` |  |  |
| Starbuster (1988)(Methodic Solutions) | STARBUST.CAS | Yes | `CASGOI /CB` |  |  |
| Starbyte (1987)(Mister Chip)(es) | STARBYTE.CAS | Yes | `CASGOI /B` |  |  |
| Stardust (1987)(Topo Soft)(es) | STARDUST.CAS | Yes | `CASGOI /S` |  |  |
| Starquake (1986)(Bubblebus Software) | STARQUAA.CAS | Yes | `CASGOI /B` |  |  |
| Starquake (1986)(Bubblebus Software) | STARQUAK.CAS | Yes | `CASGOI /B` |  |  |
| Steve Davis Snooker (1985)(CDS Microsystems) | STEVE-DA.CAS | Yes | `CASGOR` |  |  |
| Stoneville Manor - Game Pack 1 (Aackosoft - Eaglesoft) | STONEVIL.CAS | Yes | `CASGOR` |  |  |
| Stop Ball (1987)(Dro Soft) | STOP-BAL.CAS | Yes | `CASGOR` |  |  |
| Stop the Express (Hudson) (Aackosoft - Eaglesoft) | STOP-THE.CAS | Yes | `CASGOR` |  |  |
| Storm - Una's Lair (1986)(Mastertronic) | STORM-UN.CAS | Yes | `CASGOR` |  |  |
| Storm - Una's Lair (1986)(Mastertronic) | STORMA.CAS | Yes | `CASGOR` |  |  |
| Stormbringer (1987)(Mastertronic Added Dimension) | STORMCAS.CAS | Yes | `CASGOR` |  |  |
| Stormbringer (1987)(Mastertronic) | STORMBRI.CAS | Yes | `CASGOR` |  |  |
| Streaker (1987)(Bulldog) | STREAKER.CAS | Yes | `CASGOR` |  |  |
| Strip Poker II+ (1988)(Anco Software) | STRIP-PO.CAS | Yes | `CASGOR` |  |  |
| Strip Poker II+ (1988)(Anco Software)(Side A) | STRIPA.CAS | Yes | `CASGOR` |  |  |
| Submarine Shooter (1983)(Hudson Soft) | SUBMARIN.CAS | Yes | `CASGOR` |  |  |
| Super Boy I | SUPER-BO.CAS | Yes | `CASGOR` |  |  |
| Super Boy II | SUPERII.CAS | Yes | `CASGOR` |  |  |
| Super Chess (1984)(Kuma Computers) | SUPER-CH.CAS | Yes | `CASGOR` |  |  |
| Super Chess (1984)(Kuma Computers) | SUPERA.CAS | Yes | `CASGOR` |  |  |
| Super Difficult Theseus (1985)(Login Soft) | SUPER-DI.CAS | Yes | `CASGOR` |  |  |
| Super Doors (1983) | SUPER-DO.CAS | Yes | `CASGOR` |  |  |
| Super Ilevan (POPCOM 1987-04) | SUPER-IL.CAS | Yes | `CASGOR` |  |  |
| super msx 12a | SUPER12.CAS | Yes | `CASGOI /S` |  |  |
| super msx 12b | SUPERMSX.CAS | Yes | `CASGOI /S` |  |  |
| super msx 19 lato A | SUPER19.CAS | Yes | `CASGOM /B` |  |  |
| super msx 19 lato B | SUPER19B.CAS | Yes | `CASGOI /CB` |  |  |
| super msx 2a | SUPERA2.CAS | Yes | `CASGOR` |  |  |
| super msx 2b | SUPERB2.CAS | Yes | `CASGOR` |  |  |
| super msx 3 | SUPER-MS.CAS | Yes | `CASGOR` |  |  |
| Super Pac-Man (1982 & 2026)(Namco & Mastropiero) | SUPER-PA.CAS | Yes | `CASGOR` |  |  |
| Super Pachinko (Columbia) (Japan) | SUPERCAS.CAS | Yes | `CASGOR` |  |  |
| Super Racer (1985)(Login Soft) | SUPER-RA.CAS | Yes | `CASGOR` |  |  |
| Super Sprites (1986)(Idealogic)(es) | SUPER-SP.CAS | Yes | `CASGOI` |  |  |
| SUPER05A | SUPER-05.CAS | Yes | `CASGOI /S18` |  |  |
| SUPER09A | SUPER-09.CAS | Yes | `CASGOI /S` |  |  |
| SUPER09B | SUPERB.CAS | Yes | `CASGOM /S` |  |  |
| SUPER1 | SUPER-1.CAS | Yes | `CASGOT /B` |  |  |
| SUPER15A | SUPER-15.CAS | Yes | `CASGOI /S` |  |  |
| SUPER15B | SUPER15.CAS | Yes | `CASGOI /S` |  |  |
| SUPER15B__Super MSX n.5 (ottobre 1987) - cas_5 | SUPERN.CAS | Yes | `CASGOI /S` |  |  |
| SUPER22 | SUPER-22.CAS | Yes | `CASGOI /S` |  |  |
| SUPER22B | SUPER22.CAS | Yes | `CASGOI /CB` |  |  |
| super24latoa | SUPER-24.CAS | Yes | `CASGOI /B` |  |  |
| super24latob | SUPEROB.CAS | Yes | `CASGOI /B` |  |  |
| super26max | SUPER-26.CAS | Yes | `CASGOI /B` |  |  |
| super26max2 | SUPER2.CAS | Yes | `CASGOI /CB` |  |  |
| SUPER27 | SUPER-27.CAS | Yes | `CASGOR /CB` |  |  |
| super_msx_10_lato_A | SUPER10.CAS | Yes | `CASGOI /S` |  |  |
| super_msx_10_lato_B | SUPER10B.CAS | Yes | `CASGOI /S` |  |  |
| super_msx_11_lato_A | SUPER11.CAS | Yes | `CASGOI /S` |  |  |
| super_msx_11_lato_B | SUPER11B.CAS | Yes | `CASGOI /S` |  |  |
| super_msx_13_lato_A | SUPER13.CAS | Yes | `CASGOI /S` |  |  |
| super_msx_13_lato_B | SUPER13B.CAS | Yes | `CASGOI /S` |  |  |
| super_msx_14_lato_A | SUPER14.CAS | Yes | `CASGOI /S` |  |  |
| super_msx_14_lato_B | SUPER14B.CAS | Yes | `CASGOI /S` |  |  |
| super_msx_16_lato_A | SUPER16.CAS | Yes | `CASGOI /S` |  |  |
| super_msx_16_lato_B | SUPER16B.CAS | Yes | `CASGOI /S` |  |  |
| super_msx_17_lato_A | SUPER17.CAS | Yes | `CASGOI /B` |  |  |
| super_msx_17_lato_B | SUPER17B.CAS | Yes | `CASGOI /CB` |  |  |
| super_msx_21_lato_A | SUPER21.CAS | Yes | `CASGOI /S` |  |  |
| super_msx_21_lato_B | SUPER21B.CAS | Yes | `CASGOI /CB` |  |  |
| super_msx_23_lato_A | SUPER23.CAS | Yes | `CASGOI /CB` |  |  |
| super_msx_23_lato_B | SUPER23B.CAS | Yes | `CASGOI /CB` |  |  |
| super_msx_25_lato_A | SUPER25.CAS | Yes | `CASGOI /B` |  |  |
| super_msx_25_lato_B | SUPER25B.CAS | Yes | `CASGOR /CB` |  |  |
| super_msx_4_lato_A | SUPER4.CAS | Yes | `CASGOI /S` |  |  |
| super_msx_4_lato_B | SUPER4B.CAS | Yes | `CASGOI /S` |  |  |
| super_msx_6_lato_A | SUPER6.CAS | Yes | `CASGOT /S` |  |  |
| super_msx_7_lato_A | SUPER7.CAS | No | `CASGOI /S` | Q |  |
| super_msx_7_lato_B | SUPER7B.CAS | Yes | `CASGOI /S` |  |  |
| super_msx_8_lato_A | SUPER8.CAS | Yes | `CASGOI /S` |  |  |
| super_msx_8_lato_B | SUPER8B.CAS | Yes | `CASGOI /S` |  |  |
| Superbowl (1985)(Budgie Budget Software) | SUPERBOW.CAS | Yes | `CASGOR` |  |  |
| Supermaze (1984) | SUPERMAZ.CAS | Yes | `CASGOR` |  |  |
| SuperMSX18-LatoA | SUPERM18.CAS | Yes | `CASGOI /B13` |  |  |
| SuperMSX18-LatoB | SUPERMSB.CAS | Yes | `CASGOR /CB` |  |  |
| SuperMSX20-LatoA | SUPERM20.CAS | Yes | `CASGOI /B` |  |  |
| SuperMSX20-LatoB | SUPERMOB.CAS | Yes | `CASGOI /B` |  |  |
| Survivor (1987)(Topo Soft)(es) | SURVIVOR.CAS | Yes | `CASGOI /S` |  |  |
| Survivors (1986)(Atlantis Software) | SURVIV86.CAS | Yes | `CASGOR` |  |  |
| Swing Man (Side A) (Spectravideo) | SWINGA.CAS | Yes | `CASGOR` |  |  |
| Swing Man (Spectravideo) | SWING-MA.CAS | Yes | `CASGOR` |  |  |
| SWIV (1991)(Dro Soft)(Side A) | SWIVA.CAS | Yes | `CASGOI /S` |  |  |
| SwordWork (2026)(Inufuto) | SWORDWOR.CAS | Yes | `CASGOR` |  |  |
| Tai-Pan (1987)(Ocean Software)(Side A) | TAI-PAN.CAS | Yes | `CASGOI /CB` |  |  |
| Take the B Train (198x)(Atorasu) | TAKE-THE.CAS | Yes | `CASGOR` |  |  |
| Tales of Popolon (2017) | TALES-OF.CAS | Yes | `CASGOR` |  |  |
| Tales Of Popolon (v1.2)(2017)(EN) | TALESEN.CAS | Yes | `CASGOR` |  |  |
| Tales Of Popolon (v1.2)(2017)(ES) | TALESES.CAS | Yes | `CASGOR` |  |  |
| Tales Of Popolon (v1.3)(2017)(EN) | TALES3.CAS | Yes | `CASGOR` |  |  |
| Tales Of Popolon (v1.3)(2017)(ES) | TALESV.CAS | Yes | `CASGOR` |  |  |
| Tank Battalion (1984)(Bug-Byte Software) | TANK-BAT.CAS | Yes | `CASGOR /N` |  |  |
| Target Plus (1988)(Dinamic Software)(es) | TARGET.CAS | Yes | `CASGOR` |  |  |
| Tasword (1985)(Sony)(es) | TASWORD.CAS | Yes | `CASGOI /CB` |  |  |
| Tawara (1984)(Ascii) | TAWARA.CAS | Yes | `CASGOR` |  |  |
| Teach Yourself Basic(1985)(Toshiba)(Side A) | TEACH-YO.CAS | Yes | `CASGOR` |  |  |
| Teach Yourself Basic(1985)(Toshiba)(Side A)__Teach Yourself Basic(1985)(Toshiba)(Side A) | TEACHRUN.CAS | Yes | `CASGOR` |  |  |
| Teenage Mutant Hero Turtles (1990)(Image Works) | TEENACAS.CAS | Yes | `CASGOT /B` |  |  |
| Teenage Mutant Hero Turtles (1990)(Image Works) | TEENAGE.CAS | Yes | `CASGOT /B` |  |  |
| Temptations (1988)(Topo Soft)(es) | TEMPTATI.CAS | Yes | `CASGOI /S` |  |  |
| Temptations - Toposoft (1988)(Alternative version by Xesco) | TEMPTABY.CAS | Yes | `CASGOI /S` |  |  |
| Tenebra (2023)(Haplo) | TENEBRA.CAS | Yes | `CASGOR` |  |  |
| Tenebra (2023)(Haplo) | TENEBRNO.CAS | Yes | `CASGOR` |  |  |
| Tension (1988)(System 4)(es) | TENSION.CAS | Yes | `CASGOI /B` |  |  |
| Terminus - The Prison Planet (1987)(Mastertronic) | TERMINUS.CAS | Yes | `CASGOR` |  |  |
| Terrahawks (2020) (Anemotionalfish) | TERRAHAW.CAS | Yes | `CASGOR` |  |  |
| Terramex (1988)(Grandslam Entertainments) | TERRAMEX.CAS | Yes | `CASGOI /S` |  |  |
| Terrorpods (1989)(Dro Soft) | TERRORPO.CAS | Yes | `CASGOI /S` |  |  |
| Test de Adaptacion (1984)(DIMensionNEW)(es) | TEST-DE.CAS | Yes | `CASGOR` |  |  |
| Test de Capacidad de Concentracion (1984)(DIMensionNEW)(es) | TESTDE.CAS | Yes | `CASGOR` |  |  |
| Test de Caracter (1984)(DIMensionNEW)(es) | TESTES.CAS | Yes | `CASGOR` |  |  |
| Test Drive II - The Duel (1989)(Dro Soft) | TEST-DRA.CAS | Yes | `CASGOI /S` |  |  |
| Test Drive II - The Duel (1989)(Dro Soft) | TEST-DRI.CAS | Yes | `CASGOI /S` |  |  |
| Tetris (MirrorSoft) (MCM) | TETRIMCM.CAS | Yes | `CASGOR` |  |  |
| Tetris (MirrorSoft) (MCM) | TETRIS.CAS | Yes | `CASGOR` |  |  |
| The Archers - Part 1 (1985)(Level 9 Computing) | THE-ARCH.CAS | Yes | `CASGOT /CB` |  |  |
| The Archers - Part 2 (1985)(Level 9 Computing) | THE-ARC2.CAS | Yes | `CASGOT /CB` |  |  |
| The Archers - Part 3 (1985)(Level 9 Computing) | THE-ARC3.CAS | Yes | `CASGOT /CB` |  |  |
| The Archers - Part 4 (1985)(Level 9 Computing) | THE-ARC4.CAS | Yes | `CASGOT /CB` |  |  |
| The Elves of Maroland (2024)(Kame Soft) | THE-ELVE.CAS | Yes | `CASGOI /S` |  |  |
| The Growing Pains Of Adrian Mole - Part 1 (1987) (Level 9 Computing) | THE-GRO1.CAS | Yes | `CASGOT /CB` |  |  |
| The Growing Pains Of Adrian Mole - Part 2 (1987) (Level 9 Computing) | THE-GRO2.CAS | Yes | `CASGOT /B` |  |  |
| The Growing Pains Of Adrian Mole - Part 3 (1987) (Level 9 Computing) | THE-GRO3.CAS | Yes | `CASGOT /CB` |  |  |
| The Growing Pains Of Adrian Mole - Part 4 (1987) (Level 9 Computing) | THE-GRO4.CAS | Yes | `CASGOT /CB` |  |  |
| The Growing Pains of Adrian Mole 1 y 2 | THE-GROW.CAS | Yes | `CASGOT /CB` |  |  |
| The Growing Pains of Adrian Mole 3 y 4 | THE-GROY.CAS | Yes | `CASGOT /CB` |  |  |
| The Ice King (1986)(CDS Software) | THE-ICE.CAS | Yes | `CASGOM /B` |  |  |
| The Keiba - Champion Soft (1986) | THE-KEIB.CAS | Yes | `CASGOR` |  |  |
| The Munsters (1988)(Alternative Software) | THE-MUNS.CAS | Yes | `CASGOI /S` |  |  |
| The Price Of Magik (1986)(Level 9 Computing) | THE-PRIC.CAS | Yes | `CASGOT /CB` |  |  |
| The Queens Footsteps Part 1 (2020)(Davide Bucci) | THE-QUEE.CAS | Yes | `CASGOR` |  |  |
| The Queens Footsteps Part 2 (2020)(Davide Bucci).cas | THE-QUER.CAS | Yes | `CASGOR` |  |  |
| The Queens Footsteps Part 3 (2020)(Davide Bucci).cas | THE-QUE3.CAS | Yes | `CASGOR` |  |  |
| The Scramble (1983) (Marufune FSL) | THE-SCRA.CAS | Yes | `CASGOI /B` |  |  |
| The Secret Diary of Adrian Mole Aged 13≤ - Part I (1985)(Level 9 Computing) | THE-SECI.CAS | Yes | `CASGOR /B` |  |  |
| The Secret Diary of Adrian Mole Aged 13≤ - Part I (1985)(Level 9 Computing) | THECAS.CAS | Yes | `CASGOR /B` |  |  |
| The Secret Diary of Adrian Mole Aged 13≤ - Part II (1985)(Level 9 Computing) | THE-SECA.CAS | Yes | `CASGOR /B` |  |  |
| The Secret Diary of Adrian Mole Aged 13≤ - Part II (1985)(Level 9 Computing) | THE-SEII.CAS | Yes | `CASGOR /B` |  |  |
| The Secret Diary of Adrian Mole Aged 13≤ - Part III (1985)(Level 9 Computing) | THE-SECR.CAS | Yes | `CASGOR /B` |  |  |
| The Secret Diary of Adrian Mole Aged 13≤ - Part III (1985)(Level 9 Computing) | THEIII.CAS | Yes | `CASGOR /B` |  |  |
| The Secret Diary of Adrian Mole Aged 13≤ - Part IV (1985)(Level 9 Computing) | THE-SEIV.CAS | Yes | `CASGOR /B` |  |  |
| The Secret Diary of Adrian Mole Aged 13≤ - Part IV (1985)(Level 9 Computing) | THE-SEOF.CAS | Yes | `CASGOR /B` |  |  |
| The Storekeeper | THE-STOR.CAS | Yes | `CASGOR` |  |  |
| The Temptation Of The Apartment Wife (1986)(Koei) | THE-TEMP.CAS | Yes | `CASGOR` |  |  |
| The Tomato Princess From Salad Land Part 1 (Side 1A)(1985)(Hudson Soft)(BLOAD'CAS-',R) | THE-TOMA.CAS | Yes | `CASGOR` |  |  |
| The Tomato Princess From Salad Land Part 2 (Side 1B)(1985)(Hudson Soft)(BLOAD'CAS-',R) | THE-TOM1.CAS | Yes | `CASGOR` |  |  |
| The Tomato Princess From Salad Land Part 3 (Side 2A)(1985)(Hudson Soft)(BLOAD'CAS-',R) | THE-TOM3.CAS | Yes | `CASGOR` |  |  |
| The Tomato Princess From Salad Land Part 4 (Side 2B)(1985)(Hudson Soft)(BLOAD'CAS-',R) | THE-TOM4.CAS | Yes | `CASGOR` |  |  |
| The Way Of The Tiger (1986)(Gremlin Graphics Software)(GB)(Tape 1 of 2 Side A - Master Program) | THE-WAYA.CAS | Yes | `CASGOI /S` |  |  |
| The Way Of The Tiger (忍者タイガー) (1986)(Tomo Soft International)(Tape 1 Side A - Master Program) | THE-WAY1.CAS | Yes | `CASGOI /S` |  |  |
| The Worm In Paradise (1985)(Level 9 Computing) | THE-WORM.CAS | Yes | `CASGOR /B` |  |  |
| Thexder (1986)(Eaglesoft) | THEXDER.CAS | Yes | `CASGOI /CB` |  |  |
| Thing Bounces Back (1987)(Gremlin Graphics Software) | THING-BO.CAS | Yes | `CASGOI /S` |  |  |
| Thor (1988)(Proein Soft Line)(es) | THOR.CAS | Yes | `CASGOI /B` |  |  |
| Thunder Blade (1988)(US Gold)(Side A) | THUNDER.CAS | Yes | `CASGOI /S` |  |  |
| Time and Magik I - Lords of Time v2 (1988)(Level 9 Computing) | TIME-ANI.CAS | Yes | `CASGOT /CB` |  |  |
| Time and Magik I - Lords of Time v2 (1988)(Level 9 Computing) | TIME88.CAS | Yes | `CASGOT /CB` |  |  |
| Time and Magik I - Lords of Time v2(1988)(Level 9 Computing) | TIME-ANR.CAS | Yes | `CASGOT /CB` |  |  |
| Time and Magik II - Red Moon (1985)(Level 9 Computing) | TIME-AND.CAS | Yes | `CASGOR /B` |  |  |
| Time and Magik II - Red Moon v2 (1988)(Level 9 Computing) | TIMEII.CAS | Yes | `CASGOT /CB` |  |  |
| Time and Magik II - Red Moon v2 (1988)(Level 9 Computing) | TIMERED.CAS | Yes | `CASGOT /CB` |  |  |
| Time and Magik II - Red Moon v2(1988)(Level 9 Computing) | TIME-AN2.CAS | Yes | `CASGOT /CB` |  |  |
| Time and Magik III - The Price of Magik v2 (1988)(Level 9 Computing) | TIMEIII.CAS | Yes | `CASGOT /CB` |  |  |
| Time and Magik III - The Price of Magik v2 (1988)(Level 9 Computing) | TIMETHE.CAS | Yes | `CASGOT /CB` |  |  |
| Time and Magik III - The Price of Magik v2(1988)(Level 9 Computing) | TIMEOF.CAS | Yes | `CASGOT /CB` |  |  |
| Time Bandits (1984)(PSS) | TIME-BAA.CAS | Yes | `CASGOR` |  |  |
| Time Bandits (1984)(PSS) | TIME-BAN.CAS | Yes | `CASGOR` |  |  |
| Time Bomb (1987)(Methodic Solutions) | TIME-BOM.CAS | Yes | `CASGOR /CB` |  |  |
| Time Curb (1986)(Aackosoft) | TIME-CUA.CAS | Yes | `CASGOR /CB` |  |  |
| Time Curb (1986)(Aackosoft) | TIME-CUR.CAS | Yes | `CASGOR /CB` |  |  |
| Time Out (1988)(Zafiro Software Division)(es) | TIME-OUT.CAS | Yes | `CASGOR /S` |  |  |
| Time Rider (1988)(Eurosoft) | TIME-RIA.CAS | Yes | `CASGOR /CB` |  |  |
| Time Rider (1988)(Eurosoft) | TIME-RID.CAS | Yes | `CASGOR /CB` |  |  |
| Time Scanner (1989)(Activision) | TIME-SCA.CAS | Yes | `CASGOI /S` |  |  |
| Time Trax (1986)(Bug-Byte Software) | TIME-TRA.CAS | Yes | `CASGOI /B` |  |  |
| Time Trax (1986)(Bug-Byte Software) | TIMEBUG.CAS | Yes | `CASGOI /B` |  |  |
| Tiny Rise Out (1983)(ASCII) | TINY-RIS.CAS | Yes | `CASGOR` |  |  |
| Titanic (1988)(Topo Soft)(es)(Side A) | TITANIC.CAS | Yes | `CASGOI /S` |  |  |
| Toi Acid Game (1989)(Iber Soft)(es)(Side A) | TOI-ACID.CAS | Yes | `CASGOI /S` |  |  |
| Tokyo Gang (1990)(G.LL. Software)(es) | TOKYO-GA.CAS | Yes | `CASGOI /B` |  |  |
| Tom & Jerry (1989)(Erbe Software)(es) | TOM-JERR.CAS | Yes | `CASGOI /S` |  |  |
| Toobin' (1989)(Domark) | TOOBIN.CAS | Yes | `CASGOI /S` |  |  |
| Toobin' (1989)(Domark) | TOOBINA.CAS | Yes | `CASGOI /S` |  |  |
| Torreoscura - Part 1 (Bieno Marti & Pedro Fernández)(es) | TORREOSC.CAS | Yes | `CASGOI /S` |  |  |
| Torreoscura - Part 2 (Bieno Marti & Pedro Fernández)(es) | TORREOS2.CAS | Yes | `CASGOI /S` |  |  |
| Tour 91 (1991)(Topo Soft)(es)(Side A) | TOUR-91.CAS | Yes | `CASGOI /S` |  |  |
| TrackAndField1 | TRACKAND.CAS | Yes | `CASGOR` |  |  |
| TrackAndField2 | TRACKAN2.CAS | Yes | `CASGOR` |  |  |
| Trailblazer (1986)(Gremlin Graphics Software) | TRAILBLA.CAS | Yes | `CASGOT /B` |  |  |
| Trailblazer (1986)(Gremlin Graphics Software) | TRAILBLR.CAS | Yes | `CASGOT /S` |  |  |
| Transball (2016)(Santi Ontanon) | TRANSRUN.CAS | Yes | `CASGOT /B` |  |  |
| transball-en | TRANSBAL.CAS | Yes | `CASGOT /B` |  |  |
| Trantor - The Last Stormtrooper (1987)(Go!) | TRANTOR.CAS | Yes | `CASGOR` |  |  |
| Trantor - The Last Stormtrooper (1987)(Go!) | TRANTOR2.CAS | Yes | `CASGOR` |  |  |
| Trantor - The Last Stormtrooper (1987)(Go!) | TRANTORA.CAS | Yes | `CASGOR` |  |  |
| Trap - Game Pack 1 (Aackosoft - Eaglesoft) | TRAP-GAM.CAS | Yes | `CASGOR` |  |  |
| Trapox (2021)(Gamecast) | TRAPOX.CAS | Yes | `CASGOR` |  |  |
| Tras el Unicornio | TRAS-EL.CAS | Yes | `CASGOR` |  |  |
| Tres Luces de Glaurung, Las (1986)(Erbe Software)(es) | TRES-LUC.CAS | Yes | `CASGOI /CB` |  |  |
| Trick Boy. Pinball (1984)(T&E Soft) | TRICK-BO.CAS | Yes | `CASGOR` |  |  |
| Triple Comando (1988)(Dro Soft)(es)(Side A) | TRIPLE.CAS | Yes | `CASGOM /S` |  |  |
| Tritorn (1986)(Xain) | TRITORN.CAS | Yes | `CASGOM` |  |  |
| Trivial Pursuit (1986)(Domark)(es)(Side A) | TRIVIAL.CAS | Yes | `CASGOI /S` |  |  |
| TT Racer (1987)(Methodic Solutions) | TT-RACEA.CAS | Yes | `CASGOR /CB` |  |  |
| TT Racer (1987)(Methodic Solutions) | TT-RACER.CAS | Yes | `CASGOR /CB` |  |  |
| Tuareg (1988)(Topo Soft)(es) | TUAREG.CAS | Yes | `CASGOI /S` |  |  |
| Turbo Girl (1988)(Dinamic Software)(es) | TURBO-GI.CAS | Yes | `CASGOI /B` |  |  |
| Turbo Girl (1988)(Dinamic Software)(es) | TURBO2.CAS | Yes | `CASGOI /B` |  |  |
| Turbo Girl (1988)(Dinamic Software)(es) | TURBOA.CAS | Yes | `CASGOI` |  |  |
| Turmoil (1986)(Bug-Byte Software) | TURMOIL.CAS | Yes | `CASGOR` |  |  |
| Turmoil (1986)(Bug-Byte Software) | TURMOILA.CAS | Yes | `CASGOR` |  |  |
| Turtles - Konami (1981) | TURTLES.CAS | Yes | `CASGOR` |  |  |
| Turtles - Konami (1981) | TURTLES2.CAS | Yes | `CASGOR` |  |  |
| Tutor (1985)(Sony)(es)(Side A) | TUTOR.CAS | Yes | `CASGOR` |  |  |
| Twinlight (2019) (Retrosouls) | TWINLIGH.CAS | Yes | `CASGOR` |  |  |
| Typing Tutor (1985)(Sanyo) | TYPING.CAS | Yes | `CASGOR` |  |  |
| U Boat (1985)(Omega Systems)(ja) | U-BOAT.CAS | Yes | `CASGOR` |  |  |
| U-Boot (1985)(Manhattan Transfer)(es) | U-BOOT.CAS | Yes | `CASGOR` |  |  |
| U-Boot (1985)(Manhattan Transfer)(es) | U-BOOTA.CAS | Yes | `CASGOR` |  |  |
| Uchi Mata (1987)(Martech Games) | UCHI-MAT.CAS | Yes | `CASGOR` |  |  |
| Uchi Mata (1987)(Martech Games) | UCHI87.CAS | Yes | `CASGOI /B` |  |  |
| Uchi Mata (1987)(Martech Games) | UCHIRUN.CAS | Yes | `CASGOR` |  |  |
| UchiMata | UCHIMATA.CAS | Yes | `CASGOR` |  |  |
| Uchusen Gamma - Usebox.net (2019) | UCHUSEN.CAS | Yes | `CASGOR /CB` |  |  |
| Ulises (1989)(Opera Soft) | ULISES.CAS | Yes | `CASGOR /C` |  |  |
| Ultra Chess (1985)(Aackosoft) | ULTRA-CH.CAS | Yes | `CASGOR` |  |  |
| Ultra Chess (1985)(Aackosoft) | ULTRAA.CAS | Yes | `CASGOR` |  |  |
| Underground (1988)(System 4)(es) | UNDERGRO.CAS | Yes | `CASGOT /CB` |  |  |
| Untouchables, The (1989)(Erbe Software)(Side A) | UNTOUCAS.CAS | Yes | `CASGOI /S` |  |  |
| Untouchables, The (1989)(Erbe Software)(Side A) | UNTOUCHA.CAS | Yes | `CASGOI /S` |  |  |
| Vacuumania (1984)(PSS) | VACUUMAA.CAS | Yes | `CASGOR` |  |  |
| Vacuumania (1984)(PSS) | VACUUMAN.CAS | Yes | `CASGOR` |  |  |
| Valkyr (1985)(Gremlin Graphics Software) | VALKYR.CAS | Yes | `CASGOI /S` |  |  |
| Vampire (1987)(Codemasters) | VAMPIRE.CAS | Yes | `CASGOR` |  |  |
| Vampire's Empire (1988)(Dro Soft)(es) | VAMPIDRO.CAS | Yes | `CASGOI /S` |  |  |
| Vampire's Empire (1988)(Dro Soft)(es) | VAMPIRES.CAS | Yes | `CASGOI /S` |  |  |
| Vampire(1987)(Codemasters) | VAMPIR87.CAS | Yes | `CASGOR` |  |  |
| Vampire(1987)(Codemasters) | VAMPIREA.CAS | Yes | `CASGOR` |  |  |
| Vampiro (1987)(Manhattan Transfer)(es) | VAMPIRO.CAS | Yes | `CASGOI` |  |  |
| Vegetable Crash (HoneyBee Soft) (Hudson Soft) (Japan) | VEGETABL.CAS | Yes | `CASGOR` |  |  |
| Vestron (1986)(Players Software) | VESTRON.CAS | Yes | `CASGOR` |  |  |
| Vestron (1986)(Players Software) | VESTRONA.CAS | Yes | `CASGOR` |  |  |
| Viaje al Centro de la Tierra (1989)(Topo Soft)(es) | VIAJE-AL.CAS | Yes | `CASGOI /S` |  |  |
| Viaje por Europa (19xx)(Mind Games Espana)(es) | VIAJE-PO.CAS | Yes | `CASGOR` |  |  |
| Vicious Viper (1985)(Sanyo) | VICIOUS.CAS | Yes | `CASGOR` |  |  |
| Vicious Viper (1985)(Sanyo) | VICIOUS2.CAS | Yes | `CASGOR` |  |  |
| Vicious Viper (1985)(Sanyo) | VICIOUSA.CAS | Yes | `CASGOR` |  |  |
| Video Poker (1986)(Disprosoft) | VIDEORUN.CAS | Yes | `CASGOR` |  |  |
| Video Poker (1986)(Mastertronic) | VIDEO-PO.CAS | Yes | `CASGOI /B` |  |  |
| Vilzam - Cosmic Struggle (1985) (Yuichi Toyama) | VILZAM.CAS | Yes | `CASGOR` |  |  |
| Vilzam - Cosmic Struggle (1985) (Yuichi Toyama)(en) | VILZAMEN.CAS | Yes | `CASGOR` |  |  |
| Virus LQP-79 (2018) (Pentacour) | VIRUS-LQ.CAS | Yes | `CASGOR /B` |  |  |
| Voidrunner (1987)(Mastertronic Added Dimension) | VOIDRUNN.CAS | Yes | `CASGOR` |  |  |
| Volguard (1985)(dB-Soft) | VOLGUARD.CAS | Yes | `CASGOR` |  |  |
| Volguard (1985)(dB-Soft)-patched | VOLGUADB.CAS | Yes | `CASGOR` |  |  |
| Vortex Raider (1988)(Eurosoft) | VORTEX.CAS | Yes | `CASGOR /CB` |  |  |
| Vortex Raider (1988)(Eurosoft) | VORTEXA.CAS | Yes | `CASGOR /CB` |  |  |
| W Series 1 (1983) (Hudson Soft) | W-SERIE1.CAS | Yes | `CASGOR` |  |  |
| W Series 2 (1983) (Hudson Soft) | W-SERSEA.CAS | Yes | `CASGOI /C` |  |  |
| W Series 3 (1983) (Hudson Soft) | W-SERIEA.CAS | Yes | `CASGOI /C` |  |  |
| W Series 4 (1983) (Hudson Soft)( Side A - Super Doors) | W-SERIES.CAS | Yes | `CASGOR` |  |  |
| W Series 5 (1983) (Hudson Soft)(Side A - Submarine Shooter, Gunman). | W-SERIE5.CAS | Yes | `CASGOR` |  |  |
| Wall, The (1987)(Erbe Software) | WALL-THE.CAS | Yes | `CASGOR` |  |  |
| Wallball (19xx)(Tynesoft) | WALLBALA.CAS | Yes | `CASGOR` |  |  |
| Wallball (19xx)(Tynesoft) | WALLBALL.CAS | Yes | `CASGOR` |  |  |
| Wamp Cola (1988)(Iber Soft)(es) | WAMP-COL.CAS | Yes | `CASGOR` |  |  |
| War Chess (1986)(Idealogic)(es) | WAR-CHES.CAS | Yes | `CASGOR` |  |  |
| War in Middle Earth (1989)(Dro Soft)(es) | WAR-IN.CAS | Yes | `CASGOI /S` |  |  |
| Warp & Warp (1984)(Bug-Byte Software) | WARP-WAR.CAS | Yes | `CASGOR /N` |  |  |
| WATSON1 | WATSON-1.CAS | Yes | `CASGOR` |  |  |
| WEC Le Mans (1988)(Imagine Software) | WEC-LE.CAS | Yes | `CASGOI /CB` |  |  |
| WEC Le Mans (1988)(Imagine Software) | WEC-LEA.CAS | Yes | `CASGOI /CB` |  |  |
| Wells & Fargo (1988)(Topo Soft)(es) | WELLS-FA.CAS | Yes | `CASGOI /S` |  |  |
| West Bank (1989)(Dinamic Software)(es) | WEST-BAA.CAS | Yes | `CASGOI /S` |  |  |
| West Bank (1989)(Dinamic Software)(es) | WEST-BAN.CAS | Yes | `CASGOI /S` |  |  |
| Who Dares Wins II (1986)(Alligata Software) | WHO-DARE.CAS | Yes | `CASGOR` |  |  |
| Wild Cat (1984)(Nippon Columbia) | WILD-CAT.CAS | Yes | `CASGOR` |  |  |
| Wing Man (1985)(Enix)(ja)(Side A) | WING-MAA.CAS | Yes | `CASGOR` |  |  |
| Winter Events (1987)(Anco Software) | WINTER87.CAS | Yes | `CASGOR` |  |  |
| Winter Olympics (1986)(Tynesoft)(Side A) | WINTERUN.CAS | Yes | `CASGOR` |  |  |
| Winterhawk (1988)(Eurosoft) | WINTER88.CAS | Yes | `CASGOR /CB` |  |  |
| Winterhawk (1988)(Eurosoft) | WINTERHA.CAS | Yes | `CASGOR /CB` |  |  |
| Wizard's Lair (1986)(Bubblebus Software)(M3) | WIZARD.CAS | Yes | `CASGOI` |  |  |
| Wizard's Lair (1986)(Bubblebus Software)(M3) | WIZARDA.CAS | Yes | `CASGOI` |  |  |
| Word Pro v2.60 (1985)(Kuma Computers) | WORD-PRO.CAS | Yes | `CASGOR` |  |  |
| World Cup Soccer (1986)(Eaglesoft) | WORLD-CU.CAS | Yes | `CASGOR /CB` |  |  |
| World Cup Soccer (1986)(Eaglesoft) | WORLDA.CAS | Yes | `CASGOR /CB` |  |  |
| World Games (1987)(US Gold)(Side A) | WORLD-GA.CAS | Yes | `CASGOR /N` |  |  |
| World Map Software For Color Plotter Printer (1985)(Matsushita Electric Industrial)(Side A) | WORLD-MA.CAS | Yes | `CASGOR` |  |  |
| Worry (1985)(Microcabin) | WORRY.CAS | Yes | `CASGOR` |  |  |
| Wreck, The (1984)(Electric Software) | WRECK-TH.CAS | Yes | `CASGOR` |  |  |
| Wrestling (198x)(Grupo de Trabajo Software) | WRESTLIN.CAS | Yes | `CASGOR` |  |  |
| X-Racing (2019)(Brain Games)(v1.0) | X-RACING.CAS | Yes | `CASGOR` |  |  |
| X-Racing (2019)(Brain Games)(v1.0.1) | X-RACINR.CAS | Yes | `CASGOR` |  |  |
| X-Racing (2019)(Brain Games)(v1.0.2) | X-RACINV.CAS | Yes | `CASGOR` |  |  |
| X-Racing (2019)(Brain Games)(v1.0.3) | X-RACIN3.CAS | Yes | `CASGOR` |  |  |
| X-Racing (2019)(Brain Games)(v1.0.4) | X-RACIN4.CAS | Yes | `CASGOR` |  |  |
| X-Spellunker (2017) | X-SPELLU.CAS | Yes | `CASGOR` |  |  |
| X-Spelunker (2017)(Brain Games)(v1.4.2) | X-SPELUN.CAS | Yes | `CASGOR` |  |  |
| Xenon (1988)(Dro Soft)(es) | XENON.CAS | Yes | `CASGOI /S` |  |  |
| Xenon(1988)(Melbourne House) | XENONEN.CAS | Yes | `CASGOI /B` |  |  |
| Xybots (1989)(Domark) | XYBOTS.CAS | Yes | `CASGOI /S` |  |  |
| Xybots (1989)(Domark) | XYBOTSA.CAS | Yes | `CASGOI /S` |  |  |
| Xyxolog. Xyzolog (1985)(Electric Software) | XYXOLOG.CAS | Yes | `CASGOR` |  |  |
| Xyxolog. Xyzolog (1985)(Electric Software) | XYXOLOGA.CAS | Yes | `CASGOR` |  |  |
| Xyzolog (Electric Software) (Aackosoft) (Side 1) | XYZOLOG.CAS | Yes | `CASGOR` |  |  |
| Yazzie (2019) (Retrosouls) | YAZZIE.CAS | Yes | `CASGOR` |  |  |
| Yazzie MSX Remix (2020) (Retrosouls) | YAZZIMSX.CAS | Yes | `CASGOR` |  |  |
| Yie Ar Kung Fu | YIE-AR.CAS | Yes | `CASGOR` |  |  |
| Yie Ar Kung Fu II | YIE-ARII.CAS | Yes | `CASGOR` |  |  |
| Yo Calculo (1986)(Anaya Multimedia)(es) | YO-CALCU.CAS | Yes | `CASGOR` |  |  |
| Zakil Wood (1985)(Mr. Micro) | ZAKIL-WO.CAS | Yes | `CASGOR /C` |  |  |
| Zalbar 2784 (1985)(Login Soft) | ZALBAR.CAS | Yes | `CASGOR` |  |  |
| Zanac (1987)(Eaglesoft) | ZANAC.CAS | Yes | `CASGOI /CB` |  |  |
| Zarth (1985)(Enix)(ja)(Side A) | ZARTH.CAS | Yes | `CASGOR` |  |  |
| Zaxxon (1985)(Electric Software) | ZAXXON.CAS | Yes | `CASGOR` |  |  |
| Zero Fighter (1984)(Hudson Soft) | ZERO-FIG.CAS | Yes | `CASGOR` |  |  |
| Zexas (1984)(dB-Soft) | ZEXAS.CAS | Yes | `CASGOR` |  |  |
| Zipi y Zape (1989)(Dro Soft)(es)(Side A) | ZIPI-Y.CAS | Yes | `CASGOR` |  |  |
| Zoids - The Battle Begins (1985)(Martech Games) | ZOIDS-TH.CAS | Yes | `CASGOR` |  |  |
| Zombie Calavera Prologue (2021) (conv Nanochess) | ZOMBIE.CAS | Yes | `CASGOR` |  |  |
| Zona 0 (1991)(Topo Soft)(es) | ZONA-0.CAS | Yes | `CASGOI /S` |  |  |
| Zond (1988)(Iber Soft)(es) | ZOND.CAS | Yes | `CASGOR` |  |  |
| Zoot (1986)(Bug-Byte Software) | ZOOT.CAS | Yes | `CASGOR` |  |  |
