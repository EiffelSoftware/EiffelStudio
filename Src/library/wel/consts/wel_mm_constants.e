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

