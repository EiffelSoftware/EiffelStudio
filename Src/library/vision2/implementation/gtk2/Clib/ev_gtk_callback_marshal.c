//------------------------------------------------------------------------------
// ev_gtk_callback_marshal.c
//------------------------------------------------------------------------------
// description:
//     "C features of EV_GTK_CALLBACK_MARSHAL, see ev_callback_marshal.e" 
// status: "See notice at end of file"
// date: "$Date$"
// revision: "$Revision$"
//------------------------------------------------------------------------------

#include <eif_eiffel.h>
#include <gtk/gtk.h>
#include "ev_gtk_callback_marshal.h"

EIF_OBJECT ev_gtk_callback_marshal_object;

void (*ev_gtk_callback_marshal)
    (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_POINTER);

void c_ev_gtk_callback_marshal_init (
    EIF_OBJECT callback_marshal_object,
    void (*callback_marshal)
	    (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_POINTER)
)
        // Store the address of the Eiffel callback marshal in a global.
{
            ev_gtk_callback_marshal_object = eif_adopt(callback_marshal_object);
            ev_gtk_callback_marshal = callback_marshal;
}

void c_ev_gtk_callback_marshal_destroy (Void)
		// Disconnect marshal from the eiffel system.
{
	eif_wean (ev_gtk_callback_marshal_object);
	ev_gtk_callback_marshal_object = NULL;
	ev_gtk_callback_marshal = NULL;
}

void c_ev_gtk_callback_marshal (
    GtkObject* object, EIF_OBJECT agent, guint n_args, GtkArg* args
)
        // Called by GTK when an `object' emits a signal,
        // Call an `agent' with `n_args' `args'.
{
			if (ev_gtk_callback_marshal != NULL) {
				ev_gtk_callback_marshal (
					eif_access (ev_gtk_callback_marshal_object),
					eif_access (agent),
					(EIF_INTEGER) n_args,
					(EIF_POINTER) args 
				);
			}
}

// FIXME temporary wrapper for GTK_VALUE_POINTER should really be elsewhere
void* gtk_value_pointer (void* p)
{
	return (GTK_VALUE_POINTER(*(GtkArg*)p));
}

int gtk_value_int (void* p)
{
	return (GTK_VALUE_INT(*(GtkArg*)p));
}

guint c_ev_gtk_callback_marshal_signal_connect (
    GtkObject* c_object,
    const gchar* signal,
    EIF_OBJECT agent
)
		// Connect an `agent' to a named `signal' emmited by a GTK `c_object'.
		// Return connection id.
{
            guint connection_id;
            connection_id = gtk_signal_connect_full (
                c_object,                  // Object which emits the signal.
                signal,                    // Name of the signal.
                NULL,                      // Function pointer to attach.
                (GtkCallbackMarshal)
                c_ev_gtk_callback_marshal, // Function marshal.
                eif_adopt (agent),         // User data for function.
                (GtkDestroyNotify)
                eif_wean,                  // To call on hook disconnect.
                FALSE,                     // This is an object signal.
                FALSE                      // Invoke handler after the signal.
            );
	return connection_id;
}

guint c_ev_gtk_callback_marshal_signal_connect_true (
    GtkObject* c_object,
    const gchar* signal,
    EIF_OBJECT agent
)
		// Connect an `agent' to a named `signal' emmited by a GTK `c_object'.
		// Callback always returns true.
{
			guint connection_id;
            connection_id = gtk_signal_connect_full (
                c_object,                  // Object which emits the signal.
                signal,                    // Name of the signal.
                (GtkSignalFunc) c_ev_gtk_callback_marshal_true_event_callback,  // Function pointer to attach.
                NULL, // Function marshal.
                eif_adopt (agent),         // User data for function.
                (GtkDestroyNotify)
                eif_wean,                  // To call on hook disconnect.
                FALSE,                     // This is an object signal.
                FALSE                      // Invoke handler after the signal.
            );
	return connection_id;
}


int c_ev_gtk_callback_marshal_true_callback (EIF_OBJECT agent)
		// GtkFunction that passes `agent' to ev_gtk_callback_marshal
		// and returns TRUE
{
            ev_gtk_callback_marshal (
                eif_access (ev_gtk_callback_marshal_object),
                eif_access (agent),
                0,
                (EIF_POINTER) NULL 
            );
            return TRUE;
}

int c_ev_gtk_callback_marshal_true_event_callback (
		GtkWidget *widget, GdkEvent *event, EIF_OBJECT agent
)
		//
{
            ev_gtk_callback_marshal (
                eif_access (ev_gtk_callback_marshal_object),
                eif_access (agent),
                0,
                (EIF_POINTER) NULL 
            );
            return TRUE;
}

int c_ev_gtk_callback_marshal_delayed_agent_callback (EIF_OBJECT agent)
		// GtkFunction that passes `agent' to ev_gtk_callback_marshal
		// and returns FALSE to prevent subsequent calls.
{
            ev_gtk_callback_marshal (
                eif_access (ev_gtk_callback_marshal_object),
                eif_access (agent),
                0,
                (EIF_POINTER) NULL 
            );
            eif_wean (agent);
            return FALSE;
}

void c_ev_gtk_callback_marshal_delayed_agent_call (
    gint delay, EIF_OBJECT agent
)
        // Call an `agent' after `delay' milliseconds.
		// Uses c_ev_gtk_callback_marshal_false_callback so that `agent' is
		// only called once.
{
            gint connection_id;
            connection_id = gtk_timeout_add (
				delay,
				(GtkFunction)
                c_ev_gtk_callback_marshal_delayed_agent_callback,
                eif_adopt (agent)
			);
}

guint c_ev_gtk_callback_marshal_timeout_connect (
    gint delay, EIF_OBJECT agent
)
        // Call an `agent' every `delay' milliseconds.
{
            guint connection_id;
            connection_id = gtk_timeout_add_full (
				delay,
				(GtkFunction)
                c_ev_gtk_callback_marshal_true_callback,
				NULL,                       // No special marshal needed.
                eif_adopt (agent),          // User data for function.
                (GtkDestroyNotify)
                eif_wean                    // To call on hook disconnect.
			);
		return (connection_id);
}

guint c_ev_gtk_callback_marshal_idle_connect (EIF_OBJECT agent)
        // Call an `agent' when idle.
{
            guint connection_id;
            connection_id = gtk_idle_add_full (
				GTK_PRIORITY_DEFAULT,      // Priority.
				(GtkFunction)               // Function pointer to attach.
				c_ev_gtk_callback_marshal_true_callback,
				NULL,                      // Function marshal.
				eif_adopt (agent),         // User data for function.
				(GtkDestroyNotify)
				eif_wean                   // To call on hook disconnect.
			);
		return (connection_id);
}

guint c_ev_gtk_callback_marshal_delete_connect (
	GtkObject* c_object, EIF_OBJECT agent
)
		// Call an `agent' when `c_object' emmits "delete-event".
{
		int connection_id;
		connection_id = gtk_signal_connect_full (
			c_object,                  // Object which emits the signal.
			"delete-signal",           // Name of the signal.
			(GtkSignalFunc)
			c_ev_gtk_callback_marshal_true_event_callback,
				// Function pointer to attach.
			(GtkCallbackMarshal)
			gtk_marshal_BOOL__POINTER, // Function marshal.
			eif_adopt (agent),         // User data for function.
			(GtkDestroyNotify)
			eif_wean,                  // To call on hook disconnect.
			FALSE,                     // This is an object signal.
			FALSE                      // Invoke handler after the signal.
		);
		return (connection_id);
}

