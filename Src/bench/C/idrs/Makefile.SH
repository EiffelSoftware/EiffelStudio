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
CURRENT=idrs
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
JCFLAGS = \$(CFLAGS) $optimize $ccflags $large
JMTCFLAGS = \$(CFLAGS) $optimize $mtccflags $large
LINT = lint
MAKE = make
MKDEP = $mkdep \$(DPFLAGS) --
MV = $mv
RANLIB = $ranlib
RM = $rm -f
LN = $ln
SED = $sed

########################################################################
# Automatically generated parameters -- do not edit

RUN_TIME=../run-time
SOURCES =  \$(LSRC)
OBJECTS =  \$(LOBJ) \$(MT_LOBJ)

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

DPFLAGS = -I$(TOP) -I$(RUN_TIME)
CFLAGS = $(DPFLAGS)

LSRC = \
	idr_double.c \
	idr_float.c \
	idr_array.c \
	idr_char.c \
	idr_getpos.c \
	idr_int.c \
	idr_long.c \
	idr_opaque.c \
	idr_poly.c \
	idr_read.c \
	idr_setpos.c \
	idr_short.c \
	idr_size.c \
	idr_stack.c \
	idr_string.c \
	idr_uchar.c \
	idr_uint.c \
	idr_ulong.c \
	idr_union.c \
	idr_ushort.c \
	idr_vector.c \
	idr_void.c \
	idr_write.c \
	idrf_creat.c \
	idrf_dstry.c \
	idrf_pos.c \
	idrm_creat.c \
	idrm_dstry.c


MT_LOBJ = \
	MTidr_double.o \
	MTidr_float.o \
	MTidr_array.o \
	MTidr_char.o \
	MTidr_getpos.o \
	MTidr_int.o \
	MTidr_long.o \
	MTidr_opaque.o \
	MTidr_poly.o \
	MTidr_read.o \
	MTidr_setpos.o \
	MTidr_short.o \
	MTidr_size.o \
	MTidr_stack.o \
	MTidr_string.o \
	MTidr_uchar.o \
	MTidr_uint.o \
	MTidr_ulong.o \
	MTidr_union.o \
	MTidr_ushort.o \
	MTidr_vector.o \
	MTidr_void.o \
	MTidr_write.o \
	MTidrf_creat.o \
	MTidrf_dstry.o \
	MTidrf_pos.o \
	MTidrm_creat.o \
	MTidrm_dstry.o 

all:: libmtidr.a

local_realclean::
	$(RM) libmtidr.a

libmtidr.a: $(MT_LOBJ)
	$(RM) $@
	$(AR) $@ $(MT_LOBJ)
	$(RANLIB) $@

MTidr_double.o: idr_double.c
	$(CC) -c 	$(JMTCFLAGS)  	$< -o $@

MTidr_float.o: idr_float.c
	$(CC) -c 	$(JMTCFLAGS)  	$< -o $@

MTidr_array.o: idr_array.c
	$(CC) -c 	$(JMTCFLAGS)  	$< -o $@

MTidr_char.o: idr_char.c
	$(CC) -c 	$(JMTCFLAGS)  	$< -o $@

MTidr_getpos.o: idr_getpos.c
	$(CC) -c 	$(JMTCFLAGS)  	$< -o $@

MTidr_int.o: idr_int.c
	$(CC) -c 	$(JMTCFLAGS)  	$< -o $@

MTidrm_dstry.o: idrm_dstry.c
	$(CC) -c 	$(JMTCFLAGS)  	$< -o $@

MTidrm_creat.o: idrm_creat.c
	$(CC) -c 	$(JMTCFLAGS)  	$< -o $@

MTidrf_pos.o: idrf_pos.c
	$(CC) -c 	$(JMTCFLAGS)  	$< -o $@

MTidrf_dstry.o: idrf_dstry.c
	$(CC) -c 	$(JMTCFLAGS)  	$< -o $@

MTidrf_creat.o: idrf_creat.c
	$(CC) -c 	$(JMTCFLAGS)  	$< -o $@

MTidr_write.o: idr_write.c
	$(CC) -c 	$(JMTCFLAGS)  	$< -o $@

MTidr_void.o: idr_void.c
	$(CC) -c 	$(JMTCFLAGS)  	$< -o $@

MTidr_vector.o: idr_vector.c
	$(CC) -c 	$(JMTCFLAGS)  	$< -o $@

MTidr_ushort.o: idr_ushort.c
	$(CC) -c 	$(JMTCFLAGS)  	$< -o $@

MTidr_union.o: idr_union.c
	$(CC) -c 	$(JMTCFLAGS)  	$< -o $@

MTidr_ulong.o: idr_ulong.c
	$(CC) -c 	$(JMTCFLAGS)  	$< -o $@

MTidr_uint.o: idr_uint.c
	$(CC) -c 	$(JMTCFLAGS)  	$< -o $@

MTidr_uchar.o: idr_uchar.c
	$(CC) -c 	$(JMTCFLAGS)  	$< -o $@

MTidr_string.o: idr_string.c
	$(CC) -c 	$(JMTCFLAGS)  	$< -o $@

MTidr_stack.o: idr_stack.c
	$(CC) -c 	$(JMTCFLAGS)  	$< -o $@

MTidr_size.o: idr_size.c
	$(CC) -c 	$(JMTCFLAGS)  	$< -o $@

MTidr_short.o: idr_short.c
	$(CC) -c 	$(JMTCFLAGS)  	$< -o $@

MTidr_setpos.o: idr_setpos.c
	$(CC) -c 	$(JMTCFLAGS)  	$< -o $@

MTidr_read.o: idr_read.c
	$(CC) -c 	$(JMTCFLAGS)  	$< -o $@

MTidr_poly.o: idr_poly.c
	$(CC) -c 	$(JMTCFLAGS)  	$< -o $@

MTidr_opaque.o: idr_opaque.c
	$(CC) -c 	$(JMTCFLAGS)  	$< -o $@

MTidr_long.o: idr_long.c
	$(CC) -c 	$(JMTCFLAGS)  	$< -o $@

LOBJ = \
	idr_double.o \
	idr_float.o \
	idr_array.o \
	idr_char.o \
	idr_getpos.o \
	idr_int.o \
	idr_long.o \
	idr_opaque.o \
	idr_poly.o \
	idr_read.o \
	idr_setpos.o \
	idr_short.o \
	idr_size.o \
	idr_stack.o \
	idr_string.o \
	idr_uchar.o \
	idr_uint.o \
	idr_ulong.o \
	idr_union.o \
	idr_ushort.o \
	idr_vector.o \
	idr_void.o \
	idr_write.o \
	idrf_creat.o \
	idrf_dstry.o \
	idrf_pos.o \
	idrm_creat.o \
	idrm_dstry.o 

all:: libidr.a

local_realclean::
	$(RM) libidr.a

libidr.a: $(LOBJ)
	$(RM) $@
	$(AR) $@ $(LOBJ)
	$(RANLIB) $@

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

