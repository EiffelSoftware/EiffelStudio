--| FIXME NOT REVIEWED
indexing
	description: 
		"EiffelVision dynamic list abstract interface."
	status: "See notice at end of class"
	keywords: "widget list, container"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_DYNAMIC_LIST [G]

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

	extend (v: like item) is
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
		end

	replace (v: like item) is
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
		end

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

feature -- Removal

	prune (v: like item) is
			-- Remove `v' if present.
		do
			if has (v) then
				implementation.prune (v)
			end
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
			item_par: EV_DYNAMIC_LIST [G]
		do
			Result := True
			c := cursor
			from
				start
			until
				after or Result = False
			loop
				item_par ?= item_parent (item)
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

	item_parent (an_item: like item): EV_ANY is
			-- Parent of `an_item'.
		deferred
		end

feature {EV_ANY_I} -- Implementation

	implementation: EV_DYNAMIC_LIST_I [G]
			-- Responsible for interaction with the underlying native graphics
			-- toolkit.

invariant
--FIXME	parent_of_items_is_current: is_useable implies parent_of_items_is_current
--FIXME	items_unique: is_useable implies items_unique
	
end -- class EV_DYNAMIC_LIST

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
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
--| Revision 1.2  2000/02/14 12:05:13  oconnor
--| added from prerelease_20000214
--|
--| Revision 1.1.2.9  2000/02/08 05:11:02  oconnor
--| added inheritance of EV_ANY, c-ed out invariant, its stuffed, needs to be fixed
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
