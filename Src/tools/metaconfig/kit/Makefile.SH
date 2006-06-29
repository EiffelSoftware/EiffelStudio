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
CURRENT=kit
DIR=`echo $CURRENT/ | sed -e 's/\.\///g'`
echo "Extracting ${DIR}Makefile (with variable substitutions)"

INSTALL=`echo $install | sed -e 's,\./i,\$(TOP)/i,'`
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

########################################################################
# Parameters set by Configure -- edit config.sh if changes are needed

CTAGS = ctags
L = $manext
MANSRC = $installmansrc
MAKE = make
MKDEP = $mkdep \$(DPFLAGS) --
MV = $mv
RM = $rm -f
SCRIPTDIR = $installscript
SED = $sed

########################################################################
# Automatically generated parameters -- do not edit

SCRIPTS =  \$(SCRIPT)

!GROK!THIS!
$spitshell >>Makefile <<'!NO!SUBS!'
########################################################################
# Jmake rules for building libraries, programs, scripts, and data files
# $X-Id: Jmake.rules,v 3.0.1.1 1994/10/29 15:46:30 ram Exp ram $

########################################################################
# Force 'make depend' to be performed first -- do not edit

.FORCE_DEPEND::

all:: .FORCE_DEPEND

########################################################################
# Start of Jmakefile

# $X-Id: Jmakefile,v 3.0.1.2 1994/04/22 09:35:35 ram Exp ram $
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
# Revision 3.0.1.2  1994/04/22  09:35:35  ram
# patch23: new kitpost script
#
# Revision 3.0.1.1  1994/01/24  13:42:21  ram
# patch16: added dependency generation stage
#
# Revision 3.0  1993/08/18  12:04:21  ram
# Baseline for dist 3.0 netwide release.
#

SCRIPT = makedist manifake kitsend kitpost

all:: $(SCRIPT)

local_realclean::
	$(RM) $(SCRIPT)

makedist: makedist.SH
	/bin/sh makedist.SH

manifake: manifake.SH
	/bin/sh manifake.SH

kitsend: kitsend.SH
	/bin/sh kitsend.SH

kitpost: kitpost.SH
	/bin/sh kitpost.SH


install:: $(SCRIPTS) $(LSCRIPTS)
	@for file in $(SCRIPTS) $(LSCRIPTS); do \
		case '${MFLAGS}' in *[i]*) set +e;; esac; \
		(set -x; $(INSTALL) -c -m 555 $$file $(SCRIPTDIR)); \
	done

deinstall::
	@for file in $(SCRIPTS) $(LSCRIPTS); do \
		case '${MFLAGS}' in *[i]*) set +e;; esac; \
		(set -x; $(RM) $(SCRIPTDIR)/$$file); \
	done

install.man::
	@if test "$(MANSRC)"; then \
		case '${MFLAGS}' in *[i]*) set +e;; esac; \
		for file in $(SCRIPTS); do \
			(set -x; \
			$(INSTALL) -c -m 444 $$file.man $(MANSRC)/$$file.$(L)); \
		done; \
	else exit 0; fi

deinstall.man::
	@if test "$(MANSRC)"; then \
		case '${MFLAGS}' in *[i]*) set +e;; esac; \
		for file in $(SCRIPTS); do \
			(set -x; $(RM) $(MANSRC)/$$file.$(L)); \
		done; \
	else exit 0; fi

install:: makeSH
	$(INSTALL) -c -m 555  makeSH $(SCRIPTDIR)

deinstall::
	$(RM) $(SCRIPTDIR)/makeSH

install.man:: makeSH.man
	$(INSTALL) -c -m 444 makeSH.man $(MANSRC)/makeSH.$(L)

deinstall.man::
	$(RM) $(MANSRC)/makeSH.$(L)

SCRIPTSH = \
	makedist.SH \
	manifake.SH \
	kitsend.SH \
	kitpost.SH 

depend::
	($(SED) '/^# DO NOT DELETE/q' Makefile && \
	grep '^\$$grep' $(SCRIPTSH) | \
	$(SED) -e "s/^.*' \([^ ]*\) >>[ ]*\([^ ]*\)/\2: \1/" \
	) > Makefile.new
	cp Makefile Makefile.bak
	cp Makefile.new Makefile
	$(RM) Makefile.new

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

