indexing
	description:
		"Eiffel Vision item list. Base class for widgets that display EV_ITEMs"
	status: "See notice at end of class."
	keywords: "item, list"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_ITEM_LIST [G -> EV_ITEM]

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
			put_right as dl_put_right
		export
			{NONE} duplicate, new_chain
		undefine
			changeable_comparison_criterion,
			default_create,
			move
		redefine
			start,
			finish,
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
		end

	item_by_data (data: ANY): like item is
			-- First item with `data'.
		require
			data_not_void: data /= Void
		do
			Result := implementation.item_by_data (data)
		end

	index: INTEGER is
			-- Index of current position.
		do
			Result := implementation.index
		ensure then
			bridge_ok: Result = implementation.index
		end

	cursor: CURSOR is
			-- Current cursor position.
		do
			Result := implementation.cursor
		ensure then
			bridge_ok: Result.is_equal (implementation.cursor)
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
		do
			Result := implementation.valid_cursor (p)
		ensure then
			bridge_ok: Result = implementation.valid_cursor (p)
		end

	full: BOOLEAN is false
		-- Is structured filled to capacity? (Answer: no.)

feature -- Cursor movement

	start is
			-- Move to first position.
		do
			go_i_th (1)
		end

	finish is
			-- Move cursor to first position.
		do
			go_i_th (count)
		ensure then
			empty_implies_before: empty implies before
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

	extend (v: G) is
			-- Add `v' to end.
			-- Do not move cursor.
			-- Remove `v' from existing parent.
		require
			extendible: extendible
			v_not_void: v /= Void
			not_has_v: not has (v)
		do
			implementation.extend (v)
		ensure
			item_inserted: has (v)
			new_count: count = old count + 1
			item_parent_is_current: v.parent = Current
		end

	replace (v: G) is
			-- Replace current item by `v'.
			-- Remove `v' from existing parent.
		require
			writable: writable
			v_not_void: v /= Void
			item_is_v_or_not_has_v: item = v or not has (v)
		do
			implementation.replace (v)
		ensure
			item_replaced: (not old has (v)) or old item = v implies item = v
			item_parent_is_current: v.parent = Current
		end

	put_front (v: G) is
			-- If `v' not already in list add to beginning.
			-- Do not move cursor.
			-- Remove `v' from existing parent.
		require
			v_not_void: v /= Void
			not_has_v: not has (v)
		do
			implementation.put_front (v)
		ensure
			item_inserted: first = v
			new_count: count = old count + 1
			new_index: index = old index + 1
			item_parent_is_current: v.parent = Current
		end

	put_right (v: G) is
			-- If `v' not already in list add to the right of cursor position.
			-- Do not move cursor.
			-- Remove `v' from existing parent.
		require
			extendible: extendible
			not_after: not after
			v_not_void: v /= Void
			not_has_v: not has (v)
		do
			implementation.put_right (v)
		ensure
			item_inserted: i_th (index + 1) = v
	 		new_count: count = old count + 1
	 		same_index: index = old index
			item_parent_is_current: v.parent = Current
		end

	merge_left (other: like Current) is
			-- Merge `other' into current structure before cursor
			-- position. Do not move cursor. Empty `other'.
			--| Redefined because our `put_left'
			--| automatically removes item from `other'.
		do
			from
				other.start
			until
				other.empty
			loop
				put_left (other.item)
				check
					not_other_has_item: not other.has (item)
				end
			end
		end

	merge_right (other: like Current) is
			-- Merge `other' into current structure after cursor
			-- position. Do not move cursor. Empty `other'.
			--| Redefined because our `put_right'
			--| automatically removes item from `other'.
		do
			from
				other.finish
			until
				other.empty
			loop
				put_right (other.item)
				other.back
				check
					not_other_has_item: not other.has (item)
				end
			end
		end

feature -- Removal

	prune (v: G) is
			-- Remove `v' if present.
		do
			if v.parent = Current then
				implementation.prune (v)
			end
		ensure then
			removed_item_parent_is_void: old has (v) implies v.parent = Void
		end

	remove is
			-- Remove current item.
			-- Move cursor to right neighbor
			-- (or `after' if no right neighbor).
		do
			implementation.remove
		ensure then
			removed_item_parent_is_void: old item /= Void implies (old item).parent = Void
		end

	remove_left is
			-- Remove item to the left of cursor position.
		do
			implementation.remove_left
		end

	remove_right is
			-- Remove item to the right of cursor position.
			-- Do not move cursor.
		do
			implementation.remove_right
		end

feature {NONE} -- Inapplicable

	dl_extend (v: G) is
		do
			extend (v)
		end

	set_extend (v: G) is
		do
			extend (v)
		end

	dl_replace (v: G) is
		do
			replace (v)
		end

	dl_put_front (v: G) is
		do
			put_front (v)
		end

	dl_put_right (v: G) is
		do
			put_right (v)
		end

	new_chain: like Current is
		do
			check
				inapplicable: False
			end
		end

feature {NONE} -- Contract support

	parent_of_items_is_current: BOOLEAN is
			-- Do all items have parent `Current'?
		local
			c: CURSOR
			item_par: EV_ITEM_LIST [G]
		do
			Result := True
			c := cursor
			from
				start
			until
				after or Result = False
			loop
				item_par ?= item.parent
				if item_par /= Current then
					Result := False
				end
				forth
			end
			go_to (c)
		end

	items_unique: BOOLEAN is
			-- Are all items unique?
			-- (ie Are there no duplicates?)
		local
			c: CURSOR
			l: LINKED_LIST [G]
		do
			create l.make
			Result := True
			c := cursor
			from
				start
			until
				after or Result = False
			loop
				if l.has (item) then
					Result := False
				end
				l.extend (item)
				forth
			end
			go_to (c)
		end

feature {NONE}-- Assertion

	lists_equal (list1, list2: LINKED_LIST [G]): BOOLEAN is
			-- Are elements in `list1' equal to those in `list2'.
		require
			list1_not_void: list1 /= Void
			list2_not_void: list2 /= Void
		do
			if list1.count = list1.count and then list1.count > 0 then
				from
					list1.start
					list2.start
					Result := True
				until
					list1.off
				loop
					if list1.item /= list2.item then
						Result := False
					end
					list1.forth
					list2.forth
				end
				list1.start
				list2.start
			end
		end

feature -- Implementation

	changeable_comparison_criterion: BOOLEAN is False
			-- May `object_comparison' be changed?
			-- (Answer: no by default.

feature {EV_ANY_I} -- Implementation

	implementation: EV_ITEM_LIST_I [G]
			-- Responsible for interaction with the underlying native graphics
			-- toolkit.

invariant
--FIXME	parent_of_items_is_current: is_useable implies parent_of_items_is_current
--FIXME	items_unique: is_useable implies items_unique
	
end -- class EV_ITEM_LIST

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
--| Revision 1.8  2000/03/15 00:58:44  king
--| Revised post-conditions for insertions
--|
--| Revision 1.7  2000/03/14 23:48:45  brendel
--| Added features `finish', `merge_left', `merge_right'.
--|
--| Revision 1.6  2000/03/08 21:44:13  king
--| Added parent set post-conditions
--|
--| Revision 1.5  2000/03/03 22:04:25  king
--| Implemented start to set index to 1
--|
--| Revision 1.4  2000/03/01 23:43:21  king
--| Added lists_equal linked_list comparison feature
--|
--| Revision 1.3  2000/02/22 18:39:49  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.2  2000/02/14 12:05:13  oconnor
--| added from prerelease_20000214
--|
--| Revision 1.1.2.12  2000/02/09 23:05:44  rogers
--| Changed the item type from EV_ITEM to G. All features that previously took 'like item' as an argument now take 'G'.
--|
--| Revision 1.1.2.11  2000/02/09 21:50:29  oconnor
--| changed like item to G in renamed features
--|
--| Revision 1.1.2.10  2000/02/09 20:56:04  oconnor
--| removed inheritcance of ev_dynamic_list
--|
--| Revision 1.1.2.9  2000/02/08 05:11:23  oconnor
--| formatting
--|
--| Revision 1.1.2.8  2000/02/08 01:44:51  king
--| Correctly implemented item_parent and its caller
--|
--| Revision 1.1.2.7  2000/02/07 20:18:56  king
--| Added remove_from_parent
--|
--| Revision 1.1.2.6  2000/02/07 19:07:44  king
--| Implemented to fit in with new ev_dynamic_list structure
--|
--| Revision 1.1.2.5  2000/02/02 23:52:23  king
--| Added code to remove item from its parent before inserting in to new
--| container
--|
--| Revision 1.1.2.4  2000/01/28 22:24:22  oconnor
--| released
--|
--| Revision 1.1.2.3  2000/01/28 19:06:49  king
--| Made ev_item_list generically constrained to ev_item
--|
--| Revision 1.1.2.2  2000/01/27 19:30:47  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.1.2.1  2000/01/24 23:19:44  oconnor
--| renamed ev_item_holder.e to ev_item_list.e
--|
--| Revision 1.6.6.7  2000/01/14 18:45:41  oconnor
--| commenting tweaks
--|
--| Revision 1.6.6.6  2000/01/14 18:42:08  oconnor
--| Added comments.
--| Added check flase to unused feature new_chain.
--|
--| Revision 1.6.6.5  1999/12/07 20:48:21  oconnor
--| inherit SET
--|
--| Revision 1.6.6.4  1999/12/02 00:07:17  oconnor
--| changed type of item to EV_ITEM from EV_LIST_ITEM
--|
--| Revision 1.6.6.3  1999/12/01 22:23:36  oconnor
--| moved item to EV_ITEM_LIST
--|
--| Revision 1.6.6.2  1999/11/30 22:40:24  oconnor
--| renamed from EV_ITEM_HOLDER to EV_ITEM_LIST, inherit DYNAMIC_LIST
--|
--| Revision 1.6.6.1  1999/11/24 17:30:48  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.6.2.3  1999/11/04 23:10:54  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.6.2.2  1999/11/02 17:20:12  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
