indexing
	description: "PeekMessage (PM) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_PM_CONSTANTS

feature -- Access

	Pm_noremove: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"PM_NOREMOVE"
		end

	Pm_remove: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"PM_REMOVE"
		end

	Pm_noyield: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"PM_NOYIELD"
		end

end -- class WEL_PM_CONSTANTS

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
