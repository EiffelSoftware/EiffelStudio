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
CFLAGS = $optimize $ccflags $large -I\$(EIFFEL3)/bench/spec/\$(PLATFORM)/include
LDFLAGS = $ldflags
DEFINES= 
LIBS = $libs
MAKE = make
MKDEP = $mkdep \$(DPFLAGS) --
MV = $mv
RANLIB = $ranlib
RM = $rm -f

!GROK!THIS!
$spitshell >>Makefile <<'!NO!SUBS!'
.c.o:
	$(CC) $(CFLAGS) $(DEFINES) -c $<

OBJECTS= xt_support.o callback.o creation.o pixmap.o font.o \
		mel_string.o pixel.o pointer.o xm_support.o \
		c_support.o g_context.o font_box.o

libMel.a: $(OBJECTS)
	$(RM) libMel.a
	ar cr libMel.a $(OBJECTS)
	$(RANLIB) libMel.a

clean:
	$(RM) libMel.a $(OBJECTS)
clobber: clean
	$(RM) config.sh Makefile 
!NO!SUBS!
chmod 644 Makefile
$eunicefix Makefile
