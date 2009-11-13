TOP = ..
DIR = $dir_sep
OUTDIR= .
INDIR= .
CC = $cc
OUTPUT_CMD = $output_cmd
CFLAGS = -Zi -I"$rt_include" -I..$(DIR)spec$(DIR)include -I.
JCFLAGS = $(CFLAGS) $ccflags $optimize -DSQLITE_THREADSAFE=0
JMTCFLAGS = $(CFLAGS) $mtccflags $optimize -DSQLITE_THREADSAFE=1
JILCFLAGS = $(CFLAGS) $mtccflags $optimize -DEIF_IL_DLL -DSQLITE_THREADSAFE=1
LN = copy
MV = $mv
RM = $del
MKDIR_TARGET = $mkdir_target
LINK = $link32
DLL_FLAGS = $dll_flags
DLL_LIBS = $dll_libs
OBJECTS = esqlite.$obj sqlite3.obj
MT_OBJECTS = MTesqlite.$obj MTsqlite3.obj
IL_OBJECTS = ILesqlite.$obj ILsqlite3.obj

.c.$obj:
	$(CC) -c $(JCFLAGS) $<

all:: lib_dir $output_libraries clean

standard:: esqlite.lib ilesqlite.lib
mtstandard:: mtesqlite.lib

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

esqlite.lib: $(OBJECTS)
	$alib_line
	$(MV) $@ ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib$(DIR)$@

mtesqlite.lib: $(MT_OBJECTS)
	$alib_line
	$(MV) $@ ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib$(DIR)$@

ilesqlite.lib: $(IL_OBJECTS)
	$alib_line
	$(MV) $@ ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib$(DIR)$@

sqlite.$obj: sqlite.c
	$(CC) $(JCFLAGS) $(OUTPUT_CMD)$@ -c $?

#Multithreaded targets.
MTsqlite.$obj: sqlite.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?

#.NET targets.
ILsqlite.$obj: sqlite.c
	$(CC) $(JILCFLAGS) $(OUTPUT_CMD)$@ -c $?

#Multithreaded targets.
esqlite.$obj: esqlite.c
	$(CC) $(JCFLAGS) $(OUTPUT_CMD)$@ -c $?

#Multithreaded targets.
MTesqlite.$obj: esqlite.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?

#.NET targets.
ILesqlite.$obj: esqlite.c
	$(CC) $(JILCFLAGS) $(OUTPUT_CMD)$@ -c $?
