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
		%be loaded to use this control."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TAB_CONTROL

inherit
	WEL_CONTROL

	WEL_TCM_CONSTANTS
		export
			{NONE} all
		end

	WEL_TCS_CONSTANTS
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

feature -- Element change

	insert_item (index: INTEGER; an_item: WEL_TAB_CONTROL_ITEM) is
			-- Insert `an_item' at the zero-based `index'.
		require
			exists: exists
			an_item_not_void: an_item /= Void
			index_large_enough: index >= 0
			index_small_enough: index <= count
		do
			cwin_send_message (item, Tcm_insertitem, index,
				an_item.to_integer)
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

feature -- Status setting

	set_current_selection (index: INTEGER) is
			-- Set the zero-based tab `index'.
		require
			exists: exists
			index_large_enough: index >= 0
			index_small_enough: index < count
		do
			cwin_send_message (item, Tcm_setcursel, index, 0)
		ensure
			current_selection_set: current_selection = index
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
		end

feature {NONE} -- Externals

	cwin_tabcontrol_class: POINTER is
		external
			"C [macro <cctrl.h>]"
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

