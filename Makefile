# CASGO: build CASGO.COM, the detector with the four variants after it.
#
#   make           build build/CASGO.COM
#   make release   also build build/casgo.dsk, a disk image with Nextor and
#                  CASGO.COM for the openMSX setup in openmsx/
#   make clean     remove build/ (keeps the downloads and the assembler)
#
# The build needs make, curl, a C++ compiler and Python 3. It downloads the
# sjasmplus assembler's source, and for the disk image Nextor's NEXTOR.SYS and
# COMMAND2.COM, each pinned by version and SHA-256, into dl/, and builds the
# assembler into .tools/.

SJASMPLUS_VERSION := 1.24.0

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

.PHONY: all release clean FORCE
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

# Nextor 2.1.4 shipped only kernel ROMs; 2.1.3 is the latest NEXTOR.SYS.
$(DL)/NEXTOR.SYS:
	$(call fetch,https://github.com/Konamiman/Nextor/releases/download/v2.1.3/NEXTOR.SYS,3db8c8094bd5d3df4197b2f6606d4e28fb5a2462086f72ce8b6664d12a94bde7)

$(DL)/COMMAND2.COM:
	$(call fetch,https://raw.githubusercontent.com/Konamiman/Nextor/v2.1.4/source/command/command/command2.com,21f2e90251fdd8f0f726d67fc302d2aa57a1f157ceb31334a056530458845b85)

$(SJASMPLUS): $(DL)/sjasmplus-$(SJASMPLUS_VERSION)-src.tar.xz
	rm -rf $(TOOLS)/src
	mkdir -p $(TOOLS)/src
	tar -xJf $< -C $(TOOLS)/src
	$(MAKE) -C $(TOOLS)/src/sjasmplus-$(SJASMPLUS_VERSION)
	cp $(TOOLS)/src/sjasmplus-$(SJASMPLUS_VERSION)/sjasmplus $@

clean:
	rm -rf $(BUILD)
