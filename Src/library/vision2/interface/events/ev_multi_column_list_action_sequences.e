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
		export
			{EV_ANY_HANDLER} default_create
		undefine
			default_create, copy
		end

feature {NONE} -- Implementation

	implementation: EV_MULTI_COLUMN_LIST_ACTION_SEQUENCES_I

feature -- Event handling


	select_actions: EV_MULTI_COLUMN_LIST_ROW_SELECT_ACTION_SEQUENCE is
			-- Actions to be performed when a row is selected.
		do
			Result := implementation.select_actions
		ensure
			not_void: Result /= Void
		end


	deselect_actions: EV_MULTI_COLUMN_LIST_ROW_SELECT_ACTION_SEQUENCE is
			-- Actions to be performed when a row is deselected.
		do
			Result := implementation.deselect_actions
		ensure
			not_void: Result /= Void
		end


	column_title_click_actions: EV_COLUMN_ACTION_SEQUENCE is
			-- Actions to be performed when a column title is clicked.
		do
			Result := implementation.column_title_click_actions
		ensure
			not_void: Result /= Void
		end


	column_resized_actions: EV_COLUMN_ACTION_SEQUENCE is
			-- Actions to be performed when a column has been resized.
		do
			Result := implementation.column_resized_actions
		ensure
			not_void: Result /= Void
		end
		
	column_resize_actions: EV_COLUMN_ACTION_SEQUENCE is
			-- Actions to be performed when a column is resized.
		obsolete "Use `column_resized_actions' instead."
		do
			Result := implementation.column_resized_actions
		ensure
			not_void: Result /= Void
		end

end

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

