indexing

	description: "Eiffel scanner skeletons"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class EIFFEL_SCANNER_SKELETON

inherit

	YY_COMPRESSED_SCANNER_SKELETON
		rename
			make as make_compressed_scanner_skeleton
		redefine
			reset, fatal_error
		end

	EIFFEL_TOKENS
		export {NONE} all end

	BASIC_ROUTINES
		export {NONE} all end

	SHARED_ERROR_HANDLER
		export {NONE} all end

	COMPILER_EXPORTER
		export {NONE} all end

feature {NONE} -- Initialization

	make is
			-- Create a new Eiffel scanner.
		do
			make_with_buffer (Empty_buffer)
			!! token_buffer.make (Initial_buffer_size)
			!! verbatim_marker.make (Initial_verbatim_marker_size)
			!! current_position.reset
			line_number := 1
			filename := ""
		end

feature -- Initialization

	reset is
			-- Reset scanner before scanning next input source.
			-- (This routine can be called in wrap before scanning
			-- another input buffer.)
		do
			Precursor
			token_buffer.clear_all
			verbatim_marker.clear_all
			current_position.reset
			line_number := 1
			inherit_context := False
		end

feature -- Access

	filename: STRING
			-- Name of file being parsed

	line_number: INTEGER
			-- Current line number

	current_position: TOKEN_LOCATION
			-- Position of last token read

	start_position: INTEGER is
			-- Start position of last token
		do
			Result := current_position.start_position
		ensure
			definition: Result = current_position.start_position
		end

	end_position: INTEGER is
			-- End position of last token
		do
			Result := current_position.end_position
		ensure
			definition: Result = current_position.end_position
		end

	last_value: ANY
			-- Semantic value to be passed to the parser

	token_buffer: STRING
			-- Buffer for lexial tokens

	verbatim_marker: STRING
			-- Sequence of characters between " and [
			-- in Verbatim_string_opener

	inherit_context: BOOLEAN
			-- Was the last token an `end' keyword recognized
			-- by an `inherit' clause with an empty parent
			-- adaptation subclause?
			--
			-- class FOO
			-- inherit
			--		BAR
			--		end

feature -- Osolete

	error_code: INTEGER is 0
	error_message: STRING is ""
			-- Compatibility with parser written in C with yacc

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

	report_character_invalid_code_error (a_code: INTEGER) is
			-- Invalid character code after %.
		local
			an_error: BAD_CHARACTER
		do
			!! an_error.make (current_position.start_position, current_position.end_position, filename, 0, "", False)
			Error_handler.insert_error (an_error)
			Error_handler.raise_error

				-- Dummy code (for error recovery) follows:
			token_buffer.append_character ('a')
			last_token := TE_CHAR
		end

	report_character_missing_quote_error (char: STRING) is
			-- Invalid character: final quote missing.
		require
			char_not_void: char /= Void
		local
			an_error: BAD_CHARACTER
		do
			!! an_error.make (current_position.start_position, current_position.end_position, filename, 0, "", False)
			Error_handler.insert_error (an_error)
			Error_handler.raise_error

				-- Dummy code (for error recovery) follows:
			token_buffer.append_character ('a')
			last_token := TE_CHAR
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
			if a_string.is_empty then
				last_token := TE_EMPTY_STRING
			else
				last_token := TE_STRING
			end
		end

	report_missing_end_of_verbatim_string_error (a_string: STRING) is
			-- Invalid verbatim string: final bracket-quote missing.
		require
			a_string_not_void: a_string /= Void
		local
			an_error: VERBATIM_STRING_UNCOMPLETED
		do
			!! an_error.make (current_position.start_position, current_position.end_position, filename, 0, "", False)
			Error_handler.insert_error (an_error)
			Error_handler.raise_error

				-- Dummy code (for error recovery) follows:
			if a_string.is_empty then
				last_token := TE_EMPTY_VERBATIM_STRING
			else
				last_token := TE_VERBATIM_STRING
			end
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

	is_verbatim_string_closer: BOOLEAN is
			-- Is `text' a valid Verbatim_string_closer?
		require
			-- valid_text: `text' matches regexp [ \t\r]*\][^%\n"]*\"
		local
			i, j, nb: INTEGER
			found: BOOLEAN
		do
				-- Look for first character ].
				-- (Note that `text' matches the following
				-- regexp:   [ \t\r]*\][^%\n"]*\"  .)
			from j := 1 until found loop
				if text_item (j) = ']' then
					found := True
				end
				j := j + 1
			end
			nb := verbatim_marker.count
			if nb = (text_count - j) then
				Result := True
				from i := 1 until i > nb loop
					if verbatim_marker.item (i) = text_item (j) then
						i := i + 1
						j := j + 1
					else
						Result := False
						i := nb + 1  -- Jump out of the loop.
					end
				end
			end
		end

	process_character_code (code: INTEGER) is
			-- Check whether `code' is a valid character code
			-- and set `last_token' accordingly.
		require
			code_positive: code >= 0
		do
			if code > Maximum_character_code then
					-- Bad character code.
				report_character_invalid_code_error (code)
			else
				token_buffer.clear_all
				token_buffer.append_character (charconv (code))
				last_token := TE_CHAR
			end
		end

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

	append_without_underscores (from_string, to_string: STRING) is
			-- Append all characters of `from_string' but underscores
			-- to `to_string'.
		require
			from_string_not_void: from_string /= Void
			to_string_not_void: to_string /= Void
		local
			i, nb: INTEGER
			char: CHARACTER
		do
			nb := from_string.count
			from i := 1 until i > nb loop
				char := from_string.item (i)
				if char /= '_' then
					to_string.append_character (char)
				end
				i := i + 1
			end
		end

	cloned_string (a_string: STRING): STRING is
			-- Clone of `a_string'
			-- (Reduce memory storage if possible.)
		require
			a_string_not_void: a_string /= Void
		do
			!! Result.make (a_string.count)
			Result.append_string (a_string)
		ensure
			cloned_string_not_void: Result /= Void
			new_object: Result /= a_string
			equal: Result.is_equal (a_string)
			less_memory: Result.capacity <= a_string.capacity
		end

	cloned_lower_string (a_string: STRING): STRING is
			-- Clone of `a_string'; convert characters to lower case
			-- (Reduce memory storage if possible.)
		require
			a_string_not_void: a_string /= Void
		do
			!! Result.make (a_string.count)
			Result.append_string (a_string)
			Result.to_lower
		ensure
			cloned_string_not_void: Result /= Void
			new_object: Result /= a_string
			less_memory: Result.capacity <= a_string.capacity
		end

feature {NONE} -- Constants

	Initial_buffer_size: INTEGER is 5120
			-- Initial size for `token_buffer'
			-- (See `eif_rtlimits.h')

	Initial_verbatim_marker_size: INTEGER is 3
			-- Initial size for `verbatim_marker'

	Maximum_character_code: INTEGER is 255
			-- Largest supported code for CHARACTER values

invariant

	token_buffer_not_void: token_buffer /= Void
	verbatim_marker_not_void: verbatim_marker /= Void
	current_position_not_void: current_position /= Void
	filename_not_void: filename /= Void

end -- class EIFFEL_SCANNER_SKELETON


--|----------------------------------------------------------------
--| Copyright (C) 1992-2000, Interactive Software Engineering Inc.
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
