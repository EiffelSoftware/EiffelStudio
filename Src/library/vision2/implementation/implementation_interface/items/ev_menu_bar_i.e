indexing
	description: "Eiffel Vision menu bar. Implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_MENU_BAR_I
	
inherit
	EV_MENU_ITEM_LIST_I
		redefine
			interface
		end
		
feature -- Status report

	parent: EV_WINDOW is
			-- Parent of `Current'.
		deferred
		end
		

feature {EV_ANY} -- Implementation

	interface: EV_MENU_BAR	

end -- class EV_MENU_BAR_I

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
--| Revision 1.11  2001/07/14 12:16:28  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.10  2001/06/21 18:50:15  rogers
--| Implemented parent as deferred.
--|
--| Revision 1.9  2001/06/07 23:08:11  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.6.4.1  2000/05/03 19:09:09  oconnor
--| mergred from HEAD
--|
--| Revision 1.8  2000/02/22 18:39:45  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.7  2000/02/14 11:40:39  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.6.6.4  2000/02/04 04:10:28  oconnor
--| released
--|
--| Revision 1.6.6.3  2000/02/03 23:32:00  brendel
--| Revised.
--| Changed inheritance structure.
--|
--| Revision 1.6.6.2  2000/01/27 19:30:06  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.6.6.1  1999/11/24 17:30:14  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.6.2.2  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
