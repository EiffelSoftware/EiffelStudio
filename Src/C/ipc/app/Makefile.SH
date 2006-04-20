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
CTAGS = ctags
JCFLAGS = \$(CFLAGS) $optimize $warning_level $ccflags $large
JMTCFLAGS = \$(CFLAGS) $optimize $warning_level $mtccflags $large
JLKFLAGS = \$(LDFLAGS) $ldflags
LD = $ld
LINT = lint
MAKE = make
MKDEP = $mkdep \$(DPFLAGS) --
MV = $mv
RM = $rm -f
SED = $sed

########################################################################
# Automatically generated parameters -- do not edit

USRINC = $usrinc

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

# Where shared archive is located (path and name)
LIB_RUNTIME = $(TOP)/run-time
LIB_IDRS = $(TOP)/idrs
LIB_SHARED = $(TOP)/ipc/shared
LIB_IPCNAME = libipc.a
LIB_MTIPCNAME = libmtipc.a
LIB_IPC_ARCH = $(LIB_SHARED)/$(LIB_IPCNAME)
LIB_MTIPC_ARCH = $(LIB_SHARED)/$(LIB_MTIPCNAME)

DPFLAGS = -I$(TOP) -I$(LIB_SHARED) -I$(LIB_RUNTIME) -I$(LIB_IDRS) -I$(LIB_RUNTIME)/include
CFLAGS = $(DPFLAGS) -DWORKBENCH -DEIF_IPC

# Files used to build the application
LSRC = app_listen.c app_proto.c app_server.c

# Derived object file names
OBJ = \
	       app_listen.o \
	       app_proto.o \
	       app_server.o 

# Derived library object file names
MT_OBJ = \
	       MTapp_listen.o \
	       MTapp_proto.o \
	       MTapp_server.o 

MTapp_listen.o: app_listen.c
	       $(CC) -c $(JMTCFLAGS) -DWORKBENCH -DEIF_IPC $? -o $@

MTapp_proto.o: app_proto.c
	       $(CC) -c $(JMTCFLAGS) -DWORKBENCH -DEIF_IPC $? -o $@

MTapp_server.o: app_server.c
	       $(CC) -c $(JMTCFLAGS) -DWORKBENCH -DEIF_IPC $? -o $@


.FORCE:

$(LIB_SHARED)/$(LIB_IPCNAME): .FORCE
	@echo "Checking "$(LIB_IPCNAME)" in "$(LIB_SHARED)"..."
	cd $(LIB_SHARED); $(MAKE) $(LIB_IPCNAME)
	@echo "Continuing in $(CURRENT)..."

network.o: $(LIB_SHARED)/$(LIB_IPCNAME)

all:: network.o

local_realclean::
	$(RM) network.o

network.o: $(OBJ)
	$(RM) $@
	$(LD) $(JLKFLAGS) -r $(OBJ) -o $@ $(LIB_IPC_ARCH)

$(LIB_SHARED)/$(LIB_MTIPCNAME): .FORCE
	@echo "Checking "$(LIB_MTIPCNAME)" in "$(LIB_SHARED)"..."
	cd $(LIB_SHARED); $(MAKE) $(LIB_MTIPCNAME)
	@echo "Continuing in $(CURRENT)..."

MTnetwork.o: $(LIB_SHARED)/$(LIB_MTIPCNAME)

all:: MTnetwork.o

local_realclean::
	$(RM) MTnetwork.o

MTnetwork.o: $(MT_OBJ)
	$(RM) $@
	$(LD) $(JLKFLAGS) -r $(MT_OBJ) -o $@ $(LIB_MTIPC_ARCH)

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
