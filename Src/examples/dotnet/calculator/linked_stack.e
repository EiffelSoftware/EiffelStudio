indexing
	"Unbounded stacks implemented as linked lists"
	status: "See notice at end of class"
	names: linked_stack, dispenser, linked_list
	representation: linked
	access: fixed, lifo, membership
	contents: generic
	date: "$Date$"
	revision: "$Revision$"

class LINKED_STACK [G]

create 
	make

feature {ANY} -- Initialization

	make is
			-- Create an empty list.
			-- (from LINKED_LIST)
		do
			before := True
		ensure -- from LINKED_LIST
			is_before: before
		end
	
feature -- Access

	has (v: like ll_item): BOOLEAN is
			-- Does chain include `v'?
		local
			pos: LINKED_LIST_CURSOR [G]
		do
			pos := cursor
			Result := sequential_has (v)
			go_to (pos)
		ensure -- from CONTAINER
			not_found_in_empty: Result implies not empty
		end

	item: G is
			-- Item at the first position
		require -- from ACTIVE
			readable: readable
		do
			check
				not_empty: not empty
			end
			Result := first_element.item
		end
	
feature {NONE} -- Access

	cursor: LINKED_LIST_CURSOR [G] is
			-- Current cursor position
			-- (from LINKED_LIST)
		do
			create Result.make (active, after, before)
		end

	first: like ll_item is
			-- Item at first position
			-- (from LINKED_LIST)
		require -- from CHAIN
			not_empty: not empty
		do
			Result := first_element.item
		end

	search (v: like ll_item) is
			-- Move to first position (at or after current
			-- position) where `item' and `v' are equal.
			-- If structure does not include `v' ensure that
			-- `exhausted' will be true.
		do
			if before and not empty then
				forth
			end
			sequential_search (v)
		ensure -- from LINEAR
			item_found: (not exhausted) implies v = ll_item
		end;

	sequential_has (v: like ll_item): BOOLEAN is
			-- Does structure include an occurrence of `v'?
			-- (from LINEAR)
		do
			start
			if not off then
				search (v)
			end
			Result := not exhausted
		ensure -- from CONTAINER
			not_found_in_empty: Result implies not empty
		end

	i_th (i: INTEGER): like ll_item is
			-- Item at `i'-th position
			-- Was declared in CHAIN as synonym of `i_th' and `@'.
			-- (from CHAIN)
		require -- from TABLE
			valid_key: valid_index (i)
		local
			pos: LINKED_LIST_CURSOR [G]
		do
			pos := cursor
			go_i_th (i)
			Result := ll_item
			go_to (pos)
		end

	index: INTEGER is
			-- Index of current position
			-- (from LINKED_LIST)
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

	sequential_index_of (v: like ll_item; i: INTEGER): INTEGER is
			-- Index of `i'-th occurrence of `v'.
			-- 0 if none.
		require
			positive_occurrences: i > 0
		local
			occur, pos: INTEGER
		do
			from
				start
				pos := 1
			until
				off or (occur = i)
			loop
				if ll_item = v then
					occur := occur + 1
				end
				forth
				pos := pos + 1
			end
			if occur = i then
				Result := pos - 1
			end
		ensure -- from LINEAR
			non_negative_result: Result >= 0
		end

	index_of (v: like ll_item; i: INTEGER): INTEGER is
			-- Index of `i'-th occurrence of item identical to `v'.
			-- 0 if none.
		require -- from LINEAR
			positive_occurrences: i > 0
		local
			pos: LINKED_LIST_CURSOR [G]
		do
			pos := cursor
			Result := sequential_index_of (v, i)
			go_to (pos)
		ensure -- from LINEAR
			non_negative_result: Result >= 0
		end

	ll_item: G is
			-- Current item
			-- (from LINKED_LIST)
		require -- from ACTIVE
			readable: readable
			not_off: not off
		do
			Result := active.item
		end

	last: like ll_item is
			-- Item at last position
			-- (from LINKED_LIST)
		require -- from CHAIN
			not_empty: not empty
		do
			Result := last_element.item
		end

	sequential_search (v: like ll_item) is
			-- Move to first position (at or after current
			-- position) where `item' and `v' are equal.
			-- If no such position ensure that `exhausted' will be true.
			-- (from LINEAR)
			-- (export status {NONE})
		do
			from
			until
				exhausted or else v = ll_item
			loop
				forth
			end
		ensure -- from LINEAR
			item_found: (not exhausted) implies v = ll_item
		end;

	sequential_occurrences (v: G): INTEGER is
			-- Number of times `v' appears.
		do
			from
				start
				search (v)
			until
				exhausted
			loop
				Result := Result + 1
				forth
				search (v)
			end
		ensure -- from BAG
			non_negative_occurrences: Result >= 0
		end

	infix "@" (i: INTEGER): like ll_item is
			-- Item at `i'-th position
			-- Was declared in CHAIN as synonym of `i_th' and `@'.
			-- (from CHAIN)
		require -- from TABLE
			valid_key: valid_index (i)
		local
			pos: LINKED_LIST_CURSOR [G]
		do
			pos := cursor
			go_i_th (i)
			Result := ll_item
			go_to (pos)
		end
	
feature -- Measurement

	count: INTEGER
			-- Number of items
			-- (from LINKED_LIST)

	occurrences (v: like ll_item): INTEGER is
			-- Number of times `v' appears.
		local
			pos: LINKED_LIST_CURSOR [G]
		do
			pos := cursor
			Result := sequential_occurrences (v)
			go_to (pos)
		ensure -- from BAG
			non_negative_occurrences: Result >= 0
		end
	
feature -- Status report

	empty: BOOLEAN is
			-- Is structure empty?
			-- (from FINITE)
		do
			Result := (count = 0)
		end

	Extendible: BOOLEAN is True
			-- May new items be added? (Answer: yes.)
			-- (from DYNAMIC_CHAIN)

	Full: BOOLEAN is False
			-- Is structured filled to capacity? (Answer: no.)
			-- (from LINKED_LIST)

	prunable: BOOLEAN is
			-- May items be removed? (Answer: yes.)
			-- (from DYNAMIC_CHAIN)
		do
			Result := True
		end

	readable: BOOLEAN is
			-- Is there a current item that may be read?
			-- (from DISPENSER)
		do
			Result := not empty
		end

	writable: BOOLEAN is
			-- Is there a current item that may be modified?
			-- (from DISPENSER)
		do
			Result := not empty
		end
	
feature {NONE} -- Status report

	after: BOOLEAN
			-- Is there no valid cursor position to the right of cursor?
			-- (from LINKED_LIST)

	before: BOOLEAN
			-- Is there no valid cursor position to the left of cursor?
			-- (from LINKED_LIST)

	exhausted: BOOLEAN is
			-- Has structure been completely explored?
			-- (from LINEAR)
		do
			Result := off
		ensure -- from LINEAR
			exhausted_when_off: off implies Result
		end

	isfirst: BOOLEAN is
			-- Is cursor at first position?
			-- (from LINKED_LIST)
		do
			Result := not after and not before and (active = first_element)
		ensure -- from CHAIN
			valid_position: Result implies not empty
		end

	islast: BOOLEAN is
			-- Is cursor at last position?
			-- (from LINKED_LIST)
		do
			Result := not after and not before and (active /= Void) and then (active.right = Void)
		ensure -- from CHAIN
			valid_position: Result implies not empty
		end

	off: BOOLEAN is
			-- Is there no current item?
			-- (from LINKED_LIST)
		do
			Result := after or before
		end

	valid_cursor (p: LINKED_LIST_CURSOR [G]): BOOLEAN is
			-- Can the cursor be moved to position `p'?
			-- (from LINKED_LIST)
		local
			ll_c: LINKED_LIST_CURSOR [G]
			temp, sought: like first_element
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

	valid_cursor_index (i: INTEGER): BOOLEAN is
			-- Is `i' correctly bounded for cursor movement?
			-- (from CHAIN)
		do
			Result := (i >= 0) and (i <= count + 1)
		ensure -- from CHAIN
			valid_cursor_index_definition: Result = ((i >= 0) and (i <= count + 1))
		end

	valid_index (i: INTEGER): BOOLEAN is
			-- Is `i' within allowable bounds?
			-- (from CHAIN)
		do
			Result := (i >= 1) and (i <= count)
		ensure then -- from INDEXABLE
			valid_index_definition: Result = ((i >= 1) and (i <= count))
		end
	
feature {NONE} -- Cursor movement

	back is
			-- Move to previous item.
			-- (from LINKED_LIST)
		require -- from BILINEAR
			not_before: not before
		do
			if empty then
				before := True
				after := False
			elseif after then
				after := False
			elseif isfirst then
				before := True
			else
				active := previous
			end
		ensure then -- from BILINEAR
			moved_back: index = old index - 1
		end

	finish is
			-- Move cursor to last position.
			-- (Go before if empty)
			-- (from LINKED_LIST)
		local
			p: like first_element
		do
			if not empty then
				from
					p := active
				until
					p.right = Void
				loop
					p := p.right
				end
				active := p
				after := False
				before := False
			else
				before := True
				after := False
			end
		ensure then -- from CHAIN
			at_last: not empty implies islast
			empty_convention: empty implies before
		end

	forth is
			-- Move cursor to next position.
			-- (from LINKED_LIST)
		require -- from LINEAR
			not_after: not after
		local
			old_active: like first_element
		do
			if before then
				before := False
				if empty then
					after := True
				end
			else
				old_active := active
				active := active.right
				if active = Void then
					active := old_active
					after := True
				end
			end
		ensure then -- from LIST
			moved_forth: index = old index + 1
		end

	go_i_th (i: INTEGER) is
			-- Move cursor to `i'-th position.
			-- (from LINKED_LIST)
		require -- from CHAIN
			valid_cursor_index: valid_cursor_index (i)
		do
			if i = 0 then
				before := True
				after := False
				active := first_element
			elseif i = count + 1 then
				before := False
				after := True
				active := last_element
			else
				move (i - index)
			end
		ensure -- from CHAIN
			position_expected: index = i
		end

	go_to (p: LINKED_LIST_CURSOR [G]) is
			-- Move cursor to position `p'.
			-- (from LINKED_LIST)
		require -- from CURSOR_STRUCTURE
			cursor_position_valid: valid_cursor (p)
		local
			ll_c: LINKED_LIST_CURSOR [G]
		do
			ll_c ?= p
			check
				ll_c /= Void
			end
			after := ll_c.after
			before := ll_c.before
			if before then
				active := first_element
			elseif after then
				active := last_element
			else
				active := ll_c.active
			end
		end

	move (i: INTEGER) is
			-- Move cursor `i' positions. The cursor
			-- may end up `off' if the offset is too big.
			-- (from LINKED_LIST)
		local
			counter, new_index: INTEGER
			p: like first_element
		do
			if i > 0 then
				if before then
					before := False
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
					after := True
				else
					active := p
				end
			elseif i < 0 then
				new_index := index + i
				before := True
				after := False
				active := first_element
				if (new_index > 0) then
					move (new_index)
				end
			end
		ensure -- from CHAIN
			too_far_right: (old index + i > count) implies exhausted
			too_far_left: (old index + i < 1) implies exhausted
			expected_index: (not exhausted) implies (index = old index + i)
			moved_if_inbounds: ((old index + i) >= 0 and (old index + i) <= (count + 1)) implies index = (old index + i)
			before_set: (old index + i) <= 0 implies before
			after_set: (old index + i) >= (count + 1) implies after
		end

	start is
			-- Move cursor to first position.
			-- (from LINKED_LIST)
		do
			if first_element /= Void then
				active := first_element
				after := False
			else
				after := True
			end
			before := False
		ensure then -- from CHAIN
			at_first: not empty implies isfirst
			empty_convention: empty implies after
		end
	
feature -- Element change

	extend (v: like item) is
			-- Push `v' onto top.
		require -- from COLLECTION
			extendible: extendible
		do
			put_front (v)
		ensure -- from COLLECTION
			item_inserted: has (v)
			one_more_occurrence: occurrences (v) = old (occurrences (v)) + 1
			item_pushed: item = v
		end

	force (v: like item) is
			-- Push `v' onto top.
		require -- from SEQUENCE
			extendible: extendible
		do
			put_front (v)
		ensure then -- from SEQUENCE
			new_count: count = old count + 1
			item_inserted: has (v)
			item_pushed: item = v
		end

	put (v: like item) is
		require -- from COLLECTION
			extendible: extendible
		do
			put_front (v)
		ensure -- from COLLECTION
			item_inserted: has (v)
			item_pushed: item = v
		end

	replace (v: like ll_item) is
			-- Replace current item by `v'.
			-- (from LINKED_LIST)
		require -- from ACTIVE
			writable: writable
		do
			active.put (v)
		ensure -- from ACTIVE
			item_replaced: item = v
		end
	
feature {NONE} -- Element change

	merge_left (other: like Current) is
			-- Merge `other' into current structure before cursor
			-- position. Do not move cursor. Empty `other'.
			-- (from LINKED_LIST)
		require -- from DYNAMIC_CHAIN
			extendible: extendible
			not_off: not before
			other_exists: other /= Void
		local
			other_first_element: like first_element
			other_last_element: like first_element
			p: like first_element
			other_count: INTEGER
		do
			if not other.empty then
				other_first_element := other.first_element
				other_last_element := other.last_element
				other_count := other.count
				check
					other_first_element /= Void
					other_last_element /= Void
				end
				if empty then
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
				count := count + other_count
				other.wipe_out
			end
		ensure -- from DYNAMIC_CHAIN
			new_count: count = old count + old other.count
			new_index: index = old index + old other.count
			other_is_empty: other.empty
		end

	merge_right (other: like Current) is
			-- Merge `other' into current structure after cursor
			-- position. Do not move cursor. Empty `other'.
			-- (from LINKED_LIST)
		require -- from DYNAMIC_CHAIN
			extendible: extendible
			not_off: not after
			other_exists: other /= Void
		local
			other_first_element: like first_element
			other_last_element: like first_element
			p: like first_element
			other_count: INTEGER
		do
			if not other.empty then
				other_first_element := other.first_element
				other_last_element := other.last_element
				other_count := other.count
				check
					other_first_element /= Void
					other_last_element /= Void
				end
				if empty then
					first_element := other_first_element
					active := first_element
				else
					if not islast then
						other_last_element.put_right (active.right)
					end
					active.put_right (other_first_element)
				end
				count := count + other_count
				other.wipe_out
			end
		ensure -- from DYNAMIC_CHAIN
			new_count: count = old count + old other.count
			same_index: index = old index
			other_is_empty: other.empty
		end

	ll_put (v: like ll_item) is
			-- Replace current item by `v'.
			-- (Synonym for `replace')
			-- (from CHAIN)
		require -- from COLLECTION
			extendible: extendible
		do
			replace (v)
		ensure -- from COLLECTION
			item_inserted: has (v)
			same_count: count = old count
		end

	sequence_put (v: like ll_item) is
			-- Add `v' to end.
			-- (from SEQUENCE)
		require -- from COLLECTION
			extendible: extendible
		do
			extend (v)
		ensure -- from COLLECTION
			item_inserted: has (v)
			new_count: count = old count + 1
		end

	put_front (v: like ll_item) is
			-- Add `v' to beginning.
			-- Do not move cursor.
			-- (from LINKED_LIST)
		local
			p: like first_element
		do
			p := new_cell (v)
			p.put_right (first_element)
			first_element := p
			if before or empty then
				active := p
			end
			count := count + 1
		ensure -- from DYNAMIC_CHAIN
			new_count: count = old count + 1
			item_inserted: first = v
		end

	put_i_th (v: like ll_item; i: INTEGER) is
			-- Put `v' at `i'-th position.
			-- (from CHAIN)
		require -- from TABLE
			valid_key: valid_index (i)
		local
			pos: LINKED_LIST_CURSOR [G]
		do
			pos := cursor
			go_i_th (i)
			replace (v)
			go_to (pos)
		ensure then -- from INDEXABLE
			insertion_done: i_th (i) = v
		end

	put_left (v: like ll_item) is
			-- Add `v' to the left of cursor position.
			-- Do not move cursor.
			-- (from LINKED_LIST)
		require -- from DYNAMIC_CHAIN
			extendible: extendible
			not_before: not before
		local
			p: like first_element
		do
			if empty then
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
				count := count + 1
			end
		ensure -- from DYNAMIC_CHAIN
			new_count: count = old count + 1
			new_index: index = old index + 1
			previous_exists: previous /= Void
			item_inserted: previous.item = v
		end

	put_right (v: like ll_item) is
			-- Add `v' to the right of cursor position.
			-- Do not move cursor.
			-- (from LINKED_LIST)
		require -- from DYNAMIC_CHAIN
			extendible: extendible
			not_after: not after
		local
			p: like first_element
		do
			p := new_cell (v)
			check
				empty implies before
			end
			if before then
				p.put_right (first_element)
				first_element := p
				active := p
			else
				p.put_right (active.right)
				active.put_right (p)
			end
			count := count + 1
		ensure -- from DYNAMIC_CHAIN
			new_count: count = old count + 1
			same_index: index = old index
			next_exists: next /= Void
			item_inserted: not old before implies next.item = v
			item_inserted_before: old before implies active.item = v
		end
	
feature -- Removal

	remove is
			-- Remove item on top.
		require -- from ACTIVE
			prunable: prunable
			writable: writable
		do
			start
			ll_remove
		end

	wipe_out is
			-- Remove all items.
			-- (from LINKED_LIST)
		require -- from COLLECTION
			prunable
		do
			active := Void
			first_element := Void
			before := True
			after := False
			count := 0
		ensure then -- from DYNAMIC_LIST
			is_before: before
			wiped_out: empty
		end
	
feature {NONE} -- Removal

	prune (v: like ll_item) is
			-- Remove first occurrence of `v', if any,
			-- after cursor position.
			-- If found, move cursor to right neighbor
			-- if not, make structure `exhausted'.
			-- (from DYNAMIC_CHAIN)
		require -- from COLLECTION
			prunable: prunable
		do
			search (v)
			if not exhausted then
				remove
			end
		end

	prune_all (v: G) is
			-- Remove all occurrences of `v'.
		require -- from COLLECTION
			prunable
		do
			from
			until
				not has (v)
			loop
				prune (v)
			end
		ensure -- from COLLECTION
			no_more_occurrences: not has (v)
			is_exhausted: exhausted
			no_more_occurrences: not has (v)
		end

	ll_remove is
			-- Remove current item.
			-- Move cursor to right neighbor
			-- (or `after' if no right neighbor).
			-- (from LINKED_LIST)
		require -- from ACTIVE
			prunable: prunable
			writable: writable
		local
			removed, succ: like first_element
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
					after := True
				end
			elseif islast then
				active := previous
				if active /= Void then
					active.forget_right
				end
				after := True
			else
				succ := active.right
				previous.put_right (succ)
				active.forget_right
				active := succ
			end
			count := count - 1
			cleanup_after_remove (removed)
		ensure then -- from DYNAMIC_LIST
			after_when_empty: empty implies after
		end

	remove_left is
			-- Remove item to the left of cursor position.
			-- Do not move cursor.
			-- (from LINKED_LIST)
		require -- from DYNAMIC_CHAIN
			left_exists: index > 1
			not_before: not before
		do
			move (- 2)
			remove_right
			forth
		ensure -- from DYNAMIC_CHAIN
			new_count: count = old count - 1
			new_index: index = old index - 1
		end

	remove_right is
			-- Remove item to the right of cursor position.
			-- Do not move cursor.
			-- (from LINKED_LIST)
		require -- from DYNAMIC_CHAIN
			right_exists: index < count
		local
			removed, succ: like first_element
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
			count := count - 1
			cleanup_after_remove (removed)
		ensure -- from DYNAMIC_CHAIN
			new_count: count = old count - 1
			same_index: index = old index
		end

	chain_wipe_out is
			-- Remove all items.
			-- (from DYNAMIC_CHAIN)
		require -- from COLLECTION
			prunable
		do
			from
				start
			until
				empty
			loop
				remove
			end
		ensure -- from COLLECTION
			wiped_out: empty
		end
	
feature {NONE} -- Transformation

	swap (i: INTEGER) is
			-- Exchange item at `i'-th position with item
			-- at cursor position.
			-- (from CHAIN)
		require -- from CHAIN
			not_off: not off
			valid_index: valid_index (i)
		local
			old_item, new_item: like ll_item
			pos: LINKED_LIST_CURSOR [G]
		do
			pos := cursor
			old_item := ll_item
			go_i_th (i)
			new_item := ll_item
			replace (old_item)
			go_to (pos)
			replace (new_item)
		ensure -- from CHAIN
			swapped_to_item: ll_item = old i_th (i)
			swapped_from_item: i_th (i) = old ll_item
		end
	
feature -- Duplication

-- 	duplicate (n: INTEGER): like Current is
-- 			-- New stack containing the `n' latest items inserted
-- 			-- in current stack.
-- 			-- If `n' is greater than `count', identical to current stack.
-- 		require -- from CHAIN
-- 			not_off_unless_after: off implies after
-- 			valid_subchain: n >= 0
-- 			positive_argument: n > 0
-- 		local
-- 			counter: INTEGER
-- 			old_cursor: LINKED_LIST_CURSOR [G]
-- 			list: LINKED_STACK [G]
-- 		do
-- 			if not empty then
-- 				old_cursor := cursor
-- 				from
-- 					create Result.make
-- 					list := Result
-- 					start
-- 				until
-- 					after or counter = n
-- 				loop
-- 					list.finish
-- 					list.put_right (ll_item)
-- 					counter := counter + 1
-- 					forth
-- 				end
-- 				go_to (old_cursor)
-- 			end
-- 		end
	
feature {NONE} -- Inapplicable

	bag_put (v: G) is
			-- (from TABLE)
		require -- from COLLECTION
			extendible: extendible
		do
		ensure -- from COLLECTION
			item_inserted: has (v)
		end
	
feature {LINKED_STACK} -- Implementation

	active: like first_element
			-- Element at cursor position
			-- (from LINKED_LIST)

	cleanup_after_remove (v: like first_element) is
			-- Clean-up a just removed cell.
			-- (from LINKED_LIST)
		require -- from LINKED_LIST
			non_void_cell: v /= Void
		do
		end

	first_element: LINKABLE [G]
			-- Head of list
			-- (from LINKED_LIST)

	last_element: like first_element is
			-- Tail of list
			-- (from LINKED_LIST)
		local
			p: like first_element
		do
			if not empty then
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

	new_cell (v: like ll_item): like first_element is
			-- A newly created instance of the same type as `first_element'.
			-- This feature may be redefined in descendants so as to
			-- produce an adequately allocated and initialized object.
			-- (from LINKED_LIST)
		local
			i: LINKABLE [G]
		do
			create i
			Result := i
			Result.put (v)
		ensure -- from LINKED_LIST
			result_exists: Result /= Void
		end

	new_chain: like Current is
			-- A newly created instance of the same type.
			-- This feature may be redefined in descendants so as to
			-- produce an adequately allocated and initialized object.
			-- (from LINKED_LIST)
		do
			create Result.make
		ensure -- from DYNAMIC_CHAIN
			result_exists: Result /= Void
		end

	next: like first_element is
			-- Element right of cursor
			-- (from LINKED_LIST)
		do
			if before then
				Result := active
			elseif active /= Void then
				Result := active.right
			end
		end

	previous: like first_element is
			-- Element left of cursor
			-- (from LINKED_LIST)
		local
			p: like first_element
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
	
invariant

		-- from DISPENSER
	readable_definition: readable = not empty
	writable_definition: writable = not empty
		-- from ACTIVE
	writable_constraint: writable implies readable
	empty_constraint: empty implies (not readable) and (not writable)
		-- from FINITE
	empty_definition: empty = (count = 0)
	non_negative_count: count >= 0
		-- from LINKED_LIST
	prunable: prunable
	empty_constraint: empty implies ((first_element = Void) and (active = Void))
	not_void_unless_empty: (active = Void) implies empty
	before_constraint: before implies (active = first_element)
	after_constraint: after implies (active = last_element)
		-- from LIST
	before_definition: before = (index = 0)
	after_definition: after = (index = count + 1)
		-- from CHAIN
	non_negative_index: index >= 0
	index_small_enough: index <= count + 1
	off_definition: off = ((index = 0) or (index = count + 1))
	isfirst_definition: isfirst = ((not empty) and (index = 1))
	islast_definition: islast = ((not empty) and (index = count))
	item_corresponds_to_index: (not off) implies (ll_item = i_th (index))
		-- from BILINEAR
	not_both: not (after and before)
	empty_property: empty implies (after or before)
	before_constraint: before implies off
		-- from LINEAR
	after_constraint: after implies off
		-- from TRAVERSABLE
	empty_constraint: empty implies off
		-- from DYNAMIC_CHAIN
	extendible: extendible

end -- class LINKED_STACK


