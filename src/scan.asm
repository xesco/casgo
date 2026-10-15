; The scan of the CAS file for the loader cases that patch it: calls, Namco, stub
; and BASIC. Part of stage 1, in the variants of those cases.
;
; While preload reads the file, scan_check looks back from each byte that can
; end a pattern and notes where each block header and each pattern of the
; variant's cases is (pl_note). Then patch_tape goes through the notes in file
; order: the headers tell which files are binary, and each case's routine
; patches its patterns in the data segments.

; The kinds of notes.
NOTE_HEADER equ 1       ; a block header
NOTE_CALL   equ 2       ; a CALL or JP to TAPION, TAPIN or TAPIOF
NOTE_BUILD  equ 3       ; the stub's build sequence, with 00E1h or 00EAh
NOTE_NAMCO  equ 4       ; namco_call
NOTE_BLOAD  equ 5       ; the quote after BLOAD in a BASIC program
NOTE_ROM    equ 6       ; rom_back
NOTE_SLOT1  equ 7       ; the slot calls of slot1_check
NOTE_EXPTBL equ 8       ; the restore of exptbl_check
NOTE_RESET  equ 9       ; caslink_reset, in every case

; Marks in scan_table the last byte of each pattern of the variant's cases, so
; that scan_check looks back only at those bytes: the header's 74h, the F7h of
; caslink_reset, which every case patches, a tape
; call's or the Namco call's 00h, the stub's build sequence's D5h or E5h, the
; quote after BLOAD, rom_back's A8h, the 40h of slot1_check's LD HL,4000h, and
; the FCh of exptbl_check's LD A,(0FCC1h).
scan_init:
        ld hl,scan_table
        ld de,scan_table+1
        ld bc,255
        ld (hl),0
        ldir
        ld a,1
        ld (scan_table+74h),a
        ld (scan_table+0F7h),a
        ld a,(lcase)
        ld c,a          ; C = the loader cases of the command line
        ld a,1
        IF CASE_C || CASE_N
        bit 0,c         ; LC_C
        jr nz,.zero
        bit 1,c         ; LC_N
        jr z,.no_zero
.zero:
        ld (scan_table+00h),a
.no_zero:
        ENDIF
        IF CASE_S
        bit 2,c         ; LC_S
        jr z,.no_stub
        ld (scan_table+0D5h),a
        ld (scan_table+0E5h),a
.no_stub:
        ENDIF
        IF CASE_B
        bit 3,c         ; LC_B
        ret z
        ld (scan_table+22h),a
        ld (scan_table+0A8h),a
        ld (scan_table+40h),a
        ld (scan_table+0FCh),a
        ENDIF
        ret

; Looks back from the byte at HL, the last byte of a pattern, whose value is in
; E, and notes the header or the pattern that ends there. Keeps HL, BC and D.
scan_check:
        push hl
        push bc
        ld a,e
        cp 74h
        jr z,.header
        cp 0F7h
        jr z,.reset
        IF CASE_B
        cp 22h
        jr nz,.not_quote
        call bload_check
        jr .done
.not_quote:
        cp 0A8h
        jr nz,.not_port
        call rom_check
        jr .done
.not_port:
        cp 40h
        jr nz,.not_slot1
        call slot1_check
        jr .done
.not_slot1:
        cp 0FCh
        jr nz,.not_exptbl
        call exptbl_check
        jr .done
.not_exptbl:
        ENDIF
        IF CASE_C || CASE_N
        or a
        jr nz,.not_zero
        IF CASE_N
        ld a,(lcase)
        and LC_N
        call nz,namco_check
        ENDIF
        IF CASE_C
        ld a,(lcase)
        and LC_C
        call nz,calls_check
        ENDIF
        jr .done
.not_zero:
        ENDIF
        IF CASE_S
        ld a,(lcase)
        and LC_S
        call nz,stub_check
        ENDIF
        jr .done
.header:
        ld de,cas_header
        call scan_compare
        jr nz,.done
        ld bc,-7
        add hl,bc
        ld a,NOTE_HEADER
        call pl_note
        jr .done
.reset:
        ld de,caslink_reset
        call scan_compare
        jr nz,.done
        ld bc,-7
        add hl,bc
        ld a,NOTE_RESET
        call pl_note
.done:
        pop bc
        pop hl
        ld d,scan_table >> 8
        ret

; Compares the 7 bytes before HL with the first 7 of the 8-byte pattern at DE.
; Returns Z when they are equal. Keeps HL.
scan_compare:
        push hl
        ld bc,-7
        add hl,bc
        ld b,7
.loop:
        ld a,(de)
        cp (hl)
        jr nz,.differ
        inc de
        inc hl
        djnz .loop
.differ:
        pop hl
        ret

; Notes a pattern for patch_tape: its kind in A, and the file offset of its
; first byte, which is at HL in the buffer. Keeps HL, BC and DE.
pl_note:
        push hl
        push bc
        push de
        ld c,a
        ld de,scan_buffer-SCAN_KEEP
        or a
        sbc hl,de       ; HL = its place in the buffer, from the kept bytes
        ld de,(pl_base)
        add hl,de
        ld a,(pl_base+2)
        adc a,0
        ld b,a          ; B:HL = the file offset
        ex de,hl
        ld hl,(pl_end)
        push de
        ld de,pl_notes_end
        or a
        sbc hl,de
        add hl,de
        pop de
        jr nc,.full
        ld (hl),c
        inc hl
        ld (hl),e
        inc hl
        ld (hl),d
        inc hl
        ld (hl),b
        inc hl
        ld (pl_end),hl
        pop de
        pop bc
        pop hl
        ret
.full:
        ld de,too_many
        jp exit_with_path

; Applies the patches of the variant's cases at the places scan_check noted, in
; the data segments, in file order. A header with ten equal bytes after it
; starts a file, and its type decides whether the blocks that follow are
; binary: D0h is, D3h and EAh are not.
patch_tape:
        ld a,1
        ld (pt_binary),a
        xor a
        ld (pt_xd),a
        ld (pt_sd),a
        ld hl,0
        ld (pt_sd16),hl
        ld a,0FFh
        ld (pt_block+2),a ; no block yet, so pt_prev gets none
        ld hl,pl_notes
.next:
        ld de,(pl_end)
        or a
        sbc hl,de
        add hl,de
        jr nc,.last     ; no notes left
        ld a,(hl)
        inc hl
        ld e,(hl)
        inc hl
        ld d,(hl)
        inc hl
        ld (pt_off),de
        ld e,a
        ld a,(hl)
        inc hl
        ld (pt_off+2),a
        push hl
        ld hl,.done
        push hl         ; each note's routine returns to .done
        ld a,e
        cp NOTE_HEADER
        jr z,.header
        cp NOTE_RESET
        jp z,reset_patch
        IF CASE_C
        cp NOTE_CALL
        jp z,calls_patch
        ENDIF
        IF CASE_N
        cp NOTE_NAMCO
        jp z,namco_patch
        ENDIF
        IF CASE_S
        cp NOTE_BUILD
        jp z,stub_patch
        ENDIF
        IF CASE_B
        cp NOTE_BLOAD
        jp z,bload_patch
        cp NOTE_ROM
        jp z,rom_patch
        cp NOTE_SLOT1
        jp z,slot1_patch
        cp NOTE_EXPTBL
        jp z,exptbl_patch
        ENDIF
        ret
.last:
        ld hl,pl_size   ; the last block ends with the file
        ld de,pt_end
        ld bc,3
        ldir
        jp block_fix
.header:
        ld hl,pt_off    ; the block before this header ends here
        ld de,pt_end
        ld bc,3
        ldir
        call block_fix
        jp pt_header
.done:
        pop hl
        jr .next

; At a caslink_reset note, pt_off at its LDIR: when its block, a binary file's,
; starts with JP 9030h after the file's 6 bytes of addresses, as CasLink3's parts
; do, and the five bytes after RST 30h are 0, the RST 30h and those bytes become
; CALL 006Fh, INIT32, which sets screen 1 as the boot does, and a JP to the ROM
; image's start, which the part holds 7 bytes after its own.
reset_patch:
        ld a,(pt_binary)
        or a
        ret z           ; not a binary file's block
        ld a,(pt_block+2)
        inc a
        ret z           ; no block yet
        ld hl,pt_off
        ld de,pt_save
        ld bc,3
        ldir
        ld hl,(pt_block)
        ld de,6
        add hl,de
        ld (pt_off),hl
        ld a,(pt_block+2)
        adc a,0
        ld (pt_off+2),a
        ld hl,rs_part
        xor a
        ld b,3
        call pt_match
        jr nz,.back
        ld a,7
        call pt_read
        ld (rs_start),a
        ld a,8
        call pt_read
        ld (rs_start+1),a
        call .back
        ld hl,rs_zeros
        ld a,8
        ld b,5
        call pt_match
        ret nz
        ld hl,rs_code
        ld bc,6 << 8 | 7 ; 6 bytes, from RST 30h's place on
.write:
        ld a,(hl)
        ld (pt_value),a
        ld a,c
        push hl
        push bc
        call pt_write
        pop bc
        pop hl
        inc hl
        inc c
        djnz .write
        ret
.back:
        ld hl,pt_save
        ld de,pt_off
        ld bc,3
        ldir
        ret

rs_part:
        db 0C3h, 30h, 90h       ; JP 9030h
rs_zeros:
        db 0, 0, 0, 0, 0
rs_code:
        db 0CDh, 6Fh, 00h       ; CALL 006Fh
        db 0C3h                 ; JP
rs_start:
        dw 0                    ; the ROM image's start

; At a header note: sets pt_binary from the file type when ten equal bytes
; follow the header, and notes where the block starts. In the BASIC variants it
; passes each identification block to basic_file, and each other block to
; basic_data.
pt_header:
        ld hl,pt_block
        ld de,pt_prev
        ld bc,3
        ldir            ; the block before this one
        ld hl,(pt_off)  ; the block starts after the header's 8 bytes
        ld de,8
        add hl,de
        ld (pt_block),hl
        ld a,(pt_off+2)
        adc a,0
        ld (pt_block+2),a
        ld a,8
        call pt_read
        ld (pt_value),a
        ld b,9
.same:
        ld a,18
        sub b
        push bc
        call pt_read
        pop bc
        ld hl,pt_value
        cp (hl)
        IF CASE_B
        jp nz,basic_data ; not ten equal bytes: no identification block
        ELSE
        jr nz,.done     ; not ten equal bytes: no identification block
        ENDIF
        djnz .same
        ld a,(pt_value)
        ld b,1
        cp 0D0h
        jr z,.type
        ld b,0
        cp 0D3h
        jr z,.type
        cp 0EAh
        jr nz,.done
.type:
        ld a,b
        ld (pt_binary),a
.done:
        IF CASE_B
        jp basic_file
        ELSE
        ret
        ENDIF

; Returns Z when the B bytes from A places after pt_off in the file equal the
; bytes at HL.
pt_match:
        ld c,a
.next:
        push hl
        push bc
        ld a,c
        call pt_read
        pop bc
        pop hl
        cp (hl)
        ret nz
        inc hl
        inc c
        djnz .next
        xor a           ; Z: all equal
        ret

; Reads into A the byte A places after pt_off in the file.
pt_read:
        call pt_page
        ld a,(hl)
        push af
        call pt_home
        pop af
        ret

; Writes pt_value to the byte A places after pt_off, as pt_write does, and adds
; the change to pt_xd, as an XOR, and to pt_sd, as a sum, for block_fix.
pt_write_x:
        push af
        call pt_read
        ld b,a          ; B = the old byte
        ld a,(pt_value)
        ld hl,pt_xd
        xor b
        xor (hl)
        ld (hl),a
        ld a,(pt_value)
        sub b
        ld hl,pt_sd
        add a,(hl)
        ld (hl),a
        ld hl,(pt_sd16)
        ld a,(pt_value)
        ld e,a
        ld d,0
        add hl,de
        ld e,b
        or a
        sbc hl,de
        ld (pt_sd16),hl
        pop af
        jp pt_write

; Keeps the checksum of the block from pt_block to pt_end, which the patches changed
; by pt_xd as an XOR and pt_sd as a sum. The checksum byte is the block's last byte
; that is not 0, among its last 8, before the padding. When the block's bytes XORed
; to 0 before the patches, it takes pt_xd as an XOR. Else, when it was the sum of
; the bytes before it, from the block's first byte or after 1 or 2 bytes of length,
; it becomes the new sum. Else, when it made the sum of those bytes 0, it loses
; pt_sd, so that the sum stays 0. Then pt_xd and pt_sd start again from 0.
block_fix:
        call head_fix
        ld a,(pt_xd)
        ld hl,pt_sd
        or (hl)
        ret z
        ld hl,pt_off
        ld de,pt_save
        ld bc,3
        ldir
        ; The block's length, and the place of its checksum byte.
        ld hl,(pt_end)
        ld de,(pt_block)
        or a
        sbc hl,de
        ld a,(pt_block+2)
        ld c,a
        ld a,(pt_end+2)
        sbc a,c
        jp nz,.restore  ; 64 KB or more: not looked at
        ld (pt_len),hl
        ld hl,pt_end
        ld de,pt_off
        ld bc,3
        ldir
        ld b,8
.back:
        push bc
        call off_dec
        ld hl,pt_block
        call off_below
        pop bc
        jp c,.restore   ; only 0 bytes
        push bc
        xor a
        call pt_read
        pop bc
        or a
        jr nz,.checksum
        djnz .back
        jp .restore
.checksum:
        ld (pt_cs),a
        ld hl,(pt_off)
        ld de,(pt_block)
        or a
        sbc hl,de
        ld (pt_plen),hl ; the checksum byte's place in the block
        ; One pass over the block: the XOR of all its bytes, and the sums of
        ; the bytes before the checksum byte, from places 0, 1 and 2.
        ld hl,pt_block
        ld de,pt_off
        ld bc,3
        ldir
        xor a
        ld (pt_x),a
        ld (pt_s0),a
        ld (pt_s1),a
        ld (pt_s2),a
        ld hl,0
        ld (pt_n),hl
.sum:
        xor a
        call pt_read
        ld b,a
        ld hl,pt_x
        xor (hl)
        ld (hl),a
        ld hl,(pt_n)
        ld de,(pt_plen)
        or a
        sbc hl,de
        jr nc,.counted  ; at or after the checksum byte
        ld hl,pt_s0
        ld a,b
        add a,(hl)
        ld (hl),a
        ld hl,(pt_n)
        ld a,h
        or l
        jr z,.counted
        ld hl,pt_s1
        ld a,b
        add a,(hl)
        ld (hl),a
        ld hl,(pt_n)
        dec hl
        ld a,h
        or l
        jr z,.counted
        ld hl,pt_s2
        ld a,b
        add a,(hl)
        ld (hl),a
.counted:
        call off_inc
        ld hl,(pt_n)
        inc hl
        ld (pt_n),hl
        ld de,(pt_len)
        or a
        sbc hl,de
        jr c,.sum
        ; The checksum byte's place again.
        ld hl,(pt_block)
        ld de,(pt_plen)
        add hl,de
        ld (pt_off),hl
        ld a,(pt_block+2)
        adc a,0
        ld (pt_off+2),a
        ld a,(pt_x)
        ld hl,pt_xd
        xor (hl)
        jr nz,.not_xor  ; the bytes did not XOR to 0 before
        ld a,(pt_cs)
        xor (hl)
        jr .write
.not_xor:
        ld hl,pt_s0
        call .was_sum
        jr z,.write
        ld hl,pt_s1
        call .was_sum
        jr z,.write
        ld hl,pt_s2
        call .was_sum
        jr z,.write
        ld hl,pt_s0
        call .was_zero
        jr z,.write
        ld hl,pt_s1
        call .was_zero
        jr z,.write
        ld hl,pt_s2
        call .was_zero
        jr nz,.restore
.write:
        ld (pt_value),a
        xor a
        call pt_write
.restore:
        ld hl,pt_save
        ld de,pt_off
        ld bc,3
        ldir
        xor a
        ld (pt_xd),a
        ld (pt_sd),a
        ret

; Returns Z, and the checksum byte less pt_sd in A, when the sum at HL and the
; checksum byte, less pt_sd, made 0.
.was_zero:
        ld a,(pt_sd)
        ld b,a
        ld a,(pt_cs)
        add a,(hl)
        sub b
        ld a,(pt_cs)
        ret nz
        sub b
        cp a            ; Z
        ret

; Returns Z, and the new sum in A, when the sum at HL, less pt_sd, was the
; checksum byte.
.was_sum:
        ld a,(pt_sd)
        ld b,a
        ld a,(hl)
        sub b
        ld b,a
        ld a,(pt_cs)
        cp b
        ld a,(hl)
        ret

; Keeps the 16-bit sum that a header block of Ben Koks' cassette loader holds for
; the block after it: when the block before pt_block is 24 bytes long and starts
; with ABh CDh EFh, its bytes 18 and 19 take pt_sd16, and its byte 22 changes so
; that its first 23 bytes still sum to 0. Then pt_sd16 starts again from 0.
head_fix:
        ld hl,(pt_sd16)
        ld a,h
        or l
        ret z
        ld a,(pt_prev+2)
        inc a
        jr z,.done      ; no block before
        ld hl,(pt_block)
        ld de,(pt_prev)
        or a
        sbc hl,de
        ld de,24+8      ; 24 bytes, then the next block's header
        or a
        sbc hl,de
        jr nz,.done
        ld hl,pt_off
        ld de,pt_save
        ld bc,3
        ldir
        ld hl,pt_prev
        ld de,pt_off
        ld bc,3
        ldir
        ld hl,koks_head
        xor a
        ld b,3
        call pt_match
        jr nz,.restore
        ld a,18
        call pt_read
        ld e,a
        ld a,19
        push de
        call pt_read
        pop de
        ld d,a          ; DE = the block's sum
        push de
        ld hl,(pt_sd16)
        add hl,de       ; HL = the new sum
        ld a,l
        ld (pt_value),a
        ld a,18
        push hl
        call pt_write
        pop hl
        ld a,h
        ld (pt_value),a
        ld a,19
        push hl
        call pt_write
        pop hl
        pop de
        ld a,l
        sub e
        ld b,a
        ld a,h
        sub d
        add a,b
        ld b,a          ; B = the change to the sum of bytes 18 and 19
        ld a,22
        push bc
        call pt_read
        pop bc
        sub b
        ld (pt_value),a
        ld a,22
        call pt_write
.restore:
        ld hl,pt_save
        ld de,pt_off
        ld bc,3
        ldir
.done:
        ld hl,0
        ld (pt_sd16),hl
        ret

koks_head:
        db 0ABh, 0CDh, 0EFh

; Returns carry when pt_off is below the 24-bit offset at HL.
off_below:
        ld a,(pt_off)
        sub (hl)
        inc hl
        ld a,(pt_off+1)
        sbc a,(hl)
        inc hl
        ld a,(pt_off+2)
        sbc a,(hl)
        ret

; Adds 1 to pt_off.
off_inc:
        ld hl,(pt_off)
        inc hl
        ld (pt_off),hl
        ld a,h
        or l
        ret nz
        ld hl,pt_off+2
        inc (hl)
        ret

; Takes 1 from pt_off.
off_dec:
        ld hl,(pt_off)
        ld a,h
        or l
        dec hl
        ld (pt_off),hl
        ret nz
        ld hl,pt_off+2
        dec (hl)
        ret

; Writes pt_value to the byte A places after pt_off in the file.
pt_write:
        call pt_page
        ld a,(pt_value)
        ld (hl),a
; Puts page 2's own segment back.
pt_home:
        ld a,(pl_p2)
        ld e,PUT_P2
        jp map_call

; Puts in page 2 the data segment of the byte A places after pt_off in the
; file, and returns its address there in HL.
pt_page:
        ld hl,(pt_off)
        ld e,a
        ld d,0
        add hl,de
        ld a,(pt_off+2)
        adc a,0
        ld b,a          ; B:HL = the file offset
        ld de,pl_segs
.segment:
        ld a,b
        or a
        jr nz,.further
        push de
        ld de,DATA_SIZE
        or a
        sbc hl,de
        add hl,de
        pop de
        jr c,.found     ; in this segment
.further:
        push de
        ld de,DATA_SIZE
        or a
        sbc hl,de
        ld a,b
        sbc a,0
        ld b,a
        pop de
        inc de
        jr .segment
.found:
        push de
        ld de,HOLE
        or a
        sbc hl,de
        add hl,de
        jr c,.before    ; before the hole
        inc hl
        inc hl
        inc hl
.before:
        ld de,8000h
        add hl,de
        pop de
        ld a,(de)
        push hl
        ld e,PUT_P2
        call map_call
        pop hl
        ret

