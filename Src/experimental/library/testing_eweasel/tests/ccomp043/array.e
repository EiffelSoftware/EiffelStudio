indexing

	description: "[
		Sequences of values, all of the same type or of a conforming one,
		accessible through integer indices in a contiguous interval.
		]"

	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class ARRAY [G] inherit

	TO_SPECIAL [G]

create
	make,
	make_from_special

feature -- Initialization

	make (min_index, max_index: INTEGER) is
			-- Allocate array; set index interval to
			-- `min_index' .. `max_index'; set all values to default.
			-- (Make array empty if `min_index' = `max_index' + 1).
		do
		end

  make_from_special (a: SPECIAL [G]) is
            -- Initialize from the items of `a'.
        do
        end

feature -- Access

	item, infix "@" (i: INTEGER): G is
			-- Entry at index `i', if in index interval
		do
		end

	entry (i: INTEGER): G is
			-- Entry at index `i', if in index interval
		do
		end

	has (v: G): BOOLEAN is
			-- Does `v' appear in array?
 			-- (Reference or object equality,
			-- based on `object_comparison'.)
		do
		end

feature -- Measurement

end -- class ARRAY
