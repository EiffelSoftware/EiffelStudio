TOP = ..
DIR = $dir_sep
OUTDIR= .
INDIR= .
CC = $cc
OUTPUT_CMD = $output_cmd
CFLAGS = -I"$rt_include" -I..$(DIR)spec$(DIR)include -I. \
	-I..$(DIR)..$(DIR)..$(DIR)C_library$(DIR)curl$(DIR)include 
JCFLAGS = $(CFLAGS) $optimize $ccflags 
JMTCFLAGS = $(CFLAGS) $optimize $mtccflags 
JILCFLAGS = $(CFLAGS) $optimize $mtccflags  -DEIF_IL_DLL
JSTFLAGS =  $(JCFLAGS) -DCURL_STATICLIB
JMTSTFLAGS = $(JMTCFLAGS) -DCURL_STATICLIB
LN = copy
MV = $mv
RM = $del
MAKE = $make
MKDIR = $mkdir
LINK = $link32
EIF_STATIC_CURL_LIB = $(ISE_LIBRARY)$(DIR)C_library$(DIR)curl$(DIR)spec$(DIR)$(ISE_PLATFORM)$(DIR)static$(DIR)lib$(DIR)libcurl_a.lib
DLL_FLAGS = $dll_flags
DLL_LIBS = $dll_libs
OBJECTS = eiffel_curl.$obj
MT_OBJECTS = MTeiffel_curl.$obj
IL_OBJECTS = ILeiffel_curl.$obj
STATIC_OBJECTS = eiffel_curl_static.$obj
MT_STATIC_OBJECTS = MTeiffel_curl_static.$obj
LNKLIB = $link32 /lib
LNK = $(LNKLIB) $(EIF_STATIC_CURL_LIB)

.c.$obj:
	$(CC) -c $(JCFLAGS) $<

all:: $output_libraries
	$(MAKE) clean
 
standard:: eiffel_curl.lib ileiffel_curl.lib eiffel_curl_static.lib
mtstandard:: mteiffel_curl.lib MTeiffel_curl_static.lib

clean:
	$(RM) *.$obj
	$(RM) *.lib


eiffel_curl_static.lib: $(STATIC_OBJECTS) 
	$alib_line
	$(MKDIR) ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib
	$(MV) $@ ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib$(DIR)$@

MTeiffel_curl_static.lib: $(MT_STATIC_OBJECTS)
	$alib_line
	$(MKDIR) ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib
	$(MV) $@ ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib$(DIR)$@	

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

#Static targets.
eiffel_curl_static.$obj: eiffel_curl.c
	$(CC) $(JSTFLAGS) $(OUTPUT_CMD)$@ -c $?

MTeiffel_curl_static.$obj: eiffel_curl.c
	$(CC) $(JMTSTFLAGS) $(OUTPUT_CMD)$@ -c $?

#Multithreaded targets.
MTeiffel_curl.$obj: eiffel_curl.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?

#.NET targets.
ILeiffel_curl.$obj: eiffel_curl.c
	$(CC) $(JILCFLAGS) $(OUTPUT_CMD)$@ -c $?
