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

feature {NONE} -- Initialization

	make_with_size (col_nb: INTEGER) is         
			-- Create a list widget with `par' as
			-- parent and `col_nb' columns.
			-- By default, a list allow only one selection.
		deferred
		end

	make_with_text (txt: ARRAY [STRING]) is         
			-- Create a list widget with `par' as parent,
			-- and as many columns as the number of titles
			-- given.
		require
			valid_txt: txt /= Void
		do
			make_with_size (txt.count)
			set_columns_title (txt)
		end

feature -- Access

	rows: INTEGER is
			-- Number of rows
		require
			exists: not destroyed
		deferred
		end

	columns: INTEGER is
			-- Number of columns in the list.
		require
			exists: not destroyed
		deferred
		end

	get_item (index: INTEGER): EV_MULTI_COLUMN_LIST_ROW is
			-- Give the item of the list at the one-base
			-- `index'.
		require
			exists: not destroyed
			item_exists: index <= rows
		do
			Result ?= (ev_children @ index).interface
		end

	selected_item: EV_MULTI_COLUMN_LIST_ROW is
			-- Item which is currently selected in a single
			-- selection mode.
		require
			exists: not destroyed
			single_selection: not is_multiple_selection
		deferred
		end

	selected_items: LINKED_LIST [EV_MULTI_COLUMN_LIST_ROW] is
			-- List of all the selected items. For a single
			-- selection list, it gives a list with only one
			-- element which is `selected_item'. Therefore, one
			-- should use `selected_item' rather than 
			-- `selected_items' for a single selection list
		require
			exists: not destroyed
		deferred
		end

feature -- Status report

	selected: BOOLEAN is
			-- Is at least one item selected ?
		require
			exists: not destroyed
		deferred
		end

	is_multiple_selection: BOOLEAN is
			-- True if the user can choose several items
			-- False otherwise
		require
			exist: not destroyed
		deferred
		end

feature -- Status setting

	select_item (index: INTEGER) is
			-- Select an item at the one-based `index' the list.
		require
			exists: not destroyed
			index_large_enough: index > 0
			index_small_enough: index <= columns
		deferred
		end

	deselect_item (index: INTEGER) is
			-- Unselect the item at the one-based `index'.
		require
			exists: not destroyed
			index_large_enough: index > 0
			index_small_enough: index <= columns
		deferred
		end

	clear_selection is
			-- Clear the selection of the list.
		require
			exists: not destroyed
		deferred
		end

	set_multiple_selection is
			-- Allow the user to do a multiple selection simply
			-- by clicking on several choices.
		require
			exists: not destroyed
		deferred	
		end

	set_single_selection is
			-- Allow the user to do only one selection. It is the
			-- default status of the list
		require
			exists: not destroyed
		deferred
		end

	show_title_row is
			-- Show the row of the titles.
		require
			exists: not destroyed
		deferred
		end

	hide_title_row is
			-- Hide the row of the titles.
		require
			exists: not destroyed
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
			exists: not destroyed
			column_exists: column > 1 and column <= columns
		deferred
		end

feature -- Element change

	set_column_title (txt: STRING; column: INTEGER) is
			-- Make `txt' the title of the one-based column.
		require
			exists: not destroyed
			column_exists: column >= 1 and column <= columns
		deferred
		end

	set_columns_title (txt: ARRAY [STRING]) is         
			-- Make `txt' the new titles of the columns.
		require
			exists: not destroyed
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

	set_column_width (value: INTEGER; column: INTEGER) is
			-- Make `value' the new width of the one-based column.
		require
			exists: not destroyed
			column_exists: column >= 1 and column <= columns
		deferred
		end

	set_columns_width (value: ARRAY [INTEGER]) is         
			-- Make `value' the new values of the columns width.
		require
			exists: not destroyed
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
			exists: not destroyed
		deferred
		end

	clear_items is
			-- Clear all the items of the list.
		require
			exists: not destroyed
		deferred
		end

feature -- Basic operation

	find_item_by_data (data: ANY): EV_MULTI_COLUMN_LIST_ROW is
			-- Find a child with data equal to `data'.
		require
			exists: not destroyed
			valid_data: data /= Void
		local
			list: ARRAYED_LIST [EV_MULTI_COLUMN_LIST_ROW_IMP]
			litem: EV_MULTI_COLUMN_LIST_ROW
		do
			from
				list := ev_children
				list.start
			until
				list.after or Result /= Void
			loop
				litem ?= list.item.interface
				if litem.data.is_equal (data) then
					Result ?= litem
				end
				list.forth
			end
		end

feature -- Event : command association

	add_selection_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is	
			-- Add `cmd' to the list of commands to be executed
			-- when the selection has changed.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		deferred
		end

	add_column_click_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when a column is clicked.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		deferred
		end

feature -- Event -- removing command association

	remove_selection_commands is	
			-- Empty the list of commands to be executed
			-- when the selection has changed.
		require
			exists: not destroyed
		deferred
		end

	remove_column_click_commands is
			-- Empty the list of commands to be executed
			-- when a column is clicked.
		require
			exists: not destroyed
		deferred
		end

feature {EV_MULTI_COLUMN_LIST_ROW} -- Implementation

	ev_children: ARRAYED_LIST [EV_MULTI_COLUMN_LIST_ROW_IMP]
			-- We have to store the children because
			-- neither gtk nor windows does it.

	add_item (item_imp: EV_MULTI_COLUMN_LIST_ROW_IMP) is
			-- Add `item' to the list
		deferred
		end

	remove_item (item_imp: EV_MULTI_COLUMN_LIST_ROW_IMP) is
			-- Remove `item' from the list
		deferred
		end

invariant
	ev_children_not_void: ev_children /= Void

end -- class EV_MULTI_COLUMN_LIST_I

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|---------------------------------------------------------------
