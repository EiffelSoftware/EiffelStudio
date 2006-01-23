indexing
	description: "[
		Control that displays a multi-column list of items.

		Note: The common controls dll (WEL_COMMON_CONTROLS_DLL) needs to
			be loaded to use this control.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_LIST_VIEW

inherit
	WEL_CONTROL
		redefine
			process_notification_info
		end

	WEL_WINDOWS_VERSION

	WEL_LIST_VIEW_CONSTANTS
		export
			{NONE} all
			{ANY} valid_lvcfmt_constant,
				  is_valid_list_view_flag,
				  valid_lvis_constants
		end

	WEL_ILC_CONSTANTS
		export
			{NONE} all
		end

create
	make,
	make_by_id

feature {NONE} -- Initialization

	make (a_parent: WEL_WINDOW; a_x, a_y, a_width, a_height,
				an_id: INTEGER) is
			-- Make a List view control.
		require
			a_parent_not_void: a_parent /= Void
		do
			internal_window_make (a_parent, Void,
				default_style, a_x, a_y, a_width, a_height,
				an_id, default_pointer)
			id := an_id
			column_count := 0
		ensure
			exists: exists
			parent_set: parent = a_parent
			id_set: id = an_id
		end

feature -- Status report

	column_count: INTEGER
			-- Number of columns

	count: INTEGER is
			-- Number of item in the list view
		require
			exists: exists
		do
			Result := cwin_send_message_result_integer (item,
						Lvm_getitemcount, to_wparam (0), to_lparam (0))
		end

	visible_count: INTEGER is
			-- Number of items that will fit in the list view window
		require
			exists: exists
		do
			Result := cwin_send_message_result_integer (item,
						Lvm_getcountperpage, to_wparam (0), to_lparam (0))
		end

	selected_count: INTEGER is
			-- Number of selected items in the list view window
		require
			exists: exists
		do
			Result := cwin_send_message_result_integer (item,
						Lvm_getselectedcount, to_wparam (0), to_lparam (0))
		end

	top_index: INTEGER is
			-- Index of the first visible item
		require
			exists
		do
			Result := cwin_send_message_result_integer (item,
						Lvm_gettopindex, to_wparam (0), to_lparam (0)).max(0)
		ensure
			result_large_enough: Result >= 0
			result_small_enough: Result <= count
		end

	focus_item: INTEGER is
			-- Zero-based index of the item that has the focus
			-- Return -1 if there is none.
		require
			exists: exists
		do
			Result := cwin_send_message_result_integer (item,
						Lvm_getnextitem, to_wparam (-1), to_lparam (Lvni_focused))
		ensure
			result_large_enough: Result >= -1
			result_small_enough: Result < count
		end

	selected_items: ARRAY [INTEGER] is
			-- Contains all the selected index. Only one in
			-- case of a single selection list view.
		require
			exists: exists
		local
			index: INTEGER
			result_count: INTEGER
		do
			if selected_count > 0 then
				create Result.make (0, selected_count - 1)
				from
					result_count := 0
					index := cwin_send_message_result_integer (item, Lvm_getnextitem,
						to_wparam (-1), to_lparam (Lvni_selected))
				until
					index = -1
				loop
					Result.put (index, result_count)
					index := cwin_send_message_result_integer (item, Lvm_getnextitem,
								to_wparam (index), to_lparam (Lvni_selected))
					result_count := result_count + 1
				end
			else
				create Result.make (1,0)
			end
		ensure
			result_not_void: Result /= Void
			result_valid: Result.count = selected_count
		end

	selected_item: INTEGER is
			-- Contains the top most selected index.
			-- -1 if no item is selected.
		require
			exists: exists
		do
			Result := cwin_send_message_result_integer (item, Lvm_getnextitem,
				to_wparam (-1), to_lparam (Lvni_selected))
		ensure
			result_valid: selected_count > 0 implies Result >= 0
		end

	get_background_color: WEL_COLOR_REF is
			-- `Result' is background color used for control.
		local
			color_int: INTEGER
		do
			color_int := cwin_send_message_result_integer (item, Lvm_getbkcolor,
				to_wparam (0), to_lparam (0))
			create Result.make_by_color (color_int)
		end

	get_text_background_color: WEL_COLOR_REF is
			-- `Result' is background color of item text.
		local
			color_int: INTEGER
		do
			color_int := cwin_send_message_result_integer (item, Lvm_gettextbkcolor,
				to_wparam (0), to_lparam (0))
			create Result.make_by_color (color_int)
		end

	get_text_foreground_color: WEL_COLOR_REF is
			-- `Result' is foreground color for item text.
		local
			color_int: INTEGER
		do
			color_int := cwin_send_message_result_integer (item, Lvm_gettextcolor,
				to_wparam (0), to_lparam (0))
			create Result.make_by_color (color_int)
		end

	get_column_width (column: INTEGER): INTEGER is
			-- Width of the zero-based `index'-th item.
		require
			exists: exists
			index_large_enough: column >= 0
			index_small_enough: column < column_count
		do
			Result := cwin_send_message_result_integer (item, Lvm_getcolumnwidth,
				to_wparam (column), to_lparam (0))
		end

	get_item_state (index, mask: INTEGER): INTEGER is
			-- State of the zero-based `index'-th item. The mask give
			-- the state informations to retrieve. See WEL_LVIS_CONSTANTS for
			-- the value of the mask.
		require
			exists: exists
			index_large_enough: index >= 0
			index_small_enough: index < count
		do
			Result := cwin_send_message_result_integer (item, Lvm_getitemstate,
				to_wparam (index), to_lparam (mask))
		end

	get_item_position (index: INTEGER): WEL_POINT is
			-- Retrieves the position of the zero-based `index'-th item.
		require
			exists: exists
			index_large_enough: index >= 0
			index_small_enough: index < count
		do
			create Result.make (0,0)
			cwin_send_message (item, Lvm_getitemposition, to_wparam (index), Result.item)
		end

	get_item_rect (index: INTEGER): WEL_RECT is
			-- Retrieves the position of the zero-based `index'-th item.
		require
			exists: exists
			index_large_enough: index >= 0
			index_small_enough: index <= count
		do
			create Result.make (0, 0, 0, 0)
			cwin_send_message (item, Lvm_getitemrect, to_wparam (index), Result.item)
		end

	get_cell_text (isub_item, iitem: INTEGER): STRING is
			-- Get the label of the cell with coordinates `isub_item', `iiitem'.
		require
			exists: exists
			iitem_large_enough: iitem >= 0
			isub_item_large_enough: isub_item >= 0
			iitem_small_enough: iitem < count
			isub_item_small_enough: isub_item < column_count
		local
			l_item: WEL_LIST_VIEW_ITEM
			buffer: WEL_STRING
			internal_buffer_size, l_count: INTEGER
		do
			create l_item.make
			create buffer.make_empty (buffer_size)
			l_item.set_text_with_wel_string (buffer)
			l_item.set_isubitem (isub_item)
				-- We do it in a loop in case the text is larger
				-- than the default `buffer_size'
			l_count := cwin_send_message_result_integer (item, Lvm_getitemtext, to_wparam (iitem), l_item.item)
			if l_count = buffer_size then
				from
					internal_buffer_size := buffer_size
				until
					l_count < internal_buffer_size
				loop
					internal_buffer_size := internal_buffer_size * 2
					buffer.set_count (internal_buffer_size)
					l_item.set_text_with_wel_string (buffer)
					l_count := cwin_send_message_result_integer (item, Lvm_getitemtext, to_wparam (iitem), l_item.item)
				end
			end
			Result := l_item.text
		end

	get_item (index, subitem: INTEGER): WEL_LIST_VIEW_ITEM is
			-- Return a representation of the item at the
			-- `index' position.
		require
			exists: exists
			index_large_enough: index >= 0
			index_small_enough: index < count
			subitem_large_enough: subitem >= 0
			subitem_small_enough: subitem < column_count
		local
			buffer: WEL_STRING
			l_count: INTEGER
			internal_buffer_size: INTEGER
		do
				-- First we retrieve the item without its text.
			create Result.make
			Result.set_mask (Lvif_state + Lvif_image + Lvif_param)
			Result.set_iitem (index)
			Result.set_isubitem (subitem)
			Result.set_statemask (Lvis_cut + Lvis_drophilited + Lvis_focused + Lvis_selected)
			cwin_send_message (item, Lvm_getitem, to_wparam (0), Result.item)

				-- Then we retrieve the text. We do it in a loop in case the text is larger
				-- than the default `buffer_size'.
			create buffer.make_empty (buffer_size)
			Result.set_text_with_wel_string (buffer)
			l_count := cwin_send_message_result_integer (item, Lvm_getitemtext, to_wparam (0), Result.item)
			if l_count = buffer_size then
				from
					internal_buffer_size := buffer_size
				until
					l_count < internal_buffer_size
				loop
					internal_buffer_size := internal_buffer_size * 2
					buffer.set_count (internal_buffer_size)
					Result.set_text_with_wel_string (buffer)
					l_count := cwin_send_message_result_integer (item, Lvm_getitemtext, to_wparam (0), Result.item)
				end
			end
		end

	get_extended_view_style: INTEGER is
			-- Gets extended styles in list view controls.
		require
			function_supported: comctl32_version >= version_470
		do
			Result := cwin_send_message_result_integer (item, Lvm_getextendedlistviewstyle,
				to_wparam (0), to_lparam (0))
		end

	get_tooltip: WEL_TOOLTIP is
			-- `Result' is tooltip associated with `Current'.
		local
			pointer: POINTER
		do
			pointer := listview_gettooltips (item)
			if pointer /= default_pointer then
				create Result.make_by_pointer (pointer)
			end
		end

feature -- Status setting

	ensure_visible (an_index: INTEGER) is
			-- Ensure that column `an_index' is completely visible in `Current'.
		require
			exists: exists
			index_large_enough: an_index >= 0
			index_small_enough: an_index < count
		do
			cwin_send_message (item, Lvm_ensurevisible, to_wparam (an_index), to_lparam (1))
		end

	set_extended_view_style (a_new_style: INTEGER) is
			-- Sets extended styles in list view controls.
		require
			function_supported: comctl32_version >= version_470
		do
			cwin_send_message (item, Lvm_setextendedlistviewstyle, to_wparam (0), to_lparam (a_new_style))
		end

	set_column_width (value, index: INTEGER) is
			-- Make `value' the new width of the zero-base `index'-th column.
		require
			exists: exists
			index_large_enough: index >= 0
			index_small_enough: index < column_count
		do
			cwin_send_message (item, Lvm_setcolumnwidth, to_wparam (index), to_lparam (value))
		end

	update_item (index: INTEGER) is
			-- Update the list view.
		require
			exists: exists
			index_large_enough: index >= 0
			index_small_enough: index < count
		do
			cwin_send_message (item, Lvm_update, to_wparam (index), to_lparam (0))
		end

	set_item_state (index, state: INTEGER) is
			-- Set state of item at `index' with `state'.
			-- See class WEL_LVIS_CONSTANTS for possible `state' values.
		require
			exists: exists
			index_large_enough: index >= 0
			index_small_enough: index < count
		local
			an_item: WEL_LIST_VIEW_ITEM
		do
			create an_item.make
			an_item.set_statemask (state)
			an_item.set_state (state)
			cwin_send_message (item, Lvm_setitemstate, to_wparam (index), an_item.item)
		end

	set_item_count (value: INTEGER) is
			-- Prepares a list view control for adding a large number
			-- of items and make it then faster.
		require
			exists: exists
			value_big_enough: value >= 0
		do
			cwin_send_message (item, Lvm_setitemcount, to_wparam (value), to_lparam (0))
		end

	set_cell_text (isub_item, iitem: INTEGER; txt: STRING) is
			-- Set the label of the cell with coordinates `isub_item', `item'
			-- with `txt'.
		require
			exists: exists
			isub_item_large_enough: isub_item >= 0
			iitem_large_enough: iitem >= 0
			isub_item_small_enough: isub_item < column_count
			iitem_small_enough: iitem < count
		local
			an_item: WEL_LIST_VIEW_ITEM
		do
			create an_item.make_with_attributes (Lvif_text, iitem, isub_item, 0, txt)
			cwin_send_message (item, Lvm_setitemtext, to_wparam (iitem), an_item.item)
		end

	set_column_title (txt: STRING; index: INTEGER) is
			-- Make `txt' the new title of the `index'-th column.
		require
			exists: exists
			index_large_enough: index >= 0
			index_small_enough: index < column_count
		local
			a_column: WEL_LIST_VIEW_COLUMN
		do
			create a_column.make_with_attributes (Lvcf_text, index, 0, txt)
			cwin_send_message (item, Lvm_setcolumn, to_wparam (index), a_column.item)
		end

	set_column_format (index: INTEGER; fmt: INTEGER) is
			-- Set the alignment of the column, cannot be used for
			-- the first column that must be left aligned.
		require
			exists: exists
			index_large_enough: index > 0
			index_small_enough: index < column_count
			good_format: valid_lvcfmt_constant (fmt)
		local
			a_column: WEL_LIST_VIEW_COLUMN
		do
			create a_column.make_with_attributes (Lvcf_fmt, index, fmt, create {STRING}.make (0))
			cwin_send_message (item, Lvm_setcolumn, to_wparam (index), a_column.item)
		end

	set_image_list(an_imagelist: WEL_IMAGE_LIST) is
			-- Set the current "large" image list to `an_imagelist'.
			-- If `an_imagelist' is set to Void, it removes
			-- the current associated image list (if any).
		do
				-- Then, associate the image list to the tree view.
			if an_imagelist /= Void then
				cwin_send_message (item, Lvm_setimagelist, to_wparam (Lvsil_normal), an_imagelist.item)
			else
				cwin_send_message (item, Lvm_setimagelist, to_wparam (Lvsil_normal), to_lparam (0))
			end
		end

	set_small_image_list(an_imagelist: WEL_IMAGE_LIST) is
			-- Set the current "small" image list to `an_imagelist'.
			-- If `an_imagelist' is set to Void, it removes
			-- the current associated image list (if any).
		do
				-- Then, associate the image list to the tree view.
			if an_imagelist /= Void then
				cwin_send_message (item, Lvm_setimagelist, to_wparam (Lvsil_small), an_imagelist.item)
			else
				cwin_send_message (item, Lvm_setimagelist, to_wparam (Lvsil_small), to_lparam (0))
			end
		end

	set_background_color (a_color: WEL_COLOR_REF) is
			-- Assign `a_color' to background of `Current'.
		do
			cwin_send_message (item, Lvm_setbkcolor, to_wparam (0), to_lparam (a_color.item))
		end

	set_text_background_color (a_color: WEL_COLOR_REF) is
			-- Assign `a_color' to background color of item text.
		do
			cwin_send_message (item, Lvm_settextbkcolor, to_wparam (0), to_lparam (a_color.item))
		end

	set_text_foreground_color (a_color: WEL_COLOR_REF) is
			-- Assign `a_color' to foreground color for item text.
		do
			cwin_send_message (item, Lvm_settextcolor, to_wparam (0), to_lparam (a_color.item))
		end

feature -- Element change

	append_column (column: WEL_LIST_VIEW_COLUMN) is
			-- Append `column' to the list view.
		require
			exists: exists
		do
			cwin_send_message (item, Lvm_insertcolumn, to_wparam (column_count), column.item)
			column_count := column_count + 1
		ensure
			new_column_count: column_count = old column_count + 1
		end

	insert_column (column: WEL_LIST_VIEW_COLUMN; index: INTEGER) is
			-- Insert `column' at the zero-based `index'.
		require
			exists: exists
			index_large_enough: index >= 0
			index_small_enough: index <= column_count
		do
			cwin_send_message (item, Lvm_insertcolumn, to_wparam (index), column.item)
			column_count := column_count + 1
		ensure
			new_column_count: column_count = old column_count + 1
		end

	prepend_column (column: WEL_LIST_VIEW_COLUMN) is
			-- Prepend `column' to the list view.
		require
			exists: exists
		do
			cwin_send_message (item, Lvm_insertcolumn, to_wparam (0), column.item)
			column_count := column_count + 1
		ensure
			new_column_count: column_count = old column_count + 1
		end

	delete_column (index: INTEGER) is
			-- Remove the zero-based `index'-th column of the list view.
		require
			exists: exists
			index_large_enough: index >= 0
			index_small_enough: index < column_count
		do
			cwin_send_message (item, Lvm_deletecolumn, to_wparam (index), to_lparam (0))
			column_count := column_count - 1
		ensure
			new_column_count: column_count = old column_count - 1
		end

	insert_item (an_item: WEL_LIST_VIEW_ITEM) is
			-- Insert `item' in the list-view. The zero-based position of the item is
			-- given by the `iitem' attribute of the item.
		require
			exists: exists
			index_large_enough: an_item.iitem >= 0
			index_small_enough: an_item.iitem <= count
		do
			cwin_send_message (item, Lvm_insertitem, to_wparam (0), an_item.item)
		ensure
			new_count: count = old count + 1
		end

	replace_item (an_item: WEL_LIST_VIEW_ITEM) is
			-- Set the properties of `an_item'.
			-- The zero-based position of the item is given by the
			-- `iitem' attribute of the item.
		require
			exists: exists
			index_large_enough: an_item.iitem >= 0
			index_small_enough: an_item.iitem <= count
		do
			cwin_send_message (item, Lvm_setitem, to_wparam (0), an_item.item)
		end

	delete_item (index: INTEGER) is
			-- Remove the zero-based `index'-th item of the list view.
		require
			exists: exists
			index_large_enough: index >= 0
			index_small_enough: index < count
		do
			cwin_send_message (item, Lvm_deleteitem, to_wparam (index), to_lparam (0))
		ensure
			new_count: count = old count - 1
		end

	reset_content is
			-- Reset the content of the list.
		require
			exists: exists
		do
			cwin_send_message (item, Lvm_deleteallitems, to_wparam (0), to_lparam (0))
		ensure
			new_count: count = 0
		end

feature -- Basic Operations

	search (a_search_info: WEL_LIST_VIEW_SEARCH_INFO; a_starting_index: INTEGER): INTEGER is
			-- Search list view item according to `a_search_info'.
			-- Search starts after zero based index `a_starting_index'.
			-- If `a_starting_index' is -1 then search all items.
			-- Result is zero based index of found item or -1 if item was not found.
		require
			non_void_search_info: a_search_info /= Void
			valid_search_info: a_search_info.exists
			valid_starting_index: a_starting_index >= -1 and a_starting_index < count
		do
			Result := cwin_send_message_result_integer (item, Lvm_finditem,
				to_wparam (a_starting_index), a_search_info.item)
		end

feature -- Notifications

	on_lvn_begindrag (info: WEL_NM_LIST_VIEW) is
			-- A drag-and-drop operation involving the left mouse
			-- button is being initiated.
		require
			exists: exists
		do
		end

	on_lvn_beginlabeledit (info: WEL_LIST_VIEW_ITEM) is
			-- A label editing for an item has started.
		require
			exists: exists
		do
		end

	on_lvn_beginrdrag (info: WEL_NM_LIST_VIEW) is
			-- A drag-and-drop operation involving the right mouse
			-- button is being initiated.
		require
			exists: exists
		do
		end

	on_lvn_columnclick (info: WEL_NM_LIST_VIEW) is
			-- A column was tapped.
		require
			exists: exists
		do
		end

	on_lvn_deleteallitems (info: WEL_NM_LIST_VIEW) is
			-- All the items were deleted.
		require
			exists: exists
		do
		end

	on_lvn_deleteitem (info: WEL_NM_LIST_VIEW) is
			-- An item was deleted.
		require
			exists: exists
		do
		end

	on_lvn_endlabeledit (info: WEL_LIST_VIEW_ITEM) is
			-- A label editing for an item has ended.
		require
			exists: exists
		do
		end

	on_lvn_getdispinfo (info: WEL_LIST_VIEW_ITEM) is
			-- It is a request for the parent window to
			-- provide information needed to display or
			-- sort a list view item.
		require
			exists: exists
		do
		end

	on_lvn_insertitem (info: WEL_NM_LIST_VIEW) is
			-- A new item was inserted.
		require
			exists: exists
		do
		end

	on_lvn_itemchanged (info: WEL_NM_LIST_VIEW) is
			-- An item has changed.
		require
			exists: exists
		do
		end

	on_lvn_itemchanging (info: WEL_NM_LIST_VIEW) is
			-- An item is changing
		require
			exists: exists
		do
		end

	on_lvn_keydown (virtual_key: INTEGER) is
			-- A key has been pressed.
		require
			exists: exists
		do
		end

	on_lvn_setdispinfo (info: WEL_LIST_VIEW_ITEM) is
			-- The list must update the information it maintains
			-- for an item.
		require
			exists: exists
		do
		end

feature {WEL_COMPOSITE_WINDOW} -- Implementation

	process_notification_info (notification_info: WEL_NMHDR) is
			-- Process a `notification_code' sent by Windows
			-- through the Wm_notify message
		local
			nm_info: WEL_NM_LIST_VIEW
			disp_info: WEL_LV_DISPINFO
			keydown_info: WEL_LV_KEYDOWN
			code: INTEGER
		do
			code := notification_info.code
			inspect code
			when Lvn_begindrag then
				create nm_info.make_by_nmhdr (notification_info)
				on_lvn_begindrag (nm_info)
			when Lvn_beginlabeledit then
				create disp_info.make_by_nmhdr (notification_info)
				on_lvn_beginlabeledit (disp_info.list_item)
			when Lvn_beginrdrag then
				create nm_info.make_by_nmhdr (notification_info)
				on_lvn_beginrdrag (nm_info)
			when Lvn_columnclick then
				create nm_info.make_by_nmhdr (notification_info)
				on_lvn_columnclick (nm_info)
			when Lvn_deleteallitems then
				create nm_info.make_by_nmhdr (notification_info)
				on_lvn_deleteallitems (nm_info)
			when Lvn_deleteitem then
				create nm_info.make_by_nmhdr (notification_info)
				on_lvn_deleteitem (nm_info)
			when Lvn_endlabeledit then
				create disp_info.make_by_nmhdr (notification_info)
				on_lvn_endlabeledit (disp_info.list_item)
			when Lvn_getdispinfo then
				create disp_info.make_by_nmhdr (notification_info)
				on_lvn_getdispinfo (disp_info.list_item)
			when Lvn_insertitem then
				create nm_info.make_by_nmhdr (notification_info)
				on_lvn_insertitem (nm_info)
			when Lvn_itemchanged then
				create nm_info.make_by_nmhdr (notification_info)
				on_lvn_itemchanged (nm_info)
			when Lvn_itemchanging then
				create nm_info.make_by_nmhdr (notification_info)
				on_lvn_itemchanging (nm_info)
			when Lvn_keydown then
				create keydown_info.make_by_nmhdr (notification_info)
				on_lvn_keydown (keydown_info.virtual_key)
			when Lvn_setdispinfo then
				create disp_info.make_by_nmhdr (notification_info)
				on_lvn_setdispinfo (disp_info.list_item)
			when Lvn_getinfotip then
				--| FIXME ARNAUD: Implement it.
			else
			end
		end

feature {NONE} -- Implementation

	class_name: STRING is
			-- Window class name to create
		once
			create Result.make (0)
			Result.from_c (cwin_wc_listview)
		end

	default_style: INTEGER is
			-- Default style used to create the control
		once
			Result := Ws_visible + Ws_child + Ws_group +
				Ws_tabstop + Ws_border + Ws_clipchildren
				+ Lvs_report + Lvs_showselalways
		end

	buffer_size: INTEGER is 256
			-- Windows text retrieval buffer size

feature {NONE} -- Externals

	cwin_wc_listview: POINTER is
		external
			"C [macro %"cctrl.h%"] : EIF_POINTER"
		alias
			"WC_LISTVIEW"
		end

	ListView_Gettooltips (ptr: POINTER): POINTER is
		external
			"C [macro %"cctrl.h%"] (HWND): EIF_POINTER"
		alias
			"ListView_GetToolTips"
		end

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




end -- class WEL_LIST_VIEW

