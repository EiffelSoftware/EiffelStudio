TOP = ..
DIR = $dir_sep
OUTDIR= .
INDIR= .
CC = $cc
OUTPUT_CMD = $output_cmd
CFLAGS = -I"$rt_include" -I..$(DIR)spec$(DIR)windows$(DIR)include -I. -D_UNICODE -DUNICODE
JCFLAGS = $(CFLAGS) $ccflags $optimize
JMTCFLAGS = $(CFLAGS) $mtccflags $optimize
JILCFLAGS = $(CFLAGS) $ccflags $optimize -DEIF_IL_DLL
LN = copy
MV = $mv
RM = $del
MKDIR_TARGET = $mkdir_target
LINK = $link32
DLL_FLAGS = $dll_flags
DLL_LIBS = $dll_libs
OBJECTS = disptchr.$obj enumfont.$obj enum_child_windows.$obj estream.$obj msgboxpa.$obj \
		diskspace.$obj drawstate.$obj dynload.$obj choose_folder.$obj capture.$obj
MT_OBJECTS = MTdisptchr.$obj MTenumfont.$obj MTenum_child_windows.$obj MTestream.$obj MTmsgboxpa.$obj \
		MTdiskspace.$obj MTdrawstate.$obj MTdynload.$obj MTchoose_folder.$obj MTcapture.$obj \
		MTwel_thr_init.$obj
IL_OBJECTS = ILdisptchr.$obj ILenumfont.$obj ILenum_child_windows.$obj ILestream.$obj ILmsgboxpa.$obj \
		ILdiskspace.$obj ILdrawstate.$obj ILdynload.$obj ILchoose_folder.$obj ILcapture.$obj


.c.$obj:
	$(CC) -c $(JCFLAGS) $<

all:: lib_dir $output_libraries clean

standard:: wel.lib ilwel.lib
mtstandard:: mtwel.lib

..$(DIR)spec:
	$(MKDIR_TARGET)

..$(DIR)spec$(DIR)$(ISE_C_COMPILER): ..$(DIR)spec
	$(MKDIR_TARGET)

..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM): ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)
	$(MKDIR_TARGET)

..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib: ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)
	$(MKDIR_TARGET)

..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)dll: ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)
	$(MKDIR_TARGET)

lib_dir: ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)dll

clean:
	$(RM) *.$obj
	$(RM) *.lib
	$(RM) *.dll
	$(RM) *.BAK
	$(RM) *.tds
	$(RM) *.exp

wel.lib: $(OBJECTS)
	$alib_line
	$(MV) $@ ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib$(DIR)$@

mtwel.lib: $(MT_OBJECTS)
	$alib_line
	$(MV) $@ ..$(DIR)spec$(DIR)$(ISE_C_COMPILER)$(DIR)$(ISE_PLATFORM)$(DIR)lib$(DIR)$@

ilwel.lib: $(IL_OBJECTS)
	$alib_line
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

MTdiskspace.$obj: diskspace.c
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

ILdiskspace.$obj: diskspace.c
	$(CC) $(JILCFLAGS) $(OUTPUT_CMD)$@ -c $?

ILdrawstate.$obj: drawstate.c
	$(CC) $(JILCFLAGS) $(OUTPUT_CMD)$@ -c $?

ILdynload.$obj: dynload.c
	$(CC) $(JILCFLAGS) $(OUTPUT_CMD)$@ -c $?

ILchoose_folder.$obj: choose_folder.c
	$(CC) $(JILCFLAGS) $(OUTPUT_CMD)$@ -c $?

ILcapture.$obj: capture.c
	$(CC) $(JILCFLAGS) $(OUTPUT_CMD)$@ -c $?
