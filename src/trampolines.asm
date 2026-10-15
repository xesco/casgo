; The tape call trampolines for the calls and Namco cases, assembled for SLTWRK
; after tr_t0, in P3. They put T0 in page 0, run the routine, and put the slot
; register back as the ROM's routines leave it, because a loader may write to
; page 0 after the call, which T0 would take and the ROM ignores. The stack is no
; deeper than in a direct call: some loaders have no room for more.
tr_tapion:
        call tr_page0
        jp TAPION
tr_tapin:
        call tr_page0
        jp TAPIN

; Puts T0 in page 0, keeps the slot register in tr_back, and makes tr_back the
; routine's return address. Changes AF and DE, which TAPION and TAPIN change too
; (Red Book 1A63h, 1ABCh), and leaves interrupts off, as they do.
tr_page0:
        di
        call tr_t0
        pop de          ; DE = the trampoline's JP to the routine
        ex (sp),hl      ; HL = the game's return address
        ld (tr_back.jump+1),hl
        ld hl,tr_back
        ex (sp),hl      ; the routine returns to tr_back; HL is the game's again
        push de
        ret
