TOP = ..\..
OUTDIR = .
INDIR = .
CC = $cc
JCFLAGS = $(CFLAGS) $ccflags $optimize
MAKE = $make
MV = copy
RM = $del
DPFLAGS = -I$(TOP) -I$(TOP)\run-time
CFLAGS = $(DPFLAGS)

OBJECTS = yacc.$obj strsave.$obj yacc_err.$obj click.$obj

.c.$obj:
	$(CC) -c $(JCFLAGS) $<

all:: parsing.$lib

parsing.$lib: $(OBJECTS)
	$link_line

yacc.$obj: $(TOP)\eif_config.h
yacc.$obj: $(TOP)\eif_portable.h
yacc.$obj: $(TOP)\run-time\eif_cecil.h
yacc.$obj: $(TOP)\run-time\eif_copy.h
yacc.$obj: $(TOP)\run-time\eif_except.h
yacc.$obj: $(TOP)\run-time\eif_garcol.h
yacc.$obj: $(TOP)\run-time\eif_hector.h
yacc.$obj: $(TOP)\run-time\eif_local.h
yacc.$obj: $(TOP)\run-time\eif_macros.h
yacc.$obj: $(TOP)\run-time\eif_malloc.h
yacc.$obj: $(TOP)\run-time\eif_plug.h
yacc.$obj: $(TOP)\run-time\eif_size.h
yacc.$obj: $(TOP)\run-time\eif_struct.h
yacc.$obj: $(TOP)\run-time\eif_rtlimits.h
yacc.$obj: typenode.h
yacc.$obj: yacc.c
yacc.$obj: yacc.h
strsave.$obj: $(TOP)\run-time\eif_rtlimits.h
strsave.$obj: strsave.c
yacc_err.$obj: $(TOP)\eif_config.h
yacc_err.$obj: $(TOP)\eif_portable.h
yacc_err.$obj: $(TOP)\run-time\eif_cecil.h
yacc_err.$obj: $(TOP)\run-time\eif_copy.h
yacc_err.$obj: $(TOP)\run-time\eif_except.h
yacc_err.$obj: $(TOP)\run-time\eif_garcol.h
yacc_err.$obj: $(TOP)\run-time\eif_hector.h
yacc_err.$obj: $(TOP)\run-time\eif_local.h
yacc_err.$obj: $(TOP)\run-time\eif_macros.h
yacc_err.$obj: $(TOP)\run-time\eif_malloc.h
yacc_err.$obj: $(TOP)\run-time\eif_plug.h
yacc_err.$obj: $(TOP)\run-time\eif_size.h
yacc_err.$obj: $(TOP)\run-time\eif_struct.h
yacc_err.$obj: $(TOP)\run-time\eif_rtlimits.h
yacc_err.$obj: typenode.h
yacc_err.$obj: yacc.h
yacc_err.$obj: yacc_error_message.h
yacc_err.$obj: yacc_err.c
click.$obj: $(TOP)\eif_config.h
click.$obj: $(TOP)\eif_portable.h
click.$obj: $(TOP)\run-time\eif_cecil.h
click.$obj: $(TOP)\run-time\eif_copy.h
click.$obj: $(TOP)\run-time\eif_except.h
click.$obj: $(TOP)\run-time\eif_garcol.h
click.$obj: $(TOP)\run-time\eif_hector.h
click.$obj: $(TOP)\run-time\eif_local.h
click.$obj: $(TOP)\run-time\eif_macros.h
click.$obj: $(TOP)\run-time\eif_malloc.h
click.$obj: $(TOP)\run-time\eif_plug.h
click.$obj: $(TOP)\run-time\eif_size.h
click.$obj: $(TOP)\run-time\eif_struct.h
click.$obj: click.c
click.$obj: $(TOP)\run-time\eif_rtlimits.h
click.$obj: typenode.h
click.$obj: yacc.h
