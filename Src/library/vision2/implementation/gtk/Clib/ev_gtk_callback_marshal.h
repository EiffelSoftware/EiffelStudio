//------------------------------------------------------------------------------
// ev_gtk_callback_marshal.h
//------------------------------------------------------------------------------
// description:
//     "C features of EV_GTK_CALLBACK_MARSHAL, see ev_gtk_callback_marshal.c" 
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

void c_ev_gtk_callback_marshal_destroy ();

guint c_ev_gtk_callback_marshal_signal_connect
	(GtkObject*, const gchar*, EIF_OBJECT, gboolean);

guint c_ev_gtk_callback_marshal_signal_connect_true
	(GtkObject*, const gchar*, EIF_OBJECT);

int c_ev_gtk_callback_marshal_true_callback (EIF_OBJECT agent);

int c_ev_gtk_callback_marshal_true_event_callback (GtkWidget*, GdkEvent*, EIF_OBJECT);

guint c_ev_gtk_callback_marshal_timeout_connect (gint, EIF_OBJECT);

guint c_ev_gtk_callback_marshal_delete_connect (GtkObject*, EIF_OBJECT);


#endif
