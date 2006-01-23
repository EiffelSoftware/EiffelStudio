indexing
	description: "Word operations (low and high)."
	legal: "See notice at end of class."
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




end -- class WEL_WORD_OPERATIONS

