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

#ifndef _GTK_EIFFEL_H_INCLUDED_
#define _GTK_EIFFEL_H_INCLUDED_

/*==============================================================================
 Included files
==============================================================================*/

#include <gtk/gtk.h>
#include <stdlib.h>
#include "eif_eiffel.h"
#include "eif_argv.h"
#include "ev_gtk_callback_marshal.h"

EIF_REFERENCE c_match_font_name (char * pattern);

/*==============================================================================
 gtk_window functions
==============================================================================*/

void c_gtk_window_set_modal(GtkWindow* window, gboolean modal);

void
c_gdk_colormap_query_color (GdkColormap *colormap,
			  gulong       pixel,
			  GdkColor    *result);

#endif
