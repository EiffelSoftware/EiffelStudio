INCLUDE_PATH = -I$(EIFFEL4)\library\wel\spec\windows\include -I$(EIFFEL4)\bench\spec\$(PLATFORM)\include 
SHELL = \bin\sh
CC = cl
CFLAGS = -Ox -c -nologo -DWIN32 $(INCLUDE_PATH)
LDFLAGS = -MAP -STACK:1024 -subsystem:WINDOWS
LIBS = 
MAKE = nmake
MKDEP =   --
MV = copy
RANLIB = echo
RM = del

.c.obj:
	$(CC) $(CFLAGS) -c $<

method_dispatcher = method_dispatcher.obj

all:  method_dispatcher.lib

method_dispatcher.lib: $(method_dispatcher) Makefile
	del $@
	lib /OUT:$@ $(method_dispatcher)

clean: local_clean
clobber: local_clobber

local_clean::
	$(RM) core *.o

local_clobber:: local_clean
	$(RM) Makefile

