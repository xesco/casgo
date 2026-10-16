# Loaded by tools/try.sh. Gets the Carnivore2 past its boot menu, as a user does:
# ESC shows the list of configurations, and space starts the selected one,
# DefConfig, the first. A MegaFlashROM SD has no menu and boots straight to DOS.
# Then, at DOS's A> prompt, the script types the command in the environment
# variable CASGO_COMMAND. The machine then runs at normal speed for you to play.
# The disk image is in CASGO_DISK.

# The disk can only change while the machine is off.
set power off
hda $env(CASGO_DISK)
set power on

proc try_screen {} {
    if {[catch {get_screen} text]} { return {} }
    return $text
}

proc try_press {row mask} {
    keymatrixdown $row $mask
    after time 0.2 [list keymatrixup $row $mask]
}

proc try_menu {tries} {
    set screen [try_screen]
    if {[string match "*DefConfig*" $screen]} {
        try_press 8 0x01        ;# space
    } elseif {[string match "*Carnivore 2 MFC*" $screen]} {
        try_press 7 0x04        ;# ESC
        after time 1 [list try_menu [expr {$tries - 1}]]
    } elseif {$tries > 0} {
        after time 0.5 [list try_menu [expr {$tries - 1}]]
    }
}

proc try_prompt {tries} {
    set lines [lmap l [split [try_screen] "\n"] {string trim $l}]
    if {"A>" in $lines} {
        type "$::env(CASGO_COMMAND)\r"
    } elseif {$tries > 0} {
        after time 0.5 [list try_prompt [expr {$tries - 1}]]
    }
}

after time 1 {try_menu 60}
after time 3 {try_prompt 120}
