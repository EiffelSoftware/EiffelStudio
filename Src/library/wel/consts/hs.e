indexing
	description: "Hatch style (HS) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_HS_CONSTANTS

feature -- Access

	Hs_horizontal: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"HS_HORIZONTAL"
		end

	Hs_vertical: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"HS_VERTICAL"
		end

	Hs_fdiagonal: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"HS_FDIAGONAL"
		end

	Hs_bdiagonal: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"HS_BDIAGONAL"
		end

	Hs_cross: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"HS_CROSS"
		end

	Hs_diagcross: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"HS_DIAGCROSS"
		end

end -- class WEL_HS_CONSTANTS

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
