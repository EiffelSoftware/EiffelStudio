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
if yy_act <= 11 then
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
				add_class
				last_condition := NOT_BREAK_TOKEN
				set_start_condition (DOT_FEATURE)
			
end
else
--|#line 80 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 80")
end

				append_buffer
				add_cluster
			
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
				text_formatter.process_new_line
			
else
--|#line 90 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 90")
end

				buffer_token
			
end
else
--|#line 97 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 97")
end

				add_email_tokens
			
end
else
if yy_act = 10 then
--|#line 102 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 102")
end
				
				add_url_tokens				
			
else
--|#line 107 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 107")
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
--|#line 112 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 112")
end

				add_class
				last_condition := BREAK_TOKEN
				set_start_condition (DOT_FEATURE)
			
else
--|#line 119 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 119")
end

				add_cluster
			
end
else
--|#line 123 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 123")
end

				text_formatter.process_new_line
			
end
else
if yy_act = 15 then
--|#line 128 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 128")
end

				add_normal_text
			
else
--|#line 132 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 132")
end

			
end
end
else
if yy_act <= 19 then
if yy_act <= 18 then
if yy_act = 17 then
--|#line 135 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 135")
end

				add_normal_text
			
else
--|#line 140 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 140")
end

				add_normal_text	
			
end
else
--|#line 146 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 146")
end

				add_dot_feature
			
end
else
if yy_act = 20 then
--|#line 149 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 149")
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
			   46,   37,   44,   57,   38,   37,   45,  161,   58,   91,
			   50,   38,   38,   38,   38,   51,   63,   63,   51,   61,

			   36,   38,   51,   62,   75,   76,   64,   37,   38,   38,
			   38,   37,   36,   42,   75,  160,  110,   43,   52,   37,
			   37,   66,   53,   37,   37,  161,   37,  138,   67,   53,
			   37,   52,   75,   52,   75,   52,   53,   53,   53,   37,
			   37,  160,   51,   68,   37,   69,   51,   52,   46,   52,
			   52,   57,  128,   75,   53,   46,   46,   77,  158,   74,
			   46,   53,   51,   52,   79,   52,   51,   52,   53,   53,
			   53,   73,   51,   59,  133,   70,   51,   60,   73,   52,
			   51,   52,   75,  149,   80,   73,   73,   73,   51,   78,
			   51,   63,   51,   83,   51,   81,   87,   84,   63,   63,

			   83,   37,   85,   63,   94,   37,  156,   83,   83,   83,
			   37,   93,   86,   96,   37,   51,  159,   37,   82,   51,
			   37,   37,   51,  101,   37,   73,   51,  142,   75,   75,
			  102,   89,   73,   51,   51,   95,   96,   51,   51,   73,
			   73,   73,   90,   37,  122,  100,  153,   37,   37,   90,
			   64,  103,   37,  112,  111,  105,   90,   90,   90,   74,
			   75,   51,  105,   37,  152,   51,   98,   37,   83,  105,
			  105,  105,   51,   51,   99,   83,   51,   51,   87,  157,
			  145,  144,   83,   83,   83,  107,   75,  108,  113,   90,
			  102,  116,   75,  137,  132,  109,   90,  108,  107,  127,

			  107,  117,  107,   90,   90,   90,   51,  118,   37,  114,
			   51,   37,   37,   98,  107,   37,  107,   98,  119,   83,
			  123,   37,  124,  125,  104,   37,   83,   37,  104,   92,
			   75,   37,   88,   83,   83,   83,   98,   88,   83,   65,
			   51,  117,   51,   51,   51,   83,   51,   51,  113,   57,
			   75,   72,   83,   83,   83,  108,   71,  105,   48,  117,
			  124,   37,  124,  120,  105,   37,   51,   41,   65,   55,
			   51,  105,  105,  105,  107,   50,  108,   49,   90,   37,
			   51,   48,   51,   37,   51,   90,   51,  107,   41,  107,
			  162,  107,   90,   90,   90,   12,   12,  162,  162,  162,

			  162,  162,  162,  107,  162,  107,  108,  162,  105,  162,
			  162,  162,  162,  162,  162,  105,  162,  162,  162,  162,
			  162,  162,  105,  105,  105,   87,  162,  126,  162,  162,
			  162,  162,  162,  162,  126,  162,  162,  162,  162,  162,
			  162,  126,  126,  126,  108,  162,  105,  162,  162,  162,
			  162,  162,  162,  105,  162,  162,  162,  162,  162,  162,
			  105,  105,  105,  129,  162,   96,  162,  130,  162,  162,
			  162,  162,  162,  162,  130,  162,  129,  162,  129,  162,
			  129,  130,  130,  130,  162,  162,  162,  162,  162,  162,
			  162,  162,  129,  162,  129,   87,  162,  126,  162,  162,

			  162,  162,  162,  131,  126,  162,  162,  162,  162,  162,
			  162,  126,  126,  126,   96,  162,  134,  162,  162,  162,
			  162,  162,  162,  134,  162,  162,  162,  162,  162,  162,
			  134,  134,  134,  129,  162,   96,  162,  130,  162,  162,
			  162,  162,  162,  135,  130,  162,  129,  162,  129,  162,
			  129,  130,  130,  130,  162,  162,  162,  162,  162,  162,
			  162,  162,  129,  162,  129,  136,  162,  162,  162,  162,
			  162,  117,  136,  162,  162,  162,  162,  162,  162,  136,
			  136,  136,   96,  162,  134,  162,  162,  162,  162,  162,
			  139,  134,  162,  162,  162,  162,  162,  162,  134,  134,

			  134,  140,  162,  162,  162,  162,  162,  124,  140,  162,
			  162,  162,  162,  162,  162,  140,  140,  140,  142,  162,
			  136,  162,  162,  162,  162,  162,  143,  136,  162,  162,
			  162,  162,  162,  162,  136,  136,  136,  146,  162,  162,
			  162,  162,  162,  129,  146,  162,  162,  162,  162,  162,
			  162,  146,  146,  146,  148,  162,  149,  162,  140,  162,
			  162,  162,  162,  162,  150,  140,  162,  148,  162,  148,
			  162,  148,  140,  140,  140,  162,  162,  162,  162,  162,
			  162,  162,  162,  148,  162,  148,  142,  162,  136,  162,
			  162,  162,  162,  162,  162,  136,  162,  162,  162,  162,

			  162,  162,  136,  136,  136,  142,  162,  136,  162,  162,
			  162,  162,  162,  162,  136,  162,  162,  162,  162,  162,
			  162,  136,  136,  136,  149,  162,  146,  162,  162,  162,
			  162,  162,  154,  146,  162,  162,  162,  162,  162,  162,
			  146,  146,  146,  148,  162,  149,  162,  140,  162,  162,
			  162,  162,  162,  162,  140,  162,  148,  162,  148,  162,
			  148,  140,  140,  140,  162,  162,  162,  162,  162,  162,
			  162,  162,  148,  162,  148,  149,  162,  146,  162,  162,
			  162,  162,  162,  162,  146,  162,  162,  162,  162,  162,
			  162,  146,  146,  146,  149,  162,  146,  162,  162,  162,

			  162,  162,  162,  146,  162,  162,  162,  162,  162,  162,
			  146,  146,  146,   10,   10,   10,   10,   10,   10,   10,
			   10,   10,   10,   10,   10,   10,   10,   11,   11,   11,
			   11,   11,   11,   11,   11,   11,   11,   11,   11,   11,
			   11,   36,   36,  162,  162,   36,   36,   36,   36,   36,
			   37,  162,   37,  162,   37,   37,   37,   37,   37,   37,
			   37,   37,   37,   37,   39,  162,   39,   39,   39,   39,
			   39,   39,   39,   39,   39,   39,   39,   39,   40,   40,
			   40,   40,   40,   40,   40,  162,   40,   40,   40,   40,
			   40,   40,   47,  162,  162,  162,   47,   47,  162,  162,

			   47,   47,   47,   47,   47,   51,  162,   51,  162,   51,
			   51,   51,   51,   51,   51,   51,   51,   51,   51,   54,
			  162,   54,   54,   54,   54,   54,   54,   54,   54,   54,
			   54,   54,   54,   56,   56,   56,   56,   56,   56,   56,
			  162,   56,   56,   56,   56,   56,   56,   52,  162,   52,
			  162,   52,   52,   52,   52,   52,   52,   52,   52,   52,
			   52,   97,  162,   97,   97,   97,   97,   97,   97,   97,
			   97,   97,   97,   97,   97,   87,  162,   87,   87,   87,
			   87,   87,   87,   87,   87,   87,   87,   87,   87,  106,
			  162,  106,  106,  106,  106,  106,  106,  106,  106,  106,

			  106,  106,  106,   96,  162,   96,   96,   96,   96,   96,
			   96,   96,   96,   96,   96,   96,   96,  115,  162,  115,
			  162,  115,  115,  115,  115,  115,  115,  115,  115,  115,
			  115,  107,  162,  107,  107,  107,  107,  107,  107,  107,
			  107,  107,  107,  107,  107,  121,  162,  121,  162,  121,
			  121,  121,  121,  121,  121,  121,  121,  121,  121,  117,
			  162,  117,  117,  117,  117,  117,  117,  117,  117,  117,
			  117,  117,  117,  124,  162,  124,  124,  124,  124,  124,
			  124,  124,  124,  124,  124,  124,  124,  129,  162,  129,
			  129,  129,  129,  129,  129,  129,  129,  129,  129,  129,

			  129,  141,  162,  141,  141,  141,  141,  141,  141,  141,
			  141,  141,  141,  141,  141,  147,  162,  147,  147,  147,
			  147,  147,  147,  147,  147,  147,  147,  147,  147,  151,
			  162,  151,  151,  151,  151,  151,  151,  151,  151,  151,
			  151,  151,  151,  148,  162,  148,  148,  148,  148,  148,
			  148,  148,  148,  148,  148,  148,  148,  155,  162,  155,
			  155,  155,  155,  155,  155,  155,  155,  155,  155,  155,
			  155,    9,  162,  162,  162,  162,  162,  162,  162,  162,
			  162,  162,  162,  162,  162,  162,  162,  162,  162,  162,
			  162,  162,  162,  162,  162,  162,  162,  162,  162,  162,

			  162,  162,  162,  162,  162,  162,  162,  162,  162,  162, yy_Dummy>>)
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
			   21,   20,   19,   31,   15,   20,   20,  161,   31,   76,
			   35,   15,   15,   15,   18,   33,   35,   35,   34,   33,

			   36,   18,   34,   34,   76,   55,   38,   37,   18,   18,
			   18,   37,   36,   18,   55,  160,   91,   18,   29,   38,
			   42,   42,   29,   38,   42,  159,   43,  133,   43,   29,
			   43,   29,   91,   29,  133,   29,   29,   29,   29,   44,
			   45,  158,   51,   44,   45,   45,   51,   29,   46,   29,
			   32,   58,  122,  122,   32,   46,   46,   58,  156,   53,
			   46,   32,   60,   32,   60,   32,   60,   32,   32,   32,
			   32,   52,   53,   32,  128,   46,   53,   32,   52,   32,
			   61,   32,  128,  155,   61,   52,   52,   52,   59,   59,
			   62,   63,   59,   64,   62,   62,   69,   66,   63,   63,

			   64,   66,   67,   63,   79,   66,  152,   64,   64,   64,
			   68,   78,   68,   81,   68,   78,  157,   69,   63,   78,
			   67,   69,   79,   85,   67,   73,   79,  151,  157,  110,
			   86,   73,   73,   80,   81,   80,  149,   80,   81,   73,
			   73,   73,   74,   85,  110,   84,  145,   85,   86,   74,
			   84,   86,   86,   94,   93,   89,   74,   74,   74,   93,
			  145,   74,   89,   84,  144,   74,   83,   84,   83,   89,
			   89,   89,   93,   94,   83,   83,   93,   94,  142,  153,
			  138,  137,   83,   83,   83,   90,  138,   90,   95,   90,
			  103,  100,  153,  132,  127,   90,   90,  121,   90,  119,

			   90,  101,   90,   90,   90,   90,   95,  102,  103,   95,
			   95,  100,  103,  115,   90,  100,   90,   97,  104,   97,
			  111,  101,  112,  113,   92,  101,   97,  102,   88,   77,
			   75,  102,   72,   97,   97,   97,   99,   71,   99,   65,
			  111,  116,  112,  113,  111,   99,  112,  113,  114,   56,
			   54,   50,   99,   99,   99,  105,   49,  105,   48,  118,
			  123,  116,  125,  105,  105,  116,  114,   40,   39,   30,
			  114,  105,  105,  105,  106,   28,  106,   26,  106,  118,
			  123,   23,  125,  118,  123,  106,  125,  106,   17,  106,
			    9,  106,  106,  106,  106,    4,    3,    0,    0,    0,

			    0,    0,    0,  106,    0,  106,  107,    0,  107,    0,
			    0,    0,    0,    0,    0,  107,    0,    0,    0,    0,
			    0,    0,  107,  107,  107,  117,    0,  117,    0,    0,
			    0,    0,    0,    0,  117,    0,    0,    0,    0,    0,
			    0,  117,  117,  117,  120,    0,  120,    0,    0,    0,
			    0,    0,    0,  120,    0,    0,    0,    0,    0,    0,
			  120,  120,  120,  124,    0,  124,    0,  124,    0,    0,
			    0,    0,    0,    0,  124,    0,  124,    0,  124,    0,
			  124,  124,  124,  124,    0,    0,    0,    0,    0,    0,
			    0,    0,  124,    0,  124,  126,    0,  126,    0,    0,

			    0,    0,    0,  126,  126,    0,    0,    0,    0,    0,
			    0,  126,  126,  126,  129,    0,  129,    0,    0,    0,
			    0,    0,    0,  129,    0,    0,    0,    0,    0,    0,
			  129,  129,  129,  130,    0,  130,    0,  130,    0,    0,
			    0,    0,    0,  130,  130,    0,  130,    0,  130,    0,
			  130,  130,  130,  130,    0,    0,    0,    0,    0,    0,
			    0,    0,  130,    0,  130,  131,    0,    0,    0,    0,
			    0,  131,  131,    0,    0,    0,    0,    0,    0,  131,
			  131,  131,  134,    0,  134,    0,    0,    0,    0,    0,
			  134,  134,    0,    0,    0,    0,    0,    0,  134,  134,

			  134,  135,    0,    0,    0,    0,    0,  135,  135,    0,
			    0,    0,    0,    0,    0,  135,  135,  135,  136,    0,
			  136,    0,    0,    0,    0,    0,  136,  136,    0,    0,
			    0,    0,    0,    0,  136,  136,  136,  139,    0,    0,
			    0,    0,    0,  139,  139,    0,    0,    0,    0,    0,
			    0,  139,  139,  139,  140,    0,  140,    0,  140,    0,
			    0,    0,    0,    0,  140,  140,    0,  140,    0,  140,
			    0,  140,  140,  140,  140,    0,    0,    0,    0,    0,
			    0,    0,    0,  140,    0,  140,  141,    0,  141,    0,
			    0,    0,    0,    0,    0,  141,    0,    0,    0,    0,

			    0,    0,  141,  141,  141,  143,    0,  143,    0,    0,
			    0,    0,    0,    0,  143,    0,    0,    0,    0,    0,
			    0,  143,  143,  143,  146,    0,  146,    0,    0,    0,
			    0,    0,  146,  146,    0,    0,    0,    0,    0,    0,
			  146,  146,  146,  147,    0,  147,    0,  147,    0,    0,
			    0,    0,    0,    0,  147,    0,  147,    0,  147,    0,
			  147,  147,  147,  147,    0,    0,    0,    0,    0,    0,
			    0,    0,  147,    0,  147,  148,    0,  148,    0,    0,
			    0,    0,    0,    0,  148,    0,    0,    0,    0,    0,
			    0,  148,  148,  148,  154,    0,  154,    0,    0,    0,

			    0,    0,    0,  154,    0,    0,    0,    0,    0,    0,
			  154,  154,  154,  163,  163,  163,  163,  163,  163,  163,
			  163,  163,  163,  163,  163,  163,  163,  164,  164,  164,
			  164,  164,  164,  164,  164,  164,  164,  164,  164,  164,
			  164,  165,  165,    0,    0,  165,  165,  165,  165,  165,
			  166,    0,  166,    0,  166,  166,  166,  166,  166,  166,
			  166,  166,  166,  166,  167,    0,  167,  167,  167,  167,
			  167,  167,  167,  167,  167,  167,  167,  167,  168,  168,
			  168,  168,  168,  168,  168,    0,  168,  168,  168,  168,
			  168,  168,  169,    0,    0,    0,  169,  169,    0,    0,

			  169,  169,  169,  169,  169,  170,    0,  170,    0,  170,
			  170,  170,  170,  170,  170,  170,  170,  170,  170,  171,
			    0,  171,  171,  171,  171,  171,  171,  171,  171,  171,
			  171,  171,  171,  172,  172,  172,  172,  172,  172,  172,
			    0,  172,  172,  172,  172,  172,  172,  173,    0,  173,
			    0,  173,  173,  173,  173,  173,  173,  173,  173,  173,
			  173,  174,    0,  174,  174,  174,  174,  174,  174,  174,
			  174,  174,  174,  174,  174,  175,    0,  175,  175,  175,
			  175,  175,  175,  175,  175,  175,  175,  175,  175,  176,
			    0,  176,  176,  176,  176,  176,  176,  176,  176,  176,

			  176,  176,  176,  177,    0,  177,  177,  177,  177,  177,
			  177,  177,  177,  177,  177,  177,  177,  178,    0,  178,
			    0,  178,  178,  178,  178,  178,  178,  178,  178,  178,
			  178,  179,    0,  179,  179,  179,  179,  179,  179,  179,
			  179,  179,  179,  179,  179,  180,    0,  180,    0,  180,
			  180,  180,  180,  180,  180,  180,  180,  180,  180,  181,
			    0,  181,  181,  181,  181,  181,  181,  181,  181,  181,
			  181,  181,  181,  182,    0,  182,  182,  182,  182,  182,
			  182,  182,  182,  182,  182,  182,  182,  183,    0,  183,
			  183,  183,  183,  183,  183,  183,  183,  183,  183,  183,

			  183,  184,    0,  184,  184,  184,  184,  184,  184,  184,
			  184,  184,  184,  184,  184,  185,    0,  185,  185,  185,
			  185,  185,  185,  185,  185,  185,  185,  185,  185,  186,
			    0,  186,  186,  186,  186,  186,  186,  186,  186,  186,
			  186,  186,  186,  187,    0,  187,  187,  187,  187,  187,
			  187,  187,  187,  187,  187,  187,  187,  188,    0,  188,
			  188,  188,  188,  188,  188,  188,  188,  188,  188,  188,
			  188,  162,  162,  162,  162,  162,  162,  162,  162,  162,
			  162,  162,  162,  162,  162,  162,  162,  162,  162,  162,
			  162,  162,  162,  162,  162,  162,  162,  162,  162,  162,

			  162,  162,  162,  162,  162,  162,  162,  162,  162,  162, yy_Dummy>>)
		end

	yy_base_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,  387,  386,    0,    0,   38,    0,  390,
			 1171, 1171,    0, 1171, 1171,   66,    0,  381,   83,   48,
			   51,   61,    0,  379, 1171, 1171,  365, 1171,  363,  111,
			  357,   76,  143,   65,   68,   78,   89,   77,   89,  346,
			  360, 1171,   90,   96,  109,  110,  137,    0,  356,  343,
			  338,  112,  160,  142,  328,   92,  342, 1171,  144,  158,
			  132,  150,  160,  180,  182,  317,  171,  190,  180,  187,
			 1171,  330,  325,  214,  231,  308,   82,  322,  185,  192,
			  203,  204, 1171,  257,  233,  213,  218,    0,  322,  244,
			  278,  110,  318,  242,  243,  276,    0,  308,    0,  327,

			  281,  291,  297,  278,  281,  346,  367,  397,    0,    0,
			  207,  310,  312,  313,  336,  304,  331,  416,  349,  278,
			  435,  288,  131,  350,  456,  352,  486,  280,  160,  505,
			  526,  554,  278,  112,  573,  590,  609,  265,  264,  626,
			  647,  677,  269,  696,  256,  238,  715,  736,  766,  227,
			    0,  218,  197,  270,  785,  174,  148,  206,  119,  103,
			   93,   65, 1171,  812,  826,  836,  849,  863,  877,  891,
			  904,  918,  932,  946,  960,  974,  988, 1002, 1016, 1030,
			 1044, 1058, 1072, 1086, 1100, 1114, 1128, 1142, 1156, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  163,  163,  164,  164,  162,    5,  162,    7,  162,
			  162,  162,  165,  162,  162,  166,  167,  168,  166,   18,
			   18,  162,  169,  162,  162,  162,  169,  162,  162,  170,
			  171,  172,  170,   32,   32,  162,  165,   18,   18,  167,
			  168,  162,   18,   18,   18,   18,  162,  169,  162,  169,
			  162,   32,  173,   32,  171,  171,  172,  162,  172,   32,
			   32,   32,   32,  162,  166,  167,   18,   18,   18,   18,
			  162,  169,  162,  173,   32,  171,  171,  172,   32,   32,
			   32,   32,  162,  174,   18,   18,   18,  175,  162,  173,
			  176,  171,  162,   32,   32,   32,  177,  174,  178,  174,

			   18,   18,   18,   18,  162,  179,  176,  179,  180,  106,
			  171,   32,   32,   32,   32,  178,   18,  181,   18,  162,
			  179,  180,  171,   32,  182,   32,  181,  162,  171,  183,
			  182,  126,  162,  171,  183,  130,  184,  162,  171,  134,
			  185,  184,  186,  184,  162,  171,  187,  185,  187,  188,
			  147,  186,  162,  171,  187,  188,  162,  171,  162,  171,
			  162,  171,    0,  162,  162,  162,  162,  162,  162,  162,
			  162,  162,  162,  162,  162,  162,  162,  162,  162,  162,
			  162,  162,  162,  162,  162,  162,  162,  162,  162, yy_Dummy>>)
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
			    0,    0,    0,    0,    0,    0,    0,    0,    0,   22,
			    1,   20,   20,    8,    7,    8,    8,    8,    8,    8,
			    8,    8,   15,   17,   14,   16,   15,   18,   18,   15,
			   18,   18,   15,   15,   15,   18,   19,    0,    0,    0,
			    0,    4,    0,    0,    0,    0,    0,   15,   17,   15,
			    0,   15,    0,   15,    0,    0,    0,   11,    0,   15,
			   15,   15,   15,    0,    0,    6,    0,    0,    0,    0,
			    5,   15,    0,    0,   15,   13,    0,    0,   15,   15,
			   15,   15,   12,    2,    0,    0,    0,    3,    0,    0,
			    9,    0,   11,   15,   15,   15,   10,    2,    0,    2,

			    0,    0,    0,    0,    0,    9,    9,    9,    0,    9,
			    0,   15,   15,   15,   15,    2,    0,    3,    0,    0,
			    9,    9,    0,   15,   10,   15,    3,    0,    0,   10,
			   10,    3,    0,    0,   10,   10,    2,    0,    0,   10,
			    9,    2,    3,    2,    0,    0,    9,    9,    9,   10,
			    9,    2,    0,    0,    9,    9,    0,    0,    0,    0,
			   15,   13,    0, yy_Dummy>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 1171
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 162
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 163
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
