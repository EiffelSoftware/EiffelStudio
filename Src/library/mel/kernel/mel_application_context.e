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
			-- Id from `set_input', `set_time_out' and 
			-- `set_work' callbacks.
		do
			Result := Mel_dispatcher.last_id
		end;

	pending: INTEGER is
			-- Mask of pending event 
			-- (Zero, if there are none)
		require
			is_valid: is_valid
		do
			Result := xt_app_pending (handle)
		ensure
			valid_result: Result /= 0 implies
					(Result <= XtIMAll) 
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

	set_input_read_callback (a_file: IO_MEDIUM; a_command: MEL_COMMAND; an_argument: ANY) is
			-- Set `a_command' to be executed for a pending read on a `a_file'.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
			-- Set the id of the input callback to `last_id'.
			-- (Associated callback struct of `a_command' is of type MEL_ID_CALLBACK_STRUCT).
		require
			is_valid: is_valid;
			file_not_void: a_file /= Void;
			command_not_void: a_command /= Void
		local
			a_command_exec: MEL_COMMAND_EXEC
		do
			!! a_command_exec.make (a_command, an_argument);
			Mel_dispatcher.set_input_callback
					(Current, a_file, XtInputReadMask, a_command_exec);
		ensure
			valid_last_id: last_id /= Void and then last_id.is_valid
		end;

	set_input_write_callback (a_file: IO_MEDIUM; a_command: MEL_COMMAND; an_argument: ANY) is
			-- Set `a_command' to be executed for a pending write to a `a_file'.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
			-- Set the id of the input callback to `last_id'.
			-- (Associated callback struct of `a_command' is of type MEL_ID_CALLBACK_STRUCT).
		require
			is_valid: is_valid;
			file_not_void: a_file /= Void;
			command_not_void: a_command /= Void
		local
			a_command_exec: MEL_COMMAND_EXEC
		do
			!! a_command_exec.make (a_command, an_argument);
			Mel_dispatcher.set_input_callback
					(Current, a_file, XtInputWriteMask, a_command_exec);
		ensure
			valid_last_id: last_id /= Void and then last_id.is_valid
		end;

	set_input_except_callback (a_file: IO_MEDIUM; a_command: MEL_COMMAND; an_argument: ANY) is
			-- Set `a_command' to be executed for a pending I/O on `a_file'.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
			-- Set the id of the input callback to `last_id'.
			-- (Associated callback struct of `a_command' is of type MEL_ID_CALLBACK_STRUCT).
		require
			is_valid: is_valid;
			file_not_void: a_file /= Void;
			command_not_void: a_command /= Void
		local
			a_command_exec: MEL_COMMAND_EXEC
		do
			!! a_command_exec.make (a_command, an_argument);
			Mel_dispatcher.set_input_callback
					(Current, a_file, XtInputExceptMask, a_command_exec);
		ensure
			valid_last_id: last_id /= Void and then last_id.is_valid
		end;

	set_input_none_callback (a_file: IO_MEDIUM; a_command: MEL_COMMAND; an_argument: ANY) is
			-- Set `a_command' to be executed so that it never calls
			-- the registered function.
			-- `argument' will be passed to `a_command' whenever it is
			-- Set the id of the input callback to `last_id'.
			-- (Associated callback struct of `a_command' is of type MEL_ID_CALLBACK_STRUCT).
		require
			is_valid: is_valid;
			file_not_void: a_file /= Void;
			command_not_void: a_command /= Void
		local
			a_command_exec: MEL_COMMAND_EXEC
		do
			!! a_command_exec.make (a_command, an_argument);
			Mel_dispatcher.set_input_callback
					(Current, a_file, XtInputNoneMask, a_command_exec);
		ensure
			valid_last_id: last_id /= Void and then last_id.is_valid
		end;

	set_time_out_callback (a_delay: INTEGER; a_command: MEL_COMMAND; an_argument: ANY) is
			-- Set `a_command' to be executed after `a_delay'
			-- milliseconds has elapsed.
			-- `argument' will be passed to `a_command' whenever it is
			-- Add time out callback for `a_command' after `a_delay'
			-- Set the id of the timer callback to `last_id'.
			-- (Associated callback struct of `a_command' is of type MEL_ID_CALLBACK_STRUCT).
			-- (The time out callback is automatically removed after it has been invoked).
		require
			is_valid: is_valid;
			valid_time: a_delay > 0;
			command_not_void: a_command /= Void
		local
			a_command_exec: MEL_COMMAND_EXEC
		do
			!! a_command_exec.make (a_command, an_argument);
			Mel_dispatcher.set_time_out_callback
					(Current, a_delay, a_command_exec);
		ensure
			valid_last_id: last_id /= Void and then last_id.is_valid
		end;

	set_work_proc_callback (a_command: MEL_COMMAND; an_argument: ANY) is
			-- Set `a_command' to be executed for work procedure callback.
			-- `argument' will be passed to `a_command' whenever it is
			-- Set the id of the work proc to `last_id'.
			-- (Associated callback struct of `a_command' is of type MEL_ID_CALLBACK_STRUCT).
		require
			is_valid: is_valid;
			command_not_void: a_command /= Void
		local
			a_command_exec: MEL_COMMAND_EXEC
		do
			!! a_command_exec.make (a_command, an_argument);
			Mel_dispatcher.set_work_proc_callback
					(Current, a_command_exec);
		ensure
			valid_last_id: last_id /= Void and then last_id.is_valid
		end;

feature -- Update

	main_loop is
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
			valid_mask: a_mask <= XtIMAll
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
			die (0)
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
			"C (XtAppContext) | <X11/Intrinsic.h>"
		alias
			"XtDestroyApplicationContext"
		end;

	xt_init: POINTER is
		external
			"C"
		end;

	xt_app_main_loop (app_contxt: POINTER) is
		external
			"C (XtAppContext) | <X11/Intrinsic.h>"
		alias
			"XtAppMainLoop"
		end;

	set_fallback_res (app_contxt: POINTER; resource_list: ANY; count: INTEGER) is
		external
			"C"
		end;

	xt_app_pending (app_contxt: POINTER): INTEGER is
		external
			"C(XtAppContext): EIF_INTEGER | <X11/Intrinsic.h>"
		alias
			"XtAppPending"
		end;

	xt_app_process_event (app_contxt: POINTER; a_mask: INTEGER) is
		external
			"C (XtAppContext, XtInputMask) | <X11/Intrinsic.h>"
		alias
			"XtAppProcessEvent"
		end;

	xt_dispatch_event (an_event: POINTER): BOOLEAN is
		external
			"C (XEvent *): EIF_BOOLEAN | <X11/Intrinsic.h>"
		alias
			"XtDispatchEvent"
		end;

	xt_app_next_event (app_context: POINTER; an_event: POINTER) is
		external
			"C (XtAppContext, XEvent *) | <X11/Intrinsic.h>"
		alias
			"XtAppNextEvent"
		end;

 	global_xevent_ptr: POINTER is
		external
			"C [macro %"mel.h%"]: XEvent *"
		end;

end -- class MEL_APPLICATION_CONTEXT


--|----------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

