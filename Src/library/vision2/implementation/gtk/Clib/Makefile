LIBS = `gtk-config --libs`
CC = gcc
CFLAGS = -Wall -Wno-comment -g `gtk-config --cflags`
LDFLAGS = $(CFLAGS)
INCDIRS = -I$(EIFFEL4)/bench/spec/$(PLATFORM)/include
OBJECT_PATH = $(EIFFEL4)/library/vision2/implementation/gtk/spec/$(PLATFORM)

all: gtk_eiffel.o

depend:
	makedepend $(INCDIRS) *.c

.c.o:
	$(CC) $(INCDIRS) $(CFLAGS) -c $< -o $@

clean:
	rm *.o

# DO NOT DELETE

# Vision includes
gtk_eiffel.o: gtk_eiffel.h
gtk_eiffel.o: gdk_eiffel.h

# Glib headers
gtk_eiffel.o: $(PREFIX)/include/glib.h

# Gdk headers
gtk_eiffel.o: $(PREFIX)/include/gdk/gdk.h
gtk_eiffel.o: $(PREFIX)/include/gdk/gdktypes.h
gtk_eiffel.o: $(PREFIX)/include/gdk/gdkcursors.h 

# Gtk headers
gtk_eiffel.o: $(PREFIX)/include/gtk/gtk.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkobject.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkenums.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtktypeutils.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtktypebuiltins.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkdebug.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkadjustment.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkdata.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkalignment.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkbin.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkcontainer.h 
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkwidget.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkstyle.h 
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkaspectframe.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkframe.h 
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkarrow.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkmisc.h 
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkbox.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkbbox.h 
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkbutton.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkcheckbutton.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtktogglebutton.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkcheckmenuitem.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkmenuitem.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkitem.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkclist.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtksignal.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtklabel.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkhscrollbar.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkscrollbar.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkrange.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkvscrollbar.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkcolorsel.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkwindow.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkvbox.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkpreview.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkentry.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkeditable.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkhbox.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkmain.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkscale.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkhscale.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtktable.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkeventbox.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkcombo.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkcurve.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkdrawingarea.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkdialog.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkfeatures.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkfilesel.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkfixed.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkgamma.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkgc.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkhandlebox.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkhbbox.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkhpaned.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkpaned.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkhruler.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkruler.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkhseparator.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkseparator.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkimage.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkinputdialog.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtklist.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtklistitem.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkmenu.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkmenushell.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkmenubar.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkmenufactory.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtknotebook.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkoptionmenu.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkpixmap.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkprogressbar.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkradiobutton.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkradiomenuitem.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkrc.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkscrolledwindow.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkviewport.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkselection.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkspinbutton.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkstatusbar.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtktext.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtktipsquery.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtktoolbar.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtktooltips.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtktree.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtktreeitem.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkvbbox.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkvpaned.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkvruler.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkvscale.h
gtk_eiffel.o: $(PREFIX)/include/gtk/gtkvseparator.h

#Others

gtk_eiffel.o: /usr/include/stdlib.h

# ISE EiffelBench Include

gtk_eiffel.o: $(EIFFEL4)/bench/spec/linux-glibc/include/eif_eiffel.h
gtk_eiffel.o: $(EIFFEL4)/bench/spec/linux-glibc/include/eif_argv.h
