indexing
	description: "Rebar Band Style (RBBS) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_RBBS_CONSTANTS

feature -- Access

	Rbbs_break: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"RBBS_BREAK"
		end

	Rbbs_fixedsize: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"RBBS_FIXEDSIZE"
		end

	Rbbs_childedge: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"RBBS_CHILDEDGE"
		end

	Rbbs_hidden: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"RBBS_HIDDEN"
		end

	Rbbs_novert: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"RBBS_NOVERT"
		end

	Rbbs_fixedbmp: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"RBBS_FIXEDBMP"
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




end -- class WEL_RBBS_CONSTANTS

