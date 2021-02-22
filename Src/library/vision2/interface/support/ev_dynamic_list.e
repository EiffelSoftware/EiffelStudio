note
	description:
		"Multiple Eiffel Vision object containers accessible as list."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "widget list, item list, container, dynamic, set, any"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_DYNAMIC_LIST [G -> EV_CONTAINABLE]

inherit
	EV_CONTAINABLE
		undefine
			is_equal
		redefine
			implementation,
			is_in_default_state
		end

	DYNAMIC_LIST [G]
		rename
			prune as dl_prune,
			extend as dl_extend,
			replace as dl_replace,
			force as dl_force,
			put_front as dl_put_front,
			put_right as dl_put_right,
			put_i_th as dl_put_i_th,
			put_left as dl_put_left,
			append as dl_append
		export
			{NONE} duplicate, new_chain, dl_prune
			{EV_ANY_HANDLER} default_create
		undefine
			changeable_comparison_criterion,
			default_create,
			move,
			copy
		redefine
			index_of,
			i_th,
			go_i_th,
			start,
			dl_put_i_th,
			merge_left,
			merge_right,
			dl_put_left,
			dl_append,
			wipe_out,
			swap
		end

feature -- Access

	item: G
			-- Item at current position.
		do
			Result := implementation.item
		ensure then
			not_void: Result /= Void
			bridge_ok: Result.is_equal (implementation.item)
		end

	index: INTEGER
			-- Current position.
		do
			Result := implementation.index
		ensure then
			bridge_ok: Result = implementation.index
		end

	cursor: EV_DYNAMIC_LIST_CURSOR [G]
			-- Current cursor position.
		do
			Result := implementation.cursor
		ensure then
			bridge_ok: Result.is_equal (implementation.cursor)
		end

	i_th alias "[]" (i: INTEGER): like item
			-- Item at `i'-th position.
			--| Redefined for performance reasons.
		do
			Result := implementation.i_th (i)
		ensure then
			bridge_ok: Result.is_equal (implementation.i_th (i))
		end

	index_of (v: like item; i: INTEGER): INTEGER
			-- Index of `i'th occurrence of `v'.
		do
			Result := implementation.index_of (v, i)
		ensure then
			bridge_ok: Result = implementation.index_of (v, i)
		end

	retrieve_item_by_data (some_data: ANY; should_compare_objects: BOOLEAN): detachable G
			-- `Result' is first item in `Current' with data
			-- matching `some_data'. Compare objects if
			-- `should_compare_objects' otherwise compare references.
		do
			Result := implementation.retrieve_item_by_data (some_data, should_compare_objects)
		ensure
			not_found_in_empty: Result /= Void implies not is_empty
			index_not_changed: old index = index
		end

	retrieve_items_by_data (some_data: ANY; should_compare_objects: BOOLEAN): ARRAYED_LIST [G]
			-- `Result' is all items in `Current' with data
			-- matching `some_data'. Compare objects if
			-- `should_compare_objects' otherwise compare references.
		do
			Result := implementation.retrieve_items_by_data (some_data, should_compare_objects)
		ensure
			Result_not_void: Result /= Void
			not_found_in_empty: not Result.is_empty implies not is_empty
			index_not_changed: old index = index
		end

feature -- Measurement

	count: INTEGER
			-- Number of items.
		do
			Result := implementation.count
		ensure then
			bridge_ok: Result = implementation.count
		end

feature -- Status report

	valid_cursor (p: CURSOR): BOOLEAN
			-- Can the cursor be moved to position `p'?
			-- This is True if `p' conforms to EV_DYNAMIC_LIST_CURSOR and
			-- if it points to an item, `Current' must have it.
		do
			Result := implementation.valid_cursor (p)
		ensure then
			bridge_ok: Result = implementation.valid_cursor (p)
		end

	Full: BOOLEAN = False
		-- Is structured filled to capacity? (Answer: no.)

feature -- Cursor movement

	start
			-- Move cursor to first position.
		do
			implementation.start
		ensure then
			empty_implies_after: is_empty implies after
		end

	back
			-- Move to previous position.
		do
			implementation.back
		end

	forth
			-- Move cursor to next position.
		do
			implementation.forth
		end

	go_i_th (i: INTEGER)
			-- Move cursor to `i'-th position.
		do
			implementation.go_i_th (i)
		end

	go_to (p: CURSOR)
			-- Move cursor to position `p'.
		do
			implementation.go_to (p)
		end

	move (i: INTEGER)
			-- Move cursor `i' positions.
		do
			implementation.move (i)
		end

feature -- Element change

	append (s: SEQUENCE [like item])
			-- Append a copy of `s'. Do not move cursor.
		require
			not_destroyed: not is_destroyed
			extendible: extendible
			sequence_not_void: s /= Void
			sequence_not_current: s /= Current
			not_parented: not s.there_exists (agent (v: like item): BOOLEAN do Result := v /= Void and then v.parent /= Void end)
		do
			implementation.append (s)
		ensure
			count_increased: old count + s.count = count
			cursor_not_moved: (index = old index) or (after and old after)
		end

	force, extend (v: like item)
			-- Add `v' to end. Do not move cursor.
		require
			not_destroyed: not is_destroyed
			extendible: extendible
			v_not_void: v /= Void
			v_parent_void: v.parent = Void
			v_not_current: not same (v)
			v_not_parent_of_current: not is_parent_recursive (v)
		do
			implementation.extend (v)
		ensure
			parent_is_current: v.parent = Current
			v_is_last: v = last
			count_increased: count = old count + 1
			cursor_not_moved: (index = old index) or (after and old after)
		end

	replace (v: like item)
			-- Replace current item by `v'.
		require
			not_destroyed: not is_destroyed
			writable: writable
			v_not_void: v /= Void
			v_parent_void: v.parent = Void
			v_not_current: not same (v)
			v_not_parent_of_current: not is_parent_recursive (v)
		do
			implementation.replace (v)
		ensure
			parent_is_current: v.parent = Current
			item_replaced: v = item
			not_has_old_item: not has (old item)
			old_item_parent_void: (old item).parent = Void
			count_same: count = old count
			cursor_not_moved: index = old index
		end

	put_front (v: like item)
			-- Add `v' at beginning. Do not move cursor.
		require
			not_destroyed: not is_destroyed
			extendible: extendible
			v_not_void: v /= Void
			v_parent_void: v.parent = Void
			v_not_current: not same (v)
			v_not_parent_of_current: not is_parent_recursive (v)
		do
			implementation.put_front (v)
		ensure
			parent_is_current: v.parent = Current
			v_is_first: v = first
			count_increased: count = old count + 1
			cursor_not_moved: (index = old index + 1) or
				(before and old before)
		end

	put_right (v: like item)
			-- Add `v' to right of cursor position. Do not move cursor.
		require
			not_destroyed: not is_destroyed
			extendible: extendible
			not_after: not after
			v_not_void: v /= Void
			v_parent_void: v.parent = Void
			v_not_current: not same (v)
			v_not_parent_of_current: not is_parent_recursive (v)
		do
			implementation.put_right (v)
		ensure
			parent_is_current: v.parent = Current
			v_at_index_plus_one: v = i_th (index + 1)
			count_increased: count = old count + 1
	 		cursor_not_moved: index = old index
		end

	put_left (v: like item)
			-- Add `v' to the left of cursor position. Do not move cursor.
		require
			not_destroyed: not is_destroyed
			extendible: extendible
			not_before: not before
			v_not_void: v /= Void
			v_parent_void: v.parent = Void
			v_not_current: not same (v)
			v_not_parent_of_current: not is_parent_recursive (v)
		do
			implementation.put_left (v)
		ensure
			parent_is_current: v.parent = Current
			v_at_index_plus_one: v = i_th (index - 1)
			count_increased: count = old count + 1
	 		cursor_not_moved: index = old index + 1
		end

	put_i_th (v: like item; i: INTEGER)
			-- Replace item at `i'-th position by `v'.
		require
			not_destroyed: not is_destroyed
			valid_index: i > 0 and i <= count
			v_not_void: v /= Void
			v_parent_void: v.parent = Void
			v_not_current: not same (v)
			v_not_parent_of_current: not is_parent_recursive (v)
		do
			implementation.put_i_th (v, i)
		ensure
			parent_is_current: v.parent = Current
			item_replaced: v = i_th (i)
			not_has_old_item: not has (old i_th (i))
			old_item_parent_void: (old i_th (i)).parent = Void
			count_same: count = old count
			cursor_not_moved: index = old index
		end

	merge_left (other: like Current)
			-- Merge `other' into current structure before cursor
			-- position. Do not move cursor. Empty `other'.
		do
			implementation.merge_left (other)
		end

	merge_right (other: like Current)
			-- Merge `other' into current structure after cursor
			-- position. Do not move cursor. Empty `other'.
		do
			implementation.merge_right (other)
		end

	swap (i: INTEGER)
			-- Exchange_item at `i'-th position with item
			-- at cursor position.
		local
			old_item, new_item: like item;
			old_index, old_index_adjustment: INTEGER
		do
			if i < index then
					--| After removing the first item, if `i' < `index'
					--| Then when we use `old_index' - 1 to make sure
					--| we still reference the correct item.
				old_index_adjustment := -1
			end
			old_index := index
			go_i_th (i)
			new_item := item
			remove
			go_i_th (old_index + old_index_adjustment)
			old_item := item
			remove
			put_left (new_item)
			go_i_th (i)
			put_left (old_item)
			go_i_th (old_index)
		end

feature -- Removal

	prune (v: like item)
			-- Remove `v' if present. Do not move cursor, except if
			-- cursor was on `v', move to right neighbor.
		do
			implementation.prune (v)
		ensure then
			not_has_v: not has (v)
			had_item_implies_parent_void:
				old has (v) implies (v /= Void and then v.parent = Void)
			had_item_implies_count_decreased:
				old has (v) implies count = old count - 1
			had_item_and_was_after_implies_index_decreased:
				(old after and old has (v)) implies index = old index - 1
		end

	remove
			-- Remove current item. Move cursor to right neighbor.
			-- (or `after' if no right neighbor).
		do
			implementation.remove
		ensure then
			v_removed: not has (old item)
			parent_void: (old item).parent = Void
			count_decreased: count = old count - 1
			index_same: index = old index
		end

	remove_left
			-- Remove item to left of cursor position.
			-- Do not move cursor.
		do
			implementation.remove_left
		ensure then
			left_neighbor_removed: not has (old i_th (index - 1))
			parent_void: (old i_th (index -1)).parent = Void
			index_decreased: index = old index - 1
		end

	remove_right
			-- Remove item to right of cursor position.
			-- Do not move cursor.
		do
			implementation.remove_right
		ensure then
			right_neighbor_removed: not has (old i_th (index + 1))
			parent_void: (old i_th (index + 1)).parent = Void
			index_same: index = old index
		end

	wipe_out
			-- Remove all items.
		do
			implementation.wipe_out
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_CONTAINABLE} and is_empty and before
		end

feature -- Contract support

	is_parent_recursive (a_list: like item): BOOLEAN
			-- Is `a_list' a parent of `Current'?
		require
			a_list_not_void: a_list /= Void
			not_destroyed: not is_destroyed
		deferred
		end

	same (other: EV_ANY): BOOLEAN
			-- Is `other' `Current'?
		do
			Result := Current = other
		end

feature {EV_DYNAMIC_LIST} -- Inapplicable

	dl_append (s: SEQUENCE [G])
		do
			append (s)
		end

	dl_extend (v: like item)
		do
			extend (v)
		end

	dl_replace (v: like item)
		do
			replace (v)
		end

	dl_put_front (v: like item)
		do
			put_front (v)
		end

	dl_put_right (v: like item)
		do
			put_right (v)
		end

	dl_put_i_th (v: like item; i: INTEGER)
		do
			put_i_th (v, i)
		end

	dl_put_left (v: like item)
		do
			put_left (v)
		end

	new_chain: like Current
		do
			check applicable: False then
			end
				-- The following line is for 6.8 void-safety compatibility.
			Result := Current
		end

feature {EV_DYNAMIC_LIST} -- Inapplicable

	set_extend (v: like item)
		do
			extend (v)
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_DYNAMIC_LIST_I [G];
			-- Responsible for interaction with native graphics
			-- toolkit.

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
