indexing
	description: 
		"Multiple Eiffel Vision object containers accessible as list."
	status: "See notice at end of class"
	keywords: "widget list, item list, container, dynamic, set, any"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_DYNAMIC_LIST [G -> EV_ANY]

inherit
	EV_ANY
		redefine
			implementation
		end

	DYNAMIC_LIST [G]
		rename
			prune as dl_prune,
			extend as dl_extend,
			replace as dl_replace,
			put_front as dl_put_front,
			put_right as dl_put_right,
			put_i_th as dl_put_i_th
		export
			{NONE} duplicate, new_chain
			{EV_DYNAMIC_LIST_I} sequential_index_of
		undefine
			changeable_comparison_criterion,
			default_create,
			move
		redefine
			i_th,
			go_i_th,
			start,
			dl_put_i_th,
			merge_left,
			merge_right
		end

	SET [G]
		rename
			extend as set_extend
		undefine
			prune_all,
			changeable_comparison_criterion,
			default_create
		select
			prune,
			set_extend
		end

feature -- Access

	item: G is
			-- Item at current position.
		do
			Result := implementation.item
		ensure then
			not_void: Result /= Void
			bridge_ok: Result.is_equal (implementation.item)
		end

	index: INTEGER is
			-- Current position.
		do
			Result := implementation.index
		ensure then
			bridge_ok: Result = implementation.index
		end

	cursor: EV_DYNAMIC_LIST_CURSOR [G] is
			-- Current cursor position.
		do
			Result := implementation.cursor
		ensure then
			bridge_ok: Result.is_equal (implementation.cursor)
		end

	i_th (i: INTEGER): G is
			-- Item at `i'-th position.
			--| Redefined for performance reasons.
		do
			Result := implementation.i_th (i)
		ensure then
			bridge_ok: Result.is_equal (implementation.i_th (i))
		end

feature -- Measurement

	count: INTEGER is
			-- Number of items.
		do
			Result := implementation.count
		ensure then
			bridge_ok: Result = implementation.count
		end

feature -- Status report

	valid_cursor (p: CURSOR): BOOLEAN is
			-- Can the cursor be moved to position `p'?
			-- This is True if `p' conforms to EV_DYNAMIC_LIST_CURSOR and
			-- if it points to an item, `Current' must have it.
		do
			Result := implementation.valid_cursor (p)
		ensure then
			bridge_ok: Result = implementation.valid_cursor (p)
		end

	full: BOOLEAN is false
		-- Is structured filled to capacity? (Answer: no.)

feature -- Cursor movement

	start is
			-- Move cursor to first position.
		do
			implementation.start
		ensure then
			empty_implies_after: empty implies after
		end

	back is
			-- Move to previous position.
		do
			implementation.back
		end

	forth is
			-- Move cursor to next position.
		do
			implementation.forth
		end

	go_i_th (i: INTEGER) is
			-- Move cursor to `i'-th position.
		do
			implementation.go_i_th (i)
		end

	go_to (p: CURSOR) is
			-- Move cursor to position `p'.
		do
			implementation.go_to (p)
		end

	move (i: INTEGER) is
			-- Move cursor `i' positions.
		do
			implementation.move (i)
		end

feature -- Element change

	extend (v: like item) is
			-- Add `v' to end. Do not move cursor.
		require
			extendible: extendible
			v_not_void: v /= Void
			v_parent_void: parent_void (v)
			v_not_current: not same (v)
			v_not_parent_of_current: not is_parent_recursive (v)
		do
			implementation.extend (v)
		ensure
			parent_is_current: is_parent_of (v)
			v_is_last: v = last
			count_increased: count = old count + 1
			cursor_not_moved: (index = old index) or (after and old after)
		end

	replace (v: like item) is
			-- Replace current item by `v'.
		require
			writable: writable
			v_not_void: v /= Void
			v_parent_void: parent_void (v)
			v_not_current: not same (v)
			v_not_parent_of_current: not is_parent_recursive (v)
		do
			implementation.replace (v)
		ensure
			parent_is_current: is_parent_of (v)
			item_replaced: v = item
			not_has_old_item: not has (old item)
			old_item_parent_void: parent_void (old item)
			count_same: count = old count
			cursor_not_moved: index = old index
		end

	put_front (v: like item) is
			-- Add `v' at beginning. Do not move cursor.
		require
			extendible: extendible
			v_not_void: v /= Void
			v_parent_void: parent_void (v)
			v_not_current: not same (v)
			v_not_parent_of_current: not is_parent_recursive (v)
		do
			implementation.put_front (v)
		ensure
			parent_is_current: is_parent_of (v)
			v_is_first: v = first
			count_increased: count = old count + 1
			cursor_not_moved: (index = old index + 1) or
				(before and old before)
		end

	put_right (v: like item) is
			-- Add `v' to the right of cursor position. Do not move cursor.
		require
			extendible: extendible
			not_after: not after
			v_not_void: v /= Void
			v_parent_void: parent_void (v)
			v_not_current: not same (v)
			v_not_parent_of_current: not is_parent_recursive (v)
		do
			implementation.put_right (v)
		ensure
			parent_is_current: is_parent_of (v)
			v_at_index_plus_one: v = i_th (index + 1)
			count_increased: count = old count + 1
	 		cursor_not_moved: index = old index
		end

	put_i_th (v: like item; i: INTEGER) is
			-- Replace item at `i'-th position by `v'.
		require
			valid_index: i > 0 and i <= count
			v_not_void: v /= Void
			v_parent_void: parent_void (v)
			v_not_current: not same (v)
			v_not_parent_of_current: not is_parent_recursive (v)
		do
			implementation.put_i_th (v, i)
		ensure
			parent_is_current: is_parent_of (v)
			item_replaced: v = i_th (i)
			not_has_old_item: not has (old i_th (i))
			old_item_parent_void: parent_void (old i_th (i))
			count_same: count = old count
			cursor_not_moved: index = old index
		end

	merge_left (other: like Current) is
			-- Merge `other' into current structure before cursor
			-- position. Do not move cursor. Empty `other'.
		do
			implementation.merge_left (other)
		end

	merge_right (other: like Current) is
			-- Merge `other' into current structure after cursor
			-- position. Do not move cursor. Empty `other'.
		do
			implementation.merge_right (other)
		end

feature -- Removal

	prune (v: like item) is
			-- Remove `v' if present. Do not move cursor, except if
			-- cursor was on `v', move to right neighbor.
		do
			implementation.prune (v)
		ensure then
			not_has_v: not has (v)
			had_item_implies_parent_void:
				old has (v) implies parent_void (v)
			had_item_implies_count_decreased:
				old has (v) implies count = old count - 1
			had_item_and_was_after_implies_index_decreased:
				(old after and old has (v)) implies index = old index - 1
		end

	remove is
			-- Remove current item. Move cursor to right neighbor.
			-- (or `after' if no right neighbor).
		do
			implementation.remove
		ensure then
			v_removed: not has (old item)
			parent_void: parent_void (old item)
			count_decreased: count = old count - 1
			index_same: index = old index
		end

	remove_left is
			-- Remove item to the left of cursor position.
			-- Do not move cursor.
		do
			implementation.remove_left
		ensure then
			left_neighbor_removed: not has (old i_th (index - 1))
			parent_void: parent_void (old i_th (index - 1))
			index_decreased: index = old index - 1
		end

	remove_right is
			-- Remove item to the right of cursor position.
			-- Do not move cursor.
		do
			implementation.remove_right
		ensure then
			right_neighbor_removed: not has (old i_th (index + 1))
			parent_void: parent_void (old i_th (index + 1))
			index_same: index = old index
		end

feature -- Contract support

	parent_void (v: like item): BOOLEAN is
			-- Is `v' not in an Eiffel Vision container yet?
		require
			v_not_void: v /= Void
		deferred
		end

	is_parent_recursive (a_list: EV_ANY): BOOLEAN is
			-- Is `a_list' a parent of `Current'?
		require
			a_list_not_void: a_list /= Void
		deferred
		end

	same (other: EV_ANY): BOOLEAN is
			-- Is `other' `Current'?
		do
			Result := Current = other
		end

	is_parent_of (v: like item): BOOLEAN is
			-- Is `Current' parent of `v'.
		require
			v_not_void: v /= Void
		deferred
		end

feature {NONE} -- Inapplicable

	dl_extend (v: like item) is
		do
			extend (v)
		end

	set_extend (v: like item) is
		do
			extend (v)
		end

	dl_replace (v: like item) is
		do
			replace (v)
		end

	dl_put_front (v: like item) is
		do
			put_front (v)
		end

	dl_put_right (v: like item) is
		do
			put_right (v)
		end

	dl_put_i_th (v: like item; i: INTEGER) is
		do
			put_i_th (v, i)
		end

	new_chain: like Current is
		do
			check
				inapplicable: False
			end
		end

feature {EV_ANY_I} -- Implementation

	implementation: EV_DYNAMIC_LIST_I [G]
			-- Responsible for interaction with the underlying native graphics
			-- toolkit.

end -- class EV_DYNAMIC_LIST

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.5  2000/04/06 00:01:50  brendel
--| Removed action sequences.
--|
--| Revision 1.4  2000/04/05 21:16:13  brendel
--| Merged changes from LIST_REFACTOR_BRANCH.
--|
--| Revision 1.3.4.11  2000/04/05 19:31:59  brendel
--| Changed export status of sequential_index_of to EV_DYNAMIC_LIST_I,
--| because index_of uses go_to and go_to used to use index_of.
--|
--| Revision 1.3.4.10  2000/04/05 19:00:55  brendel
--| redefined put_i_th, merge_left and merge_right because they do not work
--| with our contracts.
--|
--| Revision 1.3.4.9  2000/04/04 23:02:55  brendel
--| Corrected contracts.
--|
--| Revision 1.3.4.8  2000/04/04 22:08:55  brendel
--| Redefined start to have empty convention like LINKED_LIST.
--|
--| Revision 1.3.4.7  2000/04/04 21:38:42  brendel
--| Improved postcondition.
--|
--| Revision 1.3.4.6  2000/04/03 18:10:29  brendel
--| Moved cursor implementation to _I.
--| Changed type on is_parent_recursive.
--|
--| Revision 1.3.4.5  2000/04/01 00:44:40  brendel
--| Added feature `same', because v /= Current is not allowed.
--|
--| Revision 1.3.4.4  2000/03/31 22:44:36  brendel
--| Actions are now called from here.
--|
--| Revision 1.3.4.3  2000/03/31 22:17:38  brendel
--| Minor changes.
--|
--| Revision 1.3.4.2  2000/03/31 18:43:35  brendel
--| Added contracts.
--| Added action sequences.
--| Added contract support features.
--| Redefined `i_th'.
--|
--| Revision 1.3  2000/02/22 18:39:49  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.2  2000/02/14 12:05:13  oconnor
--| added from prerelease_20000214
--|
--| Revision 1.1.2.9  2000/02/08 05:11:02  oconnor
--| added inheritance of EV_ANY, c-ed out invariant, its stuffed, needs to be
--| fixed
--|
--| Revision 1.1.2.8  2000/02/08 01:44:51  king
--| Correctly implemented item_parent and its caller
--|
--| Revision 1.1.2.7  2000/02/08 00:31:21  oconnor
--| Added invariants for uniqueness of items and parnet being set propperly
--| for items.
--|
--| Revision 1.1.2.6  2000/02/08 00:19:38  king
--| Changed inheritence to deal with changes in ev_dynamic_list
--|
--| Revision 1.1.2.5  2000/02/07 23:49:41  oconnor
--| Added postcondition to addition features to ensure removal from old parent.
--|
--| Revision 1.1.2.4  2000/02/07 23:46:24  oconnor
--| Renames item addition features from SET and DYNAMIC_LIST and defined new
--| features with same names and stronger contracts.
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
