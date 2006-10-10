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
LDFLAGS = /NOLOGO

# Derived object file names

DBGOBJECTS = \
	child.$obj \
	listen.$obj \
	ecdbgd.$obj \
	proto.$obj \
	env.$obj

.c.$obj:
	$(CC) -c $(JCFLAGS) $<

all:: ecdbgd.exe

$microsoftecdbgd.exe: $(LIBS) ecdbgd.lmk
	link $(LDFLAGS) $(LIBS) -SUBSYSTEM:WINDOWS -OUT:$@ @ecdbgd.lmk

ecdbgd.lmk: $(DBGOBJECTS)
	echo $(DBGOBJECTS) > ecdbgd.lmk
	echo GDI32.LIB ADVAPI32.LIB USER32.LIB >> ecdbgd.lmk

$borlandecdbgd.exe: $(LIBS) ecdbgd.lbk
	ilink32 @ecdbgd.lbk

ecdbgd.lbk: $(DBGOBJECTS)
	del ecdbgd.lbk
	echo $compiler_path\lib\c0w32.$obj $(DBGOBJECTS), \
	ecdbgd.exe,, CW32 IMPORT32 $(LIBS),, >> ecdbgd.lbk

listen.$obj: ..\shared\select.h
