note
	description: "[
			Hash sets with arbitrary equivalence relation and hash function.
			Implementation uses chaining.
			Search, extension and removal are amortized constant time.
		]"
	author: "Nadia Polikarpova"
	updated_by: "Alexander Kogtenkov"
	model: set, equivalence, hash

class
	V_GENERAL_HASH_SET [G]

inherit
	V_SET [G]
		redefine
			copy
		end

	V_DEFAULT [G]
		undefine
			is_equal,
			out
		redefine
			copy
		end

create
	make

feature {NONE} -- Initialization

	make (eq: PREDICATE [G, G]; h: FUNCTION [G, INTEGER])
			-- Create an empty set with equivalence relation `eq' and hash function `h'.
		require
			--- eq_is_total: eq.precondition |=| True
			--- eq_is_equivalence: is_equivalence (eq)
			--- h_is_total: h.precondition |=| True
			--- h_non_negative: forall x: G :: h (x) >= 0
			--- h_eq_consistent: forall x, y: G :: eq (x, y) implies h (x) = h(y)
		do
			equivalence := eq
			hash := h
			buckets := empty_buckets (default_capacity)
		ensure
			set_effect: set.is_empty
			--- equivalence_effect: equivalence |=| eq
			--- hash_effect: hash |=| h
		end

feature -- Initialization

	copy (other: like Current)
			-- Copy equivalence relation, hash function, capacity, optimal load and values values from `other'.
		note
			modify: set, equivalence, hash
		local
			i: INTEGER
		do
			if other /= Current then
				equivalence := other.equivalence
				hash := other.hash
				count := other.count
				create buckets.make (1, other.capacity)
				from
					i := 1
				until
					i > other.buckets.count
				loop
					buckets [i] := other.buckets [i].twin
					i := i + 1
				end
			end
		ensure then
			set_effect: set |=| other.set
			--- equivalence_effect: equivalence |=| other.equivalence
			--- hash_effect: hash |=| other.hash
		end

feature -- Measurement

	count: INTEGER
			-- Number of elements.

feature -- Search

	has (v: G): BOOLEAN
			-- Is `v' contained?
			-- (Uses `equivalence'.)
		do
			Result := buckets [index (v)].cell_satisfying (agent equivalent (v, ?)) /= Void
		end

	item (v: G): G
			-- Element of `set' equivalent to `v' according to `relation'.
		do
			if attached buckets [index (v)].cell_satisfying (agent equivalent (v, ?)) as c then
				Result := c.item
			else
				Result := default_value
			end
		end

	equivalence: PREDICATE [G, G]
			-- Equivalence relation on values.

	hash: FUNCTION [G, INTEGER]
			-- Hash function.

feature -- Iteration

	new_cursor: V_HASH_SET_ITERATOR [G]
			-- New iterator pointing to a position in the set, from which it can traverse all elements by going `forth'.
		do
			create Result.make (Current)
			Result.start
		end

	at (v: G): V_HASH_SET_ITERATOR [G]
			-- New iterator over `Current' pointing at element `v' if it exists and `off' otherwise.
		do
			create Result.make (Current)
			Result.search (v)
		end

feature -- Extension

	extend (v: G)
			-- Add `v' to the set.
		local
			i: INTEGER
		do
			i := index (v)
			if not buckets [i].exists (agent equivalent (v, ?)) then
				buckets [i].extend_back (v)
				count := count + 1
				auto_resize
			end
		end

feature -- Removal

	wipe_out
			-- Remove all elements.
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > buckets.count
			loop
				buckets [i].wipe_out
				i := i + 1
			end
			count := 0
			auto_resize
		end

feature {NONE} -- Performance parameters

	default_capacity: INTEGER = 8
			-- Default size of `buckets'.

	optimal_load: INTEGER = 100
			-- Approximate percentage of elements per bucket that bucket array has after automatic resizing.

	growth_rate: INTEGER = 2
			-- Rate by which bucket array grows and shrinks.

feature {V_CONTAINER, V_ITERATOR} -- Implementation

	buckets: V_ARRAY [V_LINKED_LIST [G]]
			-- Element storage.

	capacity: INTEGER
			-- Bucket array size.
		do
			Result := buckets.count
		end

	index (v: G): INTEGER
			-- Index of `v' into in a `buckets'.
		do
			Result := bucket_index (v, capacity)
		ensure
			result_in_bounds: 1 <= Result and Result <= buckets.count
		end

	remove_at (li: V_LINKED_LIST_ITERATOR [G])
			-- Remove element to which `li' points.
		require
			not_off: not li.off
		do
			li.remove
			count := count - 1
			auto_resize
		end

feature {NONE} -- Implementation

	bucket_index (v: G; n: INTEGER): INTEGER
			-- Index of `v' into in a bucket array of size `n'.
		require
			n_positive: n > 0
		do
			Result := hash.item ([v]) \\ n + 1
		ensure
			result_in_bounds: 1 <= Result and Result <= n
		end

	empty_buckets (n: INTEGER): V_ARRAY [V_LINKED_LIST [G]]
			-- Array of `n' empty buckets.
		require
			n_non_negative: n >= 0
		local
			i: INTEGER
		do
			create Result.make (1, n)
			from
				i := 1
			until
				i > n
			loop
				Result [i] := create {V_LINKED_LIST [G]}
				i := i + 1
			end
		end

	auto_resize
			-- Resize `buckets' to an optimal size for current `count'.
		do
			if count * optimal_load // 100 > growth_rate * capacity then
				resize (capacity * growth_rate)
			elseif buckets.count > default_capacity and count * optimal_load // 100 < capacity // growth_rate then
				resize (capacity // growth_rate)
			end
		end

	resize (c: INTEGER)
			-- Resize `buckets' to `c'.
		require
			c_positive: c > 0
		local
			b: V_ARRAY [V_LINKED_LIST [G]]
			iterator: V_HASH_SET_ITERATOR [G]
		do
			b := empty_buckets (c)
			from
				iterator := new_cursor
			until
				iterator.after
			loop
				b [bucket_index (iterator.item, c)].extend_back (iterator.item)
				iterator.forth
			end
			buckets := b
		ensure
			capacity_effect: capacity = c
		end

invariant
	--- hash_non_negative: forall x: G :: hash (x) >= 0
	count_definition: count = set.count
end
