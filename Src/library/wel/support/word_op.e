indexing
	description: "Word operations (low and high)."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_WORD_OPERATIONS

feature -- Basic operations

	cwin_lo_word (value: INTEGER): INTEGER is
			-- SDK LOWORD
		external
			"C [macro <wel.h>] (EIF_INTEGER): EIF_INTEGER"
		alias
			"LOWORD"
		end

	cwin_hi_word (value: INTEGER): INTEGER is
			-- SDK HIWORD
		external
			"C [macro <wel.h>] (EIF_INTEGER): EIF_INTEGER"
		alias
			"HIWORD"
		end

	cwin_make_long (low, high: INTEGER): INTEGER is
			-- SDK MAKELONG
		external
			"C [macro <wel.h>] (UINT, UINT): EIF_INTEGER"
		alias
			"MAKELONG"
		end

end -- class WEL_WORD_OPERATIONS

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
