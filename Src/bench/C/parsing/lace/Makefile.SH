: Makefile.SH generated from Jmake.tmpl and Jmakefile [jmake 3.0 PL60]
: $X-Id: Jmake.tmpl,v 3.0.1.2 1995/01/11 14:50:21 ram Exp $

case $CONFIG in
'')
	if test -f config.sh; then TOP=.;
	elif test -f ../config.sh; then TOP=..;
	elif test -f ../../config.sh; then TOP=../..;
	elif test -f ../../../config.sh; then TOP=../../..;
	elif test -f ../../../../config.sh; then TOP=../../../..;
	else
		echo "Can't find config.sh."; exit 1
	fi
	. $TOP/config.sh
	;;
esac
case "$0" in
*/*) cd `expr X$0 : 'X\(.*\)/'` ;;
esac
CURRENT=parsing/lace
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
CP = $cp
CTAGS = ctags
JCFLAGS = \$(CFLAGS) $optimize $ccflags $large
JLFLAGS = \$(LFLAGS) $lexflags -S../eiffel/flex.skl
JYFLAGS = \$(YFLAGS) $yaccflags
LEX = $lex
MAKE = make
MKDEP = $mkdep \$(DPFLAGS) --
MV = $mv
RANLIB = $ranlib
RM = $rm -f
SED = $sed
YACC = $yacc

########################################################################
# Automatically generated parameters -- do not edit

RUN_TIME = ../../run-time
SHARED_CLIB = ../shared
SOURCES =  \$(SRCS) lace_y.y
OBJECTS =  \$(OBJS) lace_l.o lace_y.o eif_l.o

########################################################################
# New suffixes and associated building rules -- edit with care

.c.o:
	\$(RM) \$@
	\$(CC) -c \$(JCFLAGS) \$<

!GROK!THIS!
$spitshell >>Makefile <<'!NO!SUBS!'
########################################################################
# Jmake rules for building libraries, programs, scripts, and data files
# $X-Id: Jmake.rules,v 3.0.1.5 1995/09/25 09:07:19 ram Exp $

########################################################################
# Force 'make depend' to be performed first -- do not edit

.FORCE_DEPEND::

all:: .FORCE_DEPEND

########################################################################
# Start of Jmakefile

DPFLAGS = -I$(TOP) -I$(SHARED_CLIB) -I$(RUN_TIME)
CFLAGS = $(DPFLAGS)
YFLAGS = -d

SRCS = lace_l.c lace_y.y lace_c.c eif_l.c lac_err.c keyword.c

OBJS = \
	lace_l.o \
	lace_y.o \
	lace_c.o \
	eif_l.o \
	lac_err.o \
	keyword.o 

all:: liblace.a

local_realclean::
	$(RM) liblace.a

liblace.a: $(OBJS)
	$(RM) $@
	$(AR) $@ $(OBJS)
	$(RANLIB) $@

lace_l.o: lace_y.h

liblace.a: lace_l.c

lace_l.c: lace_l.l
	$(LEX) $(JLFLAGS) lace_l.l
	$(SED) -e 's/^# define YYLMAX [0-9][0-9]*/# define YYLMAX BUFSIZ/g' < lex.yy.c > lex.xx.c
	$(SED) -e 's/yy\(.\)/xx\1/g' < lex.xx.c > lace_l.c
	$(RM) lex.yy.c lex.xx.c

liblace.a: lace_y.c

lace_y.c: lace_y.y
	$(YACC) $(JYFLAGS) lace_y.y
	$(SED) -e 's/yy\(.\)/xx\1/g' < y.tab.c > lace_y.c
	$(SED) -e 's/yy\(.\)/xx\1/g' < y.tab.h > lace_y.h
	$(RM) y.tab.c y.tab.h

local_realclean::
	$(RM) lace_y.c

lace_y.h: lace_y.c
	@if test -f y.tab.h; then \
	echo "	$(SED) -e 's/yy\(.\)/xx\1/g' < y.tab.h > lace_y.h"; \
	$(SED) -e 's/yy\(.\)/xx\1/g' < y.tab.h > lace_y.h; \
	echo "	$(RM) y.tab.h"; \
	$(RM) y.tab.h; \
	elif test -f lace_y.h; then \
	echo "	$(CP) lace_y.h lace_y.ht"; \
	$(CP) lace_y.h lace_y.ht; \
	echo "	$(SED) -e 's/yy\(.\)/xx\1/g' < lace_y.ht > lace_y.h"; \
	$(SED) -e 's/yy\(.\)/xx\1/g' < lace_y.ht > lace_y.h; \
	echo "	$(RM) lace_y.ht"; \
	$(RM) lace_y.ht; \
	else \
	exit 0; \
	fi

local_realclean::
	$(RM) lace_y.h

liblace.a: eif_l.c

eif_l.c: eif_l.l
	$(LEX) $(JLFLAGS) eif_l.l
	$(SED) -e 's/^# define YYLMAX [0-9][0-9]*/# define YYLMAX BUFSIZ/g' < lex.yy.c > lex.zz.c
	$(SED) -e 's/yy\(.\)/zz\1/g' < lex.zz.c > eif_l.c
	$(RM) lex.yy.c lex.zz.c

depend:: ../../mkdep

../../mkdep:
	@echo "You have to run Configure in $(TOP) first."; exit 1

depend::
	($(SED) '/^# DO NOT DELETE/q' Makefile && \
	$(MKDEP) $(SOURCES) | \
	$(SED) -e 's/: \.\//: /; s/\/usr\/include[^ ]*//g' -e '/: *$$/d' \
	) > Makefile.new
	cp Makefile Makefile.bak
	cp Makefile.new Makefile
	$(RM) Makefile.new

keyword.c: lace.gperf
	@if test -s keyword.c; then \
		touch $@; \
	else \
		echo "	gperf -D -p -t -l -k 1,'$$',4 -N in_word_set2 lace.gperf > $@"; \
		gperf -D -p -t -l -k 1,'$$',4 -N in_word_set2 lace.gperf > $@ ; \
	fi

keyword.o: lace_y.h
lac_err.o: lace_y.h
lace_l.o: lace_y.h

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

