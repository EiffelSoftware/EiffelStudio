/*==============================================================================
 EiffelVision/GTK External C library
 gtk_eiffel.h
--------------------------------------------------------------------------------
 description: "Functions for using gtk from Eiffel"
 date:        "$Date$"
 revision:    "$Revision$"
 status:      "See notice at end of file"
==============================================================================*/
#ifndef _GTK_EIFFEL_H_INCLUDED_
#define _GTK_EIFFEL_H_INCLUDED_

/*==============================================================================
 Included files
==============================================================================*/

#include <gtk/gtk.h>
#include <stdlib.h>
#include "eif_eiffel.h"
#include "eif_argv.h"

char * c_match_font_name (char * pattern);

EIF_REFERENCE generize (EIF_OBJECT g_item);

/*==============================================================================
 gtk_window functions
==============================================================================*/

void c_gtk_window_set_modal(GtkWindow* window, gboolean modal);

void
c_gdk_colormap_query_color (GdkColormap *colormap,
			  gulong       pixel,
			  GdkColor    result);

#endif
