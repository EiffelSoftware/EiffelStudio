TOP = ..
DIR = $dir_sep
OUTDIR= .
INDIR= .
CC = $cc
OUTPUT_CMD = $output_cmd
CFLAGS = -I"$rt_include" -I. -I"$(II_SYSTEM)$(DIR)include"
JCFLAGS = $(CFLAGS) $ccflags $optimize
JMTCFLAGS = $(CFLAGS) $mtccflags $optimize
JILCFLAGS = $(CFLAGS) $mtccflags $optimize -DEIF_IL_DLL
LN = copy
MV = $mv
RM = $del
MKDIR_TARGET = $mkdir_target
OBJECTS = ingres.$obj
IL_OBJECTS = ILingres.$obj

.c.$obj:
	$(CC) -c $(JCFLAGS) $<

all:: lib_dir standard clean
standard:: ingres_store.lib il_ingres_store.lib

..$(DIR)..$(DIR)..$(DIR)..$(DIR)spec:
	$(MKDIR_TARGET)

..$(DIR)..$(DIR)..$(DIR)..$(DIR)spec$(DIR)$(ISE_C_COMPILER): ..$(DIR)..$(DIR)..$(DIR)..$(DIR)spec
	$(MKDIR_TARGET)

..$(DIR)..$(DIR)..$(DIR)..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM): ..$(DIR)..$(DIR)..$(DIR)..$(DIR)spec$(DIR)$(ISE_C_COMPILER)
	$(MKDIR_TARGET)

..$(DIR)..$(DIR)..$(DIR)..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib: ..$(DIR)..$(DIR)..$(DIR)..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)
	$(MKDIR_TARGET)

lib_dir: ..$(DIR)..$(DIR)..$(DIR)..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib

clean:
	$(RM) *.$obj
	$(RM) *.lib
	$(RM) *.BAK

ingres_store.lib: $(OBJECTS)
	$alib_line
	$(MV) $@ ..$(DIR)..$(DIR)..$(DIR)..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib$(DIR)$@

il_ingres_store.lib: $(IL_OBJECTS)
	$alib_line
	$(MV) $@ ..$(DIR)..$(DIR)..$(DIR)..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib$(DIR)$@

ILingres.$obj: ingres.c
	$(CC) $(JILCFLAGS) $(OUTPUT_CMD)$@ -c $?
