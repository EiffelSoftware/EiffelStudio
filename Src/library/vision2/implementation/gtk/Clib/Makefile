#===============================================================================
# Makefile for vision2/implementation/gtk/Clib/gtk_eiffel.o
#-------------------------------------------------------------------------------
# Adjust PREFIX to suit local setup
#===============================================================================

PREFIX = $(EIFFEL4)/library
#PREFIX = /home/$(USER)/ws

CC = gcc
INCLUDE = -I$(EIFFEL4)/bench/spec/$(PLATFORM)/include
CFLAGS = -Wall -Wno-comment -g `gtk-config --cflags` $(INCLUDE)
INSTALL = $(PREFIX)/vision2/implementation/gtk/spec/$(PLATFORM)
OBJ = gtk_eiffel.o

all: $(OBJ)

install: gtk_eiffel.o
	install -D gtk_eiffel.o $(INSTALL)/gtk_eiffel.o

gtk_eiffel.o: gtk_eiffel.c
gtk_eiffel.o: ev_any_imp.c ev_any_imp.h
gtk_eiffel.o: ev_gtk_callback_marshal.c ev_gtk_callback_marshal.h
gtk_eiffel.o: ev_c_util.c ev_c_util.h

depend:
	makedepend $(INCLUDE) *.c

clean:
	rm -f $(OBJ)

#===============================================================================
# End of file
#===============================================================================

#-------------------------------------------------------------------------------
# EiffelVision: library of reusable components for ISE Eiffel.
# Copyright (C) 1986-1998 Interactive Software Engineering Inc.
# All rights reserved. Duplication and distribution prohibited.
# May be used only with ISE Eiffel, under terms of user license. 
# Contact ISE for any other use.
#
# Interactive Software Engineering Inc.
# ISE Building, 2nd floor
# 270 Storke Road, Goleta, CA 93117 USA
# Telephone 805-685-1006, Fax 805-685-6869
# Electronic mail <info@eiffel.com>
# Customer support e-mail <support@eiffel.com>
# For latest info see award-winning pages: http://www.eiffel.com
#-------------------------------------------------------------------------------
