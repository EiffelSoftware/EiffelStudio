TOP = ..\..
CC = $cc
JCFLAGS = $(CFLAGS) $ccflags $optimize -DWORKBENCH -DWIN32
MAKE = $make
MV = copy
RM = del

.c.obj:
	$(RM) $@
	$(CC) -c $(JCFLAGS) $<

# Derived library object file names
OBJECTS = \
	listen.obj \
	proto.obj \
	server.obj \
	$(LIBDIR)\$(LIBNAME)

# Where shared archive is located (path and name)
LIBDIR = ..\shared
LIBRUN = ..\..\run-time
LIBIDR = ..\..\idrs
LIBIDRNAME = idr.lib
LIBNAME = ipc.lib
LIBARCH = $(LIBDIR)\$(LIBNAME)
LIBIDRARCH = $(LIBIDR)\$(LIBIDRNAME)
CFLAGS = -I$(TOP) -I..\shared -I$(LIBRUN) -I$(LIBIDR)

all: network.lib

network.lib: $(OBJECTS) $(LIBDIR)\$(LIBNAME)
	$(RM) $@
	$link_line

