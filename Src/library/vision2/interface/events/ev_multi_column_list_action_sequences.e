indexing
	description:
		"Action sequences for EV_MULTI_COLUMN_LIST."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_MULTI_COLUMN_LIST_ACTION_SEQUENCES

inherit
	ANY
		undefine
			default_create, copy
		end

feature {NONE} -- Implementation

	implementation: EV_MULTI_COLUMN_LIST_ACTION_SEQUENCES_I

feature -- Event handling


	select_actions: EV_MULTI_COLUMN_LIST_ROW_SELECT_ACTION_SEQUENCE is
			-- Actions to be performed 
		do
			Result := implementation.select_actions
		ensure
			not_void: Result /= Void
		end


	deselect_actions: EV_MULTI_COLUMN_LIST_ROW_SELECT_ACTION_SEQUENCE is
			-- Actions to be performed 
		do
			Result := implementation.deselect_actions
		ensure
			not_void: Result /= Void
		end


	column_title_click_actions: EV_COLUMN_ACTION_SEQUENCE is
			-- Actions to be performed 
		do
			Result := implementation.column_title_click_actions
		ensure
			not_void: Result /= Void
		end


	column_resize_actions: EV_COLUMN_ACTION_SEQUENCE is
			-- Actions to be performed 
		do
			Result := implementation.column_resize_actions
		ensure
			not_void: Result /= Void
		end

end
