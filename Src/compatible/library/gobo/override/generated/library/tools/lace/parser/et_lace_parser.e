note

	description:

		"Lace parsers"
  
	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 1999-2009, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class ET_LACE_PARSER

inherit

	ET_LACE_PARSER_SKELETON

	ET_LACE_SCANNER
		rename
			make as make_lace_scanner
		end

create

	make, make_standard, make_with_factory


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
			yyvsp4 := -1
			yyvsp5 := -1
			yyvsp6 := -1
			yyvsp7 := -1
			yyvsp8 := -1
		end

	yy_clear_value_stacks
			-- Clear objects in semantic value stacks so that
			-- they can be collected by the garbage collector.
		local
			l_yyvs1_default_item: ANY
			l_yyvs2_default_item: ET_IDENTIFIER
			l_yyvs3_default_item: ET_LACE_CLUSTER
			l_yyvs4_default_item: ET_LACE_CLUSTERS
			l_yyvs5_default_item: ET_LACE_EXCLUDE
			l_yyvs6_default_item: ET_LACE_DOTNET_ASSEMBLY
			l_yyvs7_default_item: ET_LACE_SYSTEM
			l_yyvs8_default_item: ET_ADAPTED_DOTNET_ASSEMBLIES
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
			if yyvs4 /= Void then
				yyvs4.fill_with (l_yyvs4_default_item, 0, yyvs4.upper)
			end
			if yyvs5 /= Void then
				yyvs5.fill_with (l_yyvs5_default_item, 0, yyvs5.upper)
			end
			if yyvs6 /= Void then
				yyvs6.fill_with (l_yyvs6_default_item, 0, yyvs6.upper)
			end
			if yyvs7 /= Void then
				yyvs7.fill_with (l_yyvs7_default_item, 0, yyvs7.upper)
			end
			if yyvs8 /= Void then
				yyvs8.fill_with (l_yyvs8_default_item, 0, yyvs8.upper)
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
				yyspecial_routines2.force (yyvs2, last_et_identifier_value, yyvsp2)
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

	yy_run_geyacc
			-- You must run geyacc to regenerate this class.
		do
		end

feature {NONE} -- Semantic actions

	yy_do_action (yy_act: INTEGER)
			-- Execute semantic action.
		local
			yyval1: ANY
			yyval7: ET_LACE_SYSTEM
			yyval2: ET_IDENTIFIER
			yyval4: ET_LACE_CLUSTERS
			yyval3: ET_LACE_CLUSTER
			yyval5: ET_LACE_EXCLUDE
			yyval8: ET_ADAPTED_DOTNET_ASSEMBLIES
			yyval6: ET_LACE_DOTNET_ASSEMBLY
		do
			inspect yy_act
when 1 then
--|#line 51 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 51")
end

			set_system (last_system)
			if yyvs4.item (yyvsp4) /= Void then
				last_system.set_clusters (yyvs4.item (yyvsp4))
			end
			if yyvs8.item (yyvsp8) /= Void then
				last_system.set_dotnet_assemblies (yyvs8.item (yyvsp8))
			end
			last_system.set_root_type (yyvs2.item (yyvsp2 - 2))
			last_system.set_root_creation (yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 11
	yyvsp1 := yyvsp1 -4
	yyvsp7 := yyvsp7 -1
	yyvsp2 := yyvsp2 -3
	yyvsp4 := yyvsp4 -1
	yyvsp8 := yyvsp8 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 2 then
--|#line 66 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 66")
end

			last_system := new_system (yyvs2.item (yyvsp2).name)
			yyval7 := last_system
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp7 := yyvsp7 + 1
	yyvsp1 := yyvsp1 -1
	yyvsp2 := yyvsp2 -1
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
	yyspecial_routines7.force (yyvs7, yyval7, yyvsp7)
end
when 3 then
--|#line 73 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 73")
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
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 4 then
--|#line 75 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 75")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 5 then
--|#line 79 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 79")
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
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 6 then
--|#line 81 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 81")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 7 then
--|#line 85 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 85")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 8 then
--|#line 86 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 86")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 9 then
--|#line 89 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 89")
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
when 10 then
--|#line 90 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 90")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 11 then
--|#line 93 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 93")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 12 then
--|#line 94 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 94")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 13 then
--|#line 97 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 97")
end

yyval1 := new_default_value (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp1 := yyvsp1 -1
	yyvsp2 := yyvsp2 -2
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 14 then
--|#line 99 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 99")
end

yyval1 := new_default_value (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp1 := yyvsp1 -1
	yyvsp2 := yyvsp2 -2
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 15 then
--|#line 103 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 103")
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
when 16 then
--|#line 104 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 104")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 17 then
--|#line 107 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 107")
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
when 18 then
--|#line 108 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 108")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 19 then
--|#line 111 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 111")
end


if yy_parsing_status >= yyContinue then
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
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 20 then
--|#line 113 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 113")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp4 := yyvsp4 + 1
	yyvsp1 := yyvsp1 -1
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
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 21 then
--|#line 115 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 115")
end

yyval4 := yyvs4.item (yyvsp4) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 22 then
--|#line 119 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 119")
end

yyval4 := new_clusters (yyvs3.item (yyvsp3)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp4 := yyvsp4 + 1
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
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 23 then
--|#line 121 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 121")
end

-- TODO: syntax error: the cluster list cannot contain just
-- one subcluster that is qualified because it needs an unqualified
-- parent cluster.
			yyval4 := new_clusters (yyvs3.item (yyvsp3))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp4 := yyvsp4 + 1
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
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 24 then
--|#line 128 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 128")
end

yyval4 := yyvs4.item (yyvsp4); yyval4.put_last (yyvs3.item (yyvsp3)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp3 := yyvsp3 -1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 25 then
--|#line 130 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 130")
end

				-- Note: the subcluster has already been inserted
				-- in the list of subclusters of its parent. So
				-- no need to add it to the top-level list of clusters.
			yyval4 := yyvs4.item (yyvsp4)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp3 := yyvsp3 -1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 26 then
--|#line 139 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 139")
end

yyval3 := yyvs3.item (yyvsp3); yyval3.set_abstract (True) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyspecial_routines3.force (yyvs3, yyval3, yyvsp3)
end
when 27 then
--|#line 141 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 141")
end

yyval3 := yyvs3.item (yyvsp3); yyval3.set_recursive (True) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp2 := yyvsp2 -1
	yyspecial_routines3.force (yyvs3, yyval3, yyvsp3)
end
when 28 then
--|#line 143 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 143")
end

			yyval3 := yyvs3.item (yyvsp3);
			yyval3.set_recursive (True)
			yyval3.set_read_only (True)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyspecial_routines3.force (yyvs3, yyval3, yyvsp3)
end
when 29 then
--|#line 149 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 149")
end

yyval3 := yyvs3.item (yyvsp3) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines3.force (yyvs3, yyval3, yyvsp3)
end
when 30 then
--|#line 153 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 153")
end

			yyval3 := new_qualified_subcluster (yyvs2.item (yyvsp2 - 2), yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2), yyvs5.item (yyvsp5))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp3 := yyvsp3 + 1
	yyvsp2 := yyvsp2 -3
	yyvsp1 := yyvsp1 -3
	yyvsp5 := yyvsp5 -1
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
	yyspecial_routines3.force (yyvs3, yyval3, yyvsp3)
end
when 31 then
--|#line 157 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 157")
end

			yyval3 := new_qualified_subcluster (yyvs2.item (yyvsp2 - 2), yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2), yyvs5.item (yyvsp5))
			yyval3.set_recursive (True)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 8
	yyvsp3 := yyvsp3 + 1
	yyvsp2 := yyvsp2 -4
	yyvsp1 := yyvsp1 -3
	yyvsp5 := yyvsp5 -1
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
	yyspecial_routines3.force (yyvs3, yyval3, yyvsp3)
end
when 32 then
--|#line 162 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 162")
end

			yyval3 := new_qualified_subcluster (yyvs2.item (yyvsp2 - 2), yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2), yyvs5.item (yyvsp5))
			yyval3.set_recursive (True)
			yyval3.set_read_only (True)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 8
	yyvsp3 := yyvsp3 + 1
	yyvsp1 := yyvsp1 -4
	yyvsp2 := yyvsp2 -3
	yyvsp5 := yyvsp5 -1
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
	yyspecial_routines3.force (yyvs3, yyval3, yyvsp3)
end
when 33 then
--|#line 170 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 170")
end

			yyval3 := new_cluster (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2))
			yyval3.set_exclude (yyvs5.item (yyvsp5))
			yyval3.set_subclusters (yyvs4.item (yyvsp4))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp3 := yyvsp3 + 1
	yyvsp2 := yyvsp2 -2
	yyvsp1 := yyvsp1 -1
	yyvsp5 := yyvsp5 -1
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
	yyspecial_routines3.force (yyvs3, yyval3, yyvsp3)
end
when 34 then
--|#line 176 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 176")
end

			yyval3 := new_cluster (yyvs2.item (yyvsp2), Void)
			yyval3.set_exclude (yyvs5.item (yyvsp5))
			yyval3.set_subclusters (yyvs4.item (yyvsp4))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp3 := yyvsp3 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp5 := yyvsp5 -1
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
	yyspecial_routines3.force (yyvs3, yyval3, yyvsp3)
end
when 35 then
--|#line 184 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 184")
end

			yyval3 := new_cluster (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2))
			yyval3.set_exclude (yyvs5.item (yyvsp5))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp3 := yyvsp3 + 1
	yyvsp2 := yyvsp2 -2
	yyvsp1 := yyvsp1 -1
	yyvsp5 := yyvsp5 -1
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
	yyspecial_routines3.force (yyvs3, yyval3, yyvsp3)
end
when 36 then
--|#line 191 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 191")
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
when 37 then
--|#line 192 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 192")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 38 then
--|#line 195 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 195")
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
when 39 then
--|#line 196 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 196")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 40 then
--|#line 199 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 199")
end


if yy_parsing_status >= yyContinue then
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
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 41 then
--|#line 201 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 201")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 + 1
	yyvsp1 := yyvsp1 -2
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
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 42 then
--|#line 203 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 203")
end

yyval4 := yyvs4.item (yyvsp4) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp1 := yyvsp1 -3
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 43 then
--|#line 207 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 207")
end

yyval4 := new_clusters (yyvs3.item (yyvsp3)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp4 := yyvsp4 + 1
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
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 44 then
--|#line 209 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 209")
end

yyval4 := yyvs4.item (yyvsp4); yyval4.put_last (yyvs3.item (yyvsp3)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp3 := yyvsp3 -1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 45 then
--|#line 213 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 213")
end

yyval3 := yyvs3.item (yyvsp3); yyval3.set_abstract (True) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyspecial_routines3.force (yyvs3, yyval3, yyvsp3)
end
when 46 then
--|#line 215 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 215")
end

yyval3 := yyvs3.item (yyvsp3) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines3.force (yyvs3, yyval3, yyvsp3)
end
when 47 then
--|#line 219 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 219")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp5 := yyvsp5 + 1
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
	yyspecial_routines5.force (yyvs5, yyval5, yyvsp5)
end
when 48 then
--|#line 221 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 221")
end

yyval5 := yyvs5.item (yyvsp5) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp1 := yyvsp1 -4
	yyspecial_routines5.force (yyvs5, yyval5, yyvsp5)
end
when 49 then
--|#line 223 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 223")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp5 := yyvsp5 + 1
	yyvsp1 := yyvsp1 -4
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
	yyspecial_routines5.force (yyvs5, yyval5, yyvsp5)
end
when 50 then
--|#line 225 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 225")
end


if yy_parsing_status >= yyContinue then
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
	yyspecial_routines5.force (yyvs5, yyval5, yyvsp5)
end
when 51 then
--|#line 227 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 227")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp5 := yyvsp5 + 1
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
	yyspecial_routines5.force (yyvs5, yyval5, yyvsp5)
end
when 52 then
--|#line 231 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 231")
end


if yy_parsing_status >= yyContinue then
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
	yyspecial_routines5.force (yyvs5, yyval5, yyvsp5)
end
when 53 then
--|#line 232 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 232")
end

yyval5 := yyvs5.item (yyvsp5) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyspecial_routines5.force (yyvs5, yyval5, yyvsp5)
end
when 54 then
--|#line 234 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 234")
end

yyval5 := yyvs5.item (yyvsp5) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyspecial_routines5.force (yyvs5, yyval5, yyvsp5)
end
when 55 then
--|#line 238 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 238")
end

create yyval5.make yyval5.put_last (yyvs2.item (yyvsp2)) 
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
	yyspecial_routines5.force (yyvs5, yyval5, yyvsp5)
end
when 56 then
--|#line 240 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 240")
end

yyval5 := yyvs5.item (yyvsp5); yyval5.put_last (yyvs2.item (yyvsp2)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp2 := yyvsp2 -1
	yyspecial_routines5.force (yyvs5, yyval5, yyvsp5)
end
when 57 then
--|#line 244 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 244")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 58 then
--|#line 245 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 245")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 59 then
--|#line 248 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 248")
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
when 60 then
--|#line 249 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 249")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 61 then
--|#line 252 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 252")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 62 then
--|#line 253 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 253")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 63 then
--|#line 256 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 256")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp1 := yyvsp1 -3
	yyvsp2 := yyvsp2 -2
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 64 then
--|#line 257 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 257")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp1 := yyvsp1 -3
	yyvsp2 := yyvsp2 -2
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 65 then
--|#line 261 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 261")
end


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
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 66 then
--|#line 262 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 262")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp2 := yyvsp2 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 67 then
--|#line 265 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 265")
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
when 68 then
--|#line 266 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 266")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 69 then
--|#line 269 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 269")
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
when 70 then
--|#line 270 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 270")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 71 then
--|#line 273 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 273")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 72 then
--|#line 274 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 274")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 73 then
--|#line 277 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 277")
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
when 74 then
--|#line 278 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 278")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 75 then
--|#line 281 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 281")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp2 := yyvsp2 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 76 then
--|#line 282 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 282")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 77 then
--|#line 283 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 283")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 78 then
--|#line 286 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 286")
end


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
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 79 then
--|#line 287 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 287")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp2 := yyvsp2 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 80 then
--|#line 290 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 290")
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
when 81 then
--|#line 291 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 291")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 82 then
--|#line 294 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 294")
end


if yy_parsing_status >= yyContinue then
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
	yyspecial_routines8.force (yyvs8, yyval8, yyvsp8)
end
when 83 then
--|#line 296 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 296")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp8 := yyvsp8 + 1
	yyvsp1 := yyvsp1 -1
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
	yyspecial_routines8.force (yyvs8, yyval8, yyvsp8)
end
when 84 then
--|#line 298 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 298")
end

yyval8 := yyvs8.item (yyvsp8) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyspecial_routines8.force (yyvs8, yyval8, yyvsp8)
end
when 85 then
--|#line 302 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 302")
end

yyval8 := new_assemblies (yyvs6.item (yyvsp6)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp8 := yyvsp8 + 1
	yyvsp6 := yyvsp6 -1
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
	yyspecial_routines8.force (yyvs8, yyval8, yyvsp8)
end
when 86 then
--|#line 304 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 304")
end

			yyval8 := yyvs8.item (yyvsp8)
			yyvs8.item (yyvsp8).put_last (yyvs6.item (yyvsp6))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp6 := yyvsp6 -1
	yyspecial_routines8.force (yyvs8, yyval8, yyvsp8)
end
when 87 then
--|#line 311 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 311")
end

			yyval6 := new_assembly (yyvs2.item (yyvsp2 - 2), yyvs2.item (yyvsp2 - 1))
			yyval6.set_classname_prefix_id (yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp6 := yyvsp6 + 1
	yyvsp2 := yyvsp2 -3
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
	yyspecial_routines6.force (yyvs6, yyval6, yyvsp6)
end
when 88 then
--|#line 316 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 316")
end

			yyval6 := new_gac_assembly (yyvs2.item (yyvsp2 - 5), yyvs2.item (yyvsp2 - 4), yyvs2.item (yyvsp2 - 3), yyvs2.item (yyvsp2 - 2), yyvs2.item (yyvsp2 - 1))
			yyval6.set_classname_prefix_id (yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 10
	yyvsp6 := yyvsp6 + 1
	yyvsp2 := yyvsp2 -6
	yyvsp1 := yyvsp1 -4
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
	yyspecial_routines6.force (yyvs6, yyval6, yyvsp6)
end
when 89 then
--|#line 323 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 323")
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
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 90 then
--|#line 325 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 325")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 91 then
--|#line 329 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 329")
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
when 92 then
--|#line 330 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 330")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 93 then
--|#line 333 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 333")
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
when 94 then
--|#line 334 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 334")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 95 then
--|#line 337 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 337")
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
when 96 then
--|#line 338 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 338")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 97 then
--|#line 339 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 339")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 98 then
--|#line 342 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 342")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 99 then
--|#line 343 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 343")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 100 then
--|#line 346 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 346")
end


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
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 101 then
--|#line 347 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 347")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp1 := yyvsp1 -1
	yyvsp2 := yyvsp2 -2
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 102 then
--|#line 348 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 348")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp1 := yyvsp1 -1
	yyvsp2 := yyvsp2 -2
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 103 then
--|#line 351 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 351")
end

			add_external_value (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2))
			yyval2 := yyvs2.item (yyvsp2 - 1)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 104 then
--|#line 356 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 356")
end

			add_external_value (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2))
			yyval2 := yyvs2.item (yyvsp2 - 1)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 105 then
--|#line 363 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 363")
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
when 106 then
--|#line 364 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 364")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 107 then
--|#line 367 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 367")
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
when 108 then
--|#line 368 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 368")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 109 then
--|#line 371 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 371")
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
when 110 then
--|#line 372 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 372")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 111 then
--|#line 373 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 373")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 112 then
--|#line 376 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 376")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 113 then
--|#line 378 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 378")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
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
			when 183 then
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
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			   21,   22,    2,    2,   25,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,   23,   24,
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
			   15,   16,   17,   18,   19,   20, yyDummy>>)
		end

	yyr1_template: SPECIAL [INTEGER]
			-- Template for `yyr1'
		once
			Result := yyfixed_array (<<
			    0,   47,   44,   39,   39,   40,   40,   51,   51,   48,
			   48,   52,   52,   53,   53,   54,   54,   55,   55,   32,
			   32,   32,   31,   31,   31,   31,   26,   26,   26,   26,
			   30,   30,   30,   27,   27,   28,   56,   56,   57,   57,
			   33,   33,   33,   34,   34,   29,   29,   37,   37,   37,
			   37,   37,   35,   35,   35,   36,   36,   60,   60,   58,
			   58,   62,   62,   63,   63,   66,   66,   64,   64,   65,
			   65,   61,   61,   59,   59,   67,   67,   67,   68,   68,
			   69,   69,   46,   46,   46,   45,   45,   43,   43,   41,
			   41,   70,   70,   71,   71,   49,   49,   49,   72,   72,

			   73,   73,   73,   42,   42,   74,   74,   75,   75,   50,
			   50,   50,   38,   38, yyDummy>>)
		end

	yytypes1_template: SPECIAL [INTEGER]
			-- Template for `yytypes1'
		once
			Result := yyfixed_array (<<
			    1,    1,    7,    2,    2,    2,    1,    2,    1,    2,
			    2,    1,    2,    1,    2,    1,    1,    1,    2,    1,
			    1,    1,    4,    1,    1,    1,    1,    1,    1,    2,
			    3,    3,    3,    4,    2,    1,    8,    2,    2,    1,
			    3,    2,    3,    2,    3,    2,    1,    1,    1,    1,
			    1,    1,    1,    1,    5,    5,    1,    1,    1,    2,
			    6,    8,    1,    1,    1,    1,    1,    1,    1,    3,
			    3,    2,    2,    2,    1,    1,    5,    2,    2,    1,
			    1,    1,    1,    4,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    2,    2,    1,    1,    1,    1,    2,

			    2,    2,    5,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    3,    3,    4,    1,    1,
			    2,    6,    1,    1,    1,    1,    1,    1,    1,    1,
			    5,    1,    1,    4,    1,    1,    2,    2,    2,    1,
			    1,    3,    1,    1,    1,    1,    1,    2,    2,    2,
			    2,    2,    1,    1,    1,    2,    1,    1,    1,    1,
			    3,    2,    2,    1,    1,    2,    2,    5,    1,    1,
			    1,    1,    5,    5,    2,    1,    1,    2,    1,    1,
			    2,    2,    2,    1,    1,    1, yyDummy>>)
		end

	yytypes2_template: SPECIAL [INTEGER]
			-- Template for `yytypes2'
		once
			Result := yyfixed_array (<<
			    1,    1,    1,    2,    2,    2,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1, yyDummy>>)
		end

	yydefact_template: SPECIAL [INTEGER]
			-- Template for `yydefact'
		once
			Result := yyfixed_array (<<
			    0,    0,    0,  113,  112,    2,    0,    3,    0,    5,
			    0,    0,    9,    4,    6,    7,   19,   10,    0,    8,
			   17,   20,   82,    0,   18,   11,    0,    0,    0,    0,
			   22,   29,   23,   38,   47,   83,   95,    0,    0,   12,
			   28,    0,   26,   47,   27,    0,   39,   21,    0,    0,
			    0,   71,   52,   57,    9,   40,   59,   73,    0,    0,
			   85,   93,   96,  109,   14,   13,    0,    0,    0,   24,
			   25,   47,    0,   78,   72,   80,   53,   55,    0,   58,
			   69,   59,    0,   34,   73,   60,    0,   74,   51,    0,
			   94,   84,    0,    0,  100,   97,  107,  110,    0,   47,

			    0,    0,   40,    0,   79,   81,    0,   54,    0,   70,
			   61,    0,   73,    0,   41,   46,   43,   38,    0,   50,
			   89,   86,    0,    0,    0,  108,   98,    0,  111,    1,
			   35,    0,    0,   33,    0,   77,   56,    0,    0,   62,
			    0,   45,    0,    0,   49,    0,    0,   87,  103,    0,
			    0,  104,   99,    0,    0,   47,    0,    0,   48,   42,
			   44,    0,    0,  102,  101,   47,   47,   30,    0,    0,
			    0,   90,   32,   31,   65,   64,   63,    0,    0,    0,
			   66,   89,   88,    0,    0,    0, yyDummy>>)
		end

	yydefgoto_template: SPECIAL [INTEGER]
			-- Template for `yydefgoto'
		once
			Result := yyfixed_array (<<
			   30,   31,   40,  116,   32,   33,   22,   83,  117,   54,
			   76,   55,   43,    9,   12,  147,   94,   60,    2,   61,
			   36,  183,   16,   63,   98,   56,   19,   20,   25,   26,
			   47,   48,   84,   86,   57,   58,   79,   80,  110,  111,
			  175,   74,   75,  106,   91,   92,   95,   96,  126,  127, yyDummy>>)
		end

	yypact_template: SPECIAL [INTEGER]
			-- Template for `yypact'
		once
			Result := yyfixed_array (<<
			  190,   59,  188, -32768, -32768, -32768,   59,  177,   59,  176,
			  175,   59,  178, -32768, -32768,   59,  180, -32768,  173, -32768,
			   60,   97,  172,  167,  130, -32768,   59,   59,   59,   59,
			 -32768, -32768, -32768,   71,  114,   59,  182,  170,  169, -32768,
			 -32768,  152, -32768,  102, -32768,  133,  139, -32768,   97,   59,
			   59,   59,   59,   59,  178,  140,  166,  103,  179,  163,
			 -32768,   30,   59,  171, -32768, -32768,   59,   59,   59, -32768,
			 -32768,  145,  162,  174, -32768,  161,  156, -32768,  160, -32768,
			    8,  166,    9, -32768,  103, -32768,  168, -32768, -32768,   59,
			   32, -32768,   59,  111,  149, -32768,    3,   59,  158,  145,

			  143,  137,  140,  117,  128,  123,   59,   59,  159,   37,
			 -32768,   59,  103,   59, -32768, -32768, -32768,   11,  112, -32768,
			   39, -32768,   59,   89,   59,   69, -32768,   59, -32768, -32768,
			 -32768,  105,   90, -32768,   59, -32768, -32768,   87,   86, -32768,
			   96, -32768,   95,   56, -32768,   59,   59, -32768, -32768,   77,
			   68, -32768, -32768,   59,   59,  145,   62,   57, -32768, -32768,
			 -32768,   50,   66, -32768, -32768,  145,  145, -32768,   59,   59,
			   59, -32768, -32768, -32768, -32768,   31,   31,    5,   59,   59,
			 -32768,   20, -32768,   21,   18, -32768, yyDummy>>)
		end

	yypgoto_template: SPECIAL [INTEGER]
			-- Template for `yypgoto'
		once
			Result := yyfixed_array (<<
			  183,  -27,  185,   70,  164, -32768, -32768,  107, -32768, -32768,
			 -32768,  -68,   -1, -32768, -32768,   25, -32768,  118, -32768, -32768,
			 -32768, -32768,  150, -32768, -32768,   -8,  181, -32768, -32768, -32768,
			   91,   88,  120,  -75,  -48,  -55,   92, -32768, -32768, -32768,
			   33,   94, -32768, -32768, -32768, -32768,  -91, -32768, -32768, -32768, yyDummy>>)
		end

	yytable_template: SPECIAL [INTEGER]
			-- Template for `yytable'
		once
			Result := yyfixed_array (<<
			    5,   42,   87,  102,   17,    7,  128,   10,   85,  118,
			   14, -105,    4,    3,   18, -105,  -67,  114,  185,  -36,
			   34,  184,   38,  113,  -67,   18,   41,  125,   45,   87,
			  179,  130,  109,   85,   59,   46,  152,  140,  -91,  146,
			  -92,  -91,  -91,  -92,  -92,  -68,   17,   34,   71,   72,
			   73,   77,   78,  -68,   90,  115,  178,   87,  146,    4,
			    3,   93,    4,    3,  145,   99,  100,  101,  -15,  -15,
			  113,  -15,  -15,  -15,  171,  170,  -15, -106,  -15,  -36,
			  169, -106,  -36,  -36,   24,  168,  141,  167,  120,  -36,
			  164,   59,    4,    3,  149,   46,   93,  172,  173,  163,

			    4,    3,   29,  159,  158,   73,  136,  138,  157,  156,
			   78,   28,   15,  154,   27,   53,  115,   52,   51,   51,
			  144,  148,  150,  151,   15,   49,   93,   53,  153,   52,
			   51,  -76,  123,  155,  122,   50,  -75,   49,  -16,  -16,
			  134,  -16,  -16,  -16,  161,  162,  -16,  -37,  -16,   82,
			  -37,  -37,  165,  166,   68,   15,   66,  -37,   53,  132,
			   52,   51,    4,    3,  137,  131,  129,  174,  174,  177,
			    4,    3,   37,   67,  124,   66,  119,  180,  181,   53,
			  107,  108,  104,   97,  103,  105,   89,   88,   15,   21,
			   35,   65,   64,   62,   23,    6,    1,   13,    8,   11,

			  135,  112,  176,  139,   81,  143,  182,   39,  142,  133,
			  121,    0,   70,  160,   44,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,   69, yyDummy>>)
		end

	yycheck_template: SPECIAL [INTEGER]
			-- Template for `yycheck'
		once
			Result := yyfixed_array (<<
			    1,   28,   57,   71,   12,    6,   97,    8,   56,   84,
			   11,    8,    3,    4,   15,   12,    8,    8,    0,    8,
			   21,    0,   23,   14,   16,   26,   27,   24,   29,   84,
			   25,   99,   24,   81,   35,   24,  127,  112,    8,   19,
			    8,   11,   12,   11,   12,    8,   54,   48,   49,   50,
			   51,   52,   53,   16,   24,   82,   25,  112,   19,    3,
			    4,   62,    3,    4,   25,   66,   67,   68,    8,    9,
			   14,   11,   12,   13,    8,   25,   16,    8,   18,    8,
			   23,   12,   11,   12,   24,   23,  113,  155,   89,   18,
			   22,   92,    3,    4,    5,   24,   97,  165,  166,   22,

			    3,    4,    5,    8,    8,  106,  107,  108,   22,   22,
			  111,   14,   10,   23,   17,   13,  143,   15,   16,   16,
			    8,  122,  123,  124,   10,   23,  127,   13,   23,   15,
			   16,    8,   21,  134,   23,   21,    8,   23,    8,    9,
			   23,   11,   12,   13,  145,  146,   16,    8,   18,    9,
			   11,   12,  153,  154,   21,   10,   23,   18,   13,   22,
			   15,   16,    3,    4,    5,   22,    8,  168,  169,  170,
			    3,    4,    5,   21,   25,   23,    8,  178,  179,   13,
			   24,   21,    8,   12,   22,   24,   23,    8,   10,    9,
			   18,   22,   22,   11,   21,    7,    6,   22,   21,   23,

			  106,   81,  169,  111,   54,  117,  181,   26,  117,  102,
			   92,   -1,   48,  143,   29,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   48, yyDummy>>)
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

	yyvs2: SPECIAL [ET_IDENTIFIER]
			-- Stack for semantic values of type ET_IDENTIFIER

	yyvsc2: INTEGER
			-- Capacity of semantic value stack `yyvs2'

	yyvsp2: INTEGER
			-- Top of semantic value stack `yyvs2'

	yyspecial_routines2: KL_SPECIAL_ROUTINES [ET_IDENTIFIER]
			-- Routines that ought to be in SPECIAL [ET_IDENTIFIER]

	yyvs3: SPECIAL [ET_LACE_CLUSTER]
			-- Stack for semantic values of type ET_LACE_CLUSTER

	yyvsc3: INTEGER
			-- Capacity of semantic value stack `yyvs3'

	yyvsp3: INTEGER
			-- Top of semantic value stack `yyvs3'

	yyspecial_routines3: KL_SPECIAL_ROUTINES [ET_LACE_CLUSTER]
			-- Routines that ought to be in SPECIAL [ET_LACE_CLUSTER]

	yyvs4: SPECIAL [ET_LACE_CLUSTERS]
			-- Stack for semantic values of type ET_LACE_CLUSTERS

	yyvsc4: INTEGER
			-- Capacity of semantic value stack `yyvs4'

	yyvsp4: INTEGER
			-- Top of semantic value stack `yyvs4'

	yyspecial_routines4: KL_SPECIAL_ROUTINES [ET_LACE_CLUSTERS]
			-- Routines that ought to be in SPECIAL [ET_LACE_CLUSTERS]

	yyvs5: SPECIAL [ET_LACE_EXCLUDE]
			-- Stack for semantic values of type ET_LACE_EXCLUDE

	yyvsc5: INTEGER
			-- Capacity of semantic value stack `yyvs5'

	yyvsp5: INTEGER
			-- Top of semantic value stack `yyvs5'

	yyspecial_routines5: KL_SPECIAL_ROUTINES [ET_LACE_EXCLUDE]
			-- Routines that ought to be in SPECIAL [ET_LACE_EXCLUDE]

	yyvs6: SPECIAL [ET_LACE_DOTNET_ASSEMBLY]
			-- Stack for semantic values of type ET_LACE_DOTNET_ASSEMBLY

	yyvsc6: INTEGER
			-- Capacity of semantic value stack `yyvs6'

	yyvsp6: INTEGER
			-- Top of semantic value stack `yyvs6'

	yyspecial_routines6: KL_SPECIAL_ROUTINES [ET_LACE_DOTNET_ASSEMBLY]
			-- Routines that ought to be in SPECIAL [ET_LACE_DOTNET_ASSEMBLY]

	yyvs7: SPECIAL [ET_LACE_SYSTEM]
			-- Stack for semantic values of type ET_LACE_SYSTEM

	yyvsc7: INTEGER
			-- Capacity of semantic value stack `yyvs7'

	yyvsp7: INTEGER
			-- Top of semantic value stack `yyvs7'

	yyspecial_routines7: KL_SPECIAL_ROUTINES [ET_LACE_SYSTEM]
			-- Routines that ought to be in SPECIAL [ET_LACE_SYSTEM]

	yyvs8: SPECIAL [ET_ADAPTED_DOTNET_ASSEMBLIES]
			-- Stack for semantic values of type ET_ADAPTED_DOTNET_ASSEMBLIES

	yyvsc8: INTEGER
			-- Capacity of semantic value stack `yyvs8'

	yyvsp8: INTEGER
			-- Top of semantic value stack `yyvs8'

	yyspecial_routines8: KL_SPECIAL_ROUTINES [ET_ADAPTED_DOTNET_ASSEMBLIES]
			-- Routines that ought to be in SPECIAL [ET_ADAPTED_DOTNET_ASSEMBLIES]

feature {NONE} -- Constants

	yyFinal: INTEGER = 185
			-- Termination state id

	yyFlag: INTEGER = -32768
			-- Most negative INTEGER

	yyNtbase: INTEGER = 26
			-- Number of tokens

	yyLast: INTEGER = 231
			-- Upper bound of `yytable' and `yycheck'

	yyMax_token: INTEGER = 275
			-- Maximum token id
			-- (upper bound of `yytranslate'.)

	yyNsyms: INTEGER = 76
			-- Number of symbols
			-- (terminal and nonterminal)

feature -- User-defined features



end
