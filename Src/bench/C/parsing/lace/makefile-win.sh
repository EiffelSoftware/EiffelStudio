TOP = ..\..
OUTDIR = .
INDIR = .
CC = $cc
JCFLAGS = $(CFLAGS) $ccflags $optimize
DPFLAGS = -I$(TOP) -I$(TOP)\run-time -I..\shared
CFLAGS = $(DPFLAGS)
MAKE = $make
MV = copy
RM = $del

OBJECTS = lace_y.$obj keyword.$obj lac_err.$obj lace_c.$obj lace_l.$obj eif_l.$obj

.c.$obj:
	$(CC) -c $(JCFLAGS) $<

all:: lace.$lib

lace.$lib: $(OBJECTS)
	$link_line

lace_y.c: lace_y.cwn
	copy lace_y.cwn lace_y.c

lace_y.h: lace_y.hwn
	copy lace_y.hwn lace_y.h

lace_c.$obj: $(TOP)\eif_config.h
lace_y.$obj: lace_y.h
lac_err.$obj: ..\shared\yacc.h
