TOP = ..
DIR = $dir_sep
OUTDIR= .
INDIR= .
CC = $cc
OUTPUT_CMD = $output_cmd
CFLAGS = -I"$rt_include" -I. -D_UNICODE -DUNICODE
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
OBJECTS = cli_debugger.$obj cli_debugger_callback.$obj cli_debugger_callback_id.$obj cli_debugger_utils.$obj

.c.$obj:
	$(CC) -c $(JCFLAGS) $<

.cpp.$obj:
	$(CC) -c $(JCFLAGS) $<

all:: lib_dir cli_debugger.lib clean

OBJ:
	$(MKDIR_TARGET)

lib_dir: OBJ

clean:
	$(RM) *.$obj
	$(RM) *.lib
	$(RM) *.BAK

cli_debugger.lib: $(OBJECTS)
	$alib_line
	$(MV) $@ OBJ$(DIR)$@

