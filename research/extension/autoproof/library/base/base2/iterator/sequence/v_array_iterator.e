note
	description: "Iterators over mutable sequences that allow only traversal, search and replacement."
	author: "Nadia Polikarpova"
	revised_by: "Alexander Kogtenkov"
	model: target, index_
	manual_inv: true
	false_guards: true

class
	V_ARRAY_ITERATOR [G]

inherit
	V_INDEX_ITERATOR [G]
		redefine
			target,
			sequence,
			index_
		end

	V_MUTABLE_SEQUENCE_ITERATOR [G]
		undefine
			is_equal_,
			go_to
		redefine
			target,
			sequence,
			index_
		end

create {V_CONTAINER}
	make

feature {NONE} -- Initialization

	make (t: V_MUTABLE_SEQUENCE [G]; i: INTEGER)
			-- Create an iterator at position `i' in `t'.
		note
			status: creator
		require
			modify (Current)
			modify_field (["observers", "closed"], t)
		do
			target := t
			target.add_iterator (Current)
			if i < 1 then
				index := 0
			elseif i > t.count then
				index := t.count + 1
			else
				index := i
			end
			check target.inv end
		ensure
			target_effect: target = t
			index_effect_has: 1 <= i and i <= t.sequence.count implies index_ = i
			index_effect_before: i < 1 implies index_ = 0
			index_effect_after: i > t.sequence.count implies index_ = t.sequence.count + 1
			t_observers_effect: t.observers = old t.observers & Current
		end

feature -- Initialization

	copy_ (other: like Current)
			-- Initialize with the same `target' and `index' as in `other'.
		note
			explicit: wrapping
		require
			target_wrapped: target.is_wrapped
			other_target_wrapped: other.target.is_wrapped
			modify (Current)
			modify_model ("observers", [target, other.target])
		do
			check other.inv_only ("index_constraint", "sequence_definition", "default_owns", "index_definition") end
			check inv_only ("no_observers", "subjects_definition", "A2", "default_owns") end
			if other /= Current then
				target.forget_iterator (Current)
				target := other.target
				target.add_iterator (Current)
				index := other.index
				check target.inv end
				wrap
			end
		ensure then
			target_effect: target = other.target
			index_effect: index_ = other.index_
			old_target_wrapped: (old target).is_wrapped
			other_target_wrapped: other.target.is_wrapped
			old_target_observers_effect: other.target /= old target implies (old target).observers = old target.observers / Current
			other_target_observers_effect: other.target /= old target implies other.target.observers = old other.target.observers & Current
			target_observers_preserved: other.target = old target implies other.target.observers = old other.target.observers
		end

feature -- Access

	target: V_MUTABLE_SEQUENCE [G]
			-- Target container.

feature -- Replacement

	put (v: G)
			-- Replace item at current position with `v'.
		do
			check target.inv end
			target.put (v, target.lower + index - 1)
			check target.inv end
		end

feature -- Specification

	sequence: MML_SEQUENCE [G]
			-- Sequence of elements in `target'.
		note
			status: ghost
		attribute
			check is_executable: False then end
		end

	index_: INTEGER
			-- Current position.
		note
			status: ghost
		attribute
		end

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
