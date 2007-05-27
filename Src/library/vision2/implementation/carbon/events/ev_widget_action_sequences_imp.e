indexing
	description:
		"Action sequences for EV_WIDGET_IMP."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_WIDGET_ACTION_SEQUENCES_IMP

inherit
	EV_WIDGET_ACTION_SEQUENCES_I

	EV_ANY_IMP
		 undefine
		 	dispose,
		 	destroy
		 end

	EV_CARBON_EVENTABLE
		redefine
			on_event
		end

feature -- Event handling

	create_pointer_motion_actions: EV_POINTER_MOTION_ACTION_SEQUENCE is
			-- Create a pointer_motion action sequence.
		do
			create Result
		end

	create_pointer_button_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE is
			-- Create a pointer_button_press action sequence.
		do
			create Result
		end

	create_pointer_double_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE is
			-- Create a pointer_double_press action sequence.
		do
			create Result
		end

	create_pointer_button_release_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE is
			-- Create a pointer_button_release action sequence.
		do
			create Result
		end

	create_pointer_enter_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a pointer_enter action sequence.
		do
			create Result
		end

	create_pointer_leave_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a pointer_leave action sequence.
		do
			create Result
		end

	create_key_press_actions: EV_KEY_ACTION_SEQUENCE is
			-- Create a key_press action sequence.
		do
			create Result
		end

	create_key_press_string_actions: EV_KEY_STRING_ACTION_SEQUENCE is
			-- Create a key_press_string action sequence.
		do
			create Result
		end

	create_key_release_actions: EV_KEY_ACTION_SEQUENCE is
			-- Create a key_release action sequence.
		do
			create Result
		end

	create_focus_in_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a focus_in action sequence.
		do
			create Result
		end

	create_focus_out_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a focus_out action sequence.
		do
			create Result
		end

	create_resize_actions: EV_GEOMETRY_ACTION_SEQUENCE is
			-- Create a resize action sequence.
		do
			create Result
		end

	create_mouse_wheel_actions: EV_INTEGER_ACTION_SEQUENCE is
			-- Create a mouse_wheel action sequence.
		do
			create Result
		end

	create_file_drop_actions: like file_drop_actions_internal
			-- Create a file_drop action sequence.
		do
			create Result
		end

feature {EV_APPLICATION_IMP} -- Implementation

	on_event (a_inhandlercallref: POINTER; a_inevent: POINTER; a_inuserdata: POINTER): INTEGER is
			-- Feature that is called if an event occurs
		local
			event_class, event_kind : INTEGER
		do
				event_class := get_event_class_external (a_inevent)
				event_kind := get_event_kind_external (a_inevent)

				if event_kind = {CARBONEVENTS_ANON_ENUMS}.kEventMouseDown and event_class = {CARBONEVENTS_ANON_ENUMS}.kEventClassControl then
					pointer_button_press_actions.call ( void )
					Result := noErr -- event handled
				else
					Result := {CARBON_EVENTS_CORE_ANON_ENUMS}.eventnothandlederr
				end
		end



indexing
	copyright:	"Copyright (c) 2007, The Eiffel.Mac Team"
end
