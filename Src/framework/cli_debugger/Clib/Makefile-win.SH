TOP = ..
DIR = $dir_sep
OUTDIR= .
INDIR= .
CC = $cc
OUTPUT_CMD = $output_cmd
OPT_CFLAGS = 
#OPT_CFLAGS = -Zi
#OPT_CFLAGS = -Zi -D_DEBUG -DISE_USE_ASSERT
#OPT_CFLAGS = -Zi -D_DEBUG -DISE_USE_ASSERT -DDBGTRACE_ENABLED
CFLAGS = $(OPT_CFLAGS) -I"$rt_include" -I. -D_UNICODE -DUNICODE
JCFLAGS = $(CFLAGS) $optimize $ccflags 
JMTCFLAGS = $(CFLAGS) $optimize $mtccflags 
JILCFLAGS = $(CFLAGS) $optimize $mtccflags  -DEIF_IL_DLL
LN = copy
MV = $mv
RM = $del
MAKE = $make
MKDIR = $mkdir
LINK = $link32
DLL_FLAGS = $dll_flags
DLL_LIBS = $dll_libs
OBJECTS = cli_debugger.$obj cli_debugger_callback.$obj cli_debugger_callback_id.$obj cli_debugger_utils.$obj

.c.$obj:
	$(CC) -c $(JCFLAGS) $<

.cpp.$obj:
	$(CC) -c $(JCFLAGS) $<

all:: cli_debugger.lib
	$(MAKE) clean

clean:
	$(RM) *.$obj
	$(RM) *.lib

cli_debugger.lib: $(OBJECTS)
	$alib_line
	$(MKDIR) ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib
	$(MV) $@ ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib$(DIR)$@

