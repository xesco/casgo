; T0 in the internal RAM, for the I and T variants: T0 goes in that RAM's page 0,
; so that a game that takes the mapper's page 0 for itself misses it, and TAPIN's
; swap switches page 0's slot instead of its segment. Part of stage 2's code, in
; page 2.

; Writes the slot form of TAPIN's swap set-up into T0, seen through the window,
; then copies T0 into page 0 of the internal RAM. Page 0 changes meanwhile, so
; interrupts are off; this code and its stack are in pages 2 and 3. When the
; mapper's slot is expanded, the set-up also selects the mapper's subslot in page
; 0, through swap_sub (tape.asm), because a game's slot search can change it.
t0_to_iram:
        ld a,(RAMAD0)   ; 1000SSPP when expanded, else 000000PP
        rlca
        jr c,.expanded
        ld hl,slot_swap
        ld de,tapin.set_up+WINDOW
        ld bc,slot_swap_end-slot_swap
        ldir
        ld a,(RAMAD0)
        and 03h         ; the mapper's primary slot
        ld (tapin.set_up+slot_swap.mapper+1-slot_swap+WINDOW),a
        jr .copy
.expanded:
        ld hl,slot_swap_x
        ld de,tapin.set_up+WINDOW
        ld bc,slot_swap_x_end-slot_swap_x
        ldir
        ld a,(RAMAD0)
        and 03h         ; the mapper's primary slot
        ld (swap_sub.mapper+1+WINDOW),a
        rrca
        rrca
        ld (swap_sub.p3+1+WINDOW),a ; the same in bits 7-6, for page 3
        ld a,(RAMAD0)
        rrca
        rrca
        and 03h
        ld (swap_sub.sub+1+WINDOW),a ; the mapper's subslot
.copy:
        di
        in a,(PSLOT)
        ld (iram_a8),a
        IF MEM_T
        ; A second RAM is a subslot: select it for page 0 in its slot's subslot
        ; register, which reads back inverted (Red Book ch. 1), with page 3 in
        ; that slot meanwhile and no stack. Stage 2's ENASLT selects it again at
        ; the end and records it in SLTTBL.
        ld a,(iram_sub)
        cp 0FFh
        jr z,.primary
        ld e,a
        ld a,(iram_slot)
        rrca
        rrca
        ld b,a
        ld a,(iram_a8)
        and 3Fh
        or b
        out (PSLOT),a   ; page 3: T0's slot
        ld a,(0FFFFh)
        cpl
        and 0FCh
        or e
        ld (0FFFFh),a   ; page 0 of that slot: T0's subslot
        ld a,(iram_a8)
        out (PSLOT),a   ; page 3 back
.primary:
        ld a,(iram_a8)
        ENDIF
        and 0FCh
        ld b,a
        ld a,(iram_slot)
        or b
        out (PSLOT),a   ; page 0: the internal RAM
        IF MEM_T
        ld a,(seg_t0)   ; a second RAM is a mapper, so T0 goes in its segment of
        out (0FCh),a    ; T0's number; the internal RAM of an MSX1 ignores the port
        ENDIF
        ld hl,WINDOW
        ld de,0000h
        ld bc,4000h
        ldir
        IF MEM_T
        ld a,(iram_sub)
        cp 0FFh
        call nz,swap_copies
        ENDIF
        ld a,(iram_a8)
        out (PSLOT),a
        ret

        IF MEM_T
; A second RAM is a mapper, and every mapper takes the writes to the mapper port
; of page 0. TAPIN's swap writes a data segment there while T0 is still in page
; 0, so the code that runs until it writes T0's segment back comes from the
; second RAM's segment of that number. Copies that code, the swap's set-up to
; tapin.seg's OUT and swap_sub, into page 0 of the second RAM for each data
; segment, then puts T0's segment back. Runs with page 0 in the second RAM and
; interrupts off.
swap_copies:
        ld hl,tp_segs+WINDOW    ; the list of data segments, in T0
        ld b,TP_SEGS_MAX
.segment:
        ld a,(hl)
        out (0FCh),a    ; page 0: the second RAM's segment of that number
        push hl
        push bc
        ld hl,tapin.set_up+WINDOW
        ld de,tapin.set_up
        ld bc,tapin.seg+4-tapin.set_up
        ldir
        ld hl,swap_sub+WINDOW
        ld de,swap_sub
        ld bc,spare_tapion-swap_sub
        ldir
        pop bc
        pop hl
        inc hl
        djnz .segment
        ld a,(seg_t0)
        out (0FCh),a    ; page 0: T0's segment
        ret
        ENDIF

; TAPIN's swap set-up in the I and T variants (tape.asm): the data segment in
; the mapper's page 0, then B = the slots as they are, with the internal RAM in
; page 0, and A = the same with the mapper in page 0, for the swap's OUT (C),A
; and OUT (C),B with C = the slot register.
slot_swap:
        out (0FCh),a
        in a,(PSLOT)
        ld b,a
        and 0FCh
.mapper:
        or 0            ; the mapper's primary slot, written by t0_to_iram
        ld c,PSLOT
slot_swap_end:

; The swap's set-up when the mapper's slot is expanded: as slot_swap, but the
; rest is swap_sub, which also selects the mapper's subslot in page 0. As long
; as slot_swap.
slot_swap_x:
        out (0FCh),a
        in a,(PSLOT)
        ld b,a
        and 3Fh         ; page 3 cleared, for swap_sub
        jp swap_sub
        nop
slot_swap_x_end:
