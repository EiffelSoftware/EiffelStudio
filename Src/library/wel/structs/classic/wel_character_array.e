note
	description: "Fixed character array for WEL_STRUCTURE. Used internally by WEL. %
				 % useful to protect character arrays within an external call"
	legal: "See notice at end of class."
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

	make (an_array: ARRAY [CHARACTER])
			-- Create a fixed character array
			-- from an existing standard character array.
		require
			an_array_not_void: an_array /= Void
		local
			l_area: SPECIAL [CHARACTER]
		do
			count := an_array.count
			structure_make
			l_area := an_array.area
			item.memory_copy ($l_area, count)
		ensure
			set: to_array (an_array.lower) ~ an_array
		end

feature -- Conversion

	to_array (a_lower: INTEGER): ARRAY [CHARACTER]
			-- Eiffel array
		local
			nb: INTEGER
			l_area: SPECIAL [CHARACTER]
		do
			nb := a_lower + count - 1
			create Result.make_filled ('%U', a_lower, nb)
			l_area := Result.area;
			($l_area).memory_copy (item, nb)
		ensure
			array_not_void: Result /= Void
			lower_set: Result.lower = a_lower
			count_set: Result.count = count
		end

feature -- Measurement

	count: INTEGER
			-- Number of items in the array

	structure_size: INTEGER
			-- Size of the array (in bytes)
		do
				-- We need to return at least 1 to preserve the postcondition.
			Result := count.max (1)
		end

invariant
	positive_count: count >= 0

note
	copyright:	"Copyright (c) 1984-2015, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
