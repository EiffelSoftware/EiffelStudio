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
    // debug
		/*
        g_log (G_LOG_DOMAIN, G_LOG_LEVEL_DEBUG,
            "c_ev_gtk_callback_marshal_init (%X, %X)",
            (int) callback_marshal_object,
            (int) callback_marshal
        );
		*/
    // require
            g_assert (callback_marshal_object != NULL);
            g_assert (callback_marshal != NULL);
    // do
            ev_gtk_callback_marshal_object = eif_adopt(callback_marshal_object);
            ev_gtk_callback_marshal = callback_marshal;
    // ensure
            g_assert (
                eif_access (ev_gtk_callback_marshal_object)
                == eif_access (callback_marshal_object)
            );
            g_assert (ev_gtk_callback_marshal == callback_marshal);
    // end
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
    // debug
		/*
        g_log (G_LOG_DOMAIN, G_LOG_LEVEL_DEBUG,
            "c_ev_gtk_callback_marshal (%X (%s), %X, %d, %X)",
            (int) object, 
            object ? gtk_type_name (GTK_OBJECT_TYPE (object)) : "",
            (int) agent,
            n_args,
            (int) args
        );
		*/
		
    // require
            // `object' == NULL on idle callback.
            // We do not use `object', so no need for precondition.
            // g_assert (object != NULL);
            g_assert (agent != NULL);
            g_assert (ev_gtk_callback_marshal_object != NULL || ev_gtk_callback_marshal == NULL);
    // do
			if (ev_gtk_callback_marshal != NULL) {
				ev_gtk_callback_marshal (
					eif_access (ev_gtk_callback_marshal_object),
					eif_access (agent),
					(EIF_INTEGER) n_args,
					(EIF_POINTER) args 
				);
			}
    // end
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
    // local
            guint connection_id;
    // debug
		/*
        g_log (G_LOG_DOMAIN, G_LOG_LEVEL_DEBUG,
            "c_ev_gtk_callback_marshal_signal_connect (%X (%s), %s, %X)",
            (int) c_object, 
            gtk_type_name (GTK_OBJECT_TYPE (c_object)),
            signal,
            (int) agent
        );
		*/
    // require
            g_assert (c_object != NULL);
            g_assert (signal != NULL);
            g_assert (agent != NULL);
            g_assert (ev_gtk_callback_marshal_object != NULL);
            g_assert (ev_gtk_callback_marshal != NULL);
    // do
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
    // ensure
            g_assert (connection_id > 0);
    // end
	return connection_id;
}

void c_ev_gtk_callback_marshal_signal_connect_true (
    GtkObject* c_object,
    const gchar* signal,
    EIF_OBJECT agent
)
		// Connect an `agent' to a named `signal' emmited by a GTK `c_object'.
		// Callback always returns true.
{
    // debug
		/*
        g_log (G_LOG_DOMAIN, G_LOG_LEVEL_DEBUG,
            "c_ev_gtk_callback_marshal_signal_connect_true (%X (%s), %s, %X)",
            (int) c_object, 
            gtk_type_name (GTK_OBJECT_TYPE (c_object)),
            signal,
            (int) agent
        );
		*/
    // require
            g_assert (c_object != NULL);
            g_assert (signal != NULL);
            g_assert (agent != NULL);
            g_assert (ev_gtk_callback_marshal_object != NULL);
            g_assert (ev_gtk_callback_marshal != NULL);
    // do
            gtk_signal_connect_full (
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
	// end
}


int c_ev_gtk_callback_marshal_true_callback (EIF_OBJECT agent)
		// GtkFunction that passes `agent' to ev_gtk_callback_marshal
		// and returns TRUE
{
    // debug
		/*
        g_log (G_LOG_DOMAIN, G_LOG_LEVEL_DEBUG,
            "c_ev_gtk_callback_marshal_true_callback (%X)",
            (int) agent
        );
		*/
    // require
            g_assert (agent != NULL);
            g_assert (ev_gtk_callback_marshal_object != NULL);
            g_assert (ev_gtk_callback_marshal != NULL);
    // do
            ev_gtk_callback_marshal (
                eif_access (ev_gtk_callback_marshal_object),
                eif_access (agent),
                0,
                (EIF_POINTER) NULL 
            );
            return TRUE;
    // end
}

int c_ev_gtk_callback_marshal_true_event_callback (
		GtkWidget *widget, GdkEvent *event, EIF_OBJECT agent
)
		//
{
    // debug
		/*
        g_log (G_LOG_DOMAIN, G_LOG_LEVEL_DEBUG,
            "c_ev_gtk_callback_marshal_true_event_callback (%X)",
            (int) agent
        );
		*/
    // require
            g_assert (widget != NULL);
            g_assert (event != NULL);
            g_assert (agent != NULL);
            g_assert (ev_gtk_callback_marshal_object != NULL);
            g_assert (ev_gtk_callback_marshal != NULL);
    // do
            ev_gtk_callback_marshal (
                eif_access (ev_gtk_callback_marshal_object),
                eif_access (agent),
                0,
                (EIF_POINTER) NULL 
            );
            return TRUE;
    // end
}

int c_ev_gtk_callback_marshal_delayed_agent_callback (EIF_OBJECT agent)
		// GtkFunction that passes `agent' to ev_gtk_callback_marshal
		// and returns FALSE to prevent subsequent calls.
{
    // debug
		/*
        g_log (G_LOG_DOMAIN, G_LOG_LEVEL_DEBUG,
            "c_ev_gtk_callback_marshal_false_callback (%X)",
            (int) agent
        );
		*/
    // require
            g_assert (agent != NULL);
            g_assert (ev_gtk_callback_marshal_object != NULL);
            g_assert (ev_gtk_callback_marshal != NULL);
    // do
            ev_gtk_callback_marshal (
                eif_access (ev_gtk_callback_marshal_object),
                eif_access (agent),
                0,
                (EIF_POINTER) NULL 
            );
            eif_wean (agent);
            return FALSE;
    // end
}

void c_ev_gtk_callback_marshal_delayed_agent_call (
    gint delay, EIF_OBJECT agent
)
        // Call an `agent' after `delay' milliseconds.
		// Uses c_ev_gtk_callback_marshal_false_callback so that `agent' is
		// only called once.
{
    // local
            gint connection_id;
    // debug
		/*
        g_log (G_LOG_DOMAIN, G_LOG_LEVEL_DEBUG,
            "c_ev_gtk_marshal_delayed_agent_call (%d, %X)",
            delay, 
            (int) agent
        );
		*/
    // require
            g_assert (delay >= 0);
            g_assert (agent != NULL);
            g_assert (ev_gtk_callback_marshal_object != NULL);
            g_assert (ev_gtk_callback_marshal != NULL);
    // do
            connection_id = gtk_timeout_add (
				delay,
				(GtkFunction)
                c_ev_gtk_callback_marshal_delayed_agent_callback,
                eif_adopt (agent)
			);
    // ensure
            g_assert (connection_id > 0);
    // end
}

guint c_ev_gtk_callback_marshal_timeout_connect (
    gint delay, EIF_OBJECT agent
)
        // Call an `agent' every `delay' milliseconds.
{
    // local
            guint connection_id;
    // debug
		/*
        g_log (G_LOG_DOMAIN, G_LOG_LEVEL_DEBUG,
            "c_ev_gtk_marshal_delayed_agent_call (%d, %X)",
            delay, 
            (int) agent
        );
		*/
    // require
            g_assert (delay >= 0);
            g_assert (agent != NULL);
            g_assert (ev_gtk_callback_marshal_object != NULL);
            g_assert (ev_gtk_callback_marshal != NULL);
    // do
            connection_id = gtk_timeout_add_full (
				delay,
				(GtkFunction)
                c_ev_gtk_callback_marshal_true_callback,
				NULL,                       // No special marshal needed.
                eif_adopt (agent),          // User data for function.
                (GtkDestroyNotify)
                eif_wean                    // To call on hook disconnect.
			);
    // ensure
            g_assert (connection_id > 0);
    // end
		return (connection_id);
}

guint c_ev_gtk_callback_marshal_idle_connect (EIF_OBJECT agent)
        // Call an `agent' when idle.
{
    // local
            guint connection_id;
    // debug
		/*
        g_log (G_LOG_DOMAIN, G_LOG_LEVEL_DEBUG,
            "c_ev_gtk_marshal_delayed_agent_call (%d, %X)",
            delay, 
            (int) agent
        );
		*/
    // require
            g_assert (agent != NULL);
            g_assert (ev_gtk_callback_marshal_object != NULL);
            g_assert (ev_gtk_callback_marshal != NULL);
    // do
            connection_id = gtk_idle_add_full (
				GTK_PRIORITY_DEFAULT,      // Priority.
				(GtkFunction)               // Function pointer to attach.
				c_ev_gtk_callback_marshal_true_callback,
				NULL,                      // Function marshal.
				eif_adopt (agent),         // User data for function.
				(GtkDestroyNotify)
				eif_wean                   // To call on hook disconnect.
			);
    // ensure
            g_assert (connection_id > 0);
    // end
		return (connection_id);
}

guint c_ev_gtk_callback_marshal_delete_connect (
	GtkObject* c_object, EIF_OBJECT agent
)
		// Call an `agent' when `c_object' emmits "delete-event".
{
		int connection_id;
	// debug
		/*
		g_log (G_LOG_DOMAIN, G_LOG_LEVEL_DEBUG,
			"c_ev_gtk_marshal_delayed_agent_call (%d, %X)",
			delay,
			(int) agent
		);
		*/
	// require
		g_assert (agent != NULL);
		g_assert (ev_gtk_callback_marshal_object != NULL);
		g_assert (ev_gtk_callback_marshal != NULL);
	// do
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
	// ensure
		g_assert (connection_id > 0);
	// end
		return (connection_id);
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
// Revision 1.11  2001/06/07 23:07:59  rogers
// Merged DEVEL branch into Main trunc.
//
// Revision 1.10.2.5  2000/09/18 23:55:40  oconnor
// Added c_ev_gtk_callback_marshal_destroy
// This stops EV_APPLICATION.marshal from being called
//
// Revision 1.10.2.4  2000/08/09 19:06:40  king
// Corrected signal_connect_true to use event_callback
//
// Revision 1.10.2.3  2000/08/07 21:53:58  king
// Corrected debug output for connect_true
//
// Revision 1.10.2.2  2000/08/04 19:37:14  king
// Added c_ev_gtk_callback_marshal_signal_connect_true
//
// Revision 1.10.2.1  2000/05/03 19:08:33  oconnor
// mergred from HEAD
//
// Revision 1.10  2000/04/14 18:26:58  oconnor
// Make sure that idle callback returns TRUE so that GTK dose not
// disconnect it after it is called.
//
// Revision 1.9  2000/04/04 20:33:51  oconnor
// syntax
//
// Revision 1.8  2000/04/04 20:28:13  oconnor
// made log in marshal NULL object safe
//
// Revision 1.7  2000/04/01 01:24:43  oconnor
// syntax
//
// Revision 1.6  2000/04/01 01:10:15  oconnor
// formatting
//
// Revision 1.5  2000/03/27 19:30:31  brendel
// Commented out precondition.
//
// Revision 1.4  2000/03/08 16:46:44  brendel
// Added cast so that no compiler warning appears anymore.
//
// Revision 1.3  2000/02/18 19:11:52  oconnor
// added GTK_VALUE_INT wrapper
//
// Revision 1.2  2000/02/14 12:05:08  oconnor
// added from prerelease_20000214
//
// Revision 1.1.4.9  2000/01/28 21:51:17  oconnor
// added c_ev_gtk_callback_marshal_delete_connect
//
// Revision 1.1.4.8  2000/01/20 22:04:25  oconnor
// added idle connect function
//
// Revision 1.1.4.7  2000/01/19 08:07:39  oconnor
// commented out debugging info
//
// Revision 1.1.4.6  2000/01/17 23:24:27  oconnor
// syntax and type fixes in c_ev_gtk_callback_marshal_timeout_connect
//
// Revision 1.1.4.5  2000/01/17 23:20:47  oconnor
// added c_ev_gtk_callback_marshal_timeout_connect
//
// Revision 1.1.4.4  1999/12/13 19:43:58  oconnor
// commented out logging
//
// Revision 1.1.4.3  1999/12/09 18:16:08  oconnor
// added signal_disconnect
//
// Revision 1.1.4.2  1999/12/08 01:47:13  oconnor
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
//
//------------------------------------------------------------------------------
// End of CVS log
//------------------------------------------------------------------------------
