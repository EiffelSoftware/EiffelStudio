--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: 
	"Eiffel Vision text component. Base class for text editing widgets."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_TEXT_COMPONENT

inherit
	EV_PRIMITIVE
		redefine
			implementation,
			create_action_sequences
		end

feature -- Access

	text: STRING is
			-- Text in component.
		do
			Result := implementation.text
		ensure
			bridge_ok: Result.is_equal (implementation.text)
		end 

	text_length: INTEGER is
			-- Length of the text in the widget
		do
			Result := implementation.text_length
		ensure
			bridge_ok: Result = implementation.text_length
		end

	selected_text: STRING is
			-- Currently selected text.
		do
			Result := implementation.selected_text
		ensure
			bridge_ok: Result = implementation.selected_text
		end

feature -- Status report

	is_editable: BOOLEAN is
			-- Is text editable?
		do
			Result := implementation.is_editable
		ensure
			bridge_ok: Result = implementation.is_editable
		end

	caret_position: INTEGER is
			-- Current position of caret.
		do
			Result := implementation.caret_position
		ensure
			bridge_ok: Result = implementation.caret_position
		end

	has_selection: BOOLEAN is
			-- Is some text selected?
		do
			Result := implementation.has_selection
		ensure
			bridge_ok: Result = implementation.has_selection
		end

	selection_start: INTEGER is
			-- Index of the first selected character.
		require
			has_selection: has_selection
		do
			Result := implementation.selection_start
		ensure
			bridge_ok: Result = implementation.selection_start
			within_range: Result >= 1 and Result <= text_length
			consistent_with_selection_end: selection_end >= Result
		end

	selection_end: INTEGER is
			-- Index of the last character selected
		require
			has_selection: has_selection
		do
			Result := implementation.selection_end
		ensure
			bridge_ok: Result = implementation.selection_end
			within_range: Result >= 1 and Result <= text_length
			consistent_with_selection_start: Result >= selection_start
		end

	valid_caret_position (pos: INTEGER): BOOLEAN is
		do
			Result := implementation.valid_caret_position (pos)
		ensure
			bridge_ok: Result = implementation.valid_caret_position (pos)
		end

feature -- Status setting
	
	enable_edit is
			-- Make component editable.
		do
			implementation.set_editable (True)
		ensure
			is_editable: is_editable 
		end

	disable_edit is
			-- Make component read-only.
		do
			implementation.set_editable (False)
		ensure
			is_editable: not is_editable 
		end
	
	set_caret_position (a_caret_position: INTEGER) is
			-- Assign `a_caret_posiiton' to `caret_position'.
		require
			a_caret_position_within_range:
				a_caret_position >= 1 and a_caret_position <= text_length + 1
			valid_caret_position: valid_caret_position (a_caret_position)
			is_editable: is_editable
		do
			implementation.set_caret_position (a_caret_position)
		ensure
			caret_position_assigned: caret_position = a_caret_position
		end

feature -- Element change

	set_text (a_text: STRING) is
			-- Assign `a_text' to `text'.
		require
			text_not_void: a_text /= Void
			is_editable: is_editable
		do
			implementation.set_text (a_text)
		ensure
			text_set: text.is_equal (a_text)
		end

	insert_text (a_text: STRING) is
			-- Insert `a_text' at `caret_position'.
		require
			text_not_void: a_text /= Void
			is_editable: is_editable
		do
			implementation.insert_text (a_text)
		ensure
			text_inserted: text.is_equal (
				(old text).substring (1, (old caret_position)) +
				a_text +
				(old text).substring ((old caret_position) + 1, (old text.count))
			)
		end

	append_text (a_text: STRING) is
			-- Append `a_text' to `text'.
		require
			text_not_void: a_text /= Void
			is_editable: is_editable
		do
			implementation.append_text (a_text)
		ensure
			text_appended: text.is_equal (old text + a_text)
		end
	
	prepend_text (a_text: STRING) is
			-- Prepend `a_text' to `text'.
		require
			text_not_void: a_text /= Void
			is_editable: is_editable
		do
			implementation.prepend_text (a_text)
		ensure
			text_prepended:  text.is_equal (a_text + old text)
		end

feature -- Resizing

	set_minimum_width_in_characters (nb: INTEGER) is
			-- Make `nb' characters visible on one line.
		require
			valid_nb: nb > 0
		do
			implementation.set_minimum_width_in_characters (nb)
		ensure
			minimum_width_in_characters_assigned: False
			-- FIXME implement
		end

feature -- Basic operation

	select_region (start_pos, end_pos: INTEGER) is
			-- Select  text between `start_pos' and `end_pos' inclusive.
		require
			start_within_range: start_pos >= 1 and start_pos <= text_length
			end_within_range: end_pos >= 1 and end_pos <= text_length
		do
			implementation.select_region (start_pos, end_pos)
		ensure
			has_selection: (start_pos /= end_pos) implies has_selection
			selection_start_set: selection_start = start_pos
			selection_end_set: selection_end = end_pos
		end

	select_all is
			-- Select all text.
		require
			positive_length: text_length > 0
		do
			implementation.select_all
		ensure
			has_selection: has_selection
			selection_start_set: selection_start = 1
			selection_end_set: selection_end <= text_length + 2
				-- FIXME huh? please explain. sam 20000121
		end

	deselect_all is
			-- Unselect the current selection.
		do
			if has_selection then
				implementation.deselect_all
			end
		ensure
			not_has_selection: not has_selection
		end

	delete_selection is
			-- Delete the current selection.
		require
			has_selection: has_selection
			is_editable: is_editable
		do
			implementation.delete_selection
		ensure
			has_no_selection: not has_selection
		end

	cut_selection is
			-- Move `selected_text' to clipboard.
		require
			has_selection: has_selection
			is_editable: is_editable
		do
			implementation.cut_selection
		ensure
			selection_in_clipboard: -- clipboard.is_equal (old selected_text)
			-- FIXME implement this.
--			selection_cut: text.is_equal (
--				old text.substring (1, old selection_start) +
--				old text.substring (old selection_end, old text.count)
--			)
		end

	copy_selection is
			-- Copy `selected_text' to clipboard.
		require
			has_selection: has_selection
		do
			implementation.copy_selection
		ensure
			-- selection_copied: clipboard.is_equal (selected_text)
			-- FIXME implement this.
			text_unchanged: text.is_equal (old text)
		end

	paste (a_position: INTEGER) is
			-- Insert text from `clipboard' at `a_position'.
			-- No effect if clipboard is empty.
		require
			a_position_within_range:
				a_position >= 1 and a_position <= text_length + 1
			is_editable: is_editable
		do
			implementation.paste (a_position)
		ensure
			-- FIXME implement this.
--			clipbaord_pasted: text.is_equal (
--				old text.substring (1, a_position) +
--				clipboard +
--				old text.substring (a_position + 1, old text.count)
--			)
		end

feature -- Event handling

	change_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed then `text' changes.

feature {NONE} -- Implementation

	implementation: EV_TEXT_COMPONENT_I
			-- Responsible for interaction with the underlying native graphics
			-- toolkit.

	create_action_sequences is
			-- Create action sequences.
		do
			Precursor
			create change_actions
		end

invariant
	text_not_void: text /= Void
	change_actions_not_void: change_actions /= Void
			
end -- class EV_TEXT_COMPONENT

--!-----------------------------------------------------------------------------
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
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.25  2000/02/14 11:40:53  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.24.4.9  2000/02/08 05:12:01  oconnor
--| changes = to is_equal for feature text
--|
--| Revision 1.24.4.8  2000/02/01 01:34:49  brendel
--| Added Precursor call for create_action_sequences.
--|
--| Revision 1.24.4.7  2000/01/28 22:24:25  oconnor
--| released
--|
--| Revision 1.24.4.6  2000/01/27 19:30:57  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.24.4.5  2000/01/21 23:01:02  oconnor
--| major revision, formatting, comments, contracts
--|
--| Revision 1.24.4.4  2000/01/18 19:39:07  oconnor
--| formatting
--|
--| Revision 1.24.4.3  1999/12/30 00:56:14  rogers
--| valid position has been changed to valid_caret_position. position has been
--| changed to caret_position, and set_insertion_position has been changed to
--| set_caret_position.
--|
--| Revision 1.24.4.2  1999/12/01 20:31:54  oconnor
--| renameed set_position to set_insertion_position due do clash with EV_WIDGET.
--| set_position (x,y)
--|
--| Revision 1.24.4.1  1999/11/24 17:30:56  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.23.2.3  1999/11/04 23:10:55  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.23.2.2  1999/11/02 17:20:13  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
