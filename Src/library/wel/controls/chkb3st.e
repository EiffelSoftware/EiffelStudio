indexing
	description: "Check box which has 3 states (on, off, indeterminated)."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CHECK_BOX_3_STATE

inherit
	WEL_CHECK_BOX
		redefine
			default_style
		end

creation
	make,
	make_by_id

feature -- Status report

	indeterminate: BOOLEAN is
			-- Is the state indeterminate?
		require
			exists: exists
		do
			Result := cwin_send_message_result (item,
				Bm_getcheck, 0, 0) = 2
		end

feature {NONE} -- Implementation

	default_style: INTEGER is
			-- Default style used to create the control
		once
			Result := Ws_visible + Ws_child + Ws_group +
				Ws_tabstop + Bs_auto3state
		end

end -- class WEL_CHECK_BOX_3_STATE

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
