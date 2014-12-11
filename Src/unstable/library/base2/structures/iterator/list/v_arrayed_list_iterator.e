note
	description: "Iterators over arrayed lists."
	author: "Nadia Polikarpova"
	model: target, sequence, index

class
	V_ARRAYED_LIST_ITERATOR [G]

inherit
	V_LIST_ITERATOR [G]
		undefine
			go_to
		redefine
			copy
		end

	V_INDEX_ITERATOR [G]
		undefine
			sequence
		redefine
			copy
		end

create {V_ARRAYED_LIST}
	make

feature {NONE} -- Initialization

	make (list: V_ARRAYED_LIST [G]; i: INTEGER)
			-- Create an iterator at position `i' in `list'.
		do
			target := list
			if i < 1 then
				index := 0
			elseif i > list.count then
				index := list.count + 1
			else
				index := i
			end
		ensure
			target_effect: target = list
			index_effect_has: 1 <= i and i <= list.count implies index = i
			index_effect_before: i < 1 implies index = 0
			index_effect_after: i > list.count implies index = list.count + 1
		end

feature -- Initialization

	copy (other: like Current)
			-- Initialize with the same `target' and position as in `other'.
		note
			modify: target, sequence, index
		do
			target := other.target
			index := other.index
		ensure then
			target_effect: target = other.target
			index_effect: index = other.index
		end

feature -- Access

	target: V_ARRAYED_LIST [G]
			-- Container to iterate over.

feature -- Replacement

	put (v: G)
			-- Replace item at current position with `v'.
		do
			target.put (v, target.lower + index - 1)
		end

feature -- Extension

	extend_left (v: G)
			-- Insert `v' to the left of current position. Do not move cursor.
		do
			target.extend_at (v, index)
			index := index + 1
		end

	extend_right (v: G)
			-- Insert `v' to the right of current position. Do not move cursor.
		do
			target.extend_at (v, index + 1)
		end

	insert_left (other: V_ITERATOR [G])
			-- Append sequence of values, over which `input' iterates to the left of current position. Do not move cursor.
		local
			old_other_count: INTEGER
		do
			old_other_count := other.count_left
			target.insert_at (other, index)
			index := index + old_other_count
		end

	insert_right (other: V_ITERATOR [G])
			-- Append sequence of values, over which `input' iterates to the right of current position. Move cursor to the last element of inserted sequence.
		local
			old_other_count: INTEGER
		do
			old_other_count := other.count_left
			target.insert_at (other, index + 1)
			index := index + old_other_count
		end

feature -- Removal

	remove
			-- Remove element at current position. Move cursor to the next position.
		do
			target.remove_at (index)
		end

	remove_left
			-- Remove element to the left current position. Do not move cursor.
		do
			target.remove_at (index - 1)
			index := index - 1
		end

	remove_right
			-- Remove element to the right current position. Do not move cursor.
		do
			target.remove_at (index + 1)
		end
end
