--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "FIXME"
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

	EV_ITEM_IMP
		undefine
			parent
		redefine
			interface,
			initialize,
			make
		end

	EV_TEXTABLE_IMP
		redefine
			interface,
			set_text
		end

	EV_TOOLTIPABLE_IMP
		redefine
			interface
		end

	EV_LIST_ITEM_ACTION_SEQUENCES_IMP

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
			{EV_ITEM_IMP} Precursor
			textable_imp_initialize
			pixmapable_imp_initialize
			
			item_box := C.gtk_hbox_new (False, 0)
--gtk_widget_unset_flags (c_object, C.GTK_CAN_FOCUS_ENUM)
			C.gtk_container_add (c_object, item_box)
			C.gtk_widget_show (item_box)
			
				-- Add the pixmap box to the item but hide it so it
				-- takes up no space in the item.

			--| FIXME  IEK 01/07/2000  What spacing size should be used.
			C.gtk_box_pack_start (item_box, pixmap_box, False, False, 2)
				-- Padding of 2 pixels used for pixmap
			C.gtk_box_pack_start (item_box, text_label, True, True, 0)

			C.gtk_widget_hide (pixmap_box)	
			is_initialized := True
		end

feature -- Access

	index: INTEGER is
			-- Index of the current item.
		local
			par: POINTER
		do
			par := parent_imp.list_widget
			if par /= NULL then
				Result := 1 + C.gtk_list_child_position (par, c_object)
			end
		end

feature -- Status report

	is_selected: BOOLEAN is
			-- Is the item selected
		local
			par: POINTER
		do
			par := parent_imp.list_widget
			if par /= NULL then
				Result := C.g_list_find (
					C.gtk_list_struct_selection (par),
					c_object
				) /= NULL
			end
		end

feature -- Status setting

	enable_select is
			-- Select the item.
		local
			par: POINTER
		do
			par := parent_imp.list_widget
			if par /= NULL then
				C.gtk_list_select_child (par, c_object);
			end
		end

	disable_select is
			-- Deselect the item.
		local
			par: POINTER
		do
			par := parent_imp.list_widget
			if par /= NULL then
				C.gtk_list_unselect_child (par, c_object);
			end
		end

feature -- Element change

	set_text (txt: STRING) is
			-- Set current button text to `txt'.
		local
			combo_par: EV_COMBO_BOX_IMP
		do
			Precursor (txt)

			-- the gtk part if the parent is a combo_box
			combo_par ?= parent_imp
			if (combo_par /= Void) then
				C.gtk_combo_set_item_string (
					combo_par.c_object,
					c_object, eiffel_to_c (txt)
				)
			end
		end

feature {EV_LIST_ITEM_LIST_IMP, EV_LIST_ITEM_LIST_I} -- Implementation

	interface: EV_LIST_ITEM

end -- class EV_LIST_ITEM_IMP

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
--| Revision 1.36  2001/06/07 23:08:01  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.23.4.11  2001/05/18 17:51:35  king
--| Removed unsetting of focus flag
--|
--| Revision 1.23.4.10  2001/04/26 19:10:30  king
--| Removed focus hack
--|
--| Revision 1.23.4.9  2001/04/26 18:42:22  king
--| Reinstated focus flag
--|
--| Revision 1.23.4.8  2001/04/20 18:35:39  king
--| Removed unsetting of focus flag as this is done in EV_LIST_IMP
--|
--| Revision 1.23.4.7  2000/11/03 23:05:21  king
--| Preventing list items from attaining focus
--|
--| Revision 1.23.4.6  2000/10/30 17:32:38  king
--| Formatting
--|
--| Revision 1.23.4.5  2000/07/24 21:33:39  oconnor
--| inherit action sequences _IMP class
--|
--| Revision 1.23.4.4  2000/06/12 16:22:56  oconnor
--| removed references to obsolete features
--|
--| Revision 1.23.4.3  2000/05/10 23:43:42  king
--| Made tooltipable
--|
--| Revision 1.23.4.2  2000/05/10 18:50:34  king
--| Integrated ev_list_item_list
--|
--| Revision 1.23.4.1  2000/05/03 19:08:35  oconnor
--| mergred from HEAD
--|
--| Revision 1.34  2000/04/18 19:14:17  oconnor
--| Removed reliance on externals
--|
--| Revision 1.33  2000/04/07 22:35:53  brendel
--| Removed EV_SIMPLE_ITEM_IMP from inheritance.
--|
--| Revision 1.32  2000/04/04 20:50:06  oconnor
--| formatting
--|
--| Revision 1.31  2000/03/29 22:11:55  king
--| Added enable/disable select, removed redundant set_index
--|
--| Revision 1.30  2000/03/08 21:35:22  king
--| Removed signal connection, now performed by parent
--|
--| Revision 1.29  2000/03/07 01:26:27  king
--| Removed signal connection, now done in parent
--|
--| Revision 1.28  2000/02/29 18:43:40  king
--| Tidied up code
--|
--| Revision 1.27  2000/02/22 18:39:34  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.26  2000/02/15 19:21:06  king
--| Uncommented combo box item setting in set_text
--|
--| Revision 1.25  2000/02/14 20:38:35  oconnor
--| mergerd from HACK-O-RAMA
--|
--| Revision 1.23.6.20  2000/02/14 20:19:48  king
--| Corrected indenting on index
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
--| removed ev_children stuff and renamed initialize_text_box to
--| ev_textable_imp_initialize
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
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
