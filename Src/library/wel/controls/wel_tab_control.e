indexing
	description: "This control is analogous to the dividers in a notebook %
		%or the labels in a file cabinet. By using a tab control, an %
		%application can define multiple pages for the same area of a %
		%window or dialog box. Each page consists of a set of %
		%information or a group of controls that the application %
		%displays when the user selects the corresponding tab. A %
		%special type of tab control displays tabs that look like %
		%buttons. Clicking a button should immediately perform a %
		%command instead of displaying a page."
	note: "The common controls dll (WEL_COMMON_CONTROLS_DLL) needs to %
		%be loaded to use this control.%
		%Inheritance from WEL_COMPOSITE_WINDOW in order to propagate the%
		%events (most especially wm_command and wm_notify) to the children."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TAB_CONTROL

inherit
	WEL_CONTROL
		undefine
			process_message,
			on_wm_notify
		redefine
			process_notification_info,
			resize,
			move_and_resize
		end

	WEL_COMPOSITE_WINDOW
		undefine
			destroy,
			on_wm_destroy,
			set_default_window_procedure,
			call_default_window_procedure,
			minimal_width,
			minimal_height,
			move
		redefine
			on_wm_paint,
			resize,
			move_and_resize
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

creation
	make,
	make_by_id

feature {NONE} -- Initialization

	make (a_parent: WEL_WINDOW; a_x, a_y, a_width, a_height, an_id: INTEGER) is
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

	count: INTEGER is
			-- Number of tabs in the tab control
		require
			exists: exists
		do
			Result := cwin_send_message_result (item,
				Tcm_getitemcount, 0, 0)
		ensure
			positive_result: Result >= 0
		end

	row_count: INTEGER is
			-- Number of tab rows in the tab control
		require
			exists: exists
		do
			Result := cwin_send_message_result (item, Tcm_getrowcount, 0 ,0)
		ensure
			positive_result: Result >= 0
		end

	sheet_rect: WEL_RECT is
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
			cwin_send_message (item, Tcm_adjustrect, 0, Result.to_integer)
		end

	label_index_rect: WEL_RECT is
			-- Labeled index area of selected tab
			-- (excluding the tab sheet)
		do
			!! Result.make (0, 0, 0, 0)
			cwin_send_message (item, Tcm_getitemrect, current_selection, Result.to_integer)
		end

feature -- Status report

	current_selection: INTEGER is
			-- Selected zero-based tab
		require
			exists: exists
		do
			Result := cwin_send_message_result (item,
				Tcm_getcursel, 0, 0)
		ensure
			consistent_result: Result >= 0 and Result < count
		end

	get_item (index: INTEGER): WEL_TAB_CONTROL_ITEM is
			-- Give the item at the zero-based index of tab.
			-- As we must give a maximum size for the retrieving
			-- of the label, we allow only 30 letters. If the
			-- label is longer, it will be cut.
		require
			exists: exists
		do
			!! Result.make
			Result.set_text ("")
			Result.set_cchtextmax (30)
			cwin_send_message (item, Tcm_getitem, index, Result.to_integer)
		end

feature -- Status setting

	set_current_selection (index: INTEGER) is
			-- Set the zero-based tab `index'.
		require
			exists: exists
			index_large_enough: index >= 0
			index_small_enough: index < count
		do
			on_tcn_selchanging
			cwin_send_message (item, Tcm_setcursel, index, 0)
			on_tcn_selchange
		ensure
			current_selection_set: current_selection = index
		end

	set_vertical_font (fnt: WEL_FONT) is
			-- Assign `font' to the vertical tabs of this tab control.
			-- (Cannot use `set_font' since its postcondition is not always fulfilled)
			-- To use for a notebook with the tabs on the left or 
			-- the right.
		do
			cwin_send_message (item, wm_setfont, cwel_pointer_to_integer (fnt.item), cwin_make_long (1, 0))
		end			

feature -- Element change

	insert_item (index: INTEGER; an_item: WEL_TAB_CONTROL_ITEM) is
			-- Insert `an_item' at the zero-based `index'.
		require
			exists: exists
			an_item_not_void: an_item /= Void
			index_large_enough: index >= 0
			index_small_enough: index <= count
		local
			window: WEL_WINDOW
		do
			cwin_send_message (item, Tcm_insertitem, index,
				an_item.to_integer)
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

	delete_item (index: INTEGER) is
			-- Delete the item at the zero-based `index'.
		require
			exists: exists
			index_large_enough: index >= 0
			index_small_enough: index < count
		do
			cwin_send_message (item, Tcm_deleteitem, index, 0)
		ensure
			count_decreased: count = old count - 1
		end

	delete_all_items is
			-- Delete all items.
		require
			exists: exists
		do
			cwin_send_message (item, Tcm_deleteallitems, 0, 0)
		ensure
			empty: count = 0
		end

	set_label_index_size (new_width, new_height: INTEGER) is
			-- Set size of labeled index area of each tab
			-- Width is only reset if tabs are fixed-width; height is always reset
		do
			cwin_send_message (item, Tcm_Setitemsize, 0, cwin_make_long (new_width, new_height))
		end

feature -- Notifications

	on_tcn_keydown (virtual_key, key_data: INTEGER) is
			-- A key has been pressed
		require
			exists: exists
		do
		end

	on_tcn_selchange is
			-- Selection has changed.
			-- Shows the current selected page by default.
		require
			exists: exists
		do
			show_current_selection
		end

	on_tcn_selchanging is
			-- Selection is about to change.
			-- Hides the current selected page by default.
		require
			exists: exists
		do
			hide_current_selection
		end

feature {NONE} -- Basic operation

	hide_current_selection is
			-- Hide the current selected page.
		require
			exists: exists
		local
			selected_item: WEL_TAB_CONTROL_ITEM
		do
			selected_item := get_item (current_selection)
			if selected_item.window /= Void and then selected_item.window.exists then
				selected_item.window.hide
			end
		end

	show_current_selection is
			-- Show the current selected page.
		require
			exists: exists
		local
			selected_item: WEL_TAB_CONTROL_ITEM
		do
			selected_item := get_item (current_selection)
			if selected_item.window /= Void and then selected_item.window.exists then
				selected_item.window.show
			end
		end

	adjust_items is
			-- Adjust the size of the windows of the items
			-- to the current size.
		local
			index: INTEGER
			child_item: WEL_TAB_CONTROL_ITEM
		do
			from
				index := 0
			until
				index = count
			loop
				child_item := get_item (index)
				child_item.window.move_and_resize (sheet_rect.left, sheet_rect.top, sheet_rect.width, sheet_rect.height, False)
				index := index + 1
			end
		end

feature {WEL_COMPOSITE_WINDOW} -- Implementation

	process_notification_info (notification_info: WEL_NMHDR) is
			-- Process a `notification_code' sent by Windows
			-- through the Wm_notify message
		local
			keydown_info: WEL_TC_KEYDOWN
			code: INTEGER
		do
			code := notification_info.code
			if code = Tcn_keydown then
				!! keydown_info.make_by_nmhdr (notification_info)
				on_tcn_keydown (keydown_info.virtual_key, keydown_info.key_data)
			elseif code = Tcn_selchange then
				on_tcn_selchange
			elseif code = Tcn_selchanging then
				on_tcn_selchanging
			end
		end

	resize (a_width, a_height: INTEGER) is
   			-- Resize the window with `a_width', `a_height'.
 		do
 			{WEL_CONTROL} Precursor (a_width, a_height)
			adjust_items
		end

	move_and_resize (a_x, a_y, a_width, a_height: INTEGER; repaint: BOOLEAN) is
   			-- Move the window to `a_x', `a_y' position and
   			-- resize it with `a_width', `a_height'.
		do
			{WEL_CONTROL} Precursor (a_x, a_y, a_width, a_height, repaint)
			adjust_items
		end

feature {NONE} -- Implementation

	class_name: STRING is
			-- Window class name to create
		once
			!! Result.make (0)
			Result.from_c (cwin_tabcontrol_class)
		end

	default_style: INTEGER is
			-- Default style used to create the control
		once
			Result := Ws_visible + Ws_child + Ws_group + Ws_tabstop
						+ Tcs_multiline
		end

  	on_wm_paint (wparam: INTEGER) is
   			-- Wm_paint message.
   			-- Need to do nothing
   		do
 		end

feature {NONE} -- Externals

	cwin_tabcontrol_class: POINTER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"WC_TABCONTROL"
		end

end -- class WEL_TAB_CONTROL

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

