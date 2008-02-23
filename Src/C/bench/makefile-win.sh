TOP = ..
DIR = $dir_sep
OUTDIR = .$(DIR)LIB
INDIR = .$(DIR)OBJDIR
RTSRC = .
CC = $cc
LIB_EXE = $lib_exe
MAKE = $make
LINK32 = $link32
DLLFLAGS = $dllflags
OUTPUT_CMD = $output_cmd
CFLAGS = -I. -I$(TOP) -I$(TOP)$(DIR)run-time -I$(TOP)$(DIR)run-time$(DIR)include -I$(TOP)$(DIR)minilzo -I$(TOP)$(DIR)idrs
JCFLAGS = $(CFLAGS) $ccflags $optimize
JMTCFLAGS = $(CFLAGS) $mtccflags $optimize

.c.$obj:
	$(CC) -c $(JCFLAGS) $<

.c.exe:
	$(CC) $(JCFLAGS) $<

OBJECTS = pretrieve.$obj pstore.$obj \
			date.$obj offset.$obj byte.$obj minilzo.$obj

WOBJECTS = pretrieve.$obj wpstore.$obj \
			date.$obj offset.$obj byte.$obj minilzo.$obj

MT_OBJECTS = MTpretrieve.$obj MTpstore.$obj \
			MTdate.$obj MToffset.$obj MTbyte.$obj MTminilzo.$obj

MT_WOBJECTS = MTwpretrieve.$obj MTwpstore.$obj \
			MTdate.$obj MToffset.$obj MTbyte.$obj MTminilzo.$obj

all:: $output_libraries

dll: standard
mtdll: mtstandard
standard: compiler.$lib wcompiler.$lib meltdump.exe bytedump.exe
mtstandard: mtcompiler.$lib mtwcompiler.$lib meltdump.exe bytedump.exe

meltdump.exe: ..$(DIR)run-time$(DIR)eif_interp.h
bytedump.exe: ..$(DIR)run-time$(DIR)eif_interp.h

compiler.$lib: $(OBJECTS)
	$alib_line

wcompiler.$lib: $(WOBJECTS)
	$alib_line

mtcompiler.$lib: $(MT_OBJECTS)
	$alib_line

mtwcompiler.$lib: $(MT_WOBJECTS)
	$alib_line

wpstore.$obj: pstore.c
	$(CC) $(JCFLAGS) -DWORKBENCH $(OUTPUT_CMD)$@ -c $?

MTpretrieve.$obj: pretrieve.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $? 

MTdate.$obj: date.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $? 

MToffset.$obj: offset.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $? 

MTbyte.$obj: byte.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $? 

MTpstore.$obj: pstore.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $? 

MTwpstore.$obj: pstore.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(OUTPUT_CMD)$@ -c $? 

MTwpretrieve.$obj: pretrieve.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(OUTPUT_CMD)$@ -c $? 

MTminilzo.$obj: minilzo.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $? 


