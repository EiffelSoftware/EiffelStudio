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

void (*ev_any_imp_c_object_dispose) (EIF_REFERENCE);

EIF_REFERENCE c_ev_any_imp_get_eif_reference_from_object_id (GtkWidget* c_object)
        // Retrieve EIF_REFERENCE from object_id in `c_object'.
        // Returns NULL if Eiffel object has been reaped by the GC.
{
            int eif_oid;
            EIF_REFERENCE eif_reference = NULL;
            
	    if ((eif_oid = (int) gtk_object_get_data (
                GTK_OBJECT (c_object),
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
        // Store Eiffel object_id in `gtk_object'.
        // Set up signal handlers.
{
	    	// Our function pointer is reset every time,
		// This could be done with just one setting function.
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
            /*if (GTK_IS_WINDOW (c_object)) {
			// As Windows are toplevel widgets they need to stay alive unless explicitly destroyed.
		gtk_object_ref (GTK_OBJECT (c_object));
            }*/
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
// Revision 1.1  2005/07/07 17:02:11  king
// Initial revision
//
// Revision 1.16  2004/03/19 23:08:58  king
// Now no longer add reffing windows
//
// Revision 1.15  2003/11/12 17:48:34  manus
// Fixed bug in which when a vision2 application using capture was launched
// outside the EiffelStudio debugger as soon as you had something that would
// normally trigger a communication with EiffelStudio while debugging it would
// fail with the following message:
// Cannot serialize request, 5
// Because there were no EiffelStudio debugger. Now we make sure that `debug_mode'
// is properly restored.
//
// Revision 1.14  2003/10/22 01:14:06  king
// Added set_debug_mode that was previous inline Eiffel code
// Placed here because it doesn't compile with older C compilers (gcc 2.95)
//
// Revision 1.13  2003/08/13 20:16:23  king
// Zapped more useless code
//
// Revision 1.12  2003/08/13 19:37:38  king
// Removed C compilation error
// Zapped a lot of useless code in the process
//
// Revision 1.11  2002/11/26 21:21:19  king
// Merged with changes from 52 branch
//
// Revision 1.10.6.1  2002/10/21 18:36:19  king
// Commented out g_asserts
// Should be excluded with an #ifdef DEBUG
//
// Revision 1.10  2001/09/17 00:26:04  king
// All mem man is now done via Eiffel GC
//
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
