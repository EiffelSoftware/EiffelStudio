note

	description:

		"Scanners for lexical analyzer generators such as 'gelex'"

	library: "Gobo Eiffel Lexical Library"
	copyright: "Copyright (c) 1999-2003, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class LX_LEX_SCANNER

inherit

	LX_LEX_SCANNER_SKELETON
		redefine
			last_integer_value
		end

	LX_LEX_TOKENS
		export
			{NONE} all
		redefine
			last_integer_value
		end

create

	make, make_from_description

feature -- Status report

	valid_start_condition (sc: INTEGER): BOOLEAN
			-- Is `sc' a valid start condition?
		do
			Result := (INITIAL <= sc and sc <= EIFFEL_BLOCK2)
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
		end

	yy_execute_action (yy_act: INTEGER)
			-- Execute semantic action.
		do
if yy_act <= 60 then
if yy_act <= 30 then
if yy_act <= 15 then
if yy_act <= 8 then
if yy_act <= 4 then
if yy_act <= 2 then
if yy_act = 1 then
--|#line 57 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 57")
end
-- Separator or comment.
else
--|#line 58 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 58")
end
line_nb := line_nb + 1
end
else
if yy_act = 3 then
--|#line 59 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 59")
end

					line_nb := line_nb + 1
					set_start_condition (EIFFEL_BLOCK)
				
else
--|#line 63 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 63")
end
set_start_condition (SCNAME)
end
end
else
if yy_act <= 6 then
if yy_act = 5 then
--|#line 64 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 64")
end
set_start_condition (XSCNAME)
else
--|#line 65 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 65")
end
set_start_condition (OPTION)
end
else
if yy_act = 7 then
--|#line 66 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 66")
end

						-- Keep track of the definition name.
					last_string := text
					set_start_condition (DEFINITION)
				
else
--|#line 71 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 71")
end

					last_token := ENDSECT
					set_start_condition (SECT2)
				
end
end
end
else
if yy_act <= 12 then
if yy_act <= 10 then
if yy_act = 9 then
--|#line 75 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 75")
end

					report_unrecognized_directive_error
					set_start_condition (RECOVER1)
				
else
--|#line 79 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 79")
end

					report_directive_expected_error
					set_start_condition (RECOVER1)
				
end
else
if yy_act = 11 then
--|#line 86 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 86")
end
more
else
--|#line 87 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 87")
end
more
end
end
else
if yy_act <= 14 then
if yy_act = 13 then
--|#line 88 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 88")
end
more
else
--|#line 89 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 89")
end
more
end
else
--|#line 90 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 90")
end
more
end
end
end
else
if yy_act <= 23 then
if yy_act <= 19 then
if yy_act <= 17 then
if yy_act = 16 then
--|#line 91 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 91")
end

					last_string := text_substring (1, text_count - 2)
					line_nb := line_nb + last_string.occurrences ('%N')
					description.eiffel_header.force_last (last_string)
					set_start_condition (INITIAL)
				
else
--|#line 100 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 100")
end
-- Separator or comment.
end
else
if yy_act = 18 then
--|#line 101 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 101")
end
add_new_start_condition (text, start_condition = XSCNAME)
else
--|#line 102 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 102")
end

					line_nb := line_nb + 1
					set_start_condition (INITIAL)
				
end
end
else
if yy_act <= 21 then
if yy_act = 20 then
--|#line 106 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 106")
end

					report_start_condition_expected_error
					set_start_condition (RECOVER1)
				
else
--|#line 113 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 113")
end
-- Separator or comment.
end
else
if yy_act = 22 then
--|#line 114 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 114")
end
description.set_backing_up_report (True)
else
--|#line 115 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 115")
end
description.set_backing_up_report (False)
end
end
end
else
if yy_act <= 27 then
if yy_act <= 25 then
if yy_act = 24 then
--|#line 116 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 116")
end

					description.set_case_insensitive (False)
				
else
--|#line 119 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 119")
end

					description.set_case_insensitive (True)
				
end
else
if yy_act = 26 then
--|#line 122 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 122")
end
description.set_debug_mode (True)
else
--|#line 123 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 123")
end
description.set_debug_mode (False)
end
end
else
if yy_act <= 29 then
if yy_act = 28 then
--|#line 124 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 124")
end
description.set_no_default_rule (False)
else
--|#line 125 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 125")
end
description.set_no_default_rule (True)
end
else
--|#line 126 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 126")
end
description.set_equiv_classes_used (True)
end
end
end
end
else
if yy_act <= 45 then
if yy_act <= 38 then
if yy_act <= 34 then
if yy_act <= 32 then
if yy_act = 31 then
--|#line 127 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 127")
end
description.set_equiv_classes_used (False)
else
--|#line 128 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 128")
end
description.set_full_table (True)
end
else
if yy_act = 33 then
--|#line 129 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 129")
end
description.set_full_table (False)
else
--|#line 130 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 130")
end
description.set_meta_equiv_classes_used (True)
end
end
else
if yy_act <= 36 then
if yy_act = 35 then
--|#line 131 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 131")
end
description.set_meta_equiv_classes_used (False)
else
--|#line 132 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 132")
end
description.set_reject_used (True)
end
else
if yy_act = 37 then
--|#line 133 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 133")
end
description.set_reject_used (False)
else
--|#line 134 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 134")
end
description.set_line_used (True)
end
end
end
else
if yy_act <= 42 then
if yy_act <= 40 then
if yy_act = 39 then
--|#line 135 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 135")
end
description.set_line_used (False)
else
--|#line 136 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 136")
end
description.set_position_used (True)
end
else
if yy_act = 41 then
--|#line 137 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 137")
end
description.set_position_used (False)
else
--|#line 138 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 138")
end
description.set_pre_action_used (True)
end
end
else
if yy_act <= 44 then
if yy_act = 43 then
--|#line 139 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 139")
end
description.set_pre_action_used (False)
else
--|#line 140 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 140")
end
description.set_post_action_used (True)
end
else
--|#line 141 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 141")
end
description.set_post_action_used (False)
end
end
end
else
if yy_act <= 53 then
if yy_act <= 49 then
if yy_act <= 47 then
if yy_act = 46 then
--|#line 142 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 142")
end
description.set_pre_eof_action_used (True)
else
--|#line 143 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 143")
end
description.set_pre_eof_action_used (False)
end
else
if yy_act = 48 then
--|#line 144 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 144")
end
description.set_post_eof_action_used (True)
else
--|#line 145 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 145")
end
description.set_post_eof_action_used (False)
end
end
else
if yy_act <= 51 then
if yy_act = 50 then
--|#line 146 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 146")
end

					description.set_no_warning (False)
				
else
--|#line 149 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 149")
end

					description.set_no_warning (True)
				
end
else
if yy_act = 52 then
--|#line 153 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 153")
end
set_start_condition (OUTFILE)
else
--|#line 163 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 163")
end

					line_nb := line_nb + 1
					set_start_condition (INITIAL)
				
end
end
end
else
if yy_act <= 57 then
if yy_act <= 55 then
if yy_act = 54 then
--|#line 167 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 167")
end

					report_unrecognized_option_error (text)
					set_start_condition (RECOVER1)
			
else
--|#line 174 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 174")
end

					description.set_output_filename (text_substring (2, text_count - 1))
					set_start_condition (OPTION)
				
end
else
if yy_act = 56 then
--|#line 178 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 178")
end

					description.set_output_filename (Void)
					report_missing_quote_error
					set_start_condition (RECOVER1)
				
else
--|#line 186 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 186")
end
-- Separates name and definition.
end
end
else
if yy_act <= 59 then
if yy_act = 58 then
--|#line 187 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 187")
end

					check last_string_not_void: last_string /= Void end
					process_name_definition (last_string, text)
					set_start_condition (INITIAL)
				
else
--|#line 192 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 192")
end

					line_nb := line_nb + 1
					report_incomplete_name_definition_error
					set_start_condition (INITIAL)
				
end
else
--|#line 200 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 200")
end

						-- Eat characters to end of line.
					set_start_condition (INITIAL)
				
end
end
end
end
end
else
if yy_act <= 90 then
if yy_act <= 75 then
if yy_act <= 68 then
if yy_act <= 64 then
if yy_act <= 62 then
if yy_act = 61 then
--|#line 204 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 204")
end

						-- Eat characters to end of line.
					line_nb := line_nb + 1
					set_start_condition (INITIAL)
				
else
--|#line 217 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 217")
end
-- Separator or comment.
end
else
if yy_act = 63 then
--|#line 218 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 218")
end
line_nb := line_nb + 1
else
--|#line 219 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 219")
end

					last_token := ENDSECT
					set_start_condition (SECT3)
				
end
end
else
if yy_act <= 66 then
if yy_act = 65 then
--|#line 223 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 223")
end

					last_token := Caret_code
						-- The line number is set when creating the rule,
						-- but it often gets the wrong number because
						-- it is done after the corresponding action has
						-- be scanned.
					rule_line_nb := line_nb
					set_start_condition (REGEXP)
				
else
--|#line 232 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 232")
end
last_token := Left_brace_code
end
else
if yy_act = 67 then
--|#line 233 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 233")
end
last_token := Right_brace_code
else
--|#line 234 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 234")
end

					last_token := Less_than_code
					set_start_condition (SCOND)
				
end
end
end
else
if yy_act <= 72 then
if yy_act <= 70 then
if yy_act = 69 then
--|#line 238 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 238")
end

					less (0)
						-- The line number is set when creating the rule,
						-- but it often gets the wrong number because
						-- it is done after the corresponding action has
						-- be scanned.
					rule_line_nb := line_nb
					set_start_condition (REGEXP)
				
else
--|#line 250 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 250")
end

					last_token := Double_quote_code
					set_start_condition (QUOTE)
				
end
else
if yy_act = 71 then
	yy_end := yy_end - 1
--|#line 254 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 254")
end
last_token := Dollar_code
else
--|#line 255 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 255")
end

					last_string := text.as_lower
					if name_definitions.has (last_string) then
						put_back_string (name_definitions.item (last_string))
					else
						report_undefined_definition_error (text)
					end
				
end
end
else
if yy_act <= 74 then
if yy_act = 73 then
--|#line 263 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 263")
end

					last_token := Left_brace_code
					set_start_condition (NUM)
				
else
--|#line 267 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 267")
end

					last_string := text
					if character_classes.has (last_string) then
						last_token := CCL_OP
						last_lx_symbol_class_value := character_classes.item (last_string)
					else
						last_token := Left_bracket_code
						last_string_value := last_string
						less (1)
						set_start_condition (FIRSTCCL)
					end
				
end
else
--|#line 279 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 279")
end

					report_bad_character_class_error
					last_token := CHAR
					process_character (text_item (1).code)
				
end
end
end
else
if yy_act <= 83 then
if yy_act <= 79 then
if yy_act <= 77 then
if yy_act = 76 then
--|#line 284 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 284")
end
last_token := EOF_OP
else
--|#line 285 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 285")
end
last_token := text_item (1).code
end
else
if yy_act = 78 then
--|#line 286 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 286")
end

					set_start_condition (ACTION_TEXT)
				
else
--|#line 289 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 289")
end

					line_nb := line_nb + 1
					last_token := EMPTY
					set_start_condition (SECT2)
				
end
end
else
if yy_act <= 81 then
if yy_act = 80 then
--|#line 294 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 294")
end

					last_token := CHAR
					process_character (text_item (1).code)
				
else
--|#line 301 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 301")
end
-- Separator or comment.
end
else
if yy_act = 82 then
--|#line 302 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 302")
end
line_nb := line_nb + 1
else
--|#line 303 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 303")
end
last_token := Comma_code
end
end
end
else
if yy_act <= 87 then
if yy_act <= 85 then
if yy_act = 84 then
--|#line 304 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 304")
end
last_token := Star_code
else
--|#line 305 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 305")
end

					last_token := Greater_than_code
					set_start_condition (SECT2)
				
end
else
if yy_act = 86 then
--|#line 309 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 309")
end

					last_token := NAME
					last_string_value := text
				
else
--|#line 313 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 313")
end

					report_bad_start_condition_error (text)
				
end
end
else
if yy_act <= 89 then
if yy_act = 88 then
--|#line 319 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 319")
end
-- Separator.
else
--|#line 320 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 320")
end

					if text.is_integer then
						last_token := NUMBER
						last_integer_value := text.to_integer
					else
						report_integer_too_large_error (text)
					end
				
end
else
--|#line 328 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 328")
end
last_token := Comma_code
end
end
end
end
else
if yy_act <= 105 then
if yy_act <= 98 then
if yy_act <= 94 then
if yy_act <= 92 then
if yy_act = 91 then
--|#line 329 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 329")
end

					last_token := Right_brace_code
					set_start_condition (REGEXP)
				
else
--|#line 333 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 333")
end

					report_bad_character_in_brackets_error
					last_token := Right_brace_code
					set_start_condition (REGEXP)
				
end
else
if yy_act = 93 then
--|#line 338 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 338")
end

					report_missing_bracket_error
					line_nb := line_nb + 1
					last_token := Right_brace_code
					set_start_condition (REGEXP)
				
else
--|#line 347 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 347")
end

					process_character (text_item (1).code)
					last_token := CHAR
				
end
end
else
if yy_act <= 96 then
if yy_act = 95 then
--|#line 351 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 351")
end

					last_token := Double_quote_code
					set_start_condition (REGEXP)
				
else
--|#line 355 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 355")
end

					report_missing_quote_error
					line_nb := line_nb + 1
					last_token := Double_quote_code
					set_start_condition (REGEXP)
				
end
else
if yy_act = 97 then
--|#line 363 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 363")
end

					last_token := CHAR
					process_escaped_character
					if start_condition = FIRSTCCL then
						set_start_condition (CCL)
					end
				
else
	yy_end := yy_end - 1
--|#line 372 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 372")
end

					set_start_condition (CCL)
					last_token := Caret_code
				
end
end
end
else
if yy_act <= 102 then
if yy_act <= 100 then
if yy_act = 99 then
	yy_end := yy_end - 1
--|#line 376 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 376")
end
last_token := Caret_code
else
--|#line 377 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 377")
end

					last_token := CHAR
					process_character (text_item (1).code)
					set_start_condition (CCL)
				
end
else
if yy_act = 101 then
--|#line 382 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 382")
end

					report_bad_character_class_error
					line_nb := line_nb + 1
					last_token := Right_bracket_code
					set_start_condition (REGEXP)
				
else
	yy_end := yy_end - 1
--|#line 391 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 391")
end
last_token := Minus_code
end
end
else
if yy_act <= 104 then
if yy_act = 103 then
--|#line 392 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 392")
end

					last_token := CHAR
					process_character (text_item (1).code)
				
else
--|#line 396 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 396")
end

					last_token := Right_bracket_code
					set_start_condition (REGEXP)
				
end
else
--|#line 400 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 400")
end

					report_bad_character_class_error
					line_nb := line_nb + 1
					last_token := Right_bracket_code
					set_start_condition (REGEXP)
				
end
end
end
else
if yy_act <= 112 then
if yy_act <= 109 then
if yy_act <= 107 then
if yy_act = 106 then
--|#line 409 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 409")
end

					last_token := PIPED
					set_start_condition (SECT2)
				
else
--|#line 413 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 413")
end

					last_token := EMPTY
					line_nb := line_nb + 1
					set_start_condition (SECT2)
				
end
else
if yy_act = 108 then
--|#line 418 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 418")
end
set_start_condition (EIFFEL_BLOCK2)
else
--|#line 419 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 419")
end

					last_token := EIF_CODE
					last_string_value := text
					set_start_condition (SECT2)
				
end
end
else
if yy_act <= 111 then
if yy_act = 110 then
--|#line 427 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 427")
end
more
else
--|#line 428 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 428")
end
more
end
else
--|#line 429 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 429")
end
more
end
end
else
if yy_act <= 116 then
if yy_act <= 114 then
if yy_act = 113 then
--|#line 430 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 430")
end
more
else
--|#line 431 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 431")
end
more
end
else
if yy_act = 115 then
--|#line 432 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 432")
end

					nb_open_brackets := nb_open_brackets + 1
					more
				
else
--|#line 436 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 436")
end

					if nb_open_brackets = 0 then
						last_token := EIF_CODE
						last_string := text_substring (1, text_count - 1)
						line_nb := line_nb + last_string.occurrences ('%N')
						last_string_value := last_string
						set_start_condition (SECT2)
					else
						nb_open_brackets := nb_open_brackets - 1
						more
					end
				
end
end
else
if yy_act <= 118 then
if yy_act = 117 then
--|#line 454 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 454")
end

					last_token := EIF_CODE
					last_string_value := text
				
else
--|#line 459 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 459")
end

					if text_item (1) = '%N' then
						report_bad_character_error ("%%N")
						line_nb := line_nb + 1
					else
						report_bad_character_error (text)
					end
				
end
else
--|#line 0 "lx_lex_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_lex_scanner.l' at line 0")
end
last_token := yyError_token
fatal_error ("scanner jammed")
end
end
end
end
end
end
			yy_set_beginning_of_line
		end

	yy_execute_eof_action (yy_sc: INTEGER)
			-- Execute EOF semantic action.
		do
			terminate
		end

feature {NONE} -- Table templates

	yy_nxt_template: SPECIAL [INTEGER]
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 1702)
			yy_nxt_template_1 (an_array)
			yy_nxt_template_2 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_nxt_template_1 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			    0,  470,   39,   40,   39,  120,  120,  121,  121,  138,
			  470,  138,   41,   38,   39,   40,   39,   38,   38,   42,
			   38,   38,   38,   38,   41,   38,   38,   38,   38,   38,
			   38,   43,   43,   43,   43,   43,   43,   43,   43,   43,
			   43,   43,   43,   43,   43,   43,   43,   43,   43,   43,
			   43,   43,   43,   43,   38,   38,   38,   38,   38,   38,
			   38,   38,   45,   46,   45,  147,   55,  147,   56,   57,
			  183,  183,   47,   58,  103,   55,   48,   59,   57,   85,
			   86,   85,   58,  111,   85,   86,   85,   91,   87,   92,
			  103,   88,   88,   87,  185,  185,   88,   88,   91,  155,

			   92,  156,  161,  217,  161,   49,  111,   50,  325,   51,
			   45,   46,   45,  218,  173,   52,  174,  326,  104,  105,
			   47,  186,  186,  112,   48,  113,   89,   93,  179,  224,
			  179,   89,  157,  225,  104,  105,  451,  220,   93,  107,
			  108,  107,  107,  108,  107,  182,  112,  182,  113,  109,
			  183,  183,  109,   49,  187,   50,  187,   51,   60,   61,
			   62,   61,   60,   60,   60,   60,   60,   60,   60,   63,
			   60,   64,   64,   60,   60,   60,   64,   65,   66,   67,
			   68,   69,   64,   64,   64,   64,   64,   70,   71,   72,
			   73,   74,   75,   64,   64,   64,   64,   76,   64,   60,

			   60,   60,   60,   60,   60,   60,   60,   79,   80,   81,
			   80,   79,   79,   79,   79,   79,   79,   79,   82,   79,
			   79,   79,   79,   79,   79,   83,   83,   83,   83,   83,
			   83,   83,   83,   83,   83,   83,   83,   83,   83,   83,
			   83,   83,   83,   83,   83,   83,   83,   83,   79,   79,
			   79,   79,   79,   79,   79,   79,   94,   95,   96,   95,
			   94,   94,   94,   94,   94,   97,   98,   99,   94,   94,
			   94,   94,   94,  100,  101,  101,  101,  101,  101,  101,
			  101,  101,  101,  101,  101,  101,  101,  101,  101,  101,
			  101,  101,  101,  101,  101,  101,  101,   94,   94,   94,

			   94,   94,   94,   94,   94,  115,  193,  115,  193,  196,
			  185,  200,  185,  200,  116,  470,  116,  133,  210,  208,
			  134,  209,  133,  257,  135,  134,  201,  201,  201,  135,
			  138,  470,  138,  470,  470,  469,  140,  186,  147,  186,
			  147,  196,  468,  150,  150,  117,  118,  117,  118,  123,
			  124,  123,  125,  126,  467,  470,  127,  127,  213,  136,
			  127,  137,  142,  128,  136,  143,  137,  145,  214,  145,
			  144,  470,  466,  470,  470,  150,  145,  215,  149,  375,
			  155,  151,  156,  151,  161,  179,  161,  179,  376,  129,
			  130,  216,  249,  250,  131,  127,  123,  124,  123,  125,

			  126,  251,  289,  127,  127,  470,  182,  127,  182,  187,
			  128,  187,  193,  200,  193,  200,  208,  254,  209,  262,
			  262,  263,  263,  278,  283,  279,  464,  255,  252,  290,
			  294,  294,  295,  295,  284,  258,  129,  130,  154,  262,
			  262,  131,  127,  221,  221,  470,  221,  221,  221,  221,
			  221,  221,  221,  221,  162,  221,  162,  162,  221,  221,
			  221,  162,  162,  162,  162,  162,  162,  162,  162,  162,
			  162,  162,  162,  162,  162,  162,  162,  162,  162,  162,
			  162,  162,  162,  162,  221,  221,  221,  221,  221,  221,
			  221,  221,  230,  231,  232,  233,  234,  205,  205,  249,

			  250,  291,  235,  236,  470,  465,  237,  238,  157,  263,
			  263,  304,  239,  317,  464,  305,  321,  318,  249,  250,
			  207,  294,  294,  463,  296,  210,  295,  295,  470,  205,
			  249,  250,  253,  292,  292,  249,  250,  336,  292,  292,
			  292,  292,  292,  292,  470,  249,  250,  337,  343,  249,
			  250,  470,  344,  361,  323,  470,  380,  362,  462,  461,
			  381,  460,  249,  250,  322,  322,  459,  458,  470,  322,
			  322,  322,  322,  322,  322,  457,  349,  150,  150,  150,
			  150,  150,  150,  150,  205,  205,  205,  205,  205,  205,
			  205,  470,  246,  246,  246,  470,   38,   38,   38,   38,

			   38,   38,   38,   38,   38,   38,   38,   38,   38,   38,
			   38,   38,   38,   38,   38,   38,   44,   44,   44,   44,
			   44,   44,   44,   44,   44,   44,   44,   44,   44,   44,
			   44,   44,   44,   44,   44,   44,   53,   53,   53,   53,
			   53,   53,   53,   53,   53,   53,   53,   53,   53,   53,
			   53,   53,   53,   53,   53,   53,   54,   54,   54,   54,
			   54,   54,   54,   54,   54,   54,   54,   54,   54,   54,
			   54,   54,   54,   54,   54,   54,   77,   77,   77,   77,
			   77,   77,   77,   77,   77,   77,   77,   77,   77,   77,
			   77,   77,   77,   77,   77,   77,   84,   84,   84,   84,

			   84,   84,   84,   84,   84,   84,   84,   84,   84,   84,
			   84,   84,   84,   84,   84,   84,   90,   90,   90,   90,
			   90,   90,   90,   90,   90,   90,   90,   90,   90,   90,
			   90,   90,   90,   90,   90,   90,  102,  102,  102,  102,
			  102,  102,  102,  102,  102,  102,  102,  102,  102,  102,
			  102,  102,  102,  102,  102,  102,  106,  106,  106,  106,
			  106,  106,  106,  106,  106,  106,  106,  106,  106,  106,
			  106,  106,  106,  106,  106,  106,  110,  110,  110,  110,
			  110,  110,  110,  110,  110,  110,  110,  110,  110,  110,
			  110,  110,  110,  110,  110,  110,  114,  114,  114,  114,

			  114,  114,  114,  114,  114,  114,  114,  114,  114,  114,
			  114,  114,  114,  114,  114,  114,  119,  119,  119,  119,
			  119,  119,  119,  119,  119,  119,  119,  119,  119,  119,
			  119,  119,  119,  119,  119,  119,  122,  122,  122,  122,
			  122,  122,  122,  122,  122,  122,  122,  122,  122,  122,
			  122,  122,  122,  122,  122,  122,  132,  132,  132,  132,
			  132,  132,  132,  132,  132,  132,  132,  132,  132,  132,
			  132,  132,  132,  132,  132,  132,  141,  184,  184,  184,
			  456,  141,  141,  141,  141,  141,  141,  141,  455,  454,
			  141,  146,  146,  146,  146,  146,  146,  146,  146,  146,

			  453,  146,  152,  152,  152,  152,  152,  152,  152,  152,
			  152,  152,  152,  152,  152,  152,  152,  152,  152,  152,
			  152,  152,  153,  153,  153,  452,  451,  450,  449,  153,
			  153,  153,  153,  153,  153,  153,  153,  153,  153,  153,
			  153,  153,  154,  448,  154,  154,  154,  154,  154,  154,
			  154,  154,  154,  154,  154,  154,  154,  154,  154,  154,
			  154,  154,  157,  447,  157,  157,  157,  446,  157,  157,
			  157,  157,  157,  157,  157,  157,  157,  157,  157,  157,
			  157,  157,  163,  163,  163,  163,  163,  163,  163,  163,
			  163,  163,  177,  177,  177,  177,  177,  177,  177,  177, yy_Dummy>>,
			1, 1000, 0)
		end

	yy_nxt_template_2 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  177,  177,  177,  177,  177,  177,  177,  177,  177,  177,
			  177,  177,  181,  181,  181,  181,  181,  181,  181,  181,
			  181,  445,  181,  184,  444,  184,  184,  184,  184,  184,
			  184,  184,  184,  184,  184,  184,  184,  184,  184,  184,
			  184,  184,  184,  189,  189,  189,  189,  189,  189,  189,
			  189,  189,  443,  189,  190,  442,  190,  190,  190,  190,
			  190,  190,  190,  190,  190,  190,  190,  190,  190,  190,
			  190,  190,  190,  190,  191,  441,  191,  191,  191,  191,
			  191,  191,  191,  191,  191,  191,  191,  191,  191,  191,
			  191,  191,  191,  191,  192,  440,  439,  192,  192,  192,

			  192,  192,  192,  192,  192,  192,  192,  192,  192,  192,
			  192,  192,  192,  192,  195,  195,  195,  195,  195,  195,
			  195,  195,  195,  195,  195,  195,  195,  195,  195,  195,
			  195,  195,  195,  195,  197,  197,  197,  197,  197,  197,
			  197,  197,  197,  197,  197,  197,  197,  197,  197,  197,
			  438,  197,  197,  197,  198,  437,  198,  198,  198,  198,
			  198,  198,  198,  198,  198,  198,  198,  198,  198,  198,
			  198,  198,  198,  198,  203,  436,  203,  203,  203,  203,
			  203,  203,  203,  203,  203,  203,  203,  203,  203,  203,
			  203,  203,  203,  203,  206,  206,  206,  435,  206,  434,

			  433,  206,  206,  206,  206,  206,  206,  206,  206,  206,
			  206,  206,  207,  432,  207,  207,  207,  207,  207,  207,
			  207,  207,  207,  207,  207,  207,  207,  207,  207,  207,
			  207,  207,  210,  431,  210,  210,  210,  430,  210,  210,
			  210,  210,  210,  210,  210,  210,  210,  210,  210,  210,
			  210,  210,  139,  429,  139,  139,  139,  139,  139,  139,
			  139,  139,  139,  139,  139,  139,  139,  139,  139,  139,
			  139,  139,  148,  428,  148,  148,  148,  148,  148,  148,
			  148,  148,  148,  148,  148,  148,  148,  148,  148,  148,
			  148,  148,  159,  427,  159,  159,  159,  159,  159,  159,

			  159,  159,  159,  159,  159,  159,  159,  159,  159,  159,
			  159,  159,  180,  426,  180,  180,  180,  180,  180,  180,
			  180,  180,  180,  180,  180,  180,  180,  180,  180,  180,
			  180,  180,  188,  425,  188,  188,  188,  188,  188,  188,
			  188,  188,  188,  188,  188,  188,  188,  188,  188,  188,
			  188,  188,  194,  424,  194,  194,  194,  194,  194,  194,
			  194,  194,  194,  194,  194,  194,  194,  194,  194,  194,
			  194,  194,  212,  423,  212,  212,  212,  212,  212,  212,
			  212,  212,  212,  212,  212,  212,  212,  212,  212,  212,
			  212,  212,  221,  422,  221,  221,  221,  221,  221,  221,

			  221,  221,  221,  221,  221,  221,  221,  221,  221,  221,
			  221,  221,  247,  421,  247,  247,  247,  247,  247,  247,
			  247,  247,  247,  247,  247,  247,  247,  247,  247,  247,
			  247,  247,  259,  259,  259,  259,  259,  259,  259,  259,
			  259,  259,  259,  259,  259,  259,  259,  259,  259,  259,
			  259,  259,  260,  420,  260,  260,  260,  260,  260,  260,
			  260,  260,  260,  260,  260,  260,  260,  260,  260,  260,
			  260,  260,  419,  418,  417,  416,  415,  414,  413,  412,
			  411,  410,  409,  408,  407,  406,  405,  404,  403,  402,
			  401,  400,  399,  398,  397,  396,  395,  394,  393,  392,

			  391,  390,  389,  388,  387,  386,  385,  384,  383,  382,
			  379,  378,  377,  374,  373,  372,  371,  370,  369,  368,
			  367,  366,  365,  364,  363,  360,  359,  358,  357,  356,
			  355,  354,  353,  352,  351,  350,  348,  347,  346,  345,
			  342,  341,  340,  339,  338,  335,  334,  333,  332,  331,
			  330,  329,  328,  327,  324,  207,  320,  319,  316,  315,
			  314,  313,  312,  311,  310,  309,  308,  307,  306,  303,
			  302,  301,  300,  299,  298,  297,  154,  214,  293,  288,
			  184,  287,  286,  285,  282,  281,  280,  277,  276,  275,
			  274,  273,  272,  271,  270,  269,  268,  267,  266,  265,

			  264,  261,  260,  259,  256,  248,  199,  247,  245,  178,
			  244,  243,  242,  241,  240,  229,  228,  227,  226,  223,
			  222,  219,  212,  211,  204,  202,  199,  194,  188,  180,
			  178,  176,  175,  172,  171,  170,  169,  168,  167,  166,
			  165,  164,  162,  160,  159,  158,  151,  149,  148,  139,
			  470,   78,   78,   37,  470,  470,  470,  470,  470,  470,
			  470,  470,  470,  470,  470,  470,  470,  470,  470,  470,
			  470,  470,  470,  470,  470,  470,  470,  470,  470,  470,
			  470,  470,  470,  470,  470,  470,  470,  470,  470,  470,
			  470,  470,  470,  470,  470,  470,  470,  470,  470,  470,

			  470,  470,  470, yy_Dummy>>,
			1, 703, 1000)
		end

	yy_chk_template: SPECIAL [INTEGER]
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 1702)
			yy_chk_template_1 (an_array)
			yy_chk_template_2 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_chk_template_1 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			    0,    0,    1,    1,    1,   31,   32,   31,   32,   39,
			    0,   39,    1,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    3,    3,    3,   45,    7,   45,    7,    7,
			   88,   88,    3,    7,   23,    8,    3,    8,    8,   17,
			   17,   17,    8,   27,   18,   18,   18,   19,   17,   19,
			   24,   17,   17,   18,   93,  112,   18,   18,   20,   55,

			   20,   55,   61,  156,   61,    3,   28,    3,  298,    3,
			    4,    4,    4,  156,   74,    4,   74,  298,   23,   23,
			    4,   93,  112,   27,    4,   27,   17,   19,   80,  166,
			   80,   18,  158,  166,   24,   24,  468,  158,   20,   25,
			   25,   25,   26,   26,   26,   85,   28,   85,   28,   25,
			  183,  183,   26,    4,   95,    4,   95,    4,    9,    9,
			    9,    9,    9,    9,    9,    9,    9,    9,    9,    9,
			    9,    9,    9,    9,    9,    9,    9,    9,    9,    9,
			    9,    9,    9,    9,    9,    9,    9,    9,    9,    9,
			    9,    9,    9,    9,    9,    9,    9,    9,    9,    9,

			    9,    9,    9,    9,    9,    9,    9,   13,   13,   13,
			   13,   13,   13,   13,   13,   13,   13,   13,   13,   13,
			   13,   13,   13,   13,   13,   13,   13,   13,   13,   13,
			   13,   13,   13,   13,   13,   13,   13,   13,   13,   13,
			   13,   13,   13,   13,   13,   13,   13,   13,   13,   13,
			   13,   13,   13,   13,   13,   13,   21,   21,   21,   21,
			   21,   21,   21,   21,   21,   21,   21,   21,   21,   21,
			   21,   21,   21,   21,   21,   21,   21,   21,   21,   21,
			   21,   21,   21,   21,   21,   21,   21,   21,   21,   21,
			   21,   21,   21,   21,   21,   21,   21,   21,   21,   21,

			   21,   21,   21,   21,   21,   29,  107,   30,  107,  113,
			  117,  123,  130,  123,   29,  141,   30,   35,  211,  133,
			   35,  133,   36,  211,   35,   36,  126,  126,  126,   36,
			  138,  142,  138,  143,  144,  466,   42,  117,  147,  130,
			  147,  113,  465,  150,  150,   29,   29,   30,   30,   33,
			   33,   33,   33,   33,  462,  141,   33,   33,  142,   35,
			   33,   35,   42,   33,   36,   42,   36,  145,  145,  145,
			   42,  142,  461,  143,  144,  150,   42,  145,  150,  355,
			  154,  151,  154,  151,  161,  179,  161,  179,  355,   33,
			   33,  151,  203,  203,   33,   33,   34,   34,   34,   34,

			   34,  204,  249,   34,   34,  213,  182,   34,  182,  187,
			   34,  187,  193,  200,  193,  200,  207,  209,  207,  218,
			  218,  220,  220,  237,  241,  237,  460,  209,  204,  249,
			  255,  255,  257,  257,  241,  213,   34,   34,  262,  262,
			  262,   34,   34,  162,  162,  213,  162,  162,  162,  162,
			  162,  162,  162,  162,  162,  162,  162,  162,  162,  162,
			  162,  162,  162,  162,  162,  162,  162,  162,  162,  162,
			  162,  162,  162,  162,  162,  162,  162,  162,  162,  162,
			  162,  162,  162,  162,  162,  162,  162,  162,  162,  162,
			  162,  162,  171,  171,  171,  171,  171,  205,  205,  291,

			  291,  251,  171,  171,  258,  459,  171,  171,  263,  263,
			  263,  273,  171,  285,  458,  273,  289,  285,  292,  292,
			  294,  294,  294,  456,  258,  295,  295,  295,  296,  205,
			  251,  251,  205,  252,  252,  321,  321,  310,  252,  252,
			  252,  252,  252,  252,  258,  289,  289,  310,  316,  322,
			  322,  323,  316,  338,  296,  349,  360,  338,  455,  454,
			  360,  453,  252,  252,  290,  290,  452,  450,  296,  290,
			  290,  290,  290,  290,  290,  449,  323,  487,  487,  487,
			  487,  487,  487,  487,  504,  504,  504,  504,  504,  504,
			  504,  323,  512,  512,  512,  349,  471,  471,  471,  471,

			  471,  471,  471,  471,  471,  471,  471,  471,  471,  471,
			  471,  471,  471,  471,  471,  471,  472,  472,  472,  472,
			  472,  472,  472,  472,  472,  472,  472,  472,  472,  472,
			  472,  472,  472,  472,  472,  472,  473,  473,  473,  473,
			  473,  473,  473,  473,  473,  473,  473,  473,  473,  473,
			  473,  473,  473,  473,  473,  473,  474,  474,  474,  474,
			  474,  474,  474,  474,  474,  474,  474,  474,  474,  474,
			  474,  474,  474,  474,  474,  474,  475,  475,  475,  475,
			  475,  475,  475,  475,  475,  475,  475,  475,  475,  475,
			  475,  475,  475,  475,  475,  475,  476,  476,  476,  476,

			  476,  476,  476,  476,  476,  476,  476,  476,  476,  476,
			  476,  476,  476,  476,  476,  476,  477,  477,  477,  477,
			  477,  477,  477,  477,  477,  477,  477,  477,  477,  477,
			  477,  477,  477,  477,  477,  477,  478,  478,  478,  478,
			  478,  478,  478,  478,  478,  478,  478,  478,  478,  478,
			  478,  478,  478,  478,  478,  478,  479,  479,  479,  479,
			  479,  479,  479,  479,  479,  479,  479,  479,  479,  479,
			  479,  479,  479,  479,  479,  479,  480,  480,  480,  480,
			  480,  480,  480,  480,  480,  480,  480,  480,  480,  480,
			  480,  480,  480,  480,  480,  480,  481,  481,  481,  481,

			  481,  481,  481,  481,  481,  481,  481,  481,  481,  481,
			  481,  481,  481,  481,  481,  481,  482,  482,  482,  482,
			  482,  482,  482,  482,  482,  482,  482,  482,  482,  482,
			  482,  482,  482,  482,  482,  482,  483,  483,  483,  483,
			  483,  483,  483,  483,  483,  483,  483,  483,  483,  483,
			  483,  483,  483,  483,  483,  483,  484,  484,  484,  484,
			  484,  484,  484,  484,  484,  484,  484,  484,  484,  484,
			  484,  484,  484,  484,  484,  484,  485,  517,  517,  517,
			  448,  485,  485,  485,  485,  485,  485,  485,  447,  446,
			  485,  486,  486,  486,  486,  486,  486,  486,  486,  486,

			  444,  486,  488,  488,  488,  488,  488,  488,  488,  488,
			  488,  488,  488,  488,  488,  488,  488,  488,  488,  488,
			  488,  488,  489,  489,  489,  443,  442,  441,  440,  489,
			  489,  489,  489,  489,  489,  489,  489,  489,  489,  489,
			  489,  489,  490,  439,  490,  490,  490,  490,  490,  490,
			  490,  490,  490,  490,  490,  490,  490,  490,  490,  490,
			  490,  490,  491,  438,  491,  491,  491,  436,  491,  491,
			  491,  491,  491,  491,  491,  491,  491,  491,  491,  491,
			  491,  491,  492,  492,  492,  492,  492,  492,  492,  492,
			  492,  492,  493,  493,  493,  493,  493,  493,  493,  493, yy_Dummy>>,
			1, 1000, 0)
		end

	yy_chk_template_2 (an_array: ARRAY [INTEGER])
		do
			yy_array_subcopy (an_array, <<
			  493,  493,  493,  493,  493,  493,  493,  493,  493,  493,
			  493,  493,  494,  494,  494,  494,  494,  494,  494,  494,
			  494,  435,  494,  495,  434,  495,  495,  495,  495,  495,
			  495,  495,  495,  495,  495,  495,  495,  495,  495,  495,
			  495,  495,  495,  496,  496,  496,  496,  496,  496,  496,
			  496,  496,  433,  496,  497,  432,  497,  497,  497,  497,
			  497,  497,  497,  497,  497,  497,  497,  497,  497,  497,
			  497,  497,  497,  497,  498,  431,  498,  498,  498,  498,
			  498,  498,  498,  498,  498,  498,  498,  498,  498,  498,
			  498,  498,  498,  498,  499,  430,  429,  499,  499,  499,

			  499,  499,  499,  499,  499,  499,  499,  499,  499,  499,
			  499,  499,  499,  499,  500,  500,  500,  500,  500,  500,
			  500,  500,  500,  500,  500,  500,  500,  500,  500,  500,
			  500,  500,  500,  500,  501,  501,  501,  501,  501,  501,
			  501,  501,  501,  501,  501,  501,  501,  501,  501,  501,
			  427,  501,  501,  501,  502,  426,  502,  502,  502,  502,
			  502,  502,  502,  502,  502,  502,  502,  502,  502,  502,
			  502,  502,  502,  502,  503,  425,  503,  503,  503,  503,
			  503,  503,  503,  503,  503,  503,  503,  503,  503,  503,
			  503,  503,  503,  503,  505,  505,  505,  424,  505,  423,

			  422,  505,  505,  505,  505,  505,  505,  505,  505,  505,
			  505,  505,  506,  421,  506,  506,  506,  506,  506,  506,
			  506,  506,  506,  506,  506,  506,  506,  506,  506,  506,
			  506,  506,  507,  420,  507,  507,  507,  419,  507,  507,
			  507,  507,  507,  507,  507,  507,  507,  507,  507,  507,
			  507,  507,  508,  417,  508,  508,  508,  508,  508,  508,
			  508,  508,  508,  508,  508,  508,  508,  508,  508,  508,
			  508,  508,  509,  416,  509,  509,  509,  509,  509,  509,
			  509,  509,  509,  509,  509,  509,  509,  509,  509,  509,
			  509,  509,  510,  415,  510,  510,  510,  510,  510,  510,

			  510,  510,  510,  510,  510,  510,  510,  510,  510,  510,
			  510,  510,  511,  414,  511,  511,  511,  511,  511,  511,
			  511,  511,  511,  511,  511,  511,  511,  511,  511,  511,
			  511,  511,  513,  413,  513,  513,  513,  513,  513,  513,
			  513,  513,  513,  513,  513,  513,  513,  513,  513,  513,
			  513,  513,  514,  412,  514,  514,  514,  514,  514,  514,
			  514,  514,  514,  514,  514,  514,  514,  514,  514,  514,
			  514,  514,  515,  409,  515,  515,  515,  515,  515,  515,
			  515,  515,  515,  515,  515,  515,  515,  515,  515,  515,
			  515,  515,  516,  408,  516,  516,  516,  516,  516,  516,

			  516,  516,  516,  516,  516,  516,  516,  516,  516,  516,
			  516,  516,  518,  407,  518,  518,  518,  518,  518,  518,
			  518,  518,  518,  518,  518,  518,  518,  518,  518,  518,
			  518,  518,  519,  519,  519,  519,  519,  519,  519,  519,
			  519,  519,  519,  519,  519,  519,  519,  519,  519,  519,
			  519,  519,  520,  406,  520,  520,  520,  520,  520,  520,
			  520,  520,  520,  520,  520,  520,  520,  520,  520,  520,
			  520,  520,  405,  404,  403,  402,  401,  400,  399,  398,
			  397,  396,  394,  393,  392,  391,  390,  389,  388,  387,
			  383,  382,  381,  380,  379,  378,  377,  376,  375,  372,

			  371,  369,  368,  367,  366,  365,  364,  363,  362,  361,
			  359,  358,  357,  354,  353,  351,  350,  348,  346,  345,
			  344,  343,  342,  341,  339,  337,  336,  335,  332,  331,
			  330,  329,  328,  327,  326,  325,  320,  319,  318,  317,
			  315,  314,  313,  312,  311,  309,  308,  307,  305,  304,
			  303,  302,  301,  300,  297,  293,  288,  286,  284,  283,
			  282,  281,  280,  279,  278,  277,  276,  275,  274,  272,
			  271,  270,  267,  266,  265,  264,  261,  259,  254,  248,
			  245,  244,  243,  242,  240,  239,  238,  236,  235,  234,
			  233,  232,  231,  230,  229,  228,  227,  225,  224,  223,

			  222,  217,  216,  215,  210,  202,  198,  194,  185,  177,
			  176,  175,  174,  173,  172,  170,  169,  168,  167,  165,
			  164,  157,  135,  134,  129,  128,  121,  109,   99,   82,
			   77,   76,   75,   73,   72,   71,   70,   69,   68,   67,
			   66,   65,   63,   59,   58,   57,   52,   48,   47,   41,
			   37,   12,   11,  470,  470,  470,  470,  470,  470,  470,
			  470,  470,  470,  470,  470,  470,  470,  470,  470,  470,
			  470,  470,  470,  470,  470,  470,  470,  470,  470,  470,
			  470,  470,  470,  470,  470,  470,  470,  470,  470,  470,
			  470,  470,  470,  470,  470,  470,  470,  470,  470,  470,

			  470,  470,  470, yy_Dummy>>,
			1, 703, 1000)
		end

	yy_base_template: SPECIAL [INTEGER]
		once
			Result := yy_fixed_array (<<
			    0,    0,   12,   60,  108,    0,    0,   61,   70,  157,
			    0, 1649, 1648,  206,    0,    0,    0,   77,   82,   84,
			   95,  255,    0,   71,   87,  137,  140,   80,  103,  302,
			  304,    2,    3,  347,  394,  312,  317, 1650, 1653,    7,
			 1653, 1637,  329,    0, 1653,   63, 1653, 1636, 1631, 1653,
			    0, 1653, 1639,    0,    0,   94, 1653, 1638, 1632, 1594,
			 1653,  100, 1653, 1630,    0, 1622, 1621, 1616, 1617, 1599,
			 1609, 1612, 1601, 1595,   81, 1609, 1612, 1627, 1653, 1653,
			  126, 1653, 1617,    0, 1653,  143, 1653, 1653,   56, 1653,
			 1653, 1653, 1653,   80, 1653,  152, 1653, 1653, 1653, 1616,

			 1653,    0,    0, 1653, 1653,    0,    0,  304, 1653, 1615,
			 1653, 1653,   81,  297, 1653, 1653,    0,  296, 1653, 1653,
			 1653, 1621, 1653,  309, 1653, 1653,  324, 1653, 1609, 1581,
			  298,    0,    0,  314, 1616, 1610, 1653, 1653,  328,    0,
			 1653,  308,  324,  326,  327,  365,    0,  336,    0, 1653,
			  329,  379,    0,    0,  375, 1653,  100, 1613,  124,    0,
			 1653,  382,  442,    0, 1599, 1583,  109, 1582, 1587, 1584,
			 1578,  472, 1577, 1577, 1589, 1583, 1575, 1606, 1653,  383,
			    0,    0,  404,  136, 1653, 1594,    0,  407,    0,    0,
			    0,    0,    0,  410, 1603, 1653, 1653, 1653, 1601, 1653,

			  411, 1653, 1582,  349,  387,  483,    0,  411, 1653,  414,
			 1596,  310,    0,  398, 1653, 1591, 1590, 1599,  405, 1653,
			  407,    0, 1571, 1576, 1560, 1578,    0, 1566, 1572, 1575,
			 1574, 1573, 1568, 1569, 1551, 1561, 1564,  390, 1563, 1566,
			 1560,  397, 1571, 1559, 1549, 1566,    0,    0, 1546,  388,
			 1653,  487,  519, 1653, 1576,  416, 1653,  418,  497, 1574,
			    0, 1569,  425,  495, 1537, 1562, 1548, 1534,    0,    0,
			 1559, 1549, 1533,  491, 1532, 1537, 1534, 1528, 1528, 1540,
			 1534, 1526, 1533, 1522, 1546,  494, 1536,    0, 1532,  502,
			  550,  456,  475, 1548,  507,  512,  521, 1520,   81,    0,

			 1523, 1529, 1522, 1527, 1511, 1529,    0, 1517, 1523, 1526,
			  510, 1532, 1520, 1510, 1511, 1513,  529, 1518, 1505, 1500,
			 1518,  492,  506,  544,    0, 1503, 1511, 1496, 1511, 1493,
			 1518, 1504, 1490,    0,    0, 1515, 1489, 1513,  534, 1503,
			    0, 1500, 1489, 1500, 1487, 1482, 1494,    0, 1499,  548,
			 1480, 1483,    0, 1478, 1479,  352,    0, 1482, 1488, 1483,
			  537, 1488, 1475, 1470, 1489, 1473, 1467, 1479, 1475, 1489,
			 1653, 1477, 1463,    0,    0, 1466, 1474, 1459, 1474, 1461,
			 1472, 1459, 1454, 1466,    0, 1653,    0, 1462, 1476, 1454,
			 1467, 1453, 1457, 1447, 1450,    0, 1445, 1448, 1442, 1454,

			 1450, 1464, 1442, 1455, 1441, 1451, 1417, 1376, 1370, 1337,
			    0,    0, 1326, 1321, 1280, 1274, 1241, 1232,    0, 1200,
			 1206, 1186, 1168, 1172, 1164, 1156, 1123, 1129,    0, 1059,
			 1068, 1038, 1016, 1016,  987,  989,  946,    0,  926,  916,
			  895,  900,  903,  898,  873,    0,  852,  861,  847,  543,
			  528,    0,  529,  522,  532,  525,  491,    0,  491,  478,
			  403,  339,  322,    0,    0,  303,  303,    0,  113,    0,
			 1653,  595,  615,  635,  655,  675,  695,  715,  735,  755,
			  775,  795,  815,  835,  855,  871,  883,  567,  901,  921,
			  941,  961,  975,  991, 1004, 1022, 1035, 1053, 1073, 1093,

			 1113, 1133, 1153, 1173,  574, 1193, 1211, 1231, 1251, 1271,
			 1291, 1311,  584, 1331, 1351, 1371, 1391,  869, 1411, 1431,
			 1451, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER]
		once
			Result := yy_fixed_array (<<
			    0,  471,  470,  472,  472,  473,  473,  474,  474,  470,
			    9,  475,  475,  470,   13,   13,   13,  476,  476,  477,
			  477,  470,   21,  478,  478,  479,  479,  480,  480,  481,
			  481,  482,  482,  483,  483,  484,  484,  470,  470,  470,
			  470,  470,  485,  486,  470,  470,  470,  470,  470,  470,
			  487,  470,  470,  488,  489,  490,  470,  491,  470,  470,
			  470,  470,  470,  492,  492,  492,  492,  492,  492,  492,
			  492,  492,  492,  492,  492,  492,  492,  493,  470,  470,
			  470,  470,  470,  494,  470,  470,  470,  470,  470,  470,
			  470,  470,  470,  495,  470,  470,  470,  470,  470,  470,

			  470,  496,  497,  470,  470,  498,  499,  470,  470,  499,
			  470,  470,  495,  500,  470,  470,  501,  495,  470,  470,
			  470,  502,  470,  470,  470,  470,  470,  470,  470,  503,
			  495,  504,  505,  506,  507,  470,  470,  470,  470,  508,
			  470,  485,  485,  485,  485,  470,  486,  470,  509,  470,
			  487,  470,  488,  489,  490,  470,  490,  470,  491,  510,
			  470,  470,  470,  492,  492,  492,  492,  492,  492,  492,
			  492,  492,  492,  492,  492,  492,  492,  493,  470,  470,
			  511,  494,  470,  470,  470,  470,  512,  470,  513,  496,
			  497,  498,  499,  470,  514,  470,  470,  470,  502,  470,

			  470,  470,  470,  503,  503,  504,  505,  506,  470,  506,
			  470,  507,  515,  485,  470,  470,  470,  470,  470,  470,
			  470,  516,  492,  492,  492,  492,  492,  492,  492,  492,
			  492,  492,  492,  492,  492,  492,  492,  492,  492,  492,
			  492,  492,  492,  492,  492,  470,  517,  518,  470,  503,
			  470,  503,  503,  470,  470,  470,  470,  470,  485,  519,
			  520,  470,  470,  470,  492,  492,  492,  492,  492,  492,
			  492,  492,  492,  492,  492,  492,  492,  492,  492,  492,
			  492,  492,  492,  492,  492,  492,  492,  492,  470,  503,
			  252,  503,  503,  470,  470,  470,  485,  492,  492,  492,

			  492,  492,  492,  492,  492,  492,  492,  492,  492,  492,
			  492,  492,  492,  492,  492,  492,  492,  492,  492,  492,
			  470,  503,  503,  485,  492,  492,  492,  492,  492,  492,
			  492,  492,  492,  492,  492,  492,  492,  492,  492,  492,
			  492,  492,  492,  492,  492,  492,  492,  492,  470,  485,
			  492,  492,  492,  492,  492,  492,  492,  492,  492,  492,
			  492,  492,  492,  492,  492,  492,  492,  492,  492,  492,
			  470,  492,  492,  492,  492,  492,  492,  492,  492,  492,
			  492,  492,  492,  492,  492,  470,  492,  492,  492,  492,
			  492,  492,  492,  492,  492,  492,  492,  492,  492,  492,

			  492,  492,  492,  492,  492,  492,  492,  492,  492,  492,
			  492,  492,  492,  492,  492,  492,  492,  492,  492,  492,
			  492,  492,  492,  492,  492,  492,  492,  492,  492,  492,
			  492,  492,  492,  492,  492,  492,  492,  492,  492,  492,
			  492,  492,  492,  492,  492,  492,  492,  492,  492,  492,
			  492,  492,  492,  492,  492,  492,  492,  492,  492,  492,
			  492,  492,  492,  492,  492,  492,  492,  492,  492,  492,
			    0,  470,  470,  470,  470,  470,  470,  470,  470,  470,
			  470,  470,  470,  470,  470,  470,  470,  470,  470,  470,
			  470,  470,  470,  470,  470,  470,  470,  470,  470,  470,

			  470,  470,  470,  470,  470,  470,  470,  470,  470,  470,
			  470,  470,  470,  470,  470,  470,  470,  470,  470,  470,
			  470, yy_Dummy>>)
		end

	yy_ec_template: SPECIAL [INTEGER]
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    2,
			    3,    1,    1,    4,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    2,    1,    5,    1,    6,    7,    1,    8,
			    9,    9,   10,    9,   11,   12,    9,   13,   14,   14,
			   14,   14,   14,   14,   14,   14,   15,   15,    1,    1,
			   16,   17,   18,    9,    1,   19,   20,   21,   22,   23,
			   24,   25,   26,   27,   28,   29,   30,   31,   32,   33,
			   34,   26,   35,   36,   37,   38,   39,   40,   41,   26,
			   26,   42,   43,   44,   45,   46,    1,   19,   20,   21,

			   22,   23,   24,   25,   26,   27,   28,   29,   30,   31,
			   32,   33,   34,   26,   35,   36,   37,   38,   39,   40,
			   41,   26,   26,   47,   48,   49,    1,    1,    1,    1,
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

	yy_meta_template: SPECIAL [INTEGER]
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    2,    3,    4,    1,    5,    6,    1,
			    1,    1,    7,    1,    8,    9,    1,    1,    1,   10,
			   10,   10,   10,   10,   10,   11,   12,   11,   11,   11,
			   11,   11,   11,   11,   11,   11,   11,   11,   13,   14,
			   15,   16,    1,    1,   17,    1,   18,   19,    1,   20, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER]
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,    0,    0,    0,    0,   11,   11,    0,
			    0,   60,   60,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,  110,  110,  120,   10,    1,
			    2,   10,    9,    7,   69,   62,   63,   69,   68,   65,
			   66,   67,   69,  117,   11,   15,   15,   15,   15,   15,
			   54,   21,   53,   54,   54,   54,   54,   54,   54,   54,
			   54,   54,   54,   54,   54,   54,   54,   60,   61,   20,
			   17,   19,   20,   18,   92,   88,   93,   90,   89,   91,
			   94,   96,   95,   94,   87,   81,   82,   84,   83,   87,

			   85,   86,  109,  107,  108,  106,   58,   57,   59,   58,
			  100,  101,  100,  100,  103,  105,  103,  103,  104,   56,
			  118,   56,   80,   78,   79,   70,   80,   77,   80,   75,
			   80,   73,  110,  114,  114,  114,  115,  116,    1,    1,
			    8,    9,    9,    4,    5,    0,    7,   62,   62,   69,
			    0,   64,  117,   11,    0,   12,    0,    0,    0,   14,
			   16,   21,   21,   54,   54,   54,   54,   54,   54,   54,
			   54,   54,   54,   54,   54,   54,   54,   60,   61,   17,
			   17,   18,   88,   89,   97,   97,   97,   81,   81,   86,
			  109,  106,   58,   57,   57,   98,   99,  102,    0,   55,

			   78,   71,    0,    0,    0,    0,  110,    0,  111,    0,
			    0,    0,  113,    9,    3,    0,    0,    0,    0,   13,
			    0,   21,   54,   54,   54,   54,   30,   54,   54,   54,
			   54,   54,   54,   54,   54,   54,   54,   54,   54,   54,
			   54,   54,   54,   54,   54,   97,   97,   57,    0,    0,
			   74,    0,    0,   72,    0,    0,  112,    0,    9,    0,
			   64,    0,    0,    0,   54,   54,   54,   54,   32,   38,
			   54,   54,   54,   54,   54,   54,   54,   54,   54,   54,
			   54,   54,   54,   54,   54,   54,   54,   50,    0,    0,
			    0,    0,    0,    0,    0,    0,    9,   54,   54,   26,

			   54,   54,   54,   54,   54,   54,   31,   54,   54,   54,
			   54,   54,   54,   54,   54,   54,   54,   54,   54,   54,
			    0,    0,    0,    9,   22,   54,   54,   54,   54,   54,
			   54,   54,   54,   33,   39,   54,   54,   54,   54,   54,
			   51,   54,   54,   54,   54,   54,   54,   36,    0,    6,
			   54,   54,   28,   54,   54,   54,   27,   54,   54,   54,
			   54,   54,   54,   54,   54,   54,   54,   54,   54,   54,
			   76,   54,   54,   34,   23,   54,   54,   54,   54,   54,
			   54,   54,   54,   54,   37,   52,   40,   54,   54,   54,
			   54,   54,   54,   54,   54,   29,   54,   54,   54,   54,

			   54,   54,   54,   54,   54,   54,   54,   54,   54,   54,
			   35,   41,   54,   54,   54,   54,   54,   54,   42,   54,
			   54,   54,   54,   54,   54,   54,   54,   54,   44,   54,
			   54,   54,   54,   54,   54,   54,   54,   43,   54,   54,
			   54,   54,   54,   54,   54,   45,   54,   54,   54,   54,
			   54,   24,   54,   54,   54,   54,   54,   46,   54,   54,
			   54,   54,   54,   48,   25,   54,   54,   47,   54,   49,
			    0, yy_Dummy>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER = 1653
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER = 470
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER = 471
			-- Mark between normal states and templates

	yyNull_equiv_class: INTEGER = 1
			-- Equivalence code for NULL character

	yyReject_used: BOOLEAN = false
			-- Is `reject' called?

	yyVariable_trail_context: BOOLEAN = false
			-- Is there a regular expression with
			-- both leading and trailing parts having
			-- variable length?

	yyReject_or_variable_trail_context: BOOLEAN = false
			-- Is `reject' called or is there a
			-- regular expression with both leading
			-- and trailing parts having variable length?

	yyNb_rules: INTEGER = 119
			-- Number of rules

	yyEnd_of_buffer: INTEGER = 120
			-- End of buffer rule code

	yyLine_used: BOOLEAN = false
			-- Are line and column numbers used?

	yyPosition_used: BOOLEAN = false
			-- Is `position' used?

	INITIAL: INTEGER = 0
	SECT2: INTEGER = 1
	SECT3: INTEGER = 2
	EIFFEL_BLOCK: INTEGER = 3
	OPTION: INTEGER = 4
	RECOVER1: INTEGER = 5
	SCNAME: INTEGER = 6
	XSCNAME: INTEGER = 7
	NUM: INTEGER = 8
	QUOTE: INTEGER = 9
	SCOND: INTEGER = 10
	ACTION_TEXT: INTEGER = 11
	DEFINITION: INTEGER = 12
	FIRSTCCL: INTEGER = 13
	CCL: INTEGER = 14
	OUTFILE: INTEGER = 15
	REGEXP: INTEGER = 16
	EIFFEL_BLOCK2: INTEGER = 17
			-- Start condition codes

feature -- User-defined features



feature {NONE} -- Access

	last_integer_value: INTEGER
			-- Last semantic value of type INTEGER

end
