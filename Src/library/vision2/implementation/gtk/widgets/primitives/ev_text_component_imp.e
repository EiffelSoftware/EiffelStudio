indexing

	description: 
		"EiffelVision text component, gtk implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_TEXT_COMPONENT_IMP
	
inherit
	EV_TEXT_COMPONENT_I
		redefine
			interface
		end
	
	EV_PRIMITIVE_IMP
		redefine
			interface
		end

	EV_TEXT_COMPONENT_ACTION_SEQUENCES_IMP
		redefine
			create_change_actions
		end

feature -- Access

	text_length: INTEGER is
			-- Length of the text in the widget.
		do
			Result := text.count
		end

feature -- Status report

	is_editable: BOOLEAN is
			-- Is the text editable.
		do
			Result := C.gtk_editable_struct_editable (entry_widget) /= 0
		end

	position: INTEGER is
			-- Current position of the caret.
		do
			Result := C.gtk_editable_get_position (entry_widget) + 1
		end

	has_selection: BOOLEAN is
			-- Is something selected?
		do
			Result := selection_start < selection_end
		end

	selection_start: INTEGER is
			-- Index of the first character selected.
		do
			Result := C.gtk_editable_struct_selection_start_pos (entry_widget) + 1
		end

	selection_end: INTEGER is
			-- Index of the last character selected.
		do
			Result := C.gtk_editable_struct_selection_end_pos (entry_widget)
		end

	maximum_character_width: INTEGER is
			-- Maximum width of a single character in `Current'.
		do
		end

	clipboard_content: STRING is
			-- `Result' is current clipboard content.
		do
			--temp_label := C.gtk_entry_new
			--C.gtk_widget_show (temp_label)
			--C.gtk_container_add (default_gtk_window, temp_label)
			--a_success := C.gtk_selection_convert (
			--	temp_label,
			--	C.gdk_atom_intern (eiffel_to_c ("CLIPBOARD"), 0),
			----	C.gdk_atom_intern (eiffel_to_c ("COMPOUND_TEXT"), 0),
			--	C.GDK_CURRENT_TIME
			--)
			--create Result.make (0)
			--Result.from_c (C.gtk_editable_get_chars (temp_label, 0, -1))
			--C.gtk_container_remove (default_gtk_window, temp_label)
		end

feature -- status settings

	set_editable (flag: BOOLEAN) is
			-- `flag' true make the component read-write and
			-- `flag' false make the component read-only.
		do
			C.gtk_editable_set_editable (entry_widget, flag)
		end

	set_position (pos: INTEGER) is
			-- Set current insertion position.
		do
			C.gtk_editable_set_position (entry_widget, pos - 1)
		end

	set_caret_position (pos: INTEGER) is
			-- Set the position of the caret to `pos'.
		do
			C.gtk_editable_set_position (entry_widget, pos - 1)
		end

feature -- Resizing

	set_minimum_width_in_characters (nb: INTEGER) is
			-- Make `nb' characters visible on one line.
		do
			check not_implemented: False end
		end

feature -- Basic operation

	insert_text (txt: STRING) is
			-- Insert `txt' at the current position.
		local
			pos: INTEGER
		do
			pos := caret_position - 1
			C.gtk_editable_insert_text (
				entry_widget,
				eiffel_to_c (txt),
				txt.count,
				$pos
			)
		end

	select_region (start_pos, end_pos: INTEGER) is
			-- Select (highlight) the text between 
			-- 'start_pos' and 'end_pos'.
		do
			C.gtk_editable_select_region (entry_widget, start_pos - 1, end_pos)
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
			-- If the `selected_region' is empty, it does
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

	paste (index: INTEGER) is
			-- Insert the string which is in the 
			-- Clipboard at the `index' position in the
			-- text.
			-- If the Clipboard is empty, it does nothing. 
		local
			pos: INTEGER
		do
			pos := position
			set_position (index)
			insert_text (clipboard_content)
			set_position (pos)
		end

feature {EV_ANY_I} -- Implementation

	create_change_actions: EV_NOTIFY_ACTION_SEQUENCE is
		do
			create Result
			real_connect_signal_to_actions (entry_widget, "changed", Result, Void)
		end

	entry_widget: POINTER is
			-- Pointer to the gtkeditable widget.
		deferred
		end

	interface: EV_TEXT_COMPONENT

end -- class EV_TEXT_COMPONENT_IMP

--|-----------------------------------------------------------------------------
--| EiffelVision2: library of reusable  components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|-----------------------------------------------------------------------------

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.23  2001/07/14 12:46:23  manus
--| Replace --! by --|
--|
--| Revision 1.22  2001/07/14 12:16:27  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.21  2001/06/07 23:08:07  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.16.4.13  2000/11/30 19:30:10  king
--| Removing unused local variables
--|
--| Revision 1.16.4.12  2000/10/30 17:36:47  king
--| Removed gdk_current_time, commented out clipboard_content implementation
--|
--| Revision 1.16.4.11  2000/10/27 16:54:44  manus
--| Removed undefinition of `set_default_colors' since now the one from EV_COLORIZABLE_IMP is
--| deferred.
--| However, there might be a problem with the definition of `set_default_colors' in the following
--| classes:
--| - EV_TITLED_WINDOW_IMP
--| - EV_WINDOW_IMP
--| - EV_TEXT_COMPONENT_IMP
--| - EV_LIST_ITEM_LIST_IMP
--| - EV_SPIN_BUTTON_IMP
--|
--| Revision 1.16.4.10  2000/09/13 16:46:48  oconnor
--| fixed off by one on carret_position
--|
--| Revision 1.16.4.9  2000/09/12 19:07:19  king
--| Added set_caret_position, insert_text, comments, spelling corrections
--|
--| Revision 1.16.4.8  2000/09/08 00:27:20  king
--| Corrected spelling mistake
--|
--| Revision 1.16.4.7  2000/09/07 17:27:32  king
--| Removed select_all
--|
--| Revision 1.16.4.6  2000/09/07 16:14:42  king
--| Half implemented new features
--|
--| Revision 1.16.4.5  2000/09/06 23:18:48  king
--| Reviewed
--|
--| Revision 1.16.4.4  2000/08/03 20:14:46  king
--| Redefined create_change_actions to connect signal
--|
--| Revision 1.16.4.3  2000/07/24 21:36:10  oconnor
--| inherit action sequences _IMP class
--|
--| Revision 1.16.4.2  2000/05/25 00:41:18  king
--| Implemented externals in Eiffel
--|
--| Revision 1.16.4.1  2000/05/03 19:08:51  oconnor
--| mergred from HEAD
--|
--| Revision 1.19  2000/03/08 21:40:42  king
--| Made implementation refer to entry_widget insetad of c_object
--|
--| Revision 1.18  2000/02/22 18:39:39  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.17  2000/02/14 11:40:33  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.16.6.10  2000/02/04 05:09:26  oconnor
--| removed obsolete command features
--|
--| Revision 1.16.6.9  2000/02/04 04:25:39  oconnor
--| released
--|
--| Revision 1.16.6.8  2000/01/27 19:29:48  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.16.6.7  1999/12/13 20:03:09  oconnor
--| commented out old command stuff
--|
--| Revision 1.16.6.6  1999/12/04 18:59:20  oconnor
--| moved externals into EV_C_EXTERNALS, accessed through EV_ANY_IMP.C
--|
--| Revision 1.16.6.5  1999/12/03 07:48:12  oconnor
--| fixed gaggle of typos
--|
--| Revision 1.16.6.4  1999/12/01 20:27:50  oconnor
--| tweaks for new externals
--|
--| Revision 1.16.6.3  1999/12/01 17:37:13  oconnor
--| migrating to new externals
--|
--| Revision 1.16.6.2  1999/11/30 23:14:21  oconnor
--| rename widget to c_object
--| redefine interface to be of mreo refined type
--|
--| Revision 1.16.6.1  1999/11/24 17:29:58  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.16.2.2  1999/11/02 17:20:04  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
