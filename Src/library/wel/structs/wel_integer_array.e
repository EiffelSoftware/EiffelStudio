indexing
	description: "Fixed integer array for WEL_STRUCTURE. Used internally by WEL. %
				 % useful to protect integer arrays within an external call"
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_INTEGER_ARRAY

inherit
	
	WEL_STRUCTURE
		rename
			make as structure_make
		end

creation
	make 

feature {NONE} -- Initialization

	make (an_array: ARRAY [INTEGER]) is
			-- Create a fixed integer array
			-- from an existing standard integer array.
		require
			an_array_not_void: an_array /= Void
		local
			a: ANY
		do
			count := an_array.count
			structure_make
			a := an_array.to_c
			c_memcpy (item, $a, structure_size)
		ensure
--			set: to_array (an_array.lower).is_equal (an_array)
		end

feature -- Conversion

	to_array (a_lower: INTEGER): ARRAY [INTEGER] is
			-- Eiffel array
		local
			a: ANY
		do
			create Result.make (a_lower, a_lower + count - 1)
			a := Result.to_c
			c_memcpy ($a, item, structure_size)
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
			Result := 4*count
		end

invariant
	positive_count: count > 0

end -- class WEL_INTEGER_ARRAY

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

