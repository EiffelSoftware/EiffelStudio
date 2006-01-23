indexing
	description:
		"Action sequences for EV_MULTI_COLUMN_LIST."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end

