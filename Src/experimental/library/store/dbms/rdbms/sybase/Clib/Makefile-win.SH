TOP = ..
DIR = $dir_sep
OUTDIR= .
INDIR= .
CC = $cc
OUTPUT_CMD = $output_cmd
CFLAGS = -I"$rt_include" -I. -I"$(SYBASE)$(DIR)include"
JCFLAGS = $(CFLAGS) $optimize $ccflags 
JMTCFLAGS = $(CFLAGS) $optimize $mtccflags 
JILCFLAGS = $(CFLAGS) $optimize $mtccflags  -DEIF_IL_DLL
LN = copy
MV = $mv
RM = $del
MAKE = $make
MKDIR = $mkdir
OBJECTS = sybase.$obj
IL_OBJECTS = ILsybase.$obj

.c.$obj:
	$(CC) -c $(JCFLAGS) $<

all:: standard
	$(MAKE) clean

standard:: sybase_store.lib il_sybase_store.lib

clean:
	$(RM) *.$obj
	$(RM) *.lib

sybase_store.lib: $(OBJECTS)
	$alib_line
	$(MKDIR) ..$(DIR)..$(DIR)..$(DIR)..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib
	$(MV) $@ ..$(DIR)..$(DIR)..$(DIR)..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib$(DIR)$@

il_sybase_store.lib: $(IL_OBJECTS)
	$alib_line
	$(MKDIR) ..$(DIR)..$(DIR)..$(DIR)..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib
	$(MV) $@ ..$(DIR)..$(DIR)..$(DIR)..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib$(DIR)$@

ILsybase.$obj: sybase.c
	$(CC) $(JILCFLAGS) $(OUTPUT_CMD)$@ -c $?
