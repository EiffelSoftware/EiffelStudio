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
		rename
			command_count as item_command_count
		end

	WEL_LIST_VIEW
		rename
			make as wel_make,
			parent as wel_parent,
			set_parent as wel_set_parent,
			destroy as wel_destroy,
			font as wel_font,
			set_font as wel_set_font,
			count as rows,
			column_count as columns,
			selected_items as wel_selected_items,
			get_item as wel_get_item,
			insert_item as wel_insert_item
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
			on_set_focus,
			on_kill_focus,
			on_key_down,
			on_key_up
		redefine
			set_column_title,
			set_column_width,
			on_lvn_columnclick,
			on_lvn_itemchanged,
			default_style
		end
		
creation
	make_with_size,
	make_with_text

feature {NONE} -- Initialization

	make_with_size (col_nb: INTEGER) is         
			-- Create a list widget with `col_nb' columns.
			-- By default, a list allow only one selection.
		local
			a_column: WEL_LIST_VIEW_COLUMN
			i: INTEGER
		do
			!! ev_children.make (0)
			wel_make (default_parent.item, 0, 0, 0, 0, 0)
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
		end

feature -- Access

	selected_item: EV_MULTI_COLUMN_LIST_ROW is
			-- Item which is currently selected in a single
			-- selection mode.
		do
			Result ?= selected_items.last
		end

	selected_items: LINKED_LIST [EV_MULTI_COLUMN_LIST_ROW] is
			-- List of all the selected items. For a single
			-- selection list, it gives a list with only one
			-- element which is `selected_item'. Therefore, one
			-- should use `selected_item' rather than 
			-- `selected_items' for a single selection list
		local
			index: INTEGER
			interf: EV_MULTI_COLUMN_LIST_ROW
			c: ARRAYED_LIST [EV_MULTI_COLUMN_LIST_ROW_IMP]
		do
			from
				c := ev_children
				!! Result.make
				index := 0
			until
				index = selected_count
			loop
				interf ?= (c @ (wel_selected_items @ (index) + 1)).interface
				Result.extend (interf)
				index := index + 1
			end			
		end

feature -- Status report

	selected: BOOLEAN is
			-- Is at least one item selected ?
		do
			Result := selected_count >= 1
		end

	is_multiple_selection: BOOLEAN is
			-- True if the user can choose several items
			-- False otherwise
		do
			Result := not flag_set (style, Lvs_singlesel)
		end

	has_headers: BOOLEAN is
			-- True if there is a header line to give titles
			-- to columns
		do
			Result := not flag_set (style, Lvs_nocolumnheader)
		end

feature -- Status setting

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
		local
			c: LINKED_LIST [EV_MULTI_COLUMN_LIST_ROW]
		do
			from
				c := selected_items
				c.start
			until
				c.after
			loop
				deselect_item (c.item.index)
				c.forth
			end
		end

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
		local
			c: ARRAYED_LIST [EV_MULTI_COLUMN_LIST_ROW_IMP]
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
			reset_content
			c.wipe_out
		end

feature -- Event : command association

	add_selection_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is	
			-- Add `cmd' to the list of commands to be executed
			-- when the selection has changed.
		do
			add_command (Cmd_selection, cmd, arg)
		end

	add_column_click_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when a column is clicked.
		do
			add_command (Cmd_column_click, cmd, arg)
		end

feature -- Event -- removing command association

	remove_selection_commands is	
			-- Empty the list of commands to be executed
			-- when the selection has changed.
		do
			remove_command (Cmd_selection)
		end

	remove_column_click_commands is
			-- Empty the list of commands to be executed
			-- when a column is clicked.
		do
			remove_command (Cmd_column_click)
		end

feature {EV_MULTI_COLUMN_LIST_ROW_I} -- Implementation

	add_item (item_imp: EV_MULTI_COLUMN_LIST_ROW_IMP) is
			-- Add `item_imp' at the end of the list
		do
			insert_item (item_imp, rows + 1)
		end

	insert_item (item_imp: EV_MULTI_COLUMN_LIST_ROW_IMP; index: INTEGER) is
			-- Insert `item_imp' in the list at the index `index'.
		local
			list: ARRAYED_LIST [STRING]
			litem: WEL_LIST_VIEW_ITEM
			rw: INTEGER
		do
			-- First, we insert the graphical object.
			list := item_imp.internal_text
			from
				list.start
				create litem.make_with_attributes (Lvif_text, index - 1, 0, 0, list.item)
				wel_insert_item (litem)
				list.forth
			until
				list.after
			loop
				create litem.make_with_attributes (Lvif_text, index - 1, list.index - 1, 0, list.item)
				cwin_send_message (item, Lvm_setitem, 0, litem.to_integer)
				list.forth
			end

			-- Then, we update ev_children
			ev_children.go_i_th (index - 1)
			ev_children.put_right (item_imp)
		end

	move_item (item_imp: EV_MULTI_COLUMN_LIST_ROW_IMP; index: INTEGER) is
			-- Move the given item to the given position.
		local
			bool: BOOLEAN
		do
			bool := item_imp.is_selected
			remove_item (item_imp)
			insert_item (item_imp, index)
			if bool then
				item_imp.set_selected (True)
			end
		end

	remove_item (item_imp: EV_MULTI_COLUMN_LIST_ROW_IMP) is
			-- Remove `item' from the list
		local
			index: INTEGER
		do
			-- First, we remove the child from the graphical component
			index := ev_children.index_of (item_imp, 1) - 1
			delete_item (index)

			-- Then, we update the children
			ev_children.go_i_th (index)
			ev_children.remove
		end

	internal_get_index (item_imp: EV_MULTI_COLUMN_LIST_ROW_IMP): INTEGER is
			-- Return the index of `item' in the list.
		do
			Result := ev_children.index_of (item_imp, 1)
		end

	internal_is_selected (item_imp: EV_MULTI_COLUMN_LIST_ROW_IMP): BOOLEAN is
			-- Is `item_imp' selected in the list?
		local
			index: INTEGER
		do
			index := ev_children.index_of (item_imp, 1) - 1
			index := get_item_state (index, Lvis_selected)
			Result := flag_set (index, Lvis_selected)
		end

	internal_select (item_imp: EV_MULTI_COLUMN_LIST_ROW_IMP) is
			-- Select `item_imp' in the list.
		local
			index, flags: INTEGER
			litem: WEL_LIST_VIEW_ITEM
		do
			index := ev_children.index_of (item_imp, 1) - 1
			create litem.make_with_attributes (Lvif_state, index, 0, 0, "")
			litem.set_state (Lvis_selected)
			litem.set_statemask (Lvis_selected)	
			cwin_send_message (item, Lvm_setitemstate, index, litem.to_integer)
		end

	internal_deselect (item_imp: EV_MULTI_COLUMN_LIST_ROW_IMP) is
			-- Deselect `item_imp' in the list.
		local
			index, flags: INTEGER
			litem: WEL_LIST_VIEW_ITEM
		do
			index := ev_children.index_of (item_imp, 1) - 1
			create litem.make_with_attributes (Lvif_state, index, 0, 0, "")
			litem.set_state (0)
			litem.set_statemask (Lvis_selected)	
			cwin_send_message (item, Lvm_setitemstate, index, litem.to_integer)
		end

feature {NONE} -- WEL Implementation

	default_style: INTEGER is
			-- Style of the current window.
		do
			Result := Ws_child + Ws_visible + Ws_group 
				+ Ws_tabstop + Ws_border + Ws_clipchildren
				+ Lvs_report + Lvs_showselalways
		end

	on_lvn_columnclick (info: WEL_NM_LIST_VIEW) is
			-- A column was tapped.
		do
			execute_command (Cmd_column_click, Void)
			disable_default_processing
		end

	on_lvn_itemchanged (info: WEL_NM_LIST_VIEW) is
			-- An item has changed
		local
			item_imp: EV_MULTI_COLUMN_LIST_ROW_IMP
		do
			if info.uchanged = Lvif_state and info.isubitem = 0 then
				if flag_set(info.unewstate, Lvis_selected) and
						not flag_set(info.uoldstate, Lvis_selected) then
					item_imp := ev_children @ (info.iitem + 1)
					item_imp.execute_command (Cmd_item_activate, Void)
					execute_command (Cmd_selection, Void)
				elseif flag_set(info.uoldstate, Lvis_selected) and
						not flag_set(info.unewstate, Lvis_selected) then
					item_imp := ev_children @ (info.iitem + 1)
					item_imp.execute_command (Cmd_item_deactivate, Void)
				end
			end
		end

	next_dlgtabitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgTabItem,
			-- because we cannot do a deferred feature become an
			-- external feature.
		do
			Result := cwin_get_next_dlgtabitem (hdlg, hctl, previous)
		end

	next_dlggroupitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgGroupItem,
			-- because we cannot do a deferred feature become an
			-- external feature.
		do
			Result := cwin_get_next_dlggroupitem (hdlg, hctl, previous)
		end

feature {NONE} -- Inapplicable

	make is
			-- Do nothing here
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
