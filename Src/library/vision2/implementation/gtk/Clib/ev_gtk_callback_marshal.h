//------------------------------------------------------------------------------
// ev_gtk_callback_marshal.h
//------------------------------------------------------------------------------
// description:
//     "C features of EV_GTK_CALLBACK_MARSHAL, see ev_gtk_callback_marshal.c" 
// status: "See notice at end of file"
// date: "$Date$"
// revision: "$Revision$"
//------------------------------------------------------------------------------

#ifndef _EV_GTK_CALLBACK_MARSHAL_H_INCLUDED_
#define _EV_GTK_CALLBACK_MARSHAL_H_INCLUDED_

#include <eif_eiffel.h>
#include <gtk/gtk.h>

void c_ev_gtk_callback_marshal_init
	(EIF_OBJECT, void (*) (
		EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_POINTER)
	);

guint c_ev_gtk_callback_marshal_signal_connect
	(GtkObject*, const gchar*, EIF_OBJECT);

void c_ev_gtk_callback_marshal_delayed_agent_call (gint, EIF_OBJECT);

guint c_ev_gtk_callback_marshal_timeout_connect (gint, EIF_OBJECT);

guint c_ev_gtk_callback_marshal_idle_connect (EIF_OBJECT);

guint c_ev_gtk_callback_marshal_delete_connect (GtkObject*, EIF_OBJECT);

void* gtk_value_pointer (void*);

#endif

//------------------------------------------------------------------------------
// CVS log
//------------------------------------------------------------------------------
//
// $Log$
// Revision 1.2  2000/02/14 12:05:08  oconnor
// added from prerelease_20000214
//
// Revision 1.1.4.6  2000/01/28 21:50:54  oconnor
// added c_ev_gtk_callback_marshal_delete_connect
//
// Revision 1.1.4.5  2000/01/20 22:04:25  oconnor
// added idle connect function
//
// Revision 1.1.4.4  2000/01/17 23:21:33  oconnor
// added c_ev_gtk_callback_marshal_timeout_connect
//
// Revision 1.1.4.3  1999/12/09 18:16:08  oconnor
// added signal_disconnect
//
// Revision 1.1.4.2  1999/12/08 01:47:14  oconnor
// added delayed agent calls to facilitate post launch actions.
//
// Revision 1.1.4.1  1999/11/23 23:43:14  oconnor
// rearranged C externals
//
// Revision 1.1.2.2  1999/11/23 02:06:11  oconnor
// added GTK_VALUE_POINTER wrapper
//
// Revision 1.1.2.1  1999/11/18 03:38:08  oconnor
// initial
//
//------------------------------------------------------------------------------
// End of CVS log
//------------------------------------------------------------------------------
