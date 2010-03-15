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
MKDIR_TARGET = $mkdir_target
LINK = $link32
DLL_FLAGS = $dll_flags
DLL_LIBS = $dll_libs
OBJECTS = load_pixmap.$obj
MT_OBJECTS = MTload_pixmap.$obj
IL_OBJECTS = ILload_pixmap.$obj

.c.$obj:
	$(CC) -c $(JCFLAGS) $<

all:: lib_dir $output_libraries clean

standard:: vision2.lib ilvision2.lib
mtstandard:: mtvision2.lib

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

vision2.lib: $(OBJECTS)
	$alib_line
	$(MV) $@ ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib$(DIR)$@

mtvision2.lib: $(MT_OBJECTS)
	$alib_line
	$(MV) $@ ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib$(DIR)$@

ilvision2.lib: $(IL_OBJECTS)
	$alib_line
	$(MV) $@ ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib$(DIR)$@


vision2_hook.dll: vision2_hook.$obj
	$(LINK) $(DLL_FLAGS) $? $(DLL_LIBS)
	$(MV) $@ ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)dll$(DIR)$@

#Multithreaded targets.
MTload_pixmap.$obj: load_pixmap.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?

#.NET targets.
ILload_pixmap.$obj: load_pixmap.c
	$(CC) $(JILCFLAGS) $(OUTPUT_CMD)$@ -c $?
