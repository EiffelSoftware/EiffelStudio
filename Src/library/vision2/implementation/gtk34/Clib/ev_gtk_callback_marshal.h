/*
indexing
	description: "C features of EV_GTK_CALLBACK_MARSHAL, see ev_callback_marshal.e."
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

#ifndef _EV_GTK_CALLBACK_MARSHAL_H_INCLUDED_
#define _EV_GTK_CALLBACK_MARSHAL_H_INCLUDED_

#include <ev_gtk.h>

void c_ev_gtk_callback_marshal_init
	(EIF_REFERENCE, void (*) (
		EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_POINTER, EIF_POINTER)
	);

void c_ev_gtk_callback_marshal_destroy ();

int c_ev_gtk_callback_marshal_is_enabled;
void c_ev_gtk_callback_marshal_set_is_enabled (int);

guint c_ev_gtk_disconnect_all_signals (gpointer);

guint c_ev_gtk_callback_marshal_signal_connect
	(gpointer, const gchar*, EIF_OBJECT, gboolean);

guint c_ev_gtk_callback_marshal_timeout_connect (gint, EIF_OBJECT);

#endif
