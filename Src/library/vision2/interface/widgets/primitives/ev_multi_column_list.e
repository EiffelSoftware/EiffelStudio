--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: 
		"EiffelVision multi-column-list. Contains a list of items%
		% from which the user can select."
	note: "The list start at the index 1, the titles are not count among%
		%the rows. The columns start also at the index 1."	
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MULTI_COLUMN_LIST

inherit
	EV_PRIMITIVE
		redefine
			implementation,
			create_action_sequences
		end

	EV_ITEM_LIST [EV_MULTI_COLUMN_LIST_ROW]
		undefine
			create_action_sequences
		redefine
			implementation
		end

create
	default_create,
	make_with_columns,
	make_for_test

feature {NONE} -- Initialization

	make_with_columns (i: INTEGER) is
			-- Create list and assign `i' to `columns'.
		do
			default_create
			set_columns (i)
		end

feature -- Access

	rows: INTEGER is
			-- Number of rows
		obsolete
			"Use count instead."
		do
			Result := implementation.count
		end

	columns: INTEGER is
			-- Number of columns in the list.
		require
		do
			Result := implementation.columns
		end

	selected_item: EV_MULTI_COLUMN_LIST_ROW is
			-- Currently selected item in a single
			-- selection mode.
		require
			single_selection: not multiple_selection_enabled
		do
			Result := implementation.selected_item
		end

	selected_items: LINKED_LIST [EV_MULTI_COLUMN_LIST_ROW] is
			-- List of all the selected items. For a single
			-- selection list, it gives a list with only one
			-- element which is `selected_item'. Therefore, one
			-- should use `selected_item' rather than 
			-- `selected_items' for a single selection list
		require
		do
			Result := implementation.selected_items
		end

feature -- Status report

	selected: BOOLEAN is
			-- Is at least one item selected ?
		require
		do
			Result := implementation.selected
		end

	multiple_selection_enabled: BOOLEAN is
			-- True if the user can choose several items
			-- False otherwise
		require
		do
			Result := implementation.multiple_selection_enabled
		end
	
	title_shown: BOOLEAN is
			-- True if the title row is shown.
			-- False if the title row is not shown.
		require
		do
			Result := implementation.title_shown
		end

	column_title (a_column: INTEGER): STRING is
			-- Title of column `a_column'.
		require
			column_exists: a_column >= 1 and a_column <= columns
		do
			Result := implementation.column_title (a_column)
		end
	
	column_width (a_column: INTEGER): INTEGER is
			-- Width of column `a_column' in pixels.
		require
			column_exists: a_column >= 1 and a_column <= columns
		do
			Result := implementation.column_width (a_column)
		end

feature -- Status setting
	
	set_columns (i: INTEGER) is
			-- Assign `i' to `columns'.
		require
			empty: empty
		do
			implementation.set_columns (i)
		ensure
			columns_assigned: columns = i					
		end

	select_item (index_to_select: INTEGER) is
			-- Select an item at the one-based `index' the list.
		require
			index_large_enough: index_to_select > 0
			index_small_enough: index_to_select <= count
		do
			implementation.select_item (index_to_select)
		end

	deselect_item (index_to_deselect: INTEGER) is
			-- Unselect the item at the one-based `index'.
		require
			index_large_enough: index_to_deselect > 0
			index_small_enough: index_to_deselect <= count
		do
			implementation.deselect_item (index_to_deselect)
		end

	clear_selection is
			-- Clear the selection of the list.
		require
		do
			implementation.clear_selection
		end

	enable_multiple_selection is
			-- Allow more than one item to be selected.
		do
			implementation.enable_multiple_selection	
		end

	disable_multiple_selection is
			-- Allow only one item to be selected.

		do
			implementation.disable_multiple_selection
		end

	show_title_row is
			-- Show the row of the titles.
		require
		do
			implementation.show_title_row
		end

	hide_title_row is
			-- Hide the row of the titles.
		require
		do
			implementation.hide_title_row
		end

	align_text_left (column: INTEGER) is
			-- Align the text of the column at left.
			-- Cannot be used for the first column which is 
			-- always left aligned.
		require
			column_exists: column > 1 and column <= columns
		do
			implementation.set_column_alignment (0, column)
		end

	align_text_center (column: INTEGER) is
			-- Align the text of the column at left.
			-- Cannot be used for the first column which is 
			-- always left aligned.
		require
			column_exists: column > 1 and column <= columns
		do
			implementation.set_column_alignment (2, column)
		end
	
	align_text_right (column: INTEGER) is
			-- Align the text of the column at left.
			-- Cannot be used for the first column which is 
			-- always left aligned.
		require
			column_exists: column > 1 and column <= columns
		do
			implementation.set_column_alignment (1, column)
		end

feature -- Element change

	set_column_title (txt: STRING; column: INTEGER) is
			-- Make `txt' the title of the one-based `column'.
		require
			column_exists: column >= 1 and column <= columns
		do
			implementation.set_column_title (txt, column)
		end

	set_columns_title (txt: ARRAY [STRING]) is         
			-- Make `txt' the new titles of the columns.
		require
			text_not_void: txt /= Void
			valid_text_length: txt.count <= columns
		do
			implementation.set_columns_title (txt)
		end

	set_column_width (a_width: INTEGER; column: INTEGER) is
			-- Make `a_width' the new width of the one-based column.
		require
			valid_width: a_width >= 1
			column_exists: column >= 1 and column <= columns
		do
			implementation.set_column_width (a_width, column)
		end

	set_columns_width (value: ARRAY [INTEGER]) is         
			-- Make `value' the new values of the columns width.
		require
			value_not_void: value /= Void
			valid_value_length: value.count <= columns
		do
			implementation.set_columns_width (value)
		end

	set_rows_height (value: INTEGER) is
			-- Make `value' the new height of all the rows.
		require
			height_valid: value > 0
		do
			implementation.set_rows_height (value)
		end

feature -- Event handling

	select_actions: EV_ITEM_SELECT_ACTION_SEQUENCE
		-- Actions performed when a row is selected.

	deselect_actions: EV_ITEM_SELECT_ACTION_SEQUENCE
		-- Actions performed when a row is deselected.

	column_click_actions: EV_NOTIFY_ACTION_SEQUENCE
		-- Actions performed when a column is clicked.

feature {NONE} -- Inapplicable

	make (par: EV_CONTAINER) is
			-- Do nothing, but need to be implemented.
		do
			check
				inapplicable: False
			end
		end

feature {NONE} -- Implementation

	create_implementation is
		do
			create {EV_MULTI_COLUMN_LIST_IMP} implementation.make (Current)
		end

	create_action_sequences is
		do
			{EV_PRIMITIVE} Precursor
			create select_actions
			create deselect_actions
			create column_click_actions
		end

feature {EV_ANY_I} -- Implementation
	
	implementation: EV_MULTI_COLUMN_LIST_I
			-- Platform specific access.

end -- class EV_MULTI_COLUMN_LIST

--!-----------------------------------------------------------------------------
--! EiffelVision Library: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!---------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.38  2000/03/06 18:05:14  rogers
--| Changed types, select actions and deselect actions from EV_NOTIFY_ACTION_SEQUENCE -> EV_ITEM_SELECT_ACTION_SEQUENCE.
--|
--| Revision 1.37  2000/03/03 21:26:24  king
--| Added valid_width precond to set_column_width
--|
--| Revision 1.36  2000/03/03 18:22:59  king
--| Renamed get_column_width -> column_width, added column_title
--|
--| Revision 1.35  2000/03/03 17:05:29  rogers
--| Added set_columns and make_with_columns.
--|
--| Revision 1.34  2000/03/02 22:07:03  king
--| Made cvs log to be 80 cols or less
--|
--| Revision 1.33  2000/03/02 18:45:54  rogers
--| Minor comment change. Previous revision comment should have read :
--| renamed set_multiple_selection -> enable_multiple_selection,
--| set_single_selection -> disable_multiple_selection,
--| set_left_alignment -> align_text_left,
--| set_right_alignment to align_text_right,
--| set_cent_alignment -> align_text_right.
--|
--| Revision 1.31  2000/03/01 19:48:53  king
--| Corrected export clauses for implementation and create_imp/act_seq
--|
--| Revision 1.30  2000/03/01 03:28:43  oconnor
--| added make_for_test
--|
--| Revision 1.29  2000/02/22 18:39:51  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.28  2000/02/19 01:21:00  king
--| Reinstated column_click_actions
--|
--| Revision 1.27  2000/02/18 23:54:11  oconnor
--| released
--|
--| Revision 1.26  2000/02/18 18:45:33  king
--| Added select, deselect and column_click actions sequences
--|
--| Revision 1.25  2000/02/17 21:54:19  king
--| Added row height precond to be > 0
--|
--| Revision 1.24  2000/02/14 11:40:52  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.23.6.7  2000/02/03 17:15:36  brendel
--| Removed old event features.
--| Corrected error in create_implementation.
--|
--| Revision 1.23.6.6  2000/02/02 23:53:34  king
--| Removed redundant initialization routines
--|
--| Revision 1.23.6.5  2000/01/29 01:05:04  brendel
--| Tweaked inheritance clause.
--|
--| Revision 1.23.6.4  2000/01/27 19:30:55  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.23.6.3  1999/12/17 19:36:51  rogers
--| redefined implementation to be a a more refined type. Changed index
--| wherever it appeared as a parameter.
--|
--| Revision 1.23.6.2  1999/12/01 19:10:02  rogers
--| Changed inheritance structure from EV_ITEM_HOLDER to EV_ITEM_LIST
--|
--| Revision 1.23.6.1  1999/11/24 17:30:54  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.23.2.3  1999/11/04 23:10:55  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.23.2.2  1999/11/02 17:20:13  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
