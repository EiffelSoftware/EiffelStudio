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
if yy_act <= 64 then
if yy_act <= 32 then
if yy_act <= 16 then
if yy_act <= 8 then
if yy_act <= 4 then
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
if yy_act = 3 then
yy_set_line_column
--|#line 48 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 48")
end

				last_text_count := 1
				last_break_end := 0
				last_comment_end := text_count
				process_one_char_symbol (text_item (1))
			
else
yy_set_line_column
--|#line 54 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 54")
end

				last_text_count := 1
				last_break_end := 0
				last_comment_end := text_count
				process_one_char_symbol ('-')
			
end
end
else
if yy_act <= 6 then
if yy_act = 5 then
	yy_column := yy_column + 2
--|#line 60 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 60")
end

				last_break_end := 0
				last_comment_end := 0
				process_two_char_symbol (text_item (1), text_item (2))
			
else
yy_set_line_column
--|#line 65 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 65")
end

				last_text_count := 2
				last_break_end := text_count
				last_comment_end := 0
				process_two_char_symbol (text_item (1), text_item (2))
			
end
else
if yy_act = 7 then
yy_set_line_column
--|#line 71 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 71")
end

				last_text_count := 2
				last_break_end := 0
				last_comment_end := text_count
				process_two_char_symbol (text_item (1), text_item (2))
			
else
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
			
end
end
end
else
if yy_act <= 12 then
if yy_act <= 10 then
if yy_act = 9 then
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
			
else
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
			
end
else
if yy_act = 11 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 123 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 123")
end

				last_break_end := 0
				last_comment_end := 0
				process_identifier (text_count)
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 128 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 128")
end

				last_text_count := text_count
				break_kind := identifier_break
				more
				set_start_condition (BREAK)
			
end
end
else
if yy_act <= 14 then
if yy_act = 13 then
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
			
else
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
			
end
else
if yy_act = 15 then
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
			
else
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
			
end
end
end
end
else
if yy_act <= 24 then
if yy_act <= 20 then
if yy_act <= 18 then
if yy_act = 17 then
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
			
else
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
			
end
else
if yy_act = 19 then
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
end
else
if yy_act <= 22 then
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
else
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
end
end
else
if yy_act <= 28 then
if yy_act <= 26 then
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
else
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
end
else
if yy_act <= 30 then
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
else
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
end
end
end
end
else
if yy_act <= 48 then
if yy_act <= 40 then
if yy_act <= 36 then
if yy_act <= 34 then
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
else
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
end
else
if yy_act <= 38 then
if yy_act = 37 then
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
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 295 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 295")
end

					-- Regular manifest string.
				last_break_end := 0
				last_comment_end := 0
				process_regular_manifest_string (text_count)
			
end
else
if yy_act = 39 then
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
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 309 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 309")
end

					-- Verbatim string.
				verbatim_marker := text_substring (2, text_count - 1)
				set_start_condition (VS1)
			
end
end
end
else
if yy_act <= 44 then
if yy_act <= 42 then
if yy_act = 41 then
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
			
else
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
			
end
else
if yy_act = 43 then
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
			
else
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
			
end
end
else
if yy_act <= 46 then
if yy_act = 45 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 368 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 368")
end

				more
				set_start_condition (VS3)
			
else
	yy_line := yy_line + 1
	yy_column := 1
--|#line 372 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 372")
end

				more
				last_literal_end := text_count - 2
			
end
else
if yy_act = 47 then
	yy_line := yy_line + 1
	yy_column := 1
--|#line 376 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 376")
end

				more
				last_literal_end := text_count - 1
			
else
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
			
end
end
end
end
else
if yy_act <= 56 then
if yy_act <= 52 then
if yy_act <= 50 then
if yy_act = 49 then
	yy_line := yy_line + 1
	yy_column := 1
--|#line 398 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 398")
end

				more
				last_literal_end := text_count - 2
				set_start_condition (VS2)
			
else
	yy_line := yy_line + 1
	yy_column := 1
--|#line 403 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 403")
end

				more
				last_literal_end := text_count - 1
				set_start_condition (VS2)
			
end
else
if yy_act = 51 then
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
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 424 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 424")
end

					-- Left-aligned verbatim string.
				verbatim_marker := text_substring (2, text_count - 1)
				set_start_condition (LAVS1)
			
end
end
else
if yy_act <= 54 then
if yy_act = 53 then
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
			
else
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
			
end
else
if yy_act = 55 then
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
			
else
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
			
end
end
end
else
if yy_act <= 60 then
if yy_act <= 58 then
if yy_act = 57 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 483 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 483")
end

				more
				set_start_condition (LAVS3)
			
else
	yy_line := yy_line + 1
	yy_column := 1
--|#line 487 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 487")
end

				more
				last_literal_end := text_count - 2
			
end
else
if yy_act = 59 then
	yy_line := yy_line + 1
	yy_column := 1
--|#line 491 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 491")
end

				more
				last_literal_end := text_count - 1
			
else
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
			
end
end
else
if yy_act <= 62 then
if yy_act = 61 then
	yy_line := yy_line + 1
	yy_column := 1
--|#line 513 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 513")
end

				more
				last_literal_end := text_count - 2
				set_start_condition (LAVS2)
			
else
	yy_line := yy_line + 1
	yy_column := 1
--|#line 518 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 518")
end

				more
				last_literal_end := text_count - 1
				set_start_condition (LAVS2)
			
end
else
if yy_act = 63 then
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
			
else
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
			
end
end
end
end
end
end
else
if yy_act <= 96 then
if yy_act <= 80 then
if yy_act <= 72 then
if yy_act <= 68 then
if yy_act <= 66 then
if yy_act = 65 then
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
			
else
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
			
end
else
if yy_act = 67 then
	yy_line := yy_line + 1
	yy_column := 1
--|#line 568 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 568")
end

					-- Multi-line manifest string.
				more
				set_start_condition (MSN)
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 573 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 573")
end

				more
			
end
end
else
if yy_act <= 70 then
if yy_act = 69 then
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
end
else
if yy_act <= 76 then
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
else
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
end
end
else
if yy_act <= 88 then
if yy_act <= 84 then
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
else
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
if yy_act = 87 then
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
			
else
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
			
end
end
end
else
if yy_act <= 92 then
if yy_act <= 90 then
if yy_act = 89 then
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
			
else
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
			
end
else
if yy_act = 91 then
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
			
else
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
			
end
end
else
if yy_act <= 94 then
if yy_act = 93 then
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
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 861 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 861")
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
if yy_act = 95 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 873 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 873")
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
--|#line 885 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 885")
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
if yy_act <= 112 then
if yy_act <= 104 then
if yy_act <= 100 then
if yy_act <= 98 then
if yy_act = 97 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 897 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 897")
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
--|#line 909 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 909")
end

				last_token := E_INTEGER
				last_literal_start := 1
				last_literal_end := text_count
				last_break_end := 0
				last_comment_end := 0
				last_et_integer_constant_value := ast_factory.new_octal_integer_constant (Current)
			
end
else
if yy_act = 99 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 917 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 917")
end

				last_text_count := text_count
				last_literal_start := 1
				last_literal_end := last_text_count
				break_kind := ointeger_break
				more
				set_start_condition (BREAK)
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 925 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 925")
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
if yy_act <= 102 then
if yy_act = 101 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 937 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 937")
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
--|#line 949 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 949")
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
if yy_act = 103 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 961 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 961")
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
--|#line 973 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 973")
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
if yy_act <= 108 then
if yy_act <= 106 then
if yy_act = 105 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 981 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 981")
end

				last_text_count := text_count
				last_literal_start := 1
				last_literal_end := last_text_count
				break_kind := binteger_break
				more
				set_start_condition (BREAK)
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 989 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 989")
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
if yy_act = 107 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 1001 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1001")
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
--|#line 1013 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1013")
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
if yy_act <= 110 then
if yy_act = 109 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 1025 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1025")
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
--|#line 1041 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1041")
end

				last_text_count := text_count
				last_literal_start := 1
				last_literal_end := last_text_count
				break_kind := real_break
				more
				set_start_condition (BREAK)
			
end
else
if yy_act = 111 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 1042 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1042")
end

				last_text_count := text_count
				last_literal_start := 1
				last_literal_end := last_text_count
				break_kind := real_break
				more
				set_start_condition (BREAK)
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 1043 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1043")
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
if yy_act <= 120 then
if yy_act <= 116 then
if yy_act <= 114 then
if yy_act = 113 then
	yy_end := yy_end - 1
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 1051 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1051")
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
--|#line 1052 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1052")
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
if yy_act = 115 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 1053 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1053")
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
--|#line 1064 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1064")
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
if yy_act <= 118 then
if yy_act = 117 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 1065 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1065")
end

				last_text_count := text_count
				last_literal_start := 1
				last_literal_end := last_text_count
				break_kind := ureal_break
				more
				set_start_condition (BREAK)
			
else
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 1066 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1066")
end

				last_text_count := text_count
				last_literal_start := 1
				last_literal_end := last_text_count
				break_kind := ureal_break
				more
				set_start_condition (BREAK)
			
end
else
if yy_act = 119 then
	yy_end := yy_end - 1
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 1074 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1074")
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
--|#line 1075 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1075")
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
if yy_act <= 124 then
if yy_act <= 122 then
if yy_act = 121 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
--|#line 1076 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1076")
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
--|#line 1091 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1091")
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
if yy_act = 123 then
yy_set_line_column
--|#line 1101 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1101")
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
--|#line 1112 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1112")
end

				last_break_end := text_count
				last_comment_end := 0
				process_break
				set_start_condition (INITIAL)
			
end
end
else
if yy_act <= 126 then
if yy_act = 125 then
yy_set_line_column
--|#line 1118 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1118")
end

				last_break_end := 0
				last_comment_end := text_count
				process_break
				set_start_condition (INITIAL)
			
else
	yy_column := yy_column + 1
--|#line 1124 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1124")
end

					-- Should never happen.
				less (0)
				last_break_end := 0
				last_comment_end := 0
				process_break
				set_start_condition (INITIAL)
			
end
else
if yy_act = 127 then
	yy_column := yy_column + 1
--|#line 1145 "et_eiffel_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'et_eiffel_scanner.l' at line 1145")
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
			create an_array.make (0, 2610)
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
			  387,   51,   47,   49,  385,   47,   50,  382,   51,   53,
			   54,   53,   53,   54,   53,   55,   66,   67,   55,   57,
			   58,   57,   57,   58,   57,   60,   61,   62,  386,   63,
			   60,   61,   62,  191,   63,   69,   70,   69,   69,   70,

			   69,   72,   73,   74,  192,   75,   72,   73,   74,  174,
			   75,   78,   79,   78,   79,   80,   80,   80,   80,   80,
			   80,   82,   82,   82,   94,   94,   94,   81,  148,  149,
			   81,   64,   96,   83,   97,  122,   64,  123,  174,   76,
			   85,   86,   87,   86,   76,   91,   91,   91,   98,   98,
			   98,  174,  111,  390,  385,   92,   92,   92,  384,  390,
			   99,  360,   82,   82,   82,  111,  390,   82,   82,   82,
			  150,  149,   88,  100,   83,  358,  100,  138,  139,   83,
			  140,   89,   82,   82,   82,  114,  100,  132,  133,  132,
			  122,  100,  123,  134,   83,  100,  114,  101,  101,  101,

			  101,  101,  101,  101,  112,  112,  112,  164,  165,  100,
			  102,  102,  102,  135,  136,  135,  113,  141,  138,  142,
			  378,  140,  103,  104,  174,  105,  105,  106,  106,  106,
			  106,  106,  166,  165,   82,   82,   82,  174,  107,  108,
			  138,  145,  122,  146,  123,  109,   83,  154,  155,  110,
			  156,  107,  108,  102,  102,  102,  218,  100,  100,  151,
			  152,  151,  234,  143,  235,  103,  104,  219,  106,  106,
			  106,  106,  106,  106,  106,   82,   82,   82,   82,   82,
			   82,  112,  112,  112,  118,  118,  118,   83,  154,  161,
			   83,  162,  110,  113,  138,  139,  119,  140,  370,  100,

			  100,  121,  100,  118,  118,  118,  124,  124,  124,   80,
			   80,   80,  148,  149,  115,  119,  144,  139,  125,  140,
			  121,   81,  183,  183,  183,  115,  126,  127,  128,  127,
			  126,  129,  126,  129,  126,  129,  129,  126,  126,  126,
			  126,  130,  126,  126,  126,  126,  126,  126,  126,  126,
			  129,  126,  129,  126,  129,  129,  129,  126,  126,  129,
			  129,  126,  126,  126,  126,  126,  126,  131,  131,  131,
			  131,  131,  126,  126,  126,  141,  144,  142,  121,  140,
			  157,  154,  158,  230,  156,  157,  160,  158,  369,  156,
			   82,   82,   82,   85,  231,   87,  168,  168,  168,   84,

			  363,   84,   83,  170,  191,   87,  150,  149,  169,  185,
			  185,  185,   94,   94,   94,  192,  215,  331,  159,  277,
			  114,  143,  114,  159,  328,   88,  179,  180,  179,  215,
			   85,  114,   87,  114,   89,  171,  181,  182,  181,  122,
			   85,  123,   87,  218,  172,  174,  326,  175,  323,  175,
			  175,  189,  189,  189,  219,  176,  221,  128,  221,  132,
			  133,  132,   88,  190,  175,  134,  175,  321,  175,  175,
			  175,   89,   88,  175,  175,  164,  165,  177,  193,  193,
			  193,   89,  318,  204,  204,  204,  178,  135,  136,  135,
			  194,  195,  195,  195,  230,  205,  166,  165,  206,  206,

			  317,  138,  145,  196,  146,  231,  101,  101,  101,  101,
			  101,  101,  101,  208,  208,  208,  208,  208,  208,  254,
			  254,  197,  207,  204,  204,  204,  216,  216,  216,  315,
			  198,  200,  200,  200,  309,  205,  308,  209,  217,  144,
			  145,  299,  146,  201,  260,  260,  202,  202,  202,  202,
			  202,  202,  202,  299,  118,  118,  118,  124,  124,  124,
			  299,  203,  212,  212,  212,  117,  119,  154,  155,  125,
			  156,  141,  138,  142,  213,  140,  353,  214,  214,  214,
			  214,  214,  214,  214,  222,  223,  224,  225,  225,  225,
			  225,  141,  144,  142,  390,  140,  226,  226,  226,  352,

			  299,  110,  151,  152,  151,  304,  160,  155,  227,  156,
			  157,  154,  158,  390,  156,  287,  305,  143,  157,  160,
			  158,  282,  156,  154,  161,  282,  162,  160,  161,  282,
			  162,  228,  228,  228,  232,  232,  232,  143,  179,  180,
			  179,  306,  170,  229,   87,  177,  233,  350,  159,  181,
			  182,  181,  307,  170,  178,   87,  159,  234,  351,   87,
			  242,  180,  242,  121,  390,  244,  244,  244,  245,  245,
			  245,  221,  128,  221,  171,  189,  189,  189,  312,  312,
			  246,  356,  356,  172,  121,  171,  304,  190,  274,  236,
			  270,  243,  182,  243,  172,  390,  177,  305,  237,  390,

			  265,  265,  179,  180,  179,  178,   85,  266,   87,  262,
			  238,  239,  240,  241,  241,  241,  241,  181,  182,  181,
			  390,   85,  282,   87,  207,  259,  306,  177,  345,  345,
			  175,  177,  191,  191,  191,  299,  178,  307,   88,  299,
			  178,  354,  354,  299,   81,  364,  364,   89,  193,  193,
			  193,  296,  177,   88,  121,  344,  344,  344,  344,  344,
			  194,  178,   89,  247,  269,  269,  269,  269,  269,  269,
			  248,  249,  250,  251,  251,  251,  251,  195,  195,  195,
			  278,  279,  280,  281,  281,  281,  281,  175,  209,  196,
			  289,  350,  202,  202,  202,  202,  202,  202,  202,  262,

			  262,  262,  351,  377,  377,  377,  232,  258,  270,  270,
			  270,  263,  380,  380,  206,  206,  259,  274,  274,  274,
			  271,  218,  218,  218,  230,  230,  230,  228,  226,  275,
			  276,  375,  375,  119,  282,  282,   83,  216,  264,  266,
			  266,  266,  376,  376,  212,  211,  204,  272,  287,  287,
			  287,  267,  257,  198,  208,  208,  208,  208,  208,  208,
			  288,  290,  180,  290,  195,  234,  253,   87,  291,  182,
			  291,  252,  234,  247,   87,  168,  124,  220,  268,  282,
			  222,  223,  224,  225,  225,  225,  225,  282,  284,  284,
			  284,  284,  285,  286,  286,  120,  117,  236,  245,  245,

			  245,  112,  211,  102,  236,  186,  237,  242,  180,  242,
			  246,  390,  188,  237,  175,  292,  292,  292,  292,  292,
			  292,  292,  175,  293,  293,  293,  293,  294,  295,  295,
			  175,  295,  295,  295,  295,  295,  295,  295,  243,  182,
			  243,  186,  390,  177,  297,  297,  297,  283,  283,  283,
			  283,  167,  178,  195,  195,  195,  298,  255,  255,  255,
			  255,  255,  255,  255,  390,  196,  309,  309,  309,  315,
			  315,  315,   99,  120,  177,  117,  100,  390,  310,  390,
			  390,  316,  390,  178,  299,  301,  301,  301,  301,  302,
			  303,  303,  308,  390,  390,  390,  311,  261,  261,  261, yy_Dummy>>,
			1, 1000, 0)
		end

	yy_nxt_template_2 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			  261,  261,  261,  261,  390,  198,  390,  390,  317,  318,
			  318,  318,  390,  390,  321,  321,  321,  286,  286,  286,
			  286,  319,  390,  390,  320,  320,  322,  390,  390,  265,
			  265,  338,  338,  338,  390,  339,  390,  328,  328,  328,
			  331,  331,  331,  340,  300,  300,  300,  300,  264,  329,
			  390,  390,  332,  207,  323,  323,  323,  346,  347,  348,
			  349,  349,  349,  349,  114,  390,  324,  390,  390,  325,
			  325,  325,  325,  325,  325,  114,  272,  390,  390,  211,
			  290,  180,  290,  390,  234,  390,   87,  297,  297,  297,
			  304,  304,  304,  268,  326,  326,  326,  390,  390,  298,

			  390,  390,  190,  306,  306,  306,  327,  390,  390,  269,
			  269,  269,  269,  269,  269,  194,  236,  313,  313,  313,
			  313,  313,  313,  313,  390,  237,  266,  266,  266,  350,
			  350,  350,  390,  209,  334,  334,  334,  390,  267,  255,
			  255,  246,  390,  255,  255,  255,  335,  390,  390,  336,
			  336,  336,  336,  336,  336,  336,  291,  182,  291,  390,
			  234,  390,   87,  390,  337,  121,  278,  279,  280,  281,
			  281,  281,  281,  121,  342,  342,  342,  342,  343,  344,
			  344,  366,  366,  366,  390,  367,  390,  358,  358,  358,
			  261,  261,  236,  368,  261,  261,  261,  390,  390,  359,

			  390,  237,  175,  295,  295,  295,  295,  295,  295,  295,
			  175,  295,  295,  295,  295,  295,  295,  295,  175,  295,
			  295,  295,  295,  295,  173,  173,  360,  309,  309,  309,
			  262,  262,  262,  390,  390,  270,  270,  270,  390,  310,
			  390,  390,  263,  390,  390,  320,  320,  271,  390,  309,
			  309,  309,  366,  366,  366,  390,  367,  361,  375,  375,
			  375,  310,  390,  390,  368,  390,  259,  313,  313,  264,
			  298,  313,  313,  313,  272,  309,  309,  309,  357,  357,
			  357,  357,  357,  357,  357,  390,  390,  310,  308,  390,
			  336,  336,  336,  336,  336,  336,  336,  309,  309,  309,

			  382,  382,  382,  390,  390,  361,  390,  390,  390,  310,
			  390,  390,  383,  390,  259,  174,  346,  347,  348,  349,
			  349,  349,  349,  174,  372,  372,  372,  372,  373,  374,
			  374,  303,  303,  303,  303,  390,  308,  390,  390,  317,
			  365,  365,  365,  365,  365,  365,  365,  382,  382,  382,
			  174,  374,  374,  374,  374,  374,  390,  390,  390,  383,
			  387,  387,  387,  381,  381,  381,  381,  381,  381,  381,
			  390,  390,  388,  387,  387,  387,  385,  385,  385,  390,
			  389,  116,  116,  116,  390,  388,  317,  390,  368,  210,
			  210,  210,  390,  116,  210,  210,  256,  256,  256,  360,

			  390,  210,  341,  341,  341,  341,  390,  390,  256,  390,
			  390,  390,  360,   44,   44,   44,   44,   44,   44,   44,
			   44,   44,   44,   44,   44,   44,   44,   44,   44,   44,
			   44,   44,   44,   44,   44,   44,   44,   44,   44,   44,
			   48,   48,   48,   48,   48,   48,   48,   48,   48,   48,
			   48,   48,   48,   48,   48,   48,   48,   48,   48,   48,
			   48,   48,   48,   48,   48,   48,   48,   52,   52,   52,
			   52,   52,   52,   52,   52,   52,   52,   52,   52,   52,
			   52,   52,   52,   52,   52,   52,   52,   52,   52,   52,
			   52,   52,   52,   52,   56,   56,   56,   56,   56,   56,

			   56,   56,   56,   56,   56,   56,   56,   56,   56,   56,
			   56,   56,   56,   56,   56,   56,   56,   56,   56,   56,
			   56,   59,   59,   59,   59,   59,   59,   59,   59,   59,
			   59,   59,   59,   59,   59,   59,   59,   59,   59,   59,
			   59,   59,   59,   59,   59,   59,   59,   59,   65,   65,
			   65,   65,   65,   65,   65,   65,   65,   65,   65,   65,
			   65,   65,   65,   65,   65,   65,   65,   65,   65,   65,
			   65,   65,   65,   65,   65,   68,   68,   68,   68,   68,
			   68,   68,   68,   68,   68,   68,   68,   68,   68,   68,
			   68,   68,   68,   68,   68,   68,   68,   68,   68,   68,

			   68,   68,   71,   71,   71,   71,   71,   71,   71,   71,
			   71,   71,   71,   71,   71,   71,   71,   71,   71,   71,
			   71,   71,   71,   71,   71,   71,   71,   71,   71,   77,
			   77,   77,   77,   77,   77,   77,   77,   77,   77,   77,
			   77,   77,   77,   77,   77,   77,   77,   77,   77,   77,
			   77,   77,   77,   77,   77,   77,   84,   84,  390,   84,
			   84,   84,   84,   84,   84,   84,   84,   84,   84,   84,
			   84,   84,   84,   84,   84,   84,   84,   84,   84,   84,
			   84,   84,   84,   90,   90,   90,   90,  390,  390,   90,
			   90,   90,   90,   90,   90,   90,   90,   90,   90,   90,

			   90,   90,   90,   90,   90,   90,   90,   90,   90,   90,
			   93,   93,   93,   93,  390,  390,   93,   93,   93,   93,
			   93,   93,   93,   93,   93,   93,   93,   93,   93,   93,
			   93,   93,   93,   93,   93,   93,   93,   95,   95,  390,
			   95,   95,   95,   95,   95,   95,   95,   95,   95,   95,
			   95,   95,   95,   95,   95,   95,   95,   95,   95,   95,
			   95,   95,   95,   95,  114,  114,  114,  314,  314,  314,
			  390,  390,  114,  390,  390,  114,  114,  114,  390,  314,
			  114,  114,  114,  114,  114,  114,  114,  114,  114,  114,
			  121,  121,  390,  121,  121,  121,  121,  121,  121,  121,

			  121,  121,  121,  121,  121,  121,  121,  121,  121,  121,
			  121,  121,  121,  121,  121,  121,  121,  137,  137,  137,
			  137,  137,  137,  137,  137,  137,  137,  137,  137,  137,
			  137,  137,  137,  137,  137,  137,  137,  137,  137,  137,
			  137,  137,  137,  137,  143,  143,  143,  143,  143,  143,
			  143,  143,  143,  143,  143,  143,  143,  143,  143,  143,
			  143,  143,  143,  143,  143,  143,  143,  143,  143,  143,
			  143,  147,  147,  147,  147,  147,  147,  147,  147,  147,
			  147,  147,  147,  147,  147,  147,  147,  147,  147,  147,
			  147,  147,  147,  147,  147,  147,  147,  147,  153,  153,

			  153,  153,  153,  153,  153,  153,  153,  153,  153,  153,
			  153,  153,  153,  153,  153,  153,  153,  153,  153,  153,
			  153,  153,  153,  153,  153,  159,  159,  159,  159,  159,
			  159,  159,  159,  159,  159,  159,  159,  159,  159,  159,
			  159,  159,  159,  159,  159,  159,  159,  159,  159,  159,
			  159,  159,  163,  163,  163,  163,  163,  163,  163,  163,
			  163,  163,  163,  163,  163,  163,  163,  163,  163,  163,
			  163,  163,  163,  163,  163,  163,  163,  163,  163,   86,
			   86,  390,   86,   86,   86,   86,   86,   86,   86,   86,
			   86,   86,   86,   86,   86,   86,   86,   86,   86,   86, yy_Dummy>>,
			1, 1000, 1000)
		end

	yy_nxt_template_3 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			   86,   86,   86,   86,   86,   86,  173,  173,  390,  173,
			  173,  173,  173,  173,  173,  173,  173,  173,  173,  173,
			  173,  173,  173,  173,  173,  173,  173,  173,  173,  173,
			  173,  173,  173,  184,  184,  184,  184,  390,  390,  184,
			  184,  184,  184,  184,  184,  390,  390,  390,  184,  184,
			  187,  187,  390,  187,  187,  187,  187,  187,  187,  187,
			  187,  187,  187,  187,  187,  187,  187,  187,  187,  187,
			  187,  187,  187,  187,  187,  187,  187,   99,   99,   99,
			   99,   99,   99,   99,   99,   99,   99,   99,   99,   99,
			   99,   99,   99,   99,   99,   99,   99,   99,   99,   99,

			   99,   99,   99,   99,  199,  199,  199,  199,  199,  199,
			  199,  199,  199,  199,  390,  199,  199,  199,  199,  199,
			  199,  199,  199,  199,  199,  199,  199,  199,  199,  199,
			  199,  120,  120,  120,  120,  120,  120,  120,  120,  120,
			  120,  120,  120,  120,  120,  120,  120,  120,  120,  120,
			  120,  120,  120,  120,  120,  120,  120,  120,  121,  121,
			  121,  121,  357,  357,  390,  121,  357,  357,  357,  121,
			  121,  121,  390,  390,  121,  121,  167,  167,  167,  167,
			  167,  167,  167,  167,  167,  167,  167,  167,  167,  167,
			  167,  167,  167,  167,  167,  167,  167,  167,  167,  167,

			  167,  167,  167,  174,  174,  390,  174,  174,  174,  174,
			  174,  174,  174,  174,  174,  174,  174,  174,  174,  174,
			  174,  174,  174,  174,  174,  174,  174,  174,  174,  174,
			  175,  175,  390,  175,  175,  175,  175,  175,  175,  175,
			  175,  175,  175,  175,  175,  175,  175,  175,  175,  175,
			  175,  175,  175,  175,  175,  175,  175,  184,  184,  184,
			  184,  390,  390,  184,  184,  184,  184,  184,  184,  184,
			  184,  184,  184,  184,  184,  184,  184,  184,  184,  184,
			  184,  184,  184,  184,  273,  273,  273,  390,  390,  273,
			  273,  344,  344,  344,  344,  390,  273,  174,  174,  174,

			  174,  365,  365,  390,  174,  365,  365,  365,  174,  174,
			  174,  390,  390,  174,  174,  252,  252,  252,  252,  252,
			  252,  252,  252,  252,  252,  252,  252,  252,  252,  252,
			  252,  252,  252,  252,  252,  252,  252,  252,  252,  252,
			  252,  252,  253,  253,  253,  253,  253,  253,  253,  253,
			  253,  253,  253,  253,  253,  253,  253,  253,  253,  253,
			  253,  253,  253,  253,  253,  253,  253,  253,  253,  330,
			  330,  330,  345,  345,  345,  345,  390,  330,  390,  390,
			  330,  330,  330,  390,  390,  330,  330,  354,  354,  354,
			  354,  390,  330,  333,  333,  333,  333,  333,  333,  333,

			  333,  333,  333,  390,  333,  333,  333,  333,  333,  333,
			  333,  333,  333,  333,  333,  333,  333,  333,  333,  333,
			  121,  121,  390,  121,  121,  121,  121,  121,  121,  121,
			  121,  121,  121,  121,  121,  121,  121,  121,  121,  121,
			  121,  121,  121,  121,  121,  121,  121,  296,  296,  296,
			  296,  296,  296,  296,  296,  296,  296,  296,  296,  296,
			  296,  296,  296,  296,  296,  296,  296,  296,  296,  296,
			  296,  296,  296,  296,  355,  355,  355,  362,  362,  362,
			  371,  371,  371,  371,  390,  390,  355,  390,  390,  362,
			  374,  374,  374,  374,  352,  352,  352,  352,  352,  352,

			  352,  352,  352,  352,  352,  352,  352,  352,  352,  352,
			  352,  352,  352,  352,  352,  352,  352,  352,  352,  352,
			  352,  379,  379,  379,  381,  381,  390,  390,  381,  381,
			  381,  390,  390,  379,  384,  384,  384,  384,  384,  384,
			  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,
			  384,  384,  384,  384,  384,  384,  384,  384,  384,  384,
			  384,   21,  390,  390,  390,  390,  390,  390,  390,  390,
			  390,  390,  390,  390,  390,  390,  390,  390,  390,  390,
			  390,  390,  390,  390,  390,  390,  390,  390,  390,  390,
			  390,  390,  390,  390,  390,  390,  390,  390,  390,  390,

			  390,  390,  390,  390,  390,  390,  390,  390,  390,  390,
			  390, yy_Dummy>>,
			1, 611, 2000)
		end

	yy_chk_template: SPECIAL [INTEGER] is
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 2610)
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
			  388,    5,    3,    6,  384,    4,    6,  383,    6,    7,
			    7,    7,    8,    8,    8,    7,   14,   14,    8,    9,
			    9,    9,   10,   10,   10,   11,   11,   11,  378,   11,
			   12,   12,   12,   99,   12,   15,   15,   15,   16,   16,

			   16,   17,   17,   17,   99,   17,   18,   18,   18,  374,
			   18,   19,   19,   20,   20,   23,   23,   23,   24,   24,
			   24,   25,   25,   25,   28,   28,   28,   23,   65,   65,
			   24,   11,   29,   25,   29,   48,   12,   48,  372,   17,
			   26,   26,   26,   26,   18,   27,   27,   27,   30,   30,
			   30,  371,   34,   34,  369,   27,   27,   27,  368,   34,
			   30,  360,   32,   32,   32,   34,   34,   36,   36,   36,
			   67,   67,   26,   30,   32,  359,   32,   59,   59,   36,
			   59,   26,   31,   31,   31,  114,   32,   53,   53,   53,
			  121,   36,  121,   53,   31,   31,  114,   31,   31,   31,

			   31,   31,   31,   31,   40,   40,   40,   77,   77,   32,
			   33,   33,   33,   57,   57,   57,   40,   60,   60,   60,
			  354,   60,   33,   33,  349,   33,   33,   33,   33,   33,
			   33,   33,   79,   79,   37,   37,   37,  347,   33,   33,
			   64,   64,  129,   64,  129,   33,   37,   71,   71,   33,
			   71,   33,   33,   35,   35,   35,  120,   37,   37,   69,
			   69,   69,  174,   60,  174,   35,   35,  120,   35,   35,
			   35,   35,   35,   35,   35,   38,   38,   38,   39,   39,
			   39,   41,   41,   41,   45,   45,   45,   38,   76,   76,
			   39,   76,   35,   41,  137,  137,   45,  137,  345,   38,

			   38,  344,   39,   46,   46,   46,   50,   50,   50,   80,
			   80,   80,  147,  147,   41,   46,  139,  139,   50,  139,
			  342,   80,   90,   90,   90,   41,   51,   51,   51,   51,
			   51,   51,   51,   51,   51,   51,   51,   51,   51,   51,
			   51,   51,   51,   51,   51,   51,   51,   51,   51,   51,
			   51,   51,   51,   51,   51,   51,   51,   51,   51,   51,
			   51,   51,   51,   51,   51,   51,   51,   51,   51,   51,
			   51,   51,   51,   51,   51,   62,   62,   62,  341,   62,
			   72,   72,   72,  167,   72,   74,   74,   74,  340,   74,
			   82,   82,   82,   84,  167,   84,   85,   85,   85,   86,

			  335,   86,   82,   86,  192,   86,  149,  149,   85,   92,
			   92,   92,   93,   93,   93,  192,  115,  332,   72,  215,
			  115,   62,  215,   74,  329,   84,   88,   88,   88,  115,
			   88,  115,   88,  215,   84,   86,   89,   89,   89,  282,
			   89,  282,   89,  219,   86,   87,  327,   87,  324,   87,
			   87,   98,   98,   98,  219,   87,  127,  127,  127,  132,
			  132,  132,   88,   98,   87,  132,   87,  322,   87,   87,
			   87,   88,   89,   87,   87,  163,  163,   87,  100,  100,
			  100,   89,  319,  107,  107,  107,   87,  135,  135,  135,
			  100,  101,  101,  101,  231,  107,  165,  165,  107,  107,

			  317,  143,  143,  101,  143,  231,  101,  101,  101,  101,
			  101,  101,  101,  108,  108,  108,  108,  108,  108,  197,
			  197,  101,  107,  111,  111,  111,  116,  116,  116,  316,
			  101,  104,  104,  104,  310,  111,  308,  108,  116,  145,
			  145,  303,  145,  104,  203,  203,  104,  104,  104,  104,
			  104,  104,  104,  301,  118,  118,  118,  122,  122,  122,
			  300,  104,  110,  110,  110,  116,  118,  153,  153,  122,
			  153,  141,  141,  141,  110,  141,  299,  110,  110,  110,
			  110,  110,  110,  110,  130,  130,  130,  130,  130,  130,
			  130,  142,  142,  142,  248,  142,  146,  146,  146,  298,

			  248,  110,  151,  151,  151,  252,  155,  155,  146,  155,
			  157,  157,  157,  173,  157,  288,  252,  141,  158,  158,
			  158,  286,  158,  159,  159,  284,  159,  161,  161,  283,
			  161,  162,  162,  162,  170,  170,  170,  142,  171,  171,
			  171,  253,  171,  162,  171,  173,  170,  296,  157,  172,
			  172,  172,  253,  172,  173,  172,  158,  175,  296,  175,
			  177,  177,  177,  281,  177,  184,  184,  184,  186,  186,
			  186,  221,  221,  221,  171,  189,  189,  189,  258,  258,
			  186,  311,  311,  171,  279,  172,  305,  189,  275,  175,
			  271,  178,  178,  178,  172,  178,  177,  305,  175,  176,

			  207,  207,  179,  179,  179,  177,  179,  267,  179,  263,
			  176,  176,  176,  176,  176,  176,  176,  181,  181,  181,
			  295,  181,  285,  181,  207,  259,  307,  178,  285,  285,
			  295,  176,  191,  191,  191,  302,  178,  307,  179,  251,
			  176,  302,  302,  249,  191,  337,  337,  179,  193,  193,
			  193,  246,  295,  181,  343,  343,  343,  343,  343,  343,
			  193,  295,  181,  188,  209,  209,  209,  209,  209,  209,
			  188,  188,  188,  188,  188,  188,  188,  202,  202,  202,
			  220,  220,  220,  220,  220,  220,  220,  238,  209,  202,
			  235,  351,  202,  202,  202,  202,  202,  202,  202,  206,

			  206,  206,  351,  353,  353,  353,  233,  202,  210,  210,
			  210,  206,  361,  361,  206,  206,  202,  214,  214,  214,
			  210,  218,  218,  218,  230,  230,  230,  229,  227,  214,
			  214,  352,  376,  218,  225,  223,  230,  217,  206,  208,
			  208,  208,  352,  376,  213,  211,  205,  210,  234,  234,
			  234,  208,  201,  198,  208,  208,  208,  208,  208,  208,
			  234,  236,  236,  236,  196,  236,  194,  236,  237,  237,
			  237,  190,  237,  187,  237,  169,  125,  123,  208,  222,
			  222,  222,  222,  222,  222,  222,  222,  224,  224,  224,
			  224,  224,  224,  224,  224,  119,  117,  236,  245,  245,

			  245,  113,  109,  103,  237,   97,  236,  242,  242,  242,
			  245,  242,   96,  237,  239,  239,  239,  239,  239,  239,
			  239,  239,  240,  240,  240,  240,  240,  240,  240,  240,
			  241,  241,  241,  241,  241,  241,  241,  241,  243,  243,
			  243,   95,  243,  242,  247,  247,  247,  430,  430,  430,
			  430,   83,  242,  255,  255,  255,  247,  254,  254,  254,
			  254,  254,  254,  254,  255,  255,  256,  256,  256,  261,
			  261,  261,   81,   47,  243,   43,   42,   21,  256,    0,
			  261,  261,    0,  243,  250,  250,  250,  250,  250,  250,
			  250,  250,  255,    0,    0,    0,  256,  260,  260,  260, yy_Dummy>>,
			1, 1000, 0)
		end

	yy_chk_template_2 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			  260,  260,  260,  260,    0,  256,    0,    0,  261,  264,
			  264,  264,    0,    0,  265,  265,  265,  431,  431,  431,
			  431,  264,    0,    0,  264,  264,  265,    0,    0,  265,
			  265,  277,  277,  277,    0,  277,    0,  272,  272,  272,
			  273,  273,  273,  277,  433,  433,  433,  433,  264,  272,
			    0,    0,  273,  265,  268,  268,  268,  289,  289,  289,
			  289,  289,  289,  289,  277,    0,  268,    0,    0,  268,
			  268,  268,  268,  268,  268,  277,  272,    0,    0,  273,
			  290,  290,  290,    0,  290,    0,  290,  297,  297,  297,
			  304,  304,  304,  268,  269,  269,  269,    0,    0,  297,

			    0,    0,  304,  306,  306,  306,  269,    0,    0,  269,
			  269,  269,  269,  269,  269,  306,  290,  312,  312,  312,
			  312,  312,  312,  312,    0,  290,  325,  325,  325,  350,
			  350,  350,    0,  269,  276,  276,  276,    0,  325,  426,
			  426,  350,    0,  426,  426,  426,  276,    0,    0,  276,
			  276,  276,  276,  276,  276,  276,  291,  291,  291,    0,
			  291,    0,  291,    0,  276,  278,  278,  278,  278,  278,
			  278,  278,  278,  280,  280,  280,  280,  280,  280,  280,
			  280,  338,  338,  338,    0,  338,    0,  313,  313,  313,
			  428,  428,  291,  338,  428,  428,  428,    0,  313,  313,

			    0,  291,  292,  292,  292,  292,  292,  292,  292,  292,
			  293,  293,  293,  293,  293,  293,  293,  293,  294,  294,
			  294,  294,  294,  294,  294,  294,  313,  314,  314,  314,
			  320,  320,  320,    0,    0,  330,  330,  330,    0,  314,
			    0,    0,  320,    0,    0,  320,  320,  330,    0,  355,
			  355,  355,  366,  366,  366,    0,  366,  314,  375,  375,
			  375,  355,    0,    0,  366,    0,  314,  437,  437,  320,
			  375,  437,  437,  437,  330,  336,  336,  336,  356,  356,
			  356,  356,  356,  356,  356,    0,    0,  336,  355,    0,
			  336,  336,  336,  336,  336,  336,  336,  357,  357,  357,

			  362,  362,  362,    0,    0,  336,    0,    0,  357,  357,
			    0,    0,  362,    0,  336,  346,  346,  346,  346,  346,
			  346,  346,  346,  348,  348,  348,  348,  348,  348,  348,
			  348,  434,  434,  434,  434,    0,  357,    0,    0,  362,
			  364,  364,  364,  364,  364,  364,  364,  365,  365,  365,
			  373,  373,  373,  373,  373,  373,    0,    0,  365,  365,
			  379,  379,  379,  380,  380,  380,  380,  380,  380,  380,
			    0,    0,  379,  381,  381,  381,  385,  385,  385,    0,
			  385,  405,  405,  405,  381,  381,  365,    0,  385,  419,
			  419,  419,    0,  405,  419,  419,  427,  427,  427,  379,

			    0,  419,  441,  441,  441,  441,    0,    0,  427,    0,
			    0,    0,  381,  391,  391,  391,  391,  391,  391,  391,
			  391,  391,  391,  391,  391,  391,  391,  391,  391,  391,
			  391,  391,  391,  391,  391,  391,  391,  391,  391,  391,
			  392,  392,  392,  392,  392,  392,  392,  392,  392,  392,
			  392,  392,  392,  392,  392,  392,  392,  392,  392,  392,
			  392,  392,  392,  392,  392,  392,  392,  393,  393,  393,
			  393,  393,  393,  393,  393,  393,  393,  393,  393,  393,
			  393,  393,  393,  393,  393,  393,  393,  393,  393,  393,
			  393,  393,  393,  393,  394,  394,  394,  394,  394,  394,

			  394,  394,  394,  394,  394,  394,  394,  394,  394,  394,
			  394,  394,  394,  394,  394,  394,  394,  394,  394,  394,
			  394,  395,  395,  395,  395,  395,  395,  395,  395,  395,
			  395,  395,  395,  395,  395,  395,  395,  395,  395,  395,
			  395,  395,  395,  395,  395,  395,  395,  395,  396,  396,
			  396,  396,  396,  396,  396,  396,  396,  396,  396,  396,
			  396,  396,  396,  396,  396,  396,  396,  396,  396,  396,
			  396,  396,  396,  396,  396,  397,  397,  397,  397,  397,
			  397,  397,  397,  397,  397,  397,  397,  397,  397,  397,
			  397,  397,  397,  397,  397,  397,  397,  397,  397,  397,

			  397,  397,  398,  398,  398,  398,  398,  398,  398,  398,
			  398,  398,  398,  398,  398,  398,  398,  398,  398,  398,
			  398,  398,  398,  398,  398,  398,  398,  398,  398,  399,
			  399,  399,  399,  399,  399,  399,  399,  399,  399,  399,
			  399,  399,  399,  399,  399,  399,  399,  399,  399,  399,
			  399,  399,  399,  399,  399,  399,  400,  400,    0,  400,
			  400,  400,  400,  400,  400,  400,  400,  400,  400,  400,
			  400,  400,  400,  400,  400,  400,  400,  400,  400,  400,
			  400,  400,  400,  401,  401,  401,  401,    0,    0,  401,
			  401,  401,  401,  401,  401,  401,  401,  401,  401,  401,

			  401,  401,  401,  401,  401,  401,  401,  401,  401,  401,
			  402,  402,  402,  402,    0,    0,  402,  402,  402,  402,
			  402,  402,  402,  402,  402,  402,  402,  402,  402,  402,
			  402,  402,  402,  402,  402,  402,  402,  403,  403,    0,
			  403,  403,  403,  403,  403,  403,  403,  403,  403,  403,
			  403,  403,  403,  403,  403,  403,  403,  403,  403,  403,
			  403,  403,  403,  403,  404,  404,  404,  438,  438,  438,
			    0,    0,  404,    0,    0,  404,  404,  404,    0,  438,
			  404,  404,  404,  404,  404,  404,  404,  404,  404,  404,
			  406,  406,    0,  406,  406,  406,  406,  406,  406,  406,

			  406,  406,  406,  406,  406,  406,  406,  406,  406,  406,
			  406,  406,  406,  406,  406,  406,  406,  407,  407,  407,
			  407,  407,  407,  407,  407,  407,  407,  407,  407,  407,
			  407,  407,  407,  407,  407,  407,  407,  407,  407,  407,
			  407,  407,  407,  407,  408,  408,  408,  408,  408,  408,
			  408,  408,  408,  408,  408,  408,  408,  408,  408,  408,
			  408,  408,  408,  408,  408,  408,  408,  408,  408,  408,
			  408,  409,  409,  409,  409,  409,  409,  409,  409,  409,
			  409,  409,  409,  409,  409,  409,  409,  409,  409,  409,
			  409,  409,  409,  409,  409,  409,  409,  409,  410,  410,

			  410,  410,  410,  410,  410,  410,  410,  410,  410,  410,
			  410,  410,  410,  410,  410,  410,  410,  410,  410,  410,
			  410,  410,  410,  410,  410,  411,  411,  411,  411,  411,
			  411,  411,  411,  411,  411,  411,  411,  411,  411,  411,
			  411,  411,  411,  411,  411,  411,  411,  411,  411,  411,
			  411,  411,  412,  412,  412,  412,  412,  412,  412,  412,
			  412,  412,  412,  412,  412,  412,  412,  412,  412,  412,
			  412,  412,  412,  412,  412,  412,  412,  412,  412,  413,
			  413,    0,  413,  413,  413,  413,  413,  413,  413,  413,
			  413,  413,  413,  413,  413,  413,  413,  413,  413,  413, yy_Dummy>>,
			1, 1000, 1000)
		end

	yy_chk_template_3 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			  413,  413,  413,  413,  413,  413,  414,  414,    0,  414,
			  414,  414,  414,  414,  414,  414,  414,  414,  414,  414,
			  414,  414,  414,  414,  414,  414,  414,  414,  414,  414,
			  414,  414,  414,  415,  415,  415,  415,    0,    0,  415,
			  415,  415,  415,  415,  415,    0,    0,    0,  415,  415,
			  416,  416,    0,  416,  416,  416,  416,  416,  416,  416,
			  416,  416,  416,  416,  416,  416,  416,  416,  416,  416,
			  416,  416,  416,  416,  416,  416,  416,  417,  417,  417,
			  417,  417,  417,  417,  417,  417,  417,  417,  417,  417,
			  417,  417,  417,  417,  417,  417,  417,  417,  417,  417,

			  417,  417,  417,  417,  418,  418,  418,  418,  418,  418,
			  418,  418,  418,  418,    0,  418,  418,  418,  418,  418,
			  418,  418,  418,  418,  418,  418,  418,  418,  418,  418,
			  418,  420,  420,  420,  420,  420,  420,  420,  420,  420,
			  420,  420,  420,  420,  420,  420,  420,  420,  420,  420,
			  420,  420,  420,  420,  420,  420,  420,  420,  421,  421,
			  421,  421,  448,  448,    0,  421,  448,  448,  448,  421,
			  421,  421,    0,    0,  421,  421,  422,  422,  422,  422,
			  422,  422,  422,  422,  422,  422,  422,  422,  422,  422,
			  422,  422,  422,  422,  422,  422,  422,  422,  422,  422,

			  422,  422,  422,  423,  423,    0,  423,  423,  423,  423,
			  423,  423,  423,  423,  423,  423,  423,  423,  423,  423,
			  423,  423,  423,  423,  423,  423,  423,  423,  423,  423,
			  424,  424,    0,  424,  424,  424,  424,  424,  424,  424,
			  424,  424,  424,  424,  424,  424,  424,  424,  424,  424,
			  424,  424,  424,  424,  424,  424,  424,  425,  425,  425,
			  425,    0,    0,  425,  425,  425,  425,  425,  425,  425,
			  425,  425,  425,  425,  425,  425,  425,  425,  425,  425,
			  425,  425,  425,  425,  429,  429,  429,    0,    0,  429,
			  429,  442,  442,  442,  442,    0,  429,  432,  432,  432,

			  432,  450,  450,    0,  432,  450,  450,  450,  432,  432,
			  432,    0,    0,  432,  432,  435,  435,  435,  435,  435,
			  435,  435,  435,  435,  435,  435,  435,  435,  435,  435,
			  435,  435,  435,  435,  435,  435,  435,  435,  435,  435,
			  435,  435,  436,  436,  436,  436,  436,  436,  436,  436,
			  436,  436,  436,  436,  436,  436,  436,  436,  436,  436,
			  436,  436,  436,  436,  436,  436,  436,  436,  436,  439,
			  439,  439,  444,  444,  444,  444,    0,  439,    0,    0,
			  439,  439,  439,    0,    0,  439,  439,  446,  446,  446,
			  446,    0,  439,  440,  440,  440,  440,  440,  440,  440,

			  440,  440,  440,    0,  440,  440,  440,  440,  440,  440,
			  440,  440,  440,  440,  440,  440,  440,  440,  440,  440,
			  443,  443,    0,  443,  443,  443,  443,  443,  443,  443,
			  443,  443,  443,  443,  443,  443,  443,  443,  443,  443,
			  443,  443,  443,  443,  443,  443,  443,  445,  445,  445,
			  445,  445,  445,  445,  445,  445,  445,  445,  445,  445,
			  445,  445,  445,  445,  445,  445,  445,  445,  445,  445,
			  445,  445,  445,  445,  447,  447,  447,  449,  449,  449,
			  451,  451,  451,  451,    0,    0,  447,    0,    0,  449,
			  452,  452,  452,  452,  453,  453,  453,  453,  453,  453,

			  453,  453,  453,  453,  453,  453,  453,  453,  453,  453,
			  453,  453,  453,  453,  453,  453,  453,  453,  453,  453,
			  453,  454,  454,  454,  455,  455,    0,    0,  455,  455,
			  455,    0,    0,  454,  456,  456,  456,  456,  456,  456,
			  456,  456,  456,  456,  456,  456,  456,  456,  456,  456,
			  456,  456,  456,  456,  456,  456,  456,  456,  456,  456,
			  456,  390,  390,  390,  390,  390,  390,  390,  390,  390,
			  390,  390,  390,  390,  390,  390,  390,  390,  390,  390,
			  390,  390,  390,  390,  390,  390,  390,  390,  390,  390,
			  390,  390,  390,  390,  390,  390,  390,  390,  390,  390,

			  390,  390,  390,  390,  390,  390,  390,  390,  390,  390,
			  390, yy_Dummy>>,
			1, 611, 2000)
		end

	yy_base_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,   48,   51,   53,   60,   67,   70,   77,
			   80,   83,   88,   54,   73,   93,   96,   99,  104,  108,
			  110,  977, 2561,  113,  116,  119,  134,  143,  122,  124,
			  146,  180,  160,  208,  122,  251,  165,  232,  273,  276,
			  202,  279,  937,  934, 2561,  282,  301,  959,  129, 2561,
			  304,  325, 2561,  185, 2561, 2561, 2561,  211, 2561,  174,
			  215, 2561,  373, 2561,  237,  125, 2561,  167, 2561,  257,
			 2561,  244,  378, 2561,  383, 2561,  285,  204, 2561,  229,
			  307,  958,  388,  937,  387,  394,  397,  439,  424,  434,
			  320, 2561,  407,  410, 2561,  931,  896,  895,  449,   90,

			  476,  489, 2561,  889,  529,    0,    0,  481,  496,  861,
			  560,  521, 2561,  887,  150,  385,  524,  855,  552,  881,
			  253,  184,  555,  861, 2561,  862, 2561,  454, 2561,  236,
			  567, 2561,  457, 2561, 2561,  485, 2561,  291, 2561,  313,
			 2561,  569,  589,  498, 2561,  536,  594,  309, 2561,  403,
			 2561,  600, 2561,  564, 2561,  603, 2561,  608,  616,  620,
			 2561,  624,  629,  472, 2561,  493, 2561,  380, 2561,  861,
			  632,  636,  647,  607,  256,  651,  693,  658,  689,  700,
			 2561,  715, 2561, 2561,  663, 2561,  666,  863,  753,  673,
			  857,  730,  401,  746,  852, 2561,  850,  506,  812, 2561,

			 2561,  838,  775,  531, 2561,  832,  797,  683,  837,  747,
			  806,  804, 2561,  830,  815,  387, 2561,  823,  819,  440,
			  763,  669,  863,  819,  871,  818, 2561,  814, 2561,  813,
			  822,  491, 2561,  792,  846,  774,  859,  866,  771,  898,
			  906,  914,  905,  936, 2561,  896,  737,  942,  584,  727,
			  968,  723,  602,  638,  940,  951,  964, 2561,  665,  684,
			  980,  967, 2561,  695, 1007, 1012, 2561,  693, 1052, 1092,
			 2561,  676, 1035, 1038, 2561,  674, 1132, 1029, 1149,  668,
			 1157,  647,  433,  613,  609,  706,  605, 2561,  601, 1040,
			 1078, 1154, 1186, 1194, 1202,  714,  644, 1085,  585,  566,

			  544,  537,  719,  525, 1088,  683, 1101,  723,  495, 2561,
			  520,  668, 1100, 1185, 1225, 2561,  515,  459, 2561,  468,
			 1228, 2561,  453, 2561,  434, 1124, 2561,  432, 2561,  410,
			 1233, 2561,  403, 2561, 2561,  386, 1273,  732, 1179, 2561,
			  374,  362,  304,  738,  285,  282, 1299,  221, 1307,  208,
			 1127,  788,  828,  801,  204, 1247, 1261, 1295, 2561,  161,
			  120,  799, 1298, 2561, 1323, 1345, 1250, 2561,  144,  151,
			 2561,  135,  122, 1334,   93, 1256,  829, 2561,   78, 1358,
			 1346, 1371, 2561,   53,   61, 1374, 2561, 2561,   46, 2561,
			 2561, 1412, 1439, 1466, 1493, 1520, 1547, 1574, 1601, 1628,

			 1655, 1682, 1709, 1736, 1762, 1368, 1789, 1816, 1843, 1870,
			 1897, 1924, 1951, 1978, 2005, 2032, 2049, 2076, 2103, 1376,
			 2130, 2153, 2175, 2202, 2229, 2256, 1130, 1383, 1181, 2271,
			  935, 1005, 2292, 1032, 1319, 2314, 2341, 1258, 1754, 2367,
			 2392, 1390, 2279, 2419, 2360, 2446, 2375, 2461, 2153, 2464,
			 2292, 2468, 2478, 2493, 2508, 2515, 2533, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  390,    1,  391,  391,  392,  392,  393,  393,  394,
			  394,  395,  395,  396,  396,  397,  397,  398,  398,  399,
			  399,  390,  390,  390,  390,  390,  400,  401,  402,  403,
			  390,  390,  390,  390,   33,  390,  390,  390,  390,  390,
			  404,  404,  390,  405,  390,  390,  390,  390,  406,  390,
			  390,  390,  390,  390,  390,  390,  390,  390,  390,  407,
			  407,  390,  407,  390,  408,  409,  390,  409,  390,  390,
			  390,  410,  410,  390,  410,  390,  411,  412,  390,  412,
			  390,  390,  390,  390,  400,  390,  413,  414,  400,  400,
			  401,  390,  415,  402,  390,  390,  416,  390,  390,  417,

			  390,  390,  390,  390,  418,   34,   35,  390,  390,  419,
			  390,  390,  390,  390,   41,   41,  405,  405,  390,  390,
			  420,  406,  390,  421,  390,  390,  390,  390,  390,  406,
			  390,  390,  390,  390,  390,  390,  390,  407,  390,  407,
			  390,  407,  407,  408,  390,  408,  390,  409,  390,  409,
			  390,  390,  390,  410,  390,  410,  390,  410,  410,  411,
			  390,  411,  390,  412,  390,  412,  390,  422,  390,  390,
			  390,  413,  413,  414,  423,  424,  414,  414,  414,  400,
			  390,  400,  390,  390,  425,  390,  390,  390,  390,  390,
			  390,  390,  417,  390,  390,  390,  390,  426,  427,  390,

			  390,  390,  390,  428,  390,  390,  390,  390,  390,  390,
			  419,  429,  390,  390,  110,   41,  390,  390,  390,  420,
			  390,  390,  390,  430,  390,  431,  390,  390,  390,  390,
			  390,  422,  390,  390,  390,  432,  424,  424,  176,  176,
			  176,  176,  414,  414,  390,  390,  390,  390,  188,  433,
			  390,  434,  435,  436,  390,  426,  427,  390,  437,  438,
			  390,  428,  390,  390,  390,  390,  390,  390,  390,  390,
			  390,  390,  439,  429,  390,  390,  440,   41,  390,  441,
			  390,  442,  443,  431,  431,  431,  444,  390,  390,  390,
			  424,  424,  176,  176,  176,  414,  445,  390,  390,  390,

			  434,  434,  434,  446,  390,  435,  390,  436,  447,  390,
			  390,  448,  390,  437,  438,  390,  390,  449,  390,  390,
			  390,  390,  390,  390,  390,  268,  390,  390,  390,  390,
			  439,  390,  390,  390,  390,  390,  390,  450,  390,  390,
			  390,  442,  442,  390,  390,  444,  390,  451,  390,  452,
			  390,  445,  453,  390,  446,  447,  390,  448,  390,  390,
			  454,  455,  449,  390,  390,  450,  390,  390,  390,  456,
			  390,  452,  452,  390,  390,  390,  453,  390,  390,  454,
			  390,  455,  390,  390,  456,  390,  390,  390,  390,  390,
			    0,  390,  390,  390,  390,  390,  390,  390,  390,  390,

			  390,  390,  390,  390,  390,  390,  390,  390,  390,  390,
			  390,  390,  390,  390,  390,  390,  390,  390,  390,  390,
			  390,  390,  390,  390,  390,  390,  390,  390,  390,  390,
			  390,  390,  390,  390,  390,  390,  390,  390,  390,  390,
			  390,  390,  390,  390,  390,  390,  390,  390,  390,  390,
			  390,  390,  390,  390,  390,  390,  390, yy_Dummy>>)
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
			  194,  196,  198,  199,  199,  201,  203,  205,  205,  207,
			  207,  208,  209,  211,  211,  212,  212,  213,  214,  215,
			  217,  219,  221,  221,  222,  223,  223,  224,  225,  226,
			  227,  228,  229,  230,  231,  233,  234,  237,  238,  239,
			  240,  242,  242,  243,  244,  245,  246,  247,  248,  249,
			  250,  252,  253,  256,  257,  258,  259,  261,  262,  264,
			  264,  270,  272,  274,  274,  275,  276,  276,  277,  278,
			  279,  280,  281,  282,  283,  284,  285,  286,  287,  289,
			  291,  291,  292,  293,  295,  295,  297,  297,  297,  297,

			  298,  300,  301,  305,  306,  307,  307,  309,  309,  311,
			  311,  313,  313,  314,  314,  316,  318,  319,  319,  320,
			  321,  321,  321,  322,  323,  324,  325,  326,  326,  327,
			  327,  328,  329,  332,  332,  334,  334,  336,  338,  338,
			  338,  338,  338,  338,  338,  339,  341,  341,  342,  343,
			  344,  345,  346,  347,  348,  348,  352,  354,  355,  355,
			  355,  355,  359,  360,  360,  362,  364,  365,  365,  367,
			  369,  370,  370,  372,  374,  375,  375,  376,  378,  378,
			  378,  378,  378,  381,  382,  383,  384,  385,  386,  386,
			  386,  387,  388,  388,  388,  388,  388,  389,  391,  391,

			  392,  393,  394,  395,  396,  397,  398,  399,  400,  400,
			  401,  401,  401,  401,  409,  411,  413,  413,  413,  414,
			  414,  416,  417,  417,  418,  418,  420,  421,  421,  422,
			  422,  424,  425,  425,  426,  428,  429,  431,  432,  433,
			  434,  434,  434,  434,  434,  434,  435,  435,  435,  435,
			  435,  436,  437,  438,  440,  441,  443,  443,  445,  449,
			  449,  449,  449,  451,  452,  452,  454,  454,  456,  456,
			  457,  458,  458,  458,  458,  458,  459,  460,  461,  462,
			  466,  466,  470,  471,  471,  471,  471,  472,  474,  474,
			  475,  475, yy_Dummy>>)
		end

	yy_acclist_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,   48,   48,   51,   51,   60,   60,   63,   63,  129,
			  127,  128,  122,  123,  127,  128,  122,  123,  128,    1,
			  127,  128,   66,  127,  128,   13,  127,  128,   17,  127,
			  128,   35,  127,  128,    1,  127,  128,    1,  127,  128,
			    1,  127,  128,   84,  127,  128, -213,   84,  127,  128,
			 -213,   84,  127,  128, -213,    1,  127,  128,    1,  127,
			  128,    1,  127,  128,    1,  127,  128,   11,  127,  128,
			 -140,   11,  127,  128, -140,  127,  128,  127,  128,  126,
			  128,  124,  125,  126,  128,  124,  125,  128,  126,  128,
			   73,  128,   78,  128,   74,  128, -203,   77,  128,   81,

			  128,   81,  128,   80,  128,   79,   81,  128,   42,  128,
			   42,  128,   41,  128,   48,  128,   48,  128,   47,  128,
			   48,  128,   45,  128,   48,  128,   51,  128,   50,  128,
			   51,  128,   54,  128,   54,  128,   53,  128,   60,  128,
			   60,  128,   59,  128,   60,  128,   57,  128,   60,  128,
			   63,  128,   62,  128,   63,  128,  122,  123,    2,    3,
			   66,   38,   64, -167, -193,   66,   66, -180,   66, -168,
			   16,   18,   14,   17,   22,   35,   35,   34,   35,    2,
			  123,    5,  115,  121, -240, -246,  -85, -238,   84, -213,
			   84, -213,   82, -211,   90, -219,   82, -211,  -12,   11,

			 -140,   11, -140,   88, -217,  124,  125,  125,   73,   74,
			 -203,  -75,   76,   76,   67,   73,   76,   71,   76,   72,
			   76,   80,   79,   41,   48,   47,   48,   45,   48,   48,
			   48,   46,   47,   48,   43,   45, -172,   51,   50,   51,
			   49,   50,   53,   60,   59,   60,   57,   60,   60,   60,
			   58,   59,   60,   55,   57, -184,   63,   62,   63,   61,
			   62,    3,  -39,  -65,   36,   38,   64, -165, -167, -193,
			   66, -180,   66, -168,   66,   66, -180, -168,   66,  -52,
			   66,  -40,   21,   15,   19,   23,   35,   33,   35,    2,
			    4,  123,  123,    6,    7, -112, -118,  113, -110,  113,

			  113,  115,  121, -240, -246,  113,  -83,  104, -233,   98,
			 -227,   92, -221,  -91,   86, -215,   11, -140,  -89,  125,
			  125,   70,   70,   70,   70,  -44,  -56,    3,    3,  -37,
			  -39,  -65,   64, -193,   66, -180,   66, -168,   20,   24,
			   25,   26,   32,   32,   32,   32,    4,    7,  115,  121,
			 -240, -246,  121, -246, -110,  114,  120, -239, -245, -105,
			  108, -237,  106, -235,  -99,  102, -231,  100, -229,  -93,
			   96, -225,   94, -223,  -87, -244,   11, -140,   68,   69,
			   73,   70,   70,   70,   70,  -65,   66,   66,   25,   27,
			   28,   35,   32,   32,   32,   32,    4,    4,    7,    7,

			 -118,  114,  115,  120,  121, -239, -240, -245, -246,  121,
			 -246, -111, -117, -109,  104, -233, -107, -103,   98, -227,
			 -101,  -97,   92, -221,  -95,  119, -116,  119,  119,  121,
			 -246,  119,  -12,    8,   70,   25,   25,   28,   29,   31,
			   32,  121, -246,  121, -246, -111, -112, -117, -118,  120,
			 -245, -116,  120, -245,    9,   10,  -12,   69,   28,   28,
			   30,   35,  120,  121, -245, -246,  120,  121, -245, -246,
			 -117,   31, -117, -118,   10, yy_Dummy>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 2561
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 390
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 391
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

	yyNb_rules: INTEGER is 128
			-- Number of rules

	yyEnd_of_buffer: INTEGER is 129
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
