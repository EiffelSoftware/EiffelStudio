indexing
	description: "External parsers"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class EXTERNAL_PARSER

inherit

	EXTERNAL_PARSER_SKELETON

	EXTERNAL_FACTORY
		export
			{NONE} all
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
		do
			inspect yy_act
			when 1 then
					--|#line <not available> "external.y"
				yy_do_action_1
			when 2 then
					--|#line <not available> "external.y"
				yy_do_action_2
			when 3 then
					--|#line <not available> "external.y"
				yy_do_action_3
			when 4 then
					--|#line <not available> "external.y"
				yy_do_action_4
			when 5 then
					--|#line <not available> "external.y"
				yy_do_action_5
			when 6 then
					--|#line <not available> "external.y"
				yy_do_action_6
			when 7 then
					--|#line <not available> "external.y"
				yy_do_action_7
			when 8 then
					--|#line <not available> "external.y"
				yy_do_action_8
			when 9 then
					--|#line <not available> "external.y"
				yy_do_action_9
			when 10 then
					--|#line <not available> "external.y"
				yy_do_action_10
			when 11 then
					--|#line <not available> "external.y"
				yy_do_action_11
			when 12 then
					--|#line <not available> "external.y"
				yy_do_action_12
			when 13 then
					--|#line <not available> "external.y"
				yy_do_action_13
			when 14 then
					--|#line <not available> "external.y"
				yy_do_action_14
			when 15 then
					--|#line <not available> "external.y"
				yy_do_action_15
			when 16 then
					--|#line <not available> "external.y"
				yy_do_action_16
			when 17 then
					--|#line <not available> "external.y"
				yy_do_action_17
			when 18 then
					--|#line <not available> "external.y"
				yy_do_action_18
			when 19 then
					--|#line <not available> "external.y"
				yy_do_action_19
			when 20 then
					--|#line <not available> "external.y"
				yy_do_action_20
			when 21 then
					--|#line <not available> "external.y"
				yy_do_action_21
			when 22 then
					--|#line <not available> "external.y"
				yy_do_action_22
			when 23 then
					--|#line <not available> "external.y"
				yy_do_action_23
			when 24 then
					--|#line <not available> "external.y"
				yy_do_action_24
			when 25 then
					--|#line <not available> "external.y"
				yy_do_action_25
			when 26 then
					--|#line <not available> "external.y"
				yy_do_action_26
			when 27 then
					--|#line <not available> "external.y"
				yy_do_action_27
			when 28 then
					--|#line <not available> "external.y"
				yy_do_action_28
			when 29 then
					--|#line <not available> "external.y"
				yy_do_action_29
			when 30 then
					--|#line <not available> "external.y"
				yy_do_action_30
			when 31 then
					--|#line <not available> "external.y"
				yy_do_action_31
			when 32 then
					--|#line <not available> "external.y"
				yy_do_action_32
			when 33 then
					--|#line <not available> "external.y"
				yy_do_action_33
			when 34 then
					--|#line <not available> "external.y"
				yy_do_action_34
			when 35 then
					--|#line <not available> "external.y"
				yy_do_action_35
			when 36 then
					--|#line <not available> "external.y"
				yy_do_action_36
			when 37 then
					--|#line <not available> "external.y"
				yy_do_action_37
			when 38 then
					--|#line <not available> "external.y"
				yy_do_action_38
			when 39 then
					--|#line <not available> "external.y"
				yy_do_action_39
			when 40 then
					--|#line <not available> "external.y"
				yy_do_action_40
			when 41 then
					--|#line <not available> "external.y"
				yy_do_action_41
			when 42 then
					--|#line <not available> "external.y"
				yy_do_action_42
			when 43 then
					--|#line <not available> "external.y"
				yy_do_action_43
			when 44 then
					--|#line <not available> "external.y"
				yy_do_action_44
			when 45 then
					--|#line <not available> "external.y"
				yy_do_action_45
			when 46 then
					--|#line <not available> "external.y"
				yy_do_action_46
			when 47 then
					--|#line <not available> "external.y"
				yy_do_action_47
			when 48 then
					--|#line <not available> "external.y"
				yy_do_action_48
			when 49 then
					--|#line <not available> "external.y"
				yy_do_action_49
			when 50 then
					--|#line <not available> "external.y"
				yy_do_action_50
			when 51 then
					--|#line <not available> "external.y"
				yy_do_action_51
			when 52 then
					--|#line <not available> "external.y"
				yy_do_action_52
			when 53 then
					--|#line <not available> "external.y"
				yy_do_action_53
			when 54 then
					--|#line <not available> "external.y"
				yy_do_action_54
			when 55 then
					--|#line <not available> "external.y"
				yy_do_action_55
			when 56 then
					--|#line <not available> "external.y"
				yy_do_action_56
			when 57 then
					--|#line <not available> "external.y"
				yy_do_action_57
			when 58 then
					--|#line <not available> "external.y"
				yy_do_action_58
			when 59 then
					--|#line <not available> "external.y"
				yy_do_action_59
			when 60 then
					--|#line <not available> "external.y"
				yy_do_action_60
			when 61 then
					--|#line <not available> "external.y"
				yy_do_action_61
			when 62 then
					--|#line <not available> "external.y"
				yy_do_action_62
			when 63 then
					--|#line <not available> "external.y"
				yy_do_action_63
			when 64 then
					--|#line <not available> "external.y"
				yy_do_action_64
			when 65 then
					--|#line <not available> "external.y"
				yy_do_action_65
			when 66 then
					--|#line <not available> "external.y"
				yy_do_action_66
			when 67 then
					--|#line <not available> "external.y"
				yy_do_action_67
			when 68 then
					--|#line <not available> "external.y"
				yy_do_action_68
			when 69 then
					--|#line <not available> "external.y"
				yy_do_action_69
			when 70 then
					--|#line <not available> "external.y"
				yy_do_action_70
			when 71 then
					--|#line <not available> "external.y"
				yy_do_action_71
			when 72 then
					--|#line <not available> "external.y"
				yy_do_action_72
			when 73 then
					--|#line <not available> "external.y"
				yy_do_action_73
			when 74 then
					--|#line <not available> "external.y"
				yy_do_action_74
			when 75 then
					--|#line <not available> "external.y"
				yy_do_action_75
			when 76 then
					--|#line <not available> "external.y"
				yy_do_action_76
			when 77 then
					--|#line <not available> "external.y"
				yy_do_action_77
			else
				debug ("GEYACC")
					std.error.put_string ("Error in parser: unknown rule id: ")
					std.error.put_integer (yy_act)
					std.error.put_new_line
				end
				abort
			end
		end

	yy_do_action_1 is
			--|#line <not available> "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

				root_node := yyvs2.item (yyvsp2)
				root_node.set_is_blocking_call (yyvs6.item (yyvsp6))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp6 := yyvsp6 -1
	yyvs2.put (yyval2, yyvsp2)
end
		end

	yy_do_action_2 is
			--|#line <not available> "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

				root_node := yyvs2.item (yyvsp2)
				root_node.set_is_blocking_call (yyvs6.item (yyvsp6))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp6 := yyvsp6 -1
	yyvs2.put (yyval2, yyvsp2)
end
		end

	yy_do_action_3 is
			--|#line <not available> "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

				root_node := yyvs2.item (yyvsp2)
				root_node.set_is_blocking_call (yyvs6.item (yyvsp6))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp6 := yyvsp6 -1
	yyvs2.put (yyval2, yyvsp2)
end
		end

	yy_do_action_4 is
			--|#line <not available> "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

				root_node := yyvs2.item (yyvsp2)
				root_node.set_is_blocking_call (yyvs6.item (yyvsp6))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp6 := yyvsp6 -1
	yyvs2.put (yyval2, yyvsp2)
end
		end

	yy_do_action_5 is
			--|#line <not available> "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

				create {INLINE_EXTENSION_AS} root_node.initialize (True, Void)
			
if yy_parsing_status = yyContinue then
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
		end

	yy_do_action_6 is
			--|#line <not available> "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

				root_node := yyvs2.item (yyvsp2)
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
		end

	yy_do_action_7 is
			--|#line <not available> "external.y"
		local
			yyval6: BOOLEAN
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

				yyval6 := False
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp6 := yyvsp6 + 1
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
		end

	yy_do_action_8 is
			--|#line <not available> "external.y"
		local
			yyval6: BOOLEAN
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

				yyval6 := True
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp6 := yyvsp6 + 1
	yyvsp1 := yyvsp1 -1
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
		end

	yy_do_action_9 is
			--|#line <not available> "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

				create {C_EXTENSION_AS} yyval2.initialize (yyvs3.item (yyvsp3), yyvs8.item (yyvsp8))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp2 := yyvsp2 + 1
	yyvsp3 := yyvsp3 -1
	yyvsp8 := yyvsp8 -1
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
		end

	yy_do_action_10 is
			--|#line <not available> "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

					-- False because this is a C construct
				create {STRUCT_EXTENSION_AS} yyval2.initialize (False, yyvs4.item (yyvsp4 - 1), yyvs5.item (yyvsp5), yyvs4.item (yyvsp4), yyvs8.item (yyvsp8))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp2 := yyvsp2 + 1
	yyvsp1 := yyvsp1 -2
	yyvsp4 := yyvsp4 -2
	yyvsp5 := yyvsp5 -1
	yyvsp8 := yyvsp8 -1
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
		end

	yy_do_action_11 is
			--|#line <not available> "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

					-- False because this is a C construct
				create {MACRO_EXTENSION_AS} yyval2.initialize (False, yyvs3.item (yyvsp3), yyvs8.item (yyvsp8))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 + 1
	yyvsp1 := yyvsp1 -1
	yyvsp3 := yyvsp3 -1
	yyvsp8 := yyvsp8 -1
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
		end

	yy_do_action_12 is
			--|#line <not available> "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

				create {INLINE_EXTENSION_AS} yyval2.initialize (False, yyvs8.item (yyvsp8))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp2 := yyvsp2 + 1
	yyvsp1 := yyvsp1 -1
	yyvsp8 := yyvsp8 -1
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
		end

	yy_do_action_13 is
			--|#line <not available> "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

				yyval2 := yyvs2.item (yyvsp2)
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
		end

	yy_do_action_14 is
			--|#line <not available> "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

					-- True because this is a C++ construct
				create {STRUCT_EXTENSION_AS} yyval2.initialize (True, yyvs4.item (yyvsp4 - 1), yyvs5.item (yyvsp5), yyvs4.item (yyvsp4), yyvs8.item (yyvsp8))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp2 := yyvsp2 + 1
	yyvsp1 := yyvsp1 -2
	yyvsp4 := yyvsp4 -2
	yyvsp5 := yyvsp5 -1
	yyvsp8 := yyvsp8 -1
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
		end

	yy_do_action_15 is
			--|#line <not available> "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

					-- True because this is a C++ construct
				create {MACRO_EXTENSION_AS} yyval2.initialize (True, yyvs3.item (yyvsp3), yyvs8.item (yyvsp8))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 + 1
	yyvsp1 := yyvsp1 -1
	yyvsp3 := yyvsp3 -1
	yyvsp8 := yyvsp8 -1
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
		end

	yy_do_action_16 is
			--|#line <not available> "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

				create {INLINE_EXTENSION_AS} yyval2.initialize (True, yyvs8.item (yyvsp8))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp2 := yyvsp2 + 1
	yyvsp1 := yyvsp1 -1
	yyvsp8 := yyvsp8 -1
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
		end

	yy_do_action_17 is
			--|#line <not available> "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

				create {CPP_EXTENSION_AS} yyval2.initialize (standard, yyvs5.item (yyvsp5), yyvs3.item (yyvsp3), yyvs8.item (yyvsp8))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 + 1
	yyvsp5 := yyvsp5 -1
	yyvsp3 := yyvsp3 -1
	yyvsp8 := yyvsp8 -1
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
		end

	yy_do_action_18 is
			--|#line <not available> "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

				create {CPP_EXTENSION_AS} yyval2.initialize (creator, yyvs5.item (yyvsp5), yyvs3.item (yyvsp3), yyvs8.item (yyvsp8))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp2 := yyvsp2 + 1
	yyvsp1 := yyvsp1 -1
	yyvsp5 := yyvsp5 -1
	yyvsp3 := yyvsp3 -1
	yyvsp8 := yyvsp8 -1
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
		end

	yy_do_action_19 is
			--|#line <not available> "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

				create {CPP_EXTENSION_AS} yyval2.initialize (delete, yyvs5.item (yyvsp5), yyvs3.item (yyvsp3), yyvs8.item (yyvsp8))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp2 := yyvsp2 + 1
	yyvsp1 := yyvsp1 -1
	yyvsp5 := yyvsp5 -1
	yyvsp3 := yyvsp3 -1
	yyvsp8 := yyvsp8 -1
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
		end

	yy_do_action_20 is
			--|#line <not available> "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

				create {CPP_EXTENSION_AS} yyval2.initialize (static, yyvs5.item (yyvsp5), yyvs3.item (yyvsp3), yyvs8.item (yyvsp8))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp2 := yyvsp2 + 1
	yyvsp1 := yyvsp1 -1
	yyvsp5 := yyvsp5 -1
	yyvsp3 := yyvsp3 -1
	yyvsp8 := yyvsp8 -1
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
		end

	yy_do_action_21 is
			--|#line <not available> "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

				create {DLL_EXTENSION_AS} yyval2.initialize ({EXTERNAL_CONSTANTS}.dll32_type,
					yyvs5.item (yyvsp5), yyvs7.item (yyvsp7), yyvs3.item (yyvsp3), yyvs8.item (yyvsp8))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp2 := yyvsp2 + 1
	yyvsp1 := yyvsp1 -1
	yyvsp5 := yyvsp5 -1
	yyvsp7 := yyvsp7 -1
	yyvsp3 := yyvsp3 -1
	yyvsp8 := yyvsp8 -1
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
		end

	yy_do_action_22 is
			--|#line <not available> "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

				create {DLL_EXTENSION_AS} yyval2.initialize ({EXTERNAL_CONSTANTS}.dllwin32_type,
					yyvs5.item (yyvsp5), yyvs7.item (yyvsp7), yyvs3.item (yyvsp3), yyvs8.item (yyvsp8))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp2 := yyvsp2 + 1
	yyvsp1 := yyvsp1 -1
	yyvsp5 := yyvsp5 -1
	yyvsp7 := yyvsp7 -1
	yyvsp3 := yyvsp3 -1
	yyvsp8 := yyvsp8 -1
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
		end

	yy_do_action_23 is
			--|#line <not available> "external.y"
		local
			yyval7: INTEGER
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

yyval7 := -1
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp7 := yyvsp7 + 1
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
		end

	yy_do_action_24 is
			--|#line <not available> "external.y"
		local
			yyval7: INTEGER
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

yyval7 := token_buffer.to_integer
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp7 := yyvsp7 + 1
	yyvsp1 := yyvsp1 -1
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
		end

	yy_do_action_25 is
			--|#line <not available> "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

				create {IL_EXTENSION_AS} yyval2.initialize (yyvs7.item (yyvsp7), normal_type, yyvs3.item (yyvsp3), yyvs5.item (yyvsp5))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp2 := yyvsp2 + 1
	yyvsp7 := yyvsp7 -1
	yyvsp3 := yyvsp3 -1
	yyvsp1 := yyvsp1 -1
	yyvsp5 := yyvsp5 -1
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
		end

	yy_do_action_26 is
			--|#line <not available> "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

				create {IL_EXTENSION_AS} yyval2.initialize (yyvs7.item (yyvsp7), deferred_type, yyvs3.item (yyvsp3), yyvs5.item (yyvsp5))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp2 := yyvsp2 + 1
	yyvsp7 := yyvsp7 -1
	yyvsp1 := yyvsp1 -2
	yyvsp3 := yyvsp3 -1
	yyvsp5 := yyvsp5 -1
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
		end

	yy_do_action_27 is
			--|#line <not available> "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

				create {IL_EXTENSION_AS} yyval2.initialize (yyvs7.item (yyvsp7), creator_type, yyvs3.item (yyvsp3), yyvs5.item (yyvsp5))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp2 := yyvsp2 + 1
	yyvsp7 := yyvsp7 -1
	yyvsp1 := yyvsp1 -2
	yyvsp3 := yyvsp3 -1
	yyvsp5 := yyvsp5 -1
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
		end

	yy_do_action_28 is
			--|#line <not available> "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

				create {IL_EXTENSION_AS} yyval2.initialize (yyvs7.item (yyvsp7), field_type, yyvs3.item (yyvsp3), yyvs5.item (yyvsp5))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp2 := yyvsp2 + 1
	yyvsp7 := yyvsp7 -1
	yyvsp1 := yyvsp1 -2
	yyvsp3 := yyvsp3 -1
	yyvsp5 := yyvsp5 -1
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
		end

	yy_do_action_29 is
			--|#line <not available> "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

				create {IL_EXTENSION_AS} yyval2.initialize (yyvs7.item (yyvsp7), static_field_type, yyvs3.item (yyvsp3), yyvs5.item (yyvsp5))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp2 := yyvsp2 + 1
	yyvsp7 := yyvsp7 -1
	yyvsp1 := yyvsp1 -2
	yyvsp3 := yyvsp3 -1
	yyvsp5 := yyvsp5 -1
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
		end

	yy_do_action_30 is
			--|#line <not available> "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

				create {IL_EXTENSION_AS} yyval2.initialize (yyvs7.item (yyvsp7), enum_field_type, yyvs3.item (yyvsp3), yyvs5.item (yyvsp5))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp2 := yyvsp2 + 1
	yyvsp7 := yyvsp7 -1
	yyvsp1 := yyvsp1 -2
	yyvsp3 := yyvsp3 -1
	yyvsp5 := yyvsp5 -1
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
		end

	yy_do_action_31 is
			--|#line <not available> "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

				create {IL_EXTENSION_AS} yyval2.initialize (yyvs7.item (yyvsp7), set_static_field_type, yyvs3.item (yyvsp3), yyvs5.item (yyvsp5))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp2 := yyvsp2 + 1
	yyvsp7 := yyvsp7 -1
	yyvsp1 := yyvsp1 -2
	yyvsp3 := yyvsp3 -1
	yyvsp5 := yyvsp5 -1
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
		end

	yy_do_action_32 is
			--|#line <not available> "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

				create {IL_EXTENSION_AS} yyval2.initialize (yyvs7.item (yyvsp7), set_field_type, yyvs3.item (yyvsp3), yyvs5.item (yyvsp5))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp2 := yyvsp2 + 1
	yyvsp7 := yyvsp7 -1
	yyvsp1 := yyvsp1 -2
	yyvsp3 := yyvsp3 -1
	yyvsp5 := yyvsp5 -1
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
		end

	yy_do_action_33 is
			--|#line <not available> "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

				create {IL_EXTENSION_AS} yyval2.initialize (yyvs7.item (yyvsp7), static_type, yyvs3.item (yyvsp3), yyvs5.item (yyvsp5))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp2 := yyvsp2 + 1
	yyvsp7 := yyvsp7 -1
	yyvsp1 := yyvsp1 -2
	yyvsp3 := yyvsp3 -1
	yyvsp5 := yyvsp5 -1
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
		end

	yy_do_action_34 is
			--|#line <not available> "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

				create {IL_EXTENSION_AS} yyval2.initialize (yyvs7.item (yyvsp7), get_property_type, yyvs3.item (yyvsp3), yyvs5.item (yyvsp5))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp2 := yyvsp2 + 1
	yyvsp7 := yyvsp7 -1
	yyvsp1 := yyvsp1 -2
	yyvsp3 := yyvsp3 -1
	yyvsp5 := yyvsp5 -1
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
		end

	yy_do_action_35 is
			--|#line <not available> "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

				create {IL_EXTENSION_AS} yyval2.initialize (yyvs7.item (yyvsp7), set_property_type, yyvs3.item (yyvsp3), yyvs5.item (yyvsp5))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp2 := yyvsp2 + 1
	yyvsp7 := yyvsp7 -1
	yyvsp1 := yyvsp1 -2
	yyvsp3 := yyvsp3 -1
	yyvsp5 := yyvsp5 -1
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
		end

	yy_do_action_36 is
			--|#line <not available> "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

				create {IL_EXTENSION_AS} yyval2.initialize (yyvs7.item (yyvsp7), operator_type, yyvs3.item (yyvsp3), yyvs5.item (yyvsp5))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp2 := yyvsp2 + 1
	yyvsp7 := yyvsp7 -1
	yyvsp1 := yyvsp1 -2
	yyvsp3 := yyvsp3 -1
	yyvsp5 := yyvsp5 -1
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
		end

	yy_do_action_37 is
			--|#line <not available> "external.y"
		local
			yyval7: INTEGER
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

				yyval7 := msil_language
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp7 := yyvsp7 + 1
	yyvsp1 := yyvsp1 -1
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
		end

	yy_do_action_38 is
			--|#line <not available> "external.y"
		local
			yyval7: INTEGER
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

				yyval7 := java_language
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp7 := yyvsp7 + 1
	yyvsp1 := yyvsp1 -1
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
		end

	yy_do_action_39 is
			--|#line <not available> "external.y"
		local
			yyval3: SIGNATURE_AS
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
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
	yyvs3.put (yyval3, yyvsp3)
end
		end

	yy_do_action_40 is
			--|#line <not available> "external.y"
		local
			yyval3: SIGNATURE_AS
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

yyval3 := yyvs3.item (yyvsp3)
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs3.put (yyval3, yyvsp3)
end
		end

	yy_do_action_41 is
			--|#line <not available> "external.y"
		local
			yyval3: SIGNATURE_AS
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

				create yyval3.initialize (yyvs9.item (yyvsp9), yyvs4.item (yyvsp4))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp3 := yyvsp3 + 1
	yyvsp1 := yyvsp1 -1
	yyvsp9 := yyvsp9 -1
	yyvsp4 := yyvsp4 -1
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
	yyvs3.put (yyval3, yyvsp3)
end
		end

	yy_do_action_42 is
			--|#line <not available> "external.y"
		local
			yyval9: ARRAYED_LIST [EXTERNAL_TYPE_AS]
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp9 := yyvsp9 + 1
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
		end

	yy_do_action_43 is
			--|#line <not available> "external.y"
		local
			yyval9: ARRAYED_LIST [EXTERNAL_TYPE_AS]
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

yyval9 := yyvs9.item (yyvsp9)
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs9.put (yyval9, yyvsp9)
end
		end

	yy_do_action_44 is
			--|#line <not available> "external.y"
		local
			yyval9: ARRAYED_LIST [EXTERNAL_TYPE_AS]
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

yyval9 := yyvs9.item (yyvsp9)
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyvs9.put (yyval9, yyvsp9)
end
		end

	yy_do_action_45 is
			--|#line <not available> "external.y"
		local
			yyval9: ARRAYED_LIST [EXTERNAL_TYPE_AS]
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp9 := yyvsp9 + 1
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
		end

	yy_do_action_46 is
			--|#line <not available> "external.y"
		local
			yyval9: ARRAYED_LIST [EXTERNAL_TYPE_AS]
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

yyval9 := yyvs9.item (yyvsp9)
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs9.put (yyval9, yyvsp9)
end
		end

	yy_do_action_47 is
			--|#line <not available> "external.y"
		local
			yyval9: ARRAYED_LIST [EXTERNAL_TYPE_AS]
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

			create {ARRAYED_LIST [EXTERNAL_TYPE_AS]} yyval9.make (Argument_list_initial_size)
			yyval9.extend (yyvs4.item (yyvsp4))
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp9 := yyvsp9 + 1
	yyvsp4 := yyvsp4 -1
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
		end

	yy_do_action_48 is
			--|#line <not available> "external.y"
		local
			yyval9: ARRAYED_LIST [EXTERNAL_TYPE_AS]
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

			yyval9 := yyvs9.item (yyvsp9)
			yyval9.extend (yyvs4.item (yyvsp4))
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp4 := yyvsp4 -1
	yyvs9.put (yyval9, yyvsp9)
end
		end

	yy_do_action_49 is
			--|#line <not available> "external.y"
		local
			yyval4: EXTERNAL_TYPE_AS
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp4 := yyvsp4 + 1
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
		end

	yy_do_action_50 is
			--|#line <not available> "external.y"
		local
			yyval4: EXTERNAL_TYPE_AS
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

yyval4 := yyvs4.item (yyvsp4)
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs4.put (yyval4, yyvsp4)
end
		end

	yy_do_action_51 is
			--|#line <not available> "external.y"
		local
			yyval4: EXTERNAL_TYPE_AS
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

					-- False because no `struct' keyword.
					-- Void because no `const', `signed', `unsigned' keyword.
				yyval4 := new_external_type_as (yyvs5.item (yyvsp5), Void, False, yyvs7.item (yyvsp7), yyvs6.item (yyvsp6))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp4 := yyvsp4 + 1
	yyvsp5 := yyvsp5 -1
	yyvsp7 := yyvsp7 -1
	yyvsp6 := yyvsp6 -1
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
		end

	yy_do_action_52 is
			--|#line <not available> "external.y"
		local
			yyval4: EXTERNAL_TYPE_AS
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

					-- True because `struct' keyword.
					-- Void because no `const', `signed', `unsigned' keyword.
				yyval4 := new_external_type_as (yyvs5.item (yyvsp5), Void, True, yyvs7.item (yyvsp7), yyvs6.item (yyvsp6))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp4 := yyvsp4 + 1
	yyvsp1 := yyvsp1 -1
	yyvsp5 := yyvsp5 -1
	yyvsp7 := yyvsp7 -1
	yyvsp6 := yyvsp6 -1
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
		end

	yy_do_action_53 is
			--|#line <not available> "external.y"
		local
			yyval4: EXTERNAL_TYPE_AS
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

					-- False because no `struct' keyword.
				yyval4 := new_external_type_as (yyvs5.item (yyvsp5), signed_prefix, False, yyvs7.item (yyvsp7), yyvs6.item (yyvsp6))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp4 := yyvsp4 + 1
	yyvsp1 := yyvsp1 -1
	yyvsp5 := yyvsp5 -1
	yyvsp7 := yyvsp7 -1
	yyvsp6 := yyvsp6 -1
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
		end

	yy_do_action_54 is
			--|#line <not available> "external.y"
		local
			yyval4: EXTERNAL_TYPE_AS
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

					-- False because no `struct' keyword.
				yyval4 := new_external_type_as (yyvs5.item (yyvsp5), unsigned_prefix, False, yyvs7.item (yyvsp7), yyvs6.item (yyvsp6))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp4 := yyvsp4 + 1
	yyvsp1 := yyvsp1 -1
	yyvsp5 := yyvsp5 -1
	yyvsp7 := yyvsp7 -1
	yyvsp6 := yyvsp6 -1
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
		end

	yy_do_action_55 is
			--|#line <not available> "external.y"
		local
			yyval4: EXTERNAL_TYPE_AS
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

					-- False because no `struct' keyword.
				yyval4 := new_external_type_as (yyvs5.item (yyvsp5), const_prefix, False, yyvs7.item (yyvsp7), yyvs6.item (yyvsp6))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp4 := yyvsp4 + 1
	yyvsp1 := yyvsp1 -1
	yyvsp5 := yyvsp5 -1
	yyvsp7 := yyvsp7 -1
	yyvsp6 := yyvsp6 -1
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
		end

	yy_do_action_56 is
			--|#line <not available> "external.y"
		local
			yyval4: EXTERNAL_TYPE_AS
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

					-- True because `struct' keyword.
				yyval4 := new_external_type_as (yyvs5.item (yyvsp5), const_prefix, True, yyvs7.item (yyvsp7), yyvs6.item (yyvsp6))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp4 := yyvsp4 + 1
	yyvsp1 := yyvsp1 -2
	yyvsp5 := yyvsp5 -1
	yyvsp7 := yyvsp7 -1
	yyvsp6 := yyvsp6 -1
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
		end

	yy_do_action_57 is
			--|#line <not available> "external.y"
		local
			yyval4: EXTERNAL_TYPE_AS
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

					-- False because no `struct' keyword.
				yyval4 := new_external_type_as (yyvs5.item (yyvsp5), const_signed_prefix, False, yyvs7.item (yyvsp7), yyvs6.item (yyvsp6))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp4 := yyvsp4 + 1
	yyvsp1 := yyvsp1 -2
	yyvsp5 := yyvsp5 -1
	yyvsp7 := yyvsp7 -1
	yyvsp6 := yyvsp6 -1
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
		end

	yy_do_action_58 is
			--|#line <not available> "external.y"
		local
			yyval4: EXTERNAL_TYPE_AS
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

					-- False because no `struct' keyword.
				yyval4 := new_external_type_as (yyvs5.item (yyvsp5), const_unsigned_prefix, False, yyvs7.item (yyvsp7), yyvs6.item (yyvsp6))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp4 := yyvsp4 + 1
	yyvsp1 := yyvsp1 -2
	yyvsp5 := yyvsp5 -1
	yyvsp7 := yyvsp7 -1
	yyvsp6 := yyvsp6 -1
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
		end

	yy_do_action_59 is
			--|#line <not available> "external.y"
		local
			yyval4: EXTERNAL_TYPE_AS
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp4 := yyvsp4 + 1
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
		end

	yy_do_action_60 is
			--|#line <not available> "external.y"
		local
			yyval4: EXTERNAL_TYPE_AS
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

			yyval4 := yyvs4.item (yyvsp4)
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs4.put (yyval4, yyvsp4)
end
		end

	yy_do_action_61 is
			--|#line <not available> "external.y"
		local
			yyval7: INTEGER
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

yyval7 := 0
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp7 := yyvsp7 + 1
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
		end

	yy_do_action_62 is
			--|#line <not available> "external.y"
		local
			yyval7: INTEGER
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

yyval7 := yyvs7.item (yyvsp7) + 1
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs7.put (yyval7, yyvsp7)
end
		end

	yy_do_action_63 is
			--|#line <not available> "external.y"
		local
			yyval6: BOOLEAN
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

yyval6 := False
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp6 := yyvsp6 + 1
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
		end

	yy_do_action_64 is
			--|#line <not available> "external.y"
		local
			yyval6: BOOLEAN
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

yyval6 := True
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp6 := yyvsp6 + 1
	yyvsp1 := yyvsp1 -1
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
		end

	yy_do_action_65 is
			--|#line <not available> "external.y"
		local
			yyval8: USE_LIST_AS
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp8 := yyvsp8 + 1
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
		end

	yy_do_action_66 is
			--|#line <not available> "external.y"
		local
			yyval8: USE_LIST_AS
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

yyval8 := yyvs8.item (yyvsp8)
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs8.put (yyval8, yyvsp8)
end
		end

	yy_do_action_67 is
			--|#line <not available> "external.y"
		local
			yyval8: USE_LIST_AS
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

yyval8 := yyvs8.item (yyvsp8)
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs8.put (yyval8, yyvsp8)
end
		end

	yy_do_action_68 is
			--|#line <not available> "external.y"
		local
			yyval8: USE_LIST_AS
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

			create {USE_LIST_AS} yyval8.make (Argument_list_initial_size)
			yyval8.extend (yyvs5.item (yyvsp5))
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp8 := yyvsp8 + 1
	yyvsp5 := yyvsp5 -1
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
		end

	yy_do_action_69 is
			--|#line <not available> "external.y"
		local
			yyval8: USE_LIST_AS
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

			yyval8 := yyvs8.item (yyvsp8)
			yyval8.extend (yyvs5.item (yyvsp5))
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp5 := yyvsp5 -1
	yyvs8.put (yyval8, yyvsp8)
end
		end

	yy_do_action_70 is
			--|#line <not available> "external.y"
		local
			yyval5: ID_AS
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

			yyval5 := new_double_quote_id_as (token_buffer)
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp5 := yyvsp5 + 1
	yyvsp1 := yyvsp1 -3
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
		end

	yy_do_action_71 is
			--|#line <not available> "external.y"
		local
			yyval5: ID_AS
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

			yyval5 := new_double_quote_id_as (token_buffer)
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp5 := yyvsp5 + 1
	yyvsp1 := yyvsp1 -3
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
		end

	yy_do_action_72 is
			--|#line <not available> "external.y"
		local
			yyval5: ID_AS
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

			yyval5 := new_system_id_as (token_buffer)
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp5 := yyvsp5 + 1
	yyvsp1 := yyvsp1 -3
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
		end

	yy_do_action_73 is
			--|#line <not available> "external.y"
		local
			yyval5: ID_AS
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

			yyval5 := new_system_id_as (token_buffer)
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp5 := yyvsp5 + 1
	yyvsp1 := yyvsp1 -3
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
		end

	yy_do_action_74 is
			--|#line <not available> "external.y"
		local
			yyval5: ID_AS
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

			yyval5 := new_double_quote_id_as (token_buffer)
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp5 := yyvsp5 + 1
	yyvsp1 := yyvsp1 -1
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
		end

	yy_do_action_75 is
			--|#line <not available> "external.y"
		local
			yyval5: ID_AS
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

			yyval5 := new_double_quote_id_as (token_buffer)
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp5 := yyvsp5 + 1
	yyvsp1 := yyvsp1 -3
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
		end

	yy_do_action_76 is
			--|#line <not available> "external.y"
		local
			yyval5: ID_AS
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

			yyval5 := new_double_quote_id_as (token_buffer)
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp5 := yyvsp5 + 1
	yyvsp1 := yyvsp1 -1
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
		end

	yy_do_action_77 is
			--|#line <not available> "external.y"
		local
			yyval5: ID_AS
		do
--|#line <not available> "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line <not available>")
end

create yyval5.initialize (token_buffer) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp5 := yyvsp5 + 1
	yyvsp1 := yyvsp1 -1
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
		end

	yy_do_error_action (yy_act: INTEGER) is
			-- Execute error action.
		do
			inspect yy_act
			when 185 then
					-- End-of-file expected action.
				report_eof_expected_error
			else
					-- Default action.
				report_error ("parse error")
			end
		end

feature {NONE} -- Table templates

	yytranslate_template: SPECIAL [INTEGER] is
		once
			Result := yyfixed_array (<<
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
			   35,   36,   37,   38,   39,   40,   41,   42,   43,   44, yyDummy>>)
		end

	yyr1_template: SPECIAL [INTEGER] is
		once
			Result := yyfixed_array (<<
			    0,   45,   45,   45,   45,   45,   45,   67,   67,   46,
			   46,   46,   46,   47,   47,   47,   47,   51,   51,   51,
			   51,   48,   49,   62,   62,   50,   50,   50,   50,   50,
			   50,   50,   50,   50,   50,   50,   50,   66,   66,   52,
			   52,   53,   68,   68,   69,   70,   70,   71,   71,   54,
			   54,   55,   55,   55,   55,   55,   55,   55,   55,   56,
			   56,   61,   61,   60,   60,   63,   63,   64,   65,   65,
			   58,   58,   58,   58,   58,   59,   59,   57, yyDummy>>)
		end

	yytypes1_template: SPECIAL [INTEGER] is
		once
			Result := yyfixed_array (<<
			    2,    1,    1,    1,    1,    1,    1,    2,    7,    6,
			    6,    6,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    3,    3,    1,    1,    2,    2,
			    1,    1,    1,    1,    1,    1,    1,    2,    2,    5,
			    1,    1,    1,    2,    3,    3,    3,    3,    3,    1,
			    9,    9,    3,    3,    3,    3,    3,    3,    3,    1,
			    1,    1,    5,    5,    1,    1,    1,    1,    4,    5,
			    5,    5,    3,    5,    1,    8,    8,    3,    4,    3,
			    8,    8,    1,    1,    1,    1,    4,    9,    9,    1,
			    4,    1,    1,    1,    1,    1,    1,    1,    5,    1,

			    1,    7,    7,    5,    5,    1,    1,    1,    5,    5,
			    1,    7,    3,    3,    8,    3,    1,    1,    1,    5,
			    8,    8,    1,    8,    5,    5,    5,    5,    1,    1,
			    4,    5,    5,    5,    5,    5,    5,    5,    1,    3,
			    3,    7,    7,    5,    5,    5,    7,    7,    5,    1,
			    1,    6,    8,    8,    8,    1,    1,    1,    1,    1,
			    5,    4,    8,    8,    6,    6,    7,    7,    7,    6,
			    6,    1,    4,    1,    1,    1,    1,    5,    4,    6,
			    6,    6,    4,    8,    8,    2,    1,    1, yyDummy>>)
		end

	yytypes2_template: SPECIAL [INTEGER] is
		once
			Result := yyfixed_array (<<
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1, yyDummy>>)
		end

	yydefact_template: SPECIAL [INTEGER] is
		once
			Result := yyfixed_array (<<
			    7,   38,   37,    7,    7,    8,    5,    6,   39,    0,
			    0,   39,   39,   39,   39,   39,   42,   39,   39,   39,
			   39,   39,   39,   39,    0,   40,    0,    0,    3,    4,
			   77,    0,    0,    0,   39,    0,   65,    2,   13,   39,
			    0,   39,   65,    1,   65,    0,    0,    0,    0,   45,
			   49,   43,    0,    0,    0,    0,    0,    0,    0,    0,
			   76,    0,   23,   23,    0,    0,    0,    0,    0,   61,
			   39,   39,    0,   39,    0,   16,   66,    0,    0,    0,
			   12,    9,    0,    0,    0,    0,   47,    0,   46,    0,
			   41,    0,    0,    0,    0,    0,    0,    0,   25,    0,

			   24,   39,   39,   61,   61,    0,    0,    0,   61,   61,
			    0,   63,    0,    0,   15,    0,   74,    0,    0,   68,
			   67,   17,    0,   11,   31,   29,   27,   33,   44,    0,
			   50,   35,   32,   36,   26,   28,   34,   30,   75,   65,
			   65,   63,   63,   61,   61,   61,   63,   63,   59,   62,
			   64,   51,   18,   20,   19,    0,    0,    0,    0,    0,
			   59,   48,   22,   21,   54,   53,   63,   63,   63,   55,
			   52,    0,    0,   71,   70,   73,   72,   69,    0,   58,
			   57,   56,   60,   14,   10,    0,    0,    0, yyDummy>>)
		end

	yydefgoto_template: SPECIAL [INTEGER] is
		once
			Result := yyfixed_array (<<
			  185,   43,   37,   28,   29,    7,   38,   24,   25,   90,
			   68,  172,   69,  119,   62,  151,  111,  101,   75,   76,
			  120,    8,    9,   50,   51,   87,   88, yyDummy>>)
		end

	yypact_template: SPECIAL [INTEGER] is
		once
			Result := yyfixed_array (<<
			   55, -32768, -32768,  124,  124, -32768, -32768, -32768,  118,   71,
			    4,   75,   45,   45,   45,   45,  130,   45,   45,   45,
			   45,   45,   45,   45,  115, -32768,  -11,  -11, -32768, -32768,
			 -32768,  -10,   25,   25,   45,   25,  -17, -32768, -32768,   45,
			  -10,   45,  -17, -32768,  -17,  114,  113,  105,   99,  -10,
			  129, -32768,   96,   93,   88,   87,   86,   85,   77,   25,
			 -32768,   61,   79,   79,   25,   25,   26,   25,   92, -32768,
			   45,   45,  -17,   45,   -7, -32768, -32768,  -17,   91,  -17,
			 -32768, -32768,   25,   25,   25,   25, -32768,   97,   94,  -10,
			 -32768,   25,   25,   25,   25,   25,   25,   25, -32768,   82,

			 -32768,   45,   45, -32768, -32768,   25,   25,   25, -32768, -32768,
			   25,   -3,  -17,  -17, -32768,  -17, -32768,   36,  -25, -32768,
			   66, -32768,   25, -32768, -32768, -32768, -32768, -32768, -32768,  -10,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,  -17,
			  -17,   -3,   -3, -32768, -32768, -32768,   -3,   -3,    7, -32768,
			 -32768, -32768, -32768, -32768, -32768,   52,   35,   42,   30,   -7,
			    7, -32768, -32768, -32768, -32768, -32768,   -3,   -3,   -3, -32768,
			 -32768,  -10,  -17, -32768, -32768, -32768, -32768, -32768,  -17, -32768,
			 -32768, -32768, -32768, -32768, -32768,   20,   14, -32768, yyDummy>>)
		end

	yypgoto_template: SPECIAL [INTEGER] is
		once
			Result := yyfixed_array (<<
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768,  103, -32768, -32768,
			  -40,    1,   -9,    0,  131, -107,  -92,   73,  -29,  -69,
			 -32768, -32768,   90, -32768, -32768, -32768, -32768, yyDummy>>)
		end

	yytable_template: SPECIAL [INTEGER] is
		once
			Result := yyfixed_array (<<
			   78,   39,   61,  114,  118,  150,  117,  149,  121,   86,
			  123,  141,  142,   80,  187,   81,  146,  147,  158,  157,
			  186,   36,   35,   70,   71,   74,   73,   67,   34,   66,
			   65,   64,   60,   30,  164,  165,  116,   33,   32,  169,
			  170,   31,  176,  152,  153,  171,  154,   30,  174,  130,
			   98,  166,  167,  168,  175,  103,  104,  108,  109,  179,
			  180,  181,    6,  107,    5,  173,  106,  105,   30,   30,
			    4,    3,  159,  124,  125,  126,  127,   16,    2,  156,
			  155,    1,  131,  132,  133,  134,  135,  136,  137,  161,
			   27,   26,   42,   10,   11,  138,  143,  144,  145,   41,

			  129,  148,  128,  183,   99,  122,  110,   16,  100,  184,
			  162,  163,   40,  160,   44,   45,   46,   47,   48,   97,
			   52,   53,   54,   55,   56,   57,   58,   96,   95,   94,
			   93,  182,   89,    5,   49,   92,  102,   72,   91,   23,
			   22,   85,   77,   21,   79,   20,   19,   84,   18,   17,
			   16,   15,   14,   13,   12,   83,   82,   59,   63,  177,
			    0,  178,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,  112,  113,    0,  115,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,

			    0,    0,    0,    0,  139,  140, yyDummy>>)
		end

	yycheck_template: SPECIAL [INTEGER] is
		once
			Result := yyfixed_array (<<
			   40,   10,   13,   72,   11,    8,   13,   10,   77,   49,
			   79,  103,  104,   42,    0,   44,  108,  109,   43,   44,
			    0,   17,   18,   32,   33,   42,   35,   37,   24,   39,
			   40,   41,   43,   43,  141,  142,   43,   33,   34,  146,
			  147,   37,   12,  112,  113,   38,  115,   43,   13,   89,
			   59,  143,  144,  145,   12,   64,   65,   66,   67,  166,
			  167,  168,    7,   37,    9,   13,   40,   41,   43,   43,
			   15,   16,    6,   82,   83,   84,   85,   32,   23,   43,
			   44,   26,   91,   92,   93,   94,   95,   96,   97,  129,
			   19,   20,   17,    3,    4,   13,  105,  106,  107,   24,

			    6,  110,    5,  172,   43,   14,   14,   32,   29,  178,
			  139,  140,   37,  122,   11,   12,   13,   14,   15,   42,
			   17,   18,   19,   20,   21,   22,   23,   42,   42,   42,
			   42,  171,    3,    9,    4,   42,   63,   34,   42,   21,
			   22,   42,   39,   25,   41,   27,   28,   42,   30,   31,
			   32,   33,   34,   35,   36,   42,   42,   42,   27,  159,
			   -1,  160,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   70,   71,   -1,   73,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,

			   -1,   -1,   -1,   -1,  101,  102, yyDummy>>)
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

	yyvs2: SPECIAL [EXTERNAL_EXTENSION_AS]
			-- Stack for semantic values of type EXTERNAL_EXTENSION_AS

	yyvsc2: INTEGER
			-- Capacity of semantic value stack `yyvs2'

	yyvsp2: INTEGER
			-- Top of semantic value stack `yyvs2'

	yyspecial_routines2: KL_SPECIAL_ROUTINES [EXTERNAL_EXTENSION_AS]
			-- Routines that ought to be in SPECIAL [EXTERNAL_EXTENSION_AS]

	yyvs3: SPECIAL [SIGNATURE_AS]
			-- Stack for semantic values of type SIGNATURE_AS

	yyvsc3: INTEGER
			-- Capacity of semantic value stack `yyvs3'

	yyvsp3: INTEGER
			-- Top of semantic value stack `yyvs3'

	yyspecial_routines3: KL_SPECIAL_ROUTINES [SIGNATURE_AS]
			-- Routines that ought to be in SPECIAL [SIGNATURE_AS]

	yyvs4: SPECIAL [EXTERNAL_TYPE_AS]
			-- Stack for semantic values of type EXTERNAL_TYPE_AS

	yyvsc4: INTEGER
			-- Capacity of semantic value stack `yyvs4'

	yyvsp4: INTEGER
			-- Top of semantic value stack `yyvs4'

	yyspecial_routines4: KL_SPECIAL_ROUTINES [EXTERNAL_TYPE_AS]
			-- Routines that ought to be in SPECIAL [EXTERNAL_TYPE_AS]

	yyvs5: SPECIAL [ID_AS]
			-- Stack for semantic values of type ID_AS

	yyvsc5: INTEGER
			-- Capacity of semantic value stack `yyvs5'

	yyvsp5: INTEGER
			-- Top of semantic value stack `yyvs5'

	yyspecial_routines5: KL_SPECIAL_ROUTINES [ID_AS]
			-- Routines that ought to be in SPECIAL [ID_AS]

	yyvs6: SPECIAL [BOOLEAN]
			-- Stack for semantic values of type BOOLEAN

	yyvsc6: INTEGER
			-- Capacity of semantic value stack `yyvs6'

	yyvsp6: INTEGER
			-- Top of semantic value stack `yyvs6'

	yyspecial_routines6: KL_SPECIAL_ROUTINES [BOOLEAN]
			-- Routines that ought to be in SPECIAL [BOOLEAN]

	yyvs7: SPECIAL [INTEGER]
			-- Stack for semantic values of type INTEGER

	yyvsc7: INTEGER
			-- Capacity of semantic value stack `yyvs7'

	yyvsp7: INTEGER
			-- Top of semantic value stack `yyvs7'

	yyspecial_routines7: KL_SPECIAL_ROUTINES [INTEGER]
			-- Routines that ought to be in SPECIAL [INTEGER]

	yyvs8: SPECIAL [USE_LIST_AS]
			-- Stack for semantic values of type USE_LIST_AS

	yyvsc8: INTEGER
			-- Capacity of semantic value stack `yyvs8'

	yyvsp8: INTEGER
			-- Top of semantic value stack `yyvs8'

	yyspecial_routines8: KL_SPECIAL_ROUTINES [USE_LIST_AS]
			-- Routines that ought to be in SPECIAL [USE_LIST_AS]

	yyvs9: SPECIAL [ARRAYED_LIST [EXTERNAL_TYPE_AS]]
			-- Stack for semantic values of type ARRAYED_LIST [EXTERNAL_TYPE_AS]

	yyvsc9: INTEGER
			-- Capacity of semantic value stack `yyvs9'

	yyvsp9: INTEGER
			-- Top of semantic value stack `yyvs9'

	yyspecial_routines9: KL_SPECIAL_ROUTINES [ARRAYED_LIST [EXTERNAL_TYPE_AS]]
			-- Routines that ought to be in SPECIAL [ARRAYED_LIST [EXTERNAL_TYPE_AS]]

feature {NONE} -- Constants

	yyFinal: INTEGER is 187
			-- Termination state id

	yyFlag: INTEGER is -32768
			-- Most negative INTEGER

	yyNtbase: INTEGER is 45
			-- Number of tokens

	yyLast: INTEGER is 205
			-- Upper bound of `yytable' and `yycheck'

	yyMax_token: INTEGER is 299
			-- Maximum token id
			-- (upper bound of `yytranslate'.)

	yyNsyms: INTEGER is 72
			-- Number of symbols
			-- (terminal and nonterminal)

feature -- User-defined features



feature {NONE} -- Constants

	const_prefix: STRING is "const "
	const_signed_prefix: STRING is "const signed "
	const_unsigned_prefix: STRING is "const unsigned "
	signed_prefix: STRING is "signed "
	unsigned_prefix: STRING is "unsigned ";
			-- Available prefix to C/C++ basic types.

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

end -- class EIFFEL_PARSER
