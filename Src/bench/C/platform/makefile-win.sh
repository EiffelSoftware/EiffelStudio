TOP = ..
OUTDIR = .
INDIR = .
CC = $cc
OUTPUT_CMD = $output_cmd
JCFLAGS = $(CFLAGS) $ccflags $optimize
JMTCFLAGS = $(CFLAGS) $mtccflags $optimize
CFLAGS = -I$(TOP) -I$(TOP)\run-time -I$(TOP)\ipc\shared
MAKE = $make
MV = ren
RM = del

OBJECTS = names.$obj sizes.$obj commands.$obj

MT_OBJECTS = MTnames.$obj MTsizes.$obj MTcommands.$obj

.c.$obj:
	$(CC) -c $(JCFLAGS) $<

all:: $output_libraries

dll: standard
mtdll: mtstandard
standard: platform.$lib
mtstandard: mtplatform.$lib

platform.$lib: $(OBJECTS)
	$link_line

mtplatform.$lib: $(MT_OBJECTS)
	$link_mtline

MTnames.$obj: names.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $? 

MTcommands.$obj: commands.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $? 

MTsizes.$obj: sizes.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $? 
