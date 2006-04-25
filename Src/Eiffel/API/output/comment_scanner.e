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
			Result := (INITIAL <= sc and sc <= DOT_FEATURE)
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
if yy_act <= 7 then
if yy_act <= 4 then
if yy_act <= 2 then
if yy_act = 1 then
--|#line 34 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 34")
end

				add_email_tokens
				reset_last_type
			
else
--|#line 40 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 40")
end
				
				add_url_tokens
				reset_last_type				
			
end
else
if yy_act = 3 then
--|#line 46 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 46")
end

				add_quote_feature
			
else
--|#line 51 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 51")
end

				add_class
				set_start_condition (DOT_FEATURE)
			
end
end
else
if yy_act <= 6 then
if yy_act = 5 then
--|#line 57 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 57")
end

				add_cluster
				reset_last_type
			
else
--|#line 63 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 63")
end

				add_text (text)
				reset_last_type
			
end
else
--|#line 68 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 68")
end

				text_formatter.process_new_line
				reset_last_type
			
end
end
else
if yy_act <= 10 then
if yy_act <= 9 then
if yy_act = 8 then
--|#line 73 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 73")
end

				reset_last_type
			
else
--|#line 77 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 77")
end

				add_text (text)
				reset_last_type
			
end
else
--|#line 84 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 84")
end

				add_dot_feature
			
end
else
if yy_act <= 12 then
if yy_act = 11 then
--|#line 87 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 87")
end

				less (0)
				set_start_condition (INITIAL)
				reset_last_type
			
else
--|#line 102 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 102")
end

				add_text (text)
				reset_last_type	
			
end
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

	yy_execute_eof_action (yy_sc: INTEGER) is
			-- Execute EOF semantic action.
		do
			inspect yy_sc
when 0 then
--|#line 0 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 0")
end

				terminate
			
when 1 then
--|#line 0 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 0")
end

				set_start_condition (INITIAL)
			
			else
				terminate
			end
		end

feature {NONE} -- Table templates

	yy_nxt_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    6,    7,    8,    9,   10,    6,   11,   10,   12,
			   10,   10,   10,   10,   10,    6,    6,   10,   13,   13,
			   14,    6,   11,   10,   15,   13,   13,   16,   13,   17,
			   13,   13,   13,   13,   13,   18,   19,    6,   12,   27,
			   26,   26,   25,   28,   35,   26,   36,   26,   37,   37,
			   28,   26,   27,   38,   27,   44,   27,   28,   28,   28,
			   45,   45,   41,  114,   43,   38,   42,   46,   27,   41,
			   27,   27,   55,   68,   45,   28,   41,   41,   41,   26,
			  116,   26,   28,   26,   27,   49,   27,   43,   27,   28,
			   28,   28,   26,   47,   33,   26,   26,   48,   34,   26,

			   27,   26,   27,   37,   57,   26,   50,   58,   26,   43,
			   37,   37,   26,   45,   26,   37,   59,   67,   26,   60,
			   62,   69,   98,   45,   76,   26,   42,   62,   45,   26,
			   51,   41,   70,   43,   62,   62,   62,   53,   41,   26,
			   26,   78,   83,   26,   26,   41,   41,   41,   54,   79,
			   82,   43,   26,   77,  105,   54,   26,   71,   87,   71,
			   80,   26,   54,   54,   54,   26,   43,   26,   43,   26,
			  115,   26,   64,   26,   65,   26,   54,   26,   72,   26,
			   26,   26,   66,   54,   26,   64,   45,   64,   45,   64,
			   54,   54,   54,   88,   79,   79,   93,  110,   92,   45,

			  106,   64,   97,   64,   65,   43,   62,   45,   43,  111,
			   43,   45,   74,   62,   26,   26,  113,   45,   26,   26,
			   62,   62,   62,   64,  116,   65,  117,   54,   43,  115,
			  112,  102,  117,  109,   54,   60,   64,  104,   64,   96,
			   64,   54,   54,   54,   91,   86,   65,   81,   73,   61,
			   56,   45,   64,   43,   64,   65,   52,   62,   52,   45,
			   43,   40,   39,   23,   62,   32,   30,   25,   24,   23,
			  118,   62,   62,   62,   65,   21,   62,   21,  118,  118,
			  118,  118,  118,   62,  118,  118,  118,  118,  118,  118,
			   62,   62,   62,   84,  118,   60,  118,   85,  118,  118,

			  118,  118,  118,  118,   85,  118,   84,  118,   84,  118,
			   84,   85,   85,   85,  118,  118,  118,  118,  118,  118,
			  118,  118,   84,  118,   84,   60,  118,   89,  118,  118,
			  118,  118,  118,  118,   89,  118,  118,  118,  118,  118,
			  118,   89,   89,   89,   84,  118,   60,  118,   85,  118,
			  118,  118,  118,  118,   90,   85,  118,   84,  118,   84,
			  118,   84,   85,   85,   85,  118,  118,  118,  118,  118,
			  118,  118,  118,   84,  118,   84,   60,  118,   89,  118,
			  118,  118,  118,  118,   94,   89,  118,  118,  118,  118,
			  118,  118,   89,   89,   89,   95,  118,  118,  118,  118,

			  118,   79,   95,  118,  118,  118,  118,  118,  118,   95,
			   95,   95,   99,  118,  118,  118,  118,  118,   84,   99,
			  118,  118,  118,  118,  118,  118,   99,   99,   99,  101,
			  118,  102,  118,   95,  118,  118,  118,  118,  118,  103,
			   95,  118,  101,  118,  101,  118,  101,   95,   95,   95,
			  118,  118,  118,  118,  118,  118,  118,  118,  101,  118,
			  101,  102,  118,   99,  118,  118,  118,  118,  118,  107,
			   99,  118,  118,  118,  118,  118,  118,   99,   99,   99,
			  101,  118,  102,  118,   95,  118,  118,  118,  118,  118,
			  118,   95,  118,  101,  118,  101,  118,  101,   95,   95,

			   95,  118,  118,  118,  118,  118,  118,  118,  118,  101,
			  118,  101,  102,  118,   99,  118,  118,  118,  118,  118,
			  118,   99,  118,  118,  118,  118,  118,  118,   99,   99,
			   99,  102,  118,   99,  118,  118,  118,  118,  118,  118,
			   99,  118,  118,  118,  118,  118,  118,   99,   99,   99,
			   20,   20,   20,   20,   20,   20,   20,   20,   20,   20,
			   20,   20,   20,   22,  118,  118,  118,   22,   22,  118,
			  118,  118,   22,   22,   22,   22,   26,  118,   26,  118,
			   26,   26,   26,   26,   26,   26,   26,   26,   26,   29,
			  118,   29,   29,   29,   29,   29,   29,   29,   29,   29,

			   29,   29,   31,  118,   31,   31,   31,   31,   31,   31,
			   31,   31,   31,   31,   31,   38,   38,  118,  118,  118,
			   38,   38,   38,   38,   27,  118,   27,  118,   27,   27,
			   27,   27,   27,   27,   27,   27,   27,   63,  118,   63,
			   63,   63,   63,   63,   63,   63,   63,   63,   63,   63,
			   60,  118,   60,   60,   60,   60,   60,   60,   60,   60,
			   60,   60,   60,   64,  118,   64,   64,   64,   64,   64,
			   64,   64,   64,   64,   64,   64,   75,  118,   75,  118,
			   75,   75,   75,   75,   75,   75,   75,   75,   75,   79,
			  118,   79,   79,   79,   79,   79,   79,   79,   79,   79,

			   79,   79,   84,  118,   84,   84,   84,   84,   84,   84,
			   84,   84,   84,   84,   84,  100,  118,  100,  100,  100,
			  100,  100,  100,  100,  100,  100,  100,  100,  101,  118,
			  101,  101,  101,  101,  101,  101,  101,  101,  101,  101,
			  101,  108,  118,  108,  108,  108,  108,  108,  108,  108,
			  108,  108,  108,  108,    5,  118,  118,  118,  118,  118,
			  118,  118,  118,  118,  118,  118,  118,  118,  118,  118,
			  118,  118,  118,  118,  118,  118,  118,  118,  118,  118,
			  118,  118,  118,  118,  118,  118,  118,  118,  118,  118,
			  118,  118,  118, yy_Dummy>>)
		end

	yy_chk_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,   13,
			   17,   18,   19,   13,   17,   18,   18,   26,   19,   19,
			   13,   26,   13,   38,   13,   30,   13,   13,   13,   13,
			  111,   32,   27,  111,   30,   38,   28,   32,   13,   27,
			   13,   16,   44,   56,   56,   16,   27,   27,   27,   28,
			  116,   35,   16,   28,   16,   35,   16,   44,   16,   16,
			   16,   16,   33,   33,   16,   34,   33,   34,   16,   34,

			   16,   36,   16,   37,   47,   36,   36,   48,   47,   67,
			   37,   37,   47,   93,   49,   37,   49,   55,   49,   50,
			   53,   57,   93,   68,   67,   48,   57,   53,   77,   48,
			   37,   41,   58,   55,   53,   53,   53,   41,   41,   57,
			   50,   69,   77,   57,   50,   41,   41,   41,   42,   70,
			   76,   76,   58,   68,   97,   42,   58,   59,   82,   72,
			   71,   69,   42,   42,   42,   69,   82,   42,   97,   70,
			  115,   42,   54,   70,   54,   59,   54,   72,   59,   59,
			   71,   72,   54,   54,   71,   54,   83,   54,   88,   54,
			   54,   54,   54,   83,   78,   80,   88,  105,   87,   98,

			   98,   54,   92,   54,   62,   87,   62,  106,   92,  106,
			  105,  114,   62,   62,   78,   80,  110,  117,   78,   80,
			   62,   62,   62,   63,  113,   63,  114,   63,  110,  112,
			  109,  108,  117,  104,   63,  102,   63,   96,   63,   91,
			   63,   63,   63,   63,   86,   81,   75,   73,   61,   52,
			   46,   45,   63,   43,   63,   64,   40,   64,   39,   31,
			   29,   25,   24,   23,   64,   15,   14,   12,   10,    7,
			    5,   64,   64,   64,   74,    4,   74,    3,    0,    0,
			    0,    0,    0,   74,    0,    0,    0,    0,    0,    0,
			   74,   74,   74,   79,    0,   79,    0,   79,    0,    0,

			    0,    0,    0,    0,   79,    0,   79,    0,   79,    0,
			   79,   79,   79,   79,    0,    0,    0,    0,    0,    0,
			    0,    0,   79,    0,   79,   84,    0,   84,    0,    0,
			    0,    0,    0,    0,   84,    0,    0,    0,    0,    0,
			    0,   84,   84,   84,   85,    0,   85,    0,   85,    0,
			    0,    0,    0,    0,   85,   85,    0,   85,    0,   85,
			    0,   85,   85,   85,   85,    0,    0,    0,    0,    0,
			    0,    0,    0,   85,    0,   85,   89,    0,   89,    0,
			    0,    0,    0,    0,   89,   89,    0,    0,    0,    0,
			    0,    0,   89,   89,   89,   90,    0,    0,    0,    0,

			    0,   90,   90,    0,    0,    0,    0,    0,    0,   90,
			   90,   90,   94,    0,    0,    0,    0,    0,   94,   94,
			    0,    0,    0,    0,    0,    0,   94,   94,   94,   95,
			    0,   95,    0,   95,    0,    0,    0,    0,    0,   95,
			   95,    0,   95,    0,   95,    0,   95,   95,   95,   95,
			    0,    0,    0,    0,    0,    0,    0,    0,   95,    0,
			   95,   99,    0,   99,    0,    0,    0,    0,    0,   99,
			   99,    0,    0,    0,    0,    0,    0,   99,   99,   99,
			  100,    0,  100,    0,  100,    0,    0,    0,    0,    0,
			    0,  100,    0,  100,    0,  100,    0,  100,  100,  100,

			  100,    0,    0,    0,    0,    0,    0,    0,    0,  100,
			    0,  100,  101,    0,  101,    0,    0,    0,    0,    0,
			    0,  101,    0,    0,    0,    0,    0,    0,  101,  101,
			  101,  107,    0,  107,    0,    0,    0,    0,    0,    0,
			  107,    0,    0,    0,    0,    0,    0,  107,  107,  107,
			  119,  119,  119,  119,  119,  119,  119,  119,  119,  119,
			  119,  119,  119,  120,    0,    0,    0,  120,  120,    0,
			    0,    0,  120,  120,  120,  120,  121,    0,  121,    0,
			  121,  121,  121,  121,  121,  121,  121,  121,  121,  122,
			    0,  122,  122,  122,  122,  122,  122,  122,  122,  122,

			  122,  122,  123,    0,  123,  123,  123,  123,  123,  123,
			  123,  123,  123,  123,  123,  124,  124,    0,    0,    0,
			  124,  124,  124,  124,  125,    0,  125,    0,  125,  125,
			  125,  125,  125,  125,  125,  125,  125,  126,    0,  126,
			  126,  126,  126,  126,  126,  126,  126,  126,  126,  126,
			  127,    0,  127,  127,  127,  127,  127,  127,  127,  127,
			  127,  127,  127,  128,    0,  128,  128,  128,  128,  128,
			  128,  128,  128,  128,  128,  128,  129,    0,  129,    0,
			  129,  129,  129,  129,  129,  129,  129,  129,  129,  130,
			    0,  130,  130,  130,  130,  130,  130,  130,  130,  130,

			  130,  130,  131,    0,  131,  131,  131,  131,  131,  131,
			  131,  131,  131,  131,  131,  132,    0,  132,  132,  132,
			  132,  132,  132,  132,  132,  132,  132,  132,  133,    0,
			  133,  133,  133,  133,  133,  133,  133,  133,  133,  133,
			  133,  134,    0,  134,  134,  134,  134,  134,  134,  134,
			  134,  134,  134,  134,  118,  118,  118,  118,  118,  118,
			  118,  118,  118,  118,  118,  118,  118,  118,  118,  118,
			  118,  118,  118,  118,  118,  118,  118,  118,  118,  118,
			  118,  118,  118,  118,  118,  118,  118,  118,  118,  118,
			  118,  118,  118, yy_Dummy>>)
		end

	yy_base_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,  268,  266,  270,    0,  267,  754,  754,
			  256,  754,  255,   32,  254,  253,   64,   10,   11,   30,
			  754,    0,    0,  261,  249,  248,   17,   51,   49,  238,
			   42,  252,   54,   62,   65,   51,   71,   92,   42,  251,
			  249,  120,  137,  231,   65,  244,  243,   78,   95,   84,
			  110,  754,  243,  109,  165,  111,   67,  109,  122,  145,
			    0,  211,  195,  216,  246,    0,    0,   87,  116,  131,
			  139,  150,  147,  226,  265,  237,  129,  121,  184,  286,
			  185,  231,  144,  179,  316,  337,  229,  183,  181,  367,
			  384,  223,  186,  106,  401,  422,  229,  146,  192,  452,

			  473,  503,  226,    0,  224,  188,  200,  522,  222,  220,
			  206,   53,  207,  202,  204,  148,   58,  210,  754,  549,
			  562,  575,  588,  601,  610,  623,  636,  649,  662,  675,
			  688,  701,  714,  727,  740, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  118,    1,  119,  119,  118,  120,  118,  118,  118,
			  120,  118,  118,  121,  122,  123,  121,   16,   16,  118,
			  118,  124,  120,  118,  120,  118,   16,  125,   16,  122,
			  122,  123,  123,   16,   16,   16,   16,  118,  124,  120,
			  118,  125,   16,  122,  122,  123,  123,   16,   16,   16,
			   16,  118,  118,  125,  126,  122,  123,   16,   16,   16,
			  127,  118,  128,  126,  128,  129,   63,  122,  123,   16,
			   16,   16,   16,  118,  128,  129,  122,  123,   16,  130,
			   16,  118,  122,  123,  131,  130,  118,  122,  123,  131,
			   85,  118,  122,  123,   89,  132,  118,  122,  123,  133,

			  132,  133,  134,  100,  118,  122,  123,  133,  134,  118,
			  122,  123,  118,  122,  123,  118,  122,  123,    0,  118,
			  118,  118,  118,  118,  118,  118,  118,  118,  118,  118,
			  118,  118,  118,  118,  118, yy_Dummy>>)
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
			    7,    1,    8,    1,    9,    5,    5,    5,    5,    5,
			    5,    5,   10,   11,   12,   13,    3,    1,    3, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,    0,    0,   14,    6,    9,    7,    8,
			    6,   12,   12,    6,   12,   12,    6,    6,    6,   12,
			   11,   11,    6,    9,    6,    0,    6,    0,    6,    0,
			    0,    0,    0,    6,    6,    6,    6,    0,   10,    6,
			    0,    0,    6,    5,    0,    3,    0,    6,    6,    6,
			    6,    4,    0,    0,    1,    0,    3,    6,    6,    6,
			    2,    0,    1,    1,    1,    0,    1,    0,    0,    6,
			    6,    6,    6,    0,    1,    1,    0,    0,    6,    2,
			    6,    0,    0,    0,    2,    2,    0,    0,    0,    2,
			    2,    0,    0,    0,    2,    1,    0,    0,    0,    1,

			    1,    1,    2,    1,    0,    0,    0,    1,    1,    0,
			    0,    0,    0,    0,    0,    6,    5,    6,    0, yy_Dummy>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 754
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 118
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 119
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

	yyNb_rules: INTEGER is 13
			-- Number of rules

	yyEnd_of_buffer: INTEGER is 14
			-- End of buffer rule code

	yyLine_used: BOOLEAN is false
			-- Are line and column numbers used?

	yyPosition_used: BOOLEAN is false
			-- Is `position' used?

	INITIAL: INTEGER is 0
	DOT_FEATURE: INTEGER is 1
			-- Start condition codes

feature -- User-defined features



end -- class COMMENT_SCANNER
