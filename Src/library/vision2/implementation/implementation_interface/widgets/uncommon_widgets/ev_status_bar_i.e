--| FIXME NOT_REVIEWED this file has not been reviewed
indexing 
	description: "EiffelVision status bar."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_STATUS_BAR_I

inherit
	EV_PRIMITIVE_I
		redefine
			interface
		end

	EV_ITEM_LIST_I [EV_STATUS_BAR_ITEM]
		redefine
			interface
		end

feature {NONE} -- Implementation

	interface: EV_STATUS_BAR

end -- class EV_STATUS_BAR_I

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
--| Revision 1.5  2000/02/14 11:40:39  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.4.6.8  2000/02/06 21:19:48  brendel
--| Removal of inheritance from EV_PRIMITIVE_I did not compile.
--| Put back while waiting for something that works.
--|
--| Revision 1.4.6.7  2000/02/05 03:15:06  oconnor
--| removed inheritance of primative
--|
--| Revision 1.4.6.6  2000/02/05 01:03:47  oconnor
--| released
--|
--| Revision 1.4.6.5  2000/01/29 01:05:02  brendel
--| Tweaked inheritance clause.
--|
--| Revision 1.4.6.4  2000/01/27 19:30:07  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.4.6.3  1999/12/17 18:19:11  rogers
--| Redfined interface to be of a more refined type.
--|
--| Revision 1.4.6.2  1999/11/30 22:45:26  oconnor
--| renamed EV_ITEM_HOLDER_I to EV_ITEM_LIST_I
--|
--| Revision 1.4.6.1  1999/11/24 17:30:15  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.4.2.2  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
