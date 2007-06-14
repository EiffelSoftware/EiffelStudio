indexing

	description:

		"Infix notation calculator"

	copyright: "Copyright (c) 1999-2003, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class CALC

inherit

	YY_PARSER_SKELETON

	KL_IMPORTED_STRING_ROUTINES

create

	make, execute


feature -- Last values

	last_any_value: ANY
	last_double_value: DOUBLE

feature -- Access

	token_name (a_token: INTEGER): STRING is
			-- Name of token `a_token'
		do
			inspect a_token
			when 0 then
				Result := "EOF token"
			when -1 then
				Result := "Error token"
			when NUM then
				Result := "NUM"
			when NEG then
				Result := "NEG"
			else
				Result := yy_character_token_name (a_token)
			end
		end

feature -- Token codes

	NUM: INTEGER is 258
	NEG: INTEGER is 259

feature {NONE} -- Implementation

	yy_build_parser_tables is
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

	yy_create_value_stacks is
			-- Create value stacks.
		do
		end

	yy_init_value_stacks is
			-- Initialize value stacks.
		do
			yyvsp1 := -1
			yyvsp2 := -1
		end

	yy_clear_value_stacks is
			-- Clear objects in semantic value stacks so that
			-- they can be collected by the garbage collector.
		do
			if yyvs1 /= Void then
				yyvs1.clear_all
			end
			if yyvs2 /= Void then
				yyvs2.clear_all
			end
		end

	yy_push_last_value (yychar1: INTEGER) is
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
				yyvs1.put (last_any_value, yyvsp1)
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
				yyvs2.put (last_double_value, yyvsp2)
			else
				debug ("GEYACC")
					std.error.put_string ("Error in parser: not a token type: ")
					std.error.put_integer (yytypes2.item (yychar1))
					std.error.put_new_line
				end
				abort
			end
		end

	yy_push_error_value is
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
			yyvs1.put (yyval1, yyvsp1)
		end

	yy_pop_last_value (yystate: INTEGER) is
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

	yy_do_action (yy_act: INTEGER) is
			-- Execute semantic action.
		local
			yyval1: ANY
			yyval2: DOUBLE
		do
			inspect yy_act
when 1 then
--|#line 38 "calc.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'calc.y' at line 38")
end


if yy_parsing_status = yyContinue then
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
	yyvs1.put (yyval1, yyvsp1)
end
when 2 then
--|#line 39 "calc.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'calc.y' at line 39")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 3 then
--|#line 42 "calc.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'calc.y' at line 42")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs1.put (yyval1, yyvsp1)
end
when 4 then
--|#line 43 "calc.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'calc.y' at line 43")
end

print (yyvs2.item (yyvsp2).out); print ("%N") 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp2 := yyvsp2 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 5 then
--|#line 44 "calc.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'calc.y' at line 44")
end

recover 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 6 then
--|#line 47 "calc.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'calc.y' at line 47")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 7 then
--|#line 48 "calc.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'calc.y' at line 48")
end

yyval2 := yyvs2.item (yyvsp2 - 1) + yyvs2.item (yyvsp2) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -1
	yyvs2.put (yyval2, yyvsp2)
end
when 8 then
--|#line 49 "calc.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'calc.y' at line 49")
end

yyval2 := yyvs2.item (yyvsp2 - 1) - yyvs2.item (yyvsp2) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -1
	yyvs2.put (yyval2, yyvsp2)
end
when 9 then
--|#line 50 "calc.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'calc.y' at line 50")
end

yyval2 := yyvs2.item (yyvsp2 - 1) * yyvs2.item (yyvsp2) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -1
	yyvs2.put (yyval2, yyvsp2)
end
when 10 then
--|#line 51 "calc.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'calc.y' at line 51")
end

yyval2 := yyvs2.item (yyvsp2 - 1) / yyvs2.item (yyvsp2) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -1
	yyvs2.put (yyval2, yyvsp2)
end
when 11 then
--|#line 52 "calc.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'calc.y' at line 52")
end

yyval2 := -yyvs2.item (yyvsp2) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs2.put (yyval2, yyvsp2)
end
when 12 then
--|#line 53 "calc.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'calc.y' at line 53")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyvs2.put (yyval2, yyvsp2)
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

	yy_do_error_action (yy_act: INTEGER) is
			-- Execute error action.
		do
			inspect yy_act
			when 21 then
					-- End-of-file expected action.
				report_eof_expected_error
			else
					-- Default action.
				report_error ("parse error")
			end
		end

feature {NONE} -- Table templates

	yytranslate_template: SPECIAL [INTEGER] is
			-- Template for `yytranslate'
		once
			Result := yyfixed_array (<<
			    0,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			   10,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			   11,   12,    6,    5,    2,    4,    2,    7,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    9,    2,    2,    2,    2,    2,

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
			    2,    2,    2,    2,    2,    2,    1,    2,    3,    8, yyDummy>>)
		end

	yyr1_template: SPECIAL [INTEGER] is
			-- Template for `yyr1'
		once
			Result := yyfixed_array (<<
			    0,   14,   14,   15,   15,   15,   13,   13,   13,   13,
			   13,   13,   13, yyDummy>>)
		end

	yytypes1_template: SPECIAL [INTEGER] is
			-- Template for `yytypes1'
		once
			Result := yyfixed_array (<<
			    1,    1,    1,    1,    1,    2,    1,    2,    1,    2,
			    2,    1,    1,    1,    1,    1,    1,    1,    2,    2,
			    2,    2,    1,    1, yyDummy>>)
		end

	yytypes2_template: SPECIAL [INTEGER] is
			-- Template for `yytypes2'
		once
			Result := yyfixed_array (<<
			    1,    1,    1,    2,    1,    1,    1,    1,    1,    1,
			    1,    1,    1, yyDummy>>)
		end

	yydefact_template: SPECIAL [INTEGER] is
			-- Template for `yydefact'
		once
			Result := yyfixed_array (<<
			    1,    0,    0,    3,    0,    6,    0,    0,    2,    0,
			   11,    5,    4,    0,    0,    0,    0,   12,   10,    9,
			    7,    8,    0,    0, yyDummy>>)
		end

	yydefgoto_template: SPECIAL [INTEGER] is
			-- Template for `yydefgoto'
		once
			Result := yyfixed_array (<<
			    7,    1,    8, yyDummy>>)
		end

	yypact_template: SPECIAL [INTEGER] is
			-- Template for `yypact'
		once
			Result := yyfixed_array (<<
			 -32768,    5,   18, -32768,   18, -32768,    0,   26, -32768,   13,
			 -32768, -32768, -32768,   18,   18,   18,   18, -32768, -32768, -32768,
			   -3,   -3,    1, -32768, yyDummy>>)
		end

	yypgoto_template: SPECIAL [INTEGER] is
			-- Template for `yypgoto'
		once
			Result := yyfixed_array (<<
			   -2, -32768, -32768, yyDummy>>)
		end

	yytable_template: SPECIAL [INTEGER] is
			-- Template for `yytable'
		once
			Result := yyfixed_array (<<
			    9,   23,   10,   14,   13,   22,    6,    0,    5,    4,
			   11,   18,   19,   20,   21,    3,    2,   16,   15,   14,
			   13,    5,    4,    0,    0,   17,    0,    0,    0,    2,
			   16,   15,   14,   13,    0,    0,   12, yyDummy>>)
		end

	yycheck_template: SPECIAL [INTEGER] is
			-- Template for `yycheck'
		once
			Result := yyfixed_array (<<
			    2,    0,    4,    6,    7,    0,    1,   -1,    3,    4,
			   10,   13,   14,   15,   16,   10,   11,    4,    5,    6,
			    7,    3,    4,   -1,   -1,   12,   -1,   -1,   -1,   11,
			    4,    5,    6,    7,   -1,   -1,   10, yyDummy>>)
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

feature {NONE} -- Constants

	yyFinal: INTEGER is 23
			-- Termination state id

	yyFlag: INTEGER is -32768
			-- Most negative INTEGER

	yyNtbase: INTEGER is 13
			-- Number of tokens

	yyLast: INTEGER is 36
			-- Upper bound of `yytable' and `yycheck'

	yyMax_token: INTEGER is 259
			-- Maximum token id
			-- (upper bound of `yytranslate'.)

	yyNsyms: INTEGER is 16
			-- Number of symbols
			-- (terminal and nonterminal)

feature -- User-defined features



feature {NONE} -- Initialization

	execute is
			-- Run calculator.
		do
			make
			parse
		end

feature {NONE} -- Scanner

	read_token is
			-- Lexical analyzer returns a double floating point
			-- number on the stack and the token NUM, or the ASCII
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
			elseif (c >= '0' and c <= '9') then
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
			elseif c = '%R' then
					-- Bug in Visual Eiffel 2.1: when the Enter Key
					-- is pressed, `read_character' gets '%R' instead
					-- of '%N' or instead of the sequence '%R''%N'.
				last_token := ('%N').code
			else
					-- Return single character
				last_token := c.code
			end
		end

	last_token: INTEGER
			-- Last token read

feature {NONE} -- Implementation

	pending_character: CHARACTER
	has_pending_character: BOOLEAN

end
