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
			!! xm_callbacks.make (20);
			!! xt_event_callbacks.make (20);
			!! translation_callbacks.make (20);
			!! wm_protocol_callbacks.make (2);
			!! xt_input_callbacks.make (1);
			!! xt_timer_callbacks.make (1)
			!! xt_work_proc_callbacks.make (1)
			set_procedures ($handle_callback, $handle_event, 
					$handle_translation, $handle_wm_protocol,
					$handle_input, $handle_timer,
					$handle_work_proc);
			set_dispatcher_object (eif_adopt (Current))
		end

feature {MEL_OBJECT} -- Implementation

	add_callback (a_screen_object,
				a_resource: POINTER;
				a_callback_exec: MEL_CALLBACK_EXEC) is
			-- Add Xm motif callback list for `a_screen_object' with `a_resource'
		require
			valid_a_screen_object: Mel_widgets.has (a_screen_object);
			a_resource_not_null: a_resource /= default_pointer;
			valid_exec: a_callback_exec /= Void
		do	
			xm_callbacks.add_callback (a_screen_object, a_resource, a_callback_exec)
			if xm_callbacks.need_to_call_c then
				c_add_callback (a_screen_object, a_resource)
			end
		ensure
			added: xm_callbacks.has_callback (a_screen_object, a_resource)
		end;

	add_wm_protocol (a_screen_object: POINTER;
				atom: MEL_ATOM;
				a_callback_exec: MEL_CALLBACK_EXEC) is
			-- Add wm protocol callback list for `a_screen_object' with `atom'
		require
			valid_a_screen_object: Mel_widgets.has (a_screen_object);
			valid_atom: atom /= Void;
			valid_exec: a_callback_exec /= Void
		do	
			wm_protocol_callbacks.add_callback (a_screen_object, atom.identifier, a_callback_exec)
			if wm_protocol_callbacks.need_to_call_c then
				c_add_wm_protocol (a_screen_object, atom.identifier)
			end
		ensure
			added: wm_protocol_callbacks.has_callback (a_screen_object, atom.identifier)
		end;

	add_event_handler (a_screen_object: POINTER;
				a_mask: INTEGER;
				a_callback_exec: MEL_CALLBACK_EXEC) is
			-- Add event callback list for `a_screen_object' with `a_mask'
		require
			valid_a_screen_object: Mel_widgets.has (a_screen_object);
			a_mask_not_null: a_mask /= 0;
			valid_exec: a_callback_exec /= Void
		do	
			xt_event_callbacks.add_callback (a_screen_object, 
						a_mask, a_callback_exec)
			if xt_event_callbacks.need_to_call_c then
				c_add_event_handler (a_screen_object, a_mask)
			end
		ensure
			added: xt_event_callbacks.has_callback (a_screen_object, a_mask)
		end;

	set_translation (a_screen_object: POINTER;
				a_translation: STRING;
				a_callback_exec: MEL_CALLBACK_EXEC) is
			-- Add a translation callback for `a_screen_object' with `a_translation'
		require
			valid_a_screen_object: Mel_widgets.has (a_screen_object);
			a_translation_not_void: a_translation /= Void;
			valid_exec: a_callback_exec /= Void
		local
			mt: MEL_TRANSLATION;
			widget_callbacks: HASH_TABLE [MEL_CALLBACK_EXEC, MEL_TRANSLATION];
			ext: ANY;
			call_c: BOOLEAN
		do	
			widget_callbacks := translation_callbacks.item (a_screen_object);
			!! mt.make (a_translation);
			if widget_callbacks = Void then
				!! widget_callbacks.make (2);
				translation_callbacks.put (widget_callbacks, a_screen_object);
				widget_callbacks.put (a_callback_exec, mt);
				call_c := True
			else
				if widget_callbacks.has (mt) then
					widget_callbacks.force (a_callback_exec, mt)
					-- Note: `mt' will not be forced into the table - only
					-- `a_callback_exec' which means `mt' needs to be weaned
				else
					widget_callbacks.put (a_callback_exec, mt);
					call_c := True
				end
			end;
			if call_c then
				ext := mt.xt_translation_string.to_c;
				c_set_override_translations (a_screen_object, $ext)
			else
				mt.dispose -- wean the translation right away
			end
		ensure
			added: translation_callbacks.item (a_screen_object).has ( 
							mel_translation_from (a_translation))
		end;

	remove_callback (a_screen_object,
				a_resource: POINTER;
				a_callback_exec: MEL_CALLBACK_EXEC) is
			-- Add Xm motif callback list for `a_screen_object' with `a_resource'
		require
			valid_a_screen_object: Mel_widgets.has (a_screen_object);
			a_resource_not_null: a_resource /= default_pointer;
			valid_exec: a_callback_exec /= Void
		do	
			xm_callbacks.remove_callback (a_screen_object, a_resource, a_callback_exec)
			if xm_callbacks.need_to_call_c then
				c_remove_callback (a_screen_object, a_resource)
			end
		end;

	remove_wm_protocol (a_screen_object: POINTER;
				atom: MEL_ATOM;
				a_callback_exec: MEL_CALLBACK_EXEC) is
			-- Add WM motif protocol callback list for `a_screen_object' with `atom'
		require
			valid_a_screen_object: Mel_widgets.has (a_screen_object);
			valid_atom: atom /= Void;
			valid_exec: a_callback_exec /= Void
		do	
			wm_protocol_callbacks.remove_callback (a_screen_object, atom.identifier, a_callback_exec)
			if wm_protocol_callbacks.need_to_call_c then
				c_remove_wm_protocol (a_screen_object, atom.identifier)
			end
		end;

	remove_event_handler (a_screen_object: POINTER;
				a_mask: INTEGER;
				a_callback_exec: MEL_CALLBACK_EXEC) is
			-- Add Xm motif callback list for `a_screen_object' with `a_resource'
		require
			valid_a_screen_object: Mel_widgets.has (a_screen_object);
			a_mask_not_zero: a_mask /= 0;
			valid_exec: a_callback_exec /= Void
		do	
			xt_event_callbacks.remove_callback (a_screen_object, 
						a_mask, a_callback_exec)
			if xt_event_callbacks.need_to_call_c then
				c_remove_event_handler (a_screen_object, a_mask)
			end
		end;

	remove_translation (a_screen_object: POINTER;
				a_translation: STRING) is
			-- Add a translation callback for `a_screen_object' with `a_translation'
		require
			valid_a_screen_object: Mel_widgets.has (a_screen_object);
			a_translation_not_void: a_translation /= Void
		local
			mt: MEL_TRANSLATION;
			ext: ANY
			widget_callbacks: HASH_TABLE [MEL_CALLBACK_EXEC, MEL_TRANSLATION];
			call_c: BOOLEAN
		do	
			!! mt.make_no_adopted (a_translation);
			widget_callbacks := translation_callbacks.item (a_screen_object)
			if widget_callbacks /= Void then
				if widget_callbacks.has (mt) then
					widget_callbacks.remove (mt);
					ext := mt.xt_translation_null_string.to_c;
					c_set_override_translations (a_screen_object, $ext)
				end
			end
		ensure
			removed: not translation_callbacks.item (a_screen_object).has ( 
							mel_translation_from (a_translation))
		end;

	mel_translation_from (a_string: STRING): MEL_TRANSLATION is
			-- Mel translation object from `a_string'
		require
			non_void_a_string: a_string /= Void
		do
			!! Result.make_no_adopted (a_string)
		end;

	has_callback (a_screen_object: POINTER; 
				a_resource: POINTER): BOOLEAN is
			-- Does `a_screen_object' have xm callback `a_resource'?
		require
			valid_a_screen_object: Mel_widgets.has (a_screen_object);
			a_resource_not_null: a_resource /= default_pointer;
		do
			Result := xm_callbacks.has_callback (a_screen_object, a_resource)
		end;

	clean_up_object (w: MEL_OBJECT) is
			-- Remove mel object `w' from the appropriate
			-- callback structures.
		require
			non_void_w: w /= Void;
			screen_object_not_reset: w.screen_object /= default_pointer
		local
			so: POINTER
		do
			so := w.screen_object;
			xm_callbacks.remove (so);
			translation_callbacks.remove (so);
			xt_event_callbacks.remove (so)
		ensure
			no_trace_of_widget: cleaned_up (w)
		end;

	clean_up_gadget (g: MEL_GADGET) is
			-- Remove mel gadget `g' from the appropriate
			-- callback structures.
		require
			non_void_g: g /= Void;
			screen_object_not_reset: g.screen_object /= default_pointer
		local
			so: POINTER
		do
			so := g.screen_object;
			xm_callbacks.remove (so)
		ensure
			no_trace_of_widget: cleaned_up (g)
		end;

	clean_up_shell (s: MEL_SHELL) is
			-- Remove mel shell `s' from the appropriate
			-- callback structures.
		require
			non_void_s: s /= Void;
			screen_object_not_reset: s.screen_object /= default_pointer
		local
			so: POINTER
		do
			so := s.screen_object;
			xm_callbacks.remove (so);
			xt_event_callbacks.remove (so);
			translation_callbacks.remove (so);
			wm_protocol_callbacks.remove (so)
		ensure
			no_trace_of_widget: cleaned_up (s)
		end;

	cleaned_up (w: MEL_OBJECT): BOOLEAN is
			-- Has widget `w' been removed from all
			-- callback structures?
		do
			Result := not (xm_callbacks.has (w.screen_object) or else
					xt_event_callbacks.has (w.screen_object) or else
					wm_protocol_callbacks.has (w.screen_object) or else
					translation_callbacks.has (w.screen_object)) 
		end

feature {MEL_APPLICATION_CONTEXT}

	add_input_callback (app_context: MEL_APPLICATION_CONTEXT;
				file: IO_MEDIUM;	
				a_mask: POINTER;
				a_callback_exec: MEL_CALLBACK_EXEC) is
			-- Add input callback for `a_screen_object' with `mask'
		require
			valid_app_cont: app_context /= Void and app_context.is_valid;
			non_void_file: file /= Void;
			a_mask_not_null: a_mask /= default_pointer;
			valid_exec: a_callback_exec /= Void
		local
			id: POINTER
		do	
			id := c_add_input (app_context.handle, file.handle, a_mask);
			!! last_id.make_input (id);
			xt_input_callbacks.put (a_callback_exec, id)
		end;

	add_timer_callback (app_context: MEL_APPLICATION_CONTEXT;
				time: INTEGER;	
				a_callback_exec: MEL_CALLBACK_EXEC) is
			-- Add timer callback for `app_context' with `time'.
		require
			valid_app_cont: app_context /= Void and app_context.is_valid;
			valid_time: time >= 0;
			valid_exec: a_callback_exec /= Void
		local
			id: POINTER
		do	
			id := c_add_timer (app_context.handle, time);
			!! last_id.make_timer (id);
			xt_timer_callbacks.put (a_callback_exec, id)
		end;

	add_work_proc_callback (app_context: MEL_APPLICATION_CONTEXT;
				a_callback_exec: MEL_CALLBACK_EXEC) is
			-- Add work procedure callback for `app_context'.
		require
			valid_app_cont: app_context /= Void and app_context.is_valid;
			valid_exec: a_callback_exec /= Void
		local
			id: POINTER
		do	
			id := c_add_work_proc (app_context.handle);
			!! last_id.make_work_proc (id);
			xt_work_proc_callbacks.put (a_callback_exec, id)
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

feature {NONE} -- Implementation

	xm_callbacks: MEL_CALLBACK_TABLE [POINTER];
			-- Motif callbacks for all widgets

	wm_protocol_callbacks: MEL_CALLBACK_TABLE [POINTER];
			-- WM Motif protocol callbacks for all widgets

	xt_event_callbacks: MEL_CALLBACK_TABLE [INTEGER];
			-- Xt Event callbacks for all widgets

	xt_input_callbacks: HASH_TABLE [MEL_CALLBACK_EXEC, POINTER];
			-- Xt callbacks for input

	xt_timer_callbacks: HASH_TABLE [MEL_CALLBACK_EXEC, POINTER];
			-- Xt callbacks for timer

	xt_work_proc_callbacks: HASH_TABLE [MEL_CALLBACK_EXEC, POINTER];
			-- Xt callbacks for work procedures

	translation_callbacks: HASH_TABLE [HASH_TABLE [MEL_CALLBACK_EXEC, MEL_TRANSLATION], POINTER];
			-- Translation callbacks for all widgets

feature {MEL_APPLICATION_CONTEXT}

	last_id: MEL_IDENTIFIER;
			-- Last identifer for input, work_proc and timer callback addition

feature {NONE} -- External features passed out to C

	frozen handle_wm_protocol (a_screen_object: POINTER; 
				atom: POINTER; 
				a_callback_struct_ptr: POINTER) is
			-- Handle the Xm event that was specified in `add_callback'.
			-- Call the callbacks of the MEL widget that has `a_screen_object'
			-- and create the MEL_CALLBACK_STRUCT object associated to the event.
		require
			valid_a_screen_object: a_screen_object /= default_pointer;
			a_callback_struct_ptr: a_callback_struct_ptr /= default_pointer;
			widget_exists: Mel_widgets.has (a_screen_object);
			callback_exists: wm_protocol_callbacks.has_callback 
					(a_screen_object, atom)
		local
			a_callback_struct: MEL_CALLBACK_STRUCT;
			a_widget: MEL_OBJECT
		do
			a_widget := Mel_widgets.item (a_screen_object);
			!! a_callback_struct.make (a_widget, c_event (a_callback_struct_ptr)); 
			wm_protocol_callbacks.execute_callback (a_widget, 
							atom, a_callback_struct)
		end;

	frozen handle_callback (a_screen_object: POINTER; 
				resource_name: POINTER; 
				a_callback_struct_ptr: POINTER) is
			-- Handle the Xm event that was specified in `add_callback'.
			-- Call the callbacks of the MEL widget that has `a_screen_object'
			-- and create the MEL_CALLBACK_STRUCT object associated to the event.
		require
			valid_a_screen_object: a_screen_object /= default_pointer;
			callback_exists: xm_callbacks.has_callback 
					(a_screen_object, resource_name)
			widget_exists: Mel_widgets.has (a_screen_object);
		local
			a_callback_struct: MEL_CALLBACK_STRUCT;
			a_widget: MEL_OBJECT
		do
			a_widget := Mel_widgets.item (a_screen_object);
			a_callback_struct := create_callback_struct (a_widget, 
									a_callback_struct_ptr, resource_name);
			xm_callbacks.execute_callback (a_widget, 
							resource_name, a_callback_struct)
		end;

	frozen handle_event (a_screen_object: POINTER; 
				mask: INTEGER; 
				event_ptr: POINTER) is
			-- Handle the Xt event that was specified in `add_event_handler'.
			-- Call the callbacks of the MEL widget that has `a_screen_object'
			-- and create the MEL_CALLBACK_STRUCT object associated to the event.
		require
			valid_a_screen_object: a_screen_object /= default_pointer;
			a_callback_struct_ptr: event_ptr /= default_pointer;
			widget_exists: Mel_widgets.has (a_screen_object);
			callback_exists: xt_event_callbacks.has_callback 
					(a_screen_object, mask)
		local
			a_callback_struct: MEL_CALLBACK_STRUCT;
			a_widget: MEL_OBJECT
		do
			a_widget := Mel_widgets.item (a_screen_object);
			!! a_callback_struct.make (a_widget, event_ptr);
			xt_event_callbacks.execute_callback (a_widget, 
							mask, a_callback_struct)
		end;

	frozen handle_translation (a_screen_object: POINTER; 
				a_translation: STRING; 
				event_ptr: POINTER) is
			-- Handle the Xt event that was specified in `add_event_handler'.
			-- Call the callbacks of the MEL widget that has `a_screen_object'
			-- and create the MEL_CALLBACK_STRUCT object associated to the event.
		require
			valid_a_screen_object: a_screen_object /= default_pointer;
			translation_not_void: a_translation /= Void;
			a_callback_struct_ptr: event_ptr /= default_pointer;
			widget_exists: Mel_widgets.has (a_screen_object);
			widget_in_callback: translation_callbacks.has (a_screen_object);
			has_callback: translation_callbacks.item (a_screen_object).has (
					(mel_translation_from (a_translation)))
		local
			a_callback_struct: MEL_CALLBACK_STRUCT;
			widget_callbacks: HASH_TABLE [MEL_CALLBACK_EXEC, MEL_TRANSLATION];
			a_widget: MEL_OBJECT;
			mt: MEL_TRANSLATION
		do
			a_widget := Mel_widgets.item (a_screen_object);
			!! mt.make_no_adopted (a_translation);
			!! a_callback_struct.make (a_widget, event_ptr);
			widget_callbacks := translation_callbacks.item (a_screen_object);
			widget_callbacks.item (mt).execute (a_callback_struct);
		end;

	frozen handle_input (id: POINTER) is
			-- Handle the input event with `id'.
		require
			non_null_id: id /= default_pointer;
			has_id: xt_input_callbacks.has (id);
		local
			mel_exec: MEL_CALLBACK_EXEC;
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
			mel_exec: MEL_CALLBACK_EXEC;
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
			has_id: xt_work_proc_callbacks.has (id);
		local
			mel_exec: MEL_CALLBACK_EXEC;
			mel_struct: MEL_ID_CALLBACK_STRUCT;
			mel_id: MEL_IDENTIFIER
		do
			!! mel_id.make_work_proc (id);
			!! mel_struct.make (mel_id);
			mel_exec := xt_work_proc_callbacks.item (id);
			mel_exec.execute (mel_struct)
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
					e_handler_work_proc: POINTER) is
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
			"C [macro <eiffel.h>] (EIF_OBJ): EIF_POINTER"
		alias
			"eif_adopt"
		end;

	c_reason (a_callback_struct_ptr: POINTER): INTEGER is
		external
			"C [macro <callback_struct.h>] (XmAnyCallbackStruct *): EIF_INTEGER"
		end;

	c_add_callback (scr_obj: POINTER; resource_name: POINTER) is
		external
			"C"
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

	c_add_wm_protocol (scr_obj: POINTER; atom: POINTER) is
		external
			"C"
		end;

	c_add_event_handler (scr_obj: POINTER; mask: INTEGER) is
		external
			"C"
		end;

	c_set_override_translations (scr_obj: POINTER; a_trans: POINTER) is
		external
			"C"
		end;

	c_remove_callback (scr_obj: POINTER; resource_name: POINTER) is
		external
			"C"
		end;

	c_remove_wm_protocol (scr_obj: POINTER; atom: POINTER) is
		external
			"C"
		end;

	c_remove_event_handler (scr_obj: POINTER; mask: INTEGER) is
		external
			"C"
		end;

	xt_remove_input (id: POINTER) is
		external
			"C [macro <X11/Intrinsic.h>] (XtInputId)"
		alias
			"XtRemoveInput"
		end;

	xt_remove_time_out (id: POINTER) is
		external
			"C [macro <X11/Intrinsic.h>] (XtIntervalId)"
		alias
			"XtRemoveTimeOut"
		end;

	xt_remove_work_proc (id: POINTER) is
		external
			"C"
		end;

    c_event (a_callback_struct_ptr: POINTER): POINTER is
        external
            "C [macro <callback_struct.h>] (XmAnyCallbackStruct *): EIF_POINTER"
        end;

end -- class MEL_DISPATCHER

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
