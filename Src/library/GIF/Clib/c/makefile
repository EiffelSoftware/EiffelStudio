INCLUDE_PATH = -I. -Id:\eiffel43\bench\spec\windows\include
CC = cl
CPP = cl
CFLAGS = -Ox -YX -nologo $(INCLUDE_PATH)
MAKE = nmake
MKDEP =   --
MV = copy
RANLIB = echo
RM = del
RMDIR = rd
SHAREDLINK = link
MY_OBJECTS = gif_library.obj
.SUFFIXES:.cpp

all: $(MY_OBJECTS)
.c.obj::
	$(CC) $(CFLAGS) -c $<



clean: local_clean
clobber: local_clobber

local_clean::
	$(RM) core *.obj

