indexing
	description:
		"Action sequences for EV_MULTI_COLUMN_LIST_IMP."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_MULTI_COLUMN_LIST_ACTION_SEQUENCES_IMP

inherit
	EV_MULTI_COLUMN_LIST_ACTION_SEQUENCES_I


feature -- Event handling

	create_select_actions: EV_MULTI_COLUMN_LIST_ROW_SELECT_ACTION_SEQUENCE is
			-- Create a select action sequence.
		do
			create Result
		end

	create_deselect_actions: EV_MULTI_COLUMN_LIST_ROW_SELECT_ACTION_SEQUENCE is
			-- Create a deselect action sequence.
		do
			create Result
		end

	create_column_title_click_actions: EV_COLUMN_ACTION_SEQUENCE is
			-- Create a column_title_click action sequence.
		do
			create Result
		end

	create_column_resize_actions: EV_COLUMN_ACTION_SEQUENCE is
			-- Create a column_resize action sequence.
		do
			create Result
		end

end
