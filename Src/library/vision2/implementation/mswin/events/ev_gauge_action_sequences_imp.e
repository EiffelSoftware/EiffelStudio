indexing
	description:
		"Action sequences for EV_GAUGE_IMP."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_GAUGE_ACTION_SEQUENCES_IMP

inherit
	EV_GAUGE_ACTION_SEQUENCES_I

feature -- Event handling

	create_change_actions: EV_VALUE_CHANGE_ACTION_SEQUENCE is
			-- Create a change action sequence.
		do
			create Result
		end

end
