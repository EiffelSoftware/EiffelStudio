indexing
	description: "Code page constants."
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

	Cp_utf8: INTEGER is 65001
			-- UTF-8 code page.

end -- class WEL_CP_CONSTANTS

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

