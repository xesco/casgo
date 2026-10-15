# CASGO: build CASGO.COM, the detector with the four variants after it.
#
#   make         build build/CASGO.COM
#   make clean   remove build/ (keeps the downloads and the assembler)
#
# The build needs make, curl, a C++ compiler and Python 3. It downloads the
# sjasmplus assembler's source, pinned by version and SHA-256, into dl/, and
# builds the assembler into .tools/.

SJASMPLUS_VERSION := 1.24.0

DL        := dl
TOOLS     := .tools
BUILD     := build
SJASMPLUS := $(TOOLS)/sjasmplus

# A variant is CASGO with one memory case: M (the mapper), R (an MSX1's own RAM),
# I (T0 in that RAM too) or T (only T0 in that RAM, or in a second RAM on an MSX2).
# Each holds the code of every loader case.
MEMORY_CASES := M R I T
VARIANT_COMS := $(foreach m,$(MEMORY_CASES),$(BUILD)/CASGO$(m).COM)

.PHONY: all clean
all: $(BUILD)/CASGO.COM

# The known tapes: the detector's table and the variants' patches, in one run.
$(BUILD)/known.asm: tools/known.py tools/known.tsv
	@mkdir -p $(BUILD)
	python3 -I tools/known.py tools/known.tsv $@ $(BUILD)/patches.asm

$(BUILD)/patches.asm: $(BUILD)/known.asm

$(BUILD)/CASGO.COM: src/detect.asm src/patterns.asm $(BUILD)/known.asm $(VARIANT_COMS) $(SJASMPLUS)
	$(SJASMPLUS) --nologo --msg=war -I$(BUILD) --raw=$@ --lst=$(BUILD)/detect.lst $<

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

$(SJASMPLUS): $(DL)/sjasmplus-$(SJASMPLUS_VERSION)-src.tar.xz
	rm -rf $(TOOLS)/src
	mkdir -p $(TOOLS)/src
	tar -xJf $< -C $(TOOLS)/src
	$(MAKE) -C $(TOOLS)/src/sjasmplus-$(SJASMPLUS_VERSION)
	cp $(TOOLS)/src/sjasmplus-$(SJASMPLUS_VERSION)/sjasmplus $@

clean:
	rm -rf $(BUILD)
