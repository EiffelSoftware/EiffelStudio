indexing
	description: "Line capabilities (LC) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_LINE_CAPABILITIES_CONSTANTS

feature -- Access

	Lc_none: INTEGER is
			-- Supports no lines
		external
			"C [macro %"wel.h%"]"
		alias
			"LC_NONE"
		end

	Lc_polyline: INTEGER is
			-- Supports polylines
		external
			"C [macro %"wel.h%"]"
		alias
			"LC_POLYLINE"
		end

	Lc_marker: INTEGER is
			-- Supports markers
		external
			"C [macro %"wel.h%"]"
		alias
			"LC_MARKER"
		end

	Lc_polymarker: INTEGER is
			-- Supports polymarkers
		external
			"C [macro %"wel.h%"]"
		alias
			"LC_POLYMARKER"
		end

	Lc_wide: INTEGER is
			-- Supports wide lines
		external
			"C [macro %"wel.h%"]"
		alias
			"LC_WIDE"
		end

	Lc_styled: INTEGER is
			-- Supports styled lines
		external
			"C [macro %"wel.h%"]"
		alias
			"LC_STYLED"
		end

	Lc_wide_styled: INTEGER is
			-- Supports wide, styled lines
		external
			"C [macro %"wel.h%"]"
		alias
			"LC_WIDESTYLED"
		end

	Lc_interiors: INTEGER is
			-- Supports interiors
		external
			"C [macro %"wel.h%"]"
		alias
			"LC_INTERIORS"
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




end -- class WEL_LINE_CAPABILITIES_CONSTANTS

