indexing
	description: "Common control Track Bar Style (TBS) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TBS_CONSTANTS

feature -- Access

	Tbs_autoticks: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TBS_AUTOTICKS"
		end

	Tbs_vert: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TBS_VERT"
		end

	Tbs_horz: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TBS_HORZ"
		end

	Tbs_top: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TBS_TOP"
		end

	Tbs_bottom: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TBS_BOTTOM"
		end

	Tbs_left: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TBS_LEFT"
		end

	Tbs_right: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TBS_RIGHT"
		end

	Tbs_both: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TBS_BOTH"
		end

	Tbs_noticks: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TBS_NOTICKS"
		end

	Tbs_enableselrange: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TBS_ENABLESELRANGE"
		end

	Tbs_fixedlength: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TBS_FIXEDLENGTH"
		end

	Tbs_nothumb: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TBS_NOTHUMB"
		end

end -- class WEL_TBS_CONSTANTS

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
