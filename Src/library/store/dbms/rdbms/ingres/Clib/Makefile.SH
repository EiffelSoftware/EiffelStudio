case $CONFIG in
'')
    if test ! -f config.sh; then
        (echo "Can't find config.sh."; exit 1)
    fi 2>/dev/null
    . ./config.sh
    ;;
esac
case "$O" in
*/*) cd `expr X$0 : 'X\(.*\)/'` ;;
esac
echo "Extracting "."/Makefile (with variable substitutions)"
$spitshell >Makefile <<!GROK!THIS!
SHELL = /bin/sh
CC= $cc
AR = ar rc
CFLAGS = $optimize $ccflags $large -I$(ISE_EIFFEL)/studio/spec/$(ISE_PLATFORM)/include
LDFLAGS = $ldflags
LIBS = $libs
MAKE = make
MKDEP = $mkdep $(DPFLAGS) --
MV = $mv
RANLIB = $ranlib
RM = $rm -f

!GROK!THIS!
$spitshell >>Makefile <<'!NO!SUBS!'
.c.o:
	$(CC) $(CFLAGS) -c $<

OBJECTS = ingres.o

libingres_store.a: $(OBJECTS)
	mkdir -p ../../../../spec/$(ISE_PLATFORM)/lib
	$(RM) $@
	$(AR) $@ $(OBJECTS)
	$(MV) $@ ../../../../spec/$(ISE_PLATFORM)/lib
	$(RANLIB) ../../../../spec/$(ISE_PLATFORM)/lib/$@
	$(MAKE) clean

ingres.c:   ingres.sc   ingres.h
	esqlc -w ingres.sc

ingres.o:	ingres.c	ingres.h

clean:
	$(RM) libingres_store.a ingres.c $(OBJECTS) Makefile config.sh
!NO!SUBS!
chmod 644 Makefile
$eunicefix Makefile

