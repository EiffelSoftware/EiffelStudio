indexing
	description: "Stream format (SF) constants for the rich edit control."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_SF_CONSTANTS

feature -- Access

	Sf_text: INTEGER is
		external
			"C [macro <redit.h>]"
		alias
			"SF_TEXT"
		end

	Sf_rtf: INTEGER is
		external
			"C [macro <redit.h>]"
		alias
			"SF_RTF"
		end

	Sf_rtfnoobjs: INTEGER is
		external
			"C [macro <redit.h>]"
		alias
			"SF_RTFNOOBJS"
		end

	Sf_textized: INTEGER is
		external
			"C [macro <redit.h>]"
		alias
			"SF_TEXTIZED"
		end

	Sff_selection: INTEGER is
		external
			"C [macro <redit.h>]"
		alias
			"SFF_SELECTION"
		end

end -- class WEL_SF_CONSTANTS

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
