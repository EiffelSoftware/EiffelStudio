/*
indexing
	description: "Functions used by the class ER_COMMAND_HANDLER."
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

#include "eiffel_ribbon.h"
	
EIF_OBJECT eiffel_command_handler_object = NULL;
	/* Address of Eiffel object ER_COMMAND_HANDLER */
	
EIF_RIBBON_EXECUTE_PROC eiffel_execute_function = NULL;
	/* Address of Eiffel ER_COMMAND_HANDLER.execute */

EIF_RIBBON_UPDATE_PROPERTY_PROC eiffel_update_property_function = NULL;
	/* Address of Eiffel ER_COMMAND_HANDLER.update_property */
	
/* Set Eiffel ER_COMMAND_HANDLER object address */
void c_set_object(EIF_REFERENCE a_address)
{
	if (a_address) {
		eiffel_command_handler_object = eif_protect (a_address);
	} else {
		eiffel_command_handler_object = NULL;
	}
}

/* Release Eiffel ER_COMMAND_HANDLER object address */
void c_release_object()
{
	eif_wean (eiffel_command_handler_object);
}

/* Set ER_COMMAND_HANDLER.execute address */
void c_set_execute_address (EIF_POINTER a_address)
{
	eiffel_execute_function = (EIF_RIBBON_EXECUTE_PROC) a_address;
}

/* Set ER_COMMAND_HANDLER.update_property address */
void c_set_update_property_address(EIF_POINTER a_address)
{
	eiffel_update_property_function = (EIF_RIBBON_UPDATE_PROPERTY_PROC) a_address;
}


