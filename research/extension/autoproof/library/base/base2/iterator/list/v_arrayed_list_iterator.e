note
	description: "Iterators over arrayed lists."
	author: "Nadia Polikarpova"
	revised_by: "Alexander Kogtenkov"
	model: target, index_
	manual_inv: true
	false_guards: true

class
	V_ARRAYED_LIST_ITERATOR [G]

inherit
	V_LIST_ITERATOR [G]
		undefine
			is_equal_,
			go_to
		redefine
			target,
			sequence,
			index_
		end

	V_INDEX_ITERATOR [G]
		redefine
			target,
			sequence,
			index_
		end

create {V_ARRAYED_LIST}
	make

feature {NONE} -- Initialization

	make (list: V_ARRAYED_LIST [G]; i: INTEGER)
			-- Create an iterator at position `i' in `list'.
		note
			status: creator
		require
			modify (Current)
			modify_field (["observers", "closed"], list)
		do
			target := list
			target.add_iterator (Current)
			if i < 1 then
				index := 0
			elseif i > list.count then
				index := list.count + 1
			else
				index := i
			end
			check target.inv end
		ensure
			target_effect: target = list
			index_effect_has: 1 <= i and i <= list.sequence.count implies index = i
			index_effect_before: i < 1 implies index = 0
			index_effect_after: i > list.sequence.count implies index = list.sequence.count + 1
			list_observers_effect: list.observers = old list.observers & Current
		end

feature -- Initialization

	copy_ (other: like Current)
			-- Initialize with the same `target' and position as in `other'.
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
			if Current /= other then
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

	target: V_ARRAYED_LIST [G]
			-- Container to iterate over.

feature -- Replacement

	put (v: G)
			-- Replace item at current position with `v'.
		do
			check target.inv end
			target.put (v, index)
			check target.inv end
		end

feature -- Extension

	extend_left (v: G)
			-- Insert `v' to the left of current position. Do not move cursor.
		do
			target.extend_at (v, index)
			check target.inv end
			index := index + 1
		end

	extend_right (v: G)
			-- Insert `v' to the right of current position. Do not move cursor.
		do
			target.extend_at (v, index + 1)
			check target.inv end
		end

	insert_left (other: V_ITERATOR [G])
			-- Append sequence of values, over which `input' iterates to the left of current position. Do not move cursor.
		local
			old_other_count: INTEGER
		do
			check other.inv end
			old_other_count := other.target.count - other.index + 1
			target.insert_at (other, index)
			check target.inv end
			index := index + old_other_count
		end

	insert_right (other: V_ITERATOR [G])
			-- Append sequence of values, over which `input' iterates to the right of current position. Move cursor to the last element of inserted sequence.
		local
			old_other_count: INTEGER
		do
			check other.inv end
			old_other_count := other.target.count - other.index + 1
			target.insert_at (other, index + 1)
			check target.inv end
			index := index + old_other_count
		end

feature -- Removal

	remove
			-- Remove element at current position. Move cursor to the next position.
		do
			target.remove_at (index)
			check target.inv end
		end

	remove_left
			-- Remove element to the left current position. Do not move cursor.
		do
			target.remove_at (index - 1)
			index := index - 1
			check target.inv end
		end

	remove_right
			-- Remove element to the right current position. Do not move cursor.
		do
			target.remove_at (index + 1)
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
