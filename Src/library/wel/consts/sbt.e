indexing
	description: "Status window text constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_SBT_CONSTANTS

feature -- Access

	Sbt_borders: INTEGER is 0
			-- The text is drawn with a border to appear
			-- lower than the plane of the window.

	Sbt_noborders: INTEGER is
			-- The text is drawn without borders.
		external
			"C [macro <cctrl.h>]"
		alias
			"SBT_NOBORDERS"
		end

	Sbt_ownerdraw: INTEGER is
			-- The text is drawn by the parent window.
		external
			"C [macro <cctrl.h>]"
		alias
			"SBT_OWNERDRAW"
		end

	Sbt_popout: INTEGER is
			-- The text is drawn with a border to appear
			-- higher than the plane of the window.
		external
			"C [macro <cctrl.h>]"
		alias
			"SBT_POPOUT"
		end

end -- class WEL_SBT_CONSTANTS

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
