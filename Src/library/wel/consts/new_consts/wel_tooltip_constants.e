note
	description: "Windows tooltip constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TOOLTIP_CONSTANTS

feature -- Tooltip time delay constants

	Ttdt_automatic: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTDT_AUTOMATIC"
		end

	Ttdt_autopop: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTDT_AUTOPOP"
		end

	Ttdt_initial: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTDT_INITIAL"
		end

	Ttdt_reshow: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTDT_RESHOW"
		end

feature -- Tooltip message constants

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
		
	Ttm_setmaxtipwidth: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTM_SETMAXTIPWIDTH"
		end
		
	Ttm_getmaxtipwidth: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTM_GETMAXTIPWIDTH"
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

feature -- Tooltip style constants

	Tts_alwaystip: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTS_ALWAYSTIP"
		end

	Tts_noprefix: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTS_NOPREFIX"
		end

feature -- Tooltip Flag constants

	Ttf_idishwnd: INTEGER = 1

	Ttf_centertip: INTEGER = 2

	Ttf_rtlreading: INTEGER = 4

	Ttf_subclass: INTEGER = 16;

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




end -- class WEL_TOOLTIP_CONSTANTS

