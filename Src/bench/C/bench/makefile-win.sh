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

CFLAGS = -I. -I$(TOP)/run-time 

OBJECTS = special_tables.obj

all:: special_tables.obj

