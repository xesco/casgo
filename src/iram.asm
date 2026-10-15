; The internal RAM, for the R, I and T variants (docs/CASES.md, Internal RAM
; mode): in R and I the game's pages 2 and 3 run in an MSX1's own RAM, as on a
; cassette machine, and in I and T T0 is in its page 0. Part of stage 2's code,
; in page 2.

; Finds the internal RAM: the first primary slot, not expanded and not page 3's,
; with RAM at FFFEh, and in the I and T variants with RAM at 3FFEh too, where T0
; goes. In the T variants, when there is none, it takes the first second RAM
; instead: a subslot with RAM at 3FFEh in an expanded primary slot that is not
; page 3's (docs/CASES.md, T0 in a second RAM on an MSX2). Sets iram_slot to the
; primary slot, iram_sub to the subslot or 0FFh, and iram_toggle to the XOR of
; the primary slot's bits and page 3's, in bits 7-6, or iram_toggle to 0 when
; there is none. Stage 1 calls it from page 2, with interrupts off meanwhile: the
; search switches page 3 and page 0, so the stack moves to page 2. Leaves
; interrupts off.
iram_find:
        di
        ld (iram_sp),sp
        ld sp,iram_stack_top
        in a,(PSLOT)
        ld (iram_a8),a
        xor a
        ld (iram_toggle),a
        dec a
        ld (iram_sub),a
        ld c,0          ; C = the slot tried
.slot:
        ld hl,EXPTBL
        ld b,0
        add hl,bc
        bit 7,(hl)
        jr nz,.next     ; expanded: not internal RAM
        ld a,(iram_a8)
        rlca
        rlca
        and 03h
        cp c
        jr z,.next      ; page 3's own slot, the mapper
        ld a,c
        rrca
        rrca            ; the slot in bits 7-6
        ld b,a
        ld a,(iram_a8)
        and 3Fh
        or b
        out (PSLOT),a
        ld hl,0FFFEh
        call iram_probe
        jr nz,.next
        IF T0_IRAM
        ld a,(iram_a8)  ; T0 goes in this RAM's page 0, so it needs RAM there
        and 0FCh
        or c
        out (PSLOT),a
        ld hl,3FFEh
        call iram_probe
        jr nz,.next
        ENDIF
.found:
        ld a,(iram_a8)
        and 0C0h
        xor b
        ld (iram_toggle),a
        ld a,c
        ld (iram_slot),a
        jr .done
.next:
        inc c
        ld a,c
        cp 4
        jr nz,.slot
        IF MEM_T
        ld c,0          ; C = the expanded slot tried
.xslot:
        ld hl,EXPTBL
        ld b,0
        add hl,bc
        bit 7,(hl)
        jr z,.xnext     ; not expanded: tried above
        ld a,(iram_a8)
        rlca
        rlca
        and 03h
        cp c
        jr z,.xnext     ; page 3's own slot, the mapper
        ld a,c
        rrca
        rrca            ; the slot in bits 7-6
        ld b,a
        ld e,0          ; E = the subslot tried
.xsub:
        call iram_sub_set
        ld d,a          ; D = the subslot register as it was
        ld a,(iram_a8)
        and 0FCh
        or c
        out (PSLOT),a   ; page 0: the slot, with the subslot tried
        ld hl,3FFEh
        call iram_probe
        push af
        ld a,d
        call iram_sub_put       ; the subslot register back
        pop af
        jr nz,.xtry
        ld a,e
        ld (iram_sub),a
        jr .found
.xtry:
        inc e
        ld a,e
        cp 4
        jr nz,.xsub
.xnext:
        inc c
        ld a,c
        cp 4
        jr nz,.xslot
        ENDIF
.done:
        ld sp,(iram_sp)
        ret

        IF MEM_T
; Selects subslot E for page 0 in the subslot register of the primary slot whose
; bits 7-6 are in B, and returns the register's old value in A. The register is at
; FFFFh in its slot and reads back inverted (Red Book ch. 1), so page 3 goes to the
; slot for the access and back to iram_a8 after it. Runs from page 2 with
; interrupts off and uses the stack, which is in page 2.
iram_sub_set:
        ld a,(iram_a8)
        and 3Fh
        or b
        out (PSLOT),a   ; page 3: the slot
        ld a,(0FFFFh)
        cpl
        push af
        and 0FCh
        or e
        ld (0FFFFh),a
        jr iram_sub_back

; Writes A to the subslot register of the primary slot whose bits 7-6 are in B,
; as iram_sub_set reaches it.
iram_sub_put:
        push af
        ld a,(iram_a8)
        and 3Fh
        or b
        out (PSLOT),a   ; page 3: the slot
        pop af
        ld (0FFFFh),a
        push af
iram_sub_back:
        ld a,(iram_a8)
        out (PSLOT),a   ; page 3 back
        pop af
        ret
        ENDIF

; Returns Z when the byte at HL is RAM: it reads back what was written, and
; then gets its old value back. Puts the slot register back to iram_a8 first.
iram_probe:
        ld a,(hl)
        cpl
        ld (hl),a
        cp (hl)
        cpl
        ld (hl),a
        push af
        ld a,(iram_a8)
        out (PSLOT),a   ; the slots back, the stack's page among them
        pop af
        ret

        IF IRAM
; Copies P3, through the window, into page 3 of the internal RAM.
iram_copy:
        di
        ld a,(seg_p3)
        call open_window
        ld (iram_sp),sp
        ld sp,iram_stack_top
        in a,(PSLOT)
        ld (iram_a8),a
        ld hl,iram_toggle
        xor (hl)
        out (PSLOT),a
        ld hl,WINDOW
        ld de,0C000h
        ld bc,4000h
        ldir
        ld a,(iram_a8)
        out (PSLOT),a
        ld sp,(iram_sp)
        jp close_window

; Copies BASIC's page 2 into page 2 of the internal RAM. The copy runs from the
; bottom of P3, which nothing uses, because this code is in page 2. Its copy in
; the internal RAM's page 3 was made before, so the game never sees it there.
; iram_copier is position independent; its two XORs get page 2's toggle.
iram_copy_page2:
        ld hl,iram_copier
        ld de,COPIER
        ld bc,iram_copier_end-iram_copier
        ldir
        ld a,(iram_toggle)
        rrca
        rrca            ; page 2's bits, 5-4
        ld (COPIER+iram_copier.t1+1-iram_copier),a
        ld (COPIER+iram_copier.t2+1-iram_copier),a
        di
        ld a,(seg_p2)
        call open_window
        call COPIER
        jp close_window

iram_copier:
        in a,(PSLOT)
.t1:    xor 0
        out (PSLOT),a   ; page 2: the internal RAM
        ld hl,WINDOW
        ld de,8000h
        ld bc,4000h
        ldir
        in a,(PSLOT)
.t2:    xor 0
        out (PSLOT),a   ; page 2: the mapper again
        ret
iram_copier_end:
        ENDIF

iram_sp:     dw 0
iram_a8:     db 0
iram_toggle: db 0
iram_slot:   db 0       ; the internal RAM's primary slot
iram_sub:    db 0FFh    ; the second RAM's subslot, or 0FFh for none
iram_stack:  ds 32
iram_stack_top:
