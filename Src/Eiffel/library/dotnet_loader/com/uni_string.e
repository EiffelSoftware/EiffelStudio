indexing
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

	make (a_string: STRING) is
			-- Make a C string from `a_string'.
		require
			a_string_not_void: a_string /= Void
		do
			make_empty (a_string.count)
			set_string (a_string)
		end

	make_empty (a_length: INTEGER) is
			-- Make an empty C string of `a_length' characters.
			-- C memory area is not initialized.
		require
			positive_length: a_length >= 0
		do
			create managed_data.make (2 * (a_length + 1))
			count := 0
		end
	
	make_by_pointer (a_ptr: POINTER) is
			-- Make a copy of unicode string pointed by `a_ptr'.
		require
			a_ptr_not_null: a_ptr /= default_pointer
		local
			lth: INTEGER
		do
			lth := cwel_string_length (a_ptr)
			make_by_pointer_and_count (a_ptr, lth)
		end

	make_by_pointer_and_count (a_ptr: POINTER; a_count: INTEGER) is
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

	string: STRING is
			-- Eiffel string
		do
			Result := string_with_count (length)
		end
		
	string_with_count (a_count: INTEGER): STRING is
			-- Retrieve first `a_count' characters of Current to create a new Eiffel string
		require
			a_count_non_negative: a_count >= 0
			a_count_less_than_capacity: a_count <= count
		local
			u_string: UNI_STRING
			nb: INTEGER
		do
			create u_string.make_empty (a_count)
			nb := cwel_wide_char_to_multi_byte ({WEL_CP_CONSTANTS}.Cp_acp, 0, item,
				a_count, u_string.item, u_string.capacity, default_pointer, default_pointer)
			create Result.make (a_count + 1)
			Result.from_c_substring (u_string.item, 1, a_count)
		end

	item: POINTER is
			-- Get pointer to allocated area.
		do
			Result := managed_data.item
		ensure
			item_not_null: Result /= default_pointer
		end

feature -- Status report

	is_empty: BOOLEAN is
			-- Is current empty?
		do
			Result := length = 0
		end

	capacity: INTEGER is
			-- Number of character in Current.
		do
			Result := managed_data.count
		end

	count: INTEGER

	length: INTEGER is
			-- 
		do
			Result := cwel_string_length (item)
		end
		
feature -- Element change

	set_string (a_string: STRING) is
			-- Set `string' with `a_string'.
		require
			a_string_not_void: a_string /= Void
		local
			i, nb: INTEGER
			new_size: INTEGER
			l_area: SPECIAL [CHARACTER]
			l_c: CHARACTER
		do
			nb := a_string.count - 1
			count := nb + 1
			
			new_size := 2 * (nb + 2)
			
			if managed_data.count < new_size  then
				managed_data.resize (new_size)
			end

			from
				i := 0
				l_area := a_string.area
			until
				i > nb
			loop
				l_c := l_area.item (i)
				managed_data.put_integer_8 (l_c.code.to_integer_8, i * 2)
				managed_data.put_integer_8 (0, i * 2 + 1)
				i := i + 1
			end
			managed_data.put_integer_16 (0, (nb + 1) * 2)
		end

feature {NONE} -- Implementation

	managed_data: MANAGED_POINTER
			-- Hold data of Current.

	cwel_string_length (ptr: POINTER): INTEGER is
		external
			"C macro signature (wchar_t *): EIF_INTEGER use <string.h>"
		alias
			"wcslen"
		end	
		
	cwel_byte_size (ptr: POINTER): INTEGER is
		external
			"C macro signature (char *): EIF_INTEGER use <windows.h>"
		alias
			"sizeof"
		end	

	cwel_set_size_in_string (ptr: POINTER; n: INTEGER) is
		external
			"C [macro %"wel_string.h%"]"
		end

	cwel_multi_byte_to_wide_char (code_page, flags: INTEGER; source: POINTER;
			source_length: INTEGER; dest: POINTER; dest_size: INTEGER): INTEGER
		is
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
		is
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class UNI_STRING

