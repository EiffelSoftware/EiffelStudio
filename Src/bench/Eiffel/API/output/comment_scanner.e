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
--|#line 31 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 31")
end

				add_email_tokens
				reset_last_type
			
else
--|#line 37 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 37")
end
				
				add_url_tokens
				reset_last_type				
			
end
else
if yy_act = 3 then
--|#line 43 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 43")
end

				add_quote_feature
			
else
--|#line 48 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 48")
end

				add_class
				set_start_condition (DOT_FEATURE)
			
end
end
else
if yy_act <= 6 then
if yy_act = 5 then
--|#line 54 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 54")
end

				add_cluster
				reset_last_type
			
else
--|#line 60 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 60")
end

				add_text (text)
				reset_last_type
			
end
else
--|#line 65 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 65")
end

				text_formatter.process_new_line
				reset_last_type
			
end
end
else
if yy_act <= 10 then
if yy_act <= 9 then
if yy_act = 8 then
--|#line 70 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 70")
end

				reset_last_type
			
else
--|#line 74 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 74")
end

				add_text (text)
				reset_last_type
			
end
else
--|#line 81 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 81")
end

				add_dot_feature
			
end
else
if yy_act <= 12 then
if yy_act = 11 then
--|#line 85 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 85")
end

				set_start_condition (INITIAL)
				reset_last_type
			
else
--|#line 100 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 100")
end

				add_text (text)
				reset_last_type	
			
end
else
--|#line 0 "comment_scanner.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'comment_scanner.l' at line 0")
end
default_action
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
			    0,    6,    7,    8,    9,    6,   10,    6,    6,    6,
			    6,   11,   11,   12,    6,    6,   13,   11,   11,   14,
			   11,   15,   11,   11,   11,   11,   11,   16,   17,    6,
			   19,   19,   19,   65,   20,   19,   19,   19,   23,   20,
			   24,   23,   31,   24,   35,   23,   32,   33,   33,   24,
			   24,   24,   24,   23,   23,   24,   23,   23,   42,   26,
			   23,   24,   24,   24,   38,   28,   29,   36,   23,   40,
			   30,   23,   23,   41,   23,   23,   49,   26,   23,   43,
			   33,   34,   51,   33,   33,   36,   39,   33,   34,   38,
			   28,   46,   23,   47,   48,   23,   23,   37,   49,   23,

			   39,   44,   45,   53,   35,   45,   23,   54,   37,   22,
			   23,   45,   45,   45,   23,   28,   23,   26,   23,   51,
			   23,   45,   23,   52,   45,   55,   23,   22,   68,   68,
			   45,   45,   45,   68,   58,   68,   68,   68,   23,   68,
			   68,   56,   23,   51,   59,   45,   60,   55,   45,   23,
			   68,   59,   68,   23,   45,   45,   45,   68,   68,   23,
			   23,   23,   59,   23,   23,   23,   23,   68,   68,   68,
			   23,   49,   68,   61,   68,   68,   61,   23,   68,   68,
			   68,   23,   61,   61,   61,   49,   68,   61,   68,   62,
			   61,   68,   68,   68,   68,   68,   61,   61,   61,   63,

			   68,   59,   63,   68,   68,   68,   68,   68,   63,   63,
			   63,   65,   68,   63,   68,   66,   63,   68,   68,   68,
			   68,   68,   63,   63,   63,   65,   68,   63,   68,   68,
			   63,   68,   68,   68,   68,   68,   63,   63,   63,   18,
			   18,   18,   18,   18,   18,   18,   18,   21,   68,   68,
			   21,   21,   21,   21,   21,   23,   68,   68,   23,   23,
			   23,   23,   23,   25,   68,   25,   25,   25,   25,   25,
			   25,   27,   68,   27,   27,   27,   27,   27,   27,   34,
			   34,   34,   34,   34,   26,   68,   26,   26,   26,   26,
			   26,   26,   28,   68,   28,   28,   28,   28,   28,   28,

			   50,   68,   50,   50,   50,   50,   50,   50,   49,   68,
			   49,   49,   49,   49,   49,   49,   57,   68,   68,   57,
			   57,   57,   57,   57,   59,   68,   59,   59,   59,   59,
			   59,   59,   64,   68,   64,   64,   64,   64,   64,   64,
			   67,   68,   67,   67,   67,   67,   67,   67,    5,   68,
			   68,   68,   68,   68,   68,   68,   68,   68,   68,   68,
			   68,   68,   68,   68,   68,   68,   68,   68,   68,   68,
			   68,   68,   68,   68,   68,   68,   68,   68, yy_Dummy>>)
		end

	yy_chk_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    3,    3,    3,   67,    3,    4,    4,    4,   15,    4,
			   11,   16,   15,   11,   24,   16,   16,   17,   17,   11,
			   11,   11,   14,   23,   31,   14,   24,   23,   31,   25,
			   24,   14,   14,   14,   27,   27,   14,   25,   29,   29,
			   14,   30,   29,   30,   32,   30,   65,   36,   32,   32,
			   33,   34,   57,   33,   33,   36,   39,   33,   34,   38,
			   38,   40,   42,   41,   42,   40,   42,   37,   43,   40,

			   28,   33,   35,   46,   46,   35,   41,   47,   26,   22,
			   41,   35,   35,   35,   43,   13,   46,   12,   43,   45,
			   46,   45,   47,   45,   45,   48,   47,    7,    5,    0,
			   45,   45,   45,    0,   53,    0,    0,    0,   48,    0,
			    0,   48,   48,   50,   54,   50,   55,   56,   50,   53,
			    0,   58,    0,   53,   50,   50,   50,    0,    0,   54,
			   56,   55,   60,   54,   56,   55,   58,    0,    0,    0,
			   58,   59,    0,   59,    0,    0,   59,   60,    0,    0,
			    0,   60,   59,   59,   59,   61,    0,   61,    0,   61,
			   61,    0,    0,    0,    0,    0,   61,   61,   61,   62,

			    0,   62,   62,    0,    0,    0,    0,    0,   62,   62,
			   62,   63,    0,   63,    0,   63,   63,    0,    0,    0,
			    0,    0,   63,   63,   63,   64,    0,   64,    0,    0,
			   64,    0,    0,    0,    0,    0,   64,   64,   64,   69,
			   69,   69,   69,   69,   69,   69,   69,   70,    0,    0,
			   70,   70,   70,   70,   70,   71,    0,    0,   71,   71,
			   71,   71,   71,   72,    0,   72,   72,   72,   72,   72,
			   72,   73,    0,   73,   73,   73,   73,   73,   73,   74,
			   74,   74,   74,   74,   75,    0,   75,   75,   75,   75,
			   75,   75,   76,    0,   76,   76,   76,   76,   76,   76,

			   77,    0,   77,   77,   77,   77,   77,   77,   78,    0,
			   78,   78,   78,   78,   78,   78,   79,    0,    0,   79,
			   79,   79,   79,   79,   80,    0,   80,   80,   80,   80,
			   80,   80,   81,    0,   81,   81,   81,   81,   81,   81,
			   82,    0,   82,   82,   82,   82,   82,   82,   68,   68,
			   68,   68,   68,   68,   68,   68,   68,   68,   68,   68,
			   68,   68,   68,   68,   68,   68,   68,   68,   68,   68,
			   68,   68,   68,   68,   68,   68,   68,   68, yy_Dummy>>)
		end

	yy_base_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,   28,   33,  128,    0,  125,  348,  348,
			  348,   32,  111,  109,   44,   16,   19,   36,  348,  348,
			    0,    0,  107,   31,   34,   53,   94,   59,   95,   46,
			   49,   32,   52,   72,   73,   94,   71,   83,   84,   81,
			   73,   84,   70,   92,    0,  113,   94,  100,  116,    0,
			  137,    0,    0,  127,  137,  139,  138,   76,  144,  165,
			  155,  179,  191,  205,  219,   70,    0,   27,  348,  238,
			  246,  254,  262,  270,  275,  283,  291,  299,  307,  315,
			  323,  331,  339, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,   68,    1,   69,   69,   68,   70,   68,   68,   68,
			   68,   71,   72,   73,   71,   14,   14,   70,   68,   68,
			   74,   70,   68,   14,   14,   72,   75,   73,   76,   14,
			   14,   14,   14,   70,   74,   71,   72,   75,   73,   76,
			   14,   14,   14,   14,   70,   77,   14,   14,   14,   78,
			   77,   79,   50,   14,   14,   14,   14,   79,   14,   80,
			   14,   80,   61,   81,   81,   82,   64,   82,    0,   68,
			   68,   68,   68,   68,   68,   68,   68,   68,   68,   68,
			   68,   68,   68, yy_Dummy>>)
		end

	yy_ec_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    2,
			    3,    1,    1,    4,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    2,    1,    1,    1,    1,    1,    1,    5,
			    1,    1,    1,    1,    1,    1,    6,    7,    8,    8,
			    8,    8,    8,    8,    8,    8,    8,    8,    9,    1,
			    1,    1,    1,    1,   10,   11,   11,   11,   11,   11,
			   11,   12,   12,   12,   12,   12,   12,   12,   12,   12,
			   12,   12,   12,   12,   12,   12,   12,   12,   12,   12,
			   12,   13,    1,   14,    1,   15,   16,   17,   17,   17,

			   17,   18,   19,   20,   21,   22,   20,   20,   23,   20,
			   20,   20,   24,   20,   20,   25,   26,   20,   20,   27,
			   20,   20,   20,   28,    1,   29,    1,    1,    1,    1,
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
			    0,    1,    2,    2,    2,    1,    3,    1,    1,    1,
			    1,    4,    5,    1,    1,    1,    1,    4,    4,    4,
			    4,    4,    4,    4,    6,    7,    8,    4,    1,    1, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,    0,    0,   14,    6,    9,    7,    8,
			   12,    6,    6,    6,    6,    6,    6,    6,   13,   11,
			   13,    6,    9,    6,    6,    6,    0,    6,    0,    6,
			    6,    6,    6,    6,   10,    6,    5,    5,    3,    3,
			    6,    6,    6,    6,    4,    1,    6,    6,    6,    2,
			    1,    0,    1,    6,    6,    6,    6,    1,    6,    2,
			    6,    2,    2,    1,    1,    2,    1,    1,    0, yy_Dummy>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 348
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 68
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 69
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
