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
			"C [macro <wel.h>]"
		alias
			"{%N%
			%%TLPVOID lpMsgBuf;%N%
			%%TCHAR szBuf[5120]; DWORD dw = GetLastError();%N%
			%%TFormatMessage( %N%
			%%TFORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_IGNORE_INSERTS,%N%
			%%TNULL,%N%
			%%Tdw,%N%
			%%TMAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT), // Default language%N%
			%%T(LPTSTR) &lpMsgBuf,%N%
			%%T0,%N%
			%%TNULL %N%
			%%T);%N%
			%%Tsprintf(szBuf, %"%%s\nGetLastError returned %%u\n%", lpMsgBuf, dw);%N%
			%%TMessageBox( NULL, szBuf, %"EV_DIALOG_IMP Error%", MB_OK | MB_ICONINFORMATION );%N%
			%%TLocalFree( lpMsgBuf );%N%
			%}"
		end
		
end -- class WEL_ERROR

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

