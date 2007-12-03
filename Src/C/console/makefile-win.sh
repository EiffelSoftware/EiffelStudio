TOP = ..
DIR = $dir_sep
OUTDIR= .
INDIR= .
CC = $cc
OUTPUT_CMD = $output_cmd
CFLAGS = -I$(TOP)$(DIR)run-time -I$(TOP)$(DIR)run-time$(DIR)include -I$(TOP) -I$(TOP)$(DIR)ipc$(DIR)app -I$(TOP)$(DIR)idrs
DPFLAGS = -I$(TOP)
JCFLAGS = $(CFLAGS) $ccflags $optimize
JMTCFLAGS = $(CFLAGS) $mtccflags $optimize
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
	$link_line

wwinconsole.$lib: $(WOBJECTS)
	$link_line

mtwwinconsole.$lib: $(MT_WOBJECTS)
	$link_line

weconsole.$obj: econsole.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(OUTPUT_CMD)$@ -c $?

MTargcargv.$obj: argcargv.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?

MTeconsole.$obj: econsole.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?

MTweconsole.$obj: econsole.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(OUTPUT_CMD)$@ -c $?
