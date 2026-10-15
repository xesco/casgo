; Stage 3: CASGO's tape routines, assembled for TAPE_BASE in T0, over the BIOS's
; own tape code. The game reaches them through the BIOS jump table. Stage 1 has
; read the CAS file into the data segments, 16381 bytes in each, and filled in
; the state at the end of this file. TAPIN reads a byte by putting its data
; segment in page 0 for two instructions, the swap, which every data segment
; holds at HOLE, the same address as here.

; TAPION: finds the next header in the CAS file. Returns carry clear when one
; is found, or carry set at the end of the file. Leaves interrupts off, as the
; BIOS's TAPION does (Red Book 1A63h). A loader that reads one byte past its
; block, as BLOAD does when a file's data block is one byte short, gets the
; next header's first byte, where a tape gives it a byte of the header's tone
; and keeps the header. TAPION therefore also takes a header whose first byte
; was read before it.
tapion:
        di
        ld hl,tp_header+1
        call tapin      ; keeps HL
        ret c
        jr .compare
.next:
        call tapin
        ret c
.compare:
        cp (hl)
        jr z,.match
        ; The eight header bytes are all different, so after a mismatch only
        ; the first header byte can start a new match.
        ld hl,tp_header
        cp (hl)
        jr nz,.next
.match:
        inc hl
        ld a,l
        cp (tp_header+8) & 0FFh
        jr nz,.next
        or a            ; carry clear: found
        ret

; TAPIN: returns the next byte of the file in A with carry clear, or carry set
; at the end of the file. Like the BIOS's TAPIN, which builds the byte in D, it
; leaves the byte in D too: a loader can compare its checksum with D, as
; Hydlide's does. Changes AF, BC and DE and keeps HL; leaves interrupts off, as
; the BIOS's TAPIN does (Red Book 1ABCh). It uses no stack, so it works wherever
; the game's stack is. With the BASIC case, tp_left counts the bytes up to the
; next switch between bytes to deliver and bytes to drop, and TAPIN skips the
; dropped ones.
tapin:
        di
.again:
        ld de,(tp_left)
        ld a,(tp_left+2)
        ld c,a
        or d
        or e
        IF CASE_B
        jr z,.next_count
        ELSE
        scf
        ret z           ; no bytes left: carry
        ENDIF
        ld a,d
        or e
        dec de
        ld (tp_left),de
        jr nz,.counted
        dec c
        ld a,c
        ld (tp_left+2),a
.counted:
        ld de,(tp_ptr)
        ld a,(tp_seg)
        ; The swap's set-up, 11 bytes. With T0 in the mapper, as here, the swap
        ; writes the mapper port of page 0. In I and T, stage 2 writes slot_swap
        ; (t0iram.asm) over these bytes, so that the swap writes the slot
        ; register instead.
.set_up:
.t0:    ld bc,0FCh      ; C = page 0's mapper port; B = T0, written by stage 2
        ds 8            ; NOPs
.swap:  out (c),a       ; page 0: the data segment
        ld a,(de)       ; in the data segment, at HOLE: the byte
        out (c),b       ; in the data segment; page 0: T0 again
        ld c,a          ; C = the byte
.seg:   ld a,0          ; the mapper's page 0 for the game, T0's segment,
        out (0FCh),a    ; written by stage 2: the slot swap leaves it changed
        inc de
        ld a,e
        cp HOLE & 0FFh
        jr nz,.end
        ld a,d
        cp HOLE >> 8
        jr nz,.end
        ld de,HOLE+3    ; the data skips the hole
.end:
        ld a,d
        cp 40h
        jr c,.keep      ; still in page 0
        ld de,(tp_next) ; the next data segment
        ld a,(de)
        ld (tp_seg),a
        inc de
        ld (tp_next),de
        ld de,0
.keep:
        ld (tp_ptr),de
        IF CASE_B
        ld a,(tp_drop)
        or a
        jp nz,.again    ; a dropped byte: read the next
        ENDIF
        ld a,c
        ld d,c          ; the byte in D too, where the BIOS's TAPIN builds it
        or a            ; carry clear: a byte
        ret
        IF CASE_B
.next_count:
        ; The count ran out: the next one in tp_counts, of bytes to deliver and
        ; bytes to drop in turn. A count of 0 ends the list and the file, and
        ; tp_list stays on it.
        ld de,(tp_list)
        ld a,(de)
        ld (tp_left),a
        inc de
        ld a,(de)
        ld (tp_left+1),a
        inc de
        ld a,(de)
        ld (tp_left+2),a
        ld c,a
        ld a,(tp_left)
        or c
        ld c,a
        ld a,(tp_left+1)
        or c
        scf
        ret z           ; the end of the file: carry
        inc de
        ld (tp_list),de
        ld a,(tp_drop)
        xor 1
        ld (tp_drop),a
        jp .again
        ENDIF

HOLE    equ tapin.swap+2 ; the swap's two instructions in each data segment

; TAPIOF and TAPOOF: the BIOS's enable interrupts, which is all that is left
; to do (Red Book 19E9h, 19DDh).
tapiof:
tapoof:
        ei
        ret

; STMOTR: there is no motor.
stmotr:
        ret

        IF T0_IRAM
; The rest of the swap's set-up in the I and T variants when the mapper's slot is
; expanded (t0iram.asm, slot_swap_x), with B the slots as they were and A
; the same without page 3: page 3 goes to the mapper's slot, whose subslot
; register then selects the mapper's subslot in page 0, and A and C are set as
; slot_swap sets them. The swap's first OUT puts page 3 back. It runs from T0 and
; uses no stack.
swap_sub:
.p3:    or 0            ; the mapper's primary slot in bits 7-6, written by stage 2
        out (PSLOT),a   ; page 3: the mapper's slot
        ld a,(0FFFFh)
        cpl             ; the subslot register reads back inverted
        and 0FCh
.sub:   or 0            ; the mapper's subslot, written by stage 2
        ld (0FFFFh),a
        ld a,b
        and 0FCh
.mapper: or 0           ; the mapper's primary slot, written by stage 2
        ld c,PSLOT
        jp tapin.swap

; The tape entries of T0's spare copy, in the mapper's page 0. A loader that has
; the mapper in page 0 at a tape call reaches the copy, whose tape state never
; moves, so these entries put T0 in page 0 for the call and the copy back after
; it. Each OUT runs in one copy and the next instruction in the other, which
; holds the same bytes. They keep the routine's A, flags and HL, and use 4 bytes
; of stack more than a direct call.
spare_tapion:
        in a,(PSLOT)
        push af         ; the slot register as it was
        and 0FCh
.slot:  or 0            ; T0's primary slot, written by stage 2
        out (PSLOT),a   ; page 0: T0
        call tapion
        jr spare_back
spare_tapin:
        in a,(PSLOT)
        push af
        and 0FCh
.slot:  or 0            ; T0's primary slot, written by stage 2
        out (PSLOT),a   ; page 0: T0
        call tapin
spare_back:
        ex (sp),hl      ; H = the slot register as it was
        push af
        ld a,h
        out (PSLOT),a   ; page 0: the copy again
        pop af
        pop hl
        ret
        ENDIF

        IF CASE_B
; The second call of a loader that restores page 0, then page 1, with its own
; copy of ENASLT and A left over from the first call: A becomes the main ROM's
; slot, which a cassette machine has in page 1, and the loader's routine follows.
; Stage 1 writes its address.
slot1_fix:
        ld a,(EXPTBL)
        jp 0
        ENDIF

; TAPOON and TAPOUT: saving to tape is not part of v1, so both fail.
tapoon:
tapout:
        scf
        ret

tp_header:
        db 1Fh,0A6h,0DEh,0BAh,0CCh,13h,7Dh,74h  ; a CAS block header



; Written by stage 1.
tp_left:      ds 3      ; the bytes not yet read, 24 bits, low byte first
tp_ptr:       dw 0      ; the next byte, an address in page 0
tp_seg:       db 0      ; the data segment it is in
tp_next:      dw tp_segs+1 ; the segment after it, in tp_segs
        IF CASE_B
tp_list:      dw tp_counts ; the next count
tp_drop:      db 1      ; 1 while TAPIN drops bytes; the first count delivers
tp_counts:    ds 3*(2*DROPS_MAX+2) ; the counts, then a 0
        ENDIF
tp_segs:      ds TAPE_END-$ ; the data segments, in order, to the end of the tape code
