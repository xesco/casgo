#!/bin/sh
# Starts a CAS file with CASGO in openMSX, for you to play or look at.
#
# Usage: tools/try.sh [--mfrsd] FILE.CAS [VARIANT]
#        tools/try.sh --tape FILE.CAS
#
# Builds CASGO, puts its detector and variants on a disk image with Nextor,
# COMMAND2 and the CAS file, and starts openMSX on a Philips VG-8020 (MSX1) with a
# Carnivore2, the machine CASGO is tested on. Once Nextor's A> prompt shows, it
# types CASGO and the file, so the detector picks the variant; with VARIANT, such
# as CASGOSR, it types that variant instead. The CAS file keeps its name when it
# is a DOS 8.3 name, and is GAME.CAS otherwise. openMSX uses your own settings
# and system ROMs, which must hold the VG-8020's and the Carnivore2's.
#
# With --mfrsd, a MegaFlashROM SCC+ SD with Nextor 2.1.4 replaces the
# Carnivore2. The cartridge is the openMSX extension that the corpus runs use
# (emu/casgo_mfrsd.xml). openMSX loads an extension only from its home folder,
# so openMSX runs with the home in build/openmsx-home that the tests use, and
# your own settings do not apply. That home links to your system ROMs. Each try
# starts from the flash that the extension installs.
#
# With --tape, it starts the VG-8020 alone instead, with no Carnivore2, no disk
# and no CASGO, and puts the CAS file in openMSX's cassette player, which types
# the load command: the game loads as from a cassette, for comparison.
set -eu

usage="usage: tools/try.sh [--tape | --mfrsd] FILE.CAS [VARIANT]"
tape=no
mfrsd=no
case "${1:-}" in
    --tape) tape=yes; shift ;;
    --mfrsd) mfrsd=yes; shift ;;
esac
[ $# -ge 1 ] || { echo "$usage"; exit 1; }
cas=$1
shift
[ -f "$cas" ] || { echo "error: $cas: no such file"; exit 1; }
cas=$(cd "$(dirname "$cas")" && pwd)/$(basename "$cas")

cd "$(dirname "$0")/.."
if [ $tape = yes ]; then
    [ $# -eq 0 ] || { echo "error: --tape takes no variant"; exit 1; }
    # The load command for the first file's type, as CASGO picks it.
    load=$(python3 -I -c '
import sys
d = open(sys.argv[1], "rb").read(256 + 18)
i = d.find(bytes.fromhex("1FA6DEBACC137D74"))
t = d[i + 8] if i >= 0 and len(d) >= i + 18 else 0
print({0xD0: "BLOAD\"CAS:\",R", 0xD3: "CLOAD", 0xEA: "RUN\"CAS:\""}.get(t, ""))
' "$cas")
    [ -n "$load" ] || { echo "error: $cas: no binary, BASIC or ASCII file at its start"; exit 1; }
    CASGO_LOAD="$load" exec openmsx -machine Philips_VG_8020 -cassetteplayer "$cas" \
        -script tools/tape.tcl
fi
[ $# -le 1 ] || { echo "$usage"; exit 1; }
program=${1:-CASGO}
make -s all dl/NEXTOR.SYS
[ -f "build/$program.COM" ] || { echo "error: no variant build/$program.COM"; exit 1; }

dir=build/try
rm -rf "$dir"
mkdir -p "$dir"
name=$(basename "$cas" | tr '[:lower:]' '[:upper:]')
echo "$name" | grep -Eq '^[A-Z0-9_-]{1,8}\.CAS$' || name=GAME.CAS
cp "$cas" "$dir/$name"
python3 -I tools/mkdisk.py "$dir/try.dsk" dl/NEXTOR.SYS dl/COMMAND2.COM build/CASGO*.COM "$dir/$name"

if [ $mfrsd = yes ]; then
    make -s build/openmsx-home/share/extensions/casgo_mfrsd/hardwareconfig.xml
    rm -rf build/openmsx-home/persistent
    OPENMSX_HOME=$(pwd)/build/openmsx-home CASGO_DISK="$dir/try.dsk" CASGO_COMMAND="$program $name" \
        exec openmsx -machine Philips_VG_8020 -ext casgo_mfrsd -script tools/try.tcl
fi
CASGO_DISK="$dir/try.dsk" CASGO_COMMAND="$program $name" \
    exec openmsx -machine Philips_VG_8020 -ext Carnivore2 -script tools/try.tcl
