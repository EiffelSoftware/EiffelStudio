--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
			" EiffelVision item container. This class%
			% has been created to centralise the%
			% implementation of several features for%
			% EV_LIST_IMP and EV_MENU_ITEM_HOLDER"
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_ITEM_LIST_IMP [G -> EV_ITEM]

inherit
	EV_ITEM_LIST_I [G]
		redefine
			initialize,
			item
		end

feature {NONE} -- Initialization

	initialize is
		do
			create new_item_actions.make ("new item", <<"item">>)
			new_item_actions.extend (~item_parented)
			create remove_item_actions.make ("remove item", <<"item">>)
			remove_item_actions.extend (~item_orphaned)
			is_initialized := True
		end

feature -- Access

	item: G is
			-- Item pointed to by `index'.
		local
			p_imp: EV_ITEM_IMP
			aa: ASSIGN_ATTEMPT [G]
		do
			p_imp := ev_children.item
			if p_imp /= Void then
				create aa
				Result := aa.attempt (p_imp.interface)
			end
		end

	cursor: CURSOR is
		local
			temp_cursor: ARRAYED_LIST_CURSOR
		do	
			Result := ev_children.cursor
		end

	index: INTEGER is
		do
			Result := ev_children.index
		end

feature {EV_ANY_I} -- implementation

	item_parented (i: EV_ITEM) is
			-- Called every time an item is added to the container.
		require
			i_not_void: i /= Void
		local
			i_imp: EV_ITEM_IMP
		do
			i_imp ?= i.implementation
			i_imp.on_parented
		end

	item_orphaned (i: EV_ITEM) is
			-- Called every time an item is removed from the container.
		require
			i_not_void: i /= Void
		local
			i_imp: EV_ITEM_IMP
		do
			i_imp ?= i.implementation
			i_imp.on_orphaned
		end

	insert_item (item_imp: ev_item_imp; pos: INTEGER) is
		deferred
		ensure
			item_on_pos_is_item_imp: ev_children.i_th (pos).is_equal (item_imp)
		end

	remove_item (item_imp: ev_item_imp) is
		deferred
		end

	forth is
		do
			ev_children.forth
		end

	back is
		do
			ev_children.back
		end

	extend (v: like item) is
			-- If `v' not already in list add to end.
			-- Do not move cursor.
		local
			old_index: INTEGER
		do
			old_index := index
			item_to_imp (v).set_parent (interface)
			insert_item (item_to_imp (v), count + 1)
			ev_children.go_i_th (old_index)
			new_item_actions.call ([v])
		end

	remove_left is
			-- Remove item to the left of cursor position.
			-- Do not move cursor.
		local
			old_index: INTEGER
				-- `Index' value at entry.
		do
			old_index := index
			back
			remove
			ev_children.go_i_th (old_index - 1)
		end

	remove_right is
			-- Remove item the the right of cursor position.
			-- Do not move cursor.
		local
			old_index: INTEGER
				-- `Index' value at entry.
		do
			old_index := index
			forth
			remove
			ev_children.go_i_th (old_index)
		end

	remove is
			-- Remove current item.
			-- Move cursor to right neighbor
			-- (or `after' if no right neighbor).
		local
			item_imp: EV_ITEM_IMP
		do
			remove_item_actions.call ([item])
			item_imp := item_to_imp (item)
			check
				item_implementation_not_void: item_imp /= Void
			end
			--| FIXME Switched bottom 2 statements.
			--| The parent may not be Void before calling remove_item
			--| because menu items cannot work without their parent.
			remove_item (item_imp)
			item_imp.set_parent (Void)
		end
	
	prune (v: like item) is
			-- Remove `v' if present.
		local
			w: EV_ITEM_IMP
			original_index: INTEGER
		do
			w ?= item_to_imp (v)
			original_index := index
			from
				ev_children.start
			until
				ev_children.after or else ev_children.item = w
			loop
				ev_children.forth
			end
			if not ev_children.after then
				remove
			end		
			ev_children.go_i_th (original_index)
		end


	put_right (v: like item) is
			-- Add `v' to the right of cursor position.
			-- Do not move cursor.
		do
			item_to_imp (v).set_parent (interface)
			insert_item (item_to_imp (v), index + 1)
			new_item_actions.call ([v])
		end
		
	put_front (v: like item) is
			-- Add `v' to front.
			-- Do not move cursor.
		local
			original_index: INTEGER
		do
			original_index := index
			item_to_imp (v).set_parent (interface)
			insert_item (item_to_imp (v), 1)
			if original_index > 0 then	
				ev_children.go_i_th (original_index + 1)
			else
				ev_children.go_i_th (0)
			end
			new_item_actions.call ([v])
		end

	replace (v: like item) is
			-- Replace current item by `v'.
			-- Do not move cursor
		do
			remove
			if index > 1 then
				item_to_imp (v).set_parent (interface)
				insert_item (item_to_imp (v), index)
				move (1)
			else
				put_front (v)
				move (-1)
			end
			new_item_actions.call ([v])
		end

	move (i: INTEGER) is
			-- Move cursor `i' positions.
		do
			ev_children.move (i)
		end

	go_to (c: CURSOR) is
			-- Move cursor to position `c'
		do
			ev_children.go_to (c)
		end

	valid_cursor (c: CURSOR):BOOLEAN is
			-- Can the cursor be moved to position `c'.
		do
			Result := ev_children.valid_cursor (c)
		end

	ev_children:ARRAYED_LIST [EV_ITEM_IMP] is
		deferred
		end

feature -- Implementation

	item_to_imp (an_item: EV_ITEM): EV_ITEM_IMP is
			-- Get implementation from `an_item'.
		require
			an_item_not_void: an_item /= Void
		do
			Result ?= an_item.implementation
			check
				has_implementation: Result /= Void
			end
		ensure
			not_void: Result /= Void
		end

feature -- Event handling

	new_item_actions: ACTION_SEQUENCE [TUPLE [EV_ITEM]]
			-- Actions to be performed after an item is added.

	remove_item_actions: ACTION_SEQUENCE [TUPLE [EV_ITEM]]
			-- Actions to be performed before an item is removed.

invariant
	new_item_actions_not_void: is_useable implies new_item_actions /= Void
	remove_item_actions_not_void: is_useable implies remove_item_actions /= Void

end -- class EV_ITEM_LIST_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.

--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|---------------------------------------------------------------- 

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.24  2000/03/27 19:11:31  rogers
--| Removed call to remove_item_actions from prune.
--|
--| Revision 1.23  2000/03/24 19:20:25  rogers
--| Added initialize, item_parented item_orphaned, new_item_actions and remove_item_actions.Set up addition and removal so new_item_actions or remove_item_actions are called appropriately.
--|
--| Revision 1.22  2000/03/24 17:31:38  brendel
--| Improved comment. Removed unused local variables.
--|
--| Revision 1.21  2000/02/24 21:32:00  rogers
--| Fixed bug in put_front which would cause the cursor to point to the first item, after the insertion, if the original position was off at the start, i.e. index 0.
--|
--| Revision 1.20  2000/02/24 01:30:05  brendel
--| Switched 2 statemnts in `remove'.
--| Added precondition on item_to_imp.
--|
--| Revision 1.19  2000/02/22 20:15:37  brendel
--| Added postcondition for insert_item.
--|
--| Revision 1.18  2000/02/19 06:59:04  manus
--| released
--|
--| Revision 1.17  2000/02/14 11:40:41  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.16.6.11  2000/02/03 21:33:10  rogers
--| Fixed prune, so cursor is not moved.
--|
--| Revision 1.16.6.10  2000/02/03 21:18:01  rogers
--| Implemented prune. Moved position in text of cursor and index.
--|
--| Revision 1.16.6.9  2000/02/03 19:48:57  rogers
--| Added put_left.
--|
--| Revision 1.16.6.8  2000/02/01 03:48:07  brendel
--| Added special assignment attempt to get correct generic type.
--|
--| Revision 1.16.6.7  2000/01/29 01:05:02  brendel
--| Tweaked inheritance clause.
--|
--| Revision 1.16.6.6  2000/01/27 19:30:15  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.16.6.5  2000/01/24 21:30:03  rogers
--| When replacing an item, the new item has the parent set accordingly, before calling insert item.
--|
--| Revision 1.16.6.4  2000/01/19 20:17:18  rogers
--| This class has been changed to EV_ITEM_LIST_IMP. Added Item, added insert_item and remove item as deferred. Each descendent will only need these features for this class to work.
--|
--| Revision 1.16.6.3  2000/01/18 01:26:31  king
--| Commented out implementation to get it to compile.
--|
--| Revision 1.16.6.2  1999/12/17 17:07:14  rogers
--| Altered to fit in with the review branch. Now inherits EV_ITEM_LIST_IMP. ev_item_holder_imp.e
--|
--| Revision 1.16.6.1  1999/11/24 17:30:21  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.16.2.2  1999/11/02 17:20:08  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
