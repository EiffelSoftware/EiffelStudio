indexing
	description: "Control that displays a hierarchical list of items."
	note: "The common controls dll (WEL_COMMON_CONTROLS_DLL) needs to %
		%be loaded to use this control."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TREE_VIEW

inherit
	WEL_CONTROL
		redefine
			process_notification_info
		end

	WEL_TVS_CONSTANTS
		export
			{NONE} all
		end

	WEL_TVM_CONSTANTS
		export
			{NONE} all
		end

	WEL_TVN_CONSTANTS
		export
			{NONE} all
		end

	WEL_TVGN_CONSTANTS
		export
			{NONE} all
		end

	WEL_TVAF_CONSTANTS
		export
			{NONE} all
		end

	WEL_TVIF_CONSTANTS
		export
			{NONE} all
		end

	WEL_TVIS_CONSTANTS
		export
			{NONE} all
		end

	WEL_TVSIL_CONSTANTS
		export
			{NONE} all
		end

	WEL_ILC_CONSTANTS
		export
			{NONE} all
		end

	WEL_TVI_CONSTANTS
		export
			{NONE} all
		end

	WEL_COLOR_CONSTANTS
		export
			{NONE} all
		end

creation
	make,
	make_by_id

feature {NONE} -- Initialization

	make (a_parent: WEL_WINDOW; a_x, a_y, a_width, a_height,
				an_id: INTEGER) is
			-- Make a tree view control.
		require
			a_parent_not_void: a_parent /= Void
		do
			internal_window_make (a_parent, Void,
				default_style, a_x, a_y, a_width, a_height,
				an_id, default_pointer)
			id := an_id
		ensure
			exists: exists
			parent_set: parent = a_parent
			id_set: id = an_id
		end

feature -- Access

	last_item: POINTER
			-- Handle of the last item inserted

	get_parent_item (an_item: WEL_TREE_VIEW_ITEM): WEL_TREE_VIEW_ITEM is
			-- Return the parent item of the given item.
		local
			handle: POINTER
		do
			handle := cwel_integer_to_pointer (cwin_send_message_result (item, Tvm_getnextitem, Tvgn_parent, cwel_pointer_to_integer (an_item.h_item)))
			if handle /= default_pointer then
				create Result.make
				Result.set_h_item (handle)
				Result := get_item_with_data (Result)
			else
				Result := Void
			end
		end 

feature -- Status report

	count: INTEGER is
			-- Number of items in the tree view window
		require
			exists: exists
		do
			Result := cwin_send_message_result (item, Tvm_getcount,
				0, 0)
		ensure
			positive_result: Result >= 0
		end

	visible_count: INTEGER is
			-- Number of items that will fit into the tree
			-- view window
		require
			exists: exists
		do
			Result := cwin_send_message_result (item,
				Tvm_getvisiblecount, 0, 0)
		ensure
			positive_result: Result >= 0
		end

	indent: INTEGER is
			-- Amout, in pixels, that child items are indented
			-- relative to their parent items.
		require
			exists: exists
		do
			Result := cwin_send_message_result (item,
				Tvm_getindent, 0, 0)
		end

	is_selected (an_item: WEL_TREE_VIEW_ITEM): BOOLEAN is
			-- Is `an_item' selected?
		require
			exists: exists
			valid_item: has_item (an_item)
		local
			mask: INTEGER
		do
			mask := an_item.mask
			an_item.set_mask (Tvif_state)
			an_item.set_statemask (Tvis_selected)
			cwin_send_message (item, Tvm_getitem, 0, an_item.to_integer)
			Result := flag_set (an_item.state, Tvis_selected)
			an_item.set_mask (mask)
		end

	is_expanded (an_item: WEL_TREE_VIEW_ITEM): BOOLEAN is
			-- Is `an_item' expanded?
		require
			exists: exists
			valid_item: has_item (an_item)
		local
			mask: INTEGER
		do
			mask := an_item.mask
			an_item.set_mask (Tvif_state)
			an_item.set_statemask (Tvis_expanded)
			cwin_send_message (item, Tvm_getitem, 0, an_item.to_integer)
			Result := flag_set (an_item.state, Tvis_expanded)
			an_item.set_mask (mask)
		end

	is_cut (an_item: WEL_TREE_VIEW_ITEM): BOOLEAN is
			-- Is `an_item' selected as part of a cut and paste
			-- operation?
		require
			exists: exists
			valid_item: has_item (an_item)
		local
			mask: INTEGER
		do
			mask := an_item.mask
			an_item.set_mask (Tvif_state)
			an_item.set_statemask (Tvis_cut)
			cwin_send_message (item, Tvm_getitem, 0, an_item.to_integer)
			Result := flag_set (an_item.state, Tvis_cut)
			an_item.set_mask (mask)
		end

	is_bold (an_item: WEL_TREE_VIEW_ITEM): BOOLEAN is
			-- Is `an_item' bold?
		require
			exists: exists
			valid_item: has_item (an_item)
		local
			mask: INTEGER
		do
			mask := an_item.mask
			an_item.set_mask (Tvif_state)
			an_item.set_statemask (Tvis_bold)
			cwin_send_message (item, Tvm_getitem, 0, an_item.to_integer)
			Result := flag_set (an_item.state, Tvis_bold)
			an_item.set_mask (mask)
		end

	is_drophilited (an_item: WEL_TREE_VIEW_ITEM): BOOLEAN is
			-- Is `an_item' selected as a drag ans drop target?
		require
			exists: exists
			valid_item: has_item (an_item)
		local
			mask: INTEGER
		do
			mask := an_item.mask
			an_item.set_mask (Tvif_state)
			an_item.set_statemask (Tvis_drophilited)
			cwin_send_message (item, Tvm_getitem, 0, an_item.to_integer)
			Result := flag_set (an_item.state, Tvis_drophilited)
			an_item.set_mask (mask)
		end

	is_parent (an_item: WEL_TREE_VIEW_ITEM): BOOLEAN is
			-- Is `an_item' a parent of other items?
		require
			exists: exists
			valid_item: has_item (an_item)
		local
			mask: INTEGER
		do
			mask := an_item.mask
			an_item.set_mask (Tvif_children)
			cwin_send_message (item, Tvm_getitem, 0, an_item.to_integer)
			Result := an_item.children = 1
			an_item.set_mask (mask)
		end

	has_item (an_item: WEL_TREE_VIEW_ITEM): BOOLEAN is
			-- Does `an_item' exist in the tree?
		require
			exists: exists
			item_not_void: an_item /= Void
			item_valid: an_item.exists
		local
			mask: INTEGER
		do
			mask := an_item.mask
			an_item.set_mask (Tvif_handle)
			Result := cwin_send_message_result (item, Tvm_getitem, 0, an_item.to_integer) /= 0
			an_item.set_mask (mask)
		ensure
			mask_unchanged: an_item.mask = old an_item.mask
		end

	selected: BOOLEAN is
			-- Is an item selected?
		require
			exists: exists
		do
			Result := cwin_send_message_result (item, Tvm_getnextitem,
				Tvgn_caret, 0) /= 0
		end

	selected_item: WEL_TREE_VIEW_ITEM is
			-- Return the currently selected item.
		require
			exists: exists
			selected: selected
		local
			handle: POINTER
		do
			handle := cwel_integer_to_pointer (cwin_send_message_result (item, Tvm_getnextitem,
				Tvgn_caret, 0))
			create Result.make
			Result.set_h_item (handle)
			Result := get_item_with_data (Result)
		ensure
			item_valid: Result.exists
		end

	get_image_list: WEL_IMAGE_LIST is
			-- Get the image list associated with this treeview.
			-- Returns Void if none.
		local
			handle: POINTER
		do
			handle := cwel_integer_to_pointer ( cwin_send_message_result (item, Tvm_getimagelist, Tvsil_normal, 0) )
			if handle /= default_pointer then
				create Result.make_by_pointer(handle)
			end
		end

	get_item_rect (an_item: WEL_TREE_VIEW_ITEM): WEL_RECT is
		do
			create Result.make (0, 0, 0, 0)
			cwin_send_message (item, Tvm_getitemrect, 0, Result.to_integer)
		end

	get_tooltip: WEL_TOOLTIP is
			-- `Result' is tooltip associated with `Current'.
		local
			pointer: POINTER
		do
			pointer := treeview_gettooltips (item)
			if pointer /= default_pointer then
				create Result.make_by_pointer (pointer)
			end
		end
		
	get_background_color: WEL_COLOR_REF is
			-- `Result' is background color used for control.
		local
			color_int: INTEGER
		do
			color_int := cwin_send_message_result (item, Tvm_getbkcolor, 0, 0)
			create Result.make_by_color (color_int)
		end
		
	get_text_color: WEL_COLOR_REF is
			-- `Result' is color for item text.
		local
			color_int: INTEGER
		do
			color_int := cwin_send_message_result (item, Tvm_gettextcolor, 0, 0)
			create Result.make_by_color (color_int)
		end

feature -- Status setting

	select_item (an_item: WEL_TREE_VIEW_ITEM) is
			-- Set the selection to the given `an_item'.
		require
			exists: exists
			valid_item: has_item (an_item)
		do

			cwin_send_message (item, Tvm_selectitem,
				Tvgn_caret, cwel_pointer_to_integer (an_item.h_item))
		ensure
			item_selected: is_selected (an_item)
		end

	deselect_item (an_item: WEL_TREE_VIEW_ITEM) is
			-- Deselect the given item
		require
			exists: exists
			valid_item: has_item (an_item)
		local
			mask: INTEGER
		do
			mask := an_item.mask
			an_item.set_mask (Tvif_state)
			an_item.set_statemask (Tvis_selected)
			an_item.set_state (0)
			cwin_send_message (item, Tvm_setitem, 0, an_item.to_integer)
			an_item.set_mask (mask)
		ensure
			item_deselected: not is_selected (an_item)
		end

	expand_item (an_item: WEL_TREE_VIEW_ITEM) is
			-- Expand the given item.
		require
			exists: exists
			is_parent: is_parent (an_item)
			valid_item: has_item (an_item)
		do
			cwin_send_message (item, Tvm_expand, Tve_expand,
				cwel_pointer_to_integer (an_item.h_item))
		ensure
			item_expanded: is_expanded (an_item)
		end

	collapse_item (an_item: WEL_TREE_VIEW_ITEM) is
			-- Collapse the given item.
		require
			exists: exists
			is_parent (an_item)
			valid_item: has_item (an_item)
		do
			cwin_send_message (item, Tvm_expand, Tve_collapse,
				cwel_pointer_to_integer (an_item.h_item))
		ensure
			item_collapse: not is_expanded (an_item)
		end

	select_first_visible (an_item: WEL_TREE_VIEW_ITEM) is
			-- Scrolls the tree view vertically so that 
			-- the given `an_item' is the first visible item.
		require
			exists: exists
			valid_item: has_item (an_item)
		do
			cwin_send_message (item, Tvm_selectitem,
				Tvgn_firstvisible, cwel_pointer_to_integer (an_item.h_item))
		end

	select_drop_target (an_item: WEL_TREE_VIEW_ITEM) is
			-- Redraw the given `an_item' in the style used to 
			-- indicate the target of a drag and drop operation.
		require
			exists: exists
			valid_item: has_item (an_item)
		do
			cwin_send_message (item, Tvm_selectitem,
				Tvgn_drophilite, cwel_pointer_to_integer (an_item.h_item))
		end

	set_indent (an_indent: INTEGER) is
			-- Set `indent' with `an_indent'.
		require
			exists: exists
		do
			cwin_send_message (item, Tvm_setindent, an_indent, 0)
		end

	set_image_list(an_imagelist: WEL_IMAGE_LIST) is
			-- Set the current image list to `an_imagelist'.
			-- If `an_imagelist' is set to Void, it removes
			-- the current associated image list (if any).
		do
				-- Then, associate the image list to the tree view.
			if an_imagelist /= Void then
				cwin_send_message (item, Tvm_setimagelist, Tvsil_normal, cwel_pointer_to_integer (an_imagelist.item))
			else
				cwin_send_message (item, Tvm_setimagelist, Tvsil_normal, 0) -- 0 correspond to NULL.
			end
		end

	set_tooltip (tooltip: WEL_TOOLTIP) is
		do
			treeview_settooltips (item, tooltip.item)
		end
		
	set_background_color (a_color: WEL_COLOR_REF) is
			-- Assign `a_color' to background color.
		do
			cwin_send_message (item, Tvm_setbkcolor, 0, a_color.item)
		end
		
	set_text_color (a_color: WEL_COLOR_REF) is
			-- Assign `a_color' to color of item text.
		do
			cwin_send_message (item, Tvm_settextcolor, 0, a_color.item)
		end

feature -- Element change

	insert_item (an_item: WEL_TREE_VIEW_INSERT_STRUCT) is
			-- Insert `an_item' in the tree.
		require
			exists: exists
			an_item_not_void: an_item /= Void
			an_item_exists: an_item.exists
		do
			last_item := cwel_integer_to_pointer (cwin_send_message_result (item,
				Tvm_insertitem, 0, an_item.to_integer))
			an_item.tree_view_item.set_h_item (last_item)
			an_item.user_tree_view_item.set_h_item (last_item)
		ensure
			new_count: count = old count + 1
		end

	delete_item (an_item: WEL_TREE_VIEW_ITEM) is
			-- Remove `an_item' from the tree.
		require
			exists: exists
			item_not_void: an_item /= Void
			valid_item: has_item (an_item)
			has_items: count > 0
		local
			msg_result: INTEGER
		do
			msg_result := cwin_send_message_result (item, Tvm_deleteitem, 0, cwel_pointer_to_integer (an_item.h_item))
			check
				item_deleted: msg_result /= 0
			end
		end
		
	reset_content is
			-- Remove all `items' from `Current'.
		require
			exists: exists
			has_items: count > 0
		local
			msg_result: INTEGER
		do
			msg_result := cwin_send_message_result (item, Tvm_deleteitem, 0, cwel_pointer_to_integer (Tvi_root))
			check
				items_deleted: msg_result /= 0
			end
		end

	set_tree_item (an_item: WEL_TREE_VIEW_ITEM) is
			-- Set some or all of a tree view item's attributes.
		require
			exists: exists
			item_exists: an_item /= Void and then an_item.exists
			valid_item: has_item (an_item)
			has_items: count > 0
		do
			cwin_send_message (item, Tvm_setitem, 0, an_item.to_integer)
		end

feature -- Notifications

	on_tvn_begindrag (info: WEL_NM_TREE_VIEW) is
			-- A drag-and-drop operation involving the left mouse
			-- button is being initiated.
		require
			exists: exists
		do
		end

	on_tvn_beginlabeledit (info: WEL_TREE_VIEW_ITEM) is
			-- A label editing for an item has started.
		require
			exists: exists
		do
		end

	on_tvn_beginrdrag (info: WEL_NM_TREE_VIEW) is
			-- A drag-and-drop operation involving the right mouse
			-- button is being initiated.
		require
			exists: exists
		do
		end

	on_tvn_deleteitem (info: WEL_NM_TREE_VIEW) is
			-- An item has been deleted.
		require
			exists: exists
		do
		end

	on_tvn_endlabeledit (info: WEL_TREE_VIEW_ITEM) is
			-- A label editing for an item has ended.
		require
			exists: exists
		do
		end

	on_tvn_getdispinfo (info: WEL_TREE_VIEW_ITEM) is
			-- The parent window must provide information needed
			-- to display or sort an item.
		require
			exists: exists
		do
		end

	on_tvn_itemexpanded (info: WEL_NM_TREE_VIEW) is
			-- a parent item's list of child items has expanded
			-- or collapsed.
		require
			exists: exists
		do
		end

	on_tvn_itemexpanding (info: WEL_NM_TREE_VIEW) is
			-- a parent item's list of child items is about to
			-- expand or collapse.
		require
			exists: exists
		do
		end

	on_tvn_keydown (virtual_key: INTEGER) is
			-- The user pressed a key and the tree-view control 
			-- has the input focus.
		require
			exists: exists
		do
		end

	on_tvn_selchanged (info: WEL_NM_TREE_VIEW) is
			-- Selection has changed from one item to another.
		require
			exists: exists
		do
		end

	on_tvn_selchanging (info: WEL_NM_TREE_VIEW) is
			-- Selection is about to change from one item to
			-- another.
		require
			exists: exists
		do
		end

	on_tvn_setdispinfo (info: WEL_TREE_VIEW_ITEM) is
			-- The parent window must update the informations
			-- it maintains about an item.
		require
			exists: exists
		do
		end

feature {WEL_COMPOSITE_WINDOW} -- Implementation

	process_notification_info (notification_info: WEL_NMHDR) is
			-- Process a `notification_code' sent by Windows
			-- through the Wm_notify message
		local
			nm_info: WEL_NM_TREE_VIEW
			disp_info: WEL_TV_DISPINFO
			keydown_info: WEL_TV_KEYDOWN
			code: INTEGER
		do
			code := notification_info.code 
			if code = Tvn_begindrag then
				create nm_info.make_by_nmhdr (notification_info)
				on_tvn_begindrag (nm_info)
			elseif code = Tvn_beginlabeledit then
				create disp_info.make_by_nmhdr (notification_info)
				on_tvn_beginlabeledit (disp_info.tree_item)
			elseif code = Tvn_beginrdrag then
				create nm_info.make_by_nmhdr (notification_info)
				on_tvn_beginrdrag (nm_info)
			elseif code = Tvn_deleteitem then
				create nm_info.make_by_nmhdr (notification_info)
				on_tvn_deleteitem (nm_info)
			elseif code = Tvn_endlabeledit then
				create disp_info.make_by_nmhdr (notification_info)
				on_tvn_endlabeledit (disp_info.tree_item)
			elseif code = Tvn_getdispinfo then
				create disp_info.make_by_nmhdr (notification_info)
				on_tvn_getdispinfo (disp_info.tree_item)
			elseif code = Tvn_itemexpanded then
				create nm_info.make_by_nmhdr (notification_info)
				on_tvn_itemexpanded (nm_info)
			elseif code = Tvn_itemexpanding then
				create nm_info.make_by_nmhdr (notification_info)
				on_tvn_itemexpanding (nm_info)
			elseif code = Tvn_keydown then
				create keydown_info.make_by_nmhdr (notification_info)
				on_tvn_keydown (keydown_info.virtual_key)
			elseif code = Tvn_selchanged then
				create nm_info.make_by_nmhdr (notification_info)
				on_tvn_selchanged (nm_info)
			elseif code = Tvn_selchanging then
				create nm_info.make_by_nmhdr (notification_info)
				on_tvn_selchanging (nm_info)
			elseif code = Tvn_setdispinfo then
				create disp_info.make_by_nmhdr (notification_info)
				on_tvn_setdispinfo (disp_info.tree_item)
			end
		end

feature {WEL_NM_TREE_VIEW} -- Implementation

	get_item_with_data (an_item: WEL_TREE_VIEW_ITEM): WEL_TREE_VIEW_ITEM is
			-- Get an item and return the same item with all the
			-- data valid
		require
			exists: exists
			item_not_void: an_item /= Void
			item_exists: an_item.exists
			has_item: has_item (an_item)
      local
			buffer: STRING
			item_found: BOOLEAN
		do
			an_item.set_mask (Tvif_text + Tvif_state + Tvif_param)
			create buffer.make (Buffer_size)
			buffer.fill_blank
			an_item.set_text (buffer)
			an_item.set_cchtextmax (Buffer_size)
			item_found := cwin_send_message_result (item, Tvm_getitem, 0, an_item.to_integer) /= 0
			if item_found then
				Result := an_item
			end
		ensure
			item_found: Result /= Void
			item_valid: Result.exists
		end

feature {NONE} -- Implementation

	class_name: STRING is
			-- Window class name to create
		once
			create Result.make (0)
			Result.from_c (cwin_wc_treeview)
		end

	default_style: INTEGER is
			-- Default style used to create the control
		once
			Result := Ws_visible + Ws_child + Ws_group +
				Ws_tabstop + Ws_border + Tvs_haslines +
				Tvs_hasbuttons + Tvs_linesatroot
		end

	Buffer_size: INTEGER is 30
			-- Default buffer size for retrieving data from Windows APIs

feature {NONE} -- Externals

	cwin_wc_treeview: POINTER is
		external
			"C [macro <cctrl.h>] : EIF_POINTER"
		alias
			"WC_TREEVIEW"
		end

	TreeView_Gettooltips (ptr: POINTER): POINTER is
		external 
			"C [macro %"cctrl.h%"] (HWND): EIF_POINTER"
		alias
			"TreeView_GetToolTips"
		end

	TreeView_settooltips (hwndTV, hwndTooltip: POINTER) is
		external
			"C [macro %"cctrl.h%"] (HWND, HWND)"
		alias
			"TreeView_SetToolTips"
		end

end -- class WEL_TREE_VIEW


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

