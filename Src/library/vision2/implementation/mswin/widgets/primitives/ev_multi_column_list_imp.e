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
		redefine
			interface,
			initialize
		end

	EV_PRIMITIVE_IMP
		redefine
			on_left_button_down,
			on_middle_button_down,
			on_right_button_down,
			on_left_button_up,
			on_middle_button_up,
			on_right_button_up,
			on_key_down,
			interface
		end

	EV_ITEM_LIST_IMP [EV_MULTI_COLUMN_LIST_ROW]
		redefine
			interface,
			extend,
			put_front,
			put_right
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
			shown as is_displayed,
			font as wel_font,
			set_font as wel_set_font,
			column_count as columns,
			selected_items as wel_selected_items,
			get_item as wel_get_item,
			insert_item as wel_insert_item,
			set_column_width as wel_set_column_width,
			get_column_width as wel_get_column_width,
			item as wel_item,
			move as move_to,
			enabled as is_sensitive, 
			width as wel_width,
			height as wel_height
		undefine
			remove_command,
			set_width,
			set_height,
			window_process_message,
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
			on_lvn_columnclick,
			on_lvn_itemchanged,
			on_size,
			default_style,
			process_message
		end

	WEL_LVHT_CONSTANTS
		export
			{NONE} all
		end

creation
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
		do
			base_make (an_interface)
			create ev_children.make (0)
			wel_make (default_parent, 0, 0, 0, 0, 0)
		end

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

	last_column_width_setting: INTEGER
		-- The width that the last column was set to by the user.

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
			i: INTEGER
			interf: EV_MULTI_COLUMN_LIST_ROW
			c: ARRAYED_LIST [EV_MULTI_COLUMN_LIST_ROW_IMP]
		do
			from
				c := ev_children
				!! Result.make
				i := 0
			until
				i = selected_count
			loop
				interf ?= (c @ (wel_selected_items @ i + 1)).interface
				Result.extend (interf)
				i := i + 1
			end			
		end

	find_item_at_position (x_pos, y_pos: INTEGER): 
				EV_MULTI_COLUMN_LIST_ROW_IMP is
			-- Find the item at the given position.
			-- Position is relative to the toolbar.
		local
			pt: WEL_POINT
			handle: INTEGER
			info: WEL_LV_HITTESTINFO
		do
			create pt.make (x_pos, y_pos)
			create info.make_with_point (pt)
			cwin_send_message (wel_item, Lvm_hittest, 0, info.to_integer)
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

	multiple_selection_enabled: BOOLEAN is
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

	column_width (column: INTEGER): INTEGER is
			-- Width of the one-based `column'.
		do
			Result := wel_get_column_width (column - 1)
		end
	
	column_title (column: INTEGER): STRING is
			-- Title of the one-based `column'
		local
			c: WEL_LIST_VIEW_COLUMN
		do
			check
				to_be_implemented: False
			end
			--|FIXME This appears to be a bug in WEL.
			--|It appears that the correct parameters are passed.
			create c.make
			cwin_send_message (wel_item, Lvm_getcolumn, column , c.to_integer)
			Result := c.text
		end

feature -- Status setting

	extend (v: like item) is
			-- If `v' not already in list add to end.
			-- Do not move cursor.
		do
			if not first_addition then
				first_addition := True
				set_columns (v.columns)
			end
			{EV_ITEM_LIST_IMP} Precursor (v)
		end

	put_right (v: like item) is
			-- Add `v' to the right of cursor position.
			-- Do not move cursor.
		do
			if not first_addition then
				first_addition := True
				set_columns (v.columns)
			end
			{EV_ITEM_LIST_IMP} Precursor (v)
		end
		
	put_front (v: like item) is
			-- Add `v' to front.
			-- Do not move cursor.
		local
			original_index: INTEGER
		do
			if not first_addition then
				first_addition := True
				set_columns (v.columns)
			end
			{EV_ITEM_LIST_IMP} Precursor (v)
		end


	first_addition: Boolean
		-- Is this the first addition?
		-- We need this, as if set_columns has not already been called then
		-- we must set the number of columns before adding the row.

	set_columns (c: INTEGER)is
			-- Assign `i' to `columns'.
		local
			par_imp: WEL_WINDOW
			a_column: WEL_LIST_VIEW_COLUMN
			i, a_x, a_y, a_width, a_height: INTEGER 
		do
			-- Once the columns have been set, they are fixed.
			-- Therefore, we destroy the old WEL_LIST_VIEW,
			-- and create another with the same information.

			if parent_imp /= Void then
				par_imp ?= parent_imp
			else
				par_imp := default_parent
			end
			a_x := x
			a_y := y
			a_width := width
			a_height := height
				-- Store parent, x, y, width, height
			wel_destroy
				-- Destroy the windows object.
			wel_make (par_imp, a_x, a_y, a_width, a_height, 0)
				-- Create a new windows object with information from
				-- The previous.
			from
				i := 1
			until
				i = c + 1
			loop
				!! a_column.make
				a_column.set_cx (80)
				a_column.set_text ("")
				append_column (a_column)
				i := i + 1
			end
			-- Add columns to the list.
		end


	select_item (an_index: INTEGER) is
			-- Select an item at the one-based `an_index' the list.
		do
			(ev_children @ an_index).enable_select
		end

	deselect_item (an_index: INTEGER) is
			-- Unselect the item at the one-based `an_index'.
		do
			(ev_children @ an_index).disable_select
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
				c.item.disable_select
				c.forth
			end
		end

	enable_multiple_selection is
			-- Allow the user to do a multiple selection simply
			-- by clicking on several choices.
		do
			if not multiple_selection_enabled then
				if has_headers then
					set_style (default_style)
				else
					set_style (default_style + Lvs_nocolumnheader)
				end
			end
		end

	disable_multiple_selection is
			-- Allow the user to do only one selection. It is the
			-- default status of the list
		do
			if multiple_selection_enabled then
				if has_headers then
					set_style (default_style + Lvs_singlesel)
				else
					set_style (default_style + Lvs_singlesel + 
						Lvs_nocolumnheader)
				end
			end
		end

	show_title_row is
			-- Show the row of the titles.
		do
			if not has_headers then
				if multiple_selection_enabled then
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
				if multiple_selection_enabled then
					set_style (default_style + Lvs_nocolumnheader)
				else
					set_style (default_style + Lvs_singlesel + 
						Lvs_nocolumnheader)
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
		local
			counter: INTEGER
			current_width: INTEGER
		do
			if column /= columns then
				wel_set_column_width (value, column - 1)
			else
				last_column_width_setting := value
					-- assign `value' to `last_column_width_setting'
				from
					counter := 1
					current_width := width
				until
					counter = columns
				loop
					current_width := current_width 
						- column_width (counter)
					counter:= counter + 1
				end
				wel_set_column_width (current_width, column - 1)
			end
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
				c.item.interface.destroy
				c.forth
			end
			reset_content
			c.wipe_out
		end

	compute_column_widths is
			-- Re-compute column widths to fill parent.
		local
			current_width: INTEGER
				-- Width of multi column list.
			counter: INTEGER
		do
			current_width := width
				-- assign `width' to `current_width'
			from
				counter := 1
			until
				counter = columns + 1
			loop
				-- For every column in the mc list.
				if counter = columns then
					if current_width > last_column_width_setting then
						wel_set_column_width 
							(current_width, counter - 1)
					elseif current_width < column_width (counter)
						then 
						wel_set_column_width
							(last_column_width_setting, counter - 1)
					end
				end
				current_width := current_width - 
					column_width (counter)
				counter := counter + 1
			end
		end

feature {EV_MULTI_COLUMN_LIST_ROW_I} -- Implementation


	item_type: EV_MULTI_COLUMN_LIST_ROW_IMP is
			-- An empty feature to give a type.
			-- We don't use the genericity because it is
			-- too complicated with the multi-platform design.
			-- Need to be redefined.
		do
		end

	insert_item (item_imp: EV_MULTI_COLUMN_LIST_ROW_IMP; an_index: INTEGER) is
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
				create litem.make_with_attributes (
					Lvif_text, an_index - 1, 0, 0, list.item)
				wel_insert_item (litem)
				list.forth
			until
				list.after
			loop
				create litem.make_with_attributes (
					Lvif_text, an_index - 1, list.index - 1, 0, list.item)
				cwin_send_message (wel_item, Lvm_setitem, 0,
					litem.to_integer)
				list.forth
			end

			-- Then, we update ev_children
			ev_children.go_i_th (an_index - 1)
			ev_children.put_right (item_imp)
		end

	move_item (item_imp: EV_MULTI_COLUMN_LIST_ROW_IMP; an_index: INTEGER) is
			-- Move the given item to the given position.
		local
			bool: BOOLEAN
		do
			bool := item_imp.is_selected
			remove_item (item_imp)
			insert_item (item_imp, an_index)
			if bool then
				item_imp.enable_select
			end
		end

	remove_item (item_imp: EV_MULTI_COLUMN_LIST_ROW_IMP) is
			-- Remove `item' from the list
		local
			an_index: INTEGER
		do
			-- First, we remove the child from the graphical component
			an_index := ev_children.index_of (item_imp, 1) - 1
			delete_item (an_index)

			-- Then, we update the children
			ev_children.go_i_th (an_index + 1)
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
			i: INTEGER
		do
			i := ev_children.index_of (item_imp, 1) - 1
			i := get_item_state (i, Lvis_selected)
			Result := flag_set (i, Lvis_selected)
		end

	internal_select (item_imp: EV_MULTI_COLUMN_LIST_ROW_IMP) is
			-- Select `item_imp' in the list.
		local
			i, flags: INTEGER
			litem: WEL_LIST_VIEW_ITEM
		do
			i := ev_children.index_of (item_imp, 1) - 1
			create litem.make_with_attributes (Lvif_state, i, 0, 0, "")
			litem.set_state (Lvis_selected)
			litem.set_statemask (Lvis_selected)	
			cwin_send_message (wel_item, Lvm_setitemstate, i,
				litem.to_integer)
		end

	internal_deselect (item_imp: EV_MULTI_COLUMN_LIST_ROW_IMP) is
			-- Deselect `item_imp' in the list.
		local
			i, flags: INTEGER
			litem: WEL_LIST_VIEW_ITEM
		do
			i := ev_children.index_of (item_imp, 1) - 1
			create litem.make_with_attributes (Lvif_state, i, 0, 0, "")
			litem.set_state (0)
			litem.set_statemask (Lvis_selected)	
			cwin_send_message (wel_item, Lvm_setitemstate, i,
				litem.to_integer)
		end

feature {NONE} -- WEL Implementation

	process_message (hwnd: POINTER; msg,
			wparam, lparam: INTEGER): INTEGER is
			-- Call the routine `on_*' corresponding to the
			-- message `msg'.
		do
			if msg = Wm_paint then
				compute_column_widths
			else
				Result := {WEL_LIST_VIEW} Precursor (hwnd, msg,
					wparam, lparam)
			end
		end
	
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
			interface.column_click_actions.call ([])
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
				item_imp.interface.select_actions.call ([])
				interface.select_actions.call ([item_imp.interface])
			elseif flag_set(info.uoldstate, Lvis_selected) and
				not flag_set(info.unewstate, Lvis_selected) then
				item_imp := ev_children @ (info.iitem + 1)
				item_imp.interface.deselect_actions.call ([])
				interface.deselect_actions.call ([item_imp.interface])
			end
		end
		end

	on_left_button_down (keys, x_pos, y_pos: INTEGER) is
			-- Wm_lbuttondown message
			-- See class WEL_MK_CONSTANTS for `keys' value
--		local
--			ev_data: EV_BUTTON_EVENT_DATA
		do
--			ev_data := get_button_data (1, keys, x_pos, y_pos)
--			if has_command (Cmd_button_one_press) then
--				execute_command (Cmd_button_one_press, ev_data)
--			end
--			internal_propagate_event 
-- (Cmd_button_one_press, x_pos, y_pos, ev_data)
		end

	on_middle_button_down (keys, x_pos, y_pos: INTEGER) is
			-- Wm_mbuttondown message
			-- See class WEL_MK_CONSTANTS for `keys' value
--		local
--			ev_data: EV_BUTTON_EVENT_DATA
		do
--			ev_data := get_button_data (2, keys, x_pos, y_pos)
--			if has_command (Cmd_button_two_press) then
--				execute_command (Cmd_button_two_press, ev_data)
--			end
--			internal_propagate_event
--		(Cmd_button_two_press, x_pos, y_pos, ev_data)
		end

	on_right_button_down (keys, x_pos, y_pos: INTEGER) is
			-- Wm_rbuttondown message
			-- See class WEL_MK_CONSTANTS for `keys' value
--		local
--			ev_data: EV_BUTTON_EVENT_DATA
		do
--			ev_data := get_button_data (2, keys, x_pos, y_pos)
--			if has_command (Cmd_button_three_press) then
--				execute_command (Cmd_button_three_press, ev_data)
--			end
--			internal_propagate_event
--(Cmd_button_three_press, x_pos, y_pos, ev_data)
--			disable_default_processing
		end

	on_left_button_up (keys, x_pos, y_pos: INTEGER) is
			-- Wm_lbuttonup message
			-- See class WEL_MK_CONSTANTS for `keys' value
--		local
--			ev_data: EV_BUTTON_EVENT_DATA
		do
--			ev_data := get_button_data (1, keys, x_pos, y_pos)
--			if has_command (Cmd_button_one_release) then
--				execute_command (Cmd_button_one_release, ev_data)
--			end
--			internal_propagate_event
--(Cmd_button_one_release, x_pos, y_pos, ev_data)
		end

	on_middle_button_up (keys, x_pos, y_pos: INTEGER) is
			-- Wm_mbuttonup message
			-- See class WEL_MK_CONSTANTS for `keys' value
--		local
--			ev_data: EV_BUTTON_EVENT_DATA
		do
--			ev_data := get_button_data (2, keys, x_pos, y_pos)
--			if has_command (Cmd_button_two_release) then
--				execute_command (Cmd_button_two_release, ev_data)
--			end
--			internal_propagate_event
--(Cmd_button_two_release, x_pos, y_pos, ev_data)
		end

	on_right_button_up (keys, x_pos, y_pos: INTEGER) is
			-- Wm_rbuttonup message
			-- See class WEL_MK_CONSTANTS for `keys' value
--		local
--			ev_data: EV_BUTTON_EVENT_DATA
		do
--			ev_data := get_button_data (3, keys, x_pos, y_pos)
--			if has_command (Cmd_button_three_release) then
--				execute_command (Cmd_button_three_release, ev_data)
--			end
--			internal_propagate_event
--(Cmd_button_three_release, x_pos, y_pos, ev_data)
		end

	on_key_down (virtual_key, key_data: INTEGER) is
			-- A key has been pressed
		do
			{EV_PRIMITIVE_IMP} Precursor (virtual_key, key_data)
			process_tab_key (virtual_key)
		end

	on_size (size_type, a_height, a_width: INTEGER) is
			-- List resized.
		do
			Precursor (size_type, a_height, a_width)
			interface.resize_actions.call ([screen_x, screen_y, a_width, a_height])
		end

feature {EV_PND_TRANSPORTER_IMP}

	child_y (child: EV_MULTI_COLUMN_LIST_ROW_IMP): INTEGER is
			-- `Result' is relative ycoor of row to `parent_imp'
		do
			Result := (top_index - internal_get_index (child)) * 16 
			+ (top_index - internal_get_index (child))
			- window_frame_height
		end

	child_x: INTEGER is
			-- `Result' is relative xcoor of row to `parent_imp'
		do
			Result := window_frame_width - 1
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

feature {NONE}

	interface: EV_MULTI_COLUMN_LIST

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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.48  2000/03/13 22:22:13  rogers
--| Fixed set_columns so if the list does not have a parent and items are added, the default_parent will be used.
--|
--| Revision 1.47  2000/03/07 18:31:37  rogers
--| Redefined on_size from WEL_LIST_VIEW, so the resize_actions can be called.
--|
--| Revision 1.46  2000/03/06 23:29:30  rogers
--| Corrected formatting in set_columns, interface.select_actions and interface.deselect_Actions have been connected. Removed commented out make which is redundent.
--|
--| Revision 1.43  2000/03/06 17:13:33  rogers
--| Added calls to row select and deselect actions. Added call to column_click_actions.
--|
--| Revision 1.42  2000/03/04 00:09:35  rogers
--| Removed commented item, implemented seemingly correct code for column_title which currently does not work. Appears to be a WEL bug.
--|
--| Revision 1.41  2000/03/03 19:33:19  rogers
--| renamed get_column_width -> column_width and changed all internal calls accordingly, added column_title which is still to be implemented.
--|
--| Revision 1.40  2000/03/03 19:10:02  rogers
--| Redefined extend from EV_ITEM_LIST_IMP, added a boolean, first_addition which holds whether the addition is the first addition after creation. Implemented set_columns.
--|
--| Revision 1.38  2000/03/03 00:54:20  brendel
--| set_selected -> en/dis-able_select.
--|
--| Revision 1.37  2000/03/02 22:19:40  brendel
--| is_multiple_selection -> multiple_selection_enabled.
--| Formatted to 80 columns.
--|
--| Revision 1.36  2000/03/02 19:58:16  rogers
--| Renamed set_multiple_selection -> enable_multiple_selection and
--| set_eingle_selection -> disable_multiple_selection.
--|
--| Revision 1.35  2000/02/19 06:34:13  oconnor
--| removed old command stuff
--|
--| Revision 1.34  2000/02/19 05:45:01  oconnor
--| released
--|
--| Revision 1.33  2000/02/14 11:40:44  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.31.4.1.2.8  2000/02/04 19:07:33  rogers
--| Removed a redundent EV_ROUTINE_COMMAND defenition.
--|
--| Revision 1.31.4.1.2.7  2000/02/03 17:20:46  brendel
--| Changed `make_with_size' to `make' in creation clause.
--|
--| Revision 1.31.4.1.2.6  2000/01/29 01:05:03  brendel
--| Tweaked inheritance clause.
--|
--| Revision 1.31.4.1.2.5  2000/01/27 19:30:28  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.31.4.1.2.4  2000/01/25 17:37:53  brendel
--| Removed code associated with old events.
--| Implementation and more removal is needed.
--|
--| Revision 1.31.4.1.2.3  2000/01/19 22:35:45  rogers
--| Removed item as it is now inherited from EV_ITEM_LIST_IMP.
--|
--| Revision 1.31.4.1.2.2  1999/12/17 00:37:46  rogers
--| Altered to fit in with the review branch. Basic alterations, 
--| redefinitaions of name clashes etc. Make now takes an interface
--| Now inherits from EV_ITEM_LIST_IMP.
--|
--| Revision 1.31.4.1.2.1  1999/11/24 17:30:32  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.31.2.2  1999/11/02 17:20:09  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
