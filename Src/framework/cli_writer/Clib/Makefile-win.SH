TOP = ..
DIR = $dir_sep
OUTDIR= .
INDIR= .
CC = $cc
OUTPUT_CMD = $output_cmd
CFLAGS = -I"$rt_include" -I. -D_UNICODE -DUNICODE
JCFLAGS = $(CFLAGS) $optimize $ccflags 
JMTCFLAGS = $(CFLAGS) $optimize $mtccflags 
JILCFLAGS = $(CFLAGS) $optimize $mtccflags  -DEIF_IL_DLL
OPT_CFLAGS = 
#OPT_CFLAGS = -DASSERTIONS 
#OPT_CFLAGS = -DASSERTIONS -DDBGTRACE_ENABLED
#OPT_CFLAGS = -DDBGTRACE_ENABLED
LN = copy
MV = $mv
RM = $del
MAKE = $make
MKDIR = $mkdir
LINK = $link32
DLL_FLAGS = $dll_flags
DLL_LIBS = $dll_libs
OBJECTS = cli_writer.$obj metadata_consumer.$obj

.c.$obj:
	$(CC) -c $(JCFLAGS) $<

.cpp.$obj:
	$(CC) -c $(JCFLAGS) $<

all:: cli_writer.lib
	$(MAKE) clean

clean:
	$(RM) *.$obj
	$(RM) *.lib

cli_writer.lib: $(OBJECTS)
	$alib_line
	$(MKDIR)  ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib
	$(MV) $@  ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib$(DIR)$@

#Note that the line below will only work if you have `midl' in your PATH.
metadata_consumer.c: metadata_consumer.idl
	midl -notlb -header metadata_consumer.h -iid metadata_consumer.c metadata_consumer.idl
