indexing
	description: "Eiffel Vision radio button. Implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_RADIO_BUTTON_I

inherit
	EV_BUTTON_I
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

feature {EV_ANY_I} -- Implementation

	interface: EV_RADIO_BUTTON

end -- class EV_RADIO_BUTTON_I

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
--| Revision 1.11  2001/06/07 23:08:10  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.3.4.2  2000/05/09 20:31:08  king
--| Integrated selectable/deselectable
--|
--| Revision 1.3.4.1  2000/05/03 19:09:07  oconnor
--| mergred from HEAD
--|
--| Revision 1.9  2000/02/25 21:28:15  brendel
--| Formatting.
--|
--| Revision 1.8  2000/02/25 01:48:12  brendel
--| Revised.
--|
--| Revision 1.7  2000/02/24 18:11:44  oconnor
--| New inheritance structure for buttons with state.
--| New class EV_SELECT_BUTTON provides `is_selected' and `enable_select'.
--| RADIO_BUTTON inherits this, as does TOGGLE_BUTTON which adds
--| `disable_select' and `toggle'.
--|
--| Revision 1.6  2000/02/22 18:39:44  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.5  2000/02/17 02:19:54  oconnor
--| removed set_peer and remove_from_group, obsolete
--|
--| Revision 1.4  2000/02/14 11:40:38  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.3.6.3  2000/01/27 19:30:04  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.3.6.2  2000/01/07 00:59:14  king
--| Implemented to fit in with new structure
--|
--| Revision 1.3.6.1  1999/11/24 17:30:13  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.3.2.2  1999/11/02 17:20:06  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
