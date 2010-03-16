note
	description: "Tool Tip Message (TTM) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TTM_CONSTANTS

feature -- Access

	Ttm_activate: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTM_ACTIVATE"
		end

	Ttm_addtool: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTM_ADDTOOL"
		end

	Ttm_deltool: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTM_DELTOOL"
		end

	Ttm_enumtools: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTM_ENUMTOOLS"
		end

	Ttm_getcurrenttool: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTM_GETCURRENTTOOL"
		end

	Ttm_getdelaytime: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTM_GETDELAYTIME"
		end

	Ttm_gettext: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTM_GETTEXT"
		end

	Ttm_gettipbkcolor: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTM_GETTIPBKCOLOR"
		end

	Ttm_gettiptextcolor: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTM_GETTIPTEXTCOLOR"
		end

	Ttm_gettoolcount: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTM_GETTOOLCOUNT"
		end

	Ttm_gettoolinfo: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTM_GETTOOLINFO"
		end

	Ttm_hittest: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTM_HITTEST"
		end

	Ttm_newtoolrect: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTM_NEWTOOLRECT"
		end

	Ttm_relayevent: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTM_RELAYEVENT"
		end

	Ttm_setdelaytime: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTM_SETDELAYTIME"
		end

	Ttm_settipbkcolor: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTM_SETTIPBKCOLOR"
		end

	Ttm_settiptextcolor: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTM_SETTIPTEXTCOLOR"
		end

	Ttm_settoolinfo: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTM_SETTOOLINFO"
		end

	Ttm_updatetiptext: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTM_UPDATETIPTEXT"
		end

	Ttm_windowfrompoint: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTM_WINDOWFROMPOINT"
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_TTM_CONSTANTS

