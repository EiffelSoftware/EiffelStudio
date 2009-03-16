indexing

	description:

		"Scanners for Eiffel parsers"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 1999-2009, Eric Bezault and others"
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

	valid_start_condition (sc: INTEGER): BOOLEAN is
			-- Is `sc' a valid start condition?
		do
			Result := (INITIAL <= sc and sc <= LAVS3)
		end

feature {NONE} -- Implementation

	yy_build_tables is
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

	yy_execute_action (yy_act: INTEGER) is
			-- Execute semantic action.
		do
if yy_act <= 67 then
if yy_act <= 34 then
if yy_act <= 17 then
if yy_act <= 9 then
if yy_act <= 5 then
if yy_act <= 3 then
if yy_act <= 2 then
if yy_act = 1 then
	yy_column := yy_column + 1
--|#line 37 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 37")
end

				last_break_end := 0
				last_comment_end := 0
				process_one_char_symbol (text_item (1))
			
else
yy_set_line_column
--|#line 42 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 42")
end

				last_text_count := 1
				last_break_end := text_count
				last_comment_end := 0
				process_one_char_symbol (text_item (1))
			
end
else
yy_set_line_column
--|#line 48 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 48")
end

				last_text_count := 1
				last_break_end := 0
				last_comment_end := text_count
				process_one_char_symbol (text_item (1))
			
end
else
if yy_act = 4 then
yy_set_line_column
--|#line 54 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 54")
end

				last_text_count := 1
				last_break_end := 0
				last_comment_end := text_count
				process_one_char_symbol ('-')
			
else
	yy_column := yy_column + 2
--|#line 60 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 60")
end

				last_break_end := 0
				last_comment_end := 0
				process_two_char_symbol (text_item (1), text_item (2))
			
end
end
else
if yy_act <= 7 then
if yy_act = 6 then
yy_set_line_column
--|#line 65 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 65")
end

				last_text_count := 2
				last_break_end := text_count
				last_comment_end := 0
				process_two_char_symbol (text_item (1), text_item (2))
			
else
yy_set_line_column
--|#line 71 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 71")
end

				last_text_count := 2
				last_break_end := 0
				last_comment_end := text_count
				process_two_char_symbol (text_item (1), text_item (2))
			
end
else
if yy_act = 8 then
	yy_end := yy_end - 1
	yy_column := yy_column + 4
--|#line 93 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 93")
end

				last_token := E_ONCE_STRING
				last_literal_start := 1
				last_literal_end := 4
				last_break_end := 0
				last_comment_end := 0
				last_et_keyword_value := ast_factory.new_once_keyword (Current)
			
else
	yy_end := yy_end - 1
yy_set_line_column
--|#line 101 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 101")
end

				last_token := E_ONCE_STRING
				last_literal_start := 1
				last_literal_end := 4
				last_text_count := 4
				last_break_end := text_count
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
--|#line 110 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 110")
end

				last_token := E_ONCE_STRING
				last_literal_start := 1
				last_literal_end := 4
				last_text_count := 4
				last_break_end := 0
				last_comment_end := text_count
				last_et_keyword_value := ast_factory.new_once_keyword (Current)
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 123 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 123")
end

				last_break_end := 0
				last_comment_end := 0
				process_identifier (text_count)
			
end
else
if yy_act = 12 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 128 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 128")
end

				last_text_count := text_count
				break_kind := identifier_break
				more
				set_start_condition (BREAK)
			
else
	yy_column := yy_column + 1
--|#line 143 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 143")
end

				last_token := E_FREEOP
				last_literal_start := 1
				last_literal_end := text_count
				last_break_end := 0
				last_comment_end := 0
				last_et_free_operator_value := ast_factory.new_free_operator (Current)
			
end
end
else
if yy_act <= 15 then
if yy_act = 14 then
	yy_column := yy_column + 2
--|#line 144 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 144")
end

				last_token := E_FREEOP
				last_literal_start := 1
				last_literal_end := text_count
				last_break_end := 0
				last_comment_end := 0
				last_et_free_operator_value := ast_factory.new_free_operator (Current)
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 145 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 145")
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
--|#line 146 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 146")
end

				last_token := E_FREEOP
				last_literal_start := 1
				last_literal_end := text_count
				last_break_end := 0
				last_comment_end := 0
				last_et_free_operator_value := ast_factory.new_free_operator (Current)
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 147 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 147")
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
if yy_act <= 26 then
if yy_act <= 22 then
if yy_act <= 20 then
if yy_act <= 19 then
if yy_act = 18 then
	yy_end := yy_end - 1
	yy_column := yy_column + 1
--|#line 157 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 157")
end

				last_text_count := text_count
				last_literal_start := 1
				last_literal_end := last_text_count
				break_kind := freeop_break
				more
				set_start_condition (BREAK)
			
else
	yy_end := yy_end - 1
	yy_column := yy_column + 2
--|#line 158 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 158")
end

				last_text_count := text_count
				last_literal_start := 1
				last_literal_end := last_text_count
				break_kind := freeop_break
				more
				set_start_condition (BREAK)
			
end
else
	yy_end := yy_end - 1
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 159 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 159")
end

				last_text_count := text_count
				last_literal_start := 1
				last_literal_end := last_text_count
				break_kind := freeop_break
				more
				set_start_condition (BREAK)
			
end
else
if yy_act = 21 then
	yy_end := yy_end - 1
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 160 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 160")
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
--|#line 161 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 161")
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
if yy_act <= 24 then
if yy_act = 23 then
	yy_column := yy_column + 3
--|#line 173 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 173")
end

				last_break_end := 0
				last_comment_end := 0
				process_c1_character_constant (text_item (2))
			
else
yy_set_line_column
--|#line 178 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 178")
end

				last_text_count := 3
				last_break_end := text_count
				last_comment_end := 0
				process_c1_character_constant (text_item (2))
			
end
else
if yy_act = 25 then
yy_set_line_column
--|#line 184 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 184")
end

				last_text_count := 3
				last_break_end := 0
				last_comment_end := text_count
				process_c1_character_constant (text_item (2))
			
else
	yy_column := yy_column + 4
--|#line 190 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 190")
end

				last_break_end := 0
				last_comment_end := 0
				process_c2_character_constant (text_item (3))
			
end
end
end
else
if yy_act <= 30 then
if yy_act <= 28 then
if yy_act = 27 then
yy_set_line_column
--|#line 195 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 195")
end

				last_text_count := 4
				last_break_end := text_count
				last_comment_end := 0
				process_c2_character_constant (text_item (3))
			
else
yy_set_line_column
--|#line 201 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 201")
end

				last_text_count := 4
				last_break_end := 0
				last_comment_end := text_count
				process_c2_character_constant (text_item (3))
			
end
else
if yy_act = 29 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 208 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 208")
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
--|#line 216 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 216")
end

				last_text_count := text_count
				last_literal_start := 4
				last_literal_end := last_text_count - 2
				break_kind := character_break
				more
				set_start_condition (BREAK)
			
end
end
else
if yy_act <= 32 then
if yy_act = 31 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 225 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 225")
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
--|#line 235 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 235")
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
else
if yy_act = 33 then
	yy_column := yy_column + 3
--|#line 245 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 245")
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
--|#line 255 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 255")
end

					-- Syntax error: missing character between quotes.
				column := column + 1
				set_syntax_error
				error_handler.report_SCQQ_error (filename, current_position)
				last_et_position_value := current_position
				column := column - 1
				last_token := E_CHARERR
			
end
end
end
end
end
else
if yy_act <= 51 then
if yy_act <= 43 then
if yy_act <= 39 then
if yy_act <= 37 then
if yy_act <= 36 then
if yy_act = 35 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 264 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 264")
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
--|#line 278 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 278")
end

				last_token := E_STRFREEOP
				last_literal_start := 2
				last_literal_end := text_count - 1
				last_break_end := 0
				last_comment_end := 0
				last_et_manifest_string_value := ast_factory.new_regular_manifest_string (Current)
			
end
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 286 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 286")
end

				last_text_count := text_count
				last_literal_start := 2
				last_literal_end := last_text_count - 1
				break_kind := str_freeop_break
				more
				set_start_condition (BREAK)
			
end
else
if yy_act = 38 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 295 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 295")
end

					-- Regular manifest string.
				last_break_end := 0
				last_comment_end := 0
				process_regular_manifest_string (text_count)
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 301 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 301")
end

					-- Regular manifest string.
				last_text_count := text_count
				break_kind := string_break
				more
				set_start_condition (BREAK)
			
end
end
else
if yy_act <= 41 then
if yy_act = 40 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 309 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 309")
end

					-- Verbatim string.
				verbatim_marker := text_substring (2, text_count - 1)
				set_start_condition (VS1)
			
else
	yy_line := yy_line + 1
	yy_column := 1
--|#line 317 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 317")
end

				verbatim_open_white_characters := text
				last_literal_start := 1
				last_literal_end := 0
				set_start_condition (VS2)
			
end
else
if yy_act = 42 then
	yy_column := yy_column + 1
--|#line 323 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 323")
end

					-- No final brace-double-quote.
				last_token := E_STRERR
				last_et_position_value := current_position
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 341 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 341")
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
			
end
end
end
else
if yy_act <= 47 then
if yy_act <= 45 then
if yy_act = 44 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 356 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 356")
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
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 368 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 368")
end

				more
				set_start_condition (VS3)
			
end
else
if yy_act = 46 then
	yy_line := yy_line + 1
	yy_column := 1
--|#line 372 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 372")
end

				more
				last_literal_end := text_count - 2
			
else
	yy_line := yy_line + 1
	yy_column := 1
--|#line 376 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 376")
end

				more
				last_literal_end := text_count - 1
			
end
end
else
if yy_act <= 49 then
if yy_act = 48 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 380 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 380")
end

					-- No final brace-double-quote.
				last_token := E_STRERR
				last_et_position_value := current_position
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
else
	yy_line := yy_line + 1
	yy_column := 1
--|#line 398 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 398")
end

				more
				last_literal_end := text_count - 2
				set_start_condition (VS2)
			
end
else
if yy_act = 50 then
	yy_line := yy_line + 1
	yy_column := 1
--|#line 403 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 403")
end

				more
				last_literal_end := text_count - 1
				set_start_condition (VS2)
			
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
if yy_act <= 59 then
if yy_act <= 55 then
if yy_act <= 53 then
if yy_act = 52 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 424 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 424")
end

					-- Left-aligned verbatim string.
				verbatim_marker := text_substring (2, text_count - 1)
				set_start_condition (LAVS1)
			
else
	yy_line := yy_line + 1
	yy_column := 1
--|#line 432 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 432")
end

				verbatim_open_white_characters := text
				last_literal_start := 1
				last_literal_end := 0
				set_start_condition (LAVS2)
			
end
else
if yy_act = 54 then
	yy_column := yy_column + 1
--|#line 438 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 438")
end

					-- No final bracket-double-quote.
				last_token := E_STRERR
				last_et_position_value := current_position
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 456 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 456")
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
			
end
end
else
if yy_act <= 57 then
if yy_act = 56 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 471 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 471")
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
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 483 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 483")
end

				more
				set_start_condition (LAVS3)
			
end
else
if yy_act = 58 then
	yy_line := yy_line + 1
	yy_column := 1
--|#line 487 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 487")
end

				more
				last_literal_end := text_count - 2
			
else
	yy_line := yy_line + 1
	yy_column := 1
--|#line 491 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 491")
end

				more
				last_literal_end := text_count - 1
			
end
end
end
else
if yy_act <= 63 then
if yy_act <= 61 then
if yy_act = 60 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 495 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 495")
end

					-- No final bracket-double-quote.
				last_token := E_STRERR
				last_et_position_value := current_position
				report_syntax_error (current_position)
				set_start_condition (INITIAL)
			
else
	yy_line := yy_line + 1
	yy_column := 1
--|#line 513 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 513")
end

				more
				last_literal_end := text_count - 2
				set_start_condition (LAVS2)
			
end
else
if yy_act = 62 then
	yy_line := yy_line + 1
	yy_column := 1
--|#line 518 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 518")
end

				more
				last_literal_end := text_count - 1
				set_start_condition (LAVS2)
			
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
if yy_act <= 65 then
if yy_act = 64 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 539 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 539")
end

					-- Manifest string with special characters.
				last_token := E_STRING
				last_literal_start := 2
				last_literal_end := text_count - 1
				last_break_end := 0
				last_comment_end := 0
				last_et_manifest_string_value := ast_factory.new_special_manifest_string (Current)
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 548 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 548")
end

					-- Manifest string with special characters.
				last_text_count := text_count
				last_literal_start := 2
				last_literal_end := last_text_count - 1
				break_kind := str_special_break
				more
				set_start_condition (BREAK)
			
end
else
if yy_act = 66 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 557 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 557")
end

					-- Manifest string with special characters which may be made
					-- up of several lines or may include invalid characters.
					-- Keep track of current line and column.
				ms_line := line
				ms_column := column
				more
				set_start_condition (MS)
			
else
	yy_line := yy_line + 1
	yy_column := 1
--|#line 568 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 568")
end

					-- Multi-line manifest string.
				more
				set_start_condition (MSN)
			
end
end
end
end
end
end
else
if yy_act <= 101 then
if yy_act <= 84 then
if yy_act <= 76 then
if yy_act <= 72 then
if yy_act <= 70 then
if yy_act <= 69 then
if yy_act = 68 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 573 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 573")
end

				more
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 576 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 576")
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
			
end
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 589 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 589")
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
if yy_act = 71 then
	yy_column := yy_column + 2
--|#line 602 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 602")
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
--|#line 615 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 615")
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
else
if yy_act <= 74 then
if yy_act = 73 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 627 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 627")
end

				more
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 630 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 630")
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
if yy_act = 75 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 639 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 639")
end

				last_text_count := text_count
				last_literal_start := 2
				last_literal_end := last_text_count - 1
				break_kind := str_special_break
				more
				set_start_condition (BREAK)
			
else
	yy_column := yy_column + 2
--|#line 647 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 647")
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
end
else
if yy_act <= 80 then
if yy_act <= 78 then
if yy_act = 77 then
	yy_column := yy_column + 1
--|#line 658 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 658")
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
--|#line 671 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 671")
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
if yy_act = 79 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 699 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 699")
end

				more
				set_start_condition (MS)
			
else
	yy_line := yy_line + 1
	yy_column := 1
--|#line 703 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 703")
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
else
if yy_act <= 82 then
if yy_act = 81 then
	yy_column := yy_column + 1
--|#line 714 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 714")
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
--|#line 745 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 745")
end

				last_token := E_BIT
				last_literal_start := 1
				last_literal_end := text_count
				last_break_end := 0
				last_comment_end := 0
				last_et_bit_constant_value := ast_factory.new_bit_constant (Current)
			
end
else
if yy_act = 83 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 753 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 753")
end

				last_text_count := text_count
				last_literal_start := 1
				last_literal_end := last_text_count
				break_kind := bit_break
				more
				set_start_condition (BREAK)
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 765 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 765")
end

				last_token := E_INTEGER
				last_literal_start := 1
				last_literal_end := text_count
				last_break_end := 0
				last_comment_end := 0
				last_et_integer_constant_value := ast_factory.new_regular_integer_constant (Current)
			
end
end
end
end
else
if yy_act <= 93 then
if yy_act <= 89 then
if yy_act <= 87 then
if yy_act <= 86 then
if yy_act = 85 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 773 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 773")
end

				last_text_count := text_count
				last_literal_start := 1
				last_literal_end := last_text_count
				break_kind := integer_break
				more
				set_start_condition (BREAK)
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 781 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 781")
end

				last_token := E_INTEGER
				last_literal_start := 1
				last_literal_end := text_count
				last_break_end := 0
				last_comment_end := 0
				last_et_integer_constant_value := ast_factory.new_underscored_integer_constant (Current)
			
end
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 789 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 789")
end

				last_text_count := text_count
				last_literal_start := 1
				last_literal_end := last_text_count
				break_kind := uinteger_break
				more
				set_start_condition (BREAK)
			
end
else
if yy_act = 88 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 797 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 797")
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
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 809 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 809")
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
			
end
end
else
if yy_act <= 91 then
if yy_act = 90 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 821 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 821")
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
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 833 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 833")
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
			
end
else
if yy_act = 92 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 845 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 845")
end

				last_token := E_INTEGER
				last_literal_start := 1
				last_literal_end := text_count
				last_break_end := 0
				last_comment_end := 0
				last_et_integer_constant_value := ast_factory.new_hexadecimal_integer_constant (Current)
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 853 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 853")
end

				last_text_count := text_count
				last_literal_start := 1
				last_literal_end := last_text_count
				break_kind := hinteger_break
				more
				set_start_condition (BREAK)
			
end
end
end
else
if yy_act <= 97 then
if yy_act <= 95 then
if yy_act = 94 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 861 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 861")
end

				last_token := E_INTEGER
				last_literal_start := 1
				last_literal_end := text_count
				last_break_end := 0
				last_comment_end := 0
				last_et_integer_constant_value := ast_factory.new_hexadecimal_integer_constant (Current)
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 869 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 869")
end

				last_text_count := text_count
				last_literal_start := 1
				last_literal_end := last_text_count
				break_kind := hinteger_break
				more
				set_start_condition (BREAK)
			
end
else
if yy_act = 96 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 877 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 877")
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
				last_text_count := text_count
				last_literal_start := 1
				last_literal_end := last_text_count
				break_kind := hinteger_break
				more
				set_start_condition (BREAK)
			
end
end
else
if yy_act <= 99 then
if yy_act = 98 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 901 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 901")
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
				last_text_count := text_count
				last_literal_start := 1
				last_literal_end := last_text_count
				break_kind := hinteger_break
				more
				set_start_condition (BREAK)
			
end
else
if yy_act = 100 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 925 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 925")
end

				last_token := E_INTEGER
				last_literal_start := 1
				last_literal_end := text_count
				last_break_end := 0
				last_comment_end := 0
				last_et_integer_constant_value := ast_factory.new_octal_integer_constant (Current)
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 933 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 933")
end

				last_text_count := text_count
				last_literal_start := 1
				last_literal_end := last_text_count
				break_kind := ointeger_break
				more
				set_start_condition (BREAK)
			
end
end
end
end
end
else
if yy_act <= 118 then
if yy_act <= 110 then
if yy_act <= 106 then
if yy_act <= 104 then
if yy_act <= 103 then
if yy_act = 102 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 941 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 941")
end

				last_token := E_INTEGER
				last_literal_start := 1
				last_literal_end := text_count
				last_break_end := 0
				last_comment_end := 0
				last_et_integer_constant_value := ast_factory.new_octal_integer_constant (Current)
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 949 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 949")
end

				last_text_count := text_count
				last_literal_start := 1
				last_literal_end := last_text_count
				break_kind := ointeger_break
				more
				set_start_condition (BREAK)
			
end
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 957 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 957")
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
else
if yy_act = 105 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 969 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 969")
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
--|#line 981 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 981")
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
end
else
if yy_act <= 108 then
if yy_act = 107 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 993 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 993")
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
--|#line 1005 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1005")
end

				last_token := E_INTEGER
				last_literal_start := 1
				last_literal_end := text_count
				last_break_end := 0
				last_comment_end := 0
				last_et_integer_constant_value := ast_factory.new_binary_integer_constant (Current)
			
end
else
if yy_act = 109 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 1013 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1013")
end

				last_text_count := text_count
				last_literal_start := 1
				last_literal_end := last_text_count
				break_kind := binteger_break
				more
				set_start_condition (BREAK)
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 1021 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1021")
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
if yy_act <= 114 then
if yy_act <= 112 then
if yy_act = 111 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 1029 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1029")
end

				last_text_count := text_count
				last_literal_start := 1
				last_literal_end := last_text_count
				break_kind := binteger_break
				more
				set_start_condition (BREAK)
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 1037 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1037")
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
if yy_act = 113 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 1049 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1049")
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
--|#line 1061 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1061")
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
if yy_act <= 116 then
if yy_act = 115 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 1073 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1073")
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
--|#line 1089 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1089")
end

				last_text_count := text_count
				last_literal_start := 1
				last_literal_end := last_text_count
				break_kind := real_break
				more
				set_start_condition (BREAK)
			
end
else
if yy_act = 117 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 1090 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1090")
end

				last_text_count := text_count
				last_literal_start := 1
				last_literal_end := last_text_count
				break_kind := real_break
				more
				set_start_condition (BREAK)
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 1091 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1091")
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
if yy_act <= 126 then
if yy_act <= 122 then
if yy_act <= 120 then
if yy_act = 119 then
	yy_end := yy_end - 1
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 1099 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1099")
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
--|#line 1100 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1100")
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
if yy_act = 121 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 1101 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1101")
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
--|#line 1112 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1112")
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
if yy_act <= 124 then
if yy_act = 123 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 1113 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1113")
end

				last_text_count := text_count
				last_literal_start := 1
				last_literal_end := last_text_count
				break_kind := ureal_break
				more
				set_start_condition (BREAK)
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 1114 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1114")
end

				last_text_count := text_count
				last_literal_start := 1
				last_literal_end := last_text_count
				break_kind := ureal_break
				more
				set_start_condition (BREAK)
			
end
else
if yy_act = 125 then
	yy_end := yy_end - 1
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 1122 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1122")
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
--|#line 1123 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1123")
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
if yy_act <= 130 then
if yy_act <= 128 then
if yy_act = 127 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 1124 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1124")
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
--|#line 1139 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1139")
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
if yy_act = 129 then
yy_set_line_column
--|#line 1149 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1149")
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
--|#line 1160 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1160")
end

				last_break_end := text_count
				last_comment_end := 0
				process_break
				set_start_condition (INITIAL)
			
end
end
else
if yy_act <= 132 then
if yy_act = 131 then
yy_set_line_column
--|#line 1166 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1166")
end

				last_break_end := 0
				last_comment_end := text_count
				process_break
				set_start_condition (INITIAL)
			
else
	yy_column := yy_column + 1
--|#line 1172 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1172")
end

					-- Should never happen.
				less (0)
				last_break_end := 0
				last_comment_end := 0
				process_break
				set_start_condition (INITIAL)
			
end
else
if yy_act = 133 then
	yy_column := yy_column + 1
--|#line 1193 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1193")
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

	yy_execute_eof_action (yy_sc: INTEGER) is
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

	yy_nxt_template: SPECIAL [INTEGER] is
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 2625)
			yy_nxt_template_1 (an_array)
			yy_nxt_template_2 (an_array)
			yy_nxt_template_3 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_nxt_template_1 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			    0,   22,   23,   24,   23,   25,   26,   27,   22,   28,
			   29,   25,   25,   25,   30,   31,   32,   33,   34,   35,
			   35,   35,   35,   35,   36,   37,   25,   38,   39,   40,
			   40,   40,   40,   40,   40,   40,   41,   40,   25,   42,
			   25,   43,   40,   40,   40,   40,   40,   25,   25,   25,
			   45,   46,   45,   45,   46,   45,   49,   66,   67,   50,
			  405,   51,   47,   49,  403,   47,   50,  400,   51,   53,
			   54,   53,   53,   54,   53,   55,   66,   67,   55,   57,
			   58,   57,   57,   58,   57,   60,   61,   62,  398,   63,
			   60,   61,   62,  191,   63,   69,   70,   69,   69,   70,

			   69,   72,   73,   74,  192,   75,   72,   73,   74,  396,
			   75,   78,   79,   78,   79,   80,   80,   80,   80,   80,
			   80,   82,   82,   82,   94,   94,   94,   81,  148,  149,
			   81,   64,   96,   83,   97,  122,   64,  123,  394,   76,
			   85,   86,   87,   86,   76,   91,   91,   91,   98,   98,
			   98,  392,  111,  408,  390,   92,   92,   92,  388,  408,
			   99,  404,   82,   82,   82,  111,  408,   82,   82,   82,
			  150,  149,   88,  100,   83,  174,  100,  138,  139,   83,
			  140,   89,   82,   82,   82,  114,  100,  132,  133,  132,
			  122,  100,  123,  134,   83,  100,  114,  101,  101,  101,

			  101,  101,  101,  101,  112,  112,  112,  164,  165,  100,
			  102,  102,  102,  135,  136,  135,  113,  141,  138,  142,
			  174,  140,  103,  104,  174,  105,  105,  106,  106,  106,
			  106,  106,  166,  165,   82,   82,   82,  403,  107,  108,
			  138,  145,  122,  146,  123,  109,   83,  154,  155,  110,
			  156,  107,  108,  102,  102,  102,  215,  100,  100,  151,
			  152,  151,  231,  143,  232,  103,  104,  216,  106,  106,
			  106,  106,  106,  106,  106,   82,   82,   82,   82,   82,
			   82,  112,  112,  112,  118,  118,  118,   83,  154,  161,
			   83,  162,  110,  113,  138,  139,  119,  140,  402,  100,

			  100,  365,  100,  118,  118,  118,  124,  124,  124,   80,
			   80,   80,  148,  149,  115,  119,  144,  139,  125,  140,
			  361,   81,  183,  183,  183,  115,  126,  127,  128,  127,
			  126,  129,  126,  129,  126,  129,  129,  126,  126,  126,
			  126,  130,  126,  126,  126,  126,  126,  126,  126,  126,
			  129,  126,  129,  126,  129,  129,  129,  126,  126,  129,
			  129,  126,  126,  126,  126,  126,  126,  131,  131,  131,
			  131,  131,  126,  126,  126,  141,  144,  142,  357,  140,
			  157,  154,  158,  227,  156,  157,  160,  158,  354,  156,
			   82,   82,   82,   85,  228,   87,  168,  168,  168,   84,

			  352,   84,   83,  170,  191,   87,  150,  149,  169,  185,
			  185,  185,   94,   94,   94,  192,  213,  384,  159,  275,
			  114,  143,  114,  159,  174,   88,  179,  180,  179,  213,
			   85,  114,   87,  114,   89,  171,  181,  182,  181,  122,
			   85,  123,   87,  215,  172,  174,  174,  175,  376,  175,
			  175,  189,  189,  189,  216,  176,  218,  128,  218,  132,
			  133,  132,   88,  190,  175,  134,  175,  121,  175,  175,
			  175,   89,   88,  175,  175,  164,  165,  177,  193,  193,
			  193,   89,  121,  204,  204,  204,  178,  135,  136,  135,
			  194,  195,  195,  195,  227,  205,  166,  165,  206,  206,

			  121,  138,  145,  196,  146,  228,  101,  101,  101,  101,
			  101,  101,  101,  208,  208,  208,  208,  208,  208,  251,
			  251,  197,  207,  204,  204,  204,  118,  118,  118,  333,
			  198,  200,  200,  200,  375,  205,  328,  209,  119,  408,
			  141,  138,  142,  201,  140,  298,  202,  202,  202,  202,
			  202,  202,  202,  124,  124,  124,  141,  144,  142,  369,
			  140,  203,  151,  152,  151,  125,  219,  220,  221,  222,
			  222,  222,  222,  144,  145,  322,  146,  223,  223,  223,
			  154,  155,  303,  156,  160,  155,  143,  156,  316,  224,
			  157,  154,  158,  304,  156,  157,  160,  158,  408,  156,

			  154,  161,  143,  162,  160,  161,  314,  162,  225,  225,
			  225,  229,  229,  229,  308,  179,  180,  179,  307,  170,
			  226,   87,  231,  230,   87,  181,  182,  181,  159,  170,
			  177,   87,  298,  159,  257,  257,  239,  180,  239,  178,
			  408,  241,  241,  241,  240,  182,  240,  305,  408,  311,
			  311,  171,  350,  350,  233,  242,  242,  242,  306,  298,
			  172,  171,  281,  234,  189,  189,  189,  243,  339,  339,
			  172,  408,  177,  179,  180,  179,  190,   85,  298,   87,
			  177,  178,  235,  236,  237,  238,  238,  238,  238,  178,
			  181,  182,  181,  347,   85,  346,   87,  344,  191,  191,

			  191,  262,  262,  177,  193,  193,  193,  286,  345,   88,
			   81,  281,  178,  218,  128,  218,  194,  281,   89,  215,
			  215,  215,  259,  259,  259,  207,   88,  227,  227,  227,
			  281,  119,  370,  370,  260,   89,  244,  206,  206,   83,
			  317,  317,  121,  245,  246,  247,  248,  248,  248,  248,
			  195,  195,  195,  266,  266,  266,  266,  266,  266,  386,
			  386,  261,  196,  121,  261,  202,  202,  202,  202,  202,
			  202,  202,  267,  267,  267,  271,  303,  209,  322,  298,
			  255,  271,  271,  271,  268,  348,  348,  304,  269,  256,
			  263,  263,  263,  272,  273,  277,  278,  279,  280,  280,

			  280,  280,  264,  262,  262,  208,  208,  208,  208,  208,
			  208,  269,  286,  286,  286,  289,  180,  289,  267,  231,
			  274,   87,  263,  259,  287,  256,  298,  318,  298,  265,
			  281,  219,  220,  221,  222,  222,  222,  222,  281,  283,
			  283,  283,  283,  284,  285,  285,  290,  182,  290,  408,
			  231,  233,   87,  242,  242,  242,  296,  296,  296,  175,
			  234,  295,  360,  360,  175,  243,  288,  229,  297,  252,
			  252,  252,  252,  252,  252,  252,  328,  328,  328,  225,
			  223,  177,  233,  239,  180,  239,  318,  408,  329,  408,
			  178,  234,  175,  291,  291,  291,  291,  291,  291,  291,

			  175,  292,  292,  292,  292,  293,  294,  294,  175,  294,
			  294,  294,  294,  294,  294,  294,  240,  182,  240,  177,
			  408,  195,  195,  195,  383,  383,  383,  281,  178,  281,
			  214,  211,  408,  196,  258,  258,  258,  258,  258,  258,
			  258,  308,  308,  308,  314,  314,  314,  296,  296,  296,
			  204,  254,  177,  309,  198,  408,  315,  195,  250,  297,
			  307,  178,  298,  300,  300,  300,  300,  301,  302,  302,
			  305,  310,  319,  319,  319,  319,  319,  319,  249,  244,
			  198,  306,  344,  316,  266,  266,  266,  266,  266,  266,
			  330,  330,  330,  345,  331,  381,  265,  282,  282,  282, yy_Dummy>>,
			1, 1000, 0)
		end

	yy_nxt_template_2 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			  282,  381,  332,  333,  333,  333,  382,  168,  320,  324,
			  324,  324,  382,  252,  252,  334,  124,  252,  252,  252,
			  217,  325,  120,  114,  326,  326,  326,  326,  326,  326,
			  326,  289,  180,  289,  114,  231,  117,   87,  214,  327,
			  112,  110,  214,  121,  277,  278,  279,  280,  280,  280,
			  280,  121,  336,  336,  336,  336,  337,  338,  338,  340,
			  341,  342,  343,  343,  343,  343,  211,  233,  290,  182,
			  290,  102,  231,  186,   87,  188,  234,  303,  303,  303,
			  305,  305,  305,  364,  364,  364,  364,  364,  364,  190,
			  186,  167,  194,  312,  312,  312,  312,  312,  312,  312,

			  352,  352,  352,   99,  233,  120,  117,  320,  100,  408,
			  408,  408,  353,  234,  175,  294,  294,  294,  294,  294,
			  294,  294,  175,  294,  294,  294,  294,  294,  294,  294,
			  175,  294,  294,  294,  294,  294,  173,  173,  408,  354,
			  308,  308,  308,  357,  357,  357,  408,  408,  365,  365,
			  365,  408,  309,  408,  408,  358,  408,  408,  317,  317,
			  366,  372,  372,  372,  408,  373,  344,  344,  344,  408,
			  355,  408,  408,  374,  308,  308,  308,  408,  243,  256,
			  408,  408,  359,  361,  361,  361,  309,  367,  121,  338,
			  338,  338,  338,  338,  408,  362,  408,  408,  319,  319,

			  319,  319,  319,  319,  351,  351,  351,  351,  351,  351,
			  351,  408,  408,  307,  408,  308,  308,  308,  388,  388,
			  388,  408,  363,  308,  308,  308,  408,  309,  258,  258,
			  389,  408,  258,  258,  258,  309,  408,  408,  326,  326,
			  326,  326,  326,  326,  326,  408,  394,  394,  394,  398,
			  398,  398,  408,  355,  307,  408,  408,  316,  395,  408,
			  408,  399,  256,  174,  340,  341,  342,  343,  343,  343,
			  343,  174,  378,  378,  378,  378,  379,  380,  380,  390,
			  390,  390,  408,  408,  392,  392,  392,  285,  285,  285,
			  285,  391,  408,  408,  317,  317,  393,  408,  408,  360,

			  360,  174,  380,  380,  380,  380,  380,  400,  400,  400,
			  371,  371,  371,  371,  371,  371,  371,  408,  359,  401,
			  388,  388,  388,  318,  396,  396,  396,  299,  299,  299,
			  299,  408,  389,  372,  372,  372,  397,  373,  408,  364,
			  364,  364,  364,  364,  364,  374,  322,  408,  381,  381,
			  381,  408,  405,  405,  405,  302,  302,  302,  302,  316,
			  297,  408,  408,  320,  406,  387,  387,  387,  387,  387,
			  387,  387,  405,  405,  405,  403,  403,  403,  408,  407,
			  116,  116,  116,  408,  406,  408,  408,  374,  210,  210,
			  210,  354,  116,  210,  210,  212,  212,  212,  312,  312,

			  210,  408,  312,  312,  312,  408,  408,  212,  408,  408,
			  408,  354,   44,   44,   44,   44,   44,   44,   44,   44,
			   44,   44,   44,   44,   44,   44,   44,   44,   44,   44,
			   44,   44,   44,   44,   44,   44,   44,   44,   44,   48,
			   48,   48,   48,   48,   48,   48,   48,   48,   48,   48,
			   48,   48,   48,   48,   48,   48,   48,   48,   48,   48,
			   48,   48,   48,   48,   48,   48,   52,   52,   52,   52,
			   52,   52,   52,   52,   52,   52,   52,   52,   52,   52,
			   52,   52,   52,   52,   52,   52,   52,   52,   52,   52,
			   52,   52,   52,   56,   56,   56,   56,   56,   56,   56,

			   56,   56,   56,   56,   56,   56,   56,   56,   56,   56,
			   56,   56,   56,   56,   56,   56,   56,   56,   56,   56,
			   59,   59,   59,   59,   59,   59,   59,   59,   59,   59,
			   59,   59,   59,   59,   59,   59,   59,   59,   59,   59,
			   59,   59,   59,   59,   59,   59,   59,   65,   65,   65,
			   65,   65,   65,   65,   65,   65,   65,   65,   65,   65,
			   65,   65,   65,   65,   65,   65,   65,   65,   65,   65,
			   65,   65,   65,   65,   68,   68,   68,   68,   68,   68,
			   68,   68,   68,   68,   68,   68,   68,   68,   68,   68,
			   68,   68,   68,   68,   68,   68,   68,   68,   68,   68,

			   68,   71,   71,   71,   71,   71,   71,   71,   71,   71,
			   71,   71,   71,   71,   71,   71,   71,   71,   71,   71,
			   71,   71,   71,   71,   71,   71,   71,   71,   77,   77,
			   77,   77,   77,   77,   77,   77,   77,   77,   77,   77,
			   77,   77,   77,   77,   77,   77,   77,   77,   77,   77,
			   77,   77,   77,   77,   77,   84,   84,  408,   84,   84,
			   84,   84,   84,   84,   84,   84,   84,   84,   84,   84,
			   84,   84,   84,   84,   84,   84,   84,   84,   84,   84,
			   84,   84,   90,   90,   90,   90,  408,  408,   90,   90,
			   90,   90,   90,   90,   90,   90,   90,   90,   90,   90,

			   90,   90,   90,   90,   90,   90,   90,   90,   90,   93,
			   93,   93,   93,  408,  408,   93,   93,   93,   93,   93,
			   93,   93,   93,   93,   93,   93,   93,   93,   93,   93,
			   93,   93,   93,   93,   93,   93,   95,   95,  408,   95,
			   95,   95,   95,   95,   95,   95,   95,   95,   95,   95,
			   95,   95,   95,   95,   95,   95,   95,   95,   95,   95,
			   95,   95,   95,  114,  114,  114,  253,  253,  253,  408,
			  408,  114,  408,  408,  114,  114,  114,  408,  253,  114,
			  114,  114,  114,  114,  114,  114,  114,  114,  114,  121,
			  121,  408,  121,  121,  121,  121,  121,  121,  121,  121,

			  121,  121,  121,  121,  121,  121,  121,  121,  121,  121,
			  121,  121,  121,  121,  121,  121,  137,  137,  137,  137,
			  137,  137,  137,  137,  137,  137,  137,  137,  137,  137,
			  137,  137,  137,  137,  137,  137,  137,  137,  137,  137,
			  137,  137,  137,  143,  143,  143,  143,  143,  143,  143,
			  143,  143,  143,  143,  143,  143,  143,  143,  143,  143,
			  143,  143,  143,  143,  143,  143,  143,  143,  143,  143,
			  147,  147,  147,  147,  147,  147,  147,  147,  147,  147,
			  147,  147,  147,  147,  147,  147,  147,  147,  147,  147,
			  147,  147,  147,  147,  147,  147,  147,  153,  153,  153,

			  153,  153,  153,  153,  153,  153,  153,  153,  153,  153,
			  153,  153,  153,  153,  153,  153,  153,  153,  153,  153,
			  153,  153,  153,  153,  159,  159,  159,  159,  159,  159,
			  159,  159,  159,  159,  159,  159,  159,  159,  159,  159,
			  159,  159,  159,  159,  159,  159,  159,  159,  159,  159,
			  159,  163,  163,  163,  163,  163,  163,  163,  163,  163,
			  163,  163,  163,  163,  163,  163,  163,  163,  163,  163,
			  163,  163,  163,  163,  163,  163,  163,  163,   86,   86,
			  408,   86,   86,   86,   86,   86,   86,   86,   86,   86,
			   86,   86,   86,   86,   86,   86,   86,   86,   86,   86, yy_Dummy>>,
			1, 1000, 1000)
		end

	yy_nxt_template_3 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			   86,   86,   86,   86,   86,  173,  173,  408,  173,  173,
			  173,  173,  173,  173,  173,  173,  173,  173,  173,  173,
			  173,  173,  173,  173,  173,  173,  173,  173,  173,  173,
			  173,  173,  184,  184,  184,  184,  408,  408,  184,  184,
			  184,  184,  184,  184,  408,  408,  408,  184,  184,  187,
			  187,  408,  187,  187,  187,  187,  187,  187,  187,  187,
			  187,  187,  187,  187,  187,  187,  187,  187,  187,  187,
			  187,  187,  187,  187,  187,  187,   99,   99,   99,   99,
			   99,   99,   99,   99,   99,   99,   99,   99,   99,   99,
			   99,   99,   99,   99,   99,   99,   99,   99,   99,   99,

			   99,   99,   99,  199,  199,  199,  199,  199,  199,  199,
			  199,  199,  199,  408,  199,  199,  199,  199,  199,  199,
			  199,  199,  199,  199,  199,  199,  199,  199,  199,  199,
			  120,  120,  120,  120,  120,  120,  120,  120,  120,  120,
			  120,  120,  120,  120,  120,  120,  120,  120,  120,  120,
			  120,  120,  120,  120,  120,  120,  120,  121,  121,  121,
			  121,  351,  351,  408,  121,  351,  351,  351,  121,  121,
			  121,  408,  408,  121,  121,  167,  167,  167,  167,  167,
			  167,  167,  167,  167,  167,  167,  167,  167,  167,  167,
			  167,  167,  167,  167,  167,  167,  167,  167,  167,  167,

			  167,  167,  174,  174,  408,  174,  174,  174,  174,  174,
			  174,  174,  174,  174,  174,  174,  174,  174,  174,  174,
			  174,  174,  174,  174,  174,  174,  174,  174,  174,  175,
			  175,  408,  175,  175,  175,  175,  175,  175,  175,  175,
			  175,  175,  175,  175,  175,  175,  175,  175,  175,  175,
			  175,  175,  175,  175,  175,  175,  184,  184,  184,  184,
			  408,  408,  184,  184,  184,  184,  184,  184,  184,  184,
			  184,  184,  184,  184,  184,  184,  184,  184,  184,  184,
			  184,  184,  184,  270,  270,  270,  408,  408,  270,  270,
			  276,  276,  276,  408,  408,  270,  313,  313,  313,  349,

			  349,  349,  276,  174,  174,  174,  174,  408,  313,  408,
			  174,  349,  408,  408,  174,  174,  174,  408,  408,  174,
			  174,  249,  249,  249,  249,  249,  249,  249,  249,  249,
			  249,  249,  249,  249,  249,  249,  249,  249,  249,  249,
			  249,  249,  249,  249,  249,  249,  249,  249,  250,  250,
			  250,  250,  250,  250,  250,  250,  250,  250,  250,  250,
			  250,  250,  250,  250,  250,  250,  250,  250,  250,  250,
			  250,  250,  250,  250,  250,  321,  321,  321,  408,  408,
			  321,  321,  335,  335,  335,  335,  408,  321,  323,  323,
			  323,  323,  323,  323,  323,  323,  323,  323,  408,  323,

			  323,  323,  323,  323,  323,  323,  323,  323,  323,  323,
			  323,  323,  323,  323,  323,  338,  338,  338,  338,  121,
			  121,  408,  121,  121,  121,  121,  121,  121,  121,  121,
			  121,  121,  121,  121,  121,  121,  121,  121,  121,  121,
			  121,  121,  121,  121,  121,  121,  339,  339,  339,  339,
			  295,  295,  295,  295,  295,  295,  295,  295,  295,  295,
			  295,  295,  295,  295,  295,  295,  295,  295,  295,  295,
			  295,  295,  295,  295,  295,  295,  295,  348,  348,  348,
			  348,  356,  356,  356,  368,  368,  368,  408,  408,  368,
			  368,  408,  408,  356,  371,  371,  368,  408,  371,  371,

			  371,  377,  377,  377,  377,  380,  380,  380,  380,  346,
			  346,  346,  346,  346,  346,  346,  346,  346,  346,  346,
			  346,  346,  346,  346,  346,  346,  346,  346,  346,  346,
			  346,  346,  346,  346,  346,  346,  385,  385,  385,  387,
			  387,  408,  408,  387,  387,  387,  408,  408,  385,  402,
			  402,  402,  402,  402,  402,  402,  402,  402,  402,  402,
			  402,  402,  402,  402,  402,  402,  402,  402,  402,  402,
			  402,  402,  402,  402,  402,  402,   21,  408,  408,  408,
			  408,  408,  408,  408,  408,  408,  408,  408,  408,  408,
			  408,  408,  408,  408,  408,  408,  408,  408,  408,  408,

			  408,  408,  408,  408,  408,  408,  408,  408,  408,  408,
			  408,  408,  408,  408,  408,  408,  408,  408,  408,  408,
			  408,  408,  408,  408,  408,  408, yy_Dummy>>,
			1, 626, 2000)
		end

	yy_chk_template: SPECIAL [INTEGER] is
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 2625)
			yy_chk_template_1 (an_array)
			yy_chk_template_2 (an_array)
			yy_chk_template_3 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_chk_template_1 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    3,    3,    3,    4,    4,    4,    5,   13,   13,    5,
			  406,    5,    3,    6,  402,    4,    6,  401,    6,    7,
			    7,    7,    8,    8,    8,    7,   14,   14,    8,    9,
			    9,    9,   10,   10,   10,   11,   11,   11,  399,   11,
			   12,   12,   12,   99,   12,   15,   15,   15,   16,   16,

			   16,   17,   17,   17,   99,   17,   18,   18,   18,  397,
			   18,   19,   19,   20,   20,   23,   23,   23,   24,   24,
			   24,   25,   25,   25,   28,   28,   28,   23,   65,   65,
			   24,   11,   29,   25,   29,   48,   12,   48,  395,   17,
			   26,   26,   26,   26,   18,   27,   27,   27,   30,   30,
			   30,  393,   34,   34,  391,   27,   27,   27,  389,   34,
			   30,  384,   32,   32,   32,   34,   34,   36,   36,   36,
			   67,   67,   26,   30,   32,  380,   32,   59,   59,   36,
			   59,   26,   31,   31,   31,  114,   32,   53,   53,   53,
			  121,   36,  121,   53,   31,   31,  114,   31,   31,   31,

			   31,   31,   31,   31,   40,   40,   40,   77,   77,   32,
			   33,   33,   33,   57,   57,   57,   40,   60,   60,   60,
			  378,   60,   33,   33,  377,   33,   33,   33,   33,   33,
			   33,   33,   79,   79,   37,   37,   37,  375,   33,   33,
			   64,   64,  129,   64,  129,   33,   37,   71,   71,   33,
			   71,   33,   33,   35,   35,   35,  120,   37,   37,   69,
			   69,   69,  174,   60,  174,   35,   35,  120,   35,   35,
			   35,   35,   35,   35,   35,   38,   38,   38,   39,   39,
			   39,   41,   41,   41,   45,   45,   45,   38,   76,   76,
			   39,   76,   35,   41,  137,  137,   45,  137,  374,   38,

			   38,  366,   39,   46,   46,   46,   50,   50,   50,   80,
			   80,   80,  147,  147,   41,   46,  139,  139,   50,  139,
			  362,   80,   90,   90,   90,   41,   51,   51,   51,   51,
			   51,   51,   51,   51,   51,   51,   51,   51,   51,   51,
			   51,   51,   51,   51,   51,   51,   51,   51,   51,   51,
			   51,   51,   51,   51,   51,   51,   51,   51,   51,   51,
			   51,   51,   51,   51,   51,   51,   51,   51,   51,   51,
			   51,   51,   51,   51,   51,   62,   62,   62,  358,   62,
			   72,   72,   72,  167,   72,   74,   74,   74,  354,   74,
			   82,   82,   82,   84,  167,   84,   85,   85,   85,   86,

			  353,   86,   82,   86,  192,   86,  149,  149,   85,   92,
			   92,   92,   93,   93,   93,  192,  115,  348,   72,  213,
			  115,   62,  213,   74,  343,   84,   88,   88,   88,  115,
			   88,  115,   88,  213,   84,   86,   89,   89,   89,  281,
			   89,  281,   89,  216,   86,   87,  341,   87,  339,   87,
			   87,   98,   98,   98,  216,   87,  127,  127,  127,  132,
			  132,  132,   88,   98,   87,  132,   87,  338,   87,   87,
			   87,   88,   89,   87,   87,  163,  163,   87,  100,  100,
			  100,   89,  336,  107,  107,  107,   87,  135,  135,  135,
			  100,  101,  101,  101,  228,  107,  165,  165,  107,  107,

			  335,  143,  143,  101,  143,  228,  101,  101,  101,  101,
			  101,  101,  101,  108,  108,  108,  108,  108,  108,  197,
			  197,  101,  107,  111,  111,  111,  118,  118,  118,  334,
			  101,  104,  104,  104,  332,  111,  329,  108,  118,  245,
			  141,  141,  141,  104,  141,  245,  104,  104,  104,  104,
			  104,  104,  104,  122,  122,  122,  142,  142,  142,  325,
			  142,  104,  151,  151,  151,  122,  130,  130,  130,  130,
			  130,  130,  130,  145,  145,  322,  145,  146,  146,  146,
			  153,  153,  249,  153,  155,  155,  141,  155,  316,  146,
			  157,  157,  157,  249,  157,  158,  158,  158,  173,  158,

			  159,  159,  142,  159,  161,  161,  315,  161,  162,  162,
			  162,  170,  170,  170,  309,  171,  171,  171,  307,  171,
			  162,  171,  175,  170,  175,  172,  172,  172,  157,  172,
			  173,  172,  302,  158,  203,  203,  177,  177,  177,  173,
			  177,  184,  184,  184,  178,  178,  178,  250,  178,  255,
			  255,  171,  310,  310,  175,  186,  186,  186,  250,  300,
			  171,  172,  284,  175,  189,  189,  189,  186,  284,  284,
			  172,  176,  177,  179,  179,  179,  189,  179,  299,  179,
			  178,  177,  176,  176,  176,  176,  176,  176,  176,  178,
			  181,  181,  181,  298,  181,  297,  181,  295,  191,  191,

			  191,  207,  207,  176,  193,  193,  193,  287,  295,  179,
			  191,  285,  176,  218,  218,  218,  193,  283,  179,  215,
			  215,  215,  206,  206,  206,  207,  181,  227,  227,  227,
			  282,  215,  327,  327,  206,  181,  188,  206,  206,  227,
			  261,  261,  280,  188,  188,  188,  188,  188,  188,  188,
			  202,  202,  202,  209,  209,  209,  209,  209,  209,  355,
			  355,  206,  202,  278,  261,  202,  202,  202,  202,  202,
			  202,  202,  210,  210,  210,  272,  304,  209,  270,  301,
			  202,  212,  212,  212,  210,  301,  301,  304,  269,  202,
			  208,  208,  208,  212,  212,  217,  217,  217,  217,  217,

			  217,  217,  208,  262,  262,  208,  208,  208,  208,  208,
			  208,  210,  231,  231,  231,  233,  233,  233,  268,  233,
			  212,  233,  264,  260,  231,  256,  248,  262,  246,  208,
			  219,  219,  219,  219,  219,  219,  219,  219,  221,  221,
			  221,  221,  221,  221,  221,  221,  234,  234,  234,  294,
			  234,  233,  234,  242,  242,  242,  244,  244,  244,  294,
			  233,  243,  318,  318,  235,  242,  232,  230,  244,  251,
			  251,  251,  251,  251,  251,  251,  274,  274,  274,  226,
			  224,  294,  234,  239,  239,  239,  318,  239,  274,  274,
			  294,  234,  236,  236,  236,  236,  236,  236,  236,  236,

			  237,  237,  237,  237,  237,  237,  237,  237,  238,  238,
			  238,  238,  238,  238,  238,  238,  240,  240,  240,  239,
			  240,  252,  252,  252,  347,  347,  347,  222,  239,  220,
			  214,  211,  252,  252,  257,  257,  257,  257,  257,  257,
			  257,  253,  253,  253,  258,  258,  258,  296,  296,  296,
			  205,  201,  240,  253,  198,  258,  258,  196,  194,  296,
			  252,  240,  247,  247,  247,  247,  247,  247,  247,  247,
			  306,  253,  265,  265,  265,  265,  265,  265,  190,  187,
			  253,  306,  345,  258,  266,  266,  266,  266,  266,  266,
			  275,  275,  275,  345,  275,  346,  265,  450,  450,  450, yy_Dummy>>,
			1, 1000, 0)
		end

	yy_chk_template_2 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			  450,  382,  275,  276,  276,  276,  346,  169,  266,  273,
			  273,  273,  382,  445,  445,  276,  125,  445,  445,  445,
			  123,  273,  119,  275,  273,  273,  273,  273,  273,  273,
			  273,  289,  289,  289,  275,  289,  117,  289,  116,  273,
			  113,  110,  276,  277,  277,  277,  277,  277,  277,  277,
			  277,  279,  279,  279,  279,  279,  279,  279,  279,  288,
			  288,  288,  288,  288,  288,  288,  109,  289,  290,  290,
			  290,  103,  290,   97,  290,   96,  289,  303,  303,  303,
			  305,  305,  305,  320,  320,  320,  320,  320,  320,  303,
			   95,   83,  305,  311,  311,  311,  311,  311,  311,  311,

			  312,  312,  312,   81,  290,   47,   43,  320,   42,   21,
			    0,  312,  312,  290,  291,  291,  291,  291,  291,  291,
			  291,  291,  292,  292,  292,  292,  292,  292,  292,  292,
			  293,  293,  293,  293,  293,  293,  293,  293,    0,  312,
			  313,  313,  313,  317,  317,  317,    0,    0,  321,  321,
			  321,    0,  313,    0,    0,  317,    0,    0,  317,  317,
			  321,  330,  330,  330,    0,  330,  344,  344,  344,    0,
			  313,    0,    0,  330,  349,  349,  349,    0,  344,  313,
			    0,    0,  317,  319,  319,  319,  349,  321,  337,  337,
			  337,  337,  337,  337,    0,  319,    0,    0,  319,  319,

			  319,  319,  319,  319,  350,  350,  350,  350,  350,  350,
			  350,    0,    0,  349,    0,  351,  351,  351,  356,  356,
			  356,    0,  319,  326,  326,  326,  351,  351,  447,  447,
			  356,    0,  447,  447,  447,  326,    0,    0,  326,  326,
			  326,  326,  326,  326,  326,    0,  363,  363,  363,  367,
			  367,  367,    0,  326,  351,    0,    0,  356,  363,    0,
			    0,  367,  326,  340,  340,  340,  340,  340,  340,  340,
			  340,  342,  342,  342,  342,  342,  342,  342,  342,  359,
			  359,  359,    0,    0,  360,  360,  360,  451,  451,  451,
			  451,  359,    0,    0,  359,  359,  360,    0,    0,  360,

			  360,  379,  379,  379,  379,  379,  379,  368,  368,  368,
			  370,  370,  370,  370,  370,  370,  370,    0,  359,  368,
			  371,  371,  371,  360,  364,  364,  364,  453,  453,  453,
			  453,  371,  371,  372,  372,  372,  364,  372,    0,  364,
			  364,  364,  364,  364,  364,  372,  368,    0,  381,  381,
			  381,    0,  385,  385,  385,  454,  454,  454,  454,  371,
			  381,    0,    0,  364,  385,  386,  386,  386,  386,  386,
			  386,  386,  387,  387,  387,  403,  403,  403,    0,  403,
			  423,  423,  423,  387,  387,    0,    0,  403,  437,  437,
			  437,  385,  423,  437,  437,  438,  438,  438,  457,  457,

			  437,    0,  457,  457,  457,    0,    0,  438,    0,    0,
			    0,  387,  409,  409,  409,  409,  409,  409,  409,  409,
			  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,
			  409,  409,  409,  409,  409,  409,  409,  409,  409,  410,
			  410,  410,  410,  410,  410,  410,  410,  410,  410,  410,
			  410,  410,  410,  410,  410,  410,  410,  410,  410,  410,
			  410,  410,  410,  410,  410,  410,  411,  411,  411,  411,
			  411,  411,  411,  411,  411,  411,  411,  411,  411,  411,
			  411,  411,  411,  411,  411,  411,  411,  411,  411,  411,
			  411,  411,  411,  412,  412,  412,  412,  412,  412,  412,

			  412,  412,  412,  412,  412,  412,  412,  412,  412,  412,
			  412,  412,  412,  412,  412,  412,  412,  412,  412,  412,
			  413,  413,  413,  413,  413,  413,  413,  413,  413,  413,
			  413,  413,  413,  413,  413,  413,  413,  413,  413,  413,
			  413,  413,  413,  413,  413,  413,  413,  414,  414,  414,
			  414,  414,  414,  414,  414,  414,  414,  414,  414,  414,
			  414,  414,  414,  414,  414,  414,  414,  414,  414,  414,
			  414,  414,  414,  414,  415,  415,  415,  415,  415,  415,
			  415,  415,  415,  415,  415,  415,  415,  415,  415,  415,
			  415,  415,  415,  415,  415,  415,  415,  415,  415,  415,

			  415,  416,  416,  416,  416,  416,  416,  416,  416,  416,
			  416,  416,  416,  416,  416,  416,  416,  416,  416,  416,
			  416,  416,  416,  416,  416,  416,  416,  416,  417,  417,
			  417,  417,  417,  417,  417,  417,  417,  417,  417,  417,
			  417,  417,  417,  417,  417,  417,  417,  417,  417,  417,
			  417,  417,  417,  417,  417,  418,  418,    0,  418,  418,
			  418,  418,  418,  418,  418,  418,  418,  418,  418,  418,
			  418,  418,  418,  418,  418,  418,  418,  418,  418,  418,
			  418,  418,  419,  419,  419,  419,    0,    0,  419,  419,
			  419,  419,  419,  419,  419,  419,  419,  419,  419,  419,

			  419,  419,  419,  419,  419,  419,  419,  419,  419,  420,
			  420,  420,  420,    0,    0,  420,  420,  420,  420,  420,
			  420,  420,  420,  420,  420,  420,  420,  420,  420,  420,
			  420,  420,  420,  420,  420,  420,  421,  421,    0,  421,
			  421,  421,  421,  421,  421,  421,  421,  421,  421,  421,
			  421,  421,  421,  421,  421,  421,  421,  421,  421,  421,
			  421,  421,  421,  422,  422,  422,  446,  446,  446,    0,
			    0,  422,    0,    0,  422,  422,  422,    0,  446,  422,
			  422,  422,  422,  422,  422,  422,  422,  422,  422,  424,
			  424,    0,  424,  424,  424,  424,  424,  424,  424,  424,

			  424,  424,  424,  424,  424,  424,  424,  424,  424,  424,
			  424,  424,  424,  424,  424,  424,  425,  425,  425,  425,
			  425,  425,  425,  425,  425,  425,  425,  425,  425,  425,
			  425,  425,  425,  425,  425,  425,  425,  425,  425,  425,
			  425,  425,  425,  426,  426,  426,  426,  426,  426,  426,
			  426,  426,  426,  426,  426,  426,  426,  426,  426,  426,
			  426,  426,  426,  426,  426,  426,  426,  426,  426,  426,
			  427,  427,  427,  427,  427,  427,  427,  427,  427,  427,
			  427,  427,  427,  427,  427,  427,  427,  427,  427,  427,
			  427,  427,  427,  427,  427,  427,  427,  428,  428,  428,

			  428,  428,  428,  428,  428,  428,  428,  428,  428,  428,
			  428,  428,  428,  428,  428,  428,  428,  428,  428,  428,
			  428,  428,  428,  428,  429,  429,  429,  429,  429,  429,
			  429,  429,  429,  429,  429,  429,  429,  429,  429,  429,
			  429,  429,  429,  429,  429,  429,  429,  429,  429,  429,
			  429,  430,  430,  430,  430,  430,  430,  430,  430,  430,
			  430,  430,  430,  430,  430,  430,  430,  430,  430,  430,
			  430,  430,  430,  430,  430,  430,  430,  430,  431,  431,
			    0,  431,  431,  431,  431,  431,  431,  431,  431,  431,
			  431,  431,  431,  431,  431,  431,  431,  431,  431,  431, yy_Dummy>>,
			1, 1000, 1000)
		end

	yy_chk_template_3 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			  431,  431,  431,  431,  431,  432,  432,    0,  432,  432,
			  432,  432,  432,  432,  432,  432,  432,  432,  432,  432,
			  432,  432,  432,  432,  432,  432,  432,  432,  432,  432,
			  432,  432,  433,  433,  433,  433,    0,    0,  433,  433,
			  433,  433,  433,  433,    0,    0,    0,  433,  433,  434,
			  434,    0,  434,  434,  434,  434,  434,  434,  434,  434,
			  434,  434,  434,  434,  434,  434,  434,  434,  434,  434,
			  434,  434,  434,  434,  434,  434,  435,  435,  435,  435,
			  435,  435,  435,  435,  435,  435,  435,  435,  435,  435,
			  435,  435,  435,  435,  435,  435,  435,  435,  435,  435,

			  435,  435,  435,  436,  436,  436,  436,  436,  436,  436,
			  436,  436,  436,    0,  436,  436,  436,  436,  436,  436,
			  436,  436,  436,  436,  436,  436,  436,  436,  436,  436,
			  439,  439,  439,  439,  439,  439,  439,  439,  439,  439,
			  439,  439,  439,  439,  439,  439,  439,  439,  439,  439,
			  439,  439,  439,  439,  439,  439,  439,  440,  440,  440,
			  440,  468,  468,    0,  440,  468,  468,  468,  440,  440,
			  440,    0,    0,  440,  440,  441,  441,  441,  441,  441,
			  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,
			  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,

			  441,  441,  442,  442,    0,  442,  442,  442,  442,  442,
			  442,  442,  442,  442,  442,  442,  442,  442,  442,  442,
			  442,  442,  442,  442,  442,  442,  442,  442,  442,  443,
			  443,    0,  443,  443,  443,  443,  443,  443,  443,  443,
			  443,  443,  443,  443,  443,  443,  443,  443,  443,  443,
			  443,  443,  443,  443,  443,  443,  444,  444,  444,  444,
			    0,    0,  444,  444,  444,  444,  444,  444,  444,  444,
			  444,  444,  444,  444,  444,  444,  444,  444,  444,  444,
			  444,  444,  444,  448,  448,  448,    0,    0,  448,  448,
			  449,  449,  449,    0,    0,  448,  458,  458,  458,  467,

			  467,  467,  449,  452,  452,  452,  452,    0,  458,    0,
			  452,  467,    0,    0,  452,  452,  452,    0,    0,  452,
			  452,  455,  455,  455,  455,  455,  455,  455,  455,  455,
			  455,  455,  455,  455,  455,  455,  455,  455,  455,  455,
			  455,  455,  455,  455,  455,  455,  455,  455,  456,  456,
			  456,  456,  456,  456,  456,  456,  456,  456,  456,  456,
			  456,  456,  456,  456,  456,  456,  456,  456,  456,  456,
			  456,  456,  456,  456,  456,  459,  459,  459,    0,    0,
			  459,  459,  461,  461,  461,  461,    0,  459,  460,  460,
			  460,  460,  460,  460,  460,  460,  460,  460,    0,  460,

			  460,  460,  460,  460,  460,  460,  460,  460,  460,  460,
			  460,  460,  460,  460,  460,  462,  462,  462,  462,  463,
			  463,    0,  463,  463,  463,  463,  463,  463,  463,  463,
			  463,  463,  463,  463,  463,  463,  463,  463,  463,  463,
			  463,  463,  463,  463,  463,  463,  464,  464,  464,  464,
			  465,  465,  465,  465,  465,  465,  465,  465,  465,  465,
			  465,  465,  465,  465,  465,  465,  465,  465,  465,  465,
			  465,  465,  465,  465,  465,  465,  465,  466,  466,  466,
			  466,  469,  469,  469,  470,  470,  470,    0,    0,  470,
			  470,    0,    0,  469,  471,  471,  470,    0,  471,  471,

			  471,  472,  472,  472,  472,  473,  473,  473,  473,  474,
			  474,  474,  474,  474,  474,  474,  474,  474,  474,  474,
			  474,  474,  474,  474,  474,  474,  474,  474,  474,  474,
			  474,  474,  474,  474,  474,  474,  475,  475,  475,  476,
			  476,    0,    0,  476,  476,  476,    0,    0,  475,  477,
			  477,  477,  477,  477,  477,  477,  477,  477,  477,  477,
			  477,  477,  477,  477,  477,  477,  477,  477,  477,  477,
			  477,  477,  477,  477,  477,  477,  408,  408,  408,  408,
			  408,  408,  408,  408,  408,  408,  408,  408,  408,  408,
			  408,  408,  408,  408,  408,  408,  408,  408,  408,  408,

			  408,  408,  408,  408,  408,  408,  408,  408,  408,  408,
			  408,  408,  408,  408,  408,  408,  408,  408,  408,  408,
			  408,  408,  408,  408,  408,  408, yy_Dummy>>,
			1, 626, 2000)
		end

	yy_base_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,   48,   51,   53,   60,   67,   70,   77,
			   80,   83,   88,   54,   73,   93,   96,   99,  104,  108,
			  110, 1109, 2576,  113,  116,  119,  134,  143,  122,  124,
			  146,  180,  160,  208,  122,  251,  165,  232,  273,  276,
			  202,  279, 1069, 1065, 2576,  282,  301, 1091,  129, 2576,
			  304,  325, 2576,  185, 2576, 2576, 2576,  211, 2576,  174,
			  215, 2576,  373, 2576,  237,  125, 2576,  167, 2576,  257,
			 2576,  244,  378, 2576,  383, 2576,  285,  204, 2576,  229,
			  307, 1089,  388, 1077,  387,  394,  397,  439,  424,  434,
			  320, 2576,  407,  410, 2576, 1080, 1059, 1063,  449,   90,

			  476,  489, 2576, 1057,  529,    0,    0,  481,  496, 1025,
			 1000,  521, 2576, 1026,  150,  385,  997,  995,  524, 1008,
			  253,  184,  551, 1004, 2576, 1002, 2576,  454, 2576,  236,
			  549, 2576,  457, 2576, 2576,  485, 2576,  291, 2576,  313,
			 2576,  538,  554,  498, 2576,  570,  575,  309, 2576,  403,
			 2576,  560, 2576,  577, 2576,  581, 2576,  588,  593,  597,
			 2576,  601,  606,  472, 2576,  493, 2576,  380, 2576,  993,
			  609,  613,  623,  592,  256,  616,  665,  634,  642,  671,
			 2576,  688, 2576, 2576,  639, 2576,  653,  969,  726,  662,
			  964,  696,  401,  702,  944, 2576,  943,  506,  913, 2576,

			 2576,  937,  748,  621, 2576,  936,  720,  684,  788,  736,
			  770,  890,  779,  387,  889,  717,  440,  778,  711,  814,
			  913,  822,  911, 2576,  866, 2576,  865,  725,  491, 2576,
			  853,  810,  850,  813,  844,  848,  876,  884,  892,  881,
			  914, 2576,  851,  847,  854,  529,  812,  946,  810,  579,
			  644,  852,  919,  939, 2576,  636,  784,  917,  942, 2576,
			  809,  723,  786, 2576,  808,  955,  967, 2576,  804,  747,
			  737, 2576,  761, 1007,  874,  988, 1001, 1027,  747, 1035,
			  726,  433,  714,  701,  646,  695, 2576,  693, 1042, 1029,
			 1066, 1098, 1106, 1114,  843,  694,  945,  681,  683,  662,

			  643,  763,  616, 1075,  773, 1078,  967,  577, 2576,  600,
			  639, 1076, 1098, 1138, 2576,  592,  547, 1141,  845, 1181,
			 1066, 1146,  534, 2576, 2576,  545, 1221,  719, 2576,  522,
			 1159, 2576,  520, 2576,  515,  484,  466, 1172,  451,  432,
			 1247,  430, 1255,  408, 1164,  979,  992,  922,  401, 1172,
			 1187, 1213, 2576,  386,  347,  746, 1216, 2576,  364, 1277,
			 1282, 2576,  306, 1244, 1322, 2576,  287, 1247, 1305, 2576,
			 1293, 1318, 1331, 2576,  284,  234, 2576,  208,  204, 1285,
			  159, 1346,  998, 2576,  151, 1350, 1348, 1370, 2576,  144,
			 2576,  140, 2576,  137, 2576,  124, 2576,   95, 2576,   74,

			 2576,   53,   61, 1373, 2576, 2576,   46, 2576, 2576, 1411,
			 1438, 1465, 1492, 1519, 1546, 1573, 1600, 1627, 1654, 1681,
			 1708, 1735, 1761, 1367, 1788, 1815, 1842, 1869, 1896, 1923,
			 1950, 1977, 2004, 2031, 2048, 2075, 2102, 1375, 1382, 2129,
			 2152, 2174, 2201, 2228, 2255, 1004, 1753, 1219, 2270, 2277,
			  985, 1275, 2298, 1315, 1343, 2320, 2347, 1389, 2283, 2362,
			 2387, 2370, 2403, 2418, 2434, 2449, 2465, 2286, 2152, 2468,
			 2471, 2485, 2489, 2493, 2508, 2523, 2530, 2548, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  408,    1,  409,  409,  410,  410,  411,  411,  412,
			  412,  413,  413,  414,  414,  415,  415,  416,  416,  417,
			  417,  408,  408,  408,  408,  408,  418,  419,  420,  421,
			  408,  408,  408,  408,   33,  408,  408,  408,  408,  408,
			  422,  422,  408,  423,  408,  408,  408,  408,  424,  408,
			  408,  408,  408,  408,  408,  408,  408,  408,  408,  425,
			  425,  408,  425,  408,  426,  427,  408,  427,  408,  408,
			  408,  428,  428,  408,  428,  408,  429,  430,  408,  430,
			  408,  408,  408,  408,  418,  408,  431,  432,  418,  418,
			  419,  408,  433,  420,  408,  408,  434,  408,  408,  435,

			  408,  408,  408,  408,  436,   34,   35,  408,  408,  437,
			  438,  408,  408,  408,   41,   41,  423,  423,  408,  408,
			  439,  424,  408,  440,  408,  408,  408,  408,  408,  424,
			  408,  408,  408,  408,  408,  408,  408,  425,  408,  425,
			  408,  425,  425,  426,  408,  426,  408,  427,  408,  427,
			  408,  408,  408,  428,  408,  428,  408,  428,  428,  429,
			  408,  429,  408,  430,  408,  430,  408,  441,  408,  408,
			  408,  431,  431,  432,  442,  443,  432,  432,  432,  418,
			  408,  418,  408,  408,  444,  408,  408,  408,  408,  408,
			  408,  408,  435,  408,  408,  408,  408,  445,  446,  408,

			  408,  408,  408,  447,  408,  408,  408,  408,  408,  408,
			  437,  448,  438,   41,  449,  408,  439,  408,  408,  408,
			  450,  408,  451,  408,  408,  408,  408,  408,  441,  408,
			  408,  408,  452,  443,  443,  176,  176,  176,  176,  432,
			  432,  408,  408,  408,  408,  188,  453,  408,  454,  455,
			  456,  408,  445,  446,  408,  457,  458,  408,  447,  408,
			  408,  408,  408,  408,  408,  408,  408,  408,  408,  459,
			  448,  408,  408,  460,  212,   41,  449,  408,  461,  408,
			  462,  463,  451,  451,  451,  464,  408,  408,  408,  443,
			  443,  176,  176,  176,  432,  465,  408,  408,  408,  454,

			  454,  454,  466,  408,  455,  408,  456,  467,  408,  408,
			  468,  408,  457,  458,  408,  408,  469,  408,  408,  408,
			  408,  459,  470,  408,  408,  408,  408,  471,  408,  408,
			  408,  408,  408,  408,  408,  462,  462,  408,  408,  464,
			  408,  472,  408,  473,  408,  465,  474,  408,  466,  467,
			  408,  468,  408,  408,  475,  476,  469,  408,  408,  408,
			  408,  408,  408,  319,  408,  408,  408,  321,  470,  408,
			  408,  471,  408,  408,  408,  477,  408,  473,  473,  408,
			  408,  408,  474,  408,  408,  475,  408,  476,  408,  408,
			  408,  408,  408,  408,  408,  408,  408,  408,  408,  408,

			  408,  408,  477,  408,  408,  408,  408,  408,    0,  408,
			  408,  408,  408,  408,  408,  408,  408,  408,  408,  408,
			  408,  408,  408,  408,  408,  408,  408,  408,  408,  408,
			  408,  408,  408,  408,  408,  408,  408,  408,  408,  408,
			  408,  408,  408,  408,  408,  408,  408,  408,  408,  408,
			  408,  408,  408,  408,  408,  408,  408,  408,  408,  408,
			  408,  408,  408,  408,  408,  408,  408,  408,  408,  408,
			  408,  408,  408,  408,  408,  408,  408,  408, yy_Dummy>>)
		end

	yy_ec_template: SPECIAL [INTEGER] is
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
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,

			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1, yy_Dummy>>)
		end

	yy_meta_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    1,    2,    3,    4,    1,    5,    1,    6,    1,
			    7,    8,    1,    9,   10,   11,   12,   13,   13,   13,
			   13,   13,   14,   15,    1,   16,    1,   17,    1,   18,
			   18,   18,   19,   20,   21,   22,   23,   24,    1,    1,
			    1,   25,   19,   19,   19,   26,   27,    1,    1,    1, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    2,    3,    4,    5,    5,    5,    6,    7,
			    8,    9,   10,   12,   16,   19,   22,   25,   28,   31,
			   34,   37,   40,   43,   47,   51,   55,   58,   61,   64,
			   67,   71,   75,   77,   79,   81,   85,   88,   90,   92,
			   94,   97,   99,  101,  103,  105,  108,  110,  112,  114,
			  116,  118,  120,  122,  124,  126,  128,  130,  132,  134,
			  136,  138,  140,  142,  144,  146,  148,  150,  152,  154,
			  156,  158,  158,  160,  160,  161,  165,  166,  166,  168,
			  170,  171,  172,  173,  174,  175,  176,  177,  179,  180,

			  181,  182,  186,  187,  187,  188,  190,  192,  194,  194,
			  194,  194,  196,  197,  197,  199,  201,  201,  201,  203,
			  203,  204,  205,  207,  207,  208,  208,  209,  210,  211,
			  213,  215,  217,  217,  218,  219,  219,  220,  221,  222,
			  223,  224,  225,  226,  227,  229,  230,  233,  234,  235,
			  236,  238,  238,  239,  240,  241,  242,  243,  244,  245,
			  246,  248,  249,  252,  253,  254,  255,  257,  258,  260,
			  260,  266,  268,  270,  270,  271,  272,  272,  273,  274,
			  275,  276,  277,  278,  279,  280,  281,  282,  283,  285,
			  287,  287,  288,  289,  291,  291,  293,  293,  293,  293,

			  294,  296,  297,  301,  302,  303,  303,  305,  305,  307,
			  307,  309,  309,  311,  313,  313,  314,  315,  315,  315,
			  316,  317,  318,  319,  320,  320,  321,  321,  322,  323,
			  326,  326,  328,  328,  330,  332,  332,  332,  332,  332,
			  332,  332,  333,  335,  335,  336,  337,  338,  339,  340,
			  341,  342,  342,  346,  348,  349,  349,  349,  349,  353,
			  354,  354,  354,  354,  355,  355,  355,  355,  356,  356,
			  356,  356,  357,  357,  358,  360,  362,  364,  364,  364,
			  364,  364,  367,  368,  369,  370,  371,  372,  372,  372,
			  373,  374,  374,  374,  374,  374,  375,  377,  377,  378,

			  379,  380,  381,  382,  383,  384,  385,  386,  386,  387,
			  387,  387,  387,  395,  397,  399,  399,  399,  401,  401,
			  403,  403,  405,  405,  406,  408,  409,  411,  412,  413,
			  413,  414,  415,  415,  416,  416,  416,  416,  416,  416,
			  417,  417,  417,  417,  417,  418,  419,  420,  422,  423,
			  425,  425,  427,  431,  431,  431,  431,  433,  434,  434,
			  436,  438,  439,  439,  441,  443,  444,  444,  446,  448,
			  449,  449,  451,  451,  453,  453,  454,  455,  455,  455,
			  455,  455,  456,  457,  458,  459,  463,  463,  467,  468,
			  468,  469,  469,  470,  470,  471,  471,  472,  472,  473,

			  473,  474,  474,  474,  474,  475,  477,  477,  478,  478, yy_Dummy>>)
		end

	yy_acclist_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,   48,   48,   51,   51,   60,   60,   63,   63,  135,
			  133,  134,  128,  129,  133,  134,  128,  129,  134,    1,
			  133,  134,   66,  133,  134,   13,  133,  134,   17,  133,
			  134,   35,  133,  134,    1,  133,  134,    1,  133,  134,
			    1,  133,  134,   84,  133,  134, -219,   84,  133,  134,
			 -219,   84,  133,  134, -219,    1,  133,  134,    1,  133,
			  134,    1,  133,  134,    1,  133,  134,   11,  133,  134,
			 -146,   11,  133,  134, -146,  133,  134,  133,  134,  132,
			  134,  130,  131,  132,  134,  130,  131,  134,  132,  134,
			   73,  134,   78,  134,   74,  134, -209,   77,  134,   81,

			  134,   81,  134,   80,  134,   79,   81,  134,   42,  134,
			   42,  134,   41,  134,   48,  134,   48,  134,   47,  134,
			   48,  134,   45,  134,   48,  134,   51,  134,   50,  134,
			   51,  134,   54,  134,   54,  134,   53,  134,   60,  134,
			   60,  134,   59,  134,   60,  134,   57,  134,   60,  134,
			   63,  134,   62,  134,   63,  134,  128,  129,    2,    3,
			   66,   38,   64, -173, -199,   66,   66, -186,   66, -174,
			   16,   18,   14,   17,   22,   35,   35,   34,   35,    2,
			  129,    5,  121,  127, -252, -258,  -85, -250,   84, -219,
			   84, -219,   82, -217,   82, -217,  -12,   11, -146,   11,

			 -146,  130,  131,  131,   73,   74, -209,  -75,   76,   76,
			   67,   73,   76,   71,   76,   72,   76,   80,   79,   41,
			   48,   47,   48,   45,   48,   48,   48,   46,   47,   48,
			   43,   45, -178,   51,   50,   51,   49,   50,   53,   60,
			   59,   60,   57,   60,   60,   60,   58,   59,   60,   55,
			   57, -190,   63,   62,   63,   61,   62,    3,  -39,  -65,
			   36,   38,   64, -171, -173, -199,   66, -186,   66, -174,
			   66,   66, -186, -174,   66,  -52,   66,  -40,   21,   15,
			   19,   23,   35,   33,   35,    2,    4,  129,  129,    6,
			    7, -118, -124,  119, -116,  119,  119,  121,  127, -252,

			 -258,  119,  -83,  108, -243,  100, -235,   92, -227,   86,
			 -221,   11, -146,  131,  131,   70,   70,   70,   70,  -44,
			  -56,    3,    3,  -37,  -39,  -65,   64, -199,   66, -186,
			   66, -174,   20,   24,   25,   26,   32,   32,   32,   32,
			    4,    7,  121,  127, -252, -258,  127, -258, -116,  120,
			  126, -251, -257, -109, -101,  -93,  -87, -256,   90, -225,
			   11, -146,   88, -223,   68,   69,   73,   70,   70,   70,
			   70,  -65,   66,   66,   25,   27,   28,   35,   32,   32,
			   32,   32,    4,    4,    7,    7, -124,  120,  121,  126,
			  127, -251, -252, -257, -258,  127, -258, -117, -123,  110,

			 -245,  102, -237,   94, -229,  125, -122,  125,  125,  127,
			 -258,  125,  -91,  -12,    8,  -89,   70,   25,   25,   28,
			   29,   31,   32,  127, -258,  127, -258, -117, -118, -123,
			 -124,  126, -257, -111,  114, -249,  112, -247, -103,  106,
			 -241,  104, -239,  -95,   98, -233,   96, -231, -122,  126,
			 -257,    9,   10,  -12,   69,   28,   28,   30,   35,  126,
			  127, -257, -258,  126,  127, -257, -258, -123, -115, -113,
			 -107, -105,  -99,  -97,   31, -123, -124,   10, yy_Dummy>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 2576
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 408
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 409
			-- Mark between normal states and templates

	yyNull_equiv_class: INTEGER is 1
			-- Equivalence code for NULL character

	yyReject_used: BOOLEAN is false
			-- Is `reject' called?

	yyVariable_trail_context: BOOLEAN is true
			-- Is there a regular expression with
			-- both leading and trailing parts having
			-- variable length?

	yyReject_or_variable_trail_context: BOOLEAN is true
			-- Is `reject' called or is there a
			-- regular expression with both leading
			-- and trailing parts having variable length?

	yyNb_rules: INTEGER is 134
			-- Number of rules

	yyEnd_of_buffer: INTEGER is 135
			-- End of buffer rule code

	yyLine_used: BOOLEAN is true
			-- Are line and column numbers used?

	yyPosition_used: BOOLEAN is false
			-- Is `position' used?

	INITIAL: INTEGER is 0
	BREAK: INTEGER is 1
	MS: INTEGER is 2
	MSN: INTEGER is 3
	VS1: INTEGER is 4
	VS2: INTEGER is 5
	VS3: INTEGER is 6
	LAVS1: INTEGER is 7
	LAVS2: INTEGER is 8
	LAVS3: INTEGER is 9
			-- Start condition codes

feature -- User-defined features



feature -- Scanning

	read_token is
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
						yy_state_stack.put (yy_current_state, 0)
						yy_state_count := 1
					end
					yy_goto := yyMatch
				when yyMatch then
						-- Find the next match.
					from
						yy_done := False
					until
						yy_done
					loop
						if yy_ec /= Void then
							yy_c := yy_ec.item (yy_content_area.item (yy_cp).code)
						else
							yy_c := yy_content_area.item (yy_cp).code
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
							yy_state_stack.put (yy_current_state, yy_state_count)
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
