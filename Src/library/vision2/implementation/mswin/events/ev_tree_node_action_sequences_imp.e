indexing
	description:
		"Action sequences for EV_TREE_NODE_IMP."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_TREE_NODE_ACTION_SEQUENCES_IMP

inherit
	EV_TREE_NODE_ACTION_SEQUENCES_I

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

	create_expand_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a expand action sequence.
		do
			create Result
		end

	create_collapse_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a collapse action sequence.
		do
			create Result
		end

end
