--| FIXME NOT_REVIEWED this file has not been reviewed
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

	EV_ITEM_EVENTS_CONSTANTS_IMP
		rename
			command_count as item_event_command_count
		end

	EV_PRIMITIVE_IMP
		undefine
			on_right_button_down,
			on_left_button_down,
			on_middle_button_down,
			on_left_button_up,
			pnd_press
		redefine
			on_mouse_move,
			on_key_down,
			interface,
			initialize
		end

	EV_ARRAYED_LIST_ITEM_HOLDER_IMP [EV_TREE_ITEM]
		undefine
			item_by_data
		redefine
			interface,
			initialize
		end

	WEL_TREE_VIEW
		rename
			make as wel_make,
			parent as wel_parent,
			set_parent as wel_set_parent,
			shown as is_displayed,
			destroy as wel_destroy,
			font as wel_font,
			set_font as wel_set_font,
			selected_item as wel_selected_item,
			insert_item as wel_insert_item,
			count as total_count,
			item as wel_item,
			move as wel_move,
			enabled as is_sensitive, 
			width as wel_width,
			height as wel_height,
			x as x_position,
			y as y_position,
			resize as wel_resize,
			move_and_resize as wel_move_and_resize 
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
			on_tvn_itemexpanded,
			on_size
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

	make (an_interface: like interface) is
			-- Create a new tree.
		do
			base_make (an_interface)
			wel_make (default_parent, 0, 0, 0, 0, 0)
			create ev_children.make (1)
		end

	initialize is
			-- Do post creation initialization.
		do
			{EV_PRIMITIVE_IMP} Precursor
			{EV_ARRAYED_LIST_ITEM_HOLDER_IMP} Precursor
			{EV_TREE_I} Precursor
			create all_ev_children.make (1)

			is_initialized := True
		end

feature -- Access

	all_ev_children: HASH_TABLE [EV_TREE_ITEM_IMP, POINTER]
			-- Children of the tree Classified by their h_item

	ev_children: ARRAYED_LIST [EV_TREE_ITEM_IMP]
			-- List of the direct children of the tree.

	selected_item: EV_TREE_ITEM is
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

	general_insert_item (item_imp: EV_TREE_ITEM_IMP; par, after: POINTER; 
		an_index: INTEGER) is
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

	general_remove_item (item_imp: EV_TREE_ITEM_IMP) is
			-- Remove the given item, if it has any children, it store them in
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
			all_ev_children.remove (item_imp.h_item)
			delete_item (item_imp)
	
				-- Then, we redraw the tree
			invalidate
		end

	get_children (item_imp: EV_TREE_ITEM_IMP): 
	ARRAYED_LIST [EV_TREE_ITEM_IMP] is
			-- List of the direct children of the tree-item.
			-- If the item is Void, it returns the children of the tree.
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

feature {EV_TREE_ITEM_I} -- Implementation

	insert_item (item_imp: EV_TREE_ITEM_IMP; an_index: INTEGER) is
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

	remove_item (item_imp: EV_TREE_ITEM_IMP) is
			-- Remove `item_imp' from the children.
		do
			general_remove_item (item_imp)
					-- Now explicitly remove the item from ev_children
			invalidate
		end

	notify_item_info (item_imp: EV_TREE_ITEM_IMP) is
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

	find_item_at_position (x_pos, y_pos: INTEGER): EV_TREE_ITEM_IMP is
			-- Find the item at the given position.
			-- Position is relative to the toolbar.
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

feature {EV_ANY_I} -- WEL Implementation

	image_list: EV_IMAGE_LIST_IMP
			-- WEL image list to store all images required by items.

	
	setup_image_list is
			-- Create the image list and associate it
			-- to the control if it's not already done.
		do
				-- Create image list with all images 16 by 16 pixels
			create image_list.make_with_size (
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
			-- from the control if it's not already done.
		require
			image_list_not_void: image_list /= Void
		do
				-- Destroy the image list.
			image_list.destroy
			image_list := Void

				-- Remove the image list from the multicolumn list.
			set_image_list (Void)
		ensure
			image_list_is_void: image_list = Void
		end

	internal_propagate_pointer_press (keys, x_pos, y_pos, button: INTEGER) is
			-- Propagate `keys', `x_pos' and `y_pos' to the appropriate item
			-- event.
		local
			it: EV_TREE_ITEM_IMP
			pt: WEL_POINT
			offsets: TUPLE [INTEGER, INTEGER]
		do
			it := find_item_at_position (x_pos, y_pos)
			pt := client_to_screen (x_pos, y_pos)
			if it /= Void and it.is_transport_enabled and
				not parent_is_pnd_source then
				it.pnd_press (x_pos, y_pos, 3, pt.x, pt.y)
			elseif pnd_item_source /= Void then 
				pnd_item_source.pnd_press (x_pos, y_pos, 3, pt.x, pt.y)
			end

			if it /= Void then
				offsets := it.relative_position
				it.interface.pointer_button_press_actions.call
					([x_pos - offsets.integer_arrayed @ 1 + 1,
				y_pos - offsets.integer_arrayed @ 2, button, 0.0, 0.0, 0.0,
				pt.x, pt.y])
			end
		end

	default_style: INTEGER is
			-- Default style used to create the control
		do
			Result := Ws_child + Ws_visible + Ws_group
				+ Ws_tabstop + Ws_border + Tvs_haslines
				+ Tvs_hasbuttons + Tvs_linesatroot
				+ Tvs_showselalways
		end

	on_tvn_selchanged (info: WEL_NM_TREE_VIEW) is
			-- selection has changed from one item to another.
		local
			clist: HASH_TABLE [EV_TREE_ITEM_IMP, POINTER]
			p: POINTER
			elem: EV_TREE_ITEM_IMP
		do
			clist := all_ev_children
			p := info.old_item.h_item
			if p /= default_pointer then
				elem := clist.item (p)
				if elem /= Void then
					elem.interface.deselect_actions.call ([])
					interface.deselect_actions.call ([elem.interface])
				end
			end

			p := info.new_item.h_item
			if p /= default_pointer then
				elem := clist.item (p)
				if elem /= Void then
					elem.interface.select_actions.call ([])
					interface.select_actions.call ([elem.interface])
				end
			end
		end

	on_tvn_itemexpanded (info: WEL_NM_TREE_VIEW) is
			-- a parent item's list of child items has expanded
			-- or collapsed.
		do
			if info.action = Tve_collapse then
				(all_ev_children @ info.new_item.h_item).interface.
					collapse_actions.call ([])
			elseif info.action = Tve_expand then
				(all_ev_children @ info.new_item.h_item).interface.
					expand_actions.call ([])
			end
		end

	on_size (size_type, a_height, a_width: INTEGER) is
			-- List resized.
		do
			interface.resize_actions.call ([screen_x, screen_y, a_width,
				a_height])
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

	on_mouse_move (keys, x_pos, y_pos: INTEGER) is
			-- Executed when the mouse move.
		local
			it: EV_TREE_ITEM_IMP
			pt: WEL_POINT
			offsets: TUPLE [INTEGER, INTEGER]
		do
			it := find_item_at_position (x_pos, y_pos)
			pt := client_to_screen (x_pos, y_pos)
			if it /= Void then
				offsets := it.relative_position
				it.interface.pointer_motion_actions.call (
					[x_pos - offsets.integer_arrayed @ 1 + 1,
				y_pos - offsets.integer_arrayed @ 2, 0.0, 0.0, 0.0, pt.x,
					pt.y])
			end
			if pnd_item_source /= Void then
				pnd_item_source.pnd_motion (x_pos, y_pos, pt.x, pt.y)
			end
			{EV_PRIMITIVE_IMP} Precursor (keys, x_pos, y_pos)
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

feature {EV_ANY_I}

	interface: EV_TREE

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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
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
