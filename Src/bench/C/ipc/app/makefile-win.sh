TOP = ..\..
OUTDIR = .
INDIR = .
CC = $cc
OUTPUT_CMD = $output_cmd
CFLAGS = -I$(TOP) -I..\shared -I$(LIBRUN) -I$(LIBIDR) -I$(LIBRUN)\include
JCFLAGS = $(CFLAGS) $ccflags $optimize -DWORKBENCH
JMTCFLAGS = $(CFLAGS) $mtccflags $optimize -DWORKBENCH
MAKE = $make
MV = copy
RM = del
# Where shared archive is located (path and name)
LIBDIR = ..\shared
LIBRUN = $(TOP)\run-time
LIBIDR = $(TOP)\idrs
LIBIDRNAME = idr.$lib
LIBNAME = ipc.$lib
LIBMTIDRNAME = mtidr.$lib
LIBMTNAME = mtipc.$lib

.c.$obj:
	$(CC) -c $(JCFLAGS) $<

# Derived library object file names
OBJECTS = \
	app_listen.$obj \
	app_proto.$obj \
	app_server.$obj \
	$(LIBDIR)\$(LIBNAME)

MT_OBJECTS = \
	MTapp_listen.$obj \
	MTapp_proto.$obj \
	MTapp_server.$obj \
	$(LIBDIR)\$(LIBMTNAME)

all:: $output_libraries

dll: standard
mtdll: mtstandard
standard: network.$lib
mtstandard: mtnetwork.$lib

network.$lib: $(OBJECTS) $(LIBDIR)\$(LIBNAME)
	$link_line

mtnetwork.$lib: $(MT_OBJECTS) $(LIBDIR)\$(LIBMTNAME)
	$link_mtline

MTapp_listen.$obj: app_listen.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $? 

MTapp_proto.$obj: app_proto.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $? 

MTapp_server.$obj: app_server.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $? 

