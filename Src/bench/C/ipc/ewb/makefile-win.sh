TOP = ..\..
CC = $cc
JCFLAGS = $(CFLAGS) $ccflags $optimize -DWIN32
MAKE = make
MV = copy
RM = del

.c.obj:
	$(RM) $@
	$(CC) -c $(JCFLAGS) $<

# Files used to build the ewb
SRC = proto.c eproto.c eif_in.c eif_out.c init.c dumped.c

# Derived object file names
OBJECTS = \
	dumped.obj \
	proto.obj \
	eproto.obj \
	eif_in.obj \
	eif_out.obj \
	init.obj

# Where shared archive is located (path and name)
LIBDIR = ..\shared
LIBIDR = ..\..\idrs

RUN_TIME = ..\..\run-time
CFLAGS = /I$(TOP) /I$(LIBDIR) /I$(RUN_TIME) /I$(LIBIDR)

all:: ewb.lib

ewb.lib: $(OBJECTS)
	$(RM) $@
	$link_line

