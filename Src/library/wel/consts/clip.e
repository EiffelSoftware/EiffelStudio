indexing
	description: "Clipping precision (CLIP) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CLIP_PRECISION_CONSTANTS

feature -- Access

	Clip_default_precis: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"CLIP_DEFAULT_PRECIS"
		end

	Clip_character_precis: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"CLIP_CHARACTER_PRECIS"
		end

	Clip_stroke_precis: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"CLIP_STROKE_PRECIS"
		end

	Clip_mask: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"CLIP_MASK"
		end

	Clip_lh_angles: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"CLIP_LH_ANGLES"
		end

	Clip_tt_always: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"CLIP_TT_ALWAYS"
		end

	Clip_embedded: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"CLIP_EMBEDDED"
		end

end -- class WEL_CLIP_PRECISION_CONSTANTS

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
