note
	description: "Iterators over hash sets."
	author: "Nadia Polikarpova"
	revised_by: "Alexander Kogtenkov"
	model: target, sequence, index_
	manual_inv: true
	false_guards: true

class
	V_HASH_SET_ITERATOR [G -> V_HASHABLE]

inherit
	V_SET_ITERATOR [G]
		redefine
			is_equal_,
			target
		end

create {V_HASH_SET}
	make

feature {NONE} -- Initialization

	make (t: V_HASH_SET [G])
			-- Create iterator over `t'.
		note
			explicit: contracts, wrapping
		require
			open: is_open
			t_wrapped: t.is_wrapped
			no_observers: observers.is_empty
			not_observing_t: not t.observers [Current]
		do
			target := t
			t.unwrap
			t.observers := t.observers & Current
			t.table.lemma_domain
			iterator := t.table.new_cursor
			t.wrap

			iterator.lemma_sequence_no_duplicates
			iterator.sequence.lemma_no_duplicates
			check ∀ x: t.bag.domain ¦ t.bag [x] = iterator.sequence.to_bag [x] end

			wrap
		ensure
			wrapped: is_wrapped
			t_wrapped: t.is_wrapped
			target_effect: target = t
			index_effect: index_ = 1
			t_observers_effect: t.observers = old t.observers & Current
			iterator.is_fresh
			modify_field (["observers", "closed"], t)
			modify (Current)
		end

feature -- Initialization

	copy_ (other: like Current)
			-- Initialize with the same `target' and position as in `other'.
		note
			explicit: wrapping
		require
			target_wrapped: target.is_wrapped
			other_target_wrapped: other.target.is_wrapped
			target /= other.target implies not other.target.observers [Current]
		do
			if Current /= other then
				if target /= other.target then
					check inv_only ("no_observers") end
					target.forget_iterator (Current)
					make (other.target)
				end
				check other.inv_only ("targets_connected", "owns_definition", "same_index") end
				unwrap
				check iterator.inv_only ("target_exists") end
				check target.inv_only ("owns_definition") end
				iterator.go_to_other (other.iterator)
				check iterator.inv_only ("index_constraint", "target_domain_constraint", "value_sequence_definition") end
				wrap
			end
		ensure
			target_effect: target = old other.target
			index_effect: index_ = old other.index_
			old_target_wrapped: (old target).is_wrapped
			other_target_wrapped: other.target.is_wrapped
			old_target_observers_effect: other.target /= old target implies (old target).observers = old target.observers / Current
			other_target_observers_effect: other.target /= old target implies other.target.observers = old other.target.observers & Current
			target_observers_preserved: other.target = old target implies other.target.observers = old other.target.observers
			modify (Current)
			modify_model ("observers", [target, other.target])
		end

feature -- Access

	target: V_HASH_SET [G]
			-- Set to iterate over.

	item: G
			-- Item at current position.
		do
			check inv; iterator.inv; target.inv end
			Result := iterator.key
		end

feature -- Measurement

	index: INTEGER
			-- Current position.
		do
			check inv; iterator.inv; target.inv end
			Result := iterator.index
		end

feature -- Status report

	before: BOOLEAN
			-- Is current position before any position in `target'?
		do
			check inv; iterator.inv end
			Result := iterator.before
		end

	after: BOOLEAN
			-- Is current position after any position in `target'?
		do
			check inv; iterator.inv; target.inv end
			check iterator.target.ownership_domain <= target.ownership_domain end
			Result := iterator.after
		end

	is_first: BOOLEAN
			-- Is cursor at the first position?
		do
			check inv; iterator.inv; target.inv end
			Result := iterator.is_first
		end

	is_last: BOOLEAN
			-- Is cursor at the last position?
		do
			check inv; iterator.inv; target.inv end
			Result := iterator.is_last
		end

feature -- Comparison

	is_equal_ (other: like Current): BOOLEAN
			-- Is iterator traversing the same container and is at the same position at `other'?
		do
			check inv; other.inv; iterator.inv; other.iterator.inv end
			check target.inv_only ("owns_definition"); other.target.inv_only ("owns_definition") end
			Result := iterator.is_equal_ (other.iterator)
		end

feature -- Cursor movement

	search (v: G)
			-- Move to an element equivalent to `v'.
			-- If `v' does not appear, go after.
			-- (Use object equality.)
		do
			check iterator.inv end
			check target.inv_only ("owns_definition", "same_lock") end
			check iterator.list_iterator.inv_only ("default_owns") end
			iterator.search_key (v)
		end

	start
			-- Go to the first position.
		do
			check iterator.inv end
			check target.inv_only ("owns_definition") end
			check iterator.list_iterator.inv_only ("default_owns") end
			iterator.start
		end

	finish
			-- Go to the last position.
		do
			check iterator.inv end
			check target.inv_only ("owns_definition") end
			check iterator.list_iterator.inv_only ("default_owns") end
			iterator.finish
		end

	forth
			-- Move one position forward.
		do
			check iterator.inv end
			check target.inv_only ("owns_definition") end
			check iterator.list_iterator.inv_only ("default_owns") end
			iterator.forth
		end

	back
			-- Go one position backwards.
		do
			check iterator.inv end
			check target.inv_only ("owns_definition") end
			check iterator.list_iterator.inv_only ("default_owns") end
			iterator.back
		end

	go_before
			-- Go before any position of `target'.
		do
			check iterator.inv end
			check iterator.list_iterator.inv_only ("default_owns") end
			iterator.go_before
		end

	go_after
			-- Go after any position of `target'.
		do
			check iterator.inv end
			check target.inv_only ("owns_definition") end
			check iterator.list_iterator.inv_only ("default_owns") end
			iterator.go_after
		end

feature -- Removal

	remove
			-- Remove element at current position. Move cursor to the next position.
		do
			check iterator.inv end
			check iterator.list_iterator.inv_only ("default_owns") end
			target.unwrap

			iterator.remove
			target.wrap

			check iterator.inv_only ("target_domain_constraint") end
			iterator.sequence.to_bag.lemma_domain_count
			check ∀ x: target.bag.domain ¦ target.bag [x] = iterator.sequence.to_bag [x] end
		end

feature {V_CONTAINER, V_ITERATOR, V_LOCK} -- Implementation

	iterator: V_HASH_TABLE_ITERATOR [G, detachable ANY]
			-- Iterator over the storage.

invariant
	iterator_exists: iterator /= Void
	owns_definition: owns ~ create {MML_SET [ANY]}.singleton (iterator)
	targets_connected: target.table = iterator.target
	same_sequence: sequence ~ iterator.sequence
	same_index: index_ = iterator.index_

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
