--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing	
	description: 
		"EiffelVision radio menu item. Implementatino interface."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_RADIO_MENU_ITEM_I

inherit
	EV_CHECK_MENU_ITEM_I

feature -- Status report

	is_peer (peer: EV_RADIO_MENU_ITEM): BOOLEAN is
			-- Is this item in same group as peer
		require
		deferred
		end


feature -- Status Setting

	set_peer (peer: EV_RADIO_MENU_ITEM) is
			-- Put in same group as peer
		require
		deferred
		ensure
			same_group: is_peer(peer)
		end

	
end -- class EV_RADIO_MENU_ITEM_I

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
--| Revision 1.4  2000/02/14 11:40:34  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.3.6.2  2000/01/27 19:29:52  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.3.6.1  1999/11/24 17:30:03  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.3.2.3  1999/11/04 23:10:32  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.3.2.2  1999/11/02 17:20:05  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
