indexing
	description: "Toolbar button state constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TB_STATE_CONSTANTS

feature -- Access

	Tbstate_checked: INTEGER is
			-- The button has the Tbstyle_checked style and is
			-- being pressed.
		external
			"C [macro <cctrl.h>]"
		alias
			"TBSTATE_CHECKED"
		end

	Tbstate_enabled: INTEGER is
			-- The button accepts user input. A button not having
			-- this state does not accept user input and is grayed.
		external
			"C [macro <cctrl.h>]"
		alias
			"TBSTATE_ENABLED"
		end

	Tbstate_hidden: INTEGER is
			-- The button is not visible and cannot receive user
			-- input.
		external
			"C [macro <cctrl.h>]"
		alias
			"TBSTATE_HIDDEN"
		end

	Tbstate_indeterminate: INTEGER is
			-- The button is grayed.
		external
			"C [macro <cctrl.h>]"
		alias
			"TBSTATE_INDETERMINATE"
		end

	Tbstate_pressed: INTEGER is
			-- The button is being pressed.
		external
			"C [macro <cctrl.h>]"
		alias
			"TBSTATE_PRESSED"
		end

	Tbstate_wrap: INTEGER is
			-- A line break follows the button. The button must
			-- also have the Tbstate_enabled state.
		external
			"C [macro <cctrl.h>]"
		alias
			"TBSTATE_WRAP"
		end

end -- class WEL_TB_STATE_CONSTANTS

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
