TOP = ..\..
OUTDIR = .
INDIR = .
CC = $cc
OUTPUT_CMD = $output_cmd
RUN_TIME = $(TOP)\run-time
CFLAGS = -I$(TOP) -I$(LIBDIR) -I$(RUN_TIME) -I$(RUN_TIME)\include -I$(TOP)\console -I$(LIBIDR)
JCFLAGS = $(CFLAGS) $ccflags $optimize
JMTCFLAGS = $(CFLAGS) $mtccflags $optimize
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

MT_OBJECTS = \
	MTewb_dumped.$obj \
	MTewb_proto.$obj \
	MTeproto.$obj \
	MTeif_in.$obj \
	MTeif_out.$obj \
	MTewb_init.$obj

.c.$obj:
	$(CC) -c $(JCFLAGS) $<

all:: $output_libraries

dll: standard
mtdll: mtstandard
standard: ewb.$lib
mtstandard: mtewb.$lib

ewb.$lib: $(OBJECTS)
	$link_line

mtewb.$lib: $(MT_OBJECTS)
	$link_mtline

MTewb_dumped.$obj: ewb_dumped.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $? 

MTewb_proto.$obj: ewb_proto.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $? 

MTewb_init.$obj: ewb_init.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $? 

MTeproto.$obj: eproto.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $? 

MTeif_in.$obj: eif_in.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $? 

MTeif_out.$obj: eif_out.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $? 


