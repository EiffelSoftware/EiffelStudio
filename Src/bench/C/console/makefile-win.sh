TOP = ..
OUTDIR= .
INDIR= .
CC = $cc
OUTPUT_CMD = $output_cmd
CFLAGS = -I$(TOP)\run-time -I$(TOP)\run-time\include -I$(TOP) -I$(TOP)\ipc\app
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

all:: $output_libraries

dll: standard
mtdll: mtstandard
standard:: winconsole.$lib wwinconsole.$lib
mtstandard:: mtwinconsole.$lib mtwwinconsole.$lib

winconsole.$lib: $(OBJECTS)
	$link_line

mtwinconsole.$lib: $(MT_OBJECTS)
	$link_mtline

wwinconsole.$lib: $(WOBJECTS)
	$link_wline

mtwwinconsole.$lib: $(MT_WOBJECTS)
	$link_mtwline

weconsole.$obj: econsole.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(OUTPUT_CMD)$@ -c $?

MTargcargv.$obj: argcargv.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?

MTeconsole.$obj: econsole.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?

MTweconsole.$obj: econsole.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(OUTPUT_CMD)$@ -c $?
