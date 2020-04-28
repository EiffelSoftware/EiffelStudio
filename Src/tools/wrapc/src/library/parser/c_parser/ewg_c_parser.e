note
	description: "Parse type definitions from a C header file"
	status: "See notice at end of class"
	author: "Based on http://www.lysator.liu.se/c"
	date: "$Date$"
	revision: "$Revision$"
	info: "Based on http://www.lysator.liu.se/c"

class EWG_C_PARSER

inherit

	EWG_C_PARSER_SKELETON

	EWG_C_PHASE_1_AST_FACTORY

create

	make


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
			create yyspecial_routines1
			yyvsc1 := yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.make (yyvsc1)
			create yyspecial_routines2
			yyvsc2 := yyInitial_yyvs_size
			yyvs2 := yyspecial_routines2.make (yyvsc2)
			create yyspecial_routines3
			yyvsc3 := yyInitial_yyvs_size
			yyvs3 := yyspecial_routines3.make (yyvsc3)
			create yyspecial_routines4
			yyvsc4 := yyInitial_yyvs_size
			yyvs4 := yyspecial_routines4.make (yyvsc4)
			create yyspecial_routines5
			yyvsc5 := yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.make (yyvsc5)
			create yyspecial_routines6
			yyvsc6 := yyInitial_yyvs_size
			yyvs6 := yyspecial_routines6.make (yyvsc6)
			create yyspecial_routines7
			yyvsc7 := yyInitial_yyvs_size
			yyvs7 := yyspecial_routines7.make (yyvsc7)
			create yyspecial_routines8
			yyvsc8 := yyInitial_yyvs_size
			yyvs8 := yyspecial_routines8.make (yyvsc8)
			create yyspecial_routines9
			yyvsc9 := yyInitial_yyvs_size
			yyvs9 := yyspecial_routines9.make (yyvsc9)
			create yyspecial_routines10
			yyvsc10 := yyInitial_yyvs_size
			yyvs10 := yyspecial_routines10.make (yyvsc10)
			create yyspecial_routines11
			yyvsc11 := yyInitial_yyvs_size
			yyvs11 := yyspecial_routines11.make (yyvsc11)
			create yyspecial_routines12
			yyvsc12 := yyInitial_yyvs_size
			yyvs12 := yyspecial_routines12.make (yyvsc12)
			create yyspecial_routines13
			yyvsc13 := yyInitial_yyvs_size
			yyvs13 := yyspecial_routines13.make (yyvsc13)
			create yyspecial_routines14
			yyvsc14 := yyInitial_yyvs_size
			yyvs14 := yyspecial_routines14.make (yyvsc14)
			create yyspecial_routines15
			yyvsc15 := yyInitial_yyvs_size
			yyvs15 := yyspecial_routines15.make (yyvsc15)
			create yyspecial_routines16
			yyvsc16 := yyInitial_yyvs_size
			yyvs16 := yyspecial_routines16.make (yyvsc16)
			create yyspecial_routines17
			yyvsc17 := yyInitial_yyvs_size
			yyvs17 := yyspecial_routines17.make (yyvsc17)
		end

	yy_init_value_stacks
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
			yyvsp10 := -1
			yyvsp11 := -1
			yyvsp12 := -1
			yyvsp13 := -1
			yyvsp14 := -1
			yyvsp15 := -1
			yyvsp16 := -1
			yyvsp17 := -1
		end

	yy_clear_value_stacks
			-- Clear objects in semantic value stacks so that
			-- they can be collected by the garbage collector.
		do
			yyvs1.keep_head (0)
			yyvs2.keep_head (0)
			yyvs3.keep_head (0)
			yyvs4.keep_head (0)
			yyvs5.keep_head (0)
			yyvs6.keep_head (0)
			yyvs7.keep_head (0)
			yyvs8.keep_head (0)
			yyvs9.keep_head (0)
			yyvs10.keep_head (0)
			yyvs11.keep_head (0)
			yyvs12.keep_head (0)
			yyvs13.keep_head (0)
			yyvs14.keep_head (0)
			yyvs15.keep_head (0)
			yyvs16.keep_head (0)
			yyvs17.keep_head (0)
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
					debug ("GEYACC")
						std.error.put_line ("Resize yyvs1")
					end
					yyvsc1 := yyvsc1 + yyInitial_yyvs_size
					yyvs1 := yyspecial_routines1.aliased_resized_area (yyvs1, yyvsc1)
				end
				yyspecial_routines1.force (yyvs1, last_detachable_any_value, yyvsp1)
			when 2 then
				yyvsp2 := yyvsp2 + 1
				if yyvsp2 >= yyvsc2 then
					debug ("GEYACC")
						std.error.put_line ("Resize yyvs2")
					end
					yyvsc2 := yyvsc2 + yyInitial_yyvs_size
					yyvs2 := yyspecial_routines2.aliased_resized_area (yyvs2, yyvsc2)
				end
				yyspecial_routines2.force (yyvs2, last_string_value, yyvsp2)
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
			yyval1: detachable ANY
		do
			yyvsp1 := yyvsp1 + 1
			if yyvsp1 >= yyvsc1 then
				debug ("GEYACC")
					std.error.put_line ("Resize yyvs1")
				end
				yyvsc1 := yyvsc1 + yyInitial_yyvs_size
				yyvs1 := yyspecial_routines1.aliased_resized_area (yyvs1, yyvsc1)
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
			when 10 then
				yyvsp10 := yyvsp10 - 1
			when 11 then
				yyvsp11 := yyvsp11 - 1
			when 12 then
				yyvsp12 := yyvsp12 - 1
			when 13 then
				yyvsp13 := yyvsp13 - 1
			when 14 then
				yyvsp14 := yyvsp14 - 1
			when 15 then
				yyvsp15 := yyvsp15 - 1
			when 16 then
				yyvsp16 := yyvsp16 - 1
			when 17 then
				yyvsp17 := yyvsp17 - 1
			else
				debug ("GEYACC")
					std.error.put_string ("Error in parser: unknown type id: ")
					std.error.put_integer (yy_type_id)
					std.error.put_new_line
				end
				abort
			end
		end

	yy_run_geyacc
			-- You must run geyacc to regenerate this class.
		do
		end

feature {NONE} -- Semantic actions

	yy_do_action (yy_act: INTEGER)
			-- Execute semantic action.
		local
			yyval2: STRING
			yyval16: DS_LINKED_LIST [INTEGER]
			yyval17: INTEGER
			yyval3: EWG_C_PHASE_1_DECLARATION
			yyval7: DS_LINKED_LIST [ANY]
			yyval4: DS_LINKED_LIST [EWG_C_PHASE_1_DECLARATOR]
			yyval5: EWG_C_PHASE_1_DECLARATOR
			yyval11: EWG_C_PHASE_1_STORAGE_CLASS_SPECIFIERS
			yyval10: EWG_C_PHASE_1_TYPE_SPECIFIER
			yyval12: BOOLEAN
			yyval13: DS_LINKED_LIST [EWG_C_PHASE_1_DECLARATION]
			yyval1: detachable ANY
			yyval9: EWG_C_PHASE_1_TYPE_QUALIFIER
			yyval6: EWG_C_PHASE_1_DIRECT_DECLARATOR
			yyval14: DS_LINKED_LIST [EWG_C_PHASE_1_POINTER]
			yyval8: DS_LINKED_LIST [EWG_C_PHASE_1_TYPE_QUALIFIER]
			yyval15: EWG_C_PHASE_1_PARAMETER_TYPE_LIST
		do
				inspect yy_act
when 1 then
--|#line 190 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 190")
end

			yyval2 := yyvs2.item (yyvsp2)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 2 then
--|#line 194 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 194")
end

			yyval2 := yyvs2.item (yyvsp2)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 3 then
--|#line 198 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 198")
end

			yyval2 := yyvs2.item (yyvsp2)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 4 then
--|#line 202 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 202")
end

			yyval2 := yyvs2.item (yyvsp2)
			yyval2.prepend ("(")
			yyval2.append_character (')')
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 5 then
--|#line 211 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 211")
end

			yyval2 := yyvs2.item (yyvsp2)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 6 then
--|#line 215 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 215")
end

			yyval2 := yyvs2.item (yyvsp2 - 1)
			yyval2.append_character ('[')
			yyval2.append_string (yyvs2.item (yyvsp2))
			yyval2.append_character (']')
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -2
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 7 then
--|#line 222 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 222")
end

			yyval2 := yyvs2.item (yyvsp2)
			yyval2.append_string ("()")
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 8 then
--|#line 227 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 227")
end

			yyval2 := yyvs2.item (yyvsp2 - 1)
			yyval2.append_character ('(')
			yyval2.append_string (yyvs2.item (yyvsp2))
			yyval2.append_character (')')
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -2
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 9 then
--|#line 234 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 234")
end

			yyval2 := yyvs2.item (yyvsp2 - 1)
			yyval2.append_character ('.')
			yyval2.append_string (yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 10 then
--|#line 240 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 240")
end

			yyval2 := yyvs2.item (yyvsp2 - 2)
			yyval2.append_string (yyvs2.item (yyvsp2 - 1))
			yyval2.append_string (yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 -2
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 11 then
--|#line 246 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 246")
end

			yyval2 := yyvs2.item (yyvsp2 - 1)
			yyval2.append_string (yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp2 := yyvsp2 -1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 12 then
--|#line 251 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 251")
end

			yyval2 := yyvs2.item (yyvsp2 - 1)
			yyval2.append_string (yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp2 := yyvsp2 -1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 13 then
--|#line 259 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 259")
end

			yyval2 := yyvs2.item (yyvsp2)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 14 then
--|#line 263 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 263")
end

			yyval2 := yyvs2.item (yyvsp2 - 1)
			yyval2.append_character (',')
			yyval2.append_string (yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 15 then
--|#line 272 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 272")
end

			yyval2 := yyvs2.item (yyvsp2)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 16 then
--|#line 276 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 276")
end

			yyval2 := yyvs2.item (yyvsp2 - 1)
			yyval2.append_string (yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp2 := yyvsp2 -1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 17 then
--|#line 281 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 281")
end

			yyval2 := yyvs2.item (yyvsp2 - 1)
			yyval2.append_string (yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp2 := yyvsp2 -1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 18 then
--|#line 286 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 286")
end

			yyval2 := yyvs2.item (yyvsp2 - 1)
			yyval2.append_string (yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp2 := yyvsp2 -1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 19 then
--|#line 291 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 291")
end

			yyval2 := yyvs2.item (yyvsp2 - 1)
			yyval2.append_string (yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp2 := yyvsp2 -1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 20 then
--|#line 296 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 296")
end

			yyval2 := yyvs2.item (yyvsp2 - 1)
			yyval2.append_character ('(')
			yyval2.append_string (yyvs2.item (yyvsp2))
			yyval2.append_character (')')
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -3
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 21 then
--|#line 306 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 306")
end

			yyval2 := "&"
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp2 := yyvsp2 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp2 >= yyvsc2 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs2")
		end
		yyvsc2 := yyvsc2 + yyInitial_yyvs_size
		yyvs2 := yyspecial_routines2.aliased_resized_area (yyvs2, yyvsc2)
	end
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 22 then
--|#line 310 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 310")
end

			yyval2 := "*"
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp2 := yyvsp2 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp2 >= yyvsc2 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs2")
		end
		yyvsc2 := yyvsc2 + yyInitial_yyvs_size
		yyvs2 := yyspecial_routines2.aliased_resized_area (yyvs2, yyvsc2)
	end
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 23 then
--|#line 314 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 314")
end

			yyval2 := "+"
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp2 := yyvsp2 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp2 >= yyvsc2 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs2")
		end
		yyvsc2 := yyvsc2 + yyInitial_yyvs_size
		yyvs2 := yyspecial_routines2.aliased_resized_area (yyvs2, yyvsc2)
	end
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 24 then
--|#line 318 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 318")
end

			yyval2 := "-"
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp2 := yyvsp2 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp2 >= yyvsc2 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs2")
		end
		yyvsc2 := yyvsc2 + yyInitial_yyvs_size
		yyvs2 := yyspecial_routines2.aliased_resized_area (yyvs2, yyvsc2)
	end
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 25 then
--|#line 322 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 322")
end

			yyval2 := "~"
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp2 := yyvsp2 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp2 >= yyvsc2 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs2")
		end
		yyvsc2 := yyvsc2 + yyInitial_yyvs_size
		yyvs2 := yyspecial_routines2.aliased_resized_area (yyvs2, yyvsc2)
	end
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 26 then
--|#line 326 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 326")
end

			yyval2 := "!"
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp2 := yyvsp2 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp2 >= yyvsc2 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs2")
		end
		yyvsc2 := yyvsc2 + yyInitial_yyvs_size
		yyvs2 := yyspecial_routines2.aliased_resized_area (yyvs2, yyvsc2)
	end
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 27 then
--|#line 333 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 333")
end

			yyval2 := yyvs2.item (yyvsp2)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 28 then
--|#line 337 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 337")
end

			yyval2 := yyvs2.item (yyvsp2 - 1)
			yyval2.prepend ("(")
			yyval2.append_character (')')
			yyval2.append_string (yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -3
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 29 then
--|#line 347 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 347")
end

			yyval2 := yyvs2.item (yyvsp2)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 30 then
--|#line 351 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 351")
end

			yyval2 := yyvs2.item (yyvsp2 - 1)
			yyval2.append_character ('*')
			yyval2.append_string (yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 31 then
--|#line 357 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 357")
end

			yyval2 := yyvs2.item (yyvsp2 - 1)
			yyval2.append_character ('/')
			yyval2.append_string (yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 32 then
--|#line 363 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 363")
end

			yyval2 := yyvs2.item (yyvsp2 - 1)
			yyval2.append_character ('%%')
			yyval2.append_string (yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 33 then
--|#line 372 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 372")
end

			yyval2 := yyvs2.item (yyvsp2)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 34 then
--|#line 376 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 376")
end

			yyval2 := yyvs2.item (yyvsp2 - 1)
			yyval2.append_character ('+')
			yyval2.append_string (yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 35 then
--|#line 382 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 382")
end

			yyval2 := yyvs2.item (yyvsp2 - 1)
			yyval2.append_character ('-')
			yyval2.append_string (yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 36 then
--|#line 391 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 391")
end

			yyval2 := yyvs2.item (yyvsp2)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 37 then
--|#line 395 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 395")
end

			yyval2 := yyvs2.item (yyvsp2 - 2)
			yyval2.append_string (yyvs2.item (yyvsp2 - 1))
			yyval2.append_string (yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 -2
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 38 then
--|#line 401 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 401")
end

			yyval2 := yyvs2.item (yyvsp2 - 2)
			yyval2.append_string (yyvs2.item (yyvsp2 - 1))
			yyval2.append_string (yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 -2
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 39 then
--|#line 410 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 410")
end

			yyval2 := yyvs2.item (yyvsp2)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 40 then
--|#line 414 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 414")
end

			yyval2 := yyvs2.item (yyvsp2 - 1)
			yyval2.append_character ('<')
			yyval2.append_string (yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 41 then
--|#line 420 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 420")
end

			yyval2 := yyvs2.item (yyvsp2 - 1)
			yyval2.append_character ('>')
			yyval2.append_string (yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 42 then
--|#line 426 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 426")
end

			yyval2 := yyvs2.item (yyvsp2 - 2)
			yyval2.append_string (yyvs2.item (yyvsp2 - 1))
			yyval2.append_string (yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 -2
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 43 then
--|#line 432 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 432")
end

			yyval2 := yyvs2.item (yyvsp2 - 2)
			yyval2.append_string (yyvs2.item (yyvsp2 - 1))
			yyval2.append_string (yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 -2
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 44 then
--|#line 441 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 441")
end

			yyval2 := yyvs2.item (yyvsp2)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 45 then
--|#line 445 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 445")
end

			yyval2 := yyvs2.item (yyvsp2 - 2)
			yyval2.append_string (yyvs2.item (yyvsp2 - 1))
			yyval2.append_string (yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 -2
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 46 then
--|#line 451 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 451")
end

			yyval2 := yyvs2.item (yyvsp2 - 2)
			yyval2.append_string (yyvs2.item (yyvsp2 - 1))
			yyval2.append_string (yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 -2
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 47 then
--|#line 460 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 460")
end

			yyval2 := yyvs2.item (yyvsp2)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 48 then
--|#line 464 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 464")
end

			yyval2 := yyvs2.item (yyvsp2 - 1)
			yyval2.append_character ('&')
			yyval2.append_string (yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 49 then
--|#line 473 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 473")
end

			yyval2 := yyvs2.item (yyvsp2)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 50 then
--|#line 477 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 477")
end

			yyval2 := yyvs2.item (yyvsp2 - 1)
			yyval2.append_character ('^')
			yyval2.append_string (yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 51 then
--|#line 486 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 486")
end

			yyval2 := yyvs2.item (yyvsp2)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 52 then
--|#line 490 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 490")
end

			yyval2 := yyvs2.item (yyvsp2 - 1)
			yyval2.append_character ('|')
			yyval2.append_string (yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 53 then
--|#line 499 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 499")
end

			yyval2 := yyvs2.item (yyvsp2)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 54 then
--|#line 503 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 503")
end

			yyval2 := yyvs2.item (yyvsp2 - 2)
			yyval2.append_string (yyvs2.item (yyvsp2 - 1))
			yyval2.append_string (yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 -2
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 55 then
--|#line 512 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 512")
end

			yyval2 := yyvs2.item (yyvsp2)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 56 then
--|#line 516 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 516")
end

			yyval2 := yyvs2.item (yyvsp2 - 2)
			yyval2.append_string (yyvs2.item (yyvsp2 - 1))
			yyval2.append_string (yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 -2
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 57 then
--|#line 525 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 525")
end

			yyval2 := yyvs2.item (yyvsp2)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 58 then
--|#line 529 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 529")
end

			yyval2 := yyvs2.item (yyvsp2 - 2)
			yyval2.append_character ('?')
			yyval2.append_string (yyvs2.item (yyvsp2 - 1))
			yyval2.append_character (':')
			yyval2.append_string (yyvs2.item (yyvsp2 - 1))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp2 := yyvsp2 -2
	yyvsp1 := yyvsp1 -2
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 59 then
--|#line 540 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 540")
end

			yyval2 := yyvs2.item (yyvsp2)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 60 then
--|#line 544 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 544")
end

			yyval2 := yyvs2.item (yyvsp2 - 2)
			yyval2.append_string (yyvs2.item (yyvsp2 - 1))
			yyval2.append_string (yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 -2
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 61 then
--|#line 553 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 553")
end

			yyval2 := "="
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp2 := yyvsp2 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp2 >= yyvsc2 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs2")
		end
		yyvsc2 := yyvsc2 + yyInitial_yyvs_size
		yyvs2 := yyspecial_routines2.aliased_resized_area (yyvs2, yyvsc2)
	end
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 62 then
--|#line 557 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 557")
end

			yyval2 := yyvs2.item (yyvsp2)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 63 then
--|#line 561 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 561")
end

			yyval2 := yyvs2.item (yyvsp2)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 64 then
--|#line 565 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 565")
end

			yyval2 := yyvs2.item (yyvsp2)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 65 then
--|#line 569 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 569")
end

			yyval2 := yyvs2.item (yyvsp2)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 66 then
--|#line 573 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 573")
end

			yyval2 := yyvs2.item (yyvsp2)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 67 then
--|#line 577 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 577")
end

			yyval2 := yyvs2.item (yyvsp2)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 68 then
--|#line 581 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 581")
end

			yyval2 := yyvs2.item (yyvsp2)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 69 then
--|#line 585 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 585")
end

			yyval2 := yyvs2.item (yyvsp2)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 70 then
--|#line 589 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 589")
end

			yyval2 := yyvs2.item (yyvsp2)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 71 then
--|#line 593 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 593")
end

			yyval2 := yyvs2.item (yyvsp2)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 72 then
--|#line 600 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 600")
end

			yyval2 := yyvs2.item (yyvsp2)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 73 then
--|#line 604 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 604")
end

			yyval2 := yyvs2.item (yyvsp2 - 1)
			yyval2.append_character (',')
			yyval2.append_string (yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 74 then
--|#line 613 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 613")
end

			yyval2 := yyvs2.item (yyvsp2)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 75 then
--|#line 621 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 621")
end

create yyval16.make; yyval16.put_last (yyvs17.item (yyvsp17)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp16 := yyvsp16 + 1
	yyvsp17 := yyvsp17 -1
	if yyvsp16 >= yyvsc16 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs16")
		end
		yyvsc16 := yyvsc16 + yyInitial_yyvs_size
		yyvs16 := yyspecial_routines16.aliased_resized_area (yyvs16, yyvsc16)
	end
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
when 76 then
--|#line 623 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 623")
end

yyval16 := yyvs16.item (yyvsp16); yyval16.put_last (yyvs17.item (yyvsp17)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp17 := yyvsp17 -1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
when 77 then
--|#line 629 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 629")
end

yyval17 := cl_attribute_asm 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp17 := yyvsp17 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp17 >= yyvsc17 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs17")
		end
		yyvsc17 := yyvsc17 + yyInitial_yyvs_size
		yyvs17 := yyspecial_routines17.aliased_resized_area (yyvs17, yyvsc17)
	end
	yyspecial_routines17.force (yyvs17, yyval17, yyvsp17)
end
when 78 then
--|#line 631 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 631")
end

yyval17 := cl_attribute_fastcall 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp17 := yyvsp17 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp17 >= yyvsc17 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs17")
		end
		yyvsc17 := yyvsc17 + yyInitial_yyvs_size
		yyvs17 := yyspecial_routines17.aliased_resized_area (yyvs17, yyvsc17)
	end
	yyspecial_routines17.force (yyvs17, yyval17, yyvsp17)
end
when 79 then
--|#line 633 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 633")
end

yyval17 := cl_attribute_based 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp17 := yyvsp17 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp17 >= yyvsc17 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs17")
		end
		yyvsc17 := yyvsc17 + yyInitial_yyvs_size
		yyvs17 := yyspecial_routines17.aliased_resized_area (yyvs17, yyvsc17)
	end
	yyspecial_routines17.force (yyvs17, yyval17, yyvsp17)
end
when 80 then
--|#line 635 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 635")
end

yyval17 := cl_attribute_inline 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp17 := yyvsp17 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp17 >= yyvsc17 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs17")
		end
		yyvsc17 := yyvsc17 + yyInitial_yyvs_size
		yyvs17 := yyspecial_routines17.aliased_resized_area (yyvs17, yyvsc17)
	end
	yyspecial_routines17.force (yyvs17, yyval17, yyvsp17)
end
when 81 then
--|#line 637 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 637")
end

yyval17 := cl_attribute_cdecl 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp17 := yyvsp17 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp17 >= yyvsc17 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs17")
		end
		yyvsc17 := yyvsc17 + yyInitial_yyvs_size
		yyvs17 := yyspecial_routines17.aliased_resized_area (yyvs17, yyvsc17)
	end
	yyspecial_routines17.force (yyvs17, yyval17, yyvsp17)
end
when 82 then
--|#line 639 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 639")
end

yyval17 := cl_attribute_stdcall 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp17 := yyvsp17 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp17 >= yyvsc17 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs17")
		end
		yyvsc17 := yyvsc17 + yyInitial_yyvs_size
		yyvs17 := yyspecial_routines17.aliased_resized_area (yyvs17, yyvsc17)
	end
	yyspecial_routines17.force (yyvs17, yyval17, yyvsp17)
end
when 83 then
--|#line 644 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 644")
end

			create yyval3.make (yyvs7.item (yyvsp7), new_declarator_list, last_header_file_name)
			add_top_level_declaration (yyval3)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp3 := yyvsp3 + 1
	yyvsp7 := yyvsp7 -1
	yyvsp1 := yyvsp1 -2
	if yyvsp3 >= yyvsc3 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs3")
		end
		yyvsc3 := yyvsc3 + yyInitial_yyvs_size
		yyvs3 := yyspecial_routines3.aliased_resized_area (yyvs3, yyvsc3)
	end
	yyspecial_routines3.force (yyvs3, yyval3, yyvsp3)
end
when 84 then
--|#line 649 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 649")
end

			update_type_names (yyvs7.item (yyvsp7), yyvs4.item (yyvsp4))
			create yyval3.make (yyvs7.item (yyvsp7), yyvs4.item (yyvsp4), last_header_file_name)
			add_top_level_declaration (yyval3)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp3 := yyvsp3 + 1
	yyvsp7 := yyvsp7 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -2
	if yyvsp3 >= yyvsc3 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs3")
		end
		yyvsc3 := yyvsc3 + yyInitial_yyvs_size
		yyvs3 := yyspecial_routines3.aliased_resized_area (yyvs3, yyvsc3)
	end
	yyspecial_routines3.force (yyvs3, yyval3, yyvsp3)
end
when 85 then
--|#line 658 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 658")
end

yyval7 := yyvs7.item (yyvsp7) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyspecial_routines7.force (yyvs7, yyval7, yyvsp7)
end
when 86 then
--|#line 660 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 660")
end

yyval7 := yyvs7.item (yyvsp7) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp16 := yyvsp16 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines7.force (yyvs7, yyval7, yyvsp7)
end
when 87 then
--|#line 668 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 668")
end

create yyval7.make; yyval7.put_last (yyvs11.item (yyvsp11)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp7 := yyvsp7 + 1
	yyvsp11 := yyvsp11 -1
	if yyvsp7 >= yyvsc7 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs7")
		end
		yyvsc7 := yyvsc7 + yyInitial_yyvs_size
		yyvs7 := yyspecial_routines7.aliased_resized_area (yyvs7, yyvsc7)
	end
	yyspecial_routines7.force (yyvs7, yyval7, yyvsp7)
end
when 88 then
--|#line 670 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 670")
end

yyval7 := yyvs7.item (yyvsp7); yyval7.put_first (yyvs11.item (yyvsp11)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp11 := yyvsp11 -1
	yyspecial_routines7.force (yyvs7, yyval7, yyvsp7)
end
when 89 then
--|#line 672 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 672")
end

create yyval7.make; yyval7.put_last (yyvs10.item (yyvsp10)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp7 := yyvsp7 + 1
	yyvsp10 := yyvsp10 -1
	if yyvsp7 >= yyvsc7 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs7")
		end
		yyvsc7 := yyvsc7 + yyInitial_yyvs_size
		yyvs7 := yyspecial_routines7.aliased_resized_area (yyvs7, yyvsc7)
	end
	yyspecial_routines7.force (yyvs7, yyval7, yyvsp7)
end
when 90 then
--|#line 674 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 674")
end

yyval7 := yyvs7.item (yyvsp7); yyval7.put_first (yyvs10.item (yyvsp10)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp10 := yyvsp10 -1
	yyspecial_routines7.force (yyvs7, yyval7, yyvsp7)
end
when 91 then
--|#line 676 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 676")
end

create yyval7.make; yyval7.put_last (yyvs9.item (yyvsp9)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp7 := yyvsp7 + 1
	yyvsp9 := yyvsp9 -1
	if yyvsp7 >= yyvsc7 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs7")
		end
		yyvsc7 := yyvsc7 + yyInitial_yyvs_size
		yyvs7 := yyspecial_routines7.aliased_resized_area (yyvs7, yyvsc7)
	end
	yyspecial_routines7.force (yyvs7, yyval7, yyvsp7)
end
when 92 then
--|#line 678 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 678")
end

yyval7 := yyvs7.item (yyvsp7); yyval7.put_first (yyvs9.item (yyvsp9)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp9 := yyvsp9 -1
	yyspecial_routines7.force (yyvs7, yyval7, yyvsp7)
end
when 93 then
--|#line 683 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 683")
end

create yyval4.make; yyval4.put_last (yyvs5.item (yyvsp5)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp4 := yyvsp4 + 1
	yyvsp5 := yyvsp5 -1
	if yyvsp4 >= yyvsc4 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs4")
		end
		yyvsc4 := yyvsc4 + yyInitial_yyvs_size
		yyvs4 := yyspecial_routines4.aliased_resized_area (yyvs4, yyvsc4)
	end
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 94 then
--|#line 685 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 685")
end

yyvs4.item (yyvsp4).put_last (yyvs5.item (yyvsp5)); yyval4 := yyvs4.item (yyvsp4) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp5 := yyvsp5 -1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 95 then
--|#line 690 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 690")
end

yyval5 := yyvs5.item (yyvsp5) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines5.force (yyvs5, yyval5, yyvsp5)
end
when 96 then
--|#line 692 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 692")
end

yyval5 := yyvs5.item (yyvsp5) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyspecial_routines5.force (yyvs5, yyval5, yyvsp5)
end
when 97 then
--|#line 697 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 697")
end

create yyval11.make; yyval11.set_typedef 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp11 := yyvsp11 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp11 >= yyvsc11 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs11")
		end
		yyvsc11 := yyvsc11 + yyInitial_yyvs_size
		yyvs11 := yyspecial_routines11.aliased_resized_area (yyvs11, yyvsc11)
	end
	yyspecial_routines11.force (yyvs11, yyval11, yyvsp11)
end
when 98 then
--|#line 699 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 699")
end

create yyval11.make; yyval11.set_extern 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp11 := yyvsp11 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp11 >= yyvsc11 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs11")
		end
		yyvsc11 := yyvsc11 + yyInitial_yyvs_size
		yyvs11 := yyspecial_routines11.aliased_resized_area (yyvs11, yyvsc11)
	end
	yyspecial_routines11.force (yyvs11, yyval11, yyvsp11)
end
when 99 then
--|#line 701 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 701")
end

create yyval11.make; yyval11.set_static 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp11 := yyvsp11 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp11 >= yyvsc11 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs11")
		end
		yyvsc11 := yyvsc11 + yyInitial_yyvs_size
		yyvs11 := yyspecial_routines11.aliased_resized_area (yyvs11, yyvsc11)
	end
	yyspecial_routines11.force (yyvs11, yyval11, yyvsp11)
end
when 100 then
--|#line 703 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 703")
end

create yyval11.make; yyval11.set_auto 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp11 := yyvsp11 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp11 >= yyvsc11 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs11")
		end
		yyvsc11 := yyvsc11 + yyInitial_yyvs_size
		yyvs11 := yyspecial_routines11.aliased_resized_area (yyvs11, yyvsc11)
	end
	yyspecial_routines11.force (yyvs11, yyval11, yyvsp11)
end
when 101 then
--|#line 705 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 705")
end

create yyval11.make; yyval11.set_register 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp11 := yyvsp11 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp11 >= yyvsc11 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs11")
		end
		yyvsc11 := yyvsc11 + yyInitial_yyvs_size
		yyvs11 := yyspecial_routines11.aliased_resized_area (yyvs11, yyvsc11)
	end
	yyspecial_routines11.force (yyvs11, yyval11, yyvsp11)
end
when 102 then
--|#line 707 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 707")
end

create yyval11.make; yyval11.set_inline 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp11 := yyvsp11 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp11 >= yyvsc11 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs11")
		end
		yyvsc11 := yyvsc11 + yyInitial_yyvs_size
		yyvs11 := yyspecial_routines11.aliased_resized_area (yyvs11, yyvsc11)
	end
	yyspecial_routines11.force (yyvs11, yyval11, yyvsp11)
end
when 103 then
--|#line 712 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 712")
end

yyval10 := yyvs10.item (yyvsp10) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyspecial_routines10.force (yyvs10, yyval10, yyvsp10)
end
when 104 then
--|#line 714 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 714")
end

yyval10 := yyvs10.item (yyvsp10) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyspecial_routines10.force (yyvs10, yyval10, yyvsp10)
end
when 105 then
--|#line 719 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 719")
end

create yyval10.make (yyvs2.item (yyvsp2)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp10 := yyvsp10 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp10 >= yyvsc10 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs10")
		end
		yyvsc10 := yyvsc10 + yyInitial_yyvs_size
		yyvs10 := yyspecial_routines10.aliased_resized_area (yyvs10, yyvsc10)
	end
	yyspecial_routines10.force (yyvs10, yyval10, yyvsp10)
end
when 106 then
--|#line 721 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 721")
end

create yyval10.make (yyvs2.item (yyvsp2)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp10 := yyvsp10 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp10 >= yyvsc10 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs10")
		end
		yyvsc10 := yyvsc10 + yyInitial_yyvs_size
		yyvs10 := yyspecial_routines10.aliased_resized_area (yyvs10, yyvsc10)
	end
	yyspecial_routines10.force (yyvs10, yyval10, yyvsp10)
end
when 107 then
--|#line 723 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 723")
end

create yyval10.make (yyvs2.item (yyvsp2)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp10 := yyvsp10 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp10 >= yyvsc10 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs10")
		end
		yyvsc10 := yyvsc10 + yyInitial_yyvs_size
		yyvs10 := yyspecial_routines10.aliased_resized_area (yyvs10, yyvsc10)
	end
	yyspecial_routines10.force (yyvs10, yyval10, yyvsp10)
end
when 108 then
--|#line 725 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 725")
end

create yyval10.make (yyvs2.item (yyvsp2)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp10 := yyvsp10 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp10 >= yyvsc10 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs10")
		end
		yyvsc10 := yyvsc10 + yyInitial_yyvs_size
		yyvs10 := yyspecial_routines10.aliased_resized_area (yyvs10, yyvsc10)
	end
	yyspecial_routines10.force (yyvs10, yyval10, yyvsp10)
end
when 109 then
--|#line 727 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 727")
end

create yyval10.make (yyvs2.item (yyvsp2)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp10 := yyvsp10 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp10 >= yyvsc10 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs10")
		end
		yyvsc10 := yyvsc10 + yyInitial_yyvs_size
		yyvs10 := yyspecial_routines10.aliased_resized_area (yyvs10, yyvsc10)
	end
	yyspecial_routines10.force (yyvs10, yyval10, yyvsp10)
end
when 110 then
--|#line 729 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 729")
end

create yyval10.make (yyvs2.item (yyvsp2)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp10 := yyvsp10 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp10 >= yyvsc10 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs10")
		end
		yyvsc10 := yyvsc10 + yyInitial_yyvs_size
		yyvs10 := yyspecial_routines10.aliased_resized_area (yyvs10, yyvsc10)
	end
	yyspecial_routines10.force (yyvs10, yyval10, yyvsp10)
end
when 111 then
--|#line 731 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 731")
end

create yyval10.make (yyvs2.item (yyvsp2)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp10 := yyvsp10 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp10 >= yyvsc10 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs10")
		end
		yyvsc10 := yyvsc10 + yyInitial_yyvs_size
		yyvs10 := yyspecial_routines10.aliased_resized_area (yyvs10, yyvsc10)
	end
	yyspecial_routines10.force (yyvs10, yyval10, yyvsp10)
end
when 112 then
--|#line 733 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 733")
end

create yyval10.make (yyvs2.item (yyvsp2)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp10 := yyvsp10 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp10 >= yyvsc10 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs10")
		end
		yyvsc10 := yyvsc10 + yyInitial_yyvs_size
		yyvs10 := yyspecial_routines10.aliased_resized_area (yyvs10, yyvsc10)
	end
	yyspecial_routines10.force (yyvs10, yyval10, yyvsp10)
end
when 113 then
--|#line 735 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 735")
end

create yyval10.make (yyvs2.item (yyvsp2)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp10 := yyvsp10 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp10 >= yyvsc10 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs10")
		end
		yyvsc10 := yyvsc10 + yyInitial_yyvs_size
		yyvs10 := yyspecial_routines10.aliased_resized_area (yyvs10, yyvsc10)
	end
	yyspecial_routines10.force (yyvs10, yyval10, yyvsp10)
end
when 114 then
--|#line 737 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 737")
end

create yyval10.make (yyvs2.item (yyvsp2)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp10 := yyvsp10 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp10 >= yyvsc10 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs10")
		end
		yyvsc10 := yyvsc10 + yyInitial_yyvs_size
		yyvs10 := yyspecial_routines10.aliased_resized_area (yyvs10, yyvsc10)
	end
	yyspecial_routines10.force (yyvs10, yyval10, yyvsp10)
end
when 115 then
--|#line 739 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 739")
end

create yyval10.make (yyvs2.item (yyvsp2)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp10 := yyvsp10 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp10 >= yyvsc10 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs10")
		end
		yyvsc10 := yyvsc10 + yyInitial_yyvs_size
		yyvs10 := yyspecial_routines10.aliased_resized_area (yyvs10, yyvsc10)
	end
	yyspecial_routines10.force (yyvs10, yyval10, yyvsp10)
end
when 116 then
--|#line 741 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 741")
end

create yyval10.make (yyvs2.item (yyvsp2)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp10 := yyvsp10 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp10 >= yyvsc10 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs10")
		end
		yyvsc10 := yyvsc10 + yyInitial_yyvs_size
		yyvs10 := yyspecial_routines10.aliased_resized_area (yyvs10, yyvsc10)
	end
	yyspecial_routines10.force (yyvs10, yyval10, yyvsp10)
end
when 117 then
--|#line 743 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 743")
end

create yyval10.make (yyvs2.item (yyvsp2)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp10 := yyvsp10 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp10 >= yyvsc10 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs10")
		end
		yyvsc10 := yyvsc10 + yyInitial_yyvs_size
		yyvs10 := yyspecial_routines10.aliased_resized_area (yyvs10, yyvsc10)
	end
	yyspecial_routines10.force (yyvs10, yyval10, yyvsp10)
end
when 118 then
--|#line 748 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 748")
end

yyval10 := yyvs10.item (yyvsp10) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines10.force (yyvs10, yyval10, yyvsp10)
end
when 119 then
--|#line 750 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 750")
end

yyval10 := yyvs10.item (yyvsp10) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines10.force (yyvs10, yyval10, yyvsp10)
end
when 120 then
--|#line 752 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 752")
end

create yyval10.make (yyvs2.item (yyvsp2)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp10 := yyvsp10 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp10 >= yyvsc10 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs10")
		end
		yyvsc10 := yyvsc10 + yyInitial_yyvs_size
		yyvs10 := yyspecial_routines10.aliased_resized_area (yyvs10, yyvsc10)
	end
	yyspecial_routines10.force (yyvs10, yyval10, yyvsp10)
end
when 121 then
--|#line 757 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 757")
end

if yyvs12.item (yyvsp12) then
			create yyval10.make_struct (yyvs2.item (yyvsp2), yyvs13.item (yyvsp13))
		  else
			create yyval10.make_union (yyvs2.item (yyvsp2), yyvs13.item (yyvsp13))
		  end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp10 := yyvsp10 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -4
	yyvsp13 := yyvsp13 -1
	if yyvsp10 >= yyvsc10 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs10")
		end
		yyvsc10 := yyvsc10 + yyInitial_yyvs_size
		yyvs10 := yyspecial_routines10.aliased_resized_area (yyvs10, yyvsc10)
	end
	yyspecial_routines10.force (yyvs10, yyval10, yyvsp10)
end
when 122 then
--|#line 764 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 764")
end

if yyvs12.item (yyvsp12) then
			create yyval10.make_struct (Void, yyvs13.item (yyvsp13))
		  else
			create yyval10.make_union (Void, yyvs13.item (yyvsp13))
		  end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp10 := yyvsp10 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp1 := yyvsp1 -4
	yyvsp13 := yyvsp13 -1
	if yyvsp10 >= yyvsc10 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs10")
		end
		yyvsc10 := yyvsc10 + yyInitial_yyvs_size
		yyvs10 := yyspecial_routines10.aliased_resized_area (yyvs10, yyvsc10)
	end
	yyspecial_routines10.force (yyvs10, yyval10, yyvsp10)
end
when 123 then
--|#line 771 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 771")
end

if yyvs12.item (yyvsp12) then
			create yyval10.make_struct (yyvs2.item (yyvsp2), Void)
		  else
			create yyval10.make_union (yyvs2.item (yyvsp2), Void)
		  end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp10 := yyvsp10 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp2 := yyvsp2 -1
	if yyvsp10 >= yyvsc10 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs10")
		end
		yyvsc10 := yyvsc10 + yyInitial_yyvs_size
		yyvs10 := yyspecial_routines10.aliased_resized_area (yyvs10, yyvsc10)
	end
	yyspecial_routines10.force (yyvs10, yyval10, yyvsp10)
end
when 124 then
--|#line 778 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 778")
end

if yyvs12.item (yyvsp12) then
			create yyval10.make_struct (yyvs2.item (yyvsp2), Void)
		  else
			create yyval10.make_union (yyvs2.item (yyvsp2), Void)
		  end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp10 := yyvsp10 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp2 := yyvsp2 -1
	if yyvsp10 >= yyvsc10 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs10")
		end
		yyvsc10 := yyvsc10 + yyInitial_yyvs_size
		yyvs10 := yyspecial_routines10.aliased_resized_area (yyvs10, yyvsc10)
	end
	yyspecial_routines10.force (yyvs10, yyval10, yyvsp10)
end
when 125 then
--|#line 788 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 788")
end

yyval12 := True 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp12 := yyvsp12 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp12 >= yyvsc12 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs12")
		end
		yyvsc12 := yyvsc12 + yyInitial_yyvs_size
		yyvs12 := yyspecial_routines12.aliased_resized_area (yyvs12, yyvsc12)
	end
	yyspecial_routines12.force (yyvs12, yyval12, yyvsp12)
end
when 126 then
--|#line 790 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 790")
end

yyval12 := False 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp12 := yyvsp12 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp12 >= yyvsc12 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs12")
		end
		yyvsc12 := yyvsc12 + yyInitial_yyvs_size
		yyvs12 := yyspecial_routines12.aliased_resized_area (yyvs12, yyvsc12)
	end
	yyspecial_routines12.force (yyvs12, yyval12, yyvsp12)
end
when 127 then
--|#line 795 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 795")
end

create yyval13.make; yyval13.put_last (yyvs3.item (yyvsp3)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp13 := yyvsp13 + 1
	yyvsp3 := yyvsp3 -1
	if yyvsp13 >= yyvsc13 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs13")
		end
		yyvsc13 := yyvsc13 + yyInitial_yyvs_size
		yyvs13 := yyspecial_routines13.aliased_resized_area (yyvs13, yyvsc13)
	end
	yyspecial_routines13.force (yyvs13, yyval13, yyvsp13)
end
when 128 then
--|#line 797 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 797")
end

yyvs13.item (yyvsp13).put_last (yyvs3.item (yyvsp3)); yyval13 := yyvs13.item (yyvsp13) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp3 := yyvsp3 -1
	yyspecial_routines13.force (yyvs13, yyval13, yyvsp13)
end
when 129 then
--|#line 802 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 802")
end

create yyval3.make (yyvs7.item (yyvsp7), yyvs4.item (yyvsp4), last_header_file_name) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp3 := yyvsp3 + 1
	yyvsp7 := yyvsp7 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -2
	if yyvsp3 >= yyvsc3 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs3")
		end
		yyvsc3 := yyvsc3 + yyInitial_yyvs_size
		yyvs3 := yyspecial_routines3.aliased_resized_area (yyvs3, yyvsc3)
	end
	yyspecial_routines3.force (yyvs3, yyval3, yyvsp3)
end
when 130 then
--|#line 804 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 804")
end

create yyval3.make_without_declarator (yyvs7.item (yyvsp7), last_header_file_name) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp3 := yyvsp3 + 1
	yyvsp7 := yyvsp7 -1
	yyvsp1 := yyvsp1 -2
	if yyvsp3 >= yyvsc3 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs3")
		end
		yyvsc3 := yyvsc3 + yyInitial_yyvs_size
		yyvs3 := yyspecial_routines3.aliased_resized_area (yyvs3, yyvsc3)
	end
	yyspecial_routines3.force (yyvs3, yyval3, yyvsp3)
end
when 131 then
--|#line 814 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 814")
end

yyval7 := yyvs7.item (yyvsp7) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyspecial_routines7.force (yyvs7, yyval7, yyvsp7)
end
when 132 then
--|#line 818 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 818")
end

yyval7 := yyvs7.item (yyvsp7); yyval7.put_first (yyvs10.item (yyvsp10)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp10 := yyvsp10 -1
	yyspecial_routines7.force (yyvs7, yyval7, yyvsp7)
end
when 133 then
--|#line 820 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 820")
end

create yyval7.make; yyval7.put_last (yyvs10.item (yyvsp10)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp7 := yyvsp7 + 1
	yyvsp10 := yyvsp10 -1
	if yyvsp7 >= yyvsc7 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs7")
		end
		yyvsc7 := yyvsc7 + yyInitial_yyvs_size
		yyvs7 := yyspecial_routines7.aliased_resized_area (yyvs7, yyvsc7)
	end
	yyspecial_routines7.force (yyvs7, yyval7, yyvsp7)
end
when 134 then
--|#line 822 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 822")
end

yyval7 := yyvs7.item (yyvsp7); yyval7.put_first (yyvs9.item (yyvsp9)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp9 := yyvsp9 -1
	yyspecial_routines7.force (yyvs7, yyval7, yyvsp7)
end
when 135 then
--|#line 824 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 824")
end

create yyval7.make; yyval7.put_last (yyvs9.item (yyvsp9)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp7 := yyvsp7 + 1
	yyvsp9 := yyvsp9 -1
	if yyvsp7 >= yyvsc7 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs7")
		end
		yyvsc7 := yyvsc7 + yyInitial_yyvs_size
		yyvs7 := yyspecial_routines7.aliased_resized_area (yyvs7, yyvsc7)
	end
	yyspecial_routines7.force (yyvs7, yyval7, yyvsp7)
end
when 136 then
--|#line 831 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 831")
end

			create yyval4.make
			if yyvs5.item (yyvsp5) /= Void then
				yyval4.put_last (yyvs5.item (yyvsp5))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp4 := yyvsp4 + 1
	yyvsp5 := yyvsp5 -1
	if yyvsp4 >= yyvsc4 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs4")
		end
		yyvsc4 := yyvsc4 + yyInitial_yyvs_size
		yyvs4 := yyspecial_routines4.aliased_resized_area (yyvs4, yyvsc4)
	end
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 137 then
--|#line 838 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 838")
end

			yyval4 := yyvs4.item (yyvsp4)
			if yyvs5.item (yyvsp5) /= Void then
				yyvs4.item (yyvsp4).put_last (yyvs5.item (yyvsp5))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp5 := yyvsp5 -1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 138 then
--|#line 848 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 848")
end

yyval5 := yyvs5.item (yyvsp5) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines5.force (yyvs5, yyval5, yyvsp5)
end
when 139 then
--|#line 850 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 850")
end

create yyval5.make_default
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp5 := yyvsp5 + 1
	yyvsp1 := yyvsp1 -1
	yyvsp2 := yyvsp2 -1
	if yyvsp5 >= yyvsc5 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs5")
		end
		yyvsc5 := yyvsc5 + yyInitial_yyvs_size
		yyvs5 := yyspecial_routines5.aliased_resized_area (yyvs5, yyvsc5)
	end
	yyspecial_routines5.force (yyvs5, yyval5, yyvsp5)
end
when 140 then
--|#line 856 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 856")
end

yyval5 := yyvs5.item (yyvsp5) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp2 := yyvsp2 -1
	yyspecial_routines5.force (yyvs5, yyval5, yyvsp5)
end
when 141 then
--|#line 861 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 861")
end

create yyval10.make_enum (Void, yyvs13.item (yyvsp13)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp10 := yyvsp10 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -2
	yyvsp13 := yyvsp13 -1
	if yyvsp10 >= yyvsc10 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs10")
		end
		yyvsc10 := yyvsc10 + yyInitial_yyvs_size
		yyvs10 := yyspecial_routines10.aliased_resized_area (yyvs10, yyvsc10)
	end
	yyspecial_routines10.force (yyvs10, yyval10, yyvsp10)
end
when 142 then
--|#line 863 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 863")
end

create yyval10.make_enum (yyvs2.item (yyvsp2), yyvs13.item (yyvsp13)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp10 := yyvsp10 + 1
	yyvsp2 := yyvsp2 -2
	yyvsp1 := yyvsp1 -2
	yyvsp13 := yyvsp13 -1
	if yyvsp10 >= yyvsc10 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs10")
		end
		yyvsc10 := yyvsc10 + yyInitial_yyvs_size
		yyvs10 := yyspecial_routines10.aliased_resized_area (yyvs10, yyvsc10)
	end
	yyspecial_routines10.force (yyvs10, yyval10, yyvsp10)
end
when 143 then
--|#line 865 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 865")
end

create yyval10.make_enum (yyvs2.item (yyvsp2), Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp10 := yyvsp10 + 1
	yyvsp2 := yyvsp2 -2
	if yyvsp10 >= yyvsc10 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs10")
		end
		yyvsc10 := yyvsc10 + yyInitial_yyvs_size
		yyvs10 := yyspecial_routines10.aliased_resized_area (yyvs10, yyvsc10)
	end
	yyspecial_routines10.force (yyvs10, yyval10, yyvsp10)
end
when 144 then
--|#line 872 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 872")
end

yyval13 := yyvs13.item (yyvsp13) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyspecial_routines13.force (yyvs13, yyval13, yyvsp13)
end
when 145 then
--|#line 877 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 877")
end

create yyval13.make; yyval13.put_last (yyvs3.item (yyvsp3)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp13 := yyvsp13 + 1
	yyvsp3 := yyvsp3 -1
	if yyvsp13 >= yyvsc13 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs13")
		end
		yyvsc13 := yyvsc13 + yyInitial_yyvs_size
		yyvs13 := yyspecial_routines13.aliased_resized_area (yyvs13, yyvsc13)
	end
	yyspecial_routines13.force (yyvs13, yyval13, yyvsp13)
end
when 146 then
--|#line 879 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 879")
end

yyvs13.item (yyvsp13).put_last (yyvs3.item (yyvsp3)); yyval13 := yyvs13.item (yyvsp13) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp3 := yyvsp3 -1
	yyspecial_routines13.force (yyvs13, yyval13, yyvsp13)
end
when 147 then
--|#line 884 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 884")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp1 := yyvsp1 + 1
	if yyvsp1 >= yyvsc1 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs1")
		end
		yyvsc1 := yyvsc1 + yyInitial_yyvs_size
		yyvs1 := yyspecial_routines1.aliased_resized_area (yyvs1, yyvsc1)
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 148 then
--|#line 885 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 885")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 149 then
--|#line 889 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 889")
end

yyval3 := new_enum_declaration (yyvs2.item (yyvsp2), last_header_file_name) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp3 := yyvsp3 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp3 >= yyvsc3 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs3")
		end
		yyvsc3 := yyvsc3 + yyInitial_yyvs_size
		yyvs3 := yyspecial_routines3.aliased_resized_area (yyvs3, yyvsc3)
	end
	yyspecial_routines3.force (yyvs3, yyval3, yyvsp3)
end
when 150 then
--|#line 891 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 891")
end

yyval3 := new_enum_declaration (yyvs2.item (yyvsp2 - 1), last_header_file_name) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp3 := yyvsp3 + 1
	yyvsp2 := yyvsp2 -2
	yyvsp1 := yyvsp1 -1
	if yyvsp3 >= yyvsc3 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs3")
		end
		yyvsc3 := yyvsc3 + yyInitial_yyvs_size
		yyvs3 := yyspecial_routines3.aliased_resized_area (yyvs3, yyvsc3)
	end
	yyspecial_routines3.force (yyvs3, yyval3, yyvsp3)
end
when 151 then
--|#line 896 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 896")
end

create yyval9.make; yyval9.set_const 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp9 := yyvsp9 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp9 >= yyvsc9 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs9")
		end
		yyvsc9 := yyvsc9 + yyInitial_yyvs_size
		yyvs9 := yyspecial_routines9.aliased_resized_area (yyvs9, yyvsc9)
	end
	yyspecial_routines9.force (yyvs9, yyval9, yyvsp9)
end
when 152 then
--|#line 898 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 898")
end

create yyval9.make; yyval9.set_volatile 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp9 := yyvsp9 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp9 >= yyvsc9 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs9")
		end
		yyvsc9 := yyvsc9 + yyInitial_yyvs_size
		yyvs9 := yyspecial_routines9.aliased_resized_area (yyvs9, yyvsc9)
	end
	yyspecial_routines9.force (yyvs9, yyval9, yyvsp9)
end
when 153 then
--|#line 903 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 903")
end

create yyval5.make_with_pointers (yyvs6.item (yyvsp6), yyvs14.item (yyvsp14), last_header_file_name)
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp5 := yyvsp5 + 1
	yyvsp14 := yyvsp14 -1
	yyvsp6 := yyvsp6 -1
	if yyvsp5 >= yyvsc5 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs5")
		end
		yyvsc5 := yyvsc5 + yyInitial_yyvs_size
		yyvs5 := yyspecial_routines5.aliased_resized_area (yyvs5, yyvsc5)
	end
	yyspecial_routines5.force (yyvs5, yyval5, yyvsp5)
end
when 154 then
--|#line 905 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 905")
end

create yyval5.make (yyvs6.item (yyvsp6), last_header_file_name)
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp5 := yyvsp5 + 1
	yyvsp6 := yyvsp6 -1
	if yyvsp5 >= yyvsc5 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs5")
		end
		yyvsc5 := yyvsc5 + yyInitial_yyvs_size
		yyvs5 := yyspecial_routines5.aliased_resized_area (yyvs5, yyvsc5)
	end
	yyspecial_routines5.force (yyvs5, yyval5, yyvsp5)
end
when 155 then
--|#line 907 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 907")
end

			create yyval5.make_with_pointers (yyvs6.item (yyvsp6), yyvs14.item (yyvsp14), last_header_file_name)
			yyval5.direct_declarator.set_calling_convention_from_attribute_sequence (yyvs16.item (yyvsp16))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp5 := yyvsp5 + 1
	yyvsp14 := yyvsp14 -1
	yyvsp16 := yyvsp16 -1
	yyvsp6 := yyvsp6 -1
	if yyvsp5 >= yyvsc5 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs5")
		end
		yyvsc5 := yyvsc5 + yyInitial_yyvs_size
		yyvs5 := yyspecial_routines5.aliased_resized_area (yyvs5, yyvsc5)
	end
	yyspecial_routines5.force (yyvs5, yyval5, yyvsp5)
end
when 156 then
--|#line 913 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 913")
end

		  create yyval5.make_with_pointers (yyvs6.item (yyvsp6), yyvs14.item (yyvsp14), last_header_file_name)
		  yyval5.direct_declarator.set_calling_convention_from_attribute_sequence (yyvs16.item (yyvsp16))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp5 := yyvsp5 + 1
	yyvsp16 := yyvsp16 -1
	yyvsp14 := yyvsp14 -1
	yyvsp6 := yyvsp6 -1
	if yyvsp5 >= yyvsc5 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs5")
		end
		yyvsc5 := yyvsc5 + yyInitial_yyvs_size
		yyvs5 := yyspecial_routines5.aliased_resized_area (yyvs5, yyvsc5)
	end
	yyspecial_routines5.force (yyvs5, yyval5, yyvsp5)
end
when 157 then
--|#line 919 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 919")
end

			create yyval5.make (yyvs6.item (yyvsp6), last_header_file_name)
			yyval5.direct_declarator.set_calling_convention_from_attribute_sequence (yyvs16.item (yyvsp16))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp5 := yyvsp5 + 1
	yyvsp16 := yyvsp16 -1
	yyvsp6 := yyvsp6 -1
	if yyvsp5 >= yyvsc5 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs5")
		end
		yyvsc5 := yyvsc5 + yyInitial_yyvs_size
		yyvs5 := yyspecial_routines5.aliased_resized_area (yyvs5, yyvsc5)
	end
	yyspecial_routines5.force (yyvs5, yyval5, yyvsp5)
end
when 158 then
--|#line 928 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 928")
end

create yyval6.make (yyvs2.item (yyvsp2))
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp6 := yyvsp6 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp6 >= yyvsc6 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs6")
		end
		yyvsc6 := yyvsc6 + yyInitial_yyvs_size
		yyvs6 := yyspecial_routines6.aliased_resized_area (yyvs6, yyvsc6)
	end
	yyspecial_routines6.force (yyvs6, yyval6, yyvsp6)
end
when 159 then
--|#line 930 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 930")
end

create yyval6.make_anonymous (yyvs5.item (yyvsp5)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp6 := yyvsp6 + 1
	yyvsp1 := yyvsp1 -2
	yyvsp5 := yyvsp5 -1
	if yyvsp6 >= yyvsc6 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs6")
		end
		yyvsc6 := yyvsc6 + yyInitial_yyvs_size
		yyvs6 := yyspecial_routines6.aliased_resized_area (yyvs6, yyvsc6)
	end
	yyspecial_routines6.force (yyvs6, yyval6, yyvsp6)
end
when 160 then
--|#line 932 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 932")
end

yyval6 := yyvs6.item (yyvsp6); yyval6.add_array_last (new_array_with_size (yyvs2.item (yyvsp2))); 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp1 := yyvsp1 -4
	yyvsp2 := yyvsp2 -1
	yyspecial_routines6.force (yyvs6, yyval6, yyvsp6)
end
when 161 then
--|#line 936 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 936")
end

yyval6 := yyvs6.item (yyvsp6); yyval6.add_array_last (new_array) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp1 := yyvsp1 -4
	yyspecial_routines6.force (yyvs6, yyval6, yyvsp6)
end
when 162 then
--|#line 938 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 938")
end

yyval6 := yyvs6.item (yyvsp6); yyval6.set_parameters (yyvs15.item (yyvsp15)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp1 := yyvsp1 -4
	yyvsp15 := yyvsp15 -1
	yyspecial_routines6.force (yyvs6, yyval6, yyvsp6)
end
when 163 then
--|#line 940 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 940")
end

yyval6 := yyvs6.item (yyvsp6); yyval6.set_parameters (new_empty_elipsis_parameter_type_list) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp1 := yyvsp1 -5
	yyspecial_routines6.force (yyvs6, yyval6, yyvsp6)
end
when 164 then
--|#line 942 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 942")
end

yyval6 := yyvs6.item (yyvsp6); yyval6.set_parameters (new_empty_elipsis_parameter_type_list) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp1 := yyvsp1 -4
	yyspecial_routines6.force (yyvs6, yyval6, yyvsp6)
end
when 165 then
--|#line 947 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 947")
end

create yyval14.make; yyval14.put_last (new_pointer) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp14 := yyvsp14 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp14 >= yyvsc14 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs14")
		end
		yyvsc14 := yyvsc14 + yyInitial_yyvs_size
		yyvs14 := yyspecial_routines14.aliased_resized_area (yyvs14, yyvsc14)
	end
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
when 166 then
--|#line 949 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 949")
end

create yyval14.make; yyval14.put_last (new_pointer_with_type_qualifier_list (yyvs8.item (yyvsp8))) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp14 := yyvsp14 + 1
	yyvsp1 := yyvsp1 -1
	yyvsp8 := yyvsp8 -1
	if yyvsp14 >= yyvsc14 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs14")
		end
		yyvsc14 := yyvsc14 + yyInitial_yyvs_size
		yyvs14 := yyspecial_routines14.aliased_resized_area (yyvs14, yyvsc14)
	end
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
when 167 then
--|#line 951 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 951")
end

yyval14 := yyvs14.item (yyvsp14); yyval14.put_first (new_pointer) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
when 168 then
--|#line 953 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 953")
end

yyval14 := yyvs14.item (yyvsp14); yyval14.put_first (new_pointer_with_type_qualifier_list (yyvs8.item (yyvsp8))) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp8 := yyvsp8 -1
	yyspecial_routines14.force (yyvs14, yyval14, yyvsp14)
end
when 169 then
--|#line 958 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 958")
end

create yyval8.make; yyval8.put_last (yyvs9.item (yyvsp9)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp8 := yyvsp8 + 1
	yyvsp9 := yyvsp9 -1
	if yyvsp8 >= yyvsc8 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs8")
		end
		yyvsc8 := yyvsc8 + yyInitial_yyvs_size
		yyvs8 := yyspecial_routines8.aliased_resized_area (yyvs8, yyvsc8)
	end
	yyspecial_routines8.force (yyvs8, yyval8, yyvsp8)
end
when 170 then
--|#line 960 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 960")
end

yyval8 := yyvs8.item (yyvsp8); yyval8.put_last (yyvs9.item (yyvsp9)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp9 := yyvsp9 -1
	yyspecial_routines8.force (yyvs8, yyval8, yyvsp8)
end
when 171 then
--|#line 965 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 965")
end

create yyval15.make (yyvs13.item (yyvsp13)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp15 := yyvsp15 + 1
	yyvsp13 := yyvsp13 -1
	if yyvsp15 >= yyvsc15 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs15")
		end
		yyvsc15 := yyvsc15 + yyInitial_yyvs_size
		yyvs15 := yyspecial_routines15.aliased_resized_area (yyvs15, yyvsc15)
	end
	yyspecial_routines15.force (yyvs15, yyval15, yyvsp15)
end
when 172 then
--|#line 967 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 967")
end

create yyval15.make_with_ellipsis (yyvs13.item (yyvsp13)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp15 := yyvsp15 + 1
	yyvsp13 := yyvsp13 -1
	yyvsp1 := yyvsp1 -1
	yyvsp2 := yyvsp2 -1
	if yyvsp15 >= yyvsc15 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs15")
		end
		yyvsc15 := yyvsc15 + yyInitial_yyvs_size
		yyvs15 := yyspecial_routines15.aliased_resized_area (yyvs15, yyvsc15)
	end
	yyspecial_routines15.force (yyvs15, yyval15, yyvsp15)
end
when 173 then
--|#line 972 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 972")
end

			create yyval13.make
			check
				every_parameter_has_exactly_one_name: yyvs3.item (yyvsp3).declarators.count = 1 or
										(attached yyvs3.item (yyvsp3).type_specifier as l_type_specifier and then  l_type_specifier.is_void)
			end
			yyval13.put_last (yyvs3.item (yyvsp3))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp13 := yyvsp13 + 1
	yyvsp3 := yyvsp3 -1
	if yyvsp13 >= yyvsc13 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs13")
		end
		yyvsc13 := yyvsc13 + yyInitial_yyvs_size
		yyvs13 := yyspecial_routines13.aliased_resized_area (yyvs13, yyvsc13)
	end
	yyspecial_routines13.force (yyvs13, yyval13, yyvsp13)
end
when 174 then
--|#line 981 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 981")
end

			yyval13 := yyvs13.item (yyvsp13)
			check
				every_parameter_has_exactly_one_name: yyvs3.item (yyvsp3).declarators.count = 1
			end
			yyval13.put_last (yyvs3.item (yyvsp3))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp3 := yyvsp3 -1
	yyspecial_routines13.force (yyvs13, yyval13, yyvsp13)
end
when 175 then
--|#line 992 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 992")
end

create yyval3.make_with_one_declarator (yyvs7.item (yyvsp7), yyvs5.item (yyvsp5), last_header_file_name) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp3 := yyvsp3 + 1
	yyvsp7 := yyvsp7 -1
	yyvsp5 := yyvsp5 -1
	yyvsp1 := yyvsp1 -1
	if yyvsp3 >= yyvsc3 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs3")
		end
		yyvsc3 := yyvsc3 + yyInitial_yyvs_size
		yyvs3 := yyspecial_routines3.aliased_resized_area (yyvs3, yyvsc3)
	end
	yyspecial_routines3.force (yyvs3, yyval3, yyvsp3)
end
when 176 then
--|#line 994 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 994")
end

create yyval3.make_with_one_declarator (yyvs7.item (yyvsp7), yyvs5.item (yyvsp5), last_header_file_name) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp3 := yyvsp3 + 1
	yyvsp7 := yyvsp7 -1
	yyvsp5 := yyvsp5 -1
	yyvsp1 := yyvsp1 -1
	if yyvsp3 >= yyvsc3 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs3")
		end
		yyvsc3 := yyvsc3 + yyInitial_yyvs_size
		yyvs3 := yyspecial_routines3.aliased_resized_area (yyvs3, yyvsc3)
	end
	yyspecial_routines3.force (yyvs3, yyval3, yyvsp3)
end
when 177 then
--|#line 996 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 996")
end

create yyval3.make_with_one_declarator (yyvs7.item (yyvsp7), new_abstract_declarator (last_header_file_name), last_header_file_name) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp3 := yyvsp3 + 1
	yyvsp7 := yyvsp7 -1
	yyvsp1 := yyvsp1 -1
	if yyvsp3 >= yyvsc3 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs3")
		end
		yyvsc3 := yyvsc3 + yyInitial_yyvs_size
		yyvs3 := yyspecial_routines3.aliased_resized_area (yyvs3, yyvsc3)
	end
	yyspecial_routines3.force (yyvs3, yyval3, yyvsp3)
end
when 178 then
--|#line 1001 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 1001")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp1 := yyvsp1 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp1 >= yyvsc1 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs1")
		end
		yyvsc1 := yyvsc1 + yyInitial_yyvs_size
		yyvs1 := yyspecial_routines1.aliased_resized_area (yyvs1, yyvsc1)
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 179 then
--|#line 1002 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 1002")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp2 := yyvsp2 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 180 then
--|#line 1006 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 1006")
end

			yyval2 := c_code_from_specifier_qualifier_list (yyvs7.item (yyvsp7))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp2 := yyvsp2 + 1
	yyvsp7 := yyvsp7 -1
	if yyvsp2 >= yyvsc2 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs2")
		end
		yyvsc2 := yyvsc2 + yyInitial_yyvs_size
		yyvs2 := yyspecial_routines2.aliased_resized_area (yyvs2, yyvsc2)
	end
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 181 then
--|#line 1010 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 1010")
end

			yyval2 := c_code_from_specifier_qualifier_list (yyvs7.item (yyvsp7))
			yyval2.append_string (yyvs5.item (yyvsp5).c_code)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp2 := yyvsp2 + 1
	yyvsp7 := yyvsp7 -1
	yyvsp5 := yyvsp5 -1
	if yyvsp2 >= yyvsc2 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs2")
		end
		yyvsc2 := yyvsc2 + yyInitial_yyvs_size
		yyvs2 := yyspecial_routines2.aliased_resized_area (yyvs2, yyvsc2)
	end
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 182 then
--|#line 1019 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 1019")
end

			create yyval5.make_with_pointers (new_direct_abstract_declarator,
							yyvs14.item (yyvsp14), last_header_file_name)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp5 := yyvsp5 + 1
	yyvsp14 := yyvsp14 -1
	if yyvsp5 >= yyvsc5 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs5")
		end
		yyvsc5 := yyvsc5 + yyInitial_yyvs_size
		yyvs5 := yyspecial_routines5.aliased_resized_area (yyvs5, yyvsc5)
	end
	yyspecial_routines5.force (yyvs5, yyval5, yyvsp5)
end
when 183 then
--|#line 1024 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 1024")
end

			create yyval5.make (yyvs6.item (yyvsp6), last_header_file_name)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp5 := yyvsp5 + 1
	yyvsp6 := yyvsp6 -1
	if yyvsp5 >= yyvsc5 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs5")
		end
		yyvsc5 := yyvsc5 + yyInitial_yyvs_size
		yyvs5 := yyspecial_routines5.aliased_resized_area (yyvs5, yyvsc5)
	end
	yyspecial_routines5.force (yyvs5, yyval5, yyvsp5)
end
when 184 then
--|#line 1028 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 1028")
end

			create yyval5.make_with_pointers (yyvs6.item (yyvsp6), yyvs14.item (yyvsp14), last_header_file_name)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp5 := yyvsp5 + 1
	yyvsp14 := yyvsp14 -1
	yyvsp6 := yyvsp6 -1
	if yyvsp5 >= yyvsc5 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs5")
		end
		yyvsc5 := yyvsc5 + yyInitial_yyvs_size
		yyvs5 := yyspecial_routines5.aliased_resized_area (yyvs5, yyvsc5)
	end
	yyspecial_routines5.force (yyvs5, yyval5, yyvsp5)
end
when 185 then
--|#line 1032 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 1032")
end

			create yyval5.make_with_pointers (yyvs6.item (yyvsp6), yyvs14.item (yyvsp14), last_header_file_name)
			yyvs6.item (yyvsp6).set_calling_convention_from_attribute_sequence (yyvs16.item (yyvsp16))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp5 := yyvsp5 + 1
	yyvsp14 := yyvsp14 -1
	yyvsp16 := yyvsp16 -1
	yyvsp6 := yyvsp6 -1
	if yyvsp5 >= yyvsc5 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs5")
		end
		yyvsc5 := yyvsc5 + yyInitial_yyvs_size
		yyvs5 := yyspecial_routines5.aliased_resized_area (yyvs5, yyvsc5)
	end
	yyspecial_routines5.force (yyvs5, yyval5, yyvsp5)
end
when 186 then
--|#line 1038 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 1038")
end

			create yyval5.make_with_pointers (yyvs6.item (yyvsp6), yyvs14.item (yyvsp14), last_header_file_name)
			yyvs6.item (yyvsp6).set_calling_convention_from_attribute_sequence (yyvs16.item (yyvsp16))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp5 := yyvsp5 + 1
	yyvsp16 := yyvsp16 -1
	yyvsp14 := yyvsp14 -1
	yyvsp6 := yyvsp6 -1
	if yyvsp5 >= yyvsc5 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs5")
		end
		yyvsc5 := yyvsc5 + yyInitial_yyvs_size
		yyvs5 := yyspecial_routines5.aliased_resized_area (yyvs5, yyvsc5)
	end
	yyspecial_routines5.force (yyvs5, yyval5, yyvsp5)
end
when 187 then
--|#line 1044 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 1044")
end

			create yyval5.make (yyvs6.item (yyvsp6), last_header_file_name)
			yyvs6.item (yyvsp6).set_calling_convention_from_attribute_sequence (yyvs16.item (yyvsp16))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp5 := yyvsp5 + 1
	yyvsp16 := yyvsp16 -1
	yyvsp6 := yyvsp6 -1
	if yyvsp5 >= yyvsc5 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs5")
		end
		yyvsc5 := yyvsc5 + yyInitial_yyvs_size
		yyvs5 := yyspecial_routines5.aliased_resized_area (yyvs5, yyvsc5)
	end
	yyspecial_routines5.force (yyvs5, yyval5, yyvsp5)
end
when 188 then
--|#line 1050 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 1050")
end

			create yyval5.make_with_pointers (new_direct_abstract_declarator,
								 yyvs14.item (yyvsp14), last_header_file_name)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp5 := yyvsp5 + 1
	yyvsp16 := yyvsp16 -1
	yyvsp14 := yyvsp14 -1
	if yyvsp5 >= yyvsc5 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs5")
		end
		yyvsc5 := yyvsc5 + yyInitial_yyvs_size
		yyvs5 := yyspecial_routines5.aliased_resized_area (yyvs5, yyvsc5)
	end
	yyspecial_routines5.force (yyvs5, yyval5, yyvsp5)
end
when 189 then
--|#line 1059 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 1059")
end

			create yyval6.make_anonymous (yyvs5.item (yyvsp5))
			check
				is_abstract: yyval6.is_abstract
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp6 := yyvsp6 + 1
	yyvsp1 := yyvsp1 -2
	yyvsp5 := yyvsp5 -1
	if yyvsp6 >= yyvsc6 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs6")
		end
		yyvsc6 := yyvsc6 + yyInitial_yyvs_size
		yyvs6 := yyspecial_routines6.aliased_resized_area (yyvs6, yyvsc6)
	end
	yyspecial_routines6.force (yyvs6, yyval6, yyvsp6)
end
when 190 then
--|#line 1066 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 1066")
end

			create yyval6.make_abstract
			yyval6.add_array_last (new_array)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp6 := yyvsp6 + 1
	yyvsp1 := yyvsp1 -4
	if yyvsp6 >= yyvsc6 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs6")
		end
		yyvsc6 := yyvsc6 + yyInitial_yyvs_size
		yyvs6 := yyspecial_routines6.aliased_resized_area (yyvs6, yyvsc6)
	end
	yyspecial_routines6.force (yyvs6, yyval6, yyvsp6)
end
when 191 then
--|#line 1071 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 1071")
end

			create yyval6.make_abstract
			yyval6.add_array_last (new_array_with_size (yyvs2.item (yyvsp2)))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp6 := yyvsp6 + 1
	yyvsp1 := yyvsp1 -4
	yyvsp2 := yyvsp2 -1
	if yyvsp6 >= yyvsc6 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs6")
		end
		yyvsc6 := yyvsc6 + yyInitial_yyvs_size
		yyvs6 := yyspecial_routines6.aliased_resized_area (yyvs6, yyvsc6)
	end
	yyspecial_routines6.force (yyvs6, yyval6, yyvsp6)
end
when 192 then
--|#line 1078 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 1078")
end

			yyval6 := yyvs6.item (yyvsp6)
			yyval6.add_array_last (new_array)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp1 := yyvsp1 -4
	yyspecial_routines6.force (yyvs6, yyval6, yyvsp6)
end
when 193 then
--|#line 1083 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 1083")
end

			yyval6 := yyvs6.item (yyvsp6)
			yyval6.add_array_last (new_array_with_size (yyvs2.item (yyvsp2)))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp1 := yyvsp1 -4
	yyvsp2 := yyvsp2 -1
	yyspecial_routines6.force (yyvs6, yyval6, yyvsp6)
end
when 194 then
--|#line 1088 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 1088")
end

			create yyval6.make_abstract
			yyval6.set_parameters (new_empty_elipsis_parameter_type_list)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp6 := yyvsp6 + 1
	yyvsp1 := yyvsp1 -2
	if yyvsp6 >= yyvsc6 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs6")
		end
		yyvsc6 := yyvsc6 + yyInitial_yyvs_size
		yyvs6 := yyspecial_routines6.aliased_resized_area (yyvs6, yyvsc6)
	end
	yyspecial_routines6.force (yyvs6, yyval6, yyvsp6)
end
when 195 then
--|#line 1093 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 1093")
end

			create yyval6.make_abstract
			yyval6.set_parameters (yyvs15.item (yyvsp15))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp6 := yyvsp6 + 1
	yyvsp1 := yyvsp1 -2
	yyvsp15 := yyvsp15 -1
	if yyvsp6 >= yyvsc6 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs6")
		end
		yyvsc6 := yyvsc6 + yyInitial_yyvs_size
		yyvs6 := yyspecial_routines6.aliased_resized_area (yyvs6, yyvsc6)
	end
	yyspecial_routines6.force (yyvs6, yyval6, yyvsp6)
end
when 196 then
--|#line 1098 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 1098")
end

			yyval6 := yyvs6.item (yyvsp6)
			yyval6.set_parameters (new_empty_elipsis_parameter_type_list)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp1 := yyvsp1 -4
	yyspecial_routines6.force (yyvs6, yyval6, yyvsp6)
end
when 197 then
--|#line 1103 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 1103")
end

			yyval6 := yyvs6.item (yyvsp6)
			yyval6.set_parameters (yyvs15.item (yyvsp15))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp1 := yyvsp1 -4
	yyvsp15 := yyvsp15 -1
	yyspecial_routines6.force (yyvs6, yyval6, yyvsp6)
end
when 198 then
--|#line 1111 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 1111")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp1 := yyvsp1 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp1 >= yyvsc1 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs1")
		end
		yyvsc1 := yyvsc1 + yyInitial_yyvs_size
		yyvs1 := yyspecial_routines1.aliased_resized_area (yyvs1, yyvsc1)
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 199 then
--|#line 1112 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 1112")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 200 then
--|#line 1113 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 1113")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp1 := yyvsp1 -3
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 201 then
--|#line 1117 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 1117")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 202 then
--|#line 1118 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 1118")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 203 then
--|#line 1122 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 1122")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 204 then
--|#line 1128 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 1128")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp1 := yyvsp1 + 1
	yyvsp3 := yyvsp3 -1
	if yyvsp1 >= yyvsc1 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs1")
		end
		yyvsc1 := yyvsc1 + yyInitial_yyvs_size
		yyvs1 := yyspecial_routines1.aliased_resized_area (yyvs1, yyvsc1)
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 205 then
--|#line 1129 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 1129")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp3 := yyvsp3 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 206 then
--|#line 1133 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 1133")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 207 then
--|#line 1134 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 1134")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 208 then
--|#line 1139 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 1139")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 209 then
--|#line 1140 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 1140")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp1 := yyvsp1 + 1
	yyvsp3 := yyvsp3 -1
	if yyvsp1 >= yyvsc1 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs1")
		end
		yyvsc1 := yyvsc1 + yyInitial_yyvs_size
		yyvs1 := yyspecial_routines1.aliased_resized_area (yyvs1, yyvsc1)
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 210 then
--|#line 1144 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 1144")
end

disable_implementation_mode
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp1 := yyvsp1 -3
	yyvsp7 := yyvsp7 -1
	yyvsp5 := yyvsp5 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 211 then
--|#line 1144 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 1144")
end

enable_implementation_mode
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp1 := yyvsp1 + 1
	if yyvsp1 >= yyvsc1 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs1")
		end
		yyvsc1 := yyvsc1 + yyInitial_yyvs_size
		yyvs1 := yyspecial_routines1.aliased_resized_area (yyvs1, yyvsc1)
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 212 then
--|#line 1145 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 1145")
end

disable_implementation_mode
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp1 := yyvsp1 -2
	yyvsp7 := yyvsp7 -1
	yyvsp5 := yyvsp5 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 213 then
--|#line 1145 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 1145")
end

enable_implementation_mode
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp1 := yyvsp1 + 1
	if yyvsp1 >= yyvsc1 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs1")
		end
		yyvsc1 := yyvsc1 + yyInitial_yyvs_size
		yyvs1 := yyspecial_routines1.aliased_resized_area (yyvs1, yyvsc1)
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 214 then
--|#line 1146 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 1146")
end

disable_implementation_mode
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp1 := yyvsp1 -2
	yyvsp5 := yyvsp5 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 215 then
--|#line 1146 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 1146")
end

enable_implementation_mode
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp1 := yyvsp1 + 1
	if yyvsp1 >= yyvsc1 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs1")
		end
		yyvsc1 := yyvsc1 + yyInitial_yyvs_size
		yyvs1 := yyspecial_routines1.aliased_resized_area (yyvs1, yyvsc1)
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 216 then
--|#line 1147 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 1147")
end

disable_implementation_mode
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp5 := yyvsp5 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 217 then
--|#line 1147 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 1147")
end

enable_implementation_mode
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp1 := yyvsp1 + 1
	if yyvsp1 >= yyvsc1 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs1")
		end
		yyvsc1 := yyvsc1 + yyInitial_yyvs_size
		yyvs1 := yyspecial_routines1.aliased_resized_area (yyvs1, yyvsc1)
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 218 then
--|#line 1155 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 1155")
end

			push_reporting_type_name_scope
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp1 := yyvsp1 + 1
	if yyvsp1 >= yyvsc1 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs1")
		end
		yyvsc1 := yyvsc1 + yyInitial_yyvs_size
		yyvs1 := yyspecial_routines1.aliased_resized_area (yyvs1, yyvsc1)
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 219 then
--|#line 1162 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 1162")
end

			if type_name_scope_stack.count > 0 then
				disable_type_name_reporting_for_this_scope
			else
				-- We do need to disable type name
				-- reporting in the global scope
				-- because there is no TOK_TYPE_NAME / TOK_IDENTIFIER
				-- ambiguity in the global scope.
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp1 := yyvsp1 + 1
	if yyvsp1 >= yyvsc1 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs1")
		end
		yyvsc1 := yyvsc1 + yyInitial_yyvs_size
		yyvs1 := yyspecial_routines1.aliased_resized_area (yyvs1, yyvsc1)
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 220 then
--|#line 1176 "ewg_c_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'ewg_c_parser.y' at line 1176")
end

			pop_type_name_scope
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp1 := yyvsp1 + 1
	if yyvsp1 >= yyvsc1 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs1")
		end
		yyvsc1 := yyvsc1 + yyInitial_yyvs_size
		yyvs1 := yyspecial_routines1.aliased_resized_area (yyvs1, yyvsc1)
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
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
			when 356 then
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
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 326)
			yytranslate_template_1 (an_array)
			yytranslate_template_2 (an_array)
			Result := yyfixed_array (an_array)
		end

	yytranslate_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yytranslate'.
		do
			yyarray_subcopy (an_array, <<
			    0,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,   83,    2,    2,    2,   85,   78,    2,
			   72,   73,   79,   80,   77,   81,   76,   84,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,   91,   93,
			   86,   92,   87,   90,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,   74,    2,   75,   88,    2,    2,    2,    2,    2,

			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,   94,   89,   95,   82,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2, yyDummy>>,
			1, 200, 0)
		end

	yytranslate_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yytranslate'.
		do
			yyarray_subcopy (an_array, <<
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

			   45,   46,   47,   48,   49,   50,   51,   52,   53,   54,
			   55,   56,   57,   58,   59,   60,   61,   62,   63,   64,
			   65,   66,   67,   68,   69,   70,   71, yyDummy>>,
			1, 127, 200)
		end

	yyr1_template: SPECIAL [INTEGER]
			-- Template for `yyr1'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 220)
			yyr1_template_1 (an_array)
			yyr1_template_2 (an_array)
			Result := yyfixed_array (an_array)
		end

	yyr1_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yyr1'.
		do
			yyarray_subcopy (an_array, <<
			    0,  146,  146,  146,  146,  145,  145,  145,  145,  145,
			  145,  145,  145,  147,  147,  144,  144,  144,  144,  144,
			  144,  149,  149,  149,  149,  149,  149,  143,  143,  142,
			  142,  142,  142,  141,  141,  141,  140,  140,  140,  139,
			  139,  139,  139,  139,  138,  138,  138,  137,  137,  136,
			  136,  135,  135,  134,  134,  131,  131,  130,  130,  133,
			  133,  148,  148,  148,  148,  148,  148,  148,  148,  148,
			  148,  148,  132,  132,  129,  127,  127,  128,  128,  128,
			  128,  128,  128,   96,   96,  103,  103,  105,  105,  105,
			  105,  105,  105,   97,   97,   98,   98,  110,  110,  110,

			  110,  110,  110,  107,  107,  108,  108,  108,  108,  108,
			  108,  108,  108,  108,  108,  108,  108,  108,  109,  109,
			  109,  111,  111,  111,  111,  112,  112,  113,  113,  114,
			  114,  121,  122,  122,  122,  122,  115,  115,  116,  116,
			  116,  117,  117,  117,  119,  120,  120,  155,  155,  118,
			  118,  106,  106,   99,   99,   99,   99,   99,  100,  100,
			  100,  100,  100,  100,  100,  123,  123,  123,  123,  104,
			  104,  124,  124,  125,  125,  126,  126,  126,  156,  156,
			  150,  150,  101,  101,  101,  101,  101,  101,  101,  102,
			  102,  102,  102,  102,  102,  102,  102,  102,  153,  153, yyDummy>>,
			1, 200, 0)
		end

	yyr1_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yyr1'.
		do
			yyarray_subcopy (an_array, <<
			  153,  157,  157,  158,  159,  159,  160,  160,  161,  161,
			  162,  163,  162,  164,  162,  165,  162,  166,  152,  154,
			  151, yyDummy>>,
			1, 21, 200)
		end

	yytypes1_template: SPECIAL [INTEGER]
			-- Template for `yytypes1'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 358)
			yytypes1_template_1 (an_array)
			yytypes1_template_2 (an_array)
			Result := yyfixed_array (an_array)
		end

	yytypes1_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yytypes1'.
		do
			yyarray_subcopy (an_array, <<
			    1,    1,    1,    2,    2,    2,    2,    2,    2,    2,
			    3,    5,    6,    7,   14,   16,   17,    1,    1,    1,
			    1,    2,    2,    8,    9,   14,    5,   16,    3,    7,
			   16,    1,    1,    1,    4,    5,    5,    1,    6,   16,
			    6,   14,    1,   16,    2,    2,    2,    2,    2,    2,
			    7,    9,   10,   11,    1,    1,    9,   14,    1,    5,
			    3,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    6,    6,    7,    7,    7,    7,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,   10,   10,   10,   12,   10,    1,

			    1,    1,    1,    1,    1,    1,    1,    1,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    1,    2,    7,   15,   13,    3,    1,    1,    5,
			    1,    1,    2,    2,    2,    1,    1,    1,    1,    2,
			    2,    2,    1,    7,    2,    2,    2,    1,    1,    2,
			    2,    1,    2,    1,    1,    2,    2,    1,    1,    1,
			    2,    2,    1,    1,    2,    2,    2,    2,    1,    1,
			    1,    1,    1,    1,    1,    1,    2,    2,    2,    2,
			    1,    1,    5,    5,    6,   14,   16,    1,    1,    1, yyDummy>>,
			1, 200, 0)
		end

	yytypes1_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yytypes1'.
		do
			yyarray_subcopy (an_array, <<
			    1,    1,    1,    1,    1,    1,    1,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    1,    1,
			    2,    3,   13,   13,    1,    1,    1,    1,    5,   14,
			   16,    1,    1,    1,    9,   10,    7,    2,    1,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    1,    2,    2,    2,    1,    5,   15,   16,    1,    1,
			    1,    1,    6,   16,    6,   14,    1,    1,    2,    3,
			    2,    1,    1,    1,    2,    1,    1,    1,    1,    1,
			   13,    1,   13,    3,    7,   16,   16,   14,    2,    1,

			    7,    7,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    6,    6,    2,    1,    1,    1,    2,    3,
			    1,   13,    3,    1,    1,    5,    4,    5,    1,    2,
			    1,    2,    2,    2,    1,   15,    1,    1,    1,    1,
			    1,    2,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    2,    5,    1,    1,    1,    1,    1, yyDummy>>,
			1, 159, 200)
		end

	yytypes2_template: SPECIAL [INTEGER]
			-- Template for `yytypes2'
		once
			Result := yyfixed_array (<<
			    1,    1,    1,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1, yyDummy>>)
		end

	yydefact_template: SPECIAL [INTEGER]
			-- Template for `yydefact'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 358)
			yydefact_template_1 (an_array)
			yydefact_template_2 (an_array)
			Result := yyfixed_array (an_array)
		end

	yydefact_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yydefact'.
		do
			yyarray_subcopy (an_array, <<
			  218,  165,    0,   77,   80,   82,   81,   79,   78,  158,
			  209,  218,  218,  220,    0,  218,   75,  219,  218,  206,
			  208,  152,  151,  166,  169,  167,    0,    0,  204,  220,
			  218,  218,    0,    0,  220,   93,  220,    0,  218,    0,
			  218,    0,  219,   76,  102,  101,  100,   99,   98,   97,
			   85,  219,  219,  219,    0,  207,  170,  168,  159,   95,
			  205,    0,    0,  216,  220,  220,    0,    0,    0,  218,
			   83,  218,  218,   86,   92,   90,   88,  112,  111,  110,
			  109,    0,  126,  125,  105,  115,  114,  117,  116,  113,
			  108,  107,  106,  120,  103,  104,  118,  218,  119,  214,

			  203,   26,   25,   24,   23,   22,   21,  218,    0,    0,
			    0,    3,    2,    1,  220,   74,   57,   55,   53,   51,
			   49,   47,   44,   39,   36,   33,   29,   27,   15,    5,
			    0,    0,  178,  220,  220,  171,  173,    0,  220,   94,
			   84,    0,   59,  198,   27,   96,  218,    0,    0,  143,
			  124,  218,    0,  218,    0,   72,  220,  219,    0,   17,
			   16,  218,   19,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,   12,   11,    0,   18,
			  161,  218,  220,  220,  218,  218,  218,  177,    0,    0, yyDummy>>,
			1, 200, 0)
		end

	yydefact_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yydefact'.
		do
			yyarray_subcopy (an_array, <<
			  218,  164,    0,    0,  201,    0,   61,   71,   70,   69,
			   68,   67,   66,   65,   64,   63,   62,    0,    0,  212,
			  149,  145,    0,  147,    0,    0,  218,  218,  181,  218,
			  218,    0,    4,    0,  219,  219,  131,  220,  160,    0,
			   56,   54,   52,   50,   48,   46,   45,   41,   40,   43,
			   42,   38,   37,   35,   34,   32,   31,   30,    9,    0,
			    7,   13,    0,   10,  194,    0,    0,  218,  219,  175,
			  176,    0,  218,  218,  218,  218,  220,  162,  172,  174,
			  179,  163,  199,    0,   60,  210,    0,  141,  148,  144,
			    0,  218,  220,  127,  220,  218,  218,  218,   73,    0,

			  134,  132,    0,    0,    6,    0,    8,  189,  195,  219,
			  220,  220,  218,  218,  220,    0,  200,  202,  150,  146,
			  142,  220,  128,    0,    0,  138,  220,  136,    0,   28,
			   20,   58,   14,  220,    0,  220,    0,    0,  190,    0,
			  122,  139,    0,    0,    0,  130,    0,  192,    0,  196,
			  191,  121,  140,  137,  129,  193,  197,    0,    0, yyDummy>>,
			1, 159, 200)
		end

	yydefgoto_template: SPECIAL [INTEGER]
			-- Template for `yydefgoto'
		once
			Result := yyfixed_array (<<
			   10,   34,   35,   11,   12,  265,  194,  133,   23,   50,
			   51,   52,   94,   95,   53,   96,   97,  292,  293,  326,
			  327,   98,  221,  222,  223,  294,  236,   14,  266,  135,
			  136,   30,   16,  114,  142,  116,  154,  155,  117,  118,
			  119,  120,  121,  122,  123,  124,  125,  126,  127,  128,
			  129,  262,  217,  130,  156,   37,  198,  145,   54,  289,
			  138,  205,   63,   31,   18,   19,   20,  218,  147,   61,
			   32, yyDummy>>)
		end

	yypact_template: SPECIAL [INTEGER]
			-- Template for `yypact'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 358)
			yypact_template_1 (an_array)
			yypact_template_2 (an_array)
			Result := yyfixed_array (an_array)
		end

	yypact_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yypact'.
		do
			yyarray_subcopy (an_array, <<
			  630,   28,  630, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768,  790, 1070,  630,  471,   50,  434,  466,  650, -32768,
			 -32768, -32768, -32768,   28, -32768, -32768,  272,   50, -32768,  630,
			 -32768,  784,  207,  120,  267, -32768,   96,  247, 1003,   18,
			  936,   18,  466, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768,  555,  503,  451, 1246, -32768, -32768, -32768, -32768,  254,
			 -32768,  207,  236, -32768,  632,  758,  630,  243,  329,  576,
			 -32768,  869,  802, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768,   12, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768,   86, -32768, -32768,

			 -32768, -32768, -32768, -32768, -32768, -32768, -32768,  632,  685,  685,
			  660, -32768, -32768, -32768, -32768, -32768,   -6,  252,  158,  145,
			  148,  222,   48,  190,   87,   65, -32768, -32768,  156, -32768,
			  632,  255, -32768,  703, -32768,  251, -32768,  253,  248, -32768,
			 -32768,  329, -32768, -32768,  726, -32768,  381,  207,  216,  228,
			 -32768,  399,  224, 1196,  139, -32768, -32768,  215,  632, -32768,
			 -32768,  632, -32768,  242,  632,  632,  632,  632,  632,  632,
			  632,  632,  632,  632,  632,  632,  632,  632,  632,  632,
			  632,  632,  632,  313,  632,  604, -32768, -32768,  312, -32768,
			 -32768,  482, -32768, -32768,  137,  194,   44, -32768,  238,  234, yyDummy>>,
			1, 200, 0)
		end

	yypact_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yypact'.
		do
			yyarray_subcopy (an_array, <<
			  175, -32768,  303,  229, -32768,  -50, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768,  632,  207, -32768,
			  203, -32768,  193,  204,  216,  182, -32768, 1101, -32768,  533,
			   45,  632, -32768,  165,  588,  324, -32768, -32768, -32768,   -9,
			  252,  158,  145,  148,  222,   48,   48,  190,  190,  190,
			  190,   87,   87,   65,   65, -32768, -32768, -32768, -32768,   62,
			 -32768, -32768,  134, -32768, -32768,  151,  149,   44, 1123, -32768,
			 -32768,   46,  110,    2,  102,   83,  632, -32768, -32768, -32768,
			 -32768, -32768, -32768,  305, -32768, -32768,  632, -32768,  216, -32768,
			  122, -32768, 1214, -32768,  283,   45,  143,   27, -32768,  632,

			 -32768, -32768,  136,  632, -32768,  632, -32768, -32768, -32768, 1123,
			  632, 1170,   93,   54, -32768,  118, -32768, -32768, -32768, -32768,
			 -32768, 1214, -32768,   82,  632,   56,  109, -32768,   64, -32768,
			 -32768, -32768, -32768, -32768,   63, -32768,   52,   34, -32768,   -4,
			 -32768, -32768,  632,  283,  -24, -32768,   -3, -32768,  -37, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768,    6, -32768, yyDummy>>,
			1, 159, 200)
		end

	yypgoto_template: SPECIAL [INTEGER]
			-- Template for `yypgoto'
		once
			Result := yyfixed_array (<<
			   32, -32768,  309,   -1,   10,  -23, -154,   67, -32768,  -20,
			   39, -147, -32768, -32768, -32768, -32768, -32768,   80, -228, -32768,
			   33, -32768,   84,  146, -32768,  -57,   70,   29,  -62, -32768,
			  169,    0, -32768, -184,  -55, -32768, -130,  -33,  200,  197,
			  192,  196,  191,  127,   79,  114,  100, -123,  -13, -32768,
			 -32768, -32768, -32768, -32768,  195,   47,    8, -137, -32768, -32768,
			 -32768, -32768,  -44,  278, -32768,  330, -32768, -32768, -32768, -32768,
			 -32768, yyDummy>>)
		end

	yytable_template: SPECIAL [INTEGER]
			-- Template for `yytable'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 1311)
			yytable_template_1 (an_array)
			yytable_template_2 (an_array)
			yytable_template_3 (an_array)
			yytable_template_4 (an_array)
			yytable_template_5 (an_array)
			yytable_template_6 (an_array)
			yytable_template_7 (an_array)
			Result := yyfixed_array (an_array)
		end

	yytable_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			   15,   26,   27,  134,  204,    9,  358,  189,   17,  115,
			  235,  165,   36,   27,   39,  149,   43,   99,   15,   17,
			   33,    9,   73,   42,   38,   40,   17,  283,   59,   27,
			   25,   74,   75,   76,  239,  143,  356,   40,   42,   17,
			   24,  272,  274,   28,   41,  282,   33,    9,   33,   71,
			  153,   72,   57,    9,  259,  144,   41,  255,  256,  257,
			  175,  174,   56,   60,  322,   59,   27,   13,  231,  354,
			   22,   21,  355,   17,  191,  272,  274,   17,   29,   33,
			   33,   67,  303,   69,  164,   13,    9,  235,  235,  151,
			    2,  351,  314,  322,  144,  159,  160,  162,   29,  227,

			 -188,   28,  318,  219,  153,  152,  148,    1,  143,  350,
			  193,  131,  137,  274,  150,  157,  191,  227,  311,  312,
			  310,  313,    2,    1,    1,  349,  333, -186,  144,    1,
			  228, -186,  192,  196,  173,  172,   29,  304,  347,  231,
			  341,  274,  312,  313,  182,  144,  317,  342,  144,  181,
			  180,  144,  261,  230,   17,  191, -188,  345,  352,  225,
			 -188,  163,  195,  188,  187,  186, -185,  179,  178,  157,
			 -185,  144,  144,  -95,  285, -187,  329,  340,   60, -187,
			  197,  199,  229, -184,  284,  203,  343, -184,   68,  -95,
			   26,  267,   65,  338,   64,  273,  234,    9,  298,  268, yyDummy>>,
			1, 200, 0)
		end

	yytable_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			  177,  176,  271,  233,  144,   38,   40,  306,   17,  330,
			 -183,  305,  232,   29, -183,  227,  231,  320,  144,  220,
			  195,  115,  308,  278,  307,  275,  169,  295,  185,  296,
			  184,  115,  183,  168,  157,  268,  171,  170,  299,  269,
			  270,    8,    7,    6,    5,    4,    3,  167,  331,  335,
			  143,  247,  248,  249,  250,  115,  229,   22,   21,  297,
			    8,    7,    6,    5,    4,    3,  191, -182,  166,  115,
			  144, -182,  332,  234,  234,  309,  291,   40,  253,  254,
			  271,  288,  271,   71,  302,   72,    9,  115,  287,   73,
			  251,  252,  144,  325,   27,  286,  275,  245,  246,  157,

			  157,   62,  281,  309,  300,  301,  280,  277,  113,  112,
			  111,  110,  276,  109,  108,  263,  258,  238,  226,   17,
			  271,  271,  224,  315,  297,  202,  201, -133,  200,  157,
			  190,  100,  113,  112,  111,  110,  140,  109,  108,  323,
			   70,  328,  325,   27,   66,   58,   68,  146,   55,    8,
			    7,    6,    5,    4,    3,    2,  237,  334,  336,  242,
			  244,  337,    1,  241,  243,  240,   22,   21,  339,  279,
			  290,  321,  319,  344,  324,  139,  353,  107,    0,    0,
			  346,    0,  348,  106,  105,  104,  103,  102,  101,    0,
			 -133, -133, -133, -133, -133, -133, -133, -133, -133,  141, yyDummy>>,
			1, 200, 200)
		end

	yytable_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			  316,  107, -123, -133,    0,    0,    0,  106,  105,  104,
			  103,  102,  101,    0,    0, -133,    0, -133,    0,    0,
			    0,    0,    0,  141,    0,    0,    0, -123, -123, -123,
			 -123, -123, -123, -123, -123, -123, -123, -123, -123, -123,
			 -123, -123, -123, -123, -123, -123, -123,    8,    7,    6,
			    5,    4,    3,    0,  -87,    0,    0,    0,    0,    0,
			 -123, -123, -123, -123, -123, -123, -123, -123, -123, -123,
			 -123, -123, -123, -123,    9, -211, -123,    0, -123,    0,
			   49,   48,   47,   46,   45,    9,    0,    0,    0,    0,
			 -123,    0, -123,   22,   21,   49,   48,   47,   46,   45,

			    8,    7,    6,    5,    4,    3,  -89,    0,   22,   21,
			    0,    0,   44,    0,    0,    0,    0,  -87,  -87,  -87,
			  -87,  -87,  -87,  -87,  -87,  -87,    0,   44,  -87,    0,
			  -87,    0,   49,   48,   47,   46,   45,    8,    7,    6,
			    5,    4,    3,    2,  -87,   22,   21,    0,    8,    7,
			    6,    5,    4,    3,  191,  264,    0,    0,  -91,    0,
			    0,    1,    0,    0,   44,    0,    0,    0,    0,  -89,
			  -89,  -89,  -89,  -89,  -89,  -89,  -89,  -89,    0,    0,
			  -89,    0,  -89,    0,   49,   48,   47,   46,   45,    0,
			    0, -135,    0,    0,    0,    0,  -89,   22,   21,    8, yyDummy>>,
			1, 200, 400)
		end

	yytable_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			    7,    6,    5,    4,    3,  227, -182,  113,  112,  111,
			  110,    0,  109,  108,    0,    0,   44,    0,    0,    0,
			    0,  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,  -91,
			   22,   21,  -91,    9,  -91,  113,  112,  111,  110,    0,
			  109,  108,    8,    7,    6,    5,    4,    3,  -91,    0,
			  357,    0,    0,    9, -135, -135, -135, -135, -135, -135,
			 -135, -135, -135,  113,  112,  111,  110, -135,  109,  108,
			 -213,    0,    0,    0,    0,    0,  107,  260,    0, -135,
			    0, -135,  106,  105,  104,  103,  102,  101,  113,  112,
			  111,  110,    0,  109,  108,    0,    8,    7,    6,    5,

			    4,    3,    2,    0,  107,    0,    9,    0,    0,    1,
			  106,  105,  104,  103,  102,  101,    8,    7,    6,    5,
			    4,    3,    2,    0,    0,    0,    0,    0,    0,    1,
			    0,    0,  161,    0,    0,    0,    0,    0,  106,  105,
			  104,  103,  102,  101,  216,  215,  214,  213,  212,  211,
			  210,  209,  208,  207,    0,    0,    0,  158,    0,    0,
			    0,  132,    0,  106,  105,  104,  103,  102,  101,    8,
			    7,    6,    5,    4,    3,  191,    0, -218,    0,    0,
			    0,    0,    1,    0,    0,    0, -218, -218, -218, -218,
			 -218, -218, -218, -218, -218, -218, -218, -218, -218, -218, yyDummy>>,
			1, 200, 600)
		end

	yytable_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			 -218, -218, -218, -218, -218, -218,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,  206, -218,
			 -218, -218, -218, -218,    8,    7,    6,    5,    4,    3,
			 -156, -156, -156, -156, -156, -156, -156, -156, -156, -156,
			 -156, -156, -156, -156, -156, -156, -156, -156, -156, -156,
			    8,    7,    6,    5,    4,    3,    8,    7,    6,    5,
			    4,    3,    0, -156, -156, -156, -156, -156, -156, -156,
			 -156, -156, -156, -156,    0, -156,    0,    0, -215, -156,
			    0,    0,    0,    0, -217,    0,    0,    0,    0,    0,
			    0,    0,    0, -156, -156, -156, -156, -155, -155, -155,

			 -155, -155, -155, -155, -155, -155, -155, -155, -155, -155,
			 -155, -155, -155, -155, -155, -155, -155,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			 -155, -155, -155, -155, -155, -155, -155, -155, -155, -155,
			 -155,    0, -155,    0,    0,    0, -155,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			 -155, -155, -155, -155, -157, -157, -157, -157, -157, -157,
			 -157, -157, -157, -157, -157, -157, -157, -157, -157, -157,
			 -157, -157, -157, -157,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0, -157, -157, -157, yyDummy>>,
			1, 200, 800)
		end

	yytable_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			 -157, -157, -157, -157, -157, -157, -157, -157,    0, -157,
			    0,    0,    0, -157,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0, -157, -157, -157,
			 -157, -153, -153, -153, -153, -153, -153, -153, -153, -153,
			 -153, -153, -153, -153, -153, -153, -153, -153, -153, -153,
			 -153,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0, -153, -153, -153, -153, -153, -153,
			 -153, -153, -153, -153, -153,    0, -153,    0,    0,    0,
			 -153,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0, -153, -153, -153, -153, -154, -154,

			 -154, -154, -154, -154, -154, -154, -154, -154, -154, -154,
			 -154, -154, -154, -154, -154, -154, -154, -154,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0, -154, -154, -154, -154, -154, -154, -154, -154, -154,
			 -154, -154,    0, -154,    0,    0,    0, -154,    0,    0,
			    0,    0,   49,   48,   47,   46,   45,    0,    0,    0,
			    0, -154, -154, -154, -154,   22,   21,    8,    7,    6,
			    5,    4,    3,  227,  264,    0,    0,    0,    0,    0,
			    1,    0,    0,    0,   44,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,  276, -218, -218, yyDummy>>,
			1, 200, 1000)
		end

	yytable_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			 -218, -218, -218, -218, -218, -218, -218, -218, -218, -218,
			 -218, -218, -218, -218, -218, -218, -218, -218,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0, -218, -218, -218, -218, -218,    8,    7,    6,    5,
			    4,    3, -218,    0,    0,    0,    0,    0, -218, -218,
			 -218, -218, -218, -218, -218, -218, -218, -218, -218, -218,
			 -218, -218,    8,    7,    6,    5,    4,    3,  227, -180,
			    0,    0,    0,    0,   93,    1, -218, -218, -218, -218,
			   92,   91,   90,   89,   88,   87,   86,   85,    0,    0,
			   84,   83,   82,   81,    0,    0,    0,    0,    0,    0,

			    0,    0,    0,    0,    0,    0,    0,    0,   80,   79,
			   78,   77, yyDummy>>,
			1, 112, 1200)
		end

	yycheck_template: SPECIAL [INTEGER]
			-- Template for `yycheck'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 1311)
			yycheck_template_1 (an_array)
			yycheck_template_2 (an_array)
			yycheck_template_3 (an_array)
			yycheck_template_4 (an_array)
			yycheck_template_5 (an_array)
			yycheck_template_6 (an_array)
			yycheck_template_7 (an_array)
			Result := yyfixed_array (an_array)
		end

	yycheck_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			    0,    2,    2,   65,  141,    3,    0,  130,    0,   64,
			  157,   17,   13,   13,   14,    3,   16,   61,   18,   11,
			   12,    3,   42,   15,   14,   15,   18,   77,   29,   29,
			    1,   51,   52,   53,  164,   68,   73,   27,   30,   31,
			    1,  195,  196,   11,   15,   95,   38,    3,   40,   39,
			  107,   41,   23,    3,  184,   68,   27,  180,  181,  182,
			   12,   13,   23,   31,  292,   66,   66,    0,   77,   93,
			   42,   43,   75,   65,   72,  229,  230,   69,   11,   71,
			   72,   34,   91,   36,   90,   18,    3,  234,  235,    3,
			   72,   95,  276,  321,  107,  108,  109,  110,   31,   72,

			   73,   69,  286,  147,  161,   97,   94,   79,  141,   75,
			  133,   64,   65,  267,   28,  107,   72,   72,   72,  273,
			   74,  275,   72,   79,   79,   73,  310,   73,  141,   79,
			  153,   77,  133,  133,   86,   87,   69,   75,   75,   77,
			  324,  295,  296,  297,   79,  158,  283,   91,  161,   84,
			   85,  164,  185,  153,  146,   72,   73,   93,  342,  151,
			   77,  114,  133,    7,    8,    9,   73,   80,   81,  161,
			   77,  184,  185,   77,  218,   73,  299,   95,  146,   77,
			  133,  134,  153,   73,  217,  138,   77,   77,   92,   93,
			  191,  191,   72,   75,   74,  195,  157,    3,  231,  191, yyDummy>>,
			1, 200, 0)
		end

	yycheck_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			   10,   11,  194,  156,  217,  195,  196,   73,  200,   73,
			   73,   77,   73,  146,   77,   72,   77,   95,  231,    3,
			  191,  276,   73,   48,   73,  196,   78,  227,   72,  229,
			   74,  286,   76,   88,  226,  227,   14,   15,   73,  192,
			  193,   66,   67,   68,   69,   70,   71,   89,  303,  311,
			  283,  172,  173,  174,  175,  310,  227,   42,   43,  230,
			   66,   67,   68,   69,   70,   71,   72,   73,   16,  324,
			  283,   77,  305,  234,  235,  267,   94,  267,  178,  179,
			  272,   77,  274,  273,  237,  275,    3,  342,   95,  309,
			  176,  177,  305,  294,  294,   92,  267,  170,  171,  291,

			  292,   94,   73,  295,  234,  235,    3,   73,    3,    4,
			    5,    6,   74,    8,    9,    3,    3,   75,   94,  311,
			  312,  313,   94,  276,  295,   77,   73,    3,   77,  321,
			   75,   95,    3,    4,    5,    6,   93,    8,    9,  292,
			   93,  294,  343,  343,   77,   73,   92,   69,   18,   66,
			   67,   68,   69,   70,   71,   72,  161,  310,  311,  167,
			  169,  314,   79,  166,  168,  165,   42,   43,  321,  200,
			  224,  291,  288,  326,   91,   66,  343,   72,   -1,   -1,
			  333,   -1,  335,   78,   79,   80,   81,   82,   83,   -1,
			   66,   67,   68,   69,   70,   71,   72,   73,   74,   94, yyDummy>>,
			1, 200, 200)
		end

	yycheck_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			   95,   72,    3,   79,   -1,   -1,   -1,   78,   79,   80,
			   81,   82,   83,   -1,   -1,   91,   -1,   93,   -1,   -1,
			   -1,   -1,   -1,   94,   -1,   -1,   -1,   28,   29,   30,
			   31,   32,   33,   34,   35,   36,   37,   38,   39,   40,
			   41,   42,   43,   44,   45,   46,   47,   66,   67,   68,
			   69,   70,   71,   -1,    3,   -1,   -1,   -1,   -1,   -1,
			   61,   62,   63,   64,   65,   66,   67,   68,   69,   70,
			   71,   72,   73,   74,    3,   94,   77,   -1,   79,   -1,
			   29,   30,   31,   32,   33,    3,   -1,   -1,   -1,   -1,
			   91,   -1,   93,   42,   43,   29,   30,   31,   32,   33,

			   66,   67,   68,   69,   70,   71,    3,   -1,   42,   43,
			   -1,   -1,   61,   -1,   -1,   -1,   -1,   66,   67,   68,
			   69,   70,   71,   72,   73,   74,   -1,   61,   77,   -1,
			   79,   -1,   29,   30,   31,   32,   33,   66,   67,   68,
			   69,   70,   71,   72,   93,   42,   43,   -1,   66,   67,
			   68,   69,   70,   71,   72,   73,   -1,   -1,    3,   -1,
			   -1,   79,   -1,   -1,   61,   -1,   -1,   -1,   -1,   66,
			   67,   68,   69,   70,   71,   72,   73,   74,   -1,   -1,
			   77,   -1,   79,   -1,   29,   30,   31,   32,   33,   -1,
			   -1,    3,   -1,   -1,   -1,   -1,   93,   42,   43,   66, yyDummy>>,
			1, 200, 400)
		end

	yycheck_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			   67,   68,   69,   70,   71,   72,   73,    3,    4,    5,
			    6,   -1,    8,    9,   -1,   -1,   61,   -1,   -1,   -1,
			   -1,   66,   67,   68,   69,   70,   71,   72,   73,   74,
			   42,   43,   77,    3,   79,    3,    4,    5,    6,   -1,
			    8,    9,   66,   67,   68,   69,   70,   71,   93,   -1,
			    0,   -1,   -1,    3,   66,   67,   68,   69,   70,   71,
			   72,   73,   74,    3,    4,    5,    6,   79,    8,    9,
			   94,   -1,   -1,   -1,   -1,   -1,   72,   73,   -1,   91,
			   -1,   93,   78,   79,   80,   81,   82,   83,    3,    4,
			    5,    6,   -1,    8,    9,   -1,   66,   67,   68,   69,

			   70,   71,   72,   -1,   72,   -1,    3,   -1,   -1,   79,
			   78,   79,   80,   81,   82,   83,   66,   67,   68,   69,
			   70,   71,   72,   -1,   -1,   -1,   -1,   -1,   -1,   79,
			   -1,   -1,   72,   -1,   -1,   -1,   -1,   -1,   78,   79,
			   80,   81,   82,   83,   18,   19,   20,   21,   22,   23,
			   24,   25,   26,   27,   -1,   -1,   -1,   72,   -1,   -1,
			   -1,    3,   -1,   78,   79,   80,   81,   82,   83,   66,
			   67,   68,   69,   70,   71,   72,   -1,   74,   -1,   -1,
			   -1,   -1,   79,   -1,   -1,   -1,   28,   29,   30,   31,
			   32,   33,   34,   35,   36,   37,   38,   39,   40,   41, yyDummy>>,
			1, 200, 600)
		end

	yycheck_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			   42,   43,   44,   45,   46,   47,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   92,   61,
			   62,   63,   64,   65,   66,   67,   68,   69,   70,   71,
			   28,   29,   30,   31,   32,   33,   34,   35,   36,   37,
			   38,   39,   40,   41,   42,   43,   44,   45,   46,   47,
			   66,   67,   68,   69,   70,   71,   66,   67,   68,   69,
			   70,   71,   -1,   61,   62,   63,   64,   65,   66,   67,
			   68,   69,   70,   71,   -1,   73,   -1,   -1,   94,   77,
			   -1,   -1,   -1,   -1,   94,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   91,   92,   93,   94,   28,   29,   30,

			   31,   32,   33,   34,   35,   36,   37,   38,   39,   40,
			   41,   42,   43,   44,   45,   46,   47,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   61,   62,   63,   64,   65,   66,   67,   68,   69,   70,
			   71,   -1,   73,   -1,   -1,   -1,   77,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   91,   92,   93,   94,   28,   29,   30,   31,   32,   33,
			   34,   35,   36,   37,   38,   39,   40,   41,   42,   43,
			   44,   45,   46,   47,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   61,   62,   63, yyDummy>>,
			1, 200, 800)
		end

	yycheck_template_6 (an_array: ARRAY [INTEGER])
			-- Fill chunk #6 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			   64,   65,   66,   67,   68,   69,   70,   71,   -1,   73,
			   -1,   -1,   -1,   77,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   91,   92,   93,
			   94,   28,   29,   30,   31,   32,   33,   34,   35,   36,
			   37,   38,   39,   40,   41,   42,   43,   44,   45,   46,
			   47,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   61,   62,   63,   64,   65,   66,
			   67,   68,   69,   70,   71,   -1,   73,   -1,   -1,   -1,
			   77,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   91,   92,   93,   94,   28,   29,

			   30,   31,   32,   33,   34,   35,   36,   37,   38,   39,
			   40,   41,   42,   43,   44,   45,   46,   47,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   61,   62,   63,   64,   65,   66,   67,   68,   69,
			   70,   71,   -1,   73,   -1,   -1,   -1,   77,   -1,   -1,
			   -1,   -1,   29,   30,   31,   32,   33,   -1,   -1,   -1,
			   -1,   91,   92,   93,   94,   42,   43,   66,   67,   68,
			   69,   70,   71,   72,   73,   -1,   -1,   -1,   -1,   -1,
			   79,   -1,   -1,   -1,   61,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   74,   28,   29, yyDummy>>,
			1, 200, 1000)
		end

	yycheck_template_7 (an_array: ARRAY [INTEGER])
			-- Fill chunk #7 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			   30,   31,   32,   33,   34,   35,   36,   37,   38,   39,
			   40,   41,   42,   43,   44,   45,   46,   47,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   61,   62,   63,   64,   65,   66,   67,   68,   69,
			   70,   71,   28,   -1,   -1,   -1,   -1,   -1,   34,   35,
			   36,   37,   38,   39,   40,   41,   42,   43,   44,   45,
			   46,   47,   66,   67,   68,   69,   70,   71,   72,   73,
			   -1,   -1,   -1,   -1,   28,   79,   62,   63,   64,   65,
			   34,   35,   36,   37,   38,   39,   40,   41,   -1,   -1,
			   44,   45,   46,   47,   -1,   -1,   -1,   -1,   -1,   -1,

			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   62,   63,
			   64,   65, yyDummy>>,
			1, 112, 1200)
		end

feature {NONE} -- Semantic value stacks

	yyvs1: SPECIAL [detachable ANY]
			-- Stack for semantic values of type detachable ANY

	yyvsc1: INTEGER
			-- Capacity of semantic value stack `yyvs1'

	yyvsp1: INTEGER
			-- Top of semantic value stack `yyvs1'

	yyspecial_routines1: KL_SPECIAL_ROUTINES [detachable ANY]
			-- Routines that ought to be in SPECIAL [detachable ANY]

	yyvs2: SPECIAL [STRING]
			-- Stack for semantic values of type STRING

	yyvsc2: INTEGER
			-- Capacity of semantic value stack `yyvs2'

	yyvsp2: INTEGER
			-- Top of semantic value stack `yyvs2'

	yyspecial_routines2: KL_SPECIAL_ROUTINES [STRING]
			-- Routines that ought to be in SPECIAL [STRING]

	yyvs3: SPECIAL [EWG_C_PHASE_1_DECLARATION]
			-- Stack for semantic values of type EWG_C_PHASE_1_DECLARATION

	yyvsc3: INTEGER
			-- Capacity of semantic value stack `yyvs3'

	yyvsp3: INTEGER
			-- Top of semantic value stack `yyvs3'

	yyspecial_routines3: KL_SPECIAL_ROUTINES [EWG_C_PHASE_1_DECLARATION]
			-- Routines that ought to be in SPECIAL [EWG_C_PHASE_1_DECLARATION]

	yyvs4: SPECIAL [DS_LINKED_LIST [EWG_C_PHASE_1_DECLARATOR]]
			-- Stack for semantic values of type DS_LINKED_LIST [EWG_C_PHASE_1_DECLARATOR]

	yyvsc4: INTEGER
			-- Capacity of semantic value stack `yyvs4'

	yyvsp4: INTEGER
			-- Top of semantic value stack `yyvs4'

	yyspecial_routines4: KL_SPECIAL_ROUTINES [DS_LINKED_LIST [EWG_C_PHASE_1_DECLARATOR]]
			-- Routines that ought to be in SPECIAL [DS_LINKED_LIST [EWG_C_PHASE_1_DECLARATOR]]

	yyvs5: SPECIAL [EWG_C_PHASE_1_DECLARATOR]
			-- Stack for semantic values of type EWG_C_PHASE_1_DECLARATOR

	yyvsc5: INTEGER
			-- Capacity of semantic value stack `yyvs5'

	yyvsp5: INTEGER
			-- Top of semantic value stack `yyvs5'

	yyspecial_routines5: KL_SPECIAL_ROUTINES [EWG_C_PHASE_1_DECLARATOR]
			-- Routines that ought to be in SPECIAL [EWG_C_PHASE_1_DECLARATOR]

	yyvs6: SPECIAL [EWG_C_PHASE_1_DIRECT_DECLARATOR]
			-- Stack for semantic values of type EWG_C_PHASE_1_DIRECT_DECLARATOR

	yyvsc6: INTEGER
			-- Capacity of semantic value stack `yyvs6'

	yyvsp6: INTEGER
			-- Top of semantic value stack `yyvs6'

	yyspecial_routines6: KL_SPECIAL_ROUTINES [EWG_C_PHASE_1_DIRECT_DECLARATOR]
			-- Routines that ought to be in SPECIAL [EWG_C_PHASE_1_DIRECT_DECLARATOR]

	yyvs7: SPECIAL [DS_LINKED_LIST [ANY]]
			-- Stack for semantic values of type DS_LINKED_LIST [ANY]

	yyvsc7: INTEGER
			-- Capacity of semantic value stack `yyvs7'

	yyvsp7: INTEGER
			-- Top of semantic value stack `yyvs7'

	yyspecial_routines7: KL_SPECIAL_ROUTINES [DS_LINKED_LIST [ANY]]
			-- Routines that ought to be in SPECIAL [DS_LINKED_LIST [ANY]]

	yyvs8: SPECIAL [DS_LINKED_LIST [EWG_C_PHASE_1_TYPE_QUALIFIER]]
			-- Stack for semantic values of type DS_LINKED_LIST [EWG_C_PHASE_1_TYPE_QUALIFIER]

	yyvsc8: INTEGER
			-- Capacity of semantic value stack `yyvs8'

	yyvsp8: INTEGER
			-- Top of semantic value stack `yyvs8'

	yyspecial_routines8: KL_SPECIAL_ROUTINES [DS_LINKED_LIST [EWG_C_PHASE_1_TYPE_QUALIFIER]]
			-- Routines that ought to be in SPECIAL [DS_LINKED_LIST [EWG_C_PHASE_1_TYPE_QUALIFIER]]

	yyvs9: SPECIAL [EWG_C_PHASE_1_TYPE_QUALIFIER]
			-- Stack for semantic values of type EWG_C_PHASE_1_TYPE_QUALIFIER

	yyvsc9: INTEGER
			-- Capacity of semantic value stack `yyvs9'

	yyvsp9: INTEGER
			-- Top of semantic value stack `yyvs9'

	yyspecial_routines9: KL_SPECIAL_ROUTINES [EWG_C_PHASE_1_TYPE_QUALIFIER]
			-- Routines that ought to be in SPECIAL [EWG_C_PHASE_1_TYPE_QUALIFIER]

	yyvs10: SPECIAL [EWG_C_PHASE_1_TYPE_SPECIFIER]
			-- Stack for semantic values of type EWG_C_PHASE_1_TYPE_SPECIFIER

	yyvsc10: INTEGER
			-- Capacity of semantic value stack `yyvs10'

	yyvsp10: INTEGER
			-- Top of semantic value stack `yyvs10'

	yyspecial_routines10: KL_SPECIAL_ROUTINES [EWG_C_PHASE_1_TYPE_SPECIFIER]
			-- Routines that ought to be in SPECIAL [EWG_C_PHASE_1_TYPE_SPECIFIER]

	yyvs11: SPECIAL [EWG_C_PHASE_1_STORAGE_CLASS_SPECIFIERS]
			-- Stack for semantic values of type EWG_C_PHASE_1_STORAGE_CLASS_SPECIFIERS

	yyvsc11: INTEGER
			-- Capacity of semantic value stack `yyvs11'

	yyvsp11: INTEGER
			-- Top of semantic value stack `yyvs11'

	yyspecial_routines11: KL_SPECIAL_ROUTINES [EWG_C_PHASE_1_STORAGE_CLASS_SPECIFIERS]
			-- Routines that ought to be in SPECIAL [EWG_C_PHASE_1_STORAGE_CLASS_SPECIFIERS]

	yyvs12: SPECIAL [BOOLEAN]
			-- Stack for semantic values of type BOOLEAN

	yyvsc12: INTEGER
			-- Capacity of semantic value stack `yyvs12'

	yyvsp12: INTEGER
			-- Top of semantic value stack `yyvs12'

	yyspecial_routines12: KL_SPECIAL_ROUTINES [BOOLEAN]
			-- Routines that ought to be in SPECIAL [BOOLEAN]

	yyvs13: SPECIAL [DS_LINKED_LIST [EWG_C_PHASE_1_DECLARATION]]
			-- Stack for semantic values of type DS_LINKED_LIST [EWG_C_PHASE_1_DECLARATION]

	yyvsc13: INTEGER
			-- Capacity of semantic value stack `yyvs13'

	yyvsp13: INTEGER
			-- Top of semantic value stack `yyvs13'

	yyspecial_routines13: KL_SPECIAL_ROUTINES [DS_LINKED_LIST [EWG_C_PHASE_1_DECLARATION]]
			-- Routines that ought to be in SPECIAL [DS_LINKED_LIST [EWG_C_PHASE_1_DECLARATION]]

	yyvs14: SPECIAL [DS_LINKED_LIST [EWG_C_PHASE_1_POINTER]]
			-- Stack for semantic values of type DS_LINKED_LIST [EWG_C_PHASE_1_POINTER]

	yyvsc14: INTEGER
			-- Capacity of semantic value stack `yyvs14'

	yyvsp14: INTEGER
			-- Top of semantic value stack `yyvs14'

	yyspecial_routines14: KL_SPECIAL_ROUTINES [DS_LINKED_LIST [EWG_C_PHASE_1_POINTER]]
			-- Routines that ought to be in SPECIAL [DS_LINKED_LIST [EWG_C_PHASE_1_POINTER]]

	yyvs15: SPECIAL [EWG_C_PHASE_1_PARAMETER_TYPE_LIST]
			-- Stack for semantic values of type EWG_C_PHASE_1_PARAMETER_TYPE_LIST

	yyvsc15: INTEGER
			-- Capacity of semantic value stack `yyvs15'

	yyvsp15: INTEGER
			-- Top of semantic value stack `yyvs15'

	yyspecial_routines15: KL_SPECIAL_ROUTINES [EWG_C_PHASE_1_PARAMETER_TYPE_LIST]
			-- Routines that ought to be in SPECIAL [EWG_C_PHASE_1_PARAMETER_TYPE_LIST]

	yyvs16: SPECIAL [DS_LINKED_LIST [INTEGER]]
			-- Stack for semantic values of type DS_LINKED_LIST [INTEGER]

	yyvsc16: INTEGER
			-- Capacity of semantic value stack `yyvs16'

	yyvsp16: INTEGER
			-- Top of semantic value stack `yyvs16'

	yyspecial_routines16: KL_SPECIAL_ROUTINES [DS_LINKED_LIST [INTEGER]]
			-- Routines that ought to be in SPECIAL [DS_LINKED_LIST [INTEGER]]

	yyvs17: SPECIAL [INTEGER]
			-- Stack for semantic values of type INTEGER

	yyvsc17: INTEGER
			-- Capacity of semantic value stack `yyvs17'

	yyvsp17: INTEGER
			-- Top of semantic value stack `yyvs17'

	yyspecial_routines17: KL_SPECIAL_ROUTINES [INTEGER]
			-- Routines that ought to be in SPECIAL [INTEGER]

feature {NONE} -- Constants

	yyFinal: INTEGER = 358
			-- Termination state id

	yyFlag: INTEGER = -32768
			-- Most negative INTEGER

	yyNtbase: INTEGER = 96
			-- Number of tokens

	yyLast: INTEGER = 1311
			-- Upper bound of `yytable' and `yycheck'

	yyMax_token: INTEGER = 326
			-- Maximum token id
			-- (upper bound of `yytranslate'.)

	yyNsyms: INTEGER = 167
			-- Number of symbols
			-- (terminal and nonterminal)

feature -- User-defined features



feature

end
