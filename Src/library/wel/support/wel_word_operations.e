indexing
	description: "Word operations (low and high)."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_WORD_OPERATIONS

inherit
	WEL_DATA_TYPE

feature -- Basic operations

	cwin_lo_word (value: POINTER): INTEGER is
			-- SDK LOWORD
		external
			"C inline use <windows.h>"
		alias
			"(EIF_INTEGER) LOWORD($value)"
		end

	cwin_hi_word (value: POINTER): INTEGER is
			-- SDK HIWORD
		external
			"C inline use <windows.h>"
		alias
			"(EIF_INTEGER) HIWORD($value)"
		end

	cwin_make_long (low, high: INTEGER): POINTER is
			-- SDK MAKELONG
		external
			"C inline use <windows.h>"
		alias
			"(EIF_POINTER) MAKELONG($low, $high)"
		end

end -- class WEL_WORD_OPERATIONS

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

