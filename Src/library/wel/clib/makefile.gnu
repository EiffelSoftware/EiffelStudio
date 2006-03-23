# wel.a - Makefile for Microsoft C

CC = gcc
CFLAGS = -c -O2 -I../spec/windows/include -I$(ISE_EIFFEL)/studio/spec/$(ISE_PLATFORM)/include -D_UNICODE -DUNICODE
RM = rm

.c.o:
	$(CC) $(CFLAGS) $<

OBJ = disptchr.o choose_folder.o enumfont.o enum_child_windows.o estream.o msgboxpa.o diskspace.o drawstate.o dynload.o mousehook.o

wel.a: $(OBJ)
	if [ -f $@ ] ; then $(RM) $@ ; fi
	ld -r -o $@ $(OBJ)
	if [ ! -d ../spec/gnu ] ; then mkdir ../spec/gnu ; fi
	if [ ! -d ../spec/gnu/lib ] ; then mkdir ../spec/gnu/lib ; fi
	cp $@ ../spec/gnu/lib
	$(RM) $@
