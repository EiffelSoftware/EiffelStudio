TOP = ..\..
CC = $cc
JCFLAGS = $(CFLAGS) $ccflags $optimize
MV = copy
RM = $del

# Where shared archive is located (path and name)
LIBDIR = ..\shared
LIBNAME = ipc.$lib
LIBARCH = $(LIBDIR)\$(LIBNAME)
LIBRUN = $(TOP)\run-time
LIBIDR = $(TOP)\idrs
LIBIDRNAME = idr.$lib
LIBIDRARCH = $(LIBIDR)\$(LIBIDRNAME)
LIBS = $(LIBIDRARCH) $(LIBARCH)

CFLAGS = -I$(TOP) -I$(LIBDIR) -I$(LIBRUN) -I$(LIBIDR)
LDFLAGS =

# Derived object file names
OBJECTS = \
	child.$obj \
	listen.$obj \
	main.$obj \
	proto.$obj \
	env.$obj

.c.$obj:
	$(CC) -c $(JCFLAGS) $<

all:: ebench.exe

$microsoft-ebench.exe: $(LIBS) ebench.lmk
	link $(LDFLAGS) $(LIBS) -OUT:$@ @ebench.lmk

ebench.res: ebench.rc
	rc -r ebench.rc

ebench.lmk: $(OBJECTS) ebench.res
	del ebench.lmk
	echo $(OBJECTS) > ebench.lmk
	echo GDI32.LIB ADVAPI32.LIB USER32.LIB ebench.res >> ebench.lmk

$borland-ebench.exe: $(LIBS) ebench.lbk
	tlink32 @ebench.lbk

ebench.lbk: $(OBJECTS)
	echo -m -n c:\bc45\lib\c0x32.$obj + >> ebench.lbk
	&echo $** + >> ebench.lbk
	echo , ebench.exb,, IMPORT32.LIB+CW32.LIB+>> ebench.lbk
	echo ..\shared\ipc.lbb + >> ebench.lbk
	echo $(TOP)\idrs\idr.lbb,,ebench.res >> ebench.lbk

$watcom-ebench.exe: $(LIBS) ebench.lwk
	wlink @ebench.lwk
	wrc /fe=ebench.exe ebench

ebench.lwk: $(OBJECTS)
	echo SYSTEM nt_win > ebench.lwk
	echo OPTION CASEEXACT >> ebench.lwk
	echo NAME ebench.exw >> ebench.lwk
	for %i in ($(OBJECTS)) do echo FILE %i >> ebench.lwk
	echo LIB ..\shared\ipc.lwb >> ebench.lwk
	echo LIB $(TOP)\idrs\idr.lwb >> ebench.lwk

listen.$obj: ..\shared\select.h
