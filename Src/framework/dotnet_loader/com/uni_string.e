note
	description: "A low-level string class to solve some garbage %
		%collector problems (object move). The end-user must not use %
		%this class. Use class STRING instead."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	UNI_STRING

create
	make,
	make_empty,
	make_by_pointer,
	make_by_pointer_and_count

feature --{NONE} -- Initialization

	make (a_string: READABLE_STRING_GENERAL)
			-- Make a C string from `a_string'.
		require
			a_string_not_void: a_string /= Void
		do
			make_empty (a_string.count)
			set_string (a_string)
		end

	make_empty (a_length: INTEGER)
			-- Make an empty C string of `a_length' characters.
			-- C memory area is not initialized.
		require
			positive_length: a_length >= 0
		do
			create managed_data.make (2 * (a_length + 1))
			count := 0
		end

	make_by_pointer (a_ptr: POINTER)
			-- Make a copy of unicode string pointed by `a_ptr'.
		require
			a_ptr_not_null: a_ptr /= default_pointer
		local
			lth: INTEGER
		do
			lth := cwel_string_length (a_ptr)
			make_by_pointer_and_count (a_ptr, lth)
		end

	make_by_pointer_and_count (a_ptr: POINTER; a_count: INTEGER)
			-- Make a copy of first `a_count' characters of
			-- unicode string pointed by `a_ptr'.
		require
			a_ptr_not_null: a_ptr /= default_pointer
			a_count_non_negative: a_count >= 0
		do
			count := a_count
			create managed_data.make (2 * (a_count + 1))
			managed_data.item.memory_copy (a_ptr, a_count * 2)
		end

feature -- Access

	string: STRING
			-- Eiffel string
		do
			Result := string_with_count (length)
		end

	string_with_count (a_count: INTEGER): STRING
			-- Retrieve first `a_count' characters of Current to create a new Eiffel string
		require
			a_count_non_negative: a_count >= 0
			a_count_less_than_capacity: a_count <= count
		local
			u_string: UNI_STRING
			nb: INTEGER
			l_ansi_code_page: INTEGER
		do
			create u_string.make_empty (a_count)
				-- This is hard coded to compile on all platforms. Originally defined as
				-- {WEL_CP_CONSTANTS}.Cp_acp.
			l_ansi_code_page := 0
			nb := cwel_wide_char_to_multi_byte (l_ansi_code_page, 0, item,
				a_count, u_string.item, u_string.capacity, default_pointer, default_pointer)
			create Result.make (a_count + 1)
			Result.from_c_substring (u_string.item, 1, a_count)
		end

	item: POINTER
			-- Get pointer to allocated area.
		do
			Result := managed_data.item
		ensure
			item_not_null: Result /= default_pointer
		end

feature -- Status report

	is_empty: BOOLEAN
			-- Is current empty?
		do
			Result := length = 0
		end

	capacity: INTEGER
			-- Number of character in Current.
		do
			Result := managed_data.count
		end

	count: INTEGER

	length: INTEGER
			--
		do
			Result := cwel_string_length (item)
		end

feature -- Element change

	set_string (a_string: READABLE_STRING_GENERAL)
			-- Set `string' with `a_string'.
		require
			a_string_not_void: a_string /= Void
		local
			u: UTF_CONVERTER
		do
				-- Convert `a_string' to UTF-16 with a terminating zero.
			u.string_32_into_utf_16_0_pointer (a_string.as_string_32, managed_data)
			count := a_string.count
		end

	set_string_16 (a_string: STRING_32)
			-- Set `string' with `a_string'.
			-- Put UTF-16 as .NET requires.
		obsolete "Use `set_string'."
		require
			a_string_not_void: a_string /= Void
		do
			set_string (a_string)
		end

feature {NONE} -- Implementation

	managed_data: MANAGED_POINTER
			-- Hold data of Current.

	cwel_string_length (ptr: POINTER): INTEGER
		external
			"C macro signature (wchar_t *): EIF_INTEGER use <string.h>"
		alias
			"wcslen"
		end

	cwel_byte_size (ptr: POINTER): INTEGER
		external
			"C macro signature (char *): EIF_INTEGER use <windows.h>"
		alias
			"sizeof"
		end

	cwel_set_size_in_string (ptr: POINTER; n: INTEGER)
		external
			"C [macro %"wel_string.h%"]"
		end

	cwel_multi_byte_to_wide_char (code_page, flags: INTEGER; source: POINTER;
			source_length: INTEGER; dest: POINTER; dest_size: INTEGER): INTEGER

			-- Given a `source' of a specific `code_page' return associated
			-- Unicode string in `dest'.
		external
			"C macro signature (UINT, DWORD, LPCSTR, int, LPWSTR, int): EIF_INTEGER use <windows.h>"
		alias
			"MultiByteToWideChar"
		end

	cwel_wide_char_to_multi_byte (code_page, flags: INTEGER; source: POINTER;
			source_length: INTEGER; dest: POINTER; dest_size: INTEGER;
			default_char, used_default_char: POINTER): INTEGER

			-- Given a unicode `source' return associated string in `dest'
			-- using specific `code_page'.
		external
			"C macro signature (UINT, DWORD, LPCWSTR, int, LPSTR, int, LPCSTR, LPBOOL): EIF_INTEGER use <windows.h>"
		alias
			"WideCharToMultiByte"
		end

invariant
	managed_data_not_void: managed_data /= Void
	count_not_negative: count >= 0

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class UNI_STRING

