--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: 
		"EiffelVision text component, implementation interface."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_TEXT_COMPONENT_I
	
inherit
	EV_PRIMITIVE_I
		redefine
			set_default_colors
		end

feature -- Access

	text: STRING is
			-- Text of current label
		require
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	text_length: INTEGER is
			-- Length of the text in the widget
		require
		deferred
		end

	selected_text: STRING is
			-- Text which is currently selected
		require
		do
			Result := text.substring (selection_start, selection_end)
		end


feature -- Status report

	is_editable: BOOLEAN is
			-- Is the text editable
		require
		deferred
		end

	caret_position: INTEGER is
			-- Current position of the caret.
		require
		deferred
		end

	has_selection: BOOLEAN is
			-- Is something selected?
		require
		deferred
		end

	selection_start: INTEGER is
			-- Index of the first character selected
		require
			has_selection: has_selection
		deferred
		ensure
			result_large_enough: Result >= 1
			result_small_enough: Result <= text_length
		end

	selection_end: INTEGER is
			-- Index of the last character selected
		require
			has_selection: has_selection
		deferred
		ensure
			result_large_enough: Result >= 1
			result_small_enough: Result <= text_length
		end

	valid_caret_position (pos: INTEGER): BOOLEAN is
		require
		do
			Result := pos > 0 and pos <= text_length			
		end

feature -- Status setting
	
	set_default_colors is
			-- Initialize the colors of the widget
		local
			color: EV_COLOR
		do
			create color.make_with_rgb (1, 1, 1)
			set_background_color (color)
			create color.make_with_rgb (0, 0, 0)
			set_foreground_color (color)
		end

	set_editable (flag: BOOLEAN) is
			-- `flag' true make the component read-write and
			-- `flag' false make the component read-only.
		require
		deferred
		end

	set_caret_position (pos: INTEGER) is
			-- set current insertion position
		require
			position_large_enough: pos >= 1
			position_small_enough: pos <= text_length + 1
--			is_editable: is_editable
		deferred
		end
	
feature -- Element change

	set_text (txt: STRING) is
			-- set text in component to 'txt'
		require
			valid_text: txt /= Void
			text_is_editable: is_editable
		deferred
		ensure
			text_set: text.is_equal (txt)
		end

	insert_text (txt: STRING) is
			-- Insert `txt' at the current position.
		require
			valid_text: txt /= Void
			is_editable: is_editable
		deferred
		end
	
	append_text (txt: STRING) is
			-- append 'txt' into component
		require
			valid_text: txt /= Void
			is_editable: is_editable
		deferred
		ensure
			text_appended:
		end
	
	prepend_text (txt: STRING) is
			-- prepend 'txt' into component
		require
			valid_text: txt /= Void
			is_editable: is_editable
		deferred
		ensure
			text_prepended:
		end

feature -- Resizing

	set_minimum_width_in_characters (nb: INTEGER) is
			-- Make `nb' characters visible on one line.
		require
			valid_nb: nb > 0
		deferred
		end

feature -- Basic operation

	select_region (start_pos, end_pos: INTEGER) is
			-- Select (hilight) the text between 
			-- `start_pos' and `end_pos'. Both `start_pos' and
			-- `end_pos' are selected.
		require
			valid_start: start_pos >= 1 and start_pos <= text_length
			valid_end: end_pos >= 1 and end_pos <= text_length
		deferred
		ensure
			has_selection: (start_pos /= end_pos) implies has_selection
			selection_start_set: selection_start = start_pos
			selection_end_set: selection_end = end_pos
		end	

	select_all is
			-- Select all the text.
		require
			positive_length: text_length > 0
		deferred
		ensure
			has_selection: has_selection
			selection_start_set: selection_start = 1
			selection_end_set: selection_end <= text_length + 2
		end

	deselect_all is
			-- Unselect the current selection.
		require
		deferred
		ensure
			has_no_selection: not has_selection
		end

	delete_selection is
			-- Delete the current selection.
		require
			has_selection: has_selection
			is_editable: is_editable
		deferred
		ensure
			has_no_selection: not has_selection
		end

	cut_selection is
			-- Cut the `selected_region' by erasing it from
			-- the text and putting it in the Clipboard 
			-- to paste it later.
			-- If the `selectd_region' is empty, it does
			-- nothing.
		require
			has_selection: has_selection
			is_editable: is_editable
		deferred
		end

	copy_selection is
			-- Copy the `selected_region' in the Clipboard
			-- to paste it later.
			-- If the `selected_region' is empty, it does
			-- nothing.
		require
			has_selection: has_selection
		deferred
		end

	paste (index: INTEGER) is
			-- Insert the string which is in the 
			-- Clipboard at the `index' postion in the
			-- text.
			-- If the Clipboard is empty, it does nothing. 
		require
			index_large_enough: index >= 1
			index_small_enough: index <= text_length + 1
			is_editable: is_editable
		deferred
		end

feature -- Event - command association

--	add_change_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
--			-- Add 'cmd' to the list of commands to be executed 
--			-- when the text of the widget have changed.
--		require
--			valid_command: cmd /= Void
--		deferred
--		end

feature -- Event -- removing command association

--	remove_change_commands is
--			-- Empty the list of commands to be executed
--			-- when the text of the widget have changed.
--		require
--		deferred
--		end
	
end --class EV_TEXT_COMPONENT_I

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
--| Revision 1.36  2000/02/14 11:40:38  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.35.4.6  2000/02/04 07:09:37  oconnor
--| removed obsolete command features
--|
--| Revision 1.35.4.5  2000/02/04 04:10:28  oconnor
--| released
--|
--| Revision 1.35.4.4  2000/01/27 19:30:05  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.35.4.3  1999/12/30 01:59:25  rogers
--| changed position to caret_position , valid_position to valid_caret_position, set_position to set_caret_position.
--|
--| Revision 1.35.4.2  1999/12/03 07:47:01  oconnor
--| make_rgb (int) -> make_with_rgb (real)
--|
--| Revision 1.35.4.1  1999/11/24 17:30:13  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.34.2.3  1999/11/04 23:10:45  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.34.2.2  1999/11/02 17:20:07  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
