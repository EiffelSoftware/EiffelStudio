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
					--|#line 56 "external.y"
				yy_do_action_1
			when 2 then
					--|#line 62 "external.y"
				yy_do_action_2
			when 3 then
					--|#line 67 "external.y"
				yy_do_action_3
			when 4 then
					--|#line 72 "external.y"
				yy_do_action_4
			when 5 then
					--|#line 77 "external.y"
				yy_do_action_5
			when 6 then
					--|#line 83 "external.y"
				yy_do_action_6
			when 7 then
					--|#line 87 "external.y"
				yy_do_action_7
			when 8 then
					--|#line 93 "external.y"
				yy_do_action_8
			when 9 then
					--|#line 98 "external.y"
				yy_do_action_9
			when 10 then
					--|#line 103 "external.y"
				yy_do_action_10
			when 11 then
					--|#line 108 "external.y"
				yy_do_action_11
			when 12 then
					--|#line 114 "external.y"
				yy_do_action_12
			when 13 then
					--|#line 119 "external.y"
				yy_do_action_13
			when 14 then
					--|#line 124 "external.y"
				yy_do_action_14
			when 15 then
					--|#line 129 "external.y"
				yy_do_action_15
			when 16 then
					--|#line 135 "external.y"
				yy_do_action_16
			when 17 then
					--|#line 140 "external.y"
				yy_do_action_17
			when 18 then
					--|#line 144 "external.y"
				yy_do_action_18
			when 19 then
					--|#line 148 "external.y"
				yy_do_action_19
			when 20 then
					--|#line 154 "external.y"
				yy_do_action_20
			when 21 then
					--|#line 161 "external.y"
				yy_do_action_21
			when 22 then
					--|#line 168 "external.y"
				yy_do_action_22
			when 23 then
					--|#line 170 "external.y"
				yy_do_action_23
			when 24 then
					--|#line 174 "external.y"
				yy_do_action_24
			when 25 then
					--|#line 179 "external.y"
				yy_do_action_25
			when 26 then
					--|#line 183 "external.y"
				yy_do_action_26
			when 27 then
					--|#line 187 "external.y"
				yy_do_action_27
			when 28 then
					--|#line 191 "external.y"
				yy_do_action_28
			when 29 then
					--|#line 195 "external.y"
				yy_do_action_29
			when 30 then
					--|#line 199 "external.y"
				yy_do_action_30
			when 31 then
					--|#line 203 "external.y"
				yy_do_action_31
			when 32 then
					--|#line 207 "external.y"
				yy_do_action_32
			when 33 then
					--|#line 211 "external.y"
				yy_do_action_33
			when 34 then
					--|#line 215 "external.y"
				yy_do_action_34
			when 35 then
					--|#line 219 "external.y"
				yy_do_action_35
			when 36 then
					--|#line 225 "external.y"
				yy_do_action_36
			when 37 then
					--|#line 230 "external.y"
				yy_do_action_37
			when 38 then
					--|#line 236 "external.y"
				yy_do_action_38
			when 39 then
					--|#line 237 "external.y"
				yy_do_action_39
			when 40 then
					--|#line 241 "external.y"
				yy_do_action_40
			when 41 then
					--|#line 248 "external.y"
				yy_do_action_41
			when 42 then
					--|#line 250 "external.y"
				yy_do_action_42
			when 43 then
					--|#line 254 "external.y"
				yy_do_action_43
			when 44 then
					--|#line 259 "external.y"
				yy_do_action_44
			when 45 then
					--|#line 261 "external.y"
				yy_do_action_45
			when 46 then
					--|#line 265 "external.y"
				yy_do_action_46
			when 47 then
					--|#line 270 "external.y"
				yy_do_action_47
			when 48 then
					--|#line 277 "external.y"
				yy_do_action_48
			when 49 then
					--|#line 279 "external.y"
				yy_do_action_49
			when 50 then
					--|#line 283 "external.y"
				yy_do_action_50
			when 51 then
					--|#line 290 "external.y"
				yy_do_action_51
			when 52 then
					--|#line 296 "external.y"
				yy_do_action_52
			when 53 then
					--|#line 301 "external.y"
				yy_do_action_53
			when 54 then
					--|#line 308 "external.y"
				yy_do_action_54
			when 55 then
					--|#line 309 "external.y"
				yy_do_action_55
			when 56 then
					--|#line 315 "external.y"
				yy_do_action_56
			when 57 then
					--|#line 317 "external.y"
				yy_do_action_57
			when 58 then
					--|#line 321 "external.y"
				yy_do_action_58
			when 59 then
					--|#line 323 "external.y"
				yy_do_action_59
			when 60 then
					--|#line 327 "external.y"
				yy_do_action_60
			when 61 then
					--|#line 329 "external.y"
				yy_do_action_61
			when 62 then
					--|#line 333 "external.y"
				yy_do_action_62
			when 63 then
					--|#line 338 "external.y"
				yy_do_action_63
			when 64 then
					--|#line 343 "external.y"
				yy_do_action_64
			when 65 then
					--|#line 350 "external.y"
				yy_do_action_65
			when 66 then
					--|#line 355 "external.y"
				yy_do_action_66
			when 67 then
					--|#line 360 "external.y"
				yy_do_action_67
			when 68 then
					--|#line 364 "external.y"
				yy_do_action_68
			when 69 then
					--|#line 368 "external.y"
				yy_do_action_69
			when 70 then
					--|#line 374 "external.y"
				yy_do_action_70
			when 71 then
					--|#line 379 "external.y"
				yy_do_action_71
			when 72 then
					--|#line 385 "external.y"
				yy_do_action_72
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
			--|#line 56 "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line 56 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 56")
end


				root_node := yytype2 (yyvs.item (yyvsp))
				root_node.set_is_blocking_call (yytype6 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_2 is
			--|#line 62 "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line 62 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 62")
end


				root_node := yytype2 (yyvs.item (yyvsp))
				root_node.set_is_blocking_call (yytype6 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_3 is
			--|#line 67 "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line 67 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 67")
end


				root_node := yytype2 (yyvs.item (yyvsp))
				root_node.set_is_blocking_call (yytype6 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_4 is
			--|#line 72 "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line 72 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 72")
end


				root_node := yytype2 (yyvs.item (yyvsp))
				root_node.set_is_blocking_call (yytype6 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_5 is
			--|#line 77 "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line 77 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 77")
end


				root_node := yytype2 (yyvs.item (yyvsp))
			
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_6 is
			--|#line 83 "external.y"
		local
			yyval6: BOOLEAN
		do
--|#line 83 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 83")
end


				yyval6 := False
			
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

	yy_do_action_7 is
			--|#line 87 "external.y"
		local
			yyval6: BOOLEAN
		do
--|#line 87 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 87")
end


				yyval6 := True
			
			yyval := yyval6
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_8 is
			--|#line 93 "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line 93 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 93")
end


				create {C_EXTENSION_AS} yyval2.initialize (yytype3 (yyvs.item (yyvsp - 1)), yytype8 (yyvs.item (yyvsp)))
			
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_9 is
			--|#line 98 "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line 98 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 98")
end


					-- False because this is a C construct
				create {STRUCT_EXTENSION_AS} yyval2.initialize (False, yytype4 (yyvs.item (yyvsp - 4)), yytype5 (yyvs.item (yyvsp - 2)), yytype4 (yyvs.item (yyvsp - 1)), yytype8 (yyvs.item (yyvsp)))
			
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp := yyvsp - 5
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_10 is
			--|#line 103 "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line 103 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 103")
end


					-- False because this is a C construct
				create {MACRO_EXTENSION_AS} yyval2.initialize (False, yytype3 (yyvs.item (yyvsp - 1)), yytype8 (yyvs.item (yyvsp)))
			
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_11 is
			--|#line 108 "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line 108 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 108")
end


				create {INLINE_EXTENSION_AS} yyval2.initialize (False, yytype8 (yyvs.item (yyvsp)))
			
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_12 is
			--|#line 114 "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line 114 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 114")
end


				yyval2 := yytype2 (yyvs.item (yyvsp))
			
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_13 is
			--|#line 119 "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line 119 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 119")
end


					-- True because this is a C++ construct
				create {STRUCT_EXTENSION_AS} yyval2.initialize (True, yytype4 (yyvs.item (yyvsp - 4)), yytype5 (yyvs.item (yyvsp - 2)), yytype4 (yyvs.item (yyvsp - 1)), yytype8 (yyvs.item (yyvsp)))
			
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp := yyvsp - 5
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_14 is
			--|#line 124 "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line 124 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 124")
end


					-- True because this is a C++ construct
				create {MACRO_EXTENSION_AS} yyval2.initialize (True, yytype3 (yyvs.item (yyvsp - 1)), yytype8 (yyvs.item (yyvsp)))
			
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_15 is
			--|#line 129 "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line 129 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 129")
end


				create {INLINE_EXTENSION_AS} yyval2.initialize (True, yytype8 (yyvs.item (yyvsp)))
			
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_16 is
			--|#line 135 "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line 135 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 135")
end


				create {CPP_EXTENSION_AS} yyval2.initialize (standard, yytype5 (yyvs.item (yyvsp - 2)), yytype3 (yyvs.item (yyvsp - 1)), yytype8 (yyvs.item (yyvsp)))
			
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_17 is
			--|#line 140 "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line 140 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 140")
end


				create {CPP_EXTENSION_AS} yyval2.initialize (creator, yytype5 (yyvs.item (yyvsp - 2)), yytype3 (yyvs.item (yyvsp - 1)), yytype8 (yyvs.item (yyvsp)))
			
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_18 is
			--|#line 144 "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line 144 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 144")
end


				create {CPP_EXTENSION_AS} yyval2.initialize (delete, yytype5 (yyvs.item (yyvsp - 2)), yytype3 (yyvs.item (yyvsp - 1)), yytype8 (yyvs.item (yyvsp)))
			
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_19 is
			--|#line 148 "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line 148 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 148")
end


				create {CPP_EXTENSION_AS} yyval2.initialize (static, yytype5 (yyvs.item (yyvsp - 2)), yytype3 (yyvs.item (yyvsp - 1)), yytype8 (yyvs.item (yyvsp)))
			
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_20 is
			--|#line 154 "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line 154 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 154")
end


				create {DLL_EXTENSION_AS} yyval2.initialize (feature {EXTERNAL_CONSTANTS}.dll32_type,
					yytype5 (yyvs.item (yyvsp - 3)), yytype7 (yyvs.item (yyvsp - 2)), yytype3 (yyvs.item (yyvsp - 1)), yytype8 (yyvs.item (yyvsp)))
			
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_21 is
			--|#line 161 "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line 161 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 161")
end


				create {DLL_EXTENSION_AS} yyval2.initialize (feature {EXTERNAL_CONSTANTS}.dllwin32_type,
					yytype5 (yyvs.item (yyvsp - 3)), yytype7 (yyvs.item (yyvsp - 2)), yytype3 (yyvs.item (yyvsp - 1)), yytype8 (yyvs.item (yyvsp)))
			
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_22 is
			--|#line 168 "external.y"
		local
			yyval7: INTEGER
		do
--|#line 168 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 168")
end


yyval7 := -1
			yyval := yyval7
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

	yy_do_action_23 is
			--|#line 170 "external.y"
		local
			yyval7: INTEGER
		do
--|#line 170 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 170")
end


yyval7 := token_buffer.to_integer
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_24 is
			--|#line 174 "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line 174 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 174")
end


				create {IL_EXTENSION_AS} yyval2.initialize (yytype7 (yyvs.item (yyvsp - 3)), normal_type, yytype3 (yyvs.item (yyvsp - 2)), yytype5 (yyvs.item (yyvsp)))
			
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_25 is
			--|#line 179 "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line 179 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 179")
end


				create {IL_EXTENSION_AS} yyval2.initialize (yytype7 (yyvs.item (yyvsp - 4)), deferred_type, yytype3 (yyvs.item (yyvsp - 2)), yytype5 (yyvs.item (yyvsp)))
			
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_26 is
			--|#line 183 "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line 183 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 183")
end


				create {IL_EXTENSION_AS} yyval2.initialize (yytype7 (yyvs.item (yyvsp - 4)), creator_type, yytype3 (yyvs.item (yyvsp - 2)), yytype5 (yyvs.item (yyvsp)))
			
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_27 is
			--|#line 187 "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line 187 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 187")
end


				create {IL_EXTENSION_AS} yyval2.initialize (yytype7 (yyvs.item (yyvsp - 4)), field_type, yytype3 (yyvs.item (yyvsp - 2)), yytype5 (yyvs.item (yyvsp)))
			
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_28 is
			--|#line 191 "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line 191 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 191")
end


				create {IL_EXTENSION_AS} yyval2.initialize (yytype7 (yyvs.item (yyvsp - 4)), static_field_type, yytype3 (yyvs.item (yyvsp - 2)), yytype5 (yyvs.item (yyvsp)))
			
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_29 is
			--|#line 195 "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line 195 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 195")
end


				create {IL_EXTENSION_AS} yyval2.initialize (yytype7 (yyvs.item (yyvsp - 4)), enum_field_type, yytype3 (yyvs.item (yyvsp - 2)), yytype5 (yyvs.item (yyvsp)))
			
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_30 is
			--|#line 199 "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line 199 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 199")
end


				create {IL_EXTENSION_AS} yyval2.initialize (yytype7 (yyvs.item (yyvsp - 4)), set_static_field_type, yytype3 (yyvs.item (yyvsp - 2)), yytype5 (yyvs.item (yyvsp)))
			
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_31 is
			--|#line 203 "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line 203 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 203")
end


				create {IL_EXTENSION_AS} yyval2.initialize (yytype7 (yyvs.item (yyvsp - 4)), set_field_type, yytype3 (yyvs.item (yyvsp - 2)), yytype5 (yyvs.item (yyvsp)))
			
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_32 is
			--|#line 207 "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line 207 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 207")
end


				create {IL_EXTENSION_AS} yyval2.initialize (yytype7 (yyvs.item (yyvsp - 4)), static_type, yytype3 (yyvs.item (yyvsp - 2)), yytype5 (yyvs.item (yyvsp)))
			
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_33 is
			--|#line 211 "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line 211 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 211")
end


				create {IL_EXTENSION_AS} yyval2.initialize (yytype7 (yyvs.item (yyvsp - 4)), get_property_type, yytype3 (yyvs.item (yyvsp - 2)), yytype5 (yyvs.item (yyvsp)))
			
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_34 is
			--|#line 215 "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line 215 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 215")
end


				create {IL_EXTENSION_AS} yyval2.initialize (yytype7 (yyvs.item (yyvsp - 4)), set_property_type, yytype3 (yyvs.item (yyvsp - 2)), yytype5 (yyvs.item (yyvsp)))
			
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_35 is
			--|#line 219 "external.y"
		local
			yyval2: EXTERNAL_EXTENSION_AS
		do
--|#line 219 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 219")
end


				create {IL_EXTENSION_AS} yyval2.initialize (yytype7 (yyvs.item (yyvsp - 4)), operator_type, yytype3 (yyvs.item (yyvsp - 2)), yytype5 (yyvs.item (yyvsp)))
			
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_36 is
			--|#line 225 "external.y"
		local
			yyval7: INTEGER
		do
--|#line 225 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 225")
end


				yyval7 := msil_language
			
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_37 is
			--|#line 230 "external.y"
		local
			yyval7: INTEGER
		do
--|#line 230 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 230")
end


				yyval7 := java_language
			
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_38 is
			--|#line 236 "external.y"
		local
			yyval3: SIGNATURE_AS
		do
--|#line 236 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 236")
end



			yyval := yyval3
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

	yy_do_action_39 is
			--|#line 237 "external.y"
		local
			yyval3: SIGNATURE_AS
		do
--|#line 237 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 237")
end


yyval3 := yytype3 (yyvs.item (yyvsp))
			yyval := yyval3
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_40 is
			--|#line 241 "external.y"
		local
			yyval3: SIGNATURE_AS
		do
--|#line 241 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 241")
end


				create yyval3.initialize (yytype9 (yyvs.item (yyvsp - 1)), yytype4 (yyvs.item (yyvsp)))
			
			yyval := yyval3
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_41 is
			--|#line 248 "external.y"
		local
			yyval9: EIFFEL_LIST [EXTERNAL_TYPE_AS]
		do
--|#line 248 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 248")
end



			yyval := yyval9
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

	yy_do_action_42 is
			--|#line 250 "external.y"
		local
			yyval9: EIFFEL_LIST [EXTERNAL_TYPE_AS]
		do
--|#line 250 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 250")
end


yyval9 := yytype9 (yyvs.item (yyvsp))
			yyval := yyval9
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_43 is
			--|#line 254 "external.y"
		local
			yyval9: EIFFEL_LIST [EXTERNAL_TYPE_AS]
		do
--|#line 254 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 254")
end


yyval9 := yytype9 (yyvs.item (yyvsp - 1))
			yyval := yyval9
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_44 is
			--|#line 259 "external.y"
		local
			yyval9: EIFFEL_LIST [EXTERNAL_TYPE_AS]
		do
--|#line 259 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 259")
end



			yyval := yyval9
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

	yy_do_action_45 is
			--|#line 261 "external.y"
		local
			yyval9: EIFFEL_LIST [EXTERNAL_TYPE_AS]
		do
--|#line 261 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 261")
end


yyval9 := yytype9 (yyvs.item (yyvsp))
			yyval := yyval9
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_46 is
			--|#line 265 "external.y"
		local
			yyval9: EIFFEL_LIST [EXTERNAL_TYPE_AS]
		do
--|#line 265 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 265")
end


			create {EIFFEL_LIST [EXTERNAL_TYPE_AS]} yyval9.make (Argument_list_initial_size)
			yyval9.extend (yytype4 (yyvs.item (yyvsp)))
		
			yyval := yyval9
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_47 is
			--|#line 270 "external.y"
		local
			yyval9: EIFFEL_LIST [EXTERNAL_TYPE_AS]
		do
--|#line 270 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 270")
end


			yyval9 := yytype9 (yyvs.item (yyvsp - 2))
			yyval9.extend (yytype4 (yyvs.item (yyvsp)))
		
			yyval := yyval9
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_48 is
			--|#line 277 "external.y"
		local
			yyval4: EXTERNAL_TYPE_AS
		do
--|#line 277 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 277")
end



			yyval := yyval4
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

	yy_do_action_49 is
			--|#line 279 "external.y"
		local
			yyval4: EXTERNAL_TYPE_AS
		do
--|#line 279 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 279")
end


yyval4 := yytype4 (yyvs.item (yyvsp))
			yyval := yyval4
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_50 is
			--|#line 283 "external.y"
		local
			yyval4: EXTERNAL_TYPE_AS
		do
--|#line 283 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 283")
end


					-- False because no `struct' keyword.
					-- Void because no `signed', `unsigned' keyword.
				yyval4 := new_external_type_as (yytype5 (yyvs.item (yyvsp - 2)), Void, False, yytype7 (yyvs.item (yyvsp - 1)), yytype6 (yyvs.item (yyvsp)))
			
			yyval := yyval4
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_51 is
			--|#line 290 "external.y"
		local
			yyval4: EXTERNAL_TYPE_AS
		do
--|#line 290 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 290")
end


					-- True because `struct' keyword.
					-- Void because no `signed', `unsigned' keyword.
				yyval4 := new_external_type_as (yytype5 (yyvs.item (yyvsp - 2)), Void, True, yytype7 (yyvs.item (yyvsp - 1)), yytype6 (yyvs.item (yyvsp)))
			
			yyval := yyval4
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_52 is
			--|#line 296 "external.y"
		local
			yyval4: EXTERNAL_TYPE_AS
		do
--|#line 296 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 296")
end


					-- False because no `struct' keyword.
				yyval4 := new_external_type_as (yytype5 (yyvs.item (yyvsp - 2)), signed_prefix, False, yytype7 (yyvs.item (yyvsp - 1)), yytype6 (yyvs.item (yyvsp)))
			
			yyval := yyval4
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_53 is
			--|#line 301 "external.y"
		local
			yyval4: EXTERNAL_TYPE_AS
		do
--|#line 301 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 301")
end


					-- False because no `struct' keyword.
				yyval4 := new_external_type_as (yytype5 (yyvs.item (yyvsp - 2)), unsigned_prefix, False, yytype7 (yyvs.item (yyvsp - 1)), yytype6 (yyvs.item (yyvsp)))
			
			yyval := yyval4
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_54 is
			--|#line 308 "external.y"
		local
			yyval4: EXTERNAL_TYPE_AS
		do
--|#line 308 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 308")
end



			yyval := yyval4
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

	yy_do_action_55 is
			--|#line 309 "external.y"
		local
			yyval4: EXTERNAL_TYPE_AS
		do
--|#line 309 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 309")
end


			yyval4 := yytype4 (yyvs.item (yyvsp))
		
			yyval := yyval4
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_56 is
			--|#line 315 "external.y"
		local
			yyval7: INTEGER
		do
--|#line 315 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 315")
end


yyval7 := 0
			yyval := yyval7
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

	yy_do_action_57 is
			--|#line 317 "external.y"
		local
			yyval7: INTEGER
		do
--|#line 317 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 317")
end


yyval7 := yytype7 (yyvs.item (yyvsp - 1)) + 1
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_58 is
			--|#line 321 "external.y"
		local
			yyval6: BOOLEAN
		do
--|#line 321 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 321")
end


yyval6 := False
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

	yy_do_action_59 is
			--|#line 323 "external.y"
		local
			yyval6: BOOLEAN
		do
--|#line 323 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 323")
end


yyval6 := True
			yyval := yyval6
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_60 is
			--|#line 327 "external.y"
		local
			yyval8: USE_LIST_AS
		do
--|#line 327 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 327")
end



			yyval := yyval8
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

	yy_do_action_61 is
			--|#line 329 "external.y"
		local
			yyval8: USE_LIST_AS
		do
--|#line 329 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 329")
end


yyval8 := yytype8 (yyvs.item (yyvsp))
			yyval := yyval8
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_62 is
			--|#line 333 "external.y"
		local
			yyval8: USE_LIST_AS
		do
--|#line 333 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 333")
end


yyval8 := yytype8 (yyvs.item (yyvsp))
			yyval := yyval8
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_63 is
			--|#line 338 "external.y"
		local
			yyval8: USE_LIST_AS
		do
--|#line 338 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 338")
end


			create {USE_LIST_AS} yyval8.make (Argument_list_initial_size)
			yyval8.extend (yytype5 (yyvs.item (yyvsp)))
		
			yyval := yyval8
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_64 is
			--|#line 343 "external.y"
		local
			yyval8: USE_LIST_AS
		do
--|#line 343 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 343")
end


			yyval8 := yytype8 (yyvs.item (yyvsp - 2))
			yyval8.extend (yytype5 (yyvs.item (yyvsp)))
		
			yyval := yyval8
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_65 is
			--|#line 350 "external.y"
		local
			yyval5: ID_AS
		do
--|#line 350 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 350")
end


			yyval5 := new_double_quote_id_as (token_buffer)
		
			yyval := yyval5
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_66 is
			--|#line 355 "external.y"
		local
			yyval5: ID_AS
		do
--|#line 355 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 355")
end


			yyval5 := new_double_quote_id_as (token_buffer)
		
			yyval := yyval5
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_67 is
			--|#line 360 "external.y"
		local
			yyval5: ID_AS
		do
--|#line 360 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 360")
end


			yyval5 := new_system_id_as (token_buffer)
		
			yyval := yyval5
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_68 is
			--|#line 364 "external.y"
		local
			yyval5: ID_AS
		do
--|#line 364 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 364")
end


			yyval5 := new_system_id_as (token_buffer)
		
			yyval := yyval5
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_69 is
			--|#line 368 "external.y"
		local
			yyval5: ID_AS
		do
--|#line 368 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 368")
end


			yyval5 := new_double_quote_id_as (token_buffer)
		
			yyval := yyval5
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_70 is
			--|#line 374 "external.y"
		local
			yyval5: ID_AS
		do
--|#line 374 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 374")
end


			yyval5 := new_double_quote_id_as (token_buffer)
		
			yyval := yyval5
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_71 is
			--|#line 379 "external.y"
		local
			yyval5: ID_AS
		do
--|#line 379 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 379")
end


			yyval5 := new_double_quote_id_as (token_buffer)
		
			yyval := yyval5
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_action_72 is
			--|#line 385 "external.y"
		local
			yyval5: ID_AS
		do
--|#line 385 "external.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'external.y' at line 385")
end


create yyval5.initialize (token_buffer) 
			yyval := yyval5
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
		end

	yy_do_error_action (yy_act: INTEGER) is
			-- Execute error action.
		do
			inspect yy_act
			when 168 then
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
			   35,   36,   37,   38,   39,   40,   41,   42>>)
		end

	yyr1_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    0,   43,   43,   43,   43,   43,   65,   65,   44,   44,
			   44,   44,   45,   45,   45,   45,   49,   49,   49,   49,
			   46,   47,   60,   60,   48,   48,   48,   48,   48,   48,
			   48,   48,   48,   48,   48,   48,   64,   64,   50,   50,
			   51,   66,   66,   67,   68,   68,   69,   69,   52,   52,
			   53,   53,   53,   53,   54,   54,   59,   59,   58,   58,
			   61,   61,   62,   63,   63,   56,   56,   56,   56,   56,
			   57,   57,   55>>)
		end

	yytypes1_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    2,    1,    1,    1,    1,    1,    2,    7,    6,    6,
			    6,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    3,    3,    1,    1,    2,    2,    1,
			    1,    1,    1,    1,    1,    1,    2,    2,    5,    1,
			    1,    1,    2,    3,    3,    3,    3,    3,    1,    9,
			    9,    3,    3,    3,    3,    3,    3,    3,    1,    1,
			    1,    5,    5,    1,    1,    1,    4,    5,    5,    5,
			    3,    5,    1,    8,    8,    3,    4,    3,    8,    8,
			    1,    1,    1,    1,    4,    9,    9,    1,    4,    1,
			    1,    1,    1,    1,    1,    1,    5,    1,    1,    7,

			    7,    5,    5,    5,    1,    7,    3,    3,    8,    3,
			    1,    1,    1,    5,    8,    8,    1,    8,    5,    5,
			    5,    5,    1,    1,    4,    5,    5,    5,    5,    5,
			    5,    5,    1,    3,    3,    7,    7,    7,    5,    1,
			    1,    6,    8,    8,    8,    1,    1,    1,    1,    1,
			    5,    4,    8,    8,    6,    6,    6,    1,    4,    1,
			    1,    1,    1,    5,    4,    4,    8,    8,    2,    1,
			    1>>)
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
			    1,    1,    1>>)
		end

	yydefact_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    6,   37,   36,    6,    6,    7,    5,   38,    0,    0,
			   38,   38,   38,   38,   38,   41,   38,   38,   38,   38,
			   38,   38,   38,    0,   39,    0,    0,    3,    4,   72,
			    0,    0,    0,   38,    0,   60,    2,   12,   38,    0,
			   38,   60,    1,   60,    0,    0,    0,    0,   44,   48,
			   42,    0,    0,    0,    0,    0,    0,    0,    0,   71,
			    0,   22,   22,    0,    0,    0,    0,   56,   38,   38,
			    0,   38,    0,   15,   61,    0,    0,    0,   11,    8,
			    0,    0,    0,    0,   46,    0,   45,    0,   40,    0,
			    0,    0,    0,    0,    0,    0,   24,    0,   23,   38,

			   38,   56,   56,   56,    0,   58,    0,    0,   14,    0,
			   69,    0,    0,   63,   62,   16,    0,   10,   30,   28,
			   26,   32,   43,    0,   49,   34,   31,   35,   25,   27,
			   33,   29,   70,   60,   60,   58,   58,   58,   54,   57,
			   59,   50,   17,   19,   18,    0,    0,    0,    0,    0,
			   54,   47,   21,   20,   53,   52,   51,    0,    0,   66,
			   65,   68,   67,   64,    0,   55,   13,    9,    0,    0,
			    0>>)
		end

	yydefgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			  168,   42,   36,   27,   28,    6,   37,   23,   24,   88,
			   66,  158,   67,  113,   61,  141,  105,   99,   73,   74,
			  114,    7,    8,   49,   50,   85,   86>>)
		end

	yypact_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			   41, -32768, -32768,   74,   74, -32768, -32768,  118,   18,    6,
			   -5,   39,   39,   39,   39,   92,   39,   39,   39,   39,
			   39,   39,   39,   88, -32768,   -6,   -6, -32768, -32768, -32768,
			   26,   17,   17,   39,   17,    5, -32768, -32768,   39,   26,
			   39,    5, -32768,    5,   87,   86,   71,   70,   26,   78,
			 -32768,   69,   67,   65,   64,   58,   57,   43,   17, -32768,
			   51,   52,   52,   17,   17,   17,   62, -32768,   39,   39,
			    5,   39,   -8, -32768, -32768,    5,   61,    5, -32768, -32768,
			   17,   17,   17,   17, -32768,   68,   66,   26, -32768,   17,
			   17,   17,   17,   17,   17,   17, -32768,   59, -32768,   39,

			   39, -32768, -32768, -32768,   17,    1,    5,    5, -32768,    5,
			 -32768,   -1,  -17, -32768,   63, -32768,   17, -32768, -32768, -32768,
			 -32768, -32768, -32768,   26, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768,    5,    5,    1,    1,    1,   -3, -32768,
			 -32768, -32768, -32768, -32768, -32768,   56,   40,   46,   42,   -8,
			   -3, -32768, -32768, -32768, -32768, -32768, -32768,   26,    5, -32768,
			 -32768, -32768, -32768, -32768,    5, -32768, -32768, -32768,   32,   13,
			 -32768>>)
		end

	yypgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768,  103, -32768, -32768,
			  -39,  -44,   -4,  -46,   76, -116,  -86,   37,  -40,  -63,
			 -32768, -32768,   47, -32768, -32768, -32768, -32768>>)
		end

	yytable_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			   76,   78,  112,   79,  111,   38,   60,  108,  140,   84,
			  139,   41,  115,  170,  117,  135,  136,  137,   40,  154,
			  155,  156,   35,   34,  148,  147,   15,   68,   69,   33,
			   71,   39,  169,  110,  157,   59,   26,   25,   32,   31,
			  146,  145,   30,  142,  143,   72,  144,   29,  124,    5,
			    9,   10,  160,  162,   96,    4,    3,  161,   29,  101,
			  102,  103,   65,    2,   64,   63,    1,   29,  159,  149,
			   15,  132,  123,  122,  116,  104,  118,  119,  120,  121,
			   98,   87,    5,   95,  151,  125,  126,  127,  128,  129,
			  130,  131,   97,  152,  153,  166,   48,   94,   93,  100,

			  138,  167,   62,  163,   92,   91,  164,   90,    0,   89,
			   83,   82,  150,   43,   44,   45,   46,   47,  165,   51,
			   52,   53,   54,   55,   56,   57,   81,   80,   58,    0,
			    0,    0,    0,    0,    0,    0,   70,    0,   22,   21,
			    0,   75,   20,   77,   19,   18,    0,   17,   16,   15,
			   14,   13,   12,   11,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,  106,  107,    0,  109,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,

			    0,    0,  133,  134>>)
		end

	yycheck_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			   39,   41,   10,   43,   12,    9,   12,   70,    7,   48,
			    9,   16,   75,    0,   77,  101,  102,  103,   23,  135,
			  136,  137,   16,   17,   41,   42,   31,   31,   32,   23,
			   34,   36,    0,   41,   37,   41,   18,   19,   32,   33,
			   41,   42,   36,  106,  107,   40,  109,   41,   87,    8,
			    3,    4,   12,   11,   58,   14,   15,   11,   41,   63,
			   64,   65,   36,   22,   38,   39,   25,   41,   12,    6,
			   31,   12,    6,    5,   13,   13,   80,   81,   82,   83,
			   28,    3,    8,   40,  123,   89,   90,   91,   92,   93,
			   94,   95,   41,  133,  134,  158,    4,   40,   40,   62,

			  104,  164,   26,  149,   40,   40,  150,   40,   -1,   40,
			   40,   40,  116,   10,   11,   12,   13,   14,  157,   16,
			   17,   18,   19,   20,   21,   22,   40,   40,   40,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   33,   -1,   20,   21,
			   -1,   38,   24,   40,   26,   27,   -1,   29,   30,   31,
			   32,   33,   34,   35,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   68,   69,   -1,   71,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,

			   -1,   -1,   99,  100>>)
		end

feature {NONE} -- Conversion

	yytype2 (v: ANY): EXTERNAL_EXTENSION_AS is
		require
			valid_type: yyis_type2 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type2 (v: ANY): BOOLEAN is
		local
			u: EXTERNAL_EXTENSION_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype3 (v: ANY): SIGNATURE_AS is
		require
			valid_type: yyis_type3 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type3 (v: ANY): BOOLEAN is
		local
			u: SIGNATURE_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype4 (v: ANY): EXTERNAL_TYPE_AS is
		require
			valid_type: yyis_type4 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type4 (v: ANY): BOOLEAN is
		local
			u: EXTERNAL_TYPE_AS
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

	yytype6 (v: ANY): BOOLEAN is
		require
			valid_type: yyis_type6 (v)
		local
			ref: BOOLEAN_REF
		do
			ref ?= v
			Result := ref.item
		end

	yyis_type6 (v: ANY): BOOLEAN is
		local
			u: BOOLEAN_REF
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

	yytype8 (v: ANY): USE_LIST_AS is
		require
			valid_type: yyis_type8 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type8 (v: ANY): BOOLEAN is
		local
			u: USE_LIST_AS
		do
			u ?= v
			Result := (u = v)
		end

	yytype9 (v: ANY): EIFFEL_LIST [EXTERNAL_TYPE_AS] is
		require
			valid_type: yyis_type9 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type9 (v: ANY): BOOLEAN is
		local
			u: EIFFEL_LIST [EXTERNAL_TYPE_AS]
		do
			u ?= v
			Result := (u = v)
		end


feature {NONE} -- Constants

	yyFinal: INTEGER is 170
			-- Termination state id

	yyFlag: INTEGER is -32768
			-- Most negative INTEGER

	yyNtbase: INTEGER is 43
			-- Number of tokens

	yyLast: INTEGER is 203
			-- Upper bound of `yytable' and `yycheck'

	yyMax_token: INTEGER is 297
			-- Maximum token id
			-- (upper bound of `yytranslate'.)

	yyNsyms: INTEGER is 70
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
