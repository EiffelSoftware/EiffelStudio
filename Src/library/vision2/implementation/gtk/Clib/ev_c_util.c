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

void * get_pointer_from_array_by_index (void ** pointer_array, int index)
{
	return pointer_array [index];
}

void ev_gtk_log (
	const gchar *log_domain,
	GLogLevelFlags log_level,
	const gchar *message,
	gpointer user_data
) {
	char buf[1000];
	char* level;
	int fatal = FALSE;
	

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
	snprintf (buf, 999, "%s-%s %s", log_domain, level, message);
	printf ("%s\n", buf);
	if (fatal) {
		eraise (buf, EN_EXT);
	}
}

void enable_ev_gtk_log (void)
{
	g_log_set_handler ("Gtk", G_LOG_LEVEL_ERROR | G_LOG_LEVEL_CRITICAL | G_LOG_LEVEL_WARNING | G_LOG_LEVEL_MESSAGE | G_LOG_LEVEL_INFO | G_LOG_LEVEL_DEBUG | G_LOG_FLAG_FATAL, ev_gtk_log, NULL);
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
