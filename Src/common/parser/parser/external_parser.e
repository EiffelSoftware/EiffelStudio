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
--|#line 48
	yy_do_action_1
when 2 then
--|#line 53
	yy_do_action_2
when 3 then
--|#line 57
	yy_do_action_3
when 4 then
--|#line 61
	yy_do_action_4
when 5 then
--|#line 65
	yy_do_action_5
when 6 then
--|#line 71
	yy_do_action_6
when 7 then
--|#line 76
	yy_do_action_7
when 8 then
--|#line 81
	yy_do_action_8
when 9 then
--|#line 86
	yy_do_action_9
when 10 then
--|#line 92
	yy_do_action_10
when 11 then
--|#line 97
	yy_do_action_11
when 12 then
--|#line 102
	yy_do_action_12
when 13 then
--|#line 107
	yy_do_action_13
when 14 then
--|#line 113
	yy_do_action_14
when 15 then
--|#line 118
	yy_do_action_15
when 16 then
--|#line 122
	yy_do_action_16
when 17 then
--|#line 126
	yy_do_action_17
when 19 then
--|#line 135
	yy_do_action_19
when 20 then
--|#line 140
	yy_do_action_20
when 21 then
--|#line 144
	yy_do_action_21
when 22 then
--|#line 148
	yy_do_action_22
when 23 then
--|#line 152
	yy_do_action_23
when 24 then
--|#line 156
	yy_do_action_24
when 25 then
--|#line 160
	yy_do_action_25
when 26 then
--|#line 164
	yy_do_action_26
when 27 then
--|#line 168
	yy_do_action_27
when 28 then
--|#line 172
	yy_do_action_28
when 29 then
--|#line 176
	yy_do_action_29
when 30 then
--|#line 180
	yy_do_action_30
when 31 then
--|#line 186
	yy_do_action_31
when 32 then
--|#line 191
	yy_do_action_32
when 34 then
--|#line 198
	yy_do_action_34
when 35 then
--|#line 202
	yy_do_action_35
when 37 then
--|#line 209
	yy_do_action_37
when 38 then
--|#line 213
	yy_do_action_38
when 40 then
--|#line 220
	yy_do_action_40
when 41 then
--|#line 224
	yy_do_action_41
when 42 then
--|#line 229
	yy_do_action_42
when 44 then
--|#line 238
	yy_do_action_44
when 45 then
--|#line 242
	yy_do_action_45
when 46 then
--|#line 248
	yy_do_action_46
when 48 then
--|#line 256
	yy_do_action_48
when 49 then
--|#line 262
	yy_do_action_49
when 50 then
--|#line 264
	yy_do_action_50
when 51 then
--|#line 268
	yy_do_action_51
when 52 then
--|#line 270
	yy_do_action_52
when 54 then
--|#line 276
	yy_do_action_54
when 55 then
--|#line 280
	yy_do_action_55
when 56 then
--|#line 285
	yy_do_action_56
when 57 then
--|#line 290
	yy_do_action_57
when 58 then
--|#line 297
	yy_do_action_58
when 59 then
--|#line 302
	yy_do_action_59
when 60 then
--|#line 306
	yy_do_action_60
when 61 then
--|#line 312
	yy_do_action_61
			else
					-- No action
				yyval := yyval_default
			end
		end

	yy_do_action_1 is
			--|#line 48
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				root_node := yytype1 (yyvs.item (yyvsp))
			
			yyval := yyval1
		end

	yy_do_action_2 is
			--|#line 53
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				root_node := yytype1 (yyvs.item (yyvsp))
			
			yyval := yyval1
		end

	yy_do_action_3 is
			--|#line 57
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				root_node := yytype1 (yyvs.item (yyvsp))
			
			yyval := yyval1
		end

	yy_do_action_4 is
			--|#line 61
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				root_node := yytype1 (yyvs.item (yyvsp))
			
			yyval := yyval1
		end

	yy_do_action_5 is
			--|#line 65
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				root_node := yytype1 (yyvs.item (yyvsp))
			
			yyval := yyval1
		end

	yy_do_action_6 is
			--|#line 71
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := new_c_extension_as (yytype2 (yyvs.item (yyvsp - 1)), yytype6 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_7 is
			--|#line 76
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

					-- False because this is a C construct
				yyval1 := new_struct_extension_as (yytype4 (yyvs.item (yyvsp - 4)), yytype4 (yyvs.item (yyvsp - 2)), yytype3 (yyvs.item (yyvsp - 1)), yytype6 (yyvs.item (yyvsp)), False)
			
			yyval := yyval1
		end

	yy_do_action_8 is
			--|#line 81
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

					-- False because this is a C construct
				yyval1 := new_macro_extension_as (yytype2 (yyvs.item (yyvsp - 1)), yytype6 (yyvs.item (yyvsp)), False)
			
			yyval := yyval1
		end

	yy_do_action_9 is
			--|#line 86
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := new_inline_as
			
			yyval := yyval1
		end

	yy_do_action_10 is
			--|#line 92
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := yytype1 (yyvs.item (yyvsp))
			
			yyval := yyval1
		end

	yy_do_action_11 is
			--|#line 97
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

					-- True because this is a C++ construct
				yyval1 := new_struct_extension_as (yytype4 (yyvs.item (yyvsp - 4)), yytype4 (yyvs.item (yyvsp - 2)), yytype3 (yyvs.item (yyvsp - 1)), yytype6 (yyvs.item (yyvsp)), True)
			
			yyval := yyval1
		end

	yy_do_action_12 is
			--|#line 102
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

					-- True because this is a C++ construct
				yyval1 := new_macro_extension_as (yytype2 (yyvs.item (yyvsp - 1)), yytype6 (yyvs.item (yyvsp)), True)
			
			yyval := yyval1
		end

	yy_do_action_13 is
			--|#line 107
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := new_inline_as
			
			yyval := yyval1
		end

	yy_do_action_14 is
			--|#line 113
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := new_cpp_extension_as (standard, yytype4 (yyvs.item (yyvsp - 2)), yytype2 (yyvs.item (yyvsp - 1)), yytype6 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_15 is
			--|#line 118
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := new_cpp_extension_as (creator, yytype4 (yyvs.item (yyvsp - 2)), yytype2 (yyvs.item (yyvsp - 1)), yytype6 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_16 is
			--|#line 122
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := new_cpp_extension_as (delete, yytype4 (yyvs.item (yyvsp - 2)), yytype2 (yyvs.item (yyvsp - 1)), yytype6 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_17 is
			--|#line 126
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := new_cpp_extension_as (static, yytype4 (yyvs.item (yyvsp - 2)), yytype2 (yyvs.item (yyvsp - 1)), yytype6 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_19 is
			--|#line 135
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := new_il_extension_as (yytype7 (yyvs.item (yyvsp - 3)), normal_type, yytype2 (yyvs.item (yyvsp - 2)), yytype4 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_20 is
			--|#line 140
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := new_il_extension_as (yytype7 (yyvs.item (yyvsp - 4)), deferred_type, yytype2 (yyvs.item (yyvsp - 2)), yytype4 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_21 is
			--|#line 144
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := new_il_extension_as (yytype7 (yyvs.item (yyvsp - 4)), creator_type, yytype2 (yyvs.item (yyvsp - 2)), yytype4 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_22 is
			--|#line 148
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := new_il_extension_as (yytype7 (yyvs.item (yyvsp - 4)), field_type, yytype2 (yyvs.item (yyvsp - 2)), yytype4 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_23 is
			--|#line 152
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := new_il_extension_as (yytype7 (yyvs.item (yyvsp - 4)), static_field_type, yytype2 (yyvs.item (yyvsp - 2)), yytype4 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_24 is
			--|#line 156
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := new_il_extension_as (yytype7 (yyvs.item (yyvsp - 4)), enum_field_type, yytype2 (yyvs.item (yyvsp - 2)), yytype4 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_25 is
			--|#line 160
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := new_il_extension_as (yytype7 (yyvs.item (yyvsp - 4)), set_static_field_type, yytype2 (yyvs.item (yyvsp - 2)), yytype4 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_26 is
			--|#line 164
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := new_il_extension_as (yytype7 (yyvs.item (yyvsp - 4)), set_field_type, yytype2 (yyvs.item (yyvsp - 2)), yytype4 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_27 is
			--|#line 168
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := new_il_extension_as (yytype7 (yyvs.item (yyvsp - 4)), static_type, yytype2 (yyvs.item (yyvsp - 2)), yytype4 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_28 is
			--|#line 172
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := new_il_extension_as (yytype7 (yyvs.item (yyvsp - 4)), get_property_type, yytype2 (yyvs.item (yyvsp - 2)), yytype4 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_29 is
			--|#line 176
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := new_il_extension_as (yytype7 (yyvs.item (yyvsp - 4)), set_property_type, yytype2 (yyvs.item (yyvsp - 2)), yytype4 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_30 is
			--|#line 180
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := new_il_extension_as (yytype7 (yyvs.item (yyvsp - 4)), operator_type, yytype2 (yyvs.item (yyvsp - 2)), yytype4 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_31 is
			--|#line 186
		local
			yyval7: INTEGER
		do

				yyval7 := msil_language
			
			yyval := yyval7
		end

	yy_do_action_32 is
			--|#line 191
		local
			yyval7: INTEGER
		do

				yyval7 := java_language
			
			yyval := yyval7
		end

	yy_do_action_34 is
			--|#line 198
		local
			yyval2: SIGNATURE_AS
		do

yyval2 := yytype2 (yyvs.item (yyvsp))
			yyval := yyval2
		end

	yy_do_action_35 is
			--|#line 202
		local
			yyval2: SIGNATURE_AS
		do

yyval2 := new_signature_as (yytype8 (yyvs.item (yyvsp - 1)), yytype3 (yyvs.item (yyvsp)))
			yyval := yyval2
		end

	yy_do_action_37 is
			--|#line 209
		local
			yyval8: EIFFEL_LIST [EXTERNAL_TYPE_AS]
		do

yyval8 := yytype8 (yyvs.item (yyvsp))
			yyval := yyval8
		end

	yy_do_action_38 is
			--|#line 213
		local
			yyval8: EIFFEL_LIST [EXTERNAL_TYPE_AS]
		do

yyval8 := yytype8 (yyvs.item (yyvsp - 1))
			yyval := yyval8
		end

	yy_do_action_40 is
			--|#line 220
		local
			yyval8: EIFFEL_LIST [EXTERNAL_TYPE_AS]
		do

yyval8 := yytype8 (yyvs.item (yyvsp))
			yyval := yyval8
		end

	yy_do_action_41 is
			--|#line 224
		local
			yyval8: EIFFEL_LIST [EXTERNAL_TYPE_AS]
		do

			yyval8 := new_eiffel_list_external_type_as (Argument_list_initial_size)
			yyval8.extend (yytype3 (yyvs.item (yyvsp)))
		
			yyval := yyval8
		end

	yy_do_action_42 is
			--|#line 229
		local
			yyval8: EIFFEL_LIST [EXTERNAL_TYPE_AS]
		do

			yyval8 := yytype8 (yyvs.item (yyvsp - 2))
			yyval8.extend (yytype3 (yyvs.item (yyvsp)))
		
			yyval := yyval8
		end

	yy_do_action_44 is
			--|#line 238
		local
			yyval3: EXTERNAL_TYPE_AS
		do

yyval3 := yytype3 (yyvs.item (yyvsp))
			yyval := yyval3
		end

	yy_do_action_45 is
			--|#line 242
		local
			yyval3: EXTERNAL_TYPE_AS
		do

					-- False because no `struct' keyword.
				yyval3 := new_external_type_as (yytype4 (yyvs.item (yyvsp - 2)), False, yytype5 (yyvs.item (yyvsp - 1)), yytype5 (yyvs.item (yyvsp)), False)
			
			yyval := yyval3
		end

	yy_do_action_46 is
			--|#line 248
		local
			yyval3: EXTERNAL_TYPE_AS
		do

					-- True because `struct' keyword.
				yyval3 := new_external_type_as (yytype4 (yyvs.item (yyvsp - 2)), True, yytype5 (yyvs.item (yyvsp - 1)), yytype5 (yyvs.item (yyvsp)), False)
			
			yyval := yyval3
		end

	yy_do_action_48 is
			--|#line 256
		local
			yyval3: EXTERNAL_TYPE_AS
		do

			yyval3 := yytype3 (yyvs.item (yyvsp))
		
			yyval := yyval3
		end

	yy_do_action_49 is
			--|#line 262
		local
			yyval5: BOOLEAN
		do

yyval5 := False
			yyval := yyval5
		end

	yy_do_action_50 is
			--|#line 264
		local
			yyval5: BOOLEAN
		do

yyval5 := True
			yyval := yyval5
		end

	yy_do_action_51 is
			--|#line 268
		local
			yyval5: BOOLEAN
		do

yyval5 := False
			yyval := yyval5
		end

	yy_do_action_52 is
			--|#line 270
		local
			yyval5: BOOLEAN
		do

yyval5 := True
			yyval := yyval5
		end

	yy_do_action_54 is
			--|#line 276
		local
			yyval6: USE_LIST_AS
		do

yyval6 := yytype6 (yyvs.item (yyvsp))
			yyval := yyval6
		end

	yy_do_action_55 is
			--|#line 280
		local
			yyval6: USE_LIST_AS
		do

yyval6 := yytype6 (yyvs.item (yyvsp))
			yyval := yyval6
		end

	yy_do_action_56 is
			--|#line 285
		local
			yyval6: USE_LIST_AS
		do

			yyval6 := new_use_list_as (Argument_list_initial_size)
			yyval6.extend (yytype4 (yyvs.item (yyvsp)))
		
			yyval := yyval6
		end

	yy_do_action_57 is
			--|#line 290
		local
			yyval6: USE_LIST_AS
		do

			yyval6 := yytype6 (yyvs.item (yyvsp - 2))
			yyval6.extend (yytype4 (yyvs.item (yyvsp)))
		
			yyval := yyval6
		end

	yy_do_action_58 is
			--|#line 297
		local
			yyval4: ID_AS
		do

			yyval4 := new_double_quote_id_as (token_buffer)
		
			yyval := yyval4
		end

	yy_do_action_59 is
			--|#line 302
		local
			yyval4: ID_AS
		do

			yyval4 := new_system_id_as (token_buffer)
		
			yyval := yyval4
		end

	yy_do_action_60 is
			--|#line 306
		local
			yyval4: ID_AS
		do

			yyval4 := new_double_quote_id_as (token_buffer)
		
			yyval := yyval4
		end

	yy_do_action_61 is
			--|#line 312
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
			   35,   36,   37>>)
		end

	yyr1_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    0,   38,   38,   38,   38,   38,   39,   39,   39,   39,
			   40,   40,   40,   40,   43,   43,   43,   43,   41,   42,
			   42,   42,   42,   42,   42,   42,   42,   42,   42,   42,
			   42,   56,   56,   44,   44,   45,   57,   57,   58,   59,
			   59,   60,   60,   46,   46,   47,   47,   48,   48,   51,
			   51,   52,   52,   53,   53,   54,   55,   55,   50,   50,
			   50,   49>>)
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
			    1,    1,    3,    0,    2,    3,    4,    0,    2,    0,
			    1,    0,    1,    0,    1,    2,    1,    3,    3,    3,
			    1,    1>>)
		end

	yydefact_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    0,   32,   31,   33,   33,    0,   33,    5,   33,   36,
			    4,    0,   34,    3,   61,    0,    0,    0,   33,    0,
			   53,    2,   10,   33,    0,   33,   53,    1,   53,   33,
			   33,   33,   33,   33,   33,   33,   33,   33,   33,   33,
			    0,   39,   43,   37,    0,   18,    0,   33,   33,    0,
			   33,   13,   54,    0,    0,    0,    9,    6,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,   41,   49,    0,   40,    0,   35,   60,    0,    0,
			   56,   55,    0,    0,    0,   12,    0,   14,    0,    8,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,

			    0,   19,   49,   50,   51,   38,    0,   44,    0,    0,
			    0,   47,   15,   17,   16,   47,   25,   23,   21,   27,
			   29,   26,   30,   20,   22,   28,   24,   51,   52,   45,
			   42,   58,   59,   57,    0,    0,    0,   46,   48,   11,
			    7,    0,    0,    0>>)
		end

	yydefgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			  141,   27,   21,   10,    7,   22,   11,   12,   76,   71,
			  135,   72,   80,  104,  129,   51,   52,   81,    8,   42,
			   43,   73,   74>>)
		end

	yypact_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			   46, -32768, -32768,   27,   27,   -8,    3, -32768,   20,   81,
			 -32768,  -20, -32768, -32768, -32768,   -3,   -3,   -3,   27,   -3,
			  -20, -32768, -32768,   27,   -3,   27,  -20, -32768,  -20,   27,
			   27,   27,   27,   27,   27,   27,   27,   27,   27,   27,
			   61,  -28,   55, -32768,   -6, -32768,   70,   27,   27,  -20,
			   27, -32768, -32768,  -20,   59,  -20, -32768, -32768,   47,   45,
			   44,   43,   41,   40,   38,   33,   32,   26,   21,   -3,
			   -3, -32768,   22,   49,   35,  -28, -32768, -32768,   18,   -1,
			 -32768,   29,   -3,  -20,  -20, -32768,  -20, -32768,   -3, -32768,
			   -3,   -3,   -3,   -3,   -3,   -3,   -3,   -3,   -3,   -3,

			   -3, -32768,   22, -32768,   14, -32768,  -28, -32768,   13,   17,
			   -6,   -7, -32768, -32768, -32768,   -7, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768,   14, -32768, -32768,
			 -32768, -32768, -32768, -32768,  -28,  -20,  -20, -32768, -32768, -32768,
			 -32768,   10,    4, -32768>>)
		end

	yypgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			 -32768, -32768, -32768,   98, -32768, -32768,   97, -32768, -32768,  -73,
			  -16,   -4,    0,   -2,  -29,   -9,  -11, -32768, -32768, -32768,
			 -32768, -32768, -32768>>)
		end

	yytable_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			   45,   23,  107,   79,  143,   78,   70,   20,   19,   14,
			  142,   46,   47,   48,   18,   50,   44,   56,   26,   57,
			   54,  128,   17,   16,  131,   25,   15,  132,  134,   14,
			  103,   77,    9,  130,   14,  110,  109,   24,   85,   39,
			   38,  106,   87,   37,   89,   36,   35,   34,   33,    9,
			   32,   31,   30,   29,  105,  108,    9,  100,   75,    6,
			    5,  138,   99,    4,    3,  101,  102,    2,   98,   97,
			    1,   88,  112,  113,   96,  114,   95,   94,  111,   93,
			   92,   91,   82,   90,  115,   41,  116,  117,  118,  119,
			  120,  121,  122,  123,  124,  125,  126,   69,  137,  136,

			  127,    0,   13,   28,    0,   40,    0,    0,    0,    0,
			  133,    0,    0,    0,    0,   49,    0,    0,    0,    0,
			   53,    0,   55,    0,  139,  140,   58,   59,   60,   61,
			   62,   63,   64,   65,   66,   67,   68,    0,    0,    0,
			    0,    0,    0,    0,   83,   84,    0,   86>>)
		end

	yycheck_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			   11,    5,   75,    9,    0,   11,   34,   15,   16,   37,
			    0,   15,   16,   17,   22,   19,   36,   26,   15,   28,
			   24,    7,   30,   31,   11,   22,   34,   10,   35,   37,
			    8,   37,   29,  106,   37,    6,   37,   34,   49,   19,
			   20,    6,   53,   23,   55,   25,   26,   27,   28,   29,
			   30,   31,   32,   33,    5,   37,   29,   36,    3,   13,
			   14,  134,   36,   17,   18,   69,   70,   21,   36,   36,
			   24,   12,   83,   84,   36,   86,   36,   36,   82,   36,
			   36,   36,   12,   36,   88,    4,   90,   91,   92,   93,
			   94,   95,   96,   97,   98,   99,  100,   36,  127,  115,

			  102,   -1,    4,    6,   -1,    8,   -1,   -1,   -1,   -1,
			  110,   -1,   -1,   -1,   -1,   18,   -1,   -1,   -1,   -1,
			   23,   -1,   25,   -1,  135,  136,   29,   30,   31,   32,
			   33,   34,   35,   36,   37,   38,   39,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   47,   48,   -1,   50>>)
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

	yytype6 (v: ANY): USE_LIST_AS is
		require
			valid_type: yyis_type6 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type6 (v: ANY): BOOLEAN is
		local
			u: USE_LIST_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype7 (v: ANY): INTEGER is
		require
			valid_type: yyis_type7 (v)
		local
			ref: INTEGER_REF
		do
			ref ?= v
			Result := ref.item
		end

	yyis_type7 (v: ANY): BOOLEAN is
		local
			u: INTEGER_REF
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

	yyFinal: INTEGER is 143
			-- Termination state id

	yyFlag: INTEGER is -32768
			-- Most negative INTEGER

	yyNtbase: INTEGER is 38
			-- Number of tokens

	yyLast: INTEGER is 147
			-- Upper bound of `yytable' and `yycheck'

	yyMax_token: INTEGER is 292
			-- Maximum token id
			-- (upper bound of `yytranslate'.)

	yyNsyms: INTEGER is 61
			-- Number of symbols
			-- (terminal and nonterminal)

feature -- User-defined features



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
