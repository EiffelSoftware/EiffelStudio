indexing
	description:
		"Action sequences for EV_MULTI_COLUMN_LIST_ROW."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_MULTI_COLUMN_LIST_ROW_ACTION_SEQUENCES

inherit
	ANY
		undefine
			default_create
		end

feature {NONE} -- Implementation

	implementation: EV_MULTI_COLUMN_LIST_ROW_ACTION_SEQUENCES_I

feature -- Event handling


	select_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when selected.
		do
			Result := implementation.select_actions
		ensure
			not_void: Result /= Void
		end


	deselect_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when deselected.
		do
			Result := implementation.deselect_actions
		ensure
			not_void: Result /= Void
		end

end
