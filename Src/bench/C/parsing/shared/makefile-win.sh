TOP = ..\..
CC = $cc
JCFLAGS = $(CFLAGS) $ccflags $optimize
MAKE = $make
MV = copy
RM = del
DPFLAGS = -I$(TOP) -I$(TOP)\run-time
CFLAGS = $(DPFLAGS)

OBJECTS = yacc.obj strsave.obj yacc_err.obj click.obj

.c.obj:
	$(RM) $@
	$(CC) -c $(JCFLAGS) $<

all:: parsing.lib

parsing.lib: $(OBJECTS)
	$(RM) $@
	$link_line

yacc.obj: $(TOP)\config.h
yacc.obj: $(TOP)\portable.h
yacc.obj: $(TOP)\run-time\cecil.h
yacc.obj: $(TOP)\run-time\copy.h
yacc.obj: $(TOP)\run-time\except.h
yacc.obj: $(TOP)\run-time\garcol.h
yacc.obj: $(TOP)\run-time\hector.h
yacc.obj: $(TOP)\run-time\local.h
yacc.obj: $(TOP)\run-time\macros.h
yacc.obj: $(TOP)\run-time\malloc.h
yacc.obj: $(TOP)\run-time\plug.h
yacc.obj: $(TOP)\run-time\size.h
yacc.obj: $(TOP)\run-time\struct.h
yacc.obj: $(TOP)\run-time\rtlimits.h
yacc.obj: typenode.h
yacc.obj: yacc.c
yacc.obj: yacc.h
strsave.obj: $(TOP)\run-time\rtlimits.h
strsave.obj: strsave.c
yacc_err.obj: $(TOP)\config.h
yacc_err.obj: $(TOP)\portable.h
yacc_err.obj: $(TOP)\run-time\cecil.h
yacc_err.obj: $(TOP)\run-time\copy.h
yacc_err.obj: $(TOP)\run-time\except.h
yacc_err.obj: $(TOP)\run-time\garcol.h
yacc_err.obj: $(TOP)\run-time\hector.h
yacc_err.obj: $(TOP)\run-time\local.h
yacc_err.obj: $(TOP)\run-time\macros.h
yacc_err.obj: $(TOP)\run-time\malloc.h
yacc_err.obj: $(TOP)\run-time\plug.h
yacc_err.obj: $(TOP)\run-time\size.h
yacc_err.obj: $(TOP)\run-time\struct.h
yacc_err.obj: $(TOP)\run-time\rtlimits.h
yacc_err.obj: typenode.h
yacc_err.obj: yacc.h
yacc_err.obj: yacc_err.c
click.obj: $(TOP)\config.h
click.obj: $(TOP)\portable.h
click.obj: $(TOP)\run-time\cecil.h
click.obj: $(TOP)\run-time\copy.h
click.obj: $(TOP)\run-time\except.h
click.obj: $(TOP)\run-time\garcol.h
click.obj: $(TOP)\run-time\hector.h
click.obj: $(TOP)\run-time\local.h
click.obj: $(TOP)\run-time\macros.h
click.obj: $(TOP)\run-time\malloc.h
click.obj: $(TOP)\run-time\plug.h
click.obj: $(TOP)\run-time\size.h
click.obj: $(TOP)\run-time\struct.h
click.obj: click.c
click.obj: $(TOP)\run-time\rtlimits.h
click.obj: typenode.h
click.obj: yacc.h
