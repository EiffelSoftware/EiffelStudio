indexing
	description:
		"Action sequences for EV_TEXT_COMPONENT_IMP."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_TEXT_COMPONENT_ACTION_SEQUENCES_IMP

inherit
	EV_TEXT_COMPONENT_ACTION_SEQUENCES_I

feature -- Event handling

	create_change_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a change action sequence.
		do
			create Result
		end

end
