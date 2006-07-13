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

EV_ANY_IMP undefine dispose, destroy end

feature -- Event handling

	create_pointer_motion_actions: EV_POINTER_MOTION_ACTION_SEQUENCE is
			-- Create a pointer_motion action sequence.
			-- Attach to GTK "motion-notify-event" signal.
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
			-- Attach to GTK "button-release-event" signal.
		do
			create Result
		end

	create_pointer_enter_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a pointer_enter action sequence.
			-- Attach to GTK "enter-notify-event" signal.
		local
			app_imp: EV_APPLICATION_IMP
		do
			app_imp := app_implementation
			create Result
			signal_connect (
				event_widget,
				App_imp.enter_notify_event_string,
				agent (App_imp.gtk_marshal).pointer_enter_leave_action_intermediary (c_object, True),
				App_imp.default_translate,
				False
			)
		end

	create_pointer_leave_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a pointer_leave action sequence.
			-- Attach to GTK "leave-notify-event" signal.
		local
			app_imp: EV_APPLICATION_IMP
		do
			app_imp := app_implementation
			create Result
			signal_connect (
				event_widget,
				App_imp.leave_notify_event_string,
				agent (App_imp.gtk_marshal).pointer_enter_leave_action_intermediary (c_object, False),
				App_imp.default_translate,
				False
			)
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
			-- Attach to GTK "focus-in-event" signal.
		do
			create Result
		end

	create_focus_out_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a focus_out action sequence.
			-- Attach to GTK "focus-out-event" signal.
		do
			create Result
		end

	create_resize_actions: EV_GEOMETRY_ACTION_SEQUENCE is
			-- Create a resize action sequence.
		do
			create Result
			if not {EV_GTK_EXTERNALS}.gtk_is_window (c_object) then
					-- Window resize events are connected separately
				signal_connect (c_object, App_implementation.size_allocate_event_string, agent (App_implementation.gtk_marshal).on_size_allocate_intermediate (internal_id, ?, ?, ?, ?), size_allocate_translate_agent, False)
			end
		end

	create_mouse_wheel_actions: EV_INTEGER_ACTION_SEQUENCE is
			-- Create a mouse_wheel action sequence.
		do
			create Result
			signal_connect (event_widget, once "scroll-event", agent (App_implementation.gtk_marshal).button_press_switch_intermediary (c_object, ?, ?, ?, ?, ?, ?, ?, ?, ?), agent (App_implementation.gtk_marshal).scroll_wheel_translate, False)
		end

feature {EV_ANY_I} -- Implementation

	configure_translate_agent: FUNCTION [EV_GTK_CALLBACK_MARSHAL, TUPLE [INTEGER, POINTER], TUPLE] is
			-- Translation agent used for size allocation events
		once
			Result := agent (App_implementation.gtk_marshal).configure_translate
		end

	size_allocate_translate_agent: FUNCTION [EV_GTK_CALLBACK_MARSHAL, TUPLE [INTEGER, POINTER], TUPLE] is
			-- Translation agent used for size allocation events
		once
			Result := agent (App_implementation.gtk_marshal).size_allocate_translate
		end

	event_widget: POINTER is
			-- Pointer to the gtk event widget
		deferred
		end


indexing
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

