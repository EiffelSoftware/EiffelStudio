TOP = ..\..
CC = $cc
JCFLAGS = $(CFLAGS) $ccflags $optimize -DWIN32
MV = copy
RM = del

.c.obj:
	$(RM) $@
	$(CC) -c $(JCFLAGS) $<

# Derived object file names
OBJECTS = \
	child.obj \
	listen.obj \
	main.obj \
	proto.obj

# Where shared archive is located (path and name)
LIBDIR = ..\shared
LIBNAME = ipc.lib
LIBARCH = $(LIBDIR)\$(LIBNAME)
LIBRUN = ..\..\run-time
LIBIDR = ..\..\idrs
LIBIDRNAME = idr.lib
LIBIDRARCH = $(LIBIDR)\$(LIBIDRNAME)
LIBS = $(LIBIDRARCH) $(LIBARCH)

CFLAGS = -I$(TOP) -I$(LIBDIR) -I$(LIBRUN) -I$(LIBIDR)
LDFLAGS =

all:: ebench.exe

$microsoft-ebench.exe: $(LIBS) ebench.lmk
	$(RM) $@
	link $(LDFLAGS) $(LIBS) -OUT:$@ @ebench.lmk

ebench.res: ebench.rc
	rc /r ebench.rc

ebench.lmk: $(OBJECTS) ebench.res
	del ebench.lmk
	echo $(OBJECTS) > ebench.lmk
	echo GDI32.LIB ADVAPI32.LIB USER32.LIB ebench.res >> ebench.lmk

$borland-ebench.exe: $(LIBS) ebench.lbk
	$(RM) $@
	tlink32 @ebench.lbk

ebench.lbk: $(OBJECTS)
	echo -m -n c:\bc45\lib\c0x32.obj + > ebench.lbk
	&echo $** + >> ebench.lbk
	echo , ebench.exb,, IMPORT32.LIB+CW32.LIB+>> ebench.lbk
	echo ..\shared\ipc.lbb + >> ebench.lbk
	echo ..\..\idrs\idr.lbb,,ebench.res >> ebench.lbk

$watcom-ebench.exe: $(LIBS) ebench.lwk
	$(RM) $@
	wlink @ebench.lwk
	wrc /fe=ebench.exe ebench

ebench.lwk: $(OBJECTS)
	echo SYSTEM nt_win > ebench.lwk
	echo OPTION CASEEXACT >> ebench.lwk
	echo NAME ebench.exw >> ebench.lwk
	for %i in ($(OBJECTS)) do echo FILE %i >> ebench.lwk
	echo LIB ..\shared\ipc.lwb >> ebench.lwk
	echo LIB ..\..\idrs\idr.lwb >> ebench.lwk

listen.obj: ..\shared\select.h
