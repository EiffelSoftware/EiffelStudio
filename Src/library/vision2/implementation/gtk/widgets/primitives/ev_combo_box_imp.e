--| FIXME NOT_REVIEWED this file has not been reviewed
indexing

	description: 
		"EiffelVision combo box, gtk implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_COMBO_BOX_IMP
	
inherit
	EV_COMBO_BOX_I
		redefine
			interface
		end

	EV_TEXT_FIELD_IMP
		undefine
			pointer_over_widget
		redefine
			initialize,
			make,
			interface
		end

	EV_LIST_IMP
		undefine
			set_default_colors,
			multiple_selection_enabled,
			disable_multiple_selection,
			enable_multiple_selection
		redefine
			select_callback,
			remove_item_from_position,
			gtk_reorder_child,
			initialize,
			make,
			select_item,
			selected,
			add_to_container,
			interface
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a combo-box.
		do
			base_make (an_interface)
			-- create of the array where the items will be listed.
			create ev_children.make (1)

			-- create of the gtk object.
			set_c_object (C.gtk_combo_new)

			-- Pointer to the text we see.
			entry_widget := C.gtk_combo_struct_entry (c_object)

			-- Pointer to the list of items.
			list_widget := C.gtk_combo_struct_list (c_object)
			C.gtk_combo_disable_activate (c_object)
		end

	initialize is
			-- Connect action sequences to signals.
		do
			{EV_LIST_IMP} Precursor

			--| We don't call EV_TEXT_FIELD_IMP Precursor as this only
			--| adds two extra ones to what ev_list_imp Precursor calls
			--| already and the default sequences can only be connected
			--| once.

			real_connect_signal_to_actions (
				entry_widget,
				"activate",
				interface.return_actions,
				default_translate
			)
			real_connect_signal_to_actions (
				entry_widget,
				"changed",
				interface.change_actions,
				default_translate
			)
		end

	avoid_callback: BOOLEAN
		-- Flag used to avoid repeated emission of select signal from combo box.

	select_callback (n: INTEGER; an_item: POINTER) is
			-- Redefined to counter repeated select signal of combo box. 
		do
			if not avoid_callback then
				Precursor (n, an_item)
				avoid_callback := True
			else
				avoid_callback := False
			end
		end

feature -- Access

	select_item (an_index: INTEGER) is
			-- Give the item of the list at the one-base
			-- index. (Gtk uses 0 based indexs, I think)
		do
			C.gtk_list_select_item (list_widget, an_index - 1)
		end

feature -- Measurement

	extended_height: INTEGER is
			-- height of the combo-box when the list is shown
		do
			check
				Not_yet_implemented: False
			end
		end

feature -- Status report

	rows: INTEGER is
		 	-- Number of lines
		do
			Result := C.c_gtk_list_rows (list_widget)
		end

	selected: BOOLEAN is
			-- Is at least one item selected ?
		do
			Result := C.c_gtk_list_selected (list_widget) = 0
		end

feature -- Status setting
	
	set_maximum_text_length (len: INTEGER) is
		do
			C.gtk_entry_set_max_length (entry_widget, len)
		end
	
	set_extended_height (value: INTEGER) is
			-- Make `value' the new extended-height of the box.
		do
			--| FIXME IEK Not yet implemented.
			check to_be_implemented: False end
		end

feature {NONE} -- Implementation

	add_to_container (v: like item) is
			-- Add `v' to container.
		local
			imp: EV_LIST_ITEM_IMP
			s: ANY
		do	
			imp ?= v.implementation
			s := imp.text.to_c
			C.gtk_combo_set_item_string (c_object,
				imp.c_object,
				$s
			)
			C.gtk_container_add (list_widget, imp.c_object)
			imp.set_parent_imp (Current)
		end

	remove_item_from_position (a_position: INTEGER) is
			-- Remove item at position `a_position'.
		local
			imp: EV_LIST_ITEM_IMP
		do
			imp ?= interface.i_th (a_position).implementation
			Precursor (a_position)
			imp.set_parent_imp (Void)
			if count = 0 then
				set_text ("")
			end
		end

	gtk_reorder_child (a_container, a_child: POINTER; an_index: INTEGER) is
			-- Reorder `a_child' to `an_index' in `c_object'.
			-- `a_container' is ignored.
		do
			C.gtk_box_reorder_child (c_object,
				a_child,
				an_index - 1
			)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_COMBO_BOX

end -- class EV_COMBO_BOX_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable  components for ISE Eiffel.
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
--| Revision 1.30  2000/04/04 20:54:08  oconnor
--| updated signal connection for new marshaling scheme
--|
--| Revision 1.29  2000/03/31 19:10:57  king
--| Accounted for rename of pebble_over_widget
--|
--| Revision 1.28  2000/03/22 22:01:30  king
--| Undefined pebble_over_widget from text_field
--|
--| Revision 1.27  2000/03/15 18:29:50  king
--| Uncommented disable_activate external
--|
--| Revision 1.26  2000/03/08 22:27:38  king
--| Accounted for name change of set_combo_parent_imp
--|
--| Revision 1.25  2000/03/08 21:37:53  king
--| Removed useless redefinition of entry widget functions
--|
--| Revision 1.24  2000/03/02 23:58:05  king
--| Indented external function calls
--|
--| Revision 1.23  2000/03/01 18:05:52  king
--| Changed XX to FIXME
--|
--| Revision 1.22  2000/02/25 17:50:02  king
--| Now using real_connect_signal_to_actions
--|
--| Revision 1.21  2000/02/22 18:39:38  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.20  2000/02/17 02:18:41  oconnor
--| released
--|
--| Revision 1.19  2000/02/15 19:23:51  king
--| Tidied up code in select_region
--|
--| Revision 1.18  2000/02/14 20:38:35  oconnor
--| mergerd from HACK-O-RAMA
--|
--| Revision 1.16.6.15  2000/02/14 20:21:18  king
--| Connected signals to entry widget in initialize
--|
--| Revision 1.16.6.14  2000/02/14 17:17:22  king
--| Connected change and activate signals
--|
--| Revision 1.16.6.13  2000/02/12 00:26:11  king
--| Implemented gtk_reorder_child
--|
--| Revision 1.16.6.12  2000/02/11 18:25:26  king
--| Added entry widget pointer in EV_TEXT_FIELD_IMP to accomodate the fact that
--| combo box is not an entry widget
--|
--| Revision 1.16.6.11  2000/02/11 01:30:50  king
--| Added fixme to precursor of initialize
--|
--| Revision 1.16.6.10  2000/02/11 00:55:26  king
--| Implemented combo box to allow assertion of items
--|
--| Revision 1.16.6.9  2000/01/27 19:29:46  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.16.6.8  2000/01/18 19:33:41  king
--| Added initialize, removed redefinition of now defunct features
--|
--| Revision 1.16.6.7  2000/01/15 00:53:19  oconnor
--| renamed is_multiple_selection -> multiple_selection_enabled,
--| set_multiple_selection -> enable_multiple_selection &
--| set_single_selection -> disable_multiple_selection
--|
--| Revision 1.16.6.6  1999/12/13 20:02:38  oconnor
--| commented out old command stuff
--|
--| Revision 1.16.6.5  1999/12/04 18:59:20  oconnor
--| moved externals into EV_C_EXTERNALS, accessed through EV_ANY_IMP.C
--|
--| Revision 1.16.6.4  1999/12/03 07:48:11  oconnor
--| fixed gaggle of typos
--|
--| Revision 1.16.6.3  1999/12/01 20:27:50  oconnor
--| tweaks for new externals
--|
--| Revision 1.16.6.2  1999/11/30 23:14:20  oconnor
--| rename widget to c_object
--| redefine interface to be of mreo refined type
--|
--| Revision 1.16.6.1  1999/11/24 17:29:56  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.16.2.3  1999/11/17 01:53:04  oconnor
--| removed "child packing" hacks and obsolete _ref _unref wrappers
--|
--| Revision 1.16.2.2  1999/11/02 17:20:04  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
