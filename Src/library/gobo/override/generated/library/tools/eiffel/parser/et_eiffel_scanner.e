note

	description:

		"Scanners for Eiffel parsers"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 1999-2012, Eric Bezault and others"
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
if yy_act <= 65 then
if yy_act <= 33 then
if yy_act <= 17 then
if yy_act <= 9 then
if yy_act <= 5 then
if yy_act <= 3 then
if yy_act <= 2 then
if yy_act = 1 then
	yy_column := yy_column + 3
--|#line 39 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 39")
end

				-- Ignore byte order mark (BOM).
				-- See http://en.wikipedia.org/wiki/Byte_order_mark
			
else
	yy_column := yy_column + 1
--|#line 47 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 47")
end

				last_break_end := 0
				last_comment_end := 0
				process_one_char_symbol (text_item (1))
			
end
else
yy_set_line_column
--|#line 52 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 52")
end

				last_text_count := 1
				last_break_end := text_count
				last_comment_end := 0
				process_one_char_symbol (text_item (1))
			
end
else
if yy_act = 4 then
yy_set_line_column
--|#line 58 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 58")
end

				last_text_count := 1
				last_break_end := 0
				last_comment_end := text_count
				process_one_char_symbol (text_item (1))
			
else
yy_set_line_column
--|#line 64 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 64")
end

				last_text_count := 1
				last_break_end := 0
				last_comment_end := text_count
				process_one_char_symbol ('-')
			
end
end
else
if yy_act <= 7 then
if yy_act = 6 then
	yy_column := yy_column + 2
--|#line 70 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 70")
end

				last_break_end := 0
				last_comment_end := 0
				process_two_char_symbol (text_item (1), text_item (2))
			
else
yy_set_line_column
--|#line 75 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 75")
end

				last_text_count := 2
				last_break_end := text_count
				last_comment_end := 0
				process_two_char_symbol (text_item (1), text_item (2))
			
end
else
if yy_act = 8 then
yy_set_line_column
--|#line 81 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 81")
end

				last_text_count := 2
				last_break_end := 0
				last_comment_end := text_count
				process_two_char_symbol (text_item (1), text_item (2))
			
else
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
				last_et_keyword_value := ast_factory.new_once_keyword (Current)
			
end
end
end
else
if yy_act <= 13 then
if yy_act <= 11 then
if yy_act = 10 then
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
				last_et_keyword_value := ast_factory.new_once_keyword (Current)
			
else
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
				last_et_keyword_value := ast_factory.new_once_keyword (Current)
			
end
else
if yy_act = 12 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 151 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 151")
end

				last_break_end := 0
				last_comment_end := 0
				process_identifier (text_count)
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 156 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 156")
end

				last_text_count := text_count
				break_kind := identifier_break
				more
				set_start_condition (BREAK)
			
end
end
else
if yy_act <= 15 then
if yy_act = 14 then
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
				last_et_free_operator_value := ast_factory.new_free_operator (Current)
			
else
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
				last_et_free_operator_value := ast_factory.new_free_operator (Current)
			
end
else
if yy_act = 16 then
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
				last_et_free_operator_value := ast_factory.new_free_operator (Current)
			
else
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
				last_et_free_operator_value := ast_factory.new_free_operator (Current)
			
end
end
end
end
else
if yy_act <= 25 then
if yy_act <= 21 then
if yy_act <= 19 then
if yy_act = 18 then
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
				last_et_free_operator_value := ast_factory.new_free_operator (Current)
			
else
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
			
end
else
if yy_act = 20 then
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
			
else
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
			
end
end
else
if yy_act <= 23 then
if yy_act = 22 then
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
			
else
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
			
end
else
if yy_act = 24 then
	yy_column := yy_column + 3
--|#line 201 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 201")
end

				last_break_end := 0
				last_comment_end := 0
				process_c1_character_constant (text_item (2))
			
else
yy_set_line_column
--|#line 206 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 206")
end

				last_text_count := 3
				last_break_end := text_count
				last_comment_end := 0
				process_c1_character_constant (text_item (2))
			
end
end
end
else
if yy_act <= 29 then
if yy_act <= 27 then
if yy_act = 26 then
yy_set_line_column
--|#line 212 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 212")
end

				last_text_count := 3
				last_break_end := 0
				last_comment_end := text_count
				process_c1_character_constant (text_item (2))
			
else
	yy_column := yy_column + 4
--|#line 218 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 218")
end

				last_break_end := 0
				last_comment_end := 0
				process_c2_character_constant (text_item (3))
			
end
else
if yy_act = 28 then
yy_set_line_column
--|#line 223 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 223")
end

				last_text_count := 4
				last_break_end := text_count
				last_comment_end := 0
				process_c2_character_constant (text_item (3))
			
else
yy_set_line_column
--|#line 229 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 229")
end

				last_text_count := 4
				last_break_end := 0
				last_comment_end := text_count
				process_c2_character_constant (text_item (3))
			
end
end
else
if yy_act <= 31 then
if yy_act = 30 then
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
				last_et_character_constant_value := ast_factory.new_c3_character_constant (Current)
			
else
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
			
end
else
if yy_act = 32 then
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
				last_et_position_value := current_position
				column := column - text_count
				last_token := E_CHARERR
			
else
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
				last_et_position_value := current_position
				column := column - text_count
				last_token := E_CHARERR
			
end
end
end
end
end
else
if yy_act <= 49 then
if yy_act <= 41 then
if yy_act <= 37 then
if yy_act <= 35 then
if yy_act = 34 then
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
				last_et_position_value := current_position
				column := column - 3
				last_token := E_CHARERR
			
else
	yy_column := yy_column + 2
--|#line 283 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 283")
end

					-- Syntax error: missing character between quotes.
				column := column + 1
				set_syntax_error
				error_handler.report_SCQQ_error (filename, current_position)
				last_et_position_value := current_position
				column := column - 1
				last_token := E_CHARERR
			
end
else
if yy_act = 36 then
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
				last_et_position_value := current_position
				column := column - text_count
				last_token := E_CHARERR
			
else
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
				last_et_manifest_string_value := ast_factory.new_regular_manifest_string (Current)
			
end
end
else
if yy_act <= 39 then
if yy_act = 38 then
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
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 323 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 323")
end

					-- Regular manifest string.
				last_break_end := 0
				last_comment_end := 0
				process_regular_manifest_string (text_count)
			
end
else
if yy_act = 40 then
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
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 337 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 337")
end

					-- Verbatim string.
				verbatim_marker := text_substring (2, text_count - 1)
				set_start_condition (VS1)
			
end
end
end
else
if yy_act <= 45 then
if yy_act <= 43 then
if yy_act = 42 then
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
			
else
	yy_column := yy_column + 1
--|#line 351 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 351")
end

					-- No final brace-double-quote.
				last_token := E_STRERR
				last_et_position_value := current_position
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
end
else
if yy_act = 44 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 369 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 369")
end

				if is_verbatim_string_closer (last_literal_end + 1, text_count - 1) then
					last_token := E_STRING
					last_break_end := 0
					last_comment_end := 0
					last_et_manifest_string_value := ast_factory.new_verbatim_string (verbatim_marker, verbatim_open_white_characters,
						text_substring (last_literal_end + 1, text_count - verbatim_marker.count - 2), False, Current)
					verbatim_marker := Void
					verbatim_open_white_characters := Void
					set_start_condition (INITIAL)
				else
					more
					set_start_condition (VS3)
				end
			
else
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
			
end
end
else
if yy_act <= 47 then
if yy_act = 46 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 396 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 396")
end

				more
				set_start_condition (VS3)
			
else
	yy_line := yy_line + 1
	yy_column := 1
--|#line 400 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 400")
end

				more
				last_literal_end := text_count - 2
			
end
else
if yy_act = 48 then
	yy_line := yy_line + 1
	yy_column := 1
--|#line 404 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 404")
end

				more
				last_literal_end := text_count - 1
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 408 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 408")
end

					-- No final brace-double-quote.
				last_token := E_STRERR
				last_et_position_value := current_position
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
end
end
end
end
else
if yy_act <= 57 then
if yy_act <= 53 then
if yy_act <= 51 then
if yy_act = 50 then
	yy_line := yy_line + 1
	yy_column := 1
--|#line 426 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 426")
end

				more
				last_literal_end := text_count - 2
				set_start_condition (VS2)
			
else
	yy_line := yy_line + 1
	yy_column := 1
--|#line 431 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 431")
end

				more
				last_literal_end := text_count - 1
				set_start_condition (VS2)
			
end
else
if yy_act = 52 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 436 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 436")
end

					-- No final brace-double-quote.
				last_token := E_STRERR
				last_et_position_value := current_position
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 452 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 452")
end

					-- Left-aligned verbatim string.
				verbatim_marker := text_substring (2, text_count - 1)
				set_start_condition (LAVS1)
			
end
end
else
if yy_act <= 55 then
if yy_act = 54 then
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
			
else
	yy_column := yy_column + 1
--|#line 466 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 466")
end

					-- No final bracket-double-quote.
				last_token := E_STRERR
				last_et_position_value := current_position
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
end
else
if yy_act = 56 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 484 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 484")
end

				if is_verbatim_string_closer (last_literal_end + 1, text_count - 1) then
					last_token := E_STRING
					last_break_end := 0
					last_comment_end := 0
					last_et_manifest_string_value := ast_factory.new_verbatim_string (verbatim_marker, verbatim_open_white_characters,
						text_substring (last_literal_end + 1, text_count - verbatim_marker.count - 2), True, Current)
					verbatim_marker := Void
					verbatim_open_white_characters := Void
					set_start_condition (INITIAL)
				else
					more
					set_start_condition (LAVS3)
				end
			
else
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
			
end
end
end
else
if yy_act <= 61 then
if yy_act <= 59 then
if yy_act = 58 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 511 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 511")
end

				more
				set_start_condition (LAVS3)
			
else
	yy_line := yy_line + 1
	yy_column := 1
--|#line 515 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 515")
end

				more
				last_literal_end := text_count - 2
			
end
else
if yy_act = 60 then
	yy_line := yy_line + 1
	yy_column := 1
--|#line 519 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 519")
end

				more
				last_literal_end := text_count - 1
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 523 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 523")
end

					-- No final bracket-double-quote.
				last_token := E_STRERR
				last_et_position_value := current_position
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
end
end
else
if yy_act <= 63 then
if yy_act = 62 then
	yy_line := yy_line + 1
	yy_column := 1
--|#line 541 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 541")
end

				more
				last_literal_end := text_count - 2
				set_start_condition (LAVS2)
			
else
	yy_line := yy_line + 1
	yy_column := 1
--|#line 546 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 546")
end

				more
				last_literal_end := text_count - 1
				set_start_condition (LAVS2)
			
end
else
if yy_act = 64 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 551 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 551")
end

					-- No final bracket-double-quote.
				last_token := E_STRERR
				last_et_position_value := current_position
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
else
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
				last_et_manifest_string_value := ast_factory.new_special_manifest_string (Current)
			
end
end
end
end
end
end
else
if yy_act <= 97 then
if yy_act <= 81 then
if yy_act <= 73 then
if yy_act <= 69 then
if yy_act <= 67 then
if yy_act = 66 then
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
			
else
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
			
end
else
if yy_act = 68 then
	yy_line := yy_line + 1
	yy_column := 1
--|#line 596 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 596")
end

					-- Multi-line manifest string.
				more
				set_start_condition (MSN)
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 601 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 601")
end

				more
			
end
end
else
if yy_act <= 71 then
if yy_act = 70 then
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
				last_et_position_value := current_position
				column := ms_column
				line := ms_line
				last_token := E_STRERR
				set_start_condition (INITIAL)
			
else
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
				last_et_position_value := current_position
				column := ms_column
				line := ms_line
				last_token := E_STRERR
				set_start_condition (INITIAL)
			
end
else
if yy_act = 72 then
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
				last_et_position_value := current_position
				column := ms_column
				line := ms_line
				last_token := E_STRERR
				set_start_condition (INITIAL)
			
else
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
			
end
end
end
else
if yy_act <= 77 then
if yy_act <= 75 then
if yy_act = 74 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 655 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 655")
end

				more
			
else
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
				last_et_manifest_string_value := ast_factory.new_special_manifest_string (Current)
				set_start_condition (INITIAL)
			
end
else
if yy_act = 76 then
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
			
else
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
			
end
end
else
if yy_act <= 79 then
if yy_act = 78 then
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
				last_et_position_value := current_position
				column := ms_column
				line := ms_line
				last_token := E_STRERR
				set_start_condition (INITIAL)
			
else
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
				last_et_position_value := current_position
				column := ms_column
				line := ms_line
				last_token := E_STRERR
				set_start_condition (INITIAL)
			
end
else
if yy_act = 80 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 727 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 727")
end

				more
				set_start_condition (MS)
			
else
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
			
end
end
end
end
else
if yy_act <= 89 then
if yy_act <= 85 then
if yy_act <= 83 then
if yy_act = 82 then
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
				last_et_position_value := current_position
				column := ms_column
				line := ms_line
				last_token := E_STRERR
				set_start_condition (INITIAL)
			
else
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
				last_et_bit_constant_value := ast_factory.new_bit_constant (Current)
			
end
else
if yy_act = 84 then
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
			
else
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
				last_et_integer_constant_value := ast_factory.new_regular_integer_constant (Current)
			
end
end
else
if yy_act <= 87 then
if yy_act = 86 then
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
			
else
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
				last_et_integer_constant_value := ast_factory.new_underscored_integer_constant (Current)
			
end
else
if yy_act = 88 then
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
			
else
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
				last_et_integer_constant_value := ast_factory.new_underscored_integer_constant (Current)
			
end
end
end
else
if yy_act <= 93 then
if yy_act <= 91 then
if yy_act = 90 then
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
			
else
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
				last_et_integer_constant_value := ast_factory.new_underscored_integer_constant (Current)
			
end
else
if yy_act = 92 then
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
			
else
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
				last_et_integer_constant_value := ast_factory.new_hexadecimal_integer_constant (Current)
			
end
end
else
if yy_act <= 95 then
if yy_act = 94 then
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
			
else
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
				last_et_integer_constant_value := ast_factory.new_hexadecimal_integer_constant (Current)
			
end
else
if yy_act = 96 then
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
			
else
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
				last_et_integer_constant_value := ast_factory.new_hexadecimal_integer_constant (Current)
			
end
end
end
end
end
else
if yy_act <= 113 then
if yy_act <= 105 then
if yy_act <= 101 then
if yy_act <= 99 then
if yy_act = 98 then
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
			
else
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
				last_et_integer_constant_value := ast_factory.new_octal_integer_constant (Current)
			
end
else
if yy_act = 100 then
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
			
else
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
				last_et_integer_constant_value := ast_factory.new_octal_integer_constant (Current)
			
end
end
else
if yy_act <= 103 then
if yy_act = 102 then
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
			
else
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
				last_et_integer_constant_value := ast_factory.new_octal_integer_constant (Current)
			
end
else
if yy_act = 104 then
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
			
else
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
				last_et_integer_constant_value := ast_factory.new_binary_integer_constant (Current)
			
end
end
end
else
if yy_act <= 109 then
if yy_act <= 107 then
if yy_act = 106 then
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
			
else
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
				last_et_integer_constant_value := ast_factory.new_binary_integer_constant (Current)
			
end
else
if yy_act = 108 then
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
			
else
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
				last_et_integer_constant_value := ast_factory.new_binary_integer_constant (Current)
			
end
end
else
if yy_act <= 111 then
if yy_act = 110 then
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
			
else
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
			
end
else
if yy_act = 112 then
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
			
else
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
			
end
end
end
end
else
if yy_act <= 121 then
if yy_act <= 117 then
if yy_act <= 115 then
if yy_act = 114 then
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
				last_et_real_constant_value := ast_factory.new_regular_real_constant (Current)
			
else
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
				last_et_real_constant_value := ast_factory.new_regular_real_constant (Current)
			
end
else
if yy_act = 116 then
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
				last_et_real_constant_value := ast_factory.new_regular_real_constant (Current)
			
else
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
			
end
end
else
if yy_act <= 119 then
if yy_act = 118 then
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
			
else
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
			
end
else
if yy_act = 120 then
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
				last_et_real_constant_value := ast_factory.new_underscored_real_constant (Current)
			
else
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
				last_et_real_constant_value := ast_factory.new_underscored_real_constant (Current)
			
end
end
end
else
if yy_act <= 125 then
if yy_act <= 123 then
if yy_act = 122 then
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
				last_et_real_constant_value := ast_factory.new_underscored_real_constant (Current)
			
else
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
				last_et_break_value := ast_factory.new_break (Current)
				last_token := E_BREAK
			
end
else
if yy_act = 124 then
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
				last_et_break_value := ast_factory.new_comment (Current)
				last_token := E_BREAK
			
else
yy_set_line_column
--|#line 1140 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1140")
end

				last_break_end := text_count
				last_comment_end := 0
				process_break
				set_start_condition (INITIAL)
			
end
end
else
if yy_act <= 127 then
if yy_act = 126 then
yy_set_line_column
--|#line 1146 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1146")
end

				last_break_end := 0
				last_comment_end := text_count
				process_break
				set_start_condition (INITIAL)
			
else
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
			
end
else
if yy_act = 128 then
	yy_column := yy_column + 1
--|#line 1173 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1173")
end

				last_token := E_UNKNOWN
				last_et_position_value := current_position
			
else
yy_set_line_column
--|#line 0 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 0")
end
last_token := yyError_token
fatal_error ("scanner jammed")
end
end
end
end
end
end
end
		end

	yy_execute_eof_action (yy_sc: INTEGER)
			-- Execute EOF semantic action.
		do
			inspect yy_sc
when 0 then
--|#line 0 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 0")
end
terminate
when 1 then
--|#line 0 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 0")
end

					-- Should never happen.
				last_break_end := 0
				last_comment_end := 0
				process_break
				set_start_condition (INITIAL)
			
when 2 then
--|#line 0 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 0")
end

					-- Syntax error: missing double quote at
					-- end of manifest string.
				column := yy_column
				line := yy_line
				set_syntax_error
				error_handler.report_SSEQ_error (filename, current_position)
				last_et_position_value := current_position
				column := ms_column
				line := ms_line
				last_token := E_STRERR
				set_start_condition (INITIAL)
			
when 3 then
--|#line 0 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 0")
end

					-- Syntax error: missing character % at beginning
					-- of line in multi-line manifest string.
				column := yy_column
				line := yy_line
				set_syntax_error
				error_handler.report_SSNP_error (filename, current_position)
				last_et_position_value := current_position
				column := ms_column
				line := ms_line
				last_token := E_STRERR
				set_start_condition (INITIAL)
			
when 4 then
--|#line 0 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 0")
end

					-- No final brace-double-quote.
				last_token := E_STRERR
				last_et_position_value := current_position
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
when 5 then
--|#line 0 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 0")
end

					-- No final brace-double-quote.
				last_token := E_STRERR
				last_et_position_value := current_position
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
when 6 then
--|#line 0 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 0")
end

					-- No final brace-double-quote.
				last_token := E_STRERR
				last_et_position_value := current_position
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
when 7 then
--|#line 0 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 0")
end

					-- No final bracket-double-quote.
				last_token := E_STRERR
				last_et_position_value := current_position
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
when 8 then
--|#line 0 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 0")
end

					-- No final bracket-double-quote.
				last_token := E_STRERR
				last_et_position_value := current_position
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
when 9 then
--|#line 0 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 0")
end

					-- No final bracket-double-quote.
				last_token := E_STRERR
				last_et_position_value := current_position
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
			else
				terminate
			end
		end

feature {NONE} -- Table templates

	yy_nxt_template: SPECIAL [INTEGER]
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 2438)
			yy_nxt_template_1 (an_array)
			yy_nxt_template_2 (an_array)
			yy_nxt_template_3 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_nxt_template_1 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			    0,   22,   23,   24,   23,   25,   26,   27,   22,   28,
			   29,   25,   25,   25,   30,   31,   32,   33,   34,   35,
			   35,   35,   35,   35,   36,   37,   25,   38,   39,   40,
			   40,   40,   40,   40,   40,   40,   41,   40,   25,   42,
			   25,   43,   40,   40,   40,   40,   40,   25,   25,   25,
			   22,   22,   44,   46,   47,   46,   46,   47,   46,   50,
			   67,   68,   51,  390,   52,   48,   50,  388,   48,   51,
			  385,   52,   54,   55,   54,   54,   55,   54,   56,   67,
			   68,   56,   58,   59,   58,   58,   59,   58,   61,   62,
			   63,  389,   64,   61,   62,   63,  193,   64,   70,   71,

			   70,   70,   71,   70,   73,   74,   75,  194,   76,   73,
			   74,   75,  176,   76,   79,   80,   79,   80,   81,   81,
			   81,   81,   81,   81,   83,   83,   83,   95,   95,   95,
			   82,  150,  151,   82,   65,   97,   84,   98,  124,   65,
			  125,  176,   77,   86,   87,   88,   87,   77,   92,   92,
			   92,   99,   99,   99,  176,  112,  393,  388,   93,   93,
			   93,  387,  393,  100,  363,   83,   83,   83,  112,  393,
			   83,   83,   83,  152,  151,   89,  101,   84,  361,  101,
			  140,  141,   84,  142,   90,   83,   83,   83,  115,  101,
			  134,  135,  134,  124,  101,  125,  136,   84,  101,  115,

			  102,  102,  102,  102,  102,  102,  102,  113,  113,  113,
			  166,  167,  101,  103,  103,  103,  137,  138,  137,  114,
			  143,  140,  144,  381,  142,  104,  105,  176,  106,  106,
			  107,  107,  107,  107,  107,  168,  167,   83,   83,   83,
			  176,  108,  109,  140,  147,  124,  148,  125,  110,   84,
			  156,  157,  111,  158,  108,  109,  103,  103,  103,  221,
			  101,  101,  153,  154,  153,  237,  145,  238,  104,  105,
			  222,  107,  107,  107,  107,  107,  107,  107,   83,   83,
			   83,   83,   83,   83,  113,  113,  113,  120,  120,  120,
			   84,  156,  163,   84,  164,  111,  114,  140,  141,  121,

			  142,  373,  101,  101,  233,  101,  120,  120,  120,  126,
			  126,  126,  159,  156,  160,  234,  158,  116,  121,  150,
			  151,  127,  143,  146,  144,  193,  142,  123,  116,  129,
			  130,  129,  124,  131,  125,  131,  194,  131,  131,  123,
			  159,  162,  160,  132,  158,  152,  151,   81,   81,   81,
			  161,   86,  131,   88,  131,  123,  131,  131,  131,   82,
			  372,  131,  131,   83,   83,   83,  166,  167,  145,  133,
			  133,  133,  133,  133,  366,   84,  168,  167,  161,  170,
			  170,  170,   85,   89,   85,  217,  172,  334,   88,  115,
			  331,  171,   90,  257,  257,  181,  182,  181,  217,   86,

			  115,   88,  393,  183,  184,  183,  329,   86,  302,   88,
			  185,  185,  185,  187,  187,  187,  263,  263,  173,   95,
			   95,   95,  191,  191,  191,  315,  315,  174,  176,  326,
			  177,   89,  177,  177,  192,  224,  130,  224,  178,   89,
			   90,  324,  195,  195,  195,  359,  359,  177,   90,  177,
			  321,  177,  177,  177,  196,  320,  177,  177,  146,  141,
			  179,  142,  206,  206,  206,  137,  138,  137,  221,  180,
			  197,  197,  197,  233,  207,  268,  268,  208,  208,  222,
			  140,  147,  198,  148,  234,  102,  102,  102,  102,  102,
			  102,  102,  210,  210,  210,  210,  210,  210,  318,  209,

			  199,  209,  206,  206,  206,  218,  218,  218,  312,  200,
			  202,  202,  202,  311,  207,  302,  211,  219,  134,  135,
			  134,  307,  203,  302,  136,  204,  204,  204,  204,  204,
			  204,  204,  308,  120,  120,  120,  126,  126,  126,  302,
			  205,  214,  214,  214,  118,  121,  146,  147,  127,  148,
			  143,  140,  144,  215,  142,  356,  216,  216,  216,  216,
			  216,  216,  216,  225,  226,  227,  228,  228,  228,  228,
			  143,  146,  144,  393,  142,  229,  229,  229,  367,  367,
			  111,  153,  154,  153,  355,  156,  157,  230,  158,  162,
			  157,  290,  158,  159,  156,  160,  145,  158,  159,  162,

			  160,  285,  158,  156,  163,  179,  164,  162,  163,  285,
			  164,  231,  231,  231,  180,  285,  145,  235,  235,  235,
			  181,  182,  181,  232,  172,  237,   88,   88,  123,  236,
			  123,  161,  309,  183,  184,  183,  161,  172,  277,   88,
			  245,  182,  245,  310,  393,  273,  248,  248,  248,  191,
			  191,  191,  193,  193,  193,  269,  173,  239,  249,  280,
			  265,  192,  115,  262,   82,  174,  240,  383,  383,  173,
			  246,  184,  246,  115,  393,  302,  179,  302,  174,  393,
			  181,  182,  181,  299,   86,  180,   88,  224,  130,  224,
			  241,  242,  243,  244,  244,  244,  244,  183,  184,  183,

			  177,   86,  292,   88,  235,  231,  179,  195,  195,  195,
			  353,  179,  265,  265,  265,  180,   89,  229,  285,  196,
			  180,  354,  117,  117,  266,   90,  285,  208,  208,  273,
			  273,  273,  117,   89,  277,  277,  277,  221,  221,  221,
			  218,  274,   90,  247,  247,  247,  278,  279,  214,  121,
			  285,  267,  213,  233,  233,  233,  348,  348,  186,  186,
			  186,  186,  186,  186,  186,   84,  206,  260,  275,  307,
			  186,  186,  186,  186,  186,  186,  186,  186,  186,  200,
			  308,  197,  186,  186,  186,  186,  186,  186,  250,  272,
			  272,  272,  272,  272,  272,  251,  252,  253,  254,  254,

			  254,  254,  197,  197,  197,  281,  282,  283,  284,  284,
			  284,  284,  256,  211,  198,  255,  250,  204,  204,  204,
			  204,  204,  204,  204,  290,  290,  290,  293,  182,  293,
			  170,  237,  261,   88,  309,  126,  291,  248,  248,  248,
			  302,  262,  269,  269,  269,  310,  357,  357,  223,  249,
			  380,  380,  380,  122,  270,  220,  353,  210,  210,  210,
			  210,  210,  210,  239,  294,  184,  294,  354,  237,  378,
			   88,  118,  240,  258,  258,  258,  258,  258,  258,  258,
			  379,  271,  285,  225,  226,  227,  228,  228,  228,  228,
			  285,  287,  287,  287,  287,  288,  289,  289,  259,  259,

			  239,  245,  182,  245,  113,  393,  213,  103,  259,  240,
			  177,  295,  295,  295,  295,  295,  295,  295,  177,  296,
			  296,  296,  296,  297,  298,  298,  177,  298,  298,  298,
			  298,  298,  298,  298,  246,  184,  246,  179,  393,  300,
			  300,  300,  188,  258,  258,  190,  180,  258,  258,  188,
			  169,  301,  197,  197,  197,  318,  318,  318,  393,  312,
			  312,  312,  100,  393,  198,  122,  393,  319,  177,  119,
			  179,  313,  264,  264,  264,  264,  264,  264,  264,  180,
			  302,  304,  304,  304,  304,  305,  306,  306,  118,  314,
			  179,  311,  378,  101,  320,  321,  321,  321,  200,  180, yy_Dummy>>,
			1, 1000, 0)
		end

	yy_nxt_template_2 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  324,  324,  324,  379,  212,  212,  393,  322,  212,  212,
			  323,  323,  325,  393,  212,  268,  268,  300,  300,  300,
			  307,  307,  307,  331,  331,  331,  334,  334,  334,  301,
			  393,  393,  192,  393,  267,  332,  393,  393,  335,  209,
			  326,  326,  326,  349,  350,  351,  352,  352,  352,  352,
			  393,  393,  327,  317,  317,  328,  328,  328,  328,  328,
			  328,  393,  275,  317,  393,  213,  293,  182,  293,  393,
			  237,  393,   88,  309,  309,  309,  361,  361,  361,  271,
			  329,  329,  329,  358,  358,  196,  393,  393,  362,  269,
			  269,  269,  330,  358,  393,  272,  272,  272,  272,  272,

			  272,  270,  239,  316,  316,  316,  316,  316,  316,  316,
			  393,  240,  294,  184,  294,  363,  237,  393,   88,  211,
			  337,  337,  337,  123,  347,  347,  347,  347,  347,  264,
			  264,  393,  338,  264,  264,  339,  339,  339,  339,  339,
			  339,  339,  312,  312,  312,  286,  286,  286,  239,  393,
			  340,  341,  341,  341,  313,  342,  393,  240,  353,  353,
			  353,  365,  365,  343,  176,  377,  377,  377,  377,  377,
			  249,  365,  364,  360,  360,  360,  360,  360,  360,  360,
			  393,  262,  393,  393,  115,  368,  368,  368,  368,  368,
			  368,  368,  289,  289,  289,  115,  342,  123,  281,  282,

			  283,  284,  284,  284,  284,  123,  345,  345,  345,  345,
			  346,  347,  347,  177,  298,  298,  298,  298,  298,  298,
			  298,  177,  298,  298,  298,  298,  298,  298,  298,  177,
			  298,  298,  298,  298,  298,  175,  175,  265,  265,  265,
			  393,  393,  273,  273,  273,  393,  369,  369,  369,  266,
			  370,  393,  323,  323,  274,  303,  303,  303,  371,  393,
			  369,  369,  369,  393,  370,  312,  312,  312,  312,  312,
			  312,  393,  371,  378,  378,  378,  267,  313,  393,  393,
			  313,  275,  312,  312,  312,  301,  306,  306,  306,  393,
			  393,  370,  393,  393,  313,  393,  393,  339,  339,  339,

			  339,  339,  339,  339,  311,  370,  393,  311,  385,  385,
			  385,  393,  364,  384,  384,  384,  384,  384,  384,  384,
			  386,  262,  176,  349,  350,  351,  352,  352,  352,  352,
			  176,  375,  375,  375,  375,  376,  377,  377,  385,  385,
			  385,  390,  390,  390,  390,  390,  390,  320,  393,  393,
			  386,  393,  393,  391,  393,  393,  391,  388,  388,  388,
			  393,  392,  276,  276,  393,  393,  276,  276,  393,  371,
			  316,  316,  276,  393,  316,  316,  393,  320,  393,  393,
			  363,  393,  393,  363,  344,  344,  344,  347,  347,  347,
			  348,  348,  348,  357,  357,  357,  360,  360,  393,  393,

			  360,  360,  392,   45,   45,   45,   45,   45,   45,   45,
			   45,   45,   45,   45,   45,   45,   45,   45,   45,   45,
			   45,   45,   45,   45,   45,   45,   45,   49,   49,   49,
			   49,   49,   49,   49,   49,   49,   49,   49,   49,   49,
			   49,   49,   49,   49,   49,   49,   49,   49,   49,   49,
			   49,   53,   53,   53,   53,   53,   53,   53,   53,   53,
			   53,   53,   53,   53,   53,   53,   53,   53,   53,   53,
			   53,   53,   53,   53,   53,   57,   57,   57,   57,   57,
			   57,   57,   57,   57,   57,   57,   57,   57,   57,   57,
			   57,   57,   57,   57,   57,   57,   57,   57,   57,   60,

			   60,   60,   60,   60,   60,   60,   60,   60,   60,   60,
			   60,   60,   60,   60,   60,   60,   60,   60,   60,   60,
			   60,   60,   60,   66,   66,   66,   66,   66,   66,   66,
			   66,   66,   66,   66,   66,   66,   66,   66,   66,   66,
			   66,   66,   66,   66,   66,   66,   66,   69,   69,   69,
			   69,   69,   69,   69,   69,   69,   69,   69,   69,   69,
			   69,   69,   69,   69,   69,   69,   69,   69,   69,   69,
			   69,   72,   72,   72,   72,   72,   72,   72,   72,   72,
			   72,   72,   72,   72,   72,   72,   72,   72,   72,   72,
			   72,   72,   72,   72,   72,   78,   78,   78,   78,   78,

			   78,   78,   78,   78,   78,   78,   78,   78,   78,   78,
			   78,   78,   78,   78,   78,   78,   78,   78,   78,   85,
			   85,  393,   85,   85,   85,   85,   85,   85,   85,   85,
			   85,   85,   85,   85,   85,   85,   85,   85,   85,   85,
			   85,   85,   85,   91,   91,   91,   91,  393,  393,   91,
			   91,   91,   91,   91,   91,   91,   91,   91,   91,   91,
			   91,   91,   91,   91,   91,   91,   91,   94,   94,   94,
			   94,  393,  393,   94,   94,   94,   94,   94,   94,   94,
			   94,   94,   94,   94,   94,   94,   94,   94,   94,   94,
			   94,   96,   96,  393,   96,   96,   96,   96,   96,   96,

			   96,   96,   96,   96,   96,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,   96,  115,  115,  115,  382,  382,
			  368,  368,  393,  115,  368,  368,  115,  115,  382,  393,
			  115,  115,  115,  115,  115,  115,  115,  115,  123,  123,
			  393,  123,  123,  123,  123,  123,  123,  123,  123,  123,
			  123,  123,  123,  123,  123,  123,  123,  123,  123,  123,
			  123,  123,  128,  128,  128,  128,  128,  128,  128,  128,
			  128,  128,  128,  128,  128,  128,  128,  128,  128,  128,
			  128,  128,  128,  128,  128,  128,  139,  139,  139,  139,
			  139,  139,  139,  139,  139,  139,  139,  139,  139,  139,

			  139,  139,  139,  139,  139,  139,  139,  139,  139,  139,
			  145,  145,  145,  145,  145,  145,  145,  145,  145,  145,
			  145,  145,  145,  145,  145,  145,  145,  145,  145,  145,
			  145,  145,  145,  145,  149,  149,  149,  149,  149,  149,
			  149,  149,  149,  149,  149,  149,  149,  149,  149,  149,
			  149,  149,  149,  149,  149,  149,  149,  149,  155,  155,
			  155,  155,  155,  155,  155,  155,  155,  155,  155,  155,
			  155,  155,  155,  155,  155,  155,  155,  155,  155,  155,
			  155,  155,  161,  161,  161,  161,  161,  161,  161,  161,
			  161,  161,  161,  161,  161,  161,  161,  161,  161,  161,

			  161,  161,  161,  161,  161,  161,  165,  165,  165,  165,
			  165,  165,  165,  165,  165,  165,  165,  165,  165,  165,
			  165,  165,  165,  165,  165,  165,  165,  165,  165,  165,
			   87,   87,  393,   87,   87,   87,   87,   87,   87,   87,
			   87,   87,   87,   87,   87,   87,   87,   87,   87,   87,
			   87,   87,   87,   87,  175,  175,  393,  175,  175,  175,
			  175,  175,  175,  175,  175,  175,  175,  175,  175,  175,
			  175,  175,  175,  175,  175,  175,  175,  175,  186,  186,
			  186,  186,  393,  393,  186,  186,  186,  186,  186,  186,
			  393,  393,  186,  186,  189,  189,  393,  189,  189,  189, yy_Dummy>>,
			1, 1000, 1000)
		end

	yy_nxt_template_3 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  189,  189,  189,  189,  189,  189,  189,  189,  189,  189,
			  189,  189,  189,  189,  189,  189,  189,  189,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  100,  100,
			  100,  100,  201,  201,  201,  201,  201,  201,  201,  201,
			  201,  201,  393,  201,  201,  201,  201,  201,  201,  201,
			  201,  201,  201,  201,  201,  201,  122,  122,  122,  122,
			  122,  122,  122,  122,  122,  122,  122,  122,  122,  122,
			  122,  122,  122,  122,  122,  122,  122,  122,  122,  122,
			  123,  123,  123,  123,  374,  374,  374,  123,  393,  393,

			  123,  123,  123,  393,  393,  123,  123,  169,  169,  169,
			  169,  169,  169,  169,  169,  169,  169,  169,  169,  169,
			  169,  169,  169,  169,  169,  169,  169,  169,  169,  169,
			  169,  176,  176,  393,  176,  176,  176,  176,  176,  176,
			  176,  176,  176,  176,  176,  176,  176,  176,  176,  176,
			  176,  176,  176,  176,  176,  177,  177,  393,  177,  177,
			  177,  177,  177,  177,  177,  177,  177,  177,  177,  177,
			  177,  177,  177,  177,  177,  177,  177,  177,  177,  176,
			  176,  176,  176,  377,  377,  377,  176,  393,  393,  176,
			  176,  176,  393,  393,  176,  176,  255,  255,  255,  255,

			  255,  255,  255,  255,  255,  255,  255,  255,  255,  255,
			  255,  255,  255,  255,  255,  255,  255,  255,  255,  255,
			  256,  256,  256,  256,  256,  256,  256,  256,  256,  256,
			  256,  256,  256,  256,  256,  256,  256,  256,  256,  256,
			  256,  256,  256,  256,  333,  333,  333,  393,  393,  384,
			  384,  393,  333,  384,  384,  333,  333,  393,  393,  333,
			  333,  393,  393,  393,  393,  333,  336,  336,  336,  336,
			  336,  336,  336,  336,  336,  336,  393,  336,  336,  336,
			  336,  336,  336,  336,  336,  336,  336,  336,  336,  336,
			  123,  123,  393,  123,  123,  123,  123,  123,  123,  123,

			  123,  123,  123,  123,  123,  123,  123,  123,  123,  123,
			  123,  123,  123,  123,  299,  299,  299,  299,  299,  299,
			  299,  299,  299,  299,  299,  299,  299,  299,  299,  299,
			  299,  299,  299,  299,  299,  299,  299,  299,  355,  355,
			  355,  355,  355,  355,  355,  355,  355,  355,  355,  355,
			  355,  355,  355,  355,  355,  355,  355,  355,  355,  355,
			  355,  355,  387,  387,  387,  387,  387,  387,  387,  387,
			  387,  387,  387,  387,  387,  387,  387,  387,  387,  387,
			  387,  387,  387,  387,  387,  387,   21,  393,  393,  393,
			  393,  393,  393,  393,  393,  393,  393,  393,  393,  393,

			  393,  393,  393,  393,  393,  393,  393,  393,  393,  393,
			  393,  393,  393,  393,  393,  393,  393,  393,  393,  393,
			  393,  393,  393,  393,  393,  393,  393,  393,  393,  393,
			  393,  393,  393,  393,  393,  393,  393,  393,  393, yy_Dummy>>,
			1, 439, 2000)
		end

	yy_chk_template: SPECIAL [INTEGER]
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 2438)
			yy_chk_template_1 (an_array)
			yy_chk_template_2 (an_array)
			yy_chk_template_3 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_chk_template_1 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    3,    3,    3,    4,    4,    4,    5,
			   13,   13,    5,  391,    5,    3,    6,  387,    4,    6,
			  386,    6,    7,    7,    7,    8,    8,    8,    7,   14,
			   14,    8,    9,    9,    9,   10,   10,   10,   11,   11,
			   11,  381,   11,   12,   12,   12,  100,   12,   15,   15,

			   15,   16,   16,   16,   17,   17,   17,  100,   17,   18,
			   18,   18,  377,   18,   19,   19,   20,   20,   23,   23,
			   23,   24,   24,   24,   25,   25,   25,   28,   28,   28,
			   23,   66,   66,   24,   11,   29,   25,   29,   49,   12,
			   49,  375,   17,   26,   26,   26,   26,   18,   27,   27,
			   27,   30,   30,   30,  374,   34,   34,  372,   27,   27,
			   27,  371,   34,   30,  363,   32,   32,   32,   34,   34,
			   36,   36,   36,   68,   68,   26,   30,   32,  362,   32,
			   60,   60,   36,   60,   26,   31,   31,   31,  115,   32,
			   54,   54,   54,  123,   36,  123,   54,   31,   31,  115,

			   31,   31,   31,   31,   31,   31,   31,   40,   40,   40,
			   78,   78,   32,   33,   33,   33,   58,   58,   58,   40,
			   61,   61,   61,  357,   61,   33,   33,  352,   33,   33,
			   33,   33,   33,   33,   33,   80,   80,   37,   37,   37,
			  350,   33,   33,   65,   65,  131,   65,  131,   33,   37,
			   72,   72,   33,   72,   33,   33,   35,   35,   35,  122,
			   37,   37,   70,   70,   70,  176,   61,  176,   35,   35,
			  122,   35,   35,   35,   35,   35,   35,   35,   38,   38,
			   38,   39,   39,   39,   41,   41,   41,   46,   46,   46,
			   38,   77,   77,   39,   77,   35,   41,  139,  139,   46,

			  139,  348,   38,   38,  169,   39,   47,   47,   47,   51,
			   51,   51,   73,   73,   73,  169,   73,   41,   47,  149,
			  149,   51,   63,   63,   63,  194,   63,  347,   41,   52,
			   52,   52,  285,   52,  285,   52,  194,   52,   52,  345,
			   75,   75,   75,   52,   75,  151,  151,   81,   81,   81,
			   73,   85,   52,   85,   52,  344,   52,   52,   52,   81,
			  343,   52,   52,   83,   83,   83,  165,  165,   63,   52,
			   52,   52,   52,   52,  338,   83,  167,  167,   75,   86,
			   86,   86,   87,   85,   87,  116,   87,  335,   87,  116,
			  332,   86,   85,  199,  199,   89,   89,   89,  116,   89,

			  116,   89,  251,   90,   90,   90,  330,   90,  251,   90,
			   91,   91,   91,   93,   93,   93,  205,  205,   87,   94,
			   94,   94,   99,   99,   99,  261,  261,   87,   88,  327,
			   88,   89,   88,   88,   99,  129,  129,  129,   88,   90,
			   89,  325,  101,  101,  101,  314,  314,   88,   90,   88,
			  322,   88,   88,   88,  101,  320,   88,   88,  141,  141,
			   88,  141,  108,  108,  108,  137,  137,  137,  222,   88,
			  102,  102,  102,  234,  108,  209,  209,  108,  108,  222,
			  145,  145,  102,  145,  234,  102,  102,  102,  102,  102,
			  102,  102,  109,  109,  109,  109,  109,  109,  319,  209,

			  102,  108,  112,  112,  112,  117,  117,  117,  313,  102,
			  105,  105,  105,  311,  112,  306,  109,  117,  134,  134,
			  134,  255,  105,  304,  134,  105,  105,  105,  105,  105,
			  105,  105,  255,  120,  120,  120,  124,  124,  124,  303,
			  105,  111,  111,  111,  117,  120,  147,  147,  124,  147,
			  143,  143,  143,  111,  143,  302,  111,  111,  111,  111,
			  111,  111,  111,  132,  132,  132,  132,  132,  132,  132,
			  144,  144,  144,  175,  144,  148,  148,  148,  340,  340,
			  111,  153,  153,  153,  301,  155,  155,  148,  155,  157,
			  157,  291,  157,  159,  159,  159,  143,  159,  160,  160,

			  160,  289,  160,  161,  161,  175,  161,  163,  163,  287,
			  163,  164,  164,  164,  175,  286,  144,  172,  172,  172,
			  173,  173,  173,  164,  173,  177,  173,  177,  284,  172,
			  282,  159,  256,  174,  174,  174,  160,  174,  278,  174,
			  179,  179,  179,  256,  179,  274,  188,  188,  188,  191,
			  191,  191,  193,  193,  193,  270,  173,  177,  188,  217,
			  266,  191,  217,  262,  193,  173,  177,  364,  364,  174,
			  180,  180,  180,  217,  180,  254,  179,  252,  174,  178,
			  181,  181,  181,  249,  181,  179,  181,  224,  224,  224,
			  178,  178,  178,  178,  178,  178,  178,  183,  183,  183,

			  241,  183,  238,  183,  236,  232,  180,  195,  195,  195,
			  299,  178,  208,  208,  208,  180,  181,  230,  228,  195,
			  178,  299,  408,  408,  208,  181,  226,  208,  208,  212,
			  212,  212,  408,  183,  216,  216,  216,  221,  221,  221,
			  219,  212,  183,  186,  186,  186,  216,  216,  215,  221,
			  288,  208,  213,  233,  233,  233,  288,  288,  186,  186,
			  186,  186,  186,  186,  186,  233,  207,  203,  212,  308,
			  186,  186,  186,  186,  186,  186,  186,  186,  186,  200,
			  308,  198,  186,  186,  186,  186,  186,  186,  190,  211,
			  211,  211,  211,  211,  211,  190,  190,  190,  190,  190,

			  190,  190,  204,  204,  204,  223,  223,  223,  223,  223,
			  223,  223,  196,  211,  204,  192,  189,  204,  204,  204,
			  204,  204,  204,  204,  237,  237,  237,  239,  239,  239,
			  171,  239,  204,  239,  310,  127,  237,  248,  248,  248,
			  305,  204,  210,  210,  210,  310,  305,  305,  125,  248,
			  356,  356,  356,  121,  210,  119,  354,  210,  210,  210,
			  210,  210,  210,  239,  240,  240,  240,  354,  240,  355,
			  240,  118,  239,  257,  257,  257,  257,  257,  257,  257,
			  355,  210,  225,  225,  225,  225,  225,  225,  225,  225,
			  227,  227,  227,  227,  227,  227,  227,  227,  430,  430,

			  240,  245,  245,  245,  114,  245,  110,  104,  430,  240,
			  242,  242,  242,  242,  242,  242,  242,  242,  243,  243,
			  243,  243,  243,  243,  243,  243,  244,  244,  244,  244,
			  244,  244,  244,  244,  246,  246,  246,  245,  246,  250,
			  250,  250,   98,  429,  429,   97,  245,  429,  429,   96,
			   84,  250,  258,  258,  258,  264,  264,  264,  298,  259,
			  259,  259,   82,  258,  258,   48,  264,  264,  298,   44,
			  246,  259,  263,  263,  263,  263,  263,  263,  263,  246,
			  253,  253,  253,  253,  253,  253,  253,  253,   43,  259,
			  298,  258,  379,   42,  264,  267,  267,  267,  259,  298, yy_Dummy>>,
			1, 1000, 0)
		end

	yy_chk_template_2 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  268,  268,  268,  379,  423,  423,   21,  267,  423,  423,
			  267,  267,  268,    0,  423,  268,  268,  300,  300,  300,
			  307,  307,  307,  275,  275,  275,  276,  276,  276,  300,
			    0,    0,  307,    0,  267,  275,    0,    0,  276,  268,
			  271,  271,  271,  292,  292,  292,  292,  292,  292,  292,
			    0,    0,  271,  441,  441,  271,  271,  271,  271,  271,
			  271,    0,  275,  441,    0,  276,  293,  293,  293,    0,
			  293,    0,  293,  309,  309,  309,  316,  316,  316,  271,
			  272,  272,  272,  450,  450,  309,    0,  316,  316,  328,
			  328,  328,  272,  450,    0,  272,  272,  272,  272,  272,

			  272,  328,  293,  315,  315,  315,  315,  315,  315,  315,
			    0,  293,  294,  294,  294,  316,  294,    0,  294,  272,
			  279,  279,  279,  346,  346,  346,  346,  346,  346,  431,
			  431,    0,  279,  431,  431,  279,  279,  279,  279,  279,
			  279,  279,  317,  317,  317,  433,  433,  433,  294,    0,
			  279,  280,  280,  280,  317,  280,    0,  294,  353,  353,
			  353,  452,  452,  280,  376,  376,  376,  376,  376,  376,
			  353,  452,  317,  359,  359,  359,  359,  359,  359,  359,
			    0,  317,    0,    0,  280,  367,  367,  367,  367,  367,
			  367,  367,  434,  434,  434,  280,  280,  281,  281,  281,

			  281,  281,  281,  281,  281,  283,  283,  283,  283,  283,
			  283,  283,  283,  295,  295,  295,  295,  295,  295,  295,
			  295,  296,  296,  296,  296,  296,  296,  296,  296,  297,
			  297,  297,  297,  297,  297,  297,  297,  323,  323,  323,
			    0,    0,  333,  333,  333,    0,  341,  341,  341,  323,
			  341,    0,  323,  323,  333,  436,  436,  436,  341,    0,
			  369,  369,  369,    0,  369,  358,  358,  358,  360,  360,
			  360,    0,  369,  378,  378,  378,  323,  358,    0,  360,
			  360,  333,  339,  339,  339,  378,  437,  437,  437,    0,
			    0,  341,    0,    0,  339,    0,    0,  339,  339,  339,

			  339,  339,  339,  339,  358,  369,    0,  360,  365,  365,
			  365,    0,  339,  383,  383,  383,  383,  383,  383,  383,
			  365,  339,  349,  349,  349,  349,  349,  349,  349,  349,
			  351,  351,  351,  351,  351,  351,  351,  351,  368,  368,
			  368,  382,  382,  382,  384,  384,  384,  365,    0,  368,
			  368,    0,    0,  382,    0,  384,  384,  388,  388,  388,
			    0,  388,  432,  432,    0,    0,  432,  432,    0,  388,
			  440,  440,  432,    0,  440,  440,    0,  368,    0,    0,
			  382,    0,    0,  384,  444,  444,  444,  445,  445,  445,
			  447,  447,  447,  449,  449,  449,  451,  451,    0,    0,

			  451,  451,  388,  394,  394,  394,  394,  394,  394,  394,
			  394,  394,  394,  394,  394,  394,  394,  394,  394,  394,
			  394,  394,  394,  394,  394,  394,  394,  395,  395,  395,
			  395,  395,  395,  395,  395,  395,  395,  395,  395,  395,
			  395,  395,  395,  395,  395,  395,  395,  395,  395,  395,
			  395,  396,  396,  396,  396,  396,  396,  396,  396,  396,
			  396,  396,  396,  396,  396,  396,  396,  396,  396,  396,
			  396,  396,  396,  396,  396,  397,  397,  397,  397,  397,
			  397,  397,  397,  397,  397,  397,  397,  397,  397,  397,
			  397,  397,  397,  397,  397,  397,  397,  397,  397,  398,

			  398,  398,  398,  398,  398,  398,  398,  398,  398,  398,
			  398,  398,  398,  398,  398,  398,  398,  398,  398,  398,
			  398,  398,  398,  399,  399,  399,  399,  399,  399,  399,
			  399,  399,  399,  399,  399,  399,  399,  399,  399,  399,
			  399,  399,  399,  399,  399,  399,  399,  400,  400,  400,
			  400,  400,  400,  400,  400,  400,  400,  400,  400,  400,
			  400,  400,  400,  400,  400,  400,  400,  400,  400,  400,
			  400,  401,  401,  401,  401,  401,  401,  401,  401,  401,
			  401,  401,  401,  401,  401,  401,  401,  401,  401,  401,
			  401,  401,  401,  401,  401,  402,  402,  402,  402,  402,

			  402,  402,  402,  402,  402,  402,  402,  402,  402,  402,
			  402,  402,  402,  402,  402,  402,  402,  402,  402,  403,
			  403,    0,  403,  403,  403,  403,  403,  403,  403,  403,
			  403,  403,  403,  403,  403,  403,  403,  403,  403,  403,
			  403,  403,  403,  404,  404,  404,  404,    0,    0,  404,
			  404,  404,  404,  404,  404,  404,  404,  404,  404,  404,
			  404,  404,  404,  404,  404,  404,  404,  405,  405,  405,
			  405,    0,    0,  405,  405,  405,  405,  405,  405,  405,
			  405,  405,  405,  405,  405,  405,  405,  405,  405,  405,
			  405,  406,  406,    0,  406,  406,  406,  406,  406,  406,

			  406,  406,  406,  406,  406,  406,  406,  406,  406,  406,
			  406,  406,  406,  406,  406,  407,  407,  407,  457,  457,
			  453,  453,    0,  407,  453,  453,  407,  407,  457,    0,
			  407,  407,  407,  407,  407,  407,  407,  407,  409,  409,
			    0,  409,  409,  409,  409,  409,  409,  409,  409,  409,
			  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,
			  409,  409,  410,  410,  410,  410,  410,  410,  410,  410,
			  410,  410,  410,  410,  410,  410,  410,  410,  410,  410,
			  410,  410,  410,  410,  410,  410,  411,  411,  411,  411,
			  411,  411,  411,  411,  411,  411,  411,  411,  411,  411,

			  411,  411,  411,  411,  411,  411,  411,  411,  411,  411,
			  412,  412,  412,  412,  412,  412,  412,  412,  412,  412,
			  412,  412,  412,  412,  412,  412,  412,  412,  412,  412,
			  412,  412,  412,  412,  413,  413,  413,  413,  413,  413,
			  413,  413,  413,  413,  413,  413,  413,  413,  413,  413,
			  413,  413,  413,  413,  413,  413,  413,  413,  414,  414,
			  414,  414,  414,  414,  414,  414,  414,  414,  414,  414,
			  414,  414,  414,  414,  414,  414,  414,  414,  414,  414,
			  414,  414,  415,  415,  415,  415,  415,  415,  415,  415,
			  415,  415,  415,  415,  415,  415,  415,  415,  415,  415,

			  415,  415,  415,  415,  415,  415,  416,  416,  416,  416,
			  416,  416,  416,  416,  416,  416,  416,  416,  416,  416,
			  416,  416,  416,  416,  416,  416,  416,  416,  416,  416,
			  417,  417,    0,  417,  417,  417,  417,  417,  417,  417,
			  417,  417,  417,  417,  417,  417,  417,  417,  417,  417,
			  417,  417,  417,  417,  418,  418,    0,  418,  418,  418,
			  418,  418,  418,  418,  418,  418,  418,  418,  418,  418,
			  418,  418,  418,  418,  418,  418,  418,  418,  419,  419,
			  419,  419,    0,    0,  419,  419,  419,  419,  419,  419,
			    0,    0,  419,  419,  420,  420,    0,  420,  420,  420, yy_Dummy>>,
			1, 1000, 1000)
		end

	yy_chk_template_3 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  420,  420,  420,  420,  420,  420,  420,  420,  420,  420,
			  420,  420,  420,  420,  420,  420,  420,  420,  421,  421,
			  421,  421,  421,  421,  421,  421,  421,  421,  421,  421,
			  421,  421,  421,  421,  421,  421,  421,  421,  421,  421,
			  421,  421,  422,  422,  422,  422,  422,  422,  422,  422,
			  422,  422,    0,  422,  422,  422,  422,  422,  422,  422,
			  422,  422,  422,  422,  422,  422,  424,  424,  424,  424,
			  424,  424,  424,  424,  424,  424,  424,  424,  424,  424,
			  424,  424,  424,  424,  424,  424,  424,  424,  424,  424,
			  425,  425,  425,  425,  454,  454,  454,  425,    0,    0,

			  425,  425,  425,    0,    0,  425,  425,  426,  426,  426,
			  426,  426,  426,  426,  426,  426,  426,  426,  426,  426,
			  426,  426,  426,  426,  426,  426,  426,  426,  426,  426,
			  426,  427,  427,    0,  427,  427,  427,  427,  427,  427,
			  427,  427,  427,  427,  427,  427,  427,  427,  427,  427,
			  427,  427,  427,  427,  427,  428,  428,    0,  428,  428,
			  428,  428,  428,  428,  428,  428,  428,  428,  428,  428,
			  428,  428,  428,  428,  428,  428,  428,  428,  428,  435,
			  435,  435,  435,  455,  455,  455,  435,    0,    0,  435,
			  435,  435,    0,    0,  435,  435,  438,  438,  438,  438,

			  438,  438,  438,  438,  438,  438,  438,  438,  438,  438,
			  438,  438,  438,  438,  438,  438,  438,  438,  438,  438,
			  439,  439,  439,  439,  439,  439,  439,  439,  439,  439,
			  439,  439,  439,  439,  439,  439,  439,  439,  439,  439,
			  439,  439,  439,  439,  442,  442,  442,    0,    0,  458,
			  458,    0,  442,  458,  458,  442,  442,    0,    0,  442,
			  442,    0,    0,    0,    0,  442,  443,  443,  443,  443,
			  443,  443,  443,  443,  443,  443,    0,  443,  443,  443,
			  443,  443,  443,  443,  443,  443,  443,  443,  443,  443,
			  446,  446,    0,  446,  446,  446,  446,  446,  446,  446,

			  446,  446,  446,  446,  446,  446,  446,  446,  446,  446,
			  446,  446,  446,  446,  448,  448,  448,  448,  448,  448,
			  448,  448,  448,  448,  448,  448,  448,  448,  448,  448,
			  448,  448,  448,  448,  448,  448,  448,  448,  456,  456,
			  456,  456,  456,  456,  456,  456,  456,  456,  456,  456,
			  456,  456,  456,  456,  456,  456,  456,  456,  456,  456,
			  456,  456,  459,  459,  459,  459,  459,  459,  459,  459,
			  459,  459,  459,  459,  459,  459,  459,  459,  459,  459,
			  459,  459,  459,  459,  459,  459,  393,  393,  393,  393,
			  393,  393,  393,  393,  393,  393,  393,  393,  393,  393,

			  393,  393,  393,  393,  393,  393,  393,  393,  393,  393,
			  393,  393,  393,  393,  393,  393,  393,  393,  393,  393,
			  393,  393,  393,  393,  393,  393,  393,  393,  393,  393,
			  393,  393,  393,  393,  393,  393,  393,  393,  393, yy_Dummy>>,
			1, 439, 2000)
		end

	yy_base_template: SPECIAL [INTEGER]
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,   51,   54,   56,   63,   70,   73,   80,
			   83,   86,   91,   57,   76,   96,   99,  102,  107,  111,
			  113, 1006, 2386,  116,  119,  122,  137,  146,  125,  127,
			  149,  183,  163,  211,  125,  254,  168,  235,  276,  279,
			  205,  282,  954,  947,  919, 2386,  285,  304,  951,  132,
			 2386,  307,  327, 2386,  188, 2386, 2386, 2386,  214, 2386,
			  177,  218, 2386,  320, 2386,  240,  128, 2386,  170, 2386,
			  260, 2386,  247,  310, 2386,  338, 2386,  288,  207, 2386,
			  232,  345,  948,  361,  936,  345,  377,  380,  422,  393,
			  401,  408, 2386,  411,  417, 2386,  939,  929,  932,  420,

			   93,  440,  468, 2386,  893,  508,    0,    0,  460,  475,
			  865,  539,  500, 2386,  890,  153,  354,  503,  830,  804,
			  531,  839,  256,  187,  534,  832, 2386,  821, 2386,  433,
			 2386,  239,  546, 2386,  516, 2386, 2386,  463, 2386,  294,
			 2386,  455, 2386,  548,  568,  477, 2386,  543,  573,  316,
			 2386,  342, 2386,  579, 2386,  582, 2386,  586, 2386,  591,
			  596,  600, 2386,  604,  609,  363, 2386,  373, 2386,  301,
			 2386,  816,  615,  618,  631,  567,  259,  619,  673,  638,
			  668,  678, 2386,  695, 2386, 2386,  741, 2386,  644,  806,
			  778,  647,  801,  650,  322,  705,  798, 2386,  767,  380,

			  738, 2386, 2386,  753,  800,  403, 2386,  752,  710,  458,
			  840,  772,  727,  711, 2386,  734,  732,  627, 2386,  726,
			 2386,  735,  465,  788,  685,  866,  710,  874,  702, 2386,
			  703, 2386,  691,  751,  470, 2386,  690,  822,  686,  825,
			  862,  684,  894,  902,  910,  899,  932, 2386,  835,  669,
			  937,  392,  661,  964,  659,  518,  629,  856,  950,  957,
			 2386,  412,  622,  955,  953, 2386,  646,  993,  998, 2386,
			  641, 1038, 1078, 2386,  631, 1021, 1024, 2386,  624, 1118,
			 1149, 1181,  614, 1189,  612,  326,  599,  593,  734,  585,
			 2386,  577, 1026, 1064, 1110, 1197, 1205, 1213,  952,  707,

			 1015,  570,  545,  523,  507,  824,  499, 1018,  766, 1071,
			  831,  472, 2386,  494,  432, 1086, 1074, 1140, 2386,  484,
			  414, 2386,  436, 1235, 2386,  427, 2386,  415, 1087, 2386,
			  392, 2386,  376, 1240, 2386,  373, 2386, 2386,  360, 1280,
			  565, 1244, 2386,  346,  339,  323, 1107,  311,  285, 1306,
			  224, 1314,  211, 1156,  853,  866,  848,  207, 1263, 1156,
			 1266, 2386,  164,  123,  654, 1306, 2386, 1168, 1336, 1258,
			 2386,  147,  154, 2386,  138,  125, 1148,   96, 1271,  989,
			 2386,   81, 1339, 1296, 1342, 2386,   56,   64, 1355, 2386,
			 2386,   49, 2386, 2386, 1402, 1426, 1450, 1474, 1498, 1522,

			 1546, 1570, 1594, 1618, 1642, 1666, 1690, 1713,  709, 1737,
			 1761, 1785, 1809, 1833, 1857, 1881, 1905, 1929, 1953, 1977,
			 1993, 2017, 2041,  991, 2065, 2085, 2106, 2130, 2154,  934,
			  885, 1120, 1349, 1133, 1180, 2174, 1243, 1274, 2195, 2219,
			 1361, 1040, 2242, 2265, 1372, 1375, 2289, 1378, 2313, 1381,
			 1070, 1387, 1148, 1711, 2082, 2171, 2337, 1705, 2240, 2361, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER]
		once
			Result := yy_fixed_array (<<
			    0,  393,    1,  394,  394,  395,  395,  396,  396,  397,
			  397,  398,  398,  399,  399,  400,  400,  401,  401,  402,
			  402,  393,  393,  393,  393,  393,  403,  404,  405,  406,
			  393,  393,  393,  393,   33,  393,  393,  393,  393,  393,
			  407,  407,  393,  408,  393,  393,  393,  393,  393,  409,
			  393,  393,  410,  393,  393,  393,  393,  393,  393,  393,
			  411,  411,  393,  411,  393,  412,  413,  393,  413,  393,
			  393,  393,  414,  414,  393,  414,  393,  415,  416,  393,
			  416,  393,  393,  393,  393,  403,  393,  417,  418,  403,
			  403,  404,  393,  419,  405,  393,  393,  420,  393,  393,

			  421,  393,  393,  393,  393,  422,   34,   35,  393,  393,
			  423,  393,  393,  393,  393,   41,   41,  408,  408,  393,
			  393,  393,  424,  409,  393,  425,  393,  393,  393,  393,
			  393,  409,  393,  393,  393,  393,  393,  393,  393,  411,
			  393,  411,  393,  411,  411,  412,  393,  412,  393,  413,
			  393,  413,  393,  393,  393,  414,  393,  414,  393,  414,
			  414,  415,  393,  415,  393,  416,  393,  416,  393,  426,
			  393,  393,  393,  417,  417,  418,  427,  428,  418,  418,
			  418,  403,  393,  403,  393,  393,  419,  393,  393,  393,
			  393,  393,  393,  393,  421,  393,  393,  393,  393,  429,

			  430,  393,  393,  393,  393,  431,  393,  393,  393,  393,
			  393,  393,  423,  432,  393,  393,  111,   41,  393,  393,
			  393,  393,  424,  393,  393,  393,  433,  393,  434,  393,
			  393,  393,  393,  393,  426,  393,  393,  393,  435,  428,
			  428,  178,  178,  178,  178,  418,  418,  393,  393,  393,
			  393,  190,  436,  393,  437,  438,  439,  393,  429,  430,
			  393,  440,  441,  393,  431,  393,  393,  393,  393,  393,
			  393,  393,  393,  393,  393,  442,  432,  393,  393,  443,
			   41,  393,  444,  393,  445,  446,  434,  434,  434,  447,
			  393,  393,  393,  428,  428,  178,  178,  178,  418,  448,

			  393,  393,  393,  437,  437,  437,  449,  393,  438,  393,
			  439,  450,  393,  393,  451,  393,  440,  441,  393,  393,
			  452,  393,  393,  393,  393,  393,  393,  393,  271,  393,
			  393,  393,  393,  442,  393,  393,  393,  393,  393,  393,
			  453,  393,  393,  393,  445,  445,  393,  393,  447,  393,
			  454,  393,  455,  393,  448,  456,  393,  449,  450,  393,
			  451,  393,  393,  457,  458,  452,  393,  393,  453,  393,
			  393,  393,  459,  393,  455,  455,  393,  393,  393,  456,
			  393,  393,  457,  393,  458,  393,  393,  459,  393,  393,
			  393,  393,  393,    0,  393,  393,  393,  393,  393,  393,

			  393,  393,  393,  393,  393,  393,  393,  393,  393,  393,
			  393,  393,  393,  393,  393,  393,  393,  393,  393,  393,
			  393,  393,  393,  393,  393,  393,  393,  393,  393,  393,
			  393,  393,  393,  393,  393,  393,  393,  393,  393,  393,
			  393,  393,  393,  393,  393,  393,  393,  393,  393,  393,
			  393,  393,  393,  393,  393,  393,  393,  393,  393,  393, yy_Dummy>>)
		end

	yy_ec_template: SPECIAL [INTEGER]
		once
			Result := yy_fixed_array (<<
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
			   37,   33,   33,   47,    9,   48,   49,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,   50,    1,    1,
			    1,   51,    1,    1,    1,    1,    1,    1,    1,    1,

			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,   52,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1, yy_Dummy>>)
		end

	yy_meta_template: SPECIAL [INTEGER]
		once
			Result := yy_fixed_array (<<
			    0,    1,    2,    3,    4,    1,    5,    1,    6,    1,
			    7,    8,    1,    9,   10,   11,   12,   13,   13,   13,
			   13,   13,   13,   14,    1,   15,    1,   16,    1,   17,
			   17,   17,   18,   19,   20,   21,   19,   22,    1,    1,
			    1,   23,   18,   18,   18,   19,   24,    1,    1,    1,
			    1,    1,    1, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER]
		once
			Result := yy_fixed_array (<<
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
			  289,  291,  293,  293,  294,  295,  297,  297,  299,  299,

			  299,  299,  300,  302,  303,  307,  308,  309,  309,  311,
			  311,  313,  313,  315,  315,  316,  316,  318,  320,  321,
			  321,  322,  323,  324,  324,  324,  325,  326,  327,  328,
			  329,  329,  330,  330,  331,  332,  335,  335,  337,  337,
			  339,  341,  341,  341,  341,  341,  341,  341,  342,  344,
			  344,  345,  346,  347,  348,  349,  350,  351,  351,  355,
			  357,  358,  358,  358,  358,  362,  363,  363,  365,  367,
			  368,  368,  370,  372,  373,  373,  375,  377,  378,  378,
			  379,  381,  381,  381,  381,  381,  384,  385,  386,  387,
			  388,  389,  389,  389,  390,  391,  391,  391,  391,  391,

			  392,  394,  394,  395,  396,  397,  398,  399,  400,  401,
			  402,  403,  403,  404,  404,  404,  404,  412,  414,  416,
			  416,  416,  417,  417,  419,  420,  420,  421,  421,  423,
			  424,  424,  425,  425,  427,  428,  428,  429,  431,  432,
			  434,  435,  436,  437,  437,  437,  437,  437,  437,  438,
			  438,  438,  438,  438,  439,  440,  441,  443,  444,  446,
			  446,  448,  452,  452,  452,  452,  454,  455,  455,  457,
			  457,  459,  459,  460,  461,  461,  461,  461,  461,  462,
			  463,  464,  465,  469,  469,  473,  474,  474,  474,  474,
			  475,  477,  477,  478,  478, yy_Dummy>>)
		end

	yy_acclist_template: SPECIAL [INTEGER]
		once
			Result := yy_fixed_array (<<
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
			   85, -215,   85, -215,   83, -213,   91, -221,   83, -213,

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
			 -142,   69,   70,   74,   71,   71,   71,   71,  -66,   67,
			   67,   26,   28,   29,   36,   33,   33,   33,   33,    5,

			    5,    8,    8, -119,  115,  116,  121,  122, -241, -242,
			 -247, -248,  122, -248, -112, -118, -110,  105, -235, -108,
			 -104,   99, -229, -102,  -98,   93, -223,  -96,  120, -117,
			  120,  120,  122, -248,  120,  -13,    9,   71,   26,   26,
			   29,   30,   32,   33,  122, -248,  122, -248, -112, -113,
			 -118, -119,  121, -247, -117,  121, -247,   10,   11,  -13,
			   70,   29,   29,   31,   36,  121,  122, -247, -248,  121,
			  122, -247, -248, -118,   32, -118, -119,   11, yy_Dummy>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER = 2386
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER = 393
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER = 394
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
					-- START INLINING 'yy_at_beginning_of_line'
					-- yy_current_state := yy_start_state + yy_at_beginning_of_line
					if input_buffer.beginning_of_line then
						yy_current_state := yy_start_state + 1
					else
						yy_current_state := yy_start_state
					end
					-- END INLINING 'yy_at_beginning_of_line'
					if yyReject_or_variable_trail_context then
							-- Set up for storing up states.
						SPECIAL_INTEGER_.force (yy_state_stack, yy_current_state, 0)
						yy_state_count := 1
					end
					yy_goto := yyMatch
				when yyMatch then
					l_content_area := yy_content_area
						-- Find the next match.
					from
						yy_done := False
					until
						yy_done
					loop
						if yy_ec /= Void then
							if l_content_area /= Void then
								yy_c := yy_ec.item (l_content_area.item (yy_cp).code)
							else
								yy_c := yy_ec.item (yy_content.item (yy_cp).code)
							end
						else
							if l_content_area /= Void then
								yy_c := l_content_area.item (yy_cp).code
							else
								yy_c := yy_content.item (yy_cp).code
							end
						end
						if
							not yyReject_or_variable_trail_context and then
							yy_accept.item (yy_current_state) /= 0
						then
								-- Save the backing-up info before computing
								-- the next state because we always compute one
								-- more state than needed - we always proceed
								-- until we reach a jam state.
							yy_last_accepting_state := yy_current_state
							yy_last_accepting_cpos := yy_cp
						end
						from until
							yy_chk.item (yy_base.item (yy_current_state) + yy_c) = yy_current_state
						loop
							yy_current_state := yy_def.item (yy_current_state)
							if
								yy_meta /= Void and then
								yy_current_state >= yyTemplate_mark
							then
									-- We've arranged it so that templates are
									-- never chained to one another. This means
									-- we can afford to make a very simple test
									-- to see if we need to convert to `yy_c''s
									-- meta-equivalence class without worrying
									-- about erroneously looking up the meta
									-- equivalence class twice.
								yy_c := yy_meta.item (yy_c)
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
					check reject_used: yyReject_or_variable_trail_context end
					from yy_found := False until yy_found loop
						if
							yy_lp /= 0 and
							yy_lp < yy_accept.item (yy_current_state + 1)
						then
							yy_act := yy_acclist.item (yy_lp)
							if yyVariable_trail_context then
								if
									yy_act < - yyNb_rules or
									yy_looking_for_trail_begin /= 0
								then
									if yy_act = yy_looking_for_trail_begin then
										yy_looking_for_trail_begin := 0
										yy_act := - yy_act - yyNb_rules
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
							elseif
								yy_end - yy_start - yy_more_len /= 0
							then
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
