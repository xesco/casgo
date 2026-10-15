; The routine that puts T0 in page 0, for the calls, Namco, stub and BASIC
; cases (docs/CASES.md, Loader cases). Assembled for SLTWRK after the slot
; wrappers, in P3.

        IF CASE_B
; Puts the ROM in pages 0 and 1, then T0 in page 0, through tr_t0. Stage 1
; rewrites a binary's IN A,(0A8h) / AND 0F0h / OUT (0A8h),A as a call here
; (docs/CASES.md, BASIC's own loads), for loaders that clear the hook H.PARD.
tr_rom:
        in a,(PSLOT)
        and 0F0h
        out (PSLOT),a
        ENDIF

; Puts T0 in page 0: its subslot first, while page 0 still shows another slot, then
; its primary slot. In the M variants P3 is in T0's slot, so FFFFh here is that
; slot's subslot register, which reads back inverted (Red Book ch. 1). In the R, I
; and T variants it is not, or T0 is in the internal RAM, which is not expanded, and
; stage 2 writes a JR over the subslot code instead. Changes AF and keeps the other
; registers; it saves nothing on the stack, because some loaders have no room there
; for more than a direct tape call uses. The hook H.PARD calls it too
; (docs/CASES.md, BASIC's own loads). In the stub variants it also writes T0's
; primary slot to FC8Eh, an unused entry of TRPTBL (Red Book ch. 6), where the stub
; loader's patched build code reads it (docs/CASES.md, Stub loaders); BASIC clears
; TRPTBL on CLEAR and RUN, and H.PARD runs this before each BLOAD"CAS:".
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
