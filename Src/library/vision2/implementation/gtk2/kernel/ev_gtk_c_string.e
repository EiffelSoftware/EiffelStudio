indexing
	description: "A low-level string class to solve some garbage collector problems (mainly objects moving around) when interfacing with C APIs"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GTK_C_STRING

inherit
	DISPOSABLE

create
	set_with_eiffel_string, share_from_pointer, make_from_pointer

convert
	set_with_eiffel_string ({STRING})
	
feature {NONE} -- Initialization

	share_from_pointer (a_utf8_ptr: POINTER) is
			-- Set `Current' to use `a_utf8_ptr'.
			-- `a_utf8_ptr' is now owned by `Current' as it isn't copied so do not free from outside.
		require
			a_utf8_ptr_not_null: a_utf8_ptr /= default_pointer
		do
			set_from_pointer (a_utf8_ptr, byte_length_from_utf8_ptr (a_utf8_ptr), True)
		end

	make_from_pointer (a_utf8_ptr: POINTER) is
			-- Set `item' to `a_utf8_ptr' and gain ownership of memory.
		require
			a_utf8_ptr_not_null: a_utf8_ptr /= default_pointer
		do
			set_from_pointer (a_utf8_ptr, byte_length_from_utf8_ptr (a_utf8_ptr),  False)
		end

feature -- Access

	is_shared: BOOLEAN
		-- Is `item' shared with gtk?

	item: POINTER
			-- Pointer to the UTF8 string

	string: STRING is
			-- Locale string representation of the UTF8 string
		local
			str_ptr: POINTER
			bytes_read, bytes_written: INTEGER
			gerror: POINTER
			l_item: POINTER
		do
			l_item := item
			{EV_GTK_DEPENDENT_EXTERNALS}.g_locale_from_utf8 (l_item, string_length, $bytes_read, $bytes_written, $gerror, $str_ptr)
			if str_ptr /= default_pointer then
				create Result.make (bytes_written)
				Result.from_c_substring (str_ptr, 1, bytes_written)
				{EV_GTK_EXTERNALS}.g_free (str_ptr)
			else
				-- Sometimes the UTF8 string cannot be translated
				create Result.make_from_c (l_item)
			end
		end

	string_length: INTEGER
			-- Length of string data held in `managed_data'

	set_with_eiffel_string (a_string: STRING) is
			-- Create `item' and retian ownership.
		do
			internal_set_with_eiffel_string (a_string, False)
		end

	share_with_eiffel_string (a_string: STRING) is
			-- Create `item' but do not take ownership.
		do
			internal_set_with_eiffel_string (a_string, True)
		end

feature {NONE} -- Implementation

	internal_set_with_eiffel_string (a_string: STRING; a_shared: BOOLEAN) is
			-- Create a UTF8 string from Eiffel String `a_string'
		require
			a_string_not_void: a_string /= Void
		local
			utf8_ptr: POINTER
			string_value: ANY
			bytes_read, bytes_written: INTEGER
			gerror: POINTER
			i: INTEGER
			a_str, temp_string: STRING
			a_end: POINTER
			a_string_size: INTEGER
		do
			string_value := a_string.to_c
			{EV_GTK_DEPENDENT_EXTERNALS}.g_locale_to_utf8 ($string_value, a_string.count, $bytes_read, $bytes_written, $gerror, $utf8_ptr)
			if utf8_ptr = default_pointer then
					-- An error has occurred, this is probably due to `a_string' containing invalid characters
				from
					i := 1
					a_str := a_string.twin
				until
					i > a_str.count
				loop
					temp_string := a_str.item (i).out
					string_value := temp_string.to_c
					if not {EV_GTK_DEPENDENT_EXTERNALS}.g_utf8_validate ($string_value, -1, $a_end) then
						a_str.put (' ', i)
							-- If character doesn't validate as UTF8 then we change to a blank character
					end
					i := i + 1
				end
				string_value := a_str.to_c
				{EV_GTK_DEPENDENT_EXTERNALS}.g_locale_to_utf8 ($string_value, -1, $bytes_read, $bytes_written, $gerror, $utf8_ptr)
			end
				-- The value of bytes_written doesn't take the null character in to account
			a_string_size := bytes_written + 1
			set_from_pointer (utf8_ptr, a_string_size, a_shared)
		end

	set_from_pointer (a_ptr: POINTER; a_size: INTEGER; a_shared: BOOLEAN) is
			--  Set `item' to use `a_ptr'.
		require
			a_ptr_not_null: a_ptr /= default_pointer
			size_valid: a_size > 0
		do
			if item /= default_pointer and then not is_shared then
				{EV_GTK_EXTERNALS}.g_free (item)
			end
			string_length := a_size - 1
			item := a_ptr
			is_shared := a_shared
		end

	byte_length_from_utf8_ptr (a_utf8_ptr: POINTER): INTEGER is
			-- Length in bytes of UTF8 pointer `a_utf8_ptr'.
		require
			a_utf8_ptr_not_null: a_utf8_ptr /= default_pointer
		local
			end_byte: POINTER
		do
			if {EV_GTK_DEPENDENT_EXTERNALS}.g_utf8_validate (a_utf8_ptr, -1, $end_byte) then
				Result := pointer_diff (a_utf8_ptr, end_byte) + 1
			else
				Result := {EV_GTK_EXTERNALS}.g_utf8_strlen (a_utf8_ptr, -1) + 1
			end
		end

	pointer_diff (a_ptr1, a_ptr2: POINTER): INTEGER is
			-- Difference between two pointers
			--| FIXME Remove when pointer arithmetic is added to POINTER_REF
		external
			"C inline"
		alias
			"(EIF_INTEGER) ((rt_int_ptr) $a_ptr2 - (rt_int_ptr) $a_ptr1)"
		end

	dispose is
			-- Dispose `Current'.
		do
			if item /= default_pointer and then not is_shared then
				{EV_GTK_EXTERNALS}.g_free (item)
			end
		end

end -- class EV_GTK_C_STRING

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

