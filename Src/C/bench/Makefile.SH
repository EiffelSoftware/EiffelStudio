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
CURRENT=bench
DIR=`echo $CURRENT/ | sed -e 's/\.\///g'`
echo "Extracting ${DIR}Makefile (with variable substitutions)"

DATE=`date`

$spitshell >Makefile <<!GROK!THIS!
########################################################################
# Makefile generated from Makefile.SH on $DATE

SHELL = /bin/sh
JMAKE = jmake
TOP = ..
CURRENT = $CURRENT
DIR = $DIR

########################################################################
# Parameters set by Configure -- edit config.sh if changes are needed

AR = ar rc
CC = $cc
CTAGS = ctags
JCFLAGS = \$(CFLAGS) $optimize $warning_level $ccflags $large
JMTCFLAGS = \$(CFLAGS) $optimize $warning_level $mtccflags $large
JLKFLAGS = \$(LDFLAGS) $ccldflags
LIBS = $libs
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
SOURCES =  \$(LSRC) \$(PSTORE) \$(LSRC) \$(PSTORE) bytedump.c meltdump.c
OBJECTS =  \$(FOBJ) \$(WOBJ) \$(MT_FOBJ) \$(MT_WOBJ) bytedump.o meltdump.o

########################################################################
# New suffixes and associated building rules -- edit with care

.c.o:
	\$(RM) \$@
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
LSRC = byte.c date.c offset.c minilzo.c
PSTORE = pstore.c pretrieve.c

# Derived object file names
FOBJ = \
	   byte.o \
	   date.o \
	   offset.o \
	   minilzo.o \
	   pstore.o \
	   pretrieve.o 

MT_FOBJ = \
	MTbyte.o \
	MTdate.o \
	MToffset.o \
	MTminilzo.o \
	MTpstore.o \
	MTpretrieve.o 

WOBJ = \
	      byte.o \
	      date.o \
	      offset.o \
	      minilzo.o \
	       wpstore.o \
	       wpretrieve.o 

MT_WOBJ = \
	MTbyte.o \
	MTdate.o \
	MToffset.o \
	MTminilzo.o \
	MTwpstore.o \
	MTwpretrieve.o 

wpstore.o: pstore.c
	       $(CC) -c $(JCFLAGS) -DWORKBENCH $? -o $@

wpretrieve.o: pretrieve.c
	       $(CC) -c $(JCFLAGS) -DWORKBENCH $? -o $@


MTbyte.o: byte.c
	       $(CC) -c $(JMTCFLAGS) $? -o $@

MTdate.o: date.c
	       $(CC) -c $(JMTCFLAGS) $? -o $@

MToffset.o: offset.c
	       $(CC) -c $(JMTCFLAGS) $? -o $@

MTminilzo.o: minilzo.c
	       $(CC) -c $(JMTCFLAGS) $? -o $@

MTpstore.o: pstore.c
	       $(CC) -c $(JMTCFLAGS) $? -o $@

MTpretrieve.o: pretrieve.c
	       $(CC) -c $(JMTCFLAGS) $? -o $@


MTwpstore.o: pstore.c
	       $(CC) -c $(JMTCFLAGS) -DWORKBENCH $? -o $@

MTwpretrieve.o: pretrieve.c
	       $(CC) -c $(JMTCFLAGS) -DWORKBENCH $? -o $@


# Where shared archive is located (path and name)
# Where shared archive is located (path and name)
LIBRUN = ../run-time

DPFLAGS = -I$(TOP) -I$(LIBRUN) -I$(LIBRUN)/include -I$(TOP)/idrs
CFLAGS = $(DPFLAGS)

all:: libcompiler.a

local_realclean::
	$(RM) libcompiler.a

libcompiler.a: $(FOBJ)
	$(RM) $@
	$(AR) $@ $(FOBJ)
	$(RANLIB) $@

all:: libwcompiler.a

local_realclean::
	$(RM) libwcompiler.a

libwcompiler.a: $(WOBJ)
	$(RM) $@
	$(AR) $@ $(WOBJ)
	$(RANLIB) $@

all:: libmtcompiler.a

local_realclean::
	$(RM) libmtcompiler.a

libmtcompiler.a: $(MT_FOBJ)
	$(RM) $@
	$(AR) $@ $(MT_FOBJ)
	$(RANLIB) $@

all:: libmtwcompiler.a

local_realclean::
	$(RM) libmtwcompiler.a

libmtwcompiler.a: $(MT_WOBJ)
	$(RM) $@
	$(AR) $@ $(MT_WOBJ)
	$(RANLIB) $@

all:: bytedump

local_realclean::
	$(RM) bytedump

bytedump: bytedump.o
	$(RM) $@
	if test -f $@$(_EXE); then \
	$(MV) $@$(_EXE) $@~$(_EXE); fi
	$(CC) -o $@ bytedump.o $(JLKFLAGS) $(LIBS)

all:: meltdump

local_realclean::
	$(RM) meltdump

meltdump: meltdump.o
	$(RM) $@
	if test -f $@$(_EXE); then \
	$(MV) $@$(_EXE) $@~$(_EXE); fi
	$(CC) -o $@ meltdump.o $(JLKFLAGS) $(LIBS)

depend:: ../mkdep

../mkdep:
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

