indexing
	description: "Common control Progress Bar Message (PBM) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_PBM_CONSTANTS

feature -- Access

	Pbm_setrange: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"PBM_SETRANGE"
		end

	Pbm_setpos: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"PBM_SETPOS"
		end

	Pbm_deltapos: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"PBM_DELTAPOS"
		end

	Pbm_setstep: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"PBM_SETSTEP"
		end

	Pbm_stepit: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"PBM_STEPIT"
		end

end -- class WEL_PBM_CONSTANTS

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
