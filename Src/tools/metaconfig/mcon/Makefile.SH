: Makefile.SH generated from Jmake.tmpl and Jmakefile [jmake 3.0 PL55]
: $X-Id: Jmake.tmpl,v 3.0.1.2 1995/01/11 14:50:21 ram Exp ram $
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
CURRENT=mcon
DIR=`echo $CURRENT/ | sed -e 's/\.\///g'`
echo "Extracting ${DIR}Makefile (with variable substitutions)"

INSTALL=`echo $install | sed -e 's,\./i,\$(TOP)/i,'`
INSTALLDIR=`echo $installdir | sed -e 's,\./i,\$(TOP)/i,'`
DATE=`date`

$spitshell >Makefile <<!GROK!THIS!
########################################################################
# Makefile generated from Makefile.SH on $DATE

SHELL = /bin/sh
JMAKE = jmake
TOP = ..
CURRENT = $CURRENT
DIR = $DIR
INSTALL = $INSTALL
INSTALLDIR = $INSTALLDIR

########################################################################
# Parameters set by Configure -- edit config.sh if changes are needed

CTAGS = ctags
MAKE = make
MKDEP = $mkdep \$(DPFLAGS) --
MV = $mv
PRIVLIB = $installprivlib
RM = $rm -f
SCRIPTDIR = $installscript
SED = $sed

########################################################################
# Automatically generated parameters -- do not edit

SUBDIRS = man
BIN =  metaconfig metalint metaxref

!GROK!THIS!
$spitshell >>Makefile <<'!NO!SUBS!'
########################################################################
# Jmake rules for building libraries, programs, scripts, and data files
# $X-Id: Jmake.rules,v 3.0.1.3 1995/03/21 08:35:28 ram Exp ram $
########################################################################
# Force 'make depend' to be performed first -- do not edit

.FORCE_DEPEND::

all:: .FORCE_DEPEND

########################################################################
# Start of Jmakefile

# $X-Id: Jmakefile,v 3.0.1.4 1995/07/25 13:23:09 ram Exp ram $
#
#  Copyright (c) 1991-1993, Raphael Manfredi
#  
#  You may redistribute only under the terms of the Artistic Licence,
#  as specified in the README file that comes with the distribution.
#  You may reuse parts of this distribution only within the terms of
#  that same Artistic Licence; a copy of which may be found at the root
#  of the source tree for dist 3.0.
#
# $X-Log: Jmakefile,v $
# Revision 3.0.1.4  1995/07/25  13:23:09  ram
# patch56: installs the GNU configure-like front-end to Configure
#
# Revision 3.0.1.3  1994/01/24  13:42:29  ram
# patch16: added dependency generation stage
#
# Revision 3.0.1.2  1993/11/02  10:40:01  ram
# patch14: now invokes perload explicitely via perl executable
#
# Revision 3.0.1.1  1993/08/25  08:46:44  ram
# patch6: split unit installation to avoid shell command line overflow
#
# Revision 3.0  1993/08/18  12:04:40  ram
# Baseline for dist 3.0 netwide release.
#

all:: Glossary

local_realclean::
	$(RM) Glossary

Glossary: makegloss
	chmod +x makegloss
	./makegloss

all:: makegloss

local_realclean::
	$(RM) makegloss

makegloss: makegloss.SH
	/bin/sh makegloss.SH


install::
	@for dir in $(PRIVLIB) $(PRIVLIB)/U; do \
	case '${MFLAGS}' in *[i]*) set +e;; esac; \
	(set -x; test -d $$dir || $(INSTALLDIR) $$dir); \
	done

deinstall::
	$(RM) -r $(PRIVLIB) $(PRIVLIB)/U

install:: Glossary
	$(INSTALL) -c -m 444 Glossary $(PRIVLIB)

deinstall::
	$(RM) $(PRIVLIB)/Glossary

install:: makegloss
	$(INSTALL) -c -m 555  makegloss $(PRIVLIB)

deinstall::
	$(RM) $(PRIVLIB)/makegloss

install:: configure
	$(INSTALL) -c -m 555  configure $(PRIVLIB)

deinstall::
	$(RM) $(PRIVLIB)/configure

install:: U/[a-d]*.U
	@case '${MFLAGS}' in *[i]*) set +e;; esac; \
	for i in U/[a-d]*.U; do \
	(set -x; $(INSTALL) -c -m 444 $$i $(PRIVLIB)/U); \
	done

deinstall::
	@case '${MFLAGS}' in *[i]*) set +e;; esac; \
	for i in U/[a-d]*.U; do \
	(set -x; $(RM) $(PRIVLIB)/U/$$i); \
	done

install:: U/[A-Ze-z]*.U
	@case '${MFLAGS}' in *[i]*) set +e;; esac; \
	for i in U/[A-Ze-z]*.U; do \
	(set -x; $(INSTALL) -c -m 444 $$i $(PRIVLIB)/U); \
	done

deinstall::
	@case '${MFLAGS}' in *[i]*) set +e;; esac; \
	for i in U/[A-Ze-z]*.U; do \
	(set -x; $(RM) $(PRIVLIB)/U/$$i); \
	done

all:: metaconfig mconfig

local_realclean::
	$(RM) metaconfig mconfig

all:: mconfig

local_realclean::
	$(RM) mconfig

mconfig: mconfig.SH
	/bin/sh mconfig.SH

metaconfig: mconfig
	perl $(TOP)/bin/perload -o mconfig > $@
	chmod +rx $@

install:: metaconfig
	$(INSTALL) -c -m 555  metaconfig $(SCRIPTDIR)

deinstall::
	$(RM) $(SCRIPTDIR)/metaconfig

all:: metalint mlint

local_realclean::
	$(RM) metalint mlint

all:: mlint

local_realclean::
	$(RM) mlint

mlint: mlint.SH
	/bin/sh mlint.SH

metalint: mlint
	perl $(TOP)/bin/perload -o mlint > $@
	chmod +rx $@

install:: metalint
	$(INSTALL) -c -m 555  metalint $(SCRIPTDIR)

deinstall::
	$(RM) $(SCRIPTDIR)/metalint

all:: metaxref mxref

local_realclean::
	$(RM) metaxref mxref

all:: mxref

local_realclean::
	$(RM) mxref

mxref: mxref.SH
	/bin/sh mxref.SH

metaxref: mxref
	perl $(TOP)/bin/perload -o mxref > $@
	chmod +rx $@

install:: metaxref
	$(INSTALL) -c -m 555  metaxref $(SCRIPTDIR)

deinstall::
	$(RM) $(SCRIPTDIR)/metaxref

BINFILES = \
	mconfig \
	mlint \
	mxref 

BINSH = \
	mconfig.SH \
	mlint.SH \
	mxref.SH 

depend::
	($(SED) '/^# DO NOT DELETE/q' Makefile && \
	grep '^\$$grep' $(BINSH) | \
	$(SED) -e "s/^.*' \([^ ]*\) >>\([^ ]*\)/\2: \1/" \
	) > Makefile.new
	cp Makefile Makefile.bak
	cp Makefile.new Makefile
	$(RM) Makefile.new

########################################################################
# Common rules for all Makefiles -- do not edit

emptyrule::

clean: sub_clean local_clean
realclean: sub_realclean local_realclean
clobber: sub_clobber local_clobber

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
# Rules for building in sub-directories -- do not edit

subdirs:
	@case '${MFLAGS}' in *[ik]*) set +e;; esac; \
	for i in $(SUBDIRS) ;\
	do \
	(cd $$i ; echo $(VERB) "in $(DIR)$$i..."; \
	$(MAKE) $(MFLAGS) $(FLAGS) $(TARGET)); \
	done

install::
	@$(MAKE) subdirs TARGET=install VERB="Installing" FLAGS=

deinstall::
	@$(MAKE) subdirs TARGET=deinstall VERB="Deinstalling" FLAGS=

install.man::
	@$(MAKE) subdirs TARGET=install.man VERB="Installing man pages" FLAGS=

deinstall.man::
	@$(MAKE) subdirs TARGET=deinstall.man VERB="Deinstalling man pages" FLAGS=

sub_clean::
	@$(MAKE) subdirs TARGET=clean VERB="Cleaning" FLAGS=
	@echo "Back to $(CURRENT) for "clean...

sub_realclean::
	@$(MAKE) subdirs TARGET=realclean VERB="Real cleaning" FLAGS=
	@echo "Back to $(CURRENT) for "realclean...

sub_clobber::
	@$(MAKE) subdirs TARGET=clobber VERB="Clobbering" FLAGS=
	@echo "Back to $(CURRENT) for "clobber...

tag::
	@case '${MFLAGS}' in *[ik]*) set +e;; esac; \
	for i in $(SUBDIRS) ;\
	do \
	(cd $$i ; echo "Tagging" "in $(DIR)$$i..."; \
	$(MAKE) $(MFLAGS)  tag); \
	done

Makefiles::
	@case '${MFLAGS}' in *[ik]*) set +e;; esac; \
	for i in $(SUBDIRS);\
	do \
	echo "Making "Makefiles" in $(DIR)$$i..."; \
	(cd $$i || exit 1; \
	if test ! -f Makefile; then /bin/sh Makefile.SH; fi; \
	$(MAKE) $(MFLAGS) Makefiles) \
	done

Makefiles.SH:: Makefile.SH
	@case '${MFLAGS}' in *[ik]*) set +e;; esac; \
	for i in $(SUBDIRS);\
	do \
	case "$(DIR)$$i/" in \
	*/*/*/*/) newtop=../../../..;; \
	*/*/*/) newtop=../../..;; \
	*/*/) newtop=../..;; \
	*/) newtop=..;; \
	esac; \
	case "$(TOP)" in \
	/*) newtop="$(TOP)" ;; \
	esac; \
	echo "Making Makefiles.SH in $(DIR)$$i..."; \
	(cd $$i || exit 1; $(MAKE) $(MFLAGS) -f ../Makefile \
	Makefile TOP=$$newtop CURRENT=$(DIR)$$i;\
	$(MAKE) $(MFLAGS) Makefiles.SH) \
	done

all::
	@$(MAKE) subdirs TARGET=all VERB="Making all" FLAGS=

########################################################################
# Dependencies generated by make depend
# DO NOT DELETE THIS LINE -- make depend relies on it

# Put nothing here or make depend will gobble it up
.FORCE_DEPEND::
	@echo "You must run 'make depend' in $(TOP) first."; exit 1
!NO!SUBS!
chmod 644 Makefile
$eunicefix Makefile

