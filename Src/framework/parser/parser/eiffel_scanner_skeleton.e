indexing

	description: "Eiffel scanner skeletons"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	REFACTORING_HELPER
		export {NONE} all end

feature {NONE} -- Initialization

	make is
			-- Create a new Eiffel scanner using default factory for creating AST nodes.
		local
			l_factory: AST_FACTORY
		do
			create l_factory
			make_with_factory (l_factory)
		end

	make_with_factory (a_factory: AST_FACTORY) is
			-- Create a new Eiffel scanner using `a_factory' as factory to create AST nodes.
		require
			a_factory_not_void: a_factory /= Void
		do
			ast_factory := a_factory
			make_with_buffer (Empty_buffer)
			create token_buffer.make (Initial_buffer_size)
			create token_buffer2.make (Initial_buffer_size)
			create verbatim_marker.make (Initial_verbatim_marker_size)
			filename := ""
			is_indexing_keyword := True
			is_note_keyword := False
			is_attribute_keyword := False
		ensure
			ast_factory_set: ast_factory = a_factory
		end

feature -- Initialization

	reset is
			-- Reset scanner before scanning next input source.
			-- (This routine can be called in wrap before scanning
			-- another input buffer.)
		do
			Precursor
			token_buffer.clear_all
			token_buffer2.clear_all
			verbatim_marker.clear_all
			is_indexing_keyword := True
			is_note_keyword := False
			is_attribute_keyword := False
		end

feature -- Roundtrip

	match_list: LEAF_AS_LIST
			-- List of all tokens used for roundtrip

	initial_match_list_size: INTEGER is 1000
			-- Initial size of `match_list'.

	token_buffer2: STRING
			-- Buffer for verbatim string tokens

	verbatim_start_position: INTEGER
			-- Start position of verbatim string being scanned

	string_start_position: INTEGER
			-- Start position of regular string being scanned	

	last_keyword_as_id_index: INTEGER
			-- Last index in `match_list' for keywords that can be used as identifier

	last_break_as_start_line: INTEGER
			-- Start line of last BREAK_AS node

	last_break_as_start_column: INTEGER
			-- Start column of last BREAK_AS node

	last_break_as_start_position: INTEGER
			-- Start position of last BREAK_AS node

feature -- Access

	ast_factory: AST_FACTORY
			-- Abstract Syntax Tree factory

	current_class: ABSTRACT_CLASS_C
			-- Current class being parsed.
			-- It can be Void in a parsing that does not involve compilation

	filename: STRING
			-- Name of file being parsed

	last_value: ANY
			-- Semantic value to be passed to the parser

	last_line_pragma: BREAK_AS
			-- Last line pragma to be associated with next instruction

	token_buffer: STRING
			-- Buffer for lexical tokens

	string_position: INTEGER
			-- Start position of a string token

	verbatim_marker: STRING
			-- Sequence of characters between " and [
			-- in Verbatim_string_opener

	has_syntax_warning: BOOLEAN
			-- Do we create SYNTAX_WARNING instances for obsolte syntactical constructs?

	has_old_verbatim_strings: BOOLEAN
			-- Is old semantics of verbatim strings used?

	has_old_verbatim_strings_warning: BOOLEAN
			-- Are warnings produces for old semantics of verbatim strings?

	Maximum_string_character_code: INTEGER is 0xFF
			-- Maximum value for character code inside a string

	Maximum_bit_constant: INTEGER is 0x7FFF
			-- Maximum value of Constant in Bit_type declaration

	Maximum_string_length: INTEGER is 0x7FFF
			-- Maximum length of tokens that require a string representation
			-- (such as Identifier, Manifest_string, Free_operator)
			-- The limit is imposed by
			--   byte-code format (string length is encoded as a short integer with maximum 0x7FFF)
			--   C compiler (e.g., CL does not support strings longer than 0xFFFF bytes)
			--   CLI specification (e.g., identifiers cannot be longer 0x1FFFFFFF bytes)

feature {NONE} -- Status

	is_note_keyword: BOOLEAN
			-- Is "note" keyword allowed in current context?

	is_indexing_keyword: BOOLEAN
			-- Is "indexing" keyword allowed in current context?

	is_attribute_keyword: BOOLEAN
			-- Is "attribute" keyword allowed in current context?

feature -- Convenience

	token_line (a_node: AST_EIFFEL): like line is
			-- Line of `a_node' if not Void, `line' otherwise.
		do
			if a_node /= Void then
				Result := a_node.start_location.line
			else
				Result := line
			end
		end

	token_column (a_node: AST_EIFFEL): like column is
			-- Line of `a_node' if not Void, `column' otherwise.
		do
			if a_node /= Void then
				Result := a_node.start_location.column
			else
				Result := column
			end
		end

feature -- Osolete

	error_code: INTEGER is 0
	error_message: STRING is ""
			-- Compatibility with parser written in C with yacc

feature -- Settings

	set_has_syntax_warning (b: BOOLEAN) is
			-- Set `has_syntax_warning' to `b'
		do
			has_syntax_warning := b
		ensure
			has_syntax_warning_set: has_syntax_warning = b
		end

	set_has_old_verbatim_strings (b: BOOLEAN) is
			-- Set `has_old_verbatim_strings' to `b'
		do
			has_old_verbatim_strings := b
		ensure
			has_old_verbatim_strings_set: has_old_verbatim_strings = b
		end

	set_has_old_verbatim_strings_warning (b: BOOLEAN) is
			-- Set `has_old_verbatim_strings_warning' to `b'.
		do
			has_old_verbatim_strings_warning := b
		ensure
			has_old_verbatim_strings_warning_set: has_old_verbatim_strings_warning = b
		end

	set_is_indexing_keyword (value: BOOLEAN)
			-- Set `is_indexing_keyword' to `value'
		do
			is_indexing_keyword := value
		ensure
			is_indexing_keyword_set: is_indexing_keyword = value
		end

	set_is_note_keyword (value: BOOLEAN)
			-- Set `is_note_keyword' to `value'
		do
			is_note_keyword := value
		ensure
			is_note_keyword_set: is_note_keyword = value
		end

	set_is_attribute_keyword (value: BOOLEAN)
			-- Set `is_attribute_keyword' to `value'
		do
			is_attribute_keyword := value
		ensure
			is_attribute_keyword_set: is_attribute_keyword = value
		end

feature {NONE} -- Error handling

	report_one_error (a_error: ERROR) is
			-- Log `a_error'.
		require
			a_error_not_void: a_error /= Void
		do
			a_error.set_associated_class (current_class)
			error_handler.insert_error (a_error)
				-- To avoid reporting more than one error for the same lexical error
				-- we simply abort the scanning.
			terminate
		end

	report_one_warning (a_error: ERROR) is
			-- Log `a_error'.
		require
			a_error_not_void: a_error /= Void
		do
			a_error.set_associated_class (current_class)
			error_handler.insert_warning (a_error)
		end

	fatal_error (a_message: STRING) is
			-- A fatal error occurred.
			-- Log `a_message' and raise an exception.
		do
			report_one_error (create {SYNTAX_ERROR}.make (line, column, filename, a_message))
		end

	report_character_missing_quote_error (char: STRING) is
			-- Invalid character: final quote missing.
		require
			char_not_void: char /= Void
		do
			report_one_error (create {BAD_CHARACTER}.make (line, column, filename, ""))

				-- Dummy code (for error recovery) follows:
			token_buffer.append_character ('a')
			last_token := TE_CHAR
		end

	report_string_bad_special_character_error is
			-- Invalid special character after % in manisfest string.
		do
			report_one_error (create {STRING_EXTENSION}.make (line, column, filename, ""))

				-- Dummy code (for error recovery) follows:
			token_buffer.append_character ('a')
		end

	report_string_invalid_code_error (a_code: INTEGER) is
			-- Invalid character code after % in manisfest string.
		do
			report_one_error (create {STRING_EXTENSION}.make (line, column, filename, ""))

				-- Dummy code (for error recovery) follows:
			token_buffer.append_character ('a')
		end

	report_string_missing_quote_error (a_string: STRING) is
			-- Invalid string: final quote missing.
		require
			a_string_not_void: a_string /= Void
		do
			report_one_error (create {STRING_UNCOMPLETED}.make (line, column, filename, ""))

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
		do
			report_one_error (create {VERBATIM_STRING_UNCOMPLETED}.make (line, column, filename, ""))

				-- Dummy code (for error recovery) follows:
			if a_string.is_empty then
				last_token := TE_EMPTY_VERBATIM_STRING
			else
				last_token := TE_VERBATIM_STRING
			end
		end

	report_too_long_string (a_text: STRING) is
			-- Report that current token has too long string representation.
		require
			valid_token: last_token = TE_STR_FREE or last_token = TE_ID or last_token = TE_STRING or last_token = TE_VERBATIM_STRING
			a_text_not_void: a_text /= Void
			too_long_token: a_text.count > maximum_string_length
		do
			report_one_error (
				create {SYNTAX_ERROR}.make (line, column, filename,
					"Identifier, manifest string or free operator is " + a_text.count.out +
					" characters long that exceeds limit of " + maximum_string_length.out + " characters."))
		end

	report_unknown_token_error (a_token: CHARACTER) is
			-- Unknown token.
		do
			report_one_error (create {SYNTAX_ERROR}.make (line, column, filename, ""))
		end

	report_invalid_integer_error (a_text: STRING) is
			-- Invalid integer
		do
			report_one_error (create {VIIN}.make (line, column, filename, ""))
		end

feature {NONE} -- Implementation

	process_id_as is
			-- Process current token which is an identifier
		local
			l_count: INTEGER
		do
			l_count := text_count
				-- Note: Identifiers are converted to lower-case.
			if l_count > maximum_string_length then
				report_too_long_string (text)
			else
				last_id_as_value := ast_factory.new_filled_id_as (Current)
			end
		end

	process_id_as_with_existing_stub (keyword: KEYWORD_AS; a_index: INTEGER; is_lower: BOOLEAN) is
			-- Process current token which is an identifier and whose leaf stub has been inserted into `match_list'.
			-- For example, an "assign" keyword is later recognized as an identifier.
			-- Used for roundtrip.
		local
			l_count: INTEGER
			message: STRING
		do
			l_count := text_count
				-- Note: Identifiers are converted to lower-case.
			if l_count > maximum_string_length then
				report_too_long_string (text)
			else
				last_id_as_value := ast_factory.new_filled_id_as_with_existing_stub (Current, a_index)
				if has_syntax_warning then
					if last_id_as_value = Void then
						message := once "Keyword is used as identifier."
					else
						message := once "Keyword `" + last_id_as_value.name
						message.append_string ("' is used as identifier.")
					end
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (keyword), token_column (keyword),
							filename, message))
				end
				if last_id_as_value /= Void then
					if is_lower then
						last_id_as_value.to_lower
					else
						last_id_as_value.to_upper
					end
				end
			end
		end

	process_string_character_code (code: INTEGER) is
			-- Check whether `code' is a valid character code
			-- in a string and set `last_token' accordingly.
		require
			code_positive: code >= 0
		do
			if code > Maximum_string_character_code then
					-- Bad character code.
				set_start_condition (0)
				report_string_invalid_code_error (code)
			else
				token_buffer.append_character (charconv (code))
			end
		end

feature {NONE} -- Implementation

	is_verbatim_string_closer: BOOLEAN is
			-- Is `text' a valid Verbatim_string_closer?
		require
			-- valid_text: `text' matches regexp [ \t\r]*\][^\n"]*\"
		local
			i, j, nb: INTEGER
			found: BOOLEAN
		do
				-- Look for first character ].
				-- (Note that `text' matches the following
				-- regexp:   [ \t\r]*[\]\}][^\n"]*\"  .)
			from j := 0 until found loop
				j := j + 1
				inspect text_item (j)
				when ']', '}' then
					found := True
				else
				end
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

	align_left (s: STRING) is
			-- Align multiline string `s' to the left so that
			-- the same white space in front of every line is removed.
		require
			s_not_void: s /= Void
		local
			done: BOOLEAN
			c: CHARACTER
			i: INTEGER
		do
			from
				done := s.count = 0
			until
				done
			loop
				c := s.item (1)
				inspect c
				when ' ', '%T', '%V' then
						-- Check that all other lines start with `c'.
					from
						i := s.index_of ('%N', 1)
					until
						i <= 0 or else
						i >= s.count or else
						s.item (i + 1) /= c
					loop
						i := s.index_of ('%N', i + 1)
					end
					if i <= 0 then
							-- Remove leading `c'.
						s.remove (1)
						from
							i := s.index_of ('%N', 1)
						until
							i <= 0
						loop
							i := i + 1
							check
								i <= s.count
							end
							s.remove (i)
							i := s.index_of ('%N', i)
						end
						done := s.count = 0
					else
						done := true
					end
				else
					done := true
				end
			end
		end

	cloned_string (a_string: STRING): STRING is
			-- Clone of `a_string'
			-- (Reduce memory storage if possible.)
		require
			a_string_not_void: a_string /= Void
		do
			create Result.make (a_string.count)
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
			create Result.make (a_string.count)
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

invariant
	ast_factory_not_void: ast_factory /= Void
	token_buffer_not_void: token_buffer /= Void
	verbatim_marker_not_void: verbatim_marker /= Void
	filename_not_void: filename /= Void

indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EIFFEL_SCANNER_SKELETON

