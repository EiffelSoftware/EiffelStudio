indexing
	description: "Out (OUT) precision constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_OUT_PRECISION_CONSTANTS

feature -- Access

	Out_default_precis: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"OUT_DEFAULT_PRECIS"
		end

	Out_string_precis: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"OUT_STRING_PRECIS"
		end

	Out_character_precis: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"OUT_CHARACTER_PRECIS"
		end

	Out_stroke_precis: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"OUT_STROKE_PRECIS"
		end

	Out_tt_precis: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"OUT_TT_PRECIS"
		end

	Out_device_precis: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"OUT_DEVICE_PRECIS"
		end

	Out_raster_precis: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"OUT_RASTER_PRECIS"
		end

	Out_tt_only_precis: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"OUT_TT_ONLY_PRECIS"
		end

end -- class WEL_OUT_PRECISION_CONSTANTS

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
