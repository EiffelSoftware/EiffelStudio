indexing
	description: 
		"EiffelVision tree, Mswindows implementation."
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TREE_IMP

inherit
	EV_TREE_I

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

	EV_TREE_ITEM_HOLDER_IMP
		redefine
			add_item
		end

	WEL_TREE_VIEW
		rename
			make as wel_make,
			parent as wel_parent,
			set_parent as wel_set_parent,
			shown as displayed,
			destroy as wel_destroy,
			font as wel_font,
			set_font as wel_set_font,
			selected_item as wel_selected_item,
			insert_item as wel_insert_item,
			count as total_count
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
			on_char,
			on_key_up,
			on_set_cursor,
			show,
			hide
		redefine
			default_style,
			on_tvn_selchanged,
			on_tvn_itemexpanded
		end

	WEL_TVHT_CONSTANTS
		export
			{NONE} all
		end

	WEL_TVI_CONSTANTS
		export
			{NONE} all
		end

creation
	make

feature {NONE} -- Initialization

	make is
			-- Create a new tree.
		do
			wel_make (default_parent, 0, 0, 0, 0, 0)
			!! ev_children.make (1)
		end

feature -- Access

	count: INTEGER is
			-- Number of direct children of the holder.
		do
			Result := get_children_count (Void)
		end

	ev_children: HASH_TABLE [EV_TREE_ITEM_IMP, POINTER]
			-- Children of the tree Classified by their h_item

	children: ARRAYED_LIST [EV_TREE_ITEM_IMP] is
			-- List of the direct children of the tree.
		do
			Result := get_children (Void)
		end

	selected_item: EV_TREE_ITEM is
			-- Item which is currently selected.
		local
			handle: POINTER
		do
			if selected then
				handle := cwel_integer_to_pointer (cwin_send_message_result (item, Tvm_getnextitem, Tvgn_caret, 0))
				Result ?= (ev_children @ handle).interface
			else
				Result := Void
			end
		end

	find_item_at_position (x_pos, y_pos: INTEGER): EV_TREE_ITEM_IMP is
			-- Find the item at the given position.
			-- Position is relative to the toolbar.
		local
			pt: WEL_POINT
			info: WEL_TV_HITTESTINFO
		do
			create pt.make (x_pos, y_pos)
			create info.make_with_point (pt)
			cwin_send_message (item, Tvm_hittest, 0, info.to_integer)
			if flag_set (info.flags, Tvht_onitemlabel)
			or flag_set (info.flags, Tvht_onitemicon)
			then
				Result := ev_children @ info.hitem
			end
		end

feature -- Element change

	clear_items is
			-- Clear all the items of the list.
		local
			c: ARRAYED_LIST [EV_TREE_ITEM_IMP]
		do
			c := children
			from
				c.start
			until
				c.after
			loop
				delete_item (c.item)
				c.forth
			end
			ev_children.clear_all
		end

feature -- Event : command association

	add_select_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is	
			-- Add `cmd' to the list of commands to be executed
			-- when an item has been selected.
		do
			add_command (Cmd_select, cmd, arg)
		end
	add_unselect_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is	
			-- Add `cmd' to the list of commands to be executed
			-- when an item has been unselected.
		do
			add_command (Cmd_unselect, cmd, arg)
		end

feature -- Event -- removing command association

	remove_select_commands is	
			-- Empty the list of commands to be executed
			-- when an item has been selected.
		do
			remove_command (Cmd_select)
		end

	remove_unselect_commands is	
			-- Empty the list of commands to be executed
			-- when an item has been unselected.
		do
			remove_command (Cmd_unselect)
		end

feature -- Basic operations

	general_insert_item (item_imp: EV_TREE_ITEM_IMP; par, after: POINTER) is
			-- Add `item_imp' to the tree with `par' as parent.
			-- if `par' is the default_pointer, the parent is the tree.
		local
			struct: WEL_TREE_VIEW_INSERT_STRUCT
			c: ARRAYED_LIST [EV_TREE_ITEM_IMP]
			ci: EV_TREE_ITEM_IMP
			bool: BOOLEAN
		do
			-- First, we add the item
			create struct.make
			if par = default_pointer then
				struct.set_root
			else
				struct.set_parent (par)
			end
			struct.set_insert_after (after)
			struct.set_tree_view_item (item_imp)
			wel_insert_item (struct)
			ev_children.force (item_imp, last_item)

			-- Then, we add the subitems if there are some.
			if item_imp.internal_children /= Void then
				c := item_imp.internal_children
				from
					c.start
				until
					c.after
				loop
					general_insert_item (c.item, item_imp.h_item, Tvi_last)
					c.forth
				end
				item_imp.set_internal_children (Void)
			end

			-- Then, we redraw the tree
			invalidate
		end

	general_remove_item (item_imp: EV_TREE_ITEM_IMP) is
			-- Remove the given ite, if it has any children, it store them in
			-- the item.
		local
			c: ARRAYED_LIST [EV_TREE_ITEM_IMP]
			ci: EV_TREE_ITEM_IMP
		do
			if item_imp.is_parent then
				from
					c := get_children (item_imp)
					c.start
				until
					c.after
				loop
					general_remove_item (c.item)
					c.forth
				end
				item_imp.set_internal_children (c)
			end
			ev_children.remove (item_imp.h_item)
			delete_item (item_imp)

			-- Then, we redraw the tree
			invalidate
		end

	get_children (item_imp: EV_TREE_ITEM_IMP): ARRAYED_LIST [EV_TREE_ITEM_IMP] is
			-- List of the direct children of the tree-item.
			-- If the item is Void, it returns the children of the tree.
		local
			handle: INTEGER
			hwnd: POINTER
		do
			create Result.make (1)
			from
				if item_imp = Void then
					handle := cwin_send_message_result (item, Tvm_getnextitem, Tvgn_root, 0)
					hwnd := cwel_integer_to_pointer (handle)
				else
					handle := cwin_send_message_result (item, Tvm_getnextitem, Tvgn_child, cwel_pointer_to_integer (item_imp.h_item))
					hwnd := cwel_integer_to_pointer (handle)
				end
			until
				hwnd = default_pointer
			loop
				Result.extend (ev_children @ hwnd)
				handle := cwin_send_message_result (item, Tvm_getnextitem, Tvgn_next, handle)
				hwnd := cwel_integer_to_pointer (handle)
			end
		end

	get_children_count (item_imp: EV_TREE_ITEM_IMP): INTEGER is
			-- Number of children of the given item.
			-- If the item is Void, it return the children of the tree.
		local
			handle: INTEGER
		do
			from
				if item_imp = Void then
					handle := cwin_send_message_result (item, Tvm_getnextitem, Tvgn_root, 0)
				else
					handle := cwin_send_message_result (item, Tvm_getnextitem, Tvgn_child, cwel_pointer_to_integer (item_imp.h_item))
				end
			until
				handle = 0
			loop
				Result := Result + 1
				handle := cwin_send_message_result (item, Tvm_getnextitem, Tvgn_next, handle)
			end
		end

	internal_get_index (item_imp: EV_TREE_ITEM_IMP): INTEGER is
			-- Find the index fo `item_imp' in his parent.
		local
			handle: INTEGER
			found: BOOLEAN
		do
			from
				if item_imp.parent_imp = Current then
					handle := cwin_send_message_result (item, Tvm_getnextitem, Tvgn_root, 0)
				else
					handle := cwin_send_message_result (item, Tvm_getnextitem, Tvgn_child, cwel_pointer_to_integer (item_imp.h_item))
				end
				Result := -1
			until
				handle = 0 or found
			loop
				Result := Result + 1
				if handle = cwel_pointer_to_integer (item_imp.h_item) then
					found := True
				else
					handle := cwin_send_message_result (item, Tvm_getnextitem, Tvgn_next, handle)
				end
			end
		end

feature {EV_TREE_ITEM_I} -- Implementation

	add_item (item_imp: EV_TREE_ITEM_IMP) is
			-- Add `item_imp' to the list
		do
			general_insert_item (item_imp, default_pointer, Tvi_last)
		end

	insert_item (item_imp: like item_type; index: INTEGER) is
			-- Insert `item_imp' at the `index' position.
		do
			if index = 1 then
				general_insert_item (item_imp, default_pointer, Tvi_first)
			else
				general_insert_item (item_imp, default_pointer, (children @ (index - 1)).h_item)
			end
		end

	remove_item (item_imp: EV_TREE_ITEM_IMP) is
			-- Remove `item_imp' from the children.
		do
			general_remove_item (item_imp)
			invalidate
		end

	notify_item_info (item_imp: EV_TREE_ITEM_IMP) is
			-- Notify the system of the changes of the item.
			-- The item must have all the necessary flags and
			-- informations to notify.
		do
			cwin_send_message (item, Tvm_setitem, 0, item_imp.to_integer) 
		end

feature {NONE} -- WEL Implementation

	default_style: INTEGER is
			-- Default style used to create the control
		do
			Result := Ws_child + Ws_visible + Ws_group
				+ Ws_tabstop + Ws_border + Tvs_haslines
				+ Tvs_hasbuttons + Tvs_linesatroot
				+ Tvs_showselalways
		end

	internal_propagate_event (event_id, x_pos, y_pos: INTEGER; ev_data: EV_BUTTON_EVENT_DATA) is
			-- Propagate `event_id' to the goood item.
		local
			it: EV_TREE_ITEM_IMP
		do
			it := find_item_at_position (x_pos, y_pos)
			if it /= Void then
				it.execute_command (event_id, ev_data)
			end
		end

	on_tvn_selchanged (info: WEL_NM_TREE_VIEW) is
			-- selection has changed from one item to another.
		local
			clist: HASH_TABLE [EV_TREE_ITEM_IMP, POINTER]
			p: POINTER
			elem: EV_TREE_ITEM_IMP
		do
			clist := ev_children
			p := info.old_item.h_item
			if p /= default_pointer then
				elem := clist.item (p)
				if elem /= Void then
					elem.execute_command (Cmd_item_deactivate, Void)
					execute_command (Cmd_unselect, Void)
				end
			end

			p := info.new_item.h_item
			if p /= default_pointer then
				elem := clist.item (p)
				if elem /= Void then
					elem.execute_command (Cmd_item_activate, Void)
					execute_command (Cmd_select, Void)
				end
			end
		end

	on_tvn_itemexpanded (info: WEL_NM_TREE_VIEW) is
			-- a parent item's list of child items has expanded
			-- or collapsed.
		do
			if info.action = Tve_collapse or
				info.action = Tve_expand then
				(ev_children @ info.new_item.h_item).execute_command (Cmd_item_subtree, Void)
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

	on_char (character_code, key_data: INTEGER) is
			-- Wm_char message
			-- Avoid an unconvenient `beep' when the user
			-- tab to another control.
		do
			if not has_focus then
				disable_default_processing
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

end -- class EV_TREE_IMP

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
--|----------------------------------------------------------------
