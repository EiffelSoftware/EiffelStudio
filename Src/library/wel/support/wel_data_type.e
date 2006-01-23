indexing
	description: "Conversion to and from Windows data type"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_DATA_TYPE
	
feature -- Conversion from Eiffel to Windows

	to_lparam (i: INTEGER): POINTER is
			-- Convert integer value `i' in a valid `LPARAM' value.
		external
			"C inline use <windows.h>"
		alias
			"(LPARAM) $i"
		end

	to_wparam (i: INTEGER): POINTER is
			-- Convert integer value `i' in a valid `WPARAM' value.
		external
			"C inline use <windows.h>"
		alias
			"(WPARAM) $i"
		end

	to_lresult (i: INTEGER): POINTER is
			-- Convert integer value `i' in a valid LRESULT value.
		external
			"C inline use <windows.h>"
		alias
			"(LRESULT) $i"
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




end -- class WEL_DATA_TYPE
