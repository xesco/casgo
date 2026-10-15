; The Namco case: a loader that calls the tape through a CALL 0000h whose low
; byte it writes at run time. Stage 1 gives the call the table of tape entries'
; high byte, so it reaches the table whatever low byte the loader writes.

; At the 00h byte at HL: notes the end of the loader's call sequence.
; Changes AF, BC and DE.
namco_check:
        ld de,namco_call
        call scan_compare
        ret nz
        push hl
        ld bc,-7
        add hl,bc
        ld a,NOTE_NAMCO
        call pl_note
        pop hl
        ret

; At a Namco note in a binary file: CALL 0000h's high byte becomes the table's.
namco_patch:
        ld a,(pt_binary)
        or a
        ret z
        ld a,ENTRIES >> 8
        ld (pt_value),a
        ld a,7          ; CALL 0000h's high byte
        jp pt_write_x
