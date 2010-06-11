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
MAKE = $make
MKDIR = $mkdir
OBJECTS =   adler32.$obj compress.$obj crc32.$obj deflate.$obj gzio.$obj infback.$obj \
       inffast.$obj inflate.$obj inftrees.$obj trees.$obj uncompr.$obj zutil.$obj

.c.$obj:
	$(CC) -c $(JCFLAGS) $<

all:: zlib.lib
	$(MAKE) clean

clean:
	$(RM) *.$obj
	$(RM) *.lib
	$(RM) *.BAK

zlib.lib: $(OBJECTS)
	$alib_line
	$(MKDIR) ..$(DIR)..$(DIR)library$(DIR)vision2$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib
	$(MV) $@ ..$(DIR)..$(DIR)library$(DIR)vision2$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib$(DIR)$@
	$(MKDIR) ..$(DIR)..$(DIR)compatible$(DIR)library$(DIR)vision2$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib
	$(MV) $@ ..$(DIR)..$(DIR)compatible$(DIR)library$(DIR)vision2$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib$(DIR)$@
