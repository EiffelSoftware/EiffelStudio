indexing
	description: "A low-level string class to solve some garbage %
		%collector problems (object move). The end-user must not use %
		%this class. Use class STRING instead."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	UNI_STRING

create
	make,
	make_empty,
	make_by_pointer

feature --{NONE} -- Initialization

	make (a_string: STRING) is
			-- Make a C string from `a_string'.
		require
			a_string_not_void: a_string /= Void
		local
			a: ANY
			nb: INTEGER
		do
			nb := a_string.count
			count := nb
			make_empty (nb)
			a := a_string.to_c
			nb := cwel_multi_byte_to_wide_char (feature {WEL_CP_CONSTANTS}.Cp_utf8, 0,
				$a, nb, managed_data.item, managed_data.count)
		end

	make_empty (a_length: INTEGER) is
			-- Make an empty C string of `a_length' characters.
			-- C memory area is not initialized.
		require
			positive_length: a_length >= 0
		do
			create managed_data.make (4 * (a_length + 1))
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
			create managed_data.make (4 * (lth + 1))
			managed_data.item.memory_copy (a_ptr, lth * 2)
		end
	
feature -- Access

	string: STRING is
			-- Eiffel string
		local
			u_string: UNI_STRING
			nb: INTEGER
		do
			create u_string.make_empty (length)
			nb := cwel_wide_char_to_multi_byte (feature {WEL_CP_CONSTANTS}.Cp_utf8, 0, item,
				length, u_string.item, u_string.capacity, default_pointer, default_pointer)
			create Result.make_from_c (u_string.item)
		end

	item: POINTER is
			-- Get pointer to allocated area.
		do
			Result := managed_data.item
		ensure
			item_not_null: Result /= default_pointer
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
			a: ANY
			nb: INTEGER
			new_size: INTEGER
		do
			nb := a_string.count
			count := nb
			
			a := a_string.to_c

			new_size := 4 * (nb + 1)
			
			if managed_data.count < new_size  then
				managed_data.resize (new_size)
			end

			nb := cwel_multi_byte_to_wide_char (feature {WEL_CP_CONSTANTS}.Cp_utf8, 0,
				$a, nb, managed_data.item, managed_data.count)

			managed_data.put_integer_16 (0, nb * 2)
		end

feature {NONE} -- Implementation

	managed_data: MANAGED_POINTER
			-- Hold data of Current.

	cwel_string_length (ptr: POINTER): INTEGER is
		external
			"C macro signature (wchar_t *): EIF_INTEGER use %"eif_str.h%""
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

end -- class UNI_STRING

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
