CC=		gcc
LD=		gcc
D=
I=		-I$(JAVA_HOME)/include -I$(JAVA_HOME)/include/solaris -I$(ISE_EIFFEL)/bench/spec/$(ISE_PLATFORM)/include
O=		-g
S=		-c
CFLAGS=		${O} ${D} ${I} ${S}

.c.o:
	@rm -f $*.o
	${CC} ${CFLAGS} $<

all:	_e2j.o 



