indexing
	description:
		"[
			EiffelVision text area. To query multiple lines of text from the user.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TEXT

inherit
	EV_TEXT_COMPONENT
		redefine
			implementation,
			is_in_default_state
		end

	EV_FONTABLE
		undefine
			is_in_default_state
		redefine
			implementation,
			is_in_default_state
		end

create
	default_create,
	make_with_text

feature -- Access

	line (i: INTEGER): STRING_32 is
			-- `Result' is content of `i'th line.
		require
			not_destroyed: not is_destroyed
			valid_line_index: valid_line_index (i)
		do
			Result := implementation.line (i)
		ensure
			result_not_void: Result /= Void
		end

feature -- Status report

	has_word_wrapping: BOOLEAN is
			-- Is word wrapping enabled?
			-- If enabled, lines that are too long to be displayed
			-- in `Current' will be wrapped onto new lines.
			-- If disabled, a horizontal scroll bar will be displayed
			-- and lines will not be wrapped.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.has_word_wrapping
		ensure
			bridge_ok: Result = implementation.has_word_wrapping
		end

	current_line_number: INTEGER is
			-- Line currently containing cursor.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.current_line_number
		ensure
			valid_line_index: valid_line_index (Result)
		end

	line_count: INTEGER is
			-- Number of lines in `Current'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.line_count
		ensure
			result_greater_zero: Result > 0
		end

	first_position_from_line_number (i: INTEGER): INTEGER is
			-- Position of first character on `i'-th line.
		require
			not_destroyed: not is_destroyed
			valid_line: valid_line_index (i)
		do
			Result := implementation.first_position_from_line_number (i)
		ensure
			valid_caret_position: valid_caret_position (i)
		end

	last_position_from_line_number (i: INTEGER): INTEGER is
			-- Position of last character on `i'-th line.
		require
			not_destroyed: not is_destroyed
			valid_line: valid_line_index (i)
		do
			Result := implementation.last_position_from_line_number (i)
		ensure
			valid_caret_position: valid_caret_position (i)
		end

	line_number_from_position (i: INTEGER): INTEGER is
			-- Line containing caret position `i'.
		require
			not_destroyed: not is_destroyed
			valid_caret_position: valid_caret_position (i)
		do
			Result := implementation.line_number_from_position (i)
		ensure
			valid_line_number: Result >= 1 and Result <= line_count
		end

feature -- Basic operation

	enable_word_wrapping is
			-- Ensure `has_word_wrapping' is True.
		require
			not_destroyed: not is_destroyed
		do
			implementation.enable_word_wrapping
		ensure
			word_wrapping_enabled: has_word_wrapping
		end

	disable_word_wrapping is
			-- Ensure `has_word_wrapping' is False.
		require
			not_destroyed: not is_destroyed
		do
			implementation.disable_word_wrapping
		ensure
			word_wrapping_disabled: not has_word_wrapping
		end

	scroll_to_line (i: INTEGER) is
			-- Ensure that line `i' is visible in `Current'.
		require
			not_destroyed: not is_destroyed
			valid_line_index: valid_line_index (i)
		do
			implementation.scroll_to_line (i)
		end

	search (str: STRING_GENERAL; start: INTEGER): INTEGER is
			-- Position of first occurrence of `str' at or after `start';
			-- 0 if none.
		require
			not_destroyed: not is_destroyed
			valid_string: str /= Void
		do
			Result := implementation.search (str, start)
		end

	select_lines (first_line, last_line: INTEGER) is
			-- Select all lines from `first_line' to `last_line'.
		require
			not_destroyed: not is_destroyed
			valid_line_index: valid_line_index (first_line) and valid_line_index (last_line)
		do
			select_region (first_position_from_line_number (first_line),
								last_position_from_line_number (last_line))
		ensure
			has_selection: has_selection
		end

feature -- Contract support

	valid_line_index (i: INTEGER): BOOLEAN is
			-- Is `i' a valid line index?
		do
			Result := i > 0 and i <= line_count
		end

	last_line_not_empty: BOOLEAN is
			-- Has last line at least one character?
		obsolete "Use `not line (line_count).is_empty'"
		do
			Result := not line (line_count).is_empty
		end

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_TEXT_COMPONENT} and Precursor {EV_FONTABLE} and has_word_wrapping
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_TEXT_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_TEXT_IMP} implementation.make (Current)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_TEXT

