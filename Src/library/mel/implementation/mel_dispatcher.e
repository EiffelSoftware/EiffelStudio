indexing

	description: 
		"Dispatches the callbacks to the MEL widgets.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_DISPATCHER

inherit

	SHARED_MEL_WIDGET_MANAGER
		export
			{MEL_OBJECT} Mel_Widgets
		end;

	MEL_CALLBACK_STRUCT_CONSTANTS
		export
			{NONE} all
		end;

	MEL_OBJECT_RESOURCES
		export
			{NONE} all
		end

creation
	make

feature {NONE} -- Initialization

	make is
			-- Initialize the C variables
		do
			!! xt_input_callbacks.make (1);
			!! xt_timer_callbacks.make (1)
			!! xt_work_proc_callbacks.make (1)
			set_procedures ($handle_callback, $handle_event, 
					$handle_translation, $handle_wm_protocol,
					$handle_input, $handle_timer,
					$handle_work_proc, $handle_lose_callback,
					$handle_done_callback,
					$handle_requestor_callback);
			set_dispatcher_object (eif_adopt (Current))
		end

feature {MEL_SELECTION} -- Implementation

	lose_command: MEL_COMMAND_EXEC;
			-- Lose selection command

	done_command: MEL_COMMAND_EXEC;
			-- Done selection command

	requestor_command: MEL_COMMAND_EXEC
			-- Requestor command

	make_own_selection (a_widget: MEL_WIDGET;
				target_atom: MEL_ATOM;
				time: INTEGER;
				a_string: STRING;
				lose_cmd: like lose_command;
				done_cmd: like done_command) is
			-- Initialize Current to initiate the sending of data
			-- though the selection mechanism.
			-- `time' specifies the the selection should commence (should
			-- be taken the MEL_EVENT class).
			-- `target_atom' indicates the data representation (usually
			-- you use the `make_string' from MEL_ATOM to identify a STRING atom).
			-- It can be used to represent you're own representation of the
			-- data.
			-- `a_string' is the data that is being claimed for selection.
			-- `lose_cmd' will be invoked when another widget successfully
			-- claims the selection.
			-- `done_command' will be invoked when the transfer is complete.
		require
			valid_widget: a_widget /= Void;
			time_not_zero: time /= 0;
		local
			an_atom: MEL_ATOM;
			ext_string: ANY;
			old_lose_command: like lose_command
		do
			ext_string := a_string.to_c;
			xt_own_selection (a_widget.screen_object, 
						target_atom.identifier, time, $ext_string)
			lose_command := lose_cmd;
			done_command := done_cmd;
		end;

	make_get_selection_value (a_widget: MEL_WIDGET;
				target_atom: MEL_ATOM;
				time: INTEGER; 
				requestor_cmd: like requestor_command) is
			-- Initialize Current to obtain data though the
			-- selection mechanism.
			-- `time' specifies the the selection should commence (should
			-- be taken the MEL_EVENT class).
			-- `target_atom' indicates the data representation that the user
			-- wishes to receive.
			-- `requestor_cmd' will be invoked with the data transferred (data
			-- is of type of STRING and is passed as an argument to the
			-- `execute' routine).
		require
			valid_widget: a_widget /= Void;
			time_not_zero: time /= 0;
		do
			requestor_command := requestor_cmd;
			xt_get_selection_value (a_widget.screen_object,
				target_atom.identifier, time)
		end;

feature {MEL_APPLICATION_CONTEXT} -- Implementation

	set_input_callback (app_context: MEL_APPLICATION_CONTEXT;
				file: IO_MEDIUM;	
				a_mask: POINTER;
				a_command_exec: MEL_COMMAND_EXEC) is
			-- Add input callback for `a_screen_object' with `mask'
		require
			valid_app_cont: app_context /= Void and app_context.is_valid;
			non_void_file: file /= Void;
			a_mask_not_null: a_mask /= default_pointer;
			valid_exec: a_command_exec /= Void
		local
			id: POINTER
		do	
			id := c_add_input (app_context.handle, file.handle, a_mask);
			!! last_id.make_input (id);
			xt_input_callbacks.put (a_command_exec, id)
		end;

	set_time_out_callback (app_context: MEL_APPLICATION_CONTEXT;
				time: INTEGER;	
				a_command_exec: MEL_COMMAND_EXEC) is
			-- Add timer callback for `app_context' with `time'.
		require
			valid_app_cont: app_context /= Void and app_context.is_valid;
			valid_time: time >= 0;
			valid_exec: a_command_exec /= Void
		local
			id: POINTER
		do	
			id := c_add_timer (app_context.handle, time);
			!! last_id.make_timer (id);
			xt_timer_callbacks.put (a_command_exec, id)
		end;

	set_work_proc_callback (app_context: MEL_APPLICATION_CONTEXT;
				a_command_exec: MEL_COMMAND_EXEC) is
			-- Add work procedure callback for `app_context'.
		require
			valid_app_cont: app_context /= Void and app_context.is_valid;
			valid_exec: a_command_exec /= Void
		local
			id: POINTER
		do	
			id := c_add_work_proc (app_context.handle);
			!! last_id.make_work_proc (id);
			xt_work_proc_callbacks.put (a_command_exec, id)
		end;

feature {MEL_IDENTIFIER} -- Implementation
				
	remove_input_callback (id: MEL_IDENTIFIER) is
			-- Remove input callback with `id'.
		require
			valid_id: id /= Void and then id.is_valid;
			id_is_input: id.is_input
		do	
			xt_input_callbacks.remove (id.identifier);
			xt_remove_input (id.identifier)
		ensure
			removed: not xt_input_callbacks.has (id.identifier)
		end;

	remove_timer_callback (id: MEL_IDENTIFIER) is
			-- Remove timer callback with `id'.
		require
			valid_id: id /= Void and then id.is_valid;
			id_is_timer: id.is_timer
		do	
			xt_timer_callbacks.remove (id.identifier);
			xt_remove_time_out (id.identifier)
		ensure
			removed: not xt_timer_callbacks.has (id.identifier)
		end;

	remove_work_proc_callback (id: MEL_IDENTIFIER) is
			-- Remove work proc callback with `id'.
		require
			valid_id: id /= Void and then id.is_valid;
			id_is_work_proc: id.is_work_proc
		do	
			xt_work_proc_callbacks.remove (id.identifier);
			xt_remove_work_proc (id.identifier)
		ensure
			removed: not xt_work_proc_callbacks.has (id.identifier)
		end;

feature {MEL_OBJECT} -- Implementation

	xt_input_callbacks: HASH_TABLE [MEL_COMMAND_EXEC, POINTER];
			-- Xt callbacks for input

	xt_timer_callbacks: HASH_TABLE [MEL_COMMAND_EXEC, POINTER];
			-- Xt callbacks for timer

	xt_work_proc_callbacks: HASH_TABLE [MEL_COMMAND_EXEC, POINTER];
			-- Xt callbacks for work procedures

feature {MEL_APPLICATION_CONTEXT}

	last_id: MEL_IDENTIFIER;
			-- Last identifer for input, work_proc and timer callback addition

feature {NONE} -- External features passed out to C

	frozen handle_wm_protocol (a_screen_object: POINTER; 
				atom: POINTER; 
				a_callback_struct_ptr: POINTER) is
			-- Handle the Xm event that was specified in `set_wm_callback'.
			-- Call the callbacks of the MEL widget that has `a_screen_object'
			-- and create the MEL_CALLBACK_STRUCT object associated to the event.
		require
			valid_a_screen_object: a_screen_object /= default_pointer;
			a_callback_struct_ptr: a_callback_struct_ptr /= default_pointer;
			widget_exists: Mel_widgets.has (a_screen_object);
		local
			a_callback_struct: MEL_CALLBACK_STRUCT;
			a_widget: MEL_OBJECT;
			a_key: MEL_CALLBACK_KEY
		do
			a_widget := Mel_widgets.item (a_screen_object);
			!! a_callback_struct.make (a_widget, 
						c_event (a_callback_struct_ptr)); 
			!! a_key.make_wm_protocol (atom);
			a_widget.execute_callback (a_key, a_callback_struct)
		end;

	frozen handle_callback (a_screen_object: POINTER; 
				resource_name: POINTER; 
				a_callback_struct_ptr: POINTER) is
			-- Handle the Xm event that was specified in `set_callback'.
			-- Call the callbacks of the MEL widget that has `a_screen_object'
			-- and create the MEL_CALLBACK_STRUCT object associated to the event.
		require
			valid_a_screen_object: a_screen_object /= default_pointer;
			widget_exists: Mel_widgets.has (a_screen_object)
		local
			a_callback_struct: MEL_CALLBACK_STRUCT;
			a_key: MEL_CALLBACK_KEY;
			a_widget: MEL_OBJECT
		do
			a_widget := Mel_widgets.item (a_screen_object);
			!! a_key.make_motif (resource_name);
			a_callback_struct := create_callback_struct (a_widget, 
									a_callback_struct_ptr, resource_name);
			a_widget.execute_callback (a_key, a_callback_struct)
		end;

	frozen handle_event (a_screen_object: POINTER; 
				mask: INTEGER; 
				event_ptr: POINTER) is
			-- Handle the Xt event that was specified in `set_event_handler'.
			-- Call the callbacks of the MEL widget that has `a_screen_object'
			-- and create the MEL_CALLBACK_STRUCT object associated to the event.
		require
			valid_a_screen_object: a_screen_object /= default_pointer;
			a_callback_struct_ptr: event_ptr /= default_pointer;
			widget_exists: Mel_widgets.has (a_screen_object)
		local
			a_callback_struct: MEL_CALLBACK_STRUCT;
			a_key: MEL_CALLBACK_KEY;
			a_widget: MEL_OBJECT
		do
			a_widget := Mel_widgets.item (a_screen_object);
			!! a_callback_struct.make (a_widget, event_ptr);
			!! a_key.make_xt_event (mask);
			a_widget.execute_callback (a_key, a_callback_struct)
		end;

	frozen handle_translation (a_screen_object: POINTER; 
				a_translation: STRING; 
				event_ptr: POINTER) is
			-- Handle the Xt event that was specified in `set_translation'.
			-- Call the callbacks of the MEL widget that has `a_screen_object'
			-- and create the MEL_CALLBACK_STRUCT object associated to the event.
		require
			valid_a_screen_object: a_screen_object /= default_pointer;
			translation_not_void: a_translation /= Void;
			a_callback_struct_ptr: event_ptr /= default_pointer;
			widget_exists: Mel_widgets.has (a_screen_object);
		local
			a_callback_struct: MEL_CALLBACK_STRUCT;
			a_widget: MEL_OBJECT;
			a_key: MEL_TRANSLATION;
			str: STRING
		do
			a_widget := Mel_widgets.item (a_screen_object);
			!! a_key.make_no_adopted (a_translation);
			!! a_callback_struct.make (a_widget, event_ptr);
			a_widget.execute_callback (a_key, a_callback_struct)
		end;

	frozen handle_input (id: POINTER) is
			-- Handle the input event with `id'.
		require
			non_null_id: id /= default_pointer;
			has_id: xt_input_callbacks.has (id);
		local
			mel_exec: MEL_COMMAND_EXEC;
			mel_struct: MEL_ID_CALLBACK_STRUCT;
			mel_id: MEL_IDENTIFIER
		do
			!! mel_id.make_input (id);
			!! mel_struct.make (mel_id);
			mel_exec := xt_input_callbacks.item (id);
			mel_exec.execute (mel_struct)
		end;

	frozen handle_timer (id: POINTER) is
			-- Handle the timer event with `id'.
			-- Remove the entry with `id' after the callback
			-- is invoked
		require
			non_null_id: id /= default_pointer;
			has_id: xt_timer_callbacks.has (id);
		local
			mel_exec: MEL_COMMAND_EXEC;
			mel_struct: MEL_ID_CALLBACK_STRUCT;
			mel_id: MEL_IDENTIFIER
		do
			!! mel_id.make_timer (id);
			!! mel_struct.make (mel_id);
			mel_exec := xt_timer_callbacks.item (id);
			mel_exec.execute (mel_struct);
			xt_timer_callbacks.remove (id)
		ensure
			removed: not xt_timer_callbacks.has (id)
		end;

	frozen handle_work_proc (id: POINTER) is
			-- Handle the work proc event with `id'.
		require
			non_null_id: id /= default_pointer;
		local
			mel_exec: MEL_COMMAND_EXEC;
			mel_struct: MEL_ID_CALLBACK_STRUCT;
			mel_id: MEL_IDENTIFIER
		do
			if  xt_work_proc_callbacks.has (id) then
				!! mel_id.make_work_proc (id);
				!! mel_struct.make (mel_id);
				mel_exec := xt_work_proc_callbacks.item (id);
				mel_exec.execute (mel_struct)
			end
		end;

	frozen handle_requestor_callback (c_string: POINTER; len: INTEGER) is
			-- Handle the requestor callback. Create an eiffel string
			-- from `c_string;.
		require
			valid_c_string: c_string /= default_pointer
		local
			str: STRING
		do
			if requestor_command /= Void then
				!! str.make (len);
				str.from_c_substring (c_string, 1, len);
				requestor_command.command.execute (str)
			end
		end;

	frozen handle_lose_callback is
			-- Handle the lose callback. 
		local
			str: STRING
		do
			if lose_command /= Void then
				lose_command.command.execute (lose_command.argument)
			end
		end;

	frozen handle_done_callback is
			-- Handle the done callback. 
		local
			str: STRING
		do
			if done_command /= Void then
				done_command.command.execute (done_command.argument)
			end
		end;

feature {NONE} -- Implementation

	create_callback_struct (a_widget: MEL_OBJECT; 
				a_callback_struct_ptr: POINTER;
				resource_name: POINTER): MEL_CALLBACK_STRUCT is
			-- Create a callback structure according to `a_callback_struct_ptr'.
		require
			valid_a_widget: a_widget /= Void
			a_callback_struct_ptr: a_callback_struct_ptr /= default_pointer
				implies resource_name /= XmNdestroyCallback;
		local
			reason: INTEGER
		do
			if a_callback_struct_ptr = default_pointer then
				!! Result.make_no_event (a_widget)
			else
				reason := c_reason (a_callback_struct_ptr);
				if reason = XmCR_NONE then
					!! Result.make_no_event (a_widget)
				elseif reason = XmCR_HELP then
					!MEL_ANY_CALLBACK_STRUCT! Result.make
							(a_widget, a_callback_struct_ptr)
				else
					Result := a_widget.create_callback_struct 
						(a_callback_struct_ptr, resource_name)
				end
			end
		end;

feature {NONE} -- External features

	set_procedures (e_handle_callback, 
					e_handle_event,
					e_handle_translation,
					e_handle_wm_protocol,
					e_handle_input,
					e_handle_timer,
					e_handler_work_proc,
					e_handler_lose_callback,
					e_handler_done_callback,
					e_handler_requestor_callback: POINTER) is
		external
			"C"
		end;

	set_dispatcher_object (dispatcher: POINTER) is
		external
			"C"
		end;

	eif_adopt (object: ANY): POINTER is
			-- Eiffel macro to adopt an object
		external
			"C [macro %"eif_macros.h%"] (EIF_OBJ): EIF_POINTER"
		alias
			"eif_adopt"
		end;

	c_reason (a_callback_struct_ptr: POINTER): INTEGER is
		external
			"C [macro %"callback_struct.h%"] (XmAnyCallbackStruct *): EIF_INTEGER"
		end;

	c_add_input (app_context: POINTER; file: INTEGER; mask: POINTER): POINTER is
		external
			"C"
		end;

	c_add_timer (app_context: POINTER; time: INTEGER): POINTER is
		external
			"C"
		end;

	c_add_work_proc (app_context: POINTER): POINTER is
		external
			"C"
		end;

	xt_remove_input (id: POINTER) is
		external
			"C (XtInputId) | <X11/Intrinsic.h>"
		alias
			"XtRemoveInput"
		end;

	xt_remove_time_out (id: POINTER) is
		external
			"C (XtIntervalId) | <X11/Intrinsic.h>"
		alias
			"XtRemoveTimeOut"
		end;

	xt_remove_work_proc (id: POINTER) is
		external
			"C"
		end;

	c_event (a_callback_struct_ptr: POINTER): POINTER is
		external
			"C [macro %"callback_struct.h%"] (XmAnyCallbackStruct *): EIF_POINTER"
		end;

	xt_own_selection (w, target: POINTER; time: INTEGER; a_string: POINTER) is
		external
			"C"
		end

	xt_get_selection_value (w, target: POINTER; time: INTEGER) is
		external
			"C"
		end

end -- class MEL_DISPATCHER


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

