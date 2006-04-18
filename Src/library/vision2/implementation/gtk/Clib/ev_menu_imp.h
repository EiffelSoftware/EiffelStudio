/*
indexing
	description: "C features of EV_MENU_IMP."
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

#ifndef _EV_MENU_IMP_H_INCLUDED_
#define _EV_MENU_IMP_H_INCLUDED_

#include <gtk/gtk.h>

void
c_gtk_menu_popup (GtkMenu * menu, gint x, gint y);

#endif
