indexing
	description:
		"Eiffel Vision tool bar separator. Implementation interface."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TOOL_BAR_SEPARATOR_I

inherit
	EV_ITEM_I

end -- class EV_TOOL_BAR_SEPARATOR_I

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
--| Revision 1.13  2001/06/07 23:08:08  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.6.4.2  2000/08/17 20:07:42  rogers
--| Reviewed file. Removed redefinition of parent.
--|
--| Revision 1.6.4.1  2000/05/03 19:08:54  oconnor
--| mergred from HEAD
--|
--| Revision 1.12  2000/04/12 17:55:10  brendel
--| Description.
--|
--| Revision 1.11  2000/04/10 20:00:58  brendel
--| Fixed precursor construct.
--|
--| Revision 1.10  2000/04/10 18:30:25  brendel
--| EV_TOOL_BAR_ITEM_I -> EV_ITEM_I since non-existent.
--|
--| Revision 1.9  2000/04/10 17:44:10  brendel
--| Removed inheritance of obsolete class EV_SEPARATOR_ITEM.
--|
--| Revision 1.8  2000/02/22 18:39:40  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.7  2000/02/14 11:40:34  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.6.6.5  2000/02/04 04:02:41  oconnor
--| released
--|
--| Revision 1.6.6.4  2000/02/02 00:48:52  king
--| Corrected inheritence from item_list from tb button to tb item
--|
--| Revision 1.6.6.3  2000/01/28 18:54:18  king
--| Removed redundant features, changed to generic structure of ev_item_list
--|
--| Revision 1.6.6.2  2000/01/27 19:29:53  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.6.6.1  1999/11/24 17:30:03  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.6.2.2  1999/11/02 17:20:05  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
