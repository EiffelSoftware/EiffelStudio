indexing
	description: "Tool Tip Message (TTM) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TTM_CONSTANTS

feature -- Access

	Ttm_activate: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TTM_ACTIVATE"
		end

	Ttm_addtool: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TTM_ADDTOOL"
		end

	Ttm_deltool: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TTM_DELTOOL"
		end

	Ttm_enumtools: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TTM_ENUMTOOLS"
		end

	Ttm_getcurrenttool: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TTM_GETCURRENTTOOL"
		end

	Ttm_gettext: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TTM_GETTEXT"
		end

	Ttm_gettoolcount: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TTM_GETTOOLCOUNT"
		end

	Ttm_gettoolinfo: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TTM_GETTOOLINFO"
		end

	Ttm_hittest: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TTM_HITTEST"
		end

	Ttm_newtoolrect: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TTM_NEWTOOLRECT"
		end

	Ttm_relayevent: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TTM_RELAYEVENT"
		end

	Ttm_setdelaytime: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TTM_SETDELAYTIME"
		end

	Ttm_settoolinfo: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TTM_SETTOOLINFO"
		end

	Ttm_updatetiptext: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TTM_UPDATETIPTEXT"
		end

	Ttm_windowfrompoint: INTEGER is
		external
			"C [macro <cctrl.h>]"
		alias
			"TTM_WINDOWFROMPOINT"
		end

end -- class WEL_TTM_CONSTANTS

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
