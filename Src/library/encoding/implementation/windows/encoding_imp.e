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
			a_string_32: STRING_32
		do
			if a_from_code_page.is_equal (utf16) then
				if a_to_code_page.is_equal (utf32) then
					Result := utf16_to_utf32 (a_from_string)
				elseif a_to_code_page.is_equal (utf16) then
					Result := a_from_string.twin
				else
					Result := wide_char_to_multi_byte (code_pages.item (a_to_code_page), a_from_string.as_string_32)
				end
			elseif a_from_code_page.is_equal (utf32) then
				if a_to_code_page.is_equal (utf16) then
					Result := utf32_to_utf16 (a_from_string)
				elseif a_to_code_page.is_equal (utf32) then
					Result := a_from_string.twin
				else
					Result := utf32_to_utf16 (a_from_string)
					Result := wide_char_to_multi_byte (code_pages.item (a_to_code_page), Result)
				end
			else
				a_string_32 := multi_byte_to_wide_char (code_pages.item (a_from_code_page), a_from_string.as_string_8)
				if a_to_code_page.is_equal (utf16) then
					Result := a_string_32
				elseif a_to_code_page.is_equal (utf32) then
					Result := utf16_to_utf32 (a_string_32)
				else
					Result := wide_char_to_multi_byte (code_pages.item (a_to_code_page), a_string_32)
				end
			end
		end

	wide_char_to_multi_byte (a_code_page: STRING; a_string: STRING_32): STRING_8 is
			-- Convert UTF-16 string into 8bit string by `a_code_page'.
		local
			l_pointer: POINTER
			l_count: INTEGER
		do
			l_pointer := cwin_wide_char_to_multi_byte (a_code_page.to_integer, wide_string_to_pointer (a_string), $l_count)
			Result := pointer_to_multi_byte (l_pointer, l_count - 1)
			l_pointer.memory_free
		end

	multi_byte_to_wide_char (a_code_page: STRING; a_string: STRING_8): STRING_32 is
			-- Convert 8bit string into UTF-16 string by `a_code_page'.
		local
			l_pointer: POINTER
			l_count: INTEGER
		do
			l_pointer := cwin_multi_byte_to_wide_char (a_code_page.to_integer, multi_byte_to_pointer (a_string), $l_count)
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

	cwin_wide_char_to_multi_byte (cpid: INTEGER; a_wide_string: POINTER; a_count_to_buffer: TYPED_POINTER [INTEGER]): POINTER is
		external
			"C inline use <windows.h>"
		alias
			"[
				LPSTR temp;
			    *$a_count_to_buffer = WideCharToMultiByte ($cpid, 0, $a_wide_string, -1, NULL, 0, NULL, NULL);
			    temp = malloc ((sizeof (LPSTR) * *$a_count_to_buffer));
				WideCharToMultiByte ($cpid, 0, $a_wide_string, -1, temp, *$a_count_to_buffer, NULL, NULL);
				return (EIF_POINTER) temp;
			]"
		end

	cwin_multi_byte_to_wide_char (cpid: INTEGER; a_multi_byte: POINTER; a_count_to_buffer: TYPED_POINTER [INTEGER]): POINTER is
		external
			"C inline use <windows.h>"
		alias
			"[
				LPWSTR temp;
			    *$a_count_to_buffer = MultiByteToWideChar ($cpid, 0, $a_multi_byte, -1, NULL, 0);
			    temp = malloc ((sizeof (LPWSTR) * *$a_count_to_buffer));
				MultiByteToWideChar ($cpid,	0, $a_multi_byte, -1, temp, *$a_count_to_buffer);
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
