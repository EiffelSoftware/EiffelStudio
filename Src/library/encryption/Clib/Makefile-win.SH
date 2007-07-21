TOP = ..
DIR = $dir_sep
OUTDIR= .
INDIR= .
CC = $cc
OUTPUT_CMD = $output_cmd
CFLAGS = -I"$rt_include" -I.
JCFLAGS = $(CFLAGS) $ccflags $optimize
JMTCFLAGS = $(CFLAGS) $mtccflags $optimize
JILCFLAGS = $(CFLAGS) $mtccflags $optimize -DEIF_IL_DLL
LN = copy
MV = $mv
RM = $del
MKDIR_TARGET = $mkdir_target
OBJECTS = des.$obj desop.$obj
MT_OBJECTS = MTdes.$obj MTdesop.$obj
IL_OBJECTS = ILdes.$obj ILdesop.$obj

.c.$obj:
	$(CC) -c $(JCFLAGS) $<

all:: lib_dir $output_libraries clean

standard:: des.lib ildes.lib
mtstandard:: mtdes.lib

..$(DIR)spec:
	$(MKDIR_TARGET)

..$(DIR)spec$(DIR)$(ISE_C_COMPILER): ..$(DIR)spec
	$(MKDIR_TARGET)

..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM): ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)
	$(MKDIR_TARGET)

..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib: ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)
	$(MKDIR_TARGET)

lib_dir: ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib

clean:
	$(RM) *.$obj
	$(RM) *.lib
	$(RM) *.BAK

des.lib: $(OBJECTS)
	$alib_line
	$(MV) $@ ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib$(DIR)$@

mtdes.lib: $(MT_OBJECTS)
	$alib_line
	$(MV) $@ ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib$(DIR)$@

ildes.lib: $(IL_OBJECTS)
	$alib_line
	$(MV) $@ ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib$(DIR)$@


MTdes.$obj: des.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?

MTdesop.$obj: desop.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?

ILdes.$obj: des.c
	$(CC) $(JILCFLAGS) $(OUTPUT_CMD)$@ -c $?

ILdesop.$obj: desop.c
	$(CC) $(JILCFLAGS) $(OUTPUT_CMD)$@ -c $?
