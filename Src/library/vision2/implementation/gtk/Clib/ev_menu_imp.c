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

#include "ev_menu_imp.h"

typedef struct {
	gint x_position;
	gint y_position;
} c_position;

void
c_gtk_menu_position_func (GtkMenu * menu, gint * x, gint * y,
		gpointer user_data) // is
		// Callback that returns `x' and `y' from `user_data' for `menu'.
{
	// local
		c_position * posp;
	// require
		g_return_if_fail (user_data != NULL);
	// do
		posp = user_data;
		x = &posp->x_position;
		y = &posp->y_position;
}	// end

void
c_gtk_menu_popup (GtkMenu * menu, gint x, gint y) // is
		// Show `menu' on (`x', `y').
{
	// local
		c_position pos;
	// require
		g_return_if_fail (menu != NULL);
	// do
		pos.x_position = x;
		pos.y_position = y;
		gtk_menu_popup (menu, NULL, NULL, 
				c_gtk_menu_position_func, &pos, 0, 0);
} 	// end
