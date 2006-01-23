indexing
	description: "Mapping mode (MM) constants."
	legal: "See notice at end of class."
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




end -- class WEL_MM_CONSTANTS

