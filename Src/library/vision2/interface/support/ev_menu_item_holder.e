--| FIXME NOT_REVIEWED this file has not been reviewed
indexing

	description: 
		"EiffelVision menu item container. Abstract class and a common ancestor classes that can contain menu items."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_MENU_ITEM_HOLDER

inherit
	EV_ITEM_LIST [EV_MENU_ITEM]
		redefine
			implementation
		end

feature -- Implementation

	implementation: EV_MENU_ITEM_HOLDER_I

feature {NONE} -- Implementation

	item_type: EV_MENU_ITEM is
			-- Gives a type.
		do
		end

end -- class EV_MENU_ITEM_HOLDER

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
--| Revision 1.12  2000/02/14 11:40:49  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.11.6.5  2000/01/29 01:05:04  brendel
--| Tweaked inheritance clause.
--|
--| Revision 1.11.6.4  2000/01/28 22:24:22  oconnor
--| released
--|
--| Revision 1.11.6.3  2000/01/27 19:30:47  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.11.6.2  1999/11/30 22:40:24  oconnor
--| renamed from EV_ITEM_HOLDER to EV_ITEM_LIST, inherit DYNAMIC_LIST
--|
--| Revision 1.11.6.1  1999/11/24 17:30:48  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.11.2.2  1999/11/02 17:20:12  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
