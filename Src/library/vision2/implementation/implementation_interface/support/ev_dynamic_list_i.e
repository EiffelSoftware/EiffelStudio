indexing
	description: 
		"Eiffel Vision dynamic list. Implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_DYNAMIC_LIST_I [G -> EV_CONTAINABLE]

inherit
	EV_ANY_I
		redefine
			interface
		end

feature -- Access

	item: G is
			-- Current item
		require
			readable: index > 0 and then index <= count
		do
			Result := i_th (index)
		ensure
			not_void: Result /= Void
		end

	index: INTEGER
			-- Index of current position

	cursor: EV_DYNAMIC_LIST_CURSOR [G] is
			-- Current cursor position.
		local
			an_item: like item
		do
			if index > 0 and then index <= count then
				an_item := item
			end
			create Result.make (an_item, index <= 0, index > count)
		ensure
			not_void: Result /= Void
		end

	i_th (i: INTEGER): G is
			-- Item at `i'-th position.
		require
			i_within_bounds: i > 0 and then i <= count
		deferred
		ensure
			not_void: Result /= Void
		end

	index_of (v: like item; i: INTEGER): INTEGER is
			-- Index of i_th item `v', if present.
			-- As dynamic list descendants are all sets,
			-- Result will be zero for all values of `i'
			-- that are not equal to one
		local
			an_index: INTEGER
		do
			if i = 1 then
				from
					an_index := 1
				until
					Result > 0 or else an_index > count
				loop
					if i_th (an_index) = v then
						Result := an_index
					end
					an_index := an_index + 1
				end
			end
		end

feature -- Measurement

	count: INTEGER is
			-- Number of items.
		deferred
		end

feature -- Status report

	valid_cursor (p: CURSOR): BOOLEAN is
			-- Can the cursor be moved to position `p'?
			-- This is True if `p' conforms to EV_DYNAMIC_LIST_CURSOR and
			-- if it points to an item, `Current' must have it.
		local
			dlc: EV_DYNAMIC_LIST_CURSOR [G]
		do
			dlc ?= p
			Result := dlc /= Void and then
				(dlc.item = Void or else has (dlc.item))
		end

	has (v: like item): BOOLEAN is
			-- Does structure contain `v'?
		require
			v_not_void: v /= Void
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > count or else Result
			loop
				if i_th (i) = v then
					Result := True
				end
				i := i + 1
			end
		end

feature -- Cursor movement

	start is
			-- Move cursor to first position.
		do
			index := 1
		ensure
			index_on_first: index = 1
		end

	back is
			-- Move to previous item.
		require
			not_before: index > 0
		do
			index := index - 1
		end

	forth is
			-- Move cursor to next position.
		require
			not_after: index <= count
		do
			index := index + 1
		end

	go_i_th (i: INTEGER) is
			-- Move cursor to `i'-th position.
		do
			index := i
			if index < 0 then
				index := 0
			elseif index > count + 1 then
				index := count + 1
			end
		end

	go_to (p: CURSOR) is
			-- Move cursor to position `p'.
		local
			dlc: EV_DYNAMIC_LIST_CURSOR [G]
		do
			dlc ?= p
			check
				dlc_not_void: dlc /= Void
			end
			if dlc.after then
				index := count + 1
			elseif dlc.before then
				index := 0
			else
				index := index_of (dlc.item, 1)
			end
		end

	move (i: INTEGER) is
			-- Move cursor `i' positions.
		do
			index := index + i
			if index < 0 then
				index := 0
			elseif index > count + 1 then
				index := count + 1
			end
		end

feature -- Element change

	extend (v: like item) is
			-- Add `v' to end. Do not move cursor.
		require
			v_not_void: v /= Void
		do
			insert_i_th (v, count + 1)
			if index = count then
				index := index + 1
			end
		ensure
			has_v: has (v)
		end

	replace (v: like item) is
			-- Replace current item by `v'.
		require
			writable: index > 0 and then index <= count
			v_not_void: v /= Void
		do
			remove_i_th (index)
			insert_i_th (v, index)
		ensure
			has_v: has (v)
		end

	put_front (v: like item) is
			-- Add `v' at beginning. Do not move cursor.
		require
			v_not_void: v /= Void
		do
			insert_i_th (v, 1)
			if index > 0 then
				index := index + 1
			end
		ensure
			has_v: has (v)
		end

	put_right (v: like item) is
			-- Add `v' to the right of cursor position. Do not move cursor.
		require
			v_not_void: v /= Void
		do
			insert_i_th (v, index + 1)
		ensure
			has_v: has (v)
		end

	put_left (v: like item) is
			-- Add `v' to the left of cursor position. Do not move cursor.
		require
			v_not_void: v /= Void
		do
			insert_i_th (v, index)
			index := index + 1
		ensure
			has_v: has (v)
		end

	put_i_th (v: like item; i: INTEGER) is
			-- Replace item at `i'-th position by `v'.
		require
			valid_index: i > 0 and i <= count
			v_not_void: v /= Void
		do
			insert_i_th (v, i)
			remove_i_th (i + 1)
		ensure
			has_v: has (v)
		end

	merge_left (other: like interface) is
			-- Merge `other' into current structure before cursor
			-- position. Do not move cursor. Empty `other'.
		local
			v: like item
		do
			from
				other.start
			until
				other.is_empty
			loop
				v := other.item
				other.remove
				insert_i_th (v, index)
				index := index + 1
			end
		end

	merge_right (other: like interface) is
			-- Merge `other' into current structure after cursor
			-- position. Do not move cursor. Empty `other'.
		local
			v: like item
		do
			from
			until
				other.is_empty
			loop
				other.finish
				v := other.item
				other.remove
				insert_i_th (v, index + 1)
			end
		end

feature -- Removal

	prune (v: like item) is
			-- Remove `v' if present. Do not move cursor, except if
			-- cursor was on `v', move to right neighbor.
		local
			item_index: INTEGER
		do
			item_index := index_of (v, 1)
			if item_index > 0 then
				remove_i_th (item_index)
				if item_index <= index then
					index := index - 1
				end
			end
		ensure
			--| It is not possible to call old item as if off, it will cause
			--| imp to_int to fail and because all old expressions are evaluated
			--| on entry to a routine, we cannot check that we were not off
			--| before evaluating old item. Julian. 
			cursor_not_moved: not old has (v) implies
				old interface.index = interface.index
			cursor_not_moved: old has (v) and then old interface.index <
				old index_of (v, 1) implies index = old index
			cursor_not_moved: old has (v) and then old interface.index >=
				old index_of (v, 1) implies index = old index - 1
			not_has_v: not has (v)
		end

	remove is
			-- Remove current item. Move cursor to right neighbor
			-- (or `after' if no right neighbor).
		do
			remove_i_th (index)
			if index > count + 1 then
				index := count + 1
			end
		ensure
			not_has_v: not has (old item)
		end

	remove_left is
			-- Remove item to the left of cursor position.
			-- Do not move cursor.
		do
			index := index - 1
			remove_i_th (index)
		ensure then
			left_neighbor_removed: not has (old i_th (index - 1))
		end

	remove_right is
			-- Remove item to the right of cursor position.
			-- Do not move cursor.
		do
			remove_i_th (index + 1)
		ensure then
			right_neighbor_removed: not has (old i_th (index + 1))
		end

	wipe_out is
			-- Remove all items.
		do
			from
				interface.start
			until
				interface.is_empty
			loop
				interface.remove
			end
			interface.back
		end

feature {NONE} -- Implementation

	insert_i_th (v: like item; i: INTEGER) is
			-- Insert `v' at position `i'.
		require
			i_within_bounds: i > 0 and i <= count + 1
		deferred
		ensure
			count_increased: count = old count + 1
		end

	remove_i_th (i: INTEGER) is
			-- Remove item at `i'-th position.
		require
			i_within_bounds: i > 0 and i <= count
		deferred
		ensure
			count_decreased: count = old count - 1
		end

feature {EV_ANY_I} -- Implementation

	imp_to_int (imp: EV_ANY_I): G is
			-- `interface' of `imp'.
		require
			imp_not_void: imp /= Void
		do
			if g_converter = Void then
				create g_converter
			end
			Result := g_converter.attempt (imp.interface)
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_DYNAMIC_LIST [G]

feature {NONE} -- Implementation

	g_converter: ASSIGN_ATTEMPT [G]

invariant
	index_within_bounds: is_usable implies (index >= 0 and then
		index <= count + 1)

end -- class EV_DYNAMIC_LIST_I

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

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.11  2001/07/14 12:16:28  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.10  2001/06/07 23:08:09  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.8.2.12  2001/05/18 18:21:55  king
--| Corrected index_within_bounds invariant
--|
--| Revision 1.8.2.11  2001/02/16 00:17:13  rogers
--| Replaced is_useable with is_usable.
--|
--| Revision 1.8.2.10  2001/01/15 20:13:50  rogers
--| Implemented wipe_out. This now allows implementation to redefine wipe_out
--| for performance optimizations.
--|
--| Revision 1.8.2.9  2000/11/29 00:35:22  rogers
--| Changed empty to is_empty.
--|
--| Revision 1.8.2.8  2000/10/04 17:25:08  rogers
--| Fixed post condition on prune again, as it turned out it is not possible
--| to use old item without being sure that imp_to_int will not fail, as
--| pre and post conditions are only checked one level deep. Post condition
--| on prune now does not use old item, it now works with the index. Formatting
--| to 80 columns.
--|
--| Revision 1.8.2.7  2000/10/04 15:47:01  rogers
--| Fixed prune. The index was not moved correctly, and there was still a bug
--| in the post condition.
--|
--| Revision 1.8.2.6  2000/10/03 22:20:06  rogers
--| Corrected post condition on prune.
--|
--| Revision 1.8.2.5  2000/09/18 18:15:30  oconnor
--| Previous implementor of prune did not understand that cursor position
--| not changing is not the same as `index' not changing. (ie when the
--| pruned item index is less than `index'.)
--|
--| Revision 1.8.2.4  2000/05/27 01:53:24  pichery
--| Cosmetics
--|
--| Revision 1.8.2.3  2000/05/13 00:04:13  king
--| Converted to new EV_CONTAINABLE class
--|
--| Revision 1.8.2.2  2000/05/05 22:21:21  king
--| Implemented index_of
--|
--| Revision 1.8.2.1  2000/05/03 19:09:00  oconnor
--| mergred from HEAD
--|
--| Revision 1.8  2000/04/07 23:59:36  brendel
--| Added put_left.
--|
--| Revision 1.7  2000/04/07 18:37:55  brendel
--| Fixed bug in prune.
--|
--| Revision 1.6  2000/04/07 01:32:31  brendel
--| Added has.
--| Replaced interface.has with has.
--|
--| Revision 1.5  2000/04/06 00:03:17  brendel
--| Fixed bug in merge_right.
--|
--| Revision 1.4  2000/04/05 21:16:10  brendel
--| Merged changes from LIST_REFACTOR_BRANCH.
--|
--| Revision 1.3.4.14  2000/04/05 19:48:37  brendel
--| We now save the cursor ourselves in `prune'.
--|
--| Revision 1.3.4.13  2000/04/05 19:34:22  brendel
--| Changed prune to use sequential_index_of instead of index_of, because
--| index_of saves the cursor, which is not efficient.
--|
--| Revision 1.3.4.12  2000/04/05 19:27:44  brendel
--| Fixed 2 minor bugs.
--|
--| Revision 1.3.4.11  2000/04/05 19:02:21  brendel
--| Added put_i_th, merge_left and merge_right.
--|
--| Revision 1.3.4.10  2000/04/04 22:09:24  brendel
--| Added start.
--|
--| Revision 1.3.4.9  2000/04/04 21:39:35  brendel
--| Corrected go_i_th.
--|
--| Revision 1.3.4.8  2000/04/04 18:47:54  brendel
--| Improved implementation of go_to.
--| Changed imp_to_int to use ASSIGN_ATTEMPT.
--|
--| Revision 1.3.4.7  2000/04/04 17:41:45  brendel
--| Changed location of external.
--|
--| Revision 1.3.4.6  2000/04/04 01:51:09  brendel
--| Added function `imp_to_int' that uses `generize' to get the interface of
--| an object without checking the type.
--|
--| Revision 1.3.4.5  2000/04/03 18:02:42  brendel
--| Moved cursor implementation from interface.
--| replaced has with interface.has.
--|
--| Revision 1.3.4.4  2000/04/01 00:43:16  brendel
--| Fixed cursor bug.
--|
--| Revision 1.3.4.3  2000/03/31 22:45:36  brendel
--| Implemented all 4 remove features in terms of `remove_i_th'.
--| Implemented all 4 add features in terms of `insert_i_th'.
--|
--| Revision 1.3.4.2  2000/03/31 22:20:05  brendel
--| Added CVS log.
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
