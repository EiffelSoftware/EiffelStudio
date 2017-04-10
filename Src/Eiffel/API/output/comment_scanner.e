note

	description: "Scanners for Eiffel comment"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$date$"
	revision: "$Revision$"

class COMMENT_SCANNER

inherit
	COMMENT_SCANNER_SKELETON

create
	make_with_text_formatter


feature -- Status report

	valid_start_condition (sc: INTEGER): BOOLEAN
			-- Is `sc' a valid start condition?
		do
			Result := (INITIAL <= sc and sc <= BREAK_TOKEN)
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
--|#line <not available> "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line <not available>")
end

				if separate_comment then
					set_start_condition (BREAK_TOKEN)
				else
					set_start_condition (NOT_BREAK_TOKEN)
				end
				less (0)
			
when 2 then
--|#line <not available> "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line <not available>")
end

				append_buffer
				add_email_tokens
			
when 3 then
--|#line <not available> "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line <not available>")
end
	
				append_buffer
				add_url_tokens				
			
when 4 then
--|#line <not available> "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line <not available>")
end

				append_buffer
				add_quote_feature
			
when 5 then
--|#line <not available> "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line <not available>")
end

				append_buffer
				add_class (True)
				last_condition := NOT_BREAK_TOKEN
				set_start_condition (DOT_FEATURE)
				less (text_count - 2)
			
when 6 then
--|#line <not available> "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line <not available>")
end

				append_buffer
				add_class (False)
			
when 7 then
--|#line <not available> "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line <not available>")
end

				append_buffer
				add_cluster
			
when 8 then
--|#line <not available> "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line <not available>")
end

				append_buffer
				text_formatter.process_new_line
			
when 9 then
--|#line <not available> "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line <not available>")
end

				buffer_token
			
when 10 then
--|#line <not available> "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line <not available>")
end

				add_email_tokens
			
when 11 then
--|#line <not available> "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line <not available>")
end
				
				add_url_tokens				
			
when 12 then
--|#line <not available> "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line <not available>")
end

				add_quote_feature
			
when 13 then
--|#line <not available> "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line <not available>")
end

				add_class (True)
				last_condition := BREAK_TOKEN
				set_start_condition (DOT_FEATURE)
				less (text_count - 2)
			
when 14 then
--|#line <not available> "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line <not available>")
end

				add_class (False)
			
when 15 then
--|#line <not available> "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line <not available>")
end

				add_cluster
			
when 16 then
--|#line <not available> "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line <not available>")
end

				text_formatter.process_new_line
			
when 17 then
--|#line <not available> "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line <not available>")
end

				add_normal_text
			
when 18 then
--|#line <not available> "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line <not available>")
end

			
when 19 then
--|#line <not available> "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line <not available>")
end

				add_normal_text
			
when 20 then
--|#line <not available> "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line <not available>")
end

				add_normal_text	
			
when 21 then
--|#line <not available> "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line <not available>")
end

				add_dot_feature
			
when 22 then
--|#line <not available> "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line <not available>")
end

				less (0)
				set_start_condition (last_condition)
				reset_last_type
			
when 23 then
--|#line <not available> "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line <not available>")
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
when 0, 1, 2, 3 then
--|#line <not available> "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line <not available>")
end

				append_buffer
				terminate
			
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
			create an_array.make_filled (0, 0, 888)
			yy_nxt_template_1 (an_array)
			yy_nxt_template_2 (an_array)
			yy_nxt_template_3 (an_array)
			yy_nxt_template_4 (an_array)
			yy_nxt_template_5 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_nxt_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			    0,   13,   13,   14,   13,   13,   13,   13,   13,   13,
			   13,   13,   13,   13,   13,   13,   13,   13,   13,   15,
			   15,   16,   13,   13,   13,   17,   15,   18,   19,   20,
			   15,   15,   21,   15,   15,   15,   15,   22,   23,   24,
			   13,   13,   25,   26,   27,   28,   29,   25,   29,   30,
			   29,   31,   29,   29,   29,   29,   29,   25,   25,   29,
			   32,   32,   33,   25,   30,   29,   34,   32,   35,   36,
			   37,   32,   32,   38,   32,   32,   32,   32,   39,   40,
			   41,   25,   31,   43,  165,   47,  164,   43,   43,   43,
			   43,   43,   48,   43,   44,   43,   43,   43,   43,   43,

			   43,   44,   44,   43,   43,   43,   43,   43,   44,   44,
			   44,   44,   44,   44,   44,   44,   44,   44,   44,   44,
			   44,   43,   43,   43,   51,   67,   76,   71,   42,  165,
			   52,   60,   68,   72,   80,   60,   60,   60,   61,   60,
			   42,   60,   62,   60,   60,   60,   60,   60,   60,   62,
			   62,   61,   60,   61,   60,   61,   62,   62,   62,   62,
			   62,   62,   62,   62,   62,   62,   62,   62,   62,   61,
			   60,   61,   78,   76,   76,   76,   76,   76,   93,   76,
			   76,   76,   55,   94,   91,  164,   79,   92,   91,   78,
			   80,   81,   91,   85,   55,   82,   94,   83,   84,   91, yy_Dummy>>,
			1, 200, 0)
		end

	yy_nxt_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			   94,   86,   95,   99,   97,   96,  150,   92,   91,  106,
			  162,   87,   61,   94,   76,   98,   61,   61,   61,   61,
			   61,  102,   61,   90,   61,   61,   61,   61,   61,   61,
			   90,   90,   61,   61,   61,   61,   61,   90,   90,   90,
			   90,   90,   90,   90,   90,   90,   90,   90,   90,   90,
			   61,   61,   61,   91,   76,   91,   91,   75,  166,   76,
			   76,   76,  110,   91,  115,  107,   76,  116,  160,   75,
			   76,   97,   91,  100,  101,  108,  103,   80,   80,   92,
			  109,   91,   91,  117,   94,  121,  104,  105,   91,   76,
			   97,  158,  118,   91,  105,  105,  156,  127,  119,   91,

			  136,  105,  105,  105,  105,  105,  105,  105,  105,  105,
			  105,  105,  105,  105,  114,   97,   76,   92,   91,  154,
			  106,  114,  114,   91,  128,   76,  138,   91,  114,  114,
			  114,  114,  114,  114,  114,  114,  114,  114,  114,  114,
			  114,  120,  123,   80,  152,   76,  123,  123,  123,  123,
			  123,  124,  123,  105,  123,  123,  123,  123,  123,  125,
			  105,  105,  123,  123,  123,  123,  123,  105,  105,  105,
			  105,  105,  105,  105,  105,  105,  105,  105,  105,  105,
			  123,  123,  123,  131,   91,  134,  133,  149,  117,  155,
			  131,  131,  139,   91,   76,   76,   92,  131,  131,  131, yy_Dummy>>,
			1, 200, 200)
		end

	yy_nxt_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  131,  131,  131,  131,  131,  131,  131,  131,  131,  131,
			  132,   97,   80,   80,  132,  132,  132,  133,  132,  134,
			  132,  114,  132,  132,  132,  132,  132,  135,  114,  114,
			  133,  132,  133,  132,  133,  114,  114,  114,  114,  114,
			  114,  114,  114,  114,  114,  114,  114,  114,  133,  132,
			  133,  133,  124,  147,  132,  133,  133,  133,  133,  133,
			  134,  133,  131,  133,  133,  133,  133,  133,  144,  131,
			  131,  133,  133,  133,  133,  133,  131,  131,  131,  131,
			  131,  131,  131,  131,  131,  131,  131,  131,  131,  133,
			  133,  133,   92,   91,   91,  153,  157,  159,  133,  161,

			  132,  143,   92,   92,  163,  142,  123,  123,  137,  146,
			   97,   92,   92,   97,   43,  130,   92,  130,   43,   43,
			  142,   43,   43,  110,  142,  148,  142,  142,   43,   43,
			  142,   43,  148,  148,   43,   43,   43,  142,   43,  148,
			  148,  148,  148,  148,  148,  148,  148,  148,  148,  148,
			  148,  148,   43,   43,   43,   60,  126,  122,   92,   60,
			   60,  147,   61,   60,  121,  147,  151,  147,  147,   60,
			   60,  147,   60,  151,  151,   61,   60,   61,  147,   61,
			  151,  151,  151,  151,  151,  151,  151,  151,  151,  151,
			  151,  151,  151,   61,   60,   61,   10,   10,   10,   10, yy_Dummy>>,
			1, 200, 400)
		end

	yy_nxt_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			   10,   10,   10,   10,   10,   10,   10,   10,   10,   10,
			   10,   10,   10,   10,   11,   11,   11,   11,   11,   11,
			   11,   11,   11,   11,   11,   11,   11,   11,   11,   11,
			   11,   11,   42,   42,  113,  112,   42,   42,   42,   42,
			   45,  112,   45,   45,   45,   45,   45,   45,   45,   45,
			   45,   45,   45,   45,   45,   45,   45,   45,   46,   46,
			   46,  111,   46,   46,   46,   46,   46,   46,   46,   46,
			   46,   46,   46,   46,   46,   46,   55,   55,   77,   92,
			   55,   55,   55,   55,   56,   91,   56,   89,   88,   56,
			   56,   56,   56,   56,   56,   57,   77,   56,   56,   56,

			   56,   63,   76,   63,   63,   63,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   65,
			   65,   65,   59,   65,   65,   65,   65,   65,   65,   65,
			   65,   65,   65,   65,   65,   65,   65,   75,   74,   75,
			   75,   73,   70,   75,   75,   75,   75,  110,   69,  110,
			  110,  110,  110,  110,  110,  110,   66,   64,  110,  110,
			  110,  110,  129,   59,  129,   58,   57,  129,  129,  129,
			  129,  129,  129,   54,   53,  129,  129,  129,  129,  121,
			   50,  121,  121,  121,  121,  121,  121,  121,   49,  166,
			  121,  121,  121,  121,  140,   12,  140,   12,  166,  140, yy_Dummy>>,
			1, 200, 600)
		end

	yy_nxt_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  140,  140,  140,  140,  140,  166,  166,  140,  140,  140,
			  140,  141,  166,  141,  141,  166,  141,  141,  141,  141,
			  141,  141,  141,  141,  141,  141,  141,  141,  141,  145,
			  166,  145,  145,  166,  145,  145,  145,  145,  145,  145,
			  145,  145,  145,  145,  145,  145,  145,    9,  166,  166,
			  166,  166,  166,  166,  166,  166,  166,  166,  166,  166,
			  166,  166,  166,  166,  166,  166,  166,  166,  166,  166,
			  166,  166,  166,  166,  166,  166,  166,  166,  166,  166,
			  166,  166,  166,  166,  166,  166,  166,  166,  166, yy_Dummy>>,
			1, 89, 800)
		end

	yy_chk_template: SPECIAL [INTEGER]
			-- Template for `yy_chk'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 888)
			yy_chk_template_1 (an_array)
			yy_chk_template_2 (an_array)
			yy_chk_template_3 (an_array)
			yy_chk_template_4 (an_array)
			yy_chk_template_5 (an_array)
			Result := yy_fixed_array (an_array)
		end

	yy_chk_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    0,    5,    5,    5,    5,    5,    5,    5,    5,    5,
			    5,    5,    5,    5,    5,    5,    5,    5,    5,    5,
			    5,    5,    5,    5,    5,    5,    5,    5,    5,    5,
			    5,    5,    5,    5,    5,    5,    5,    5,    5,    5,
			    5,    5,    7,    7,    7,    7,    7,    7,    7,    7,
			    7,    7,    7,    7,    7,    7,    7,    7,    7,    7,
			    7,    7,    7,    7,    7,    7,    7,    7,    7,    7,
			    7,    7,    7,    7,    7,    7,    7,    7,    7,    7,
			    7,    7,    7,   15,  165,   18,  164,   15,   15,   15,
			   15,   15,   18,   15,   15,   15,   15,   15,   15,   15,

			   15,   15,   15,   15,   15,   15,   15,   15,   15,   15,
			   15,   15,   15,   15,   15,   15,   15,   15,   15,   15,
			   15,   15,   15,   15,   21,   35,   79,   38,   42,  163,
			   21,   32,   35,   38,   79,   32,   32,   32,   32,   32,
			   42,   32,   32,   32,   32,   32,   32,   32,   32,   32,
			   32,   32,   32,   32,   32,   32,   32,   32,   32,   32,
			   32,   32,   32,   32,   32,   32,   32,   32,   32,   32,
			   32,   32,   46,   47,   48,   49,   50,   51,   64,   52,
			   53,   54,   55,   65,   70,  162,   47,   64,   68,   46,
			   48,   49,   67,   53,   55,   50,   66,   51,   52,   69, yy_Dummy>>,
			1, 200, 0)
		end

	yy_chk_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   65,   54,   66,   70,   68,   67,  146,  146,   73,   80,
			  160,   55,   61,   66,   80,   69,   61,   61,   61,   61,
			   61,   73,   61,   61,   61,   61,   61,   61,   61,   61,
			   61,   61,   61,   61,   61,   61,   61,   61,   61,   61,
			   61,   61,   61,   61,   61,   61,   61,   61,   61,   61,
			   61,   61,   61,   71,   81,   72,   74,   75,   75,   82,
			   83,   84,   86,   96,   93,   81,   85,   95,  158,   75,
			   86,   96,  100,   71,   72,   82,   74,   84,   83,   93,
			   85,   98,   99,   97,   95,  103,   75,   76,   97,  107,
			  100,  156,   98,  103,   76,   76,  154,  107,   99,  101,

			  115,   76,   76,   76,   76,   76,   76,   76,   76,   76,
			   76,   76,   76,   76,   91,  101,  109,  115,  118,  152,
			  108,   91,   91,  151,  109,  108,  118,  102,   91,   91,
			   91,   91,   91,   91,   91,   91,   91,   91,   91,   91,
			   91,  102,  105,  108,  149,  148,  105,  105,  105,  105,
			  105,  105,  105,  105,  105,  105,  105,  105,  105,  105,
			  105,  105,  105,  105,  105,  105,  105,  105,  105,  105,
			  105,  105,  105,  105,  105,  105,  105,  105,  105,  105,
			  105,  105,  105,  113,  120,  145,  144,  143,  119,  153,
			  113,  113,  120,  119,  128,  127,  153,  113,  113,  113, yy_Dummy>>,
			1, 200, 200)
		end

	yy_chk_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  113,  113,  113,  113,  113,  113,  113,  113,  113,  113,
			  114,  119,  127,  128,  114,  114,  114,  114,  114,  114,
			  114,  114,  114,  114,  114,  114,  114,  114,  114,  114,
			  114,  114,  114,  114,  114,  114,  114,  114,  114,  114,
			  114,  114,  114,  114,  114,  114,  114,  114,  114,  114,
			  114,  131,  141,  137,  135,  131,  131,  131,  131,  131,
			  131,  131,  131,  131,  131,  131,  131,  131,  131,  131,
			  131,  131,  131,  131,  131,  131,  131,  131,  131,  131,
			  131,  131,  131,  131,  131,  131,  131,  131,  131,  131,
			  131,  131,  136,  138,  139,  150,  155,  157,  133,  159,

			  132,  130,  155,  150,  161,  126,  125,  123,  117,  136,
			  138,  157,  159,  139,  142,  116,  161,  112,  142,  142,
			  142,  142,  142,  142,  142,  142,  142,  142,  142,  142,
			  142,  142,  142,  142,  142,  142,  142,  142,  142,  142,
			  142,  142,  142,  142,  142,  142,  142,  142,  142,  142,
			  142,  142,  142,  142,  142,  147,  106,  104,   92,  147,
			  147,  147,  147,  147,  147,  147,  147,  147,  147,  147,
			  147,  147,  147,  147,  147,  147,  147,  147,  147,  147,
			  147,  147,  147,  147,  147,  147,  147,  147,  147,  147,
			  147,  147,  147,  147,  147,  147,  167,  167,  167,  167, yy_Dummy>>,
			1, 200, 400)
		end

	yy_chk_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  167,  167,  167,  167,  167,  167,  167,  167,  167,  167,
			  167,  167,  167,  167,  168,  168,  168,  168,  168,  168,
			  168,  168,  168,  168,  168,  168,  168,  168,  168,  168,
			  168,  168,  169,  169,   90,   89,  169,  169,  169,  169,
			  170,   88,  170,  170,  170,  170,  170,  170,  170,  170,
			  170,  170,  170,  170,  170,  170,  170,  170,  171,  171,
			  171,   87,  171,  171,  171,  171,  171,  171,  171,  171,
			  171,  171,  171,  171,  171,  171,  172,  172,   77,   63,
			  172,  172,  172,  172,  173,   62,  173,   59,   58,  173,
			  173,  173,  173,  173,  173,   57,   45,  173,  173,  173,

			  173,  174,   44,  174,  174,  174,  174,  174,  174,  174,
			  174,  174,  174,  174,  174,  174,  174,  174,  174,  175,
			  175,  175,   41,  175,  175,  175,  175,  175,  175,  175,
			  175,  175,  175,  175,  175,  175,  175,  176,   40,  176,
			  176,   39,   37,  176,  176,  176,  176,  177,   36,  177,
			  177,  177,  177,  177,  177,  177,   34,   33,  177,  177,
			  177,  177,  178,   31,  178,   29,   26,  178,  178,  178,
			  178,  178,  178,   23,   22,  178,  178,  178,  178,  179,
			   20,  179,  179,  179,  179,  179,  179,  179,   19,    9,
			  179,  179,  179,  179,  180,    4,  180,    3,    0,  180, yy_Dummy>>,
			1, 200, 600)
		end

	yy_chk_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  180,  180,  180,  180,  180,    0,    0,  180,  180,  180,
			  180,  181,    0,  181,  181,    0,  181,  181,  181,  181,
			  181,  181,  181,  181,  181,  181,  181,  181,  181,  182,
			    0,  182,  182,    0,  182,  182,  182,  182,  182,  182,
			  182,  182,  182,  182,  182,  182,  182,  166,  166,  166,
			  166,  166,  166,  166,  166,  166,  166,  166,  166,  166,
			  166,  166,  166,  166,  166,  166,  166,  166,  166,  166,
			  166,  166,  166,  166,  166,  166,  166,  166,  166,  166,
			  166,  166,  166,  166,  166,  166,  166,  166,  166, yy_Dummy>>,
			1, 89, 800)
		end

	yy_base_template: SPECIAL [INTEGER]
			-- Template for `yy_base'
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,  787,  785,    0,    0,   41,    0,  789,
			  847,  847,    0,  847,  847,   82,    0,    0,   55,  755,
			  743,   98,  748,  735,    0,    0,  764,  847,  847,  752,
			  847,  750,  130,  744,  743,   95,  715,  705,  101,  715,
			  700,  709,  116,    0,  684,  673,  164,  155,  156,  157,
			  158,  159,  161,  162,  163,  170,    0,  693,  674,  673,
			    0,  211,  667,  656,  164,  175,  188,  174,  170,  181,
			  166,  235,  237,  190,  238,  245,  275,  655,  847,  108,
			  196,  236,  241,  242,  243,  248,  252,  651,  633,  627,
			  616,  302,  535,  256,  847,  259,  245,  270,  263,  264,

			  254,  281,  309,  275,  547,  341,  545,  271,  307,  298,
			    0,    0,  511,  371,  409,  294,  509,  497,  300,  375,
			  366,    0,    0,  489,    0,  488,  494,  377,  376,  847,
			  461,  450,  482,  480,    0,  436,  469,  442,  475,  476,
			  847,  442,  513,  365,  368,  375,  184,  554,  327,  329,
			  480,  305,  303,  373,  279,  479,  282,  488,  258,  489,
			  199,  493,  162,  106,   63,   61,  847,  595,  613,  622,
			  639,  657,  666,  683,  700,  718,  729,  744,  761,  776,
			  793,  810,  828, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER]
			-- Template for `yy_def'
		once
			Result := yy_fixed_array (<<
			    0,  167,  167,  168,  168,  166,    5,  166,    7,  166,
			  166,  166,  169,  166,  166,  166,  170,  171,   15,   15,
			   15,   15,   15,   15,  172,  173,  166,  166,  166,  173,
			  166,  166,  166,  174,  175,   32,   32,   32,   32,   32,
			   32,  176,  169,   15,   15,  170,  171,   15,   15,   15,
			   15,   15,   15,   15,   15,  172,  173,  166,  173,  166,
			   32,  166,   32,  174,  174,  175,  175,   32,   32,   32,
			   32,   32,   32,   32,   32,  176,   15,  170,  166,   15,
			   15,   15,   15,   15,   15,   15,   15,  166,  173,  166,
			   61,   32,  174,  174,  166,  175,   32,   32,   32,   32,

			   32,   32,   32,   32,  166,  166,   15,   15,   15,   15,
			  177,  178,  166,   61,  166,  174,  166,   32,   32,   32,
			   32,  179,  180,  105,  181,  105,   15,   15,   15,  166,
			  166,  166,  114,  131,  182,  114,  174,   32,   32,   32,
			  166,  181,  166,  166,  131,  182,  174,  166,  142,  166,
			  174,  147,  166,  174,  166,  174,  166,  174,  166,  174,
			  166,  174,  166,  174,  166,  174,    0,  166,  166,  166,
			  166,  166,  166,  166,  166,  166,  166,  166,  166,  166,
			  166,  166,  166, yy_Dummy>>)
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
			    1,    1,    2,    5,    6,    7,    7,    7,    7,    8,
			    5,    5,    5,    5,    9,    7,   10,   11,   12,   12,
			   12,   12,   12,   12,   12,   12,   12,   12,   13,   14,
			   15,    7,   16,   17,   18,   19,   19,   19,   19,   19,
			   19,   19,   19,   19,   19,   20,   19,   19,   19,   19,
			   19,   19,   19,   19,   19,   19,   19,   19,   19,   19,
			   19,   21,   22,   23,    5,   24,   25,   19,   19,   19,

			   19,   26,   27,   28,   29,   30,   19,   19,   31,   19,
			   32,   33,   34,   19,   35,   36,   37,   19,   19,   38,
			   19,   19,   19,   39,   40,   41,    7,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1, yy_Dummy>>,
			1, 200, 0)
		end

	yy_ec_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1, yy_Dummy>>,
			1, 57, 200)
		end

	yy_meta_template: SPECIAL [INTEGER]
			-- Template for `yy_meta'
		once
			Result := yy_fixed_array (<<
			    0,    1,    2,    2,    2,    1,    1,    3,    4,    1,
			    5,    6,    7,    8,    9,    1,    1,    3,    1,   10,
			   11,   12,    1,   13,    3,    4,   10,   10,   10,   10,
			   10,   14,   10,   10,   10,   10,   15,   16,   17,   18,
			    1,   18, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER]
			-- Template for `yy_accept'
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,    0,    0,    0,    0,    0,    0,   24,
			    1,   22,   22,    9,    8,    9,    9,    9,    9,    9,
			    9,    9,    9,    9,    9,   17,   19,   16,   18,   17,
			   20,   20,   17,   20,   20,   17,   17,   17,   17,   17,
			   17,   20,   21,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,   17,   19,   17,    0,
			   17,    0,   17,    0,    0,    0,    0,   17,   17,   17,
			   17,   17,   17,   17,   17,    0,    0,    7,    4,    0,
			    0,    0,    0,    0,    0,    0,    0,    6,   17,    0,
			    0,   17,   15,    0,   12,    0,   17,   17,   17,   17,

			   17,   17,   17,   17,   14,    2,    0,    0,    0,    0,
			    3,    0,    0,    0,   10,    0,   12,   17,   17,   17,
			   17,   11,    0,    2,    0,    2,    0,    0,    0,    5,
			    0,   10,   10,   10,    0,   10,    0,   17,   17,   17,
			   13,    2,    3,    0,   10,   10,    0,   11,    3,    0,
			    0,   11,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,   17,   15,    0, yy_Dummy>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER = 847
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER = 166
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER = 167
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

	yyNb_rules: INTEGER = 23
			-- Number of rules

	yyEnd_of_buffer: INTEGER = 24
			-- End of buffer rule code

	yyLine_used: BOOLEAN = false
			-- Are line and column numbers used?

	yyPosition_used: BOOLEAN = false
			-- Is `position' used?

	INITIAL: INTEGER = 0
	DOT_FEATURE: INTEGER = 1
	NOT_BREAK_TOKEN: INTEGER = 2
	BREAK_TOKEN: INTEGER = 3
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

end -- class COMMENT_SCANNER
