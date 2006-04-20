TOP = ..\..
OUTDIR = .
INDIR = .
CC = $cc
OUTPUT_CMD = $output_cmd
RUN_TIME = $(TOP)\run-time
CFLAGS = -I$(TOP) -I$(LIBDIR) -I$(RUN_TIME) -I$(RUN_TIME)\include -I$(TOP)\console -I$(LIBIDR)
JCFLAGS = $(CFLAGS) $ccflags $optimize -DEIF_IPC
JMTCFLAGS = $(CFLAGS) $mtccflags $optimize -DEIF_IPC
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

MT_WOBJECTS = \
	MTwewb_dumped.$obj \
	MTwewb_proto.$obj \
	MTweproto.$obj \
	MTweif_in.$obj \
	MTweif_out.$obj \
	MTwewb_init.$obj

.c.$obj:
	$(CC) -c $(JCFLAGS) $<

all:: $output_libraries

dll: standard
mtdll: mtstandard
standard: ewb.$lib
mtstandard: mtewb.$lib mtwewb.$lib

ewb.$lib: $(OBJECTS)
	$link_line

mtewb.$lib: $(MT_OBJECTS)
	$link_line

mtwewb.$lib: $(MT_WOBJECTS)
	$link_line

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


MTwewb_dumped.$obj: ewb_dumped.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(OUTPUT_CMD)$@ -c $? 

MTwewb_proto.$obj: ewb_proto.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(OUTPUT_CMD)$@ -c $? 

MTwewb_init.$obj: ewb_init.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(OUTPUT_CMD)$@ -c $? 

MTweproto.$obj: eproto.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(OUTPUT_CMD)$@ -c $? 

MTweif_in.$obj: eif_in.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(OUTPUT_CMD)$@ -c $? 

MTweif_out.$obj: eif_out.c
	$(CC) $(JMTCFLAGS) -DWORKBENCH $(OUTPUT_CMD)$@ -c $? 


