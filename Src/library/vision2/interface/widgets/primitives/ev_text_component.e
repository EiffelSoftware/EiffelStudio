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
			is_in_default_state
		end

	EV_TEXT_COMPONENT_ACTION_SEQUENCES
		redefine
			implementation
		end
		
feature {NONE} -- Initialization

	make_with_text (a_text: STRING) is
			-- Create `Current' and assign `a_text' to `text'
		require
			a_text_not_void: a_text /= Void
		do
			default_create
			set_text (a_text)
		ensure
			text_assigned: text.is_equal (a_text) and text /= a_text
		end

feature -- Access

	text: STRING is
			-- Text of `Current'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.text
		ensure
			bridge_ok: equal (Result, implementation.text)
			not_void: Result /= Void
			cloned: Result /= implementation.text
		end 

	text_length: INTEGER is
			-- Number of characters making up `text'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.text_length
		ensure
			bridge_ok: Result = implementation.text_length
		end

	selected_text: STRING is
			-- Currently selected text.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.selected_text
		ensure
			bridge_ok: Result.is_equal (implementation.selected_text)
		end

feature -- Status report

	is_editable: BOOLEAN is
			-- Is `text' editable?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.is_editable
		ensure
			bridge_ok: Result = implementation.is_editable
		end

	caret_position: INTEGER is
			-- Current position of caret.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.caret_position
		ensure
			bridge_ok: Result = implementation.caret_position
		end

	has_selection: BOOLEAN is
			-- Does current have a selection?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.has_selection
		ensure
			bridge_ok: Result = implementation.has_selection
		end

	selection_start: INTEGER is
			-- Index of first selected character.
		require
			not_destroyed: not is_destroyed
			has_selection: has_selection
		do
			Result := implementation.selection_start
		ensure
			bridge_ok: Result = implementation.selection_start
			within_range: Result >= 1 and Result <= text_length
			consistent_with_selection_end: selection_end >= Result
		end

	selection_end: INTEGER is
			-- Index of last character selected
		require
			not_destroyed: not is_destroyed
			has_selection: has_selection
		do
			Result := implementation.selection_end
		ensure
			bridge_ok: Result = implementation.selection_end
			within_range: Result >= 1 and Result <= text_length
			consistent_with_selection_start: Result >= selection_start
		end

	valid_caret_position (pos: INTEGER): BOOLEAN is
			-- Is `pos' a valid caret position?
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.valid_caret_position (pos)
		ensure
			bridge_ok: Result = implementation.valid_caret_position (pos)
		end

feature -- Status setting
	
	enable_edit is
			-- Make `Current' editable.
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_editable (True)
		ensure
			is_editable: is_editable 
		end

	disable_edit is
			-- Make `Current' read-only.
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_editable (False)
		ensure
			is_editable: not is_editable 
		end
	
	set_caret_position (a_caret_position: INTEGER) is
			-- Assign `a_caret_posiiton' to `caret_position'.
		require
			not_destroyed: not is_destroyed
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
			not_destroyed: not is_destroyed
			text_not_void: a_text /= Void
			no_carriage_returns: not a_text.has ('%R')
		do
			implementation.set_text (a_text)
		ensure
			text_set: check_text_modification (Void, a_text)
		end

	remove_text is
			-- Make `text' empty.
		require
			not_destroyed: not is_destroyed
		do
			implementation.remove_text
		ensure
			text_empty: text.is_empty
		end

	insert_text (a_text: STRING) is
			-- Insert `a_text' to right of `caret_position'.
		require
			not_destroyed: not is_destroyed
			text_not_void: a_text /= Void
			no_carriage_returns: not a_text.has ('%R')
		do
			implementation.insert_text (a_text)
		ensure
			text_insert_correctly: text.is_equal ((old text).substring (1,
				(old caret_position - 1)) + a_text + (old text).substring
				((old caret_position), (old text.count)))
			caret_not_moved: old caret_position = caret_position
		end

	append_text (a_text: STRING) is
			-- Append `a_text' to `text'.
		require
			not_destroyed: not is_destroyed
			text_not_void: a_text /= Void
			no_carriage_returns: not a_text.has ('%R')
		do
			implementation.append_text (a_text)
		ensure
			text_appended: check_text_modification (old text, a_text)
			caret_not_moved: old caret_position = caret_position
		end
	
	prepend_text (a_text: STRING) is
			-- Prepend `a_text' to `text'.
		require
			not_destroyed: not is_destroyed
			text_not_void: a_text /= Void
			no_carriage_returns: not a_text.has ('%R')
		do
			implementation.prepend_text (a_text)
		ensure
			text_prepended:  text.is_equal (a_text + old text)
			caret_not_moved: old caret_position = caret_position
		end

feature -- Resizing

	set_minimum_width_in_characters (nb: INTEGER) is
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

	select_region (start_pos, end_pos: INTEGER) is
			-- Select text between `start_pos' and `end_pos' inclusive.
		require
			not_destroyed: not is_destroyed
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
			not_destroyed: not is_destroyed
			positive_length: text_length > 0
		do
			implementation.select_all
		ensure
			has_selection: has_selection
			selection_start_set: selection_start = 1
			selection_end_set: selection_end = text_length
		end

	deselect_all is
			-- Unselect the current selection.
		require
			not_destroyed: not is_destroyed
		do
			if has_selection then
				implementation.deselect_all
			end
		ensure
			not_has_selection: not has_selection
		end

	delete_selection is
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
				(1, old selection_start - 1) + (old text).substring
				(old selection_end + 1, (old text).count))
		end

	cut_selection is
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
				(1, old selection_start - 1) + (old text).substring
				(old selection_end + 1, (old text).count))
		end

	copy_selection is
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

	paste (a_position: INTEGER) is
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

	maximum_character_width: INTEGER is
			-- Maximum width of a single character in `Current'.
		do
			Result := implementation.maximum_character_width
		end
	
	clipboard_content: STRING is
			-- `Result' is contents of the clipboard.
		do
			Result := implementation.clipboard_content
		end

	check_text_modification (old_text, added_text: STRING): BOOLEAN is
			-- Ensure that `text' is equal to `old_text' + `added_text' with
			-- all %R removed.
		do
			added_text.prune_all ('%R')
			if old_text /= Void then
				Result := text.is_equal (old_text + added_text)
			else
				Result := text.is_equal (added_text)
			end
		end

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_PRIMITIVE} and text.is_empty and
				is_editable and caret_position = 1 and not has_selection
		end

feature {EV_ANY_I} -- Implementation

	implementation: EV_TEXT_COMPONENT_I
			-- Responsible for interaction with native graphics
			-- toolkit.

invariant
	text_not_void: is_usable implies text /= Void
			
end -- class EV_TEXT_COMPONENT

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

