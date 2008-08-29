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
			Result := c_console_code_page.out
		end

feature {NONE} -- NLS LC CTYPE CONSTANTS

	LOCALE_IDEFAULTCODEPAGE: INTEGER 			=  	0x0000000B   -- default oem code page
	locale_idefaultcodepage_maxlen: INTEGER 	= 	6
	LOCALE_IDEFAULTANSICODEPAGE: INTEGER 		= 	0x00001004   -- default ansi code page
	locale_idefaultansicodepage_maxlen: INTEGER = 	6
	LOCALE_IDEFAULTMACCODEPAGE: INTEGER 		=	0x00001011   -- default mac code page
	locale_idefaultmaccodepage_maxlen: INTEGER 	= 	6

feature {NONE} -- Implementation

	extract_locale_string(lcid: INTEGER; lc_ctype: INTEGER; bufferlen: INTEGER): STRING_32 is
		local
			l_pointer: MANAGED_POINTER
			l_int: INTEGER
		do
			create l_pointer.make (c_tchar_length * bufferlen)
			l_int := c_extract_locale_string(lcid, lc_ctype, l_pointer.item, l_pointer.count)
			Result := pointer_to_wide_string (l_pointer.item, l_pointer.count)
		end

	c_extract_locale_string(lcid: INTEGER; lc_ctype: INTEGER; a_pointer: POINTER; a_len: INTEGER): INTEGER is
		external
			"C inline use <windows.h>"
		alias
			"return GetLocaleInfo((LCID) $lcid, (LCTYPE) $lc_ctype, $a_pointer, (int) $a_len);"
		end

	c_tchar_length: INTEGER is
			-- Lenth of TCHAR.
		external
			"C inline use <windows.h>"
		alias
			"return sizeof(TCHAR);"
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

invariant
	correct_locale_idefaultcodepage_maxlen:
		c_extract_locale_string (system_locale, LOCALE_IDEFAULTCODEPAGE, default_pointer, 0) <= locale_idefaultcodepage_maxlen
	correct_locale_idefaultansicodepage_maxlen:
		c_extract_locale_string (system_locale, LOCALE_IDEFAULTANSICODEPAGE, default_pointer, 0) <= locale_idefaultansicodepage_maxlen
	correct_locale_idefaultmaccodepage_maxlen:
		c_extract_locale_string (system_locale, LOCALE_IDEFAULTMACCODEPAGE, default_pointer, 0) <= locale_idefaultmaccodepage_maxlen

indexing
	library:   "Encoding: Library of reusable components for Eiffel."
	copyright: "Copyright (c) 1984-2008, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			356 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"



end
