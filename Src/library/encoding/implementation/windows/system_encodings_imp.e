indexing
	description: "System encodings, windows implementation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SYSTEM_ENCODINGS_IMP

inherit
	SYSTEM_ENCODINGS_I

	ENCODING_HELPER

feature -- Access

	system_code_page: STRING is
			-- System code page
			-- Take oem as default
		do
			Result := extract_locale_string (system_locale,
											LOCALE_IDEFAULTCODEPAGE,
											locale_idefaultcodepage_maxlen)
		end

	console_code_page: STRING is
			-- Console code page
		do
			Result := 	c_console_code_page.out
		end

feature {NONE} -- NLS LC CTYPE CONSTANTS

	LOCALE_IDEFAULTCODEPAGE: INTEGER is        0x0000000B   -- default oem code page
	locale_idefaultcodepage_maxlen: INTEGER is 6
	LOCALE_IDEFAULTANSICODEPAGE: INTEGER is    0x00001004   -- default ansi code page
	locale_idefaultansicodepage_maxlen: INTEGER is 6
	LOCALE_IDEFAULTMACCODEPAGE: INTEGER is     0x00001011   -- default mac code page
	locale_idefaultmaccodepage_maxlen: INTEGER is 6

feature {NONE} -- Implementation

	extract_locale_string(lcid: INTEGER; lc_ctype: INTEGER; bufferlen: INTEGER): STRING_32 is
		local
			pointer: POINTER
		do
			pointer := c_extract_locale_string(lcid, lc_ctype, bufferlen)
			Result := pointer_to_wide_string (pointer, bufferlen)
			pointer.memory_free
		end

	c_extract_locale_string(lcid: INTEGER; lc_ctype: INTEGER; bufferlen: INTEGER ): POINTER is
		external
			"C inline use <windows.h>"
		alias
			"[
				TCHAR *string;
				string = malloc(sizeof(TCHAR)*$bufferlen);
				GetLocaleInfo((LCID) $lcid, (LCTYPE) $lc_ctype, string, (int) $bufferlen);
				return string;
			]"
		end

	c_console_code_page: INTEGER is
			-- Output codepage of the console
		external
			"C inline use <windows.h>"
		alias
			"[
				return (EIF_INTEGER_32)GetConsoleOutputCP ();
			]"
		end

	system_locale: INTEGER is
			-- Encapsulation of GetSystemDefaultLCID
		external
			"C (): LCID | <windows.h>"
		alias
			"GetSystemDefaultLCID"
		end

	user_locale: INTEGER is
			-- Encapsulation of GetUserDefaultLCID
		external
			"C (): LCID| <windows.h>"
		alias
			"GetUserDefaultLCID"
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

end
