//------------------------------------------------------------------------------
// ev_c_util.c
//------------------------------------------------------------------------------
// description: "C features of EV_C_UTILS"
// status: "See notice at end of file"
// date: "$Date$"
// revision: "$Revision$"
//------------------------------------------------------------------------------

#include "ev_c_util.h"
#include "eif_except.h"

EIF_REAL double_array_i_th (double *double_array, int index)
{
	return (EIF_REAL) double_array [index];
}

GtkArg* gtk_args_array_i_th (GtkArg** args_array, int index)
{
	return (GtkArg*)args_array + index;
}

void ev_gtk_log (
	const gchar* log_domain,
	GLogLevelFlags log_level,
	const gchar* message,
	gpointer user_data
) {
	static char buf[1000];
	char* level;
	int fatal = FALSE;
	int a_debug_mode;
	a_debug_mode = (int) user_data;

	if (a_debug_mode > 0)
	{
	// If no debugging is set then everything is left to DBC
	switch (log_level) {
	case G_LOG_LEVEL_ERROR:
		level = "ERROR";
		fatal = TRUE;
		break;
	case G_LOG_LEVEL_CRITICAL:
		level = "CRITICAL";
		fatal = TRUE;
		break;
	case G_LOG_LEVEL_WARNING:
		level = "WARNING";
		break;
	case G_LOG_LEVEL_MESSAGE:
		level = "MESSAGE";
		break;
	case G_LOG_LEVEL_INFO:
		level = "INFO";
		break;
	case G_LOG_LEVEL_DEBUG:
		level = "DEBUG";
	default:
		level = "UNKNOWN";
		fatal = TRUE;
	}
	if ( strlen (log_domain) + strlen (level) + strlen (message) + 2 > 999 ) {
		if ( strlen (log_domain) + strlen (level) > 999 ) {
			sprintf (buf, "%s-%s\n", log_domain, level);
		} else {
			sprintf (buf, "GTK-%s\n", level);
		}
	} else {
		sprintf (buf, "%s-%s %s", log_domain, level, message);
	}
	printf ("%s\n", buf);
	if (fatal && a_debug_mode > 1) {
		eraise (buf, EN_EXT);
	}
	}
}

void enable_ev_gtk_log (int a_mode)
{
	g_log_set_handler ("Gtk", G_LOG_LEVEL_ERROR | G_LOG_LEVEL_CRITICAL |
		G_LOG_LEVEL_WARNING | G_LOG_LEVEL_MESSAGE | G_LOG_LEVEL_INFO |
		G_LOG_LEVEL_DEBUG | G_LOG_FLAG_FATAL, ev_gtk_log, (gpointer) a_mode);
    g_log_set_handler ("Gdk", G_LOG_LEVEL_ERROR | G_LOG_LEVEL_CRITICAL |
        G_LOG_LEVEL_WARNING | G_LOG_LEVEL_MESSAGE | G_LOG_LEVEL_INFO |
		G_LOG_LEVEL_DEBUG | G_LOG_FLAG_FATAL, ev_gtk_log, (gpointer) a_mode);
	g_log_set_handler ("GLib",  G_LOG_LEVEL_ERROR | G_LOG_LEVEL_CRITICAL |
        G_LOG_LEVEL_WARNING | G_LOG_LEVEL_MESSAGE | G_LOG_LEVEL_INFO |
        G_LOG_LEVEL_DEBUG | G_LOG_FLAG_FATAL, ev_gtk_log, (gpointer) a_mode);
    g_log_set_handler (NULL,  G_LOG_LEVEL_ERROR | G_LOG_LEVEL_CRITICAL |
        G_LOG_LEVEL_WARNING | G_LOG_LEVEL_MESSAGE | G_LOG_LEVEL_INFO |
        G_LOG_LEVEL_DEBUG | G_LOG_FLAG_FATAL, ev_gtk_log, (gpointer) a_mode);
}


//------------------------------------------------------------------------------
// EiffelVision2: library of reusable components for ISE Eiffel.
// Copyright (C) 1986-1999 Interactive Software Engineering Inc.
// All rights reserved. Duplication and distribution prohibited.
// May be used only with ISE Eiffel, under terms of user license.
// Contact ISE for any other use.
//
// Interactive Software Engineering Inc.
// ISE Building, 2nd floor
// 270 Storke Road, Goleta, CA 93117 USA
// Telephone 805-685-1006, Fax 805-685-6869
// Electronic mail <info@eiffel.com>
// Customer support e-mail <support@eiffel.com>
// For latest info see award-winning pages: http://www.eiffel.com
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// CVS log
//------------------------------------------------------------------------------
//
// $Log$
// Revision 1.10  2001/08/30 19:17:09  king
// Made log message buffer static
//
// Revision 1.9  2001/08/24 20:50:08  king
// Removed unused external
//
// Revision 1.8  2001/08/03 18:41:26  king
// Removed no longer needed externals
//
// Revision 1.7  2001/07/24 19:00:30  king
// Corrected debugging output, slight optimization of logging
//
// Revision 1.6  2001/06/07 23:07:59  rogers
// Merged DEVEL branch into Main trunc.
//
// Revision 1.5.2.9  2001/06/05 17:32:09  king
// Including all gtk message logging domains
//
// Revision 1.5.2.8  2001/06/05 01:29:55  king
// Updated message logging modes
//
// Revision 1.5.2.7  2001/06/04 20:05:01  king
// Updated enable_ev_gtk_log to include debig signature
//
// Revision 1.5.2.6  2001/06/04 19:05:19  king
// Removed printing of error messages for later debug mechanism
//
// Revision 1.5.2.5  2000/11/29 00:40:42  king
// Implemented gtk_args_array_i_th
//
// Revision 1.5.2.4  2000/10/12 16:20:49  king
// Removed set_pixmap_and_mask
//
// Revision 1.5.2.3  2000/10/02 23:14:10  king
// Added test set_pixmap_and_mask
//
// Revision 1.5.2.2  2000/07/20 18:38:33  king
// Added double_array_i_th
//
// Revision 1.5.2.1  2000/05/03 19:08:33  oconnor
// mergred from HEAD
//
// Revision 1.5  2000/04/18 21:43:23  king
// Moved string_pointer_deref definition from header to source
//
// Revision 1.4  2000/04/18 17:58:01  oconnor
// Renamed get_pointer_from_array_by_index -> pointer_array_i_th
// Added string_pointer_deref (pointer: POINTER): POINTER
//
// Revision 1.3  2000/02/17 22:40:58  oconnor
// modified eraise call to not need snprintf, NOt avalible on Solaris.
//
// Revision 1.2  2000/02/14 12:05:08  oconnor
// added from prerelease_20000214
//
// Revision 1.1.2.4  2000/02/11 04:53:18  oconnor
// tweaked log
//
// Revision 1.1.2.3  2000/02/11 04:48:50  oconnor
// attached GTK+ exception system to Eiffel
//
// Revision 1.1.2.2  2000/01/17 17:58:35  brendel
// Removed strange CVS log.
//
// Revision 1.1.2.1  2000/01/14 22:17:14  brendel
// Initial.
//
//------------------------------------------------------------------------------
// End of CVS log
//------------------------------------------------------------------------------
