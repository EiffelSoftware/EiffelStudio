indexing	
	description: "Eiffel Vision list item list. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_LIST_ITEM_LIST_IMP

inherit
	EV_LIST_ITEM_LIST_I
		redefine
			interface
		end

	EV_ITEM_LIST_IMP [EV_LIST_ITEM]
		redefine
			interface
		end

	EV_LIST_ITEM_LIST_ACTION_SEQUENCES_IMP

feature {EV_ANY_I} -- Access

	ev_children: ARRAYED_LIST [EV_LIST_ITEM_IMP]
			-- List of the children.

feature {EV_LIST_ITEM_IMP} -- Implementation

	image_list: EV_IMAGE_LIST_IMP
			-- Image list to store all images required by items.

	setup_image_list is
			-- Create the image list and associate it
			-- to `Current' if not already associated.
		deferred
		end
	
	remove_image_list is
			-- disassociate `image_list' from `Current'.
		deferred
		end

	pixmaps_size_changed is
			-- The size of the displayed pixmaps has just
			-- changed.
		local
			pixmap: EV_PIXMAP
			cur: CURSOR
		do
				-- We only do this if there are images associated with
				-- `Current'.
			if image_list /= Void then
					
					-- Rebuild the image list.
				remove_image_list
				setup_image_list

					-- Save cursor position
				cur := ev_children.cursor

					-- Insert the image of each list item
					-- back into the image list.
				from
					ev_children.start
				until
					ev_children.after
				loop
					pixmap := ev_children.item.pixmap
					if pixmap /= Void then
						ev_children.item.set_pixmap_in_parent
					end
					ev_children.forth
				end		
					-- Restore saved_position
				ev_children.go_to (cur)
			end
		ensure then
			child_index_consistent: old ev_children.index = ev_children.index
		end

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
			-- `Result' is index of `item_imp' in the list.
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
   			-- Retrieves the position of the zero-based `an_index'-th item.
   		deferred
   		end

feature {EV_ANY_I} -- Implementation

	set_pixmap_of_child (an_item: EV_LIST_ITEM_IMP; position, image_index: INTEGER) is
			-- Set pixmap of `an_item' at position `position' in `Current'
			-- to the `image_index'th image in `image_list'.
		deferred
		end

	remove_pixmap_of_child (an_item: EV_LIST_ITEM_IMP; position: INTEGER) is
			-- Remove pixmap of `an_item' located at position `position' in
			-- `Current'.
		deferred
		end

feature {EV_LIST_ITEM_IMP} -- Implementation

	top_index: INTEGER is
			-- Index of item displayed at the top of `Current'.
		deferred
		end
	
	visible_count: INTEGER is
   			-- Number of items that can be displayed at once.
		deferred
		end

	insert_item (item_imp: EV_LIST_ITEM_IMP; an_index: INTEGER) is
			-- Insert `item_imp' at `an_index' position.
		deferred
		end

	remove_item (item_imp: EV_LIST_ITEM_IMP) is
			-- Remove `item_imp'.
		deferred
		end

	refresh_item (item_imp: EV_LIST_ITEM_IMP) is
			-- Refresh current so that it take into account 
			-- changes made in `item_imp' 
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

feature {EV_ANY_I} -- Implementation

	interface: EV_LIST_ITEM_LIST

end -- class EV_LIST_ITEM_LIST_IMP

--|-----------------------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
--|-----------------------------------------------------------------------------

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.10  2001/07/14 12:46:25  manus
--| Replace --! by --|
--|
--| Revision 1.9  2001/07/14 12:16:29  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.8  2001/06/07 23:08:13  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.6.2.10  2000/08/21 20:27:21  rogers
--| Added remove_pixmap_of_child as deferred.
--|
--| Revision 1.6.2.8  2000/07/28 02:42:06  pichery
--| Fixed bug in `set_text' of EV_LIST_ITEM_IMP (changes
--| were not reflected in the parent if the item was already in a
--| list).
--|
--| Revision 1.6.2.7  2000/07/24 23:58:12  rogers
--| Now inherits EV_LIST_ITEM_LIST_ACTION_SEQUENCES_IMP.
--|
--| Revision 1.6.2.6  2000/07/18 20:40:59  rogers
--| Added pixmaps_size_changed. This was previously identical in both
--| EV_COMBO_BOX_IMP and Ev_LIST_IMP.
--|
--| Revision 1.6.2.5  2000/07/17 18:06:10  rogers
--| Added remove_image_list as deferred.
--|
--| Revision 1.6.2.4  2000/07/14 17:47:07  rogers
--| Added image_list for association of pixmaps, and added setup_image_list
--| as deferred.
--|
--| Revision 1.6.2.3  2000/06/12 23:04:50  rogers
--| Removed FIXME NOT_REVIEWED. COmments, formatting.
--|
--| Revision 1.6.2.2  2000/05/10 20:01:02  king
--| Integrated interface
--|
--| Revision 1.6.2.1  2000/05/03 19:09:18  oconnor
--| mergred from HEAD
--|
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
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------

