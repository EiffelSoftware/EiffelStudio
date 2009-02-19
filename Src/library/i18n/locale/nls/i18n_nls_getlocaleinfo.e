note
	description: "Wrapper for extracting locale information from the NLS get_localeinfo function."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	I18N_NLS_GETLOCALEINFO

inherit
	SHARED_I18N_NLS_LC_CTYPE_CONSTANTS

	UNICODE_CONVERSION
		export
			{NONE} all
		end

feature -- Interface

	extract_locale_integer (lcid: INTEGER; lc_ctype: INTEGER): INTEGER
			--
		external
			"C inline use <windows.h>"
		alias
			"[
				int temp;
				GetLocaleInfo ((LCID) $lcid, ((LCTYPE) $lc_ctype | LOCALE_RETURN_NUMBER), (LPTSTR) &temp, 2);
				return (EIF_INTEGER) temp;
			]"
		end

	extract_locale_string(lcid: INTEGER; lc_ctype: INTEGER; bufferlen: INTEGER): STRING_32
			--
		local
			pointer: POINTER
		do
			pointer := c_extract_locale_string(lcid, lc_ctype, bufferlen)
			Result := pointer_to_string (pointer, bufferlen)
			pointer.memory_free
		end

feature {NONE} -- C helper

	c_extract_locale_string(lcid: INTEGER; lc_ctype: INTEGER; bufferlen: INTEGER ): POINTER
			--
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

feature {NONE} -- utf16-LE (aka "wide string") handling

	pointer_to_string(ptr: POINTER; buf_size: INTEGER): STRING_32
			-- takes a pointer to a utf16-LE string (the LE is important!)
			-- and returns the corresponding STRING_32 by means of Horrible Things
		require
				--pointer is not null, I suppose
			ptr_not_null: ptr /= default_pointer
		local
			length: INTEGER
		do
				-- Ignore the reminder part, when it doesn't make sense to be a character.
			if buf_size \\ c_wcsize /= 0 then
				length := (buf_size // c_wcsize) * c_wcsize
			else
				length := buf_size
			end
			length := length.min (c_wcslen (ptr) * c_wcsize)
			Result := pointer_to_wide_string (ptr, length)
			Result := utf16_to_utf32 (Result)
		end

	c_wcslen (ptr: POINTER): INTEGER
		external
			"C (void *): EIF_INTEGER| <string.h>"
		alias
			"wcslen"
		end

	c_wcsize: INTEGER
		external
			"C inline"
		alias
			"sizeof (wchar_t)"
		end

note
	library:   "Internationalization library"
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
