indexing
	description: "Control that displays a multi-column list of items."
	note: "The common controls dll (WEL_COMMON_CONTROLS_DLL) needs to %
		%be loaded to use this control."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_LIST_VIEW

inherit
	WEL_CONTROL
		redefine
			process_notification
		end

	WEL_LVS_CONSTANTS
		export
			{NONE} all
		end

	WEL_LVM_CONSTANTS
		export
			{NONE} all
		end

	WEL_LVN_CONSTANTS
		export
			{NONE} all
		end

	WEL_LVIF_CONSTANTS
		export
			{NONE} all
		end

	WEL_LVIS_CONSTANTS
		export
			{NONE} all
		end

	WEL_LVNI_CONSTANTS
		export
			{NONE} all
		end

	WEL_LVCF_CONSTANTS

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
			Result := cwin_send_message_result (item,
						Lvm_getitemcount, 0, 0)
		end

	visible_count: INTEGER is
			-- Number of items that will fit in the list view window
		require
			exists: exists
		do
			Result := cwin_send_message_result (item,
						Lvm_getcountperpage, 0, 0)
		end

	selected_count: INTEGER is
			-- Number of selected items in the list view window
		require
			exists: exists
		do
			Result := cwin_send_message_result (item, 
						Lvm_getselectedcount, 0, 0)
		end

	top_index: INTEGER is
			-- Index of the first visible item
		require
			exists
		do
			Result := cwin_send_message_result (item, 
						Lvm_gettopindex, 0, 0)
		ensure
			result_large_enough: Result >= 0
			result_small_enough: Result < count
		end

	focus_item: INTEGER is
			-- Zero-based index of the item that has the focus
			-- Return -1 if there is none.
		require
			exists: exists
		do
			Result := cwin_send_message_result (item, 
						Lvm_getnextitem, -1, Lvni_focused)
		ensure
			result_large_enough: Result >= 0
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
			from
				!! Result.make (0, selected_count - 1)
				result_count := 0
				index := -1
			until
				index >= count
			loop
				index := cwin_send_message_result (item, Lvm_getnextitem,
							index, Lvni_selected)
				Result.put (index, result_count)
				result_count := result_count + 1
			end
		ensure
			result_not_void: Result /= Void
		--	count_ok: result_count = selected_count
		end

	get_column_width (index: INTEGER): INTEGER is
			-- Width of the zero-based `index'-th item.
		require
			exists: exists
			index_large_enough: index >= 0
			index_small_enough: index < column_count
		do
			Result := cwin_send_message_result (item, Lvm_getcolumnwidth, index, 0)
		end

	get_item_state (index: INTEGER): INTEGER is
			-- State of the zero-based `index'-th item. See WEL_LVIF_CONSTANTS for
			-- the state constants.
		require
			exists: exists
			index_large_enough: index >= 0
			index_small_enough: index < column_count
		do
			Result := cwin_send_message_result (item, Lvm_getitemstate, index, 0)
		end

feature -- Status setting

	set_column_width (value, index: INTEGER) is
			-- Make `value' the new width of the zero-base `index'-th column.
		require
			exists: exists
			index_large_enough: index >= 0
			index_small_enough: index < column_count
		do
			cwin_send_message (item, Lvm_setcolumnwidth, index, value)
		end

	update_item (index: INTEGER) is
			-- Update the list view.
		require
			exists: exists
			index_large_enough: index >= 0
			index_small_enough: index < count
		do
			cwin_send_message (item, Lvm_update, index, 0)
		end	

	set_item_state (index, value: INTEGER) is
			-- Make `vaue' the new state of the zero-based `index'-th item.
			-- See WEL_LVIF_CONSTANTS for the state constants.
		require
			exists: exists
			index_large_enough: index >= 0
			index_small_enough: index < column_count
		local
			an_item: WEL_LIST_VIEW_ITEM
		do
			!! an_item.make_with_attributes (value, index, 0, 0, "")
			cwin_send_message (item, Lvm_setitemstate, index, an_item.to_integer)
		end

	set_item_count (value: INTEGER) is
			-- Prepares a list view control for adding a large number
			-- of items and make it then faster.
		require
			exists: exists
			value_big_enough: value >= 0
		do
			cwin_send_message (item, Lvm_setitemcount, value, 0)
		end	

	set_cell_text (i,j: INTEGER; txt: STRING) is
			-- Set the label of the cell with coordinates `i', `j' with `txt'.
		require
			exists: exists
			i_large_enough: i >= 0
			j_large_enough: j >= 0
			i_small_enough: i < column_count
			j_small_enough: j < count
		local
			an_item: WEL_LIST_VIEW_ITEM
		do
			!! an_item.make_with_attributes (Lvif_text, j, i, 0, txt)
			cwin_send_message (item, Lvm_setitemtext, j, an_item.to_integer)
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
			!! a_column.make_with_attributes (Lvcf_text, index, 0, txt)
			cwin_send_message (item, Lvm_setcolumn, index, a_column.to_integer)
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
			!! a_column.make_with_attributes (Lvcf_fmt, index, fmt, "")
			cwin_send_message (item, Lvm_setcolumn, index, a_column.to_integer)
		end

feature -- Element change

	append_column (column: WEL_LIST_VIEW_COLUMN) is
			-- Append `column' to the list view.
		require
			exists: exists
		do
			cwin_send_message (item, Lvm_insertcolumn, column_count, column.to_integer)
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
			cwin_send_message (item, Lvm_insertcolumn, index, column.to_integer)
			column_count := column_count + 1
		ensure
			new_column_count: column_count = old column_count + 1
		end

	prepend_column (column: WEL_LIST_VIEW_COLUMN) is
			-- Prepend `column' to the list view.
		require
			exists: exists
		do
			cwin_send_message (item, Lvm_insertcolumn, 0, column.to_integer)
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
			cwin_send_message (item, Lvm_deletecolumn, index, 0)
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
			cwin_send_message (item, Lvm_insertitem, 0, an_item.to_integer)
		ensure
			new_count: count = old count + 1
		end

	delete_item (index: INTEGER) is
			-- Remove the zero-based `index'-th item of the list view.
		require
			exists: exists
			index_large_enough: index >= 0
			index_small_enough: index < count
		do
			cwin_send_message (item, Lvm_deleteitem, index, 0)
		ensure
			new_count: count = old count - 1
		end

	reset_content is
			-- Reset the content of the list.
		require
			exists: exists
		do
			cwin_send_message (item, Lvm_deleteallitems, 0, 0)
		ensure
			new_count: count = 0
		end

feature -- Notifications

	on_lvn_itemchanged is
			-- An item has changed.
		require
			exists: exists
		do
		end

	on_lvn_itemchanging is
			-- An item is changing
		require
			exists: exists
		do
		end

	on_lvn_keydown is
			-- A key has been pressed.
		require
			exists: exists
		do
		end

	on_lvn_columnclick is
			-- A column was tapped.
		require
			exists: exists
		do
		end

	on_lvn_insertitem is
			-- A new item was inserted.
		require
			exists: exists
		do
		end

	on_lvn_beginlabeledit is
			-- A label editing for an item has started.
		require
			exists: exists
		do
		end

	on_lvn_endlabeledit is
			-- A label editing for an item has ended.
		require
			exists: exists
		do
		end

	on_lvn_deleteallitems is
			-- All the items were deleted.
		require
			exists: exists
		do
		end

	on_lvn_deleteitem is
			-- An item was deleted.
		require
			exists: exists
		do
		end

feature {WEL_COMPOSITE_WINDOW} -- Implementation

	process_notification (notification_code: INTEGER) is
			-- Process a `notification_code' sent by Windows
			-- through the Wm_notify message
		do
			if notification_code = Lvn_itemchanged then
				on_lvn_itemchanged
			elseif notification_code = Lvn_itemchanging then
				on_lvn_itemchanging
			elseif notification_code = Lvn_keydown then
				on_lvn_keydown
			elseif notification_code = Lvn_columnclick then
				on_lvn_columnclick
			elseif notification_code = Lvn_insertitem then
				on_lvn_insertitem
			elseif notification_code = Lvn_beginlabeledit then
				on_lvn_beginlabeledit
			elseif notification_code = Lvn_endlabeledit then
				on_lvn_endlabeledit
			elseif notification_code = Lvn_deleteallitems then
				on_lvn_deleteallitems
			elseif notification_code = Lvn_deleteitem then
				on_lvn_deleteitem
			else
				default_process_notification (notification_code)
			end
		end

feature {NONE} -- Implementation

	class_name: STRING is
			-- Window class name to create
		once
			!! Result.make (0)
			Result.from_c (cwin_wc_listview)
		end

	default_style: INTEGER is
			-- Default style used to create the control
		once
			Result := Ws_visible + Ws_child + Ws_group +
				Ws_tabstop + Ws_border + Ws_clipchildren
				+ Lvs_report + Lvs_showselalways
		end

feature {NONE} -- Externals

	cwin_wc_listview: POINTER is
		external
			"C [macro <cctrl.h>]"
		alias
			"WC_LISTVIEW"
		end

invariant
	invariant_clause: -- Your invariant here

end -- class WEL_LIST_VIEW

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
--|----------------------------------------------------------------

