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
CURRENT=run-time
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

AR = $ar rc
CC = $cc
CTAGS = ctags
JCFLAGS = \$(CFLAGS) $optimize $ccflags $large
JLDFLAGS = \$(LDFLAGS) $optimize $ldflags
L = $manext
LIBS = $libs
LINT = lint
LN = $ln
MANSRC = $installmansrc
MAKE = make
MKDEP = $mkdep \$(DPFLAGS) --
MV = $mv
RANLIB = $ranlib
RM = $rm -f
SCRIPTDIR = $installscript
SED = $sed

########################################################################
# Automatically generated parameters -- do not edit

SOURCES =  compress.c console.c option.c \$(LSRC) x2c.c debug.c interp.c option.c update.c wbench.c main.c
OBJECTS =  \$(LOBJ) \$(WOBJ) \$(WOBJ) \$(EOBJ) \$(EOBJ) x2c.o debug.o interp.o option.o update.o wbench.o main.o
LSCRIPTS =  eif_size.h

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

CFLAGS = -I$(TOP) -I. -I../ipc/app
DPFLAGS = -I$(TOP) -I. -I../ipc/app

NETWORK_OBJ = ../ipc/app/network.o

LSRC = math.c malloc.c garcol.c local.c store.c retrieve.c \
	hash.c traverse.c hashin.c tools.c internal.c plug.c \
	copy.c equal.c lmalloc.c out.c timer.c urgent.c sig.c \
	hector.c cecil.c bits.c file.c dir.c string.c misc.c \
	pattern.c error.c umain.c memory.c argv.c boolstr.c search.c \
	run_idr.c path_name.c dle.c object_id.c eif_threads.c eif_project.c\
	gen_conf.c rout_obj.c

OTHER = main.c except.c

WADD = debug.c interp.c update.c wbench.c

NETWORK = network.o

WSRC = \
	compress.c \
	console.c \
	woption.c \
	wmath.c \
	wmalloc.c \
	wgarcol.c \
	wlocal.c \
	wstore.c \
	wretrieve.c \
	whash.c \
	wtraverse.c \
	whashin.c \
	wtools.c \
	winternal.c \
	wplug.c \
	wcopy.c \
	wequal.c \
	wlmalloc.c \
	wout.c \
	wtimer.c \
	wurgent.c \
	wsig.c \
	whector.c \
	wcecil.c \
	wbits.c \
	wfile.c \
	wdir.c \
	wstring.c \
	wmisc.c \
	wpattern.c \
	werror.c \
	wumain.c \
	wmemory.c \
	wargv.c \
	wboolstr.c \
	wsearch.c \
	wrun_idr.c \
	wpath_name.c \
	wdle.c \
	wobject_id.c \
	weif_threads.c \
	wmain.c \
	wexcept.c \
	weif_project.c \
	wgen_conf.c \
	wrout_obj.c

ESRC = \
	compress.c \
	console.c \
	wmath.c \
	wmalloc.c \
	wgarcol.c \
	wlocal.c \
	wstore.c \
	wretrieve.c \
	whash.c \
	wtraverse.c \
	whashin.c \
	wtools.c \
	winternal.c \
	wplug.c \
	wcopy.c \
	wequal.c \
	wlmalloc.c \
	wout.c \
	wtimer.c \
	wurgent.c \
	wsig.c \
	whector.c \
	wcecil.c \
	wbits.c \
	wfile.c \
	wdir.c \
	wstring.c \
	wmisc.c \
	wpattern.c \
	werror.c \
	wumain.c \
	wmemory.c \
	wargv.c \
	wboolstr.c \
	wsearch.c \
	wrun_idr.c \
	wpath_name.c \
	wdle.c \
	wobject_id.c \
	weif_threads.c \
	bmain.c \
	bexcept.c \
	weif_project.c \
	wgen_conf.c \
	wrout_obj.c


LOBJ = \
	eif_once.o \
	compress.o \
	console.o \
	option.o \
	math.o \
	malloc.o \
	garcol.o \
	local.o \
	store.o \
	retrieve.o \
	hash.o \
	traverse.o \
	hashin.o \
	tools.o \
	internal.o \
	plug.o \
	copy.o \
	equal.o \
	lmalloc.o \
	out.o \
	timer.o \
	urgent.o \
	sig.o \
	hector.o \
	cecil.o \
	bits.o \
	file.o \
	dir.o \
	string.o \
	misc.o \
	pattern.o \
	error.o \
	umain.o \
	memory.o \
	argv.o \
	boolstr.o \
	search.o \
	run_idr.o \
	path_name.o \
	dle.o \
	object_id.o \
	eif_threads.o \
	main.o \
	except.o \
	eif_project.o \
	gen_conf.o \
	rout_obj.o

WOBJ = \
	$(NETWORK) \
	eif_once.o \
	compress.o \
	console.o \
	woption.o \
	wmath.o \
	wmalloc.o \
	wgarcol.o \
	wlocal.o \
	wstore.o \
	wretrieve.o \
	whash.o \
	wtraverse.o \
	whashin.o \
	wtools.o \
	winternal.o \
	wplug.o \
	wcopy.o \
	wequal.o \
	wlmalloc.o \
	wout.o \
	wtimer.o \
	wurgent.o \
	wsig.o \
	whector.o \
	wcecil.o \
	wbits.o \
	wfile.o \
	wdir.o \
	wstring.o \
	wmisc.o \
	wpattern.o \
	werror.o \
	wumain.o \
	wmemory.o \
	wargv.o \
	wboolstr.o \
	wsearch.o \
	wrun_idr.o \
	wpath_name.o \
	wdle.o \
	wobject_id.o \
	weif_threads.o \
	wmain.o \
	wexcept.o \
	debug.o \
	interp.o \
	update.o \
	wbench.o \
	weif_project.o \
	wgen_conf.o \
	wrout_obj.o

EOBJ = \
	woption.o \
	eif_once.o \
	compress.o \
	console.o \
	wmath.o \
	wmalloc.o \
	wgarcol.o \
	wlocal.o \
	wstore.o \
	wretrieve.o \
	whash.o \
	wtraverse.o \
	whashin.o \
	wtools.o \
	winternal.o \
	wplug.o \
	wcopy.o \
	wequal.o \
	wlmalloc.o \
	wout.o \
	wtimer.o \
	wurgent.o \
	wsig.o \
	whector.o \
	wcecil.o \
	wbits.o \
	wfile.o \
	wdir.o \
	wstring.o \
	wmisc.o \
	wpattern.o \
	werror.o \
	wumain.o \
	wmemory.o \
	wargv.o \
	wboolstr.o \
	wsearch.o \
	wrun_idr.o \
	wpath_name.o \
	wdle.o \
	wobject_id.o \
	weif_threads.o \
	bmain.o \
	bexcept.o \
	debug.o \
	interp.o \
	update.o \
	wbench.o  \
	weif_project.o \
	wgen_conf.o \
	wrout_obj.o

all:: eif_size.h

local_realclean::
	$(RM) eif_size.h

eif_size.h: eif_size_h.SH
	/bin/sh eif_size_h.SH

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

install.man:: size_h.man
	$(INSTALL) -c -m 444 size_h.man $(MANSRC)/eif_size.h.$(L)

deinstall.man::
	$(RM) $(MANSRC)/eif_size.h.$(L)

all:: libfinalized.a

local_realclean::
	$(RM) libfinalized.a

libfinalized.a: $(LOBJ)
	$(RM) $@
	$(AR) $@ $(LOBJ)
	$(RANLIB) $@

all:: libwkbench.a

local_realclean::
	$(RM) libwkbench.a

libwkbench.a: $(WOBJ)
	$(RM) $@
	$(AR) $@ $(WOBJ)
	$(RANLIB) $@

all:: libebench.a

local_realclean::
	$(RM) libebench.a

libebench.a: $(EOBJ)
	$(RM) $@
	$(AR) $@ $(EOBJ)
	$(RANLIB) $@

all:: x2c

local_realclean::
	$(RM) x2c

x2c: x2c.o
	$(RM) $@
	if test -f $@; then $(MV) $@ $@~; else exit 0; fi
	$(CC) -o $@ x2c.o $(JLDFLAGS) $(LIBS)

all:: eif_config.h eif_portable.h eif_confmagic.h

local_realclean::
	$(RM) eif_config.h eif_portable.h eif_confmagic.h

eif_config.h: $(TOP)/eif_config.h
	$(RM) $@
	$(LN) $(TOP)/eif_config.h .

eif_confmagic.h: $(TOP)/eif_confmagic.h
	$(RM) $@
	$(LN) $(TOP)/eif_confmagic.h .

eif_portable.h: $(TOP)/eif_portable.h
	$(RM) $@
	$(LN) $(TOP)/eif_portable.h .

depend:: ../mkdep

../mkdep:
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

wmath.c: math.c
	$(RM) wmath.c
	$(LN) math.c wmath.c
remove::
	$(RM) wmath.c

wmalloc.c: malloc.c
	$(RM) wmalloc.c
	$(LN) malloc.c wmalloc.c
remove::
	$(RM) wmalloc.c

wgarcol.c: garcol.c
	$(RM) wgarcol.c
	$(LN) garcol.c wgarcol.c
remove::
	$(RM) wgarcol.c

wlocal.c: local.c
	$(RM) wlocal.c
	$(LN) local.c wlocal.c
remove::
	$(RM) wlocal.c

wstore.c: store.c
	$(RM) wstore.c
	$(LN) store.c wstore.c
remove::
	$(RM) wstore.c

wretrieve.c: retrieve.c
	$(RM) wretrieve.c
	$(LN) retrieve.c wretrieve.c
remove::
	$(RM) wretrieve.c

whash.c: hash.c
	$(RM) whash.c
	$(LN) hash.c whash.c
remove::
	$(RM) whash.c

wtraverse.c: traverse.c
	$(RM) wtraverse.c
	$(LN) traverse.c wtraverse.c
remove::
	$(RM) wtraverse.c

whashin.c: hashin.c
	$(RM) whashin.c
	$(LN) hashin.c whashin.c
remove::
	$(RM) whashin.c

wtools.c: tools.c
	$(RM) wtools.c
	$(LN) tools.c wtools.c
remove::
	$(RM) wtools.c

winternal.c: internal.c
	$(RM) winternal.c
	$(LN) internal.c winternal.c
remove::
	$(RM) winternal.c

wplug.c: plug.c
	$(RM) wplug.c
	$(LN) plug.c wplug.c
remove::
	$(RM) wplug.c

wcopy.c: copy.c
	$(RM) wcopy.c
	$(LN) copy.c wcopy.c
remove::
	$(RM) wcopy.c

wequal.c: equal.c
	$(RM) wequal.c
	$(LN) equal.c wequal.c
remove::
	$(RM) wequal.c

wlmalloc.c: lmalloc.c
	$(RM) wlmalloc.c
	$(LN) lmalloc.c wlmalloc.c
remove::
	$(RM) wlmalloc.c

wout.c: out.c
	$(RM) wout.c
	$(LN) out.c wout.c
remove::
	$(RM) wout.c

wtimer.c: timer.c
	$(RM) wtimer.c
	$(LN) timer.c wtimer.c
remove::
	$(RM) wtimer.c

wurgent.c: urgent.c
	$(RM) wurgent.c
	$(LN) urgent.c wurgent.c
remove::
	$(RM) wurgent.c

wsig.c: sig.c
	$(RM) wsig.c
	$(LN) sig.c wsig.c
remove::
	$(RM) wsig.c

whector.c: hector.c
	$(RM) whector.c
	$(LN) hector.c whector.c
remove::
	$(RM) whector.c

wcecil.c: cecil.c
	$(RM) wcecil.c
	$(LN) cecil.c wcecil.c
remove::
	$(RM) wcecil.c

wbits.c: bits.c
	$(RM) wbits.c
	$(LN) bits.c wbits.c
remove::
	$(RM) wbits.c

wfile.c: file.c
	$(RM) wfile.c
	$(LN) file.c wfile.c
remove::
	$(RM) wfile.c

wdir.c: dir.c
	$(RM) wdir.c
	$(LN) dir.c wdir.c
remove::
	$(RM) wdir.c

wstring.c: string.c
	$(RM) wstring.c
	$(LN) string.c wstring.c
remove::
	$(RM) wstring.c

wmisc.c: misc.c
	$(RM) wmisc.c
	$(LN) misc.c wmisc.c
remove::
	$(RM) wmisc.c

wpattern.c: pattern.c
	$(RM) wpattern.c
	$(LN) pattern.c wpattern.c
remove::
	$(RM) wpattern.c

werror.c: error.c
	$(RM) werror.c
	$(LN) error.c werror.c
remove::
	$(RM) werror.c

wumain.c: umain.c
	$(RM) wumain.c
	$(LN) umain.c wumain.c
remove::
	$(RM) wumain.c

wmemory.c: memory.c
	$(RM) wmemory.c
	$(LN) memory.c wmemory.c
remove::
	$(RM) wmemory.c

wargv.c: argv.c
	$(RM) wargv.c
	$(LN) argv.c wargv.c
remove::
	$(RM) wargv.c

wboolstr.c: boolstr.c
	$(RM) wboolstr.c
	$(LN) boolstr.c wboolstr.c
remove::
	$(RM) wboolstr.c

wsearch.c: search.c
	$(RM) wsearch.c
	$(LN) search.c wsearch.c
remove::
	$(RM) wsearch.c

wrun_idr.c: run_idr.c
	$(RM) wrun_idr.c
	$(LN) run_idr.c wrun_idr.c
remove::
	$(RM) wrun_idr.c

wpath_name.c: path_name.c
	$(RM) wpath_name.c
	$(LN) path_name.c wpath_name.c
remove::
	$(RM) wpath_name.c

wdle.c: dle.c
	$(RM) wdle.c
	$(LN) dle.c wdle.c
remove::
	$(RM) wdle.c

wobject_id.c: object_id.c
	$(RM) wobject_id.c
	$(LN) object_id.c wobject_id.c
remove::
	$(RM) wobject_id.c

weif_threads.c: eif_threads.c
	$(RM) weif_threads.c
	$(LN) eif_threads.c weif_threads.c
remove::
	$(RM) weif_threads.c

wgen_conf.c: gen_conf.c
	$(RM) wgen_conf.c
	$(LN) gen_conf.c wgen_conf.c
remove::
	$(RM) wgen_conf.c

wrout_obj.c: rout_obj.c
	$(RM) wrout_obj.c
	$(LN) rout_obj.c wrout_obj.c
remove::
	$(RM) wrout_obj.c

wmain.c: main.c
	$(RM) wmain.c
	$(LN) main.c wmain.c
remove::
	$(RM) wmain.c

wexcept.c: except.c
	$(RM) wexcept.c
	$(LN) except.c wexcept.c
remove::
	$(RM) wexcept.c

woption.c: option.c
	$(RM) woption.c
	$(LN) option.c woption.c
remove::
	$(RM) woption.c

weif_project.c: eif_project.c
	$(RM) weif_project.c
	$(LN) eif_project.c weif_project.c
remove::
	$(RM) weif_project.c

weif_project.o: weif_project.c
	$(CC) -c $(JCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

woption.o: woption.c
	$(CC) -c $(JCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

wmath.o: wmath.c
	$(CC) -c $(JCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

wmalloc.o: wmalloc.c
	$(CC) -c $(JCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

wgarcol.o: wgarcol.c
	$(CC) -c $(JCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

wlocal.o: wlocal.c
	$(CC) -c $(JCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

wstore.o: wstore.c
	$(CC) -c $(JCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

wretrieve.o: wretrieve.c
	$(CC) -c $(JCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

whash.o: whash.c
	$(CC) -c $(JCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

wtraverse.o: wtraverse.c
	$(CC) -c $(JCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

whashin.o: whashin.c
	$(CC) -c $(JCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

wtools.o: wtools.c
	$(CC) -c $(JCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

winternal.o: winternal.c
	$(CC) -c $(JCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

wplug.o: wplug.c
	$(CC) -c $(JCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

wcopy.o: wcopy.c
	$(CC) -c $(JCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

wequal.o: wequal.c
	$(CC) -c $(JCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

wlmalloc.o: wlmalloc.c
	$(CC) -c $(JCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

wout.o: wout.c
	$(CC) -c $(JCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

wtimer.o: wtimer.c
	$(CC) -c $(JCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

wurgent.o: wurgent.c
	$(CC) -c $(JCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

wsig.o: wsig.c
	$(CC) -c $(JCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

whector.o: whector.c
	$(CC) -c $(JCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

wcecil.o: wcecil.c
	$(CC) -c $(JCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

wbits.o: wbits.c
	$(CC) -c $(JCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

wfile.o: wfile.c
	$(CC) -c $(JCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

wdir.o: wdir.c
	$(CC) -c $(JCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

wstring.o: wstring.c
	$(CC) -c $(JCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

wmisc.o: wmisc.c
	$(CC) -c $(JCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

wpattern.o: wpattern.c
	$(CC) -c $(JCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

werror.o: werror.c
	$(CC) -c $(JCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

wumain.o: wumain.c
	$(CC) -c $(JCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

wmemory.o: wmemory.c
	$(CC) -c $(JCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

wargv.o: wargv.c
	$(CC) -c $(JCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

wboolstr.o: wboolstr.c
	$(CC) -c $(JCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

wsearch.o: wsearch.c
	$(CC) -c $(JCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

wrun_idr.o: wrun_idr.c
	$(CC) -c $(JCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

wpath_name.o: wpath_name.c
	$(CC) -c $(JCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

wdle.o: wdle.c
	$(CC) -c $(JCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

wobject_id.o: wobject_id.c
	$(CC) -c $(JCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

weif_threads.o: weif_threads.c
	$(CC) -c $(JCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

wgen_conf.o: wgen_conf.c
	$(CC) -c $(JCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

wrout_obj.o: wrout_obj.c
	$(CC) -c $(JCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

wmain.o: wmain.c
	$(CC) -c $(JCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

wexcept.o: wexcept.c
	$(CC) -c $(JCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c


debug.o: debug.c
	$(CC) -c $(JCFLAGS) -DWORKBENCH $*.c

interp.o: interp.c
	$(CC) -c $(JCFLAGS) -DWORKBENCH $*.c

update.o: update.c
	$(CC) -c $(JCFLAGS) -DWORKBENCH $*.c

wbench.o: wbench.c
	$(CC) -c $(JCFLAGS) -DWORKBENCH $*.c


local_clean:: remove

final: libfinalized.a
work: libwkbench.a

.FORCE:

../ipc/app/network.o: .FORCE
	@echo "Checking "network.o" in "../ipc/app"..."
	cd ../ipc/app; $(MAKE) network.o
	@echo "Continuing in $(CURRENT)..."

network.o: ../ipc/app/network.o

network.o:
	$(RM) network.o
	$(LN) $(NETWORK_OBJ) $@

bmain.c: main.c
	$(RM) bmain.c
	$(LN) main.c bmain.c
remove::
	$(RM) bmain.c

bexcept.c: except.c
	$(RM) bexcept.c
	$(LN) except.c bexcept.c
remove::
	$(RM) bexcept.c


bmain.o: bmain.c
	$(CC) -c $(JCFLAGS) -DWORKBENCH -DNOHOOK $*.c
	$(RM) $*.c

bexcept.o: bexcept.c
	$(CC) -c $(JCFLAGS) -DWORKBENCH -DNOHOOK $*.c
	$(RM) $*.c


TESTS = mram gram lram eram sram

test: $(TESTS)
	mram >test 2>&1
	gram >>test 2>&1
	lram >>test 2>&1
	eram >>test 2>&1
	sram >>test 2>&1

mram: malloc.c
	$(CC) $(JCFLAGS) -DTEST  -o $@ malloc.c

gram: garcol.c
	$(CC) $(JCFLAGS) -DTEST  -o $@ garcol.c

lram: local.c
	$(CC) $(JCFLAGS) -DTEST  -o $@ local.c

eram: except.c
	$(CC) $(JCFLAGS) -DTEST  -o $@ except.c

sram: sig.c
	$(CC) $(JCFLAGS) -DTEST  -o $@ sig.c

local_realclean::
	$(RM) $(TESTS)

local_clobber::
	$(RM) test

########################################################################
# Common rules for all Makefiles -- do not edit

emptyrule::

clean: local_clean
realclean: local_realclean
clobber: local_clobber

local_clean::
	$(RM) core *~ *.o

local_realclean:: local_clean
	$(RM) -r UU

local_clobber:: local_realclean
	$(RM) config.sh eif_config.h
	$(RM) -r .config
	$(RM) Makefile

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

