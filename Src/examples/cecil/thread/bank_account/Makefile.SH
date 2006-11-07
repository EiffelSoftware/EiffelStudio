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
MV = $mv
SHELL = /bin/sh
CFLAGS = $mtccflags $large
EC = ec$rt_version
ECF = bank_account.ecf
TARGET = classic
EIFLIB = EIFGENs/\$(TARGET)/W_code/libbank_account.a 
LIBS = $mtlibs
OBJECT = main.o fext.o

!GROK!THIS!
$spitshell >>Makefile <<'!NO!SUBS!'

all: bank_account 

$(EIFLIB): compile_eiffel

compile_eiffel:
	$(EC) -config $(ECF) -freeze -c_compile 
	cd EIFGENs/$(TARGET)/W_code; $(MAKE) cecil
	$(LN) EIFGENs/$(TARGET)/W_code/bank_account.melted .

bank_account: $(OBJECT) $(EIFLIB)
	$(CC) -o bank_account $(OBJECT) $(EIFLIB) $(LIBS)

.c.o:
	$(CC) $(CFLAGS) -I$(INCLUDE_PATH) -c $<

clean:
	$(RM) core
	$(RM) config.sh
	$(RM) *.o 
	$(RM) bank_account 
	$(RM) bank_account.melted
	$(RM) bank_account.epr
	$(RM) Makefile
	$(DELDIR) EIFGENs
	

