--| FIXME NOT_REVIEWED this file has not been reviewed
indexing	
	description: "Eiffel Vision list item list. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_LIST_ITEM_LIST_IMP

inherit
	EV_ITEM_LIST_IMP [EV_LIST_ITEM]

feature {EV_ANY_I} -- Access

	ev_children: ARRAYED_LIST [EV_LIST_ITEM_IMP]
			-- List of the children

feature {EV_LIST_ITEM_IMP} -- Implementation

	internal_is_selected (item_imp: EV_LIST_ITEM_IMP): BOOLEAN is
			-- Is `item_imp' selected in the list?
		deferred
		end

	internal_deselect_item (item_imp: EV_LIST_ITEM_IMP) is
			-- Deselect `item_imp' in the list.
		deferred
		end

	internal_select_item (item_imp: EV_LIST_ITEM_IMP) is
			-- Select `item_imp' in the list.
		deferred
		end

	internal_get_index (item_imp: EV_LIST_ITEM_IMP): INTEGER is
			-- Return the index of `item_imp' in the list.
		require
			item_imp_not_void: item_imp /= Void
			ev_children_has_item: ev_children.has (item_imp)
		deferred
		ensure
			Result_within_bounds:
				Result > 0 and then Result <= ev_children.count
			correct_index:
				(ev_children @ Result) = item_imp
		end

   	get_item_position (an_index: INTEGER): WEL_POINT is
   			-- Retrieves the position of the zero-based `index'-th item.
   		deferred
   		end

feature {EV_LIST_ITEM_IMP} -- Implementation

	top_index: INTEGER is
			-- Index of item at displayed at top of list.
		deferred
		end
	
	visible_count: INTEGER is
   			-- Number of items that can be displayed.
		deferred
		end

	insert_item (item_imp: EV_LIST_ITEM_IMP; an_index: INTEGER) is
			-- Insert `item_imp' at `an_index'.
		deferred
		end

	remove_item (item_imp: EV_LIST_ITEM_IMP) is
			-- Remove `item_imp'.
		deferred
		end

feature {EV_LIST_ITEM_IMP} -- Pick & Drop

	set_pointer_style (c: EV_CURSOR) is
			-- Assign `c' to `parent_imp' pointer style.
		deferred
		end

	set_capture is
			-- Grab user input.
		deferred
		end

	release_capture is
			-- Release user input.
		deferred
		end

	set_heavy_capture is
			-- Grab user input.
		deferred
		end

	release_heavy_capture is
			-- Release user input.
		deferred
		end

end -- class EV_LIST_ITEM_LIST_IMP

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
--| Revision 1.6  2000/04/20 01:11:18  pichery
--| Complete Refactoring.
--|
--| Revision 1.5  2000/04/18 22:35:57  pichery
--| Reborn removed file
--|
--| Revision 1.3  2000/04/05 21:16:11  brendel
--| Merged changes from LIST_REFACTOR_BRANCH.
--|
--| Revision 1.2.2.1  2000/04/05 19:53:31  brendel
--| Removed calls to ev_children by graphical insert/remove features.
--|
--| Revision 1.2  2000/03/30 18:10:32  brendel
--| Added deferred features `top_index', `item_height' and
--| `set_pointer_style'.
--|
--| Revision 1.1  2000/03/30 17:31:58  brendel
--| New class as common list ancestor for EV_LIST_IMP and EV_COMBO_BOX_IMP.
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------

