--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "Eiffel Vision menu item list"
	status: "See notice at end of class"
	keywords: "menu, bar, drop down, popup"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_MENU_ITEM_LIST

inherit
	EV_ITEM_LIST [EV_MENU_ITEM]

	--| FIXME redefine add-functions of itemlist since the submenu's may
	--| not have a parent yet.

end -- class EV_MENU_ITEM_LIST

--!-----------------------------------------------------------------------------
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
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.2  2000/02/14 12:05:14  oconnor
--| added from prerelease_20000214
--|
--| Revision 1.1.2.1  2000/02/03 23:32:01  brendel
--| Revised.
--| Changed inheritance structure.
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
