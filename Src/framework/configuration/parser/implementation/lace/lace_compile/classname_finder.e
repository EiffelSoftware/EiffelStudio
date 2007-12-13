indexing

	description: "Eiffel classname finders"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class CLASSNAME_FINDER

inherit

	CLASSNAME_FINDER_SKELETON

create

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
--|#line 30 "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line 30")
end

				set_start_condition (IN_CLASS)
				set_partial_class (True)

when 2 then
--|#line 34 "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line 34")
end

				set_start_condition (IN_CLASS)
				set_partial_class (False)

when 3 then
--|#line 39 "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line 39")
end

				classname := text
				terminate

when 4 then
--|#line 44 "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line 44")
end
-- Ignore
when 5 then
--|#line 45 "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line 45")
end
-- Ignore
when 6 then
--|#line 49 "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line 49")
end
-- Ignore
when 7 then
--|#line 51 "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line 51")
end

				verbatim_marker.clear_all
				if text_item (text_count) = '[' then
					verbatim_marker.append_character (']')
				else
					verbatim_marker.append_character ('}')
				end
				append_text_substring_to_string (2, text_count - 1, verbatim_marker)
				last_start_condition := start_condition
				set_start_condition (VERBATIM_STR3)

when 8 then
--|#line 63 "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line 63")
end
-- Ignore
when 9 then
--|#line 64 "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line 64")
end
-- Ignore
when 10 then
--|#line 65 "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line 65")
end
-- Ignore
when 11 then
--|#line 70 "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line 70")
end

				set_start_condition (VERBATIM_STR1)

when 12 then
--|#line 73 "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line 73")
end

					-- No final bracket-double-quote.
				set_start_condition (last_start_condition)

when 13 then
--|#line 85 "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line 85")
end

				if is_verbatim_string_closer then
					set_start_condition (last_start_condition)
				else
					set_start_condition (VERBATIM_STR2)
				end

when 14 then
--|#line 92 "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line 92")
end

				set_start_condition (VERBATIM_STR2)

when 15 then
--|#line 95 "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line 95")
end

				-- Ignore.

when 16 then
--|#line 98 "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line 98")
end

					-- No final bracket-double-quote.
				set_start_condition (last_start_condition)

when 17 then
--|#line 110 "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line 110")
end

				set_start_condition (VERBATIM_STR1)

when 18 then
--|#line 113 "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line 113")
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
			   72,   22,   23,   24,   22,   23,   24,   19,   19,   19,
			   19,   19,   13,   14,   19,   15,   19,   19,   25,   29,
			   30,   25,   34,   35,   44,   45,   50,   19,   19,   19,
			   40,   32,   41,   44,   48,   50,   36,   31,   31,   51,
			   52,   31,   40,   31,   41,   37,   59,   39,   60,   65,
			   39,   46,   44,   45,   31,   31,   34,   35,   59,   39,

			   60,   65,   39,   44,   45,   46,   44,   45,   47,   66,
			   36,   53,   54,   55,   44,   48,   56,   51,   52,   53,
			   54,   66,   47,   54,   54,   81,   55,   36,   57,   58,
			   34,   35,   34,   63,   32,   62,   70,   81,   67,   58,
			   62,   71,   64,   81,   36,   31,   31,   73,   70,   31,
			   27,   31,   62,   71,   62,   39,   68,   54,   39,   73,
			   81,   69,   31,   31,   33,   64,   27,   39,   67,   58,
			   39,   57,   58,   34,   35,   62,   68,   54,   55,   72,
			   74,   75,   75,   77,   62,   75,   75,   36,   78,   79,
			   80,   81,   74,   81,   76,   77,   81,   81,   81,   81,

			   78,   79,   80,   81,   81,   81,   76,   20,   20,   20,
			   20,   20,   20,   20,   20,   20,   20,   21,   21,   21,
			   21,   21,   21,   21,   21,   21,   21,   26,   26,   26,
			   26,   26,   26,   26,   26,   26,   26,   28,   28,   28,
			   28,   28,   28,   28,   28,   28,   28,   31,   81,   81,
			   81,   31,   81,   81,   31,   33,   81,   33,   33,   33,
			   33,   33,   33,   33,   33,   38,   81,   81,   81,   38,
			   38,   38,   38,   38,   38,   39,   39,   39,   39,   39,
			   39,   42,   42,   42,   42,   42,   42,   43,   43,   43,
			   43,   43,   43,   43,   43,   43,   43,   47,   47,   47,

			   47,   47,   47,   47,   47,   47,   47,   49,   49,   49,
			   49,   49,   49,   49,   49,   49,   49,   37,   81,   37,
			   37,   37,   37,   37,   37,   37,   37,   61,   61,   81,
			   61,   61,   61,   61,   61,   61,   61,   55,   81,   55,
			   55,   55,   55,   55,   55,   55,   55,   11,   81,   81,
			   81,   81,   81,   81,   81,   81,   81,   81,   81,   81,
			   81,   81,   81,   81,   81,   81,   81,   81,   81,   81,
			   81,   81,   81,   81,   81,   81,   81, yy_Dummy>>)
		end

	yy_chk_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    3,    3,    3,    3,    3,    3,    3,    3,    9,    9,
			   69,    5,    5,    5,    6,    6,    6,    3,    3,    3,
			    4,    4,    4,    4,    4,    4,    4,    4,    5,   10,
			   10,    6,   14,   14,   21,   21,   49,    4,    4,    4,
			   17,   32,   18,   25,   25,   26,   14,   16,   16,   29,
			   29,   16,   17,   16,   18,   15,   40,   16,   41,   59,
			   16,   22,   22,   22,   16,   16,   33,   33,   40,   16,

			   41,   59,   16,   43,   43,   46,   46,   46,   22,   60,
			   33,   35,   35,   35,   47,   47,   35,   51,   51,   53,
			   53,   60,   46,   54,   54,   61,   54,   35,   36,   36,
			   36,   36,   55,   55,   13,   53,   65,   56,   62,   62,
			   61,   66,   56,   11,   36,   38,   38,   71,   65,   38,
			    8,   38,   56,   66,   62,   38,   63,   63,   38,   71,
			   64,   63,   38,   38,   64,   64,    7,   38,   67,   67,
			   38,   57,   57,   57,   57,   64,   68,   68,   72,   72,
			   73,   74,   74,   76,   67,   75,   75,   57,   77,   78,
			   79,    0,   73,    0,   75,   76,    0,    0,    0,    0,

			   77,   78,   79,    0,    0,    0,   75,   82,   82,   82,
			   82,   82,   82,   82,   82,   82,   82,   83,   83,   83,
			   83,   83,   83,   83,   83,   83,   83,   84,   84,   84,
			   84,   84,   84,   84,   84,   84,   84,   85,   85,   85,
			   85,   85,   85,   85,   85,   85,   85,   86,    0,    0,
			    0,   86,    0,    0,   86,   87,    0,   87,   87,   87,
			   87,   87,   87,   87,   87,   88,    0,    0,    0,   88,
			   88,   88,   88,   88,   88,   89,   89,   89,   89,   89,
			   89,   90,   90,   90,   90,   90,   90,   91,   91,   91,
			   91,   91,   91,   91,   91,   91,   91,   92,   92,   92,

			   92,   92,   92,   92,   92,   92,   92,   93,   93,   93,
			   93,   93,   93,   93,   93,   93,   93,   94,    0,   94,
			   94,   94,   94,   94,   94,   94,   94,   95,   95,    0,
			   95,   95,   95,   95,   95,   95,   95,   96,    0,   96,
			   96,   96,   96,   96,   96,   96,   96,   81,   81,   81,
			   81,   81,   81,   81,   81,   81,   81,   81,   81,   81,
			   81,   81,   81,   81,   81,   81,   81,   81,   81,   81,
			   81,   81,   81,   81,   81,   81,   81, yy_Dummy>>)
		end

	yy_base_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,   29,   49,   39,   42,  163,  147,   36,
			   57,  143,    0,  131,   58,   79,   76,   57,   63,  347,
			    0,   61,   89,  347,  347,   70,   72,  347,  347,   77,
			  347,    0,   68,   92,  347,  109,  126,    0,  144,    0,
			   77,   73,    0,  100,  347,  347,  103,  111,  347,   63,
			  347,  115,  347,  117,  121,  128,  134,  169,  347,   73,
			   92,  122,  136,  154,  157,  120,  129,  166,  174,   32,
			    0,  138,  171,  167,  179,  183,  170,  179,  173,  174,
			  347,  347,  206,  216,  226,  236,  246,  254,  264,  270,
			  276,  286,  296,  306,  316,  326,  336, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,   81,    1,   82,   82,   83,   83,   84,   84,   85,
			   85,   81,   86,   81,   87,   81,   88,   89,   89,   81,
			   90,   91,   91,   81,   81,   92,   93,   81,   81,   81,
			   81,   86,   81,   87,   81,   87,   87,   94,   88,   89,
			   89,   89,   90,   91,   81,   81,   91,   92,   81,   93,
			   81,   81,   81,   95,   81,   96,   95,   87,   81,   89,
			   89,   95,   95,   96,   95,   89,   89,   95,   81,   81,
			   89,   89,   81,   89,   89,   81,   81,   81,   81,   81,
			   81,    0,   81,   81,   81,   81,   81,   81,   81,   81,
			   81,   81,   81,   81,   81,   81,   81, yy_Dummy>>)
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
			   22,   22,   22,   18,    1,   19,    1,    1,    1,    1,
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
			   75,   76,   76,   77,   77,   77,   78,   79,   79,   79,
			   79,   81,   82,   82,   83,   84,   84,   84,   84,   84,
			   84,   85,   85, yy_Dummy>>)
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
			   18,   17,   11,   -7,    5,    5,  -26,    5,    5,    2,
			    5,    5,    5,    5,    1, yy_Dummy>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 347
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 81
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 82
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

end -- class CLASSNAME_FINDER
