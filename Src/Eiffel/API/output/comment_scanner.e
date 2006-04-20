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
			    0,    6,    7,    8,    9,   10,    6,    6,   10,   11,
			   10,   10,   10,   10,   10,    6,    6,   10,   12,   12,
			   13,    6,    6,   10,   14,   12,   12,   15,   12,   16,
			   12,   12,   12,   12,   12,   17,   18,    6,   10,   20,
			   20,   20,   20,   20,   20,   25,   21,   24,  101,   21,
			   24,   32,   25,  100,   24,   33,   39,   23,   37,   25,
			   25,   25,   25,   34,   34,   38,   24,   40,   24,   25,
			   24,   24,   44,   41,  101,   24,   25,   25,   25,   24,
			   42,   30,   24,   24,   43,   31,   24,   24,   34,   35,
			   48,   24,   45,   49,   51,   34,   34,   48,   24,   52,

			   34,   35,   24,   54,   48,   48,   48,   24,   38,   53,
			   59,   24,   60,   40,   61,   46,   40,   24,   38,   37,
			   62,   24,   73,   38,   24,   86,   38,   40,   24,   57,
			   63,   48,   24,   67,   69,   40,   24,   58,   48,   70,
			   24,   71,   63,   40,   24,   48,   48,   48,   24,   74,
			   78,   64,   24,   57,   24,   48,   70,   68,   24,   24,
			   24,   24,   48,   24,   24,   24,   81,   98,   91,   48,
			   48,   48,   57,   38,   48,   70,   24,   77,   40,   38,
			   24,   48,   38,   40,   92,   38,   82,  100,   48,   48,
			   48,   54,   85,   75,   40,   24,   96,   97,   38,   24,

			   75,   95,   40,   88,   94,   99,   40,   75,   75,   75,
			   54,   54,   75,   90,   38,   40,   84,   80,   79,   75,
			   76,  102,   57,   72,   65,   55,   75,   75,   75,   83,
			  102,   50,   40,   38,   47,   70,   83,   40,   38,   36,
			   22,   29,   27,   83,   83,   83,   88,   23,   83,   23,
			   22,  103,  103,  103,   89,   83,  103,  103,  103,  103,
			  103,  103,   83,   83,   83,   88,  103,   83,  103,  103,
			  103,  103,  103,  103,   83,  103,  103,  103,  103,  103,
			  103,   83,   83,   83,   88,  103,   83,  103,  103,  103,
			  103,  103,  103,   83,  103,  103,  103,  103,  103,  103,

			   83,   83,   83,   19,   19,   19,   19,   19,   19,   19,
			   19,   19,   24,  103,  103,   24,   24,   24,   24,   24,
			   24,   26,  103,   26,   26,   26,   26,   26,   26,   26,
			   28,  103,   28,   28,   28,   28,   28,   28,   28,   35,
			   35,   35,   35,   35,   35,   56,  103,   56,   56,   56,
			   56,   56,   56,   56,   54,  103,   54,   54,   54,   54,
			   54,   54,   54,   66,  103,  103,   66,   66,   66,   66,
			   66,   66,   70,  103,   70,   70,   70,   70,   70,   70,
			   70,   87,  103,   87,   87,   87,   87,   87,   87,   87,
			   93,  103,   93,   93,   93,   93,   93,   93,   93,    5,

			  103,  103,  103,  103,  103,  103,  103,  103,  103,  103,
			  103,  103,  103,  103,  103,  103,  103,  103,  103,  103,
			  103,  103,  103,  103,  103,  103,  103,  103,  103,  103,
			  103,  103,  103,  103,  103,  103,  103,  103, yy_Dummy>>)
		end

	yy_chk_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    3,
			    3,    3,    4,    4,    4,   12,    3,   16,  101,    4,
			   17,   16,   12,  100,   17,   17,   27,   18,   25,   12,
			   12,   12,   15,   18,   18,   27,   24,   29,   32,   15,
			   24,   25,   32,   29,   98,   25,   15,   15,   15,   30,
			   30,   15,   31,   30,   31,   15,   31,   33,   34,   35,
			   37,   33,   33,   39,   42,   34,   34,   37,   42,   43,

			   34,   35,   42,   45,   37,   37,   37,   44,   39,   44,
			   49,   44,   50,   50,   51,   34,   82,   43,   59,   51,
			   52,   43,   67,   67,   45,   82,   49,   60,   45,   48,
			   53,   48,   51,   59,   61,   68,   51,   48,   48,   62,
			   52,   63,   64,   74,   52,   48,   48,   48,   53,   68,
			   74,   53,   53,   56,   61,   56,   69,   60,   61,   62,
			   64,   63,   56,   62,   64,   63,   77,   95,   85,   56,
			   56,   56,   58,   77,   58,   71,   69,   73,   78,   95,
			   69,   58,   85,   86,   86,   73,   78,   97,   58,   58,
			   58,   70,   81,   70,   92,   71,   92,   94,   81,   71,

			   70,   91,   96,   93,   90,   96,   99,   70,   70,   70,
			   75,   88,   75,   84,   91,  102,   80,   76,   75,   75,
			   72,   99,   66,   65,   55,   47,   75,   75,   75,   79,
			  102,   41,   40,   38,   36,   79,   79,   28,   26,   23,
			   22,   14,   13,   79,   79,   79,   83,   11,   83,   10,
			    7,    5,    0,    0,   83,   83,    0,    0,    0,    0,
			    0,    0,   83,   83,   83,   87,    0,   87,    0,    0,
			    0,    0,    0,    0,   87,    0,    0,    0,    0,    0,
			    0,   87,   87,   87,   89,    0,   89,    0,    0,    0,
			    0,    0,    0,   89,    0,    0,    0,    0,    0,    0,

			   89,   89,   89,  104,  104,  104,  104,  104,  104,  104,
			  104,  104,  105,    0,    0,  105,  105,  105,  105,  105,
			  105,  106,    0,  106,  106,  106,  106,  106,  106,  106,
			  107,    0,  107,  107,  107,  107,  107,  107,  107,  108,
			  108,  108,  108,  108,  108,  109,    0,  109,  109,  109,
			  109,  109,  109,  109,  110,    0,  110,  110,  110,  110,
			  110,  110,  110,  111,    0,    0,  111,  111,  111,  111,
			  111,  111,  112,    0,  112,  112,  112,  112,  112,  112,
			  112,  113,    0,  113,  113,  113,  113,  113,  113,  113,
			  114,    0,  114,  114,  114,  114,  114,  114,  114,  103,

			  103,  103,  103,  103,  103,  103,  103,  103,  103,  103,
			  103,  103,  103,  103,  103,  103,  103,  103,  103,  103,
			  103,  103,  103,  103,  103,  103,  103,  103,  103,  103,
			  103,  103,  103,  103,  103,  103,  103,  103, yy_Dummy>>)
		end

	yy_base_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,   37,   40,  251,  399,  248,  399,  399,
			  237,  235,   34,  230,  229,   51,   17,   20,   45,  399,
			  399,    0,  238,  226,   36,   41,  216,   43,  230,   60,
			   49,   52,   38,   57,   77,   78,  227,   79,  211,   86,
			  225,  224,   68,   87,   77,   94,  399,  219,  120,  104,
			  106,  102,  110,  118,    0,  187,  144,    0,  163,   96,
			  120,  124,  129,  131,  130,  202,  213,  101,  128,  146,
			  182,  165,  206,  163,  136,  201,  202,  151,  171,  218,
			  200,  176,  109,  237,  205,  160,  176,  256,  202,  275,
			  195,  192,  187,  194,  187,  157,  195,  165,   52,  199,

			   31,   26,  208,  399,  302,  311,  320,  329,  335,  344,
			  353,  362,  371,  380,  389, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,  103,    1,  104,  104,  103,  103,  103,  103,  103,
			  103,  103,  105,  106,  107,  105,   15,   15,  103,  103,
			  103,  108,  103,  103,   15,   15,  106,  106,  107,  107,
			   15,   15,   15,   15,  103,  108,  103,  105,  106,  106,
			  107,  107,   15,   15,   15,   15,  103,  103,  109,  106,
			  107,   15,   15,   15,  110,  103,  109,  111,  109,  106,
			  107,   15,   15,   15,   15,  103,  111,  106,  107,   15,
			  112,   15,  103,  106,  107,  112,  103,  106,  107,   75,
			  103,  106,  107,  113,  103,  106,  107,  113,  114,  113,
			  103,  106,  107,  114,  103,  106,  107,  103,  106,  107,

			  103,  106,  107,    0,  103,  103,  103,  103,  103,  103,
			  103,  103,  103,  103,  103, yy_Dummy>>)
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
			    1,    1,    1,    1,    1,    4,    4,    4,    4,    4,
			    4,    4,    6,    7,    8,    9,    1,    1,    1, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,    0,    0,   14,    6,    9,    7,    8,
			    6,   12,    6,    6,    6,    6,    6,    6,    6,   13,
			   11,   13,    9,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,   10,    0,    0,    5,    0,
			    3,    0,    0,    0,    0,    0,    4,    0,    1,    0,
			    3,    0,    0,    0,    2,    0,    1,    0,    1,    0,
			    0,    0,    0,    0,    0,    0,    1,    0,    0,    0,
			    2,    0,    0,    0,    0,    2,    0,    0,    0,    2,
			    0,    0,    0,    1,    0,    0,    0,    1,    2,    1,
			    0,    0,    0,    1,    0,    0,    0,    0,    0,    0,

			    6,    5,    6,    0, yy_Dummy>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 399
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 103
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 104
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
