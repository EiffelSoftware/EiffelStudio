indexing
	description:
		"Action sequences for EV_TEXT_FIELD_IMP."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_TEXT_FIELD_ACTION_SEQUENCES_IMP

inherit
	EV_TEXT_FIELD_ACTION_SEQUENCES_I


feature -- Event handling

	create_return_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a return action sequence.
		do
			create Result
		end

end
