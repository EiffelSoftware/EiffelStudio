note
	description: "Iterators over doubly-linked lists."
	author: "Nadia Polikarpova"
	model: target, index_
	manual_inv: true
	false_guards: true

class
	V_DOUBLY_LINKED_LIST_ITERATOR [G]

inherit
	V_LIST_ITERATOR [G]
		redefine
			target,
			off,
			is_equal_,
			go_to
		end

create
	make

feature {V_CONTAINER, V_ITERATOR} -- Initialization

	make (list: V_DOUBLY_LINKED_LIST [G])
			-- Create iterator over `list'.
		note
			status: creator
		require
			modify (Current)
			modify_field (["observers", "closed"], list)
		do
			target := list
			target.add_iterator (Current)
			active := Void
			after_ := False
			check target.inv_only ("cells_domain", "bag_definition") end
			target.lemma_cells_distinct
		ensure
			target_effect: target = list
			index_effect: index_ = 0
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
			if Current /= other then
				check other.inv_only ("index_constraint", "after_definition", "sequence_definition", "cell_off", "cell_not_off", "default_owns") end
				check inv_only ("no_observers", "subjects_definition", "A2") end
				target.forget_iterator (Current)
				target := other.target
				target.add_iterator (Current)
				active := other.active
				index_ := other.index_
				after_ := other.after_
				set_owns (other.owns)
				check target.inv_only ("cells_domain", "bag_definition") end
				target.lemma_cells_distinct
				wrap
			end
		ensure
			target_effect: target = other.target
			index_effect: index_ = other.index_
			old_target_wrapped: (old target).is_wrapped
			other_target_wrapped: other.target.is_wrapped
			old_target_observers_effect: other.target /= old target implies (old target).observers = old target.observers / Current
			other_target_observers_effect: other.target /= old target implies other.target.observers = old other.target.observers & Current
			target_observers_preserved: other.target = old target implies other.target.observers = old other.target.observers
		end

feature -- Access

	target: V_DOUBLY_LINKED_LIST [G]
			-- Container to iterate over.

	item: G
			-- Item at current position.
		do
			check inv end
			check target.inv end
			Result := active.item
		end

feature -- Measurement

	index: INTEGER
			-- Current position.
		do
			check inv end
			if after then
				Result := target.count + 1
			elseif active /= Void then
				Result := active_index
			end
		end

feature -- Status report

	off: BOOLEAN
			-- Is current position off scope?
		do
			check inv end
			Result := active = Void
		end

	after: BOOLEAN
			-- Is current position after the last container position?
		do
			check inv end
			Result := after_
		end

	before: BOOLEAN
			-- Is current position before the first container position?
		do
			check inv end
			Result := active = Void and not after_
		end

	is_first: BOOLEAN
			-- Is cursor at the first position?
		do
			check inv end
			check target.inv end
			Result := active /= Void and active = target.first_cell
		end

	is_last: BOOLEAN
			-- Is cursor at the last position?
		do
			check inv end
			check target.inv end
			Result := active /= Void and then active = target.last_cell
		end

feature -- Comparison

	is_equal_ (other: like Current): BOOLEAN
			-- Is iterator traversing the same container and is at the same position at `other'?		
		do
			check inv; other.inv end
			Result := target = other.target and active = other.active and after_ = other.after_
		end

feature -- Cursor movement

	start
			-- Go to the first position.
		do
			check target.inv end
			active := target.first_cell
			after_ := active = Void
			index_ := 1
		end

	finish
			-- Go to the last position.
		do
			check target.inv end
			active := target.last_cell
			after_ := False
			index_ := target.sequence.count
		end

	forth
			-- Move one position forward.
		do
			check target.inv end
			active := active.right
			index_ := index_ + 1
			after_ := active = Void
		end

	back
			-- Go one position backwards.
		do
			check target.inv end
			active := active.left
			index_ := index_ - 1
			check index_ >= 1 implies target.cells [index_].inv end
		end

	go_before
			-- Go before any position of `target'.
		do
			active := Void
			after_ := False
			index_ := 0
		end

	go_after
			-- Go after any position of `target'.
		do
			check inv end
			check target.inv end
			active := Void
			after_ := True
			index_ := target.count + 1
		end

	go_to (i: INTEGER)
			-- Go to position `i'.
		note
			explicit: wrapping
		local
			j: INTEGER
		do
			check inv end
			if i = 0 then
				go_before
			elseif i = target.count + 1 then
				go_after
			else
				check target.inv end
				unwrap
				active := target.cell_at (i)
				after_ := False
				index_ := i
				wrap
			end
		end

feature -- Replacement

	put (v: G)
			-- Replace item at current position with `v'.
		do
			target.put_cell (v, active, index_)
			check target.inv_only ("bag_definition") end
		end

feature -- Extension

	extend_left (v: G)
			-- Insert `v' to the left of current position. Do not move cursor.
		note
			explicit: wrapping
		do
			check inv_only ("subjects_definition") end
			if is_first then
				unwrap
				target.extend_front (v)
				check target.inv_only ("bag_definition") end
				index_ := index_ + 1
				target.lemma_cells_distinct
				wrap
			else
				back
				extend_right (v)
				check inv end
				forth
				check inv end
				forth
			end
		end

	extend_right (v: G)
			-- Insert `v' to the right of current position. Do not move cursor.
		do
			target.extend_after (create {V_DOUBLY_LINKABLE [G]}.put (v), active, index_)
			check target.inv_only ("bag_definition") end
		ensure then
			cell_sequence_front_preserved: target.cells.old_.front (index_) ~ target.cells.front (index_)
			cell_sequence_tail_preserved: target.cells.old_.tail (index_ + 1) ~ target.cells.tail (index_ + 2)
		end

	insert_left (other: V_ITERATOR [G])
			-- Append sequence of values, over which `input' iterates to the left of current position. Do not move cursor.
		note
			explicit: wrapping
		do
			check inv_only ("subjects_definition", "sequence_definition", "no_observers", "A2") end
			check other.inv_only ("subjects_definition", "index_constraint", "no_observers", "A2") end
			if is_first then
				unwrap
				target.prepend (other)
				check target.inv_only ("bag_definition") end
				index_ := index_ + other.sequence.tail (other.index_.old_).count
				target.lemma_cells_distinct
				wrap
			else
				back
				insert_right (other)
				check inv_only ("sequence_definition", "after_definition") end
				forth
			end
		end

	insert_right (other: V_ITERATOR [G])
			-- Append sequence of values, over which `input' iterates to the right of current position. Move cursor to the last element of inserted sequence.
		note
			explicit: wrapping
		local
			v: G
			s: like sequence
		do
			from
				check inv_only ("subjects_definition", "no_observers", "A2") end
				check other.inv_only ("target_exists", "subjects_definition", "index_constraint") end
			invariant
				1 <= index_.old_ and index_.old_ <= index_ and index_ <= sequence.count
				1 <= other.index_.old_ and other.index_.old_ <= other.index_ and other.index_ <= other.sequence.count + 1
				index_ - index_.old_ = other.index_ - other.index_.old_
				is_wrapped
				other.is_wrapped
				target.is_wrapped
				target /= Current
				across target.observers as o all o.item /= Current implies o.item.is_open end
				s = other.sequence.old_.interval (other.index_.old_, other.index_ - 1)
				target.sequence ~ (target.sequence.front (index_.old_).old_ +
					s + target.sequence.tail (index_.old_ + 1).old_)
				target.observers ~ target.observers.old_
				other.sequence ~ other.sequence.old_
			until
				other.after
			loop
				check inv_only ("after_definition", "sequence_definition") end
				v := other.item
				extend_right (v)
				s := s & v
				check inv_only ("after_definition", "sequence_definition") end
				forth
				check other.inv_only ("no_observers") end
				other.forth
			variant
				other.sequence.count - other.index_
			end
		end

	merge (other: V_DOUBLY_LINKED_LIST [G])
			-- Merge `other' into `target' after current position. Do not copy elements. Empty `other'.
		require
			target_wrapped: target.is_wrapped
			other_wrapped: other.is_wrapped
			other_not_target: other /= target
			not_after: index_ <= sequence.count
			observers_open: across target.observers as o all o.item /= Current implies o.item.is_open end
			other_observers_open: across other.observers as o all o.item.is_open end
			modify_model ("sequence", Current)
			modify_model ("sequence", [target, other])
		do
			target.merge_after (other, active, index_)
			check target.inv_only ("cells_domain", "bag_definition") end
			target.lemma_cells_distinct
		ensure
			sequence_effect: sequence ~ old (sequence.front (index_) + other.sequence + sequence.tail (index_ + 1))
			other_sequence_effect: other.sequence.is_empty
		end

feature -- Removal

	remove
			-- Remove element at current position. Move cursor to the next position.
		note
			explicit: wrapping
		do
			if is_first then
				unwrap
				target.remove_front
				check target.inv_only ("bag_definition", "first_cell_empty", "cells_first") end
				active := target.first_cell
				after_ := active = Void
				target.lemma_cells_distinct
				wrap
			else
				check inv_only ("subjects_definition", "sequence_definition") end
				back
				remove_right
				check inv end
				forth
			end
		end

	remove_left
			-- Remove element to the left of current position. Do not move cursor.
		note
			explicit: wrapping
		do
			back
			check inv end
			remove
		end

	remove_right
			-- Remove element to the right of current position. Do not move cursor.
		do
			target.remove_after (active, index_)
			check target.inv_only ("bag_definition") end
		end

feature {V_DOUBLY_LINKED_LIST_ITERATOR} -- Implementation

	active: V_DOUBLY_LINKABLE [G]
			-- Cell at current position.

	after_: BOOLEAN
			-- Is current position after the last container position?			

	active_index: INTEGER
			-- Distance from `target.first_cell' to `active'.
		require
			active_exists: active /= Void
			closed: closed
			target_closed: target.closed
		local
			cf, cb: V_DOUBLY_LINKABLE [G]
			i, j: INTEGER
		do
			check inv end
			check target.inv end
			from
				cf := target.first_cell
				cb := target.last_cell
				i := 1
				j := target.count_
			invariant
				1 <= i and i <= index_
				index_ <= j and j <= sequence.count
				cf = target.cells [i]
				cb = target.cells [j]
			until
				active = cf or active = cb
			loop
				i := i + 1
				cf := cf.right
				check target.cells [j - 1].inv end
				j := j - 1
				cb := cb.left
			variant
				target.count_ - i
			end
			target.lemma_cells_distinct
			if active = cf then
				Result := i
			else
				Result := j
			end
		ensure
			definition: Result = index_
		end

invariant
	after_definition: after_ = (index_ = sequence.count + 1)
	cell_off: (index_ < 1 or sequence.count < index_) = (active = Void)
	target_cells_domain: target.cells.count = sequence.count
	cell_not_off: 1 <= index_ and index_ <= sequence.count implies active = target.cells [index_]
	target_cells_distinct: target.cells.no_duplicates

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
