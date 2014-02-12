note
	description: "[
		Sequences of values, all of the same type or of a conforming one,
		accessible through integer indices in a contiguous interval.
		]"

	library: "Free implementation of ELKS library"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ARRAY [G]

create
	make, make_from_special

feature {NONE} -- Initialization

	make (min_index, max_index: INTEGER)
			-- Allocate array; set index interval to
			-- `min_index' .. `max_index'; set all values to default.
			-- (Make array empty if `min_index' = `max_index' + 1).
		do
			create area.make_empty (max_index)
		end

	make_from_special (a: SPECIAL [G])
			-- Initialize Current from items of `a'.
		require
			special_attached: a /= Void
		do
			set_area (a)
		ensure
		end

feature {NONE} -- Implementation

	area: SPECIAL [G]
			-- Special data zone

	set_area (other: like area)
			-- Make `other' the new `area'
		do
			area := other
		ensure
			area_set: area = other
		end

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
