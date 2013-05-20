/*
indexing
	description: "C features of EV_C_UTILS."
	date: "$Date$"
	revision: "$Revision$"
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
#include <ev_gtk.h>


typedef struct {
	gint x_position;
	gint y_position;
} menu_position;

extern void c_gtk_menu_position_func (GtkMenu * menu, gint * x, gint * y, gboolean * push_in,  gpointer user_data);
extern void c_gtk_return_combo_toggle (GtkWidget *widget, GtkWidget** user_data);
extern void enable_ev_gtk_log (int a_mode);

/* XPM */
extern char **default_pixmap_xpm (void);
extern char **information_pixmap_xpm (void);
extern char **error_pixmap_xpm (void);
extern char **question_pixmap_xpm (void);
extern char **warning_pixmap_xpm (void);
extern char **no_collate_pixmap_xpm (void);
extern char **collate_pixmap_xpm (void);
extern char **landscape_pixmap_xpm (void);
extern char **portrait_pixmap_xpm (void);
extern char **busy_cursor_xpm (void);
extern char **crosshair_cursor_xpm (void);
extern char **help_cursor_xpm (void);
extern char **ibeam_cursor_xpm (void);
extern char **no_cursor_xpm (void);
extern char **sizeall_cursor_xpm (void);
extern char **sizenesw_cursor_xpm (void);
extern char **sizens_cursor_xpm (void);
extern char **sizenwse_cursor_xpm (void);
extern char **sizewe_cursor_xpm (void);
extern char **standard_cursor_xpm (void);
extern char **uparrow_cursor_xpm (void);
extern char **wait_cursor_xpm (void);

#endif
