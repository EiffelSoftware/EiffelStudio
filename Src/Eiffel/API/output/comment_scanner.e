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

				if seperate_comment then
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
		once
			Result := yy_fixed_array (<<
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
			   44,   43,   43,   43,   52,  165,   69,   67,   73,   78,
			   53,   61,   68,   70,   74,   61,   61,   61,   62,   61,
			  107,   61,   63,   61,   61,   61,   61,   61,   61,   63,
			   63,   62,   61,   62,   61,   62,   63,   63,   63,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   62,
			   61,   62,   42,   78,   78,   78,   78,   78,   94,   78,
			   78,   78,   56,   67,   42,   78,   80,   93,   92,   95,
			   81,   82,   92,   86,   56,   83,   92,   84,   85,   92,

			   78,   87,   92,   81,   97,   96,  110,  157,   81,  102,
			  164,   88,   62,   93,   78,   98,   62,   62,   62,   62,
			   62,   99,   62,   91,   62,   62,   62,   62,   62,   62,
			   91,   91,   62,   62,   62,   62,   62,   91,   91,   91,
			   91,   91,   91,   91,   91,   91,   91,   91,   91,   91,
			   62,   62,   62,   92,  106,   92,   92,   77,  166,   78,
			  115,   78,   78,   92,   92,   78,   92,  117,  162,   77,
			   92,   97,   92,  100,  101,   93,  103,  108,   81,  109,
			  119,  118,   92,   92,   97,  121,  104,  105,   78,  150,
			   93,   78,  160,   92,  105,  105,  127,  120,   97,  128,

			  136,  105,  105,  105,  105,  105,  105,  105,  105,  105,
			  105,  105,  105,  105,  114,   92,  158,   93,   92,  106,
			  117,  114,  114,  138,   78,   92,  139,   78,  114,  114,
			  114,  114,  114,  114,  114,  114,  114,  114,  114,  114,
			  114,  123,   81,   97,   81,  123,  123,  123,  123,  123,
			  124,  123,  105,  123,  123,  123,  123,  123,  125,  105,
			  105,  123,  123,  123,  123,  123,  105,  105,  105,  105,
			  105,  105,  105,  105,  105,  105,  105,  105,  105,  123,
			  123,  123,  131,  156,  153,  154,  155,   92,  152,  131,
			  131,   78,   93,   93,   93,   92,  131,  131,  131,  131,

			  131,  131,  131,  131,  131,  131,  131,  131,  131,  132,
			   81,  146,   97,  132,  132,  132,  133,  132,  134,  132,
			  114,  132,  132,  132,  132,  132,  135,  114,  114,  133,
			  132,  133,  132,  133,  114,  114,  114,  114,  114,  114,
			  114,  114,  114,  114,  114,  114,  114,  133,  132,  133,
			  133,   78,  134,  133,  133,  133,  133,  133,  133,  134,
			  133,  131,  133,  133,  133,  133,  133,  144,  131,  131,
			  133,  133,  133,  133,  133,  131,  131,  131,  131,  131,
			  131,  131,  131,  131,  131,  131,  131,  131,  133,  133,
			  133,   92,  159,  163,  161,   42,   42,  149,  124,   42,

			   42,   42,   42,  147,  132,   93,   93,   93,  133,  132,
			   97,   43,  143,  142,  123,   43,   43,  142,   43,   43,
			  110,  142,  148,  142,  142,   43,   43,  142,   43,  148,
			  148,   43,   43,   43,  142,   43,  148,  148,  148,  148,
			  148,  148,  148,  148,  148,  148,  148,  148,  148,   43,
			   43,   43,   61,  123,  137,  130,   61,   61,  147,   62,
			   61,  121,  147,  151,  147,  147,   61,   61,  147,   61,
			  151,  151,   62,   61,   62,  147,   62,  151,  151,  151,
			  151,  151,  151,  151,  151,  151,  151,  151,  151,  151,
			   62,   61,   62,   10,   10,   10,   10,   10,   10,   10,

			   10,   10,   10,   10,   10,   10,   10,   10,   10,   10,
			   10,   11,   11,   11,   11,   11,   11,   11,   11,   11,
			   11,   11,   11,   11,   11,   11,   11,   11,   11,   45,
			  130,   45,   45,   45,   45,   45,   45,   45,   45,   45,
			   45,   45,   45,   45,   45,   45,   45,   46,   46,   46,
			   46,   46,   46,   46,   46,   46,   46,   46,   46,  126,
			   46,   46,   46,   46,   46,   56,   56,  122,  116,   56,
			   56,   56,   56,   57,   93,   57,  113,  112,   57,   57,
			   57,   57,   57,   57,  112,  111,   57,   57,   57,   57,
			   64,   79,   64,   64,   64,   64,   64,   64,   64,   64,

			   64,   64,   64,   64,   64,   64,   64,   64,   66,   66,
			   66,   66,   66,   66,   66,   66,   66,   66,   66,   66,
			   67,   66,   66,   66,   66,   66,   77,   93,   77,   77,
			   92,   90,   77,   77,   77,   77,  110,   89,  110,  110,
			  110,  110,  110,  110,  110,   58,   47,  110,  110,  110,
			  110,  129,   79,  129,   78,   60,  129,  129,  129,  129,
			  129,  129,   76,   75,  129,  129,  129,  129,  121,   72,
			  121,  121,  121,  121,  121,  121,  121,   71,   65,  121,
			  121,  121,  121,  140,   60,  140,   59,   58,  140,  140,
			  140,  140,  140,  140,   55,   54,  140,  140,  140,  140,

			  141,   51,  141,  141,   50,  141,  141,  141,  141,  141,
			  141,  141,  141,  141,  141,  141,  141,  141,  145,   47,
			  145,  145,  166,  145,  145,  145,  145,  145,  145,  145,
			  145,  145,  145,  145,  145,  145,   12,   12,    9,  166,
			  166,  166,  166,  166,  166,  166,  166,  166,  166,  166,
			  166,  166,  166,  166,  166,  166,  166,  166,  166,  166,
			  166,  166,  166,  166,  166,  166,  166,  166,  166,  166,
			  166,  166,  166,  166,  166,  166,  166,  166,  166,  166, yy_Dummy>>)
		end

	yy_chk_template: SPECIAL [INTEGER]
		once
			Result := yy_fixed_array (<<
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
			   15,   15,   15,   15,   21,  163,   35,   34,   38,   82,
			   21,   32,   34,   35,   38,   32,   32,   32,   32,   32,
			   82,   32,   32,   32,   32,   32,   32,   32,   32,   32,
			   32,   32,   32,   32,   32,   32,   32,   32,   32,   32,
			   32,   32,   32,   32,   32,   32,   32,   32,   32,   32,
			   32,   32,   42,   48,   49,   50,   51,   52,   65,   53,
			   54,   55,   56,   68,   42,   84,   48,   65,   70,   68,
			   49,   50,   69,   54,   56,   51,   75,   52,   53,   71,

			   80,   55,   72,   84,   70,   69,   87,  155,   80,   75,
			  162,   56,   62,  155,   87,   71,   62,   62,   62,   62,
			   62,   72,   62,   62,   62,   62,   62,   62,   62,   62,
			   62,   62,   62,   62,   62,   62,   62,   62,   62,   62,
			   62,   62,   62,   62,   62,   62,   62,   62,   62,   62,
			   62,   62,   62,   73,   81,   74,   76,   77,   77,   81,
			   94,   83,   85,   96,   99,   86,  100,   97,  160,   77,
			   98,   96,   97,   73,   74,   94,   76,   83,   85,   86,
			   99,   98,  101,  102,  100,  103,   77,   78,  107,  146,
			  146,  109,  158,  103,   78,   78,  107,  102,  101,  109,

			  115,   78,   78,   78,   78,   78,   78,   78,   78,   78,
			   78,   78,   78,   78,   92,  118,  156,  115,  120,  108,
			  119,   92,   92,  118,  108,  119,  120,  127,   92,   92,
			   92,   92,   92,   92,   92,   92,   92,   92,   92,   92,
			   92,  105,  108,  119,  127,  105,  105,  105,  105,  105,
			  105,  105,  105,  105,  105,  105,  105,  105,  105,  105,
			  105,  105,  105,  105,  105,  105,  105,  105,  105,  105,
			  105,  105,  105,  105,  105,  105,  105,  105,  105,  105,
			  105,  105,  113,  154,  150,  152,  153,  151,  149,  113,
			  113,  128,  150,  153,  136,  138,  113,  113,  113,  113,

			  113,  113,  113,  113,  113,  113,  113,  113,  113,  114,
			  128,  136,  138,  114,  114,  114,  114,  114,  114,  114,
			  114,  114,  114,  114,  114,  114,  114,  114,  114,  114,
			  114,  114,  114,  114,  114,  114,  114,  114,  114,  114,
			  114,  114,  114,  114,  114,  114,  114,  114,  114,  114,
			  131,  148,  145,  144,  131,  131,  131,  131,  131,  131,
			  131,  131,  131,  131,  131,  131,  131,  131,  131,  131,
			  131,  131,  131,  131,  131,  131,  131,  131,  131,  131,
			  131,  131,  131,  131,  131,  131,  131,  131,  131,  131,
			  131,  139,  157,  161,  159,  169,  169,  143,  141,  169,

			  169,  169,  169,  137,  135,  161,  157,  159,  133,  132,
			  139,  142,  130,  126,  125,  142,  142,  142,  142,  142,
			  142,  142,  142,  142,  142,  142,  142,  142,  142,  142,
			  142,  142,  142,  142,  142,  142,  142,  142,  142,  142,
			  142,  142,  142,  142,  142,  142,  142,  142,  142,  142,
			  142,  142,  147,  123,  117,  116,  147,  147,  147,  147,
			  147,  147,  147,  147,  147,  147,  147,  147,  147,  147,
			  147,  147,  147,  147,  147,  147,  147,  147,  147,  147,
			  147,  147,  147,  147,  147,  147,  147,  147,  147,  147,
			  147,  147,  147,  167,  167,  167,  167,  167,  167,  167,

			  167,  167,  167,  167,  167,  167,  167,  167,  167,  167,
			  167,  168,  168,  168,  168,  168,  168,  168,  168,  168,
			  168,  168,  168,  168,  168,  168,  168,  168,  168,  170,
			  112,  170,  170,  170,  170,  170,  170,  170,  170,  170,
			  170,  170,  170,  170,  170,  170,  170,  171,  171,  171,
			  171,  171,  171,  171,  171,  171,  171,  171,  171,  106,
			  171,  171,  171,  171,  171,  172,  172,  104,   95,  172,
			  172,  172,  172,  173,   93,  173,   91,   90,  173,  173,
			  173,  173,  173,  173,   89,   88,  173,  173,  173,  173,
			  174,   79,  174,  174,  174,  174,  174,  174,  174,  174,

			  174,  174,  174,  174,  174,  174,  174,  174,  175,  175,
			  175,  175,  175,  175,  175,  175,  175,  175,  175,  175,
			   66,  175,  175,  175,  175,  175,  176,   64,  176,  176,
			   63,   60,  176,  176,  176,  176,  177,   59,  177,  177,
			  177,  177,  177,  177,  177,   58,   46,  177,  177,  177,
			  177,  178,   45,  178,   44,   41,  178,  178,  178,  178,
			  178,  178,   40,   39,  178,  178,  178,  178,  179,   37,
			  179,  179,  179,  179,  179,  179,  179,   36,   33,  179,
			  179,  179,  179,  180,   31,  180,   29,   26,  180,  180,
			  180,  180,  180,  180,   23,   22,  180,  180,  180,  180,

			  181,   20,  181,  181,   19,  181,  181,  181,  181,  181,
			  181,  181,  181,  181,  181,  181,  181,  181,  182,   17,
			  182,  182,    9,  182,  182,  182,  182,  182,  182,  182,
			  182,  182,  182,  182,  182,  182,    4,    3,  166,  166,
			  166,  166,  166,  166,  166,  166,  166,  166,  166,  166,
			  166,  166,  166,  166,  166,  166,  166,  166,  166,  166,
			  166,  166,  166,  166,  166,  166,  166,  166,  166,  166,
			  166,  166,  166,  166,  166,  166,  166,  166,  166,  166, yy_Dummy>>)
		end

	yy_base_template: SPECIAL [INTEGER]
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,  827,  826,    0,    0,   41,    0,  822,
			  838,  838,    0,  838,  838,   82,    0,  811,   55,  771,
			  764,   98,  769,  756,    0,    0,  785,  838,  838,  773,
			  838,  771,  130,  765,  119,   96,  744,  732,  102,  737,
			  724,  742,  160,    0,  736,  729,  738,  838,  155,  156,
			  157,  158,  159,  161,  162,  163,  170,    0,  743,  723,
			  717,    0,  211,  712,  704,  164,  712,  838,  175,  174,
			  170,  181,  184,  235,  237,  178,  238,  245,  275,  668,
			  182,  241,  111,  243,  167,  244,  247,  196,  675,  676,
			  669,  658,  302,  651,  252,  660,  245,  254,  252,  246,

			  248,  264,  265,  275,  657,  340,  648,  270,  306,  273,
			    0,    0,  624,  370,  408,  294,  549,  543,  297,  307,
			  300,    0,    0,  535,    0,  496,  502,  309,  373,  838,
			  472,  449,  491,  490,    0,  486,  371,  492,  377,  473,
			  838,  488,  510,  475,  435,  442,  267,  551,  433,  373,
			  369,  369,  369,  370,  366,  190,  307,  483,  282,  484,
			  257,  482,  187,  102,   63,   61,  838,  592,  610,  485,
			  628,  646,  655,  672,  689,  707,  718,  733,  750,  765,
			  782,  799,  817, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER]
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
		once
			Result := yy_fixed_array (<<
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
			    0,    1,    2,    2,    2,    1,    1,    3,    4,    1,
			    5,    6,    7,    8,    9,    1,    1,    3,    1,   10,
			   11,   12,    1,    4,    3,   13,   10,   10,   10,   10,
			   10,   14,   10,   10,   10,   10,   15,   16,   17,   18,
			    1,    4, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER]
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

	yyJam_base: INTEGER = 838
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
