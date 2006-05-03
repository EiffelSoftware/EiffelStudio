/*
indexing
	description: "C features of IO_WATCHER, see io_watcher.e for important notes."
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

#ifndef _IO_WATCHER_H_INCLUDED_
#define _IO_WATCHER_H_INCLUDED_

#include <eif_eiffel.h>
#include <glib.h>

extern void (*eif_on_event) (EIF_REFERENCE, EIF_INTEGER);

extern void add_watch_callback (EIF_OBJECT io_watcher, gint handle, GIOCondition condition, gint* connection_id);

extern gboolean c_io_watcher_marshal (
	GIOChannel* source, 
	GIOCondition condition,
	gpointer io_watcher
);

#endif
