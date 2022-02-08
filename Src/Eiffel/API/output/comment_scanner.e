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
				add_class (True)
			
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

				add_class (True)
			
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
			create an_array.make_filled (0, 0, 732)
			yy_nxt_template_1 (an_array)
			yy_nxt_template_2 (an_array)
			yy_nxt_template_3 (an_array)
			yy_nxt_template_4 (an_array)
			an_array.area.fill_with (166, 693, 732)
			Result := yy_fixed_array (an_array)
		end

	yy_nxt_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			    0,   13,   14,   13,   13,   13,   13,   13,   13,   13,
			   13,   13,   13,   13,   13,   13,   13,   13,   15,   16,
			   13,   13,   13,   17,   15,   18,   19,   20,   15,   15,
			   21,   15,   15,   15,   15,   22,   23,   24,   13,   13,
			   13,   26,   27,   28,   29,   25,   29,   30,   29,   31,
			   29,   29,   29,   29,   29,   25,   25,   29,   32,   33,
			   25,   30,   29,   34,   32,   35,   36,   37,   32,   32,
			   38,   32,   32,   32,   32,   39,   40,   41,   25,   31,
			   25,   43,   43,   43,   43,   43,   55,   43,   44,   43,
			   43,   43,   43,   43,   43,   44,   43,   43,   43,   43,

			   43,   44,   44,   44,   44,   44,   44,   44,   44,   44,
			   44,   44,   44,   44,   43,   43,   43,   43,   47,  106,
			   51,   42,  150,   92,   76,   48,   52,   60,   60,   60,
			   61,   60,   42,   60,   62,   60,   60,   60,   60,   60,
			   60,   62,   61,   60,   61,   60,   61,   62,   62,   62,
			   62,   62,   62,   62,   62,   62,   62,   62,   62,   62,
			   61,   60,   61,   60,   67,   78,   71,   76,   76,   76,
			   76,   68,   72,   76,   76,   76,   76,   93,   55,   79,
			   94,   78,   91,   80,   81,   92,   85,   91,   82,   55,
			   91,   91,   83,   84,   96,   86,   94,   76,   42,   76, yy_Dummy>>,
			1, 200, 0)
		end

	yy_nxt_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			   75,   75,   97,  102,   80,   98,   87,   61,   61,   61,
			   61,   61,  109,   61,   90,   61,   61,   61,   61,   61,
			   61,   90,   61,   61,   61,   61,   61,   90,   90,   90,
			   90,   90,   90,   90,   90,   90,   90,   90,   90,   90,
			   61,   61,   61,   61,   94,   91,   91,   76,   91,   91,
			   95,   75,  166,   76,   76,  165,   76,  107,  115,  110,
			   94,  116,   75,   99,  164,  100,  101,   76,  103,  108,
			   80,   80,   92,  117,   91,   91,   91,   94,   91,  104,
			  105,   97,   76,  157,  121,  118,  165,  105,   92,  127,
			   91,  119,   91,  105,  105,  105,  105,  105,  105,  105,

			  105,  105,  105,  105,  105,  105,  114,   97,   76,   91,
			  164,  162,  160,  114,  158,  128,  138,   91,  136,  114,
			  114,  114,  114,  114,  114,  114,  114,  114,  114,  114,
			  114,  114,   97,   91,   92,   91,  153,  110,  155,  110,
			  110,  110,  139,   92,   92,  156,  120,  123,  123,  123,
			  123,  123,  124,  123,  105,  123,  123,  123,  123,  123,
			  125,  105,  123,  123,  123,  123,  123,  105,  105,  105,
			  105,  105,  105,  105,  105,  105,  105,  105,  105,  105,
			  123,  123,  123,  123,  106,   76,  117,   76,   91,   76,
			  159,   91,   92,   91,  154,   91,  152,   76,  161,  134, yy_Dummy>>,
			1, 200, 200)
		end

	yy_nxt_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			  133,   80,  163,   92,   97,   80,   80,  131,   97,  146,
			   92,   97,   56,   92,  131,   56,   56,  149,   56,  124,
			  131,  131,  131,  131,  131,  131,  131,  131,  131,  131,
			  131,  131,  131,  132,  132,  132,  133,  132,  134,  132,
			  114,  132,  132,  132,  132,  132,  135,  114,  133,  132,
			  133,  132,  133,  114,  114,  114,  114,  114,  114,  114,
			  114,  114,  114,  114,  114,  114,  133,  132,  133,  132,
			  133,  133,  133,  133,  133,  134,  133,  131,  133,  133,
			  133,  133,  133,  144,  131,  133,  133,  133,  133,  133,
			  131,  131,  131,  131,  131,  131,  131,  131,  131,  131,

			  131,  131,  131,  133,  133,  133,  133,   43,   43,  142,
			   43,   43,  110,  142,  148,  142,  142,   43,   43,  142,
			   43,  148,   43,   43,   43,  142,   43,  148,  148,  148,
			  148,  148,  148,  148,  148,  148,  148,  148,  148,  148,
			   43,   43,   43,   43,   60,   60,  147,   61,   60,  121,
			  147,  151,  147,  147,   60,   60,  147,   60,  151,   61,
			   60,   61,  147,   61,  151,  151,  151,  151,  151,  151,
			  151,  151,  151,  151,  151,  151,  151,   61,   60,   61,
			   60,   10,   10,   10,   10,   10,   10,   10,   10,   11,
			   11,   11,   11,   11,   11,   11,   11,   45,   45,   45, yy_Dummy>>,
			1, 200, 400)
		end

	yy_nxt_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			   45,   45,   45,   45,   46,   46,  147,   46,   46,   46,
			   46,   46,   63,   63,   63,   63,   63,   63,   63,   65,
			   65,  132,   65,   65,   65,   65,   65,  129,  133,  132,
			  129,  129,  121,  129,  121,  121,  121,  140,  143,  142,
			  140,  140,  123,  140,  141,  141,  123,  141,  141,  141,
			  141,  145,  145,  137,  145,  145,  145,  145,  130,  130,
			  126,  122,   92,  113,  112,  112,  111,   77,   92,   91,
			   89,   88,   57,   77,   76,   59,   74,   73,   70,   69,
			   66,   64,   59,   58,   57,   54,   53,   50,   49,  166,
			   12,   12,    9, yy_Dummy>>,
			1, 93, 600)
		end

	yy_chk_template: SPECIAL [INTEGER]
			-- Template for `yy_chk'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 732)
			an_array.put (0, 0)
			an_array.area.fill_with (5, 1, 40)
			an_array.area.fill_with (7, 41, 80)
			yy_chk_template_1 (an_array)
			an_array.area.fill_with (15, 87, 117)
			yy_chk_template_2 (an_array)
			an_array.area.fill_with (32, 133, 163)
			yy_chk_template_3 (an_array)
			an_array.area.fill_with (61, 213, 243)
			yy_chk_template_4 (an_array)
			an_array.area.fill_with (105, 347, 383)
			yy_chk_template_5 (an_array)
			an_array.area.fill_with (114, 433, 469)
			an_array.area.fill_with (131, 470, 506)
			an_array.area.fill_with (142, 507, 543)
			an_array.area.fill_with (147, 544, 580)
			yy_chk_template_6 (an_array)
			an_array.area.fill_with (166, 692, 732)
			Result := yy_fixed_array (an_array)
		end

	yy_chk_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   15,   15,   15,   15,   15,  172, yy_Dummy>>,
			1, 6, 81)
		end

	yy_chk_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   18,   80,   21,   42,  146,  146,   80,   18,   21,   32,
			   32,   32,   32,   32,   42, yy_Dummy>>,
			1, 15, 118)
		end

	yy_chk_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   35,   46,   38,   47,   48,   49,   50,   35,   38,   51,
			   53,   52,   54,   64,   55,   47,   65,   46,   67,   48,
			   49,   64,   53,   68,   50,   55,   69,   73,   51,   52,
			   67,   54,   65,   79,  169,   85,  176,  176,   68,   73,
			   79,   69,   55,   61,   61,   61,   61,   61,   85, yy_Dummy>>,
			1, 49, 164)
		end

	yy_chk_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   66,   70,   71,   81,   72,   74,   66,   75,   75,   83,
			   82,  165,   84,   81,   93,   86,   66,   95,   75,   70,
			  164,   71,   72,   86,   74,   82,   83,   84,   93,   97,
			   96,   98,   99,   95,   97,   75,   76,   96,  107,  155,
			  103,   98,  163,   76,  155,  107,  100,   99,  103,   76,
			   76,   76,   76,   76,   76,   76,   76,   76,   76,   76,
			   76,   76,   91,  100,  109,  118,  162,  160,  158,   91,
			  156,  109,  118,  101,  115,   91,   91,   91,   91,   91,
			   91,   91,   91,   91,   91,   91,   91,   91,  101,  102,
			  115,  120,  150,  177,  153,  177,  177,  177,  120,  150,

			  153,  154,  102, yy_Dummy>>,
			1, 103, 244)
		end

	yy_chk_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  108,  127,  119,  128,  138,  108,  157,  119,  136,  139,
			  152,  151,  149,  148,  159,  145,  144,  127,  161,  157,
			  138,  128,  108,  113,  119,  136,  159,  139,  173,  161,
			  113,  173,  173,  143,  173,  141,  113,  113,  113,  113,
			  113,  113,  113,  113,  113,  113,  113,  113,  113, yy_Dummy>>,
			1, 49, 384)
		end

	yy_chk_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			  167,  167,  167,  167,  167,  167,  167,  167,  168,  168,
			  168,  168,  168,  168,  168,  168,  170,  170,  170,  170,
			  170,  170,  170,  171,  171,  137,  171,  171,  171,  171,
			  171,  174,  174,  174,  174,  174,  174,  174,  175,  175,
			  135,  175,  175,  175,  175,  175,  178,  133,  132,  178,
			  178,  179,  178,  179,  179,  179,  180,  130,  126,  180,
			  180,  125,  180,  181,  181,  123,  181,  181,  181,  181,
			  182,  182,  117,  182,  182,  182,  182,  116,  112,  106,
			  104,   92,   90,   89,   88,   87,   77,   63,   62,   59,
			   58,   57,   45,   44,   41,   40,   39,   37,   36,   34,

			   33,   31,   29,   26,   23,   22,   20,   19,    9,    4,
			    3, yy_Dummy>>,
			1, 111, 581)
		end

	yy_base_template: SPECIAL [INTEGER]
			-- Template for `yy_base'
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,  682,  681,    0,    0,   40,    0,  689,
			  692,  692,    0,  692,  692,   77,    0,    0,   90,  657,
			  652,   96,  662,  649,    0,    0,  683,  692,  692,  671,
			  692,  670,  123,  669,  668,  136,  648,  643,  142,  653,
			  640,  663,  110,    0,  657,  652,  158,  150,  151,  152,
			  153,  156,  158,  157,  159,  167,    0,  671,  658,  657,
			    0,  203,  652,  647,  164,  173,  237,  165,  170,  173,
			  228,  229,  231,  174,  232,  240,  269,  646,  692,  180,
			  107,  230,  237,  236,  239,  182,  250,  657,  658,  657,
			  646,  295,  641,  251,  692,  254,  257,  261,  258,  259,

			  273,  300,  316,  275,  652,  343,  650,  265,  372,  291,
			    0,    0,  654,  396,  429,  313,  653,  643,  292,  374,
			  318,    0,    0,  629,    0,  625,  629,  368,  370,  692,
			  600,  466,  612,  611,    0,  604,  371,  596,  371,  376,
			  692,  410,  503,  397,  383,  390,  102,  540,  380,  382,
			  322,  378,  379,  323,  329,  267,  306,  382,  303,  389,
			  301,  392,  289,  265,  243,  234,  692,  580,  588,  192,
			  595,  603,   80,  410,  610,  618,  195,  335,  625,  630,
			  635,  642,  649, yy_Dummy>>)
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
			create an_array.make_filled (0, 0, 257)
			yy_ec_template_1 (an_array)
			an_array.area.fill_with (18, 65, 90)
			yy_ec_template_2 (an_array)
			an_array.area.fill_with (40, 127, 257)
			Result := yy_fixed_array (an_array)
		end

	yy_ec_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			    0,   40,   40,   40,   40,   40,   40,   40,   40,    1,
			    2,   40,   40,    3,   40,   40,   40,   40,   40,   40,
			   40,   40,   40,   40,   40,   40,   40,   40,   40,   40,
			   40,   40,    1,    4,    5,    6,    6,    6,    6,    7,
			    4,    4,    4,    4,    8,    6,    9,   10,   11,   11,
			   11,   11,   11,   11,   11,   11,   11,   11,   12,   13,
			   14,    6,   15,   16,   17, yy_Dummy>>,
			1, 65, 0)
		end

	yy_ec_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			   19,   20,   21,    4,   22,   23,   18,   18,   18,   18,
			   24,   25,   26,   27,   28,   18,   18,   29,   18,   30,
			   31,   32,   18,   33,   34,   35,   18,   18,   36,   18,
			   18,   18,   37,   38,   39,    6, yy_Dummy>>,
			1, 36, 91)
		end

	yy_meta_template: SPECIAL [INTEGER]
			-- Template for `yy_meta'
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    8,    8,    2,    3,    8,    4,
			    2,    2,    5,    2,    8,    8,    2,    8,    6,    7,
			    8,    7,    2,    3,    6,    6,    6,    6,    6,    6,
			    6,    6,    6,    6,    6,    6,    6,    7,    8,    7,
			    8, yy_Dummy>>)
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

	yyJam_base: INTEGER = 692
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER = 166
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER = 167
			-- Mark between normal states and templates

	yyNull_equiv_class: INTEGER = 40
			-- Equivalence code for NULL character

	yyMax_symbol_equiv_class: INTEGER = 256
			-- All symbols greater than this symbol will have
			-- the same equivalence class as this symbol

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
