note
	description:
		"EiffelVision text component. Implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TEXT_COMPONENT_I

inherit
	EV_PRIMITIVE_I
		redefine
			interface
		end

	EV_TEXTABLE_I
		redefine
			interface
		end

	EV_TEXT_COMPONENT_ACTION_SEQUENCES_I

feature -- Access

	text_length: INTEGER
			-- Length of the text in `Current'.
		do
			Result := text.count
		ensure
			Result_not_negative: Result >= 0
		end

	selected_text: STRING_32
			-- Text currently selected in `Current'.
		do
			Result := text.substring (start_selection, end_selection - 1)
		end

	maximum_character_width: INTEGER
			-- Maximum width of a single character in `Current'.
		deferred
		end

	clipboard_content: STRING_32
			-- `Result' is current clipboard content.
		deferred
		end

feature -- Status report

	is_editable: BOOLEAN
			-- Is the text editable by the user?
		deferred
		end

	caret_position: INTEGER
			-- Current position of the caret.
		deferred
		end

	has_selection: BOOLEAN
			-- Does `Current' have a selection?
		deferred
		end

	start_selection: INTEGER
			-- Caret position of the start of selected text if any,
			-- otherwise `caret_position'.
		deferred
		ensure
			result_large_enough: Result >= 1
			result_small_enough: Result <= text_length + 1
			consistent_with_selection_start: Result >= start_selection
		end

	end_selection: INTEGER
			-- Caret position of the end of selected text if any,
			-- otherwise `caret_position'.
		deferred
		ensure
			result_large_enough: Result >= 1
			result_small_enough: Result <= text_length + 1
			consistent_with_selection_end: end_selection >= Result
		end

	valid_caret_position (pos: INTEGER): BOOLEAN
			-- Is `pos' a valid position for the caret?
		do
			Result := pos >= 1 and pos <= text_length + 1
		end

feature -- Status setting

	set_editable (flag: BOOLEAN)
			-- if `flag' then make the component read-write.
			-- if not `flag' then make the component read-only.
		require
		deferred
		end

	set_caret_position (pos: INTEGER)
			-- set current insertion position
		require
			valid_caret_position: pos >= 1 and pos <= text_length + 1
		deferred
		end

feature -- Element change

	insert_text (a_text: READABLE_STRING_GENERAL)
			-- Insert `a_text' at the current caret position.
		require
			valid_text: a_text /= Void
		deferred
		end

	append_text (a_text: READABLE_STRING_GENERAL)
			-- append 'a_text' into `Current'.
		require
			valid_text: a_text /= Void
		deferred
		ensure
			text_appended:
		end

	prepend_text (a_text: READABLE_STRING_GENERAL)
			-- prepend 'a_text' into `Current'.
		require
			valid_text: a_text /= Void
		deferred
		ensure
			text_prepended:
		end

feature -- Resizing

	set_minimum_width_in_characters (nb: INTEGER)
			-- Make a minimum of `nb' of the widest character visible
			-- on one line.
		require
			valid_nb: nb > 0
		deferred
		end

feature {EV_ANY, EV_ANY_I} -- Basic operation

	select_region (start_pos, end_pos: INTEGER)
			-- Select (highlight) the characters between character positions `start_pos' and `end_pos'.
		require
			valid_start_character_position: start_pos >= 1 and start_pos <= text_length
			valid_end_character_position: end_pos >= 1 and end_pos <= text_length
		deferred
		ensure
			has_selection: has_selection
			selection_set: (start_pos <= end_pos implies
				start_selection = start_pos and end_selection = end_pos + 1) or
				start_selection = end_pos and end_selection = start_pos + 1
		end

	set_selection (a_start_pos, a_end_pos: INTEGER)
			-- Select (highlight) the characters between valid caret positions `a_start_pos' and `a_end_pos'.
		require
			valid_start: a_start_pos > 0 and a_start_pos <= text_length + 1
			valid_end: a_end_pos > 0 and a_end_pos <= text_length + 1
		deferred
		ensure
			selection_set: a_start_pos /= a_end_pos = has_selection
		end

	select_all
			-- Select all the text of `Current'.
		require
			positive_length: text_length > 0
		do
			select_region (1, text.count)
		ensure
			has_selection: has_selection
			selection_start_set: start_selection = 1
			selection_end_set: end_selection = text_length + 1
		end

	deselect_all
			-- Unselect the current selection.
		deferred
		ensure
			has_no_selection: not has_selection
		end

	delete_selection
			-- Delete the current selection.
		require
			has_selection: has_selection
			is_editable: is_editable
		deferred
		ensure
			has_no_selection: not has_selection
		end

	cut_selection
			-- Cut `selected_region' by erasing it from
			-- the text and putting it in the Clipboard to paste it later.
			-- If `selectd_region' is empty, it does nothing.
		require
			has_selection: has_selection
			is_editable: is_editable
		deferred
		end

	copy_selection
			-- Copy `selected_region' into the Clipboard.
			-- If the `selected_region' is empty, it does nothing.
		require
			has_selection: has_selection
		deferred
		end

	paste (index: INTEGER)
			-- Insert the contents of the clipboard
			-- at `index' postion of `text'.
			-- If the Clipboard is empty, it does nothing.
		require
			index_large_enough: index >= 1
			index_small_enough: index <= text_length + 1
			is_editable: is_editable
		deferred
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_TEXT_COMPONENT note option: stable attribute end;
            -- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_TEXT_COMPONENT_I









