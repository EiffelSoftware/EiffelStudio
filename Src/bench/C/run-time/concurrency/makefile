OBJS =  server.o ser_list.o parameter.o ref_table.o concurrency.o print.o idle.o curerror.o subs.o stack.o sep_call.o sep_ser.o
CC = cc
FLAG = -c  -DWORKBENCH -DCONCURRENT_EIFFEL  -I../ 

lib.a:	$(OBJS)

server.o:	server.c ../curserver.h ../net.h ../constant.h ../curerrmsg.h 
		$(CC) $(FLAG) server.c

subs.o:	subs.c ../curextern.h ../net.h ../constant.h ../curerrmsg.h 
		$(CC) $(FLAG) subs.c

concurrency.o:	concurrency.c ../curextern.h ../net.h ../constant.h ../curerrmsg.h 
		$(CC) $(FLAG) concurrency.c

parameter.o:	parameter.c ../curextern.h ../net.h ../constant.h ../curerrmsg.h 
		$(CC) $(FLAG) parameter.c

ser_list.o:	ser_list.c ../curextern.h ../net.h ../constant.h ../curerrmsg.h 
		$(CC) $(FLAG) ser_list.c

ref_table.o:	ref_table.c ../curextern.h ../net.h ../constant.h ../curerrmsg.h 
		$(CC) $(FLAG) ref_table.c

print.o:	print.c ../curextern.h ../net.h ../constant.h ../curerrmsg.h 
		$(CC) $(FLAG) print.c

curerror.o:	curerror.c ../curextern.h ../net.h ../constant.h ../curerrmsg.h 
		$(CC) $(FLAG) curerror.c

idle.o:	idle.c ../curextern.h ../net.h ../constant.h ../curerrmsg.h 
		$(CC) $(FLAG) idle.c

stack.o:	stack.c ../curextern.h ../net.h ../constant.h ../curerrmsg.h 
		$(CC) $(FLAG) stack.c

sep_ser.o:	sep_ser.c ../curextern.h ../net.h ../constant.h ../curerrmsg.h 
		$(CC) $(FLAG) sep_ser.c

sep_call.o:	sep_call.c ../curextern.h ../net.h ../constant.h ../curerrmsg.h 
		$(CC) $(FLAG) sep_call.c

