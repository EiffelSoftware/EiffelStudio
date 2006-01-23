indexing
	description: 
		"Eiffel Vision tree. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TREE_IMP

inherit
	EV_TREE_I
		redefine
			interface,
			initialize
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
			initialize,
			set_background_color,
			set_foreground_color,
			background_color,
			destroy
		end

	EV_ITEM_LIST_IMP [EV_TREE_NODE, EV_TREE_NODE_IMP]
		undefine
			item_by_data
		redefine
			interface,
			initialize
		end
		
	EV_PICK_AND_DROPABLE_ITEM_HOLDER_IMP
		redefine
			interface
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
			set_tooltip as wel_set_tooltip,
			set_background_color as wel_set_background_color
		undefine
			set_width, set_height, on_left_button_down,
			on_middle_button_down, on_right_button_down,
			on_left_button_up, on_middle_button_up,
			on_right_button_up, on_left_button_double_click,
			on_middle_button_double_click, on_right_button_double_click,
			on_mouse_move, on_set_focus, on_kill_focus,
			on_desactivate, on_key_down, on_char, on_key_up,
			on_set_cursor, show, hide, on_size, x_position, y_position,
			on_sys_key_down, default_process_message, on_sys_key_up,
			on_mouse_wheel, on_getdlgcode
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

create
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

			set_is_initialized (True)
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
				handle := cwin_send_message_result (wel_item, Tvm_getnextitem,
					to_wparam (Tvgn_caret), to_lparam (0))
				Result ?= (all_ev_children @ handle).interface
			else
				Result := Void
			end
		end
		
	selected_item_imp: EV_TREE_NODE_IMP is
			-- Currently selected_item_imp.
			-- Added for speed, if we did not have this,
			-- then we would have to do another reverse assigment
			-- after `selected_item' to get the _IMP.
		local
			handle: POINTER
		do
			if selected then
				handle := cwin_send_message_result (wel_item, Tvm_getnextitem,
					to_wparam (Tvgn_caret), to_lparam (0))
				Result ?= all_ev_children @ handle
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
				if item_imp.top_parent_imp /= Void then
					item_imp.set_internal_children (Void)
				end
			end

				-- Then, we redraw the tree
			invalidate
		end
		
	general_remove_item (item_imp: EV_TREE_NODE_IMP) is
			-- Remove `item_imp' from `Current'.
		do
			internal_general_remove_item (item_imp, 0)
		end
		

	internal_general_remove_item (item_imp: EV_TREE_NODE_IMP; depth: INTEGER;) is
			-- Remove `item_imp' from `Current'.
			-- This should only be called by `internal_remove_item'.
			-- We need to track `depth' so that we only assign `False'
			-- to `removing_item' when we return from the top level of the recursion.
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
					internal_general_remove_item (c.item, depth + 1)
					c.forth
				end
				item_imp.set_internal_children (c)
			else
				item_imp.set_internal_children (create {ARRAYED_LIST [EV_TREE_NODE_IMP]}.make (0))
			end
			if item_imp = selected_item_imp then
				item_imp.deselect_actions.call (Void)
				deselect_actions.call (Void)
			end
			all_ev_children.remove (item_imp.h_item)
			delete_item (item_imp)
	
				-- Then, we redraw the tree
			invalidate
				-- Only signify that we have ended the
				-- removal when we are back to the top level
				-- of the recursion.
			if depth = 0 then
				removing_item := False
			end
		end

	get_children (item_imp: EV_TREE_NODE_IMP): 
		ARRAYED_LIST [EV_TREE_NODE_IMP] is
			-- List of the direct children of `item_imp'.
			-- If the `item_imp' is Void, it returns the children of the tree.
		local
			hwnd: POINTER
			a_default_pointer: POINTER
		do
			create Result.make (1)
			from
				if item_imp = Void then
					hwnd := cwin_send_message_result (
						wel_item, Tvm_getnextitem, to_wparam (Tvgn_root), to_lparam (0))
				else
					hwnd := cwin_send_message_result (
						wel_item, Tvm_getnextitem, to_wparam (Tvgn_child), item_imp.h_item)
				end
			until
				hwnd = a_default_pointer
			loop
				Result.extend (all_ev_children @ hwnd)
				hwnd := cwin_send_message_result (wel_item,
					Tvm_getnextitem, to_wparam (Tvgn_next), hwnd)
			end
		end
		
	ensure_item_visible (tree_node: EV_TREE_NODE) is
			-- Ensure `tree_item' is visible in `Current'.
			-- Tree nodes may be expanded to achieve this.
		local
			tree_node_imp: EV_TREE_NODE_IMP
		do
			tree_node_imp ?= tree_node.implementation
			check
				tree_node_imp /= Void
			end
			cwin_send_message (wel_item, Tvm_ensurevisible, to_wparam (0), tree_node_imp.h_item)
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
			cwin_send_message (wel_item, Tvm_setitem, to_wparam (0), item_imp.wel_item) 
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
			cwin_send_message (wel_item, Tvm_hittest, to_wparam (0), info.item)
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
			was_in_transport_at_start: BOOLEAN
		do
			was_in_transport_at_start := application_imp.pick_and_drop_source /= Void
			pre_drop_it := find_item_at_position (x_pos, y_pos)
			pt := client_to_screen (x_pos, y_pos)

			if pre_drop_it /= Void and not transport_executing
				and not item_is_in_pnd then
				if pre_drop_it.pointer_button_press_actions_internal
					/= Void then
					offsets := pre_drop_it.relative_position
					pre_drop_it.pointer_button_press_actions.call
					([x_pos - offsets.integer_item (1) + 1,
					y_pos - offsets.integer_item (2), button, 0.0, 0.0, 0.0,
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
						([x_pos - offsets.integer_item (1) + 1,
						y_pos - offsets.integer_item (2), button, 0.0, 0.0,
						0.0, pt.x, pt.y])
				end
			end
				-- Reset `call_press_event'.
			keep_press_event
			if button = 3 and was_in_transport_at_start /= (application_imp.pick_and_drop_source /= Void) then
					-- If the state of the pick and drop has changed during execution of
					-- this procedure, then we wish to disable the default processing for the
					-- click. This prevents the nasty visual feedback where the item on which you right
					-- click becomes temporarily drawn as selected even though it is not. This is
					-- standard Windows behavior for a tree control, but we wish to supress it.
					-- Without this fix, the old behavior has the effect of selecting the first item in a tree
					-- when picking from a tree item in a tree with no selected item.
					-- The selection was never actually changed, but the visual feedback is not pleasant.
					-- Julian
				disable_default_processing
			end
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
					([x_pos - offsets.integer_item (1) + 1,
					y_pos - offsets.integer_item (2), button, 0.0, 0.0, 0.0,
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
				+ Ws_clipchildren + Ws_clipsiblings
		end

	on_tvn_selchanging (info: WEL_NM_TREE_VIEW) is
		do
				-- If we are removing the selected item then we set the return
				-- value to 1 (True) which stops windows from selecting the next
				-- item in `Current'.
			if removing_item then
				wel_parent.set_message_return_value (to_lresult (1))
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
					elem.deselect_actions.call (Void)
					deselect_actions.call (Void)
				end
			end

			if info.new_item /= Void then	
				p := info.new_item.h_item
				if p /= default_pointer then
					elem := clist.item (p)
					if elem /= Void then
							-- Call the select_actions on `elem'.
						elem.select_actions.call (Void)
						select_actions.call (Void)
					end
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
				cwin_send_message (wel_item, Tvm_expand, to_wparam (Tve_expand), an_item.h_item)
				tree_item.interface.expand_actions.call (Void)
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
				cwin_send_message (wel_item, Tvm_expand, to_wparam (Tve_collapse), an_item.h_item)
				tree_item.interface.collapse_actions.call (Void)
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
						collapse_actions.call (Void)
				elseif info.action = Tve_expand then
					(all_ev_children @ info.new_item.h_item).interface.
						expand_actions.call (Void)
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
					[x_pos - offsets.integer_item (1) + 1,
				y_pos - offsets.integer_item (2), 0.0, 0.0, 0.0, pt.x,
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
		
	background_color: EV_COLOR is
			-- Color used for the background of `Current'.
			-- This has been redefined as the background color of
			-- text components is white, or `Color_read_write' by default.
		do
			if background_color_imp /= Void then
				Result ?= background_color_imp.interface
			else
				Result := (create {EV_STOCK_COLORS}).Color_read_write
			end
		end
		
	set_background_color (color: EV_COLOR) is
			--
		do
			background_color_imp ?= color.implementation
			wel_set_background_color (background_color_imp)
			if is_displayed then
				-- If the widget is not hidden then invalidate.
				invalidate
			end
		end
		
	set_foreground_color (color: EV_COLOR) is
			-- Make `color' the new `foreground_color'
		do
			foreground_color_imp ?= color.implementation
			set_text_color (foreground_color_imp)
			if is_displayed then
				-- If the widget is not hidden then invalidate.
				invalidate
			end
		end
		
	destroy is
			-- Destroy `Current'.
		do
			wipe_out
			Precursor {EV_PRIMITIVE_IMP}
		end

feature {EV_ANY_I}

	interface: EV_TREE;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_TREE_IMP

