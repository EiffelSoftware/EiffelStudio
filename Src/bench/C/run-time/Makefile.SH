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
LD=$ld
CC = $cc
CTAGS = ctags
JCFLAGS = \$(CFLAGS) $optimize $ccflags $large
JMTCFLAGS = \$(CFLAGS) $optimize $mtccflags $large
JLDFLAGS = \$(LDFLAGS) $optimize $ldflags
SHAREDEIFLIB = $prefix$eiflib$sharedsuffix
SHAREDWKEIFLIB = $prefix$wkeiflib$sharedsuffix
LDSHAREDFLAGS = $ldsharedflags
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
OBJECTS =  \$(LOBJ) \$(WOBJ) \(MT_WOBJ) \$(MT_LOBJ) \$(EOBJ)  x2c.o 
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
MTNETWORK_OBJ = ../ipc/app/MTnetwork.o

LSRC = math.c malloc.c garcol.c local.c store.c retrieve.c \
	hash.c traverse.c hashin.c tools.c internal.c plug.c \
	copy.c equal.c lmalloc.c out.c timer.c urgent.c sig.c \
	hector.c cecil.c bits.c file.c dir.c string.c misc.c \
	pattern.c error.c umain.c memory.c argv.c boolstr.c search.c \
	run_idr.c path_name.c dle.c object_id.c eif_threads.c eif_project.c\
	eif_rw_lock.c \
	gen_conf.c rout_obj.c

OTHER = main.c except.c

WADD = debug.c interp.c update.c wbench.c

NETWORK = network.o

MTNETWORK = MTnetwork.o

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
	eif_rw_lock.c \
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
	eif_rw_lock.c \
	wgen_conf.c \
	wrout_obj.c


MT_LOBJ = \
	MTeif_once.o \
	MTcompress.o \
	MTconsole.o \
	MToption.o \
	MTmath.o \
	MTmalloc.o \
	MTgarcol.o \
	MTlocal.o \
	MTstore.o \
	MTretrieve.o \
	MThash.o \
	MTtraverse.o \
	MThashin.o \
	MTtools.o \
	MTinternal.o \
	MTplug.o \
	MTcopy.o \
	MTequal.o \
	MTlmalloc.o \
	MTout.o \
	MTtimer.o \
	MTurgent.o \
	MTsig.o \
	MThector.o \
	MTcecil.o \
	MTbits.o \
	MTfile.o \
	MTdir.o \
	MTstring.o \
	MTmisc.o \
	MTpattern.o \
	MTerror.o \
	MTumain.o \
	MTmemory.o \
	MTargv.o \
	MTboolstr.o \
	MTsearch.o \
	MTrun_idr.o \
	MTpath_name.o \
	MTdle.o \
	MTobject_id.o \
	MTeif_threads.o \
	MTmain.o \
	MTexcept.o \
	MTeif_project.o \
	MTeif_rw_lock.o \
	MTgen_conf.o \
	MTrout_obj.o

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
	eif_rw_lock.o \
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
	eif_rw_lock.o \
	wgen_conf.o \
	wrout_obj.o

MT_WOBJ = \
	$(MTNETWORK) \
	MTeif_once.o \
	MTcompress.o \
	MTconsole.o \
	MTwoption.o \
	MTwmath.o \
	MTwmalloc.o \
	MTwgarcol.o \
	MTwlocal.o \
	MTwstore.o \
	MTwretrieve.o \
	MTwhash.o \
	MTwtraverse.o \
	MTwhashin.o \
	MTwtools.o \
	MTwinternal.o \
	MTwplug.o \
	MTwcopy.o \
	MTwequal.o \
	MTwlmalloc.o \
	MTwout.o \
	MTwtimer.o \
	MTwurgent.o \
	MTwsig.o \
	MTwhector.o \
	MTwcecil.o \
	MTwbits.o \
	MTwfile.o \
	MTwdir.o \
	MTwstring.o \
	MTwmisc.o \
	MTwpattern.o \
	MTwerror.o \
	MTwumain.o \
	MTwmemory.o \
	MTwargv.o \
	MTwboolstr.o \
	MTwsearch.o \
	MTwrun_idr.o \
	MTwpath_name.o \
	MTwdle.o \
	MTwobject_id.o \
	MTweif_threads.o \
	MTwmain.o \
	MTwexcept.o \
	MTdebug.o \
	MTinterp.o \
	MTupdate.o \
	MTwbench.o \
	MTweif_project.o \
	MTeif_rw_lock.o \
	MTwgen_conf.o \
	MTwrout_obj.o

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
	eif_rw_lock.o \
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

#MT

all:: libmtwkbench.so 

local_realclean::
	$(RM) libmtwkbench.so 

libmtwkbench.so: $(MT_WOBJ)
	$(RM) $@
	$(CC) $(LDSHAREDFLAGS) -o $@ $(MT_WOBJ)

all:: libmtfinalized.so 

local_realclean::
	$(RM) libmtfinalized.so	

libmtfinalized.so: $(MT_LOBJ)
	$(RM) $@
	$(CC) $(LDSHAREDFLAGS) -o $@ $(MT_LOBJ)
	
all:: libmtfinalized.a

local_realclean::
	$(RM) libmtfinalized.a

libmtfinalized.a: $(MT_LOBJ)
	$(RM) $@
	$(AR) $@ $(MT_LOBJ)
	$(RANLIB) $@

all:: libmtwkbench.a

local_realclean::
	$(RM) libmtwkbench.a

libmtwkbench.a: $(MT_WOBJ)
	$(RM) $@
	$(AR) $@ $(MT_WOBJ)
	$(RANLIB) $@

#MT
all:: libwkbench.so 

local_realclean::
	$(RM) libwkbench.so 

libwkbench.so: $(WOBJ)
	$(RM) $@
	$(CC) $(LDSHAREDFLAGS) -o $@ $(WOBJ)

all:: libfinalized.so 

local_realclean::
	$(RM) libfinalized.so	

libfinalized.so: $(LOBJ)
	$(RM) $@
	$(CC) $(LDSHAREDFLAGS) -o $@ $(LOBJ)
	
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

#MT L

MTmath.c: math.c
	$(RM) MTmath.c
	$(LN) math.c MTmath.c
remove::
	$(RM) MTmath.c

MTmalloc.c: malloc.c
	$(RM) MTmalloc.c
	$(LN) malloc.c MTmalloc.c
remove::
	$(RM) MTmalloc.c

MTgarcol.c: garcol.c
	$(RM) MTgarcol.c
	$(LN) garcol.c MTgarcol.c
remove::
	$(RM) MTgarcol.c

MTlocal.c: local.c
	$(RM) MTlocal.c
	$(LN) local.c MTlocal.c
remove::
	$(RM) MTlocal.c

MTstore.c: store.c
	$(RM) MTstore.c
	$(LN) store.c MTstore.c
remove::
	$(RM) MTstore.c

MTretrieve.c: retrieve.c
	$(RM) MTretrieve.c
	$(LN) retrieve.c MTretrieve.c
remove::
	$(RM) MTretrieve.c

MThash.c: hash.c
	$(RM) MThash.c
	$(LN) hash.c MThash.c
remove::
	$(RM) MThash.c

MTtraverse.c: traverse.c
	$(RM) MTtraverse.c
	$(LN) traverse.c MTtraverse.c
remove::
	$(RM) MTtraverse.c

MThashin.c: hashin.c
	$(RM) MThashin.c
	$(LN) hashin.c MThashin.c
remove::
	$(RM) MThashin.c

MTtools.c: tools.c
	$(RM) MTtools.c
	$(LN) tools.c MTtools.c
remove::
	$(RM) MTtools.c

MTinternal.c: internal.c
	$(RM) MTinternal.c
	$(LN) internal.c MTinternal.c
remove::
	$(RM) MTinternal.c

MTplug.c: plug.c
	$(RM) MTplug.c
	$(LN) plug.c MTplug.c
remove::
	$(RM) MTplug.c

MTcopy.c: copy.c
	$(RM) MTcopy.c
	$(LN) copy.c MTcopy.c
remove::
	$(RM) MTcopy.c

MTequal.c: equal.c
	$(RM) MTequal.c
	$(LN) equal.c MTequal.c
remove::
	$(RM) MTequal.c

MTlmalloc.c: lmalloc.c
	$(RM) MTlmalloc.c
	$(LN) lmalloc.c MTlmalloc.c
remove::
	$(RM) MTlmalloc.c

MTout.c: out.c
	$(RM) MTout.c
	$(LN) out.c MTout.c
remove::
	$(RM) MTout.c

MTtimer.c: timer.c
	$(RM) MTtimer.c
	$(LN) timer.c MTtimer.c
remove::
	$(RM) MTtimer.c

MTurgent.c: urgent.c
	$(RM) MTurgent.c
	$(LN) urgent.c MTurgent.c
remove::
	$(RM) MTurgent.c

MTsig.c: sig.c
	$(RM) MTsig.c
	$(LN) sig.c MTsig.c
remove::
	$(RM) MTsig.c

MThector.c: hector.c
	$(RM) MThector.c
	$(LN) hector.c MThector.c
remove::
	$(RM) MThector.c

MTcecil.c: cecil.c
	$(RM) MTcecil.c
	$(LN) cecil.c MTcecil.c
remove::
	$(RM) MTcecil.c

MTbits.c: bits.c
	$(RM) MTbits.c
	$(LN) bits.c MTbits.c
remove::
	$(RM) MTbits.c

MTfile.c: file.c
	$(RM) MTfile.c
	$(LN) file.c MTfile.c
remove::
	$(RM) MTfile.c

MTdir.c: dir.c
	$(RM) MTdir.c
	$(LN) dir.c MTdir.c
remove::
	$(RM) MTdir.c

MTstring.c: string.c
	$(RM) MTstring.c
	$(LN) string.c MTstring.c
remove::
	$(RM) MTstring.c

MTmisc.c: misc.c
	$(RM) MTmisc.c
	$(LN) misc.c MTmisc.c
remove::
	$(RM) MTmisc.c

MTpattern.c: pattern.c
	$(RM) MTpattern.c
	$(LN) pattern.c MTpattern.c
remove::
	$(RM) MTpattern.c

MTerror.c: error.c
	$(RM) MTerror.c
	$(LN) error.c MTerror.c
remove::
	$(RM) MTerror.c

MTumain.c: umain.c
	$(RM) MTumain.c
	$(LN) umain.c MTumain.c
remove::
	$(RM) MTumain.c

MTmemory.c: memory.c
	$(RM) MTmemory.c
	$(LN) memory.c MTmemory.c
remove::
	$(RM) MTmemory.c

MTargv.c: argv.c
	$(RM) MTargv.c
	$(LN) argv.c MTargv.c
remove::
	$(RM) MTargv.c

MTboolstr.c: boolstr.c
	$(RM) MTboolstr.c
	$(LN) boolstr.c MTboolstr.c
remove::
	$(RM) MTboolstr.c

MTsearch.c: search.c
	$(RM) MTsearch.c
	$(LN) search.c MTsearch.c
remove::
	$(RM) MTsearch.c

MTrun_idr.c: run_idr.c
	$(RM) MTrun_idr.c
	$(LN) run_idr.c MTrun_idr.c
remove::
	$(RM) MTrun_idr.c

MTpath_name.c: path_name.c
	$(RM) MTpath_name.c
	$(LN) path_name.c MTpath_name.c
remove::
	$(RM) MTpath_name.c

MTdle.c: dle.c
	$(RM) MTdle.c
	$(LN) dle.c MTdle.c
remove::
	$(RM) MTdle.c

MTobject_id.c: object_id.c
	$(RM) MTobject_id.c
	$(LN) object_id.c MTobject_id.c
remove::
	$(RM) MTobject_id.c

MTeif_once.c: eif_once.c
	$(RM) MTeif_once.c
	$(LN) eif_once.c MTeif_once.c
remove::
	$(RM) MTeif_once.c

MTeif_rw_lock.c: eif_rw_lock.c
	$(RM) MTeif_rw_lock.c
	$(LN) eif_rw_lock.c MTeif_rw_lock.c
remove::
	$(RM) MTeif_rw_lock.c

MTeif_threads.c: eif_threads.c
	$(RM) MTeif_threads.c
	$(LN) eif_threads.c MTeif_threads.c
remove::
	$(RM) MTeif_threads.c

MTgen_conf.c: gen_conf.c
	$(RM) MTgen_conf.c
	$(LN) gen_conf.c MTgen_conf.c
remove::
	$(RM) MTgen_conf.c

MTrout_obj.c: rout_obj.c
	$(RM) MTrout_obj.c
	$(LN) rout_obj.c MTrout_obj.c
remove::
	$(RM) MTrout_obj.c

MTmain.c: main.c
	$(RM) MTmain.c
	$(LN) main.c MTmain.c
remove::
	$(RM) MTmain.c

MTexcept.c: except.c
	$(RM) MTexcept.c
	$(LN) except.c MTexcept.c
remove::
	$(RM) MTexcept.c

MToption.c: option.c
	$(RM) MToption.c
	$(LN) option.c MToption.c
remove::
	$(RM) MToption.c

MTeif_project.c: eif_project.c
	$(RM) MTeif_project.c
	$(LN) eif_project.c MTeif_project.c
remove::
	$(RM) MTeif_project.c

MTeif_project.o: MTeif_project.c
	$(CC) -c $(JMTCFLAGS)  $*.c
	$(RM) $*.c

MToption.o: MToption.c
	$(CC) -c $(JMTCFLAGS)  $*.c
	$(RM) $*.c

MTmath.o: MTmath.c
	$(CC) -c $(JMTCFLAGS)  $*.c
	$(RM) $*.c

MTmalloc.o: MTmalloc.c
	$(CC) -c $(JMTCFLAGS)  $*.c
	$(RM) $*.c

MTgarcol.o: MTgarcol.c
	$(CC) -c $(JMTCFLAGS)  $*.c
	$(RM) $*.c

MTlocal.o: MTlocal.c
	$(CC) -c $(JMTCFLAGS)  $*.c
	$(RM) $*.c

MTstore.o: MTstore.c
	$(CC) -c $(JMTCFLAGS)  $*.c
	$(RM) $*.c

MTretrieve.o: MTretrieve.c
	$(CC) -c $(JMTCFLAGS)  $*.c
	$(RM) $*.c

MThash.o: MThash.c
	$(CC) -c $(JMTCFLAGS)  $*.c
	$(RM) $*.c

MTtraverse.o: MTtraverse.c
	$(CC) -c $(JMTCFLAGS)  $*.c
	$(RM) $*.c

MThashin.o: MThashin.c
	$(CC) -c $(JMTCFLAGS)  $*.c
	$(RM) $*.c

MTtools.o: MTtools.c
	$(CC) -c $(JMTCFLAGS)  $*.c
	$(RM) $*.c

MTinternal.o: MTinternal.c
	$(CC) -c $(JMTCFLAGS)  $*.c
	$(RM) $*.c

MTplug.o: MTplug.c
	$(CC) -c $(JMTCFLAGS)  $*.c
	$(RM) $*.c

MTcopy.o: MTcopy.c
	$(CC) -c $(JMTCFLAGS)  $*.c
	$(RM) $*.c

MTequal.o: MTequal.c
	$(CC) -c $(JMTCFLAGS)  $*.c
	$(RM) $*.c

MTlmalloc.o: MTlmalloc.c
	$(CC) -c $(JMTCFLAGS)  $*.c
	$(RM) $*.c

MTout.o: MTout.c
	$(CC) -c $(JMTCFLAGS)  $*.c
	$(RM) $*.c

MTtimer.o: MTtimer.c
	$(CC) -c $(JMTCFLAGS)  $*.c
	$(RM) $*.c

MTurgent.o: MTurgent.c
	$(CC) -c $(JMTCFLAGS)  $*.c
	$(RM) $*.c

MTsig.o: MTsig.c
	$(CC) -c $(JMTCFLAGS)  $*.c
	$(RM) $*.c

MThector.o: MThector.c
	$(CC) -c $(JMTCFLAGS)  $*.c
	$(RM) $*.c

MTcecil.o: MTcecil.c
	$(CC) -c $(JMTCFLAGS)  $*.c
	$(RM) $*.c

MTbits.o: MTbits.c
	$(CC) -c $(JMTCFLAGS)  $*.c
	$(RM) $*.c

MTfile.o: MTfile.c
	$(CC) -c $(JMTCFLAGS)  $*.c
	$(RM) $*.c

MTdir.o: MTdir.c
	$(CC) -c $(JMTCFLAGS)  $*.c
	$(RM) $*.c

MTstring.o: MTstring.c
	$(CC) -c $(JMTCFLAGS)  $*.c
	$(RM) $*.c

MTmisc.o: MTmisc.c
	$(CC) -c $(JMTCFLAGS)  $*.c
	$(RM) $*.c

MTpattern.o: MTpattern.c
	$(CC) -c $(JMTCFLAGS)  $*.c
	$(RM) $*.c

MTerror.o: MTerror.c
	$(CC) -c $(JMTCFLAGS)  $*.c
	$(RM) $*.c

MTumain.o: MTumain.c
	$(CC) -c $(JMTCFLAGS)  $*.c
	$(RM) $*.c

MTmemory.o: MTmemory.c
	$(CC) -c $(JMTCFLAGS)  $*.c
	$(RM) $*.c

MTargv.o: MTargv.c
	$(CC) -c $(JMTCFLAGS)  $*.c
	$(RM) $*.c

MTboolstr.o: MTboolstr.c
	$(CC) -c $(JMTCFLAGS)  $*.c
	$(RM) $*.c

MTsearch.o: MTsearch.c
	$(CC) -c $(JMTCFLAGS)  $*.c
	$(RM) $*.c

MTrun_idr.o: MTrun_idr.c
	$(CC) -c $(JMTCFLAGS)  $*.c
	$(RM) $*.c

MTpath_name.o: MTpath_name.c
	$(CC) -c $(JMTCFLAGS)  $*.c
	$(RM) $*.c

MTdle.o: MTdle.c
	$(CC) -c $(JMTCFLAGS)  $*.c
	$(RM) $*.c

MTobject_id.o: MTobject_id.c
	$(CC) -c $(JMTCFLAGS)  $*.c
	$(RM) $*.c

MTeif_rw_lock.o: MTeif_rw_lock.c
	$(CC) -c $(JMTCFLAGS)  $*.c
	$(RM) $*.c

MTeif_threads.o: MTeif_threads.c
	$(CC) -c $(JMTCFLAGS)  $*.c
	$(RM) $*.c

MTeif_once.o: MTeif_once.c
	$(CC) -c $(JMTCFLAGS)  $*.c
	$(RM) $*.c

MTgen_conf.o: MTgen_conf.c
	$(CC) -c $(JMTCFLAGS)  $*.c
	$(RM) $*.c

MTrout_obj.o: MTrout_obj.c
	$(CC) -c $(JMTCFLAGS)  $*.c
	$(RM) $*.c

MTmain.o: MTmain.c
	$(CC) -c $(JMTCFLAGS)  $*.c
	$(RM) $*.c

MTexcept.o: MTexcept.c
	$(CC) -c $(JMTCFLAGS)  $*.c
	$(RM) $*.c


#MT


MTcompress.c: compress.c
	$(RM) MTcompress.c
	$(LN) compress.c MTcompress.c
remove::
	$(RM) MTcompress.c


MTwmath.c: math.c
	$(RM) MTwmath.c
	$(LN) math.c MTwmath.c
remove::
	$(RM) MTwmath.c

MTwmalloc.c: malloc.c
	$(RM) MTwmalloc.c
	$(LN) malloc.c MTwmalloc.c
remove::
	$(RM) MTwmalloc.c

MTwgarcol.c: garcol.c
	$(RM) MTwgarcol.c
	$(LN) garcol.c MTwgarcol.c
remove::
	$(RM) MTwgarcol.c

MTwlocal.c: local.c
	$(RM) MTwlocal.c
	$(LN) local.c MTwlocal.c
remove::
	$(RM) MTwlocal.c

MTwstore.c: store.c
	$(RM) MTwstore.c
	$(LN) store.c MTwstore.c
remove::
	$(RM) MTwstore.c

MTwretrieve.c: retrieve.c
	$(RM) MTwretrieve.c
	$(LN) retrieve.c MTwretrieve.c
remove::
	$(RM) MTwretrieve.c

MTwhash.c: hash.c
	$(RM) MTwhash.c
	$(LN) hash.c MTwhash.c
remove::
	$(RM) MTwhash.c

MTwtraverse.c: traverse.c
	$(RM) MTwtraverse.c
	$(LN) traverse.c MTwtraverse.c
remove::
	$(RM) MTwtraverse.c

MTwhashin.c: hashin.c
	$(RM) MTwhashin.c
	$(LN) hashin.c MTwhashin.c
remove::
	$(RM) MTwhashin.c

MTwtools.c: tools.c
	$(RM) MTwtools.c
	$(LN) tools.c MTwtools.c
remove::
	$(RM) MTwtools.c

MTwinternal.c: internal.c
	$(RM) MTwinternal.c
	$(LN) internal.c MTwinternal.c
remove::
	$(RM) MTwinternal.c

MTwplug.c: plug.c
	$(RM) MTwplug.c
	$(LN) plug.c MTwplug.c
remove::
	$(RM) MTwplug.c

MTwcopy.c: copy.c
	$(RM) MTwcopy.c
	$(LN) copy.c MTwcopy.c
remove::
	$(RM) MTwcopy.c

MTwequal.c: equal.c
	$(RM) MTwequal.c
	$(LN) equal.c MTwequal.c
remove::
	$(RM) MTwequal.c

MTwlmalloc.c: lmalloc.c
	$(RM) MTwlmalloc.c
	$(LN) lmalloc.c MTwlmalloc.c
remove::
	$(RM) MTwlmalloc.c

MTwout.c: out.c
	$(RM) MTwout.c
	$(LN) out.c MTwout.c
remove::
	$(RM) MTwout.c

MTwtimer.c: timer.c
	$(RM) MTwtimer.c
	$(LN) timer.c MTwtimer.c
remove::
	$(RM) MTwtimer.c

MTwurgent.c: urgent.c
	$(RM) MTwurgent.c
	$(LN) urgent.c MTwurgent.c
remove::
	$(RM) MTwurgent.c

MTwsig.c: sig.c
	$(RM) MTwsig.c
	$(LN) sig.c MTwsig.c
remove::
	$(RM) MTwsig.c

MTwhector.c: hector.c
	$(RM) MTwhector.c
	$(LN) hector.c MTwhector.c
remove::
	$(RM) MTwhector.c

MTwcecil.c: cecil.c
	$(RM) MTwcecil.c
	$(LN) cecil.c MTwcecil.c
remove::
	$(RM) MTwcecil.c

MTwbits.c: bits.c
	$(RM) MTwbits.c
	$(LN) bits.c MTwbits.c
remove::
	$(RM) MTwbits.c

MTwfile.c: file.c
	$(RM) MTwfile.c
	$(LN) file.c MTwfile.c
remove::
	$(RM) MTwfile.c

MTwdir.c: dir.c
	$(RM) MTwdir.c
	$(LN) dir.c MTwdir.c
remove::
	$(RM) MTwdir.c

MTwstring.c: string.c
	$(RM) MTwstring.c
	$(LN) string.c MTwstring.c
remove::
	$(RM) MTwstring.c

MTwmisc.c: misc.c
	$(RM) MTwmisc.c
	$(LN) misc.c MTwmisc.c
remove::
	$(RM) MTwmisc.c

MTwpattern.c: pattern.c
	$(RM) MTwpattern.c
	$(LN) pattern.c MTwpattern.c
remove::
	$(RM) MTwpattern.c

MTwerror.c: error.c
	$(RM) MTwerror.c
	$(LN) error.c MTwerror.c
remove::
	$(RM) MTwerror.c

MTwumain.c: umain.c
	$(RM) MTwumain.c
	$(LN) umain.c MTwumain.c
remove::
	$(RM) MTwumain.c

MTwmemory.c: memory.c
	$(RM) MTwmemory.c
	$(LN) memory.c MTwmemory.c
remove::
	$(RM) MTwmemory.c

MTwargv.c: argv.c
	$(RM) MTwargv.c
	$(LN) argv.c MTwargv.c
remove::
	$(RM) MTwargv.c

MTwboolstr.c: boolstr.c
	$(RM) MTwboolstr.c
	$(LN) boolstr.c MTwboolstr.c
remove::
	$(RM) MTwboolstr.c

MTwsearch.c: search.c
	$(RM) MTwsearch.c
	$(LN) search.c MTwsearch.c
remove::
	$(RM) MTwsearch.c

MTwrun_idr.c: run_idr.c
	$(RM) MTwrun_idr.c
	$(LN) run_idr.c MTwrun_idr.c
remove::
	$(RM) MTwrun_idr.c

MTwpath_name.c: path_name.c
	$(RM) MTwpath_name.c
	$(LN) path_name.c MTwpath_name.c
remove::
	$(RM) MTwpath_name.c

MTwdle.c: dle.c
	$(RM) MTwdle.c
	$(LN) dle.c MTwdle.c
remove::
	$(RM) MTwdle.c

MTwobject_id.c: object_id.c
	$(RM) MTwobject_id.c
	$(LN) object_id.c MTwobject_id.c
remove::
	$(RM) MTwobject_id.c

MTweif_threads.c: eif_threads.c
	$(RM) MTweif_threads.c
	$(LN) eif_threads.c MTweif_threads.c
remove::
	$(RM) MTweif_threads.c

MTwgen_conf.c: gen_conf.c
	$(RM) MTwgen_conf.c
	$(LN) gen_conf.c MTwgen_conf.c
remove::
	$(RM) MTwgen_conf.c

MTwrout_obj.c: rout_obj.c
	$(RM) MTwrout_obj.c
	$(LN) rout_obj.c MTwrout_obj.c
remove::
	$(RM) MTwrout_obj.c

MTwmain.c: main.c
	$(RM) MTwmain.c
	$(LN) main.c MTwmain.c
remove::
	$(RM) MTwmain.c

MTwexcept.c: except.c
	$(RM) MTwexcept.c
	$(LN) except.c MTwexcept.c
remove::
	$(RM) MTwexcept.c

MTconsole.c: console.c
	$(RM) MTconsole.c
	$(LN) console.c MTconsole.c
remove::
	$(RM) MTconsole.c

MTwoption.c: option.c
	$(RM) MTwoption.c
	$(LN) option.c MTwoption.c
remove::
	$(RM) MTwoption.c

MTweif_project.c: eif_project.c
	$(RM) MTweif_project.c
	$(LN) eif_project.c MTweif_project.c
remove::
	$(RM) MTweif_project.c

MTdebug.c: debug.c
	$(RM) MTdebug.c
	$(LN) debug.c MTdebug.c
remove::
	$(RM) MTdebug.c

MTinterp.c: interp.c
	$(RM) MTinterp.c
	$(LN) interp.c MTinterp.c
remove::
	$(RM) MTinterp.c

MTupdate.c: update.c
	$(RM) MTupdate.c
	$(LN) update.c MTupdate.c
remove::
	$(RM) MTupdate.c

MTwbench.c: wbench.c
	$(RM) MTwbench.c
	$(LN) wbench.c MTwbench.c
remove::
	$(RM) MTwbench.c

MTweif_project.o: MTweif_project.c
	$(CC) -c $(JMTCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

MTconsole.o: MTconsole.c
	$(CC) -c $(JMTCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

MTwoption.o: MTwoption.c
	$(CC) -c $(JMTCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

MTcompress.o: MTcompress.c
	$(CC) -c $(JMTCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

MTwmath.o: MTwmath.c
	$(CC) -c $(JMTCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

MTwmalloc.o: MTwmalloc.c
	$(CC) -c $(JMTCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

MTwgarcol.o: MTwgarcol.c
	$(CC) -c $(JMTCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

MTwlocal.o: MTwlocal.c
	$(CC) -c $(JMTCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

MTwstore.o: MTwstore.c
	$(CC) -c $(JMTCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

MTwretrieve.o: MTwretrieve.c
	$(CC) -c $(JMTCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

MTwhash.o: MTwhash.c
	$(CC) -c $(JMTCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

MTwtraverse.o: MTwtraverse.c
	$(CC) -c $(JMTCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

MTwhashin.o: MTwhashin.c
	$(CC) -c $(JMTCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

MTwtools.o: MTwtools.c
	$(CC) -c $(JMTCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

MTwinternal.o: MTwinternal.c
	$(CC) -c $(JMTCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

MTwplug.o: MTwplug.c
	$(CC) -c $(JMTCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

MTwcopy.o: MTwcopy.c
	$(CC) -c $(JMTCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

MTwequal.o: MTwequal.c
	$(CC) -c $(JMTCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

MTwlmalloc.o: MTwlmalloc.c
	$(CC) -c $(JMTCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

MTwout.o: MTwout.c
	$(CC) -c $(JMTCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

MTwtimer.o: MTwtimer.c
	$(CC) -c $(JMTCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

MTwurgent.o: MTwurgent.c
	$(CC) -c $(JMTCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

MTwsig.o: MTwsig.c
	$(CC) -c $(JMTCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

MTwhector.o: MTwhector.c
	$(CC) -c $(JMTCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

MTwcecil.o: MTwcecil.c
	$(CC) -c $(JMTCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

MTwbits.o: MTwbits.c
	$(CC) -c $(JMTCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

MTwfile.o: MTwfile.c
	$(CC) -c $(JMTCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

MTwdir.o: MTwdir.c
	$(CC) -c $(JMTCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

MTwstring.o: MTwstring.c
	$(CC) -c $(JMTCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

MTwmisc.o: MTwmisc.c
	$(CC) -c $(JMTCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

MTwpattern.o: MTwpattern.c
	$(CC) -c $(JMTCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

MTwerror.o: MTwerror.c
	$(CC) -c $(JMTCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

MTwumain.o: MTwumain.c
	$(CC) -c $(JMTCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

MTwmemory.o: MTwmemory.c
	$(CC) -c $(JMTCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

MTwargv.o: MTwargv.c
	$(CC) -c $(JMTCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

MTwboolstr.o: MTwboolstr.c
	$(CC) -c $(JMTCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

MTwsearch.o: MTwsearch.c
	$(CC) -c $(JMTCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

MTwrun_idr.o: MTwrun_idr.c
	$(CC) -c $(JMTCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

MTwpath_name.o: MTwpath_name.c
	$(CC) -c $(JMTCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

MTwdle.o: MTwdle.c
	$(CC) -c $(JMTCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

MTwobject_id.o: MTwobject_id.c
	$(CC) -c $(JMTCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

MTweif_threads.o: MTweif_threads.c
	$(CC) -c $(JMTCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

MTwgen_conf.o: MTwgen_conf.c
	$(CC) -c $(JMTCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

MTwrout_obj.o: MTwrout_obj.c
	$(CC) -c $(JMTCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

MTwmain.o: MTwmain.c
	$(CC) -c $(JMTCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c

MTwexcept.o: MTwexcept.c
	$(CC) -c $(JMTCFLAGS) -DWORKBENCH $*.c
	$(RM) $*.c


MTdebug.o: MTdebug.c
	$(CC) -c $(JMTCFLAGS) -DWORKBENCH $*.c

MTinterp.o: MTinterp.c
	$(CC) -c $(JMTCFLAGS) -DWORKBENCH $*.c

MTupdate.o: MTupdate.c
	$(CC) -c $(JMTCFLAGS) -DWORKBENCH $*.c

MTwbench.o: MTwbench.c
	$(CC) -c $(JMTCFLAGS) -DWORKBENCH $*.c



local_clean:: remove
#MT END

shared: sharedfinal sharedwork
mtshared: mtsharedfinal mtsharedwork
sharedfinal: libfinalized.so
mtsharedfinal: libmtfinalized.so
sharedwork: libwkbench.so
mtsharedwork: libmtwkbench.so

static: final work
final: libfinalized.a
mtfinal: libmtfinalized.a
work: libwkbench.a
mtwork: libmtwkbench.a
mt: mtwork mtfinal


link: 
	$(LN) ../config.sh .
	$(LN) ../eif_portable.h .
	$(LN) ../eif_config.h .
	$(LN) ../eif_confmagic.h .

.FORCE:

../ipc/app/network.o: .FORCE
	@echo "Checking "network.o" in "../ipc/app"..."
	cd ../ipc/app; $(MAKE) network.o
	@echo "Continuing in $(CURRENT)..."

network.o: ../ipc/app/network.o

network.o:
	$(RM) network.o
	$(LN) $(NETWORK_OBJ) $@

.FORCE:

../ipc/app/MTnetwork.o: .FORCE
	@echo "Checking "MTnetwork.o" in "../ipc/app"..."
	cd ../ipc/app; $(MAKE) MTnetwork.o
	@echo "Continuing in $(CURRENT)..."

MTnetwork.o: ../ipc/app/MTnetwork.o

MTnetwork.o:
	$(RM) MTnetwork.o
	$(LN) $(MTNETWORK_OBJ) $@

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

