note

	description:

		"Scanners for Eiffel parsers"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 1999-2014, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class ET_EIFFEL_SCANNER

inherit

	ET_EIFFEL_SCANNER_SKELETON
		redefine
			read_token
		end

create

	make

feature -- Status report

	valid_start_condition (sc: INTEGER): BOOLEAN
			-- Is `sc' a valid start condition?
		do
			Result := (INITIAL <= sc and sc <= LAVS3)
		end

feature {NONE} -- Implementation

	yy_build_tables
			-- Build scanner tables.
		do
			yy_nxt := yy_nxt_template
			yy_chk := yy_chk_template
			yy_base := yy_base_template
			yy_def := yy_def_template
			yy_ec := yy_ec_template
			yy_meta := yy_meta_template
			yy_accept := yy_accept_template
			yy_acclist := yy_acclist_template
		end

	yy_execute_action (yy_act: INTEGER)
			-- Execute semantic action.
		do
			inspect yy_act
when 1 then
	yy_column := yy_column + 3
--|#line 39 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 39")
end

				-- Ignore byte order mark (BOM).
				-- See http://en.wikipedia.org/wiki/Byte_order_mark
			
when 2 then
	yy_column := yy_column + 1
--|#line 47 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 47")
end

				last_break_end := 0
				last_comment_end := 0
				process_one_char_symbol (text_item (1))
			
when 3 then
yy_set_line_column
--|#line 52 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 52")
end

				last_text_count := 1
				last_break_end := text_count
				last_comment_end := 0
				process_one_char_symbol (text_item (1))
			
when 4 then
yy_set_line_column
--|#line 58 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 58")
end

				last_text_count := 1
				last_break_end := 0
				last_comment_end := text_count
				process_one_char_symbol (text_item (1))
			
when 5 then
yy_set_line_column
--|#line 64 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 64")
end

				last_text_count := 1
				last_break_end := 0
				last_comment_end := text_count
				process_one_char_symbol ('-')
			
when 6 then
	yy_column := yy_column + 2
--|#line 70 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 70")
end

				last_break_end := 0
				last_comment_end := 0
				process_two_char_symbol (text_item (1), text_item (2))
			
when 7 then
yy_set_line_column
--|#line 75 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 75")
end

				last_text_count := 2
				last_break_end := text_count
				last_comment_end := 0
				process_two_char_symbol (text_item (1), text_item (2))
			
when 8 then
yy_set_line_column
--|#line 81 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 81")
end

				last_text_count := 2
				last_break_end := 0
				last_comment_end := text_count
				process_two_char_symbol (text_item (1), text_item (2))
			
when 9 then
	yy_end := yy_end - 1
	yy_column := yy_column + 4
--|#line 121 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 121")
end

				last_token := E_ONCE_STRING
				last_literal_start := 1
				last_literal_end := 4
				last_break_end := 0
				last_comment_end := 0
				last_detachable_et_keyword_value := ast_factory.new_once_keyword (Current)
			
when 10 then
	yy_end := yy_end - 1
yy_set_line_column
--|#line 129 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 129")
end

				last_token := E_ONCE_STRING
				last_literal_start := 1
				last_literal_end := 4
				last_text_count := 4
				last_break_end := text_count
				last_comment_end := 0
				last_detachable_et_keyword_value := ast_factory.new_once_keyword (Current)
			
when 11 then
	yy_end := yy_end - 1
yy_set_line_column
--|#line 138 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 138")
end

				last_token := E_ONCE_STRING
				last_literal_start := 1
				last_literal_end := 4
				last_text_count := 4
				last_break_end := 0
				last_comment_end := text_count
				last_detachable_et_keyword_value := ast_factory.new_once_keyword (Current)
			
when 12 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 151 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 151")
end

				last_break_end := 0
				last_comment_end := 0
				process_identifier (text_count)
			
when 13 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 156 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 156")
end

				last_text_count := text_count
				break_kind := identifier_break
				more
				set_start_condition (BREAK)
			
when 14 then
	yy_column := yy_column + 1
--|#line 171 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 171")
end

				last_token := E_FREEOP
				last_literal_start := 1
				last_literal_end := text_count
				last_break_end := 0
				last_comment_end := 0
				last_detachable_et_free_operator_value := ast_factory.new_free_operator (Current)
			
when 15 then
	yy_column := yy_column + 2
--|#line 172 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 172")
end

				last_token := E_FREEOP
				last_literal_start := 1
				last_literal_end := text_count
				last_break_end := 0
				last_comment_end := 0
				last_detachable_et_free_operator_value := ast_factory.new_free_operator (Current)
			
when 16 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 173 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 173")
end

				last_token := E_FREEOP
				last_literal_start := 1
				last_literal_end := text_count
				last_break_end := 0
				last_comment_end := 0
				last_detachable_et_free_operator_value := ast_factory.new_free_operator (Current)
			
when 17 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 174 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 174")
end

				last_token := E_FREEOP
				last_literal_start := 1
				last_literal_end := text_count
				last_break_end := 0
				last_comment_end := 0
				last_detachable_et_free_operator_value := ast_factory.new_free_operator (Current)
			
when 18 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 175 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 175")
end

				last_token := E_FREEOP
				last_literal_start := 1
				last_literal_end := text_count
				last_break_end := 0
				last_comment_end := 0
				last_detachable_et_free_operator_value := ast_factory.new_free_operator (Current)
			
when 19 then
	yy_end := yy_end - 1
	yy_column := yy_column + 1
--|#line 185 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 185")
end

				last_text_count := text_count
				last_literal_start := 1
				last_literal_end := last_text_count
				break_kind := freeop_break
				more
				set_start_condition (BREAK)
			
when 20 then
	yy_end := yy_end - 1
	yy_column := yy_column + 2
--|#line 186 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 186")
end

				last_text_count := text_count
				last_literal_start := 1
				last_literal_end := last_text_count
				break_kind := freeop_break
				more
				set_start_condition (BREAK)
			
when 21 then
	yy_end := yy_end - 1
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 187 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 187")
end

				last_text_count := text_count
				last_literal_start := 1
				last_literal_end := last_text_count
				break_kind := freeop_break
				more
				set_start_condition (BREAK)
			
when 22 then
	yy_end := yy_end - 1
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 188 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 188")
end

				last_text_count := text_count
				last_literal_start := 1
				last_literal_end := last_text_count
				break_kind := freeop_break
				more
				set_start_condition (BREAK)
			
when 23 then
	yy_end := yy_end - 1
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 189 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 189")
end

				last_text_count := text_count
				last_literal_start := 1
				last_literal_end := last_text_count
				break_kind := freeop_break
				more
				set_start_condition (BREAK)
			
when 24 then
	yy_column := yy_column + 3
--|#line 201 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 201")
end

				last_break_end := 0
				last_comment_end := 0
				process_c1_character_constant (text_item (2))
			
when 25 then
yy_set_line_column
--|#line 206 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 206")
end

				last_text_count := 3
				last_break_end := text_count
				last_comment_end := 0
				process_c1_character_constant (text_item (2))
			
when 26 then
yy_set_line_column
--|#line 212 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 212")
end

				last_text_count := 3
				last_break_end := 0
				last_comment_end := text_count
				process_c1_character_constant (text_item (2))
			
when 27 then
	yy_column := yy_column + 4
--|#line 218 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 218")
end

				last_break_end := 0
				last_comment_end := 0
				process_c2_character_constant (text_item (3))
			
when 28 then
yy_set_line_column
--|#line 223 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 223")
end

				last_text_count := 4
				last_break_end := text_count
				last_comment_end := 0
				process_c2_character_constant (text_item (3))
			
when 29 then
yy_set_line_column
--|#line 229 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 229")
end

				last_text_count := 4
				last_break_end := 0
				last_comment_end := text_count
				process_c2_character_constant (text_item (3))
			
when 30 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 236 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 236")
end

				last_token := E_CHARACTER
				last_literal_start := 4
				last_literal_end := text_count - 2
				last_break_end := 0
				last_comment_end := 0
				last_detachable_et_character_constant_value := ast_factory.new_c3_character_constant (Current)
			
when 31 then
	yy_end := yy_end - 1
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 244 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 244")
end

				last_text_count := text_count
				last_literal_start := 4
				last_literal_end := last_text_count - 2
				break_kind := character_break
				more
				set_start_condition (BREAK)
			
when 32 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 253 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 253")
end

					-- Syntax error: invalid character code (too big)
					-- in special character specification %/code/.
				column := column + text_count
				set_syntax_error
				error_handler.report_SCAO_error (filename, current_position)
				last_detachable_et_position_value := current_position
				column := column - text_count
				last_token := E_CHARERR
			
when 33 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 263 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 263")
end

					-- Syntax error: missing character / at end
					-- of special character specification %/code/.
				column := column + text_count
				set_syntax_error
				error_handler.report_SCAS_error (filename, current_position)
				last_detachable_et_position_value := current_position
				column := column - text_count
				last_token := E_CHARERR
			
when 34 then
	yy_column := yy_column + 3
--|#line 273 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 273")
end

					-- Syntax error: missing ASCII code in
					-- special character specification %/code/.
				column := column + 3
				set_syntax_error
				error_handler.report_SCAC_error (filename, current_position)
				last_detachable_et_position_value := current_position
				column := column - 3
				last_token := E_CHARERR
			
when 35 then
	yy_column := yy_column + 2
--|#line 283 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 283")
end

					-- Syntax error: missing character between quotes.
				column := column + 1
				set_syntax_error
				error_handler.report_SCQQ_error (filename, current_position)
				last_detachable_et_position_value := current_position
				column := column - 1
				last_token := E_CHARERR
			
when 36 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 292 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 292")
end

					-- Syntax error: missing quote at
					-- end of character constant.
				column := column + text_count
				set_syntax_error
				error_handler.report_SCEQ_error (filename, current_position)
				last_detachable_et_position_value := current_position
				column := column - text_count
				last_token := E_CHARERR
			
when 37 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 306 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 306")
end

				last_token := E_STRFREEOP
				last_literal_start := 2
				last_literal_end := text_count - 1
				last_break_end := 0
				last_comment_end := 0
				last_detachable_et_manifest_string_value := ast_factory.new_regular_manifest_string (Current)
			
when 38 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 314 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 314")
end

				last_text_count := text_count
				last_literal_start := 2
				last_literal_end := last_text_count - 1
				break_kind := str_freeop_break
				more
				set_start_condition (BREAK)
			
when 39 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 323 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 323")
end

					-- Regular manifest string.
				last_break_end := 0
				last_comment_end := 0
				process_regular_manifest_string (text_count)
			
when 40 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 329 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 329")
end

					-- Regular manifest string.
				last_text_count := text_count
				break_kind := string_break
				more
				set_start_condition (BREAK)
			
when 41 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 337 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 337")
end

					-- Verbatim string.
				verbatim_marker := text_substring (2, text_count - 1)
				set_start_condition (VS1)
			
when 42 then
	yy_line := yy_line + 1
	yy_column := 1
--|#line 345 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 345")
end

				verbatim_open_white_characters := text
				last_literal_start := 1
				last_literal_end := 0
				set_start_condition (VS2)
			
when 43 then
	yy_column := yy_column + 1
--|#line 351 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 351")
end

					-- No final brace-double-quote.
				last_token := E_STRERR
				last_detachable_et_position_value := current_position
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
when 44 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 369 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 369")
end

				if is_verbatim_string_closer (last_literal_end + 1, text_count - 1) then
					last_token := E_STRING
					last_break_end := 0
					last_comment_end := 0
					last_detachable_et_manifest_string_value := ast_factory.new_verbatim_string (verbatim_marker, verbatim_open_white_characters,
						text_substring (last_literal_end + 1, text_count - verbatim_marker.count - 2), False, Current)
					verbatim_marker := no_verbatim_marker
					verbatim_open_white_characters := no_verbatim_marker
					set_start_condition (INITIAL)
				else
					more
					set_start_condition (VS3)
				end
			
when 45 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 384 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 384")
end

				if is_verbatim_string_closer (last_literal_end + 1, text_count - 1) then
					verbatim_close_white_characters := text_substring (last_literal_end + 1, text_count - verbatim_marker.count - 2)
					last_text_count := text_count
					break_kind := str_verbatim_break
					more
					set_start_condition (BREAK)
				else
					more
					set_start_condition (VS3)
				end
			
when 46 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 396 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 396")
end

				more
				set_start_condition (VS3)
			
when 47 then
	yy_line := yy_line + 1
	yy_column := 1
--|#line 400 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 400")
end

				more
				last_literal_end := text_count - 2
			
when 48 then
	yy_line := yy_line + 1
	yy_column := 1
--|#line 404 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 404")
end

				more
				last_literal_end := text_count - 1
			
when 49 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 408 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 408")
end

					-- No final brace-double-quote.
				last_token := E_STRERR
				last_detachable_et_position_value := current_position
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
when 50 then
	yy_line := yy_line + 1
	yy_column := 1
--|#line 426 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 426")
end

				more
				last_literal_end := text_count - 2
				set_start_condition (VS2)
			
when 51 then
	yy_line := yy_line + 1
	yy_column := 1
--|#line 431 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 431")
end

				more
				last_literal_end := text_count - 1
				set_start_condition (VS2)
			
when 52 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 436 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 436")
end

					-- No final brace-double-quote.
				last_token := E_STRERR
				last_detachable_et_position_value := current_position
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
when 53 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 452 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 452")
end

					-- Left-aligned verbatim string.
				verbatim_marker := text_substring (2, text_count - 1)
				set_start_condition (LAVS1)
			
when 54 then
	yy_line := yy_line + 1
	yy_column := 1
--|#line 460 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 460")
end

				verbatim_open_white_characters := text
				last_literal_start := 1
				last_literal_end := 0
				set_start_condition (LAVS2)
			
when 55 then
	yy_column := yy_column + 1
--|#line 466 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 466")
end

					-- No final bracket-double-quote.
				last_token := E_STRERR
				last_detachable_et_position_value := current_position
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
when 56 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 484 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 484")
end

				if is_verbatim_string_closer (last_literal_end + 1, text_count - 1) then
					last_token := E_STRING
					last_break_end := 0
					last_comment_end := 0
					last_detachable_et_manifest_string_value := ast_factory.new_verbatim_string (verbatim_marker, verbatim_open_white_characters,
						text_substring (last_literal_end + 1, text_count - verbatim_marker.count - 2), True, Current)
					verbatim_marker := no_verbatim_marker
					verbatim_open_white_characters := no_verbatim_marker
					set_start_condition (INITIAL)
				else
					more
					set_start_condition (LAVS3)
				end
			
when 57 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 499 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 499")
end

				if is_verbatim_string_closer (last_literal_end + 1, text_count - 1) then
					verbatim_close_white_characters := text_substring (last_literal_end + 1, text_count - verbatim_marker.count - 2)
					last_text_count := text_count
					break_kind := str_left_aligned_verbatim_break
					more
					set_start_condition (BREAK)
				else
					more
					set_start_condition (LAVS3)
				end
			
when 58 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 511 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 511")
end

				more
				set_start_condition (LAVS3)
			
when 59 then
	yy_line := yy_line + 1
	yy_column := 1
--|#line 515 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 515")
end

				more
				last_literal_end := text_count - 2
			
when 60 then
	yy_line := yy_line + 1
	yy_column := 1
--|#line 519 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 519")
end

				more
				last_literal_end := text_count - 1
			
when 61 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 523 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 523")
end

					-- No final bracket-double-quote.
				last_token := E_STRERR
				last_detachable_et_position_value := current_position
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
when 62 then
	yy_line := yy_line + 1
	yy_column := 1
--|#line 541 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 541")
end

				more
				last_literal_end := text_count - 2
				set_start_condition (LAVS2)
			
when 63 then
	yy_line := yy_line + 1
	yy_column := 1
--|#line 546 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 546")
end

				more
				last_literal_end := text_count - 1
				set_start_condition (LAVS2)
			
when 64 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 551 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 551")
end

					-- No final bracket-double-quote.
				last_token := E_STRERR
				last_detachable_et_position_value := current_position
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
when 65 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 567 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 567")
end

					-- Manifest string with special characters.
				last_token := E_STRING
				last_literal_start := 2
				last_literal_end := text_count - 1
				last_break_end := 0
				last_comment_end := 0
				last_detachable_et_manifest_string_value := ast_factory.new_special_manifest_string (Current)
			
when 66 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 576 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 576")
end

					-- Manifest string with special characters.
				last_text_count := text_count
				last_literal_start := 2
				last_literal_end := last_text_count - 1
				break_kind := str_special_break
				more
				set_start_condition (BREAK)
			
when 67 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 585 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 585")
end

					-- Manifest string with special characters which may be made
					-- up of several lines or may include invalid characters.
					-- Keep track of current line and column.
				ms_line := line
				ms_column := column
				more
				set_start_condition (MS)
			
when 68 then
	yy_line := yy_line + 1
	yy_column := 1
--|#line 596 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 596")
end

					-- Multi-line manifest string.
				more
				set_start_condition (MSN)
			
when 69 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 601 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 601")
end

				more
			
when 70 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 604 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 604")
end

					-- Syntax error: invalid character code (too big) in special
					-- character specification %/code/ in manifest string.
				column := yy_column
				line := yy_line
				set_syntax_error
				error_handler.report_SSAO_error (filename, current_position)
				last_detachable_et_position_value := current_position
				column := ms_column
				line := ms_line
				last_token := E_STRERR
				set_start_condition (INITIAL)
			
when 71 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 617 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 617")
end

					-- Syntax error: missing character / at end of special
					-- character specification %/code/ in manifest string.
				column := yy_column
				line := yy_line
				set_syntax_error
				error_handler.report_SSAS_error (filename, current_position)
				last_detachable_et_position_value := current_position
				column := ms_column
				line := ms_line
				last_token := E_STRERR
				set_start_condition (INITIAL)
			
when 72 then
	yy_column := yy_column + 2
--|#line 630 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 630")
end

					-- Syntax error: missing ASCII code in special character
					-- specification %/code/ in manifest string.
				column := yy_column
				line := yy_line
				set_syntax_error
				error_handler.report_SSAC_error (filename, current_position)
				last_detachable_et_position_value := current_position
				column := ms_column
				line := ms_line
				last_token := E_STRERR
				set_start_condition (INITIAL)
			
when 73 then
	yy_column := yy_column + 2
--|#line 643 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 643")
end

					-- Syntax error: special character specification
					-- %l where l is a letter code should be in
					-- upper-case in manifest strings.
				column := yy_column - 1
				line := yy_line
				set_syntax_error
				error_handler.report_SSCU_error (filename, current_position)
				column := ms_column
				line := ms_line
				more
			
when 74 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 655 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 655")
end

				more
			
when 75 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 658 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 658")
end

				last_token := E_STRING
				last_literal_start := 2
				last_literal_end := text_count - 1
				last_break_end := 0
				last_comment_end := 0
				last_detachable_et_manifest_string_value := ast_factory.new_special_manifest_string (Current)
				set_start_condition (INITIAL)
			
when 76 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 667 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 667")
end

				last_text_count := text_count
				last_literal_start := 2
				last_literal_end := last_text_count - 1
				break_kind := str_special_break
				more
				set_start_condition (BREAK)
			
when 77 then
	yy_column := yy_column + 2
--|#line 675 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 675")
end

					-- Syntax error: Invalid special character
					-- in manifest strings.
				column := yy_column - 1
				line := yy_line
				set_syntax_error
				error_handler.report_SSSC_error (filename, current_position)
				column := ms_column
				line := ms_line
				more
			
when 78 then
	yy_column := yy_column + 1
--|#line 686 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 686")
end

					-- Syntax error: invalid special character
					-- %l in manifest strings.
				column := yy_column
				line := yy_line
				set_syntax_error
				error_handler.report_SSSC_error (filename, current_position)
				last_detachable_et_position_value := current_position
				column := ms_column
				line := ms_line
				last_token := E_STRERR
				set_start_condition (INITIAL)
			
when 79 then
	yy_line := yy_line + 1
	yy_column := 1
--|#line 699 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 699")
end

					-- Syntax error: Invalid new-line in manifest string.
				column := 1
				line := yy_line
				set_syntax_error
				error_handler.report_SSNL_error (filename, current_position)
				last_detachable_et_position_value := current_position
				column := ms_column
				line := ms_line
				last_token := E_STRERR
				set_start_condition (INITIAL)
			
when 80 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 727 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 727")
end

				more
				set_start_condition (MS)
			
when 81 then
	yy_line := yy_line + 1
	yy_column := 1
--|#line 731 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 731")
end

					-- Syntax error: empty line in middle of
					-- multi-line manifest string.
				column := 1
				line := yy_line - 1
				set_syntax_error
				error_handler.report_SSEL_error (filename, current_position)
				column := ms_column
				line := ms_line
				more
			
when 82 then
	yy_column := yy_column + 1
--|#line 742 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 742")
end

					-- Syntax error: missing character % at beginning
					-- of line in multi-line manifest string.
				column := yy_column - 1
				line := yy_line
				set_syntax_error
				error_handler.report_SSNP_error (filename, current_position)
				last_detachable_et_position_value := current_position
				column := ms_column
				line := ms_line
				last_token := E_STRERR
				set_start_condition (INITIAL)
			
when 83 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 773 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 773")
end

				last_token := E_BIT
				last_literal_start := 1
				last_literal_end := text_count
				last_break_end := 0
				last_comment_end := 0
				last_detachable_et_bit_constant_value := ast_factory.new_bit_constant (Current)
			
when 84 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 781 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 781")
end

				last_text_count := text_count
				last_literal_start := 1
				last_literal_end := last_text_count
				break_kind := bit_break
				more
				set_start_condition (BREAK)
			
when 85 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 793 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 793")
end

				last_token := E_INTEGER
				last_literal_start := 1
				last_literal_end := text_count
				last_break_end := 0
				last_comment_end := 0
				last_detachable_et_integer_constant_value := ast_factory.new_regular_integer_constant (Current)
			
when 86 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 801 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 801")
end

				last_text_count := text_count
				last_literal_start := 1
				last_literal_end := last_text_count
				break_kind := integer_break
				more
				set_start_condition (BREAK)
			
when 87 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 809 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 809")
end

				last_token := E_INTEGER
				last_literal_start := 1
				last_literal_end := text_count
				last_break_end := 0
				last_comment_end := 0
				last_detachable_et_integer_constant_value := ast_factory.new_underscored_integer_constant (Current)
			
when 88 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 817 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 817")
end

				last_text_count := text_count
				last_literal_start := 1
				last_literal_end := last_text_count
				break_kind := uinteger_break
				more
				set_start_condition (BREAK)
			
when 89 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 825 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 825")
end

					-- Syntax error: an underscore may not be
					-- the first character of an integer.
				set_syntax_error
				error_handler.report_SIFU_error (filename, current_position)
				last_token := E_INTEGER
				last_literal_start := 1
				last_literal_end := text_count
				last_break_end := 0
				last_comment_end := 0
				last_detachable_et_integer_constant_value := ast_factory.new_underscored_integer_constant (Current)
			
when 90 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 837 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 837")
end

					-- Syntax error: an underscore may not be
					-- the first character of an integer.
				set_syntax_error
				error_handler.report_SIFU_error (filename, current_position)
				last_text_count := text_count
				last_literal_start := 1
				last_literal_end := last_text_count
				break_kind := uinteger_break
				more
				set_start_condition (BREAK)
			
when 91 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 849 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 849")
end

					-- Syntax error: an underscore may not be
					-- the last character of an integer.
				set_syntax_error
				error_handler.report_SILU_error (filename, current_position)
				last_token := E_INTEGER
				last_literal_start := 1
				last_literal_end := text_count
				last_break_end := 0
				last_comment_end := 0
				last_detachable_et_integer_constant_value := ast_factory.new_underscored_integer_constant (Current)
			
when 92 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 861 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 861")
end

					-- Syntax error: an underscore may not be
					-- the last character of an integer.
				set_syntax_error
				error_handler.report_SILU_error (filename, current_position)
				last_text_count := text_count
				last_literal_start := 1
				last_literal_end := last_text_count
				break_kind := uinteger_break
				more
				set_start_condition (BREAK)
			
when 93 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 873 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 873")
end

				last_token := E_INTEGER
				last_literal_start := 1
				last_literal_end := text_count
				last_break_end := 0
				last_comment_end := 0
				last_detachable_et_integer_constant_value := ast_factory.new_hexadecimal_integer_constant (Current)
			
when 94 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 881 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 881")
end

				last_text_count := text_count
				last_literal_start := 1
				last_literal_end := last_text_count
				break_kind := hinteger_break
				more
				set_start_condition (BREAK)
			
when 95 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 889 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 889")
end

					-- Syntax error: an underscore may not be
					-- the first character of an integer.
				set_syntax_error
				error_handler.report_SIFU_error (filename, current_position)
				last_token := E_INTEGER
				last_literal_start := 1
				last_literal_end := text_count
				last_break_end := 0
				last_comment_end := 0
				last_detachable_et_integer_constant_value := ast_factory.new_hexadecimal_integer_constant (Current)
			
when 96 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 901 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 901")
end

					-- Syntax error: an underscore may not be
					-- the first character of an integer.
				set_syntax_error
				error_handler.report_SIFU_error (filename, current_position)
				last_text_count := text_count
				last_literal_start := 1
				last_literal_end := last_text_count
				break_kind := hinteger_break
				more
				set_start_condition (BREAK)
			
when 97 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 913 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 913")
end

					-- Syntax error: an underscore may not be
					-- the last character of an integer.
				set_syntax_error
				error_handler.report_SILU_error (filename, current_position)
				last_token := E_INTEGER
				last_literal_start := 1
				last_literal_end := text_count
				last_break_end := 0
				last_comment_end := 0
				last_detachable_et_integer_constant_value := ast_factory.new_hexadecimal_integer_constant (Current)
			
when 98 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 925 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 925")
end

					-- Syntax error: an underscore may not be
					-- the last character of an integer.
				set_syntax_error
				error_handler.report_SILU_error (filename, current_position)
				last_text_count := text_count
				last_literal_start := 1
				last_literal_end := last_text_count
				break_kind := hinteger_break
				more
				set_start_condition (BREAK)
			
when 99 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 937 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 937")
end

				last_token := E_INTEGER
				last_literal_start := 1
				last_literal_end := text_count
				last_break_end := 0
				last_comment_end := 0
				last_detachable_et_integer_constant_value := ast_factory.new_octal_integer_constant (Current)
			
when 100 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 945 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 945")
end

				last_text_count := text_count
				last_literal_start := 1
				last_literal_end := last_text_count
				break_kind := ointeger_break
				more
				set_start_condition (BREAK)
			
when 101 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 953 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 953")
end

					-- Syntax error: an underscore may not be
					-- the first character of an integer.
				set_syntax_error
				error_handler.report_SIFU_error (filename, current_position)
				last_token := E_INTEGER
				last_literal_start := 1
				last_literal_end := text_count
				last_break_end := 0
				last_comment_end := 0
				last_detachable_et_integer_constant_value := ast_factory.new_octal_integer_constant (Current)
			
when 102 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 965 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 965")
end

					-- Syntax error: an underscore may not be
					-- the first character of an integer.
				set_syntax_error
				error_handler.report_SIFU_error (filename, current_position)
				last_text_count := text_count
				last_literal_start := 1
				last_literal_end := last_text_count
				break_kind := ointeger_break
				more
				set_start_condition (BREAK)
			
when 103 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 977 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 977")
end

					-- Syntax error: an underscore may not be
					-- the last character of an integer.
				set_syntax_error
				error_handler.report_SILU_error (filename, current_position)
				last_token := E_INTEGER
				last_literal_start := 1
				last_literal_end := text_count
				last_break_end := 0
				last_comment_end := 0
				last_detachable_et_integer_constant_value := ast_factory.new_octal_integer_constant (Current)
			
when 104 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 989 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 989")
end

					-- Syntax error: an underscore may not be
					-- the last character of an integer.
				set_syntax_error
				error_handler.report_SILU_error (filename, current_position)
				last_text_count := text_count
				last_literal_start := 1
				last_literal_end := last_text_count
				break_kind := ointeger_break
				more
				set_start_condition (BREAK)
			
when 105 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 1001 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1001")
end

				last_token := E_INTEGER
				last_literal_start := 1
				last_literal_end := text_count
				last_break_end := 0
				last_comment_end := 0
				last_detachable_et_integer_constant_value := ast_factory.new_binary_integer_constant (Current)
			
when 106 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 1009 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1009")
end

				last_text_count := text_count
				last_literal_start := 1
				last_literal_end := last_text_count
				break_kind := binteger_break
				more
				set_start_condition (BREAK)
			
when 107 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 1017 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1017")
end

					-- Syntax error: an underscore may not be
					-- the first character of an integer.
				set_syntax_error
				error_handler.report_SIFU_error (filename, current_position)
				last_token := E_INTEGER
				last_literal_start := 1
				last_literal_end := text_count
				last_break_end := 0
				last_comment_end := 0
				last_detachable_et_integer_constant_value := ast_factory.new_binary_integer_constant (Current)
			
when 108 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 1029 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1029")
end

					-- Syntax error: an underscore may not be
					-- the first character of an integer.
				set_syntax_error
				error_handler.report_SIFU_error (filename, current_position)
				last_text_count := text_count
				last_literal_start := 1
				last_literal_end := last_text_count
				break_kind := binteger_break
				more
				set_start_condition (BREAK)
			
when 109 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 1041 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1041")
end

					-- Syntax error: an underscore may not be
					-- the last character of an integer.
				set_syntax_error
				error_handler.report_SILU_error (filename, current_position)
				last_token := E_INTEGER
				last_literal_start := 1
				last_literal_end := text_count
				last_break_end := 0
				last_comment_end := 0
				last_detachable_et_integer_constant_value := ast_factory.new_binary_integer_constant (Current)
			
when 110 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 1053 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1053")
end

					-- Syntax error: an underscore may not be
					-- the last character of an integer.
				set_syntax_error
				error_handler.report_SILU_error (filename, current_position)
				last_text_count := text_count
				last_literal_start := 1
				last_literal_end := last_text_count
				break_kind := binteger_break
				more
				set_start_condition (BREAK)
			
when 111 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 1069 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1069")
end

				last_text_count := text_count
				last_literal_start := 1
				last_literal_end := last_text_count
				break_kind := real_break
				more
				set_start_condition (BREAK)
			
when 112 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 1070 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1070")
end

				last_text_count := text_count
				last_literal_start := 1
				last_literal_end := last_text_count
				break_kind := real_break
				more
				set_start_condition (BREAK)
			
when 113 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 1071 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1071")
end

				last_text_count := text_count
				last_literal_start := 1
				last_literal_end := last_text_count
				break_kind := real_break
				more
				set_start_condition (BREAK)
			
when 114 then
	yy_end := yy_end - 1
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 1079 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1079")
end

		-- The first regexp of this group uses a trailing context
		-- to make sure that an integer followed by two dots is
		-- not recognized as a real followed by a dot.
				last_token := E_REAL
				last_literal_start := 1
				last_literal_end := text_count
				last_break_end := 0
				last_comment_end := 0
				last_detachable_et_real_constant_value := ast_factory.new_regular_real_constant (Current)
			
when 115 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 1080 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1080")
end

		-- The first regexp of this group uses a trailing context
		-- to make sure that an integer followed by two dots is
		-- not recognized as a real followed by a dot.
				last_token := E_REAL
				last_literal_start := 1
				last_literal_end := text_count
				last_break_end := 0
				last_comment_end := 0
				last_detachable_et_real_constant_value := ast_factory.new_regular_real_constant (Current)
			
when 116 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 1081 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1081")
end

		-- The first regexp of this group uses a trailing context
		-- to make sure that an integer followed by two dots is
		-- not recognized as a real followed by a dot.
				last_token := E_REAL
				last_literal_start := 1
				last_literal_end := text_count
				last_break_end := 0
				last_comment_end := 0
				last_detachable_et_real_constant_value := ast_factory.new_regular_real_constant (Current)
			
when 117 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 1092 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1092")
end

				last_text_count := text_count
				last_literal_start := 1
				last_literal_end := last_text_count
				break_kind := ureal_break
				more
				set_start_condition (BREAK)
			
when 118 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 1093 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1093")
end

				last_text_count := text_count
				last_literal_start := 1
				last_literal_end := last_text_count
				break_kind := ureal_break
				more
				set_start_condition (BREAK)
			
when 119 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 1094 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1094")
end

				last_text_count := text_count
				last_literal_start := 1
				last_literal_end := last_text_count
				break_kind := ureal_break
				more
				set_start_condition (BREAK)
			
when 120 then
	yy_end := yy_end - 1
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 1102 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1102")
end

		-- The first regexp of this group uses a trailing context
		-- to make sure that an integer followed by two dots is
		-- not recognized as a real followed by a dot.
				last_token := E_REAL
				last_literal_start := 1
				last_literal_end := text_count
				last_break_end := 0
				last_comment_end := 0
				last_detachable_et_real_constant_value := ast_factory.new_underscored_real_constant (Current)
			
when 121 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 1103 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1103")
end

		-- The first regexp of this group uses a trailing context
		-- to make sure that an integer followed by two dots is
		-- not recognized as a real followed by a dot.
				last_token := E_REAL
				last_literal_start := 1
				last_literal_end := text_count
				last_break_end := 0
				last_comment_end := 0
				last_detachable_et_real_constant_value := ast_factory.new_underscored_real_constant (Current)
			
when 122 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 1104 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1104")
end

		-- The first regexp of this group uses a trailing context
		-- to make sure that an integer followed by two dots is
		-- not recognized as a real followed by a dot.
				last_token := E_REAL
				last_literal_start := 1
				last_literal_end := text_count
				last_break_end := 0
				last_comment_end := 0
				last_detachable_et_real_constant_value := ast_factory.new_underscored_real_constant (Current)
			
when 123 then
yy_set_line_column
--|#line 1119 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1119")
end

				last_literal_start := 1
				last_literal_end := 0
				last_text_count := 0
				last_break_end := text_count
				last_comment_end := 0
				last_detachable_et_break_value := ast_factory.new_break (Current)
				last_token := E_BREAK
			
when 124 then
yy_set_line_column
--|#line 1129 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1129")
end

				last_literal_start := 1
				last_literal_end := 0
				last_text_count := 0
				last_break_end := 0
				last_comment_end := text_count
				last_detachable_et_break_value := ast_factory.new_comment (Current)
				last_token := E_BREAK
			
when 125 then
yy_set_line_column
--|#line 1140 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1140")
end

				last_break_end := text_count
				last_comment_end := 0
				process_break
				set_start_condition (INITIAL)
			
when 126 then
yy_set_line_column
--|#line 1146 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1146")
end

				last_break_end := 0
				last_comment_end := text_count
				process_break
				set_start_condition (INITIAL)
			
when 127 then
	yy_column := yy_column + 1
--|#line 1152 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1152")
end

					-- Should never happen.
				less (0)
				last_break_end := 0
				last_comment_end := 0
				process_break
				set_start_condition (INITIAL)
			
when 128 then
	yy_column := yy_column + 1
--|#line 1173 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1173")
end

				last_token := E_UNKNOWN
				last_detachable_et_position_value := current_position
			
when 129 then
yy_set_line_column
--|#line 0 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 0")
end
last_token := yyError_token
fatal_error ("scanner jammed")
			else
				last_token := yyError_token
				fatal_error ("fatal scanner internal error: no action found")
			end
		end

	yy_execute_eof_action (yy_sc: INTEGER)
			-- Execute EOF semantic action.
		do
			inspect yy_sc
when 0 then
--|#line 1172 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1172")
end
terminate
when 1 then
--|#line 1160 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1160")
end

					-- Should never happen.
				last_break_end := 0
				last_comment_end := 0
				process_break
				set_start_condition (INITIAL)
			
when 2 then
--|#line 711 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 711")
end

					-- Syntax error: missing double quote at
					-- end of manifest string.
				column := yy_column
				line := yy_line
				set_syntax_error
				error_handler.report_SSEQ_error (filename, current_position)
				last_detachable_et_position_value := current_position
				column := ms_column
				line := ms_line
				last_token := E_STRERR
				set_start_condition (INITIAL)
			
when 3 then
--|#line 755 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 755")
end

					-- Syntax error: missing character % at beginning
					-- of line in multi-line manifest string.
				column := yy_column
				line := yy_line
				set_syntax_error
				error_handler.report_SSNP_error (filename, current_position)
				last_detachable_et_position_value := current_position
				column := ms_column
				line := ms_line
				last_token := E_STRERR
				set_start_condition (INITIAL)
			
when 4 then
--|#line 358 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 358")
end

					-- No final brace-double-quote.
				last_token := E_STRERR
				last_detachable_et_position_value := current_position
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
when 5 then
--|#line 415 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 415")
end

					-- No final brace-double-quote.
				last_token := E_STRERR
				last_detachable_et_position_value := current_position
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
when 6 then
--|#line 443 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 443")
end

					-- No final brace-double-quote.
				last_token := E_STRERR
				last_detachable_et_position_value := current_position
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
when 7 then
--|#line 473 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 473")
end

					-- No final bracket-double-quote.
				last_token := E_STRERR
				last_detachable_et_position_value := current_position
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
when 8 then
--|#line 530 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 530")
end

					-- No final bracket-double-quote.
				last_token := E_STRERR
				last_detachable_et_position_value := current_position
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
when 9 then
--|#line 558 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 558")
end

					-- No final bracket-double-quote.
				last_token := E_STRERR
				last_detachable_et_position_value := current_position
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
			else
				terminate
			end
		end

feature {NONE} -- Table templates

	yy_nxt_template: SPECIAL [INTEGER]
			-- Template for `yy_nxt'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 2836)
			yy_nxt_template_1 (an_array)
			yy_nxt_template_2 (an_array)
			yy_nxt_template_3 (an_array)
			yy_nxt_template_4 (an_array)
			yy_nxt_template_5 (an_array)
			yy_nxt_template_6 (an_array)
			yy_nxt_template_7 (an_array)
			yy_nxt_template_8 (an_array)
			yy_nxt_template_9 (an_array)
			yy_nxt_template_10 (an_array)
			yy_nxt_template_11 (an_array)
			yy_nxt_template_12 (an_array)
			yy_nxt_template_13 (an_array)
			yy_nxt_template_14 (an_array)
			yy_nxt_template_15 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_nxt_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			    0,   22,   23,   24,   23,   25,   26,   27,   22,   28,
			   29,   25,   25,   25,   30,   31,   32,   33,   34,   35,
			   35,   35,   35,   35,   36,   37,   25,   38,   39,   40,
			   40,   40,   40,   40,   40,   40,   41,   40,   25,   42,
			   25,   43,   40,   40,   40,   40,   40,   40,   25,   25,
			   25,   22,   22,   44,   46,   47,   46,   46,   47,   46,
			   50,   67,   68,   51,  176,   52,   48,   50,  398,   48,
			   51,  176,   52,   54,   55,   54,   54,   55,   54,   56,
			   67,   68,   56,   58,   59,   58,   58,   59,   58,   61,
			   62,   63,  385,   64,   61,   62,   63,  193,   64,   70,

			   71,   70,   70,   71,   70,   73,   74,   75,  194,   76,
			   73,   74,   75,  123,   76,   79,   80,   79,   80,   81,
			   81,   81,   81,   81,   81,   83,   83,   83,   92,   92,
			   92,   82,  415,   97,   82,   98,   65,   84,   93,   93,
			   93,   65,  398,   77,   86,   87,   88,   87,   77,   95,
			   95,   95,   99,   99,   99,  176,   83,   83,   83,  150,
			  151,   83,   83,   83,  100,  112,  423,  385,   84,   83,
			   83,   83,  423,   84,  123,  101,   89,  101,  112,  423,
			  101,   84,  423,  152,  151,  101,   90,   83,   83,   83,
			  166,  167,  101,  101,  124,  407,  125,  168,  167,   84, yy_Dummy>>,
			1, 200, 0)
		end

	yy_nxt_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  101,  404,  102,  102,  102,  102,  102,  102,  102,  101,
			  103,  103,  103,  134,  135,  134,  137,  138,  137,  136,
			  150,  151,  104,  105,  414,  106,  106,  107,  107,  107,
			  107,  107,  113,  113,  113,   83,   83,   83,  108,  109,
			  398,   83,   83,   83,  114,  110,  124,   84,  125,  111,
			  412,  108,  109,   84,  176,  110,  103,  103,  103,  101,
			  101,  140,  141,  176,  142,  101,  152,  151,  104,  105,
			  176,  107,  107,  107,  107,  107,  107,  107,  113,  113,
			  113,  120,  120,  120,  120,  120,  120,  126,  126,  126,
			  114,  140,  147,  121,  148,  111,  121,  423,  115,  127,

			  143,  140,  144,  124,  142,  125,  143,  146,  144,  115,
			  142,  116,  153,  154,  153,  156,  157,   86,  158,   88,
			  166,  167,  116,  129,  130,  129,  237,  131,  238,  131,
			  385,  131,  131,  221,  159,  156,  160,  132,  158,  159,
			  162,  160,  123,  158,  222,  407,  131,  145,  131,   89,
			  131,  131,  131,  145,  406,  131,  131,  156,  163,   90,
			  164,  168,  167,  133,  133,  133,  133,  133,   81,   81,
			   81,  374,  161,   83,   83,   83,  233,  161,  193,  372,
			   82,  170,  170,  170,   85,   84,   85,  234,  172,  194,
			   88,  140,  141,  171,  142,  221,  181,  182,  181,  124, yy_Dummy>>,
			1, 200, 200)
		end

	yy_nxt_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			   86,  125,   88,  183,  184,  183,  222,   86,  233,   88,
			  185,  185,  185,  187,  187,  187,   95,   95,   95,  234,
			  173,  400,  191,  191,  191,  195,  195,  195,  257,  257,
			  174,  176,   89,  177,  192,  177,  177,  196,  398,   89,
			  313,  178,   90,  224,  130,  224,  206,  206,  206,   90,
			  177,  314,  177,  176,  177,  177,  177,  176,  207,  177,
			  177,  208,  208,  179,  210,  210,  210,  210,  210,  210,
			  206,  206,  206,  180,  197,  197,  197,  387,  134,  135,
			  134,  385,  207,  217,  136,  209,  198,  115,  211,  102,
			  102,  102,  102,  102,  102,  102,  217,  123,  115,  218,

			  218,  218,  263,  263,  199,  120,  120,  120,  126,  126,
			  126,  219,  123,  200,  202,  202,  202,  121,  268,  268,
			  127,  137,  138,  137,  146,  141,  203,  142,  123,  204,
			  204,  204,  204,  204,  204,  204,  321,  321,  118,  143,
			  140,  144,  209,  142,  205,  214,  214,  214,  225,  226,
			  227,  228,  228,  228,  228,  140,  147,  215,  148,  423,
			  216,  216,  216,  216,  216,  216,  216,  143,  146,  144,
			  423,  142,  146,  147,  383,  148,  229,  229,  229,  153,
			  154,  153,  156,  157,  111,  158,  145,  377,  230,  162,
			  157,  179,  158,  159,  156,  160,  340,  158,  159,  162, yy_Dummy>>,
			1, 200, 400)
		end

	yy_nxt_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  160,  180,  158,  156,  163,  337,  164,  162,  163,  335,
			  164,  231,  231,  231,  145,  235,  235,  235,  181,  182,
			  181,  332,  172,  232,   88,  330,  237,  236,   88,  280,
			  327,  161,  115,  183,  184,  183,  161,  172,  326,   88,
			  245,  182,  245,  115,  423,  247,  247,  247,  248,  248,
			  248,  191,  191,  191,  173,  193,  193,  193,  239,  285,
			  249,  324,  315,  192,  174,  357,  357,   82,  240,  173,
			  246,  184,  246,  316,  423,  318,  179,  370,  370,  174,
			  423,  181,  182,  181,  317,   86,  180,   88,  224,  130,
			  224,  241,  242,  243,  244,  244,  244,  244,  183,  184,

			  183,  306,   86,  363,   88,  306,  179,  195,  195,  195,
			  313,  124,  179,  125,  364,  315,  180,   89,  306,  196,
			  423,  314,  180,  265,  265,  265,  316,   90,  273,  273,
			  273,  221,  221,  221,   89,  266,  378,  378,  208,  208,
			  274,  402,  402,  121,   90,  250,  272,  272,  272,  272,
			  272,  272,  251,  252,  253,  254,  254,  254,  254,  197,
			  197,  197,  267,  397,  397,  397,  306,  275,  366,  365,
			  211,  198,  368,  368,  204,  204,  204,  204,  204,  204,
			  204,  277,  277,  277,  233,  233,  233,  175,  292,  261,
			  397,  397,  397,  278,  279,  285,   84,  285,  262,  269, yy_Dummy>>,
			1, 200, 600)
		end

	yy_nxt_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  269,  269,  281,  282,  283,  284,  284,  284,  284,  285,
			  423,  270,  123,  123,  210,  210,  210,  210,  210,  210,
			  292,  292,  292,  295,  182,  295,  363,  237,  423,   88,
			  277,  273,  293,  269,  306,  307,  265,  364,  271,  285,
			  286,  226,  227,  228,  228,  228,  228,  296,  184,  296,
			  423,  237,  395,   88,  245,  182,  245,  395,  423,  239,
			  177,  262,  306,  396,  306,  308,  303,  294,  396,  240,
			  287,  285,  289,  289,  289,  289,  290,  291,  291,  248,
			  248,  248,  179,  239,  246,  184,  246,  235,  423,  231,
			  179,  249,  180,  240,  423,  288,  288,  288,  288,  229,

			  180,  304,  304,  304,  177,  297,  242,  243,  244,  244,
			  244,  244,  285,  305,  285,  218,  197,  197,  197,  214,
			  179,  318,  318,  318,  213,  206,  179,  423,  198,  260,
			  180,  200,  197,  319,  256,  298,  180,  299,  299,  299,
			  299,  299,  299,  299,  258,  258,  258,  258,  258,  258,
			  258,  320,  324,  324,  324,  317,  291,  291,  291,  291,
			  200,  255,  250,  423,  325,  170,  126,  175,  300,  300,
			  300,  300,  301,  302,  302,  264,  264,  264,  264,  264,
			  264,  264,  304,  304,  304,  337,  337,  337,  223,  122,
			  220,  326,  118,  113,  305,  213,  103,  338,  175,  302, yy_Dummy>>,
			1, 200, 800)
		end

	yy_nxt_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  302,  302,  302,  302,  302,  302,  327,  327,  327,  188,
			  190,  330,  330,  330,  309,  309,  309,  309,  328,  188,
			  169,  329,  329,  331,  275,  100,  268,  268,  122,  175,
			  306,  310,  310,  310,  310,  311,  312,  312,  312,  312,
			  312,  312,  340,  340,  340,  267,  352,  352,  352,  352,
			  209,  332,  332,  332,  341,  358,  359,  360,  361,  361,
			  361,  361,  119,  333,  118,  101,  334,  334,  334,  334,
			  334,  334,  355,  355,  355,  355,  295,  182,  295,  423,
			  237,  213,   88,  296,  184,  296,  423,  237,  423,   88,
			  271,  335,  335,  335,  322,  322,  322,  322,  322,  322,

			  322,  423,  423,  336,  423,  423,  272,  272,  272,  272,
			  272,  272,  239,  313,  313,  313,  315,  315,  315,  239,
			  423,  423,  240,  423,  423,  192,  423,  423,  196,  240,
			  211,  343,  343,  343,  123,  355,  355,  355,  355,  355,
			  423,  423,  423,  344,  423,  423,  345,  345,  345,  345,
			  345,  345,  345,  318,  318,  318,  423,  372,  372,  372,
			  423,  346,  347,  347,  347,  319,  348,  423,  423,  373,
			  269,  269,  269,  423,  349,  423,  423,  423,  265,  265,
			  265,  423,  270,  375,  423,  273,  273,  273,  423,  423,
			  266,  423,  262,  329,  329,  115,  374,  274,  371,  371, yy_Dummy>>,
			1, 200, 1000)
		end

	yy_nxt_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  371,  371,  371,  371,  371,  423,  115,  423,  348,  123,
			  350,  282,  283,  284,  284,  284,  284,  267,  363,  363,
			  363,  380,  380,  380,  275,  381,  423,  318,  318,  318,
			  249,  258,  258,  382,  423,  258,  258,  258,  423,  319,
			  351,  123,  353,  353,  353,  353,  354,  355,  355,  175,
			  362,  362,  362,  362,  362,  362,  362,  318,  318,  318,
			  423,  423,  362,  362,  362,  362,  317,  381,  423,  319,
			  357,  357,  357,  357,  423,  362,  362,  362,  423,  423,
			  175,  302,  302,  302,  302,  302,  302,  302,  404,  404,
			  404,  368,  368,  368,  368,  423,  317,  404,  404,  404,

			  405,  379,  379,  379,  379,  379,  379,  379,  423,  405,
			  423,  175,  302,  302,  302,  302,  302,  302,  302,  380,
			  380,  380,  423,  381,  423,  423,  423,  326,  395,  395,
			  395,  382,  423,  264,  264,  423,  326,  264,  264,  264,
			  305,  423,  175,  302,  302,  302,  302,  302,  175,  175,
			  176,  393,  393,  393,  393,  393,  423,  415,  415,  415,
			  415,  415,  415,  423,  423,  381,  423,  423,  423,  416,
			  423,  423,  416,  175,  318,  318,  318,  403,  403,  403,
			  403,  403,  403,  403,  423,  423,  319,  423,  423,  345,
			  345,  345,  345,  345,  345,  345,  374,  423,  423,  374, yy_Dummy>>,
			1, 200, 1200)
		end

	yy_nxt_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  117,  117,  117,  423,  375,  322,  322,  423,  423,  322,
			  322,  322,  117,  262,  176,  388,  359,  360,  361,  361,
			  361,  361,  423,  423,  407,  407,  407,  423,  417,  212,
			  212,  212,  423,  423,  212,  212,  382,  356,  356,  356,
			  423,  212,  356,  356,  423,  389,  176,  391,  391,  391,
			  391,  392,  393,  393,  394,  394,  394,  394,  394,  394,
			  394,  259,  259,  259,  423,  423,  394,  394,  394,  394,
			  417,  371,  371,  259,  423,  371,  371,  371,  423,  394,
			  394,  394,  423,  423,  175,  411,  411,  411,  411,  411,
			  411,  411,  323,  323,  323,  423,  423,  411,  411,  411,

			  411,  367,  367,  367,  323,  423,  367,  367,  423,  423,
			  411,  411,  411,  302,  302,  302,  302,  302,  302,  302,
			  369,  369,  369,  423,  423,  302,  302,  302,  302,  379,
			  379,  423,  369,  379,  379,  379,  423,  423,  302,  302,
			  302,   45,   45,   45,   45,   45,   45,   45,   45,   45,
			   45,   45,   45,   45,   45,   45,   45,   45,   45,   45,
			   45,   45,   45,   45,   45,   45,   45,   45,   49,   49,
			   49,   49,   49,   49,   49,   49,   49,   49,   49,   49,
			   49,   49,   49,   49,   49,   49,   49,   49,   49,   49,
			   49,   49,   49,   49,   49,   53,   53,   53,   53,   53, yy_Dummy>>,
			1, 200, 1400)
		end

	yy_nxt_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			   53,   53,   53,   53,   53,   53,   53,   53,   53,   53,
			   53,   53,   53,   53,   53,   53,   53,   53,   53,   53,
			   53,   53,   57,   57,   57,   57,   57,   57,   57,   57,
			   57,   57,   57,   57,   57,   57,   57,   57,   57,   57,
			   57,   57,   57,   57,   57,   57,   57,   57,   57,   60,
			   60,   60,   60,   60,   60,   60,   60,   60,   60,   60,
			   60,   60,   60,   60,   60,   60,   60,   60,   60,   60,
			   60,   60,   60,   60,   60,   60,   66,   66,   66,   66,
			   66,   66,   66,   66,   66,   66,   66,   66,   66,   66,
			   66,   66,   66,   66,   66,   66,   66,   66,   66,   66,

			   66,   66,   66,   69,   69,   69,   69,   69,   69,   69,
			   69,   69,   69,   69,   69,   69,   69,   69,   69,   69,
			   69,   69,   69,   69,   69,   69,   69,   69,   69,   69,
			   72,   72,   72,   72,   72,   72,   72,   72,   72,   72,
			   72,   72,   72,   72,   72,   72,   72,   72,   72,   72,
			   72,   72,   72,   72,   72,   72,   72,   78,   78,   78,
			   78,   78,   78,   78,   78,   78,   78,   78,   78,   78,
			   78,   78,   78,   78,   78,   78,   78,   78,   78,   78,
			   78,   78,   78,   78,   85,   85,  423,   85,   85,   85,
			   85,   85,   85,   85,   85,   85,   85,   85,   85,   85, yy_Dummy>>,
			1, 200, 1600)
		end

	yy_nxt_template_10 (an_array: ARRAY [INTEGER])
			-- Fill chunk #10 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			   85,   85,   85,   85,   85,   85,   85,   85,   85,   85,
			   85,   91,   91,   91,   91,  423,  423,   91,   91,   91,
			   91,   91,   91,   91,   91,   91,   91,   91,   91,   91,
			   91,   91,   91,   91,   91,   91,   91,   91,   94,   94,
			   94,   94,  423,  423,   94,   94,   94,   94,   94,   94,
			   94,   94,   94,   94,   94,   94,   94,   94,   94,   94,
			   94,   94,   94,   94,   94,   96,   96,  423,   96,   96,
			   96,   96,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,   96,  115,  115,  115,  376,  376,  376,  423,  423,

			  115,  423,  423,  115,  115,  115,  423,  376,  115,  115,
			  115,  115,  115,  115,  115,  115,  115,  115,  123,  123,
			  423,  123,  123,  123,  123,  123,  123,  123,  123,  123,
			  123,  123,  123,  123,  123,  123,  123,  123,  123,  123,
			  123,  123,  123,  123,  123,  128,  128,  128,  128,  128,
			  128,  128,  128,  128,  128,  128,  128,  128,  128,  128,
			  128,  128,  128,  128,  128,  128,  128,  128,  128,  128,
			  128,  128,  139,  139,  139,  139,  139,  139,  139,  139,
			  139,  139,  139,  139,  139,  139,  139,  139,  139,  139,
			  139,  139,  139,  139,  139,  139,  139,  139,  139,  145, yy_Dummy>>,
			1, 200, 1800)
		end

	yy_nxt_template_11 (an_array: ARRAY [INTEGER])
			-- Fill chunk #11 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  145,  145,  145,  145,  145,  145,  145,  145,  145,  145,
			  145,  145,  145,  145,  145,  145,  145,  145,  145,  145,
			  145,  145,  145,  145,  145,  145,  149,  149,  149,  149,
			  149,  149,  149,  149,  149,  149,  149,  149,  149,  149,
			  149,  149,  149,  149,  149,  149,  149,  149,  149,  149,
			  149,  149,  149,  155,  155,  155,  155,  155,  155,  155,
			  155,  155,  155,  155,  155,  155,  155,  155,  155,  155,
			  155,  155,  155,  155,  155,  155,  155,  155,  155,  155,
			  161,  161,  161,  161,  161,  161,  161,  161,  161,  161,
			  161,  161,  161,  161,  161,  161,  161,  161,  161,  161,

			  161,  161,  161,  161,  161,  161,  161,  165,  165,  165,
			  165,  165,  165,  165,  165,  165,  165,  165,  165,  165,
			  165,  165,  165,  165,  165,  165,  165,  165,  165,  165,
			  165,  165,  165,  165,   87,   87,  423,   87,   87,   87,
			   87,   87,   87,   87,   87,   87,   87,   87,   87,   87,
			   87,   87,   87,   87,   87,   87,   87,   87,   87,   87,
			   87,  175,  175,  423,  175,  175,  175,  175,  175,  175,
			  175,  175,  175,  175,  175,  175,  175,  175,  175,  175,
			  175,  175,  175,  175,  175,  175,  175,  175,  186,  186,
			  186,  186,  423,  423,  186,  186,  186,  186,  186,  186, yy_Dummy>>,
			1, 200, 2000)
		end

	yy_nxt_template_12 (an_array: ARRAY [INTEGER])
			-- Fill chunk #12 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  423,  423,  423,  186,  186,  189,  189,  423,  189,  189,
			  189,  189,  189,  189,  189,  189,  189,  189,  189,  189,
			  189,  189,  189,  189,  189,  189,  189,  189,  189,  189,
			  189,  189,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  201,
			  201,  201,  201,  201,  201,  201,  201,  201,  201,  423,
			  201,  201,  201,  201,  201,  201,  201,  201,  201,  201,
			  201,  201,  201,  201,  201,  201,  122,  122,  122,  122,
			  122,  122,  122,  122,  122,  122,  122,  122,  122,  122,

			  122,  122,  122,  122,  122,  122,  122,  122,  122,  122,
			  122,  122,  122,  123,  123,  123,  123,  384,  384,  384,
			  123,  423,  384,  384,  123,  123,  123,  423,  423,  123,
			  123,  169,  169,  169,  169,  169,  169,  169,  169,  169,
			  169,  169,  169,  169,  169,  169,  169,  169,  169,  169,
			  169,  169,  169,  169,  169,  169,  169,  169,  176,  176,
			  423,  176,  176,  176,  176,  176,  176,  176,  176,  176,
			  176,  176,  176,  176,  176,  176,  176,  176,  176,  176,
			  176,  176,  176,  176,  176,  177,  177,  423,  177,  177,
			  177,  177,  177,  177,  177,  177,  177,  177,  177,  177, yy_Dummy>>,
			1, 200, 2200)
		end

	yy_nxt_template_13 (an_array: ARRAY [INTEGER])
			-- Fill chunk #13 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  177,  177,  177,  177,  177,  177,  177,  177,  177,  177,
			  177,  177,  186,  186,  186,  186,  423,  423,  186,  186,
			  186,  186,  186,  186,  186,  186,  186,  186,  186,  186,
			  186,  186,  186,  186,  186,  186,  186,  186,  186,  276,
			  276,  276,  423,  423,  276,  276,  390,  390,  390,  390,
			  423,  276,  176,  176,  176,  176,  403,  403,  423,  176,
			  403,  403,  403,  176,  176,  176,  423,  423,  176,  176,
			  255,  255,  255,  255,  255,  255,  255,  255,  255,  255,
			  255,  255,  255,  255,  255,  255,  255,  255,  255,  255,
			  255,  255,  255,  255,  255,  255,  255,  256,  256,  256,

			  256,  256,  256,  256,  256,  256,  256,  256,  256,  256,
			  256,  256,  256,  256,  256,  256,  256,  256,  256,  256,
			  256,  256,  256,  256,  339,  339,  339,  386,  386,  386,
			  386,  423,  339,  386,  386,  339,  339,  339,  423,  423,
			  339,  339,  393,  393,  393,  393,  423,  339,  342,  342,
			  342,  342,  342,  342,  342,  342,  342,  342,  423,  342,
			  342,  342,  342,  342,  342,  342,  342,  342,  342,  342,
			  342,  342,  342,  342,  342,  123,  123,  423,  123,  123,
			  123,  123,  123,  123,  123,  123,  123,  123,  123,  123,
			  123,  123,  123,  123,  123,  123,  123,  123,  123,  123, yy_Dummy>>,
			1, 200, 2400)
		end

	yy_nxt_template_14 (an_array: ARRAY [INTEGER])
			-- Fill chunk #14 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  123,  123,  303,  303,  303,  303,  303,  303,  303,  303,
			  303,  303,  303,  303,  303,  303,  303,  303,  303,  303,
			  303,  303,  303,  303,  303,  303,  303,  303,  303,  365,
			  365,  365,  365,  365,  365,  365,  365,  365,  365,  365,
			  365,  365,  365,  365,  365,  365,  365,  365,  365,  365,
			  365,  365,  365,  365,  365,  365,  399,  399,  399,  399,
			  423,  423,  399,  399,  401,  401,  401,  408,  408,  408,
			  408,  423,  423,  408,  408,  423,  401,  406,  406,  406,
			  406,  406,  406,  406,  406,  406,  406,  406,  406,  406,
			  406,  406,  406,  406,  406,  406,  406,  406,  406,  406,

			  406,  406,  406,  406,  409,  409,  409,  409,  423,  423,
			  409,  409,  410,  410,  410,  423,  423,  410,  410,  413,
			  413,  413,  413,  423,  423,  413,  413,  418,  418,  418,
			  418,  423,  423,  418,  418,  419,  419,  419,  419,  423,
			  423,  419,  419,  420,  420,  420,  420,  423,  423,  420,
			  420,  421,  421,  421,  421,  423,  423,  421,  421,  355,
			  355,  355,  355,  423,  423,  355,  355,  422,  422,  422,
			  422,  423,  423,  422,  422,  393,  393,  393,  393,  423,
			  423,  393,  393,   21,  423,  423,  423,  423,  423,  423,
			  423,  423,  423,  423,  423,  423,  423,  423,  423,  423, yy_Dummy>>,
			1, 200, 2600)
		end

	yy_nxt_template_15 (an_array: ARRAY [INTEGER])
			-- Fill chunk #15 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  423,  423,  423,  423,  423,  423,  423,  423,  423,  423,
			  423,  423,  423,  423,  423,  423,  423,  423,  423,  423,
			  423,  423,  423,  423,  423,  423,  423,  423,  423,  423,
			  423,  423,  423,  423,  423,  423,  423, yy_Dummy>>,
			1, 37, 2800)
		end

	yy_chk_template: SPECIAL [INTEGER]
			-- Template for `yy_chk'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 2836)
			yy_chk_template_1 (an_array)
			yy_chk_template_2 (an_array)
			yy_chk_template_3 (an_array)
			yy_chk_template_4 (an_array)
			yy_chk_template_5 (an_array)
			yy_chk_template_6 (an_array)
			yy_chk_template_7 (an_array)
			yy_chk_template_8 (an_array)
			yy_chk_template_9 (an_array)
			yy_chk_template_10 (an_array)
			yy_chk_template_11 (an_array)
			yy_chk_template_12 (an_array)
			yy_chk_template_13 (an_array)
			yy_chk_template_14 (an_array)
			yy_chk_template_15 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_chk_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    3,    3,    3,    4,    4,    4,
			    5,   13,   13,    5,  422,    5,    3,    6,  421,    4,
			    6,  420,    6,    7,    7,    7,    8,    8,    8,    7,
			   14,   14,    8,    9,    9,    9,   10,   10,   10,   11,
			   11,   11,  419,   11,   12,   12,   12,  100,   12,   15,

			   15,   15,   16,   16,   16,   17,   17,   17,  100,   17,
			   18,   18,   18,  418,   18,   19,   19,   20,   20,   23,
			   23,   23,   24,   24,   24,   25,   25,   25,   27,   27,
			   27,   23,  416,   29,   24,   29,   11,   25,   27,   27,
			   27,   12,  413,   17,   26,   26,   26,   26,   18,   28,
			   28,   28,   30,   30,   30,  410,   36,   36,   36,   66,
			   66,   32,   32,   32,   30,   34,   34,  409,   36,   37,
			   37,   37,   34,   32,  408,   32,   26,   30,   34,   34,
			   36,   37,   34,   68,   68,   32,   26,   31,   31,   31,
			   78,   78,   37,   37,   49,  406,   49,   80,   80,   31, yy_Dummy>>,
			1, 200, 0)
		end

	yy_chk_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   31,  405,   31,   31,   31,   31,   31,   31,   31,   32,
			   33,   33,   33,   54,   54,   54,   58,   58,   58,   54,
			  149,  149,   33,   33,  400,   33,   33,   33,   33,   33,
			   33,   33,   40,   40,   40,   38,   38,   38,   33,   33,
			  399,   39,   39,   39,   40,   33,  123,   38,  123,   33,
			  398,   33,   33,   39,  393,   33,   35,   35,   35,   38,
			   38,   60,   60,  391,   60,   39,  151,  151,   35,   35,
			  390,   35,   35,   35,   35,   35,   35,   35,   41,   41,
			   41,   46,   46,   46,   47,   47,   47,   51,   51,   51,
			   41,   65,   65,   46,   65,   35,   47,  388,  115,   51,

			   61,   61,   61,  131,   61,  131,   63,   63,   63,  115,
			   63,   41,   70,   70,   70,   72,   72,   85,   72,   85,
			  165,  165,   41,   52,   52,   52,  176,   52,  176,   52,
			  386,   52,   52,  122,   73,   73,   73,   52,   73,   75,
			   75,   75,  384,   75,  122,  383,   52,   61,   52,   85,
			   52,   52,   52,   63,  382,   52,   52,   77,   77,   85,
			   77,  167,  167,   52,   52,   52,   52,   52,   81,   81,
			   81,  374,   73,   83,   83,   83,  169,   75,  194,  373,
			   81,   86,   86,   86,   87,   83,   87,  169,   87,  194,
			   87,  139,  139,   86,  139,  222,   89,   89,   89,  285, yy_Dummy>>,
			1, 200, 200)
		end

	yy_chk_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   89,  285,   89,   90,   90,   90,  222,   90,  234,   90,
			   91,   91,   91,   93,   93,   93,   94,   94,   94,  234,
			   87,  368,   99,   99,   99,  101,  101,  101,  199,  199,
			   87,   88,   89,   88,   99,   88,   88,  101,  367,   90,
			  255,   88,   89,  129,  129,  129,  108,  108,  108,   90,
			   88,  255,   88,  361,   88,   88,   88,  359,  108,   88,
			   88,  108,  108,   88,  109,  109,  109,  109,  109,  109,
			  112,  112,  112,   88,  102,  102,  102,  357,  134,  134,
			  134,  356,  112,  116,  134,  108,  102,  116,  109,  102,
			  102,  102,  102,  102,  102,  102,  116,  355,  116,  117,

			  117,  117,  205,  205,  102,  120,  120,  120,  124,  124,
			  124,  117,  353,  102,  105,  105,  105,  120,  209,  209,
			  124,  137,  137,  137,  141,  141,  105,  141,  352,  105,
			  105,  105,  105,  105,  105,  105,  261,  261,  117,  143,
			  143,  143,  209,  143,  105,  111,  111,  111,  132,  132,
			  132,  132,  132,  132,  132,  145,  145,  111,  145,  175,
			  111,  111,  111,  111,  111,  111,  111,  144,  144,  144,
			  350,  144,  147,  147,  349,  147,  148,  148,  148,  153,
			  153,  153,  155,  155,  111,  155,  143,  344,  148,  157,
			  157,  175,  157,  159,  159,  159,  341,  159,  160,  160, yy_Dummy>>,
			1, 200, 400)
		end

	yy_chk_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  160,  175,  160,  161,  161,  338,  161,  163,  163,  336,
			  163,  164,  164,  164,  144,  172,  172,  172,  173,  173,
			  173,  333,  173,  164,  173,  331,  177,  172,  177,  217,
			  328,  159,  217,  174,  174,  174,  160,  174,  326,  174,
			  179,  179,  179,  217,  179,  186,  186,  186,  188,  188,
			  188,  191,  191,  191,  173,  193,  193,  193,  177,  290,
			  188,  325,  256,  191,  173,  290,  290,  193,  177,  174,
			  180,  180,  180,  256,  180,  319,  179,  320,  320,  174,
			  178,  181,  181,  181,  317,  181,  179,  181,  224,  224,
			  224,  178,  178,  178,  178,  178,  178,  178,  183,  183,

			  183,  312,  183,  303,  183,  310,  180,  195,  195,  195,
			  314,  385,  178,  385,  303,  316,  180,  181,  309,  195,
			  307,  314,  178,  208,  208,  208,  316,  181,  212,  212,
			  212,  221,  221,  221,  183,  208,  346,  346,  208,  208,
			  212,  375,  375,  221,  183,  190,  211,  211,  211,  211,
			  211,  211,  190,  190,  190,  190,  190,  190,  190,  204,
			  204,  204,  208,  366,  366,  366,  311,  212,  306,  305,
			  211,  204,  311,  311,  204,  204,  204,  204,  204,  204,
			  204,  216,  216,  216,  233,  233,  233,  297,  293,  204,
			  412,  412,  412,  216,  216,  291,  233,  289,  204,  210, yy_Dummy>>,
			1, 200, 600)
		end

	yy_chk_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  210,  210,  223,  223,  223,  223,  223,  223,  223,  288,
			  286,  210,  284,  282,  210,  210,  210,  210,  210,  210,
			  237,  237,  237,  239,  239,  239,  364,  239,  251,  239,
			  278,  274,  237,  270,  251,  251,  266,  364,  210,  225,
			  225,  225,  225,  225,  225,  225,  225,  240,  240,  240,
			  302,  240,  365,  240,  245,  245,  245,  396,  245,  239,
			  302,  262,  254,  365,  252,  251,  249,  238,  396,  239,
			  225,  227,  227,  227,  227,  227,  227,  227,  227,  248,
			  248,  248,  302,  240,  246,  246,  246,  236,  246,  232,
			  245,  248,  302,  240,  241,  464,  464,  464,  464,  230,

			  245,  250,  250,  250,  241,  241,  241,  241,  241,  241,
			  241,  241,  228,  250,  226,  219,  258,  258,  258,  215,
			  246,  259,  259,  259,  213,  207,  241,  258,  258,  203,
			  246,  200,  198,  259,  196,  241,  241,  242,  242,  242,
			  242,  242,  242,  242,  257,  257,  257,  257,  257,  257,
			  257,  259,  264,  264,  264,  258,  465,  465,  465,  465,
			  259,  192,  189,  264,  264,  171,  127,  242,  243,  243,
			  243,  243,  243,  243,  243,  263,  263,  263,  263,  263,
			  263,  263,  304,  304,  304,  275,  275,  275,  125,  121,
			  119,  264,  118,  114,  304,  110,  104,  275,  243,  244, yy_Dummy>>,
			1, 200, 800)
		end

	yy_chk_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  244,  244,  244,  244,  244,  244,  267,  267,  267,   98,
			   97,  268,  268,  268,  467,  467,  467,  467,  267,   96,
			   84,  267,  267,  268,  275,   82,  268,  268,   48,  244,
			  253,  253,  253,  253,  253,  253,  253,  253,  468,  468,
			  468,  468,  276,  276,  276,  267,  475,  475,  475,  475,
			  268,  271,  271,  271,  276,  294,  294,  294,  294,  294,
			  294,  294,   44,  271,   43,   42,  271,  271,  271,  271,
			  271,  271,  476,  476,  476,  476,  295,  295,  295,   21,
			  295,  276,  295,  296,  296,  296,    0,  296,    0,  296,
			  271,  272,  272,  272,  321,  321,  321,  321,  321,  321,

			  321,    0,    0,  272,    0,    0,  272,  272,  272,  272,
			  272,  272,  295,  313,  313,  313,  315,  315,  315,  296,
			    0,    0,  295,    0,    0,  313,    0,    0,  315,  296,
			  272,  279,  279,  279,  354,  354,  354,  354,  354,  354,
			    0,    0,    0,  279,    0,    0,  279,  279,  279,  279,
			  279,  279,  279,  323,  323,  323,    0,  322,  322,  322,
			    0,  279,  280,  280,  280,  323,  280,    0,  322,  322,
			  334,  334,  334,    0,  280,    0,    0,    0,  329,  329,
			  329,    0,  334,  323,    0,  339,  339,  339,    0,    0,
			  329,    0,  323,  329,  329,  280,  322,  339,  370,  370, yy_Dummy>>,
			1, 200, 1000)
		end

	yy_chk_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  370,  370,  370,  370,  370,    0,  280,    0,  280,  281,
			  281,  281,  281,  281,  281,  281,  281,  329,  363,  363,
			  363,  347,  347,  347,  339,  347,    0,  369,  369,  369,
			  363,  460,  460,  347,    0,  460,  460,  460,    0,  369,
			  281,  283,  283,  283,  283,  283,  283,  283,  283,  298,
			  298,  298,  298,  298,  298,  298,  298,  371,  371,  371,
			    0,    0,  298,  298,  298,  298,  369,  347,  371,  371,
			  479,  479,  479,  479,    0,  298,  298,  298,    0,    0,
			  298,  299,  299,  299,  299,  299,  299,  299,  376,  376,
			  376,  482,  482,  482,  482,    0,  371,  379,  379,  379,

			  376,  378,  378,  378,  378,  378,  378,  378,  379,  379,
			    0,  299,  300,  300,  300,  300,  300,  300,  300,  380,
			  380,  380,    0,  380,    0,    0,    0,  376,  395,  395,
			  395,  380,    0,  462,  462,    0,  379,  462,  462,  462,
			  395,    0,  300,  301,  301,  301,  301,  301,  301,  301,
			  392,  392,  392,  392,  392,  392,    0,  401,  401,  401,
			  403,  403,  403,    0,    0,  380,    0,    0,    0,  401,
			    0,  403,  403,  301,  345,  345,  345,  402,  402,  402,
			  402,  402,  402,  402,    0,    0,  345,    0,    0,  345,
			  345,  345,  345,  345,  345,  345,  401,    0,    0,  403, yy_Dummy>>,
			1, 200, 1200)
		end

	yy_chk_template_8 (an_array: ARRAY [INTEGER])
			-- Fill chunk #8 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  438,  438,  438,    0,  345,  471,  471,    0,    0,  471,
			  471,  471,  438,  345,  358,  358,  358,  358,  358,  358,
			  358,  358,    0,    0,  407,  407,  407,    0,  407,  453,
			  453,  453,    0,    0,  453,  453,  407,  478,  478,  478,
			    0,  453,  478,  478,    0,  358,  360,  360,  360,  360,
			  360,  360,  360,  360,  362,  362,  362,  362,  362,  362,
			  362,  461,  461,  461,    0,    0,  362,  362,  362,  362,
			  407,  484,  484,  461,    0,  484,  484,  484,    0,  362,
			  362,  362,    0,    0,  362,  394,  394,  394,  394,  394,
			  394,  394,  472,  472,  472,    0,    0,  394,  394,  394,

			  394,  481,  481,  481,  472,    0,  481,  481,    0,    0,
			  394,  394,  394,  411,  411,  411,  411,  411,  411,  411,
			  483,  483,  483,    0,    0,  411,  411,  411,  411,  486,
			  486,    0,  483,  486,  486,  486,    0,    0,  411,  411,
			  411,  424,  424,  424,  424,  424,  424,  424,  424,  424,
			  424,  424,  424,  424,  424,  424,  424,  424,  424,  424,
			  424,  424,  424,  424,  424,  424,  424,  424,  425,  425,
			  425,  425,  425,  425,  425,  425,  425,  425,  425,  425,
			  425,  425,  425,  425,  425,  425,  425,  425,  425,  425,
			  425,  425,  425,  425,  425,  426,  426,  426,  426,  426, yy_Dummy>>,
			1, 200, 1400)
		end

	yy_chk_template_9 (an_array: ARRAY [INTEGER])
			-- Fill chunk #9 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  426,  426,  426,  426,  426,  426,  426,  426,  426,  426,
			  426,  426,  426,  426,  426,  426,  426,  426,  426,  426,
			  426,  426,  427,  427,  427,  427,  427,  427,  427,  427,
			  427,  427,  427,  427,  427,  427,  427,  427,  427,  427,
			  427,  427,  427,  427,  427,  427,  427,  427,  427,  428,
			  428,  428,  428,  428,  428,  428,  428,  428,  428,  428,
			  428,  428,  428,  428,  428,  428,  428,  428,  428,  428,
			  428,  428,  428,  428,  428,  428,  429,  429,  429,  429,
			  429,  429,  429,  429,  429,  429,  429,  429,  429,  429,
			  429,  429,  429,  429,  429,  429,  429,  429,  429,  429,

			  429,  429,  429,  430,  430,  430,  430,  430,  430,  430,
			  430,  430,  430,  430,  430,  430,  430,  430,  430,  430,
			  430,  430,  430,  430,  430,  430,  430,  430,  430,  430,
			  431,  431,  431,  431,  431,  431,  431,  431,  431,  431,
			  431,  431,  431,  431,  431,  431,  431,  431,  431,  431,
			  431,  431,  431,  431,  431,  431,  431,  432,  432,  432,
			  432,  432,  432,  432,  432,  432,  432,  432,  432,  432,
			  432,  432,  432,  432,  432,  432,  432,  432,  432,  432,
			  432,  432,  432,  432,  433,  433,    0,  433,  433,  433,
			  433,  433,  433,  433,  433,  433,  433,  433,  433,  433, yy_Dummy>>,
			1, 200, 1600)
		end

	yy_chk_template_10 (an_array: ARRAY [INTEGER])
			-- Fill chunk #10 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  433,  433,  433,  433,  433,  433,  433,  433,  433,  433,
			  433,  434,  434,  434,  434,    0,    0,  434,  434,  434,
			  434,  434,  434,  434,  434,  434,  434,  434,  434,  434,
			  434,  434,  434,  434,  434,  434,  434,  434,  435,  435,
			  435,  435,    0,    0,  435,  435,  435,  435,  435,  435,
			  435,  435,  435,  435,  435,  435,  435,  435,  435,  435,
			  435,  435,  435,  435,  435,  436,  436,    0,  436,  436,
			  436,  436,  436,  436,  436,  436,  436,  436,  436,  436,
			  436,  436,  436,  436,  436,  436,  436,  436,  436,  436,
			  436,  436,  437,  437,  437,  485,  485,  485,    0,    0,

			  437,    0,    0,  437,  437,  437,    0,  485,  437,  437,
			  437,  437,  437,  437,  437,  437,  437,  437,  439,  439,
			    0,  439,  439,  439,  439,  439,  439,  439,  439,  439,
			  439,  439,  439,  439,  439,  439,  439,  439,  439,  439,
			  439,  439,  439,  439,  439,  440,  440,  440,  440,  440,
			  440,  440,  440,  440,  440,  440,  440,  440,  440,  440,
			  440,  440,  440,  440,  440,  440,  440,  440,  440,  440,
			  440,  440,  441,  441,  441,  441,  441,  441,  441,  441,
			  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,
			  441,  441,  441,  441,  441,  441,  441,  441,  441,  442, yy_Dummy>>,
			1, 200, 1800)
		end

	yy_chk_template_11 (an_array: ARRAY [INTEGER])
			-- Fill chunk #11 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  442,  442,  442,  442,  442,  442,  442,  442,  442,  442,
			  442,  442,  442,  442,  442,  442,  442,  442,  442,  442,
			  442,  442,  442,  442,  442,  442,  443,  443,  443,  443,
			  443,  443,  443,  443,  443,  443,  443,  443,  443,  443,
			  443,  443,  443,  443,  443,  443,  443,  443,  443,  443,
			  443,  443,  443,  444,  444,  444,  444,  444,  444,  444,
			  444,  444,  444,  444,  444,  444,  444,  444,  444,  444,
			  444,  444,  444,  444,  444,  444,  444,  444,  444,  444,
			  445,  445,  445,  445,  445,  445,  445,  445,  445,  445,
			  445,  445,  445,  445,  445,  445,  445,  445,  445,  445,

			  445,  445,  445,  445,  445,  445,  445,  446,  446,  446,
			  446,  446,  446,  446,  446,  446,  446,  446,  446,  446,
			  446,  446,  446,  446,  446,  446,  446,  446,  446,  446,
			  446,  446,  446,  446,  447,  447,    0,  447,  447,  447,
			  447,  447,  447,  447,  447,  447,  447,  447,  447,  447,
			  447,  447,  447,  447,  447,  447,  447,  447,  447,  447,
			  447,  448,  448,    0,  448,  448,  448,  448,  448,  448,
			  448,  448,  448,  448,  448,  448,  448,  448,  448,  448,
			  448,  448,  448,  448,  448,  448,  448,  448,  449,  449,
			  449,  449,    0,    0,  449,  449,  449,  449,  449,  449, yy_Dummy>>,
			1, 200, 2000)
		end

	yy_chk_template_12 (an_array: ARRAY [INTEGER])
			-- Fill chunk #12 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    0,    0,    0,  449,  449,  450,  450,    0,  450,  450,
			  450,  450,  450,  450,  450,  450,  450,  450,  450,  450,
			  450,  450,  450,  450,  450,  450,  450,  450,  450,  450,
			  450,  450,  451,  451,  451,  451,  451,  451,  451,  451,
			  451,  451,  451,  451,  451,  451,  451,  451,  451,  451,
			  451,  451,  451,  451,  451,  451,  451,  451,  451,  452,
			  452,  452,  452,  452,  452,  452,  452,  452,  452,    0,
			  452,  452,  452,  452,  452,  452,  452,  452,  452,  452,
			  452,  452,  452,  452,  452,  452,  454,  454,  454,  454,
			  454,  454,  454,  454,  454,  454,  454,  454,  454,  454,

			  454,  454,  454,  454,  454,  454,  454,  454,  454,  454,
			  454,  454,  454,  455,  455,  455,  455,  487,  487,  487,
			  455,    0,  487,  487,  455,  455,  455,    0,    0,  455,
			  455,  456,  456,  456,  456,  456,  456,  456,  456,  456,
			  456,  456,  456,  456,  456,  456,  456,  456,  456,  456,
			  456,  456,  456,  456,  456,  456,  456,  456,  457,  457,
			    0,  457,  457,  457,  457,  457,  457,  457,  457,  457,
			  457,  457,  457,  457,  457,  457,  457,  457,  457,  457,
			  457,  457,  457,  457,  457,  458,  458,    0,  458,  458,
			  458,  458,  458,  458,  458,  458,  458,  458,  458,  458, yy_Dummy>>,
			1, 200, 2200)
		end

	yy_chk_template_13 (an_array: ARRAY [INTEGER])
			-- Fill chunk #13 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  458,  458,  458,  458,  458,  458,  458,  458,  458,  458,
			  458,  458,  459,  459,  459,  459,    0,    0,  459,  459,
			  459,  459,  459,  459,  459,  459,  459,  459,  459,  459,
			  459,  459,  459,  459,  459,  459,  459,  459,  459,  463,
			  463,  463,    0,    0,  463,  463,  489,  489,  489,  489,
			    0,  463,  466,  466,  466,  466,  494,  494,    0,  466,
			  494,  494,  494,  466,  466,  466,    0,    0,  466,  466,
			  469,  469,  469,  469,  469,  469,  469,  469,  469,  469,
			  469,  469,  469,  469,  469,  469,  469,  469,  469,  469,
			  469,  469,  469,  469,  469,  469,  469,  470,  470,  470,

			  470,  470,  470,  470,  470,  470,  470,  470,  470,  470,
			  470,  470,  470,  470,  470,  470,  470,  470,  470,  470,
			  470,  470,  470,  470,  473,  473,  473,  488,  488,  488,
			  488,    0,  473,  488,  488,  473,  473,  473,    0,    0,
			  473,  473,  490,  490,  490,  490,    0,  473,  474,  474,
			  474,  474,  474,  474,  474,  474,  474,  474,    0,  474,
			  474,  474,  474,  474,  474,  474,  474,  474,  474,  474,
			  474,  474,  474,  474,  474,  477,  477,    0,  477,  477,
			  477,  477,  477,  477,  477,  477,  477,  477,  477,  477,
			  477,  477,  477,  477,  477,  477,  477,  477,  477,  477, yy_Dummy>>,
			1, 200, 2400)
		end

	yy_chk_template_14 (an_array: ARRAY [INTEGER])
			-- Fill chunk #14 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  477,  477,  480,  480,  480,  480,  480,  480,  480,  480,
			  480,  480,  480,  480,  480,  480,  480,  480,  480,  480,
			  480,  480,  480,  480,  480,  480,  480,  480,  480,  491,
			  491,  491,  491,  491,  491,  491,  491,  491,  491,  491,
			  491,  491,  491,  491,  491,  491,  491,  491,  491,  491,
			  491,  491,  491,  491,  491,  491,  492,  492,  492,  492,
			    0,    0,  492,  492,  493,  493,  493,  496,  496,  496,
			  496,    0,    0,  496,  496,    0,  493,  495,  495,  495,
			  495,  495,  495,  495,  495,  495,  495,  495,  495,  495,
			  495,  495,  495,  495,  495,  495,  495,  495,  495,  495,

			  495,  495,  495,  495,  497,  497,  497,  497,    0,    0,
			  497,  497,  498,  498,  498,    0,    0,  498,  498,  499,
			  499,  499,  499,    0,    0,  499,  499,  500,  500,  500,
			  500,    0,    0,  500,  500,  501,  501,  501,  501,    0,
			    0,  501,  501,  502,  502,  502,  502,    0,    0,  502,
			  502,  503,  503,  503,  503,    0,    0,  503,  503,  504,
			  504,  504,  504,    0,    0,  504,  504,  505,  505,  505,
			  505,    0,    0,  505,  505,  506,  506,  506,  506,    0,
			    0,  506,  506,  423,  423,  423,  423,  423,  423,  423,
			  423,  423,  423,  423,  423,  423,  423,  423,  423,  423, yy_Dummy>>,
			1, 200, 2600)
		end

	yy_chk_template_15 (an_array: ARRAY [INTEGER])
			-- Fill chunk #15 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  423,  423,  423,  423,  423,  423,  423,  423,  423,  423,
			  423,  423,  423,  423,  423,  423,  423,  423,  423,  423,
			  423,  423,  423,  423,  423,  423,  423,  423,  423,  423,
			  423,  423,  423,  423,  423,  423,  423, yy_Dummy>>,
			1, 37, 2800)
		end

	yy_base_template: SPECIAL [INTEGER]
			-- Template for `yy_base'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 506)
			yy_base_template_1 (an_array)
			yy_base_template_2 (an_array)
			yy_base_template_3 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_base_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			    0,    0,    0,   52,   55,   57,   64,   71,   74,   81,
			   84,   87,   92,   58,   77,   97,  100,  103,  108,  112,
			  114, 1079, 2783,  117,  120,  123,  138,  126,  147,  125,
			  150,  185,  159,  208,  135,  254,  154,  167,  233,  239,
			  230,  276, 1026, 1023, 1011, 2783,  279,  282, 1014,  188,
			 2783,  285,  321, 2783,  211, 2783, 2783, 2783,  214, 2783,
			  258,  298, 2783,  304, 2783,  288,  156, 2783,  180, 2783,
			  310, 2783,  312,  332, 2783,  337, 2783,  354,  187, 2783,
			  194,  366, 1011,  371, 1006,  311,  379,  382,  425,  394,
			  401,  408, 2783,  411,  414, 2783, 1009,  994,  999,  420,

			   94,  423,  472, 2783,  982,  512,    0,    0,  444,  447,
			  954,  543,  468, 2783,  979,  263,  452,  497,  951,  938,
			  503,  975,  330,  240,  506,  972, 2783,  952, 2783,  441,
			 2783,  297,  531, 2783,  476, 2783, 2783,  519, 2783,  388,
			 2783,  521, 2783,  537,  565,  552, 2783,  569,  574,  217,
			 2783,  263, 2783,  577, 2783,  579, 2783,  586, 2783,  591,
			  596,  600, 2783,  604,  609,  317, 2783,  358, 2783,  373,
			 2783,  951,  613,  616,  631,  553,  320,  620,  674,  638,
			  668,  679, 2783,  696, 2783, 2783,  643, 2783,  646,  952,
			  735,  649,  947,  653,  375,  705,  920, 2783,  918,  415, yy_Dummy>>,
			1, 200, 0)
		end

	yy_base_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			  890, 2783, 2783,  915,  757,  489, 2783,  911,  721,  501,
			  797,  729,  726,  883, 2783,  905,  779,  597, 2783,  901,
			 2783,  729,  392,  785,  686,  823,  898,  855,  896, 2783,
			  885, 2783,  875,  782,  405, 2783,  873,  818,  851,  821,
			  845,  888,  920,  951,  982,  852,  882, 2783,  877,  852,
			  899,  818,  848, 1014,  846,  437,  659,  927,  914,  919,
			 2783,  523,  820,  958,  950, 2783,  822, 1004, 1009, 2783,
			  819, 1049, 1089, 2783,  817,  983, 1040, 2783,  816, 1129,
			 1160, 1193,  797, 1225,  796,  393,  763,    0,  793,  781,
			  643,  779, 2783,  774, 1038, 1074, 1081,  740, 1233, 1264,

			 1295, 1326,  844,  700,  980,  755,  758,  673,    0,  702,
			  689,  750,  685, 1111,  707, 1114,  712,  643, 2783,  661,
			  664, 1077, 1155, 1151, 2783,  647,  597, 2783,  616, 1176,
			 2783,  611, 2783,  607, 1168, 2783,  595, 2783,  591, 1183,
			 2783,  582, 2783, 2783,  573, 1372,  723, 1219, 2783,  560,
			  523,    0,  512,  496, 1118,  481,  465,  461, 1398,  441,
			 1430,  437, 1437, 1216,  823,  849,  761,  422,  405, 1225,
			 1181, 1255, 2783,  365,  330,  728, 1286, 2783, 1284, 1295,
			 1317, 2783,  340,  342,  326,  705,  314, 2783,  250,    0,
			  254,  247, 1334,  238, 1468, 1326,  854, 2783,  240,  224, yy_Dummy>>,
			1, 200, 200)
		end

	yy_base_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_base'.
		do
			yy_array_subcopy (an_array, <<
			  214, 1355, 1360, 1358, 2783,  187,  192, 1422,  158,  151,
			  139, 1496,  788,  126, 2783, 2783,  118, 2783,   97,   76,
			   55,   52,   48, 2783, 1540, 1567, 1594, 1621, 1648, 1675,
			 1702, 1729, 1756, 1783, 1810, 1837, 1864, 1890, 1387, 1917,
			 1944, 1971, 1998, 2025, 2052, 2079, 2106, 2133, 2160, 2187,
			 2204, 2231, 2258, 1416, 2285, 2308, 2330, 2357, 2384, 2411,
			 1222, 1448, 1324, 2426,  883,  944, 2447, 1002, 1026, 2469,
			 2496, 1396, 1479, 2522, 2547, 1034, 1060, 2574, 1424, 1258,
			 2601, 1488, 1279, 1507, 1462, 1882, 1520, 2304, 2515, 2434,
			 2530, 2628, 2644, 2651, 2447, 2676, 2655, 2692, 2699, 2707,

			 2715, 2723, 2731, 2739, 2747, 2755, 2763, yy_Dummy>>,
			1, 107, 400)
		end

	yy_def_template: SPECIAL [INTEGER]
			-- Template for `yy_def'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 506)
			yy_def_template_1 (an_array)
			yy_def_template_2 (an_array)
			yy_def_template_3 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_def_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			    0,  423,    1,  424,  424,  425,  425,  426,  426,  427,
			  427,  428,  428,  429,  429,  430,  430,  431,  431,  432,
			  432,  423,  423,  423,  423,  423,  433,  434,  435,  436,
			  423,  423,  423,  423,   33,  423,  423,  423,  423,  423,
			  437,  437,  423,  438,  423,  423,  423,  423,  423,  439,
			  423,  423,  440,  423,  423,  423,  423,  423,  423,  423,
			  441,  441,  423,  441,  423,  442,  443,  423,  443,  423,
			  423,  423,  444,  444,  423,  444,  423,  445,  446,  423,
			  446,  423,  423,  423,  423,  433,  423,  447,  448,  433,
			  433,  434,  423,  449,  435,  423,  423,  450,  423,  423,

			  451,  423,  423,  423,  423,  452,   34,   35,  423,  423,
			  453,  423,  423,  423,  423,   41,   41,  438,  438,  423,
			  423,  423,  454,  439,  423,  455,  423,  423,  423,  423,
			  423,  439,  423,  423,  423,  423,  423,  423,  423,  441,
			  423,  441,  423,  441,  441,  442,  423,  442,  423,  443,
			  423,  443,  423,  423,  423,  444,  423,  444,  423,  444,
			  444,  445,  423,  445,  423,  446,  423,  446,  423,  456,
			  423,  423,  423,  447,  447,  448,  457,  458,  448,  448,
			  448,  433,  423,  433,  423,  423,  459,  423,  423,  423,
			  423,  423,  423,  423,  451,  423,  423,  423,  423,  460, yy_Dummy>>,
			1, 200, 0)
		end

	yy_def_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  461,  423,  423,  423,  423,  462,  423,  423,  423,  423,
			  423,  423,  453,  463,  423,  423,  111,   41,  423,  423,
			  423,  423,  454,  423,  423,  423,  464,  423,  465,  423,
			  423,  423,  423,  423,  456,  423,  423,  423,  466,  458,
			  458,  448,  241,  241,  241,  448,  448,  423,  423,  423,
			  423,  190,  467,  423,  468,  469,  470,  423,  460,  461,
			  423,  471,  472,  423,  462,  423,  423,  423,  423,  423,
			  423,  423,  423,  423,  423,  473,  463,  423,  423,  474,
			   41,  423,  475,  423,  476,  477,  225,  478,  465,  465,
			  465,  479,  423,  423,  423,  458,  458,  241,  241,  241,

			  241,  241,  448,  480,  423,  423,  423,  251,  481,  468,
			  468,  468,  482,  423,  469,  423,  470,  483,  423,  423,
			  484,  423,  471,  472,  423,  423,  485,  423,  423,  423,
			  423,  423,  423,  423,  271,  423,  423,  423,  423,  473,
			  423,  423,  423,  423,  423,  423,  486,  423,  423,  423,
			  281,  487,  476,  476,  423,  423,  488,  479,  423,  489,
			  423,  490,  241,  423,  480,  491,  423,  492,  482,  483,
			  423,  484,  423,  423,  493,  494,  485,  423,  423,  486,
			  423,  423,  423,  495,  496,  477,  497,  423,  358,  498,
			  490,  490,  423,  423,  362,  423,  491,  423,  423,  499, yy_Dummy>>,
			1, 200, 200)
		end

	yy_def_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_def'.
		do
			yy_array_subcopy (an_array, <<
			  423,  493,  423,  494,  423,  423,  495,  423,  500,  501,
			  502,  394,  423,  503,  423,  423,  423,  423,  504,  423,
			  505,  423,  506,    0,  423,  423,  423,  423,  423,  423,
			  423,  423,  423,  423,  423,  423,  423,  423,  423,  423,
			  423,  423,  423,  423,  423,  423,  423,  423,  423,  423,
			  423,  423,  423,  423,  423,  423,  423,  423,  423,  423,
			  423,  423,  423,  423,  423,  423,  423,  423,  423,  423,
			  423,  423,  423,  423,  423,  423,  423,  423,  423,  423,
			  423,  423,  423,  423,  423,  423,  423,  423,  423,  423,
			  423,  423,  423,  423,  423,  423,  423,  423,  423,  423,

			  423,  423,  423,  423,  423,  423,  423, yy_Dummy>>,
			1, 107, 400)
		end

	yy_ec_template: SPECIAL [INTEGER]
			-- Template for `yy_ec'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 256)
			yy_ec_template_1 (an_array)
			yy_ec_template_2 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_ec_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    2,
			    3,    1,    1,    4,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    2,    5,    6,    7,    5,    8,    9,   10,
			   11,   11,   12,   13,    5,   14,   15,   16,   17,   18,
			   19,   20,   20,   21,   22,   22,   23,   23,   24,    5,
			   25,   26,   27,   28,    9,   29,   30,   31,   29,   32,
			   29,   33,   34,   33,   33,   33,   34,   33,   35,   36,
			   33,   34,   34,   34,   34,   34,   34,   33,   37,   33,
			   33,   38,   39,   40,    5,   41,    1,   42,   43,   44,

			   42,   32,   42,   33,   45,   33,   33,   33,   45,   33,
			   46,   36,   33,   45,   45,   45,   45,   45,   45,   33,
			   47,   33,   33,   48,    9,   49,   50,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,   51,    1,    1,
			    1,   52,    1,    1,    1,    1,    1,    1,    1,    1, yy_Dummy>>,
			1, 200, 0)
		end

	yy_ec_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,   53,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1, yy_Dummy>>,
			1, 57, 200)
		end

	yy_meta_template: SPECIAL [INTEGER]
			-- Template for `yy_meta'
		once
			Result := yy_fixed_array (<<
			    0,    1,    2,    3,    4,    1,    5,    1,    6,    1,
			    7,    8,    1,    9,   10,   11,   12,   13,   13,   13,
			   13,   13,   14,   15,    1,   16,    1,   17,    1,   18,
			   18,   18,   19,   20,   21,   22,   23,   24,    1,    1,
			    1,   25,   19,   19,   19,   20,   26,   27,    1,    1,
			    1,    1,    1,    1, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER]
			-- Template for `yy_accept'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 424)
			yy_accept_template_1 (an_array)
			yy_accept_template_2 (an_array)
			yy_accept_template_3 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_accept_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    2,    3,    4,    5,    5,    5,    6,    7,
			    8,    9,   10,   12,   16,   19,   22,   25,   28,   31,
			   34,   37,   40,   43,   47,   51,   55,   58,   61,   64,
			   67,   71,   75,   77,   79,   81,   83,   87,   90,   92,
			   94,   96,   99,  101,  103,  105,  107,  110,  112,  114,
			  116,  118,  120,  122,  124,  126,  128,  130,  132,  134,
			  136,  138,  140,  142,  144,  146,  148,  150,  152,  154,
			  156,  158,  160,  160,  162,  162,  163,  167,  168,  168,
			  170,  172,  173,  174,  175,  176,  177,  178,  179,  181,

			  182,  183,  184,  188,  189,  189,  190,  192,  194,  196,
			  196,  196,  198,  200,  201,  201,  203,  205,  207,  207,
			  207,  209,  209,  210,  211,  213,  213,  214,  214,  215,
			  216,  217,  219,  221,  223,  223,  224,  225,  225,  226,
			  227,  228,  229,  230,  231,  232,  233,  235,  236,  239,
			  240,  241,  242,  244,  244,  245,  246,  247,  248,  249,
			  250,  251,  252,  254,  255,  258,  259,  260,  261,  263,
			  264,  266,  266,  272,  274,  276,  276,  277,  278,  278,
			  279,  280,  281,  282,  283,  284,  285,  286,  287,  288,
			  289,  291,  293,  293,  294,  295,  297,  297,  299,  299, yy_Dummy>>,
			1, 200, 0)
		end

	yy_accept_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  299,  299,  300,  302,  303,  307,  308,  309,  309,  311,
			  311,  313,  313,  315,  315,  316,  316,  318,  320,  321,
			  321,  322,  323,  324,  324,  324,  325,  326,  327,  328,
			  329,  329,  330,  330,  331,  332,  335,  335,  337,  337,
			  339,  341,  341,  341,  341,  341,  341,  341,  342,  344,
			  344,  345,  346,  347,  348,  349,  350,  351,  351,  355,
			  357,  358,  358,  358,  358,  362,  363,  363,  365,  367,
			  368,  368,  370,  372,  373,  373,  375,  377,  378,  378,
			  379,  381,  381,  381,  381,  381,  384,  385,  385,  386,
			  387,  388,  389,  390,  390,  390,  391,  392,  392,  392,

			  392,  392,  392,  392,  393,  395,  395,  396,  397,  397,
			  398,  399,  400,  401,  402,  403,  404,  405,  405,  406,
			  406,  406,  406,  414,  416,  418,  418,  418,  419,  419,
			  421,  422,  422,  423,  423,  425,  426,  426,  427,  427,
			  429,  430,  430,  431,  433,  434,  436,  437,  438,  439,
			  439,  439,  439,  439,  439,  439,  439,  439,  440,  440,
			  440,  440,  440,  440,  441,  442,  443,  445,  445,  446,
			  448,  448,  450,  454,  454,  454,  454,  456,  457,  457,
			  459,  459,  461,  461,  462,  462,  464,  464,  465,  465,
			  465,  465,  465,  465,  465,  465,  466,  467,  468,  468, yy_Dummy>>,
			1, 200, 200)
		end

	yy_accept_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_accept'.
		do
			yy_array_subcopy (an_array, <<
			  468,  469,  473,  473,  477,  478,  478,  478,  478,  478,
			  478,  478,  478,  479,  479,  480,  482,  482,  483,  483,
			  483,  483,  483,  483,  483, yy_Dummy>>,
			1, 25, 400)
		end

	yy_acclist_template: SPECIAL [INTEGER]
			-- Template for `yy_acclist'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 482)
			yy_acclist_template_1 (an_array)
			yy_acclist_template_2 (an_array)
			yy_acclist_template_3 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_acclist_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			    0,   49,   49,   52,   52,   61,   61,   64,   64,  130,
			  128,  129,  123,  124,  128,  129,  123,  124,  129,    2,
			  128,  129,   67,  128,  129,   14,  128,  129,   18,  128,
			  129,   36,  128,  129,    2,  128,  129,    2,  128,  129,
			    2,  128,  129,   85,  128,  129, -215,   85,  128,  129,
			 -215,   85,  128,  129, -215,    2,  128,  129,    2,  128,
			  129,    2,  128,  129,    2,  128,  129,   12,  128,  129,
			 -142,   12,  128,  129, -142,  128,  129,  128,  129,  128,
			  129,  127,  129,  125,  126,  127,  129,  125,  126,  129,
			  127,  129,   74,  129,   79,  129,   75,  129, -205,   78,

			  129,   82,  129,   82,  129,   81,  129,   80,   82,  129,
			   43,  129,   43,  129,   42,  129,   49,  129,   49,  129,
			   48,  129,   49,  129,   46,  129,   49,  129,   52,  129,
			   51,  129,   52,  129,   55,  129,   55,  129,   54,  129,
			   61,  129,   61,  129,   60,  129,   61,  129,   58,  129,
			   61,  129,   64,  129,   63,  129,   64,  129,  123,  124,
			    3,    4,   67,   39,   65, -169, -195,   67,   67, -182,
			   67, -170,   17,   19,   15,   18,   23,   36,   36,   35,
			   36,    3,  124,    6,  116,  122, -242, -248,  -86, -240,
			   85, -215,   85, -215,   83, -213,   91, -221,   83, -213, yy_Dummy>>,
			1, 200, 0)
		end

	yy_acclist_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			  -13,   12, -142,   12, -142,   89, -219,  125,  126,  126,
			   74,   75, -205,  -76,   77,   77,   68,   74,   77,   72,
			   77,   73,   77,   81,   80,   42,   49,   48,   49,   46,
			   49,   49,   49,   47,   48,   49,   44,   46, -174,   52,
			   51,   52,   50,   51,   54,   61,   60,   61,   58,   61,
			   61,   61,   59,   60,   61,   56,   58, -186,   64,   63,
			   64,   62,   63,    4,  -40,  -66,   37,   39,   65, -167,
			 -169, -195,   67, -182,   67, -170,   67,   67, -182, -170,
			   67,  -53,   67,  -41,   22,   16,   20,   24,   36,   34,
			   36,    3,    5,  124,  124,    7,    8, -113, -119,  114,

			 -111,  114,  114,  116,  122, -242, -248,  114,  -84,  105,
			 -235,   99, -229,   93, -223,  -92,   87, -217,   12, -142,
			  -90,    1,  126,  126,   71,   71,   71,   71,  -45,  -57,
			    4,    4,  -38,  -40,  -66,   65, -195,   67, -182,   67,
			 -170,   21,   25,   26,   27,   33,   33,   33,   33,    5,
			    8,  116,  122, -242, -248,  122, -248, -111,  115,  121,
			 -241, -247, -106,  109, -239,  107, -237, -100,  103, -233,
			  101, -231,  -94,   97, -227,   95, -225,  -88, -246,   12,
			 -142,   69,   70,   74,   71,   71,   71,   71,   71,  -66,
			   67,   67,   26,   28,   29,   36,   33,   33,   33,   33, yy_Dummy>>,
			1, 200, 200)
		end

	yy_acclist_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_acclist'.
		do
			yy_array_subcopy (an_array, <<
			   33,    5,    5,    8,    8, -119,  115,  116,  121,  122,
			 -241, -242, -247, -248,  122, -248, -112, -118, -110,  105,
			 -235, -108, -104,   99, -229, -102,  -98,   93, -223,  -96,
			  120, -117,  120,  120,  122, -248,  120,  -13,    9,   71,
			   26,   26,   29,   30,   32,   33,  122, -248,  122, -248,
			 -112, -113, -118, -119,  121, -247, -117,  121, -247,   10,
			   11,  -13,   69,   74,   70,   29,   29,   31,   36,  121,
			  122, -247, -248,  121,  122, -247, -248, -118,   30,   32,
			 -118, -119,   11, yy_Dummy>>,
			1, 83, 400)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER = 2783
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER = 423
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER = 424
			-- Mark between normal states and templates

	yyNull_equiv_class: INTEGER = 1
			-- Equivalence code for NULL character

	yyReject_used: BOOLEAN = false
			-- Is `reject' called?

	yyVariable_trail_context: BOOLEAN = true
			-- Is there a regular expression with
			-- both leading and trailing parts having
			-- variable length?

	yyReject_or_variable_trail_context: BOOLEAN = true
			-- Is `reject' called or is there a
			-- regular expression with both leading
			-- and trailing parts having variable length?

	yyNb_rules: INTEGER = 129
			-- Number of rules

	yyEnd_of_buffer: INTEGER = 130
			-- End of buffer rule code

	yyLine_used: BOOLEAN = true
			-- Are line and column numbers used?

	yyPosition_used: BOOLEAN = false
			-- Is `position' used?

	INITIAL: INTEGER = 0
	BREAK: INTEGER = 1
	MS: INTEGER = 2
	MSN: INTEGER = 3
	VS1: INTEGER = 4
	VS2: INTEGER = 5
	VS3: INTEGER = 6
	LAVS1: INTEGER = 7
	LAVS2: INTEGER = 8
	LAVS3: INTEGER = 9
			-- Start condition codes

feature -- User-defined features



feature -- Scanning

	read_token
			-- (NOTE: THIS IS THE COPY/PASTE VERSION OF THE CODE IN
			-- THE YY_COMPRESSED_SCANNER_SKELETON CLASS, FOR OPTIMISATION
			-- WITH ISE EIFFEL (ALLOW INLINING NOT POSSIBLE IN
			-- YY_COMPRESSED_SCANNER_SKELETON).)

			-- Read a token from `input_buffer'.
			-- Make result available in `last_token'.
		local
			yy_cp, yy_bp: INTEGER
			yy_current_state: INTEGER
			yy_next_state: INTEGER
			yy_matched_count: INTEGER
			yy_act: INTEGER
			yy_goto: INTEGER
			yy_c: INTEGER
			yy_found: BOOLEAN
			yy_rejected_line: INTEGER
			yy_rejected_column: INTEGER
			yy_rejected_position: INTEGER
			yy_done: BOOLEAN
			l_content_area: like yy_content_area
		do
				-- This routine is implemented with a loop whose body
				-- is a big inspect instruction. This is a mere
				-- translation of C gotos into Eiffel. Needless to
				-- say that I'm not very proud of this piece of code.
				-- However I performed some benchmarks and the results
				-- were that this implementation runs amazingly faster
				-- than an alternative implementation with no loop nor
				-- inspect instructions and where every branch of the
				-- old inspect instruction was written in a separate
				-- routine. I think that the performance penalty is due
				-- to the routine call overhead and the depth of the call
				-- stack. Anyway, I prefer to provide you with a big and
				-- ugly but fast scanning routine rather than a nice and
				-- slow version. I hope you won't blame me for that! :-)
			from
				last_token := yyUnknown_token
				yy_goto := yyNext_token
			until
				last_token /= yyUnknown_token
			loop
				inspect yy_goto
				when yyNext_token then
					if yy_more_flag then
						yy_more_len := yy_end - yy_start
						yy_more_flag := False
					else
						yy_more_len := 0
						line := yy_line
						column := yy_column
						position := yy_position
					end
					yy_cp := yy_end
						-- `yy_bp' is the position of the first
						-- character of the current token.
					yy_bp := yy_cp
						-- Find the start state.
--	START INLINING 'yy_at_beginning_of_line'
--					yy_current_state := yy_start_state + yy_at_beginning_of_line
					if input_buffer.beginning_of_line then
						yy_current_state := yy_start_state + 1
					else
						yy_current_state := yy_start_state
					end
--	END INLINING 'yy_at_beginning_of_line'
					if yyReject_or_variable_trail_context then
							-- Set up for storing up states.
						SPECIAL_INTEGER_.force (yy_state_stack, yy_current_state, 0)
						yy_state_count := 1
					end
					yy_goto := yyMatch
				when yyMatch then
						-- Find the next match.
					l_content_area := yy_content_area
					from
						yy_done := False
					until
						yy_done
					loop
						if attached yy_ec as l_yy_ec then
							if l_content_area /= Void then
								yy_c := l_yy_ec.item (l_content_area.item (yy_cp).code)
							else
								yy_c := l_yy_ec.item (yy_content.item (yy_cp).code)
							end
						else
							if l_content_area /= Void then
								yy_c := l_content_area.item (yy_cp).code
							else
								yy_c := yy_content.item (yy_cp).code
							end
						end
						if not yyReject_or_variable_trail_context and then yy_accept.item (yy_current_state) /= 0 then
								-- Save the backing-up info before computing
								-- the next state because we always compute one
								-- more state than needed - we always proceed
								-- until we reach a jam state.
							yy_last_accepting_state := yy_current_state
							yy_last_accepting_cpos := yy_cp
						end
						from
						until
							yy_chk.item (yy_base.item (yy_current_state) + yy_c) = yy_current_state
						loop
							yy_current_state := yy_def.item (yy_current_state)
							if attached yy_meta as l_yy_meta and then yy_current_state >= yyTemplate_mark then
									-- We've arranged it so that templates are
									-- never chained to one another. This means
									-- we can afford to make a very simple test
									-- to see if we need to convert to `yy_c''s
									-- meta-equivalence class without worrying
									-- about erroneously looking up the meta
									-- equivalence class twice.
								yy_c := l_yy_meta.item (yy_c)
							end
						end
						yy_current_state := yy_nxt.item (yy_base.item (yy_current_state) + yy_c)
						if yyReject_or_variable_trail_context then
							SPECIAL_INTEGER_.force (yy_state_stack, yy_current_state, yy_state_count)
							yy_state_count := yy_state_count + 1
						end
						yy_cp := yy_cp + 1
						yy_done := (yy_current_state = yyJam_state)
					end
					if not yyReject_or_variable_trail_context then
							-- Do the guaranteed-needed backing up
							-- to find out the match.
						yy_cp := yy_last_accepting_cpos
						yy_current_state := yy_last_accepting_state
					end
					yy_goto := yyFind_action
				when yyFind_action then
						-- Find the action number.
					if not yyReject_or_variable_trail_context then
						yy_act := yy_accept.item (yy_current_state)
						yy_goto := yyDo_action
					else
						yy_state_count := yy_state_count - 1
						yy_current_state := yy_state_stack.item (yy_state_count)
						yy_lp := yy_accept.item (yy_current_state)
						yy_goto := yyFind_rule
					end
				when yyFind_rule then
						-- We branch here when backing up.
					check
						reject_used: yyReject_or_variable_trail_context
						yy_acclist_not_void: attached yy_acclist as l_yy_acclist
					then
						from
							yy_found := False
						until
							yy_found
						loop
							if yy_lp /= 0 and yy_lp < yy_accept.item (yy_current_state + 1) then
								yy_act := l_yy_acclist.item (yy_lp)
								if yyVariable_trail_context then
									if yy_act < -yyNb_rules or yy_looking_for_trail_begin /= 0 then
										if yy_act = yy_looking_for_trail_begin then
											yy_looking_for_trail_begin := 0
											yy_act := -yy_act - yyNb_rules
											yy_found := True
										else
											yy_lp := yy_lp + 1
										end
									elseif yy_act < 0 then
										yy_looking_for_trail_begin := yy_act - yyNb_rules
										if yyReject_used then
												-- Remember matched text in case
												-- we back up due to `reject'.
											yy_full_match := yy_cp
											yy_full_state := yy_state_count
											yy_full_lp := yy_lp
										end
										yy_lp := yy_lp + 1
									else
										yy_full_match := yy_cp
										yy_full_state := yy_state_count
										yy_full_lp := yy_lp
										yy_found := True
									end
								else
									yy_full_match := yy_cp
									yy_found := True
								end
							else
								yy_cp := yy_cp - 1
								yy_state_count := yy_state_count - 1
								yy_current_state := yy_state_stack.item (yy_state_count)
								yy_lp := yy_accept.item (yy_current_state)
							end
						end
						yy_rejected_line := yy_line
						yy_rejected_column := yy_column
						yy_rejected_position := yy_position
						yy_goto := yyDo_action
					end
				when yyDo_action then
						-- Set up `text' before action.
					yy_bp := yy_bp - yy_more_len
					yy_start := yy_bp
					yy_end := yy_cp
					debug ("GELEX")
					end
					yy_goto := yyNext_token
						-- Semantic actions.
					if yy_act = 0 then
							-- Must back up.
						if not yyReject_or_variable_trail_context then
								-- Backing-up info for compressed tables is
								-- taken after `yy_cp' has been incremented
								-- for the next state.
							yy_cp := yy_last_accepting_cpos
							yy_bp := yy_bp + yy_more_len
							yy_current_state := yy_last_accepting_state
							yy_goto := yyFind_action
						else
							last_token := yyError_token
							fatal_error ("fatal scanner internal error: no action found")
						end
					elseif yy_act = yyEnd_of_buffer then
							-- Amount of text matched not including
							-- the EOB character.
						yy_matched_count := yy_cp - yy_bp - 1
							-- Note that here we test for `yy_end' "<="
							-- to the position of the first EOB in the buffer,
							-- since `yy_end' will already have been
							-- incremented past the NULL character (since all
							-- states make transitions on EOB to the
							-- end-of-buffer state). Contrast this with the
							-- test in `read_character'.
						if yy_end <= input_buffer.count + 1 then
								-- This was really a NULL character.
							yy_end := yy_bp + yy_matched_count
							yy_current_state := yy_previous_state
								-- We're now positioned to make the NULL
								-- transition. We couldn't have
								-- `yy_previous_state' go ahead and do it
								-- for us because it doesn't know how to deal
								-- with the possibility of jamming (and we
								-- don't want to build jamming into it because
								-- then it will run more slowly).
							yy_next_state := yy_null_trans_state (yy_current_state)
							yy_bp := yy_bp + yy_more_len
							if yy_next_state /= 0 then
									-- Consume the NULL character.
								yy_cp := yy_end + 1
								yy_end := yy_cp
								yy_current_state := yy_next_state
								yy_goto := yyMatch
							else
								if yyReject_or_variable_trail_context then
										-- Still need to initialize `yy_cp',
										-- though `yy_current_state' was set
										-- up by `yy_previous_state'.
									yy_cp := yy_end
										-- Remove the state which was inserted
										-- in `yy_state_stack' by the call to
										-- `yy_null_trans_state'.
									yy_state_count := yy_state_count - 1
								else
										-- Do the guaranteed-needed backing up
										-- then figure out the match.
									yy_cp := yy_last_accepting_cpos
									yy_current_state := yy_last_accepting_state
								end
								yy_goto := yyFind_action
							end
						else
								-- Do not take the EOB character
								-- into account.
							yy_end := yy_end - 1
							yy_refill_input_buffer
							if input_buffer.filled then
								yy_current_state := yy_previous_state
								yy_cp := yy_end
								yy_bp := yy_start + yy_more_len
								yy_goto := yyMatch
							elseif yy_end - yy_start - yy_more_len /= 0 then
									-- Some text has been matched prior to
									-- the EOB. First process it.
								yy_current_state := yy_previous_state
								yy_cp := yy_end
								yy_bp := yy_start + yy_more_len
								yy_goto := yyFind_action
							else
									-- Only the EOB character has been matched,
									-- so treat this as a final EOF.
								if wrap then
									yy_bp := yy_start
									yy_cp := yy_end
									yy_execute_eof_action ((yy_start_state - 1) // 2)
								end
							end
						end
					else
						yy_execute_action (yy_act)
						if yy_rejected then
							yy_rejected := False
							yy_line := yy_rejected_line
							yy_column := yy_rejected_column
							yy_position := yy_rejected_position
								-- Restore position backed-over text.
							yy_cp := yy_full_match
							if yyVariable_trail_context then
									-- Restore original accepting position.
								yy_lp := yy_full_lp
									-- Restore original state.
								yy_state_count := yy_full_state
									-- Restore current state.
								yy_current_state := yy_state_stack.item (yy_state_count - 1)
							end
							yy_lp := yy_lp + 1
							yy_goto := yyFind_rule
						end
					end
				end
			end
			debug ("GELEX")
				print_last_token
			end
		end

end
