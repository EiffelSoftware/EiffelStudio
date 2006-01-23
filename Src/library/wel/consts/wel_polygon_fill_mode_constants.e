indexing
	description: "Polygon fill mode constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_POLYGON_FILL_MODE_CONSTANTS

feature -- Access

	Alternate: INTEGER is
			-- Selects alternate mode (fills the area between
			-- odd-numbered and even-numbered polygon sides on
			-- each scan line).
		external
			"C [macro %"wel.h%"]"
		alias
			"ALTERNATE"
		end

	Winding: INTEGER is
			-- Selects winding mode (fills any region with a
			-- nonzero winding value).
		external
			"C [macro %"wel.h%"]"
		alias
			"WINDING"
		end

feature -- Status report

	valid_polygon_fill_mode_constant (c: INTEGER): BOOLEAN is
			-- Is `c' a valid polygon fill mode constant?
		do
			Result := c = Alternate or else c = Winding
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




end -- class WEL_POLYGON_FILL_MODE_CONSTANTS

