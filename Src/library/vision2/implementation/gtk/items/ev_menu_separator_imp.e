indexing
	description: "Eiffel Vision menu separator. GTK+ implementation."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MENU_SEPARATOR_IMP

inherit
	EV_MENU_SEPARATOR_I
		redefine
			interface
		end

	EV_MENU_ITEM_IMP
		redefine
			make,
			interface,
			initialize
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a menu.
		do
			base_make (an_interface)
			set_c_object (C.gtk_menu_item_new)
			C.gtk_widget_show (c_object)
		end
	
	initialize is
			-- Do nothing because an empty GtkMenuItem is a separator.
		do
			textable_imp_initialize
			pixmapable_imp_initialize
			initialize_menu_sep_box
			create radio_group_ref
			is_initialized := True
		end

	initialize_menu_sep_box is
			-- Create and initialize menu item box.
			--| This is just to satisfy pixmapable and textable contracts.
		local
			box: POINTER
		do
			box := C.gtk_hbox_new (False, 0)
			C.gtk_widget_hide (box)
			C.gtk_box_pack_start (box, text_label, True, True, 0)
			C.gtk_box_pack_start (box, pixmap_box, True, True, 0)
		end

feature {EV_MENU_ITEM_LIST_IMP} -- Implementation

	radio_group_ref: POINTER_REF

	set_radio_group (p: POINTER) is
			-- Assign `p' to `radio_group'.
		do
			radio_group_ref.set_item (p)
		end

	radio_group: POINTER is
			-- GSList with all radio items of this container.
		do
			Result := radio_group_ref.item
		end

feature {NONE} -- Implementation

	interface: EV_MENU_SEPARATOR

end -- class EV_MENU_SEPARATOR_IMP

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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.12  2001/06/07 23:08:01  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.6.4.1  2000/05/03 19:08:35  oconnor
--| mergred from HEAD
--|
--| Revision 1.11  2000/04/27 23:36:53  king
--| Added pointer ref functions for radio grouping
--|
--| Revision 1.10  2000/04/11 23:18:04  brendel
--| Speling.
--|
--| Revision 1.9  2000/02/22 19:59:38  brendel
--| Added features `radio_group' and `set_radio_group' to save the need for
--| a list in EV_MENU_ITEM_LIST_IMP.
--|
--| Revision 1.8  2000/02/22 18:39:34  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.7  2000/02/14 11:40:27  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.6.6.5  2000/02/05 01:38:12  brendel
--| Implemented.
--|
--| Revision 1.6.6.4  2000/02/04 04:25:36  oconnor
--| released
--|
--| Revision 1.6.6.3  2000/02/03 23:31:59  brendel
--| Revised.
--| Changed inheritance structure.
--|
--| Revision 1.6.6.2  2000/01/27 19:29:25  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.6.6.1  1999/11/24 17:29:43  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.6.2.2  1999/11/02 17:20:02  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
