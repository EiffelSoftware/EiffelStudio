indexing
	description: "Eiffel Vision menu item. GTK+ implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_MENU_ITEM_IMP
	
inherit
	EV_MENU_ITEM_I
		redefine
			interface
		end

	EV_SIMPLE_ITEM_IMP
		redefine
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
			connect_signal_to_actions ("activate", interface.press_actions)
		end
	
	initialize is
			-- Call to both precursors.
		do
			textable_imp_initialize
			pixmapable_imp_initialize
			initialize_menu_item_box
			--set_pixmap (create {EV_PIXMAP}.make_with_size (16, 16))
			{EV_SIMPLE_ITEM_IMP} Precursor
		end

	initialize_menu_item_box is
			-- Create and initialize menu item box.
		local
			box: POINTER
		do
			box := C.gtk_hbox_new (False, 0)
			C.gtk_container_add (c_object, box)
			C.gtk_widget_show (box)

			C.gtk_box_pack_start (box, pixmap_box, False, True, 0)
			C.gtk_widget_hide (pixmap_box)
			C.gtk_box_pack_start (box, text_label, True, True, 0)
			C.gtk_widget_show (text_label)
		ensure
			menu_item_box /= default_pointer
		end
	
feature {EV_ANY_I} -- Implementation

	menu_item_box: POINTER is
		do
			Result := C.gtk_container_children (c_object)
			Result := C.g_list_nth_data (Result, 0)
		end

	interface: EV_MENU_ITEM

end -- class EV_MENU_ITEM_IMP

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
--| Revision 1.37  2000/02/14 11:40:27  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.36.6.8  2000/02/05 01:37:14  brendel
--| Cleanup.
--|
--| Revision 1.36.6.7  2000/02/04 04:25:36  oconnor
--| released
--|
--| Revision 1.36.6.6  2000/02/04 01:15:02  brendel
--| Added connect to activate signal in creation.
--|
--| Revision 1.36.6.5  2000/02/03 23:31:59  brendel
--| Revised.
--| Changed inheritance structure.
--|
--| Revision 1.36.6.4  2000/02/02 00:06:44  oconnor
--| hacking menus
--|
--| Revision 1.36.6.3  2000/01/27 19:29:25  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.36.6.2  1999/11/30 17:25:13  brendel
--| Added redefine of initialize because of change in EV_TEXTABLE_IMP.
--|
--| Revision 1.36.6.1  1999/11/24 17:29:42  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.36.2.3  1999/11/09 16:53:14  oconnor
--| reworking dead object cleanup
--|
--| Revision 1.36.2.2  1999/11/02 17:20:02  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
