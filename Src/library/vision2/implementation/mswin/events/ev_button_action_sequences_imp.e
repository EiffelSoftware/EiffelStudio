indexing
	description:
		"Action sequences for EV_BUTTON_IMP."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_BUTTON_ACTION_SEQUENCES_IMP

inherit
	EV_BUTTON_ACTION_SEQUENCES_I

feature -- Event handling

	create_select_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a select action sequence.
		do
			create Result
		end

end
