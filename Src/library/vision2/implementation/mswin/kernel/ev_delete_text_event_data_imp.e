--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "EiffelVision delete text event data"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DELETE_TEXT_EVENT_DATA_IMP

inherit
	EV_DELETE_TEXT_EVENT_DATA_I

	EV_RICH_TEXT_EVENT_DATA_IMP
		rename
			set_all as set_all_rich_text
		end

end -- class EV_DELETE_TEXT_EVENT_DATA_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
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
--|----------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.2  2000/02/14 11:40:40  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.1.10.2  2000/01/27 19:30:10  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.1.10.1  1999/11/24 17:30:17  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.1.6.2  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
