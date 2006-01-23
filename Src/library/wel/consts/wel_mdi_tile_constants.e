indexing
	description: "Multiple Document Interface (MDI) tile constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_MDI_TILE_CONSTANTS

feature -- Access

	Mditile_vertical: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MDITILE_VERTICAL"
		end

	Mditile_horizontal: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MDITILE_HORIZONTAL"
		end

	Mditile_skipdisabled: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MDITILE_SKIPDISABLED"
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




end -- class WEL_MDI_TILE_CONSTANTS

