indexing
	description: 
		"EiffelVision container that contains a list of widgets."
	status: "See notice at end of class"
	keywords: "widget list, container"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_WIDGET_LIST

inherit
	EV_CONTAINER
		undefine
			prune_all
		redefine
			implementation
		end

	DYNAMIC_LIST [EV_WIDGET]
		rename
			prune as dl_prune,
			extend as dl_extend,
			replace as dl_replace,
			put as dl_put,
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
		select
			dl_put
		end

	SET [EV_WIDGET]
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
			-- Move cursor to first position.
		do
			go_i_th (1)
		ensure then
			empty_implies_after: empty implies after
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

	put_front (v: like item) is
			-- If `v' not already in list add to beginning.
			-- Do not move cursor.
			-- Remove `v' from existing parent.
		require
			v_not_void: v /= Void
			not_has_v: not has (v)
		do
			implementation.put_front (v)
		ensure
			item_inserted: has (v)
			new_count: count = old count + 1
			item_inserted: first = v
		end

	put_right (v: like item) is
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
			item_inserted: has (v)
	 		new_count: count = old count + 1
	 		same_index: index = old index
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

	prune (v: like item) is
			-- Remove `v' if present.
			-- If cursor was on `v', move to right or after.
			-- Do not move cursor otherwise.
		do
			implementation.prune (v)
		end

	remove is
			-- Remove current item.
			-- Move cursor to right neighbor
			-- (or `after' if no right neighbor).
		do
			implementation.remove
		end

	remove_left is
			-- Remove item to the left of cursor position.
			-- Do not move cursor.
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
		do
			Result := True
			c := cursor
			from
				start
			until
				after or Result = False
			loop
				if item.parent /= Current then
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
			l: LINKED_LIST [EV_WIDGET]
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

feature {NONE} -- Implementation

	implementation: EV_WIDGET_LIST_I
			-- Responsible for interaction with the underlying native graphics
			-- toolkit.

invariant
	parent_of_items_is_current: is_useable implies parent_of_items_is_current
	items_unique: is_useable implies items_unique

end -- class EV_WIDGET_LIST

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
--| Revision 1.12  2000/03/03 19:41:04  brendel
--| Removed feature `put_left'.
--|
--| Revision 1.11  2000/03/03 18:31:12  brendel
--| Added redefinition of `put_left', since the implementation in
--| DYNAMIC_CHAIN causes the invariant to be called.
--|
--| Revision 1.10  2000/03/03 16:51:13  brendel
--| off -> after
--|
--| Revision 1.9  2000/03/02 20:09:05  brendel
--| Fixed minor bug in contract support features.
--|
--| Revision 1.8  2000/03/02 19:47:08  brendel
--| Added redefinition of `merge_left' and `merge_right', because the
--| original implementation removes the items explicitly and our versions
--| of `put_right', `put_left' adn `put_front' delete an item automatically
--| when it was in another list.
--|
--| Revision 1.7  2000/03/02 18:01:45  oconnor
--| improved prune comment further :)
--|
--| Revision 1.6  2000/03/02 17:09:52  brendel
--| Improved comment on `prune'.
--|
--| Revision 1.5  2000/03/02 01:32:43  brendel
--| Removed conditional `has (v)' from feature `prune', to let the
--| implementation take care of this.
--|
--| Revision 1.4  2000/02/26 06:26:07  oconnor
--| added extra postconditions to start and finish
--|
--| Revision 1.3  2000/02/22 18:39:51  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.2  2000/02/14 12:05:14  oconnor
--| added from prerelease_20000214
--|
--| Revision 1.1.4.17  2000/02/08 09:36:54  oconnor
--| Removed inheritance of EV_DYNAMIC_LIST
--| This created more problems than it solved.
--| Most preconditions and invaraints require somthing better that G
--| as the item type and there with ireconsilable noconformities involving like
--|
--| Revision 1.1.4.16  2000/02/08 05:11:31  oconnor
--| formatting
--|
--| Revision 1.1.4.15  2000/02/08 01:44:51  king
--| Correctly implemented item_parent and its caller
--|
--| Revision 1.1.4.14  2000/02/08 00:19:38  king
--| Changed inheritence to deal with changes in ev_dynamic_list
--|
--| Revision 1.1.4.13  2000/02/07 20:19:42  king
--| Added remove_from_parent
--|
--| Revision 1.1.4.12  2000/02/07 19:08:12  king
--| Implemented to fit in with new ev_dynamic_list structure
--|
--| Revision 1.1.4.11  2000/01/28 20:00:15  oconnor
--| released
--|
--| Revision 1.1.4.10  2000/01/28 16:45:05  oconnor
--| changed replace from  if has (v) then  to  if not has (v) then
--|
--| Revision 1.1.4.9  2000/01/27 19:30:53  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.1.4.8  2000/01/17 18:03:16  oconnor
--| added checks and comments to prevent insertion of Void items
--|
--| Revision 1.1.4.7  2000/01/17 03:18:21  oconnor
--| fixed comments, removed io.putstring (index.out) from remove_left
--|
--| Revision 1.1.4.6  1999/12/17 19:46:31  rogers
--| Now inherits EV_INVISIBLE_CONTAINER instead of EV_CONTAINER. Will only now
--| add an item if the item is not already in the list.
--|
--| Revision 1.1.4.5  1999/12/15 20:17:30  oconnor
--| reworking box formatting, contracts and names
--|
--| Revision 1.1.4.4  1999/12/15 17:38:47  oconnor
--| formatting
--|
--| Revision 1.1.4.3  1999/12/15 17:03:41  oconnor
--| formatting
--|
--| Revision 1.1.4.2  1999/11/30 22:16:36  oconnor
--| comment improvements
--|
--| Revision 1.1.4.1  1999/11/24 00:15:57  oconnor
--| merged from REVIEW_BRANCH_19991006
--|
--| Revision 1.1.2.3  1999/11/17 02:01:58  oconnor
--| inherit SET
--|
--| Revision 1.1.2.2  1999/11/09 16:53:16  oconnor
--| reworking dead object cleanup
--|
--| Revision 1.1.2.1  1999/11/05 18:02:35  oconnor
--| initial
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
