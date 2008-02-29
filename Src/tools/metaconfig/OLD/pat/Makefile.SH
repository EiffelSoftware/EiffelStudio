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
CURRENT=pat
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

# $X-Id: Jmakefile,v 3.0.1.3 1995/07/24 09:57:21 ram Exp ram $
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
# Revision 3.0.1.3  1995/07/24  09:57:21  ram
# patch56: was missing an entry for the patlog program
#
# Revision 3.0.1.2  1994/01/24  13:42:48  ram
# patch16: added dependency generation stage
#
# Revision 3.0.1.1  1993/08/24  12:09:05  ram
# patch3: added patnotify and patsnap
#
# Revision 3.0  1993/08/18  12:10:32  ram
# Baseline for dist 3.0 netwide release.
#

BASE = // cil base diff make clean col name ftp send \
	index post notify snap log

PAT = \
	pat \
	patcil \
	patbase \
	patdiff \
	patmake \
	patclean \
	patcol \
	patname \
	patftp \
	patsend \
	patindex \
	patpost \
	patnotify \
	patsnap \
	patlog 

all:: $(PAT)

local_realclean::
	$(RM) $(PAT)

pat: pat.SH
	/bin/sh pat.SH

patcil: patcil.SH
	/bin/sh patcil.SH

patbase: patbase.SH
	/bin/sh patbase.SH

patdiff: patdiff.SH
	/bin/sh patdiff.SH

patmake: patmake.SH
	/bin/sh patmake.SH

patclean: patclean.SH
	/bin/sh patclean.SH

patcol: patcol.SH
	/bin/sh patcol.SH

patname: patname.SH
	/bin/sh patname.SH

patftp: patftp.SH
	/bin/sh patftp.SH

patsend: patsend.SH
	/bin/sh patsend.SH

patindex: patindex.SH
	/bin/sh patindex.SH

patpost: patpost.SH
	/bin/sh patpost.SH

patnotify: patnotify.SH
	/bin/sh patnotify.SH

patsnap: patsnap.SH
	/bin/sh patsnap.SH

patlog: patlog.SH
	/bin/sh patlog.SH


install:: $(PAT)
	@case '${MFLAGS}' in *[i]*) set +e;; esac; \
	for i in $(PAT); do \
	(set -x; $(INSTALL) -c -m 555 $$i $(SCRIPTDIR)); \
	done

deinstall::
	@case '${MFLAGS}' in *[i]*) set +e;; esac; \
	for i in $(PAT); do \
	(set -x; $(RM) $(SCRIPTDIR)/$$i); \
	done

install.man:: pat.man
	$(INSTALL) -c -m 444 pat.man $(MANSRC)/pat.$(L)

deinstall.man::
	$(RM) $(MANSRC)/pat.$(L)

PATSH = \
	pat.SH \
	patcil.SH \
	patbase.SH \
	patdiff.SH \
	patmake.SH \
	patclean.SH \
	patcol.SH \
	patname.SH \
	patftp.SH \
	patsend.SH \
	patindex.SH \
	patpost.SH \
	patnotify.SH \
	patsnap.SH \
	patlog.SH 

depend::
	($(SED) '/^# DO NOT DELETE/q' Makefile && \
	grep '^\$$grep' $(PATSH) | \
	$(SED) -e "s/^.*' \([^ ]*\) >>\([^ ]*\)/\2: \1/" \
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

