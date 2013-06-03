/*
indexing
	description: "C features of IO_WATCHER."
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

#include "io_watcher.h"

void (*eif_on_event) (EIF_REFERENCE, EIF_INTEGER);

void add_watch_callback (EIF_OBJECT io_watcher, gint handle, GIOCondition condition, gint* connection_id) 
	// Set up `on_event' callback for `io_watcher' when an event occurs
	// on medium referenced by `handle'.
{
	GIOChannel* g_channel = NULL;
	g_channel = g_io_channel_unix_new (handle);
	*connection_id = g_io_add_watch_full (
		g_channel,
		G_PRIORITY_DEFAULT_IDLE,
		condition,
		c_io_watcher_marshal,
		eif_adopt (io_watcher),
		(GDestroyNotify) eif_wean
	);
	g_io_channel_unref (g_channel);
}

gboolean c_io_watcher_marshal (
	GIOChannel* source, 
	GIOCondition condition,
	gpointer io_watcher
)
	// Call `io_watcher'.on_event.
{
	eif_on_event (eif_access ((EIF_OBJECT) io_watcher), (EIF_INTEGER) condition);
	return TRUE;
}
