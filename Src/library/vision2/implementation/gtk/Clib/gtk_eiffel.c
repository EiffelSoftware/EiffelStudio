/* FXIME remove this file (move contents into eiffel code) */
/***************************
 *			   *		     
 *   EiffelVision/GTK      *
 *                         *
 *   external C library    *
 *			   *	       
 *   Date: 5/22/98         *
 *                         *
 ***************************/

#include "gtk_eiffel.h"
#include "gdk_eiffel.h"
#include "ev_any_imp.c"
#include "ev_c_util.c"
#include "ev_titled_window_imp.c"
#include "ev_menu_imp.c"
#include "ev_gtk_callback_marshal.c"

#include <X11/Xlib.h>
#include <gdk/gdkprivate.h>

/*********************************
 *
 * Function: `c_match_font_name'
 * 
 * Author:   Vincent Brendel
 * Date:     12 jan 2000
 *
 * Note:     Cannot be moved to Eiffel, because it returns a char **
 *
 * Uses XListFonts to match `pattern' to a final font name.
 * Returns NULL string if no match is found.
 * As maximum, we pass 1 because we want only the first match.
 *
 *********************************/

char * c_match_font_name (char * pattern)
{
	char ** match_list; // array of null-term. strings.
	int list_size; // return var for XListFonts.

	match_list = XListFonts (gdk_display, pattern, 1, &list_size);

	// list empty means no match found.
	if (list_size == 0) return NULL;

	// return first (and only) string in list.
	return match_list [0];
}

/*********************************
 * Function `generize'
 *
 * Compiler hack to return a generic type G
 * from type ANY, used in the Eiffel function
 * item in EV_ITEM_LIST_IMP.
 ********************************/

EIF_REFERENCE generize (EIF_OBJECT g_item)
{
	return eif_access (g_item);
}

void enable_motion_notify (GtkWidget *widg)
{
	gint event_flags;

	event_flags = gtk_widget_get_events(GTK_WIDGET(widg));
	event_flags &= GDK_POINTER_MOTION_MASK;
	if (event_flags != GDK_POINTER_MOTION_MASK)
		gtk_widget_add_events (GTK_WIDGET(widg), GDK_POINTER_MOTION_MASK);
}

void c_gtk_widget_set_all_events (GtkObject * win)
{
	gint event_flags;

 	event_flags = gtk_widget_get_events(GTK_WIDGET(win));
 	event_flags = event_flags | GDK_BUTTON_PRESS_MASK | GDK_BUTTON_RELEASE_MASK | GDK_KEY_PRESS_MASK | GDK_KEY_RELEASE_MASK | GDK_ENTER_NOTIFY_MASK | GDK_LEAVE_NOTIFY_MASK | GDK_FOCUS_CHANGE_MASK;
	gtk_widget_set_events (GTK_WIDGET(win), event_flags);
}


void c_gtk_window_set_modal (GtkWindow* window, gboolean modal)
{
	gtk_signal_connect_object(GTK_OBJECT(window),"show",GTK_SIGNAL_FUNC(gtk_grab_add),GTK_OBJECT(window));
	gtk_signal_connect_object(GTK_OBJECT(window),"hide",GTK_SIGNAL_FUNC(gtk_grab_remove),GTK_OBJECT(window));
}
