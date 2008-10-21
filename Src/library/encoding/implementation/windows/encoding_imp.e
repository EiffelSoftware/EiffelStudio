indexing
	description: "Encoding conversion implementation on Windows"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ENCODING_IMP

inherit
	ENCODING_I

	CODE_PAGES
		export
			{NONE} all
		end

feature -- String encoding convertion

	convert_to (a_from_code_page: STRING; a_from_string: STRING_GENERAL; a_to_code_page: STRING) is
			-- Convert `a_from_string' of `a_from_code_page' to a string of `a_to_code_page'.
		local
			l_count: INTEGER
			l_code_page: STRING
			l_from_code_page, l_to_code_page: STRING
			l_string_32: STRING_32
			l_from_be, l_to_be: BOOLEAN
			l_converted_32: STRING_32
			l_converted_8: STRING_8
		do
			l_from_code_page := platfrom_code_page_from_name (a_from_code_page)
			l_to_code_page := platfrom_code_page_from_name (a_to_code_page)

			l_from_be := is_big_endian_code_page (a_from_code_page)
			l_to_be := is_big_endian_code_page (a_to_code_page)

			last_conversion_successful := True
			if is_two_byte_code_page (a_from_code_page) then
				l_string_32 := a_from_string.as_string_32
				if l_from_be = is_little_endian then
					l_string_32 := string_16_switch_endian (l_string_32)
				end
				if is_four_bype_code_page (a_to_code_page) then
					l_string_32 := utf16_to_utf32 (l_string_32)
					if l_to_be = is_little_endian then
						l_converted_32 := string_32_switch_endian (l_string_32)
					else
						l_converted_32 := l_string_32
					end
					last_converted_string := l_converted_32
				elseif is_two_byte_code_page (a_to_code_page) then
					if l_to_be = is_little_endian then
						l_converted_32 := string_16_switch_endian (l_string_32)
					else
						l_converted_32 := l_string_32
					end
					last_converted_string := l_converted_32
					last_was_wide_string := True
				else
					l_converted_8 := wide_char_to_multi_byte (l_to_code_page, l_string_32)
					last_converted_string := l_converted_8
				end
			elseif is_four_bype_code_page (a_from_code_page) then
				l_string_32 := a_from_string.as_string_32
				if l_from_be = is_little_endian then
					l_string_32 := string_32_switch_endian (l_string_32)
				end
				if is_two_byte_code_page (a_to_code_page) then
					l_string_32 := utf32_to_utf16 (l_string_32)
					if l_to_be = is_little_endian then
						l_converted_32 := string_16_switch_endian (l_string_32)
					else
						l_converted_32 := l_string_32
					end
					last_converted_string := l_converted_32
					last_was_wide_string := True
				elseif is_four_bype_code_page (a_to_code_page) then
					if l_to_be = is_little_endian then
						l_converted_32 := string_32_switch_endian (l_string_32)
					else
						l_converted_32 := l_string_32.twin
					end
					last_converted_string := l_converted_32
				else
					l_converted_32 := utf32_to_utf16 (l_string_32)
					l_converted_8 := wide_char_to_multi_byte (l_to_code_page, l_converted_32)
					last_converted_string := l_converted_8
				end
			else
				l_string_32 := multi_byte_to_wide_char (l_from_code_page, a_from_string.as_string_8)
				if is_two_byte_code_page (a_to_code_page) then
					if l_to_be = is_little_endian then
						l_converted_32 := string_16_switch_endian (l_string_32)
					else
						l_converted_32 := l_string_32
					end
					last_converted_string := l_converted_32
					last_was_wide_string := True
				elseif is_four_bype_code_page (a_to_code_page) then
					l_string_32 := utf16_to_utf32 (l_string_32)
					if l_to_be = is_little_endian then
						l_converted_32 := string_32_switch_endian (l_string_32)
					else
						l_converted_32 := l_string_32
					end
					last_converted_string := l_converted_32
				else
					l_converted_8 := wide_char_to_multi_byte (l_to_code_page, l_string_32)
					last_converted_string := l_converted_8
				end
			end
		end

	wide_char_to_multi_byte (a_code_page: STRING; a_string: STRING_32): STRING_8 is
			-- Convert UTF-16 string into 8bit string by `a_code_page'.
		local
			l_count: INTEGER
			l_string: MANAGED_POINTER
			l_out_string: MANAGED_POINTER
		do
			l_string := wide_string_to_pointer (a_string)
			l_count := cwin_WideCharToMultiByte_buffer_length (a_code_page.to_integer, l_string.item)
			create l_out_string.make (l_count)
			cwin_wide_char_to_multi_byte (a_code_page.to_integer, l_string.item, l_out_string.item, l_count, $last_conversion_successful)
			Result := pointer_to_multi_byte (l_out_string.item, l_count - 1)
		end

	multi_byte_to_wide_char (a_code_page: STRING; a_string: STRING_8): STRING_32 is
			-- Convert 8bit string into UTF-16 string by `a_code_page'.
		local
			l_count: INTEGER
			l_string: MANAGED_POINTER
			l_out_string: MANAGED_POINTER
		do
			l_string := multi_byte_to_pointer (a_string)
			l_count := cwin_MultiByteToWideChar_buffer_length (a_code_page.to_integer, l_string.item)
			create l_out_string.make (l_count * Wchar_length)
			cwin_multi_byte_to_wide_char (a_code_page.to_integer, l_string.item, l_out_string.item, l_count, $last_conversion_successful)
			Result := pointer_to_wide_string (l_out_string.item, (l_count - 1) * 2)
		end

feature -- Status report

	is_code_page_valid (a_code_page: STRING): BOOLEAN is
			-- Is `a_code_page' valid?
		do
			if a_code_page /= Void and then not a_code_page.is_empty then
				Result := is_known_code_page (a_code_page)
			end
		end

	is_code_page_convertable (a_from_code_page, a_to_code_page: STRING): BOOLEAN is
			-- Is `a_from_code_page' convertable to `a_to_code_page'.
		do
				-- Always true. It is not really interesting here on windows without converting strings.
				-- `last_conversion_successful' reflects correct result.
			Result := True
		end

feature {NONE} -- Access

	platfrom_code_page_from_name (a_code_page_name: STRING): STRING is
			-- Code page the OS supported.
			-- Result can be passed to Windows API.
		require
			a_code_page_name_not_void: a_code_page_name /= Void
			a_code_page_name_not_empty: not a_code_page_name.is_empty
			a_code_page_valid: is_code_page_valid (a_code_page_name)
		do
			Result := code_pages.item (a_code_page_name.as_lower)
		ensure
			Result_not_void: Result /= Void
		end

feature {NONE} -- Status report

	is_known_code_page (a_code_page: STRING): BOOLEAN is
			-- Is `a_code_page' a known code page?
		require
			a_code_page_not_void: a_code_page /= Void
			a_code_page_not_empty: not a_code_page.is_empty
		do
			Result := code_pages.has (a_code_page.as_lower)
		end

	is_two_byte_code_page (a_code_page: STRING): BOOLEAN is
			-- Is `a_code_page' a known code page?
		require
			a_code_page_not_void: a_code_page /= Void
			a_code_page_not_empty: not a_code_page.is_empty
		do
			Result := two_byte_code_pages.has (a_code_page.as_lower)
		end

	is_four_bype_code_page (a_code_page: STRING): BOOLEAN is
			-- Is `a_code_page' a known code page?
		require
			a_code_page_not_void: a_code_page /= Void
			a_code_page_not_empty: not a_code_page.is_empty
		do
			Result := four_byte_code_pages.has (a_code_page.as_lower)
		end

	is_big_endian_code_page (a_code_page: STRING): BOOLEAN is
			-- Is `a_code_page' a known code page?
		require
			a_code_page_not_void: a_code_page /= Void
			a_code_page_not_empty: not a_code_page.is_empty
		do
			Result := big_endian_code_pages.has (a_code_page.as_lower)
		end

feature {NONE} -- Implementation

	cwin_WideCharToMultiByte_buffer_length (cpid: INTEGER; a_wide_string: POINTER): INTEGER is
			-- Get buffer length of converted result.
		external
			"C inline use <windows.h>"
		alias
			"return WideCharToMultiByte ($cpid, 0, $a_wide_string, -1, NULL, 0, NULL, NULL);"
		end

	cwin_MultiByteToWideChar_buffer_length (cpid: INTEGER; a_multi_byte: POINTER): INTEGER is
			-- Get buffer length of converted result.
		external
			"C inline use <windows.h>"
		alias
			"return MultiByteToWideChar ($cpid, 0, $a_multi_byte, -1, NULL, 0);"
		end

	cwin_wide_char_to_multi_byte (cpid: INTEGER; a_wide_string: POINTER; a_out_pointer: POINTER; a_count_to_buffer: INTEGER; a_b: TYPED_POINTER [BOOLEAN]) is
		external
			"C inline use <windows.h>"
		alias
			"[
				DWORD dw;
			    			    	
				WideCharToMultiByte ((UINT) $cpid, (DWORD) 0, (LPCWSTR) $a_wide_string,
					(int) -1, (LPSTR) $a_out_pointer, (int) $a_count_to_buffer, (LPCSTR) NULL, (LPBOOL) NULL);
				dw = GetLastError();
				if (dw == ERROR_INSUFFICIENT_BUFFER || dw == ERROR_INVALID_FLAGS || dw == ERROR_INVALID_PARAMETER) {
					*$a_b = 0;
				}
			]"
		end

	cwin_multi_byte_to_wide_char (cpid: INTEGER; a_multi_byte: POINTER; a_out_pointer: POINTER; a_count_to_buffer: INTEGER; a_b: TYPED_POINTER [BOOLEAN]) is
		external
			"C inline use <windows.h>"
		alias
			"[
				DWORD dw;
			    
				MultiByteToWideChar ((UINT) $cpid, (DWORD) 0, (LPCSTR) $a_multi_byte,
					(int) -1, (LPWSTR) $a_out_pointer, (int) $a_count_to_buffer);
				dw = GetLastError();
				if (dw == ERROR_INSUFFICIENT_BUFFER || dw == ERROR_INVALID_FLAGS || dw == ERROR_INVALID_PARAMETER || dw == ERROR_NO_UNICODE_TRANSLATION) {
					*$a_b = 0;
				}
			]"
		end

	Wchar_length: INTEGER is
			-- Length of WCHAR.
		external
			"C inline use <windows.h>"
		alias
			"return sizeof(WCHAR);"
		end


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
