indexing
	description: "EiffelVision check menu. GTK+ implementation."
	status: "See notice at end of class"
	date: "$Date$";
	revision: "$Revision$"

class
	EV_CHECK_MENU_ITEM_IMP

inherit
	EV_CHECK_MENU_ITEM_I
		redefine
			interface
		end

	EV_MENU_ITEM_IMP
		redefine
			make,
			interface
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a menu.
		do
			base_make (an_interface)
			set_c_object (C.gtk_check_menu_item_new)
			C.gtk_check_menu_item_set_show_toggle (c_object, True)
			C.gtk_check_menu_item_set_active (c_object, False)
		end

feature -- Status report

	is_selected: BOOLEAN is
			-- Is this menu item checked?
		do
			Result := C.gtk_check_menu_item_struct_active (c_object).to_boolean
		end

feature -- Status setting

	enable_select is
			-- Select this menu item.
		do
			C.gtk_check_menu_item_set_active (c_object, True)
		end

	disable_select is
			-- Deselect this menu item.
		do
			C.gtk_check_menu_item_set_active (c_object, False)
		end

	toggle is
			-- Invert the value of `is_selected'.
		do
			C.gtk_check_menu_item_set_active (c_object, not is_selected)
		end

feature {NONE} -- Implementation

	interface: EV_CHECK_MENU_ITEM

end -- class EV_CHECK_MENU_ITEM_IMP

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
--| Revision 1.20  2001/06/07 23:08:01  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.13.4.2  2000/05/09 21:46:45  king
--| Intergrated selectable/deselectable
--|
--| Revision 1.13.4.1  2000/05/03 19:08:35  oconnor
--| mergred from HEAD
--|
--| Revision 1.18  2000/02/25 01:57:00  brendel
--| Removed imp of `enable_select' and `selected' since it now inherits
--| EV_SELECT_MENU_ITEM_IMP.
--|
--| Revision 1.17  2000/02/22 20:02:44  brendel
--| Removed comment because that turned out not to be true.
--| Default state of check menu items is unchecked.
--|
--| Revision 1.16  2000/02/22 18:39:34  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.15  2000/02/18 19:26:05  king
--| Corrected is_selected
--|
--| Revision 1.14  2000/02/14 11:40:27  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.13.6.5  2000/02/05 01:36:33  brendel
--| Inherits from EV_MENU_ITEM_IMP instead of EV_MENU_IMP.
--|
--| Revision 1.13.6.4  2000/02/04 04:25:36  oconnor
--| released
--|
--| Revision 1.13.6.3  2000/02/03 23:31:59  brendel
--| Revised.
--| Changed inheritance structure.
--|
--| Revision 1.13.6.2  2000/01/27 19:29:24  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.13.6.1  1999/11/24 17:29:42  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.13.2.2  1999/11/02 17:20:02  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
