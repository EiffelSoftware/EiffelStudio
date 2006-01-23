indexing
	description: "Stream format (SF) constants for the rich edit control."
	legal: "See notice at end of class."
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

	Sff_selection: INTEGER is 32768;
			-- Selection only.

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




end -- class WEL_SF_CONSTANTS

