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
    // local
            int eif_oid;
            EIF_REFERENCE eif_reference = NULL;
#ifdef DEBUG
        g_log (G_LOG_DOMAIN, G_LOG_LEVEL_DEBUG,
            "c_ev_any_imp_get_eif_reference_from_object_id (%X (%s)) = %X",
            (int) c_object,
            gtk_type_name (GTK_OBJECT_TYPE (c_object)),
            (int) eif_id_object (
                (int) gtk_object_get_data (GTK_OBJECT (c_object), "eif_oid")
            )
        );
#endif /* DEBUG */
    // require
            g_assert (c_object != NULL);
            g_assert (GTK_IS_WIDGET (c_object));
    // do
            if ((eif_oid = (int) gtk_object_get_data (
                GTK_OBJECT (c_object),
                "eif_oid"
            ))) {
	        eif_reference = eif_id_object (eif_oid);
            }
            return (eif_reference);
    // end
}


void c_ev_any_imp_c_object_dispose (GtkWidget* c_object, int eif_oid)
        // "destroy" signal handler.
        // Pass call to Eiffel feature if Eiffel object exists.
{
    // local
            EIF_REFERENCE eif_reference;
#ifdef DEBUG
        g_log (G_LOG_DOMAIN, G_LOG_LEVEL_DEBUG,
            "c_ev_any_imp_c_object_dispose (%X (%s), %d (%X))",
            (int) c_object,
            gtk_type_name (GTK_OBJECT_TYPE (c_object)),
            eif_oid,
            (int) eif_id_object (eif_oid)
        );
#endif /* DEBUG */
    // require
            g_assert (c_object != NULL);
            g_assert (GTK_IS_WIDGET (c_object));
            g_assert (eif_oid != 0);
    // do
            eif_reference = eif_id_object (eif_oid);
            if (eif_reference) {
                ev_any_imp_c_object_dispose (eif_reference);
            }
    // end
}


gboolean c_ev_any_imp_c_object_references_eif_object (GtkWidget* c_object)
        // Does `c_object' reference Eiffel object?
{
#ifdef DEBUG
        g_log (G_LOG_DOMAIN, G_LOG_LEVEL_DEBUG,
            "c_ev_any_imp_c_object_references_eif_object (%X (%s)) = %d",
            (int) c_object,
            gtk_type_name (GTK_OBJECT_TYPE (c_object)),
            gtk_object_get_data (GTK_OBJECT (c_object), "eif_object") ? 1 : 0
        );
#endif /* DEBUG */
    // require
            g_assert (c_object != NULL);
            g_assert (GTK_IS_WIDGET (c_object));
    // do
            return ((gboolean) gtk_object_get_data (
                GTK_OBJECT (c_object),
                "eif_object"
            ));
    // end
}


gboolean c_ev_any_imp_eif_object_references_c_object (GtkWidget* c_object)
        // Does Eiffel object reference `c_object'?
{
#ifdef DEBUG
        g_log (G_LOG_DOMAIN, G_LOG_LEVEL_DEBUG,
            "c_ev_any_imp_eif_object_references_c_object (%X (%s)) = %d",
            (int) c_object,
            gtk_type_name (GTK_OBJECT_TYPE (c_object)),
            gtk_object_get_data (GTK_OBJECT (c_object), "ref_from_eif") ? 1 : 0
        );
#endif /* DEBUG */
    // require
            g_assert (c_object != NULL);
            g_assert (GTK_IS_WIDGET (c_object));
    // do
            return ((gboolean) gtk_object_get_data (
                GTK_OBJECT (c_object),
                "ref_from_eif"
            ));
    // end
}


void c_ev_any_imp_set_gtk_controls_object_life (GtkWidget* c_object)
        // Pass control of the widget's life to the GTK reference counter.
        // Store an Eiffel reference in `c_object'.
        // Remove GTK reference from `c_object'.
{
    // local
            EIF_REFERENCE eif_reference;
            EIF_OBJECT eif_object;
#ifdef DEBUG
        g_log (G_LOG_DOMAIN, G_LOG_LEVEL_DEBUG,
            "c_ev_any_imp_set_gtk_controls_object_life (%X (%s))",
            (int) c_object,
            gtk_type_name (GTK_OBJECT_TYPE (c_object))
        );
#endif /* DEBUG */
    // require
            g_assert (c_object != NULL);
            g_assert (GTK_IS_WIDGET (c_object));
            g_assert (! c_ev_any_imp_c_object_references_eif_object (c_object));
    // do
            eif_reference =
                c_ev_any_imp_get_eif_reference_from_object_id (c_object);
            g_assert (eif_reference != NULL);
            eif_object = eif_protect (eif_reference);
            gtk_object_set_data_full (
                GTK_OBJECT (c_object),
                "eif_object",
                eif_object,
                (GtkDestroyNotify) c_eif_wean
            );
    
            if (c_ev_any_imp_eif_object_references_c_object (c_object)) {
                gtk_object_unref (GTK_OBJECT (c_object));
                gtk_object_remove_data (
                    GTK_OBJECT (c_object),
                    "ref_from_eif"
                );
            }
    // ensure
            g_assert (c_ev_any_imp_c_object_references_eif_object (c_object));
            g_assert (! c_ev_any_imp_eif_object_references_c_object (c_object));
    // end
}


void c_ev_any_imp_set_eiffel_controls_object_life (GtkWidget* c_object)
        // Pass control of the widget's life to the Eiffel GC.
        // Remove Eiffel reference from `c_object'.
        // Add GTK reference to `c_object'.
{
#ifdef DEBUG
        g_log (G_LOG_DOMAIN, G_LOG_LEVEL_DEBUG,
            "c_ev_any_imp_set_eiffel_controls_object_life (%X (%s))",
            (int) c_object,
            gtk_type_name (GTK_OBJECT_TYPE (c_object))
        );
#endif /* DEBUG */
    // require
            g_assert (c_object != NULL);
            g_assert (GTK_IS_WIDGET (c_object));
            g_assert (c_object->parent == NULL);
            g_assert (c_ev_any_imp_c_object_references_eif_object (c_object));
            g_assert (! c_ev_any_imp_eif_object_references_c_object (c_object));
    // do
            gtk_object_remove_data (GTK_OBJECT (c_object), "eif_object");
            gtk_object_ref (GTK_OBJECT (c_object));
            gtk_object_set_data (
                GTK_OBJECT (c_object),
                "ref_from_eif",
                (gpointer*) TRUE
            );
    // ensure
            g_assert (! c_ev_any_imp_c_object_references_eif_object (c_object));
            g_assert (c_ev_any_imp_eif_object_references_c_object (c_object));
    // end
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
#ifdef DEBUG
        g_log (G_LOG_DOMAIN, G_LOG_LEVEL_DEBUG,
            "c_ev_any_imp_on_c_object_parent_set (%X (%s), old: %X (%s), %X) new: %X (%s)",
            (int) c_object,
            gtk_type_name (GTK_OBJECT_TYPE (c_object)),
            (int) old_parent,
            old_parent ?
            gtk_type_name (GTK_OBJECT_TYPE (old_parent)) : "unparented",
            (int) user_data,
            (int) GTK_WIDGET (c_object)->parent,
            GTK_WIDGET (c_object)->parent ?
            gtk_type_name (GTK_OBJECT_TYPE (GTK_WIDGET (c_object)->parent)) : "unparented"
        );
#endif /* DEBUG */
    // do
            if (c_object->parent) {
                if ( ! c_ev_any_imp_c_object_references_eif_object (c_object)) {
                    c_ev_any_imp_set_gtk_controls_object_life (c_object);
                }
            } else {
                c_ev_any_imp_set_eiffel_controls_object_life (c_object);
            }
    // end
}


void c_ev_any_imp_set_eif_oid_in_c_object (
    GtkWidget* c_object,
    int eif_oid,
    void (*c_object_dispose) (EIF_REFERENCE)
)
        // Store Eiffel object_id in `gtk_object'.
        // Set up signal handlers.
{
#ifdef DEBUG
        g_log (G_LOG_DOMAIN, G_LOG_LEVEL_DEBUG,
            "c_ev_any_imp_set_eif_oid_in_c_object (%X (%s), %d (%X), %X)",
            (int) c_object,
            gtk_type_name (GTK_OBJECT_TYPE (c_object)),
            eif_oid,
            (int) eif_id_object (eif_oid),
            (int) c_object_dispose
        );
#endif /* DEBUG */
    // require
            g_assert (c_object != NULL);
            g_assert (GTK_IS_WIDGET (c_object));
            g_assert (eif_oid != 0);
            g_assert (c_object_dispose != NULL);
            g_assert (GTK_OBJECT (c_object)->ref_count == 1);
            g_assert (GTK_OBJECT_FLOATING(c_object) || GTK_IS_WINDOW(c_object));
    // do
            ev_any_imp_c_object_dispose = c_object_dispose;
            gtk_object_set_data (
                GTK_OBJECT (c_object),
                "eif_oid",
                (gpointer*) eif_oid
            );
            gtk_signal_connect (
                GTK_OBJECT (c_object),
                "destroy",
                c_ev_any_imp_c_object_dispose,
                (gpointer*) eif_oid
            );
            if (GTK_IS_WINDOW (c_object)) {
				gtk_object_ref (GTK_OBJECT (c_object));
				gtk_object_set_data (
					GTK_OBJECT (c_object),
					"ref_from_eif",
					(gpointer*) TRUE
				);
				g_assert (GTK_OBJECT (c_object)->ref_count == 2);
            } else {
                gtk_signal_connect (
                    GTK_OBJECT (c_object),
                    "parent-set",
                    c_ev_any_imp_on_c_object_parent_set,
                    NULL
                );
				g_assert (GTK_OBJECT (c_object)->ref_count == 1);
            }
    // ensure
            g_assert (eif_oid ==
                (int) gtk_object_get_data (GTK_OBJECT (c_object), "eif_oid"));
            g_assert (ev_any_imp_c_object_dispose == c_object_dispose);
    // end
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
	(void) eif_wean ((EIF_OBJECT) data);
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
// Revision 1.9  2001/08/08 16:51:35  manus
// Avoid a useless local variable declaration.
//
// Revision 1.8  2001/06/26 19:01:15  manus
// Added `c_eif_wean' which is an encapsulation of `eif_wean' that has the correct
// signature for `GtkDestroyNotify'.
//
// Revision 1.7  2001/06/07 23:07:59  rogers
// Merged DEVEL branch into Main trunc.
//
// Revision 1.6.2.2  2000/06/20 21:43:00  oconnor
// Reference windows apon creation. See ev_any_imp.e and ev_any_imp.fig
//
// Revision 1.6.2.1  2000/05/03 19:08:33  oconnor
// mergred from HEAD
//
// Revision 1.6  2000/04/11 23:16:02  king
// Commented out debug pp definition
//
// Revision 1.5  2000/04/11 16:23:28  oconnor
// use #define DEBUG for logging
//
// Revision 1.4  2000/03/01 03:15:29  oconnor
// reverted last commit which was in error
//
// Revision 1.2  2000/02/14 12:05:07  oconnor
// added from prerelease_20000214
//
// Revision 1.1.4.8  2000/01/19 08:07:22  oconnor
// commented out debugging info
//
// Revision 1.1.4.7  1999/12/09 18:15:13  oconnor
// layout tweak
//
// Revision 1.1.4.6  1999/12/07 22:06:04  oconnor
// added an assertion
//
// Revision 1.1.4.5  1999/12/02 00:45:03  oconnor
// not in C is !
//
// Revision 1.1.4.4  1999/12/01 02:14:29  oconnor
// implement part of invariant in C
//
// Revision 1.1.4.3  1999/12/01 01:55:53  oconnor
// spell
//
// Revision 1.1.4.2  1999/11/30 22:52:08  oconnor
// Return Void if GTK object has no Eiffel object
//
// Revision 1.1.4.1  1999/11/23 23:43:13  oconnor
// rearranged C externals
//
// Revision 1.1.2.4  1999/11/23 22:57:08  oconnor
// removed logging stuff
//
// Revision 1.1.2.3  1999/11/18 03:36:56  oconnor
// added casts to keep gcc happier
//
// Revision 1.1.2.2  1999/11/17 22:04:32  oconnor
// log messages now display addresses in hex
//
// Revision 1.1.2.1  1999/11/12 07:56:26  oconnor
// initial
//
//------------------------------------------------------------------------------
// End of CVS log
//------------------------------------------------------------------------------
