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
		-- Actual widget parent of `Current' when PND starts.
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

	top_level_window_imp: EV_WINDOW_IMP is
		do
			Result := parent_imp.top_level_window_imp
		end

	pnd_press (a_x, a_y, a_button, a_screen_x, a_screen_y: INTEGER) is
			-- Process a pointer press that may alter the current state
			-- of pick/drag and drop.
		do
			if press_action = Ev_pnd_start_transport then
					-- Now check the correct pointer_button was pressed to start 
					-- The transport, otherwise, do nothing.
				if (a_button = 1 and not mode_is_pick_and_drop) or
					(a_button = 3 and mode_is_pick_and_drop) then
					set_pnd_original_parent
					start_transport (a_x, a_y, a_button, 0, 0, 0.5, a_screen_x,
						a_screen_y)
					pnd_original_parent.set_parent_source_true
					pnd_original_parent.set_item_source (Current)
					pnd_original_parent.set_item_source_true
				end
			elseif press_action = Ev_pnd_end_transport then
				end_transport (a_x, a_y, a_button, 0, 0, 0.5, a_screen_x, a_screen_y)
				pnd_original_parent.set_parent_source_false
				pnd_original_parent.set_item_source (Void)
				pnd_original_parent.set_item_source_false
					-- If the user cancelled a pick and drop with the left
					-- button then we need to make sure that the
					-- pointer_button_press_actions are not called on
					-- `pnd_original_parent' or an item at the current
					-- pointer position within `pnd_original_parent'.
				if a_button = 1 then
					pnd_original_parent.discard_press_event
				end
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
			original_x := -1
			original_y := -1
			application_imp.end_awaiting_movement
			awaiting_movement := False	
			if mode_is_drag_and_drop and press_action =
				Ev_pnd_end_transport then
				end_transport (a_x, a_y, 1, 0, 0, 0, 0, 0)
				pnd_original_parent.set_parent_source_false
				pnd_original_parent.set_item_source (Void)
				pnd_original_parent.set_item_source_false
			else
				original_top_level_window_imp.move_to_foreground
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
			pnd_original_parent.set_capture
		end

	release_capture is
			-- Release user input.
			-- Works only on current windows thread.
		do
			pnd_original_parent.release_capture
		end

	set_heavy_capture is
			-- Grab user input.
			-- Works on all windows threads.
		do
			pnd_original_parent.set_heavy_capture
		end

	release_heavy_capture is
			-- Release user input.
			-- Works on all windows threads.
		do
			pnd_original_parent.release_heavy_capture
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
--| Revision 1.8  2001/06/07 23:08:12  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.6.2.17  2001/06/04 22:13:13  rogers
--| Removed redundent require else.
--|
--| Revision 1.6.2.16  2001/02/16 17:31:13  rogers
--| We now call move_to_foreground on `original_top_level_window_imp' in
--| check_drag_and_drop_release. The check in pnd_press has been changed into
--| a pre condition.
--|
--| Revision 1.6.2.15  2001/02/10 01:42:42  rogers
--| `Check_drag_and_drop_release' now accesses the application through
--| `application_imp'.
--|
--| Revision 1.6.2.14  2001/02/10 00:32:11  rogers
--| Check_drag_and_drop_release now resets `awaiting_movement' within the
--| application.
--|
--| Revision 1.6.2.13  2001/02/08 18:05:58  rogers
--| Removed uneeded call to move_to_foreground.
--|
--| Revision 1.6.2.12  2001/02/06 19:30:07  rogers
--| Check_drag_and_drop_release now calls `allow_movement'
--| on `top_level_window_imp' before attempting to move
--| `top_level_window_imp' to foreground. Fixes bug, where releasing the left
--| button before the drag and drop had started would not raise
--| `top_level_window_imp' to foreground.
--|
--| Revision 1.6.2.11  2000/12/29 00:33:40  rogers
--| Pnd_press now calls discard_press_event on `pnd_original_parent' if the
--| left button is pressed.
--|
--| Revision 1.6.2.10  2000/11/02 17:54:15  rogers
--| Pressing any button apart from the right will raise `Current' to the
--| foreground. The exception is pressing the left button when drag and drop is
--| enabled on `Current'.
--|
--| Revision 1.6.2.9  2000/11/02 17:27:13  rogers
--| Middle button presses now raise `Current' to foreground.
--|
--| Revision 1.6.2.8  2000/10/30 22:30:49  rogers
--| Corrected comment of `pnd_original_parent'. Fixed set_capture,
--| release_capture, set_heavy_capture and release_heavy_capture so they
--| all are executed on `pnd_original_parent' which fixes a bug in pick
--| and drop for tree items.
--|
--| Revision 1.6.2.7  2000/10/25 23:19:35  rogers
--| Last log message should have read : fixed release capture.
--|
--| Revision 1.6.2.6  2000/10/25 23:03:57  rogers
--| Modifiedcvs diff
--|
--| Revision 1.6.2.5  2000/10/24 18:47:17  king
--| Updated end_transport signature
--|
--| Revision 1.6.2.4  2000/07/19 21:44:44  rogers
--| Fixed pnd_press so that if press_action = Ev_pnd_start_transport,
--| our internal variables which hold the state of the pick and drop, will
--| now only be set when a pick/drag and drop is about to start. This fixes
--| a nasty bug.
--|
--| Revision 1.6.2.3  2000/06/12 20:24:09  rogers
--| Removed FIXME NOT_REVIEWED. Added comment.
--|
--| Revision 1.6.2.2  2000/05/15 22:02:57  rogers
--| Added top_level_window which is the window containing `Current'. Pnd_press
--| and check_drag_and_drop_release both call move_to_foreground on
--| top_level_ window as required.
--|
--| Revision 1.6.2.1  2000/05/03 19:09:14  oconnor
--| mergred from HEAD
--|
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

