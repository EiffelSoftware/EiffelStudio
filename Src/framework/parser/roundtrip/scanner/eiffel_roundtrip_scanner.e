note
	description: "Object that scans a input buffer and generate `match_list' for roundtrip"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_ROUNDTRIP_SCANNER

inherit
	EIFFEL_SCANNER
		redefine
			process_id_as,
			process_string_character_code,
			process_string_character_as_value,
			scan
		end

create
	make_with_factory

feature -- Scann

	scan_file (a_file: KL_BINARY_INPUT_FILE)
			-- Scan `a_file'.
		require
			a_file_not_void: a_file /= Void
		do
			if attached encoding_converter.input_buffer_from_file (a_file, Void) as l_input_buffer then
				input_buffer := l_input_buffer
				detected_encoding := encoding_converter.detected_encoding
				detected_bom := encoding_converter.last_bom
				yy_load_input_buffer
				filename := a_file.name
				scan
			else
				has_syntax_error := True
			end
		ensure
			match_list_set: not has_syntax_error implies match_list /= Void
		end

	scan
			-- Scan `input_buffer' until end of file is found
			-- or an error occurs.
		local
			l_as: AST_EIFFEL
			l_error_level: NATURAL_32
		do
			l_error_level := error_handler.error_level
			ast_factory.create_match_list (2000)
			from
				read_token
			until
				last_token <= 0
			loop
				read_token
				inspect
					last_token
				when TE_INTEGER then
					l_as := ast_factory.new_integer_as (Void, False, Void, text, Void, line, column, position, text_count, character_column, character_position, unicode_text_count)
				when TE_REAL then
					l_as := ast_factory.new_real_as (Void, Void, text, Void, line, column, position, text_count, character_column, character_position, unicode_text_count)
				when TE_CHAR then
					l_as := last_detachable_char_as_value
				when
					TE_STR_LT, TE_STR_GT, TE_STR_LE, TE_STR_GE, TE_STR_PLUS, TE_STR_MINUS, TE_STR_STAR,
					TE_STR_SLASH, TE_STR_POWER, TE_STR_DIV, TE_STR_MOD, TE_STR_BRACKET, TE_STR_AND,
					TE_STR_AND_THEN, TE_STR_IMPLIES, TE_STR_NOT, TE_STR_OR, TE_STR_OR_ELSE, TE_STR_XOR,
					TE_STR_FREE,
					TE_EMPTY_STRING, TE_EMPTY_VERBATIM_STRING,
					TE_STRING, TE_VERBATIM_STRING
				then
					l_as := last_detachable_string_as_value
				else
				end
			end
			if l_error_level = error_handler.error_level then
				has_syntax_error := False
				match_list := ast_factory.match_list
			else
				has_syntax_error := True
				match_list := Void
			end
		end

	scan_string (a_string: STRING)
			-- Scan `a_string'.
			-- Encoding is detected according to BOM.
			-- Otherwise defaults to ASCII.
		require
			a_string_not_void: a_string /= Void
		do
			if attached encoding_converter.input_buffer_from_string (a_string, Void) as l_input_buffer then
				input_buffer := l_input_buffer
				detected_encoding := encoding_converter.detected_encoding
				detected_bom := encoding_converter.last_bom
				yy_load_input_buffer
				scan
			else
				has_syntax_error := True
			end
		ensure
			match_list_set: not has_syntax_error implies match_list /= Void
		end

	scan_utf8_string (a_string: STRING_8)
			-- Scan `a_string' in UTF-8.
		require
			a_string_not_void: a_string /= Void
		do
			create {YY_UNICODE_BUFFER} input_buffer.make_from_utf8_string (a_string)
			detected_encoding := utf8
			detected_bom := Void
			yy_load_input_buffer
			scan
		ensure
			match_list_set: not has_syntax_error implies match_list /= Void
		end

feature -- Status reporting

	has_syntax_error: BOOLEAN
		-- Is there any error during last scanning?

feature

	process_id_as
			-- Process current token which is an identifier
		local
			l_as: detachable ID_AS
		do
			l_as := ast_factory.new_filled_id_as (Current)
		end

	process_string_character_code (code: NATURAL_32)
			-- Check whether `code' is a valid character code
			-- in a string and set `last_token' accordingly.
		do
		end

	process_string_character_as_value (str: READABLE_STRING_8)
			-- <Precursor>
		do
		end

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
