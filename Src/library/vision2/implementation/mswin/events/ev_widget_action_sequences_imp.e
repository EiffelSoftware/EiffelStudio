indexing
	description:
		"Action sequences for EV_WIDGET_IMP."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_WIDGET_ACTION_SEQUENCES_IMP

inherit
	EV_WIDGET_ACTION_SEQUENCES_I

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

	create_focus_in_actions: EV_FOCUS_ACTION_SEQUENCE is
			-- Create a focus_in action sequence.
		do
			create Result
		end

	create_focus_out_actions: EV_FOCUS_ACTION_SEQUENCE is
			-- Create a focus_out action sequence.
		do
			create Result
		end

	create_resize_actions: EV_GEOMETRY_ACTION_SEQUENCE is
			-- Create a resize action sequence.
		do
			create Result
		end

end
