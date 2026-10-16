# Boots the test machine from the games disk, runs CASGO on one game, and writes
# one verdict line to the result file.
#
# It waits until the load is over: until CASGO's tape routines have had no call for
# 10 emulated seconds, as in the cassette player's runs below, or 600 seconds have
# passed. Some loaders pause between their parts for more than 5 seconds, and keys
# pressed then judged the screen of a load that had not ended. Loaders that read the
# tape from BASIC, byte by byte, take minutes. When a tape call comes during the key
# presses below, the load had only paused, and it waits again. Then it reads video
# RAM and presses keys as a person would: it holds space down for 0.2 seconds and
# reads video RAM 2 seconds later, up to 3 times, then does the same with "1", which
# starts many games from their menu. The presses stop when video RAM changes. The
# verdict is the first of these that holds:
#
#   ERROR <line>   an error from BASIC, CASGO or the loader is on the screen
#   RESET          a line starts with DOS's A>: the game reset the machine
#   ROMHANG        page 0 is slot 0, the BIOS ROM, and the PC is in its tape code
#                  (19DDh-1B44h) or BREAKX (046Fh-047Fh): a tape call reached the
#                  ROM's own tape routines
#   BASIC          BASIC's prompt, with its function key line, is on the screen
#   TAPELOOP       the game still called the tape routines after 600 seconds: it
#                  reads past the end of the file, or waits for another side
#   RUNS           video RAM changed during the key presses: the game runs
#   STATIC         video RAM never changed: a game that froze, or a load that
#                  stopped on its loading screen
#
# Each verdict ends with the CPU's state (PC, the primary slot register, the four
# mapper registers) and the number of tape calls.
#
# The Makefile passes in the environment: CASGO_DISK, the disk image; CASGO_GAME,
# what follows CASGO on the command line; and CASGO_RESULT, the result file.
# CASGO_PROGRAM, when set, is the program typed instead of CASGO, the detector:
# a variant such as CASGOSR. CASGO_SCREEN, when set, names the files that keep
# the screen at the end of the load (save_screen, below).
# Times are emulated seconds, which pass quickly because the throttle is off.
#
# With CASGO_TAPE, the machine has no disk and openMSX's cassette player holds the
# CAS file (-cassetteplayer): at BASIC's Ok the script types CASGO_TAPE, the load
# command, and after CLOAD it types RUN. This measures the tapes on a cassette
# machine. Every call of TAPION and TAPIN counts, the load may take up to 1800
# seconds, and it is over after the same 10 seconds without a call, which the ROM's
# TAPION needs to wait through the tape's silence and leader. There is no ROMHANG,
# because the ROM's tape code is where a cassette machine loads.

set renderer none
set throttle off
set mute on

set tape [info exists env(CASGO_TAPE)]
set limit [expr {$tape ? 1800 : 600}]
set quiet 10

# The disk can only change while the machine is off.
if {!$tape} {
    set power off
    hda $env(CASGO_DISK)
    set power on
}

set calls 0             ;# calls of CASGO's TAPION and TAPIN
set last_call 0         ;# the emulated time of the last one
set start 0             ;# the emulated time CASGO was typed
set keys 0              ;# the emulated time of the last key presses

proc now {} { machine_info time }

# Counts a call of TAPION or TAPIN in CASGO's tape code. The ROM's own entry jumps
# to 1ABCh, CASGO's to its own routine, which tells the two apart in any slot.
proc tape_call {} {
    if {!$::tape && [debug read memory 0x00E5] + 256 * [debug read memory 0x00E6] == 0x1ABC} return
    incr ::calls
    set ::last_call [now]
}

# Writes the verdict and ends openMSX. openMSX's exit takes effect only after
# the current command, so every call is followed by a return.
proc finish {verdict} {
    set mappers {}
    foreach port {0xFC 0xFD 0xFE 0xFF} {
        lappend mappers [format %02X [debug read ioports $port]]
    }
    set state [format "pc=%04X a8=%02X" [reg pc] [debug read ioports 0xA8]]
    set f [open $::env(CASGO_RESULT) w]
    puts $f "$verdict\t$state mappers=[join $mappers ,] calls=$::calls"
    close $f
    exit
}

# The screen's lines without the margins' spaces, or "graphics" when the screen
# is not in a text mode, which get_screen cannot read.
proc screen_lines {} {
    if {[catch {get_screen} text]} {
        return graphics
    }
    lmap l [split $text "\n"] {string trim $l}
}

proc vram {} { debug read_block VRAM 0 0x4000 }

# Waits for the load to end, then starts the key presses.
proc wait_load {} {
    set t [now]
    if {"A>" in [screen_lines] && $t - $::start > 5} {
        verdict 0
        return
    }
    if {($::calls > 0 && $t - $::last_call >= $::quiet) || $t - $::start >= $::limit} {
        set ::v0 [vram]
        save_screen
        set ::keys $t
        press space 1
        return
    }
    after time 1 wait_load
}

# With CASGO_SCREEN, saves the screen at the end of the load, before the key
# presses, and again if the load only paused, for tools/screens.py:
# CASGO_SCREEN.vram holds video RAM, and CASGO_SCREEN.regs the VDP registers 0
# to 7 on one line.
proc save_screen {} {
    if {![info exists ::env(CASGO_SCREEN)]} return
    set f [open $::env(CASGO_SCREEN).vram wb]
    fconfigure $f -translation binary
    puts -nonewline $f $::v0
    close $f
    set f [open $::env(CASGO_SCREEN).regs w]
    puts $f [lmap r {0 1 2 3 4 5 6 7} {debug read {VDP regs} $r}]
    close $f
}

# The keyboard matrix row and bit of each key that the script presses.
array set key_matrix {space {8 0x01} 1 {0 0x02}}

# Holds the key down for 0.2 seconds, as a person presses it, so that a game
# that scans the keyboard now and then still sees it, then looks 2 seconds
# later whether video RAM changed. Space is pressed up to 3 times, then "1" up
# to 3 times, and the first change ends the presses.
proc press {key try} {
    lassign $::key_matrix($key) row mask
    keymatrixdown $row $mask
    after time 0.2 [list keymatrixup $row $mask]
    after time 2 [list pressed $key $try]
}

proc pressed {key try} {
    if {$::last_call > $::keys || [vram] ne $::v0} {
        verdict 1
    } elseif {$try < 3} {
        press $key [expr {$try + 1}]
    } elseif {$key eq "space"} {
        press 1 1
    } else {
        verdict 0
    }
}

proc verdict {changed} {
    set lines [screen_lines]
    if {$lines ne "graphics"} {
        set lines [lsearch -all -inline -not $lines ""]
        foreach l $lines {
            if {[string match -nocase "*error" $l] || [string match -nocase "*error in *" $l]
                    || [string match "Cannot open:*" $l]
                    || [string match "No tape header:*" $l] || [string match "Unknown *" $l]
                    || [string match "Not enough memory*" $l] || [string match "No mapper*" $l]} {
                # A screen can hold character codes that get_screen passes on as
                # line breaks or tabs, which would split the TSV line.
                finish "ERROR [string map {"\n" " " "\r" " " "\t" " "} [string range $l 0 39]]"
                return
            }
        }
    }
    # The keys pressed after the load follow the prompt: "A> 1".
    if {$lines ne "graphics" && [lsearch -glob $lines "A>*"] >= 0} {
        finish RESET
        return
    }
    set pc [reg pc]
    if {!$::tape && ([debug read ioports 0xA8] & 3) == 0
            && (($pc >= 0x19DD && $pc <= 0x1B44) || ($pc >= 0x046F && $pc <= 0x047F))} {
        finish ROMHANG
        return
    }
    if {$lines ne "graphics" && [lsearch -glob $lines "color*auto*goto*list*run*"] >= 0} {
        finish BASIC
        return
    }
    if {$::last_call > $::keys && $::keys > 0} {
        # The tape was read again after the keys: the load had only paused.
        # Wait for it to end, up to the time limit.
        if {[now] - $::start < $::limit} {
            after time 1 wait_load
            return
        }
        finish TAPELOOP
        return
    }
    if {$changed} {
        finish RUNS
        return
    }
    finish STATIC
}

proc wait_for_prompt {timeout} {
    if {"A>" in [screen_lines]} {
        set program [expr {[info exists ::env(CASGO_PROGRAM)] ? $::env(CASGO_PROGRAM) : "CASGO"}]
        type "$program $::env(CASGO_GAME)\r"
        set ::start [now]
        debug set_bp 0x00E1 {} tape_call
        debug set_bp 0x00E4 {} tape_call
        after time 3 wait_load
    } elseif {$timeout <= 0} {
        finish "ERROR no A> prompt"
    } else {
        after time 0.5 [list wait_for_prompt [expr {$timeout - 0.5}]]
    }
}

# Cassette mode: waits for an Ok line below the ones seen, then types the line.
proc wait_for_ok {line seen then timeout} {
    set oks [llength [lsearch -all [screen_lines] "Ok"]]
    if {$oks > $seen} {
        type "$line\r"
        if {$::start == 0} {
            set ::start [now]
            debug set_bp 0x00E1 {} tape_call
            debug set_bp 0x00E4 {} tape_call
        }
        if {$then ne ""} {
            after time 2 [list wait_for_ok $then $oks "" $::limit]
        } else {
            after time 3 wait_load
        }
    } elseif {$timeout <= 0} {
        finish "ERROR no Ok prompt"
    } else {
        after time 0.5 [list wait_for_ok $line $seen $then [expr {$timeout - 0.5}]]
    }
}

if {$tape} {
    if {$env(CASGO_TAPE) eq "CLOAD"} {
        wait_for_ok CLOAD 0 RUN 60
    } else {
        wait_for_ok $env(CASGO_TAPE) 0 "" 60
    }
} else {
    wait_for_prompt 60
}
