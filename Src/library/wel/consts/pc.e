indexing
	description: "Palette entry flag constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_PC_CONSTANTS

feature -- Access

	Pc_reserved: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"PC_RESERVED"
		end

	Pc_explicit: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"PC_EXPLICIT"
		end

	Pc_nocollapse: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"PC_NOCOLLAPSE"
		end

end -- class WEL_PC_CONSTANTS

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
