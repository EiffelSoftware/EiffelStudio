indexing
	description: "Unbounded stacks implemented as linked lists"
	external_name: "ISE.Examples.Calculator.LinkedStack"
	
class 
	LINKED_STACK [G]

create 
	make

feature {ANY} -- Initialization

	make is
		indexing
			description: "Create an empty list."
			external_name: "Make"
		do
			before := True
		ensure
			is_before: before
		end
	
feature -- Access

	item: G is
		indexing
			description: "Item at the first position"
			external_name: "Item"
		require 
			readable: readable
		do
			check
				not_empty: not empty
			end
			Result := first_element.item
		end

feature -- Status Report

	has (v: like ll_item): BOOLEAN is
		indexing
			description: "Does chain include `v'?"
			external_name: "Has"
		require
			non_void_item: v /= Void
		local
			pos: LINKED_LIST_CURSOR [G]
		do
			pos := cursor
			Result := sequential_has (v)
			go_to (pos)
		ensure 
			not_found_in_empty: Result implies not empty
		end
	
feature -- Measurement

	count: INTEGER
		indexing
			description: "Number of items"
			external_name: "Count"
		end

	occurrences (v: like ll_item): INTEGER is
		indexing
			description: "Number of times `v' appears"
			external_name: "Occurrences"
		require
			non_void_item: v /= Void
		local
			pos: LINKED_LIST_CURSOR [G]
		do
			pos := cursor
			Result := sequential_occurrences (v)
			go_to (pos)
		ensure 
			non_negative_occurrences: Result >= 0
		end
	
feature -- Status report

	empty: BOOLEAN is
		indexing
			description: "Is structure empty?"
			external_name: "Empty"
		do
			Result := (count = 0)
		end

	Extendible: BOOLEAN is True
		indexing
			description: "May new items be added? (Answer: yes.)"
			external_name: "Extendible"
		end
		
	Full: BOOLEAN is False
		indexing
			description: "Is structured filled to capacity? (Answer: no.)"
			external_name: "Full"
		end

	prunable: BOOLEAN is
		indexing
			description: "May items be removed? (Answer: yes.)"
			external_name: "Prunable"
		do
			Result := True
		end

	readable: BOOLEAN is
		indexing
			description: "Is there a current item that may be read?"
			external_name: "Readable"
		do
			Result := not empty
		end

	writable: BOOLEAN is
		indexing
			description: "Is there a current item that may be modified?"
			external_name: "Writable"
		do
			Result := not empty
		end

feature -- Element change

	extend (v: like item) is
		indexing
			description: "Push `v' onto top."
			external_name: "Extend"
		require 
			extendible: extendible
		do
			put_front (v)
		ensure
			item_inserted: has (v)
			one_more_occurrence: occurrences (v) = old (occurrences (v)) + 1
			item_pushed: item = v
		end

	force (v: like item) is
		indexing
			description: "Push `v' onto top."
			external_name: "Force"
		require 
			extendible: extendible
		do
			put_front (v)
		ensure then 
			new_count: count = old count + 1
			item_inserted: has (v)
			item_pushed: item = v
		end

	put (v: like item) is
		indexing
			description: "Put `v' at the front."
			external_name: "Put"
		require 
			extendible: extendible
		do
			put_front (v)
		ensure 
			item_inserted: has (v)
			item_pushed: item = v
		end

	replace (v: like ll_item) is
		indexing
			description: "Replace current item by `v'."
			external_name: "Replace"
		require 
			writable: writable
		do
			active.put (v)
		ensure 
			item_replaced: item = v
		end

feature -- Removal

	remove is
		indexing
			description: "Remove item on top."
			external_name: "Remove"
		require 
			prunable: prunable
			writable: writable
		do
			start
			ll_remove
		end

	wipe_out is
		indexing
			description: "Remove all items."
			external_name: "WipeOut"
		require
			prunable
		do
			active := Void
			first_element := Void
			before := True
			after := False
			count := 0
		ensure then 
			is_before: before
			wiped_out: empty
		end
		
feature {NONE} -- Access

	cursor: LINKED_LIST_CURSOR [G] is
		indexing
			description: "Current cursor position"
			external_name: "Cursor"
		do
			create Result.make (active, after, before)
		ensure
			cursor_created: Result /= Void
		end

	first: like ll_item is
		indexing
			description: "Item at first position"
			external_name: "First"
		require 
			not_empty: not empty
		do
			Result := first_element.item
		end

	search (v: like ll_item) is
		indexing
			description: "[Move to first position (at or after current%
						%position) where `item' and `v' are equal.%
						%If structure does not include `v' ensure that%
						%`exhausted' will be true.]"
			external_name: "Search"
		do
			if before and not empty then
				forth
			end
			sequential_search (v)
		ensure 
			item_found: (not exhausted) implies v = ll_item
		end

	sequential_has (v: like ll_item): BOOLEAN is
		indexing
			description: "Does structure include an occurrence of `v'?"
			external_name: "SequentialHas"
		require
			non_void_item: v /= Void
		do
			start
			if not off then
				search (v)
			end
			Result := not exhausted
		ensure 
			not_found_in_empty: Result implies not empty
		end

	i_th (i: INTEGER): like ll_item is
		indexing
			description: "Item at `i'-th position"
			external_name: "ITh"
		require 
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
		indexing
			description: "Index of current position"
			external_name: "Index"
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
		indexing
			description: "Index of `i'-th occurrence of `v' (0 if none)"
			external_name: "SequentialIndexOf"
		require
			non_void_item: v /= Void
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
		ensure 
			non_negative_result: Result >= 0
		end

	index_of (v: like ll_item; i: INTEGER): INTEGER is
		indexing
			description: "Index of `i'-th occurrence of item identical to `v' (0 if none)"
			external_name: "IndexOf"
		require 
			positive_occurrences: i > 0
		local
			pos: LINKED_LIST_CURSOR [G]
		do
			pos := cursor
			Result := sequential_index_of (v, i)
			go_to (pos)
		ensure
			non_negative_result: Result >= 0
		end

	ll_item: G is
		indexing
			description: "Current item"
			external_name: "LLItem"
		require
			readable: readable
			not_off: not off
		do
			Result := active.item
		end

	last: like ll_item is
		indexing
			description: "Item at last position"
			external_name: "Last"
		require 
			not_empty: not empty
		do
			Result := last_element.item
		end

	sequential_search (v: like ll_item) is
		indexing
			description: "[Move to first position (at or after current%
						%position) where `item' and `v' are equal.%
						%If no such position ensure that `exhausted' will be true.]"
			external_name: "Description" 
		do
			from
			until
				exhausted or else v = ll_item
			loop
				forth
			end
		ensure 
			item_found: (not exhausted) implies v = ll_item
		end

	sequential_occurrences (v: G): INTEGER is
		indexing
			description: "Number of times `v' appears"
			external_name: "SequentialOccurrences"
		require
			non_void_item: v /= Void
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
		ensure 
			non_negative_occurrences: Result >= 0
		end

	infix "@" (i: INTEGER): like ll_item is
		indexing
			description: "Item at `i'-th position"
			external_name: "ItemAt"
		require 
			valid_key: valid_index (i)
		local
			pos: LINKED_LIST_CURSOR [G]
		do
			pos := cursor
			go_i_th (i)
			Result := ll_item
			go_to (pos)
		end
		
feature {NONE} -- Status report

	after: BOOLEAN
		indexing
			description: "Is there no valid cursor position to the right of cursor?"
			external_name: "After"
		end

	before: BOOLEAN
		indexing
			description: "Is there no valid cursor position to the left of cursor?"
			external_name: "Before"
		end

	exhausted: BOOLEAN is
		indexing
			description: "Has structure been completely explored?"
			external_name: "Exhausted"
		do
			Result := off
		ensure 
			exhausted_when_off: off implies Result
		end

	isfirst: BOOLEAN is
		indexing
			description: "Is cursor at first position?"
			external_name: "IsFirst"
		do
			Result := not after and not before and (active = first_element)
		ensure 
			valid_position: Result implies not empty
		end

	islast: BOOLEAN is
		indexing
			description: "Is cursor at last position?"
			external_name: "IsLast"
		do
			Result := not after and not before and (active /= Void) and then (active.right = Void)
		ensure
			valid_position: Result implies not empty
		end

	off: BOOLEAN is
		indexing
			description: "Is there no current item?"
			external_name: "Off"
		do
			Result := after or before
		end

	valid_cursor (p: LINKED_LIST_CURSOR [G]): BOOLEAN is
		indexing
			description: "Can the cursor be moved to position `p'?"
			external_name: "ValidCursor"
		require
			non_void_cursor: p /= Void
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
		indexing
			description: "Is `i' correctly bounded for cursor movement?"
			external_name: "ValidCursorIndex"
		do
			Result := (i >= 0) and (i <= count + 1)
		ensure
			valid_cursor_index_definition: Result = ((i >= 0) and (i <= count + 1))
		end

	valid_index (i: INTEGER): BOOLEAN is
		indexing
			description: "Is `i' within allowable bounds?"
			external_name: "ValidIndex"
		do
			Result := (i >= 1) and (i <= count)
		ensure then 
			valid_index_definition: Result = ((i >= 1) and (i <= count))
		end
	
feature {NONE} -- Cursor movement

	back is
		indexing
			description: "Move to previous item."
			external_name: "Back"
		require 
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
		ensure then 
			moved_back: index = old index - 1
		end

	finish is
		indexing
			description: "Move cursor to last position. (Go before if empty.)"
			external_name: "Finish"
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
		ensure then 
			at_last: not empty implies islast
			empty_convention: empty implies before
		end

	forth is
		indexing
			description: "Move cursor to next position."
			external_name: "Forth"
		require 
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
		ensure then 
			moved_forth: index = old index + 1
		end

	go_i_th (i: INTEGER) is
		indexing
			description: "Move cursor to `i'-th position."
			external_name: "GoITh"
		require
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
		ensure 
			position_expected: index = i
		end

	go_to (p: LINKED_LIST_CURSOR [G]) is
		indexing
			description: "Move cursor to position `p'."
			external_name: "GoTo"
		require
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
		indexing
			description: "Move cursor `i' positions. The cursor may end up `off' if the offset is too big."
			external_name: "Move"
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
		ensure 
			too_far_right: (old index + i > count) implies exhausted
			too_far_left: (old index + i < 1) implies exhausted
			expected_index: (not exhausted) implies (index = old index + i)
			moved_if_inbounds: ((old index + i) >= 0 and (old index + i) <= (count + 1)) implies index = (old index + i)
			before_set: (old index + i) <= 0 implies before
			after_set: (old index + i) >= (count + 1) implies after
		end

	start is
		indexing
			description: "Move cursor to first position."
			external_name: "Start"
		do
			if first_element /= Void then
				active := first_element
				after := False
			else
				after := True
			end
			before := False
		ensure then 
			at_first: not empty implies isfirst
			empty_convention: empty implies after
		end
	
feature {NONE} -- Element change

	merge_left (other: like Current) is
		indexing
			description: "[Merge `other' into current structure before cursor%
						%position. Do not move cursor. Empty `other'.]"
			external_name: "MergeLeft"
		require 
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
		ensure 
			new_count: count = old count + old other.count
			new_index: index = old index + old other.count
			other_is_empty: other.empty
		end

	merge_right (other: like Current) is
		indexing
			description: "[Merge `other' into current structure after cursor%
						%position. Do not move cursor. Empty `other'.]"
			external_name: "MergeRight"
		require 
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
		ensure 
			new_count: count = old count + old other.count
			same_index: index = old index
			other_is_empty: other.empty
		end

	ll_put (v: like ll_item) is
		indexing
			description: "Replace current item by `v'. (Synonym for `replace')"
			external_name: "LLPut"
		require 
			extendible: extendible
		do
			replace (v)
		ensure 
			item_inserted: has (v)
			same_count: count = old count
		end

	sequence_put (v: like ll_item) is
		indexing
			description: "Add `v' to end."
			external_name: "SequencePut"
		require 
			extendible: extendible
		do
			extend (v)
		ensure 
			item_inserted: has (v)
			new_count: count = old count + 1
		end

	put_front (v: like ll_item) is
		indexing
			description: "Add `v' to beginning. Do not move cursor."
			external_name: "PutFront"
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
		ensure 
			new_count: count = old count + 1
			item_inserted: first = v
		end

	put_i_th (v: like ll_item; i: INTEGER) is
		indexing
			description: "Put `v' at `i'-th position."
			external_name: "PutITh"
		require 
			valid_key: valid_index (i)
		local
			pos: LINKED_LIST_CURSOR [G]
		do
			pos := cursor
			go_i_th (i)
			replace (v)
			go_to (pos)
		ensure then 
			insertion_done: i_th (i) = v
		end

	put_left (v: like ll_item) is
		indexing
			description: "Add `v' to the left of cursor position. Do not move cursor."
			external_name: "PutLeft"
		require 
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
		ensure
			new_count: count = old count + 1
			new_index: index = old index + 1
			previous_exists: previous /= Void
			item_inserted: previous.item = v
		end

	put_right (v: like ll_item) is
		indexing
			description: "Add `v' to the right of cursor position. Do not move cursor."
			external_name: "PutRight"
		require
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
		ensure
			new_count: count = old count + 1
			same_index: index = old index
			next_exists: next /= Void
			item_inserted: not old before implies next.item = v
			item_inserted_before: old before implies active.item = v
		end
	
feature {NONE} -- Removal

	prune (v: like ll_item) is
		indexing
			description: "[Remove first occurrence of `v', if any,%
						%after cursor position.%
						%If found, move cursor to right neighbor%
						%if not, make structure `exhausted'.]"
			external_name: "Prune"
		require 
			prunable: prunable
		do
			search (v)
			if not exhausted then
				remove
			end
		end

	prune_all (v: G) is
		indexing
			description: "Remove all occurrences of `v'."
			external_name: "PruneAll"
		require
			prunable
		do
			from
			until
				not has (v)
			loop
				prune (v)
			end
		ensure
			no_more_occurrences: not has (v)
			is_exhausted: exhausted
			no_more_occurrences: not has (v)
		end

	ll_remove is
		indexing
			description: "[Remove current item.%
						%Move cursor to right neighbor (or `after' if no right neighbor).]"
			external_name: "LLRemove"
		require 
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
		ensure then 
			after_when_empty: empty implies after
		end

	remove_left is
		indexing
			description: "Remove item to the left of cursor position. Do not move cursor."
			external_name: "RemoveLeft"
		require 
			left_exists: index > 1
			not_before: not before
		do
			move (- 2)
			remove_right
			forth
		ensure 
			new_count: count = old count - 1
			new_index: index = old index - 1
		end

	remove_right is
		indexing
			description: "Remove item to the right of cursor position. Do not move cursor."
			external_name: "RemoveRight"
		require
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
		ensure 
			new_count: count = old count - 1
			same_index: index = old index
		end

	chain_wipe_out is
		indexing
			description: "Remove all items."
			external_name: "ChainWipeOut"
		require 
			prunable
		do
			from
				start
			until
				empty
			loop
				remove
			end
		ensure 
			wiped_out: empty
		end
	
feature {NONE} -- Transformation

	swap (i: INTEGER) is
		indexing
			description: "Exchange item at `i'-th position with item at cursor position."
			external_name: "Swap"
		require 
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
		ensure 
			swapped_to_item: ll_item = old i_th (i)
			swapped_from_item: i_th (i) = old ll_item
		end
	
feature -- Duplication

-- 	duplicate (n: INTEGER): like Current is
--		indexing
--			description: "[New stack containing the `n' latest items inserted in current stack.%
-- 						% If `n' is greater than `count', identical to current stack.]"
-- 			external_name: "Duplicate"
-- 		require
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
		indexing
			description: "Do nothing"
			external_name: "BagPut"
		require 
			extendible: extendible
		do
		ensure 
			item_inserted: has (v)
		end
	
feature {LINKED_STACK} -- Implementation

	active: like first_element
		indexing
			description: "Element at cursor position"
			external_name: "Active"
		end

	cleanup_after_remove (v: like first_element) is
		indexing
			description: "Clean-up a just removed cell."
			external_name: "CleanUpAfterRemove"
		require
			non_void_cell: v /= Void
		do
		end

	first_element: LINKABLE [G]
		indexing
			description: "Head of list"
			external_name: "FirstElement"
		end

	last_element: like first_element is
		indexing
			description: "Tail of list"
			external_name: "LastElement"
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
		indexing
			description: "[A newly created instance of the same type as `first_element'.%
						%This feature may be redefined in descendants so as to%
						%produce an adequately allocated and initialized object.]"
			external_name: "NewCell"
		local
			i: LINKABLE [G]
		do
			create i
			Result := i
			Result.put (v)
		ensure 
			result_exists: Result /= Void
		end

	new_chain: like Current is
		indexing
			description: "A newly created instance of the same type.%
						%This feature may be redefined in descendants so as to%
						%produce an adequately allocated and initialized object.]"
			external_name: "NewChain"
		do
			create Result.make
		ensure 
			result_exists: Result /= Void
		end

	next: like first_element is
		indexing
			description: "Element right of cursor"
			external_name: "Next"
		do
			if before then
				Result := active
			elseif active /= Void then
				Result := active.right
			end
		end

	previous: like first_element is
		indexing
			description: "Element left of cursor"
			external_name: "Previous"
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
	readable_definition: readable = not empty
	writable_definition: writable = not empty

	writable_constraint: writable implies readable
	empty_constraint: empty implies (not readable) and (not writable)

	empty_definition: empty = (count = 0)
	non_negative_count: count >= 0

	prunable: prunable
	empty_constraint: empty implies ((first_element = Void) and (active = Void))
	not_void_unless_empty: (active = Void) implies empty
	before_constraint: before implies (active = first_element)
	after_constraint: after implies (active = last_element)

	before_definition: before = (index = 0)
	after_definition: after = (index = count + 1)

	non_negative_index: index >= 0
	index_small_enough: index <= count + 1
	off_definition: off = ((index = 0) or (index = count + 1))
	isfirst_definition: isfirst = ((not empty) and (index = 1))
	islast_definition: islast = ((not empty) and (index = count))
	item_corresponds_to_index: (not off) implies (ll_item = i_th (index))

	not_both: not (after and before)
	empty_property: empty implies (after or before)
	before_constraint: before implies off

	after_constraint: after implies off

	empty_constraint: empty implies off

	extendible: extendible

end -- class LINKED_STACK