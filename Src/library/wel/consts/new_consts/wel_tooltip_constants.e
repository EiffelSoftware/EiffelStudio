indexing
	description: "Windows tooltip constants."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TOOLTIP_CONSTANTS

feature -- Tooltip time delay constants

	Ttdt_automatic: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTDT_AUTOMATIC"
		end

	Ttdt_autopop: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTDT_AUTOPOP"
		end

	Ttdt_initial: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTDT_INITIAL"
		end

	Ttdt_reshow: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTDT_RESHOW"
		end

feature -- Tooltip message constants

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

feature -- Tooltip style constants

	Tts_alwaystip: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTS_ALWAYSTIP"
		end

	Tts_noprefix: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTS_NOPREFIX"
		end

end -- class WEL_TOOLTIP_CONSTANTS
