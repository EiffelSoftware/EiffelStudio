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
CFLAGS = $optimize $ccflags $large -I\$(EIFFEL4)/bench/spec/\$(PLATFORM)/include
LDFLAGS = $ldflags
LIBS = $libs
MAKE = make
MKDEP = $mkdep \$(DPFLAGS) --
MV = $mv
RANLIB = $ranlib
RM = $rm -f

!GROK!THIS!
$spitshell >>Makefile <<'!NO!SUBS!'
.c.o:
	$(CC) $(CFLAGS) -c $<

OBJECTS= buffer.o rou.o

lex.a: $(OBJECTS)
	$(RM) lex.a
	ar cr lex.a $(OBJECTS)
	$(RANLIB) lex.a

clean:
	$(RM) lex.a $(OBJECTS)

clobber: clean
	$(RM) Makefile config.sh
!NO!SUBS!
chmod 644 Makefile
$eunicefix Makefile
