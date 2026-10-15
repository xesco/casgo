; CASGO's detector: reads a CAS file, picks the variant of CASGO that loads it,
; and loads that variant in its own place (docs/DESIGN.md, The detector).
;
; It finds the machine's internal RAM, reads the CAS file once in parts of 16
; KB and applies the rules of the cases to it, prints the variant, and then
; copies the variant, whose image follows the detector in CASGO.COM, to 0100h
; and runs it as DOS runs a program (DOS2-PIS 2.1 and 3.5). The variant is CASGO
; and the memory case's letter, and its command line holds the loader cases as
; an option, then the CAS path. An option before the path, such as /M or /CB,
; forces the cases it names.

BDOS    equ 0005h       ; MSX-DOS function entry (DOS2-PIS 2.3)
TPA_TOP equ 0006h       ; the end of the TPA, the address in the JP at 0005h (DOS2-PIS 2.3)
LOAD_FLAG equ 0037h     ; not 0 when a program was just loaded (DOS2-PIS 3.5)
CMDLINE equ 0080h       ; command line: a length byte, then the text (DOS2-PIS 2.3)
CONOUT  equ 02h         ; _CONOUT: print the character in E (DOS2-FCS 3.3)
STROUT  equ 09h         ; _STROUT: print a "$"-terminated string (DOS2-FCS 3.10)
OPEN    equ 43h         ; _OPEN: open a file, handle in B (DOS2-FCS 3.47)
CLOSE   equ 45h         ; _CLOSE: close a file handle (DOS2-FCS 3.49)
READ    equ 48h         ; _READ: read HL bytes to DE, count in HL (DOS2-FCS 3.52)

EXPTBL  equ 0FCC1h      ; slot of the main ROM, and which slots are expanded (Red Book ch. 6)
PSLOT   equ 0A8h        ; primary slot register (Red Book ch. 1)

PATH_SIZE equ 64        ; the CAS path, with its 0
CHUNK   equ 4000h       ; the bytes read at a time
KEEP    equ 16          ; the bytes of the previous read kept before the buffer
PROBE   equ 0B000h      ; the internal RAM search runs here, in page 2, above the buffer
LOADER_ROOM equ 256     ; the loader goes this far below the end of the TPA

        org 0100h       ; a .COM is loaded and started at 0100h (DOS2-PIS 2.1)

start:
        call take_path

        ; The internal RAM search switches pages 0 and 3, so it runs from page
        ; 2, with its stack there.
        ld hl,probe_image
        ld de,PROBE
        ld bc,probe_size
        ldir
        call probe

        call scan_file
        call pick
        call split_variant
        call print_choice
        jp load_variant

; Takes the option, when the command line starts with one, into opt_loader and
; opt_mem, and the CAS path, the next word, into cas_path. The option is "/" and
; up to two loader letters, P, C, N, S or B, and a memory letter, M, R, I or T.
take_path:
        ld hl,CMDLINE
        ld b,(hl)
        inc hl
        call .skip
        ld a,(hl)
        cp "/"
        jr nz,.path
        ld (opt_at),hl
        ld a,b
        ld (opt_left),a
        ld de,opt_loader ; DE = where the next loader letter goes
.option:
        inc hl
        dec b
        jr z,.usage
        ld a,(hl)
        cp " "
        jr z,.option_end
        and 0DFh        ; upper case
        ld c,a
        push hl
        ld hl,mem_letters
        call find_letter
        pop hl
        jr nz,.loader
        ld a,(opt_mem)
        or a
        jr nz,.bad      ; two memory letters
        ld a,c
        ld (opt_mem),a
        jr .option
.loader:
        push hl
        ld hl,loader_letters
        call find_letter
        pop hl
        jr nz,.bad
        ld a,e
        cp (opt_loader+2) & 0FFh
        jr z,.bad       ; more than two loader letters
        ld a,c
        ld (de),a
        inc de
        jr .option
.option_end:
        call .skip
        jr .path
.usage:
        ld de,usage
        jp exit_message
; Ends with "Unknown option: " and the option's word, copied into cas_path to
; be printed with it.
.bad:
        ld hl,(opt_at)
        ld a,(opt_left)
        ld b,a
        ld de,cas_path
.bad_copy:
        ld a,(hl)
        cp " "
        jr z,.bad_end
        ld (de),a
        inc hl
        inc de
        djnz .bad_copy
.bad_end:
        xor a
        ld (de),a
        ld de,unknown_option
        jp exit_with_path
; Skips the spaces at HL; B counts the characters left. Ends with the usage
; when none is left.
.skip:
        ld a,b
        or a
        jr z,.usage
        ld a,(hl)
        cp " "
        ret nz
        inc hl
        dec b
        jr .skip
.path:
        ld de,cas_path
        ld c,PATH_SIZE-1
.copy:
        ld a,(hl)
        cp " "
        jr z,.end
        ld (de),a
        inc hl
        inc de
        dec c           ; C = the room left in cas_path
        jr z,.too_long
        djnz .copy
.end:
        xor a
        ld (de),a
        ret
.too_long:
        ld de,path_too_long
        jp exit_message

; Reads the CAS file once and applies the rules (docs/CASES.md,
; Loader cases). A rule's pattern ends at one of the bytes that scan_table
; marks; only there does check look back for the rest.
scan_file:
        ld de,cas_path
        ld a,1          ; open for reading only
        ld c,OPEN
        call BDOS
        or a
        ld de,cannot_open
        jp nz,exit_with_path
        ld a,b
        ld (handle),a

        ld hl,scan_table
        ld de,scan_table+1
        ld bc,255
        ld (hl),0
        ldir
        ld a,1
        ld (scan_table+74h),a   ; a header's last byte
        ld (scan_table+00h),a   ; a tape call's or the Namco call's
        ld (scan_table+0A8h),a  ; OUT (0A8h),A's
        ld (scan_table+0D5h),a  ; the stub's build sequence's
        ld (scan_table+0E5h),a  ; the stub's build sequence's, with HL
        ld (scan_table+0FCh),a  ; LD A,(0FCC1h)'s
        ld (scan_table+22h),a   ; the BLOAD token's quote, CFh 22h
        ld (scan_table+"D"),a   ; the text BLOAD's
        ld (scan_table+2Fh),a   ; the slot moves' (move_tails)
        ld (scan_table+3Fh),a
        ld (scan_table+0Fh),a
        ld (scan_table+07h),a
        ld (scan_table+1Fh),a
        ld (scan_table+03h),a
        ld (scan_table+3Bh),a
        ld (scan_table+0B1h),a  ; also page 2's slot put in page 1 (page2to1_bytes)
        ld (scan_table+80h),a
        ld (scan_table+40h),a   ; the slot calls' (slot1_bytes)
        ld (scan_table+7Eh),a   ; the slot search's (search_bytes)
        ld (scan_table+"]"),a   ; CasLink3's text's (caslink_bytes)
        ld (scan_table+01h),a   ; the slot module's (module_bytes)
        ld (scan_table+04h),a   ; the Sydney engine's search's (sydney_bytes), and
                                ; the search for page 1 alone's (page1_bytes)
        ld hl,buffer-KEEP
        ld b,KEEP
.clear:
        ld (hl),0
        inc hl
        djnz .clear
        ld hl,0
        ld (d_base),hl
        xor a
        ld (d_base+2),a
.chunk:
        ld a,(handle)
        ld b,a
        ld de,buffer
        ld hl,CHUNK
        ld c,READ
        call BDOS       ; HL = the bytes read, 0 at the end of the file
        ld a,h
        or l
        jr z,.end
        ld b,h
        ld c,l
        push hl
        ld hl,buffer
        ld d,scan_table >> 8
.byte:
        ld e,(hl)
        ld a,(de)
        or a
        call nz,check
        inc hl
        dec bc
        ld a,b
        or c
        jr nz,.byte
        pop hl          ; the bytes read
        push hl
        ld de,(d_base)
        add hl,de
        ld (d_base),hl
        ld a,(d_base+2)
        adc a,0
        ld (d_base+2),a ; d_base = the file offset of the next read
        pop hl
        ld de,buffer-KEEP
        add hl,de       ; HL = the last KEEP bytes of this read
        ld bc,KEEP
        ldir
        jr .chunk
.end:
        call block_end
        call kt_end
        ld a,(handle)
        ld b,a
        ld c,CLOSE
        jp BDOS

; Looks back from the byte at HL, whose value is in E; BC counts the bytes of
; the read from it on. A pattern that ends in the bytes a binary file loads
; below 8000h does not count: BLOAD puts them into ROM on a cassette machine, so
; they never run. Keeps HL, BC and D.
check:
        push hl
        push bc
        ld a,e
        cp 74h
        jp z,.header
        push hl
        push af
        call rom_byte
        pop bc          ; B = the byte's value
        pop hl
        jp c,.done      ; a byte that BLOAD puts into ROM
        ld a,b
        or a
        jp z,.zero
        cp 0A8h
        jp z,.out
        cp 0D5h
        jp z,.build
        cp 0E5h
        jp z,.build
        cp 22h
        jp z,.token
        cp "D"
        jp z,.text
        cp "]"
        jp z,.caslink
        cp 01h
        jp z,.module
        cp 04h
        jp z,.sydney
        cp 40h
        jp z,.slot1
        cp 7Eh
        jp z,.search
        cp 0FCh
        jp nz,.move     ; the other marked bytes end slot moves
        ; FCh: LD A,(0FCC1h), which reads EXPTBL
        dec hl
        ld a,(hl)
        cp 0C1h
        jp nz,.done
        dec hl
        ld a,(hl)
        cp 3Ah
        jp nz,.done
        ld a,1
        ld (d_exptbl),a
        jp .done
.move:
        cp 0B1h         ; OR C: page 2's slot put in page 1, which needs T
        call z,page2to1_check
        call move_check
        jp .done
.sydney:
        ; The Sydney engine's search for RAM for page 1, which needs M too
        ld de,sydney_bytes
        ld b,(sydney_bytes_end-sydney_bytes)/2
        call match_before
        jr nz,.page1
        ld a,1
        ld (d_module),a
        jp .done
.page1:
        ; The search for RAM for page 1 alone, which needs T
        ld de,page1_bytes
        ld b,(page1_bytes_end-page1_bytes)/2
        call match_before
        jp nz,.done
        ld a,1
        ld (d_t),a
        jp .done
.module:
        ; A slot module that runs its copy of ENASLT from page 3 and selects the
        ; RAM it found, the mapper's on a machine whose mapper comes first
        ld de,module_bytes
        ld b,(module_bytes_end-module_bytes)/2
        call match_before
        jp nz,.done
        ld a,1
        ld (d_module),a
        jp .done
.caslink:
        ; CasLink3's text: its loader reads the tape through the BIOS and checks
        ; its data with a CRC, so the tape calls there never run
        ld de,caslink_bytes
        ld b,(caslink_bytes_end-caslink_bytes)/2
        call match_before
        jp nz,.done
        ld a,1
        ld (d_caslink),a
        jp .done
.search:
        ; The slot search from slot 3 down, whose RAM test finds the internal
        ; RAM's page 0 first
        ld de,search_bytes
        ld b,(search_bytes_end-search_bytes)/2
        call match_before
        jp nz,.done
        ld a,1
        ld (d_move),a
        jp .done
.slot1:
        ; The slot calls: the loader copies code into the RAM it finds for page
        ; 0, from slot 3 down, which is the internal RAM
        ld de,slot1_bytes
        ld b,(slot1_bytes_end-slot1_bytes)/2
        call match_before
        jp nz,.done
        pop bc          ; BC = the bytes of the read from HL on
        push bc
        ld a,b
        or a
        jr nz,.slot1_call
        ld a,c
        cp 4
        jp c,.done      ; the second call is past this read: no look
.slot1_call:
        ; then CALL nn with the first call's nn
        inc hl
        ld a,(hl)
        cp 0CDh
        jp nz,.done
        inc hl
        ld de,-6
        ex de,hl
        add hl,de       ; HL = the first call's nn, DE = the second's
        ld a,(de)
        cp (hl)
        jp nz,.done
        inc hl
        inc de
        ld a,(de)
        cp (hl)
        jp nz,.done
        ld a,1
        ld (d_move),a
        jp .done
.header:
        ld de,cas_header
        call compare
        jp nz,.done
        call kt_header  ; keeps HL
        push hl
        call block_end  ; changes HL
        pop hl
        pop bc
        push bc
        call block_start
        jp .done
.zero:
        ld de,namco_call
        call compare
        jr nz,.direct
        ld a,1
        ld (d_namco),a
        jp .done
.direct:
        dec hl          ; a tape call: CD or C3, then 00E1h, 00E4h or 00E7h
        ld a,(hl)
        cp 0E1h
        jr z,.opcode
        cp 0E4h
        jr z,.opcode
        cp 0E7h
        jp nz,.done
.opcode:
        dec hl
        ld a,(hl)
        cp 0CDh         ; CALL nn
        jr z,.call
        cp 0C3h         ; JP nn
        jp nz,.done
.call:
        ld a,1
        ld (d_call),a
        jp .done
.out:
        dec hl
        ld a,(hl)
        cp 0D3h         ; OUT (n),A
        jp nz,.done
        ld a,1
        ld (d_out),a
        ld (d_out_any),a
        inc hl          ; HL = the A8h
        ld de,level9_bytes
        ld b,(level9_bytes_end-level9_bytes)/2
        call match_before
        dec hl          ; HL = the D3h again
        jr nz,.not_level9
        ld a,1
        ld (d_t),a
.not_level9:
        ; After LD A,0FFh, slot 3 in every page: a LD DE,nn below 4000h in the
        ; 8 bytes after it is a copy into page 0 of slot 3, the internal RAM
        dec hl
        ld a,(hl)
        cp 0FFh
        jp nz,.done
        dec hl
        ld a,(hl)
        cp 3Eh          ; LD A,n
        jp nz,.done
        pop bc          ; BC = the bytes of the read from the A8h on
        push bc
        ld a,b
        or a
        ld b,8          ; B = the places to look at
        jr nz,.slot3
        ld a,c
        cp 12
        jr nc,.slot3
        sub 3           ; fewer when the read ends sooner
        jp c,.done
        jp z,.done
        ld b,a
.slot3:
        inc hl
        inc hl
        inc hl          ; HL = the A8h
.slot3_byte:
        inc hl
        ld a,(hl)
        cp 11h          ; LD DE,nn
        jr nz,.slot3_next
        inc hl
        inc hl
        ld a,(hl)       ; nn's high byte
        dec hl
        dec hl
        cp 40h
        jr nc,.slot3_next
        ld a,1
        ld (d_slot3),a
        jp .done
.slot3_next:
        djnz .slot3_byte
        jp .done
.build:
        ld de,stub_build
        call compare
        jr z,.stub
        ld de,stub_build_hl
        call compare
        jp nz,.done
.stub:
        ld a,1
        ld (d_stub),a
        jp .done
.token:
        dec hl          ; tokenized BASIC: the BLOAD token, then a quote
        ld a,(hl)
        cp 0CFh
        jp nz,.done
        jr .bload
.text:
        ld de,bload_text+3
        ld b,4          ; the text BLOAD, back from its D
.letter:
        dec hl
        ld a,(de)
        cp (hl)
        jp nz,.done
        dec de
        djnz .letter
.bload:
        ld a,1
        ld (d_bload),a
.done:
        pop bc
        pop hl
        ld d,scan_table >> 8
        ret

; Returns carry when the byte at HL in the buffer is one that a binary file
; loads below 8000h: when its file offset is below d_rom_end.
rom_byte:
        ld de,buffer
        or a
        sbc hl,de       ; HL = its place in the buffer; the kept bytes come before
        ld de,(d_base)
        add hl,de
        ld a,(d_base+2)
        adc a,0
        ld b,a          ; B:HL = the file offset
        ld de,(d_rom_end)
        or a
        sbc hl,de
        ld a,b
        ld hl,d_rom_end+2
        sbc a,(hl)      ; the offset less d_rom_end: carry when it is below
        ret

; At the last byte of a block header, at HL, with BC bytes of the read from it
; on: when the block is the identification block of a file, notes whether the
; file is binary; when it is the data block of a binary file, sets d_rom_end to
; the end of the bytes it loads below 8000h. The bytes after the header must be
; in this read, or the block is not looked at.
block_start:
        ld a,b
        or a
        jr nz,.room
        ld a,c
        cp 17
        ret c           ; the block's first bytes are in the next read
.room:
        inc hl          ; the block's first byte
        call known_bytes
        ld a,(hl)
        ld d,h
        ld e,l
        ld b,9
.same:
        inc de
        ld a,(de)
        cp (hl)
        jr nz,.data
        djnz .same
        ld a,(hl)       ; ten equal bytes: the file's type
        sub 0D0h
        jr z,.binary
        ld a,-1
.binary:
        inc a
        ld (d_bsave),a  ; 1 for a binary file, 0 for the others
        ret
.data:
        ld a,(d_bsave)
        or a
        ret z
        xor a
        ld (d_bsave),a
        ld e,(hl)
        inc hl
        ld d,(hl)       ; DE = the start address
        inc hl
        ld c,(hl)
        inc hl
        ld b,(hl)       ; BC = the end address
        inc hl
        ld a,d
        cp 40h
        jr nc,.page0_done
        ld a,b
        cp 40h
        jr c,.page0_done
        ld a,1
        ld (d_page0),a  ; from page 0 to page 1 or above
.page0_done:
        ld a,d
        cp 80h
        ret nc          ; it starts at 8000h or above
        inc hl
        inc hl          ; HL = the first byte the file loads
        push hl
        ld a,b
        cp 80h
        jr c,.below
        ld bc,7FFFh     ; it ends at 8000h or above: up to 7FFFh
.below:
        ld h,b
        ld l,c
        or a
        sbc hl,de       ; HL = the bytes below 8000h, less one
        pop de          ; DE = the first byte
        ret c           ; it ends before it starts
        inc hl
        push hl
        ex de,hl
        call rom_offset ; B:HL = the first byte's file offset
        pop de
        add hl,de
        ld (d_rom_end),hl
        ld a,b
        adc a,0
        ld (d_rom_end+2),a
        ret

; Returns in B:HL the file offset of the byte at HL in the buffer.
rom_offset:
        ld de,buffer
        or a
        sbc hl,de
        ld de,(d_base)
        add hl,de
        ld a,(d_base+2)
        adc a,0
        ld b,a
        ret

; At the byte at HL, OR C: sets d_t when the code that ends there puts page 2's
; slot in page 1 (page2to1_bytes). Keeps HL; changes AF, BC and DE.
page2to1_check:
        ld de,page2to1_bytes
        ld b,(page2to1_bytes_end-page2to1_bytes)/2
        call match_before
        ret nz
        ld a,1
        ld (d_t),a
        ret

; At the byte at HL, the last of a pattern in move_tails: sets d_move when the
; code that ends there follows IN A,(0A8h), at most 6 bytes after it. Changes
; AF, BC, DE and HL.
move_check:
        ld de,move_tails
.tail:
        ld a,(de)
        or a
        ret z           ; no tail ends at HL
        ld c,a          ; C = the tail's length
        inc de          ; DE = its bytes
        push hl
        push de
        ld b,0
        dec bc
        or a
        sbc hl,bc       ; HL = where the tail would start
        inc c
        ld b,c
.byte:
        ld a,(de)
        cp (hl)
        jr nz,.next
        inc de
        inc hl
        djnz .byte
        or a
        sbc hl,bc       ; HL = the tail's first byte (B is 0)
        ld b,7          ; IN A,(0A8h) right before it, or up to 6 bytes earlier
.in:
        dec hl
        ld a,(hl)
        cp PSLOT
        jr nz,.in_next
        dec hl
        ld a,(hl)
        inc hl
        cp 0DBh         ; IN A,(n)
        jr z,.found
.in_next:
        djnz .in
.next:
        pop de
        pop hl
        ex de,hl
        ld b,0
        add hl,bc       ; the next tail
        ex de,hl
        jr .tail
.found:
        pop de
        pop hl
        ld a,1
        ld (d_move),a
        ret

; The ends of the code that puts the slot of page 2 or 3, or slot 3, in page 0
; after IN A,(0A8h), each its length and then its bytes (docs/CASES.md, T0 in the
; internal RAM). Their last bytes are marked in scan_table.
move_tails:
        db 8, 0CBh, 2Fh, 0CBh, 2Fh, 0CBh, 2Fh, 0CBh, 2Fh  ; SRA A four times
        db 8, 0CBh, 3Fh, 0CBh, 3Fh, 0CBh, 3Fh, 0CBh, 3Fh  ; SRL A four times
        db 8, 0CBh, 0Fh, 0CBh, 0Fh, 0CBh, 0Fh, 0CBh, 0Fh  ; RRC A four times
        db 4, 0Fh, 0Fh, 0Fh, 0Fh                          ; RRCA four times
        db 4, 07h, 07h, 07h, 07h                          ; RLCA four times
        db 4, 1Fh, 1Fh, 1Fh, 1Fh                          ; RRA four times
        db 4, 07h, 07h, 0E6h, 03h                         ; RLCA, RLCA, AND 03h
        db 5, 0E6h, 0F0h, 4Fh, 0F6h, 0Fh                  ; AND 0F0h, LD C,A, OR 0Fh
        db 8, 0CBh, 3Bh, 0CBh, 3Bh, 0CBh, 3Bh, 0CBh, 3Bh  ; SRL E four times
        db 7, 0E6h, 0F0h, 4Fh, 06h, 0Fh, 78h, 0B1h        ; AND 0F0h, LD C,A, LD B,0Fh,
                                                          ; LD A,B, OR C
        db 6, 0E6h, 0F0h, 06h, 03h, 0F5h, 80h             ; AND 0F0h, LD B,03h, PUSH AF,
                                                          ; ADD A,B
        db 0

; CasLink3's text, [CasLink3]: the bytes before its last, "]", each its place
; before the "]" and its value.
caslink_bytes:
        db 1, "3", 2, "k", 3, "n", 4, "i", 5, "L", 6, "s", 7, "a", 8, "C", 9, "["
caslink_bytes_end:

; Returns Z when the B bytes at DE, each its place before HL and its value,
; match the file there. Keeps HL; changes AF, BC and DE.
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

; Compares the 7 bytes before HL with the first 7 of the 8-byte pattern at DE.
; Returns Z when they are equal. Keeps HL.
compare:
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

; Ends a block: the calls rule holds if this block writes the slot register
; with OUT (0A8h),A and this block or the one before calls the tape directly
; (docs/CASES.md, Tape calls).
block_end:
        ld a,(d_call)
        ld hl,d_prev
        or (hl)
        ld hl,d_out
        and (hl)
        ld hl,d_calls
        or (hl)
        ld (hl),a
        ld a,(d_call)
        ld (d_prev),a
        xor a
        ld (d_call),a
        ld (d_out),a
        ret

; Picks the variant: its loader letters, then its memory letter, after
; "CASGO" in variant. A known tape's cases fill in the option where the command
; line gave none; its memory letter needs RAM in the internal RAM's page 0, as
; on the machine its entry was measured on, unless it is M.
pick:
        ld hl,(kt_match)
        ld a,h
        or l
        jr z,.picked_known
        push hl
        inc hl
        inc hl
        inc hl
        ld a,(hl)
        ld (kt_patch),a ; the patch number, which the option gets in any case
        pop hl
        ld a,(opt_loader)
        or a
        jr nz,.known_mem
        ld a,(hl)
        ld (opt_loader),a
        inc hl
        ld a,(hl)
        ld (opt_loader+1),a
        dec hl
.known_mem:
        inc hl
        inc hl
        ld a,(opt_mem)
        or a
        jr nz,.picked_known
        ld a,(hl)
        cp "M"
        jr z,.known_set
        ld b,a
        ld a,(has_i)
        or a
        jr z,.picked_known
        ld a,b
.known_set:
        ld (opt_mem),a
.picked_known:
        ld hl,variant+5
        ld a,(d_caslink)
        or a
        jr nz,.namco
        ld a,(d_calls)
        or a
        jr z,.namco
        ld a,(d_stub)     ; the calls rule and the stub rule: the stub case
        or a
        jr nz,.namco
        ld (hl),"C"
        inc hl
        ld a,(d_bload)    ; the calls and BASIC case, CB
        or a
        jr z,.memory
        ld (hl),"B"
        inc hl
        jr .memory
.namco:
        ld a,(d_namco)
        or a
        jr z,.stub
        ld (hl),"N"
        inc hl
        jr .memory
.stub:
        ld a,(d_stub)
        or a
        ld a,"S"
        jr nz,.letter
        ; The BASIC case: the file loads with BLOAD, and it writes the slot
        ; register or holds a binary file that loads from page 0 on
        ; (docs/CASES.md, BASIC's own loads).
        ld a,(d_out_any)
        ld b,a
        ld a,(d_page0)
        or b
        ld b,a
        ld a,(d_bload)
        and b
        ld a,"P"
        jr z,.letter
        ld a,"B"
.letter:
        ld (hl),a
        inc hl
.memory:
        ; Loader letters from the option replace the picked ones, before the
        ; memory rules, which look at the loader case.
        ld a,(opt_loader)
        or a
        jr z,.picked
        ld hl,variant+5
        ld de,opt_loader
.forced:
        ld a,(de)
        or a
        jr z,.picked
        ld (hl),a
        inc hl
        inc de
        jr .forced
.picked:
        ; R when the machine has internal RAM; with RAM in its page 0 too, T for
        ; code that needs it (d_t), and I when the loader case is S, or the file
        ; writes the slot register,
        ; never reads EXPTBL and never takes the internal RAM for page 0, by a
        ; slot move or the BASIC case's slot calls; M on a machine without
        ; internal RAM (docs/CASES.md, T0 in the internal RAM). On a machine
        ; with a second RAM instead, the same rules give T for I and M for R
        ; (docs/CASES.md, T0 in a second RAM on an MSX2).
        ld a,(has_r)
        ld b,a
        ld a,(has_t2)
        or b
        ld a,"M"
        jr z,.memory_letter
        ld a,(d_module)
        or a
        ld a,"M"
        jr nz,.memory_letter
        ld a,(has_i)
        ld b,a
        ld a,(has_t2)
        or b
        jr z,.r
        ld a,(d_t)
        or a
        ld a,"T"
        jr nz,.memory_letter
        ld a,(d_slot3)
        or a
        jr nz,.r        ; even for the stub case
        dec hl
        ld a,(hl)       ; the loader case's last letter: S in the stub case
        inc hl
        cp "S"
        ld a,"I"
        jr z,.memory_letter
        ld a,(d_move)
        or a
        jr nz,.r
        ld a,(d_out_any)
        or a
        jr z,.r
        ld a,(d_exptbl)
        or a
        ld a,"I"
        jr z,.memory_letter
.r:
        ld a,"R"
.memory_letter:
        ld b,a
        ld a,(has_t2)
        or a
        jr z,.mapped
        ld a,b
        cp "R"
        jr nz,.not_r
        ld b,"M"        ; a second RAM serves only T0
.not_r:
        cp "I"
        jr nz,.mapped
        ld b,"T"
.mapped:
        ld a,(opt_mem)  ; a memory letter from the option replaces the picked one
        or a
        jr nz,.store
        ld a,b
.store:
        ld (hl),a
        inc hl
        ld (hl),0
        ret

; The known tapes (docs/CASES.md, Known tapes): a tape matches an entry of
; known_table when its blocks from number N on have the entry's lengths, or block
; N starts with the entry's bytes. The blocks are counted from the first header,
; and a block's length is the bytes from the end of its header to the next header
; or to the end of the file.

; At a header whose last byte is at HL: ends the block before it. Keeps HL.
kt_header:
        push hl
        call rom_offset ; B:HL = the header's last byte
        ld de,-7
        add hl,de
        ld a,b
        adc a,0FFh
        ld b,a          ; B:HL = the header's first byte
        call kt_close
        ld (kt_hdr),hl
        ld a,b
        ld (kt_hdr+2),a
        ld a,(kt_n)
        inc a
        jr z,.full      ; at most 255 headers count
        ld (kt_n),a
.full:
        pop hl
        ret

; At the end of the file: ends its last block.
kt_end:
        ld hl,(d_base)
        ld a,(d_base+2)
        ld b,a          ; B:HL = the file's length

; Ends the block that runs to B:HL, after the last header, if there is one: its
; length goes to kt_len and to known_block. Keeps B:HL.
kt_close:
        ld a,(kt_n)
        or a
        ret z
        push hl
        push bc
        ld de,(kt_hdr)
        or a
        sbc hl,de
        ld a,(kt_hdr+2)
        ld c,a
        ld a,b
        sbc a,c
        ld c,a
        ld de,8         ; the header
        or a
        sbc hl,de
        ld a,c
        sbc a,0
        ld (kt_len),hl
        ld (kt_len+2),a
        call known_block
        pop bc
        pop hl
        ret

; Adds kt_len, the length of block kt_n-1, to kt_hist, the last 6 lengths, and
; looks up the lengths entries of known_table that end at that block.
known_block:
        ld hl,kt_hist+3
        ld de,kt_hist
        ld bc,15
        ldir            ; the oldest length goes
        ld hl,kt_len
        ld bc,3
        ldir            ; DE = kt_hist+15: the newest
        ld hl,known_table
.entry:
        ld a,(hl)
        cp 0FFh
        ret z
        or a
        jr nz,.next     ; a bytes entry
        push hl
        inc hl
        ld a,(kt_n)
        dec a
        ld c,a          ; C = the block that just ended
        ld a,(hl)       ; the entry's first block
        inc hl
        ld b,(hl)       ; B = the count of lengths
        inc hl
        add a,b
        dec a
        cp c
        jr nz,.no       ; the entry's last block is another
        ld a,6
        sub b
        ld e,a
        add a,a
        add a,e         ; 3 x (6 - B): the oldest length to compare
        ld e,a
        ld d,0
        push hl
        ld hl,kt_hist
        add hl,de
        ex de,hl        ; DE = the lengths kept, HL = the entry's
        pop hl
        ld a,b
        add a,a
        add a,b
        ld b,a          ; 3 x B bytes
        call kt_compare
        jr nz,.no
        ld (kt_match),hl ; HL = the entry's letters
.no:
        pop hl
.next:
        call kt_skip
        jr .entry

; At a block's first byte, HL: looks up the bytes entries of known_table for
; block kt_n-1. Keeps HL, BC and DE. The block's first 8 bytes are in the
; buffer: block_start checks that before.
known_bytes:
        push hl
        push bc
        push de
        ex de,hl        ; DE = the block's first byte
        ld hl,known_table
.entry:
        ld a,(hl)
        cp 0FFh
        jr z,.done
        dec a
        jr nz,.next     ; a lengths entry
        push hl
        push de
        inc hl
        ld a,(kt_n)
        dec a
        cp (hl)
        jr nz,.no
        inc hl
        ld b,(hl)       ; the count of bytes
        inc hl
        call kt_compare
        jr nz,.no
        ld (kt_match),hl
.no:
        pop de
        pop hl
.next:
        call kt_skip
        jr .entry
.done:
        pop de
        pop bc
        pop hl
        ret

; Moves HL from a known_table entry to the next one. Changes AF and BC.
kt_skip:
        ld a,(hl)       ; the kind
        inc hl
        inc hl
        ld c,(hl)       ; the count of values
        inc hl
        or a
        ld a,c
        jr nz,.bytes
        add a,a
        add a,c         ; lengths: 3 bytes each
.bytes:
        add a,4         ; the letters and the patch number
        ld c,a
        ld b,0
        add hl,bc
        ret

; Returns Z when the B bytes at HL equal those at DE; moves both on.
kt_compare:
        ld a,(de)
        cp (hl)
        inc hl
        inc de
        ret nz
        djnz kt_compare
        ret

; Splits variant, "CASGO", the loader letters, the memory letter and a 0, into
; the variant's name, CASGO and the memory letter, and its command line in
; CMDLINE: " /", the loader letters and a known tape's patch number, unless the
; letter is P alone and there is no patch, then a space and the CAS path. Keeps
; the option for print_choice in option.
split_variant:
        ld hl,variant+5
.end:
        ld a,(hl)
        or a
        jr z,.found
        inc hl
        jr .end
.found:
        dec hl
        ld a,(hl)       ; the memory letter
        push af
        ld (hl),0       ; the loader letters, from variant+5, end here
        ld de,option
        ld a,(kt_patch)
        or a
        jr nz,.option   ; a patch: an option, P included
        ld a,(variant+5)
        cp "P"
        jr nz,.option
        ld a,(variant+6)
        or a
        jr z,.no_option ; the plain case alone: no option
.option:
        ld a," "
        ld (de),a
        inc de
        ld a,"/"
        ld (de),a
        inc de
        ld hl,variant+5
.letters:
        ld a,(hl)
        or a
        jr z,.patch
        ld (de),a
        inc hl
        inc de
        jr .letters
.patch:
        ld a,(kt_patch)
        or a
        call nz,.number
.no_option:
        xor a
        ld (de),a
        pop af
        ld (variant+5),a ; the name: CASGO and the memory letter
        xor a
        ld (variant+6),a
        ; The command line: the option, a space and the CAS path.
        ld hl,option
        ld de,CMDLINE+1
        call .copy
        ld a," "
        ld (de),a
        inc de
        ld hl,cas_path
        call .copy
        ld a,e
        sub (CMDLINE+1) & 0FFh
        ld (CMDLINE),a
        xor a
        ld (de),a
        ret
; Writes A, 1 to 255, in decimal at DE, and moves DE on. Changes AF, BC and HL.
.number:
        ld c,0          ; C = 1 once a digit is written
        ld b,100
        call .place
        ld b,10
        call .place
        add a,"0"
        ld (de),a
        inc de
        ret
.place:
        ld h,"0"-1
.sub:
        inc h
        sub b
        jr nc,.sub
        add a,b
        ld l,a          ; L = the rest
        ld a,h
        cp "0"
        jr nz,.write
        bit 0,c
        jr z,.skip      ; no leading 0
.write:
        ld (de),a
        inc de
        ld c,1
.skip:
        ld a,l
        ret
.copy:
        ld a,(hl)
        or a
        ret z
        ld (de),a
        inc hl
        inc de
        jr .copy

; Returns Z when the letter in C is in the zero-terminated list at HL.
find_letter:
        ld a,(hl)
        or a
        jr z,.no
        cp c
        ret z
        inc hl
        jr find_letter
.no:
        inc a           ; NZ
        ret

; Prints the CAS path and the variant with its option: "GAME.CAS: CASGOR /CB".
print_choice:
        ld hl,cas_path
        call print_zero
        ld e,":"
        ld c,CONOUT
        call BDOS
        ld e," "
        ld c,CONOUT
        call BDOS
        ld hl,variant
        call print_zero
        ld hl,option
        call print_zero
        ld de,crlf
        ld c,STROUT
        jp BDOS

; Runs the variant, whose image follows the detector in CASGO.COM, as DOS runs a
; program, with the same command line (docs/DESIGN.md, Loading the variant).
load_variant:
        ld a,(variant+5) ; the memory letter
        ld hl,images
.find:
        cp (hl)
        jr z,.found
        inc hl
        inc hl
        inc hl
        inc hl
        inc hl
        jr .find
.found:
        inc hl
        ld e,(hl)
        inc hl
        ld d,(hl)       ; DE = the image
        inc hl
        ld c,(hl)
        inc hl
        ld b,(hl)       ; BC = its bytes
        push de
        push bc
        ; The loader goes LOADER_ROOM bytes below the end of the TPA, where
        ; neither the image nor its copy at 0100h reach and the stack keeps its
        ; room.
        ld hl,(TPA_TOP)
        ld de,-LOADER_ROOM
        add hl,de
        push hl
        ex de,hl
        ld hl,loader
        ld bc,loader_end-loader
        ldir
        pop ix          ; IX = the loader
        pop bc
        pop hl          ; HL = the image, BC = its bytes
        jp (ix)

; The loader: copies the variant's image, BC bytes at HL, to 0100h, over the
; detector, and runs it as DOS starts a program, with the stack at the end of
; the TPA (DOS2-PIS 2.1). The copy goes down in memory, so LDIR reads each
; byte before it writes over it. LOAD_FLAG says that a program was loaded, as
; the command interpreter sets it before it runs one (DOS2-PIS 3.5): Boulder
; Dash II fails to start without it. The loader runs wherever it is copied: it
; holds no address of its own.
loader:
        ld de,0100h
        ldir
        ld a,1
        ld (LOAD_FLAG),a
        ld hl,(TPA_TOP)
        ld sp,hl
        ld hl,0
        push hl         ; RET ends the variant through 0000h
        jp 0100h
loader_end:

; The variants' images: the memory letter, the image's address and its bytes.
images:
        db "M"
        dw image_m, image_r-image_m
        db "R"
        dw image_r, image_i-image_r
        db "I"
        dw image_i, image_t-image_i
        db "T"
        dw image_t, images_end-image_t

; Prints the zero-terminated string at HL.
print_zero:
        ld a,(hl)
        or a
        ret z
        ld e,a
        ld c,CONOUT
        push hl
        call BDOS
        pop hl
        inc hl
        jr print_zero

; Prints the "$"-terminated message at DE, then the CAS path, and ends.
exit_with_path:
        call print_dos
        ld hl,cas_path
        call print_zero
        ld de,crlf
; Prints the "$"-terminated message at DE and ends with a jump to 0000h
; (DOS2-PIS 2.2).
exit_message:
        call print_dos
        jp 0000h

print_dos:
        ld c,STROUT
        jp BDOS

        include "patterns.asm"

usage:
        db "Usage: CASGO [/CASES] FILE.CAS",13,10,"$"
unknown_option:
        db "Unknown option: $"
bload_text:
        db "BLOA"       ; the text BLOAD before its D
path_too_long:
        db "Path too long",13,10,"$"
cannot_open:
        db "Cannot open: $"
crlf:
        db 13,10,"$"
variant:
        db "CASGO"
        ds 4            ; the letters and their 0, written by pick
option:
        ds 8            ; " /", the loader letters, the patch number and a 0, or a 0
opt_loader:
        ds 3            ; the option's loader letters and a 0
opt_mem:
        db 0            ; the option's memory letter, or 0
kt_n:   db 0            ; the headers so far, at most 255
kt_hdr: ds 3            ; the file offset of the last header
kt_len: ds 3            ; the length of the block that just ended
kt_hist: ds 18          ; the lengths of the last 6 blocks, the newest last
kt_match: dw 0          ; the letters of the matching entry, or 0
kt_patch: db 0          ; the patch number of the matching entry, or 0
        include "known.asm"
opt_at:
        dw 0            ; the option's "/" in the command line
opt_left:
        db 0            ; the characters left from it on
loader_letters:
        db "PCNSB",0
mem_letters:
        db "MRIT",0

handle:    db 0
d_call:    db 0         ; 1 when this block calls the tape directly
d_out:     db 0         ; 1 when this block writes the slot register
d_prev:    db 0         ; 1 when the block before called the tape directly
d_calls:   db 0         ; 1 when the calls rule held for a block
d_namco:   db 0         ; 1 when the file holds the Namco call
d_stub:    db 0         ; 1 when the file holds the stub's build sequence
d_out_any: db 0         ; 1 when the file writes the slot register
d_exptbl:  db 0         ; 1 when the file reads EXPTBL with LD A,(0FCC1h)
d_move:    db 0         ; 1 when the file takes the internal RAM for page 0
d_caslink: db 0         ; 1 when the file holds CasLink3's text: no calls case
d_module:  db 0         ; 1 when the file holds code that needs M
d_slot3:   db 0         ; 1 when the file copies into page 0 of slot 3
d_t:       db 0         ; 1 when the file holds code that needs T: Level 9's
                        ; search for RAM, page 2's slot put in page 1, or the
                        ; search for page 1 alone
d_bload:   db 0         ; 1 when the file holds BLOAD, as text or as its token
d_base:    ds 3         ; the file offset of buffer, the start of this read
d_bsave:   db 0         ; 1 after a binary file's identification block
d_rom_end: ds 3         ; the end of the bytes a binary file loads below 8000h
d_page0:   db 0         ; 1 when a binary file loads from page 0 to page 1 or above
cas_path: ds PATH_SIZE

; The internal RAM search, assembled for PROBE in page 2 and copied there.
probe_image:
        disp PROBE

; Finds whether the machine has internal RAM: a primary slot, not expanded and
; not page 3's, with RAM at FFFEh (has_r), and such a slot with RAM at 3FFEh
; too (has_i), as the R and I variants search (src/iram.asm). Interrupts are
; off meanwhile, and the stack is here, because the search switches pages 3
; and 0.
probe:
        di
        ld (p_sp),sp
        ld sp,p_stack_top
        in a,(PSLOT)
        ld (p_a8),a
        ld c,0          ; C = the slot tried
.slot:
        ld hl,EXPTBL
        ld b,0
        add hl,bc
        bit 7,(hl)
        jr nz,.next     ; expanded: not internal RAM
        ld a,(p_a8)
        rlca
        rlca
        and 03h
        cp c
        jr z,.next      ; page 3's own slot, the mapper
        ld a,c
        rrca
        rrca            ; the slot in bits 7-6
        ld b,a
        ld a,(p_a8)
        and 3Fh
        or b
        out (PSLOT),a
        ld hl,0FFFEh
        call p_ram
        jr nz,.next
        ld a,1
        ld (has_r),a
        ld a,(p_a8)
        and 0FCh
        or c
        out (PSLOT),a
        ld hl,3FFEh
        call p_ram
        jr nz,.next
        ld a,1
        ld (has_i),a
        jr .done
.next:
        inc c
        ld a,c
        cp 4
        jr nz,.slot
        ld a,(has_r)
        or a
        jr nz,.done
        ; No internal RAM: look for a second RAM, a subslot with RAM at 3FFEh in
        ; an expanded primary slot after page 3's, as the T variants search
        ; (src/iram.asm). Only a slot after the mapper's counts, because the
        ; loaders that need T take the first RAM from slot 0 up.
        ld a,(p_a8)
        rlca
        rlca
        and 03h
        ld c,a          ; C = the slot tried, from the mapper's up
.xslot:
        inc c
        ld a,c
        cp 4
        jr z,.done
        ld hl,EXPTBL
        ld b,0
        add hl,bc
        bit 7,(hl)
        jr z,.xslot     ; not expanded: tried above
        ld a,c
        rrca
        rrca            ; the slot in bits 7-6
        ld b,a
        ld e,0          ; E = the subslot tried
.xsub:
        call p_sub_set
        ld d,a          ; D = the subslot register as it was
        ld a,(p_a8)
        and 0FCh
        or c
        out (PSLOT),a   ; page 0: the slot, with the subslot tried
        ld hl,3FFEh
        call p_ram
        push af
        ld a,d
        call p_sub_put  ; the subslot register back
        pop af
        jr z,.second
        inc e
        ld a,e
        cp 4
        jr nz,.xsub
        jr .xslot
.second:
        ld a,1
        ld (has_t2),a
.done:
        ld sp,(p_sp)
        ei
        ret

; Selects subslot E for page 0 in the subslot register of the primary slot whose
; bits 7-6 are in B, and returns the register's old value in A. The register is at
; FFFFh in its slot and reads back inverted (Red Book ch. 1), so page 3 goes to the
; slot for the access and back to p_a8 after it. The stack is here, in page 2.
p_sub_set:
        ld a,(p_a8)
        and 3Fh
        or b
        out (PSLOT),a   ; page 3: the slot
        ld a,(0FFFFh)
        cpl
        push af
        and 0FCh
        or e
        ld (0FFFFh),a
        jr p_sub_back

; Writes A to the subslot register of the primary slot whose bits 7-6 are in B,
; as p_sub_set reaches it.
p_sub_put:
        push af
        ld a,(p_a8)
        and 3Fh
        or b
        out (PSLOT),a   ; page 3: the slot
        pop af
        ld (0FFFFh),a
        push af
p_sub_back:
        ld a,(p_a8)
        out (PSLOT),a   ; page 3 back
        pop af
        ret

; Returns Z when the byte at HL is RAM, keeping its value, and puts the slot
; register back to p_a8.
p_ram:
        ld a,(hl)
        cpl
        ld (hl),a
        cp (hl)
        cpl
        ld (hl),a
        push af
        ld a,(p_a8)
        out (PSLOT),a
        pop af
        ret

has_r:  db 0
has_i:  db 0
has_t2: db 0            ; 1 for a second RAM after the mapper's slot
p_sp:   dw 0
p_a8:   db 0
p_stack: ds 16
p_stack_top:
        ent
probe_size equ $-probe_image

; The four variants, as their .COM files are, which load_variant copies to 0100h
; (docs/DESIGN.md, Loading the variant).
image_m:
        incbin "CASGOM.COM"
image_r:
        incbin "CASGOR.COM"
image_i:
        incbin "CASGOI.COM"
image_t:
        incbin "CASGOT.COM"
images_end:

; The CAS file is read here, after KEEP bytes kept from the previous read; the
; table of check follows, on a 256-byte boundary.
buffer      equ ($+KEEP+255) & 0FF00h
scan_table  equ buffer+CHUNK
        assert scan_table+256 <= PROBE          ; below the search in page 2
