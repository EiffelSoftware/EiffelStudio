indexing
	description: "Eiffel Vision menu. Implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_MENU_I
	
inherit
	EV_MENU_ITEM_I
		redefine
			interface,
			parent
		end

	EV_MENU_ITEM_LIST_I
		redefine
			interface
		end

feature -- Access

	parent: EV_MENU_ITEM_LIST is
			-- Item list containing `Current'.
		do
			if parent_imp /= Void then
				Result ?= parent_imp.interface
			end
		end

feature -- Basic operations

	show is
			-- Pop up on the current pointer position.
		deferred
		end

	show_at (a_widget: EV_WIDGET; a_x, a_y: INTEGER) is
			-- Pop up on `a_x', `a_y' relative to the top-left corner
			-- of `a_widget'.
		deferred
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_MENU	

end -- class EV_MENU_I

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
--| Revision 1.24  2001/07/14 12:16:28  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.23  2001/06/07 23:08:11  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.17.4.1  2000/05/03 19:09:09  oconnor
--| mergred from HEAD
--|
--| Revision 1.22  2000/04/05 21:16:10  brendel
--| Merged changes from LIST_REFACTOR_BRANCH.
--|
--| Revision 1.21.2.1  2000/04/03 18:07:18  brendel
--| Redefined parent because it is now needed for the precondition on
--| all add-features.
--|
--| Revision 1.21  2000/03/22 23:52:22  brendel
--| Fixed feature clause name.
--|
--| Revision 1.20  2000/03/22 22:52:00  brendel
--| Added show and show_at.
--|
--| Revision 1.19  2000/02/22 18:39:45  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.18  2000/02/14 11:40:39  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.17.6.6  2000/02/04 04:10:28  oconnor
--| released
--|
--| Revision 1.17.6.5  2000/02/03 23:32:00  brendel
--| Revised.
--| Changed inheritance structure.
--|
--| Revision 1.17.6.4  2000/02/02 00:06:45  oconnor
--| hacking menus
--|
--| Revision 1.17.6.3  2000/01/27 19:30:06  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.17.6.2  1999/12/17 18:19:11  rogers
--| Redfined interface to be of a more refined type.
--|
--| Revision 1.17.6.1  1999/11/24 17:30:15  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.17.2.3  1999/11/04 23:10:46  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.17.2.2  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
