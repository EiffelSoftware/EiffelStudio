indexing
	description: "Eiffel Vision menu. GTK+ implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_MENU_IMP
	
inherit
	EV_MENU_I
		redefine
			interface
		end

	EV_MENU_ITEM_IMP
		redefine
			interface
		end

	EV_MENU_ITEM_LIST_IMP
		redefine
			interface
		end

create
	make

feature {EV_WINDOW_IMP} -- Implementation

	list_widget: POINTER is
			-- Widget manipulated by list operations.
			-- This is the GtkMenu.
		do
			if menu_widget = Default_pointer then
				menu_widget := C.gtk_menu_new
				C.gtk_menu_item_set_submenu (c_object, menu_widget)
				C.gtk_widget_show (menu_widget)
			end
			Result := menu_widget
		end

	menu_widget: POINTER

feature {EV_ANY_I} -- Implementation

	interface: EV_MENU
	
end -- class EV_MENU_IMP

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
--| Revision 1.24  2000/02/14 11:40:33  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.23.4.6  2000/02/04 19:02:49  brendel
--| Submenu is now set when menu is created.
--|
--| Revision 1.23.4.5  2000/02/04 04:25:39  oconnor
--| released
--|
--| Revision 1.23.4.4  2000/02/03 23:31:59  brendel
--| Revised.
--| Changed inheritance structure.
--|
--| Revision 1.23.4.3  2000/02/02 00:06:44  oconnor
--| hacking menus
--|
--| Revision 1.23.4.2  2000/01/27 19:29:50  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.23.4.1  1999/11/24 17:30:00  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.22.2.5  1999/11/17 01:53:07  oconnor
--| removed "child packing" hacks and obsolete _ref _unref wrappers
--|
--| Revision 1.22.2.4  1999/11/09 16:53:15  oconnor
--| reworking dead object cleanup
--|
--| Revision 1.22.2.3  1999/11/04 23:10:31  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.22.2.2  1999/11/02 17:20:05  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
