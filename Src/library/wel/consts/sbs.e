indexing
	description: "ScrollBar style (SBS) messages."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_SBS_CONSTANTS

feature -- Access

	Sbs_horz: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"SBS_HORZ"
		end

	Sbs_vert: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"SBS_VERT"
		end

	Sbs_topalign: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"SBS_TOPALIGN"
		end

	Sbs_leftalign: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"SBS_LEFTALIGN"
		end

	Sbs_bottomalign: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"SBS_BOTTOMALIGN"
		end

	Sbs_rightalign: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"SBS_RIGHTALIGN"
		end

	Sbs_sizeboxtopleftalign: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"SBS_SIZEBOXTOPLEFTALIGN"
		end

	Sbs_sizeboxbottomrightalign: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"SBS_SIZEBOXBOTTOMRIGHTALIGN"
		end

	Sbs_sizebox: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"SBS_SIZEBOX"
		end

end -- class WEL_SBS_CONSTANTS

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
