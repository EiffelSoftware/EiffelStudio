CC= cc 
LINK= 
DEFINES= -DSTRINGS_ALIGNED -D_NO_PROTO -DNO_REGEX 
INCLUDES= -I$(RUN_TIME3)  
CFLAGS= $(LINK) $(INCLUDES) $(DEFINES)
LIBPATHS=
LIBS=
OBJECTS= efb_motif.o efb_system.o

all: efb.a

efb.a: $(OBJECTS)
	rm -f efb.a
	ar cr efb.a $(OBJECTS)

efb_motif.o: efb_motif.c
	$(CC)  $(CFLAGS) $(LIBPATHS) -c efb_motif.c

efb_system.o: ../efb_system.c
	$(CC)  $(CFLAGS) $(LIBPATHS) -c ../efb_system.c
