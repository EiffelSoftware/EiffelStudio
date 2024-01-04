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


extern void c_ev_gtk_callback_marshal_init
#ifdef EIF_IL_DLL
		(
			void (*) (EIF_POINTER, EIF_INTEGER, EIF_POINTER, EIF_POINTER),
			void (*) (EIF_POINTER) /* free */
#else
		(
			EIF_REFERENCE, /*EV_GTK_MARSHAL*/
			void (*) (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_POINTER, EIF_POINTER)
#endif
		);

extern void c_ev_gtk_callback_marshal_destroy ();

extern int c_ev_gtk_callback_marshal_is_enabled;
extern void c_ev_gtk_callback_marshal_set_is_enabled (int);

extern guint c_ev_gtk_callback_marshal_signal_connect
		(gpointer,
		 const gchar*,
#ifdef EIF_IL_DLL
		 EIF_POINTER,
#else
		 EIF_OBJECT,
#endif
		 gboolean);
#else

extern guint c_ev_gtk_callback_marshal_timeout_connect (gint,
#ifdef EIF_IL_DLL
	EIF_POINTER
#else
	EIF_OBJECT
#endif
	);

extern void gtk_set_dispatcher_object(EIF_OBJECT _addr_);
#   define cgtk_set_dispatcher_object(_addr_) gtk_set_dispatcher_object(_addr_)
        /* Set `dispatcher' with `eif_adopt (addr)' */

extern void gtk_release_dispatcher_object();

#   define cgtk_release_dispatcher_object gtk_release_dispatcher_object()
        /* Release `dispatcher' object. */

#endif
