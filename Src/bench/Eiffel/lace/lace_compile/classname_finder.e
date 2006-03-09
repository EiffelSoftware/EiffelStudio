indexing

	description: "Eiffel classname finders"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class CLASSNAME_FINDER

inherit

	CLASSNAME_FINDER_SKELETON

creation

	make


feature -- Status report

	valid_start_condition (sc: INTEGER): BOOLEAN is
			-- Is `sc' a valid start condition?
		do
			Result := (INITIAL <= sc and sc <= VERBATIM_STR3)
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
			yy_acclist := yy_acclist_template
		end

	yy_execute_action (yy_act: INTEGER) is
			-- Execute semantic action.
		do
			inspect yy_act
when 1 then
--|#line 29 "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line 29")
end

				set_partial_class
				set_start_condition (IN_CLASS)
			
when 2 then
--|#line 34 "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line 34")
end

				set_start_condition (IN_CLASS)
			
when 3 then
--|#line 38 "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line 38")
end

				classname := text
				last_token := TE_ID
			
when 4 then
--|#line 43 "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line 43")
end
-- Ignore
when 5 then
--|#line 44 "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line 44")
end
-- Ignore
when 6 then
--|#line 48 "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line 48")
end
-- Ignore
when 7 then
--|#line 50 "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line 50")
end

				verbatim_marker.clear_all
				append_text_substring_to_string (2, text_count - 1, verbatim_marker)
				last_start_condition := start_condition
				set_start_condition (VERBATIM_STR3)
			
when 8 then
--|#line 57 "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line 57")
end
-- Ignore
when 9 then
--|#line 58 "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line 58")
end
-- Ignore
when 10 then
--|#line 59 "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line 59")
end
-- Ignore
when 11 then
--|#line 64 "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line 64")
end

				set_start_condition (VERBATIM_STR1)
			
when 12 then
--|#line 67 "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line 67")
end

					-- No final bracket-double-quote.
				set_start_condition (last_start_condition)
			
when 13 then
--|#line 79 "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line 79")
end

				if is_verbatim_string_closer then
					set_start_condition (last_start_condition)
				else
					set_start_condition (VERBATIM_STR2)
				end
			
when 14 then
--|#line 86 "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line 86")
end

				set_start_condition (VERBATIM_STR2)
			
when 15 then
--|#line 89 "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line 89")
end

				-- Ignore.
			
when 16 then
--|#line 92 "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line 92")
end

					-- No final bracket-double-quote.
				set_start_condition (last_start_condition)
			
when 17 then
--|#line 104 "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line 104")
end

				set_start_condition (VERBATIM_STR1)
			
when 18 then
--|#line 107 "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line 107")
end

					-- No final bracket-double-quote.
				set_start_condition (last_start_condition)
			
when 19 then
--|#line 0 "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line 0")
end
last_token := yyError_token
fatal_error ("scanner jammed")
			else
				last_token := yyError_token
				fatal_error ("fatal scanner internal error: no action found")
			end
		end

	yy_execute_eof_action (yy_sc: INTEGER) is
			-- Execute EOF semantic action.
		do
			inspect yy_sc
when 2 then
--|#line 0 "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line 0")
end

					-- No final bracket-double-quote.
				set_start_condition (last_start_condition)
			
when 3 then
--|#line 0 "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line 0")
end

					-- No final bracket-double-quote.
				set_start_condition (last_start_condition)
			
when 4 then
--|#line 0 "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line 0")
end

					-- No final bracket-double-quote.
				set_start_condition (last_start_condition)
			
			else
				terminate
			end
		end

feature {NONE} -- Table templates

	yy_nxt_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,   12,   12,   13,   14,   12,   15,   12,   12,   16,
			   16,   17,   16,   16,   18,   16,   16,   16,   12,   12,
			   12,   16,   16,   17,   16,   16,   18,   16,   16,   16,
			   19,   19,   13,   14,   19,   15,   19,   19,   29,   30,
			   61,   22,   23,   24,   22,   23,   24,   19,   19,   19,
			   19,   19,   13,   14,   19,   15,   19,   19,   25,   29,
			   30,   25,   34,   35,   44,   45,   50,   19,   19,   19,
			   40,   32,   41,   44,   48,   43,   36,   31,   31,   51,
			   52,   31,   40,   31,   41,   50,   59,   39,   44,   45,
			   39,   46,   44,   45,   31,   31,   34,   35,   59,   39,

			   54,   55,   39,   60,   37,   56,   51,   52,   47,   32,
			   36,   57,   58,   34,   35,   60,   46,   44,   45,   44,
			   48,   43,   74,   34,   35,   54,   55,   36,   31,   31,
			   62,   63,   31,   47,   31,   74,   55,   55,   39,   53,
			   64,   39,   62,   63,   27,   31,   31,   53,   61,   65,
			   39,   66,   64,   39,   57,   58,   34,   35,   27,   67,
			   70,   65,   71,   66,   68,   68,   68,   68,   72,   73,
			   36,   67,   70,   74,   71,   69,   74,   74,   31,   74,
			   72,   73,   31,   74,   74,   31,   74,   69,   20,   20,
			   20,   20,   20,   20,   20,   20,   20,   20,   21,   21,

			   21,   21,   21,   21,   21,   21,   21,   21,   26,   26,
			   26,   26,   26,   26,   26,   26,   26,   26,   28,   28,
			   28,   28,   28,   28,   28,   28,   28,   28,   33,   74,
			   33,   33,   33,   33,   33,   33,   33,   33,   38,   74,
			   74,   74,   38,   38,   38,   38,   38,   38,   39,   39,
			   39,   39,   39,   39,   42,   42,   42,   42,   42,   42,
			   43,   43,   43,   43,   43,   43,   43,   43,   43,   43,
			   47,   47,   47,   47,   47,   47,   47,   47,   47,   47,
			   49,   49,   49,   49,   49,   49,   49,   49,   49,   49,
			   53,   53,   53,   53,   53,   53,   53,   53,   53,   53,

			   37,   74,   37,   37,   37,   37,   37,   37,   37,   37,
			   11,   74,   74,   74,   74,   74,   74,   74,   74,   74,
			   74,   74,   74,   74,   74,   74,   74,   74,   74,   74,
			   74,   74,   74,   74,   74,   74,   74,   74,   74,   74, yy_Dummy>>)
		end

	yy_chk_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    3,    3,    3,    3,    3,    3,    3,    3,    9,    9,
			   56,    5,    5,    5,    6,    6,    6,    3,    3,    3,
			    4,    4,    4,    4,    4,    4,    4,    4,    5,   10,
			   10,    6,   14,   14,   21,   21,   49,    4,    4,    4,
			   17,   32,   18,   25,   25,   25,   14,   16,   16,   29,
			   29,   16,   17,   16,   18,   26,   40,   16,   43,   43,
			   16,   22,   22,   22,   16,   16,   33,   33,   40,   16,

			   35,   35,   16,   41,   15,   35,   51,   51,   22,   13,
			   33,   36,   36,   36,   36,   41,   46,   46,   46,   47,
			   47,   47,   53,   53,   53,   54,   54,   36,   38,   38,
			   59,   60,   38,   46,   38,   11,   55,   55,   38,   55,
			   62,   38,   59,   60,    8,   38,   38,   61,   61,   63,
			   38,   65,   62,   38,   57,   57,   57,   57,    7,   66,
			   69,   63,   70,   65,   67,   67,   68,   68,   71,   72,
			   57,   66,   69,    0,   70,   68,    0,    0,   79,    0,
			   71,   72,   79,    0,    0,   79,    0,   68,   75,   75,
			   75,   75,   75,   75,   75,   75,   75,   75,   76,   76,

			   76,   76,   76,   76,   76,   76,   76,   76,   77,   77,
			   77,   77,   77,   77,   77,   77,   77,   77,   78,   78,
			   78,   78,   78,   78,   78,   78,   78,   78,   80,    0,
			   80,   80,   80,   80,   80,   80,   80,   80,   81,    0,
			    0,    0,   81,   81,   81,   81,   81,   81,   82,   82,
			   82,   82,   82,   82,   83,   83,   83,   83,   83,   83,
			   84,   84,   84,   84,   84,   84,   84,   84,   84,   84,
			   85,   85,   85,   85,   85,   85,   85,   85,   85,   85,
			   86,   86,   86,   86,   86,   86,   86,   86,   86,   86,
			   87,   87,   87,   87,   87,   87,   87,   87,   87,   87,

			   88,    0,   88,   88,   88,   88,   88,   88,   88,   88,
			   74,   74,   74,   74,   74,   74,   74,   74,   74,   74,
			   74,   74,   74,   74,   74,   74,   74,   74,   74,   74,
			   74,   74,   74,   74,   74,   74,   74,   74,   74,   74, yy_Dummy>>)
		end

	yy_base_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,   29,   49,   39,   42,  155,  141,   36,
			   57,  135,    0,  106,   58,   98,   76,   57,   63,  310,
			    0,   61,   89,  310,  310,   70,   82,  310,  310,   77,
			  310,    0,   68,   92,  310,   98,  109,    0,  127,    0,
			   77,   88,    0,   85,  310,  310,  114,  116,  310,   63,
			  310,  104,  310,  119,  123,  134,   32,  152,  310,  114,
			  114,  140,  124,  137,    0,  142,  146,  162,  164,  147,
			  153,  152,  153,  310,  310,  187,  197,  207,  217,  177,
			  227,  237,  243,  249,  259,  269,  279,  289,  299, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,   74,    1,   75,   75,   76,   76,   77,   77,   78,
			   78,   74,   79,   74,   80,   74,   81,   82,   82,   74,
			   83,   84,   84,   74,   74,   85,   86,   74,   74,   74,
			   74,   79,   74,   80,   74,   87,   80,   88,   81,   82,
			   82,   82,   83,   84,   74,   74,   84,   85,   74,   86,
			   74,   74,   74,   87,   74,   74,   74,   80,   74,   82,
			   82,   74,   82,   82,   82,   82,   82,   82,   74,   74,
			   74,   74,   74,   74,    0,   74,   74,   74,   74,   74,
			   74,   74,   74,   74,   74,   74,   74,   74,   74, yy_Dummy>>)
		end

	yy_ec_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    2,
			    3,    1,    1,    2,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    2,    1,    4,    1,    1,    5,    1,    1,
			    1,    1,    1,    1,    1,    6,    1,    7,    8,    8,
			    8,    8,    8,    8,    8,    8,    8,    8,    1,    1,
			    1,    1,    1,    1,    1,    9,   10,   11,   10,   10,
			   10,   10,   10,   12,   10,   10,   13,   10,   10,   10,
			   14,   10,   15,   16,   17,   10,   10,   10,   10,   10,
			   10,   18,    1,   19,    1,   20,    1,   21,   22,   23,

			   22,   22,   22,   22,   22,   24,   22,   22,   25,   22,
			   22,   22,   26,   22,   27,   28,   29,   22,   22,   22,
			   22,   22,   22,    1,    1,    1,    1,    1,    1,    1,
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
			    0,    1,    1,    2,    3,    1,    4,    1,    5,    5,
			    5,    6,    5,    5,    7,    5,    5,    8,    1,    1,
			    5,    5,    5,    9,    5,    5,   10,    5,    5,    5, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    1,    2,    3,    3,    3,    4,    5,    6,    7,
			    7,    7,    8,   11,   13,   15,   17,   21,   24,   27,
			   29,   32,   34,   36,   38,   40,   42,   44,   46,   48,
			   50,   52,   53,   54,   54,   55,   55,   56,   57,   59,
			   60,   61,   62,   63,   64,   65,   66,   67,   68,   70,
			   71,   72,   72,   73,   73,   73,   73,   73,   73,   74,
			   75,   76,   76,   77,   78,   80,   81,   82,   83,   83,
			   83,   83,   83,   83,   84,   84, yy_Dummy>>)
		end

	yy_acclist_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    4,    4,   16,   16,   18,   18,   20,    4,   10,
			   19,    9,   19,   10,   19,   10,   19,    4,    5,   10,
			   19,    5,   10,   19,    5,   10,   19,   10,   19,    3,
			   10,   19,   16,   19,   16,   19,   15,   19,   14,   19,
			   16,   19,   18,   19,   17,   19,   12,   19,   12,   19,
			   11,   19,    4,    9,    6,  -26,    8,    4,    5,    5,
			    5,    5,    3,   16,   15,   14,   16,   16,   13,   14,
			   18,   17,   11,   -7,    5,    5,    5,    5,    2,    5,
			    5,    5,    5,    1, yy_Dummy>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 310
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 74
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 75
			-- Mark between normal states and templates

	yyNull_equiv_class: INTEGER is 1
			-- Equivalence code for NULL character

	yyReject_used: BOOLEAN is false
			-- Is `reject' called?

	yyVariable_trail_context: BOOLEAN is true
			-- Is there a regular expression with
			-- both leading and trailing parts having
			-- variable length?

	yyReject_or_variable_trail_context: BOOLEAN is true
			-- Is `reject' called or is there a
			-- regular expression with both leading
			-- and trailing parts having variable length?

	yyNb_rules: INTEGER is 19
			-- Number of rules

	yyEnd_of_buffer: INTEGER is 20
			-- End of buffer rule code

	yyLine_used: BOOLEAN is false
			-- Are line and column numbers used?

	yyPosition_used: BOOLEAN is false
			-- Is `position' used?

	INITIAL: INTEGER is 0
	IN_CLASS: INTEGER is 1
	VERBATIM_STR1: INTEGER is 2
	VERBATIM_STR2: INTEGER is 3
	VERBATIM_STR3: INTEGER is 4
			-- Start condition codes

feature -- User-defined features



end -- class CLASSNAME_FINDER


--|----------------------------------------------------------------
--| Copyright (C) 1992-2000, Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited
--| without prior agreement with Interactive Software Engineering.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------
