TOP = ..\..
CC = $cc
JCFLAGS = $(CFLAGS) $ccflags $optimize
MV = copy
RM = del

# Where shared archive is located (path and name)
LIBDIR = ..\shared
LIBNAME = ipc.$lib
LIBARCH = $(LIBDIR)\$(LIBNAME)
LIBRUN = $(TOP)\run-time -I$(TOP)\run-time\include
LIBIDR = $(TOP)\idrs
LIBIDRNAME = idr.$lib
LIBIDRARCH = $(LIBIDR)\$(LIBIDRNAME)
LIBS = $(LIBIDRARCH) $(LIBARCH)

CFLAGS = -I$(TOP) -I$(LIBDIR) -I$(LIBRUN) -I$(LIBIDR)
LDFLAGS = /DEBUG /DEBUGTYPE:BOTH /NOLOGO

# Derived object file names
OBJECTS = \
	child.$obj \
	listen.$obj \
	main.$obj \
	proto.$obj \
	env.$obj

.c.$obj:
	$(CC) -c $(JCFLAGS) $<

all:: estudio.exe

$microsoft-estudio.exe: $(LIBS) estudio.lmk
	link $(LDFLAGS) $(LIBS) -OUT:$@ @estudio.lmk

estudio.res: estudio.rc
	$resource_compiler -r estudio.rc

estudio.lmk: $(OBJECTS) estudio.res
	del estudio.lmk
	echo $(OBJECTS) > estudio.lmk
	echo GDI32.LIB ADVAPI32.LIB USER32.LIB estudio.res >> estudio.lmk

$borland-estudio.exe: $(LIBS) estudio.lbk
	ilink32 @estudio.lbk

estudio.lbk: $(OBJECTS) estudio.res
	del estudio.lbk
	echo $compiler_path\lib\c0w32.$obj $(OBJECTS), \
	estudio.exe,, CW32 IMPORT32 ..\shared\ipc.lib \
	$(TOP)\idrs\idr.lib,,estudio.res >> estudio.lbk

$watcom-estudio.exe: $(LIBS) estudio.lwk
	wlink @estudio.lwk
	wrc /fe=estudio.exe estudio

estudio.lwk: $(OBJECTS)
	echo SYSTEM nt_win > estudio.lwk
	echo OPTION CASEEXACT >> estudio.lwk
	echo NAME estudio.exw >> estudio.lwk
	for %i in ($(OBJECTS)) do echo FILE %i >> estudio.lwk
	echo LIB ..\shared\ipc.lwb >> estudio.lwk
	echo LIB $(TOP)\idrs\idr.lwb >> estudio.lwk

listen.$obj: ..\shared\select.h
