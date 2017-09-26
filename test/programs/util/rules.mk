AS := mipsel-linux-as
OBJCOPY := mipsel-linux-objcopy
CC := mipsel-linux-gcc
LD := mipsel-linux-ld
AR := mipsel-linux-ar

ASFLAGS=-EB -mabi=eabi -march=r2000
CFLAGS=-EB -mno-abicalls -mabi=eabi -march=r2000 -nostdlib -static -G0 -std=c99
LDFLAGS=-EB
ARFLAGS=-cvq

# assembles the program into out files
%.o: %.s
	$(AS) $(ASFLAGS) $< -o $@

# compiles programs into out files
%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

# converts to verilog and performs endian swapping
%.vhex: %.bin
	$(OBJCOPY) -j .text -O verilog $< $@.text
	$(OBJCOPY) -j .data -O verilog $< $@.data
