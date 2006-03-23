indexing
	description:
		"EiffelVision text area. Implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_TEXT_I

inherit
	EV_TEXT_COMPONENT_I
		redefine
			interface
		end

	EV_FONTABLE_I
		redefine
			interface
		end

feature -- Access

	line (i: INTEGER): STRING_32 is
			-- `Result' is content of the `i'th line.
		require
			valid_line: valid_line_index (i)
		deferred
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
		deferred
		end

	current_line_number: INTEGER is
			-- `Result'is number of line containing cursor.
		require
		deferred
		ensure
			valid_line_index: valid_line_index (Result)
		end

	line_count: INTEGER is
			-- Number of lines of text in `Current'.
		deferred
		ensure
			result_greater_zero: Result > 0
		end

	first_position_from_line_number (i: INTEGER): INTEGER is
			-- Position of the first character on the `i'-th line.
		require
			valid_line: valid_line_index (i)
		deferred
		ensure
			valid_caret_position: valid_caret_position (i)
		end

	last_position_from_line_number (i: INTEGER): INTEGER is
			-- Position of the last character on the `i'-th line.
		require
			valid_line: valid_line_index (i)
		deferred
		ensure
			valid_caret_position: valid_caret_position (i)
		end

	line_number_from_position (i: INTEGER): INTEGER is
			-- Line containing caret position `i'.
		require
			valid_caret_position: valid_caret_position (i)
		deferred
		ensure
			valid_line_number: Result >= 1 and Result <= line_count
		end

feature -- Basic operation

	enable_word_wrapping is
			-- Ensure `has_word_wrap' is True.
		deferred
		ensure
			word_wrapping_enabled: has_word_wrapping
		end

	disable_word_wrapping is
			-- Ensure `has_word_wrap' is False.
		deferred
		ensure
			word_wrapping_disabled: not has_word_wrapping
		end

	search (str: STRING_GENERAL; start: INTEGER): INTEGER is
			-- Position of first occurrence of `str' at or after `start';
			-- 0 if none.
		require
			valid_string: str /= Void
		do
			Result := text.substring_index (str, start)
		end

	scroll_to_line (i: INTEGER) is
			-- Ensure that line `i' is visible in `Current'.
		require
			valid_line_index: valid_line_index (i)
		deferred
		end

feature -- Assertions

	valid_line_index (i: INTEGER): BOOLEAN is
			-- Is `i' a valid line index?
		require
		do
			Result := i > 0 and i <= line_count
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TEXT;

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




end -- class EV_TEXT_I

