/*
indexing
	description: "C features of EV_ANY_IMP, see ev_any_imp.e for important notes."
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

#ifndef _EV_ANY_IMP_H_INCLUDED_
#define _EV_ANY_IMP_H_INCLUDED_

#include <ev_gtk.h>

#define set_eif_oid_in_c_object(cobj,eifoid,cobjdisp) c_ev_any_imp_set_eif_oid_in_c_object ((GtkWidget*)cobj,(int)eifoid, (void (*) (EIF_REFERENCE))cobjdisp)

extern void c_ev_any_imp_set_eif_oid_in_c_object
	(GtkWidget*, int, void (*) (EIF_REFERENCE));

extern EIF_REFERENCE c_ev_any_imp_get_eif_reference_from_object_id
	(GtkWidget* c_object);

#endif
