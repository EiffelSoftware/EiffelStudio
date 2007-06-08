indexing

	description:

		"Lace parsers"
  
	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 1999-2006, Eric Bezault and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
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
				yyvs2.put (last_et_identifier_value, yyvsp2)
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
			yyval2: ET_IDENTIFIER
			yyval4: ET_LACE_CLUSTERS
			yyval3: ET_LACE_CLUSTER
			yyval5: ET_LACE_EXCLUDE
			yyval7: ET_LACE_DOTNET_ASSEMBLIES
			yyval6: ET_LACE_DOTNET_ASSEMBLY
		do
			inspect yy_act
when 1 then
--|#line 50 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 50")
end

			last_universe := new_universe (yyvs4.item (yyvsp4))
			last_universe.set_dotnet_assemblies (yyvs7.item (yyvsp7))
			last_universe.set_system_name (yyvs2.item (yyvsp2 - 3).name)
			last_universe.set_root_class (yyvs2.item (yyvsp2 - 2))
			last_universe.set_root_creation (yyvs2.item (yyvsp2))
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 12
	yyvsp1 := yyvsp1 -5
	yyvsp2 := yyvsp2 -4
	yyvsp4 := yyvsp4 -1
	yyvsp7 := yyvsp7 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 2 then
--|#line 61 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 61")
end


if yy_parsing_status = yyContinue then
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
when 3 then
--|#line 63 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 63")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyvs2.put (yyval2, yyvsp2)
end
when 4 then
--|#line 67 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 67")
end


if yy_parsing_status = yyContinue then
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
when 5 then
--|#line 69 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 69")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs2.put (yyval2, yyvsp2)
end
when 6 then
--|#line 73 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 73")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs1.put (yyval1, yyvsp1)
end
when 7 then
--|#line 74 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 74")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 8 then
--|#line 77 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 77")
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
when 9 then
--|#line 78 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 78")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs1.put (yyval1, yyvsp1)
end
when 10 then
--|#line 81 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 81")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 11 then
--|#line 82 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 82")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyvs1.put (yyval1, yyvsp1)
end
when 12 then
--|#line 85 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 85")
end

yyval1 := new_default_value (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp1 := yyvsp1 -1
	yyvsp2 := yyvsp2 -2
	yyvs1.put (yyval1, yyvsp1)
end
when 13 then
--|#line 87 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 87")
end

yyval1 := new_default_value (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp1 := yyvsp1 -1
	yyvsp2 := yyvsp2 -2
	yyvs1.put (yyval1, yyvsp1)
end
when 14 then
--|#line 91 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 91")
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
when 15 then
--|#line 92 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 92")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs1.put (yyval1, yyvsp1)
end
when 16 then
--|#line 95 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 95")
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
when 17 then
--|#line 96 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 96")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs1.put (yyval1, yyvsp1)
end
when 18 then
--|#line 99 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 99")
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
when 19 then
--|#line 101 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 101")
end


if yy_parsing_status = yyContinue then
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
	yyvs4.put (yyval4, yyvsp4)
end
when 20 then
--|#line 103 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 103")
end

yyval4 := yyvs4.item (yyvsp4) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyvs4.put (yyval4, yyvsp4)
end
when 21 then
--|#line 107 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 107")
end

yyval4 := new_clusters (yyvs3.item (yyvsp3)) 
if yy_parsing_status = yyContinue then
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
	yyvs4.put (yyval4, yyvsp4)
end
when 22 then
--|#line 109 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 109")
end

-- TODO: syntax error: the cluster list cannot contain just
-- one subcluster that is qualified because it needs an unqualified
-- parent cluster.
			yyval4 := new_clusters (yyvs3.item (yyvsp3))
		
if yy_parsing_status = yyContinue then
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
	yyvs4.put (yyval4, yyvsp4)
end
when 23 then
--|#line 116 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 116")
end

yyval4 := yyvs4.item (yyvsp4); yyval4.put_last (yyvs3.item (yyvsp3)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp3 := yyvsp3 -1
	yyvs4.put (yyval4, yyvsp4)
end
when 24 then
--|#line 118 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 118")
end

				-- Note: the subcluster has already been inserted
				-- in the list of subclusters of its parent. So
				-- no need to add it to the top-level list of clusters.
			yyval4 := yyvs4.item (yyvsp4)
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp3 := yyvsp3 -1
	yyvs4.put (yyval4, yyvsp4)
end
when 25 then
--|#line 127 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 127")
end

yyval3 := yyvs3.item (yyvsp3); yyval3.set_abstract (True) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs3.put (yyval3, yyvsp3)
end
when 26 then
--|#line 129 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 129")
end

yyval3 := yyvs3.item (yyvsp3); yyval3.set_recursive (True) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp2 := yyvsp2 -1
	yyvs3.put (yyval3, yyvsp3)
end
when 27 then
--|#line 131 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 131")
end

			yyval3 := yyvs3.item (yyvsp3);
			yyval3.set_recursive (True)
			yyval3.set_read_only (True)
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs3.put (yyval3, yyvsp3)
end
when 28 then
--|#line 137 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 137")
end

yyval3 := yyvs3.item (yyvsp3) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs3.put (yyval3, yyvsp3)
end
when 29 then
--|#line 141 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 141")
end

			yyval3 := new_qualified_subcluster (yyvs2.item (yyvsp2 - 2), yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2), yyvs5.item (yyvsp5))
		
if yy_parsing_status = yyContinue then
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
	yyvs3.put (yyval3, yyvsp3)
end
when 30 then
--|#line 145 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 145")
end

			yyval3 := new_qualified_subcluster (yyvs2.item (yyvsp2 - 2), yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2), yyvs5.item (yyvsp5))
			yyval3.set_recursive (True)
		
if yy_parsing_status = yyContinue then
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
	yyvs3.put (yyval3, yyvsp3)
end
when 31 then
--|#line 150 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 150")
end

			yyval3 := new_qualified_subcluster (yyvs2.item (yyvsp2 - 2), yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2), yyvs5.item (yyvsp5))
			yyval3.set_recursive (True)
			yyval3.set_read_only (True)
		
if yy_parsing_status = yyContinue then
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
	yyvs3.put (yyval3, yyvsp3)
end
when 32 then
--|#line 158 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 158")
end

			yyval3 := new_cluster (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2))
			yyval3.set_exclude (yyvs5.item (yyvsp5))
			yyval3.set_subclusters (yyvs4.item (yyvsp4))
		
if yy_parsing_status = yyContinue then
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
	yyvs3.put (yyval3, yyvsp3)
end
when 33 then
--|#line 164 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 164")
end

			yyval3 := new_cluster (yyvs2.item (yyvsp2), Void)
			yyval3.set_exclude (yyvs5.item (yyvsp5))
			yyval3.set_subclusters (yyvs4.item (yyvsp4))
		
if yy_parsing_status = yyContinue then
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
	yyvs3.put (yyval3, yyvsp3)
end
when 34 then
--|#line 172 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 172")
end

			yyval3 := new_cluster (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2))
			yyval3.set_exclude (yyvs5.item (yyvsp5))
		
if yy_parsing_status = yyContinue then
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
	yyvs3.put (yyval3, yyvsp3)
end
when 35 then
--|#line 179 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 179")
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
when 36 then
--|#line 180 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 180")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs1.put (yyval1, yyvsp1)
end
when 37 then
--|#line 183 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 183")
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
when 38 then
--|#line 184 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 184")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs1.put (yyval1, yyvsp1)
end
when 39 then
--|#line 187 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 187")
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
when 40 then
--|#line 189 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 189")
end


if yy_parsing_status = yyContinue then
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
	yyvs4.put (yyval4, yyvsp4)
end
when 41 then
--|#line 191 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 191")
end

yyval4 := yyvs4.item (yyvsp4) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp1 := yyvsp1 -3
	yyvs4.put (yyval4, yyvsp4)
end
when 42 then
--|#line 195 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 195")
end

yyval4 := new_clusters (yyvs3.item (yyvsp3)) 
if yy_parsing_status = yyContinue then
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
	yyvs4.put (yyval4, yyvsp4)
end
when 43 then
--|#line 197 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 197")
end

yyval4 := yyvs4.item (yyvsp4); yyval4.put_last (yyvs3.item (yyvsp3)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp3 := yyvsp3 -1
	yyvs4.put (yyval4, yyvsp4)
end
when 44 then
--|#line 201 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 201")
end

yyval3 := yyvs3.item (yyvsp3); yyval3.set_abstract (True) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs3.put (yyval3, yyvsp3)
end
when 45 then
--|#line 203 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 203")
end

yyval3 := yyvs3.item (yyvsp3) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs3.put (yyval3, yyvsp3)
end
when 46 then
--|#line 207 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 207")
end


if yy_parsing_status = yyContinue then
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
	yyvs5.put (yyval5, yyvsp5)
end
when 47 then
--|#line 209 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 209")
end

yyval5 := yyvs5.item (yyvsp5) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp1 := yyvsp1 -4
	yyvs5.put (yyval5, yyvsp5)
end
when 48 then
--|#line 211 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 211")
end


if yy_parsing_status = yyContinue then
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
	yyvs5.put (yyval5, yyvsp5)
end
when 49 then
--|#line 213 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 213")
end


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
when 50 then
--|#line 215 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 215")
end


if yy_parsing_status = yyContinue then
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
	yyvs5.put (yyval5, yyvsp5)
end
when 51 then
--|#line 219 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 219")
end


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
when 52 then
--|#line 220 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 220")
end

yyval5 := yyvs5.item (yyvsp5) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs5.put (yyval5, yyvsp5)
end
when 53 then
--|#line 222 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 222")
end

yyval5 := yyvs5.item (yyvsp5) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyvs5.put (yyval5, yyvsp5)
end
when 54 then
--|#line 226 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 226")
end

create yyval5.make yyval5.put_last (yyvs2.item (yyvsp2)) 
if yy_parsing_status = yyContinue then
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
when 55 then
--|#line 228 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 228")
end

yyval5 := yyvs5.item (yyvsp5); yyval5.put_last (yyvs2.item (yyvsp2)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp2 := yyvsp2 -1
	yyvs5.put (yyval5, yyvsp5)
end
when 56 then
--|#line 232 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 232")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs1.put (yyval1, yyvsp1)
end
when 57 then
--|#line 233 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 233")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 58 then
--|#line 236 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 236")
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
when 59 then
--|#line 237 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 237")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs1.put (yyval1, yyvsp1)
end
when 60 then
--|#line 240 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 240")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 61 then
--|#line 241 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 241")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyvs1.put (yyval1, yyvsp1)
end
when 62 then
--|#line 244 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 244")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp1 := yyvsp1 -3
	yyvsp2 := yyvsp2 -2
	yyvs1.put (yyval1, yyvsp1)
end
when 63 then
--|#line 245 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 245")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp1 := yyvsp1 -3
	yyvsp2 := yyvsp2 -2
	yyvs1.put (yyval1, yyvsp1)
end
when 64 then
--|#line 249 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 249")
end


if yy_parsing_status = yyContinue then
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
when 65 then
--|#line 250 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 250")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp2 := yyvsp2 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 66 then
--|#line 253 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 253")
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
when 67 then
--|#line 254 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 254")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs1.put (yyval1, yyvsp1)
end
when 68 then
--|#line 257 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 257")
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
when 69 then
--|#line 258 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 258")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs1.put (yyval1, yyvsp1)
end
when 70 then
--|#line 261 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 261")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs1.put (yyval1, yyvsp1)
end
when 71 then
--|#line 262 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 262")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 72 then
--|#line 265 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 265")
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
when 73 then
--|#line 266 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 266")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs1.put (yyval1, yyvsp1)
end
when 74 then
--|#line 269 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 269")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp2 := yyvsp2 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 75 then
--|#line 270 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 270")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 76 then
--|#line 271 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 271")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyvs1.put (yyval1, yyvsp1)
end
when 77 then
--|#line 274 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 274")
end


if yy_parsing_status = yyContinue then
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
when 78 then
--|#line 275 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 275")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp2 := yyvsp2 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 79 then
--|#line 278 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 278")
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
when 80 then
--|#line 279 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 279")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs1.put (yyval1, yyvsp1)
end
when 81 then
--|#line 282 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 282")
end


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
when 82 then
--|#line 284 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 284")
end


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
when 83 then
--|#line 286 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 286")
end

yyval7 := yyvs7.item (yyvsp7) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyvs7.put (yyval7, yyvsp7)
end
when 84 then
--|#line 290 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 290")
end

yyval7 := new_assemblies (yyvs6.item (yyvsp6)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp7 := yyvsp7 + 1
	yyvsp6 := yyvsp6 -1
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
when 85 then
--|#line 292 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 292")
end

			yyval7 := yyvs7.item (yyvsp7)
			yyvs7.item (yyvsp7).put_last (yyvs6.item (yyvsp6))
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp6 := yyvsp6 -1
	yyvs7.put (yyval7, yyvsp7)
end
when 86 then
--|#line 299 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 299")
end

			yyval6 := new_assembly (yyvs2.item (yyvsp2 - 2), yyvs2.item (yyvsp2 - 1))
			yyval6.set_classname_prefix (yyvs2.item (yyvsp2))
		
if yy_parsing_status = yyContinue then
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
	yyvs6.put (yyval6, yyvsp6)
end
when 87 then
--|#line 304 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 304")
end

			yyval6 := new_gac_assembly (yyvs2.item (yyvsp2 - 5), yyvs2.item (yyvsp2 - 4), yyvs2.item (yyvsp2 - 3), yyvs2.item (yyvsp2 - 2), yyvs2.item (yyvsp2 - 1))
			yyval6.set_classname_prefix (yyvs2.item (yyvsp2))
		
if yy_parsing_status = yyContinue then
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
	yyvs6.put (yyval6, yyvsp6)
end
when 88 then
--|#line 311 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 311")
end


if yy_parsing_status = yyContinue then
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
when 89 then
--|#line 313 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 313")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyvs2.put (yyval2, yyvsp2)
end
when 90 then
--|#line 317 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 317")
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
when 91 then
--|#line 318 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 318")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs1.put (yyval1, yyvsp1)
end
when 92 then
--|#line 321 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 321")
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
when 93 then
--|#line 322 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 322")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs1.put (yyval1, yyvsp1)
end
when 94 then
--|#line 325 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 325")
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
when 95 then
--|#line 326 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 326")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs1.put (yyval1, yyvsp1)
end
when 96 then
--|#line 327 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 327")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 97 then
--|#line 330 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 330")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 98 then
--|#line 331 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 331")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyvs1.put (yyval1, yyvsp1)
end
when 99 then
--|#line 334 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 334")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp2 := yyvsp2 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 100 then
--|#line 335 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 335")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp1 := yyvsp1 -1
	yyvsp2 := yyvsp2 -2
	yyvs1.put (yyval1, yyvsp1)
end
when 101 then
--|#line 336 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 336")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp1 := yyvsp1 -1
	yyvsp2 := yyvsp2 -2
	yyvs1.put (yyval1, yyvsp1)
end
when 102 then
--|#line 339 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 339")
end


if yy_parsing_status = yyContinue then
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
when 103 then
--|#line 340 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 340")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp2 := yyvsp2 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 104 then
--|#line 343 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 343")
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
when 105 then
--|#line 344 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 344")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs1.put (yyval1, yyvsp1)
end
when 106 then
--|#line 347 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 347")
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
when 107 then
--|#line 348 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 348")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs1.put (yyval1, yyvsp1)
end
when 108 then
--|#line 351 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 351")
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
when 109 then
--|#line 352 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 352")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs1.put (yyval1, yyvsp1)
end
when 110 then
--|#line 353 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 353")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs1.put (yyval1, yyvsp1)
end
when 111 then
--|#line 356 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 356")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
when 112 then
--|#line 358 "et_lace_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_lace_parser.y' at line 358")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status = yyContinue then
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

	yyr1_template: SPECIAL [INTEGER] is
		once
			Result := yyfixed_array (<<
			    0,   45,   39,   39,   40,   40,   49,   49,   46,   46,
			   50,   50,   51,   51,   52,   52,   53,   53,   32,   32,
			   32,   31,   31,   31,   31,   26,   26,   26,   26,   30,
			   30,   30,   27,   27,   28,   54,   54,   55,   55,   33,
			   33,   33,   34,   34,   29,   29,   37,   37,   37,   37,
			   37,   35,   35,   35,   36,   36,   58,   58,   56,   56,
			   60,   60,   61,   61,   64,   64,   62,   62,   63,   63,
			   59,   59,   57,   57,   65,   65,   65,   66,   66,   67,
			   67,   44,   44,   44,   43,   43,   42,   42,   41,   41,
			   68,   68,   69,   69,   47,   47,   47,   70,   70,   71,

			   71,   71,   74,   74,   72,   72,   73,   73,   48,   48,
			   48,   38,   38, yyDummy>>)
		end

	yytypes1_template: SPECIAL [INTEGER] is
		once
			Result := yyfixed_array (<<
			    1,    1,    2,    2,    2,    1,    2,    1,    2,    2,
			    1,    2,    1,    2,    1,    1,    1,    2,    1,    1,
			    1,    4,    1,    1,    1,    1,    1,    1,    2,    3,
			    3,    3,    4,    2,    1,    7,    2,    2,    1,    3,
			    2,    3,    2,    3,    2,    1,    1,    1,    1,    1,
			    1,    1,    1,    5,    5,    1,    1,    1,    2,    6,
			    7,    1,    1,    1,    1,    1,    1,    1,    3,    3,
			    2,    2,    2,    1,    1,    5,    2,    2,    1,    1,
			    1,    1,    4,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    2,    1,    1,    1,    1,    2,    2,    2,

			    5,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    3,    3,    4,    1,    1,    2,    6,
			    1,    1,    1,    1,    1,    1,    1,    5,    1,    1,
			    4,    1,    1,    2,    2,    2,    1,    1,    3,    1,
			    1,    1,    1,    1,    2,    2,    1,    2,    2,    1,
			    1,    1,    2,    1,    1,    1,    1,    3,    2,    2,
			    1,    1,    1,    2,    2,    5,    1,    1,    1,    1,
			    2,    5,    5,    2,    1,    1,    2,    1,    1,    2,
			    2,    2,    1,    1,    1, yyDummy>>)
		end

	yytypes2_template: SPECIAL [INTEGER] is
		once
			Result := yyfixed_array (<<
			    1,    1,    1,    2,    2,    2,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1, yyDummy>>)
		end

	yydefact_template: SPECIAL [INTEGER] is
		once
			Result := yyfixed_array (<<
			    0,    0,  112,  111,    0,    0,    2,    0,    4,    0,
			    0,    8,    3,    5,    6,   18,    9,    0,    7,   16,
			   19,   81,    0,   17,   10,    0,    0,    0,    0,   21,
			   28,   22,   37,   46,   82,   94,    0,    0,   11,   27,
			    0,   25,   46,   26,    0,   38,   20,    0,    0,    0,
			   70,   51,   56,    8,   39,   58,   72,    0,    0,   84,
			   92,   95,  108,   13,   12,    0,    0,    0,   23,   24,
			   46,    0,   77,   71,   79,   52,   54,    0,   57,   68,
			   58,    0,   33,   72,   59,    0,   73,   50,    0,   93,
			   83,    0,    0,   96,  106,  109,    0,   46,    0,    0,

			   39,    0,   78,   80,    0,   53,    0,   69,   60,    0,
			   72,    0,   40,   45,   42,   37,    0,   49,   88,   85,
			    0,    0,  107,   97,    0,  110,    1,   34,    0,    0,
			   32,    0,   76,   55,    0,    0,   61,    0,   44,    0,
			    0,   48,    0,    0,   86,  102,   99,    0,    0,   98,
			    0,    0,   46,    0,    0,   47,   41,   43,    0,    0,
			    0,  101,  100,   46,   46,   29,    0,    0,    0,   89,
			  103,   31,   30,   64,   63,   62,    0,    0,    0,   65,
			   88,   87,    0,    0,    0, yyDummy>>)
		end

	yydefgoto_template: SPECIAL [INTEGER] is
		once
			Result := yyfixed_array (<<
			   29,   30,   39,  114,   31,   32,   21,   82,  115,   53,
			   75,   54,   42,    8,   11,  144,   59,   60,   35,  182,
			   15,   62,   96,   55,   18,   19,   24,   25,   46,   47,
			   83,   85,   56,   57,   78,   79,  108,  109,  174,   73,
			   74,  104,   90,   91,   93,   94,  123,  124,  146, yyDummy>>)
		end

	yypact_template: SPECIAL [INTEGER] is
		once
			Result := yyfixed_array (<<
			  183,  158, -32768, -32768,  189,  158,  182,  158,  181,  180,
			  158,  176, -32768, -32768,  158,  179, -32768,  178, -32768,   59,
			   95,  177,  151,  127, -32768,  158,  158,  158,  158, -32768,
			 -32768, -32768,    4,  111,  158,  174,  172,  171, -32768, -32768,
			  137, -32768,   46, -32768,  108,   68, -32768,   95,  158,  158,
			  158,  158,  158,  176,  164,  165,  152,  175,  169, -32768,
			   28,  158,  170, -32768, -32768,  158,  158,  158, -32768, -32768,
			  100,  168,  173, -32768,  167,  160, -32768,  159, -32768,   65,
			  165,  103, -32768,  152, -32768,  166, -32768, -32768,  158,   33,
			 -32768,  158,   -3, -32768,    2,  158,  163,  100,  157,  153,

			  164,  149,  162,  161,  158,  158,  148,   15, -32768,  158,
			  152,  158, -32768, -32768, -32768,   30,  156, -32768,   18, -32768,
			  158,  143,   66, -32768,  158, -32768, -32768, -32768,  140,  134,
			 -32768,  158, -32768, -32768,  122,  115, -32768,  125, -32768,  117,
			   88, -32768,  158,  158, -32768, -32768,   97,  106,   96, -32768,
			  158,  158,  100,   78,   70, -32768, -32768, -32768,   72,   80,
			  158, -32768, -32768,  100,  100, -32768,  158,  158,  158, -32768,
			 -32768, -32768, -32768, -32768,   57,   57,   38,  158,  158, -32768,
			   39, -32768,   42,   17, -32768, yyDummy>>)
		end

	yypgoto_template: SPECIAL [INTEGER] is
		once
			Result := yyfixed_array (<<
			  187,  -26,  186,   71,  185, -32768, -32768,  112, -32768, -32768,
			 -32768,  -68,   -1, -32768, -32768,   26,  119, -32768, -32768, -32768,
			  154, -32768, -32768,    0,  184, -32768, -32768, -32768,   90,   82,
			  121,  -75,  -48,  -53,   91, -32768, -32768, -32768,   31,   83,
			 -32768, -32768, -32768, -32768,  -90, -32768, -32768, -32768, -32768, yyDummy>>)
		end

	yytable_template: SPECIAL [INTEGER] is
		once
			Result := yyfixed_array (<<
			    4,   41,  100,   86,    6,  125,    9,   84,  116,   13,
			 -104,   16,  -35,   17, -104,  -35,  -35,  184,  121,   33,
			  120,   37,  -35,  -67,   17,   40,  122,   44,   45,  127,
			   86,  -67,   84,   58,  149,  137,  -90,  143,  -35,  -90,
			  -90,  -91,  183,  142,  -91,  -91,   33,   70,   71,   72,
			   76,   77,   89,   16,   45,  113,   14,   86,  143,   52,
			   92,   51,   50,  178,   97,   98,   99,  -14,  -14,   48,
			  -14,  -14,  -14,  -66, -105,  -14,  -36,  -14, -105,  -36,
			  -36,  -66,  177,   23,  165,  138,  -36,  118,  169,  107,
			   58,    3,    2,  167,   92,  171,  172,  168,    3,    2,

			   28,  166,  111,   72,  133,  135,    3,    2,   77,   27,
			   14,  112,   26,   52,  113,   51,   50,  111,  162,  145,
			  148,   14,  160,   92,   52,  156,   51,   50,  161,   67,
			  152,   65,   49,  155,   48,  -15,  -15,  154,  -15,  -15,
			  -15,  158,  159,  -15,  153,  -15,    3,    2,  147,  163,
			  164,    3,    2,  134,    3,    2,   36,  151,   66,  170,
			   65,    3,    2,  150,  141,  173,  173,  176,   50,  -75,
			  -74,  126,  131,   81,  117,  129,  179,  180,   52,  128,
			  106,  102,   95,   87,  105,   61,   14,  132,   20,    1,
			  101,  103,   88,   64,   63,   34,    5,  140,  175,   22,

			  136,  110,   12,    7,   10,  139,  181,   80,    0,   38,
			  119,  157,  130,    0,   43,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,   69,    0,   68, yyDummy>>)
		end

	yycheck_template: SPECIAL [INTEGER] is
		once
			Result := yyfixed_array (<<
			    1,   27,   70,   56,    5,   95,    7,   55,   83,   10,
			    8,   11,    8,   14,   12,   11,   12,    0,   21,   20,
			   23,   22,   18,    8,   25,   26,   24,   28,   24,   97,
			   83,   16,   80,   34,  124,  110,    8,   19,    8,   11,
			   12,    8,    0,   25,   11,   12,   47,   48,   49,   50,
			   51,   52,   24,   53,   24,   81,   10,  110,   19,   13,
			   61,   15,   16,   25,   65,   66,   67,    8,    9,   23,
			   11,   12,   13,    8,    8,   16,    8,   18,   12,   11,
			   12,   16,   25,   24,  152,  111,   18,   88,    8,   24,
			   91,    3,    4,   23,   95,  163,  164,   25,    3,    4,

			    5,   23,   14,  104,  105,  106,    3,    4,  109,   14,
			   10,    8,   17,   13,  140,   15,   16,   14,   22,  120,
			  121,   10,   25,  124,   13,    8,   15,   16,   22,   21,
			  131,   23,   21,    8,   23,    8,    9,   22,   11,   12,
			   13,  142,  143,   16,   22,   18,    3,    4,    5,  150,
			  151,    3,    4,    5,    3,    4,    5,   23,   21,  160,
			   23,    3,    4,   23,    8,  166,  167,  168,   16,    8,
			    8,    8,   23,    9,    8,   22,  177,  178,   13,   22,
			   21,    8,   12,    8,   24,   11,   10,  104,    9,    6,
			   22,   24,   23,   22,   22,   18,    7,  115,  167,   21,

			  109,   80,   22,   21,   23,  115,  180,   53,   -1,   25,
			   91,  140,  100,   -1,   28,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   47,   -1,   47, yyDummy>>)
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

	yyvs7: SPECIAL [ET_LACE_DOTNET_ASSEMBLIES]
			-- Stack for semantic values of type ET_LACE_DOTNET_ASSEMBLIES

	yyvsc7: INTEGER
			-- Capacity of semantic value stack `yyvs7'

	yyvsp7: INTEGER
			-- Top of semantic value stack `yyvs7'

	yyspecial_routines7: KL_SPECIAL_ROUTINES [ET_LACE_DOTNET_ASSEMBLIES]
			-- Routines that ought to be in SPECIAL [ET_LACE_DOTNET_ASSEMBLIES]

feature {NONE} -- Constants

	yyFinal: INTEGER is 184
			-- Termination state id

	yyFlag: INTEGER is -32768
			-- Most negative INTEGER

	yyNtbase: INTEGER is 26
			-- Number of tokens

	yyLast: INTEGER is 234
			-- Upper bound of `yytable' and `yycheck'

	yyMax_token: INTEGER is 275
			-- Maximum token id
			-- (upper bound of `yytranslate'.)

	yyNsyms: INTEGER is 75
			-- Number of symbols
			-- (terminal and nonterminal)

feature -- User-defined features



end
