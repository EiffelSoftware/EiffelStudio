TOP = ..$(DIR)..
DIR = $dir_sep
OUTDIR = .
INDIR = .
CC = $cc
OUTPUT_CMD = $output_cmd
CFLAGS = -I$(TOP) -I..$(DIR)shared -I$(LIBRUN) -I$(LIBIDR) -I$(LIBRUN)$(DIR)include
JCFLAGS = $(CFLAGS) $ccflags $optimize -DWORKBENCH -DEIF_IPC
JMTCFLAGS = $(CFLAGS) $mtccflags $optimize -DWORKBENCH -DEIF_IPC
MAKE = $make
# Where shared archive is located (path and name)
LIBDIR = ..$(DIR)shared
LIBRUN = $(TOP)$(DIR)run-time
LIBIDR = $(TOP)$(DIR)idrs
LIBNAME = ipc.$lib
LIBMTNAME = mtipc.$lib

.c.$obj:
	$(CC) -c $(JCFLAGS) $<

# Derived library object file names
OBJECTS = \
	app_listen.$obj \
	app_proto.$obj \
	app_server.$obj \
	app_transfer.$obj \
	$(LIBDIR)$(DIR)$(LIBNAME)

MT_OBJECTS = \
	MTapp_listen.$obj \
	MTapp_proto.$obj \
	MTapp_server.$obj \
	MTapp_transfer.$obj \
	$(LIBDIR)$(DIR)$(LIBMTNAME)

all:: $output_libraries

dll: standard
mtdll: mtstandard
standard: network.$lib
mtstandard: mtnetwork.$lib

network.$lib: $(OBJECTS) $(LIBDIR)$(DIR)$(LIBNAME)
	$link_line

mtnetwork.$lib: $(MT_OBJECTS) $(LIBDIR)$(DIR)$(LIBMTNAME)
	$link_line

MTapp_listen.$obj: app_listen.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $? 

MTapp_proto.$obj: app_proto.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $? 

MTapp_server.$obj: app_server.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $? 

MTapp_transfer.$obj: app_transfer.c
	$(CC) $(JMTCFLAGS) $(OUTPUT_CMD)$@ -c $? 

