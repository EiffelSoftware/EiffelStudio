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
CC= cc
CFLAGS = $optimize $ccflags $large -I$(EIFFEL4)/bench/spec/$(PLATFORM)/include -I$(HOME)/matisse/include
LDFLAGS = $ldflags 
DEFINES= -DWORKBENCH -DSTRINGS_ALIGNED -D_NO_PROTO -DNO_REGEX -DSYSTEMV -DARX_CHECK -DSYSV
LIBS = $libs
MAKE = make
MKDEP = $mkdep $(DPFLAGS) --
MV = $mv
RANLIB = $ranlib
RM = $rm -f

!GROK!THIS!
$spitshell >>Makefile <<'!NO!SUBS!'

#libmatisse.a: mt_support.o special.o
#	$(RANLIB) $@

#mt_support.o : mt_support.c
#	$(CC) $(CFLAGS) $(DEFINES) -c mt_support.c

special.o : special.c
	$(CC) $(CFLAGS) $(DEFINES) -c special.c


clean :
	@echo ok.
!NO!SUBS!
chmod 644 Makefile
$eunicefix Makefile

