: Makefile.SH generated from Jmake.tmpl and Jmakefile [jmake 3.0 PL44]
: $X-Id: Jmake.tmpl,v 3.0.1.1 1993/08/20 07:36:36 ram Exp ram $

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
CURRENT=lib
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
MV = $mv
PRIVLIB = $installprivlib
RM = $rm -f

########################################################################
# Automatically generated parameters -- do not edit

SUBDIRS = C

!GROK!THIS!
$spitshell >>Makefile <<'!NO!SUBS!'
########################################################################
# Jmake rules for building libraries, programs, scripts, and data files
# $X-Id: Jmake.rules,v 3.0.1.1 1994/10/29 15:46:30 ram Exp ram $

########################################################################
# Start of Jmakefile

# $X-Id: Jmakefile,v 3.0.1.1 1994/01/24 13:43:31 ram Exp ram $
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
# Revision 3.0.1.1  1994/01/24  13:43:31  ram
# patch16: added new directory for C code sources
#
# Revision 3.0  1993/08/18  12:04:34  ram
# Baseline for dist 3.0 netwide release.
#

FILES = errnolist.a errnolist.mk
FILES_SH = errnolist makedepend makedir

INSTALLFLAGS = -m 444

all::

install::
	@for dir in $(PRIVLIB)/lib; do \
		case '${MFLAGS}' in *[i]*) set +e;; esac; \
		(set -x; test -d $$dir || $(INSTALLDIR) $$dir); \
	done

install:: $(FILES)
	@case '${MFLAGS}' in *[i]*) set +e;; esac; \
	for i in $(FILES); do \
		(set -x; $(INSTALL) -c $(INSTALLFLAGS) $$i $(PRIVLIB)/lib); \
	done

deinstall::
	@case '${MFLAGS}' in *[i]*) set +e;; esac; \
	for i in $(FILES); do \
		(set -x; $(RM) $(PRIVLIB)/lib/$$i); \
	done


install:: errnolist.sh
	@case '${MFLAGS}' in *[i]*) set +e;; esac; \
	(set -x; $(INSTALL) -c -m 444 errnolist.sh $(PRIVLIB)/lib/errnolist.SH)

deinstall::
	@case '${MFLAGS}' in *[i]*) set +e;; esac; \
	(set -x; $(RM) $(PRIVLIB)/lib/errnolist.SH)

install:: makedepend.sh
	@case '${MFLAGS}' in *[i]*) set +e;; esac; \
	(set -x; $(INSTALL) -c -m 444 makedepend.sh $(PRIVLIB)/lib/makedepend.SH)

deinstall::
	@case '${MFLAGS}' in *[i]*) set +e;; esac; \
	(set -x; $(RM) $(PRIVLIB)/lib/makedepend.SH)

install:: makedir.sh
	@case '${MFLAGS}' in *[i]*) set +e;; esac; \
	(set -x; $(INSTALL) -c -m 444 makedir.sh $(PRIVLIB)/lib/makedir.SH)

deinstall::
	@case '${MFLAGS}' in *[i]*) set +e;; esac; \
	(set -x; $(RM) $(PRIVLIB)/lib/makedir.SH)

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

!NO!SUBS!
chmod 644 Makefile
$eunicefix Makefile

