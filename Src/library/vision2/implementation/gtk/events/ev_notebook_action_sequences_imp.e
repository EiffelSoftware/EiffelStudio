indexing
	description:
		"Action sequences for EV_NOTEBOOK_IMP."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_NOTEBOOK_ACTION_SEQUENCES_IMP

inherit
	EV_NOTEBOOK_ACTION_SEQUENCES_I


feature -- Event handling

	create_selection_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a selection action sequence.
		do
			create Result
		end

end
