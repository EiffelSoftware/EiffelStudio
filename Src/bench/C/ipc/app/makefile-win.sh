TOP = ..\..
OUTDIR = .
INDIR = .
CC = $cc
JCFLAGS = $(CFLAGS) $ccflags $optimize -DWORKBENCH
MAKE = $make
MV = copy
RM = del

.c.$obj:
	$(CC) -c $(JCFLAGS) $<

# Derived library object file names
OBJECTS = \
	listen.$obj \
	proto.$obj \
	server.$obj \
	$(LIBDIR)\$(LIBNAME)

# Where shared archive is located (path and name)
LIBDIR = ..\shared
LIBRUN = $(TOP)\run-time
LIBIDR = $(TOP)\idrs
LIBIDRNAME = idr.lib
LIBNAME = ipc.lib
LIBARCH = $(LIBDIR)\$(LIBNAME)
LIBIDRARCH = $(LIBIDR)\$(LIBIDRNAME)
CFLAGS = -I$(TOP) -I..\shared -I$(LIBRUN) -I$(LIBIDR)

all: network.lib

network.lib: $(OBJECTS) $(LIBDIR)\$(LIBNAME)
	$link_line

