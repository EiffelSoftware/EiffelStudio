CC= cc
LINK= 
DEFINES= -DSTRINGS_ALIGNED -D_NO_PROTO -DNO_REGEX 
INCLUDES= -I$(RUN_TIME3) -I/moscow/openwinV3/include
CFLAGS= $(LINK) $(INCLUDES) $(DEFINES)
LIBPATHS=
LIBS=
OBJECTS= efb_openlook.o efb_system.o

all: efb.a

efb.a: $(OBJECTS)
	rm -f efb.a
	ar cr efb.a $(OBJECTS)
	ranlib efb.a

efb_openlook.o: efb_openlook.c
	$(CC)  $(CFLAGS) $(LIBPATHS) -c efb_openlook.c

efb_system.o: ../efb_system.c
	$(CC)  $(CFLAGS) $(LIBPATHS) -c ../efb_system.c
