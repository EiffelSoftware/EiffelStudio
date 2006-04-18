/*
indexing
	description: "C features of EV_ANY_IMP, see ev_any_imp.e for important notes."
	date: "$Date: $"
	revision: "$Revision: $"
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
#include <eif_object_id.h>
#include <gtk/gtk.h>
#include "ev_any_imp.h"

void (*ev_any_imp_c_object_dispose) (EIF_REFERENCE);

EIF_REFERENCE c_ev_any_imp_get_eif_reference_from_object_id (GtkWidget* c_object)
        // Retrieve EIF_REFERENCE from object_id in `c_object'.
        // Returns NULL if Eiffel object has been reaped by the GC.
{
            int eif_oid;
            EIF_REFERENCE eif_reference = NULL;
            
	    if ((eif_oid = (int) (rt_int_ptr) g_object_get_data (
                G_OBJECT (c_object),
                "eif_oid"
            ))) {
	        eif_reference = eif_id_object (eif_oid);
            }
            return (eif_reference);
}

void c_ev_any_imp_c_object_dispose (GtkWidget* c_object, int eif_oid)
        // "destroy" signal handler.
        // Pass call to Eiffel feature if Eiffel object exists.
{
            EIF_REFERENCE eif_reference;
            
	    eif_reference = eif_id_object (eif_oid);
	    if (eif_reference) {
                ev_any_imp_c_object_dispose (eif_reference);
            }
}

void c_ev_any_imp_set_eif_oid_in_c_object (
    GtkWidget* c_object,
    int eif_oid,
    void (*c_object_dispose) (EIF_REFERENCE)
)
        // Store Eiffel object_id in `g_object'.
        // Set up signal handlers.
{
	    	// Our function pointer is reset every time,
		// This could be done with just one setting function.
            ev_any_imp_c_object_dispose = c_object_dispose;
            g_object_set_data (
                G_OBJECT (c_object),
                "eif_oid",
                (gpointer) (rt_int_ptr) eif_oid
            );
            g_signal_connect (
                G_OBJECT (c_object),
                "destroy",
                (GCallback) c_ev_any_imp_c_object_dispose,
                (gpointer) (rt_int_ptr) eif_oid
            );
}

/* To store previous value of `debug_mode' */
static int saved_debug_mode = 0;

void set_debug_mode (int a_debug_mode)
{
	if (a_debug_mode == 0) {
			/* We are disabling debugger here, therefore we need to save
			 * previous state of debugger so that we can correctly restore
			 * it later when we want to enable it again. */
		saved_debug_mode = debug_mode;
		debug_mode = a_debug_mode;
	} else {
			/* Restore previous state of debugger. */
		debug_mode = saved_debug_mode;
	}
}
