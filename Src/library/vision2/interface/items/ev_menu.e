indexing
	description: "Eiffel Vision menu. Menu items that can have a submenu."
	status: "See notice at end of class"
	keywords: "menu, bar, drop down, popup"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MENU

inherit
	EV_MENU_ITEM
		redefine
			implementation,
			create_implementation,
			create_action_sequences
		end
	
	EV_MENU_ITEM_LIST
		redefine
			implementation,
			create_implementation,
			create_action_sequences
		end

create
	default_create,
	make_with_text

feature {NONE} -- Initialization

	create_implementation is
			-- Create implementation of menu.
		do
			create {EV_MENU_IMP} implementation.make (Current)
		end

	create_action_sequences is
		do
			{EV_MENU_ITEM} Precursor
			{EV_MENU_ITEM_LIST} Precursor
		end

feature {EV_ANY_I} -- Implementation

	implementation: EV_MENU_I	

end -- class EV_MENU

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
--| Revision 1.19  2000/02/14 11:40:53  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.18.6.6  2000/02/04 01:05:40  brendel
--| Rearranged inheritance structure in compliance with revised interface.
--| Nothing has been implemented yet!
--|
--| Revision 1.18.6.5  2000/02/03 23:32:01  brendel
--| Revised.
--| Changed inheritance structure.
--|
--| Revision 1.18.6.4  2000/02/02 00:06:46  oconnor
--| hacking menus
--|
--| Revision 1.18.6.3  2000/01/28 22:24:26  oconnor
--| released
--|
--| Revision 1.18.6.2  2000/01/27 19:30:58  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.18.6.1  1999/11/24 17:30:57  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.18.2.3  1999/11/04 23:10:55  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.18.2.2  1999/11/02 17:20:13  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
