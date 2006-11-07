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
INCLUDE_PATH = $rt_include
DELDIR = $rm -rf
LN = $ln
RM = $rm -f
CP = $cp
SHELL = /bin/sh
CFLAGS = $ccflags $large
EC = ec$rt_version
ECF = cecil.ecf
TARGET = classic
EIFLIB = EIFGENs/\$(TARGET)/W_code/libcecil.a 
LIBS = $libs
OBJECT = fext.o

!GROK!THIS!
$spitshell >>Makefile <<'!NO!SUBS!'


all: $(OBJECT) compile_eiffel

compile_eiffel: $(OBJECT)
	$(EC) -config $(ECF) -freeze -c_compile
	$(LN) EIFGENs/$(TARGET)/W_code/cecil.melted .
	$(LN) EIFGENs/$(TARGET)/W_code/cecil .

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
	$(DELDIR) EIFGENs

