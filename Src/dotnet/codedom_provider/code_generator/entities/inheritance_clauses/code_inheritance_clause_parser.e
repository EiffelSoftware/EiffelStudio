indexing

	description: "Eiffel inheritance clause parser"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_INHERITANCE_CLAUSE_PARSER

inherit
	CODE_INHERITANCE_CLAUSE_PARSER_SKELETON

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
		local
			yyval3: LIST [CODE_SNIPPET_PARENT]
			yyval2: CODE_SNIPPET_PARENT
			yyval4: STRING
			yyval5: LIST [STRING]
			yyval7: LIST [CODE_SNIPPET_RENAME_CLAUSE]
			yyval6: CODE_SNIPPET_RENAME_CLAUSE
			yyval9: LIST [CODE_SNIPPET_EXPORT_CLAUSE]
			yyval11: LIST [CODE_SNIPPET_UNDEFINE_CLAUSE]
			yyval13: LIST [CODE_SNIPPET_REDEFINE_CLAUSE]
			yyval15: LIST [CODE_SNIPPET_SELECT_CLAUSE]
		do
			inspect yy_act
when 1 then
--|#line 48 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 48")
end

			yyval := yyval_default;
parents := yytype3 (yyvs.item (yyvsp)) 

if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
when 2 then
--|#line 51 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 51")
end

			yyval := yyval_default;
parents := create {ARRAYED_LIST [CODE_SNIPPET_PARENT]}.make (0) 

if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
when 3 then
--|#line 55 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 55")
end


				yyval3 := create {ARRAYED_LIST [CODE_SNIPPET_PARENT]}.make (Initial_parent_list_size)
				yyval3.extend (yytype2 (yyvs.item (yyvsp)))
			
			yyval := yyval3
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
when 4 then
--|#line 60 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 60")
end


				yyval3 := yytype3 (yyvs.item (yyvsp - 1))
				yyval3.extend (yytype2 (yyvs.item (yyvsp)))
			
			yyval := yyval3
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
when 5 then
--|#line 67 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 67")
end


yyval2 := yytype2 (yyvs.item (yyvsp)) 
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
when 6 then
--|#line 69 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 69")
end


yyval2 := yytype2 (yyvs.item (yyvsp - 1)) 
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
when 7 then
--|#line 73 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 73")
end


				yyval2 := create {CODE_SNIPPET_PARENT}.make (yytype4 (yyvs.item (yyvsp - 1)), yytype4 (yyvs.item (yyvsp)), Void, Void, Void, Void, Void)
			
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
when 8 then
--|#line 77 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 77")
end


				yyval2 := create {CODE_SNIPPET_PARENT}.make (yytype4 (yyvs.item (yyvsp - 7)), yytype4 (yyvs.item (yyvsp - 6)), yytype7 (yyvs.item (yyvsp - 5)), yytype9 (yyvs.item (yyvsp - 4)), yytype11 (yyvs.item (yyvsp - 3)), yytype13 (yyvs.item (yyvsp - 2)), yytype15 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 8
	yyvsp := yyvsp - 7
	yyvs.put (yyval, yyvsp)
end
when 9 then
--|#line 81 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 81")
end


				yyval2 := create {CODE_SNIPPET_PARENT}.make (yytype4 (yyvs.item (yyvsp - 6)), yytype4 (yyvs.item (yyvsp - 5)), Void, yytype9 (yyvs.item (yyvsp - 4)), yytype11 (yyvs.item (yyvsp - 3)), yytype13 (yyvs.item (yyvsp - 2)), yytype15 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 7
	yyvsp := yyvsp - 6
	yyvs.put (yyval, yyvsp)
end
when 10 then
--|#line 85 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 85")
end


				yyval2 := create {CODE_SNIPPET_PARENT}.make (yytype4 (yyvs.item (yyvsp - 5)), yytype4 (yyvs.item (yyvsp - 4)), Void, Void, yytype11 (yyvs.item (yyvsp - 3)), yytype13 (yyvs.item (yyvsp - 2)), yytype15 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp := yyvsp - 5
	yyvs.put (yyval, yyvsp)
end
when 11 then
--|#line 89 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 89")
end


				yyval2 := create {CODE_SNIPPET_PARENT}.make (yytype4 (yyvs.item (yyvsp - 4)), yytype4 (yyvs.item (yyvsp - 3)), Void, Void, Void, yytype13 (yyvs.item (yyvsp - 2)), yytype15 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp := yyvsp - 4
	yyvs.put (yyval, yyvsp)
end
when 12 then
--|#line 93 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 93")
end


				yyval2 := create {CODE_SNIPPET_PARENT}.make (yytype4 (yyvs.item (yyvsp - 3)), yytype4 (yyvs.item (yyvsp - 2)), Void, Void, Void, Void, yytype15 (yyvs.item (yyvsp - 1)))
			
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp := yyvsp - 3
	yyvs.put (yyval, yyvsp)
end
when 13 then
--|#line 97 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 97")
end


				yyval2 := create {CODE_SNIPPET_PARENT}.make (yytype4 (yyvs.item (yyvsp - 2)), yytype4 (yyvs.item (yyvsp - 1)), Void, Void, Void, Void, Void)
			
			yyval := yyval2
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
when 14 then
--|#line 103 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 103")
end


yyval4 := yytype4 (yyvs.item (yyvsp)) 
			yyval := yyval4
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
when 15 then
--|#line 105 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 105")
end


yyval4 := yytype4 (yyvs.item (yyvsp)) 
			yyval := yyval4
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
when 16 then
--|#line 109 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 109")
end


				yyval4 := create {STRING}.make (64)
				yyval4.append ("expanded ")
				yyval4.append (yytype4 (yyvs.item (yyvsp - 1)))
				if yytype4 (yyvs.item (yyvsp)) /= Void then
					yyval4.append (yytype4 (yyvs.item (yyvsp)))
				end
			
			yyval := yyval4
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
when 17 then
--|#line 118 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 118")
end


				yyval4 := create {STRING}.make (64)
				yyval4.append ("separate ")
				yyval4.append (yytype4 (yyvs.item (yyvsp - 1)))
				if yytype4 (yyvs.item (yyvsp)) /= Void then
					yyval4.append (yytype4 (yyvs.item (yyvsp)))
				end
			
			yyval := yyval4
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
when 18 then
--|#line 127 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 127")
end


				yyval4 := create {STRING}.make (yytype4 (yyvs.item (yyvsp)).count + 4)
				yyval4.append ("BIT ")
				yyval4.append (yytype4 (yyvs.item (yyvsp)))
			
			yyval := yyval4
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
when 19 then
--|#line 133 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 133")
end


				yyval4 := create {STRING}.make (yytype4 (yyvs.item (yyvsp)).count + 4)
				yyval4.append ("BIT ")
				yyval4.append (yytype4 (yyvs.item (yyvsp)))
			
			yyval := yyval4
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
when 20 then
--|#line 139 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 139")
end


				yyval4 := create {STRING}.make (yytype4 (yyvs.item (yyvsp)).count + 5)
				yyval4.append ("like ")
				yyval4.append (yytype4 (yyvs.item (yyvsp)))
			
			yyval := yyval4
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
when 21 then
--|#line 145 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 145")
end


yyval4 := "like Current" 
			yyval := yyval4
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
when 22 then
--|#line 149 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 149")
end


				yyval4 := yytype4 (yyvs.item (yyvsp - 1))
				if yytype4 (yyvs.item (yyvsp)) /= Void then
					yyval4.append (yytype4 (yyvs.item (yyvsp)))
				end
			
			yyval := yyval4
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
when 23 then
--|#line 158 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 158")
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
when 24 then
--|#line 160 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 160")
end



			yyval := yyval4
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
when 25 then
--|#line 162 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 162")
end


				yyval4 := create {STRING}.make (yytype4 (yyvs.item (yyvsp - 1)).count + 2)
				yyval4.append_character ('[')
				yyval4.append (yytype4 (yyvs.item (yyvsp - 1)))
				yyval4.append_character (']')
			
			yyval := yyval4
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
when 26 then
--|#line 171 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 171")
end


yyval4 := yytype4 (yyvs.item (yyvsp)) 
			yyval := yyval4
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
when 27 then
--|#line 173 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 173")
end


				yyval4 := yytype4 (yyvs.item (yyvsp - 2))
				yyval4.append (", ")
				yyval4.append (yytype4 (yyvs.item (yyvsp)))
			
			yyval := yyval4
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
when 28 then
--|#line 181 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 181")
end


				yyval5 := create {ARRAYED_LIST [STRING]}.make (1)
				yyval5.extend ("{NONE}")
			
			yyval := yyval5
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
when 29 then
--|#line 186 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 186")
end


yyval5 := yytype5 (yyvs.item (yyvsp - 1)) 
			yyval := yyval5
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
when 30 then
--|#line 190 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 190")
end


				yyval5 := create {ARRAYED_LIST [STRING]}.make (1)
				yyval5.extend (yytype4 (yyvs.item (yyvsp)))
			
			yyval := yyval5
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
when 31 then
--|#line 195 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 195")
end


				yyval5 := yytype5 (yyvs.item (yyvsp - 2))
				yyval5.extend (yytype4 (yyvs.item (yyvsp)))
			
			yyval := yyval5
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
when 32 then
--|#line 202 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 202")
end



			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
when 33 then
--|#line 204 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 204")
end


yyval7 := yytype7 (yyvs.item (yyvsp)) 
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
when 34 then
--|#line 208 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 208")
end


				yyval7 := create {ARRAYED_LIST [CODE_SNIPPET_RENAME_CLAUSE]}.make (Initial_clause_list_size)
				yyval7.extend (yytype6 (yyvs.item (yyvsp)))
			
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
when 35 then
--|#line 213 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 213")
end


				yyval7 := yytype7 (yyvs.item (yyvsp - 2))
				yyval7.extend (yytype6 (yyvs.item (yyvsp)))
			
			yyval := yyval7
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
when 36 then
--|#line 220 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 220")
end


				yyval6 := create {CODE_SNIPPET_RENAME_CLAUSE}.make (yytype4 (yyvs.item (yyvsp - 2)), yytype4 (yyvs.item (yyvsp)))
			
			yyval := yyval6
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
when 37 then
--|#line 226 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 226")
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
when 38 then
--|#line 228 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 228")
end


yyval9 := yytype9 (yyvs.item (yyvsp)) 
			yyval := yyval9
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
when 39 then
--|#line 232 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 232")
end


				if yytype9 (yyvs.item (yyvsp)) /= Void or else yytype9 (yyvs.item (yyvsp)).is_empty then
					yyval9 := Void
				else
					yyval9 := yytype9 (yyvs.item (yyvsp))
				end
			
			yyval := yyval9
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
when 40 then
--|#line 240 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 240")
end



			yyval := yyval9
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
when 41 then
--|#line 244 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 244")
end


				yyval9 := yytype9 (yyvs.item (yyvsp))
			
			yyval := yyval9
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
when 42 then
--|#line 248 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 248")
end


				yyval9 := yytype9 (yyvs.item (yyvsp - 1))
				if yytype9 (yyvs.item (yyvsp - 1)) /= Void and yytype9 (yyvs.item (yyvsp)) /= Void then
					yyval9.append (yytype9 (yyvs.item (yyvsp)))
				end
			
			yyval := yyval9
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
when 43 then
--|#line 257 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 257")
end


				if yytype5 (yyvs.item (yyvsp - 1)) /= Void then
					yyval9 := create {ARRAYED_LIST [CODE_SNIPPET_EXPORT_CLAUSE]}.make (yytype5 (yyvs.item (yyvsp - 2)).count)
					from
						yytype5 (yyvs.item (yyvsp - 2)).start
					until
						yytype5 (yyvs.item (yyvsp - 2)).after
					loop
						yyval9.extend (create {CODE_SNIPPET_EXPORT_CLAUSE}.make (yytype5 (yyvs.item (yyvsp - 2)).item, yytype5 (yyvs.item (yyvsp - 1))))
						yytype5 (yyvs.item (yyvsp - 2)).forth
					end
				end
			
			yyval := yyval9
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
when 44 then
--|#line 273 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 273")
end



			yyval := yyval5
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
when 45 then
--|#line 275 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 275")
end


				yyval5 := create {ARRAYED_LIST [STRING]}.make (1)
				yyval5.extend ("all")
			
			yyval := yyval5
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
when 46 then
--|#line 280 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 280")
end


yyval5 := yytype5 (yyvs.item (yyvsp)) 
			yyval := yyval5
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
when 47 then
--|#line 284 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 284")
end


				yyval5 := create {ARRAYED_LIST [STRING]}.make (Initial_feature_list_size)
				yyval5.extend (yytype4 (yyvs.item (yyvsp)))
			
			yyval := yyval5
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
when 48 then
--|#line 289 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 289")
end


				yyval5 := yytype5 (yyvs.item (yyvsp - 2))
				yyval5.extend (yytype4 (yyvs.item (yyvsp)))
			
			yyval := yyval5
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp := yyvsp - 2
	yyvs.put (yyval, yyvsp)
end
when 49 then
--|#line 296 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 296")
end



			yyval := yyval11
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
when 50 then
--|#line 298 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 298")
end


yyval11 := yytype11 (yyvs.item (yyvsp)) 
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
when 51 then
--|#line 302 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 302")
end



			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
when 52 then
--|#line 304 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 304")
end


				yyval11 := create {ARRAYED_LIST [CODE_SNIPPET_UNDEFINE_CLAUSE]}.make (yytype5 (yyvs.item (yyvsp)).count)
				from
					yytype5 (yyvs.item (yyvsp)).start
				until
					yytype5 (yyvs.item (yyvsp)).after
				loop
					yyval11.extend (create {CODE_SNIPPET_UNDEFINE_CLAUSE}.make (yytype5 (yyvs.item (yyvsp)).item))
					yytype5 (yyvs.item (yyvsp)).forth
				end
			
			yyval := yyval11
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
when 53 then
--|#line 318 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 318")
end



			yyval := yyval13
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
when 54 then
--|#line 320 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 320")
end


yyval13 := yytype13 (yyvs.item (yyvsp)) 
			yyval := yyval13
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
when 55 then
--|#line 324 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 324")
end



			yyval := yyval13
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
when 56 then
--|#line 326 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 326")
end


				yyval13 := create {ARRAYED_LIST [CODE_SNIPPET_REDEFINE_CLAUSE]}.make (yytype5 (yyvs.item (yyvsp)).count)
				from
					yytype5 (yyvs.item (yyvsp)).start
				until
					yytype5 (yyvs.item (yyvsp)).after
				loop
					yyval13.extend (create {CODE_SNIPPET_REDEFINE_CLAUSE}.make (yytype5 (yyvs.item (yyvsp)).item))
					yytype5 (yyvs.item (yyvsp)).forth
				end
			
			yyval := yyval13
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
when 57 then
--|#line 340 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 340")
end



			yyval := yyval15
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
when 58 then
--|#line 342 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 342")
end


yyval15 := yytype15 (yyvs.item (yyvsp)) 
			yyval := yyval15
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
when 59 then
--|#line 346 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 346")
end



			yyval := yyval15
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
when 60 then
--|#line 348 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 348")
end


				yyval15 := create {ARRAYED_LIST [CODE_SNIPPET_SELECT_CLAUSE]}.make (yytype5 (yyvs.item (yyvsp)).count)
				from
					yytype5 (yyvs.item (yyvsp)).start
				until
					yytype5 (yyvs.item (yyvsp)).after
				loop
					yyval15.extend (create {CODE_SNIPPET_SELECT_CLAUSE}.make (yytype5 (yyvs.item (yyvsp)).item))
					yytype5 (yyvs.item (yyvsp)).forth
				end
			
			yyval := yyval15
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
when 61 then
--|#line 362 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 362")
end


yyval4 := yytype4 (yyvs.item (yyvsp)) 
			yyval := yyval4
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
when 62 then
--|#line 364 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 364")
end


yyval4 := yytype4 (yyvs.item (yyvsp)) 
			yyval := yyval4
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
when 63 then
--|#line 366 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 366")
end


yyval4 := yytype4 (yyvs.item (yyvsp)) 
			yyval := yyval4
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
when 64 then
--|#line 370 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 370")
end


yyval4 := yytype4 (yyvs.item (yyvsp)) 
			yyval := yyval4
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
when 65 then
--|#line 375 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 375")
end


yyval4 := yytype4 (yyvs.item (yyvsp)) 
			yyval := yyval4
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
when 66 then
--|#line 379 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 379")
end


yyval4 := "prefix %"-%"" 
			yyval := yyval4
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
when 67 then
--|#line 381 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 381")
end


yyval4 := "prefix %"+%"" 
			yyval := yyval4
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
when 68 then
--|#line 383 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 383")
end


yyval4 := "prefix %"not%"" 
			yyval := yyval4
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
when 69 then
--|#line 385 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 385")
end


				yyval4 := create {STRING}.make (9 + token_buffer.count)
				yyval4.append ("prefix %"")
				yyval4.append (token_buffer.as_lower)
				yyval4.append_character ('"')
			
			yyval := yyval4
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
when 70 then
--|#line 394 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 394")
end


yyval4 := "infix %"<%"" 
			yyval := yyval4
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
when 71 then
--|#line 396 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 396")
end


yyval4 := "infix %"<=%"" 
			yyval := yyval4
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
when 72 then
--|#line 398 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 398")
end


yyval4 := "infix %">%"" 
			yyval := yyval4
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
when 73 then
--|#line 400 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 400")
end


yyval4 := "infix %">=%"" 
			yyval := yyval4
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
when 74 then
--|#line 402 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 402")
end


yyval4 := "infix %"-%"" 
			yyval := yyval4
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
when 75 then
--|#line 404 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 404")
end


yyval4 := "infix %"+%"" 
			yyval := yyval4
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
when 76 then
--|#line 406 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 406")
end


yyval4 := "infix %"*%"" 
			yyval := yyval4
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
when 77 then
--|#line 408 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 408")
end


yyval4 := "infix %"/%"" 
			yyval := yyval4
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
when 78 then
--|#line 410 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 410")
end


yyval4 := "infix %"\\%"" 
			yyval := yyval4
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
when 79 then
--|#line 412 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 412")
end


yyval4 := "infix %"//%"" 
			yyval := yyval4
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
when 80 then
--|#line 414 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 414")
end


yyval4 := "infix %"^%"" 
			yyval := yyval4
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
when 81 then
--|#line 416 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 416")
end


yyval4 := "infix %"and%"" 
			yyval := yyval4
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
when 82 then
--|#line 418 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 418")
end


yyval4 := "infix %"and then%"" 
			yyval := yyval4
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
when 83 then
--|#line 420 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 420")
end


yyval4 := "infix %"implies%"" 
			yyval := yyval4
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
when 84 then
--|#line 422 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 422")
end


yyval4 := "infix %"or%"" 
			yyval := yyval4
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
when 85 then
--|#line 424 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 424")
end


yyval4 := "infix %"or else%"" 
			yyval := yyval4
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
when 86 then
--|#line 426 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 426")
end


yyval4 := "infix %"xor%"" 
			yyval := yyval4
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
when 87 then
--|#line 428 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 428")
end


				yyval4 := create {STRING}.make (8 + token_buffer.count)
				yyval4.append ("infix %"")
				yyval4.append (token_buffer.as_lower)
				yyval4.append_character ('"')
			
			yyval := yyval4
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
when 88 then
--|#line 437 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 437")
end


				yyval4 := token_buffer.twin
			
			yyval := yyval4
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
when 89 then
--|#line 441 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 441")
end


				yyval4 := token_buffer.twin
			
			yyval := yyval4
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
when 90 then
--|#line 445 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 445")
end


				yyval4 := token_buffer.twin
			
			yyval := yyval4
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp := yyvsp - 1
	yyvs.put (yyval, yyvsp)
end
when 91 then
--|#line 451 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 451")
end


yyval4 := token_buffer.twin 
			yyval := yyval4
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
end
when 92 then
--|#line 455 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 455")
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
when 93 then
--|#line 456 "inheritance_clause.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'inheritance_clause.y' at line 456")
end

			yyval := yyval_default;


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs.put (yyval, yyvsp)
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
			when 128 then
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

			   45,   46,   47>>)
		end

	yyr1_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    0,   80,   80,   48,   48,   49,   49,   50,   50,   50,
			   50,   50,   50,   50,   61,   61,   60,   60,   60,   60,
			   60,   60,   59,   57,   57,   57,   58,   58,   63,   63,
			   66,   66,   67,   67,   68,   68,   69,   71,   71,   70,
			   70,   72,   72,   73,   64,   64,   64,   65,   65,   75,
			   75,   74,   74,   77,   77,   76,   76,   79,   79,   78,
			   78,   51,   51,   51,   52,   53,   55,   55,   55,   55,
			   54,   54,   54,   54,   54,   54,   54,   54,   54,   54,
			   54,   54,   54,   54,   54,   54,   54,   54,   56,   56,
			   56,   62,   81,   81>>)
		end

	yytypes1_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    1,    1,    1,    1,    3,    2,    2,    4,    1,    2,
			    1,    1,    4,    1,    1,    1,    1,    1,    4,    4,
			    4,    4,    4,    1,    1,    1,    1,    1,    1,    7,
			    9,   11,   13,   15,    1,    4,    1,    1,    1,    4,
			    4,    4,    4,    1,    1,    4,    1,    1,    4,    4,
			    4,    4,    5,    5,    4,    7,    6,    5,    1,    5,
			    9,    9,    1,    9,    9,   11,   11,   13,   13,   15,
			   15,    1,    1,    1,    4,    4,    4,    1,    1,    1,
			    1,    4,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,

			    4,    1,    1,    1,    1,    4,    5,    1,    5,    5,
			    9,   11,   13,   15,    1,    4,    4,    6,    1,    1,
			    1,   13,   15,    1,    4,   15,    1,    1,    1,    1,
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
			    1,    1,    1,    1,    1,    1,    1,    1>>)
		end

	yydefact_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    0,   92,   91,   93,    1,    3,    5,   23,    2,    4,
			    6,    0,    7,    0,    0,    0,   24,    0,    0,   14,
			   15,   26,   23,   51,   59,   32,   55,   92,   13,   37,
			   49,   53,   57,    0,   21,   20,    0,    0,   88,   18,
			   19,   23,   23,   25,    0,   22,    0,    0,   47,   62,
			   63,   61,   52,   60,    0,   33,   34,   56,    0,   44,
			   39,   41,   40,   38,   49,   50,   53,   54,   57,   58,
			    0,   12,   90,   89,   17,   16,   27,   69,   68,   67,
			   66,   65,   87,   86,   85,   84,   83,   82,   81,   80,
			   79,   78,   77,   76,   75,   74,   73,   72,   71,   70,

			   64,    0,    0,    0,   28,   30,    0,   45,   92,   46,
			   42,   53,   57,    0,   11,   48,   36,   35,   29,    0,
			   43,   57,    0,   10,   31,    0,    9,    8,    0,    0,
			    0>>)
		end

	yydefgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    4,    5,    6,   48,   49,   50,  100,   81,   39,   12,
			   18,   19,   20,   21,   51,   59,  108,   52,  106,   29,
			   55,   56,   30,   64,   60,   61,   65,   66,   67,   68,
			   69,   70,  128,    8>>)
		end

	yypact_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			   97,   40, -32768, -32768,   44, -32768,  102,   89, -32768, -32768,
			 -32768,   14,   82,    5,   -2,   44, -32768,   44,   85, -32768,
			 -32768, -32768,   89,   35,   35,   35,   35,   36, -32768,   99,
			   71,   69,   31,   98, -32768, -32768,   81,   78, -32768, -32768,
			 -32768,   89,   89, -32768,    9, -32768,   50,   30, -32768, -32768,
			 -32768, -32768,   80,   80,   94,   96, -32768,   80,   70,   16,
			   73, -32768, -32768, -32768,   71, -32768,   69, -32768,   31, -32768,
			   79, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,

			 -32768,   35,   35,   35, -32768, -32768,   34, -32768,   83,   80,
			 -32768,   69,   31,   45, -32768, -32768, -32768, -32768, -32768,   44,
			 -32768,   31,   41, -32768, -32768,   38, -32768, -32768,   21,   17,
			 -32768>>)
		end

	yypgoto_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			 -32768,  113, -32768,  -23, -32768, -32768, -32768, -32768, -32768,  -14,
			 -32768, -32768, -32768,   75,   -1, -32768, -32768,  -17, -32768, -32768,
			 -32768,   11,   87, -32768, -32768,   51,  103,   46,  101,  -60,
			  100,  -63, -32768,  -26>>)
		end

	yytable_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    7,   62,   54,    7,    2,  113,  112,   53,   45,   57,
			   22,    2,   35,   40,   41,    2,   42,  130,   17,  107,
			    2,  129,    2,   17,   38,   37,   36,   74,   75,   16,
			   34,   15,   14,   13,   47,   46,   15,   14,   13,  119,
			    3,    2,  109,   22,    3,  127,    2,   24,  126,  122,
			    2,  121,  123,   47,   46,  118,   58,  105,  125,   99,
			   98,   97,   96,   95,   94,   93,   92,   91,   90,   89,
			   88,   87,   86,   85,   84,   83,    2,   82,  115,  116,
			   54,   26,  120,   80,   79,  101,  114,    3,   23,   28,
			   44,  104,   27,   58,   26,   25,   78,   77,   24,   23,

			   43,  103,  102,   11,   73,   71,   10,   72,    1,   27,
			  111,  110,   33,   32,  117,   31,   63,    9,  124,   76>>)
		end

	yycheck_template: ANY is
			-- This is supposed to be "like FIXED_INTEGER_ARRAY_TYPE",
			-- but once functions cannot be declared with anchored types.
		once
			Result := yyfixed_array (<<
			    1,   27,   25,    4,    6,   68,   66,   24,   22,   26,
			   11,    6,   13,   14,   15,    6,   17,    0,    9,    3,
			    6,    0,    6,    9,   26,   27,   28,   41,   42,   15,
			   25,   22,   23,   24,   18,   19,   22,   23,   24,    5,
			    4,    6,   59,   44,    4,    7,    6,   16,    7,  112,
			    6,  111,    7,   18,   19,   21,   20,   58,  121,   29,
			   30,   31,   32,   33,   34,   35,   36,   37,   38,   39,
			   40,   41,   42,   43,   44,   45,    6,   47,  101,  102,
			  103,   12,  108,   33,   34,    5,    7,    4,   17,    7,
			    5,   21,   10,   20,   12,   13,   46,   47,   16,   17,

			   15,    5,    8,   14,   26,    7,    4,   26,   11,   10,
			   64,   60,   12,   12,  103,   12,   29,    4,  119,   44>>)
		end

feature {NONE} -- Conversion

	yytype2 (v: ANY): CODE_SNIPPET_PARENT is
		require
			valid_type: yyis_type2 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type2 (v: ANY): BOOLEAN is
		local
			u: CODE_SNIPPET_PARENT
		do
			u ?= v
			Result := (u = v)
		end

	yytype3 (v: ANY): LIST [CODE_SNIPPET_PARENT] is
		require
			valid_type: yyis_type3 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type3 (v: ANY): BOOLEAN is
		local
			u: LIST [CODE_SNIPPET_PARENT]
		do
			u ?= v
			Result := (u = v)
		end

	yytype4 (v: ANY): STRING is
		require
			valid_type: yyis_type4 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type4 (v: ANY): BOOLEAN is
		local
			u: STRING
		do
			u ?= v
			Result := (u = v)
		end

	yytype5 (v: ANY): LIST [STRING] is
		require
			valid_type: yyis_type5 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type5 (v: ANY): BOOLEAN is
		local
			u: LIST [STRING]
		do
			u ?= v
			Result := (u = v)
		end

	yytype6 (v: ANY): CODE_SNIPPET_RENAME_CLAUSE is
		require
			valid_type: yyis_type6 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type6 (v: ANY): BOOLEAN is
		local
			u: CODE_SNIPPET_RENAME_CLAUSE
		do
			u ?= v
			Result := (u = v)
		end

	yytype7 (v: ANY): LIST [CODE_SNIPPET_RENAME_CLAUSE] is
		require
			valid_type: yyis_type7 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type7 (v: ANY): BOOLEAN is
		local
			u: LIST [CODE_SNIPPET_RENAME_CLAUSE]
		do
			u ?= v
			Result := (u = v)
		end

	yytype9 (v: ANY): LIST [CODE_SNIPPET_EXPORT_CLAUSE] is
		require
			valid_type: yyis_type9 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type9 (v: ANY): BOOLEAN is
		local
			u: LIST [CODE_SNIPPET_EXPORT_CLAUSE]
		do
			u ?= v
			Result := (u = v)
		end

	yytype11 (v: ANY): LIST [CODE_SNIPPET_UNDEFINE_CLAUSE] is
		require
			valid_type: yyis_type11 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type11 (v: ANY): BOOLEAN is
		local
			u: LIST [CODE_SNIPPET_UNDEFINE_CLAUSE]
		do
			u ?= v
			Result := (u = v)
		end

	yytype13 (v: ANY): LIST [CODE_SNIPPET_REDEFINE_CLAUSE] is
		require
			valid_type: yyis_type13 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type13 (v: ANY): BOOLEAN is
		local
			u: LIST [CODE_SNIPPET_REDEFINE_CLAUSE]
		do
			u ?= v
			Result := (u = v)
		end

	yytype15 (v: ANY): LIST [CODE_SNIPPET_SELECT_CLAUSE] is
		require
			valid_type: yyis_type15 (v)
		do
			Result ?= v
		ensure
			definition: Result = v
		end

	yyis_type15 (v: ANY): BOOLEAN is
		local
			u: LIST [CODE_SNIPPET_SELECT_CLAUSE]
		do
			u ?= v
			Result := (u = v)
		end


feature {NONE} -- Constants

	yyFinal: INTEGER is 130
			-- Termination state id

	yyFlag: INTEGER is -32768
			-- Most negative INTEGER

	yyNtbase: INTEGER is 48
			-- Number of tokens

	yyLast: INTEGER is 119
			-- Upper bound of `yytable' and `yycheck'

	yyMax_token: INTEGER is 302
			-- Maximum token id
			-- (upper bound of `yytranslate'.)

	yyNsyms: INTEGER is 82
			-- Number of symbols
			-- (terminal and nonterminal)

feature -- User-defined features



end -- class CODE_INHERITANCE_CLAUSE_PARSER

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------