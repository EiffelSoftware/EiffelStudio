indexing
	description: "Stretch mode constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_STRETCH_MODE_CONSTANTS

feature -- Access

	Stretch_andscans: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"STRETCH_ANDSCANS"
		end

	Stretch_deletescans: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"STRETCH_DELETESCANS"
		end

	Stretch_orscans: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"STRETCH_ORSCANS"
		end

feature -- Status report

	valid_stretch_mode_constant (c: INTEGER): BOOLEAN is
			-- Is `c' a valid stretch mode constant?
		do
			Result := c = Stretch_andscans or else
				c = Stretch_deletescans or else
				c = Stretch_orscans
		end

end -- class WEL_STRETCH_MODE_CONSTANTS

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
