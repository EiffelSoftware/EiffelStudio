LIBS = `gtk-config --libs`
#LIBDIRS = -L/usr/X11R6/lib 
INCDIRS = -I$(EIFFEL4)/bench/spec/$(PLATFORM)/include 
CFLAGS = -Wall -Wno-comment -g `gtk-config --cflags`
LDFLAGS = $(CFLAGS)

all: gtk_eiffel.o


.c.o:
	$(CC) $(INCDIRS) $(CFLAGS) -c $< -o $@

clean:
	rm *.o

