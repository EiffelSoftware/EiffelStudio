indexing
	description: "Multiple Document Interface (MDI) tile constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_MDI_TILE_CONSTANTS

feature -- Access

	Mditile_vertical: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"MDITILE_VERTICAL"
		end

	Mditile_horizontal: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"MDITILE_HORIZONTAL"
		end

	Mditile_skipdisabled: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"MDITILE_SKIPDISABLED"
		end

end -- class WEL_MDI_TILE_CONSTANTS

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
