//------------------------------------------------------------------------------
// ev_menu_imp.h
//------------------------------------------------------------------------------
// description: "C function for EV_MENU_IMP."
// status: "See notice at end of file"
// date: "$Date$"
// revision: "$Revision$"
//------------------------------------------------------------------------------

#ifndef _EV_MENU_IMP_H_INCLUDED_
#define _EV_MENU_IMP_H_INCLUDED_

#include <gtk/gtk.h>

typedef struct {
	gint x_position;
	gint y_position;
} c_position;

void c_gtk_menu_position_func (GtkMenu * menu, gint * x, gint * y, gpointer user_data);

#endif

//------------------------------------------------------------------------------
// EiffelVision2: library of reusable components for ISE Eiffel.
// Copyright (C) 1986-2000 Interactive Software Engineering Inc.
// All rights reserved. Duplication and distribution prohibited.
// May be used only with ISE Eiffel, under terms of user license.
// Contact ISE for any other use.
//
// Interactive Software Engineering Inc.
// ISE Building, 2nd floor
// 270 Storke Road, Goleta, CA 93117 USA
// Telephone 805-685-1006, Fax 805-685-6869
// Electronic mail <info@eiffel.com>
// Customer support e-mail <support@eiffel.com>
// For latest info see award-winning pages: http://www.eiffel.com
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// CVS log
//------------------------------------------------------------------------------
//
// $Log$
// Revision 1.2  2004/03/08 20:01:05  king
// Added struct definition to header so that it can be referenced in Eiffel inline code
//
// Revision 1.1  2003/04/03 01:40:50  king
// Initial gtk 2 conversion
//
// Revision 1.2  2001/06/07 23:07:59  rogers
// Merged DEVEL branch into Main trunc.
//
// Revision 1.1.2.1  2000/05/03 19:08:34  oconnor
// mergred from HEAD
//
// Revision 1.1  2000/04/25 17:37:54  brendel
// Initial.
//
//
//------------------------------------------------------------------------------
// End of CVS log
//------------------------------------------------------------------------------
