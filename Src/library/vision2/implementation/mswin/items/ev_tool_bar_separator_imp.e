indexing
	description:
		"Eiffel Vision tool bar separator. Mswindows implemenatation."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_SEPARATOR_IMP

inherit
	EV_TOOL_BAR_SEPARATOR_I
		undefine
			parent
		select
			interface
		end

	EV_TOOL_BAR_BUTTON_IMP
		rename
			interface as ev_tool_bar_button_interface
		end

creation
	make

end -- class EV_TOOL_BAR_SEPARATOR_IMP

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
--| Revision 1.13  2001/06/07 23:08:12  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.5.4.2  2000/06/12 18:25:12  rogers
--| Reviewed class. Comments, formatting. Removed tb_parent_imp and
--| old_item_parent_imp.
--|
--| Revision 1.5.4.1  2000/05/03 19:09:11  oconnor
--| mergred from HEAD
--|
--| Revision 1.12  2000/04/26 22:19:56  rogers
--| Removed type as now redundent.
--|
--| Revision 1.11  2000/04/11 17:31:51  brendel
--| Removed inh. of EV_SEPARATOR_ITEM_IMP again.
--|
--| Revision 1.10  2000/04/11 17:11:20  rogers
--| Now inherits EV_SEPARATOR_ITEM_IMP. Redefined interface.
--|
--| Revision 1.9  2000/04/10 17:44:09  brendel
--| Removed inheritance of obsolete class EV_SEPARATOR_ITEM.
--|
--| Revision 1.8  2000/02/19 05:44:59  oconnor
--| released
--|
--| Revision 1.7  2000/02/19 04:35:44  oconnor
--| added deferred features
--|
--| Revision 1.6  2000/02/14 11:40:39  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.5.6.3  2000/01/27 19:30:09  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.5.6.2  2000/01/21 18:09:01  rogers
--| Renamed interface inherited from ev_tool_bar_button_imp as
--| ev_tool_bar_button_imp_interface. Selected interface inherited from
--| EV_TOOL_BAR_SEPARATOR_I.
--|
--| Revision 1.5.6.1  1999/11/24 17:30:17  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.5.2.2  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
