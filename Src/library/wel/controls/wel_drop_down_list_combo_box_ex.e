indexing
	description: "Objects that ..."
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

create
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
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

