indexing
	description: 
		"EiffelVision multi-column-list, Mswindows implementation."
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MULTI_COLUMN_LIST_IMP

inherit
	EV_MULTI_COLUMN_LIST_I

	EV_PRIMITIVE_IMP

	EV_ITEM_EVENTS_CONSTANTS_IMP

	WEL_LIST_VIEW
		rename
			make as wel_make,
			destroy as wel_destroy,
			parent as wel_parent,
			font as wel_font,
			set_font as wel_set_font,
			count as rows,
			column_count as columns,
			selected_items as wel_selected_items,
			get_item as wel_get_item
		undefine
			remove_command,
			set_width,
			set_height,
			on_left_button_down,
			on_right_button_down,
			on_left_button_up,
			on_right_button_up,
			on_left_button_double_click,
			on_right_button_double_click,
			on_mouse_move,
			on_char,
			on_key_up
		redefine
			set_column_title,
			set_column_width,
			on_lvn_columnclick,
			on_lvn_itemchanged 
		end
		
creation
	make_with_size

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
		do
			check
				Inapplicable: False
			end
		end

	make_with_size (par: EV_CONTAINER; col_nb: INTEGER) is         
			-- Create a list widget with `par' as
			-- parent and `col_nb' columns.
			-- By default, a list allow only one selection.
		local
			par_imp: WEL_WINDOW
			a_column: WEL_LIST_VIEW_COLUMN
			i: INTEGER
		do
			!! ev_children.make (0)
			par_imp ?= par.implementation
			check
				par_imp /= Void
			end
			wel_make (par_imp, 0, 0, 0, 0, 0)
			from
				i := 1
			until
				i = col_nb + 1
			loop
				!! a_column.make
				a_column.set_cx (80)
				a_column.set_text ("")
				append_column (a_column)
				i := i + 1
			end
			is_multiple_selection := True
			has_headers := True
		end

feature -- Access

	selected_item: EV_MULTI_COLUMN_LIST_ROW is
			-- Item which is currently selected, for a multiple
			-- selection, it gives the last selected item.
		do
			Result ?= ev_children.last
		end

	selected_items: LINKED_LIST [EV_MULTI_COLUMN_LIST_ROW] is
			-- List of all the selected items. For a single
			-- selection list, it gives a list with only one
			-- element which is `selected_item'. Therefore, one
			-- should use `selected_item' rather than 
			-- `selected_items' for a single selection list
		local
			index: INTEGER
		do
			from
				!! Result.make
				index := 1
			until
				index = selected_count
			loop
				Result.extend (ev_children @ (wel_selected_items @ index))
				index := index + 1
			end			
		end

feature -- Status report

	selected: BOOLEAN is
			-- Is at least one item selected ?
		do
			Result := selected_count >= 1
		end

	is_multiple_selection: BOOLEAN
			-- True if the user can choose several items
			-- False otherwise

	has_headers: BOOLEAN
			-- True if there is a header line to give titles
			-- to columns

feature -- Status setting

	set_multiple_selection is
			-- Allow the user to do a multiple selection simply
			-- by clicking on several choices.
		do
			if not is_multiple_selection then
				if has_headers then
					set_style (default_style)
				else
					set_style (default_style + Lvs_nocolumnheader)
				end
				is_multiple_selection := True
			end
		end

	set_single_selection is
			-- Allow the user to do only one selection. It is the
			-- default status of the list
		do
			if is_multiple_selection then
				if has_headers then
					set_style (default_style + Lvs_singlesel)
				else
					set_style (default_style + Lvs_singlesel +Lvs_nocolumnheader)
				end
				is_multiple_selection := False
			end
		end

	show_title_row is
			-- Show the row of the titles.
		do
			if not has_headers then
				if is_multiple_selection then
					set_style (default_style)
				else
					set_style (default_style + Lvs_singlesel)
				end
				has_headers := True
			end
		end

	hide_title_row is
			-- Hide the row of the titles.
		do
			if has_headers then
				if is_multiple_selection then
					set_style (default_style + Lvs_nocolumnheader)
				else
					set_style (default_style + Lvs_singlesel + Lvs_nocolumnheader)
				end
				has_headers := False
			end
		end

	set_column_alignment (type: INTEGER; column: INTEGER) is
			-- Align the text of the column.
			-- 0: Left, 
			-- 1: Right,
			-- 2: Center,
			-- 3: Justify
		do
			inspect type
			when 0 then
				set_column_format (column - 1, Lvcfmt_left)
			when 1 then
				set_column_format (column - 1, Lvcfmt_right)
			when 2 then
				set_column_format (column - 1, Lvcfmt_center)
			when 3 then
				set_column_format (column - 1, Lvcfmt_justifymask)
			end
		end

feature -- Element change

	set_column_title (txt: STRING; column: INTEGER) is
			-- Make `txt' the title of the column number
			-- `number'.
		do
			{WEL_LIST_VIEW} Precursor (txt, column - 1)
		end

	set_column_width (value: INTEGER; column: INTEGER) is
			-- Make `value' the new width of the one-based column.
		do
			{WEL_LIST_VIEW} Precursor (value, column - 1)
		end

	set_rows_height (value: INTEGER) is
			-- Make`value' the new height of all the rows.
		do
			check
				not_possible: False
			end
		end

	clear_items is
			-- Clear all the items of the list.
		do
			from
				ev_children.start
			until
				ev_children.after
			loop
				ev_children.item.remove_implementation
				ev_children.forth
			end
			reset_content
			ev_children.wipe_out
		end

feature -- Event : command association

	add_selection_command (cmd: EV_COMMAND; arg: EV_ARGUMENTS) is	
			-- Add `cmd' to the list of commands to be executed
			-- when the selection has changed.
		do
			add_command (Cmd_selection, cmd, arg)
		end

	add_column_click_command (cmd: EV_COMMAND; arg: EV_ARGUMENTS) is
			-- Add `cmd' to the list of commands to be executed
			-- when a column is clicked.
		do
			add_command (Cmd_column_click, cmd, arg)
		end

feature {EV_MULTI_COLUMN_LIST_ROW} -- Implementation

	add_item (an_item: EV_MULTI_COLUMN_LIST_ROW) is
			-- Add `item' to the list
		local
			item_imp: EV_MULTI_COLUMN_LIST_ROW_IMP
		do
			item_imp ?= an_item.implementation
			item_imp.set_iitem (rows)
			insert_item (item_imp)
			ev_children.force (an_item)
		end

	on_lvn_columnclick (info: WEL_NM_LIST_VIEW) is
			-- A column was tapped.
		do
			execute_command (Cmd_column_click, Void)
		end

	on_lvn_itemchanged (info: WEL_NM_LIST_VIEW) is
			-- An item has changed
		local
			item_imp: EV_MULTI_COLUMN_LIST_ROW_IMP
		do
			if flag_set(info.unewstate, Lvis_selected) and
					not flag_set(info.uoldstate, Lvis_selected) then
				item_imp ?= (ev_children @ (info.iitem + 1)).implementation
				item_imp.execute_command (Cmd_item_activate, Void)
				execute_command (Cmd_selection, Void)
			elseif flag_set(info.uoldstate, Lvis_selected) and
					not flag_set(info.unewstate, Lvis_selected) then
				item_imp ?= (ev_children @ (info.iitem + 1)).implementation
				item_imp.execute_command (Cmd_item_deactivate, Void)
				execute_command (Cmd_selection, Void)
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
