TOP = ..
DIR = $dir_sep
OUTDIR= .
INDIR= .
CC = $cc
OUTPUT_CMD = $output_cmd
CFLAGS = -I"$rt_include" -I. -I"$(MYSQL)\include"
JCFLAGS = $(CFLAGS) $optimize $ccflags 
JMTCFLAGS = $(CFLAGS) $optimize $mtccflags 
JILCFLAGS = $(CFLAGS) $optimize $mtccflags  -DEIF_IL_DLL
LN = copy
MV = $mv
RM = $del
MAKE = $make
MKDIR = $mkdir
OBJECTS = eif_mysql.$obj

.c.$obj:
	$(CC) -c $(JCFLAGS) $<

all:: standard
	$(MAKE) clean

standard:: mysql_store.lib

clean:
	$(RM) *.$obj
	$(RM) *.lib

mysql_store.lib: $(OBJECTS)
	$alib_line
	$(MKDIR) ..$(DIR)..$(DIR)..$(DIR)..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib
	$(MV) $@ ..$(DIR)..$(DIR)..$(DIR)..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib$(DIR)$@
