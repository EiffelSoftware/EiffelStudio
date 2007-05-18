indexing
	description: "Fixed integer array for WEL_STRUCTURE. Used internally by WEL. %
				 % useful to protect integer arrays within an external call"
	legal: "See notice at end of class."
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

create
	make 

feature {NONE} -- Initialization

	make (an_array: ARRAY [INTEGER]) is
			-- Create a fixed integer array
			-- from an existing standard integer array.
		require
			an_array_not_void: an_array /= Void
		local
			i, j, nb: INTEGER
			l_val: INTEGER
		do
			count := an_array.count
			structure_make
			from
				i := an_array.lower
				nb := an_array.upper
			until
				i > nb
			loop
				l_val := an_array.item (i)
				(item + j * Integer_size).memory_copy ($l_val, Integer_size)
				i := i + 1
				j := j + 1
			end
		ensure
			set: to_array (an_array.lower).is_equal (an_array)
		end

feature -- Conversion

	to_array (a_lower: INTEGER): ARRAY [INTEGER] is
			-- Eiffel array
		local
			i, j, nb: INTEGER
			l_val: INTEGER
		do
			from
				i := a_lower
				nb := a_lower + count - 1
				create Result.make (a_lower, nb)
			until
				i > nb
			loop
				($l_val).memory_copy (item + j * Integer_size, Integer_size)
				Result.put (l_val, i)
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
			Result := (Integer_size * count).max (1)
		end
		
feature {NONE} -- Constants

	Integer_size: INTEGER is 4
			-- Size of integers.

invariant
	positive_count: count > 0

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
