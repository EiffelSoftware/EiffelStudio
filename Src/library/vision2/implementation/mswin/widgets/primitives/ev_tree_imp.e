indexing
	description: 
		"Eiffel Vision tree. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TREE_IMP

inherit
	EV_TREE_I
		redefine
			interface,
			initialize,
			pixmaps_size_changed
		end

	EV_PRIMITIVE_IMP
		undefine
			on_right_button_down,
			on_left_button_down,
			on_middle_button_down,
			on_left_button_up,
			on_left_button_double_click,
			on_middle_button_double_click,
			on_right_button_double_click,
			pnd_press,
			escape_pnd
		redefine
			on_mouse_move,
			on_key_down,
			on_char,
			interface,
			initialize
		end

	EV_ITEM_LIST_IMP [EV_TREE_NODE]
		undefine
			item_by_data
		redefine
			interface,
			initialize
		end

	WEL_TREE_VIEW
		rename
			make as wel_make, parent as wel_parent,
			set_parent as wel_set_parent, shown as is_displayed,
			destroy as wel_destroy, font as wel_font,
			set_font as wel_set_font, selected_item as wel_selected_item,
			insert_item as wel_insert_item, count as total_count,
			item as wel_item, move as wel_move, enabled as is_sensitive, 
			width as wel_width, height as wel_height, x as x_position,
			y as y_position, resize as wel_resize,
			move_and_resize as wel_move_and_resize,
			has_capture as wel_has_capture,
			set_tooltip as wel_set_tooltip
		undefine
			set_width, set_height, on_left_button_down,
			on_middle_button_down, on_right_button_down,
			on_left_button_up, on_middle_button_up,
			on_right_button_up, on_left_button_double_click,
			on_middle_button_double_click, on_right_button_double_click,
			on_mouse_move, on_set_focus, on_kill_focus,
			on_desactivate, on_key_down, on_char, on_key_up,
			on_set_cursor, show, hide, on_size, x_position, y_position,
			on_sys_key_down, default_process_message, on_sys_key_up
		redefine
			default_style, on_tvn_selchanged, on_tvn_itemexpanded,
			on_tvn_selchanging, on_erase_background, collapse_item,
			expand_item
		end

	WEL_TVHT_CONSTANTS
		export
			{NONE} all
		end

	WEL_TVI_CONSTANTS
		export
			{NONE} all
		end

	WEL_TVAF_CONSTANTS
		export
			{NONE} all
		end
	
	EV_SHARED_IMAGE_LIST_IMP
		export
			{NONE} all
		end

	EV_TREE_ACTION_SEQUENCES_IMP

creation
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create `Current' with interface `an_interface'.
		do
			base_make (an_interface)
			wel_make (default_parent, 0, 0, 0, 0, 0)
			create ev_children.make (1)
		end

	initialize is
			-- Do post creation initialization.
		do
			Precursor {EV_PRIMITIVE_IMP}
			Precursor {EV_ITEM_LIST_IMP}
			Precursor {EV_TREE_I}
			create all_ev_children.make (1)

			is_initialized := True
		end

feature -- Access

	all_ev_children: HASH_TABLE [EV_TREE_NODE_IMP, POINTER]
			-- Children of `Current' Classified by their h_item

	ev_children: ARRAYED_LIST [EV_TREE_NODE_IMP]
			-- List of the direct children of `Current'.

	selected_item: EV_TREE_NODE is
			-- Currently selected item.
		local
			handle: POINTER
		do
			if selected then
				handle := cwel_integer_to_pointer (cwin_send_message_result 
				(wel_item, Tvm_getnextitem, Tvgn_caret, 0))
				Result ?= (all_ev_children @ handle).interface
			else
				Result := Void
			end
		end

feature -- Basic operations

	general_insert_item (item_imp: EV_TREE_NODE_IMP; par, after: POINTER; 
		an_index: INTEGER) is
			-- Add `item_imp' to the tree with `par' as parent.
			-- if `par' is the default_pointer, the parent is the tree.
		local
			struct: WEL_TREE_VIEW_INSERT_STRUCT
			c: ARRAYED_LIST [EV_TREE_NODE_IMP]
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
			all_ev_children.force (item_imp, last_item)

				-- Then, we add the subitems if there are some.
			if item_imp.internal_children /= Void then
				c := item_imp.internal_children
				from
					c.start
				until
					c.after
				loop
					general_insert_item (c.item, item_imp.h_item, Tvi_last,
					an_index)
					c.forth
				end
				item_imp.set_internal_children (Void)
			end

				-- Then, we redraw the tree
			invalidate
		end

	general_remove_item (item_imp: EV_TREE_NODE_IMP) is
			-- Remove `item_imp' from `Current'.
		local
			c: ARRAYED_LIST [EV_TREE_NODE_IMP]
		do
			removing_item := True
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
			all_ev_children.remove (item_imp.h_item)
			delete_item (item_imp)
	
				-- Then, we redraw the tree
			invalidate
			removing_item := False
		end

	get_children (item_imp: EV_TREE_NODE_IMP): 
		ARRAYED_LIST [EV_TREE_NODE_IMP] is
			-- List of the direct children of `item_imp'.
			-- If the `item_imp' is Void, it returns the children of the tree.
		local
			handle: INTEGER
			hwnd: POINTER
		do
			create Result.make (1)
			from
				if item_imp = Void then
					handle := cwin_send_message_result (
					wel_item, Tvm_getnextitem, Tvgn_root, 0)
					hwnd := cwel_integer_to_pointer (handle)
				else
					handle := cwin_send_message_result (
						wel_item, Tvm_getnextitem, Tvgn_child,
						cwel_pointer_to_integer (item_imp.h_item))
					hwnd := cwel_integer_to_pointer (handle)
				end
			until
				hwnd = default_pointer
			loop
				Result.extend (all_ev_children @ hwnd)
				handle := cwin_send_message_result (wel_item,
					Tvm_getnextitem, Tvgn_next, handle)
				hwnd := cwel_integer_to_pointer (handle)
			end
		end

feature {EV_TREE_NODE_I} -- Implementation

	insert_item (item_imp: EV_TREE_NODE_IMP; an_index: INTEGER) is
			-- Insert `item_imp' at the `an_index' position.
		do
			if an_index = 1 then
				general_insert_item (item_imp, default_pointer,
					Tvi_first, an_index)
			else
				general_insert_item (item_imp, default_pointer,
					(ev_children @ (an_index - 1)).h_item, an_index)
			end
		end

	remove_item (item_imp: EV_TREE_NODE_IMP) is
			-- Remove `item_imp' from `Current'.
		do
			general_remove_item (item_imp)
					-- Now explicitly remove the item from ev_children
			invalidate
		end

	notify_item_info (item_imp: EV_TREE_NODE_IMP) is
			-- Notify the system of the changes of the item.
			-- The item must have all the necessary flags and
			-- informations to notify.
		do
			cwin_send_message (wel_item, Tvm_setitem, 0, item_imp.to_integer) 
		end

feature {EV_ANY_I} -- Implementation

	pixmaps_size_changed is
			-- The size of the displayed pixmaps has just
			-- changed.
		do
			if image_list /= Void then
				general_reset_pixmap
			end
		end

	general_reset_pixmap is
			-- Reset the pixmap (if the size of displayed has
			-- changes for example)
		local	
			c: like ev_children
		do
			remove_image_list
			setup_image_list

			c := ev_children
			from
				c.start
			until
				c.after
			loop
				c.item.general_reset_pixmap
				c.forth
			end
		end

	find_item_at_position (x_pos, y_pos: INTEGER): EV_TREE_NODE_IMP is
			-- Find the item at `x_pos', `y_pos' pixel coordinates
			-- within `Current' (Origin of coordinates is top left).
		local
			pt: WEL_POINT
			info: WEL_TV_HITTESTINFO
		do
			create pt.make (x_pos, y_pos)
			create info.make_with_point (pt)
			cwin_send_message (wel_item, Tvm_hittest, 0, info.to_integer)
			if flag_set (info.flags, Tvht_onitemlabel)
			or flag_set (info.flags, Tvht_onitemicon)
			then
				Result := all_ev_children @ info.hitem
			end
		end

feature {NONE} -- Implementation

		-- This is assigned `True' at the start of general_remove_item, and
		-- assigned `False' at the end. When removing a selected item, Windows
		-- automatically selects the next item. If we override
		-- on_tvn_selchanging when `removing_item' is `True' then this stops the
		-- selections occuring and matches GTk's behaviour.
	removing_item: BOOLEAN

feature {EV_ANY_I} -- WEL Implementation

	image_list: EV_IMAGE_LIST_IMP
			-- WEL image list to store all images required by items.

	setup_image_list is
			-- Create the image list and associate it
			-- to `Current' if it's not already done.
		do
				-- Create image list with all images 16 by 16 pixels
			image_list := get_imagelist_with_size (
				pixmaps_width, 
				pixmaps_height
				)

				-- Associate the image list with the tree.
			set_image_list (image_list)
		ensure
			image_list_not_void: image_list /= Void
		end

	remove_image_list is
			-- Destroy the image list and remove it
			-- from `Current' if it's not already done.
		require
			image_list_not_void: image_list /= Void
		do
				-- Remove the image list.
			destroy_imagelist (image_list)
			image_list := Void

				-- Remove the image list from the multicolumn list.
			set_image_list (Void)
		ensure
			image_list_is_void: image_list = Void
		end

	internal_propagate_pointer_press (keys, x_pos, y_pos, button: INTEGER) is
			-- Propagate `keys', `x_pos' and `y_pos' to the appropriate item
			-- event. Called on a pointer button press.
		local
			pre_drop_it, post_drop_it: EV_TREE_NODE_IMP
			pt: WEL_POINT
			offsets: TUPLE [INTEGER, INTEGER]
			item_press_actions_called: BOOLEAN
		do
			pre_drop_it := find_item_at_position (x_pos, y_pos)
			pt := client_to_screen (x_pos, y_pos)

			if pre_drop_it /= Void and not transport_executing
				and not item_is_in_pnd then
				if pre_drop_it.pointer_button_press_actions_internal
					/= Void then
					offsets := pre_drop_it.relative_position
					pre_drop_it.pointer_button_press_actions.call
					([x_pos - offsets.integer_arrayed @ 1 + 1,
					y_pos - offsets.integer_arrayed @ 2, button, 0.0, 0.0, 0.0,
					pt.x, pt.y])
				end
					-- We record that the press actions have been called.
				item_press_actions_called := True
			end
				--| The pre_drop_it.parent /= Void is to check that the item that
				--| was originally clicked on, has not been removed during the press actions.
				--| If the parent is now void then it has, and there is no need to continue
				--| with `pnd_press'.
			if pre_drop_it /= Void and pre_drop_it.is_transport_enabled and
				not parent_is_pnd_source and pre_drop_it.parent /= Void then
				pre_drop_it.pnd_press (x_pos, y_pos, button, pt.x, pt.y)
			elseif pnd_item_source /= Void then 
				pnd_item_source.pnd_press (x_pos, y_pos, button, pt.x, pt.y)
			end

			if item_is_pnd_source_at_entry = item_is_pnd_source then
				pnd_press (x_pos, y_pos, button, pt.x, pt.y)
			end

			if not press_actions_called and call_press_event then
				interface.pointer_button_press_actions.call
					([x_pos, y_pos, button, 0.0, 0.0, 0.0, pt.x, pt.y])
			end

			post_drop_it := find_item_at_position (x_pos, y_pos)

				-- If there is an item where the button press was recieved,
				-- and it has not changed from the start of this procedure
				-- then call `pointer_button_press_actions'. 
				--| Internal_propagate_pointer_press in EV_MULTI_COLUMN_LIST_IMP
				--| has a fuller explanation.
			if not item_press_actions_called then
				if post_drop_it /= Void and pre_drop_it = post_drop_it and call_press_event then
					offsets := post_drop_it.relative_position
					post_drop_it.pointer_button_press_actions.call
						([x_pos - offsets.integer_arrayed @ 1 + 1,
						y_pos - offsets.integer_arrayed @ 2, button, 0.0, 0.0,
						0.0, pt.x, pt.y])
				end
			end
				-- Reset `call_press_event'.
			keep_press_event
		end

	internal_propagate_pointer_double_press
		(keys, x_pos, y_pos, button: INTEGER) is
			-- Propagate `keys', `x_pos' and `y_pos' to the appropriate item
			-- event. Called on a pointer button double press.
		local
			it: EV_TREE_NODE_IMP
			pt: WEL_POINT
			offsets: TUPLE [INTEGER, INTEGER]
		do
			it := find_item_at_position (x_pos, y_pos)
			pt := client_to_screen (x_pos, y_pos)
			if it /= Void then
				offsets := it.relative_position
				it.pointer_double_press_actions.call
					([x_pos - offsets.integer_arrayed @ 1 + 1,
					y_pos - offsets.integer_arrayed @ 2, button, 0.0, 0.0, 0.0,
					pt.x, pt.y])
			end
		end


	default_style: INTEGER is
			-- Default style used to create `Current'
		do
			Result := Ws_child + Ws_visible + Ws_group
				+ Ws_tabstop + Ws_border + Tvs_haslines
				+ Tvs_hasbuttons + Tvs_linesatroot
				+ Tvs_showselalways + Tvs_infotip
		end

	on_tvn_selchanging (info: WEL_NM_TREE_VIEW) is
		do
				-- If we are removing the selected item then we set the return
				-- value to 1 (True) which stops windows from selecting the next
				-- item in `Current'.
			if removing_item then
				wel_parent.set_message_return_value (1)
			end
		end

	on_tvn_selchanged (info: WEL_NM_TREE_VIEW) is
			-- Selection has changed from one item to another.
		local
			clist: HASH_TABLE [EV_TREE_NODE_IMP, POINTER]
			p: POINTER
			elem: EV_TREE_NODE_IMP
		do
			clist := all_ev_children

			p := info.old_item.h_item
			if p /= default_pointer then
				elem := clist.item (p)
				if elem /= Void then
						-- Call the deselect actions on `elem'.
					elem.deselect_actions.call ([])
					deselect_actions.call ([elem.interface])
				end
			end

			p := info.new_item.h_item
			if p /= default_pointer then
				elem := clist.item (p)
				if elem /= Void then
						-- Call the select_actions on `elem'.
					elem.select_actions.call ([])
					select_actions.call ([elem.interface])
				end
			end
		end

	expand_called_manually: BOOLEAN
		-- Are we within `expand_item' or `collapse_item'?
		--| This is used to stop on_tvn_itemexpanded calling `expand_actions'
		--| or `collapse_actions' again when the notification is generated by
		--| a call from `expand_item' or `collapse_item'.
		--| When we call Tvm_Expand on an item,
		--| the TVIS_EXPANDEDONCE state flag is set which stops
		--| on_tvn_item_expanded notifications being generated again.
		--| Could not find an easy way to fix this, so this is why this
		--| boolean is required and the redefinitions of `expand_item'
		--| and `collapse_item'. If this was not the case then we could
		--| simply always use the tvn_itemexpanded notification with no
		--| redefinition of `expand_item' or `collapse_item'.
		--|See Tvm_expand in MSDN for better explanation. Julian.

	expand_item (an_item: WEL_TREE_VIEW_ITEM) is
			-- Expand the given item.
			--| Set `expand_called_manually' to true for duration of this
			--| feature. See comment for `expand_called_manually'.
		local
			tree_item: EV_TREE_NODE_IMP
		do
			expand_called_manually := True
			tree_item ?= an_item
			if not is_expanded (tree_item) then
				cwin_send_message (wel_item, Tvm_expand, Tve_expand,
					cwel_pointer_to_integer (an_item.h_item))
				tree_item.interface.expand_actions.call ([])
			end
			expand_called_manually := False
		end

	collapse_item (an_item: WEL_TREE_VIEW_ITEM) is
			-- Collapse the given item.
			--| Set `expand_called_manually' to true for duration of this
			--| feature. See comment for `expand_called_manually'.
		local
			tree_item: EV_TREE_NODE_IMP
		do
			expand_called_manually := True
			tree_item ?= an_item
			if is_expanded (tree_item) then
				cwin_send_message (wel_item, Tvm_expand, Tve_collapse,
					cwel_pointer_to_integer (an_item.h_item))
				tree_item.interface.collapse_actions.call ([])
			end
			expand_called_manually := False
		end


	on_tvn_itemexpanded (info: WEL_NM_TREE_VIEW) is
			-- a parent item's list of child items has expanded
			-- or collapsed.
		do
			if not expand_called_manually then
				if info.action = Tve_collapse then
					(all_ev_children @ info.new_item.h_item).interface.
						collapse_actions.call ([])
				elseif info.action = Tve_expand then
					(all_ev_children @ info.new_item.h_item).interface.
						expand_actions.call ([])
				end
			end
		end

	on_key_down (virtual_key, key_data: INTEGER) is
			-- A key has been pressed.
		do
			process_tab_key (virtual_key)
			Precursor {EV_PRIMITIVE_IMP} (virtual_key, key_data)
		end

	on_char (character_code, key_data: INTEGER) is
			-- Wm_char message
			-- Avoid an unconvenient `beep' when the user
			-- tab to another control.
		do
			Precursor {EV_PRIMITIVE_IMP} (character_code, key_data)
			if not has_focus then
				disable_default_processing
			end
		end

	on_mouse_move (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the mouse move.
		local
			it: EV_TREE_NODE_IMP
			pt: WEL_POINT
			offsets: TUPLE [INTEGER, INTEGER]
		do
			it := find_item_at_position (x_pos, y_pos)
			pt := client_to_screen (x_pos, y_pos)
			if it /= Void then
				offsets := it.relative_position
				it.pointer_motion_actions.call (
					[x_pos - offsets.integer_arrayed @ 1 + 1,
				y_pos - offsets.integer_arrayed @ 2, 0.0, 0.0, 0.0, pt.x,
					pt.y])
			end
			if pnd_item_source /= Void then
				pnd_item_source.pnd_motion (x_pos, y_pos, pt.x, pt.y)
			end
			Precursor {EV_PRIMITIVE_IMP} (keys, x_pos, y_pos)
		end

	on_erase_background (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- Wm_erasebkgnd message.
			-- May be redefined to paint something on
			-- the `paint_dc'. `invalid_rect' defines
			-- the invalid rectangle of the client area that
			-- needs to be repainted.
		do
			disable_default_processing
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
			-- c_mouse_message_x deferred but it does not work because
			-- it would be implemented by an external.
		do
			Result := c_mouse_message_x (lparam)
		end

	mouse_message_y (lparam: INTEGER): INTEGER is
			-- Encapsulation of the c_mouse_message_x function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not work because
			-- it would be implemented by an external.
		do
			Result := c_mouse_message_y (lparam)
		end

	show_window (hwnd: POINTER; cmd_show: INTEGER) is
			-- Encapsulation of the cwin_show_window function of
			-- WEL_WINDOW. Normaly, we should be able to have directly
			-- c_mouse_message_x deferred but it does not work because
			-- it would be implemented by an external.
		do
			cwin_show_window (hwnd, cmd_show)
		end

feature {EV_ANY_I}

	interface: EV_TREE

end -- class EV_TREE_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision: library of reusable components for ISE Eiffel.
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
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.72  2001/06/14 00:09:14  rogers
--| Undefined the version of escape_pnd inherited from EV_PRIMITIVE_IMP.
--|
--| Revision 1.71  2001/06/07 23:08:17  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.32.4.38  2001/02/19 19:25:30  rogers
--| Renamed removing_selected_item to removing_item. Modified the timing of
--| setting this variable. This fixes a bug where selecting an item, calling
--| wipe_out, rebuilding the tree, and then selecting an item would select the
--| first item in the tree, not the one clicked on. Improved comments.
--|
--| Revision 1.32.4.37  2001/02/14 23:57:06  rogers
--| Fixed bug in internal_propagate_pointer_press. We now check that
--| `pre_drop_it' is still parented before calling `pnd_press' on
--| `pre_drop_it'. This is because a button press can cause the item to be
--| removed.
--|
--| Revision 1.32.4.36  2001/02/02 00:47:24  rogers
--| On_key_down now calls process_tab_key before Precursor. This ensures that
--| any tab movement we do in our implementation can be overriden by the user
--| with key_press_actions.
--|
--| Revision 1.32.4.35  2001/01/26 23:18:18  rogers
--| Undefined on_sys_key_down inherited from WEL.
--|
--| Revision 1.32.4.34  2001/01/09 19:07:06  rogers
--| Undefined default_process_message from WEL.
--|
--| Revision 1.32.4.33  2000/12/29 00:43:56  rogers
--| Internal_propagate_pointer_press now only calls the
--| pointer_button_press_actions if a pnd is running if `call_press_events'.
--|
--| Revision 1.32.4.32  2000/12/19 01:27:07  rogers
--| Renamed set_tooltip inherited from wel_tree_view as wel_set_tooltip.
--|
--| Revision 1.32.4.30  2000/11/09 16:50:45  pichery
--| - Added shared imagelist.
--| - Cosmetics
--|
--| Revision 1.32.4.29  2000/11/06 20:05:53  rogers
--| Added Tvs_infotip to default_style. This causes a tooltip to be displayed
--| if the text of an item cannot be viewed completely in the tree.
--|
--| Revision 1.32.4.27  2000/10/25 23:26:50  rogers
--| Modified internal_propagate_pointer_press so that the button press
--| events are recieved in the correct order in conjunction with the
--| pick/drag and drop. Correct order is before when starting a pick and after
--| when ending a pick.
--|
--| Revision 1.32.4.26  2000/10/24 20:15:01  rogers
--| Fixed bug in internal_propagate_pointer_pree if you were in PND and had
--| dropped on an item and removed that item from `Current' in the drop
--| actions.
--|
--| Revision 1.32.4.25  2000/10/17 23:57:58  rogers
--| Corrected typo in create button1
--|
--| Revision 1.32.4.24  2000/10/17 23:42:06  rogers
--| On_char now calls precursor which calls key_press_string_actions correctly.
--|
--| Revision 1.32.4.23  2000/10/11 00:01:49  raphaels
--| Added `on_desactivate' to list of undefined features from WEL_WINDOW.
--|
--| Revision 1.32.4.22  2000/10/04 22:44:32  rogers
--| Redefined expand_item and collapse_item to fix bug in calling of items
--| expand and collapse action sequences. See comment for
--| `expand_called_manually' for further explanation.
--|
--| Revision 1.32.4.21  2000/09/13 22:09:20  rogers
--| Changed the style of Precursor.
--|
--| Revision 1.32.4.20  2000/09/08 00:00:26  manus
--| Removed tree view flickering when resizing them.
--|
--| Revision 1.32.4.19  2000/08/11 18:29:32  rogers
--| Fixed copyright clauses. Now use ! instead of |.
--|
--| Revision 1.32.4.18  2000/08/10 17:05:02  rogers
--| Fixed bug in general_remove_item. Whenever an item contained in `Current'
--| is removed, then removing_selected_item will be assigned `True', and
--| the select/deselect actions will never be called.
--|
--| Revision 1.32.4.17  2000/08/09 21:21:40  rogers
--| Redefined on_tvn_selchanging. Added removing_selected_item to hold whether
--| the selected item is being removed. This fixes a bug in the behaviour
--| when the selected item is removed. No item is now automatically selected,
--| and the deselect actions are no longer called. The behaviour is now
--| identical on both platforms.
--|
--| Revision 1.32.4.16  2000/08/08 02:42:14  manus
--| Updated inheritance with new WEL messages handling
--|
--| Revision 1.32.4.15  2000/08/02 22:49:31  rogers
--| Changed inheritance from EV_ARRAYED_LIST_ITEM_HOLDER_IMP [EV_TREE_NODE] to
--| EV_ITEM_LIST_IMP [EV_TREE_NODE]. Precursor call in initialize now
--| reflects this change.
--|
--| Revision 1.32.4.14  2000/07/26 22:34:12  rogers
--| All action sequences are no longer called through the interface.
--| Internal_propagate_pointer_double_press has been fixed. It now calls the
--| correct action sequence.
--|
--| Revision 1.32.4.13  2000/07/24 23:19:41  rogers
--| Now inherits EV_TREE_ACTION_SEQUENCES_IMP.
--|
--| Revision 1.32.4.12  2000/07/21 20:10:29  rogers
--| Undone previous commit changes. Please ignore last commit log.
--|
--| Revision 1.32.4.11  2000/07/21 19:37:17  rogers
--| Removed redefined destroy as it is no longer necessary.
--|
--| Revision 1.32.4.10  2000/07/12 16:03:55  rogers
--| Undefined x_position and y_position from WEL, as they are now inherited
--| from EV_WIDGET_IMP.
--|
--| Revision 1.32.4.9  2000/06/19 21:14:07  rogers
--| Removed inheritance from EV_ITEM_EVENTS_CONSTANTS. Removed FIXME
--| NOT_REVIEWED. Comments, formatting.
--|
--| Revision 1.32.4.8  2000/06/13 18:34:08  rogers
--| Removed undefintion of remove_command and renaming of command_count.
--|
--| Revision 1.32.4.7  2000/06/09 20:57:02  manus
--| Removed useless undefinition of `on_size'
--|
--| Revision 1.32.4.6  2000/06/09 20:16:54  rogers
--| Added internal_propagate_pointer_double_press. Comments. Formatting.
--|
--| Revision 1.32.4.5  2000/05/27 01:55:52  pichery
--| Cosmetics
--|
--| Revision 1.32.4.4  2000/05/16 20:19:46  king
--| Converted to new tree item structure
--|
--| Revision 1.32.4.3  2000/05/04 18:35:31  rogers
--| Internal_propagate_pointer_press now passes the correct button to
--| the child when a child is clicked on. This fixes a bug where all
--| presses acted as a right click.
--|
--| Revision 1.32.4.2  2000/05/03 22:35:05  brendel
--| Fixed resize_actions.
--|
--| Revision 1.32.4.1  2000/05/03 19:09:51  oconnor
--| mergred from HEAD
--|
--| Revision 1.68  2000/04/27 23:14:20  rogers
--| Undefined on_left_button_up from EV_PRIMITIVE_IMP.
--|
--| Revision 1.67  2000/04/26 00:03:12  pichery
--| Slight redesign of the pixmap handling in
--| trees and multi-column lists.
--|
--| Added `set_pixmaps_size', `pixmaps_width'
--| and `pixmaps_height' in the interfaces and
--| in the implementations.
--|
--| Fixed bugs in multi-column lists and trees.
--|
--| Revision 1.66  2000/04/25 01:23:47  pichery
--| Changed pixmap handling.
--|
--| Revision 1.65  2000/04/17 17:30:26  rogers
--| Added wel_window_parent fix.
--|
--| Revision 1.64  2000/04/11 19:02:32  rogers
--| Insert_item and remove_item no longer directly modify ev_children.
--|
--| Revision 1.63  2000/04/11 16:56:50  rogers
--| Removed direct inheritance from EV_PICK_AND_DROPABLE_ITEM_HOLDER_IMP.
--|
--| Revision 1.62  2000/04/10 18:31:59  brendel
--| Modified creation sequence.
--|
--| Revision 1.61  2000/04/05 21:16:13  brendel
--| Merged changes from LIST_REFACTOR_BRANCH.
--|
--| Revision 1.60  2000/03/31 00:24:51  rogers
--| Removed on_left_button_down, on_middle_button_down and
--| on_right_button_down as they are now inherited from
--| EV_PICK_AND_DROPABLE_ITEM_HOLDER_IMP
--|
--| Revision 1.59  2000/03/30 19:59:13  rogers
--| Removed commented pnd_press.
--|
--| Revision 1.57.2.1  2000/04/03 18:25:35  brendel
--| Count is now implemented in EV_DYNAMIC_LIST_IMP.
--|
--| Revision 1.57  2000/03/28 01:33:32  rogers
--| Formatting.
--|
--| Revision 1.56  2000/03/28 01:11:47  rogers
--| Added reduce_image_list_references.
--|
--| Revision 1.55  2000/03/27 17:35:03  rogers
--| Renamed current_image_list_images -> current_image_list_info, which now
--| stores a tuple which contains the position in the image list and the 
--|number of items referencing this image in the tree.
--|
--| Revision 1.54  2000/03/24 19:14:11  rogers
--| Redefined initialize from EV_ARRAYED_LIST_ITEM_HOLDER_IMP.
--|
--| Revision 1.53  2000/03/24 17:14:22  rogers
--| Added creation of current_image_list_images.
--|
--| Revision 1.52  2000/03/24 00:19:34  rogers
--| Added initialize which creates and sets the image list of the tree.
--| Added image_list and current_image_list which is a record of images in
--| the list.
--|
--| Revision 1.51  2000/03/22 20:18:53  rogers
--| Added pnd_press, added functions relating to PND status of object and
--| children.Not complete implementation of PND so more work needs to be
--| undertaken.
--|
--| Revision 1.50  2000/03/14 18:39:12  rogers
--| Renamed
--| 	move -> wel_move
--| 	x -> x_position
--| 	y -> y_position
--| 	resize -> wel_resize
--| 	move_and_resize -> wel_move_and_resize
--|
--| Revision 1.49  2000/03/13 22:39:03  rogers
--| Moved the client_to_screen feature call to within the if statement in
--| on_mouse_move.
--|
--| Revision 1.48  2000/03/13 20:50:03  rogers
--| Tree item's events now are called with the relative x and relative y
--| positions instead of 0 0..
--|
--| Revision 1.47  2000/03/13 18:30:56  rogers
--| Removed old command association. Connected the select, deselect,
--| collapse and expand events to the tree, and also propogated them to the
--| items of the tree.
--|
--| Revision 1.46  2000/03/13 17:55:41  rogers
--| Redefined on_mouse_move so the pointer_motion_actions can be called on
--| the child.
--|
--| Revision 1.45  2000/03/13 17:45:46  rogers
--| Removed on_left_button_up, on_middle_button_up and on_right_button_up.
--| Added internal propogate_pointer_press and find_item_at position.
--|
--| Revision 1.44  2000/03/09 19:59:02  rogers
--| Removed multiple selection features.
--|
--| Revision 1.42  2000/03/09 16:44:23  rogers
--| Connected the addition and removal of ev_children directly now.
--|
--| Revision 1.40  2000/03/07 17:34:47  rogers
--| Now inherits from EV_ARRAYED_LIST_ITEM_HOLDER_IMP [EV_TREE_ITEM] instead 
--| of EV_TREE_ITEM_HOLDER_IMP. Reference to item_type replaced 
--| with EV_TREE_ITEM_IMP.
--|
--| Revision 1.39  2000/03/06 20:46:07  rogers
--| Corrected reference from index -> an_index in insert_item.
--|
--| Revision 1.38  2000/03/06 19:09:07  rogers
--| Added selected_items, enable_multiple_selection, 
--| disable_multiple_selection and multiple_selection_enabled.
--| All these are to be implemented.
--|
--| Revision 1.37  2000/03/01 18:09:23  oconnor
--| released
--|
--| Revision 1.36  2000/02/19 07:49:45  oconnor
--| unreleased
--|
--| Revision 1.35  2000/02/19 06:34:13  oconnor
--| removed old command stuff
--|
--| Revision 1.34  2000/02/19 05:45:01  oconnor
--| released
--|
--| Revision 1.33  2000/02/14 11:40:45  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.32.6.6  2000/01/29 01:05:04  brendel
--| Tweaked inheritance clause.
--|
--| Revision 1.32.6.5  2000/01/27 19:30:30  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.32.6.4  2000/01/25 17:37:53  brendel
--| Removed code associated with old events.
--| Implementation and more removal is needed.
--|
--| Revision 1.32.6.3  1999/12/17 21:22:18  rogers
--| Interface as now exported to EV_ANY_I.
--|
--| Revision 1.32.6.2  1999/12/17 00:22:47  rogers
--| Altered to fit in with the review branch. Make now takes an interface.
--|
--| Revision 1.32.6.1  1999/11/24 17:30:35  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.32.2.2  1999/11/02 17:20:10  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
