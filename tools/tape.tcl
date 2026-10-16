# Loaded by tools/try.sh --tape, which puts the CAS file in the cassette player.
# At BASIC's Ok, it types the load command in CASGO_LOAD, as on a cassette
# machine without CASGO, for comparison. A tokenized BASIC file gets CLOAD, then
# RUN once the load is over.

proc tape_lines {} {
    if {[catch {get_screen} text]} { return {} }
    lmap l [split $text "\n"] {string trim $l}
}

# Waits for an Ok line below the line count seen, then types the command.
proc tape_type {command seen then tries} {
    set lines [tape_lines]
    set oks [llength [lsearch -all $lines "Ok"]]
    if {$oks > $seen} {
        type "$command\r"
        if {$then ne ""} {
            after time 2 [list tape_type $then $oks "" 600]
        }
    } elseif {$tries > 0} {
        after time 0.5 [list tape_type $command $seen $then [expr {$tries - 1}]]
    }
}

if {$env(CASGO_LOAD) eq "CLOAD"} {
    after time 2 {tape_type CLOAD 0 RUN 120}
} else {
    after time 2 [list tape_type $env(CASGO_LOAD) 0 "" 120]
}
