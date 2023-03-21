TOP = ..
DIR = $dir_sep
OUTDIR= .
INDIR= .
CC = $cc
OUTPUT_CMD = $output_cmd
CFLAGS = -I"$rt_include" -I . 
JCFLAGS = $(CFLAGS) $optimize $ccflags
JMTCFLAGS = $(CFLAGS) $optimize $mtccflags
JILCFLAGS = $(CFLAGS) $optimize $mtccflags  -DEIF_IL_DLL
LN = copy
MV = $mv
RM = $del
MAKE = $make
MKDIR = $mkdir
OBJECTS = bigdigits.$obj

.c.$obj:
	$(CC) -c $(JCFLAGS) $<

all:: standard
	$(MAKE) clean

standard:: eif_bigdigits.lib

clean:
	$(RM) *.$obj
	$(RM) *.lib

eif_bigdigits.lib: $(OBJECTS)
	$alib_line
	$(MKDIR) $(INDIR)$(DIR)C$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib
	$(MV) $@ $(INDIR)$(DIR)C$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib$(DIR)$@
