--| FIXME NOT_REVIEWED this file has not been reviewed
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
		undefine
			set_default_colors
		redefine
			interface
		end

feature -- Access

	text_length: INTEGER is
			-- Length of the text in the widget
		do
			Result := text.count
		end

feature -- Status report

	is_editable: BOOLEAN is
			-- Is the text editable
		do
			Result := C.c_gtk_editable_editable (c_object) /= 0
		end

	position: INTEGER is
			-- Current position of the caret.
		do
			Result := C.gtk_text_get_point (c_object) + 1
		end

	has_selection: BOOLEAN is
			-- Is something selected?
		do
			Result := C.c_gtk_editable_has_selection (c_object) /= 0
		end

	selection_start: INTEGER is
			-- Index of the first character selected
		do
			Result := C.c_gtk_editable_selection_start (c_object) + 1
		end

	selection_end: INTEGER is
			-- Index of the last character selected
		do
			Result := C.c_gtk_editable_selection_end (c_object)
		end

feature -- status settings

	set_editable (flag: BOOLEAN) is
			-- `flag' true make the component read-write and
			-- `flag' false make the component read-only.
		do
			C.gtk_editable_set_editable (c_object, flag)
		end

	set_position (pos: INTEGER) is
			-- set current insertion position
		do
			C.gtk_text_set_point (c_object, pos - 1)
		end

feature -- Resizing

	set_minimum_width_in_characters (nb: INTEGER) is
			-- Make `nb' characters visible on one line.
		do
			check not_implemented: False end
		end

feature -- Basic operation

	select_region (start_pos, end_pos: INTEGER) is
			-- Select (hilight) the text between 
			-- 'start_pos' and 'end_pos'
		do
			C.gtk_editable_select_region (c_object, start_pos - 1, end_pos)
		end	

	select_all is
			-- Select all the text.
		do
			C.gtk_editable_select_region (c_object, 0, text_length)
		end

	deselect_all is
			-- Unselect the current selection.
		do
			C.gtk_editable_select_region (c_object, 0, 0)
		end

	delete_selection is
			-- Delete the current selection.
		do
			C.gtk_editable_delete_selection (c_object)
		end

	cut_selection is
			-- Cut the `selected_region' by erasing it from
			-- the text and putting it in the Clipboard 
			-- to paste it later.
			-- If the `selectd_region' is empty, it does
			-- nothing.
		do
			C.gtk_editable_cut_clipboard (c_object)
		end

	copy_selection is
			-- Copy the `selected_region' in the Clipboard
			-- to paste it later.
			-- If the `selected_region' is empty, it does
			-- nothing.
		do
			C.gtk_editable_copy_clipboard (c_object)
		end

	paste (index: INTEGER) is
			-- Insert the string which is in the 
			-- Clipboard at the `index' postion in the
			-- text.
			-- If the Clipboard is empty, it does nothing. 
		local
			pos: INTEGER
		do
			pos := position
			set_position (index)
			C.gtk_editable_paste_clipboard (c_object)
			set_position (pos)
		end

feature -- Event - command association

--	add_change_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
--			-- Add 'cmd' to the list of commands to be executed 
--			-- when the text of the widget have changed.
--		do
--		--	add_command (c_object, "changed", cmd, arg, default_pointer)
--		end

feature -- Event -- removing command association

--	remove_change_commands is
--			-- Empty the list of commands to be executed
--			-- when the text of the widget have changed.
--		do
--		--	remove_commands (c_object, changed_id)
--		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TEXT_COMPONENT

end -- class EV_TEXT_COMPONENT_IMP

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
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
