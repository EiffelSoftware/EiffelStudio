TOP = ..
DIR = $dir_sep
OUTDIR= .
INDIR= .
CC = $cc
OUTPUT_CMD = $output_cmd
CFLAGS = -I"$rt_include" -I $(TOP)$(DIR)include -I $(TOP)$(DIR)$(TOP)$(DIR)$(TOP)$(DIR)generated_wrapper$(DIR)c$(DIR)include -I $(TOP)$(DIR)$(TOP)$(DIR)$(TOP)$(DIR)C$(DIR)include  
JCFLAGS = $(CFLAGS) $optimize $ccflags
JMTCFLAGS = $(CFLAGS) $optimize $mtccflags
JILCFLAGS = $(CFLAGS) $optimize $mtccflags  -DEIF_IL_DLL
LN = copy
MV = $mv
RM = $del
MAKE = $make
MKDIR = $mkdir
OBJECTS = ewg_wrapc_testing_callback_c_glue_code.$obj wrapc_testing.$obj

.c.$obj:
	$(CC) -c $(JCFLAGS) $<

all:: standard
	$(MAKE) clean

standard:: eif_wrapc_testing.lib

clean:
	$(RM) *.$obj
	$(RM) *.lib

eif_wrapc_testing.lib: $(OBJECTS)
	$alib_line
	$(MKDIR) $(TOP)$(DIR)$(TOP)$(DIR)$(TOP)$(DIR)C$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib
	$(MV) $@ $(TOP)$(DIR)$(TOP)$(DIR)$(TOP)$(DIR)C$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib$(DIR)$@