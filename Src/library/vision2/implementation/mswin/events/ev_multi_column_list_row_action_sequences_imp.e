indexing
	description:
		"Action sequences for EV_MULTI_COLUMN_LIST_ROW_IMP."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_MULTI_COLUMN_LIST_ROW_ACTION_SEQUENCES_IMP

inherit
	EV_MULTI_COLUMN_LIST_ROW_ACTION_SEQUENCES_I

feature -- Event handling

	create_select_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a select action sequence.
		do
			create Result
		end

	create_deselect_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a deselect action sequence.
		do
			create Result
		end

end
