TOP = ..\..\..
CC = $cc
JCFLAGS = $(CFLAGS) $ccflags $optimize
LN = copy
MV = \bin\mv
RM = del

.c.obj:
	$(RM) $@
	$(CC) -c $(JCFLAGS) $<

CFLAGS = /I$(TOP)\run-time /I$(TOP) /I$(TOP)\ipc\shared
DPFLAGS = /I$(TOP)

OBJECTS = argcargv.obj econsole.obj ..\..\..\ipc\shared\shword.obj

all:: econsole.lib

econsole.lib: $(OBJECTS)
	$(RM) $@
	$link_line

