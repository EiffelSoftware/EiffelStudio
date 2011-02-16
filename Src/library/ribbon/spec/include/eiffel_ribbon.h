/*
indexing
	description: "Functions used by the class EV_COMMAND_HANDLER."
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

#ifndef _eiffel_ribbon_h_
#define _eiffel_ribbon_h_

#include "eif_eiffel.h"

/* unix-specific */
#ifndef EIF_WINDOWS 
#include <sys/time.h>
#include <unistd.h> 
#endif

typedef EIF_NATURAL_32 (* EIF_RIBBON_UPDATE_PROPERTY_PROC) (
#ifndef EIF_IL_DLL
	EIF_REFERENCE,  /* EIFFEL_RIBBON Eiffel object */
#endif
	EIF_NATURAL_32, /* UINT nCmdID */
	EIF_POINTER, /* REFPROPERTYKEY key */
	EIF_POINTER, /* PROPVARIANT *ppropvarCurrentValue*/
	EIF_POINTER /* PROPVARIANT *ppropvarNewValue */
	);
	
typedef EIF_INTEGER (* EIF_RIBBON_EXECUTE_PROC) (
#ifndef EIF_IL_DLL
	EIF_REFERENCE,  /* EIFFEL_RIBBON Eiffel object */
#endif
	EIF_POINTER,
	EIF_NATURAL_32, /* UINT nCmdID */
	EIF_INTEGER, /* UI_EXECUTIONVERB verb */
	EIF_POINTER, /* PROPERTYKEY* key */
	EIF_POINTER, /* PROPVARIANT* ppropvarValue */
	EIF_POINTER  /* IUISimplePropertySet* pCommandExecutionProperties */
	);

#ifdef __cplusplus
extern "C" {
#endif

extern void c_set_object(EIF_REFERENCE a_address);
extern void c_release_object(void);
extern void c_set_execute_address(EIF_POINTER a_address);
extern void c_set_update_property_address( EIF_POINTER a_address);

extern EIF_OBJECT eiffel_command_handler_object;
	/* Address of Eiffel object ER_COMMAND_HANDLER */
extern EIF_RIBBON_EXECUTE_PROC eiffel_execute_function;
	/* Address of Eiffel ER_COMMAND_HANDLER.execute */
extern EIF_RIBBON_UPDATE_PROPERTY_PROC eiffel_update_property_function;
	/* Address of Eiffel ER_COMMAND_HANDLER.update_property */ 
	
#ifdef __cplusplus
}
#endif
	
#endif	
