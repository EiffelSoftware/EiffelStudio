--| FIXME Not for release
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
			implementation
		end

	EV_ITEM_LIST [EV_MULTI_COLUMN_LIST_ROW]
		undefine
			create_action_sequences
		redefine
			implementation
		end

create
	default_create

feature {NONE} -- Initialization

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
			-- Item which is currently selected in a single
			-- selection mode.
		require
			single_selection: not is_multiple_selection
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

	is_multiple_selection: BOOLEAN is
			-- True if the user can choose several items
			-- False otherwise
		require
		do
			Result := implementation.is_multiple_selection
		end
	
	title_shown: BOOLEAN is
			-- True if the title row is shown.
			-- False if the title row is not shown.
		require
		do
			Result := implementation.title_shown
		end
	
	get_column_width (column: INTEGER): INTEGER is
			-- Width of column `column' in pixel.
		require
			column_exists: column >= 1 and column <= columns
		do
			Result := implementation.get_column_width (column)
		end

feature -- Status setting

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

	set_multiple_selection is
			-- Allow the user to do a multiple selection simply
			-- by clicking on several choices.
		require
		do
			implementation.set_multiple_selection	
		end

	set_single_selection is
			-- Allow the user to do only one selection. It is the
			-- default status of the list
		require
		do
			implementation.set_single_selection
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

	set_left_alignment (column: INTEGER) is
			-- Align the text of the column at left.
			-- Cannot be used for the first column which is 
			-- always left aligned.
		require
			column_exists: column > 1 and column <= columns
		do
			implementation.set_column_alignment (0, column)
		end

	set_center_alignment (column: INTEGER) is
			-- Align the text of the column at left.
			-- Cannot be used for the first column which is 
			-- always left aligned.
		require
			column_exists: column > 1 and column <= columns
		do
			implementation.set_column_alignment (2, column)
		end
	
	set_right_alignment (column: INTEGER) is
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

	set_column_width (value: INTEGER; column: INTEGER) is
			-- Make `value' the new width of the one-based column.
		require
			column_exists: column >= 1 and column <= columns
		do
			implementation.set_column_width (value, column)
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
			-- Make`value' the new height of all the rows.
		require
		do
			implementation.set_rows_height (value)
		end

feature -- Implementation
	
	implementation: EV_MULTI_COLUMN_LIST_I
			-- Platform specific access.

feature {NONE} -- Inapplicable

	make (par: EV_CONTAINER) is
			-- Do nothing, but need to be implemented.
		do
			check
				inapplicable: False
			end
		end

	create_implementation is
		do
			create {EV_MULTI_COLUMN_LIST_IMP} implementation.make (Current)
		end

end -- class EV_MULTI_COLUMN_LIST

--!----------------------------------------------------------------
--! EiffelVision Library: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
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
--| redefined implementation to be a a more refined type. Changed index wherever it appeared as a parameter.
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
