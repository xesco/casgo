; The tape call trampolines of the calls and Namco cases (docs/CASES.md, Tape
; calls), assembled for SLTWRK after tr_t0, in P3. Stage 1 rewrites a loader's
; calls to TAPION, TAPIN and TAPIOF to come here. The TAPION and TAPIN
; ones put page 0 on T0, run the routine, and then put the slot register back
; as it was, as the ROM's routines leave it: a loader may write page 0 after
; the call, which T0 would take and the ROM ignores. They leave the stack as
; deep as a direct call would, because some loaders have no room for more.
tr_tapion:
        call tr_page0
        jp TAPION
tr_tapin:
        call tr_page0
        jp TAPIN

; Puts T0 in page 0, with the slot register before it kept in tr_back, then
; puts tr_back in place of the game's return address,
; so that the routine returns there, and goes on to the trampoline's JP. Keeps
; every register but AF and DE: TAPION and TAPIN take nothing in them and may
; change them too (Red Book 1A63h, 1ABCh); leaves interrupts off, as they do.
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
