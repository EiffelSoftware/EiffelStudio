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
		
	Ttm_setmaxtipwidth: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTM_SETMAXTIPWIDTH"
		end
		
	Ttm_getmaxtipwidth: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTM_GETMAXTIPWIDTH"
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

feature -- Tooltip Flag constants

	Ttf_idishwnd: INTEGER is 1

	Ttf_centertip: INTEGER is 2

	Ttf_rtlreading: INTEGER is 4

	Ttf_subclass: INTEGER is 16

end -- class WEL_TOOLTIP_CONSTANTS

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

