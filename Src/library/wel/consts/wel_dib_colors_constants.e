indexing
	description: "Dib colors (DIB) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_DIB_COLORS_CONSTANTS

feature -- Access

	Dib_rgb_colors: INTEGER is 0

	Dib_pal_colors: INTEGER is 1

feature -- Status report

	valid_dib_colors_constant (c: INTEGER): BOOLEAN is
			-- Is `c' a valid dib colors constant?
		do
			Result := c = Dib_rgb_colors or else c = Dib_pal_colors
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




end -- class WEL_DIB_COLORS_CONSTANTS

