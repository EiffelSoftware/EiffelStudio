--| FIXME Not for release
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
		redefine
			initialize,
			make,
			text,
			set_editable,
			set_text,
			append_text,
			prepend_text,
			position,
			set_position,
			select_region,
			cut_selection,
			copy_selection,
			paste,
			selection_start,
			selection_end,
			has_selection,
			delete_selection,
			select_all,
			deselect_all,
			is_editable,
			interface
		end

	EV_LIST_IMP
		undefine
			set_default_colors,
			multiple_selection_enabled,
			disable_multiple_selection,
			enable_multiple_selection
		redefine
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
		end

	initialize is
		do
			{EV_LIST_IMP} Precursor

			--| FIXME IEK Action sequence is being connected twice.
			--{EV_TEXT_FIELD_IMP} Precursor
		end

feature -- Access

	text: STRING is
		local
			p: POINTER
		do
			p := C.gtk_entry_get_text (entry_widget)
			create Result.make (0)
			Result.from_c (p)
		end

	select_item (an_index: INTEGER) is
			-- Give the item of the list at the one-base
			-- index. (Gtk uses 0 based indexs, I think)
		do
			C.gtk_list_select_item (list_widget, an_index - 1)
		end

feature -- Status report

	is_editable: BOOLEAN is
			-- Is the text editable
		do
			Result := C.c_gtk_editable_editable (entry_widget) /= 0
		end

	has_selection: BOOLEAN is
			-- Is something selected?
		do
			Result := C.c_gtk_editable_has_selection (entry_widget) /= 0
		end

	position: INTEGER is
			-- Current position of the caret.
		do
			Result := C.gtk_text_get_point (entry_widget) + 1
		end

	selection_start: INTEGER is
			-- Index of the first character selected
		do
			Result := C.c_gtk_editable_selection_start (entry_widget) + 1
		end

	selection_end: INTEGER is
			-- Index of the last character selected
		do
			Result := C.c_gtk_editable_selection_end (entry_widget)
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

	set_editable (flag: BOOLEAN) is
			-- `flag' true make the component read-write and
			-- `flag' false make the component read-only.
		do
			C.gtk_entry_set_editable (entry_widget, flag)
		end

	set_text (txt: STRING) is
		local
			a: ANY
		do
			a := txt.to_c
			C.gtk_entry_set_text (entry_widget, $a)
		end
	
	append_text (txt: STRING) is
		local
			a: ANY
		do
			a := txt.to_c
			C.gtk_entry_append_text (entry_widget, $a)
		end
	
	prepend_text (txt: STRING) is
		local
			a: ANY
		do
			a := txt.to_c
			C.gtk_entry_prepend_text (entry_widget, $a)
		end
	
	set_position (pos: INTEGER) is
		do
			C.gtk_text_set_point (entry_widget, pos - 1)
		end
	
	set_maximum_text_length (len: INTEGER) is
		do
			C.gtk_entry_set_max_length (entry_widget, len)
		end
	
	select_region (start_pos, end_pos: INTEGER) is
		do
			C.gtk_entry_select_region (entry_widget, start_pos-1, end_pos)
		end	

	set_extended_height (value: INTEGER) is
			-- Make `value' the new extended-height of the box.
		do
			-- XX Not yet implemented.
		end

feature -- Basic operation

	select_all is
			-- Select all the text.
		do
			C.gtk_editable_select_region (entry_widget, 0, text_length)
		end

	deselect_all is
			-- Unselect the current selection.
		do
			C.gtk_editable_select_region (entry_widget, 0, 0)
		end

	delete_selection is
			-- Delete the current selection.
		do
			C.gtk_editable_delete_selection (entry_widget)
		end

	cut_selection is
			-- Cut the `selected_region' by erasing it from
			-- the text and putting it in the Clipboard 
			-- to paste it later.
			-- If the `selectd_region' is empty, it does
			-- nothing.
		do
			C.gtk_editable_cut_clipboard (entry_widget)
		end

	copy_selection is
			-- Copy the `selected_region' in the Clipboard
			-- to paste it later.
			-- If the `selected_region' is empty, it does
			-- nothing.
		do
			C.gtk_editable_copy_clipboard (entry_widget)
		end

	paste (an_index: INTEGER) is
			-- Insert the string which is in the 
			-- Clipboard at the `index' postion in the
			-- text.
			-- If the Clipboard is empty, it does nothing. 
		local
			pos: INTEGER
		do
			pos := position
			set_position (an_index)
			C.gtk_editable_paste_clipboard (entry_widget)
			set_position (pos)
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
			C.gtk_combo_set_item_string (c_object, imp.c_object, $S)
			C.gtk_container_add (list_widget, imp.c_object)
		end

	gtk_reorder_child (a_container, a_child: POINTER; an_index: INTEGER) is
			-- Reorder `a_child' to `an_index' in `c_object'.
			-- `a_container' is ignored.
		do
			C.gtk_box_reorder_child (c_object, a_child, an_index - 1)
		end


feature {EV_ANY_I} -- Implementation

	interface: EV_COMBO_BOX

end -- class EV_COMBO_BOX_IMP

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable  components for ISE Eiffel.
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
--| Revision 1.17  2000/02/14 11:40:32  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.16.6.13  2000/02/12 00:26:11  king
--| Implemented gtk_reorder_child
--|
--| Revision 1.16.6.12  2000/02/11 18:25:26  king
--| Added entry widget pointer in EV_TEXT_FIELD_IMP to accomodate the fact that combo box is not an entry widget
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
--| renamed is_multiple_selection -> multiple_selection_enabled, set_multiple_selection -> enable_multiple_selection & set_single_selection -> disable_multiple_selection
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
