TOP = ..
OUTDIR= .
INDIR= .
CC = $cc
CFLAGS = -I$(TOP)\run-time -I$(TOP) -I$(TOP)\ipc\shared
DPFLAGS = -I$(TOP)
JCFLAGS = $(CFLAGS) $ccflags $optimize
LN = copy
MV = \bin\mv
RM = del
OBJECTS = argcargv.$obj econsole.$obj

.c.$obj:
	$(CC) -c $(JCFLAGS) $<

all:: winconsole.$lib

winconsole.$lib: $(OBJECTS)
	$link_line
