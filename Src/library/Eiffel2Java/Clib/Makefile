SHELL= \bin\sh
CC=		cl
LD=		cl

CFLAGS= -Od -c -nologo  -I$(EIFFEL4)\bench\spec\windows\include -Id:\apps\jdk1.1.8\include -Id:\apps\jdk1.1.8\include\win32 
CFLAGSMT= -Od -c -nologo -MTd -DEIF_THREADS  -DWORKBENCH -I$(EIFFEL4)\bench\spec\windows\include -Id:\apps\jdk1.1.8\include -Id:\apps\jdk1.1.8\include\win32 -Id:\cvs_dir\mtC\run-time

.c.obj:
	$(CC) $(CFLAGS) $<

all:	e2j.obj 

