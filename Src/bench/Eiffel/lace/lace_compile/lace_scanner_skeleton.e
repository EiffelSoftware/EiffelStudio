indexing

	description: "Lace scanner skeletons"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class LACE_SCANNER_SKELETON

inherit

	YY_COMPRESSED_SCANNER_SKELETON
		rename
			make as make_compressed_scanner_skeleton
		redefine
			reset, fatal_error
		end

	LACE_TOKENS
		export {NONE} all end

	BASIC_ROUTINES
		export {NONE} all end

	SHARED_ERROR_HANDLER
		export {NONE} all end

	COMPILER_EXPORTER
		export {NONE} all end

feature {NONE} -- Initialization

	make is
			-- Create a new Lace scanner.
		do
			make_with_buffer (Empty_buffer)
			create token_buffer.make (Initial_buffer_size)
			create comment_list.make (10)
			create current_position.reset
			line_number := 1
			filename := ""
		end

feature -- Initialization

	reset is
			-- Reset scanner before scanning next input source.
			-- (This routine can be called in wrap before scanning
			-- another input buffer.)
		do
			Precursor {YY_COMPRESSED_SCANNER_SKELETON}
			token_buffer.clear_all
			current_position.reset
			line_number := 1
		end

	reset_comment_list is
			-- Reset comment_list before scanning next input source.
		do
			create comment_list.make (10)
		end

feature -- Access

	filename: STRING
			-- Name of file being parsed

	line_number: INTEGER
			-- Current line number

	current_position: TOKEN_LOCATION
			-- Position of last token read

	last_value: ANY
			-- Semantic value to be passed to the parser

	token_buffer: STRING
			-- Buffer for lexial tokens

	comment_list: ARRAYED_LIST [STRING]
			-- List all comments from file being parsed.

feature -- Error handling

	fatal_error (a_message: STRING) is
			-- A fatal error occurred.
			-- Log `a_message' and raise an exception.
		local
			an_error: SYNTAX_ERROR
		do
			!! an_error.make (current_position.start_position, current_position.end_position, filename, 0, a_message, False)
			Error_handler.insert_error (an_error)
			Error_handler.raise_error
		end

	report_string_bad_special_character_error is
			-- Invalid special character after % in manisfest string.
		local
			an_error: STRING_EXTENSION
		do
			!! an_error.make (current_position.start_position, current_position.end_position, filename, 0, "", False)
			Error_handler.insert_error (an_error)
			Error_handler.raise_error

				-- Dummy code (for error recovery) follows:
			token_buffer.append_character ('a')
		end

	report_string_invalid_code_error (a_code: INTEGER) is
			-- Invalid character code after % in manisfest string.
		local
			an_error: STRING_EXTENSION
		do
			!! an_error.make (current_position.start_position, current_position.end_position, filename, 0, "", False)
			Error_handler.insert_error (an_error)
			Error_handler.raise_error

				-- Dummy code (for error recovery) follows:
			token_buffer.append_character ('a')
		end

	report_string_missing_quote_error (a_string: STRING) is
			-- Invalid string: final quote missing.
		require
			a_string_not_void: a_string /= Void
		local
			an_error: STRING_UNCOMPLETED
		do
			!! an_error.make (current_position.start_position, current_position.end_position, filename, 0, "", False)
			Error_handler.insert_error (an_error)
			Error_handler.raise_error

				-- Dummy code (for error recovery) follows:
			last_token := LAC_STRING
		end

	report_string_empty_error is
			-- Invalid string: empty string.
		local
			an_error: STRING_EMPTY
		do
			!! an_error.make (current_position.start_position, current_position.end_position, filename, 0, "", False)
			Error_handler.insert_error (an_error)
			Error_handler.raise_error
		end

	report_unknown_token_error (a_token: CHARACTER) is
			-- Unknown token.
		local
			an_error: SYNTAX_ERROR
		do
			!! an_error.make (current_position.start_position, current_position.end_position, filename, 0, "", False)
			Error_handler.insert_error (an_error)
			Error_handler.raise_error
		end

feature {NONE} -- Implementation

	process_string_character_code (code: INTEGER) is
			-- Check whether `code' is a valid character code
			-- in a string and set `last_token' accordingly.
		require
			code_positive: code >= 0
		do
			if code > Maximum_character_code then
					-- Bad character code.
				set_start_condition (0)
				report_string_invalid_code_error (code)
			else
				token_buffer.append_character (charconv (code))
			end
		end

feature {NONE} -- Constants

	Initial_buffer_size: INTEGER is 5120
			-- Initial size for `token_buffer'
			-- (See `eif_rtlimits.h')

	Maximum_character_code: INTEGER is 255
			-- Largest supported code for CHARACTER values

invariant

	token_buffer_not_void: token_buffer /= Void
	current_position_not_void: current_position /= Void
	filename_not_void: filename /= Void

end -- class LACE_SCANNER_SKELETON


--|----------------------------------------------------------------
--| Copyright (C) 1992-1999, Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited
--| without prior agreement with Interactive Software Engineering.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------
