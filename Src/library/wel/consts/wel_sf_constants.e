indexing
	description: "Stream format (SF) constants for the rich edit control."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_SF_CONSTANTS

feature -- Access

	Sf_text: INTEGER is 1
			-- Text with spaces in place of OLE objects.

	Sf_rtf: INTEGER is 2
			-- Rich-text format (RTF).

	Sf_rtfnoobjs: INTEGER is 3
			-- RTF with spaces in place of OLE object.

	Sf_textized: INTEGER is 4
			-- Text with a text representation of OLE objects.

	Sff_selection: INTEGER is 32768
			-- Selection only.

end -- class WEL_SF_CONSTANTS


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

