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
OBJECTS =   adler32.$obj compress.$obj crc32.$obj deflate.$obj gzio.$obj infback.$obj \
       inffast.$obj inflate.$obj inftrees.$obj trees.$obj uncompr.$obj zutil.$obj

.c.$obj:
	$(CC) -c $(JCFLAGS) $<

all:: exp_lib_dir lib_dir zlib.lib clean

..$(DIR)..$(DIR)library$(DIR)vision2$(DIR)spec:
	$(MKDIR_TARGET)

..$(DIR)..$(DIR)library$(DIR)vision2$(DIR)spec$(DIR)$(ISE_C_COMPILER): ..$(DIR)..$(DIR)library$(DIR)vision2$(DIR)spec
	$(MKDIR_TARGET)

..$(DIR)..$(DIR)library$(DIR)vision2$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM): ..$(DIR)..$(DIR)library$(DIR)vision2$(DIR)spec$(DIR)$(ISE_C_COMPILER)
	$(MKDIR_TARGET)

..$(DIR)..$(DIR)library$(DIR)vision2$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib: ..$(DIR)..$(DIR)library$(DIR)vision2$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)
	$(MKDIR_TARGET)

lib_dir: ..$(DIR)..$(DIR)library$(DIR)vision2$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib

..$(DIR)..$(DIR)compatible$(DIR)library$(DIR)vision2$(DIR)spec:
	$(MKDIR_TARGET)

..$(DIR)..$(DIR)compatible$(DIR)library$(DIR)vision2$(DIR)spec$(DIR)$(ISE_C_COMPILER): ..$(DIR)..$(DIR)compatible$(DIR)library$(DIR)vision2$(DIR)spec
	$(MKDIR_TARGET)

..$(DIR)..$(DIR)compatible$(DIR)library$(DIR)vision2$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM): ..$(DIR)..$(DIR)compatible$(DIR)library$(DIR)vision2$(DIR)spec$(DIR)$(ISE_C_COMPILER)
	$(MKDIR_TARGET)

..$(DIR)..$(DIR)compatible$(DIR)library$(DIR)vision2$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib: ..$(DIR)..$(DIR)compatible$(DIR)library$(DIR)vision2$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)
	$(MKDIR_TARGET)

exp_lib_dir: ..$(DIR)..$(DIR)compatible$(DIR)library$(DIR)vision2$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib


clean:
	$(RM) *.$obj
	$(RM) *.lib
	$(RM) *.BAK

zlib.lib: $(OBJECTS)
	$alib_line
	$(MV) $@ ..$(DIR)..$(DIR)library$(DIR)vision2$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib$(DIR)$@
	$(MV) $@ ..$(DIR)..$(DIR)compatible$(DIR)library$(DIR)vision2$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib$(DIR)$@
