

socket.a : socket.o socket_r.o  bitmask.h
	ar rc socket.a socket.o socket_r.o 
	ar ts socket.a  

wsocket.a : wsocket.o wsocket_r.o bitmask.h Makefile
	ar rc wsocket.a wsocket.o wsocket_r.o 
	ar ts wsocket.a 

socket.o : socket.c
	cc -I$(EIFFEL3)/bench/spec/$(PLATFORM)/include -c socket.c

socket_r.o : socket_r.c 
	cc -I$(EIFFEL3)/bench/spec/$(PLATFORM)/include -c socket_r.c

wsocket.o : wsocket.c
	cc -g -DWORKBENCH -I$(EIFFEL3)/bench/spec/$(PLATFORM)/include -c wsocket.c 
 
wsocket_r.o : wsocket_r.c   
	cc -g -DWORKBENCH -I$(EIFFEL3)/bench/spec/$(PLATFORM)/include -c wsocket_r.c  
 
clean: 
	\rm -f *.a *.o wsocket.c wsocket_r.c
	

socket_r.c :
	

socket.c :
	
	
wsocket_r.c :
	\rm -f wsocket_r.c
	ln -s socket_r.c wsocket_r.c

wsocket.c :
	\rm -f wsocket.c
	ln -s socket.c wsocket.c

