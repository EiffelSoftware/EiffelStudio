indexing
	description: "External parsers"
	status: "See notice at end of class"
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
					-- Void because no `signed', `unsigned' keyword.
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
					-- Void because no `signed', `unsigned' keyword.
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

	yy_do_action_56 is
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

	yy_do_action_57 is
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

	yy_do_action_58 is
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

	yy_do_action_59 is
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

	yy_do_action_60 is
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

	yy_do_action_61 is
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

	yy_do_action_62 is
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

	yy_do_action_63 is
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

	yy_do_action_64 is
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

	yy_do_action_65 is
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

	yy_do_action_66 is
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

	yy_do_action_67 is
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

	yy_do_action_68 is
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

	yy_do_action_69 is
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

	yy_do_action_73 is
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
			when 169 then
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
			   35,   36,   37,   38,   39,   40,   41,   42,   43, yyDummy>>)
		end

	yyr1_template: SPECIAL [INTEGER] is
		once
			Result := yyfixed_array (<<
			    0,   44,   44,   44,   44,   44,   44,   66,   66,   45,
			   45,   45,   45,   46,   46,   46,   46,   50,   50,   50,
			   50,   47,   48,   61,   61,   49,   49,   49,   49,   49,
			   49,   49,   49,   49,   49,   49,   49,   65,   65,   51,
			   51,   52,   67,   67,   68,   69,   69,   70,   70,   53,
			   53,   54,   54,   54,   54,   55,   55,   60,   60,   59,
			   59,   62,   62,   63,   64,   64,   57,   57,   57,   57,
			   57,   58,   58,   56, yyDummy>>)
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
			    1,    1,    5,    5,    1,    1,    1,    4,    5,    5,
			    5,    3,    5,    1,    8,    8,    3,    4,    3,    8,
			    8,    1,    1,    1,    1,    4,    9,    9,    1,    4,
			    1,    1,    1,    1,    1,    1,    1,    5,    1,    1,

			    7,    7,    5,    5,    5,    1,    7,    3,    3,    8,
			    3,    1,    1,    1,    5,    8,    8,    1,    8,    5,
			    5,    5,    5,    1,    1,    4,    5,    5,    5,    5,
			    5,    5,    5,    1,    3,    3,    7,    7,    7,    5,
			    1,    1,    6,    8,    8,    8,    1,    1,    1,    1,
			    1,    5,    4,    8,    8,    6,    6,    6,    1,    4,
			    1,    1,    1,    1,    5,    4,    4,    8,    8,    2,
			    1,    1, yyDummy>>)
		end

	yytypes2_template: SPECIAL [INTEGER] is
		once
			Result := yyfixed_array (<<
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1, yyDummy>>)
		end

	yydefact_template: SPECIAL [INTEGER] is
		once
			Result := yyfixed_array (<<
			    7,   38,   37,    7,    7,    8,    5,    6,   39,    0,
			    0,   39,   39,   39,   39,   39,   42,   39,   39,   39,
			   39,   39,   39,   39,    0,   40,    0,    0,    3,    4,
			   73,    0,    0,    0,   39,    0,   61,    2,   13,   39,
			    0,   39,   61,    1,   61,    0,    0,    0,    0,   45,
			   49,   43,    0,    0,    0,    0,    0,    0,    0,    0,
			   72,    0,   23,   23,    0,    0,    0,    0,   57,   39,
			   39,    0,   39,    0,   16,   62,    0,    0,    0,   12,
			    9,    0,    0,    0,    0,   47,    0,   46,    0,   41,
			    0,    0,    0,    0,    0,    0,    0,   25,    0,   24,

			   39,   39,   57,   57,   57,    0,   59,    0,    0,   15,
			    0,   70,    0,    0,   64,   63,   17,    0,   11,   31,
			   29,   27,   33,   44,    0,   50,   35,   32,   36,   26,
			   28,   34,   30,   71,   61,   61,   59,   59,   59,   55,
			   58,   60,   51,   18,   20,   19,    0,    0,    0,    0,
			    0,   55,   48,   22,   21,   54,   53,   52,    0,    0,
			   67,   66,   69,   68,   65,    0,   56,   14,   10,    0,
			    0,    0, yyDummy>>)
		end

	yydefgoto_template: SPECIAL [INTEGER] is
		once
			Result := yyfixed_array (<<
			  169,   43,   37,   28,   29,    7,   38,   24,   25,   89,
			   67,  159,   68,  114,   62,  142,  106,  100,   74,   75,
			  115,    8,    9,   50,   51,   86,   87, yyDummy>>)
		end

	yypact_template: SPECIAL [INTEGER] is
		once
			Result := yyfixed_array (<<
			   42, -32768, -32768,   93,   93, -32768, -32768, -32768,  117,   17,
			    5,   -6,   39,   39,   39,   39,   88,   39,   39,   39,
			   39,   39,   39,   39,   87, -32768,   -7,   -7, -32768, -32768,
			 -32768,   13,   27,   27,   39,   27,  -28, -32768, -32768,   39,
			   13,   39,  -28, -32768,  -28,   86,   85,   70,   68,   13,
			   80, -32768,   65,   63,   62,   58,   57,   56,   55,   27,
			 -32768,   40,   51,   51,   27,   27,   27,   67, -32768,   39,
			   39,  -28,   39,   -9, -32768, -32768,  -28,   61,  -28, -32768,
			 -32768,   27,   27,   27,   27, -32768,   69,   66,   13, -32768,
			   27,   27,   27,   27,   27,   27,   27, -32768,   60, -32768,

			   39,   39, -32768, -32768, -32768,   27,    0,  -28,  -28, -32768,
			  -28, -32768,   -2,  -18, -32768,   64, -32768,   27, -32768, -32768,
			 -32768, -32768, -32768, -32768,   13, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768,  -28,  -28,    0,    0,    0,    7,
			 -32768, -32768, -32768, -32768, -32768, -32768,   54,   53,   52,   44,
			   -9,    7, -32768, -32768, -32768, -32768, -32768, -32768,   13,  -28,
			 -32768, -32768, -32768, -32768, -32768,  -28, -32768, -32768, -32768,   34,
			   32, -32768, yyDummy>>)
		end

	yypgoto_template: SPECIAL [INTEGER] is
		once
			Result := yyfixed_array (<<
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768,  102, -32768, -32768,
			  -40,  -22,   -5,  -43,   78, -117,  -87,   45,  -41,  -64,
			 -32768, -32768,   59, -32768, -32768, -32768, -32768, yyDummy>>)
		end

	yytable_template: SPECIAL [INTEGER] is
		once
			Result := yyfixed_array (<<
			   77,   79,  113,   80,  112,   39,   61,  109,  141,   85,
			  140,   42,  116,   73,  118,  136,  137,  138,   41,  155,
			  156,  157,   36,   35,  149,  148,   16,   69,   70,   34,
			   72,   40,  171,  111,  170,   60,   27,   26,   33,   32,
			  147,  146,   31,  143,  144,  158,  145,   30,  125,    6,
			   66,    5,   65,   64,   97,   30,  163,    4,    3,  102,
			  103,  104,   10,   11,  162,    2,  161,  160,    1,   30,
			  150,   16,  124,  133,  123,  117,  119,  120,  121,  122,
			   99,  105,   98,   88,  152,  126,  127,  128,  129,  130,
			  131,  132,   49,  153,  154,  167,   96,   95,   94,   93,

			  139,  168,    5,   92,   91,   63,   90,  164,  101,   84,
			    0,   83,  151,   44,   45,   46,   47,   48,  166,   52,
			   53,   54,   55,   56,   57,   58,   82,   81,   59,  165,
			    0,    0,    0,    0,    0,    0,   71,    0,   23,   22,
			    0,   76,   21,   78,   20,   19,    0,   18,   17,   16,
			   15,   14,   13,   12,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,  107,  108,    0,  110,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,

			    0,    0,  134,  135, yyDummy>>)
		end

	yycheck_template: SPECIAL [INTEGER] is
		once
			Result := yyfixed_array (<<
			   40,   42,   11,   44,   13,   10,   13,   71,    8,   49,
			   10,   17,   76,   41,   78,  102,  103,  104,   24,  136,
			  137,  138,   17,   18,   42,   43,   32,   32,   33,   24,
			   35,   37,    0,   42,    0,   42,   19,   20,   33,   34,
			   42,   43,   37,  107,  108,   38,  110,   42,   88,    7,
			   37,    9,   39,   40,   59,   42,   12,   15,   16,   64,
			   65,   66,    3,    4,   12,   23,   13,   13,   26,   42,
			    6,   32,    6,   13,    5,   14,   81,   82,   83,   84,
			   29,   14,   42,    3,  124,   90,   91,   92,   93,   94,
			   95,   96,    4,  134,  135,  159,   41,   41,   41,   41,

			  105,  165,    9,   41,   41,   27,   41,  150,   63,   41,
			   -1,   41,  117,   11,   12,   13,   14,   15,  158,   17,
			   18,   19,   20,   21,   22,   23,   41,   41,   41,  151,
			   -1,   -1,   -1,   -1,   -1,   -1,   34,   -1,   21,   22,
			   -1,   39,   25,   41,   27,   28,   -1,   30,   31,   32,
			   33,   34,   35,   36,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   69,   70,   -1,   72,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,

			   -1,   -1,  100,  101, yyDummy>>)
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

	yyFinal: INTEGER is 171
			-- Termination state id

	yyFlag: INTEGER is -32768
			-- Most negative INTEGER

	yyNtbase: INTEGER is 44
			-- Number of tokens

	yyLast: INTEGER is 203
			-- Upper bound of `yytable' and `yycheck'

	yyMax_token: INTEGER is 298
			-- Maximum token id
			-- (upper bound of `yytranslate'.)

	yyNsyms: INTEGER is 71
			-- Number of symbols
			-- (terminal and nonterminal)

feature -- User-defined features



feature {NONE} -- Constants

	signed_prefix: STRING is "signed "
	unsigned_prefix: STRING is "unsigned "
			-- Available prefix to C/C++ basic types.

end -- class EIFFEL_PARSER


--|----------------------------------------------------------------
--| Copyright (C) 1992-1999, Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited
--| without prior agreement with Interactive Software Engineering.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------
