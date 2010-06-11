TOP = ..
DIR = $dir_sep
OUTDIR= .
INDIR= .
CC = $cc
OUTPUT_CMD = $output_cmd
CFLAGS = -I"$rt_include" -I..$(DIR)spec$(DIR)include -I. \
	-I..$(DIR)..$(DIR)..$(DIR)C_library$(DIR)libpng  -I..$(DIR)..$(DIR)..$(DIR)C_library$(DIR)zlib
JCFLAGS = $(CFLAGS) $ccflags $optimize
JMTCFLAGS = $(CFLAGS) $mtccflags $optimize
JILCFLAGS = $(CFLAGS) $mtccflags $optimize -DEIF_IL_DLL
LN = copy
MV = $mv
RM = $del
MAKE = $make
MKDIR = $mkdir
LINK = $link32
DLL_FLAGS = $dll_flags
DLL_LIBS = $dll_libs
OBJECTS = eiffel_curl.$obj
MT_OBJECTS = MTeiffel_curl.$obj
IL_OBJECTS = ILeiffel_curl.$obj

.c.$obj:
	$(CC) -c $(JCFLAGS) $<

all:: $output_libraries
	$(MAKE) clean

standard:: eiffel_curl.lib ileiffel_curl.lib
mtstandard:: mteiffel_curl.lib

clean:
	$(RM) *.$obj
	$(RM) *.lib

eiffel_curl.lib: $(OBJECTS)
	$alib_line
	$(MKDIR) ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib
	$(MV) $@ ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib$(DIR)$@

mteiffel_curl.lib: $(MT_OBJECTS)
	$alib_line
	$(MKDIR) ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib
	$(MV) $@ ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib$(DIR)$@

ileiffel_curl.lib: $(IL_OBJECTS)
	$alib_line
	$(MKDIR) ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib
	$(MV) $@ ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib$(DIR)$@

#Multithreaded targets.
MTeiffel_curl.$obj: eiffel_curl.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?

#.NET targets.
ILeiffel_curl.$obj: eiffel_curl.c
	$(CC) $(JILCFLAGS) $(OUTPUT_CMD)$@ -c $?
