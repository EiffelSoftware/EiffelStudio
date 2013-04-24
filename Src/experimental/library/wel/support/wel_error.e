note
	description: "Analyzes Windows errors."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_ERROR

feature -- Status

	last_error_code: INTEGER
			-- Integer code corresponding to last error.
		do
			Result := cwin_get_last_error_code
		end

	display_last_error
			-- Display string corresponding to last
			-- error in a message dialog box.
		local
			l_str: STRING_32
			l_msg_box: WEL_MSG_BOX
		do
			l_str := text_for_error_code (last_error_code)
			l_str.append ({STRING_32} "%NGetLastError returned " + last_error_code.out + "%N")
			create l_msg_box.make
			l_msg_box.information_message_box (Void, l_str, "WEL_ERROR Dialog")
		end

	text_for_error_code (a_error_code: INTEGER): STRING_32
			-- Text corresponding to `a_error_code'.
		require
			a_error_code_non_negative: a_error_code >= 0
		local
			l_str: WEL_STRING
			l_ptr, l_null: POINTER
		do
			l_ptr := cwin_error_text (a_error_code)
			if l_ptr /= l_null then
				create l_str.share_from_pointer (l_ptr)
				Result := l_str.string
				cwin_local_free (l_ptr)
			else
				create Result.make_empty
			end
		ensure
			text_for_error_code_not_void: Result /= Void
		end

feature -- Setting

	reset_last_error_code
			-- Reset `last_error_code' to `0'.
		do
			cwin_set_last_error_code (0)
		ensure
			last_error_code_set: last_error_code = 0
		end

feature {NONE} -- Implementation

	cwin_set_last_error_code (i: INTEGER)
			-- Set new value for `last_error_code'.
		external
			"C macro signature (DWORD) use <windows.h>"
		alias
			"SetLastError"
		end

	cwin_get_last_error_code: INTEGER
			-- The GetLastError function retrieves the calling thread's
			-- last-error code value. The last-error code is maintained
			-- on a per-thread basis. Multiple threads do not overwrite
			-- each other's last-error code.
		external
			"C [macro <windows.h>]"
		alias
			"GetLastError()"
		end

	cwin_local_free (a_ptr: POINTER)
			-- Free `a_ptr' using LocalFree.
		external
			"C inline use <windows.h>"
		alias
			"LocalFree((HLOCAL) $a_ptr);"
		end

	cwin_error_text (a_code: INTEGER): POINTER
			-- Get text from error `a_code'. It is up to the caller to free
			-- the returned buffer using `cwin_local_free'.
		external
			"C inline use <windows.h>, <tchar.h>"
		alias
			"[
			{
			LPVOID result;
			FormatMessage( 
				FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_IGNORE_INSERTS,
				NULL,
				$a_code,
				MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT), // Default language
				(LPTSTR) &result,
				0,
				NULL 
				);
			return result;
			}
			]"
		end


note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_ERROR

