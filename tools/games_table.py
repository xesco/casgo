#!/usr/bin/env python3
"""Write docs/GAMES.md: for each tape of the corpus, whether CASGO loads it, the
variant that the detector picks, and for a tape that does not load, a code for
why and the cases that load it when CASGO's option forces them.

Usage:
  games_table.py MANIFEST CASES.tsv RUNS SCREENS.tsv CAUSES.tsv OUT.md [CASS [FALSE.tsv [TRUE.tsv]]]

MANIFEST is the corpus's tapes/MANIFEST.TXT (short name, TAB, full title).
CASES.tsv is the output of tools/cases.py: the variant the detector picks for
each tape. RUNS is a folder of corpus runs, RUNS/PROGRAM/FILE/result, each the
verdict of test/game.tcl with PROGRAM typed: CASGO, the detector, or a
variant. SCREENS.tsv holds, for the tapes whose run with CASGO failed the key
test, how CASGO's screen at the end of the load compares with the screen of
openMSX's cassette player (file, then SAME or DIFFERENT in its fourth column).
CAUSES.tsv holds the causes found by investigation (test/causes.tsv). A tape
loads with a program when the run's verdict is RUNS, and with CASGO also when
its screen is the SAME as the cassette player's. A tape with a cause does not
load whatever its run's verdict, because the investigation found a run that
only looked like a load; the exception is T, whose result is a matter of
chance and so is the run's. A tape loads only when it loads
with CASGO, the detector, whose variant is the one a user runs. CASS, a folder of
the cassette player's runs (CASS/FILE/screen and result), lets another variant
count as loading only when its screen at the end of the load is the same as the
cassette player's, whatever its verdict. FALSE.tsv (test/false_runs.tsv) lists the runs of
other variants that investigation found to be no load (file, program, evidence),
which are not offered to run instead. TRUE.tsv (test/true_loads.tsv) lists the
tapes that investigation found loading with CASGO although their screen differs
from the cassette player's, by chance or because one run drew more of it (file,
evidence).
"""
import collections
import importlib.util
import os
import re
import sys

sys.dont_write_bytecode = True
_spec = importlib.util.spec_from_file_location(
    "screens", os.path.join(os.path.dirname(os.path.abspath(__file__)), "screens.py"))
screens = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(screens)

SYMPTOMS = {
    "ROMHANG": "A",
    "RESET": "B",
    "ERROR": "C",
    "BASIC": "D",
    "STATIC": "E",
    "TAPELOOP": "F",
    "UNKNOWN": "G",
}

LEGEND = [
    ("A", "Hangs in the BIOS ROM's tape code: a tape call reached the ROM, which waits for a real cassette"),
    ("B", "Resets the machine, back to the DOS prompt"),
    ("C", "Stops with an error message, from BASIC or from the game's loader"),
    ("D", "Stops at BASIC's prompt"),
    ("E", "Freezes: after the load the screen never changes, a frozen game or a load that stopped on its loading screen"),
    ("F", "Keeps reading the tape after its load: it wants more tape than the file holds, such as a level on the second side, or its loader is still reading after 600 seconds"),
    ("G", "The file does not start with a file CASGO can load, but with a data block"),
    ("H", "A BASIC loader that clears the hooks, or loads with its own copy of BASIC's cassette code, before it reads the tape with the BIOS ROM in page 0"),
    ("I", "Reads the cassette input itself, from the sound chip, where CASGO has no signal: a tool for a real cassette"),
    ("K", "The loader checks its own code, which CASGO changed to redirect the tape calls"),
    ("M", "Expects all its RAM in one slot, as on a cassette machine: it puts the mapper in some pages while its code or data is in the internal RAM, or the reverse, and runs into memory it never wrote, such as text drawn as stripes. CASGO with the memory case `T` forced loads several ([DESIGN.md](DESIGN.md#memory-cases))"),
    ("P", "The game loads into its RAM in page 0, which is CASGO's BIOS copy, and overwrites CASGO's tape code"),
    ("Q", "A stub loader that puts the internal RAM in page 0, where `I` keeps T0, and that the stub's slots cannot take out of page 0 for its tape calls in `R` ([LIMITS.md](LIMITS.md#tapes-that-do-not-load))"),
    ("S", "A stub loader that loads its own code over the byte where CASGO keeps the slot of its BIOS copy, so its later tape calls go astray"),
    ("T", "Loads or fails with any change in CASGO's timing: the result is a matter of chance"),
    ("U", "Runs code at an address that neither the game nor the BIOS writes, which works on the cassette player's machine only with the bytes its RAM holds at power-up ([LIMITS.md](LIMITS.md#tapes-that-do-not-load))"),
    ("W", "A bug in the game's slot code that runs only when a slot other than the cassette machine's has RAM, as the mapper's slot does ([LIMITS.md](LIMITS.md#tapes-that-do-not-load))"),
    ("X", "The loader builds its tape calls in memory, from code it decodes, where CASGO cannot see them"),
]


def verdict(path):
    """The verdict code of a run's result file, or None when there is none."""
    try:
        line = open(path, encoding="utf-8", errors="replace").readline()
    except OSError:
        return None
    text = line.split("\t")[0]
    if text.startswith("ERROR Unknown file type"):
        return "UNKNOWN"
    return text.split(" ")[0] or None


def title(full):
    """The game's title from a corpus file name, without the load hints."""
    t = re.sub(r"\.cas$", "", full, flags=re.I)
    t = re.sub(r"\s*\[[^\]]*\]", "", t)
    return t.replace("|", "/").strip()


def read_tsv(path, value=1):
    """The first column of a TSV file mapped to one of its other columns."""
    result = {}
    for line in open(path, encoding="utf-8", errors="replace"):
        if line.startswith("#") or not line.strip():
            continue
        fields = line.rstrip("\n").split("\t")
        if len(fields) > value:
            result[fields[0]] = fields[value]
    return result


def shown(v, patch=0):
    """The variant and option that CASGO prints for v, letters after CASGO: the
    loader letters and the memory letter, such as CASGOCBR for CASGOR /CB, and
    a known tape's patch number, which follows the letters, P included."""
    loader, memory = v[5:-1], v[-1]
    if patch:
        return f"CASGO{memory} /{loader}{patch}"
    return "CASGO" + memory + ("" if loader == "P" else " /" + loader)


def known_patches(tapes):
    """The patch number that the detector passes for each tape of the folder
    tapes: the entries of tools/known.tsv with patches get the numbers 1, 2 and
    on, in file order, as tools/known.py numbers them, and a tape gets the
    number of the last entry that matches it, as the detector looks them up (0
    for an entry without a patch)."""
    entries = []
    number = 0
    for line in open(os.path.join(os.path.dirname(__file__), "known.tsv")):
        if line.strip() and not line.startswith("#"):
            f = line.rstrip("\n").split("\t")
            n = 0
            if f[5] != "-":
                number += 1
                n = number
            if f[3] == "len":
                vals = tuple(int(v) for v in f[4].split(","))
            else:
                vals = bytes.fromhex(f[4])
            entries.append((f[3], int(f[2]), vals, n))
    header = bytes.fromhex("1FA6DEBACC137D74")
    out = {}
    for name in os.listdir(tapes):
        if not name.endswith(".CAS"):
            continue
        raw = open(os.path.join(tapes, name), "rb").read()
        starts = []
        i = raw.find(header)
        while i >= 0:
            starts.append(i)
            i = raw.find(header, i + 1)
        starts.append(len(raw))
        blocks = [raw[starts[k] + 8:starts[k + 1]] for k in range(len(starts) - 1)][:255]
        lengths = [len(b) for b in blocks]
        found = 0
        for kind, block, vals, n in entries:
            if kind == "len":
                if tuple(lengths[block:block + len(vals)]) == vals:
                    found = n
            elif block < len(blocks) and blocks[block][:8] == vals:
                found = n
        if found:
            out[name] = found
    return out


def main():
    manifest, cases_tsv, runs, screens_tsv, causes_tsv, out = sys.argv[1:7]
    cass = sys.argv[7] if len(sys.argv) > 7 else None
    false_runs = set()
    if len(sys.argv) > 8:
        for line in open(sys.argv[8]):
            if line.strip() and not line.startswith("#"):
                false_runs.add(tuple(line.split("\t")[:2]))
    true_loads = set()
    if len(sys.argv) > 9:
        for line in open(sys.argv[9]):
            if line.strip() and not line.startswith("#"):
                true_loads.add(line.split("\t")[0])

    def same_screen(f, program):
        """Whether the program's screen at the end of the load is the cassette player's."""
        if cass is None or verdict(os.path.join(cass, f, "result")) not in ("RUNS", "STATIC"):
            return False
        if verdict(os.path.join(runs, program, f, "result")) not in ("RUNS", "STATIC"):
            return False
        mine = os.path.join(runs, program, f, "screen")
        theirs = os.path.join(cass, f, "screen")
        if not (os.path.exists(mine + ".vram") and os.path.exists(theirs + ".vram")):
            return False
        return screens.same_fraction(screens.load(theirs), screens.load(mine)) >= screens.THRESHOLD
    patched = known_patches(os.path.dirname(manifest))
    names = read_tsv(manifest)
    picks = read_tsv(cases_tsv, 2)
    same = {f for f, v in read_tsv(screens_tsv, 3).items() if v == "SAME"}
    causes = read_tsv(causes_tsv)
    programs = sorted(p for p in os.listdir(runs) if p != "CASGO")

    rows = []
    counts = collections.Counter()
    for f in sorted(picks):
        detected = verdict(os.path.join(runs, "CASGO", f, "result"))
        if detected is None:
            continue
        pick = picks[f]
        overruled = f in causes and causes[f] != "T"
        if (detected == "RUNS" or f in same or f in true_loads) and not overruled:
            loads, code, instead = "Yes", "", ""
            counts["loads"] += 1
        else:
            loads = "No"
            if f in causes:
                code = causes[f]
            else:
                code = SYMPTOMS.get(detected, "?")
            counts["code " + code] += 1
            # Another variant loads the tape only when its screen at the end of
            # the load is the cassette player's: a RUNS verdict alone was a
            # false load for many of these tapes.
            others = [p for p in programs
                      if (f, p) not in false_runs and same_screen(f, p)]
            # Prefer a variant with the detector's loader case.
            others.sort(key=lambda p: (p[5:-1] != pick[5:-1], p))
            if others:
                instead = others[0]
                counts["other"] += 1
            else:
                instead = ""
                counts["none"] += 1
        rows.append((title(names.get(f, f)), f, loads, shown(pick, patched.get(f, 0)), code,
                     "CASGO /" + instead[5:] if instead else ""))
    rows.sort(key=lambda r: r[0].lower())

    total = len(rows)
    with open(out, "w", encoding="utf-8") as o:
        o.write("# Games\n\n")
        o.write("This page lists each tape of the test corpus, whether CASGO loads it and the\n")
        o.write("variant that CASGO picks for it. For a tape that does not load, it gives a code for\n")
        o.write("why and, where one exists, the command that loads the tape by forcing other cases\n")
        o.write("name. It is for players looking up a game, and for anyone working on CASGO, who can\n")
        o.write("see which kinds of tape still fail. The tapes ran in openMSX on a Philips VG-8020\n")
        o.write("with a Carnivore2, the machine CASGO is tested on, and `tools/games_table.py`\n")
        o.write("writes this page from the runs.\n\n")
        o.write("## How a tape is judged\n\n")
        o.write("Each tape ran with `CASGO`, which picks a variant for it\n")
        o.write("([README.md](../README.md#loading-a-game)), and the tape loads when that variant\n")
        o.write("loads it. A run waits until the load is over, then presses space, and\n")
        o.write("then `1`, which starts many games from their menu. It holds each key down as a\n")
        o.write("person would and presses it up to three times, because a game that is still\n")
        o.write("setting up misses a short press. A tape loads when the screen changes during the\n")
        o.write("key presses (`test/game.tcl`). Many games wait at a menu for a key that is neither\n")
        o.write("space nor `1`, so a tape whose screen does not change ran in openMSX's own\n")
        o.write("cassette player too: it loads when CASGO's screen at the end of the load is the\n")
        o.write("same as the cassette player's, at least 90% of its pixels (`tools/screens.py`).\n")
        o.write("The screen also changes when a game crashes into other code or resets the machine,\n")
        o.write("so a tape whose investigation found such a run does not load, and gets the code of\n")
        o.write("its cause. A tape that did not load ran with the other cases forced too, and the\n")
        o.write("column Run instead names a command whose screen at the end of the load is the\n")
        o.write("same as the cassette player's. A number after the letters, as in `CASGOR /P3`,\n")
        o.write("is a known tape's patch, which changes a few of its bytes as it loads\n")
        o.write("([DESIGN.md](DESIGN.md#the-detector-and-the-variants)).\n")
        o.write("A game whose screen depends on chance, such as one that deals its cards at\n")
        o.write("random, loads when an investigation found it running (`test/true_loads.tsv`).\n")
        o.write("So does a game that draws its menu slowly, when CASGO's run drew more of the\n")
        o.write("menu than the cassette player's run did.\n")
        o.write("The corpus holds side A tapes that openMSX's cassette player loads: a second\n")
        o.write("side needs the first one before it, and a tape whose cassette run ends in an\n")
        o.write("error or at BASIC's prompt cannot be compared, so both are left out.\n\n")
        o.write("## Summary\n\n")
        o.write("The table counts the tapes by result.\n\n")
        o.write("| Result | Tapes |\n|---|---|\n")
        o.write(f"| Loads | {counts['loads']} |\n")
        o.write(f"| Does not load, but CASGO with other cases forced loads it | {counts['other']} |\n")
        o.write(f"| Does not load with any variant | {counts['none']} |\n")
        o.write(f"| All | {total} |\n\n")
        o.write("## Codes\n\n")
        o.write("A tape that does not load gets one code. The codes A to G say what the run with\n")
        o.write("`CASGO` showed, and the codes H to X say why, where an investigation found the\n")
        o.write("cause.\n\n")
        o.write("| Code | Meaning | Tapes |\n|---|---|---|\n")
        for code, meaning in LEGEND:
            if counts["code " + code]:
                o.write(f"| {code} | {meaning} | {counts['code ' + code]} |\n")
        if counts["code ?"]:
            o.write(f"| ? | The run did not finish | {counts['code ?']} |\n")
        o.write("\n## Games\n\n")
        o.write("The table lists the tapes by title.\n\n")
        o.write("| Game | File | Loads | Variant | Code | Run instead |\n|---|---|---|---|---|---|\n")
        for t, f, loads, variant, code, instead in rows:
            i = f"`{instead}`" if instead else ""
            o.write(f"| {t} | {f} | {loads} | `{variant}` | {code} | {i} |\n")


if __name__ == "__main__":
    main()
