indexing
	description: "Eiffel Vision radio menu item. GTK+ implementation."
	status: "See notice at end of class"
	date: "$Date$";
	revision: "$Revision$"

class
	EV_RADIO_MENU_ITEM_IMP

inherit
	EV_RADIO_MENU_ITEM_I
		redefine
			interface
		end

	EV_MENU_ITEM_IMP
		redefine
			on_activate,
			interface,
			make
		end

	EV_RADIO_PEER_IMP
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a menu item.
		do
			base_make (an_interface)
			set_c_object (C.gtk_radio_menu_item_new (NULL))
			C.gtk_check_menu_item_set_show_toggle (c_object, True)
			C.gtk_check_menu_item_set_active (c_object, True)
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

feature {EV_ANY_I} -- Implementation

	on_activate is
		do
			if is_selected then
				Precursor
			end
		end

	set_radio_group (a_gslist: POINTER) is
			-- Make current a member of `a_gslist' radio group.
		do
			C.gtk_radio_menu_item_set_group (c_object, a_gslist)
		end

	radio_group: POINTER is
		do
			Result := C.gtk_radio_menu_item_group (c_object)
		end

	interface: EV_RADIO_MENU_ITEM

end -- class EV_RADIO_MENU_ITEM_IMP

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
--| Revision 1.21  2001/06/07 23:08:01  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.11.4.3  2000/06/02 21:05:27  king
--| Added select_actions bug fix
--|
--| Revision 1.11.4.2  2000/05/09 21:46:45  king
--| Intergrated selectable/deselectable
--|
--| Revision 1.11.4.1  2000/05/03 19:08:36  oconnor
--| mergred from HEAD
--|
--| Revision 1.19  2000/05/02 18:55:19  oconnor
--| Use NULL instread of Defualt_pointer in C code.
--| Use eiffel_to_c (a) instead of a.to_c.
--|
--| Revision 1.18  2000/04/25 18:44:07  king
--| Added set_radio_group, gslist->radio-group
--|
--| Revision 1.17  2000/02/25 01:54:56  brendel
--| Added inheritance of EV_RADIO_PEER_IMP, which means: effecting of `gslist'
--| and features `peers' and `selected_peer' could be removed.
--|
--| Revision 1.16  2000/02/24 20:48:54  brendel
--| Changed in compliance with interface.
--|
--| Revision 1.15  2000/02/24 01:41:41  king
--| Added peers to make compile, needs implementing
--|
--| Revision 1.14  2000/02/22 20:03:40  brendel
--| Removed old implementation, since grouping is now handled by
--| EV_MENU_ITEM_LIST_IMP.
--|
--| Revision 1.13  2000/02/22 18:39:34  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.12  2000/02/14 11:40:27  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.11.6.2  2000/01/27 19:29:25  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.11.6.1  1999/11/24 17:29:43  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.11.2.3  1999/11/04 23:10:26  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.11.2.2  1999/11/02 17:20:02  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
