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
--			non_negative_argument: n >= 0
		do
			create internal_native_array.make (n)
		ensure
			capacity_set: capacity = n
			count_set: count = 0
		end

	make_filled (v: T; n: INTEGER)
			-- Create a special object for `n' entries initialized with `v'.
		require
--			non_negative_argument: n >= 0
		do
			make_empty (n)
--			fill_with (v, 0, n - 1)
		ensure
--			capacity_set: capacity = n
--			count_set: count = n
--			filled: filled_with (v, 0, n - 1)
		end

feature -- Access

	native_array: NATIVE_ARRAY [T]
			-- Only for compatibility with .NET
		do
			Result := internal_native_array
		end

feature -- Measurement

	to_array: ARRAY [T]
			-- Build an array representation of Current from `1' to `count'.
		do
			create Result.make_from_special (Current)
		ensure
			to_array_attached: Result /= Void
--			to_array_lower_set: Result.lower = 1
--			to_array_upper_set: Result.upper = count
		end

	item alias "[]" (i: INTEGER): T assign put
			-- Item at `i'-th position
			-- (indices begin at 0)
		external
			"built_in"
		end

	put (v: T; i: INTEGER)
			-- Replace `i'-th item by `v'.
			-- (Indices begin at 0.)
--		require
--			index_large_enough: i >= 0
--			index_small_enough: i < count
		external
			"built_in"
		ensure
			inserted: item (i) = v
			same_count: count = old count
			same_capacity: capacity = old capacity
		end

	extend (v: T)
			-- Add `v' at index `count'.
		require
--			count_small_enough: count < capacity
		external
			"built_in"
		ensure
			count_increased: count = old count + 1
			same_capacity: capacity = old capacity
			inserted: item (count - 1) = v
		end

	lower: INTEGER = 0
			-- Minimum index of Current

	upper: INTEGER
			-- Maximum index of Current
		do
--			Result := count - 1
		ensure
--			definition: lower <= Result + 1
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

feature {SPECIAL} -- Implementation: Access

	internal_native_array: like native_array
			-- Access to memory location.

invariant

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
