; The BASIC case's part of stage 1: it finds the binary files that BASIC's BLOAD
; loads into page 0, where a cassette machine's ROM drops their bytes, and drops
; those bytes too. scan_check notes the quote after each BLOAD; patch_tape reads the
; file name there, and the headers of the binary files, and changes the start
; address of each file to drop; drop_counts then gives TAPIN its counts of bytes to
; deliver and drop. It also changes the code in binary files that puts the ROM back
; in pages 0 and 1, so that it puts T0 in page 0, for loaders that clear the hook
; H.PARD.

; At the quote at HL: notes it when BLOAD comes before it, as the token CFh or
; as text, with at most two spaces between. Keeps HL.
bload_check:
        push hl
        ld b,3          ; the byte before the quote, or one of two spaces more
.back:
        dec hl
        ld a,(hl)
        cp " "
        jr nz,.word
        djnz .back
        jr .no
.word:
        cp 0CFh         ; the BLOAD token
        jr z,.yes
        ld de,bload_text+4
        ld b,5          ; the text BLOAD, from its last letter back
.letter:
        ld a,(de)
        cp (hl)
        jr nz,.no
        dec de
        dec hl
        djnz .letter
.yes:
        pop hl
        ld a,NOTE_BLOAD
        jp pl_note
.no:
        pop hl
        ret

bload_text:
        db "BLOAD"

; At a BLOAD note in a BASIC program: when the statement names a file and gives
; no offset, only an optional ,R, adds the name, padded with spaces, to
; pt_names. A "CAS:" in front of the name, in any case, is not part of it.
bload_patch:
        ld a,(pt_binary)
        or a
        ret nz          ; a quote in a binary file
        ld hl,bp_name
        ld b,6
.clear:
        ld (hl)," "
        inc hl
        djnz .clear
        ld c,1          ; C = the place of the next byte, after pt_off
        ld hl,cas_device
        ld a,1
        ld b,4
        call bp_match
        jr nz,.name
        ld c,5
.name:
        ld hl,bp_name
        ld b,0          ; B = the name's length
.char:
        call bp_read
        cp 22h
        jr z,.closed
        inc b
        ld e,a
        ld a,b
        cp 7
        ret z           ; longer than a tape file name
        ld (hl),e
        inc hl
        inc c
        jr .char
.closed:
        ld a,b
        or a
        ret z           ; no name: the next file, whatever its name
        inc c
        call bp_space
        call bp_end
        jr z,.add       ; the end of the statement
        cp ","
        ret nz
        inc c
        call bp_space
        and 0DFh
        cp "R"
        ret nz          ; an offset
        inc c
        call bp_space
        call bp_end
        ret nz
.add:
        ld a,(pt_nnames)
        cp NAMES_MAX
        ret z           ; no room: the file keeps its bytes
        ld l,a
        inc a
        ld (pt_nnames),a
        ld h,0
        ld d,h
        ld e,l
        add hl,hl
        add hl,de
        add hl,hl       ; HL = 6 x its index
        ld de,pt_names
        add hl,de
        ex de,hl
        ld hl,bp_name
        ld bc,6
        ldir
        ret

; Returns Z when the byte in A ends a BASIC statement: a colon, or the end of a
; line, 00h in a tokenized program and 0Dh in an ASCII one.
bp_end:
        cp ":"
        ret z
        or a
        ret z
        cp 0Dh
        ret

; Reads into A the first byte from place C on that is not a space, and leaves
; C at it.
bp_space:
        call bp_read
        cp " "
        ret nz
        inc c
        jr bp_space

; Reads into A the byte at place C after pt_off. Keeps BC and HL.
bp_read:
        push bc
        push hl
        ld a,c
        call pt_read
        pop hl
        pop bc
        ret

; Returns Z when the B bytes from place A after pt_off equal those at HL, with
; letters in any case.
bp_match:
        ld c,a
.next:
        call bp_read
        cp "a"
        jr c,.cased
        and 0DFh        ; a lower-case letter in upper case
.cased:
        cp (hl)
        ret nz
        inc hl
        inc c
        djnz .next
        xor a
        ret

cas_device:
        db "CAS:"
bp_name:
        ds 6

; At a header note that starts a file: when the file is binary and its name is
; in pt_names, sets pt_pending, so that its data block is looked at next.
basic_file:
        xor a
        ld (pt_pending),a
        ld a,(pt_value)
        cp 0D0h
        ret nz
        ld a,(pt_nnames)
        or a
        ret z
        ld b,a
        ld hl,pt_names
.name:
        push bc
        push hl
        ld a,18         ; the name, after the header and the ten type bytes
        ld b,6
        call pt_match
        pop hl
        pop bc
        jr z,.found
        ld de,6
        add hl,de
        djnz .name
        ret
.found:
        ld a,1
        ld (pt_pending),a
        ret

; At the header note of a block that does not start a file: when it is the data
; block of a pending file, which starts below 4000h and ends at 4000h or above,
; notes the bytes below 4000h as dropped and changes the start address to
; 4000h. The block holds the start, end and run addresses, then the bytes.
basic_data:
        ld a,(pt_pending)
        or a
        ret z
        xor a
        ld (pt_pending),a
        ld a,9
        call pt_read
        cp 40h
        ret nc          ; it starts in page 1 or above
        ld a,11
        call pt_read
        cp 40h
        ret c           ; it ends in page 0
        ld a,(pl_ndrops)
        cp DROPS_MAX
        ret z           ; no room: the file keeps its bytes
        ld l,a
        inc a
        ld (pl_ndrops),a
        ld h,0
        ld d,h
        ld e,l
        add hl,hl
        add hl,hl
        add hl,de       ; HL = 5 x its index
        ld de,pl_drops
        add hl,de
        push hl
        ld hl,(pt_off)
        ld de,14        ; the header, then the three addresses
        add hl,de
        ex de,hl
        pop hl
        ld (hl),e
        inc hl
        ld (hl),d
        inc hl
        ld a,(pt_off+2)
        adc a,0
        ld (hl),a       ; the drop's file offset
        inc hl
        push hl
        ld a,8
        call pt_read
        push af
        ld a,9
        call pt_read
        ld d,a
        pop af
        ld e,a          ; DE = the start address; pt_read changes DE
        ld hl,4000h
        or a
        sbc hl,de
        ex de,hl
        pop hl
        ld (hl),e
        inc hl
        ld (hl),d       ; the drop's length: 4000h less the start
        xor a
        ld (pt_value),a
        ld a,8
        call pt_write
        ld a,40h
        ld (pt_value),a
        ld a,9
        jp pt_write     ; the start address: 4000h

; Writes TAPIN's counts into the tape image: from the start of the file, the
; bytes to deliver up to the first drop, the drop's length, the bytes up to
; the next drop, and so on, then the bytes to the end of the file and a 0.
; tp_left starts at 0 and tp_drop at 1, so TAPIN's first call takes the first
; count as bytes to deliver.
drop_counts:
        xor a
        ld (tape_copy+tp_left-TAPE_BASE),a
        ld (tape_copy+tp_left+1-TAPE_BASE),a
        ld (tape_copy+tp_left+2-TAPE_BASE),a
        ld (dc_pos),a
        ld (dc_pos+1),a
        ld (dc_pos+2),a
        ld hl,tape_copy+tp_counts-TAPE_BASE
        ld (dc_out),hl
        ld hl,pl_drops
        ld a,(pl_ndrops)
        or a
        jr z,.last
        ld b,a
.drop:
        push bc
        ld e,(hl)
        inc hl
        ld d,(hl)
        inc hl
        ld c,(hl)       ; C:DE = the drop's offset
        inc hl
        push hl
        call dc_keep    ; the bytes up to it
        pop hl
        ld e,(hl)
        inc hl
        ld d,(hl)
        inc hl
        push hl
        ld c,0
        call dc_put     ; its length
        ld hl,(dc_pos)
        add hl,de
        ld (dc_pos),hl
        ld a,(dc_pos+2)
        adc a,0
        ld (dc_pos+2),a ; dc_pos = the end of the drop
        pop hl
        pop bc
        djnz .drop
.last:
        ld de,(pl_size)
        ld a,(pl_size+2)
        ld c,a
        call dc_keep    ; the bytes to the end of the file
        ld de,0
        ld c,d
        jp dc_put       ; the end of the list

; Writes the count from dc_pos up to the offset C:DE, and moves dc_pos there.
dc_keep:
        push de
        push bc
        ld hl,(dc_pos)
        ex de,hl
        or a
        sbc hl,de
        ex de,hl        ; DE = the low 16 bits of the count
        ld a,(dc_pos+2)
        ld b,a
        ld a,c
        sbc a,b
        ld c,a          ; C = its high byte
        call dc_put
        pop bc
        pop de
        ld (dc_pos),de
        ld a,c
        ld (dc_pos+2),a
        ret

; Writes the count C:DE at dc_out and moves dc_out past it.
dc_put:
        ld hl,(dc_out)
        ld (hl),e
        inc hl
        ld (hl),d
        inc hl
        ld (hl),c
        inc hl
        ld (dc_out),hl
        ret

dc_pos:  ds 3           ; the file offset that the counts so far reach
dc_out:  dw 0           ; where the next count goes

; At the A8h byte at HL: notes rom_back when it ends there. Keeps HL; changes
; AF, BC and DE.
rom_check:
        push hl
        ld bc,-5
        add hl,bc
        ld de,rom_back
        ld b,5
.byte:
        ld a,(de)
        cp (hl)
        jr nz,.no
        inc de
        inc hl
        djnz .byte
        ld bc,-5
        add hl,bc
        ld a,NOTE_ROM
        call pl_note
.no:
        pop hl
        ret

; At a rom_back note, in a binary file: the sequence becomes CALL tr_rom and
; three NOPs, so that it puts T0 in page 0 instead of the ROM.
rom_patch:
        ld a,(pt_binary)
        or a
        ret z
        ld c,0          ; C = the place of the byte
.byte:
        ld b,0
        ld hl,rom_call
        add hl,bc
        ld a,(hl)
        ld (pt_value),a
        ld a,c
        push bc
        call pt_write_x
        pop bc
        inc c
        ld a,c
        cp rom_call_end-rom_call
        jr nz,.byte
        ret

rom_call:
        db 0CDh, tr_rom & 0FFh, tr_rom >> 8, 0, 0, 0
rom_call_end:

; At the 40h byte at HL: notes the slot calls when LD A,(nn) / LD HL,0000h /
; CALL nn / LD HL,4000h ends there, the second call's CALL following. Keeps
; HL; changes AF, BC and DE.
slot1_check:
        ld de,slot1_bytes
        ld b,(slot1_bytes_end-slot1_bytes)/2
        call match_before
        ret nz
        push hl
        ld bc,-11
        add hl,bc
        ld a,NOTE_SLOT1
        call pl_note
        pop hl
        ret

; At the FCh byte at HL: notes the restore of pages 1 and 0 with EXPTBL's byte
; for slot 1, LD H,40h / LD A,(0FCC2h) / CALL nn / LD H,00h / LD A,(0FCC1h),
; when it ends there. Keeps HL; changes AF, BC and DE.
exptbl_check:
        ld de,exptbl_bytes
        ld b,(exptbl_bytes_end-exptbl_bytes)/2
        call match_before
        ret nz
        push hl
        ld bc,-12
        add hl,bc
        ld a,NOTE_EXPTBL
        call pl_note
        pop hl
        ret

; The restore's bytes before LD A,(0FCC1h)'s FCh that do not vary, each its
; place before the FCh and its value.
exptbl_bytes:
        db 1, 0C1h, 2, 3Ah, 3, 00h, 4, 26h, 7, 0CDh, 8, 0FCh, 9, 0C2h, 10, 3Ah
        db 11, 40h, 12, 26h
exptbl_bytes_end:

; At a restore note, in a binary file: LD A,(0FCC2h), EXPTBL's byte for slot 1,
; becomes LD A,(0FCC1h), the main ROM's slot, which page 1's BASIC ROM shares.
; The loader meant that slot: FCC2h is 00h, which selects slot 0, only while
; slot 1 is not expanded, and a Carnivore2 there expands it.
exptbl_patch:
        ld a,(pt_binary)
        or a
        ret z
        ld a,0C1h
        ld (pt_value),a
        ld a,3          ; the low byte of LD A,(0FCC2h)'s address
        jp pt_write_x

; Returns Z when the B bytes at DE, each its place before HL and its value,
; match the bytes there. Keeps HL; changes AF, BC and DE.
match_before:
        push hl
        ld a,(de)       ; the byte's place before HL
        inc de
        ld c,a
        ld a,l
        sub c
        ld l,a
        ld a,h
        sbc a,0
        ld h,a
        ld a,(de)       ; its value
        inc de
        cp (hl)
        pop hl
        ret nz
        djnz match_before
        ret

; At a slot calls note, in a binary file: when CALL nn follows LD HL,4000h with
; the first call's nn, the second call becomes CALL slot1_fix, which gives the
; loader's routine the main ROM's slot in A. slot1_fix jumps to one routine, so
; a second note with another routine keeps its call.
slot1_patch:
        ld a,(pt_binary)
        or a
        ret z
        ld a,12
        call pt_read
        cp 0CDh
        ret nz
        ld a,7
        call pt_read
        ld e,a
        ld a,13
        push de
        call pt_read
        pop de
        cp e
        ret nz
        ld a,8
        push de
        call pt_read    ; changes DE
        pop de
        ld d,a
        ld a,14
        push de
        call pt_read
        pop de
        cp d
        ret nz          ; DE = the loader's routine
        ld hl,(sl_routine)
        ld a,h
        or l
        jr z,.first
        sbc hl,de
        ret nz          ; slot1_fix already jumps to another routine
.first:
        ld (sl_routine),de
        ld (tape_copy+slot1_fix+4-TAPE_BASE),de
        ld a,slot1_fix & 0FFh
        ld (pt_value),a
        ld a,13
        call pt_write_x
        ld a,slot1_fix >> 8
        ld (pt_value),a
        ld a,14
        jp pt_write_x

sl_routine: dw 0        ; the routine that slot1_fix jumps to, 0 before the first
