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
		undefine
			parent,
			show
		redefine
			interface,
			initialize
		end

	EV_MENU_ITEM_LIST_IMP
		redefine
			interface,
			initialize,
			list_widget
		end

create
	make

feature {NONE} -- Initialization

	initialize is
		do
			list_widget := C.gtk_menu_new
			C.gtk_widget_show (list_widget)
			C.gtk_menu_item_set_submenu (
				c_object, list_widget
			)
			Precursor
		end

feature -- Basic operations

	show is
			-- Pop up on the current pointer position.
		do
			if not interface.empty then
				C.gtk_menu_popup (list_widget, Default_pointer,
					Default_pointer, Default_pointer,
					Default_pointer, 0, 0)
			end
		end

	show_at (a_widget: EV_WIDGET; a_x, a_y: INTEGER) is
			-- Pop up on `a_x', `a_y' relative to the top-left corner
			-- of `a_widget'.
		do
			check
				to_be_implemented: False
			end
		end

feature {EV_ANY_I} -- Implementation

	list_widget: POINTER

	interface: EV_MENU
	
end -- class EV_MENU_IMP

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
--| Revision 1.32  2000/04/19 16:16:41  brendel
--| Submenu is now always visible again, like on Windows.
--|
--| Revision 1.31  2000/04/14 15:50:18  brendel
--| Corrected removal of submenu.
--|
--| Revision 1.30  2000/04/13 18:56:15  brendel
--| Changed so that submenu arrow is only shown when it has submenu items.
--|
--| Revision 1.29  2000/04/06 23:58:35  brendel
--| Renamed menu_widget to list_widget.
--|
--| Revision 1.28  2000/04/05 21:16:10  brendel
--| Merged changes from LIST_REFACTOR_BRANCH.
--|
--| Revision 1.27.2.2  2000/04/05 00:01:41  brendel
--| removed menu_widget.
--| list_widget is now initialized at creation time.
--|
--| Revision 1.27.2.1  2000/04/04 16:27:33  brendel
--| Undefined parent.
--|
--| Revision 1.27  2000/03/23 02:29:13  brendel
--| Implemented `show'.
--|
--| Revision 1.26  2000/03/22 22:57:55  brendel
--| Added show and show_at. Marked as "to be implemented".
--|
--| Revision 1.25  2000/02/22 18:39:39  oconnor
--| updated copyright date and formatting
--|
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
