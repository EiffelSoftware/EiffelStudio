OBJS =  server.o ser_list.o parameter.o ref_table.o concurrency.o print.o idle.o curerror.o subs.o stack.o sep_call.o sep_ser.o sep_obj.o
WOBJS =  wserver.o ser_list.o parameter.o ref_table.o concurrency.o print.o idle.o curerror.o subs.o stack.o wsep_call.o sep_ser.o sep_obj.o
TARGET = runtime.a wkbench.a
CC = gcc
FLAG = -c  -ansi -DCONCURRENT_EIFFEL  -I../ -I../../
WFLAG = -c  -ansi -DWORKBENCH -DCONCURRENT_EIFFEL  -I../  -I../../
AR = ar rc
RUNLIB = :
LN = /usr/5bin/ln
ECHO = echo

all: $(TARGET)
	$(ECHO) "Done with compiling CEC run-time."

wkbench.a:	$(WOBJS)
	$(RM) $@
	$(AR) $@ $(WOBJS)
	$(RUNLIB) $@

runtime.a:	$(OBJS)
	$(RM) $@
	$(AR) $@ $(OBJS)
	$(RUNLIB) $@

server.o:	server.c ../curserver.h ../net.h ../constant.h ../curerrmsg.h ../curglb.h ../curextf.h
		$(CC) $(FLAG) server.c

wserver.c: server.c
		$(RM) wserver.c
		$(LN) server.c wserver.c

wserver.o:	wserver.c ../curserver.h ../net.h ../constant.h ../curerrmsg.h ../curglb.h ../curextf.h
		$(CC) $(WFLAG) wserver.c

subs.o:	subs.c ../curextern.h ../net.h ../constant.h ../curerrmsg.h ../curextg.h ../curextf.h
		$(CC) $(FLAG) subs.c

concurrency.o:	concurrency.c ../curextern.h ../net.h ../constant.h ../curerrmsg.h ../curextg.h ../curextf.h
		$(CC) $(FLAG) concurrency.c

parameter.o:	parameter.c ../curextern.h ../net.h ../constant.h ../curerrmsg.h ../curextg.h ../curextf.h
		$(CC) $(FLAG) parameter.c

ser_list.o:	ser_list.c ../curextern.h ../net.h ../constant.h ../curerrmsg.h ../curextg.h ../curextf.h
		$(CC) $(FLAG) ser_list.c

ref_table.o:	ref_table.c ../curextern.h ../net.h ../constant.h ../curerrmsg.h ../curextg.h ../curextf.h
		$(CC) $(FLAG) ref_table.c

print.o:	print.c ../curextern.h ../net.h ../constant.h ../curerrmsg.h ../curextg.h ../curextf.h
		$(CC) $(FLAG) print.c

curerror.o:	curerror.c ../curextern.h ../net.h ../constant.h ../curerrmsg.h ../curextg.h ../curextf.h
		$(CC) $(FLAG) curerror.c

idle.o:	idle.c ../curextern.h ../net.h ../constant.h ../curerrmsg.h ../curextg.h ../curextf.h
		$(CC) $(FLAG) idle.c

stack.o:	stack.c ../curextern.h ../net.h ../constant.h ../curerrmsg.h ../curextg.h ../curextf.h
		$(CC) $(FLAG) stack.c

sep_ser.o:	sep_ser.c ../curextern.h ../net.h ../constant.h ../curerrmsg.h ../curextg.h ../curextf.h
		$(CC) $(FLAG) sep_ser.c

wsep_call.o:	wsep_call.c ../curextern.h ../net.h ../constant.h ../curerrmsg.h ../curextg.h ../curextf.h
		$(CC) $(WFLAG) wsep_call.c

wsep_call.c: sep_call.c
		$(RM) wsep_call.c
		$(LN) sep_call.c wsep_call.c

sep_call.o:	sep_call.c ../curextern.h ../net.h ../constant.h ../curerrmsg.h ../curextg.h ../curextf.h
		$(CC) $(FLAG) sep_call.c

sep_obj.o:	sep_obj.c ../curextern.h ../net.h ../constant.h ../curerrmsg.h ../curextg.h ../curextf.h
		$(CC) $(FLAG) sep_obj.c

