case $CONFIG in
'')
	if test ! -f config.sh; then
		(echo "Can't find config.sh."; exit 1)
	fi 2>/dev/null
	. ./config.sh
	;;
esac
case "$0" in
*/*) cd `expr X$0 : 'X\(.*\)/'` ;;
esac
echo "Extracting "."/Makefile (with variable substitutions)"
$spitshell >Makefile <<!GROK!THIS!
########################################################################
# Makefile generated from Makefile.SH on $DATE
MAKE = make
INCLUDE_PATH = \$(ISE_EIFFEL)/studio/spec/\$(ISE_PLATFORM)/include
DELDIR = $rm -rf
LN = $ln
RM = $rm -f
CP = $cp
SHELL = /bin/sh
FINISH_FREEZING = \$(ISE_EIFFEL)/studio/spec/\$(ISE_PLATFORM)/bin/finish_freezing
CFLAGS = $ccflags $large
EC = \$(ISE_EIFFEL)/studio/spec/\$(ISE_PLATFORM)/bin/ec
EIFLIB = EIFGEN/W_code/libcecil.a 
LIBS = $libs
OBJECT = main.o

!GROK!THIS!
$spitshell >>Makefile <<'!NO!SUBS!'


all: compile_eiffel compile_c mklink cecil 

compile_eiffel:
	$(EC) -freeze; 

compile_c:
	cd EIFGEN/W_code; $(ISE_EIFFEL)/studio/spec/$(ISE_PLATFORM)/bin/finish_freezing -silent; $(MAKE) cecil

mklink:
	$(LN) EIFGEN/W_code/cecil.melted .

cecil: $(OBJECT) $(EIFLIB)
	$(CC) -o cecil $(OBJECT) $(EIFLIB) $(LIBS)

.c.o:
	$(CC) $(CFLAGS) -I$(INCLUDE_PATH) -c $<

clean:
	$(RM) core
	$(RM) config.sh
	$(RM) *.o 
	$(RM) cecil 
	$(RM) cecil.melted
	$(RM) cecil.epr
	$(RM) Makefile
	$(DELDIR) EIFGEN
	
