indexing
	description: "A combo box which has a drop down list box."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_DROP_DOWN_LIST_COMBO_BOX

inherit
	WEL_COMBO_BOX

	WEL_CBS_CONSTANTS
		export
			{NONE} all
		end

creation
	make,
	make_by_id

feature -- Status setting

	show_drop_down is
		require
			exists: exists
		do
			cwin_send_message (item, Cb_showdropdown, 1, 0)
		ensure
			dropped_down: dropped_down
		end

	hide_drop_down is
		require
			exists: exists
		do
			cwin_send_message (item, Cb_showdropdown, 0, 0)
		ensure
			not_dropped_down: not dropped_down
		end

feature -- Status report

	dropped_down: BOOLEAN is
			-- Is the list box of the combo box dropped down?
		require
			exists: exists
		do
			Result := cwin_send_message_result (item,
					Cb_getdroppedstate, 0, 0) /= 0
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

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
