note
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

	cwin_lo_word (value: POINTER): INTEGER
			-- SDK LOWORD
		external
			"C macro use <windows.h>"
		alias
			"LOWORD"
		end

	cwin_hi_word (value: POINTER): INTEGER
			-- SDK HIWORD
		external
			"C macro use <windows.h>"
		alias
			"HIWORD"
		end

	cwin_make_long (low, high: INTEGER): POINTER
			-- SDK MAKELONG
		external
			"C inline use <windows.h>"
		alias
			"return (EIF_POINTER) (rt_uint_ptr) MAKELONG($low, $high);"
		end

	cwin_make_lparam (low, high: INTEGER): POINTER
			-- SKD MAKELPARAM
		external
			"C macro use <windows.h>"
		alias
			"MAKELPARAM"
		end

note
	copyright:	"Copyright (c) 1984-2011, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class WEL_WORD_OPERATIONS

