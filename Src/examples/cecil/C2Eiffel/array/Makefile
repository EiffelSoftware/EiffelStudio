CC = gcc
MAKE = make
INCLUDE_PATH = $(EIFFEL4)/bench/spec/$(PLATFORM)/include
DELDIR = /bin/rm -rf
LN = /bin/ln -s
RM = /bin/rm -f
CP = /bin/cp
SHELL = sh
FINISH_FREEZING = $(EIFFEL4)/bench/spec/$(PLATFORM)/bin/finish_freezing
ES4 = $(EIFFEL4)/bench/spec/$(PLATFORM)/bin/es4
EIFLIB = EIFGEN/W_code/libtst.a 
LIBS = -lm
OBJECT = main.o
VERSION_NUMBER=42

all: compile_eiffel compile_c mklink tst 

compile_eiffel:
	$(ES4) -freeze; 

compile_c:
	cd EIFGEN/W_code; $(CP) $(EIFFEL4)/bench/spec/$(PLATFORM)/include/config.sh .; $(SHELL) Makefile.SH; $(MAKE) cecil
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
	
