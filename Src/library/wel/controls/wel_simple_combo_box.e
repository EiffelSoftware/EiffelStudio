indexing
	description: "A combox box with an edit control and a list box %
		%always open."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_SIMPLE_COMBO_BOX

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

	set_limit_text (limit: INTEGER) is
			-- Set the length of the text the user may type.
		require
			exists: exists
			positive_limit: limit >= 0
		do
			cwin_send_message (item, Cb_limittext, limit, 0)
		end

feature {NONE} -- Implementation

	default_style: INTEGER is
			-- Default style used to create the control
		once
			Result := Ws_visible + Ws_child + Ws_group +
				Ws_tabstop + Ws_vscroll + Cbs_simple +
				Cbs_autohscroll
		end

end -- class WEL_SIMPLE_COMBO_BOX


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

