--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: 
		"EiffelVision multi-column-list, implementation interface."
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_MULTI_COLUMN_LIST_I

inherit
	EV_PRIMITIVE_I
		rename
			interface as primitive_interface
		end

	EV_ITEM_LIST_I [EV_MULTI_COLUMN_LIST_ROW]
		select
			interface
		end

feature -- Access

	columns: INTEGER is
			-- Number of columns in the list.
		require
		deferred
		end

	selected_item: EV_MULTI_COLUMN_LIST_ROW is
			-- Item which is currently selected in a single
			-- selection mode.
		require
			single_selection: not multiple_selection_enabled
		deferred
		end

	selected_items: LINKED_LIST [EV_MULTI_COLUMN_LIST_ROW] is
			-- List of all the selected items. For a single
			-- selection list, it gives a list with only one
			-- element which is `selected_item'. Therefore, one
			-- should use `selected_item' rather than 
			-- `selected_items' for a single selection list
		require
		deferred
		end

feature -- Status report

	selected: BOOLEAN is
			-- Is at least one item selected ?
		require
		deferred
		end

	multiple_selection_enabled: BOOLEAN is
			-- True if the user can choose several items
			-- False otherwise
		require
		deferred
		end

	title_shown: BOOLEAN is
			-- True if the title row is shown.
			-- False if the title row is not shown.
		require
		deferred
		end

	column_title (a_column: INTEGER): STRING is
			-- Title of column `a_column'.
		require
			column_exists: a_column >= 1 and a_column <= columns
		deferred
		end

	column_width (a_column: INTEGER): INTEGER is
			-- Width of column `a_column' in pixels.
		require
			column_exists: a_column >= 1 and a_column <= columns
		deferred
		end

feature -- Status setting

	set_columns (i: INTEGER) is
			-- Assign `i' to `columns'
		require
			empty: count = 0
		deferred
		ensure
			columns_assigned: columns = i					
		end

	select_item (an_index: INTEGER) is
			-- Select an item at the one-based `an_index' the list.
		require
			index_large_enough: an_index > 0
			index_small_enough: an_index <= count
		deferred
		end

	deselect_item (an_index: INTEGER) is
			-- Unselect the item at the one-based `an_index'.
		require
			index_large_enough: an_index > 0
			index_small_enough: an_index <= count
		deferred
		end

	clear_selection is
			-- Clear the selection of the list.
		require
		deferred
		end

	enable_multiple_selection is
			-- Allow more than one item to be selected.

		require
		deferred	
		end

	disable_multiple_selection is
			-- Allow only one item to be selected.
		require
		deferred
		end

	show_title_row is
			-- Show the row of the titles.
		require
		deferred
		end

	hide_title_row is
			-- Hide the row of the titles.
		require
		deferred
		end

	set_column_alignment (type: INTEGER; column: INTEGER) is
			-- Align the text of the column.
			-- Not allowed for the first column that stays
			-- left aligned.
			-- 0: Left, 
			-- 1: Right,
			-- 2: Center,
		require
			column_exists: column > 1 and column <= columns
		deferred
		end

feature -- Element change

	set_column_title (txt: STRING; column: INTEGER) is
			-- Make `txt' the title of the one-based column.
		require
			column_exists: column >= 1 and column <= columns
		deferred
		end

	set_columns_title (txt: ARRAY [STRING]) is         
			-- Make `txt' the new titles of the columns.
		require
			text_not_void: txt /= Void
			valid_text_length: txt.count <= columns
		local
			i: INTEGER
			list_i: INTEGER
		do
			from
				i := txt.lower
				list_i := 1
			until
				i = txt.upper + 1
			loop
				set_column_title (txt @ i, list_i)
				i := i+ 1
				list_i := list_i + 1
			end
		end

	set_column_width (a_width: INTEGER; column: INTEGER) is
			-- Make `value' the new width of the one-based column.
		require
			valid_width: a_width >= 1
			column_exists: column >= 1 and column <= columns
		deferred
		end

	set_columns_width (value: ARRAY [INTEGER]) is         
			-- Make `value' the new values of the columns width.
		require
			value_not_void: value /= Void
			valid_value_length: value.count <= columns
		local
			i: INTEGER
			list_i: INTEGER
		do
			from
				i := value.lower
				list_i := 1
			until
				i = value.upper + 1
			loop
				set_column_width (value @ i, list_i)
				i := i + 1
				list_i := list_i + 1
			end
		end

	set_rows_height (value: INTEGER) is
			-- Make`value' the new height of all the rows.
		require
		deferred
		end

feature {EV_MULTI_COLUMN_LIST_ROW_IMP, EV_ITEM_LIST_IMP} -- Implementation

	ev_children: ARRAYED_LIST [EV_MULTI_COLUMN_LIST_ROW_IMP]
			-- We have to store the children because
			-- neither gtk nor windows does it.

invariant
	ev_children_not_void: ev_children /= Void

end -- class EV_MULTI_COLUMN_LIST_I

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
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
--| Revision 1.32  2000/03/03 21:20:02  king
--| Added valid_width precond to set_column_width
--|
--| Revision 1.31  2000/03/03 18:21:47  king
--| Renamed get_column_width -> column_width, added column_title
--|
--| Revision 1.30  2000/03/03 17:08:09  rogers
--| Added set_columns.
--|
--| Revision 1.29  2000/03/02 22:01:14  king
--| Implemented selection name changes
--|
--| Revision 1.28  2000/03/02 18:47:24  rogers
--| Renamed set_multiple_selection -> enable_multiple_selection and
--| set_single_seelction to disable_multiple_seelction.
--|
--| Revision 1.27  2000/02/22 18:39:44  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.26  2000/02/18 23:54:11  oconnor
--| released
--|
--| Revision 1.25  2000/02/16 20:29:45  king
--| Removed redundant remove_item
--|
--| Revision 1.24  2000/02/14 11:40:38  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.23.6.7  2000/02/02 23:47:55  king
--| Removed redundant clutter
--|
--| Revision 1.23.6.6  2000/01/29 01:05:01  brendel
--| Tweaked inheritance clause.
--|
--| Revision 1.23.6.5  2000/01/27 19:30:04  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.23.6.4  1999/12/17 18:01:27  rogers
--| Redefined interface to be of more refined type. Renamed parameter index
--| to an_index. add_item is no longer applicable. export ev_children to
--| EV_ITEM_LIST_IMP.
--|
--| Revision 1.23.6.3  1999/12/09 03:15:06  oconnor
--| commented out make_with_* features, these should be in interface only
--|
--| Revision 1.23.6.2  1999/12/01 19:05:49  rogers
--| Changed inheritance structure from EV_ITEM_HOLDER_I to EV_ITEM_LIST_I
--|
--| Revision 1.23.6.1  1999/11/24 17:30:12  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.23.2.3  1999/11/04 23:10:45  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.23.2.2  1999/11/02 17:20:06  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
