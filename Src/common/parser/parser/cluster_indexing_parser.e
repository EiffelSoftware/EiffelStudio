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
--|#line 81 "cluster_indexing.y"
	yy_do_action_1
when 2 then
--|#line 90 "cluster_indexing.y"
	yy_do_action_2
when 3 then
--|#line 92 "cluster_indexing.y"
	yy_do_action_3
when 4 then
--|#line 94 "cluster_indexing.y"
	yy_do_action_4
when 5 then
--|#line 98 "cluster_indexing.y"
	yy_do_action_5
when 6 then
--|#line 103 "cluster_indexing.y"
	yy_do_action_6
when 7 then
--|#line 110 "cluster_indexing.y"
	yy_do_action_7
when 8 then
--|#line 114 "cluster_indexing.y"
	yy_do_action_8
when 9 then
--|#line 116 "cluster_indexing.y"
	yy_do_action_9
when 10 then
--|#line 120 "cluster_indexing.y"
	yy_do_action_10
when 11 then
--|#line 125 "cluster_indexing.y"
	yy_do_action_11
when 12 then
--|#line 130 "cluster_indexing.y"
	yy_do_action_12
when 13 then
--|#line 137 "cluster_indexing.y"
	yy_do_action_13
when 14 then
--|#line 139 "cluster_indexing.y"
	yy_do_action_14
when 15 then
--|#line 144 "cluster_indexing.y"
	yy_do_action_15
when 16 then
--|#line 145 "cluster_indexing.y"
	yy_do_action_16
when 17 then
--|#line 152 "cluster_indexing.y"
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
--|#line 166 "cluster_indexing.y"
	yy_do_action_24
when 25 then
--|#line 168 "cluster_indexing.y"
	yy_do_action_25
when 26 then
--|#line 170 "cluster_indexing.y"
	yy_do_action_26
when 27 then
--|#line 172 "cluster_indexing.y"
	yy_do_action_27
when 28 then
--|#line 174 "cluster_indexing.y"
	yy_do_action_28
when 29 then
--|#line 178 "cluster_indexing.y"
	yy_do_action_29
when 30 then
--|#line 180 "cluster_indexing.y"
	yy_do_action_30
when 31 then
--|#line 182 "cluster_indexing.y"
	yy_do_action_31
when 32 then
--|#line 184 "cluster_indexing.y"
	yy_do_action_32
when 33 then
--|#line 186 "cluster_indexing.y"
	yy_do_action_33
when 34 then
--|#line 188 "cluster_indexing.y"
	yy_do_action_34
when 35 then
--|#line 192 "cluster_indexing.y"
	yy_do_action_35
when 36 then
--|#line 194 "cluster_indexing.y"
	yy_do_action_36
when 37 then
--|#line 198 "cluster_indexing.y"
	yy_do_action_37
when 38 then
--|#line 205 "cluster_indexing.y"
	yy_do_action_38
when 39 then
--|#line 220 "cluster_indexing.y"
	yy_do_action_39
when 40 then
--|#line 235 "cluster_indexing.y"
	yy_do_action_40
when 41 then
--|#line 253 "cluster_indexing.y"
	yy_do_action_41
when 42 then
--|#line 255 "cluster_indexing.y"
	yy_do_action_42
when 43 then
--|#line 257 "cluster_indexing.y"
	yy_do_action_43
when 44 then
--|#line 264 "cluster_indexing.y"
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
--|#line 276 "cluster_indexing.y"
	yy_do_action_48
when 49 then
--|#line 278 "cluster_indexing.y"
	yy_do_action_49
when 50 then
--|#line 280 "cluster_indexing.y"
	yy_do_action_50
when 51 then
--|#line 282 "cluster_indexing.y"
	yy_do_action_51
when 52 then
--|#line 284 "cluster_indexing.y"
	yy_do_action_52
when 53 then
--|#line 286 "cluster_indexing.y"
	yy_do_action_53
when 54 then
--|#line 288 "cluster_indexing.y"
	yy_do_action_54
when 55 then
--|#line 290 "cluster_indexing.y"
	yy_do_action_55
when 56 then
--|#line 292 "cluster_indexing.y"
	yy_do_action_56
when 57 then
--|#line 294 "cluster_indexing.y"
	yy_do_action_57
when 58 then
--|#line 296 "cluster_indexing.y"
	yy_do_action_58
when 59 then
--|#line 298 "cluster_indexing.y"
	yy_do_action_59
when 60 then
--|#line 300 "cluster_indexing.y"
	yy_do_action_60
when 61 then
--|#line 302 "cluster_indexing.y"
	yy_do_action_61
when 62 then
--|#line 304 "cluster_indexing.y"
	yy_do_action_62
when 63 then
--|#line 306 "cluster_indexing.y"
	yy_do_action_63
when 64 then
--|#line 308 "cluster_indexing.y"
	yy_do_action_64
when 65 then
--|#line 310 "cluster_indexing.y"
	yy_do_action_65
when 66 then
--|#line 312 "cluster_indexing.y"
	yy_do_action_66
when 67 then
--|#line 314 "cluster_indexing.y"
	yy_do_action_67
when 68 then
--|#line 316 "cluster_indexing.y"
	yy_do_action_68
			else
					-- No action
				yyval := yyval_default
			end
		end

	yy_do_action_1 is
			--|#line 81 "cluster_indexing.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 81")
end
			yyval := yyval_default;
				create root_node
				root_node.set_top_indexes (yytype11 (yyvs.item (yyvsp)))
			

		end

	yy_do_action_2 is
			--|#line 90 "cluster_indexing.y"
		local
			yyval11: INDEXING_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 90")
end


			yyval := yyval11
		end

	yy_do_action_3 is
			--|#line 92 "cluster_indexing.y"
		local
			yyval11: INDEXING_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 92")
end

yyval11 := yytype11 (yyvs.item (yyvsp)) 
			yyval := yyval11
		end

	yy_do_action_4 is
			--|#line 94 "cluster_indexing.y"
		local
			yyval11: INDEXING_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 94")
end


			yyval := yyval11
		end

	yy_do_action_5 is
			--|#line 98 "cluster_indexing.y"
		local
			yyval11: INDEXING_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 98")
end

				yyval11 := new_eiffel_list_index_as (Initial_index_list_size)
				yyval11.extend (yytype6 (yyvs.item (yyvsp)))
			
			yyval := yyval11
		end

	yy_do_action_6 is
			--|#line 103 "cluster_indexing.y"
		local
			yyval11: INDEXING_CLAUSE_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 103")
end

				yyval11 := yytype11 (yyvs.item (yyvsp - 1))
				yyval11.extend (yytype6 (yyvs.item (yyvsp)))
			
			yyval := yyval11
		end

	yy_do_action_7 is
			--|#line 110 "cluster_indexing.y"
		local
			yyval6: INDEX_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 110")
end

yyval6 := new_index_as (yytype5 (yyvs.item (yyvsp - 2)), yytype10 (yyvs.item (yyvsp - 1))) 
			yyval := yyval6
		end

	yy_do_action_8 is
			--|#line 114 "cluster_indexing.y"
		local
			yyval5: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 114")
end

yyval5 := yytype5 (yyvs.item (yyvsp - 1)) 
			yyval := yyval5
		end

	yy_do_action_9 is
			--|#line 116 "cluster_indexing.y"
		local
			yyval5: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 116")
end


			yyval := yyval5
		end

	yy_do_action_10 is
			--|#line 120 "cluster_indexing.y"
		local
			yyval10: EIFFEL_LIST [ATOMIC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 120")
end

				yyval10 := new_eiffel_list_atomic_as (Initial_index_terms_size)
				yyval10.extend (yytype1 (yyvs.item (yyvsp)))
			
			yyval := yyval10
		end

	yy_do_action_11 is
			--|#line 125 "cluster_indexing.y"
		local
			yyval10: EIFFEL_LIST [ATOMIC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 125")
end

				yyval10 := yytype10 (yyvs.item (yyvsp - 2))
				yyval10.extend (yytype1 (yyvs.item (yyvsp)))
			
			yyval := yyval10
		end

	yy_do_action_12 is
			--|#line 130 "cluster_indexing.y"
		local
			yyval10: EIFFEL_LIST [ATOMIC_AS]
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 130")
end

-- TO DO: remove this TE_SEMICOLON (see: INDEX_AS.index_list /= Void)
				yyval10 := new_eiffel_list_atomic_as (0)
			
			yyval := yyval10
		end

	yy_do_action_13 is
			--|#line 137 "cluster_indexing.y"
		local
			yyval1: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 137")
end

yyval1 := yytype5 (yyvs.item (yyvsp)) 
			yyval := yyval1
		end

	yy_do_action_14 is
			--|#line 139 "cluster_indexing.y"
		local
			yyval1: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 139")
end

yyval1 := yytype1 (yyvs.item (yyvsp)) 
			yyval := yyval1
		end

	yy_do_action_15 is
			--|#line 144 "cluster_indexing.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 144")
end
			yyval := yyval_default;


		end

	yy_do_action_16 is
			--|#line 145 "cluster_indexing.y"
		local

		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 145")
end
			yyval := yyval_default;


		end

	yy_do_action_17 is
			--|#line 152 "cluster_indexing.y"
		local
			yyval5: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 152")
end

create yyval5.initialize (token_buffer) 
			yyval := yyval5
		end

	yy_do_action_18 is
			--|#line 154 "cluster_indexing.y"
		local
			yyval5: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 154")
end

yyval5 := new_boolean_id_as 
			yyval := yyval5
		end

	yy_do_action_19 is
			--|#line 156 "cluster_indexing.y"
		local
			yyval5: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 156")
end

yyval5 := new_character_id_as (False) 
			yyval := yyval5
		end

	yy_do_action_20 is
			--|#line 158 "cluster_indexing.y"
		local
			yyval5: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 158")
end

yyval5 := new_character_id_as (True) 
			yyval := yyval5
		end

	yy_do_action_21 is
			--|#line 160 "cluster_indexing.y"
		local
			yyval5: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 160")
end

yyval5 := new_double_id_as 
			yyval := yyval5
		end

	yy_do_action_22 is
			--|#line 162 "cluster_indexing.y"
		local
			yyval5: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 162")
end

yyval5 := new_integer_id_as (8) 
			yyval := yyval5
		end

	yy_do_action_23 is
			--|#line 164 "cluster_indexing.y"
		local
			yyval5: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 164")
end

yyval5 := new_integer_id_as (16) 
			yyval := yyval5
		end

	yy_do_action_24 is
			--|#line 166 "cluster_indexing.y"
		local
			yyval5: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 166")
end

yyval5 := new_integer_id_as (32) 
			yyval := yyval5
		end

	yy_do_action_25 is
			--|#line 168 "cluster_indexing.y"
		local
			yyval5: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 168")
end

yyval5 := new_integer_id_as (64) 
			yyval := yyval5
		end

	yy_do_action_26 is
			--|#line 170 "cluster_indexing.y"
		local
			yyval5: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 170")
end

yyval5 := new_none_id_as 
			yyval := yyval5
		end

	yy_do_action_27 is
			--|#line 172 "cluster_indexing.y"
		local
			yyval5: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 172")
end

yyval5 := new_pointer_id_as 
			yyval := yyval5
		end

	yy_do_action_28 is
			--|#line 174 "cluster_indexing.y"
		local
			yyval5: ID_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 174")
end

yyval5 := new_real_id_as 
			yyval := yyval5
		end

	yy_do_action_29 is
			--|#line 178 "cluster_indexing.y"
		local
			yyval1: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 178")
end

yyval1 := yytype3 (yyvs.item (yyvsp)) 
			yyval := yyval1
		end

	yy_do_action_30 is
			--|#line 180 "cluster_indexing.y"
		local
			yyval1: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 180")
end

yyval1 := yytype4 (yyvs.item (yyvsp)) 
			yyval := yyval1
		end

	yy_do_action_31 is
			--|#line 182 "cluster_indexing.y"
		local
			yyval1: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 182")
end

yyval1 := yytype7 (yyvs.item (yyvsp)) 
			yyval := yyval1
		end

	yy_do_action_32 is
			--|#line 184 "cluster_indexing.y"
		local
			yyval1: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 184")
end

yyval1 := yytype8 (yyvs.item (yyvsp)) 
			yyval := yyval1
		end

	yy_do_action_33 is
			--|#line 186 "cluster_indexing.y"
		local
			yyval1: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 186")
end

yyval1 := yytype2 (yyvs.item (yyvsp)) 
			yyval := yyval1
		end

	yy_do_action_34 is
			--|#line 188 "cluster_indexing.y"
		local
			yyval1: ATOMIC_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 188")
end

yyval1 := yytype9 (yyvs.item (yyvsp)) 
			yyval := yyval1
		end

	yy_do_action_35 is
			--|#line 192 "cluster_indexing.y"
		local
			yyval3: BOOL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 192")
end

yyval3 := new_boolean_as (False) 
			yyval := yyval3
		end

	yy_do_action_36 is
			--|#line 194 "cluster_indexing.y"
		local
			yyval3: BOOL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 194")
end

yyval3 := new_boolean_as (True) 
			yyval := yyval3
		end

	yy_do_action_37 is
			--|#line 198 "cluster_indexing.y"
		local
			yyval4: CHAR_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 198")
end

				check is_character: not token_buffer.is_empty end
				yyval4 := new_character_as (token_buffer.item (1))
			
			yyval := yyval4
		end

	yy_do_action_38 is
			--|#line 205 "cluster_indexing.y"
		local
			yyval7: INTEGER_CONSTANT
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 205")
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

	yy_do_action_39 is
			--|#line 220 "cluster_indexing.y"
		local
			yyval7: INTEGER_CONSTANT
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 220")
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

	yy_do_action_40 is
			--|#line 235 "cluster_indexing.y"
		local
			yyval7: INTEGER_CONSTANT
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 235")
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

	yy_do_action_41 is
			--|#line 253 "cluster_indexing.y"
		local
			yyval8: REAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 253")
end

yyval8 := new_real_as (cloned_string (token_buffer)) 
			yyval := yyval8
		end

	yy_do_action_42 is
			--|#line 255 "cluster_indexing.y"
		local
			yyval8: REAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 255")
end

yyval8 := new_real_as (cloned_string (token_buffer)) 
			yyval := yyval8
		end

	yy_do_action_43 is
			--|#line 257 "cluster_indexing.y"
		local
			yyval8: REAL_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 257")
end

				token_buffer.precede ('-')
				yyval8 := new_real_as (cloned_string (token_buffer))
			
			yyval := yyval8
		end

	yy_do_action_44 is
			--|#line 264 "cluster_indexing.y"
		local
			yyval2: BIT_CONST_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 264")
end

yyval2 := new_bit_const_as (create {ID_AS}.initialize (token_buffer)) 
			yyval := yyval2
		end

	yy_do_action_45 is
			--|#line 268 "cluster_indexing.y"
		local
			yyval9: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 268")
end

yyval9 := yytype9 (yyvs.item (yyvsp)) 
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

yyval9 := new_empty_string_as 
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

yyval9 := new_empty_verbatim_string_as (cloned_string (verbatim_marker)) 
			yyval := yyval9
		end

	yy_do_action_48 is
			--|#line 276 "cluster_indexing.y"
		local
			yyval9: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 276")
end

yyval9 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval9
		end

	yy_do_action_49 is
			--|#line 278 "cluster_indexing.y"
		local
			yyval9: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 278")
end

yyval9 := new_verbatim_string_as (cloned_string (token_buffer), cloned_string (verbatim_marker)) 
			yyval := yyval9
		end

	yy_do_action_50 is
			--|#line 280 "cluster_indexing.y"
		local
			yyval9: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 280")
end

yyval9 := new_lt_string_as 
			yyval := yyval9
		end

	yy_do_action_51 is
			--|#line 282 "cluster_indexing.y"
		local
			yyval9: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 282")
end

yyval9 := new_le_string_as 
			yyval := yyval9
		end

	yy_do_action_52 is
			--|#line 284 "cluster_indexing.y"
		local
			yyval9: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 284")
end

yyval9 := new_gt_string_as 
			yyval := yyval9
		end

	yy_do_action_53 is
			--|#line 286 "cluster_indexing.y"
		local
			yyval9: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 286")
end

yyval9 := new_ge_string_as 
			yyval := yyval9
		end

	yy_do_action_54 is
			--|#line 288 "cluster_indexing.y"
		local
			yyval9: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 288")
end

yyval9 := new_minus_string_as 
			yyval := yyval9
		end

	yy_do_action_55 is
			--|#line 290 "cluster_indexing.y"
		local
			yyval9: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 290")
end

yyval9 := new_plus_string_as 
			yyval := yyval9
		end

	yy_do_action_56 is
			--|#line 292 "cluster_indexing.y"
		local
			yyval9: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 292")
end

yyval9 := new_star_string_as 
			yyval := yyval9
		end

	yy_do_action_57 is
			--|#line 294 "cluster_indexing.y"
		local
			yyval9: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 294")
end

yyval9 := new_slash_string_as 
			yyval := yyval9
		end

	yy_do_action_58 is
			--|#line 296 "cluster_indexing.y"
		local
			yyval9: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 296")
end

yyval9 := new_mod_string_as 
			yyval := yyval9
		end

	yy_do_action_59 is
			--|#line 298 "cluster_indexing.y"
		local
			yyval9: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 298")
end

yyval9 := new_div_string_as 
			yyval := yyval9
		end

	yy_do_action_60 is
			--|#line 300 "cluster_indexing.y"
		local
			yyval9: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 300")
end

yyval9 := new_power_string_as 
			yyval := yyval9
		end

	yy_do_action_61 is
			--|#line 302 "cluster_indexing.y"
		local
			yyval9: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 302")
end

yyval9 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval9
		end

	yy_do_action_62 is
			--|#line 304 "cluster_indexing.y"
		local
			yyval9: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 304")
end

yyval9 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval9
		end

	yy_do_action_63 is
			--|#line 306 "cluster_indexing.y"
		local
			yyval9: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 306")
end

yyval9 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval9
		end

	yy_do_action_64 is
			--|#line 308 "cluster_indexing.y"
		local
			yyval9: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 308")
end

yyval9 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval9
		end

	yy_do_action_65 is
			--|#line 310 "cluster_indexing.y"
		local
			yyval9: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 310")
end

yyval9 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval9
		end

	yy_do_action_66 is
			--|#line 312 "cluster_indexing.y"
		local
			yyval9: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 312")
end

yyval9 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval9
		end

	yy_do_action_67 is
			--|#line 314 "cluster_indexing.y"
		local
			yyval9: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 314")
end

yyval9 := new_string_as (cloned_string (token_buffer)) 
			yyval := yyval9
		end

	yy_do_action_68 is
			--|#line 316 "cluster_indexing.y"
		local
			yyval9: STRING_AS
		do
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'cluster_indexing.y' at line 316")
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
			  125,  126,  127,  128,  129,  130,  131,  132,  133,  134,
			  135,  136,  137>>)
		end

	yyr1_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    0,  153,  151,  151,  151,  152,  152,  145,  144,  144,
			  150,  150,  150,  138,  138,  154,  154,  143,  143,  143,
			  143,  143,  143,  143,  143,  143,  143,  143,  143,  139,
			  139,  139,  139,  139,  139,  141,  141,  142,  146,  146,
			  146,  147,  147,  147,  140,  148,  148,  148,  149,  149,
			  149,  149,  149,  149,  149,  149,  149,  149,  149,  149,
			  149,  149,  149,  149,  149,  149,  149,  149,  149>>)
		end

	yyr2_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    0,    1,    0,    2,    1,    1,    2,    3,    2,    0,
			    1,    3,    1,    1,    1,    0,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    2,
			    2,    1,    2,    2,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1>>)
		end

	yydefact_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    2,    9,    1,   28,   27,   26,   20,   25,   23,   22,
			   24,   21,   19,   18,   17,    0,    0,    5,    9,    8,
			   68,   67,   66,   65,   64,   63,   62,   61,   60,   59,
			   58,   57,   56,   55,   54,   53,   52,   51,   50,   47,
			   49,   46,   36,   35,   12,   44,   48,   41,   37,   38,
			    0,    0,   10,   14,   33,   29,   30,   13,   31,   32,
			   34,   45,   15,    6,   43,   40,   42,   39,    0,   16,
			    7,   11,    0,    0,    0>>)
		end

	yydefgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			   52,   53,   54,   55,   56,   15,   16,   17,   58,   59,
			   60,   61,   62,    2,   18,   72,   70>>)
		end

	yypact_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			  -63,  157, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768,  -28,  -14, -32768,   54, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			  -22,  -25, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768,  -35, -32768, -32768, -32768, -32768, -32768,   19, -32768,
			 -32768, -32768,   10,    8, -32768>>)
		end

	yypgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			  -54, -32768, -32768, -32768, -32768,  -13, -32768,   -5, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768>>)
		end

	yytable_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			   51,   50,   69,   57,   67,   68,   66,   65,   74,   64,
			   73,   19,    1,   63,   71,   49,   48,   47,   46,   14,
			   45,    0,    0,   44,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,   51,   50,    0,    0,   43,   42,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,   49,   48,
			   47,   46,   14,   45,   -3,   57,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			   43,   42,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,   14,    0,    0,
			    0,   13,   12,   11,   10,    9,    8,    7,    6,    5,

			    4,    3,   41,   40,   39,   38,   37,   36,   35,   34,
			   33,   32,   31,   30,   29,   28,   27,   26,   25,   24,
			   23,   22,   21,   20,   13,   12,   11,   10,    9,    8,
			    7,    6,    5,    4,    3,   41,   40,   39,   38,   37,
			   36,   35,   34,   33,   32,   31,   30,   29,   28,   27,
			   26,   25,   24,   23,   22,   21,   20,   -4,    0,   13,
			   12,   11,   10,    9,    8,    7,    6,    5,    4,    3,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			   14,    0,    0,    0,    0,    0,    0,    0,    0,    0,

			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,   13,   12,   11,   10,    9,    8,    7,    6,
			    5,    4,    3>>)
		end

	yycheck_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			   14,   15,   37,   16,   29,   40,   31,   29,    0,   31,
			    0,   39,   75,   18,   68,   29,   30,   31,   32,   33,
			   34,   -1,   -1,   37,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   14,   15,   -1,   -1,   51,   52,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   29,   30,
			   31,   32,   33,   34,    0,   68,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   51,   52,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   33,   -1,   -1,
			   -1,  105,  106,  107,  108,  109,  110,  111,  112,  113,

			  114,  115,  116,  117,  118,  119,  120,  121,  122,  123,
			  124,  125,  126,  127,  128,  129,  130,  131,  132,  133,
			  134,  135,  136,  137,  105,  106,  107,  108,  109,  110,
			  111,  112,  113,  114,  115,  116,  117,  118,  119,  120,
			  121,  122,  123,  124,  125,  126,  127,  128,  129,  130,
			  131,  132,  133,  134,  135,  136,  137,    0,   -1,  105,
			  106,  107,  108,  109,  110,  111,  112,  113,  114,  115,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   33,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,

			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,  105,  106,  107,  108,  109,  110,  111,  112,
			  113,  114,  115>>)
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

	yyFinal: INTEGER is 74
			-- Termination state id

	yyFlag: INTEGER is -32768
			-- Most negative INTEGER

	yyNtbase: INTEGER is 138
			-- Number of tokens

	yyLast: INTEGER is 272
			-- Upper bound of `yytable' and `yycheck'

	yyMax_token: INTEGER is 392
			-- Maximum token id
			-- (upper bound of `yytranslate'.)

	yyNsyms: INTEGER is 155
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
