indexing
	description: "Brush style (BS) constants."
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

	Bs_dibpattern8x8: INTEGER is 8
			-- Same as `Bs_dibpattern'.

end -- class WEL_BRUSH_STYLE_CONSTANTS

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

