include util/rules.mk

S_SOURCES := $(wildcard *.s)
C_SOURCES := $(wildcard *.c)
OBJS = $(patsubst %.s, %.o, $(S_SOURCES)) $(patsubst %.c, %.o, $(C_SOURCES))
BINS = $(patsubst %.o, %.bin, $(OBJS))
VHEX = $(patsubst %.bin, %.vhex, $(BINS))

all: $(VHEX)
bins: $(BINS)

lib/libmips.a:
	cd lib && make

# links the assembly into the proper format for programming
%.bin: %.o lib/libmips.a
	$(LD) $(LDFLAGS) -Llib/ -static -lmips -o $@ -T util/baremetal-mips.ld $< -lmips

# converts to verilog and performs endian swapping
%.vhex: %.bin
	$(OBJCOPY) -j .text -O verilog $< $@.text
	$(OBJCOPY) -j .data -O verilog $< $@.data

debug:
	@echo "Sources: $(S_SOURCES) $(C_SOURCES)"
	@echo "Objs: $(OBJS)"
	@echo "Bins: $(BINS)"
	@echo "Vhex: $(VHEX)"

clean:
	rm -rf *.o *.out *.vhex.* *.tmp *.bin lib/*.o lib/*.a
