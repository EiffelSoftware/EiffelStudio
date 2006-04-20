TOP = ..
OUTDIR= .
INDIR= .
OUTPUT_CMD= $output_cmd
CC = $cc
JCFLAGS = $ccflags -I$(TOP)\run-time -I$(TOP)\ipc\shared $optimize -I$(TOP)
JMTCFLAGS = $mtccflags -I$(TOP)\run-time -I$(TOP)\ipc\shared $optimize -I$(TOP)
MV = copy
RM = del

OBJECTS = \
	idrs.$obj

MT_OBJECTS = \
	MTidrs.$obj

.c.$obj:
	$(CC) -c $(JCFLAGS) $<

all:: $output_libraries

dll: standard
mtdll: mtstandard
standard:: idrs.$obj
mtstandard:: mtidrs.$obj

MTidrs.$obj: idrs.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?

