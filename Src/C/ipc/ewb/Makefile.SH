: Makefile.SH generated from Jmake.tmpl and Jmakefile [jmake 3.5 PL0]
: $X-Id: Jmake.tmpl 91075 2005-12-28 23:58:23Z manus $

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
OBJECTS =  \$(LOBJ)  \$(WOBJ)  \$(MT_LOBJ)  \$(MT_WOBJ) wewb_proto.o MTwewb_proto.o

########################################################################
# New suffixes and associated building rules -- edit with care

.c.o:
	\$(CC) -c \$(JCFLAGS) \$<

!GROK!THIS!
$spitshell >>Makefile <<'!NO!SUBS!'
########################################################################
# Jmake rules for building libraries, programs, scripts, and data files
# $X-Id: Jmake.rules 18 2006-12-27 10:35:09Z rmanfredi $

########################################################################
# Force 'make depend' to be performed first -- do not edit

.FORCE_DEPEND::

all:: .FORCE_DEPEND

########################################################################
# Start of Jmakefile

# Files used to build the daemon
LSRC = eproto.c eif_in.c eif_out.c ewb_init.c ewb_dumped.c ewb_child.c ewb_transfer.c ewb_proto.c
ALL_SRC = $(LSRC)

# Derived object file names
LOBJ = \
	eproto.o \
	eif_in.o \
	eif_out.o \
	ewb_init.o \
	ewb_dumped.o \
	ewb_child.o \
	ewb_transfer.o \
	ewb_proto.o 

WOBJ = \
	weproto.o \
	weif_in.o \
	weif_out.o \
	wewb_init.o \
	wewb_dumped.o \
	wewb_child.o \
	wewb_transfer.o \
	wewb_proto.o 

MT_WOBJ = \
	MTweproto.o \
	MTweif_in.o \
	MTweif_out.o \
	MTwewb_init.o \
	MTwewb_dumped.o \
	MTwewb_child.o \
	MTwewb_transfer.o \
	MTwewb_proto.o 

MT_LOBJ = \
	MTeproto.o \
	MTeif_in.o \
	MTeif_out.o \
	MTewb_init.o \
	MTewb_dumped.o \
	MTewb_child.o \
	MTewb_transfer.o \
	MTewb_proto.o 

# The following is to buiilt the multithreaded version, we creates rules to generate the MT*.o files
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

MTewb_child.o: ewb_child.c
	       $(CC) -c $(JMTCFLAGS) $? -o $@

MTewb_transfer.o: ewb_transfer.c
	       $(CC) -c $(JMTCFLAGS) $? -o $@

MTewb_proto.o: ewb_proto.c
	       $(CC) -c $(JMTCFLAGS) $? -o $@


# Rule for compiling MTw*.o files
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

MTwewb_child.o: ewb_child.c
	       $(CC) -c $(JMTCFLAGS) -DWORKBENCH $? -o $@

MTwewb_transfer.o: ewb_transfer.c
	       $(CC) -c $(JMTCFLAGS) -DWORKBENCH $? -o $@

MTwewb_proto.o: ewb_proto.c
	       $(CC) -c $(JMTCFLAGS) -DWORKBENCH $? -o $@


# Rule for compiling w*.o files
weproto.o: eproto.c
	       $(CC) -c $(JCFLAGS) -DWORKBENCH $? -o $@

weif_in.o: eif_in.c
	       $(CC) -c $(JCFLAGS) -DWORKBENCH $? -o $@

weif_out.o: eif_out.c
	       $(CC) -c $(JCFLAGS) -DWORKBENCH $? -o $@

wewb_init.o: ewb_init.c
	       $(CC) -c $(JCFLAGS) -DWORKBENCH $? -o $@

wewb_dumped.o: ewb_dumped.c
	       $(CC) -c $(JCFLAGS) -DWORKBENCH $? -o $@

wewb_child.o: ewb_child.c
	       $(CC) -c $(JCFLAGS) -DWORKBENCH $? -o $@

wewb_transfer.o: ewb_transfer.c
	       $(CC) -c $(JCFLAGS) -DWORKBENCH $? -o $@

wewb_proto.o: ewb_proto.c
	       $(CC) -c $(JCFLAGS) -DWORKBENCH $? -o $@


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

all:: libwewb.a

local_realclean::
	$(RM) libwewb.a

libwewb.a:  $(WOBJ)
	$(RM) $@
	$(AR) $@  $(WOBJ)
	$(RANLIB) $@

all:: libmtewb.a

local_realclean::
	$(RM) libmtewb.a

libmtewb.a:  $(MT_LOBJ)
	$(RM) $@
	$(AR) $@  $(MT_LOBJ)
	$(RANLIB) $@

all:: libmtwewb.a

local_realclean::
	$(RM) libmtwewb.a

libmtwewb.a:  $(MT_WOBJ)
	$(RM) $@
	$(AR) $@  $(MT_WOBJ)
	$(RANLIB) $@

all:: wewb_proto.o

local_realclean::
	$(RM) wewb_proto.o

all:: MTwewb_proto.o

local_realclean::
	$(RM) MTwewb_proto.o

depend:: ../../mkdep

../../mkdep:
	@echo "You have to run Configure in $(TOP) first."; exit 1

depend::
	($(SED) '/^# DO NOT DELETE/q' Makefile && \
	$(MKDEP) $(SOURCES) | \
	$(SED) -e 's:/usr/lib[^ ]*::g; s:$(USRINC)[^ ]*::g; ' \
	-e '/: / b print' -e '$$ b print' -e 'H; d; n; : print' \
	-e 'x; s/\\$$//; s/\\\n//g; s/  */ /g; s/ :/:/;' -e '/: *$$/d' \
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
	if test -f core; then $(RM) core; fi
	$(RM) *~ *.o

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
	else touch $@; fi

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

