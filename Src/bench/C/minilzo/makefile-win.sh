TOP = ..
OUTDIR = .\LIB
INDIR = .\OBJDIR
RTSRC = .
CC = $cc
CTAGS = ctags
LIB_EXE = $lib_exe
LN = copy
MAKE = $make
MV = move
RM = del
LINK32 = $link32
DLLFLAGS = $dllflags
OUTPUT_CMD = $output_cmd
CFLAGS = -I. -I$(TOP) -I$(TOP)\run-time -I$(TOP)\run-time\include
JCFLAGS = $(CFLAGS) $ccflags $optimize
JMTCFLAGS = $(CFLAGS) $mtccflags $optimize

.c.$obj:
	$(CC) -c $(JCFLAGS) $<

OBJECTS = minilzo.$obj

all:: minilzo.$obj
