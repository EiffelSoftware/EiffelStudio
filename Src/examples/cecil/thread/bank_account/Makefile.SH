	cp $ISE_EIFFEL/bench/spec/$ISE_PLATFORM/include/config.sh .
	if test ! -f config.sh; then
		(echo "Can't find config.sh."; exit 1)
	fi 2>/dev/null
	. ./config.sh

echo "Extracting "."/Makefile (with variable substitutions)"
$spitshell >Makefile <<!GROK!THIS!
SHELL = /bin/sh
CC = $cc
CFLAGS = $optimize $mtccflags $large -I\$(ISE_EIFFEL)/bench/spec/\$(ISE_PLATFORM)/include -I. \$(INCLUDE_PATH)
LDFLAGS =  $windows_flags $mtldflags
EIFLIB = EIFGEN/F_code/libbank_account.a 
MAKE = $make
AR = $ar
LIBS=$mtlibs
LD = $ld
MKDEP = $mkdep \$(DPFLAGS) --
MV = $mv
RANLIB = $ranlib
RM = $rm -f
RMDIR = $rmdir
COMMAND_MAKEFILE = $command_makefile
!GROK!THIS!
$spitshell >>Makefile <<'!NO!SUBS!'
.SUFFIXES: .x .xpp

.c.o:
	$(CC) $(CFLAGS) -c $<

all: tst

OBJECTS= main.o fext.o  

$(EIFLIB): 
	cd EIFGEN/F_code;\
	$(MAKE) cecil;\
	cd ../..

tst: $(OBJECTS)  $(EIFLIB) Makefile
	$(RM) tst
	$(CC) -o $@ $(CFLAGS) $(LDFLAGS)  $(OBJECTS) $(EIFLIB) $(LIBS) 

clean: local_clean
clobber: local_clobber

local_clean::
	$(RM) core *.o 

local_clobber:: local_clean
	$(RM) tst Makefile config.sh 

!NO!SUBS!
chmod 644 Makefile
$eunicefix Makefile

