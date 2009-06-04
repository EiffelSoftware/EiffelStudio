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
		require
			has_selection: has_selection
		do
			Result := text.substring (selection_start, selection_end)
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

	selection_start: INTEGER
			-- Index of the first character selected.
		require
			has_selection: has_selection
		deferred
		ensure
			result_large_enough: Result >= 1
			result_small_enough: Result <= text_length
		end

	selection_end: INTEGER
			-- Index of the last character selected.
		require
			has_selection: has_selection
		deferred
		ensure
			result_large_enough: Result >= 1
			result_small_enough: Result <= text_length
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
			valid_caret_position: valid_caret_position (pos)
		deferred
		end

feature -- Element change

	insert_text (a_text: STRING_GENERAL)
			-- Insert `a_text' at the current caret position.
		require
			valid_text: a_text /= Void
		deferred
		end

	append_text (a_text: STRING_GENERAL)
			-- append 'a_text' into `Current'.
		require
			valid_text: a_text /= Void
		deferred
		ensure
			text_appended:
		end

	prepend_text (a_text: STRING_GENERAL)
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
			-- Select (hilight) the text between
			-- `start_pos' and `end_pos'. Both `start_pos' and
			-- `end_pos' are selected.
		require
			valid_start: start_pos >= 1 and start_pos <= text_length
			valid_end: end_pos >= 1 and end_pos <= text_length
		deferred
		ensure
			has_selection: has_selection
			selection_set: (start_pos <= end_pos implies
				selection_start = start_pos and selection_end = end_pos) or
				selection_start = end_pos and selection_end = start_pos
		end

	select_all
			-- Select all the text of `Current'.
		require
			positive_length: text_length > 0
		do
			select_region (1, text.count)
		ensure
			has_selection: has_selection
			selection_start_set: selection_start = 1
			selection_end_set: selection_end = text_length
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

feature {NONE} -- Implementation

	interface: detachable EV_TEXT_COMPONENT note option: stable attribute end;
            -- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_TEXT_COMPONENT_I









