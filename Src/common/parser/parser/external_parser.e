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
--|#line 49
	yy_do_action_1
when 2 then
--|#line 54
	yy_do_action_2
when 3 then
--|#line 58
	yy_do_action_3
when 4 then
--|#line 62
	yy_do_action_4
when 5 then
--|#line 66
	yy_do_action_5
when 6 then
--|#line 72
	yy_do_action_6
when 7 then
--|#line 77
	yy_do_action_7
when 8 then
--|#line 82
	yy_do_action_8
when 9 then
--|#line 87
	yy_do_action_9
when 10 then
--|#line 93
	yy_do_action_10
when 11 then
--|#line 98
	yy_do_action_11
when 12 then
--|#line 103
	yy_do_action_12
when 13 then
--|#line 108
	yy_do_action_13
when 14 then
--|#line 114
	yy_do_action_14
when 15 then
--|#line 119
	yy_do_action_15
when 16 then
--|#line 123
	yy_do_action_16
when 17 then
--|#line 127
	yy_do_action_17
when 19 then
--|#line 136
	yy_do_action_19
when 20 then
--|#line 141
	yy_do_action_20
when 21 then
--|#line 145
	yy_do_action_21
when 22 then
--|#line 149
	yy_do_action_22
when 23 then
--|#line 153
	yy_do_action_23
when 24 then
--|#line 157
	yy_do_action_24
when 25 then
--|#line 161
	yy_do_action_25
when 26 then
--|#line 165
	yy_do_action_26
when 27 then
--|#line 169
	yy_do_action_27
when 28 then
--|#line 173
	yy_do_action_28
when 29 then
--|#line 177
	yy_do_action_29
when 30 then
--|#line 181
	yy_do_action_30
when 31 then
--|#line 187
	yy_do_action_31
when 32 then
--|#line 192
	yy_do_action_32
when 34 then
--|#line 199
	yy_do_action_34
when 35 then
--|#line 203
	yy_do_action_35
when 37 then
--|#line 210
	yy_do_action_37
when 38 then
--|#line 214
	yy_do_action_38
when 40 then
--|#line 221
	yy_do_action_40
when 41 then
--|#line 225
	yy_do_action_41
when 42 then
--|#line 230
	yy_do_action_42
when 44 then
--|#line 239
	yy_do_action_44
when 45 then
--|#line 243
	yy_do_action_45
when 46 then
--|#line 249
	yy_do_action_46
when 48 then
--|#line 257
	yy_do_action_48
when 49 then
--|#line 263
	yy_do_action_49
when 50 then
--|#line 265
	yy_do_action_50
when 51 then
--|#line 269
	yy_do_action_51
when 52 then
--|#line 271
	yy_do_action_52
when 54 then
--|#line 277
	yy_do_action_54
when 55 then
--|#line 281
	yy_do_action_55
when 56 then
--|#line 286
	yy_do_action_56
when 57 then
--|#line 291
	yy_do_action_57
when 58 then
--|#line 298
	yy_do_action_58
when 59 then
--|#line 303
	yy_do_action_59
when 60 then
--|#line 307
	yy_do_action_60
when 61 then
--|#line 313
	yy_do_action_61
			else
					-- No action
				yyval := yyval_default
			end
		end

	yy_do_action_1 is
			--|#line 49
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				root_node := yytype1 (yyvs.item (yyvsp))
			
			yyval := yyval1
		end

	yy_do_action_2 is
			--|#line 54
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				root_node := yytype1 (yyvs.item (yyvsp))
			
			yyval := yyval1
		end

	yy_do_action_3 is
			--|#line 58
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				root_node := yytype1 (yyvs.item (yyvsp))
			
			yyval := yyval1
		end

	yy_do_action_4 is
			--|#line 62
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				root_node := yytype1 (yyvs.item (yyvsp))
			
			yyval := yyval1
		end

	yy_do_action_5 is
			--|#line 66
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				root_node := yytype1 (yyvs.item (yyvsp))
			
			yyval := yyval1
		end

	yy_do_action_6 is
			--|#line 72
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := new_c_extension_as (yytype2 (yyvs.item (yyvsp - 1)), yytype7 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_7 is
			--|#line 77
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

					-- False because this is a C construct
				yyval1 := new_struct_extension_as (yytype4 (yyvs.item (yyvsp - 4)), yytype4 (yyvs.item (yyvsp - 2)), yytype3 (yyvs.item (yyvsp - 1)), yytype7 (yyvs.item (yyvsp)), False)
			
			yyval := yyval1
		end

	yy_do_action_8 is
			--|#line 82
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

					-- False because this is a C construct
				yyval1 := new_macro_extension_as (yytype2 (yyvs.item (yyvsp - 1)), yytype7 (yyvs.item (yyvsp)), False)
			
			yyval := yyval1
		end

	yy_do_action_9 is
			--|#line 87
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := new_inline_as
			
			yyval := yyval1
		end

	yy_do_action_10 is
			--|#line 93
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := yytype1 (yyvs.item (yyvsp))
			
			yyval := yyval1
		end

	yy_do_action_11 is
			--|#line 98
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

					-- True because this is a C++ construct
				yyval1 := new_struct_extension_as (yytype4 (yyvs.item (yyvsp - 4)), yytype4 (yyvs.item (yyvsp - 2)), yytype3 (yyvs.item (yyvsp - 1)), yytype7 (yyvs.item (yyvsp)), True)
			
			yyval := yyval1
		end

	yy_do_action_12 is
			--|#line 103
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

					-- True because this is a C++ construct
				yyval1 := new_macro_extension_as (yytype2 (yyvs.item (yyvsp - 1)), yytype7 (yyvs.item (yyvsp)), True)
			
			yyval := yyval1
		end

	yy_do_action_13 is
			--|#line 108
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := new_inline_as
			
			yyval := yyval1
		end

	yy_do_action_14 is
			--|#line 114
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := new_cpp_extension_as (standard, yytype4 (yyvs.item (yyvsp - 2)), yytype2 (yyvs.item (yyvsp - 1)), yytype7 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_15 is
			--|#line 119
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := new_cpp_extension_as (creator, yytype4 (yyvs.item (yyvsp - 2)), yytype2 (yyvs.item (yyvsp - 1)), yytype7 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_16 is
			--|#line 123
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := new_cpp_extension_as (delete, yytype4 (yyvs.item (yyvsp - 2)), yytype2 (yyvs.item (yyvsp - 1)), yytype7 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_17 is
			--|#line 127
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := new_cpp_extension_as (static, yytype4 (yyvs.item (yyvsp - 2)), yytype2 (yyvs.item (yyvsp - 1)), yytype7 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_19 is
			--|#line 136
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := new_il_extension_as (yytype6 (yyvs.item (yyvsp - 3)), normal_type, yytype2 (yyvs.item (yyvsp - 2)), yytype4 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_20 is
			--|#line 141
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := new_il_extension_as (yytype6 (yyvs.item (yyvsp - 4)), deferred_type, yytype2 (yyvs.item (yyvsp - 2)), yytype4 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_21 is
			--|#line 145
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := new_il_extension_as (yytype6 (yyvs.item (yyvsp - 4)), creator_type, yytype2 (yyvs.item (yyvsp - 2)), yytype4 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_22 is
			--|#line 149
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := new_il_extension_as (yytype6 (yyvs.item (yyvsp - 4)), field_type, yytype2 (yyvs.item (yyvsp - 2)), yytype4 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_23 is
			--|#line 153
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := new_il_extension_as (yytype6 (yyvs.item (yyvsp - 4)), static_field_type, yytype2 (yyvs.item (yyvsp - 2)), yytype4 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_24 is
			--|#line 157
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := new_il_extension_as (yytype6 (yyvs.item (yyvsp - 4)), enum_field_type, yytype2 (yyvs.item (yyvsp - 2)), yytype4 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_25 is
			--|#line 161
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := new_il_extension_as (yytype6 (yyvs.item (yyvsp - 4)), set_static_field_type, yytype2 (yyvs.item (yyvsp - 2)), yytype4 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_26 is
			--|#line 165
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := new_il_extension_as (yytype6 (yyvs.item (yyvsp - 4)), set_field_type, yytype2 (yyvs.item (yyvsp - 2)), yytype4 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_27 is
			--|#line 169
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := new_il_extension_as (yytype6 (yyvs.item (yyvsp - 4)), static_type, yytype2 (yyvs.item (yyvsp - 2)), yytype4 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_28 is
			--|#line 173
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := new_il_extension_as (yytype6 (yyvs.item (yyvsp - 4)), get_property_type, yytype2 (yyvs.item (yyvsp - 2)), yytype4 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_29 is
			--|#line 177
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := new_il_extension_as (yytype6 (yyvs.item (yyvsp - 4)), set_property_type, yytype2 (yyvs.item (yyvsp - 2)), yytype4 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_30 is
			--|#line 181
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := new_il_extension_as (yytype6 (yyvs.item (yyvsp - 4)), operator_type, yytype2 (yyvs.item (yyvsp - 2)), yytype4 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_31 is
			--|#line 187
		local
			yyval6: INTEGER
		do

				yyval6 := msil_language
			
			yyval := yyval6
		end

	yy_do_action_32 is
			--|#line 192
		local
			yyval6: INTEGER
		do

				yyval6 := java_language
			
			yyval := yyval6
		end

	yy_do_action_34 is
			--|#line 199
		local
			yyval2: SIGNATURE_AS
		do

yyval2 := yytype2 (yyvs.item (yyvsp))
			yyval := yyval2
		end

	yy_do_action_35 is
			--|#line 203
		local
			yyval2: SIGNATURE_AS
		do

yyval2 := new_signature_as (yytype8 (yyvs.item (yyvsp - 1)), yytype3 (yyvs.item (yyvsp)))
			yyval := yyval2
		end

	yy_do_action_37 is
			--|#line 210
		local
			yyval8: EIFFEL_LIST [EXTERNAL_TYPE_AS]
		do

yyval8 := yytype8 (yyvs.item (yyvsp))
			yyval := yyval8
		end

	yy_do_action_38 is
			--|#line 214
		local
			yyval8: EIFFEL_LIST [EXTERNAL_TYPE_AS]
		do

yyval8 := yytype8 (yyvs.item (yyvsp - 1))
			yyval := yyval8
		end

	yy_do_action_40 is
			--|#line 221
		local
			yyval8: EIFFEL_LIST [EXTERNAL_TYPE_AS]
		do

yyval8 := yytype8 (yyvs.item (yyvsp))
			yyval := yyval8
		end

	yy_do_action_41 is
			--|#line 225
		local
			yyval8: EIFFEL_LIST [EXTERNAL_TYPE_AS]
		do

			yyval8 := new_eiffel_list_external_type_as (Argument_list_initial_size)
			yyval8.extend (yytype3 (yyvs.item (yyvsp)))
		
			yyval := yyval8
		end

	yy_do_action_42 is
			--|#line 230
		local
			yyval8: EIFFEL_LIST [EXTERNAL_TYPE_AS]
		do

			yyval8 := yytype8 (yyvs.item (yyvsp - 2))
			yyval8.extend (yytype3 (yyvs.item (yyvsp)))
		
			yyval := yyval8
		end

	yy_do_action_44 is
			--|#line 239
		local
			yyval3: EXTERNAL_TYPE_AS
		do

yyval3 := yytype3 (yyvs.item (yyvsp))
			yyval := yyval3
		end

	yy_do_action_45 is
			--|#line 243
		local
			yyval3: EXTERNAL_TYPE_AS
		do

					-- False because no `struct' keyword.
				yyval3 := new_external_type_as (yytype4 (yyvs.item (yyvsp - 2)), False, yytype6 (yyvs.item (yyvsp - 1)), yytype5 (yyvs.item (yyvsp)), False)
			
			yyval := yyval3
		end

	yy_do_action_46 is
			--|#line 249
		local
			yyval3: EXTERNAL_TYPE_AS
		do

					-- True because `struct' keyword.
				yyval3 := new_external_type_as (yytype4 (yyvs.item (yyvsp - 2)), True, yytype6 (yyvs.item (yyvsp - 1)), yytype5 (yyvs.item (yyvsp)), False)
			
			yyval := yyval3
		end

	yy_do_action_48 is
			--|#line 257
		local
			yyval3: EXTERNAL_TYPE_AS
		do

			yyval3 := yytype3 (yyvs.item (yyvsp))
		
			yyval := yyval3
		end

	yy_do_action_49 is
			--|#line 263
		local
			yyval6: INTEGER
		do

yyval6 := 0
			yyval := yyval6
		end

	yy_do_action_50 is
			--|#line 265
		local
			yyval6: INTEGER
		do

yyval6 := yytype6 (yyvs.item (yyvsp - 1)) + 1
			yyval := yyval6
		end

	yy_do_action_51 is
			--|#line 269
		local
			yyval5: BOOLEAN
		do

yyval5 := False
			yyval := yyval5
		end

	yy_do_action_52 is
			--|#line 271
		local
			yyval5: BOOLEAN
		do

yyval5 := True
			yyval := yyval5
		end

	yy_do_action_54 is
			--|#line 277
		local
			yyval7: USE_LIST_AS
		do

yyval7 := yytype7 (yyvs.item (yyvsp))
			yyval := yyval7
		end

	yy_do_action_55 is
			--|#line 281
		local
			yyval7: USE_LIST_AS
		do

yyval7 := yytype7 (yyvs.item (yyvsp))
			yyval := yyval7
		end

	yy_do_action_56 is
			--|#line 286
		local
			yyval7: USE_LIST_AS
		do

			yyval7 := new_use_list_as (Argument_list_initial_size)
			yyval7.extend (yytype4 (yyvs.item (yyvsp)))
		
			yyval := yyval7
		end

	yy_do_action_57 is
			--|#line 291
		local
			yyval7: USE_LIST_AS
		do

			yyval7 := yytype7 (yyvs.item (yyvsp - 2))
			yyval7.extend (yytype4 (yyvs.item (yyvsp)))
		
			yyval := yyval7
		end

	yy_do_action_58 is
			--|#line 298
		local
			yyval4: ID_AS
		do

			yyval4 := new_double_quote_id_as (token_buffer)
		
			yyval := yyval4
		end

	yy_do_action_59 is
			--|#line 303
		local
			yyval4: ID_AS
		do

			yyval4 := new_system_id_as (token_buffer)
		
			yyval := yyval4
		end

	yy_do_action_60 is
			--|#line 307
		local
			yyval4: ID_AS
		do

			yyval4 := new_double_quote_id_as (token_buffer)
		
			yyval := yyval4
		end

	yy_do_action_61 is
			--|#line 313
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
			   59,   60,   60,   46,   46,   47,   47,   48,   48,   52,
			   52,   51,   51,   53,   53,   54,   55,   55,   50,   50,
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
			    2,    0,    1,    0,    1,    2,    1,    3,    3,    3,
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

			    0,   19,   49,   51,   38,    0,   44,    0,    0,    0,
			   47,   15,   17,   16,   47,   25,   23,   21,   27,   29,
			   26,   30,   20,   22,   28,   24,   51,   50,   52,   45,
			   42,   58,   59,   57,    0,    0,    0,   46,   48,   11,
			    7,    0,    0,    0>>)
		end

	yydefgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			  141,   27,   21,   10,    7,   22,   11,   12,   76,   71,
			  135,   72,   80,  129,  103,   51,   52,   81,    8,   42,
			   43,   73,   74>>)
		end

	yypact_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			   50, -32768, -32768,   53,   53,   -8,    6, -32768,   26,   93,
			 -32768,  -19, -32768, -32768, -32768,   -3,   -3,   -3,   53,   -3,
			  -19, -32768, -32768,   53,   -3,   53,  -19, -32768,  -19,   53,
			   53,   53,   53,   53,   53,   53,   53,   53,   53,   53,
			   49,  -28,   59, -32768,   -6, -32768,   71,   53,   53,  -19,
			   53, -32768, -32768,  -19,   57,  -19, -32768, -32768,   45,   44,
			   43,   41,   40,   34,   24,   14,   12,   11,    7,   -3,
			   -3, -32768, -32768,   36,   33,  -28, -32768, -32768,    0,   -1,
			 -32768,   27,   -3,  -19,  -19, -32768,  -19, -32768,   -3, -32768,
			   -3,   -3,   -3,   -3,   -3,   -3,   -3,   -3,   -3,   -3,

			   -3, -32768, -32768,   17, -32768,  -28, -32768,   16,   20,   -6,
			  -16, -32768, -32768, -32768,  -16, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768,   17, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768,  -28,  -19,  -19, -32768, -32768, -32768,
			 -32768,   10,    4, -32768>>)
		end

	yypgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			 -32768, -32768, -32768,   94, -32768, -32768,   97, -32768, -32768,  -73,
			  -13,   -4,   -7,  -27,   -2,  -10,  -11, -32768, -32768, -32768,
			 -32768, -32768, -32768>>)
		end

	yytable_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			   45,   23,  106,   79,  143,   78,   70,   20,   19,   14,
			  142,   46,   47,   48,   18,   50,   56,   44,   57,  134,
			   54,   26,   17,   16,  128,  127,   15,  131,   25,   14,
			  132,   77,  130,  109,   14,    9,  108,  107,   85,  105,
			   24,  104,   87,  100,   89,   39,   38,   99,   98,   37,
			   97,   36,   35,   34,   33,    9,   32,   31,   30,   29,
			   96,  138,   75,    6,    5,  101,  102,    4,    3,   88,
			   95,    2,  111,  112,    1,  113,   94,   93,  110,   92,
			   91,   90,    9,   82,  114,   69,  115,  116,  117,  118,
			  119,  120,  121,  122,  123,  124,  125,   41,   13,  137,

			  126,  136,  133,   28,    0,   40,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,   49,    0,    0,    0,    0,
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
			    0,   15,   16,   17,   22,   19,   26,   36,   28,   35,
			   24,   15,   30,   31,    7,    8,   34,   11,   22,   37,
			   10,   37,  105,    6,   37,   29,   37,   37,   49,    6,
			   34,    5,   53,   36,   55,   19,   20,   36,   36,   23,
			   36,   25,   26,   27,   28,   29,   30,   31,   32,   33,
			   36,  134,    3,   13,   14,   69,   70,   17,   18,   12,
			   36,   21,   83,   84,   24,   86,   36,   36,   82,   36,
			   36,   36,   29,   12,   88,   36,   90,   91,   92,   93,
			   94,   95,   96,   97,   98,   99,  100,    4,    4,  126,

			  102,  114,  109,    6,   -1,    8,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   18,   -1,   -1,   -1,   -1,
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
