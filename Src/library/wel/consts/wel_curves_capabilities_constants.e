note
	description: "Curves capabilities (CC) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CURVES_CAPABILITIES_CONSTANTS

feature -- Access

	Cc_none: INTEGER
			-- Supports curves
		external
			"C [macro %"wel.h%"]"
		alias
			"CC_NONE"
		end

	Cc_circles: INTEGER
			-- Supports circles
		external
			"C [macro %"wel.h%"]"
		alias
			"CC_CIRCLES"
		end

	Cc_pie: INTEGER
			-- Supports pie wedges
		external
			"C [macro %"wel.h%"]"
		alias
			"CC_PIE"
		end

	Cc_chord: INTEGER
			-- Supports chords
		external
			"C [macro %"wel.h%"]"
		alias
			"CC_CHORD"
		end

	Cc_ellipses: INTEGER
			-- Supports ellipses
		external
			"C [macro %"wel.h%"]"
		alias
			"CC_ELLIPSES"
		end

	Cc_wide: INTEGER
			-- Supports wide borders
		external
			"C [macro %"wel.h%"]"
		alias
			"CC_WIDE"
		end

	Cc_styled: INTEGER
			-- Supports styled borders
		external
			"C [macro %"wel.h%"]"
		alias
			"CC_STYLED"
		end

	Cc_wide_styled: INTEGER
			-- Supports wide, styled borders
		external
			"C [macro %"wel.h%"]"
		alias
			"CC_WIDESTYLED"
		end

	Cc_interiors: INTEGER
			-- Supports interiors
		external
			"C [macro %"wel.h%"]"
		alias
			"CC_INTERIORS"
		end

	Cc_round_rect: INTEGER
			-- Supports rectangles with rounded corners
		external
			"C [macro %"wel.h%"]"
		alias
			"CC_ROUNDRECT"
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




end -- class WEL_CURVES_CAPABILITIES_CONSTANTS

