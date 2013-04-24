note
	description: "Common control ReBar (RB) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_RB_CONSTANTS

feature -- Access

	Rb_deleteband: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"RB_DELETEBAND"
		end

	Rb_getbandinfo: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"RB_GETBANDINFO"
		end

	Rb_getbarinfo: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"RB_GETBARINFO"
		end

	Rb_getbandcount: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"RB_GETBANDCOUNT"
		end

	Rb_getrowcount: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"RB_GETROWCOUNT"
		end

	Rb_getrowheight: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"RB_GETROWHEIGHT"
		end

	Rb_insertband: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"RB_INSERTBAND"
		end

	Rb_setbandinfo: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"RB_SETBANDINFO"
		end

	Rb_setbarinfo: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"RB_SETBARINFO"
		end

	Rb_setparent: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"RB_SETPARENT"
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




end -- class WEL_RB_CONSTANTS

