indexing
	description: "List box which can have only one selection."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_SINGLE_SELECTION_LIST_BOX

inherit
	WEL_LIST_BOX

	WEL_LBS_CONSTANTS
		export
			{NONE} all
		end

creation
	make,
	make_by_id

feature -- Status setting

	select_item (index: INTEGER) is
			-- Select item at the zero-based `index'.
		do
			cwin_send_message (item, Lb_setcursel, index, 0)
		ensure then
			selected: selected
			selected_item: selected_item = index
			selected_string: strings.item (index).is_equal (selected_string)
		end

	unselect is
			-- Unselect the selected item.
		require
			exists: exists
		do
			cwin_send_message (item, Lb_setcursel, -1, 0)
		ensure
			unselected: not selected
		end

feature -- Status report

	selected: BOOLEAN is
			-- Is an item selected?
		do
			Result := cwin_send_message_result (item,
				Lb_getcursel, 0, 0) /= Lb_err
		end

	selected_item: INTEGER is
			-- Zero-based index of the selected item
		require
			exists: exists
			selected: selected
		do
			Result := cwin_send_message_result (item,
				Lb_getcursel, 0, 0)
		ensure
			result_large_enough: Result >= 0
			result_small_enough: Result < count
		end

	selected_string: STRING is
			-- Selected string
		require
			exists: exists
			selected: selected
		do
			Result := i_th_text (selected_item)
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	default_style: INTEGER is
			-- Default style used to create the control
		once
			Result := Ws_visible + Ws_child + Ws_group +
				Ws_tabstop + Ws_border + Ws_vscroll +
				Lbs_notify
		end

invariant
	consistent_selection: exists and then selected implies
		is_selected (selected_item) and
		strings.item (selected_item).is_equal (selected_string)

end -- class WEL_SINGLE_SELECTION_LIST_BOX


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

