indexing	
	description: "Eiffel Vision radio menu item. Implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_RADIO_MENU_ITEM_I

inherit
	EV_CHECK_MENU_ITEM_I
		redefine
			interface
		end

feature -- Status report

	peers: LINKED_LIST [like interface] is
			-- List of all radio items in the group `Current' is in.
		deferred
		ensure
			not_void: Result /= Void
			different_list_every_time: Result /= peers
		end

feature {NONE} -- Implementation

	interface: EV_RADIO_MENU_ITEM

end -- class EV_RADIO_MENU_ITEM_I

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
--| Revision 1.7  2000/02/24 01:36:59  brendel
--| Added feature set_peer.
--|
--| Revision 1.6  2000/02/22 19:55:09  brendel
--| Changed in compliance with interface.
--|
--| Revision 1.5  2000/02/22 18:39:40  oconnor
--| updated copyright date and formatting
--|
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
