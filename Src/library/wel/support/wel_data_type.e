indexing
	description: "Conversion to and from Windows data type"
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
		
end -- class WEL_DATA_TYPE
