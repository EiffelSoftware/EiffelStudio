indexing
	description: "EiffelVision toolbar. Implementation interface."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TOOL_BAR_I

inherit
	EV_PRIMITIVE_I
		redefine
			interface
		end

	EV_ITEM_LIST_I [EV_TOOL_BAR_ITEM]
		redefine
			interface
		end

feature {NONE} -- Implementation

	interface: EV_TOOL_BAR

end -- class EV_TOOL_BAR_I

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
--| Revision 1.15  2001/07/14 12:46:24  manus
--| Replace --! by --|
--|
--| Revision 1.14  2001/07/14 12:16:29  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.13  2001/06/07 23:08:10  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.8.4.2  2000/08/18 16:15:04  rogers
--| removed fixme not_Reviewed. Comments. Removed set_default_options as redundent.
--|
--| Revision 1.8.4.1  2000/05/03 19:09:07  oconnor
--| mergred from HEAD
--|
--| Revision 1.12  2000/04/11 23:30:07  king
--| Removed connect_radio_grouping
--|
--| Revision 1.11  2000/04/04 17:05:08  rogers
--| Added connect_radio_grouping.
--|
--| Revision 1.10  2000/02/22 18:39:44  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.9  2000/02/14 11:40:38  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.8.6.9  2000/02/04 04:10:28  oconnor
--| released
--|
--| Revision 1.8.6.8  2000/02/01 20:11:16  king
--| Altered inheritence from item_list to deal with new generic item structure
--|
--| Revision 1.8.6.7  2000/01/28 19:08:36  king
--| Converted to fit in with generic structure of ev_item_list
--|
--| Revision 1.8.6.6  2000/01/27 19:30:06  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.8.6.5  2000/01/26 23:22:42  king
--| Removed redundant creation routines
--|
--| Revision 1.8.6.4  1999/12/17 17:49:31  rogers
--| Redefined interface to be of more refined type. set_vetical_resize and set_horizontal_Resize are no longer applicable.
--|
--| Revision 1.8.6.3  1999/12/09 03:15:07  oconnor
--| commented out make_with_* features, these should be in interface only
--|
--| Revision 1.8.6.2  1999/12/01 19:23:09  rogers
--| Changed inheritance structure from EV_ITEM_HOLDER_I to EV_ITEM_LIST_I
--|
--| Revision 1.8.6.1  1999/11/24 17:30:14  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.8.2.2  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
