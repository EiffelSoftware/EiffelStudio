indexing
	description: "Hatch style (HS) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_HS_CONSTANTS

feature -- Access

	Hs_horizontal: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"HS_HORIZONTAL"
		end

	Hs_vertical: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"HS_VERTICAL"
		end

	Hs_fdiagonal: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"HS_FDIAGONAL"
		end

	Hs_bdiagonal: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"HS_BDIAGONAL"
		end

	Hs_cross: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"HS_CROSS"
		end

	Hs_diagcross: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"HS_DIAGCROSS"
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




end -- class WEL_HS_CONSTANTS

