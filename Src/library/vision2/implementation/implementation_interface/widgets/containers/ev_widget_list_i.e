indexing
	description: 
		"EiffelVision widget list. Implementation interface."
	status: "See notice at end of class"
	keywords: "widget list, container"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_WIDGET_LIST_I

inherit
	EV_CONTAINER_I
		redefine
			interface
		end

	EV_DYNAMIC_LIST_I [EV_WIDGET]
		redefine
			interface
		end

feature {EV_ANY_I} -- implementation

	interface: EV_WIDGET_LIST

end -- class WIDGET_LIST

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
--| Revision 1.9  2001/07/14 12:46:24  manus
--| Replace --! by --|
--|
--| Revision 1.8  2001/07/14 12:16:28  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.7  2001/06/07 23:08:10  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.6.2.1  2000/05/03 19:09:05  oconnor
--| mergred from HEAD
--|
--| Revision 1.6  2000/04/05 21:16:10  brendel
--| Merged changes from LIST_REFACTOR_BRANCH.
--|
--| Revision 1.5.4.1  2000/04/03 18:06:23  brendel
--| Removed all feature now implemented by EV_DYNAMIC_LIST_I.
--|
--| Revision 1.5  2000/03/03 19:41:05  brendel
--| Removed feature `put_left'.
--|
--| Revision 1.4  2000/03/03 18:31:55  brendel
--| Added deferred feature `put_left'.
--|
--| Revision 1.3  2000/02/22 18:39:44  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.2  2000/02/14 12:05:09  oconnor
--| added from prerelease_20000214
--|
--| Revision 1.1.4.10  2000/02/08 09:36:57  oconnor
--| emoved inheritance of EV_DYNAMIC_LIST
--| This created more problems than it solved.
--| Most preconditions and invaraints require somthing better that G
--| as the item type and there with ireconsilable noconformities involving like
--|
--| Revision 1.1.4.9  2000/02/07 19:01:37  king
--| Converted to new ev_dynamic_list structure
--|
--| Revision 1.1.4.8  2000/02/04 04:09:08  oconnor
--| released
--|
--| Revision 1.1.4.7  2000/01/27 19:30:02  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.1.4.6  2000/01/17 19:22:43  oconnor
--| inherit from EV_CONTAINER_I instead of EV_INVISIBLE_CONTAINER_I
--|
--| Revision 1.1.4.5  2000/01/17 18:02:41  oconnor
--| added preconditions to prevent insertion of Void items
--|
--| Revision 1.1.4.4  1999/12/17 18:21:02  rogers
--| Now inherits from EV_INVISIBLE_CONTAINER_I instead of EV_CONTAINER_I.
--|
--| Revision 1.1.4.3  1999/12/15 17:03:41  oconnor
--| formatting
--|
--| Revision 1.1.4.2  1999/11/30 22:48:43  oconnor
--| Redefined interface to more refined type
--|
--| Revision 1.1.4.1  1999/11/24 17:30:11  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.1.2.3  1999/11/17 01:57:02  oconnor
--| added move and prune removed full
--|
--| Revision 1.1.2.2  1999/11/09 16:53:16  oconnor
--| reworking dead object cleanup
--|
--| Revision 1.1.2.1  1999/11/05 18:24:32  oconnor
--| initial
--|
--| Revision 1.1.2.1  1999/11/05 18:02:35  oconnor
--| initial
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
