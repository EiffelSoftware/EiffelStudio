note
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
		export
			{EV_INTERMEDIARY_ROUTINES}
				focus_in_actions_internal,
				focus_out_actions_internal,
				pointer_motion_actions_internal,
				pointer_button_release_actions,
				pointer_leave_actions,
				pointer_leave_actions_internal,
				pointer_enter_actions_internal
		end

feature -- Event handling

	create_pointer_motion_actions: EV_POINTER_MOTION_ACTION_SEQUENCE
			-- Create a pointer_motion action sequence.
			-- Attach to GTK "motion-notify-event" signal.
		do
			create Result
		end

	create_pointer_button_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE
			-- Create a pointer_button_press action sequence.
		do
			create Result
		end

	create_pointer_double_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE
			-- Create a pointer_double_press action sequence.
		do
			create Result
		end

	create_pointer_button_release_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE
			-- Create a pointer_button_release action sequence.
		do
			create Result
		end

	create_pointer_enter_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Create a pointer_enter action sequence.
		do
			create Result
		end

	create_pointer_leave_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Create a pointer_leave action sequence.
		do
			create Result
		end

	create_key_press_actions: EV_KEY_ACTION_SEQUENCE
			-- Create a key_press action sequence.
		do
			create Result
		end

	create_key_press_string_actions: EV_KEY_STRING_ACTION_SEQUENCE
			-- Create a key_press_string action sequence.
		do
			create Result
		end

	create_key_release_actions: EV_KEY_ACTION_SEQUENCE
			-- Create a key_release action sequence.
		do
			create Result
		end

	create_focus_in_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Create a focus_in action sequence.
			-- Attach to GTK "focus-in-event" signal.
		do
			create Result
		end

	create_focus_out_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Create a focus_out action sequence.
			-- Attach to GTK "focus-out-event" signal.
		do
			create Result
		end

	create_resize_actions: EV_GEOMETRY_ACTION_SEQUENCE
			-- Create a resize action sequence.
		local
			l_app_imp: like app_implementation
		do
			create Result
			if not {EV_GTK_EXTERNALS}.gtk_is_window (c_object) then
					-- Window resize events are connected separately
				l_app_imp := app_implementation
				l_app_imp.gtk_marshal.signal_connect (c_object, l_app_imp.size_allocate_event_string, agent (l_app_imp.gtk_marshal).on_size_allocate_intermediate (internal_id, ?, ?, ?, ?), l_app_imp.gtk_marshal.size_allocate_translate_agent, False)
			end
		end

	create_mouse_wheel_actions: EV_INTEGER_ACTION_SEQUENCE
			-- Create a mouse_wheel action sequence.
		do
			create Result
		end

	create_file_drop_actions: EV_LITE_ACTION_SEQUENCE [TUPLE [LIST [STRING_32]]]
			-- Create a file_drop action sequence.
		do
			create Result
		end

feature {EV_ANY_I} -- Implementation

	internal_id: INTEGER
		deferred
		end

	app_implementation: EV_APPLICATION_IMP
		deferred
		end

	visual_widget: POINTER
		deferred
		end

	c_object: POINTER
		deferred
		end

	event_widget: POINTER
			-- Pointer to the gtk event widget
		deferred
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end











