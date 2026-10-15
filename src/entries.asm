; The table of tape entries of the calls and Namco cases, and the trampolines'
; way back, assembled for ENTRIES in P3's SLTATR (docs/CASES.md, Tape calls): a
; call to a tape entry 00xxh whose high byte stage 1 changed to FCh lands on the
; entry here with the same low byte.
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

; Where TAPION and TAPIN return from a trampoline (src/trampolines.asm): puts the
; slot register back and jumps to the game's return address, both of which
; tr_page0 wrote below. It is here, after the table, where SLTATR has room, so
; that SLTWRK holds the code of every loader case (docs/PLAN.md, step 21).
tr_back:
        push af
.saved:
        ld a,0          ; the slot register before the call
        out (PSLOT),a
        pop af
.jump:
        jp 0            ; the game's return address
