CC = gcc
MAKE = make
INCLUDE_PATH = $(ISE_EIFFEL)/studio/spec/$(ISE_PLATFORM)/include
DELDIR = /bin/rm -rf
LN = /bin/ln -s
RM = /bin/rm -f
CP = /bin/cp
SHELL = sh
FINISH_FREEZING = $(ISE_EIFFEL)/studio/spec/$(ISE_PLATFORM)/bin/finish_freezing
ES4 = $(ISE_EIFFEL)/studio/spec/$(ISE_PLATFORM)/bin/ec
EIFLIB = EIFGEN/W_code/libtst.a 
LIBS = -lm
OBJECT = main.o
VERSION_NUMBER=45

all: compile_eiffel compile_c mklink tst 

compile_eiffel:
	$(ES4) -freeze; 

compile_c:
	cd EIFGEN/W_code; $(CP) $(ISE_EIFFEL)/studio/spec/$(ISE_PLATFORM)/include/config.sh .; $(SHELL) Makefile.SH; $(MAKE) cecil
mklink:
	$(LN) EIFGEN/W_code/tst.melted .
tst: $(OBJECT) 
	$(CC) -o tst $(OBJECT) $(EIFLIB) $(LIBS)
.c.o:
	$(CC) -DVERSION=$(VERSION_NUMBER) -I$(INCLUDE_PATH) -c $<
clean:
	$(RM) *.o 
	$(RM) tst 
	$(RM) tst.melted
	$(RM) tst.epr
	$(DELDIR) EIFGEN
	
