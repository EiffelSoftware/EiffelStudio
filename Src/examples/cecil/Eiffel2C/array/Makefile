CC = gcc
ES4 = $(EIFFEL4)/bench/spec/$(PLATFORM)/bin/es4
FINISH_FREEZING = $(EIFFEL4)/bench/spec/$(PLATFORM)/bin/finish_freezing
INCLUDE_PATH = $(EIFFEL4)/bench/spec/$(PLATFORM)/include
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


	

