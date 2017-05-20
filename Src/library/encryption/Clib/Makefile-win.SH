TOP = ..
DIR = $dir_sep
OUTDIR= .
INDIR= .
CC = $cc
OUTPUT_CMD = $output_cmd
CFLAGS = -I"$rt_include" -I.
JCFLAGS = $(CFLAGS) $optimize $ccflags 
JMTCFLAGS = $(CFLAGS) $optimize $mtccflags 
JILCFLAGS = $(CFLAGS) $optimize $mtccflags  -DEIF_IL_DLL
LN = copy
MV = $mv
RM = $del
MAKE = $make
MKDIR = $mkdir
OBJECTS = des.$obj desop.$obj
MT_OBJECTS = MTdes.$obj MTdesop.$obj
IL_OBJECTS = ILdes.$obj ILdesop.$obj

.c.$obj:
	$(CC) -c $(JCFLAGS) $<

all:: $output_libraries
	$(MAKE) clean

standard:: des.lib ildes.lib
mtstandard:: mtdes.lib

clean:
	$(RM) *.$obj
	$(RM) *.lib

des.lib: $(OBJECTS)
	$alib_line
	$(MKDIR) ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib
	$(MV) $@ ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib$(DIR)$@

mtdes.lib: $(MT_OBJECTS)
	$alib_line
	$(MKDIR) ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib
	$(MV) $@ ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib$(DIR)$@

ildes.lib: $(IL_OBJECTS)
	$alib_line
	$(MKDIR) ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib
	$(MV) $@ ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib$(DIR)$@


MTdes.$obj: des.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?

MTdesop.$obj: desop.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?

ILdes.$obj: des.c
	$(CC) $(JILCFLAGS) $(OUTPUT_CMD)$@ -c $?

ILdesop.$obj: desop.c
	$(CC) $(JILCFLAGS) $(OUTPUT_CMD)$@ -c $?
