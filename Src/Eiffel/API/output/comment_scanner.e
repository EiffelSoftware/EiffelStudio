indexing

	description: "Scanners for Eiffel comment"
	status: "See notice at end of class"
	date: "$date$"
	revision: "$Revision$"

class COMMENT_SCANNER

inherit
	COMMENT_SCANNER_SKELETON

create
	make_with_text_formatter


feature -- Status report

	valid_start_condition (sc: INTEGER): BOOLEAN is
			-- Is `sc' a valid start condition?
		do
			Result := (INITIAL <= sc and sc <= BREAK_TOKEN)
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
if yy_act <= 11 then
if yy_act <= 6 then
if yy_act <= 3 then
if yy_act <= 2 then
if yy_act = 1 then
--|#line 38 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 38")
end

				if seperate_comment then
					set_start_condition (BREAK_TOKEN)
				else
					set_start_condition (NOT_BREAK_TOKEN)
				end
				less (0)
			
else
--|#line 53 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 53")
end

				append_buffer
				add_email_tokens
			
end
else
--|#line 59 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 59")
end
	
				append_buffer
				add_url_tokens				
			
end
else
if yy_act <= 5 then
if yy_act = 4 then
--|#line 65 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 65")
end

				append_buffer
				add_quote_feature
			
else
--|#line 71 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 71")
end

				append_buffer
				add_class
				last_condition := NOT_BREAK_TOKEN
				set_start_condition (DOT_FEATURE)
			
end
else
--|#line 79 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 79")
end

				append_buffer
				add_cluster
			
end
end
else
if yy_act <= 9 then
if yy_act <= 8 then
if yy_act = 7 then
--|#line 84 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 84")
end

				append_buffer
				text_formatter.process_new_line
			
else
--|#line 89 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 89")
end

				buffer_token
			
end
else
--|#line 96 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 96")
end

				add_email_tokens
			
end
else
if yy_act = 10 then
--|#line 101 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 101")
end
				
				add_url_tokens				
			
else
--|#line 106 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 106")
end

				add_quote_feature
			
end
end
end
else
if yy_act <= 16 then
if yy_act <= 14 then
if yy_act <= 13 then
if yy_act = 12 then
--|#line 111 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 111")
end

				add_class
				last_condition := BREAK_TOKEN
				set_start_condition (DOT_FEATURE)
			
else
--|#line 118 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 118")
end

				add_cluster
			
end
else
--|#line 122 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 122")
end

				text_formatter.process_new_line
			
end
else
if yy_act = 15 then
--|#line 127 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 127")
end

				add_text (text)
			
else
--|#line 131 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 131")
end

			
end
end
else
if yy_act <= 19 then
if yy_act <= 18 then
if yy_act = 17 then
--|#line 134 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 134")
end

				add_text (text)
			
else
--|#line 139 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 139")
end

				add_text (text)	
			
end
else
--|#line 145 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 145")
end

				add_dot_feature
			
end
else
if yy_act = 20 then
--|#line 148 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 148")
end

				less (0)
				set_start_condition (last_condition)
				reset_last_type
			
else
--|#line 0 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 0")
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
			inspect yy_sc
when 0, 1, 2, 3 then
--|#line 0 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 0")
end

				append_buffer
				terminate
			
			else
				terminate
			end
		end

feature {NONE} -- Table templates

	yy_nxt_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,   13,   13,   14,   13,   13,   13,   13,   13,   13,
			   13,   13,   13,   13,   13,   13,   13,   13,   15,   15,
			   16,   13,   13,   13,   17,   15,   15,   18,   15,   19,
			   15,   15,   15,   15,   15,   20,   21,   13,   13,   22,
			   23,   24,   25,   26,   22,   27,   26,   28,   26,   26,
			   26,   26,   26,   22,   22,   26,   29,   29,   30,   22,
			   27,   26,   31,   29,   29,   32,   29,   33,   29,   29,
			   29,   29,   29,   34,   35,   22,   28,   38,   37,   45,
			   45,   37,   43,   50,   38,   37,   44,   59,  170,   91,
			   49,   38,   38,   38,   38,   50,   61,   61,   62,   50,

			   60,   38,   36,   37,   74,  111,   76,   37,   38,   38,
			   38,   37,   37,   41,   36,   37,   67,   42,   51,   37,
			   65,   50,   52,   37,   37,   50,   66,  169,   37,   52,
			  110,   51,   75,   51,   76,   51,   52,   52,   52,   37,
			   77,   74,   73,   37,   68,   45,   74,   51,  170,   51,
			   51,  164,   45,   45,   52,   50,   50,   45,   79,   50,
			   50,   52,   50,   51,   74,   51,   80,   51,   52,   52,
			   52,   72,   69,   57,  130,   74,   84,   58,   72,   51,
			   37,   51,   74,   85,   37,   72,   72,   72,   50,   78,
			   50,   61,   50,   83,   50,   81,   87,  123,   61,   61,

			   83,   37,   37,   61,   86,   37,   37,   83,   83,   83,
			   96,   93,   94,   76,  169,   50,  136,   37,   82,   50,
			  101,   37,   72,   50,   74,   95,   76,   50,   89,   72,
			   50,   50,  113,  137,   50,   50,   72,   72,   72,   90,
			   37,   76,  100,  124,   37,   76,   90,   62,  102,  143,
			  142,  166,   50,   90,   90,   90,   50,   74,   50,  131,
			   37,  105,   50,   98,   37,   83,   37,  150,  105,  103,
			   37,   99,   83,   74,  117,  105,  105,  105,  155,   83,
			   83,   83,  107,  163,  108,  112,   90,  114,  102,   76,
			   73,  165,  109,   90,   37,  107,  147,  107,   37,  107,

			   90,   90,   90,   50,  118,   50,   37,   50,  115,   50,
			   37,  107,   76,  107,   98,  159,   83,  119,   96,  125,
			  126,  151,  167,   83,   37,   76,  160,  158,   37,   74,
			   83,   83,   83,   98,   74,   83,   87,   37,  127,   50,
			   50,   37,   83,   50,   50,  114,  149,  141,  135,   83,
			   83,   83,  108,  108,  105,  129,  118,  118,   50,  126,
			  121,  105,   50,   50,   98,  120,  104,   50,  105,  105,
			  105,  107,  126,  108,   92,   90,   37,   37,   76,   50,
			   37,   37,   90,   50,  107,   76,  107,   74,  107,   90,
			   90,   90,   50,  171,   76,   76,   50,  168,   88,   88,

			  107,   64,  107,  108,   63,  105,   76,   74,   71,   70,
			  171,   47,  105,   64,   63,   56,   54,   49,   48,  105,
			  105,  105,   87,   47,  128,  172,   12,   12,  172,  172,
			  172,  128,  172,  172,  172,  172,  172,  172,  128,  128,
			  128,  108,  172,  105,  172,  172,  172,  172,  172,  172,
			  105,  172,  172,  172,  172,  172,  172,  105,  105,  105,
			  132,  172,   96,  172,  133,  172,  172,  172,  172,  172,
			  172,  133,  172,  132,  172,  132,  172,  132,  133,  133,
			  133,  172,  172,  172,  172,  172,  172,  172,  172,  132,
			  172,  132,   87,  172,  128,  172,  172,  172,  172,  172,

			  134,  128,  172,  172,  172,  172,  172,  172,  128,  128,
			  128,   96,  172,  138,  172,  172,  172,  172,  172,  172,
			  138,  172,  172,  172,  172,  172,  172,  138,  138,  138,
			  132,  172,   96,  172,  133,  172,  172,  172,  172,  172,
			  139,  133,  172,  132,  172,  132,  172,  132,  133,  133,
			  133,  172,  172,  172,  172,  172,  172,  172,  172,  132,
			  172,  132,  140,  172,  172,  172,  172,  172,  118,  140,
			  172,  172,  172,  172,  172,  172,  140,  140,  140,   96,
			  172,  138,  172,  172,  172,  172,  172,  144,  138,  172,
			  172,  172,  172,  172,  172,  138,  138,  138,  145,  172,

			  172,  172,  172,  172,  126,  145,  172,  172,  172,  172,
			  172,  172,  145,  145,  145,  147,  172,  140,  172,  172,
			  172,  172,  172,  148,  140,  172,  172,  172,  172,  172,
			  172,  140,  140,  140,  152,  172,  172,  172,  172,  172,
			  132,  152,  172,  172,  172,  172,  172,  172,  152,  152,
			  152,  154,  172,  155,  172,  145,  172,  172,  172,  172,
			  172,  156,  145,  172,  154,  172,  154,  172,  154,  145,
			  145,  145,  172,  172,  172,  172,  172,  172,  172,  172,
			  154,  172,  154,  147,  172,  140,  172,  172,  172,  172,
			  172,  172,  140,  172,  172,  172,  172,  172,  172,  140,

			  140,  140,  147,  172,  140,  172,  172,  172,  172,  172,
			  172,  140,  172,  172,  172,  172,  172,  172,  140,  140,
			  140,  155,  172,  152,  172,  172,  172,  172,  172,  161,
			  152,  172,  172,  172,  172,  172,  172,  152,  152,  152,
			  154,  172,  155,  172,  145,  172,  172,  172,  172,  172,
			  172,  145,  172,  154,  172,  154,  172,  154,  145,  145,
			  145,  172,  172,  172,  172,  172,  172,  172,  172,  154,
			  172,  154,  155,  172,  152,  172,  172,  172,  172,  172,
			  172,  152,  172,  172,  172,  172,  172,  172,  152,  152,
			  152,  155,  172,  152,  172,  172,  172,  172,  172,  172,

			  152,  172,  172,  172,  172,  172,  172,  152,  152,  152,
			   10,   10,   10,   10,   10,   10,   10,   10,   10,   10,
			   10,   10,   11,   11,   11,   11,   11,   11,   11,   11,
			   11,   11,   11,   11,   36,   36,  172,   36,   36,   36,
			   36,   36,   37,  172,   37,  172,   37,   37,   37,   37,
			   37,   37,   37,   37,   39,  172,   39,   39,   39,   39,
			   39,   39,   39,   39,   39,   39,   40,  172,   40,   40,
			   40,   40,   40,   40,   40,   40,   40,   40,   46,  172,
			  172,  172,   46,   46,  172,   46,   46,   46,   46,   46,
			   50,  172,   50,  172,   50,   50,   50,   50,   50,   50,

			   50,   50,   53,  172,   53,   53,   53,   53,   53,   53,
			   53,   53,   53,   53,   55,  172,   55,   55,   55,   55,
			   55,   55,   55,   55,   55,   55,   51,  172,   51,  172,
			   51,   51,   51,   51,   51,   51,   51,   51,   97,  172,
			   97,   97,   97,   97,   97,   97,   97,   97,   97,   97,
			   87,  172,   87,   87,   87,   87,   87,   87,   87,   87,
			   87,   87,  106,  172,  106,  106,  106,  106,  106,  106,
			  106,  106,  106,  106,   96,  172,   96,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,  116,  172,  116,  172,
			  116,  116,  116,  116,  116,  116,  116,  116,  107,  172,

			  107,  107,  107,  107,  107,  107,  107,  107,  107,  107,
			  122,  172,  122,  172,  122,  122,  122,  122,  122,  122,
			  122,  122,  118,  172,  118,  118,  118,  118,  118,  118,
			  118,  118,  118,  118,  126,  172,  126,  126,  126,  126,
			  126,  126,  126,  126,  126,  126,  132,  172,  132,  132,
			  132,  132,  132,  132,  132,  132,  132,  132,  146,  172,
			  146,  146,  146,  146,  146,  146,  146,  146,  146,  146,
			  153,  172,  153,  153,  153,  153,  153,  153,  153,  153,
			  153,  153,  157,  172,  157,  157,  157,  157,  157,  157,
			  157,  157,  157,  157,  154,  172,  154,  154,  154,  154,

			  154,  154,  154,  154,  154,  154,  162,  172,  162,  162,
			  162,  162,  162,  162,  162,  162,  162,  162,    9,  172,
			  172,  172,  172,  172,  172,  172,  172,  172,  172,  172,
			  172,  172,  172,  172,  172,  172,  172,  172,  172,  172,
			  172,  172,  172,  172,  172,  172,  172,  172,  172,  172,
			  172,  172,  172,  172,  172,  172,  172, yy_Dummy>>)
		end

	yy_chk_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    5,    5,    5,    5,    5,    5,    5,    5,    5,
			    5,    5,    5,    5,    5,    5,    5,    5,    5,    5,
			    5,    5,    5,    5,    5,    5,    5,    5,    5,    5,
			    5,    5,    5,    5,    5,    5,    5,    5,    5,    7,
			    7,    7,    7,    7,    7,    7,    7,    7,    7,    7,
			    7,    7,    7,    7,    7,    7,    7,    7,    7,    7,
			    7,    7,    7,    7,    7,    7,    7,    7,    7,    7,
			    7,    7,    7,    7,    7,    7,    7,   15,   19,   21,
			   21,   20,   19,   33,   15,   20,   20,   33,  170,   75,
			   35,   15,   15,   15,   18,   34,   35,   35,   38,   34,

			   34,   18,   36,   37,   75,   92,   92,   37,   18,   18,
			   18,   38,   43,   18,   36,   38,   43,   18,   29,   41,
			   41,   50,   29,   41,   42,   50,   42,  169,   42,   29,
			   91,   29,   54,   29,   56,   29,   29,   29,   29,   44,
			   56,   54,   52,   44,   44,   45,   91,   29,  167,   29,
			   32,  159,   45,   45,   32,   52,   58,   45,   58,   52,
			   58,   32,   59,   32,  159,   32,   59,   32,   32,   32,
			   32,   51,   45,   32,  123,  123,   65,   32,   51,   32,
			   65,   32,  110,   66,   65,   51,   51,   51,   57,   57,
			   60,   61,   57,   62,   60,   60,   68,  110,   61,   61,

			   62,   66,   67,   61,   67,   66,   67,   62,   62,   62,
			   81,   78,   79,  111,  166,   78,  130,   68,   61,   78,
			   85,   68,   72,   80,  130,   80,  131,   80,   72,   72,
			   79,   81,   94,  131,   79,   81,   72,   72,   72,   73,
			   85,  137,   84,  111,   85,  124,   73,   84,   86,  137,
			  136,  163,   94,   73,   73,   73,   94,  136,   73,  124,
			   84,   89,   73,   83,   84,   83,   86,  142,   89,   86,
			   86,   83,   83,  142,  100,   89,   89,   89,  162,   83,
			   83,   83,   90,  158,   90,   93,   90,   95,  103,  160,
			   93,  160,   90,   90,  100,   90,  157,   90,  100,   90,

			   90,   90,   90,   93,  101,   95,  103,   93,   95,   95,
			  103,   90,  143,   90,   97,  150,   97,  102,  155,  112,
			  113,  143,  164,   97,  101,  151,  151,  149,  101,  150,
			   97,   97,   97,   99,  164,   99,  147,  102,  114,  112,
			  113,  102,   99,  112,  113,  115,  141,  135,  129,   99,
			   99,   99,  105,  122,  105,  120,  117,  119,  114,  125,
			  105,  105,  114,  115,  116,  104,   88,  115,  105,  105,
			  105,  106,  127,  106,   77,  106,  117,  119,  168,  125,
			  117,  119,  106,  125,  106,   76,  106,   74,  106,  106,
			  106,  106,  127,  168,  165,  171,  127,  165,   71,   70,

			  106,   64,  106,  107,   63,  107,   55,   53,   49,   48,
			  171,   47,  107,   40,   39,   31,   30,   28,   26,  107,
			  107,  107,  118,   23,  118,    9,    4,    3,    0,    0,
			    0,  118,    0,    0,    0,    0,    0,    0,  118,  118,
			  118,  121,    0,  121,    0,    0,    0,    0,    0,    0,
			  121,    0,    0,    0,    0,    0,    0,  121,  121,  121,
			  126,    0,  126,    0,  126,    0,    0,    0,    0,    0,
			    0,  126,    0,  126,    0,  126,    0,  126,  126,  126,
			  126,    0,    0,    0,    0,    0,    0,    0,    0,  126,
			    0,  126,  128,    0,  128,    0,    0,    0,    0,    0,

			  128,  128,    0,    0,    0,    0,    0,    0,  128,  128,
			  128,  132,    0,  132,    0,    0,    0,    0,    0,    0,
			  132,    0,    0,    0,    0,    0,    0,  132,  132,  132,
			  133,    0,  133,    0,  133,    0,    0,    0,    0,    0,
			  133,  133,    0,  133,    0,  133,    0,  133,  133,  133,
			  133,    0,    0,    0,    0,    0,    0,    0,    0,  133,
			    0,  133,  134,    0,    0,    0,    0,    0,  134,  134,
			    0,    0,    0,    0,    0,    0,  134,  134,  134,  138,
			    0,  138,    0,    0,    0,    0,    0,  138,  138,    0,
			    0,    0,    0,    0,    0,  138,  138,  138,  139,    0,

			    0,    0,    0,    0,  139,  139,    0,    0,    0,    0,
			    0,    0,  139,  139,  139,  140,    0,  140,    0,    0,
			    0,    0,    0,  140,  140,    0,    0,    0,    0,    0,
			    0,  140,  140,  140,  144,    0,    0,    0,    0,    0,
			  144,  144,    0,    0,    0,    0,    0,    0,  144,  144,
			  144,  145,    0,  145,    0,  145,    0,    0,    0,    0,
			    0,  145,  145,    0,  145,    0,  145,    0,  145,  145,
			  145,  145,    0,    0,    0,    0,    0,    0,    0,    0,
			  145,    0,  145,  146,    0,  146,    0,    0,    0,    0,
			    0,    0,  146,    0,    0,    0,    0,    0,    0,  146,

			  146,  146,  148,    0,  148,    0,    0,    0,    0,    0,
			    0,  148,    0,    0,    0,    0,    0,    0,  148,  148,
			  148,  152,    0,  152,    0,    0,    0,    0,    0,  152,
			  152,    0,    0,    0,    0,    0,    0,  152,  152,  152,
			  153,    0,  153,    0,  153,    0,    0,    0,    0,    0,
			    0,  153,    0,  153,    0,  153,    0,  153,  153,  153,
			  153,    0,    0,    0,    0,    0,    0,    0,    0,  153,
			    0,  153,  154,    0,  154,    0,    0,    0,    0,    0,
			    0,  154,    0,    0,    0,    0,    0,    0,  154,  154,
			  154,  161,    0,  161,    0,    0,    0,    0,    0,    0,

			  161,    0,    0,    0,    0,    0,    0,  161,  161,  161,
			  173,  173,  173,  173,  173,  173,  173,  173,  173,  173,
			  173,  173,  174,  174,  174,  174,  174,  174,  174,  174,
			  174,  174,  174,  174,  175,  175,    0,  175,  175,  175,
			  175,  175,  176,    0,  176,    0,  176,  176,  176,  176,
			  176,  176,  176,  176,  177,    0,  177,  177,  177,  177,
			  177,  177,  177,  177,  177,  177,  178,    0,  178,  178,
			  178,  178,  178,  178,  178,  178,  178,  178,  179,    0,
			    0,    0,  179,  179,    0,  179,  179,  179,  179,  179,
			  180,    0,  180,    0,  180,  180,  180,  180,  180,  180,

			  180,  180,  181,    0,  181,  181,  181,  181,  181,  181,
			  181,  181,  181,  181,  182,    0,  182,  182,  182,  182,
			  182,  182,  182,  182,  182,  182,  183,    0,  183,    0,
			  183,  183,  183,  183,  183,  183,  183,  183,  184,    0,
			  184,  184,  184,  184,  184,  184,  184,  184,  184,  184,
			  185,    0,  185,  185,  185,  185,  185,  185,  185,  185,
			  185,  185,  186,    0,  186,  186,  186,  186,  186,  186,
			  186,  186,  186,  186,  187,    0,  187,  187,  187,  187,
			  187,  187,  187,  187,  187,  187,  188,    0,  188,    0,
			  188,  188,  188,  188,  188,  188,  188,  188,  189,    0,

			  189,  189,  189,  189,  189,  189,  189,  189,  189,  189,
			  190,    0,  190,    0,  190,  190,  190,  190,  190,  190,
			  190,  190,  191,    0,  191,  191,  191,  191,  191,  191,
			  191,  191,  191,  191,  192,    0,  192,  192,  192,  192,
			  192,  192,  192,  192,  192,  192,  193,    0,  193,  193,
			  193,  193,  193,  193,  193,  193,  193,  193,  194,    0,
			  194,  194,  194,  194,  194,  194,  194,  194,  194,  194,
			  195,    0,  195,  195,  195,  195,  195,  195,  195,  195,
			  195,  195,  196,    0,  196,  196,  196,  196,  196,  196,
			  196,  196,  196,  196,  197,    0,  197,  197,  197,  197,

			  197,  197,  197,  197,  197,  197,  198,    0,  198,  198,
			  198,  198,  198,  198,  198,  198,  198,  198,  172,  172,
			  172,  172,  172,  172,  172,  172,  172,  172,  172,  172,
			  172,  172,  172,  172,  172,  172,  172,  172,  172,  172,
			  172,  172,  172,  172,  172,  172,  172,  172,  172,  172,
			  172,  172,  172,  172,  172,  172,  172, yy_Dummy>>)
		end

	yy_base_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,  418,  417,    0,    0,   38,    0,  425,
			 1118, 1118,    0, 1118, 1118,   66,    0,    0,   83,   48,
			   51,   61,    0,  421, 1118, 1118,  406, 1118,  405,  111,
			  404,  403,  143,   53,   65,   78,   91,   73,   81,  392,
			  406,   89,   94,   82,  109,  134,    0,  409,  396,  395,
			   91,  160,  125,  385,  119,  399,  127,  158,  126,  132,
			  160,  180,  182,  382,  394,  150,  171,  172,  187, 1118,
			  392,  391,  211,  228,  365,   82,  378,  367,  185,  200,
			  193,  201, 1118,  254,  230,  210,  236,    0,  360,  250,
			  275,  124,   99,  273,  222,  275,    0,  305,    0,  324,

			  264,  294,  307,  276,  328,  343,  364,  394,    0,    0,
			  160,  206,  309,  310,  328,  333,  355,  346,  413,  347,
			  334,  432,  344,  153,  238,  349,  453,  362,  483,  334,
			  202,  219,  502,  523,  551,  332,  235,  234,  570,  587,
			  606,  330,  251,  305,  623,  644,  674,  327,  693,  319,
			  307,  318,  712,  733,  763,  309,    0,  287,  274,  142,
			  282,  782,  269,  241,  312,  387,  192,  126,  371,  105,
			   66,  388, 1118,  809,  821,  829,  841,  853,  865,  877,
			  889,  901,  913,  925,  937,  949,  961,  973,  985,  997,
			 1009, 1021, 1033, 1045, 1057, 1069, 1081, 1093, 1105, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  173,  173,  174,  174,  172,    5,  172,    7,  172,
			  172,  172,  175,  172,  172,  176,  177,  178,  176,   18,
			   18,  172,  179,  172,  172,  172,  179,  172,  172,  180,
			  181,  182,  180,   32,   32,  172,  175,   18,   18,  177,
			  178,   18,   18,   18,   18,  172,  179,  172,  179,  172,
			   32,  183,   32,  181,  181,  182,  182,   32,   32,   32,
			   32,  172,  176,  177,  178,   18,   18,   18,   18,  172,
			  179,  172,  183,   32,  181,  181,  182,  182,   32,   32,
			   32,   32,  172,  184,   18,   18,   18,  185,  172,  183,
			  186,  181,  182,   32,   32,   32,  187,  184,  188,  184,

			   18,   18,   18,   18,  172,  189,  186,  189,  190,  106,
			  181,  182,   32,   32,   32,   32,  188,   18,  191,   18,
			  172,  189,  190,  181,  182,   32,  192,   32,  191,  172,
			  181,  182,  193,  192,  128,  172,  181,  182,  193,  133,
			  194,  172,  181,  182,  138,  195,  194,  196,  194,  172,
			  181,  182,  197,  195,  197,  198,  153,  196,  172,  181,
			  182,  197,  198,  172,  181,  182,  172,  181,  182,  172,
			  181,  182,    0,  172,  172,  172,  172,  172,  172,  172,
			  172,  172,  172,  172,  172,  172,  172,  172,  172,  172,
			  172,  172,  172,  172,  172,  172,  172,  172,  172, yy_Dummy>>)
		end

	yy_ec_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    2,
			    3,    1,    1,    4,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    2,    5,    6,    5,    5,    5,    5,    7,
			    5,    5,    5,    5,    8,    5,    9,   10,   11,   11,
			   11,   11,   11,   11,   11,   11,   11,   11,   12,   13,
			   14,    5,   15,   16,   17,   18,   18,   18,   18,   18,
			   18,   19,   19,   19,   19,   19,   19,   19,   19,   19,
			   19,   19,   19,   19,   19,   19,   19,   19,   19,   19,
			   19,   20,   21,   22,    5,   23,   24,   25,   25,   25,

			   25,   26,   27,   28,   29,   30,   28,   28,   31,   28,
			   28,   28,   32,   28,   28,   33,   34,   28,   28,   35,
			   28,   28,   28,   36,   37,   38,    5,    1,    1,    1,
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
			    0,    1,    2,    2,    2,    1,    1,    3,    1,    4,
			    1,    1,    1,    1,    1,    1,    1,    1,    5,    6,
			    7,    1,    3,    1,    3,    5,    5,    5,    8,    5,
			    5,    5,    9,   10,   11,   12,    3,    1,    3, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,    0,    0,    0,    0,    0,    0,   22,
			    1,   20,   20,    8,    7,    8,    8,    8,    8,    8,
			    8,    8,   15,   17,   14,   16,   15,   18,   18,   15,
			   18,   18,   15,   15,   15,   18,   19,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,   15,   17,   15,    0,
			   15,    0,   15,    0,    0,    0,    0,   15,   15,   15,
			   15,    0,    0,    6,    4,    0,    0,    0,    0,    5,
			   15,    0,    0,   15,   13,    0,   11,    0,   15,   15,
			   15,   15,   12,    2,    0,    0,    0,    3,    0,    0,
			    9,    0,   11,   15,   15,   15,   10,    2,    0,    2,

			    0,    0,    0,    0,    0,    9,    9,    9,    0,    9,
			    0,    0,   15,   15,   15,   15,    2,    0,    3,    0,
			    0,    9,    9,    0,    0,   15,   10,   15,    3,    0,
			    0,    0,   10,   10,    3,    0,    0,    0,   10,   10,
			    2,    0,    0,    0,   10,    9,    2,    3,    2,    0,
			    0,    0,    9,    9,    9,   10,    9,    2,    0,    0,
			    0,    9,    9,    0,    0,    0,    0,    0,    0,   15,
			   13,   15,    0, yy_Dummy>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 1118
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 172
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 173
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

	yyNb_rules: INTEGER is 21
			-- Number of rules

	yyEnd_of_buffer: INTEGER is 22
			-- End of buffer rule code

	yyLine_used: BOOLEAN is false
			-- Are line and column numbers used?

	yyPosition_used: BOOLEAN is false
			-- Is `position' used?

	INITIAL: INTEGER is 0
	DOT_FEATURE: INTEGER is 1
	NOT_BREAK_TOKEN: INTEGER is 2
	BREAK_TOKEN: INTEGER is 3
			-- Start condition codes

feature -- User-defined features



end -- class COMMENT_SCANNER
