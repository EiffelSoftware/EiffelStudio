/*
indexing
	description: "C features for GTK interface."
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

#ifdef __VMS 
#define XQueryColor XQUERYCOLOR 
#endif /* __VMS */


#include "gtk_eiffel.h"
#include "ev_any_imp.c"
#include "ev_c_util.c"
#include "ev_menu_imp.c"
#include "ev_gtk_callback_marshal.c"

#include <X11/Xlib.h>
#include <gdk/gdkprivate.h>
#include <gdk/gdkx.h>

void
c_gdk_colormap_query_color (GdkColormap *a_colormap,
			  gulong       a_pixel,
			  GdkColor    *result)
{
	XColor xcolor;
	GdkVisual *visual;
	// Code taken from gtk mailing list, will be implemented in gtk+ 2.0
	// and removed on upgrade of v2 to that version.
 
	visual = gdk_colormap_get_visual (a_colormap);

	switch (visual->type) {
	case GDK_VISUAL_DIRECT_COLOR:
	case GDK_VISUAL_TRUE_COLOR:

	result->red = 65535. * (double)((a_pixel & visual->red_mask) >> visual->red_shift) 
/ ((1 << visual->red_prec) - 1);
	result->green = 65535. * (double)((a_pixel & visual->green_mask) >> visual->green_shift)
/ ((1 << visual->green_prec) - 1);
	result->blue = 65535. * (double)((a_pixel & visual->blue_mask) >> visual->blue_shift)
/ ((1 << visual->blue_prec) - 1);
	break;
	case GDK_VISUAL_STATIC_GRAY:
	case GDK_VISUAL_GRAYSCALE:
	result->red = result->green = result->blue = 65535. * (double)a_pixel/((1<visual->depth)
- 1);
	break;
	case GDK_VISUAL_STATIC_COLOR:
	xcolor.pixel = a_pixel;
	XQueryColor (GDK_DISPLAY (), GDK_COLORMAP_XCOLORMAP (a_colormap), &xcolor);
	result->red = xcolor.red;
	result->green = xcolor.green;
	result->blue =  xcolor.blue;
	break;
	case GDK_VISUAL_PSEUDO_COLOR:
	result->red = a_colormap->colors[a_pixel].red;
	result->green = a_colormap->colors[a_pixel].green;
	result->blue = a_colormap->colors[a_pixel].blue;
	break;
	default:
	break;
  }
}
