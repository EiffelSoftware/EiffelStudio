indexing
	description: "Analyzes Windows errors."
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

feature {NONE} -- Implementation

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
			"C [macro <wel.h>]"
		alias
			"{%N%
			%LPVOID lpMsgBuf;%N%
			%FormatMessage( %N%
			%%TFORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_IGNORE_INSERTS,%N%
			%%TNULL,%N%
			%%TGetLastError(),%N%
			%%TMAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT), // Default language%N%
			%%T(LPTSTR) &lpMsgBuf,%N%
			%%T0,%N%
			%%TNULL %N%
			%);%N%
			%MessageBox( NULL, (LPCTSTR)lpMsgBuf, %"EV_DIALOG_IMP Error%", MB_OK | MB_ICONINFORMATION );%N%
			%LocalFree( lpMsgBuf );%N%
			%}"
		end
		
end -- class WEL_ERROR
