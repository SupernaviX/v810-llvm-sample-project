# Set the project name here
NAME = Sample

OUTPUTDIR = output
TOOLCHAIN_ARCH := v810
TOOLCHAIN_DIR := C:/llvm-v810

# The rest of the Makefile should not need changing ...
BINDIR = $(TOOLCHAIN_DIR)/bin
INCDIR = $(TOOLCHAIN_DIR)/include
LIBDIR = $(TOOLCHAIN_DIR)/lib

AS = $(BINDIR)/llvm-mc
CC = $(BINDIR)/clang
LD = $(BINDIR)/ld.lld
OBJCOPY = $(BINDIR)/llvm-objcopy

ASFLAGS += --triple v810-unknown-vb --filetype=obj
CFLAGS += -I$(INCDIR) -xc -target v810-unknown-vb -mgprel -c -O1 -ffunction-sections -fdata-sections -fomit-frame-pointer -flto
LDFLAGS += -target v810-unknown-vb -mcpu=vb --ld-path=$(LD) -L$(LIBDIR) -Tvb.ld -nolibc -flto

SFILES := $(foreach dir,./,$(notdir $(wildcard $(dir)/*.s)))
CFILES := $(foreach dir,./,$(notdir $(wildcard $(dir)/*.c)))
BINFILES := $(foreach dir,./,$(notdir $(wildcard $(dir)/*.bin)))

SOBJS := $(OUTPUTDIR)/$(SFILES:.s=.o)
COBJS := $(OUTPUTDIR)/$(CFILES:.c=.o)
BINOBJS := $(OUTPUTDIR)/$(BINFILES:.bin=.o)

OFILES := $(SOBJS) $(COBJS) $(BINOBJS)
ELFFILES := $(OUTPUTDIR)/$(NAME).elf
VBFILES := $(OUTPUTDIR)/$(NAME).vb

.PHONY: all clean distclean

all: $(VBFILES)

$(VBFILES): $(ELFFILES)
	$(OBJCOPY) -S -O binary $< $@

$(ELFFILES): $(OFILES)
	$(CC) $(OFILES) $(LDFLAGS) -o $@

$(SOBJS): $(SFILES)
	$(AS) $(ASFLAGS) -o $@ $<

$(COBJS): $(CFILES)
	$(CC) $(CFLAGS) -o $@ $<

$(BINOBJS): $(BINFILES)
	$(LD) -m elf32_v810 --format binary --relocatable -Tvb_rodata.ld -o $@ $<

clean: 
ifeq ($(OS),Windows_NT)
	del /q "$(OUTPUTDIR)\\*"
else
	rm -f $(OUTPUTDIR)/*
endif

distclean: clean
