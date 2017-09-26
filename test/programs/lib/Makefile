include ../util/rules.mk

S_SOURCES := $(wildcard *.s)
C_SOURCES := $(wildcard *.c)
OBJS = $(patsubst %.s, %.o, $(S_SOURCES)) $(patsubst %.c, %.o, $(C_SOURCES))

libmips.a: $(OBJS)
	$(AR) $(ARFLAGS) libmips.a $(OBJS)
