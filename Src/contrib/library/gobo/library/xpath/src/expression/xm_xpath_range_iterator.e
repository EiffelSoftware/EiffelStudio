note

	description:

		"Objects that select a monotonically increasing integer sequence."

	library: "Gobo Eiffel XPath Library"
	copyright: "Copyright (c) 2004, Colin Adams and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class XM_XPATH_RANGE_ITERATOR

inherit

	XM_XPATH_SEQUENCE_ITERATOR [XM_XPATH_ITEM]
		redefine
			is_last_position_finder, last_position, is_realizable_iterator, realize
		end

create

	make

feature {NONE} -- Initialization

	make (a_min, a_max: INTEGER)
			-- Establish invariant.
		require
			valid_maximum: a_max >= minimum
		do
			minimum := a_min
			maximum := a_max
		ensure
			minimum_set: minimum = a_min
			maximum_set: maximum = a_max
		end

feature -- Access

	item: XM_XPATH_ITEM
			-- Value or node at the current position
		do
			create {XM_XPATH_MACHINE_INTEGER_VALUE} Result.make (index + minimum - 1)
		end

	last_position: INTEGER
			-- Last position (= number of items in sequence)
		do
			Result := maximum - minimum + 1
		end

feature -- Status report

	is_realizable_iterator: BOOLEAN
			-- Is `Current' a realizable iterator?
		do
			Result := True
		end

	is_last_position_finder: BOOLEAN
			-- Can `Current' find the last position?
		do
			Result := True
		end

	after: BOOLEAN
			-- Are there any more items in the sequence?
		do
			Result := not before and then index > maximum - minimum + 1
		end

feature -- Cursor movement

	forth
			-- Move to next position
		do
			index := index + 1
		end

feature -- Evaluation

	realize
			-- Realize the sequence as a value.
		do
			create {XM_XPATH_INTEGER_RANGE} last_realized_value .make (minimum, maximum)
		end

feature -- Duplication

	another: like Current
			-- Another iterator that iterates over the same items as the original
		do
			create Result.make (minimum, maximum)
		end

feature {NONE} -- Implementation

	minimum, maximum: INTEGER

invariant

	valid_maximum: maximum >= minimum

end
