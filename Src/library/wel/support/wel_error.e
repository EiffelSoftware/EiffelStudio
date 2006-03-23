indexing
	description: "Analyzes Windows errors."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_ERROR

feature -- Status

	last_error_code: INTEGER is
			-- Integer code corresponding to last error.
		do
			Result := cwin_get_last_error_code
		end
		
	display_last_error is
			-- Display string corresponding to last
			-- error in a message dialog box.
		do
			cwin_display_last_error
		end

feature -- Setting

	reset_last_error_code is
			-- Reset `last_error_code' to `0'.
		do
			cwin_set_last_error_code (0)
		ensure
			last_error_code_set: last_error_code = 0
		end

feature {NONE} -- Implementation

	cwin_set_last_error_code (i: INTEGER) is
			-- Set new value for `last_error_code'.
		external
			"C macro signature (DWORD) use <windows.h>"
		alias
			"SetLastError"
		end

	cwin_get_last_error_code: INTEGER is
			-- The GetLastError function retrieves the calling thread's
			-- last-error code value. The last-error code is maintained
			-- on a per-thread basis. Multiple threads do not overwrite
			-- each other's last-error code. 
		external
			"C [macro <windows.h>]"
		alias
			"GetLastError()"
		end

	cwin_display_last_error is
			-- Display GetLastError in a message box.
		external
			"C inline use <windows.h>, <tchar.h>"
		alias
			"[
			{
			LPVOID lpMsgBuf;
			TCHAR szBuf[5120]; DWORD dw = GetLastError();
			FormatMessage( 
				FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_IGNORE_INSERTS,
				NULL,
				dw,
				MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT), // Default language
				(LPTSTR) &lpMsgBuf,
				0,
				NULL 
				);
			_stprintf(szBuf, L"%s\nGetLastError returned %u\n", lpMsgBuf, dw);
			MessageBox( NULL, szBuf, L"EV_DIALOG_IMP Error", MB_OK | MB_ICONINFORMATION );
			LocalFree( lpMsgBuf );
			}
			]"
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




end -- class WEL_ERROR

