//------------------------------------------------------------------------------
// io_watcher.c
//------------------------------------------------------------------------------
// description: "C features of IO_WATCHER, see io_watcher.e"
// status: "See notice at end of file"
// date: "$Date$"
// revision: "$Revision$"
//------------------------------------------------------------------------------

#include <eif_eiffel.h>
#include <glib.h>
#include "io_watcher.h"

void (*eif_on_event) (EIF_REFERENCE, EIF_INTEGER);


void c_io_watcher_initialize_callback (
	void (*on_event_address) (EIF_REFERENCE, EIF_INTEGER)
)
		// Assign `on_event_address' to `eif_on_event'.
{
	// require
		g_assert (on_event_address != NULL);
	// do
		eif_on_event = on_event_address;
	// ensure
		g_assert (eif_on_event == on_event_address);
	// end
}


void c_io_watcher_marshal (
	GIOChannel* source, 
	GIOCondition condition,
	EIF_OBJECT io_watcher
)
		// Call `io_watcher'.on_event.
{
	// require
		g_assert (source != NULL);
		g_assert (condition > 0);
		g_assert (io_watcher != NULL);
	// do
		eif_on_event (eif_access (io_watcher), condition);
	// end
}


guint c_io_watcher_add_watch_callback (EIF_OBJECT io_watcher, gint handle)
		// Set up callback of `io_watcher'.on_event when an event occurs
		// on medium referenced by `handle'.
{
	// local
		guint connection_id = 0;
		GIOChannel* g_channel = NULL;
	// require
		g_assert (io_watcher != NULL);
		g_assert (handle > 0);
		g_assert (eif_on_event != NULL);
	// do
			g_channel = g_io_channel_unix_new (handle);
			g_assert (g_channel != NULL);
			connection_id = g_io_add_watch_full (
				g_channel,
				G_PRIORITY_DEFAULT_IDLE,
				G_IO_IN,
				(GIOFunc) c_io_watcher_marshal,
				eif_adopt (io_watcher),
				(GDestroyNotify) eif_wean
			);
			g_io_channel_unref (g_channel);
	// ensure
		g_assert (connection_id > 0);
	// end
	return connection_id;
}


//------------------------------------------------------------------------------
// EiffelEvent: library of reusable components for ISE Eiffel.
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
// Revision 1.1  2000/08/10 17:37:59  etienne
// Moved file from .. to separate C code from Eiffel code.
//
// Revision 1.1  2000/05/16 16:05:10  oconnor
// initial
//
//------------------------------------------------------------------------------
// End of CVS log
//------------------------------------------------------------------------------

