indexing
	description:
			" EiffelVision item container. This class%
			% has been created to centralise the%
			% implementation of several features for%
			% EV_LIST_IMP and EV_MENU_ITEM_HOLDER%
			% Mswindows implementation."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_ITEM_LIST_IMP [G -> EV_ITEM]

inherit
	EV_ITEM_LIST_I [G]
		redefine
			initialize,
			interface
		select
			interface
		end

	EV_DYNAMIC_LIST_IMP [G, EV_ITEM_IMP]
		redefine
			interface,
			item,
			insert_i_th,
			remove_i_th
		end

	EV_PICK_AND_DROPABLE_ITEM_HOLDER_IMP
		rename
			interface as old_interface
		end

feature {NONE} -- Initialization

	initialize is
			-- Initialize `Current'.
		do
			create new_item_actions
			create remove_item_actions
			is_initialized := True
		end

feature {NONE} -- Implementation

	insert_i_th (v: like item; i: INTEGER) is
			-- Insert `v' at position `i'.
		local
			v_imp: EV_ITEM_IMP
		do
			v_imp ?= v.implementation
			check
				v_imp_not_void: v /= Void
			end
			Precursor {EV_DYNAMIC_LIST_IMP} (v, i)
			v_imp.set_parent_imp (Current)
			insert_item (v_imp, i)
			v_imp.on_parented
			new_item_actions.call ([v_imp.interface])
		end

	remove_i_th (i: INTEGER) is
			-- Remove item at `i'-th position.
		local
			v_imp: EV_ITEM_IMP
		do
			v_imp ?= i_th (i).implementation
			check
				v_imp_not_void: v_imp /= Void
			end
			v_imp.on_orphaned
			remove_item_actions.call ([v_imp.interface])
			remove_item (v_imp)
			v_imp.set_parent_imp (Void)
			Precursor (i)
		end

feature {EV_ANY_I} -- implementation

	insert_item (v_imp: EV_ITEM_IMP; pos: INTEGER) is
			-- Graphically insert `v_imp' at `pos'.
		require
			v_imp_not_void: v_imp /= Void
			pos_within_bounds: pos > 0 and pos <= count + 1
		deferred
		end

	remove_item (v_imp: EV_ITEM_IMP) is
			-- Graphically remove `v_imp'.
		require
			v_imp_not_void: v_imp /= Void
		deferred
		end

feature -- Event handling

	new_item_actions: ACTION_SEQUENCE [TUPLE [EV_ITEM]]
			-- Actions to be performed after an item is added.

	remove_item_actions: ACTION_SEQUENCE [TUPLE [EV_ITEM]]
			-- Actions to be performed before an item is removed.

feature {EV_ANY_I} -- Implementation

	interface: EV_ITEM_LIST [G]

invariant
	new_item_actions_not_void: is_usable implies new_item_actions /= Void
	remove_item_actions_not_void: is_usable implies remove_item_actions /= Void

end -- class EV_ITEM_LIST_IMP

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
--| Revision 1.32  2001/07/14 12:16:29  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.31  2001/06/07 23:08:13  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.16.4.6  2001/02/15 23:56:08  rogers
--| Replaced is_useable with is_usable.
--|
--| Revision 1.16.4.5  2000/10/25 22:45:34  rogers
--| New_item_actions and remove_item_actions are no longer created with make
--| within initialize. Default create is used instead.
--|
--| Revision 1.16.4.4  2000/07/25 00:51:07  rogers
--| Removed arguments to make procedure from action sequences.
--|
--| Revision 1.16.4.3  2000/06/20 01:00:16  manus
--| Cosmetics
--|
--| Revision 1.16.4.2  2000/05/18 23:05:20  rogers
--| Insert_i_th and remove_i_th now call set_parent_imp instead of set_parent.
--|
--| Revision 1.16.4.1  2000/05/03 19:09:17  oconnor
--| mergred from HEAD
--|
--| Revision 1.29  2000/05/02 22:56:23  rogers
--| Removed FIXME NOT_REVIEWED. Comments. Formatting.
--|
--| Revision 1.28  2000/04/11 17:04:37  rogers
--| Added inheritance from EV_PICK_AND_dROPABLE_ITEM_HOLDER_IMP.
--|
--| Revision 1.27  2000/04/05 21:16:11  brendel
--| Merged changes from LIST_REFACTOR_BRANCH.
--|
--| Revision 1.26  2000/03/30 19:53:31  rogers
--| Comments and removed unecessary FIXME.
--|
--| Revision 1.25.2.2  2000/04/05 19:52:23  brendel
--| Improved implementation.
--|
--| Revision 1.25.2.1  2000/04/03 18:21:07  brendel
--| Removed features implemented by EV_DYNAMIC_LIST_IMP.
--| Formatted for 80 columns.
--|
--| Revision 1.25  2000/03/30 17:47:12  brendel
--| Changed export status.
--|
--| Revision 1.24  2000/03/27 19:11:31  rogers
--| Removed call to remove_item_actions from prune.
--|
--| Revision 1.23  2000/03/24 19:20:25  rogers
--| Added initialize, item_parented item_orphaned, new_item_actions and
--| remove_item_actions.Set up addition and removal so new_item_actions or
--| remove_item_actions are called appropriately.
--|
--| Revision 1.22  2000/03/24 17:31:38  brendel
--| Improved comment. Removed unused local variables.
--|
--| Revision 1.21  2000/02/24 21:32:00  rogers
--| Fixed bug in put_front which would cause the cursor to point to the first
--| item, after the insertion, if the original position was off at the start,
--| i.e. index 0.
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
--| When replacing an item, the new item has the parent set accordingly,
--| before calling insert item.
--|
--| Revision 1.16.6.4  2000/01/19 20:17:18  rogers
--| This class has been changed to EV_ITEM_LIST_IMP. Added Item, added
--| insert_item and remove item as deferred. Each descendent will only need
--| these features for this class to work.
--|
--| Revision 1.16.6.3  2000/01/18 01:26:31  king
--| Commented out implementation to get it to compile.
--|
--| Revision 1.16.6.2  1999/12/17 17:07:14  rogers
--| Altered to fit in with the review branch. Now inherits EV_ITEM_LIST_IMP.
--| ev_item_holder_imp.e
--|
--| Revision 1.16.6.1  1999/11/24 17:30:21  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.16.2.2  1999/11/02 17:20:08  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------

