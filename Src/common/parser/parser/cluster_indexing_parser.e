indexing

	description: "Cluster indexing parsers"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class CLUSTER_INDEXING_PARSER

inherit
	EIFFEL_PARSER_SKELETON

create
	make


feature {NONE} -- Implementation

	yy_build_parser_tables is
			-- Build parser tables.
		do
			yytranslate ?= yytranslate_template
			yyr1 ?= yyr1_template
			yytypes1 ?= yytypes1_template
			yytypes2 ?= yytypes2_template
			yydefact ?= yydefact_template
			yydefgoto ?= yydefgoto_template
			yypact ?= yypact_template
			yypgoto ?= yypgoto_template
			yytable ?= yytable_template
			yycheck ?= yycheck_template
		end

feature {NONE} -- Semantic actions

	yy_do_action (yy_act: INTEGER) is
			-- Execute semantic action.
		do
			inspect yy_act
			when 1 then
					--|#line 80 "cluster_indexing.y"
				yy_do_action_1
			when 2 then
					--|#line 89 "cluster_indexing.y"
				yy_do_action_2
			when 3 then
					--|#line 91 "cluster_indexing.y"
				yy_do_action_3
			when 4 then
					--|#line 93 "cluster_indexing.y"
				yy_do_action_4
			when 5 then
					--|#line 97 "cluster_indexing.y"
				yy_do_action_5
			when 6 then
					--|#line 102 "cluster_indexing.y"
				yy_do_action_6
			when 7 then
					--|#line 109 "cluster_indexing.y"
				yy_do_action_7
			when 8 then
					--|#line 113 "cluster_indexing.y"
				yy_do_action_8
			when 9 then
					--|#line 115 "cluster_indexing.y"
				yy_do_action_9
			when 10 then
					--|#line 119 "cluster_indexing.y"
				yy_do_action_10
			when 11 then
					--|#line 124 "cluster_indexing.y"
				yy_do_action_11
			when 12 then
					--|#line 129 "cluster_indexing.y"
				yy_do_action_12
			when 13 then
					--|#line 136 "cluster_indexing.y"
				yy_do_action_13
			when 14 then
					--|#line 138 "cluster_indexing.y"
				yy_do_action_14
			when 15 then
					--|#line 143 "cluster_indexing.y"
				yy_do_action_15
			when 16 then
					--|#line 144 "cluster_indexing.y"
				yy_do_action_16
			when 17 then
					--|#line 151 "cluster_indexing.y"
				yy_do_action_17
			when 18 then
					--|#line 155 "cluster_indexing.y"
				yy_do_action_18
			when 19 then
					--|#line 157 "cluster_indexing.y"
				yy_do_action_19
			when 20 then
					--|#line 159 "cluster_indexing.y"
				yy_do_action_20
			when 21 then
					--|#line 161 "cluster_indexing.y"
				yy_do_action_21
			when 22 then
					--|#line 163 "cluster_indexing.y"
				yy_do_action_22
			when 23 then
					--|#line 165 "cluster_indexing.y"
				yy_do_action_23
			when 24 then
					--|#line 169 "cluster_indexing.y"
				yy_do_action_24
			when 25 then
					--|#line 171 "cluster_indexing.y"
				yy_do_action_25
			when 26 then
					--|#line 175 "cluster_indexing.y"
				yy_do_action_26
			when 27 then
					--|#line 182 "cluster_indexing.y"
				yy_do_action_27
			when 28 then
					--|#line 197 "cluster_indexing.y"
				yy_do_action_28
			when 29 then
					--|#line 212 "cluster_indexing.y"
				yy_do_action_29
			when 30 then
					--|#line 230 "cluster_indexing.y"
				yy_do_action_30
			when 31 then
					--|#line 232 "cluster_indexing.y"
				yy_do_action_31
			when 32 then
					--|#line 234 "cluster_indexing.y"
				yy_do_action_32
			when 33 then
					--|#line 241 "cluster_indexing.y"
				yy_do_action_33
			when 34 then
					--|#line 245 "cluster_indexing.y"
				yy_do_action_34
			when 35 then
					--|#line 247 "cluster_indexing.y"
				yy_do_action_35
			when 36 then
					--|#line 249 "cluster_indexing.y"
				yy_do_action_36
			when 37 then
					--|#line 253 "cluster_indexing.y"
				yy_do_action_37
			when 38 then
					--|#line 255 "cluster_indexing.y"
				yy_do_action_38
			when 39 then
					--|#line 257 "cluster_indexing.y"
				yy_do_action_39
			when 40 then
					--|#line 259 "cluster_indexing.y"
				yy_do_action_40
			when 41 then
					--|#line 261 "cluster_indexing.y"
				yy_do_action_41
			when 42 then
					--|#line 263 "cluster_indexing.y"
				yy_do_action_42
			when 43 then
					--|#line 265 "cluster_indexing.y"
				yy_do_action_43
			when 44 then
					--|#line 267 "cluster_indexing.y"
				yy_do_action_44
			when 45 then
					--|#line 269 "cluster_indexing.y"
				yy_do_action_45
			when 46 then
					--|#line 271 "cluster_indexing.y"
				yy_do_action_46
			when 47 then
					--|#line 273 "cluster_indexing.y"
				yy_do_action_47
			when 48 then
					--|#line 275 "cluster_indexing.y"
				yy_do_action_48
			when 49 then
					--|#line 277 "cluster_indexing.y"
				yy_do_action_49
			when 50 then
					--|#line 279 "cluster_indexing.y"
				yy_do_action_50
			when 51 then
					--|#line 281 "cluster_indexing.y"
				yy_do_action_51
			when 52 then
					--|#line 283 "cluster_indexing.y"
				yy_do_action_52
			when 53 then
					--|#line 285 "cluster_indexing.y"
				yy_do_action_53
			when 54 then
					--|#line 287 "cluster_indexing.y"
				yy_do_action_54
			when 55 then
					--|#line 289 "cluster_indexing.y"
				yy_do_action_55
			when 56 then
					--|#line 291 "cluster_indexing.y"
				yy_do_action_56
			when 57 then
					--|#line 293 "cluster_indexing.y"
				yy_do_action_57
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
			--|#line 80 "cluster_indexing.y"
		do
--|#line 80 "cluster_indexing.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 80")
end

			yyval := yyval_default;
				create root_node
				root_node.set_top_indexes (yytype12 (yyvs.item (yyvsp)))
			

if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_2 is
			--|#line 89 "cluster_indexing.y"
		local
			yyval12: INDEXING_CLAUSE_AS
		do
--|#line 89 "cluster_indexing.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 89")
end



			yyval := yyval12
if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_3 is
			--|#line 91 "cluster_indexing.y"
		local
			yyval12: INDEXING_CLAUSE_AS
		do
--|#line 91 "cluster_indexing.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 91")
end


yyval12 := yytype12 (yyvs.item (yyvsp)) 
			yyval := yyval12
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_4 is
			--|#line 93 "cluster_indexing.y"
		local
			yyval12: INDEXING_CLAUSE_AS
		do
--|#line 93 "cluster_indexing.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 93")
end



			yyval := yyval12
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_5 is
			--|#line 97 "cluster_indexing.y"
		local
			yyval12: INDEXING_CLAUSE_AS
		do
--|#line 97 "cluster_indexing.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 97")
end


				yyval12 := new_eiffel_list_index_as (Initial_index_list_size)
				yyval12.extend (yytype7 (yyvs.item (yyvsp)))
			
			yyval := yyval12
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_6 is
			--|#line 102 "cluster_indexing.y"
		local
			yyval12: INDEXING_CLAUSE_AS
		do
--|#line 102 "cluster_indexing.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 102")
end


				yyval12 := yytype12 (yyvs.item (yyvsp - 1))
				yyval12.extend (yytype7 (yyvs.item (yyvsp)))
			
			yyval := yyval12
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_7 is
			--|#line 109 "cluster_indexing.y"
		local
			yyval7: INDEX_AS
		do
--|#line 109 "cluster_indexing.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 109")
end


yyval7 := new_index_as (yytype6 (yyvs.item (yyvsp - 2)), yytype11 (yyvs.item (yyvsp - 1)), current_position) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_8 is
			--|#line 113 "cluster_indexing.y"
		local
			yyval6: ID_AS
		do
--|#line 113 "cluster_indexing.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 113")
end


yyval6 := yytype6 (yyvs.item (yyvsp - 1)) 
			yyval := yyval6
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_9 is
			--|#line 115 "cluster_indexing.y"
		local
			yyval6: ID_AS
		do
--|#line 115 "cluster_indexing.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 115")
end



			yyval := yyval6
if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_10 is
			--|#line 119 "cluster_indexing.y"
		local
			yyval11: EIFFEL_LIST [ATOMIC_AS]
		do
--|#line 119 "cluster_indexing.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 119")
end


				yyval11 := new_eiffel_list_atomic_as (Initial_index_terms_size)
				yyval11.extend (yytype2 (yyvs.item (yyvsp)))
			
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_11 is
			--|#line 124 "cluster_indexing.y"
		local
			yyval11: EIFFEL_LIST [ATOMIC_AS]
		do
--|#line 124 "cluster_indexing.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 124")
end


				yyval11 := yytype11 (yyvs.item (yyvsp - 2))
				yyval11.extend (yytype2 (yyvs.item (yyvsp)))
			
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_12 is
			--|#line 129 "cluster_indexing.y"
		local
			yyval11: EIFFEL_LIST [ATOMIC_AS]
		do
--|#line 129 "cluster_indexing.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 129")
end


-- TO DO: remove this TE_SEMICOLON (see: INDEX_AS.index_list /= Void)
				yyval11 := new_eiffel_list_atomic_as (0)
			
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_13 is
			--|#line 136 "cluster_indexing.y"
		local
			yyval2: ATOMIC_AS
		do
--|#line 136 "cluster_indexing.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 136")
end


yyval2 := yytype6 (yyvs.item (yyvsp)) 
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_14 is
			--|#line 138 "cluster_indexing.y"
		local
			yyval2: ATOMIC_AS
		do
--|#line 138 "cluster_indexing.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 138")
end


yyval2 := yytype2 (yyvs.item (yyvsp)) 
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_15 is
			--|#line 143 "cluster_indexing.y"
		do
--|#line 143 "cluster_indexing.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 143")
end

			yyval := yyval_default;


if yy_parsing_status = yyContinue then
	yyvsp := yyvsp + 1
	if yyvsp >= yyvsc then
		yyvsc := yyvsc + yyInitial_stack_size
		yyvs := FIXED_ARRAY_.resize (yyvs, yyvsc)
		debug ("GEYACC")
			std.error.put_string ("Stack (yyvs) size increased to ")
			std.error.put_integer (yyvsc)
			std.error.put_new_line
		end
	end
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_16 is
			--|#line 144 "cluster_indexing.y"
		do
--|#line 144 "cluster_indexing.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 144")
end

			yyval := yyval_default;


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_17 is
			--|#line 151 "cluster_indexing.y"
		local
			yyval6: ID_AS
		do
--|#line 151 "cluster_indexing.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 151")
end


create yyval6.initialize (token_buffer) 
			yyval := yyval6
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_18 is
			--|#line 155 "cluster_indexing.y"
		local
			yyval2: ATOMIC_AS
		do
--|#line 155 "cluster_indexing.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 155")
end


yyval2 := yytype4 (yyvs.item (yyvsp)) 
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_19 is
			--|#line 157 "cluster_indexing.y"
		local
			yyval2: ATOMIC_AS
		do
--|#line 157 "cluster_indexing.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 157")
end


yyval2 := yytype5 (yyvs.item (yyvsp)) 
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_20 is
			--|#line 159 "cluster_indexing.y"
		local
			yyval2: ATOMIC_AS
		do
--|#line 159 "cluster_indexing.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 159")
end


yyval2 := yytype8 (yyvs.item (yyvsp)) 
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_21 is
			--|#line 161 "cluster_indexing.y"
		local
			yyval2: ATOMIC_AS
		do
--|#line 161 "cluster_indexing.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 161")
end


yyval2 := yytype9 (yyvs.item (yyvsp)) 
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_22 is
			--|#line 163 "cluster_indexing.y"
		local
			yyval2: ATOMIC_AS
		do
--|#line 163 "cluster_indexing.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 163")
end


yyval2 := yytype3 (yyvs.item (yyvsp)) 
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_23 is
			--|#line 165 "cluster_indexing.y"
		local
			yyval2: ATOMIC_AS
		do
--|#line 165 "cluster_indexing.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 165")
end


yyval2 := yytype10 (yyvs.item (yyvsp)) 
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_24 is
			--|#line 169 "cluster_indexing.y"
		local
			yyval4: BOOL_AS
		do
--|#line 169 "cluster_indexing.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 169")
end


yyval4 := new_boolean_as (False) 
			yyval := yyval4
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_25 is
			--|#line 171 "cluster_indexing.y"
		local
			yyval4: BOOL_AS
		do
--|#line 171 "cluster_indexing.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 171")
end


yyval4 := new_boolean_as (True) 
			yyval := yyval4
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_26 is
			--|#line 175 "cluster_indexing.y"
		local
			yyval5: CHAR_AS
		do
--|#line 175 "cluster_indexing.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 175")
end


				check is_character: not token_buffer.is_empty end
				yyval5 := new_character_as (token_buffer.item (1))
			
			yyval := yyval5
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_27 is
			--|#line 182 "cluster_indexing.y"
		local
			yyval8: INTEGER_CONSTANT
		do
--|#line 182 "cluster_indexing.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 182")
end


				if token_buffer.is_integer then
					yyval8 := new_integer_as (False, token_buffer)
				elseif
					token_buffer.item (1) = '0' and then
					token_buffer.item (2).lower = 'x'
				then
					yyval8 := new_integer_as_from_hexa (token_buffer)
				else
					report_integer_too_large_error (token_buffer)
						-- Dummy code (for error recovery) follows:
					yyval8 := new_integer_as (False, "0")
				end
			
			yyval := yyval8
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_28 is
			--|#line 197 "cluster_indexing.y"
		local
			yyval8: INTEGER_CONSTANT
		do
--|#line 197 "cluster_indexing.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 197")
end


				if token_buffer.is_integer then
					yyval8 := new_integer_as (False, token_buffer)
				elseif
					token_buffer.item (1) = '0' and then
					token_buffer.item (2).lower = 'x'
				then
					yyval8 := new_integer_as_from_hexa (token_buffer)
				else
					report_integer_too_large_error (token_buffer)
						-- Dummy code (for error recovery) follows:
					yyval8 := new_integer_as (False, "0")
				end
			
			yyval := yyval8
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_29 is
			--|#line 212 "cluster_indexing.y"
		local
			yyval8: INTEGER_CONSTANT
		do
--|#line 212 "cluster_indexing.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 212")
end


				if token_buffer.is_integer then
					yyval8 := new_integer_as (True, token_buffer)
				elseif
					token_buffer.item (1) = '0' and then
					token_buffer.item (2).lower = 'x'
				then
					yyval8 := new_integer_as_from_hexa (token_buffer)	
				else
					token_buffer.precede ('-')
					report_integer_too_small_error (token_buffer)
						-- Dummy code (for error recovery) follows:
					yyval8 := new_integer_as (False, "0")
				end
			
			yyval := yyval8
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_30 is
			--|#line 230 "cluster_indexing.y"
		local
			yyval9: REAL_AS
		do
--|#line 230 "cluster_indexing.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 230")
end


yyval9 := new_real_as (cloned_string (token_buffer)) 
			yyval := yyval9
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_31 is
			--|#line 232 "cluster_indexing.y"
		local
			yyval9: REAL_AS
		do
--|#line 232 "cluster_indexing.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 232")
end


yyval9 := new_real_as (cloned_string (token_buffer)) 
			yyval := yyval9
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_32 is
			--|#line 234 "cluster_indexing.y"
		local
			yyval9: REAL_AS
		do
--|#line 234 "cluster_indexing.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 234")
end


				token_buffer.precede ('-')
				yyval9 := new_real_as (cloned_string (token_buffer))
			
			yyval := yyval9
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_33 is
			--|#line 241 "cluster_indexing.y"
		local
			yyval3: BIT_CONST_AS
		do
--|#line 241 "cluster_indexing.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 241")
end


yyval3 := new_bit_const_as (create {ID_AS}.initialize (token_buffer)) 
			yyval := yyval3
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_34 is
			--|#line 245 "cluster_indexing.y"
		local
			yyval10: STRING_AS
		do
--|#line 245 "cluster_indexing.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 245")
end


yyval10 := yytype10 (yyvs.item (yyvsp)) 
			yyval := yyval10
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_35 is
			--|#line 247 "cluster_indexing.y"
		local
			yyval10: STRING_AS
		do
--|#line 247 "cluster_indexing.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 247")
end


yyval10 := new_empty_string_as 
			yyval := yyval10
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_36 is
			--|#line 249 "cluster_indexing.y"
		local
			yyval10: STRING_AS
		do
--|#line 249 "cluster_indexing.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 249")
end


yyval10 := new_empty_verbatim_string_as (cloned_string (verbatim_marker)) 
			yyval := yyval10
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_37 is
			--|#line 253 "cluster_indexing.y"
		local
			yyval10: STRING_AS
		do
--|#line 253 "cluster_indexing.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 253")
end


yyval10 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval10
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_38 is
			--|#line 255 "cluster_indexing.y"
		local
			yyval10: STRING_AS
		do
--|#line 255 "cluster_indexing.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 255")
end


yyval10 := new_verbatim_string_as (cloned_string (token_buffer), cloned_string (verbatim_marker)) 
			yyval := yyval10
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_39 is
			--|#line 257 "cluster_indexing.y"
		local
			yyval10: STRING_AS
		do
--|#line 257 "cluster_indexing.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 257")
end


yyval10 := new_lt_string_as 
			yyval := yyval10
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_40 is
			--|#line 259 "cluster_indexing.y"
		local
			yyval10: STRING_AS
		do
--|#line 259 "cluster_indexing.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 259")
end


yyval10 := new_le_string_as 
			yyval := yyval10
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_41 is
			--|#line 261 "cluster_indexing.y"
		local
			yyval10: STRING_AS
		do
--|#line 261 "cluster_indexing.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 261")
end


yyval10 := new_gt_string_as 
			yyval := yyval10
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_42 is
			--|#line 263 "cluster_indexing.y"
		local
			yyval10: STRING_AS
		do
--|#line 263 "cluster_indexing.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 263")
end


yyval10 := new_ge_string_as 
			yyval := yyval10
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_43 is
			--|#line 265 "cluster_indexing.y"
		local
			yyval10: STRING_AS
		do
--|#line 265 "cluster_indexing.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 265")
end


yyval10 := new_minus_string_as 
			yyval := yyval10
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_44 is
			--|#line 267 "cluster_indexing.y"
		local
			yyval10: STRING_AS
		do
--|#line 267 "cluster_indexing.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 267")
end


yyval10 := new_plus_string_as 
			yyval := yyval10
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_45 is
			--|#line 269 "cluster_indexing.y"
		local
			yyval10: STRING_AS
		do
--|#line 269 "cluster_indexing.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 269")
end


yyval10 := new_star_string_as 
			yyval := yyval10
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_46 is
			--|#line 271 "cluster_indexing.y"
		local
			yyval10: STRING_AS
		do
--|#line 271 "cluster_indexing.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 271")
end


yyval10 := new_slash_string_as 
			yyval := yyval10
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_47 is
			--|#line 273 "cluster_indexing.y"
		local
			yyval10: STRING_AS
		do
--|#line 273 "cluster_indexing.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 273")
end


yyval10 := new_mod_string_as 
			yyval := yyval10
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_48 is
			--|#line 275 "cluster_indexing.y"
		local
			yyval10: STRING_AS
		do
--|#line 275 "cluster_indexing.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 275")
end


yyval10 := new_div_string_as 
			yyval := yyval10
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_49 is
			--|#line 277 "cluster_indexing.y"
		local
			yyval10: STRING_AS
		do
--|#line 277 "cluster_indexing.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 277")
end


yyval10 := new_power_string_as 
			yyval := yyval10
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_50 is
			--|#line 279 "cluster_indexing.y"
		local
			yyval10: STRING_AS
		do
--|#line 279 "cluster_indexing.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 279")
end


yyval10 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval10
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_51 is
			--|#line 281 "cluster_indexing.y"
		local
			yyval10: STRING_AS
		do
--|#line 281 "cluster_indexing.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 281")
end


yyval10 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval10
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_52 is
			--|#line 283 "cluster_indexing.y"
		local
			yyval10: STRING_AS
		do
--|#line 283 "cluster_indexing.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 283")
end


yyval10 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval10
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_53 is
			--|#line 285 "cluster_indexing.y"
		local
			yyval10: STRING_AS
		do
--|#line 285 "cluster_indexing.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 285")
end


yyval10 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval10
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_54 is
			--|#line 287 "cluster_indexing.y"
		local
			yyval10: STRING_AS
		do
--|#line 287 "cluster_indexing.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 287")
end


yyval10 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval10
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_55 is
			--|#line 289 "cluster_indexing.y"
		local
			yyval10: STRING_AS
		do
--|#line 289 "cluster_indexing.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 289")
end


yyval10 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval10
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_56 is
			--|#line 291 "cluster_indexing.y"
		local
			yyval10: STRING_AS
		do
--|#line 291 "cluster_indexing.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 291")
end


yyval10 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval10
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_57 is
			--|#line 293 "cluster_indexing.y"
		local
			yyval10: STRING_AS
		do
--|#line 293 "cluster_indexing.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 293")
end


yyval10 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval10
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_error_action (yy_act: INTEGER) is
			-- Execute error action.
		do
			inspect yy_act
			when 61 then
					-- End-of-file expected action.
				report_eof_expected_error
			else
					-- Default action.
				report_error ("parse error")
			end
		end

feature {NONE} -- Table templates

	yytranslate_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
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
			   35,   36,   37,   38,   39,   40,   41,   42,   43,   44,

			   45,   46,   47,   48,   49,   50,   51,   52,   53,   54,
			   55,   56,   57,   58,   59,   60,   61,   62,   63,   64,
			   65,   66,   67,   68,   69,   70,   71,   72,   73,   74,
			   75,   76,   77,   78,   79,   80,   81,   82,   83,   84,
			   85,   86,   87,   88,   89,   90,   91,   92,   93,   94,
			   95,   96,   97,   98,   99,  100,  101,  102,  103,  104,
			  105,  106,  107,  108,  109,  110,  111,  112,  113,  114,
			  115,  116,  117,  118,  119,  120,  121,  122,  123,  124,
			  125,  126,  127,  128,  129>>)
		end

	yyr1_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    0,  145,  143,  143,  143,  144,  144,  137,  136,  136,
			  142,  142,  142,  130,  130,  146,  146,  135,  131,  131,
			  131,  131,  131,  131,  133,  133,  134,  138,  138,  138,
			  139,  139,  139,  132,  140,  140,  140,  141,  141,  141,
			  141,  141,  141,  141,  141,  141,  141,  141,  141,  141,
			  141,  141,  141,  141,  141,  141,  141,  141>>)
		end

	yytypes1_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    1,    1,   12,    1,    6,    6,    7,   12,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    2,    2,    3,    4,    5,    6,    8,    9,   10,
			   10,   11,    7,    1,    1,    1,    1,    1,    1,    1,
			    2,    1,    1,    1>>)
		end

	yytypes2_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,

			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1>>)
		end

	yydefact_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    2,    9,    1,   17,    0,    0,    5,    9,    8,   57,
			   56,   55,   54,   53,   52,   51,   50,   49,   48,   47,
			   46,   45,   44,   43,   42,   41,   40,   39,   36,   38,
			   35,   25,   24,   12,   33,   37,   30,   26,   27,    0,
			    0,   10,   14,   22,   18,   19,   13,   20,   21,   23,
			   34,   15,    6,   32,   29,   31,   28,    0,   16,    7,
			   11,    0,    0,    0>>)
		end

	yydefgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			   41,   42,   43,   44,   45,    4,    5,    6,   47,   48,
			   49,   50,   51,    2,    7,   61,   59>>)
		end

	yypact_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			  -61,   12, -32768, -32768,  -29,  -14, -32768,    3, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,  -20,
			  -23, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768,  -33, -32768, -32768, -32768, -32768, -32768,   10, -32768, -32768,
			 -32768,   13,    5, -32768>>)
		end

	yypgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			  -35, -32768, -32768, -32768, -32768,   -3, -32768,   14, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768>>)
		end

	yytable_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			   40,   39,   46,   -3,   58,   63,   56,   57,   55,   54,
			    8,   53,   -4,   62,    1,   38,   37,   36,   35,    3,
			   34,   52,   60,   33,   40,   39,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    3,   32,   31,   38,
			   37,   36,   35,    3,   34,    3,    0,    0,    0,    0,
			    0,    0,    0,    0,   46,    0,    0,    0,    0,    0,
			    0,   32,   31,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,   30,   29,   28,    0,   27,   26,   25,

			   24,   23,   22,   21,   20,   19,   18,   17,   16,   15,
			   14,   13,   12,   11,   10,    9,    0,   30,   29,   28,
			    0,   27,   26,   25,   24,   23,   22,   21,   20,   19,
			   18,   17,   16,   15,   14,   13,   12,   11,   10,    9>>)
		end

	yycheck_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			   14,   15,    5,    0,   37,    0,   29,   40,   31,   29,
			   39,   31,    0,    0,   75,   29,   30,   31,   32,   33,
			   34,    7,   57,   37,   14,   15,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   33,   51,   52,   29,
			   30,   31,   32,   33,   34,   33,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   57,   -1,   -1,   -1,   -1,   -1,
			   -1,   51,   52,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,  107,  108,  109,   -1,  111,  112,  113,

			  114,  115,  116,  117,  118,  119,  120,  121,  122,  123,
			  124,  125,  126,  127,  128,  129,   -1,  107,  108,  109,
			   -1,  111,  112,  113,  114,  115,  116,  117,  118,  119,
			  120,  121,  122,  123,  124,  125,  126,  127,  128,  129>>)
		end

feature {NONE} -- Conversion

	yytype2 (v: ANY): ATOMIC_AS is
		require
			valid_type: yyis_type2 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type2 (v: ANY): BOOLEAN is
		local
			u: ATOMIC_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype3 (v: ANY): BIT_CONST_AS is
		require
			valid_type: yyis_type3 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type3 (v: ANY): BOOLEAN is
		local
			u: BIT_CONST_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype4 (v: ANY): BOOL_AS is
		require
			valid_type: yyis_type4 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type4 (v: ANY): BOOLEAN is
		local
			u: BOOL_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype5 (v: ANY): CHAR_AS is
		require
			valid_type: yyis_type5 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type5 (v: ANY): BOOLEAN is
		local
			u: CHAR_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype6 (v: ANY): ID_AS is
		require
			valid_type: yyis_type6 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type6 (v: ANY): BOOLEAN is
		local
			u: ID_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype7 (v: ANY): INDEX_AS is
		require
			valid_type: yyis_type7 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type7 (v: ANY): BOOLEAN is
		local
			u: INDEX_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype8 (v: ANY): INTEGER_CONSTANT is
		require
			valid_type: yyis_type8 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type8 (v: ANY): BOOLEAN is
		local
			u: INTEGER_CONSTANT
		do
			u ?= v
			Result := (u = v)
		end

	yytype9 (v: ANY): REAL_AS is
		require
			valid_type: yyis_type9 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type9 (v: ANY): BOOLEAN is
		local
			u: REAL_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype10 (v: ANY): STRING_AS is
		require
			valid_type: yyis_type10 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type10 (v: ANY): BOOLEAN is
		local
			u: STRING_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype11 (v: ANY): EIFFEL_LIST [ATOMIC_AS] is
		require
			valid_type: yyis_type11 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type11 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [ATOMIC_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype12 (v: ANY): INDEXING_CLAUSE_AS is
		require
			valid_type: yyis_type12 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type12 (v: ANY): BOOLEAN is
		local
			u: INDEXING_CLAUSE_AS
		do
			u ?= v
			Result := (u = v)
		end


feature {NONE} -- Constants

	yyFinal: INTEGER is 63
			-- Termination state id

	yyFlag: INTEGER is -32768
			-- Most negative INTEGER

	yyNtbase: INTEGER is 130
			-- Number of tokens

	yyLast: INTEGER is 139
			-- Upper bound of `yytable' and `yycheck'

	yyMax_token: INTEGER is 384
			-- Maximum token id
			-- (upper bound of `yytranslate'.)

	yyNsyms: INTEGER is 147
			-- Number of symbols
			-- (terminal and nonterminal)

feature -- User-defined features



end -- class EIFFEL_PARSER


--|----------------------------------------------------------------
--| Copyright (C) 1992-2000, Interactive Software Engineering Inc.
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
