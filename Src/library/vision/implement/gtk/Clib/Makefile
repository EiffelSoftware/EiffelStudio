LIBS = -lgtk -lgdk -lglib -lX11 -lXext -lm
LIBDIRS = -L/usr/X11R6/lib 
INCDIRS = -I$(EIFFEL4)/bench/spec/$(PLATFORM)/include -I/usr/lib/glib/include
CFLAGS = -Wall -g
LDFLAGS = $(CFLAGS)

all: gtk_eiffel.o


.c.o:
	$(CC) $(INCDIRS) $(CFLAGS) -c $< -o $@

clean:
	rm *.o

