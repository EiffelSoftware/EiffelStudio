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
			make
		end

creation
	make_with_size,
	make_with_text

feature {NONE} -- Initialization

	make_with_size (par: EV_CONTAINER; col_nb: INTEGER) is         
			-- Create a list widget with `par' as
			-- parent and `col_nb' columns.
			-- By default, a list allow only one selection.
		require
			valid_parent: parent_needed implies par /= Void
			valid_nb: col_nb > 0
		do
			!EV_MULTI_COLUMN_LIST_IMP!implementation.make_with_size (col_nb)
			widget_make (par)
		end

	make_with_text (par: EV_CONTAINER; txt: ARRAY [STRING]) is         
			-- Create a list widget with `par' as parent,
			-- and as many columns as the number of titles
			-- given.
		require
			valid_parent: parent_needed implies par /= Void
			valid_text: txt /= Void
		do
			!EV_MULTI_COLUMN_LIST_IMP!implementation.make_with_text (txt)
			widget_make (par)
		end

feature -- Access

	rows: INTEGER is
			-- Number of rows
		require
			exists: not destroyed
		do
			Result := implementation.rows
		end

	columns: INTEGER is
			-- Number of columns in the list.
		require
			exists: not destroyed
		do
			Result := implementation.columns
		end

	get_item (index: INTEGER): EV_MULTI_COLUMN_LIST_ROW is
			-- Give the item of the list at the one-base
			-- `index'.
		require
			exists: not destroyed
			item_exists: index <= rows
		do
			Result := implementation.get_item(index)
		end

	selected_item: EV_MULTI_COLUMN_LIST_ROW is
			-- Item which is currently selected in a single
			-- selection mode.
		require
			exists: not destroyed
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
			exists: not destroyed
		do
			Result := implementation.selected_items
		end

feature -- Status report

	selected: BOOLEAN is
			-- Is at least one item selected ?
		require
			exists: not destroyed
		do
			Result := implementation.selected
		end

	is_multiple_selection: BOOLEAN is
			-- True if the user can choose several items
			-- False otherwise
		require
			exist: not destroyed
		do
			Result := implementation.is_multiple_selection
		end

feature -- Status setting

	select_item (index: INTEGER) is
			-- Select an item at the one-based `index' the list.
		require
			exists: not destroyed
			index_large_enough: index > 0
			index_small_enough: index <= columns
		do
			implementation.select_item (index)
		end

	deselect_item (index: INTEGER) is
			-- Unselect the item at the one-based `index'.
		require
			exists: not destroyed
			index_large_enough: index > 0
			index_small_enough: index <= columns
		do
			implementation.deselect_item (index)
		end

	clear_selection is
			-- Clear the selection of the list.
		require
			exists: not destroyed
		do
			implementation.clear_selection
		end

	set_multiple_selection is
			-- Allow the user to do a multiple selection simply
			-- by clicking on several choices.
		require
			exists: not destroyed
		do
			implementation.set_multiple_selection	
		end

	set_single_selection is
			-- Allow the user to do only one selection. It is the
			-- default status of the list
		require
			exists: not destroyed
		do
			implementation.set_single_selection
		end

	show_title_row is
			-- Show the row of the titles.
		require
			exists: not destroyed
		do
			implementation.show_title_row
		end

	hide_title_row is
			-- Hide the row of the titles.
		require
			exists: not destroyed
		do
			implementation.hide_title_row
		end

	set_left_alignment (column: INTEGER) is
			-- Align the text of the column at left.
			-- Cannot be used for the first column which is 
			-- always left aligned.
		require
			exists: not destroyed
			column_exists: column > 1 and column <= columns
		do
			implementation.set_column_alignment (0, column)
		end

	set_center_alignment (column: INTEGER) is
			-- Align the text of the column at left.
			-- Cannot be used for the first column which is 
			-- always left aligned.
		require
			exists: not destroyed
			column_exists: column > 1 and column <= columns
		do
			implementation.set_column_alignment (2, column)
		end
	
	set_right_alignment (column: INTEGER) is
			-- Align the text of the column at left.
			-- Cannot be used for the first column which is 
			-- always left aligned.
		require
			exists: not destroyed
			column_exists: column > 1 and column <= columns
		do
			implementation.set_column_alignment (1, column)
		end

feature -- Element change

	set_column_title (txt: STRING; column: INTEGER) is
			-- Make `txt' the title of the one-based `column'.
		require
			exists: not destroyed
			column_exists: column >= 1 and column <= columns
		do
			implementation.set_column_title (txt, column)
		end

	set_columns_title (txt: ARRAY [STRING]) is         
			-- Make `txt' the new titles of the columns.
		require
			exists: not destroyed
			text_not_void: txt /= Void
			valid_text_length: txt.count <= columns
		do
			implementation.set_columns_title (txt)
		end

	set_column_width (value: INTEGER; column: INTEGER) is
			-- Make `value' the new width of the one-based column.
		require
			exists: not destroyed
			column_exists: column >= 1 and column <= columns
		do
			implementation.set_column_width (value, column)
		end

	set_columns_width (value: ARRAY [INTEGER]) is         
			-- Make `value' the new values of the columns width.
		require
			exists: not destroyed
			value_not_void: value /= Void
			valid_value_length: value.count <= columns
		do
			implementation.set_columns_width (value)
		end

	set_rows_height (value: INTEGER) is
			-- Make`value' the new height of all the rows.
		require
			exists: not destroyed
		do
			implementation.set_rows_height (value)
		end

	clear_items is
			-- Clear all the items of the list.
		require
			exists: not destroyed
		do
			implementation.clear_items
		end

feature -- Event : command association

	add_selection_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is	
			-- Add `cmd' to the list of commands to be executed
			-- when the selection has changed.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		do
			implementation.add_selection_command (cmd, arg)
		end

	add_column_click_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when a column is clicked.
		require
			exists: not destroyed
			valid_command: cmd /= Void
		do
			implementation.add_column_click_command (cmd, arg)
		end

feature -- Event -- removing command association

	remove_selection_commands is	
			-- Empty the list of commands to be executed
			-- when the selection has changed.
		require
			exists: not destroyed
		do
			implementation.remove_selection_commands
		end

	remove_column_click_commands is
			-- Empty the list of commands to be executed
			-- when a column is clicked.
		require
			exists: not destroyed
		do
			implementation.remove_column_click_commands
		end

feature {EV_MULTI_COLUMN_LIST_ROW_IMP, EV_MULTI_COLUMN_LIST_ROW} -- Implementation
	
	implementation: EV_MULTI_COLUMN_LIST_I	

feature {NONE} -- Inapplicable

	make (par: EV_CONTAINER) is
			-- Do nothing, but need to be implemented.
		do
			check
				inapplicable: False
			end
		end

end -- class EV_MULTI_COLUMN_LIST

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
