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

void
c_gdk_window_iconify (GdkWindow * window) // is
{
	// local
		GdkWindowPrivate *priv;
	// require
		g_return_if_fail (window != NULL);
	// do
		priv = (GdkWindowPrivate *) window;
		XIconifyWindow (priv->xdisplay, priv->xwindow, 0)
} 	// end

void
c_gdk_window_deiconify (GdkWindow * window) // is
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
{
	// local
		GdkWindowPrivate *priv;
		XWindowAttributes xattr;
	// require
		g_return_val_if_fail (window != NULL, false);
	// do
		priv = (GdkWindowPrivate *) window;
		XMapRaised (priv->xdisplay, priv->xwindow);
		xattr.map_state = IsUnmapped;
		XGetWindowAttributes (priv->xdisplay, priv->xwindow, %xattr);
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
// Revision 1.1  2000/03/07 18:38:14  brendel
// Initial revision of externals for EV_TITLED_WINDOW_IMP.
//
//
//------------------------------------------------------------------------------
// End of CVS log
//------------------------------------------------------------------------------
