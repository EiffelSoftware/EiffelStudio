INCLUDE_PATH = -I$(EIFFEL4)\bench\spec\windows\include -I$(EIFFEL4)\library\wel\spec\windows\include -I$(MATISSE)\include
SHELL = \bin\sh
CC = cl
CFLAGS = -Zi -c -nologo -DWORKBENCH -DWIN32 $(INCLUDE_PATH)
LDFLAGS = -DEBUG -STACK:1024 -subsystem:WINDOWS
LIBS = 
MAKE = nmake
MKDEP =   --
MV = copy
RANLIB = echo
RM = del /F

.c.obj:
	$(CC) $(CFLAGS) -c $<
mt_support = mt_support.obj
matisse = mt_support.obj special.obj
special = special.obj
matisse_store = matisse_store.obj display.obj

all:  mt_support.lib matisse.lib special.lib matisse_store.lib
mt_support.lib: $(mt_support) Makefile
	$(RM) $@
	lib /OUT:$@ $(mt_support)
	$(RM) ..\..\..\..\spec\$(COMPILER)\Lib\$@
	$(MV) $@ ..\..\..\..\spec\$(COMPILER)\Lib

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
