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

#ifndef _EV_TITLED_WINDOW_IMP_H_INCLUDED_
#define _EV_TITLED_WINDOW_IMP_H_INCLUDED_

#include <gdk/gdk.h>

void
c_gdk_window_iconify (GdkWindow * window);

void
c_gdk_window_deiconify (GdkWindow * window);

gboolean
c_gdk_window_is_iconified (GdkWindow * window);

#endif
