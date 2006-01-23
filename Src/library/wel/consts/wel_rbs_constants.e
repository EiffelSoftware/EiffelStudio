indexing
	description: "Common control ReBar Style (TBS) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_RBS_CONSTANTS

feature -- Access

	Rbs_tooltips: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"RBS_TOOLTIPS"
		end

	Rbs_varheight: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"RBS_VARHEIGHT"
		end

	Rbs_bandborders: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"RBS_BANDBORDERS"
		end

	Rbs_fixedorder: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"RBS_FIXEDORDER"
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




end -- class WEL_RBS_CONSTANTS

