; The calls case: for loaders that put the BIOS ROM back in page 0 and then call
; the tape directly. Stage 1 points each CALL or JP to TAPION, TAPIN or TAPIOF at
; the table of tape entries (entries.asm) instead.

; At the 00h byte at HL: notes a CALL or JP to 00E1h, 00E4h or 00E7h.
; Changes AF, BC and HL.
calls_check:
        dec hl
        ld a,(hl)
        cp TAPION & 0FFh
        jr z,.opcode
        cp TAPIN & 0FFh
        jr z,.opcode
        cp TAPIOF & 0FFh
        ret nz
.opcode:
        dec hl
        ld a,(hl)
        cp 0CDh         ; CALL nn
        jr z,.found
        cp 0C3h         ; JP nn
        ret nz
.found:
        ld a,NOTE_CALL
        jp pl_note

; At a call note in a binary file: the call's high byte becomes the table's.
calls_patch:
        ld a,(pt_binary)
        or a
        ret z
        ld a,ENTRIES >> 8
        ld (pt_value),a
        ld a,2          ; the operand's high byte
        jp pt_write_x
