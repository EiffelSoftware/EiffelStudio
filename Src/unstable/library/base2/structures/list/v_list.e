note
	description: "[
		Indexable containers, where elements can be inserted and removed at any position. 
		Indexing starts from 1.
		]"
	author: "Nadia Polikarpova"
	updated_by: "Alexander Kogtenkov"
	model: sequence

deferred class
	V_LIST [G]

inherit
	V_MUTABLE_SEQUENCE [G]
		undefine
			count
		redefine
			at,
			is_equal
		end

feature -- Measurement

	lower: INTEGER = 1
			-- Lower bound of index interval.

	upper: INTEGER
			-- Upper bound of index interval.
		do
			Result := count
		end

feature -- Iteration

	at (i: INTEGER): V_LIST_ITERATOR [G]
			-- New iterator pointing at position `i'.
		deferred
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Is list made of the same values in the same order as `other'?
			-- (Use reference comparison.)
		local
			i, j: V_ITERATOR [G]
		do
			if other = Current then
				Result := True
			elseif count = other.count then
				from
					Result := True
					i := new_cursor
					j := other.new_cursor
				until
					i.after or not Result
				loop
					Result := i.item = j.item
					i.forth
					j.forth
				end
			end
		ensure then
			definition: Result = (sequence |=| other.sequence)
		end

feature -- Extension

	extend_front (v: G)
			-- Insert `v' at the front.
		note
			modify: sequence
		deferred
		ensure
			sequence_effect: sequence |=| old sequence.prepended (v)
		end

	extend_back (v: G)
			-- Insert `v' at the back.
		note
			modify: sequence
		deferred
		ensure
			sequence_effect: sequence |=| old (sequence & v)
		end

	extend_at (v: G; i: INTEGER)
			-- Insert `v' at position `i'.
		note
			modify: sequence
		require
			valid_index: has_index (i) or i = count + 1
		deferred
		ensure
			sequence_effect: sequence |=| old (sequence.front (i - 1) & v + sequence.tail (i))
		end

	append (input: V_ITERATOR [G])
			-- Append sequence of values produced by `input'.
		note
			modify: sequence, input__index
		require
			different_target: input.target /= Current
			not_before: not input.before
		do
			from
			until
				input.after
			loop
				extend_back (input.item)
				input.forth
			end
		ensure
			sequence_effect: sequence |=| old (sequence + input.sequence.tail (input.index))
			input_index_effect: input.index = input.sequence.count + 1
		end

	prepend (input: V_ITERATOR [G])
			-- Prepend sequence of values produced by `input'.
		note
			modify: sequence, input__index
		require
			different_target: input.target /= Current
			not_before: not input.before
		deferred
		ensure
			sequence_effect: sequence |=| old (input.sequence.tail (input.index) + sequence)
			input_index_effect: input.index = input.sequence.count + 1
		end

	insert_at (input: V_ITERATOR [G]; i: INTEGER)
			-- Insert starting at position `i' sequence of values produced by `input'.
		note
			modify: sequence, input__index
		require
			valid_index: has_index (i) or i = count + 1
			different_target: input.target /= Current
			not_before: not input.before
		deferred
		ensure
			sequence_effect: sequence |=| old (sequence.front (i - 1) + input.sequence.tail (input.index) + sequence.tail (i))
			input_index_effect: input.index = input.sequence.count + 1
		end

feature -- Removal

	remove_front
			-- Remove first element.
		note
			modify: sequence
		require
			not_empty: not is_empty
		deferred
		ensure
			sequence_effect: sequence |=| old sequence.but_first
		end

	remove_back
			-- Remove last element.
		note
			modify: sequence
		require
			not_empty: not is_empty
		deferred
		ensure
			sequence_effect: sequence |=| old sequence.but_last
		end

	remove_at (i: INTEGER)
			-- Remove element at position `i'.
		note
			modify: sequence
		require
			has_index: has_index (i)
		deferred
		ensure
			sequence_effect: sequence |=| old sequence.removed_at (i)
		end

	remove (v: G)
			-- Remove the first occurrence of `v'.
		note
			modify: sequence
		require
			has: has (v)
		local
			i: V_LIST_ITERATOR [G]
		do
			i := new_cursor
			i.search_forth (v)
			i.remove
		ensure
			sequence_effect: sequence |=| old sequence.removed_at (sequence.inverse.image_of (v).extremum (agent less_equal))
		end

	remove_all (v: G)
			-- Remove all occurrences of `v'.
		note
			modify: sequence
		local
			i: V_LIST_ITERATOR [G]
		do
			from
				i := new_cursor
				i.search_forth (v)
			until
				i.after
			loop
				i.remove
				i.search_forth (v)
			end
		ensure
			sequence_effect: sequence |=| old sequence.removed (sequence.inverse.image_of (v))
		end

	remove_satisfying (pred: PREDICATE [G])
			-- Remove the first element satisfying `pred'.
		note
			modify: sequence
		require
			exists: exists (pred)
		local
			i: V_LIST_ITERATOR [G]
		do
			i := new_cursor
			i.satisfy_forth (pred)
			i.remove
		ensure
			sequence_effect: sequence |=| old sequence.removed_at (sequence.inverse.image (sequence.inverse.domain | pred).extremum (agent less_equal))
		end

	remove_all_satisfying (pred: PREDICATE [G])
			-- Remove all elements satisfying `pred'.
		note
			modify: sequence
		require
			pred_has_one_arg: pred.open_count = 1
			precondition_satisfied: map.range.for_all (agent (x: G; p: PREDICATE [G]): BOOLEAN
				do
					Result := p.precondition ([x])
				end (?, pred))
		local
			i: V_LIST_ITERATOR [G]
		do
			from
				i := new_cursor
				i.satisfy_forth (pred)
			until
				i.after
			loop
				i.remove
				i.satisfy_forth (pred)
			end
		ensure
			sequence_effect: sequence |=| old sequence.removed (sequence.inverse.image (sequence.inverse.domain | pred))
		end

	wipe_out
			-- Remove all elements.
		note
			modify: sequence
		deferred
		ensure then
			sequence_effect: sequence.is_empty
		end

feature -- Specification

	sequence: MML_SEQUENCE [G]
			-- Sequence of list's elements.
		note
			status: specification
		deferred
		end

invariant
	map_domain_definition: map.domain |=| sequence.domain
	map_definition: map.for_all (agent (i: INTEGER; x: G): BOOLEAN
		do
			Result := x = sequence [i]
		end)

end
