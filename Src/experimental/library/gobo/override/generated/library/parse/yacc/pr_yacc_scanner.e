indexing

	description:

		"Scanners for parser generators such as 'geyacc'"

	library: "Gobo Eiffel Parse Library"
	copyright: "Copyright (c) 1999, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class PR_YACC_SCANNER

inherit

	PR_YACC_SCANNER_SKELETON

create

	make

feature -- Status report

	valid_start_condition (sc: INTEGER): BOOLEAN is
			-- Is `sc' a valid start condition?
		do
			Result := (INITIAL <= sc and sc <= ERROR_ACTION)
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
		end

	yy_execute_action (yy_act: INTEGER) is
			-- Execute semantic action.
		do
if yy_act <= 43 then
if yy_act <= 22 then
if yy_act <= 11 then
if yy_act <= 6 then
if yy_act <= 3 then
if yy_act <= 2 then
if yy_act = 1 then
--|#line 39 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 39")
end
last_token := T_TOKEN
else
--|#line 40 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 40")
end
last_token := T_LEFT
end
else
--|#line 41 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 41")
end
last_token := T_RIGHT
end
else
if yy_act <= 5 then
if yy_act = 4 then
--|#line 42 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 42")
end
last_token := T_NONASSOC
else
--|#line 43 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 43")
end
last_token := T_TYPE
end
else
--|#line 44 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 44")
end
last_token := T_START
end
end
else
if yy_act <= 9 then
if yy_act <= 8 then
if yy_act = 7 then
--|#line 45 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 45")
end
last_token := T_EXPECT
else
--|#line 46 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 46")
end
last_token := Comma_code
end
else
--|#line 47 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 47")
end
last_token := Less_than_code
end
else
if yy_act = 10 then
--|#line 48 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 48")
end
last_token := Greater_than_code
else
--|#line 49 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 49")
end
last_token := Left_bracket_code
end
end
end
else
if yy_act <= 17 then
if yy_act <= 14 then
if yy_act <= 13 then
if yy_act = 12 then
--|#line 50 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 50")
end
last_token := Right_bracket_code
else
--|#line 51 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 51")
end

						line_nb := line_nb + 1
						set_start_condition (EIFFEL_CODE)
					
end
else
--|#line 55 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 55")
end

						set_start_condition (EIFFEL_CODE)
					
end
else
if yy_act <= 16 then
if yy_act = 15 then
--|#line 58 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 58")
end

						last_token := T_2PERCENTS
						set_start_condition (SECTION2)
					
else
--|#line 62 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 62")
end
last_token := T_UNKNOWN
end
else
--|#line 66 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 66")
end
-- Separator or comment.
end
end
else
if yy_act <= 20 then
if yy_act <= 19 then
if yy_act = 18 then
--|#line 67 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 67")
end
line_nb := line_nb + 1
else
--|#line 69 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 69")
end

						last_token := T_INTEGER
						last_string_value := text
					
end
else
--|#line 73 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 73")
end

						last_token := T_INTEGER_8
						last_string_value := text
					
end
else
if yy_act = 21 then
--|#line 77 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 77")
end

						last_token := T_INTEGER_16
						last_string_value := text
					
else
--|#line 81 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 81")
end

						last_token := T_INTEGER_32
						last_string_value := text
					
end
end
end
end
else
if yy_act <= 33 then
if yy_act <= 28 then
if yy_act <= 25 then
if yy_act <= 24 then
if yy_act = 23 then
--|#line 85 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 85")
end

						last_token := T_INTEGER_64
						last_string_value := text
					
else
--|#line 89 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 89")
end

						last_token := T_NATURAL
						last_string_value := text
					
end
else
--|#line 93 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 93")
end

						last_token := T_NATURAL_8
						last_string_value := text
					
end
else
if yy_act <= 27 then
if yy_act = 26 then
--|#line 97 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 97")
end

						last_token := T_NATURAL_16
						last_string_value := text
					
else
--|#line 101 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 101")
end

						last_token := T_NATURAL_32
						last_string_value := text
					
end
else
--|#line 105 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 105")
end

						last_token := T_NATURAL_64
						last_string_value := text
					
end
end
else
if yy_act <= 31 then
if yy_act <= 30 then
if yy_act = 29 then
--|#line 109 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 109")
end

						last_token := T_BOOLEAN
						last_string_value := text
					
else
--|#line 113 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 113")
end

						last_token := T_REAL
						last_string_value := text
					
end
else
--|#line 117 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 117")
end

						last_token := T_REAL_32
						last_string_value := text
					
end
else
if yy_act = 32 then
--|#line 121 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 121")
end

						last_token := T_REAL_64
						last_string_value := text
					
else
--|#line 125 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 125")
end

						last_token := T_DOUBLE
						last_string_value := text
					
end
end
end
else
if yy_act <= 38 then
if yy_act <= 36 then
if yy_act <= 35 then
if yy_act = 34 then
--|#line 129 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 129")
end

						last_token := T_CHARACTER
						last_string_value := text
					
else
--|#line 133 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 133")
end

						last_token := T_CHARACTER_8
						last_string_value := text
					
end
else
--|#line 137 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 137")
end

						last_token := T_CHARACTER_32
						last_string_value := text
					
end
else
if yy_act = 37 then
--|#line 141 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 141")
end

						last_token := T_POINTER
						last_string_value := text
					
else
--|#line 145 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 145")
end

						last_token := T_TUPLE
						last_string_value := text
					
end
end
else
if yy_act <= 41 then
if yy_act <= 40 then
if yy_act = 39 then
--|#line 149 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 149")
end

						last_token := T_LIKE
						last_string_value := text
					
else
--|#line 153 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 153")
end

						last_token := T_CURRENT
						last_string_value := text
					
end
else
--|#line 157 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 157")
end

						last_token := T_EXPANDED
						last_string_value := text
					
end
else
if yy_act = 42 then
--|#line 161 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 161")
end

						last_token := T_REFERENCE
						last_string_value := text
					
else
--|#line 165 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 165")
end

						last_token := T_SEPARATE
						last_string_value := text
					
end
end
end
end
end
else
if yy_act <= 65 then
if yy_act <= 54 then
if yy_act <= 49 then
if yy_act <= 46 then
if yy_act <= 45 then
if yy_act = 44 then
--|#line 169 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 169")
end

						last_token := T_ATTACHED
						last_string_value := text
					
else
--|#line 173 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 173")
end

						last_token := T_DETACHABLE
						last_string_value := text
					
end
else
--|#line 177 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 177")
end

						last_token := T_AS
						last_string_value := text
					
end
else
if yy_act <= 48 then
if yy_act = 47 then
--|#line 181 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 181")
end

						last_token := T_IDENTIFIER
						last_string_value := text
					
else
--|#line 185 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 185")
end

						last_token := T_NUMBER
						last_integer_value := text.to_integer
						if last_integer_value = 0 then
							report_null_integer_error
						end
					
end
else
--|#line 192 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 192")
end

						last_token := T_CHAR
						last_string_value := text
					
end
end
else
if yy_act <= 52 then
if yy_act <= 51 then
if yy_act = 50 then
--|#line 196 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 196")
end

						last_token := T_STR
						last_string_value := text
						if text_count < 4 then
							report_invalid_string_token_error (text)
						end
					
else
--|#line 206 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 206")
end
last_token := T_PREC
end
else
--|#line 207 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 207")
end

						last_token := T_ERROR
						last_integer_value := line_nb
						set_start_condition (ERROR_SECTION)
					
end
else
if yy_act = 53 then
--|#line 212 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 212")
end

						last_token := Colon_code
						last_integer_value := line_nb
					
else
--|#line 216 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 216")
end

						last_token := Bar_code
						last_integer_value := line_nb
					
end
end
end
else
if yy_act <= 60 then
if yy_act <= 57 then
if yy_act <= 56 then
if yy_act = 55 then
--|#line 220 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 220")
end
last_token := Semicolon_code
else
--|#line 221 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 221")
end

						line_nb := line_nb + 1
						set_start_condition (EIFFEL_ACTION)
					
end
else
--|#line 225 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 225")
end

						set_start_condition (EIFFEL_ACTION)
					
end
else
if yy_act <= 59 then
if yy_act = 58 then
--|#line 228 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 228")
end

						last_token := T_2PERCENTS
						set_start_condition (SECTION3)
					
else
--|#line 235 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 235")
end

						last_token := T_USER_CODE
						last_string_value := text
					
end
else
--|#line 242 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 242")
end
-- Separator or comment.
end
end
else
if yy_act <= 63 then
if yy_act <= 62 then
if yy_act = 61 then
--|#line 243 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 243")
end
line_nb := line_nb + 1
else
--|#line 245 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 245")
end
last_token := Left_parenthesis_code
end
else
--|#line 246 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 246")
end
last_token := Right_parenthesis_code
end
else
if yy_act = 64 then
--|#line 247 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 247")
end

						last_token := T_NUMBER
						last_error := text.to_integer
						last_integer_value := last_error
					
else
--|#line 252 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 252")
end

						line_nb := line_nb + 1
						set_start_condition (ERROR_ACTION)
					
end
end
end
end
else
if yy_act <= 76 then
if yy_act <= 71 then
if yy_act <= 68 then
if yy_act <= 67 then
if yy_act = 66 then
--|#line 256 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 256")
end

						set_start_condition (ERROR_ACTION)
					
else
--|#line 262 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 262")
end
more
end
else
--|#line 263 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 263")
end
more
end
else
if yy_act <= 70 then
if yy_act = 69 then
--|#line 264 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 264")
end
more
else
--|#line 265 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 265")
end
more
end
else
--|#line 266 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 266")
end
more
end
end
else
if yy_act <= 74 then
if yy_act <= 73 then
if yy_act = 72 then
--|#line 267 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 267")
end

					line_nb := line_nb + 1
					more
				
else
--|#line 271 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 271")
end

					last_token := T_EIFFEL
					last_string_value := text_substring (1, text_count - 2)
					set_start_condition (INITIAL)
				
end
else
--|#line 285 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 285")
end

					action_buffer.append_string (text)
				
end
else
if yy_act = 75 then
--|#line 286 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 286")
end

					action_buffer.append_string (text)
				
else
--|#line 287 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 287")
end

					action_buffer.append_string (text)
				
end
end
end
else
if yy_act <= 81 then
if yy_act <= 79 then
if yy_act <= 78 then
if yy_act = 77 then
--|#line 288 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 288")
end

					action_buffer.append_string (text)
				
else
--|#line 289 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 289")
end

					action_buffer.append_string (text)
				
end
else
--|#line 292 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 292")
end

					line_nb := line_nb + text_count
					action_buffer.append_string (text)
				
end
else
if yy_act = 80 then
--|#line 296 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 296")
end

					if start_condition = ERROR_ACTION then
						report_invalid_dollar_dollar_error
						action_buffer.append_string ("$$")
					elseif rule /= Void then
						process_dollar_dollar (rule)
					else
						action_buffer.append_string ("$$")
					end
				
else
--|#line 306 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 306")
end

					if text_substring (2, text_count).is_integer then
						if rule /= Void then
							if start_condition = ERROR_ACTION then
								process_dollar_n (text_substring (2, text_count).to_integer, last_error - 1, rule)
							else
								process_dollar_n (text_substring (2, text_count).to_integer, rule.rhs.count, rule)
							end
						else
							action_buffer.append_string (text)
						end
					else
						report_integer_too_large_error (text_substring (2, text_count))
						action_buffer.append_string (text)
					end
				
end
end
else
if yy_act <= 84 then
if yy_act <= 83 then
if yy_act = 82 then
--|#line 322 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 322")
end

					if text_substring (3, text_count).is_integer then
						if rule /= Void then
							if start_condition = ERROR_ACTION then
								process_dollar_n (- text_substring (3, text_count).to_integer, last_error - 1, rule)
							else
								process_dollar_n (- text_substring (3, text_count).to_integer, rule.rhs.count, rule)
							end
						else
							action_buffer.append_string (text)
						end
					else
						report_integer_too_large_error (text_substring (3, text_count))
						action_buffer.append_string (text)
					end
				
else
--|#line 338 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 338")
end

					action_buffer.append_character ('{')
					nb_open_brackets := nb_open_brackets + 1
				
end
else
--|#line 342 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 342")
end

					if nb_open_brackets = 0 then
						last_token := T_ACTION
						last_string_value := cloned_string (action_buffer)
						action_buffer.wipe_out
						set_start_condition (SECTION2)
					else
						action_buffer.append_character ('}')
						nb_open_brackets := nb_open_brackets - 1
					end
				
end
else
if yy_act = 85 then
--|#line 362 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 362")
end

					last_token := text_item (1).code
				
else
--|#line 0 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 0")
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

	yy_execute_eof_action (yy_sc: INTEGER) is
			-- Execute EOF semantic action.
		do
			inspect yy_sc
when 3 then
--|#line 0 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 0")
end

					report_missing_characters_error ("%%}")
					last_token := T_EIFFEL
					last_string_value := text_substring (1, text_count)
					set_start_condition (INITIAL)
				
when 4, 6 then
--|#line 0 "pr_yacc_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'pr_yacc_scanner.l' at line 0")
end

					report_missing_characters_error ("}")
					last_token := T_ACTION
					last_string_value := cloned_string (action_buffer)
					action_buffer.wipe_out
					set_start_condition (SECTION2)
				
			else
				terminate
			end
		end

feature {NONE} -- Table templates

	yy_nxt_template: SPECIAL [INTEGER] is
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 1056)
			yy_nxt_template_1 (an_array)
			yy_nxt_template_2 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_nxt_template_1 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			    0,   16,   17,   18,   17,   19,   16,   20,   21,   16,
			   16,   22,   23,   16,   24,   24,   24,   24,   24,   24,
			   24,   24,   16,   16,   25,   26,   27,   28,   29,   30,
			   31,   32,   32,   32,   33,   32,   32,   34,   35,   32,
			   36,   37,   38,   39,   32,   32,   32,   40,   16,   41,
			   16,   16,   16,   16,   42,   49,   88,   50,   16,   51,
			   52,   69,  100,   69,   53,   85,   86,   89,  284,   43,
			   44,   16,   16,   49,   90,   50,  281,   51,   52,  103,
			  104,  103,   53,   91,  108,  101,  109,  108,  117,  109,
			  118,  119,  280,  279,   16,  102,   16,  120,   45,   46,

			   42,  125,  135,  125,   16,  128,  129,  128,   69,  136,
			   69,   79,  137,   79,  152,   43,   44,   16,   16,  153,
			  103,  104,  103,  108,  285,  109,  108,  111,  109,  117,
			  285,  118,  160,  158,  278,  110,  122,  285,  277,  161,
			   16,  164,   16,  285,   45,   46,   55,  276,   56,   57,
			   56,   58,  125,  138,  125,   59,  128,  129,  128,  172,
			  172,  172,  172,  172,  172,  138,  233,  282,  234,  275,
			  283,   80,   80,   80,   80,   80,   80,  265,  274,  266,
			  273,  267,  268,  269,  264,  270,  263,  271,  272,  262,
			  261,  260,  259,  258,   60,  257,   61,   55,  256,   56,

			   57,   56,   58,  255,  254,  253,   59,   83,   83,   83,
			   83,   83,   83,   83,  127,  127,  127,  127,  127,  127,
			  127,  162,  162,  162,  162,  162,  162,  162,  191,  191,
			  191,  191,  191,  191,  191,  192,  192,  192,  192,  192,
			  192,  192,  252,  251,  250,   60,  249,   61,   62,   63,
			   62,  248,  247,  246,  245,   64,   65,  244,   66,  243,
			   67,   67,   67,   67,   67,   67,   67,   67,  193,  193,
			  193,  193,  193,  193,  193,  194,  194,  194,  194,  194,
			  194,  194,  242,  241,  240,  239,  238,  237,  236,  235,
			  232,  231,  230,  229,  228,  227,  226,   68,   62,   63,

			   62,  225,  224,  223,  222,   64,   65,  221,   66,  220,
			   67,   67,   67,   67,   67,   67,   67,   67,  219,  218,
			  122,  116,  111,  107,  217,  216,  215,  214,  213,  212,
			  211,  210,  209,  208,  207,  206,  205,  204,  203,  202,
			  138,  201,  200,  199,  198,  197,  196,   68,   55,  195,
			   56,   57,   56,   58,  190,  189,  188,   59,  187,  186,
			  185,  184,  183,  182,  181,  180,  179,  178,  177,  176,
			  175,  174,  138,  171,  170,  169,  168,  167,  166,  165,
			  163,  115,  159,  157,  156,  155,  154,  151,  150,  149,
			  148,  147,  146,  145,  144,  143,   60,  142,   61,   55,

			  141,   56,   57,   56,   58,  138,  134,  133,   59,  132,
			  131,  130,   71,  126,  124,  123,  115,  113,  112,   99,
			   98,   97,   96,   95,   94,   93,   92,   87,   82,   81,
			   71,  285,  285,  285,  285,  285,  285,  285,  285,  285,
			  285,  285,  285,  285,  285,  285,  285,   60,  285,   61,
			   72,  285,  285,  285,  285,  285,  285,  285,  285,  285,
			  285,  285,  285,  285,  285,  285,  285,  285,  285,  285,
			  285,  285,  285,   73,  285,  285,  285,  285,  285,  285,
			   74,   75,  285,  285,   76,   77,   78,  285,  285,  285,
			  285,  285,  285,  285,   79,   80,  285,  285,  285,  285,

			  285,  139,  139,  139,  139,  139,  139,  285,  285,  285,
			  285,  285,  285,  285,  285,  285,  285,  285,  285,  285,
			  285,  285,  285,  285,  285,  285,  285,  285,  285,  285,
			  285,  285,  140,   47,   47,   47,   47,   47,   47,   47,
			   47,   47,   47,   47,   47,   47,   47,   47,   47,   47,
			   47,   47,   47,   47,   47,   47,   47,   47,   48,   48,
			   48,   48,   48,   48,   48,   48,   48,   48,   48,   48,
			   48,   48,   48,   48,   48,   48,   48,   48,   48,   48,
			   48,   48,   48,   54,   54,   54,   54,   54,   54,   54,
			   54,   54,   54,   54,   54,   54,   54,   54,   54,   54,

			   54,   54,   54,   54,   54,   54,   54,   54,   16,   16,
			   16,   16,   16,   16,   16,   16,   16,   16,   16,   16,
			   16,   16,   16,   16,   16,   16,   16,   16,   16,   16,
			   16,   16,   16,   70,  285,   70,   70,   70,   70,   70,
			   70,   70,   70,   70,   70,   70,   70,   70,   70,   70,
			   70,   70,   70,   70,   70,   70,   70,   70,   80,  285,
			   80,   80,   80,  285,   80,   80,   80,   80,   80,   80,
			   80,   80,   80,   80,   80,   80,   80,   80,   80,   80,
			   80,   80,   80,   84,   84,   84,   84,   84,   84,   84,
			   84,   84,   84,   84,   84,   84,   84,   84,   84,  105,

			  105,  105,  105,  105,  105,  105,  105,  105,  105,  105,
			  105,  105,  105,  105,  105,  105,  105,  105,  105,  105,
			  105,  105,  105,  105,  106,  285,  285,  106,  285,  285,
			  285,  106,  106,  106,  106,  106,  106,  106,  106,  106,
			  106,  106,  106,  106,  106,  106,  106,  106,  106,  107,
			  285,  107,  107,  107,  107,  107,  107,  107,  107,  107,
			  107,  107,  107,  107,  107,  107,  107,  107,  107,  107,
			  107,  107,  107,  107,  111,  285,  111,  111,  111,  285,
			  111,  111,  111,  111,  111,  111,  111,  111,  111,  111,
			  111,  111,  111,  111,  111,  111,  111,  111,  111,  114,

			  285,  285,  285,  285,  285,  285,  114,  114,  114,  114,
			  114,  114,  114,  114,  114,  114,  114,  114,  114,  114,
			  114,  114,  116,  285,  116,  116,  116,  116,  116,  116,
			  116,  116,  116,  116,  116,  116,  116,  116,  116,  116,
			  116,  116,  116,  116,  116,  116,  116,  121,  285,  285,
			  121,  121,  121,  121,  121,  121,  121,  121,  122,  285,
			  122,  122,  122,  285,  122,  122,  122,  122,  122,  122,
			  122,  122,  122,  122,  122,  122,  122,  122,  122,  122,
			  122,  122,  122,   82,  285,   82,   82,   82,   82,   82,
			   82,   82,   82,   82,   82,   82,   82,   82,   82,   82,

			   82,   82,   82,   82,   82,   82,   82,   82,  113,  285,
			  113,  113,  113,  113,  113,  113,  113,  113,  113,  113,
			  113,  113,  113,  113,  113,  113,  113,  113,  113,  113,
			  113,  113,  113,  124,  285,  124,  124,  124,  124,  124,
			  124,  124,  124,  124,  124,  124,  124,  124,  124,  124,
			  124,  124,  124,  124,  124,  124,  124,  124,  126,  285,
			  126,  126,  126,  126,  126,  126,  126,  126,  126,  126,
			  126,  126,  126,  126,  126,  126,  126,  126,  126,  126,
			  126,  126,  126,  173,  285,  173,  173,  173,  173,  173,
			  173,  173,  173,   80,  285,   80,   80,   80,   80,   80, yy_Dummy>>,
			1, 1000, 0)
		end

	yy_nxt_template_2 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			   80,   80,   80,   15,  285,  285,  285,  285,  285,  285,
			  285,  285,  285,  285,  285,  285,  285,  285,  285,  285,
			  285,  285,  285,  285,  285,  285,  285,  285,  285,  285,
			  285,  285,  285,  285,  285,  285,  285,  285,  285,  285,
			  285,  285,  285,  285,  285,  285,  285,  285,  285,  285,
			  285,  285,  285,  285,  285,  285,  285, yy_Dummy>>,
			1, 57, 1000)
		end

	yy_chk_template: SPECIAL [INTEGER] is
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 1056)
			yy_chk_template_1 (an_array)
			yy_chk_template_2 (an_array)
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
			    1,    1,    1,    1,    3,    7,   29,    7,    3,    7,
			    7,   17,   42,   17,    7,   27,   27,   29,  282,    3,
			    3,    3,    3,    8,   30,    8,  271,    8,    8,   45,
			   45,   45,    8,   30,   50,   42,   50,   51,   56,   51,
			   56,   57,  270,  269,    3,   42,    3,   57,    3,    3,

			    4,   62,   78,   62,    4,   68,   68,   68,   69,   78,
			   69,   79,   79,   79,   97,    4,    4,    4,    4,   97,
			  103,  103,  103,  107,  109,  107,  110,  112,  110,  116,
			  118,  116,  112,  109,  267,   51,  123,  121,  266,  118,
			    4,  123,    4,  121,    4,    4,    9,  265,    9,    9,
			    9,    9,  125,  139,  125,    9,  128,  128,  128,  139,
			  139,  139,  139,  139,  139,  172,  212,  274,  212,  264,
			  274,  172,  172,  172,  172,  172,  172,  258,  263,  258,
			  260,  258,  258,  259,  256,  259,  255,  259,  259,  253,
			  252,  251,  247,  246,    9,  245,    9,   10,  244,   10,

			   10,   10,   10,  242,  240,  239,   10,  292,  292,  292,
			  292,  292,  292,  292,  302,  302,  302,  302,  302,  302,
			  302,  305,  305,  305,  305,  305,  305,  305,  309,  309,
			  309,  309,  309,  309,  309,  310,  310,  310,  310,  310,
			  310,  310,  236,  235,  234,   10,  233,   10,   11,   11,
			   11,  232,  231,  230,  229,   11,   11,  227,   11,  226,
			   11,   11,   11,   11,   11,   11,   11,   11,  311,  311,
			  311,  311,  311,  311,  311,  312,  312,  312,  312,  312,
			  312,  312,  225,  224,  223,  219,  218,  216,  214,  213,
			  211,  210,  209,  208,  207,  206,  205,   11,   12,   12,

			   12,  204,  203,  202,  200,   12,   12,  199,   12,  198,
			   12,   12,   12,   12,   12,   12,   12,   12,  197,  195,
			  194,  193,  192,  191,  190,  189,  188,  187,  186,  185,
			  184,  183,  181,  180,  179,  178,  177,  176,  175,  174,
			  173,  171,  170,  169,  168,  167,  166,   12,   13,  165,
			   13,   13,   13,   13,  157,  156,  155,   13,  154,  153,
			  152,  151,  150,  149,  148,  147,  146,  145,  144,  143,
			  142,  141,  140,  136,  135,  134,  133,  132,  131,  130,
			  122,  115,  111,  102,  101,   99,   98,   96,   95,   94,
			   93,   92,   91,   90,   89,   88,   13,   87,   13,   14,

			   86,   14,   14,   14,   14,   80,   77,   76,   14,   75,
			   74,   73,   70,   66,   59,   58,   55,   53,   52,   39,
			   38,   37,   36,   35,   34,   33,   31,   28,   23,   21,
			   19,   15,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,   14,    0,   14,
			   20,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,   20,    0,    0,    0,    0,    0,    0,
			   20,   20,    0,    0,   20,   20,   20,    0,    0,    0,
			    0,    0,    0,    0,   20,   81,    0,    0,    0,    0,

			    0,   81,   81,   81,   81,   81,   81,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,   81,  286,  286,  286,  286,  286,  286,  286,
			  286,  286,  286,  286,  286,  286,  286,  286,  286,  286,
			  286,  286,  286,  286,  286,  286,  286,  286,  287,  287,
			  287,  287,  287,  287,  287,  287,  287,  287,  287,  287,
			  287,  287,  287,  287,  287,  287,  287,  287,  287,  287,
			  287,  287,  287,  288,  288,  288,  288,  288,  288,  288,
			  288,  288,  288,  288,  288,  288,  288,  288,  288,  288,

			  288,  288,  288,  288,  288,  288,  288,  288,  289,  289,
			  289,  289,  289,  289,  289,  289,  289,  289,  289,  289,
			  289,  289,  289,  289,  289,  289,  289,  289,  289,  289,
			  289,  289,  289,  290,    0,  290,  290,  290,  290,  290,
			  290,  290,  290,  290,  290,  290,  290,  290,  290,  290,
			  290,  290,  290,  290,  290,  290,  290,  290,  291,    0,
			  291,  291,  291,    0,  291,  291,  291,  291,  291,  291,
			  291,  291,  291,  291,  291,  291,  291,  291,  291,  291,
			  291,  291,  291,  293,  293,  293,  293,  293,  293,  293,
			  293,  293,  293,  293,  293,  293,  293,  293,  293,  294,

			  294,  294,  294,  294,  294,  294,  294,  294,  294,  294,
			  294,  294,  294,  294,  294,  294,  294,  294,  294,  294,
			  294,  294,  294,  294,  295,    0,    0,  295,    0,    0,
			    0,  295,  295,  295,  295,  295,  295,  295,  295,  295,
			  295,  295,  295,  295,  295,  295,  295,  295,  295,  296,
			    0,  296,  296,  296,  296,  296,  296,  296,  296,  296,
			  296,  296,  296,  296,  296,  296,  296,  296,  296,  296,
			  296,  296,  296,  296,  297,    0,  297,  297,  297,    0,
			  297,  297,  297,  297,  297,  297,  297,  297,  297,  297,
			  297,  297,  297,  297,  297,  297,  297,  297,  297,  298,

			    0,    0,    0,    0,    0,    0,  298,  298,  298,  298,
			  298,  298,  298,  298,  298,  298,  298,  298,  298,  298,
			  298,  298,  299,    0,  299,  299,  299,  299,  299,  299,
			  299,  299,  299,  299,  299,  299,  299,  299,  299,  299,
			  299,  299,  299,  299,  299,  299,  299,  300,    0,    0,
			  300,  300,  300,  300,  300,  300,  300,  300,  301,    0,
			  301,  301,  301,    0,  301,  301,  301,  301,  301,  301,
			  301,  301,  301,  301,  301,  301,  301,  301,  301,  301,
			  301,  301,  301,  303,    0,  303,  303,  303,  303,  303,
			  303,  303,  303,  303,  303,  303,  303,  303,  303,  303,

			  303,  303,  303,  303,  303,  303,  303,  303,  304,    0,
			  304,  304,  304,  304,  304,  304,  304,  304,  304,  304,
			  304,  304,  304,  304,  304,  304,  304,  304,  304,  304,
			  304,  304,  304,  306,    0,  306,  306,  306,  306,  306,
			  306,  306,  306,  306,  306,  306,  306,  306,  306,  306,
			  306,  306,  306,  306,  306,  306,  306,  306,  307,    0,
			  307,  307,  307,  307,  307,  307,  307,  307,  307,  307,
			  307,  307,  307,  307,  307,  307,  307,  307,  307,  307,
			  307,  307,  307,  308,    0,  308,  308,  308,  308,  308,
			  308,  308,  308,  313,    0,  313,  313,  313,  313,  313, yy_Dummy>>,
			1, 1000, 0)
		end

	yy_chk_template_2 (an_array: ARRAY [INTEGER]) is
		do
			yy_array_subcopy (an_array, <<
			  313,  313,  313,  285,  285,  285,  285,  285,  285,  285,
			  285,  285,  285,  285,  285,  285,  285,  285,  285,  285,
			  285,  285,  285,  285,  285,  285,  285,  285,  285,  285,
			  285,  285,  285,  285,  285,  285,  285,  285,  285,  285,
			  285,  285,  285,  285,  285,  285,  285,  285,  285,  285,
			  285,  285,  285,  285,  285,  285,  285, yy_Dummy>>,
			1, 57, 1000)
		end

	yy_base_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,   47,   93,    0,    0,   52,   70,  143,
			  194,  246,  296,  345,  396,  431, 1003,   59, 1003,  425,
			  443,  381, 1003,  416,    0, 1003, 1003,   23,  388,   23,
			   44,  381,    0,  387,  390,  397,  383,  391,  390,  375,
			 1003, 1003,   55, 1003, 1003,   77, 1003,    0,    0, 1003,
			   79,   82,  411,  405,    0,  413,   83,   85,  408,  402,
			 1003, 1003,   99, 1003, 1003, 1003,  401,    0,  103,  106,
			  407, 1003, 1003,  366,  380,  370,  373,  363,   63,  109,
			  397,  487,    0,    0,    0,    0,  357,  358,  369,  353,
			  350,  348,  351,  347,  353,  345,  353,   88,  346,  345,

			 1003,  343,  342,  118, 1003,    0,    0,  118, 1003,  120,
			  121,  374,  119,    0,    0,  378,  124, 1003,  126, 1003,
			    0,  131,  372,  128,    0,  150,    0,    0,  154, 1003,
			  339,  347,  339,  344,  349,  338,  333, 1003, 1003,  145,
			  364,  345,  333,  328,  327,  341,  339,  339,  334,  333,
			  318,  323,  323,  329,  332,  319,  314,  324,    0, 1003,
			    0,    0,    0, 1003,    0,  319,  303,  319,  311,  302,
			  312,  311,  157,  332,  311,  308,  311,  306,  307,  297,
			  295,  300,    0,  290,  287,  279,  287,  286,  296,  286,
			  296,  310,  309,  308,  307,  291, 1003,  276,  266,  264,

			  266, 1003,  270,  276,  273,  258,  262,  264,  264,  262,
			  265,  260,  149,  259,  262,    0,  246, 1003,  243,  243,
			 1003, 1003, 1003,  254,  245,  239,  216,  231,    0,  224,
			  212,  215,  210,  230,  226,  205,  199, 1003, 1003,  166,
			  175,    0,  173,    0,  171,  166,  143,  142,    0,    0,
			    0,  163,  160,  161,    0,  145,  147,    0,  162,  168,
			  150,    0, 1003,  128,  139,  128,  122,  116,    0,   74,
			   76,   58,    0,    0,  150,    0,    0,    0,    0,    0,
			    0,    0,   52,    0,    0, 1003,  532,  557,  582,  607,
			  632,  657,  199,  675,  698,  723,  748,  773,  798,  821,

			  843,  857,  206,  882,  907,  213,  932,  957,  977,  220,
			  227,  260,  267,  987, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  285,    1,    1,    1,  286,  286,  287,  287,  288,
			  288,  289,  289,  288,  288,  285,  285,  285,  285,  290,
			  285,  291,  285,  285,  292,  285,  285,  293,  293,  293,
			  293,  293,  293,  293,  293,  293,  293,  293,  293,  293,
			  285,  285,  285,  285,  285,  285,  285,  294,  295,  285,
			  296,  296,  297,  285,  298,  285,  299,  300,  301,  285,
			  285,  285,  285,  285,  285,  285,  285,  302,  285,  285,
			  290,  285,  285,  285,  285,  285,  285,  285,  285,  285,
			  285,  291,  303,  292,  293,  293,  293,  293,  293,  293,
			  293,  293,  293,  293,  293,  293,  293,  293,  293,  293,

			  285,  285,  285,  285,  285,  294,  295,  296,  285,  296,
			  296,  285,  297,  304,  298,  285,  299,  285,  299,  285,
			  305,  300,  285,  301,  306,  285,  307,  302,  285,  285,
			  285,  285,  285,  285,  285,  285,  285,  285,  285,  285,
			  308,  293,  293,  293,  293,  293,  293,  293,  293,  293,
			  293,  293,  293,  293,  293,  293,  285,  285,  309,  285,
			  310,  311,  305,  285,  312,  285,  285,  285,  285,  285,
			  285,  285,  285,  313,  293,  293,  293,  293,  293,  293,
			  293,  293,  293,  293,  293,  293,  293,  293,  293,  285,
			  285,  309,  310,  311,  312,  285,  285,  285,  285,  285,

			  285,  285,  293,  293,  293,  293,  293,  293,  293,  293,
			  293,  293,  293,  293,  293,  293,  285,  285,  285,  285,
			  285,  285,  285,  293,  293,  293,  293,  293,  293,  293,
			  293,  293,  293,  293,  293,  293,  293,  285,  285,  285,
			  293,  293,  293,  293,  293,  293,  293,  293,  293,  293,
			  293,  293,  293,  285,  293,  293,  293,  293,  293,  293,
			  293,  293,  285,  293,  293,  293,  293,  293,  293,  293,
			  293,  293,  293,  293,  293,  293,  293,  293,  293,  293,
			  293,  293,  293,  293,  293,    0,  285,  285,  285,  285,
			  285,  285,  285,  285,  285,  285,  285,  285,  285,  285,

			  285,  285,  285,  285,  285,  285,  285,  285,  285,  285,
			  285,  285,  285,  285, yy_Dummy>>)
		end

	yy_ec_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    2,
			    3,    1,    1,    4,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    2,    1,    5,    1,    6,    7,    1,    8,
			    9,   10,    1,    1,   11,   12,    1,   13,   14,   15,
			   16,   17,   18,   14,   19,   14,   20,   21,   22,   23,
			   24,    1,   25,    1,    1,   26,   27,   28,   29,   30,
			   31,   32,   33,   34,   35,   36,   37,   35,   38,   39,
			   40,   35,   41,   42,   43,   44,   35,   35,   45,   46,
			   35,   47,   48,   49,    1,   50,    1,   26,   27,   28,

			   29,   30,   31,   32,   33,   34,   35,   36,   37,   35,
			   38,   39,   40,   35,   41,   42,   43,   44,   35,   35,
			   45,   46,   35,   51,   52,   53,    1,    1,    1,    1,
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
			    0,    1,    1,    2,    1,    3,    4,    5,    6,    1,
			    1,    1,    7,    1,    8,    8,    9,   10,   11,   12,
			   13,   14,    1,    1,    1,    1,   15,   15,   15,   15,
			   15,   15,   16,   16,   16,   16,   16,   16,   16,   16,
			   16,   17,   18,   19,   20,   21,   22,    1,    1,    1,
			   23,   24,    1,   25, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,    0,    0,    0,    0,   67,   67,   74,
			   74,    0,    0,   74,   74,   87,   85,   17,   18,   85,
			   16,   85,    8,   85,   48,    9,   10,   47,   47,   47,
			   47,   47,   47,   47,   47,   47,   47,   47,   47,   47,
			   11,   12,   85,   53,   55,   57,   54,   59,   67,   72,
			   71,   71,   71,   71,   74,   79,   78,   78,   78,   78,
			   83,   84,   60,   61,   62,   63,   85,   64,   66,   17,
			    0,   50,   15,    0,    0,    0,    0,    0,    0,   14,
			    0,    0,   17,   48,   47,   46,   47,   47,   47,   47,
			   47,   47,   47,   47,   47,   47,   47,   47,   47,   47,

			   58,    0,    0,   57,   56,   59,   67,    0,   68,   68,
			   73,    0,    0,   70,   74,   79,    0,   75,   75,   80,
			    0,   81,    0,    0,   77,   60,   60,   64,   66,   65,
			    0,    0,    0,    0,    0,    0,    0,   13,   49,    0,
			    0,   47,   47,   47,   47,   47,   47,   47,   47,   47,
			   47,   47,   47,   47,   47,   47,    0,    0,    0,   69,
			    0,    0,   82,   76,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,   47,   47,   47,   47,   47,   47,
			   47,   47,   39,   47,   47,   30,   47,   47,   47,    0,
			    0,    0,    0,    0,    0,    0,    2,    0,    0,    0,

			    0,    5,   47,   47,   47,   47,   47,   47,   47,   47,
			   47,   47,   47,   47,   47,   38,    0,   51,    0,    0,
			    3,    6,    1,   47,   47,   47,   47,   47,   33,   47,
			   47,   47,   47,   47,   47,   47,   47,   52,    7,    0,
			   47,   29,   47,   40,   47,   47,   19,   24,   37,   31,
			   32,   47,   47,    0,   44,   47,   47,   41,   47,   47,
			   47,   43,    4,   34,   47,   47,   47,   47,   20,   47,
			   47,   47,   25,   42,   47,   45,   21,   22,   23,   26,
			   27,   28,   47,   35,   36,    0, yy_Dummy>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 1003
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 285
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 286
			-- Mark between normal states and templates

	yyNull_equiv_class: INTEGER is 1
			-- Equivalence code for NULL character

	yyReject_used: BOOLEAN is false
			-- Is `reject' called?

	yyVariable_trail_context: BOOLEAN is false
			-- Is there a regular expression with
			-- both leading and trailing parts having
			-- variable length?

	yyReject_or_variable_trail_context: BOOLEAN is false
			-- Is `reject' called or is there a
			-- regular expression with both leading
			-- and trailing parts having variable length?

	yyNb_rules: INTEGER is 86
			-- Number of rules

	yyEnd_of_buffer: INTEGER is 87
			-- End of buffer rule code

	yyLine_used: BOOLEAN is false
			-- Are line and column numbers used?

	yyPosition_used: BOOLEAN is false
			-- Is `position' used?

	INITIAL: INTEGER is 0
	SECTION2: INTEGER is 1
	SECTION3: INTEGER is 2
	EIFFEL_CODE: INTEGER is 3
	EIFFEL_ACTION: INTEGER is 4
	ERROR_SECTION: INTEGER is 5
	ERROR_ACTION: INTEGER is 6
			-- Start condition codes

feature -- User-defined features



end
