FLAG = -c -I$(EIFFEL3)/bench/spec/$(PLATFORM)/include 
LIBS = -lsocket -lnsl -lm $(EIFFEL3)/library/net/spec/$(PLATFORM)/lib/libnet.a
OBJS = dog.o subs.o 
CC = cc

lannion: $(OBJS)
		$(CC) -o lannion $(OBJS) $(LIBS)
		rm -f dog.o
		rm -f subs.o

dog.o:   dog.c dog.h
		$(CC) $(FLAG) dog.c

subs.o:   subs.c dog.h
		$(CC) $(FLAG) subs.c

