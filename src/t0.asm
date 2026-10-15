; The routine that puts T0 in page 0, for the calls, Namco, stub and BASIC
; cases, assembled for SLTWRK after the slot wrappers, in P3.

        IF CASE_B
; Puts the ROM in pages 0 and 1, then T0 in page 0. Stage 1 turns a binary's
; IN A,(0A8h) / AND 0F0h / OUT (0A8h),A into a call here, for loaders that clear
; the hook H.PARD.
tr_rom:
        in a,(PSLOT)
        and 0F0h
        out (PSLOT),a
        ENDIF

; Puts T0 in page 0: its subslot first, while page 0 still shows another slot,
; then its primary slot. In M, P3 is in T0's slot, so FFFFh is that slot's
; subslot register, which reads back inverted (Red Book ch. 1). In R, I and T
; page 3 cannot reach it, and stage 2 writes a JR over the subslot code. Changes
; AF and uses 2 bytes of stack. H.PARD calls it too, before each BLOAD"CAS:".
; With the stub case it also writes T0's primary slot to FC8Eh, an unused entry
; of TRPTBL (Red Book ch. 6), for the stub loader's patched code; BASIC clears
; TRPTBL on CLEAR and RUN, which is why H.PARD writes it again.
tr_t0:
        IF CASE_S
tr_t:
        ld a,0          ; T0's primary slot, written by stage 2
        ld (0FC8Eh),a
        ENDIF
tr_sub:
        ld a,0          ; T0's subslot, or JR .primary, written by stage 2
        push bc
        ld b,a
        ld a,(0FFFFh)
        cpl
        and 0FCh
        or b
        ld (0FFFFh),a
        pop bc
.primary:
        in a,(PSLOT)
        IF TRAMPOLINES
        ld (tr_back.saved+1),a  ; the slot register before, for the trampolines
        ENDIF
        and 0FCh
tr_prim:
        or 0            ; T0's primary slot, written by stage 2
        out (PSLOT),a
        ret
