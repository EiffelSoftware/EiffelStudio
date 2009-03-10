indexing

	description:

		"Parsers for parser generators such as 'geyacc'"

	library: "Gobo Eiffel Parse Library"
	copyright: "Copyright (c) 1999-2009, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class PR_YACC_PARSER

inherit

	PR_YACC_PARSER_SKELETON

	PR_YACC_SCANNER
		rename
			make as make_yacc_scanner,
			reset as reset_yacc_scanner
		end

create

	make


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
			yyvsp3 := -1
			yyvsp4 := -1
			yyvsp5 := -1
			yyvsp6 := -1
			yyvsp7 := -1
			yyvsp8 := -1
			yyvsp9 := -1
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
			if yyvs3 /= Void then
				yyvs3.clear_all
			end
			if yyvs4 /= Void then
				yyvs4.clear_all
			end
			if yyvs5 /= Void then
				yyvs5.clear_all
			end
			if yyvs6 /= Void then
				yyvs6.clear_all
			end
			if yyvs7 /= Void then
				yyvs7.clear_all
			end
			if yyvs8 /= Void then
				yyvs8.clear_all
			end
			if yyvs9 /= Void then
				yyvs9.clear_all
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
				yyvs2.put (last_string_value, yyvsp2)
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
				yyvs3.put (last_integer_value, yyvsp3)
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
			when 3 then
				yyvsp3 := yyvsp3 - 1
			when 4 then
				yyvsp4 := yyvsp4 - 1
			when 5 then
				yyvsp5 := yyvsp5 - 1
			when 6 then
				yyvsp6 := yyvsp6 - 1
			when 7 then
				yyvsp7 := yyvsp7 - 1
			when 8 then
				yyvsp8 := yyvsp8 - 1
			when 9 then
				yyvsp9 := yyvsp9 - 1
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
			yyval5: PR_TYPE
			yyval2: STRING
			yyval6: DS_ARRAYED_LIST [PR_TYPE]
			yyval8: DS_ARRAYED_LIST [PR_LABELED_TYPE]
			yyval7: PR_LABELED_TYPE
			yyval9: DS_ARRAYED_LIST [STRING]
			yyval4: PR_TOKEN
		do
			inspect yy_act
when 1 then
--|#line 59 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 59")
end

			if successful then
				set_start_symbol
				process_symbols
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp1 := yyvsp1 -4
	yyvs1.put (yyval1, yyvsp1)
end
when 2 then
--|#line 59 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 59")
end

			initialize_grammar
		
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
	yyvs1.put (yyval1, yyvsp1)
end
when 3 then
--|#line 72 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 72")
end

			precedence := 1
		
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
	yyvs1.put (yyval1, yyvsp1)
end
when 4 then
--|#line 76 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 76")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 5 then
--|#line 79 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 79")
end

			last_grammar.eiffel_header.force_last (yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp1 := yyvsp1 + 1
	yyvsp2 := yyvsp2 -1
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
when 6 then
--|#line 83 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 83")
end

			type := Void
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyvs1.put (yyval1, yyvsp1)
end
when 7 then
--|#line 87 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 87")
end

			type := Void
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyvs1.put (yyval1, yyvsp1)
end
when 8 then
--|#line 91 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 91")
end

			precedence := precedence + 1
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 9 then
--|#line 95 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 95")
end

			precedence := precedence + 1
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 10 then
--|#line 99 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 99")
end

			precedence := precedence + 1
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 11 then
--|#line 103 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 103")
end

			if start_symbol /= Void then
				report_multiple_start_declarations_error
			else
				create start_symbol.make (yyvs2.item (yyvsp2), line_nb)
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp2 := yyvsp2 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 12 then
--|#line 111 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 111")
end

			last_grammar.set_expected_conflicts (yyvs3.item (yyvsp3))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp3 := yyvsp3 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 13 then
--|#line 117 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 117")
end

			type := No_type
		
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
	yyvs1.put (yyval1, yyvsp1)
end
when 14 then
--|#line 121 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 121")
end

			type := yyvs5.item (yyvsp5)
			set_no_alias_name (type)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp5 := yyvsp5 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 15 then
--|#line 126 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 126")
end

			type := yyvs5.item (yyvsp5)
			set_alias_name (type, yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp1 := yyvsp1 -1
	yyvsp5 := yyvsp5 -1
	yyvsp2 := yyvsp2 -2
	yyvs1.put (yyval1, yyvsp1)
end
when 16 then
--|#line 133 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 133")
end

			type := No_type
		
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
	yyvs1.put (yyval1, yyvsp1)
end
when 17 then
--|#line 137 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 137")
end

			type := yyvs5.item (yyvsp5)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp5 := yyvsp5 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 18 then
--|#line 143 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 143")
end

			yyval5 := new_type (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp5 := yyvsp5 + 1
	yyvsp2 := yyvsp2 -2
	if yyvsp5 >= yyvsc5 then
		if yyvs5 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs5")
			end
			create yyspecial_routines5
			yyvsc5 := yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.make (yyvsc5)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs5")
			end
			yyvsc5 := yyvsc5 + yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.resize (yyvs5, yyvsc5)
		end
	end
	yyvs5.put (yyval5, yyvsp5)
end
when 19 then
--|#line 147 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 147")
end

			yyval5 := new_basic_type (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp5 := yyvsp5 + 1
	yyvsp2 := yyvsp2 -2
	if yyvsp5 >= yyvsc5 then
		if yyvs5 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs5")
			end
			create yyspecial_routines5
			yyvsc5 := yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.make (yyvsc5)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs5")
			end
			yyvsc5 := yyvsc5 + yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.resize (yyvs5, yyvsc5)
		end
	end
	yyvs5.put (yyval5, yyvsp5)
end
when 20 then
--|#line 151 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 151")
end

			yyval5 := new_basic_type (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp5 := yyvsp5 + 1
	yyvsp2 := yyvsp2 -2
	if yyvsp5 >= yyvsc5 then
		if yyvs5 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs5")
			end
			create yyspecial_routines5
			yyvsc5 := yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.make (yyvsc5)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs5")
			end
			yyvsc5 := yyvsc5 + yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.resize (yyvs5, yyvsc5)
		end
	end
	yyvs5.put (yyval5, yyvsp5)
end
when 21 then
--|#line 155 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 155")
end

			yyval5 := new_basic_type (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp5 := yyvsp5 + 1
	yyvsp2 := yyvsp2 -2
	if yyvsp5 >= yyvsc5 then
		if yyvs5 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs5")
			end
			create yyspecial_routines5
			yyvsc5 := yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.make (yyvsc5)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs5")
			end
			yyvsc5 := yyvsc5 + yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.resize (yyvs5, yyvsc5)
		end
	end
	yyvs5.put (yyval5, yyvsp5)
end
when 22 then
--|#line 159 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 159")
end

			yyval5 := new_basic_type (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp5 := yyvsp5 + 1
	yyvsp2 := yyvsp2 -2
	if yyvsp5 >= yyvsc5 then
		if yyvs5 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs5")
			end
			create yyspecial_routines5
			yyvsc5 := yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.make (yyvsc5)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs5")
			end
			yyvsc5 := yyvsc5 + yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.resize (yyvs5, yyvsc5)
		end
	end
	yyvs5.put (yyval5, yyvsp5)
end
when 23 then
--|#line 163 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 163")
end

			yyval5 := new_basic_type (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp5 := yyvsp5 + 1
	yyvsp2 := yyvsp2 -2
	if yyvsp5 >= yyvsc5 then
		if yyvs5 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs5")
			end
			create yyspecial_routines5
			yyvsc5 := yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.make (yyvsc5)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs5")
			end
			yyvsc5 := yyvsc5 + yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.resize (yyvs5, yyvsc5)
		end
	end
	yyvs5.put (yyval5, yyvsp5)
end
when 24 then
--|#line 167 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 167")
end

			yyval5 := new_basic_type (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp5 := yyvsp5 + 1
	yyvsp2 := yyvsp2 -2
	if yyvsp5 >= yyvsc5 then
		if yyvs5 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs5")
			end
			create yyspecial_routines5
			yyvsc5 := yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.make (yyvsc5)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs5")
			end
			yyvsc5 := yyvsc5 + yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.resize (yyvs5, yyvsc5)
		end
	end
	yyvs5.put (yyval5, yyvsp5)
end
when 25 then
--|#line 171 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 171")
end

			yyval5 := new_basic_type (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp5 := yyvsp5 + 1
	yyvsp2 := yyvsp2 -2
	if yyvsp5 >= yyvsc5 then
		if yyvs5 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs5")
			end
			create yyspecial_routines5
			yyvsc5 := yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.make (yyvsc5)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs5")
			end
			yyvsc5 := yyvsc5 + yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.resize (yyvs5, yyvsc5)
		end
	end
	yyvs5.put (yyval5, yyvsp5)
end
when 26 then
--|#line 175 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 175")
end

			yyval5 := new_basic_type (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp5 := yyvsp5 + 1
	yyvsp2 := yyvsp2 -2
	if yyvsp5 >= yyvsc5 then
		if yyvs5 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs5")
			end
			create yyspecial_routines5
			yyvsc5 := yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.make (yyvsc5)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs5")
			end
			yyvsc5 := yyvsc5 + yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.resize (yyvs5, yyvsc5)
		end
	end
	yyvs5.put (yyval5, yyvsp5)
end
when 27 then
--|#line 179 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 179")
end

			yyval5 := new_basic_type (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp5 := yyvsp5 + 1
	yyvsp2 := yyvsp2 -2
	if yyvsp5 >= yyvsc5 then
		if yyvs5 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs5")
			end
			create yyspecial_routines5
			yyvsc5 := yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.make (yyvsc5)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs5")
			end
			yyvsc5 := yyvsc5 + yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.resize (yyvs5, yyvsc5)
		end
	end
	yyvs5.put (yyval5, yyvsp5)
end
when 28 then
--|#line 183 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 183")
end

			yyval5 := new_basic_type (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp5 := yyvsp5 + 1
	yyvsp2 := yyvsp2 -2
	if yyvsp5 >= yyvsc5 then
		if yyvs5 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs5")
			end
			create yyspecial_routines5
			yyvsc5 := yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.make (yyvsc5)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs5")
			end
			yyvsc5 := yyvsc5 + yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.resize (yyvs5, yyvsc5)
		end
	end
	yyvs5.put (yyval5, yyvsp5)
end
when 29 then
--|#line 187 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 187")
end

			yyval5 := new_basic_type (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp5 := yyvsp5 + 1
	yyvsp2 := yyvsp2 -2
	if yyvsp5 >= yyvsc5 then
		if yyvs5 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs5")
			end
			create yyspecial_routines5
			yyvsc5 := yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.make (yyvsc5)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs5")
			end
			yyvsc5 := yyvsc5 + yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.resize (yyvs5, yyvsc5)
		end
	end
	yyvs5.put (yyval5, yyvsp5)
end
when 30 then
--|#line 191 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 191")
end

			yyval5 := new_basic_type (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp5 := yyvsp5 + 1
	yyvsp2 := yyvsp2 -2
	if yyvsp5 >= yyvsc5 then
		if yyvs5 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs5")
			end
			create yyspecial_routines5
			yyvsc5 := yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.make (yyvsc5)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs5")
			end
			yyvsc5 := yyvsc5 + yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.resize (yyvs5, yyvsc5)
		end
	end
	yyvs5.put (yyval5, yyvsp5)
end
when 31 then
--|#line 195 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 195")
end

			yyval5 := new_basic_type (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp5 := yyvsp5 + 1
	yyvsp2 := yyvsp2 -2
	if yyvsp5 >= yyvsc5 then
		if yyvs5 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs5")
			end
			create yyspecial_routines5
			yyvsc5 := yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.make (yyvsc5)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs5")
			end
			yyvsc5 := yyvsc5 + yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.resize (yyvs5, yyvsc5)
		end
	end
	yyvs5.put (yyval5, yyvsp5)
end
when 32 then
--|#line 199 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 199")
end

			yyval5 := new_basic_type (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp5 := yyvsp5 + 1
	yyvsp2 := yyvsp2 -2
	if yyvsp5 >= yyvsc5 then
		if yyvs5 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs5")
			end
			create yyspecial_routines5
			yyvsc5 := yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.make (yyvsc5)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs5")
			end
			yyvsc5 := yyvsc5 + yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.resize (yyvs5, yyvsc5)
		end
	end
	yyvs5.put (yyval5, yyvsp5)
end
when 33 then
--|#line 203 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 203")
end

			yyval5 := new_basic_type (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp5 := yyvsp5 + 1
	yyvsp2 := yyvsp2 -2
	if yyvsp5 >= yyvsc5 then
		if yyvs5 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs5")
			end
			create yyspecial_routines5
			yyvsc5 := yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.make (yyvsc5)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs5")
			end
			yyvsc5 := yyvsc5 + yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.resize (yyvs5, yyvsc5)
		end
	end
	yyvs5.put (yyval5, yyvsp5)
end
when 34 then
--|#line 207 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 207")
end

			yyval5 := new_basic_type (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp5 := yyvsp5 + 1
	yyvsp2 := yyvsp2 -2
	if yyvsp5 >= yyvsc5 then
		if yyvs5 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs5")
			end
			create yyspecial_routines5
			yyvsc5 := yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.make (yyvsc5)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs5")
			end
			yyvsc5 := yyvsc5 + yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.resize (yyvs5, yyvsc5)
		end
	end
	yyvs5.put (yyval5, yyvsp5)
end
when 35 then
--|#line 211 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 211")
end

			yyval5 := new_basic_type (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp5 := yyvsp5 + 1
	yyvsp2 := yyvsp2 -2
	if yyvsp5 >= yyvsc5 then
		if yyvs5 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs5")
			end
			create yyspecial_routines5
			yyvsc5 := yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.make (yyvsc5)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs5")
			end
			yyvsc5 := yyvsc5 + yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.resize (yyvs5, yyvsc5)
		end
	end
	yyvs5.put (yyval5, yyvsp5)
end
when 36 then
--|#line 215 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 215")
end

			yyval5 := new_basic_type (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp5 := yyvsp5 + 1
	yyvsp2 := yyvsp2 -2
	if yyvsp5 >= yyvsc5 then
		if yyvs5 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs5")
			end
			create yyspecial_routines5
			yyvsc5 := yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.make (yyvsc5)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs5")
			end
			yyvsc5 := yyvsc5 + yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.resize (yyvs5, yyvsc5)
		end
	end
	yyvs5.put (yyval5, yyvsp5)
end
when 37 then
--|#line 219 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 219")
end

			yyval5 := new_basic_type (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp5 := yyvsp5 + 1
	yyvsp2 := yyvsp2 -2
	if yyvsp5 >= yyvsc5 then
		if yyvs5 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs5")
			end
			create yyspecial_routines5
			yyvsc5 := yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.make (yyvsc5)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs5")
			end
			yyvsc5 := yyvsc5 + yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.resize (yyvs5, yyvsc5)
		end
	end
	yyvs5.put (yyval5, yyvsp5)
end
when 38 then
--|#line 223 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 223")
end

			yyval5 := new_type (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp5 := yyvsp5 + 1
	yyvsp2 := yyvsp2 -2
	yyvsp1 := yyvsp1 -2
	if yyvsp5 >= yyvsc5 then
		if yyvs5 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs5")
			end
			create yyspecial_routines5
			yyvsc5 := yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.make (yyvsc5)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs5")
			end
			yyvsc5 := yyvsc5 + yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.resize (yyvs5, yyvsc5)
		end
	end
	yyvs5.put (yyval5, yyvsp5)
end
when 39 then
--|#line 227 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 227")
end

			yyval5 := new_generic_type (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2), yyvs6.item (yyvsp6))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp5 := yyvsp5 + 1
	yyvsp2 := yyvsp2 -2
	yyvsp6 := yyvsp6 -1
	if yyvsp5 >= yyvsc5 then
		if yyvs5 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs5")
			end
			create yyspecial_routines5
			yyvsc5 := yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.make (yyvsc5)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs5")
			end
			yyvsc5 := yyvsc5 + yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.resize (yyvs5, yyvsc5)
		end
	end
	yyvs5.put (yyval5, yyvsp5)
end
when 40 then
--|#line 231 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 231")
end

			yyval5 := new_type (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp5 := yyvsp5 + 1
	yyvsp2 := yyvsp2 -2
	if yyvsp5 >= yyvsc5 then
		if yyvs5 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs5")
			end
			create yyspecial_routines5
			yyvsc5 := yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.make (yyvsc5)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs5")
			end
			yyvsc5 := yyvsc5 + yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.resize (yyvs5, yyvsc5)
		end
	end
	yyvs5.put (yyval5, yyvsp5)
end
when 41 then
--|#line 235 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 235")
end

			yyval5 := new_type (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp5 := yyvsp5 + 1
	yyvsp2 := yyvsp2 -2
	yyvsp1 := yyvsp1 -2
	if yyvsp5 >= yyvsc5 then
		if yyvs5 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs5")
			end
			create yyspecial_routines5
			yyvsc5 := yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.make (yyvsc5)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs5")
			end
			yyvsc5 := yyvsc5 + yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.resize (yyvs5, yyvsc5)
		end
	end
	yyvs5.put (yyval5, yyvsp5)
end
when 42 then
--|#line 239 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 239")
end

			yyval5 := new_generic_type (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2), yyvs6.item (yyvsp6))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp5 := yyvsp5 + 1
	yyvsp2 := yyvsp2 -2
	yyvsp6 := yyvsp6 -1
	if yyvsp5 >= yyvsc5 then
		if yyvs5 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs5")
			end
			create yyspecial_routines5
			yyvsc5 := yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.make (yyvsc5)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs5")
			end
			yyvsc5 := yyvsc5 + yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.resize (yyvs5, yyvsc5)
		end
	end
	yyvs5.put (yyval5, yyvsp5)
end
when 43 then
--|#line 243 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 243")
end

			yyval5 := new_labeled_tuple_type (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2), yyvs8.item (yyvsp8))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp5 := yyvsp5 + 1
	yyvsp2 := yyvsp2 -2
	yyvsp8 := yyvsp8 -1
	if yyvsp5 >= yyvsc5 then
		if yyvs5 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs5")
			end
			create yyspecial_routines5
			yyvsc5 := yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.make (yyvsc5)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs5")
			end
			yyvsc5 := yyvsc5 + yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.resize (yyvs5, yyvsc5)
		end
	end
	yyvs5.put (yyval5, yyvsp5)
end
when 44 then
--|#line 247 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 247")
end

			yyval5 := new_anchored_type (yyvs2.item (yyvsp2 - 2), yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp5 := yyvsp5 + 1
	yyvsp2 := yyvsp2 -3
	if yyvsp5 >= yyvsc5 then
		if yyvs5 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs5")
			end
			create yyspecial_routines5
			yyvsc5 := yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.make (yyvsc5)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs5")
			end
			yyvsc5 := yyvsc5 + yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.resize (yyvs5, yyvsc5)
		end
	end
	yyvs5.put (yyval5, yyvsp5)
end
when 45 then
--|#line 251 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 251")
end

			yyval5 := new_like_current_type (yyvs2.item (yyvsp2 - 2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp5 := yyvsp5 + 1
	yyvsp2 := yyvsp2 -3
	if yyvsp5 >= yyvsc5 then
		if yyvs5 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs5")
			end
			create yyspecial_routines5
			yyvsc5 := yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.make (yyvsc5)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs5")
			end
			yyvsc5 := yyvsc5 + yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.resize (yyvs5, yyvsc5)
		end
	end
	yyvs5.put (yyval5, yyvsp5)
end
when 46 then
--|#line 257 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 257")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
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
	yyvs2.put (yyval2, yyvsp2)
end
when 47 then
--|#line 258 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 258")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 48 then
--|#line 260 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 260")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 49 then
--|#line 262 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 262")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 50 then
--|#line 264 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 264")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 51 then
--|#line 266 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 266")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 52 then
--|#line 268 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 268")
end

yyval2 := "!" 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp2 := yyvsp2 + 1
	yyvsp1 := yyvsp1 -1
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
	yyvs2.put (yyval2, yyvsp2)
end
when 53 then
--|#line 270 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 270")
end

yyval2 := "?" 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp2 := yyvsp2 + 1
	yyvsp1 := yyvsp1 -1
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
	yyvs2.put (yyval2, yyvsp2)
end
when 54 then
--|#line 274 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 274")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
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
	yyvs2.put (yyval2, yyvsp2)
end
when 55 then
--|#line 275 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 275")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 56 then
--|#line 277 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 277")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 57 then
--|#line 279 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 279")
end

yyval2 := "!" 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp2 := yyvsp2 + 1
	yyvsp1 := yyvsp1 -1
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
	yyvs2.put (yyval2, yyvsp2)
end
when 58 then
--|#line 281 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 281")
end

yyval2 := "?" 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp2 := yyvsp2 + 1
	yyvsp1 := yyvsp1 -1
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
	yyvs2.put (yyval2, yyvsp2)
end
when 59 then
--|#line 285 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 285")
end

			yyval6 := yyvs6.item (yyvsp6)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyvs6.put (yyval6, yyvsp6)
end
when 60 then
--|#line 291 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 291")
end

			create yyval6.make (5)
			yyval6.force_last (yyvs5.item (yyvsp5))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp6 := yyvsp6 + 1
	yyvsp5 := yyvsp5 -1
	if yyvsp6 >= yyvsc6 then
		if yyvs6 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs6")
			end
			create yyspecial_routines6
			yyvsc6 := yyInitial_yyvs_size
			yyvs6 := yyspecial_routines6.make (yyvsc6)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs6")
			end
			yyvsc6 := yyvsc6 + yyInitial_yyvs_size
			yyvs6 := yyspecial_routines6.resize (yyvs6, yyvsc6)
		end
	end
	yyvs6.put (yyval6, yyvsp6)
end
when 61 then
--|#line 296 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 296")
end

			yyval6 := yyvs6.item (yyvsp6)
			yyval6.force_last (yyvs5.item (yyvsp5))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp5 := yyvsp5 -1
	yyvs6.put (yyval6, yyvsp6)
end
when 62 then
--|#line 303 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 303")
end

			yyval8 := yyvs8.item (yyvsp8)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyvs8.put (yyval8, yyvsp8)
end
when 63 then
--|#line 309 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 309")
end

			create yyval8.make (5)
			yyval8.force_last (yyvs7.item (yyvsp7))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp8 := yyvsp8 + 1
	yyvsp7 := yyvsp7 -1
	if yyvsp8 >= yyvsc8 then
		if yyvs8 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs8")
			end
			create yyspecial_routines8
			yyvsc8 := yyInitial_yyvs_size
			yyvs8 := yyspecial_routines8.make (yyvsc8)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs8")
			end
			yyvsc8 := yyvsc8 + yyInitial_yyvs_size
			yyvs8 := yyspecial_routines8.resize (yyvs8, yyvsc8)
		end
	end
	yyvs8.put (yyval8, yyvsp8)
end
when 64 then
--|#line 314 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 314")
end

			yyval8 := yyvs8.item (yyvsp8)
			yyval8.force_last (yyvs7.item (yyvsp7))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp7 := yyvsp7 -1
	yyvs8.put (yyval8, yyvsp8)
end
when 65 then
--|#line 321 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 321")
end

			yyval7 := new_labeled_type (yyvs9.item (yyvsp9), yyvs5.item (yyvsp5))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp7 := yyvsp7 + 1
	yyvsp9 := yyvsp9 -1
	yyvsp3 := yyvsp3 -1
	yyvsp5 := yyvsp5 -1
	if yyvsp7 >= yyvsc7 then
		if yyvs7 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs7")
			end
			create yyspecial_routines7
			yyvsc7 := yyInitial_yyvs_size
			yyvs7 := yyspecial_routines7.make (yyvsc7)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs7")
			end
			yyvsc7 := yyvsc7 + yyInitial_yyvs_size
			yyvs7 := yyspecial_routines7.resize (yyvs7, yyvsc7)
		end
	end
	yyvs7.put (yyval7, yyvsp7)
end
when 66 then
--|#line 327 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 327")
end

			create yyval9.make (5)
			yyval9.force_last (yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp9 := yyvsp9 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp9 >= yyvsc9 then
		if yyvs9 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs9")
			end
			create yyspecial_routines9
			yyvsc9 := yyInitial_yyvs_size
			yyvs9 := yyspecial_routines9.make (yyvsc9)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs9")
			end
			yyvsc9 := yyvsc9 + yyInitial_yyvs_size
			yyvs9 := yyspecial_routines9.resize (yyvs9, yyvsc9)
		end
	end
	yyvs9.put (yyval9, yyvsp9)
end
when 67 then
--|#line 332 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 332")
end

			yyval9 := yyvs9.item (yyvsp9)
			yyval9.force_last (yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp2 := yyvsp2 -1
	yyvs9.put (yyval9, yyvsp9)
end
when 68 then
--|#line 339 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 339")
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
	yyvs1.put (yyval1, yyvsp1)
end
when 69 then
--|#line 340 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 340")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 70 then
--|#line 341 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 341")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp4 := yyvsp4 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 71 then
--|#line 344 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 344")
end

			yyval4 := new_terminal (yyvs2.item (yyvsp2), type)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp4 := yyvsp4 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp4 >= yyvsc4 then
		if yyvs4 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs4")
			end
			create yyspecial_routines4
			yyvsc4 := yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.make (yyvsc4)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs4")
			end
			yyvsc4 := yyvsc4 + yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.resize (yyvs4, yyvsc4)
		end
	end
	yyvs4.put (yyval4, yyvsp4)
end
when 72 then
--|#line 348 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 348")
end

			yyval4 := new_terminal (yyvs2.item (yyvsp2), type)
			set_token_id (yyval4, yyvs3.item (yyvsp3))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp3 := yyvsp3 -1
	if yyvsp4 >= yyvsc4 then
		if yyvs4 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs4")
			end
			create yyspecial_routines4
			yyvsc4 := yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.make (yyvsc4)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs4")
			end
			yyvsc4 := yyvsc4 + yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.resize (yyvs4, yyvsc4)
		end
	end
	yyvs4.put (yyval4, yyvsp4)
end
when 73 then
--|#line 353 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 353")
end

			yyval4 := new_terminal (yyvs2.item (yyvsp2 - 1), type)
			set_literal_string (yyval4, yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 + 1
	yyvsp2 := yyvsp2 -2
	if yyvsp4 >= yyvsc4 then
		if yyvs4 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs4")
			end
			create yyspecial_routines4
			yyvsc4 := yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.make (yyvsc4)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs4")
			end
			yyvsc4 := yyvsc4 + yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.resize (yyvs4, yyvsc4)
		end
	end
	yyvs4.put (yyval4, yyvsp4)
end
when 74 then
--|#line 358 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 358")
end

			yyval4 := new_terminal (yyvs2.item (yyvsp2 - 1), type)
			set_token_id (yyval4, yyvs3.item (yyvsp3))
			set_literal_string (yyval4, yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp4 := yyvsp4 + 1
	yyvsp2 := yyvsp2 -2
	yyvsp3 := yyvsp3 -1
	if yyvsp4 >= yyvsc4 then
		if yyvs4 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs4")
			end
			create yyspecial_routines4
			yyvsc4 := yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.make (yyvsc4)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs4")
			end
			yyvsc4 := yyvsc4 + yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.resize (yyvs4, yyvsc4)
		end
	end
	yyvs4.put (yyval4, yyvsp4)
end
when 75 then
--|#line 364 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 364")
end

			yyval4 := new_char_terminal (yyvs2.item (yyvsp2), type)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp4 := yyvsp4 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp4 >= yyvsc4 then
		if yyvs4 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs4")
			end
			create yyspecial_routines4
			yyvsc4 := yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.make (yyvsc4)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs4")
			end
			yyvsc4 := yyvsc4 + yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.resize (yyvs4, yyvsc4)
		end
	end
	yyvs4.put (yyval4, yyvsp4)
end
when 76 then
--|#line 370 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 370")
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
	yyvs1.put (yyval1, yyvsp1)
end
when 77 then
--|#line 371 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 371")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 78 then
--|#line 372 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 372")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp4 := yyvsp4 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 79 then
--|#line 375 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 375")
end

			yyval4 := new_left_terminal (yyvs2.item (yyvsp2), precedence)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp4 := yyvsp4 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp4 >= yyvsc4 then
		if yyvs4 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs4")
			end
			create yyspecial_routines4
			yyvsc4 := yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.make (yyvsc4)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs4")
			end
			yyvsc4 := yyvsc4 + yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.resize (yyvs4, yyvsc4)
		end
	end
	yyvs4.put (yyval4, yyvsp4)
end
when 80 then
--|#line 379 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 379")
end

			yyval4 := new_left_terminal (yyvs2.item (yyvsp2), precedence)
			set_token_id (yyval4, yyvs3.item (yyvsp3))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp3 := yyvsp3 -1
	if yyvsp4 >= yyvsc4 then
		if yyvs4 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs4")
			end
			create yyspecial_routines4
			yyvsc4 := yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.make (yyvsc4)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs4")
			end
			yyvsc4 := yyvsc4 + yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.resize (yyvs4, yyvsc4)
		end
	end
	yyvs4.put (yyval4, yyvsp4)
end
when 81 then
--|#line 384 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 384")
end

			yyval4 := new_left_terminal (yyvs2.item (yyvsp2 - 1), precedence)
			set_literal_string (yyval4, yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 + 1
	yyvsp2 := yyvsp2 -2
	if yyvsp4 >= yyvsc4 then
		if yyvs4 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs4")
			end
			create yyspecial_routines4
			yyvsc4 := yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.make (yyvsc4)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs4")
			end
			yyvsc4 := yyvsc4 + yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.resize (yyvs4, yyvsc4)
		end
	end
	yyvs4.put (yyval4, yyvsp4)
end
when 82 then
--|#line 389 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 389")
end

			yyval4 := new_left_terminal (yyvs2.item (yyvsp2 - 1), precedence)
			set_token_id (yyval4, yyvs3.item (yyvsp3))
			set_literal_string (yyval4, yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp4 := yyvsp4 + 1
	yyvsp2 := yyvsp2 -2
	yyvsp3 := yyvsp3 -1
	if yyvsp4 >= yyvsc4 then
		if yyvs4 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs4")
			end
			create yyspecial_routines4
			yyvsc4 := yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.make (yyvsc4)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs4")
			end
			yyvsc4 := yyvsc4 + yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.resize (yyvs4, yyvsc4)
		end
	end
	yyvs4.put (yyval4, yyvsp4)
end
when 83 then
--|#line 395 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 395")
end

			yyval4 := new_left_char_terminal (yyvs2.item (yyvsp2), precedence)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp4 := yyvsp4 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp4 >= yyvsc4 then
		if yyvs4 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs4")
			end
			create yyspecial_routines4
			yyvsc4 := yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.make (yyvsc4)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs4")
			end
			yyvsc4 := yyvsc4 + yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.resize (yyvs4, yyvsc4)
		end
	end
	yyvs4.put (yyval4, yyvsp4)
end
when 84 then
--|#line 401 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 401")
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
	yyvs1.put (yyval1, yyvsp1)
end
when 85 then
--|#line 402 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 402")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 86 then
--|#line 403 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 403")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp4 := yyvsp4 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 87 then
--|#line 406 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 406")
end

			yyval4 := new_right_terminal (yyvs2.item (yyvsp2), precedence)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp4 := yyvsp4 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp4 >= yyvsc4 then
		if yyvs4 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs4")
			end
			create yyspecial_routines4
			yyvsc4 := yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.make (yyvsc4)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs4")
			end
			yyvsc4 := yyvsc4 + yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.resize (yyvs4, yyvsc4)
		end
	end
	yyvs4.put (yyval4, yyvsp4)
end
when 88 then
--|#line 410 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 410")
end

			yyval4 := new_right_terminal (yyvs2.item (yyvsp2), precedence)
			set_token_id (yyval4, yyvs3.item (yyvsp3))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp3 := yyvsp3 -1
	if yyvsp4 >= yyvsc4 then
		if yyvs4 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs4")
			end
			create yyspecial_routines4
			yyvsc4 := yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.make (yyvsc4)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs4")
			end
			yyvsc4 := yyvsc4 + yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.resize (yyvs4, yyvsc4)
		end
	end
	yyvs4.put (yyval4, yyvsp4)
end
when 89 then
--|#line 415 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 415")
end

			yyval4 := new_right_terminal (yyvs2.item (yyvsp2 - 1), precedence)
			set_literal_string (yyval4, yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 + 1
	yyvsp2 := yyvsp2 -2
	if yyvsp4 >= yyvsc4 then
		if yyvs4 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs4")
			end
			create yyspecial_routines4
			yyvsc4 := yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.make (yyvsc4)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs4")
			end
			yyvsc4 := yyvsc4 + yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.resize (yyvs4, yyvsc4)
		end
	end
	yyvs4.put (yyval4, yyvsp4)
end
when 90 then
--|#line 420 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 420")
end

			yyval4 := new_right_terminal (yyvs2.item (yyvsp2 - 1), precedence)
			set_token_id (yyval4, yyvs3.item (yyvsp3))
			set_literal_string (yyval4, yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp4 := yyvsp4 + 1
	yyvsp2 := yyvsp2 -2
	yyvsp3 := yyvsp3 -1
	if yyvsp4 >= yyvsc4 then
		if yyvs4 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs4")
			end
			create yyspecial_routines4
			yyvsc4 := yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.make (yyvsc4)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs4")
			end
			yyvsc4 := yyvsc4 + yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.resize (yyvs4, yyvsc4)
		end
	end
	yyvs4.put (yyval4, yyvsp4)
end
when 91 then
--|#line 426 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 426")
end

			yyval4 := new_right_char_terminal (yyvs2.item (yyvsp2), precedence)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp4 := yyvsp4 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp4 >= yyvsc4 then
		if yyvs4 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs4")
			end
			create yyspecial_routines4
			yyvsc4 := yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.make (yyvsc4)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs4")
			end
			yyvsc4 := yyvsc4 + yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.resize (yyvs4, yyvsc4)
		end
	end
	yyvs4.put (yyval4, yyvsp4)
end
when 92 then
--|#line 432 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 432")
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
	yyvs1.put (yyval1, yyvsp1)
end
when 93 then
--|#line 433 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 433")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 94 then
--|#line 434 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 434")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp4 := yyvsp4 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 95 then
--|#line 437 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 437")
end

			yyval4 := new_nonassoc_terminal (yyvs2.item (yyvsp2), precedence)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp4 := yyvsp4 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp4 >= yyvsc4 then
		if yyvs4 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs4")
			end
			create yyspecial_routines4
			yyvsc4 := yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.make (yyvsc4)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs4")
			end
			yyvsc4 := yyvsc4 + yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.resize (yyvs4, yyvsc4)
		end
	end
	yyvs4.put (yyval4, yyvsp4)
end
when 96 then
--|#line 441 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 441")
end

			yyval4 := new_nonassoc_terminal (yyvs2.item (yyvsp2), precedence)
			set_token_id (yyval4, yyvs3.item (yyvsp3))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp3 := yyvsp3 -1
	if yyvsp4 >= yyvsc4 then
		if yyvs4 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs4")
			end
			create yyspecial_routines4
			yyvsc4 := yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.make (yyvsc4)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs4")
			end
			yyvsc4 := yyvsc4 + yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.resize (yyvs4, yyvsc4)
		end
	end
	yyvs4.put (yyval4, yyvsp4)
end
when 97 then
--|#line 446 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 446")
end

			yyval4 := new_nonassoc_terminal (yyvs2.item (yyvsp2 - 1), precedence)
			set_literal_string (yyval4, yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 + 1
	yyvsp2 := yyvsp2 -2
	if yyvsp4 >= yyvsc4 then
		if yyvs4 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs4")
			end
			create yyspecial_routines4
			yyvsc4 := yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.make (yyvsc4)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs4")
			end
			yyvsc4 := yyvsc4 + yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.resize (yyvs4, yyvsc4)
		end
	end
	yyvs4.put (yyval4, yyvsp4)
end
when 98 then
--|#line 451 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 451")
end

			yyval4 := new_nonassoc_terminal (yyvs2.item (yyvsp2 - 1), precedence)
			set_token_id (yyval4, yyvs3.item (yyvsp3))
			set_literal_string (yyval4, yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp4 := yyvsp4 + 1
	yyvsp2 := yyvsp2 -2
	yyvsp3 := yyvsp3 -1
	if yyvsp4 >= yyvsc4 then
		if yyvs4 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs4")
			end
			create yyspecial_routines4
			yyvsc4 := yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.make (yyvsc4)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs4")
			end
			yyvsc4 := yyvsc4 + yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.resize (yyvs4, yyvsc4)
		end
	end
	yyvs4.put (yyval4, yyvsp4)
end
when 99 then
--|#line 457 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 457")
end

			yyval4 := new_nonassoc_char_terminal (yyvs2.item (yyvsp2), precedence)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp4 := yyvsp4 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp4 >= yyvsc4 then
		if yyvs4 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs4")
			end
			create yyspecial_routines4
			yyvsc4 := yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.make (yyvsc4)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs4")
			end
			yyvsc4 := yyvsc4 + yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.resize (yyvs4, yyvsc4)
		end
	end
	yyvs4.put (yyval4, yyvsp4)
end
when 100 then
--|#line 463 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 463")
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
	yyvs1.put (yyval1, yyvsp1)
end
when 101 then
--|#line 464 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 464")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 102 then
--|#line 465 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 465")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyvs1.put (yyval1, yyvsp1)
end
when 103 then
--|#line 468 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 468")
end

			yyval1 := new_nonterminal (yyvs2.item (yyvsp2), type)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp1 := yyvsp1 + 1
	yyvsp2 := yyvsp2 -1
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
when 104 then
--|#line 474 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 474")
end

			report_no_rules_error
		
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
	yyvs1.put (yyval1, yyvsp1)
end
when 105 then
--|#line 478 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 478")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs1.put (yyval1, yyvsp1)
end
when 106 then
--|#line 479 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 479")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 107 then
--|#line 482 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 482")
end

			process_rule (rule)
			rule := Void
			precedence_token := Void
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp1 := yyvsp1 -3
	yyvs1.put (yyval1, yyvsp1)
end
when 108 then
--|#line 490 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 490")
end

			if is_terminal (yyvs2.item (yyvsp2)) then
				report_lhs_symbol_token_error (yyvs2.item (yyvsp2))
				rule := new_rule (new_dummy_variable)
			else
				rule := new_rule (new_variable (yyvs2.item (yyvsp2)))
				if rule.lhs.rules.count > 1 then
					report_rule_declared_twice_warning (yyvs2.item (yyvsp2))
				end
			end
			precedence_token := Void
			put_rule (rule)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp1 := yyvsp1 + 1
	yyvsp2 := yyvsp2 -1
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
when 109 then
--|#line 506 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 506")
end

			rule.set_line_nb (yyvs3.item (yyvsp3))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp1 := yyvsp1 + 1
	yyvsp3 := yyvsp3 -1
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
when 110 then
--|#line 512 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 512")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs1.put (yyval1, yyvsp1)
end
when 111 then
--|#line 513 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 513")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyvs1.put (yyval1, yyvsp1)
end
when 112 then
--|#line 516 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 516")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs1.put (yyval1, yyvsp1)
end
when 113 then
--|#line 517 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 517")
end

			if yyvs3.item (yyvsp3) < 1 or yyvs3.item (yyvsp3) > rule.error_actions.count then
				report_invalid_error_n_error (yyvs3.item (yyvsp3))
			else
				put_error_action (new_error_action (yyvs2.item (yyvsp2), yyvs3.item (yyvsp3 - 1)), yyvs3.item (yyvsp3), rule)
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp1 := yyvsp1 -2
	yyvsp3 := yyvsp3 -2
	yyvsp2 := yyvsp2 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 114 then
--|#line 527 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 527")
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
	yyvs1.put (yyval1, yyvsp1)
end
when 115 then
--|#line 528 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 528")
end

			put_symbol (new_symbol (yyvs2.item (yyvsp2)), rule)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp2 := yyvsp2 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 116 then
--|#line 532 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 532")
end

			put_symbol (new_char_token (yyvs2.item (yyvsp2)), rule)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp2 := yyvsp2 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 117 then
--|#line 536 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 536")
end

			put_symbol (new_string_token (yyvs2.item (yyvsp2)), rule)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp2 := yyvsp2 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 118 then
--|#line 540 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 540")
end

			put_action (new_action (yyvs2.item (yyvsp2)), rule)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp2 := yyvsp2 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 119 then
--|#line 544 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 544")
end

			if precedence_token /= Void then
				report_prec_specified_twice_error
			else
				precedence_token := yyvs4.item (yyvsp4)
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp4 := yyvsp4 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 120 then
--|#line 554 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 554")
end

			if is_terminal (yyvs2.item (yyvsp2)) then
				yyval4 := new_token (yyvs2.item (yyvsp2))
			else
				report_prec_not_token_error (yyvs2.item (yyvsp2))
				yyval4 := new_char_token ("'a'")
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp4 := yyvsp4 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp4 >= yyvsc4 then
		if yyvs4 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs4")
			end
			create yyspecial_routines4
			yyvsc4 := yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.make (yyvsc4)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs4")
			end
			yyvsc4 := yyvsc4 + yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.resize (yyvs4, yyvsc4)
		end
	end
	yyvs4.put (yyval4, yyvsp4)
end
when 121 then
--|#line 563 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 563")
end

			yyval4 := new_char_token (yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp4 := yyvsp4 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp4 >= yyvsc4 then
		if yyvs4 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs4")
			end
			create yyspecial_routines4
			yyvsc4 := yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.make (yyvsc4)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs4")
			end
			yyvsc4 := yyvsc4 + yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.resize (yyvs4, yyvsc4)
		end
	end
	yyvs4.put (yyval4, yyvsp4)
end
when 122 then
--|#line 569 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 569")
end

			process_rule (rule)
			rule := new_rule (rule.lhs)
			precedence_token := Void
			rule.set_line_nb (yyvs3.item (yyvsp3))
			put_rule (rule)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp1 := yyvsp1 + 1
	yyvsp3 := yyvsp3 -1
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
when 123 then
--|#line 579 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 579")
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
	yyvs1.put (yyval1, yyvsp1)
end
when 124 then
--|#line 580 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 580")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs1.put (yyval1, yyvsp1)
end
when 125 then
--|#line 581 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 581")
end

			last_grammar.set_eiffel_code (yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp2 := yyvsp2 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 126 then
--|#line 587 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 587")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 127 then
--|#line 589 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 589")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 128 then
--|#line 591 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 591")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 129 then
--|#line 593 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 593")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 130 then
--|#line 595 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 595")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 131 then
--|#line 597 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 597")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 132 then
--|#line 599 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 599")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 133 then
--|#line 601 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 601")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 134 then
--|#line 603 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 603")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 135 then
--|#line 605 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 605")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 136 then
--|#line 607 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 607")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 137 then
--|#line 609 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 609")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 138 then
--|#line 611 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 611")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 139 then
--|#line 613 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 613")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 140 then
--|#line 615 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 615")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 141 then
--|#line 617 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 617")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 142 then
--|#line 619 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 619")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 143 then
--|#line 621 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 621")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 144 then
--|#line 623 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 623")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 145 then
--|#line 625 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 625")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 146 then
--|#line 627 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 627")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 147 then
--|#line 629 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 629")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 148 then
--|#line 631 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 631")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 149 then
--|#line 633 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 633")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 150 then
--|#line 635 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 635")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 151 then
--|#line 637 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 637")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 152 then
--|#line 639 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 639")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 153 then
--|#line 641 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 641")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 154 then
--|#line 643 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 643")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
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
			when 182 then
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
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,   55,    2,    2,    2,    2,    2,    2,
			   59,   60,    2,    2,   57,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,   50,   58,
			   51,    2,   52,   56,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,   53,    2,   54,    2,    2,    2,    2,    2,    2,

			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,   49,    2,    2,    2,    2,    2,
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
			    5,    6,    7,    8,    9,   10,   11,   12,   13,   14,
			   15,   16,   17,   18,   19,   20,   21,   22,   23,   24,
			   25,   26,   27,   28,   29,   30,   31,   32,   33,   34,
			   35,   36,   37,   38,   39,   40,   41,   42,   43,   44,

			   45,   46,   47,   48, yyDummy>>)
		end

	yyr1_template: SPECIAL [INTEGER] is
			-- Template for `yyr1'
		once
			Result := yyfixed_array (<<
			    0,   76,   78,   77,   77,   81,   81,   81,   81,   81,
			   81,   81,   81,   82,   82,   82,   84,   84,   69,   69,
			   69,   69,   69,   69,   69,   69,   69,   69,   69,   69,
			   69,   69,   69,   69,   69,   69,   69,   69,   69,   69,
			   69,   69,   69,   69,   69,   69,   62,   62,   62,   62,
			   62,   62,   62,   62,   63,   63,   63,   63,   63,   71,
			   70,   70,   73,   72,   72,   74,   75,   75,   83,   83,
			   83,   65,   65,   65,   65,   65,   86,   86,   86,   66,
			   66,   66,   66,   66,   87,   87,   87,   67,   67,   67,
			   67,   67,   88,   88,   88,   68,   68,   68,   68,   68,

			   85,   85,   85,   89,   79,   79,   79,   90,   91,   92,
			   93,   93,   94,   94,   96,   96,   96,   96,   96,   96,
			   64,   64,   95,   80,   80,   80,   61,   61,   61,   61,
			   61,   61,   61,   61,   61,   61,   61,   61,   61,   61,
			   61,   61,   61,   61,   61,   61,   61,   61,   61,   61,
			   61,   61,   61,   61,   61, yyDummy>>)
		end

	yytypes1_template: SPECIAL [INTEGER] is
			-- Template for `yytypes1'
		once
			Result := yyfixed_array (<<
			    1,    1,    1,    2,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    1,    1,    1,    1,    1,    2,    3,
			    1,    1,    1,    1,    1,    1,    1,    1,    3,    1,
			    1,    1,    2,    2,    2,    2,    2,    2,    2,    5,
			    1,    1,    2,    2,    4,    1,    2,    2,    4,    1,
			    2,    2,    4,    5,    1,    2,    1,    1,    1,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,

			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    1,    1,    2,    1,    4,    3,    2,    4,    3,
			    2,    4,    3,    2,    1,    2,    1,    2,    2,    4,
			    1,    3,    1,    3,    2,    2,    2,    1,    2,    1,
			    6,    2,    2,    1,    6,    8,    1,    2,    2,    2,
			    2,    4,    3,    2,    1,    1,    2,    2,    4,    1,
			    5,    6,    1,    2,    8,    7,    9,    1,    2,    3,
			    1,    1,    1,    1,    1,    3,    1,    5,    7,    2,
			    5,    2,    1,    1,    1, yyDummy>>)
		end

	yytypes2_template: SPECIAL [INTEGER] is
			-- Template for `yytypes2'
		once
			Result := yyfixed_array (<<
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    3,    3,    3,
			    3,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1, yyDummy>>)
		end

	yydefact_template: SPECIAL [INTEGER] is
			-- Template for `yydefact'
		once
			Result := yyfixed_array (<<
			    2,    3,    0,    5,  104,   16,    0,    0,   92,   84,
			   76,   13,    4,  153,  152,  151,  150,  149,  148,  147,
			  140,  139,  138,  144,  143,  142,  141,  136,  135,  134,
			  133,  132,  131,  130,  129,  128,  127,  154,  146,  145,
			  137,  126,  108,  123,  105,    0,   54,  100,   11,   12,
			   10,    9,    8,   54,   68,  124,    1,  106,  109,  114,
			   58,   57,   56,   55,   49,   48,   47,    0,    0,    0,
			    7,    0,   99,   95,   93,    0,   91,   87,   85,    0,
			   83,   79,   77,    0,    6,  125,    0,  110,  112,   32,
			   31,   30,   36,   35,   34,   33,   28,   27,   26,   25,

			   24,   23,   22,   21,   20,   19,   37,   29,   18,    0,
			   40,   17,    0,  103,  101,   94,   96,   97,   86,   88,
			   89,   78,   80,   81,   14,    0,    0,   75,   71,   69,
			  107,  122,  114,    0,  117,  116,  118,    0,  115,   54,
			   39,   45,   44,   54,   42,   43,  102,   98,   90,   82,
			    0,   70,   72,   73,  111,    0,  121,  120,  119,   38,
			   60,    0,   41,   66,    0,   63,    0,   15,   74,    0,
			   54,   59,    0,   62,    0,   54,    0,   61,   64,   67,
			   65,  113,    0,    0,    0, yyDummy>>)
		end

	yydefgoto_template: SPECIAL [INTEGER] is
			-- Template for `yydefgoto'
		once
			Result := yyfixed_array (<<
			   42,   67,   68,  158,  129,   82,   78,   74,  160,  161,
			  140,  164,  145,  165,  166,  182,    2,    1,   43,   56,
			   12,   54,   84,   47,   70,   52,   51,   50,  114,   44,
			   45,   59,   86,   87,  132,   88, yyDummy>>)
		end

	yypact_template: SPECIAL [INTEGER] is
			-- Template for `yypact'
		once
			Result := yyfixed_array (<<
			 -32768, -32768,   49, -32768,  582,   75,  582,   77, -32768, -32768,
			 -32768,   72, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768,  384, -32768,   68,   66, -32768, -32768, -32768,
			  193,  154,  115,   66, -32768,  101, -32768, -32768, -32768, -32768,
			  719,  693,  667,  641, -32768, -32768, -32768,  615,   17,   64,
			  232,  549, -32768,   25, -32768,  516, -32768,   24, -32768,  483,
			 -32768,   23, -32768,   15,  -10, -32768,   -9,   31,  348, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,

			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,   62,   34,
			   61, -32768,  582, -32768, -32768, -32768,   95, -32768, -32768,   89,
			 -32768, -32768,   70, -32768, -32768,  582,  450, -32768,   21, -32768,
			 -32768, -32768, -32768,   28, -32768, -32768, -32768,  417, -32768,  305,
			 -32768, -32768, -32768,  267, -32768, -32768, -32768, -32768, -32768, -32768,
			   32, -32768,   63, -32768,   31,   30, -32768, -32768, -32768, -32768,
			 -32768,    9, -32768, -32768,  -52, -32768,   26, -32768, -32768,   14,
			   66, -32768,   47, -32768,   37,   66,   35, -32768, -32768, -32768,
			 -32768, -32768,    5,    3, -32768, yyDummy>>)
		end

	yypgoto_template: SPECIAL [INTEGER] is
			-- Template for `yypgoto'
		once
			Result := yyfixed_array (<<
			   -6, -32768, -32768, -32768,   41,   87,   90,   93,  -45, -32768,
			   53, -32768, -32768,  -39, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,   50,   85,
			 -32768, -32768, -32768,   -5, -32768, -32768, yyDummy>>)
		end

	yytable_template: SPECIAL [INTEGER] is
			-- Template for `yytable'
		once
			Result := yyfixed_array (<<
			   48,   69,  173,  184,   41,  183,  172,  127,   83,   40,
			   39,   38,   37,   36,   35,   34,   33,   32,   31,   30,
			   29,   28,   27,   26,   25,   24,   23,   22,   21,   20,
			   19,   18,   17,   16,   15,   14,   13,  125,  110,  153,
			  131,  123,  120,  117,   73,   77,   81,  126,  142,  130,
			  181,  179,   11,   10,    9,    8,    7,  109,    6,    5,
			    4,  163,    3,  171,  113,   73,  170,  124,  152,   77,
			  122,  119,  116,   81,  176,  141,  175,  169,  128,  133,
			  -46,  168,  138,  174,  167,  -46,  -46,  155,  149,  -46,
			  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,

			  -46,  -46,  -46,  -46,  -46,  -46,  113,  148,   66,   65,
			   64,   63,   62,  147,  143,  139,  111,   85,   58,  150,
			  128,   61,   60,   53,   49,  177,   46,  154,   57,   41,
			  180,  157,   80,  178,   40,   39,   38,   37,   36,   35,
			   34,   33,   32,   31,   30,   29,   28,   27,   26,   25,
			   24,   23,   22,   21,   20,   19,   18,   17,   16,   15,
			   14,   13,  146,  144,  115,  118,  121,  151,   41,    0,
			    0,   76,   79,   40,   39,   38,   37,   36,   35,   34,
			   33,   32,   31,   30,   29,   28,   27,   26,   25,   24,
			   23,   22,   21,   20,   19,   18,   17,   16,   15,   14,

			   13,    0,    0,    0,    0,    0,    0,   41,    0,    0,
			   72,   75,   40,   39,   38,   37,   36,   35,   34,   33,
			   32,   31,   30,   29,   28,   27,   26,   25,   24,   23,
			   22,   21,   20,   19,   18,   17,   16,   15,   14,   13,
			    0,    0,    0,    0,    0,    0,   41,    0,    0,    0,
			   71,   40,   39,   38,   37,   36,   35,   34,   33,   32,
			   31,   30,   29,   28,   27,   26,   25,   24,   23,   22,
			   21,   20,   19,   18,   17,   16,   15,   14,   13,    0,
			    0,  163,    0,    0,    0,    0,  -46,  -46,    0,  112,
			  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,

			  -46,  -46,  -46,  -46,  -46,  -46,  -46,    0,    0,   66,
			   65,   64,   63,   62,    0,    0,    0,    0,    0,  -46,
			    0,  162,   61,   60,  -46,  -46,    0,    0,  -46,  -46,
			  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,  -46,
			  -46,  -46,  -46,  -46,  -46,    0,    0,   66,   65,   64,
			   63,   62,    0,    0,    0,    0,  137,    0,    0,  159,
			   61,   60,   41,  136,    0,  135,  134,   40,   39,   38,
			   37,   36,   35,   34,   33,   32,   31,   30,   29,   28,
			   27,   26,   25,   24,   23,   22,   21,   20,   19,   18,
			   17,   16,   15,   14,   13,   55,    0,    0,   41,    0,

			    0,    0,    0,   40,   39,   38,   37,   36,   35,   34,
			   33,   32,   31,   30,   29,   28,   27,   26,   25,   24,
			   23,   22,   21,   20,   19,   18,   17,   16,   15,   14,
			   13,   41,    0,    0,  156,    0,   40,   39,   38,   37,
			   36,   35,   34,   33,   32,   31,   30,   29,   28,   27,
			   26,   25,   24,   23,   22,   21,   20,   19,   18,   17,
			   16,   15,   14,   13,   41,    0,    0,  127,    0,   40,
			   39,   38,   37,   36,   35,   34,   33,   32,   31,   30,
			   29,   28,   27,   26,   25,   24,   23,   22,   21,   20,
			   19,   18,   17,   16,   15,   14,   13,   41,    0,    0,

			   80,    0,   40,   39,   38,   37,   36,   35,   34,   33,
			   32,   31,   30,   29,   28,   27,   26,   25,   24,   23,
			   22,   21,   20,   19,   18,   17,   16,   15,   14,   13,
			   41,    0,    0,   76,    0,   40,   39,   38,   37,   36,
			   35,   34,   33,   32,   31,   30,   29,   28,   27,   26,
			   25,   24,   23,   22,   21,   20,   19,   18,   17,   16,
			   15,   14,   13,   41,    0,    0,   72,    0,   40,   39,
			   38,   37,   36,   35,   34,   33,   32,   31,   30,   29,
			   28,   27,   26,   25,   24,   23,   22,   21,   20,   19,
			   18,   17,   16,   15,   14,   13,   41,    0,    0,    0,

			    0,   40,   39,   38,   37,   36,   35,   34,   33,   32,
			   31,   30,   29,   28,   27,   26,   25,   24,   23,   22,
			   21,   20,   19,   18,   17,   16,   15,   14,   13,  108,
			    0,    0,    0,    0,  107,  106,    0,    0,  105,  104,
			  103,  102,  101,  100,   99,   98,   97,   96,   95,   94,
			   93,   92,   91,   90,   89,  -50,    0,    0,    0,    0,
			  -50,  -50,    0,    0,  -50,  -50,  -50,  -50,  -50,  -50,
			  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,  -50,
			  -50,  -51,    0,    0,    0,    0,  -51,  -51,    0,    0,
			  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -51,

			  -51,  -51,  -51,  -51,  -51,  -51,  -51,  -52,    0,    0,
			    0,    0,  -52,  -52,    0,    0,  -52,  -52,  -52,  -52,
			  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,  -52,
			  -52,  -52,  -52,  -53,    0,    0,    0,    0,  -53,  -53,
			    0,    0,  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,
			  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53,  -53, yyDummy>>)
		end

	yycheck_template: SPECIAL [INTEGER] is
			-- Template for `yycheck'
		once
			Result := yyfixed_array (<<
			    6,   46,   54,    0,   14,    0,   58,   17,   53,   19,
			   20,   21,   22,   23,   24,   25,   26,   27,   28,   29,
			   30,   31,   32,   33,   34,   35,   36,   37,   38,   39,
			   40,   41,   42,   43,   44,   45,   46,   22,   21,   18,
			   49,   18,   18,   18,   50,   51,   52,   57,   14,   58,
			   15,   14,    3,    4,    5,    6,    7,   40,    9,   10,
			   11,   14,   13,   54,   70,   71,   57,   52,   47,   75,
			   47,   47,   47,   79,   60,   41,   50,   47,   84,   48,
			   14,   18,   88,   57,   52,   19,   20,   59,   18,   23,
			   24,   25,   26,   27,   28,   29,   30,   31,   32,   33,

			   34,   35,   36,   37,   38,   39,  112,   18,   42,   43,
			   44,   45,   46,   18,   53,   53,   52,   16,   50,  125,
			  126,   55,   56,   51,   47,  170,   51,  132,   43,   14,
			  175,  137,   17,  172,   19,   20,   21,   22,   23,   24,
			   25,   26,   27,   28,   29,   30,   31,   32,   33,   34,
			   35,   36,   37,   38,   39,   40,   41,   42,   43,   44,
			   45,   46,  112,  110,   71,   75,   79,  126,   14,   -1,
			   -1,   17,   57,   19,   20,   21,   22,   23,   24,   25,
			   26,   27,   28,   29,   30,   31,   32,   33,   34,   35,
			   36,   37,   38,   39,   40,   41,   42,   43,   44,   45,

			   46,   -1,   -1,   -1,   -1,   -1,   -1,   14,   -1,   -1,
			   17,   57,   19,   20,   21,   22,   23,   24,   25,   26,
			   27,   28,   29,   30,   31,   32,   33,   34,   35,   36,
			   37,   38,   39,   40,   41,   42,   43,   44,   45,   46,
			   -1,   -1,   -1,   -1,   -1,   -1,   14,   -1,   -1,   -1,
			   57,   19,   20,   21,   22,   23,   24,   25,   26,   27,
			   28,   29,   30,   31,   32,   33,   34,   35,   36,   37,
			   38,   39,   40,   41,   42,   43,   44,   45,   46,   -1,
			   -1,   14,   -1,   -1,   -1,   -1,   19,   20,   -1,   57,
			   23,   24,   25,   26,   27,   28,   29,   30,   31,   32,

			   33,   34,   35,   36,   37,   38,   39,   -1,   -1,   42,
			   43,   44,   45,   46,   -1,   -1,   -1,   -1,   -1,   14,
			   -1,   54,   55,   56,   19,   20,   -1,   -1,   23,   24,
			   25,   26,   27,   28,   29,   30,   31,   32,   33,   34,
			   35,   36,   37,   38,   39,   -1,   -1,   42,   43,   44,
			   45,   46,   -1,   -1,   -1,   -1,    8,   -1,   -1,   54,
			   55,   56,   14,   15,   -1,   17,   18,   19,   20,   21,
			   22,   23,   24,   25,   26,   27,   28,   29,   30,   31,
			   32,   33,   34,   35,   36,   37,   38,   39,   40,   41,
			   42,   43,   44,   45,   46,   11,   -1,   -1,   14,   -1,

			   -1,   -1,   -1,   19,   20,   21,   22,   23,   24,   25,
			   26,   27,   28,   29,   30,   31,   32,   33,   34,   35,
			   36,   37,   38,   39,   40,   41,   42,   43,   44,   45,
			   46,   14,   -1,   -1,   17,   -1,   19,   20,   21,   22,
			   23,   24,   25,   26,   27,   28,   29,   30,   31,   32,
			   33,   34,   35,   36,   37,   38,   39,   40,   41,   42,
			   43,   44,   45,   46,   14,   -1,   -1,   17,   -1,   19,
			   20,   21,   22,   23,   24,   25,   26,   27,   28,   29,
			   30,   31,   32,   33,   34,   35,   36,   37,   38,   39,
			   40,   41,   42,   43,   44,   45,   46,   14,   -1,   -1,

			   17,   -1,   19,   20,   21,   22,   23,   24,   25,   26,
			   27,   28,   29,   30,   31,   32,   33,   34,   35,   36,
			   37,   38,   39,   40,   41,   42,   43,   44,   45,   46,
			   14,   -1,   -1,   17,   -1,   19,   20,   21,   22,   23,
			   24,   25,   26,   27,   28,   29,   30,   31,   32,   33,
			   34,   35,   36,   37,   38,   39,   40,   41,   42,   43,
			   44,   45,   46,   14,   -1,   -1,   17,   -1,   19,   20,
			   21,   22,   23,   24,   25,   26,   27,   28,   29,   30,
			   31,   32,   33,   34,   35,   36,   37,   38,   39,   40,
			   41,   42,   43,   44,   45,   46,   14,   -1,   -1,   -1,

			   -1,   19,   20,   21,   22,   23,   24,   25,   26,   27,
			   28,   29,   30,   31,   32,   33,   34,   35,   36,   37,
			   38,   39,   40,   41,   42,   43,   44,   45,   46,   14,
			   -1,   -1,   -1,   -1,   19,   20,   -1,   -1,   23,   24,
			   25,   26,   27,   28,   29,   30,   31,   32,   33,   34,
			   35,   36,   37,   38,   39,   14,   -1,   -1,   -1,   -1,
			   19,   20,   -1,   -1,   23,   24,   25,   26,   27,   28,
			   29,   30,   31,   32,   33,   34,   35,   36,   37,   38,
			   39,   14,   -1,   -1,   -1,   -1,   19,   20,   -1,   -1,
			   23,   24,   25,   26,   27,   28,   29,   30,   31,   32,

			   33,   34,   35,   36,   37,   38,   39,   14,   -1,   -1,
			   -1,   -1,   19,   20,   -1,   -1,   23,   24,   25,   26,
			   27,   28,   29,   30,   31,   32,   33,   34,   35,   36,
			   37,   38,   39,   14,   -1,   -1,   -1,   -1,   19,   20,
			   -1,   -1,   23,   24,   25,   26,   27,   28,   29,   30,
			   31,   32,   33,   34,   35,   36,   37,   38,   39, yyDummy>>)
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

	yyvs2: SPECIAL [STRING]
			-- Stack for semantic values of type STRING

	yyvsc2: INTEGER
			-- Capacity of semantic value stack `yyvs2'

	yyvsp2: INTEGER
			-- Top of semantic value stack `yyvs2'

	yyspecial_routines2: KL_SPECIAL_ROUTINES [STRING]
			-- Routines that ought to be in SPECIAL [STRING]

	yyvs3: SPECIAL [INTEGER]
			-- Stack for semantic values of type INTEGER

	yyvsc3: INTEGER
			-- Capacity of semantic value stack `yyvs3'

	yyvsp3: INTEGER
			-- Top of semantic value stack `yyvs3'

	yyspecial_routines3: KL_SPECIAL_ROUTINES [INTEGER]
			-- Routines that ought to be in SPECIAL [INTEGER]

	yyvs4: SPECIAL [PR_TOKEN]
			-- Stack for semantic values of type PR_TOKEN

	yyvsc4: INTEGER
			-- Capacity of semantic value stack `yyvs4'

	yyvsp4: INTEGER
			-- Top of semantic value stack `yyvs4'

	yyspecial_routines4: KL_SPECIAL_ROUTINES [PR_TOKEN]
			-- Routines that ought to be in SPECIAL [PR_TOKEN]

	yyvs5: SPECIAL [PR_TYPE]
			-- Stack for semantic values of type PR_TYPE

	yyvsc5: INTEGER
			-- Capacity of semantic value stack `yyvs5'

	yyvsp5: INTEGER
			-- Top of semantic value stack `yyvs5'

	yyspecial_routines5: KL_SPECIAL_ROUTINES [PR_TYPE]
			-- Routines that ought to be in SPECIAL [PR_TYPE]

	yyvs6: SPECIAL [DS_ARRAYED_LIST [PR_TYPE]]
			-- Stack for semantic values of type DS_ARRAYED_LIST [PR_TYPE]

	yyvsc6: INTEGER
			-- Capacity of semantic value stack `yyvs6'

	yyvsp6: INTEGER
			-- Top of semantic value stack `yyvs6'

	yyspecial_routines6: KL_SPECIAL_ROUTINES [DS_ARRAYED_LIST [PR_TYPE]]
			-- Routines that ought to be in SPECIAL [DS_ARRAYED_LIST [PR_TYPE]]

	yyvs7: SPECIAL [PR_LABELED_TYPE]
			-- Stack for semantic values of type PR_LABELED_TYPE

	yyvsc7: INTEGER
			-- Capacity of semantic value stack `yyvs7'

	yyvsp7: INTEGER
			-- Top of semantic value stack `yyvs7'

	yyspecial_routines7: KL_SPECIAL_ROUTINES [PR_LABELED_TYPE]
			-- Routines that ought to be in SPECIAL [PR_LABELED_TYPE]

	yyvs8: SPECIAL [DS_ARRAYED_LIST [PR_LABELED_TYPE]]
			-- Stack for semantic values of type DS_ARRAYED_LIST [PR_LABELED_TYPE]

	yyvsc8: INTEGER
			-- Capacity of semantic value stack `yyvs8'

	yyvsp8: INTEGER
			-- Top of semantic value stack `yyvs8'

	yyspecial_routines8: KL_SPECIAL_ROUTINES [DS_ARRAYED_LIST [PR_LABELED_TYPE]]
			-- Routines that ought to be in SPECIAL [DS_ARRAYED_LIST [PR_LABELED_TYPE]]

	yyvs9: SPECIAL [DS_ARRAYED_LIST [STRING]]
			-- Stack for semantic values of type DS_ARRAYED_LIST [STRING]

	yyvsc9: INTEGER
			-- Capacity of semantic value stack `yyvs9'

	yyvsp9: INTEGER
			-- Top of semantic value stack `yyvs9'

	yyspecial_routines9: KL_SPECIAL_ROUTINES [DS_ARRAYED_LIST [STRING]]
			-- Routines that ought to be in SPECIAL [DS_ARRAYED_LIST [STRING]]

feature {NONE} -- Constants

	yyFinal: INTEGER is 184
			-- Termination state id

	yyFlag: INTEGER is -32768
			-- Most negative INTEGER

	yyNtbase: INTEGER is 61
			-- Number of tokens

	yyLast: INTEGER is 758
			-- Upper bound of `yytable' and `yycheck'

	yyMax_token: INTEGER is 303
			-- Maximum token id
			-- (upper bound of `yytranslate'.)

	yyNsyms: INTEGER is 97
			-- Number of symbols
			-- (terminal and nonterminal)

feature -- User-defined features



end
