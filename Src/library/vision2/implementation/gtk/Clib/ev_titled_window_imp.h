//------------------------------------------------------------------------------
// ev_titled_window_imp.h
//------------------------------------------------------------------------------
// description: "C features of EV_TITLED_WINDOW_IMP, see ev_titled_window_imp.c
// and ev_titled_window_imp.e" 
// status: "See notice at end of file"
// date: "$Date$"
// revision: "$Revision$"
//------------------------------------------------------------------------------

#ifndef _EV_TITLED_WINDOW_IMP_H_INCLUDED_
#define _EV_TITLED_WINDOW_IMP_H_INCLUDED_

#include <gtk/gdk.h>

void
c_gdk_window_iconify (GdkWindow * window);

void
c_gdk_window_deiconify (GdkWindow * window);

gboolean
c_gdk_window_is_iconified (GdkWindow * window);

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
// Revision 1.1  2000/03/07 18:38:14  brendel
// Initial revision of externals for EV_TITLED_WINDOW_IMP.
//
//
//------------------------------------------------------------------------------
// End of CVS log
//------------------------------------------------------------------------------
