indexing

	description: "Scanners for Eiffel comment"
	status: "See notice at end of class"
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
			    0,    6,    7,    8,    9,   10,    6,    6,   10,   11,
			   10,   10,   10,   10,   10,    6,    6,   10,   12,   12,
			   13,    6,    6,   10,   14,   12,   12,   15,   12,   16,
			   12,   12,   12,   12,   12,   17,   18,    6,   11,   23,
			   24,   30,   24,   23,   34,  114,   24,   35,   24,   36,
			   36,   21,   25,   31,   24,   44,  113,   40,   24,   25,
			   37,   45,   43,   41,   24,   26,   25,   25,   25,   25,
			   24,   42,   37,   70,   24,   24,   25,   71,   44,   24,
			   24,   44,   26,   25,   25,   25,   24,   24,   32,   42,
			   24,  114,   33,   24,   47,   24,   24,   24,   24,   86,

			   42,   24,   24,   48,   24,   24,   49,   36,   24,   50,
			   54,   81,   56,   90,   36,   36,   44,   54,   60,   36,
			   55,   42,   24,   98,   54,   54,   54,   42,   24,   42,
			   24,   58,   24,   24,   51,   59,   24,   62,   24,   24,
			   24,   42,   40,   24,   24,   44,   61,   73,   24,   29,
			   75,   44,   24,   95,  113,   24,   80,  111,   24,   24,
			   29,   44,   24,   66,   24,   54,   44,   44,   31,   42,
			   24,   67,   54,   91,   24,   87,   29,  110,   29,   54,
			   54,   54,   69,   74,   31,   94,   82,  101,   40,   69,
			   76,   24,   42,   44,  105,   24,   69,   69,   69,   44,

			   24,   24,   24,   83,   84,   24,   24,   24,   24,   24,
			   24,   77,   24,   66,  115,   54,   44,   24,   24,  107,
			   44,   76,   54,   24,   24,   99,  104,   24,   24,   54,
			   54,   54,   66,   24,   54,  115,   44,   83,  109,   24,
			   42,   54,  108,   24,   44,   83,   62,  112,   54,   54,
			   54,   24,  103,   97,   93,   42,   89,   24,   66,   24,
			   85,   24,   62,   78,   88,   24,   21,   64,   57,   24,
			   44,   88,   37,   37,   42,   37,   37,   37,   88,   88,
			   88,   62,   53,   88,   52,   46,   44,   42,   39,   92,
			   88,   22,   38,   28,   23,   22,   21,   88,   88,   88,

			   96,  116,   20,   20,  116,  116,   83,   96,  116,  116,
			  116,  116,  116,  116,   96,   96,   96,  101,  116,   96,
			  116,  116,  116,  116,  116,  102,   96,  116,  116,  116,
			  116,  116,  116,   96,   96,   96,  101,  116,   96,  116,
			  116,  116,  116,  116,  116,   96,  116,  116,  116,  116,
			  116,  116,   96,   96,   96,  101,  116,   96,  116,  116,
			  116,  116,  116,  116,   96,  116,  116,  116,  116,  116,
			  116,   96,   96,   96,   19,   19,   19,   19,   19,   19,
			   19,   19,   19,   24,  116,  116,   24,   24,   24,   24,
			   24,   24,   27,  116,   27,   27,   27,   27,   27,   27,

			   27,   29,  116,   29,   29,   29,   29,   29,   29,   29,
			   63,  116,  116,   63,   63,  116,   63,   63,   63,   65,
			  116,   65,   65,   65,   65,   65,   65,   65,   68,  116,
			  116,   68,   68,   68,   68,   68,   68,   72,  116,   72,
			   72,   72,   72,   72,   72,   72,   62,  116,   62,   62,
			   62,   62,   62,   62,   62,   79,  116,  116,   79,   79,
			   79,   79,   79,   79,   83,  116,   83,   83,   83,   83,
			   83,   83,   83,  100,  116,  100,  100,  100,  100,  100,
			  100,  100,  106,  116,  106,  106,  106,  106,  106,  106,
			  106,    5,  116,  116,  116,  116,  116,  116,  116,  116,

			  116,  116,  116,  116,  116,  116,  116,  116,  116,  116,
			  116,  116,  116,  116,  116,  116,  116,  116,  116,  116,
			  116,  116,  116,  116,  116,  116,  116,  116,  116,  116, yy_Dummy>>)
		end

	yy_chk_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,   10,
			   16,   14,   17,   18,   16,  114,   17,   17,   24,   18,
			   18,   10,   12,   14,   24,   30,  113,   25,   24,   12,
			   37,   30,   28,   26,   25,   12,   12,   12,   12,   15,
			   25,   28,   37,   56,   25,   68,   15,   57,   57,   68,
			   26,   71,   15,   15,   15,   15,   26,   32,   15,   56,
			   26,  111,   15,   32,   32,   33,   34,   32,   35,   80,

			   80,   33,   34,   33,   35,   33,   34,   36,   35,   35,
			   40,   71,   43,   86,   36,   36,   46,   40,   48,   36,
			   41,   86,   41,   94,   40,   40,   40,   43,   41,   94,
			   48,   46,   41,   47,   36,   47,   48,   50,   49,   47,
			   48,   70,   69,   47,   49,   91,   49,   58,   49,   58,
			   60,   72,   50,   91,  110,   69,   70,  108,   50,   69,
			   58,   81,   50,   54,   60,   54,   87,   73,   72,  108,
			   60,   54,   54,   87,   60,   81,   58,  107,   58,   54,
			   54,   54,   55,   59,   73,   90,   74,  106,   59,   55,
			   61,   55,   90,   99,   99,   59,   55,   55,   55,  112,

			   74,   59,   61,   75,   76,   59,   74,   55,   61,   55,
			   74,   61,   61,   65,  112,   65,   95,   75,   76,  103,
			  115,   77,   65,   75,   76,   95,   98,   75,   76,   65,
			   65,   65,   67,   77,   67,  115,  105,   82,  105,   77,
			   98,   67,  104,   77,  109,   84,  101,  109,   67,   67,
			   67,   82,   97,   93,   89,  104,   85,   82,   79,   84,
			   78,   82,   83,   64,   83,   84,   63,   53,   45,   84,
			   44,   83,  121,  121,   42,  121,  121,  121,   83,   83,
			   83,   88,   39,   88,   38,   31,   29,   27,   23,   88,
			   88,   22,   21,   13,   11,    7,    6,   88,   88,   88,

			   92,    5,    4,    3,    0,    0,   92,   92,    0,    0,
			    0,    0,    0,    0,   92,   92,   92,   96,    0,   96,
			    0,    0,    0,    0,    0,   96,   96,    0,    0,    0,
			    0,    0,    0,   96,   96,   96,  100,    0,  100,    0,
			    0,    0,    0,    0,    0,  100,    0,    0,    0,    0,
			    0,    0,  100,  100,  100,  102,    0,  102,    0,    0,
			    0,    0,    0,    0,  102,    0,    0,    0,    0,    0,
			    0,  102,  102,  102,  117,  117,  117,  117,  117,  117,
			  117,  117,  117,  118,    0,    0,  118,  118,  118,  118,
			  118,  118,  119,    0,  119,  119,  119,  119,  119,  119,

			  119,  120,    0,  120,  120,  120,  120,  120,  120,  120,
			  122,    0,    0,  122,  122,    0,  122,  122,  122,  123,
			    0,  123,  123,  123,  123,  123,  123,  123,  124,    0,
			    0,  124,  124,  124,  124,  124,  124,  125,    0,  125,
			  125,  125,  125,  125,  125,  125,  126,    0,  126,  126,
			  126,  126,  126,  126,  126,  127,    0,    0,  127,  127,
			  127,  127,  127,  127,  128,    0,  128,  128,  128,  128,
			  128,  128,  128,  129,    0,  129,  129,  129,  129,  129,
			  129,  129,  130,    0,  130,  130,  130,  130,  130,  130,
			  130,  116,  116,  116,  116,  116,  116,  116,  116,  116,

			  116,  116,  116,  116,  116,  116,  116,  116,  116,  116,
			  116,  116,  116,  116,  116,  116,  116,  116,  116,  116,
			  116,  116,  116,  116,  116,  116,  116,  116,  116,  116, yy_Dummy>>)
		end

	yy_base_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,  294,  293,  301,  272,  293,  491,  491,
			   27,  282,   41,  281,   29,   58,   10,   12,   31,  491,
			    0,  285,  289,  275,   24,   40,   56,  265,   49,  279,
			   48,  278,   63,   71,   72,   74,   96,   49,  262,  275,
			   99,   98,  252,  105,  263,  261,  109,  109,  106,  114,
			  128,  491,    0,  261,  154,  171,   67,   71,  140,  171,
			  140,  178,    0,  242,  226,  204,    0,  223,   45,  125,
			  119,   74,  144,  160,  176,  193,  194,  209,  239,  249,
			   78,  154,  227,  253,  235,  242,   99,  159,  272,  239,
			  170,  138,  289,  237,  107,  209,  308,  244,  218,  186,

			  327,  237,  346,  210,  233,  229,  178,  167,  147,  237,
			  132,   69,  192,   34,   23,  213,  491,  373,  382,  391,
			  400,  268,  409,  418,  427,  436,  445,  454,  463,  472,
			  481, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  116,    1,  117,  117,  116,  116,  116,  116,  116,
			  116,  116,  118,  119,  120,  118,   15,   15,  116,  116,
			  121,  116,  116,  116,   15,   15,   15,  119,  119,  120,
			  120,  120,   15,   15,   15,   15,  116,  121,  116,  116,
			  118,   15,  119,  119,  120,  120,  120,   15,   15,   15,
			   15,  116,  122,  116,  123,  124,  119,  120,  125,   15,
			   15,   15,  126,  116,  116,  123,  127,  123,   15,   15,
			  119,  120,  120,  120,   15,   15,   15,   15,  116,  127,
			  119,  120,   15,  128,   15,  116,  119,  120,  128,  116,
			  119,  120,   88,  116,  119,  120,  129,  116,  119,  120,

			  129,  130,  129,  116,  119,  120,  130,  116,  119,  120,
			  116,  119,  120,  116,  119,  120,    0,  116,  116,  116,
			  116,  116,  116,  116,  116,  116,  116,  116,  116,  116,
			  116, yy_Dummy>>)
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
			    0,    1,    2,    2,    2,    1,    1,    1,    1,    3,
			    1,    1,    1,    1,    1,    1,    1,    1,    4,    5,
			    6,    1,    1,    1,    1,    4,    4,    4,    4,    4,
			    4,    7,    4,    8,    9,    4,    6,    1,    6, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,    0,    0,   14,   12,    9,    7,    8,
			   12,   12,   12,   12,   12,   12,   12,   12,   12,   11,
			   11,    0,    9,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,   10,    0,    0,
			    0,    0,    5,    0,    3,    0,    3,    0,    0,    0,
			    0,    4,    6,    0,    1,    6,    0,    3,    6,    0,
			    0,    0,    2,    0,    0,    1,    0,    1,    0,    0,
			    0,    0,    0,    3,    0,    0,    0,    0,    0,    1,
			    0,    0,    0,    2,    0,    0,    0,    0,    2,    0,
			    0,    0,    2,    0,    0,    0,    1,    0,    0,    0,

			    1,    2,    1,    0,    0,    0,    1,    0,    0,    0,
			    0,    0,    0,    6,    5,    6,    0, yy_Dummy>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 491
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 116
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 117
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
