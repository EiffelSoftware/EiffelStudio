note
	description:
		"[
			Eiffel Vision text component. Base class for text editing widgets.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TEXT_COMPONENT

inherit
	EV_PRIMITIVE
		redefine
			implementation,
			is_in_default_state
		end

	EV_TEXTABLE
		redefine
			implementation,
			is_in_default_state
		end

	EV_TEXT_COMPONENT_ACTION_SEQUENCES

feature -- Access

	text_length: INTEGER
			-- Number of characters making up `text'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.text_length
		ensure
			bridge_ok: Result = implementation.text_length
			definition: Result = text.count
			Result_not_negative: Result >= 0
		end

	selected_text: STRING_32
			-- Currently selected text.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.selected_text
		ensure
			bridge_ok: Result.is_equal (implementation.selected_text)
			definition: has_selection implies text.substring (start_selection, end_selection - 1).is_equal (Result)
		end

feature -- Status report

	is_editable: BOOLEAN
			-- Is `text' editable?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_editable
		ensure
			bridge_ok: Result = implementation.is_editable
		end

	caret_position: INTEGER
			-- Current position of caret.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.caret_position
		ensure
			bridge_ok: Result = implementation.caret_position
			within_range: Result >= 1 and Result <= text_length + 1
		end

	has_selection: BOOLEAN
			-- Does current have a selection?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.has_selection
		ensure
			bridge_ok: Result = implementation.has_selection
			definition: Result implies start_selection /= end_selection
		end

	start_selection: INTEGER
			-- Caret position of the start of selected text if any,
			-- otherwise `caret_position'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.start_selection
		ensure
			bridge_ok: Result = implementation.start_selection
			within_range: Result >= 1 and Result <= text_length + 1
			consistent_with_selection_end: end_selection >= Result
		end

	end_selection: INTEGER
			-- Caret position of the end of selected text if any,
			-- otherwise `caret_position'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.end_selection
		ensure
			bridge_ok: Result = implementation.end_selection
			within_range: Result >= 1 and Result <= text_length + 1
			consistent_with_selection_start: Result >= start_selection
		end

	selection_start: INTEGER
			-- Index of first selected character.
		obsolete
			"Use `start_selection' instead. [2017-05-31]"
		require
			not_destroyed: not is_destroyed
			has_selection: has_selection
		do
			Result := implementation.start_selection
		end

	selection_end: INTEGER
			-- Index of last character selected.
		obsolete
			"Use `end_selection - 1' instead. [2017-05-31]"
		require
			not_destroyed: not is_destroyed
			has_selection: has_selection
		do
			Result := implementation.end_selection - 1
		end

	valid_caret_position (pos: INTEGER): BOOLEAN
			-- Is `pos' a valid caret position?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.valid_caret_position (pos)
		ensure
			bridge_ok: Result = implementation.valid_caret_position (pos)
			within_range: Result implies (pos >= 1 and pos <= text_length + 1)
		end

feature -- Status setting

	enable_edit
			-- Make `Current' editable.
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_editable (True)
		ensure
			is_editable: is_editable
		end

	disable_edit
			-- Make `Current' read-only.
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_editable (False)
		ensure
			is_editable: not is_editable
		end

	set_caret_position (a_caret_position: INTEGER)
			-- Assign `a_caret_position' to `caret_position'.
		require
			not_destroyed: not is_destroyed
			valid_caret_position: a_caret_position >= 1 and a_caret_position <= text_length + 1
		do
			implementation.set_caret_position (a_caret_position)
		ensure
			caret_position_assigned: change_actions.is_empty implies caret_position = a_caret_position
		end

feature -- Element change

	insert_text (a_text: READABLE_STRING_GENERAL)
			-- Insert `a_text' to right of `caret_position'.
		require
			not_destroyed: not is_destroyed
			text_not_void: a_text /= Void
			no_carriage_returns: not a_text.has_code (('%R').natural_32_code)
		do
			implementation.insert_text (a_text)
		ensure
			text_insert_correctly: text.is_equal ((old text).substring (1,
				(old caret_position - 1)) + a_text.as_string_32 + (old text).substring
				((old caret_position), (old text.count)))
			caret_not_moved: old caret_position = caret_position
		end

	append_text (a_text: READABLE_STRING_GENERAL)
			-- Append `a_text' to `text'.
		require
			not_destroyed: not is_destroyed
			text_not_void: a_text /= Void
			no_carriage_returns: not a_text.has_code (('%R').natural_32_code)
		do
			implementation.append_text (a_text)
		ensure
			text_appended: check_text_modification (old text, a_text.as_string_32)
			caret_not_moved: old caret_position = caret_position
		end

	prepend_text (a_text: READABLE_STRING_GENERAL)
			-- Prepend `a_text' to `text'.
		require
			not_destroyed: not is_destroyed
			text_not_void: a_text /= Void
			no_carriage_returns: not a_text.has_code (('%R').natural_32_code)
		do
			implementation.prepend_text (a_text)
		ensure
			text_prepended:  text.is_equal (a_text.as_string_32 + old text)
			caret_not_moved: old caret_position = caret_position
		end

feature -- Resizing

	set_minimum_width_in_characters (nb: INTEGER)
			-- Make a minimum of `nb' of the widest character visible
			-- on one line.
		require
			not_destroyed: not is_destroyed
			valid_nb: nb > 0
		do
			implementation.set_minimum_width_in_characters (nb)
		ensure
			minimum_width_in_characters_assigned: old minimum_width <
				minimum_width implies minimum_width >=
				maximum_character_width * nb
		end

feature -- Basic operation

	select_region (a_start_character_pos, a_end_character_pos: INTEGER)
			-- Select (highlight) text between `a_start_character_pos' and `a_end_character_pos' character positions inclusive.
		require
			not_destroyed: not is_destroyed
			start_within_range: a_start_character_pos >= 1 and a_start_character_pos <= text_length
			end_within_range: a_end_character_pos >= 1 and a_end_character_pos <= text_length
		do
			implementation.select_region (a_start_character_pos, a_end_character_pos)
		ensure
			has_selection: has_selection
			selection_set: (a_start_character_pos <= a_end_character_pos implies
				start_selection = a_start_character_pos and end_selection = a_end_character_pos + 1) or
				start_selection = a_end_character_pos and end_selection = a_start_character_pos + 1
		end

	set_selection (a_start_pos, a_end_pos: INTEGER)
			-- Select (highlight) the characters between valid caret positions `a_start_pos' and `a_end_pos'.
		require
			valid_start: a_start_pos > 0 and a_start_pos <= text_length + 1
			valid_end: a_end_pos > 0 and a_end_pos <= text_length + 1
		do
			implementation.set_selection (a_start_pos, a_end_pos)
		ensure
			selection_set: a_start_pos /= a_end_pos = has_selection
			caret_set: (a_start_pos = a_end_pos) implies caret_position = a_start_pos
			selection_bounds_set: (a_start_pos <= a_end_pos implies
				(start_selection = a_start_pos and end_selection = a_end_pos)) or
				(start_selection = a_end_pos and end_selection = a_start_pos)
		end

	select_all
			-- Select all text.
		require
			not_destroyed: not is_destroyed
			positive_length: text_length > 0
		do
			implementation.select_all
		ensure
			has_selection: has_selection
			selection_start_set: start_selection = 1
			selection_end_set: end_selection = text_length + 1
		end

	deselect_all
			-- Unselect current selection.
		require
			not_destroyed: not is_destroyed
		do
			if has_selection then
				implementation.deselect_all
			end
		ensure
			not_has_selection: not has_selection
		end

	delete_selection
			-- Delete current selection.
		require
			not_destroyed: not is_destroyed
			has_selection: has_selection
			is_editable: is_editable
		do
			implementation.delete_selection
		ensure
			has_no_selection: not has_selection
			selection_deleted: text.is_equal ((old text).substring
				(1, old start_selection - 1) + (old text).substring
				(old end_selection, (old text).count))
		end

	cut_selection
			-- Move `selected_text' to clipboard.
		require
			not_destroyed: not is_destroyed
			has_selection: has_selection
			is_editable: is_editable
		do
			implementation.cut_selection
		ensure
			selection_in_clipboard:
				clipboard_content.is_equal (old selected_text)
			selection_cut: text.is_equal ((old text).substring
				(1, old start_selection - 1) + (old text).substring
				(old end_selection, (old text).count))
		end

	copy_selection
			-- Copy `selected_text' to clipboard.
		require
			not_destroyed: not is_destroyed
			has_selection: has_selection
		do
			implementation.copy_selection
		ensure
			selection_copied: clipboard_content.is_equal (selected_text)
			text_unchanged: text.is_equal (old text)
			caret_not_moved: caret_position = old caret_position
		end

	paste (a_position: INTEGER)
			-- Insert text from `clipboard' at `a_position'.
			-- No effect if clipboard is empty.
		require
			not_destroyed: not is_destroyed
			a_position_within_range:
				a_position >= 1 and a_position <= text_length + 1
			is_editable: is_editable
		do
			implementation.paste (a_position)
		ensure
			text_pasted_correctly: text.is_equal ((old text).substring (1,
				a_position - 1) + clipboard_content + ((old text).substring (
				a_position, ((old text).count))))
			caret_position_consistent:
				old caret_position <= a_position implies
					caret_position = old caret_position
			caret_position_consistent:
				old caret_position > a_position implies
				caret_position = old caret_position + clipboard_content.count
		end

feature {NONE} -- Contract support

	maximum_character_width: INTEGER
			-- Maximum width of a single character in `Current'.
		do
			Result := implementation.maximum_character_width
		end

	clipboard_content: STRING_32
			-- `Result' is contents of the clipboard.
		do
			Result := implementation.clipboard_content
		end

	check_text_modification (old_text, added_text: STRING_32): BOOLEAN
			-- Ensure that `text' is equal to `old_text' + `added_text' with
			-- all %R removed.
		do
			added_text.prune_all ('%R')
			Result := text.is_equal (old_text + added_text)
		end

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_PRIMITIVE} and text.is_empty and
				is_editable and caret_position = 1 and not has_selection
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_TEXT_COMPONENT_I
			-- Responsible for interaction with native graphics
			-- toolkit.

invariant

note
	copyright:	"Copyright (c) 1984-2015, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_TEXT_COMPONENT

