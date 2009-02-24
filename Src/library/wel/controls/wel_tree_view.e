note
	description: "[
		Control that displays a hierarchical list of items.
		
		Note: The common controls dll (WEL_COMMON_CONTROLS_DLL) needs to
			be loaded to use this control.
		]"
	legal: "See notice at end of class."
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

create
	make,
	make_by_id

feature {NONE} -- Initialization

	make (a_parent: WEL_WINDOW; a_x, a_y, a_width, a_height,
				an_id: INTEGER)
			-- Make a tree view control.
		require
			a_parent_not_void: a_parent /= Void
			a_parent_exists: a_parent.exists
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

	get_parent_item (an_item: WEL_TREE_VIEW_ITEM): detachable WEL_TREE_VIEW_ITEM
			-- Return the parent item of the given item.
		require
			exists: exists
			an_item_not_void: an_item /= Void
			an_item_exists: an_item.exists
		local
			handle: POINTER
		do
			handle := {WEL_API}.send_message_result (item, Tvm_getnextitem,
				to_wparam (Tvgn_parent), an_item.h_item)
			if handle /= default_pointer then
				create Result.make
				Result.set_h_item (handle)
				Result := get_item_with_data (Result)
			else
				Result := Void
			end
		end

feature -- Status report

	count: INTEGER
			-- Number of items in the tree view window
		require
			exists: exists
		do
			Result := {WEL_API}.send_message_result_integer (item, Tvm_getcount,
				to_wparam (0), to_lparam (0))
		ensure
			positive_result: Result >= 0
		end

	visible_count: INTEGER
			-- Number of items that will fit into the tree
			-- view window
		require
			exists: exists
		do
			Result := {WEL_API}.send_message_result_integer (item,
				Tvm_getvisiblecount, to_wparam (0), to_lparam (0))
		ensure
			positive_result: Result >= 0
		end

	indent: INTEGER
			-- Amout, in pixels, that child items are indented
			-- relative to their parent items.
		require
			exists: exists
		do
			Result := {WEL_API}.send_message_result_integer (item,
				Tvm_getindent, to_wparam (0), to_lparam (0))
		end

	is_selected (an_item: WEL_TREE_VIEW_ITEM): BOOLEAN
			-- Is `an_item' selected?
		require
			exists: exists
			an_item_not_void: an_item /= Void
			an_item_exists: an_item.exists
			valid_item: has_item (an_item)
		local
			wel_tree_view_item: WEL_TREE_VIEW_ITEM
		do
			create wel_tree_view_item.make
			wel_tree_view_item.set_h_item (an_item.h_item)
			wel_tree_view_item.set_mask (Tvif_state)
			wel_tree_view_item.set_statemask (Tvis_selected)
			{WEL_API}.send_message (item, Tvm_getitem, to_wparam (0), wel_tree_view_item.item)
			Result := flag_set (wel_tree_view_item.state, Tvis_selected)
		end

	is_expanded (an_item: WEL_TREE_VIEW_ITEM): BOOLEAN
			-- Is `an_item' expanded?
		require
			exists: exists
			an_item_not_void: an_item /= Void
			an_item_exists: an_item.exists
			valid_item: has_item (an_item)
		local
			wel_tree_view_item: WEL_TREE_VIEW_ITEM
		do
			create wel_tree_view_item.make
			wel_tree_view_item.set_h_item (an_item.h_item)
			wel_tree_view_item.set_mask (Tvif_state)
			wel_tree_view_item.set_statemask (Tvis_expanded)
			{WEL_API}.send_message (item, Tvm_getitem, to_wparam (0), wel_tree_view_item.item)
			Result := flag_set (wel_tree_view_item.state, Tvis_expanded)
		end

	is_cut (an_item: WEL_TREE_VIEW_ITEM): BOOLEAN
			-- Is `an_item' selected as part of a cut and paste
			-- operation?
		require
			exists: exists
			an_item_not_void: an_item /= Void
			an_item_exists: an_item.exists
			valid_item: has_item (an_item)
		local
			wel_tree_view_item: WEL_TREE_VIEW_ITEM
		do
			create wel_tree_view_item.make
			wel_tree_view_item.set_h_item (an_item.h_item)
			wel_tree_view_item.set_mask (Tvif_state)
			wel_tree_view_item.set_statemask (Tvis_cut)
			{WEL_API}.send_message (item, Tvm_getitem, to_wparam (0), wel_tree_view_item.item)
			Result := flag_set (wel_tree_view_item.state, Tvis_cut)
		end

	is_bold (an_item: WEL_TREE_VIEW_ITEM): BOOLEAN
			-- Is `an_item' bold?
		require
			exists: exists
			an_item_not_void: an_item /= Void
			an_item_exists: an_item.exists
			valid_item: has_item (an_item)
		local
			wel_tree_view_item: WEL_TREE_VIEW_ITEM
		do
			create wel_tree_view_item.make
			wel_tree_view_item.set_h_item (an_item.h_item)
			wel_tree_view_item.set_mask (Tvif_state)
			wel_tree_view_item.set_statemask (Tvis_bold)
			{WEL_API}.send_message (item, Tvm_getitem, to_wparam (0), wel_tree_view_item.item)
			Result := flag_set (wel_tree_view_item.state, Tvis_bold)
		end

	is_drophilited (an_item: WEL_TREE_VIEW_ITEM): BOOLEAN
			-- Is `an_item' selected as a drag ans drop target?
		require
			exists: exists
			an_item_not_void: an_item /= Void
			an_item_exists: an_item.exists
			valid_item: has_item (an_item)
		local
			wel_tree_view_item: WEL_TREE_VIEW_ITEM
		do
			create wel_tree_view_item.make
			wel_tree_view_item.set_h_item (an_item.h_item)
			wel_tree_view_item.set_mask (Tvif_state)
			wel_tree_view_item.set_statemask (Tvis_drophilited)
			{WEL_API}.send_message (item, Tvm_getitem, to_wparam (0), wel_tree_view_item.item)
			Result := flag_set (wel_tree_view_item.state, Tvis_drophilited)
		end

	is_parent (an_item: WEL_TREE_VIEW_ITEM): BOOLEAN
			-- Is `an_item' a parent of other items?
		require
			exists: exists
			an_item_not_void: an_item /= Void
			an_item_exists: an_item.exists
			valid_item: has_item (an_item)
		local
			wel_tree_view_item: WEL_TREE_VIEW_ITEM
		do
			create wel_tree_view_item.make
			wel_tree_view_item.set_h_item (an_item.h_item)
			wel_tree_view_item.set_mask (Tvif_children)
			{WEL_API}.send_message (item, Tvm_getitem, to_wparam (0), wel_tree_view_item.item)
			Result := wel_tree_view_item.children = 1
		end

	has_item (an_item: WEL_TREE_VIEW_ITEM): BOOLEAN
			-- Does `an_item' exist in the tree?
		require
			exists: exists
			item_not_void: an_item /= Void
			item_valid: an_item.exists
		local
			wel_tree_view_item: WEL_TREE_VIEW_ITEM
		do
			create wel_tree_view_item.make
			wel_tree_view_item.set_h_item (an_item.h_item)
			wel_tree_view_item.set_mask (tvif_handle)
			Result := {WEL_API}.send_message_result (item, Tvm_getitem, to_wparam (0), wel_tree_view_item.item) /= default_pointer
		ensure
			mask_unchanged: an_item.mask = old an_item.mask
		end

	selected: BOOLEAN
			-- Is an item selected?
		require
			exists: exists
		do
			Result := {WEL_API}.send_message_result (item, Tvm_getnextitem,
				to_wparam (Tvgn_caret), to_lparam (0)) /= default_pointer
		end

	selected_item: WEL_TREE_VIEW_ITEM
			-- Return the currently selected item.
		require
			exists: exists
			selected: selected
		local
			handle: POINTER
		do
			handle := {WEL_API}.send_message_result (item, Tvm_getnextitem,
				to_wparam (Tvgn_caret), to_lparam (0))
			create Result.make
			Result.set_h_item (handle)
			Result := get_item_with_data (Result)
		ensure
			item_valid: Result.exists
		end

	get_image_list: detachable WEL_IMAGE_LIST
			-- Get the image list associated with this treeview.
			-- Returns Void if none.
		require
			exists: exists
		local
			handle: POINTER
		do
			handle := {WEL_API}.send_message_result (item, Tvm_getimagelist,
				to_wparam (Tvsil_normal), to_lparam (0))
			if handle /= default_pointer then
				create Result.make_by_pointer(handle)
			end
		end

	get_item_rect (an_item: WEL_TREE_VIEW_ITEM): detachable WEL_RECT
			-- `Result' is rect of item `an_item' or `Void'
			-- if `an_item' is not visible.
		require
			exists: exists
			an_item_not_void: an_item /= Void
			an_item_exists: an_item.exists
		local
			rect: WEL_RECT
		do
			create rect.make (0, 0, 0, 0)
			set_item_pointer_in_rect (rect.item, an_item.h_item)
			if {WEL_API}.send_message_result_integer (item, Tvm_getitemrect, to_wparam (0), rect.item) = 1 then
				Result := rect
			end
		end

	get_item_text_rect (an_item: WEL_TREE_VIEW_ITEM): detachable WEL_RECT
			-- `Result' is rect for text of `an_item' or `Void'
			-- if `an_item' is not visible.
		require
			exists: exists
			an_item_not_void: an_item /= Void
			an_item_exists: an_item.exists
		local
			rect: WEL_RECT
		do
			create rect.make (0, 0, 0, 0)
			set_item_pointer_in_rect (rect.item, an_item.h_item)
			if {WEL_API}.send_message_result_integer (item, Tvm_getitemrect, to_wparam (1), rect.item) = 1 then
				Result := rect
			end
		end

	get_tooltip: detachable WEL_TOOLTIP
			-- `Result' is tooltip associated with `Current'.
		require
			exists: exists
		local
			pointer: POINTER
		do
			pointer := treeview_gettooltips (item)
			if pointer /= default_pointer then
				create Result.make_by_pointer (pointer)
			end
		end

	get_background_color: WEL_COLOR_REF
			-- `Result' is background color used for control.
		require
			exists: exists
		local
			color_int: INTEGER
		do
			color_int := {WEL_API}.send_message_result_integer (item, Tvm_getbkcolor, to_wparam (0), to_lparam (0))
			create Result.make_by_color (color_int)
		end

	get_text_color: WEL_COLOR_REF
			-- `Result' is color for item text.
		require
			exists: exists
		local
			color_int: INTEGER
		do
			color_int := {WEL_API}.send_message_result_integer (item, Tvm_gettextcolor, to_wparam (0), to_lparam (0))
			create Result.make_by_color (color_int)
		end

feature -- Status setting

	select_item (an_item: WEL_TREE_VIEW_ITEM)
			-- Set the selection to the given `an_item'.
		require
			exists: exists
			an_item_not_void: an_item /= Void
			an_item_exists: an_item.exists
			valid_item: has_item (an_item)
		do
			{WEL_API}.send_message (item, Tvm_selectitem, to_wparam (Tvgn_caret), an_item.h_item)
		ensure
			item_selected: is_selected (an_item)
		end

	deselect_item (an_item: WEL_TREE_VIEW_ITEM)
			-- Deselect the given item.
		require
			exists: exists
			an_item_not_void: an_item /= Void
			an_item_exists: an_item.exists
			valid_item: has_item (an_item)
		do
			{WEL_API}.send_message (item, Tvm_selectitem, to_wparam (Tvgn_caret), to_lparam (0))
		ensure
			item_deselected: not is_selected (an_item)
		end

	expand_item (an_item: WEL_TREE_VIEW_ITEM)
			-- Expand the given item.
		require
			exists: exists
			an_item_not_void: an_item /= Void
			an_item_exists: an_item.exists
			valid_item: has_item (an_item)
			is_parent: is_parent (an_item)
		do
			{WEL_API}.send_message (item, Tvm_expand, to_wparam (Tve_expand), an_item.h_item)
		ensure
			item_expanded: is_expanded (an_item)
		end

	collapse_item (an_item: WEL_TREE_VIEW_ITEM)
			-- Collapse the given item.
		require
			exists: exists
			an_item_not_void: an_item /= Void
			an_item_exists: an_item.exists
			valid_item: has_item (an_item)
			is_parent: is_parent (an_item)
		do
			{WEL_API}.send_message (item, Tvm_expand, to_wparam (Tve_collapse), an_item.h_item)
		ensure
			item_collapse: not is_expanded (an_item)
		end

	select_first_visible (an_item: WEL_TREE_VIEW_ITEM)
			-- Scrolls the tree view vertically so that
			-- the given `an_item' is the first visible item.
		require
			exists: exists
			an_item_not_void: an_item /= Void
			an_item_exists: an_item.exists
			valid_item: has_item (an_item)
		do
			{WEL_API}.send_message (item, Tvm_selectitem, to_wparam (Tvgn_firstvisible), an_item.h_item)
		end

	select_drop_target (an_item: WEL_TREE_VIEW_ITEM)
			-- Redraw the given `an_item' in the style used to
			-- indicate the target of a drag and drop operation.
		require
			exists: exists
			an_item_not_void: an_item /= Void
			an_item_exists: an_item.exists
			valid_item: has_item (an_item)
		do
			{WEL_API}.send_message (item, Tvm_selectitem, to_wparam (Tvgn_drophilite), an_item.h_item)
		end

	set_indent (an_indent: INTEGER)
			-- Set `indent' with `an_indent'.
		require
			exists: exists
		do
			{WEL_API}.send_message (item, Tvm_setindent, to_wparam (an_indent), to_lparam (0))
		end

	set_image_list(an_imagelist: detachable WEL_IMAGE_LIST)
			-- Set the current image list to `an_imagelist'.
			-- If `an_imagelist' is set to Void, it removes
			-- the current associated image list (if any).
		require
			exists: exists
		do
				-- Then, associate the image list to the tree view.
			if an_imagelist /= Void then
				{WEL_API}.send_message (item, Tvm_setimagelist, to_wparam (Tvsil_normal), an_imagelist.item)
			else
				{WEL_API}.send_message (item, Tvm_setimagelist, to_wparam (Tvsil_normal), to_lparam (0))
			end
		end

	set_tooltip (tooltip: WEL_TOOLTIP)
		require
			exists: exists
			tooltip_not_void: tooltip /= Void
			tooltip_exists: tooltip.exists
		do
			treeview_settooltips (item, tooltip.item)
		end

	set_background_color (a_color: WEL_COLOR_REF)
			-- Assign `a_color' to background color.
		require
			exists: exists
			a_color_not_void: a_color /= Void
		do
			{WEL_API}.send_message (item, Tvm_setbkcolor, to_wparam (0), to_lparam (a_color.item))
		end

	set_text_color (a_color: WEL_COLOR_REF)
			-- Assign `a_color' to color of item text.
		require
			exists: exists
			a_color_not_void: a_color /= Void
		do
			{WEL_API}.send_message (item, Tvm_settextcolor, to_wparam (0), to_lparam (a_color.item))
		end

feature -- Element change

	insert_item (an_item: WEL_TREE_VIEW_INSERT_STRUCT)
			-- Insert `an_item' in the tree.
		require
			exists: exists
			an_item_not_void: an_item /= Void
			an_item_exists: an_item.exists
			user_item_set: an_item.user_tree_view_item /= Void
		local
			l_user_item: detachable WEL_TREE_VIEW_ITEM
		do
			last_item := {WEL_API}.send_message_result (item, Tvm_insertitem, to_wparam (0), an_item.item)
			an_item.tree_view_item.set_h_item (last_item)
			l_user_item := an_item.user_tree_view_item
				-- Per precondition
			check l_user_item_attached: l_user_item /= Void end
			l_user_item.set_h_item (last_item)
		ensure
			new_count: count = old count + 1
		end

	delete_item (an_item: WEL_TREE_VIEW_ITEM)
			-- Remove `an_item' from the tree.
		require
			exists: exists
			item_not_void: an_item /= Void
			an_item_exists: an_item.exists
			valid_item: has_item (an_item)
			has_items: count > 0
		local
			msg_result: POINTER
		do
			msg_result := {WEL_API}.send_message_result (item, Tvm_deleteitem,
				to_wparam (0), an_item.h_item)
			check
				item_deleted: msg_result /= default_pointer
			end
		end

	reset_content
			-- Remove all `items' from `Current'.
		require
			exists: exists
			has_items: count > 0
		local
			msg_result: POINTER
		do
			msg_result := {WEL_API}.send_message_result (item, Tvm_deleteitem, to_wparam (0), Tvi_root)
			check
				items_deleted: msg_result /= default_pointer
			end
		end

	set_tree_item (an_item: WEL_TREE_VIEW_ITEM)
			-- Set some or all of a tree view item's attributes.
		require
			exists: exists
			item_exists: an_item /= Void and then an_item.exists
			valid_item: has_item (an_item)
			has_items: count > 0
		do
			{WEL_API}.send_message (item, Tvm_setitem, to_wparam (0), an_item.item)
		end

feature -- Notifications

	on_tvn_begindrag (info: WEL_NM_TREE_VIEW)
			-- A drag-and-drop operation involving the left mouse
			-- button is being initiated.
		require
			exists: exists
			info_not_void: info /= Void
			info_exists: info.exists
		do
		end

	on_tvn_beginlabeledit (info: WEL_TREE_VIEW_ITEM)
			-- A label editing for an item has started.
		require
			exists: exists
			info_not_void: info /= Void
			info_exists: info.exists
		do
		end

	on_tvn_beginrdrag (info: WEL_NM_TREE_VIEW)
			-- A drag-and-drop operation involving the right mouse
			-- button is being initiated.
		require
			exists: exists
			info_not_void: info /= Void
			info_exists: info.exists
		do
		end

	on_tvn_deleteitem (info: WEL_NM_TREE_VIEW)
			-- An item has been deleted.
		require
			exists: exists
			info_not_void: info /= Void
			info_exists: info.exists
		do
		end

	on_tvn_endlabeledit (info: WEL_TREE_VIEW_ITEM)
			-- A label editing for an item has ended.
		require
			exists: exists
			info_not_void: info /= Void
			info_exists: info.exists
		do
		end

	on_tvn_getdispinfo (info: WEL_TREE_VIEW_ITEM)
			-- The parent window must provide information needed
			-- to display or sort an item.
		require
			exists: exists
			info_not_void: info /= Void
			info_exists: info.exists
		do
		end

	on_tvn_itemexpanded (info: WEL_NM_TREE_VIEW)
			-- a parent item's list of child items has expanded
			-- or collapsed.
		require
			exists: exists
			info_not_void: info /= Void
			info_exists: info.exists
		do
		end

	on_tvn_itemexpanding (info: WEL_NM_TREE_VIEW)
			-- a parent item's list of child items is about to
			-- expand or collapse.
		require
			exists: exists
			info_not_void: info /= Void
			info_exists: info.exists
		do
		end

	on_tvn_keydown (virtual_key: INTEGER)
			-- The user pressed a key and the tree-view control
			-- has the input focus.
		require
			exists: exists
		do
		end

	on_tvn_selchanged (info: WEL_NM_TREE_VIEW)
			-- Selection has changed from one item to another.
		require
			exists: exists
			info_not_void: info /= Void
			info_exists: info.exists
		do
		end

	on_tvn_selchanging (info: WEL_NM_TREE_VIEW)
			-- Selection is about to change from one item to
			-- another.
		require
			exists: exists
			info_not_void: info /= Void
			info_exists: info.exists
		do
		end

	on_tvn_setdispinfo (info: WEL_TREE_VIEW_ITEM)
			-- The parent window must update the informations
			-- it maintains about an item.
		require
			exists: exists
			info_not_void: info /= Void
			info_exists: info.exists
		do
		end

feature {WEL_COMPOSITE_WINDOW} -- Implementation

	process_notification_info (notification_info: WEL_NMHDR)
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

	get_item_with_data (an_item: WEL_TREE_VIEW_ITEM): WEL_TREE_VIEW_ITEM
			-- Get an item and return the same item with all the
			-- data valid
		require
			exists: exists
			item_not_void: an_item /= Void
			item_exists: an_item.exists
			has_item: has_item (an_item)
      		local
			buffer: STRING_32
		do
			Result := an_item
			Result.set_mask (Tvif_text + Tvif_state + Tvif_param)
			create buffer.make (Buffer_size)
			buffer.fill_blank
			Result.set_text (buffer)
			Result.set_cchtextmax (Buffer_size)
			{WEL_API}.send_message (item, Tvm_getitem, to_wparam (0), an_item.item)
		ensure
			item_found: Result /= Void
			item_valid: Result.exists
		end

feature {NONE} -- Implementation

	class_name: STRING_32
			-- Window class name to create
		once
			Result := (create {WEL_STRING}.share_from_pointer (cwin_wc_treeview)).string
		end

	default_style: INTEGER
			-- Default style used to create the control
		once
			Result := Ws_visible + Ws_child + Ws_group +
				Ws_tabstop + Ws_border + Tvs_haslines +
				Tvs_hasbuttons + Tvs_linesatroot
		end

	Buffer_size: INTEGER = 30
			-- Default buffer size for retrieving data from Windows APIs

feature {NONE} -- Externals

	cwin_wc_treeview: POINTER
		external
			"C [macro <cctrl.h>] : EIF_POINTER"
		alias
			"WC_TREEVIEW"
		end

	TreeView_Gettooltips (ptr: POINTER): POINTER
		external
			"C [macro %"cctrl.h%"] (HWND): EIF_POINTER"
		alias
			"TreeView_GetToolTips"
		end

	TreeView_settooltips (hwndTV, hwndTooltip: POINTER)
		external
			"C [macro %"cctrl.h%"] (HWND, HWND)"
		alias
			"TreeView_SetToolTips"
		end

	cwin_index_to_state_image_mask (i: INTEGER): INTEGER
		external
			"C [macro %"commctrl.h%"] (UINT): EIF_INTEGER"
		alias
			"INDEXTOSTATEIMAGEMASK"
		end

	set_item_pointer_in_rect (a_rect_item, a_tree_item: POINTER)
			-- Place value of `a_tree_item' in structure pointed to by `a_rect_item'.
		external
			"C inline use <windows.h>"
		alias
			"*(HTREEITEM*)$a_rect_item = (HTREEITEM) $a_tree_item"
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_TREE_VIEW

