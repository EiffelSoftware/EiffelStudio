indexing
	description:
		"Action sequences for EV_STANDARD_DIALOG_IMP."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_STANDARD_DIALOG_ACTION_SEQUENCES_IMP

inherit
	EV_STANDARD_DIALOG_ACTION_SEQUENCES_I


feature -- Event handling

	create_ok_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a ok action sequence.
		do
			create Result
		end

	create_cancel_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a cancel action sequence.
		do
			create Result
		end

end
