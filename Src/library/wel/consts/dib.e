indexing
	description: "Dib colors (DIB) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_DIB_COLORS_CONSTANTS

feature -- Access

	Dib_rgb_colors: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"DIB_RGB_COLORS"
		end

	Dib_pal_colors: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"DIB_PAL_COLORS"
		end

feature -- Status report

	valid_dib_colors_constant (c: INTEGER): BOOLEAN is
			-- Is `c' a valid dib colors constant?
		do
			Result := c = Dib_rgb_colors or else c = Dib_pal_colors
		end

end -- class WEL_DIB_COLORS_CONSTANTS

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-1997, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
