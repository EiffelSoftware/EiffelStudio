--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: 
		"EiffelVision popup menu, implementation interface"
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_POPUP_MENU_I

inherit
	EV_ANY_I

	EV_MENU_ITEM_HOLDER_I 

feature -- Access

	parent_imp: EV_CONTAINER_IMP is
			-- Implementation of the parent.
		deferred
		end

feature -- Status setting

	show is
			-- Show the popup menu at the current position
			-- of the mouse.
		require
			valid_parent: parent_imp /= Void
		deferred
		end

	show_at_position (x, y: INTEGER) is
			-- Show the popup menu at the given position
		require
			valid_parent: parent_imp /= Void
		deferred
		end

feature -- Element change

	set_parent (par: EV_CONTAINER) is
			-- Make `par' the new parent of the popup.
		deferred
		end

end -- class EV_POPUP_MENU_I

--!----------------------------------------------------------------
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
--!----------------------------------------------------------------


--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.8  2000/02/14 11:40:39  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.7.6.4  2000/02/04 19:57:52  oconnor
--| unreleased
--|
--| Revision 1.7.6.3  2000/02/04 04:10:28  oconnor
--| released
--|
--| Revision 1.7.6.2  2000/01/27 19:30:07  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.7.6.1  1999/11/24 17:30:15  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.7.2.3  1999/11/04 23:10:46  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.7.2.2  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
