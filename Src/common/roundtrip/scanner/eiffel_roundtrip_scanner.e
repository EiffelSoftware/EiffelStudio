indexing
	description: "Object that scans a input buffer and generate `match_list' for roundtrip"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_ROUNDTRIP_SCANNER

inherit
	EIFFEL_SCANNER
		redefine
			process_id_as,
			process_character_code,
			process_string_character_code,
			scan
		end

	EIFFEL_TOKENS

	SHARED_PARSER_FILE_BUFFER
		export
			{NONE}all
		end

create
	make_with_factory

feature -- Scann

	scan_file (a_file: KI_CHARACTER_INPUT_STREAM) is
			-- Scan `a_file'.
		require
			a_file_not_void: a_file /= Void
		do
			File_buffer.set_file (a_file)
			input_buffer := File_buffer
			yy_load_input_buffer
			filename := a_file.name
			scan
		ensure
			match_list_set: not has_syntax_error implies match_list /= Void
		end

	scan_string (a_string: STRING) is
			-- Scan `a_string'.
		require
			a_string_not_void: a_string /= Void
		do
			create input_buffer.make (a_string)
			yy_load_input_buffer
			scan
		ensure
			match_list_set: not has_syntax_error implies match_list /= Void
		end

	scan is
			-- Scan `input_buffer' until end of file is found
			-- or an error occurs.
		local
			l_as: AST_EIFFEL
		do
			error_handler.wipe_out
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
						l_as := ast_factory.new_integer_as (Void, False, Void, text, Void, line, column, position, text_count)
					when TE_REAL then
						l_as := ast_factory.new_real_as (Void, Void, text, Void, line, column, position, text_count)
					when TE_CHAR then
						l_as := ast_factory.new_character_as (' ', line, column, position, text)
					when
						TE_STR_LT, TE_STR_GT, TE_STR_LE, TE_STR_GE, TE_STR_PLUS, TE_STR_MINUS, TE_STR_STAR,
						TE_STR_SLASH, TE_STR_POWER, TE_STR_DIV, TE_STR_MOD, TE_STR_BRACKET, TE_STR_AND,
 				 	    TE_STR_AND_THEN, TE_STR_IMPLIES, TE_STR_NOT, TE_STR_OR, TE_STR_OR_ELSE, TE_STR_XOR,
 				 	    TE_STR_FREE then
 				 	    l_as := ast_factory.new_string_as ("", line, column, position, text_count, text)
					when TE_EMPTY_STRING then
						l_as := ast_factory.new_string_as ("", line, column, string_position, position + text_count - string_position, token_buffer2)
					when TE_STRING then
						l_as := ast_factory.new_string_as ("", line, column, string_position, position + text_count - string_position, token_buffer2)
					when TE_EMPTY_VERBATIM_STRING then
						l_as := ast_factory.new_verbatim_string_as ("", "", False, line, column, string_position, position + text_count - string_position, token_buffer2)
					when TE_VERBATIM_STRING then
						l_as := ast_factory.new_verbatim_string_as ("", "", False, line, column, string_position, position + text_count - string_position, token_buffer2)
					else
				end
			end
			if has_syntax_error then
				match_list := Void
			else
				match_list := ast_factory.match_list
			end
		end


feature -- Status reporting

	has_syntax_error: BOOLEAN is
			-- Is there any error during last scanning?
		do
			Result := not error_handler.error_list.is_empty
		end

feature

	process_id_as is
			-- Process current token which is an identifier
		local
			l_as: ID_AS
		do
			l_as := ast_factory.new_filled_id_as (Current)
		end

	process_character_code (code: INTEGER) is
			-- Check whether `code' is a valid character code
			-- and set `last_token' accordingly.
		do
			last_token := TE_CHAR
		end

	process_string_character_code (code: INTEGER) is
			-- Check whether `code' is a valid character code
			-- in a string and set `last_token' accordingly.
		do
		end

end
