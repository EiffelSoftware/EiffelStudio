note

	description:

		"Calculator with memory"

	copyright: "Copyright (c) 1999-2006, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class MCALC

inherit

	YY_PARSER_SKELETON
		rename
			make as make_parser_skeleton
		end

	KL_IMPORTED_STRING_ROUTINES

create

	make, execute


feature -- Last values

	last_any_value: ANY
	last_double_value: DOUBLE
	last_string_value: STRING

feature -- Access

	token_name (a_token: INTEGER): STRING
			-- Name of token `a_token'
		do
			inspect a_token
			when 0 then
				Result := "EOF token"
			when -1 then
				Result := "Error token"
			when NUM then
				Result := "NUM"
			when VAR then
				Result := "VAR"
			when ASSIGNMENT then
				Result := "ASSIGNMENT"
			when NEG then
				Result := "NEG"
			else
				Result := yy_character_token_name (a_token)
			end
		end

feature -- Token codes

	NUM: INTEGER = 258
	VAR: INTEGER = 259
	ASSIGNMENT: INTEGER = 260
	NEG: INTEGER = 261

feature {NONE} -- Implementation

	yy_build_parser_tables
			-- Build parser tables.
		do
			yytranslate := yytranslate_template
			yyr1 := yyr1_template
			yytypes1 := yytypes1_template
			yytypes2 := yytypes2_template
			yydefact := yydefact_template
			yydefgoto := yydefgoto_template
			yypact := yypact_template
			yypgoto := yypgoto_template
			yytable := yytable_template
			yycheck := yycheck_template
		end

	yy_create_value_stacks
			-- Create value stacks.
		do
		end

	yy_init_value_stacks
			-- Initialize value stacks.
		do
			yyvsp1 := -1
			yyvsp2 := -1
			yyvsp3 := -1
		end

	yy_clear_value_stacks
			-- Clear objects in semantic value stacks so that
			-- they can be collected by the garbage collector.
		local
			l_yyvs1_default_item: ANY
			l_yyvs2_default_item: DOUBLE
			l_yyvs3_default_item: STRING
		do
			if yyvs1 /= Void then
				yyvs1.fill_with (l_yyvs1_default_item, 0, yyvs1.upper)
			end
			if yyvs2 /= Void then
				yyvs2.fill_with (l_yyvs2_default_item, 0, yyvs2.upper)
			end
			if yyvs3 /= Void then
				yyvs3.fill_with (l_yyvs3_default_item, 0, yyvs3.upper)
			end
		end

	yy_push_last_value (yychar1: INTEGER)
			-- Push semantic value associated with token `last_token'
			-- (with internal id `yychar1') on top of corresponding
			-- value stack.
		do
			inspect yytypes2.item (yychar1)
			when 1 then
				yyvsp1 := yyvsp1 + 1
				if yyvsp1 >= yyvsc1 then
					if yyvs1 = Void then
						debug ("GEYACC")
							std.error.put_line ("Create yyvs1")
						end
						create yyspecial_routines1
						yyvsc1 := yyInitial_yyvs_size
						yyvs1 := yyspecial_routines1.make (yyvsc1)
					else
						debug ("GEYACC")
							std.error.put_line ("Resize yyvs1")
						end
						yyvsc1 := yyvsc1 + yyInitial_yyvs_size
						yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
					end
				end
				yyspecial_routines1.force (yyvs1, last_any_value, yyvsp1)
			when 2 then
				yyvsp2 := yyvsp2 + 1
				if yyvsp2 >= yyvsc2 then
					if yyvs2 = Void then
						debug ("GEYACC")
							std.error.put_line ("Create yyvs2")
						end
						create yyspecial_routines2
						yyvsc2 := yyInitial_yyvs_size
						yyvs2 := yyspecial_routines2.make (yyvsc2)
					else
						debug ("GEYACC")
							std.error.put_line ("Resize yyvs2")
						end
						yyvsc2 := yyvsc2 + yyInitial_yyvs_size
						yyvs2 := yyspecial_routines2.resize (yyvs2, yyvsc2)
					end
				end
				yyspecial_routines2.force (yyvs2, last_double_value, yyvsp2)
			when 3 then
				yyvsp3 := yyvsp3 + 1
				if yyvsp3 >= yyvsc3 then
					if yyvs3 = Void then
						debug ("GEYACC")
							std.error.put_line ("Create yyvs3")
						end
						create yyspecial_routines3
						yyvsc3 := yyInitial_yyvs_size
						yyvs3 := yyspecial_routines3.make (yyvsc3)
					else
						debug ("GEYACC")
							std.error.put_line ("Resize yyvs3")
						end
						yyvsc3 := yyvsc3 + yyInitial_yyvs_size
						yyvs3 := yyspecial_routines3.resize (yyvs3, yyvsc3)
					end
				end
				yyspecial_routines3.force (yyvs3, last_string_value, yyvsp3)
			else
				debug ("GEYACC")
					std.error.put_string ("Error in parser: not a token type: ")
					std.error.put_integer (yytypes2.item (yychar1))
					std.error.put_new_line
				end
				abort
			end
		end

	yy_push_error_value
			-- Push semantic value associated with token 'error'
			-- on top of corresponding value stack.
		local
			yyval1: ANY
		do
			yyvsp1 := yyvsp1 + 1
			if yyvsp1 >= yyvsc1 then
				if yyvs1 = Void then
					debug ("GEYACC")
						std.error.put_line ("Create yyvs1")
					end
					create yyspecial_routines1
					yyvsc1 := yyInitial_yyvs_size
					yyvs1 := yyspecial_routines1.make (yyvsc1)
				else
					debug ("GEYACC")
						std.error.put_line ("Resize yyvs1")
					end
					yyvsc1 := yyvsc1 + yyInitial_yyvs_size
					yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
				end
			end
			yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
		end

	yy_pop_last_value (yystate: INTEGER)
			-- Pop semantic value from stack when in state `yystate'.
		local
			yy_type_id: INTEGER
		do
			yy_type_id := yytypes1.item (yystate)
			inspect yy_type_id
			when 1 then
				yyvsp1 := yyvsp1 - 1
			when 2 then
				yyvsp2 := yyvsp2 - 1
			when 3 then
				yyvsp3 := yyvsp3 - 1
			else
				debug ("GEYACC")
					std.error.put_string ("Error in parser: unknown type id: ")
					std.error.put_integer (yy_type_id)
					std.error.put_new_line
				end
				abort
			end
		end

feature {NONE} -- Semantic actions

	yy_do_action (yy_act: INTEGER)
			-- Execute semantic action.
		local
			yyval1: ANY
			yyval2: DOUBLE
		do
			inspect yy_act
when 1 then
--|#line 43 "mcalc.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'mcalc.y' at line 43")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp1 := yyvsp1 + 1
	if yyvsp1 >= yyvsc1 then
		if yyvs1 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs1")
			end
			create yyspecial_routines1
			yyvsc1 := yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.make (yyvsc1)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs1")
			end
			yyvsc1 := yyvsc1 + yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
		end
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 2 then
--|#line 44 "mcalc.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'mcalc.y' at line 44")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 3 then
--|#line 47 "mcalc.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'mcalc.y' at line 47")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 4 then
--|#line 48 "mcalc.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'mcalc.y' at line 48")
end

print (yyvs2.item (yyvsp2).out); print ("%N") 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp2 := yyvsp2 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 5 then
--|#line 49 "mcalc.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'mcalc.y' at line 49")
end

recover 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 6 then
--|#line 52 "mcalc.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'mcalc.y' at line 52")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 7 then
--|#line 53 "mcalc.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'mcalc.y' at line 53")
end

yyval2 := memory_value (yyvs3.item (yyvsp3)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp2 := yyvsp2 + 1
	yyvsp3 := yyvsp3 -1
	if yyvsp2 >= yyvsc2 then
		if yyvs2 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs2")
			end
			create yyspecial_routines2
			yyvsc2 := yyInitial_yyvs_size
			yyvs2 := yyspecial_routines2.make (yyvsc2)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs2")
			end
			yyvsc2 := yyvsc2 + yyInitial_yyvs_size
			yyvs2 := yyspecial_routines2.resize (yyvs2, yyvsc2)
		end
	end
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 8 then
--|#line 54 "mcalc.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'mcalc.y' at line 54")
end

yyval2 := yyvs2.item (yyvsp2); set_memory_value (yyval2, yyvs3.item (yyvsp3)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp3 := yyvsp3 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 9 then
--|#line 55 "mcalc.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'mcalc.y' at line 55")
end

yyval2 := yyvs2.item (yyvsp2 - 1) + yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 10 then
--|#line 56 "mcalc.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'mcalc.y' at line 56")
end

yyval2 := yyvs2.item (yyvsp2 - 1) - yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 11 then
--|#line 57 "mcalc.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'mcalc.y' at line 57")
end

yyval2 := yyvs2.item (yyvsp2 - 1) * yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 12 then
--|#line 58 "mcalc.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'mcalc.y' at line 58")
end

yyval2 := yyvs2.item (yyvsp2 - 1) / yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 13 then
--|#line 59 "mcalc.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'mcalc.y' at line 59")
end

yyval2 := -yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 14 then
--|#line 60 "mcalc.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'mcalc.y' at line 60")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
			else
				debug ("GEYACC")
					std.error.put_string ("Error in parser: unknown rule id: ")
					std.error.put_integer (yy_act)
					std.error.put_new_line
				end
				abort
			end
		end

	yy_do_error_action (yy_act: INTEGER)
			-- Execute error action.
		do
			inspect yy_act
			when 24 then
					-- End-of-file expected action.
				report_eof_expected_error
			else
					-- Default action.
				report_error ("parse error")
			end
		end

feature {NONE} -- Table templates

	yytranslate_template: SPECIAL [INTEGER]
			-- Template for `yytranslate'
		once
			Result := yyfixed_array (<<
			    0,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			   12,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			   13,   14,    8,    7,    2,    6,    2,    9,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,   11,    2,    2,    2,    2,    2,

			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,

			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    1,    2,    3,    4,
			    5,   10, yyDummy>>)
		end

	yyr1_template: SPECIAL [INTEGER]
			-- Template for `yyr1'
		once
			Result := yyfixed_array (<<
			    0,   16,   16,   17,   17,   17,   15,   15,   15,   15,
			   15,   15,   15,   15,   15, yyDummy>>)
		end

	yytypes1_template: SPECIAL [INTEGER]
			-- Template for `yytypes1'
		once
			Result := yyfixed_array (<<
			    1,    1,    1,    1,    1,    3,    2,    1,    2,    1,
			    2,    2,    1,    1,    1,    1,    1,    1,    1,    1,
			    2,    2,    2,    2,    2,    1,    1, yyDummy>>)
		end

	yytypes2_template: SPECIAL [INTEGER]
			-- Template for `yytypes2'
		once
			Result := yyfixed_array (<<
			    1,    1,    1,    2,    3,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1, yyDummy>>)
		end

	yydefact_template: SPECIAL [INTEGER]
			-- Template for `yydefact'
		once
			Result := yyfixed_array (<<
			    1,    0,    0,    3,    0,    7,    6,    0,    0,    2,
			    0,   13,    0,    5,    4,    0,    0,    0,    0,   14,
			    8,   12,   11,    9,   10,    0,    0, yyDummy>>)
		end

	yydefgoto_template: SPECIAL [INTEGER]
			-- Template for `yydefgoto'
		once
			Result := yyfixed_array (<<
			    8,    1,    9, yyDummy>>)
		end

	yypact_template: SPECIAL [INTEGER]
			-- Template for `yypact'
		once
			Result := yyfixed_array (<<
			 -32768,    5,   16, -32768,   16,    2, -32768,    0,   26, -32768,
			   17, -32768,   16, -32768, -32768,   16,   16,   16,   16, -32768,
			   33, -32768, -32768,   -5,   -5,    1, -32768, yyDummy>>)
		end

	yypgoto_template: SPECIAL [INTEGER]
			-- Template for `yypgoto'
		once
			Result := yyfixed_array (<<
			   -2, -32768, -32768, yyDummy>>)
		end

	yytable_template: SPECIAL [INTEGER]
			-- Template for `yytable'
		once
			Result := yyfixed_array (<<
			   10,   26,   11,   16,   15,   25,    7,   12,    6,    5,
			   20,    4,   13,   21,   22,   23,   24,    3,    2,    6,
			    5,    0,    4,   18,   17,   16,   15,    0,    0,    2,
			    0,   19,   18,   17,   16,   15,    0,    0,   14,   18,
			   17,   16,   15, yyDummy>>)
		end

	yycheck_template: SPECIAL [INTEGER]
			-- Template for `yycheck'
		once
			Result := yyfixed_array (<<
			    2,    0,    4,    8,    9,    0,    1,    5,    3,    4,
			   12,    6,   12,   15,   16,   17,   18,   12,   13,    3,
			    4,   -1,    6,    6,    7,    8,    9,   -1,   -1,   13,
			   -1,   14,    6,    7,    8,    9,   -1,   -1,   12,    6,
			    7,    8,    9, yyDummy>>)
		end

feature {NONE} -- Semantic value stacks

	yyvs1: SPECIAL [ANY]
			-- Stack for semantic values of type ANY

	yyvsc1: INTEGER
			-- Capacity of semantic value stack `yyvs1'

	yyvsp1: INTEGER
			-- Top of semantic value stack `yyvs1'

	yyspecial_routines1: KL_SPECIAL_ROUTINES [ANY]
			-- Routines that ought to be in SPECIAL [ANY]

	yyvs2: SPECIAL [DOUBLE]
			-- Stack for semantic values of type DOUBLE

	yyvsc2: INTEGER
			-- Capacity of semantic value stack `yyvs2'

	yyvsp2: INTEGER
			-- Top of semantic value stack `yyvs2'

	yyspecial_routines2: KL_SPECIAL_ROUTINES [DOUBLE]
			-- Routines that ought to be in SPECIAL [DOUBLE]

	yyvs3: SPECIAL [STRING]
			-- Stack for semantic values of type STRING

	yyvsc3: INTEGER
			-- Capacity of semantic value stack `yyvs3'

	yyvsp3: INTEGER
			-- Top of semantic value stack `yyvs3'

	yyspecial_routines3: KL_SPECIAL_ROUTINES [STRING]
			-- Routines that ought to be in SPECIAL [STRING]

feature {NONE} -- Constants

	yyFinal: INTEGER = 26
			-- Termination state id

	yyFlag: INTEGER = -32768
			-- Most negative INTEGER

	yyNtbase: INTEGER = 15
			-- Number of tokens

	yyLast: INTEGER = 42
			-- Upper bound of `yytable' and `yycheck'

	yyMax_token: INTEGER = 261
			-- Maximum token id
			-- (upper bound of `yytranslate'.)

	yyNsyms: INTEGER = 18
			-- Number of symbols
			-- (terminal and nonterminal)

feature -- User-defined features



feature {NONE} -- Initialization

	make
			-- Create a new calculator with memory.
		do
			make_parser_skeleton
			create memory_values.make (10)
		end

	execute
			-- Run calculator.
		do
			make
			parse
		end

feature -- Memory management

	memory_value (a_name: STRING): DOUBLE
			-- Value associated with memory a_name;
			-- 0.0 if no value has been stored in a_name yet
		require
			a_name_not_void: a_name /= Void
		do
			if memory_values.has (a_name) then
				Result := memory_values.item (a_name)
			else
				Result := 0.0
			end
		end

	set_memory_value (a_value: DOUBLE; a_name: STRING)
			-- Store a_value into a_name.
		require
			a_name_not_void: a_name /= Void
		do
			memory_values.force (a_value, a_name)
		ensure
			memory_value_set: memory_value (a_name) = a_value
		end

feature {NONE} -- Scanner

	read_token
			-- Lexical analyzer returns a double floating point
			-- number on the stack and the token NUM, a STRING and
			-- and the token VAR, a token ASSIGNMENT, or the ASCII
			-- character read if not a number. Skips all blanks
			-- and tabs, returns 0 for EOF.
		local
			c: CHARACTER
			buffer: STRING
		do
				-- Skip white space
			from
				if has_pending_character then
					c := pending_character
					has_pending_character := False
				elseif not std.input.end_of_file then
					std.input.read_character
					c := std.input.last_character
				end
			until
				std.input.end_of_file or else
				(c /= ' ' and c /= '%T')
			loop
				std.input.read_character
				c := std.input.last_character
			end
			if std.input.end_of_file then
					-- Return end-of-file
				last_token := 0
			else
				inspect c
				when '0'..'9' then
						-- Process numbers
					last_token := NUM
					from
						create buffer.make (10)
						buffer.append_character (c)
						std.input.read_character
						c := std.input.last_character
					until
						std.input.end_of_file or else
						(c < '0' or c > '9')
					loop
						buffer.append_character (c)
						std.input.read_character
						c := std.input.last_character
					end
					if not std.input.end_of_file and then c = '.' then
						from
							buffer.append_character ('.')
							std.input.read_character
							c := std.input.last_character
						until
							std.input.end_of_file or else
							(c < '0' or c > '9')
						loop
							buffer.append_character (c)
							std.input.read_character
							c := std.input.last_character
						end
					end
					if not std.input.end_of_file then
						pending_character := c
						has_pending_character := True
					end
					last_double_value := buffer.to_double
				when 'a'..'z', 'A'..'Z' then
						-- Process variables.
					last_token := VAR
					from
						create buffer.make (10)
						buffer.append_character (c)
						std.input.read_character
						c := std.input.last_character
					until
						std.input.end_of_file or else
						not (('a' <= c and c <= 'z') or
							('A' <= c and c <= 'Z') or
							('0' <= c and c <= '9'))
					loop
						buffer.append_character (c)
						std.input.read_character
						c := std.input.last_character
					end
					if not std.input.end_of_file then
						pending_character := c
						has_pending_character := True
					end
					last_string_value := buffer
				when ':' then
					std.input.read_character
					c := std.input.last_character
					if not std.input.end_of_file then
						if c = '=' then
								-- Found ":="
							last_token := ASSIGNMENT
						else
								-- Return single character
							last_token := (':').code
							pending_character := c
							has_pending_character := True
						end
					else
							-- Return single character
						last_token := (':').code 
					end
				else
						-- Return single character
					last_token := c.code
				end
			end
		end

	last_token: INTEGER
			-- Last token read

feature {NONE} -- Implementation

	pending_character: CHARACTER
	has_pending_character: BOOLEAN

	memory_values: DS_HASH_TABLE [DOUBLE, STRING]
			-- Values already stored so far

invariant

	memory_values_not_void: memory_values /= Void

end
