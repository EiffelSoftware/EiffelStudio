indexing
	description: "Mapping mode (MM) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_MM_CONSTANTS

feature -- Access

	Mm_text: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MM_TEXT"
		end

	Mm_lometric: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MM_LOMETRIC"
		end

	Mm_himetric: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MM_HIMETRIC"
		end

	Mm_loenglish: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MM_LOENGLISH"
		end

	Mm_hienglish: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MM_HIENGLISH"
		end

	Mm_twips: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MM_TWIPS"
		end

	Mm_isotropic: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MM_ISOTROPIC"
		end

	Mm_anisotropic: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"MM_ANISOTROPIC"
		end

feature -- Status report

	valid_map_mode_constant (c: INTEGER): BOOLEAN is
			-- Is `c' a valid map mode constant?
		do
			Result := c = Mm_text or else
				c = Mm_lometric or else
				c = Mm_himetric or else
				c = Mm_loenglish or else
				c = Mm_hienglish or else
				c = Mm_twips or else
				c = Mm_isotropic or else
				c = Mm_anisotropic
		end

end -- class WEL_MM_CONSTANTS


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

