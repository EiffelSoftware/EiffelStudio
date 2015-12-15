TOP = ..
DIR = $dir_sep
OUTDIR= .
INDIR= .
CC = $cc
OUTPUT_CMD = $output_cmd
CFLAGS = -I"$rt_include" -I..\zlib -I.
JCFLAGS = $(CFLAGS) $ccflags $optimize
JMTCFLAGS = $(CFLAGS) $mtccflags $optimize
JILCFLAGS = $(CFLAGS) $mtccflags $optimize -DEIF_IL_DLL
LN = copy
MV = $mv
RM = $del
MAKE = $make
MKDIR = $mkdir
OBJECTS = png.$obj pngerror.$obj pngget.$obj pngmem.$obj pngpread.$obj \
		pngread.$obj pngrio.$obj pngrtran.$obj pngrutil.$obj pngset.$obj \
		pngtrans.$obj pngwio.$obj pngwrite.$obj pngwtran.$obj pngwutil.$obj

.c.$obj:
	$(CC) -c $(JCFLAGS) $<

all:: libpng.lib
	$(MAKE) clean

clean:
	$(RM) *.$obj
	$(RM) *.lib
	$(RM) *.BAK

libpng.lib: $(OBJECTS)
	$alib_line
	$(MKDIR) "$(IRON_PATH)$(DIR)packages$(DIR)vision2$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib"
	$(MV) $@ "$(IRON_PATH)$(DIR)packages$(DIR)vision2$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib$(DIR)$@"
