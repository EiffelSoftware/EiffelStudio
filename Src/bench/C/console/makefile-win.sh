TOP = ..
OUTDIR= .
INDIR= .
CC = $cc
OUTPUT_CMD = $output_cmd
CFLAGS = -I$(TOP)\run-time -I$(TOP) -I$(TOP)\ipc\app
DPFLAGS = -I$(TOP)
JCFLAGS = $(CFLAGS) $ccflags $optimize
JMTCFLAGS = $(CFLAGS) $mtccflags $optimize
LN = copy
MV = \bin\mv
RM = del
OBJECTS = argcargv.$obj econsole.$obj
MT_OBJECTS = MTargcargv.$obj MTeconsole.$obj

.c.$obj:
	$(CC) -c $(JCFLAGS) $<

all:: winconsole.$lib mtwinconsole.$lib

winconsole.$lib: $(OBJECTS)
	$link_line

mtwinconsole.$lib: $(MT_OBJECTS)
	$link_mtline

MTargcargv.$obj: argcargv.c
	$(CC) -c $(JMTCFLAGS)  	$? $(OUTPUT_CMD)$@

MTeconsole.$obj: econsole.c
	$(CC) -c $(JMTCFLAGS)  	$? $(OUTPUT_CMD)$@
