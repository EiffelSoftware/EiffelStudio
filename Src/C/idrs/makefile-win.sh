TOP = ..
DIR = $dir_sep
OUTDIR= .
INDIR= .
OUTPUT_CMD= $output_cmd
CC = $cc
JCFLAGS = $ccflags -I$(TOP)$(DIR)run-time -I$(TOP)$(DIR)ipc$(DIR)shared $optimize -I$(TOP)
JMTCFLAGS = $mtccflags -I$(TOP)$(DIR)run-time -I$(TOP)$(DIR)ipc$(DIR)shared $optimize -I$(TOP)

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
mtstandard:: MTidrs.$obj

MTidrs.$obj: idrs.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?

