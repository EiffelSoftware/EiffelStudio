TOP=..\..
OUTDIR= .
INDIR= .
CC=$cc
RM=del
LIBRUN = $(TOP)\run-time
LIBIDR = $(TOP)\idrs
DPFLAGS = -I$(TOP) -I$(LIBRUN) -I$(LIBIDR) -I.
CFLAGS = $(DPFLAGS) -DWORKBENCH
JCFLAGS = $(CFLAGS) $ccflags $optimize

OBJECTS = \
	com.$obj \
	identify.$obj \
	lock.$obj \
	logfile.$obj \
	network.$obj \
	networku.$obj \
	select.$obj \
	shword.$obj \
	stack.$obj \
	stream.$obj \
	system.$obj \
	transfer.$obj \
	rqst_idrs.$obj \
	uu.$obj

.c.$obj:
	$(CC) -c $(JCFLAGS) $<

all:: ipc.lib

ipc.lib: $(OBJECTS)
	$link_line

com.$obj: eif_logfile.h
logfile.$obj: eif_logfile.h
network.$obj: eif_logfile.h
select.$obj: eif_logfile.h
transfer.$obj: eif_logfile.h
identify.$obj: eif_logfile.h
