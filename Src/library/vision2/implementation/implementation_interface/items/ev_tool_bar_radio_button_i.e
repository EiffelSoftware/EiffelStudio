indexing
	description:
		" EiffelVision tool-bar radio button. implementation%
		% interface."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TOOL_BAR_RADIO_BUTTON_I

inherit
	EV_TOOL_BAR_BUTTON_I
		redefine
			interface
		end

	EV_RADIO_PEER_I
		redefine
			interface
		end

	EV_SELECTABLE_I
		redefine
			interface
		end

feature {AV_ANY_I} -- Implementation

	interface: EV_TOOL_BAR_RADIO_BUTTON

end -- class EV_TOOL_BAR_RADIO_BUTTON_I

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
--| Revision 1.9  2001/06/07 23:08:08  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.2.4.2  2000/05/09 21:12:42  king
--| Integrated changes to selectable/deselectable
--|
--| Revision 1.2.4.1  2000/05/03 19:08:54  oconnor
--| mergred from HEAD
--|
--| Revision 1.7  2000/04/26 22:22:15  rogers
--| Removed FIXME NOT_REVIEWED.
--|
--| Revision 1.6  2000/04/04 17:12:35  rogers
--| Now inherits EV_TOOL_BAR_SELECT_BUTTON_I, EV_RADIO_PEER_I.
--| Removed is_peer and set_peer.
--|
--| Revision 1.5  2000/02/22 18:39:40  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.4  2000/02/14 13:48:37  oconnor
--| release
--|
--| Revision 1.3  2000/02/14 11:40:34  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.2.6.2  2000/01/27 19:29:53  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.2.6.1  1999/11/24 17:30:03  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.2.2.3  1999/11/04 23:10:33  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.2.2.2  1999/11/02 17:20:05  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
