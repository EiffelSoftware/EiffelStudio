CC = $cc
JCFLAGS = $(CFLAGS) $ccflags $optimize
MAKE = $make
MV = copy
RM = del

.c.obj:
	$(RM) $@
	$(CC) -c $(JCFLAGS) $<

OBJECTS = lace_y.obj keyword.obj lac_err.obj lace_c.obj lace_l.obj eif_l.obj

TOP = ..\SHARED
RUN_TIME = ..\..\run-time
DPFLAGS = -I$(TOP) -I$(RUN_TIME) -I..\..
CFLAGS = $(DPFLAGS)

all:: lace.lib

lace.lib: $(OBJECTS)
	$(RM) $@
	$link_line

lace_y.c: lace_y.cwn
	copy lace_y.cwn lace_y.c

lace_y.h: lace_y.hwn
	copy lace_y.hwn lace_y.h

lace_c.obj: ..\..\config.h
lace_y.obj: lace_y.h
lac_err.obj: ..\shared\yacc.h
