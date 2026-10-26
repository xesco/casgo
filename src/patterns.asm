; The byte patterns that the detector's rules and the variants' patches look for.
; casgo.asm and detect.asm both include this file, so that a rule and its patch
; find the same bytes. Each is 8 bytes long, and the scans compare the 7 bytes
; before the last one.

; A CAS block header.
cas_header:
        db 1Fh, 0A6h, 0DEh, 0BAh, 0CCh, 13h, 7Dh, 74h

; CasLink3's start of the ROM image it puts in RAM, LDIR / POP AF / AND 0FCh /
; OUT (0A8h),A / RST 30h: an inter-slot call of the reset, 0000h in slot 0, whose
; three bytes follow.
caslink_reset:
        db 0EDh, 0B0h, 0F1h, 0E6h, 0FCh, 0D3h, 0A8h, 0F7h

; The Namco case: the last bytes of the loader's call, OUT (0A8h),A / POP HL /
; POP AF / PUSH HL / CALL 0000h, whose low byte the loader writes.
namco_call:
        db 0D3h, 0A8h, 0E1h, 0F1h, 0E5h, 0CDh, 00h, 00h

; The stub case: the build sequence LD DE,00E1h / PUSH DE / LD DE,CDD9h /
; PUSH DE, and the same with 00EAh, TAPOON.
stub_build:
        db 11h, 0E1h, 00h, 0D5h, 11h, 0D9h, 0CDh, 0D5h
stub_build_ea:
        db 11h, 0EAh, 00h, 0D5h, 11h, 0D9h, 0CDh, 0D5h
; The same with HL: LD HL,00E1h / PUSH HL / LD HL,CDD9h / PUSH HL.
stub_build_hl:
        db 21h, 0E1h, 00h, 0E5h, 21h, 0D9h, 0CDh, 0E5h

; The BASIC case: IN A,(0A8h) / AND 0F0h / OUT (0A8h),A, which puts the ROM in
; pages 0 and 1. Its scan compares the 5 bytes before the last.
rom_back:
        db 0DBh, 0A8h, 0E6h, 0F0h, 0D3h, 0A8h

; The BASIC case's slot calls, LD A,(nn) / LD HL,0000h / CALL nn / LD HL,4000h,
; with which a loader restores pages 0 and 1: the bytes before LD HL,4000h's
; 40h that do not vary, each its place before the 40h and its value.
slot1_bytes:
        db 1, 00h, 2, 21h, 5, 0CDh, 6, 00h, 7, 00h, 8, 21h, 11, 3Ah
slot1_bytes_end:

; A slot search from slot 3 down, LD C,03h / LD B,00h / LD HL,0FCC1h /
; ADD HL,BC / BIT 7,(HL), which finds the internal RAM's page 0 first: the
; bytes before BIT 7,(HL)'s 7Eh, each its place before the 7Eh and its value.
search_bytes:
        db 1, 0CBh, 2, 09h, 3, 0FCh, 4, 0C1h, 5, 21h, 6, 00h, 7, 06h, 8, 03h, 9, 0Eh
search_bytes_end:

; The same search with DE for the slot, LD A,03h / LD (nn),A / LD E,A /
; LD D,00h / LD HL,0FCC1h / ADD HL,DE / BIT 7,(HL): the bytes before the 7Eh but
; nn's.
search_de_bytes:
        db 1, 0CBh, 2, 19h, 3, 0FCh, 4, 0C1h, 5, 21h, 6, 00h, 7, 16h, 8, 5Fh
        db 11, 32h, 12, 03h, 13, 3Eh
search_de_bytes_end:

; The same search from slot 0 up, XOR A / LD (nn),A / LD E,A / LD D,00h /
; LD HL,0FCC1h / ADD HL,DE / BIT 7,(HL): the bytes before the 7Eh but nn's.
search_up_bytes:
        db 1, 0CBh, 2, 19h, 3, 0FCh, 4, 0C1h, 5, 21h, 6, 00h, 7, 16h, 8, 5Fh
        db 11, 32h, 12, 0AFh
search_up_bytes_end:

; The end of a slot module's copy of ENASLT, LD B,A / POP AF / AND A / RET,
; and the CALL 0138h, RSLREG, after it: the module runs ENASLT from page 3, so
; it needs page 3 in the mapper's slot. The bytes before CALL 0138h's last, 01h,
; each its place before the 01h and its value.
module_bytes:
        db 1, 38h, 2, 0CDh, 3, 0C9h, 4, 0A7h, 5, 0F1h, 6, 47h
module_bytes_end:

; The start of the Sydney engine's search for RAM for page 1, IN A,(0A8h) /
; AND 0F3h / PUSH AF / AND 30h / LD B,A / POP AF / SUB 04h: from slot 0 up it
; finds the mapper first, and the game later puts page 2 there too, so it needs
; M. The bytes before SUB 04h's last, 04h, each its place before the 04h and its
; value.
sydney_bytes:
        db 1, 0D6h, 2, 0F1h, 3, 47h, 4, 30h, 5, 0E6h, 6, 0F5h, 7, 0F3h, 8, 0E6h
        db 9, 0A8h, 10, 0DBh
sydney_bytes_end:

; Level 9's search for RAM, IN A,(0A8h) / AND E / LD B,A / LD A,D / AND (HL) /
; OR B / OUT (0A8h),A: for pages 2, 1 and 0 in turn, it tries the slots from 0
; up through a table of slot register values and takes the first with RAM. It
; finds the mapper first, and the game then calls the BIOS with the slots of its
; start, so it needs pages 2 and 3 in the mapper and T0 out of it: T. The bytes
; before OUT (0A8h),A's last, A8h, each its place before the A8h and its value.
level9_bytes:
        db 1, 0D3h, 2, 0B0h, 3, 0A6h, 4, 7Ah, 5, 47h, 6, 0A3h, 7, 0A8h, 8, 0DBh
level9_bytes_end:

; Code that puts page 2's slot in page 1 as well, IN A,(0A8h) / LD C,A / SRL A /
; SRL A / AND 0Ch / OR C: a game whose search put the mapper in page 2 reads the
; mapper in page 1 too, so it needs T. The bytes before OR C, B1h, each its place
; before it and its value.
page2to1_bytes:
        db 1, 0Ch, 2, 0E6h, 3, 3Fh, 4, 0CBh, 5, 3Fh, 6, 0CBh, 7, 4Fh, 8, 0A8h, 9, 0DBh
page2to1_bytes_end:

; A search for RAM for page 1 alone that keeps page 2's slot, LD A,B / AND 30h /
; LD B,A / IN A,(0A8h) / AND 0F3h / SUB 04h: from slot 0 up it finds the mapper,
; and the game later puts page 1's slot in page 2, so it needs T. The bytes before
; SUB 04h's last, 04h, each its place before it and its value.
page1_bytes:
        db 1, 0D6h, 2, 0F3h, 3, 0E6h, 4, 0A8h, 5, 0DBh, 6, 47h, 7, 30h, 8, 0E6h, 9, 78h
page1_bytes_end:
