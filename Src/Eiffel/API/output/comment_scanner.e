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
				add_class (True)
				last_condition := NOT_BREAK_TOKEN
				set_start_condition (DOT_FEATURE)
				less (text_count - 2)
			
end
else
--|#line 79 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 79")
end

				append_buffer
				add_class (False)
			
end
end
else
if yy_act <= 9 then
if yy_act <= 8 then
if yy_act = 7 then
--|#line 85 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 85")
end

				append_buffer
				add_cluster
			
else
--|#line 90 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 90")
end

				append_buffer
				text_formatter.process_new_line
			
end
else
--|#line 95 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 95")
end

				buffer_token
			
end
else
if yy_act <= 11 then
if yy_act = 10 then
--|#line 102 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 102")
end

				add_email_tokens
			
else
--|#line 107 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 107")
end
				
				add_url_tokens				
			
end
else
--|#line 112 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 112")
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
--|#line 117 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 117")
end

				add_class (True)
				last_condition := BREAK_TOKEN
				set_start_condition (DOT_FEATURE)
				less (text_count - 2)
			
else
--|#line 125 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 125")
end

				add_class (False)
			
end
else
--|#line 130 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 130")
end

				add_cluster
			
end
else
if yy_act <= 17 then
if yy_act = 16 then
--|#line 134 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 134")
end

				text_formatter.process_new_line
			
else
--|#line 139 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 139")
end

				add_normal_text
			
end
else
--|#line 143 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 143")
end

			
end
end
else
if yy_act <= 21 then
if yy_act <= 20 then
if yy_act = 19 then
--|#line 146 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 146")
end

				add_normal_text
			
else
--|#line 151 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 151")
end

				add_normal_text	
			
end
else
--|#line 157 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 157")
end

				add_dot_feature
			
end
else
if yy_act = 22 then
--|#line 160 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 160")
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
			    0,  166,  166,   14,  166,  166,  166,   57,   57,   97,
			  166,   36,   58,   76,   77,   95,  166,   74,   15,   16,
			   74,   75,   36,   17,   15,   18,   19,   15,   15,   15,
			   15,   15,   20,   21,   14,   38,   38,   74,   59,   44,
			   38,   45,   60,   38,   74,  132,   75,   38,   78,   15,
			   16,   94,  165,  164,   17,   15,   18,   19,   15,   15,
			   15,   15,   15,   20,   21,   22,   23,   24,   25,   26,
			   22,   27,   26,   28,   26,   26,   26,   26,   26,   22,
			   22,   26,   29,   30,   22,   27,   26,   31,   29,   32,
			   33,   29,   29,   29,   29,   29,   34,   35,   22,   28,

			   38,   46,  165,  114,  116,  164,  162,   38,   74,   74,
			   74,   74,   46,   38,   38,   38,   38,   38,   38,   38,
			   38,   38,   38,   79,   80,   70,  137,  153,  152,   38,
			   74,  160,   92,   75,   75,   38,   38,   38,   42,   38,
			   38,   38,   43,   38,   51,   81,   75,  126,   51,   51,
			   52,   51,  146,   51,   53,   51,   51,   51,   51,   51,
			   51,   53,   52,   51,   52,   51,   52,   53,   53,   53,
			   53,   53,   53,   53,   53,   53,   52,   51,   52,   64,
			   64,  142,   64,  151,   97,   64,  152,   75,   64,   38,
			   38,   66,   38,   38,   38,   38,   68,   67,   38,   38,

			   64,   74,   38,   69,   73,   63,  166,   84,  151,  156,
			   38,   73,  113,   96,   38,  145,   63,   73,   73,   73,
			   73,   73,   73,   73,   73,   73,   64,   75,  149,   82,
			   83,   87,  145,   75,  148,  141,   38,   83,   86,  139,
			   38,  161,  103,   83,   83,   83,   83,   83,   83,   83,
			   83,   83,   85,   75,   87,  102,  157,   64,  136,   38,
			   64,  116,   64,   38,  120,  121,   74,   38,  128,   75,
			   38,   38,   38,  128,   38,  111,   38,   73,  163,  117,
			  110,   38,   38,   90,   73,   38,   38,  122,  121,   75,
			   73,   73,   73,   73,   73,   73,   73,   73,   73,   91,

			  131,  100,  129,  128,   38,   38,   91,  127,   38,   38,
			  109,  110,   91,   91,   91,   91,   91,   91,   91,   91,
			   91,   99,  109,  123,   99,   99,   99,   99,   99,  100,
			   99,   83,   99,   99,   99,   99,   99,  101,   83,   99,
			   99,   99,   99,   99,   83,   83,   83,   83,   83,   83,
			   83,   83,   83,   99,   99,   99,  104,   99,  104,  115,
			  107,   64,  107,   64,  121,   98,   93,   75,   89,   89,
			   88,   38,   65,   38,  105,   38,  108,   38,   57,   75,
			   74,   38,   72,  108,   71,   38,   48,   41,   65,  108,
			  108,  108,  108,  108,  108,  108,  108,  108,  109,   50,

			   62,   61,  109,  109,  110,  109,  111,  109,   91,  109,
			  109,  109,  109,  109,  112,   91,  110,  109,  110,  109,
			  110,   91,   91,   91,   91,   91,   91,   91,   91,   91,
			  110,  109,  110,  110,   55,   50,   49,  110,  110,  110,
			  110,  111,  110,  108,  110,  110,  110,  110,  110,  124,
			  108,  110,  110,  110,  110,  110,  108,  108,  108,  108,
			  108,  108,  108,  108,  108,  110,  110,  110,   87,   48,
			  130,   41,  166,   12,   12,  166,  166,  130,  166,  166,
			  166,  166,  166,  130,  130,  130,  130,  130,  130,  130,
			  130,  130,  128,  166,  166,  166,  128,  128,  133,  128,

			   97,  128,  134,  128,  128,  128,  128,  128,  128,  134,
			  133,  128,  133,  128,  133,  134,  134,  134,  134,  134,
			  134,  134,  134,  134,  133,  128,  133,   87,  166,  130,
			  166,  166,  166,  166,  166,  135,  130,  166,  166,  166,
			  166,  166,  130,  130,  130,  130,  130,  130,  130,  130,
			  130,   97,  166,  138,  166,  166,  166,  166,  166,  166,
			  138,  166,  166,  166,  166,  166,  138,  138,  138,  138,
			  138,  138,  138,  138,  138,  140,  166,  166,  166,  166,
			  166,  121,  140,  166,  166,  166,  166,  166,  140,  140,
			  140,  140,  140,  140,  140,  140,  140,   97,  166,  138,

			  166,  166,  166,  166,  166,  143,  138,  166,  166,  166,
			  166,  166,  138,  138,  138,  138,  138,  138,  138,  138,
			  138,  144,  166,  166,  166,  166,  166,  166,  144,  166,
			  166,  166,  166,  166,  144,  144,  144,  144,  144,  144,
			  144,  144,  144,  145,  166,  166,  166,  145,  145,  145,
			  145,  146,  145,  140,  145,  145,  145,  145,  145,  147,
			  140,  145,  145,  145,  145,  145,  140,  140,  140,  140,
			  140,  140,  140,  140,  140,  145,  145,  145,  150,  166,
			  166,  166,  166,  166,  133,  150,  166,  166,  166,  166,
			  166,  150,  150,  150,  150,  150,  150,  150,  150,  150,

			  151,  166,  166,  166,  151,  151,  152,  151,  153,  151,
			  144,  151,  151,  151,  151,  151,  154,  144,  152,  151,
			  152,  151,  152,  144,  144,  144,  144,  144,  144,  144,
			  144,  144,  152,  151,  152,  152,  166,  166,  166,  152,
			  152,  152,  152,  153,  152,  150,  152,  152,  152,  152,
			  152,  158,  150,  152,  152,  152,  152,  152,  150,  150,
			  150,  150,  150,  150,  150,  150,  150,  152,  152,  152,
			   10,   10,   10,   10,   10,   10,   10,   10,   10,   10,
			   10,   10,   10,   10,   11,   11,   11,   11,   11,   11,
			   11,   11,   11,   11,   11,   11,   11,   11,   13,   13,

			   13,   13,   13,   13,   13,   13,   13,   13,   13,   13,
			   13,   13,   36,  166,  166,   36,   36,   36,   36,   36,
			   37,  166,   37,  166,   37,   37,   37,   37,   37,   37,
			   37,   37,   37,   37,   39,  166,   39,   39,   39,   39,
			   39,   39,   39,   39,   39,   39,   39,   39,   40,   40,
			   40,   40,   40,   40,   40,  166,   40,   40,   40,   40,
			   40,   40,   46,  166,  166,   46,   46,   46,   46,   46,
			   47,  166,  166,  166,   47,   47,  166,  166,   47,   47,
			   47,   47,   47,   54,  166,   54,   54,   54,   54,   54,
			   54,   54,   54,   54,   54,   54,   54,   56,   56,   56,

			   56,   56,   56,   56,  166,   56,   56,   56,   56,   56,
			   56,   63,   63,  166,  166,   63,   63,   63,   63,   63,
			   52,  166,   52,  166,   52,   52,   52,   52,   52,   52,
			   52,   52,   52,   52,   87,  166,   87,   87,   87,   87,
			   87,   87,   87,   87,   87,   87,   87,   87,  106,  166,
			  166,  166,  106,  106,  166,  166,  106,  106,  106,  106,
			  106,   97,  166,   97,   97,   97,   97,   97,   97,   97,
			   97,   97,   97,   97,   97,  118,  166,  166,  166,  118,
			  118,  166,  166,  118,  118,  118,  118,  118,  119,  166,
			  119,  166,  119,  119,  119,  119,  119,  119,  119,  119,

			  119,  119,  125,  166,  125,  166,  125,  125,  125,  125,
			  125,  125,  125,  125,  125,  125,  121,  166,  121,  121,
			  121,  121,  121,  121,  121,  121,  121,  121,  121,  121,
			  133,  166,  133,  133,  133,  133,  133,  133,  133,  133,
			  133,  133,  133,  133,  155,  166,  155,  155,  155,  155,
			  155,  155,  155,  155,  155,  155,  155,  155,  159,  166,
			  159,  159,  159,  159,  159,  159,  159,  159,  159,  159,
			  159,  159,    9,  166,  166,  166,  166,  166,  166,  166,
			  166,  166,  166,  166,  166,  166,  166,  166,  166,  166,
			  166,  166,  166,  166,  166,  166,  166,  166,  166,  166,

			  166,  166,  166,  166,  166,  166,  166,  166, yy_Dummy>>)
		end

	yy_chk_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,    5,    0,    0,    0,   31,   58,   81,
			    0,   36,   31,   55,   58,   79,    0,   81,    5,    5,
			   79,   55,   36,    5,    5,    5,    5,    5,    5,    5,
			    5,    5,    5,    5,    6,   19,   20,   59,   32,   19,
			   20,   20,   32,   37,   78,  126,  126,   37,   59,    6,
			    6,   78,  165,  164,    6,    6,    6,    6,    6,    6,
			    6,    6,    6,    6,    6,    7,    7,    7,    7,    7,
			    7,    7,    7,    7,    7,    7,    7,    7,    7,    7,
			    7,    7,    7,    7,    7,    7,    7,    7,    7,    7,
			    7,    7,    7,    7,    7,    7,    7,    7,    7,    7,

			   15,   46,  163,   94,  117,  162,  160,   15,   94,  117,
			   61,   60,   46,   15,   15,   15,   15,   15,   15,   15,
			   15,   15,   18,   60,   61,   46,  132,  159,  158,   18,
			   62,  156,   76,  132,  113,   18,   18,   18,   18,   18,
			   18,   18,   18,   18,   29,   62,   76,  113,   29,   29,
			   29,   29,  155,   29,   29,   29,   29,   29,   29,   29,
			   29,   29,   29,   29,   29,   29,   29,   29,   29,   29,
			   29,   29,   29,   29,   29,   29,   29,   29,   29,   38,
			   42,  137,   44,  154,  153,   43,  152,  137,   45,   38,
			   42,   42,   44,   38,   42,   43,   44,   43,   45,   43,

			   66,   80,   45,   45,   52,   63,   63,   66,  151,  148,
			   66,   52,   92,   80,   66,  147,   63,   52,   52,   52,
			   52,   52,   52,   52,   52,   52,   68,   92,  142,   63,
			   64,  146,  145,  142,  141,  136,   68,   64,   68,  134,
			   68,  157,   85,   64,   64,   64,   64,   64,   64,   64,
			   64,   64,   67,  157,   69,   84,  149,   67,  131,   85,
			   84,   96,   69,   85,  102,  103,   96,   67,  129,  149,
			   84,   67,   69,  127,   84,  125,   69,   73,  161,   96,
			  124,  102,  103,   73,   73,  102,  103,  104,  120,  161,
			   73,   73,   73,   73,   73,   73,   73,   73,   73,   74,

			  123,  119,  116,  115,  104,  120,   74,  114,  104,  120,
			  112,  110,   74,   74,   74,   74,   74,   74,   74,   74,
			   74,   83,  109,  107,  101,   83,   83,   83,   83,   83,
			   83,   83,   83,   83,   83,   83,   83,   83,   83,   83,
			   83,   83,   83,   83,   83,   83,   83,   83,   83,   83,
			   83,   83,   83,   83,   83,   83,   86,   99,  105,   95,
			   93,   86,   89,  105,  122,   82,   77,   75,   72,   71,
			   70,   86,   65,  105,   86,   86,   90,  105,   56,   54,
			   53,  122,   50,   90,   49,  122,   48,   40,   39,   90,
			   90,   90,   90,   90,   90,   90,   90,   90,   91,   35,

			   34,   33,   91,   91,   91,   91,   91,   91,   91,   91,
			   91,   91,   91,   91,   91,   91,   91,   91,   91,   91,
			   91,   91,   91,   91,   91,   91,   91,   91,   91,   91,
			   91,   91,   91,  108,   30,   28,   26,  108,  108,  108,
			  108,  108,  108,  108,  108,  108,  108,  108,  108,  108,
			  108,  108,  108,  108,  108,  108,  108,  108,  108,  108,
			  108,  108,  108,  108,  108,  108,  108,  108,  121,   23,
			  121,   17,    9,    4,    3,    0,    0,  121,    0,    0,
			    0,    0,    0,  121,  121,  121,  121,  121,  121,  121,
			  121,  121,  128,    0,    0,    0,  128,  128,  128,  128,

			  128,  128,  128,  128,  128,  128,  128,  128,  128,  128,
			  128,  128,  128,  128,  128,  128,  128,  128,  128,  128,
			  128,  128,  128,  128,  128,  128,  128,  130,    0,  130,
			    0,    0,    0,    0,    0,  130,  130,    0,    0,    0,
			    0,    0,  130,  130,  130,  130,  130,  130,  130,  130,
			  130,  133,    0,  133,    0,    0,    0,    0,    0,    0,
			  133,    0,    0,    0,    0,    0,  133,  133,  133,  133,
			  133,  133,  133,  133,  133,  135,    0,    0,    0,    0,
			    0,  135,  135,    0,    0,    0,    0,    0,  135,  135,
			  135,  135,  135,  135,  135,  135,  135,  138,    0,  138,

			    0,    0,    0,    0,    0,  138,  138,    0,    0,    0,
			    0,    0,  138,  138,  138,  138,  138,  138,  138,  138,
			  138,  139,    0,    0,    0,    0,    0,    0,  139,    0,
			    0,    0,    0,    0,  139,  139,  139,  139,  139,  139,
			  139,  139,  139,  140,    0,    0,    0,  140,  140,  140,
			  140,  140,  140,  140,  140,  140,  140,  140,  140,  140,
			  140,  140,  140,  140,  140,  140,  140,  140,  140,  140,
			  140,  140,  140,  140,  140,  140,  140,  140,  143,    0,
			    0,    0,    0,    0,  143,  143,    0,    0,    0,    0,
			    0,  143,  143,  143,  143,  143,  143,  143,  143,  143,

			  144,    0,    0,    0,  144,  144,  144,  144,  144,  144,
			  144,  144,  144,  144,  144,  144,  144,  144,  144,  144,
			  144,  144,  144,  144,  144,  144,  144,  144,  144,  144,
			  144,  144,  144,  144,  144,  150,    0,    0,    0,  150,
			  150,  150,  150,  150,  150,  150,  150,  150,  150,  150,
			  150,  150,  150,  150,  150,  150,  150,  150,  150,  150,
			  150,  150,  150,  150,  150,  150,  150,  150,  150,  150,
			  167,  167,  167,  167,  167,  167,  167,  167,  167,  167,
			  167,  167,  167,  167,  168,  168,  168,  168,  168,  168,
			  168,  168,  168,  168,  168,  168,  168,  168,  169,  169,

			  169,  169,  169,  169,  169,  169,  169,  169,  169,  169,
			  169,  169,  170,    0,    0,  170,  170,  170,  170,  170,
			  171,    0,  171,    0,  171,  171,  171,  171,  171,  171,
			  171,  171,  171,  171,  172,    0,  172,  172,  172,  172,
			  172,  172,  172,  172,  172,  172,  172,  172,  173,  173,
			  173,  173,  173,  173,  173,    0,  173,  173,  173,  173,
			  173,  173,  174,    0,    0,  174,  174,  174,  174,  174,
			  175,    0,    0,    0,  175,  175,    0,    0,  175,  175,
			  175,  175,  175,  176,    0,  176,  176,  176,  176,  176,
			  176,  176,  176,  176,  176,  176,  176,  177,  177,  177,

			  177,  177,  177,  177,    0,  177,  177,  177,  177,  177,
			  177,  178,  178,    0,    0,  178,  178,  178,  178,  178,
			  179,    0,  179,    0,  179,  179,  179,  179,  179,  179,
			  179,  179,  179,  179,  180,    0,  180,  180,  180,  180,
			  180,  180,  180,  180,  180,  180,  180,  180,  181,    0,
			    0,    0,  181,  181,    0,    0,  181,  181,  181,  181,
			  181,  182,    0,  182,  182,  182,  182,  182,  182,  182,
			  182,  182,  182,  182,  182,  183,    0,    0,    0,  183,
			  183,    0,    0,  183,  183,  183,  183,  183,  184,    0,
			  184,    0,  184,  184,  184,  184,  184,  184,  184,  184,

			  184,  184,  185,    0,  185,    0,  185,  185,  185,  185,
			  185,  185,  185,  185,  185,  185,  186,    0,  186,  186,
			  186,  186,  186,  186,  186,  186,  186,  186,  186,  186,
			  187,    0,  187,  187,  187,  187,  187,  187,  187,  187,
			  187,  187,  187,  187,  188,    0,  188,  188,  188,  188,
			  188,  188,  188,  188,  188,  188,  188,  188,  189,    0,
			  189,  189,  189,  189,  189,  189,  189,  189,  189,  189,
			  189,  189,  166,  166,  166,  166,  166,  166,  166,  166,
			  166,  166,  166,  166,  166,  166,  166,  166,  166,  166,
			  166,  166,  166,  166,  166,  166,  166,  166,  166,  166,

			  166,  166,  166,  166,  166,  166,  166,  166, yy_Dummy>>)
		end

	yy_base_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,  465,  464,    0,   31,   64,    0,  472,
			 1072, 1072,    0, 1072, 1072,   89,    0,  464,  111,    8,
			    9,    0,    0,  467, 1072, 1072,  424, 1072,  423,  143,
			  422,    0,   11,  370,  368,  387,    0,   16,  162,  367,
			  380, 1072,  163,  168,  165,  171,   90,    0,  384,  371,
			  369,    0,  193,  363,  358,    0,  371, 1072,    1,   20,
			   94,   93,  113,  194,  219,  351,  183,  240,  209,  245,
			  361,  362,  361,  266,  288,  346,  125,  359,   27,    3,
			  184,    0,  356,  320,  243,  232,  344,    0,    0,  356,
			  365,  397,  206,  354,   91,  349,  249,    0,    0,  340,

			    0,  307,  254,  255,  277,  346, 1072,  289,  432,  305,
			  294,    0,  293,  113,  297,  293,  292,   92, 1072,  292,
			  278,  459,  354,  280,  263,  266,   25,  263,  491,  258,
			  518,  244,  112,  542,  222,  564,  220,  166,  588,  610,
			  642,  218,  212,  667,  699,  215,  222,  198,  201,  248,
			  734,  191,  169,  175,  166,  143,  122,  232,  111,  118,
			   96,  268,   84,   81,   32,   31, 1072,  769,  783,  797,
			  806,  819,  833,  847,  856,  869,  882,  896,  906,  919,
			  933,  947,  960,  974,  987, 1001, 1015, 1029, 1043, 1057, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  167,  167,  168,  168,  169,  169,  166,    7,  166,
			  166,  166,  170,  166,  166,  171,  172,  173,  171,   18,
			   18,  174,  175,  166,  166,  166,  175,  166,  166,  166,
			  176,  177,   29,   29,   29,  178,  170,   18,   18,  172,
			  173,  166,   18,   18,   18,   18,  174,  175,  166,  175,
			  166,   29,  179,   29,  176,  176,  177,  166,  177,   29,
			   29,   29,   29,  178,   18,  172,   18,   18,   18,   18,
			  166,  175,  166,  179,   29,  176,  176,  177,   29,   29,
			   29,   29,  166,  166,   18,   18,   18,  180,  181,  166,
			  179,  166,  176,  166,   29,   29,   29,  182,  183,   83,

			  184,   83,   18,   18,   18,   18,  166,  166,  166,   91,
			  108,  185,   91,  176,   29,   29,   29,   29,  166,  184,
			   18,  186,   18,  166,  108,  185,  176,   29,  166,   29,
			  186,  166,  176,  187,  128,  130,  166,  176,  187,  128,
			  166,  166,  176,  138,  166,  140,  188,  140,  166,  176,
			  166,  144,  150,  189,  144,  188,  166,  176,  150,  189,
			  166,  176,  166,  176,  166,  176,    0,  166,  166,  166,
			  166,  166,  166,  166,  166,  166,  166,  166,  166,  166,
			  166,  166,  166,  166,  166,  166,  166,  166,  166,  166, yy_Dummy>>)
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
			   18,   18,   18,   18,   18,   18,   18,   18,   18,   18,
			   18,   18,   18,   18,   18,   18,   18,   18,   18,   18,
			   18,   19,   20,   21,    5,   22,   23,   18,   18,   18,

			   18,   24,   25,   18,   26,   27,   18,   18,   28,   18,
			   18,   18,   29,   18,   18,   30,   31,   18,   18,   32,
			   18,   18,   18,   33,   34,   35,    5,    1,    1,    1,
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
			    1,    1,    5,    1,    1,    1,    1,    1,    6,    7,
			    1,    3,    1,    8,    6,    9,    6,    6,    6,   10,
			   11,   12,   13,   14,    1,    3, yy_Dummy>>)
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

	yyJam_base: INTEGER is 1072
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
