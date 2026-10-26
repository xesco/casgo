; A variant of CASGO: starts a cassette game from a CAS file, in three stages.
;
; Stage 1, in DOS: checks the BIOS, takes the CAS file from the command line and
; picks its load command, reads the whole file into mapper segments, patches the
; loaders of the variant's cases, and enters BASIC.
; Stage 2, in BASIC: cleans page 3 of the disk system, installs the slot
; wrappers (slots.asm), puts a copy of the BIOS with CASGO's tape routines in
; page 0, and types the load command.
; Stage 3, the game: the tape routines (tape.asm) give it the file's bytes from
; RAM. No DOS call happens from here on.
;
; Terms used in the source:
;   T0        the RAM segment in page 0 that holds CASGO's copy of the BIOS
;   P3        the segment in page 3, cleaned to be a cassette machine's page 3
;   data segments  the segments that hold the CAS file, 16381 bytes in each
;   window    page 1 (4000h), where stage 2 puts a segment such as T0 to write it
;   loader cases   C (calls), N (Namco), S (stub), B (BASIC): kinds of loader
;             that reach the tape in a way the plain case does not catch
;   memory cases   M (all in the mapper), R (pages 2 and 3 in an MSX1's own
;             RAM), I (T0 there too), T (only T0 there, or in a second RAM)
;
; The Makefile assembles one variant per memory case, with MEM_R, MEM_I or MEM_T
; set to 1, and CASE_C, CASE_N, CASE_S and CASE_B set to 1 in every variant; the
; command line's option says which loader cases run. The symbols below say which
; parts of the code a variant needs.
SCAN        equ CASE_C || CASE_N || CASE_S || CASE_B ; stage 1 scans and patches
TRAMPOLINES equ CASE_C || CASE_N                ; the table of tape entries
T0_ROUTINE  equ TRAMPOLINES || CASE_S || CASE_B ; tr_t0, in SLTWRK
HPARD_HOOK  equ CASE_S || CASE_B                ; H.PARD calls tr_t0
IRAM        equ MEM_R || MEM_I                  ; the game's pages 2 and 3
T0_IRAM     equ MEM_I || MEM_T                  ; T0 in the internal RAM
FIND_IRAM   equ IRAM || T0_IRAM                 ; stage 1 finds the internal RAM

BDOS    equ 0005h       ; MSX-DOS function entry (DOS2-PIS 2.3)
RDSLT   equ 000Ch       ; read the byte at HL in slot A; also in DOS (DOS2-PIS 2.3)
WRSLT   equ 0014h       ; write E to HL in slot A (Red Book ch. 4)
CALSLT  equ 001Ch       ; call IX in slot IYh (Red Book ch. 4)
MSXVER  equ 002Dh       ; MSX version: 0 for MSX1 (map.grauw.nl system variables)
EXTROM  equ 015Fh       ; MSX2 and later: call IX in the Sub-ROM (map.grauw.nl BIOS)
CMDLINE equ 0080h       ; command line: a length byte, then the text (DOS2-PIS 2.3)
CONOUT  equ 02h         ; _CONOUT: print the character in E (DOS2-FCS 3.3)
STROUT  equ 09h         ; _STROUT: print a "$"-terminated string (DOS2-FCS 3.10)
CLOSE   equ 45h         ; _CLOSE: close a file handle (DOS2-FCS 3.49)
OPEN    equ 43h         ; _OPEN: open a file, handle in B (DOS2-FCS 3.47)
READ    equ 48h         ; _READ: read HL bytes to DE, count in HL (DOS2-FCS 3.52)
SEEK    equ 4Ah         ; _SEEK: move the file pointer, A = method (DOS2-FCS 3.54)

ENASLT  equ 0024h       ; BIOS: put slot A in the page of address H (Red Book ch. 4)
CLS     equ 00C3h       ; BIOS: clear the screen, entered with Z set (Red Book ch. 4)
CHPUT   equ 00A2h       ; BIOS: print the character in A (Red Book ch. 4)
LC_C    equ 01h         ; lcase: the calls case
LC_N    equ 02h         ; the Namco case
LC_S    equ 04h         ; the stub case
LC_B    equ 08h         ; the BASIC case
RAMAD0  equ 0F341h      ; slot of the RAM for page 0 (map.grauw.nl system variables)
RAMAD1  equ 0F342h      ; slot of the RAM for page 1 (map.grauw.nl system variables)
PUTPNT  equ 0F3F8h      ; keyboard buffer: where the next key goes (Red Book ch. 6)
GETPNT  equ 0F3FAh      ; keyboard buffer: the next key to read (Red Book ch. 6)
KEYBUF  equ 0FBF0h      ; keyboard buffer: a ring of 40 bytes (Red Book ch. 6)
EXPTBL  equ 0FCC1h      ; slot of the main ROM (Red Book ch. 6)
SLTATR  equ 0FCC9h      ; what each extension ROM offers, 64 bytes (Red Book ch. 6)
SLTWRK  equ 0FD09h      ; work area of the extension ROMs, 128 bytes (Red Book ch. 6)
HOOKS   equ 0FD9Ah      ; the hooks, FD9Ah-FFC9h (Red Book ch. 6)
HOOKS_SIZE equ 0FFCAh-HOOKS
HPARD   equ 0FEB2h      ; hook: BASIC parses a device name (Red Book ch. 6)
ENTRIES equ SLTATR+18h  ; the table of tape entries, FCE1h: FCxxh for each 00xxh
EXTBIO  equ 0FFCAh      ; extended BIOS entry (DOS2-PIS 5.2)
MEMSIZ  equ 0F672h      ; the top of BASIC's string space (Red Book ch. 6)
STKTOP  equ 0F674h      ; the top of BASIC's stack, the bottom of its string space
DOS_ENTRY equ 0F37Dh    ; Disk BASIC's entry to the DOS; 00h on a cassette MSX
DOSON   equ 0F368h      ; $DOSON: maps the master disk ROM into page 1 (Nextor kernel/data.mac)
BASENT  equ 4022h       ; master disk ROM: enter Disk BASIC (Nextor kernel/bank0/doshead.mac)

PSLOT   equ 0A8h        ; primary slot register (Red Book ch. 1)
MAPPER1 equ 0FDh        ; mapper register of page 1

; Mapper support routines: offsets in the jump table EXTBIO returns (DOS2-PIS 5.2).
ALL_SEG equ 00h
GET_P0  equ 1Bh
GET_P1  equ 21h
PUT_P2  equ 24h
GET_P2  equ 27h
GET_P3  equ 2Dh

; The BIOS jump table entries of the tape routines, and where each one points
; in the BIOS CASGO knows (Red Book ch. 4).
TAPION  equ 00E1h
TAPIN   equ 00E4h
TAPIOF  equ 00E7h
TAPOON  equ 00EAh
TAPOUT  equ 00EDh
TAPOOF  equ 00F0h
STMOTR  equ 00F3h
OUTDO   equ 0018h           ; the RST 18h entry of OUTDO (Red Book ch. 4)

; The BIOS's tape code, which CASGO's tape routines replace in T0: from TAPOOF
; at 19DDh up to OUTDO at 1B45h (Red Book ch. 4).
TAPE_BASE equ 19DDh
TAPE_END  equ 1B45h

; Stage 2 runs in page 2, whose segment DOS and BASIC share, so it is still there in
; BASIC.
STAGE2  equ 0A000h

; Each data segment holds DATA_SIZE bytes of the CAS file: 16 KB less the hole, the
; 3 bytes of TAPIN's swap (tape.asm). Stage 2 copies page 2 of BASIC into the
; internal RAM with a copier at COPIER, in P3.
DATA_SIZE equ 4000h-3
COPIER  equ 0C000h

; The BASIC case: the BLOAD names stage 1 notes, and the binary files whose bytes
; below 4000h TAPIN drops.
NAMES_MAX equ 8
DROPS_MAX equ 4

; The CAS path, as typed; the bytes stage 1 reads to find the first header; and
; the bytes it reads at a time when it scans the whole file.
PATH_SIZE equ 64
SCAN_SIZE equ 256
SCAN_CHUNK equ DATA_SIZE ; one data segment's bytes, so a read fills a segment
SCAN_KEEP equ 11         ; the longest look-back, the BASIC case's slot calls'

; Page 1 is the window through which stage 2 writes T0 and reads P3, so an address
; seen there is the address in the segment plus WINDOW.
WINDOW  equ 4000h

        org 0100h       ; a .COM is loaded and started at 0100h (DOS2-PIS 2.1)

;----------------------------------------------------------------------------
; Stage 1, in DOS.

start:
        ; The TPA after this file holds what ran before, such as the detector,
        ; whose code, buffers and stack differ from one build to the next. The
        ; game later finds some of these bytes in its RAM, so the RAM's
        ; power-on pattern there, up to 16 bytes below the stack, makes the
        ; memory the game gets the same whichever program started this variant.
        ld hl,-16
        add hl,sp
        ld de,com_end
        or a
        sbc hl,de       ; HL = the bytes to fill
        ld b,h
        ld c,l
        ex de,hl
        call fill_pattern

        ; Stage 2 writes over the BIOS's tape code, so that code must be where
        ; CASGO expects it: each jump table entry into it, and the entry of the
        ; routine after it, must point where the Red Book says.
        ld hl,bios_entries
.check:
        ld e,(hl)       ; DE = the jump table entry
        inc hl
        ld d,(hl)
        inc hl
        ld a,d
        or e
        jr z,.known     ; end of the table
        ld c,(hl)       ; BC = where it must point
        inc hl
        ld b,(hl)
        inc hl
        push hl
        ex de,hl
        inc hl          ; the operand of the entry's JP
        call read_bios
        cp c
        jr nz,.unknown
        inc hl
        call read_bios
        cp b
.unknown:
        pop hl
        ld de,unknown_bios
        jp nz,print_dos
        jr .check
.known:
        ei              ; RDSLT leaves interrupts off (Red Book ch. 4)

        ld hl,stage2_image
        ld de,STAGE2
        ld bc,images_size
        ldir

        IF FIND_IRAM
        ; The internal RAM, which the variant's memory case needs. The search
        ; is part of stage 2's code, which is in page 2 now, as it needs.
        call iram_find
        ei
        ld a,(iram_toggle)
        or a
        ld de,no_iram
        jp z,exit_message
        ENDIF

        call find_type  ; returns only when the file is a CAS CASGO can load

        ; The mapper support routines. EXTBIO needs the stack in page 3, where
        ; DOS put it (DOS2-PIS 2.1), and returns A=0 when there is no support,
        ; and the free segments of the primary mapper in C (DOS2-PIS 5.2).
        xor a
        ld de,0402h     ; device 4 (mapper support), function 2 (jump table)
        call EXTBIO
        or a
        ld de,no_mapper
        jp z,print_dos
        ld (map_table),hl
        ld a,c
        ld (map_free),a

        ld e,GET_P0
        call map_call
        ld (seg_t0),a
        ld e,GET_P1
        call map_call
        ld (seg_p1),a
        ld e,GET_P2
        call map_call
        ld (seg_p2),a
        ld (pl_p2),a    ; also here: seg_p2 is in page 2, hidden by each copy
        ld e,GET_P3
        call map_call
        ld (seg_p3),a

        call preload
        IF SCAN
        call patch_tape
        ENDIF
        call apply_patches
        call tape_state

        ; The buffers of preload and of the scan, after this file and below
        ; page 2, hold parts of the CAS file, at places that change with each
        ; build. A game can take that RAM for its own, so it gets the power-on
        ; pattern there too.
        ld hl,com_end
        ld bc,8000h-com_end
        call fill_pattern

        ; The line BASIC runs first. Interrupts are off while the buffer is
        ; written, because the keyboard interrupt writes it too.
        ld hl,stage2_command
        call type_line

        xor a
        ld (CMDLINE),a  ; no argument: the BASIC entry runs RUN alone

        call DOSON
        jp BASENT       ; does not return; BASIC runs the line in the buffer

; Fills BC bytes from HL with the RAM's power-on pattern of a Philips VG-8020
; in openMSX, the machine CASGO's cassette runs are compared on: in each 512
; bytes, FFh FFh 00h 00h 64 times, then 00h 00h FFh FFh 64 times. So a byte is
; FFh when bits 1 and 8 of its address are equal. A loader that adds up RAM it
; never wrote, as Field Master's does, gets the sums it gets on that machine.
; Changes AF, BC and HL. Stage 1 and stage 2 each assemble it at their address.
        MACRO FILL_PATTERN
.byte:
        ld a,l
        rrca
        xor h
        and 1
        ld a,0FFh
        jr z,.ff
        xor a
.ff:
        ld (hl),a
        inc hl
        dec bc
        ld a,b
        or c
        jr nz,.byte
        ret
        ENDM

fill_pattern:
        FILL_PATTERN

; Takes the loader cases from the command line's option, /P, /C, /N, /S or /B
; or two of these letters, into lcase, and a known tape's patch number, which
; the letters can be followed by, into kp_set, and the CAS path into cas_path,
; finds the
; file's first header in its first SCAN_SIZE bytes, and puts the load command
; for its type into load_command. On any error it prints a message and ends
; CASGO.
find_type:
        ld hl,CMDLINE
        ld b,(hl)       ; the length of the command line
        inc hl
        call .skip
        ld a,(hl)
        cp "/"
        jr nz,.path
        ld (opt_at),hl
        ld a,b
        ld (opt_left),a
.option:
        inc hl
        dec b
        ld de,usage
        jp z,exit_message
        ld a,(hl)
        cp " "
        jr z,.option_end
        sub "0"
        cp 10
        jr c,.digit
        ld a,(hl)
        and 0DFh        ; upper case
        ld c,LC_C
        cp "C"
        jr z,.letter
        ld c,LC_N
        cp "N"
        jr z,.letter
        ld c,LC_S
        cp "S"
        jr z,.letter
        ld c,LC_B
        cp "B"
        jr z,.letter
        ld c,0
        cp "P"
        jp nz,bad_option
.letter:
        ld a,(lcase)
        or c
        ld (lcase),a
        jr .option
.digit:
        push bc
        ld c,a          ; C = the digit
        ld a,(kp_set)
        cp 26
        jr nc,.too_big  ; over 255
        ld b,a
        add a,a
        add a,a
        add a,b
        add a,a         ; 10 times
        add a,c
        jr c,.too_big
        ld (kp_set),a
        pop bc
        jr .option
.too_big:
        pop bc
        jp bad_option
.option_end:
        ld a,(kp_set)
        or a
        jr z,.set_ok    ; no patch
        dec a
        push hl
        ld hl,patch_table
        cp (hl)         ; the count of sets
        pop hl
        jp nc,bad_option ; no set with that number
.set_ok:
        call .skip
.path:
        ld de,cas_path
        ld c,PATH_SIZE-1
.copy:
        ld a,(hl)
        cp " "
        jr z,.copied
        dec c           ; C = the room left in cas_path
        jp z,.too_long
        ld (de),a
        inc hl
        inc de
        djnz .copy
.copied:
        xor a
        ld (de),a
        jr .open
; Skips the spaces at HL; B counts the characters left. Ends CASGO with the
; usage when none is left.
.skip:
        ld a,b
        or a
        ld de,usage
        jp z,exit_message
        ld a,(hl)
        cp " "
        ret nz
        inc hl
        dec b
        jr .skip
.open:
        ld de,cas_path
        ld a,1          ; open for reading only
        ld c,OPEN
        call BDOS
        or a
        ld de,cannot_open
        jp nz,exit_with_path
        push bc         ; B = the handle
        ld de,scan_buffer
        ld hl,SCAN_SIZE
        ld c,READ
        call BDOS       ; HL = the bytes read
        pop bc
        push hl
        ld c,CLOSE
        call BDOS
        pop bc          ; BC = the bytes read

        ; A header needs its 8 bytes and the 10 type bytes after it.
        ld hl,scan_buffer
.find:
        ld a,b
        or a
        jr nz,.room
        ld a,c
        cp 8+10
        ld de,no_header
        jp c,exit_with_path
.room:
        push hl
        push bc
        ld de,cas_header
        ld b,8
.compare:
        ld a,(de)
        cp (hl)
        jr nz,.differ
        inc hl
        inc de
        djnz .compare
        pop bc
        pop de          ; HL is now at the type bytes
        jr .type
.differ:
        pop bc
        pop hl
        inc hl
        dec bc
        jr .find

.type:
        ld a,(hl)
        ld b,10
.same:
        cp (hl)
        ld de,unknown_type
        jp nz,exit_with_path
        inc hl
        djnz .same
        ld hl,bload_command
        cp 0D0h         ; binary
        jr z,.command
        ld hl,cload_command
        cp 0D3h         ; tokenized BASIC
        jr z,.command
        ld hl,run_command
        cp 0EAh         ; ASCII
        jp nz,exit_with_path
        jr .command
.too_long:
        ld de,path_too_long
        jp exit_message
.command:
        push hl
        ld hl,clear_command
        ld de,load_command
        ld bc,clear_command_size
        ldir
        pop hl
.copy_command:
        ld a,(hl)
        ld (de),a
        inc hl
        inc de
        or a
        jr nz,.copy_command
        ret

; Reads the CAS file into the data segments, DATA_SIZE bytes in each, after checking
; that the free segments hold it. In the variants that patch the file, it also scans
; each read for the patterns of the variant's cases (scan.asm).
preload:
        ld de,cas_path
        ld a,1          ; open for reading only
        ld c,OPEN
        call BDOS
        or a
        ld de,cannot_open
        jp nz,exit_with_path
        ld a,b
        ld (scan_handle),a

        ; The file's size, from the pointer at its end; then back to its start.
        ld a,2          ; relative to the end
        ld de,0
        ld hl,0
        ld c,SEEK
        call BDOS       ; DE:HL = the size
        ld (pl_size),hl
        ld a,e
        ld (pl_size+2),a
        ld a,(scan_handle)
        ld b,a
        xor a           ; relative to the start
        ld d,a
        ld e,a
        ld h,a
        ld l,a
        ld c,SEEK
        call BDOS

        ; The segments the file needs: one for each DATA_SIZE bytes or part.
        ld hl,(pl_size)
        ld a,(pl_size+2)
        ld c,0          ; C = segments counted
.count:
        ld b,a
        or h
        or l
        jr z,.counted
        inc c
        ld de,DATA_SIZE
        or a
        sbc hl,de
        ld a,b
        sbc a,0
        jr nc,.count
.counted:
        ld a,c
        ld (pl_need),a
        ld hl,map_free
        cp (hl)
        jr z,.fits
        jr nc,.too_big
.fits:
        cp TP_SEGS_MAX+1
        jr c,.room
.too_big:
        ld de,no_memory
        call print_dos  ; "Not enough memory: " and the path
        call print_path
        ld de,needs
        call print_dos
        ld a,(pl_need)
        call print_number
        ld de,segments_free
        call print_dos
        ld a,(map_free)
        call print_number
        ld de,are_free
        jp exit_message
.room:
        IF SCAN
        call scan_init

        ; The SCAN_KEEP bytes before the buffer hold the end of the previous
        ; read, so that a pattern that two reads cut is still seen whole.
        ; pl_base is the file offset of the first of them.
        ld hl,scan_buffer-SCAN_KEEP
        ld b,SCAN_KEEP
.clear:
        ld (hl),0
        inc hl
        djnz .clear
        ld hl,-SCAN_KEEP
        ld (pl_base),hl
        ld a,0FFh
        ld (pl_base+2),a
        ld hl,pl_notes
        ld (pl_end),hl
        ENDIF
        ld hl,pl_segs
        ld (pl_seg_ptr),hl
.chunk:
        ld a,(scan_handle)
        ld b,a
        ld de,scan_buffer
        ld hl,SCAN_CHUNK
        ld c,READ
        call BDOS       ; HL = the bytes read, 0 at the end of the file
        ld a,h
        or l
        jp z,.end
        ld (pl_read),hl
        IF SCAN
        ld b,h
        ld c,l
        ld hl,scan_buffer
        ld d,scan_table >> 8
.byte:
        ld e,(hl)
        ld a,(de)
        or a
        call nz,scan_check
        inc hl
        dec bc
        ld a,b
        or c
        jr nz,.byte
        ENDIF

        ; The bytes into the next data segment, around the hole.
        ld a,1          ; system segment
        ld b,0          ; in the primary mapper
        ld e,ALL_SEG
        call map_call
        ld de,no_segment
        jp c,exit_message
        ld hl,(pl_seg_ptr)
        ld (hl),a
        inc hl
        ld (pl_seg_ptr),hl
        ld e,PUT_P2
        call map_call   ; page 2: the data segment
        ld hl,scan_buffer
        ld de,8000h
        ld bc,(pl_read)
        push bc
        ld bc,HOLE
        ldir            ; the bytes before the hole (a short read copies more,
        ex de,hl        ; which TAPIN never reaches)
        ld (hl),1Ah     ; LD A,(DE)
        inc hl
        ld (hl),0EDh    ; OUT (C),B
        inc hl
        ld (hl),41h
        inc hl
        ex de,hl
        pop hl
        ld bc,HOLE
        or a
        sbc hl,bc       ; HL = the bytes after the hole
        jr c,.copied
        jr z,.copied
        ld b,h
        ld c,l
        ld hl,scan_buffer+HOLE
        ldir
.copied:
        ld a,(pl_p2)
        ld e,PUT_P2
        call map_call   ; page 2: its own segment again

        IF SCAN
        ld hl,(pl_read)
        ld de,scan_buffer
        add hl,de
        ld de,-SCAN_KEEP
        add hl,de       ; HL = the last SCAN_KEEP bytes of this read
        ld de,scan_buffer-SCAN_KEEP
        ld bc,SCAN_KEEP
        ldir
        ld hl,(pl_base)
        ld de,DATA_SIZE
        add hl,de
        ld (pl_base),hl
        ld a,(pl_base+2)
        adc a,0
        ld (pl_base+2),a
        ENDIF
        jp .chunk
.end:
        ld a,(scan_handle)
        ld b,a
        ld c,CLOSE
        jp BDOS

; Applies patch set kp_set, a known tape's, which the option's number selects: when
; each patch's offset is in the file and its old byte is the file's byte there, each
; byte becomes its patch's new byte, XORed with T0's primary slot when the patch's
; flag is 1. Else the file stays as it is.
apply_patches:
        ld a,(kp_set)
        or a
        ret z
        dec a
        add a,a
        ld e,a
        ld d,0
        ld hl,patch_table+1
        add hl,de
        ld a,(hl)
        inc hl
        ld h,(hl)
        ld l,a          ; HL = the set
        ld b,(hl)       ; B = its count of patches
        inc hl
        push hl
        push bc
.check:
        call .offset    ; pt_off = the patch's offset; HL = its old byte
        push hl
        ld hl,pl_size
        call off_below
        pop hl
        jr nc,.differ   ; past the end of the file
        push hl
        push bc
        xor a
        call pt_read
        pop bc
        pop hl
        cp (hl)
        jr nz,.differ
        inc hl
        inc hl
        inc hl
        djnz .check
        pop bc
        pop hl
.write:
        call .offset
        inc hl
        ld a,(hl)       ; the new byte
        inc hl
        bit 0,(hl)
        jr z,.value
        ld c,a
        IF T0_IRAM
        ld a,(iram_slot)        ; T0 is in the internal RAM
        ELSE
        ld a,(RAMAD0)
        and 03h
        ENDIF
        xor c
.value:
        ld (pt_value),a
        inc hl
        push hl
        push bc
        xor a
        call pt_write
        pop bc
        pop hl
        djnz .write
        ret
.differ:
        pop bc          ; the set's count and place
        pop hl
        ret
; Copies the 3 bytes of a patch's offset at HL to pt_off; HL ends at its old
; byte.
.offset:
        ld de,pt_off
        ld a,(hl)
        ld (de),a
        inc hl
        inc de
        ld a,(hl)
        ld (de),a
        inc hl
        inc de
        ld a,(hl)
        ld (de),a
        inc hl
        ret

        include "patches.asm"

; Fills in the tape routines' state, in the tape image: the bytes to read, the
; first data segment, and the list of data segments.
tape_state:
        IF CASE_B
        call drop_counts
        ELSE
        ld hl,(pl_size)
        ld (tape_copy+tp_left-TAPE_BASE),hl
        ld a,(pl_size+2)
        ld (tape_copy+tp_left+2-TAPE_BASE),a
        ENDIF
        ld a,(pl_segs)
        ld (tape_copy+tp_seg-TAPE_BASE),a
        ld hl,pl_segs
        ld de,tape_copy+tp_segs-TAPE_BASE
        ld a,(pl_need)
        or a
        ret z
        ld c,a
        ld b,0
        ldir
        ret

; Prints the "$"-terminated message at DE, then the CAS path, and ends CASGO.
exit_with_path:
        call print_dos
        call print_path
        ld de,crlf
; Prints the "$"-terminated message at DE and ends CASGO with a jump to 0000h,
; which works at any stack depth (DOS2-PIS 2.2).
exit_message:
        call print_dos
        jp 0000h

; Ends CASGO with "Unknown option: " and the option's word, which goes into
; cas_path to be printed with it.
bad_option:
        ld hl,(opt_at)
        ld a,(opt_left)
        ld b,a
        ld de,cas_path
.copy:
        ld a,(hl)
        cp " "
        jr z,.copied
        ld (de),a
        inc hl
        inc de
        djnz .copy
.copied:
        xor a
        ld (de),a
        ld de,unknown_option
        jp exit_with_path

opt_at:   dw 0          ; the option's "/" in the command line
opt_left: db 0          ; the characters left from it on

; Prints the CAS path.
print_path:
        ld hl,cas_path
.next:
        ld a,(hl)
        or a
        ret z
        ld e,a
        ld c,CONOUT
        push hl
        call BDOS
        pop hl
        inc hl
        jr .next

; Prints A in decimal, without leading zeros.
print_number:
        ld c,0          ; C = 1 once a digit is printed
        ld b,100
        call .digit
        ld b,10
        call .digit
        ld c,1          ; the last digit always prints
        ld b,1
.digit:
        ld e,"0"-1
.count:
        inc e
        sub b
        jr nc,.count
        add a,b         ; A = the rest
        push af
        ld a,e
        cp "0"
        jr nz,.print
        ld a,c
        or a
        jr z,.skip      ; a leading zero
.print:
        ld c,1
        push bc
        ld c,CONOUT
        call BDOS
        pop bc
.skip:
        pop af
        ret

; Reads the byte at HL in the main ROM into A. Keeps BC and HL.
read_bios:
        push bc
        push hl
        ld a,(EXPTBL)
        call RDSLT
        pop hl
        pop bc
        ret

; Calls the mapper support routine at offset E of the jump table, with A and B
; as its parameters.
map_call:
        ld hl,(map_table)
        ld d,0
        add hl,de
        jp (hl)

; Prints the "$"-terminated string at DE through DOS.
print_dos:
        ld c,STROUT
        jp BDOS

        IF SCAN
        include "scan.asm"
        ENDIF
        IF CASE_C
        include "calls.asm"
        ENDIF
        IF CASE_N
        include "namco.asm"
        ENDIF
        IF CASE_S
        include "stub.asm"
        ENDIF
        IF CASE_B
        include "basic.asm"
        ENDIF

; The jump table entries into the tape code, and where each one points (Red
; Book ch. 4). STMOTR is not here: its code is not in the tape code, and it
; differs between BIOSes (1384h on the VG-8020, 1387h on the NMS 8250).
bios_entries:
        dw TAPION, 1A63h
        dw TAPIN,  1ABCh
        dw TAPIOF, 19E9h
        dw TAPOON, 19F1h
        dw TAPOUT, 1A19h
        dw TAPOOF, TAPE_BASE
        dw OUTDO,  TAPE_END     ; the routine after the tape code
        dw 0

map_table:
        dw 0
map_free:     db 0      ; the free segments of the primary mapper
pl_p2:        db 0      ; page 2's segment, kept here while page 2 holds data
pl_size:      ds 3      ; the CAS file's size, low byte first
pl_need:      db 0      ; the data segments it needs
pl_read:      dw 0      ; the bytes of the last read
pl_seg_ptr:   dw 0      ; where the next data segment goes in pl_segs
pl_segs:      ds TP_SEGS_MAX ; the data segments, in order
scan_handle:  db 0
        IF SCAN
pl_base:      ds 3      ; the file offset of scan_buffer-SCAN_KEEP
pl_end:       dw 0      ; the end of the notes
pt_binary:    db 0      ; 1 while patch_tape is in a binary file
pt_off:       ds 3      ; the file offset of the note patch_tape is at
pt_value:     db 0      ; the byte pt_write writes
pt_block:     ds 3      ; the file offset of the block of the last header note
pt_end:       ds 3      ; the end of that block, for block_fix
pt_xd:        db 0      ; the patches' change to the block, as an XOR
pt_sd:        db 0      ; and as a sum
pt_sd16:      dw 0      ; and as a 16-bit sum, for head_fix
pt_prev:      ds 3      ; the file offset of the block before pt_block's, FFh on top for none
pt_save:      ds 3      ; pt_off, kept while block_fix moves it
pt_len:       dw 0      ; the block's length
pt_plen:      dw 0      ; the place of its checksum byte
pt_n:         dw 0      ; the place block_fix is at
pt_cs:        db 0      ; the checksum byte
pt_x:         db 0      ; the XOR of the block's bytes
pt_s0:        db 0      ; the sums of the bytes before the checksum byte,
pt_s1:        db 0      ; from places 0, 1 and 2
pt_s2:        db 0
too_many:
        db "Too many blocks: $"
        ENDIF
        IF CASE_B
pt_names:     ds 6*NAMES_MAX ; the names that BLOADs of the BASIC program load
pt_nnames:    db 0
pt_pending:   db 0      ; 1 from a binary file's header to its data block's
pl_drops:     ds 5*DROPS_MAX ; each drop: its file offset, 3 bytes, and its length
pl_ndrops:    db 0
        ENDIF
        IF FIND_IRAM
no_iram:
        IF T0_IRAM
        db "No internal RAM with RAM in page 0",13,10,"$"
        ELSE
        db "No internal RAM",13,10,"$"
        ENDIF
        ENDIF
unknown_bios:
        db "Unknown BIOS: its tape code is not where CASGO expects",13,10,"$"
no_mapper:
        db "No mapper support",13,10,"$"
no_segment:
        db "No free mapper segment",13,10,"$"
no_memory:
        db "Not enough memory: $"
needs:
        db 13,10,"Needs $"
segments_free:
        db " segments, $"
are_free:
        db " are free",13,10,"$"
usage:
        db "Usage: CASGO"
        IF MEM_I
        db "I"
        ELSEIF MEM_T
        db "T"
        ELSEIF MEM_R
        db "R"
        ELSE
        db "M"
        ENDIF
        db " [/CNSB] FILE.CAS",13,10,"$"
path_too_long:
        db "Path too long",13,10,"$"
cannot_open:
        db "Cannot open: $"
no_header:
        db "No tape header: $"
unknown_option:
        db "Unknown option: $"
unknown_type:
        db "Unknown file type: $"
crlf:
        db 13,10,"$"

        include "patterns.asm"

; The load command for each file type. The CLEAR before it gives the game memory up
; to F380h, as on a machine without disk (Red Book ch. 6, HIMEM), and the USR call
; after it runs stage2_fill.
clear_command:
        db "CLEAR200,&HF380:A=USR(0)",13
clear_command_size equ $-clear_command
bload_command:
        db "BLOAD",34,"CAS:",34,",R",13,0
cload_command:
        db "CLOAD",13,"RUN",13,0
run_command:
        db "RUN",34,"CAS:",34,13,0

stage2_command:
        db "DEFUSR=&HA000:A=USR(0)",13,0
stage2_command_end:
        assert STAGE2 == 0A000h         ; the address typed in the line above
        assert stage2_command_end-stage2_command-1 < 40 ; a ring of 40 holds 39 keys

        IF FIND_IRAM
; Puts A in the slot register and returns Z when the byte at BFFEh is then RAM,
; with the slot register back to D. iram_find calls it to test page 2 of a slot,
; with interrupts off. iram_find, its variables and its stack are in page 2, so
; this is in page 0, and it uses no stack until page 2 is back.
iram_page2:
        out (PSLOT),a   ; page 2: the slot tried
        ld hl,0BFFEh
        ld a,(hl)
        cpl
        ld (hl),a
        cp (hl)
        cpl
        ld (hl),a
        ld a,d
        out (PSLOT),a   ; page 2 back, and with it the stack
        ret
        assert $ <= 8000h       ; it switches page 2, so it must stay out of it
        ENDIF

;----------------------------------------------------------------------------
; Stage 2, in BASIC: assembled for STAGE2 and copied there by stage 1,
; followed by the image of the tape routines.

stage2_image:
        disp STAGE2

stage2:
        jp stage2_setup ; the first USR call; stage2_fill the second
stage2_setup:
        ; P3 becomes a cassette-only machine's page 3: RET in every hook, so
        ; that no interrupt reaches the disk system, which the game does not
        ; need, because no DOS call follows. The DOS entry holds 00h, as on a
        ; cassette-only machine, because some loaders refuse to run when they
        ; find a disk system there, as Aackobase's does. SLTATR is cleared, so
        ; no extension ROM claims SLTWRK, which holds the slot wrappers.
        di
        ld hl,HOOKS
        ld (hl),0C9h
        ld de,HOOKS+1
        ld bc,HOOKS_SIZE-1
        ldir
        xor a
        ld (DOS_ENTRY),a
        ld hl,SLTATR
        ld (hl),0
        ld de,SLTATR+1
        ld bc,64-1
        ldir
        IF TRAMPOLINES
        ld hl,entries_copy
        ld de,ENTRIES
        ld bc,entries_size
        ldir
        ENDIF
        ld hl,slots_copy
        ld de,SLTWRK
        ld bc,slots_size
        ldir
        ld a,(EXPTBL)
        and 03h         ; the main ROM's primary slot
        ld (sw_rom+1),a

        IF T0_ROUTINE
        ; T0's slot for tr_t0: RAMAD0 is 1000SSPP, or 000000PP when not
        ; expanded; in the I and T variants T0 is in the internal RAM, not
        ; expanded.
        ld a,(RAMAD0)
        ld b,a
        IF T0_IRAM
        ld a,(iram_slot)
        ELSE
        and 03h
        ENDIF
        ld (tr_prim+1),a
        IF CASE_S
        ld (tr_t+1),a
        ENDIF
        IF FIND_IRAM
        ld a,0FFh       ; no subslot, or page 3 cannot reach T0's subslot register
        ELSE
        ld a,b
        rlca
        ld a,0FFh       ; no subslot
        jr nc,.subslot
        ld a,b
        rrca
        rrca
        and 03h
        ENDIF
.subslot:
        cp 0FFh
        jr nz,.sub
        ld a,18h        ; JR over the subslot code: no subslot to set
        ld (tr_sub),a
        ld a,tr_sub.primary-(tr_sub+2)
.sub:
        ld (tr_sub+1),a
        ENDIF

        IF HPARD_HOOK
        ; H.PARD: CALL tr_t0, then the RET already there, so that BASIC's own loads
        ; start with T0 in page 0. Only the stub and BASIC cases set it.
        ld a,(lcase)
        and LC_S|LC_B
        jr z,.no_hpard
        ld hl,HPARD
        ld (hl),0CDh
        inc hl
        ld (hl),tr_t0 & 0FFh
        inc hl
        ld (hl),tr_t0 >> 8
.no_hpard:
        ENDIF

        ; T0: a copy of the BIOS, with CASGO's tape routines in its tape code
        ; and the tape entries of its jump table pointing at them.
        ld a,(seg_t0)
        call open_window
        ld hl,0000h
        ld de,0000h+WINDOW
        ld bc,4000h
        ldir
        ld hl,tape_copy
        ld de,TAPE_BASE+WINDOW
        ld bc,tape_size
        ldir
        ld hl,tapion
        ld (TAPION+1+WINDOW),hl
        ld hl,tapin
        ld (TAPIN+1+WINDOW),hl
        ld hl,tapiof
        ld (TAPIOF+1+WINDOW),hl
        ld hl,tapoon
        ld (TAPOON+1+WINDOW),hl
        ld hl,tapout
        ld (TAPOUT+1+WINDOW),hl
        ld hl,tapoof
        ld (TAPOOF+1+WINDOW),hl
        ld hl,stmotr
        ld (STMOTR+1+WINDOW),hl
        ld hl,RDSLT
        ld de,sw_rdslt
        call patch_routine
        ld hl,WRSLT
        ld de,sw_wrslt
        call patch_routine
        ld hl,CALSLT
        ld de,sw_calslt
        call patch_routine
        ld a,(MSXVER)   ; page 0 is the ROM here
        or a
        jr z,.msx1      ; an MSX1 has no Sub-ROM
        ld hl,EXTROM
        ld de,sw_extrom
        call patch_routine
.msx1:
        ld a,(seg_t0)
        ld (tapin.t0+2+WINDOW),a        ; the segment TAPIN's swap puts back
        ld (tapin.seg+1+WINDOW),a
        IF T0_IRAM
        ld a,(iram_slot)
        ld (spare_tapion.slot+1+WINDOW),a
        ld (spare_tapin.slot+1+WINDOW),a
        call t0_to_iram
        ; The mapper's page 0 keeps T0 as a spare copy for the game, whose tape
        ; state does not move: its tape entries go to T0 instead.
        ld hl,spare_tapion
        ld (TAPION+1+WINDOW),hl
        ld hl,spare_tapin
        ld (TAPIN+1+WINDOW),hl
        ENDIF
        call close_window

        IF IRAM
        ; Pages 2 and 3 go to the internal RAM, with copies of BASIC's page 2
        ; and of P3; then T0 in page 0. ENASLT updates the slot variables in
        ; page 3, so page 3 must be final first.
        call iram_copy
        call iram_copy_page2
        ld a,(iram_toggle)
        ld b,a
        rrca
        rrca            ; the same slots for page 2, in bits 5-4
        or b
        ld b,a
        in a,(PSLOT)
        xor b
        out (PSLOT),a   ; pages 2 and 3: the internal RAM, with the copies;
                        ; this code goes on in the copy of page 2
        ENDIF
        IF T0_IRAM
        ld a,(iram_sub)
        cp 0FFh
        ld a,(iram_slot)
        jr z,.t0_slot
        ld b,a          ; a second RAM: ENASLT's form 1000SSPP, so that it sets
        ld a,(iram_sub) ; the subslot register and SLTTBL (Red Book ch. 4)
        rlca
        rlca
        or b
        or 80h
.t0_slot:
        ELSE
        ld a,(RAMAD0)
        ENDIF
        ld h,00h
        call ENASLT     ; T0 holds the same code as the ROM, so ENASLT runs on

        xor a           ; CLS clears only with Z set
        call CLS
        ld hl,stage2_fill
        ld (stage2+1),hl ; the next USR call fills the string space
        ld hl,load_command
        call type_line
        ei
        ret             ; back to BASIC, which runs the load command

; The second USR call, from the line of the CLEAR. The CLEAR has put BASIC's
; string space where a machine without disk has it, from STKTOP to MEMSIZ, and
; left there what Disk BASIC wrote, where that machine holds RAM that nothing
; wrote. Loaders can read it as data past the end of their blocks, as Binary
; Land's does, so it gets the power-on pattern, as the TPA does in stage 1.
stage2_fill:
        di
        ld hl,(MEMSIZ)
        ld de,(STKTOP)
        or a
        sbc hl,de       ; HL = the string space's bytes
        ld b,h
        ld c,l
        ex de,hl
        call fill_pattern2
        ei
        ret

        IF FIND_IRAM
        include "iram.asm"
        ENDIF
        IF T0_IRAM
        include "t0iram.asm"
        ENDIF


; Writes a jump to DE over the first bytes of the routine that the jump table
; entry at HL points to, in T0 seen through the window. The routine's address
; comes from the ROM's entry, which is in page 0.
patch_routine:
        inc hl
        ld a,(hl)
        inc hl
        ld h,(hl)
        ld l,a          ; HL = the routine
        ld bc,WINDOW
        add hl,bc
        ld (hl),0C3h    ; JP
        inc hl
        ld (hl),e
        inc hl
        ld (hl),d
        ret

; Opens the window: puts the RAM slot in page 1, showing segment A. Interrupts
; must be off, because the BASIC ROM is gone from page 1 meanwhile.
open_window:
        out (MAPPER1),a
        ld a,(RAMAD1)
        ld h,40h
        jp ENASLT

; Closes the window: the BASIC ROM back in page 1, and page 1's own segment
; back in the mapper.
close_window:
        ld a,(EXPTBL)
        ld h,40h
        call ENASLT
        ld a,(seg_p1)
        out (MAPPER1),a
        ret

; Fills BC bytes from HL with the RAM's power-on pattern, as fill_pattern does.
fill_pattern2:
        FILL_PATTERN

; Types the zero-terminated line at HL into the keyboard buffer, which it
; empties first. Interrupts are off meanwhile, because the keyboard interrupt
; writes the buffer too; they stay off.
type_line:
        di
        ld de,KEYBUF
        ld (GETPNT),de
.next:
        ld a,(hl)
        or a
        jr z,.end
        ld (de),a
        inc hl
        inc de
        jr .next
.end:
        ld (PUTPNT),de
        ret

; Written by stage 1.
kp_set: db 0            ; the patch set of the command line's option, or 0
lcase:  db 0            ; the loader cases of the command line's option: LC_C,
                        ; LC_N, LC_S and LC_B, or 0 for the plain case
seg_t0: db 0            ; T0: page 0 of DOS, for the BIOS copy
seg_p1: db 0            ; page 1's segment, put back after each copy
seg_p2: db 0            ; page 2's segment, BASIC's RAM there
seg_p3: db 0            ; P3: page 3 of DOS and BASIC

cas_path:
        ds PATH_SIZE    ; written by stage 1
load_command:
        ds 40           ; written by stage 1: the CLEAR, then the load command

        ent

; The tape routines, assembled for TAPE_BASE in T0.
tape_image:
        disp TAPE_BASE
        include "tape.asm"
tape_image_end:
        ent

; The slot wrappers, and the code of the variant's loader case that runs from
; page 3, assembled for SLTWRK in P3.
slots_image:
        disp SLTWRK
        include "slots.asm"
        IF T0_ROUTINE
        include "t0.asm"
        ENDIF
        IF TRAMPOLINES
        include "trampolines.asm"
        ENDIF
slots_image_end:
        ent

        IF TRAMPOLINES
entries_image:
        disp ENTRIES
        include "entries.asm"
entries_image_end:
        ent
entries_size equ entries_image_end-ENTRIES
entries_copy equ STAGE2+(entries_image-stage2_image)
        ENDIF

tape_size   equ tape_image_end-TAPE_BASE
slots_size  equ slots_image_end-SLTWRK
images_size equ $-stage2_image
tape_copy   equ STAGE2+(tape_image-stage2_image)   ; where stage 1 puts the images
slots_copy  equ STAGE2+(slots_image-stage2_image)
TP_SEGS_MAX equ TAPE_END-tp_segs                   ; the data segments TAPIN can list

        assert TAPE_BASE+tape_size <= TAPE_END  ; must fit in the BIOS's tape code
        IF T0_IRAM
        assert TP_SEGS_MAX >= 58                ; the Carnivore2's free segments, 950 KB
        ELSE
        assert TP_SEGS_MAX >= 64                ; 1 MB of CAS file at least
        ENDIF
        IF T0_IRAM
        assert slot_swap_end-slot_swap == tapin.swap-tapin.set_up ; the same 11 bytes
        assert slot_swap_x_end-slot_swap_x == slot_swap_end-slot_swap
        ENDIF
        assert slots_size <= 128                ; must fit in SLTWRK
        IF TRAMPOLINES
        assert e_tapion == (ENTRIES & 0FF00h) | (TAPION & 0FFh)
        assert e_tapin  == (ENTRIES & 0FF00h) | (TAPIN & 0FFh)
        assert e_tapiof == (ENTRIES & 0FF00h) | (TAPIOF & 0FFh)
        assert e_tapoon == (ENTRIES & 0FF00h) | (TAPOON & 0FFh)
        assert e_tapout == (ENTRIES & 0FF00h) | (TAPOUT & 0FFh)
        assert e_tapoof == (ENTRIES & 0FF00h) | (TAPOOF & 0FFh)
        assert e_stmotr == (ENTRIES & 0FF00h) | (STMOTR & 0FFh)
        assert entries_image_end <= SLTATR+64   ; must fit in SLTATR
        ENDIF
        assert (tp_header & 0FFh) <= 0F8h       ; TAPION compares low bytes only
        assert clear_command_size+14 <= 39      ; the line and the longest load
                                                ; command, 14 keys, fit the
                                                ; 40-byte keyboard ring

; Stage 1 reads the CAS file here, past the end of CASGO.COM, after SCAN_KEEP
; bytes kept from the previous read; the table of scan_check follows, on a
; 256-byte boundary for its lookups, and then the notes of preload. All of it
; stays below page 2, which holds each data segment in turn.
com_end:
scan_buffer equ com_end+SCAN_KEEP
scan_table  equ (scan_buffer+SCAN_CHUNK+255) & 0FF00h
pl_notes    equ scan_table+256
pl_notes_end equ pl_notes+4*1024        ; 1024 notes of 4 bytes
        assert pl_notes_end <= 8000h            ; must stay out of page 2
        assert STAGE2+images_size <= 0C000h     ; stage 2 and the image stay in page 2
