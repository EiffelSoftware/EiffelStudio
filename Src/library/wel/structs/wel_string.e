indexing
	description: "A low-level string class to solve some garbage %
		%collector problems (object move). The end-user must not use %
		%this class. Use class STRING instead."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_STRING

inherit
	WEL_STRUCTURE
		rename
			make as structure_make
		end

creation
	make,
	make_empty,
	make_by_pointer

feature {NONE} -- Initialization

	make (a_string: STRING) is
			-- Make a C string from `a_string'.
		require
			a_string_not_void: a_string /= Void
		local
			a: ANY
			nb: INTEGER
		do
			nb := a_string.count
			make_empty (nb)
			a := a_string.to_c
			memory_copy ($a, nb + 1)
		ensure
			not_shared: not shared
		end

	make_empty (a_length: INTEGER) is
			-- Make an empty C string of `a_length' characters.
			-- C memory area is not initialized.
		require
			positive_length: a_length >= 0
		local
			a_default_pointer: POINTER
		do
			item := c_calloc (1, a_length + 1)
			if item = a_default_pointer then
					-- Memory allocation problem
				c_enomem
			end
			capacity := a_length + 1
			shared := False
		end

feature -- Access

	string: STRING is
			-- Eiffel string
		do
			create Result.make_from_c (item)
		ensure
			result_not_void: Result /= Void
		end

	null_separated_strings: LINKED_LIST [STRING] is
			-- Retrieve all string contained in `item'. Strings are
			-- NULL separared inside `item'.
		local
			current_string: STRING
			current_pos: POINTER
		do
			from
				create Result.make
				current_pos := item
				create current_string.make_from_c (current_pos)
			until
				current_string.is_empty
			loop
				Result.extend (current_string)
				current_pos := current_pos + current_string.count + 1
				create current_string.make_from_c (current_pos)
			end
		ensure
			result_not_void: Result /= Void
		end

	space_separated_strings: LINKED_LIST [STRING] is
			-- Retrieve all string contained in `item'. Strings are
			-- space-separared inside `item'.
		local
			curr_space: INTEGER
			next_space: INTEGER
			long_string: STRING
		do
			create long_string.make_from_c (item)
			create Result.make
			
				-- Add each "word" of the long_string to the Result-list
			from
				curr_space := 1
				next_space := long_string.index_of (' ',curr_space)
			until
				next_space = 0
			loop
				Result.extend (long_string.substring (curr_space, next_space - 1))
				curr_space := next_space + 1
				next_space := long_string.index_of (' ',curr_space)
			end
				-- No space left, extract the last string: from the last space until
				-- the end of the string.
			Result.extend (long_string.substring (curr_space, long_string.count))
		ensure
			result_not_void: Result /= Void
		end

	length, count: INTEGER is
			-- String length
		do
			Result := cwel_string_length (item)
		end
		
feature -- Element change

	set_string (a_string: STRING) is
			-- Set `string' with `a_string'.
		require
			a_string_not_void: a_string /= Void
			valid_count: a_string.count < capacity
		local
			a: ANY
		do
			a := a_string.to_c
			memory_copy ($a, a_string.count + 1)
		ensure
			string_set: a_string.is_equal (string)
		end

	set_null_character (offset: INTEGER) is
			-- Set `%U' at `offset' position of `Current'.
			-- First position being  at `0' index.
		require
			valid_offset: offset >= 0 and offset < capacity
		local
			a: CHARACTER
		do
			a := '%U'
			c_memcpy (item + offset, $a, 1)
		end

	set_size_in_string (n: INTEGER) is
			-- Set two first bytes of string pointed by `item' to
			-- value represented by `n' in a two bytes representation.
		require
			valid_size: n > 0
		do
			cwel_set_size_in_string (item, n)
		end

feature -- Measurement

	structure_size: INTEGER is
			-- String length
		do
			Result := capacity
		end

	capacity: INTEGER
			-- Size of initial string (Needed for `set_string' precondition).

feature {NONE} -- Implementation

	cwel_string_length (ptr: POINTER): INTEGER is
		external
			"C signature (char *): EIF_INTEGER use %"eif_str.h%""
		alias
			"strlen"
		end

	cwel_set_size_in_string (ptr: POINTER; n: INTEGER) is
		external
			"C [macro %"wel_string.h%"]"
		end

end -- class WEL_STRING


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

