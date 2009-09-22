TOP = ..
DIR = $dir_sep
OUTDIR= .
INDIR= .
CC = $cc
OUTPUT_CMD = $output_cmd
CFLAGS = -I"$rt_include" -I..$(DIR)zlib -I.
JCFLAGS = $(CFLAGS) $ccflags $optimize
JMTCFLAGS = $(CFLAGS) $mtccflags $optimize
JILCFLAGS = $(CFLAGS) $mtccflags $optimize -DEIF_IL_DLL
LN = copy
MV = $mv
RM = $del
MKDIR_TARGET = $mkdir_target
OBJECTS = png.$obj pngerror.$obj pngget.$obj pngmem.$obj pngpread.$obj \
		pngread.$obj pngrio.$obj pngrtran.$obj pngrutil.$obj pngset.$obj \
		pngtrans.$obj pngwio.$obj pngwrite.$obj pngwtran.$obj pngwutil.$obj

.c.$obj:
	$(CC) -c $(JCFLAGS) $<

all:: exp_lib_dir lib_dir libpng.lib clean

..$(DIR)..$(DIR)library$(DIR)vision2$(DIR)spec:
	$(MKDIR_TARGET)

..$(DIR)..$(DIR)library$(DIR)vision2$(DIR)spec$(DIR)$(ISE_C_COMPILER): ..$(DIR)..$(DIR)library$(DIR)vision2$(DIR)spec
	$(MKDIR_TARGET)

..$(DIR)..$(DIR)library$(DIR)vision2$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM): ..$(DIR)..$(DIR)library$(DIR)vision2$(DIR)spec$(DIR)$(ISE_C_COMPILER)
	$(MKDIR_TARGET)

..$(DIR)..$(DIR)library$(DIR)vision2$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib: ..$(DIR)..$(DIR)library$(DIR)vision2$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)
	$(MKDIR_TARGET)

lib_dir: ..$(DIR)..$(DIR)library$(DIR)vision2$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib

..$(DIR)..$(DIR)experimental$(DIR)library$(DIR)vision2$(DIR)spec:
	$(MKDIR_TARGET)

..$(DIR)..$(DIR)experimental$(DIR)library$(DIR)vision2$(DIR)spec$(DIR)$(ISE_C_COMPILER): ..$(DIR)..$(DIR)experimental$(DIR)library$(DIR)vision2$(DIR)spec
	$(MKDIR_TARGET)

..$(DIR)..$(DIR)experimental$(DIR)library$(DIR)vision2$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM): ..$(DIR)..$(DIR)experimental$(DIR)library$(DIR)vision2$(DIR)spec$(DIR)$(ISE_C_COMPILER)
	$(MKDIR_TARGET)

..$(DIR)..$(DIR)experimental$(DIR)library$(DIR)vision2$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib: ..$(DIR)..$(DIR)experimental$(DIR)library$(DIR)vision2$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)
	$(MKDIR_TARGET)

exp_lib_dir: ..$(DIR)..$(DIR)experimental$(DIR)library$(DIR)vision2$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib


clean:
	$(RM) *.$obj
	$(RM) *.lib
	$(RM) *.BAK

libpng.lib: $(OBJECTS)
	$alib_line
	$(MV) $@ ..$(DIR)..$(DIR)library$(DIR)vision2$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib$(DIR)$@
	$(MV) $@ ..$(DIR)..$(DIR)experimental$(DIR)library$(DIR)vision2$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib$(DIR)$@
