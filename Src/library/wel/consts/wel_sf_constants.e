indexing
	description: "Stream format (SF) constants for the rich edit control."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_SF_CONSTANTS

feature -- Access

	Sf_text: INTEGER is
			-- Text with spaces in place of OLE objects.
		external
			"C [macro %"redit.h%"]"
		alias
			"SF_TEXT"
		end

	Sf_rtf: INTEGER is
			-- Rich-text format (RTF).
		external
			"C [macro %"redit.h%"]"
		alias
			"SF_RTF"
		end

	Sf_rtfnoobjs: INTEGER is
			-- RTF with spaces in place of OLE object.
		external
			"C [macro %"redit.h%"]"
		alias
			"SF_RTFNOOBJS"
		end

	Sf_textized: INTEGER is
			-- Text with a text representation of OLE objects.
		external
			"C [macro %"redit.h%"]"
		alias
			"SF_TEXTIZED"
		end

	Sff_selection: INTEGER is
			-- Selection only.
		external
			"C [macro %"redit.h%"]"
		alias
			"SFF_SELECTION"
		end

end -- class WEL_SF_CONSTANTS

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

