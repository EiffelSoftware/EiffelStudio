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
		redefine
			on_left_button_down,
			on_middle_button_down,
			on_right_button_down,
			on_left_button_up,
			on_middle_button_up,
			on_right_button_up,
			on_key_down
		end

	EV_ARRAYED_LIST_ITEM_HOLDER_IMP
		redefine
			move_item
		end

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
			shown as displayed,
			font as wel_font,
			set_font as wel_set_font,
			column_count as columns,
			selected_items as wel_selected_items,
			get_item as wel_get_item,
			insert_item as wel_insert_item
		undefine
			window_process_message,
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
			on_key_up,
			on_set_cursor,
			show,
			hide
		redefine
			set_column_title,
			set_column_width,
			on_lvn_columnclick,
			on_lvn_itemchanged,
			default_style
		end

	WEL_LVHT_CONSTANTS
		export
			{NONE} all
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
			wel_make (default_parent, 0, 0, 0, 0, 0)
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

	find_item_at_position (x_pos, y_pos: INTEGER): EV_MULTI_COLUMN_LIST_ROW_IMP is
			-- Find the item at the given position.
			-- Position is relative to the toolbar.
		local
			pt: WEL_POINT
			handle: INTEGER
			info: WEL_LV_HITTESTINFO
		do
			create pt.make (x_pos, y_pos)
			create info.make_with_point (pt)
			cwin_send_message (item, Lvm_hittest, 0, info.to_integer)
			if flag_set (info.flags, Lvht_onitemlabel)
			or flag_set (info.flags, Lvht_onitemicon)
			then
				Result := ev_children @ (info.iitem + 1)
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

	title_shown: BOOLEAN is
			-- True if the title row is shown.
			-- False if the title row is not shown.
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

	item_type: EV_MULTI_COLUMN_LIST_ROW_IMP is
			-- An empty feature to give a type.
			-- We don't use the genericity because it is
			-- too complicated with the multi-platform design.
			-- Need to be redefined.
		do
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
			ev_children.go_i_th (index + 1)
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

	internal_propagate_event (event_id, x_pos, y_pos: INTEGER; ev_data: EV_BUTTON_EVENT_DATA) is
			-- Propagate `event_id' to the good item.
		local
			it: EV_MULTI_COLUMN_LIST_ROW_IMP
		do
			it := find_item_at_position (x_pos, y_pos)
			if it /= Void then
				it.execute_command (event_id, ev_data)
			end
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

	on_left_button_down (keys, x_pos, y_pos: INTEGER) is
			-- Wm_lbuttondown message
			-- See class WEL_MK_CONSTANTS for `keys' value
		local
			ev_data: EV_BUTTON_EVENT_DATA
		do
			ev_data := get_button_data (1, keys, x_pos, y_pos)
			if has_command (Cmd_button_one_press) then
				execute_command (Cmd_button_one_press, ev_data)
			end
			internal_propagate_event (Cmd_button_one_press, x_pos, y_pos, ev_data)
		end

	on_middle_button_down (keys, x_pos, y_pos: INTEGER) is
			-- Wm_mbuttondown message
			-- See class WEL_MK_CONSTANTS for `keys' value
		local
			ev_data: EV_BUTTON_EVENT_DATA
		do
			ev_data := get_button_data (2, keys, x_pos, y_pos)
			if has_command (Cmd_button_two_press) then
				execute_command (Cmd_button_two_press, ev_data)
			end
			internal_propagate_event (Cmd_button_two_press, x_pos, y_pos, ev_data)
		end

	on_right_button_down (keys, x_pos, y_pos: INTEGER) is
			-- Wm_rbuttondown message
			-- See class WEL_MK_CONSTANTS for `keys' value
		local
			ev_data: EV_BUTTON_EVENT_DATA
		do
			ev_data := get_button_data (2, keys, x_pos, y_pos)
			if has_command (Cmd_button_three_press) then
				execute_command (Cmd_button_three_press, ev_data)
			end
			internal_propagate_event (Cmd_button_three_press, x_pos, y_pos, ev_data)
			disable_default_processing
		end

	on_left_button_up (keys, x_pos, y_pos: INTEGER) is
			-- Wm_lbuttonup message
			-- See class WEL_MK_CONSTANTS for `keys' value
		local
			ev_data: EV_BUTTON_EVENT_DATA
		do
			ev_data := get_button_data (1, keys, x_pos, y_pos)
			if has_command (Cmd_button_one_release) then
				execute_command (Cmd_button_one_release, ev_data)
			end
			internal_propagate_event (Cmd_button_one_release, x_pos, y_pos, ev_data)
		end

	on_middle_button_up (keys, x_pos, y_pos: INTEGER) is
			-- Wm_mbuttonup message
			-- See class WEL_MK_CONSTANTS for `keys' value
		local
			ev_data: EV_BUTTON_EVENT_DATA
		do
			ev_data := get_button_data (2, keys, x_pos, y_pos)
			if has_command (Cmd_button_two_release) then
				execute_command (Cmd_button_two_release, ev_data)
			end
			internal_propagate_event (Cmd_button_two_release, x_pos, y_pos, ev_data)
		end

	on_right_button_up (keys, x_pos, y_pos: INTEGER) is
			-- Wm_rbuttonup message
			-- See class WEL_MK_CONSTANTS for `keys' value
		local
			ev_data: EV_BUTTON_EVENT_DATA
		do
			ev_data := get_button_data (3, keys, x_pos, y_pos)
			if has_command (Cmd_button_three_release) then
				execute_command (Cmd_button_three_release, ev_data)
			end
			internal_propagate_event (Cmd_button_three_release, x_pos, y_pos, ev_data)
		end

	on_key_down (virtual_key, key_data: INTEGER) is
			-- A key has been pressed
		do
			{EV_PRIMITIVE_IMP} Precursor (virtual_key, key_data)
			process_tab_key (virtual_key)
		end

feature -- Inapplicable

	make is
			-- Not applicable
		do
			check
				Inapplicable: False
			end
		end

feature {NONE} -- Feature that should be directly implemented by externals

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
			check
				Never_called: False
			end
		end

	mouse_message_x (lparam: INTEGER): INTEGER is
			-- Encapsulation of the c_mouse_message_x function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not wotk because
			-- it would be implemented by an external.
		do
			Result := c_mouse_message_x (lparam)
		end

	mouse_message_y (lparam: INTEGER): INTEGER is
			-- Encapsulation of the c_mouse_message_x function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not wotk because
			-- it would be implemented by an external.
		do
			Result := c_mouse_message_y (lparam)
		end

	show_window (hwnd: POINTER; cmd_show: INTEGER) is
			-- Encapsulation of the cwin_show_window function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not wotk because
			-- it would be implemented by an external.
		do
			cwin_show_window (hwnd, cmd_show)
		end

end -- class EV_MULTI_COLUMN_LIST_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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
