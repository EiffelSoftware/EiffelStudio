note
	description: "Iterators over linked queues."
	author: "Nadia Polikarpova"
	revised_by: "Alexander Kogtenkov"
	model: target, index_
	manual_inv: true
	false_guards: true

class
	V_LINKED_QUEUE_ITERATOR [G]

inherit
	V_ITERATOR [G]
		redefine
			target,
			is_equal_,
			is_model_equal
		end

create {V_CONTAINER}
	make

feature {NONE} -- Initialization

	make (t: V_LINKED_QUEUE [G])
			-- Create iterator over `t'.
		note
			explicit: contracts, wrapping
		require
			open: is_open
			t_wrapped: t.is_wrapped
			no_observers: observers.is_empty
			not_observing_t: not t.observers [Current]
			modify_field (["observers", "closed"], t)
			modify (Current)
		do
			target := t
			t.unwrap
			t.observers := t.observers & Current
			iterator := t.list.new_cursor
			t.wrap
			wrap
		ensure
			wrapped: is_wrapped
			t_wrapped: t.is_wrapped
			target_effect: target = t
			index_effect: index_ = 1
			t_observers_effect: t.observers = old t.observers & Current
			iterator.is_fresh
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
			modify (Current)
			modify_model ("observers", [target, other.target])
		do
			if Current /= other then
				if target /= other.target then
					check inv_only ("no_observers") end
					target.forget_iterator (Current)
					make (other.target)
				end
				go_to_other (other)
			end
		ensure
			target_effect: target = old other.target
			index_effect: index_ = old other.index_
			old_target_wrapped: (old target).is_wrapped
			other_target_wrapped: other.target.is_wrapped
			old_target_observers_effect: other.target /= old target implies (old target).observers = old target.observers / Current
			other_target_observers_effect: other.target /= old target implies other.target.observers = old other.target.observers & Current
			target_observers_preserved: other.target = old target implies other.target.observers = old other.target.observers
		end

feature -- Access

	target: V_LINKED_QUEUE [G]
			-- Stack to iterate over.

	item: G
			-- Item at current position.
		do
			check inv; iterator.inv; target.inv end
			Result := iterator.item
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

	start
			-- Go to the first position.
		do
			check iterator.inv end
			check target.inv_only ("owns_definition") end
			iterator.start
		end

	finish
			-- Go to the last position.
		do
			check iterator.inv end
			check target.inv_only ("owns_definition") end
			iterator.finish
		end

	forth
			-- Move one position forward.
		do
			check iterator.inv end
			check target.inv_only ("owns_definition") end
			iterator.forth
		end

	back
			-- Go one position backwards.
		do
			check iterator.inv end
			check target.inv_only ("owns_definition") end
			iterator.back
		end

	go_before
			-- Go before any position of `target'.
		do
			check iterator.inv end
			iterator.go_before
		end

	go_after
			-- Go after any position of `target'.
		do
			check iterator.inv end
			check target.inv_only ("owns_definition") end
			iterator.go_after
		end

feature {V_CONTAINER, V_ITERATOR} -- Implementation

	iterator: V_LINKED_LIST_ITERATOR [G]
			-- Iterator over the storage.

	go_to_other (other: like Current)
			-- Move to the same position as `other'.
		require
			is_wrapped
			other.closed
			other /= Current
			same_target: target = other.target
			target_wrapped: target.is_wrapped
			modify_model ("index_", Current)
		do
			unwrap
			check other.inv_only ("owns_definition", "targets_connected", "same_sequence", "same_index") end
			check target.inv_only ("owns_definition"); target.list.inv_only ("cells_domain") end
			check iterator.inv_only ("sequence_definition") end
			check other.iterator.inv_only ("sequence_definition", "index_constraint", "cell_not_off", "cell_off") end
			if other.iterator.before then
				iterator.go_before
			elseif other.iterator.after then
				iterator.go_after
			else
				if attached other.iterator.active as a then
					iterator.go_to_cell (a)
					target.list.lemma_cells_distinct
				else
					check from_condition: False then end
				end
			end
			wrap
		ensure
			is_wrapped
			index_effect: index_ = old other.index_
		end

feature -- Specification

	is_model_equal (other: like Current): BOOLEAN
			-- Is the abstract state of `Current' equal to that of `other'?
		note
			status: ghost, functional, nonvariant
		do
			Result := target = other.target and index_ = other.index_
		end

invariant
	sequence_definition: sequence ~ target.sequence
	iterator_exists: iterator /= Void
	owns_definition: owns ~ create {MML_SET [ANY]}.singleton (iterator)
	targets_connected: target.list = iterator.target
	same_sequence: sequence ~ iterator.sequence
	same_index: index_ = iterator.index_

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
