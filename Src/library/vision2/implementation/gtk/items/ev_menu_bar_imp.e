indexing
	description: "Eiffel Vision menu bar. GTK+ implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_MENU_BAR_IMP
	
inherit
	EV_MENU_BAR_I
		redefine
			interface
		end

	EV_MENU_ITEM_LIST_IMP
		redefine
			interface,
			insert_menu_item
		end
	
create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
		do
			base_make (an_interface)
			set_c_object (C.gtk_menu_bar_new)
			C.gtk_widget_show (c_object)
		end

	initialize is
		do
			is_initialized := True
		end

feature {NONE} -- Implementation

	insert_menu_item (an_item_imp: EV_ITEM_IMP; pos: INTEGER) is
			-- Generic menu item insertion.
		do
			an_item_imp.set_parent_imp (Current)
			C.gtk_menu_shell_insert (list_widget, an_item_imp.c_object, pos - 1)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_MENU_BAR

end -- class EV_MENU_BAR_IMP

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
--| Revision 1.14  2001/06/07 23:08:07  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.4.4.1  2000/05/03 19:08:52  oconnor
--| mergred from HEAD
--|
--| Revision 1.13  2000/04/26 23:49:03  king
--| Corrected external call to zero-based positioning
--|
--| Revision 1.12  2000/04/25 21:52:26  king
--| Changed back to gtk_menu_shell_insert, using list-widget instead of c_object
--|
--| Revision 1.11  2000/04/25 21:36:59  king
--| Changed external call from menu_shell to menu_bar
--|
--| Revision 1.10  2000/04/25 19:01:09  king
--| Removed gtk_reorder_child, added insert_menu_item
--|
--| Revision 1.9  2000/04/06 23:57:35  brendel
--| Added redefinition gtk_reorder_child because a gtk_menu_bar is not a menu,
--| so gtk_menu_reorder_child does not work.
--|
--| Revision 1.8  2000/04/06 02:05:13  brendel
--| Added initialization of list_widget.
--|
--| Revision 1.7  2000/04/05 21:16:10  brendel
--| Merged changes from LIST_REFACTOR_BRANCH.
--|
--| Revision 1.6.4.1  2000/04/04 23:49:17  brendel
--| *** empty log message ***
--|
--| Revision 1.6  2000/02/22 18:39:39  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.5  2000/02/14 11:40:33  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.4.6.5  2000/02/04 04:25:39  oconnor
--| released
--|
--| Revision 1.4.6.4  2000/02/04 01:17:18  brendel
--| Added gtk_widget_show in creation procedure, since it does not inherit
--| from EV_WIDGET_IMP and is not shown by default.
--|
--| Revision 1.4.6.3  2000/02/03 23:31:59  brendel
--| Revised.
--| Changed inheritance structure.
--|
--| Revision 1.4.6.2  2000/01/27 19:29:50  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.4.6.1  1999/11/24 17:29:59  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.4.2.2  1999/11/02 17:20:05  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
