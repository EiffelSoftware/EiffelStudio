indexing
	description: 
		"EiffelVision vertical box. Implementation interface."
	status: "See notice at end of class"
	keywords: "container, box, vertical"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_VERTICAL_BOX_I
	
inherit
	EV_BOX_I
		redefine
			interface
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_VERTICAL_BOX

end -- class EV_VERTICAL_BOX_I

--|-----------------------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|-----------------------------------------------------------------------------

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.8  2001/07/14 12:46:24  manus
--| Replace --! by --|
--|
--| Revision 1.7  2001/07/14 12:16:28  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.6  2001/06/07 23:08:10  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.3.4.2  2000/10/06 20:11:48  oconnor
--| cosmetics
--|
--| Revision 1.3.4.1  2000/05/03 19:09:05  oconnor
--| mergred from HEAD
--|
--| Revision 1.5  2000/02/22 18:39:43  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.4  2000/02/14 11:40:37  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.3.6.5  2000/02/04 04:09:08  oconnor
--| released
--|
--| Revision 1.3.6.4  2000/01/27 19:30:02  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.3.6.3  1999/12/17 18:21:40  rogers
--| Redfined interface to be of a more refined type.
--|
--| Revision 1.3.6.2  1999/12/15 18:33:05  oconnor
--| formatting
--|
--| Revision 1.3.6.1  1999/11/24 17:30:11  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.3.2.2  1999/11/02 17:20:06  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
