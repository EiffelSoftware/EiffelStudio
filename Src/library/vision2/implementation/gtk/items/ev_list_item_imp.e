--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: ""
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_LIST_ITEM_IMP

inherit
	EV_LIST_ITEM_I
		redefine
			interface
		end

	EV_SIMPLE_ITEM_IMP
		undefine
			parent
		redefine
			interface,
			initialize,
			has_parent,
			set_text,
			make
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a list item with an empty name.
		do
			base_make (an_interface)
			set_c_object (C.gtk_list_item_new)	
		end

	initialize is
			-- Set up action sequence connection and `Precursor' initialization,
			-- create list item box to hold label and pixmap.
		local
			item_box: POINTER
		do
			{EV_SIMPLE_ITEM_IMP} Precursor
			textable_imp_initialize
			pixmapable_imp_initialize
			
			item_box := C.gtk_hbox_new (False, 0)
			C.gtk_container_add (c_object, item_box)
			C.gtk_widget_show (item_box)
			
				-- Add the pixmap box to the item but hide it so it
				-- takes up no space in the item.

			--| FIXME  IEK 01/07/2000  What spacing size should be used.
			C.gtk_box_pack_start (item_box, pixmap_box, False, False, 2)
				-- Padding of 2 pixels used for pixmap
			C.gtk_box_pack_start (item_box, text_label, True, True, 0)
			

			C.gtk_widget_hide (pixmap_box)
			
			connect_signal_to_actions ("select", interface.select_actions)
			connect_signal_to_actions ("deselect", interface.deselect_actions)
			is_initialized := True
		end

feature -- Access

	index: INTEGER is
			-- Index of the current item.
		do
			Result := C.gtk_list_child_position(parent_imp.list_widget, Current.c_object) + 1 
		end

feature -- Status report

	is_selected: BOOLEAN is
			-- Is the item selected
		do
			Result := C.c_gtk_list_item_is_selected (parent_imp.list_widget, c_object) = 1
		end

	is_first: BOOLEAN is
			-- Is the item first in the list ?
		do
			Result := C.gtk_list_child_position (parent_imp.list_widget, Current.c_object) + 1 = 1
		end

	is_last: BOOLEAN is
			-- Is the item last in the list ?
		do
			Result := C.gtk_list_child_position (parent_imp.list_widget, Current.c_object) + 1 = C.c_gtk_list_rows (parent_imp.list_widget)
		end

feature -- Status setting

	set_selected (flag: BOOLEAN) is
			-- Select the item if `flag', unselect it otherwise.
		do
			if flag then
				C.c_gtk_list_item_select (c_object)
			else
				C.c_gtk_list_item_unselect (c_object)
			end
		end

	toggle is
			-- Change the state of the toggle button to
			-- opposit status.
		do
			set_selected (not is_selected)
		end

	set_index (value: INTEGER) is
			-- Make `value' the new index of the item in the
			-- list.
		do
			-- Reference the widget otherwise it will be destroyed
			-- when removed from the list.
			C.gtk_object_ref (c_object)
			--FIXME is this ref wrapper needed
			-- Remove the item from the list.
			C.c_gtk_list_remove_item (parent_imp.list_widget, c_object)

			-- Add the item at the given index.
			C.c_gtk_list_insert_item (parent_imp.list_widget, c_object, value - 1)

			-- Unreference the widget which has an extra reference.
			C.gtk_object_unref (c_object)
		end

feature -- element change

	set_text (txt: STRING) is
			-- Set current button text to `txt'.
		local
			--FIXME combo_par: EV_COMBO_BOX_IMP
		do
			{EV_SIMPLE_ITEM_IMP} Precursor (txt)

			-- the gtk part if the parent is a combo_box
			--FIXME combo_par ?= parent_imp
			--FIXME if (combo_par /= Void) then
			--FIXME 	C.gtk_combo_set_item_string (combo_par.c_object, c_object, eiffel_to_c (txt))
			--FIXME end
		end

feature -- Assertion

	has_parent : BOOLEAN is
			-- Redefinition of has_a_parent, already defined
			-- in EV_WIDGET_I, because parent_imp has been
			-- redefined as widget_parent_imp
		do
			Result := parent_imp /= void
		end

feature {EV_LIST_ITEM_IMP, EV_LIST_I} -- Implementation

	interface: EV_LIST_ITEM

end -- class EV_LIST_ITEM_IMP

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
--| Revision 1.24  2000/02/14 11:40:27  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.23.6.19  2000/02/11 01:28:46  king
--| Changed packing of pixmap box to non-expand
--|
--| Revision 1.23.6.18  2000/02/04 07:39:21  oconnor
--| tweaked for release without combo box
--|
--| Revision 1.23.6.17  2000/02/04 04:25:36  oconnor
--| released
--|
--| Revision 1.23.6.16  2000/02/02 23:41:00  king
--| Removed redefinition of parent_imp
--|
--| Revision 1.23.6.15  2000/01/28 18:52:32  king
--| Altered to deal with initialize name changes in textable and pixmapable
--|
--| Revision 1.23.6.14  2000/01/27 19:29:25  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.23.6.13  2000/01/19 17:46:28  oconnor
--| renamed text_box to text_label
--|
--| Revision 1.23.6.12  2000/01/18 23:16:05  king
--| Set is_initialized to true
--|
--| Revision 1.23.6.11  2000/01/11 19:26:21  king
--| Removed command association commands
--|
--| Revision 1.23.6.10  2000/01/10 20:09:18  king
--| Added container initialization for label and pixmap
--|
--| Revision 1.23.6.9  2000/01/07 23:27:51  king
--| Removed calling of ev_textable_imp_initialize
--|
--| Revision 1.23.6.8  1999/12/13 19:45:17  oconnor
--| commented out old command stuff
--|
--| Revision 1.23.6.7  1999/12/08 17:42:27  oconnor
--| removed more inherited externals
--|
--| Revision 1.23.6.6  1999/12/04 18:59:12  oconnor
--| moved externals into EV_C_EXTERNALS, accessed through EV_ANY_IMP.C
--|
--| Revision 1.23.6.5  1999/12/03 07:49:57  oconnor
--| removed old command stuff
--|
--| Revision 1.23.6.4  1999/12/01 19:24:13  oconnor
--| removed ev_children stuff and renamed initialize_text_box to ev_textable_imp_initialize
--|
--| Revision 1.23.6.3  1999/12/01 17:37:10  oconnor
--| migrating to new externals
--|
--| Revision 1.23.6.2  1999/11/30 22:55:17  oconnor
--| rename widget -> c_object
--|
--| Revision 1.23.6.1  1999/11/24 17:29:42  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.23.2.2  1999/11/02 17:20:02  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
