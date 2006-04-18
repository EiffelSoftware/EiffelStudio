/*
indexing
	description: "C features of EV_TITLED_WINDOW_IMP, see ev_titled_window_imp.h and ev_titled_window_imp.e."
	date: "$Date: $"
	revision: "$Revision: $"
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
*/

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
