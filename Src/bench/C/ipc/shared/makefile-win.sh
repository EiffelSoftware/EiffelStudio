CC=$cc
RM=del
TOP=..\..
LIBRUN = $(TOP)\run-time
LIBIDR = $(TOP)\idrs
DPFLAGS = -I$(TOP) -I$(LIBRUN) -I$(LIBIDR) -I.
CFLAGS = $(DPFLAGS) -DWORKBENCH
JCFLAGS = $(CFLAGS) $ccflags $optimize

OBJECTS = \
	com.obj \
	identify.obj \
	lock.obj \
	logfile.obj \
	network.obj \
	networku.obj \
	select.obj \
	shword.obj \
	stack.obj \
	stream.obj \
	system.obj \
	transfer.obj \
	rqst_idrs.obj \
	uu.obj

.c.obj:
	$(RM) $@
	$(CC) -c $(JCFLAGS) $<

all:: ipc.lib

ipc.lib: $(OBJECTS)
	$(RM) $@
	$link_line

com.obj: logfile.h
logfile.obj: logfile.h
network.obj: logfile.h
select.obj: logfile.h
transfer.obj: logfile.h
identify.obj: logfile.h
