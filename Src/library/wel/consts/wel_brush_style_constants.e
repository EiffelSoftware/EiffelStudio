indexing
	description: "Brush style (BS) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_BRUSH_STYLE_CONSTANTS

feature -- Access

	Bs_solid: INTEGER is 0
			-- Solid brush.

	Bs_null: INTEGER is 1
			-- Same as `Bs_hollow'.

	Bs_hollow: INTEGER is 1
			-- Hollow brush.

	Bs_hatched: INTEGER is 2
			-- Hatched brush.

	Bs_pattern: INTEGER is 3
			-- Pattern brush defined by a memory bitmap.

	Bs_indexed: INTEGER is 4

	Bs_dibpattern: INTEGER is 5
			-- A pattern brush defined by a device-independent
			-- bitmap (DIB) specification.

	Bs_dibpatternpt: INTEGER is 6
			-- A pattern brush defined by a device-independent
			-- bitmap (DIB) specification

	Bs_pattern8x8: INTEGER is 7
			-- Same as `Bs_pattern'.

	Bs_dibpattern8x8: INTEGER is 8;
			-- Same as `Bs_dibpattern'.

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




end -- class WEL_BRUSH_STYLE_CONSTANTS

