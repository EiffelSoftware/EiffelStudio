indexing
	description: "Dib colors (DIB) constants."
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

end -- class WEL_DIB_COLORS_CONSTANTS

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

