note
	description: "[
		Special objects: homogeneous sequences of values,
		used to represent arrays and strings
		]"
	library: "Free implementation of ELKS library"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

frozen class
	SPECIAL [T]

create
	make_empty, make_filled

feature {NONE} -- Initialization

	make_empty (n: INTEGER)
			-- Create a special object for `n' entries.
		require
			non_negative_argument: n >= 0
		external
			"built_in"
		ensure
			capacity_set: capacity = n
			count_set: count = 0
		end

	make_filled (v: T; n: INTEGER)
			-- Create a special object for `n' entries initialized with `v'.
		require
			non_negative_argument: n >= 0
		do
			make_empty (n)
			fill_with (v, 0, n - 1)
		ensure
			capacity_set: capacity = n
			count_set: count = n
			filled: filled_with (v, 0, n - 1)
		end

feature -- Access

	item alias "[]" (i: INTEGER): T assign put
			-- Item at `i'-th position
			-- (indices begin at 0)
		external
			"built_in"
		end

	to_array: ARRAY [T]
			-- Build an array representation of Current from `1' to `count'.
		do
			create Result.make_from_special (Current)
		ensure
			to_array_attached: Result /= Void
			to_array_lower_set: Result.lower = 1
			to_array_upper_set: Result.upper = count
		end

feature -- Element change

	fill_with (v: T; start_index, end_index: INTEGER)
			-- Set items between `start_index' and `end_index' with `v'.
		require
			start_index_non_negative: start_index >= 0
			start_index_in_bound: start_index <= count
			start_index_not_too_big: start_index <= end_index + 1
			end_index_valid: end_index < capacity
		local
			i, nb: INTEGER
			l_count: like count
		do
			from
				i := start_index
				l_count := count.min (end_index + 1)
				nb := l_count
			until
				i = nb
			loop
				put (v, i)
				i := i + 1
			end
			from
				i := l_count
				nb := end_index + 1
			until
				i = nb
			loop
				extend (v)
				i := i + 1
			end
		ensure
			same_capacity: capacity = old capacity
			count_definition: count = (old count).max (end_index + 1)
			filled: filled_with (v, start_index, end_index)
		end

	put (v: T; i: INTEGER)
			-- Replace `i'-th item by `v'.
			-- (Indices begin at 0.)
		require
			index_large_enough: i >= 0
			index_small_enough: i < count
		external
			"built_in"
		ensure
			inserted: item (i) = v
			same_count: count = old count
			same_capacity: capacity = old capacity
		end

	force (v: T; i: INTEGER)
			-- If `i' is equal to `count' increase `count' by one and insert `v' at index `count',
			-- otherwise replace `i'-th item by `v'.
			-- (Indices begin at 0.)
		require
			index_large_enough: i >= 0
			index_small_enough: i <= count
			not_full: i = count implies count < capacity
		do
			if i < count then
				put (v, i)
			else
				extend (v)
			end
		ensure
			count_updated: count = (i + 1).max (old count)
			same_capacity: capacity = old capacity
			inserted: item (i) = v
		end

	extend (v: T)
			-- Add `v' at index `count'.
		require
			count_small_enough: count < capacity
		external
			"built_in"
		ensure
			count_increased: count = old count + 1
			same_capacity: capacity = old capacity
			inserted: item (count - 1) = v
		end

feature -- Status report

	filled_with (v: T; start_index, end_index: INTEGER): BOOLEAN
			-- Are all items between index `start_index' and `end_index'
			-- set to `v'?
			-- (Use reference equality for comparison.)			
		require
			start_index_non_negative: start_index >= 0
			start_index_not_too_big: start_index <= end_index + 1
			end_index_valid: end_index < count
		local
			i: INTEGER
		do
			from
				Result := True
				i := start_index
			until
				i > end_index or else not Result
			loop
				Result := item (i) = v
				i := i + 1
			end
		end

feature -- Measurement

	lower: INTEGER = 0
			-- Minimum index of Current

	upper: INTEGER
			-- Maximum index of Current
		do
			Result := count - 1
		ensure
			definition: lower <= Result + 1
		end

	count: INTEGER
			-- Count of special area
		external
			"built_in"
		end

	capacity: INTEGER
			-- Capacity of special area
		external
			"built_in"
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
