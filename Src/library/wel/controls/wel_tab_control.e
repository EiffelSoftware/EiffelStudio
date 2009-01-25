note
	description: "[
		This control is analogous to the dividers in a notebook
		or the labels in a file cabinet. By using a tab control, an
		application can define multiple pages for the same area of a
		window or dialog box. Each page consists of a set of
		information or a group of controls that the application
		displays when the user selects the corresponding tab. A
		special type of tab control displays tabs that look like
		buttons. Clicking a button should immediately perform a
		command instead of displaying a page.

		Note: The common controls dll (WEL_COMMON_CONTROLS_DLL) needs to
			be loaded to use this control.
			Inheritance from WEL_COMPOSITE_WINDOW in order to propagate the
			events (most especially wm_command and wm_notify) to the children.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TAB_CONTROL

inherit
	WEL_CONTROL
		undefine
			process_message,
			on_getdlgcode,
			on_wm_notify
		redefine
			process_notification_info,
			resize,
			move_and_resize,
			on_erase_background
		end

	WEL_COMPOSITE_WINDOW
		undefine
			destroy,
			on_wm_destroy,
			on_wm_erase_background,
			set_default_window_procedure,
			call_default_window_procedure,
			minimal_width,
			minimal_height,
			move
		redefine
			on_wm_paint,
			resize,
			move_and_resize,
			on_erase_background
		end

	WEL_TCM_CONSTANTS
		export
			{NONE} all
		end

	WEL_TCS_CONSTANTS
		export
			{NONE} all
		end

	WEL_TCN_CONSTANTS
		export
			{NONE} all
		end

	WEL_RGN_CONSTANTS
		export {NONE}
			all
		end

create
	make,
	make_by_id

feature {NONE} -- Initialization

	make (a_parent: WEL_WINDOW; a_x, a_y, a_width, a_height, an_id: INTEGER)
			-- Make a tab control.
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

	count: INTEGER
			-- Number of tabs in the tab control
		require
			exists: exists
		do
			Result := {WEL_API}.send_message_result_integer (item,Tcm_getitemcount, to_wparam (0), to_lparam (0))
		ensure
			positive_result: Result >= 0
		end

	row_count: INTEGER
			-- Number of tab rows in the tab control
		require
			exists: exists
		do
			Result := {WEL_API}.send_message_result_integer (item, Tcm_getrowcount, to_wparam (0), to_lparam (0))
		ensure
			positive_result: Result >= 0
		end

	sheet_rect: WEL_RECT
			-- Client area of each tab sheet
			-- (excluding the labeled index)
			-- Windows require in multiline mode to have at least
			-- two element in the notebook to have access to this
			-- data or to be currently showing the tab control.
			-- If this condition are not satisfied, Windows will raise
			-- a segmentation violation.
		require
			exists: exists
		do
			Result := client_rect
			{WEL_API}.send_message (item, Tcm_adjustrect, to_wparam (0), Result.item)
		end

	label_index_rect: WEL_RECT
			-- Labeled index area of selected tab
			-- (excluding the tab sheet)
		do
			create Result.make (0, 0, 0, 0)
			{WEL_API}.send_message (item, Tcm_getitemrect, to_wparam (current_selection), Result.item)
		end

feature -- Status report

	current_selection: INTEGER
			-- Selected zero-based tab
		require
			exists: exists
		do
			Result := {WEL_API}.send_message_result_integer (item, Tcm_getcursel, to_wparam (0), to_lparam (0))
		ensure
			consistent_result: Result /= -1 implies Result >= 0 and Result < count
		end

	selected_window: ?WEL_WINDOW
			-- Window corresponding to currently selected tab
		do
			Result := get_item (current_selection).window
		end

	get_item (index: INTEGER): WEL_TAB_CONTROL_ITEM
			-- Give the item at the zero-based index of tab.
			-- As we must give a maximum size for the retrieving
			-- of the label, we allow only `buffer_size' letters. If the
			-- label is longer, it will be cut.
		require
			exists: exists
		local
			buffer: STRING_32
		do
			create Result.make
			create buffer.make (buffer_size)
			buffer.fill_blank
			Result.set_text (buffer)
			Result.set_cchtextmax (buffer_size)
			{WEL_API}.send_message (item, Tcm_getitem, to_wparam (index), Result.item)
		end

	background_region (invalid_rect: WEL_RECT): WEL_REGION
			-- `Result' is a background region of `Current' that needs
			-- re-drawing when `invalid_rect' is invalidated.
		require
			invalid_rect_not_void: invalid_rect /= Void
		local
			tmp_region, new_region: WEL_REGION
			i, a_count, sel, cur_style: INTEGER
			r: WEL_RECT
			is_vertical, is_bottom, is_right: BOOLEAN
			r_addr: POINTER
			l_item: POINTER
		do
						-- Find out where tabs are located.
			cur_style := style
			is_bottom := flag_set (cur_style, Tcs_bottom)
			is_vertical := flag_set (cur_style, Tcs_vertical)
			is_right := flag_set (cur_style, Tcs_right)

				-- Create the region as the invalid area of `Current' that
				-- needs to be redrawn.
			create Result.make_rect_indirect (invalid_rect)
			create r.make (0, 0, 0, 0)
			r_addr := r.item

				-- Remove from region the area corresponding to tabs.
				-- For a non selected tab, the area returned is too big, we need
				-- to make it smaller because only the text will be updated,
				-- not the part that is close to the notebook area.
				-- For a selected tab, the area returned is too small, we need
				-- to make it bigger to avoid the tab of flickering.
			from
				i := 0
				a_count := count
				sel := current_selection
				l_item := item
			until
				i = a_count
			loop
				{WEL_API}.send_message (l_item, Tcm_getitemrect, to_wparam (i), r_addr)
				if i /= sel then
					if is_bottom then
						r.set_top (r.top + 2)
					elseif is_vertical then
						if is_right then
							r.set_left (r.left + 2)
						else
							r.set_right (r.right - 2)
						end
					else
						r.set_bottom (r.bottom - 2)
					end
				else
					if is_bottom then
						r.set_bottom (r.bottom + 2)
					elseif is_vertical then
						if is_right then
							r.set_right (r.right + 2)
						else
							r.set_left (r.left - 2)
						end
					else
						r.set_top (r.top - 2)

					end
				end
				create tmp_region.make_rect_indirect (r)
				new_region := Result.combine (tmp_region, Rgn_diff)
				tmp_region.delete
				Result.delete
				Result := new_region
				i := i + 1
			end
		ensure
			Result_not_void: Result /= Void
		end

feature -- Status setting

	set_current_selection (index: INTEGER)
			-- Set the zero-based tab `index'.
		require
			exists: exists
			index_large_enough: index >= 0
			index_small_enough: index < count
		do
			on_tcn_selchanging
			{WEL_API}.send_message (item, Tcm_setcursel, to_wparam (index), to_lparam (0))
			on_tcn_selchange
		ensure
			current_selection_set: current_selection = index
		end

	set_vertical_font (fnt: WEL_FONT)
			-- Assign `font' to the vertical tabs of this tab control.
			-- (Cannot use `set_font' since its postcondition is not always fulfilled)
			-- To use for a notebook with the tabs on the left or
			-- the right.
		require
			exists: exists
			fnt_not_void: fnt /= Void
		do
			{WEL_API}.send_message (item, wm_setfont, fnt.item, cwin_make_long (1, 0))
		end

feature -- Element change

	update_item (index: INTEGER; an_item: WEL_TAB_CONTROL_ITEM)
			-- Sets some or all of the `index'-th tab's attributes. Attributes values
			-- are taken from `an_item'. See `an_item.mask' for selected attributes.
		require
			exists: exists
			an_item_not_void: an_item /= Void
			index_large_enough: index >= 0
			index_small_enough: index <= count
		do
			{WEL_API}.send_message (item, Tcm_setitem, to_wparam (index), an_item.item)
		end

	insert_item (index: INTEGER; an_item: WEL_TAB_CONTROL_ITEM)
			-- Insert `an_item' at the zero-based `index'.
		require
			exists: exists
			an_item_not_void: an_item /= Void
			index_large_enough: index >= 0
			index_small_enough: index <= count
		local
			window: ?WEL_WINDOW
		do
			{WEL_API}.send_message (item, Tcm_insertitem, to_wparam (index), an_item.item)
			window := an_item.window
			if window /= Void and then window.exists then
				if index = 0 then
					window.show
				else
					window.hide
				end
			end
		ensure
			count_increased: count = old count + 1
		end

	delete_item (index: INTEGER)
			-- Delete the item at the zero-based `index'.
		require
			exists: exists
			index_large_enough: index >= 0
			index_small_enough: index < count
		do
			{WEL_API}.send_message (item, Tcm_deleteitem, to_wparam (index), to_lparam (0))
		ensure
			count_decreased: count = old count - 1
		end

	delete_all_items
			-- Delete all items.
		require
			exists: exists
		do
			{WEL_API}.send_message (item, Tcm_deleteallitems, to_wparam (0), to_lparam (0))
		ensure
			empty: count = 0
		end

	set_label_index_size (new_width, new_height: INTEGER)
			-- Set size of labeled index area of each tab
			-- Width is only reset if tabs are fixed-width; height is always reset
		do
			{WEL_API}.send_message (item, Tcm_setitemsize, to_wparam (0), cwin_make_long (new_width, new_height))
		end

feature -- Notifications

	on_tcn_keydown (virtual_key, key_data: INTEGER)
			-- A key has been pressed
		require
			exists: exists
		do
		end

	on_tcn_selchange
			-- Selection has changed.
			-- Shows the current selected page by default.
		require
			exists: exists
		do
			show_current_selection
		end

	on_tcn_selchanging
			-- Selection is about to change.
			-- Hides the current selected page by default.
		require
			exists: exists
		do
			hide_current_selection
		end

feature {NONE} -- Basic operation

	hide_current_selection
			-- Hide the current selected page.
		require
			exists: exists
		local
			selected_item: ?WEL_WINDOW
		do
			selected_item := get_item (current_selection).window
			if selected_item /= Void and then selected_item.exists then
				selected_item.hide
			end
		end

	show_current_selection
			-- Show the current selected page.
		require
			exists: exists
		local
			selected_item: ?WEL_WINDOW
		do
			selected_item := get_item (current_selection).window
			if selected_item /= Void and then selected_item.exists then
				selected_item.show
			end
		end

	adjust_items
			-- Adjust the size of the windows of the items
			-- to the current size.
		local
			index: INTEGER
			l_window: ?WEL_WINDOW
		do
			from
				index := 0
			until
				index = count
			loop
				l_window := get_item (index).window
				if l_window /= Void then
					l_window.move_and_resize (sheet_rect.left, sheet_rect.top, sheet_rect.width, sheet_rect.height, False)
				end
				index := index + 1
			end
		end

feature {WEL_COMPOSITE_WINDOW} -- Implementation

	process_notification_info (notification_info: WEL_NMHDR)
			-- Process a `notification_code' sent by Windows
			-- through the Wm_notify message
		local
			keydown_info: WEL_TC_KEYDOWN
			code: INTEGER
		do
			code := notification_info.code
			if code = Tcn_keydown then
				create keydown_info.make_by_nmhdr (notification_info)
				on_tcn_keydown (keydown_info.virtual_key, keydown_info.key_data)
			elseif code = Tcn_selchange then
				on_tcn_selchange
			elseif code = Tcn_selchanging then
				on_tcn_selchanging
			end
		end

	resize (a_width, a_height: INTEGER)
   			-- Resize the window with `a_width', `a_height'.
 		do
 			Precursor {WEL_CONTROL} (a_width, a_height)
			adjust_items
		end

	move_and_resize (a_x, a_y, a_width, a_height: INTEGER; repaint: BOOLEAN)
   			-- Move the window to `a_x', `a_y' position and
   			-- resize it with `a_width', `a_height'.
		do
			Precursor {WEL_CONTROL} (a_x, a_y, a_width, a_height, repaint)
			adjust_items
		end

	on_erase_background (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT)
			-- Wm_erasebkgnd message.
			-- May be redefined to paint something on
			-- the `paint_dc'. `invalid_rect' defines
			-- the invalid rectangle of the client area that
			-- needs to be repainted.
		local
			bk_brush: ?WEL_BRUSH
			a_background_region: WEL_REGION
		do
			bk_brush := background_brush

			if bk_brush /= Void then
					--| Disable the default windows processing and return correct
					--| value to Windows, i.e. nonzero value.
				disable_default_processing
				set_message_return_value (to_lresult (1))


				a_background_region := background_region (invalid_rect)
					-- Fill the remaining region, `main_region'.
				paint_dc.fill_region (a_background_region, bk_brush)

					-- Clean up GDI objects
				bk_brush.delete
				a_background_region.delete
			end
		end

feature {NONE} -- Implementation

	class_name: STRING_32
			-- Window class name to create
		once
			Result := (create {WEL_STRING}.share_from_pointer (cwin_tabcontrol_class)).string
		end

	default_style: INTEGER
			-- Default style used to create the control
		once
			Result := Ws_visible + Ws_child + Ws_group + Ws_tabstop
						+ Tcs_multiline
		end

	buffer_size: INTEGER = 256
			-- Windows text retrieval buffer size

  	on_wm_paint (wparam: POINTER)
   			-- Wm_paint message.
   			-- Need to do nothing
   		do
 		end

	dummy_tab_item: WEL_TAB_CONTROL_ITEM
		once
			create Result.make
		end

feature {NONE} -- Externals

	cwin_tabcontrol_class: POINTER
		external
			"C [macro %"cctrl.h%"] : EIF_POINTER"
		alias
			"WC_TABCONTROL"
		end

	cwin_set_item_size (hwnd: POINTER; cx, cy: INTEGER)
			-- Change the parent of the given child
		external
			"C [macro <commctrl.h>] (HWND, EIF_INTEGER, EIF_INTEGER)"
		alias
			"TabCtrl_SetItemSize"
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




end -- class WEL_TAB_CONTROL

