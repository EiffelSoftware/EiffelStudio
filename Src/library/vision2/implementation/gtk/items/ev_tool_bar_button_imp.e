--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "EiffelVision2 Toolbar button, a specific button that goes in a tool-bar."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_BUTTON_IMP

inherit
	EV_TOOL_BAR_BUTTON_I
		select
			interface
		end

	EV_SIMPLE_ITEM_IMP
		rename
			interface as simple_item_interface
		undefine
			set_pixmap,
			remove_pixmap,
			parent,
			set_text,
			remove_text
		redefine
			initialize
		end

	EV_BUTTON_IMP
		rename
			interface as button_interface,
			parent_imp as button_parent_imp,
			parent_set as button_parent_set,
			parent as button_parent
		undefine
			has_parent
		redefine
			make,
			initialize,
			initialize_button_box
		select
			button_parent_imp,
			button_parent_set,
			button_parent
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create the tool bar button.
		do
			base_make (an_interface)
			set_c_object (C.gtk_button_new)
			C.gtk_button_set_relief (c_object, C.gtk_relief_none_enum)
		end

	connect_signals is
			-- Redefined in radio as press_actions is not connected directly
		do
			connect_signal_to_actions ("clicked", interface.press_actions)
		end

	initialize is
			-- Initialization of button box and events.

		do
			{EV_SIMPLE_ITEM_IMP} Precursor
			pixmapable_imp_initialize
			textable_imp_initialize
			initialize_button_box
			connect_signals
			is_initialized := True
		end

	initialize_button_box is
			-- Create the box for pixmap and label and connect action sequence.
		local
			box: POINTER
		do
			box := C.gtk_vbox_new (False, 0)
			C.gtk_container_add (c_object, box)
			C.gtk_widget_show (box)
			C.gtk_box_pack_end (box, text_label, True, True, 0)
			C.gtk_widget_hide (text_label)
			C.gtk_box_pack_start (box, pixmap_box, True, True, 0)
			C.gtk_widget_hide (pixmap_box)
		end

feature -- Status report

	index: INTEGER is
		do
			if parent_imp /= Void then
				Result := C.gtk_list_child_position (parent_imp.list_widget, Current.c_object) + 1
			end 
		end

end -- class EV_TOOL_BAR_BUTTON_IMP

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
--!---------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.16  2000/02/14 11:40:27  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.15.4.7  2000/02/04 21:22:08  king
--| Changed packing options for pix and text box
--|
--| Revision 1.15.4.6  2000/02/04 04:25:36  oconnor
--| released
--|
--| Revision 1.15.4.5  2000/02/01 20:05:57  king
--| extracted a connect signals to be redefined in tb_rad_but
--|
--| Revision 1.15.4.4  2000/01/28 18:43:00  king
--| Updated initialize to use pixmapable and textable initialize nam changes
--|
--| Revision 1.15.4.3  2000/01/27 19:29:26  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.15.4.2  2000/01/26 23:20:44  king
--| Implemented to fit in with new structure, index and ordering need implementing, removed redundant features
--|
--| Revision 1.15.4.1  1999/11/24 17:29:43  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.13.2.2  1999/11/02 17:20:02  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
