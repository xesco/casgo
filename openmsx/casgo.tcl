# Starts CASGO in openMSX on a Philips VG-8020 with a Carnivore2, the machine
# CASGO is tested on. It copies casgo.dsk to work.dsk, adds every CAS file in
# this script's folder to work.dsk, makes work.dsk the Carnivore2's disk and
# starts the Carnivore2's first configuration, which boots Nextor:
#
#   openmsx -machine Philips_VG_8020 -ext Carnivore2 -script casgo.tcl

set casgo_dir [file dirname [file normalize [info script]]]
set casgo_work [file join $casgo_dir work.dsk]
file copy -force [file join $casgo_dir casgo.dsk] $casgo_work

set power off
hda $casgo_work
foreach f [glob -nocomplain -directory $casgo_dir *] {
    # A path goes as a list, so that a space does not split it.
    if {[string match -nocase *.cas $f] && [catch {diskmanipulator import hda [list $f]} err]} {
        puts "casgo.tcl: [file tail $f]: $err"
    }
}
set power on

# The Carnivore2's boot menu: ESC shows its list, and SPACE starts its first
# entry, DefConfig (RAM, IDE, FMPAC, SCC).
proc casgo_press {row mask} {
    keymatrixdown $row $mask
    after time 0.2 [list keymatrixup $row $mask]
}
proc casgo_menu {n} {
    if {[catch {get_screen} s]} { set s "" }
    if {[string match "*DefConfig*" $s]} {
        casgo_press 8 0x01
    } elseif {[string match "*Carnivore 2 MFC*" $s]} {
        casgo_press 7 0x04
        after time 1 [list casgo_menu [expr {$n - 1}]]
    } elseif {$n > 0} {
        after time 0.5 [list casgo_menu [expr {$n - 1}]]
    }
}
after time 1 {casgo_menu 60}
