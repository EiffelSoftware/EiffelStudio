#This makefile will generate the cecil executable in frozen mode 
# (es4 -freeze) .
# In finalized mode, there is no melted.eif file, then you should
# remove the rule `melted'.
 
CC= gcc
CFLAGS= -O -I/$(EIFFEL4)/bench/spec/$(PLATFORM)/include
LN= ln
RM= rm
.c.o:
	$(CC) $(CFLAGS) -c $<
	
all: melted cecil_test 

melted: EIFGEN/W_code/melted.eif
	$(RM) -f melted.eif
	$(LN) EIFGEN/W_code/melted.eif melted.eif

cecil_test: main.o
	$(CC) -o cecil_test main.o EIFGEN/W_code/libtest.a -lm

