; The table of tape entries for the calls and Namco cases, assembled for SLTATR
; in P3. A tape call whose high byte stage 1 changed from 00h to FCh lands here,
; on the entry with the same low byte.
e_tapion:
        jp tr_tapion
e_tapin:
        jp tr_tapin
e_tapiof:
        ei
        ret
        nop
e_tapoon:
        scf             ; saving fails, as CASGO's TAPOON does
        ret
        nop
e_tapout:
        scf
        ret
        nop
e_tapoof:
        ei
        ret
        nop
e_stmotr:
        ret

; Where TAPION and TAPIN return from a trampoline (trampolines.asm): puts the
; slot register back and jumps to the game's return address, both written by
; tr_page0. It sits here because SLTWRK has no room left.
tr_back:
        push af
.saved:
        ld a,0          ; the slot register before the call
        out (PSLOT),a
        pop af
.jump:
        jp 0            ; the game's return address
