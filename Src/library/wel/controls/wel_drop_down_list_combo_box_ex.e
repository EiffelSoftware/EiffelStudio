indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_DROP_DOWN_LIST_COMBO_BOX_EX

inherit
	WEL_COMBO_BOX_EX
		redefine
			text_length,
			text
		end

creation
	make

feature -- Status report

	text_length: INTEGER is
			-- Text length
		do
			Result := selected_string.count
		end

	text: STRING is
			-- Window text
		do
			Result := selected_string
		end

feature {NONE} -- Implementation

	default_style: INTEGER is
			-- Default style used to create the control
		once
			Result := Ws_visible + Ws_child + Ws_border
				+ Cbs_dropdownlist + Cbs_autohscroll
		end

end -- class WEL_DROP_DOWN_LIST_COMBO_BOX_EX


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

