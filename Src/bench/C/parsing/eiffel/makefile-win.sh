TOP = ..\..
OUTDIR = .
INDIR = .
CC = $cc
JCFLAGS = $ccflags $optimize $(CFLAGS)
LN = copy
MAKE = nmake
MV = copy
RM = $del

.c.$obj:
	$(CC) -c $(JCFLAGS) $<

RUN_TIME = $(TOP)\run-time
SHARED_CLIB = ..\shared
CFLAGS = -I$(SHARED_CLIB) -I$(RUN_TIME) -I$(TOP)

OBJECTS = eiffel_c.$obj eif_err.$obj encode.$obj pretrieve.$obj date.$obj \
	keyword.$obj byte.$obj offset.$obj parser.$obj lexic.$obj infix.$obj \
	prefix.$obj pstore.$obj

WOBJECTS = eiffel_c.$obj eif_err.$obj encode.$obj pretrieve.$obj date.$obj \
	keyword.$obj byte.$obj offset.$obj parser.$obj lexic.$obj infix.$obj \
	prefix.$obj wpstore.$obj

all:: eiffel.$lib

eiffel.$lib: $(OBJECTS)
	$link_line

all:: weiffel.$lib

weiffel.$lib: $(WOBJECTS)
	$link_wline

parser.c: parser.cwn
	copy parser.hwn parser.h
	copy parser.cwn parser.c

wpstore.c: pstore.c
	copy pstore.c wpstore.c

wpstore.$obj: wpstore.c
	$(CC) -c -DWORKBENCH $(JCFLAGS) wpstore.c

parser.h: parser.c

lexic.$obj: parser.h

keyword.$obj: parser.h
eif_err.$obj: parser.h

eiffel_c.$obj: eiffel_c.c
eiffel_c.$obj: eiffel_c.h
eif_err.$obj: eif_err.c
encode.$obj: encode.c
pretrieve.$obj: pretrieve.c
date.$obj: date.c
keyword.$obj: keyword.c
byte.$obj: byte.c
offset.$obj: offset.c
parser.$obj: eiffel_c.h
parser.$obj: parser.c
infix.$obj: infix.c
prefix.$obj: prefix.c
pstore.$obj: pstore.c
eiffel_c.$obj: eiffel_c.c
eiffel_c.$obj: eiffel_c.h
eif_err.$obj: eif_err.c
encode.$obj: encode.c
pretrieve.$obj: pretrieve.c
date.$obj: date.c
keyword.$obj: keyword.c
byte.$obj: byte.c
offset.$obj: offset.c
parser.$obj: eiffel_c.h
parser.$obj: parser.y
infix.$obj: infix.c
prefix.$obj: prefix.c
pstore.$obj: pstore.c
lexic.$obj: lexic.c
parser.$obj: eiffel_c.h
parser.$obj: parser.c

