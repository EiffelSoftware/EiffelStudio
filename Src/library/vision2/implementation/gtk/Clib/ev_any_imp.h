//------------------------------------------------------------------------------
// ev_any_imp.h
//------------------------------------------------------------------------------
// description: "C features of EV_ANY_IMP, see ev_any_imp.c and ev_any_imp.e" 
// status: "See notice at end of file"
// date: "$Date$"
// revision: "$Revision$"
//------------------------------------------------------------------------------

#ifndef _EV_ANY_IMP_H_INCLUDED_
#define _EV_ANY_IMP_H_INCLUDED_

#include <eif_eiffel.h>
#include <gtk/gtk.h>

void c_ev_any_imp_set_eif_oid_in_c_object
	(GtkWidget*, int, void (*) (EIF_REFERENCE));

EIF_REFERENCE c_ev_any_imp_get_eif_reference_from_object_id
	(GtkWidget* c_object);

gboolean c_ev_any_imp_invariant (GtkWidget* c_object);

#endif

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
// Revision 1.3  2001/06/07 23:07:59  rogers
// Merged DEVEL branch into Main trunc.
//
// Revision 1.2.6.1  2000/05/03 19:08:33  oconnor
// mergred from HEAD
//
// Revision 1.2  2000/02/14 12:05:08  oconnor
// added from prerelease_20000214
//
// Revision 1.1.4.3  1999/12/01 02:14:29  oconnor
// implement part of invariant in C
//
// Revision 1.1.4.2  1999/12/01 01:56:06  oconnor
// added copyright notice
//
// Revision 1.1.4.1  1999/11/23 23:43:14  oconnor
// rearranged C externals
//
// Revision 1.1.2.2  1999/11/18 03:37:16  oconnor
// improved indexing cluase
//
// Revision 1.1.2.1  1999/11/12 07:56:27  oconnor
// initial
//
//
//------------------------------------------------------------------------------
// End of CVS log
//------------------------------------------------------------------------------
