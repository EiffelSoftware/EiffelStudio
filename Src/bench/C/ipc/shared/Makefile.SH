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
CURRENT=ipc/shared
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
JMTCFLAGS = \$(CFLAGS) $optimize $mtccflags $large
LINT = lint
MAKE = make
MKDEP = $mkdep \$(DPFLAGS) --
MV = $mv
RANLIB = $ranlib
RM = $rm -f
LN = $ln
SED = $sed

########################################################################
# Automatically generated parameters -- do not edit

SOURCES =  \$(LSRC)
OBJECTS =  \$(LOBJ) \$(MT_LOBJ)

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

LIBRUN = ../../run-time
LIBIDR = ../../idrs
DPFLAGS = -I$(TOP) -I$(LIBRUN) -I$(LIBIDR)
CFLAGS = $(DPFLAGS) -DWORKBENCH

LSRC = com.c identify.c lock.c logfile.c network.c select.c shword.c stack.c \
	stream.c system.c transfer.c rqst_idrs.c

MT_LOBJ = \
    MTcom.o \
    MTidentify.o \
    MTlock.o \
    MTlogfile.o \
    MTnetwork.o \
    MTselect.o \
    MTshword.o \
    MTstack.o \
    MTstream.o \
    MTsystem.o \
    MTtransfer.o \
    MTrqst_idrs.o

all:: libmtipc.a

local_realclean::
	$(RM) libmtipc.a

libmtipc.a: $(MT_LOBJ)
	$(RM) $@
	$(AR) $@ $(MT_LOBJ)
	$(RANLIB) $@


MTcom.c: com.c
	$(RM) MTcom.c
	$(LN) com.c MTcom.c
remove::
	$(RM) MTcom.c

MTidentify.c: identify.c
	$(RM) MTidentify.c
	$(LN) identify.c MTidentify.c
remove::
	$(RM) MTidentify.c

MTlock.c: lock.c
	$(RM) MTlock.c
	$(LN) lock.c MTlock.c
remove::
	$(RM) MTlock.c

MTlogfile.c: logfile.c
	$(RM) MTlogfile.c
	$(LN) logfile.c MTlogfile.c
remove::
	$(RM) MTlogfile.c

MTnetwork.c: network.c
	$(RM) MTnetwork.c
	$(LN) network.c MTnetwork.c
remove::
	$(RM) MTnetwork.c

MTselect.c: select.c
	$(RM) MTselect.c
	$(LN) select.c MTselect.c
remove::
	$(RM) MTselect.c

MTshword.c: shword.c
	$(RM) MTshword.c
	$(LN) shword.c MTshword.c
remove::
	$(RM) MTshword.c

MTstream.c: stream.c
	$(RM) MTstream.c
	$(LN) stream.c MTstream.c
remove::
	$(RM) MTstream.c

MTstack.c: stack.c
	$(RM) MTstack.c
	$(LN) stack.c MTstack.c
remove::
	$(RM) MTstack.c

MTsystem.c: system.c
	$(RM) MTsystem.c
	$(LN) system.c MTsystem.c
remove::
	$(RM) MTsystem.c

MTtransfer.c: transfer.c
	$(RM) MTtransfer.c
	$(LN) transfer.c MTtransfer.c
remove::
	$(RM) MTtransfer.c

MTrqst_idrs.c: rqst_idrs.c
	$(RM) MTrqst_idrs.c
	$(LN) rqst_idrs.c MTrqst_idrs.c
remove::
	$(RM) MTrqst_idrs.c


MTcom.o: MTcom.c
	$(CC) -c $(JMTCFLAGS) $*.c
	$(RM) $*.c

MTidentify.o: MTidentify.c
	$(CC) -c $(JMTCFLAGS) $*.c
	$(RM) $*.c

MTlogfile.o: MTlogfile.c
	$(CC) -c $(JMTCFLAGS) $*.c
	$(RM) $*.c

MTnetwork.o: MTnetwork.c
	$(CC) -c $(JMTCFLAGS) $*.c
	$(RM) $*.c

MTselect.o: MTselect.c
	$(CC) -c $(JMTCFLAGS) $*.c
	$(RM) $*.c

MTshword.o: MTshword.c
	$(CC) -c $(JMTCFLAGS) $*.c
	$(RM) $*.c

MTstream.o: MTstream.c
	$(CC) -c $(JMTCFLAGS) $*.c
	$(RM) $*.c

MTsystem.o: MTsystem.c
	$(CC) -c $(JMTCFLAGS) $*.c
	$(RM) $*.c

MTstack.o: MTstack.c
	$(CC) -c $(JMTCFLAGS) $*.c
	$(RM) $*.c

MTtransfer.o: MTtransfer.c
	$(CC) -c $(JMTCFLAGS) $*.c
	$(RM) $*.c

MTrqst_idrs.o: MTrqst_idrs.c
	$(CC) -c $(JMTCFLAGS) $*.c
	$(RM) $*.c

MTlock.o: MTlock.c
	$(CC) -c $(JMTCFLAGS) $*.c
	$(RM) $*.c

LOBJ = \
	com.o \
	identify.o \
	lock.o \
	logfile.o \
	network.o \
	select.o \
	shword.o \
	stack.o \
	stream.o \
	system.o \
	transfer.o \
	rqst_idrs.o 

all:: libipc.a

local_realclean::
	$(RM) libipc.a

libipc.a: $(LOBJ)
	$(RM) $@
	$(AR) $@ $(LOBJ)
	$(RANLIB) $@


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

lint:
	$(LINT) $(LINTFLAGS) $(SOURCES) $(LINTLIBS)

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

