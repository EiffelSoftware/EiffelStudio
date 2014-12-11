note
	description: "Iterators over linked lists."
	author: "Nadia Polikarpova"
	model: target, sequence, index

class
	V_LINKED_LIST_ITERATOR [G]

inherit
	V_LIST_ITERATOR [G]
		undefine
			off
		redefine
			copy
		end

	V_CELL_CURSOR [G]
		undefine
			is_equal,
			box
		redefine
			active,
			copy
		end

create {V_CONTAINER, V_ITERATOR}
	make

feature {V_CONTAINER, V_ITERATOR} -- Initialization

	make (list: V_LINKED_LIST [G])
			-- Create iterator over `list'.
		do
			target := list
			active := Void
			after := False
		ensure
			target_effect: target = list
			index_effect: index = 0
		end

feature -- Initialization

	copy (other: like Current)
			-- Initialize with the same `target' and position as in `other'.
		note
			modify: target, index
		do
			target := other.target
			active := other.active
			after := other.after
		ensure then
			target_effect: target = other.target
			index_effect: index = other.index
		end

feature -- Access

	target: V_LINKED_LIST [G]
			-- Container to iterate over.

feature -- Measurement			

	index: INTEGER
			-- Current position.
		do
			if after then
				Result := target.count + 1
			elseif is_last then
				Result := target.count
			elseif active /= Void then
				Result := active_index
			end
		end

feature -- Status report	

	is_first: BOOLEAN
			-- Is cursor at the first position?
		do
			Result := not (active = Void) and active = target.first_cell
		end

	is_last: BOOLEAN
			-- Is cursor at the last position?
		do
			Result := not (active = Void) and then active = target.last_cell
		end

	after: BOOLEAN
			-- Is current position after the last container position?

	before: BOOLEAN
			-- Is current position before the first container position?
		do
			Result := off and not after
		end

feature -- Cursor movement

	start
			-- Go to the first position.
		do
			active := target.first_cell
			if active = Void then
				after := True
			else
				after := False
			end
		end

	finish
			-- Go to the last position.
		do
			active := target.last_cell
			after := False
		end

	forth
			-- Move one position forward.
		do
			check not_off: attached active as a then
				active := a.right
			end
			if active = Void then
				after := True
			end
		end

	back
			-- Go one position backwards.
		local
			old_active: detachable V_LINKABLE [G]
		do
			if is_first then
				go_before
			else
				old_active := active
				from
					start
				until
					attached active as a and then a.right = old_active
				loop
					forth
				end
			end
		end

	go_before
			-- Go before any position of `target'.
		do
			active := Void
			after := False
		end

	go_after
			-- Go after any position of `target'.
		do
			active := Void
			after := True
		end

feature -- Extension

	extend_left (v: G)
			-- Insert `v' to the left of current position. Do not move cursor.
		do
			if is_first then
				target.extend_front (v)
			else
				back
				extend_right (v)
				forth
				forth
			end
		end

	extend_right (v: G)
			-- Insert `v' to the right of current position. Do not move cursor.
		do
			check not_off: attached active as a then
				target.extend_after (v, a)
			end
		end

	insert_left (other: V_ITERATOR [G])
			-- Append sequence of values, over which `input' iterates to the left of current position. Do not move cursor.
		do
			if is_first then
				target.prepend (other)
			else
				back
				insert_right (other)
				forth
			end
		end

	insert_right (other: V_ITERATOR [G])
			-- Append sequence of values, over which `input' iterates to the right of current position. Move cursor to the last element of inserted sequence.
		do
			from
			until
				other.after
			loop
				extend_right (other.item)
				forth
				other.forth
			end
		end

	merge (other: V_LINKED_LIST [G])
			-- Merge `other' into `target' after current position. Do not copy elements. Empty `other'.
		note
			modify: sequence, other__sequence
		require
			other_not_target: other /= target
			not_after: not after
		do
			if before then
				target.merge_after (other, Void)
			else
				target.merge_after (other, active)
			end
		ensure
			sequence_effect: sequence |=| old (sequence.front (index) + other.sequence + sequence.tail (index + 1))
			other_sequence_effect: other.sequence.is_empty
		end

feature -- Removal

	remove
			-- Remove element at current position. Move cursor to the next position.
		do
			if is_first then
				target.remove_front
				start
			else
				back
				remove_right
				forth
			end
		end

	remove_left
			-- Remove element to the left of current position. Do not move cursor.
		do
			back
			remove
		end

	remove_right
			-- Remove element to the right of current position. Do not move cursor.
		do
			check not_off: attached active as a then
				target.remove_after (a)
			end
		end

feature {V_CELL_CURSOR} -- Implementation

	active: detachable V_LINKABLE [G]
			-- Cell at current position.
			-- If unreachable from `target.first_cell' iterator is considered `before'.

	active_index: INTEGER
			-- Distance from `target.first_cell' to `active'.
			-- 0 if `active' is not reachable from `target.first_cell'.
		require
			active_exists: active /= Void
		local
			c: detachable V_LINKABLE [G]
		do
			from
				c := target.first_cell
				Result := 1
			until
				c = active or c = Void
			loop
				Result := Result + 1
				c := c.right
			end
		end

invariant
	after_definition: after = (index = sequence.count + 1)

end
