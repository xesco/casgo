; The slot wrappers, assembled for SLTWRK in P3. Stage 2 points these entries of
; T0's jump table here, so that the slot routines run from the main ROM: each
; stub names the ROM entry, and sw_common puts the ROM in page 0, calls the entry
; with the caller's registers, and puts T0 back. The routines handle interrupts
; themselves.

sw_rdslt:
        push hl         ; the caller's HL, while the stub uses HL
        ld hl,RDSLT
        jr sw_common
sw_wrslt:
        push hl
        ld hl,WRSLT
        jr sw_common
sw_calslt:
        push hl
        ld hl,CALSLT
        jr sw_common
sw_extrom:
        push hl
        ld hl,EXTROM

sw_common:
        ld (sw_call+1),hl
        pop hl
        push af
        in a,(PSLOT)
        ld (sw_back+1),a
        and 0FCh
sw_rom:
        or 0            ; the main ROM's primary slot, written by stage 2
        out (PSLOT),a   ; page 0: the main ROM
        pop af
sw_call:
        call 0          ; the ROM's own entry, written by the stub
        push af
        push bc
sw_back:
        ld a,0          ; the slot register before the call, written above
        and 03h         ; page 0's primary slot before the call: T0's
        ld b,a
        in a,(PSLOT)    ; the routine may have changed the other pages for good
        and 0FCh
        or b
        out (PSLOT),a   ; page 0: T0 again
        pop bc
        pop af
        ret
