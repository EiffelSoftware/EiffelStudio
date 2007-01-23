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

feature -- String encoding convertion

	convert_to (a_from_code_page: STRING; a_from_string: STRING_GENERAL; a_to_code_page: STRING): STRING_GENERAL is
			-- Convert `a_from_string' of `a_from_code_page' to a string of `a_to_code_page'.
		local
			l_pointer, l_o_pointer: POINTER
			l_m_t_w: BOOLEAN
			l_count: INTEGER
			l_code_page: STRING
			l_from_code_page, l_to_code_page: STRING
			l_string_32: STRING_32
			l_from_be, l_to_be: BOOLEAN
		do
			l_from_code_page := code_pages.item (a_from_code_page)
			l_to_code_page := code_pages.item (a_to_code_page)

			l_from_be := big_endian_codepage.has (a_from_code_page)
			l_to_be := big_endian_codepage.has (a_to_code_page)

			last_conversion_successful := True
			if two_byte_codesets.has (a_from_code_page) then
				l_string_32 := a_from_string.as_string_32
				if l_from_be = is_little_endian then
					l_string_32 := string_16_switch_endian (l_string_32)
				end
				if four_byte_codesets.has (a_to_code_page) then
					l_string_32 := utf16_to_utf32 (l_string_32)
					if l_to_be = is_little_endian then
						Result := string_32_switch_endian (l_string_32)
					else
						Result := l_string_32
					end
				elseif two_byte_codesets.has (a_to_code_page) then
					if l_to_be = is_little_endian then
						Result := string_16_switch_endian (l_string_32)
					else
						Result := l_string_32
					end
				else
					Result := wide_char_to_multi_byte (l_to_code_page, l_string_32)
				end
			elseif four_byte_codesets.has (a_from_code_page) then
				l_string_32 := a_from_string.as_string_32
				if l_from_be = is_little_endian then
					l_string_32 := string_32_switch_endian (l_string_32)
				end
				if two_byte_codesets.has (a_to_code_page) then
					l_string_32 := utf32_to_utf16 (l_string_32)
					if l_to_be = is_little_endian then
						Result := string_16_switch_endian (l_string_32)
					else
						Result := l_string_32
					end
				elseif four_byte_codesets.has (a_to_code_page) then
					if l_to_be = is_little_endian then
						Result := string_32_switch_endian (l_string_32)
					else
						Result := l_string_32.twin
					end
				else
					Result := utf32_to_utf16 (l_string_32)
					Result := wide_char_to_multi_byte (l_to_code_page, Result)
				end
			else
				l_string_32 := multi_byte_to_wide_char (l_from_code_page, a_from_string.as_string_8)
				if two_byte_codesets.has (a_to_code_page) then
					if l_to_be = is_little_endian then
						Result := string_16_switch_endian (l_string_32)
					else
						Result := l_string_32
					end
				elseif four_byte_codesets.has (a_to_code_page) then
					l_string_32 := utf16_to_utf32 (l_string_32)
					if l_to_be = is_little_endian then
						Result := string_32_switch_endian (l_string_32)
					else
						Result := l_string_32
					end
				else
					Result := wide_char_to_multi_byte (l_to_code_page, l_string_32)
				end
			end
		end

	wide_char_to_multi_byte (a_code_page: STRING; a_string: STRING_32): STRING_8 is
			-- Convert UTF-16 string into 8bit string by `a_code_page'.
		local
			l_pointer: POINTER
			l_count: INTEGER
		do
			l_pointer := cwin_wide_char_to_multi_byte (a_code_page.to_integer, wide_string_to_pointer (a_string), $l_count, $last_conversion_successful)
			Result := pointer_to_multi_byte (l_pointer, l_count - 1)
			l_pointer.memory_free
		end

	multi_byte_to_wide_char (a_code_page: STRING; a_string: STRING_8): STRING_32 is
			-- Convert 8bit string into UTF-16 string by `a_code_page'.
		local
			l_pointer: POINTER
			l_count: INTEGER
		do
			l_pointer := cwin_multi_byte_to_wide_char (a_code_page.to_integer, multi_byte_to_pointer (a_string), $l_count, $last_conversion_successful)
			Result := pointer_to_wide_string (l_pointer, (l_count - 1) * 2)
			l_pointer.memory_free
		end

feature -- Status report

	is_code_page_valid (a_code_page: STRING): BOOLEAN is
			-- Is `a_code_page' valid?
		do
			if a_code_page /= Void and then a_code_page /= Void then
				Result := code_pages.has (a_code_page)
			end
		end

feature {NONE} -- Implementation

	cwin_wide_char_to_multi_byte (cpid: INTEGER; a_wide_string: POINTER; a_count_to_buffer: TYPED_POINTER [INTEGER]; a_b: TYPED_POINTER [BOOLEAN]): POINTER is
		external
			"C inline use <windows.h>"
		alias
			"[
				LPSTR temp;
				DWORD dw;
			    *$a_count_to_buffer = WideCharToMultiByte ($cpid, 0, $a_wide_string, -1, NULL, 0, NULL, NULL);
			    
			    temp = malloc ((sizeof (LPSTR) * *$a_count_to_buffer));
			    if (temp == NULL){
			    	*$a_b = 0;
			    	return;
			    }
			    			    	
				WideCharToMultiByte ($cpid, 0, $a_wide_string, -1, temp, *$a_count_to_buffer, NULL, NULL);
				dw = GetLastError();
				if (dw == ERROR_INSUFFICIENT_BUFFER || dw == ERROR_INVALID_FLAGS || dw == ERROR_INVALID_PARAMETER)
					*$a_b = 0;
				return (EIF_POINTER) temp;
			]"
		end

	cwin_multi_byte_to_wide_char (cpid: INTEGER; a_multi_byte: POINTER; a_count_to_buffer: TYPED_POINTER [INTEGER]; a_b: TYPED_POINTER [BOOLEAN]): POINTER is
		external
			"C inline use <windows.h>"
		alias
			"[
				LPWSTR temp;
				DWORD dw;
			    *$a_count_to_buffer = MultiByteToWideChar ($cpid, 0, $a_multi_byte, -1, NULL, 0);
			    
			    temp = malloc ((sizeof (LPWSTR) * *$a_count_to_buffer));
			    if (temp == NULL){
			    	*$a_b = 0;
			    	return;
			    }
			    
				MultiByteToWideChar ($cpid,	0, $a_multi_byte, -1, temp, *$a_count_to_buffer);
				dw = GetLastError();
				if (dw == ERROR_INSUFFICIENT_BUFFER || dw == ERROR_INVALID_FLAGS || dw == ERROR_INVALID_PARAMETER || dw == ERROR_NO_UNICODE_TRANSLATION)
					*$a_b = 0;
				return (EIF_POINTER) temp;
			]"
		end

indexing
	library:   "EiffelBase: Library of reusable components for Eiffel."
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
