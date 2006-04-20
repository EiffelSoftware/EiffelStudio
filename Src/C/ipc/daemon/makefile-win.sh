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
LIBIDRNAME = idrs.$obj
LIBIDRARCH = $(LIBIDR)\$(LIBIDRNAME)
LIBS = $(LIBIDRARCH) $(LIBARCH)

CFLAGS = -I$(TOP) -I$(LIBDIR) -I$(LIBRUN) -I$(LIBIDR)
LDFLAGS = /DEBUG /NOLOGO

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

$microsoftestudio.exe: $(LIBS) estudio.lmk
	link $(LDFLAGS) $(LIBS) -SUBSYSTEM:WINDOWS -OUT:$@ @estudio.lmk

estudio.res: estudio.rc
	$resource_compiler -r estudio.rc

estudio.lmk: $(OBJECTS) estudio.res
	echo $(OBJECTS) > estudio.lmk
	echo GDI32.LIB ADVAPI32.LIB USER32.LIB estudio.res >> estudio.lmk

$borlandestudio.exe: $(LIBS) estudio.lbk
	ilink32 @estudio.lbk

estudio.lbk: $(OBJECTS) estudio.res
	del estudio.lbk
	echo $compiler_path\lib\c0w32.$obj $(OBJECTS), \
	estudio.exe,, CW32 IMPORT32 $(LIBS),,estudio.res >> estudio.lbk

listen.$obj: ..\shared\select.h
