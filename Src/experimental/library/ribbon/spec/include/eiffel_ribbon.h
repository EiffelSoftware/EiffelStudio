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

#ifdef __cplusplus
extern "C" {
#endif

typedef EIF_NATURAL_32 (* EIF_RIBBON_UPDATE_PROPERTY_PROC) (
#ifndef EIF_IL_DLL
	EIF_REFERENCE,  /* EV_RIBBON_DISPATCHER Eiffel object */
#endif
	EIF_POINTER,
	EIF_NATURAL_32, /* UINT nCmdID */
	EIF_POINTER, /* REFPROPERTYKEY key */
	EIF_POINTER, /* PROPVARIANT *ppropvarCurrentValue*/
	EIF_POINTER /* PROPVARIANT *ppropvarNewValue */
	);
	
typedef EIF_INTEGER (* EIF_RIBBON_EXECUTE_PROC) (
#ifndef EIF_IL_DLL
	EIF_REFERENCE,  /* EV_RIBBON_DISPATCHER Eiffel object */
#endif
	EIF_POINTER,
	EIF_NATURAL_32, /* UINT nCmdID */
	EIF_INTEGER, /* UI_EXECUTIONVERB verb */
	EIF_POINTER, /* PROPERTYKEY* key */
	EIF_POINTER, /* PROPVARIANT* ppropvarValue */
	EIF_POINTER  /* IUISimplePropertySet* pCommandExecutionProperties */
	);

typedef EIF_NATURAL_32 (* EIF_RIBBON_ON_CREATE_UI_COMMAND_PROC) (
#ifndef EIF_IL_DLL
	EIF_REFERENCE,  /* EV_RIBBON_DISPATCHER Eiffel object */
#endif
	EIF_POINTER, 	/* IUIApplication*	*/
	EIF_NATURAL_32, /* UINT nCmdID	*/
	EIF_INTEGER, 	/* UI_COMMANDTYPE  */
	EIF_POINTER	/* IUICommandHandler ** */
	);

typedef EIF_NATURAL_32 (* EIF_RIBBON_ON_VIEW_CHANGED_PROC) (
#ifndef EIF_IL_DLL
	EIF_REFERENCE,  /* EV_RIBBON_DISPATCHER Eiffel object */
#endif
	EIF_POINTER, 	/* IUIApplication*	*/
	EIF_NATURAL_32, /* UINT viewId	*/
	EIF_INTEGER, 	/* UI_VIEWTYPE  */
	EIF_POINTER,	/* IUnknown *view */
	EIF_INTEGER,	/* UI_VIEWVERB */
	EIF_INTEGER		/* INT32 reasonCode */
	);

extern void c_set_eiffel_dispatcher(EIF_REFERENCE a_address);
extern void c_release_eiffel_dispatcher(void);
extern void c_set_execute_address (EIF_RIBBON_EXECUTE_PROC a_address);
extern void c_set_update_property_address(EIF_RIBBON_UPDATE_PROPERTY_PROC a_address);

extern void c_release_ribbon_object(void);
extern void c_set_on_create_ui_command_address(EIF_POINTER a_address);
extern void c_set_on_view_changed_address(EIF_POINTER a_address);

extern EIF_OBJECT eiffel_dispatcher;
	/* Address of Eiffel object EV_RIBBON_DISPATCHER */
extern EIF_RIBBON_EXECUTE_PROC eiffel_execute_function;
	/* Address of Eiffel EV_RIBBON_DISPATCHER.execute */
extern EIF_RIBBON_UPDATE_PROPERTY_PROC eiffel_update_property_function;
	/* Address of Eiffel EV_RIBBON_DISPATCHER.update_property */ 

extern EIF_RIBBON_ON_CREATE_UI_COMMAND_PROC eiffel_on_create_ui_command_function;
	/* Address of Eiffel EV_RIBBON_DISPATCHER.on_create_ui_command */
extern EIF_RIBBON_ON_VIEW_CHANGED_PROC eiffel_on_view_changed_function;
	/* Address of Eiffel EV_RIBBON_DISPATCHER.on_view_changed */


#ifdef __cplusplus
}
#endif

#endif	
