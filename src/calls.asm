; The calls case (docs/CASES.md, Tape calls): stage 1 rewrites each CALL or JP
; to TAPION, TAPIN or TAPIOF in the binary files, so that it reaches the table
; of tape entries in SLTATR. The detector picks this case only for tapes whose
; loader puts the ROM back in page 0 itself.

; At the 00h byte at HL: notes a CALL or JP (CDh or C3h) whose operand is
; 00E1h, 00E4h or 00E7h. Changes AF, BC and HL.
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

; At a call note, in a binary file: the call's high byte becomes the table's.
calls_patch:
        ld a,(pt_binary)
        or a
        ret z
        ld a,ENTRIES >> 8
        ld (pt_value),a
        ld a,2          ; the operand's high byte
        jp pt_write_x
