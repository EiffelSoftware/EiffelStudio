TOP = ..\..
OUTDIR = .
INDIR = .
CC = $cc
RUN_TIME = $(TOP)\run-time 
CFLAGS = -I$(TOP) -I$(LIBDIR) -I$(RUN_TIME) -I$(TOP)\console -I$(LIBIDR)
JCFLAGS = $(CFLAGS) $ccflags $optimize
MAKE = make
MV = copy
RM = del

# Where shared archive is located (path and name)
LIBDIR = ..\shared
LIBIDR = $(TOP)\idrs

# Files used to build the ewb
SRC = ewb_proto.c eproto.c eif_in.c eif_out.c ewb_init.c ewb_dumped.c

# Derived object file names
OBJECTS = \
	ewb_dumped.$obj \
	ewb_proto.$obj \
	eproto.$obj \
	eif_in.$obj \
	eif_out.$obj \
	ewb_init.$obj

.c.$obj:
	$(CC) -c $(JCFLAGS) $<

all:: ewb.$lib

ewb.$lib: $(OBJECTS)
	$link_line
