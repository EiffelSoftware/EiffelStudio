note
	description: "Iterators over tables implemented as set of key-value pairs."
	author: "Nadia Polikarpova"
	model: target, map, key_sequence, index

class
	V_SET_TABLE_ITERATOR [K, V]

inherit
	V_TABLE_ITERATOR [K, V]
		redefine
			copy
		end

create {V_SET_TABLE}
	make_at_start,
	make_at_key

feature {NONE} -- Initialization

	make_at_start (t: V_SET_TABLE [K, V])
			-- Create an iterator at start of `t'.
		do
			target := t
			set_iterator := target.set.new_cursor
		ensure
			target_effect: target = t
			index_effect: index = 1
		end

	make_at_key (t: V_SET_TABLE [K, V]; k: K)
			-- Create an iterator over `t' pointing to the position with key `k'.
		do
			target := t
			set_iterator := target.set.at ([k, ({V}).default])
		ensure
			target_effect: target = t
			index_effect_found: target.has_key (k) implies target.equivalent (key_sequence [index], k)
			index_effect_not_found: not target.has_key (k) implies index = key_sequence.count + 1
		end

feature -- Initialization

	copy (other: like Current)
			-- Initialize with the same `target' and position as in `other'.
		note
			modify: target, map, key_sequence, index
		do
			if other /= Current then
				target := other.target
				set_iterator := other.set_iterator.twin
			end
		ensure then
			target_effect: target = other.target
			key_sequence_effect: key_sequence |=| other.key_sequence
			index_effect: index = other.index
		end

feature -- Access

	target: V_SET_TABLE [K, V]
			-- Container to iterate over.

	key: K
			-- Key at current position.
		do
			Result := set_iterator.item.key
		end

	item: V
			-- Item at current position.
		do
			Result := set_iterator.item.value
		end

feature -- Measurement	

	index: INTEGER
			-- Current position.
		do
			Result := set_iterator.index
		end

feature -- Status report

	before: BOOLEAN
			-- Is current position before any position in `target'?
		do
			Result := set_iterator.before
		end

	after: BOOLEAN
			-- Is current position after any position in `target'?
		do
			Result := set_iterator.after
		end

	is_first: BOOLEAN
			-- Is cursor at the first position?
		do
			Result := set_iterator.is_first
		end

	is_last: BOOLEAN
			-- Is cursor at the last position?
		do
			Result := set_iterator.is_last
		end

feature -- Cursor movement

	start
			-- Go to the first position.
		do
			set_iterator.start
		end

	finish
			-- Go to the last position.
		do
			set_iterator.finish
		end

	forth
			-- Move one position forward.
		do
			set_iterator.forth
		end

	back
			-- Go one position backwards.
		do
			set_iterator.back
		end

	go_before
			-- Go before any position of `target'.
		do
			set_iterator.go_before
		end

	go_after
			-- Go after any position of `target'.
		do
			set_iterator.go_after
		end

	search_key (k: K)
			-- Move to a position where key is equivalent to `k'.
			-- If `k' does not appear, go after.
			-- (Use `target.key_equivalence')
		do
			set_iterator.search ([k, ({V}).default])
		end

feature -- Replacement

	put (v: V)
			-- Replace item at current position with `v'.
		note
			modify: map
		do
			set_iterator.item.value := v
		ensure then
			map_effect: map |=| old map.updated (key_sequence [index], v)
		end

feature -- Removal

	remove
			-- Remove key-value pair at current position. Move to the next position.
		do
			set_iterator.remove
		end

feature {V_CONTAINER, V_ITERATOR} -- Implementation

	set_iterator: V_SET_ITERATOR [TUPLE [key: K; value: V]]
			-- Iterator over the underlying set.

feature -- Specification

	key_sequence: MML_SEQUENCE [K]
			-- Sequence of keys.
		note
			status: specification
		local
			pair_sequence: MML_SEQUENCE [TUPLE [key: K; value: V]]
			i: INTEGER
		do
			create Result
			pair_sequence := set_iterator.sequence
			from
				i := 1
			until
				i > pair_sequence.count
			loop
				Result := Result & pair_sequence.item (i).key
				i := i + 1
			end
		end

	value_sequence: MML_SEQUENCE [V]
			-- Sequence of values.
		note
			status: specification
		local
			pair_sequence: MML_SEQUENCE [TUPLE [key: K; value: V]]
			i: INTEGER
		do
			create Result
			pair_sequence := set_iterator.sequence
			from
				i := 1
			until
				i > pair_sequence.count
			loop
				Result := Result & pair_sequence.item (i).value
				i := i + 1
			end
		end

invariant
	valid_set: target.set = set_iterator.target
end
