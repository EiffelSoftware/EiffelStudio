TOP = ..
CC = $cc
JCFLAGS = $(CFLAGS) $ccflags $optimize
MAKE = $make
MV = ren
RM = del

.c.obj:
	$(RM) $@
	$(CC) -c $(JCFLAGS) $<

CFLAGS = -I$(TOP) -I..\run-time

OBJECTS = \
	names.obj \
	sizes.obj \
	commands.obj

all:: platform.lib

platform.lib: $(OBJECTS)
	$(RM) $@
	$link_line
