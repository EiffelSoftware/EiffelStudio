note

	description: "Eiffel inheritance clause parser"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_INHERITANCE_CLAUSE_PARSER

inherit
	CODE_INHERITANCE_CLAUSE_PARSER_SKELETON

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
		end

	yy_push_last_value (yychar1: INTEGER)
			-- Push semantic value associated with token `last_token'
			-- (with internal id `yychar1') on top of corresponding
			-- value stack.
		do
			yyvsp1 := yyvsp1 + 1
			if yyvsp1 >= yyvsc1 then
				debug ("GEYACC")
					std.error.put_line ("Resize yyvs1")
				end
				yyvsc1 := yyvsc1 + yyInitial_yyvs_size
				yyvs1 := yyspecial_routines1.aliased_resized_area (yyvs1, yyvsc1)
			end
			yyspecial_routines1.force (yyvs1, last_detachable_any_value, yyvsp1)
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
		do
			inspect yy_act
			when 1 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_1
			when 2 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_2
			when 3 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_3
			when 4 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_4
			when 5 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_5
			when 6 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_6
			when 7 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_7
			when 8 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_8
			when 9 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_9
			when 10 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_10
			when 11 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_11
			when 12 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_12
			when 13 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_13
			when 14 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_14
			when 15 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_15
			when 16 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_16
			when 17 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_17
			when 18 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_18
			when 19 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_19
			when 20 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_20
			when 21 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_21
			when 22 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_22
			when 23 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_23
			when 24 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_24
			when 25 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_25
			when 26 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_26
			when 27 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_27
			when 28 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_28
			when 29 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_29
			when 30 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_30
			when 31 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_31
			when 32 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_32
			when 33 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_33
			when 34 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_34
			when 35 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_35
			when 36 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_36
			when 37 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_37
			when 38 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_38
			when 39 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_39
			when 40 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_40
			when 41 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_41
			when 42 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_42
			when 43 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_43
			when 44 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_44
			when 45 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_45
			when 46 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_46
			when 47 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_47
			when 48 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_48
			when 49 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_49
			when 50 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_50
			when 51 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_51
			when 52 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_52
			when 53 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_53
			when 54 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_54
			when 55 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_55
			when 56 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_56
			when 57 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_57
			when 58 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_58
			when 59 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_59
			when 60 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_60
			when 61 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_61
			when 62 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_62
			when 63 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_63
			when 64 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_64
			when 65 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_65
			when 66 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_66
			when 67 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_67
			when 68 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_68
			when 69 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_69
			when 70 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_70
			when 71 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_71
			when 72 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_72
			when 73 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_73
			when 74 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_74
			when 75 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_75
			when 76 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_76
			when 77 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_77
			when 78 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_78
			when 79 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_79
			when 80 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_80
			when 81 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_81
			when 82 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_82
			when 83 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_83
			when 84 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_84
			when 85 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_85
			when 86 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_86
			when 87 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_87
			when 88 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_88
			when 89 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_89
			when 90 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_90
			when 91 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_91
			when 92 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_92
			when 93 then
					--|#line <not available> "inheritance_clause.y"
				yy_do_action_93
			else
				debug ("GEYACC")
					std.error.put_string ("Error in parser: unknown rule id: ")
					std.error.put_integer (yy_act)
					std.error.put_new_line
				end
				abort
			end
		end

	yy_do_action_1
			--|#line <not available> "inheritance_clause.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

parents := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp2 := yyvsp2 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
		end

	yy_do_action_2
			--|#line <not available> "inheritance_clause.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

parents := create {ARRAYED_LIST [CODE_SNIPPET_PARENT]}.make (0) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
		end

	yy_do_action_3
			--|#line <not available> "inheritance_clause.y"
		local
			yyval2: LIST [CODE_SNIPPET_PARENT]
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

				yyval2 := create {ARRAYED_LIST [CODE_SNIPPET_PARENT]}.make (Initial_parent_list_size)
				yyval2.extend (yyvs3.item (yyvsp3))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp2 := yyvsp2 + 1
	yyvsp3 := yyvsp3 -1
	if yyvsp2 >= yyvsc2 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs2")
		end
		yyvsc2 := yyvsc2 + yyInitial_yyvs_size
		yyvs2 := yyspecial_routines2.aliased_resized_area (yyvs2, yyvsc2)
	end
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
		end

	yy_do_action_4
			--|#line <not available> "inheritance_clause.y"
		local
			yyval2: LIST [CODE_SNIPPET_PARENT]
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

				yyval2 := yyvs2.item (yyvsp2)
				yyval2.extend (yyvs3.item (yyvsp3))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp3 := yyvsp3 -1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
		end

	yy_do_action_5
			--|#line <not available> "inheritance_clause.y"
		local
			yyval3: CODE_SNIPPET_PARENT
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

yyval3 := yyvs3.item (yyvsp3) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines3.force (yyvs3, yyval3, yyvsp3)
end
		end

	yy_do_action_6
			--|#line <not available> "inheritance_clause.y"
		local
			yyval3: CODE_SNIPPET_PARENT
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

yyval3 := yyvs3.item (yyvsp3) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyspecial_routines3.force (yyvs3, yyval3, yyvsp3)
end
		end

	yy_do_action_7
			--|#line <not available> "inheritance_clause.y"
		local
			yyval3: CODE_SNIPPET_PARENT
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

				yyval3 := create {CODE_SNIPPET_PARENT}.make (yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4), Void, Void, Void, Void, Void)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp3 := yyvsp3 + 1
	yyvsp4 := yyvsp4 -2
	if yyvsp3 >= yyvsc3 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs3")
		end
		yyvsc3 := yyvsc3 + yyInitial_yyvs_size
		yyvs3 := yyspecial_routines3.aliased_resized_area (yyvs3, yyvsc3)
	end
	yyspecial_routines3.force (yyvs3, yyval3, yyvsp3)
end
		end

	yy_do_action_8
			--|#line <not available> "inheritance_clause.y"
		local
			yyval3: CODE_SNIPPET_PARENT
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

				yyval3 := create {CODE_SNIPPET_PARENT}.make (yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4), yyvs6.item (yyvsp6), yyvs8.item (yyvsp8), yyvs9.item (yyvsp9), yyvs10.item (yyvsp10), yyvs11.item (yyvsp11))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 8
	yyvsp3 := yyvsp3 + 1
	yyvsp4 := yyvsp4 -2
	yyvsp6 := yyvsp6 -1
	yyvsp8 := yyvsp8 -1
	yyvsp9 := yyvsp9 -1
	yyvsp10 := yyvsp10 -1
	yyvsp11 := yyvsp11 -1
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
		end

	yy_do_action_9
			--|#line <not available> "inheritance_clause.y"
		local
			yyval3: CODE_SNIPPET_PARENT
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

				yyval3 := create {CODE_SNIPPET_PARENT}.make (yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4), Void, yyvs8.item (yyvsp8), yyvs9.item (yyvsp9), yyvs10.item (yyvsp10), yyvs11.item (yyvsp11))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp3 := yyvsp3 + 1
	yyvsp4 := yyvsp4 -2
	yyvsp8 := yyvsp8 -1
	yyvsp9 := yyvsp9 -1
	yyvsp10 := yyvsp10 -1
	yyvsp11 := yyvsp11 -1
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
		end

	yy_do_action_10
			--|#line <not available> "inheritance_clause.y"
		local
			yyval3: CODE_SNIPPET_PARENT
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

				yyval3 := create {CODE_SNIPPET_PARENT}.make (yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4), Void, Void, yyvs9.item (yyvsp9), yyvs10.item (yyvsp10), yyvs11.item (yyvsp11))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp3 := yyvsp3 + 1
	yyvsp4 := yyvsp4 -2
	yyvsp9 := yyvsp9 -1
	yyvsp10 := yyvsp10 -1
	yyvsp11 := yyvsp11 -1
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
		end

	yy_do_action_11
			--|#line <not available> "inheritance_clause.y"
		local
			yyval3: CODE_SNIPPET_PARENT
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

				yyval3 := create {CODE_SNIPPET_PARENT}.make (yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4), Void, Void, Void, yyvs10.item (yyvsp10), yyvs11.item (yyvsp11))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp3 := yyvsp3 + 1
	yyvsp4 := yyvsp4 -2
	yyvsp10 := yyvsp10 -1
	yyvsp11 := yyvsp11 -1
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
		end

	yy_do_action_12
			--|#line <not available> "inheritance_clause.y"
		local
			yyval3: CODE_SNIPPET_PARENT
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

				yyval3 := create {CODE_SNIPPET_PARENT}.make (yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4), Void, Void, Void, Void, yyvs11.item (yyvsp11))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp3 := yyvsp3 + 1
	yyvsp4 := yyvsp4 -2
	yyvsp11 := yyvsp11 -1
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
		end

	yy_do_action_13
			--|#line <not available> "inheritance_clause.y"
		local
			yyval3: CODE_SNIPPET_PARENT
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

				yyval3 := create {CODE_SNIPPET_PARENT}.make (yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4), Void, Void, Void, Void, Void)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp3 := yyvsp3 + 1
	yyvsp4 := yyvsp4 -2
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
		end

	yy_do_action_14
			--|#line <not available> "inheritance_clause.y"
		local
			yyval4: STRING
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

yyval4 := yyvs4.item (yyvsp4) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
		end

	yy_do_action_15
			--|#line <not available> "inheritance_clause.y"
		local
			yyval4: STRING
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

yyval4 := yyvs4.item (yyvsp4) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
		end

	yy_do_action_16
			--|#line <not available> "inheritance_clause.y"
		local
			yyval4: STRING
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

				yyval4 := create {STRING}.make (64)
				yyval4.append ("expanded ")
				yyval4.append (yyvs4.item (yyvsp4 - 1))
				if yyvs4.item (yyvsp4) /= Void then
					yyval4.append (yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
		end

	yy_do_action_17
			--|#line <not available> "inheritance_clause.y"
		local
			yyval4: STRING
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

				yyval4 := create {STRING}.make (64)
				yyval4.append ("separate ")
				yyval4.append (yyvs4.item (yyvsp4 - 1))
				if yyvs4.item (yyvsp4) /= Void then
					yyval4.append (yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
		end

	yy_do_action_18
			--|#line <not available> "inheritance_clause.y"
		local
			yyval4: STRING
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

				yyval4 := create {STRING}.make (yyvs4.item (yyvsp4).count + 4)
				yyval4.append ("BIT ")
				yyval4.append (yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
		end

	yy_do_action_19
			--|#line <not available> "inheritance_clause.y"
		local
			yyval4: STRING
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

				yyval4 := create {STRING}.make (yyvs4.item (yyvsp4).count + 4)
				yyval4.append ("BIT ")
				yyval4.append (yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
		end

	yy_do_action_20
			--|#line <not available> "inheritance_clause.y"
		local
			yyval4: STRING
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

				yyval4 := create {STRING}.make (yyvs4.item (yyvsp4).count + 5)
				yyval4.append ("like ")
				yyval4.append (yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
		end

	yy_do_action_21
			--|#line <not available> "inheritance_clause.y"
		local
			yyval4: STRING
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

yyval4 := "like Current" 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 + 1
	yyvsp1 := yyvsp1 -2
	if yyvsp4 >= yyvsc4 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs4")
		end
		yyvsc4 := yyvsc4 + yyInitial_yyvs_size
		yyvs4 := yyspecial_routines4.aliased_resized_area (yyvs4, yyvsc4)
	end
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
		end

	yy_do_action_22
			--|#line <not available> "inheritance_clause.y"
		local
			yyval4: STRING
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

				yyval4 := yyvs4.item (yyvsp4 - 1)
				if yyvs4.item (yyvsp4) /= Void then
					yyval4.append (yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
		end

	yy_do_action_23
			--|#line <not available> "inheritance_clause.y"
		local
			yyval4: STRING
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp4 := yyvsp4 + 1
	if yyvsp4 >= yyvsc4 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs4")
		end
		yyvsc4 := yyvsc4 + yyInitial_yyvs_size
		yyvs4 := yyspecial_routines4.aliased_resized_area (yyvs4, yyvsc4)
	end
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
		end

	yy_do_action_24
			--|#line <not available> "inheritance_clause.y"
		local
			yyval4: STRING
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 + 1
	yyvsp1 := yyvsp1 -2
	if yyvsp4 >= yyvsc4 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs4")
		end
		yyvsc4 := yyvsc4 + yyInitial_yyvs_size
		yyvs4 := yyspecial_routines4.aliased_resized_area (yyvs4, yyvsc4)
	end
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
		end

	yy_do_action_25
			--|#line <not available> "inheritance_clause.y"
		local
			yyval4: STRING
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

				yyval4 := create {STRING}.make (yyvs4.item (yyvsp4).count + 2)
				yyval4.append_character ('[')
				yyval4.append (yyvs4.item (yyvsp4))
				yyval4.append_character (']')
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
		end

	yy_do_action_26
			--|#line <not available> "inheritance_clause.y"
		local
			yyval4: STRING
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

yyval4 := yyvs4.item (yyvsp4) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
		end

	yy_do_action_27
			--|#line <not available> "inheritance_clause.y"
		local
			yyval4: STRING
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

				yyval4 := yyvs4.item (yyvsp4 - 1)
				yyval4.append (", ")
				yyval4.append (yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
		end

	yy_do_action_28
			--|#line <not available> "inheritance_clause.y"
		local
			yyval5: LIST [STRING]
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

				yyval5 := create {ARRAYED_LIST [STRING]}.make (1)
				yyval5.extend ("{NONE}")
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp5 := yyvsp5 + 1
	yyvsp1 := yyvsp1 -2
	if yyvsp5 >= yyvsc5 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs5")
		end
		yyvsc5 := yyvsc5 + yyInitial_yyvs_size
		yyvs5 := yyspecial_routines5.aliased_resized_area (yyvs5, yyvsc5)
	end
	yyspecial_routines5.force (yyvs5, yyval5, yyvsp5)
end
		end

	yy_do_action_29
			--|#line <not available> "inheritance_clause.y"
		local
			yyval5: LIST [STRING]
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

yyval5 := yyvs5.item (yyvsp5) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyspecial_routines5.force (yyvs5, yyval5, yyvsp5)
end
		end

	yy_do_action_30
			--|#line <not available> "inheritance_clause.y"
		local
			yyval5: LIST [STRING]
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

				yyval5 := create {ARRAYED_LIST [STRING]}.make (1)
				yyval5.extend (yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp5 := yyvsp5 + 1
	yyvsp4 := yyvsp4 -1
	if yyvsp5 >= yyvsc5 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs5")
		end
		yyvsc5 := yyvsc5 + yyInitial_yyvs_size
		yyvs5 := yyspecial_routines5.aliased_resized_area (yyvs5, yyvsc5)
	end
	yyspecial_routines5.force (yyvs5, yyval5, yyvsp5)
end
		end

	yy_do_action_31
			--|#line <not available> "inheritance_clause.y"
		local
			yyval5: LIST [STRING]
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

				yyval5 := yyvs5.item (yyvsp5)
				yyval5.extend (yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp4 := yyvsp4 -1
	yyspecial_routines5.force (yyvs5, yyval5, yyvsp5)
end
		end

	yy_do_action_32
			--|#line <not available> "inheritance_clause.y"
		local
			yyval6: LIST [CODE_SNIPPET_RENAME_CLAUSE]
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp6 := yyvsp6 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp6 >= yyvsc6 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs6")
		end
		yyvsc6 := yyvsc6 + yyInitial_yyvs_size
		yyvs6 := yyspecial_routines6.aliased_resized_area (yyvs6, yyvsc6)
	end
	yyspecial_routines6.force (yyvs6, yyval6, yyvsp6)
end
		end

	yy_do_action_33
			--|#line <not available> "inheritance_clause.y"
		local
			yyval6: LIST [CODE_SNIPPET_RENAME_CLAUSE]
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

yyval6 := yyvs6.item (yyvsp6) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyspecial_routines6.force (yyvs6, yyval6, yyvsp6)
end
		end

	yy_do_action_34
			--|#line <not available> "inheritance_clause.y"
		local
			yyval6: LIST [CODE_SNIPPET_RENAME_CLAUSE]
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

				yyval6 := create {ARRAYED_LIST [CODE_SNIPPET_RENAME_CLAUSE]}.make (Initial_clause_list_size)
				yyval6.extend (yyvs7.item (yyvsp7))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp6 := yyvsp6 + 1
	yyvsp7 := yyvsp7 -1
	if yyvsp6 >= yyvsc6 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs6")
		end
		yyvsc6 := yyvsc6 + yyInitial_yyvs_size
		yyvs6 := yyspecial_routines6.aliased_resized_area (yyvs6, yyvsc6)
	end
	yyspecial_routines6.force (yyvs6, yyval6, yyvsp6)
end
		end

	yy_do_action_35
			--|#line <not available> "inheritance_clause.y"
		local
			yyval6: LIST [CODE_SNIPPET_RENAME_CLAUSE]
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

				yyval6 := yyvs6.item (yyvsp6)
				yyval6.extend (yyvs7.item (yyvsp7))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp7 := yyvsp7 -1
	yyspecial_routines6.force (yyvs6, yyval6, yyvsp6)
end
		end

	yy_do_action_36
			--|#line <not available> "inheritance_clause.y"
		local
			yyval7: CODE_SNIPPET_RENAME_CLAUSE
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

				yyval7 := create {CODE_SNIPPET_RENAME_CLAUSE}.make (yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp7 := yyvsp7 + 1
	yyvsp4 := yyvsp4 -2
	yyvsp1 := yyvsp1 -1
	if yyvsp7 >= yyvsc7 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs7")
		end
		yyvsc7 := yyvsc7 + yyInitial_yyvs_size
		yyvs7 := yyspecial_routines7.aliased_resized_area (yyvs7, yyvsc7)
	end
	yyspecial_routines7.force (yyvs7, yyval7, yyvsp7)
end
		end

	yy_do_action_37
			--|#line <not available> "inheritance_clause.y"
		local
			yyval8: LIST [CODE_SNIPPET_EXPORT_CLAUSE]
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp8 := yyvsp8 + 1
	if yyvsp8 >= yyvsc8 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs8")
		end
		yyvsc8 := yyvsc8 + yyInitial_yyvs_size
		yyvs8 := yyspecial_routines8.aliased_resized_area (yyvs8, yyvsc8)
	end
	yyspecial_routines8.force (yyvs8, yyval8, yyvsp8)
end
		end

	yy_do_action_38
			--|#line <not available> "inheritance_clause.y"
		local
			yyval8: LIST [CODE_SNIPPET_EXPORT_CLAUSE]
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

yyval8 := yyvs8.item (yyvsp8) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines8.force (yyvs8, yyval8, yyvsp8)
end
		end

	yy_do_action_39
			--|#line <not available> "inheritance_clause.y"
		local
			yyval8: LIST [CODE_SNIPPET_EXPORT_CLAUSE]
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

				if yyvs8.item (yyvsp8) = Void or else yyvs8.item (yyvsp8).is_empty then
					yyval8 := Void
				else
					yyval8 := yyvs8.item (yyvsp8)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyspecial_routines8.force (yyvs8, yyval8, yyvsp8)
end
		end

	yy_do_action_40
			--|#line <not available> "inheritance_clause.y"
		local
			yyval8: LIST [CODE_SNIPPET_EXPORT_CLAUSE]
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp8 := yyvsp8 + 1
	yyvsp1 := yyvsp1 -2
	if yyvsp8 >= yyvsc8 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs8")
		end
		yyvsc8 := yyvsc8 + yyInitial_yyvs_size
		yyvs8 := yyspecial_routines8.aliased_resized_area (yyvs8, yyvsc8)
	end
	yyspecial_routines8.force (yyvs8, yyval8, yyvsp8)
end
		end

	yy_do_action_41
			--|#line <not available> "inheritance_clause.y"
		local
			yyval8: LIST [CODE_SNIPPET_EXPORT_CLAUSE]
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

yyval8 := yyvs8.item (yyvsp8) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines8.force (yyvs8, yyval8, yyvsp8)
end
		end

	yy_do_action_42
			--|#line <not available> "inheritance_clause.y"
		local
			yyval8: LIST [CODE_SNIPPET_EXPORT_CLAUSE]
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

				yyval8 := yyvs8.item (yyvsp8 - 1)
				if yyvs8.item (yyvsp8 - 1) /= Void and yyvs8.item (yyvsp8) /= Void then
					yyval8.append (yyvs8.item (yyvsp8))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp8 := yyvsp8 -1
	yyspecial_routines8.force (yyvs8, yyval8, yyvsp8)
end
		end

	yy_do_action_43
			--|#line <not available> "inheritance_clause.y"
		local
			yyval8: LIST [CODE_SNIPPET_EXPORT_CLAUSE]
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

				if yyvs5.item (yyvsp5) /= Void then
					yyval8 := create {ARRAYED_LIST [CODE_SNIPPET_EXPORT_CLAUSE]}.make (yyvs5.item (yyvsp5).count)
					from
						yyvs5.item (yyvsp5).start
					until
						yyvs5.item (yyvsp5).after
					loop
						yyval8.extend (create {CODE_SNIPPET_EXPORT_CLAUSE}.make (yyvs5.item (yyvsp5).item, yyvs5.item (yyvsp5 - 1)))
						yyvs5.item (yyvsp5).forth
					end
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp8 := yyvsp8 + 1
	yyvsp5 := yyvsp5 -2
	yyvsp1 := yyvsp1 -1
	if yyvsp8 >= yyvsc8 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs8")
		end
		yyvsc8 := yyvsc8 + yyInitial_yyvs_size
		yyvs8 := yyspecial_routines8.aliased_resized_area (yyvs8, yyvsc8)
	end
	yyspecial_routines8.force (yyvs8, yyval8, yyvsp8)
end
		end

	yy_do_action_44
			--|#line <not available> "inheritance_clause.y"
		local
			yyval5: LIST [STRING]
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp5 := yyvsp5 + 1
	if yyvsp5 >= yyvsc5 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs5")
		end
		yyvsc5 := yyvsc5 + yyInitial_yyvs_size
		yyvs5 := yyspecial_routines5.aliased_resized_area (yyvs5, yyvsc5)
	end
	yyspecial_routines5.force (yyvs5, yyval5, yyvsp5)
end
		end

	yy_do_action_45
			--|#line <not available> "inheritance_clause.y"
		local
			yyval5: LIST [STRING]
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

				yyval5 := create {ARRAYED_LIST [STRING]}.make (1)
				yyval5.extend ("all")
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp5 := yyvsp5 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp5 >= yyvsc5 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs5")
		end
		yyvsc5 := yyvsc5 + yyInitial_yyvs_size
		yyvs5 := yyspecial_routines5.aliased_resized_area (yyvs5, yyvsc5)
	end
	yyspecial_routines5.force (yyvs5, yyval5, yyvsp5)
end
		end

	yy_do_action_46
			--|#line <not available> "inheritance_clause.y"
		local
			yyval5: LIST [STRING]
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

yyval5 := yyvs5.item (yyvsp5) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines5.force (yyvs5, yyval5, yyvsp5)
end
		end

	yy_do_action_47
			--|#line <not available> "inheritance_clause.y"
		local
			yyval5: LIST [STRING]
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

				yyval5 := create {ARRAYED_LIST [STRING]}.make (Initial_feature_list_size)
				yyval5.extend (yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp5 := yyvsp5 + 1
	yyvsp4 := yyvsp4 -1
	if yyvsp5 >= yyvsc5 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs5")
		end
		yyvsc5 := yyvsc5 + yyInitial_yyvs_size
		yyvs5 := yyspecial_routines5.aliased_resized_area (yyvs5, yyvsc5)
	end
	yyspecial_routines5.force (yyvs5, yyval5, yyvsp5)
end
		end

	yy_do_action_48
			--|#line <not available> "inheritance_clause.y"
		local
			yyval5: LIST [STRING]
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

				yyval5 := yyvs5.item (yyvsp5)
				yyval5.extend (yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp4 := yyvsp4 -1
	yyspecial_routines5.force (yyvs5, yyval5, yyvsp5)
end
		end

	yy_do_action_49
			--|#line <not available> "inheritance_clause.y"
		local
			yyval9: LIST [CODE_SNIPPET_UNDEFINE_CLAUSE]
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp9 := yyvsp9 + 1
	if yyvsp9 >= yyvsc9 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs9")
		end
		yyvsc9 := yyvsc9 + yyInitial_yyvs_size
		yyvs9 := yyspecial_routines9.aliased_resized_area (yyvs9, yyvsc9)
	end
	yyspecial_routines9.force (yyvs9, yyval9, yyvsp9)
end
		end

	yy_do_action_50
			--|#line <not available> "inheritance_clause.y"
		local
			yyval9: LIST [CODE_SNIPPET_UNDEFINE_CLAUSE]
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

yyval9 := yyvs9.item (yyvsp9) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines9.force (yyvs9, yyval9, yyvsp9)
end
		end

	yy_do_action_51
			--|#line <not available> "inheritance_clause.y"
		local
			yyval9: LIST [CODE_SNIPPET_UNDEFINE_CLAUSE]
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp9 := yyvsp9 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp9 >= yyvsc9 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs9")
		end
		yyvsc9 := yyvsc9 + yyInitial_yyvs_size
		yyvs9 := yyspecial_routines9.aliased_resized_area (yyvs9, yyvsc9)
	end
	yyspecial_routines9.force (yyvs9, yyval9, yyvsp9)
end
		end

	yy_do_action_52
			--|#line <not available> "inheritance_clause.y"
		local
			yyval9: LIST [CODE_SNIPPET_UNDEFINE_CLAUSE]
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

				yyval9 := create {ARRAYED_LIST [CODE_SNIPPET_UNDEFINE_CLAUSE]}.make (yyvs5.item (yyvsp5).count)
				from
					yyvs5.item (yyvsp5).start
				until
					yyvs5.item (yyvsp5).after
				loop
					yyval9.extend (create {CODE_SNIPPET_UNDEFINE_CLAUSE}.make (yyvs5.item (yyvsp5).item))
					yyvs5.item (yyvsp5).forth
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp9 := yyvsp9 + 1
	yyvsp1 := yyvsp1 -1
	yyvsp5 := yyvsp5 -1
	if yyvsp9 >= yyvsc9 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs9")
		end
		yyvsc9 := yyvsc9 + yyInitial_yyvs_size
		yyvs9 := yyspecial_routines9.aliased_resized_area (yyvs9, yyvsc9)
	end
	yyspecial_routines9.force (yyvs9, yyval9, yyvsp9)
end
		end

	yy_do_action_53
			--|#line <not available> "inheritance_clause.y"
		local
			yyval10: LIST [CODE_SNIPPET_REDEFINE_CLAUSE]
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp10 := yyvsp10 + 1
	if yyvsp10 >= yyvsc10 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs10")
		end
		yyvsc10 := yyvsc10 + yyInitial_yyvs_size
		yyvs10 := yyspecial_routines10.aliased_resized_area (yyvs10, yyvsc10)
	end
	yyspecial_routines10.force (yyvs10, yyval10, yyvsp10)
end
		end

	yy_do_action_54
			--|#line <not available> "inheritance_clause.y"
		local
			yyval10: LIST [CODE_SNIPPET_REDEFINE_CLAUSE]
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

yyval10 := yyvs10.item (yyvsp10) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines10.force (yyvs10, yyval10, yyvsp10)
end
		end

	yy_do_action_55
			--|#line <not available> "inheritance_clause.y"
		local
			yyval10: LIST [CODE_SNIPPET_REDEFINE_CLAUSE]
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp10 := yyvsp10 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp10 >= yyvsc10 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs10")
		end
		yyvsc10 := yyvsc10 + yyInitial_yyvs_size
		yyvs10 := yyspecial_routines10.aliased_resized_area (yyvs10, yyvsc10)
	end
	yyspecial_routines10.force (yyvs10, yyval10, yyvsp10)
end
		end

	yy_do_action_56
			--|#line <not available> "inheritance_clause.y"
		local
			yyval10: LIST [CODE_SNIPPET_REDEFINE_CLAUSE]
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

				yyval10 := create {ARRAYED_LIST [CODE_SNIPPET_REDEFINE_CLAUSE]}.make (yyvs5.item (yyvsp5).count)
				from
					yyvs5.item (yyvsp5).start
				until
					yyvs5.item (yyvsp5).after
				loop
					yyval10.extend (create {CODE_SNIPPET_REDEFINE_CLAUSE}.make (yyvs5.item (yyvsp5).item))
					yyvs5.item (yyvsp5).forth
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp10 := yyvsp10 + 1
	yyvsp1 := yyvsp1 -1
	yyvsp5 := yyvsp5 -1
	if yyvsp10 >= yyvsc10 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs10")
		end
		yyvsc10 := yyvsc10 + yyInitial_yyvs_size
		yyvs10 := yyspecial_routines10.aliased_resized_area (yyvs10, yyvsc10)
	end
	yyspecial_routines10.force (yyvs10, yyval10, yyvsp10)
end
		end

	yy_do_action_57
			--|#line <not available> "inheritance_clause.y"
		local
			yyval11: LIST [CODE_SNIPPET_SELECT_CLAUSE]
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp11 := yyvsp11 + 1
	if yyvsp11 >= yyvsc11 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs11")
		end
		yyvsc11 := yyvsc11 + yyInitial_yyvs_size
		yyvs11 := yyspecial_routines11.aliased_resized_area (yyvs11, yyvsc11)
	end
	yyspecial_routines11.force (yyvs11, yyval11, yyvsp11)
end
		end

	yy_do_action_58
			--|#line <not available> "inheritance_clause.y"
		local
			yyval11: LIST [CODE_SNIPPET_SELECT_CLAUSE]
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

yyval11 := yyvs11.item (yyvsp11) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines11.force (yyvs11, yyval11, yyvsp11)
end
		end

	yy_do_action_59
			--|#line <not available> "inheritance_clause.y"
		local
			yyval11: LIST [CODE_SNIPPET_SELECT_CLAUSE]
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp11 := yyvsp11 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp11 >= yyvsc11 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs11")
		end
		yyvsc11 := yyvsc11 + yyInitial_yyvs_size
		yyvs11 := yyspecial_routines11.aliased_resized_area (yyvs11, yyvsc11)
	end
	yyspecial_routines11.force (yyvs11, yyval11, yyvsp11)
end
		end

	yy_do_action_60
			--|#line <not available> "inheritance_clause.y"
		local
			yyval11: LIST [CODE_SNIPPET_SELECT_CLAUSE]
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

				yyval11 := create {ARRAYED_LIST [CODE_SNIPPET_SELECT_CLAUSE]}.make (yyvs5.item (yyvsp5).count)
				from
					yyvs5.item (yyvsp5).start
				until
					yyvs5.item (yyvsp5).after
				loop
					yyval11.extend (create {CODE_SNIPPET_SELECT_CLAUSE}.make (yyvs5.item (yyvsp5).item))
					yyvs5.item (yyvsp5).forth
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp11 := yyvsp11 + 1
	yyvsp1 := yyvsp1 -1
	yyvsp5 := yyvsp5 -1
	if yyvsp11 >= yyvsc11 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs11")
		end
		yyvsc11 := yyvsc11 + yyInitial_yyvs_size
		yyvs11 := yyspecial_routines11.aliased_resized_area (yyvs11, yyvsc11)
	end
	yyspecial_routines11.force (yyvs11, yyval11, yyvsp11)
end
		end

	yy_do_action_61
			--|#line <not available> "inheritance_clause.y"
		local
			yyval4: STRING
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

yyval4 := yyvs4.item (yyvsp4) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
		end

	yy_do_action_62
			--|#line <not available> "inheritance_clause.y"
		local
			yyval4: STRING
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

yyval4 := yyvs4.item (yyvsp4) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
		end

	yy_do_action_63
			--|#line <not available> "inheritance_clause.y"
		local
			yyval4: STRING
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

yyval4 := yyvs4.item (yyvsp4) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
		end

	yy_do_action_64
			--|#line <not available> "inheritance_clause.y"
		local
			yyval4: STRING
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

yyval4 := yyvs4.item (yyvsp4) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
		end

	yy_do_action_65
			--|#line <not available> "inheritance_clause.y"
		local
			yyval4: STRING
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

yyval4 := yyvs4.item (yyvsp4) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
		end

	yy_do_action_66
			--|#line <not available> "inheritance_clause.y"
		local
			yyval4: STRING
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

yyval4 := "prefix %"-%"" 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp4 := yyvsp4 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp4 >= yyvsc4 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs4")
		end
		yyvsc4 := yyvsc4 + yyInitial_yyvs_size
		yyvs4 := yyspecial_routines4.aliased_resized_area (yyvs4, yyvsc4)
	end
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
		end

	yy_do_action_67
			--|#line <not available> "inheritance_clause.y"
		local
			yyval4: STRING
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

yyval4 := "prefix %"+%"" 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp4 := yyvsp4 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp4 >= yyvsc4 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs4")
		end
		yyvsc4 := yyvsc4 + yyInitial_yyvs_size
		yyvs4 := yyspecial_routines4.aliased_resized_area (yyvs4, yyvsc4)
	end
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
		end

	yy_do_action_68
			--|#line <not available> "inheritance_clause.y"
		local
			yyval4: STRING
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

yyval4 := "prefix %"not%"" 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp4 := yyvsp4 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp4 >= yyvsc4 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs4")
		end
		yyvsc4 := yyvsc4 + yyInitial_yyvs_size
		yyvs4 := yyspecial_routines4.aliased_resized_area (yyvs4, yyvsc4)
	end
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
		end

	yy_do_action_69
			--|#line <not available> "inheritance_clause.y"
		local
			yyval4: STRING
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

				yyval4 := create {STRING}.make (9 + token_buffer.count)
				yyval4.append ("prefix %"")
				yyval4.append (token_buffer.as_lower)
				yyval4.append_character ('"')
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp4 := yyvsp4 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp4 >= yyvsc4 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs4")
		end
		yyvsc4 := yyvsc4 + yyInitial_yyvs_size
		yyvs4 := yyspecial_routines4.aliased_resized_area (yyvs4, yyvsc4)
	end
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
		end

	yy_do_action_70
			--|#line <not available> "inheritance_clause.y"
		local
			yyval4: STRING
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

yyval4 := "infix %"<%"" 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp4 := yyvsp4 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp4 >= yyvsc4 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs4")
		end
		yyvsc4 := yyvsc4 + yyInitial_yyvs_size
		yyvs4 := yyspecial_routines4.aliased_resized_area (yyvs4, yyvsc4)
	end
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
		end

	yy_do_action_71
			--|#line <not available> "inheritance_clause.y"
		local
			yyval4: STRING
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

yyval4 := "infix %"<=%"" 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp4 := yyvsp4 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp4 >= yyvsc4 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs4")
		end
		yyvsc4 := yyvsc4 + yyInitial_yyvs_size
		yyvs4 := yyspecial_routines4.aliased_resized_area (yyvs4, yyvsc4)
	end
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
		end

	yy_do_action_72
			--|#line <not available> "inheritance_clause.y"
		local
			yyval4: STRING
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

yyval4 := "infix %">%"" 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp4 := yyvsp4 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp4 >= yyvsc4 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs4")
		end
		yyvsc4 := yyvsc4 + yyInitial_yyvs_size
		yyvs4 := yyspecial_routines4.aliased_resized_area (yyvs4, yyvsc4)
	end
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
		end

	yy_do_action_73
			--|#line <not available> "inheritance_clause.y"
		local
			yyval4: STRING
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

yyval4 := "infix %">=%"" 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp4 := yyvsp4 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp4 >= yyvsc4 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs4")
		end
		yyvsc4 := yyvsc4 + yyInitial_yyvs_size
		yyvs4 := yyspecial_routines4.aliased_resized_area (yyvs4, yyvsc4)
	end
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
		end

	yy_do_action_74
			--|#line <not available> "inheritance_clause.y"
		local
			yyval4: STRING
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

yyval4 := "infix %"-%"" 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp4 := yyvsp4 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp4 >= yyvsc4 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs4")
		end
		yyvsc4 := yyvsc4 + yyInitial_yyvs_size
		yyvs4 := yyspecial_routines4.aliased_resized_area (yyvs4, yyvsc4)
	end
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
		end

	yy_do_action_75
			--|#line <not available> "inheritance_clause.y"
		local
			yyval4: STRING
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

yyval4 := "infix %"+%"" 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp4 := yyvsp4 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp4 >= yyvsc4 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs4")
		end
		yyvsc4 := yyvsc4 + yyInitial_yyvs_size
		yyvs4 := yyspecial_routines4.aliased_resized_area (yyvs4, yyvsc4)
	end
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
		end

	yy_do_action_76
			--|#line <not available> "inheritance_clause.y"
		local
			yyval4: STRING
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

yyval4 := "infix %"*%"" 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp4 := yyvsp4 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp4 >= yyvsc4 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs4")
		end
		yyvsc4 := yyvsc4 + yyInitial_yyvs_size
		yyvs4 := yyspecial_routines4.aliased_resized_area (yyvs4, yyvsc4)
	end
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
		end

	yy_do_action_77
			--|#line <not available> "inheritance_clause.y"
		local
			yyval4: STRING
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

yyval4 := "infix %"/%"" 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp4 := yyvsp4 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp4 >= yyvsc4 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs4")
		end
		yyvsc4 := yyvsc4 + yyInitial_yyvs_size
		yyvs4 := yyspecial_routines4.aliased_resized_area (yyvs4, yyvsc4)
	end
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
		end

	yy_do_action_78
			--|#line <not available> "inheritance_clause.y"
		local
			yyval4: STRING
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

yyval4 := "infix %"\\%"" 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp4 := yyvsp4 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp4 >= yyvsc4 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs4")
		end
		yyvsc4 := yyvsc4 + yyInitial_yyvs_size
		yyvs4 := yyspecial_routines4.aliased_resized_area (yyvs4, yyvsc4)
	end
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
		end

	yy_do_action_79
			--|#line <not available> "inheritance_clause.y"
		local
			yyval4: STRING
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

yyval4 := "infix %"//%"" 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp4 := yyvsp4 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp4 >= yyvsc4 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs4")
		end
		yyvsc4 := yyvsc4 + yyInitial_yyvs_size
		yyvs4 := yyspecial_routines4.aliased_resized_area (yyvs4, yyvsc4)
	end
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
		end

	yy_do_action_80
			--|#line <not available> "inheritance_clause.y"
		local
			yyval4: STRING
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

yyval4 := "infix %"^%"" 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp4 := yyvsp4 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp4 >= yyvsc4 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs4")
		end
		yyvsc4 := yyvsc4 + yyInitial_yyvs_size
		yyvs4 := yyspecial_routines4.aliased_resized_area (yyvs4, yyvsc4)
	end
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
		end

	yy_do_action_81
			--|#line <not available> "inheritance_clause.y"
		local
			yyval4: STRING
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

yyval4 := "infix %"and%"" 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp4 := yyvsp4 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp4 >= yyvsc4 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs4")
		end
		yyvsc4 := yyvsc4 + yyInitial_yyvs_size
		yyvs4 := yyspecial_routines4.aliased_resized_area (yyvs4, yyvsc4)
	end
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
		end

	yy_do_action_82
			--|#line <not available> "inheritance_clause.y"
		local
			yyval4: STRING
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

yyval4 := "infix %"and then%"" 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp4 := yyvsp4 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp4 >= yyvsc4 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs4")
		end
		yyvsc4 := yyvsc4 + yyInitial_yyvs_size
		yyvs4 := yyspecial_routines4.aliased_resized_area (yyvs4, yyvsc4)
	end
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
		end

	yy_do_action_83
			--|#line <not available> "inheritance_clause.y"
		local
			yyval4: STRING
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

yyval4 := "infix %"implies%"" 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp4 := yyvsp4 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp4 >= yyvsc4 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs4")
		end
		yyvsc4 := yyvsc4 + yyInitial_yyvs_size
		yyvs4 := yyspecial_routines4.aliased_resized_area (yyvs4, yyvsc4)
	end
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
		end

	yy_do_action_84
			--|#line <not available> "inheritance_clause.y"
		local
			yyval4: STRING
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

yyval4 := "infix %"or%"" 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp4 := yyvsp4 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp4 >= yyvsc4 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs4")
		end
		yyvsc4 := yyvsc4 + yyInitial_yyvs_size
		yyvs4 := yyspecial_routines4.aliased_resized_area (yyvs4, yyvsc4)
	end
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
		end

	yy_do_action_85
			--|#line <not available> "inheritance_clause.y"
		local
			yyval4: STRING
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

yyval4 := "infix %"or else%"" 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp4 := yyvsp4 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp4 >= yyvsc4 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs4")
		end
		yyvsc4 := yyvsc4 + yyInitial_yyvs_size
		yyvs4 := yyspecial_routines4.aliased_resized_area (yyvs4, yyvsc4)
	end
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
		end

	yy_do_action_86
			--|#line <not available> "inheritance_clause.y"
		local
			yyval4: STRING
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

yyval4 := "infix %"xor%"" 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp4 := yyvsp4 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp4 >= yyvsc4 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs4")
		end
		yyvsc4 := yyvsc4 + yyInitial_yyvs_size
		yyvs4 := yyspecial_routines4.aliased_resized_area (yyvs4, yyvsc4)
	end
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
		end

	yy_do_action_87
			--|#line <not available> "inheritance_clause.y"
		local
			yyval4: STRING
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

				yyval4 := create {STRING}.make (8 + token_buffer.count)
				yyval4.append ("infix %"")
				yyval4.append (token_buffer.as_lower)
				yyval4.append_character ('"')
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp4 := yyvsp4 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp4 >= yyvsc4 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs4")
		end
		yyvsc4 := yyvsc4 + yyInitial_yyvs_size
		yyvs4 := yyspecial_routines4.aliased_resized_area (yyvs4, yyvsc4)
	end
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
		end

	yy_do_action_88
			--|#line <not available> "inheritance_clause.y"
		local
			yyval4: STRING
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

				yyval4 := token_buffer.twin
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp4 := yyvsp4 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp4 >= yyvsc4 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs4")
		end
		yyvsc4 := yyvsc4 + yyInitial_yyvs_size
		yyvs4 := yyspecial_routines4.aliased_resized_area (yyvs4, yyvsc4)
	end
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
		end

	yy_do_action_89
			--|#line <not available> "inheritance_clause.y"
		local
			yyval4: STRING
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

				yyval4 := token_buffer.twin
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 + 1
	yyvsp1 := yyvsp1 -2
	if yyvsp4 >= yyvsc4 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs4")
		end
		yyvsc4 := yyvsc4 + yyInitial_yyvs_size
		yyvs4 := yyspecial_routines4.aliased_resized_area (yyvs4, yyvsc4)
	end
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
		end

	yy_do_action_90
			--|#line <not available> "inheritance_clause.y"
		local
			yyval4: STRING
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

				yyval4 := token_buffer.twin
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 + 1
	yyvsp1 := yyvsp1 -2
	if yyvsp4 >= yyvsc4 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs4")
		end
		yyvsc4 := yyvsc4 + yyInitial_yyvs_size
		yyvs4 := yyspecial_routines4.aliased_resized_area (yyvs4, yyvsc4)
	end
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
		end

	yy_do_action_91
			--|#line <not available> "inheritance_clause.y"
		local
			yyval4: STRING
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end

yyval4 := token_buffer.twin 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp4 := yyvsp4 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp4 >= yyvsc4 then
		debug ("GEYACC")
			std.error.put_line ("Resize yyvs4")
		end
		yyvsc4 := yyvsc4 + yyInitial_yyvs_size
		yyvs4 := yyspecial_routines4.aliased_resized_area (yyvs4, yyvsc4)
	end
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
		end

	yy_do_action_92
			--|#line <not available> "inheritance_clause.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
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
		end

	yy_do_action_93
			--|#line <not available> "inheritance_clause.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
		end

	yy_do_error_action (yy_act: INTEGER)
			-- Execute error action.
		do
			inspect yy_act
			when 128 then
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
			create an_array.make_filled (0, 0, 302)
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

			   45,   46,   47, yyDummy>>,
			1, 103, 200)
		end

	yyr1_template: SPECIAL [INTEGER]
			-- Template for `yyr1'
		once
			Result := yyfixed_array (<<
			    0,   80,   80,   48,   48,   49,   49,   50,   50,   50,
			   50,   50,   50,   50,   61,   61,   60,   60,   60,   60,
			   60,   60,   59,   57,   57,   57,   58,   58,   63,   63,
			   66,   66,   67,   67,   68,   68,   69,   71,   71,   70,
			   70,   72,   72,   73,   64,   64,   64,   65,   65,   75,
			   75,   74,   74,   77,   77,   76,   76,   79,   79,   78,
			   78,   51,   51,   51,   52,   53,   55,   55,   55,   55,
			   54,   54,   54,   54,   54,   54,   54,   54,   54,   54,
			   54,   54,   54,   54,   54,   54,   54,   54,   56,   56,
			   56,   62,   81,   81, yyDummy>>)
		end

	yytypes1_template: SPECIAL [INTEGER]
			-- Template for `yytypes1'
		once
			Result := yyfixed_array (<<
			    1,    1,    1,    1,    2,    3,    3,    4,    1,    3,
			    1,    1,    4,    1,    1,    1,    1,    1,    4,    4,
			    4,    4,    4,    1,    1,    1,    1,    1,    1,    6,
			    8,    9,   10,   11,    1,    4,    1,    1,    1,    4,
			    4,    4,    4,    1,    1,    4,    1,    1,    4,    4,
			    4,    4,    5,    5,    4,    6,    7,    5,    1,    5,
			    8,    8,    1,    8,    8,    9,    9,   10,   10,   11,
			   11,    1,    1,    1,    4,    4,    4,    1,    1,    1,
			    1,    4,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,

			    4,    1,    1,    1,    1,    4,    5,    1,    5,    5,
			    8,    9,   10,   11,    1,    4,    4,    7,    1,    1,
			    1,   10,   11,    1,    4,   11,    1,    1,    1,    1,
			    1, yyDummy>>)
		end

	yytypes2_template: SPECIAL [INTEGER]
			-- Template for `yytypes2'
		once
			Result := yyfixed_array (<<
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1, yyDummy>>)
		end

	yydefact_template: SPECIAL [INTEGER]
			-- Template for `yydefact'
		once
			Result := yyfixed_array (<<
			    0,   92,   91,   93,    1,    3,    5,   23,    2,    4,
			    6,    0,    7,    0,    0,    0,   24,    0,    0,   14,
			   15,   26,   23,   51,   59,   32,   55,   92,   13,   37,
			   49,   53,   57,    0,   21,   20,    0,    0,   88,   18,
			   19,   23,   23,   25,    0,   22,    0,    0,   47,   62,
			   63,   61,   52,   60,    0,   33,   34,   56,    0,   44,
			   39,   41,   40,   38,   49,   50,   53,   54,   57,   58,
			    0,   12,   90,   89,   17,   16,   27,   69,   68,   67,
			   66,   65,   87,   86,   85,   84,   83,   82,   81,   80,
			   79,   78,   77,   76,   75,   74,   73,   72,   71,   70,

			   64,    0,    0,    0,   28,   30,    0,   45,   92,   46,
			   42,   53,   57,    0,   11,   48,   36,   35,   29,    0,
			   43,   57,    0,   10,   31,    0,    9,    8,    0,    0,
			    0, yyDummy>>)
		end

	yydefgoto_template: SPECIAL [INTEGER]
			-- Template for `yydefgoto'
		once
			Result := yyfixed_array (<<
			    4,    5,    6,   48,   49,   50,  100,   81,   39,   12,
			   18,   19,   20,   21,   51,   59,  108,   52,  106,   29,
			   55,   56,   30,   64,   60,   61,   65,   66,   67,   68,
			   69,   70,  128,    8, yyDummy>>)
		end

	yypact_template: SPECIAL [INTEGER]
			-- Template for `yypact'
		once
			Result := yyfixed_array (<<
			   97,   40, -32768, -32768,   44, -32768,  102,   89, -32768, -32768,
			 -32768,   14,   82,    5,   -2,   44, -32768,   44,   85, -32768,
			 -32768, -32768,   89,   35,   35,   35,   35,   36, -32768,   99,
			   71,   69,   31,   98, -32768, -32768,   81,   78, -32768, -32768,
			 -32768,   89,   89, -32768,    9, -32768,   50,   30, -32768, -32768,
			 -32768, -32768,   80,   80,   94,   96, -32768,   80,   70,   16,
			   73, -32768, -32768, -32768,   71, -32768,   69, -32768,   31, -32768,
			   79, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,

			 -32768,   35,   35,   35, -32768, -32768,   34, -32768,   83,   80,
			 -32768,   69,   31,   45, -32768, -32768, -32768, -32768, -32768,   44,
			 -32768,   31,   41, -32768, -32768,   38, -32768, -32768,   21,   17,
			 -32768, yyDummy>>)
		end

	yypgoto_template: SPECIAL [INTEGER]
			-- Template for `yypgoto'
		once
			Result := yyfixed_array (<<
			 -32768,  113, -32768,  -23, -32768, -32768, -32768, -32768, -32768,  -14,
			 -32768, -32768, -32768,   75,   -1, -32768, -32768,  -17, -32768, -32768,
			 -32768,   11,   87, -32768, -32768,   51,  103,   46,  101,  -60,
			  100,  -63, -32768,  -26, yyDummy>>)
		end

	yytable_template: SPECIAL [INTEGER]
			-- Template for `yytable'
		once
			Result := yyfixed_array (<<
			    7,   62,   54,    7,    2,  113,  112,   53,   45,   57,
			   22,    2,   35,   40,   41,    2,   42,  130,   17,  107,
			    2,  129,    2,   17,   38,   37,   36,   74,   75,   16,
			   34,   15,   14,   13,   47,   46,   15,   14,   13,  119,
			    3,    2,  109,   22,    3,  127,    2,   24,  126,  122,
			    2,  121,  123,   47,   46,  118,   58,  105,  125,   99,
			   98,   97,   96,   95,   94,   93,   92,   91,   90,   89,
			   88,   87,   86,   85,   84,   83,    2,   82,  115,  116,
			   54,   26,  120,   80,   79,  101,  114,    3,   23,   28,
			   44,  104,   27,   58,   26,   25,   78,   77,   24,   23,

			   43,  103,  102,   11,   73,   71,   10,   72,    1,   27,
			  111,  110,   33,   32,  117,   31,   63,    9,  124,   76, yyDummy>>)
		end

	yycheck_template: SPECIAL [INTEGER]
			-- Template for `yycheck'
		once
			Result := yyfixed_array (<<
			    1,   27,   25,    4,    6,   68,   66,   24,   22,   26,
			   11,    6,   13,   14,   15,    6,   17,    0,    9,    3,
			    6,    0,    6,    9,   26,   27,   28,   41,   42,   15,
			   25,   22,   23,   24,   18,   19,   22,   23,   24,    5,
			    4,    6,   59,   44,    4,    7,    6,   16,    7,  112,
			    6,  111,    7,   18,   19,   21,   20,   58,  121,   29,
			   30,   31,   32,   33,   34,   35,   36,   37,   38,   39,
			   40,   41,   42,   43,   44,   45,    6,   47,  101,  102,
			  103,   12,  108,   33,   34,    5,    7,    4,   17,    7,
			    5,   21,   10,   20,   12,   13,   46,   47,   16,   17,

			   15,    5,    8,   14,   26,    7,    4,   26,   11,   10,
			   64,   60,   12,   12,  103,   12,   29,    4,  119,   44, yyDummy>>)
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

	yyvs2: SPECIAL [LIST [CODE_SNIPPET_PARENT]]
			-- Stack for semantic values of type LIST [CODE_SNIPPET_PARENT]

	yyvsc2: INTEGER
			-- Capacity of semantic value stack `yyvs2'

	yyvsp2: INTEGER
			-- Top of semantic value stack `yyvs2'

	yyspecial_routines2: KL_SPECIAL_ROUTINES [LIST [CODE_SNIPPET_PARENT]]
			-- Routines that ought to be in SPECIAL [LIST [CODE_SNIPPET_PARENT]]

	yyvs3: SPECIAL [CODE_SNIPPET_PARENT]
			-- Stack for semantic values of type CODE_SNIPPET_PARENT

	yyvsc3: INTEGER
			-- Capacity of semantic value stack `yyvs3'

	yyvsp3: INTEGER
			-- Top of semantic value stack `yyvs3'

	yyspecial_routines3: KL_SPECIAL_ROUTINES [CODE_SNIPPET_PARENT]
			-- Routines that ought to be in SPECIAL [CODE_SNIPPET_PARENT]

	yyvs4: SPECIAL [STRING]
			-- Stack for semantic values of type STRING

	yyvsc4: INTEGER
			-- Capacity of semantic value stack `yyvs4'

	yyvsp4: INTEGER
			-- Top of semantic value stack `yyvs4'

	yyspecial_routines4: KL_SPECIAL_ROUTINES [STRING]
			-- Routines that ought to be in SPECIAL [STRING]

	yyvs5: SPECIAL [LIST [STRING]]
			-- Stack for semantic values of type LIST [STRING]

	yyvsc5: INTEGER
			-- Capacity of semantic value stack `yyvs5'

	yyvsp5: INTEGER
			-- Top of semantic value stack `yyvs5'

	yyspecial_routines5: KL_SPECIAL_ROUTINES [LIST [STRING]]
			-- Routines that ought to be in SPECIAL [LIST [STRING]]

	yyvs6: SPECIAL [LIST [CODE_SNIPPET_RENAME_CLAUSE]]
			-- Stack for semantic values of type LIST [CODE_SNIPPET_RENAME_CLAUSE]

	yyvsc6: INTEGER
			-- Capacity of semantic value stack `yyvs6'

	yyvsp6: INTEGER
			-- Top of semantic value stack `yyvs6'

	yyspecial_routines6: KL_SPECIAL_ROUTINES [LIST [CODE_SNIPPET_RENAME_CLAUSE]]
			-- Routines that ought to be in SPECIAL [LIST [CODE_SNIPPET_RENAME_CLAUSE]]

	yyvs7: SPECIAL [CODE_SNIPPET_RENAME_CLAUSE]
			-- Stack for semantic values of type CODE_SNIPPET_RENAME_CLAUSE

	yyvsc7: INTEGER
			-- Capacity of semantic value stack `yyvs7'

	yyvsp7: INTEGER
			-- Top of semantic value stack `yyvs7'

	yyspecial_routines7: KL_SPECIAL_ROUTINES [CODE_SNIPPET_RENAME_CLAUSE]
			-- Routines that ought to be in SPECIAL [CODE_SNIPPET_RENAME_CLAUSE]

	yyvs8: SPECIAL [LIST [CODE_SNIPPET_EXPORT_CLAUSE]]
			-- Stack for semantic values of type LIST [CODE_SNIPPET_EXPORT_CLAUSE]

	yyvsc8: INTEGER
			-- Capacity of semantic value stack `yyvs8'

	yyvsp8: INTEGER
			-- Top of semantic value stack `yyvs8'

	yyspecial_routines8: KL_SPECIAL_ROUTINES [LIST [CODE_SNIPPET_EXPORT_CLAUSE]]
			-- Routines that ought to be in SPECIAL [LIST [CODE_SNIPPET_EXPORT_CLAUSE]]

	yyvs9: SPECIAL [LIST [CODE_SNIPPET_UNDEFINE_CLAUSE]]
			-- Stack for semantic values of type LIST [CODE_SNIPPET_UNDEFINE_CLAUSE]

	yyvsc9: INTEGER
			-- Capacity of semantic value stack `yyvs9'

	yyvsp9: INTEGER
			-- Top of semantic value stack `yyvs9'

	yyspecial_routines9: KL_SPECIAL_ROUTINES [LIST [CODE_SNIPPET_UNDEFINE_CLAUSE]]
			-- Routines that ought to be in SPECIAL [LIST [CODE_SNIPPET_UNDEFINE_CLAUSE]]

	yyvs10: SPECIAL [LIST [CODE_SNIPPET_REDEFINE_CLAUSE]]
			-- Stack for semantic values of type LIST [CODE_SNIPPET_REDEFINE_CLAUSE]

	yyvsc10: INTEGER
			-- Capacity of semantic value stack `yyvs10'

	yyvsp10: INTEGER
			-- Top of semantic value stack `yyvs10'

	yyspecial_routines10: KL_SPECIAL_ROUTINES [LIST [CODE_SNIPPET_REDEFINE_CLAUSE]]
			-- Routines that ought to be in SPECIAL [LIST [CODE_SNIPPET_REDEFINE_CLAUSE]]

	yyvs11: SPECIAL [LIST [CODE_SNIPPET_SELECT_CLAUSE]]
			-- Stack for semantic values of type LIST [CODE_SNIPPET_SELECT_CLAUSE]

	yyvsc11: INTEGER
			-- Capacity of semantic value stack `yyvs11'

	yyvsp11: INTEGER
			-- Top of semantic value stack `yyvs11'

	yyspecial_routines11: KL_SPECIAL_ROUTINES [LIST [CODE_SNIPPET_SELECT_CLAUSE]]
			-- Routines that ought to be in SPECIAL [LIST [CODE_SNIPPET_SELECT_CLAUSE]]

feature {NONE} -- Constants

	yyFinal: INTEGER = 130
			-- Termination state id

	yyFlag: INTEGER = -32768
			-- Most negative INTEGER

	yyNtbase: INTEGER = 48
			-- Number of tokens

	yyLast: INTEGER = 119
			-- Upper bound of `yytable' and `yycheck'

	yyMax_token: INTEGER = 302
			-- Maximum token id
			-- (upper bound of `yytranslate'.)

	yyNsyms: INTEGER = 82
			-- Number of symbols
			-- (terminal and nonterminal)

feature -- User-defined features



end -- class CODE_INHERITANCE_CLAUSE_PARSER

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------
