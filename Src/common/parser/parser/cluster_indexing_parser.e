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
			yyr2 ?= yyr2_template
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
--|#line 79 "cluster_indexing.y"
	yy_do_action_1
when 2 then
--|#line 88 "cluster_indexing.y"
	yy_do_action_2
when 3 then
--|#line 90 "cluster_indexing.y"
	yy_do_action_3
when 4 then
--|#line 92 "cluster_indexing.y"
	yy_do_action_4
when 5 then
--|#line 96 "cluster_indexing.y"
	yy_do_action_5
when 6 then
--|#line 101 "cluster_indexing.y"
	yy_do_action_6
when 7 then
--|#line 108 "cluster_indexing.y"
	yy_do_action_7
when 8 then
--|#line 112 "cluster_indexing.y"
	yy_do_action_8
when 9 then
--|#line 114 "cluster_indexing.y"
	yy_do_action_9
when 10 then
--|#line 118 "cluster_indexing.y"
	yy_do_action_10
when 11 then
--|#line 123 "cluster_indexing.y"
	yy_do_action_11
when 12 then
--|#line 128 "cluster_indexing.y"
	yy_do_action_12
when 13 then
--|#line 135 "cluster_indexing.y"
	yy_do_action_13
when 14 then
--|#line 137 "cluster_indexing.y"
	yy_do_action_14
when 15 then
--|#line 142 "cluster_indexing.y"
	yy_do_action_15
when 16 then
--|#line 143 "cluster_indexing.y"
	yy_do_action_16
when 17 then
--|#line 150 "cluster_indexing.y"
	yy_do_action_17
when 18 then
--|#line 154 "cluster_indexing.y"
	yy_do_action_18
when 19 then
--|#line 156 "cluster_indexing.y"
	yy_do_action_19
when 20 then
--|#line 158 "cluster_indexing.y"
	yy_do_action_20
when 21 then
--|#line 160 "cluster_indexing.y"
	yy_do_action_21
when 22 then
--|#line 162 "cluster_indexing.y"
	yy_do_action_22
when 23 then
--|#line 164 "cluster_indexing.y"
	yy_do_action_23
when 24 then
--|#line 168 "cluster_indexing.y"
	yy_do_action_24
when 25 then
--|#line 170 "cluster_indexing.y"
	yy_do_action_25
when 26 then
--|#line 174 "cluster_indexing.y"
	yy_do_action_26
when 27 then
--|#line 181 "cluster_indexing.y"
	yy_do_action_27
when 28 then
--|#line 196 "cluster_indexing.y"
	yy_do_action_28
when 29 then
--|#line 211 "cluster_indexing.y"
	yy_do_action_29
when 30 then
--|#line 229 "cluster_indexing.y"
	yy_do_action_30
when 31 then
--|#line 231 "cluster_indexing.y"
	yy_do_action_31
when 32 then
--|#line 233 "cluster_indexing.y"
	yy_do_action_32
when 33 then
--|#line 240 "cluster_indexing.y"
	yy_do_action_33
when 34 then
--|#line 244 "cluster_indexing.y"
	yy_do_action_34
when 35 then
--|#line 246 "cluster_indexing.y"
	yy_do_action_35
when 36 then
--|#line 248 "cluster_indexing.y"
	yy_do_action_36
when 37 then
--|#line 252 "cluster_indexing.y"
	yy_do_action_37
when 38 then
--|#line 254 "cluster_indexing.y"
	yy_do_action_38
when 39 then
--|#line 256 "cluster_indexing.y"
	yy_do_action_39
when 40 then
--|#line 258 "cluster_indexing.y"
	yy_do_action_40
when 41 then
--|#line 260 "cluster_indexing.y"
	yy_do_action_41
when 42 then
--|#line 262 "cluster_indexing.y"
	yy_do_action_42
when 43 then
--|#line 264 "cluster_indexing.y"
	yy_do_action_43
when 44 then
--|#line 266 "cluster_indexing.y"
	yy_do_action_44
when 45 then
--|#line 268 "cluster_indexing.y"
	yy_do_action_45
when 46 then
--|#line 270 "cluster_indexing.y"
	yy_do_action_46
when 47 then
--|#line 272 "cluster_indexing.y"
	yy_do_action_47
when 48 then
--|#line 274 "cluster_indexing.y"
	yy_do_action_48
when 49 then
--|#line 276 "cluster_indexing.y"
	yy_do_action_49
when 50 then
--|#line 278 "cluster_indexing.y"
	yy_do_action_50
when 51 then
--|#line 280 "cluster_indexing.y"
	yy_do_action_51
when 52 then
--|#line 282 "cluster_indexing.y"
	yy_do_action_52
when 53 then
--|#line 284 "cluster_indexing.y"
	yy_do_action_53
when 54 then
--|#line 286 "cluster_indexing.y"
	yy_do_action_54
when 55 then
--|#line 288 "cluster_indexing.y"
	yy_do_action_55
when 56 then
--|#line 290 "cluster_indexing.y"
	yy_do_action_56
when 57 then
--|#line 292 "cluster_indexing.y"
	yy_do_action_57
			else
					-- No action
				yyval := yyval_default
			end
		end

	yy_do_action_1 is
			--|#line 79 "cluster_indexing.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 79")
end
			yyval := yyval_default;
				create root_node
				root_node.set_top_indexes (yytype11 (yyvs.item (yyvsp)))
			

		end

	yy_do_action_2 is
			--|#line 88 "cluster_indexing.y"
		local
			yyval11: INDEXING_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 88")
end


			yyval := yyval11
		end

	yy_do_action_3 is
			--|#line 90 "cluster_indexing.y"
		local
			yyval11: INDEXING_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 90")
end

yyval11 := yytype11 (yyvs.item (yyvsp)) 
			yyval := yyval11
		end

	yy_do_action_4 is
			--|#line 92 "cluster_indexing.y"
		local
			yyval11: INDEXING_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 92")
end


			yyval := yyval11
		end

	yy_do_action_5 is
			--|#line 96 "cluster_indexing.y"
		local
			yyval11: INDEXING_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 96")
end

				yyval11 := new_eiffel_list_index_as (Initial_index_list_size)
				yyval11.extend (yytype6 (yyvs.item (yyvsp)))
			
			yyval := yyval11
		end

	yy_do_action_6 is
			--|#line 101 "cluster_indexing.y"
		local
			yyval11: INDEXING_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 101")
end

				yyval11 := yytype11 (yyvs.item (yyvsp - 1))
				yyval11.extend (yytype6 (yyvs.item (yyvsp)))
			
			yyval := yyval11
		end

	yy_do_action_7 is
			--|#line 108 "cluster_indexing.y"
		local
			yyval6: INDEX_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 108")
end

yyval6 := new_index_as (yytype5 (yyvs.item (yyvsp - 2)), yytype10 (yyvs.item (yyvsp - 1))) 
			yyval := yyval6
		end

	yy_do_action_8 is
			--|#line 112 "cluster_indexing.y"
		local
			yyval5: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 112")
end

yyval5 := yytype5 (yyvs.item (yyvsp - 1)) 
			yyval := yyval5
		end

	yy_do_action_9 is
			--|#line 114 "cluster_indexing.y"
		local
			yyval5: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 114")
end


			yyval := yyval5
		end

	yy_do_action_10 is
			--|#line 118 "cluster_indexing.y"
		local
			yyval10: EIFFEL_LIST [ATOMIC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 118")
end

				yyval10 := new_eiffel_list_atomic_as (Initial_index_terms_size)
				yyval10.extend (yytype1 (yyvs.item (yyvsp)))
			
			yyval := yyval10
		end

	yy_do_action_11 is
			--|#line 123 "cluster_indexing.y"
		local
			yyval10: EIFFEL_LIST [ATOMIC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 123")
end

				yyval10 := yytype10 (yyvs.item (yyvsp - 2))
				yyval10.extend (yytype1 (yyvs.item (yyvsp)))
			
			yyval := yyval10
		end

	yy_do_action_12 is
			--|#line 128 "cluster_indexing.y"
		local
			yyval10: EIFFEL_LIST [ATOMIC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 128")
end

-- TO DO: remove this TE_SEMICOLON (see: INDEX_AS.index_list /= Void)
				yyval10 := new_eiffel_list_atomic_as (0)
			
			yyval := yyval10
		end

	yy_do_action_13 is
			--|#line 135 "cluster_indexing.y"
		local
			yyval1: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 135")
end

yyval1 := yytype5 (yyvs.item (yyvsp)) 
			yyval := yyval1
		end

	yy_do_action_14 is
			--|#line 137 "cluster_indexing.y"
		local
			yyval1: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 137")
end

yyval1 := yytype1 (yyvs.item (yyvsp)) 
			yyval := yyval1
		end

	yy_do_action_15 is
			--|#line 142 "cluster_indexing.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 142")
end
			yyval := yyval_default;


		end

	yy_do_action_16 is
			--|#line 143 "cluster_indexing.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 143")
end
			yyval := yyval_default;


		end

	yy_do_action_17 is
			--|#line 150 "cluster_indexing.y"
		local
			yyval5: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 150")
end

create yyval5.initialize (token_buffer) 
			yyval := yyval5
		end

	yy_do_action_18 is
			--|#line 154 "cluster_indexing.y"
		local
			yyval1: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 154")
end

yyval1 := yytype3 (yyvs.item (yyvsp)) 
			yyval := yyval1
		end

	yy_do_action_19 is
			--|#line 156 "cluster_indexing.y"
		local
			yyval1: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 156")
end

yyval1 := yytype4 (yyvs.item (yyvsp)) 
			yyval := yyval1
		end

	yy_do_action_20 is
			--|#line 158 "cluster_indexing.y"
		local
			yyval1: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 158")
end

yyval1 := yytype7 (yyvs.item (yyvsp)) 
			yyval := yyval1
		end

	yy_do_action_21 is
			--|#line 160 "cluster_indexing.y"
		local
			yyval1: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 160")
end

yyval1 := yytype8 (yyvs.item (yyvsp)) 
			yyval := yyval1
		end

	yy_do_action_22 is
			--|#line 162 "cluster_indexing.y"
		local
			yyval1: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 162")
end

yyval1 := yytype2 (yyvs.item (yyvsp)) 
			yyval := yyval1
		end

	yy_do_action_23 is
			--|#line 164 "cluster_indexing.y"
		local
			yyval1: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 164")
end

yyval1 := yytype9 (yyvs.item (yyvsp)) 
			yyval := yyval1
		end

	yy_do_action_24 is
			--|#line 168 "cluster_indexing.y"
		local
			yyval3: BOOL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 168")
end

yyval3 := new_boolean_as (False) 
			yyval := yyval3
		end

	yy_do_action_25 is
			--|#line 170 "cluster_indexing.y"
		local
			yyval3: BOOL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 170")
end

yyval3 := new_boolean_as (True) 
			yyval := yyval3
		end

	yy_do_action_26 is
			--|#line 174 "cluster_indexing.y"
		local
			yyval4: CHAR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 174")
end

				check is_character: not token_buffer.is_empty end
				yyval4 := new_character_as (token_buffer.item (1))
			
			yyval := yyval4
		end

	yy_do_action_27 is
			--|#line 181 "cluster_indexing.y"
		local
			yyval7: INTEGER_CONSTANT
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 181")
end

				if token_buffer.is_integer then
					yyval7 := new_integer_as (False, token_buffer)
				elseif
					token_buffer.item (1) = '0' and then
					token_buffer.item (2).lower = 'x'
				then
					yyval7 := new_integer_as_from_hexa (token_buffer)
				else
					report_integer_too_large_error (token_buffer)
						-- Dummy code (for error recovery) follows:
					yyval7 := new_integer_as (False, "0")
				end
			
			yyval := yyval7
		end

	yy_do_action_28 is
			--|#line 196 "cluster_indexing.y"
		local
			yyval7: INTEGER_CONSTANT
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 196")
end

				if token_buffer.is_integer then
					yyval7 := new_integer_as (False, token_buffer)
				elseif
					token_buffer.item (1) = '0' and then
					token_buffer.item (2).lower = 'x'
				then
					yyval7 := new_integer_as_from_hexa (token_buffer)
				else
					report_integer_too_large_error (token_buffer)
						-- Dummy code (for error recovery) follows:
					yyval7 := new_integer_as (False, "0")
				end
			
			yyval := yyval7
		end

	yy_do_action_29 is
			--|#line 211 "cluster_indexing.y"
		local
			yyval7: INTEGER_CONSTANT
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 211")
end

				if token_buffer.is_integer then
					yyval7 := new_integer_as (True, token_buffer)
				elseif
					token_buffer.item (1) = '0' and then
					token_buffer.item (2).lower = 'x'
				then
					yyval7 := new_integer_as_from_hexa (token_buffer)	
				else
					token_buffer.precede ('-')
					report_integer_too_small_error (token_buffer)
						-- Dummy code (for error recovery) follows:
					yyval7 := new_integer_as (False, "0")
				end
			
			yyval := yyval7
		end

	yy_do_action_30 is
			--|#line 229 "cluster_indexing.y"
		local
			yyval8: REAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 229")
end

yyval8 := new_real_as (cloned_string (token_buffer)) 
			yyval := yyval8
		end

	yy_do_action_31 is
			--|#line 231 "cluster_indexing.y"
		local
			yyval8: REAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 231")
end

yyval8 := new_real_as (cloned_string (token_buffer)) 
			yyval := yyval8
		end

	yy_do_action_32 is
			--|#line 233 "cluster_indexing.y"
		local
			yyval8: REAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 233")
end

				token_buffer.precede ('-')
				yyval8 := new_real_as (cloned_string (token_buffer))
			
			yyval := yyval8
		end

	yy_do_action_33 is
			--|#line 240 "cluster_indexing.y"
		local
			yyval2: BIT_CONST_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 240")
end

yyval2 := new_bit_const_as (create {ID_AS}.initialize (token_buffer)) 
			yyval := yyval2
		end

	yy_do_action_34 is
			--|#line 244 "cluster_indexing.y"
		local
			yyval9: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 244")
end

yyval9 := yytype9 (yyvs.item (yyvsp)) 
			yyval := yyval9
		end

	yy_do_action_35 is
			--|#line 246 "cluster_indexing.y"
		local
			yyval9: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 246")
end

yyval9 := new_empty_string_as 
			yyval := yyval9
		end

	yy_do_action_36 is
			--|#line 248 "cluster_indexing.y"
		local
			yyval9: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 248")
end

yyval9 := new_empty_verbatim_string_as (cloned_string (verbatim_marker)) 
			yyval := yyval9
		end

	yy_do_action_37 is
			--|#line 252 "cluster_indexing.y"
		local
			yyval9: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 252")
end

yyval9 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval9
		end

	yy_do_action_38 is
			--|#line 254 "cluster_indexing.y"
		local
			yyval9: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 254")
end

yyval9 := new_verbatim_string_as (cloned_string (token_buffer), cloned_string (verbatim_marker)) 
			yyval := yyval9
		end

	yy_do_action_39 is
			--|#line 256 "cluster_indexing.y"
		local
			yyval9: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 256")
end

yyval9 := new_lt_string_as 
			yyval := yyval9
		end

	yy_do_action_40 is
			--|#line 258 "cluster_indexing.y"
		local
			yyval9: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 258")
end

yyval9 := new_le_string_as 
			yyval := yyval9
		end

	yy_do_action_41 is
			--|#line 260 "cluster_indexing.y"
		local
			yyval9: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 260")
end

yyval9 := new_gt_string_as 
			yyval := yyval9
		end

	yy_do_action_42 is
			--|#line 262 "cluster_indexing.y"
		local
			yyval9: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 262")
end

yyval9 := new_ge_string_as 
			yyval := yyval9
		end

	yy_do_action_43 is
			--|#line 264 "cluster_indexing.y"
		local
			yyval9: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 264")
end

yyval9 := new_minus_string_as 
			yyval := yyval9
		end

	yy_do_action_44 is
			--|#line 266 "cluster_indexing.y"
		local
			yyval9: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 266")
end

yyval9 := new_plus_string_as 
			yyval := yyval9
		end

	yy_do_action_45 is
			--|#line 268 "cluster_indexing.y"
		local
			yyval9: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 268")
end

yyval9 := new_star_string_as 
			yyval := yyval9
		end

	yy_do_action_46 is
			--|#line 270 "cluster_indexing.y"
		local
			yyval9: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 270")
end

yyval9 := new_slash_string_as 
			yyval := yyval9
		end

	yy_do_action_47 is
			--|#line 272 "cluster_indexing.y"
		local
			yyval9: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 272")
end

yyval9 := new_mod_string_as 
			yyval := yyval9
		end

	yy_do_action_48 is
			--|#line 274 "cluster_indexing.y"
		local
			yyval9: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 274")
end

yyval9 := new_div_string_as 
			yyval := yyval9
		end

	yy_do_action_49 is
			--|#line 276 "cluster_indexing.y"
		local
			yyval9: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 276")
end

yyval9 := new_power_string_as 
			yyval := yyval9
		end

	yy_do_action_50 is
			--|#line 278 "cluster_indexing.y"
		local
			yyval9: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 278")
end

yyval9 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval9
		end

	yy_do_action_51 is
			--|#line 280 "cluster_indexing.y"
		local
			yyval9: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 280")
end

yyval9 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval9
		end

	yy_do_action_52 is
			--|#line 282 "cluster_indexing.y"
		local
			yyval9: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 282")
end

yyval9 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval9
		end

	yy_do_action_53 is
			--|#line 284 "cluster_indexing.y"
		local
			yyval9: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 284")
end

yyval9 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval9
		end

	yy_do_action_54 is
			--|#line 286 "cluster_indexing.y"
		local
			yyval9: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 286")
end

yyval9 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval9
		end

	yy_do_action_55 is
			--|#line 288 "cluster_indexing.y"
		local
			yyval9: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 288")
end

yyval9 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval9
		end

	yy_do_action_56 is
			--|#line 290 "cluster_indexing.y"
		local
			yyval9: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 290")
end

yyval9 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval9
		end

	yy_do_action_57 is
			--|#line 292 "cluster_indexing.y"
		local
			yyval9: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 292")
end

yyval9 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval9
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
			  125,  126>>)
		end

	yyr1_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    0,  142,  140,  140,  140,  141,  141,  134,  133,  133,
			  139,  139,  139,  127,  127,  143,  143,  132,  128,  128,
			  128,  128,  128,  128,  130,  130,  131,  135,  135,  135,
			  136,  136,  136,  129,  137,  137,  137,  138,  138,  138,
			  138,  138,  138,  138,  138,  138,  138,  138,  138,  138,
			  138,  138,  138,  138,  138,  138,  138,  138>>)
		end

	yyr2_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    0,    1,    0,    2,    1,    1,    2,    3,    2,    0,
			    1,    3,    1,    1,    1,    0,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    2,    2,
			    1,    2,    2,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1>>)
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
			    0,   30,   29,   28,   27,   26,   25,   24,   23,   22,

			   21,   20,   19,   18,   17,   16,   15,   14,   13,   12,
			   11,   10,    9,    0,    0,   30,   29,   28,   27,   26,
			   25,   24,   23,   22,   21,   20,   19,   18,   17,   16,
			   15,   14,   13,   12,   11,   10,    9>>)
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
			   -1,  105,  106,  107,  108,  109,  110,  111,  112,  113,

			  114,  115,  116,  117,  118,  119,  120,  121,  122,  123,
			  124,  125,  126,   -1,   -1,  105,  106,  107,  108,  109,
			  110,  111,  112,  113,  114,  115,  116,  117,  118,  119,
			  120,  121,  122,  123,  124,  125,  126>>)
		end

feature {NONE} -- Conversion

	yytype1 (v: ANY): ATOMIC_AS is
		require
			valid_type: yyis_type1 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type1 (v: ANY): BOOLEAN is
		local
			u: ATOMIC_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype2 (v: ANY): BIT_CONST_AS is
		require
			valid_type: yyis_type2 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type2 (v: ANY): BOOLEAN is
		local
			u: BIT_CONST_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype3 (v: ANY): BOOL_AS is
		require
			valid_type: yyis_type3 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type3 (v: ANY): BOOLEAN is
		local
			u: BOOL_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype4 (v: ANY): CHAR_AS is
		require
			valid_type: yyis_type4 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type4 (v: ANY): BOOLEAN is
		local
			u: CHAR_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype5 (v: ANY): ID_AS is
		require
			valid_type: yyis_type5 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type5 (v: ANY): BOOLEAN is
		local
			u: ID_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype6 (v: ANY): INDEX_AS is
		require
			valid_type: yyis_type6 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type6 (v: ANY): BOOLEAN is
		local
			u: INDEX_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype7 (v: ANY): INTEGER_CONSTANT is
		require
			valid_type: yyis_type7 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type7 (v: ANY): BOOLEAN is
		local
			u: INTEGER_CONSTANT
		do
			u ?= v
			Result := (u = v)
		end

	yytype8 (v: ANY): REAL_AS is
		require
			valid_type: yyis_type8 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type8 (v: ANY): BOOLEAN is
		local
			u: REAL_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype9 (v: ANY): STRING_AS is
		require
			valid_type: yyis_type9 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type9 (v: ANY): BOOLEAN is
		local
			u: STRING_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype10 (v: ANY): EIFFEL_LIST [ATOMIC_AS] is
		require
			valid_type: yyis_type10 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type10 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [ATOMIC_AS]
		do
			u ?= v
			Result := (u = v)
		end

	yytype11 (v: ANY): INDEXING_CLAUSE_AS is
		require
			valid_type: yyis_type11 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type11 (v: ANY): BOOLEAN is
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

	yyNtbase: INTEGER is 127
			-- Number of tokens

	yyLast: INTEGER is 136
			-- Upper bound of `yytable' and `yycheck'

	yyMax_token: INTEGER is 381
			-- Maximum token id
			-- (upper bound of `yytranslate'.)

	yyNsyms: INTEGER is 144
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
