indexing
	description: "Sequential, one-way linked lists"
	external_name: "ISE.Base.LinkedList"

class
	LINKED_LIST [G]

inherit
	DYNAMIC_LIST [G]
		redefine
			isfirst, islast,wipe_out,
			before, after, off,
			extend,	count, last, prune,
			first, go_i_th, has, index_of			
		end

create

	make

feature -- Initialization

	make is
		indexing
			description: "Create an empty list."
		do
			internal_before := True
		ensure
			is_before: before
		end

feature -- Access

	has (v: G): BOOLEAN is
		indexing
			description: "[
						Does chain include `v'?
						(Reference or object equality,
						based on `object_comparison'.
						if True use `is_equal' else
						`reference_equal')
					  ]"
		local
			pos: CURSOR
		do
			pos := cursor
			start
			if not off then
				search (v)
			end
			Result := not exhausted
			go_to (pos)
		end

	item: G is
		indexing
			description: "Item at current position"
		do
			Result := active.item
		end

	index: INTEGER is
		indexing
			description: "Index of current position"
		local
			p: LINKED_LIST_CURSOR [G]
		do
			if after then
				Result := count + 1
			elseif not before then
				p ?= cursor
				check
					p /= Void
				end
				from
					start
					Result := 1
				until
					p.active = active
				loop
					forth
					Result := Result + 1
				end
				go_to (p)
			end
		end

	index_of (v: G; i: INTEGER): INTEGER is
		indexing
			description: "[
						Index of `i'-th occurrence of `v'.
						0 if none.
						(Reference or object equality,
						based on `object_comparison'.
						if True use `is_equal' else
						`reference_equal')
					  ]"
		local
			pos_cursor: CURSOR
			occur, pos: INTEGER
			a: ANY
		do
			pos_cursor := cursor
			if object_comparison and v /= Void then
				from
					start
					pos := 1
					a := v
				until
					off or (occur = i)
				loop
					if item /= Void and then a.is_equal (item) then
						occur := occur + 1
					end
					forth
					pos := pos + 1
				end
			else
				from
					start
					pos := 1
				until
					off or (occur = i)
				loop
					if item = v then
						occur := occur + 1
					end
					forth
					pos := pos + 1
				end
			end
			if occur = i then
				Result := pos - 1
			end
			go_to (pos_cursor)
		end

	cursor: CURSOR is
		indexing
			description: "Current cursor position"
		do
			create {LINKED_LIST_CURSOR [G]} Result.make (active, after, before)
		end

	first: G is
		indexing
			description: "Item at first position"
		do
			Result := first_element.item
		end

	last: G is
		indexing
			description: "Item at last position"
		do
			Result := last_element.item
		end

feature -- Status report

	valid_cursor (p: CURSOR): BOOLEAN is
		indexing
			description: "Can the cursor be moved to position `p'?"
		local
			ll_c: LINKED_LIST_CURSOR [G]
			temp, sought: LINKABLE [G]
		do
			ll_c ?= p
			if ll_c /= Void then
				from
					temp := first_element
					sought := ll_c.active
					Result := ll_c.after or else ll_c.before
				until
					Result or else temp = Void
				loop
					Result := (temp = sought)
					temp := temp.right
				end
			end
		end

	full: BOOLEAN is
		indexing
			description: "Is structure filled to capacity?"
		do
			Result := False
		end

	after: BOOLEAN is
		indexing
			description: "Is there no valid cursor position to the right of cursor?"
		do
			Result := internal_after
		end

	before: BOOLEAN is
		indexing
			description: "Is there no valid cursor position to the left of cursor?"
		do
			Result := internal_before
		end

	off: BOOLEAN is
		indexing
			description: "Is there no current item?"
		do
			Result := after or before
		end

	isfirst: BOOLEAN is
		indexing
			description: "Is cursor at first position?"
		do
			Result := not after and not before and (active = first_element)
		end

	islast: BOOLEAN is
		indexing
			description: "Is cursor at last position?"
		do
			Result := not after and not before and
						(active /= Void) and then (active.right = Void)
		end

	is_inserted (v: G): BOOLEAN is
		indexing
			description: "Has `v' been inserted at the end by the most recent `put' or `extend'?"
		do
			check
				put_constraint: (v /= last_element.item) implies not off
					-- Because, if this routine has not been called by
					-- `extend', it was called by `put' which replaces the
					-- current item, which implies the cursor is not `off'.
			end
			Result := (v = last_element.item) or else (v = item)
		end

feature -- Cursor movement

	start is
		indexing
			description: "Move to first position if any."
		do
			if first_element /= Void then
				active := first_element
				internal_after := False
			else
				internal_after := True
			end
			internal_before := False
		ensure then
			empty_convention: is_empty implies after
		end
		
	forth is
		indexing
			description: "[
						Move to next position; if no next position,
						ensure that `exhausted' will be true.
					  ]"
		local
			old_active: LINKABLE [G]
		do
			if before then
				internal_before := False
				if is_empty then internal_after := True end
			else
				old_active := active
				active := active.right
				if active = Void then
					active := old_active
					internal_after := True
				end
			end
		end

	back is
		indexing
			description: "Move to previous position."
		do
			if is_empty then
				internal_before := True
				internal_after := False
			elseif after then
				internal_after := False
			elseif isfirst then
				internal_before := True
			else
				active := previous
			end
		end

	finish is
		indexing
			description: "Move cursor to last position. (No effect if empty)"
		local
			p: LINKABLE [G]
		do
			if not is_empty then
				from
					p := active
				until
					p.right = Void
				loop
					p := p.right
				end
				active := p
				internal_after := False
				internal_before := False
			else
				internal_before := True
				internal_after := False
			end
		ensure then
			Empty_convention: is_empty implies before
		end

	go_i_th (i: INTEGER) is
		indexing
			description: "Move cursor to `i'-th position."
		do
			if i = 0 then
				internal_before := True
				internal_after := False
				active := first_element
			elseif i = count + 1 then
				internal_before := False
				internal_after := True
				active := last_element
			else
				move (i - index)
			end
		end

	go_to (p: CURSOR) is
		indexing
			description: "Move cursor to position `p'."
		local
			ll_c: LINKED_LIST_CURSOR [G]
		do
			ll_c ?= p
				check
					ll_c /= Void
				end
			internal_after := ll_c.after
			internal_before := ll_c.before
			if before then
				active := first_element
			elseif after then
				active := last_element
			else
				active := ll_c.active
			end
		end

	move (i: INTEGER) is
		indexing
			description: "[
						Move cursor `i' positions. The cursor
						may end up `off' if the absolute value of `i'
						is too big.
					  ]"
		local
			counter, new_index: INTEGER
			p: LINKABLE [G]
		do
			if i > 0 then
				if before then
					internal_before := False
					counter := 1
				end
				from
					p := active
				until
					(counter = i) or else (p = Void)
				loop
					active := p
					p := p.right
					counter := counter + 1
				end
				if p = Void then
					internal_after := True
				else
					active := p
				end
			elseif i < 0 then
				new_index := index + i
				internal_before := True
				internal_after := False
				active := first_element
				if (new_index > 0) then
					move (new_index)
				end
			end
		ensure then
	 		moved_if_inbounds:
	 			((old index + i) >= 0 and
	 			(old index + i) <= (count + 1))
	 				implies index = (old index + i)
	 		before_set: (old index + i) <= 0 implies before
	 		after_set: (old index + i) >= (count + 1) implies after
		end

feature -- Measurement

	count: INTEGER is
		indexing
			description: "Number of items"
		do
			Result := internal_count
		end

feature -- Element change

	extend (v: G) is
		indexing
			description: "Add a new occurrence of `v'."
		local
			p: LINKABLE [G]
		do
			p := new_cell (v)
			if is_empty then
				first_element := p
				active := p
			else
				last_element.put_right (p)
				if after then active := p end
			end
			internal_count := count + 1
		end

	replace (v: G) is
		indexing
			description: "Replace current item by `v'."
		do
			active.put (v)
		end

	put_front (v: G) is
		indexing
			description: "Add `v' at beginning. Do not move cursor."
		local
			p: LINKABLE [G]
		do
			p := new_cell (v)
			p.put_right (first_element)
			first_element := p
			if before or is_empty then
				active := p
			end
			internal_count := count + 1
		end

	put_left (v: G) is
		indexing
			description: "Add `v' to the left of cursor position. Do not move cursor."
		local
			p: LINKABLE [G]
		do
			if is_empty then
				put_front (v)
			elseif after then
				back
				put_right (v)
				move (2)
			else
				p := new_cell (active.item)
				p.put_right (active.right)
				active.put (v)
				active.put_right (p)
				active := p
				internal_count := count + 1
			end
		ensure then
			previous_exists: previous /= Void
			item_inserted: previous.item = v
		end

	put_right (v: G) is
		indexing
			description: "Add `v' to the right of cursor position. Do not move cursor."
		local
			p: LINKABLE [G]
		do
			p := new_cell (v)
			check is_empty implies before end
			if before then
				p.put_right (first_element)
				first_element := p
				active := p
			else
				p.put_right (active.right)
				active.put_right (p)
			end
			internal_count := count + 1
		ensure then
			next_exists: next /= Void
			item_inserted: not old before implies next.item = v
			item_inserted_before: old before implies active.item = v
		end

	merge_left (other: LINKED_LIST [G]) is
		indexing
			description: "[
						Merge `other' into current structure before cursor
						position. Do not move cursor. Empty `other'.
					  ]"
		local
			other_first_element: LINKABLE [G]
			other_last_element: LINKABLE [G]
			p: LINKABLE [G]
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
					first_element := other_first_element
					active := first_element
				elseif isfirst then
					p := first_element
					other_last_element.put_right (p)
					first_element := other_first_element
				else
					p := previous
					if p /= Void then
						p.put_right (other_first_element)
					end
					other_last_element.put_right (active)
				end
				internal_count := count + other_count
				other.wipe_out
			end
		end

	merge_right (other: LINKED_LIST [G]) is
		indexing
			description: "[
						Merge `other' into current structure after cursor
						position. Do not move cursor. Empty `other'.
					  ]"
		local
			other_first_element: LINKABLE [G]
			other_last_element: LINKABLE [G]
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
					first_element := other_first_element
					active := first_element
				else
					if not islast then
						other_last_element.put_right (active.right)
					end
					active.put_right (other_first_element)
				end
				internal_count := count + other_count
				other.wipe_out
			end
		end
		
feature -- Removal

	prune (v: G) is
		indexing
			description: "[
						Remove first occurrence of `v', if any,
						after cursor position.
						If found, move cursor to right neighbor;
						if not, make structure `exhausted'.
					  ]"
		do
			search (v)
			if not exhausted then
				remove
			end
		end

	remove is
		indexing
			description: "[
						Remove current item.
						Move cursor to right neighbor
						(or `after' if no right neighbor).
					  ]"
		local
			removed, succ: LINKABLE [G]
		do
			removed := active
			if isfirst then
				first_element := first_element.right
				active.forget_right
				active := first_element
				if count = 1 then
					check
						no_active: active = Void
					end
					internal_after := True
				end
			elseif islast then
				active := previous
				if active /= Void then
					active.forget_right
				end
				internal_after := True
			else
				succ := active.right
				previous.put_right (succ)
				active.forget_right
				active := succ
			end
			internal_count := count - 1
			cleanup_after_remove (removed)
		end

	remove_left is
		indexing
			description: "Remove item to the left of cursor position. Do not move cursor."
		do
			move (-2)
			remove_right
			forth
		end

	remove_right is
		indexing
			description: "[
						Remove item to the right of cursor position.
						Do not move cursor.
					  ]"
		local
			removed, succ: LINKABLE [G]
		do
			if before then
				removed := first_element
				first_element := first_element.right
				active.forget_right
				active := first_element
			else
				succ := active.right
				removed := succ
				active.put_right (succ.right)
				succ.forget_right
			end
			internal_count := count - 1
			cleanup_after_remove (removed)
		end

	wipe_out is
		indexing
			description: "Remove all items."
		do
			active := Void
			first_element := Void
			internal_before := True
			internal_after := False
			internal_count := 0
		end

feature -- Duplication

	copy (other: LINKED_LIST [G]) is
		indexing
			description: "[
						Update current object using fields of object attached
						to `other', so as to yield equal objects.
					  ]"
		require
			other_not_void: other /= void
			type_identity: get_type.is_equal (other.get_type)
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
		ensure
			is_equal: is_equal (other)
		end

feature {LINKED_LIST} -- Implementation

	new_chain: LINKED_LIST [G] is
		indexing
			description: "[
						A newly created instance of the same type.
						This feature may be redefined in descendants so as to
						produce an adequately allocated and initialized object.
					  ]"
		do
			create Result.make
		end

	new_cell (v: G): LINKABLE [G] is
		indexing
			description: "[
						A newly created instance of the same type as `first_element'.
						This feature may be redefined in descendants so as to
						produce an adequately allocated and initialized object.
					  ]"
		do
			create Result
			Result.put (v)
		ensure
			result_exists: Result /= Void
		end

	previous: LINKABLE [G] is
		indexing
			description: "Element left of cursor"
		local
			p: LINKABLE [G]
		do
			if after then
				Result := active
			elseif not (isfirst or before) then
				from
					p := first_element
				until
					p.right = active
				loop
					p := p.right
				end
				Result := p
			end
		end

	next: LINKABLE [G] is
		indexing
			description: "Element right of cursor"
		do
			if before then
				Result := active
			elseif active /= Void then
				Result := active.right
			end
		end

	active: LINKABLE [G]
		indexing
			description: "Element at cursor position"
		end

	first_element: LINKABLE [G]
		indexing
			description: "Head of list"
		end

	last_element: LINKABLE [G] is
		indexing
			description: "Tail of list"
		local
			p: LINKABLE [G]
		do
			if not is_empty then
				from
					Result := active
					p := active.right
				until
					p = Void
				loop
					Result := p
					p := p.right
				end
			end
		end

	cleanup_after_remove (v: LINKABLE [G]) is
		indexing
			description: "Clean-up a just removed cell."
		require
			non_void_cell: v /= Void
		do
		end

feature {NONE} -- Implementation

	internal_after, internal_before: BOOLEAN
	
	internal_count: INTEGER

invariant

	prunable: prunable
	empty_constraint: is_empty implies ((first_element = Void) and 
				(active = Void))
	not_void_unless_empty: (active = Void) implies is_empty
	before_constraint: before implies (active = first_element)
	after_constraint: after implies (active = last_element)

end -- class LINKED_LIST
