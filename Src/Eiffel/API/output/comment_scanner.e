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
			create an_array.make_filled (0, 0, 900)
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
			   41,   25,   31,   43,  165,   48,  164,   43,   43,   43,
			   43,   43,   49,   43,   44,   43,   43,   43,   43,   43,

			   43,   44,   44,   43,   43,   43,   43,   43,   44,   44,
			   44,   44,   44,   44,   44,   44,   44,   44,   44,   44,
			   44,   43,   43,   43,   47,   52,   69,   67,   73,   78,
			   78,   53,   68,   70,   74,  106,  150,   93,  165,   42,
			   78,   47,   61,   80,   67,   81,   61,   61,   61,   62,
			   61,   42,   61,   63,   61,   61,   61,   61,   61,   61,
			   63,   63,   62,   61,   62,   61,   62,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   62,   61,   62,   47,   78,   78,   78,   56,   78,   78,
			   78,   67,   67,  164,   92,   94,   92,   92,   95,   56, yy_Dummy>>,
			1, 200, 0)
		end

	yy_nxt_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			   47,   82,   86,   83,   93,   92,   84,   85,   67,   67,
			   87,   78,   97,   98,  100,   78,   88,   62,   96,   81,
			  162,   62,   62,   62,   62,   62,  107,   62,   91,   62,
			   62,   62,   62,   62,   62,   91,   91,   62,   62,   62,
			   62,   62,   91,   91,   91,   91,   91,   91,   91,   91,
			   91,   91,   91,   91,   91,   62,   62,   62,   92,   92,
			   92,   92,   77,  166,   78,   78,   78,  110,  116,  160,
			   78,  115,  158,  102,   77,   78,   92,   99,  101,   92,
			  108,  103,   81,   81,  109,   67,   93,   97,  117,   92,
			   92,  104,  105,   92,   97,  121,  157,  156,  154,  105,

			  105,  118,   93,   92,   92,  119,  105,  105,  105,  105,
			  105,  105,  105,  105,  105,  105,  105,  105,  105,  114,
			   97,   78,   92,   78,  152,  106,  114,  114,   78,  127,
			   78,  128,   92,  114,  114,  114,  114,  114,  114,  114,
			  114,  114,  114,  114,  114,  114,  120,  123,   81,  134,
			  133,  123,  123,  123,  123,  123,  124,  123,  105,  123,
			  123,  123,  123,  123,  125,  105,  105,  123,  123,  123,
			  123,  123,  105,  105,  105,  105,  105,  105,  105,  105,
			  105,  105,  105,  105,  105,  123,  123,  123,  131,   92,
			   92,  149,  124,  147,  132,  131,  131,  138,  139,  136, yy_Dummy>>,
			1, 200, 200)
		end

	yy_nxt_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			   78,   93,  131,  131,  131,  131,  131,  131,  131,  131,
			  131,  131,  131,  131,  131,  132,   93,   81,  146,  132,
			  132,  132,  133,  132,  134,  132,  114,  132,  132,  132,
			  132,  132,  135,  114,  114,  133,  132,  133,  132,  133,
			  114,  114,  114,  114,  114,  114,  114,  114,  114,  114,
			  114,  114,  114,  133,  132,  133,  117,   78,   92,   92,
			  153,   92,  155,  159,  133,  132,  143,  142,   93,   93,
			  161,  123,  123,  137,  130,   97,   81,   93,   97,   97,
			  133,  130,  126,   93,  133,  133,  133,  133,  133,  134,
			  133,  131,  133,  133,  133,  133,  133,  144,  131,  131,

			  133,  133,  133,  133,  133,  131,  131,  131,  131,  131,
			  131,  131,  131,  131,  131,  131,  131,  131,  133,  133,
			  133,   43,  122,   93,  113,   43,   43,  142,   43,   43,
			  110,  142,  148,  142,  142,   43,   43,  142,   43,  148,
			  148,   43,   43,   43,  142,   43,  148,  148,  148,  148,
			  148,  148,  148,  148,  148,  148,  148,  148,  148,   43,
			   43,   43,   61,  112,  112,  111,   61,   61,  147,   62,
			   61,  121,  147,  151,  147,  147,   61,   61,  147,   61,
			  151,  151,   62,   61,   62,  147,   62,  151,  151,  151,
			  151,  151,  151,  151,  151,  151,  151,  151,  151,  151, yy_Dummy>>,
			1, 200, 400)
		end

	yy_nxt_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			   62,   61,   62,  163,   79,   93,   92,   90,   89,   58,
			   79,   78,   60,   76,   75,   93,   10,   10,   10,   10,
			   10,   10,   10,   10,   10,   10,   10,   10,   10,   10,
			   10,   10,   10,   11,   11,   11,   11,   11,   11,   11,
			   11,   11,   11,   11,   11,   11,   11,   11,   11,   11,
			   42,   42,   72,   42,   42,   42,   42,   42,   45,   71,
			   45,   45,   45,   45,   45,   45,   45,   45,   45,   45,
			   45,   45,   45,   45,   45,   46,   46,   46,   46,   46,
			   46,   46,   46,   46,   46,   46,   46,   46,   46,   46,
			   46,   46,   56,   56,   65,   56,   56,   56,   56,   56,

			   57,   60,   57,   59,   58,   57,   57,   57,   57,   57,
			   57,   55,   57,   57,   57,   57,   57,   64,   54,   64,
			   64,   64,   64,   64,   64,   64,   64,   64,   64,   64,
			   64,   64,   64,   64,   66,   66,   66,   66,   66,   66,
			   66,   66,   66,   66,   66,   66,   66,   66,   66,   66,
			   66,   77,   51,   77,   77,   50,   77,   77,   77,   77,
			   77,  110,  166,  110,  110,  110,  110,  110,  110,  110,
			   12,  110,  110,  110,  110,  110,  129,   12,  129,  166,
			  166,  129,  129,  129,  129,  129,  129,  166,  129,  129,
			  129,  129,  129,  121,  166,  121,  121,  121,  121,  121, yy_Dummy>>,
			1, 200, 600)
		end

	yy_nxt_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  121,  121,  166,  121,  121,  121,  121,  121,  140,  166,
			  140,  166,  166,  140,  140,  140,  140,  140,  140,  166,
			  140,  140,  140,  140,  140,  141,  166,  141,  141,  166,
			  141,  141,  141,  141,  141,  141,  141,  141,  141,  141,
			  141,  141,  145,  166,  145,  145,  166,  145,  145,  145,
			  145,  145,  145,  145,  145,  145,  145,  145,  145,    9,
			  166,  166,  166,  166,  166,  166,  166,  166,  166,  166,
			  166,  166,  166,  166,  166,  166,  166,  166,  166,  166,
			  166,  166,  166,  166,  166,  166,  166,  166,  166,  166,
			  166,  166,  166,  166,  166,  166,  166,  166,  166,  166,

			  166, yy_Dummy>>,
			1, 101, 800)
		end

	yy_chk_template: SPECIAL [INTEGER]
			-- Template for `yy_chk'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 900)
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
			   15,   15,   15,   15,   17,   21,   35,   34,   38,   49,
			   48,   21,   34,   35,   38,   81,  146,  146,  163,   42,
			   81,   17,   32,   48,   34,   49,   32,   32,   32,   32,
			   32,   42,   32,   32,   32,   32,   32,   32,   32,   32,
			   32,   32,   32,   32,   32,   32,   32,   32,   32,   32,
			   32,   32,   32,   32,   32,   32,   32,   32,   32,   32,
			   32,   32,   32,   46,   51,   50,   52,   56,   53,   54,
			   55,   66,   68,  162,   73,   65,   70,   71,   68,   56, yy_Dummy>>,
			1, 200, 0)
		end

	yy_chk_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   46,   50,   54,   51,   65,   69,   52,   53,   66,   68,
			   55,   80,   70,   71,   73,   82,   56,   62,   69,   80,
			  160,   62,   62,   62,   62,   62,   82,   62,   62,   62,
			   62,   62,   62,   62,   62,   62,   62,   62,   62,   62,
			   62,   62,   62,   62,   62,   62,   62,   62,   62,   62,
			   62,   62,   62,   62,   62,   62,   62,   62,   72,   74,
			   75,   76,   77,   77,   83,   84,   85,   87,   95,  158,
			   86,   94,  156,   75,   77,   87,  100,   72,   74,   96,
			   83,   76,   85,   84,   86,   95,   94,   96,   97,   99,
			   98,   77,   78,   97,  100,  103,  155,  154,  152,   78,

			   78,   98,  155,  103,  101,   99,   78,   78,   78,   78,
			   78,   78,   78,   78,   78,   78,   78,   78,   78,   92,
			  101,  107,  151,  109,  149,  108,   92,   92,  148,  107,
			  108,  109,  102,   92,   92,   92,   92,   92,   92,   92,
			   92,   92,   92,   92,   92,   92,  102,  105,  108,  145,
			  144,  105,  105,  105,  105,  105,  105,  105,  105,  105,
			  105,  105,  105,  105,  105,  105,  105,  105,  105,  105,
			  105,  105,  105,  105,  105,  105,  105,  105,  105,  105,
			  105,  105,  105,  105,  105,  105,  105,  105,  113,  118,
			  120,  143,  141,  137,  135,  113,  113,  118,  120,  115, yy_Dummy>>,
			1, 200, 200)
		end

	yy_chk_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  127,  136,  113,  113,  113,  113,  113,  113,  113,  113,
			  113,  113,  113,  113,  113,  114,  115,  127,  136,  114,
			  114,  114,  114,  114,  114,  114,  114,  114,  114,  114,
			  114,  114,  114,  114,  114,  114,  114,  114,  114,  114,
			  114,  114,  114,  114,  114,  114,  114,  114,  114,  114,
			  114,  114,  114,  114,  114,  114,  119,  128,  138,  139,
			  150,  119,  153,  157,  133,  132,  130,  126,  150,  153,
			  159,  125,  123,  117,  116,  138,  128,  157,  139,  119,
			  131,  112,  106,  159,  131,  131,  131,  131,  131,  131,
			  131,  131,  131,  131,  131,  131,  131,  131,  131,  131,

			  131,  131,  131,  131,  131,  131,  131,  131,  131,  131,
			  131,  131,  131,  131,  131,  131,  131,  131,  131,  131,
			  131,  142,  104,   93,   91,  142,  142,  142,  142,  142,
			  142,  142,  142,  142,  142,  142,  142,  142,  142,  142,
			  142,  142,  142,  142,  142,  142,  142,  142,  142,  142,
			  142,  142,  142,  142,  142,  142,  142,  142,  142,  142,
			  142,  142,  147,   90,   89,   88,  147,  147,  147,  147,
			  147,  147,  147,  147,  147,  147,  147,  147,  147,  147,
			  147,  147,  147,  147,  147,  147,  147,  147,  147,  147,
			  147,  147,  147,  147,  147,  147,  147,  147,  147,  147, yy_Dummy>>,
			1, 200, 400)
		end

	yy_chk_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  147,  147,  147,  161,   79,   64,   63,   60,   59,   58,
			   45,   44,   41,   40,   39,  161,  167,  167,  167,  167,
			  167,  167,  167,  167,  167,  167,  167,  167,  167,  167,
			  167,  167,  167,  168,  168,  168,  168,  168,  168,  168,
			  168,  168,  168,  168,  168,  168,  168,  168,  168,  168,
			  169,  169,   37,  169,  169,  169,  169,  169,  170,   36,
			  170,  170,  170,  170,  170,  170,  170,  170,  170,  170,
			  170,  170,  170,  170,  170,  171,  171,  171,  171,  171,
			  171,  171,  171,  171,  171,  171,  171,  171,  171,  171,
			  171,  171,  172,  172,   33,  172,  172,  172,  172,  172,

			  173,   31,  173,   29,   26,  173,  173,  173,  173,  173,
			  173,   23,  173,  173,  173,  173,  173,  174,   22,  174,
			  174,  174,  174,  174,  174,  174,  174,  174,  174,  174,
			  174,  174,  174,  174,  175,  175,  175,  175,  175,  175,
			  175,  175,  175,  175,  175,  175,  175,  175,  175,  175,
			  175,  176,   20,  176,  176,   19,  176,  176,  176,  176,
			  176,  177,    9,  177,  177,  177,  177,  177,  177,  177,
			    4,  177,  177,  177,  177,  177,  178,    3,  178,    0,
			    0,  178,  178,  178,  178,  178,  178,    0,  178,  178,
			  178,  178,  178,  179,    0,  179,  179,  179,  179,  179, yy_Dummy>>,
			1, 200, 600)
		end

	yy_chk_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  179,  179,    0,  179,  179,  179,  179,  179,  180,    0,
			  180,    0,    0,  180,  180,  180,  180,  180,  180,    0,
			  180,  180,  180,  180,  180,  181,    0,  181,  181,    0,
			  181,  181,  181,  181,  181,  181,  181,  181,  181,  181,
			  181,  181,  182,    0,  182,  182,    0,  182,  182,  182,
			  182,  182,  182,  182,  182,  182,  182,  182,  182,  166,
			  166,  166,  166,  166,  166,  166,  166,  166,  166,  166,
			  166,  166,  166,  166,  166,  166,  166,  166,  166,  166,
			  166,  166,  166,  166,  166,  166,  166,  166,  166,  166,
			  166,  166,  166,  166,  166,  166,  166,  166,  166,  166,

			  166, yy_Dummy>>,
			1, 101, 800)
		end

	yy_base_template: SPECIAL [INTEGER]
			-- Template for `yy_base'
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,  767,  760,    0,    0,   41,    0,  762,
			  859,  859,    0,  859,  859,   82,    0,  116,   55,  722,
			  715,   99,  692,  673,    0,    0,  702,  859,  859,  690,
			  859,  688,  141,  681,  119,   96,  626,  615,  102,  588,
			  575,  599,  127,    0,  593,  587,  175,  859,  112,  111,
			  167,  166,  168,  170,  171,  172,  175,    0,  607,  594,
			  593,    0,  216,  588,  582,  181,  183,  859,  184,  187,
			  178,  179,  240,  176,  241,  242,  243,  250,  280,  581,
			  193,  122,  197,  246,  247,  248,  252,  257,  555,  556,
			  555,  506,  307,  500,  263,  260,  261,  275,  272,  271,

			  258,  286,  314,  285,  512,  346,  471,  303,  312,  305,
			    0,    0,  475,  376,  414,  393,  468,  462,  371,  443,
			  372,    0,    0,  454,    0,  453,  456,  382,  439,  859,
			  426,  479,  447,  446,    0,  376,  378,  382,  440,  441,
			  859,  382,  520,  369,  332,  339,  114,  561,  310,  309,
			  445,  304,  282,  446,  280,  279,  263,  454,  259,  460,
			  209,  592,  170,  115,   63,   61,  859,  615,  632,  640,
			  657,  674,  682,  699,  716,  733,  743,  758,  775,  790,
			  807,  824,  841, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER]
			-- Template for `yy_def'
		once
			Result := yy_fixed_array (<<
			    0,  167,  167,  168,  168,  166,    5,  166,    7,  166,
			  166,  166,  169,  166,  166,  166,  170,  171,   15,   15,
			   15,   15,   15,   15,  172,  173,  166,  166,  166,  173,
			  166,  166,  166,  174,  175,   32,   32,   32,   32,   32,
			   32,  176,  169,   15,   15,  170,  171,  166,   15,   15,
			   15,   15,   15,   15,   15,   15,  172,  173,  166,  173,
			  166,   32,  166,   32,  174,  174,  175,  166,  175,   32,
			   32,   32,   32,   32,   32,   32,   32,  176,   15,  170,
			   15,   15,   15,   15,   15,   15,   15,   15,  166,  173,
			  166,   62,   32,  174,  174,  175,   32,   32,   32,   32,

			   32,   32,   32,   32,  166,  166,   15,   15,   15,   15,
			  177,  178,  166,   62,  166,  174,  166,   32,   32,   32,
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
			   11,   12,    1,    4,    3,    4,   10,   10,   10,   10,
			   10,   13,   10,   10,   10,   14,   15,   16,   17,    4,
			    1,    4, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER]
			-- Template for `yy_accept'
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,    0,    0,    0,    0,    0,    0,   24,
			    1,   22,   22,    9,    8,    9,    9,    9,    9,    9,
			    9,    9,    9,    9,    9,   17,   19,   16,   18,   17,
			   20,   20,   17,   20,   20,   17,   17,   17,   17,   17,
			   17,   20,   21,    0,    0,    0,    0,    4,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,   17,   19,   17,
			    0,   17,    0,   17,    0,    0,    0,   12,    0,   17,
			   17,   17,   17,   17,   17,   17,   17,    0,    0,    7,
			    0,    0,    0,    0,    0,    0,    0,    0,    6,   17,
			    0,    0,   17,   15,    0,    0,   17,   17,   17,   17,

			   17,   17,   17,   17,   14,    2,    0,    0,    0,    0,
			    3,    0,    0,    0,   10,    0,   12,   17,   17,   17,
			   17,   11,    0,    2,    0,    2,    0,    0,    0,    5,
			    0,   10,   10,   10,    0,   10,    0,   17,   17,   17,
			   13,    2,    3,    0,   10,   10,    0,   11,    3,    0,
			    0,   11,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,   17,   15,    0, yy_Dummy>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER = 859
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
