SHELL= \bin\sh
CC=		cl
LD=		cl

CFLAGS= -Zi -YX -c -nologo  -Ie:\EIFFEL42e\bench\spec\windows\include -Id:\jdk1.1.5\include -Id:\jdk1.1.5\include\win32 
CFLAGSMT= -Zi -YX -c -nologo -MTd -DEIF_THREADS  -DWORKBENCH -Ie:\EIFFEL42e\bench\spec\windows\include -Id:\jdk1.1.5\include -Id:\jdk1.1.5\include\win32 -Id:\cvs_dir\mtC\run-time

.c.obj:
        $(CC) $(CFLAGSMT) $<

all:	e2j.obj 

