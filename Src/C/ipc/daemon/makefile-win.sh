TOP = ..$(DIR)..
DIR = $dir_sep
CC = $cc
JCFLAGS = $(CFLAGS) $ccflags $optimize
MV = copy
RM = del

# Where shared archive is located (path and name)
LIBDIR = ..$(DIR)shared
LIBNAME = ipc.$lib
LIBARCH = $(LIBDIR)$(DIR)$(LIBNAME)
LIBRUN = $(TOP)$(DIR)run-time -I$(TOP)$(DIR)run-time$(DIR)include
LIBIDR = $(TOP)$(DIR)idrs
LIBIDRNAME = idrs.$obj
LIBIDRARCH = $(LIBIDR)$(DIR)$(LIBIDRNAME)
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

$mingwecdbgd.exe: $(LIBS) $(DBGOBJECTS)
	$(CC) -mwindows -o $@ $(DBGOBJECTS) $(LIBS) -lgdi32 -ladvapi32 -luser32

$microsoftecdbgd.exe: $(LIBS) ecdbgd.lmk
	link $(LDFLAGS) $(LIBS) -SUBSYSTEM:WINDOWS -OUT:$@ @ecdbgd.lmk

ecdbgd.lmk: $(DBGOBJECTS)
	echo $(DBGOBJECTS) > ecdbgd.lmk
	echo GDI32.LIB ADVAPI32.LIB USER32.LIB >> ecdbgd.lmk

$borlandecdbgd.exe: $(LIBS)  $(DBGOBJECTS)
	$compiler_path$(DIR)bin$(DIR)ilink32 $compiler_path$(DIR)lib$(DIR)c0w32.$obj $(DBGOBJECTS), \
	ecdbgd.exe,, CW32 IMPORT32 $(LIBS),, 

listen.$obj: ..$(DIR)shared$(DIR)select.h
