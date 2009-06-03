indexing

	description:

		"Scanners for regular expressions"

	library: "Gobo Eiffel Lexical Library"
	copyright: "Copyright (c) 1999-2003, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class LX_REGEXP_SCANNER

inherit

	LX_LEX_SCANNER_SKELETON
		redefine
			last_integer_value
		end

	LX_REGEXP_TOKENS
		export
			{NONE} all
		redefine
			last_integer_value
		end

create

	make, make_from_description

feature -- Status report

	valid_start_condition (sc: INTEGER): BOOLEAN is
			-- Is `sc' a valid start condition?
		do
			Result := (INITIAL <= sc and sc <= REGEXP)
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
if yy_act <= 14 then
if yy_act <= 7 then
if yy_act <= 4 then
if yy_act <= 2 then
if yy_act = 1 then
--|#line 48 "lx_regexp_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_regexp_scanner.l' at line 48")
end

					last_token := Caret_code
					set_start_condition (REGEXP)
				
else
--|#line 52 "lx_regexp_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_regexp_scanner.l' at line 52")
end

					less (0)
					set_start_condition (REGEXP)
				
end
else
if yy_act = 3 then
--|#line 59 "lx_regexp_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_regexp_scanner.l' at line 59")
end

					last_token := Double_quote_code
					set_start_condition (QUOTE)
				
else
	yy_end := yy_end - 1
--|#line 63 "lx_regexp_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_regexp_scanner.l' at line 63")
end
last_token := Dollar_code
end
end
else
if yy_act <= 6 then
if yy_act = 5 then
--|#line 64 "lx_regexp_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_regexp_scanner.l' at line 64")
end

					last_token := Left_brace_code
					set_start_condition (NUM)
				
else
--|#line 68 "lx_regexp_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_regexp_scanner.l' at line 68")
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
					last_string := Void
				
end
else
--|#line 81 "lx_regexp_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_regexp_scanner.l' at line 81")
end
last_token := text_item (1).code
end
end
else
if yy_act <= 11 then
if yy_act <= 9 then
if yy_act = 8 then
--|#line 82 "lx_regexp_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_regexp_scanner.l' at line 82")
end

					last_token := CHAR
					process_character (text_item (1).code)
				
else
--|#line 89 "lx_regexp_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_regexp_scanner.l' at line 89")
end
-- Separator.
end
else
if yy_act = 10 then
--|#line 90 "lx_regexp_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_regexp_scanner.l' at line 90")
end

					if text.is_integer then
						last_token := NUMBER
						last_integer_value := text.to_integer
					else
						report_integer_too_large_error (text)
					end
				
else
--|#line 98 "lx_regexp_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_regexp_scanner.l' at line 98")
end
last_token := Comma_code
end
end
else
if yy_act <= 13 then
if yy_act = 12 then
--|#line 99 "lx_regexp_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_regexp_scanner.l' at line 99")
end

					last_token := Right_brace_code
					set_start_condition (REGEXP)
				
else
--|#line 103 "lx_regexp_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_regexp_scanner.l' at line 103")
end

					report_bad_character_in_brackets_error
					last_token := Right_brace_code
					set_start_condition (REGEXP)
				
end
else
--|#line 108 "lx_regexp_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_regexp_scanner.l' at line 108")
end

					report_missing_bracket_error
					line_nb := line_nb + 1
					last_token := Right_brace_code
					set_start_condition (REGEXP)
				
end
end
end
else
if yy_act <= 21 then
if yy_act <= 18 then
if yy_act <= 16 then
if yy_act = 15 then
--|#line 117 "lx_regexp_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_regexp_scanner.l' at line 117")
end

					process_character (text_item (1).code)
					last_token := CHAR
				
else
--|#line 121 "lx_regexp_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_regexp_scanner.l' at line 121")
end

					last_token := Double_quote_code
					set_start_condition (REGEXP)
				
end
else
if yy_act = 17 then
--|#line 125 "lx_regexp_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_regexp_scanner.l' at line 125")
end

					report_missing_quote_error
					line_nb := line_nb + 1
					last_token := Double_quote_code
					set_start_condition (REGEXP)
				
else
--|#line 133 "lx_regexp_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_regexp_scanner.l' at line 133")
end

					last_token := CHAR
					process_escaped_character
					if start_condition = FIRSTCCL then
						set_start_condition (CCL)
					end
				
end
end
else
if yy_act <= 20 then
if yy_act = 19 then
	yy_end := yy_end - 1
--|#line 142 "lx_regexp_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_regexp_scanner.l' at line 142")
end

					set_start_condition (CCL)
					last_token := Caret_code
				
else
	yy_end := yy_end - 1
--|#line 146 "lx_regexp_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_regexp_scanner.l' at line 146")
end
last_token := Caret_code
end
else
--|#line 147 "lx_regexp_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_regexp_scanner.l' at line 147")
end

					last_token := CHAR
					process_character (text_item (1).code)
					set_start_condition (CCL)
				
end
end
else
if yy_act <= 25 then
if yy_act <= 23 then
if yy_act = 22 then
--|#line 152 "lx_regexp_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_regexp_scanner.l' at line 152")
end

					report_bad_character_class_error
					line_nb := line_nb + 1
					last_token := Right_bracket_code
					set_start_condition (REGEXP)
				
else
	yy_end := yy_end - 1
--|#line 161 "lx_regexp_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_regexp_scanner.l' at line 161")
end
last_token := Minus_code
end
else
if yy_act = 24 then
--|#line 162 "lx_regexp_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_regexp_scanner.l' at line 162")
end

					last_token := CHAR
					process_character (text_item (1).code)
				
else
--|#line 166 "lx_regexp_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_regexp_scanner.l' at line 166")
end

					last_token := Right_bracket_code
					set_start_condition (REGEXP)
				
end
end
else
if yy_act <= 27 then
if yy_act = 26 then
--|#line 170 "lx_regexp_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_regexp_scanner.l' at line 170")
end

					report_bad_character_class_error
					line_nb := line_nb + 1
					last_token := Right_bracket_code
					set_start_condition (REGEXP)
				
else
--|#line 178 "lx_regexp_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_regexp_scanner.l' at line 178")
end

					if text_item (1) = '%N' then
						report_bad_character_error ("%%N")
						line_nb := line_nb + 1
					else
						report_bad_character_error (text)
					end
				
end
else
--|#line 0 "lx_regexp_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'lx_regexp_scanner.l' at line 0")
end
last_token := yyError_token
fatal_error ("scanner jammed")
end
end
end
end
		end

	yy_execute_eof_action (yy_sc: INTEGER) is
			-- Execute EOF semantic action.
		do
			terminate
		end

feature {NONE} -- Table templates

	yy_nxt_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,   66,   66,   15,   15,   51,   51,   45,   55,   44,
			   44,   46,   46,   49,   47,   47,   16,   16,   18,   19,
			   49,   46,   45,   20,   47,   21,   21,   46,   44,   44,
			   47,   56,   57,   54,   22,   18,   19,   43,   58,   53,
			   20,   59,   21,   21,   60,   56,   57,   61,   56,   57,
			   43,   22,   24,   25,   56,   57,   56,   57,   66,   66,
			   66,   66,   66,   26,   24,   25,   66,   66,   66,   66,
			   66,   66,   66,   66,   66,   26,   28,   66,   66,   66,
			   66,   66,   66,   66,   66,   66,   66,   29,   66,   30,
			   28,   66,   66,   66,   66,   66,   66,   66,   66,   66,

			   66,   29,   66,   30,   32,   66,   66,   66,   66,   33,
			   66,   66,   66,   66,   66,   34,   35,   32,   66,   66,
			   66,   66,   33,   66,   66,   66,   66,   66,   34,   35,
			   15,   37,   38,   39,   66,   66,   66,   66,   66,   66,
			   40,   41,   66,   66,   42,   15,   37,   38,   39,   66,
			   66,   66,   66,   66,   66,   40,   41,   66,   66,   42,
			   62,   66,   66,   66,   66,   56,   57,   63,   63,   63,
			   66,   66,   56,   57,   64,   52,   52,   65,   65,   65,
			   14,   14,   14,   14,   17,   17,   17,   17,   23,   23,
			   23,   23,   27,   27,   27,   27,   31,   31,   31,   31,

			   36,   36,   36,   36,   45,   66,   45,   45,   48,   48,
			   48,   48,   50,   50,   50,   52,   66,   52,   52,   13,
			   66,   66,   66,   66,   66,   66,   66,   66,   66,   66,
			   66,   66,   66,   66,   66,   66,   66,   66, yy_Dummy>>)
		end

	yy_chk_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,    1,    2,   38,   38,   78,   77,   21,
			   21,   26,   29,   30,   26,   29,    1,    2,    3,    3,
			   30,   34,   54,    3,   34,    3,    3,   41,   44,   44,
			   41,   52,   52,   46,    3,    4,    4,   43,   53,   40,
			    4,   53,    4,    4,   56,   62,   62,   56,   63,   63,
			   18,    4,    5,    5,   64,   64,   65,   65,   13,    0,
			    0,    0,    0,    5,    6,    6,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    6,    7,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    7,    0,    7,
			    8,    0,    0,    0,    0,    0,    0,    0,    0,    0,

			    0,    8,    0,    8,    9,    0,    0,    0,    0,    9,
			    0,    0,    0,    0,    0,    9,    9,   10,    0,    0,
			    0,    0,   10,    0,    0,    0,    0,    0,   10,   10,
			   11,   11,   11,   11,    0,    0,    0,    0,    0,    0,
			   11,   11,    0,    0,   11,   12,   12,   12,   12,    0,
			    0,    0,    0,    0,    0,   12,   12,    0,    0,   12,
			   58,    0,    0,    0,    0,   58,   58,   59,   59,   59,
			    0,    0,   59,   59,   60,   60,   60,   61,   61,   61,
			   67,   67,   67,   67,   68,   68,   68,   68,   69,   69,
			   69,   69,   70,   70,   70,   70,   71,   71,   71,   71,

			   72,   72,   72,   72,   73,    0,   73,   73,   74,   74,
			   74,   74,   75,   75,   75,   76,    0,   76,   76,   66,
			   66,   66,   66,   66,   66,   66,   66,   66,   66,   66,
			   66,   66,   66,   66,   66,   66,   66,   66, yy_Dummy>>)
		end

	yy_base_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    0,    1,   16,   33,   49,   61,   73,   87,  101,
			  114,  127,  142,   58,  219,  219,  219,  219,   48,  219,
			  219,    0,  219,  219,  219,  219,    2,  219,  219,    3,
			    5,  219,  219,    0,   12,  219,  219,  219,    3,  219,
			   25,   18,  219,   35,   19,  219,   24,    0,  219,  219,
			  219,  219,   17,   29,   13,    0,   35,  219,  151,  158,
			  165,  168,   31,   34,   40,   42,  219,  179,  183,  187,
			  191,  195,  199,  203,  207,  211,  214,    5,    4, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,   67,   67,   68,   68,   69,   69,   70,   70,   71,
			   71,   72,   72,   66,   66,   66,   66,   66,   66,   66,
			   66,   66,   66,   66,   66,   66,   73,   66,   66,   73,
			   74,   66,   66,   75,   73,   66,   66,   66,   66,   66,
			   76,   73,   66,   66,   66,   66,   66,   77,   66,   66,
			   66,   66,   76,   76,   66,   78,   76,   66,   76,   76,
			   59,   59,   76,   76,   76,   76,    0,   66,   66,   66,
			   66,   66,   66,   66,   66,   66,   66,   66,   66, yy_Dummy>>)
		end

	yy_ec_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    2,
			    3,    1,    1,    2,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    2,    1,    4,    1,    5,    1,    1,    1,
			    6,    6,    6,    6,    7,    8,    6,    6,    9,    9,
			    9,    9,    9,    9,    9,    9,   10,   10,    1,    1,
			    1,    1,    1,    6,    1,   11,   11,   11,   11,   11,
			   11,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,   12,    1,
			    1,   13,   14,   15,   16,    1,    1,   11,   11,   11,

			   11,   11,   11,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			   12,    1,    1,   17,    6,   18,    1,    1,    1,    1,
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
			    0,    1,    1,    2,    1,    1,    1,    1,    1,    3,
			    3,    3,    1,    1,    1,    4,    1,    1,    1, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,   29,    2,   27,    1,   13,    9,   14,
			   11,   10,   12,   15,   17,   16,   15,   21,   22,   21,
			   21,   24,   26,   24,   24,   25,    8,    3,    8,    7,
			    8,    8,    5,    9,   10,   18,   18,   18,   19,   20,
			   23,    4,    0,    0,   18,   18,    0,    6,    0,    0,
			    0,    0,    0,    0,    0,    0,    0, yy_Dummy>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 219
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 66
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 67
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

	yyNb_rules: INTEGER is 28
			-- Number of rules

	yyEnd_of_buffer: INTEGER is 29
			-- End of buffer rule code

	yyLine_used: BOOLEAN is false
			-- Are line and column numbers used?

	yyPosition_used: BOOLEAN is false
			-- Is `position' used?

	INITIAL: INTEGER is 0
	NUM: INTEGER is 1
	QUOTE: INTEGER is 2
	FIRSTCCL: INTEGER is 3
	CCL: INTEGER is 4
	REGEXP: INTEGER is 5
			-- Start condition codes

feature -- User-defined features



feature {NONE} -- Access

	last_integer_value: INTEGER
			-- Last semantic value of type INTEGER

end
