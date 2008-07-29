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
CURRENT=run-time
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

AR = ar rc
CC = $cc
CTAGS = ctags
JCFLAGS = \$(CFLAGS) $optimize $warning_level $ccflags $large
JMTCFLAGS = \$(CFLAGS) $optimize $warning_level $mtccflags $large
JLKFLAGS = \$(LDFLAGS) $ccldflags
LDSHAREDFLAGS = $ldsharedflags
SHAREDLINK= $sharedlink
L = $manext
LIBS = $libs
LINT = lint
LINTFLAGS = \$(CFLAGS)
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

USRINC = $usrinc
OBJECTS =  \$(MT_LOBJ) \$(MT_WOBJ) \$(LOBJ) \$(WOBJ) x2c.o offset.o runtime_validation.o offset.o
SOURCES =  \$(LSRC) \$(WADD) x2c.c runtime_validation.c
LSCRIPTS =  eif_size.h

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

CFLAGS = -I$(TOP) -I. -I$(TOP)/ipc/app -I./include -I$(TOP)/idrs
DPFLAGS = -I$(TOP) -I. -I$(TOP)/ipc/app

LIB_SHARED= $(TOP)/ipc/shared
LIB_IPCNAME= ipc.o
LIB_MTIPCNAME = mtipc.o
LIB_IPC_ARCH = $(LIB_SHARED)/$(LIB_IPCNAME)
LIB_MTIPC_ARCH = $(LIB_SHARED)/$(LIB_MTIPCNAME)

EWB_PROTO_OBJ = $(TOP)/ipc/ewb/wewb_proto.o
MTEWB_PROTO_OBJ = $(TOP)/ipc/ewb/MTwewb_proto.o

IDRS_OBJ = $(TOP)/idrs/idrs.o
MTIDRS_OBJ = $(TOP)/idrs/MTidrs.o
NETWORK_OBJ = $(TOP)/ipc/app/network.o
MTNETWORK_OBJ = $(TOP)/ipc/app/MTnetwork.o

LSRC = malloc.c garcol.c local.c store.c retrieve.c \
	hash.c traverse.c hashin.c tools.c internal.c plug.c \
	copy.c equal.c lmalloc.c out.c timer.c urgent.c sig.c \
	hector.c cecil.c bits.c file.c dir.c misc.c \
	error.c umain.c memory.c argv.c boolstr.c search.c \
	run_idr.c path_name.c object_id.c eif_threads.c eif_project.c \
	eif_rw_lock.c gen_conf.c eif_type_id.c rout_obj.c \
	option.c compress.c console.c offset.c main.c except.c

WADD = debug.c interp.c update.c wbench.c

WOBJ = \
	$(IDRS_OBJ) \
	$(LIB_IPC_ARCH) \
	$(NETWORK_OBJ) \
	debug.o \
	interp.o \
	update.o \
	wbench.o \
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
	wmisc.o \
	werror.o \
	wumain.o \
	wmemory.o \
	wargv.o \
	wboolstr.o \
	wsearch.o \
	wrun_idr.o \
	wpath_name.o \
	wobject_id.o \
	weif_threads.o \
	weif_project.o \
	weif_rw_lock.o \
	wgen_conf.o \
	weif_type_id.o \
	wrout_obj.o \
	woption.o \
	wcompress.o \
	wconsole.o \
	woffset.o \
	wmain.o \
	wexcept.o 

LOBJ = \
	$(IDRS_OBJ) \
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
	misc.o \
	error.o \
	umain.o \
	memory.o \
	argv.o \
	boolstr.o \
	search.o \
	run_idr.o \
	path_name.o \
	object_id.o \
	eif_threads.o \
	eif_project.o \
	eif_rw_lock.o \
	gen_conf.o \
	eif_type_id.o \
	rout_obj.o \
	option.o \
	compress.o \
	console.o \
	offset.o \
	main.o \
	except.o 

MT_WOBJ = \
	$(MTIDRS_OBJ) \
	$(LIB_MTIPC_ARCH) \
	$(MTNETWORK_OBJ) \
	MTdebug.o \
	MTinterp.o \
	MTupdate.o \
	MTwbench.o \
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
	MTwmisc.o \
	MTwerror.o \
	MTwumain.o \
	MTwmemory.o \
	MTwargv.o \
	MTwboolstr.o \
	MTwsearch.o \
	MTwrun_idr.o \
	MTwpath_name.o \
	MTwobject_id.o \
	MTweif_threads.o \
	MTweif_project.o \
	MTweif_rw_lock.o \
	MTwgen_conf.o \
	MTweif_type_id.o \
	MTwrout_obj.o \
	MTwoption.o \
	MTwcompress.o \
	MTwconsole.o \
	MTwoffset.o \
	MTwmain.o \
	MTwexcept.o 

MT_LOBJ = \
	$(MTIDRS_OBJ) \
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
	MTmisc.o \
	MTerror.o \
	MTumain.o \
	MTmemory.o \
	MTargv.o \
	MTboolstr.o \
	MTsearch.o \
	MTrun_idr.o \
	MTpath_name.o \
	MTobject_id.o \
	MTeif_threads.o \
	MTeif_project.o \
	MTeif_rw_lock.o \
	MTgen_conf.o \
	MTeif_type_id.o \
	MTrout_obj.o \
	MToption.o \
	MTcompress.o \
	MTconsole.o \
	MToffset.o \
	MTmain.o \
	MTexcept.o 

wmalloc.o: malloc.c
	       $(CC) -c $(JCFLAGS) -DWORKBENCH $? -o $@

wgarcol.o: garcol.c
	       $(CC) -c $(JCFLAGS) -DWORKBENCH $? -o $@

wlocal.o: local.c
	       $(CC) -c $(JCFLAGS) -DWORKBENCH $? -o $@

wstore.o: store.c
	       $(CC) -c $(JCFLAGS) -DWORKBENCH $? -o $@

wretrieve.o: retrieve.c
	       $(CC) -c $(JCFLAGS) -DWORKBENCH $? -o $@

whash.o: hash.c
	       $(CC) -c $(JCFLAGS) -DWORKBENCH $? -o $@

wtraverse.o: traverse.c
	       $(CC) -c $(JCFLAGS) -DWORKBENCH $? -o $@

whashin.o: hashin.c
	       $(CC) -c $(JCFLAGS) -DWORKBENCH $? -o $@

wtools.o: tools.c
	       $(CC) -c $(JCFLAGS) -DWORKBENCH $? -o $@

winternal.o: internal.c
	       $(CC) -c $(JCFLAGS) -DWORKBENCH $? -o $@

wplug.o: plug.c
	       $(CC) -c $(JCFLAGS) -DWORKBENCH $? -o $@

wcopy.o: copy.c
	       $(CC) -c $(JCFLAGS) -DWORKBENCH $? -o $@

wequal.o: equal.c
	       $(CC) -c $(JCFLAGS) -DWORKBENCH $? -o $@

wlmalloc.o: lmalloc.c
	       $(CC) -c $(JCFLAGS) -DWORKBENCH $? -o $@

wout.o: out.c
	       $(CC) -c $(JCFLAGS) -DWORKBENCH $? -o $@

wtimer.o: timer.c
	       $(CC) -c $(JCFLAGS) -DWORKBENCH $? -o $@

wurgent.o: urgent.c
	       $(CC) -c $(JCFLAGS) -DWORKBENCH $? -o $@

wsig.o: sig.c
	       $(CC) -c $(JCFLAGS) -DWORKBENCH $? -o $@

whector.o: hector.c
	       $(CC) -c $(JCFLAGS) -DWORKBENCH $? -o $@

wcecil.o: cecil.c
	       $(CC) -c $(JCFLAGS) -DWORKBENCH $? -o $@

wbits.o: bits.c
	       $(CC) -c $(JCFLAGS) -DWORKBENCH $? -o $@

wfile.o: file.c
	       $(CC) -c $(JCFLAGS) -DWORKBENCH $? -o $@

wdir.o: dir.c
	       $(CC) -c $(JCFLAGS) -DWORKBENCH $? -o $@

wmisc.o: misc.c
	       $(CC) -c $(JCFLAGS) -DWORKBENCH $? -o $@

werror.o: error.c
	       $(CC) -c $(JCFLAGS) -DWORKBENCH $? -o $@

wumain.o: umain.c
	       $(CC) -c $(JCFLAGS) -DWORKBENCH $? -o $@

wmemory.o: memory.c
	       $(CC) -c $(JCFLAGS) -DWORKBENCH $? -o $@

wargv.o: argv.c
	       $(CC) -c $(JCFLAGS) -DWORKBENCH $? -o $@

wboolstr.o: boolstr.c
	       $(CC) -c $(JCFLAGS) -DWORKBENCH $? -o $@

wsearch.o: search.c
	       $(CC) -c $(JCFLAGS) -DWORKBENCH $? -o $@

wrun_idr.o: run_idr.c
	       $(CC) -c $(JCFLAGS) -DWORKBENCH $? -o $@

wpath_name.o: path_name.c
	       $(CC) -c $(JCFLAGS) -DWORKBENCH $? -o $@

wobject_id.o: object_id.c
	       $(CC) -c $(JCFLAGS) -DWORKBENCH $? -o $@

weif_threads.o: eif_threads.c
	       $(CC) -c $(JCFLAGS) -DWORKBENCH $? -o $@

weif_project.o: eif_project.c
	       $(CC) -c $(JCFLAGS) -DWORKBENCH $? -o $@

weif_rw_lock.o: eif_rw_lock.c
	       $(CC) -c $(JCFLAGS) -DWORKBENCH $? -o $@

wgen_conf.o: gen_conf.c
	       $(CC) -c $(JCFLAGS) -DWORKBENCH $? -o $@

weif_type_id.o: eif_type_id.c
	       $(CC) -c $(JCFLAGS) -DWORKBENCH $? -o $@

wrout_obj.o: rout_obj.c
	       $(CC) -c $(JCFLAGS) -DWORKBENCH $? -o $@

woption.o: option.c
	       $(CC) -c $(JCFLAGS) -DWORKBENCH $? -o $@

wcompress.o: compress.c
	       $(CC) -c $(JCFLAGS) -DWORKBENCH $? -o $@

wconsole.o: console.c
	       $(CC) -c $(JCFLAGS) -DWORKBENCH $? -o $@

woffset.o: offset.c
	       $(CC) -c $(JCFLAGS) -DWORKBENCH $? -o $@

wmain.o: main.c
	       $(CC) -c $(JCFLAGS) -DWORKBENCH $? -o $@

wexcept.o: except.c
	       $(CC) -c $(JCFLAGS) -DWORKBENCH $? -o $@


MTmalloc.o: malloc.c
	       $(CC) -c $(JMTCFLAGS) $? -o $@

MTgarcol.o: garcol.c
	       $(CC) -c $(JMTCFLAGS) $? -o $@

MTlocal.o: local.c
	       $(CC) -c $(JMTCFLAGS) $? -o $@

MTstore.o: store.c
	       $(CC) -c $(JMTCFLAGS) $? -o $@

MTretrieve.o: retrieve.c
	       $(CC) -c $(JMTCFLAGS) $? -o $@

MThash.o: hash.c
	       $(CC) -c $(JMTCFLAGS) $? -o $@

MTtraverse.o: traverse.c
	       $(CC) -c $(JMTCFLAGS) $? -o $@

MThashin.o: hashin.c
	       $(CC) -c $(JMTCFLAGS) $? -o $@

MTtools.o: tools.c
	       $(CC) -c $(JMTCFLAGS) $? -o $@

MTinternal.o: internal.c
	       $(CC) -c $(JMTCFLAGS) $? -o $@

MTplug.o: plug.c
	       $(CC) -c $(JMTCFLAGS) $? -o $@

MTcopy.o: copy.c
	       $(CC) -c $(JMTCFLAGS) $? -o $@

MTequal.o: equal.c
	       $(CC) -c $(JMTCFLAGS) $? -o $@

MTlmalloc.o: lmalloc.c
	       $(CC) -c $(JMTCFLAGS) $? -o $@

MTout.o: out.c
	       $(CC) -c $(JMTCFLAGS) $? -o $@

MTtimer.o: timer.c
	       $(CC) -c $(JMTCFLAGS) $? -o $@

MTurgent.o: urgent.c
	       $(CC) -c $(JMTCFLAGS) $? -o $@

MTsig.o: sig.c
	       $(CC) -c $(JMTCFLAGS) $? -o $@

MThector.o: hector.c
	       $(CC) -c $(JMTCFLAGS) $? -o $@

MTcecil.o: cecil.c
	       $(CC) -c $(JMTCFLAGS) $? -o $@

MTbits.o: bits.c
	       $(CC) -c $(JMTCFLAGS) $? -o $@

MTfile.o: file.c
	       $(CC) -c $(JMTCFLAGS) $? -o $@

MTdir.o: dir.c
	       $(CC) -c $(JMTCFLAGS) $? -o $@

MTmisc.o: misc.c
	       $(CC) -c $(JMTCFLAGS) $? -o $@

MTerror.o: error.c
	       $(CC) -c $(JMTCFLAGS) $? -o $@

MTumain.o: umain.c
	       $(CC) -c $(JMTCFLAGS) $? -o $@

MTmemory.o: memory.c
	       $(CC) -c $(JMTCFLAGS) $? -o $@

MTargv.o: argv.c
	       $(CC) -c $(JMTCFLAGS) $? -o $@

MTboolstr.o: boolstr.c
	       $(CC) -c $(JMTCFLAGS) $? -o $@

MTsearch.o: search.c
	       $(CC) -c $(JMTCFLAGS) $? -o $@

MTrun_idr.o: run_idr.c
	       $(CC) -c $(JMTCFLAGS) $? -o $@

MTpath_name.o: path_name.c
	       $(CC) -c $(JMTCFLAGS) $? -o $@

MTobject_id.o: object_id.c
	       $(CC) -c $(JMTCFLAGS) $? -o $@

MTeif_threads.o: eif_threads.c
	       $(CC) -c $(JMTCFLAGS) $? -o $@

MTeif_project.o: eif_project.c
	       $(CC) -c $(JMTCFLAGS) $? -o $@

MTeif_rw_lock.o: eif_rw_lock.c
	       $(CC) -c $(JMTCFLAGS) $? -o $@

MTgen_conf.o: gen_conf.c
	       $(CC) -c $(JMTCFLAGS) $? -o $@

MTeif_type_id.o: eif_type_id.c
	       $(CC) -c $(JMTCFLAGS) $? -o $@

MTrout_obj.o: rout_obj.c
	       $(CC) -c $(JMTCFLAGS) $? -o $@

MToption.o: option.c
	       $(CC) -c $(JMTCFLAGS) $? -o $@

MTcompress.o: compress.c
	       $(CC) -c $(JMTCFLAGS) $? -o $@

MTconsole.o: console.c
	       $(CC) -c $(JMTCFLAGS) $? -o $@

MToffset.o: offset.c
	       $(CC) -c $(JMTCFLAGS) $? -o $@

MTmain.o: main.c
	       $(CC) -c $(JMTCFLAGS) $? -o $@

MTexcept.o: except.c
	       $(CC) -c $(JMTCFLAGS) $? -o $@


MTwmalloc.o: malloc.c
	       $(CC) -c $(JMTCFLAGS) -DWORKBENCH $? -o $@

MTwgarcol.o: garcol.c
	       $(CC) -c $(JMTCFLAGS) -DWORKBENCH $? -o $@

MTwlocal.o: local.c
	       $(CC) -c $(JMTCFLAGS) -DWORKBENCH $? -o $@

MTwstore.o: store.c
	       $(CC) -c $(JMTCFLAGS) -DWORKBENCH $? -o $@

MTwretrieve.o: retrieve.c
	       $(CC) -c $(JMTCFLAGS) -DWORKBENCH $? -o $@

MTwhash.o: hash.c
	       $(CC) -c $(JMTCFLAGS) -DWORKBENCH $? -o $@

MTwtraverse.o: traverse.c
	       $(CC) -c $(JMTCFLAGS) -DWORKBENCH $? -o $@

MTwhashin.o: hashin.c
	       $(CC) -c $(JMTCFLAGS) -DWORKBENCH $? -o $@

MTwtools.o: tools.c
	       $(CC) -c $(JMTCFLAGS) -DWORKBENCH $? -o $@

MTwinternal.o: internal.c
	       $(CC) -c $(JMTCFLAGS) -DWORKBENCH $? -o $@

MTwplug.o: plug.c
	       $(CC) -c $(JMTCFLAGS) -DWORKBENCH $? -o $@

MTwcopy.o: copy.c
	       $(CC) -c $(JMTCFLAGS) -DWORKBENCH $? -o $@

MTwequal.o: equal.c
	       $(CC) -c $(JMTCFLAGS) -DWORKBENCH $? -o $@

MTwlmalloc.o: lmalloc.c
	       $(CC) -c $(JMTCFLAGS) -DWORKBENCH $? -o $@

MTwout.o: out.c
	       $(CC) -c $(JMTCFLAGS) -DWORKBENCH $? -o $@

MTwtimer.o: timer.c
	       $(CC) -c $(JMTCFLAGS) -DWORKBENCH $? -o $@

MTwurgent.o: urgent.c
	       $(CC) -c $(JMTCFLAGS) -DWORKBENCH $? -o $@

MTwsig.o: sig.c
	       $(CC) -c $(JMTCFLAGS) -DWORKBENCH $? -o $@

MTwhector.o: hector.c
	       $(CC) -c $(JMTCFLAGS) -DWORKBENCH $? -o $@

MTwcecil.o: cecil.c
	       $(CC) -c $(JMTCFLAGS) -DWORKBENCH $? -o $@

MTwbits.o: bits.c
	       $(CC) -c $(JMTCFLAGS) -DWORKBENCH $? -o $@

MTwfile.o: file.c
	       $(CC) -c $(JMTCFLAGS) -DWORKBENCH $? -o $@

MTwdir.o: dir.c
	       $(CC) -c $(JMTCFLAGS) -DWORKBENCH $? -o $@

MTwmisc.o: misc.c
	       $(CC) -c $(JMTCFLAGS) -DWORKBENCH $? -o $@

MTwerror.o: error.c
	       $(CC) -c $(JMTCFLAGS) -DWORKBENCH $? -o $@

MTwumain.o: umain.c
	       $(CC) -c $(JMTCFLAGS) -DWORKBENCH $? -o $@

MTwmemory.o: memory.c
	       $(CC) -c $(JMTCFLAGS) -DWORKBENCH $? -o $@

MTwargv.o: argv.c
	       $(CC) -c $(JMTCFLAGS) -DWORKBENCH $? -o $@

MTwboolstr.o: boolstr.c
	       $(CC) -c $(JMTCFLAGS) -DWORKBENCH $? -o $@

MTwsearch.o: search.c
	       $(CC) -c $(JMTCFLAGS) -DWORKBENCH $? -o $@

MTwrun_idr.o: run_idr.c
	       $(CC) -c $(JMTCFLAGS) -DWORKBENCH $? -o $@

MTwpath_name.o: path_name.c
	       $(CC) -c $(JMTCFLAGS) -DWORKBENCH $? -o $@

MTwobject_id.o: object_id.c
	       $(CC) -c $(JMTCFLAGS) -DWORKBENCH $? -o $@

MTweif_threads.o: eif_threads.c
	       $(CC) -c $(JMTCFLAGS) -DWORKBENCH $? -o $@

MTweif_project.o: eif_project.c
	       $(CC) -c $(JMTCFLAGS) -DWORKBENCH $? -o $@

MTweif_rw_lock.o: eif_rw_lock.c
	       $(CC) -c $(JMTCFLAGS) -DWORKBENCH $? -o $@

MTwgen_conf.o: gen_conf.c
	       $(CC) -c $(JMTCFLAGS) -DWORKBENCH $? -o $@

MTweif_type_id.o: eif_type_id.c
	       $(CC) -c $(JMTCFLAGS) -DWORKBENCH $? -o $@

MTwrout_obj.o: rout_obj.c
	       $(CC) -c $(JMTCFLAGS) -DWORKBENCH $? -o $@

MTwoption.o: option.c
	       $(CC) -c $(JMTCFLAGS) -DWORKBENCH $? -o $@

MTwcompress.o: compress.c
	       $(CC) -c $(JMTCFLAGS) -DWORKBENCH $? -o $@

MTwconsole.o: console.c
	       $(CC) -c $(JMTCFLAGS) -DWORKBENCH $? -o $@

MTwoffset.o: offset.c
	       $(CC) -c $(JMTCFLAGS) -DWORKBENCH $? -o $@

MTwmain.o: main.c
	       $(CC) -c $(JMTCFLAGS) -DWORKBENCH $? -o $@

MTwexcept.o: except.c
	       $(CC) -c $(JMTCFLAGS) -DWORKBENCH $? -o $@


debug.o: debug.c
	$(CC) -c $(JCFLAGS) -DWORKBENCH $? -o $@

interp.o: interp.c
	$(CC) -c $(JCFLAGS) -DWORKBENCH $? -o $@

update.o: update.c
	$(CC) -c $(JCFLAGS) -DWORKBENCH $? -o $@

wbench.o: wbench.c
	$(CC) -c $(JCFLAGS) -DWORKBENCH $? -o $@


MTdebug.o: debug.c
	$(CC) -c $(JMTCFLAGS) -DWORKBENCH $? -o $@

MTinterp.o: interp.c
	$(CC) -c $(JMTCFLAGS) -DWORKBENCH $? -o $@

MTupdate.o: update.c
	$(CC) -c $(JMTCFLAGS) -DWORKBENCH $? -o $@

MTwbench.o: wbench.c
	$(CC) -c $(JMTCFLAGS) -DWORKBENCH $? -o $@


all:: eif_size.h

local_realclean::
	$(RM) eif_size.h

eif_size.h: eif_size_h.SH
	/bin/sh eif_size_h.SH

local_install:: $(SCRIPTS) $(LSCRIPTS)
	@case '${MFLAGS}' in *[i]*) set +e;; esac; \
	(set -x; test -d $(INSTALL_PREFIX)$(SCRIPTDIR) || \
	$(INSTALLDIR) $(INSTALL_PREFIX)$(SCRIPTDIR)); \
	for file in $(SCRIPTS) $(LSCRIPTS); do \
	(set -x; \
	$(INSTALL) -c -m 555 $$file $(INSTALL_PREFIX)$(SCRIPTDIR)) || \
	exit 1; \
	done

local_deinstall::
	@for file in $(SCRIPTS) $(LSCRIPTS); do \
	case '${MFLAGS}' in *[i]*) set +e;; esac; \
	(set -x; $(RM) $(INSTALL_PREFIX)$(SCRIPTDIR)/$$file); \
	done

local_install.man:: eif_size_h.man
	@case '${MFLAGS}' in *[i]*) set +e;; esac; \
	(set -x; test -d $(INSTALL_PREFIX)$(MANSRC) || \
	$(INSTALLDIR) $(INSTALL_PREFIX)$(MANSRC)); \
	$(INSTALL) -c -m 444 eif_size_h.man $(INSTALL_PREFIX)$(MANSRC)/eif_size.h.$(L)

local_deinstall.man::
	$(RM) $(INSTALL_PREFIX)$(MANSRC)/eif_size.h.$(L)

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

all:: libmtfinalized.so

local_realclean::
	$(RM) libmtfinalized.so

libmtfinalized.so: $(MT_LOBJ)
	$(RM) $@
	$(SHAREDLINK) $(LDSHAREDFLAGS) $@ $(MT_LOBJ)

all:: libmtwkbench.so

local_realclean::
	$(RM) libmtwkbench.so

libmtwkbench.so: $(MT_WOBJ)
	$(RM) $@
	$(SHAREDLINK) $(LDSHAREDFLAGS) $@ $(MT_WOBJ)

all:: libfinalized.so

local_realclean::
	$(RM) libfinalized.so

libfinalized.so: $(LOBJ)
	$(RM) $@
	$(SHAREDLINK) $(LDSHAREDFLAGS) $@ $(LOBJ)

all:: libwkbench.so

local_realclean::
	$(RM) libwkbench.so

libwkbench.so: $(WOBJ)
	$(RM) $@
	$(SHAREDLINK) $(LDSHAREDFLAGS) $@ $(WOBJ)

all:: x2c

local_realclean::
	$(RM) x2c

x2c: x2c.o offset.o
	$(RM) $@
	if test -f $@$(_EXE); then \
	$(MV) $@$(_EXE) $@~$(_EXE); fi
	$(CC) -o $@ x2c.o offset.o $(JLKFLAGS) $(LIBS)

all:: runtime_validation

local_realclean::
	$(RM) runtime_validation

runtime_validation: runtime_validation.o offset.o
	$(RM) $@
	if test -f $@$(_EXE); then \
	$(MV) $@$(_EXE) $@~$(_EXE); fi
	$(CC) -o $@ runtime_validation.o offset.o $(JLKFLAGS) $(LIBS)

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
	$(SED) -e 's:/usr/lib[^ ]*::g; s:$(USRINC)[^ ]*::g; ' \
	-e '/: / b print' -e '$$ b print' -e 'H; d; n; : print' \
	-e 'x; s/\\$$//; s/\\\n//g; s/  */ /g; s/ :/:/;' -e '/: *$$/d' \
	) > Makefile.new
	cp Makefile Makefile.bak
	cp Makefile.new Makefile
	$(RM) Makefile.new

lint:
	$(LINT) $(LINTFLAGS) $(SOURCES) $(LINTLIBS)

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
mtebench: libmtebench.a
mt: mtwork mtfinal mtebench

.FORCE:

$(TOP)/ipc/app/network.o: .FORCE
	@echo "Checking "network.o" in "$(TOP)/ipc/app"..."
	cd $(TOP)/ipc/app; $(MAKE) network.o
	@echo "Continuing in $(CURRENT)..."

$(TOP)/idrs/idrs.o: .FORCE
	@echo "Checking "idrs.o" in "$(TOP)/idrs"..."
	cd $(TOP)/idrs; $(MAKE) idrs.o
	@echo "Continuing in $(CURRENT)..."

$(LIB_SHARED)/$(LIB_IPCNAME): .FORCE
	@echo "Checking "$(LIB_IPCNAME)" in "$(LIB_SHARED)"..."
	cd $(LIB_SHARED); $(MAKE) $(LIB_IPCNAME)
	@echo "Continuing in $(CURRENT)..."

$(LIB_SHARED)/$(LIB_MTIPCNAME): .FORCE
	@echo "Checking "$(LIB_MTIPCNAME)" in "$(LIB_SHARED)"..."
	cd $(LIB_SHARED); $(MAKE) $(LIB_MTIPCNAME)
	@echo "Continuing in $(CURRENT)..."

$(TOP)/ipc/ewb/wewb_proto.o: .FORCE
	@echo "Checking "wewb_proto.o" in "$(TOP)/ipc/ewb"..."
	cd $(TOP)/ipc/ewb; $(MAKE) wewb_proto.o
	@echo "Continuing in $(CURRENT)..."

$(TOP)/ipc/ewb/MTwewb_proto.o: .FORCE
	@echo "Checking "MTwewb_proto.o" in "$(TOP)/ipc/ewb"..."
	cd $(TOP)/ipc/ewb; $(MAKE) MTwewb_proto.o
	@echo "Continuing in $(CURRENT)..."

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

