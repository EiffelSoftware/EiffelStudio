LIBS = `gtk-config --libs`
#LIBDIRS = -L/usr/X11R6/lib 
INCDIRS = -I$(EIFFEL4)/bench/spec/$(PLATFORM)/include 
CFLAGS = -Wall -Wno-comment -g `gtk-config --cflags`
LDFLAGS = $(CFLAGS)

all: gtk_eiffel.o

depend:
	makedepend $(INCDIRS) *.c


.c.o:
	$(CC) $(INCDIRS) $(CFLAGS) -c $< -o $@

clean:
	rm *.o

# DO NOT DELETE

gtk_eiffel.o: gtk_eiffel.h /usr/include/gtk/gtk.h /usr/include/gdk/gdk.h
gtk_eiffel.o: /usr/include/gdk/gdktypes.h /usr/include/glib.h
gtk_eiffel.o: /usr/include/glibconfig.h
gtk_eiffel.o: /usr/lib/gcc-lib/i386-redhat-linux/2.7.2.3/include/float.h
gtk_eiffel.o: /usr/include/limits.h /usr/include/features.h
gtk_eiffel.o: /usr/include/sys/cdefs.h /usr/include/gnu/stubs.h
gtk_eiffel.o: /usr/include/posix1_lim.h /usr/include/local_lim.h
gtk_eiffel.o: /usr/include/linux/limits.h /usr/include/posix2_lim.h
gtk_eiffel.o: /usr/include/gdk/gdkcursors.h /usr/include/gtk/gtkaccelerator.h
gtk_eiffel.o: /usr/include/gtk/gtkobject.h /usr/include/gtk/gtkenums.h
gtk_eiffel.o: /usr/include/gtk/gtktypeutils.h
gtk_eiffel.o: /usr/include/gtk/gtktypebuiltins.h /usr/include/gtk/gtkdebug.h
gtk_eiffel.o: /usr/include/gtk/gtkadjustment.h /usr/include/gtk/gtkdata.h
gtk_eiffel.o: /usr/include/gtk/gtkalignment.h /usr/include/gtk/gtkbin.h
gtk_eiffel.o: /usr/include/gtk/gtkcontainer.h /usr/include/gtk/gtkwidget.h
gtk_eiffel.o: /usr/include/gtk/gtkstyle.h /usr/include/gtk/gtkaspectframe.h
gtk_eiffel.o: /usr/include/gtk/gtkframe.h /usr/include/gtk/gtkarrow.h
gtk_eiffel.o: /usr/include/gtk/gtkmisc.h /usr/include/gtk/gtkbox.h
gtk_eiffel.o: /usr/include/gtk/gtkbbox.h /usr/include/gtk/gtkbutton.h
gtk_eiffel.o: /usr/include/gtk/gtkcheckbutton.h
gtk_eiffel.o: /usr/include/gtk/gtktogglebutton.h
gtk_eiffel.o: /usr/include/gtk/gtkcheckmenuitem.h
gtk_eiffel.o: /usr/include/gtk/gtkmenuitem.h /usr/include/gtk/gtkitem.h
gtk_eiffel.o: /usr/include/gtk/gtkclist.h /usr/include/gtk/gtksignal.h
gtk_eiffel.o: /usr/include/gtk/gtklabel.h /usr/include/gtk/gtkhscrollbar.h
gtk_eiffel.o: /usr/include/gtk/gtkscrollbar.h /usr/include/gtk/gtkrange.h
gtk_eiffel.o: /usr/include/gtk/gtkvscrollbar.h /usr/include/gtk/gtkcolorsel.h
gtk_eiffel.o: /usr/include/stdlib.h
gtk_eiffel.o: /usr/lib/gcc-lib/i386-redhat-linux/2.7.2.3/include/stddef.h
gtk_eiffel.o: /usr/include/sys/types.h /usr/include/gnu/types.h
gtk_eiffel.o: /usr/include/time.h /usr/include/endian.h
gtk_eiffel.o: /usr/include/bytesex.h /usr/include/sys/select.h
gtk_eiffel.o: /usr/include/selectbits.h /usr/include/alloca.h
gtk_eiffel.o: /usr/include/stdio.h /usr/include/libio.h
gtk_eiffel.o: /usr/include/_G_config.h
gtk_eiffel.o: /usr/lib/gcc-lib/i386-redhat-linux/2.7.2.3/include/stdarg.h
gtk_eiffel.o: /usr/include/stdio_lim.h /usr/include/math.h
gtk_eiffel.o: /usr/include/huge_val.h /usr/include/mathcalls.h
gtk_eiffel.o: /usr/include/gtk/gtkwindow.h /usr/include/gtk/gtkvbox.h
gtk_eiffel.o: /usr/include/gtk/gtkpreview.h /usr/include/gtk/gtkentry.h
gtk_eiffel.o: /usr/include/gtk/gtkeditable.h /usr/include/gtk/gtkhbox.h
gtk_eiffel.o: /usr/include/gtk/gtkmain.h /usr/include/gtk/gtkscale.h
gtk_eiffel.o: /usr/include/gtk/gtkhscale.h /usr/include/gtk/gtktable.h
gtk_eiffel.o: /usr/include/gtk/gtkeventbox.h /usr/include/gtk/gtkcombo.h
gtk_eiffel.o: /usr/include/gtk/gtkcurve.h /usr/include/gtk/gtkdrawingarea.h
gtk_eiffel.o: /usr/include/gtk/gtkdialog.h /usr/include/gtk/gtkfeatures.h
gtk_eiffel.o: /usr/include/gtk/gtkfilesel.h /usr/include/gtk/gtkfixed.h
gtk_eiffel.o: /usr/include/gtk/gtkgamma.h /usr/include/gtk/gtkgc.h
gtk_eiffel.o: /usr/include/gtk/gtkhandlebox.h /usr/include/gtk/gtkhbbox.h
gtk_eiffel.o: /usr/include/gtk/gtkhpaned.h /usr/include/gtk/gtkpaned.h
gtk_eiffel.o: /usr/include/gtk/gtkhruler.h /usr/include/gtk/gtkruler.h
gtk_eiffel.o: /usr/include/gtk/gtkhseparator.h
gtk_eiffel.o: /usr/include/gtk/gtkseparator.h /usr/include/gtk/gtkimage.h
gtk_eiffel.o: /usr/include/gtk/gtkinputdialog.h /usr/include/gtk/gtklist.h
gtk_eiffel.o: /usr/include/gtk/gtklistitem.h /usr/include/gtk/gtkmenu.h
gtk_eiffel.o: /usr/include/gtk/gtkmenushell.h /usr/include/gtk/gtkmenubar.h
gtk_eiffel.o: /usr/include/gtk/gtkmenufactory.h
gtk_eiffel.o: /usr/include/gtk/gtknotebook.h /usr/include/gtk/gtkoptionmenu.h
gtk_eiffel.o: /usr/include/gtk/gtkpixmap.h /usr/include/gtk/gtkprogressbar.h
gtk_eiffel.o: /usr/include/gtk/gtkradiobutton.h
gtk_eiffel.o: /usr/include/gtk/gtkradiomenuitem.h /usr/include/gtk/gtkrc.h
gtk_eiffel.o: /usr/include/gtk/gtkscrolledwindow.h
gtk_eiffel.o: /usr/include/gtk/gtkviewport.h /usr/include/gtk/gtkselection.h
gtk_eiffel.o: /usr/include/gtk/gtkspinbutton.h
gtk_eiffel.o: /usr/include/gtk/gtkstatusbar.h /usr/include/gtk/gtktext.h
gtk_eiffel.o: /usr/include/gtk/gtktipsquery.h /usr/include/gtk/gtktoolbar.h
gtk_eiffel.o: /usr/include/gtk/gtktooltips.h /usr/include/gtk/gtktree.h
gtk_eiffel.o: /usr/include/gtk/gtktreeitem.h /usr/include/gtk/gtkvbbox.h
gtk_eiffel.o: /usr/include/gtk/gtkvpaned.h /usr/include/gtk/gtkvruler.h
gtk_eiffel.o: /usr/include/gtk/gtkvscale.h /usr/include/gtk/gtkvseparator.h
gtk_eiffel.o: /boston/common/Eiffel43-19/bench/spec/linux-glibc/include/eif_eiffel.h
gtk_eiffel.o: /boston/common/Eiffel43-19/bench/spec/linux-glibc/include/eif_config.h
gtk_eiffel.o: /usr/include/string.h
gtk_eiffel.o: /boston/common/Eiffel43-19/bench/spec/linux-glibc/include/eif_globals.h
gtk_eiffel.o: /boston/common/Eiffel43-19/bench/spec/linux-glibc/include/eif_portable.h
gtk_eiffel.o: /boston/common/Eiffel43-19/bench/spec/linux-glibc/include/eif_confmagic.h
gtk_eiffel.o: /boston/common/Eiffel43-19/bench/spec/linux-glibc/include/eif_constants.h
gtk_eiffel.o: /usr/include/signal.h /usr/include/sigset.h
gtk_eiffel.o: /usr/include/signum.h /usr/include/sigaction.h
gtk_eiffel.o: /usr/include/sigcontext.h /usr/include/asm/sigcontext.h
gtk_eiffel.o: /boston/common/Eiffel43-19/bench/spec/linux-glibc/include/eif_types.h
gtk_eiffel.o: /boston/common/Eiffel43-19/bench/spec/linux-glibc/include/eif_threads.h
gtk_eiffel.o: /boston/common/Eiffel43-19/bench/spec/linux-glibc/include/eif_cecil.h
gtk_eiffel.o: /boston/common/Eiffel43-19/bench/spec/linux-glibc/include/eif_plug.h
gtk_eiffel.o: /boston/common/Eiffel43-19/bench/spec/linux-glibc/include/eif_main.h
gtk_eiffel.o: /boston/common/Eiffel43-19/bench/spec/linux-glibc/include/eif_urgent.h
gtk_eiffel.o: /boston/common/Eiffel43-19/bench/spec/linux-glibc/include/eif_out.h
gtk_eiffel.o: /boston/common/Eiffel43-19/bench/spec/linux-glibc/include/eif_interp.h
gtk_eiffel.o: /boston/common/Eiffel43-19/bench/spec/linux-glibc/include/eif_struct.h
gtk_eiffel.o: /boston/common/Eiffel43-19/bench/spec/linux-glibc/include/eif_dir.h
gtk_eiffel.o: /boston/common/Eiffel43-19/bench/spec/linux-glibc/include/eif_macros.h
gtk_eiffel.o: /boston/common/Eiffel43-19/bench/spec/linux-glibc/include/eif_project.h
gtk_eiffel.o: /boston/common/Eiffel43-19/bench/spec/linux-glibc/include/eif_malloc.h
gtk_eiffel.o: /boston/common/Eiffel43-19/bench/spec/linux-glibc/include/eif_garcol.h
gtk_eiffel.o: /boston/common/Eiffel43-19/bench/spec/linux-glibc/include/eif_except.h
gtk_eiffel.o: /usr/include/setjmp.h /usr/include/jmp_buf.h
gtk_eiffel.o: /usr/include/errno.h /usr/include/errnos.h
gtk_eiffel.o: /usr/include/linux/errno.h /usr/include/asm/errno.h
gtk_eiffel.o: /boston/common/Eiffel43-19/bench/spec/linux-glibc/include/eif_local.h
gtk_eiffel.o: /boston/common/Eiffel43-19/bench/spec/linux-glibc/include/eif_copy.h
gtk_eiffel.o: /boston/common/Eiffel43-19/bench/spec/linux-glibc/include/eif_hector.h
gtk_eiffel.o: /boston/common/Eiffel43-19/bench/spec/linux-glibc/include/eif_size.h
gtk_eiffel.o: /boston/common/Eiffel43-19/bench/spec/linux-glibc/include/eif_gen_conf.h
gtk_eiffel.o: /boston/common/Eiffel43-19/bench/spec/linux-glibc/include/eif_rout_obj.h
gtk_eiffel.o: /boston/common/Eiffel43-19/bench/spec/linux-glibc/include/eif_option.h
gtk_eiffel.o: /boston/common/Eiffel43-19/bench/spec/linux-glibc/include/eif_err_msg.h
gtk_eiffel.o: /usr/include/unistd.h /usr/include/posix_opt.h
gtk_eiffel.o: /usr/include/confname.h
gtk_eiffel.o: /boston/common/Eiffel43-19/bench/spec/linux-glibc/include/eif_bits.h
gtk_eiffel.o: /usr/include/dirent.h /usr/include/direntry.h
gtk_eiffel.o: /boston/common/Eiffel43-19/bench/spec/linux-glibc/include/eif_file.h
gtk_eiffel.o: /usr/include/sys/stat.h /usr/include/statbuf.h
gtk_eiffel.o: /boston/common/Eiffel43-19/bench/spec/linux-glibc/include/eif_argv.h
gtk_eiffel.o: gdk_eiffel.h
