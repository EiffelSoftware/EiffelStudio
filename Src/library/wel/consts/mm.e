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
			"C [macro <wel.h>]"
		alias
			"MM_TEXT"
		end

	Mm_lometric: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"MM_LOMETRIC"
		end

	Mm_himetric: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"MM_HIMETRIC"
		end

	Mm_loenglish: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"MM_LOENGLISH"
		end

	Mm_hienglish: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"MM_HIENGLISH"
		end

	Mm_twips: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"MM_TWIPS"
		end

	Mm_isotropic: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"MM_ISOTROPIC"
		end

	Mm_anisotropic: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"MM_ANISOTROPIC"
		end

end -- class WEL_MM_CONSTANTS

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
