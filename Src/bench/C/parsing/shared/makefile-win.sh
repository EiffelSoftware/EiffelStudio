CC = $cc
JCFLAGS = $(CFLAGS) $ccflags $optimize
MAKE = $make
MV = copy
RM = del

.c.obj:
	$(RM) $@
	$(CC) -c $(JCFLAGS) $<

OBJECTS = yacc.obj strsave.obj yacc_err.obj click.obj

RUN_TIME = ..\..\run-time
DPFLAGS = -I$(RUN_TIME) -I..\..
CFLAGS = $(DPFLAGS)

all:: parsing.lib

parsing.lib: $(OBJECTS)
	$(RM) $@
	$link_line

yacc.obj: ..\..\config.h
yacc.obj: ..\..\portable.h
yacc.obj: ..\..\run-time\cecil.h
yacc.obj: ..\..\run-time\copy.h
yacc.obj: ..\..\run-time\except.h
yacc.obj: ..\..\run-time\garcol.h
yacc.obj: ..\..\run-time\hector.h
yacc.obj: ..\..\run-time\local.h
yacc.obj: ..\..\run-time\macros.h
yacc.obj: ..\..\run-time\malloc.h
yacc.obj: ..\..\run-time\plug.h
yacc.obj: ..\..\run-time\size.h
yacc.obj: ..\..\run-time\struct.h
yacc.obj: ..\..\run-time\rtlimits.h
yacc.obj: typenode.h
yacc.obj: yacc.c
yacc.obj: yacc.h
strsave.obj: ..\..\run-time\rtlimits.h
strsave.obj: strsave.c
yacc_err.obj: ..\..\config.h
yacc_err.obj: ..\..\portable.h
yacc_err.obj: ..\..\run-time\cecil.h
yacc_err.obj: ..\..\run-time\copy.h
yacc_err.obj: ..\..\run-time\except.h
yacc_err.obj: ..\..\run-time\garcol.h
yacc_err.obj: ..\..\run-time\hector.h
yacc_err.obj: ..\..\run-time\local.h
yacc_err.obj: ..\..\run-time\macros.h
yacc_err.obj: ..\..\run-time\malloc.h
yacc_err.obj: ..\..\run-time\plug.h
yacc_err.obj: ..\..\run-time\size.h
yacc_err.obj: ..\..\run-time\struct.h
yacc_err.obj: ..\..\run-time\rtlimits.h
yacc_err.obj: typenode.h
yacc_err.obj: yacc.h
yacc_err.obj: yacc_err.c
click.obj: ..\..\config.h
click.obj: ..\..\portable.h
click.obj: ..\..\run-time\cecil.h
click.obj: ..\..\run-time\copy.h
click.obj: ..\..\run-time\except.h
click.obj: ..\..\run-time\garcol.h
click.obj: ..\..\run-time\hector.h
click.obj: ..\..\run-time\local.h
click.obj: ..\..\run-time\macros.h
click.obj: ..\..\run-time\malloc.h
click.obj: ..\..\run-time\plug.h
click.obj: ..\..\run-time\size.h
click.obj: ..\..\run-time\struct.h
click.obj: click.c
click.obj: ..\..\run-time\rtlimits.h
click.obj: typenode.h
click.obj: yacc.h
