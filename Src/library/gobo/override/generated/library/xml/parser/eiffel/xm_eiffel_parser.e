note

	description: 

		"XML parsers using a native Eiffel parser"

	implements: "XML 1.0 (Second Edition) - W3C Recommendation 6 October 2000"

	library: "Gobo Eiffel XML Library"
	copyright: "Copyright (c) 2002-2012, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class XM_EIFFEL_PARSER

inherit

	XM_EIFFEL_PARSER_SKELETON
		redefine
			parse
		end

create

	make


feature {NONE} -- Implementation

	yy_build_parser_tables
			-- Build parser tables.
		do
			yytranslate := yytranslate_template
			yyr1 := yyr1_template
			yytypes1 := yytypes1_template
			yytypes2 := yytypes2_template
			yydefact := yydefact_template
			yydefgoto := yydefgoto_template
			yypact := yypact_template
			yypgoto := yypgoto_template
			yytable := yytable_template
			yycheck := yycheck_template
		end

	yy_create_value_stacks
			-- Create value stacks.
		do
		end

	yy_init_value_stacks
			-- Initialize value stacks.
		do
			yyvsp1 := -1
			yyvsp2 := -1
			yyvsp3 := -1
			yyvsp4 := -1
			yyvsp5 := -1
			yyvsp6 := -1
			yyvsp7 := -1
			yyvsp8 := -1
			yyvsp9 := -1
			yyvsp10 := -1
			yyvsp11 := -1
		end

	yy_clear_value_stacks
			-- Clear objects in semantic value stacks so that
			-- they can be collected by the garbage collector.
		local
			l_yyvs1_default_item: ANY
			l_yyvs2_default_item: XM_EIFFEL_PARSER_NAME
			l_yyvs3_default_item: DS_HASH_SET [XM_EIFFEL_PARSER_NAME]
			l_yyvs4_default_item: STRING
			l_yyvs5_default_item: XM_DTD_EXTERNAL_ID
			l_yyvs6_default_item: XM_DTD_ELEMENT_CONTENT
			l_yyvs7_default_item: XM_DTD_ATTRIBUTE_CONTENT
			l_yyvs8_default_item: DS_BILINKED_LIST [XM_DTD_ATTRIBUTE_CONTENT]
			l_yyvs9_default_item: DS_BILINKED_LIST [STRING]
			l_yyvs10_default_item: BOOLEAN
			l_yyvs11_default_item: XM_EIFFEL_DECLARATION
		do
			if yyvs1 /= Void then
				yyvs1.fill_with (l_yyvs1_default_item, 0, yyvs1.upper)
			end
			if yyvs2 /= Void then
				yyvs2.fill_with (l_yyvs2_default_item, 0, yyvs2.upper)
			end
			if yyvs3 /= Void then
				yyvs3.fill_with (l_yyvs3_default_item, 0, yyvs3.upper)
			end
			if yyvs4 /= Void then
				yyvs4.fill_with (l_yyvs4_default_item, 0, yyvs4.upper)
			end
			if yyvs5 /= Void then
				yyvs5.fill_with (l_yyvs5_default_item, 0, yyvs5.upper)
			end
			if yyvs6 /= Void then
				yyvs6.fill_with (l_yyvs6_default_item, 0, yyvs6.upper)
			end
			if yyvs7 /= Void then
				yyvs7.fill_with (l_yyvs7_default_item, 0, yyvs7.upper)
			end
			if yyvs8 /= Void then
				yyvs8.fill_with (l_yyvs8_default_item, 0, yyvs8.upper)
			end
			if yyvs9 /= Void then
				yyvs9.fill_with (l_yyvs9_default_item, 0, yyvs9.upper)
			end
			if yyvs10 /= Void then
				yyvs10.fill_with (l_yyvs10_default_item, 0, yyvs10.upper)
			end
			if yyvs11 /= Void then
				yyvs11.fill_with (l_yyvs11_default_item, 0, yyvs11.upper)
			end
		end

	yy_push_last_value (yychar1: INTEGER)
			-- Push semantic value associated with token `last_token'
			-- (with internal id `yychar1') on top of corresponding
			-- value stack.
		do
			inspect yytypes2.item (yychar1)
			when 1 then
				yyvsp1 := yyvsp1 + 1
				if yyvsp1 >= yyvsc1 then
					if yyvs1 = Void then
						debug ("GEYACC")
							std.error.put_line ("Create yyvs1")
						end
						create yyspecial_routines1
						yyvsc1 := yyInitial_yyvs_size
						yyvs1 := yyspecial_routines1.make (yyvsc1)
					else
						debug ("GEYACC")
							std.error.put_line ("Resize yyvs1")
						end
						yyvsc1 := yyvsc1 + yyInitial_yyvs_size
						yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
					end
				end
				yyspecial_routines1.force (yyvs1, last_any_value, yyvsp1)
			when 4 then
				yyvsp4 := yyvsp4 + 1
				if yyvsp4 >= yyvsc4 then
					if yyvs4 = Void then
						debug ("GEYACC")
							std.error.put_line ("Create yyvs4")
						end
						create yyspecial_routines4
						yyvsc4 := yyInitial_yyvs_size
						yyvs4 := yyspecial_routines4.make (yyvsc4)
					else
						debug ("GEYACC")
							std.error.put_line ("Resize yyvs4")
						end
						yyvsc4 := yyvsc4 + yyInitial_yyvs_size
						yyvs4 := yyspecial_routines4.resize (yyvs4, yyvsc4)
					end
				end
				yyspecial_routines4.force (yyvs4, last_string_value, yyvsp4)
			else
				debug ("GEYACC")
					std.error.put_string ("Error in parser: not a token type: ")
					std.error.put_integer (yytypes2.item (yychar1))
					std.error.put_new_line
				end
				abort
			end
		end

	yy_push_error_value
			-- Push semantic value associated with token 'error'
			-- on top of corresponding value stack.
		local
			yyval1: ANY
		do
			yyvsp1 := yyvsp1 + 1
			if yyvsp1 >= yyvsc1 then
				if yyvs1 = Void then
					debug ("GEYACC")
						std.error.put_line ("Create yyvs1")
					end
					create yyspecial_routines1
					yyvsc1 := yyInitial_yyvs_size
					yyvs1 := yyspecial_routines1.make (yyvsc1)
				else
					debug ("GEYACC")
						std.error.put_line ("Resize yyvs1")
					end
					yyvsc1 := yyvsc1 + yyInitial_yyvs_size
					yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
				end
			end
			yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
		end

	yy_pop_last_value (yystate: INTEGER)
			-- Pop semantic value from stack when in state `yystate'.
		local
			yy_type_id: INTEGER
		do
			yy_type_id := yytypes1.item (yystate)
			inspect yy_type_id
			when 1 then
				yyvsp1 := yyvsp1 - 1
			when 2 then
				yyvsp2 := yyvsp2 - 1
			when 3 then
				yyvsp3 := yyvsp3 - 1
			when 4 then
				yyvsp4 := yyvsp4 - 1
			when 5 then
				yyvsp5 := yyvsp5 - 1
			when 6 then
				yyvsp6 := yyvsp6 - 1
			when 7 then
				yyvsp7 := yyvsp7 - 1
			when 8 then
				yyvsp8 := yyvsp8 - 1
			when 9 then
				yyvsp9 := yyvsp9 - 1
			when 10 then
				yyvsp10 := yyvsp10 - 1
			when 11 then
				yyvsp11 := yyvsp11 - 1
			else
				debug ("GEYACC")
					std.error.put_string ("Error in parser: unknown type id: ")
					std.error.put_integer (yy_type_id)
					std.error.put_new_line
				end
				abort
			end
		end

feature {NONE} -- Semantic actions

	yy_do_action (yy_act: INTEGER)
			-- Execute semantic action.
		local
			yyval1: ANY
			yyval2: XM_EIFFEL_PARSER_NAME
			yyval4: STRING
			yyval11: XM_EIFFEL_DECLARATION
			yyval5: XM_DTD_EXTERNAL_ID
			yyval10: BOOLEAN
			yyval3: DS_HASH_SET [XM_EIFFEL_PARSER_NAME]
			yyval6: XM_DTD_ELEMENT_CONTENT
			yyval8: DS_BILINKED_LIST [XM_DTD_ATTRIBUTE_CONTENT]
			yyval7: XM_DTD_ATTRIBUTE_CONTENT
			yyval9: DS_BILINKED_LIST [STRING]
		do
			inspect yy_act
when 1 then
--|#line 124 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 124")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 2 then
--|#line 134 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 134")
end

			yyval2 := new_namespace_name
			namespace_force_last (yyval2, yyvs4.item (yyvsp4))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp2 := yyvsp2 + 1
	yyvsp4 := yyvsp4 -1
	if yyvsp2 >= yyvsc2 then
		if yyvs2 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs2")
			end
			create yyspecial_routines2
			yyvsc2 := yyInitial_yyvs_size
			yyvs2 := yyspecial_routines2.make (yyvsc2)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs2")
			end
			yyvsc2 := yyvsc2 + yyInitial_yyvs_size
			yyvs2 := yyspecial_routines2.resize (yyvs2, yyvsc2)
		end
	end
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 3 then
--|#line 139 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 139")
end

			yyval2 := new_namespace_name
			namespace_force_last (yyval2, shared_empty_string)
			namespace_force_last (yyval2, shared_empty_string)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp2 := yyvsp2 + 1
	yyvsp4 := yyvsp4 -1
	if yyvsp2 >= yyvsc2 then
		if yyvs2 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs2")
			end
			create yyspecial_routines2
			yyvsc2 := yyInitial_yyvs_size
			yyvs2 := yyspecial_routines2.make (yyvsc2)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs2")
			end
			yyvsc2 := yyvsc2 + yyInitial_yyvs_size
			yyvs2 := yyspecial_routines2.resize (yyvs2, yyvsc2)
		end
	end
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 4 then
--|#line 145 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 145")
end

			yyval2 := new_namespace_name
			namespace_force_last (yyval2, shared_empty_string)
			namespace_force_last (yyval2, yyvs4.item (yyvsp4))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp2 := yyvsp2 + 1
	yyvsp4 := yyvsp4 -2
	if yyvsp2 >= yyvsc2 then
		if yyvs2 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs2")
			end
			create yyspecial_routines2
			yyvsc2 := yyInitial_yyvs_size
			yyvs2 := yyspecial_routines2.make (yyvsc2)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs2")
			end
			yyvsc2 := yyvsc2 + yyInitial_yyvs_size
			yyvs2 := yyspecial_routines2.resize (yyvs2, yyvsc2)
		end
	end
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 5 then
--|#line 151 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 151")
end

			yyval2 := yyvs2.item (yyvsp2)
			namespace_force_last (yyval2, yyvs4.item (yyvsp4))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp4 := yyvsp4 -2
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 6 then
--|#line 156 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 156")
end

			yyval2 := yyvs2.item (yyvsp2)
			namespace_force_last (yyval2, shared_empty_string)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 7 then
--|#line 163 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 163")
end

yyval4 := yyvs4.item (yyvsp4) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 8 then
--|#line 164 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 164")
end

yyval4 := yyvs4.item (yyvsp4) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 9 then
--|#line 171 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 171")
end

yyval4 := onstring_ascii (yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 10 then
--|#line 172 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 172")
end

yyval4 := onstring_utf8 (yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 11 then
--|#line 175 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 175")
end

yyval4 := onstring_ascii (yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 12 then
--|#line 176 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 176")
end

yyval4 := onstring_utf8 (yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 13 then
--|#line 179 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 179")
end

yyval4 := onstring_ascii (yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 14 then
--|#line 180 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 180")
end

yyval4 := onstring_utf8 (yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 15 then
--|#line 183 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 183")
end

yyval4 := yyvs4.item (yyvsp4) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 16 then
--|#line 184 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 184")
end

yyval4 := onstring_ascii (yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 17 then
--|#line 185 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 185")
end

yyval4 := onstring_utf8 (yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 18 then
--|#line 188 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 188")
end

yyval4 := onstring_ascii (yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 19 then
--|#line 189 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 189")
end

yyval4 := onstring_utf8 (yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 20 then
--|#line 192 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 192")
end

yyval4 := onstring_ascii (yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 21 then
--|#line 193 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 193")
end

yyval4 := onstring_utf8 (yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 22 then
--|#line 196 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 196")
end

yyval4 := onstring_ascii (yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 23 then
--|#line 197 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 197")
end

yyval4 := onstring_utf8 (yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 24 then
--|#line 200 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 200")
end

yyval4 := onstring_ascii (yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 25 then
--|#line 201 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 201")
end

yyval4 := onstring_utf8 (yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 26 then
--|#line 204 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 204")
end

yyval4 := onstring_ascii (yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 27 then
--|#line 205 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 205")
end

yyval4 := onstring_utf8 (yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 28 then
--|#line 212 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 212")
end

yyval4 := yyvs4.item (yyvsp4) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 29 then
--|#line 213 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 213")
end

yyval4 := yyvs4.item (yyvsp4) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 30 then
--|#line 214 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 214")
end

yyval4 := yyvs4.item (yyvsp4) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 31 then
--|#line 215 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 215")
end

yyval4 := yyvs4.item (yyvsp4) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 32 then
--|#line 216 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 216")
end

yyval4 := yyvs4.item (yyvsp4) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 33 then
--|#line 217 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 217")
end

yyval4 := yyvs4.item (yyvsp4) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 34 then
--|#line 218 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 218")
end

yyval4 := yyvs4.item (yyvsp4) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 35 then
--|#line 219 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 219")
end

yyval4 := yyvs4.item (yyvsp4) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 36 then
--|#line 220 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 220")
end

yyval4 := yyvs4.item (yyvsp4) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 37 then
--|#line 221 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 221")
end

yyval4 := yyvs4.item (yyvsp4) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 38 then
--|#line 222 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 222")
end

yyval4 := yyvs4.item (yyvsp4) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 39 then
--|#line 223 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 223")
end

yyval4 := yyvs4.item (yyvsp4) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 40 then
--|#line 224 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 224")
end

yyval4 := yyvs4.item (yyvsp4) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 41 then
--|#line 225 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 225")
end

yyval4 := yyvs4.item (yyvsp4) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 42 then
--|#line 226 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 226")
end

yyval4 := yyvs4.item (yyvsp4) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 43 then
--|#line 229 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 229")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp1 := yyvsp1 + 1
	if yyvsp1 >= yyvsc1 then
		if yyvs1 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs1")
			end
			create yyspecial_routines1
			yyvsc1 := yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.make (yyvsc1)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs1")
			end
			yyvsc1 := yyvsc1 + yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
		end
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 44 then
--|#line 230 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 230")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 45 then
--|#line 233 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 233")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 46 then
--|#line 234 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 234")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 47 then
--|#line 237 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 237")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp1 := yyvsp1 + 1
	yyvsp4 := yyvsp4 -1
	if yyvsp1 >= yyvsc1 then
		if yyvs1 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs1")
			end
			create yyspecial_routines1
			yyvsc1 := yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.make (yyvsc1)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs1")
			end
			yyvsc1 := yyvsc1 + yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
		end
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 48 then
--|#line 238 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 238")
end

				-- Really applies only in DTD, but token cannot appear in content
				-- and test above would catch, if unintentionally.
			if not in_external_dtd then 
				force_error (Error_doctype_peref_only_in_dtd) 
			end 
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp1 := yyvsp1 + 1
	yyvsp4 := yyvsp4 -1
	if yyvsp1 >= yyvsc1 then
		if yyvs1 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs1")
			end
			create yyspecial_routines1
			yyvsc1 := yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.make (yyvsc1)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs1")
			end
			yyvsc1 := yyvsc1 + yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
		end
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 49 then
--|#line 250 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 250")
end

yyval4 := shared_empty_string 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 50 then
--|#line 252 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 252")
end

yyval4 := yyvs4.item (yyvsp4 - 1) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp4 := yyvsp4 -2
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 51 then
--|#line 254 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 254")
end

yyval4 := yyvs4.item (yyvsp4 - 1) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp4 := yyvsp4 -2
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 52 then
--|#line 258 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 258")
end

yyval4 := STRING_.concat (yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 53 then
--|#line 260 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 260")
end

yyval4 := STRING_.appended_string (yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 54 then
--|#line 264 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 264")
end

yyval4 := yyvs4.item (yyvsp4) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 55 then
--|#line 266 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 266")
end

yyval4 := yyvs4.item (yyvsp4) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 56 then
--|#line 270 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 270")
end

yyval4 := entity_referenced_in_entity_value (yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 57 then
--|#line 276 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 276")
end

yyval4 := shared_empty_string 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 58 then
--|#line 278 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 278")
end

yyval4 := yyvs4.item (yyvsp4 - 1) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp4 := yyvsp4 -2
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 59 then
--|#line 280 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 280")
end

yyval4 := yyvs4.item (yyvsp4 - 1) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp4 := yyvsp4 -2
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 60 then
--|#line 284 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 284")
end

yyval4 := STRING_.concat (yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 61 then
--|#line 286 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 286")
end

yyval4 := STRING_.appended_string (yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 62 then
--|#line 290 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 290")
end

yyval4 := yyvs4.item (yyvsp4) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 63 then
--|#line 291 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 291")
end

yyval4 := yyvs4.item (yyvsp4) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 64 then
--|#line 292 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 292")
end

force_error (Error_lt_not_allowed_attribute_value) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 65 then
--|#line 295 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 295")
end

yyval4 := shared_empty_string 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 66 then
--|#line 296 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 296")
end

yyval4 := shared_empty_string 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 67 then
--|#line 301 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 301")
end

on_comment (yyvs4.item (yyvsp4 - 1)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 + 1
	yyvsp4 := yyvsp4 -3
	if yyvsp1 >= yyvsc1 then
		if yyvs1 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs1")
			end
			create yyspecial_routines1
			yyvsc1 := yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.make (yyvsc1)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs1")
			end
			yyvsc1 := yyvsc1 + yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
		end
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 68 then
--|#line 303 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 303")
end

on_comment (shared_empty_string) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 + 1
	yyvsp4 := yyvsp4 -2
	if yyvsp1 >= yyvsc1 then
		if yyvs1 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs1")
			end
			create yyspecial_routines1
			yyvsc1 := yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.make (yyvsc1)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs1")
			end
			yyvsc1 := yyvsc1 + yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
		end
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 69 then
--|#line 307 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 307")
end

on_dtd_comment (yyvs4.item (yyvsp4 - 1)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 + 1
	yyvsp4 := yyvsp4 -3
	if yyvsp1 >= yyvsc1 then
		if yyvs1 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs1")
			end
			create yyspecial_routines1
			yyvsc1 := yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.make (yyvsc1)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs1")
			end
			yyvsc1 := yyvsc1 + yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
		end
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 70 then
--|#line 309 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 309")
end

on_dtd_comment (shared_empty_string) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 + 1
	yyvsp4 := yyvsp4 -2
	if yyvsp1 >= yyvsc1 then
		if yyvs1 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs1")
			end
			create yyspecial_routines1
			yyvsc1 := yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.make (yyvsc1)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs1")
			end
			yyvsc1 := yyvsc1 + yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
		end
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 71 then
--|#line 313 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 313")
end

yyval4 := yyvs4.item (yyvsp4) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 72 then
--|#line 315 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 315")
end

yyval4 := yyvs4.item (yyvsp4) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 73 then
--|#line 319 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 319")
end

yyval4 := STRING_.concat (yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 74 then
--|#line 321 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 321")
end

yyval4 := STRING_.appended_string (yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 75 then
--|#line 325 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 325")
end

yyval4 := yyvs4.item (yyvsp4) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 76 then
--|#line 326 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 326")
end

force_error (Error_no_dash_dash_in_comment) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 77 then
--|#line 331 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 331")
end

on_processing_instruction (yyvs4.item (yyvsp4 - 2), yyvs4.item (yyvsp4 - 1)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp4 := yyvsp4 -4
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 78 then
--|#line 333 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 333")
end

on_processing_instruction (yyvs4.item (yyvsp4 - 1), shared_empty_string) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp4 := yyvsp4 -3
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 79 then
--|#line 335 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 335")
end

force_error (Error_pi_xml_reserved) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp1 := yyvsp1 + 1
	yyvsp4 := yyvsp4 -1
	if yyvsp1 >= yyvsc1 then
		if yyvs1 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs1")
			end
			create yyspecial_routines1
			yyvsc1 := yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.make (yyvsc1)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs1")
			end
			yyvsc1 := yyvsc1 + yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
		end
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 80 then
--|#line 338 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 338")
end

on_dtd_processing_instruction (yyvs4.item (yyvsp4 - 2), yyvs4.item (yyvsp4 - 1)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp4 := yyvsp4 -4
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 81 then
--|#line 340 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 340")
end

on_dtd_processing_instruction (yyvs4.item (yyvsp4 - 1), shared_empty_string) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp4 := yyvsp4 -3
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 82 then
--|#line 342 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 342")
end

force_error (Error_pi_xml_reserved) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp1 := yyvsp1 + 1
	yyvsp4 := yyvsp4 -1
	if yyvsp1 >= yyvsc1 then
		if yyvs1 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs1")
			end
			create yyspecial_routines1
			yyvsc1 := yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.make (yyvsc1)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs1")
			end
			yyvsc1 := yyvsc1 + yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
		end
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 83 then
--|#line 345 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 345")
end

yyval4 := STRING_.concat (yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 84 then
--|#line 347 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 347")
end

yyval4 := STRING_.concat (yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 85 then
--|#line 349 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 349")
end

yyval4 := yyvs4.item (yyvsp4) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 86 then
--|#line 353 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 353")
end

yyval4 := STRING_.concat (yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 87 then
--|#line 355 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 355")
end

yyval4 := STRING_.appended_string (yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 88 then
--|#line 359 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 359")
end

yyval4 := yyvs4.item (yyvsp4) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 89 then
--|#line 360 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 360")
end

yyval4 := yyvs4.item (yyvsp4) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 90 then
--|#line 361 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 361")
end

yyval4 := yyvs4.item (yyvsp4) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 91 then
--|#line 364 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 364")
end

yyval4 := yyvs4.item (yyvsp4) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 92 then
--|#line 365 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 365")
end

yyval4 := yyvs4.item (yyvsp4) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 93 then
--|#line 370 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 370")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 + 1
	yyvsp4 := yyvsp4 -2
	if yyvsp1 >= yyvsc1 then
		if yyvs1 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs1")
			end
			create yyspecial_routines1
			yyvsc1 := yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.make (yyvsc1)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs1")
			end
			yyvsc1 := yyvsc1 + yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
		end
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 94 then
--|#line 371 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 371")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 + 1
	yyvsp4 := yyvsp4 -3
	if yyvsp1 >= yyvsc1 then
		if yyvs1 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs1")
			end
			create yyspecial_routines1
			yyvsc1 := yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.make (yyvsc1)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs1")
			end
			yyvsc1 := yyvsc1 + yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
		end
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 95 then
--|#line 374 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 374")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 96 then
--|#line 375 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 375")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 97 then
--|#line 378 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 378")
end

on_content (yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 98 then
--|#line 384 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 384")
end

			apply_encoding (yyvs11.item (yyvsp11).encoding)
			yyvs11.item (yyvsp11).process (Current) -- event
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp11 := yyvsp11 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 99 then
--|#line 391 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 391")
end

create yyval11.make 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp11 := yyvsp11 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp11 >= yyvsc11 then
		if yyvs11 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs11")
			end
			create yyspecial_routines11
			yyvsc11 := yyInitial_yyvs_size
			yyvs11 := yyspecial_routines11.make (yyvsc11)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs11")
			end
			yyvsc11 := yyvsc11 + yyInitial_yyvs_size
			yyvs11 := yyspecial_routines11.resize (yyvs11, yyvsc11)
		end
	end
	yyspecial_routines11.force (yyvs11, yyval11, yyvsp11)
end
when 100 then
--|#line 393 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 393")
end

yyval11 := yyvs11.item (yyvsp11) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines11.force (yyvs11, yyval11, yyvsp11)
end
when 101 then
--|#line 395 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 395")
end

yyval11 := yyvs11.item (yyvsp11) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyspecial_routines11.force (yyvs11, yyval11, yyvsp11)
end
when 102 then
--|#line 399 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 399")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp1 := yyvsp1 + 1
	if yyvsp1 >= yyvsc1 then
		if yyvs1 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs1")
			end
			create yyspecial_routines1
			yyvsc1 := yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.make (yyvsc1)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs1")
			end
			yyvsc1 := yyvsc1 + yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
		end
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 103 then
--|#line 400 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 400")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 104 then
--|#line 401 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 401")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 105 then
--|#line 404 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 404")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp1 := yyvsp1 + 1
	if yyvsp1 >= yyvsc1 then
		if yyvs1 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs1")
			end
			create yyspecial_routines1
			yyvsc1 := yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.make (yyvsc1)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs1")
			end
			yyvsc1 := yyvsc1 + yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
		end
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 106 then
--|#line 405 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 405")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 107 then
--|#line 408 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 408")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 108 then
--|#line 409 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 409")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 109 then
--|#line 412 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 412")
end

			yyvs11.item (yyvsp11).set_version (yyvs4.item (yyvsp4 - 1))
			yyval11 := yyvs11.item (yyvsp11)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp4 := yyvsp4 -3
	yyspecial_routines11.force (yyvs11, yyval11, yyvsp11)
end
when 110 then
--|#line 417 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 417")
end

force_error (Error_xml_declaration) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp11 := yyvsp11 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	if yyvsp11 >= yyvsc11 then
		if yyvs11 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs11")
			end
			create yyspecial_routines11
			yyvsc11 := yyInitial_yyvs_size
			yyvs11 := yyspecial_routines11.make (yyvsc11)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs11")
			end
			yyvsc11 := yyvsc11 + yyInitial_yyvs_size
			yyvs11 := yyspecial_routines11.resize (yyvs11, yyvsc11)
		end
	end
	yyspecial_routines11.force (yyvs11, yyval11, yyvsp11)
end
when 111 then
--|#line 420 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 420")
end

create yyval11.make 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp11 := yyvsp11 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp11 >= yyvsc11 then
		if yyvs11 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs11")
			end
			create yyspecial_routines11
			yyvsc11 := yyInitial_yyvs_size
			yyvs11 := yyspecial_routines11.make (yyvsc11)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs11")
			end
			yyvsc11 := yyvsc11 + yyInitial_yyvs_size
			yyvs11 := yyspecial_routines11.resize (yyvs11, yyvsc11)
		end
	end
	yyspecial_routines11.force (yyvs11, yyval11, yyvsp11)
end
when 112 then
--|#line 422 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 422")
end

			create yyval11.make 
			yyval11.set_stand_alone (yyvs10.item (yyvsp10))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp11 := yyvsp11 + 1
	yyvsp1 := yyvsp1 -2
	yyvsp10 := yyvsp10 -1
	if yyvsp11 >= yyvsc11 then
		if yyvs11 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs11")
			end
			create yyspecial_routines11
			yyvsc11 := yyInitial_yyvs_size
			yyvs11 := yyspecial_routines11.make (yyvsc11)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs11")
			end
			yyvsc11 := yyvsc11 + yyInitial_yyvs_size
			yyvs11 := yyspecial_routines11.resize (yyvs11, yyvsc11)
		end
	end
	yyspecial_routines11.force (yyvs11, yyval11, yyvsp11)
end
when 113 then
--|#line 427 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 427")
end

			create yyval11.make 
			yyval11.set_encoding (yyvs4.item (yyvsp4))
			apply_encoding (yyvs4.item (yyvsp4))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp11 := yyvsp11 + 1
	yyvsp1 := yyvsp1 -2
	yyvsp4 := yyvsp4 -1
	if yyvsp11 >= yyvsc11 then
		if yyvs11 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs11")
			end
			create yyspecial_routines11
			yyvsc11 := yyInitial_yyvs_size
			yyvs11 := yyspecial_routines11.make (yyvsc11)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs11")
			end
			yyvsc11 := yyvsc11 + yyInitial_yyvs_size
			yyvs11 := yyspecial_routines11.resize (yyvs11, yyvsc11)
		end
	end
	yyspecial_routines11.force (yyvs11, yyval11, yyvsp11)
end
when 114 then
--|#line 433 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 433")
end

			create yyval11.make;
			yyval11.set_encoding (yyvs4.item (yyvsp4))
			yyval11.set_stand_alone (yyvs10.item (yyvsp10)) 
			apply_encoding (yyvs4.item (yyvsp4))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp11 := yyvsp11 + 1
	yyvsp1 := yyvsp1 -3
	yyvsp4 := yyvsp4 -1
	yyvsp10 := yyvsp10 -1
	if yyvsp11 >= yyvsc11 then
		if yyvs11 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs11")
			end
			create yyspecial_routines11
			yyvsc11 := yyInitial_yyvs_size
			yyvs11 := yyspecial_routines11.make (yyvsc11)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs11")
			end
			yyvsc11 := yyvsc11 + yyInitial_yyvs_size
			yyvs11 := yyspecial_routines11.resize (yyvs11, yyvsc11)
		end
	end
	yyspecial_routines11.force (yyvs11, yyval11, yyvsp11)
end
when 115 then
--|#line 442 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 442")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 116 then
--|#line 443 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 443")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 117 then
--|#line 444 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 444")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 118 then
--|#line 445 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 445")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp4 := yyvsp4 -2
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 119 then
--|#line 448 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 448")
end

yyval4 := yyvs4.item (yyvsp4 - 1) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp4 := yyvsp4 -4
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 120 then
--|#line 450 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 450")
end

yyval4 := yyvs4.item (yyvsp4 - 1) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp4 := yyvsp4 -4
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 121 then
--|#line 454 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 454")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 122 then
--|#line 455 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 455")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 123 then
--|#line 456 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 456")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp1 := yyvsp1 + 1
	yyvsp4 := yyvsp4 -1
	if yyvsp1 >= yyvsc1 then
		if yyvs1 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs1")
			end
			create yyspecial_routines1
			yyvsc1 := yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.make (yyvsc1)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs1")
			end
			yyvsc1 := yyvsc1 + yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
		end
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 124 then
--|#line 459 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 459")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 125 then
--|#line 460 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 460")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 126 then
--|#line 463 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 463")
end

on_doctype (yyvs4.item (yyvsp4), Void, True) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 127 then
--|#line 467 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 467")
end

on_dtd_end 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp1 := yyvsp1 -2
	yyvsp4 := yyvsp4 -2
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 128 then
--|#line 471 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 471")
end

			on_doctype (yyvs4.item (yyvsp4), yyvs5.item (yyvsp5), False) 
			yyval5 := yyvs5.item (yyvsp5)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -2
	yyspecial_routines5.force (yyvs5, yyval5, yyvsp5)
end
when 129 then
--|#line 478 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 478")
end

			debug ("xml_parser")
				std.error.put_string ("[dtd: in]")
			end
			in_external_dtd := True
			when_external_dtd (yyvs5.item (yyvsp5)) 
			on_dtd_end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp1 := yyvsp1 -1
	yyvsp4 := yyvsp4 -2
	yyvsp5 := yyvsp5 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 130 then
--|#line 491 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 491")
end

			if not in_external_dtd then
				force_error (Error_misplaced_dtd_declaration)
			end
			debug ("xml_parser")
				std.error.put_string ("[dtd: out]")
			end
			in_external_dtd := False
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp1 := yyvsp1 -1
	yyvsp4 := yyvsp4 -2
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 131 then
--|#line 503 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 503")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp1 := yyvsp1 + 1
	if yyvsp1 >= yyvsc1 then
		if yyvs1 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs1")
			end
			create yyspecial_routines1
			yyvsc1 := yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.make (yyvsc1)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs1")
			end
			yyvsc1 := yyvsc1 + yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
		end
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 132 then
--|#line 504 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 504")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 133 then
--|#line 507 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 507")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 134 then
--|#line 508 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 508")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 135 then
--|#line 511 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 511")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 136 then
--|#line 512 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 512")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 137 then
--|#line 517 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 517")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp1 := yyvsp1 + 1
	if yyvsp1 >= yyvsc1 then
		if yyvs1 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs1")
			end
			create yyspecial_routines1
			yyvsc1 := yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.make (yyvsc1)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs1")
			end
			yyvsc1 := yyvsc1 + yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
		end
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 138 then
--|#line 518 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 518")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp4 := yyvsp4 -2
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 139 then
--|#line 519 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 519")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp1 := yyvsp1 -1
	yyvsp4 := yyvsp4 -2
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 140 then
--|#line 522 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 522")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 141 then
--|#line 523 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 523")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 142 then
--|#line 528 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 528")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 143 then
--|#line 529 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 529")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 144 then
--|#line 530 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 530")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 145 then
--|#line 531 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 531")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 146 then
--|#line 532 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 532")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 147 then
--|#line 533 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 533")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 148 then
--|#line 534 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 534")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp1 := yyvsp1 + 1
	yyvsp4 := yyvsp4 -1
	if yyvsp1 >= yyvsc1 then
		if yyvs1 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs1")
			end
			create yyspecial_routines1
			yyvsc1 := yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.make (yyvsc1)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs1")
			end
			yyvsc1 := yyvsc1 + yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
		end
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 149 then
--|#line 535 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 535")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp1 := yyvsp1 + 1
	yyvsp4 := yyvsp4 -1
	if yyvsp1 >= yyvsc1 then
		if yyvs1 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs1")
			end
			create yyspecial_routines1
			yyvsc1 := yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.make (yyvsc1)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs1")
			end
			yyvsc1 := yyvsc1 + yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
		end
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 150 then
--|#line 540 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 540")
end

yyval10 := True 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp10 := yyvsp10 + 1
	yyvsp4 := yyvsp4 -5
	if yyvsp10 >= yyvsc10 then
		if yyvs10 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs10")
			end
			create yyspecial_routines10
			yyvsc10 := yyInitial_yyvs_size
			yyvs10 := yyspecial_routines10.make (yyvsc10)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs10")
			end
			yyvsc10 := yyvsc10 + yyInitial_yyvs_size
			yyvs10 := yyspecial_routines10.resize (yyvs10, yyvsc10)
		end
	end
	yyspecial_routines10.force (yyvs10, yyval10, yyvsp10)
end
when 151 then
--|#line 541 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 541")
end

yyval10 := True 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp10 := yyvsp10 + 1
	yyvsp4 := yyvsp4 -5
	if yyvsp10 >= yyvsc10 then
		if yyvs10 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs10")
			end
			create yyspecial_routines10
			yyvsc10 := yyInitial_yyvs_size
			yyvs10 := yyspecial_routines10.make (yyvsc10)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs10")
			end
			yyvsc10 := yyvsc10 + yyInitial_yyvs_size
			yyvs10 := yyspecial_routines10.resize (yyvs10, yyvsc10)
		end
	end
	yyspecial_routines10.force (yyvs10, yyval10, yyvsp10)
end
when 152 then
--|#line 542 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 542")
end

yyval10 := False 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp10 := yyvsp10 + 1
	yyvsp4 := yyvsp4 -5
	if yyvsp10 >= yyvsc10 then
		if yyvs10 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs10")
			end
			create yyspecial_routines10
			yyvsc10 := yyInitial_yyvs_size
			yyvs10 := yyspecial_routines10.make (yyvsc10)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs10")
			end
			yyvsc10 := yyvsc10 + yyInitial_yyvs_size
			yyvs10 := yyspecial_routines10.resize (yyvs10, yyvsc10)
		end
	end
	yyspecial_routines10.force (yyvs10, yyval10, yyvsp10)
end
when 153 then
--|#line 543 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 543")
end

yyval10 := False 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp10 := yyvsp10 + 1
	yyvsp4 := yyvsp4 -5
	if yyvsp10 >= yyvsc10 then
		if yyvs10 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs10")
			end
			create yyspecial_routines10
			yyvsc10 := yyInitial_yyvs_size
			yyvs10 := yyspecial_routines10.make (yyvsc10)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs10")
			end
			yyvsc10 := yyvsc10 + yyInitial_yyvs_size
			yyvs10 := yyspecial_routines10.resize (yyvs10, yyvsc10)
		end
	end
	yyspecial_routines10.force (yyvs10, yyval10, yyvsp10)
end
when 154 then
--|#line 548 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 548")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 155 then
--|#line 549 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 549")
end

			if not yyvs2.item (yyvsp2 - 1).is_equal (yyvs2.item (yyvsp2)) then
				force_error (Error_end_tag_mismatch)
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 + 1
	yyvsp2 := yyvsp2 -2
	if yyvsp1 >= yyvsc1 then
		if yyvs1 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs1")
			end
			create yyspecial_routines1
			yyvsc1 := yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.make (yyvsc1)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs1")
			end
			yyvsc1 := yyvsc1 + yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
		end
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 156 then
--|#line 555 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 555")
end

			if not yyvs2.item (yyvsp2 - 1).is_equal (yyvs2.item (yyvsp2)) then
				force_error (Error_end_tag_mismatch)
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 -2
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 157 then
--|#line 561 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 561")
end

force_error (Error_element_end_tag) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp2 := yyvsp2 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 158 then
--|#line 562 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 562")
end

force_error (Error_element_content) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp2 := yyvsp2 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 159 then
--|#line 568 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 568")
end

			yyval2 := yyvs2.item (yyvsp2)
			on_start_tag_finish
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp4 := yyvsp4 -2
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 160 then
--|#line 573 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 573")
end

			yyval2 := yyvs2.item (yyvsp2)
			on_start_tag_finish
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp4 := yyvsp4 -2
	yyvsp1 := yyvsp1 -1
	yyvsp3 := yyvsp3 -1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 161 then
--|#line 578 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 578")
end

force_error (Error_start_tag) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp2 := yyvsp2 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	if yyvsp2 >= yyvsc2 then
		if yyvs2 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs2")
			end
			create yyspecial_routines2
			yyvsc2 := yyInitial_yyvs_size
			yyvs2 := yyspecial_routines2.make (yyvsc2)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs2")
			end
			yyvsc2 := yyvsc2 + yyInitial_yyvs_size
			yyvs2 := yyspecial_routines2.resize (yyvs2, yyvsc2)
		end
	end
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 162 then
--|#line 581 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 581")
end

			on_start_tag_finish -- makes empty attributes
			on_end_tag (Void, yyvs2.item (yyvsp2).ns_prefix, yyvs2.item (yyvsp2).local_part)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 + 1
	yyvsp4 := yyvsp4 -2
	yyvsp2 := yyvsp2 -1
	if yyvsp1 >= yyvsc1 then
		if yyvs1 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs1")
			end
			create yyspecial_routines1
			yyvsc1 := yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.make (yyvsc1)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs1")
			end
			yyvsc1 := yyvsc1 + yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
		end
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 163 then
--|#line 586 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 586")
end

			on_start_tag_finish
			on_end_tag (Void, yyvs2.item (yyvsp2).ns_prefix, yyvs2.item (yyvsp2).local_part)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp4 := yyvsp4 -2
	yyvsp2 := yyvsp2 -1
	yyvsp3 := yyvsp3 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 164 then
--|#line 593 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 593")
end

			yyval2 := yyvs2.item (yyvsp2)
			on_start_tag (Void, yyvs2.item (yyvsp2).ns_prefix, yyvs2.item (yyvsp2).local_part)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 165 then
--|#line 600 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 600")
end

			yyval3 := new_name_set
			yyval3.force_new (yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp3 := yyvsp3 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp3 >= yyvsc3 then
		if yyvs3 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs3")
			end
			create yyspecial_routines3
			yyvsc3 := yyInitial_yyvs_size
			yyvs3 := yyspecial_routines3.make (yyvsc3)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs3")
			end
			yyvsc3 := yyvsc3 + yyInitial_yyvs_size
			yyvs3 := yyspecial_routines3.resize (yyvs3, yyvsc3)
		end
	end
	yyspecial_routines3.force (yyvs3, yyval3, yyvsp3)
end
when 166 then
--|#line 605 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 605")
end

			yyval3 := yyvs3.item (yyvsp3)
			if (yyval3).has (yyvs2.item (yyvsp2)) then
				force_error (Error_attribute_duplicate)
			else
				yyval3.force_new (yyvs2.item (yyvsp2))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp2 := yyvsp2 -1
	yyspecial_routines3.force (yyvs3, yyval3, yyvsp3)
end
when 167 then
--|#line 616 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 616")
end

			yyval2 := yyvs2.item (yyvsp2)
			on_attribute (Void, yyvs2.item (yyvsp2).ns_prefix, yyvs2.item (yyvsp2).local_part, yyvs4.item (yyvsp4))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp4 := yyvsp4 -2
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 168 then
--|#line 621 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 621")
end

force_error (Error_attribute) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 169 then
--|#line 625 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 625")
end

			yyval2 := yyvs2.item (yyvsp2)
			on_end_tag (Void, yyvs2.item (yyvsp2).ns_prefix, yyvs2.item (yyvsp2).local_part)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp4 := yyvsp4 -2
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 170 then
--|#line 630 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 630")
end

force_error (Error_end_tag) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp2 := yyvsp2 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	if yyvsp2 >= yyvsc2 then
		if yyvs2 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs2")
			end
			create yyspecial_routines2
			yyvsc2 := yyInitial_yyvs_size
			yyvs2 := yyspecial_routines2.make (yyvsc2)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs2")
			end
			yyvsc2 := yyvsc2 + yyInitial_yyvs_size
			yyvs2 := yyspecial_routines2.resize (yyvs2, yyvsc2)
		end
	end
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
when 171 then
--|#line 633 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 633")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 172 then
--|#line 634 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 634")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 173 then
--|#line 637 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 637")
end

on_content (yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp1 := yyvsp1 + 1
	yyvsp4 := yyvsp4 -1
	if yyvsp1 >= yyvsc1 then
		if yyvs1 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs1")
			end
			create yyspecial_routines1
			yyvsc1 := yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.make (yyvsc1)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs1")
			end
			yyvsc1 := yyvsc1 + yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
		end
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 174 then
--|#line 638 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 638")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 175 then
--|#line 639 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 639")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 176 then
--|#line 640 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 640")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 177 then
--|#line 641 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 641")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 178 then
--|#line 642 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 642")
end

force_error (Error_no_cdata_end_in_content) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp1 := yyvsp1 + 1
	yyvsp4 := yyvsp4 -1
	if yyvsp1 >= yyvsc1 then
		if yyvs1 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs1")
			end
			create yyspecial_routines1
			yyvsc1 := yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.make (yyvsc1)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs1")
			end
			yyvsc1 := yyvsc1 + yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
		end
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 179 then
--|#line 643 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 643")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 180 then
--|#line 646 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 646")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp1 := yyvsp1 + 1
	yyvsp4 := yyvsp4 -1
	if yyvsp1 >= yyvsc1 then
		if yyvs1 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs1")
			end
			create yyspecial_routines1
			yyvsc1 := yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.make (yyvsc1)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs1")
			end
			yyvsc1 := yyvsc1 + yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
		end
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 181 then
--|#line 647 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 647")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp1 := yyvsp1 + 1
	yyvsp4 := yyvsp4 -1
	if yyvsp1 >= yyvsc1 then
		if yyvs1 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs1")
			end
			create yyspecial_routines1
			yyvsc1 := yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.make (yyvsc1)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs1")
			end
			yyvsc1 := yyvsc1 + yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
		end
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 182 then
--|#line 648 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 648")
end

force_error (Error_entity_xml_declaration) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp1 := yyvsp1 + 1
	yyvsp4 := yyvsp4 -1
	if yyvsp1 >= yyvsc1 then
		if yyvs1 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs1")
			end
			create yyspecial_routines1
			yyvsc1 := yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.make (yyvsc1)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs1")
			end
			yyvsc1 := yyvsc1 + yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
		end
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 183 then
--|#line 651 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 651")
end

yyval4 := yyvs4.item (yyvsp4) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 184 then
--|#line 653 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 653")
end

yyval4 := yyvs4.item (yyvsp4) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 185 then
--|#line 659 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 659")
end

on_element_declaration (yyvs4.item (yyvsp4 - 1),yyvs6.item (yyvsp6)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp1 := yyvsp1 -1
	yyvsp4 := yyvsp4 -3
	yyvsp6 := yyvsp6 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 186 then
--|#line 661 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 661")
end

force_error (Error_doctype_element) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 187 then
--|#line 664 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 664")
end

create yyval6.make_empty 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp6 := yyvsp6 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	if yyvsp6 >= yyvsc6 then
		if yyvs6 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs6")
			end
			create yyspecial_routines6
			yyvsc6 := yyInitial_yyvs_size
			yyvs6 := yyspecial_routines6.make (yyvsc6)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs6")
			end
			yyvsc6 := yyvsc6 + yyInitial_yyvs_size
			yyvs6 := yyspecial_routines6.resize (yyvs6, yyvsc6)
		end
	end
	yyspecial_routines6.force (yyvs6, yyval6, yyvsp6)
end
when 188 then
--|#line 666 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 666")
end

create yyval6.make_any 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp6 := yyvsp6 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	if yyvsp6 >= yyvsc6 then
		if yyvs6 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs6")
			end
			create yyspecial_routines6
			yyvsc6 := yyInitial_yyvs_size
			yyvs6 := yyspecial_routines6.make (yyvsc6)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs6")
			end
			yyvsc6 := yyvsc6 + yyInitial_yyvs_size
			yyvs6 := yyspecial_routines6.resize (yyvs6, yyvsc6)
		end
	end
	yyspecial_routines6.force (yyvs6, yyval6, yyvsp6)
end
when 189 then
--|#line 668 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 668")
end

yyval6 := yyvs6.item (yyvsp6) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyspecial_routines6.force (yyvs6, yyval6, yyvsp6)
end
when 190 then
--|#line 670 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 670")
end

yyval6 := yyvs6.item (yyvsp6) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines6.force (yyvs6, yyval6, yyvsp6)
end
when 191 then
--|#line 674 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 674")
end

yyval6 := yyvs6.item (yyvsp6) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyspecial_routines6.force (yyvs6, yyval6, yyvsp6)
end
when 192 then
--|#line 676 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 676")
end

yyval6 := yyvs6.item (yyvsp6); set_element_repetition (yyval6, yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyspecial_routines6.force (yyvs6, yyval6, yyvsp6)
end
when 193 then
--|#line 678 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 678")
end

yyval6 := yyvs6.item (yyvsp6) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyspecial_routines6.force (yyvs6, yyval6, yyvsp6)
end
when 194 then
--|#line 680 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 680")
end

yyval6 := yyvs6.item (yyvsp6); set_element_repetition (yyval6, yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyspecial_routines6.force (yyvs6, yyval6, yyvsp6)
end
when 195 then
--|#line 684 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 684")
end

yyval6 := element_name (yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp6 := yyvsp6 + 1
	yyvsp4 := yyvsp4 -1
	if yyvsp6 >= yyvsc6 then
		if yyvs6 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs6")
			end
			create yyspecial_routines6
			yyvsc6 := yyInitial_yyvs_size
			yyvs6 := yyspecial_routines6.make (yyvsc6)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs6")
			end
			yyvsc6 := yyvsc6 + yyInitial_yyvs_size
			yyvs6 := yyspecial_routines6.resize (yyvs6, yyvsc6)
		end
	end
	yyspecial_routines6.force (yyvs6, yyval6, yyvsp6)
end
when 196 then
--|#line 686 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 686")
end

yyval6 := element_name (yyvs4.item (yyvsp4 - 1)); set_element_repetition (yyval6, yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp6 := yyvsp6 + 1
	yyvsp4 := yyvsp4 -2
	if yyvsp6 >= yyvsc6 then
		if yyvs6 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs6")
			end
			create yyspecial_routines6
			yyvsc6 := yyInitial_yyvs_size
			yyvs6 := yyspecial_routines6.make (yyvsc6)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs6")
			end
			yyvsc6 := yyvsc6 + yyInitial_yyvs_size
			yyvs6 := yyspecial_routines6.resize (yyvs6, yyvsc6)
		end
	end
	yyspecial_routines6.force (yyvs6, yyval6, yyvsp6)
end
when 197 then
--|#line 688 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 688")
end

yyval6 := yyvs6.item (yyvsp6) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyspecial_routines6.force (yyvs6, yyval6, yyvsp6)
end
when 198 then
--|#line 690 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 690")
end

yyval6 := yyvs6.item (yyvsp6); set_element_repetition (yyval6, yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyspecial_routines6.force (yyvs6, yyval6, yyvsp6)
end
when 199 then
--|#line 692 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 692")
end

yyval6 := yyvs6.item (yyvsp6) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyspecial_routines6.force (yyvs6, yyval6, yyvsp6)
end
when 200 then
--|#line 694 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 694")
end

yyval6 := yyvs6.item (yyvsp6); set_element_repetition (yyval6, yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyspecial_routines6.force (yyvs6, yyval6, yyvsp6)
end
when 201 then
--|#line 698 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 698")
end

yyval4 := Zero_or_more_repetition 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 202 then
--|#line 700 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 700")
end

yyval4 := One_or_more_repetition 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 203 then
--|#line 702 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 702")
end

yyval4 := Zero_or_one_repetition 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 204 then
--|#line 706 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 706")
end

yyval6 := yyvs6.item (yyvsp6); yyval6.items.force_first (yyvs6.item (yyvsp6 - 1)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp6 := yyvsp6 -1
	yyvsp1 := yyvsp1 -3
	yyspecial_routines6.force (yyvs6, yyval6, yyvsp6)
end
when 205 then
--|#line 710 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 710")
end

create yyval6.make_choice; yyval6.items.force_last (yyvs6.item (yyvsp6)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines6.force (yyvs6, yyval6, yyvsp6)
end
when 206 then
--|#line 712 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 712")
end

yyval6 := yyvs6.item (yyvsp6 - 1); yyval6.items.force_last (yyvs6.item (yyvsp6)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp6 := yyvsp6 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines6.force (yyvs6, yyval6, yyvsp6)
end
when 207 then
--|#line 717 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 717")
end

yyval6 := yyvs6.item (yyvsp6) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyspecial_routines6.force (yyvs6, yyval6, yyvsp6)
end
when 208 then
--|#line 721 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 721")
end

create yyval6.make_sequence; yyval6.items.force_last (yyvs6.item (yyvsp6)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines6.force (yyvs6, yyval6, yyvsp6)
end
when 209 then
--|#line 723 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 723")
end

yyval6 := yyvs6.item (yyvsp6 - 1); yyval6.items.force_last (yyvs6.item (yyvsp6)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp6 := yyvsp6 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines6.force (yyvs6, yyval6, yyvsp6)
end
when 210 then
--|#line 727 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 727")
end

create yyval6.make_mixed 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp6 := yyvsp6 + 1
	yyvsp1 := yyvsp1 -3
	if yyvsp6 >= yyvsc6 then
		if yyvs6 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs6")
			end
			create yyspecial_routines6
			yyvsc6 := yyInitial_yyvs_size
			yyvs6 := yyspecial_routines6.make (yyvsc6)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs6")
			end
			yyvsc6 := yyvsc6 + yyInitial_yyvs_size
			yyvs6 := yyspecial_routines6.resize (yyvs6, yyvsc6)
		end
	end
	yyspecial_routines6.force (yyvs6, yyval6, yyvsp6)
end
when 211 then
--|#line 729 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 729")
end

create yyval6.make_mixed; yyval6.set_zero_or_more 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp6 := yyvsp6 + 1
	yyvsp1 := yyvsp1 -3
	yyvsp4 := yyvsp4 -1
	if yyvsp6 >= yyvsc6 then
		if yyvs6 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs6")
			end
			create yyspecial_routines6
			yyvsc6 := yyInitial_yyvs_size
			yyvs6 := yyspecial_routines6.make (yyvsc6)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs6")
			end
			yyvsc6 := yyvsc6 + yyInitial_yyvs_size
			yyvs6 := yyspecial_routines6.resize (yyvs6, yyvsc6)
		end
	end
	yyspecial_routines6.force (yyvs6, yyval6, yyvsp6)
end
when 212 then
--|#line 731 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 731")
end

yyval6 := yyvs6.item (yyvsp6); yyval6.set_zero_or_more 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp1 := yyvsp1 -4
	yyvsp4 := yyvsp4 -1
	yyspecial_routines6.force (yyvs6, yyval6, yyvsp6)
end
when 213 then
--|#line 735 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 735")
end

create yyval6.make_mixed; yyval6.items.force_last (element_name (yyvs4.item (yyvsp4))) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp6 := yyvsp6 + 1
	yyvsp4 := yyvsp4 -1
	if yyvsp6 >= yyvsc6 then
		if yyvs6 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs6")
			end
			create yyspecial_routines6
			yyvsc6 := yyInitial_yyvs_size
			yyvs6 := yyspecial_routines6.make (yyvsc6)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs6")
			end
			yyvsc6 := yyvsc6 + yyInitial_yyvs_size
			yyvs6 := yyspecial_routines6.resize (yyvs6, yyvsc6)
		end
	end
	yyspecial_routines6.force (yyvs6, yyval6, yyvsp6)
end
when 214 then
--|#line 737 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 737")
end

yyval6 := yyvs6.item (yyvsp6); yyval6.items.force_last (element_name (yyvs4.item (yyvsp4))) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp4 := yyvsp4 -1
	yyspecial_routines6.force (yyvs6, yyval6, yyvsp6)
end
when 215 then
--|#line 743 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 743")
end

yyval4 := yyvs4.item (yyvsp4) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 216 then
--|#line 747 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 747")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 217 then
--|#line 750 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 750")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 218 then
--|#line 753 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 753")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 219 then
--|#line 756 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 756")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp1 := yyvsp1 + 1
	yyvsp4 := yyvsp4 -1
	if yyvsp1 >= yyvsc1 then
		if yyvs1 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs1")
			end
			create yyspecial_routines1
			yyvsc1 := yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.make (yyvsc1)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs1")
			end
			yyvsc1 := yyvsc1 + yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
		end
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 220 then
--|#line 759 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 759")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 221 then
--|#line 764 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 764")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp1 := yyvsp1 -1
	yyvsp4 := yyvsp4 -3
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 222 then
--|#line 766 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 766")
end

on_attribute_declarations (yyvs4.item (yyvsp4 - 1), yyvs8.item (yyvsp8)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp1 := yyvsp1 -1
	yyvsp4 := yyvsp4 -3
	yyvsp8 := yyvsp8 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 223 then
--|#line 768 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 768")
end

force_error (Error_doctype_attribute) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 224 then
--|#line 772 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 772")
end

yyval8 := new_dtd_attribute_content_list; yyval8.force_last (yyvs7.item (yyvsp7)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp8 := yyvsp8 + 1
	yyvsp7 := yyvsp7 -1
	if yyvsp8 >= yyvsc8 then
		if yyvs8 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs8")
			end
			create yyspecial_routines8
			yyvsc8 := yyInitial_yyvs_size
			yyvs8 := yyspecial_routines8.make (yyvsc8)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs8")
			end
			yyvsc8 := yyvsc8 + yyInitial_yyvs_size
			yyvs8 := yyspecial_routines8.resize (yyvs8, yyvsc8)
		end
	end
	yyspecial_routines8.force (yyvs8, yyval8, yyvsp8)
end
when 225 then
--|#line 774 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 774")
end

yyval8 := yyvs8.item (yyvsp8); yyval8.force_last (yyvs7.item (yyvsp7)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp7 := yyvsp7 -1
	yyspecial_routines8.force (yyvs8, yyval8, yyvsp8)
end
when 226 then
--|#line 778 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 778")
end

yyval7 := yyvs7.item (yyvsp7 - 1); yyval7.set_name (yyvs4.item (yyvsp4)); yyval7.copy_default (yyvs7.item (yyvsp7)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp7 := yyvsp7 -1
	yyvsp1 := yyvsp1 -3
	yyvsp4 := yyvsp4 -1
	yyspecial_routines7.force (yyvs7, yyval7, yyvsp7)
end
when 227 then
--|#line 780 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 780")
end

force_error (Error_doctype_attribute_item) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp7 := yyvsp7 + 1
	yyvsp1 := yyvsp1 -2
	yyvsp4 := yyvsp4 -1
	if yyvsp7 >= yyvsc7 then
		if yyvs7 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs7")
			end
			create yyspecial_routines7
			yyvsc7 := yyInitial_yyvs_size
			yyvs7 := yyspecial_routines7.make (yyvsc7)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs7")
			end
			yyvsc7 := yyvsc7 + yyInitial_yyvs_size
			yyvs7 := yyspecial_routines7.resize (yyvs7, yyvsc7)
		end
	end
	yyspecial_routines7.force (yyvs7, yyval7, yyvsp7)
end
when 228 then
--|#line 783 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 783")
end

yyval7 := new_dtd_attribute_content; yyval7.set_data 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp7 := yyvsp7 + 1
	yyvsp4 := yyvsp4 -1
	if yyvsp7 >= yyvsc7 then
		if yyvs7 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs7")
			end
			create yyspecial_routines7
			yyvsc7 := yyInitial_yyvs_size
			yyvs7 := yyspecial_routines7.make (yyvsc7)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs7")
			end
			yyvsc7 := yyvsc7 + yyInitial_yyvs_size
			yyvs7 := yyspecial_routines7.resize (yyvs7, yyvsc7)
		end
	end
	yyspecial_routines7.force (yyvs7, yyval7, yyvsp7)
end
when 229 then
--|#line 785 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 785")
end

yyval7 := yyvs7.item (yyvsp7) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines7.force (yyvs7, yyval7, yyvsp7)
end
when 230 then
--|#line 787 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 787")
end

yyval7 := yyvs7.item (yyvsp7) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines7.force (yyvs7, yyval7, yyvsp7)
end
when 231 then
--|#line 791 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 791")
end

yyval7 := new_dtd_attribute_content; yyval7.set_id 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp7 := yyvsp7 + 1
	yyvsp4 := yyvsp4 -1
	if yyvsp7 >= yyvsc7 then
		if yyvs7 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs7")
			end
			create yyspecial_routines7
			yyvsc7 := yyInitial_yyvs_size
			yyvs7 := yyspecial_routines7.make (yyvsc7)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs7")
			end
			yyvsc7 := yyvsc7 + yyInitial_yyvs_size
			yyvs7 := yyspecial_routines7.resize (yyvs7, yyvsc7)
		end
	end
	yyspecial_routines7.force (yyvs7, yyval7, yyvsp7)
end
when 232 then
--|#line 793 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 793")
end

yyval7 := new_dtd_attribute_content; yyval7.set_id_ref 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp7 := yyvsp7 + 1
	yyvsp4 := yyvsp4 -1
	if yyvsp7 >= yyvsc7 then
		if yyvs7 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs7")
			end
			create yyspecial_routines7
			yyvsc7 := yyInitial_yyvs_size
			yyvs7 := yyspecial_routines7.make (yyvsc7)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs7")
			end
			yyvsc7 := yyvsc7 + yyInitial_yyvs_size
			yyvs7 := yyspecial_routines7.resize (yyvs7, yyvsc7)
		end
	end
	yyspecial_routines7.force (yyvs7, yyval7, yyvsp7)
end
when 233 then
--|#line 795 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 795")
end

yyval7 := new_dtd_attribute_content; yyval7.set_id_ref; yyval7.set_list_type 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp7 := yyvsp7 + 1
	yyvsp4 := yyvsp4 -1
	if yyvsp7 >= yyvsc7 then
		if yyvs7 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs7")
			end
			create yyspecial_routines7
			yyvsc7 := yyInitial_yyvs_size
			yyvs7 := yyspecial_routines7.make (yyvsc7)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs7")
			end
			yyvsc7 := yyvsc7 + yyInitial_yyvs_size
			yyvs7 := yyspecial_routines7.resize (yyvs7, yyvsc7)
		end
	end
	yyspecial_routines7.force (yyvs7, yyval7, yyvsp7)
end
when 234 then
--|#line 797 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 797")
end

yyval7 := new_dtd_attribute_content; yyval7.set_entity 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp7 := yyvsp7 + 1
	yyvsp4 := yyvsp4 -1
	if yyvsp7 >= yyvsc7 then
		if yyvs7 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs7")
			end
			create yyspecial_routines7
			yyvsc7 := yyInitial_yyvs_size
			yyvs7 := yyspecial_routines7.make (yyvsc7)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs7")
			end
			yyvsc7 := yyvsc7 + yyInitial_yyvs_size
			yyvs7 := yyspecial_routines7.resize (yyvs7, yyvsc7)
		end
	end
	yyspecial_routines7.force (yyvs7, yyval7, yyvsp7)
end
when 235 then
--|#line 799 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 799")
end

yyval7 := new_dtd_attribute_content; yyval7.set_entity; yyval7.set_list_type 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp7 := yyvsp7 + 1
	yyvsp4 := yyvsp4 -1
	if yyvsp7 >= yyvsc7 then
		if yyvs7 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs7")
			end
			create yyspecial_routines7
			yyvsc7 := yyInitial_yyvs_size
			yyvs7 := yyspecial_routines7.make (yyvsc7)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs7")
			end
			yyvsc7 := yyvsc7 + yyInitial_yyvs_size
			yyvs7 := yyspecial_routines7.resize (yyvs7, yyvsc7)
		end
	end
	yyspecial_routines7.force (yyvs7, yyval7, yyvsp7)
end
when 236 then
--|#line 801 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 801")
end

yyval7 := new_dtd_attribute_content; yyval7.set_token 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp7 := yyvsp7 + 1
	yyvsp4 := yyvsp4 -1
	if yyvsp7 >= yyvsc7 then
		if yyvs7 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs7")
			end
			create yyspecial_routines7
			yyvsc7 := yyInitial_yyvs_size
			yyvs7 := yyspecial_routines7.make (yyvsc7)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs7")
			end
			yyvsc7 := yyvsc7 + yyInitial_yyvs_size
			yyvs7 := yyspecial_routines7.resize (yyvs7, yyvsc7)
		end
	end
	yyspecial_routines7.force (yyvs7, yyval7, yyvsp7)
end
when 237 then
--|#line 803 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 803")
end

yyval7 := new_dtd_attribute_content; yyval7.set_token; yyval7.set_list_type 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp7 := yyvsp7 + 1
	yyvsp4 := yyvsp4 -1
	if yyvsp7 >= yyvsc7 then
		if yyvs7 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs7")
			end
			create yyspecial_routines7
			yyvsc7 := yyInitial_yyvs_size
			yyvs7 := yyspecial_routines7.make (yyvsc7)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs7")
			end
			yyvsc7 := yyvsc7 + yyInitial_yyvs_size
			yyvs7 := yyspecial_routines7.resize (yyvs7, yyvsc7)
		end
	end
	yyspecial_routines7.force (yyvs7, yyval7, yyvsp7)
end
when 238 then
--|#line 807 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 807")
end

yyval7 := new_dtd_attribute_content; yyval7.set_notation 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp7 := yyvsp7 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp7 >= yyvsc7 then
		if yyvs7 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs7")
			end
			create yyspecial_routines7
			yyvsc7 := yyInitial_yyvs_size
			yyvs7 := yyspecial_routines7.make (yyvsc7)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs7")
			end
			yyvsc7 := yyvsc7 + yyInitial_yyvs_size
			yyvs7 := yyspecial_routines7.resize (yyvs7, yyvsc7)
		end
	end
	yyspecial_routines7.force (yyvs7, yyval7, yyvsp7)
end
when 239 then
--|#line 809 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 809")
end

yyval7 := new_dtd_attribute_content; yyval7.set_enumeration_list (yyvs9.item (yyvsp9)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp7 := yyvsp7 + 1
	yyvsp9 := yyvsp9 -1
	if yyvsp7 >= yyvsc7 then
		if yyvs7 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs7")
			end
			create yyspecial_routines7
			yyvsc7 := yyInitial_yyvs_size
			yyvs7 := yyspecial_routines7.make (yyvsc7)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs7")
			end
			yyvsc7 := yyvsc7 + yyInitial_yyvs_size
			yyvs7 := yyspecial_routines7.resize (yyvs7, yyvsc7)
		end
	end
	yyspecial_routines7.force (yyvs7, yyval7, yyvsp7)
end
when 240 then
--|#line 813 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 813")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp1 := yyvsp1 -2
	yyvsp4 := yyvsp4 -2
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 241 then
--|#line 816 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 816")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp1 := yyvsp1 + 1
	yyvsp4 := yyvsp4 -1
	if yyvsp1 >= yyvsc1 then
		if yyvs1 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs1")
			end
			create yyspecial_routines1
			yyvsc1 := yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.make (yyvsc1)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs1")
			end
			yyvsc1 := yyvsc1 + yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
		end
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 242 then
--|#line 817 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 817")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp4 := yyvsp4 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 243 then
--|#line 820 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 820")
end

yyval9 := yyvs9.item (yyvsp9) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyspecial_routines9.force (yyvs9, yyval9, yyvsp9)
end
when 244 then
--|#line 824 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 824")
end

yyval9 := new_string_bilinked_list; yyval9.force_last (yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp9 := yyvsp9 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	if yyvsp9 >= yyvsc9 then
		if yyvs9 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs9")
			end
			create yyspecial_routines9
			yyvsc9 := yyInitial_yyvs_size
			yyvs9 := yyspecial_routines9.make (yyvsc9)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs9")
			end
			yyvsc9 := yyvsc9 + yyInitial_yyvs_size
			yyvs9 := yyspecial_routines9.resize (yyvs9, yyvsc9)
		end
	end
	yyspecial_routines9.force (yyvs9, yyval9, yyvsp9)
end
when 245 then
--|#line 826 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 826")
end

yyval9 := yyvs9.item (yyvsp9); yyval9.force_last (yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp1 := yyvsp1 -2
	yyvsp4 := yyvsp4 -1
	yyspecial_routines9.force (yyvs9, yyval9, yyvsp9)
end
when 246 then
--|#line 830 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 830")
end

yyval7 := new_dtd_attribute_content; yyval7.set_value_required 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp7 := yyvsp7 + 1
	yyvsp4 := yyvsp4 -1
	if yyvsp7 >= yyvsc7 then
		if yyvs7 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs7")
			end
			create yyspecial_routines7
			yyvsc7 := yyInitial_yyvs_size
			yyvs7 := yyspecial_routines7.make (yyvsc7)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs7")
			end
			yyvsc7 := yyvsc7 + yyInitial_yyvs_size
			yyvs7 := yyspecial_routines7.resize (yyvs7, yyvsc7)
		end
	end
	yyspecial_routines7.force (yyvs7, yyval7, yyvsp7)
end
when 247 then
--|#line 832 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 832")
end

yyval7 := new_dtd_attribute_content; yyval7.set_value_implied 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp7 := yyvsp7 + 1
	yyvsp4 := yyvsp4 -1
	if yyvsp7 >= yyvsc7 then
		if yyvs7 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs7")
			end
			create yyspecial_routines7
			yyvsc7 := yyInitial_yyvs_size
			yyvs7 := yyspecial_routines7.make (yyvsc7)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs7")
			end
			yyvsc7 := yyvsc7 + yyInitial_yyvs_size
			yyvs7 := yyspecial_routines7.resize (yyvs7, yyvsc7)
		end
	end
	yyspecial_routines7.force (yyvs7, yyval7, yyvsp7)
end
when 248 then
--|#line 834 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 834")
end

yyval7 := new_dtd_attribute_content; yyval7.set_value_fixed (yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp7 := yyvsp7 + 1
	yyvsp4 := yyvsp4 -2
	yyvsp1 := yyvsp1 -1
	if yyvsp7 >= yyvsc7 then
		if yyvs7 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs7")
			end
			create yyspecial_routines7
			yyvsc7 := yyInitial_yyvs_size
			yyvs7 := yyspecial_routines7.make (yyvsc7)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs7")
			end
			yyvsc7 := yyvsc7 + yyInitial_yyvs_size
			yyvs7 := yyspecial_routines7.resize (yyvs7, yyvsc7)
		end
	end
	yyspecial_routines7.force (yyvs7, yyval7, yyvsp7)
end
when 249 then
--|#line 836 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 836")
end

yyval7 := new_dtd_attribute_content; yyval7.set_default_value (yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp7 := yyvsp7 + 1
	yyvsp4 := yyvsp4 -1
	if yyvsp7 >= yyvsc7 then
		if yyvs7 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs7")
			end
			create yyspecial_routines7
			yyvsc7 := yyInitial_yyvs_size
			yyvs7 := yyspecial_routines7.make (yyvsc7)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs7")
			end
			yyvsc7 := yyvsc7 + yyInitial_yyvs_size
			yyvs7 := yyspecial_routines7.resize (yyvs7, yyvsc7)
		end
	end
	yyspecial_routines7.force (yyvs7, yyval7, yyvsp7)
end
when 250 then
--|#line 842 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 842")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 251 then
--|#line 843 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 843")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 252 then
--|#line 844 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 844")
end

force_error (Error_doctype_conditional_section) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 253 then
--|#line 847 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 847")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 254 then
--|#line 848 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 848")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp4 := yyvsp4 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 255 then
--|#line 851 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 851")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp1 := yyvsp1 -1
	yyvsp4 := yyvsp4 -3
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 256 then
--|#line 854 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 854")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp4 := yyvsp4 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 257 then
--|#line 857 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 857")
end

scanner.push_start_condition_dtd_ignore 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp1 := yyvsp1 -1
	yyvsp4 := yyvsp4 -3
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 258 then
--|#line 861 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 861")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp1 := yyvsp1 + 1
	if yyvsp1 >= yyvsc1 then
		if yyvs1 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs1")
			end
			create yyspecial_routines1
			yyvsc1 := yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.make (yyvsc1)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs1")
			end
			yyvsc1 := yyvsc1 + yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
		end
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 259 then
--|#line 862 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 862")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 260 then
--|#line 865 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 865")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 261 then
--|#line 866 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 866")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 262 then
--|#line 869 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 869")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp1 := yyvsp1 + 1
	yyvsp4 := yyvsp4 -1
	if yyvsp1 >= yyvsc1 then
		if yyvs1 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs1")
			end
			create yyspecial_routines1
			yyvsc1 := yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.make (yyvsc1)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs1")
			end
			yyvsc1 := yyvsc1 + yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
		end
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 263 then
--|#line 870 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 870")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp4 := yyvsp4 -2
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 264 then
--|#line 879 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 879")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 265 then
--|#line 880 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 880")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 266 then
--|#line 881 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 881")
end

force_error (Error_doctype_entity) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 267 then
--|#line 884 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 884")
end

				-- Internal entity.
			when_entity_declared (yyvs4.item (yyvsp4 - 2), new_literal_entity (yyvs4.item (yyvsp4 - 2), yyvs4.item (yyvsp4 - 1)))
			on_entity_declaration (yyvs4.item (yyvsp4 - 2), False, yyvs4.item (yyvsp4 - 1), Void, Void)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp1 := yyvsp1 -2
	yyvsp4 := yyvsp4 -4
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 268 then
--|#line 890 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 890")
end

				-- External entity.
			when_entity_declared (yyvs4.item (yyvsp4 - 1), new_external_entity (yyvs5.item (yyvsp5)))
			on_entity_declaration (yyvs4.item (yyvsp4 - 1), False, Void, yyvs5.item (yyvsp5), Void)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp1 := yyvsp1 -2
	yyvsp4 := yyvsp4 -3
	yyvsp5 := yyvsp5 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 269 then
--|#line 896 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 896")
end

				-- Unparsed NDATA entity.
			on_entity_declaration (yyvs4.item (yyvsp4 - 2), False, Void, yyvs5.item (yyvsp5), yyvs4.item (yyvsp4 - 1))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 8
	yyvsp1 := yyvsp1 -2
	yyvsp4 := yyvsp4 -4
	yyvsp5 := yyvsp5 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 270 then
--|#line 903 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 903")
end

				-- Internal PE entity.
			when_pe_entity_declared (yyvs4.item (yyvsp4 - 2), new_literal_entity (yyvs4.item (yyvsp4 - 2), yyvs4.item (yyvsp4 - 1)))
			on_entity_declaration (yyvs4.item (yyvsp4 - 2), True, yyvs4.item (yyvsp4 - 1), Void, Void) 
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 9
	yyvsp1 := yyvsp1 -3
	yyvsp4 := yyvsp4 -5
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 271 then
--|#line 909 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 909")
end

				-- External PE entity.
			when_pe_entity_declared (yyvs4.item (yyvsp4 - 1), new_external_entity (yyvs5.item (yyvsp5))) 
			on_entity_declaration (yyvs4.item (yyvsp4 - 1), True, Void, yyvs5.item (yyvsp5), Void)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 9
	yyvsp1 := yyvsp1 -3
	yyvsp4 := yyvsp4 -4
	yyvsp5 := yyvsp5 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 272 then
--|#line 917 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 917")
end

yyval5 := new_dtd_external_id; yyval5.set_system (yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp5 := yyvsp5 + 1
	yyvsp4 := yyvsp4 -1
	if yyvsp5 >= yyvsc5 then
		if yyvs5 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs5")
			end
			create yyspecial_routines5
			yyvsc5 := yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.make (yyvsc5)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs5")
			end
			yyvsc5 := yyvsc5 + yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.resize (yyvs5, yyvsc5)
		end
	end
	yyspecial_routines5.force (yyvs5, yyval5, yyvsp5)
end
when 273 then
--|#line 919 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 919")
end

yyval5 := new_dtd_external_id; yyval5.set_public (yyvs4.item (yyvsp4 - 1)); yyval5.set_system (yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp5 := yyvsp5 + 1
	yyvsp4 := yyvsp4 -2
	if yyvsp5 >= yyvsc5 then
		if yyvs5 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs5")
			end
			create yyspecial_routines5
			yyvsc5 := yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.make (yyvsc5)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs5")
			end
			yyvsc5 := yyvsc5 + yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.resize (yyvs5, yyvsc5)
		end
	end
	yyspecial_routines5.force (yyvs5, yyval5, yyvsp5)
end
when 274 then
--|#line 923 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 923")
end

yyval4 := yyvs4.item (yyvsp4) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -2
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 275 then
--|#line 929 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 929")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp1 := yyvsp1 + 1
	if yyvsp1 >= yyvsc1 then
		if yyvs1 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs1")
			end
			create yyspecial_routines1
			yyvsc1 := yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.make (yyvsc1)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs1")
			end
			yyvsc1 := yyvsc1 + yyInitial_yyvs_size
			yyvs1 := yyspecial_routines1.resize (yyvs1, yyvsc1)
		end
	end
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 276 then
--|#line 930 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 930")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp4 := yyvsp4 -3
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 277 then
--|#line 931 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 931")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp1 := yyvsp1 -1
	yyvsp4 := yyvsp4 -4
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 278 then
--|#line 932 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 932")
end

force_error (Error_xml_declaration) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 279 then
--|#line 935 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 935")
end

yyval4 := yyvs4.item (yyvsp4 - 1) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp4 := yyvsp4 -4
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 280 then
--|#line 937 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 937")
end

yyval4 := yyvs4.item (yyvsp4 - 1) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp4 := yyvsp4 -4
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
when 281 then
--|#line 943 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 943")
end

on_notation_declaration (yyvs4.item (yyvsp4 - 1), yyvs5.item (yyvsp5)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp1 := yyvsp1 -2
	yyvsp4 := yyvsp4 -3
	yyvsp5 := yyvsp5 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 282 then
--|#line 945 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 945")
end

on_notation_declaration (yyvs4.item (yyvsp4 - 1), yyvs5.item (yyvsp5)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp1 := yyvsp1 -2
	yyvsp4 := yyvsp4 -3
	yyvsp5 := yyvsp5 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 283 then
--|#line 947 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 947")
end

force_error (Error_doctype_notation) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
when 284 then
--|#line 951 "xm_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'xm_eiffel_parser.y' at line 951")
end

yyval5 := new_dtd_external_id; yyval5.set_system (yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp5 := yyvsp5 + 1
	yyvsp4 := yyvsp4 -1
	if yyvsp5 >= yyvsc5 then
		if yyvs5 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs5")
			end
			create yyspecial_routines5
			yyvsc5 := yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.make (yyvsc5)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs5")
			end
			yyvsc5 := yyvsc5 + yyInitial_yyvs_size
			yyvs5 := yyspecial_routines5.resize (yyvs5, yyvsc5)
		end
	end
	yyspecial_routines5.force (yyvs5, yyval5, yyvsp5)
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

	yy_do_error_action (yy_act: INTEGER)
			-- Execute error action.
		do
			inspect yy_act
			when 465 then
					-- End-of-file expected action.
				report_eof_expected_error
			else
					-- Default action.
				report_error ("parse error")
			end
		end

feature {NONE} -- Table templates

	yytranslate_template: SPECIAL [INTEGER]
			-- Template for `yytranslate'
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
			   85,   86,   87,   88,   89,   90,   91,   92,   93,   94, yyDummy>>)
		end

	yyr1_template: SPECIAL [INTEGER]
			-- Template for `yyr1'
		once
			Result := yyfixed_array (<<
			    0,  160,   95,   95,   95,   95,   95,  101,  101,  105,
			  105,  106,  106,  107,  107,  102,  102,  102,  108,  108,
			  109,  109,  110,  110,  111,  111,  104,  104,  103,  103,
			  103,  103,  103,  103,  103,  103,  103,  103,  103,  103,
			  103,  103,  103,  164,  164,  165,  165,  166,  166,  112,
			  112,  112,  113,  113,  114,  114,  119,  115,  115,  115,
			  116,  116,  117,  117,  117,  118,  118,  167,  167,  168,
			  168,  120,  120,  121,  121,  122,  122,  169,  169,  169,
			  170,  170,  170,  123,  123,  123,  125,  125,  126,  126,
			  126,  124,  124,  171,  171,  127,  127,  128,  161,  159,

			  159,  159,  172,  172,  172,  163,  163,  173,  173,  157,
			  157,  158,  158,  158,  158,  155,  155,  155,  155,  153,
			  153,  175,  175,  175,  174,  174,  179,  176,  132,  177,
			  178,  182,  182,  183,  183,  184,  184,  180,  180,  180,
			  187,  187,  185,  185,  185,  185,  185,  185,  185,  185,
			  156,  156,  156,  156,  162,  162,  162,  162,  162,   97,
			   97,   97,  192,  192,   96,  100,  100,   99,   99,   98,
			   98,  193,  193,  194,  194,  194,  194,  194,  194,  194,
			  195,  195,  195,  129,  129,  188,  188,  135,  135,  135,
			  135,  136,  136,  136,  136,  137,  137,  137,  137,  137,

			  137,  144,  144,  144,  138,  139,  139,  140,  141,  141,
			  142,  142,  142,  143,  143,  134,  196,  197,  199,  198,
			  200,  189,  189,  189,  145,  145,  146,  146,  147,  147,
			  147,  148,  148,  148,  148,  148,  148,  148,  149,  149,
			  201,  202,  202,  151,  152,  152,  150,  150,  150,  150,
			  186,  186,  186,  203,  203,  205,  204,  206,  207,  207,
			  208,  208,  209,  209,  190,  190,  190,  210,  210,  210,
			  211,  211,  130,  130,  133,  181,  181,  181,  181,  154,
			  154,  191,  191,  191,  131, yyDummy>>)
		end

	yytypes1_template: SPECIAL [INTEGER]
			-- Template for `yytypes1'
		once
			Result := yyfixed_array (<<
			    1,    4,    4,    4,    4,    4,   11,   11,    1,    1,
			    1,    1,    1,    1,    4,    1,    4,    4,    4,    4,
			    4,    4,    4,    4,    4,    4,    4,    4,    1,    4,
			    1,    1,    1,    1,    4,    2,    1,    1,    1,    4,
			    4,    4,    4,    4,    4,    4,   11,    1,    1,    1,
			    1,    1,    4,    4,    4,    1,    1,    4,    1,    4,
			    4,    4,    1,    2,    2,    4,    4,    4,    4,    4,
			    4,    4,    4,    1,    2,    4,    4,    1,    1,    1,
			    1,    1,    1,    1,    1,    4,    4,    4,    4,    4,
			    4,    4,    4,   10,    1,    4,    4,    4,    4,    4,

			    4,    4,    4,    4,    4,    4,    4,    4,    4,    4,
			    4,    4,    4,    4,    4,    4,    4,    4,    5,    1,
			    4,    1,    4,    4,    4,    4,    4,    4,    4,    4,
			    1,    1,    2,    4,    4,    4,    4,    1,    2,    1,
			    4,    4,    4,    4,    4,    1,    1,    1,    1,    4,
			    4,    4,    4,    4,    4,    1,    1,    4,    1,    1,
			    1,    4,    4,    4,    4,    4,    4,    4,    4,    4,
			    4,    4,    4,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    4,    2,    2,    3,    4,    4,    4,    4,    4,    4,

			    4,    4,    4,   10,    4,    4,    4,    4,    4,    4,
			    5,    4,    1,    1,    4,    4,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    4,    4,
			    4,    4,    1,    4,    1,    4,    4,    1,    1,    1,
			    4,    1,    4,    4,    1,    4,    4,    4,    4,    4,
			    4,    1,    4,    1,    1,    4,    1,    4,    4,    4,
			    4,    4,    4,    4,    4,    4,    1,    1,    4,    4,
			    1,    4,    1,    4,    4,    2,    4,    4,    4,    4,
			    4,    4,    1,    1,    1,    1,    1,    1,    1,    8,
			    7,    1,    1,    1,    4,    4,    4,    4,    4,    4,

			    4,    4,    4,    4,    4,    4,    4,    4,    4,    5,
			    5,    4,    4,    4,    5,    7,    1,    4,    4,    4,
			    4,    4,    6,    6,    6,    6,    6,    1,    4,    4,
			    4,    4,    4,    1,    1,    1,    4,    4,    4,    4,
			    4,    4,    4,    4,    1,    4,    1,    1,    4,    1,
			    1,    1,    1,    1,    4,    4,    4,    4,    4,    1,
			    4,    1,    1,    4,    4,    4,    6,    6,    6,    6,
			    1,    1,    4,    4,    4,    5,    4,    4,    4,    4,
			    4,    1,    4,    4,    4,    4,    4,    4,    4,    4,
			    4,    4,    4,    7,    7,    7,    9,    1,    1,    1,

			    1,    1,    1,    4,    1,    4,    1,    4,    1,    4,
			    1,    4,    4,    1,    1,    1,    1,    1,    1,    4,
			    1,    1,    1,    4,    4,    4,    4,    9,    1,    6,
			    6,    1,    6,    4,    4,    6,    4,    4,    4,    4,
			    1,    4,    4,    4,    4,    7,    1,    1,    1,    1,
			    1,    1,    1,    4,    1,    1,    4,    6,    4,    4,
			    4,    1,    4,    1,    4,    1,    1,    1, yyDummy>>)
		end

	yytypes2_template: SPECIAL [INTEGER]
			-- Template for `yytypes2'
		once
			Result := yyfixed_array (<<
			    1,    1,    1,    4,    4,    4,    4,    4,    4,    4,
			    4,    4,    4,    4,    4,    4,    4,    4,    4,    4,
			    4,    4,    4,    4,    4,    4,    4,    4,    4,    4,
			    4,    4,    4,    4,    4,    4,    4,    4,    4,    4,
			    4,    4,    4,    4,    4,    4,    4,    4,    4,    4,
			    4,    4,    4,    4,    4,    4,    4,    4,    4,    4,
			    4,    4,    4,    4,    4,    4,    4,    4,    4,    4,
			    4,    4,    4,    4,    4,    4,    4,    4,    4,    4,
			    4,    4,    4,    4,    4,    4,    4,    4,    4,    4,
			    4,    4,    4,    4,    4, yyDummy>>)
		end

	yydefact_template: SPECIAL [INTEGER]
			-- Template for `yydefact'
		once
			Result := yyfixed_array (<<
			  105,    0,   79,    0,    0,  123,  100,  102,    0,   99,
			  121,  122,  106,  107,    0,  110,   43,   21,   20,   43,
			   76,   68,   10,    9,   75,    0,   72,   71,  101,    0,
			   98,  103,  124,    0,    0,    0,  105,  154,  108,    0,
			  115,    0,   23,   22,   47,   48,    0,  111,   44,   45,
			    0,   44,   67,   74,   73,    0,  104,  275,  125,    3,
			   12,   11,  161,  164,    0,    2,  178,  181,  180,    0,
			    0,  182,  184,  158,  155,  183,  173,  175,  177,  176,
			  174,    0,  171,  179,    1,  116,  117,    0,    0,  109,
			    0,    0,   43,   43,   46,   78,   91,   92,    0,   85,

			   42,   41,   40,   37,   36,   35,   34,   33,   32,   31,
			   30,   29,   39,   38,   19,   18,   43,   28,  137,  137,
			    0,  131,   14,   13,    4,    8,    7,    6,  159,  162,
			    0,  170,    0,   93,   97,    0,   95,  157,  156,  172,
			  118,    0,    0,    0,    0,  113,   44,  112,   44,   77,
			   90,   88,   89,   84,   83,  126,   44,    0,    0,    0,
			  278,    0,   43,    0,    0,    0,    0,    0,   82,    0,
			    0,  148,  149,  147,  146,    0,  132,  133,  135,  136,
			  142,  143,  144,  145,  250,  251,    0,  258,  264,  265,
			    5,    0,  165,    0,  169,   94,   96,  120,  119,    0,

			    0,    0,    0,   43,   87,   86,   27,   26,    0,  272,
			   43,   43,  140,    0,  129,  127,    0,    0,  252,    0,
			  283,    0,  266,    0,  223,    0,  186,    0,   43,   70,
			    0,  130,  134,  253,    0,  258,  262,    0,  259,  260,
			    0,  168,  160,  163,    0,    0,    0,    0,    0,    0,
			    0,  114,  273,  128,  138,   43,  141,   43,  276,   43,
			   43,    0,    0,    0,   43,    0,    0,   44,   69,  254,
			    0,  256,  261,    0,  167,  166,  280,  279,  153,  151,
			  152,  150,  139,    0,    0,    0,    0,    0,    0,   43,
			  224,    0,   44,    0,   81,    0,  263,   64,   66,   65,

			   57,   62,    0,    0,   63,  277,  255,  257,  284,   43,
			   43,    0,    0,   43,   43,  225,    0,  221,    0,   43,
			   43,   43,    0,  190,   43,   43,   43,    0,   80,   59,
			   61,   58,   60,    0,    0,    0,   49,   25,   24,   54,
			   56,    0,    0,   55,    0,   43,    0,   44,  222,  227,
			    0,  216,  188,  187,  185,   43,   43,   43,  192,  191,
			  194,  193,  189,   43,   43,  195,  208,   43,   43,    0,
			    0,    0,  281,  282,   43,   43,   51,   53,   50,   52,
			  267,    0,  268,    0,    0,  237,  236,  235,  234,  233,
			  232,  231,  228,    0,  229,  230,  239,    0,  238,  202,

			  201,  203,  220,  196,  215,   43,    0,  198,  197,  200,
			  199,   43,  219,  207,    0,    0,  210,    0,    0,  269,
			    0,    0,    0,   17,   16,   43,   15,    0,  217,  205,
			    0,  218,  209,   43,  213,    0,  211,  270,  271,  274,
			    0,    0,  247,  246,  249,  226,  244,    0,  243,    0,
			  204,    0,    0,  241,    0,    0,   43,  206,  214,  212,
			  240,    0,  248,  245,  242,    0,    0,    0, yyDummy>>)
		end

	yydefgoto_template: SPECIAL [INTEGER]
			-- Template for `yydefgoto'
		once
			Result := yyfixed_array (<<
			  191,   64,   35,   74,  192,  193,  124,  425,  364,  209,
			   24,   65,  126,  117,  152,   45,  340,  313,  341,  342,
			  274,  302,  303,  304,  343,   25,   26,   27,   98,   99,
			  153,  154,  135,  136,   76,  210,  310,  118,  345,  365,
			  322,  323,  366,  367,  430,  368,  369,  326,  435,  358,
			  289,  290,  393,  394,  395,  445,  396,  427,   16,   92,
			   41,   93,    6,   46,    7,  465,    8,   77,    9,  404,
			  148,   49,   10,  173,   11,  174,   80,   30,   12,   31,
			   13,   32,   33,   58,  119,  158,  121,  175,  176,  177,
			  178,  179,  213,  180,  181,  182,  183,   37,   81,   82,

			   83,  370,  406,  413,  414,  371,  398,  454,  184,  185,
			  186,  187,  237,  238,  239,  188,  189, yyDummy>>)
		end

	yypact_template: SPECIAL [INTEGER]
			-- Template for `yypact'
		once
			Result := yyfixed_array (<<
			  511,  155, -32768,  317,  585, -32768,  474,  524,  479, -32768,
			 -32768, -32768,  474, -32768,  348, -32768,  223, -32768, -32768,  223,
			 -32768, -32768, -32768, -32768, -32768,  536,  247,  247,  474,  223,
			 -32768,  474, -32768,  512,   54,  112,  474, -32768, -32768,  529,
			  525,  396, -32768, -32768, -32768, -32768,  504, -32768,  371, -32768,
			  501,  517, -32768, -32768, -32768,  444,  474,  491, -32768,  414,
			 -32768, -32768, -32768,  423,  220, -32768, -32768, -32768, -32768,   28,
			  319, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768,   14, -32768, -32768, -32768,  478, -32768,  469,  435, -32768,
			  348,  348,  223,  223, -32768, -32768, -32768, -32768,  437,  663,

			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768,  223, -32768,  449,  449,
			  179,  638, -32768, -32768, -32768, -32768, -32768,  414, -32768, -32768,
			  131, -32768,  -49, -32768, -32768,  194, -32768, -32768, -32768, -32768,
			 -32768,  422,  399,  382,  375, -32768,   49, -32768,  223, -32768,
			 -32768, -32768, -32768,  663,  663, -32768,  688,  709,  383,  381,
			 -32768,  223,  223,  246,  352,  337,  310,  229, -32768,  317,
			  443, -32768, -32768, -32768, -32768,  367,  638, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768,  627,   34, -32768, -32768,
			 -32768,   11, -32768,  202, -32768, -32768, -32768, -32768, -32768,  369,

			  365,  254,  200,  223, -32768, -32768, -32768, -32768,  152, -32768,
			  223,  223, -32768,  675, -32768, -32768,  425,  356, -32768,  150,
			 -32768,  444, -32768,  407, -32768,  444, -32768,  444,  223, -32768,
			  366, -32768, -32768, -32768,  590,   34, -32768,  291,   34, -32768,
			  268, -32768, -32768, -32768,  131,  315,  333,  313,  309,  279,
			  263, -32768, -32768, -32768, -32768,  223, -32768,  223, -32768,  223,
			  223,  223,  223,  223,  223,  223,  251,  517, -32768, -32768,
			  190, -32768, -32768,   74, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768,  235,  226,  221,  586,  444,  270,  223,
			 -32768,  209,  444,  409, -32768,  215, -32768, -32768, -32768, -32768,

			 -32768, -32768,   71,   53, -32768, -32768, -32768, -32768,  152,  223,
			  223,  223,  362,  223,  223, -32768,  199, -32768,   55,  223,
			  223,  223,  196, -32768,  316,  316,  223,  481, -32768, -32768,
			 -32768, -32768, -32768,  185,  176,  270, -32768, -32768, -32768, -32768,
			 -32768,  280,  106, -32768,  149,  223,  146,   12, -32768, -32768,
			  505, -32768, -32768, -32768, -32768,  223,  223,  223, -32768, -32768,
			 -32768, -32768, -32768,  223,  316, -32768,  128,  316,  316,   86,
			  518,  115, -32768, -32768,  223,  223, -32768, -32768, -32768, -32768,
			 -32768,  105, -32768,  223,  223, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768,  223, -32768, -32768, -32768,  364, -32768, -32768,

			 -32768, -32768, -32768, -32768, -32768,  223,  518, -32768, -32768, -32768,
			 -32768,  223, -32768, -32768,  518,  555,   88,   79,   25, -32768,
			  444,  346,  169, -32768, -32768,  223, -32768,  115, -32768, -32768,
			  115, -32768, -32768,  223, -32768,  115, -32768, -32768, -32768, -32768,
			  555,  223, -32768, -32768, -32768, -32768, -32768,  364, -32768,  518,
			 -32768,  555,   26, -32768,   -4,   23,  223, -32768, -32768, -32768,
			 -32768,  555, -32768, -32768, -32768,   47,   35, -32768, yyDummy>>)
		end

	yypgoto_template: SPECIAL [INTEGER]
			-- Template for `yypgoto'
		once
			Result := yyfixed_array (<<
			  -18, -32768, -32768,  552,  388, -32768,  507,  177,  -54, -199,
			  -27,  -46, -32768, -32768,   -1, -115, -32768,  288, -32768,  207,
			 -389, -32768,  283, -32768, -32768,  452, -32768,  462,  342, -32768,
			 -32768,  296, -32768,  473, -32768, -267, -32768, -32768, -32768, -392,
			 -32768, -32768, -230,  328, -32768,  327, -32768, -32768, -32768, -175,
			 -32768,  318, -32768, -32768, -32768, -32768, -32768, -32768,  485, -110,
			  351,  458, -32768, -32768, -32768, -32768, -32768,  594,  557,  -16,
			  -12,   40,    6, -32768,  -21, -32768, -32768, -32768,   22, -32768,
			  129, -32768, -32768, -32768, -32768,  476, -32768, -32768,  415, -138,
			 -108, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,  506,

			 -32768, -288, -360, -156, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768,  338, -32768,  332, -32768, -32768, yyDummy>>)
		end

	yytable_template: SPECIAL [INTEGER]
			-- Template for `yytable'
		once
			Result := yyfixed_array (<<
			   47,  116,   19,   50,   48,  327,  172,   51,   75,  252,
			  162,  415,  241,  125,   79,  137,   63,   55,  240,  309,
			   44,  314,   72,  434,   96,   23,   22,    4,   28,  131,
			    3,   44,  194,  444,    2,  467,   71,  127,  232,  460,
			  405,   78,  172,  134,   70,   23,   22,  466,  453,  212,
			   97,  132,  130,   56,   75,   62,  349,   44,  438,  458,
			   79,  172,  397,   44,   23,   22,  462,  447,  375,  464,
			  449,  172,  151,  459,   91,  451,  145,  147,   43,   42,
			  146,  125,   23,   22,  383,   23,   22,   78,   94,   43,
			   42,   94,   34,   69,  461,   94,  232,  127,  172,  273,

			  155,   68,   67,   66,  156,  256,  257,  235,  134,  252,
			   61,   60,  437,   73,   59,   43,   42,   23,   22,  172,
			   72,   43,   42,   23,   22,    4,  151,  151,    3,  412,
			  331,  411,    2,  440,   71,  436,   61,   60,  419,   44,
			   59,   38,   70,  299,  298,  297,  217,  219,  329,  216,
			  360,  300,  221,  223,  225,  227,   15,   38,  412,  405,
			  236,  299,  298,  297,  299,  298,  297,  261,  228,  263,
			   94,  264,  405,  265,  338,  337,  429,   44,   14,  382,
			  160,  244,  380,  378,  432,   38,   94,  251,   94,  403,
			   34,   69,  407,  409,  253,  254,   94,   43,   42,   68,

			   67,   66,   14,  207,  206,   23,   22,   90,  236,  373,
			   44,  236,  266,   61,   60,  416,  267,   59,  372,  457,
			  260,  259,  443,  442,  441,  195,  250,  249,   44,  354,
			  226,   44,  348,  311,  328,   43,   42,   44,  318,  282,
			   96,  283,  317,  284,  285,  273,  301,  218,  291,  286,
			  287,  288,  292,  293,   44,  307,   94,  305,   23,   22,
			  306,   94,   20,   94,  296,   94,   97,   94,   43,   42,
			  294,  448,  281,  316,  450,  301,  301,  292,   44,  452,
			  248,  247,  243,  242,   94,  339,   43,   42,  280,   43,
			   42,   23,   22,  333,  334,   43,   42,  344,  346,  335,

			  129,  128,  347,  351,  352,  353,  350,   94,  359,  361,
			  362,  224,   43,   42,  339,  339,  -43,  -43,   44,  279,
			  208,  207,  206,  278,   44,  276,   94,   94,   94,  381,
			   23,   22,   94,   94,   18,   17,   43,   42,  222,  399,
			  400,  401,  277,  426,  273,   44,  312,  402,  338,  337,
			  133,  408,  410,  220,   44,   40,   39,  376,  417,  418,
			   44,  433,  357,  356,  355,  271,  439,  115,  114,  424,
			  423,  420,  421,   23,   22,   94,   43,   42,  258,   44,
			  268,  422,   43,   42,  202,  201,  433,   94,  319,  428,
			   94,  200,  199,  426,  246,  431,   91,  433,  245,   90,

			  113,  112,  231,   43,   42,   88,   87,  433,  198,  446,
			  115,  114,   43,   42,  215,   44,  214,   44,   43,   42,
			  111,  110,  109,  108,  107,  106,  105,  104,  103,  455,
			  338,  337,  197,   44,  102,  101,  100,   43,   42,  336,
			  463,  143,  144,  113,  112,  321,  320,  115,  114,  204,
			  205,  319,   44,   90,   23,   22,  149,  229,   20,  142,
			   94,   94,   94,  111,  110,  109,  108,  107,  106,  105,
			  104,  103,  262,   43,   42,   43,   42,  102,  101,  100,
			  113,  112,    5,  157,  115,  114,  140,    4,   53,   54,
			    3,   43,   42,  141,    2,   94,   61,   60,  123,  122,

			  111,  110,  109,  108,  107,  106,  105,  104,  103,  127,
			   43,   42,  120,   44,  102,  101,  100,  113,  112,    5,
			   95,  115,  114,  319,    4,   44,   89,    3,   23,   22,
			  363,    2,    1,   86,   18,   17,   85,  111,  110,  109,
			  108,  107,  106,  105,  104,  103,   57,  319,  377,  379,
			   52,  102,  101,  100,  113,  112,   29,   34,  115,  114,
			  319,  392,  391,  390,  389,  388,  387,  386,  385,  384,
			  272,   43,   42,  270,  111,  110,  109,  108,  107,  106,
			  105,  104,  103,   43,   42,  330,  332,  139,  102,  101,
			  100,  113,  112,   84,   44,  159,   23,   22,  171,   21,

			   20,  234,   36,  170,  203,  161,  169,  315,  196,  295,
			  168,  111,  110,  109,  108,  107,  106,  105,  104,  103,
			  325,  324,  230,  374,  456,  102,  101,  100,  167,  166,
			  165,  164,  275,  138,  190,  171,  308,  207,  206,    0,
			  170,    0,    0,  169,    0,    0,  171,  168,    0,    0,
			    0,  170,   43,   42,  169,    0,   43,   42,  168,    0,
			    0,    0,    0,  163,  269,  167,  166,  165,  164,    0,
			    0,  150,    0,    0,   23,   22,  167,  166,  165,  164,
			   18,   17,    0,  171,    0,    0,    0,    0,  170,    0,
			    0,  169,    0,   43,   42,  168,   44,    0,    0,    0,

			  163,  233,    0,    0,   43,   42,    0,    0,    0,    0,
			  255,  163,    0,  167,  166,  165,  164,  171,    0,    0,
			    0,    0,  170,    0,    0,  169,    0,    0,    0,  168,
			    0,    0,    0,    0,    0,    0,    0,    0,  208,  207,
			  206,   43,   42,    0,  211,    0,    0,  167,  166,  165,
			  164,    0,    0,    0,   43,   42,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,   43,   42, yyDummy>>)
		end

	yycheck_template: SPECIAL [INTEGER]
			-- Template for `yycheck'
		once
			Result := yyfixed_array (<<
			   16,   55,    3,   19,   16,  293,  121,   19,   35,  208,
			  120,  371,    1,   59,   35,    1,   34,   29,    7,  286,
			    8,  288,    8,  415,   51,   11,   12,   13,    6,    1,
			   16,    8,   81,  422,   20,    0,   22,   86,  176,   43,
			   44,   35,  157,   70,   30,   11,   12,    0,  440,  157,
			   51,   69,   64,   31,   81,    1,    1,    8,   33,  451,
			   81,  176,  350,    8,   11,   12,  455,  427,  335,  461,
			  430,  186,   99,   47,   25,  435,   92,   93,   66,   67,
			   92,  127,   11,   12,   72,   11,   12,   81,   48,   66,
			   67,   51,   78,   79,  454,   55,  234,   86,  213,   76,

			  116,   87,   88,   89,  116,  213,  216,   73,  135,  308,
			   82,   83,   33,    1,   86,   66,   67,   11,   12,  234,
			    8,   66,   67,   11,   12,   13,  153,  154,   16,   43,
			   77,   45,   20,  421,   22,   47,   82,   83,   33,    8,
			   86,   12,   30,   90,   91,   92,  162,  163,   77,  161,
			  325,   77,  164,  165,  166,  167,    1,   28,   43,   44,
			  187,   90,   91,   92,   90,   91,   92,  221,  169,  223,
			  130,  225,   44,  227,   68,   69,  406,    8,   23,   33,
			    1,  193,   33,   77,  414,   56,  146,  203,  148,  364,
			   78,   79,  367,  368,  210,  211,  156,   66,   67,   87,

			   88,   89,   23,   51,   52,   11,   12,   28,  235,   33,
			    8,  238,  228,   82,   83,  371,  228,   86,   33,  449,
			   70,   71,   53,   54,   55,   31,   26,   27,    8,   33,
			    1,    8,   33,  287,   19,   66,   67,    8,  292,  255,
			  267,  257,   33,  259,  260,   76,  273,    1,  264,  261,
			  262,  263,  264,  265,    8,   34,  216,   22,   11,   12,
			   34,  221,   15,  223,   74,  225,  267,  227,   66,   67,
			   19,  427,    9,  289,  430,  302,  303,  289,    8,  435,
			   26,   27,   80,   81,  244,  312,   66,   67,    9,   66,
			   67,   11,   12,  309,  310,   66,   67,  313,  314,  311,

			   80,   81,  314,  319,  320,  321,  318,  267,  324,  325,
			  326,    1,   66,   67,  341,  342,   70,   71,    8,   10,
			   50,   51,   52,   10,    8,   10,  286,  287,  288,  345,
			   11,   12,  292,  293,   17,   18,   66,   67,    1,  355,
			  356,  357,    9,  397,   76,    8,   76,  363,   68,   69,
			   31,  367,  368,    1,    8,    7,    8,   77,  374,  375,
			    8,  415,   46,   47,   48,   74,  420,    3,    4,    5,
			    6,  383,  384,   11,   12,  335,   66,   67,   22,    8,
			   14,  393,   66,   67,    9,   10,  440,  347,   42,  405,
			  350,    9,   10,  447,   29,  411,   25,  451,   29,   28,

			   36,   37,   35,   66,   67,    9,   10,  461,    9,  425,
			    3,    4,   66,   67,   33,    8,   33,    8,   66,   67,
			   56,   57,   58,   59,   60,   61,   62,   63,   64,  441,
			   68,   69,   10,    8,   70,   71,   72,   66,   67,   77,
			  456,   90,   91,   36,   37,   36,   37,    3,    4,  153,
			  154,   42,    8,   28,   11,   12,   19,   14,   15,   24,
			  420,  421,  422,   56,   57,   58,   59,   60,   61,   62,
			   63,   64,   65,   66,   67,   66,   67,   70,   71,   72,
			   36,   37,    8,   34,    3,    4,    8,   13,   26,   27,
			   16,   66,   67,   24,   20,  455,   82,   83,   84,   85,

			   56,   57,   58,   59,   60,   61,   62,   63,   64,   86,
			   66,   67,   21,    8,   70,   71,   72,   36,   37,    8,
			   19,    3,    4,   42,   13,    8,   22,   16,   11,   12,
			   49,   20,   21,    8,   17,   18,    7,   56,   57,   58,
			   59,   60,   61,   62,   63,   64,   34,   42,  341,  342,
			   14,   70,   71,   72,   36,   37,   32,   78,    3,    4,
			   42,   56,   57,   58,   59,   60,   61,   62,   63,   64,
			  238,   66,   67,  235,   56,   57,   58,   59,   60,   61,
			   62,   63,   64,   66,   67,  302,  303,   81,   70,   71,
			   72,   36,   37,   36,    8,  119,   11,   12,    8,   14,

			   15,  186,    8,   13,  146,  120,   16,  289,  135,  267,
			   20,   56,   57,   58,   59,   60,   61,   62,   63,   64,
			  293,  293,  170,  335,  447,   70,   71,   72,   38,   39,
			   40,   41,  244,   81,  127,    8,   50,   51,   52,   -1,
			   13,   -1,   -1,   16,   -1,   -1,    8,   20,   -1,   -1,
			   -1,   13,   66,   67,   16,   -1,   66,   67,   20,   -1,
			   -1,   -1,   -1,   73,   74,   38,   39,   40,   41,   -1,
			   -1,    8,   -1,   -1,   11,   12,   38,   39,   40,   41,
			   17,   18,   -1,    8,   -1,   -1,   -1,   -1,   13,   -1,
			   -1,   16,   -1,   66,   67,   20,    8,   -1,   -1,   -1,

			   73,   74,   -1,   -1,   66,   67,   -1,   -1,   -1,   -1,
			   35,   73,   -1,   38,   39,   40,   41,    8,   -1,   -1,
			   -1,   -1,   13,   -1,   -1,   16,   -1,   -1,   -1,   20,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   50,   51,
			   52,   66,   67,   -1,   35,   -1,   -1,   38,   39,   40,
			   41,   -1,   -1,   -1,   66,   67,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   66,   67, yyDummy>>)
		end

feature {NONE} -- Semantic value stacks

	yyvs1: SPECIAL [ANY]
			-- Stack for semantic values of type ANY

	yyvsc1: INTEGER
			-- Capacity of semantic value stack `yyvs1'

	yyvsp1: INTEGER
			-- Top of semantic value stack `yyvs1'

	yyspecial_routines1: KL_SPECIAL_ROUTINES [ANY]
			-- Routines that ought to be in SPECIAL [ANY]

	yyvs2: SPECIAL [XM_EIFFEL_PARSER_NAME]
			-- Stack for semantic values of type XM_EIFFEL_PARSER_NAME

	yyvsc2: INTEGER
			-- Capacity of semantic value stack `yyvs2'

	yyvsp2: INTEGER
			-- Top of semantic value stack `yyvs2'

	yyspecial_routines2: KL_SPECIAL_ROUTINES [XM_EIFFEL_PARSER_NAME]
			-- Routines that ought to be in SPECIAL [XM_EIFFEL_PARSER_NAME]

	yyvs3: SPECIAL [DS_HASH_SET [XM_EIFFEL_PARSER_NAME]]
			-- Stack for semantic values of type DS_HASH_SET [XM_EIFFEL_PARSER_NAME]

	yyvsc3: INTEGER
			-- Capacity of semantic value stack `yyvs3'

	yyvsp3: INTEGER
			-- Top of semantic value stack `yyvs3'

	yyspecial_routines3: KL_SPECIAL_ROUTINES [DS_HASH_SET [XM_EIFFEL_PARSER_NAME]]
			-- Routines that ought to be in SPECIAL [DS_HASH_SET [XM_EIFFEL_PARSER_NAME]]

	yyvs4: SPECIAL [STRING]
			-- Stack for semantic values of type STRING

	yyvsc4: INTEGER
			-- Capacity of semantic value stack `yyvs4'

	yyvsp4: INTEGER
			-- Top of semantic value stack `yyvs4'

	yyspecial_routines4: KL_SPECIAL_ROUTINES [STRING]
			-- Routines that ought to be in SPECIAL [STRING]

	yyvs5: SPECIAL [XM_DTD_EXTERNAL_ID]
			-- Stack for semantic values of type XM_DTD_EXTERNAL_ID

	yyvsc5: INTEGER
			-- Capacity of semantic value stack `yyvs5'

	yyvsp5: INTEGER
			-- Top of semantic value stack `yyvs5'

	yyspecial_routines5: KL_SPECIAL_ROUTINES [XM_DTD_EXTERNAL_ID]
			-- Routines that ought to be in SPECIAL [XM_DTD_EXTERNAL_ID]

	yyvs6: SPECIAL [XM_DTD_ELEMENT_CONTENT]
			-- Stack for semantic values of type XM_DTD_ELEMENT_CONTENT

	yyvsc6: INTEGER
			-- Capacity of semantic value stack `yyvs6'

	yyvsp6: INTEGER
			-- Top of semantic value stack `yyvs6'

	yyspecial_routines6: KL_SPECIAL_ROUTINES [XM_DTD_ELEMENT_CONTENT]
			-- Routines that ought to be in SPECIAL [XM_DTD_ELEMENT_CONTENT]

	yyvs7: SPECIAL [XM_DTD_ATTRIBUTE_CONTENT]
			-- Stack for semantic values of type XM_DTD_ATTRIBUTE_CONTENT

	yyvsc7: INTEGER
			-- Capacity of semantic value stack `yyvs7'

	yyvsp7: INTEGER
			-- Top of semantic value stack `yyvs7'

	yyspecial_routines7: KL_SPECIAL_ROUTINES [XM_DTD_ATTRIBUTE_CONTENT]
			-- Routines that ought to be in SPECIAL [XM_DTD_ATTRIBUTE_CONTENT]

	yyvs8: SPECIAL [DS_BILINKED_LIST [XM_DTD_ATTRIBUTE_CONTENT]]
			-- Stack for semantic values of type DS_BILINKED_LIST [XM_DTD_ATTRIBUTE_CONTENT]

	yyvsc8: INTEGER
			-- Capacity of semantic value stack `yyvs8'

	yyvsp8: INTEGER
			-- Top of semantic value stack `yyvs8'

	yyspecial_routines8: KL_SPECIAL_ROUTINES [DS_BILINKED_LIST [XM_DTD_ATTRIBUTE_CONTENT]]
			-- Routines that ought to be in SPECIAL [DS_BILINKED_LIST [XM_DTD_ATTRIBUTE_CONTENT]]

	yyvs9: SPECIAL [DS_BILINKED_LIST [STRING]]
			-- Stack for semantic values of type DS_BILINKED_LIST [STRING]

	yyvsc9: INTEGER
			-- Capacity of semantic value stack `yyvs9'

	yyvsp9: INTEGER
			-- Top of semantic value stack `yyvs9'

	yyspecial_routines9: KL_SPECIAL_ROUTINES [DS_BILINKED_LIST [STRING]]
			-- Routines that ought to be in SPECIAL [DS_BILINKED_LIST [STRING]]

	yyvs10: SPECIAL [BOOLEAN]
			-- Stack for semantic values of type BOOLEAN

	yyvsc10: INTEGER
			-- Capacity of semantic value stack `yyvs10'

	yyvsp10: INTEGER
			-- Top of semantic value stack `yyvs10'

	yyspecial_routines10: KL_SPECIAL_ROUTINES [BOOLEAN]
			-- Routines that ought to be in SPECIAL [BOOLEAN]

	yyvs11: SPECIAL [XM_EIFFEL_DECLARATION]
			-- Stack for semantic values of type XM_EIFFEL_DECLARATION

	yyvsc11: INTEGER
			-- Capacity of semantic value stack `yyvs11'

	yyvsp11: INTEGER
			-- Top of semantic value stack `yyvs11'

	yyspecial_routines11: KL_SPECIAL_ROUTINES [XM_EIFFEL_DECLARATION]
			-- Routines that ought to be in SPECIAL [XM_EIFFEL_DECLARATION]

feature {NONE} -- Constants

	yyFinal: INTEGER = 467
			-- Termination state id

	yyFlag: INTEGER = -32768
			-- Most negative INTEGER

	yyNtbase: INTEGER = 95
			-- Number of tokens

	yyLast: INTEGER = 776
			-- Upper bound of `yytable' and `yycheck'

	yyMax_token: INTEGER = 349
			-- Maximum token id
			-- (upper bound of `yytranslate'.)

	yyNsyms: INTEGER = 212
			-- Number of symbols
			-- (terminal and nonterminal)

feature -- User-defined features



feature -- Parsing

	parse
			-- (NOTE: THIS IS THE COPY/PASTE VERSION OF THE CODE IN
			-- THE YY_PARSER_SKELETON CLASS, FOR OPTIMISATION WITH
			-- ISE EIFFEL (ALLOW INLINING NOT POSSIBLE IN
			-- YY_PARSER_SKELETON).)

			-- Parse input stream.
			-- Set `syntax_error' to True if
			-- parsing has not been successful.
		local
			yystacksize: INTEGER
			yystate: INTEGER
			yyn: INTEGER
			yychar1: INTEGER
			index, yyss_top: INTEGER
			yy_goto: INTEGER
		do
				-- This routine is implemented with a loop whose body
				-- is a big inspect instruction. This is a mere
				-- translation of C gotos into Eiffel. Needless to
				-- say that I'm not very proud of this piece of code.
				-- However I performed some benchmarks and the results
				-- were that this implementation runs amazingly faster
				-- than an alternative implementation with no loop nor
				-- inspect instructions and where every branch of the
				-- old inspect instruction was written in a separate
				-- routine. I think that the performance penalty is due
				-- to the routine call overhead and the depth of the call
				-- stack. Anyway, I prefer to provide you with a big and
				-- ugly but fast parsing routine rather than a nice and
				-- slow version. I hope you won't blame me for that! :-)
			from
				if yy_parsing_status = yySuspended then
					yystacksize := yy_suspended_yystacksize
					yystate := yy_suspended_yystate
					yyn := yy_suspended_yyn
					yychar1 := yy_suspended_yychar1
					index := yy_suspended_index
					yyss_top := yy_suspended_yyss_top
					yy_goto := yy_suspended_yy_goto
					yy_parsing_status := yyContinue
					if yy_goto = yyReduce then
							-- Now "shift" the result of the reduction.
							-- Determine what state that goes to,
							-- based on the state we popped back to
							-- and the rule number reduced by.
						yyn := yyr1.item (yyn)
						yyss_top := yyss.item (yyssp)
						index := yyn - yyNtbase
						yystate := yypgoto.item (index) + yyss_top
						if
							(yystate >= 0 and yystate <= yyLast) and then
							yycheck.item (yystate) = yyss_top
						then
							yystate := yytable.item (yystate)
						else
							yystate := yydefgoto.item (index)
						end
						yy_goto := yyNewstate
					end
				else
					error_count := 0
					yy_lookahead_needed := True
					yyerrstatus := 0
					yy_init_value_stacks
					yyssp := -1
					yystacksize := yyss.count
					yy_parsing_status := yyContinue
					yy_goto := yyNewstate
				end
			until
				yy_parsing_status /= yyContinue
			loop
				inspect yy_goto
				when yyNewstate then
					yyssp := yyssp + 1
					if yyssp >= yystacksize then
						yystacksize := yystacksize + yyInitial_stack_size
						yyss := SPECIAL_INTEGER_.resize (yyss, yystacksize)
						debug ("GEYACC")
							std.error.put_string ("Stack (yyss) size increased to ")
							std.error.put_integer (yystacksize)
							std.error.put_character ('%N')
						end
					end
					debug ("GEYACC")
						std.error.put_string ("Entering state ")
						std.error.put_integer (yystate)
						std.error.put_character ('%N')
					end
					SPECIAL_INTEGER_.force (yyss, yystate, yyssp)
						-- Do appropriate processing given the current state.
						-- Read a lookahead token if one is needed.
					yyn := yypact.item (yystate)
						-- First try to decide what to do without reference
						-- lookahead token.
					if yyn = yyFlag then
						yy_goto := yyDefault
					else
							-- Not known => get a lookahead token if don't
							-- already have one.
						if yy_lookahead_needed then
							debug ("GEYACC")
								std.error.put_string ("Reading a token%N")
							end
							read_token
							yy_lookahead_needed := False
						end
							-- Convert token to internal form (in `yychar1')
							-- for indexing tables.
						if last_token > yyEof then
							debug ("GEYACC")
								std.error.put_string ("Next token is ")
								std.error.put_integer (last_token)
								std.error.put_character ('%N')
							end
								-- Translate lexical token `last_token' into
								-- geyacc internal token code.
							if last_token <= yyMax_token then
								yychar1 := yytranslate.item (last_token)
							else
								yychar1 := yyNsyms
							end
							yyn := yyn + yychar1
						elseif last_token = yyEof then
								-- This means end of input.
							debug ("GEYACC")
								std.error.put_string ("Now at end of input.%N")
							end
							yychar1 := 0
						else
								-- An error occurred in the scanner.
							debug ("GEYACC")
								std.error.put_string ("Error in scanner.%N")
							end
							error_count := error_count + 1
							yy_do_error_action (yystate)
							abort
								-- Skip next conditional instruction:
							yyn := -1
						end
						if
							(yyn < 0 or yyn > yyLast) or else
							yycheck.item (yyn) /= yychar1
						then
							yy_goto := yyDefault
						else
							yyn := yytable.item (yyn)
								-- `yyn' is what to do for this token type in
								-- this state:
								-- Negative => reduce, -`yyn' is rule number.
								-- Positive => shift, `yyn' is new state.
								-- New state is final state => don't bother to
								-- shift, just return success.
								-- 0, or most negative number => error.
							if yyn < 0 then
								if yyn = yyFlag then
									yy_goto := yyErrlab
								else
									yyn := -yyn
									yy_goto := yyReduce
								end
							elseif yyn = 0 then
								yy_goto := yyErrlab
							elseif yyn = yyFinal then
								accept
							else
									-- Shift the lookahead token.
								debug ("GEYACC")
									std.error.put_string ("Shifting token ")
									std.error.put_integer (last_token)
									std.error.put_character ('%N')
								end
									-- Discard the token being shifted
									-- unless it is eof.
								if last_token > yyEof then
									yy_lookahead_needed := True
								end
								yy_push_last_value (yychar1)
									-- Count tokens shifted since error;
									-- after three, turn off error status.
								if yyerrstatus /= 0 then
									yyerrstatus := yyerrstatus - 1
								end
								yystate := yyn
								check
									newstate: yy_goto = yyNewstate
								end
							end
						end
					end
				when yyDefault then
						-- Do the default action for the current state.
					yyn := yydefact.item (yystate)
					if yyn = 0 then
						yy_goto := yyErrlab
					else
						yy_goto := yyReduce
					end
				when yyReduce then
						-- Do a reduction. `yyn' is the number of a rule
						-- to reduce with.
					debug ("GEYACC")
						std.error.put_string ("Reducing via rule #")
						std.error.put_integer (yyn)
						std.error.put_character ('%N')
					end
					yy_do_action (yyn)
					inspect yy_parsing_status
					when yyContinue then
							-- Now "shift" the result of the reduction.
							-- Determine what state that goes to,
							-- based on the state we popped back to
							-- and the rule number reduced by.
						yyn := yyr1.item (yyn)
						yyss_top := yyss.item (yyssp)
						index := yyn - yyNtbase
						yystate := yypgoto.item (index) + yyss_top
						if
							(yystate >= 0 and yystate <= yyLast) and then
							yycheck.item (yystate) = yyss_top
						then
							yystate := yytable.item (yystate)
						else
							yystate := yydefgoto.item (index)
						end
						yy_goto := yyNewstate
					when yySuspended then
						yy_suspended_yystacksize := yystacksize
						yy_suspended_yystate := yystate
						yy_suspended_yyn := yyn
						yy_suspended_yychar1 := yychar1
						yy_suspended_index := index
						yy_suspended_yyss_top := yyss_top
						yy_suspended_yy_goto := yy_goto
					when yyError_raised then
							-- Handle error raised explicitly by an action.
						yy_parsing_status := yyContinue
						yy_goto := yyErrlab
					else
							-- Accepted or aborted.
					end
				when yyErrlab then
						-- Detect error.
					if yyerrstatus = 3 then
							-- If just tried and failed to reuse lookahead
							-- token after an error, discard it. Return
							-- failure if at end of input.
						if last_token <= yyEof then
							abort
						else
							debug ("GEYACC")
								std.error.put_string ("Discarding token ")
								std.error.put_integer (last_token)
								std.error.put_character ('%N')
							end
							yy_lookahead_needed := True
							yy_goto := yyErrhandle
						end
					else
						if yyerrstatus = 0 then
								-- If not already recovering from an error,
								-- report this error.
							error_count := error_count + 1
							yy_do_error_action (yystate)
						end
						yyerrstatus := 3
						yy_goto := yyErrhandle
					end
				when yyErrhandle then
						-- Handle error.
					yyn := yypact.item (yystate)
					if yyn = yyFlag then
						yy_goto := yyErrpop
					else
						yyn := yyn + yyTerror
						if
							(yyn < 0 or yyn > yyLast) or else
							yycheck.item (yyn) /= yyTerror
						then
							yy_goto := yyErrpop
						else
							yyn := yytable.item (yyn)
							if yyn < 0 then
								if yyn = yyFlag then
									yy_goto := yyErrpop
								else
									yyn := -yyn
									yy_goto := yyReduce
								end
							elseif yyn = 0 then
								yy_goto := yyErrpop
							elseif yyn = yyFinal then
								accept
							else
								yy_push_error_value
								yystate := yyn
								yy_goto := yyNewstate
							end
						end
					end
				when yyErrpop then
						-- Pop the current state because it cannot handle
						-- the error token.
					if yyssp = 0 then
						abort
					else
						yy_pop_last_value (yystate)
						yyssp := yyssp - 1
						yystate := yyss.item (yyssp)
						yy_goto := yyErrhandle
					end
				end
			end
			if yy_parsing_status /= yySuspended then
				yy_clear_all
			end
		rescue
			debug ("GEYACC")
				std.error.put_line ("Entering rescue clause of parser")
			end
			abort
			yy_clear_all
		end

end
