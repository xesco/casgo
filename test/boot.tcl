# Boots the test machine from the CASGO disk image, runs CASGO at the DOS
# prompt and writes PASS or FAIL, then the screen text, to a result file.
#
# The Makefile passes in the environment: CASGO_DISK, the disk image or folder;
# CASGO_DRIVE, the openMSX command that inserts it (hda for the IDE, diska for
# the floppy); CASGO_IRAM, 1 when the machine has internal RAM in a slot of its
# own; CASGO_LOW, 1 when that RAM's slot is below the mapper's; CASGO_CASE, the
# case to run; and CASGO_RESULT, the result file.
# Times are emulated seconds, which pass quickly because the throttle is off.

set renderer none
set throttle off
set mute on

# The disk can only change while the machine is off.
set power off
$env(CASGO_DRIVE) $env(CASGO_DISK)
set power on

proc finish {verdict} {
    set f [open $::env(CASGO_RESULT) w]
    puts $f $verdict
    puts $f [join [screen_lines] "\n"]
    close $f
    exit
}

# Calls next once a screen line equals line, or finishes with FAIL after
# timeout emulated seconds. Screen lines are compared without the spaces of the
# screen's margins. get_screen reads text modes only, so while the screen is in
# a graphics mode (the MSX2 boot logo) there are no lines yet.
proc screen_lines {} {
    if {[catch {get_screen} text]} {
        return {}
    }
    lmap l [split $text "\n"] {string trim $l}
}

proc wait_for_line {line timeout next} {
    if {$line in [screen_lines]} {
        eval $next
    } elseif {$timeout <= 0} {
        finish "FAIL: no line \"$line\" on the screen"
    } else {
        after time 0.5 [list wait_for_line $line [expr {$timeout - 0.5}] $next]
    }
}

# The steps of each case: a command typed at the A> prompt and the line it must
# print, and for the R and I variants the line they print instead on a machine
# without internal RAM (CASGO_IRAM is 0), and for the detector the line it prints
# instead on a machine whose internal RAM is below the mapper (CASGO_LOW is 1).
# In the bin case the error cases come first, because each one returns to the
# prompt; every case ends with a load, which ends in BASIC, or with the error of
# a machine without internal RAM.
# SKEWED.CAS has its headers at offsets that are not multiples of 8; its program
# prints BIN OK only if CASGO's CLEAR left HIMEM at F380h. A step with no command
# waits for one more line of the command before it.
set no_iram    "No internal RAM"
set no_iram_p0 "No internal RAM with RAM in page 0"
set cases [subst {
    bin {
        {"CASGOM"              "Usage: CASGOM \[/CNSB\] FILE.CAS"}
        {"CASGOM /X SKEWED.CAS" "Unknown option: /X"}
        {"CASGOM NOFILE.CAS"   "Cannot open: NOFILE.CAS"}
        {"CASGOM NOHDR.CAS"    "No tape header: NOHDR.CAS"}
        {"CASGOM BADTYPE.CAS"  "Unknown file type: BADTYPE.CAS"}
        {"CASGOM BIG.CAS"      "Not enough memory: BIG.CAS"}
        {"CASGOM SKEWED.CAS"   "BIN OK"}
    }
    binr {
        {"CASGOR SKEWED.CAS"   "BIN OK"      "$no_iram"}
    }
    bini {
        {"CASGOI SKEWED.CAS"   "BIN OK"      "$no_iram_p0"}
    }
    bint {
        {"CASGOT SKEWED.CAS"   "BIN OK"      "$no_iram_p0"}
    }
    bas {
        {"CASGOM BASOK.CAS"    "BAS OK"}
    }
    asc {
        {"CASGOM ASCOK.CAS"    "ASC OK"}
    }
    im2 {
        {"CASGOM IM2.CAS"      "IM2 OK"}
    }
    stub {
        {"CASGOM /S STUB.CAS"     "STUB OK"}
    }
    stubr {
        {"CASGOR /S STUB.CAS"     "STUB OK"     "$no_iram"}
    }
    next {
        {"CASGOM /C NEXT.CAS"     "NEXT OK"}
    }
    nextr {
        {"CASGOR /C NEXT.CAS"     "NEXT OK"     "$no_iram"}
    }
    nexti {
        {"CASGOI /C NEXT.CAS"     "NEXT OK"     "$no_iram_p0"}
    }
    nextt {
        {"CASGOT /C NEXT.CAS"     "NEXT OK"     "$no_iram_p0"}
    }
    stubt {
        {"CASGOT /S STUB.CAS"     "STUB OK"     "$no_iram_p0"}
    }
    pardt {
        {"CASGOT /B PARD.CAS"     "PARD OK"     "$no_iram_p0"}
    }
    namco {
        {"CASGOM /N NAMCO.CAS"    "NAMCO OK"}
    }
    pard {
        {"CASGOM /B PARD.CAS"     "PARD OK"}
    }
    short {
        {"CASGOM /B SHORT.CAS"    "SHORT OK"}
    }
    tapd {
        {"CASGOM TAPD.CAS"     "TAPIN D OK"}
    }
    stubhl {
        {"CASGOM /S STUBHL.CAS"   "STUB HL OK"}
    }
    cs {
        {"CASGOM /CS STUB.CAS"    "STUB OK"}
    }
    cb {
        {"CASGOM /CB CB.CAS"      "NEXT OK"}
    }
    drop {
        {"CASGOM /B DROP.CAS"     "BIN OK"}
    }
    hook {
        {"CASGOM /B HOOK.CAS"     "HOOK OK"}
    }
    exptbl {
        {"CASGOM /B EXPTBL.CAS"   "EXPTBL OK"}
    }
    slots {
        {"CASGOM /B SLOTS.CAS"    "SLOTS OK"}
    }
    detect {
        {"CASGO"                "Usage: CASGO \[/CASES\] FILE.CAS"}
        {"CASGO /X SKEWED.CAS"  "Unknown option: /X"}
        {"CASGO /CNS SKEWED.CAS" "Unknown option: /CNS"}
        {"CASGO NOFILE.CAS"     "Cannot open: NOFILE.CAS"}
        {"CASGO NOHDR.CAS"      "No tape header: NOHDR.CAS"}
        {"CASGO SKEWED.CAS"     "SKEWED.CAS: CASGOR"  "SKEWED.CAS: CASGOM"}
        {""                     "BIN OK"}
    }
    dnext {
        {"CASGO NEXT.CAS"       "NEXT.CAS: CASGOR /C"    "NEXT.CAS: CASGOM /C"}
        {""                     "NEXT OK"}
    }
    dnamco {
        {"CASGO NAMCO.CAS"      "NAMCO.CAS: CASGOI /N"   "NAMCO.CAS: CASGOM /N"}
        {""                     "NAMCO OK"}
    }
    dstub {
        {"CASGO STUB.CAS"       "STUB.CAS: CASGOI /S"    "STUB.CAS: CASGOM /S"}
        {""                     "STUB OK"}
    }
    dstubhl {
        {"CASGO STUBHL.CAS"     "STUBHL.CAS: CASGOI /S"  "STUBHL.CAS: CASGOM /S"}
        {""                     "STUB HL OK"}
    }
    dforce {
        {"CASGO /SR STUB.CAS"   "STUB.CAS: CASGOR /S"  "STUB.CAS: CASGOR /S"}
        {""                     "STUB OK"     "$no_iram"}
    }
    dknown {
        {"CASGO KNOWN.CAS"      "KNOWN.CAS: CASGOM /B" "KNOWN.CAS: CASGOM /B"}
        {""                     "BIN OK"}
    }
    dknownb {
        {"CASGO KNOWNB.CAS"     "KNOWNB.CAS: CASGOM /S" "KNOWNB.CAS: CASGOM /S"}
        {""                     "BIN OK"}
    }
    dcaslink {
        {"CASGO CASLINK.CAS"    "CASLINK.CAS: CASGOI"   "CASLINK.CAS: CASGOM"}
        {""                     "CASLINK OK"}
    }
    dpatch {
        {"CASGO PATCH.CAS"      "PATCH.CAS: CASGOM /P1" "PATCH.CAS: CASGOM /P1"}
        {""                     "BIN OK"}
    }
    dpard {
        {"CASGO PARD.CAS"       "PARD.CAS: CASGOR /B"    "PARD.CAS: CASGOM /B"}
        {""                     "PARD OK"}
    }
    dcb {
        {"CASGO CB.CAS"         "CB.CAS: CASGOR /CB"     "CB.CAS: CASGOM /CB"}
        {""                     "NEXT OK"}
    }
    ddrop {
        {"CASGO DROP.CAS"       "DROP.CAS: CASGOR /B"    "DROP.CAS: CASGOM /B"}
        {""                     "BIN OK"}
    }
    dhook {
        {"CASGO HOOK.CAS"       "HOOK.CAS: CASGOI /B"    "HOOK.CAS: CASGOM /B"}
        {""                     "HOOK OK"}
    }
    dslots {
        {"CASGO SLOTS.CAS"      "SLOTS.CAS: CASGOR /B"   "SLOTS.CAS: CASGOM /B"   "SLOTS.CAS: CASGOI /B"}
        {""                     "SLOTS OK"}
    }
    dmodule {
        {"CASGO MODULE.CAS"     "MODULE.CAS: CASGOM"  "MODULE.CAS: CASGOM"}
        {""                     "MODULE OK"}
    }
    dsydney {
        {"CASGO SYDNEY.CAS"     "SYDNEY.CAS: CASGOM"  "SYDNEY.CAS: CASGOM"}
        {""                     "SYDNEY OK"}
    }
    dlevel9 {
        {"CASGO LEVEL9.CAS"     "LEVEL9.CAS: CASGOT"  "LEVEL9.CAS: CASGOM"}
        {""                     "LEVEL9 OK"}
    }
    dpage21 {
        {"CASGO PAGE21.CAS"     "PAGE21.CAS: CASGOT"  "PAGE21.CAS: CASGOM"}
        {""                     "PAGE21 OK"}
    }
    dpage1 {
        {"CASGO PAGE1.CAS"      "PAGE1.CAS: CASGOT"   "PAGE1.CAS: CASGOM"}
        {""                     "PAGE1 OK"}
    }
    dexptbl {
        {"CASGO EXPTBL.CAS"     "EXPTBL.CAS: CASGOR /B"  "EXPTBL.CAS: CASGOM /B"}
        {""                     "EXPTBL OK"}
    }
    dslot3 {
        {"CASGO SLOT3.CAS"      "SLOT3.CAS: CASGOR"   "SLOT3.CAS: CASGOM"}
        {""                     "SLOT3 OK"}
    }
    ddown {
        {"CASGO DOWN.CAS"       "DOWN.CAS: CASGOR"    "DOWN.CAS: CASGOM"    "DOWN.CAS: CASGOI"}
        {""                     "DOWN OK"}
    }
    dup {
        {"CASGO UP.CAS"         "UP.CAS: CASGOI"      "UP.CAS: CASGOM"      "UP.CAS: CASGOR"}
        {""                     "UP OK"}
    }
    dshift {
        {"CASGO SHIFT.CAS"      "SHIFT.CAS: CASGOR"   "SHIFT.CAS: CASGOM"}
        {""                     "SHIFT OK"}
    }
}]

# Runs the steps from the first one, each once the prompt is back.
proc run_steps {steps} {
    if {$steps eq {}} {
        finish_cleared
        return
    }
    lassign [lindex $steps 0] command expected no_iram low
    if {$no_iram ne "" && !$::env(CASGO_IRAM)} {
        set expected $no_iram
    }
    if {$low ne "" && $::env(CASGO_LOW)} {
        set expected $low
    }
    if {$command eq ""} {
        # The same command goes on: only the next line to wait for.
        wait_for_line $expected 30 [list run_steps [lrange $steps 1 end]]
    } else {
        wait_for_line "A>" 60 [list type_and_check $command $expected [lrange $steps 1 end]]
    }
}

proc type_and_check {command expected rest} {
    type "$command\r"
    wait_for_line $expected 30 [list run_steps $rest]
}

# Passes if CASGO's CLS removed the line that called stage 2.
proc finish_cleared {} {
    if {"DEFUSR=&HA000:A=USR(0)" in [screen_lines]} {
        finish "FAIL: the screen was not cleared"
    } else {
        finish PASS
    }
}

run_steps [dict get $cases $env(CASGO_CASE)]
