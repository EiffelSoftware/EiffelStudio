indexing
	description:
		"Action sequences for EV_MULTI_COLUMN_LIST_IMP."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	create_column_resized_actions: EV_COLUMN_ACTION_SEQUENCE is
			-- Create a column_resize action sequence.
		do
			create Result
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

