indexing
	description: "Fixed character array for WEL_STRUCTURE. Used internally by WEL. %
				 % useful to protect character arrays within an external call"
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CHARACTER_ARRAY

inherit
	
	WEL_STRUCTURE
		rename
			make as structure_make
		end

create
	make 

feature {NONE} -- Initialization

	make (an_array: ARRAY [CHARACTER]) is
			-- Create a fixed character array
			-- from an existing standard character array.
		require
			an_array_not_void: an_array /= Void
		local
			i, j, nb: INTEGER
			l_val: INTEGER_8
		do
			count := an_array.count
			structure_make
			from
				i := an_array.lower
				nb := an_array.upper
			until
				i > nb
			loop
				l_val := an_array.item (i).code.to_integer_8;
				(item + j).memory_copy ($l_val, 1)
				i := i + 1
				j := j + 1
			end
		ensure
			set: to_array (an_array.lower).is_equal (an_array)
		end

feature -- Conversion

	to_array (a_lower: INTEGER): ARRAY [CHARACTER] is
			-- Eiffel array
		local
			i, j, nb: INTEGER
			l_val: INTEGER_8
		do
			from
				i := a_lower
				nb := a_lower + count - 1
				create Result.make (a_lower, nb)
			until
				i > nb
			loop
				($l_val).memory_copy (item + j, 1)
				Result.put (l_val.to_character, i)
				i := i + 1
				j := j + 1
			end
		ensure
			array_not_void: Result /= Void
			lower_set: Result.lower = a_lower
			count_set: Result.count = count
		end

feature -- Measurement

	count: INTEGER
			-- Number of items in the array

	structure_size: INTEGER is
			-- Size of the array (in bytes)
		do
				-- We need to return at least 1 to preserve the postcondition.
			Result := count.max (1)
		end

invariant
	positive_count: count >= 0

end -- class WEL_CHARACTER_ARRAY


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

