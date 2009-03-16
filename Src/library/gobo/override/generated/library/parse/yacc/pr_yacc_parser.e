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
			yyval4: PR_TOKEN
		do
			inspect yy_act
when 1 then
--|#line 58 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 58")
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
--|#line 58 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 58")
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
--|#line 71 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 71")
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
--|#line 75 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 75")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 5 then
--|#line 78 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 78")
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
--|#line 82 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 82")
end

			type := Void
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyvs1.put (yyval1, yyvsp1)
end
when 7 then
--|#line 86 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 86")
end

			type := Void
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyvs1.put (yyval1, yyvsp1)
end
when 8 then
--|#line 90 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 90")
end

			precedence := precedence + 1
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 9 then
--|#line 94 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 94")
end

			precedence := precedence + 1
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 10 then
--|#line 98 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 98")
end

			precedence := precedence + 1
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 11 then
--|#line 102 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 102")
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
--|#line 110 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 110")
end

			last_grammar.set_expected_conflicts (yyvs3.item (yyvsp3))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp3 := yyvsp3 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 13 then
--|#line 116 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 116")
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
--|#line 120 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 120")
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
--|#line 125 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 125")
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
--|#line 132 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 132")
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
--|#line 136 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 136")
end

			type := yyvs5.item (yyvsp5)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp5 := yyvsp5 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 18 then
--|#line 142 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 142")
end

			yyval5 := new_type (Void, yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp5 := yyvsp5 + 1
	yyvsp2 := yyvsp2 -1
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
--|#line 146 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 146")
end

			yyval5 := new_basic_type (Void, yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp5 := yyvsp5 + 1
	yyvsp2 := yyvsp2 -1
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
--|#line 150 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 150")
end

			yyval5 := new_type (Void, yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp5 := yyvsp5 + 1
	yyvsp2 := yyvsp2 -1
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
--|#line 154 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 154")
end

yyval5 := yyvs5.item (yyvsp5) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs5.put (yyval5, yyvsp5)
end
when 22 then
--|#line 158 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 158")
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
when 23 then
--|#line 162 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 162")
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
--|#line 166 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 166")
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
when 25 then
--|#line 170 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 170")
end

			yyval5 := new_type (Void, yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp5 := yyvsp5 + 1
	yyvsp2 := yyvsp2 -1
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
when 26 then
--|#line 174 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 174")
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
when 27 then
--|#line 178 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 178")
end

			yyval5 := new_generic_type (Void, yyvs2.item (yyvsp2), yyvs6.item (yyvsp6))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp5 := yyvsp5 + 1
	yyvsp2 := yyvsp2 -1
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
when 28 then
--|#line 182 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 182")
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
when 29 then
--|#line 186 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 186")
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
when 30 then
--|#line 190 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 190")
end

			yyval5 := new_type (Void, yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp5 := yyvsp5 + 1
	yyvsp2 := yyvsp2 -1
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
when 31 then
--|#line 194 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 194")
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
when 32 then
--|#line 198 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 198")
end

			yyval5 := new_generic_type (Void, yyvs2.item (yyvsp2), yyvs6.item (yyvsp6))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp5 := yyvsp5 + 1
	yyvsp2 := yyvsp2 -1
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
when 33 then
--|#line 202 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 202")
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
when 34 then
--|#line 206 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 206")
end

			yyval5 := new_labeled_tuple_type (Void, yyvs2.item (yyvsp2), yyvs8.item (yyvsp8))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp5 := yyvsp5 + 1
	yyvsp2 := yyvsp2 -1
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
when 35 then
--|#line 210 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 210")
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
when 36 then
--|#line 214 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 214")
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
when 37 then
--|#line 220 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 220")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 38 then
--|#line 222 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 222")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 39 then
--|#line 224 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 224")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 40 then
--|#line 226 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 226")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 41 then
--|#line 228 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 228")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 42 then
--|#line 230 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 230")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 43 then
--|#line 232 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 232")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 44 then
--|#line 234 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 234")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 45 then
--|#line 236 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 236")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 46 then
--|#line 238 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 238")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 47 then
--|#line 240 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 240")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 48 then
--|#line 242 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 242")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 49 then
--|#line 244 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 244")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 50 then
--|#line 246 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 246")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 51 then
--|#line 248 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 248")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 52 then
--|#line 250 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 250")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 53 then
--|#line 252 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 252")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 54 then
--|#line 254 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 254")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 55 then
--|#line 256 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 256")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 56 then
--|#line 260 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 260")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 57 then
--|#line 262 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 262")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 58 then
--|#line 264 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 264")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 59 then
--|#line 266 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 266")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 60 then
--|#line 268 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 268")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 61 then
--|#line 270 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 270")
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
when 62 then
--|#line 272 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 272")
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
when 63 then
--|#line 276 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 276")
end

yyval2 := Void 
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
when 64 then
--|#line 278 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 278")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 65 then
--|#line 282 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 282")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 66 then
--|#line 284 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 284")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 67 then
--|#line 286 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 286")
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
when 68 then
--|#line 288 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 288")
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
when 69 then
--|#line 292 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 292")
end

			yyval6 := yyvs6.item (yyvsp6)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyvs6.put (yyval6, yyvsp6)
end
when 70 then
--|#line 298 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 298")
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
when 71 then
--|#line 303 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 303")
end

			yyval6 := yyvs6.item (yyvsp6)
			yyval6.force_first (yyvs5.item (yyvsp5))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp5 := yyvsp5 -1
	yyvsp1 := yyvsp1 -1
	yyvs6.put (yyval6, yyvsp6)
end
when 72 then
--|#line 308 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 308")
end

			yyval6 := yyvs6.item (yyvsp6)
			yyval6.force_first (new_type (Void, yyvs2.item (yyvsp2)))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -1
	yyvs6.put (yyval6, yyvsp6)
end
when 73 then
--|#line 313 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 313")
end

			yyval6 := yyvs6.item (yyvsp6)
			yyval6.force_first (new_basic_type (Void, yyvs2.item (yyvsp2)))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -1
	yyvs6.put (yyval6, yyvsp6)
end
when 74 then
--|#line 318 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 318")
end

			yyval6 := yyvs6.item (yyvsp6)
			yyval6.force_first (new_type (Void, yyvs2.item (yyvsp2)))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -1
	yyvs6.put (yyval6, yyvsp6)
end
when 75 then
--|#line 325 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 325")
end

			yyval8 := yyvs8.item (yyvsp8)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyvs8.put (yyval8, yyvsp8)
end
when 76 then
--|#line 331 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 331")
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
when 77 then
--|#line 336 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 336")
end

			yyval8 := yyvs8.item (yyvsp8)
			yyval8.force_first (yyvs7.item (yyvsp7))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp7 := yyvsp7 -1
	yyvsp1 := yyvsp1 -1
	yyvs8.put (yyval8, yyvsp8)
end
when 78 then
--|#line 341 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 341")
end

			yyval8 := yyvs8.item (yyvsp8)
			yyval8.first.labels.force_first (yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -1
	yyvs8.put (yyval8, yyvsp8)
end
when 79 then
--|#line 346 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 346")
end

			yyval8 := yyvs8.item (yyvsp8)
			yyval8.first.labels.force_first (yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -1
	yyvs8.put (yyval8, yyvsp8)
end
when 80 then
--|#line 351 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 351")
end

			yyval8 := yyvs8.item (yyvsp8)
			yyval8.first.labels.force_first (yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -1
	yyvs8.put (yyval8, yyvsp8)
end
when 81 then
--|#line 358 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 358")
end

			yyval7 := new_labeled_type (yyvs2.item (yyvsp2), yyvs5.item (yyvsp5))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp7 := yyvsp7 + 1
	yyvsp2 := yyvsp2 -1
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
when 82 then
--|#line 364 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 364")
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
when 83 then
--|#line 365 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 365")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 84 then
--|#line 366 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 366")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp4 := yyvsp4 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 85 then
--|#line 369 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 369")
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
when 86 then
--|#line 373 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 373")
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
when 87 then
--|#line 378 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 378")
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
when 88 then
--|#line 383 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 383")
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
when 89 then
--|#line 389 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 389")
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
when 90 then
--|#line 395 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 395")
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
when 91 then
--|#line 396 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 396")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 92 then
--|#line 397 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 397")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp4 := yyvsp4 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 93 then
--|#line 400 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 400")
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
when 94 then
--|#line 404 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 404")
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
when 95 then
--|#line 409 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 409")
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
when 96 then
--|#line 414 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 414")
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
when 97 then
--|#line 420 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 420")
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
when 98 then
--|#line 426 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 426")
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
when 99 then
--|#line 427 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 427")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 100 then
--|#line 428 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 428")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp4 := yyvsp4 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 101 then
--|#line 431 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 431")
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
when 102 then
--|#line 435 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 435")
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
when 103 then
--|#line 440 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 440")
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
when 104 then
--|#line 445 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 445")
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
when 105 then
--|#line 451 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 451")
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
when 106 then
--|#line 457 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 457")
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
when 107 then
--|#line 458 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 458")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 108 then
--|#line 459 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 459")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp4 := yyvsp4 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 109 then
--|#line 462 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 462")
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
when 110 then
--|#line 466 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 466")
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
when 111 then
--|#line 471 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 471")
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
when 112 then
--|#line 476 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 476")
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
when 113 then
--|#line 482 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 482")
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
when 114 then
--|#line 488 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 488")
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
--|#line 489 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 489")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 116 then
--|#line 490 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 490")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyvs1.put (yyval1, yyvsp1)
end
when 117 then
--|#line 493 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 493")
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
when 118 then
--|#line 499 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 499")
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
when 119 then
--|#line 503 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 503")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs1.put (yyval1, yyvsp1)
end
when 120 then
--|#line 504 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 504")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 121 then
--|#line 507 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 507")
end

			process_rule (rule)
			rule := Void
			precedence_token := Void
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp1 := yyvsp1 -3
	yyvs1.put (yyval1, yyvsp1)
end
when 122 then
--|#line 515 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 515")
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
when 123 then
--|#line 531 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 531")
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
when 124 then
--|#line 537 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 537")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs1.put (yyval1, yyvsp1)
end
when 125 then
--|#line 538 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 538")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyvs1.put (yyval1, yyvsp1)
end
when 126 then
--|#line 541 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 541")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs1.put (yyval1, yyvsp1)
end
when 127 then
--|#line 542 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 542")
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
when 128 then
--|#line 552 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 552")
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
when 129 then
--|#line 553 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 553")
end

			put_symbol (new_symbol (yyvs2.item (yyvsp2)), rule)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp2 := yyvsp2 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 130 then
--|#line 557 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 557")
end

			put_symbol (new_char_token (yyvs2.item (yyvsp2)), rule)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp2 := yyvsp2 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 131 then
--|#line 561 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 561")
end

			put_symbol (new_string_token (yyvs2.item (yyvsp2)), rule)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp2 := yyvsp2 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 132 then
--|#line 565 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 565")
end

			put_action (new_action (yyvs2.item (yyvsp2)), rule)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp2 := yyvsp2 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 133 then
--|#line 569 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 569")
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
when 134 then
--|#line 579 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 579")
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
when 135 then
--|#line 588 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 588")
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
when 136 then
--|#line 594 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 594")
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
when 137 then
--|#line 604 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 604")
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
when 138 then
--|#line 605 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 605")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs1.put (yyval1, yyvsp1)
end
when 139 then
--|#line 606 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 606")
end

			last_grammar.set_eiffel_code (yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp2 := yyvsp2 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 140 then
--|#line 612 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 612")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 141 then
--|#line 614 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 614")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 142 then
--|#line 616 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 616")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 143 then
--|#line 618 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 618")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 144 then
--|#line 620 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 620")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 145 then
--|#line 622 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 622")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 146 then
--|#line 624 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 624")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 147 then
--|#line 626 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 626")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 148 then
--|#line 628 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 628")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 149 then
--|#line 630 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 630")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 150 then
--|#line 632 "pr_yacc_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'pr_yacc_parser.y' at line 632")
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
			when 198 then
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
			    0,   78,   80,   79,   79,   83,   83,   83,   83,   83,
			   83,   83,   83,   84,   84,   84,   86,   86,   71,   71,
			   71,   71,   72,   72,   72,   72,   72,   72,   72,   72,
			   72,   72,   72,   72,   72,   72,   72,   62,   62,   62,
			   62,   62,   62,   62,   62,   62,   62,   62,   62,   62,
			   62,   62,   62,   62,   62,   62,   63,   63,   63,   63,
			   63,   63,   63,   65,   65,   64,   64,   64,   64,   74,
			   73,   73,   73,   73,   73,   76,   75,   75,   75,   75,
			   75,   77,   85,   85,   85,   67,   67,   67,   67,   67,
			   88,   88,   88,   68,   68,   68,   68,   68,   89,   89,

			   89,   69,   69,   69,   69,   69,   90,   90,   90,   70,
			   70,   70,   70,   70,   87,   87,   87,   91,   81,   81,
			   81,   92,   93,   94,   95,   95,   96,   96,   98,   98,
			   98,   98,   98,   98,   66,   66,   97,   82,   82,   82,
			   61,   61,   61,   61,   61,   61,   61,   61,   61,   61,
			   61, yyDummy>>)
		end

	yytypes1_template: SPECIAL [INTEGER] is
			-- Template for `yytypes1'
		once
			Result := yyfixed_array (<<
			    1,    1,    1,    2,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    1,    1,    1,    1,    1,    2,
			    3,    1,    1,    1,    1,    1,    1,    1,    1,    3,
			    1,    1,    1,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    5,    5,    1,    1,    2,    2,
			    4,    1,    2,    2,    4,    1,    2,    2,    4,    5,
			    1,    2,    1,    1,    1,    1,    6,    8,    1,    6,

			    2,    2,    2,    2,    1,    1,    2,    1,    4,    3,
			    2,    4,    3,    2,    4,    3,    2,    1,    2,    1,
			    2,    2,    4,    1,    3,    1,    3,    2,    2,    2,
			    1,    2,    1,    2,    2,    2,    5,    5,    6,    8,
			    7,    1,    2,    2,    2,    1,    6,    1,    6,    8,
			    2,    2,    1,    2,    2,    2,    2,    4,    3,    2,
			    1,    1,    2,    2,    4,    1,    1,    3,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    2,
			    3,    6,    8,    6,    8,    5,    6,    8,    6,    2,
			    2,    2,    8,    1,    1,    1,    1,    2,    1,    1,

			    1, yyDummy>>)
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
			    2,    3,    0,    5,  118,   16,    0,    0,  106,   98,
			   90,   13,    4,  149,  148,  147,  146,  145,  144,  143,
			   50,   49,   48,   54,   53,   52,   51,   46,   45,   44,
			   43,   42,   41,   40,   39,   38,   37,  150,  142,   55,
			   47,  140,  122,  141,  137,  119,    0,   63,  114,   11,
			   12,   10,    9,    8,   63,   82,  138,    1,  120,  123,
			  128,   68,   67,   66,   65,   58,   57,   56,   20,   18,
			   19,    0,   64,    0,    0,   21,    7,    0,  113,  109,
			  107,    0,  105,  101,   99,    0,   97,   93,   91,    0,
			    6,  139,    0,  124,  126,   63,   32,   34,   63,   27,

			   22,   23,   28,    0,   17,    0,  117,  115,  108,  110,
			  111,  100,  102,  103,   92,   94,   95,   14,    0,    0,
			   89,   85,   83,  121,  136,  128,    0,  131,  130,  132,
			    0,  129,   30,   20,   18,   19,   70,   21,    0,    0,
			   76,   25,   20,   18,   19,   63,   26,   63,   31,   33,
			   36,   35,  116,  112,  104,   96,    0,   84,   86,   87,
			  125,    0,  135,  134,  133,   63,   63,   63,   63,   63,
			   69,   75,    0,   63,   63,   63,   24,   29,   15,   88,
			    0,   74,   80,   72,   78,   81,   73,   79,   71,    0,
			    0,    0,   77,    0,    0,    0,    0,  127,    0,    0,

			    0, yyDummy>>)
		end

	yydefgoto_template: SPECIAL [INTEGER] is
			-- Template for `yydefgoto'
		once
			Result := yyfixed_array (<<
			   42,   43,   71,   72,   73,  164,  122,   88,   84,   80,
			  136,  137,  138,   96,  139,   97,  140,  198,    2,    1,
			   44,   57,   12,   55,   90,   48,   76,   53,   52,   51,
			  107,   45,   46,   60,   92,   93,  125,   94, yyDummy>>)
		end

	yypact_template: SPECIAL [INTEGER] is
			-- Template for `yypact'
		once
			Result := yyfixed_array (<<
			 -32768, -32768,   58, -32768,  832,   54,  832,   56, -32768, -32768,
			 -32768,   53, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768,  634, -32768,   52,  555, -32768, -32768,
			 -32768,  253,  214,  175,  555, -32768,   85, -32768, -32768, -32768,
			 -32768,  995,  969,  943,  917, -32768, -32768, -32768,   44,   43,
			 -32768,  891,   70,   49,   31, -32768,  292,  799, -32768,    0,
			 -32768,  766, -32768,  -10, -32768,  733, -32768,  -12, -32768,  -19,
			  136, -32768,  -44,    6,  598,  441, -32768, -32768,  403, -32768,

			   27, -32768,   26,    8, -32768,  832, -32768, -32768, -32768,   60,
			 -32768, -32768,   59, -32768, -32768,   41, -32768, -32768,  832,  700,
			 -32768,  -16, -32768, -32768, -32768, -32768,   14, -32768, -32768, -32768,
			  667, -32768, -32768,  -17,  -30,   19, -32768,   17,   18,   16,
			    2, -32768,  -27,  -28,   -2,  365, -32768,  327, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768,    1, -32768,   34, -32768,
			    6,    3, -32768, -32768, -32768,  517,  517,  555,  517,  479,
			 -32768, -32768,  865,  479,  479,  479, -32768, -32768, -32768, -32768,
			  -15, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,  -11,
			  -29,  -13, -32768,   24,  865,  865,  865, -32768,   38,    4,

			 -32768, yyDummy>>)
		end

	yypgoto_template: SPECIAL [INTEGER] is
			-- Template for `yypgoto'
		once
			Result := yyfixed_array (<<
			    5,  -47, -32768, -32768, -32768, -32768,   -6,   23,   33,   32,
			  -37,  -38,  -81,  -68, -153,    9, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			    7,   62, -32768, -32768, -32768,  -18, -32768, -32768, yyDummy>>)
		end

	yytable_template: SPECIAL [INTEGER] is
			-- Template for `yytable'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 1034)
			yytable_template_1 (an_array)
			yytable_template_2 (an_array)
			Result := yyfixed_array (an_array)
		end

	yytable_template_1 (an_array: ARRAY [INTEGER]) is
			-- Fill chunk #1 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			   70,   99,  159,  118,  200,  124,  116,   70,  113,   75,
			   74,   49,  182,  184,  123,  187,   75,   89,  110,  192,
			  167,  167,  151,   98,  101,   98,   95,  166,  195,  174,
			  173,  158,  146,  117,  148,  115,   95,  112,  199,  197,
			  165,  182,  184,  187,  196,  193,  194,  109,  135,  150,
			  180,  144,  179,  178,  126,  175,   79,   83,   87,  155,
			  172,   11,   10,    9,    8,    7,   99,    6,    5,    4,
			  171,    3,  170,  161,  169,   99,  168,  154,  153,  147,
			  145,  106,   79,  104,  181,  183,   83,  186,  188,  103,
			   87,  102,  181,  183,  186,  121,   98,   95,  144,  131,

			  135,   91,   59,   50,   54,   47,   58,  160,  114,  108,
			  106,  149,  152,  157,  111,    0,    0,    0,  135,  135,
			   70,  135,  144,  156,  121,  191,  144,  144,  144,   75,
			  185,    0,    0,    0,    0,  163,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,  191,  191,  191,
			   41,    0,    0,  120,    0,   40,   39,   38,   37,   36,
			   35,   34,   33,   32,   31,   30,   29,   28,   27,   26,
			   25,   24,   23,   22,   21,   20,   19,   18,   17,   16,
			   15,   14,   13,    0,    0,    0,    0,    0,    0,   41,
			    0,    0,   86,  119,   40,   39,   38,   37,   36,   35,

			   34,   33,   32,   31,   30,   29,   28,   27,   26,   25,
			   24,   23,   22,   21,   20,   19,   18,   17,   16,   15,
			   14,   13,    0,    0,    0,    0,    0,    0,   41,    0,
			    0,   82,   85,   40,   39,   38,   37,   36,   35,   34,
			   33,   32,   31,   30,   29,   28,   27,   26,   25,   24,
			   23,   22,   21,   20,   19,   18,   17,   16,   15,   14,
			   13,    0,    0,    0,    0,    0,    0,   41,    0,    0,
			   78,   81,   40,   39,   38,   37,   36,   35,   34,   33,
			   32,   31,   30,   29,   28,   27,   26,   25,   24,   23,
			   22,   21,   20,   19,   18,   17,   16,   15,   14,   13,

			    0,    0,    0,    0,    0,    0,   41,    0,    0,    0,
			   77,   40,   39,   38,   37,   36,   35,   34,   33,   32,
			   31,   30,   29,   28,   27,   26,   25,   24,   23,   22,
			   21,   20,   19,   18,   17,   16,   15,   14,   13,    0,
			    0,  134,    0,    0,    0,    0,   40,   39,  133,  105,
			   36,   35,   34,   33,   32,   31,   30,   29,   28,   27,
			   26,   25,   24,   23,   22,   21,   20,    0,    0,   67,
			   66,   65,   64,   63,    0,    0,    0,    0,    0,  143,
			    0,  177,   62,   61,   40,   39,  142,    0,   36,   35,
			   34,   33,   32,   31,   30,   29,   28,   27,   26,   25,

			   24,   23,   22,   21,   20,    0,    0,   67,   66,   65,
			   64,   63,    0,    0,    0,    0,    0,  143,    0,  176,
			   62,   61,   40,   39,  142,    0,   36,   35,   34,   33,
			   32,   31,   30,   29,   28,   27,   26,   25,   24,   23,
			   22,   21,   20,    0,    0,   67,   66,   65,   64,   63,
			    0,    0,    0,    0,    0,  134,    0,  141,   62,   61,
			   40,   39,  133,    0,   36,   35,   34,   33,   32,   31,
			   30,   29,   28,   27,   26,   25,   24,   23,   22,   21,
			   20,    0,    0,   67,   66,   65,   64,   63,    0,    0,
			    0,    0,    0,  143,    0,  132,   62,   61,   40,   39,

			  142,    0,   36,   35,   34,   33,   32,   31,   30,   29,
			   28,   27,   26,   25,   24,   23,   22,   21,   20,    0,
			    0,   67,   66,   65,   64,   63,    0,    0,    0,    0,
			    0,  134,    0,    0,   62,   61,   40,   39,  133,    0,
			   36,   35,   34,   33,   32,   31,   30,   29,   28,   27,
			   26,   25,   24,   23,   22,   21,   20,    0,    0,   67,
			   66,   65,   64,   63,    0,    0,    0,    0,    0,   69,
			    0,    0,   62,   61,   40,   39,   68,    0,   36,   35,
			   34,   33,   32,   31,   30,   29,   28,   27,   26,   25,
			   24,   23,   22,   21,   20,    0,    0,   67,   66,   65,

			   64,   63,    0,    0,    0,    0,  130,    0,    0,    0,
			   62,   61,   41,  129,    0,  128,  127,   40,   39,   38,
			   37,   36,   35,   34,   33,   32,   31,   30,   29,   28,
			   27,   26,   25,   24,   23,   22,   21,   20,   19,   18,
			   17,   16,   15,   14,   13,   56,    0,    0,   41,    0,
			    0,    0,    0,   40,   39,   38,   37,   36,   35,   34,
			   33,   32,   31,   30,   29,   28,   27,   26,   25,   24,
			   23,   22,   21,   20,   19,   18,   17,   16,   15,   14,
			   13,   41,    0,    0,  162,    0,   40,   39,   38,   37,
			   36,   35,   34,   33,   32,   31,   30,   29,   28,   27,

			   26,   25,   24,   23,   22,   21,   20,   19,   18,   17,
			   16,   15,   14,   13,   41,    0,    0,  120,    0,   40,
			   39,   38,   37,   36,   35,   34,   33,   32,   31,   30,
			   29,   28,   27,   26,   25,   24,   23,   22,   21,   20,
			   19,   18,   17,   16,   15,   14,   13,   41,    0,    0,
			   86,    0,   40,   39,   38,   37,   36,   35,   34,   33,
			   32,   31,   30,   29,   28,   27,   26,   25,   24,   23,
			   22,   21,   20,   19,   18,   17,   16,   15,   14,   13,
			   41,    0,    0,   82,    0,   40,   39,   38,   37,   36,
			   35,   34,   33,   32,   31,   30,   29,   28,   27,   26,

			   25,   24,   23,   22,   21,   20,   19,   18,   17,   16,
			   15,   14,   13,   41,    0,    0,   78,    0,   40,   39,
			   38,   37,   36,   35,   34,   33,   32,   31,   30,   29,
			   28,   27,   26,   25,   24,   23,   22,   21,   20,   19,
			   18,   17,   16,   15,   14,   13,   41,    0,    0,    0,
			    0,   40,   39,   38,   37,   36,   35,   34,   33,   32,
			   31,   30,   29,   28,   27,   26,   25,   24,   23,   22,
			   21,   20,   19,   18,   17,   16,   15,   14,   13,  190,
			    0,    0,    0,    0,   40,   39,  189,    0,   36,   35,
			   34,   33,   32,   31,   30,   29,   28,   27,   26,   25,

			   24,   23,   22,   21,   20,  100,    0,    0,    0,    0,
			   40,   39,    0,    0,   36,   35,   34,   33,   32,   31,
			   30,   29,   28,   27,   26,   25,   24,   23,   22,   21,
			   20,  -59,    0,    0,    0,    0,  -59,  -59,    0,    0,
			  -59,  -59,  -59,  -59,  -59,  -59,  -59,  -59,  -59,  -59,
			  -59,  -59,  -59,  -59,  -59,  -59,  -59,  -60,    0,    0,
			    0,    0,  -60,  -60,    0,    0,  -60,  -60,  -60,  -60,
			  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,  -60,
			  -60,  -60,  -60,  -61,    0,    0,    0,    0,  -61,  -61,
			    0,    0,  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61, yyDummy>>,
			1, 1000, 0)
		end

	yytable_template_2 (an_array: ARRAY [INTEGER]) is
			-- Fill chunk #2 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -61,  -62,
			    0,    0,    0,    0,  -62,  -62,    0,    0,  -62,  -62,
			  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,  -62,
			  -62,  -62,  -62,  -62,  -62, yyDummy>>,
			1, 35, 1000)
		end

	yycheck_template: SPECIAL [INTEGER] is
			-- Template for `yycheck'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 1034)
			yycheck_template_1 (an_array)
			yycheck_template_2 (an_array)
			Result := yyfixed_array (an_array)
		end

	yycheck_template_1 (an_array: ARRAY [INTEGER]) is
			-- Fill chunk #1 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			   47,   69,   18,   22,    0,   49,   18,   54,   18,   47,
			   47,    6,  165,  166,   58,  168,   54,   54,   18,  172,
			   50,   50,   14,   53,   71,   53,   53,   57,   57,   57,
			   57,   47,  100,   52,  102,   47,   53,   47,    0,   15,
			   57,  194,  195,  196,   57,   60,   57,   47,   95,   41,
			   47,   98,   18,   52,   48,   57,   51,   52,   53,   18,
			   58,    3,    4,    5,    6,    7,  134,    9,   10,   11,
			   54,   13,   54,   59,   57,  143,   57,   18,   18,   53,
			   53,   76,   77,   52,  165,  166,   81,  168,  169,   40,
			   85,   21,  173,  174,  175,   90,   53,   53,  145,   94,

			  147,   16,   50,   47,   51,   51,   44,  125,   85,   77,
			  105,  102,  105,  119,   81,   -1,   -1,   -1,  165,  166,
			  167,  168,  169,  118,  119,  172,  173,  174,  175,  167,
			  167,   -1,   -1,   -1,   -1,  130,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,  194,  195,  196,
			   14,   -1,   -1,   17,   -1,   19,   20,   21,   22,   23,
			   24,   25,   26,   27,   28,   29,   30,   31,   32,   33,
			   34,   35,   36,   37,   38,   39,   40,   41,   42,   43,
			   44,   45,   46,   -1,   -1,   -1,   -1,   -1,   -1,   14,
			   -1,   -1,   17,   57,   19,   20,   21,   22,   23,   24,

			   25,   26,   27,   28,   29,   30,   31,   32,   33,   34,
			   35,   36,   37,   38,   39,   40,   41,   42,   43,   44,
			   45,   46,   -1,   -1,   -1,   -1,   -1,   -1,   14,   -1,
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
			   -1,   14,   -1,   -1,   -1,   -1,   19,   20,   21,   57,
			   23,   24,   25,   26,   27,   28,   29,   30,   31,   32,
			   33,   34,   35,   36,   37,   38,   39,   -1,   -1,   42,
			   43,   44,   45,   46,   -1,   -1,   -1,   -1,   -1,   14,
			   -1,   54,   55,   56,   19,   20,   21,   -1,   23,   24,
			   25,   26,   27,   28,   29,   30,   31,   32,   33,   34,

			   35,   36,   37,   38,   39,   -1,   -1,   42,   43,   44,
			   45,   46,   -1,   -1,   -1,   -1,   -1,   14,   -1,   54,
			   55,   56,   19,   20,   21,   -1,   23,   24,   25,   26,
			   27,   28,   29,   30,   31,   32,   33,   34,   35,   36,
			   37,   38,   39,   -1,   -1,   42,   43,   44,   45,   46,
			   -1,   -1,   -1,   -1,   -1,   14,   -1,   54,   55,   56,
			   19,   20,   21,   -1,   23,   24,   25,   26,   27,   28,
			   29,   30,   31,   32,   33,   34,   35,   36,   37,   38,
			   39,   -1,   -1,   42,   43,   44,   45,   46,   -1,   -1,
			   -1,   -1,   -1,   14,   -1,   54,   55,   56,   19,   20,

			   21,   -1,   23,   24,   25,   26,   27,   28,   29,   30,
			   31,   32,   33,   34,   35,   36,   37,   38,   39,   -1,
			   -1,   42,   43,   44,   45,   46,   -1,   -1,   -1,   -1,
			   -1,   14,   -1,   -1,   55,   56,   19,   20,   21,   -1,
			   23,   24,   25,   26,   27,   28,   29,   30,   31,   32,
			   33,   34,   35,   36,   37,   38,   39,   -1,   -1,   42,
			   43,   44,   45,   46,   -1,   -1,   -1,   -1,   -1,   14,
			   -1,   -1,   55,   56,   19,   20,   21,   -1,   23,   24,
			   25,   26,   27,   28,   29,   30,   31,   32,   33,   34,
			   35,   36,   37,   38,   39,   -1,   -1,   42,   43,   44,

			   45,   46,   -1,   -1,   -1,   -1,    8,   -1,   -1,   -1,
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
			   -1,   -1,   -1,   -1,   19,   20,   21,   -1,   23,   24,
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
			   -1,   -1,   23,   24,   25,   26,   27,   28,   29,   30, yyDummy>>,
			1, 1000, 0)
		end

	yycheck_template_2 (an_array: ARRAY [INTEGER]) is
			-- Fill chunk #2 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			   31,   32,   33,   34,   35,   36,   37,   38,   39,   14,
			   -1,   -1,   -1,   -1,   19,   20,   -1,   -1,   23,   24,
			   25,   26,   27,   28,   29,   30,   31,   32,   33,   34,
			   35,   36,   37,   38,   39, yyDummy>>,
			1, 35, 1000)
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

feature {NONE} -- Constants

	yyFinal: INTEGER is 200
			-- Termination state id

	yyFlag: INTEGER is -32768
			-- Most negative INTEGER

	yyNtbase: INTEGER is 61
			-- Number of tokens

	yyLast: INTEGER is 1034
			-- Upper bound of `yytable' and `yycheck'

	yyMax_token: INTEGER is 303
			-- Maximum token id
			-- (upper bound of `yytranslate'.)

	yyNsyms: INTEGER is 99
			-- Number of symbols
			-- (terminal and nonterminal)

feature -- User-defined features



end
