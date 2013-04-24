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
#include "common.h"
#include "iui_command_handler.c"
#include "iui_application.c"
#include "simple_property_set.c"

EIF_OBJECT eiffel_dispatcher = NULL;
	/* Address of Eiffel object EV_RIBBON_DISPATCHER */
	
EIF_RIBBON_EXECUTE_PROC eiffel_execute_function = NULL;
	/* Address of Eiffel EV_RIBBON_DISPATCHER.execute */

EIF_RIBBON_UPDATE_PROPERTY_PROC eiffel_update_property_function = NULL;
	/* Address of Eiffel EV_RIBBON_DISPATCHER.update_property */

EIF_RIBBON_ON_CREATE_UI_COMMAND_PROC eiffel_on_create_ui_command_function =  NULL;
	/* Address of Eiffel EV_RIBBON_DISPATCHER.on_create_ui_command */

EIF_RIBBON_ON_VIEW_CHANGED_PROC eiffel_on_view_changed_function =  NULL;
	/* Address of Eiffel EV_RIBBON_DISPATCHER.on_view_changed */

/* Set Eiffel EV_RIBBON_DISPATCHER object address */
void c_set_eiffel_dispatcher (EIF_REFERENCE a_address)
{
	if (a_address) {
		eiffel_dispatcher = eif_protect (a_address);
	} else {
		eiffel_dispatcher = NULL;
	}
}

/* Release Eiffel EV_RIBBON_DISPATCHER object address */
void c_release_eiffel_dispatcher()
{
	eif_wean (eiffel_dispatcher);
}

/* Set EV_RIBBON_DISPATCHER.execute address */
void c_set_execute_address (EIF_RIBBON_EXECUTE_PROC a_address)
{
	eiffel_execute_function = a_address;
}

/* Set EV_RIBBON_DISPATCHER.update_property address */
void c_set_update_property_address(EIF_RIBBON_UPDATE_PROPERTY_PROC a_address)
{
	eiffel_update_property_function = a_address;
}

/* Set EV_RIBBON_DISPATCHER.on_create_ui_command address */
void c_set_on_create_ui_command_address(EIF_POINTER a_address)
{
	eiffel_on_create_ui_command_function = (EIF_RIBBON_ON_CREATE_UI_COMMAND_PROC) a_address;
}

/* Set EV_RIBBON_DISPATCHER.on_view_changed address */
void c_set_on_view_changed_address (EIF_POINTER a_address)
{
	eiffel_on_view_changed_function = (EIF_RIBBON_ON_VIEW_CHANGED_PROC) a_address;
}
