//------------------------------------------------------------------------------
// ev_titled_window_imp.c
//------------------------------------------------------------------------------
// description: "C features of EV_TITLED_WINDOW_IMP, see ev_titled_window_imp.h
// and ev_titled_window_imp.e" 
// status: "See notice at end of file"
// date: "$Date$"
// revision: "$Revision$"
//------------------------------------------------------------------------------

#include "ev_titled_window_imp.h"
#include "X11/Xlib.h"
#include "gdk/gdkprivate.h"

void
c_gdk_window_iconify (GdkWindow * window) // is
		// Hide `window' and display an icon on the desktop.
{
	// local
		GdkWindowPrivate *priv;
	// require
		g_return_if_fail (window != NULL);
	// do
		priv = (GdkWindowPrivate *) window;
		XIconifyWindow (priv->xdisplay, priv->xwindow, 0);
} 	// end

void
c_gdk_window_deiconify (GdkWindow * window) // is
		// Show `window' that is iconized.
{
	// local
		GdkWindowPrivate *priv;
	// require
		g_return_if_fail (window != NULL);
	// do
		priv = (GdkWindowPrivate *) window;
		XMapRaised (priv->xdisplay, priv->xwindow);
} 	// end

gboolean
c_gdk_window_is_iconified (GdkWindow * window) // is
		// Is `window' hidden and displayed as icon?
{
	// local
		GdkWindowPrivate *priv;
		XWindowAttributes xattr;
	// require
		g_return_val_if_fail (window != NULL, 0);
	// do
		priv = (GdkWindowPrivate *) window;
		xattr.map_state = IsUnmapped;
		XGetWindowAttributes (priv->xdisplay, priv->xwindow, &xattr);
		return (xattr.map_state == IsUnmapped);
} 	// end

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
// Revision 1.6  2001/06/07 23:07:59  rogers
// Merged DEVEL branch into Main trunc.
//
// Revision 1.5.6.1  2000/05/03 19:08:34  oconnor
// mergred from HEAD
//
// Revision 1.5  2000/03/08 20:10:00  brendel
// Fixed bug in c_gdk_window_is_iconified.
//
// Revision 1.4  2000/03/08 16:42:33  brendel
// Added header comments.
// Removed c_gdk_window_get_geometry.
//
// Revision 1.3  2000/03/08 02:06:39  brendel
// Added function c_gdk_window_get_geometry.
//
// Revision 1.2  2000/03/08 01:25:46  brendel
// Fixed compliler errors.
//
// Revision 1.1  2000/03/07 18:38:14  brendel
// Initial revision of externals for EV_TITLED_WINDOW_IMP.
//
//
//------------------------------------------------------------------------------
// End of CVS log
//------------------------------------------------------------------------------
