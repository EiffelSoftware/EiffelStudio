indexing
	description: "A combo box which has a drop down list box."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_DROP_DOWN_LIST_COMBO_BOX

inherit
	WEL_COMBO_BOX
		redefine
			height
		end

	WEL_CBS_CONSTANTS
		export
			{NONE} all
		end

creation
	make,
	make_by_id

feature -- Access

	height: INTEGER is
			-- Height including the list box
		do
			Result := dropped_rect.height
		end

feature -- Status setting

	show_list is
			-- Show the drop down list
		require
			exists: exists
		do
			cwin_send_message (item, Cb_showdropdown, 1, 0)
		ensure
			list_shown: list_shown
		end

	hide_list is
			-- Hide the drop down list
		require
			exists: exists
		do
			cwin_send_message (item, Cb_showdropdown, 0, 0)
		ensure
			list_not_shown: not list_shown
		end

feature -- Status report

	list_shown: BOOLEAN is
			-- Is the drop down list shown?
		require
			exists: exists
		do
			Result := cwin_send_message_result (item,
				Cb_getdroppedstate, 0, 0) /= 0
		end

feature -- Obsolete

	show_drop_down is obsolete "Use ``show_list''"
		require
			exists: exists
		do
			show_list
		ensure
			list_shown: list_shown
		end

	hide_drop_down is obsolete "Use ``hide_list''"
		require
			exists: exists
		do
			hide_list
		ensure
			list_not_shown: not list_shown
		end

	dropped_down: BOOLEAN is obsolete "Use ``list_shown''"
		require
			exists: exists
		do
			Result := list_shown
		end

feature {NONE} -- Implementation

	default_style: INTEGER is
			-- Default style used to create the control
		once
			Result := Ws_visible + Ws_child + Ws_group +
				Ws_tabstop + Ws_vscroll + Cbs_dropdownlist +
				Cbs_autohscroll
		end

end -- class WEL_DROP_DOWN_LIST_COMBO_BOX


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

