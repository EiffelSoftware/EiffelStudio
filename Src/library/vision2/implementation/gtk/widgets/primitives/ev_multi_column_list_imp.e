indexing
	description: 
		"EiffelVision multi-column-list, implementation interface."
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MULTI_COLUMN_LIST_IMP

inherit
	EV_MULTI_COLUMN_LIST_I

	EV_PRIMITIVE_IMP
		export
			{EV_MULTI_COLUMN_LIST_ROW_IMP} widget
		redefine
			destroy
		end

creation
	make_with_size,
	make_with_text

feature {NONE} -- Initialization

	make_with_size (col_nb: INTEGER) is         
			-- Create a list widget with `par' as
			-- parent and `col_nb' columns.
			-- By default, a list allow only one selection.
		do
			widget := gtk_clist_new (col_nb)
			gtk_object_ref (widget)
			show_title_row
			!! ev_children.make (0)
		end

feature -- Access

	columns: INTEGER is
			-- Number of columns in the list.
		do
			Result := c_gtk_clist_columns (widget)
		end

	rows: INTEGER is
			-- Number of rows in the list.
		do
			Result := c_gtk_clist_rows (widget)
		end

	selected_item: EV_MULTI_COLUMN_LIST_ROW is
			-- Item which is currently selected, for a multiple
			-- selection, it gives the item which has the focus.
		local
			index: INTEGER
		do
			index := c_gtk_clist_ith_selected_item (widget, c_gtk_clist_selection_length (widget))
			Result ?= (ev_children @ (index + 1)).interface
		end

	selected_items: LINKED_LIST [EV_MULTI_COLUMN_LIST_ROW] is
			-- List of all the selected items. For a single
			-- selection list, it gives a list with only one
			-- element which is `selected_item'. Therefore, one
			-- should use `selected_item' rather than 
			-- `selected_items' for a single selection list
		local
			i: INTEGER
			index: INTEGER
			upper: INTEGER
			row: EV_MULTI_COLUMN_LIST_ROW
		do
			upper := c_gtk_clist_selection_length (widget)
			!! Result.make
			from
				i := 0
			until
				i = upper
			loop
				index := c_gtk_clist_ith_selected_item (widget, i)
				row ?= (ev_children @ (index + 1)).interface
				Result.extend (row)
				i := i + 1
			end
		end

feature -- Status report

	selected: BOOLEAN is
			-- Is at least one item selected ?
		do
			Result := c_gtk_clist_selected (widget)
		end

	is_multiple_selection: BOOLEAN is
			-- True if the user can choose several items
			-- False otherwise
		do
			Result := (c_gtk_clist_selection_mode (widget) = GTK_SELECTION_MULTIPLE)
		end

feature -- Status setting

	destroy is
		-- Destroy screen widget implementation and EV_LIST_ITEM objects
		do
			clear_items
			{EV_PRIMITIVE_IMP} Precursor 
		end

	show_title_row is
			-- Show the row of the titles.
		do
			gtk_clist_column_titles_show (widget)
		end

	hide_title_row is
			-- Hide the row of the titles.
		do
			gtk_clist_column_titles_hide (widget)
		end

	set_multiple_selection is
			-- Allow the user to do a multiple selection simply
			-- by clicking on several choices.
			-- For constants, see EV_GTK_CONSTANTS
		do
			gtk_clist_set_selection_mode (widget, GTK_SELECTION_MULTIPLE)
		end

	set_single_selection is
			-- Allow the user to do only one selection. It is the
			-- default status of the list.
			-- For constants, see EV_GTK_CONSTANTS
		do
			gtk_clist_set_selection_mode (widget, GTK_SELECTION_SINGLE)
		end

	set_column_alignment (type: INTEGER; column: INTEGER) is
			-- Align the text of the column at left.

		do
			gtk_clist_set_column_justification (widget, column - 1, type)
		end

	select_item (index: INTEGER) is
			-- Select an item at the one-based `index' the list.
		do
			(ev_children @ index).set_selected (True)
		end

	deselect_item (index: INTEGER) is
			-- Unselect the item at the one-based `index'.
		do
			(ev_children @ index).set_selected (False)
		end

	clear_selection is
			-- Clear the selection of the list.
		do
			gtk_clist_unselect_all (widget)
		end

feature -- Element change

	set_column_title (txt: STRING; column: INTEGER) is
			-- Make `txt' the title of the column number
			-- `number'.
		local
			a: ANY
		do
			a := txt.to_c
			gtk_clist_set_column_title (widget, column - 1, $a)
		end

	set_column_width (value: INTEGER; column: INTEGER) is
			-- Make `value' the new width of the column number
			-- `column'.
		do
			gtk_clist_set_column_width (widget, column - 1, value)
		end

	set_rows_height (value: INTEGER) is
			-- Make`value' the new height of all the rows.
		do
			gtk_clist_set_row_height (widget, value)
		end

	clear_items is
			-- Clear all the items of the list.
		local
			c: ARRAYED_LIST [EV_MULTI_COLUMN_LIST_ROW_IMP]
				-- to work with local variable which
				-- increases speed if there are many elements
				-- in `ev_children'
		do
			from
				c := ev_children
				c.start
			until
				c.after
			loop
				c.item.interface.remove_implementation
				c.forth
			end
			c.wipe_out
			
			gtk_clist_clear (widget)
		end

feature -- Event : command association

	add_selection_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is	
			-- Add `cmd' to the list of commands to be executed
			-- when the selection has changed.
		do
			add_command ("select_row", cmd, arg)
			add_command ("unselect_row", cmd, arg)
		end

	add_column_click_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when a column is clicked.
		do
			add_command ("click_column", cmd, arg)
		end

feature -- Event -- removing command association

	remove_selection_commands is	
			-- Empty the list of commands to be executed
			-- when the selection has changed.
		do
			remove_commands (select_row_id)
			remove_commands (unselect_row_id)
		end

	remove_column_click_commands is
			-- Empty the list of commands to be executed
			-- when a column is clicked.
		do
			remove_commands (click_column_id)
		end

feature {EV_MULTI_COLUMN_LIST_ROW_IMP} -- Implementation

	add_item (item_imp: EV_MULTI_COLUMN_LIST_ROW_IMP) is
			-- Add `item' to the list
		local
			index: INTEGER
			column_i: INTEGER
		do
			-- add an empty row to the gtk column list:
			index := c_gtk_clist_append_row (widget)

			-- add text in the gtk column list row:
			item_imp.set_index (index)
			from
				item_imp.text.start
				column_i := 1
			until
				column_i > columns
			loop
				item_imp.set_cell_text ( column_i, item_imp.text.item)
				item_imp.text.forth
				column_i := column_i + 1
			end
				
			-- update the list of rows of the column list:
			ev_children.force (item_imp)

		end

	remove_item (item_imp: EV_MULTI_COLUMN_LIST_ROW_IMP) is
		do
			gtk_clist_remove (widget, item_imp.index)
		end

feature {NONE} -- Inapplicable

	make is
			-- Do nothing, need to be implemented
		do
			check
				Inapplicable: False
			end
		end

end -- class EV_MULTI_COLUMN_LIST_IMP

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
