indexing
	description: "Eiffel Vision menu item list. Implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_MENU_ITEM_LIST_I
	
inherit
	EV_ITEM_LIST_I [EV_MENU_ITEM]

	EV_MENU_ITEM_LIST_ACTION_SEQUENCES_I

end -- class EV_MENU_ITEM_LIST_I

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
--| Revision 1.4  2001/06/07 23:08:10  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.3.6.2  2000/07/24 21:30:47  oconnor
--| inherit action sequences _I class
--|
--| Revision 1.3.6.1  2000/05/03 19:09:05  oconnor
--| mergred from HEAD
--|
--| Revision 1.3  2000/02/22 18:39:43  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.2  2000/02/14 12:05:09  oconnor
--| added from prerelease_20000214
--|
--| Revision 1.1.2.2  2000/02/04 04:09:08  oconnor
--| released
--|
--| Revision 1.1.2.1  2000/02/03 23:32:00  brendel
--| Revised.
--| Changed inheritance structure.
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
