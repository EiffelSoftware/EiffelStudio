indexing
	description:
		"Eiffel Vision popup menu handler. Invisible window that lets%N%
		%`menu_item_list' receive click commands."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_POPUP_MENU_HANDLER

inherit
	WEL_FRAME_WINDOW
		redefine
			on_menu_command
		end

create
	make_with_menu

feature {NONE} -- Initialization

	make_with_menu (a_menu: EV_MENU_ITEM_LIST_IMP) is
			-- Initialize with `a_menu'.
		require
			a_menu_not_void: a_menu /= Void
		do
			make_top ("EV_POPUP_MENU_HANDLER")
			menu_item_list := a_menu
			set_menu (menu_item_list)
		end

feature {NONE} -- Implementation

	menu_item_list: EV_MENU_ITEM_LIST_IMP
			-- Connected menu.

	on_menu_command (an_id: INTEGER) is
			-- Propagate to `menu'.
		do
			menu_item_list.menu_item_clicked (an_id)
		end

end -- class EV_POPUP_MENU_HANDLER

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
--| Revision 1.6  2001/07/14 12:46:25  manus
--| Replace --! by --|
--|
--| Revision 1.5  2001/07/14 12:16:29  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.4  2001/06/07 23:08:13  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.3.2.1  2000/05/03 19:09:18  oconnor
--| mergred from HEAD
--|
--| Revision 1.3  2000/04/07 22:33:27  brendel
--| Indexing clause.
--|
--| Revision 1.2  2000/03/23 00:53:35  brendel
--| Now inherits WEL_FRAME_WINDOW because WEL_COMPOSITE_WINDOW is deferred.
--|
--| Revision 1.1  2000/03/22 23:45:47  brendel
--| Initial.
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------


