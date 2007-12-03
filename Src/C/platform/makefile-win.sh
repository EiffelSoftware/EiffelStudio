TOP = ..
DIR = $dir_sep
OUTDIR = .
INDIR = .
CC = $cc
OUTPUT_CMD = $output_cmd
JCFLAGS = $(CFLAGS) $ccflags $optimize
JMTCFLAGS = $(CFLAGS) $mtccflags $optimize
CFLAGS = -I$(TOP) -I$(TOP)$(DIR)run-time -I$(TOP)$(DIR)run-time$(DIR)include -I$(TOP)$(DIR)ipc$(DIR)shared
MAKE = $make

OBJECTS = names.$obj commands.$obj

MT_OBJECTS = MTnames.$obj MTcommands.$obj

.c.$obj:
	$(CC) -c $(JCFLAGS) $<

all:: $output_libraries

dll: standard
mtdll: mtstandard
standard: platform.$lib
mtstandard: mtplatform.$lib

platform.$lib: $(OBJECTS)
	$alib_line

mtplatform.$lib: $(MT_OBJECTS)
	$alib_line

MTnames.$obj: names.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $? 

MTcommands.$obj: commands.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $? 
