indexing
	description: "Tab control notification (TCN) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TCN_CONSTANTS

feature -- Access

	Tcn_keydown: INTEGER is
			-- Notifies a tab control's parent window that a key
			-- has been pressed.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TCN_KEYDOWN"
		end

	Tcn_selchange: INTEGER is
			-- Notifies a tab control's parent window that the
			-- currently selected tab has changed.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TCN_SELCHANGE"
		end

	Tcn_selchanging: INTEGER is
			-- Notifies a tab control's parent window that the
			-- currently selected tab is about to change.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TCN_SELCHANGING"
		end

end -- class WEL_TCN_CONSTANTS

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

