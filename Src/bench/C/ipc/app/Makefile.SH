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
CURRENT=ipc/app
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

CC = $cc
LDFLAGS = $ldflags
CTAGS = ctags
JCFLAGS = \$(CFLAGS) $optimize $ccflags $large
JMTCFLAGS = \$(CFLAGS) $optimize $mtccflags $large
LD = ld
MAKE = make
MKDEP = $mkdep \$(DPFLAGS) --
MV = $mv
RM = $rm -f
LN = $ln
SED = $sed

########################################################################
# Automatically generated parameters -- do not edit

SOURCES =  \$(LIB)

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

# Files used to build the application
LIB = app_listen.c app_proto.c app_server.c

# Derived object file names
OBJ = app_listen.o \
	app_proto.o \
	app_server.o 

# Derived object file names for MT lib generation
MT_OBJ = MTapp_listen.o \
    MTapp_proto.o \
    MTapp_server.o

MTapp_listen.o: app_listen.c
	$(CC) -c $(JMTCFLAGS)  $? -o $@

MTapp_proto.o: app_proto.c
	$(CC) -c $(JMTCFLAGS)  $? -o $@

MTapp_server.o: app_server.c
	$(CC) -c $(JMTCFLAGS)  $? -o $@

# Derived library object file names
LOBJ = \
	app_listen.o \
	app_proto.o \
	app_server.o 

#derived library object file names for MT libs

MT_LOBJ = \
    MTapp_listen.o \
    MTapp_proto.o \
    MTapp_server.o

# Where shared archive is located (path and name)
LIBDIR = ../shared
LIBRUN = ../../run-time
LIBIDR = ../../idrs
LIBIDRNAME = libidr.a
MTLIBIDRNAME = libmtidr.a
LIBNAME = libipc.a
MTLIBNAME = libmtipc.a
LIBWKBENCH = libwkbench.a
LIBMTWKBENCH = libwkbench.a
LIBARCH = $(LIBDIR)/$(LIBNAME)
MTLIBARCH = $(LIBDIR)/$(MTLIBNAME)
LIBIDRARCH = $(LIBIDR)/$(LIBIDRNAME)
MTLIBIDRARCH = $(LIBIDR)/$(MTLIBIDRNAME)

DPFLAGS = -I$(TOP) -I$(LIBDIR) -I$(LIBRUN) -I$(LIBIDR) -I$(LIBRUN)/include
CFLAGS = $(DPFLAGS) -DWORKBENCH

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

all:: $(OBJ) $(MT_OBJ)

local_realclean::
	$(RM) $(OBJ) $(MT_OBJ)

.FORCE:

$(LIBDIR)/$(LIBNAME): .FORCE
	@echo "Checking "$(LIBNAME)" in "$(LIBDIR)"..."
	cd $(LIBDIR); $(MAKE) $(LIBNAME)
	@echo "Continuing in $(CURRENT)..."

network.o: $(LIBDIR)/$(LIBNAME)

$(LIBIDR)/$(LIBIDRNAME): .FORCE
	@echo "Checking "$(LIBIDRNAME)" in "$(LIBIDR)"..."
	cd $(LIBIDR); $(MAKE) $(LIBIDRNAME)
	@echo "Continuing in $(CURRENT)..."

network.o: $(LIBIDR)/$(LIBIDRNAME)

all:: network.o

local_realclean::
	$(RM) network.o

network.o: $(LOBJ)
	$(RM) $@
	$(LD) $(LDFLAGS) -r $(LOBJ) -o $@ $(LIBARCH) $(LIBIDRARCH)

# for MT

.FORCE:

$(LIBDIR)/$(MTLIBNAME): .FORCE
	@echo "Checking "$(iMTLIBNAME)" in "$(LIBDIR)"..."
	cd $(LIBDIR); $(MAKE) $(MTLIBNAME)
	@echo "Continuing in $(CURRENT)..."

MTnetwork.o: $(LIBDIR)/$(MTLIBNAME)

$(LIBIDR)/$(MTLIBIDRNAME): .FORCE
	@echo "Checking "$(MTLIBIDRNAME)" in "$(LIBIDR)"..."
	cd $(LIBIDR); $(MAKE) $(MTLIBIDRNAME)
	@echo "Continuing in $(CURRENT)..."

MTnetwork.o: $(LIBIDR)/$(MTLIBIDRNAME)

all:: MTnetwork.o

MTnetwork.o: $(MT_LOBJ) $(LIBDIR)/$(MTLIBNAME)  $(LIBIDR)/$(MTLIBIDRNAME)
	$(RM) $@
	$(LD) $(LDFLAGS) -r $(MT_LOBJ) -o $@ $(MTLIBARCH) $(MTLIBIDRARCH)


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

