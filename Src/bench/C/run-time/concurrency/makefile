OBJS =  server.o ser_list.o parameter.o ref_table.o concurrency.o test.o print.o idle.o error.o subs.o disp_ser.o stack.o
CC = cc
FLAG = -c -I$(EIFFEL3)/bench/spec/$(PLATFORM)/include

lib.a:	$(OBJS)
			ar -r lib.a $(OBJS)

server.o:	server.c curextern.h net.h constant.h curerrmsg.h 
		$(CC) $(FLAG) -DWORKBENCH server.c

subs.o:	subs.c curextern.h net.h constant.h curerrmsg.h 
		$(CC) $(FLAG) subs.c

concurrency.o:	concurrency.c curextern.h net.h constant.h curerrmsg.h 
		$(CC) $(FLAG) concurrency.c

test.o:	test.c curextern.h net.h constant.h curerrmsg.h 
		$(CC) $(FLAG) test.c

parameter.o:	parameter.c curextern.h net.h constant.h curerrmsg.h 
		$(CC) $(FLAG) parameter.c

ser_list.o:	ser_list.c curextern.h net.h constant.h curerrmsg.h 
		$(CC) $(FLAG) ser_list.c

ref_table.o:	ref_table.c curextern.h net.h constant.h curerrmsg.h 
		$(CC) $(FLAG) ref_table.c

print.o:	print.c curextern.h net.h constant.h curerrmsg.h 
		$(CC) $(FLAG) print.c

error.o:	error.c curextern.h net.h constant.h curerrmsg.h 
		$(CC) $(FLAG) error.c

idle.o:	idle.c curextern.h net.h constant.h curerrmsg.h 
		$(CC) $(FLAG) idle.c

stack.o:	stack.c curextern.h net.h constant.h curerrmsg.h 
		$(CC) $(FLAG) stack.c

disp_ser.o:	disp_ser.c curextern.h net.h constant.h curerrmsg.h 
		$(CC) $(FLAG) disp_ser.c

tree.o:	tree.c curextern.h net.h constant.h curerrmsg.h 
		$(CC) $(FLAG) tree.c
