indexing
	description:
		"Action sequences for EV_ITEM_IMP."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_ITEM_ACTION_SEQUENCES_IMP

inherit
	EV_ITEM_ACTION_SEQUENCES_I

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

end
