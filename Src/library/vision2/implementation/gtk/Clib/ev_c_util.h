/*
indexing
	description: "C features of EV_C_UTILS."
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

#ifndef _EV_C_UTIL_H_INCLUDED_
#define _EV_C_UTIL_H_INCLUDED_
#include <gtk/gtk.h>

typedef struct {
	gint x_position;
	gint y_position;
} c_position;

void c_gtk_menu_position_func (GtkMenu * menu, gint * x, gint * y, gpointer user_data);

void c_gtk_return_combo_toggle (GtkWidget *widget, GtkWidget** user_data);

void enable_ev_gtk_log (int a_mode);

/* XPM */
char **default_pixmap_xpm (void);
char **information_pixmap_xpm (void);
char **error_pixmap_xpm (void);
char **question_pixmap_xpm (void);
char **warning_pixmap_xpm (void);
char **no_collate_pixmap_xpm (void);
char **collate_pixmap_xpm (void);
char **landscape_pixmap_xpm (void);
char **portrait_pixmap_xpm (void);
char **busy_cursor_xpm (void);
char **crosshair_cursor_xpm (void);
char **help_cursor_xpm (void);
char **ibeam_cursor_xpm (void);
char **no_cursor_xpm (void);
char **sizeall_cursor_xpm (void);
char **sizenesw_cursor_xpm (void);
char **sizens_cursor_xpm (void);
char **sizenwse_cursor_xpm (void);
char **sizewe_cursor_xpm (void);
char **standard_cursor_xpm (void);
char **uparrow_cursor_xpm (void);
char **wait_cursor_xpm (void);

#endif
