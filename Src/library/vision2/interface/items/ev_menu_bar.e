indexing
	description:
		"Menu bar containing drop down menus. See EV_MENU."
	status: "See notice at end of class"
	keywords: "menu, bar, item, file, edit, help"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MENU_BAR

inherit
	EV_MENU_ITEM_LIST
		redefine
			implementation,
			create_implementation
		end

create
	default_create

feature {NONE} -- Initialization

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_MENU_BAR_IMP} implementation.make (Current)
		end

feature -- Status report

	parent: EV_MENU_ITEM_LIST is
			-- Container of `Current'.
		do
			-- Menu bars have no menu item list as parent.
		end

feature {EV_ANY_I} -- Implementation

	implementation: EV_MENU_BAR_I
			-- Responsible for interaction with the native graphics toolkit.

end -- class EV_MENU BAR

--!-----------------------------------------------------------------------------
--! EiffelVision : library of reusable components for ISE Eiffel.
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
--!----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.12  2000/04/05 21:16:23  brendel
--| Merged changes from LIST_REFACTOR_BRANCH.
--|
--| Revision 1.11.2.1  2000/04/03 18:15:15  brendel
--| Implemented parent. Always returns Void.
--|
--| Revision 1.11  2000/03/17 01:23:34  oconnor
--| formatting and layout
--|
--| Revision 1.10  2000/02/29 18:09:11  oconnor
--| reformatted indexing cluase
--|
--| Revision 1.9  2000/02/22 18:39:52  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.8  2000/02/14 11:40:53  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.7.6.6  2000/02/04 22:12:46  king
--| Changed export clause of implementation to ev_any_i
--|
--| Revision 1.7.6.5  2000/02/03 23:32:01  brendel
--| Revised.
--| Changed inheritance structure.
--|
--| Revision 1.7.6.4  2000/02/02 00:06:46  oconnor
--| hacking menus
--|
--| Revision 1.7.6.3  2000/01/28 22:24:26  oconnor
--| released
--|
--| Revision 1.7.6.2  2000/01/27 19:30:58  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.7.6.1  1999/11/24 17:30:57  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.7.2.2  1999/11/02 17:20:13  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
