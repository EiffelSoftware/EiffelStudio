indexing
	description: "Line capabilities (LC) constants."
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

end -- class WEL_LINE_CAPABILITIES_CONSTANTS


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

