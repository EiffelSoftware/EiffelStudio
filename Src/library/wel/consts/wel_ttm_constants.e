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
			"C [macro %"cctrl.h%"]"
		alias
			"TTM_ACTIVATE"
		end

	Ttm_addtool: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTM_ADDTOOL"
		end

	Ttm_deltool: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTM_DELTOOL"
		end

	Ttm_enumtools: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTM_ENUMTOOLS"
		end

	Ttm_getcurrenttool: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTM_GETCURRENTTOOL"
		end

	Ttm_getdelaytime: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTM_GETDELAYTIME"
		end

	Ttm_gettext: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTM_GETTEXT"
		end

	Ttm_gettipbkcolor: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTM_GETTIPBKCOLOR"
		end

	Ttm_gettiptextcolor: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTM_GETTIPTEXTCOLOR"
		end

	Ttm_gettoolcount: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTM_GETTOOLCOUNT"
		end

	Ttm_gettoolinfo: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTM_GETTOOLINFO"
		end

	Ttm_hittest: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTM_HITTEST"
		end

	Ttm_newtoolrect: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTM_NEWTOOLRECT"
		end

	Ttm_relayevent: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTM_RELAYEVENT"
		end

	Ttm_setdelaytime: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTM_SETDELAYTIME"
		end

	Ttm_settipbkcolor: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTM_SETTIPBKCOLOR"
		end

	Ttm_settiptextcolor: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTM_SETTIPTEXTCOLOR"
		end

	Ttm_settoolinfo: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTM_SETTOOLINFO"
		end

	Ttm_updatetiptext: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTM_UPDATETIPTEXT"
		end

	Ttm_windowfrompoint: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTM_WINDOWFROMPOINT"
		end

end -- class WEL_TTM_CONSTANTS


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

