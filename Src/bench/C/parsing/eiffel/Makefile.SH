: Makefile.SH generated from Jmake.tmpl and Jmakefile [jmake 2.8 PL13]
: $X-Id: Jmake.tmpl,v 2.8.1.2 91/11/18 13:22:54 ram Exp Locker: ram $

case $CONFIG in
'')
	if test ! -f config.sh; then
		ln ../config.sh . || \
		ln ../../config.sh . || \
		ln ../../../config.sh . || \
		ln ../../../../config.sh . || \
		(echo "Can't find config.sh."; exit 1)
	fi 2>/dev/null
	. ./config.sh
	;;
esac
case "$0" in
*/*) cd `expr X$0 : 'X\(.*\)/'` ;;
esac
CURRENT=parsing/eiffel
DIR=`echo $CURRENT/ | sed -e 's/\.\///g'`
echo "Extracting ${DIR}Makefile (with variable substitutions)"
DATE=`date`
$spitshell >Makefile <<!GROK!THIS!
########################################################################
# Makefile generated from Makefile.SH on $DATE

SHELL = /bin/sh
JMAKE = jmake
TOP = ../..
CURRENT = $CURRENT
DIR = $DIR

########################################################################
# Parameters set by Configure -- edit config.sh if changes are needed

AR = ar rc
CC = $cc
CTAGS = ctags
JCFLAGS = \$(CFLAGS) $optimize $ccflags $large
JLFLAGS = \$(LFLAGS) $lexflags -Sflex.skl
JYFLAGS = \$(YFLAGS) $yaccflags
LEX = $lex
LN = $ln
MAKE = make
MKDEP = $mkdep \$(DPFLAGS) --
MV = $mv
RANLIB = $ranlib
RM = $rm -f
SED = $sed
YACC = $yacc

########################################################################
# Automatically generated parameters -- do not edit

SOURCES =  \$(LSRCS) \$(LSRCS) parser.y
OBJECTS =  \$(OBJS) \$(WOBJS) lexic.o parser.o

########################################################################
# New suffixes and associated building rules -- edit with care

.SUFFIXES: .l .y

.c.o:
	\$(RM) \$@
	\$(CC) -c \$(JCFLAGS) \$<

.l.c:
	\$(LEX) \$(JLFLAGS) \$<
	\$(SED) -e 's/^# define YYLMAX [0-9][0-9]*/# define YYLMAX BUFSIZ/g' < lex.yy.c > \$@
	\$(RM) lex.yy.c

.y.c:
	\$(YACC) \$(JYFLAGS) \$<
	\$(MV) y.tab.c \$@

!GROK!THIS!
$spitshell >>Makefile <<'!NO!SUBS!'

########################################################################
# Jmake rules for building libraries, programs, scripts, and data files
# $X-Id: Jmake.rules,v 2.8.1.4 91/11/18 13:19:07 ram Exp Locker: ram $

########################################################################
# Force 'make depend' to be performed first -- do not edit

.FORCE_DEPEND::

all:: .FORCE_DEPEND

########################################################################
# Start of Jmakefile

RUN_TIME = ../../run-time
SHARED_CLIB = ../shared
DPFLAGS = -I$(SHARED_CLIB) -I$(RUN_TIME) -I$(TOP)
CFLAGS = $(DPFLAGS)
YFLAGS = -d

SRCS = eiffel_c.c eif_err.c encode.c pretrieve.c date.c keyword.c \
	byte.c offset.c parser.y lexic.c infix.c prefix.c

SMODE = pstore.c

LSRCS = $(SRCS) $(SMODE)

OBJS = \
	eiffel_c.o \
	eif_err.o \
	encode.o \
	pretrieve.o \
	date.o \
	keyword.o \
	byte.o \
	offset.o \
	parser.o \
	lexic.o \
	infix.o \
	prefix.o \
	pstore.o 

WOBJS = \
	eiffel_c.o \
	eif_err.o \
	encode.o \
	pretrieve.o \
	date.o \
	keyword.o \
	byte.o \
	offset.o \
	parser.o \
	lexic.o \
	infix.o \
	prefix.o \
	wpstore.o 

wpstore.c: pstore.c
	$(RM) wpstore.c
	$(LN) pstore.c wpstore.c
remove::
	$(RM) wpstore.c


wpstore.o: wpstore.c
	$(CC) -c $(JCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c


local_clean:: remove

all:: libeiffel.a

local_realclean::
	$(RM) libeiffel.a

libeiffel.a: $(OBJS)
	$(RM) $@
	$(AR) $@ $(OBJS)
	$(RANLIB) $@

all:: libweiffel.a

local_realclean::
	$(RM) libweiffel.a

libweiffel.a: $(WOBJS)
	$(RM) $@
	$(AR) $@ $(WOBJS)
	$(RANLIB) $@

lexic.o: parser.h

libeiffel.a: lexic.c

libeiffel.a: parser.c

local_realclean::
	$(RM) parser.c

parser.h: parser.c
	@if test -f y.tab.h; then \
		echo "	$(MV) y.tab.h $@"; \
		$(MV) y.tab.h $@; \
	else \
		exit 0; \
	fi

local_realclean::
	$(RM) parser.h

depend:: ../../mkdep

../../mkdep:
	@echo "You have to run Configure in $(TOP) first."; exit 1

depend::
	($(SED) '/^# DO NOT DELETE/q' Makefile && \
	$(MKDEP) $(SOURCES) | \
	$(SED) 's/: \.\//: /; /\/usr\/include/d' \
	) > Makefile.new
	cp Makefile Makefile.bak
	cp Makefile.new Makefile
	$(RM) Makefile.new

keyword.c: eiffel.gperf
	@if test -s keyword.c; then \
		touch $@; \
	else \
		echo "	gperf -p -t -l -k 1,'$$',4 eiffel.gperf > $@"; \
		gperf -p -t -l -k 1,'$$',4 eiffel.gperf > $@ ; \
	fi

infix.c: infix.gperf
	@if test -s infix.c; then \
		touch $@; \
	else \
		echo "  gperf -l -k '1,2,$' -N std_infix infix.gperf > $@"; \
		gperf -l -k '1,2,$$' -N std_infix infix.gperf > $@ ; \
	fi

prefix.c: prefix.gperf
	@if test -s prefix.c; then \
		touch $@; \
	else \
		echo "  gperf -l -k '1,2,$' -N std_prefix prefix.gperf > $@"; \
		gperf -l -k '1,2,$$' -N std_prefix prefix.gperf > $@ ; \
	fi

keyword.o: parser.h
eif_err.o: parser.h

########################################################################
# Common rules for all Makefiles -- do not edit

emptyrule::

clean: local_clean
realclean: local_realclean
clobber: local_clobber

local_clean::
	$(RM) core *~ *.o

local_realclean:: local_clean

local_clobber:: local_realclean
	$(RM) Makefile config.sh

Makefile.SH: Jmakefile
	-@if test -f $(TOP)/.package; then \
		if test -f Makefile.SH; then \
			echo "	$(RM) Makefile.SH~; $(MV) Makefile.SH Makefile.SH~"; \
			$(RM) Makefile.SH~; $(MV) Makefile.SH Makefile.SH~; \
		fi; \
		echo "	$(JMAKE) -DTOPDIR=$(TOP) -DCURDIR=$(CURRENT)" ; \
		$(JMAKE) -DTOPDIR=$(TOP) -DCURDIR=$(CURRENT) ; \
	else touch $@; exit 0; fi

Makefile: Makefile.SH
	/bin/sh Makefile.SH

tags::
	$(CTAGS) -w *.[ch]
	$(CTAGS) -xw *.[ch] > tags

local_clobber::
	$(RM) tags

########################################################################
# Empty rules for directories with no sub-directories -- do not edit

install::
	@echo "install in $(CURRENT) done."

deinstall::
	@echo "deinstall in $(CURRENT) done."

install.man::
	@echo "install.man in $(CURRENT) done."

deinstall.man::
	@echo "deinstall.man in $(CURRENT) done."

Makefiles::

Makefiles.SH::

########################################################################
# Dependencies generated by make depend
# DO NOT DELETE THIS LINE -- make depend relies on it

# Put nothing here or make depend will gobble it up
.FORCE_DEPEND::
	@echo "You must run 'make depend' in $(TOP) first."; exit 1
!NO!SUBS!
chmod 644 Makefile
$eunicefix Makefile

