note

	description: "Scanners for external commands"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"


class EB_COMMAND_SCANNER

inherit
	EB_COMMAND_SCANNER_SKELETON


create
	make


feature -- Status report

	valid_start_condition (sc: INTEGER): BOOLEAN
			-- Is `sc' a valid start condition?
		do
			Result := (sc = INITIAL)
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
			inspect yy_act
when 1 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "command_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'command_scanner.l' at line <not available>")
end

								set_last_text_fragment (factory.new_class_buffer (Current))
								register_text_fragment (last_text_fragment)
								last_token := T_CLASS_BUFFER
				
when 2 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "command_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'command_scanner.l' at line <not available>")
end

								set_last_text_fragment (factory.new_class_buffer_selected (Current))
								register_text_fragment (last_text_fragment)
								last_token := T_CLASS_BUFFER_SELECTED
				
when 3 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "command_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'command_scanner.l' at line <not available>")
end

								set_last_text_fragment (factory.new_feature_buffer (Current))
								register_text_fragment (last_text_fragment)
								last_token := T_FEATURE_BUFFER
						
when 4 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "command_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'command_scanner.l' at line <not available>")
end

								set_last_text_fragment (factory.new_tool_buffer (Current))
								register_text_fragment (last_text_fragment)
								last_token := T_TOOL_BUFFER
						
when 5 then
	yy_column := yy_column + yy_end - yy_start - yy_more_len
	yy_position := yy_position + yy_end - yy_start - yy_more_len
--|#line <not available> "command_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'command_scanner.l' at line <not available>")
end

								set_last_text_fragment (factory.new_tool_buffer_selected (Current))
								register_text_fragment (last_text_fragment)
								last_token := T_TOOL_BUFFER_SELECTED
						
when 6 then
	yy_column := yy_column + 10
	yy_position := yy_position + 10
--|#line <not available> "command_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'command_scanner.l' at line <not available>")
end

								set_last_text_fragment (factory.new_file_name (Current))
								register_text_fragment (last_text_fragment)
								last_token := T_FILE_NAME
						
when 7 then
	yy_column := yy_column + 11
	yy_position := yy_position + 11
--|#line <not available> "command_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'command_scanner.l' at line <not available>")
end

								set_last_text_fragment (factory.new_class_name (Current))
								register_text_fragment (last_text_fragment)
								last_token := T_CLASS_NAME
						
when 8 then
	yy_column := yy_column + 15
	yy_position := yy_position + 15
--|#line <not available> "command_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'command_scanner.l' at line <not available>")
end

								set_last_text_fragment (factory.new_directory_name (Current))
								register_text_fragment (last_text_fragment)
								last_token := T_DIRECTORY_NAME
						
when 9 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "command_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'command_scanner.l' at line <not available>")
end

								set_last_text_fragment (factory.new_w_code (Current))
								register_text_fragment (last_text_fragment)
								last_token := T_W_CODE
						
when 10 then
	yy_column := yy_column + 7
	yy_position := yy_position + 7
--|#line <not available> "command_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'command_scanner.l' at line <not available>")
end

								set_last_text_fragment (factory.new_f_code (Current))
								register_text_fragment (last_text_fragment)
								last_token := T_F_CODE
						
when 11 then
	yy_column := yy_column + 16
	yy_position := yy_position + 16
--|#line <not available> "command_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'command_scanner.l' at line <not available>")
end

								set_last_text_fragment (factory.new_group_directory (Current))
								register_text_fragment (last_text_fragment)
								last_token := T_GROUP_DIRECTORY
						
when 12 then
	yy_column := yy_column + 11
	yy_position := yy_position + 11
--|#line <not available> "command_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'command_scanner.l' at line <not available>")
end

								set_last_text_fragment (factory.new_group_name (Current))
								register_text_fragment (last_text_fragment)
								last_token := T_GROUP_NAME
						
when 13 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "command_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'command_scanner.l' at line <not available>")
end


								set_last_text_fragment (factory.new_line (Current))
								register_text_fragment (last_text_fragment)
								last_token := T_LINE
						
when 14 then
	yy_column := yy_column + 18
	yy_position := yy_position + 18
--|#line <not available> "command_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'command_scanner.l' at line <not available>")
end

								set_last_text_fragment (factory.new_project_directory (Current))
								register_text_fragment (last_text_fragment)
								last_token := T_PROJECT_DIRECTORY
						
when 15 then
	yy_column := yy_column + 17
	yy_position := yy_position + 17
--|#line <not available> "command_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'command_scanner.l' at line <not available>")
end

								set_last_text_fragment (factory.new_target_directory (Current))
								register_text_fragment (last_text_fragment)
								last_token := T_TARGET_DIRECTORY
						
when 16 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "command_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'command_scanner.l' at line <not available>")
end

								set_last_text_fragment (factory.new_file (Current))
								register_text_fragment (last_text_fragment)
								last_token := T_FILE
						
when 17 then
	yy_column := yy_column + 5
	yy_position := yy_position + 5
--|#line <not available> "command_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'command_scanner.l' at line <not available>")
end

								set_last_text_fragment (factory.new_path (Current))
								register_text_fragment (last_text_fragment)
								last_token := T_PATH
							
when 18 then
	yy_column := yy_column + 12
	yy_position := yy_position + 12
--|#line <not available> "command_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'command_scanner.l' at line <not available>")
end

								set_last_text_fragment (factory.new_target_name (Current))
								register_text_fragment (last_text_fragment)
								last_token := T_TARGET_NAME
							
when 19 then
	yy_column := yy_column + 1
	yy_position := yy_position + 1
--|#line <not available> "command_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'command_scanner.l' at line <not available>")
end

								last_token := T_UNRECOGNIZED
			
when 20 then
yy_set_line_column
	yy_position := yy_position + 1
--|#line <not available> "command_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'command_scanner.l' at line <not available>")
end
default_action
			else
				last_token := yyError_token
				fatal_error ("fatal scanner internal error: no action found")
			end
		end

	yy_execute_eof_action (yy_sc: INTEGER)
			-- Execute EOF semantic action.
		do
			terminate
		end

feature {NONE} -- Table templates

	yy_nxt_template: SPECIAL [INTEGER]
		once
			Result := yy_fixed_array (<<
			    0,  129,    5,    6,    5,    6,    7,   59,    7,   28,
			   30,   20,   21,   59,   36,   23,   24,   22,   27,   38,
			   39,   40,   26,   37,   29,   41,   42,   43,    8,   18,
			    8,   25,   59,   28,   30,   34,   20,   21,   36,   23,
			   24,   22,   27,   38,   39,   40,   26,   37,   29,   41,
			   42,   43,    9,   19,    9,   10,   11,   44,   12,   13,
			   35,   45,   49,   14,   32,   33,   33,   15,   50,   51,
			   16,   52,   17,   53,   54,   55,   56,   57,   58,   10,
			   11,   44,   12,   13,   60,   45,   49,   14,   46,   32,
			   33,   15,   50,   51,   16,   52,   17,   53,   54,   55,

			   56,   57,   58,   61,   63,   64,   65,   66,   60,   67,
			   69,   70,   71,   47,   73,   74,   75,   76,   77,   78,
			   81,   83,   84,   79,   85,   86,   87,   61,   63,   64,
			   65,   66,   80,   67,   69,   70,   71,   91,   73,   74,
			   75,   76,   77,   78,   81,   83,   84,   79,   85,   86,
			   87,   89,   92,   93,   94,   95,   80,   96,   97,   98,
			   90,   91,   99,  101,  102,  103,  104,  105,  106,  107,
			  108,  109,  110,  111,  112,   89,   92,   93,   94,   95,
			  113,   96,   97,   98,   90,  114,   99,  101,  102,  103,
			  104,  105,  106,  107,  108,  109,  110,  111,  112,  115,

			  116,  117,  118,  119,  113,  120,  121,  122,  123,  114,
			  124,  125,  126,  127,  128,    4,    4,   32,   21,   20,
			  100,   88,   82,  115,  116,  117,  118,  119,   72,  120,
			  121,  122,  123,   68,  124,  125,  126,  127,  128,   62,
			   48,   31,  129,    3,  129,  129,  129,  129,  129,  129,
			  129,  129,  129,  129,  129,  129,  129,  129,  129,  129,
			  129,  129,  129,  129,  129,  129,  129,  129,  129,  129,
			  129,  129,  129,  129,  129,  129,  129,  129,  129,  129,
			  129,  129,  129,  129,  129,  129,  129,  129,  129,  129,
			  129,  129,  129,  129,  129,  129,  129, yy_Dummy>>)
		end

	yy_chk_template: SPECIAL [INTEGER]
		once
			Result := yy_fixed_array (<<
			    0,    0,    1,    1,    2,    2,    1,   59,    2,   15,
			   16,   20,   21,  135,   22,   11,   12,   10,   14,   24,
			   25,   26,   13,   23,   15,   27,   28,   29,    1,    7,
			    2,   12,   59,   15,   16,   20,   20,   21,   22,   11,
			   12,   10,   14,   24,   25,   26,   13,   23,   15,   27,
			   28,   29,    1,    7,    2,    6,    6,   30,    6,    6,
			   21,   31,   36,    6,   32,   33,  134,    6,   37,   38,
			    6,   39,    6,   40,   41,   42,   43,   44,   45,    6,
			    6,   30,    6,    6,   49,   31,   36,    6,   32,   32,
			   33,    6,   37,   38,    6,   39,    6,   40,   41,   42,

			   43,   44,   45,   50,   52,   53,   56,   57,   49,   58,
			   61,   62,   63,   33,   65,   66,   67,   68,   69,   70,
			   73,   76,   77,   72,   78,   79,   80,   50,   52,   53,
			   56,   57,   72,   58,   61,   62,   63,   83,   65,   66,
			   67,   68,   69,   70,   73,   76,   77,   72,   78,   79,
			   80,   82,   84,   85,   86,   87,   72,   88,   89,   90,
			   82,   83,   91,   94,   95,   96,   97,   98,  100,  101,
			  103,  104,  105,  106,  107,   82,   84,   85,   86,   87,
			  108,   88,   89,   90,   82,  109,   91,   94,   95,   96,
			   97,   98,  100,  101,  103,  104,  105,  106,  107,  111,

			  112,  113,  114,  115,  108,  116,  117,  118,  120,  109,
			  121,  122,  124,  125,  126,  130,  130,  133,  132,  131,
			   92,   81,   74,  111,  112,  113,  114,  115,   64,  116,
			  117,  118,  120,   60,  121,  122,  124,  125,  126,   51,
			   35,   17,    3,  129,  129,  129,  129,  129,  129,  129,
			  129,  129,  129,  129,  129,  129,  129,  129,  129,  129,
			  129,  129,  129,  129,  129,  129,  129,  129,  129,  129,
			  129,  129,  129,  129,  129,  129,  129,  129,  129,  129,
			  129,  129,  129,  129,  129,  129,  129,  129,  129,  129,
			  129,  129,  129,  129,  129,  129,  129, yy_Dummy>>)
		end

	yy_base_template: SPECIAL [INTEGER]
		once
			Result := yy_fixed_array (<<
			    0,    0,    2,  242,  243,  243,   46,    1,    0,    0,
			    0,    0,    1,    0,    3,    2,    3,  211,    0,    0,
			    6,    7,    7,    1,    2,   11,    1,    6,    2,    7,
			   35,   52,   59,   60,  243,  236,   39,   57,   58,   51,
			   48,   63,   61,   60,   64,   58,  243,  243,    0,   61,
			   94,  209,   94,   84,  243,  243,   95,   96,   99,    2,
			  203,   86,   92,  101,  198,  105,   91,  105,   98,   98,
			  112,  243,  113,   96,  192,  243,  114,  100,  106,  110,
			  119,  191,  141,  119,  125,  142,  132,  137,  147,  143,
			  152,  151,  190,  243,  152,  153,  150,  144,  149,  243,

			  149,  160,  243,  148,  160,  161,  166,  150,  169,  176,
			  243,  181,  180,  192,  178,  192,  183,  182,  187,  243,
			  181,  190,  189,  243,  190,  186,  187,  243,  243,  243,
			  214,  217,  216,  215,   64,   11, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER]
		once
			Result := yy_fixed_array (<<
			    0,  130,  130,  129,  129,  129,  129,  129,  131,  132,
			  129,  129,  129,  129,  129,  129,  129,  129,  133,  134,
			  131,  132,  129,  129,  129,  129,  129,  129,  129,  129,
			  129,  129,  133,  134,  129,  129,  129,  129,  129,  129,
			  129,  129,  129,  129,  129,  129,  129,  129,  135,  129,
			  129,  129,  129,  129,  129,  129,  129,  129,  129,  135,
			  129,  129,  129,  129,  129,  129,  129,  129,  129,  129,
			  129,  129,  129,  129,  129,  129,  129,  129,  129,  129,
			  129,  129,  129,  129,  129,  129,  129,  129,  129,  129,
			  129,  129,  129,  129,  129,  129,  129,  129,  129,  129,

			  129,  129,  129,  129,  129,  129,  129,  129,  129,  129,
			  129,  129,  129,  129,  129,  129,  129,  129,  129,  129,
			  129,  129,  129,  129,  129,  129,  129,  129,  129,    0,
			  129,  129,  129,  129,  129,  129, yy_Dummy>>)
		end

	yy_ec_template: SPECIAL [INTEGER]
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    2,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    3,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    4,    1,    5,    5,
			    5,    5,    5,    5,    5,    5,    5,    5,    1,    1,
			    1,    1,    1,    1,    6,    7,    8,    9,   10,   11,
			   12,   13,   14,   15,   16,    8,   17,   18,   19,   20,
			   21,    8,   22,   23,   24,   25,    8,   26,    8,   27,
			    8,   28,    1,   29,    1,   30,    1,   31,   32,   33,

			   34,   35,   36,   37,   38,   39,   40,   32,   41,   42,
			   43,   44,   45,   32,   46,   47,   48,   49,   32,   50,
			   32,   51,   32,   52,    1,   53,    1,    1,    1,    1,
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
			    0,    1,    1,    1,    1,    1,    1,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    1,    1,
			    1,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    1,    1, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER]
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,   21,   19,   20,   19,   19,   19,   19,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    4,    1,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    5,    2,    0,    0,
			    0,   16,    0,    0,   13,   17,    0,    0,    0,    3,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,   10,    0,    0,    0,    9,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    6,    0,    0,    0,    0,    0,    7,

			    0,    0,   12,    0,    0,    0,    0,    0,    0,    0,
			   18,    0,    0,    0,    0,    0,    0,    0,    0,    8,
			    0,    0,    0,   11,    0,    0,    0,   15,   14,    0, yy_Dummy>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER = 243
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER = 129
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER = 130
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

	yyNb_rules: INTEGER = 20
			-- Number of rules

	yyEnd_of_buffer: INTEGER = 21
			-- End of buffer rule code

	yyLine_used: BOOLEAN = true
			-- Are line and column numbers used?

	yyPosition_used: BOOLEAN = true
			-- Is `position' used?

	INITIAL: INTEGER = 0
			-- Start condition codes

feature -- User-defined features



note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
