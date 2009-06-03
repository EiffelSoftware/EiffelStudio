/*
 * Functions for dealing with callbacks.
 */

#include "mel.h"
#ifdef EIF_VMS
#include "eif4:[c.ipc.shared]ipcvms.h"
# define NeedFunctionPrototypes 1	/* ensure we get Xt prototypes */
#endif


rt_private EIF_OBJ dispatcher; 		/* Eiffel Class Dispatcher in MEL */
rt_private EIF_PROC e_handle_callback;	/* Eiffel routine that dispatches motif events */
rt_private EIF_PROC e_handle_event;	/* Eiffel routine that dispatches Xt events */
rt_private EIF_PROC e_handle_translation;	/* Eiffel routine that dispatches translations */
rt_private EIF_PROC e_handle_wm_protocol;	/* Eiffel routine that dispatches wm protocols */
rt_private EIF_PROC e_handle_input;	/* Eiffel routine that dispatches input events */
rt_private EIF_PROC e_handle_timer;	/* Eiffel routine that dispatches timer events */
rt_private EIF_PROC e_handle_work_proc;/* Eiffel routine that dispatches work procedures */
rt_private EIF_PROC e_handle_lose_callback;/* Eiffel routine that dispatches 
											lose selection callback */
rt_private EIF_PROC e_handle_done_callback;/* Eiffel routine that dispatches 
											done selection callback */
rt_private EIF_PROC e_handle_requestor_callback;/* Eiffel routine that dispatches 
											the requestor callback */

/* Functions */

struct work_struct {
	XtWorkProcId id;
};

void handle_callback (Widget scr_obj, XtPointer resource_name, XtPointer call_data)
{
	(e_handle_callback) (
				(EIF_OBJ) eif_access (dispatcher),
				(EIF_POINTER) scr_obj,			/* Widget which invoked callback */
				(EIF_POINTER) resource_name, 	/* Passed as a argument */
				(EIF_POINTER) call_data			/* Motif XmAnyCallback structure */
				);
}

void handle_event (Widget scr_obj, XtPointer mask, XtPointer call_data)
{
	(e_handle_event) (
				(EIF_OBJ) eif_access (dispatcher),
				(EIF_POINTER) scr_obj,			/* Widget which invoked callback */
				(EIF_INTEGER) mask, 			/* Passed as a argument */
				(EIF_POINTER) call_data			/* XEvent structure */
				);
}

void handle_wmprotocol (Widget scr_obj, XtPointer resource_name, XtPointer call_data)
{
	(e_handle_wm_protocol) (
				(EIF_OBJ) eif_access (dispatcher),
				(EIF_POINTER) scr_obj,			/* Widget which invoked callback */
				(EIF_POINTER) resource_name, 	/* Passed as a argument */
				(EIF_POINTER) call_data			/* Motif callback structure */
				);
}

void handle_translation (Widget scr_obj, XEvent *an_event,
	String *params, Cardinal *num_params)
{
	EIF_OBJ trans;

	if (*num_params) {
		sscanf (params [0], "0x%lX", &trans);
		(e_handle_translation) (
				(EIF_OBJ) eif_access (dispatcher),
				(EIF_POINTER) scr_obj,			/* Widget which invoked callback */
				(EIF_OBJ) eif_access (trans),	/* Pass the translation as a argument */
				(EIF_POINTER) an_event			/* Pass the Xevent structure */
				);
	}
}

void handle_input (XtPointer client_data, int *fid, XtInputId *id)
{
	(e_handle_input) (
				(EIF_OBJ) eif_access (dispatcher),
				(EIF_POINTER) *id			/* Id of input event */
				);
}

void handle_timer (XtPointer client_data, XtIntervalId *id)
{
	(e_handle_timer) (
				(EIF_OBJ) eif_access (dispatcher),
				(EIF_POINTER) *id			/* Id of timer event */
				);
}

Boolean handle_work_proc (XtPointer client_data)
{
	struct work_struct *ws = (struct work_struct *) client_data;
	((e_handle_work_proc) (
				(EIF_OBJ) eif_access (dispatcher),
				(EIF_POINTER) ws	/* Pass work structure to eiffel */
				));
	return False;
}

void c_add_callback (EIF_POINTER scr_obj, EIF_POINTER resource_name)
{
	XtAddCallback ((Widget) scr_obj, 
				(String) resource_name, 
				handle_callback, 
				(XtPointer) resource_name);
}

EIF_POINTER c_add_input (EIF_POINTER app_context, EIF_INTEGER fid, EIF_POINTER mask)
{
#ifdef EIF_VMS
	int efn = ipcvms_get_fd_efn(fid, O_RDONLY);
	static int save_fid;
	save_fid = fid;
	fid = efn;
	return (EIF_POINTER) XtAppAddInput ((XtAppContext) app_context, 
			(int) fid,
			(XtPointer) 0,	    /* can be an IOSB? */
			handle_input, 
			NULL);
#else  /* EIF_VMS */
	return (EIF_POINTER) XtAppAddInput ((XtAppContext) app_context, 
			(int) fid,
			(XtPointer) mask,
			handle_input, 
			NULL);
#endif /* EIF_VMS */
}

EIF_POINTER c_add_timer (EIF_POINTER app_context, EIF_INTEGER time)
{
	return (EIF_POINTER) XtAppAddTimeOut ((XtAppContext) app_context, 
								(unsigned long) time,
								handle_timer, 
								NULL);
}

EIF_POINTER c_add_work_proc (EIF_POINTER app_context, EIF_INTEGER int_id)
{
	struct work_struct *ws;
	ws = (struct work_struct *) cmalloc(sizeof(struct work_struct));
	ws->id = XtAppAddWorkProc ((XtAppContext) app_context, 
								handle_work_proc, 
								ws);
	return (EIF_POINTER) ws;
}

void c_remove_callback (EIF_POINTER scr_obj, EIF_POINTER resource_name)
{
	XtRemoveCallback ((Widget) scr_obj, 
				(String) resource_name, 
				handle_callback, 
				(XtPointer) resource_name);
}

void c_add_event_handler (EIF_POINTER scr_obj, EIF_INTEGER mask)
{
	XtAddEventHandler ((Widget) scr_obj, 
				(EventMask) mask, 
				False,
#ifdef EIF_VMS
				(XtEventHandler) handle_event, 
#else
				handle_event, 
#endif
				(XtPointer) mask);
}

void c_remove_event_handler (EIF_POINTER scr_obj, EIF_INTEGER mask)
{
	XtRemoveEventHandler ((Widget) scr_obj, 
				(EventMask) mask, 
				False,
#ifdef EIF_VMS
				(XtEventHandler) handle_event, 
#else
				handle_event, 
#endif
				(XtPointer) mask);
}

void c_set_override_translations (EIF_POINTER w, char *trans)
{
	XtTranslations  trans_ptr;
		/*
		 * Set the override translation for widget `w'.
		 */

	trans_ptr = XtParseTranslationTable (trans);
	XtOverrideTranslations ((Widget) w, trans_ptr);
}

void c_add_wm_protocol_callback (EIF_POINTER scr_obj, EIF_POINTER atom)
{
	XmAddWMProtocolCallback ((Widget) scr_obj, 
		 		(Atom) atom,
				handle_wmprotocol, 
				(XtPointer) atom);
}

void c_remove_wm_protocol_callback (EIF_POINTER scr_obj, EIF_POINTER atom)
{
	XmRemoveWMProtocolCallback ((Widget) scr_obj, 
				(Atom) atom,
				handle_wmprotocol, 
				(XtPointer) atom);
}

void xt_remove_work_proc (EIF_POINTER id)
{
	struct work_struct *ws = (struct work_struct *) id;

	XtRemoveWorkProc (ws->id);
#ifdef EIF_VMS
	eif_rt_xfree (id);
#else
	eif_rt_xfree (ws);
#endif
}

/*
 * Selection mechanism
 */

rt_private char *string_passed; /* String value selected. */
rt_private Atom target_atom;/* 
						  * Target Atom of the selection.
						  * This value can be used to identify the string representation
						  * between Eiffel applications. (Note: Eiffel will only
						  * support string data).
						  */

void free_string()
{
	if (string_passed) {
		XtFree (string_passed);
	}
	string_passed = NULL;
}

/*
 * The following routines deals with requesting the data.
 */

rt_private void requestor_callback (Widget w, XtPointer client_data, 
	Atom *selection, Atom *type, XtPointer value, unsigned long *length, int *format)
{
	if ((value == NULL) && (*length == 0)) 
		return; /* Return immediately if there is no value. */

	(e_handle_requestor_callback) (
				(EIF_OBJ) eif_access (dispatcher),
				(EIF_POINTER) value,
				(EIF_INTEGER) *length
				);
	XtFree (value); 	/* Must always free the value. */
}

rt_public void xt_get_selection_value (EIF_POINTER w, EIF_POINTER target, EIF_INTEGER time)
{
	XtGetSelectionValue ((Widget) w, XA_PRIMARY, (Atom) target,	
			requestor_callback, NULL, time);
}

/*
 * The following routines deals with ownership.
 */

rt_private Boolean convert_proc (Widget w, Atom *selection, Atom *target, 
	Atom *type_return, XtPointer *value_return, unsigned long *length_return,
	int *format_return)
{
	if ((*target) == target_atom) {
		*value_return = string_passed;
		*length_return = strlen (string_passed);
		*type_return = target_atom;
		*format_return = 8;
		return (True);
	}
	return (False);
}

rt_private void lose_ownership_proc (Widget w, Atom *selection)
{
	(e_handle_lose_callback) (
				(EIF_OBJ) eif_access (dispatcher)
				);
	free_string();
}

rt_private void transfer_done_proc (Widget w, Atom *selection, Atom *target)
{
	if ((*target==target_atom) || (*target==XA_STRING)) {
		(e_handle_done_callback) (
					(EIF_OBJ) eif_access (dispatcher)
					);
	}
}

rt_public void xt_own_selection (EIF_POINTER w, EIF_POINTER target, EIF_INTEGER time, EIF_POINTER a_string)
{
	if (XtOwnSelection ((Widget) w, XA_PRIMARY, (Time) time, 
			convert_proc, lose_ownership_proc, transfer_done_proc) == False)
		XtWarning ("Failed attempting to become selection owner.\n \
			Try to select again.\n");	
	else {
		target_atom = (Atom) target;
		free_string();
		string_passed = XtNewString ((char *) a_string);
	}
}

/*
 * Setting callback routines into Eiffel.
 */
void set_procedures (EIF_PROC hndl_callback_addr, EIF_PROC hndl_event_addr,
	EIF_PROC hndl_trans_addr, EIF_PROC hndl_wmprot_addr,
	EIF_PROC hndl_input_addr, EIF_PROC hndl_timer_addr,
	EIF_PROC hndl_work_proc_addr, EIF_PROC hndl_lose_callback_addr,
	EIF_PROC hndl_done_callback_addr, EIF_PROC hndl_requestor_callback_addr)
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
	e_handle_lose_callback = hndl_lose_callback_addr;
	e_handle_done_callback = hndl_done_callback_addr;
	e_handle_requestor_callback = hndl_requestor_callback_addr;
}

void set_dispatcher_object (EIF_POINTER dispatcher_address)
{
	dispatcher = dispatcher_address;
}

