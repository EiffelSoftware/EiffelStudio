--|FXIME remove this file (move contents into eiffel code)
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

/*********************************
 *
 * Function `c_gtk_window_x'
 *          `c_gtk_window_y'
 *			`c_gtk_window_maximum_height'
 *			`c_gtk_window_maximum_width'
 *			`c_gtk_window_title'
 *
 * Note : Return the x and y coordinates of a window
 * 		  And the postcondition function for x. 
 * 		  Return the maximum height and width.
 * 		  Return the title of a window 
 *      
 * Author : Leila, Alex
 *
 *********************************/

EIF_INTEGER c_gtk_window_x (GtkWidget *w)
{
	gint x;

	if GTK_WIDGET_VISIBLE(w)
	{
		gdk_window_get_position (w->window, &x, NULL);
		return x;
	}
	else
		return (-1);
}

EIF_INTEGER c_gtk_window_y (GtkWidget *w)
{
	gint y;
	
	if GTK_WIDGET_VISIBLE(w)
	{
		gdk_window_get_position (w->window, NULL, &y);
		return y;
	}
	else
		return (-1);
}


void c_gtk_window_set_modal (GtkWindow* window, gboolean modal)
{
	gtk_signal_connect_object(GTK_OBJECT(window),"show",GTK_SIGNAL_FUNC(gtk_grab_add),GTK_OBJECT(window));
	gtk_signal_connect_object(GTK_OBJECT(window),"hide",GTK_SIGNAL_FUNC(gtk_grab_remove),GTK_OBJECT(window));
}

EIF_INTEGER c_gtk_window_maximum_height (GtkWidget *w)
{
	GtkWindowGeometryInfo *info;
	
	if GTK_WIDGET_VISIBLE(w)
	{		
		info = (GtkWindowGeometryInfo *) gtk_object_get_data (GTK_OBJECT(w), "gtk-window-geometry");
		return info->geometry.max_height;
	}
	else
		return (-1);
}

EIF_INTEGER c_gtk_window_maximum_width (GtkWidget *w)
{
	GtkWindowGeometryInfo *info;
			
	if GTK_WIDGET_VISIBLE(w)
	{		
		info = (GtkWindowGeometryInfo *) gtk_object_get_data (GTK_OBJECT(w), "gtk-window-geometry");
		return info->geometry.max_width;
	}
	else
		return (-1);
}

gchar* c_gtk_window_title (GtkWindow *w)
{
	return w->title;
}

void c_gtk_window_set_icon (GtkWidget *window, GtkPixmap *pixmap, GtkWidget *icon_window, GtkPixmap *usermask)
{
	GdkBitmap *mask, *custommask;
	GList *child;

	if (usermask != NULL)
	{
		gtk_pixmap_get (usermask, NULL, &custommask);
		gtk_widget_shape_combine_mask (icon_window, custommask, 0, 0);
	}
	else 
	{
		gtk_pixmap_get (pixmap, NULL, &mask);
		gtk_widget_shape_combine_mask (icon_window, mask, 0, 0);
	}
	
	// Check to see if pixmap has already been set in the icon window
	child = gtk_container_children (GTK_CONTAINER (icon_window));
	child = g_list_find (child, (gpointer) pixmap);

	//If not already set, add pixmap to icon window
	if (!child)
	{
		gtk_widget_show (GTK_WIDGET (pixmap));
		gtk_container_add (GTK_CONTAINER (icon_window), GTK_WIDGET (pixmap));
	}

	// --| FIXME IEK The icon shows momentarily on the screen.
	//Move icon window to left corner of screen
	gtk_widget_set_uposition (icon_window, 0, 0);
	gtk_widget_show (icon_window);
	gdk_window_move (icon_window->window, -500, -500);
	// The window then gets set as the icon window displacing it from (-500, -500)

	gdk_window_set_icon (window->window, icon_window->window, NULL, NULL);
}

void c_gtk_window_set_icon_name (GtkWindow *wind, gchar *name)
{
		gdk_window_set_icon_name (GTK_WIDGET (wind)->window, name);
}
