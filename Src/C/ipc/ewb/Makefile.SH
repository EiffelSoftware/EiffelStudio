: Makefile.SH generated from Jmake.tmpl and Jmakefile [jmake 3.0 PL70]
: $X-Id: Jmake.tmpl,v 1.4 2005/10/13 21:38:08 manus Exp $

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
CURRENT=ipc/ewb
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
JCFLAGS = \$(CFLAGS) $optimize $warning_level $ccflags $large
JMTCFLAGS = \$(CFLAGS) $optimize $warning_level $mtccflags $large
LINT = lint
MAKE = make
MKDEP = $mkdep \$(DPFLAGS) --
MV = $mv
RANLIB = $ranlib
RM = $rm -f
SED = $sed

########################################################################
# Automatically generated parameters -- do not edit

USRINC = $usrinc
SOURCES =  \$(LSRC)
OBJECTS =  \$(LOBJ) \$(MT_LOBJ) \$(MT_WOBJ)

########################################################################
# New suffixes and associated building rules -- edit with care

.c.o:
	\$(CC) -c \$(JCFLAGS) \$<

!GROK!THIS!
$spitshell >>Makefile <<'!NO!SUBS!'
########################################################################
# Jmake rules for building libraries, programs, scripts, and data files
# $X-Id: Jmake.rules,v 1.4 2005/10/13 21:37:30 manus Exp $
########################################################################
# Force 'make depend' to be performed first -- do not edit

.FORCE_DEPEND::

all:: .FORCE_DEPEND

########################################################################
# Start of Jmakefile

# Files used to build the daemon
LSRC = ewb_proto.c eproto.c eif_in.c eif_out.c ewb_init.c ewb_dumped.c

# Derived object file names
LOBJ = \
	       ewb_proto.o \
	       eproto.o \
	       eif_in.o \
	       eif_out.o \
	       ewb_init.o \
	       ewb_dumped.o 

MT_WOBJ = \
	       MTwewb_proto.o \
	       MTweproto.o \
	       MTweif_in.o \
	       MTweif_out.o \
	       MTwewb_init.o \
	       MTwewb_dumped.o 

MT_LOBJ = \
	       MTewb_proto.o \
	       MTeproto.o \
	       MTeif_in.o \
	       MTeif_out.o \
	       MTewb_init.o \
	       MTewb_dumped.o 

# The following is to buiilt the multithreaded version, we creates rules to generate the MT*.o files
MTewb_proto.o: ewb_proto.c
	       $(CC) -c $(JMTCFLAGS) $? -o $@

MTeproto.o: eproto.c
	       $(CC) -c $(JMTCFLAGS) $? -o $@

MTeif_in.o: eif_in.c
	       $(CC) -c $(JMTCFLAGS) $? -o $@

MTeif_out.o: eif_out.c
	       $(CC) -c $(JMTCFLAGS) $? -o $@

MTewb_init.o: ewb_init.c
	       $(CC) -c $(JMTCFLAGS) $? -o $@

MTewb_dumped.o: ewb_dumped.c
	       $(CC) -c $(JMTCFLAGS) $? -o $@


# Rule for compiling MTw*.o files
MTwewb_proto.o: ewb_proto.c
	       $(CC) -c $(JMTCFLAGS) -DWORKBENCH $? -o $@

MTweproto.o: eproto.c
	       $(CC) -c $(JMTCFLAGS) -DWORKBENCH $? -o $@

MTweif_in.o: eif_in.c
	       $(CC) -c $(JMTCFLAGS) -DWORKBENCH $? -o $@

MTweif_out.o: eif_out.c
	       $(CC) -c $(JMTCFLAGS) -DWORKBENCH $? -o $@

MTwewb_init.o: ewb_init.c
	       $(CC) -c $(JMTCFLAGS) -DWORKBENCH $? -o $@

MTwewb_dumped.o: ewb_dumped.c
	       $(CC) -c $(JMTCFLAGS) -DWORKBENCH $? -o $@


# Where shared archive is located (path and name)
LIB_SHARED = ../shared
LIB_IDR = ../../idrs

RUN_TIME = ../../run-time
DPFLAGS = -I$(TOP) -I$(LIB_SHARED) -I$(RUN_TIME) -I$(LIB_IDR) -I$(RUN_TIME)/include
CFLAGS = $(DPFLAGS) -DEIF_IPC

all:: libewb.a

local_realclean::
	$(RM) libewb.a

libewb.a: $(LOBJ)
	$(RM) $@
	$(AR) $@ $(LOBJ)
	$(RANLIB) $@

all:: libmtewb.a

local_realclean::
	$(RM) libmtewb.a

libmtewb.a: $(MT_LOBJ)
	$(RM) $@
	$(AR) $@ $(MT_LOBJ)
	$(RANLIB) $@

all:: libmtwewb.a

local_realclean::
	$(RM) libmtwewb.a

libmtwewb.a: $(MT_WOBJ)
	$(RM) $@
	$(AR) $@ $(MT_WOBJ)
	$(RANLIB) $@

depend:: ../../mkdep

../../mkdep:
	@echo "You have to run Configure in $(TOP) first."; exit 1

depend::
	($(SED) '/^# DO NOT DELETE/q' Makefile && \
	$(MKDEP) $(SOURCES) | \
	$(SED) -e 's:/usr/include[^ ]*::g; s:$(USRINC)[^ ]*::g; ' \
	-e '/: / b print' -e 'H; d; n; : print' -e 'x; s/\\\n//g' \
	-e 's/  */ /g; s/ :/:/;' -e '/: *$$/d' \
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
