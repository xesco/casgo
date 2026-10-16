#!/bin/sh
# Runs CASGO on every .cas file in a folder, on each Nextor test machine, and
# writes one line per game and machine to a TSV file: the machine, the file and
# the verdict of test/game.tcl, with the CPU state at the end.
#
# Usage: test/corpus.sh FOLDER OUT.TSV
#
# Each game gets its own disk, with Nextor, CASGO's detector and variants and the
# game as GAME.CAS, so that games of any size and name fit. The Makefile's corpus
# target sets the environment: CASGO_COMS, NEXTOR_SYS, COMMAND2 (the files for
# the disk),
# OPENMSX_HOME, and MACHINES, a list of "name:machine:extensions" entries in
# which the extensions are separated by commas.

set -eu
folder=$1
out=$2
work=$(dirname "$out")/corpus
mkdir -p "$work"
: > "$out"

for cas in "$folder"/*.cas "$folder"/*.CAS; do
    [ -f "$cas" ] || continue
    cp "$cas" "$work/GAME.CAS"
    python3 -I tools/mkdisk.py "$work/game.dsk" "$NEXTOR_SYS" "$COMMAND2" $CASGO_COMS "$work/GAME.CAS"
    for entry in $MACHINES; do
        name=${entry%%:*}
        rest=${entry#*:}
        machine=${rest%%:*}
        extensions=$(echo "${rest#*:}" | sed 's/,/ -ext /g; s/^/-ext /')
        rm -f "$work/result"
        # openMSX saves the flash of a flash cartridge in the persistent folder of
        # its home, and the next run would start from that copy. Removing the
        # folder makes each run start from the flash that the extension installs.
        rm -rf "$OPENMSX_HOME/persistent"
        CASGO_DISK="$work/game.dsk" CASGO_GAME=GAME.CAS CASGO_RESULT="$work/result" \
            SDL_AUDIODRIVER=dummy perl -e 'alarm 900; exec @ARGV' \
            openmsx -command "set sound_driver null" -machine "$machine" $extensions \
            -script test/game.tcl > "$work/openmsx.log" 2>&1 || true
        verdict=$(cat "$work/result" 2>/dev/null || echo "ERROR no result")
        printf '%s\t%s\t%s\n' "$name" "$(basename "$cas")" "$verdict" | tee -a "$out"
    done
done
