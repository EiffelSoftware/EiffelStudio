note

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
			yy_initialize, yy_load_input_buffer, reset, fatal_error
		end

	EIFFEL_TOKENS
		export
			{NONE} all
		end

	SHARED_ERROR_HANDLER
		export {NONE} all end

	COMPILER_EXPORTER
		export {NONE} all end

	REFACTORING_HELPER
		export {NONE} all end

	SHARED_ENCODING_CONVERTER
		export {NONE} all end

	SYSTEM_ENCODINGS
		export {NONE} all end

	BOM_CONSTANTS
		export {NONE} all end

	INTERNAL_COMPILER_STRING_EXPORTER

feature {NONE} -- Initialization

	make
			-- Create a new Eiffel scanner using default factory for creating AST nodes.
		do
			make_with_factory (create {AST_FACTORY})
		end

	make_with_factory (a_factory: AST_FACTORY)
			-- Create a new Eiffel scanner using `a_factory' as factory to create AST nodes.
		require
			a_factory_not_void: a_factory /= Void
		do
			ast_factory := a_factory
			make_with_buffer (Empty_buffer)
			create token_buffer.make (Initial_buffer_size)
			create roundtrip_token_buffer.make (Initial_buffer_size)
			create start_location.make_null
			create verbatim_marker.make (Initial_verbatim_marker_size)
			filename := ""
			syntax_version := obsolete_syntax
			ast_factory.set_parser (Current)
		ensure
			ast_factory_set: ast_factory = a_factory
			ast_factory_set_with_parser: ast_factory.parser = Current
		end

feature -- Initialization

	reset
			-- Reset scanner before scanning next input source.
			-- (This routine can be called in wrap before scanning
			-- another input buffer.)
		do
			Precursor
			start_location.set_position (0, 0, 0, 0, 0, 0, 0)
			token_buffer.wipe_out
			roundtrip_token_buffer.wipe_out
			verbatim_marker.wipe_out
			syntax_version := obsolete_syntax
			character_position := position
			character_column := column
			next_character_position := position
			next_character_column := column
		end

	yy_initialize
			-- <Precursor>
		do
			Precursor
			character_position := position
			character_column := column
			next_character_position := position
			next_character_column := column
		end

	yy_load_input_buffer
			-- <Precursor>
		do
			Precursor
			character_position := 1
			character_column := 1
			next_character_column := 1
			next_character_position := 1
			unicode_text_count := 0
		end

feature -- Roundtrip

	match_list: detachable LEAF_AS_LIST
			-- List of all tokens used for roundtrip

	initial_match_list_size: INTEGER = 1000
			-- Initial size of `match_list'.

	roundtrip_token_buffer: STRING
			-- Buffer for roundtrip tokens

	verbatim_common_columns: INTEGER
			-- Number of columns that the verbatim string has in common.

	last_keyword_as_id_index: INTEGER
			-- Last index in `match_list' for keywords that can be used as identifier

	last_break_as_start_line: INTEGER
			-- Start line of last BREAK_AS node

	last_break_as_start_column: INTEGER
			-- Start column of last BREAK_AS node

	last_break_as_start_position: INTEGER
			-- Start position of last BREAK_AS node

	last_break_as_character_start_column: INTEGER
			-- Start column of last BREAK_AS node

	last_break_as_character_start_position: INTEGER
			-- Start position of last BREAK_AS node

	character_column: INTEGER
			-- Unicode character column number of last token read when
			-- '%option line' has been specified

	character_position: INTEGER
			-- Unicode character position of last token read (i.e. number of
			-- characters from the start of the input source)
			-- when '%option position' has been specified

	unicode_text_count: INTEGER
			-- Number of unicode characters in last token read

	next_character_column: INTEGER
			-- Unicode character column number of last token read
			-- for next call to `update_character_locations'

	next_character_position: INTEGER
			-- Unicode character position of last token read
			-- for next call to `update_character_locations'

feature -- Access

	ast_factory: AST_FACTORY
			-- Abstract Syntax Tree factory

	current_class: detachable ABSTRACT_CLASS_C
			-- Current class being parsed.
			-- It can be Void in a parsing that does not involve compilation

	filename: READABLE_STRING_GENERAL
			-- Name of file being parsed

	last_value: detachable ANY
			-- Semantic value to be passed to the parser

	last_line_pragma: detachable BREAK_AS
			-- Last line pragma to be associated with next instruction

	start_location: LOCATION_AS
			-- Start location of a manifest string

	token_buffer: STRING
			-- Buffer for lexical tokens

	verbatim_marker: STRING
			-- Sequence of characters between " and [
			-- in Verbatim_string_opener

	has_syntax_warning: BOOLEAN
			-- Do we create SYNTAX_WARNING instances for obsolte syntactical constructs?

	is_warning_as_error: BOOLEAN
			-- Should syntax warnings be reported as errors?

	Maximum_string_character_code: NATURAL_32 = 0x10FFFF
			-- Maximum value for character code inside a string
			-- According to ISO/IEC 10646, the maximum Unicode point is 10FFFF.
			-- However ISO/IEC 10646 has stated that all future assignments of characters
			-- will also take place in range 0 - 7FFFFFFF

	Maximum_string_length: INTEGER = 0x7FFF
			-- Maximum length of tokens that require a string representation
			-- (such as Identifier, Manifest_string, Free_operator)
			-- The limit is imposed by
			--   byte-code format (string length is encoded as a short integer with maximum 0x7FFF)
			--   C compiler (e.g., CL does not support strings longer than 0xFFFF bytes)
			--   CLI specification (e.g., identifiers cannot be longer 0x1FFFFFFF bytes)

	ecma_syntax: NATURAL_8 = 0x00
			-- Syntax strictly follows the ECMA specification

	obsolete_syntax: NATURAL_8 = 0x01
			-- Allows pre-ECMA keywords and ignore new ECMA keywords such as `note', `attribute', `attached' and `detachable'

	transitional_syntax: NATURAL_8 = 0x2
			-- Allows both pre and ECMA keywords

	provisional_syntax: NATURAL_8 = 0x3
			-- ECMA syntax + possible future extensions

feature -- Access: Encoding

	detected_encoding: detachable ENCODING
			-- Encoding detected by last parsing

	detected_bom: detachable STRING
			-- Bom of the encoding detected by last parsing

feature {NONE} -- Status

	syntax_version: NATURAL_8
			-- Version of syntax used, one of the `ecma_syntax', `obsolete_syntax' and `transitional_syntax'.

feature -- Convenience

	token_line (a_node: detachable AST_EIFFEL): like line
			-- Line of `a_node' if possible, `line' otherwise.
		do
				-- Not all nodes may have a proper location, in which case, we
				-- use the parser `line'.
			if a_node /= Void and then not a_node.start_location.is_null then
				Result := a_node.start_location.line
			else
				Result := line
			end
		end

	token_column (a_node: detachable AST_EIFFEL): like column
			-- Column of `a_node' if possible, `column' otherwise.
		do
				-- Not all nodes may have a proper location, in which case, we
				-- use the parser `column'.
			if a_node /= Void and then not a_node.start_location.is_null then
				Result := a_node.start_location.column
			else
				Result := column
			end
		end

feature -- Osolete

	error_code: INTEGER = 0
	error_message: STRING = ""
			-- Compatibility with parser written in C with yacc

feature -- Settings

	set_has_syntax_warning (b: BOOLEAN)
			-- Set `has_syntax_warning' to `b'
		do
			has_syntax_warning := b
		ensure
			has_syntax_warning_set: has_syntax_warning = b
		end

	set_warning_as_error (b: BOOLEAN)
			-- Set `is_warning_as_error` to `b`.
		do
			is_warning_as_error := b
		ensure
			is_warning_as_error = b
		end

	set_syntax_version (a_version: like syntax_version)
			-- Set `syntax_version' to `a_version'.
		require
			valid_version: a_version = ecma_syntax or a_version = transitional_syntax or a_version = obsolete_syntax or a_version = provisional_syntax
		do
			syntax_version := a_version
		ensure
			syntax_version_set: syntax_version = a_version
		end

	set_filename (a_filename: like filename)
			-- Set `filename' with `a_filename'.
		require
			a_filename_not_void: a_filename /= Void
		do
			filename := a_filename
		ensure
			filename_set: filename = a_filename
		end

feature {NONE} -- Error handling

	report_one_error (a_error: ERROR)
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

	report_one_warning (a_error: ERROR)
			-- Log `a_error'.
		require
			a_error_not_void: a_error /= Void
		do
			a_error.set_associated_class (current_class)
			error_handler.insert_warning (a_error, is_warning_as_error)
		end

	fatal_error (a_message: STRING)
			-- A fatal error occurred.
			-- Log `a_message' and raise an exception.
		do
			report_one_error (create {SYNTAX_ERROR}.make (line, column, filename, a_message))
		end

	report_character_missing_quote_error (char: STRING)
			-- Invalid character: final quote missing.
		require
			char_not_void: char /= Void
		do
			report_one_error (create {BAD_CHARACTER}.make (line, column, filename, ""))

				-- Dummy code (for error recovery) follows:
			token_buffer.append_character ('a')
			last_token := TE_CHAR
		end

	report_string_bad_special_character_error
			-- Invalid special character after % in manisfest string.
		do
			report_one_error (create {STRING_EXTENSION}.make (line, column, filename, ""))

				-- Dummy code (for error recovery) follows:
			token_buffer.append_character ('a')
		end

	report_string_invalid_code_error (a_code: NATURAL_32)
			-- Invalid character code after % in manisfest string.
		do
			report_one_error (create {STRING_EXTENSION}.make (line, column, filename, ""))

				-- Dummy code (for error recovery) follows:
			token_buffer.append_character ('a')
		end

	report_string_missing_quote_error (a_string: STRING)
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

	report_missing_end_of_verbatim_string_error (a_string: STRING)
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

	report_too_long_string (a_text: STRING)
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

	report_unknown_token_error (a_token: CHARACTER)
			-- Unknown token.
		do
			report_one_error (create {SYNTAX_ERROR}.make (line, column, filename, ""))
		end

feature {AST_FACTORY} -- Error handling

	report_invalid_integer_error (a_text: STRING)
			-- Invalid integer
		do
			report_one_error (create {VIIN}.make (line, column, filename, ""))
		end

	report_invalid_type_for_real_error (a_type: TYPE_AS; a_real: READABLE_STRING_8)
			-- Error when an incorrect type `a_type' is specified for a real constant `a_real'.
		require
			a_type_not_void: a_type /= Void
			a_real_not_void: a_real /= Void
		local
			an_error: SYNTAX_ERROR
		do
			create an_error.make (line, column, filename,
				"Specified type %"" + a_type.dump +
					"%" is not a valid type for real constant %"" + a_real + "%"")
			report_one_error (an_error)
		end

	report_invalid_type_for_integer_error (a_type: TYPE_AS; an_int: READABLE_STRING_8)
			-- Error when an incorrect type `a_type' is specified for an integer constant `an_int'.
		require
			a_type_not_void: a_type /= Void
			an_int_not_void: an_int /= Void
		local
			an_error: SYNTAX_ERROR
		do
			create an_error.make (line, column, filename,
				"Specified type %"" + a_type.dump +
					"%" is not a valid type for integer constant %"" + an_int + "%"")
			report_one_error (an_error)
		end

	report_integer_too_large_error (a_type: detachable TYPE_AS; an_int: READABLE_STRING_8)
			-- `an_int', although only made up of digits, doesn't fit
			-- in an INTEGER (i.e. greater than maximum_integer_value).
		require
			an_int_not_void: an_int /= Void
		local
			l_message: STRING
		do
			fixme ("Change plain syntax error to Integer_too_large error when the corresponding validity rule is available.")
			if a_type /= Void then
				l_message := "Integer value " + an_int + " is too large for " + a_type.dump + "."
			else
				l_message := "Integer value " + an_int + " is too large for any integer type."
			end
			report_one_error (create {SYNTAX_ERROR}.make (line, column, filename, l_message))
		end

	report_integer_too_small_error (a_type: detachable TYPE_AS; an_int: READABLE_STRING_8)
			-- `an_int', although only made up of digits, doesn't fit
			-- in an INTEGER (i.e. less than minimum_integer_value).
		require
			an_int_not_void: an_int /= Void
		local
			l_message: STRING
		do
			fixme ("Change plain syntax error to Integer_too_small error when the corresponding validity rule is available.")
			if a_type /= Void then
				l_message := "Integer value " + an_int + " is too small for " + a_type.dump + "."
			else
				l_message := "Integer value " + an_int + " is too small for any integer type."
			end
			report_one_error (create {SYNTAX_ERROR}.make (line, column, filename, l_message))
		end

	report_character_code_too_large_error (a_code: READABLE_STRING_8)
			-- Integer encoded by `a_code' is too large to fit into a CHARACTER_32
		require
			a_code_not_void: a_code /= Void
		do
			report_one_error (create {BAD_CHARACTER}.make (line, column, filename,
				"Character code " + a_code + " is too large for CHARACTER_32."))
		end

feature {NONE} -- Implementation

	process_id_as
			-- Process current token which is an identifier
		local
			l_count: INTEGER
		do
			l_count := text_count
				-- Note: Identifiers are converted to lower-case.
			if l_count > maximum_string_length then
				report_too_long_string (utf8_text)
			else
				last_detachable_id_as_value := ast_factory.new_filled_id_as (Current)
			end
		end

	process_id_as_with_existing_stub (keyword: KEYWORD_AS; a_index: INTEGER; is_lower: BOOLEAN)
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
				report_too_long_string (utf8_text)
			else
				last_detachable_id_as_value := ast_factory.new_filled_id_as_with_existing_stub (Current, a_index)
				if has_syntax_warning then
					if attached last_detachable_id_as_value as l_value and then attached l_value.name as l_name then
						message := once "Keyword `" + l_name
						message.append_string ("' is used as identifier.")
					else
						message := once "Keyword is used as identifier."
					end
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (keyword), token_column (keyword),
							filename, message))
				end
				if attached last_detachable_id_as_value as l_value then
					if is_lower then
						l_value.to_lower
					else
						l_value.to_upper
					end
				end
			end
		end

	process_string_character_as_value (str: READABLE_STRING_8)
			-- Check whether `str' is a valid character value
			-- in a string and set `last_token' accordingly.
		require
			not_empty: str.count >= 0
		do
			if
				attached ast_factory.new_temporary_integer_value (Current, '+', str) as i
			then
				if i.natural_64_value <= {NATURAL_32}.Max_value then
					process_string_character_code (i.natural_32_value)
				else
					report_character_code_too_large_error (str)
				end
			else
				check unsupported: False end
				report_string_bad_special_character_error
			end
		end

	process_string_character_code (code: NATURAL_32)
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
				encoding_converter.append_code_point_to_utf8 (code, token_buffer)
			end
		end

	process_simple_string_as (a_token: INTEGER)
			-- Set `last_string_as_value' accordingly to the current scanner input of a manifest string and set `last_token' with `a_token'
		local
			l_str: detachable STRING
			n: INTEGER
		do
			n := text_count

				-- We remove the double quotes and initializes it with scanned input.
			l_str := ast_factory.new_string (n - 2)
			if l_str /= Void then
				append_utf8_text_substring_to_string (2, n - 1, l_str)
			end

				-- `roundtrip_token_buffer' is used for the getting the actual input
				-- (useful for roundtrip parsing)
			ast_factory.set_buffer (roundtrip_token_buffer, Current)

				-- `l_str' being a new object, it is just fine to pass it as is.
				-- `roundtrip_token_buffer' is not a new object but redefinitions of `new_string_as'
				-- take care of duplicating it when necessary.
			last_detachable_string_as_value := ast_factory.new_string_as (l_str, line, column, position, n, character_column, character_position, unicode_text_count, roundtrip_token_buffer)
			last_token := a_token

				-- Check if manifest string is not too long (excluding the double quotes).
			if (n - 2) > maximum_string_length then
					-- If `l_str' is Void, we need to actually create it for error purpose even if it was
					-- not needed by the factory.
				if l_str = Void then
					create l_str.make (n - 2)
					append_utf8_text_substring_to_string (2, n - 1, l_str)
				end
				report_too_long_string (l_str)
			end
		ensure
			last_token_set: last_token = a_token or else last_token = yyEOF_token
					-- `last_token' is set to `yyEOF_token' on error (when string is too long)
		end

feature {NONE} -- Implementation

	is_verbatim_string_closer: BOOLEAN
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
			if nb = text_count - j then
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

	align_left (s: STRING)
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
				verbatim_common_columns := 0
				done := s.is_empty
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
						verbatim_common_columns := verbatim_common_columns + 1
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
						done := s.is_empty
					else
						done := True
					end
				else
					done := True
				end
			end
		end

	cloned_string (a_string: STRING): STRING
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

	cloned_lower_string (a_string: STRING): STRING
			-- Clone of `a_string'; convert characters to lower case
			-- (Reduce memory storage if possible.)
		obsolete "Avoid using this feature because it is not Unicode-friendly."
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

	char_32_from_source (a_str: STRING): CHARACTER_32
			-- Convert UTF-8 stream to UTF-32 character.
		require
			a_str_not_void: a_str /= Void
			a_str_valid: encoding_converter.utf8_to_utf32 (a_str).count <= 1
		do
			if not a_str.is_empty then
				Result := encoding_converter.read_character_from_utf8 (1, Void, a_str)
			end
		end

	create_break_as_with_saved_data
			-- Create break as with saved data
		local
			u: UTF_CONVERTER
			l_buf: like roundtrip_token_buffer
		do
			l_buf := roundtrip_token_buffer
			ast_factory.create_break_as_with_data (l_buf,
				last_break_as_start_line,
				last_break_as_start_column,
				last_break_as_start_position,
				roundtrip_token_buffer.count,
				last_break_as_character_start_column,
				last_break_as_character_start_position,
				u.utf_8_to_string_32_count (l_buf.area, 0, l_buf.count - 1))
		end

	save_break_as_data
			-- Save break as data
		do
			last_break_as_start_position := position
			last_break_as_start_line := line
			last_break_as_start_column := column
			last_break_as_character_start_column := character_column
			last_break_as_character_start_position := character_position
		end

	update_character_locations
			-- Update character locations for later use.
		do
			if yyline_used and attached yy_unicode_content_area as l_content_area then
				update_character_position_from_buffer (l_content_area, yy_start, yy_end - 1)
			end
		end

	update_character_position_from_buffer (s: SPECIAL [CHARACTER_32]; start_pos, end_pos: INTEGER)
			-- Count of characters corresponding to UTF-8 sequence `s'.
			-- Compute column number in character.
		require
			start_position_big_enough: start_pos >= 0
			end_position_big_enough: start_pos <= end_pos + 1
			end_pos_small_enough: end_pos < s.count
		local
			i: INTEGER
			n: INTEGER
			c: INTEGER
			cc: like character_column
			cp: like character_position
		do
			from
				i := start_pos
				n := end_pos
				cc := next_character_column
				cp := next_character_position
				character_column := cc
				character_position := cp
			until
				i > n
			loop
				c := s [i].code
				i := i + 1
				cp := cp + 1
				cc :=
					if c = 0xA then -- New line
						1
					else
						cc + 1
					end
			end
			next_character_column := cc
			next_character_position := cp
			unicode_text_count := next_character_position - character_position
		end

	last_counted_character_column: INTEGER
			-- Last counted character column

feature {NONE} -- Constants

	Initial_buffer_size: INTEGER = 5120
			-- Initial size for `token_buffer'
			-- (See `eif_rtlimits.h')

	Initial_verbatim_marker_size: INTEGER = 3
			-- Initial size for `verbatim_marker'

invariant
	ast_factory_not_void: ast_factory /= Void
	token_buffer_not_void: token_buffer /= Void
	verbatim_marker_not_void: verbatim_marker /= Void
	filename_not_void: filename /= Void

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
