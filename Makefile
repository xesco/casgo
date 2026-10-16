# CASGO: build CASGO.COM, the detector with the four variants after it.
#
#   make           build build/CASGO.COM
#   make release   also build build/casgo.dsk, a disk image with Nextor and
#                  CASGO.COM for the openMSX setup in openmsx/
#   make test      on each test machine, boot Nextor or MSX-DOS 2 in openMSX and
#                  run CASGO at the DOS prompt; make test-vg8020 runs one machine,
#                  and make test-vg8020-bas one case on it
#   make games     run CASGO on the CAS files in games/ (see below)
#   make corpus    run CASGO on every CAS file in a folder (see below)
#   make clean     remove build/ (keeps the downloads and the assembler)
#
# The build needs make, curl, a C++ compiler and Python 3. It downloads the
# sjasmplus assembler's source, and for the disk image Nextor's NEXTOR.SYS and
# COMMAND2.COM, each pinned by version and SHA-256, into dl/, and builds the
# assembler into .tools/.
#
# The tests also need openMSX, with the test machines' system ROMs in SYSTEMROMS,
# the MSX-DOS 2 cartridge ROM among them. They download Nextor's kernel ROMs.
# MSX-DOS 2's own files cannot be downloaded: put your MSX-DOS 2 zip, with
# MSXDOS2.SYS and COMMAND2.COM at its top, in dl/MSXDOS2.zip.

SJASMPLUS_VERSION := 1.24.0
NEXTOR_ROM        := Nextor-2.1.4.SunriseIDE.ROM
NEXTOR_MFRSD_ROM  := Nextor-2.1.4.MegaFlashSDSCC.1-slot.ROM
SYSTEMROMS        ?= $(HOME)/.openMSX/share/systemroms

# CASGO's version, which its usage message shows: the git tag without its v, with
# the commits since it when there are any. The release workflow sets it.
VERSION ?= $(or $(patsubst v%,%,$(shell git describe --tags --always --dirty 2>/dev/null)),unknown)

DL        := dl
TOOLS     := .tools
BUILD     := build
SJASMPLUS := $(TOOLS)/sjasmplus

# A variant is CASGO with one memory case: M (the mapper), R (an MSX1's own RAM),
# I (T0 in that RAM too) or T (only T0 in that RAM, or in a second RAM on an MSX2).
# Each holds the code of every loader case.
MEMORY_CASES := M R I T
VARIANT_COMS := $(foreach m,$(MEMORY_CASES),$(BUILD)/CASGO$(m).COM)

.PHONY: all release test games corpus clean FORCE
all: $(BUILD)/CASGO.COM
release: $(BUILD)/CASGO.COM $(BUILD)/casgo.dsk

# The known tapes: the detector's table and the variants' patches, in one run.
$(BUILD)/known.asm: tools/known.py tools/known.tsv
	@mkdir -p $(BUILD)
	python3 -I tools/known.py tools/known.tsv $@ $(BUILD)/patches.asm

$(BUILD)/patches.asm: $(BUILD)/known.asm

# Rewritten only when the version changes, so that make rebuilds only then.
$(BUILD)/version.asm: FORCE
	@mkdir -p $(BUILD)
	@echo '        db "$(VERSION)"' > $@.new
	@cmp -s $@.new $@ && rm $@.new || mv $@.new $@

$(BUILD)/CASGO.COM: src/detect.asm src/patterns.asm $(BUILD)/known.asm $(BUILD)/version.asm $(VARIANT_COMS) $(SJASMPLUS)
	$(SJASMPLUS) --nologo --msg=war -I$(BUILD) --raw=$@ --lst=$(BUILD)/detect.lst $<

$(BUILD)/casgo.dsk: tools/mkdisk.py $(DL)/NEXTOR.SYS $(DL)/COMMAND2.COM $(BUILD)/CASGO.COM
	python3 -I tools/mkdisk.py $@ $(DL)/NEXTOR.SYS $(DL)/COMMAND2.COM $(BUILD)/CASGO.COM

variant_flags = -DCASE_C=1 -DCASE_N=1 -DCASE_S=1 -DCASE_B=1 \
                -DMEM_R=$(if $(filter R,$(1)),1,0) -DMEM_I=$(if $(filter I,$(1)),1,0) \
                -DMEM_T=$(if $(filter T,$(1)),1,0)

define variant
$(BUILD)/CASGO$(1).COM: $(wildcard src/*.asm) $(BUILD)/patches.asm $(SJASMPLUS)
	@mkdir -p $(BUILD)
	$(SJASMPLUS) --nologo --msg=war -I$(BUILD) $(call variant_flags,$(1)) --raw=$$@ --lst=$(BUILD)/CASGO$(1).lst src/casgo.asm
endef
$(foreach m,$(MEMORY_CASES),$(eval $(call variant,$(m))))

# The test CAS files (test/boot.tcl): TEST.CAS, a binary that prints BIN OK;
# SKEWED.CAS, the same with no header at a multiple of 8; BADTYPE.CAS, with a type
# byte CASGO does not know; NOHDR.CAS, with no header; BIG.CAS, TEST.CAS padded to
# more than the free segments of any test machine hold; BASOK.CAS and ASCOK.CAS,
# BASIC programs, tokenized and ASCII, that print BAS OK and ASC OK; IM2.CAS, a
# binary that reads the 16384-byte file after it in interrupt mode 2 and prints IM2
# OK; STUB.CAS, a binary that reads the 16384-byte file after it through a stub
# loader's stub and prints STUB OK; STUBHL.CAS, the same through a stub built with
# LD HL, which prints STUB HL OK; NEXT.CAS, a binary whose tape calls need the
# rewrite only because of the OUT (0A8h),A in the block after it, and that prints
# NEXT OK; PARD.CAS, a BASIC program that BLOADs a binary that puts the ROM in page
# 0, then BLOADs TEST.CAS's binary and prints PARD OK; TAPD.CAS, a binary that
# checks that TAPIN leaves the byte in D, and prints TAPIN D OK; NAMCO.CAS, a binary
# that reads the block after it through a tape call it builds at run time, and
# prints NAMCO OK; CB.CAS, a BASIC program that BLOADs the binary that puts the ROM
# in page 0, then BLOADs NEXT.CAS's binary, which prints NEXT OK; DROP.CAS, a BASIC
# program that BLOADs 18 KB of FFh from 0000h, which a cassette machine's ROM drops,
# then TEST.CAS's binary, and that names a file too long for a tape in a REM;
# HOOK.CAS, a BASIC program that BLOADs a binary that puts RET in every hook and the
# ROM in pages 0 and 1, then BLOADs TEST.CAS's binary and prints HOOK OK;
# SHIFT.CAS, a binary that shifts the slot register's value as Level 9's loader
# does, and prints SHIFT OK; SLOTS.CAS, a BASIC program that BLOADs a binary that
# restores pages 0 and 1 as Capitan Sevilla's loader does, then BLOADs TEST.CAS's
# binary and prints SLOTS OK; MODULE.CAS, a binary whose data holds the slot
# module's bytes that make the detector pick M, and that prints MODULE OK;
# SYDNEY.CAS, the same with the Sydney engine's search, which prints SYDNEY OK;
# LEVEL9.CAS, the same with Level 9's search for RAM, which prints LEVEL9 OK;
# KNOWN.CAS and KNOWNB.CAS, TEST.CAS's binary padded to 777 and 333 bytes, the
# known tapes of the test entries in tools/known.tsv, by block lengths and by
# first bytes, which print BIN OK; PATCH.CAS, the same padded to 555 bytes with
# BIN OK changed to BIN NO, which its entry's patch changes back;
# PAGE21.CAS, the same with code that puts page 2's slot in page 1, which prints
# PAGE21 OK; PAGE1.CAS, the same with a search for RAM for page 1 alone, which
# prints PAGE1 OK;
# EXPTBL.CAS, a BASIC program that BLOADs a binary holding Satan's restore of pages
# 1 and 0, which prints EXPTBL OK when CASGO changed its read of EXPTBL; SLOT3.CAS,
# a binary whose data holds a copy into page 0 of slot 3, and that prints SLOT3 OK;
# CASLINK.CAS, a binary laid out as a part of a CasLink3 tape, which starts its
# ROM image through a reset and prints CASLINK OK when CASGO changed the reset;
# SHORT.CAS, a BASIC program that BLOADs a binary whose block is one byte short, so
# that BLOAD reads the next header's first byte, then BLOADs TEST.CAS's binary by
# its name and prints SHORT OK.
$(BUILD)/%.bin: test/%.asm $(SJASMPLUS)
	@mkdir -p $(BUILD)
	$(SJASMPLUS) --nologo --msg=war --raw=$@ $<

$(BUILD)/TEST.CAS: tools/mkcas.py $(BUILD)/binok.bin
	python3 -I tools/mkcas.py $@ binary BINOK 9000 9000 $(BUILD)/binok.bin

$(BUILD)/KNOWN.CAS: tools/mkcas.py $(BUILD)/binok.bin
	python3 -I -c "import sys; d=open(sys.argv[1],'rb').read(); open(sys.argv[2],'wb').write(d+bytes(777-len(d)))" $(BUILD)/binok.bin $(BUILD)/knownok.bin
	python3 -I tools/mkcas.py $@ binary KNOWN 9000 9000 $(BUILD)/knownok.bin

$(BUILD)/KNOWNB.CAS: tools/mkcas.py $(BUILD)/binok.bin
	python3 -I -c "import sys; d=open(sys.argv[1],'rb').read(); open(sys.argv[2],'wb').write(d+bytes(333-len(d)))" $(BUILD)/binok.bin $(BUILD)/knownbok.bin
	python3 -I tools/mkcas.py $@ binary KNOWNB 9000 9000 $(BUILD)/knownbok.bin

$(BUILD)/PATCH.CAS: tools/mkcas.py $(BUILD)/binok.bin
	python3 -I -c "import sys; d=open(sys.argv[1],'rb').read(); i=d.find(b'BIN OK'); d=d[:i]+b'BIN NO'+d[i+6:]; open(sys.argv[2],'wb').write(d+bytes(555-len(d)))" $(BUILD)/binok.bin $(BUILD)/patchok.bin
	python3 -I tools/mkcas.py $@ binary PATCH 9000 9000 $(BUILD)/patchok.bin

$(BUILD)/SHIFT.CAS: tools/mkcas.py $(BUILD)/shiftok.bin
	python3 -I tools/mkcas.py $@ binary SHIFT 9000 9000 $(BUILD)/shiftok.bin

$(BUILD)/MODULE.CAS: tools/mkcas.py $(BUILD)/moduleok.bin
	python3 -I tools/mkcas.py $@ binary MODULE 9000 9000 $(BUILD)/moduleok.bin

$(BUILD)/SYDNEY.CAS: tools/mkcas.py $(BUILD)/sydneyok.bin
	python3 -I tools/mkcas.py $@ binary SYDNEY 9000 9000 $(BUILD)/sydneyok.bin

$(BUILD)/LEVEL9.CAS: tools/mkcas.py $(BUILD)/level9ok.bin
	python3 -I tools/mkcas.py $@ binary LEVEL9 9000 9000 $(BUILD)/level9ok.bin

$(BUILD)/PAGE21.CAS: tools/mkcas.py $(BUILD)/page21ok.bin
	python3 -I tools/mkcas.py $@ binary PAGE21 9000 9000 $(BUILD)/page21ok.bin

$(BUILD)/PAGE1.CAS: tools/mkcas.py $(BUILD)/page1ok.bin
	python3 -I tools/mkcas.py $@ binary PAGE1 9000 9000 $(BUILD)/page1ok.bin

$(BUILD)/EXPTBL.CAS: tools/mkcas.py test/exptblok.bas $(BUILD)/exptblok.bin
	python3 -I tools/mkcas.py $(BUILD)/exptbla.cas ascii EXPTOK test/exptblok.bas
	python3 -I tools/mkcas.py $(BUILD)/exptblb.cas binary EXPT 9000 9000 $(BUILD)/exptblok.bin
	cat $(BUILD)/exptbla.cas $(BUILD)/exptblb.cas > $@

$(BUILD)/CASLINK.CAS: tools/mkcas.py $(BUILD)/caslinkok.bin
	python3 -I tools/mkcas.py $@ binary CASLNK 9000 9000 $(BUILD)/caslinkok.bin

$(BUILD)/SLOT3.CAS: tools/mkcas.py $(BUILD)/slot3ok.bin
	python3 -I tools/mkcas.py $@ binary SLOT3 9000 9000 $(BUILD)/slot3ok.bin

$(BUILD)/SHORT.CAS: tools/mkcas.py test/shortok.bas $(BUILD)/binok.bin
	python3 -I tools/mkcas.py $(BUILD)/shorta.cas ascii SHRTOK test/shortok.bas
	python3 -I tools/mkcas.py --short $(BUILD)/shortb.cas binary SHORT A000 A000 $(BUILD)/binok.bin
	python3 -I tools/mkcas.py $(BUILD)/shortc.cas binary BINOK 9000 9000 $(BUILD)/binok.bin
	cat $(BUILD)/shorta.cas $(BUILD)/shortb.cas $(BUILD)/shortc.cas > $@

$(BUILD)/SKEWED.CAS: tools/mkcas.py $(BUILD)/binok.bin
	python3 -I tools/mkcas.py --skew 3 $@ binary BINOK 9000 9000 $(BUILD)/binok.bin

$(BUILD)/BADTYPE.CAS: tools/mkcas.py $(BUILD)/binok.bin
	python3 -I tools/mkcas.py --type 55 $@ binary BINOK 9000 9000 $(BUILD)/binok.bin

$(BUILD)/BIG.CAS: $(BUILD)/TEST.CAS
	python3 -I -c "import sys; d=open(sys.argv[1],'rb').read(); open(sys.argv[2],'wb').write(d+bytes(430000-len(d)))" $< $@

$(BUILD)/NOHDR.CAS:
	@mkdir -p $(BUILD)
	python3 -I -c "import sys; open(sys.argv[1], 'wb').write(bytes(64))" $@

$(BUILD)/BASOK.CAS: tools/mkcas.py $(BUILD)/basok.bin
	python3 -I tools/mkcas.py $@ basic BASOK $(BUILD)/basok.bin

$(BUILD)/IM2.CAS: tools/mkcas.py $(BUILD)/im2ok.bin
	python3 -I -c "import sys; open(sys.argv[1], 'wb').write(bytes((n + n // 256) % 256 for n in range(16384)))" $(BUILD)/im2data.bin
	python3 -I tools/mkcas.py $(BUILD)/im2a.cas binary IM2OK 9000 9000 $(BUILD)/im2ok.bin
	python3 -I tools/mkcas.py $(BUILD)/im2b.cas binary IM2DAT 0 0 $(BUILD)/im2data.bin
	cat $(BUILD)/im2a.cas $(BUILD)/im2b.cas > $@

$(BUILD)/STUB.CAS: tools/mkcas.py $(BUILD)/stubok.bin
	python3 -I -c "import sys; open(sys.argv[1], 'wb').write(bytes((n + n // 256) % 256 for n in range(16384)))" $(BUILD)/stubdata.bin
	python3 -I tools/mkcas.py $(BUILD)/stuba.cas binary STUBOK 9000 9000 $(BUILD)/stubok.bin
	python3 -I tools/mkcas.py $(BUILD)/stubb.cas binary STUBDT 0 0 $(BUILD)/stubdata.bin
	cat $(BUILD)/stuba.cas $(BUILD)/stubb.cas > $@

$(BUILD)/STUBHL.CAS: tools/mkcas.py $(BUILD)/stubhlok.bin
	python3 -I -c "import sys; open(sys.argv[1], 'wb').write(bytes((n + n // 256) % 256 for n in range(16384)))" $(BUILD)/stubdata.bin
	python3 -I tools/mkcas.py $(BUILD)/stubhla.cas binary STUBHL 9000 9000 $(BUILD)/stubhlok.bin
	python3 -I tools/mkcas.py $(BUILD)/stubhlb.cas binary STUBDT 0 0 $(BUILD)/stubdata.bin
	cat $(BUILD)/stubhla.cas $(BUILD)/stubhlb.cas > $@

$(BUILD)/NEXT.CAS: tools/mkcas.py $(BUILD)/nextok.bin $(BUILD)/nextb.bin
	python3 -I -c "import sys; open(sys.argv[1], 'wb').write(bytes(range(256)))" $(BUILD)/nextdata.bin
	python3 -I tools/mkcas.py $(BUILD)/nexta.cas binary NEXTOK 9000 9000 $(BUILD)/nextok.bin
	python3 -I tools/mkcas.py $(BUILD)/nextb.cas raw $(BUILD)/nextb.bin
	python3 -I tools/mkcas.py $(BUILD)/nextc.cas raw $(BUILD)/nextdata.bin
	cat $(BUILD)/nexta.cas $(BUILD)/nextb.cas $(BUILD)/nextc.cas > $@

$(BUILD)/PARD.CAS: tools/mkcas.py test/pardok.bas $(BUILD)/rom0.bin $(BUILD)/binok.bin
	python3 -I tools/mkcas.py $(BUILD)/parda.cas ascii PARDOK test/pardok.bas
	python3 -I tools/mkcas.py $(BUILD)/pardb.cas binary ROM0 9000 9000 $(BUILD)/rom0.bin
	python3 -I tools/mkcas.py $(BUILD)/pardc.cas binary BINOK 9000 9000 $(BUILD)/binok.bin
	cat $(BUILD)/parda.cas $(BUILD)/pardb.cas $(BUILD)/pardc.cas > $@

$(BUILD)/HOOK.CAS: tools/mkcas.py test/hookok.bas $(BUILD)/hooks.bin $(BUILD)/binok.bin
	python3 -I tools/mkcas.py $(BUILD)/hooka.cas ascii HOOKOK test/hookok.bas
	python3 -I tools/mkcas.py $(BUILD)/hookb.cas binary HOOKS 9000 9000 $(BUILD)/hooks.bin
	python3 -I tools/mkcas.py $(BUILD)/hookc.cas binary BINOK 9000 9000 $(BUILD)/binok.bin
	cat $(BUILD)/hooka.cas $(BUILD)/hookb.cas $(BUILD)/hookc.cas > $@

$(BUILD)/SLOTS.CAS: tools/mkcas.py test/slotsok.bas $(BUILD)/slotsok.bin $(BUILD)/binok.bin
	python3 -I tools/mkcas.py $(BUILD)/slotsa.cas ascii SLOTOK test/slotsok.bas
	python3 -I tools/mkcas.py $(BUILD)/slotsb.cas binary SLOTS 9000 9000 $(BUILD)/slotsok.bin
	python3 -I tools/mkcas.py $(BUILD)/slotsc.cas binary BINOK 9000 9000 $(BUILD)/binok.bin
	cat $(BUILD)/slotsa.cas $(BUILD)/slotsb.cas $(BUILD)/slotsc.cas > $@

$(BUILD)/NAMCO.CAS: tools/mkcas.py $(BUILD)/namcook.bin
	python3 -I -c "import sys; open(sys.argv[1], 'wb').write(bytes(range(256)))" $(BUILD)/namcodata.bin
	python3 -I tools/mkcas.py $(BUILD)/namcoa.cas binary NAMCOK 9000 9000 $(BUILD)/namcook.bin
	python3 -I tools/mkcas.py $(BUILD)/namcob.cas raw $(BUILD)/namcodata.bin
	cat $(BUILD)/namcoa.cas $(BUILD)/namcob.cas > $@

$(BUILD)/CB.CAS: tools/mkcas.py test/cbok.bas $(BUILD)/rom0.bin $(BUILD)/NEXT.CAS
	python3 -I tools/mkcas.py $(BUILD)/cba.cas ascii CBOK test/cbok.bas
	python3 -I tools/mkcas.py $(BUILD)/cbb.cas binary ROM0 9000 9000 $(BUILD)/rom0.bin
	cat $(BUILD)/cba.cas $(BUILD)/cbb.cas $(BUILD)/NEXT.CAS > $@

$(BUILD)/DROP.CAS: tools/mkcas.py test/dropok.bas $(BUILD)/binok.bin
	python3 -I -c "import sys; open(sys.argv[1], 'wb').write(bytes([255]) * 0x4800)" $(BUILD)/dropff.bin
	python3 -I tools/mkcas.py $(BUILD)/dropa.cas ascii DROPOK test/dropok.bas
	python3 -I tools/mkcas.py $(BUILD)/dropb.cas binary DROPFF 0000 0000 $(BUILD)/dropff.bin
	python3 -I tools/mkcas.py $(BUILD)/dropc.cas binary BINOK 9000 9000 $(BUILD)/binok.bin
	cat $(BUILD)/dropa.cas $(BUILD)/dropb.cas $(BUILD)/dropc.cas > $@

$(BUILD)/TAPD.CAS: tools/mkcas.py $(BUILD)/tapdok.bin
	python3 -I -c "import sys; open(sys.argv[1], 'wb').write(bytes(range(256)))" $(BUILD)/tapddata.bin
	python3 -I tools/mkcas.py $(BUILD)/tapda.cas binary TAPDOK 9000 9000 $(BUILD)/tapdok.bin
	python3 -I tools/mkcas.py $(BUILD)/tapdb.cas raw $(BUILD)/tapddata.bin
	cat $(BUILD)/tapda.cas $(BUILD)/tapdb.cas > $@

$(BUILD)/ASCOK.CAS: tools/mkcas.py test/ascok.bas
	@mkdir -p $(BUILD)
	python3 -I tools/mkcas.py $@ ascii ASCOK test/ascok.bas

# fetch,URL,SHA256: download $@ and keep it only if its checksum matches.
define fetch
	@mkdir -p $(DL)
	curl -sfL -o $@.part $(1)
	echo "$(2)  $@.part" | shasum -a 256 -c - >/dev/null || \
	  { echo "error: $@: checksum mismatch"; rm -f $@.part; exit 1; }
	mv $@.part $@
endef

$(DL)/sjasmplus-$(SJASMPLUS_VERSION)-src.tar.xz:
	$(call fetch,https://github.com/z00m128/sjasmplus/releases/download/v$(SJASMPLUS_VERSION)/sjasmplus-$(SJASMPLUS_VERSION)-src.tar.xz,0b5013f07e8d8505f9e296529655668b6fdf0268625c19e883b0fff484e209f1)

$(DL)/$(NEXTOR_ROM):
	$(call fetch,https://github.com/Konamiman/Nextor/releases/download/v2.1.4/$(NEXTOR_ROM),4eafcd3a4918da7da98559b2b598d430521d35857f1bf0d2ba6619f8e71c05b2)

$(DL)/$(NEXTOR_MFRSD_ROM):
	$(call fetch,https://github.com/Konamiman/Nextor/releases/download/v2.1.4/$(NEXTOR_MFRSD_ROM),5e1ab82af74b84e46636a14c592ac9d97a1515feb1104fb38d46152b16e57cb1)

# Nextor 2.1.4 shipped only kernel ROMs; 2.1.3 is the latest NEXTOR.SYS.
$(DL)/NEXTOR.SYS:
	$(call fetch,https://github.com/Konamiman/Nextor/releases/download/v2.1.3/NEXTOR.SYS,3db8c8094bd5d3df4197b2f6606d4e28fb5a2462086f72ce8b6664d12a94bde7)

$(DL)/COMMAND2.COM:
	$(call fetch,https://raw.githubusercontent.com/Konamiman/Nextor/v2.1.4/source/command/command/command2.com,21f2e90251fdd8f0f726d67fc302d2aa57a1f157ceb31334a056530458845b85)

# MSX-DOS 2's files, from your zip, checked against the version tested.
$(DL)/MSXDOS2.zip:
	@echo "error: $@ is missing: put your MSX-DOS 2 zip there (see the top of this Makefile)"; exit 1

$(DL)/msxdos2/MSXDOS2.SYS $(DL)/msxdos2/COMMAND2.COM &: $(DL)/MSXDOS2.zip
	unzip -q -o -j $< MSXDOS2.SYS COMMAND2.COM -d $(DL)/msxdos2
	echo "6fef57af945184a3c57e5c00f9cb8eb2b04e4a60898b686b64b50480a0974171  $(DL)/msxdos2/MSXDOS2.SYS" | shasum -a 256 -c - >/dev/null
	echo "420eed1d995c9bc48f436baba4db2c15a310fa496f24ea87ef8efd967817cf2d  $(DL)/msxdos2/COMMAND2.COM" | shasum -a 256 -c - >/dev/null
	touch $(DL)/msxdos2/MSXDOS2.SYS $(DL)/msxdos2/COMMAND2.COM

$(SJASMPLUS): $(DL)/sjasmplus-$(SJASMPLUS_VERSION)-src.tar.xz
	rm -rf $(TOOLS)/src
	mkdir -p $(TOOLS)/src
	tar -xJf $< -C $(TOOLS)/src
	$(MAKE) -C $(TOOLS)/src/sjasmplus-$(SJASMPLUS_VERSION)
	cp $(TOOLS)/src/sjasmplus-$(SJASMPLUS_VERSION)/sjasmplus $@

# ---- Tests ----

# openMSX reads extensions only from its home directory, so the test gets its
# own home in build/, holding the IDE extension and a link to SYSTEMROMS.
EMU_HOME := $(BUILD)/openmsx-home
EMU_EXT  := $(EMU_HOME)/share/extensions/casgo_ide
EMU_MFRSD := $(EMU_HOME)/share/extensions/casgo_mfrsd

# The emulators run silent: SDL's dummy audio driver keeps openMSX off the
# computer's sound device, and each run also sets openMSX's own driver to null.
export SDL_AUDIODRIVER := dummy

# The test machines: an MSX1 that gets its mapper from a cartridge, and an MSX2
# whose own 128 KB mapper is CASGO's minimum, both under Nextor from the IDE,
# and the MSX2 also under MSX-DOS 2 from a floppy. MSX-DOS 2 does not run on an
# MSX1.
TEST_MACHINES := vg8020 nms8250 nms8250-dos2

# IRAM_ is 1 for a machine with internal RAM in a slot of its own, where the R
# and I variants load, and 0 where they stop with an error.
IRAM_vg8020            := 1
IRAM_nms8250           := 0
IRAM_nms8250-dos2      := 0

MACHINE_vg8020         := Philips_VG_8020
EXTENSIONS_vg8020      := -ext ram512k -ext casgo_ide
DRIVE_vg8020           := hda
DISK_vg8020            := $(BUILD)/test.dsk
DISKDEP_vg8020         := $(BUILD)/test.dsk

MACHINE_nms8250        := Philips_NMS_8250
EXTENSIONS_nms8250     := -ext casgo_ide
DRIVE_nms8250          := hda
DISK_nms8250           := $(BUILD)/test.dsk
DISKDEP_nms8250        := $(BUILD)/test.dsk

MACHINE_nms8250-dos2   := Philips_NMS_8250
EXTENSIONS_nms8250-dos2 := -ext msxdos2
DRIVE_nms8250-dos2     := diska
DISK_nms8250-dos2      := $(BUILD)/dos2disk
DISKDEP_nms8250-dos2   := $(BUILD)/dos2disk.stamp


# Two disks with the same tests: an image that boots Nextor from the IDE, and a
# folder that openMSX shows as a floppy and that boots MSX-DOS 2. MSX-DOS 2 loads
# MSXDOS2.SYS through the boot sector's code, which tools/mkdisk.py does not
# write; openMSX gives a folder a boot sector with that code.
TEST_FILES := $(BUILD)/CASGO.COM $(VARIANT_COMS) \
              $(addprefix $(BUILD)/,TEST.CAS SKEWED.CAS BADTYPE.CAS NOHDR.CAS BIG.CAS BASOK.CAS ASCOK.CAS IM2.CAS STUB.CAS NEXT.CAS PARD.CAS NAMCO.CAS CB.CAS DROP.CAS STUBHL.CAS TAPD.CAS HOOK.CAS SHIFT.CAS SLOTS.CAS MODULE.CAS SYDNEY.CAS LEVEL9.CAS PAGE21.CAS PAGE1.CAS KNOWN.CAS KNOWNB.CAS PATCH.CAS CASLINK.CAS EXPTBL.CAS SLOT3.CAS SHORT.CAS)
NEXTOR_FILES := $(DL)/NEXTOR.SYS $(DL)/COMMAND2.COM $(TEST_FILES)
DOS2_FILES   := $(DL)/msxdos2/MSXDOS2.SYS $(DL)/msxdos2/COMMAND2.COM $(TEST_FILES)

$(BUILD)/test.dsk: tools/mkdisk.py $(NEXTOR_FILES)
	python3 -I tools/mkdisk.py $@ $(NEXTOR_FILES)

$(BUILD)/dos2disk.stamp: $(DOS2_FILES)
	rm -rf $(BUILD)/dos2disk
	mkdir -p $(BUILD)/dos2disk
	cp $(DOS2_FILES) $(BUILD)/dos2disk/
	touch $@

$(EMU_EXT)/hardwareconfig.xml: emu/casgo_ide.xml $(DL)/$(NEXTOR_ROM)
	@mkdir -p $(EMU_EXT)
	cp $(DL)/$(NEXTOR_ROM) $(EMU_EXT)/
	cp $< $@
	ln -sfn $(SYSTEMROMS) $(EMU_HOME)/share/systemroms

$(EMU_MFRSD)/hardwareconfig.xml: emu/casgo_mfrsd.xml $(DL)/$(NEXTOR_MFRSD_ROM)
	@mkdir -p $(EMU_MFRSD)
	python3 -I -c "import sys; d=open(sys.argv[1],'rb').read(); open(sys.argv[2],'wb').write(b'\\xff'*0x700000+d)" $(DL)/$(NEXTOR_MFRSD_ROM) $(EMU_MFRSD)/flash.rom
	cp $< $@
	ln -sfn $(SYSTEMROMS) $(EMU_HOME)/share/systemroms

# Each case boots a machine once and runs one variant (test/boot.tcl). With the
# plain loader case: bin runs the error cases and loads a binary with the mapper,
# binr and bini the binary with the internal RAM and with T0 there, bint with T0
# in the internal RAM and pages 2 and 3 in the mapper, bas a tokenized BASIC
# program, asc an ASCII one, im2 a binary that reads its data in interrupt mode 2,
# and tapd one that checks that TAPIN leaves the byte in D. stub, stubr and stubt
# load a binary that reads its data through a stub loader's stub, stubhl one
# through a stub built with LD HL, next, nextr, nexti and nextt one whose tape
# calls the calls case rewrites, namco one whose tape calls are built at run time,
# pard and pardt a BASIC load after a binary put the ROM in page 0, cs the stub
# binary with the calls and stub case, cb a BASIC load of the calls binary after a
# binary put the ROM in page 0, with the calls and BASIC case, drop a BASIC load
# from 0000h whose page 0 bytes the BASIC variant drops, hook a BASIC load after a
# binary cleared the hooks and put the ROM in pages 0 and 1, slots one after a
# binary restored pages 0 and 1 with the A that its first slot call left, exptbl
# the change of a restore that reads EXPTBL's byte for slot 1, and short a BASIC
# load after a binary whose block is one byte short. On a machine without
# internal RAM, the R, I and T variants stop with their error. The d cases run the
# detector, CASGO.COM: detect its errors and the plain binary, dnext, dnamco, dstub
# and dstubhl the binaries of the loader cases, dpard, dcb, ddrop, dhook, dslots
# and dexptbl the BASIC loads, dshift, dmodule, dsydney, dlevel9, dpage21, dpage1
# and dslot3 the memory rules for the slot shift, the slot module, the Sydney
# engine, Level 9's search for RAM, page 2's slot put in page 1, the search for
# RAM for page 1 alone and the copy into page 0 of slot 3, dforce cases forced by
# the option, dknown and dknownb a known tape by block lengths and by first
# bytes, dpatch a known tape's patch, and dcaslink the change of CasLink3's
# reset; each checks the variant and option that the detector prints, then the
# load.
TEST_CASES := bin binr bini bint bas asc im2 tapd stub stubr stubt stubhl next nextr nexti nextt \
              namco pard pardt cs \
              cb drop hook slots exptbl short detect dnext dnamco dstub dstubhl dpard dcb ddrop dhook dslots dexptbl dshift dmodule dsydney dlevel9 dpage21 dpage1 dslot3 dforce dknown dknownb dpatch dcaslink

test: $(addprefix test-,$(TEST_MACHINES))

# test-MACHINE runs every case on that machine; test-MACHINE-CASE runs one.
# macOS has no timeout command, so perl's alarm stops a hung openMSX.
define test_case
test-$(1): test-$(1)-$(2)
test-$(1)-$(2): $(DISKDEP_$(1)) $(EMU_EXT)/hardwareconfig.xml
	rm -f $(BUILD)/test-$(1)-$(2).result
	OPENMSX_HOME=$(abspath $(EMU_HOME)) \
	CASGO_DRIVE=$(DRIVE_$(1)) \
	CASGO_IRAM=$(IRAM_$(1)) \
	CASGO_DISK=$(abspath $(DISK_$(1))) \
	CASGO_CASE=$(2) \
	CASGO_RESULT=$(abspath $(BUILD)/test-$(1)-$(2).result) \
	  perl -e 'alarm 120; exec @ARGV' \
	  openmsx -command "set sound_driver null" -machine $(MACHINE_$(1)) $(EXTENSIONS_$(1)) -script test/boot.tcl \
	  >$(BUILD)/openmsx-$(1)-$(2).log 2>&1 || true
	@echo "== $(1) $(2)"
	@grep -v '^ *$$$$' $(BUILD)/test-$(1)-$(2).result 2>/dev/null || { echo "FAIL: openMSX wrote no result, see $(BUILD)/openmsx-$(1)-$(2).log"; exit 1; }
	@head -1 $(BUILD)/test-$(1)-$(2).result | grep -q '^PASS'
endef
$(foreach m,$(TEST_MACHINES),$(foreach c,$(TEST_CASES),$(eval $(call test_case,$(m),$(c)))))

# make games: runs CASGO on every CAS file in games/ on the Nextor test
# machines and writes a verdict per game and machine to build/games.tsv
# (test/game.tcl). games/ is not in the repository: put your own CAS files
# there, with 8.3 names.
GAMES := $(sort $(notdir $(wildcard games/*.CAS)))

$(BUILD)/games.dsk: tools/mkdisk.py $(DL)/NEXTOR.SYS $(DL)/COMMAND2.COM $(BUILD)/CASGO.COM $(VARIANT_COMS) $(addprefix games/,$(GAMES))
	python3 -I tools/mkdisk.py $@ $(filter-out tools/mkdisk.py,$^)

.PHONY: games
games: $(BUILD)/games.dsk $(EMU_EXT)/hardwareconfig.xml
	@rm -f $(BUILD)/games.tsv
	@for m in vg8020 nms8250; do \
	  for g in $(GAMES); do \
	    rm -f $(BUILD)/game.result; \
	    if [ $$m = vg8020 ]; then machine="$(MACHINE_vg8020)"; ext="$(EXTENSIONS_vg8020)"; \
	    else machine="$(MACHINE_nms8250)"; ext="$(EXTENSIONS_nms8250)"; fi; \
	    OPENMSX_HOME=$(abspath $(EMU_HOME)) CASGO_DISK=$(abspath $(BUILD)/games.dsk) \
	    CASGO_GAME=$$g CASGO_RESULT=$(abspath $(BUILD)/game.result) \
	      perl -e 'alarm 120; exec @ARGV' openmsx -command "set sound_driver null" -machine $$machine $$ext -script test/game.tcl \
	      >$(BUILD)/openmsx-game.log 2>&1; \
	    printf '%s\t%s\t%s\n' $$m $$g "$$(cat $(BUILD)/game.result 2>/dev/null || echo 'ERROR no result')" \
	      | tee -a $(BUILD)/games.tsv; \
	  done; \
	done

# make corpus CORPUS=folder: runs CASGO on every .cas file in the folder on the
# Nextor test machines, each game on its own disk, and writes a verdict per game
# and machine to build/corpus.tsv (test/corpus.sh, test/game.tcl).
# CORPUS_MACHINES names the machines to run: vg8020 and nms8250 by default, both
# with the Sunrise IDE. The machines vg8020-mfrsd and nms8250-mfrsd have a
# MegaFlashROM SCC+ SD in place of the Sunrise IDE. The cartridge brings its own
# mapper, so vg8020-mfrsd runs without the memory cartridge. For example:
#   make corpus CORPUS=tapes CORPUS_MACHINES=vg8020-mfrsd
CORPUS_vg8020        := vg8020:$(MACHINE_vg8020):ram512k,casgo_ide
CORPUS_nms8250       := nms8250:$(MACHINE_nms8250):casgo_ide
CORPUS_vg8020-mfrsd  := vg8020-mfrsd:$(MACHINE_vg8020):casgo_mfrsd
CORPUS_nms8250-mfrsd := nms8250-mfrsd:$(MACHINE_nms8250):casgo_mfrsd
CORPUS_MACHINES ?= vg8020 nms8250
.PHONY: corpus
corpus: $(BUILD)/CASGO.COM $(VARIANT_COMS) $(DL)/NEXTOR.SYS $(DL)/COMMAND2.COM $(EMU_EXT)/hardwareconfig.xml \
        $(if $(filter %-mfrsd,$(CORPUS_MACHINES)),$(EMU_MFRSD)/hardwareconfig.xml)
	@test -n "$(CORPUS)" || { echo "usage: make corpus CORPUS=folder"; exit 1; }
	OPENMSX_HOME=$(abspath $(EMU_HOME)) CASGO_COMS="$(BUILD)/CASGO.COM $(VARIANT_COMS)" \
	NEXTOR_SYS=$(DL)/NEXTOR.SYS COMMAND2=$(DL)/COMMAND2.COM \
	MACHINES="$(foreach m,$(CORPUS_MACHINES),$(CORPUS_$(m)))" \
	  test/corpus.sh "$(CORPUS)" $(BUILD)/corpus.tsv


clean:
	rm -rf $(BUILD)
