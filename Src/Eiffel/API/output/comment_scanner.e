indexing

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
if yy_act <= 12 then
if yy_act <= 6 then
if yy_act <= 3 then
if yy_act <= 2 then
if yy_act = 1 then
--|#line 39 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 39")
end

				if seperate_comment then
					set_start_condition (BREAK_TOKEN)
				else
					set_start_condition (NOT_BREAK_TOKEN)
				end
				less (0)
			
else
--|#line 54 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 54")
end

				append_buffer
				add_email_tokens
			
end
else
--|#line 60 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 60")
end
	
				append_buffer
				add_url_tokens				
			
end
else
if yy_act <= 5 then
if yy_act = 4 then
--|#line 66 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 66")
end

				append_buffer
				add_quote_feature
			
else
--|#line 72 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 72")
end

				append_buffer
				add_class (True)
				last_condition := NOT_BREAK_TOKEN
				set_start_condition (DOT_FEATURE)
				less (text_count - 2)
			
end
else
--|#line 80 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 80")
end

				append_buffer
				add_class (False)
			
end
end
else
if yy_act <= 9 then
if yy_act <= 8 then
if yy_act = 7 then
--|#line 86 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 86")
end

				append_buffer
				add_cluster
			
else
--|#line 91 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 91")
end

				append_buffer
				text_formatter.process_new_line
			
end
else
--|#line 96 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 96")
end

				buffer_token
			
end
else
if yy_act <= 11 then
if yy_act = 10 then
--|#line 103 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 103")
end

				add_email_tokens
			
else
--|#line 108 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 108")
end
				
				add_url_tokens				
			
end
else
--|#line 113 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 113")
end

				add_quote_feature
			
end
end
end
else
if yy_act <= 18 then
if yy_act <= 15 then
if yy_act <= 14 then
if yy_act = 13 then
--|#line 118 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 118")
end

				add_class (True)
				last_condition := BREAK_TOKEN
				set_start_condition (DOT_FEATURE)
				less (text_count - 2)
			
else
--|#line 126 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 126")
end

				add_class (False)
			
end
else
--|#line 131 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 131")
end

				add_cluster
			
end
else
if yy_act <= 17 then
if yy_act = 16 then
--|#line 135 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 135")
end

				text_formatter.process_new_line
			
else
--|#line 140 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 140")
end

				add_normal_text
			
end
else
--|#line 144 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 144")
end

			
end
end
else
if yy_act <= 21 then
if yy_act <= 20 then
if yy_act = 19 then
--|#line 147 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 147")
end

				add_normal_text
			
else
--|#line 152 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 152")
end

				add_normal_text	
			
end
else
--|#line 158 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 158")
end

				add_dot_feature
			
end
else
if yy_act = 22 then
--|#line 161 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 161")
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
			   29,   29,   29,   34,   35,   22,   28,   38,   37,   46,
			   46,   37,   44,   57,   38,   37,   45,  165,   58,   92,
			   50,   38,   38,   38,   38,   51,   63,   63,   51,   61,

			   36,   38,   51,   62,   75,   76,   64,   37,   38,   38,
			   38,   37,   36,   42,   75,  164,  113,   43,   52,   37,
			   37,   66,   53,   37,   37,  165,   37,  142,   67,   53,
			   37,   52,   75,   52,   75,   52,   53,   53,   53,   37,
			   37,  164,   51,   68,   37,   69,   51,   52,   46,   52,
			   52,   57,  132,   75,   53,   46,   46,   77,  162,   74,
			   46,   53,   51,   52,   79,   52,   51,   52,   53,   53,
			   53,   73,   51,   59,  137,   70,   51,   60,   73,   52,
			   51,   52,   75,  153,   80,   73,   73,   73,   51,   78,
			   51,   63,   51,   83,   51,   81,   87,   84,   63,   63,

			   83,   37,   85,   63,   95,   37,  160,   83,   83,   83,
			   37,   94,   86,   97,   37,   51,  163,   37,   82,   51,
			   37,   37,   51,  103,   37,   73,   51,  146,   75,   75,
			  104,   90,   73,   51,   51,   96,   97,   51,   51,   73,
			   73,   73,   91,   37,  126,  102,  157,   37,   37,   91,
			   64,  105,   37,  115,  114,  108,   91,   91,   91,   74,
			   75,   51,  108,   37,  156,   51,  100,   37,   83,  108,
			  108,  108,   51,   51,  101,   83,   51,   51,   87,  161,
			  149,  148,   83,   83,   83,  110,   75,  111,  116,   91,
			  104,  120,   75,  141,  136,  112,   91,  111,  110,  131,

			  110,  121,  110,   91,   91,   91,   51,  122,   37,  117,
			   51,   37,   37,  100,  110,   37,  110,  100,  123,   83,
			  127,   37,  128,  129,  107,   37,   83,   37,  107,   98,
			   93,   37,   75,   83,   83,   83,  100,   89,   83,   89,
			   51,  121,   51,   51,   51,   83,   51,   51,  116,   88,
			   65,   57,   83,   83,   83,  111,   75,  108,   72,  121,
			  128,   37,  128,  124,  108,   37,   51,   71,   48,   41,
			   51,  108,  108,  108,  110,   65,  111,   55,   91,   37,
			   51,   50,   51,   37,   51,   91,   51,  110,   49,  110,
			   48,  110,   91,   91,   91,   41,  166,   12,   12,  166,

			  166,  166,  166,  110,  166,  110,  111,  166,  108,  166,
			  166,  166,  166,  166,  166,  108,  166,  166,  166,  166,
			  166,  166,  108,  108,  108,   87,  166,  130,  166,  166,
			  166,  166,  166,  166,  130,  166,  166,  166,  166,  166,
			  166,  130,  130,  130,  111,  166,  108,  166,  166,  166,
			  166,  166,  166,  108,  166,  166,  166,  166,  166,  166,
			  108,  108,  108,  133,  166,   97,  166,  134,  166,  166,
			  166,  166,  166,  166,  134,  166,  133,  166,  133,  166,
			  133,  134,  134,  134,  166,  166,  166,  166,  166,  166,
			  166,  166,  133,  166,  133,   87,  166,  130,  166,  166,

			  166,  166,  166,  135,  130,  166,  166,  166,  166,  166,
			  166,  130,  130,  130,   97,  166,  138,  166,  166,  166,
			  166,  166,  166,  138,  166,  166,  166,  166,  166,  166,
			  138,  138,  138,  133,  166,   97,  166,  134,  166,  166,
			  166,  166,  166,  139,  134,  166,  133,  166,  133,  166,
			  133,  134,  134,  134,  166,  166,  166,  166,  166,  166,
			  166,  166,  133,  166,  133,  140,  166,  166,  166,  166,
			  166,  121,  140,  166,  166,  166,  166,  166,  166,  140,
			  140,  140,   97,  166,  138,  166,  166,  166,  166,  166,
			  143,  138,  166,  166,  166,  166,  166,  166,  138,  138,

			  138,  144,  166,  166,  166,  166,  166,  128,  144,  166,
			  166,  166,  166,  166,  166,  144,  144,  144,  146,  166,
			  140,  166,  166,  166,  166,  166,  147,  140,  166,  166,
			  166,  166,  166,  166,  140,  140,  140,  150,  166,  166,
			  166,  166,  166,  133,  150,  166,  166,  166,  166,  166,
			  166,  150,  150,  150,  152,  166,  153,  166,  144,  166,
			  166,  166,  166,  166,  154,  144,  166,  152,  166,  152,
			  166,  152,  144,  144,  144,  166,  166,  166,  166,  166,
			  166,  166,  166,  152,  166,  152,  146,  166,  140,  166,
			  166,  166,  166,  166,  166,  140,  166,  166,  166,  166,

			  166,  166,  140,  140,  140,  146,  166,  140,  166,  166,
			  166,  166,  166,  166,  140,  166,  166,  166,  166,  166,
			  166,  140,  140,  140,  153,  166,  150,  166,  166,  166,
			  166,  166,  158,  150,  166,  166,  166,  166,  166,  166,
			  150,  150,  150,  152,  166,  153,  166,  144,  166,  166,
			  166,  166,  166,  166,  144,  166,  152,  166,  152,  166,
			  152,  144,  144,  144,  166,  166,  166,  166,  166,  166,
			  166,  166,  152,  166,  152,  153,  166,  150,  166,  166,
			  166,  166,  166,  166,  150,  166,  166,  166,  166,  166,
			  166,  150,  150,  150,  153,  166,  150,  166,  166,  166,

			  166,  166,  166,  150,  166,  166,  166,  166,  166,  166,
			  150,  150,  150,   10,   10,   10,   10,   10,   10,   10,
			   10,   10,   10,   10,   10,   10,   10,   11,   11,   11,
			   11,   11,   11,   11,   11,   11,   11,   11,   11,   11,
			   11,   36,   36,  166,  166,   36,   36,   36,   36,   36,
			   37,  166,   37,  166,   37,   37,   37,   37,   37,   37,
			   37,   37,   37,   37,   39,  166,   39,   39,   39,   39,
			   39,   39,   39,   39,   39,   39,   39,   39,   40,   40,
			   40,   40,   40,   40,   40,  166,   40,   40,   40,   40,
			   40,   40,   47,  166,  166,  166,   47,   47,  166,  166,

			   47,   47,   47,   47,   47,   51,  166,   51,  166,   51,
			   51,   51,   51,   51,   51,   51,   51,   51,   51,   54,
			  166,   54,   54,   54,   54,   54,   54,   54,   54,   54,
			   54,   54,   54,   56,   56,   56,   56,   56,   56,   56,
			  166,   56,   56,   56,   56,   56,   56,   52,  166,   52,
			  166,   52,   52,   52,   52,   52,   52,   52,   52,   52,
			   52,   99,  166,   99,   99,   99,   99,   99,   99,   99,
			   99,   99,   99,   99,   99,   87,  166,   87,   87,   87,
			   87,   87,   87,   87,   87,   87,   87,   87,   87,  106,
			  166,  166,  166,  106,  106,  166,  166,  106,  106,  106,

			  106,  106,  109,  166,  109,  109,  109,  109,  109,  109,
			  109,  109,  109,  109,  109,  109,   97,  166,   97,   97,
			   97,   97,   97,   97,   97,   97,   97,   97,   97,   97,
			  118,  166,  166,  166,  118,  118,  166,  166,  118,  118,
			  118,  118,  118,  119,  166,  119,  166,  119,  119,  119,
			  119,  119,  119,  119,  119,  119,  119,  110,  166,  110,
			  110,  110,  110,  110,  110,  110,  110,  110,  110,  110,
			  110,  125,  166,  125,  166,  125,  125,  125,  125,  125,
			  125,  125,  125,  125,  125,  121,  166,  121,  121,  121,
			  121,  121,  121,  121,  121,  121,  121,  121,  121,  128,

			  166,  128,  128,  128,  128,  128,  128,  128,  128,  128,
			  128,  128,  128,  133,  166,  133,  133,  133,  133,  133,
			  133,  133,  133,  133,  133,  133,  133,  145,  166,  145,
			  145,  145,  145,  145,  145,  145,  145,  145,  145,  145,
			  145,  151,  166,  151,  151,  151,  151,  151,  151,  151,
			  151,  151,  151,  151,  151,  155,  166,  155,  155,  155,
			  155,  155,  155,  155,  155,  155,  155,  155,  155,  152,
			  166,  152,  152,  152,  152,  152,  152,  152,  152,  152,
			  152,  152,  152,  159,  166,  159,  159,  159,  159,  159,
			  159,  159,  159,  159,  159,  159,  159,    9,  166,  166,

			  166,  166,  166,  166,  166,  166,  166,  166,  166,  166,
			  166,  166,  166,  166,  166,  166,  166,  166,  166,  166,
			  166,  166,  166,  166,  166,  166,  166,  166,  166,  166,
			  166,  166,  166,  166,  166,  166, yy_Dummy>>)
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
			   21,   20,   19,   31,   15,   20,   20,  165,   31,   76,
			   35,   15,   15,   15,   18,   33,   35,   35,   34,   33,

			   36,   18,   34,   34,   76,   55,   38,   37,   18,   18,
			   18,   37,   36,   18,   55,  164,   92,   18,   29,   38,
			   42,   42,   29,   38,   42,  163,   43,  137,   43,   29,
			   43,   29,   92,   29,  137,   29,   29,   29,   29,   44,
			   45,  162,   51,   44,   45,   45,   51,   29,   46,   29,
			   32,   58,  126,  126,   32,   46,   46,   58,  160,   53,
			   46,   32,   60,   32,   60,   32,   60,   32,   32,   32,
			   32,   52,   53,   32,  132,   46,   53,   32,   52,   32,
			   61,   32,  132,  159,   61,   52,   52,   52,   59,   59,
			   62,   63,   59,   64,   62,   62,   69,   66,   63,   63,

			   64,   66,   67,   63,   79,   66,  156,   64,   64,   64,
			   68,   78,   68,   81,   68,   78,  161,   69,   63,   78,
			   67,   69,   79,   85,   67,   73,   79,  155,  161,  113,
			   86,   73,   73,   80,   81,   80,  153,   80,   81,   73,
			   73,   73,   74,   85,  113,   84,  149,   85,   86,   74,
			   84,   86,   86,   95,   94,   90,   74,   74,   74,   94,
			  149,   74,   90,   84,  148,   74,   83,   84,   83,   90,
			   90,   90,   94,   95,   83,   83,   94,   95,  146,  157,
			  142,  141,   83,   83,   83,   91,  142,   91,   96,   91,
			  105,  102,  157,  136,  131,   91,   91,  125,   91,  123,

			   91,  103,   91,   91,   91,   91,   96,  104,  105,   96,
			   96,  102,  105,  119,   91,  102,   91,   99,  107,   99,
			  114,  103,  115,  116,   93,  103,   99,  104,   89,   82,
			   77,  104,   75,   99,   99,   99,  101,   72,  101,   71,
			  114,  120,  115,  116,  114,  101,  115,  116,  117,   70,
			   65,   56,  101,  101,  101,  108,   54,  108,   50,  122,
			  127,  120,  129,  108,  108,  120,  117,   49,   48,   40,
			  117,  108,  108,  108,  109,   39,  109,   30,  109,  122,
			  127,   28,  129,  122,  127,  109,  129,  109,   26,  109,
			   23,  109,  109,  109,  109,   17,    9,    4,    3,    0,

			    0,    0,    0,  109,    0,  109,  110,    0,  110,    0,
			    0,    0,    0,    0,    0,  110,    0,    0,    0,    0,
			    0,    0,  110,  110,  110,  121,    0,  121,    0,    0,
			    0,    0,    0,    0,  121,    0,    0,    0,    0,    0,
			    0,  121,  121,  121,  124,    0,  124,    0,    0,    0,
			    0,    0,    0,  124,    0,    0,    0,    0,    0,    0,
			  124,  124,  124,  128,    0,  128,    0,  128,    0,    0,
			    0,    0,    0,    0,  128,    0,  128,    0,  128,    0,
			  128,  128,  128,  128,    0,    0,    0,    0,    0,    0,
			    0,    0,  128,    0,  128,  130,    0,  130,    0,    0,

			    0,    0,    0,  130,  130,    0,    0,    0,    0,    0,
			    0,  130,  130,  130,  133,    0,  133,    0,    0,    0,
			    0,    0,    0,  133,    0,    0,    0,    0,    0,    0,
			  133,  133,  133,  134,    0,  134,    0,  134,    0,    0,
			    0,    0,    0,  134,  134,    0,  134,    0,  134,    0,
			  134,  134,  134,  134,    0,    0,    0,    0,    0,    0,
			    0,    0,  134,    0,  134,  135,    0,    0,    0,    0,
			    0,  135,  135,    0,    0,    0,    0,    0,    0,  135,
			  135,  135,  138,    0,  138,    0,    0,    0,    0,    0,
			  138,  138,    0,    0,    0,    0,    0,    0,  138,  138,

			  138,  139,    0,    0,    0,    0,    0,  139,  139,    0,
			    0,    0,    0,    0,    0,  139,  139,  139,  140,    0,
			  140,    0,    0,    0,    0,    0,  140,  140,    0,    0,
			    0,    0,    0,    0,  140,  140,  140,  143,    0,    0,
			    0,    0,    0,  143,  143,    0,    0,    0,    0,    0,
			    0,  143,  143,  143,  144,    0,  144,    0,  144,    0,
			    0,    0,    0,    0,  144,  144,    0,  144,    0,  144,
			    0,  144,  144,  144,  144,    0,    0,    0,    0,    0,
			    0,    0,    0,  144,    0,  144,  145,    0,  145,    0,
			    0,    0,    0,    0,    0,  145,    0,    0,    0,    0,

			    0,    0,  145,  145,  145,  147,    0,  147,    0,    0,
			    0,    0,    0,    0,  147,    0,    0,    0,    0,    0,
			    0,  147,  147,  147,  150,    0,  150,    0,    0,    0,
			    0,    0,  150,  150,    0,    0,    0,    0,    0,    0,
			  150,  150,  150,  151,    0,  151,    0,  151,    0,    0,
			    0,    0,    0,    0,  151,    0,  151,    0,  151,    0,
			  151,  151,  151,  151,    0,    0,    0,    0,    0,    0,
			    0,    0,  151,    0,  151,  152,    0,  152,    0,    0,
			    0,    0,    0,    0,  152,    0,    0,    0,    0,    0,
			    0,  152,  152,  152,  158,    0,  158,    0,    0,    0,

			    0,    0,    0,  158,    0,    0,    0,    0,    0,    0,
			  158,  158,  158,  167,  167,  167,  167,  167,  167,  167,
			  167,  167,  167,  167,  167,  167,  167,  168,  168,  168,
			  168,  168,  168,  168,  168,  168,  168,  168,  168,  168,
			  168,  169,  169,    0,    0,  169,  169,  169,  169,  169,
			  170,    0,  170,    0,  170,  170,  170,  170,  170,  170,
			  170,  170,  170,  170,  171,    0,  171,  171,  171,  171,
			  171,  171,  171,  171,  171,  171,  171,  171,  172,  172,
			  172,  172,  172,  172,  172,    0,  172,  172,  172,  172,
			  172,  172,  173,    0,    0,    0,  173,  173,    0,    0,

			  173,  173,  173,  173,  173,  174,    0,  174,    0,  174,
			  174,  174,  174,  174,  174,  174,  174,  174,  174,  175,
			    0,  175,  175,  175,  175,  175,  175,  175,  175,  175,
			  175,  175,  175,  176,  176,  176,  176,  176,  176,  176,
			    0,  176,  176,  176,  176,  176,  176,  177,    0,  177,
			    0,  177,  177,  177,  177,  177,  177,  177,  177,  177,
			  177,  178,    0,  178,  178,  178,  178,  178,  178,  178,
			  178,  178,  178,  178,  178,  179,    0,  179,  179,  179,
			  179,  179,  179,  179,  179,  179,  179,  179,  179,  180,
			    0,    0,    0,  180,  180,    0,    0,  180,  180,  180,

			  180,  180,  181,    0,  181,  181,  181,  181,  181,  181,
			  181,  181,  181,  181,  181,  181,  182,    0,  182,  182,
			  182,  182,  182,  182,  182,  182,  182,  182,  182,  182,
			  183,    0,    0,    0,  183,  183,    0,    0,  183,  183,
			  183,  183,  183,  184,    0,  184,    0,  184,  184,  184,
			  184,  184,  184,  184,  184,  184,  184,  185,    0,  185,
			  185,  185,  185,  185,  185,  185,  185,  185,  185,  185,
			  185,  186,    0,  186,    0,  186,  186,  186,  186,  186,
			  186,  186,  186,  186,  186,  187,    0,  187,  187,  187,
			  187,  187,  187,  187,  187,  187,  187,  187,  187,  188,

			    0,  188,  188,  188,  188,  188,  188,  188,  188,  188,
			  188,  188,  188,  189,    0,  189,  189,  189,  189,  189,
			  189,  189,  189,  189,  189,  189,  189,  190,    0,  190,
			  190,  190,  190,  190,  190,  190,  190,  190,  190,  190,
			  190,  191,    0,  191,  191,  191,  191,  191,  191,  191,
			  191,  191,  191,  191,  191,  192,    0,  192,  192,  192,
			  192,  192,  192,  192,  192,  192,  192,  192,  192,  193,
			    0,  193,  193,  193,  193,  193,  193,  193,  193,  193,
			  193,  193,  193,  194,    0,  194,  194,  194,  194,  194,
			  194,  194,  194,  194,  194,  194,  194,  166,  166,  166,

			  166,  166,  166,  166,  166,  166,  166,  166,  166,  166,
			  166,  166,  166,  166,  166,  166,  166,  166,  166,  166,
			  166,  166,  166,  166,  166,  166,  166,  166,  166,  166,
			  166,  166,  166,  166,  166,  166, yy_Dummy>>)
		end

	yy_base_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,  389,  388,    0,    0,   38,    0,  396,
			 1197, 1197,    0, 1197, 1197,   66,    0,  388,   83,   48,
			   51,   61,    0,  388, 1197, 1197,  376, 1197,  369,  111,
			  365,   76,  143,   65,   68,   78,   89,   77,   89,  353,
			  362, 1197,   90,   96,  109,  110,  137,    0,  366,  354,
			  345,  112,  160,  142,  334,   92,  344, 1197,  144,  158,
			  132,  150,  160,  180,  182,  328,  171,  190,  180,  187,
			  340,  332,  330,  214,  231,  310,   82,  323,  185,  192,
			  203,  204,  320,  257,  233,  213,  218,    0,    0,  322,
			  244,  278,  110,  318,  242,  243,  276,    0,    0,  308,

			    0,  327,  281,  291,  297,  278, 1197,  281,  346,  367,
			  397,    0,    0,  207,  310,  312,  313,  336, 1197,  304,
			  331,  416,  349,  278,  435,  288,  131,  350,  456,  352,
			  486,  280,  160,  505,  526,  554,  278,  112,  573,  590,
			  609,  265,  264,  626,  647,  677,  269,  696,  256,  238,
			  715,  736,  766,  227,    0,  218,  197,  270,  785,  174,
			  148,  206,  119,  103,   93,   65, 1197,  812,  826,  836,
			  849,  863,  877,  891,  904,  918,  932,  946,  960,  974,
			  988, 1001, 1015, 1029, 1042, 1056, 1070, 1084, 1098, 1112,
			 1126, 1140, 1154, 1168, 1182, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  167,  167,  168,  168,  166,    5,  166,    7,  166,
			  166,  166,  169,  166,  166,  170,  171,  172,  170,   18,
			   18,  166,  173,  166,  166,  166,  173,  166,  166,  174,
			  175,  176,  174,   32,   32,  166,  169,   18,   18,  171,
			  172,  166,   18,   18,   18,   18,  166,  173,  166,  173,
			  166,   32,  177,   32,  175,  175,  176,  166,  176,   32,
			   32,   32,   32,  166,  170,  171,   18,   18,   18,   18,
			  166,  173,  166,  177,   32,  175,  175,  176,   32,   32,
			   32,   32,  166,  178,   18,   18,   18,  179,  180,  166,
			  177,  181,  175,  166,   32,   32,   32,  182,  183,  178,

			  184,  178,   18,   18,   18,   18,  166,  166,  185,  181,
			  185,  186,  109,  175,   32,   32,   32,   32,  166,  184,
			   18,  187,   18,  166,  185,  186,  175,   32,  188,   32,
			  187,  166,  175,  189,  188,  130,  166,  175,  189,  134,
			  190,  166,  175,  138,  191,  190,  192,  190,  166,  175,
			  193,  191,  193,  194,  151,  192,  166,  175,  193,  194,
			  166,  175,  166,  175,  166,  175,    0,  166,  166,  166,
			  166,  166,  166,  166,  166,  166,  166,  166,  166,  166,
			  166,  166,  166,  166,  166,  166,  166,  166,  166,  166,
			  166,  166,  166,  166,  166, yy_Dummy>>)
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
			    7,    1,    3,    1,    8,    5,    5,    5,    9,    5,
			    5,    5,   10,   11,   12,   13,   14,    1,    3, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,    0,    0,    0,    0,    0,    0,   24,
			    1,   22,   22,    9,    8,    9,    9,    9,    9,    9,
			    9,    9,   17,   19,   16,   18,   17,   20,   20,   17,
			   20,   20,   17,   17,   17,   20,   21,    0,    0,    0,
			    0,    4,    0,    0,    0,    0,    0,   17,   19,   17,
			    0,   17,    0,   17,    0,    0,    0,   12,    0,   17,
			   17,   17,   17,    0,    0,    7,    0,    0,    0,    0,
			    6,   17,    0,    0,   17,   15,    0,    0,   17,   17,
			   17,   17,   14,    2,    0,    0,    0,    3,    0,    0,
			    0,   10,    0,   12,   17,   17,   17,   11,    0,    2,

			    0,    2,    0,    0,    0,    0,    5,    0,   10,   10,
			   10,    0,   10,    0,   17,   17,   17,   17,   13,    2,
			    0,    3,    0,    0,   10,   10,    0,   17,   11,   17,
			    3,    0,    0,   11,   11,    3,    0,    0,   11,   11,
			    2,    0,    0,   11,   10,    2,    3,    2,    0,    0,
			   10,   10,   10,   11,   10,    2,    0,    0,   10,   10,
			    0,    0,    0,    0,   17,   15,    0, yy_Dummy>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 1197
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 166
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 167
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

	yyNb_rules: INTEGER is 23
			-- Number of rules

	yyEnd_of_buffer: INTEGER is 24
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



indexing
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
