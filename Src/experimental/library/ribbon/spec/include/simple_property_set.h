/*
indexing
	description: "Functions used by the class EV_SIMPLE_PROPERTY_SET."
	copyright:	"Copyright (c) 1984-2010, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
				Eiffel Software
				5949 Hollister Ave., Goleta, CA 93117 USA
				Telephone 805-685-1006, Fax 805-685-6869
				Website http://www.eiffel.com
				Customer support http://support.eiffel.com
		]"
*/

#ifndef _simple_property_set_h_
#define _simple_property_set_h_

#include "eif_eiffel.h"
#include "common.h"

/* unix-specific */
#ifndef EIF_WINDOWS 
#include <sys/time.h>
#include <unistd.h> 
#endif
	
#ifdef __cplusplus
extern "C" {
#endif

typedef EIF_NATURAL_32 (* EIF_RIBBON_SIMPLE_PROPERTY_SET_GET_VALUE_PROC) (
#ifndef EIF_IL_DLL
	EIF_REFERENCE,  /* EIFFEL_RIBBON Eiffel object */
#endif
	EIF_POINTER, /* IUISimplePropertySet */
	EIF_POINTER, /* REFPROPERTYKEY key */
	EIF_POINTER /* PROPVARIANT *ppropvarNewValue */
	);
	
IUISimplePropertySet * CreateInstanceSimplePropertySet ();

extern void c_set_simple_property_set_object(EIF_REFERENCE a_address);
extern void c_release_simple_property_set_object (void);
extern void c_set_get_value_address (EIF_POINTER a_address);

extern EIF_OBJECT eiffel_simple_property_set_object;
	/* Address of Eiffel object EV_SIMPLE_PROPERTY_SET */
extern EIF_RIBBON_SIMPLE_PROPERTY_SET_GET_VALUE_PROC eiffel_get_value_function;
	/* Address of Eiffel ER_COMMAND_HANDLER.get_value */
	
#ifdef __cplusplus
}
#endif
	
	
#endif	
