indexing
	description: "A low-level string class to solve some garbage %
		%collector problems (object move). The end-user must not use %
		%this class. Use class STRING instead."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	C_STRING

create
	make,
	make_empty,
	make_by_pointer

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
			a_length_positive: a_length >= 0
		do
			create managed_data.make ((a_length + 1))
			count := 0
		end
	
	make_by_pointer (a_ptr: POINTER) is
			-- Make a copy of string pointed by `a_ptr'.
		require
			a_ptr_not_null: a_ptr /= default_pointer
		do
			make_by_pointer_and_count (a_ptr, c_strlen (a_ptr))
		end
		
	make_by_pointer_and_count (a_ptr: POINTER; a_length: INTEGER) is
			-- Make a copy of first `a_length' byte of string pointed by `a_ptr'.
		require
			a_ptr_not_null: a_ptr /= default_pointer
			a_length_positive: a_length >= 0
		do
			count := a_length
			create managed_data.make ((a_length + 1))
			managed_data.item.memory_copy (a_ptr, a_length)
		end

feature -- Access

	substring (start_pos, end_pos: INTEGER): STRING is
			-- Copy of substring containing all characters at indices
			-- between `start_pos' and `end_pos'.
		require
			start_position_big_enough: start_pos >= 1
			end_position_big_enough: start_pos <= end_pos + 1
			end_position_not_too_big: end_pos <= count
		do
			create Result.make (end_pos - start_pos + 1)
			Result.from_c_substring (item, start_pos, end_pos)
		end
		
	string: STRING is
			-- Eiffel string
		do
			create Result.make_from_c (item)
		end

	item: POINTER is
			-- Get pointer to allocated area.
		do
			Result := managed_data.item
		ensure
			item_not_null: Result /= default_pointer
		end

feature -- Measurement

	capacity: INTEGER is
			-- Number of characters in Current.
		do
			Result := managed_data.count
		end

	count: INTEGER
			-- Number of characters in Current.

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
			nb := a_string.count
			count := nb
			
			new_size := nb + 1
			
			if managed_data.count < new_size  then
				managed_data.resize (new_size)
			end

			from
				i := 0
				l_area := a_string.area
			until
				i >= nb
			loop
				l_c := l_area.item (i)
				managed_data.put_integer_8 (l_c.code.to_integer_8, i)
				i := i + 1
			end
			managed_data.put_integer_8 (0, nb)
		end

feature {NONE} -- Implementation

	managed_data: MANAGED_POINTER
			-- Hold data of Current.

	c_strlen (ptr: POINTER): INTEGER is
		external
			"C macro signature (char *): EIF_INTEGER use %"eif_str.h%""
		alias
			"strlen"
		end	
		
invariant
	managed_data_not_void: managed_data /= Void
	count_not_negative: count >= 0

end -- class C_STRING

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
