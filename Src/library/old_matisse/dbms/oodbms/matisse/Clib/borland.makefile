INCLUDE_PATH = -I$(EIFFEL4)\bench\spec\w32msc\include -I$(EIFFEL4)\library\wel\spec\windows\include -I$(MATISSE)\include
SHELL = \bin\sh
CC = bcc32
CFLAGS = -O2 -c -WC -g0 -w- -DWIN32  -DWORKBENCH  $(INCLUDE_PATH)
LDFLAGS = -m -s -c -Tpe -aa -S:2048
LIBS = 
MAKE = make
MKDEP =   --
MV = copy
RANLIB = echo
RM = del

.c.obj:
	$(CC) $(CFLAGS) -c $<

EOBJ1 = special.obj  

all::  special.lib

special.lib: $(EOBJ1) Makefile
	$(RM) $@
	$(RM) tlib.dumX
	echo Building library
	&echo +$** AMPER >> tlib.dumX
	echo +the_end >> tlib.dumX
	sed -f c:\sf tlib.dumX > tlib.dum
	tlib /p128 /c $@ @tlib.dum
	$(RM) tlib.dum
#
.c.obj:
	if exist t.cmp $(RM) t.cmp
	for %i in ($(CFLAGS)) do echo %i >> t.cmp
	for %i in ($(INCLUDE_PATH)) do echo %i >> t.cmp
	$(CC) @t.cmp $<
	@$(RM) t.cmp
#
.x.obj:
	$(EIFFEL4)\bench\spec\w32bcc\bin\x2c $< $*.c
	if exist t.cmp $(RM) t.cmp
	for %i in ($(CFLAGS)) do echo %i >> t.cmp
	for %i in ($(INCLUDE_PATH)) do echo %i >> t.cmp
	$(CC) @t.cmp $*.c
	$(RM) t.cmp

clean: local_clean
clobber: local_clobber

local_clean::
	$(RM) core *.o

local_clobber:: local_clean
	$(RM) Makefile

