--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		"Mswindows implementation of pick and dropable for items."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PICK_AND_DROPABLE_ITEM_IMP

inherit
	EV_PICK_AND_DROPABLE_IMP
		undefine
			set_pointer_style
		redefine
			pnd_press,
			check_drag_and_drop_release
		end

feature -- Access

	pnd_original_parent: EV_ITEM_LIST_IMP [EV_ITEM]
		-- Parent of `Current' when PND starts.
		--| This is required as the item's parent may change during
		--| exection of the actions, while we still need to access it
		--| after the actions have been called.

	set_pnd_original_parent is
			-- Assign `parent_imp' to `pnd_original_parent'.
			--| This is done as a feature rather than just an assignment
			--| within pnd_press as EV_TREE_ITEM_IMP needs to store
			--| top_parent_imp. This allows a simply redefinition of
			--| this feature rather than pnd_press which would lead
			--| to unecessary code duplication. 
		do
			pnd_original_parent := parent_imp
		end
		
	parent_imp: EV_ITEM_LIST_IMP [EV_ITEM] is
			-- Parent implementation of `Current'.
		deferred
		end

	pnd_press (a_x, a_y, a_button, a_screen_x, a_screen_y: INTEGER) is
		do
			check
				parent_not_void: parent_imp /= Void
			end
			if press_action = Ev_pnd_start_transport then
				set_pnd_original_parent
				start_transport (a_x, a_y, a_button, 0, 0, 0.5, a_screen_x,
					a_screen_y)
				pnd_original_parent.set_parent_source_true
				pnd_original_parent.set_item_source (Current)
				pnd_original_parent.set_item_source_true
			elseif press_action = Ev_pnd_end_transport then
				end_transport (a_x, a_y, a_button)
				pnd_original_parent.set_parent_source_false
				pnd_original_parent.set_item_source (Void)
				pnd_original_parent.set_item_source_false
			else
				pnd_original_parent.set_parent_source_false
				pnd_original_parent.set_item_source (Void)
				pnd_original_parent.set_item_source_false
				check
					disabled: press_action = Ev_pnd_disabled
				end
			end
		end

	check_drag_and_drop_release (a_x, a_y: INTEGER) is
			-- End transport if in drag and drop.
			--| Releasing the left button ends drag and drop.
		do
			if mode_is_drag_and_drop and press_action =
				Ev_pnd_end_transport then
				end_transport (a_x, a_y, 1)
				pnd_original_parent.set_parent_source_false
				pnd_original_parent.set_item_source (Void)
				pnd_original_parent.set_item_source_false
			end
		end

	set_pointer_style (c: EV_CURSOR) is
			-- Assign `c' to `parent_imp' pointer style.
		do
			if parent_imp /= Void then
				parent_imp.set_pointer_style (c)
			end
		end

	set_capture is
			-- Grab user input.
			-- Works only on current windows thread.
		do
			parent_imp.set_capture
		end

	release_capture is
			-- Release user input.
			-- Works only on current windows thread.
		do
			parent_imp.set_capture
		end

	set_heavy_capture is
			-- Grab user input.
			-- Works on all windows threads.
		do
			parent_imp.set_heavy_capture
		end

	release_heavy_capture is
			-- Release user input
			-- Works on all windows threads.
		do
			parent_imp.release_heavy_capture
		end

end -- class EV_PICK_AND_DROPABLE_ITEM_IMP

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
--| Revision 1.6  2000/04/27 23:02:48  rogers
--| Redefined check_drag_and_drop_release from
--| EV_PICK_AND_DROPABLE_IMP.
--|
--| Revision 1.5  2000/04/21 21:51:18  rogers
--| Added set_capture, release_capture, set_heavy_capture and
--| release_heavy_capture. Each item had these previously.
--|
--| Revision 1.4  2000/04/14 23:30:13  rogers
--| Added pnd_original_parent and set_pnd_original_parent.
--|
--| Revision 1.3  2000/04/14 21:48:01  brendel
--| Released.
--|
--| Revision 1.2  2000/04/12 18:56:20  brendel
--| Unreleased.
--| Cosmetics.
--| Added copyright notice.
--| Added CVS Log.
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------

