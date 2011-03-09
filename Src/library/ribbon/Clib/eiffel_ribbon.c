/*
indexing
	description: "Functions used by the class EV_COMMAND_HANDLER and EV_RIBBON."
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
#include "ribbon.h"
#include "command.c"
#include "ribbon.c"
#include "simple_property_set.c"

EIF_OBJECT eiffel_command_handler_object = NULL;
	/* Address of Eiffel object EV_COMMAND_HANDLER */

EIF_OBJECT eiffel_ribbon_object = NULL;
	/* Address of Eiffel object EV_RIBBON */
	
EIF_RIBBON_EXECUTE_PROC eiffel_execute_function = NULL;
	/* Address of Eiffel EV_COMMAND_HANDLER.execute */

EIF_RIBBON_UPDATE_PROPERTY_PROC eiffel_update_property_function = NULL;
	/* Address of Eiffel EV_COMMAND_HANDLER.update_property */

EIF_RIBBON_ON_CREATE_UI_COMMAND_PROC eiffel_on_create_ui_command_function =  NULL;
	/* Address of Eiffel EV_RIBBON.on_create_ui_command */

/* Set Eiffel EV_COMMAND_HANDLER object address */
void c_set_command_handler_object(EIF_REFERENCE a_address)
{
	if (a_address) {
		eiffel_command_handler_object = eif_protect (a_address);
	} else {
		eiffel_command_handler_object = NULL;
	}
}

/* Release Eiffel EV_COMMAND_HANDLER object address */
void c_release_command_handler_object()
{
	eif_wean (eiffel_command_handler_object);
}

/* Set EV_COMMAND_HANDLER.execute address */
void c_set_execute_address (EIF_RIBBON_EXECUTE_PROC a_address)
{
	eiffel_execute_function = a_address;
}

/* Set EV_COMMAND_HANDLER.update_property address */
void c_set_update_property_address(EIF_RIBBON_UPDATE_PROPERTY_PROC a_address)
{
	eiffel_update_property_function = a_address;
}

/* Set Eiffel EV_RIBBON object address */
void c_set_ribbon_object(EIF_REFERENCE a_address)
{
	if (a_address) {
		eiffel_ribbon_object = eif_protect (a_address);
	} else {
		eiffel_ribbon_object = NULL;
	}
}

/* Release Eiffel EV_RIBBON object address */
void c_release_ribbon_object()
{
	eif_wean (eiffel_ribbon_object);
}

/* Set EV_RIBBON.on_create_ui_command address */
void c_set_on_create_ui_command_address(EIF_POINTER a_address)
{
	eiffel_on_create_ui_command_function = (EIF_RIBBON_ON_CREATE_UI_COMMAND_PROC) a_address;
}