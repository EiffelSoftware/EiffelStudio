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
			pnd_press
		end

feature -- Access

	parent_imp: EV_ITEM_LIST_IMP [EV_ITEM] is
		deferred
		end
	
	pnd_press (a_x, a_y, a_button, a_screen_x, a_screen_y: INTEGER) is
		do
			check
				parent_not_void: parent_imp /= Void
			end
			if press_action = Ev_pnd_start_transport then
				start_transport (a_x, a_y, a_button, 0, 0, 0.5, a_screen_x,
					a_screen_y)
				parent_imp.set_parent_source_true
				parent_imp.set_item_source (Current)
				parent_imp.set_item_source_true
			elseif press_action = Ev_pnd_end_transport then
				end_transport (a_x, a_y, a_button)
				parent_imp.set_parent_source_false
				parent_imp.set_item_source (Void)
				parent_imp.set_item_source_false
			else
				parent_imp.set_parent_source_false
				parent_imp.set_item_source (Void)
				parent_imp.set_item_source_false
				check
					disabled: press_action = Ev_pnd_disabled
				end
			end
		end

	set_pointer_style (c: EV_CURSOR) is
			-- Assign `c' to `parent_imp' pointer style.
		do
			if parent_imp /= Void then
				parent_imp.set_pointer_style (c)
			end
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

