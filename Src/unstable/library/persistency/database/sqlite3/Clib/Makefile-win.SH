TOP = ..
DIR = $dir_sep
OUTDIR= .
INDIR= .
CC = $cc
OUTPUT_CMD = $output_cmd
CFLAGS = -I"$rt_include" -I..$(DIR)spec$(DIR)include -I.
JCFLAGS = $(CFLAGS) $optimize $ccflags -DSQLITE_THREADSAFE=0 -DSQLITE_OMIT_LOAD_EXTENSION=1
JMTCFLAGS = $(CFLAGS) $optimize $mtccflags -DSQLITE_THREADSAFE=1 -DSQLITE_OMIT_LOAD_EXTENSION=1
JILCFLAGS = $(CFLAGS) $optimize $mtccflags  -DEIF_IL_DLL -DSQLITE_THREADSAFE=1 -DSQLITE_OMIT_LOAD_EXTENSION=1
LN = copy
MV = $mv
RM = $del
MAKE = $make
MKDIR = $mkdir
LINK = $link32
DLL_FLAGS = $dll_flags
DLL_LIBS = $dll_libs
OBJECTS = esqlite.$obj sqlite3.$obj
MT_OBJECTS = MTesqlite.$obj MTsqlite3.$obj
IL_OBJECTS = ILesqlite.$obj ILsqlite3.$obj

.c.$obj:
	$(CC) -c $(JCFLAGS) $<

all:: $output_libraries
	$(MAKE) clean

standard:: esqlite.lib ilesqlite.lib
mtstandard:: mtesqlite.lib

clean:
	$(RM) *.$obj
	$(RM) *.lib

# Lib 

esqlite.lib: $(OBJECTS)
	$alib_line
	$(MKDIR) ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib
	$(MV) $@ ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib$(DIR)$@

mtesqlite.lib: $(MT_OBJECTS)
	$alib_line
	$(MKDIR) ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib
	$(MV) $@ ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib$(DIR)$@

ilesqlite.lib: $(IL_OBJECTS)
	$alib_line
	$(MKDIR) ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib
	$(MV) $@ ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib$(DIR)$@

# Obj

sqlite3.$obj: sqlite3.c
	$(CC) $(JCFLAGS) $(OUTPUT_CMD)$@ -c $?

#Multithreaded targets.
MTsqlite3.$obj: sqlite3.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?

#.NET targets.
ILsqlite3.$obj: sqlite3.c
	$(CC) $(JILCFLAGS) $(OUTPUT_CMD)$@ -c $?

# Eiffel lib
esqlite.$obj: esqlite.c
	$(CC) $(JCFLAGS) $(OUTPUT_CMD)$@ -c $?

#Multithreaded targets.
MTesqlite.$obj: esqlite.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?

#.NET targets.
ILesqlite.$obj: esqlite.c
	$(CC) $(JILCFLAGS) $(OUTPUT_CMD)$@ -c $?
