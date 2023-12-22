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
EIF_POINTER ev_gtk_dispatcher;

#ifdef EIF_IL_DLL
void (* ev_gtk_free) (EIF_POINTER);
#endif

void (*ev_gtk_callback_marshal)
#ifdef EIF_IL_DLL
    (EIF_POINTER,
#else
    (EIF_REFERENCE, EIF_REFERENCE,
#endif
     EIF_INTEGER, EIF_POINTER, EIF_POINTER);

void c_ev_gtk_callback_marshal_init (
#ifdef EIF_IL_DLL
    void (*callback_marshal) (EIF_POINTER, EIF_INTEGER, EIF_POINTER, EIF_POINTER),
    void (*callback_free) (EIF_POINTER)
#else
    EIF_REFERENCE callback_marshal_object,
    void (*callback_marshal) (EIF_REFERENCE, EIF_REFERENCE, EIF_INTEGER, EIF_POINTER, EIF_POINTER)
#endif
	)
        // Store the address of the Eiffel callback marshal in a global.
{
	printf("[Start] c_ev_gtk_callback_marshal_init\n");
#ifdef EIF_IL_DLL
	    printf("[.Net] Calling c_ev_gtk_callback_marshal_init\n");
	    ev_gtk_callback_marshal = callback_marshal;
	    printf("[.Net ev_gtk_callback_marshal] %p\n", ev_gtk_callback_marshal);
	    ev_gtk_free = callback_free;
	    printf("[.Net] Set ev_gtk_free\n");
#else
	    printf("[Classic] c_ev_gtk_callback_marshal_init\n");
	    ev_gtk_callback_marshal_object = eif_protect(callback_marshal_object);
	    ev_gtk_callback_marshal = callback_marshal;
#endif
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
	printf("[Start] c_ev_gtk_callback_marshal\n");

	if (c_ev_gtk_callback_marshal_is_enabled) {
		printf("[.Net] Calling ev_gtk_callback_marshal\n");
#ifdef EIF_IL_DLL
		printf("[.Net closure] %p\n", closure);
		printf("[.Net closure->data] %p\n", closure->data);
		printf("[.Net eif_access ((EIF_OBJECT) closure->data)] %p\n", eif_access ((EIF_OBJECT) closure->data));
		printf("[.Net params] %i\n", n_param_values - 1);
		printf("[.Net values] %p\n", ((GValue*)param_values + 1));
		printf("[.Net] Calling ev_gtk_callback_marshal causes a segmentation fault\n");
#endif
		ev_gtk_callback_marshal (
#ifdef EIF_IL_DLL
			(EIF_POINTER) closure->data,
#else
			eif_access (ev_gtk_callback_marshal_object),
			eif_access ((EIF_OBJECT) closure->data),
#endif
			(EIF_INTEGER) n_param_values - 1,
			(EIF_POINTER) ((GValue*)param_values + 1),
			(EIF_POINTER) return_value
      	 	);
		printf("after Calling ev_gtk_callback_marshal\n");
	}
}

int c_ev_gtk_callback_marshal_true_callback (
#ifdef EIF_IL_DLL
	EIF_POINTER
#else
	EIF_OBJECT
#endif
	adopted_agent)
	// GtkFunction that passes `agent' to ev_gtk_callback_marshal
	// and returns TRUE
{
    if (c_ev_gtk_callback_marshal_is_enabled) {
#ifdef EIF_IL_DLL
 	printf("[.Net] Calling ev_gtk_callback_marshal\n");
#endif
	ev_gtk_callback_marshal (
#ifdef EIF_IL_DLL
		adopted_agent,
#else
           	eif_access (ev_gtk_callback_marshal_object),
           	eif_access (adopted_agent),
#endif
		(EIF_INTEGER) 0,
		(EIF_POINTER) NULL,
		(EIF_POINTER) NULL
	);
    }
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
#ifdef EIF_IL_DLL
    EIF_POINTER agent,
#else
    EIF_OBJECT agent,
#endif
    gboolean invoke_after_handler
)
		// Connect an `agent' to a named `signal' emitted by a GTK `c_object'.
		// Return connection id.
{
	guint connection_id;
	GClosure *closure;

	printf("[Start] c_ev_gtk_callback_marshal_signal_connect\n");
#ifdef EIF_IL_DLL
	EIF_POINTER adopted_agent;
	printf("[NET: c_ev_gtk_callback_marshal_signal_connect]: Calling c_ev_gtk_callback_marshal_signal_connect\n");
	// Since we pass a pointer we don't need anymore eif_adopt
	//adopted_agent = (EIF_OBJECT) eif_adopt (agent);
	adopted_agent = agent;
	printf("[.Net agent] %p\n", agent);
#else
	EIF_OBJECT adopted_agent;
	agent = (EIF_OBJECT) eif_adopt (agent);
#endif
	closure = g_closure_new_simple (sizeof(GClosure), adopted_agent);
	printf("[closure] %p\n", closure);
	g_closure_add_invalidate_notifier(closure, (gpointer) adopted_agent, (GClosureNotify)gclosure_notify_eif_wean);
#ifdef EIF_IL_DLL
	/* pass the address of the new delegate*/

	// TODO double check how to release the object
	eif_wean(ev_gtk_free);

#endif

	g_closure_set_marshal (closure, c_ev_gtk_callback_marshal);
	printf("g_closure_set_marshal closure, c_ev_gtk_callback_marshal] %p ,  %p\n ", closure, c_ev_gtk_callback_marshal);

	connection_id = g_signal_connect_closure (c_object, signal, closure, invoke_after_handler);
	return connection_id;
}

guint c_ev_gtk_callback_marshal_timeout_connect (
    gint delay,
#ifdef EIF_IL_DLL
    EIF_POINTER
#else
    EIF_OBJECT
#endif
    agent
)
        // Call an `agent' every `delay' milliseconds.
{
	#ifdef EIF_IL_DLL
		EIF_POINTER adopted_agent;
		adopted_agent = agent;
	#else
		EIF_OBJECT adopted_agent;
		adopted_agent = eif_adopt (agent);
	#endif
	guint connection_id;

	connection_id = g_timeout_add_full (
				G_PRIORITY_DEFAULT,
				delay,
				(GSourceFunc) c_ev_gtk_callback_marshal_true_callback,
				adopted_agent,          // User data for function.
				(GDestroyNotify) gdestroy_notify_eif_wean // To call on hook disconnect.
			);
	return (connection_id);
}


#ifdef EIF_IL_DLL
void gtk_set_dispatcher_object(EIF_OBJECT _addr_)
{
    ev_gtk_dispatcher = (EIF_OBJECT) eif_adopt (_addr_);
}

void gtk_release_dispatcher_object()
{
    eif_wean (ev_gtk_dispatcher);
}
#endif

