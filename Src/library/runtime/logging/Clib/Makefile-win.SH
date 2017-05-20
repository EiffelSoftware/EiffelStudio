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
LN = copy
MV = $mv
RM = $del
MAKE = $make
MKDIR = $mkdir
LINK = $link32
DLL_FLAGS = $dll_flags
DLL_LIBS = $dll_libs

.c.$obj:
	$(CC) -c $(JCFLAGS) $<

all:: standard clean
standard:: eif_eventlog_messages.dll

clean:
	$(RM) *.$obj
	$(RM) *.lib
	$(RM) *.dll
	$(RM) *.RES
	$(RM) *.bin

eif_eventlog_messages.dll: eif_eventlog_messages.mc
	mc eif_eventlog_messages.mc
	rc eif_eventlog_messages.rc
  	$(LINK) $(DLL_FLAGS) $(DLL_LIBS) -noentry eif_eventlog_messages.res
	$(MKDIR) ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib
	$(MV) $@ ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib$(DIR)$@
