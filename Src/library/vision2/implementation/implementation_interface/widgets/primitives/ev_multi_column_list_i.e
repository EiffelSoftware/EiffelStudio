indexing
	description: 
		"Eiffel Vision multi column list. Implementation interface."
	status: "See notice at end of class"
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

feature {NONE} -- Initialization

	initialize is
		do
			update_children_agent := ~update_children
			create column_titles.make
			create column_widths.make
		end

feature -- Access

	columns: INTEGER is
			-- Column count.
		deferred
		end

	selected_item: EV_MULTI_COLUMN_LIST_ROW is
			-- Currently selected item.
			-- Topmost selected item if multiple items are selected.
			-- (For multiple selections see `selected_items')
		deferred
		end

	selected_items: LINKED_LIST [EV_MULTI_COLUMN_LIST_ROW] is
			-- Currently selected items.
		deferred
		end

	row_height: INTEGER is
			-- Height in pixels of each row.
		deferred
		end

feature -- Status report

	multiple_selection_enabled: BOOLEAN is
			-- Can more that one item be selected?
		deferred
		end
	
	title_shown: BOOLEAN is
			-- Is a row displaying column titles shown?
		deferred
		end

	column_title (a_column: INTEGER): STRING is
			-- Title of `a_column'.
		require
			a_column_positive: a_column > 0
		do
			if a_column <= column_titles.count then
				Result := column_titles @ a_column
			else
				Result := ""
			end
		end
	
	column_width (a_column: INTEGER): INTEGER is
			-- Width of `a_column' in pixels.
		require
			a_column_positive: a_column > 0
		do
			if a_column <= column_widths.count then
				Result := column_widths @ a_column
			end
		end

feature -- Status setting

	select_item (an_index: INTEGER) is
			-- Select item at `an_index'.
		require
			an_index_within_range: an_index > 0 and an_index <= count
		deferred
		ensure
			item_deselected: not selected_items.has (interface.i_th (an_index))
		end

	deselect_item (an_index: INTEGER) is
			-- Deselect item at `an_index'.
		require
			an_index_within_range: an_index > 0 and an_index <= count
		deferred
		ensure
			item_deselected: not selected_items.has (interface.i_th (an_index))
		end

	clear_selection is
			-- Make `selected_items' empty.
		deferred
		ensure
			selected_items_empty: selected_items.empty
		end

	enable_multiple_selection is
			-- Allow more than one item to be selected.
		deferred
		ensure
			multiple_selection_enabled: multiple_selection_enabled
		end

	disable_multiple_selection is
			-- Allow only one item to be selected.
		deferred
		ensure
			not_multiple_selection_enabled: not multiple_selection_enabled
		end

	show_title_row is
			-- Show row displaying column titles.
		deferred
		ensure
			title_shown: title_shown
		end

	hide_title_row is
			-- Hide row displaying column titles.
		deferred
		ensure
			not_title_shown: not title_shown
		end

	align_text_left (a_column: INTEGER) is
			-- Display text of `a_column' left aligned.
			-- First column is always left aligned.
		require
			a_column_withing_range: a_column > 1 and a_column <= columns
		deferred
		end

	align_text_center (a_column: INTEGER) is
			-- Display text of `a_column' centered.
			-- First column is always left aligned.
		require
			a_column_within_range: a_column > 1 and a_column <= columns
		deferred
		end
	
	align_text_right (a_column: INTEGER) is
			-- Display text of `a_column' right aligned.
			-- First column is always left aligned.
		require
			a_column_within_range: a_column > 1 and a_column <= columns
		deferred
		end

feature -- Element change

	set_column_title (a_title: STRING; a_column: INTEGER) is
			-- Assign `a_title' to the `column_title'(`a_column').
		require
			a_column_positive: a_column > 0
			a_title_not_void: a_title /= Void
		do
			if a_column <= column_titles.count then
				column_titles.go_i_th (a_column)
				column_titles.replace (clone (a_title))
			else
				from	
				until
					a_column = column_titles.count + 1
				loop
					column_titles.extend (Void)
				end
				column_titles.extend (clone (a_title))
			end
			column_title_changed (a_title, a_column)
		ensure
			a_title_assigned: a_title.is_equal (column_title (a_column))
		end

	set_column_titles (titles: ARRAY [STRING]) is         
			-- Assign `titles' to titles of columns in order.
		require
			titles_not_void: titles /= Void
			titles_count_is_columns: titles.count = columns
		local
			i: INTEGER
			old_count: INTEGER
		do
			from
				i := 1
				old_count := column_titles.count
				column_titles.wipe_out
			until
				i > column_titles.count
			loop
				column_title_changed (titles @ i, i)
				column_titles.extend (clone (titles @ i))
				i := i + 1
				old_count := old_count - 1
			end
			from
			until
				old_count <= 0
			loop
				column_title_changed ("", i)
				i := i + 1
				old_count := old_count - 1
			end
		end

	set_column_width (a_width: INTEGER; a_column: INTEGER) is
			-- Assign `a_width' `column_width'(`a_column').
		require
			a_column_within_range: a_column > 0 and a_column <= columns
			a_width_positive: a_width > 0
		do
			if a_column <= column_widths.count then
				column_widths.go_i_th (a_column)
				column_widths.replace (a_width)
			else
				from	
				until
					a_column = column_widths.count + 1
				loop
					column_widths.extend (Default_column_width) 
				end
				column_widths.extend (a_width)
			end
			column_width_changed (a_width, a_column)
		ensure
			a_width_assigned: a_width = column_width (a_column)
		end

	set_column_widths (widths: ARRAY [INTEGER]) is         
			-- Assign `widths' to column widths in order.
		require
			widths_not_void: widths /= Void
			widths_count_is_columns: widths.count = columns
		local
			i: INTEGER
			old_count: INTEGER
		do
			from
				i := 1
				old_count := column_widths.count
				column_widths.wipe_out
			until
				i > column_widths.count
			loop
				column_width_changed (widths @ i, i)
				column_widths.extend (widths @ i)
				i := i + 1
				old_count := old_count - 1
			end
			from
			until
				old_count <= 0
			loop
				column_title_changed ("", i)
				i := i + 1
				old_count := old_count - 1
			end
		end

	set_row_height (a_height: INTEGER) is
			-- Set all rows to `a_height'.
		require
			height_valid: a_height > 0
		deferred
		ensure
			a_height_assigned: a_height = row_height
		end

feature {EV_ANY_I} -- Implementation

	update_children is
			-- Update all children with `update_needed' True.
			--| We are on an idle action now. At least one item has marked
			--| itself `update_needed'.
		local
			cur: INTEGER
		do
			cur := ev_children.index
			from
				ev_children.start
			until
				ev_children.after
			loop
				if ev_children.item.update_needed then
					update_child (ev_children.item, ev_children.index)
				end
				ev_children.forth
			end
			ev_children.go_i_th (index)
		end

	update_child (child: EV_MULTI_COLUMN_LIST_ROW_IMP; a_row: INTEGER) is
			-- Update `child'.
		require
			child_not_void: child /= Void
			child_dirty: child.update_needed
		local
			cur: CURSOR
			txt: STRING
			list: LINKED_LIST [STRING]
		do
			list := child.interface
			cur := list.cursor
			from
				list.start
			until
				list.after
			loop
				txt := list.item
				if txt = Void then
					txt := ""
				end
				if list.index > columns then
					add_column
				end
				set_text_on_position (list.index, a_row, txt)
				list.forth
			end
			list.go_to (cur)
			child.update_performed
		ensure
			child_updated: not child.update_needed
		end

	add_column is
			-- Append new column at end.
		deferred
		ensure
			column_count_increased: columns = old columns + 1
		end

	set_text_on_position (a_column, a_row: INTEGER; a_text: STRING) is
			-- Set the label of the cell with coordinates `a_x', `a_y'
			-- with `txt'.
		require
			a_column_large_enough: a_column > 0
			a_row_large_enough: a_row > 0
			a_column_small_enough: a_column <= columns
			a_row_small_enough: a_row <= count
			a_text_not_void: a_text /= Void
		deferred
		end

	column_title_changed (a_title: STRING; a_column: INTEGER) is
			-- Replace title of `a_column' with `a_title' if column present.
			-- If `a_title' is Void, remove it.
		require
			a_column_positive: a_column > 0
		deferred
		end

	column_width_changed (a_width, a_column: INTEGER) is
			-- Replace width of `a_column' with `a_width' if column present.
		require
			a_column_positive: a_column > 0
			a_width_positive: a_width > 0
		deferred
		end

	update_children_agent: PROCEDURE [EV_MULTI_COLUMN_LIST_I, TUPLE []]
			-- Agent object for `update_children'.

feature {EV_MULTI_COLUMN_LIST_ROW_IMP, EV_ITEM_LIST_IMP} -- Implementation

	ev_children: ARRAYED_LIST [EV_MULTI_COLUMN_LIST_ROW_IMP]
			-- We have to store the children because
			-- neither gtk nor windows does it.

	column_titles: LINKED_LIST [STRING]
			-- All column titles set using `set_column_titles' and
			-- `set_column_title'. We store it to give the user the
			-- option to specify more titles than the current number of colums.

	column_widths: LINKED_LIST [INTEGER]
			-- All column widths set using `set_column_widths' and
			-- `set_column_width'.

	Default_column_width: INTEGER is 80

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
--| Revision 1.37  2000/03/25 01:13:58  brendel
--| Revised. Formatting.
--| Implemented platform independently: set_column_*.
--| Propagated to platforms: column_width_changed and column_title_changed.
--|
--| Revision 1.36  2000/03/24 19:36:08  brendel
--| Moved update_child back again. Added `add_column' and
--| `set_text_on_position' to support the function.
--|
--| Revision 1.35  2000/03/24 17:56:28  brendel
--| Made `update_child' deferred because it needs some platform specific
--| stuff.
--|
--| Revision 1.34  2000/03/24 17:29:35  brendel
--| Moved platform independent update code here.
--|
--| Revision 1.33  2000/03/24 01:36:21  brendel
--| Added row_height.
--| Formatting.
--|
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
