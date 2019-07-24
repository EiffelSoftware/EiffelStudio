TOP = ..
DIR = $dir_sep
OUTDIR= .
INDIR= .
CC = $cc
OUTPUT_CMD = $output_cmd
CFLAGS = -I"$rt_include" -I.
JCFLAGS = $(CFLAGS) $optimize $ccflags 
JMTCFLAGS = $(CFLAGS) $optimize $mtccflags 
JILCFLAGS = $(CFLAGS) $optimize $mtccflags  -DEIF_IL_DLL
LN = copy
MV = $mv
RM = $del
MAKE = $make
MKDIR = $mkdir
OBJECTS =   adler32.$obj compress.$obj crc32.$obj deflate.$obj gzclose.$obj gzlib.$obj \
       gzread.$obj gzwrite.$obj infback.$obj inffast.$obj inflate.$obj inftrees.$obj trees.$obj \
       uncompr.$obj zutil.$obj

.c.$obj:
	$(CC) -c $(JCFLAGS) $<

all:: zlib.lib
	$(MAKE) clean

clean:
	$(RM) *.$obj
	$(RM) *.lib

zlib.lib: $(OBJECTS)
	$alib_line
	$(MKDIR) spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib
	$(MV) $@ spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib$(DIR)$@

