indexing
	description: "Dialog response (ID) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_ID_CONSTANTS

feature -- Access

	Idok: INTEGER is 1
			-- OK button was selected.

	Idcancel: INTEGER is 2
			-- Cancel button was selected.

	Idabort: INTEGER is 3
			-- Abort button was selected.

	Idretry: INTEGER is 4
			-- Retry button was selected.

	Idignore: INTEGER is 5
			-- Ignore button was selected.

	Idyes: INTEGER is 6
			-- Yes button was selected.

	Idno: INTEGER is 7;
			-- No button was selected.

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




end -- class WEL_ID_CONSTANTS

