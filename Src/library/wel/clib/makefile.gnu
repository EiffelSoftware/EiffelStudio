# wel.a - Makefile for Microsoft C

EIFFEL_SRC=C:/Eiffel50
EIFFEL_SRC2=C:/Eiffel50
CC = gcc
CFLAGS = -c -O2 -I$(EIFFEL_SRC)/library/wel/spec/windows/include -I$(EIFFEL_SRC2)/bench/spec/windows/include
RM = rm

.c.o:
	$(CC) $(CFLAGS) $<

OBJ = disptchr.o choose_folder.o enumfont.o estream.o msgboxpa.o diskspace.o drawstate.o dynload.o mousehook.o

wel.a: $(OBJ)
	if [ -f $@ ] ; then $(RM) $@ ; fi
	ld -r -o $@ $(OBJ)
	if [ ! -d $(EIFFEL_SRC)/library/wel/spec/gnu ] ; then mkdir $(EIFFEL_SRC)/library/wel/spec/gnu ; fi
	if [ ! -d $(EIFFEL_SRC)/library/wel/spec/gnu/lib ] ; then mkdir $(EIFFEL_SRC)/library/wel/spec/gnu/lib ; fi
	cp $@ $(EIFFEL_SRC)/library/wel/spec/gnu/lib
	$(RM) $@
