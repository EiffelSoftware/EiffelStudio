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
			"C [macro <cctrl.h>]"
		alias
			"TCN_KEYDOWN"
		end

	Tcn_selchange: INTEGER is
			-- Notifies a tab control's parent window that the
			-- currently selected tab has changed.
		external
			"C [macro <cctrl.h>]"
		alias
			"TCN_SELCHANGE"
		end

	Tcn_selchanging: INTEGER is
			-- Notifies a tab control's parent window that the
			-- currently selected tab is about to change.
		external
			"C [macro <cctrl.h>]"
		alias
			"TCN_SELCHANGING"
		end

end -- class WEL_TCN_CONSTANTS

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-1997, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
