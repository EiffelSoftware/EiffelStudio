indexing
	description: "External parsers"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class EXTERNAL_PARSER

inherit

	EXTERNAL_PARSER_SKELETON

creation

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
--|#line 50
	yy_do_action_1
when 2 then
--|#line 55
	yy_do_action_2
when 3 then
--|#line 59
	yy_do_action_3
when 4 then
--|#line 63
	yy_do_action_4
when 5 then
--|#line 67
	yy_do_action_5
when 6 then
--|#line 73
	yy_do_action_6
when 7 then
--|#line 78
	yy_do_action_7
when 8 then
--|#line 83
	yy_do_action_8
when 9 then
--|#line 88
	yy_do_action_9
when 10 then
--|#line 94
	yy_do_action_10
when 11 then
--|#line 99
	yy_do_action_11
when 12 then
--|#line 104
	yy_do_action_12
when 13 then
--|#line 109
	yy_do_action_13
when 14 then
--|#line 115
	yy_do_action_14
when 15 then
--|#line 120
	yy_do_action_15
when 16 then
--|#line 124
	yy_do_action_16
when 17 then
--|#line 128
	yy_do_action_17
when 19 then
--|#line 137
	yy_do_action_19
when 20 then
--|#line 142
	yy_do_action_20
when 21 then
--|#line 146
	yy_do_action_21
when 22 then
--|#line 150
	yy_do_action_22
when 23 then
--|#line 154
	yy_do_action_23
when 24 then
--|#line 158
	yy_do_action_24
when 25 then
--|#line 162
	yy_do_action_25
when 26 then
--|#line 166
	yy_do_action_26
when 27 then
--|#line 170
	yy_do_action_27
when 28 then
--|#line 174
	yy_do_action_28
when 29 then
--|#line 178
	yy_do_action_29
when 30 then
--|#line 182
	yy_do_action_30
when 31 then
--|#line 188
	yy_do_action_31
when 32 then
--|#line 193
	yy_do_action_32
when 34 then
--|#line 200
	yy_do_action_34
when 35 then
--|#line 204
	yy_do_action_35
when 37 then
--|#line 211
	yy_do_action_37
when 38 then
--|#line 215
	yy_do_action_38
when 40 then
--|#line 222
	yy_do_action_40
when 41 then
--|#line 226
	yy_do_action_41
when 42 then
--|#line 231
	yy_do_action_42
when 44 then
--|#line 240
	yy_do_action_44
when 45 then
--|#line 244
	yy_do_action_45
when 46 then
--|#line 251
	yy_do_action_46
when 47 then
--|#line 257
	yy_do_action_47
when 48 then
--|#line 262
	yy_do_action_48
when 50 then
--|#line 270
	yy_do_action_50
when 51 then
--|#line 276
	yy_do_action_51
when 52 then
--|#line 278
	yy_do_action_52
when 53 then
--|#line 282
	yy_do_action_53
when 54 then
--|#line 284
	yy_do_action_54
when 56 then
--|#line 290
	yy_do_action_56
when 57 then
--|#line 294
	yy_do_action_57
when 58 then
--|#line 299
	yy_do_action_58
when 59 then
--|#line 304
	yy_do_action_59
when 60 then
--|#line 311
	yy_do_action_60
when 61 then
--|#line 316
	yy_do_action_61
when 62 then
--|#line 320
	yy_do_action_62
when 63 then
--|#line 326
	yy_do_action_63
			else
					-- No action
				yyval := yyval_default
			end
		end

	yy_do_action_1 is
			--|#line 50
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				root_node := yytype1 (yyvs.item (yyvsp))
			
			yyval := yyval1
		end

	yy_do_action_2 is
			--|#line 55
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				root_node := yytype1 (yyvs.item (yyvsp))
			
			yyval := yyval1
		end

	yy_do_action_3 is
			--|#line 59
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				root_node := yytype1 (yyvs.item (yyvsp))
			
			yyval := yyval1
		end

	yy_do_action_4 is
			--|#line 63
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				root_node := yytype1 (yyvs.item (yyvsp))
			
			yyval := yyval1
		end

	yy_do_action_5 is
			--|#line 67
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				root_node := yytype1 (yyvs.item (yyvsp))
			
			yyval := yyval1
		end

	yy_do_action_6 is
			--|#line 73
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := new_c_extension_as (yytype2 (yyvs.item (yyvsp - 1)), yytype7 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_7 is
			--|#line 78
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

					-- False because this is a C construct
				yyval1 := new_struct_extension_as (yytype4 (yyvs.item (yyvsp - 4)), yytype4 (yyvs.item (yyvsp - 2)), yytype3 (yyvs.item (yyvsp - 1)), yytype7 (yyvs.item (yyvsp)), False)
			
			yyval := yyval1
		end

	yy_do_action_8 is
			--|#line 83
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

					-- False because this is a C construct
				yyval1 := new_macro_extension_as (yytype2 (yyvs.item (yyvsp - 1)), yytype7 (yyvs.item (yyvsp)), False)
			
			yyval := yyval1
		end

	yy_do_action_9 is
			--|#line 88
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := new_inline_as
			
			yyval := yyval1
		end

	yy_do_action_10 is
			--|#line 94
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := yytype1 (yyvs.item (yyvsp))
			
			yyval := yyval1
		end

	yy_do_action_11 is
			--|#line 99
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

					-- True because this is a C++ construct
				yyval1 := new_struct_extension_as (yytype4 (yyvs.item (yyvsp - 4)), yytype4 (yyvs.item (yyvsp - 2)), yytype3 (yyvs.item (yyvsp - 1)), yytype7 (yyvs.item (yyvsp)), True)
			
			yyval := yyval1
		end

	yy_do_action_12 is
			--|#line 104
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

					-- True because this is a C++ construct
				yyval1 := new_macro_extension_as (yytype2 (yyvs.item (yyvsp - 1)), yytype7 (yyvs.item (yyvsp)), True)
			
			yyval := yyval1
		end

	yy_do_action_13 is
			--|#line 109
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := new_inline_as
			
			yyval := yyval1
		end

	yy_do_action_14 is
			--|#line 115
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := new_cpp_extension_as (standard, yytype4 (yyvs.item (yyvsp - 2)), yytype2 (yyvs.item (yyvsp - 1)), yytype7 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_15 is
			--|#line 120
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := new_cpp_extension_as (creator, yytype4 (yyvs.item (yyvsp - 2)), yytype2 (yyvs.item (yyvsp - 1)), yytype7 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_16 is
			--|#line 124
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := new_cpp_extension_as (delete, yytype4 (yyvs.item (yyvsp - 2)), yytype2 (yyvs.item (yyvsp - 1)), yytype7 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_17 is
			--|#line 128
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := new_cpp_extension_as (static, yytype4 (yyvs.item (yyvsp - 2)), yytype2 (yyvs.item (yyvsp - 1)), yytype7 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_19 is
			--|#line 137
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := new_il_extension_as (yytype6 (yyvs.item (yyvsp - 3)), normal_type, yytype2 (yyvs.item (yyvsp - 2)), yytype4 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_20 is
			--|#line 142
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := new_il_extension_as (yytype6 (yyvs.item (yyvsp - 4)), deferred_type, yytype2 (yyvs.item (yyvsp - 2)), yytype4 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_21 is
			--|#line 146
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := new_il_extension_as (yytype6 (yyvs.item (yyvsp - 4)), creator_type, yytype2 (yyvs.item (yyvsp - 2)), yytype4 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_22 is
			--|#line 150
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := new_il_extension_as (yytype6 (yyvs.item (yyvsp - 4)), field_type, yytype2 (yyvs.item (yyvsp - 2)), yytype4 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_23 is
			--|#line 154
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := new_il_extension_as (yytype6 (yyvs.item (yyvsp - 4)), static_field_type, yytype2 (yyvs.item (yyvsp - 2)), yytype4 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_24 is
			--|#line 158
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := new_il_extension_as (yytype6 (yyvs.item (yyvsp - 4)), enum_field_type, yytype2 (yyvs.item (yyvsp - 2)), yytype4 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_25 is
			--|#line 162
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := new_il_extension_as (yytype6 (yyvs.item (yyvsp - 4)), set_static_field_type, yytype2 (yyvs.item (yyvsp - 2)), yytype4 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_26 is
			--|#line 166
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := new_il_extension_as (yytype6 (yyvs.item (yyvsp - 4)), set_field_type, yytype2 (yyvs.item (yyvsp - 2)), yytype4 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_27 is
			--|#line 170
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := new_il_extension_as (yytype6 (yyvs.item (yyvsp - 4)), static_type, yytype2 (yyvs.item (yyvsp - 2)), yytype4 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_28 is
			--|#line 174
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := new_il_extension_as (yytype6 (yyvs.item (yyvsp - 4)), get_property_type, yytype2 (yyvs.item (yyvsp - 2)), yytype4 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_29 is
			--|#line 178
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := new_il_extension_as (yytype6 (yyvs.item (yyvsp - 4)), set_property_type, yytype2 (yyvs.item (yyvsp - 2)), yytype4 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_30 is
			--|#line 182
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := new_il_extension_as (yytype6 (yyvs.item (yyvsp - 4)), operator_type, yytype2 (yyvs.item (yyvsp - 2)), yytype4 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_31 is
			--|#line 188
		local
			yyval6: INTEGER
		do

				yyval6 := msil_language
			
			yyval := yyval6
		end

	yy_do_action_32 is
			--|#line 193
		local
			yyval6: INTEGER
		do

				yyval6 := java_language
			
			yyval := yyval6
		end

	yy_do_action_34 is
			--|#line 200
		local
			yyval2: SIGNATURE_AS
		do

yyval2 := yytype2 (yyvs.item (yyvsp))
			yyval := yyval2
		end

	yy_do_action_35 is
			--|#line 204
		local
			yyval2: SIGNATURE_AS
		do

yyval2 := new_signature_as (yytype8 (yyvs.item (yyvsp - 1)), yytype3 (yyvs.item (yyvsp)))
			yyval := yyval2
		end

	yy_do_action_37 is
			--|#line 211
		local
			yyval8: EIFFEL_LIST [EXTERNAL_TYPE_AS]
		do

yyval8 := yytype8 (yyvs.item (yyvsp))
			yyval := yyval8
		end

	yy_do_action_38 is
			--|#line 215
		local
			yyval8: EIFFEL_LIST [EXTERNAL_TYPE_AS]
		do

yyval8 := yytype8 (yyvs.item (yyvsp - 1))
			yyval := yyval8
		end

	yy_do_action_40 is
			--|#line 222
		local
			yyval8: EIFFEL_LIST [EXTERNAL_TYPE_AS]
		do

yyval8 := yytype8 (yyvs.item (yyvsp))
			yyval := yyval8
		end

	yy_do_action_41 is
			--|#line 226
		local
			yyval8: EIFFEL_LIST [EXTERNAL_TYPE_AS]
		do

			yyval8 := new_eiffel_list_external_type_as (Argument_list_initial_size)
			yyval8.extend (yytype3 (yyvs.item (yyvsp)))
		
			yyval := yyval8
		end

	yy_do_action_42 is
			--|#line 231
		local
			yyval8: EIFFEL_LIST [EXTERNAL_TYPE_AS]
		do

			yyval8 := yytype8 (yyvs.item (yyvsp - 2))
			yyval8.extend (yytype3 (yyvs.item (yyvsp)))
		
			yyval := yyval8
		end

	yy_do_action_44 is
			--|#line 240
		local
			yyval3: EXTERNAL_TYPE_AS
		do

yyval3 := yytype3 (yyvs.item (yyvsp))
			yyval := yyval3
		end

	yy_do_action_45 is
			--|#line 244
		local
			yyval3: EXTERNAL_TYPE_AS
		do

					-- False because no `struct' keyword.
					-- Void because no `signed', `unsigned' keyword.
				yyval3 := new_external_type_as (yytype4 (yyvs.item (yyvsp - 2)), Void, False, yytype6 (yyvs.item (yyvsp - 1)), yytype5 (yyvs.item (yyvsp)))
			
			yyval := yyval3
		end

	yy_do_action_46 is
			--|#line 251
		local
			yyval3: EXTERNAL_TYPE_AS
		do

					-- True because `struct' keyword.
					-- Void because no `signed', `unsigned' keyword.
				yyval3 := new_external_type_as (yytype4 (yyvs.item (yyvsp - 2)), Void, True, yytype6 (yyvs.item (yyvsp - 1)), yytype5 (yyvs.item (yyvsp)))
			
			yyval := yyval3
		end

	yy_do_action_47 is
			--|#line 257
		local
			yyval3: EXTERNAL_TYPE_AS
		do

					-- False because no `struct' keyword.
				yyval3 := new_external_type_as (yytype4 (yyvs.item (yyvsp - 2)), signed_prefix, False, yytype6 (yyvs.item (yyvsp - 1)), yytype5 (yyvs.item (yyvsp)))
			
			yyval := yyval3
		end

	yy_do_action_48 is
			--|#line 262
		local
			yyval3: EXTERNAL_TYPE_AS
		do

					-- False because no `struct' keyword.
				yyval3 := new_external_type_as (yytype4 (yyvs.item (yyvsp - 2)), unsigned_prefix, False, yytype6 (yyvs.item (yyvsp - 1)), yytype5 (yyvs.item (yyvsp)))
			
			yyval := yyval3
		end

	yy_do_action_50 is
			--|#line 270
		local
			yyval3: EXTERNAL_TYPE_AS
		do

			yyval3 := yytype3 (yyvs.item (yyvsp))
		
			yyval := yyval3
		end

	yy_do_action_51 is
			--|#line 276
		local
			yyval6: INTEGER
		do

yyval6 := 0
			yyval := yyval6
		end

	yy_do_action_52 is
			--|#line 278
		local
			yyval6: INTEGER
		do

yyval6 := yytype6 (yyvs.item (yyvsp - 1)) + 1
			yyval := yyval6
		end

	yy_do_action_53 is
			--|#line 282
		local
			yyval5: BOOLEAN
		do

yyval5 := False
			yyval := yyval5
		end

	yy_do_action_54 is
			--|#line 284
		local
			yyval5: BOOLEAN
		do

yyval5 := True
			yyval := yyval5
		end

	yy_do_action_56 is
			--|#line 290
		local
			yyval7: USE_LIST_AS
		do

yyval7 := yytype7 (yyvs.item (yyvsp))
			yyval := yyval7
		end

	yy_do_action_57 is
			--|#line 294
		local
			yyval7: USE_LIST_AS
		do

yyval7 := yytype7 (yyvs.item (yyvsp))
			yyval := yyval7
		end

	yy_do_action_58 is
			--|#line 299
		local
			yyval7: USE_LIST_AS
		do

			yyval7 := new_use_list_as (Argument_list_initial_size)
			yyval7.extend (yytype4 (yyvs.item (yyvsp)))
		
			yyval := yyval7
		end

	yy_do_action_59 is
			--|#line 304
		local
			yyval7: USE_LIST_AS
		do

			yyval7 := yytype7 (yyvs.item (yyvsp - 2))
			yyval7.extend (yytype4 (yyvs.item (yyvsp)))
		
			yyval := yyval7
		end

	yy_do_action_60 is
			--|#line 311
		local
			yyval4: ID_AS
		do

			yyval4 := new_double_quote_id_as (token_buffer)
		
			yyval := yyval4
		end

	yy_do_action_61 is
			--|#line 316
		local
			yyval4: ID_AS
		do

			yyval4 := new_system_id_as (token_buffer)
		
			yyval := yyval4
		end

	yy_do_action_62 is
			--|#line 320
		local
			yyval4: ID_AS
		do

			yyval4 := new_double_quote_id_as (token_buffer)
		
			yyval := yyval4
		end

	yy_do_action_63 is
			--|#line 326
		local
			yyval4: ID_AS
		do

yyval4 := new_id_as (token_buffer) 
			yyval := yyval4
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
			   35,   36,   37,   38,   39>>)
		end

	yyr1_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    0,   40,   40,   40,   40,   40,   41,   41,   41,   41,
			   42,   42,   42,   42,   45,   45,   45,   45,   43,   44,
			   44,   44,   44,   44,   44,   44,   44,   44,   44,   44,
			   44,   58,   58,   46,   46,   47,   59,   59,   60,   61,
			   61,   62,   62,   48,   48,   49,   49,   49,   49,   50,
			   50,   54,   54,   53,   53,   55,   55,   56,   57,   57,
			   52,   52,   52,   51>>)
		end

	yyr2_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    0,    2,    2,    2,    2,    1,    2,    6,    3,    2,
			    1,    6,    3,    2,    3,    4,    4,    4,    2,    4,
			    5,    5,    5,    5,    5,    5,    5,    5,    5,    5,
			    5,    1,    1,    0,    1,    3,    0,    1,    3,    0,
			    1,    1,    3,    0,    2,    3,    4,    4,    4,    0,
			    2,    0,    2,    0,    1,    0,    1,    2,    1,    3,
			    3,    3,    1,    1>>)
		end

	yydefact_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    0,   32,   31,   33,   33,    0,   33,    5,   33,   36,
			    4,    0,   34,    3,   63,    0,    0,    0,   33,    0,
			   55,    2,   10,   33,    0,   33,   55,    1,   55,   33,
			   33,   33,   33,   33,   33,   33,   33,   33,   33,   33,
			    0,   39,   43,   37,    0,   18,    0,   33,   33,    0,
			   33,   13,   56,    0,    0,    0,    9,    6,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,   41,   51,    0,   40,    0,   35,   62,
			    0,    0,   58,   57,    0,    0,    0,   12,    0,   14,
			    0,    8,    0,    0,    0,    0,    0,    0,    0,    0,

			    0,    0,    0,   19,   51,   51,   51,   53,   38,    0,
			   44,    0,    0,    0,   49,   15,   17,   16,   49,   25,
			   23,   21,   27,   29,   26,   30,   20,   22,   28,   24,
			   53,   53,   53,   52,   54,   45,   42,   60,   61,   59,
			    0,    0,    0,   48,   47,   46,   50,   11,    7,    0,
			    0,    0>>)
		end

	yydefgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			  149,   27,   21,   10,    7,   22,   11,   12,   78,   73,
			  141,   74,   82,  135,  107,   51,   52,   83,    8,   42,
			   43,   75,   76>>)
		end

	yypact_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			   38, -32768, -32768,   79,   79,   42,   84, -32768,   96,  108,
			 -32768,  -20, -32768, -32768, -32768,   11,   11,   11,   79,   11,
			  -20, -32768, -32768,   79,   11,   79,  -20, -32768,  -20,   79,
			   79,   79,   79,   79,   79,   79,   79,   79,   79,   79,
			   73,   48,  107, -32768,    8, -32768,   97,   79,   79,  -20,
			   79, -32768, -32768,  -20,   59,  -20, -32768, -32768,   69,   67,
			   66,   65,   64,   63,   62,   45,   41,   40,   31,   11,
			   11,   11,   11, -32768, -32768,   58,   55,   48, -32768, -32768,
			   21,   15, -32768,   47,   11,  -20,  -20, -32768,  -20, -32768,
			   11, -32768,   11,   11,   11,   11,   11,   11,   11,   11,

			   11,   11,   11, -32768, -32768, -32768, -32768,   33, -32768,   48,
			 -32768,   32,   39,    8,  -13, -32768, -32768, -32768,  -13, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			   33,   33,   33, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			   48,  -20,  -20, -32768, -32768, -32768, -32768, -32768, -32768,   14,
			    2, -32768>>)
		end

	yypgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			 -32768, -32768, -32768,  116, -32768, -32768,   -2, -32768, -32768,  -70,
			   -1,   -4,    1, -106,  -96,  -23,  -11, -32768, -32768, -32768,
			 -32768, -32768, -32768>>)
		end

	yytable_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			   45,   23,  151,   56,   28,   57,   40,  110,  130,  131,
			  132,   46,   47,   48,  150,   50,   49,   81,   44,   80,
			   54,   53,  140,   55,  143,  144,  145,   58,   59,   60,
			   61,   62,   63,   64,   65,   66,   67,   68,   87,  136,
			  134,  133,   89,  137,   91,   85,   86,   79,   88,  138,
			   14,    6,    5,  113,  112,    4,    3,   20,   19,    2,
			  111,  109,    1,  108,   18,  103,  104,  105,  106,  102,
			  146,   90,   17,   16,  115,  116,   15,  117,  101,  100,
			  114,   14,   72,   99,   71,   70,  118,   14,  119,  120,
			  121,  122,  123,  124,  125,  126,  127,  128,  129,   26,

			   98,   97,   96,   95,   94,   93,   25,   92,    9,   84,
			   77,   69,   41,    9,  139,   39,   38,  142,   24,   37,
			   13,   36,   35,   34,   33,    9,   32,   31,   30,   29,
			  147,  148>>)
		end

	yycheck_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			   11,    5,    0,   26,    6,   28,    8,   77,  104,  105,
			  106,   15,   16,   17,    0,   19,   18,    9,   38,   11,
			   24,   23,   35,   25,  130,  131,  132,   29,   30,   31,
			   32,   33,   34,   35,   36,   37,   38,   39,   49,  109,
			    7,    8,   53,   11,   55,   47,   48,   39,   50,   10,
			   39,   13,   14,    6,   39,   17,   18,   15,   16,   21,
			   39,    6,   24,    5,   22,   69,   70,   71,   72,   38,
			  140,   12,   30,   31,   85,   86,   34,   88,   38,   38,
			   84,   39,   34,   38,   36,   37,   90,   39,   92,   93,
			   94,   95,   96,   97,   98,   99,  100,  101,  102,   15,

			   38,   38,   38,   38,   38,   38,   22,   38,   29,   12,
			    3,   38,    4,   29,  113,   19,   20,  118,   34,   23,
			    4,   25,   26,   27,   28,   29,   30,   31,   32,   33,
			  141,  142>>)
		end

feature {NONE} -- Conversion

	yytype1 (v: ANY): EXTERNAL_EXTENSION_AS is
		require
			valid_type: yyis_type1 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type1 (v: ANY): BOOLEAN is
		local
			u: EXTERNAL_EXTENSION_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype2 (v: ANY): SIGNATURE_AS is
		require
			valid_type: yyis_type2 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type2 (v: ANY): BOOLEAN is
		local
			u: SIGNATURE_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype3 (v: ANY): EXTERNAL_TYPE_AS is
		require
			valid_type: yyis_type3 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type3 (v: ANY): BOOLEAN is
		local
			u: EXTERNAL_TYPE_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype4 (v: ANY): ID_AS is
		require
			valid_type: yyis_type4 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type4 (v: ANY): BOOLEAN is
		local
			u: ID_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype5 (v: ANY): BOOLEAN is
		require
			valid_type: yyis_type5 (v)
		local
			ref: BOOLEAN_REF
		do
			ref ?= v
			Result := ref.item
		end

	yyis_type5 (v: ANY): BOOLEAN is
		local
			u: BOOLEAN_REF
		do
			u ?= v
			Result := (u = v)
		end

	yytype6 (v: ANY): INTEGER is
		require
			valid_type: yyis_type6 (v)
		local
			ref: INTEGER_REF
		do
			ref ?= v
			Result := ref.item
		end

	yyis_type6 (v: ANY): BOOLEAN is
		local
			u: INTEGER_REF
		do
			u ?= v
			Result := (u = v)
		end

	yytype7 (v: ANY): USE_LIST_AS is
		require
			valid_type: yyis_type7 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type7 (v: ANY): BOOLEAN is
		local
			u: USE_LIST_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype8 (v: ANY): EIFFEL_LIST [EXTERNAL_TYPE_AS] is
		require
			valid_type: yyis_type8 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type8 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [EXTERNAL_TYPE_AS]
		do
			u ?= v
			Result := (u = v)
		end


feature {NONE} -- Constants

	yyFinal: INTEGER is 151
			-- Termination state id

	yyFlag: INTEGER is -32768
			-- Most negative INTEGER

	yyNtbase: INTEGER is 40
			-- Number of tokens

	yyLast: INTEGER is 131
			-- Upper bound of `yytable' and `yycheck'

	yyMax_token: INTEGER is 294
			-- Maximum token id
			-- (upper bound of `yytranslate'.)

	yyNsyms: INTEGER is 63
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
