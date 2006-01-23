indexing
	description: "Status window messages."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_STATUS_WINDOW_CONSTANTS

feature -- Access

	Sb_getrect: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"SB_GETRECT"
		end

	Sb_setminheight: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"SB_SETMINHEIGHT"
		end

	Sb_getborders: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"SB_GETBORDERS"
		end

	Sb_gettext: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"SB_GETTEXT"
		end

	Sb_gettextlength: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"SB_GETTEXTLENGTH"
		end

	Sb_settext: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"SB_SETTEXT"
		end

	Sb_getparts: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"SB_GETPARTS"
		end

	Sb_setparts: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"SB_SETPARTS"
		end

	Sb_simple: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"SB_SIMPLE"
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_STATUS_WINDOW_CONSTANTS

