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

#include <eif_eiffel.h>
#include <gtk/gtk.h>
#include "ev_gtk_callback_marshal.h"

EIF_OBJECT ev_gtk_callback_marshal_object;

void (*ev_gtk_callback_marshal)
    (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_POINTER, EIF_POINTER);

void c_ev_gtk_callback_marshal_init (
    EIF_REFERENCE callback_marshal_object,
    void (*callback_marshal) (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_POINTER, EIF_POINTER)
)
        // Store the address of the Eiffel callback marshal in a global.
{
        ev_gtk_callback_marshal_object = eif_protect(callback_marshal_object);
        ev_gtk_callback_marshal = callback_marshal;
}

int c_ev_gtk_callback_marshal_is_enabled;

void c_ev_gtk_callback_marshal_set_is_enabled (int enabled_state)
{
	c_ev_gtk_callback_marshal_is_enabled = enabled_state;
}

void c_ev_gtk_callback_marshal_destroy (void)
		// Disconnect marshal from the eiffel system.
{
       /* eif_wean (ev_gtk_callback_marshal_object);
        ev_gtk_callback_marshal_object = NULL;
        ev_gtk_callback_marshal = NULL;*/
}

void c_ev_gtk_callback_marshal (
    GClosure *closure, GValue *return_value, guint n_param_values, const GValue *param_values, gpointer invocation_hint, gpointer marshal_data
)
        // Called by GTK when an `object' emits a signal,
        // Call an `agent' with `n_args' `args'.
{
	if (c_ev_gtk_callback_marshal_is_enabled)
		ev_gtk_callback_marshal (
			eif_access (ev_gtk_callback_marshal_object),
			eif_access ((EIF_OBJECT) closure->data),
			(EIF_INTEGER) n_param_values - 1,
			(EIF_POINTER) ((GValue*)param_values + 1),
			return_value
       	 	);
}

int c_ev_gtk_callback_marshal_true_callback (EIF_OBJECT agent)
		// GtkFunction that passes `agent' to ev_gtk_callback_marshal
		// and returns TRUE
{
      if (c_ev_gtk_callback_marshal_is_enabled)
                ev_gtk_callback_marshal (
                        eif_access (ev_gtk_callback_marshal_object),
                        eif_access (agent),
                        0,
                        (EIF_POINTER) NULL,
			NULL
        );
      return TRUE;
}


void dummy_callback (void)
{
	// Do nothing
	printf ("This should not be called\n");
}

void gclosure_notify_eif_wean (gpointer data, GClosure *closure) 
{
	/* closure notify to be called when user `data` is no longer used */
	if (data) {
		eif_wean ((EIF_OBJECT) data);
	}
}

void gdestroy_notify_eif_wean (gpointer data)
{
	if (data) {
		eif_wean ((EIF_OBJECT) data);
	}
}

guint c_ev_gtk_callback_marshal_signal_connect (
    gpointer c_object,
    const gchar* signal,
    EIF_OBJECT agent,
    gboolean invoke_after_handler
)
		// Connect an `agent' to a named `signal' emitted by a GTK `c_object'.
		// Return connection id.
{
	guint connection_id;
	GClosure *closure;
	EIF_OBJECT adopted_agent;

	//closure = g_cclosure_new (dummy_callback, eif_adopt (agent), (GClosureNotify)gclosure_notify_eif_wean);
	//g_closure_set_marshal (closure, c_ev_gtk_callback_marshal);
	
	adopted_agent = eif_adopt (agent);

	closure = g_closure_new_simple (sizeof(GClosure), adopted_agent);
    g_closure_add_invalidate_notifier(closure, (gpointer) adopted_agent, (GClosureNotify)gclosure_notify_eif_wean);
    //g_closure_add_finalize_notifier (closure, adopted_agent, (GClosureNotify)gclosure_notify_eif_wean);
	g_closure_set_marshal (closure, c_ev_gtk_callback_marshal);

	connection_id = g_signal_connect_closure (c_object, signal, closure, invoke_after_handler);
	return connection_id;
}

guint c_ev_gtk_callback_marshal_timeout_connect (
    gint delay, EIF_OBJECT agent
)
        // Call an `agent' every `delay' milliseconds.
{
	guint connection_id;
	connection_id = g_timeout_add_full (
				G_PRIORITY_DEFAULT,
				delay,
				(GSourceFunc) c_ev_gtk_callback_marshal_true_callback,
				eif_adopt (agent),          // User data for function.
				(GDestroyNotify) gdestroy_notify_eif_wean // To call on hook disconnect.
			);
	return (connection_id);
}


