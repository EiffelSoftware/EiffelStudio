note
	description: "[
		Indexable containers, where elements can be inserted and removed at any position. 
		Indexing starts from 1.
		]"
	author: "Nadia Polikarpova"
	revised_by: "Alexander Kogtenkov"
	model: sequence
	manual_inv: true
	false_guards: true

deferred class
	V_LIST [G]

inherit
	V_MUTABLE_SEQUENCE [G]
		redefine
			item,
			at,
			is_model_equal
		end

feature -- Access

	item alias "[]" (i: INTEGER): G
			-- Value at index `i'.
		deferred
		ensure then
			definition_sequence: Result = sequence [i]
		end

feature -- Measurement

	lower: INTEGER
			-- Lower bound of index interval.
		note
			status: nonvariant
		do
			check inv_only ("lower_definition") end
			Result := 1
		end

	count: INTEGER
			-- Number of elements.
		note
			status: nonvariant
		do
			check inv_only ("count_definition", "bag_definition") end
			Result := count_
		end

feature -- Iteration

	at (i: INTEGER): V_LIST_ITERATOR [G]
			-- New iterator pointing at position `i'.
		note
			status: impure
			explicit: contracts
		deferred
		ensure then
			index_definition_in_bounds: 0 <= i and i <= sequence.count + 1 implies Result.index_ = i
		end

feature -- Extension

	extend_front (v: G)
			-- Insert `v' at the front.
		require
			observers_open: across observers as o all o.is_open end
		deferred
		ensure
			sequence_effect: sequence ~ old sequence.prepended (v)
			modify_model ("sequence", Current)
		end

	extend_back (v: G)
			-- Insert `v' at the back.
		require
			observers_open: across observers as o all o.is_open end
		deferred
		ensure
			sequence_effect: sequence ~ old (sequence & v)
			modify_model ("sequence", Current)
		end

	extend_at (v: G; i: INTEGER)
			-- Insert `v' at position `i'.
		require
			valid_index: 1 <= i and i <= sequence.count + 1
			observers_open: across observers as o all o.is_open end
		deferred
		ensure
			sequence_effect: sequence ~ old sequence.extended_at (i, v)
			modify_model ("sequence", Current)
		end

	append (input: V_ITERATOR [G])
			-- Append sequence of values produced by `input'.
		note
			status: nonvariant
		require
			not_current: input /= Current
			different_target: input.target /= Current
			input_target_wrapped: input.target.is_wrapped
			not_before: not input.before
			observers_open: across observers as o all o.is_open end
		do
			from
			invariant
				is_wrapped and input.is_wrapped
				input.inv
				input.index_.old_ <= input.index_
				input.index_ <= input.sequence.count + 1
				sequence ~ sequence.old_ + input.sequence.interval (input.index_.old_, input.index_ - 1)
			until
				input.after
			loop
				extend_back (input.item)
				input.forth
			variant
				input.sequence.count - input.index_
			end
		ensure
			sequence_effect: sequence ~ old (sequence + input.sequence.tail (input.index_))
			input_index_effect: input.index_ = input.sequence.count + 1
			modify_model ("sequence", Current)
			modify_model ("index_", input)
		end

	prepend (input: V_ITERATOR [G])
			-- Prepend sequence of values produced by `input'.
		require
			not_current: input /= Current
			different_target: input.target /= Current
			input_target_wrapped: input.target.is_wrapped
			not_before: not input.before
			observers_open: across observers as o all o.is_open end
		deferred
		ensure
			sequence_effect: sequence ~ old (input.sequence.tail (input.index_) + sequence)
			input_index_effect: input.index_ = input.sequence.count + 1
			observers_preserved: observers ~ old observers
			modify_model (["sequence", "observers"], Current)
			modify_model ("index_", input)
		end

	insert_at (input: V_ITERATOR [G]; i: INTEGER)
			-- Insert starting at position `i' sequence of values produced by `input'.
		require
			valid_index: 1 <= i and i <= sequence.count + 1
			not_current: input /= Current
			different_target: input.target /= Current
			input_target_wrapped: input.target.is_wrapped
			not_before: not input.before
			observers_open: across observers as o all o.is_open end
		deferred
		ensure
			sequence_effect: sequence ~ old (sequence.front (i - 1) + input.sequence.tail (input.index_) + sequence.tail (i))
			input_index_effect: input.index_ = input.sequence.count + 1
			observers_preserved: observers ~ old observers
			modify_model (["sequence", "observers"], Current)
			modify_model ("index_", input)
		end

feature -- Removal

	remove_front
			-- Remove first element.
		require
			not_empty: not is_empty
			observers_open: across observers as o all o.is_open end
		deferred
		ensure
			sequence_effect: sequence ~ old sequence.but_first
			modify_model ("sequence", Current)
		end

	remove_back
			-- Remove last element.
		require
			not_empty: not is_empty
			observers_open: across observers as o all o.is_open end
		deferred
		ensure
			sequence_effect: sequence ~ old sequence.but_last
			modify_model ("sequence", Current)
		end

	remove_at (i: INTEGER)
			-- Remove element at position `i'.
		require
			has_index: 1 <= i and i <= sequence.count
			observers_open: across observers as o all o.is_open end
		deferred
		ensure
			sequence_effect: sequence ~ old sequence.removed_at (i)
			modify_model ("sequence", Current)
		end

	remove (v: G)
			-- Remove the first occurrence of `v'.
		note
			status: nonvariant
		require
			has: sequence.has (v)
			observers_open: across observers as o all o.is_open end
		local
			i: V_LIST_ITERATOR [G]
		do
			i := new_cursor
			i.search_forth (v)
			i.remove
			check i.inv_only ("target_bag_constraint", "sequence_definition") end
			forget_iterator (i)
		ensure
			sequence_effect: across 1 |..| sequence.count.old_ as j some
					sequence.old_ [j] = v and
					not sequence.old_.front (j - 1).has (v) and
					sequence ~ sequence.old_.removed_at (j) end
			observers_restored: observers ~ old observers
			modify_model (["sequence", "observers"], Current)
		end

	remove_all (v: G)
			-- Remove all occurrences of `v'.
		note
			status: nonvariant
		require
			observers_open: across observers as o all o.is_open end
		local
			i: V_LIST_ITERATOR [G]
			n_, j_: INTEGER
		do
			from
				i := new_cursor
				i.search_forth (v)
			invariant
				is_wrapped and i.is_wrapped
				i.inv_only ("sequence_definition", "index_constraint", "target_bag_constraint")
				1 <= i.index_ and i.index_ <= sequence.count + 1
				not i.off implies i.item = v
				not sequence.front (i.index_ - 1).has (v)
				sequence.count + n_ = sequence.old_.count
				sequence.front (i.index_ - 1) = removed_all (sequence.old_.front (i.index_ + n_ - 1), v)
				across i.index_ |..| sequence.count as j all sequence [j] = sequence.old_[j + n_] end
				n_ >= 0
				modify_model ("sequence", Current)
				modify_model (["index_", "sequence"], i)
			until
				i.after
			loop
				use_definition (removed_all (sequence.old_.front (i.index_ + n_), v))
				check sequence.old_.front (i.index_ + n_).but_last = sequence.old_.front (i.index_ + n_ - 1) end
				i.remove
				check i.inv_only ("target_bag_constraint", "sequence_definition") end
				j_ := i.index_

				i.search_forth (v)

				check sequence.old_.front (i.index_ + n_) = sequence.old_.front (j_ + n_) + sequence.old_.interval (j_ + n_ + 1, i.index_ + n_) end
				check sequence.interval (j_, i.index_ - 1) = sequence.old_.interval (j_ + n_ + 1, i.index_ + n_) end
				lemma_removed_all_concat (sequence.old_.front (j_ + n_), sequence.old_.interval (j_ + n_ + 1, i.index_ + n_), v)
				n_ := n_ + 1
			variant
				i.sequence.count - i.index_
			end
			bag.old_.lemma_remove_all (v)
			forget_iterator (i)
		ensure
			sequence_effect: sequence ~ removed_all (old sequence, v)
			observers_restored: observers ~ old observers
			modify_model (["sequence", "observers"], Current)
		end

	wipe_out
			-- Remove all elements.
		require
			observers_open: across observers as o all o.is_open end
		deferred
		ensure
			sequence_effect: sequence.is_empty
			modify_model ("sequence", Current)
		end

feature {V_LIST, V_LIST_ITERATOR} -- Implementation

	count_: INTEGER
			-- Number of elements.		

feature -- Specification

	is_model_equal (other: like Current): BOOLEAN
			-- Is the abstract state of `Current' equal to that of `other'?
		note
			status: ghost, functional, nonvariant
		do
			Result := sequence ~ other.sequence
		end

	removed_all (s: like sequence; x: G): like sequence
			-- Sequence `s' with all occurrences of `x' removed.
		note
			status: ghost, functional, nonvariant, static, opaque
		require
			reads ([])
		do
			Result := if s.is_empty then s else
				if s.last = x then removed_all (s.but_last, x) else removed_all (s.but_last, x) & s.last end end
		ensure
			not Result.has (x)
			not s.has (x) implies Result = s
		end

	lemma_removed_all_concat (s1, s2: like sequence; x: G)
			-- `removed_all' distributes over sequence concatenation.
		note
			status: lemma, static
		do
			use_definition (removed_all (s2, x))
			if not s2.is_empty then
				check (s1 + s2).but_last = s1 + s2.but_last end
				lemma_removed_all_concat (s1, s2.but_last, x)
				use_definition (removed_all (s1 + s2, x))
			else
				check s1 + s2 = s1 end
			end
		ensure
			removed_all (s1 + s2, x) = removed_all (s1, x) + removed_all (s2, x)
		end

invariant
	lower_definition: lower_ = 1
	count_definition: count_ = sequence.count

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
