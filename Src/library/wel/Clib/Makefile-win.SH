TOP = ..
DIR = $dir_sep
OUTDIR= .
INDIR= .
CC = $cc
OUTPUT_CMD = $output_cmd
CFLAGS = -I"$rt_include" -I..$(DIR)spec$(DIR)windows$(DIR)include -I. -D_UNICODE -DUNICODE
JCFLAGS = $(CFLAGS) $optimize $ccflags 
JMTCFLAGS = $(CFLAGS) $optimize $mtccflags 
JILCFLAGS = $(CFLAGS) $optimize $ccflags  -DEIF_IL_DLL
LN = copy
MV = $mv
RM = $del
MAKE = $make
MKDIR = $mkdir
LINK = $link32
DLL_FLAGS = $dll_flags
DLL_LIBS = $dll_libs
OBJECTS = disptchr.$obj enumfont.$obj enum_child_windows.$obj estream.$obj msgboxpa.$obj \
		drawstate.$obj dynload.$obj choose_folder.$obj capture.$obj user_validation.$obj
MT_OBJECTS = MTdisptchr.$obj MTenumfont.$obj MTenum_child_windows.$obj MTestream.$obj MTmsgboxpa.$obj \
		MTdrawstate.$obj MTdynload.$obj MTchoose_folder.$obj MTcapture.$obj \
		MTwel_thr_init.$obj MTuser_validation.$obj
IL_OBJECTS = ILdisptchr.$obj ILenumfont.$obj ILenum_child_windows.$obj ILestream.$obj ILmsgboxpa.$obj \
		ILdrawstate.$obj ILdynload.$obj ILchoose_folder.$obj ILcapture.$obj ILuser_validation.$obj


.c.$obj:
	$(CC) -c $(JCFLAGS) $<

all:: $output_libraries
	$(MAKE) clean

standard:: wel.lib ilwel.lib
mtstandard:: mtwel.lib

clean:
	$(RM) *.$obj
	$(RM) *.lib

wel.lib: $(OBJECTS)
	$alib_line
	$(MKDIR) ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib
	$(MV) $@ ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib$(DIR)$@

mtwel.lib: $(MT_OBJECTS)
	$alib_line
	$(MKDIR) ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib
	$(MV) $@ ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib$(DIR)$@

ilwel.lib: $(IL_OBJECTS)
	$alib_line
	$(MKDIR) ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib
	$(MV) $@ ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib$(DIR)$@


#Multithreaded targets.
MTnetwork.$obj: network.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?

MTdisptchr.$obj: disptchr.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?

MTenumfont.$obj: enumfont.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?

MTenum_child_windows.$obj: enum_child_windows.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?

MTestream.$obj: estream.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?

MTmsgboxpa.$obj: msgboxpa.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?

MTdrawstate.$obj: drawstate.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?

MTdynload.$obj: dynload.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?

MTchoose_folder.$obj: choose_folder.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?

MTcapture.$obj: capture.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?

MTwel_thr_init.$obj: wel_thr_init.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?

MTuser_validation.$obj: user_validation.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $?


#.NET targets.
ILnetwork.$obj: network.c
	$(CC) $(JILCFLAGS) $(OUTPUT_CMD)$@ -c $?

ILdisptchr.$obj: disptchr.c
	$(CC) $(JILCFLAGS) $(OUTPUT_CMD)$@ -c $?

ILenumfont.$obj: enumfont.c
	$(CC) $(JILCFLAGS) $(OUTPUT_CMD)$@ -c $?

ILenum_child_windows.$obj: enum_child_windows.c
	$(CC) $(JILCFLAGS) $(OUTPUT_CMD)$@ -c $?

ILestream.$obj: estream.c
	$(CC) $(JILCFLAGS) $(OUTPUT_CMD)$@ -c $?

ILmsgboxpa.$obj: msgboxpa.c
	$(CC) $(JILCFLAGS) $(OUTPUT_CMD)$@ -c $?

ILdrawstate.$obj: drawstate.c
	$(CC) $(JILCFLAGS) $(OUTPUT_CMD)$@ -c $?

ILdynload.$obj: dynload.c
	$(CC) $(JILCFLAGS) $(OUTPUT_CMD)$@ -c $?

ILchoose_folder.$obj: choose_folder.c
	$(CC) $(JILCFLAGS) $(OUTPUT_CMD)$@ -c $?

ILcapture.$obj: capture.c
	$(CC) $(JILCFLAGS) $(OUTPUT_CMD)$@ -c $?

ILuser_validation.$obj: user_validation.c
	$(CC) $(JILCFLAGS) $(OUTPUT_CMD)$@ -c $?
