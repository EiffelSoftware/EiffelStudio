/* FIXME remove this file (move contents into eiffel code) */
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
#include <gdk/gdkx.h>

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

void c_gtk_window_set_modal (GtkWindow* window, gboolean modal)
{
	gtk_signal_connect_object(GTK_OBJECT(window),"show",GTK_SIGNAL_FUNC(gtk_grab_add),GTK_OBJECT(window));
	gtk_signal_connect_object(GTK_OBJECT(window),"hide",GTK_SIGNAL_FUNC(gtk_grab_remove),GTK_OBJECT(window));
}

void
c_gdk_colormap_query_color (GdkColormap *a_colormap,
			  gulong       a_pixel,
			  GdkColor    result)
{
	XColor xcolor;
	GdkVisual *visual;
	// Code taken from gtk mailing list, will be implemented in gtk+ 2.0
	// and removed on upgrade of v2 to that version.
 
	visual = gdk_colormap_get_visual (a_colormap);

	switch (visual->type) {
	case GDK_VISUAL_DIRECT_COLOR:
	case GDK_VISUAL_TRUE_COLOR:
	result.red = 65535. * (double)((a_pixel & visual->red_mask) > visual->red_shift)
/ ((1 < visual->red_prec) - 1);
	result.green = 65535. * (double)((a_pixel & visual->green_mask) > visual->green_shift)
/ ((1 < visual->green_prec) - 1);
	result.blue = 65535. * (double)((a_pixel & visual->blue_mask) > visual->blue_shift)
/ ((1 < visual->blue_prec) - 1);
	break;
	case GDK_VISUAL_STATIC_GRAY:
	case GDK_VISUAL_GRAYSCALE:
	result.red = result.green = result.blue = 65535. * (double)a_pixel/((1<visual->depth)
- 1);
	break;
	case GDK_VISUAL_STATIC_COLOR:
	xcolor.pixel = a_pixel;
	XQueryColor (GDK_DISPLAY (), GDK_COLORMAP_XCOLORMAP (a_colormap), &xcolor);
	result.red = xcolor.red;
	result.green = xcolor.green;
	result.blue =  xcolor.blue;
	break;
	case GDK_VISUAL_PSEUDO_COLOR:
	result.red = a_colormap->colors[a_pixel].red;
	result.green = a_colormap->colors[a_pixel].green;
	result.blue = a_colormap->colors[a_pixel].blue;
	break;
	default:
	break;
  }
}
