indexing
	description: "Tooltip Notification (TTN) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TTN_CONSTANTS

feature -- Access

	Ttn_needtext: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TTN_NEEDTEXT"
		end

	Ttn_pop: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TTN_POP"
		end

	Ttn_show: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TTN_SHOW"
		end

end -- class WEL_TTN_CONSTANTS

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
