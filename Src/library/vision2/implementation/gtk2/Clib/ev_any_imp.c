//------------------------------------------------------------------------------
// ev_any_imp.c
//------------------------------------------------------------------------------
// description: "C features of EV_ANY_IMP, see ev_any_imp.e for important notes"
// status: "See notice at end of file"
// date: "$Date$"
// revision: "$Revision$"
//------------------------------------------------------------------------------

#include <eif_eiffel.h>
#include <eif_object_id.h>
#include <gtk/gtk.h>
#include "ev_any_imp.h"

//#define DEBUG

void (*ev_any_imp_c_object_dispose) (EIF_REFERENCE);

rt_private void c_eif_wean (gpointer data);

EIF_REFERENCE c_ev_any_imp_get_eif_reference_from_object_id (GtkWidget* c_object)
        // Retrieve EIF_REFERENCE from object_id in `c_object'.
        // Returns NULL if Eiffel object has been reaped by the GC.
{
            int eif_oid;
            EIF_REFERENCE eif_reference = NULL;
            if ((eif_oid = (int) g_object_get_data (
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


gboolean c_ev_any_imp_c_object_references_eif_object (GtkWidget* c_object)
        // Does `c_object' reference Eiffel object?
{
            return ((gboolean) g_object_get_data (
                G_OBJECT (c_object),
                "eif_object"
            ));
}


gboolean c_ev_any_imp_eif_object_references_c_object (GtkWidget* c_object)
        // Does Eiffel object reference `c_object'?
{
            return ((gboolean) g_object_get_data (
                G_OBJECT (c_object),
                "ref_from_eif"
            ));
}


void c_ev_any_imp_set_gtk_controls_object_life (GtkWidget* c_object)
        // Pass control of the widget's life to the GTK reference counter.
        // Store an Eiffel reference in `c_object'.
        // Remove GTK reference from `c_object'.
{
            EIF_REFERENCE eif_reference;
            EIF_OBJECT eif_object;
            eif_reference =
                c_ev_any_imp_get_eif_reference_from_object_id (c_object);
            //eif_object = eif_protect (eif_reference);
		eif_object = c_ev_any_imp_get_eif_reference_from_object_id (c_object);
            g_object_set_data_full (
                G_OBJECT (c_object),
                "eif_object",
                eif_object,
                (GtkDestroyNotify) c_eif_wean
            );
    
            if (c_ev_any_imp_eif_object_references_c_object (c_object)) {
//                g_object_unref (G_OBJECT (c_object));
                g_object_remove_data (
                    G_OBJECT (c_object),
                    "ref_from_eif"
                );
            }
}


void c_ev_any_imp_set_eiffel_controls_object_life (GtkWidget* c_object)
        // Pass control of the widget's life to the Eiffel GC.
        // Remove Eiffel reference from `c_object'.
        // Add GTK reference to `c_object'.
{
            g_object_remove_data (G_OBJECT (c_object), "eif_object");
 //           g_object_ref (G_OBJECT (c_object));
            g_object_set_data (
                G_OBJECT (c_object),
                "ref_from_eif",
                (gpointer*) TRUE
            );
}


void c_ev_any_imp_on_c_object_parent_set (
    GtkWidget* c_object,
    GtkWidget* old_parent,
    gpointer* user_data
)
        // Handler for "parent_set" signal.
        // When a widget is unparented hand memory management control to Eiffel.
        // When a widget is parented hand it to GTK.
{
            if (c_object->parent) {
                if ( ! c_ev_any_imp_c_object_references_eif_object (c_object)) {
                    c_ev_any_imp_set_gtk_controls_object_life (c_object);
                }
            } else {
                c_ev_any_imp_set_eiffel_controls_object_life (c_object);
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
            ev_any_imp_c_object_dispose = c_object_dispose;
            g_object_set_data (
                G_OBJECT (c_object),
                "eif_oid",
                (gpointer*) eif_oid
            );
            gtk_signal_connect (
                G_OBJECT (c_object),
                "destroy",
                c_ev_any_imp_c_object_dispose,
                (gpointer*) eif_oid
            );
            if (GTK_IS_WINDOW (c_object)) {
				g_object_ref (G_OBJECT (c_object));
				g_object_set_data (
					G_OBJECT (c_object),
					"ref_from_eif",
					(gpointer*) TRUE
				);
            } else {
//g_object_ref (G_OBJECT (c_object));
                gtk_signal_connect (
                    G_OBJECT (c_object),
                    "parent-set",
                    c_ev_any_imp_on_c_object_parent_set,
                    NULL
                );
            }
}

gboolean c_ev_any_imp_invariant (GtkWidget* c_object)
	// Called by Eiffel invariant
{
    return (
        ! (
            c_ev_any_imp_c_object_references_eif_object (c_object)
            &&
            c_ev_any_imp_eif_object_references_c_object (c_object)
        )
	&&
	ev_any_imp_c_object_dispose != NULL
    );
}

rt_private void c_eif_wean (gpointer data)
	/* Call `eif_wean' on Eiffel object represented by `data'. */
{
//	(void) eif_wean ((EIF_OBJECT) data);
}
