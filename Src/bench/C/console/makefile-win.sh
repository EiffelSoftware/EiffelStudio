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
WOBJECTS = argcargv.$obj weconsole.$obj
MT_WOBJECTS = MTargcargv.$obj MTweconsole.$obj

.c.$obj:
	$(CC) -c $(JCFLAGS) $<

all:: winconsole.$lib mtwinconsole.$lib
all:: wwinconsole.$lib mtwwinconsole.$lib

winconsole.$lib: $(OBJECTS)
	$link_line

mtwinconsole.$lib: $(MT_OBJECTS)
	$link_mtline

wwinconsole.$lib: $(WOBJECTS)
	$link_wline

mtwwinconsole.$lib: $(MT_WOBJECTS)
	$link_mtwline

MTargcargv.$obj: argcargv.c
	$(CC) -c $(JMTCFLAGS)  	$? $(OUTPUT_CMD)$@

MTeconsole.$obj: econsole.c
	$(CC) -c $(JMTCFLAGS)  	$? $(OUTPUT_CMD)$@

weconsole.$obj: econsole.c
	$(CC) -c $(JCFLAGS) -DWORKBENCH $? $(OUTPUT_CMD)$@

MTweconsole.$obj: econsole.c
	$(CC) -c $(JMTCFLAGS) -DWORKBENCH $? $(OUTPUT_CMD)$@
