indexing

	description: "Eiffel classname finders"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

				set_start_condition (IN_CLASS)
			
when 2 then
--|#line 33 "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line 33")
end

				classname := text
				last_token := TE_ID
			
when 3 then
--|#line 38 "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line 38")
end
-- Ignore
when 4 then
--|#line 39 "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line 39")
end
-- Ignore
when 5 then
--|#line 43 "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line 43")
end
-- Ignore
when 6 then
--|#line 45 "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line 45")
end

				verbatim_marker.clear_all
				append_text_substring_to_string (2, text_count - 1, verbatim_marker)
				last_start_condition := start_condition
				set_start_condition (VERBATIM_STR3)
			
when 7 then
--|#line 52 "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line 52")
end
-- Ignore
when 8 then
--|#line 53 "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line 53")
end
-- Ignore
when 9 then
--|#line 54 "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line 54")
end
-- Ignore
when 10 then
--|#line 59 "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line 59")
end

				set_start_condition (VERBATIM_STR1)
			
when 11 then
--|#line 62 "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line 62")
end

					-- No final bracket-double-quote.
				set_start_condition (last_start_condition)
			
when 12 then
--|#line 74 "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line 74")
end

				if is_verbatim_string_closer then
					set_start_condition (last_start_condition)
				else
					set_start_condition (VERBATIM_STR2)
				end
			
when 13 then
--|#line 81 "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line 81")
end

				set_start_condition (VERBATIM_STR2)
			
when 14 then
--|#line 84 "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line 84")
end

				-- Ignore.
			
when 15 then
--|#line 87 "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line 87")
end

					-- No final bracket-double-quote.
				set_start_condition (last_start_condition)
			
when 16 then
--|#line 99 "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line 99")
end

				set_start_condition (VERBATIM_STR1)
			
when 17 then
--|#line 102 "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line 102")
end

					-- No final bracket-double-quote.
				set_start_condition (last_start_condition)
			
when 18 then
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
			   16,   17,   16,   16,   12,   12,   12,   16,   16,   17,
			   16,   16,   18,   18,   13,   14,   18,   15,   18,   18,
			   19,   19,   19,   19,   19,   18,   18,   18,   19,   19,
			   19,   19,   19,   21,   22,   23,   28,   29,   28,   29,
			   33,   34,   58,   39,   42,   43,   24,   21,   22,   23,
			   35,   39,   42,   46,   41,   49,   50,   48,   52,   53,
			   24,   30,   30,   54,   31,   30,   48,   30,   37,   37,
			   37,   38,   37,   37,   30,   30,   37,   37,   37,   38,
			   37,   37,   44,   42,   43,   57,   33,   34,   42,   43,

			   42,   46,   41,   57,   36,   45,   35,   55,   56,   33,
			   34,   49,   50,   61,   33,   34,   52,   53,   31,   35,
			   44,   42,   43,   53,   53,   61,   51,   59,   51,   58,
			   60,   26,   26,   45,   61,   59,   61,   61,   60,   20,
			   20,   20,   20,   20,   20,   20,   20,   25,   25,   25,
			   25,   25,   25,   25,   25,   27,   27,   27,   27,   27,
			   27,   27,   27,   30,   61,   61,   61,   30,   61,   30,
			   32,   61,   32,   32,   32,   32,   32,   32,   38,   38,
			   38,   38,   40,   40,   40,   40,   41,   41,   41,   41,
			   41,   41,   41,   41,   45,   45,   45,   45,   45,   45,

			   45,   45,   47,   47,   47,   47,   47,   47,   47,   47,
			   51,   51,   51,   51,   51,   51,   51,   51,   36,   61,
			   36,   36,   36,   36,   36,   36,   11,   61,   61,   61,
			   61,   61,   61,   61,   61,   61,   61,   61,   61,   61,
			   61,   61,   61,   61,   61,   61,   61,   61, yy_Dummy>>)
		end

	yy_chk_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    3,    3,    3,    3,    3,    3,    3,    3,
			    3,    3,    3,    3,    3,    3,    3,    3,    3,    3,
			    3,    3,    3,    5,    5,    5,    9,    9,   10,   10,
			   14,   14,   54,   17,   20,   20,    5,    6,    6,    6,
			   14,   17,   24,   24,   24,   28,   28,   47,   34,   34,
			    6,   16,   16,   34,   31,   16,   25,   16,   16,   16,
			   16,   16,   16,   16,   16,   16,   16,   16,   16,   16,
			   16,   16,   21,   21,   21,   39,   32,   32,   41,   41,

			   45,   45,   45,   39,   15,   21,   32,   35,   35,   35,
			   35,   49,   49,   51,   51,   51,   52,   52,   13,   35,
			   44,   44,   44,   53,   53,   11,   53,   57,   58,   58,
			   59,    8,    7,   44,    0,   57,    0,    0,   59,   62,
			   62,   62,   62,   62,   62,   62,   62,   63,   63,   63,
			   63,   63,   63,   63,   63,   64,   64,   64,   64,   64,
			   64,   64,   64,   65,    0,    0,    0,   65,    0,   65,
			   66,    0,   66,   66,   66,   66,   66,   66,   67,   67,
			   67,   67,   68,   68,   68,   68,   69,   69,   69,   69,
			   69,   69,   69,   69,   70,   70,   70,   70,   70,   70,

			   70,   70,   71,   71,   71,   71,   71,   71,   71,   71,
			   72,   72,   72,   72,   72,   72,   72,   72,   73,    0,
			   73,   73,   73,   73,   73,   73,   61,   61,   61,   61,
			   61,   61,   61,   61,   61,   61,   61,   61,   61,   61,
			   61,   61,   61,   61,   61,   61,   61,   61, yy_Dummy>>)
		end

	yy_base_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,   21,    0,   41,   55,  129,  128,   44,
			   46,  125,    0,  115,   46,   98,   70,   41,  226,    0,
			   51,   90,  226,  226,   59,   73,  226,  226,   63,  226,
			    0,   71,   92,  226,   66,  105,    0,    0,    0,   86,
			    0,   95,  226,  226,  118,   97,  226,   64,  226,  109,
			  226,  110,  114,  121,   44,    0,  226,  114,  121,  117,
			    0,  226,  138,  146,  154,  162,  169,  173,  177,  185,
			  193,  201,  209,  217, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,   61,    1,   61,    3,   62,   62,   63,   63,   64,
			   64,   61,   65,   61,   66,   61,   61,   67,   61,   68,
			   69,   69,   61,   61,   70,   71,   61,   61,   61,   61,
			   65,   61,   66,   61,   72,   66,   73,   16,   67,   67,
			   68,   69,   61,   61,   69,   70,   61,   71,   61,   61,
			   61,   72,   61,   61,   61,   35,   61,   67,   61,   67,
			   67,    0,   61,   61,   61,   61,   61,   61,   61,   61,
			   61,   61,   61,   61, yy_Dummy>>)
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
			   10,   10,   10,   10,   10,   10,   12,   10,   10,   10,
			   10,   10,   10,   13,   10,   10,   10,   10,   10,   10,
			   10,   14,    1,   15,    1,   16,    1,   17,   18,   19,

			   18,   18,   18,   18,   18,   18,   18,   18,   20,   18,
			   18,   18,   18,   18,   18,   21,   18,   18,   18,   18,
			   18,   18,   18,    1,    1,    1,    1,    1,    1,    1,
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
			    5,    6,    5,    7,    1,    1,    5,    5,    5,    8,
			    5,    5, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    1,    2,    3,    3,    3,    4,    5,    6,    7,
			    7,    7,    8,   11,   13,   15,   17,   21,   24,   26,
			   29,   31,   33,   35,   37,   39,   41,   43,   45,   47,
			   49,   50,   51,   51,   52,   52,   53,   54,   56,   57,
			   58,   59,   60,   61,   62,   63,   64,   66,   67,   68,
			   68,   69,   69,   69,   69,   69,   69,   70,   71,   71,
			   72,   74,   74, yy_Dummy>>)
		end

	yy_acclist_template: SPECIAL [INTEGER] is
		once
			Result := yy_fixed_array (<<
			    0,    3,    3,   15,   15,   17,   17,   19,    3,    9,
			   18,    8,   18,    9,   18,    9,   18,    3,    4,    9,
			   18,    4,    9,   18,    9,   18,    2,    9,   18,   15,
			   18,   15,   18,   14,   18,   13,   18,   15,   18,   17,
			   18,   16,   18,   11,   18,   11,   18,   10,   18,    3,
			    8,    5,  -24,    7,    3,    4,    4,    4,    2,   15,
			   14,   13,   15,   15,   12,   13,   17,   16,   10,   -6,
			    4,    4,    1,    4, yy_Dummy>>)
		end

feature {NONE} -- Constants

	yyJam_base: INTEGER is 226
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER is 61
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER is 62
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

	yyNb_rules: INTEGER is 18
			-- Number of rules

	yyEnd_of_buffer: INTEGER is 19
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
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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


