indexing
	description: "Code page constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CP_CONSTANTS

feature -- Access

	Cp_acp: INTEGER is 0
			-- ANSI code page.

	Cp_oemcp: INTEGER is 1
			-- OEM code page.

	Cp_maccp: INTEGER is 2
			-- Macintosh code page.

	Cp_thread_acp: INTEGER is 3
			-- The current thread's ANSI code page.

	Cp_symbol: INTEGER is 42
			-- Symbol code page.

	Cp_utf7: INTEGER is 65000
			-- UTF-7 code page.

	Cp_utf8: INTEGER is 65001;
			-- UTF-8 code page.

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




end -- class WEL_CP_CONSTANTS

