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
--|#line 56
	yy_do_action_1
when 2 then
--|#line 61
	yy_do_action_2
when 3 then
--|#line 65
	yy_do_action_3
when 4 then
--|#line 69
	yy_do_action_4
when 5 then
--|#line 73
	yy_do_action_5
when 6 then
--|#line 79
	yy_do_action_6
when 7 then
--|#line 84
	yy_do_action_7
when 8 then
--|#line 89
	yy_do_action_8
when 9 then
--|#line 94
	yy_do_action_9
when 10 then
--|#line 100
	yy_do_action_10
when 11 then
--|#line 105
	yy_do_action_11
when 12 then
--|#line 110
	yy_do_action_12
when 13 then
--|#line 115
	yy_do_action_13
when 14 then
--|#line 121
	yy_do_action_14
when 15 then
--|#line 126
	yy_do_action_15
when 16 then
--|#line 130
	yy_do_action_16
when 17 then
--|#line 134
	yy_do_action_17
when 18 then
--|#line 140
	yy_do_action_18
when 19 then
--|#line 147
	yy_do_action_19
when 20 then
--|#line 154
	yy_do_action_20
when 21 then
--|#line 156
	yy_do_action_21
when 22 then
--|#line 160
	yy_do_action_22
when 23 then
--|#line 165
	yy_do_action_23
when 24 then
--|#line 169
	yy_do_action_24
when 25 then
--|#line 173
	yy_do_action_25
when 26 then
--|#line 177
	yy_do_action_26
when 27 then
--|#line 181
	yy_do_action_27
when 28 then
--|#line 185
	yy_do_action_28
when 29 then
--|#line 189
	yy_do_action_29
when 30 then
--|#line 193
	yy_do_action_30
when 31 then
--|#line 197
	yy_do_action_31
when 32 then
--|#line 201
	yy_do_action_32
when 33 then
--|#line 205
	yy_do_action_33
when 34 then
--|#line 211
	yy_do_action_34
when 35 then
--|#line 216
	yy_do_action_35
when 37 then
--|#line 223
	yy_do_action_37
when 38 then
--|#line 227
	yy_do_action_38
when 40 then
--|#line 236
	yy_do_action_40
when 41 then
--|#line 240
	yy_do_action_41
when 43 then
--|#line 247
	yy_do_action_43
when 44 then
--|#line 251
	yy_do_action_44
when 45 then
--|#line 256
	yy_do_action_45
when 47 then
--|#line 265
	yy_do_action_47
when 48 then
--|#line 269
	yy_do_action_48
when 49 then
--|#line 276
	yy_do_action_49
when 50 then
--|#line 282
	yy_do_action_50
when 51 then
--|#line 287
	yy_do_action_51
when 53 then
--|#line 295
	yy_do_action_53
when 54 then
--|#line 301
	yy_do_action_54
when 55 then
--|#line 303
	yy_do_action_55
when 56 then
--|#line 307
	yy_do_action_56
when 57 then
--|#line 309
	yy_do_action_57
when 59 then
--|#line 315
	yy_do_action_59
when 60 then
--|#line 319
	yy_do_action_60
when 61 then
--|#line 324
	yy_do_action_61
when 62 then
--|#line 329
	yy_do_action_62
when 63 then
--|#line 336
	yy_do_action_63
when 64 then
--|#line 341
	yy_do_action_64
when 65 then
--|#line 345
	yy_do_action_65
when 66 then
--|#line 351
	yy_do_action_66
when 67 then
--|#line 356
	yy_do_action_67
when 68 then
--|#line 362
	yy_do_action_68
			else
					-- No action
				yyval := yyval_default
			end
		end

	yy_do_action_1 is
			--|#line 56
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				root_node := yytype1 (yyvs.item (yyvsp))
			
			yyval := yyval1
		end

	yy_do_action_2 is
			--|#line 61
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				root_node := yytype1 (yyvs.item (yyvsp))
			
			yyval := yyval1
		end

	yy_do_action_3 is
			--|#line 65
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				root_node := yytype1 (yyvs.item (yyvsp))
			
			yyval := yyval1
		end

	yy_do_action_4 is
			--|#line 69
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				root_node := yytype1 (yyvs.item (yyvsp))
			
			yyval := yyval1
		end

	yy_do_action_5 is
			--|#line 73
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				root_node := yytype1 (yyvs.item (yyvsp))
			
			yyval := yyval1
		end

	yy_do_action_6 is
			--|#line 79
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				create {C_EXTENSION_AS} yyval1.initialize (yytype2 (yyvs.item (yyvsp - 1)), yytype7 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_7 is
			--|#line 84
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

					-- False because this is a C construct
				create {STRUCT_EXTENSION_AS} yyval1.initialize (False, yytype4 (yyvs.item (yyvsp - 4)), yytype4 (yyvs.item (yyvsp - 2)), yytype3 (yyvs.item (yyvsp - 1)), yytype7 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_8 is
			--|#line 89
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

					-- False because this is a C construct
				create {MACRO_EXTENSION_AS} yyval1.initialize (False, yytype2 (yyvs.item (yyvsp - 1)), yytype7 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_9 is
			--|#line 94
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := Void
			
			yyval := yyval1
		end

	yy_do_action_10 is
			--|#line 100
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := yytype1 (yyvs.item (yyvsp))
			
			yyval := yyval1
		end

	yy_do_action_11 is
			--|#line 105
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

					-- True because this is a C++ construct
				create {STRUCT_EXTENSION_AS} yyval1.initialize (True, yytype4 (yyvs.item (yyvsp - 4)), yytype4 (yyvs.item (yyvsp - 2)), yytype3 (yyvs.item (yyvsp - 1)), yytype7 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_12 is
			--|#line 110
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

					-- True because this is a C++ construct
				create {MACRO_EXTENSION_AS} yyval1.initialize (True, yytype2 (yyvs.item (yyvsp - 1)), yytype7 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_13 is
			--|#line 115
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				yyval1 := Void
			
			yyval := yyval1
		end

	yy_do_action_14 is
			--|#line 121
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				create {CPP_EXTENSION_AS} yyval1.initialize (standard, yytype4 (yyvs.item (yyvsp - 2)), yytype2 (yyvs.item (yyvsp - 1)), yytype7 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_15 is
			--|#line 126
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				create {CPP_EXTENSION_AS} yyval1.initialize (creator, yytype4 (yyvs.item (yyvsp - 2)), yytype2 (yyvs.item (yyvsp - 1)), yytype7 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_16 is
			--|#line 130
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				create {CPP_EXTENSION_AS} yyval1.initialize (delete, yytype4 (yyvs.item (yyvsp - 2)), yytype2 (yyvs.item (yyvsp - 1)), yytype7 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_17 is
			--|#line 134
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				create {CPP_EXTENSION_AS} yyval1.initialize (static, yytype4 (yyvs.item (yyvsp - 2)), yytype2 (yyvs.item (yyvsp - 1)), yytype7 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_18 is
			--|#line 140
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				create {DLL_EXTENSION_AS} yyval1.initialize (feature {EXTERNAL_CONSTANTS}.dll32_type,
					yytype4 (yyvs.item (yyvsp - 3)), yytype6 (yyvs.item (yyvsp - 2)), yytype2 (yyvs.item (yyvsp - 1)), yytype7 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_19 is
			--|#line 147
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				create {DLL_EXTENSION_AS} yyval1.initialize (feature {EXTERNAL_CONSTANTS}.dllwin32_type,
					yytype4 (yyvs.item (yyvsp - 3)), yytype6 (yyvs.item (yyvsp - 2)), yytype2 (yyvs.item (yyvsp - 1)), yytype7 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_20 is
			--|#line 154
		local
			yyval6: INTEGER
		do

yyval6 := 0
			yyval := yyval6
		end

	yy_do_action_21 is
			--|#line 156
		local
			yyval6: INTEGER
		do

yyval6 := token_buffer.to_integer
			yyval := yyval6
		end

	yy_do_action_22 is
			--|#line 160
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				create {IL_EXTENSION_AS} yyval1.initialize (yytype6 (yyvs.item (yyvsp - 3)), normal_type, yytype2 (yyvs.item (yyvsp - 2)), yytype4 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_23 is
			--|#line 165
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				create {IL_EXTENSION_AS} yyval1.initialize (yytype6 (yyvs.item (yyvsp - 4)), deferred_type, yytype2 (yyvs.item (yyvsp - 2)), yytype4 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_24 is
			--|#line 169
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				create {IL_EXTENSION_AS} yyval1.initialize (yytype6 (yyvs.item (yyvsp - 4)), creator_type, yytype2 (yyvs.item (yyvsp - 2)), yytype4 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_25 is
			--|#line 173
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				create {IL_EXTENSION_AS} yyval1.initialize (yytype6 (yyvs.item (yyvsp - 4)), field_type, yytype2 (yyvs.item (yyvsp - 2)), yytype4 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_26 is
			--|#line 177
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				create {IL_EXTENSION_AS} yyval1.initialize (yytype6 (yyvs.item (yyvsp - 4)), static_field_type, yytype2 (yyvs.item (yyvsp - 2)), yytype4 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_27 is
			--|#line 181
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				create {IL_EXTENSION_AS} yyval1.initialize (yytype6 (yyvs.item (yyvsp - 4)), enum_field_type, yytype2 (yyvs.item (yyvsp - 2)), yytype4 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_28 is
			--|#line 185
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				create {IL_EXTENSION_AS} yyval1.initialize (yytype6 (yyvs.item (yyvsp - 4)), set_static_field_type, yytype2 (yyvs.item (yyvsp - 2)), yytype4 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_29 is
			--|#line 189
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				create {IL_EXTENSION_AS} yyval1.initialize (yytype6 (yyvs.item (yyvsp - 4)), set_field_type, yytype2 (yyvs.item (yyvsp - 2)), yytype4 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_30 is
			--|#line 193
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				create {IL_EXTENSION_AS} yyval1.initialize (yytype6 (yyvs.item (yyvsp - 4)), static_type, yytype2 (yyvs.item (yyvsp - 2)), yytype4 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_31 is
			--|#line 197
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				create {IL_EXTENSION_AS} yyval1.initialize (yytype6 (yyvs.item (yyvsp - 4)), get_property_type, yytype2 (yyvs.item (yyvsp - 2)), yytype4 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_32 is
			--|#line 201
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				create {IL_EXTENSION_AS} yyval1.initialize (yytype6 (yyvs.item (yyvsp - 4)), set_property_type, yytype2 (yyvs.item (yyvsp - 2)), yytype4 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_33 is
			--|#line 205
		local
			yyval1: EXTERNAL_EXTENSION_AS
		do

				create {IL_EXTENSION_AS} yyval1.initialize (yytype6 (yyvs.item (yyvsp - 4)), operator_type, yytype2 (yyvs.item (yyvsp - 2)), yytype4 (yyvs.item (yyvsp)))
			
			yyval := yyval1
		end

	yy_do_action_34 is
			--|#line 211
		local
			yyval6: INTEGER
		do

				yyval6 := msil_language
			
			yyval := yyval6
		end

	yy_do_action_35 is
			--|#line 216
		local
			yyval6: INTEGER
		do

				yyval6 := java_language
			
			yyval := yyval6
		end

	yy_do_action_37 is
			--|#line 223
		local
			yyval2: SIGNATURE_AS
		do

yyval2 := yytype2 (yyvs.item (yyvsp))
			yyval := yyval2
		end

	yy_do_action_38 is
			--|#line 227
		local
			yyval2: SIGNATURE_AS
		do

				create yyval2.initialize (yytype8 (yyvs.item (yyvsp - 1)), yytype3 (yyvs.item (yyvsp)))
			
			yyval := yyval2
		end

	yy_do_action_40 is
			--|#line 236
		local
			yyval8: EIFFEL_LIST [EXTERNAL_TYPE_AS]
		do

yyval8 := yytype8 (yyvs.item (yyvsp))
			yyval := yyval8
		end

	yy_do_action_41 is
			--|#line 240
		local
			yyval8: EIFFEL_LIST [EXTERNAL_TYPE_AS]
		do

yyval8 := yytype8 (yyvs.item (yyvsp - 1))
			yyval := yyval8
		end

	yy_do_action_43 is
			--|#line 247
		local
			yyval8: EIFFEL_LIST [EXTERNAL_TYPE_AS]
		do

yyval8 := yytype8 (yyvs.item (yyvsp))
			yyval := yyval8
		end

	yy_do_action_44 is
			--|#line 251
		local
			yyval8: EIFFEL_LIST [EXTERNAL_TYPE_AS]
		do

			create {EIFFEL_LIST [EXTERNAL_TYPE_AS]} yyval8.make (Argument_list_initial_size)
			yyval8.extend (yytype3 (yyvs.item (yyvsp)))
		
			yyval := yyval8
		end

	yy_do_action_45 is
			--|#line 256
		local
			yyval8: EIFFEL_LIST [EXTERNAL_TYPE_AS]
		do

			yyval8 := yytype8 (yyvs.item (yyvsp - 2))
			yyval8.extend (yytype3 (yyvs.item (yyvsp)))
		
			yyval := yyval8
		end

	yy_do_action_47 is
			--|#line 265
		local
			yyval3: EXTERNAL_TYPE_AS
		do

yyval3 := yytype3 (yyvs.item (yyvsp))
			yyval := yyval3
		end

	yy_do_action_48 is
			--|#line 269
		local
			yyval3: EXTERNAL_TYPE_AS
		do

					-- False because no `struct' keyword.
					-- Void because no `signed', `unsigned' keyword.
				yyval3 := new_external_type_as (yytype4 (yyvs.item (yyvsp - 2)), Void, False, yytype6 (yyvs.item (yyvsp - 1)), yytype5 (yyvs.item (yyvsp)))
			
			yyval := yyval3
		end

	yy_do_action_49 is
			--|#line 276
		local
			yyval3: EXTERNAL_TYPE_AS
		do

					-- True because `struct' keyword.
					-- Void because no `signed', `unsigned' keyword.
				yyval3 := new_external_type_as (yytype4 (yyvs.item (yyvsp - 2)), Void, True, yytype6 (yyvs.item (yyvsp - 1)), yytype5 (yyvs.item (yyvsp)))
			
			yyval := yyval3
		end

	yy_do_action_50 is
			--|#line 282
		local
			yyval3: EXTERNAL_TYPE_AS
		do

					-- False because no `struct' keyword.
				yyval3 := new_external_type_as (yytype4 (yyvs.item (yyvsp - 2)), signed_prefix, False, yytype6 (yyvs.item (yyvsp - 1)), yytype5 (yyvs.item (yyvsp)))
			
			yyval := yyval3
		end

	yy_do_action_51 is
			--|#line 287
		local
			yyval3: EXTERNAL_TYPE_AS
		do

					-- False because no `struct' keyword.
				yyval3 := new_external_type_as (yytype4 (yyvs.item (yyvsp - 2)), unsigned_prefix, False, yytype6 (yyvs.item (yyvsp - 1)), yytype5 (yyvs.item (yyvsp)))
			
			yyval := yyval3
		end

	yy_do_action_53 is
			--|#line 295
		local
			yyval3: EXTERNAL_TYPE_AS
		do

			yyval3 := yytype3 (yyvs.item (yyvsp))
		
			yyval := yyval3
		end

	yy_do_action_54 is
			--|#line 301
		local
			yyval6: INTEGER
		do

yyval6 := 0
			yyval := yyval6
		end

	yy_do_action_55 is
			--|#line 303
		local
			yyval6: INTEGER
		do

yyval6 := yytype6 (yyvs.item (yyvsp - 1)) + 1
			yyval := yyval6
		end

	yy_do_action_56 is
			--|#line 307
		local
			yyval5: BOOLEAN
		do

yyval5 := False
			yyval := yyval5
		end

	yy_do_action_57 is
			--|#line 309
		local
			yyval5: BOOLEAN
		do

yyval5 := True
			yyval := yyval5
		end

	yy_do_action_59 is
			--|#line 315
		local
			yyval7: USE_LIST_AS
		do

yyval7 := yytype7 (yyvs.item (yyvsp))
			yyval := yyval7
		end

	yy_do_action_60 is
			--|#line 319
		local
			yyval7: USE_LIST_AS
		do

yyval7 := yytype7 (yyvs.item (yyvsp))
			yyval := yyval7
		end

	yy_do_action_61 is
			--|#line 324
		local
			yyval7: USE_LIST_AS
		do

			create {USE_LIST_AS} yyval7.make (Argument_list_initial_size)
			yyval7.extend (yytype4 (yyvs.item (yyvsp)))
		
			yyval := yyval7
		end

	yy_do_action_62 is
			--|#line 329
		local
			yyval7: USE_LIST_AS
		do

			yyval7 := yytype7 (yyvs.item (yyvsp - 2))
			yyval7.extend (yytype4 (yyvs.item (yyvsp)))
		
			yyval := yyval7
		end

	yy_do_action_63 is
			--|#line 336
		local
			yyval4: ID_AS
		do

			yyval4 := new_double_quote_id_as (token_buffer)
		
			yyval := yyval4
		end

	yy_do_action_64 is
			--|#line 341
		local
			yyval4: ID_AS
		do

			yyval4 := new_system_id_as (token_buffer)
		
			yyval := yyval4
		end

	yy_do_action_65 is
			--|#line 345
		local
			yyval4: ID_AS
		do

			yyval4 := new_double_quote_id_as (token_buffer)
		
			yyval := yyval4
		end

	yy_do_action_66 is
			--|#line 351
		local
			yyval4: ID_AS
		do

			yyval4 := new_double_quote_id_as (token_buffer)
		
			yyval := yyval4
		end

	yy_do_action_67 is
			--|#line 356
		local
			yyval4: ID_AS
		do

			yyval4 := new_double_quote_id_as (token_buffer)
		
			yyval := yyval4
		end

	yy_do_action_68 is
			--|#line 362
		local
			yyval4: ID_AS
		do

create yyval4.initialize (token_buffer) 
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
			   35,   36,   37,   38,   39,   40>>)
		end

	yyr1_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    0,   41,   41,   41,   41,   41,   42,   42,   42,   42,
			   43,   43,   43,   43,   47,   47,   47,   47,   44,   45,
			   58,   58,   46,   46,   46,   46,   46,   46,   46,   46,
			   46,   46,   46,   46,   62,   62,   48,   48,   49,   63,
			   63,   64,   65,   65,   66,   66,   50,   50,   51,   51,
			   51,   51,   52,   52,   57,   57,   56,   56,   59,   59,
			   60,   61,   61,   54,   54,   54,   55,   55,   53>>)
		end

	yyr2_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    0,    2,    2,    1,    1,    1,    2,    6,    3,    2,
			    1,    6,    3,    2,    3,    4,    4,    4,    5,    5,
			    0,    1,    4,    5,    5,    5,    5,    5,    5,    5,
			    5,    5,    5,    5,    1,    1,    0,    1,    3,    0,
			    1,    3,    0,    1,    1,    3,    0,    2,    3,    4,
			    4,    4,    0,    2,    0,    2,    0,    1,    0,    1,
			    2,    1,    3,    3,    3,    1,    3,    1,    1>>)
		end

	yydefact_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    0,   35,   34,    0,    0,    0,   36,    3,    4,    5,
			   36,   67,    0,   20,   20,   68,    0,    0,    0,   36,
			    0,   58,    2,   10,   36,    0,   39,   36,   58,    1,
			   58,   37,   36,   36,   36,   36,   36,   36,   36,   36,
			   36,   36,   36,    0,    0,   21,   36,   36,    0,   36,
			   36,    0,   36,    0,   13,   59,    0,    0,   42,   46,
			   40,    0,    9,    6,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,   66,   58,   58,    0,
			    0,    0,   12,    0,   65,    0,    0,   61,   60,   14,
			    0,    0,    0,    0,   44,   54,    0,   43,    0,   38,

			    8,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,   22,   19,   18,   52,   15,   17,   16,    0,
			    0,    0,   52,   54,   54,   54,   56,   41,    0,   47,
			   28,   26,   24,   30,   32,   29,   33,   23,   25,   31,
			   27,    0,    0,   63,   64,   62,    0,   56,   56,   56,
			   55,   57,   48,   45,   53,   11,    7,   51,   50,   49,
			    0,    0,    0>>)
		end

	yydefgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			  160,   29,   22,    7,    8,    9,   23,   30,   31,   99,
			   94,  142,   95,   87,   13,  152,  126,   46,   54,   55,
			   88,   10,   59,   60,   96,   97>>)
		end

	yypact_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			   11, -32768, -32768,   -9,   -9,   22,   34, -32768, -32768, -32768,
			  132, -32768,   50,   62,   62, -32768,   -7,   -7,   -7,   45,
			   -7,  -12, -32768, -32768,   45,   -7,   80,   45,  -12, -32768,
			  -12, -32768,   45,   45,   45,   45,   45,   45,   45,   45,
			   45,   45,   45,   44,   71, -32768,   45,   45,   64,   45,
			   45,  -12,   45,   -4, -32768, -32768,  -12,   61,   23,   65,
			 -32768,  -12, -32768, -32768,   42,   41,   40,   39,   38,   33,
			   32,   28,   27,   26,   16,   -7, -32768,  -12,  -12,   -7,
			  -12,  -12, -32768,  -12, -32768,   19,   12, -32768,   37, -32768,
			   -7,   -7,   -7,   -7, -32768, -32768,   35,   36,   23, -32768,

			 -32768,   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,   -7,
			   -7,   -7, -32768, -32768, -32768,   -6, -32768, -32768, -32768,   30,
			   29,   -4,   -6, -32768, -32768, -32768,   15, -32768,   23, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768,   23,  -12, -32768, -32768, -32768,  -12,   15,   15,   15,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			   14,    6, -32768>>)
		end

	yypgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768,   98, -32768, -32768,
			  -94,  -13,   -5,  -28,   88, -130, -115,   77,  -27,  -35,
			 -32768, -32768, -32768, -32768, -32768, -32768>>)
		end

	yytable_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			   24,   62,   12,   63,  129,   86,  162,   85,  147,  148,
			  149,   48,   49,   50,  161,   52,   82,  157,  158,  159,
			   57,   89,  151,  150,    6,    5,  100,   53,    4,    3,
			  141,   11,    2,   15,  153,    1,   84,   21,   20,  144,
			  127,  143,  128,  121,   19,  116,  117,  154,  118,   28,
			  113,  114,  120,   18,   17,  111,   27,   16,   93,  119,
			   92,   91,   15,   15,   26,  110,  109,  108,   98,   25,
			  112,  107,  106,   90,  115,   26,   79,  105,  104,  103,
			  102,  101,   76,   75,   58,  122,  123,  124,  125,   45,
			   44,   47,   14,  145,    0,    0,  130,  131,  132,  133,

			  134,  135,  136,  137,  138,  139,  140,  155,   43,  146,
			    0,  156,    0,    0,    0,    0,    0,   51,    0,    0,
			    0,    0,   56,    0,    0,   61,    0,    0,    0,    0,
			   64,   65,   66,   67,   68,   69,   70,   71,   72,   73,
			   74,    0,    0,    0,   77,   78,    0,   80,   81,    0,
			   83,   42,   41,    0,    0,   40,    0,   39,   38,    0,
			   37,   36,   26,   35,   34,   33,   32>>)
		end

	yycheck_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    5,   28,   11,   30,   98,    9,    0,   11,  123,  124,
			  125,   16,   17,   18,    0,   20,   51,  147,  148,  149,
			   25,   56,    7,    8,   13,   14,   61,   39,   17,   18,
			   36,   40,   21,   40,  128,   24,   40,   15,   16,   10,
			    5,   11,    6,    6,   22,   80,   81,  141,   83,   15,
			   77,   78,   40,   31,   32,   39,   22,   35,   35,   40,
			   37,   38,   40,   40,   30,   39,   39,   39,    3,   35,
			   75,   39,   39,   12,   79,   30,   12,   39,   39,   39,
			   39,   39,   11,   39,    4,   90,   91,   92,   93,   27,
			   40,   14,    4,  121,   -1,   -1,  101,  102,  103,  104,

			  105,  106,  107,  108,  109,  110,  111,  142,   10,  122,
			   -1,  146,   -1,   -1,   -1,   -1,   -1,   19,   -1,   -1,
			   -1,   -1,   24,   -1,   -1,   27,   -1,   -1,   -1,   -1,
			   32,   33,   34,   35,   36,   37,   38,   39,   40,   41,
			   42,   -1,   -1,   -1,   46,   47,   -1,   49,   50,   -1,
			   52,   19,   20,   -1,   -1,   23,   -1,   25,   26,   -1,
			   28,   29,   30,   31,   32,   33,   34>>)
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

	yyFinal: INTEGER is 162
			-- Termination state id

	yyFlag: INTEGER is -32768
			-- Most negative INTEGER

	yyNtbase: INTEGER is 41
			-- Number of tokens

	yyLast: INTEGER is 166
			-- Upper bound of `yytable' and `yycheck'

	yyMax_token: INTEGER is 295
			-- Maximum token id
			-- (upper bound of `yytranslate'.)

	yyNsyms: INTEGER is 67
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
