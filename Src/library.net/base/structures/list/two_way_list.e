indexing
	description: "Sequential, two-way linked lists"
	external_name: "ISE.Base.TwoWayList"

class 
	TWO_WAY_LIST [G] 

inherit
	LINKED_LIST [G]
		redefine
			first_element, last_element,
			extend, put_front, put_left, put_right,
			merge_right, merge_left, new_cell,
			remove, remove_left, remove_right, wipe_out,
			previous, finish, move, islast,
			forth, back, new_chain, copy, next,
			active, cleanup_after_remove, valid_cursor
		end

create

	make_sublist, make

feature -- Access

	first_element: BI_LINKABLE [G]
		indexing
			description: "Head of list (Anchor redefinition)"
		end

	last_element: BI_LINKABLE [G] is
		indexing
			description: "Tail of the list"
		do
			Result := internal_last_element
		end

	sublist: TWO_WAY_LIST [G]
		indexing
			description: "Result produced by last `split'"
		end

feature -- Status report

	islast: BOOLEAN is
		indexing
			description: "Is cursor at last position?"
		do
			Result := (active = last_element)
				and then not after
				and then not before
		end

	valid_cursor (p: CURSOR): BOOLEAN is
		indexing
			description: "Can the cursor be moved to position `p'?"
		local
			ll_c: LINKED_LIST_CURSOR [G]
			temp, sought: BI_LINKABLE [G]
		do
			ll_c ?= p
			if ll_c /= Void then
				from
					temp := first_element
					sought ?= ll_c.active
					Result := ll_c.after or else ll_c.before
				until
					Result or else temp = Void
				loop
					Result := (temp = sought)
					temp := temp.right
				end
			end
		end
		
feature -- Cursor movement

	forth is
		indexing
			description: "Move cursor to next position, if any."
		do
			if before then
				internal_before := False
				if is_empty then
					internal_after := True
				end
			else
				active := active.right
				if active = Void then
					active := last_element
					internal_after := True
				end
			end
		end

	back is
		indexing
			description: "Move cursor to previous position, if any."
		do
			if after then
				internal_after := False
				if is_empty then
					internal_before := True
				end
			else
				active := active.left
				if active = Void then
					active := first_element
					internal_before := True
				end
			end
		end

	finish is
		indexing
			description: "Move cursor to last position. (Go before if empty)"
		do
			if not is_empty then
				active := last_element
				internal_after := False
				internal_before := False
			else
				internal_after := False
				internal_before := True
			end
		ensure then
			not_after: not after
		end

	move (i: INTEGER) is
		indexing
			description: "[
						Move cursor `i' positions. The cursor
						may end up `off' if the offset is to big.
					  ]"
		local
			counter: INTEGER
			p: BI_LINKABLE [G]
		do
			if i > 0 then
				Precursor (i)
			elseif i < 0 then
				if after then
					internal_after := False
					counter := -1
				end
				from
					p := active
				until
					(counter = i) or else (p = Void)
				loop
					p := p.left
					counter := counter - 1
				end
				if p = Void then
					internal_before := True
					active := first_element
				else
					active := p
				end
			end
		end

feature -- Element change

	put_front (v: G) is
		indexing
			description: "Add `v' to beginning. Do not move cursor."
		do
			Precursor (v)
			if count = 1 then
				internal_last_element := first_element
			end
		end

	extend (v: G) is
		indexing
			description: "Add `v' to end. Do not move cursor."
		local
			p : BI_LINKABLE [G]
		do
			p := new_cell (v)
			if is_empty then
				first_element := p
				active := p
			else
				p.put_left (last_element)
			end
			internal_last_element := p
			if after then
				active := p
			end
			internal_count := count + 1
		end

	put_left (v: G) is
		indexing
			description: "[
						Add `v' to the left of cursor position.
						Do not move cursor.
					  ]"
		local
			p: BI_LINKABLE [G]
		do
			p := new_cell (v)
			if is_empty then
				first_element := p
				internal_last_element := p
				active := p
				internal_before := False
			elseif after then
				p.put_left (last_element)
				internal_last_element := p
				active := p
			elseif isfirst then
				p.put_right (active)
				first_element := p
			else
				p.put_left (active.left)
				p.put_right (active)
			end
			internal_count := count + 1
		end

	put_right (v: G) is
		indexing
			description: "Add `v' to the right of cursor position. Do not move cursor."
		local
			was_last: BOOLEAN
		do
			was_last := islast
			Precursor (v)
			if count = 1 then
					-- `p' is only element in list
				internal_last_element := active
			elseif was_last then
					-- `p' is last element in list
				internal_last_element := active.right
			end
		end

	merge_left (other: TWO_WAY_LIST [G]) is
		indexing
			description: "[
						Merge `other' into current structure before cursor
						position. Do not move cursor. Empty `other'.
					  ]"
		local
			other_first_element: BI_LINKABLE [G]
			other_last_element: BI_LINKABLE [G]
			other_count: INTEGER
		do
			if not other.is_empty then
				other_first_element := other.first_element
				other_last_element := other.last_element
				other_count := other.count
					check
						other_first_element /= Void
						other_last_element /= Void
					end
				if is_empty then
					internal_last_element := other_last_element
					first_element := other_first_element
					if before then
						active := first_element
					else -- after because of invariant 'empty_property'
						active := last_element
					end
				elseif isfirst then
					other_last_element.put_right (first_element)
					first_element := other_first_element
				elseif after then
					other_first_element.put_left (last_element)
					internal_last_element := other_last_element
					active := last_element
				else
					other_first_element.put_left (active.left)
					active.put_left (other_last_element)
				end
				internal_count := count + other_count
				other.wipe_out
			end
		end

	merge_right (other: TWO_WAY_LIST [G]) is
		indexing
			description: "[
						Merge `other' into current structure after cursor
						position. Do not move cursor. Empty `other'.
					  ]"
		do
			if is_empty or else islast then
				internal_last_element := other.last_element
			end
			Precursor (other)
		end

feature -- Removal

	remove is
		indexing
			description: "[
						Remove current item.
						Move cursor to right neighbor
						(or `after' if no right neighbor).
					  ]"
		local
			succ, pred, removed: BI_LINKABLE [G]
		do
			removed := active
			if isfirst then
				active := first_element.right
				first_element.forget_right
				first_element := active
				if count = 1 then
					check
						no_active: active = Void
					end
					internal_after := True
					internal_last_element := Void
				end
			elseif islast then
				active := last_element.left
				last_element.forget_left
				internal_last_element := active
				internal_after := True
			else
				pred := active.left
				succ := active.right
				pred.forget_right
				succ.forget_left
				pred.put_right (succ)
				active := succ
			end
			internal_count := count - 1
			cleanup_after_remove (removed)
		end

	remove_left is
		indexing
			description: "[
						Remove item to the left of cursor position.
						Do not move cursor.
					  ]"
		do
			back
			remove
		end

	remove_right is
		indexing
			description: "[
						Remove item to the right of cursor position.
						Do not move cursor.
					  ]"
		do
			forth
			remove
			back
		end

	wipe_out is
		indexing
			description: "Remove all items."
		do
			Precursor
			internal_last_element := Void
		end

	split (n: INTEGER) is
		indexing
			description: "[
						Remove from current list
						min (`n', `count' - `index' - 1) items
						starting at cursor position.
						Move cursor right one position.
						Make extracted sublist accessible
						through attribute `sublist'.
					  ]"
		require
			not_off: not off
			valid_sublist: n >= 0
		local
			actual_number, active_index: INTEGER
			p_elem, s_elem, e_elem, n_elem: BI_LINKABLE [G]
		do
			if n = 0 then
					--just create new empty sublist
				create sublist.make
			else
					-- recognize first breakpoint
				active_index := index
				if active_index + n > count + 1 then
					actual_number := count + 1 - active_index
				else
					actual_number := n
				end
				s_elem := active
				p_elem := previous
					-- recognize second breakpoint
				move (actual_number - 1)
				e_elem := active
				n_elem := next
					-- make sublist
				s_elem.forget_left
				e_elem.forget_right
				create sublist.make_sublist (s_elem, e_elem, actual_number)
					-- fix `Current'
				internal_count := count - actual_number
				if p_elem /= Void then
					p_elem.put_right (n_elem)
				else
					first_element := n_elem
				end
				if n_elem /= Void then
					active := n_elem
				else
					internal_last_element := p_elem
					active := p_elem
					internal_after := True
				end
			end
		end

	remove_sublist is
		do
			sublist := Void
		end

feature -- Duplication

	copy (other: TWO_WAY_LIST [G]) is
		indexing
			description: "[
						Update current object using fields of object attached
						to `other', so as to yield equal objects.
					  ]"
		local
			cur: LINKED_LIST_CURSOR [G]
			obj_comparison: BOOLEAN
		do
			obj_comparison := other.object_comparison
			if not other.is_empty then
				cur ?= other.cursor
				wipe_out
				from
					other.start
				until
					other.off
				loop
					extend (other.item)
					other.forth
				end
				other.go_to(cur)
			end
			internal_object_comparison := obj_comparison
		end

feature {TWO_WAY_LIST} -- Implementation

	internal_last_element: BI_LINKABLE [G]
	
	make_sublist (first_item, last_item: BI_LINKABLE [G]; n: INTEGER) is
		indexing
			description: "Create sublist"
		do
			make
			first_element := first_item
			internal_last_element := last_item
			active := first_element
			internal_count := n
		end

	next: BI_LINKABLE [G] is
		indexing
			description: "Element right of cursor"
		do
			if before then
				Result := active
			elseif active /= Void then
				Result := active.right
			end
		end

	active: BI_LINKABLE [G]
		indexing
			description: "Element at cursor position"
		end

	new_chain: TWO_WAY_LIST [G] is
		indexing
			description: "[
						A newly created instance of the same type.
						This feature may be redefined in descendants so as to
						produce an adequately allocated and initialized object.
					  ]"
		do
			create Result.make
		end
		
	new_cell (v: G): BI_LINKABLE [G] is
		indexing
			description: "A newly created instance of the type of `first_element'."
		do
			create Result
			Result.put (v)
		end

	previous: BI_LINKABLE [G] is
		indexing
			description: "Element left of cursor"
		do
			if after then
				Result := active
			elseif active /= Void then
				Result := active.left
			end
		end

	cleanup_after_remove (v: BI_LINKABLE [G]) is
		indexing
			description: "Clean-up a just removed cell."
		do
		end

invariant

	non_empty_list_has_two_endpoints: not is_empty implies
				(first_element /= Void and last_element /= Void)
	first_element_constraint: first_element /= Void implies 
				first_element.left = Void
	last_element_constraint: last_element /= Void implies 
				last_element.right = Void

end -- class TWO_WAY_LIST



