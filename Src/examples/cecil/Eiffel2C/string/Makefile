CC = gcc
ES4 = $(ISE_EIFFEL)/bench/spec/$(ISE_PLATFORM)/bin/es4
FINISH_FREEZING = $(ISE_EIFFEL)/bench/spec/$(ISE_PLATFORM)/bin/finish_freezing
INCLUDE_PATH = $(ISE_EIFFEL)/bench/spec/$(ISE_PLATFORM)/include
CFLAGS = 
LN = /bin/ln
RM = /bin/rm -f
DELDIR = /bin/rm -rf
VERSION_NUMBER = 43
.c.o: 
	$(CC) -DVERSION=$(VERSION_NUMBER) -I$(INCLUDE_PATH) $(CFLAGS) -c $<

all: str_conv mklink

clean:
	$(DELDIR) EIFGEN
	$(RM) tst tst.melted
	$(RM) core
	$(RM) tst.epr
	$(RM) fext.o

mklink:
	$(LN) -s EIFGEN/W_code/tst .
	$(LN) -s EIFGEN/W_code/tst.melted .
	
str_conv: fext.o 
	$(ES4); cd EIFGEN/W_code/; $(FINISH_FREEZING)


	

