FLAG = -c -I$(EIFFEL4)/bench/spec/$(PLATFORM)/include 
LIBS = -lsocket -lnsl -lm $(EIFFEL4)/library/net/spec/$(PLATFORM)/lib/libnet.a
OBJS = dog.o subs.o 
CC = cc

concurrent_daemon: $(OBJS)
		$(CC) -o concurrent_daemon $(OBJS) $(LIBS)
		rm -f dog.o
		rm -f subs.o

dog.o:   dog.c dog.h
		$(CC) $(FLAG) dog.c

subs.o:   subs.c dog.h
		$(CC) $(FLAG) subs.c

