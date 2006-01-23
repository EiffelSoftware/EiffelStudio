indexing
	description: "Common control Progress Bar Message (PBM) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_PBM_CONSTANTS

feature -- Access

	Pbm_getpos: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"PBM_GETPOS"
		end

	Pbm_getrange: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"PBM_GETRANGE"
		end

	Pbm_setrange: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"PBM_SETRANGE"
		end
		
	Pbm_setrange32: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"PBM_SETRANGE32"
		end

	Pbm_setpos: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"PBM_SETPOS"
		end

	Pbm_deltapos: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"PBM_DELTAPOS"
		end

	Pbm_setstep: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"PBM_SETSTEP"
		end

	Pbm_stepit: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"PBM_STEPIT"
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




end -- class WEL_PBM_CONSTANTS

