MAKE = make
INCLUDE_PATH = $(ISE_EIFFEL)/studio/spec/$(ISE_PLATFORM)/include
DELDIR = /bin/rm -rf
LN = /bin/ln -s
RM = /bin/rm -f
CP = /bin/cp
SHELL = /bin/sh
FINISH_FREEZING = $(ISE_EIFFEL)/studio/spec/$(ISE_PLATFORM)/bin/finish_freezing
EC = $(ISE_EIFFEL)/studio/spec/$(ISE_PLATFORM)/bin/ec
EIFLIB = EIFGEN/W_code/libcecil.a 
LIBS = -lm
OBJECT = main.o
VERSION_NUMBER=45

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
	$(RM) *.o 
	$(RM) cecil 
	$(RM) cecil.melted
	$(RM) cecil.epr
	$(DELDIR) EIFGEN
	
