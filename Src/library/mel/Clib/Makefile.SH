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
CFLAGS = $optimize $ccflags $large -I\$(ISE_EIFFEL)/bench/spec/\$(ISE_PLATFORM)/include
MTCFLAGS = $optimize $mtccflags $large -I\$(ISE_EIFFEL)/bench/spec/\$(ISE_PLATFORM)/include
LDFLAGS = $ldflags
DEFINES= 
LIBS = $libs
MTLIBS = $mtlibs
MAKE = make
MKDEP = $mkdep \$(DPFLAGS) --
MV = $mv
RANLIB = $ranlib
RM = $rm -f
SHAREDLINK= $sharedlink
LDSHAREDFLAGS= $ldsharedflags
MEL_LIBS = libMel.a libmtMel.a libMel.so libmtMel.so


!GROK!THIS!
$spitshell >>Makefile <<'!NO!SUBS!'

all: $(MEL_LIBS)

#libMel.a

OBJECTS= xt_support.o callback.o creation.o pixmap.o font.o \
		mel_string.o pixel.o pointer.o xm_support.o \
		c_support.o g_context.o font_box.o


libMel.a: $(OBJECTS)
	$(RM) libMel.a
	ar cr libMel.a $(OBJECTS)
	$(RANLIB) libMel.a

#libMel.so

libMel.so: $(OBJECTS)
	$(RM) $@
	$(SHAREDLINK) $(LDSHAREDFLAGS) $@ $(OBJECTS)

#libmtMel.a

MT_OBJECTS= MTxt_support.o MTcallback.o MTcreation.o MTpixmap.o MTfont.o \
		MTmel_string.o MTpixel.o MTpointer.o MTxm_support.o \
		MTc_support.o MTg_context.o MTfont_box.o

MTxt_support.o: xt_support.c
	$(CC) -c $(MTCFLAGS) $? -o $@

MTcallback.o: callback.c
	$(CC) -c $(MTCFLAGS) $? -o $@

MTcreation.o: creation.c
	$(CC) -c $(MTCFLAGS) $? -o $@

MTpixmap.o: pixmap.c
	$(CC) -c $(MTCFLAGS) $? -o $@

MTfont.o: font.c
	$(CC) -c $(MTCFLAGS) $? -o $@

MTmel_string.o: mel_string.c
	$(CC) -c $(MTCFLAGS) $? -o $@

MTpixel.o: pixel.c
	$(CC) -c $(MTCFLAGS) $? -o $@

MTpointer.o: pointer.c
	$(CC) -c $(MTCFLAGS) $? -o $@

MTxm_support.o: xm_support.c
	$(CC) -c $(MTCFLAGS) $? -o $@

MTc_support.o: c_support.c
	$(CC) -c $(MTCFLAGS) $? -o $@

MTg_context.o: g_context.c
	$(CC) -c $(MTCFLAGS) $? -o $@

MTfont_box.o: font_box.c
	$(CC) -c $(MTCFLAGS) $? -o $@

libmtMel.a: $(MT_OBJECTS)
	$(RM) libmtMel.a
	ar cr libmtMel.a $(MT_OBJECTS)
	$(RANLIB) libmtMel.a

#libmtMel.so

libmtMel.so: $(MT_OBJECTS)
	$(RM) $@
	$(SHAREDLINK) $(LDSHAREDFLAGS) $@ $(MT_OBJECTS)

ALL_OBJECTS= $(OBJECTS) $(MT_OBJECTS)

clean:
	$(RM) $(MEL_LIBS) $(ALL_OBJECTS)

clobber: clean
	$(RM) config.sh Makefile 
!NO!SUBS!
chmod 644 Makefile
$eunicefix Makefile
