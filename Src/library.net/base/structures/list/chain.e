indexing
	description: "[
				Possibly circular sequences of items,
				without commitment to a particular representation
			  ]"
	class_type: Interface
	external_name: "ISE.Base.Chain"

deferred class 
	CHAIN [G] 

inherit
	CURSOR_STRUCTURE [G]

	SEQUENCE [G]
		export
			{NONE} remove
		end

feature -- Access

	first: G is
		indexing
			description: "Item at first position"
		require
			not_empty: not is_empty
		deferred
		end

	last: G is
		indexing
			description: "Item at last position"
		require
			not_empty: not is_empty
		deferred
		end

	i_th (i: INTEGER): G is
		indexing
			description: "Entry at index `i'."
		require
			valid_index: valid_index (i)
		deferred
		end

	infix "@" (i: INTEGER): G is
		indexing
			description: "Entry at index `i'."
		require
			valid_index: valid_index (i)
		deferred
		end
		
feature -- Cursor movement

	move (i: INTEGER) is
		indexing
			description: "[
						Move cursor `i' positions. The cursor
						may end up `off' if the absolute value of `i'
						is too big.
					  ]"
		deferred
		ensure
			too_far_right: (old index + i > count) implies exhausted
			too_far_left: (old index + i < 1) implies exhausted
			expected_index: (not exhausted) implies (index = old index + i)
		end

	go_i_th (i: INTEGER) is
		indexing
			description: "Move cursor to `i'-th position."
		require
			valid_cursor_index: valid_cursor_index (i)
		deferred
		ensure
			position_expected: index = i
		end

 feature -- Status report

	isfirst: BOOLEAN is
		indexing
			description: "Is cursor at first position?"
		deferred
		ensure
			valid_position: Result implies not is_empty
		end

	islast: BOOLEAN is
		indexing
			description: "Is cursor at last position?"
		deferred
		ensure
			valid_position: Result implies not is_empty
		end

	valid_cursor_index (i: INTEGER): BOOLEAN is
		indexing
			description: "Is `i' correctly bounded for cursor movement?"
		deferred
		ensure
			valid_cursor_index_definition: Result = ((i >= 0) and (i <= count + 1))
		end

	valid_index (i: INTEGER): BOOLEAN is
		indexing
			description: "Is `i' a valid index?"
		deferred
		ensure
			valid_index_definition: Result = ((i >= 1) and (i <= count))
		end

feature -- Element change

	put_i_th (v: G; i: INTEGER) is
		indexing
			description: "Associate value `v' with index `i'."
		require
			valid_index: valid_index (i)
		deferred
		end

feature -- Measurement

	index_set: INTEGER_INTERVAL is
		indexing
			description: "Range of acceptable indexes"
		deferred
		ensure
			not_void: Result /= Void
		end

feature -- Transformation

	swap (i: INTEGER) is
		indexing
			description: "Exchange item at `i'-th position with item at cursor position."
		require
			not_off: not off
			valid_index: valid_index (i)
		deferred
		ensure
	 		swapped_to_item: item = old i_th (i)
	 		swapped_from_item: i_th (i) = old item
		end

feature -- Duplication

	duplicate (n: INTEGER): CHAIN [G] is
		indexing
			description: "[
						Copy of sub-chain beginning at current position
						and having min (`n', `from_here') items,
						where `from_here' is the number of items
						at or to the right of current position.
					  ]"
		require
			not_off_unless_after: off implies after
			valid_subchain: n >= 0
		deferred
		end

--invariant

--	non_negative_index: index >= 0
--	index_small_enough: index <= count + 1
--	off_definition: off = ((index = 0) or (index = count + 1))
--	isfirst_definition: isfirst = ((not is_empty) and (index = 1))
--	islast_definition: islast = ((not is_empty) and (index = count))
--	item_corresponds_to_index: (not off) implies (item = i_th (index))
--	index_set_has_same_count: index_set.count = count

end -- class CHAIN
