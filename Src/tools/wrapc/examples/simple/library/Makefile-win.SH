TOP = ..
DIR = $dir_sep
OUTDIR= .
INDIR= .
CC = $cc
OUTPUT_CMD = $output_cmd
CFLAGS = -I"$rt_include" -I $(TOP)$(DIR)include  -I $(TOP)$(DIR)$(TOP)$(DIR)$(TOP)$(DIR)manual_wrapper$(DIR)c$(DIR)include 
JCFLAGS = $(CFLAGS) $optimize $ccflags 
JMTCFLAGS = $(CFLAGS) $optimize $mtccflags 
JILCFLAGS = $(CFLAGS) $optimize $mtccflags  -DEIF_IL_DLL
LN = copy
MV = $mv
RM = $del
MAKE = $make
MKDIR = $mkdir
OBJECTS = 	simple_c.$obj 

.c.$obj:
	$(CC) -c $(JCFLAGS) $<

all:: standard
	$(MAKE) clean

standard:: eif_simple.lib

clean:
	$(RM) *.$obj
	$(RM) *.lib

eif_simple.lib: $(OBJECTS)
	$alib_line
	$(MKDIR) $(TOP)$(DIR)$(TOP)$(DIR)$(TOP)$(DIR)C$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib
	$(MV) $@ $(TOP)$(DIR)$(TOP)$(DIR)$(TOP)$(DIR)C$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib$(DIR)$@
