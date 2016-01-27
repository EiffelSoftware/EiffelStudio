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

inherit
	ITERABLE [G]

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

feature

	new_cursor: ITERATION_CURSOR [G]
			-- Fresh cursor associated with current structure
		do
			check False then end
		end

	make_from_array (a: ARRAY [G])
			-- Initialize from the items of `a'.
			-- (Useful in proper descendants of class `ARRAY',
			-- to initialize an array-like object from a manifest array.)
		do
		end

feature -- Access

	item alias "[]", at alias "@" (i: INTEGER): G assign put
			-- Entry at index `i', if in index interval
		do
			Result := area.item (i - lower)
		end

feature -- Measurement

	lower: INTEGER
			-- Minimum index

	upper: INTEGER
			-- Maximum index

	count, capacity: INTEGER
			-- Number of available indices
		do
			Result := upper - lower + 1
		ensure then
			consistent_with_bounds: Result = upper - lower + 1
		end

feature -- Element change

	put (v: like item; i: INTEGER)
			-- Replace `i'-th entry, if in index interval, by `v'.
		do
			area.put (v, i - lower)
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
	copyright: "Copyright (c) 1984-2016, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
