TOP = ..
OUTDIR = .\LIB
INDIR = .\OBJDIR
RTSRC = .
CC = $cc
CTAGS = ctags
LIB_EXE = $lib_exe
LN = copy
MAKE = $make
MV = move
RM = del
LINK32 = $link32
DLLFLAGS = $dllflags
OUTPUT_CMD = $output_cmd
CFLAGS = -I. -I$(TOP) -I$(TOP)\run-time -I$(TOP)\run-time\include -I$(EIFFEL_SRC)\C\minilzo
JCFLAGS = $(CFLAGS) $ccflags $optimize
JMTCFLAGS = $(CFLAGS) $mtccflags $optimize

.c.$obj:
	$(CC) -c $(JCFLAGS) $<

.c.exe:
	$(CC) $(JCFLAGS) $<

OBJECTS = pretrieve.$obj pstore.$obj \
			date.$obj offset.$obj byte.$obj encode.$obj

WOBJECTS = pretrieve.$obj wpstore.$obj \
			date.$obj offset.$obj byte.$obj encode.$obj

MT_OBJECTS = MTpretrieve.$obj MTpstore.$obj \
			MTdate.$obj MToffset.$obj MTbyte.$obj MTencode.$obj

MT_WOBJECTS = MTpretrieve.$obj MTwpstore.$obj \
			MTdate.$obj MToffset.$obj MTbyte.$obj MTencode.$obj

all:: $output_libraries

dll: standard
mtdll: mtstandard
standard: compiler.$lib wcompiler.$lib meltdump.exe bytedump.exe
mtstandard: mtcompiler.$lib mtwcompiler.$lib meltdump.exe bytedump.exe

meltdump.exe: ..\run-time\eif_interp.h
bytedump.exe: ..\run-time\eif_interp.h

compiler.$lib: $(OBJECTS)
	$link_line

wcompiler.$lib: $(WOBJECTS)
	$link_wline

mtcompiler.$lib: $(MT_OBJECTS)
	$link_mtline

mtwcompiler.$lib: $(MT_WOBJECTS)
	$link_mtwline

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

MTencode.$obj: encode.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $? 

MTpstore.$obj: pstore.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $? 

MTwpstore.$obj: pstore.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(OUTPUT_CMD)$@ -c $? 


