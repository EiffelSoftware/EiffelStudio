INCLUDE_PATH = -I$(EIFFEL4)\bench\spec\windows\include -I$(EIFFEL4)\library\wel\spec\windows\include -I$(MATISSE)\include
SHELL = \bin\sh
CC = cl
CFLAGS = -Ox -Zi -c -nologo -DWIN32  -DWORKBENCH $(INCLUDE_PATH)
LDFLAGS = -DEBUG -STACK:1024 -subsystem:WINDOWS
LIBS = 
MAKE = nmake
MKDEP =   --
MV = copy
RANLIB = echo
RM = del /F

.c.obj:
	$(CC) $(CFLAGS) -c $<

matisse = mt_support.obj special.obj
special = special.obj
matisse_store = matisse_store.obj display.obj

all:  matisse.lib special.lib matisse_store.lib

matisse.lib: $(matisse) Makefile
	$(RM) $@
	lib /OUT:$@ $(matisse)
	$(RM) ..\..\..\..\spec\$(COMPILER)\Lib\$@
	$(MV) $@ ..\..\..\..\spec\$(COMPILER)\Lib

special.lib: $(special) Makefile
	$(RM) $@
	lib /OUT:$@ $(special)
	$(RM) ..\..\..\..\spec\$(COMPILER)\Lib\$@
	$(MV) $@ ..\..\..\..\spec\$(COMPILER)\Lib

matisse_store.lib: $(matisse_store) Makefile
	$(RM) $@
	lib -DEBUGTYPE:BOTH -OUT:$@ $(matisse_store)
	$(RM) ..\..\..\..\spec\$(COMPILER)\Lib\$@
	$(MV) $@ ..\..\..\..\spec\$(COMPILER)\Lib

clean: local_clean
clobber: local_clobber

local_clean::
	$(RM) core *.o

local_clobber:: local_clean
	$(RM) Makefile
