indexing
	description: 
		"Encapsulation of the Application Context of X.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_APPLICATION_CONTEXT

inherit

	EXCEPTIONS
		export
			{NONE} all
		end;

	SHARED_MEL_WIDGET_MANAGER
		export
			{NONE} all
		end;

	SHARED_MEL_DISPATCHER;

	MEL_APPLICATION_CONTEXT_RESOURCES

creation
	make, 
	make_from_existing

feature {NONE} -- Initialization

	make is
			-- Create the mel application context.
		do
			handle := xt_init;
			create_dispatcher
		ensure
			 application_context_is_valid: is_valid
		end;

	make_from_existing (a_pointer: POINTER) is
			-- Create a mel application context from 
			-- an existing application context.
		require
			pointer_not_null: a_pointer /= default_pointer
		do
			handle := a_pointer
		ensure
			application_context_is_valid: is_valid
		end;

feature -- Access

	handle: POINTER
			-- Associated C handle

feature -- Status report

	is_valid: BOOLEAN is
			-- Is the application context valid?
		do
			Result := handle /= default_pointer
		ensure
			is_valid_implies_non_null: Result implies handle /= default_pointer
		end;

	last_id: MEL_IDENTIFIER is
			-- Id from `add_input', `add_timer' and 
			-- `add_work' callbacks.
		do
			Result := Mel_dispatcher.last_id
		end;

	pending: INTEGER is
			-- Mask of pending event 
			-- (Null, if there are none)
		require
			is_valid: is_valid
		do
			Result := xt_app_pending (handle)
		ensure
			valid_result: Result /= 0 implies
					(Result = XtIMAlternateInput) or else 
					(Result = XtIMTimer) or else 
					(Result = XtIMXEvent) 
		end;

	next_event: MEL_EVENT is
			-- Retrieves the next event from the queue 
			-- (It waits until there is an event in the queue. The
			-- retrieved event is removed from the queue)
		require
			is_valid: is_valid
		local
			ms: MEL_CALLBACK_STRUCT
		do
			xt_app_next_event (handle, global_xevent_ptr);
			!! ms.make_event_only (global_xevent_ptr);
			Result := ms.event
		ensure
			event_returned: Result /= Void
		end;
	
	XtIMAlternateInput: INTEGER is
			-- Constant for Alternative input
			-- (Returned by `pending' and used for `process_event')
		external
			"C [macro <X11/Intrinsic.h>]: EIF_INTEGER"
		alias
			"XtIMAlternateInput"
		end;

	XtIMAll: INTEGER is
			-- Constant for all events
			-- (Used for `process_event')
		external
			"C [macro <X11/Intrinsic.h>]: EIF_INTEGER"
		alias
			"XtIMAll"
		end;

	XtIMTimer: INTEGER is
			-- Constant for timer event
			-- (Returned by `pending' and used for `process_event')
		external
			"C [macro <X11/Intrinsic.h>]: EIF_INTEGER"
		alias
			"XtIMTimer"
		end;

	XtIMXEvent: INTEGER is
			-- Constant for X events
			-- (Returned by `pending' and used for `process_event')
		external
			"C [macro <X11/Intrinsic.h>]: EIF_POINTER"
		alias
			"XtIMXEvent"
		end;

feature -- Element change

	set_default_resources (a_list: ARRAY [MEL_WIDGET_RESOURCE]) is
			-- Set the default resource setting's
		local
			out_list: ARRAY [ANY];
			ext: ANY;
			counter, number: INTEGER
		do
			if a_list /= Void then
				!! out_list.make (a_list.lower, a_list.upper);
				from
					counter := a_list.lower
				until
					counter > a_list.upper
				loop
					out_list.put (a_list.item (counter).resource_string.to_c, counter);
					counter := counter + 1
				end;
				number := a_list.count;
				ext := out_list.to_c
			end;
			set_fallback_res (handle, ext, number)
		end;

	add_input_read_callback (a_file: IO_MEDIUM; a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Add input callback for source file `a_file' to 
			-- a pending read on `a_file'.
			-- Set the id of the input callback to `last_id'.
			-- (Associated callback struct of `a_callback' is of type MEL_ID_CALLBACK_STRUCT).
		require
			is_valid: is_valid;
			file_not_void: a_file /= Void;
			callback_not_void: a_callback /= Void
		local
			a_callback_exec: MEL_CALLBACK_EXEC
		do
			!! a_callback_exec.make (a_callback, an_argument);
			Mel_dispatcher.add_input_callback
					(Current, a_file, XtInputReadMask, a_callback_exec);
		ensure
			valid_last_id: last_id /= Void and then last_id.is_valid
		end;

	add_input_write_callback (a_file: IO_MEDIUM; a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Add input callback for source file `a_file' to 
			-- a pending write on `a_file'.
			-- Set the id of the input callback to `last_id'.
			-- (Associated callback struct of `a_callback' is of type MEL_ID_CALLBACK_STRUCT).
		require
			is_valid: is_valid;
			file_not_void: a_file /= Void;
			callback_not_void: a_callback /= Void
		local
			a_callback_exec: MEL_CALLBACK_EXEC
		do
			!! a_callback_exec.make (a_callback, an_argument);
			Mel_dispatcher.add_input_callback
					(Current, a_file, XtInputWriteMask, a_callback_exec);
		ensure
			valid_last_id: last_id /= Void and then last_id.is_valid
		end;

	add_input_except_callback (a_file: IO_MEDIUM; a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Add input callback for source file `a_file' to 
			-- a pending I/O error on `a_file'.
			-- Set the id of the input callback to `last_id'.
			-- (Associated callback struct of `a_callback' is of type MEL_ID_CALLBACK_STRUCT).
		require
			is_valid: is_valid;
			file_not_void: a_file /= Void;
			callback_not_void: a_callback /= Void
		local
			a_callback_exec: MEL_CALLBACK_EXEC
		do
			!! a_callback_exec.make (a_callback, an_argument);
			Mel_dispatcher.add_input_callback
					(Current, a_file, XtInputExceptMask, a_callback_exec);
		ensure
			valid_last_id: last_id /= Void and then last_id.is_valid
		end;

	add_input_none_callback (a_file: IO_MEDIUM; a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Add input callback for source file `a_file' so that it
			-- never calls the registered function.
			-- Set the id of the input callback to `last_id'.
			-- (Associated callback struct of `a_callback' is of type MEL_ID_CALLBACK_STRUCT).
		require
			is_valid: is_valid;
			file_not_void: a_file /= Void;
			callback_not_void: a_callback /= Void
		local
			a_callback_exec: MEL_CALLBACK_EXEC
		do
			!! a_callback_exec.make (a_callback, an_argument);
			Mel_dispatcher.add_input_callback
					(Current, a_file, XtInputNoneMask, a_callback_exec);
		ensure
			valid_last_id: last_id /= Void and then last_id.is_valid
		end;

	add_time_out_callback (a_delay: INTEGER; a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Add time out callback for `a_callback' after `a_delay'
			-- milliseconds has elapsed.
			-- Set the id of the timer callback to `last_id'.
			-- (Associated callback struct of `a_callback' is of type MEL_ID_CALLBACK_STRUCT).
			-- (The time out callback is automatically removed after it has been invoked).
		require
			is_valid: is_valid;
			valid_time: a_delay > 0;
			callback_not_void: a_callback /= Void
		local
			a_callback_exec: MEL_CALLBACK_EXEC
		do
			!! a_callback_exec.make (a_callback, an_argument);
			Mel_dispatcher.add_timer_callback
					(Current, a_delay, a_callback_exec);
		ensure
			valid_last_id: last_id /= Void and then last_id.is_valid
		end;

	add_work_proc_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Add work procedure callback `a_callback'. 
			-- Set the id of the work proc to `last_id'.
			-- (Associated callback struct of `a_callback' is of type MEL_ID_CALLBACK_STRUCT).
		require
			is_valid: is_valid;
			callback_not_void: a_callback /= Void
		local
			a_callback_exec: MEL_CALLBACK_EXEC
		do
			!! a_callback_exec.make (a_callback, an_argument);
			Mel_dispatcher.add_work_proc_callback
					(Current, a_callback_exec);
		ensure
			valid_last_id: last_id /= Void and then last_id.is_valid
		end;

feature -- Update

	iterate is
			-- Loop the application.
		require
			is_valid: is_valid;
		do
			xt_app_main_loop (handle)
		end;

	process_event (a_mask: INTEGER) is
			-- Process one X event, alternative input source or timer
			-- event in Current application context based on `a_mask'.
			-- This routine will block until an event of type `a_mask'
			-- becomes available.
		require
			is_valid: is_valid;
			valid_mask: a_mask = XtIMAlternateInput or else
					a_mask = XtIMTimer or else
					a_mask = XtIMXEvent or else
					a_mask = XtIMAll
		do
			xt_app_process_event (handle, a_mask)
		end;

	dispatch_event (an_event: MEL_EVENT) is
			-- Dispatch `an_event' to the appropriated event handler.
		require
			valid_an_event: an_event /= Void 
		do
			if xt_dispatch_event (an_event.handle) then
			end
		end;

feature -- Removal

	destroy is
			-- Destroy the application context.
		require
			application_context_is_valid: is_valid
		do
			xt_destroy_application_context (handle);
		end;

	exit is
			-- Destroy the application context and then
			-- exit the application.
		require
			application_context_is_valid: is_valid
		do
			xt_destroy_application_context (handle);
			new_die (0)
		end;

feature {NONE} -- Implementation

	create_dispatcher is
			-- Create the `dispatcher' for MEL callbacks.
		local
			dispatcher: MEL_DISPATCHER;
		once
			if Mel_dispatcher /= Void then end
		end;

	last_id_ref: CELL [MEL_IDENTIFIER] is
			-- Last id saved
		once
			!! Result.put (Void)
		end;

feature {NONE} -- Implementation

	xt_destroy_application_context (app_contxt: POINTER) is
		external
			"C [macro <X11/Intrinsic.h>] (XtAppContext)"
		alias
			"XtDestroyApplicationContext"
		end;

	xt_init: POINTER is
		external
			"C"
		end;

	xt_app_main_loop (app_contxt: POINTER) is
		external
			"C [macro <X11/Intrinsic.h>] (XtAppContext)"
		alias
			"XtAppMainLoop"
		end;

	set_fallback_res (app_contxt: POINTER; resource_list: ANY; count: INTEGER) is
		external
			"C"
		end;

	xt_app_pending (app_contxt: POINTER): INTEGER is
		external
			"C [macro <X11/Intrinsic.h>] (XtAppContext): EIF_INTEGER"
		alias
			"XtAppPending"
		end;

	xt_app_process_event (app_contxt: POINTER; a_mask: INTEGER) is
		external
			"C [macro <X11/Intrinsic.h>] (XtAppContext, XtInputMask)"
		alias
			"XtAppProcessEvent"
		end;

	xt_dispatch_event (an_event: POINTER): BOOLEAN is
		external
			"C [macro <X11/Intrinsic.h>] (XEvent *): EIF_BOOLEAN"
		alias
			"XtDispatchEvent"
		end;

	xt_app_next_event (app_context: POINTER; an_event: POINTER) is
		external
			"C [macro <X11/Intrinsic.h>] (XtAppContext, XEvent *)"
		alias
			"XtAppNextEvent"
		end;

 	global_xevent_ptr: POINTER is
        external
            "C [macro <mel.h>]: XEvent *"
        end;

end -- class MEL_APPLICATION_CONTEXT

--|-----------------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1996, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-----------------------------------------------------------------------
