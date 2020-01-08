note

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

	valid_start_condition (sc: INTEGER): BOOLEAN
			-- Is `sc' a valid start condition?
		do
			Result := (INITIAL <= sc and sc <= VERBATIM_STR3)
		end

feature {NONE} -- Implementation

	yy_build_tables
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

	yy_execute_action (yy_act: INTEGER)
			-- Execute semantic action.
		do
			inspect yy_act
when 1 then
--|#line <not available> "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line <not available>")
end

				set_start_condition (IN_CLASS)
				set_partial_class (True)
			
when 2 then
--|#line <not available> "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line <not available>")
end

				set_start_condition (IN_CLASS)
				set_partial_class (False)
			
when 3 then
--|#line <not available> "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line <not available>")
end

				classname := text
					-- Class name has been found so we terminate parser
				terminate
			
when 4 then
--|#line <not available> "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line <not available>")
end
-- Ignore
when 5 then
--|#line <not available> "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line <not available>")
end
-- Ignore
when 6 then
--|#line <not available> "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line <not available>")
end
-- Ignore
when 7 then
--|#line <not available> "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line <not available>")
end

				verbatim_marker.wipe_out
				if text_item (text_count) = '[' then
					verbatim_marker.append_character (']')
				else
					verbatim_marker.append_character ('}')
				end
				append_text_substring_to_string (2, text_count - 1, verbatim_marker)
				last_start_condition := start_condition
				set_start_condition (VERBATIM_STR3)
			
when 8 then
--|#line <not available> "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line <not available>")
end
-- Ignore
when 9 then
--|#line <not available> "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line <not available>")
end
-- Ignore
when 10 then
--|#line <not available> "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line <not available>")
end
-- Ignore
when 11 then
--|#line <not available> "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line <not available>")
end

				set_start_condition (VERBATIM_STR1)
			
when 12 then
--|#line <not available> "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line <not available>")
end

					-- No final bracket-double-quote.
				set_start_condition (last_start_condition)
			
when 13 then
--|#line <not available> "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line <not available>")
end

				if is_verbatim_string_closer then
					set_start_condition (last_start_condition)
				else
					set_start_condition (VERBATIM_STR2)
				end
			
when 14 then
--|#line <not available> "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line <not available>")
end

				set_start_condition (VERBATIM_STR2)
			
when 15 then
--|#line <not available> "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line <not available>")
end

				-- Ignore.
			
when 16 then
--|#line <not available> "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line <not available>")
end

					-- No final bracket-double-quote.
				set_start_condition (last_start_condition)
			
when 17 then
--|#line <not available> "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line <not available>")
end

				set_start_condition (VERBATIM_STR1)
			
when 18 then
--|#line <not available> "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line <not available>")
end

					-- No final bracket-double-quote.
				set_start_condition (last_start_condition)
			
when 19 then
--|#line <not available> "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line <not available>")
end
last_token := yyError_token
fatal_error ("scanner jammed")
			else
				last_token := yyError_token
				fatal_error ("fatal scanner internal error: no action found")
			end
		end

	yy_execute_eof_action (yy_sc: INTEGER)
			-- Execute EOF semantic action.
		do
			inspect yy_sc
when 2 then
--|#line <not available> "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line <not available>")
end

					-- No final bracket-double-quote.
				set_start_condition (last_start_condition)
			
when 3 then
--|#line <not available> "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line <not available>")
end

					-- No final bracket-double-quote.
				set_start_condition (last_start_condition)
			
when 4 then
--|#line <not available> "classname_finder.l"
debug ("GELEX")
	std.error.put_line ("Executing scanner user-code from file 'classname_finder.l' at line <not available>")
end

					-- No final bracket-double-quote.
				set_start_condition (last_start_condition)
			
			else
				terminate
			end
		end

feature {NONE} -- Table templates

	yy_nxt_template: SPECIAL [INTEGER]
			-- Template for `yy_nxt'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 305)
			yy_nxt_template_1 (an_array)
			yy_nxt_template_2 (an_array)
			an_array.area.fill_with (81, 277, 305)
			Result := yy_fixed_array (an_array)
		end

	yy_nxt_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			    0,   12,   13,   14,   12,   15,   12,   12,   16,   16,
			   17,   16,   16,   18,   16,   16,   16,   12,   12,   12,
			   16,   16,   17,   16,   16,   18,   16,   16,   16,   12,
			   19,   13,   14,   19,   15,   19,   19,   22,   23,   24,
			   22,   23,   24,   29,   30,   72,   19,   19,   19,   29,
			   30,   50,   34,   35,   25,   40,   41,   25,   19,   19,
			   13,   14,   19,   15,   19,   19,   36,   40,   41,   44,
			   45,   32,   46,   44,   45,   19,   19,   19,   44,   48,
			   51,   52,   34,   35,   44,   45,   59,   19,   31,   47,
			   60,   31,   50,   31,   44,   48,   36,   39,   59,   31,

			   39,   31,   60,   65,   31,   31,   46,   44,   45,   39,
			   51,   52,   39,   53,   54,   65,   31,   53,   54,   55,
			   34,   63,   56,   47,   54,   54,   81,   55,   66,   62,
			   81,   64,   70,   36,   57,   58,   34,   35,   68,   54,
			   66,   62,   67,   58,   70,   62,   37,   68,   54,   32,
			   36,   31,   69,   81,   31,   27,   31,   71,   62,   27,
			   39,   81,   73,   39,   81,   33,   64,   31,   31,   71,
			   67,   58,   39,   74,   73,   39,   62,   55,   72,   31,
			   57,   58,   34,   35,   81,   74,   62,   75,   75,   75,
			   75,   77,   78,   79,   80,   81,   36,   81,   76,   38, yy_Dummy>>,
			1, 200, 0)
		end

	yy_nxt_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_nxt'.
		do
			yy_array_subcopy (an_array, <<
			   38,   38,   81,   77,   78,   79,   80,   39,   39,   81,
			   76,   20,   20,   20,   20,   20,   20,   21,   21,   21,
			   21,   21,   21,   26,   26,   26,   26,   26,   26,   28,
			   28,   28,   28,   28,   28,   33,   33,   33,   33,   33,
			   42,   42,   43,   43,   43,   43,   43,   43,   47,   47,
			   47,   47,   47,   47,   49,   49,   49,   49,   49,   49,
			   37,   37,   37,   37,   37,   61,   81,   61,   61,   61,
			   61,   55,   55,   55,   55,   55,   11, yy_Dummy>>,
			1, 77, 200)
		end

	yy_chk_template: SPECIAL [INTEGER]
			-- Template for `yy_chk'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 305)
			an_array.put (0, 0)
			an_array.area.fill_with (1, 1, 29)
			yy_chk_template_1 (an_array)
			yy_chk_template_2 (an_array)
			an_array.area.fill_with (81, 276, 305)
			Result := yy_fixed_array (an_array)
		end

	yy_chk_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			    3,    3,    3,    3,    3,    3,    3,    5,    5,    5,
			    6,    6,    6,    9,    9,   69,    3,    3,    3,   10,
			   10,   49,   14,   14,    5,   17,   18,    6,    3,    4,
			    4,    4,    4,    4,    4,    4,   14,   17,   18,   21,
			   21,   32,   22,   22,   22,    4,    4,    4,   25,   25,
			   29,   29,   33,   33,   43,   43,   40,    4,   16,   22,
			   41,   16,   26,   16,   47,   47,   33,   16,   40,   86,
			   16,   86,   41,   59,   16,   16,   46,   46,   46,   16,
			   51,   51,   16,   53,   53,   59,   16,   35,   35,   35,
			   55,   55,   35,   46,   54,   54,   56,   54,   60,   53,

			   61,   56,   65,   35,   36,   36,   36,   36,   68,   68,
			   60,   56,   62,   62,   65,   61,   15,   63,   63,   13,
			   36,   38,   63,   11,   38,    8,   38,   66,   62,    7,
			   38,   64,   71,   38,    0,   64,   64,   38,   38,   66,
			   67,   67,   38,   73,   71,   38,   64,   72,   72,   38,
			   57,   57,   57,   57,    0,   73,   67,   74,   74,   75,
			   75,   76,   77,   78,   79,    0,   57,    0,   75,   88,
			   88,   88,    0,   76,   77,   78,   79,   89,   89,    0,
			   75,   82,   82,   82,   82,   82,   82,   83,   83,   83,
			   83,   83,   83,   84,   84,   84,   84,   84,   84,   85, yy_Dummy>>,
			1, 200, 30)
		end

	yy_chk_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yy_chk'.
		do
			yy_array_subcopy (an_array, <<
			   85,   85,   85,   85,   85,   87,   87,   87,   87,   87,
			   90,   90,   91,   91,   91,   91,   91,   91,   92,   92,
			   92,   92,   92,   92,   93,   93,   93,   93,   93,   93,
			   94,   94,   94,   94,   94,   95,    0,   95,   95,   95,
			   95,   96,   96,   96,   96,   96, yy_Dummy>>,
			1, 46, 230)
		end

	yy_base_template: SPECIAL [INTEGER]
			-- Template for `yy_base'
		once
			Result := yy_fixed_array (<<
			    0,    0,    0,   29,   58,   36,   39,  157,  153,   42,
			   48,  153,    0,  147,   49,  141,   87,   43,   48,  276,
			    0,   67,   71,  276,  276,   76,   90,  276,  276,   79,
			  276,    0,   69,   79,  276,  116,  133,    0,  150,    0,
			   78,   76,    0,   82,  276,  276,  105,   92,  276,   49,
			  276,  109,  276,  112,  123,  117,  124,  179,  276,   88,
			  112,  128,  141,  146,  159,  117,  146,  169,  137,   38,
			    0,  154,  171,  161,  186,  188,  179,  184,  178,  179,
			  276,  276,  210,  216,  222,  228,   95,  233,  195,  203,
			  236,  241,  247,  253,  258,  264,  269, yy_Dummy>>)
		end

	yy_def_template: SPECIAL [INTEGER]
			-- Template for `yy_def'
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

	yy_ec_template: SPECIAL [INTEGER]
			-- Template for `yy_ec'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 257)
			yy_ec_template_1 (an_array)
			an_array.area.fill_with (29, 126, 257)
			Result := yy_fixed_array (an_array)
		end

	yy_ec_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yy_ec'.
		do
			yy_array_subcopy (an_array, <<
			    0,   29,   29,   29,   29,   29,   29,   29,   29,    1,
			    2,   29,   29,    1,   29,   29,   29,   29,   29,   29,
			   29,   29,   29,   29,   29,   29,   29,   29,   29,   29,
			   29,   29,    1,   29,    3,   29,   29,    4,   29,   29,
			   29,   29,   29,   29,   29,    5,   29,    6,    7,    7,
			    7,    7,    7,    7,    7,    7,    7,    7,   29,   29,
			   29,   29,   29,   29,   29,    8,    9,   10,    9,    9,
			    9,    9,    9,   11,    9,    9,   12,    9,    9,    9,
			   13,    9,   14,   15,   16,    9,    9,    9,    9,    9,
			    9,   17,   29,   18,   29,   19,   29,   20,   21,   22,

			   21,   21,   21,   21,   21,   23,   21,   21,   24,   21,
			   21,   21,   25,   21,   26,   27,   28,   21,   21,   21,
			   21,   21,   21,   17,   29,   18, yy_Dummy>>,
			1, 126, 0)
		end

	yy_meta_template: SPECIAL [INTEGER]
			-- Template for `yy_meta'
		once
			Result := yy_fixed_array (<<
			    0,    6,    1,    2,    6,    3,    6,    4,    4,    4,
			    5,    4,    4,    5,    4,    4,    4,    6,    6,    4,
			    4,    4,    5,    4,    4,    5,    4,    4,    4,    6, yy_Dummy>>)
		end

	yy_accept_template: SPECIAL [INTEGER]
			-- Template for `yy_accept'
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

	yy_acclist_template: SPECIAL [INTEGER]
			-- Template for `yy_acclist'
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

	yyJam_base: INTEGER = 276
			-- Position in `yy_nxt'/`yy_chk' tables
			-- where default jam table starts

	yyJam_state: INTEGER = 81
			-- State id corresponding to jam state

	yyTemplate_mark: INTEGER = 82
			-- Mark between normal states and templates

	yyNull_equiv_class: INTEGER = 29
			-- Equivalence code for NULL character

	yyMax_symbol_equiv_class: INTEGER = 256
			-- All symbols greater than this symbol will have
			-- the same equivalence class as this symbol

	yyReject_used: BOOLEAN = false
			-- Is `reject' called?

	yyVariable_trail_context: BOOLEAN = true
			-- Is there a regular expression with
			-- both leading and trailing parts having
			-- variable length?

	yyReject_or_variable_trail_context: BOOLEAN = true
			-- Is `reject' called or is there a
			-- regular expression with both leading
			-- and trailing parts having variable length?

	yyNb_rules: INTEGER = 19
			-- Number of rules

	yyEnd_of_buffer: INTEGER = 20
			-- End of buffer rule code

	yyLine_used: BOOLEAN = false
			-- Are line and column numbers used?

	yyPosition_used: BOOLEAN = false
			-- Is `position' used?

	INITIAL: INTEGER = 0
	IN_CLASS: INTEGER = 1
	VERBATIM_STR1: INTEGER = 2
	VERBATIM_STR2: INTEGER = 3
	VERBATIM_STR3: INTEGER = 4
			-- Start condition codes

feature -- User-defined features



note
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
