/*
 * Functions for dealing with callbacks.
 */

#include "mel.h"

private EIF_OBJ dispatcher; 		/* Eiffel Class Dispatcher in MEL */
private EIF_PROC e_handle_callback;	/* Eiffel routine that dispatches motif events */
private EIF_PROC e_handle_event;	/* Eiffel routine that dispatches Xt events */
private EIF_PROC e_handle_translation;	/* Eiffel routine that dispatches translations */
private EIF_PROC e_handle_wm_protocol;	/* Eiffel routine that dispatches wm protocols */
private EIF_PROC e_handle_input;	/* Eiffel routine that dispatches input events */
private EIF_PROC e_handle_timer;	/* Eiffel routine that dispatches timer events */
private EIF_PROC e_handle_work_proc;/* Eiffel routine that dispatches work procedures */

/* Functions */

struct work_struct {
    XtWorkProcId id;
};

void handle_callback (scr_obj, resource_name, call_data)
Widget scr_obj;
XtPointer resource_name;
XtPointer call_data;
{
	(e_handle_callback) (
				(EIF_OBJ) eif_access (dispatcher),
				(EIF_POINTER) scr_obj,			/* Widget which invoked callback */
				(EIF_POINTER) resource_name, 	/* Passed as a argument */
				(EIF_POINTER) call_data			/* Motif XmAnyCallback structure */
				);
}

void handle_event (scr_obj, mask, call_data)
Widget scr_obj;
XtPointer mask;
XtPointer call_data;
{
	(e_handle_event) (
				(EIF_OBJ) eif_access (dispatcher),
				(EIF_POINTER) scr_obj,			/* Widget which invoked callback */
				(EIF_INTEGER) mask, 			/* Passed as a argument */
				(EIF_POINTER) call_data			/* XEvent structure */
				);
}

void handle_wmprotocol (scr_obj, resource_name, call_data)
Widget scr_obj;
XtPointer resource_name;
XtPointer call_data;
{
	(e_handle_wm_protocol) (
				(EIF_OBJ) eif_access (dispatcher),
				(EIF_POINTER) scr_obj,			/* Widget which invoked callback */
				(EIF_POINTER) resource_name, 	/* Passed as a argument */
				(EIF_POINTER) call_data			/* Motif callback structure */
				);
}

void handle_translation (scr_obj, an_event, params, num_params)
Widget scr_obj;
XEvent *an_event;
String *params;
Cardinal *num_params;
{
	EIF_OBJ trans;

	if (*num_params) {
		sscanf (params [0], "0x%lX", &trans);
		(e_handle_translation) (
				(EIF_OBJ) eif_access (dispatcher),
				(EIF_POINTER) scr_obj,			/* Widget which invoked callback */
				(EIF_POINTER) eif_access (trans),/* Pass the translation as a argument */
				(EIF_POINTER) an_event			/* Pass the Xevent structure */
				);
	}
}

void handle_input (client_data, fid, id)
XtPointer client_data;
int *fid;
XtInputId *id;
{
	(e_handle_input) (
				(EIF_OBJ) eif_access (dispatcher),
				(EIF_POINTER) *id			/* Id of input event */
				);
}

void handle_timer (client_data, id)
XtPointer client_data;
XtIntervalId *id;
{
	(e_handle_timer) (
				(EIF_OBJ) eif_access (dispatcher),
				(EIF_POINTER) *id			/* Id of timer event */
				);
}

Boolean handle_work_proc (client_data)
XtPointer client_data;
{
	struct work_struct *ws = (struct work_struct *) client_data;
	((e_handle_work_proc) (
				(EIF_OBJ) eif_access (dispatcher),
				(EIF_POINTER) ws	/* Pass work structure to eiffel */
				));
	return False;
}

void c_add_callback (scr_obj, resource_name)
EIF_POINTER scr_obj;
EIF_POINTER resource_name;
{
	XtAddCallback ((Widget) scr_obj, 
				(String) resource_name, 
				handle_callback, 
				(XtPointer) resource_name);
}

EIF_POINTER c_add_input (app_context, fid, mask)
EIF_POINTER app_context;
EIF_INTEGER fid;
EIF_POINTER mask;
{
	return (EIF_POINTER) XtAppAddInput ((XtAppContext) app_context, 
								(int) fid,
								(XtPointer) mask,
								handle_input, 
								NULL);
}

EIF_POINTER c_add_timer (app_context, time)
EIF_POINTER app_context;
EIF_INTEGER time;
{
	return (EIF_POINTER) XtAppAddTimeOut ((XtAppContext) app_context, 
								(unsigned long) time,
								handle_timer, 
								NULL);
}

EIF_POINTER c_add_work_proc (app_context, int_id)
EIF_POINTER app_context;
EIF_INTEGER int_id;
{
	struct work_struct *ws;
	ws = (struct work_struct *) cmalloc(sizeof(struct work_struct));
	ws->id = XtAppAddWorkProc ((XtAppContext) app_context, 
								handle_work_proc, 
								ws);
	return (EIF_POINTER) ws;
}

void c_remove_callback (scr_obj, resource_name)
EIF_POINTER scr_obj;
EIF_POINTER resource_name;
{
	XtRemoveCallback ((Widget) scr_obj, 
				(String) resource_name, 
				handle_callback, 
				(XtPointer) resource_name);
}

void c_add_event_handler (scr_obj, mask)
EIF_POINTER scr_obj;
EIF_INTEGER mask;
{
	XtAddEventHandler ((Widget) scr_obj, 
				(EventMask) mask, 
				False,
				handle_event, 
				(XtPointer) mask);
}

void c_remove_event_handler (scr_obj, mask)
EIF_POINTER scr_obj;
EIF_INTEGER mask;
{
	XtRemoveEventHandler ((Widget) scr_obj, 
				(EventMask) mask, 
				False,
				handle_event, 
				(XtPointer) mask);
}

void c_set_override_translations (w, trans)
EIF_POINTER w;
char *trans;
{
	XtTranslations  trans_ptr;
		/*
		 * Set the override translation for widget `w'.
		 */

	trans_ptr = XtParseTranslationTable (trans);
	XtOverrideTranslations ((Widget) w, trans_ptr);
}

void c_add_wm_protocol (scr_obj, atom)
EIF_POINTER scr_obj;
EIF_POINTER atom;
{
	XmAddWMProtocolCallback ((Widget) scr_obj, 
		 		(Atom) atom,
				handle_wmprotocol, 
				(XtPointer) atom);
}

void c_remove_wm_protocol (scr_obj, atom)
EIF_POINTER scr_obj;
EIF_POINTER atom;
{
	XmRemoveWMProtocolCallback ((Widget) scr_obj, 
				(Atom) atom,
				handle_wmprotocol, 
				(XtPointer) atom);
}

void xt_remove_work_proc (id)
EIF_POINTER id;
{
	struct work_struct *ws = (struct work_struct *) id;

	XtRemoveWorkProc (ws->id);
	xfree (ws);
}

void set_procedures (hndl_callback_addr, 
					hndl_event_addr, 
					hndl_trans_addr,	
					hndl_wmprot_addr,
					hndl_input_addr,
					hndl_timer_addr,
					hndl_work_proc_addr)
EIF_PROC hndl_callback_addr;
EIF_PROC hndl_event_addr;
EIF_PROC hndl_trans_addr;
EIF_PROC hndl_wmprot_addr;
EIF_PROC hndl_input_addr;
EIF_PROC hndl_timer_addr;
EIF_PROC hndl_work_proc_addr;
{
		/*
		 * Initialize the Eiffel procedure addresses so
		 * they can be called from C
		 */
	e_handle_callback = hndl_callback_addr;
	e_handle_event = hndl_event_addr;
	e_handle_translation = hndl_trans_addr;
	e_handle_wm_protocol = hndl_wmprot_addr;
	e_handle_input = hndl_input_addr;
	e_handle_timer = hndl_timer_addr;
	e_handle_work_proc = hndl_work_proc_addr;
}

void set_dispatcher_object (dispatcher_address)
EIF_POINTER dispatcher_address;
{
	dispatcher = dispatcher_address;
}

