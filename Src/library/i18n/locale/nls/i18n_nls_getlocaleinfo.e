note
	description: "Wrapper for extracting locale information from the NLS get_localeinfo function."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	I18N_NLS_GETLOCALEINFO

inherit
	UC_IMPORTED_UTF16_ROUTINES
	SHARED_I18N_NLS_LC_CTYPE_CONSTANTS

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
			Result := pointer_to_string (pointer)
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

	pointer_to_string(ptr: POINTER): STRING_32
			-- takes a pointer to a utf16-LE string (the LE is important!)
			-- and returns the corresponding STRING_32 by means of Horrible Things
		require
				--pointer is not null, I suppose
			ptr_not_null: ptr /= default_pointer
		local
			managed_ptr: MANAGED_POINTER
			length: INTEGER
			counter: INTEGER
			a_least, a_most: INTEGER --high byte and low byte of current character
			a_low_most, a_low_least: INTEGER --high byte and low byte of next character
		do
			length := c_wcslen (ptr)
			create managed_ptr.share_from_pointer (ptr, length*2) --utf16: each character is 2 bytes.
			create Result.make_empty

				-- This code is based on append_utf16 in UC_STRING - this version is
				-- needed because strings returned by the Windows  NLS api are UT16-LE
				-- and therefore do not have a BOM, which append_utf16 requires
				-- (it will in fact cause an exception if the BOM is absent. is_valid_utf16 should check for it.)
				-- Also I don't like the idea of reading bytes into a STRING_8, reading the
				-- STRING_8 into a UC_STRING with append_utf16 and then turning the UC_STRING
				-- into a STRING_32.  Talk about efficiency...

			from
					-- counter counts bytes not characters! 0-based as it is the offset from the pointer.
				counter := 0
			until
				counter >= (length*2)
			loop
				a_least := managed_ptr.read_natural_8 (counter)
				a_most := managed_ptr.read_natural_8 (counter+1)
				if utf16.is_surrogate (a_most) then
						-- this is a surrogate, i.e a code point represented with 4 bytes
						-- we read the next character and glue the two together
					check utf16.is_high_surrogate (a_most) end
					check counter+2 < (length*2) end
					counter := counter + 2
					a_least := managed_ptr.read_natural_8 (counter)
					a_most := managed_ptr.read_natural_8 (counter+1)
					check utf16.is_low_surrogate (a_low_most) end
					Result.append_character (utf16.surrogate_from_bytes (a_most, a_least, a_low_most, a_low_least).to_character_32)
				else
						-- not a surrogate
					Result.append_character ((a_most*256 + a_least).to_character_32)
				end
				counter := counter + 2
			end

		end

	c_wcslen (ptr: POINTER): INTEGER
		external
			"C (void *): EIF_INTEGER| <string.h>"
		alias
			"wcslen"
		end

note
	library:   "Internationalization library"
	copyright: "Copyright (c) 1984-2006, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			356 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
