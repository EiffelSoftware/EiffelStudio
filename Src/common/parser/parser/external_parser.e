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
--|#line 349
	yy_do_action_66
when 67 then
--|#line 355
	yy_do_action_67
when 68 then
--|#line 360
	yy_do_action_68
when 69 then
--|#line 366
	yy_do_action_69
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
				create {STRUCT_EXTENSION_AS} yyval1.initialize (False, yytype3 (yyvs.item (yyvsp - 4)), yytype4 (yyvs.item (yyvsp - 2)), yytype3 (yyvs.item (yyvsp - 1)), yytype7 (yyvs.item (yyvsp)))
			
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
				create {STRUCT_EXTENSION_AS} yyval1.initialize (True, yytype3 (yyvs.item (yyvsp - 4)), yytype4 (yyvs.item (yyvsp - 2)), yytype3 (yyvs.item (yyvsp - 1)), yytype7 (yyvs.item (yyvsp)))
			
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

			yyval4 := new_system_id_as (token_buffer)
		
			yyval := yyval4
		end

	yy_do_action_66 is
			--|#line 349
		local
			yyval4: ID_AS
		do

			yyval4 := new_double_quote_id_as (token_buffer)
		
			yyval := yyval4
		end

	yy_do_action_67 is
			--|#line 355
		local
			yyval4: ID_AS
		do

			yyval4 := new_double_quote_id_as (token_buffer)
		
			yyval := yyval4
		end

	yy_do_action_68 is
			--|#line 360
		local
			yyval4: ID_AS
		do

			yyval4 := new_double_quote_id_as (token_buffer)
		
			yyval := yyval4
		end

	yy_do_action_69 is
			--|#line 366
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
			   35,   36,   37,   38,   39,   40,   41>>)
		end

	yyr1_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    0,   42,   42,   42,   42,   42,   43,   43,   43,   43,
			   44,   44,   44,   44,   48,   48,   48,   48,   45,   46,
			   59,   59,   47,   47,   47,   47,   47,   47,   47,   47,
			   47,   47,   47,   47,   63,   63,   49,   49,   50,   64,
			   64,   65,   66,   66,   67,   67,   51,   51,   52,   52,
			   52,   52,   53,   53,   58,   58,   57,   57,   60,   60,
			   61,   62,   62,   55,   55,   55,   55,   56,   56,   54>>)
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
			    2,    1,    3,    3,    3,    3,    1,    3,    1,    1>>)
		end

	yydefact_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    0,   35,   34,    0,    0,    0,   36,    3,    4,    5,
			   36,   68,    0,   20,   20,   69,    0,    0,    0,   36,
			    0,   58,    2,   10,   36,    0,   39,   36,   58,    1,
			   58,   37,   36,   36,   36,   36,   36,   36,   36,   36,
			   36,   36,   36,    0,    0,   21,   36,   36,    0,    0,
			    0,    0,   54,   36,   36,    0,   36,    0,   13,   59,
			    0,    0,   42,   46,   40,    0,    9,    6,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			   67,   58,   58,   54,   54,   54,    0,   56,    0,    0,
			   12,    0,   66,    0,    0,   61,   60,   14,    0,   44,

			    0,   43,    0,   38,    8,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,   22,   19,   18,   56,
			   56,   56,   52,   55,   57,   48,   15,   17,   16,    0,
			    0,    0,    0,   52,   41,    0,   47,   28,   26,   24,
			   30,   32,   29,   33,   23,   25,   31,   27,   51,   50,
			   49,    0,    0,   63,   65,   64,   62,    0,   45,   53,
			   11,    7,    0,    0,    0>>)
		end

	yydefgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			  162,   29,   22,    7,    8,    9,   23,   30,   31,  103,
			   51,  152,   52,   95,   13,  125,   87,   46,   58,   59,
			   96,   10,   63,   64,  100,  101>>)
		end

	yypact_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			   -5, -32768, -32768,   -9,   -9,   12,   18, -32768, -32768, -32768,
			   40, -32768,   63,   73,   73, -32768,   41,   21,   21,   16,
			   21,  -14, -32768, -32768,   16,   41,   94,   16,  -14, -32768,
			  -14, -32768,   16,   16,   16,   16,   16,   16,   16,   16,
			   16,   16,   16,   60,   86, -32768,   16,   16,   21,   21,
			   21,   84, -32768,   16,   16,  -14,   16,   -8, -32768, -32768,
			  -14,   83,   41,   77, -32768,  -14, -32768, -32768,   55,   54,
			   52,   51,   50,   49,   48,   47,   45,   44,   43,   21,
			 -32768,  -14,  -14, -32768, -32768, -32768,   21,   10,  -14,  -14,
			 -32768,  -14, -32768,   35,  -11, -32768,   61, -32768,   21, -32768,

			   59,   56,   41, -32768, -32768,   21,   21,   21,   21,   21,
			   21,   21,   21,   21,   21,   21, -32768, -32768, -32768,   10,
			   10,   10,   -1, -32768, -32768, -32768, -32768, -32768, -32768,   34,
			   32,   26,   -8,   -1, -32768,   41, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768,   41,  -14, -32768, -32768, -32768, -32768,  -14, -32768, -32768,
			 -32768, -32768,   14,    7, -32768>>)
		end

	yypgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768,  112, -32768, -32768,
			  -25,  -10,    6,  -26,  101,  -70,  -63,   87,  -24,  -50,
			 -32768, -32768, -32768, -32768, -32768, -32768>>)
		end

	yytable_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			   61,   94,   12,   93,   66,   90,   67,  164,    6,    5,
			   97,   24,    4,    3,  163,  104,    2,  124,  123,    1,
			  119,  120,  121,   53,   54,   57,   56,   21,   20,  131,
			  130,   11,   92,   28,   19,  151,  155,   99,  126,  127,
			   27,  128,  154,   18,   17,  153,   26,   16,   26,  148,
			  149,  150,   15,   25,   83,   84,   85,  117,  118,   42,
			   41,   15,  135,   40,  134,   39,   38,  132,   37,   36,
			   26,   35,   34,   33,   32,  129,   50,  136,   49,   48,
			  102,   15,  115,  114,  113,  116,  112,  111,  110,  109,
			  108,  107,  122,  106,  105,   98,   86,   80,   62,   79,

			   45,   47,  160,   44,  133,   14,  156,  161,    0,    0,
			  158,  137,  138,  139,  140,  141,  142,  143,  144,  145,
			  146,  147,   43,  157,    0,    0,  159,    0,    0,    0,
			    0,   55,    0,    0,    0,    0,   60,    0,    0,   65,
			    0,    0,    0,    0,   68,   69,   70,   71,   72,   73,
			   74,   75,   76,   77,   78,    0,    0,    0,   81,   82,
			    0,    0,    0,    0,    0,   88,   89,    0,   91>>)
		end

	yycheck_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			   25,    9,   11,   11,   28,   55,   30,    0,   13,   14,
			   60,    5,   17,   18,    0,   65,   21,    7,    8,   24,
			   83,   84,   85,   17,   18,   39,   20,   15,   16,   40,
			   41,   40,   40,   15,   22,   36,   10,   62,   88,   89,
			   22,   91,   10,   31,   32,   11,   30,   35,   30,  119,
			  120,  121,   40,   35,   48,   49,   50,   81,   82,   19,
			   20,   40,    6,   23,    5,   25,   26,    6,   28,   29,
			   30,   31,   32,   33,   34,   40,   35,  102,   37,   38,
			    3,   40,   39,   39,   39,   79,   39,   39,   39,   39,
			   39,   39,   86,   39,   39,   12,   12,   11,    4,   39,

			   27,   14,  152,   40,   98,    4,  132,  157,   -1,   -1,
			  135,  105,  106,  107,  108,  109,  110,  111,  112,  113,
			  114,  115,   10,  133,   -1,   -1,  151,   -1,   -1,   -1,
			   -1,   19,   -1,   -1,   -1,   -1,   24,   -1,   -1,   27,
			   -1,   -1,   -1,   -1,   32,   33,   34,   35,   36,   37,
			   38,   39,   40,   41,   42,   -1,   -1,   -1,   46,   47,
			   -1,   -1,   -1,   -1,   -1,   53,   54,   -1,   56>>)
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

	yyFinal: INTEGER is 164
			-- Termination state id

	yyFlag: INTEGER is -32768
			-- Most negative INTEGER

	yyNtbase: INTEGER is 42
			-- Number of tokens

	yyLast: INTEGER is 168
			-- Upper bound of `yytable' and `yycheck'

	yyMax_token: INTEGER is 296
			-- Maximum token id
			-- (upper bound of `yytranslate'.)

	yyNsyms: INTEGER is 68
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
