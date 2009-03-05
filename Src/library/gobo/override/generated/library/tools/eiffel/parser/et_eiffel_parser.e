indexing

	description:

		"Eiffel parsers"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 1999-2009, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class ET_EIFFEL_PARSER

inherit

	ET_EIFFEL_PARSER_SKELETON
		undefine
			read_token
		redefine
			yyparse
		end

	ET_EIFFEL_SCANNER
		rename
			make as make_eiffel_scanner
		undefine
			reset, set_syntax_error
		end

create

	make


feature {NONE} -- Implementation

	yy_build_parser_tables is
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

	yy_create_value_stacks is
			-- Create value stacks.
		do
		end

	yy_init_value_stacks is
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
			yyvsp12 := -1
			yyvsp13 := -1
			yyvsp14 := -1
			yyvsp15 := -1
			yyvsp16 := -1
			yyvsp17 := -1
			yyvsp18 := -1
			yyvsp19 := -1
			yyvsp20 := -1
			yyvsp21 := -1
			yyvsp22 := -1
			yyvsp23 := -1
			yyvsp24 := -1
			yyvsp25 := -1
			yyvsp26 := -1
			yyvsp27 := -1
			yyvsp28 := -1
			yyvsp29 := -1
			yyvsp30 := -1
			yyvsp31 := -1
			yyvsp32 := -1
			yyvsp33 := -1
			yyvsp34 := -1
			yyvsp35 := -1
			yyvsp36 := -1
			yyvsp37 := -1
			yyvsp38 := -1
			yyvsp39 := -1
			yyvsp40 := -1
			yyvsp41 := -1
			yyvsp42 := -1
			yyvsp43 := -1
			yyvsp44 := -1
			yyvsp45 := -1
			yyvsp46 := -1
			yyvsp47 := -1
			yyvsp48 := -1
			yyvsp49 := -1
			yyvsp50 := -1
			yyvsp51 := -1
			yyvsp52 := -1
			yyvsp53 := -1
			yyvsp54 := -1
			yyvsp55 := -1
			yyvsp56 := -1
			yyvsp57 := -1
			yyvsp58 := -1
			yyvsp59 := -1
			yyvsp60 := -1
			yyvsp61 := -1
			yyvsp62 := -1
			yyvsp63 := -1
			yyvsp64 := -1
			yyvsp65 := -1
			yyvsp66 := -1
			yyvsp67 := -1
			yyvsp68 := -1
			yyvsp69 := -1
			yyvsp70 := -1
			yyvsp71 := -1
			yyvsp72 := -1
			yyvsp73 := -1
			yyvsp74 := -1
			yyvsp75 := -1
			yyvsp76 := -1
			yyvsp77 := -1
			yyvsp78 := -1
			yyvsp79 := -1
			yyvsp80 := -1
			yyvsp81 := -1
			yyvsp82 := -1
			yyvsp83 := -1
			yyvsp84 := -1
			yyvsp85 := -1
			yyvsp86 := -1
			yyvsp87 := -1
			yyvsp88 := -1
			yyvsp89 := -1
			yyvsp90 := -1
			yyvsp91 := -1
			yyvsp92 := -1
			yyvsp93 := -1
			yyvsp94 := -1
			yyvsp95 := -1
			yyvsp96 := -1
			yyvsp97 := -1
			yyvsp98 := -1
			yyvsp99 := -1
			yyvsp100 := -1
			yyvsp101 := -1
			yyvsp102 := -1
			yyvsp103 := -1
			yyvsp104 := -1
			yyvsp105 := -1
			yyvsp106 := -1
			yyvsp107 := -1
			yyvsp108 := -1
			yyvsp109 := -1
			yyvsp110 := -1
			yyvsp111 := -1
			yyvsp112 := -1
			yyvsp113 := -1
			yyvsp114 := -1
			yyvsp115 := -1
			yyvsp116 := -1
			yyvsp117 := -1
			yyvsp118 := -1
		end

	yy_clear_value_stacks is
			-- Clear objects in semantic value stacks so that
			-- they can be collected by the garbage collector.
		do
			if yyvs1 /= Void then
				yyvs1.clear_all
			end
			if yyvs2 /= Void then
				yyvs2.clear_all
			end
			if yyvs3 /= Void then
				yyvs3.clear_all
			end
			if yyvs4 /= Void then
				yyvs4.clear_all
			end
			if yyvs5 /= Void then
				yyvs5.clear_all
			end
			if yyvs6 /= Void then
				yyvs6.clear_all
			end
			if yyvs7 /= Void then
				yyvs7.clear_all
			end
			if yyvs8 /= Void then
				yyvs8.clear_all
			end
			if yyvs9 /= Void then
				yyvs9.clear_all
			end
			if yyvs10 /= Void then
				yyvs10.clear_all
			end
			if yyvs11 /= Void then
				yyvs11.clear_all
			end
			if yyvs12 /= Void then
				yyvs12.clear_all
			end
			if yyvs13 /= Void then
				yyvs13.clear_all
			end
			if yyvs14 /= Void then
				yyvs14.clear_all
			end
			if yyvs15 /= Void then
				yyvs15.clear_all
			end
			if yyvs16 /= Void then
				yyvs16.clear_all
			end
			if yyvs17 /= Void then
				yyvs17.clear_all
			end
			if yyvs18 /= Void then
				yyvs18.clear_all
			end
			if yyvs19 /= Void then
				yyvs19.clear_all
			end
			if yyvs20 /= Void then
				yyvs20.clear_all
			end
			if yyvs21 /= Void then
				yyvs21.clear_all
			end
			if yyvs22 /= Void then
				yyvs22.clear_all
			end
			if yyvs23 /= Void then
				yyvs23.clear_all
			end
			if yyvs24 /= Void then
				yyvs24.clear_all
			end
			if yyvs25 /= Void then
				yyvs25.clear_all
			end
			if yyvs26 /= Void then
				yyvs26.clear_all
			end
			if yyvs27 /= Void then
				yyvs27.clear_all
			end
			if yyvs28 /= Void then
				yyvs28.clear_all
			end
			if yyvs29 /= Void then
				yyvs29.clear_all
			end
			if yyvs30 /= Void then
				yyvs30.clear_all
			end
			if yyvs31 /= Void then
				yyvs31.clear_all
			end
			if yyvs32 /= Void then
				yyvs32.clear_all
			end
			if yyvs33 /= Void then
				yyvs33.clear_all
			end
			if yyvs34 /= Void then
				yyvs34.clear_all
			end
			if yyvs35 /= Void then
				yyvs35.clear_all
			end
			if yyvs36 /= Void then
				yyvs36.clear_all
			end
			if yyvs37 /= Void then
				yyvs37.clear_all
			end
			if yyvs38 /= Void then
				yyvs38.clear_all
			end
			if yyvs39 /= Void then
				yyvs39.clear_all
			end
			if yyvs40 /= Void then
				yyvs40.clear_all
			end
			if yyvs41 /= Void then
				yyvs41.clear_all
			end
			if yyvs42 /= Void then
				yyvs42.clear_all
			end
			if yyvs43 /= Void then
				yyvs43.clear_all
			end
			if yyvs44 /= Void then
				yyvs44.clear_all
			end
			if yyvs45 /= Void then
				yyvs45.clear_all
			end
			if yyvs46 /= Void then
				yyvs46.clear_all
			end
			if yyvs47 /= Void then
				yyvs47.clear_all
			end
			if yyvs48 /= Void then
				yyvs48.clear_all
			end
			if yyvs49 /= Void then
				yyvs49.clear_all
			end
			if yyvs50 /= Void then
				yyvs50.clear_all
			end
			if yyvs51 /= Void then
				yyvs51.clear_all
			end
			if yyvs52 /= Void then
				yyvs52.clear_all
			end
			if yyvs53 /= Void then
				yyvs53.clear_all
			end
			if yyvs54 /= Void then
				yyvs54.clear_all
			end
			if yyvs55 /= Void then
				yyvs55.clear_all
			end
			if yyvs56 /= Void then
				yyvs56.clear_all
			end
			if yyvs57 /= Void then
				yyvs57.clear_all
			end
			if yyvs58 /= Void then
				yyvs58.clear_all
			end
			if yyvs59 /= Void then
				yyvs59.clear_all
			end
			if yyvs60 /= Void then
				yyvs60.clear_all
			end
			if yyvs61 /= Void then
				yyvs61.clear_all
			end
			if yyvs62 /= Void then
				yyvs62.clear_all
			end
			if yyvs63 /= Void then
				yyvs63.clear_all
			end
			if yyvs64 /= Void then
				yyvs64.clear_all
			end
			if yyvs65 /= Void then
				yyvs65.clear_all
			end
			if yyvs66 /= Void then
				yyvs66.clear_all
			end
			if yyvs67 /= Void then
				yyvs67.clear_all
			end
			if yyvs68 /= Void then
				yyvs68.clear_all
			end
			if yyvs69 /= Void then
				yyvs69.clear_all
			end
			if yyvs70 /= Void then
				yyvs70.clear_all
			end
			if yyvs71 /= Void then
				yyvs71.clear_all
			end
			if yyvs72 /= Void then
				yyvs72.clear_all
			end
			if yyvs73 /= Void then
				yyvs73.clear_all
			end
			if yyvs74 /= Void then
				yyvs74.clear_all
			end
			if yyvs75 /= Void then
				yyvs75.clear_all
			end
			if yyvs76 /= Void then
				yyvs76.clear_all
			end
			if yyvs77 /= Void then
				yyvs77.clear_all
			end
			if yyvs78 /= Void then
				yyvs78.clear_all
			end
			if yyvs79 /= Void then
				yyvs79.clear_all
			end
			if yyvs80 /= Void then
				yyvs80.clear_all
			end
			if yyvs81 /= Void then
				yyvs81.clear_all
			end
			if yyvs82 /= Void then
				yyvs82.clear_all
			end
			if yyvs83 /= Void then
				yyvs83.clear_all
			end
			if yyvs84 /= Void then
				yyvs84.clear_all
			end
			if yyvs85 /= Void then
				yyvs85.clear_all
			end
			if yyvs86 /= Void then
				yyvs86.clear_all
			end
			if yyvs87 /= Void then
				yyvs87.clear_all
			end
			if yyvs88 /= Void then
				yyvs88.clear_all
			end
			if yyvs89 /= Void then
				yyvs89.clear_all
			end
			if yyvs90 /= Void then
				yyvs90.clear_all
			end
			if yyvs91 /= Void then
				yyvs91.clear_all
			end
			if yyvs92 /= Void then
				yyvs92.clear_all
			end
			if yyvs93 /= Void then
				yyvs93.clear_all
			end
			if yyvs94 /= Void then
				yyvs94.clear_all
			end
			if yyvs95 /= Void then
				yyvs95.clear_all
			end
			if yyvs96 /= Void then
				yyvs96.clear_all
			end
			if yyvs97 /= Void then
				yyvs97.clear_all
			end
			if yyvs98 /= Void then
				yyvs98.clear_all
			end
			if yyvs99 /= Void then
				yyvs99.clear_all
			end
			if yyvs100 /= Void then
				yyvs100.clear_all
			end
			if yyvs101 /= Void then
				yyvs101.clear_all
			end
			if yyvs102 /= Void then
				yyvs102.clear_all
			end
			if yyvs103 /= Void then
				yyvs103.clear_all
			end
			if yyvs104 /= Void then
				yyvs104.clear_all
			end
			if yyvs105 /= Void then
				yyvs105.clear_all
			end
			if yyvs106 /= Void then
				yyvs106.clear_all
			end
			if yyvs107 /= Void then
				yyvs107.clear_all
			end
			if yyvs108 /= Void then
				yyvs108.clear_all
			end
			if yyvs109 /= Void then
				yyvs109.clear_all
			end
			if yyvs110 /= Void then
				yyvs110.clear_all
			end
			if yyvs111 /= Void then
				yyvs111.clear_all
			end
			if yyvs112 /= Void then
				yyvs112.clear_all
			end
			if yyvs113 /= Void then
				yyvs113.clear_all
			end
			if yyvs114 /= Void then
				yyvs114.clear_all
			end
			if yyvs115 /= Void then
				yyvs115.clear_all
			end
			if yyvs116 /= Void then
				yyvs116.clear_all
			end
			if yyvs117 /= Void then
				yyvs117.clear_all
			end
			if yyvs118 /= Void then
				yyvs118.clear_all
			end
		end

	yy_push_last_value (yychar1: INTEGER) is
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
				yyvs1.put (last_any_value, yyvsp1)
			when 2 then
				yyvsp2 := yyvsp2 + 1
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
				yyvs2.put (last_et_keyword_value, yyvsp2)
			when 3 then
				yyvsp3 := yyvsp3 + 1
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
				yyvs3.put (last_et_agent_keyword_value, yyvsp3)
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
				yyvs4.put (last_et_precursor_keyword_value, yyvsp4)
			when 5 then
				yyvsp5 := yyvsp5 + 1
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
				yyvs5.put (last_et_symbol_value, yyvsp5)
			when 6 then
				yyvsp6 := yyvsp6 + 1
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
				yyvs6.put (last_et_position_value, yyvsp6)
			when 7 then
				yyvsp7 := yyvsp7 + 1
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
				yyvs7.put (last_et_bit_constant_value, yyvsp7)
			when 8 then
				yyvsp8 := yyvsp8 + 1
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
				yyvs8.put (last_et_boolean_constant_value, yyvsp8)
			when 9 then
				yyvsp9 := yyvsp9 + 1
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
				yyvs9.put (last_et_break_value, yyvsp9)
			when 10 then
				yyvsp10 := yyvsp10 + 1
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
				yyvs10.put (last_et_character_constant_value, yyvsp10)
			when 11 then
				yyvsp11 := yyvsp11 + 1
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
				yyvs11.put (last_et_current_value, yyvsp11)
			when 12 then
				yyvsp12 := yyvsp12 + 1
				if yyvsp12 >= yyvsc12 then
					if yyvs12 = Void then
						debug ("GEYACC")
							std.error.put_line ("Create yyvs12")
						end
						create yyspecial_routines12
						yyvsc12 := yyInitial_yyvs_size
						yyvs12 := yyspecial_routines12.make (yyvsc12)
					else
						debug ("GEYACC")
							std.error.put_line ("Resize yyvs12")
						end
						yyvsc12 := yyvsc12 + yyInitial_yyvs_size
						yyvs12 := yyspecial_routines12.resize (yyvs12, yyvsc12)
					end
				end
				yyvs12.put (last_et_free_operator_value, yyvsp12)
			when 13 then
				yyvsp13 := yyvsp13 + 1
				if yyvsp13 >= yyvsc13 then
					if yyvs13 = Void then
						debug ("GEYACC")
							std.error.put_line ("Create yyvs13")
						end
						create yyspecial_routines13
						yyvsc13 := yyInitial_yyvs_size
						yyvs13 := yyspecial_routines13.make (yyvsc13)
					else
						debug ("GEYACC")
							std.error.put_line ("Resize yyvs13")
						end
						yyvsc13 := yyvsc13 + yyInitial_yyvs_size
						yyvs13 := yyspecial_routines13.resize (yyvs13, yyvsc13)
					end
				end
				yyvs13.put (last_et_identifier_value, yyvsp13)
			when 14 then
				yyvsp14 := yyvsp14 + 1
				if yyvsp14 >= yyvsc14 then
					if yyvs14 = Void then
						debug ("GEYACC")
							std.error.put_line ("Create yyvs14")
						end
						create yyspecial_routines14
						yyvsc14 := yyInitial_yyvs_size
						yyvs14 := yyspecial_routines14.make (yyvsc14)
					else
						debug ("GEYACC")
							std.error.put_line ("Resize yyvs14")
						end
						yyvsc14 := yyvsc14 + yyInitial_yyvs_size
						yyvs14 := yyspecial_routines14.resize (yyvs14, yyvsc14)
					end
				end
				yyvs14.put (last_et_integer_constant_value, yyvsp14)
			when 15 then
				yyvsp15 := yyvsp15 + 1
				if yyvsp15 >= yyvsc15 then
					if yyvs15 = Void then
						debug ("GEYACC")
							std.error.put_line ("Create yyvs15")
						end
						create yyspecial_routines15
						yyvsc15 := yyInitial_yyvs_size
						yyvs15 := yyspecial_routines15.make (yyvsc15)
					else
						debug ("GEYACC")
							std.error.put_line ("Resize yyvs15")
						end
						yyvsc15 := yyvsc15 + yyInitial_yyvs_size
						yyvs15 := yyspecial_routines15.resize (yyvs15, yyvsc15)
					end
				end
				yyvs15.put (last_et_keyword_operator_value, yyvsp15)
			when 16 then
				yyvsp16 := yyvsp16 + 1
				if yyvsp16 >= yyvsc16 then
					if yyvs16 = Void then
						debug ("GEYACC")
							std.error.put_line ("Create yyvs16")
						end
						create yyspecial_routines16
						yyvsc16 := yyInitial_yyvs_size
						yyvs16 := yyspecial_routines16.make (yyvsc16)
					else
						debug ("GEYACC")
							std.error.put_line ("Resize yyvs16")
						end
						yyvsc16 := yyvsc16 + yyInitial_yyvs_size
						yyvs16 := yyspecial_routines16.resize (yyvs16, yyvsc16)
					end
				end
				yyvs16.put (last_et_manifest_string_value, yyvsp16)
			when 17 then
				yyvsp17 := yyvsp17 + 1
				if yyvsp17 >= yyvsc17 then
					if yyvs17 = Void then
						debug ("GEYACC")
							std.error.put_line ("Create yyvs17")
						end
						create yyspecial_routines17
						yyvsc17 := yyInitial_yyvs_size
						yyvs17 := yyspecial_routines17.make (yyvsc17)
					else
						debug ("GEYACC")
							std.error.put_line ("Resize yyvs17")
						end
						yyvsc17 := yyvsc17 + yyInitial_yyvs_size
						yyvs17 := yyspecial_routines17.resize (yyvs17, yyvsc17)
					end
				end
				yyvs17.put (last_et_real_constant_value, yyvsp17)
			when 18 then
				yyvsp18 := yyvsp18 + 1
				if yyvsp18 >= yyvsc18 then
					if yyvs18 = Void then
						debug ("GEYACC")
							std.error.put_line ("Create yyvs18")
						end
						create yyspecial_routines18
						yyvsc18 := yyInitial_yyvs_size
						yyvs18 := yyspecial_routines18.make (yyvsc18)
					else
						debug ("GEYACC")
							std.error.put_line ("Resize yyvs18")
						end
						yyvsc18 := yyvsc18 + yyInitial_yyvs_size
						yyvs18 := yyspecial_routines18.resize (yyvs18, yyvsc18)
					end
				end
				yyvs18.put (last_et_result_value, yyvsp18)
			when 19 then
				yyvsp19 := yyvsp19 + 1
				if yyvsp19 >= yyvsc19 then
					if yyvs19 = Void then
						debug ("GEYACC")
							std.error.put_line ("Create yyvs19")
						end
						create yyspecial_routines19
						yyvsc19 := yyInitial_yyvs_size
						yyvs19 := yyspecial_routines19.make (yyvsc19)
					else
						debug ("GEYACC")
							std.error.put_line ("Resize yyvs19")
						end
						yyvsc19 := yyvsc19 + yyInitial_yyvs_size
						yyvs19 := yyspecial_routines19.resize (yyvs19, yyvsc19)
					end
				end
				yyvs19.put (last_et_retry_instruction_value, yyvsp19)
			when 20 then
				yyvsp20 := yyvsp20 + 1
				if yyvsp20 >= yyvsc20 then
					if yyvs20 = Void then
						debug ("GEYACC")
							std.error.put_line ("Create yyvs20")
						end
						create yyspecial_routines20
						yyvsc20 := yyInitial_yyvs_size
						yyvs20 := yyspecial_routines20.make (yyvsc20)
					else
						debug ("GEYACC")
							std.error.put_line ("Resize yyvs20")
						end
						yyvsc20 := yyvsc20 + yyInitial_yyvs_size
						yyvs20 := yyspecial_routines20.resize (yyvs20, yyvsc20)
					end
				end
				yyvs20.put (last_et_symbol_operator_value, yyvsp20)
			when 21 then
				yyvsp21 := yyvsp21 + 1
				if yyvsp21 >= yyvsc21 then
					if yyvs21 = Void then
						debug ("GEYACC")
							std.error.put_line ("Create yyvs21")
						end
						create yyspecial_routines21
						yyvsc21 := yyInitial_yyvs_size
						yyvs21 := yyspecial_routines21.make (yyvsc21)
					else
						debug ("GEYACC")
							std.error.put_line ("Resize yyvs21")
						end
						yyvsc21 := yyvsc21 + yyInitial_yyvs_size
						yyvs21 := yyspecial_routines21.resize (yyvs21, yyvsc21)
					end
				end
				yyvs21.put (last_et_void_value, yyvsp21)
			when 22 then
				yyvsp22 := yyvsp22 + 1
				if yyvsp22 >= yyvsc22 then
					if yyvs22 = Void then
						debug ("GEYACC")
							std.error.put_line ("Create yyvs22")
						end
						create yyspecial_routines22
						yyvsc22 := yyInitial_yyvs_size
						yyvs22 := yyspecial_routines22.make (yyvsc22)
					else
						debug ("GEYACC")
							std.error.put_line ("Resize yyvs22")
						end
						yyvsc22 := yyvsc22 + yyInitial_yyvs_size
						yyvs22 := yyspecial_routines22.resize (yyvs22, yyvsc22)
					end
				end
				yyvs22.put (last_et_semicolon_symbol_value, yyvsp22)
			when 23 then
				yyvsp23 := yyvsp23 + 1
				if yyvsp23 >= yyvsc23 then
					if yyvs23 = Void then
						debug ("GEYACC")
							std.error.put_line ("Create yyvs23")
						end
						create yyspecial_routines23
						yyvsc23 := yyInitial_yyvs_size
						yyvs23 := yyspecial_routines23.make (yyvsc23)
					else
						debug ("GEYACC")
							std.error.put_line ("Resize yyvs23")
						end
						yyvsc23 := yyvsc23 + yyInitial_yyvs_size
						yyvs23 := yyspecial_routines23.resize (yyvs23, yyvsc23)
					end
				end
				yyvs23.put (last_et_bracket_symbol_value, yyvsp23)
			when 24 then
				yyvsp24 := yyvsp24 + 1
				if yyvsp24 >= yyvsc24 then
					if yyvs24 = Void then
						debug ("GEYACC")
							std.error.put_line ("Create yyvs24")
						end
						create yyspecial_routines24
						yyvsc24 := yyInitial_yyvs_size
						yyvs24 := yyspecial_routines24.make (yyvsc24)
					else
						debug ("GEYACC")
							std.error.put_line ("Resize yyvs24")
						end
						yyvsc24 := yyvsc24 + yyInitial_yyvs_size
						yyvs24 := yyspecial_routines24.resize (yyvs24, yyvsc24)
					end
				end
				yyvs24.put (last_et_question_mark_symbol_value, yyvsp24)
			else
				debug ("GEYACC")
					std.error.put_string ("Error in parser: not a token type: ")
					std.error.put_integer (yytypes2.item (yychar1))
					std.error.put_new_line
				end
				abort
			end
		end

	yy_push_error_value is
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
			yyvs1.put (yyval1, yyvsp1)
		end

	yy_pop_last_value (yystate: INTEGER) is
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
			when 12 then
				yyvsp12 := yyvsp12 - 1
			when 13 then
				yyvsp13 := yyvsp13 - 1
			when 14 then
				yyvsp14 := yyvsp14 - 1
			when 15 then
				yyvsp15 := yyvsp15 - 1
			when 16 then
				yyvsp16 := yyvsp16 - 1
			when 17 then
				yyvsp17 := yyvsp17 - 1
			when 18 then
				yyvsp18 := yyvsp18 - 1
			when 19 then
				yyvsp19 := yyvsp19 - 1
			when 20 then
				yyvsp20 := yyvsp20 - 1
			when 21 then
				yyvsp21 := yyvsp21 - 1
			when 22 then
				yyvsp22 := yyvsp22 - 1
			when 23 then
				yyvsp23 := yyvsp23 - 1
			when 24 then
				yyvsp24 := yyvsp24 - 1
			when 25 then
				yyvsp25 := yyvsp25 - 1
			when 26 then
				yyvsp26 := yyvsp26 - 1
			when 27 then
				yyvsp27 := yyvsp27 - 1
			when 28 then
				yyvsp28 := yyvsp28 - 1
			when 29 then
				yyvsp29 := yyvsp29 - 1
			when 30 then
				yyvsp30 := yyvsp30 - 1
			when 31 then
				yyvsp31 := yyvsp31 - 1
			when 32 then
				yyvsp32 := yyvsp32 - 1
			when 33 then
				yyvsp33 := yyvsp33 - 1
			when 34 then
				yyvsp34 := yyvsp34 - 1
			when 35 then
				yyvsp35 := yyvsp35 - 1
			when 36 then
				yyvsp36 := yyvsp36 - 1
			when 37 then
				yyvsp37 := yyvsp37 - 1
			when 38 then
				yyvsp38 := yyvsp38 - 1
			when 39 then
				yyvsp39 := yyvsp39 - 1
			when 40 then
				yyvsp40 := yyvsp40 - 1
			when 41 then
				yyvsp41 := yyvsp41 - 1
			when 42 then
				yyvsp42 := yyvsp42 - 1
			when 43 then
				yyvsp43 := yyvsp43 - 1
			when 44 then
				yyvsp44 := yyvsp44 - 1
			when 45 then
				yyvsp45 := yyvsp45 - 1
			when 46 then
				yyvsp46 := yyvsp46 - 1
			when 47 then
				yyvsp47 := yyvsp47 - 1
			when 48 then
				yyvsp48 := yyvsp48 - 1
			when 49 then
				yyvsp49 := yyvsp49 - 1
			when 50 then
				yyvsp50 := yyvsp50 - 1
			when 51 then
				yyvsp51 := yyvsp51 - 1
			when 52 then
				yyvsp52 := yyvsp52 - 1
			when 53 then
				yyvsp53 := yyvsp53 - 1
			when 54 then
				yyvsp54 := yyvsp54 - 1
			when 55 then
				yyvsp55 := yyvsp55 - 1
			when 56 then
				yyvsp56 := yyvsp56 - 1
			when 57 then
				yyvsp57 := yyvsp57 - 1
			when 58 then
				yyvsp58 := yyvsp58 - 1
			when 59 then
				yyvsp59 := yyvsp59 - 1
			when 60 then
				yyvsp60 := yyvsp60 - 1
			when 61 then
				yyvsp61 := yyvsp61 - 1
			when 62 then
				yyvsp62 := yyvsp62 - 1
			when 63 then
				yyvsp63 := yyvsp63 - 1
			when 64 then
				yyvsp64 := yyvsp64 - 1
			when 65 then
				yyvsp65 := yyvsp65 - 1
			when 66 then
				yyvsp66 := yyvsp66 - 1
			when 67 then
				yyvsp67 := yyvsp67 - 1
			when 68 then
				yyvsp68 := yyvsp68 - 1
			when 69 then
				yyvsp69 := yyvsp69 - 1
			when 70 then
				yyvsp70 := yyvsp70 - 1
			when 71 then
				yyvsp71 := yyvsp71 - 1
			when 72 then
				yyvsp72 := yyvsp72 - 1
			when 73 then
				yyvsp73 := yyvsp73 - 1
			when 74 then
				yyvsp74 := yyvsp74 - 1
			when 75 then
				yyvsp75 := yyvsp75 - 1
			when 76 then
				yyvsp76 := yyvsp76 - 1
			when 77 then
				yyvsp77 := yyvsp77 - 1
			when 78 then
				yyvsp78 := yyvsp78 - 1
			when 79 then
				yyvsp79 := yyvsp79 - 1
			when 80 then
				yyvsp80 := yyvsp80 - 1
			when 81 then
				yyvsp81 := yyvsp81 - 1
			when 82 then
				yyvsp82 := yyvsp82 - 1
			when 83 then
				yyvsp83 := yyvsp83 - 1
			when 84 then
				yyvsp84 := yyvsp84 - 1
			when 85 then
				yyvsp85 := yyvsp85 - 1
			when 86 then
				yyvsp86 := yyvsp86 - 1
			when 87 then
				yyvsp87 := yyvsp87 - 1
			when 88 then
				yyvsp88 := yyvsp88 - 1
			when 89 then
				yyvsp89 := yyvsp89 - 1
			when 90 then
				yyvsp90 := yyvsp90 - 1
			when 91 then
				yyvsp91 := yyvsp91 - 1
			when 92 then
				yyvsp92 := yyvsp92 - 1
			when 93 then
				yyvsp93 := yyvsp93 - 1
			when 94 then
				yyvsp94 := yyvsp94 - 1
			when 95 then
				yyvsp95 := yyvsp95 - 1
			when 96 then
				yyvsp96 := yyvsp96 - 1
			when 97 then
				yyvsp97 := yyvsp97 - 1
			when 98 then
				yyvsp98 := yyvsp98 - 1
			when 99 then
				yyvsp99 := yyvsp99 - 1
			when 100 then
				yyvsp100 := yyvsp100 - 1
			when 101 then
				yyvsp101 := yyvsp101 - 1
			when 102 then
				yyvsp102 := yyvsp102 - 1
			when 103 then
				yyvsp103 := yyvsp103 - 1
			when 104 then
				yyvsp104 := yyvsp104 - 1
			when 105 then
				yyvsp105 := yyvsp105 - 1
			when 106 then
				yyvsp106 := yyvsp106 - 1
			when 107 then
				yyvsp107 := yyvsp107 - 1
			when 108 then
				yyvsp108 := yyvsp108 - 1
			when 109 then
				yyvsp109 := yyvsp109 - 1
			when 110 then
				yyvsp110 := yyvsp110 - 1
			when 111 then
				yyvsp111 := yyvsp111 - 1
			when 112 then
				yyvsp112 := yyvsp112 - 1
			when 113 then
				yyvsp113 := yyvsp113 - 1
			when 114 then
				yyvsp114 := yyvsp114 - 1
			when 115 then
				yyvsp115 := yyvsp115 - 1
			when 116 then
				yyvsp116 := yyvsp116 - 1
			when 117 then
				yyvsp117 := yyvsp117 - 1
			when 118 then
				yyvsp118 := yyvsp118 - 1
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

	yy_do_action (yy_act: INTEGER) is
			-- Execute semantic action.
		do
			if yy_act <= 200 then
				yy_do_action_1_200 (yy_act)
			elseif yy_act <= 400 then
				yy_do_action_201_400 (yy_act)
			elseif yy_act <= 600 then
				yy_do_action_401_600 (yy_act)
			elseif yy_act <= 800 then
				yy_do_action_601_800 (yy_act)
			else
				debug ("GEYACC")
					std.error.put_string ("Error in parser: unknown rule id: ")
					std.error.put_integer (yy_act)
					std.error.put_new_line
				end
				abort
			end
		end

	yy_do_action_1_200 (yy_act: INTEGER) is
			-- Execute semantic action.
		do
			inspect yy_act
			when 1 then
					--|#line 222 "et_eiffel_parser.y"
				yy_do_action_1
			when 2 then
					--|#line 226 "et_eiffel_parser.y"
				yy_do_action_2
			when 3 then
					--|#line 234 "et_eiffel_parser.y"
				yy_do_action_3
			when 4 then
					--|#line 243 "et_eiffel_parser.y"
				yy_do_action_4
			when 5 then
					--|#line 244 "et_eiffel_parser.y"
				yy_do_action_5
			when 6 then
					--|#line 244 "et_eiffel_parser.y"
				yy_do_action_6
			when 7 then
					--|#line 255 "et_eiffel_parser.y"
				yy_do_action_7
			when 8 then
					--|#line 261 "et_eiffel_parser.y"
				yy_do_action_8
			when 9 then
					--|#line 267 "et_eiffel_parser.y"
				yy_do_action_9
			when 10 then
					--|#line 273 "et_eiffel_parser.y"
				yy_do_action_10
			when 11 then
					--|#line 279 "et_eiffel_parser.y"
				yy_do_action_11
			when 12 then
					--|#line 285 "et_eiffel_parser.y"
				yy_do_action_12
			when 13 then
					--|#line 285 "et_eiffel_parser.y"
				yy_do_action_13
			when 14 then
					--|#line 301 "et_eiffel_parser.y"
				yy_do_action_14
			when 15 then
					--|#line 306 "et_eiffel_parser.y"
				yy_do_action_15
			when 16 then
					--|#line 321 "et_eiffel_parser.y"
				yy_do_action_16
			when 17 then
					--|#line 326 "et_eiffel_parser.y"
				yy_do_action_17
			when 18 then
					--|#line 328 "et_eiffel_parser.y"
				yy_do_action_18
			when 19 then
					--|#line 328 "et_eiffel_parser.y"
				yy_do_action_19
			when 20 then
					--|#line 339 "et_eiffel_parser.y"
				yy_do_action_20
			when 21 then
					--|#line 341 "et_eiffel_parser.y"
				yy_do_action_21
			when 22 then
					--|#line 341 "et_eiffel_parser.y"
				yy_do_action_22
			when 23 then
					--|#line 354 "et_eiffel_parser.y"
				yy_do_action_23
			when 24 then
					--|#line 356 "et_eiffel_parser.y"
				yy_do_action_24
			when 25 then
					--|#line 360 "et_eiffel_parser.y"
				yy_do_action_25
			when 26 then
					--|#line 371 "et_eiffel_parser.y"
				yy_do_action_26
			when 27 then
					--|#line 371 "et_eiffel_parser.y"
				yy_do_action_27
			when 28 then
					--|#line 380 "et_eiffel_parser.y"
				yy_do_action_28
			when 29 then
					--|#line 380 "et_eiffel_parser.y"
				yy_do_action_29
			when 30 then
					--|#line 391 "et_eiffel_parser.y"
				yy_do_action_30
			when 31 then
					--|#line 398 "et_eiffel_parser.y"
				yy_do_action_31
			when 32 then
					--|#line 404 "et_eiffel_parser.y"
				yy_do_action_32
			when 33 then
					--|#line 408 "et_eiffel_parser.y"
				yy_do_action_33
			when 34 then
					--|#line 419 "et_eiffel_parser.y"
				yy_do_action_34
			when 35 then
					--|#line 431 "et_eiffel_parser.y"
				yy_do_action_35
			when 36 then
					--|#line 431 "et_eiffel_parser.y"
				yy_do_action_36
			when 37 then
					--|#line 440 "et_eiffel_parser.y"
				yy_do_action_37
			when 38 then
					--|#line 440 "et_eiffel_parser.y"
				yy_do_action_38
			when 39 then
					--|#line 451 "et_eiffel_parser.y"
				yy_do_action_39
			when 40 then
					--|#line 458 "et_eiffel_parser.y"
				yy_do_action_40
			when 41 then
					--|#line 462 "et_eiffel_parser.y"
				yy_do_action_41
			when 42 then
					--|#line 468 "et_eiffel_parser.y"
				yy_do_action_42
			when 43 then
					--|#line 470 "et_eiffel_parser.y"
				yy_do_action_43
			when 44 then
					--|#line 475 "et_eiffel_parser.y"
				yy_do_action_44
			when 45 then
					--|#line 486 "et_eiffel_parser.y"
				yy_do_action_45
			when 46 then
					--|#line 495 "et_eiffel_parser.y"
				yy_do_action_46
			when 47 then
					--|#line 497 "et_eiffel_parser.y"
				yy_do_action_47
			when 48 then
					--|#line 499 "et_eiffel_parser.y"
				yy_do_action_48
			when 49 then
					--|#line 501 "et_eiffel_parser.y"
				yy_do_action_49
			when 50 then
					--|#line 503 "et_eiffel_parser.y"
				yy_do_action_50
			when 51 then
					--|#line 505 "et_eiffel_parser.y"
				yy_do_action_51
			when 52 then
					--|#line 507 "et_eiffel_parser.y"
				yy_do_action_52
			when 53 then
					--|#line 509 "et_eiffel_parser.y"
				yy_do_action_53
			when 54 then
					--|#line 511 "et_eiffel_parser.y"
				yy_do_action_54
			when 55 then
					--|#line 515 "et_eiffel_parser.y"
				yy_do_action_55
			when 56 then
					--|#line 526 "et_eiffel_parser.y"
				yy_do_action_56
			when 57 then
					--|#line 536 "et_eiffel_parser.y"
				yy_do_action_57
			when 58 then
					--|#line 547 "et_eiffel_parser.y"
				yy_do_action_58
			when 59 then
					--|#line 558 "et_eiffel_parser.y"
				yy_do_action_59
			when 60 then
					--|#line 571 "et_eiffel_parser.y"
				yy_do_action_60
			when 61 then
					--|#line 573 "et_eiffel_parser.y"
				yy_do_action_61
			when 62 then
					--|#line 577 "et_eiffel_parser.y"
				yy_do_action_62
			when 63 then
					--|#line 579 "et_eiffel_parser.y"
				yy_do_action_63
			when 64 then
					--|#line 585 "et_eiffel_parser.y"
				yy_do_action_64
			when 65 then
					--|#line 589 "et_eiffel_parser.y"
				yy_do_action_65
			when 66 then
					--|#line 595 "et_eiffel_parser.y"
				yy_do_action_66
			when 67 then
					--|#line 595 "et_eiffel_parser.y"
				yy_do_action_67
			when 68 then
					--|#line 609 "et_eiffel_parser.y"
				yy_do_action_68
			when 69 then
					--|#line 620 "et_eiffel_parser.y"
				yy_do_action_69
			when 70 then
					--|#line 629 "et_eiffel_parser.y"
				yy_do_action_70
			when 71 then
					--|#line 638 "et_eiffel_parser.y"
				yy_do_action_71
			when 72 then
					--|#line 645 "et_eiffel_parser.y"
				yy_do_action_72
			when 73 then
					--|#line 652 "et_eiffel_parser.y"
				yy_do_action_73
			when 74 then
					--|#line 659 "et_eiffel_parser.y"
				yy_do_action_74
			when 75 then
					--|#line 666 "et_eiffel_parser.y"
				yy_do_action_75
			when 76 then
					--|#line 673 "et_eiffel_parser.y"
				yy_do_action_76
			when 77 then
					--|#line 680 "et_eiffel_parser.y"
				yy_do_action_77
			when 78 then
					--|#line 687 "et_eiffel_parser.y"
				yy_do_action_78
			when 79 then
					--|#line 694 "et_eiffel_parser.y"
				yy_do_action_79
			when 80 then
					--|#line 703 "et_eiffel_parser.y"
				yy_do_action_80
			when 81 then
					--|#line 705 "et_eiffel_parser.y"
				yy_do_action_81
			when 82 then
					--|#line 705 "et_eiffel_parser.y"
				yy_do_action_82
			when 83 then
					--|#line 718 "et_eiffel_parser.y"
				yy_do_action_83
			when 84 then
					--|#line 729 "et_eiffel_parser.y"
				yy_do_action_84
			when 85 then
					--|#line 737 "et_eiffel_parser.y"
				yy_do_action_85
			when 86 then
					--|#line 746 "et_eiffel_parser.y"
				yy_do_action_86
			when 87 then
					--|#line 748 "et_eiffel_parser.y"
				yy_do_action_87
			when 88 then
					--|#line 750 "et_eiffel_parser.y"
				yy_do_action_88
			when 89 then
					--|#line 752 "et_eiffel_parser.y"
				yy_do_action_89
			when 90 then
					--|#line 754 "et_eiffel_parser.y"
				yy_do_action_90
			when 91 then
					--|#line 762 "et_eiffel_parser.y"
				yy_do_action_91
			when 92 then
					--|#line 770 "et_eiffel_parser.y"
				yy_do_action_92
			when 93 then
					--|#line 772 "et_eiffel_parser.y"
				yy_do_action_93
			when 94 then
					--|#line 774 "et_eiffel_parser.y"
				yy_do_action_94
			when 95 then
					--|#line 776 "et_eiffel_parser.y"
				yy_do_action_95
			when 96 then
					--|#line 778 "et_eiffel_parser.y"
				yy_do_action_96
			when 97 then
					--|#line 786 "et_eiffel_parser.y"
				yy_do_action_97
			when 98 then
					--|#line 796 "et_eiffel_parser.y"
				yy_do_action_98
			when 99 then
					--|#line 798 "et_eiffel_parser.y"
				yy_do_action_99
			when 100 then
					--|#line 800 "et_eiffel_parser.y"
				yy_do_action_100
			when 101 then
					--|#line 802 "et_eiffel_parser.y"
				yy_do_action_101
			when 102 then
					--|#line 804 "et_eiffel_parser.y"
				yy_do_action_102
			when 103 then
					--|#line 812 "et_eiffel_parser.y"
				yy_do_action_103
			when 104 then
					--|#line 820 "et_eiffel_parser.y"
				yy_do_action_104
			when 105 then
					--|#line 822 "et_eiffel_parser.y"
				yy_do_action_105
			when 106 then
					--|#line 824 "et_eiffel_parser.y"
				yy_do_action_106
			when 107 then
					--|#line 826 "et_eiffel_parser.y"
				yy_do_action_107
			when 108 then
					--|#line 828 "et_eiffel_parser.y"
				yy_do_action_108
			when 109 then
					--|#line 836 "et_eiffel_parser.y"
				yy_do_action_109
			when 110 then
					--|#line 846 "et_eiffel_parser.y"
				yy_do_action_110
			when 111 then
					--|#line 848 "et_eiffel_parser.y"
				yy_do_action_111
			when 112 then
					--|#line 852 "et_eiffel_parser.y"
				yy_do_action_112
			when 113 then
					--|#line 855 "et_eiffel_parser.y"
				yy_do_action_113
			when 114 then
					--|#line 863 "et_eiffel_parser.y"
				yy_do_action_114
			when 115 then
					--|#line 874 "et_eiffel_parser.y"
				yy_do_action_115
			when 116 then
					--|#line 879 "et_eiffel_parser.y"
				yy_do_action_116
			when 117 then
					--|#line 884 "et_eiffel_parser.y"
				yy_do_action_117
			when 118 then
					--|#line 891 "et_eiffel_parser.y"
				yy_do_action_118
			when 119 then
					--|#line 900 "et_eiffel_parser.y"
				yy_do_action_119
			when 120 then
					--|#line 902 "et_eiffel_parser.y"
				yy_do_action_120
			when 121 then
					--|#line 906 "et_eiffel_parser.y"
				yy_do_action_121
			when 122 then
					--|#line 909 "et_eiffel_parser.y"
				yy_do_action_122
			when 123 then
					--|#line 915 "et_eiffel_parser.y"
				yy_do_action_123
			when 124 then
					--|#line 923 "et_eiffel_parser.y"
				yy_do_action_124
			when 125 then
					--|#line 928 "et_eiffel_parser.y"
				yy_do_action_125
			when 126 then
					--|#line 933 "et_eiffel_parser.y"
				yy_do_action_126
			when 127 then
					--|#line 938 "et_eiffel_parser.y"
				yy_do_action_127
			when 128 then
					--|#line 949 "et_eiffel_parser.y"
				yy_do_action_128
			when 129 then
					--|#line 960 "et_eiffel_parser.y"
				yy_do_action_129
			when 130 then
					--|#line 973 "et_eiffel_parser.y"
				yy_do_action_130
			when 131 then
					--|#line 982 "et_eiffel_parser.y"
				yy_do_action_131
			when 132 then
					--|#line 993 "et_eiffel_parser.y"
				yy_do_action_132
			when 133 then
					--|#line 995 "et_eiffel_parser.y"
				yy_do_action_133
			when 134 then
					--|#line 1001 "et_eiffel_parser.y"
				yy_do_action_134
			when 135 then
					--|#line 1003 "et_eiffel_parser.y"
				yy_do_action_135
			when 136 then
					--|#line 1005 "et_eiffel_parser.y"
				yy_do_action_136
			when 137 then
					--|#line 1012 "et_eiffel_parser.y"
				yy_do_action_137
			when 138 then
					--|#line 1020 "et_eiffel_parser.y"
				yy_do_action_138
			when 139 then
					--|#line 1027 "et_eiffel_parser.y"
				yy_do_action_139
			when 140 then
					--|#line 1034 "et_eiffel_parser.y"
				yy_do_action_140
			when 141 then
					--|#line 1042 "et_eiffel_parser.y"
				yy_do_action_141
			when 142 then
					--|#line 1049 "et_eiffel_parser.y"
				yy_do_action_142
			when 143 then
					--|#line 1056 "et_eiffel_parser.y"
				yy_do_action_143
			when 144 then
					--|#line 1063 "et_eiffel_parser.y"
				yy_do_action_144
			when 145 then
					--|#line 1072 "et_eiffel_parser.y"
				yy_do_action_145
			when 146 then
					--|#line 1081 "et_eiffel_parser.y"
				yy_do_action_146
			when 147 then
					--|#line 1088 "et_eiffel_parser.y"
				yy_do_action_147
			when 148 then
					--|#line 1095 "et_eiffel_parser.y"
				yy_do_action_148
			when 149 then
					--|#line 1102 "et_eiffel_parser.y"
				yy_do_action_149
			when 150 then
					--|#line 1109 "et_eiffel_parser.y"
				yy_do_action_150
			when 151 then
					--|#line 1118 "et_eiffel_parser.y"
				yy_do_action_151
			when 152 then
					--|#line 1125 "et_eiffel_parser.y"
				yy_do_action_152
			when 153 then
					--|#line 1132 "et_eiffel_parser.y"
				yy_do_action_153
			when 154 then
					--|#line 1139 "et_eiffel_parser.y"
				yy_do_action_154
			when 155 then
					--|#line 1148 "et_eiffel_parser.y"
				yy_do_action_155
			when 156 then
					--|#line 1155 "et_eiffel_parser.y"
				yy_do_action_156
			when 157 then
					--|#line 1166 "et_eiffel_parser.y"
				yy_do_action_157
			when 158 then
					--|#line 1168 "et_eiffel_parser.y"
				yy_do_action_158
			when 159 then
					--|#line 1168 "et_eiffel_parser.y"
				yy_do_action_159
			when 160 then
					--|#line 1181 "et_eiffel_parser.y"
				yy_do_action_160
			when 161 then
					--|#line 1188 "et_eiffel_parser.y"
				yy_do_action_161
			when 162 then
					--|#line 1196 "et_eiffel_parser.y"
				yy_do_action_162
			when 163 then
					--|#line 1205 "et_eiffel_parser.y"
				yy_do_action_163
			when 164 then
					--|#line 1214 "et_eiffel_parser.y"
				yy_do_action_164
			when 165 then
					--|#line 1225 "et_eiffel_parser.y"
				yy_do_action_165
			when 166 then
					--|#line 1227 "et_eiffel_parser.y"
				yy_do_action_166
			when 167 then
					--|#line 1227 "et_eiffel_parser.y"
				yy_do_action_167
			when 168 then
					--|#line 1240 "et_eiffel_parser.y"
				yy_do_action_168
			when 169 then
					--|#line 1242 "et_eiffel_parser.y"
				yy_do_action_169
			when 170 then
					--|#line 1246 "et_eiffel_parser.y"
				yy_do_action_170
			when 171 then
					--|#line 1257 "et_eiffel_parser.y"
				yy_do_action_171
			when 172 then
					--|#line 1257 "et_eiffel_parser.y"
				yy_do_action_172
			when 173 then
					--|#line 1272 "et_eiffel_parser.y"
				yy_do_action_173
			when 174 then
					--|#line 1276 "et_eiffel_parser.y"
				yy_do_action_174
			when 175 then
					--|#line 1281 "et_eiffel_parser.y"
				yy_do_action_175
			when 176 then
					--|#line 1281 "et_eiffel_parser.y"
				yy_do_action_176
			when 177 then
					--|#line 1291 "et_eiffel_parser.y"
				yy_do_action_177
			when 178 then
					--|#line 1295 "et_eiffel_parser.y"
				yy_do_action_178
			when 179 then
					--|#line 1306 "et_eiffel_parser.y"
				yy_do_action_179
			when 180 then
					--|#line 1314 "et_eiffel_parser.y"
				yy_do_action_180
			when 181 then
					--|#line 1325 "et_eiffel_parser.y"
				yy_do_action_181
			when 182 then
					--|#line 1325 "et_eiffel_parser.y"
				yy_do_action_182
			when 183 then
					--|#line 1336 "et_eiffel_parser.y"
				yy_do_action_183
			when 184 then
					--|#line 1340 "et_eiffel_parser.y"
				yy_do_action_184
			when 185 then
					--|#line 1347 "et_eiffel_parser.y"
				yy_do_action_185
			when 186 then
					--|#line 1355 "et_eiffel_parser.y"
				yy_do_action_186
			when 187 then
					--|#line 1362 "et_eiffel_parser.y"
				yy_do_action_187
			when 188 then
					--|#line 1372 "et_eiffel_parser.y"
				yy_do_action_188
			when 189 then
					--|#line 1381 "et_eiffel_parser.y"
				yy_do_action_189
			when 190 then
					--|#line 1392 "et_eiffel_parser.y"
				yy_do_action_190
			when 191 then
					--|#line 1394 "et_eiffel_parser.y"
				yy_do_action_191
			when 192 then
					--|#line 1394 "et_eiffel_parser.y"
				yy_do_action_192
			when 193 then
					--|#line 1407 "et_eiffel_parser.y"
				yy_do_action_193
			when 194 then
					--|#line 1409 "et_eiffel_parser.y"
				yy_do_action_194
			when 195 then
					--|#line 1413 "et_eiffel_parser.y"
				yy_do_action_195
			when 196 then
					--|#line 1415 "et_eiffel_parser.y"
				yy_do_action_196
			when 197 then
					--|#line 1415 "et_eiffel_parser.y"
				yy_do_action_197
			when 198 then
					--|#line 1428 "et_eiffel_parser.y"
				yy_do_action_198
			when 199 then
					--|#line 1430 "et_eiffel_parser.y"
				yy_do_action_199
			when 200 then
					--|#line 1434 "et_eiffel_parser.y"
				yy_do_action_200
			else
				debug ("GEYACC")
					std.error.put_string ("Error in parser: unknown rule id: ")
					std.error.put_integer (yy_act)
					std.error.put_new_line
				end
				abort
			end
		end

	yy_do_action_201_400 (yy_act: INTEGER) is
			-- Execute semantic action.
		do
			inspect yy_act
			when 201 then
					--|#line 1436 "et_eiffel_parser.y"
				yy_do_action_201
			when 202 then
					--|#line 1436 "et_eiffel_parser.y"
				yy_do_action_202
			when 203 then
					--|#line 1449 "et_eiffel_parser.y"
				yy_do_action_203
			when 204 then
					--|#line 1451 "et_eiffel_parser.y"
				yy_do_action_204
			when 205 then
					--|#line 1455 "et_eiffel_parser.y"
				yy_do_action_205
			when 206 then
					--|#line 1466 "et_eiffel_parser.y"
				yy_do_action_206
			when 207 then
					--|#line 1474 "et_eiffel_parser.y"
				yy_do_action_207
			when 208 then
					--|#line 1483 "et_eiffel_parser.y"
				yy_do_action_208
			when 209 then
					--|#line 1494 "et_eiffel_parser.y"
				yy_do_action_209
			when 210 then
					--|#line 1496 "et_eiffel_parser.y"
				yy_do_action_210
			when 211 then
					--|#line 1503 "et_eiffel_parser.y"
				yy_do_action_211
			when 212 then
					--|#line 1510 "et_eiffel_parser.y"
				yy_do_action_212
			when 213 then
					--|#line 1521 "et_eiffel_parser.y"
				yy_do_action_213
			when 214 then
					--|#line 1521 "et_eiffel_parser.y"
				yy_do_action_214
			when 215 then
					--|#line 1536 "et_eiffel_parser.y"
				yy_do_action_215
			when 216 then
					--|#line 1538 "et_eiffel_parser.y"
				yy_do_action_216
			when 217 then
					--|#line 1540 "et_eiffel_parser.y"
				yy_do_action_217
			when 218 then
					--|#line 1540 "et_eiffel_parser.y"
				yy_do_action_218
			when 219 then
					--|#line 1552 "et_eiffel_parser.y"
				yy_do_action_219
			when 220 then
					--|#line 1552 "et_eiffel_parser.y"
				yy_do_action_220
			when 221 then
					--|#line 1564 "et_eiffel_parser.y"
				yy_do_action_221
			when 222 then
					--|#line 1566 "et_eiffel_parser.y"
				yy_do_action_222
			when 223 then
					--|#line 1568 "et_eiffel_parser.y"
				yy_do_action_223
			when 224 then
					--|#line 1568 "et_eiffel_parser.y"
				yy_do_action_224
			when 225 then
					--|#line 1580 "et_eiffel_parser.y"
				yy_do_action_225
			when 226 then
					--|#line 1580 "et_eiffel_parser.y"
				yy_do_action_226
			when 227 then
					--|#line 1594 "et_eiffel_parser.y"
				yy_do_action_227
			when 228 then
					--|#line 1605 "et_eiffel_parser.y"
				yy_do_action_228
			when 229 then
					--|#line 1617 "et_eiffel_parser.y"
				yy_do_action_229
			when 230 then
					--|#line 1626 "et_eiffel_parser.y"
				yy_do_action_230
			when 231 then
					--|#line 1637 "et_eiffel_parser.y"
				yy_do_action_231
			when 232 then
					--|#line 1639 "et_eiffel_parser.y"
				yy_do_action_232
			when 233 then
					--|#line 1643 "et_eiffel_parser.y"
				yy_do_action_233
			when 234 then
					--|#line 1643 "et_eiffel_parser.y"
				yy_do_action_234
			when 235 then
					--|#line 1656 "et_eiffel_parser.y"
				yy_do_action_235
			when 236 then
					--|#line 1663 "et_eiffel_parser.y"
				yy_do_action_236
			when 237 then
					--|#line 1670 "et_eiffel_parser.y"
				yy_do_action_237
			when 238 then
					--|#line 1679 "et_eiffel_parser.y"
				yy_do_action_238
			when 239 then
					--|#line 1688 "et_eiffel_parser.y"
				yy_do_action_239
			when 240 then
					--|#line 1692 "et_eiffel_parser.y"
				yy_do_action_240
			when 241 then
					--|#line 1698 "et_eiffel_parser.y"
				yy_do_action_241
			when 242 then
					--|#line 1700 "et_eiffel_parser.y"
				yy_do_action_242
			when 243 then
					--|#line 1700 "et_eiffel_parser.y"
				yy_do_action_243
			when 244 then
					--|#line 1713 "et_eiffel_parser.y"
				yy_do_action_244
			when 245 then
					--|#line 1724 "et_eiffel_parser.y"
				yy_do_action_245
			when 246 then
					--|#line 1733 "et_eiffel_parser.y"
				yy_do_action_246
			when 247 then
					--|#line 1744 "et_eiffel_parser.y"
				yy_do_action_247
			when 248 then
					--|#line 1749 "et_eiffel_parser.y"
				yy_do_action_248
			when 249 then
					--|#line 1753 "et_eiffel_parser.y"
				yy_do_action_249
			when 250 then
					--|#line 1761 "et_eiffel_parser.y"
				yy_do_action_250
			when 251 then
					--|#line 1768 "et_eiffel_parser.y"
				yy_do_action_251
			when 252 then
					--|#line 1777 "et_eiffel_parser.y"
				yy_do_action_252
			when 253 then
					--|#line 1784 "et_eiffel_parser.y"
				yy_do_action_253
			when 254 then
					--|#line 1793 "et_eiffel_parser.y"
				yy_do_action_254
			when 255 then
					--|#line 1798 "et_eiffel_parser.y"
				yy_do_action_255
			when 256 then
					--|#line 1805 "et_eiffel_parser.y"
				yy_do_action_256
			when 257 then
					--|#line 1806 "et_eiffel_parser.y"
				yy_do_action_257
			when 258 then
					--|#line 1807 "et_eiffel_parser.y"
				yy_do_action_258
			when 259 then
					--|#line 1808 "et_eiffel_parser.y"
				yy_do_action_259
			when 260 then
					--|#line 1813 "et_eiffel_parser.y"
				yy_do_action_260
			when 261 then
					--|#line 1818 "et_eiffel_parser.y"
				yy_do_action_261
			when 262 then
					--|#line 1824 "et_eiffel_parser.y"
				yy_do_action_262
			when 263 then
					--|#line 1829 "et_eiffel_parser.y"
				yy_do_action_263
			when 264 then
					--|#line 1835 "et_eiffel_parser.y"
				yy_do_action_264
			when 265 then
					--|#line 1841 "et_eiffel_parser.y"
				yy_do_action_265
			when 266 then
					--|#line 1850 "et_eiffel_parser.y"
				yy_do_action_266
			when 267 then
					--|#line 1855 "et_eiffel_parser.y"
				yy_do_action_267
			when 268 then
					--|#line 1861 "et_eiffel_parser.y"
				yy_do_action_268
			when 269 then
					--|#line 1866 "et_eiffel_parser.y"
				yy_do_action_269
			when 270 then
					--|#line 1872 "et_eiffel_parser.y"
				yy_do_action_270
			when 271 then
					--|#line 1878 "et_eiffel_parser.y"
				yy_do_action_271
			when 272 then
					--|#line 1887 "et_eiffel_parser.y"
				yy_do_action_272
			when 273 then
					--|#line 1889 "et_eiffel_parser.y"
				yy_do_action_273
			when 274 then
					--|#line 1891 "et_eiffel_parser.y"
				yy_do_action_274
			when 275 then
					--|#line 1893 "et_eiffel_parser.y"
				yy_do_action_275
			when 276 then
					--|#line 1901 "et_eiffel_parser.y"
				yy_do_action_276
			when 277 then
					--|#line 1903 "et_eiffel_parser.y"
				yy_do_action_277
			when 278 then
					--|#line 1911 "et_eiffel_parser.y"
				yy_do_action_278
			when 279 then
					--|#line 1914 "et_eiffel_parser.y"
				yy_do_action_279
			when 280 then
					--|#line 1923 "et_eiffel_parser.y"
				yy_do_action_280
			when 281 then
					--|#line 1927 "et_eiffel_parser.y"
				yy_do_action_281
			when 282 then
					--|#line 1937 "et_eiffel_parser.y"
				yy_do_action_282
			when 283 then
					--|#line 1940 "et_eiffel_parser.y"
				yy_do_action_283
			when 284 then
					--|#line 1949 "et_eiffel_parser.y"
				yy_do_action_284
			when 285 then
					--|#line 1953 "et_eiffel_parser.y"
				yy_do_action_285
			when 286 then
					--|#line 1963 "et_eiffel_parser.y"
				yy_do_action_286
			when 287 then
					--|#line 1965 "et_eiffel_parser.y"
				yy_do_action_287
			when 288 then
					--|#line 1973 "et_eiffel_parser.y"
				yy_do_action_288
			when 289 then
					--|#line 1976 "et_eiffel_parser.y"
				yy_do_action_289
			when 290 then
					--|#line 1985 "et_eiffel_parser.y"
				yy_do_action_290
			when 291 then
					--|#line 1988 "et_eiffel_parser.y"
				yy_do_action_291
			when 292 then
					--|#line 1997 "et_eiffel_parser.y"
				yy_do_action_292
			when 293 then
					--|#line 2001 "et_eiffel_parser.y"
				yy_do_action_293
			when 294 then
					--|#line 2013 "et_eiffel_parser.y"
				yy_do_action_294
			when 295 then
					--|#line 2016 "et_eiffel_parser.y"
				yy_do_action_295
			when 296 then
					--|#line 2020 "et_eiffel_parser.y"
				yy_do_action_296
			when 297 then
					--|#line 2023 "et_eiffel_parser.y"
				yy_do_action_297
			when 298 then
					--|#line 2027 "et_eiffel_parser.y"
				yy_do_action_298
			when 299 then
					--|#line 2029 "et_eiffel_parser.y"
				yy_do_action_299
			when 300 then
					--|#line 2032 "et_eiffel_parser.y"
				yy_do_action_300
			when 301 then
					--|#line 2035 "et_eiffel_parser.y"
				yy_do_action_301
			when 302 then
					--|#line 2041 "et_eiffel_parser.y"
				yy_do_action_302
			when 303 then
					--|#line 2049 "et_eiffel_parser.y"
				yy_do_action_303
			when 304 then
					--|#line 2053 "et_eiffel_parser.y"
				yy_do_action_304
			when 305 then
					--|#line 2055 "et_eiffel_parser.y"
				yy_do_action_305
			when 306 then
					--|#line 2059 "et_eiffel_parser.y"
				yy_do_action_306
			when 307 then
					--|#line 2061 "et_eiffel_parser.y"
				yy_do_action_307
			when 308 then
					--|#line 2065 "et_eiffel_parser.y"
				yy_do_action_308
			when 309 then
					--|#line 2067 "et_eiffel_parser.y"
				yy_do_action_309
			when 310 then
					--|#line 2073 "et_eiffel_parser.y"
				yy_do_action_310
			when 311 then
					--|#line 2075 "et_eiffel_parser.y"
				yy_do_action_311
			when 312 then
					--|#line 2077 "et_eiffel_parser.y"
				yy_do_action_312
			when 313 then
					--|#line 2079 "et_eiffel_parser.y"
				yy_do_action_313
			when 314 then
					--|#line 2081 "et_eiffel_parser.y"
				yy_do_action_314
			when 315 then
					--|#line 2083 "et_eiffel_parser.y"
				yy_do_action_315
			when 316 then
					--|#line 2085 "et_eiffel_parser.y"
				yy_do_action_316
			when 317 then
					--|#line 2087 "et_eiffel_parser.y"
				yy_do_action_317
			when 318 then
					--|#line 2089 "et_eiffel_parser.y"
				yy_do_action_318
			when 319 then
					--|#line 2091 "et_eiffel_parser.y"
				yy_do_action_319
			when 320 then
					--|#line 2093 "et_eiffel_parser.y"
				yy_do_action_320
			when 321 then
					--|#line 2095 "et_eiffel_parser.y"
				yy_do_action_321
			when 322 then
					--|#line 2097 "et_eiffel_parser.y"
				yy_do_action_322
			when 323 then
					--|#line 2099 "et_eiffel_parser.y"
				yy_do_action_323
			when 324 then
					--|#line 2101 "et_eiffel_parser.y"
				yy_do_action_324
			when 325 then
					--|#line 2103 "et_eiffel_parser.y"
				yy_do_action_325
			when 326 then
					--|#line 2105 "et_eiffel_parser.y"
				yy_do_action_326
			when 327 then
					--|#line 2107 "et_eiffel_parser.y"
				yy_do_action_327
			when 328 then
					--|#line 2109 "et_eiffel_parser.y"
				yy_do_action_328
			when 329 then
					--|#line 2111 "et_eiffel_parser.y"
				yy_do_action_329
			when 330 then
					--|#line 2113 "et_eiffel_parser.y"
				yy_do_action_330
			when 331 then
					--|#line 2115 "et_eiffel_parser.y"
				yy_do_action_331
			when 332 then
					--|#line 2117 "et_eiffel_parser.y"
				yy_do_action_332
			when 333 then
					--|#line 2120 "et_eiffel_parser.y"
				yy_do_action_333
			when 334 then
					--|#line 2122 "et_eiffel_parser.y"
				yy_do_action_334
			when 335 then
					--|#line 2124 "et_eiffel_parser.y"
				yy_do_action_335
			when 336 then
					--|#line 2126 "et_eiffel_parser.y"
				yy_do_action_336
			when 337 then
					--|#line 2128 "et_eiffel_parser.y"
				yy_do_action_337
			when 338 then
					--|#line 2130 "et_eiffel_parser.y"
				yy_do_action_338
			when 339 then
					--|#line 2132 "et_eiffel_parser.y"
				yy_do_action_339
			when 340 then
					--|#line 2134 "et_eiffel_parser.y"
				yy_do_action_340
			when 341 then
					--|#line 2136 "et_eiffel_parser.y"
				yy_do_action_341
			when 342 then
					--|#line 2138 "et_eiffel_parser.y"
				yy_do_action_342
			when 343 then
					--|#line 2140 "et_eiffel_parser.y"
				yy_do_action_343
			when 344 then
					--|#line 2142 "et_eiffel_parser.y"
				yy_do_action_344
			when 345 then
					--|#line 2144 "et_eiffel_parser.y"
				yy_do_action_345
			when 346 then
					--|#line 2146 "et_eiffel_parser.y"
				yy_do_action_346
			when 347 then
					--|#line 2148 "et_eiffel_parser.y"
				yy_do_action_347
			when 348 then
					--|#line 2150 "et_eiffel_parser.y"
				yy_do_action_348
			when 349 then
					--|#line 2152 "et_eiffel_parser.y"
				yy_do_action_349
			when 350 then
					--|#line 2154 "et_eiffel_parser.y"
				yy_do_action_350
			when 351 then
					--|#line 2158 "et_eiffel_parser.y"
				yy_do_action_351
			when 352 then
					--|#line 2160 "et_eiffel_parser.y"
				yy_do_action_352
			when 353 then
					--|#line 2164 "et_eiffel_parser.y"
				yy_do_action_353
			when 354 then
					--|#line 2166 "et_eiffel_parser.y"
				yy_do_action_354
			when 355 then
					--|#line 2168 "et_eiffel_parser.y"
				yy_do_action_355
			when 356 then
					--|#line 2170 "et_eiffel_parser.y"
				yy_do_action_356
			when 357 then
					--|#line 2172 "et_eiffel_parser.y"
				yy_do_action_357
			when 358 then
					--|#line 2174 "et_eiffel_parser.y"
				yy_do_action_358
			when 359 then
					--|#line 2176 "et_eiffel_parser.y"
				yy_do_action_359
			when 360 then
					--|#line 2178 "et_eiffel_parser.y"
				yy_do_action_360
			when 361 then
					--|#line 2180 "et_eiffel_parser.y"
				yy_do_action_361
			when 362 then
					--|#line 2182 "et_eiffel_parser.y"
				yy_do_action_362
			when 363 then
					--|#line 2184 "et_eiffel_parser.y"
				yy_do_action_363
			when 364 then
					--|#line 2186 "et_eiffel_parser.y"
				yy_do_action_364
			when 365 then
					--|#line 2188 "et_eiffel_parser.y"
				yy_do_action_365
			when 366 then
					--|#line 2190 "et_eiffel_parser.y"
				yy_do_action_366
			when 367 then
					--|#line 2192 "et_eiffel_parser.y"
				yy_do_action_367
			when 368 then
					--|#line 2194 "et_eiffel_parser.y"
				yy_do_action_368
			when 369 then
					--|#line 2196 "et_eiffel_parser.y"
				yy_do_action_369
			when 370 then
					--|#line 2198 "et_eiffel_parser.y"
				yy_do_action_370
			when 371 then
					--|#line 2200 "et_eiffel_parser.y"
				yy_do_action_371
			when 372 then
					--|#line 2202 "et_eiffel_parser.y"
				yy_do_action_372
			when 373 then
					--|#line 2204 "et_eiffel_parser.y"
				yy_do_action_373
			when 374 then
					--|#line 2207 "et_eiffel_parser.y"
				yy_do_action_374
			when 375 then
					--|#line 2213 "et_eiffel_parser.y"
				yy_do_action_375
			when 376 then
					--|#line 2220 "et_eiffel_parser.y"
				yy_do_action_376
			when 377 then
					--|#line 2222 "et_eiffel_parser.y"
				yy_do_action_377
			when 378 then
					--|#line 2230 "et_eiffel_parser.y"
				yy_do_action_378
			when 379 then
					--|#line 2241 "et_eiffel_parser.y"
				yy_do_action_379
			when 380 then
					--|#line 2248 "et_eiffel_parser.y"
				yy_do_action_380
			when 381 then
					--|#line 2255 "et_eiffel_parser.y"
				yy_do_action_381
			when 382 then
					--|#line 2265 "et_eiffel_parser.y"
				yy_do_action_382
			when 383 then
					--|#line 2276 "et_eiffel_parser.y"
				yy_do_action_383
			when 384 then
					--|#line 2283 "et_eiffel_parser.y"
				yy_do_action_384
			when 385 then
					--|#line 2292 "et_eiffel_parser.y"
				yy_do_action_385
			when 386 then
					--|#line 2301 "et_eiffel_parser.y"
				yy_do_action_386
			when 387 then
					--|#line 2310 "et_eiffel_parser.y"
				yy_do_action_387
			when 388 then
					--|#line 2319 "et_eiffel_parser.y"
				yy_do_action_388
			when 389 then
					--|#line 2330 "et_eiffel_parser.y"
				yy_do_action_389
			when 390 then
					--|#line 2332 "et_eiffel_parser.y"
				yy_do_action_390
			when 391 then
					--|#line 2334 "et_eiffel_parser.y"
				yy_do_action_391
			when 392 then
					--|#line 2334 "et_eiffel_parser.y"
				yy_do_action_392
			when 393 then
					--|#line 2347 "et_eiffel_parser.y"
				yy_do_action_393
			when 394 then
					--|#line 2354 "et_eiffel_parser.y"
				yy_do_action_394
			when 395 then
					--|#line 2361 "et_eiffel_parser.y"
				yy_do_action_395
			when 396 then
					--|#line 2371 "et_eiffel_parser.y"
				yy_do_action_396
			when 397 then
					--|#line 2382 "et_eiffel_parser.y"
				yy_do_action_397
			when 398 then
					--|#line 2389 "et_eiffel_parser.y"
				yy_do_action_398
			when 399 then
					--|#line 2398 "et_eiffel_parser.y"
				yy_do_action_399
			when 400 then
					--|#line 2407 "et_eiffel_parser.y"
				yy_do_action_400
			else
				debug ("GEYACC")
					std.error.put_string ("Error in parser: unknown rule id: ")
					std.error.put_integer (yy_act)
					std.error.put_new_line
				end
				abort
			end
		end

	yy_do_action_401_600 (yy_act: INTEGER) is
			-- Execute semantic action.
		do
			inspect yy_act
			when 401 then
					--|#line 2416 "et_eiffel_parser.y"
				yy_do_action_401
			when 402 then
					--|#line 2425 "et_eiffel_parser.y"
				yy_do_action_402
			when 403 then
					--|#line 2436 "et_eiffel_parser.y"
				yy_do_action_403
			when 404 then
					--|#line 2438 "et_eiffel_parser.y"
				yy_do_action_404
			when 405 then
					--|#line 2440 "et_eiffel_parser.y"
				yy_do_action_405
			when 406 then
					--|#line 2442 "et_eiffel_parser.y"
				yy_do_action_406
			when 407 then
					--|#line 2444 "et_eiffel_parser.y"
				yy_do_action_407
			when 408 then
					--|#line 2446 "et_eiffel_parser.y"
				yy_do_action_408
			when 409 then
					--|#line 2448 "et_eiffel_parser.y"
				yy_do_action_409
			when 410 then
					--|#line 2450 "et_eiffel_parser.y"
				yy_do_action_410
			when 411 then
					--|#line 2454 "et_eiffel_parser.y"
				yy_do_action_411
			when 412 then
					--|#line 2456 "et_eiffel_parser.y"
				yy_do_action_412
			when 413 then
					--|#line 2458 "et_eiffel_parser.y"
				yy_do_action_413
			when 414 then
					--|#line 2460 "et_eiffel_parser.y"
				yy_do_action_414
			when 415 then
					--|#line 2462 "et_eiffel_parser.y"
				yy_do_action_415
			when 416 then
					--|#line 2466 "et_eiffel_parser.y"
				yy_do_action_416
			when 417 then
					--|#line 2468 "et_eiffel_parser.y"
				yy_do_action_417
			when 418 then
					--|#line 2470 "et_eiffel_parser.y"
				yy_do_action_418
			when 419 then
					--|#line 2472 "et_eiffel_parser.y"
				yy_do_action_419
			when 420 then
					--|#line 2474 "et_eiffel_parser.y"
				yy_do_action_420
			when 421 then
					--|#line 2478 "et_eiffel_parser.y"
				yy_do_action_421
			when 422 then
					--|#line 2480 "et_eiffel_parser.y"
				yy_do_action_422
			when 423 then
					--|#line 2484 "et_eiffel_parser.y"
				yy_do_action_423
			when 424 then
					--|#line 2486 "et_eiffel_parser.y"
				yy_do_action_424
			when 425 then
					--|#line 2490 "et_eiffel_parser.y"
				yy_do_action_425
			when 426 then
					--|#line 2494 "et_eiffel_parser.y"
				yy_do_action_426
			when 427 then
					--|#line 2496 "et_eiffel_parser.y"
				yy_do_action_427
			when 428 then
					--|#line 2500 "et_eiffel_parser.y"
				yy_do_action_428
			when 429 then
					--|#line 2502 "et_eiffel_parser.y"
				yy_do_action_429
			when 430 then
					--|#line 2506 "et_eiffel_parser.y"
				yy_do_action_430
			when 431 then
					--|#line 2508 "et_eiffel_parser.y"
				yy_do_action_431
			when 432 then
					--|#line 2510 "et_eiffel_parser.y"
				yy_do_action_432
			when 433 then
					--|#line 2516 "et_eiffel_parser.y"
				yy_do_action_433
			when 434 then
					--|#line 2518 "et_eiffel_parser.y"
				yy_do_action_434
			when 435 then
					--|#line 2524 "et_eiffel_parser.y"
				yy_do_action_435
			when 436 then
					--|#line 2526 "et_eiffel_parser.y"
				yy_do_action_436
			when 437 then
					--|#line 2530 "et_eiffel_parser.y"
				yy_do_action_437
			when 438 then
					--|#line 2532 "et_eiffel_parser.y"
				yy_do_action_438
			when 439 then
					--|#line 2534 "et_eiffel_parser.y"
				yy_do_action_439
			when 440 then
					--|#line 2536 "et_eiffel_parser.y"
				yy_do_action_440
			when 441 then
					--|#line 2538 "et_eiffel_parser.y"
				yy_do_action_441
			when 442 then
					--|#line 2546 "et_eiffel_parser.y"
				yy_do_action_442
			when 443 then
					--|#line 2554 "et_eiffel_parser.y"
				yy_do_action_443
			when 444 then
					--|#line 2556 "et_eiffel_parser.y"
				yy_do_action_444
			when 445 then
					--|#line 2558 "et_eiffel_parser.y"
				yy_do_action_445
			when 446 then
					--|#line 2560 "et_eiffel_parser.y"
				yy_do_action_446
			when 447 then
					--|#line 2562 "et_eiffel_parser.y"
				yy_do_action_447
			when 448 then
					--|#line 2570 "et_eiffel_parser.y"
				yy_do_action_448
			when 449 then
					--|#line 2580 "et_eiffel_parser.y"
				yy_do_action_449
			when 450 then
					--|#line 2582 "et_eiffel_parser.y"
				yy_do_action_450
			when 451 then
					--|#line 2584 "et_eiffel_parser.y"
				yy_do_action_451
			when 452 then
					--|#line 2586 "et_eiffel_parser.y"
				yy_do_action_452
			when 453 then
					--|#line 2588 "et_eiffel_parser.y"
				yy_do_action_453
			when 454 then
					--|#line 2596 "et_eiffel_parser.y"
				yy_do_action_454
			when 455 then
					--|#line 2604 "et_eiffel_parser.y"
				yy_do_action_455
			when 456 then
					--|#line 2606 "et_eiffel_parser.y"
				yy_do_action_456
			when 457 then
					--|#line 2608 "et_eiffel_parser.y"
				yy_do_action_457
			when 458 then
					--|#line 2610 "et_eiffel_parser.y"
				yy_do_action_458
			when 459 then
					--|#line 2612 "et_eiffel_parser.y"
				yy_do_action_459
			when 460 then
					--|#line 2620 "et_eiffel_parser.y"
				yy_do_action_460
			when 461 then
					--|#line 2630 "et_eiffel_parser.y"
				yy_do_action_461
			when 462 then
					--|#line 2632 "et_eiffel_parser.y"
				yy_do_action_462
			when 463 then
					--|#line 2634 "et_eiffel_parser.y"
				yy_do_action_463
			when 464 then
					--|#line 2636 "et_eiffel_parser.y"
				yy_do_action_464
			when 465 then
					--|#line 2638 "et_eiffel_parser.y"
				yy_do_action_465
			when 466 then
					--|#line 2640 "et_eiffel_parser.y"
				yy_do_action_466
			when 467 then
					--|#line 2648 "et_eiffel_parser.y"
				yy_do_action_467
			when 468 then
					--|#line 2656 "et_eiffel_parser.y"
				yy_do_action_468
			when 469 then
					--|#line 2658 "et_eiffel_parser.y"
				yy_do_action_469
			when 470 then
					--|#line 2660 "et_eiffel_parser.y"
				yy_do_action_470
			when 471 then
					--|#line 2662 "et_eiffel_parser.y"
				yy_do_action_471
			when 472 then
					--|#line 2664 "et_eiffel_parser.y"
				yy_do_action_472
			when 473 then
					--|#line 2672 "et_eiffel_parser.y"
				yy_do_action_473
			when 474 then
					--|#line 2682 "et_eiffel_parser.y"
				yy_do_action_474
			when 475 then
					--|#line 2686 "et_eiffel_parser.y"
				yy_do_action_475
			when 476 then
					--|#line 2688 "et_eiffel_parser.y"
				yy_do_action_476
			when 477 then
					--|#line 2692 "et_eiffel_parser.y"
				yy_do_action_477
			when 478 then
					--|#line 2695 "et_eiffel_parser.y"
				yy_do_action_478
			when 479 then
					--|#line 2703 "et_eiffel_parser.y"
				yy_do_action_479
			when 480 then
					--|#line 2710 "et_eiffel_parser.y"
				yy_do_action_480
			when 481 then
					--|#line 2721 "et_eiffel_parser.y"
				yy_do_action_481
			when 482 then
					--|#line 2726 "et_eiffel_parser.y"
				yy_do_action_482
			when 483 then
					--|#line 2731 "et_eiffel_parser.y"
				yy_do_action_483
			when 484 then
					--|#line 2738 "et_eiffel_parser.y"
				yy_do_action_484
			when 485 then
					--|#line 2744 "et_eiffel_parser.y"
				yy_do_action_485
			when 486 then
					--|#line 2753 "et_eiffel_parser.y"
				yy_do_action_486
			when 487 then
					--|#line 2755 "et_eiffel_parser.y"
				yy_do_action_487
			when 488 then
					--|#line 2759 "et_eiffel_parser.y"
				yy_do_action_488
			when 489 then
					--|#line 2762 "et_eiffel_parser.y"
				yy_do_action_489
			when 490 then
					--|#line 2768 "et_eiffel_parser.y"
				yy_do_action_490
			when 491 then
					--|#line 2776 "et_eiffel_parser.y"
				yy_do_action_491
			when 492 then
					--|#line 2781 "et_eiffel_parser.y"
				yy_do_action_492
			when 493 then
					--|#line 2786 "et_eiffel_parser.y"
				yy_do_action_493
			when 494 then
					--|#line 2791 "et_eiffel_parser.y"
				yy_do_action_494
			when 495 then
					--|#line 2802 "et_eiffel_parser.y"
				yy_do_action_495
			when 496 then
					--|#line 2813 "et_eiffel_parser.y"
				yy_do_action_496
			when 497 then
					--|#line 2826 "et_eiffel_parser.y"
				yy_do_action_497
			when 498 then
					--|#line 2835 "et_eiffel_parser.y"
				yy_do_action_498
			when 499 then
					--|#line 2844 "et_eiffel_parser.y"
				yy_do_action_499
			when 500 then
					--|#line 2846 "et_eiffel_parser.y"
				yy_do_action_500
			when 501 then
					--|#line 2854 "et_eiffel_parser.y"
				yy_do_action_501
			when 502 then
					--|#line 2862 "et_eiffel_parser.y"
				yy_do_action_502
			when 503 then
					--|#line 2864 "et_eiffel_parser.y"
				yy_do_action_503
			when 504 then
					--|#line 2872 "et_eiffel_parser.y"
				yy_do_action_504
			when 505 then
					--|#line 2880 "et_eiffel_parser.y"
				yy_do_action_505
			when 506 then
					--|#line 2884 "et_eiffel_parser.y"
				yy_do_action_506
			when 507 then
					--|#line 2892 "et_eiffel_parser.y"
				yy_do_action_507
			when 508 then
					--|#line 2902 "et_eiffel_parser.y"
				yy_do_action_508
			when 509 then
					--|#line 2912 "et_eiffel_parser.y"
				yy_do_action_509
			when 510 then
					--|#line 2924 "et_eiffel_parser.y"
				yy_do_action_510
			when 511 then
					--|#line 2926 "et_eiffel_parser.y"
				yy_do_action_511
			when 512 then
					--|#line 2933 "et_eiffel_parser.y"
				yy_do_action_512
			when 513 then
					--|#line 2935 "et_eiffel_parser.y"
				yy_do_action_513
			when 514 then
					--|#line 2942 "et_eiffel_parser.y"
				yy_do_action_514
			when 515 then
					--|#line 2944 "et_eiffel_parser.y"
				yy_do_action_515
			when 516 then
					--|#line 2951 "et_eiffel_parser.y"
				yy_do_action_516
			when 517 then
					--|#line 2953 "et_eiffel_parser.y"
				yy_do_action_517
			when 518 then
					--|#line 2960 "et_eiffel_parser.y"
				yy_do_action_518
			when 519 then
					--|#line 2962 "et_eiffel_parser.y"
				yy_do_action_519
			when 520 then
					--|#line 2969 "et_eiffel_parser.y"
				yy_do_action_520
			when 521 then
					--|#line 2971 "et_eiffel_parser.y"
				yy_do_action_521
			when 522 then
					--|#line 2978 "et_eiffel_parser.y"
				yy_do_action_522
			when 523 then
					--|#line 2980 "et_eiffel_parser.y"
				yy_do_action_523
			when 524 then
					--|#line 2987 "et_eiffel_parser.y"
				yy_do_action_524
			when 525 then
					--|#line 2998 "et_eiffel_parser.y"
				yy_do_action_525
			when 526 then
					--|#line 2998 "et_eiffel_parser.y"
				yy_do_action_526
			when 527 then
					--|#line 3019 "et_eiffel_parser.y"
				yy_do_action_527
			when 528 then
					--|#line 3021 "et_eiffel_parser.y"
				yy_do_action_528
			when 529 then
					--|#line 3023 "et_eiffel_parser.y"
				yy_do_action_529
			when 530 then
					--|#line 3025 "et_eiffel_parser.y"
				yy_do_action_530
			when 531 then
					--|#line 3027 "et_eiffel_parser.y"
				yy_do_action_531
			when 532 then
					--|#line 3029 "et_eiffel_parser.y"
				yy_do_action_532
			when 533 then
					--|#line 3031 "et_eiffel_parser.y"
				yy_do_action_533
			when 534 then
					--|#line 3033 "et_eiffel_parser.y"
				yy_do_action_534
			when 535 then
					--|#line 3035 "et_eiffel_parser.y"
				yy_do_action_535
			when 536 then
					--|#line 3037 "et_eiffel_parser.y"
				yy_do_action_536
			when 537 then
					--|#line 3039 "et_eiffel_parser.y"
				yy_do_action_537
			when 538 then
					--|#line 3047 "et_eiffel_parser.y"
				yy_do_action_538
			when 539 then
					--|#line 3060 "et_eiffel_parser.y"
				yy_do_action_539
			when 540 then
					--|#line 3062 "et_eiffel_parser.y"
				yy_do_action_540
			when 541 then
					--|#line 3064 "et_eiffel_parser.y"
				yy_do_action_541
			when 542 then
					--|#line 3066 "et_eiffel_parser.y"
				yy_do_action_542
			when 543 then
					--|#line 3068 "et_eiffel_parser.y"
				yy_do_action_543
			when 544 then
					--|#line 3074 "et_eiffel_parser.y"
				yy_do_action_544
			when 545 then
					--|#line 3076 "et_eiffel_parser.y"
				yy_do_action_545
			when 546 then
					--|#line 3078 "et_eiffel_parser.y"
				yy_do_action_546
			when 547 then
					--|#line 3080 "et_eiffel_parser.y"
				yy_do_action_547
			when 548 then
					--|#line 3084 "et_eiffel_parser.y"
				yy_do_action_548
			when 549 then
					--|#line 3086 "et_eiffel_parser.y"
				yy_do_action_549
			when 550 then
					--|#line 3088 "et_eiffel_parser.y"
				yy_do_action_550
			when 551 then
					--|#line 3090 "et_eiffel_parser.y"
				yy_do_action_551
			when 552 then
					--|#line 3094 "et_eiffel_parser.y"
				yy_do_action_552
			when 553 then
					--|#line 3096 "et_eiffel_parser.y"
				yy_do_action_553
			when 554 then
					--|#line 3102 "et_eiffel_parser.y"
				yy_do_action_554
			when 555 then
					--|#line 3104 "et_eiffel_parser.y"
				yy_do_action_555
			when 556 then
					--|#line 3106 "et_eiffel_parser.y"
				yy_do_action_556
			when 557 then
					--|#line 3108 "et_eiffel_parser.y"
				yy_do_action_557
			when 558 then
					--|#line 3112 "et_eiffel_parser.y"
				yy_do_action_558
			when 559 then
					--|#line 3119 "et_eiffel_parser.y"
				yy_do_action_559
			when 560 then
					--|#line 3126 "et_eiffel_parser.y"
				yy_do_action_560
			when 561 then
					--|#line 3135 "et_eiffel_parser.y"
				yy_do_action_561
			when 562 then
					--|#line 3146 "et_eiffel_parser.y"
				yy_do_action_562
			when 563 then
					--|#line 3148 "et_eiffel_parser.y"
				yy_do_action_563
			when 564 then
					--|#line 3152 "et_eiffel_parser.y"
				yy_do_action_564
			when 565 then
					--|#line 3154 "et_eiffel_parser.y"
				yy_do_action_565
			when 566 then
					--|#line 3161 "et_eiffel_parser.y"
				yy_do_action_566
			when 567 then
					--|#line 3168 "et_eiffel_parser.y"
				yy_do_action_567
			when 568 then
					--|#line 3177 "et_eiffel_parser.y"
				yy_do_action_568
			when 569 then
					--|#line 3186 "et_eiffel_parser.y"
				yy_do_action_569
			when 570 then
					--|#line 3188 "et_eiffel_parser.y"
				yy_do_action_570
			when 571 then
					--|#line 3188 "et_eiffel_parser.y"
				yy_do_action_571
			when 572 then
					--|#line 3201 "et_eiffel_parser.y"
				yy_do_action_572
			when 573 then
					--|#line 3212 "et_eiffel_parser.y"
				yy_do_action_573
			when 574 then
					--|#line 3220 "et_eiffel_parser.y"
				yy_do_action_574
			when 575 then
					--|#line 3229 "et_eiffel_parser.y"
				yy_do_action_575
			when 576 then
					--|#line 3238 "et_eiffel_parser.y"
				yy_do_action_576
			when 577 then
					--|#line 3240 "et_eiffel_parser.y"
				yy_do_action_577
			when 578 then
					--|#line 3244 "et_eiffel_parser.y"
				yy_do_action_578
			when 579 then
					--|#line 3246 "et_eiffel_parser.y"
				yy_do_action_579
			when 580 then
					--|#line 3248 "et_eiffel_parser.y"
				yy_do_action_580
			when 581 then
					--|#line 3250 "et_eiffel_parser.y"
				yy_do_action_581
			when 582 then
					--|#line 3256 "et_eiffel_parser.y"
				yy_do_action_582
			when 583 then
					--|#line 3258 "et_eiffel_parser.y"
				yy_do_action_583
			when 584 then
					--|#line 3265 "et_eiffel_parser.y"
				yy_do_action_584
			when 585 then
					--|#line 3267 "et_eiffel_parser.y"
				yy_do_action_585
			when 586 then
					--|#line 3269 "et_eiffel_parser.y"
				yy_do_action_586
			when 587 then
					--|#line 3269 "et_eiffel_parser.y"
				yy_do_action_587
			when 588 then
					--|#line 3282 "et_eiffel_parser.y"
				yy_do_action_588
			when 589 then
					--|#line 3293 "et_eiffel_parser.y"
				yy_do_action_589
			when 590 then
					--|#line 3302 "et_eiffel_parser.y"
				yy_do_action_590
			when 591 then
					--|#line 3313 "et_eiffel_parser.y"
				yy_do_action_591
			when 592 then
					--|#line 3315 "et_eiffel_parser.y"
				yy_do_action_592
			when 593 then
					--|#line 3317 "et_eiffel_parser.y"
				yy_do_action_593
			when 594 then
					--|#line 3319 "et_eiffel_parser.y"
				yy_do_action_594
			when 595 then
					--|#line 3321 "et_eiffel_parser.y"
				yy_do_action_595
			when 596 then
					--|#line 3323 "et_eiffel_parser.y"
				yy_do_action_596
			when 597 then
					--|#line 3327 "et_eiffel_parser.y"
				yy_do_action_597
			when 598 then
					--|#line 3329 "et_eiffel_parser.y"
				yy_do_action_598
			when 599 then
					--|#line 3333 "et_eiffel_parser.y"
				yy_do_action_599
			when 600 then
					--|#line 3337 "et_eiffel_parser.y"
				yy_do_action_600
			else
				debug ("GEYACC")
					std.error.put_string ("Error in parser: unknown rule id: ")
					std.error.put_integer (yy_act)
					std.error.put_new_line
				end
				abort
			end
		end

	yy_do_action_601_800 (yy_act: INTEGER) is
			-- Execute semantic action.
		do
			inspect yy_act
			when 601 then
					--|#line 3339 "et_eiffel_parser.y"
				yy_do_action_601
			when 602 then
					--|#line 3343 "et_eiffel_parser.y"
				yy_do_action_602
			when 603 then
					--|#line 3345 "et_eiffel_parser.y"
				yy_do_action_603
			when 604 then
					--|#line 3349 "et_eiffel_parser.y"
				yy_do_action_604
			when 605 then
					--|#line 3351 "et_eiffel_parser.y"
				yy_do_action_605
			when 606 then
					--|#line 3353 "et_eiffel_parser.y"
				yy_do_action_606
			when 607 then
					--|#line 3355 "et_eiffel_parser.y"
				yy_do_action_607
			when 608 then
					--|#line 3357 "et_eiffel_parser.y"
				yy_do_action_608
			when 609 then
					--|#line 3359 "et_eiffel_parser.y"
				yy_do_action_609
			when 610 then
					--|#line 3367 "et_eiffel_parser.y"
				yy_do_action_610
			when 611 then
					--|#line 3369 "et_eiffel_parser.y"
				yy_do_action_611
			when 612 then
					--|#line 3375 "et_eiffel_parser.y"
				yy_do_action_612
			when 613 then
					--|#line 3377 "et_eiffel_parser.y"
				yy_do_action_613
			when 614 then
					--|#line 3379 "et_eiffel_parser.y"
				yy_do_action_614
			when 615 then
					--|#line 3379 "et_eiffel_parser.y"
				yy_do_action_615
			when 616 then
					--|#line 3392 "et_eiffel_parser.y"
				yy_do_action_616
			when 617 then
					--|#line 3403 "et_eiffel_parser.y"
				yy_do_action_617
			when 618 then
					--|#line 3411 "et_eiffel_parser.y"
				yy_do_action_618
			when 619 then
					--|#line 3420 "et_eiffel_parser.y"
				yy_do_action_619
			when 620 then
					--|#line 3429 "et_eiffel_parser.y"
				yy_do_action_620
			when 621 then
					--|#line 3431 "et_eiffel_parser.y"
				yy_do_action_621
			when 622 then
					--|#line 3433 "et_eiffel_parser.y"
				yy_do_action_622
			when 623 then
					--|#line 3435 "et_eiffel_parser.y"
				yy_do_action_623
			when 624 then
					--|#line 3442 "et_eiffel_parser.y"
				yy_do_action_624
			when 625 then
					--|#line 3444 "et_eiffel_parser.y"
				yy_do_action_625
			when 626 then
					--|#line 3450 "et_eiffel_parser.y"
				yy_do_action_626
			when 627 then
					--|#line 3452 "et_eiffel_parser.y"
				yy_do_action_627
			when 628 then
					--|#line 3456 "et_eiffel_parser.y"
				yy_do_action_628
			when 629 then
					--|#line 3458 "et_eiffel_parser.y"
				yy_do_action_629
			when 630 then
					--|#line 3460 "et_eiffel_parser.y"
				yy_do_action_630
			when 631 then
					--|#line 3462 "et_eiffel_parser.y"
				yy_do_action_631
			when 632 then
					--|#line 3464 "et_eiffel_parser.y"
				yy_do_action_632
			when 633 then
					--|#line 3466 "et_eiffel_parser.y"
				yy_do_action_633
			when 634 then
					--|#line 3468 "et_eiffel_parser.y"
				yy_do_action_634
			when 635 then
					--|#line 3470 "et_eiffel_parser.y"
				yy_do_action_635
			when 636 then
					--|#line 3472 "et_eiffel_parser.y"
				yy_do_action_636
			when 637 then
					--|#line 3474 "et_eiffel_parser.y"
				yy_do_action_637
			when 638 then
					--|#line 3476 "et_eiffel_parser.y"
				yy_do_action_638
			when 639 then
					--|#line 3478 "et_eiffel_parser.y"
				yy_do_action_639
			when 640 then
					--|#line 3480 "et_eiffel_parser.y"
				yy_do_action_640
			when 641 then
					--|#line 3482 "et_eiffel_parser.y"
				yy_do_action_641
			when 642 then
					--|#line 3484 "et_eiffel_parser.y"
				yy_do_action_642
			when 643 then
					--|#line 3486 "et_eiffel_parser.y"
				yy_do_action_643
			when 644 then
					--|#line 3488 "et_eiffel_parser.y"
				yy_do_action_644
			when 645 then
					--|#line 3490 "et_eiffel_parser.y"
				yy_do_action_645
			when 646 then
					--|#line 3492 "et_eiffel_parser.y"
				yy_do_action_646
			when 647 then
					--|#line 3494 "et_eiffel_parser.y"
				yy_do_action_647
			when 648 then
					--|#line 3496 "et_eiffel_parser.y"
				yy_do_action_648
			when 649 then
					--|#line 3498 "et_eiffel_parser.y"
				yy_do_action_649
			when 650 then
					--|#line 3502 "et_eiffel_parser.y"
				yy_do_action_650
			when 651 then
					--|#line 3504 "et_eiffel_parser.y"
				yy_do_action_651
			when 652 then
					--|#line 3506 "et_eiffel_parser.y"
				yy_do_action_652
			when 653 then
					--|#line 3508 "et_eiffel_parser.y"
				yy_do_action_653
			when 654 then
					--|#line 3510 "et_eiffel_parser.y"
				yy_do_action_654
			when 655 then
					--|#line 3512 "et_eiffel_parser.y"
				yy_do_action_655
			when 656 then
					--|#line 3514 "et_eiffel_parser.y"
				yy_do_action_656
			when 657 then
					--|#line 3516 "et_eiffel_parser.y"
				yy_do_action_657
			when 658 then
					--|#line 3518 "et_eiffel_parser.y"
				yy_do_action_658
			when 659 then
					--|#line 3520 "et_eiffel_parser.y"
				yy_do_action_659
			when 660 then
					--|#line 3530 "et_eiffel_parser.y"
				yy_do_action_660
			when 661 then
					--|#line 3532 "et_eiffel_parser.y"
				yy_do_action_661
			when 662 then
					--|#line 3534 "et_eiffel_parser.y"
				yy_do_action_662
			when 663 then
					--|#line 3536 "et_eiffel_parser.y"
				yy_do_action_663
			when 664 then
					--|#line 3538 "et_eiffel_parser.y"
				yy_do_action_664
			when 665 then
					--|#line 3540 "et_eiffel_parser.y"
				yy_do_action_665
			when 666 then
					--|#line 3542 "et_eiffel_parser.y"
				yy_do_action_666
			when 667 then
					--|#line 3544 "et_eiffel_parser.y"
				yy_do_action_667
			when 668 then
					--|#line 3546 "et_eiffel_parser.y"
				yy_do_action_668
			when 669 then
					--|#line 3548 "et_eiffel_parser.y"
				yy_do_action_669
			when 670 then
					--|#line 3550 "et_eiffel_parser.y"
				yy_do_action_670
			when 671 then
					--|#line 3552 "et_eiffel_parser.y"
				yy_do_action_671
			when 672 then
					--|#line 3554 "et_eiffel_parser.y"
				yy_do_action_672
			when 673 then
					--|#line 3556 "et_eiffel_parser.y"
				yy_do_action_673
			when 674 then
					--|#line 3558 "et_eiffel_parser.y"
				yy_do_action_674
			when 675 then
					--|#line 3560 "et_eiffel_parser.y"
				yy_do_action_675
			when 676 then
					--|#line 3562 "et_eiffel_parser.y"
				yy_do_action_676
			when 677 then
					--|#line 3564 "et_eiffel_parser.y"
				yy_do_action_677
			when 678 then
					--|#line 3579 "et_eiffel_parser.y"
				yy_do_action_678
			when 679 then
					--|#line 3581 "et_eiffel_parser.y"
				yy_do_action_679
			when 680 then
					--|#line 3583 "et_eiffel_parser.y"
				yy_do_action_680
			when 681 then
					--|#line 3585 "et_eiffel_parser.y"
				yy_do_action_681
			when 682 then
					--|#line 3589 "et_eiffel_parser.y"
				yy_do_action_682
			when 683 then
					--|#line 3589 "et_eiffel_parser.y"
				yy_do_action_683
			when 684 then
					--|#line 3602 "et_eiffel_parser.y"
				yy_do_action_684
			when 685 then
					--|#line 3613 "et_eiffel_parser.y"
				yy_do_action_685
			when 686 then
					--|#line 3621 "et_eiffel_parser.y"
				yy_do_action_686
			when 687 then
					--|#line 3630 "et_eiffel_parser.y"
				yy_do_action_687
			when 688 then
					--|#line 3638 "et_eiffel_parser.y"
				yy_do_action_688
			when 689 then
					--|#line 3642 "et_eiffel_parser.y"
				yy_do_action_689
			when 690 then
					--|#line 3644 "et_eiffel_parser.y"
				yy_do_action_690
			when 691 then
					--|#line 3644 "et_eiffel_parser.y"
				yy_do_action_691
			when 692 then
					--|#line 3657 "et_eiffel_parser.y"
				yy_do_action_692
			when 693 then
					--|#line 3668 "et_eiffel_parser.y"
				yy_do_action_693
			when 694 then
					--|#line 3676 "et_eiffel_parser.y"
				yy_do_action_694
			when 695 then
					--|#line 3685 "et_eiffel_parser.y"
				yy_do_action_695
			when 696 then
					--|#line 3687 "et_eiffel_parser.y"
				yy_do_action_696
			when 697 then
					--|#line 3687 "et_eiffel_parser.y"
				yy_do_action_697
			when 698 then
					--|#line 3700 "et_eiffel_parser.y"
				yy_do_action_698
			when 699 then
					--|#line 3711 "et_eiffel_parser.y"
				yy_do_action_699
			when 700 then
					--|#line 3719 "et_eiffel_parser.y"
				yy_do_action_700
			when 701 then
					--|#line 3728 "et_eiffel_parser.y"
				yy_do_action_701
			when 702 then
					--|#line 3730 "et_eiffel_parser.y"
				yy_do_action_702
			when 703 then
					--|#line 3730 "et_eiffel_parser.y"
				yy_do_action_703
			when 704 then
					--|#line 3745 "et_eiffel_parser.y"
				yy_do_action_704
			when 705 then
					--|#line 3756 "et_eiffel_parser.y"
				yy_do_action_705
			when 706 then
					--|#line 3764 "et_eiffel_parser.y"
				yy_do_action_706
			when 707 then
					--|#line 3773 "et_eiffel_parser.y"
				yy_do_action_707
			when 708 then
					--|#line 3775 "et_eiffel_parser.y"
				yy_do_action_708
			when 709 then
					--|#line 3777 "et_eiffel_parser.y"
				yy_do_action_709
			when 710 then
					--|#line 3779 "et_eiffel_parser.y"
				yy_do_action_710
			when 711 then
					--|#line 3781 "et_eiffel_parser.y"
				yy_do_action_711
			when 712 then
					--|#line 3783 "et_eiffel_parser.y"
				yy_do_action_712
			when 713 then
					--|#line 3789 "et_eiffel_parser.y"
				yy_do_action_713
			when 714 then
					--|#line 3791 "et_eiffel_parser.y"
				yy_do_action_714
			when 715 then
					--|#line 3795 "et_eiffel_parser.y"
				yy_do_action_715
			when 716 then
					--|#line 3806 "et_eiffel_parser.y"
				yy_do_action_716
			when 717 then
					--|#line 3813 "et_eiffel_parser.y"
				yy_do_action_717
			when 718 then
					--|#line 3820 "et_eiffel_parser.y"
				yy_do_action_718
			when 719 then
					--|#line 3827 "et_eiffel_parser.y"
				yy_do_action_719
			when 720 then
					--|#line 3834 "et_eiffel_parser.y"
				yy_do_action_720
			when 721 then
					--|#line 3841 "et_eiffel_parser.y"
				yy_do_action_721
			when 722 then
					--|#line 3848 "et_eiffel_parser.y"
				yy_do_action_722
			when 723 then
					--|#line 3855 "et_eiffel_parser.y"
				yy_do_action_723
			when 724 then
					--|#line 3862 "et_eiffel_parser.y"
				yy_do_action_724
			when 725 then
					--|#line 3869 "et_eiffel_parser.y"
				yy_do_action_725
			when 726 then
					--|#line 3876 "et_eiffel_parser.y"
				yy_do_action_726
			when 727 then
					--|#line 3885 "et_eiffel_parser.y"
				yy_do_action_727
			when 728 then
					--|#line 3892 "et_eiffel_parser.y"
				yy_do_action_728
			when 729 then
					--|#line 3896 "et_eiffel_parser.y"
				yy_do_action_729
			when 730 then
					--|#line 3908 "et_eiffel_parser.y"
				yy_do_action_730
			when 731 then
					--|#line 3910 "et_eiffel_parser.y"
				yy_do_action_731
			when 732 then
					--|#line 3912 "et_eiffel_parser.y"
				yy_do_action_732
			when 733 then
					--|#line 3914 "et_eiffel_parser.y"
				yy_do_action_733
			when 734 then
					--|#line 3916 "et_eiffel_parser.y"
				yy_do_action_734
			when 735 then
					--|#line 3920 "et_eiffel_parser.y"
				yy_do_action_735
			when 736 then
					--|#line 3922 "et_eiffel_parser.y"
				yy_do_action_736
			when 737 then
					--|#line 3924 "et_eiffel_parser.y"
				yy_do_action_737
			when 738 then
					--|#line 3924 "et_eiffel_parser.y"
				yy_do_action_738
			when 739 then
					--|#line 3937 "et_eiffel_parser.y"
				yy_do_action_739
			when 740 then
					--|#line 3948 "et_eiffel_parser.y"
				yy_do_action_740
			when 741 then
					--|#line 3956 "et_eiffel_parser.y"
				yy_do_action_741
			when 742 then
					--|#line 3965 "et_eiffel_parser.y"
				yy_do_action_742
			when 743 then
					--|#line 3974 "et_eiffel_parser.y"
				yy_do_action_743
			when 744 then
					--|#line 3976 "et_eiffel_parser.y"
				yy_do_action_744
			when 745 then
					--|#line 3978 "et_eiffel_parser.y"
				yy_do_action_745
			when 746 then
					--|#line 3984 "et_eiffel_parser.y"
				yy_do_action_746
			when 747 then
					--|#line 3986 "et_eiffel_parser.y"
				yy_do_action_747
			when 748 then
					--|#line 3988 "et_eiffel_parser.y"
				yy_do_action_748
			when 749 then
					--|#line 3990 "et_eiffel_parser.y"
				yy_do_action_749
			when 750 then
					--|#line 3992 "et_eiffel_parser.y"
				yy_do_action_750
			when 751 then
					--|#line 3994 "et_eiffel_parser.y"
				yy_do_action_751
			when 752 then
					--|#line 3996 "et_eiffel_parser.y"
				yy_do_action_752
			when 753 then
					--|#line 3998 "et_eiffel_parser.y"
				yy_do_action_753
			when 754 then
					--|#line 4000 "et_eiffel_parser.y"
				yy_do_action_754
			when 755 then
					--|#line 4002 "et_eiffel_parser.y"
				yy_do_action_755
			when 756 then
					--|#line 4004 "et_eiffel_parser.y"
				yy_do_action_756
			when 757 then
					--|#line 4006 "et_eiffel_parser.y"
				yy_do_action_757
			when 758 then
					--|#line 4008 "et_eiffel_parser.y"
				yy_do_action_758
			when 759 then
					--|#line 4010 "et_eiffel_parser.y"
				yy_do_action_759
			when 760 then
					--|#line 4012 "et_eiffel_parser.y"
				yy_do_action_760
			when 761 then
					--|#line 4014 "et_eiffel_parser.y"
				yy_do_action_761
			when 762 then
					--|#line 4016 "et_eiffel_parser.y"
				yy_do_action_762
			when 763 then
					--|#line 4018 "et_eiffel_parser.y"
				yy_do_action_763
			when 764 then
					--|#line 4020 "et_eiffel_parser.y"
				yy_do_action_764
			when 765 then
					--|#line 4022 "et_eiffel_parser.y"
				yy_do_action_765
			when 766 then
					--|#line 4024 "et_eiffel_parser.y"
				yy_do_action_766
			when 767 then
					--|#line 4026 "et_eiffel_parser.y"
				yy_do_action_767
			when 768 then
					--|#line 4028 "et_eiffel_parser.y"
				yy_do_action_768
			when 769 then
					--|#line 4032 "et_eiffel_parser.y"
				yy_do_action_769
			when 770 then
					--|#line 4034 "et_eiffel_parser.y"
				yy_do_action_770
			when 771 then
					--|#line 4038 "et_eiffel_parser.y"
				yy_do_action_771
			when 772 then
					--|#line 4040 "et_eiffel_parser.y"
				yy_do_action_772
			when 773 then
					--|#line 4044 "et_eiffel_parser.y"
				yy_do_action_773
			when 774 then
					--|#line 4046 "et_eiffel_parser.y"
				yy_do_action_774
			when 775 then
					--|#line 4050 "et_eiffel_parser.y"
				yy_do_action_775
			when 776 then
					--|#line 4052 "et_eiffel_parser.y"
				yy_do_action_776
			when 777 then
					--|#line 4056 "et_eiffel_parser.y"
				yy_do_action_777
			when 778 then
					--|#line 4061 "et_eiffel_parser.y"
				yy_do_action_778
			when 779 then
					--|#line 4068 "et_eiffel_parser.y"
				yy_do_action_779
			when 780 then
					--|#line 4075 "et_eiffel_parser.y"
				yy_do_action_780
			when 781 then
					--|#line 4077 "et_eiffel_parser.y"
				yy_do_action_781
			when 782 then
					--|#line 4081 "et_eiffel_parser.y"
				yy_do_action_782
			when 783 then
					--|#line 4083 "et_eiffel_parser.y"
				yy_do_action_783
			when 784 then
					--|#line 4087 "et_eiffel_parser.y"
				yy_do_action_784
			when 785 then
					--|#line 4092 "et_eiffel_parser.y"
				yy_do_action_785
			when 786 then
					--|#line 4099 "et_eiffel_parser.y"
				yy_do_action_786
			when 787 then
					--|#line 4106 "et_eiffel_parser.y"
				yy_do_action_787
			when 788 then
					--|#line 4108 "et_eiffel_parser.y"
				yy_do_action_788
			when 789 then
					--|#line 4110 "et_eiffel_parser.y"
				yy_do_action_789
			when 790 then
					--|#line 4119 "et_eiffel_parser.y"
				yy_do_action_790
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
			--|#line 222 "et_eiffel_parser.y"
		local
			yyval1: ANY
		do
--|#line 222 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 222")
end

			-- END
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp1 := yyvsp1 + 1
	yyvsp42 := yyvsp42 -1
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
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_2 is
			--|#line 226 "et_eiffel_parser.y"
		local
			yyval1: ANY
		do
--|#line 226 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 226")
end

			if yyvs42.item (yyvsp42) /= Void then
				yyvs42.item (yyvsp42).set_leading_break (yyvs9.item (yyvsp9))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 + 1
	yyvsp9 := yyvsp9 -1
	yyvsp42 := yyvsp42 -1
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
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_3 is
			--|#line 234 "et_eiffel_parser.y"
		local
			yyval42: ET_CLASS
		do
--|#line 234 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 234")
end

			yyval42 := yyvs42.item (yyvsp42)
			if yyval42 /= Void then
				yyval42.set_first_indexing (yyvs78.item (yyvsp78))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp78 := yyvsp78 -1
	yyvs42.put (yyval42, yyvsp42)
end
		end

	yy_do_action_4 is
			--|#line 243 "et_eiffel_parser.y"
		local
			yyval1: ANY
		do
--|#line 243 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 243")
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
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_5 is
			--|#line 244 "et_eiffel_parser.y"
		local
			yyval1: ANY
		do
--|#line 244 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 244")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp42 := yyvsp42 -1
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_6 is
			--|#line 244 "et_eiffel_parser.y"
		local
			yyval1: ANY
		do
--|#line 244 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 244")
end

			if not current_system.preparse_multiple_mode then
					-- Raise syntax error: it is not valid to have more
					-- than one class text in the same file.
				raise_error
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
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_7 is
			--|#line 255 "et_eiffel_parser.y"
		local
			yyval42: ET_CLASS
		do
--|#line 255 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 255")
end

			yyval42 := yyvs42.item (yyvsp42)
			set_class_to_end (yyval42, yyvs98.item (yyvsp98), yyvs102.item (yyvsp102), yyvs56.item (yyvsp56), yyvs53.item (yyvsp53), yyvs67.item (yyvsp67), yyvs86.item (yyvsp86), yyvs78.item (yyvsp78), yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 12
	yyvsp76 := yyvsp76 -1
	yyvsp98 := yyvsp98 -1
	yyvsp102 := yyvsp102 -1
	yyvsp56 := yyvsp56 -1
	yyvsp53 := yyvsp53 -1
	yyvsp67 := yyvsp67 -1
	yyvsp86 := yyvsp86 -1
	yyvsp78 := yyvsp78 -1
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -2
	yyvs42.put (yyval42, yyvsp42)
end
		end

	yy_do_action_8 is
			--|#line 261 "et_eiffel_parser.y"
		local
			yyval42: ET_CLASS
		do
--|#line 261 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 261")
end

			yyval42 := yyvs42.item (yyvsp42)
			set_class_to_end (yyval42, yyvs98.item (yyvsp98), yyvs102.item (yyvsp102), yyvs56.item (yyvsp56), yyvs53.item (yyvsp53), yyvs67.item (yyvsp67), yyvs86.item (yyvsp86), yyvs78.item (yyvsp78), yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 12
	yyvsp76 := yyvsp76 -1
	yyvsp98 := yyvsp98 -1
	yyvsp102 := yyvsp102 -1
	yyvsp56 := yyvsp56 -1
	yyvsp53 := yyvsp53 -1
	yyvsp67 := yyvsp67 -1
	yyvsp86 := yyvsp86 -1
	yyvsp78 := yyvsp78 -1
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -2
	yyvs42.put (yyval42, yyvsp42)
end
		end

	yy_do_action_9 is
			--|#line 267 "et_eiffel_parser.y"
		local
			yyval42: ET_CLASS
		do
--|#line 267 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 267")
end

			yyval42 := yyvs42.item (yyvsp42)
			set_class_to_end (yyval42, yyvs98.item (yyvsp98), yyvs102.item (yyvsp102), Void, yyvs53.item (yyvsp53), yyvs67.item (yyvsp67), yyvs86.item (yyvsp86), yyvs78.item (yyvsp78), yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 11
	yyvsp76 := yyvsp76 -1
	yyvsp98 := yyvsp98 -1
	yyvsp102 := yyvsp102 -1
	yyvsp53 := yyvsp53 -1
	yyvsp67 := yyvsp67 -1
	yyvsp86 := yyvsp86 -1
	yyvsp78 := yyvsp78 -1
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -2
	yyvs42.put (yyval42, yyvsp42)
end
		end

	yy_do_action_10 is
			--|#line 273 "et_eiffel_parser.y"
		local
			yyval42: ET_CLASS
		do
--|#line 273 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 273")
end

			yyval42 := yyvs42.item (yyvsp42)
			set_class_to_end (yyval42, yyvs98.item (yyvsp98), yyvs102.item (yyvsp102), Void, Void, yyvs67.item (yyvsp67), yyvs86.item (yyvsp86), yyvs78.item (yyvsp78), yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 10
	yyvsp76 := yyvsp76 -1
	yyvsp98 := yyvsp98 -1
	yyvsp102 := yyvsp102 -1
	yyvsp67 := yyvsp67 -1
	yyvsp86 := yyvsp86 -1
	yyvsp78 := yyvsp78 -1
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -2
	yyvs42.put (yyval42, yyvsp42)
end
		end

	yy_do_action_11 is
			--|#line 279 "et_eiffel_parser.y"
		local
			yyval42: ET_CLASS
		do
--|#line 279 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 279")
end

			yyval42 := yyvs42.item (yyvsp42)
			set_class_to_end (yyval42, yyvs98.item (yyvsp98), yyvs102.item (yyvsp102), Void, Void, Void, yyvs86.item (yyvsp86), yyvs78.item (yyvsp78), yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 9
	yyvsp76 := yyvsp76 -1
	yyvsp98 := yyvsp98 -1
	yyvsp102 := yyvsp102 -1
	yyvsp86 := yyvsp86 -1
	yyvsp78 := yyvsp78 -1
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -2
	yyvs42.put (yyval42, yyvsp42)
end
		end

	yy_do_action_12 is
			--|#line 285 "et_eiffel_parser.y"
		local
			yyval42: ET_CLASS
		do
--|#line 285 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 285")
end

			yyval42 := yyvs42.item (yyvsp42 - 2)
			set_class_to_inheritance_end (yyval42, yyvs98.item (yyvsp98), yyvs102.item (yyvsp102))
			if yyvs42.item (yyvsp42 - 1) /= Void then
				yyvs42.item (yyvsp42 - 1).set_first_indexing (yyvs78.item (yyvsp78))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 8
	yyvsp42 := yyvsp42 -2
	yyvsp76 := yyvsp76 -1
	yyvsp98 := yyvsp98 -1
	yyvsp102 := yyvsp102 -1
	yyvsp78 := yyvsp78 -1
	yyvsp1 := yyvsp1 -1
	yyvs42.put (yyval42, yyvsp42)
end
		end

	yy_do_action_13 is
			--|#line 285 "et_eiffel_parser.y"
		local
			yyval42: ET_CLASS
		do
--|#line 285 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 285")
end

			if not current_system.preparse_multiple_mode then
					-- Raise syntax error: it is not valid to have more
					-- than one class text in the same file.
				raise_error
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp42 := yyvsp42 + 1
	if yyvsp42 >= yyvsc42 then
		if yyvs42 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs42")
			end
			create yyspecial_routines42
			yyvsc42 := yyInitial_yyvs_size
			yyvs42 := yyspecial_routines42.make (yyvsc42)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs42")
			end
			yyvsc42 := yyvsc42 + yyInitial_yyvs_size
			yyvs42 := yyspecial_routines42.resize (yyvs42, yyvsc42)
		end
	end
	yyvs42.put (yyval42, yyvsp42)
end
		end

	yy_do_action_14 is
			--|#line 301 "et_eiffel_parser.y"
		local
			yyval42: ET_CLASS
		do
--|#line 301 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 301")
end

			yyval42 := yyvs42.item (yyvsp42)
			set_class_to_end (yyval42, yyvs98.item (yyvsp98), yyvs102.item (yyvsp102), Void, Void, Void, Void, yyvs78.item (yyvsp78), yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 8
	yyvsp76 := yyvsp76 -1
	yyvsp98 := yyvsp98 -1
	yyvsp102 := yyvsp102 -1
	yyvsp78 := yyvsp78 -1
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -2
	yyvs42.put (yyval42, yyvsp42)
end
		end

	yy_do_action_15 is
			--|#line 306 "et_eiffel_parser.y"
		local
			yyval42: ET_CLASS
		do
--|#line 306 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 306")
end

			yyval42 := yyvs42.item (yyvsp42)
			set_class_to_inheritance_end (yyval42, yyvs98.item (yyvsp98), yyvs102.item (yyvsp102))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp76 := yyvsp76 -1
	yyvsp98 := yyvsp98 -1
	yyvsp102 := yyvsp102 -1
	yyvsp1 := yyvsp1 -1
	yyvs42.put (yyval42, yyvsp42)
end
		end

	yy_do_action_16 is
			--|#line 321 "et_eiffel_parser.y"
		local
			yyval1: ANY
		do
--|#line 321 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 321")
end

set_class_providers 
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
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_17 is
			--|#line 326 "et_eiffel_parser.y"
		local
			yyval78: ET_INDEXING_LIST
		do
--|#line 326 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 326")
end

yyval78 := ast_factory.new_indexings (yyvs2.item (yyvsp2), 0) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp78 := yyvsp78 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp78 >= yyvsc78 then
		if yyvs78 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs78")
			end
			create yyspecial_routines78
			yyvsc78 := yyInitial_yyvs_size
			yyvs78 := yyspecial_routines78.make (yyvsc78)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs78")
			end
			yyvsc78 := yyvsc78 + yyInitial_yyvs_size
			yyvs78 := yyspecial_routines78.resize (yyvs78, yyvsc78)
		end
	end
	yyvs78.put (yyval78, yyvsp78)
end
		end

	yy_do_action_18 is
			--|#line 328 "et_eiffel_parser.y"
		local
			yyval78: ET_INDEXING_LIST
		do
--|#line 328 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 328")
end

			yyval78 := yyvs78.item (yyvsp78)
			remove_keyword
			remove_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp78 := yyvsp78 -1
	yyvsp2 := yyvsp2 -1
	yyvs78.put (yyval78, yyvsp78)
end
		end

	yy_do_action_19 is
			--|#line 328 "et_eiffel_parser.y"
		local
			yyval78: ET_INDEXING_LIST
		do
--|#line 328 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 328")
end

			add_keyword (yyvs2.item (yyvsp2))
			add_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp78 := yyvsp78 + 1
	if yyvsp78 >= yyvsc78 then
		if yyvs78 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs78")
			end
			create yyspecial_routines78
			yyvsc78 := yyInitial_yyvs_size
			yyvs78 := yyspecial_routines78.make (yyvsc78)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs78")
			end
			yyvsc78 := yyvsc78 + yyInitial_yyvs_size
			yyvs78 := yyspecial_routines78.resize (yyvs78, yyvsc78)
		end
	end
	yyvs78.put (yyval78, yyvsp78)
end
		end

	yy_do_action_20 is
			--|#line 339 "et_eiffel_parser.y"
		local
			yyval78: ET_INDEXING_LIST
		do
--|#line 339 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 339")
end

yyval78 := ast_factory.new_indexings (yyvs2.item (yyvsp2), 0) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp78 := yyvsp78 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp78 >= yyvsc78 then
		if yyvs78 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs78")
			end
			create yyspecial_routines78
			yyvsc78 := yyInitial_yyvs_size
			yyvs78 := yyspecial_routines78.make (yyvsc78)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs78")
			end
			yyvsc78 := yyvsc78 + yyInitial_yyvs_size
			yyvs78 := yyspecial_routines78.resize (yyvs78, yyvsc78)
		end
	end
	yyvs78.put (yyval78, yyvsp78)
end
		end

	yy_do_action_21 is
			--|#line 341 "et_eiffel_parser.y"
		local
			yyval78: ET_INDEXING_LIST
		do
--|#line 341 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 341")
end

			yyval78 := yyvs78.item (yyvsp78)
			remove_keyword
			remove_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp78 := yyvsp78 -1
	yyvsp2 := yyvsp2 -1
	yyvs78.put (yyval78, yyvsp78)
end
		end

	yy_do_action_22 is
			--|#line 341 "et_eiffel_parser.y"
		local
			yyval78: ET_INDEXING_LIST
		do
--|#line 341 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 341")
end

			add_keyword (yyvs2.item (yyvsp2))
			add_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp78 := yyvsp78 + 1
	if yyvsp78 >= yyvsc78 then
		if yyvs78 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs78")
			end
			create yyspecial_routines78
			yyvsc78 := yyInitial_yyvs_size
			yyvs78 := yyspecial_routines78.make (yyvsc78)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs78")
			end
			yyvsc78 := yyvsc78 + yyInitial_yyvs_size
			yyvs78 := yyspecial_routines78.resize (yyvs78, yyvsc78)
		end
	end
	yyvs78.put (yyval78, yyvsp78)
end
		end

	yy_do_action_23 is
			--|#line 354 "et_eiffel_parser.y"
		local
			yyval78: ET_INDEXING_LIST
		do
--|#line 354 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 354")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp78 := yyvsp78 + 1
	if yyvsp78 >= yyvsc78 then
		if yyvs78 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs78")
			end
			create yyspecial_routines78
			yyvsc78 := yyInitial_yyvs_size
			yyvs78 := yyspecial_routines78.make (yyvsc78)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs78")
			end
			yyvsc78 := yyvsc78 + yyInitial_yyvs_size
			yyvs78 := yyspecial_routines78.resize (yyvs78, yyvsc78)
		end
	end
	yyvs78.put (yyval78, yyvsp78)
end
		end

	yy_do_action_24 is
			--|#line 356 "et_eiffel_parser.y"
		local
			yyval78: ET_INDEXING_LIST
		do
--|#line 356 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 356")
end

yyval78 := yyvs78.item (yyvsp78) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs78.put (yyval78, yyvsp78)
end
		end

	yy_do_action_25 is
			--|#line 360 "et_eiffel_parser.y"
		local
			yyval78: ET_INDEXING_LIST
		do
--|#line 360 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 360")
end

			if yyvs79.item (yyvsp79) /= Void then
				yyval78 := ast_factory.new_indexings (last_keyword, counter_value + 1)
				if yyval78 /= Void then
					yyval78.put_first (yyvs79.item (yyvsp79))
				end
			else
				yyval78 := ast_factory.new_indexings (last_keyword, counter_value)
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp78 := yyvsp78 + 1
	yyvsp79 := yyvsp79 -1
	if yyvsp78 >= yyvsc78 then
		if yyvs78 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs78")
			end
			create yyspecial_routines78
			yyvsc78 := yyInitial_yyvs_size
			yyvs78 := yyspecial_routines78.make (yyvsc78)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs78")
			end
			yyvsc78 := yyvsc78 + yyInitial_yyvs_size
			yyvs78 := yyspecial_routines78.resize (yyvs78, yyvsc78)
		end
	end
	yyvs78.put (yyval78, yyvsp78)
end
		end

	yy_do_action_26 is
			--|#line 371 "et_eiffel_parser.y"
		local
			yyval78: ET_INDEXING_LIST
		do
--|#line 371 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 371")
end

			yyval78 := yyvs78.item (yyvsp78)
			if yyval78 /= Void and yyvs79.item (yyvsp79) /= Void then
				yyval78.put_first (yyvs79.item (yyvsp79))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp78 := yyvsp78 -1
	yyvsp79 := yyvsp79 -1
	yyvs78.put (yyval78, yyvsp78)
end
		end

	yy_do_action_27 is
			--|#line 371 "et_eiffel_parser.y"
		local
			yyval78: ET_INDEXING_LIST
		do
--|#line 371 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 371")
end

increment_counter 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp78 := yyvsp78 + 1
	if yyvsp78 >= yyvsc78 then
		if yyvs78 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs78")
			end
			create yyspecial_routines78
			yyvsc78 := yyInitial_yyvs_size
			yyvs78 := yyspecial_routines78.make (yyvsc78)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs78")
			end
			yyvsc78 := yyvsc78 + yyInitial_yyvs_size
			yyvs78 := yyspecial_routines78.resize (yyvs78, yyvsc78)
		end
	end
	yyvs78.put (yyval78, yyvsp78)
end
		end

	yy_do_action_28 is
			--|#line 380 "et_eiffel_parser.y"
		local
			yyval78: ET_INDEXING_LIST
		do
--|#line 380 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 380")
end

			yyval78 := yyvs78.item (yyvsp78)
			if yyval78 /= Void and yyvs79.item (yyvsp79) /= Void then
				yyval78.put_first (yyvs79.item (yyvsp79))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp78 := yyvsp78 -1
	yyvsp79 := yyvsp79 -1
	yyvs78.put (yyval78, yyvsp78)
end
		end

	yy_do_action_29 is
			--|#line 380 "et_eiffel_parser.y"
		local
			yyval78: ET_INDEXING_LIST
		do
--|#line 380 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 380")
end

increment_counter 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp78 := yyvsp78 + 1
	if yyvsp78 >= yyvsc78 then
		if yyvs78 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs78")
			end
			create yyspecial_routines78
			yyvsc78 := yyInitial_yyvs_size
			yyvs78 := yyspecial_routines78.make (yyvsc78)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs78")
			end
			yyvsc78 := yyvsc78 + yyInitial_yyvs_size
			yyvs78 := yyspecial_routines78.resize (yyvs78, yyvsc78)
		end
	end
	yyvs78.put (yyval78, yyvsp78)
end
		end

	yy_do_action_30 is
			--|#line 391 "et_eiffel_parser.y"
		local
			yyval79: ET_INDEXING_ITEM
		do
--|#line 391 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 391")
end

			yyval79 := yyvs79.item (yyvsp79)
			remove_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs79.put (yyval79, yyvsp79)
end
		end

	yy_do_action_31 is
			--|#line 398 "et_eiffel_parser.y"
		local
			yyval79: ET_INDEXING_ITEM
		do
--|#line 398 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 398")
end

			yyval79 := ast_factory.new_tagged_indexing (ast_factory.new_tag (yyvs13.item (yyvsp13), yyvs5.item (yyvsp5)), yyvs82.item (yyvsp82))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp79 := yyvsp79 + 1
	yyvsp13 := yyvsp13 -1
	yyvsp5 := yyvsp5 -1
	yyvsp82 := yyvsp82 -1
	if yyvsp79 >= yyvsc79 then
		if yyvs79 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs79")
			end
			create yyspecial_routines79
			yyvsc79 := yyInitial_yyvs_size
			yyvs79 := yyspecial_routines79.make (yyvsc79)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs79")
			end
			yyvsc79 := yyvsc79 + yyInitial_yyvs_size
			yyvs79 := yyspecial_routines79.resize (yyvs79, yyvsc79)
		end
	end
	yyvs79.put (yyval79, yyvsp79)
end
		end

	yy_do_action_32 is
			--|#line 404 "et_eiffel_parser.y"
		local
			yyval79: ET_INDEXING_ITEM
		do
--|#line 404 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 404")
end

yyval79 := ast_factory.new_indexing_semicolon (yyvs79.item (yyvsp79), yyvs22.item (yyvsp22)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp22 := yyvsp22 -1
	yyvs79.put (yyval79, yyvsp79)
end
		end

	yy_do_action_33 is
			--|#line 408 "et_eiffel_parser.y"
		local
			yyval78: ET_INDEXING_LIST
		do
--|#line 408 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 408")
end

			if yyvs79.item (yyvsp79) /= Void then
				yyval78 := ast_factory.new_indexings (last_keyword, counter_value + 1)
				if yyval78 /= Void then
					yyval78.put_first (yyvs79.item (yyvsp79))
				end
			else
				yyval78 := ast_factory.new_indexings (last_keyword, counter_value)
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp78 := yyvsp78 + 1
	yyvsp79 := yyvsp79 -1
	if yyvsp78 >= yyvsc78 then
		if yyvs78 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs78")
			end
			create yyspecial_routines78
			yyvsc78 := yyInitial_yyvs_size
			yyvs78 := yyspecial_routines78.make (yyvsc78)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs78")
			end
			yyvsc78 := yyvsc78 + yyInitial_yyvs_size
			yyvs78 := yyspecial_routines78.resize (yyvs78, yyvsc78)
		end
	end
	yyvs78.put (yyval78, yyvsp78)
end
		end

	yy_do_action_34 is
			--|#line 419 "et_eiffel_parser.y"
		local
			yyval78: ET_INDEXING_LIST
		do
--|#line 419 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 419")
end

			if yyvs79.item (yyvsp79) /= Void then
				yyval78 := ast_factory.new_indexings (last_keyword, counter_value + 1)
				if yyval78 /= Void then
					yyval78.put_first (yyvs79.item (yyvsp79))
				end
			else
				yyval78 := ast_factory.new_indexings (last_keyword, counter_value)
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp78 := yyvsp78 + 1
	yyvsp79 := yyvsp79 -1
	if yyvsp78 >= yyvsc78 then
		if yyvs78 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs78")
			end
			create yyspecial_routines78
			yyvsc78 := yyInitial_yyvs_size
			yyvs78 := yyspecial_routines78.make (yyvsc78)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs78")
			end
			yyvsc78 := yyvsc78 + yyInitial_yyvs_size
			yyvs78 := yyspecial_routines78.resize (yyvs78, yyvsc78)
		end
	end
	yyvs78.put (yyval78, yyvsp78)
end
		end

	yy_do_action_35 is
			--|#line 431 "et_eiffel_parser.y"
		local
			yyval78: ET_INDEXING_LIST
		do
--|#line 431 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 431")
end

			yyval78 := yyvs78.item (yyvsp78)
			if yyval78 /= Void and yyvs79.item (yyvsp79) /= Void then
				yyval78.put_first (yyvs79.item (yyvsp79))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp78 := yyvsp78 -1
	yyvsp79 := yyvsp79 -1
	yyvs78.put (yyval78, yyvsp78)
end
		end

	yy_do_action_36 is
			--|#line 431 "et_eiffel_parser.y"
		local
			yyval78: ET_INDEXING_LIST
		do
--|#line 431 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 431")
end

increment_counter 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp78 := yyvsp78 + 1
	if yyvsp78 >= yyvsc78 then
		if yyvs78 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs78")
			end
			create yyspecial_routines78
			yyvsc78 := yyInitial_yyvs_size
			yyvs78 := yyspecial_routines78.make (yyvsc78)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs78")
			end
			yyvsc78 := yyvsc78 + yyInitial_yyvs_size
			yyvs78 := yyspecial_routines78.resize (yyvs78, yyvsc78)
		end
	end
	yyvs78.put (yyval78, yyvsp78)
end
		end

	yy_do_action_37 is
			--|#line 440 "et_eiffel_parser.y"
		local
			yyval78: ET_INDEXING_LIST
		do
--|#line 440 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 440")
end

			yyval78 := yyvs78.item (yyvsp78)
			if yyval78 /= Void and yyvs79.item (yyvsp79) /= Void then
				yyval78.put_first (yyvs79.item (yyvsp79))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp78 := yyvsp78 -1
	yyvsp79 := yyvsp79 -1
	yyvs78.put (yyval78, yyvsp78)
end
		end

	yy_do_action_38 is
			--|#line 440 "et_eiffel_parser.y"
		local
			yyval78: ET_INDEXING_LIST
		do
--|#line 440 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 440")
end

increment_counter 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp78 := yyvsp78 + 1
	if yyvsp78 >= yyvsc78 then
		if yyvs78 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs78")
			end
			create yyspecial_routines78
			yyvsc78 := yyInitial_yyvs_size
			yyvs78 := yyspecial_routines78.make (yyvsc78)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs78")
			end
			yyvsc78 := yyvsc78 + yyInitial_yyvs_size
			yyvs78 := yyspecial_routines78.resize (yyvs78, yyvsc78)
		end
	end
	yyvs78.put (yyval78, yyvsp78)
end
		end

	yy_do_action_39 is
			--|#line 451 "et_eiffel_parser.y"
		local
			yyval79: ET_INDEXING_ITEM
		do
--|#line 451 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 451")
end

			yyval79 := yyvs79.item (yyvsp79)
			remove_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs79.put (yyval79, yyvsp79)
end
		end

	yy_do_action_40 is
			--|#line 458 "et_eiffel_parser.y"
		local
			yyval79: ET_INDEXING_ITEM
		do
--|#line 458 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 458")
end

			yyval79 := ast_factory.new_indexing (yyvs82.item (yyvsp82))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp79 := yyvsp79 + 1
	yyvsp82 := yyvsp82 -1
	if yyvsp79 >= yyvsc79 then
		if yyvs79 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs79")
			end
			create yyspecial_routines79
			yyvsc79 := yyInitial_yyvs_size
			yyvs79 := yyspecial_routines79.make (yyvsc79)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs79")
			end
			yyvsc79 := yyvsc79 + yyInitial_yyvs_size
			yyvs79 := yyspecial_routines79.resize (yyvs79, yyvsc79)
		end
	end
	yyvs79.put (yyval79, yyvsp79)
end
		end

	yy_do_action_41 is
			--|#line 462 "et_eiffel_parser.y"
		local
			yyval79: ET_INDEXING_ITEM
		do
--|#line 462 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 462")
end

			yyval79 := ast_factory.new_tagged_indexing (ast_factory.new_tag (yyvs13.item (yyvsp13), yyvs5.item (yyvsp5)), yyvs82.item (yyvsp82))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp79 := yyvsp79 + 1
	yyvsp13 := yyvsp13 -1
	yyvsp5 := yyvsp5 -1
	yyvsp82 := yyvsp82 -1
	if yyvsp79 >= yyvsc79 then
		if yyvs79 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs79")
			end
			create yyspecial_routines79
			yyvsc79 := yyInitial_yyvs_size
			yyvs79 := yyspecial_routines79.make (yyvsc79)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs79")
			end
			yyvsc79 := yyvsc79 + yyInitial_yyvs_size
			yyvs79 := yyspecial_routines79.resize (yyvs79, yyvsc79)
		end
	end
	yyvs79.put (yyval79, yyvsp79)
end
		end

	yy_do_action_42 is
			--|#line 468 "et_eiffel_parser.y"
		local
			yyval79: ET_INDEXING_ITEM
		do
--|#line 468 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 468")
end

yyval79 := ast_factory.new_indexing_semicolon (yyvs79.item (yyvsp79), yyvs22.item (yyvsp22)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp22 := yyvsp22 -1
	yyvs79.put (yyval79, yyvsp79)
end
		end

	yy_do_action_43 is
			--|#line 470 "et_eiffel_parser.y"
		local
			yyval79: ET_INDEXING_ITEM
		do
--|#line 470 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 470")
end

yyval79 := ast_factory.new_indexing_semicolon (yyvs79.item (yyvsp79), yyvs22.item (yyvsp22)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp22 := yyvsp22 -1
	yyvs79.put (yyval79, yyvsp79)
end
		end

	yy_do_action_44 is
			--|#line 475 "et_eiffel_parser.y"
		local
			yyval82: ET_INDEXING_TERM_LIST
		do
--|#line 475 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 475")
end

			if yyvs80.item (yyvsp80) /= Void then
				yyval82 := ast_factory.new_indexing_terms (counter_value + 1)
				if yyval82 /= Void then
					yyval82.put_first (yyvs80.item (yyvsp80))
				end
			else
				yyval82 := ast_factory.new_indexing_terms (counter_value)
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp82 := yyvsp82 + 1
	yyvsp80 := yyvsp80 -1
	if yyvsp82 >= yyvsc82 then
		if yyvs82 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs82")
			end
			create yyspecial_routines82
			yyvsc82 := yyInitial_yyvs_size
			yyvs82 := yyspecial_routines82.make (yyvsc82)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs82")
			end
			yyvsc82 := yyvsc82 + yyInitial_yyvs_size
			yyvs82 := yyspecial_routines82.resize (yyvs82, yyvsc82)
		end
	end
	yyvs82.put (yyval82, yyvsp82)
end
		end

	yy_do_action_45 is
			--|#line 486 "et_eiffel_parser.y"
		local
			yyval82: ET_INDEXING_TERM_LIST
		do
--|#line 486 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 486")
end

			yyval82 := yyvs82.item (yyvsp82)
			if yyval82 /= Void and yyvs81.item (yyvsp81) /= Void then
				yyval82.put_first (yyvs81.item (yyvsp81))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp81 := yyvsp81 -1
	yyvs82.put (yyval82, yyvsp82)
end
		end

	yy_do_action_46 is
			--|#line 495 "et_eiffel_parser.y"
		local
			yyval80: ET_INDEXING_TERM
		do
--|#line 495 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 495")
end

yyval80 := yyvs13.item (yyvsp13) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp80 := yyvsp80 + 1
	yyvsp13 := yyvsp13 -1
	if yyvsp80 >= yyvsc80 then
		if yyvs80 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs80")
			end
			create yyspecial_routines80
			yyvsc80 := yyInitial_yyvs_size
			yyvs80 := yyspecial_routines80.make (yyvsc80)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs80")
			end
			yyvsc80 := yyvsc80 + yyInitial_yyvs_size
			yyvs80 := yyspecial_routines80.resize (yyvs80, yyvsc80)
		end
	end
	yyvs80.put (yyval80, yyvsp80)
end
		end

	yy_do_action_47 is
			--|#line 497 "et_eiffel_parser.y"
		local
			yyval80: ET_INDEXING_TERM
		do
--|#line 497 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 497")
end

yyval80 := yyvs8.item (yyvsp8) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp80 := yyvsp80 + 1
	yyvsp8 := yyvsp8 -1
	if yyvsp80 >= yyvsc80 then
		if yyvs80 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs80")
			end
			create yyspecial_routines80
			yyvsc80 := yyInitial_yyvs_size
			yyvs80 := yyspecial_routines80.make (yyvsc80)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs80")
			end
			yyvsc80 := yyvsc80 + yyInitial_yyvs_size
			yyvs80 := yyspecial_routines80.resize (yyvs80, yyvsc80)
		end
	end
	yyvs80.put (yyval80, yyvsp80)
end
		end

	yy_do_action_48 is
			--|#line 499 "et_eiffel_parser.y"
		local
			yyval80: ET_INDEXING_TERM
		do
--|#line 499 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 499")
end

yyval80 := yyvs10.item (yyvsp10) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp80 := yyvsp80 + 1
	yyvsp10 := yyvsp10 -1
	if yyvsp80 >= yyvsc80 then
		if yyvs80 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs80")
			end
			create yyspecial_routines80
			yyvsc80 := yyInitial_yyvs_size
			yyvs80 := yyspecial_routines80.make (yyvsc80)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs80")
			end
			yyvsc80 := yyvsc80 + yyInitial_yyvs_size
			yyvs80 := yyspecial_routines80.resize (yyvs80, yyvsc80)
		end
	end
	yyvs80.put (yyval80, yyvsp80)
end
		end

	yy_do_action_49 is
			--|#line 501 "et_eiffel_parser.y"
		local
			yyval80: ET_INDEXING_TERM
		do
--|#line 501 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 501")
end

yyval80 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp80 := yyvsp80 + 1
	yyvsp14 := yyvsp14 -1
	if yyvsp80 >= yyvsc80 then
		if yyvs80 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs80")
			end
			create yyspecial_routines80
			yyvsc80 := yyInitial_yyvs_size
			yyvs80 := yyspecial_routines80.make (yyvsc80)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs80")
			end
			yyvsc80 := yyvsc80 + yyInitial_yyvs_size
			yyvs80 := yyspecial_routines80.resize (yyvs80, yyvsc80)
		end
	end
	yyvs80.put (yyval80, yyvsp80)
end
		end

	yy_do_action_50 is
			--|#line 503 "et_eiffel_parser.y"
		local
			yyval80: ET_INDEXING_TERM
		do
--|#line 503 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 503")
end

yyval80 := yyvs17.item (yyvsp17) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp80 := yyvsp80 + 1
	yyvsp17 := yyvsp17 -1
	if yyvsp80 >= yyvsc80 then
		if yyvs80 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs80")
			end
			create yyspecial_routines80
			yyvsc80 := yyInitial_yyvs_size
			yyvs80 := yyspecial_routines80.make (yyvsc80)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs80")
			end
			yyvsc80 := yyvsc80 + yyInitial_yyvs_size
			yyvs80 := yyspecial_routines80.resize (yyvs80, yyvsc80)
		end
	end
	yyvs80.put (yyval80, yyvsp80)
end
		end

	yy_do_action_51 is
			--|#line 505 "et_eiffel_parser.y"
		local
			yyval80: ET_INDEXING_TERM
		do
--|#line 505 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 505")
end

yyval80 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp80 := yyvsp80 + 1
	yyvsp16 := yyvsp16 -1
	if yyvsp80 >= yyvsc80 then
		if yyvs80 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs80")
			end
			create yyspecial_routines80
			yyvsc80 := yyInitial_yyvs_size
			yyvs80 := yyspecial_routines80.make (yyvsc80)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs80")
			end
			yyvsc80 := yyvsc80 + yyInitial_yyvs_size
			yyvs80 := yyspecial_routines80.resize (yyvs80, yyvsc80)
		end
	end
	yyvs80.put (yyval80, yyvsp80)
end
		end

	yy_do_action_52 is
			--|#line 507 "et_eiffel_parser.y"
		local
			yyval80: ET_INDEXING_TERM
		do
--|#line 507 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 507")
end

yyval80 := yyvs7.item (yyvsp7) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp80 := yyvsp80 + 1
	yyvsp7 := yyvsp7 -1
	if yyvsp80 >= yyvsc80 then
		if yyvs80 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs80")
			end
			create yyspecial_routines80
			yyvsc80 := yyInitial_yyvs_size
			yyvs80 := yyspecial_routines80.make (yyvsc80)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs80")
			end
			yyvsc80 := yyvsc80 + yyInitial_yyvs_size
			yyvs80 := yyspecial_routines80.resize (yyvs80, yyvsc80)
		end
	end
	yyvs80.put (yyval80, yyvsp80)
end
		end

	yy_do_action_53 is
			--|#line 509 "et_eiffel_parser.y"
		local
			yyval80: ET_INDEXING_TERM
		do
--|#line 509 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 509")
end

yyval80 := ast_factory.new_custom_attribute (yyvs54.item (yyvsp54), Void, yyvs2.item (yyvsp2)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp80 := yyvsp80 + 1
	yyvsp54 := yyvsp54 -1
	yyvsp2 := yyvsp2 -1
	if yyvsp80 >= yyvsc80 then
		if yyvs80 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs80")
			end
			create yyspecial_routines80
			yyvsc80 := yyInitial_yyvs_size
			yyvs80 := yyspecial_routines80.make (yyvsc80)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs80")
			end
			yyvsc80 := yyvsc80 + yyInitial_yyvs_size
			yyvs80 := yyspecial_routines80.resize (yyvs80, yyvsc80)
		end
	end
	yyvs80.put (yyval80, yyvsp80)
end
		end

	yy_do_action_54 is
			--|#line 511 "et_eiffel_parser.y"
		local
			yyval80: ET_INDEXING_TERM
		do
--|#line 511 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 511")
end

yyval80 := ast_factory.new_custom_attribute (yyvs54.item (yyvsp54), yyvs96.item (yyvsp96), yyvs2.item (yyvsp2)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp80 := yyvsp80 + 1
	yyvsp54 := yyvsp54 -1
	yyvsp96 := yyvsp96 -1
	yyvsp2 := yyvsp2 -1
	if yyvsp80 >= yyvsc80 then
		if yyvs80 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs80")
			end
			create yyspecial_routines80
			yyvsc80 := yyInitial_yyvs_size
			yyvs80 := yyspecial_routines80.make (yyvsc80)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs80")
			end
			yyvsc80 := yyvsc80 + yyInitial_yyvs_size
			yyvs80 := yyspecial_routines80.resize (yyvs80, yyvsc80)
		end
	end
	yyvs80.put (yyval80, yyvsp80)
end
		end

	yy_do_action_55 is
			--|#line 515 "et_eiffel_parser.y"
		local
			yyval81: ET_INDEXING_TERM_ITEM
		do
--|#line 515 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 515")
end

			yyval81 := ast_factory.new_indexing_term_comma (yyvs80.item (yyvsp80), yyvs5.item (yyvsp5))
			if yyval81 /= Void then
				increment_counter
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp81 := yyvsp81 + 1
	yyvsp80 := yyvsp80 -1
	yyvsp5 := yyvsp5 -1
	if yyvsp81 >= yyvsc81 then
		if yyvs81 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs81")
			end
			create yyspecial_routines81
			yyvsc81 := yyInitial_yyvs_size
			yyvs81 := yyspecial_routines81.make (yyvsc81)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs81")
			end
			yyvsc81 := yyvsc81 + yyInitial_yyvs_size
			yyvs81 := yyspecial_routines81.resize (yyvs81, yyvsc81)
		end
	end
	yyvs81.put (yyval81, yyvsp81)
end
		end

	yy_do_action_56 is
			--|#line 526 "et_eiffel_parser.y"
		local
			yyval42: ET_CLASS
		do
--|#line 526 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 526")
end

			yyval42 := new_class (yyvs13.item (yyvsp13))
			if yyval42 /= Void then
				yyval42.set_class_keyword (yyvs2.item (yyvsp2))
				yyval42.set_frozen_keyword (yyvs2.item (yyvsp2 - 2))
				yyval42.set_external_keyword (yyvs2.item (yyvsp2 - 1))
			end
			last_class := yyval42
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp42 := yyvsp42 + 1
	yyvsp2 := yyvsp2 -3
	yyvsp13 := yyvsp13 -1
	if yyvsp42 >= yyvsc42 then
		if yyvs42 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs42")
			end
			create yyspecial_routines42
			yyvsc42 := yyInitial_yyvs_size
			yyvs42 := yyspecial_routines42.make (yyvsc42)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs42")
			end
			yyvsc42 := yyvsc42 + yyInitial_yyvs_size
			yyvs42 := yyspecial_routines42.resize (yyvs42, yyvsc42)
		end
	end
	yyvs42.put (yyval42, yyvsp42)
end
		end

	yy_do_action_57 is
			--|#line 536 "et_eiffel_parser.y"
		local
			yyval42: ET_CLASS
		do
--|#line 536 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 536")
end

			yyval42 := new_class (yyvs13.item (yyvsp13))
			if yyval42 /= Void then
				yyval42.set_class_keyword (yyvs2.item (yyvsp2))
				yyval42.set_class_mark (yyvs2.item (yyvsp2 - 2))
				yyval42.set_frozen_keyword (yyvs2.item (yyvsp2 - 3))
				yyval42.set_external_keyword (yyvs2.item (yyvsp2 - 1))
			end
			last_class := yyval42
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp42 := yyvsp42 + 1
	yyvsp2 := yyvsp2 -4
	yyvsp13 := yyvsp13 -1
	if yyvsp42 >= yyvsc42 then
		if yyvs42 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs42")
			end
			create yyspecial_routines42
			yyvsc42 := yyInitial_yyvs_size
			yyvs42 := yyspecial_routines42.make (yyvsc42)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs42")
			end
			yyvsc42 := yyvsc42 + yyInitial_yyvs_size
			yyvs42 := yyspecial_routines42.resize (yyvs42, yyvsc42)
		end
	end
	yyvs42.put (yyval42, yyvsp42)
end
		end

	yy_do_action_58 is
			--|#line 547 "et_eiffel_parser.y"
		local
			yyval42: ET_CLASS
		do
--|#line 547 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 547")
end

			yyval42 := new_class (yyvs13.item (yyvsp13))
			if yyval42 /= Void then
				yyval42.set_class_keyword (yyvs2.item (yyvsp2))
				yyval42.set_class_mark (yyvs2.item (yyvsp2 - 2))
				yyval42.set_frozen_keyword (yyvs2.item (yyvsp2 - 3))
				yyval42.set_external_keyword (yyvs2.item (yyvsp2 - 1))
			end
			last_class := yyval42
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp42 := yyvsp42 + 1
	yyvsp2 := yyvsp2 -4
	yyvsp13 := yyvsp13 -1
	if yyvsp42 >= yyvsc42 then
		if yyvs42 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs42")
			end
			create yyspecial_routines42
			yyvsc42 := yyInitial_yyvs_size
			yyvs42 := yyspecial_routines42.make (yyvsc42)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs42")
			end
			yyvsc42 := yyvsc42 + yyInitial_yyvs_size
			yyvs42 := yyspecial_routines42.resize (yyvs42, yyvsc42)
		end
	end
	yyvs42.put (yyval42, yyvsp42)
end
		end

	yy_do_action_59 is
			--|#line 558 "et_eiffel_parser.y"
		local
			yyval42: ET_CLASS
		do
--|#line 558 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 558")
end

			yyval42 := new_class (yyvs13.item (yyvsp13))
			if yyval42 /= Void then
				yyval42.set_class_keyword (yyvs2.item (yyvsp2))
				yyval42.set_class_mark (yyvs2.item (yyvsp2 - 2))
				yyval42.set_frozen_keyword (yyvs2.item (yyvsp2 - 3))
				yyval42.set_external_keyword (yyvs2.item (yyvsp2 - 1))
			end
			last_class := yyval42
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp42 := yyvsp42 + 1
	yyvsp2 := yyvsp2 -4
	yyvsp13 := yyvsp13 -1
	if yyvsp42 >= yyvsc42 then
		if yyvs42 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs42")
			end
			create yyspecial_routines42
			yyvsc42 := yyInitial_yyvs_size
			yyvs42 := yyspecial_routines42.make (yyvsc42)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs42")
			end
			yyvsc42 := yyvsc42 + yyInitial_yyvs_size
			yyvs42 := yyspecial_routines42.resize (yyvs42, yyvsc42)
		end
	end
	yyvs42.put (yyval42, yyvsp42)
end
		end

	yy_do_action_60 is
			--|#line 571 "et_eiffel_parser.y"
		local
			yyval2: ET_KEYWORD
		do
--|#line 571 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 571")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp2 := yyvsp2 + 1
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
	yyvs2.put (yyval2, yyvsp2)
end
		end

	yy_do_action_61 is
			--|#line 573 "et_eiffel_parser.y"
		local
			yyval2: ET_KEYWORD
		do
--|#line 573 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 573")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
		end

	yy_do_action_62 is
			--|#line 577 "et_eiffel_parser.y"
		local
			yyval2: ET_KEYWORD
		do
--|#line 577 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 577")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp2 := yyvsp2 + 1
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
	yyvs2.put (yyval2, yyvsp2)
end
		end

	yy_do_action_63 is
			--|#line 579 "et_eiffel_parser.y"
		local
			yyval2: ET_KEYWORD
		do
--|#line 579 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 579")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
		end

	yy_do_action_64 is
			--|#line 585 "et_eiffel_parser.y"
		local
			yyval76: ET_FORMAL_PARAMETER_LIST
		do
--|#line 585 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 585")
end

			set_formal_parameters (Void)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp76 := yyvsp76 + 1
	if yyvsp76 >= yyvsc76 then
		if yyvs76 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs76")
			end
			create yyspecial_routines76
			yyvsc76 := yyInitial_yyvs_size
			yyvs76 := yyspecial_routines76.make (yyvsc76)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs76")
			end
			yyvsc76 := yyvsc76 + yyInitial_yyvs_size
			yyvs76 := yyspecial_routines76.resize (yyvs76, yyvsc76)
		end
	end
	yyvs76.put (yyval76, yyvsp76)
end
		end

	yy_do_action_65 is
			--|#line 589 "et_eiffel_parser.y"
		local
			yyval76: ET_FORMAL_PARAMETER_LIST
		do
--|#line 589 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 589")
end

			yyval76 := ast_factory.new_formal_parameters (yyvs23.item (yyvsp23), yyvs5.item (yyvsp5), 0)
			set_formal_parameters (yyval76)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp76 := yyvsp76 + 1
	yyvsp23 := yyvsp23 -1
	yyvsp5 := yyvsp5 -1
	if yyvsp76 >= yyvsc76 then
		if yyvs76 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs76")
			end
			create yyspecial_routines76
			yyvsc76 := yyInitial_yyvs_size
			yyvs76 := yyspecial_routines76.make (yyvsc76)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs76")
			end
			yyvsc76 := yyvsc76 + yyInitial_yyvs_size
			yyvs76 := yyspecial_routines76.resize (yyvs76, yyvsc76)
		end
	end
	yyvs76.put (yyval76, yyvsp76)
end
		end

	yy_do_action_66 is
			--|#line 595 "et_eiffel_parser.y"
		local
			yyval76: ET_FORMAL_PARAMETER_LIST
		do
--|#line 595 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 595")
end

			yyval76 := yyvs76.item (yyvsp76)
			set_formal_parameters (yyval76)
			remove_symbol
			remove_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp76 := yyvsp76 -1
	yyvsp23 := yyvsp23 -1
	yyvs76.put (yyval76, yyvsp76)
end
		end

	yy_do_action_67 is
			--|#line 595 "et_eiffel_parser.y"
		local
			yyval76: ET_FORMAL_PARAMETER_LIST
		do
--|#line 595 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 595")
end

			add_symbol (yyvs23.item (yyvsp23))
			add_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp76 := yyvsp76 + 1
	if yyvsp76 >= yyvsc76 then
		if yyvs76 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs76")
			end
			create yyspecial_routines76
			yyvsc76 := yyInitial_yyvs_size
			yyvs76 := yyspecial_routines76.make (yyvsc76)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs76")
			end
			yyvsc76 := yyvsc76 + yyInitial_yyvs_size
			yyvs76 := yyspecial_routines76.resize (yyvs76, yyvsc76)
		end
	end
	yyvs76.put (yyval76, yyvsp76)
end
		end

	yy_do_action_68 is
			--|#line 609 "et_eiffel_parser.y"
		local
			yyval76: ET_FORMAL_PARAMETER_LIST
		do
--|#line 609 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 609")
end

			if yyvs74.item (yyvsp74) /= Void then
				yyval76 := ast_factory.new_formal_parameters (last_symbol, yyvs5.item (yyvsp5), counter_value + 1)
				if yyval76 /= Void then
					yyval76.put_first (yyvs74.item (yyvsp74))
				end
			else
				yyval76 := ast_factory.new_formal_parameters (last_symbol, yyvs5.item (yyvsp5), counter_value)
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp76 := yyvsp76 + 1
	yyvsp74 := yyvsp74 -1
	yyvsp5 := yyvsp5 -1
	if yyvsp76 >= yyvsc76 then
		if yyvs76 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs76")
			end
			create yyspecial_routines76
			yyvsc76 := yyInitial_yyvs_size
			yyvs76 := yyspecial_routines76.make (yyvsc76)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs76")
			end
			yyvsc76 := yyvsc76 + yyInitial_yyvs_size
			yyvs76 := yyspecial_routines76.resize (yyvs76, yyvsc76)
		end
	end
	yyvs76.put (yyval76, yyvsp76)
end
		end

	yy_do_action_69 is
			--|#line 620 "et_eiffel_parser.y"
		local
			yyval76: ET_FORMAL_PARAMETER_LIST
		do
--|#line 620 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 620")
end

			yyval76 := yyvs76.item (yyvsp76)
			if yyval76 /= Void and yyvs75.item (yyvsp75) /= Void then
				yyval76.put_first (yyvs75.item (yyvsp75))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp75 := yyvsp75 -1
	yyvs76.put (yyval76, yyvsp76)
end
		end

	yy_do_action_70 is
			--|#line 629 "et_eiffel_parser.y"
		local
			yyval75: ET_FORMAL_PARAMETER_ITEM
		do
--|#line 629 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 629")
end

			yyval75 := ast_factory.new_formal_parameter_comma (yyvs74.item (yyvsp74), yyvs5.item (yyvsp5))
			if yyval75 /= Void then
				increment_counter
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp75 := yyvsp75 + 1
	yyvsp74 := yyvsp74 -1
	yyvsp5 := yyvsp5 -1
	if yyvsp75 >= yyvsc75 then
		if yyvs75 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs75")
			end
			create yyspecial_routines75
			yyvsc75 := yyInitial_yyvs_size
			yyvs75 := yyspecial_routines75.make (yyvsc75)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs75")
			end
			yyvsc75 := yyvsc75 + yyInitial_yyvs_size
			yyvs75 := yyspecial_routines75.resize (yyvs75, yyvsc75)
		end
	end
	yyvs75.put (yyval75, yyvsp75)
end
		end

	yy_do_action_71 is
			--|#line 638 "et_eiffel_parser.y"
		local
			yyval74: ET_FORMAL_PARAMETER
		do
--|#line 638 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 638")
end

			yyval74 := ast_factory.new_formal_parameter (Void, yyvs13.item (yyvsp13))
			if yyval74 /= Void then
				register_constraint (Void)
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp74 := yyvsp74 + 1
	yyvsp13 := yyvsp13 -1
	if yyvsp74 >= yyvsc74 then
		if yyvs74 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs74")
			end
			create yyspecial_routines74
			yyvsc74 := yyInitial_yyvs_size
			yyvs74 := yyspecial_routines74.make (yyvsc74)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs74")
			end
			yyvsc74 := yyvsc74 + yyInitial_yyvs_size
			yyvs74 := yyspecial_routines74.resize (yyvs74, yyvsc74)
		end
	end
	yyvs74.put (yyval74, yyvsp74)
end
		end

	yy_do_action_72 is
			--|#line 645 "et_eiffel_parser.y"
		local
			yyval74: ET_FORMAL_PARAMETER
		do
--|#line 645 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 645")
end

			yyval74 := ast_factory.new_formal_parameter (yyvs2.item (yyvsp2), yyvs13.item (yyvsp13))
			if yyval74 /= Void then
				register_constraint (Void)
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp74 := yyvsp74 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp13 := yyvsp13 -1
	if yyvsp74 >= yyvsc74 then
		if yyvs74 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs74")
			end
			create yyspecial_routines74
			yyvsc74 := yyInitial_yyvs_size
			yyvs74 := yyspecial_routines74.make (yyvsc74)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs74")
			end
			yyvsc74 := yyvsc74 + yyInitial_yyvs_size
			yyvs74 := yyspecial_routines74.resize (yyvs74, yyvsc74)
		end
	end
	yyvs74.put (yyval74, yyvsp74)
end
		end

	yy_do_action_73 is
			--|#line 652 "et_eiffel_parser.y"
		local
			yyval74: ET_FORMAL_PARAMETER
		do
--|#line 652 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 652")
end

			yyval74 := ast_factory.new_formal_parameter (yyvs2.item (yyvsp2), yyvs13.item (yyvsp13))
			if yyval74 /= Void then
				register_constraint (Void)
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp74 := yyvsp74 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp13 := yyvsp13 -1
	if yyvsp74 >= yyvsc74 then
		if yyvs74 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs74")
			end
			create yyspecial_routines74
			yyvsc74 := yyInitial_yyvs_size
			yyvs74 := yyspecial_routines74.make (yyvsc74)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs74")
			end
			yyvsc74 := yyvsc74 + yyInitial_yyvs_size
			yyvs74 := yyspecial_routines74.resize (yyvs74, yyvsc74)
		end
	end
	yyvs74.put (yyval74, yyvsp74)
end
		end

	yy_do_action_74 is
			--|#line 659 "et_eiffel_parser.y"
		local
			yyval74: ET_FORMAL_PARAMETER
		do
--|#line 659 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 659")
end

			yyval74 := ast_factory.new_constrained_formal_parameter (Void, yyvs13.item (yyvsp13), yyvs5.item (yyvsp5), dummy_constraint (yyvs50.item (yyvsp50)), Void)
			if yyval74 /= Void then
				register_constraint (yyvs50.item (yyvsp50))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp74 := yyvsp74 + 1
	yyvsp13 := yyvsp13 -1
	yyvsp5 := yyvsp5 -1
	yyvsp50 := yyvsp50 -1
	if yyvsp74 >= yyvsc74 then
		if yyvs74 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs74")
			end
			create yyspecial_routines74
			yyvsc74 := yyInitial_yyvs_size
			yyvs74 := yyspecial_routines74.make (yyvsc74)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs74")
			end
			yyvsc74 := yyvsc74 + yyInitial_yyvs_size
			yyvs74 := yyspecial_routines74.resize (yyvs74, yyvsc74)
		end
	end
	yyvs74.put (yyval74, yyvsp74)
end
		end

	yy_do_action_75 is
			--|#line 666 "et_eiffel_parser.y"
		local
			yyval74: ET_FORMAL_PARAMETER
		do
--|#line 666 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 666")
end

			yyval74 := ast_factory.new_constrained_formal_parameter (yyvs2.item (yyvsp2), yyvs13.item (yyvsp13), yyvs5.item (yyvsp5), dummy_constraint (yyvs50.item (yyvsp50)), Void)
			if yyval74 /= Void then
				register_constraint (yyvs50.item (yyvsp50))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp74 := yyvsp74 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp13 := yyvsp13 -1
	yyvsp5 := yyvsp5 -1
	yyvsp50 := yyvsp50 -1
	if yyvsp74 >= yyvsc74 then
		if yyvs74 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs74")
			end
			create yyspecial_routines74
			yyvsc74 := yyInitial_yyvs_size
			yyvs74 := yyspecial_routines74.make (yyvsc74)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs74")
			end
			yyvsc74 := yyvsc74 + yyInitial_yyvs_size
			yyvs74 := yyspecial_routines74.resize (yyvs74, yyvsc74)
		end
	end
	yyvs74.put (yyval74, yyvsp74)
end
		end

	yy_do_action_76 is
			--|#line 673 "et_eiffel_parser.y"
		local
			yyval74: ET_FORMAL_PARAMETER
		do
--|#line 673 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 673")
end

			yyval74 := ast_factory.new_constrained_formal_parameter (yyvs2.item (yyvsp2), yyvs13.item (yyvsp13), yyvs5.item (yyvsp5), dummy_constraint (yyvs50.item (yyvsp50)), Void)
			if yyval74 /= Void then
				register_constraint (yyvs50.item (yyvsp50))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp74 := yyvsp74 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp13 := yyvsp13 -1
	yyvsp5 := yyvsp5 -1
	yyvsp50 := yyvsp50 -1
	if yyvsp74 >= yyvsc74 then
		if yyvs74 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs74")
			end
			create yyspecial_routines74
			yyvsc74 := yyInitial_yyvs_size
			yyvs74 := yyspecial_routines74.make (yyvsc74)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs74")
			end
			yyvsc74 := yyvsc74 + yyInitial_yyvs_size
			yyvs74 := yyspecial_routines74.resize (yyvs74, yyvsc74)
		end
	end
	yyvs74.put (yyval74, yyvsp74)
end
		end

	yy_do_action_77 is
			--|#line 680 "et_eiffel_parser.y"
		local
			yyval74: ET_FORMAL_PARAMETER
		do
--|#line 680 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 680")
end

			yyval74 := ast_factory.new_constrained_formal_parameter (Void, yyvs13.item (yyvsp13), yyvs5.item (yyvsp5), dummy_constraint (yyvs50.item (yyvsp50)), yyvs49.item (yyvsp49))
			if yyval74 /= Void then
				register_constraint (yyvs50.item (yyvsp50))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp74 := yyvsp74 + 1
	yyvsp13 := yyvsp13 -1
	yyvsp5 := yyvsp5 -1
	yyvsp50 := yyvsp50 -1
	yyvsp49 := yyvsp49 -1
	if yyvsp74 >= yyvsc74 then
		if yyvs74 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs74")
			end
			create yyspecial_routines74
			yyvsc74 := yyInitial_yyvs_size
			yyvs74 := yyspecial_routines74.make (yyvsc74)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs74")
			end
			yyvsc74 := yyvsc74 + yyInitial_yyvs_size
			yyvs74 := yyspecial_routines74.resize (yyvs74, yyvsc74)
		end
	end
	yyvs74.put (yyval74, yyvsp74)
end
		end

	yy_do_action_78 is
			--|#line 687 "et_eiffel_parser.y"
		local
			yyval74: ET_FORMAL_PARAMETER
		do
--|#line 687 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 687")
end

			yyval74 := ast_factory.new_constrained_formal_parameter (yyvs2.item (yyvsp2), yyvs13.item (yyvsp13), yyvs5.item (yyvsp5), dummy_constraint (yyvs50.item (yyvsp50)), yyvs49.item (yyvsp49))
			if yyval74 /= Void then
				register_constraint (yyvs50.item (yyvsp50))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp74 := yyvsp74 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp13 := yyvsp13 -1
	yyvsp5 := yyvsp5 -1
	yyvsp50 := yyvsp50 -1
	yyvsp49 := yyvsp49 -1
	if yyvsp74 >= yyvsc74 then
		if yyvs74 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs74")
			end
			create yyspecial_routines74
			yyvsc74 := yyInitial_yyvs_size
			yyvs74 := yyspecial_routines74.make (yyvsc74)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs74")
			end
			yyvsc74 := yyvsc74 + yyInitial_yyvs_size
			yyvs74 := yyspecial_routines74.resize (yyvs74, yyvsc74)
		end
	end
	yyvs74.put (yyval74, yyvsp74)
end
		end

	yy_do_action_79 is
			--|#line 694 "et_eiffel_parser.y"
		local
			yyval74: ET_FORMAL_PARAMETER
		do
--|#line 694 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 694")
end

			yyval74 := ast_factory.new_constrained_formal_parameter (yyvs2.item (yyvsp2), yyvs13.item (yyvsp13), yyvs5.item (yyvsp5), dummy_constraint (yyvs50.item (yyvsp50)), yyvs49.item (yyvsp49))
			if yyval74 /= Void then
				register_constraint (yyvs50.item (yyvsp50))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp74 := yyvsp74 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp13 := yyvsp13 -1
	yyvsp5 := yyvsp5 -1
	yyvsp50 := yyvsp50 -1
	yyvsp49 := yyvsp49 -1
	if yyvsp74 >= yyvsc74 then
		if yyvs74 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs74")
			end
			create yyspecial_routines74
			yyvsc74 := yyInitial_yyvs_size
			yyvs74 := yyspecial_routines74.make (yyvsc74)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs74")
			end
			yyvsc74 := yyvsc74 + yyInitial_yyvs_size
			yyvs74 := yyspecial_routines74.resize (yyvs74, yyvsc74)
		end
	end
	yyvs74.put (yyval74, yyvsp74)
end
		end

	yy_do_action_80 is
			--|#line 703 "et_eiffel_parser.y"
		local
			yyval49: ET_CONSTRAINT_CREATOR
		do
--|#line 703 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 703")
end

yyval49 := ast_factory.new_constraint_creator (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2), 0) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp49 := yyvsp49 + 1
	yyvsp2 := yyvsp2 -2
	if yyvsp49 >= yyvsc49 then
		if yyvs49 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs49")
			end
			create yyspecial_routines49
			yyvsc49 := yyInitial_yyvs_size
			yyvs49 := yyspecial_routines49.make (yyvsc49)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs49")
			end
			yyvsc49 := yyvsc49 + yyInitial_yyvs_size
			yyvs49 := yyspecial_routines49.resize (yyvs49, yyvsc49)
		end
	end
	yyvs49.put (yyval49, yyvsp49)
end
		end

	yy_do_action_81 is
			--|#line 705 "et_eiffel_parser.y"
		local
			yyval49: ET_CONSTRAINT_CREATOR
		do
--|#line 705 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 705")
end

			yyval49 := yyvs49.item (yyvsp49)
			remove_keyword
			remove_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp49 := yyvsp49 -1
	yyvsp2 := yyvsp2 -1
	yyvs49.put (yyval49, yyvsp49)
end
		end

	yy_do_action_82 is
			--|#line 705 "et_eiffel_parser.y"
		local
			yyval49: ET_CONSTRAINT_CREATOR
		do
--|#line 705 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 705")
end

			add_keyword (yyvs2.item (yyvsp2))
			add_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp49 := yyvsp49 + 1
	if yyvsp49 >= yyvsc49 then
		if yyvs49 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs49")
			end
			create yyspecial_routines49
			yyvsc49 := yyInitial_yyvs_size
			yyvs49 := yyspecial_routines49.make (yyvsc49)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs49")
			end
			yyvsc49 := yyvsc49 + yyInitial_yyvs_size
			yyvs49 := yyspecial_routines49.resize (yyvs49, yyvsc49)
		end
	end
	yyvs49.put (yyval49, yyvsp49)
end
		end

	yy_do_action_83 is
			--|#line 718 "et_eiffel_parser.y"
		local
			yyval49: ET_CONSTRAINT_CREATOR
		do
--|#line 718 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 718")
end

			if yyvs13.item (yyvsp13) /= Void then
				yyval49 := ast_factory.new_constraint_creator (last_keyword, yyvs2.item (yyvsp2), counter_value + 1)
				if yyval49 /= Void then
					yyval49.put_first (yyvs13.item (yyvsp13))
				end
			else
				yyval49 := ast_factory.new_constraint_creator (last_keyword, yyvs2.item (yyvsp2), counter_value)
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp49 := yyvsp49 + 1
	yyvsp13 := yyvsp13 -1
	yyvsp2 := yyvsp2 -1
	if yyvsp49 >= yyvsc49 then
		if yyvs49 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs49")
			end
			create yyspecial_routines49
			yyvsc49 := yyInitial_yyvs_size
			yyvs49 := yyspecial_routines49.make (yyvsc49)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs49")
			end
			yyvsc49 := yyvsc49 + yyInitial_yyvs_size
			yyvs49 := yyspecial_routines49.resize (yyvs49, yyvsc49)
		end
	end
	yyvs49.put (yyval49, yyvsp49)
end
		end

	yy_do_action_84 is
			--|#line 729 "et_eiffel_parser.y"
		local
			yyval49: ET_CONSTRAINT_CREATOR
		do
--|#line 729 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 729")
end

			yyval49 := ast_factory.new_constraint_creator (last_keyword, yyvs2.item (yyvsp2), counter_value)
			if yyval49 /= Void and yyvs70.item (yyvsp70) /= Void then
				yyval49.put_first (yyvs70.item (yyvsp70))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp49 := yyvsp49 + 1
	yyvsp70 := yyvsp70 -1
	yyvsp2 := yyvsp2 -1
	if yyvsp49 >= yyvsc49 then
		if yyvs49 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs49")
			end
			create yyspecial_routines49
			yyvsc49 := yyInitial_yyvs_size
			yyvs49 := yyspecial_routines49.make (yyvsc49)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs49")
			end
			yyvsc49 := yyvsc49 + yyInitial_yyvs_size
			yyvs49 := yyspecial_routines49.resize (yyvs49, yyvsc49)
		end
	end
	yyvs49.put (yyval49, yyvsp49)
end
		end

	yy_do_action_85 is
			--|#line 737 "et_eiffel_parser.y"
		local
			yyval49: ET_CONSTRAINT_CREATOR
		do
--|#line 737 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 737")
end

			yyval49 := yyvs49.item (yyvsp49)
			if yyval49 /= Void and yyvs70.item (yyvsp70) /= Void then
				yyval49.put_first (yyvs70.item (yyvsp70))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp70 := yyvsp70 -1
	yyvs49.put (yyval49, yyvsp49)
end
		end

	yy_do_action_86 is
			--|#line 746 "et_eiffel_parser.y"
		local
			yyval50: ET_CONSTRAINT_TYPE
		do
--|#line 746 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 746")
end

yyval50 := new_constraint_named_type (Void, yyvs13.item (yyvsp13), yyvs48.item (yyvsp48)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp50 := yyvsp50 + 1
	yyvsp13 := yyvsp13 -1
	yyvsp48 := yyvsp48 -1
	if yyvsp50 >= yyvsc50 then
		if yyvs50 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs50")
			end
			create yyspecial_routines50
			yyvsc50 := yyInitial_yyvs_size
			yyvs50 := yyspecial_routines50.make (yyvsc50)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs50")
			end
			yyvsc50 := yyvsc50 + yyInitial_yyvs_size
			yyvs50 := yyspecial_routines50.resize (yyvs50, yyvsc50)
		end
	end
	yyvs50.put (yyval50, yyvsp50)
end
		end

	yy_do_action_87 is
			--|#line 748 "et_eiffel_parser.y"
		local
			yyval50: ET_CONSTRAINT_TYPE
		do
--|#line 748 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 748")
end

yyval50 := new_constraint_named_type (yyvs2.item (yyvsp2), yyvs13.item (yyvsp13), yyvs48.item (yyvsp48)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp50 := yyvsp50 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp13 := yyvsp13 -1
	yyvsp48 := yyvsp48 -1
	if yyvsp50 >= yyvsc50 then
		if yyvs50 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs50")
			end
			create yyspecial_routines50
			yyvsc50 := yyInitial_yyvs_size
			yyvs50 := yyspecial_routines50.make (yyvsc50)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs50")
			end
			yyvsc50 := yyvsc50 + yyInitial_yyvs_size
			yyvs50 := yyspecial_routines50.resize (yyvs50, yyvsc50)
		end
	end
	yyvs50.put (yyval50, yyvsp50)
end
		end

	yy_do_action_88 is
			--|#line 750 "et_eiffel_parser.y"
		local
			yyval50: ET_CONSTRAINT_TYPE
		do
--|#line 750 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 750")
end

yyval50 := new_constraint_named_type (yyvs2.item (yyvsp2), yyvs13.item (yyvsp13), yyvs48.item (yyvsp48)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp50 := yyvsp50 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp13 := yyvsp13 -1
	yyvsp48 := yyvsp48 -1
	if yyvsp50 >= yyvsc50 then
		if yyvs50 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs50")
			end
			create yyspecial_routines50
			yyvsc50 := yyInitial_yyvs_size
			yyvs50 := yyspecial_routines50.make (yyvsc50)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs50")
			end
			yyvsc50 := yyvsc50 + yyInitial_yyvs_size
			yyvs50 := yyspecial_routines50.resize (yyvs50, yyvsc50)
		end
	end
	yyvs50.put (yyval50, yyvsp50)
end
		end

	yy_do_action_89 is
			--|#line 752 "et_eiffel_parser.y"
		local
			yyval50: ET_CONSTRAINT_TYPE
		do
--|#line 752 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 752")
end

yyval50 := new_constraint_named_type (yyvs2.item (yyvsp2), yyvs13.item (yyvsp13), yyvs48.item (yyvsp48)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp50 := yyvsp50 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp13 := yyvsp13 -1
	yyvsp48 := yyvsp48 -1
	if yyvsp50 >= yyvsc50 then
		if yyvs50 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs50")
			end
			create yyspecial_routines50
			yyvsc50 := yyInitial_yyvs_size
			yyvs50 := yyspecial_routines50.make (yyvsc50)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs50")
			end
			yyvsc50 := yyvsc50 + yyInitial_yyvs_size
			yyvs50 := yyspecial_routines50.resize (yyvs50, yyvsc50)
		end
	end
	yyvs50.put (yyval50, yyvsp50)
end
		end

	yy_do_action_90 is
			--|#line 754 "et_eiffel_parser.y"
		local
			yyval50: ET_CONSTRAINT_TYPE
		do
--|#line 754 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 754")
end

			if current_system.is_ise and then current_system.ise_version < ise_6_1_0 then
				raise_error
			else
				yyval50 := new_constraint_named_type (yyvs5.item (yyvsp5), yyvs13.item (yyvsp13), yyvs48.item (yyvsp48))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp50 := yyvsp50 + 1
	yyvsp5 := yyvsp5 -1
	yyvsp13 := yyvsp13 -1
	yyvsp48 := yyvsp48 -1
	if yyvsp50 >= yyvsc50 then
		if yyvs50 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs50")
			end
			create yyspecial_routines50
			yyvsc50 := yyInitial_yyvs_size
			yyvs50 := yyspecial_routines50.make (yyvsc50)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs50")
			end
			yyvsc50 := yyvsc50 + yyInitial_yyvs_size
			yyvs50 := yyspecial_routines50.resize (yyvs50, yyvsc50)
		end
	end
	yyvs50.put (yyval50, yyvsp50)
end
		end

	yy_do_action_91 is
			--|#line 762 "et_eiffel_parser.y"
		local
			yyval50: ET_CONSTRAINT_TYPE
		do
--|#line 762 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 762")
end

			if current_system.is_ise and then current_system.ise_version < ise_6_1_0 then
				raise_error
			else
				yyval50 := new_constraint_named_type (yyvs24.item (yyvsp24), yyvs13.item (yyvsp13), yyvs48.item (yyvsp48))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp50 := yyvsp50 + 1
	yyvsp24 := yyvsp24 -1
	yyvsp13 := yyvsp13 -1
	yyvsp48 := yyvsp48 -1
	if yyvsp50 >= yyvsc50 then
		if yyvs50 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs50")
			end
			create yyspecial_routines50
			yyvsc50 := yyInitial_yyvs_size
			yyvs50 := yyspecial_routines50.make (yyvsc50)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs50")
			end
			yyvsc50 := yyvsc50 + yyInitial_yyvs_size
			yyvs50 := yyspecial_routines50.resize (yyvs50, yyvsc50)
		end
	end
	yyvs50.put (yyval50, yyvsp50)
end
		end

	yy_do_action_92 is
			--|#line 770 "et_eiffel_parser.y"
		local
			yyval50: ET_CONSTRAINT_TYPE
		do
--|#line 770 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 770")
end

yyval50 := yyvs88.item (yyvsp88) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp50 := yyvsp50 + 1
	yyvsp88 := yyvsp88 -1
	if yyvsp50 >= yyvsc50 then
		if yyvs50 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs50")
			end
			create yyspecial_routines50
			yyvsc50 := yyInitial_yyvs_size
			yyvs50 := yyspecial_routines50.make (yyvsc50)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs50")
			end
			yyvsc50 := yyvsc50 + yyInitial_yyvs_size
			yyvs50 := yyspecial_routines50.resize (yyvs50, yyvsc50)
		end
	end
	yyvs50.put (yyval50, yyvsp50)
end
		end

	yy_do_action_93 is
			--|#line 772 "et_eiffel_parser.y"
		local
			yyval50: ET_CONSTRAINT_TYPE
		do
--|#line 772 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 772")
end

yyval50 := new_bit_n (yyvs13.item (yyvsp13), yyvs14.item (yyvsp14)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp50 := yyvsp50 + 1
	yyvsp13 := yyvsp13 -1
	yyvsp14 := yyvsp14 -1
	if yyvsp50 >= yyvsc50 then
		if yyvs50 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs50")
			end
			create yyspecial_routines50
			yyvsc50 := yyInitial_yyvs_size
			yyvs50 := yyspecial_routines50.make (yyvsc50)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs50")
			end
			yyvsc50 := yyvsc50 + yyInitial_yyvs_size
			yyvs50 := yyspecial_routines50.resize (yyvs50, yyvsc50)
		end
	end
	yyvs50.put (yyval50, yyvsp50)
end
		end

	yy_do_action_94 is
			--|#line 774 "et_eiffel_parser.y"
		local
			yyval50: ET_CONSTRAINT_TYPE
		do
--|#line 774 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 774")
end

yyval50 := new_bit_feature (yyvs13.item (yyvsp13 - 1), yyvs13.item (yyvsp13))  
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp50 := yyvsp50 + 1
	yyvsp13 := yyvsp13 -2
	if yyvsp50 >= yyvsc50 then
		if yyvs50 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs50")
			end
			create yyspecial_routines50
			yyvsc50 := yyInitial_yyvs_size
			yyvs50 := yyspecial_routines50.make (yyvsc50)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs50")
			end
			yyvsc50 := yyvsc50 + yyInitial_yyvs_size
			yyvs50 := yyspecial_routines50.resize (yyvs50, yyvsc50)
		end
	end
	yyvs50.put (yyval50, yyvsp50)
end
		end

	yy_do_action_95 is
			--|#line 776 "et_eiffel_parser.y"
		local
			yyval50: ET_CONSTRAINT_TYPE
		do
--|#line 776 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 776")
end

yyval50 := new_constraint_named_type (Void, yyvs13.item (yyvsp13), yyvs48.item (yyvsp48)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp50 := yyvsp50 + 1
	yyvsp13 := yyvsp13 -1
	yyvsp48 := yyvsp48 -1
	if yyvsp50 >= yyvsc50 then
		if yyvs50 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs50")
			end
			create yyspecial_routines50
			yyvsc50 := yyInitial_yyvs_size
			yyvs50 := yyspecial_routines50.make (yyvsc50)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs50")
			end
			yyvsc50 := yyvsc50 + yyInitial_yyvs_size
			yyvs50 := yyspecial_routines50.resize (yyvs50, yyvsc50)
		end
	end
	yyvs50.put (yyval50, yyvsp50)
end
		end

	yy_do_action_96 is
			--|#line 778 "et_eiffel_parser.y"
		local
			yyval50: ET_CONSTRAINT_TYPE
		do
--|#line 778 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 778")
end

			if current_system.is_ise and then current_system.ise_version < ise_6_1_0 then
				raise_error
			else
				yyval50 := new_constraint_named_type (yyvs5.item (yyvsp5), yyvs13.item (yyvsp13), yyvs48.item (yyvsp48))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp50 := yyvsp50 + 1
	yyvsp5 := yyvsp5 -1
	yyvsp13 := yyvsp13 -1
	yyvsp48 := yyvsp48 -1
	if yyvsp50 >= yyvsc50 then
		if yyvs50 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs50")
			end
			create yyspecial_routines50
			yyvsc50 := yyInitial_yyvs_size
			yyvs50 := yyspecial_routines50.make (yyvsc50)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs50")
			end
			yyvsc50 := yyvsc50 + yyInitial_yyvs_size
			yyvs50 := yyspecial_routines50.resize (yyvs50, yyvsc50)
		end
	end
	yyvs50.put (yyval50, yyvsp50)
end
		end

	yy_do_action_97 is
			--|#line 786 "et_eiffel_parser.y"
		local
			yyval50: ET_CONSTRAINT_TYPE
		do
--|#line 786 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 786")
end

			if current_system.is_ise and then current_system.ise_version < ise_6_1_0 then
				raise_error
			else
				yyval50 := new_constraint_named_type (yyvs24.item (yyvsp24), yyvs13.item (yyvsp13), yyvs48.item (yyvsp48))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp50 := yyvsp50 + 1
	yyvsp24 := yyvsp24 -1
	yyvsp13 := yyvsp13 -1
	yyvsp48 := yyvsp48 -1
	if yyvsp50 >= yyvsc50 then
		if yyvs50 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs50")
			end
			create yyspecial_routines50
			yyvsc50 := yyInitial_yyvs_size
			yyvs50 := yyspecial_routines50.make (yyvsc50)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs50")
			end
			yyvsc50 := yyvsc50 + yyInitial_yyvs_size
			yyvs50 := yyspecial_routines50.resize (yyvs50, yyvsc50)
		end
	end
	yyvs50.put (yyval50, yyvsp50)
end
		end

	yy_do_action_98 is
			--|#line 796 "et_eiffel_parser.y"
		local
			yyval50: ET_CONSTRAINT_TYPE
		do
--|#line 796 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 796")
end

yyval50 := new_constraint_named_type (Void, yyvs13.item (yyvsp13), yyvs48.item (yyvsp48)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp50 := yyvsp50 + 1
	yyvsp13 := yyvsp13 -1
	yyvsp48 := yyvsp48 -1
	if yyvsp50 >= yyvsc50 then
		if yyvs50 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs50")
			end
			create yyspecial_routines50
			yyvsc50 := yyInitial_yyvs_size
			yyvs50 := yyspecial_routines50.make (yyvsc50)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs50")
			end
			yyvsc50 := yyvsc50 + yyInitial_yyvs_size
			yyvs50 := yyspecial_routines50.resize (yyvs50, yyvsc50)
		end
	end
	yyvs50.put (yyval50, yyvsp50)
end
		end

	yy_do_action_99 is
			--|#line 798 "et_eiffel_parser.y"
		local
			yyval50: ET_CONSTRAINT_TYPE
		do
--|#line 798 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 798")
end

yyval50 := new_constraint_named_type (yyvs2.item (yyvsp2), yyvs13.item (yyvsp13), yyvs48.item (yyvsp48)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp50 := yyvsp50 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp13 := yyvsp13 -1
	yyvsp48 := yyvsp48 -1
	if yyvsp50 >= yyvsc50 then
		if yyvs50 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs50")
			end
			create yyspecial_routines50
			yyvsc50 := yyInitial_yyvs_size
			yyvs50 := yyspecial_routines50.make (yyvsc50)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs50")
			end
			yyvsc50 := yyvsc50 + yyInitial_yyvs_size
			yyvs50 := yyspecial_routines50.resize (yyvs50, yyvsc50)
		end
	end
	yyvs50.put (yyval50, yyvsp50)
end
		end

	yy_do_action_100 is
			--|#line 800 "et_eiffel_parser.y"
		local
			yyval50: ET_CONSTRAINT_TYPE
		do
--|#line 800 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 800")
end

yyval50 := new_constraint_named_type (yyvs2.item (yyvsp2), yyvs13.item (yyvsp13), yyvs48.item (yyvsp48)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp50 := yyvsp50 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp13 := yyvsp13 -1
	yyvsp48 := yyvsp48 -1
	if yyvsp50 >= yyvsc50 then
		if yyvs50 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs50")
			end
			create yyspecial_routines50
			yyvsc50 := yyInitial_yyvs_size
			yyvs50 := yyspecial_routines50.make (yyvsc50)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs50")
			end
			yyvsc50 := yyvsc50 + yyInitial_yyvs_size
			yyvs50 := yyspecial_routines50.resize (yyvs50, yyvsc50)
		end
	end
	yyvs50.put (yyval50, yyvsp50)
end
		end

	yy_do_action_101 is
			--|#line 802 "et_eiffel_parser.y"
		local
			yyval50: ET_CONSTRAINT_TYPE
		do
--|#line 802 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 802")
end

yyval50 := new_constraint_named_type (yyvs2.item (yyvsp2), yyvs13.item (yyvsp13), yyvs48.item (yyvsp48)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp50 := yyvsp50 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp13 := yyvsp13 -1
	yyvsp48 := yyvsp48 -1
	if yyvsp50 >= yyvsc50 then
		if yyvs50 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs50")
			end
			create yyspecial_routines50
			yyvsc50 := yyInitial_yyvs_size
			yyvs50 := yyspecial_routines50.make (yyvsc50)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs50")
			end
			yyvsc50 := yyvsc50 + yyInitial_yyvs_size
			yyvs50 := yyspecial_routines50.resize (yyvs50, yyvsc50)
		end
	end
	yyvs50.put (yyval50, yyvsp50)
end
		end

	yy_do_action_102 is
			--|#line 804 "et_eiffel_parser.y"
		local
			yyval50: ET_CONSTRAINT_TYPE
		do
--|#line 804 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 804")
end

			if current_system.is_ise and then current_system.ise_version < ise_6_1_0 then
				raise_error
			else
				yyval50 := new_constraint_named_type (yyvs5.item (yyvsp5), yyvs13.item (yyvsp13), yyvs48.item (yyvsp48))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp50 := yyvsp50 + 1
	yyvsp5 := yyvsp5 -1
	yyvsp13 := yyvsp13 -1
	yyvsp48 := yyvsp48 -1
	if yyvsp50 >= yyvsc50 then
		if yyvs50 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs50")
			end
			create yyspecial_routines50
			yyvsc50 := yyInitial_yyvs_size
			yyvs50 := yyspecial_routines50.make (yyvsc50)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs50")
			end
			yyvsc50 := yyvsc50 + yyInitial_yyvs_size
			yyvs50 := yyspecial_routines50.resize (yyvs50, yyvsc50)
		end
	end
	yyvs50.put (yyval50, yyvsp50)
end
		end

	yy_do_action_103 is
			--|#line 812 "et_eiffel_parser.y"
		local
			yyval50: ET_CONSTRAINT_TYPE
		do
--|#line 812 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 812")
end

			if current_system.is_ise and then current_system.ise_version < ise_6_1_0 then
				raise_error
			else
				yyval50 := new_constraint_named_type (yyvs24.item (yyvsp24), yyvs13.item (yyvsp13), yyvs48.item (yyvsp48))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp50 := yyvsp50 + 1
	yyvsp24 := yyvsp24 -1
	yyvsp13 := yyvsp13 -1
	yyvsp48 := yyvsp48 -1
	if yyvsp50 >= yyvsc50 then
		if yyvs50 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs50")
			end
			create yyspecial_routines50
			yyvsc50 := yyInitial_yyvs_size
			yyvs50 := yyspecial_routines50.make (yyvsc50)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs50")
			end
			yyvsc50 := yyvsc50 + yyInitial_yyvs_size
			yyvs50 := yyspecial_routines50.resize (yyvs50, yyvsc50)
		end
	end
	yyvs50.put (yyval50, yyvsp50)
end
		end

	yy_do_action_104 is
			--|#line 820 "et_eiffel_parser.y"
		local
			yyval50: ET_CONSTRAINT_TYPE
		do
--|#line 820 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 820")
end

yyval50 := yyvs88.item (yyvsp88) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp50 := yyvsp50 + 1
	yyvsp88 := yyvsp88 -1
	if yyvsp50 >= yyvsc50 then
		if yyvs50 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs50")
			end
			create yyspecial_routines50
			yyvsc50 := yyInitial_yyvs_size
			yyvs50 := yyspecial_routines50.make (yyvsc50)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs50")
			end
			yyvsc50 := yyvsc50 + yyInitial_yyvs_size
			yyvs50 := yyspecial_routines50.resize (yyvs50, yyvsc50)
		end
	end
	yyvs50.put (yyval50, yyvsp50)
end
		end

	yy_do_action_105 is
			--|#line 822 "et_eiffel_parser.y"
		local
			yyval50: ET_CONSTRAINT_TYPE
		do
--|#line 822 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 822")
end

yyval50 := new_bit_n (yyvs13.item (yyvsp13), yyvs14.item (yyvsp14)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp50 := yyvsp50 + 1
	yyvsp13 := yyvsp13 -1
	yyvsp14 := yyvsp14 -1
	if yyvsp50 >= yyvsc50 then
		if yyvs50 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs50")
			end
			create yyspecial_routines50
			yyvsc50 := yyInitial_yyvs_size
			yyvs50 := yyspecial_routines50.make (yyvsc50)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs50")
			end
			yyvsc50 := yyvsc50 + yyInitial_yyvs_size
			yyvs50 := yyspecial_routines50.resize (yyvs50, yyvsc50)
		end
	end
	yyvs50.put (yyval50, yyvsp50)
end
		end

	yy_do_action_106 is
			--|#line 824 "et_eiffel_parser.y"
		local
			yyval50: ET_CONSTRAINT_TYPE
		do
--|#line 824 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 824")
end

yyval50 := new_bit_feature (yyvs13.item (yyvsp13 - 1), yyvs13.item (yyvsp13))  
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp50 := yyvsp50 + 1
	yyvsp13 := yyvsp13 -2
	if yyvsp50 >= yyvsc50 then
		if yyvs50 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs50")
			end
			create yyspecial_routines50
			yyvsc50 := yyInitial_yyvs_size
			yyvs50 := yyspecial_routines50.make (yyvsc50)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs50")
			end
			yyvsc50 := yyvsc50 + yyInitial_yyvs_size
			yyvs50 := yyspecial_routines50.resize (yyvs50, yyvsc50)
		end
	end
	yyvs50.put (yyval50, yyvsp50)
end
		end

	yy_do_action_107 is
			--|#line 826 "et_eiffel_parser.y"
		local
			yyval50: ET_CONSTRAINT_TYPE
		do
--|#line 826 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 826")
end

yyval50 := new_constraint_named_type (Void, yyvs13.item (yyvsp13), yyvs48.item (yyvsp48)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp50 := yyvsp50 + 1
	yyvsp13 := yyvsp13 -1
	yyvsp48 := yyvsp48 -1
	if yyvsp50 >= yyvsc50 then
		if yyvs50 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs50")
			end
			create yyspecial_routines50
			yyvsc50 := yyInitial_yyvs_size
			yyvs50 := yyspecial_routines50.make (yyvsc50)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs50")
			end
			yyvsc50 := yyvsc50 + yyInitial_yyvs_size
			yyvs50 := yyspecial_routines50.resize (yyvs50, yyvsc50)
		end
	end
	yyvs50.put (yyval50, yyvsp50)
end
		end

	yy_do_action_108 is
			--|#line 828 "et_eiffel_parser.y"
		local
			yyval50: ET_CONSTRAINT_TYPE
		do
--|#line 828 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 828")
end

			if current_system.is_ise and then current_system.ise_version < ise_6_1_0 then
				raise_error
			else
				yyval50 := new_constraint_named_type (yyvs5.item (yyvsp5), yyvs13.item (yyvsp13), yyvs48.item (yyvsp48))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp50 := yyvsp50 + 1
	yyvsp5 := yyvsp5 -1
	yyvsp13 := yyvsp13 -1
	yyvsp48 := yyvsp48 -1
	if yyvsp50 >= yyvsc50 then
		if yyvs50 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs50")
			end
			create yyspecial_routines50
			yyvsc50 := yyInitial_yyvs_size
			yyvs50 := yyspecial_routines50.make (yyvsc50)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs50")
			end
			yyvsc50 := yyvsc50 + yyInitial_yyvs_size
			yyvs50 := yyspecial_routines50.resize (yyvs50, yyvsc50)
		end
	end
	yyvs50.put (yyval50, yyvsp50)
end
		end

	yy_do_action_109 is
			--|#line 836 "et_eiffel_parser.y"
		local
			yyval50: ET_CONSTRAINT_TYPE
		do
--|#line 836 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 836")
end

			if current_system.is_ise and then current_system.ise_version < ise_6_1_0 then
				raise_error
			else
				yyval50 := new_constraint_named_type (yyvs24.item (yyvsp24), yyvs13.item (yyvsp13), yyvs48.item (yyvsp48))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp50 := yyvsp50 + 1
	yyvsp24 := yyvsp24 -1
	yyvsp13 := yyvsp13 -1
	yyvsp48 := yyvsp48 -1
	if yyvsp50 >= yyvsc50 then
		if yyvs50 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs50")
			end
			create yyspecial_routines50
			yyvsc50 := yyInitial_yyvs_size
			yyvs50 := yyspecial_routines50.make (yyvsc50)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs50")
			end
			yyvsc50 := yyvsc50 + yyInitial_yyvs_size
			yyvs50 := yyspecial_routines50.resize (yyvs50, yyvsc50)
		end
	end
	yyvs50.put (yyval50, yyvsp50)
end
		end

	yy_do_action_110 is
			--|#line 846 "et_eiffel_parser.y"
		local
			yyval48: ET_CONSTRAINT_ACTUAL_PARAMETER_LIST
		do
--|#line 846 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 846")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp48 := yyvsp48 + 1
	if yyvsp48 >= yyvsc48 then
		if yyvs48 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs48")
			end
			create yyspecial_routines48
			yyvsc48 := yyInitial_yyvs_size
			yyvs48 := yyspecial_routines48.make (yyvsc48)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs48")
			end
			yyvsc48 := yyvsc48 + yyInitial_yyvs_size
			yyvs48 := yyspecial_routines48.resize (yyvs48, yyvsc48)
		end
	end
	yyvs48.put (yyval48, yyvsp48)
end
		end

	yy_do_action_111 is
			--|#line 848 "et_eiffel_parser.y"
		local
			yyval48: ET_CONSTRAINT_ACTUAL_PARAMETER_LIST
		do
--|#line 848 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 848")
end

yyval48 := yyvs48.item (yyvsp48) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs48.put (yyval48, yyvsp48)
end
		end

	yy_do_action_112 is
			--|#line 852 "et_eiffel_parser.y"
		local
			yyval48: ET_CONSTRAINT_ACTUAL_PARAMETER_LIST
		do
--|#line 852 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 852")
end

yyval48 := ast_factory.new_constraint_actual_parameters (yyvs23.item (yyvsp23), yyvs5.item (yyvsp5), 0) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp48 := yyvsp48 + 1
	yyvsp23 := yyvsp23 -1
	yyvsp5 := yyvsp5 -1
	if yyvsp48 >= yyvsc48 then
		if yyvs48 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs48")
			end
			create yyspecial_routines48
			yyvsc48 := yyInitial_yyvs_size
			yyvs48 := yyspecial_routines48.make (yyvsc48)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs48")
			end
			yyvsc48 := yyvsc48 + yyInitial_yyvs_size
			yyvs48 := yyspecial_routines48.resize (yyvs48, yyvsc48)
		end
	end
	yyvs48.put (yyval48, yyvsp48)
end
		end

	yy_do_action_113 is
			--|#line 855 "et_eiffel_parser.y"
		local
			yyval48: ET_CONSTRAINT_ACTUAL_PARAMETER_LIST
		do
--|#line 855 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 855")
end

			yyval48 := yyvs48.item (yyvsp48)
			remove_symbol
			remove_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs48.put (yyval48, yyvsp48)
end
		end

	yy_do_action_114 is
			--|#line 863 "et_eiffel_parser.y"
		local
			yyval48: ET_CONSTRAINT_ACTUAL_PARAMETER_LIST
		do
--|#line 863 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 863")
end

			if yyvs50.item (yyvsp50) /= Void then
				yyval48 := ast_factory.new_constraint_actual_parameters (last_symbol, yyvs5.item (yyvsp5), counter_value + 1)
				if yyval48 /= Void then
					yyval48.put_first (yyvs50.item (yyvsp50))
				end
			else
				yyval48 := ast_factory.new_constraint_actual_parameters (last_symbol, yyvs5.item (yyvsp5), counter_value)
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp48 := yyvsp48 + 1
	yyvsp50 := yyvsp50 -1
	yyvsp5 := yyvsp5 -1
	if yyvsp48 >= yyvsc48 then
		if yyvs48 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs48")
			end
			create yyspecial_routines48
			yyvsc48 := yyInitial_yyvs_size
			yyvs48 := yyspecial_routines48.make (yyvsc48)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs48")
			end
			yyvsc48 := yyvsc48 + yyInitial_yyvs_size
			yyvs48 := yyspecial_routines48.resize (yyvs48, yyvsc48)
		end
	end
	yyvs48.put (yyval48, yyvsp48)
end
		end

	yy_do_action_115 is
			--|#line 874 "et_eiffel_parser.y"
		local
			yyval48: ET_CONSTRAINT_ACTUAL_PARAMETER_LIST
		do
--|#line 874 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 874")
end

			yyval48 := yyvs48.item (yyvsp48)
			add_to_constraint_actual_parameter_list (yyvs47.item (yyvsp47), yyval48)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp47 := yyvsp47 -1
	yyvs48.put (yyval48, yyvsp48)
end
		end

	yy_do_action_116 is
			--|#line 879 "et_eiffel_parser.y"
		local
			yyval48: ET_CONSTRAINT_ACTUAL_PARAMETER_LIST
		do
--|#line 879 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 879")
end

			yyval48 := yyvs48.item (yyvsp48)
			add_to_constraint_actual_parameter_list (ast_factory.new_constraint_actual_parameter_comma (new_constraint_named_type (Void, yyvs13.item (yyvsp13), Void), yyvs5.item (yyvsp5)), yyval48)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp13 := yyvsp13 -1
	yyvsp5 := yyvsp5 -1
	yyvsp1 := yyvsp1 -1
	yyvs48.put (yyval48, yyvsp48)
end
		end

	yy_do_action_117 is
			--|#line 884 "et_eiffel_parser.y"
		local
			yyval48: ET_CONSTRAINT_ACTUAL_PARAMETER_LIST
		do
--|#line 884 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 884")
end

			yyval48 := yyvs48.item (yyvsp48)
			add_to_constraint_actual_parameter_list (ast_factory.new_constraint_actual_parameter_comma (new_constraint_named_type (Void, yyvs13.item (yyvsp13), Void), yyvs5.item (yyvsp5)), yyval48)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp13 := yyvsp13 -1
	yyvsp5 := yyvsp5 -1
	yyvsp1 := yyvsp1 -1
	yyvs48.put (yyval48, yyvsp48)
end
		end

	yy_do_action_118 is
			--|#line 891 "et_eiffel_parser.y"
		local
			yyval47: ET_CONSTRAINT_ACTUAL_PARAMETER_ITEM
		do
--|#line 891 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 891")
end

			yyval47 := ast_factory.new_constraint_actual_parameter_comma (yyvs50.item (yyvsp50), yyvs5.item (yyvsp5))
			if yyval47 /= Void then
				increment_counter
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp47 := yyvsp47 + 1
	yyvsp50 := yyvsp50 -1
	yyvsp5 := yyvsp5 -1
	if yyvsp47 >= yyvsc47 then
		if yyvs47 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs47")
			end
			create yyspecial_routines47
			yyvsc47 := yyInitial_yyvs_size
			yyvs47 := yyspecial_routines47.make (yyvsc47)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs47")
			end
			yyvsc47 := yyvsc47 + yyInitial_yyvs_size
			yyvs47 := yyspecial_routines47.resize (yyvs47, yyvsc47)
		end
	end
	yyvs47.put (yyval47, yyvsp47)
end
		end

	yy_do_action_119 is
			--|#line 900 "et_eiffel_parser.y"
		local
			yyval48: ET_CONSTRAINT_ACTUAL_PARAMETER_LIST
		do
--|#line 900 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 900")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp48 := yyvsp48 + 1
	if yyvsp48 >= yyvsc48 then
		if yyvs48 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs48")
			end
			create yyspecial_routines48
			yyvsc48 := yyInitial_yyvs_size
			yyvs48 := yyspecial_routines48.make (yyvsc48)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs48")
			end
			yyvsc48 := yyvsc48 + yyInitial_yyvs_size
			yyvs48 := yyspecial_routines48.resize (yyvs48, yyvsc48)
		end
	end
	yyvs48.put (yyval48, yyvsp48)
end
		end

	yy_do_action_120 is
			--|#line 902 "et_eiffel_parser.y"
		local
			yyval48: ET_CONSTRAINT_ACTUAL_PARAMETER_LIST
		do
--|#line 902 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 902")
end

yyval48 := yyvs48.item (yyvsp48) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs48.put (yyval48, yyvsp48)
end
		end

	yy_do_action_121 is
			--|#line 906 "et_eiffel_parser.y"
		local
			yyval48: ET_CONSTRAINT_ACTUAL_PARAMETER_LIST
		do
--|#line 906 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 906")
end

yyval48 := ast_factory.new_constraint_actual_parameters (yyvs23.item (yyvsp23), yyvs5.item (yyvsp5), 0) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp48 := yyvsp48 + 1
	yyvsp23 := yyvsp23 -1
	yyvsp5 := yyvsp5 -1
	if yyvsp48 >= yyvsc48 then
		if yyvs48 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs48")
			end
			create yyspecial_routines48
			yyvsc48 := yyInitial_yyvs_size
			yyvs48 := yyspecial_routines48.make (yyvsc48)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs48")
			end
			yyvsc48 := yyvsc48 + yyInitial_yyvs_size
			yyvs48 := yyspecial_routines48.resize (yyvs48, yyvsc48)
		end
	end
	yyvs48.put (yyval48, yyvsp48)
end
		end

	yy_do_action_122 is
			--|#line 909 "et_eiffel_parser.y"
		local
			yyval48: ET_CONSTRAINT_ACTUAL_PARAMETER_LIST
		do
--|#line 909 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 909")
end

			yyval48 := yyvs48.item (yyvsp48)
			remove_symbol
			remove_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs48.put (yyval48, yyvsp48)
end
		end

	yy_do_action_123 is
			--|#line 915 "et_eiffel_parser.y"
		local
			yyval48: ET_CONSTRAINT_ACTUAL_PARAMETER_LIST
		do
--|#line 915 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 915")
end

			yyval48 := yyvs48.item (yyvsp48)
			remove_symbol
			remove_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs48.put (yyval48, yyvsp48)
end
		end

	yy_do_action_124 is
			--|#line 923 "et_eiffel_parser.y"
		local
			yyval48: ET_CONSTRAINT_ACTUAL_PARAMETER_LIST
		do
--|#line 923 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 923")
end

			yyval48 := ast_factory.new_constraint_actual_parameters (last_symbol, yyvs5.item (yyvsp5), counter_value + 1)
			add_to_constraint_actual_parameter_list (ast_factory.new_constraint_labeled_actual_parameter (yyvs13.item (yyvsp13), yyvs5.item (yyvsp5 - 1), yyvs50.item (yyvsp50)), yyval48)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp48 := yyvsp48 + 1
	yyvsp13 := yyvsp13 -1
	yyvsp5 := yyvsp5 -2
	yyvsp50 := yyvsp50 -1
	if yyvsp48 >= yyvsc48 then
		if yyvs48 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs48")
			end
			create yyspecial_routines48
			yyvsc48 := yyInitial_yyvs_size
			yyvs48 := yyspecial_routines48.make (yyvsc48)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs48")
			end
			yyvsc48 := yyvsc48 + yyInitial_yyvs_size
			yyvs48 := yyspecial_routines48.resize (yyvs48, yyvsc48)
		end
	end
	yyvs48.put (yyval48, yyvsp48)
end
		end

	yy_do_action_125 is
			--|#line 928 "et_eiffel_parser.y"
		local
			yyval48: ET_CONSTRAINT_ACTUAL_PARAMETER_LIST
		do
--|#line 928 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 928")
end

			yyval48 := yyvs48.item (yyvsp48)
			add_to_constraint_actual_parameter_list (yyvs47.item (yyvsp47), yyvs48.item (yyvsp48))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp47 := yyvsp47 -1
	yyvs48.put (yyval48, yyvsp48)
end
		end

	yy_do_action_126 is
			--|#line 933 "et_eiffel_parser.y"
		local
			yyval48: ET_CONSTRAINT_ACTUAL_PARAMETER_LIST
		do
--|#line 933 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 933")
end

			yyval48 := yyvs48.item (yyvsp48)
			add_to_constraint_actual_parameter_list (yyvs47.item (yyvsp47), yyvs48.item (yyvsp48))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp47 := yyvsp47 -1
	yyvs48.put (yyval48, yyvsp48)
end
		end

	yy_do_action_127 is
			--|#line 938 "et_eiffel_parser.y"
		local
			yyval48: ET_CONSTRAINT_ACTUAL_PARAMETER_LIST
		do
--|#line 938 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 938")
end

			yyval48 := yyvs48.item (yyvsp48)
			if yyval48 /= Void then
				if not yyval48.is_empty then
					add_to_constraint_actual_parameter_list (ast_factory.new_constraint_labeled_comma_actual_parameter (yyvs13.item (yyvsp13), yyvs5.item (yyvsp5), yyval48.first.type), yyval48)
				else
					add_to_constraint_actual_parameter_list (ast_factory.new_constraint_labeled_comma_actual_parameter (yyvs13.item (yyvsp13), yyvs5.item (yyvsp5), Void), yyval48)
				end
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp13 := yyvsp13 -1
	yyvsp5 := yyvsp5 -1
	yyvsp1 := yyvsp1 -1
	yyvs48.put (yyval48, yyvsp48)
end
		end

	yy_do_action_128 is
			--|#line 949 "et_eiffel_parser.y"
		local
			yyval48: ET_CONSTRAINT_ACTUAL_PARAMETER_LIST
		do
--|#line 949 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 949")
end

			yyval48 := yyvs48.item (yyvsp48)
			if yyval48 /= Void then
				if not yyval48.is_empty then
					add_to_constraint_actual_parameter_list (ast_factory.new_constraint_labeled_comma_actual_parameter (yyvs13.item (yyvsp13), yyvs5.item (yyvsp5), yyval48.first.type), yyval48)
				else
					add_to_constraint_actual_parameter_list (ast_factory.new_constraint_labeled_comma_actual_parameter (yyvs13.item (yyvsp13), yyvs5.item (yyvsp5), Void), yyval48)
				end
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp13 := yyvsp13 -1
	yyvsp5 := yyvsp5 -1
	yyvsp1 := yyvsp1 -1
	yyvs48.put (yyval48, yyvsp48)
end
		end

	yy_do_action_129 is
			--|#line 960 "et_eiffel_parser.y"
		local
			yyval48: ET_CONSTRAINT_ACTUAL_PARAMETER_LIST
		do
--|#line 960 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 960")
end

			yyval48 := yyvs48.item (yyvsp48)
			if yyval48 /= Void then
				if not yyval48.is_empty then
					add_to_constraint_actual_parameter_list (ast_factory.new_constraint_labeled_comma_actual_parameter (yyvs13.item (yyvsp13), yyvs5.item (yyvsp5), yyval48.first.type), yyval48)
				else
					add_to_constraint_actual_parameter_list (ast_factory.new_constraint_labeled_comma_actual_parameter (yyvs13.item (yyvsp13), yyvs5.item (yyvsp5), Void), yyval48)
				end
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp13 := yyvsp13 -1
	yyvsp5 := yyvsp5 -1
	yyvsp1 := yyvsp1 -1
	yyvs48.put (yyval48, yyvsp48)
end
		end

	yy_do_action_130 is
			--|#line 973 "et_eiffel_parser.y"
		local
			yyval47: ET_CONSTRAINT_ACTUAL_PARAMETER_ITEM
		do
--|#line 973 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 973")
end

			yyval47 := ast_factory.new_constraint_labeled_actual_parameter (yyvs13.item (yyvsp13), yyvs5.item (yyvsp5), yyvs50.item (yyvsp50))
			if yyval47 /= Void then
				increment_counter
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp47 := yyvsp47 + 1
	yyvsp13 := yyvsp13 -1
	yyvsp5 := yyvsp5 -1
	yyvsp50 := yyvsp50 -1
	if yyvsp47 >= yyvsc47 then
		if yyvs47 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs47")
			end
			create yyspecial_routines47
			yyvsc47 := yyInitial_yyvs_size
			yyvs47 := yyspecial_routines47.make (yyvsc47)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs47")
			end
			yyvsc47 := yyvsc47 + yyInitial_yyvs_size
			yyvs47 := yyspecial_routines47.resize (yyvs47, yyvsc47)
		end
	end
	yyvs47.put (yyval47, yyvsp47)
end
		end

	yy_do_action_131 is
			--|#line 982 "et_eiffel_parser.y"
		local
			yyval47: ET_CONSTRAINT_ACTUAL_PARAMETER_ITEM
		do
--|#line 982 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 982")
end

			yyval47 := ast_factory.new_constraint_labeled_actual_parameter_semicolon (ast_factory.new_constraint_labeled_actual_parameter (yyvs13.item (yyvsp13), yyvs5.item (yyvsp5), yyvs50.item (yyvsp50)), yyvs22.item (yyvsp22))
			if yyval47 /= Void then
				increment_counter
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp47 := yyvsp47 + 1
	yyvsp13 := yyvsp13 -1
	yyvsp5 := yyvsp5 -1
	yyvsp50 := yyvsp50 -1
	yyvsp22 := yyvsp22 -1
	if yyvsp47 >= yyvsc47 then
		if yyvs47 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs47")
			end
			create yyspecial_routines47
			yyvsc47 := yyInitial_yyvs_size
			yyvs47 := yyspecial_routines47.make (yyvsc47)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs47")
			end
			yyvsc47 := yyvsc47 + yyInitial_yyvs_size
			yyvs47 := yyspecial_routines47.resize (yyvs47, yyvsc47)
		end
	end
	yyvs47.put (yyval47, yyvsp47)
end
		end

	yy_do_action_132 is
			--|#line 993 "et_eiffel_parser.y"
		local
			yyval98: ET_OBSOLETE
		do
--|#line 993 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 993")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp98 := yyvsp98 + 1
	if yyvsp98 >= yyvsc98 then
		if yyvs98 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs98")
			end
			create yyspecial_routines98
			yyvsc98 := yyInitial_yyvs_size
			yyvs98 := yyspecial_routines98.make (yyvsc98)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs98")
			end
			yyvsc98 := yyvsc98 + yyInitial_yyvs_size
			yyvs98 := yyspecial_routines98.resize (yyvs98, yyvsc98)
		end
	end
	yyvs98.put (yyval98, yyvsp98)
end
		end

	yy_do_action_133 is
			--|#line 995 "et_eiffel_parser.y"
		local
			yyval98: ET_OBSOLETE
		do
--|#line 995 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 995")
end

yyval98 := ast_factory.new_obsolete_message (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp98 := yyvsp98 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp98 >= yyvsc98 then
		if yyvs98 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs98")
			end
			create yyspecial_routines98
			yyvsc98 := yyInitial_yyvs_size
			yyvs98 := yyspecial_routines98.make (yyvsc98)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs98")
			end
			yyvsc98 := yyvsc98 + yyInitial_yyvs_size
			yyvs98 := yyspecial_routines98.resize (yyvs98, yyvsc98)
		end
	end
	yyvs98.put (yyval98, yyvsp98)
end
		end

	yy_do_action_134 is
			--|#line 1001 "et_eiffel_parser.y"
		local
			yyval102: ET_PARENT_LIST
		do
--|#line 1001 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1001")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp102 := yyvsp102 + 1
	if yyvsp102 >= yyvsc102 then
		if yyvs102 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs102")
			end
			create yyspecial_routines102
			yyvsc102 := yyInitial_yyvs_size
			yyvs102 := yyspecial_routines102.make (yyvsc102)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs102")
			end
			yyvsc102 := yyvsc102 + yyInitial_yyvs_size
			yyvs102 := yyspecial_routines102.resize (yyvs102, yyvsc102)
		end
	end
	yyvs102.put (yyval102, yyvsp102)
end
		end

	yy_do_action_135 is
			--|#line 1003 "et_eiffel_parser.y"
		local
			yyval102: ET_PARENT_LIST
		do
--|#line 1003 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1003")
end

yyval102 := ast_factory.new_parents (yyvs2.item (yyvsp2), 0) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp102 := yyvsp102 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp102 >= yyvsc102 then
		if yyvs102 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs102")
			end
			create yyspecial_routines102
			yyvsc102 := yyInitial_yyvs_size
			yyvs102 := yyspecial_routines102.make (yyvsc102)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs102")
			end
			yyvsc102 := yyvsc102 + yyInitial_yyvs_size
			yyvs102 := yyspecial_routines102.resize (yyvs102, yyvsc102)
		end
	end
	yyvs102.put (yyval102, yyvsp102)
end
		end

	yy_do_action_136 is
			--|#line 1005 "et_eiffel_parser.y"
		local
			yyval102: ET_PARENT_LIST
		do
--|#line 1005 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1005")
end

			yyval102 := yyvs102.item (yyvsp102)
			remove_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs102.put (yyval102, yyvsp102)
end
		end

	yy_do_action_137 is
			--|#line 1012 "et_eiffel_parser.y"
		local
			yyval102: ET_PARENT_LIST
		do
--|#line 1012 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1012")
end

			yyval102 := yyvs102.item (yyvsp102)
			remove_keyword
			remove_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs102.put (yyval102, yyvsp102)
end
		end

	yy_do_action_138 is
			--|#line 1020 "et_eiffel_parser.y"
		local
			yyval1: ANY
		do
--|#line 1020 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1020")
end

			add_keyword (yyvs2.item (yyvsp2))
			add_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp1 := yyvsp1 + 1
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
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_139 is
			--|#line 1027 "et_eiffel_parser.y"
		local
			yyval100: ET_PARENT
		do
--|#line 1027 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1027")
end

			yyval100 := new_parent (yyvs13.item (yyvsp13), yyvs27.item (yyvsp27), Void, Void, Void, Void, Void, Void)
			if yyval100 /= Void then
				increment_counter
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp100 := yyvsp100 + 1
	yyvsp13 := yyvsp13 -1
	yyvsp27 := yyvsp27 -1
	if yyvsp100 >= yyvsc100 then
		if yyvs100 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs100")
			end
			create yyspecial_routines100
			yyvsc100 := yyInitial_yyvs_size
			yyvs100 := yyspecial_routines100.make (yyvsc100)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs100")
			end
			yyvsc100 := yyvsc100 + yyInitial_yyvs_size
			yyvs100 := yyspecial_routines100.resize (yyvs100, yyvsc100)
		end
	end
	yyvs100.put (yyval100, yyvsp100)
end
		end

	yy_do_action_140 is
			--|#line 1034 "et_eiffel_parser.y"
		local
			yyval100: ET_PARENT
		do
--|#line 1034 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1034")
end

			yyval100 := new_parent (yyvs13.item (yyvsp13), yyvs27.item (yyvsp27), yyvs109.item (yyvsp109), yyvs61.item (yyvsp61), yyvs87.item (yyvsp87 - 2), yyvs87.item (yyvsp87 - 1), yyvs87.item (yyvsp87), yyvs2.item (yyvsp2))
			if yyval100 /= Void then
				increment_counter
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 8
	yyvsp100 := yyvsp100 + 1
	yyvsp13 := yyvsp13 -1
	yyvsp27 := yyvsp27 -1
	yyvsp109 := yyvsp109 -1
	yyvsp61 := yyvsp61 -1
	yyvsp87 := yyvsp87 -3
	yyvsp2 := yyvsp2 -1
	if yyvsp100 >= yyvsc100 then
		if yyvs100 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs100")
			end
			create yyspecial_routines100
			yyvsc100 := yyInitial_yyvs_size
			yyvs100 := yyspecial_routines100.make (yyvsc100)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs100")
			end
			yyvsc100 := yyvsc100 + yyInitial_yyvs_size
			yyvs100 := yyspecial_routines100.resize (yyvs100, yyvsc100)
		end
	end
	yyvs100.put (yyval100, yyvsp100)
end
		end

	yy_do_action_141 is
			--|#line 1042 "et_eiffel_parser.y"
		local
			yyval100: ET_PARENT
		do
--|#line 1042 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1042")
end

			yyval100 := new_parent (yyvs13.item (yyvsp13), yyvs27.item (yyvsp27), Void, yyvs61.item (yyvsp61), yyvs87.item (yyvsp87 - 2), yyvs87.item (yyvsp87 - 1), yyvs87.item (yyvsp87), yyvs2.item (yyvsp2))
			if yyval100 /= Void then
				increment_counter
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp100 := yyvsp100 + 1
	yyvsp13 := yyvsp13 -1
	yyvsp27 := yyvsp27 -1
	yyvsp61 := yyvsp61 -1
	yyvsp87 := yyvsp87 -3
	yyvsp2 := yyvsp2 -1
	if yyvsp100 >= yyvsc100 then
		if yyvs100 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs100")
			end
			create yyspecial_routines100
			yyvsc100 := yyInitial_yyvs_size
			yyvs100 := yyspecial_routines100.make (yyvsc100)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs100")
			end
			yyvsc100 := yyvsc100 + yyInitial_yyvs_size
			yyvs100 := yyspecial_routines100.resize (yyvs100, yyvsc100)
		end
	end
	yyvs100.put (yyval100, yyvsp100)
end
		end

	yy_do_action_142 is
			--|#line 1049 "et_eiffel_parser.y"
		local
			yyval100: ET_PARENT
		do
--|#line 1049 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1049")
end

			yyval100 := new_parent (yyvs13.item (yyvsp13), yyvs27.item (yyvsp27), Void, Void, yyvs87.item (yyvsp87 - 2), yyvs87.item (yyvsp87 - 1), yyvs87.item (yyvsp87), yyvs2.item (yyvsp2))
			if yyval100 /= Void then
				increment_counter
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp100 := yyvsp100 + 1
	yyvsp13 := yyvsp13 -1
	yyvsp27 := yyvsp27 -1
	yyvsp87 := yyvsp87 -3
	yyvsp2 := yyvsp2 -1
	if yyvsp100 >= yyvsc100 then
		if yyvs100 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs100")
			end
			create yyspecial_routines100
			yyvsc100 := yyInitial_yyvs_size
			yyvs100 := yyspecial_routines100.make (yyvsc100)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs100")
			end
			yyvsc100 := yyvsc100 + yyInitial_yyvs_size
			yyvs100 := yyspecial_routines100.resize (yyvs100, yyvsc100)
		end
	end
	yyvs100.put (yyval100, yyvsp100)
end
		end

	yy_do_action_143 is
			--|#line 1056 "et_eiffel_parser.y"
		local
			yyval100: ET_PARENT
		do
--|#line 1056 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1056")
end

			yyval100 := new_parent (yyvs13.item (yyvsp13), yyvs27.item (yyvsp27), Void, Void, Void, yyvs87.item (yyvsp87 - 1), yyvs87.item (yyvsp87), yyvs2.item (yyvsp2))
			if yyval100 /= Void then
				increment_counter
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp100 := yyvsp100 + 1
	yyvsp13 := yyvsp13 -1
	yyvsp27 := yyvsp27 -1
	yyvsp87 := yyvsp87 -2
	yyvsp2 := yyvsp2 -1
	if yyvsp100 >= yyvsc100 then
		if yyvs100 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs100")
			end
			create yyspecial_routines100
			yyvsc100 := yyInitial_yyvs_size
			yyvs100 := yyspecial_routines100.make (yyvsc100)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs100")
			end
			yyvsc100 := yyvsc100 + yyInitial_yyvs_size
			yyvs100 := yyspecial_routines100.resize (yyvs100, yyvsc100)
		end
	end
	yyvs100.put (yyval100, yyvsp100)
end
		end

	yy_do_action_144 is
			--|#line 1063 "et_eiffel_parser.y"
		local
			yyval100: ET_PARENT
		do
--|#line 1063 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1063")
end

			yyval100 := new_parent (yyvs13.item (yyvsp13), yyvs27.item (yyvsp27), Void, Void, Void, Void, yyvs87.item (yyvsp87), yyvs2.item (yyvsp2))
			if yyval100 /= Void then
				increment_counter
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp100 := yyvsp100 + 1
	yyvsp13 := yyvsp13 -1
	yyvsp27 := yyvsp27 -1
	yyvsp87 := yyvsp87 -1
	yyvsp2 := yyvsp2 -1
	if yyvsp100 >= yyvsc100 then
		if yyvs100 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs100")
			end
			create yyspecial_routines100
			yyvsc100 := yyInitial_yyvs_size
			yyvs100 := yyspecial_routines100.make (yyvsc100)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs100")
			end
			yyvsc100 := yyvsc100 + yyInitial_yyvs_size
			yyvs100 := yyspecial_routines100.resize (yyvs100, yyvsc100)
		end
	end
	yyvs100.put (yyval100, yyvsp100)
end
		end

	yy_do_action_145 is
			--|#line 1072 "et_eiffel_parser.y"
		local
			yyval100: ET_PARENT
		do
--|#line 1072 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1072")
end

			yyval100 := new_parent (yyvs13.item (yyvsp13), yyvs27.item (yyvsp27), Void, Void, Void, Void, Void, yyvs2.item (yyvsp2))
			if yyval100 /= Void then
				increment_counter
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp100 := yyvsp100 + 1
	yyvsp13 := yyvsp13 -1
	yyvsp27 := yyvsp27 -1
	yyvsp2 := yyvsp2 -1
	if yyvsp100 >= yyvsc100 then
		if yyvs100 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs100")
			end
			create yyspecial_routines100
			yyvsc100 := yyInitial_yyvs_size
			yyvs100 := yyspecial_routines100.make (yyvsc100)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs100")
			end
			yyvsc100 := yyvsc100 + yyInitial_yyvs_size
			yyvs100 := yyspecial_routines100.resize (yyvs100, yyvsc100)
		end
	end
	yyvs100.put (yyval100, yyvsp100)
end
		end

	yy_do_action_146 is
			--|#line 1081 "et_eiffel_parser.y"
		local
			yyval102: ET_PARENT_LIST
		do
--|#line 1081 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1081")
end

			yyval102 := ast_factory.new_parents (last_keyword, counter_value)
			if yyval102 /= Void and yyvs100.item (yyvsp100) /= Void then
				yyval102.put_first (yyvs100.item (yyvsp100))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp102 := yyvsp102 + 1
	yyvsp100 := yyvsp100 -1
	if yyvsp102 >= yyvsc102 then
		if yyvs102 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs102")
			end
			create yyspecial_routines102
			yyvsc102 := yyInitial_yyvs_size
			yyvs102 := yyspecial_routines102.make (yyvsc102)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs102")
			end
			yyvsc102 := yyvsc102 + yyInitial_yyvs_size
			yyvs102 := yyspecial_routines102.resize (yyvs102, yyvsc102)
		end
	end
	yyvs102.put (yyval102, yyvsp102)
end
		end

	yy_do_action_147 is
			--|#line 1088 "et_eiffel_parser.y"
		local
			yyval102: ET_PARENT_LIST
		do
--|#line 1088 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1088")
end

			yyval102 := ast_factory.new_parents (last_keyword, counter_value)
			if yyval102 /= Void and yyvs101.item (yyvsp101) /= Void then
				yyval102.put_first (yyvs101.item (yyvsp101))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp102 := yyvsp102 + 1
	yyvsp101 := yyvsp101 -1
	if yyvsp102 >= yyvsc102 then
		if yyvs102 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs102")
			end
			create yyspecial_routines102
			yyvsc102 := yyInitial_yyvs_size
			yyvs102 := yyspecial_routines102.make (yyvsc102)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs102")
			end
			yyvsc102 := yyvsc102 + yyInitial_yyvs_size
			yyvs102 := yyspecial_routines102.resize (yyvs102, yyvsc102)
		end
	end
	yyvs102.put (yyval102, yyvsp102)
end
		end

	yy_do_action_148 is
			--|#line 1095 "et_eiffel_parser.y"
		local
			yyval102: ET_PARENT_LIST
		do
--|#line 1095 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1095")
end

			yyval102 := yyvs102.item (yyvsp102)
			if yyval102 /= Void and yyvs100.item (yyvsp100) /= Void then
				yyval102.put_first (yyvs100.item (yyvsp100))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp100 := yyvsp100 -1
	yyvs102.put (yyval102, yyvsp102)
end
		end

	yy_do_action_149 is
			--|#line 1102 "et_eiffel_parser.y"
		local
			yyval102: ET_PARENT_LIST
		do
--|#line 1102 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1102")
end

			yyval102 := yyvs102.item (yyvsp102)
			if yyval102 /= Void and yyvs100.item (yyvsp100) /= Void then
				yyval102.put_first (yyvs100.item (yyvsp100))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp100 := yyvsp100 -1
	yyvs102.put (yyval102, yyvsp102)
end
		end

	yy_do_action_150 is
			--|#line 1109 "et_eiffel_parser.y"
		local
			yyval102: ET_PARENT_LIST
		do
--|#line 1109 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1109")
end

			yyval102 := yyvs102.item (yyvsp102)
			if yyval102 /= Void and yyvs101.item (yyvsp101) /= Void then
				yyval102.put_first (yyvs101.item (yyvsp101))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp101 := yyvsp101 -1
	yyvs102.put (yyval102, yyvsp102)
end
		end

	yy_do_action_151 is
			--|#line 1118 "et_eiffel_parser.y"
		local
			yyval102: ET_PARENT_LIST
		do
--|#line 1118 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1118")
end

			yyval102 := ast_factory.new_parents (last_keyword, counter_value)
			if yyval102 /= Void and yyvs100.item (yyvsp100) /= Void then
				yyval102.put_first (yyvs100.item (yyvsp100))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp102 := yyvsp102 + 1
	yyvsp100 := yyvsp100 -1
	if yyvsp102 >= yyvsc102 then
		if yyvs102 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs102")
			end
			create yyspecial_routines102
			yyvsc102 := yyInitial_yyvs_size
			yyvs102 := yyspecial_routines102.make (yyvsc102)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs102")
			end
			yyvsc102 := yyvsc102 + yyInitial_yyvs_size
			yyvs102 := yyspecial_routines102.resize (yyvs102, yyvsc102)
		end
	end
	yyvs102.put (yyval102, yyvsp102)
end
		end

	yy_do_action_152 is
			--|#line 1125 "et_eiffel_parser.y"
		local
			yyval102: ET_PARENT_LIST
		do
--|#line 1125 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1125")
end

			yyval102 := yyvs102.item (yyvsp102)
			if yyval102 /= Void and yyvs100.item (yyvsp100) /= Void then
				yyval102.put_first (yyvs100.item (yyvsp100))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp100 := yyvsp100 -1
	yyvs102.put (yyval102, yyvsp102)
end
		end

	yy_do_action_153 is
			--|#line 1132 "et_eiffel_parser.y"
		local
			yyval102: ET_PARENT_LIST
		do
--|#line 1132 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1132")
end

			yyval102 := yyvs102.item (yyvsp102)
			if yyval102 /= Void and yyvs100.item (yyvsp100) /= Void then
				yyval102.put_first (yyvs100.item (yyvsp100))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp100 := yyvsp100 -1
	yyvs102.put (yyval102, yyvsp102)
end
		end

	yy_do_action_154 is
			--|#line 1139 "et_eiffel_parser.y"
		local
			yyval102: ET_PARENT_LIST
		do
--|#line 1139 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1139")
end

			yyval102 := yyvs102.item (yyvsp102)
			if yyval102 /= Void and yyvs101.item (yyvsp101) /= Void then
				yyval102.put_first (yyvs101.item (yyvsp101))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp101 := yyvsp101 -1
	yyvs102.put (yyval102, yyvsp102)
end
		end

	yy_do_action_155 is
			--|#line 1148 "et_eiffel_parser.y"
		local
			yyval101: ET_PARENT_ITEM
		do
--|#line 1148 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1148")
end

			yyval101 := ast_factory.new_parent_semicolon (yyvs100.item (yyvsp100), yyvs22.item (yyvsp22))
			if yyval101 /= Void and yyvs100.item (yyvsp100) = Void then
				increment_counter
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp101 := yyvsp101 + 1
	yyvsp100 := yyvsp100 -1
	yyvsp22 := yyvsp22 -1
	if yyvsp101 >= yyvsc101 then
		if yyvs101 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs101")
			end
			create yyspecial_routines101
			yyvsc101 := yyInitial_yyvs_size
			yyvs101 := yyspecial_routines101.make (yyvsc101)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs101")
			end
			yyvsc101 := yyvsc101 + yyInitial_yyvs_size
			yyvs101 := yyspecial_routines101.resize (yyvs101, yyvsc101)
		end
	end
	yyvs101.put (yyval101, yyvsp101)
end
		end

	yy_do_action_156 is
			--|#line 1155 "et_eiffel_parser.y"
		local
			yyval101: ET_PARENT_ITEM
		do
--|#line 1155 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1155")
end

			yyval101 := ast_factory.new_parent_semicolon (yyvs100.item (yyvsp100), yyvs22.item (yyvsp22))
			if yyval101 /= Void and yyvs100.item (yyvsp100) = Void then
				increment_counter
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp101 := yyvsp101 + 1
	yyvsp100 := yyvsp100 -1
	yyvsp22 := yyvsp22 -1
	if yyvsp101 >= yyvsc101 then
		if yyvs101 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs101")
			end
			create yyspecial_routines101
			yyvsc101 := yyInitial_yyvs_size
			yyvs101 := yyspecial_routines101.make (yyvsc101)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs101")
			end
			yyvsc101 := yyvsc101 + yyInitial_yyvs_size
			yyvs101 := yyspecial_routines101.resize (yyvs101, yyvsc101)
		end
	end
	yyvs101.put (yyval101, yyvsp101)
end
		end

	yy_do_action_157 is
			--|#line 1166 "et_eiffel_parser.y"
		local
			yyval109: ET_RENAME_LIST
		do
--|#line 1166 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1166")
end

yyval109 := ast_factory.new_renames (yyvs2.item (yyvsp2), 0) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp109 := yyvsp109 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp109 >= yyvsc109 then
		if yyvs109 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs109")
			end
			create yyspecial_routines109
			yyvsc109 := yyInitial_yyvs_size
			yyvs109 := yyspecial_routines109.make (yyvsc109)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs109")
			end
			yyvsc109 := yyvsc109 + yyInitial_yyvs_size
			yyvs109 := yyspecial_routines109.resize (yyvs109, yyvsc109)
		end
	end
	yyvs109.put (yyval109, yyvsp109)
end
		end

	yy_do_action_158 is
			--|#line 1168 "et_eiffel_parser.y"
		local
			yyval109: ET_RENAME_LIST
		do
--|#line 1168 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1168")
end

			yyval109 := yyvs109.item (yyvsp109)
			remove_keyword
			remove_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp109 := yyvsp109 -1
	yyvsp2 := yyvsp2 -1
	yyvs109.put (yyval109, yyvsp109)
end
		end

	yy_do_action_159 is
			--|#line 1168 "et_eiffel_parser.y"
		local
			yyval109: ET_RENAME_LIST
		do
--|#line 1168 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1168")
end

			add_keyword (yyvs2.item (yyvsp2))
			add_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp109 := yyvsp109 + 1
	if yyvsp109 >= yyvsc109 then
		if yyvs109 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs109")
			end
			create yyspecial_routines109
			yyvsc109 := yyInitial_yyvs_size
			yyvs109 := yyspecial_routines109.make (yyvsc109)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs109")
			end
			yyvsc109 := yyvsc109 + yyInitial_yyvs_size
			yyvs109 := yyspecial_routines109.resize (yyvs109, yyvsc109)
		end
	end
	yyvs109.put (yyval109, yyvsp109)
end
		end

	yy_do_action_160 is
			--|#line 1181 "et_eiffel_parser.y"
		local
			yyval109: ET_RENAME_LIST
		do
--|#line 1181 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1181")
end

			yyval109 := ast_factory.new_renames (last_keyword, counter_value)
			if yyval109 /= Void and yyvs108.item (yyvsp108) /= Void then
				yyval109.put_first (yyvs108.item (yyvsp108))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp109 := yyvsp109 + 1
	yyvsp108 := yyvsp108 -1
	if yyvsp109 >= yyvsc109 then
		if yyvs109 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs109")
			end
			create yyspecial_routines109
			yyvsc109 := yyInitial_yyvs_size
			yyvs109 := yyspecial_routines109.make (yyvsc109)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs109")
			end
			yyvsc109 := yyvsc109 + yyInitial_yyvs_size
			yyvs109 := yyspecial_routines109.resize (yyvs109, yyvsc109)
		end
	end
	yyvs109.put (yyval109, yyvsp109)
end
		end

	yy_do_action_161 is
			--|#line 1188 "et_eiffel_parser.y"
		local
			yyval109: ET_RENAME_LIST
		do
--|#line 1188 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1188")
end

			yyval109 := ast_factory.new_renames (last_keyword, counter_value)
			if yyval109 /= Void and yyvs108.item (yyvsp108) /= Void then
				yyval109.put_first (yyvs108.item (yyvsp108))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp109 := yyvsp109 + 1
	yyvsp108 := yyvsp108 -1
	if yyvsp109 >= yyvsc109 then
		if yyvs109 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs109")
			end
			create yyspecial_routines109
			yyvsc109 := yyInitial_yyvs_size
			yyvs109 := yyspecial_routines109.make (yyvsc109)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs109")
			end
			yyvsc109 := yyvsc109 + yyInitial_yyvs_size
			yyvs109 := yyspecial_routines109.resize (yyvs109, yyvsc109)
		end
	end
	yyvs109.put (yyval109, yyvsp109)
end
		end

	yy_do_action_162 is
			--|#line 1196 "et_eiffel_parser.y"
		local
			yyval109: ET_RENAME_LIST
		do
--|#line 1196 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1196")
end

			yyval109 := yyvs109.item (yyvsp109)
			if yyval109 /= Void and yyvs108.item (yyvsp108) /= Void then
				yyval109.put_first (yyvs108.item (yyvsp108))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp108 := yyvsp108 -1
	yyvs109.put (yyval109, yyvsp109)
end
		end

	yy_do_action_163 is
			--|#line 1205 "et_eiffel_parser.y"
		local
			yyval108: ET_RENAME_ITEM
		do
--|#line 1205 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1205")
end

			yyval108 := ast_factory.new_rename (yyvs69.item (yyvsp69), yyvs2.item (yyvsp2), yyvs64.item (yyvsp64))
			if yyval108 /= Void then
				increment_counter
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp108 := yyvsp108 + 1
	yyvsp69 := yyvsp69 -1
	yyvsp2 := yyvsp2 -1
	yyvsp64 := yyvsp64 -1
	if yyvsp108 >= yyvsc108 then
		if yyvs108 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs108")
			end
			create yyspecial_routines108
			yyvsc108 := yyInitial_yyvs_size
			yyvs108 := yyspecial_routines108.make (yyvsc108)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs108")
			end
			yyvsc108 := yyvsc108 + yyInitial_yyvs_size
			yyvs108 := yyspecial_routines108.resize (yyvs108, yyvsc108)
		end
	end
	yyvs108.put (yyval108, yyvsp108)
end
		end

	yy_do_action_164 is
			--|#line 1214 "et_eiffel_parser.y"
		local
			yyval108: ET_RENAME_ITEM
		do
--|#line 1214 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1214")
end

			yyval108 := ast_factory.new_rename_comma (yyvs69.item (yyvsp69), yyvs2.item (yyvsp2), yyvs64.item (yyvsp64), yyvs5.item (yyvsp5))
			if yyval108 /= Void then
				increment_counter
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp108 := yyvsp108 + 1
	yyvsp69 := yyvsp69 -1
	yyvsp2 := yyvsp2 -1
	yyvsp64 := yyvsp64 -1
	yyvsp5 := yyvsp5 -1
	if yyvsp108 >= yyvsc108 then
		if yyvs108 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs108")
			end
			create yyspecial_routines108
			yyvsc108 := yyInitial_yyvs_size
			yyvs108 := yyspecial_routines108.make (yyvsc108)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs108")
			end
			yyvsc108 := yyvsc108 + yyInitial_yyvs_size
			yyvs108 := yyspecial_routines108.resize (yyvs108, yyvsc108)
		end
	end
	yyvs108.put (yyval108, yyvsp108)
end
		end

	yy_do_action_165 is
			--|#line 1225 "et_eiffel_parser.y"
		local
			yyval61: ET_EXPORT_LIST
		do
--|#line 1225 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1225")
end

yyval61 := ast_factory.new_exports (yyvs2.item (yyvsp2), 0) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp61 := yyvsp61 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp61 >= yyvsc61 then
		if yyvs61 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs61")
			end
			create yyspecial_routines61
			yyvsc61 := yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.make (yyvsc61)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs61")
			end
			yyvsc61 := yyvsc61 + yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.resize (yyvs61, yyvsc61)
		end
	end
	yyvs61.put (yyval61, yyvsp61)
end
		end

	yy_do_action_166 is
			--|#line 1227 "et_eiffel_parser.y"
		local
			yyval61: ET_EXPORT_LIST
		do
--|#line 1227 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1227")
end

			yyval61 := yyvs61.item (yyvsp61)
			remove_keyword
			remove_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp61 := yyvsp61 -1
	yyvsp2 := yyvsp2 -1
	yyvs61.put (yyval61, yyvsp61)
end
		end

	yy_do_action_167 is
			--|#line 1227 "et_eiffel_parser.y"
		local
			yyval61: ET_EXPORT_LIST
		do
--|#line 1227 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1227")
end

			add_keyword (yyvs2.item (yyvsp2))
			add_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp61 := yyvsp61 + 1
	if yyvsp61 >= yyvsc61 then
		if yyvs61 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs61")
			end
			create yyspecial_routines61
			yyvsc61 := yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.make (yyvsc61)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs61")
			end
			yyvsc61 := yyvsc61 + yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.resize (yyvs61, yyvsc61)
		end
	end
	yyvs61.put (yyval61, yyvsp61)
end
		end

	yy_do_action_168 is
			--|#line 1240 "et_eiffel_parser.y"
		local
			yyval61: ET_EXPORT_LIST
		do
--|#line 1240 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1240")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp61 := yyvsp61 + 1
	if yyvsp61 >= yyvsc61 then
		if yyvs61 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs61")
			end
			create yyspecial_routines61
			yyvsc61 := yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.make (yyvsc61)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs61")
			end
			yyvsc61 := yyvsc61 + yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.resize (yyvs61, yyvsc61)
		end
	end
	yyvs61.put (yyval61, yyvsp61)
end
		end

	yy_do_action_169 is
			--|#line 1242 "et_eiffel_parser.y"
		local
			yyval61: ET_EXPORT_LIST
		do
--|#line 1242 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1242")
end

yyval61 := yyvs61.item (yyvsp61) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs61.put (yyval61, yyvsp61)
end
		end

	yy_do_action_170 is
			--|#line 1246 "et_eiffel_parser.y"
		local
			yyval61: ET_EXPORT_LIST
		do
--|#line 1246 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1246")
end

			if yyvs60.item (yyvsp60) /= Void then
				yyval61 := ast_factory.new_exports (last_keyword, counter_value + 1)
				if yyval61 /= Void then
					yyval61.put_first (yyvs60.item (yyvsp60))
				end
			else
				yyval61 := ast_factory.new_exports (last_keyword, counter_value)
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp61 := yyvsp61 + 1
	yyvsp60 := yyvsp60 -1
	if yyvsp61 >= yyvsc61 then
		if yyvs61 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs61")
			end
			create yyspecial_routines61
			yyvsc61 := yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.make (yyvsc61)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs61")
			end
			yyvsc61 := yyvsc61 + yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.resize (yyvs61, yyvsc61)
		end
	end
	yyvs61.put (yyval61, yyvsp61)
end
		end

	yy_do_action_171 is
			--|#line 1257 "et_eiffel_parser.y"
		local
			yyval61: ET_EXPORT_LIST
		do
--|#line 1257 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1257")
end

			yyval61 := yyvs61.item (yyvsp61)
			if yyval61 /= Void and yyvs60.item (yyvsp60) /= Void then
				yyval61.put_first (yyvs60.item (yyvsp60))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp61 := yyvsp61 -1
	yyvsp60 := yyvsp60 -1
	yyvs61.put (yyval61, yyvsp61)
end
		end

	yy_do_action_172 is
			--|#line 1257 "et_eiffel_parser.y"
		local
			yyval61: ET_EXPORT_LIST
		do
--|#line 1257 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1257")
end

			if yyvs60.item (yyvsp60) /= Void then
				increment_counter
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp61 := yyvsp61 + 1
	if yyvsp61 >= yyvsc61 then
		if yyvs61 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs61")
			end
			create yyspecial_routines61
			yyvsc61 := yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.make (yyvsc61)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs61")
			end
			yyvsc61 := yyvsc61 + yyInitial_yyvs_size
			yyvs61 := yyspecial_routines61.resize (yyvs61, yyvsc61)
		end
	end
	yyvs61.put (yyval61, yyvsp61)
end
		end

	yy_do_action_173 is
			--|#line 1272 "et_eiffel_parser.y"
		local
			yyval60: ET_EXPORT
		do
--|#line 1272 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1272")
end

			yyval60 := ast_factory.new_all_export (yyvs44.item (yyvsp44), yyvs2.item (yyvsp2))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp60 := yyvsp60 + 1
	yyvsp44 := yyvsp44 -1
	yyvsp2 := yyvsp2 -1
	if yyvsp60 >= yyvsc60 then
		if yyvs60 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs60")
			end
			create yyspecial_routines60
			yyvsc60 := yyInitial_yyvs_size
			yyvs60 := yyspecial_routines60.make (yyvsc60)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs60")
			end
			yyvsc60 := yyvsc60 + yyInitial_yyvs_size
			yyvs60 := yyspecial_routines60.resize (yyvs60, yyvsc60)
		end
	end
	yyvs60.put (yyval60, yyvsp60)
end
		end

	yy_do_action_174 is
			--|#line 1276 "et_eiffel_parser.y"
		local
			yyval60: ET_EXPORT
		do
--|#line 1276 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1276")
end

			last_export_clients := yyvs44.item (yyvsp44)
			yyval60 := ast_factory.new_feature_export (last_export_clients, 0)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp60 := yyvsp60 + 1
	yyvsp44 := yyvsp44 -1
	if yyvsp60 >= yyvsc60 then
		if yyvs60 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs60")
			end
			create yyspecial_routines60
			yyvsc60 := yyInitial_yyvs_size
			yyvs60 := yyspecial_routines60.make (yyvsc60)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs60")
			end
			yyvsc60 := yyvsc60 + yyInitial_yyvs_size
			yyvs60 := yyspecial_routines60.resize (yyvs60, yyvsc60)
		end
	end
	yyvs60.put (yyval60, yyvsp60)
end
		end

	yy_do_action_175 is
			--|#line 1281 "et_eiffel_parser.y"
		local
			yyval60: ET_EXPORT
		do
--|#line 1281 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1281")
end

			yyval60 := yyvs68.item (yyvsp68)
			remove_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp44 := yyvsp44 -1
	yyvsp68 := yyvsp68 -1
	yyvs60.put (yyval60, yyvsp60)
end
		end

	yy_do_action_176 is
			--|#line 1281 "et_eiffel_parser.y"
		local
			yyval60: ET_EXPORT
		do
--|#line 1281 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1281")
end

			last_export_clients := yyvs44.item (yyvsp44)
			add_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp60 := yyvsp60 + 1
	if yyvsp60 >= yyvsc60 then
		if yyvs60 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs60")
			end
			create yyspecial_routines60
			yyvsc60 := yyInitial_yyvs_size
			yyvs60 := yyspecial_routines60.make (yyvsc60)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs60")
			end
			yyvsc60 := yyvsc60 + yyInitial_yyvs_size
			yyvs60 := yyspecial_routines60.resize (yyvs60, yyvsc60)
		end
	end
	yyvs60.put (yyval60, yyvsp60)
end
		end

	yy_do_action_177 is
			--|#line 1291 "et_eiffel_parser.y"
		local
			yyval60: ET_EXPORT
		do
--|#line 1291 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1291")
end

yyval60 := ast_factory.new_null_export (yyvs22.item (yyvsp22)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp60 := yyvsp60 + 1
	yyvsp22 := yyvsp22 -1
	if yyvsp60 >= yyvsc60 then
		if yyvs60 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs60")
			end
			create yyspecial_routines60
			yyvsc60 := yyInitial_yyvs_size
			yyvs60 := yyspecial_routines60.make (yyvsc60)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs60")
			end
			yyvsc60 := yyvsc60 + yyInitial_yyvs_size
			yyvs60 := yyspecial_routines60.resize (yyvs60, yyvsc60)
		end
	end
	yyvs60.put (yyval60, yyvsp60)
end
		end

	yy_do_action_178 is
			--|#line 1295 "et_eiffel_parser.y"
		local
			yyval68: ET_FEATURE_EXPORT
		do
--|#line 1295 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1295")
end

			if yyvs69.item (yyvsp69) /= Void then
				yyval68 := ast_factory.new_feature_export (last_export_clients, counter_value + 1)
				if yyval68 /= Void then
					yyval68.put_first (yyvs69.item (yyvsp69))
				end
			else
				yyval68 := ast_factory.new_feature_export (last_export_clients, counter_value)
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp68 := yyvsp68 + 1
	yyvsp69 := yyvsp69 -1
	if yyvsp68 >= yyvsc68 then
		if yyvs68 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs68")
			end
			create yyspecial_routines68
			yyvsc68 := yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.make (yyvsc68)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs68")
			end
			yyvsc68 := yyvsc68 + yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.resize (yyvs68, yyvsc68)
		end
	end
	yyvs68.put (yyval68, yyvsp68)
end
		end

	yy_do_action_179 is
			--|#line 1306 "et_eiffel_parser.y"
		local
			yyval68: ET_FEATURE_EXPORT
		do
--|#line 1306 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1306")
end

			yyval68 := ast_factory.new_feature_export (last_export_clients, counter_value)
			if yyval68 /= Void and yyvs70.item (yyvsp70) /= Void then
				yyval68.put_first (yyvs70.item (yyvsp70))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp68 := yyvsp68 + 1
	yyvsp70 := yyvsp70 -1
	if yyvsp68 >= yyvsc68 then
		if yyvs68 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs68")
			end
			create yyspecial_routines68
			yyvsc68 := yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.make (yyvsc68)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs68")
			end
			yyvsc68 := yyvsc68 + yyInitial_yyvs_size
			yyvs68 := yyspecial_routines68.resize (yyvs68, yyvsc68)
		end
	end
	yyvs68.put (yyval68, yyvsp68)
end
		end

	yy_do_action_180 is
			--|#line 1314 "et_eiffel_parser.y"
		local
			yyval68: ET_FEATURE_EXPORT
		do
--|#line 1314 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1314")
end

			yyval68 := yyvs68.item (yyvsp68)
			if yyval68 /= Void and yyvs70.item (yyvsp70) /= Void then
				yyval68.put_first (yyvs70.item (yyvsp70))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp70 := yyvsp70 -1
	yyvs68.put (yyval68, yyvsp68)
end
		end

	yy_do_action_181 is
			--|#line 1325 "et_eiffel_parser.y"
		local
			yyval44: ET_CLIENTS
		do
--|#line 1325 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1325")
end

			yyval44 := yyvs44.item (yyvsp44)
			remove_symbol
			remove_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp44 := yyvsp44 -1
	yyvsp5 := yyvsp5 -1
	yyvs44.put (yyval44, yyvsp44)
end
		end

	yy_do_action_182 is
			--|#line 1325 "et_eiffel_parser.y"
		local
			yyval44: ET_CLIENTS
		do
--|#line 1325 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1325")
end

			add_symbol (yyvs5.item (yyvsp5))
			add_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp44 := yyvsp44 + 1
	if yyvsp44 >= yyvsc44 then
		if yyvs44 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs44")
			end
			create yyspecial_routines44
			yyvsc44 := yyInitial_yyvs_size
			yyvs44 := yyspecial_routines44.make (yyvsc44)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs44")
			end
			yyvsc44 := yyvsc44 + yyInitial_yyvs_size
			yyvs44 := yyspecial_routines44.resize (yyvs44, yyvsc44)
		end
	end
	yyvs44.put (yyval44, yyvsp44)
end
		end

	yy_do_action_183 is
			--|#line 1336 "et_eiffel_parser.y"
		local
			yyval44: ET_CLIENTS
		do
--|#line 1336 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1336")
end

yyval44 := ast_factory.new_none_clients (yyvs5.item (yyvsp5 - 1), yyvs5.item (yyvsp5)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp44 := yyvsp44 + 1
	yyvsp5 := yyvsp5 -2
	if yyvsp44 >= yyvsc44 then
		if yyvs44 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs44")
			end
			create yyspecial_routines44
			yyvsc44 := yyInitial_yyvs_size
			yyvs44 := yyspecial_routines44.make (yyvsc44)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs44")
			end
			yyvsc44 := yyvsc44 + yyInitial_yyvs_size
			yyvs44 := yyspecial_routines44.resize (yyvs44, yyvsc44)
		end
	end
	yyvs44.put (yyval44, yyvsp44)
end
		end

	yy_do_action_184 is
			--|#line 1340 "et_eiffel_parser.y"
		local
			yyval44: ET_CLIENTS
		do
--|#line 1340 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1340")
end

			yyval44 := ast_factory.new_clients (last_symbol, yyvs5.item (yyvsp5), counter_value)
			if yyval44 /= Void and yyvs43.item (yyvsp43) /= Void then
				yyval44.put_first (yyvs43.item (yyvsp43))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp44 := yyvsp44 + 1
	yyvsp43 := yyvsp43 -1
	yyvsp5 := yyvsp5 -1
	if yyvsp44 >= yyvsc44 then
		if yyvs44 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs44")
			end
			create yyspecial_routines44
			yyvsc44 := yyInitial_yyvs_size
			yyvs44 := yyspecial_routines44.make (yyvsc44)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs44")
			end
			yyvsc44 := yyvsc44 + yyInitial_yyvs_size
			yyvs44 := yyspecial_routines44.resize (yyvs44, yyvsc44)
		end
	end
	yyvs44.put (yyval44, yyvsp44)
end
		end

	yy_do_action_185 is
			--|#line 1347 "et_eiffel_parser.y"
		local
			yyval44: ET_CLIENTS
		do
--|#line 1347 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1347")
end

			yyval44 := ast_factory.new_clients (last_symbol, yyvs5.item (yyvsp5), counter_value)
			if yyval44 /= Void and yyvs43.item (yyvsp43) /= Void then
				yyval44.put_first (yyvs43.item (yyvsp43))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp44 := yyvsp44 + 1
	yyvsp43 := yyvsp43 -1
	yyvsp5 := yyvsp5 -1
	if yyvsp44 >= yyvsc44 then
		if yyvs44 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs44")
			end
			create yyspecial_routines44
			yyvsc44 := yyInitial_yyvs_size
			yyvs44 := yyspecial_routines44.make (yyvsc44)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs44")
			end
			yyvsc44 := yyvsc44 + yyInitial_yyvs_size
			yyvs44 := yyspecial_routines44.resize (yyvs44, yyvsc44)
		end
	end
	yyvs44.put (yyval44, yyvsp44)
end
		end

	yy_do_action_186 is
			--|#line 1355 "et_eiffel_parser.y"
		local
			yyval44: ET_CLIENTS
		do
--|#line 1355 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1355")
end

			yyval44 := yyvs44.item (yyvsp44)
			if yyval44 /= Void and yyvs43.item (yyvsp43) /= Void then
				yyval44.put_first (yyvs43.item (yyvsp43))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp43 := yyvsp43 -1
	yyvs44.put (yyval44, yyvsp44)
end
		end

	yy_do_action_187 is
			--|#line 1362 "et_eiffel_parser.y"
		local
			yyval44: ET_CLIENTS
		do
--|#line 1362 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1362")
end

			yyval44 := yyvs44.item (yyvsp44)
			if yyval44 /= Void and yyvs43.item (yyvsp43) /= Void then
				yyval44.put_first (yyvs43.item (yyvsp43))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp43 := yyvsp43 -1
	yyvs44.put (yyval44, yyvsp44)
end
		end

	yy_do_action_188 is
			--|#line 1372 "et_eiffel_parser.y"
		local
			yyval43: ET_CLIENT_ITEM
		do
--|#line 1372 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1372")
end

			yyval43 := new_client (yyvs13.item (yyvsp13))
			if yyval43 /= Void then
				increment_counter
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp43 := yyvsp43 + 1
	yyvsp13 := yyvsp13 -1
	if yyvsp43 >= yyvsc43 then
		if yyvs43 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs43")
			end
			create yyspecial_routines43
			yyvsc43 := yyInitial_yyvs_size
			yyvs43 := yyspecial_routines43.make (yyvsc43)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs43")
			end
			yyvsc43 := yyvsc43 + yyInitial_yyvs_size
			yyvs43 := yyspecial_routines43.resize (yyvs43, yyvsc43)
		end
	end
	yyvs43.put (yyval43, yyvsp43)
end
		end

	yy_do_action_189 is
			--|#line 1381 "et_eiffel_parser.y"
		local
			yyval43: ET_CLIENT_ITEM
		do
--|#line 1381 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1381")
end

			yyval43 := new_client_comma (yyvs13.item (yyvsp13), yyvs5.item (yyvsp5))
			if yyval43 /= Void then
				increment_counter
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp43 := yyvsp43 + 1
	yyvsp13 := yyvsp13 -1
	yyvsp5 := yyvsp5 -1
	if yyvsp43 >= yyvsc43 then
		if yyvs43 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs43")
			end
			create yyspecial_routines43
			yyvsc43 := yyInitial_yyvs_size
			yyvs43 := yyspecial_routines43.make (yyvsc43)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs43")
			end
			yyvsc43 := yyvsc43 + yyInitial_yyvs_size
			yyvs43 := yyspecial_routines43.resize (yyvs43, yyvsc43)
		end
	end
	yyvs43.put (yyval43, yyvsp43)
end
		end

	yy_do_action_190 is
			--|#line 1392 "et_eiffel_parser.y"
		local
			yyval87: ET_KEYWORD_FEATURE_NAME_LIST
		do
--|#line 1392 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1392")
end

yyval87 := ast_factory.new_keyword_feature_name_list (yyvs2.item (yyvsp2), 0) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp87 := yyvsp87 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp87 >= yyvsc87 then
		if yyvs87 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs87")
			end
			create yyspecial_routines87
			yyvsc87 := yyInitial_yyvs_size
			yyvs87 := yyspecial_routines87.make (yyvsc87)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs87")
			end
			yyvsc87 := yyvsc87 + yyInitial_yyvs_size
			yyvs87 := yyspecial_routines87.resize (yyvs87, yyvsc87)
		end
	end
	yyvs87.put (yyval87, yyvsp87)
end
		end

	yy_do_action_191 is
			--|#line 1394 "et_eiffel_parser.y"
		local
			yyval87: ET_KEYWORD_FEATURE_NAME_LIST
		do
--|#line 1394 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1394")
end

			yyval87 := yyvs87.item (yyvsp87)
			remove_keyword
			remove_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp87 := yyvsp87 -1
	yyvsp2 := yyvsp2 -1
	yyvs87.put (yyval87, yyvsp87)
end
		end

	yy_do_action_192 is
			--|#line 1394 "et_eiffel_parser.y"
		local
			yyval87: ET_KEYWORD_FEATURE_NAME_LIST
		do
--|#line 1394 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1394")
end

			add_keyword (yyvs2.item (yyvsp2))
			add_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp87 := yyvsp87 + 1
	if yyvsp87 >= yyvsc87 then
		if yyvs87 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs87")
			end
			create yyspecial_routines87
			yyvsc87 := yyInitial_yyvs_size
			yyvs87 := yyspecial_routines87.make (yyvsc87)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs87")
			end
			yyvsc87 := yyvsc87 + yyInitial_yyvs_size
			yyvs87 := yyspecial_routines87.resize (yyvs87, yyvsc87)
		end
	end
	yyvs87.put (yyval87, yyvsp87)
end
		end

	yy_do_action_193 is
			--|#line 1407 "et_eiffel_parser.y"
		local
			yyval87: ET_KEYWORD_FEATURE_NAME_LIST
		do
--|#line 1407 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1407")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp87 := yyvsp87 + 1
	if yyvsp87 >= yyvsc87 then
		if yyvs87 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs87")
			end
			create yyspecial_routines87
			yyvsc87 := yyInitial_yyvs_size
			yyvs87 := yyspecial_routines87.make (yyvsc87)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs87")
			end
			yyvsc87 := yyvsc87 + yyInitial_yyvs_size
			yyvs87 := yyspecial_routines87.resize (yyvs87, yyvsc87)
		end
	end
	yyvs87.put (yyval87, yyvsp87)
end
		end

	yy_do_action_194 is
			--|#line 1409 "et_eiffel_parser.y"
		local
			yyval87: ET_KEYWORD_FEATURE_NAME_LIST
		do
--|#line 1409 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1409")
end

yyval87 := yyvs87.item (yyvsp87) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs87.put (yyval87, yyvsp87)
end
		end

	yy_do_action_195 is
			--|#line 1413 "et_eiffel_parser.y"
		local
			yyval87: ET_KEYWORD_FEATURE_NAME_LIST
		do
--|#line 1413 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1413")
end

yyval87 := ast_factory.new_keyword_feature_name_list (yyvs2.item (yyvsp2), 0) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp87 := yyvsp87 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp87 >= yyvsc87 then
		if yyvs87 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs87")
			end
			create yyspecial_routines87
			yyvsc87 := yyInitial_yyvs_size
			yyvs87 := yyspecial_routines87.make (yyvsc87)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs87")
			end
			yyvsc87 := yyvsc87 + yyInitial_yyvs_size
			yyvs87 := yyspecial_routines87.resize (yyvs87, yyvsc87)
		end
	end
	yyvs87.put (yyval87, yyvsp87)
end
		end

	yy_do_action_196 is
			--|#line 1415 "et_eiffel_parser.y"
		local
			yyval87: ET_KEYWORD_FEATURE_NAME_LIST
		do
--|#line 1415 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1415")
end

			yyval87 := yyvs87.item (yyvsp87)
			remove_keyword
			remove_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp87 := yyvsp87 -1
	yyvsp2 := yyvsp2 -1
	yyvs87.put (yyval87, yyvsp87)
end
		end

	yy_do_action_197 is
			--|#line 1415 "et_eiffel_parser.y"
		local
			yyval87: ET_KEYWORD_FEATURE_NAME_LIST
		do
--|#line 1415 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1415")
end

			add_keyword (yyvs2.item (yyvsp2))
			add_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp87 := yyvsp87 + 1
	if yyvsp87 >= yyvsc87 then
		if yyvs87 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs87")
			end
			create yyspecial_routines87
			yyvsc87 := yyInitial_yyvs_size
			yyvs87 := yyspecial_routines87.make (yyvsc87)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs87")
			end
			yyvsc87 := yyvsc87 + yyInitial_yyvs_size
			yyvs87 := yyspecial_routines87.resize (yyvs87, yyvsc87)
		end
	end
	yyvs87.put (yyval87, yyvsp87)
end
		end

	yy_do_action_198 is
			--|#line 1428 "et_eiffel_parser.y"
		local
			yyval87: ET_KEYWORD_FEATURE_NAME_LIST
		do
--|#line 1428 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1428")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp87 := yyvsp87 + 1
	if yyvsp87 >= yyvsc87 then
		if yyvs87 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs87")
			end
			create yyspecial_routines87
			yyvsc87 := yyInitial_yyvs_size
			yyvs87 := yyspecial_routines87.make (yyvsc87)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs87")
			end
			yyvsc87 := yyvsc87 + yyInitial_yyvs_size
			yyvs87 := yyspecial_routines87.resize (yyvs87, yyvsc87)
		end
	end
	yyvs87.put (yyval87, yyvsp87)
end
		end

	yy_do_action_199 is
			--|#line 1430 "et_eiffel_parser.y"
		local
			yyval87: ET_KEYWORD_FEATURE_NAME_LIST
		do
--|#line 1430 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1430")
end

yyval87 := yyvs87.item (yyvsp87) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs87.put (yyval87, yyvsp87)
end
		end

	yy_do_action_200 is
			--|#line 1434 "et_eiffel_parser.y"
		local
			yyval87: ET_KEYWORD_FEATURE_NAME_LIST
		do
--|#line 1434 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1434")
end

yyval87 := ast_factory.new_keyword_feature_name_list (yyvs2.item (yyvsp2), 0) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp87 := yyvsp87 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp87 >= yyvsc87 then
		if yyvs87 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs87")
			end
			create yyspecial_routines87
			yyvsc87 := yyInitial_yyvs_size
			yyvs87 := yyspecial_routines87.make (yyvsc87)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs87")
			end
			yyvsc87 := yyvsc87 + yyInitial_yyvs_size
			yyvs87 := yyspecial_routines87.resize (yyvs87, yyvsc87)
		end
	end
	yyvs87.put (yyval87, yyvsp87)
end
		end

	yy_do_action_201 is
			--|#line 1436 "et_eiffel_parser.y"
		local
			yyval87: ET_KEYWORD_FEATURE_NAME_LIST
		do
--|#line 1436 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1436")
end

			yyval87 := yyvs87.item (yyvsp87)
			remove_keyword
			remove_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp87 := yyvsp87 -1
	yyvsp2 := yyvsp2 -1
	yyvs87.put (yyval87, yyvsp87)
end
		end

	yy_do_action_202 is
			--|#line 1436 "et_eiffel_parser.y"
		local
			yyval87: ET_KEYWORD_FEATURE_NAME_LIST
		do
--|#line 1436 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1436")
end

			add_keyword (yyvs2.item (yyvsp2))
			add_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp87 := yyvsp87 + 1
	if yyvsp87 >= yyvsc87 then
		if yyvs87 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs87")
			end
			create yyspecial_routines87
			yyvsc87 := yyInitial_yyvs_size
			yyvs87 := yyspecial_routines87.make (yyvsc87)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs87")
			end
			yyvsc87 := yyvsc87 + yyInitial_yyvs_size
			yyvs87 := yyspecial_routines87.resize (yyvs87, yyvsc87)
		end
	end
	yyvs87.put (yyval87, yyvsp87)
end
		end

	yy_do_action_203 is
			--|#line 1449 "et_eiffel_parser.y"
		local
			yyval87: ET_KEYWORD_FEATURE_NAME_LIST
		do
--|#line 1449 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1449")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp87 := yyvsp87 + 1
	if yyvsp87 >= yyvsc87 then
		if yyvs87 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs87")
			end
			create yyspecial_routines87
			yyvsc87 := yyInitial_yyvs_size
			yyvs87 := yyspecial_routines87.make (yyvsc87)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs87")
			end
			yyvsc87 := yyvsc87 + yyInitial_yyvs_size
			yyvs87 := yyspecial_routines87.resize (yyvs87, yyvsc87)
		end
	end
	yyvs87.put (yyval87, yyvsp87)
end
		end

	yy_do_action_204 is
			--|#line 1451 "et_eiffel_parser.y"
		local
			yyval87: ET_KEYWORD_FEATURE_NAME_LIST
		do
--|#line 1451 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1451")
end

yyval87 := yyvs87.item (yyvsp87) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs87.put (yyval87, yyvsp87)
end
		end

	yy_do_action_205 is
			--|#line 1455 "et_eiffel_parser.y"
		local
			yyval87: ET_KEYWORD_FEATURE_NAME_LIST
		do
--|#line 1455 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1455")
end

			if yyvs69.item (yyvsp69) /= Void then
				yyval87 := ast_factory.new_keyword_feature_name_list (last_keyword, counter_value + 1)
				if yyval87 /= Void then
					yyval87.put_first (yyvs69.item (yyvsp69))
				end
			else
				yyval87 := ast_factory.new_keyword_feature_name_list (last_keyword, counter_value)
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp87 := yyvsp87 + 1
	yyvsp69 := yyvsp69 -1
	if yyvsp87 >= yyvsc87 then
		if yyvs87 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs87")
			end
			create yyspecial_routines87
			yyvsc87 := yyInitial_yyvs_size
			yyvs87 := yyspecial_routines87.make (yyvsc87)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs87")
			end
			yyvsc87 := yyvsc87 + yyInitial_yyvs_size
			yyvs87 := yyspecial_routines87.resize (yyvs87, yyvsc87)
		end
	end
	yyvs87.put (yyval87, yyvsp87)
end
		end

	yy_do_action_206 is
			--|#line 1466 "et_eiffel_parser.y"
		local
			yyval87: ET_KEYWORD_FEATURE_NAME_LIST
		do
--|#line 1466 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1466")
end

			yyval87 := ast_factory.new_keyword_feature_name_list (last_keyword, counter_value)
			if yyval87 /= Void and yyvs70.item (yyvsp70) /= Void then
				yyval87.put_first (yyvs70.item (yyvsp70))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp87 := yyvsp87 + 1
	yyvsp70 := yyvsp70 -1
	if yyvsp87 >= yyvsc87 then
		if yyvs87 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs87")
			end
			create yyspecial_routines87
			yyvsc87 := yyInitial_yyvs_size
			yyvs87 := yyspecial_routines87.make (yyvsc87)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs87")
			end
			yyvsc87 := yyvsc87 + yyInitial_yyvs_size
			yyvs87 := yyspecial_routines87.resize (yyvs87, yyvsc87)
		end
	end
	yyvs87.put (yyval87, yyvsp87)
end
		end

	yy_do_action_207 is
			--|#line 1474 "et_eiffel_parser.y"
		local
			yyval87: ET_KEYWORD_FEATURE_NAME_LIST
		do
--|#line 1474 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1474")
end

			yyval87 := yyvs87.item (yyvsp87)
			if yyval87 /= Void and yyvs70.item (yyvsp70) /= Void then
				yyval87.put_first (yyvs70.item (yyvsp70))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp70 := yyvsp70 -1
	yyvs87.put (yyval87, yyvsp87)
end
		end

	yy_do_action_208 is
			--|#line 1483 "et_eiffel_parser.y"
		local
			yyval70: ET_FEATURE_NAME_ITEM
		do
--|#line 1483 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1483")
end

			yyval70 := ast_factory.new_feature_name_comma (yyvs69.item (yyvsp69), yyvs5.item (yyvsp5))
			if yyval70 /= Void then
				increment_counter
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp70 := yyvsp70 + 1
	yyvsp69 := yyvsp69 -1
	yyvsp5 := yyvsp5 -1
	if yyvsp70 >= yyvsc70 then
		if yyvs70 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs70")
			end
			create yyspecial_routines70
			yyvsc70 := yyInitial_yyvs_size
			yyvs70 := yyspecial_routines70.make (yyvsc70)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs70")
			end
			yyvsc70 := yyvsc70 + yyInitial_yyvs_size
			yyvs70 := yyspecial_routines70.resize (yyvs70, yyvsc70)
		end
	end
	yyvs70.put (yyval70, yyvsp70)
end
		end

	yy_do_action_209 is
			--|#line 1494 "et_eiffel_parser.y"
		local
			yyval56: ET_CREATOR_LIST
		do
--|#line 1494 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1494")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp56 := yyvsp56 + 1
	if yyvsp56 >= yyvsc56 then
		if yyvs56 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs56")
			end
			create yyspecial_routines56
			yyvsc56 := yyInitial_yyvs_size
			yyvs56 := yyspecial_routines56.make (yyvsc56)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs56")
			end
			yyvsc56 := yyvsc56 + yyInitial_yyvs_size
			yyvs56 := yyspecial_routines56.resize (yyvs56, yyvsc56)
		end
	end
	yyvs56.put (yyval56, yyvsp56)
end
		end

	yy_do_action_210 is
			--|#line 1496 "et_eiffel_parser.y"
		local
			yyval56: ET_CREATOR_LIST
		do
--|#line 1496 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1496")
end

			yyval56 := yyvs56.item (yyvsp56)
			remove_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs56.put (yyval56, yyvsp56)
end
		end

	yy_do_action_211 is
			--|#line 1503 "et_eiffel_parser.y"
		local
			yyval56: ET_CREATOR_LIST
		do
--|#line 1503 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1503")
end

			yyval56 := yyvs56.item (yyvsp56)
			remove_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs56.put (yyval56, yyvsp56)
end
		end

	yy_do_action_212 is
			--|#line 1510 "et_eiffel_parser.y"
		local
			yyval56: ET_CREATOR_LIST
		do
--|#line 1510 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1510")
end

			if yyvs55.item (yyvsp55) /= Void then
				yyval56 := ast_factory.new_creators (counter_value + 1)
				if yyval56 /= Void then
					yyval56.put_first (yyvs55.item (yyvsp55))
				end
			else
				yyval56 := ast_factory.new_creators (counter_value)
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp56 := yyvsp56 + 1
	yyvsp55 := yyvsp55 -1
	if yyvsp56 >= yyvsc56 then
		if yyvs56 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs56")
			end
			create yyspecial_routines56
			yyvsc56 := yyInitial_yyvs_size
			yyvs56 := yyspecial_routines56.make (yyvsc56)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs56")
			end
			yyvsc56 := yyvsc56 + yyInitial_yyvs_size
			yyvs56 := yyspecial_routines56.resize (yyvs56, yyvsc56)
		end
	end
	yyvs56.put (yyval56, yyvsp56)
end
		end

	yy_do_action_213 is
			--|#line 1521 "et_eiffel_parser.y"
		local
			yyval56: ET_CREATOR_LIST
		do
--|#line 1521 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1521")
end

			yyval56 := yyvs56.item (yyvsp56)
			if yyval56 /= Void and yyvs55.item (yyvsp55) /= Void then
				yyval56.put_first (yyvs55.item (yyvsp55))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp56 := yyvsp56 -1
	yyvsp55 := yyvsp55 -1
	yyvs56.put (yyval56, yyvsp56)
end
		end

	yy_do_action_214 is
			--|#line 1521 "et_eiffel_parser.y"
		local
			yyval56: ET_CREATOR_LIST
		do
--|#line 1521 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1521")
end

			if yyvs55.item (yyvsp55) /= Void then
				increment_counter
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp56 := yyvsp56 + 1
	if yyvsp56 >= yyvsc56 then
		if yyvs56 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs56")
			end
			create yyspecial_routines56
			yyvsc56 := yyInitial_yyvs_size
			yyvs56 := yyspecial_routines56.make (yyvsc56)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs56")
			end
			yyvsc56 := yyvsc56 + yyInitial_yyvs_size
			yyvs56 := yyspecial_routines56.resize (yyvs56, yyvsc56)
		end
	end
	yyvs56.put (yyval56, yyvsp56)
end
		end

	yy_do_action_215 is
			--|#line 1536 "et_eiffel_parser.y"
		local
			yyval55: ET_CREATOR
		do
--|#line 1536 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1536")
end

yyval55 := ast_factory.new_creator (yyvs2.item (yyvsp2), yyvs44.item (yyvsp44), 0) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp55 := yyvsp55 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp44 := yyvsp44 -1
	if yyvsp55 >= yyvsc55 then
		if yyvs55 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs55")
			end
			create yyspecial_routines55
			yyvsc55 := yyInitial_yyvs_size
			yyvs55 := yyspecial_routines55.make (yyvsc55)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs55")
			end
			yyvsc55 := yyvsc55 + yyInitial_yyvs_size
			yyvs55 := yyspecial_routines55.resize (yyvs55, yyvsc55)
		end
	end
	yyvs55.put (yyval55, yyvsp55)
end
		end

	yy_do_action_216 is
			--|#line 1538 "et_eiffel_parser.y"
		local
			yyval55: ET_CREATOR
		do
--|#line 1538 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1538")
end

yyval55 := ast_factory.new_creator (yyvs2.item (yyvsp2), new_any_clients (yyvs2.item (yyvsp2)), 0) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp55 := yyvsp55 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp55 >= yyvsc55 then
		if yyvs55 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs55")
			end
			create yyspecial_routines55
			yyvsc55 := yyInitial_yyvs_size
			yyvs55 := yyspecial_routines55.make (yyvsc55)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs55")
			end
			yyvsc55 := yyvsc55 + yyInitial_yyvs_size
			yyvs55 := yyspecial_routines55.resize (yyvs55, yyvsc55)
		end
	end
	yyvs55.put (yyval55, yyvsp55)
end
		end

	yy_do_action_217 is
			--|#line 1540 "et_eiffel_parser.y"
		local
			yyval55: ET_CREATOR
		do
--|#line 1540 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1540")
end

			yyval55 := yyvs55.item (yyvsp55)
			remove_keyword
			remove_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp55 := yyvsp55 -1
	yyvsp2 := yyvsp2 -1
	yyvsp44 := yyvsp44 -1
	yyvs55.put (yyval55, yyvsp55)
end
		end

	yy_do_action_218 is
			--|#line 1540 "et_eiffel_parser.y"
		local
			yyval55: ET_CREATOR
		do
--|#line 1540 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1540")
end

			add_keyword (yyvs2.item (yyvsp2))
			last_clients := yyvs44.item (yyvsp44)
			add_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp55 := yyvsp55 + 1
	if yyvsp55 >= yyvsc55 then
		if yyvs55 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs55")
			end
			create yyspecial_routines55
			yyvsc55 := yyInitial_yyvs_size
			yyvs55 := yyspecial_routines55.make (yyvsc55)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs55")
			end
			yyvsc55 := yyvsc55 + yyInitial_yyvs_size
			yyvs55 := yyspecial_routines55.resize (yyvs55, yyvsc55)
		end
	end
	yyvs55.put (yyval55, yyvsp55)
end
		end

	yy_do_action_219 is
			--|#line 1552 "et_eiffel_parser.y"
		local
			yyval55: ET_CREATOR
		do
--|#line 1552 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1552")
end

			yyval55 := yyvs55.item (yyvsp55)
			remove_keyword
			remove_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp55 := yyvsp55 -1
	yyvsp2 := yyvsp2 -1
	yyvs55.put (yyval55, yyvsp55)
end
		end

	yy_do_action_220 is
			--|#line 1552 "et_eiffel_parser.y"
		local
			yyval55: ET_CREATOR
		do
--|#line 1552 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1552")
end

			add_keyword (yyvs2.item (yyvsp2))
			last_clients := new_any_clients (last_keyword)
			add_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp55 := yyvsp55 + 1
	if yyvsp55 >= yyvsc55 then
		if yyvs55 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs55")
			end
			create yyspecial_routines55
			yyvsc55 := yyInitial_yyvs_size
			yyvs55 := yyspecial_routines55.make (yyvsc55)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs55")
			end
			yyvsc55 := yyvsc55 + yyInitial_yyvs_size
			yyvs55 := yyspecial_routines55.resize (yyvs55, yyvsc55)
		end
	end
	yyvs55.put (yyval55, yyvsp55)
end
		end

	yy_do_action_221 is
			--|#line 1564 "et_eiffel_parser.y"
		local
			yyval55: ET_CREATOR
		do
--|#line 1564 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1564")
end

yyval55 := ast_factory.new_creator (yyvs2.item (yyvsp2), yyvs44.item (yyvsp44), 0) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp55 := yyvsp55 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp44 := yyvsp44 -1
	if yyvsp55 >= yyvsc55 then
		if yyvs55 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs55")
			end
			create yyspecial_routines55
			yyvsc55 := yyInitial_yyvs_size
			yyvs55 := yyspecial_routines55.make (yyvsc55)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs55")
			end
			yyvsc55 := yyvsc55 + yyInitial_yyvs_size
			yyvs55 := yyspecial_routines55.resize (yyvs55, yyvsc55)
		end
	end
	yyvs55.put (yyval55, yyvsp55)
end
		end

	yy_do_action_222 is
			--|#line 1566 "et_eiffel_parser.y"
		local
			yyval55: ET_CREATOR
		do
--|#line 1566 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1566")
end

yyval55 := ast_factory.new_creator (yyvs2.item (yyvsp2), new_any_clients (yyvs2.item (yyvsp2)), 0) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp55 := yyvsp55 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp55 >= yyvsc55 then
		if yyvs55 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs55")
			end
			create yyspecial_routines55
			yyvsc55 := yyInitial_yyvs_size
			yyvs55 := yyspecial_routines55.make (yyvsc55)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs55")
			end
			yyvsc55 := yyvsc55 + yyInitial_yyvs_size
			yyvs55 := yyspecial_routines55.resize (yyvs55, yyvsc55)
		end
	end
	yyvs55.put (yyval55, yyvsp55)
end
		end

	yy_do_action_223 is
			--|#line 1568 "et_eiffel_parser.y"
		local
			yyval55: ET_CREATOR
		do
--|#line 1568 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1568")
end

			yyval55 := yyvs55.item (yyvsp55)
			remove_keyword
			remove_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp55 := yyvsp55 -1
	yyvsp2 := yyvsp2 -1
	yyvsp44 := yyvsp44 -1
	yyvs55.put (yyval55, yyvsp55)
end
		end

	yy_do_action_224 is
			--|#line 1568 "et_eiffel_parser.y"
		local
			yyval55: ET_CREATOR
		do
--|#line 1568 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1568")
end

			add_keyword (yyvs2.item (yyvsp2))
			last_clients := yyvs44.item (yyvsp44)
			add_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp55 := yyvsp55 + 1
	if yyvsp55 >= yyvsc55 then
		if yyvs55 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs55")
			end
			create yyspecial_routines55
			yyvsc55 := yyInitial_yyvs_size
			yyvs55 := yyspecial_routines55.make (yyvsc55)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs55")
			end
			yyvsc55 := yyvsc55 + yyInitial_yyvs_size
			yyvs55 := yyspecial_routines55.resize (yyvs55, yyvsc55)
		end
	end
	yyvs55.put (yyval55, yyvsp55)
end
		end

	yy_do_action_225 is
			--|#line 1580 "et_eiffel_parser.y"
		local
			yyval55: ET_CREATOR
		do
--|#line 1580 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1580")
end

			yyval55 := yyvs55.item (yyvsp55)
			remove_keyword
			remove_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp55 := yyvsp55 -1
	yyvsp2 := yyvsp2 -1
	yyvs55.put (yyval55, yyvsp55)
end
		end

	yy_do_action_226 is
			--|#line 1580 "et_eiffel_parser.y"
		local
			yyval55: ET_CREATOR
		do
--|#line 1580 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1580")
end

			add_keyword (yyvs2.item (yyvsp2))
			last_clients := new_any_clients (last_keyword)
			add_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp55 := yyvsp55 + 1
	if yyvsp55 >= yyvsc55 then
		if yyvs55 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs55")
			end
			create yyspecial_routines55
			yyvsc55 := yyInitial_yyvs_size
			yyvs55 := yyspecial_routines55.make (yyvsc55)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs55")
			end
			yyvsc55 := yyvsc55 + yyInitial_yyvs_size
			yyvs55 := yyspecial_routines55.resize (yyvs55, yyvsc55)
		end
	end
	yyvs55.put (yyval55, yyvsp55)
end
		end

	yy_do_action_227 is
			--|#line 1594 "et_eiffel_parser.y"
		local
			yyval55: ET_CREATOR
		do
--|#line 1594 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1594")
end

			if yyvs13.item (yyvsp13) /= Void then
				yyval55 := ast_factory.new_creator (last_keyword, last_clients, counter_value + 1)
				if yyval55 /= Void then
					yyval55.put_first (yyvs13.item (yyvsp13))
				end
			else
				yyval55 := ast_factory.new_creator (last_keyword, last_clients, counter_value)
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp55 := yyvsp55 + 1
	yyvsp13 := yyvsp13 -1
	if yyvsp55 >= yyvsc55 then
		if yyvs55 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs55")
			end
			create yyspecial_routines55
			yyvsc55 := yyInitial_yyvs_size
			yyvs55 := yyspecial_routines55.make (yyvsc55)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs55")
			end
			yyvsc55 := yyvsc55 + yyInitial_yyvs_size
			yyvs55 := yyspecial_routines55.resize (yyvs55, yyvsc55)
		end
	end
	yyvs55.put (yyval55, yyvsp55)
end
		end

	yy_do_action_228 is
			--|#line 1605 "et_eiffel_parser.y"
		local
			yyval55: ET_CREATOR
		do
--|#line 1605 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1605")
end

			if current_system.is_ise then
				raise_error
			else
				yyval55 := ast_factory.new_creator (last_keyword, last_clients, counter_value)
				if yyval55 /= Void and yyvs70.item (yyvsp70) /= Void then
					yyval55.put_first (yyvs70.item (yyvsp70))
				end
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp55 := yyvsp55 + 1
	yyvsp70 := yyvsp70 -1
	if yyvsp55 >= yyvsc55 then
		if yyvs55 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs55")
			end
			create yyspecial_routines55
			yyvsc55 := yyInitial_yyvs_size
			yyvs55 := yyspecial_routines55.make (yyvsc55)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs55")
			end
			yyvsc55 := yyvsc55 + yyInitial_yyvs_size
			yyvs55 := yyspecial_routines55.resize (yyvs55, yyvsc55)
		end
	end
	yyvs55.put (yyval55, yyvsp55)
end
		end

	yy_do_action_229 is
			--|#line 1617 "et_eiffel_parser.y"
		local
			yyval55: ET_CREATOR
		do
--|#line 1617 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1617")
end

			yyval55 := yyvs55.item (yyvsp55)
			if yyval55 /= Void and yyvs70.item (yyvsp70) /= Void then
				yyval55.put_first (yyvs70.item (yyvsp70))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp70 := yyvsp70 -1
	yyvs55.put (yyval55, yyvsp55)
end
		end

	yy_do_action_230 is
			--|#line 1626 "et_eiffel_parser.y"
		local
			yyval70: ET_FEATURE_NAME_ITEM
		do
--|#line 1626 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1626")
end

			yyval70 := ast_factory.new_feature_name_comma (yyvs13.item (yyvsp13), yyvs5.item (yyvsp5))
			if yyval70 /= Void then
				increment_counter
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp70 := yyvsp70 + 1
	yyvsp13 := yyvsp13 -1
	yyvsp5 := yyvsp5 -1
	if yyvsp70 >= yyvsc70 then
		if yyvs70 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs70")
			end
			create yyspecial_routines70
			yyvsc70 := yyInitial_yyvs_size
			yyvs70 := yyspecial_routines70.make (yyvsc70)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs70")
			end
			yyvsc70 := yyvsc70 + yyInitial_yyvs_size
			yyvs70 := yyspecial_routines70.resize (yyvs70, yyvsc70)
		end
	end
	yyvs70.put (yyval70, yyvsp70)
end
		end

	yy_do_action_231 is
			--|#line 1637 "et_eiffel_parser.y"
		local
			yyval53: ET_CONVERT_FEATURE_LIST
		do
--|#line 1637 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1637")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp53 := yyvsp53 + 1
	if yyvsp53 >= yyvsc53 then
		if yyvs53 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs53")
			end
			create yyspecial_routines53
			yyvsc53 := yyInitial_yyvs_size
			yyvs53 := yyspecial_routines53.make (yyvsc53)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs53")
			end
			yyvsc53 := yyvsc53 + yyInitial_yyvs_size
			yyvs53 := yyspecial_routines53.resize (yyvs53, yyvsc53)
		end
	end
	yyvs53.put (yyval53, yyvsp53)
end
		end

	yy_do_action_232 is
			--|#line 1639 "et_eiffel_parser.y"
		local
			yyval53: ET_CONVERT_FEATURE_LIST
		do
--|#line 1639 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1639")
end

yyval53 := yyvs53.item (yyvsp53) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs53.put (yyval53, yyvsp53)
end
		end

	yy_do_action_233 is
			--|#line 1643 "et_eiffel_parser.y"
		local
			yyval53: ET_CONVERT_FEATURE_LIST
		do
--|#line 1643 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1643")
end

			yyval53 := yyvs53.item (yyvsp53)
			remove_keyword
			remove_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp53 := yyvsp53 -1
	yyvsp2 := yyvsp2 -1
	yyvs53.put (yyval53, yyvsp53)
end
		end

	yy_do_action_234 is
			--|#line 1643 "et_eiffel_parser.y"
		local
			yyval53: ET_CONVERT_FEATURE_LIST
		do
--|#line 1643 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1643")
end

			add_keyword (yyvs2.item (yyvsp2))
			add_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp53 := yyvsp53 + 1
	if yyvsp53 >= yyvsc53 then
		if yyvs53 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs53")
			end
			create yyspecial_routines53
			yyvsc53 := yyInitial_yyvs_size
			yyvs53 := yyspecial_routines53.make (yyvsc53)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs53")
			end
			yyvsc53 := yyvsc53 + yyInitial_yyvs_size
			yyvs53 := yyspecial_routines53.resize (yyvs53, yyvsc53)
		end
	end
	yyvs53.put (yyval53, yyvsp53)
end
		end

	yy_do_action_235 is
			--|#line 1656 "et_eiffel_parser.y"
		local
			yyval53: ET_CONVERT_FEATURE_LIST
		do
--|#line 1656 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1656")
end

			yyval53 := ast_factory.new_convert_features (last_keyword, counter_value + 1)
			if yyval53 /= Void and yyvs51.item (yyvsp51) /= Void then
				yyval53.put_first (yyvs51.item (yyvsp51))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp53 := yyvsp53 + 1
	yyvsp51 := yyvsp51 -1
	if yyvsp53 >= yyvsc53 then
		if yyvs53 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs53")
			end
			create yyspecial_routines53
			yyvsc53 := yyInitial_yyvs_size
			yyvs53 := yyspecial_routines53.make (yyvsc53)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs53")
			end
			yyvsc53 := yyvsc53 + yyInitial_yyvs_size
			yyvs53 := yyspecial_routines53.resize (yyvs53, yyvsc53)
		end
	end
	yyvs53.put (yyval53, yyvsp53)
end
		end

	yy_do_action_236 is
			--|#line 1663 "et_eiffel_parser.y"
		local
			yyval53: ET_CONVERT_FEATURE_LIST
		do
--|#line 1663 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1663")
end

			yyval53 := ast_factory.new_convert_features (last_keyword, counter_value)
			if yyval53 /= Void and yyvs52.item (yyvsp52) /= Void then
				yyval53.put_first (yyvs52.item (yyvsp52))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp53 := yyvsp53 + 1
	yyvsp52 := yyvsp52 -1
	if yyvsp53 >= yyvsc53 then
		if yyvs53 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs53")
			end
			create yyspecial_routines53
			yyvsc53 := yyInitial_yyvs_size
			yyvs53 := yyspecial_routines53.make (yyvsc53)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs53")
			end
			yyvsc53 := yyvsc53 + yyInitial_yyvs_size
			yyvs53 := yyspecial_routines53.resize (yyvs53, yyvsc53)
		end
	end
	yyvs53.put (yyval53, yyvsp53)
end
		end

	yy_do_action_237 is
			--|#line 1670 "et_eiffel_parser.y"
		local
			yyval53: ET_CONVERT_FEATURE_LIST
		do
--|#line 1670 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1670")
end

			yyval53 := yyvs53.item (yyvsp53)
			if yyval53 /= Void and yyvs52.item (yyvsp52) /= Void then
				yyval53.put_first (yyvs52.item (yyvsp52))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp52 := yyvsp52 -1
	yyvs53.put (yyval53, yyvsp53)
end
		end

	yy_do_action_238 is
			--|#line 1679 "et_eiffel_parser.y"
		local
			yyval52: ET_CONVERT_FEATURE_ITEM
		do
--|#line 1679 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1679")
end

			yyval52 := ast_factory.new_convert_feature_comma (yyvs51.item (yyvsp51), yyvs5.item (yyvsp5))
			if yyval52 /= Void then
				increment_counter
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp52 := yyvsp52 + 1
	yyvsp51 := yyvsp51 -1
	yyvsp5 := yyvsp5 -1
	if yyvsp52 >= yyvsc52 then
		if yyvs52 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs52")
			end
			create yyspecial_routines52
			yyvsc52 := yyInitial_yyvs_size
			yyvs52 := yyspecial_routines52.make (yyvsc52)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs52")
			end
			yyvsc52 := yyvsc52 + yyInitial_yyvs_size
			yyvs52 := yyspecial_routines52.resize (yyvs52, yyvsc52)
		end
	end
	yyvs52.put (yyval52, yyvsp52)
end
		end

	yy_do_action_239 is
			--|#line 1688 "et_eiffel_parser.y"
		local
			yyval51: ET_CONVERT_FEATURE
		do
--|#line 1688 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1688")
end

			yyval51 := ast_factory.new_convert_function (yyvs69.item (yyvsp69), yyvs5.item (yyvsp5), yyvs114.item (yyvsp114))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp51 := yyvsp51 + 1
	yyvsp69 := yyvsp69 -1
	yyvsp5 := yyvsp5 -1
	yyvsp114 := yyvsp114 -1
	if yyvsp51 >= yyvsc51 then
		if yyvs51 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs51")
			end
			create yyspecial_routines51
			yyvsc51 := yyInitial_yyvs_size
			yyvs51 := yyspecial_routines51.make (yyvsc51)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs51")
			end
			yyvsc51 := yyvsc51 + yyInitial_yyvs_size
			yyvs51 := yyspecial_routines51.resize (yyvs51, yyvsc51)
		end
	end
	yyvs51.put (yyval51, yyvsp51)
end
		end

	yy_do_action_240 is
			--|#line 1692 "et_eiffel_parser.y"
		local
			yyval51: ET_CONVERT_FEATURE
		do
--|#line 1692 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1692")
end

			yyval51 := ast_factory.new_convert_procedure (yyvs69.item (yyvsp69), yyvs5.item (yyvsp5 - 1), yyvs114.item (yyvsp114), yyvs5.item (yyvsp5))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp51 := yyvsp51 + 1
	yyvsp69 := yyvsp69 -1
	yyvsp5 := yyvsp5 -2
	yyvsp114 := yyvsp114 -1
	if yyvsp51 >= yyvsc51 then
		if yyvs51 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs51")
			end
			create yyspecial_routines51
			yyvsc51 := yyInitial_yyvs_size
			yyvs51 := yyspecial_routines51.make (yyvsc51)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs51")
			end
			yyvsc51 := yyvsc51 + yyInitial_yyvs_size
			yyvs51 := yyspecial_routines51.resize (yyvs51, yyvsc51)
		end
	end
	yyvs51.put (yyval51, yyvsp51)
end
		end

	yy_do_action_241 is
			--|#line 1698 "et_eiffel_parser.y"
		local
			yyval114: ET_TYPE_LIST
		do
--|#line 1698 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1698")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp114 := yyvsp114 + 1
	yyvsp5 := yyvsp5 -2
	if yyvsp114 >= yyvsc114 then
		if yyvs114 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs114")
			end
			create yyspecial_routines114
			yyvsc114 := yyInitial_yyvs_size
			yyvs114 := yyspecial_routines114.make (yyvsc114)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs114")
			end
			yyvsc114 := yyvsc114 + yyInitial_yyvs_size
			yyvs114 := yyspecial_routines114.resize (yyvs114, yyvsc114)
		end
	end
	yyvs114.put (yyval114, yyvsp114)
end
		end

	yy_do_action_242 is
			--|#line 1700 "et_eiffel_parser.y"
		local
			yyval114: ET_TYPE_LIST
		do
--|#line 1700 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1700")
end

			yyval114 := yyvs114.item (yyvsp114)
			remove_symbol
			remove_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp114 := yyvsp114 -1
	yyvsp5 := yyvsp5 -1
	yyvs114.put (yyval114, yyvsp114)
end
		end

	yy_do_action_243 is
			--|#line 1700 "et_eiffel_parser.y"
		local
			yyval114: ET_TYPE_LIST
		do
--|#line 1700 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1700")
end

			add_symbol (yyvs5.item (yyvsp5))
			add_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp114 := yyvsp114 + 1
	if yyvsp114 >= yyvsc114 then
		if yyvs114 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs114")
			end
			create yyspecial_routines114
			yyvsc114 := yyInitial_yyvs_size
			yyvs114 := yyspecial_routines114.make (yyvsc114)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs114")
			end
			yyvsc114 := yyvsc114 + yyInitial_yyvs_size
			yyvs114 := yyspecial_routines114.resize (yyvs114, yyvsc114)
		end
	end
	yyvs114.put (yyval114, yyvsp114)
end
		end

	yy_do_action_244 is
			--|#line 1713 "et_eiffel_parser.y"
		local
			yyval114: ET_TYPE_LIST
		do
--|#line 1713 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1713")
end

			if yyvs112.item (yyvsp112) /= Void then
				yyval114 := ast_factory.new_convert_types (last_symbol, yyvs5.item (yyvsp5), counter_value + 1)
				if yyval114 /= Void then
					yyval114.put_first (yyvs112.item (yyvsp112))
				end
			else
				yyval114 := ast_factory.new_convert_types (last_symbol, yyvs5.item (yyvsp5), counter_value)
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp114 := yyvsp114 + 1
	yyvsp112 := yyvsp112 -1
	yyvsp5 := yyvsp5 -1
	if yyvsp114 >= yyvsc114 then
		if yyvs114 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs114")
			end
			create yyspecial_routines114
			yyvsc114 := yyInitial_yyvs_size
			yyvs114 := yyspecial_routines114.make (yyvsc114)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs114")
			end
			yyvsc114 := yyvsc114 + yyInitial_yyvs_size
			yyvs114 := yyspecial_routines114.resize (yyvs114, yyvsc114)
		end
	end
	yyvs114.put (yyval114, yyvsp114)
end
		end

	yy_do_action_245 is
			--|#line 1724 "et_eiffel_parser.y"
		local
			yyval114: ET_TYPE_LIST
		do
--|#line 1724 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1724")
end

			yyval114 := yyvs114.item (yyvsp114)
			if yyval114 /= Void and yyvs113.item (yyvsp113) /= Void then
				yyval114.put_first (yyvs113.item (yyvsp113))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp113 := yyvsp113 -1
	yyvs114.put (yyval114, yyvsp114)
end
		end

	yy_do_action_246 is
			--|#line 1733 "et_eiffel_parser.y"
		local
			yyval113: ET_TYPE_ITEM
		do
--|#line 1733 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1733")
end

			yyval113 := ast_factory.new_type_comma (yyvs112.item (yyvsp112), yyvs5.item (yyvsp5))
			if yyval113 /= Void then
				increment_counter
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp113 := yyvsp113 + 1
	yyvsp112 := yyvsp112 -1
	yyvsp5 := yyvsp5 -1
	if yyvsp113 >= yyvsc113 then
		if yyvs113 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs113")
			end
			create yyspecial_routines113
			yyvsc113 := yyInitial_yyvs_size
			yyvs113 := yyspecial_routines113.make (yyvsc113)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs113")
			end
			yyvsc113 := yyvsc113 + yyInitial_yyvs_size
			yyvs113 := yyspecial_routines113.resize (yyvs113, yyvsc113)
		end
	end
	yyvs113.put (yyval113, yyvsp113)
end
		end

	yy_do_action_247 is
			--|#line 1744 "et_eiffel_parser.y"
		local
			yyval67: ET_FEATURE_CLAUSE_LIST
		do
--|#line 1744 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1744")
end

			-- $$ := Void
			set_class_features
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp67 := yyvsp67 + 1
	if yyvsp67 >= yyvsc67 then
		if yyvs67 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs67")
			end
			create yyspecial_routines67
			yyvsc67 := yyInitial_yyvs_size
			yyvs67 := yyspecial_routines67.make (yyvsc67)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs67")
			end
			yyvsc67 := yyvsc67 + yyInitial_yyvs_size
			yyvs67 := yyspecial_routines67.resize (yyvs67, yyvsc67)
		end
	end
	yyvs67.put (yyval67, yyvsp67)
end
		end

	yy_do_action_248 is
			--|#line 1749 "et_eiffel_parser.y"
		local
			yyval67: ET_FEATURE_CLAUSE_LIST
		do
--|#line 1749 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1749")
end

yyval67 := yyvs67.item (yyvsp67) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs67.put (yyval67, yyvsp67)
end
		end

	yy_do_action_249 is
			--|#line 1753 "et_eiffel_parser.y"
		local
			yyval67: ET_FEATURE_CLAUSE_LIST
		do
--|#line 1753 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1753")
end

			yyval67 := yyvs67.item (yyvsp67)
			set_class_features
			remove_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs67.put (yyval67, yyvsp67)
end
		end

	yy_do_action_250 is
			--|#line 1761 "et_eiffel_parser.y"
		local
			yyval67: ET_FEATURE_CLAUSE_LIST
		do
--|#line 1761 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1761")
end

			yyval67 := ast_factory.new_feature_clauses (counter_value)
			if yyval67 /= Void and yyvs66.item (yyvsp66) /= Void then
				yyval67.put_first (yyvs66.item (yyvsp66))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp67 := yyvsp67 + 1
	yyvsp66 := yyvsp66 -1
	if yyvsp67 >= yyvsc67 then
		if yyvs67 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs67")
			end
			create yyspecial_routines67
			yyvsc67 := yyInitial_yyvs_size
			yyvs67 := yyspecial_routines67.make (yyvsc67)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs67")
			end
			yyvsc67 := yyvsc67 + yyInitial_yyvs_size
			yyvs67 := yyspecial_routines67.resize (yyvs67, yyvsc67)
		end
	end
	yyvs67.put (yyval67, yyvsp67)
end
		end

	yy_do_action_251 is
			--|#line 1768 "et_eiffel_parser.y"
		local
			yyval67: ET_FEATURE_CLAUSE_LIST
		do
--|#line 1768 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1768")
end

			yyval67 := yyvs67.item (yyvsp67)
			if yyval67 /= Void and yyvs66.item (yyvsp66) /= Void then
				yyval67.put_first (yyvs66.item (yyvsp66))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp66 := yyvsp66 -1
	yyvs67.put (yyval67, yyvsp67)
end
		end

	yy_do_action_252 is
			--|#line 1777 "et_eiffel_parser.y"
		local
			yyval66: ET_FEATURE_CLAUSE
		do
--|#line 1777 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1777")
end

			yyval66 := last_feature_clause
			if yyval66 /= Void then
				increment_counter
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs66.put (yyval66, yyvsp66)
end
		end

	yy_do_action_253 is
			--|#line 1784 "et_eiffel_parser.y"
		local
			yyval66: ET_FEATURE_CLAUSE
		do
--|#line 1784 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1784")
end

			yyval66 := last_feature_clause
			if yyval66 /= Void then
				increment_counter
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs66.put (yyval66, yyvsp66)
end
		end

	yy_do_action_254 is
			--|#line 1793 "et_eiffel_parser.y"
		local
			yyval66: ET_FEATURE_CLAUSE
		do
--|#line 1793 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1793")
end

			last_clients := yyvs44.item (yyvsp44)
			last_feature_clause := ast_factory.new_feature_clause (yyvs2.item (yyvsp2), last_clients)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp66 := yyvsp66 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp44 := yyvsp44 -1
	if yyvsp66 >= yyvsc66 then
		if yyvs66 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs66")
			end
			create yyspecial_routines66
			yyvsc66 := yyInitial_yyvs_size
			yyvs66 := yyspecial_routines66.make (yyvsc66)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs66")
			end
			yyvsc66 := yyvsc66 + yyInitial_yyvs_size
			yyvs66 := yyspecial_routines66.resize (yyvs66, yyvsc66)
		end
	end
	yyvs66.put (yyval66, yyvsp66)
end
		end

	yy_do_action_255 is
			--|#line 1798 "et_eiffel_parser.y"
		local
			yyval66: ET_FEATURE_CLAUSE
		do
--|#line 1798 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1798")
end

			last_clients := new_any_clients (yyvs2.item (yyvsp2))
			last_feature_clause := ast_factory.new_feature_clause (yyvs2.item (yyvsp2), last_clients)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp66 := yyvsp66 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp66 >= yyvsc66 then
		if yyvs66 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs66")
			end
			create yyspecial_routines66
			yyvsc66 := yyInitial_yyvs_size
			yyvs66 := yyspecial_routines66.make (yyvsc66)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs66")
			end
			yyvsc66 := yyvsc66 + yyInitial_yyvs_size
			yyvs66 := yyspecial_routines66.resize (yyvs66, yyvsc66)
		end
	end
	yyvs66.put (yyval66, yyvsp66)
end
		end

	yy_do_action_256 is
			--|#line 1805 "et_eiffel_parser.y"
		local
			yyval1: ANY
		do
--|#line 1805 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1805")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp1 := yyvsp1 + 1
	yyvsp107 := yyvsp107 -1
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
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_257 is
			--|#line 1806 "et_eiffel_parser.y"
		local
			yyval1: ANY
		do
--|#line 1806 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1806")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp1 := yyvsp1 + 1
	yyvsp105 := yyvsp105 -1
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
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_258 is
			--|#line 1807 "et_eiffel_parser.y"
		local
			yyval1: ANY
		do
--|#line 1807 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1807")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp107 := yyvsp107 -1
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_259 is
			--|#line 1808 "et_eiffel_parser.y"
		local
			yyval1: ANY
		do
--|#line 1808 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1808")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp105 := yyvsp105 -1
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_260 is
			--|#line 1813 "et_eiffel_parser.y"
		local
			yyval107: ET_QUERY
		do
--|#line 1813 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1813")
end

			yyval107 := yyvs107.item (yyvsp107)
			register_query (yyval107)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs107.put (yyval107, yyvsp107)
end
		end

	yy_do_action_261 is
			--|#line 1818 "et_eiffel_parser.y"
		local
			yyval107: ET_QUERY
		do
--|#line 1818 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1818")
end

			yyval107 := yyvs107.item (yyvsp107)
			yyval107.set_frozen_keyword (yyvs2.item (yyvsp2))
			register_query (yyval107)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp2 := yyvsp2 -1
	yyvs107.put (yyval107, yyvsp107)
end
		end

	yy_do_action_262 is
			--|#line 1824 "et_eiffel_parser.y"
		local
			yyval107: ET_QUERY
		do
--|#line 1824 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1824")
end

			yyval107 := new_query_synonym (ast_factory.new_extended_feature_name_comma (yyvs64.item (yyvsp64), yyvs5.item (yyvsp5)), yyvs107.item (yyvsp107))
			register_query_synonym (yyval107)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp64 := yyvsp64 -1
	yyvsp5 := yyvsp5 -1
	yyvs107.put (yyval107, yyvsp107)
end
		end

	yy_do_action_263 is
			--|#line 1829 "et_eiffel_parser.y"
		local
			yyval107: ET_QUERY
		do
--|#line 1829 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1829")
end

			yyval107 := new_query_synonym (yyvs64.item (yyvsp64), yyvs107.item (yyvsp107))
			register_query_synonym (yyval107)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp64 := yyvsp64 -1
	yyvs107.put (yyval107, yyvsp107)
end
		end

	yy_do_action_264 is
			--|#line 1835 "et_eiffel_parser.y"
		local
			yyval107: ET_QUERY
		do
--|#line 1835 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1835")
end

			yyval107 := new_query_synonym (ast_factory.new_extended_feature_name_comma (yyvs64.item (yyvsp64), yyvs5.item (yyvsp5)), yyvs107.item (yyvsp107))
			yyval107.set_frozen_keyword (yyvs2.item (yyvsp2))
			register_query_synonym (yyval107)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp2 := yyvsp2 -1
	yyvsp64 := yyvsp64 -1
	yyvsp5 := yyvsp5 -1
	yyvs107.put (yyval107, yyvsp107)
end
		end

	yy_do_action_265 is
			--|#line 1841 "et_eiffel_parser.y"
		local
			yyval107: ET_QUERY
		do
--|#line 1841 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1841")
end

			yyval107 := new_query_synonym (yyvs64.item (yyvsp64), yyvs107.item (yyvsp107))
			yyval107.set_frozen_keyword (yyvs2.item (yyvsp2))
			register_query_synonym (yyval107)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 -1
	yyvsp64 := yyvsp64 -1
	yyvs107.put (yyval107, yyvsp107)
end
		end

	yy_do_action_266 is
			--|#line 1850 "et_eiffel_parser.y"
		local
			yyval105: ET_PROCEDURE
		do
--|#line 1850 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1850")
end

			yyval105 := yyvs105.item (yyvsp105)
			register_procedure (yyval105)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs105.put (yyval105, yyvsp105)
end
		end

	yy_do_action_267 is
			--|#line 1855 "et_eiffel_parser.y"
		local
			yyval105: ET_PROCEDURE
		do
--|#line 1855 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1855")
end

			yyval105 := yyvs105.item (yyvsp105)
			yyval105.set_frozen_keyword (yyvs2.item (yyvsp2))
			register_procedure (yyval105)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp2 := yyvsp2 -1
	yyvs105.put (yyval105, yyvsp105)
end
		end

	yy_do_action_268 is
			--|#line 1861 "et_eiffel_parser.y"
		local
			yyval105: ET_PROCEDURE
		do
--|#line 1861 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1861")
end

			yyval105 := new_procedure_synonym (ast_factory.new_extended_feature_name_comma (yyvs64.item (yyvsp64), yyvs5.item (yyvsp5)), yyvs105.item (yyvsp105))
			register_procedure_synonym (yyval105)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp64 := yyvsp64 -1
	yyvsp5 := yyvsp5 -1
	yyvs105.put (yyval105, yyvsp105)
end
		end

	yy_do_action_269 is
			--|#line 1866 "et_eiffel_parser.y"
		local
			yyval105: ET_PROCEDURE
		do
--|#line 1866 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1866")
end

			yyval105 := new_procedure_synonym (yyvs64.item (yyvsp64), yyvs105.item (yyvsp105))
			register_procedure_synonym (yyval105)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp64 := yyvsp64 -1
	yyvs105.put (yyval105, yyvsp105)
end
		end

	yy_do_action_270 is
			--|#line 1872 "et_eiffel_parser.y"
		local
			yyval105: ET_PROCEDURE
		do
--|#line 1872 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1872")
end

			yyval105 := new_procedure_synonym (ast_factory.new_extended_feature_name_comma (yyvs64.item (yyvsp64), yyvs5.item (yyvsp5)), yyvs105.item (yyvsp105))
			yyval105.set_frozen_keyword (yyvs2.item (yyvsp2))
			register_procedure_synonym (yyval105)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp2 := yyvsp2 -1
	yyvsp64 := yyvsp64 -1
	yyvsp5 := yyvsp5 -1
	yyvs105.put (yyval105, yyvsp105)
end
		end

	yy_do_action_271 is
			--|#line 1878 "et_eiffel_parser.y"
		local
			yyval105: ET_PROCEDURE
		do
--|#line 1878 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1878")
end

			yyval105 := new_procedure_synonym (yyvs64.item (yyvsp64), yyvs105.item (yyvsp105))
			yyval105.set_frozen_keyword (yyvs2.item (yyvsp2))
			register_procedure_synonym (yyval105)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 -1
	yyvsp64 := yyvsp64 -1
	yyvs105.put (yyval105, yyvsp105)
end
		end

	yy_do_action_272 is
			--|#line 1887 "et_eiffel_parser.y"
		local
			yyval107: ET_QUERY
		do
--|#line 1887 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1887")
end

yyval107 := ast_factory.new_attribute (yyvs64.item (yyvsp64), ast_factory.new_colon_type (yyvs5.item (yyvsp5), yyvs112.item (yyvsp112)), yyvs33.item (yyvsp33), Void, last_clients, last_feature_clause, last_class.master_class) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp107 := yyvsp107 + 1
	yyvsp64 := yyvsp64 -1
	yyvsp5 := yyvsp5 -1
	yyvsp112 := yyvsp112 -1
	yyvsp33 := yyvsp33 -1
	if yyvsp107 >= yyvsc107 then
		if yyvs107 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs107")
			end
			create yyspecial_routines107
			yyvsc107 := yyInitial_yyvs_size
			yyvs107 := yyspecial_routines107.make (yyvsc107)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs107")
			end
			yyvsc107 := yyvsc107 + yyInitial_yyvs_size
			yyvs107 := yyspecial_routines107.resize (yyvs107, yyvsc107)
		end
	end
	yyvs107.put (yyval107, yyvsp107)
end
		end

	yy_do_action_273 is
			--|#line 1889 "et_eiffel_parser.y"
		local
			yyval107: ET_QUERY
		do
--|#line 1889 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1889")
end

yyval107 := ast_factory.new_attribute (yyvs64.item (yyvsp64), ast_factory.new_colon_type (yyvs5.item (yyvsp5), yyvs112.item (yyvsp112)), yyvs33.item (yyvsp33), yyvs22.item (yyvsp22), last_clients, last_feature_clause, last_class.master_class) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp107 := yyvsp107 + 1
	yyvsp64 := yyvsp64 -1
	yyvsp5 := yyvsp5 -1
	yyvsp112 := yyvsp112 -1
	yyvsp33 := yyvsp33 -1
	yyvsp22 := yyvsp22 -1
	if yyvsp107 >= yyvsc107 then
		if yyvs107 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs107")
			end
			create yyspecial_routines107
			yyvsc107 := yyInitial_yyvs_size
			yyvs107 := yyspecial_routines107.make (yyvsc107)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs107")
			end
			yyvsc107 := yyvsc107 + yyInitial_yyvs_size
			yyvs107 := yyspecial_routines107.resize (yyvs107, yyvsc107)
		end
	end
	yyvs107.put (yyval107, yyvsp107)
end
		end

	yy_do_action_274 is
			--|#line 1891 "et_eiffel_parser.y"
		local
			yyval107: ET_QUERY
		do
--|#line 1891 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1891")
end

yyval107 := ast_factory.new_constant_attribute (yyvs64.item (yyvsp64), ast_factory.new_colon_type (yyvs5.item (yyvsp5), yyvs112.item (yyvsp112)), yyvs33.item (yyvsp33), yyvs2.item (yyvsp2), yyvs46.item (yyvsp46), yyvs22.item (yyvsp22), last_clients, last_feature_clause, last_class.master_class) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp107 := yyvsp107 + 1
	yyvsp64 := yyvsp64 -1
	yyvsp5 := yyvsp5 -1
	yyvsp112 := yyvsp112 -1
	yyvsp33 := yyvsp33 -1
	yyvsp2 := yyvsp2 -1
	yyvsp46 := yyvsp46 -1
	yyvsp22 := yyvsp22 -1
	if yyvsp107 >= yyvsc107 then
		if yyvs107 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs107")
			end
			create yyspecial_routines107
			yyvsc107 := yyInitial_yyvs_size
			yyvs107 := yyspecial_routines107.make (yyvsc107)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs107")
			end
			yyvsc107 := yyvsc107 + yyInitial_yyvs_size
			yyvs107 := yyspecial_routines107.resize (yyvs107, yyvsc107)
		end
	end
	yyvs107.put (yyval107, yyvsp107)
end
		end

	yy_do_action_275 is
			--|#line 1893 "et_eiffel_parser.y"
		local
			yyval107: ET_QUERY
		do
--|#line 1893 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1893")
end

			if current_system.is_ise and then current_system.ise_version < ise_5_7_59914 then
				raise_error
			else
				yyval107 := ast_factory.new_constant_attribute (yyvs64.item (yyvsp64), ast_factory.new_colon_type (yyvs5.item (yyvsp5 - 1), yyvs112.item (yyvsp112)), yyvs33.item (yyvsp33), yyvs5.item (yyvsp5), yyvs46.item (yyvsp46), yyvs22.item (yyvsp22), last_clients, last_feature_clause, last_class.master_class)
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp107 := yyvsp107 + 1
	yyvsp64 := yyvsp64 -1
	yyvsp5 := yyvsp5 -2
	yyvsp112 := yyvsp112 -1
	yyvsp33 := yyvsp33 -1
	yyvsp46 := yyvsp46 -1
	yyvsp22 := yyvsp22 -1
	if yyvsp107 >= yyvsc107 then
		if yyvs107 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs107")
			end
			create yyspecial_routines107
			yyvsc107 := yyInitial_yyvs_size
			yyvs107 := yyspecial_routines107.make (yyvsc107)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs107")
			end
			yyvsc107 := yyvsc107 + yyInitial_yyvs_size
			yyvs107 := yyspecial_routines107.resize (yyvs107, yyvsc107)
		end
	end
	yyvs107.put (yyval107, yyvsp107)
end
		end

	yy_do_action_276 is
			--|#line 1901 "et_eiffel_parser.y"
		local
			yyval107: ET_QUERY
		do
--|#line 1901 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1901")
end

yyval107 := ast_factory.new_unique_attribute (yyvs64.item (yyvsp64), ast_factory.new_colon_type (yyvs5.item (yyvsp5), yyvs112.item (yyvsp112)), yyvs33.item (yyvsp33), yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2), yyvs22.item (yyvsp22), last_clients, last_feature_clause, last_class.master_class) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp107 := yyvsp107 + 1
	yyvsp64 := yyvsp64 -1
	yyvsp5 := yyvsp5 -1
	yyvsp112 := yyvsp112 -1
	yyvsp33 := yyvsp33 -1
	yyvsp2 := yyvsp2 -2
	yyvsp22 := yyvsp22 -1
	if yyvsp107 >= yyvsc107 then
		if yyvs107 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs107")
			end
			create yyspecial_routines107
			yyvsc107 := yyInitial_yyvs_size
			yyvs107 := yyspecial_routines107.make (yyvsc107)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs107")
			end
			yyvsc107 := yyvsc107 + yyInitial_yyvs_size
			yyvs107 := yyspecial_routines107.resize (yyvs107, yyvsc107)
		end
	end
	yyvs107.put (yyval107, yyvsp107)
end
		end

	yy_do_action_277 is
			--|#line 1903 "et_eiffel_parser.y"
		local
			yyval107: ET_QUERY
		do
--|#line 1903 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1903")
end

			if current_system.is_ise and then current_system.ise_version < ise_5_7_59914 then
				raise_error
			else
				yyval107 := ast_factory.new_unique_attribute (yyvs64.item (yyvsp64), ast_factory.new_colon_type (yyvs5.item (yyvsp5 - 1), yyvs112.item (yyvsp112)), yyvs33.item (yyvsp33), yyvs5.item (yyvsp5), yyvs2.item (yyvsp2), yyvs22.item (yyvsp22), last_clients, last_feature_clause, last_class.master_class)
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp107 := yyvsp107 + 1
	yyvsp64 := yyvsp64 -1
	yyvsp5 := yyvsp5 -2
	yyvsp112 := yyvsp112 -1
	yyvsp33 := yyvsp33 -1
	yyvsp2 := yyvsp2 -1
	yyvsp22 := yyvsp22 -1
	if yyvsp107 >= yyvsc107 then
		if yyvs107 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs107")
			end
			create yyspecial_routines107
			yyvsc107 := yyInitial_yyvs_size
			yyvs107 := yyspecial_routines107.make (yyvsc107)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs107")
			end
			yyvsc107 := yyvsc107 + yyInitial_yyvs_size
			yyvs107 := yyspecial_routines107.resize (yyvs107, yyvsc107)
		end
	end
	yyvs107.put (yyval107, yyvsp107)
end
		end

	yy_do_action_278 is
			--|#line 1911 "et_eiffel_parser.y"
		local
			yyval107: ET_QUERY
		do
--|#line 1911 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1911")
end

yyval107 := ast_factory.new_do_function (yyvs64.item (yyvsp64), Void, ast_factory.new_colon_type (yyvs5.item (yyvsp5), yyvs112.item (yyvsp112)), yyvs33.item (yyvsp33), yyvs2.item (yyvsp2 - 1), yyvs78.item (yyvsp78), yyvs98.item (yyvsp98), yyvs104.item (yyvsp104), yyvs91.item (yyvsp91), yyvs45.item (yyvsp45 - 1), yyvs103.item (yyvsp103), yyvs45.item (yyvsp45), yyvs2.item (yyvsp2), yyvs22.item (yyvsp22), last_clients, last_feature_clause, last_class.master_class) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 14
	yyvsp107 := yyvsp107 + 1
	yyvsp64 := yyvsp64 -1
	yyvsp5 := yyvsp5 -1
	yyvsp112 := yyvsp112 -1
	yyvsp33 := yyvsp33 -1
	yyvsp2 := yyvsp2 -2
	yyvsp78 := yyvsp78 -1
	yyvsp98 := yyvsp98 -1
	yyvsp104 := yyvsp104 -1
	yyvsp91 := yyvsp91 -1
	yyvsp45 := yyvsp45 -2
	yyvsp103 := yyvsp103 -1
	yyvsp22 := yyvsp22 -1
	if yyvsp107 >= yyvsc107 then
		if yyvs107 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs107")
			end
			create yyspecial_routines107
			yyvsc107 := yyInitial_yyvs_size
			yyvs107 := yyspecial_routines107.make (yyvsc107)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs107")
			end
			yyvsc107 := yyvsc107 + yyInitial_yyvs_size
			yyvs107 := yyspecial_routines107.resize (yyvs107, yyvsc107)
		end
	end
	yyvs107.put (yyval107, yyvsp107)
end
		end

	yy_do_action_279 is
			--|#line 1914 "et_eiffel_parser.y"
		local
			yyval107: ET_QUERY
		do
--|#line 1914 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1914")
end

			if current_system.is_ise and then current_system.ise_version < ise_5_7_59914 then
				raise_error
			else
				yyval107 := ast_factory.new_do_function (yyvs64.item (yyvsp64), Void, ast_factory.new_colon_type (yyvs5.item (yyvsp5), yyvs112.item (yyvsp112)), yyvs33.item (yyvsp33), Void, yyvs78.item (yyvsp78), yyvs98.item (yyvsp98), yyvs104.item (yyvsp104), yyvs91.item (yyvsp91), yyvs45.item (yyvsp45 - 1), yyvs103.item (yyvsp103), yyvs45.item (yyvsp45), yyvs2.item (yyvsp2), yyvs22.item (yyvsp22), last_clients, last_feature_clause, last_class.master_class)
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 13
	yyvsp107 := yyvsp107 + 1
	yyvsp64 := yyvsp64 -1
	yyvsp5 := yyvsp5 -1
	yyvsp112 := yyvsp112 -1
	yyvsp33 := yyvsp33 -1
	yyvsp78 := yyvsp78 -1
	yyvsp98 := yyvsp98 -1
	yyvsp104 := yyvsp104 -1
	yyvsp91 := yyvsp91 -1
	yyvsp45 := yyvsp45 -2
	yyvsp103 := yyvsp103 -1
	yyvsp2 := yyvsp2 -1
	yyvsp22 := yyvsp22 -1
	if yyvsp107 >= yyvsc107 then
		if yyvs107 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs107")
			end
			create yyspecial_routines107
			yyvsc107 := yyInitial_yyvs_size
			yyvs107 := yyspecial_routines107.make (yyvsc107)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs107")
			end
			yyvsc107 := yyvsc107 + yyInitial_yyvs_size
			yyvs107 := yyspecial_routines107.resize (yyvs107, yyvsc107)
		end
	end
	yyvs107.put (yyval107, yyvsp107)
end
		end

	yy_do_action_280 is
			--|#line 1923 "et_eiffel_parser.y"
		local
			yyval107: ET_QUERY
		do
--|#line 1923 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1923")
end

yyval107 := ast_factory.new_do_function (yyvs64.item (yyvsp64), yyvs73.item (yyvsp73), ast_factory.new_colon_type (yyvs5.item (yyvsp5), yyvs112.item (yyvsp112)), yyvs33.item (yyvsp33), yyvs2.item (yyvsp2 - 1), yyvs78.item (yyvsp78), yyvs98.item (yyvsp98), yyvs104.item (yyvsp104), yyvs91.item (yyvsp91), yyvs45.item (yyvsp45 - 1), yyvs103.item (yyvsp103), yyvs45.item (yyvsp45), yyvs2.item (yyvsp2), yyvs22.item (yyvsp22), last_clients, last_feature_clause, last_class.master_class) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 15
	yyvsp107 := yyvsp107 + 1
	yyvsp64 := yyvsp64 -1
	yyvsp73 := yyvsp73 -1
	yyvsp5 := yyvsp5 -1
	yyvsp112 := yyvsp112 -1
	yyvsp33 := yyvsp33 -1
	yyvsp2 := yyvsp2 -2
	yyvsp78 := yyvsp78 -1
	yyvsp98 := yyvsp98 -1
	yyvsp104 := yyvsp104 -1
	yyvsp91 := yyvsp91 -1
	yyvsp45 := yyvsp45 -2
	yyvsp103 := yyvsp103 -1
	yyvsp22 := yyvsp22 -1
	if yyvsp107 >= yyvsc107 then
		if yyvs107 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs107")
			end
			create yyspecial_routines107
			yyvsc107 := yyInitial_yyvs_size
			yyvs107 := yyspecial_routines107.make (yyvsc107)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs107")
			end
			yyvsc107 := yyvsc107 + yyInitial_yyvs_size
			yyvs107 := yyspecial_routines107.resize (yyvs107, yyvsc107)
		end
	end
	yyvs107.put (yyval107, yyvsp107)
end
		end

	yy_do_action_281 is
			--|#line 1927 "et_eiffel_parser.y"
		local
			yyval107: ET_QUERY
		do
--|#line 1927 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1927")
end

			if current_system.is_ise and then current_system.ise_version < ise_5_7_59914 then
				raise_error
			else
				yyval107 := ast_factory.new_do_function (yyvs64.item (yyvsp64), yyvs73.item (yyvsp73), ast_factory.new_colon_type (yyvs5.item (yyvsp5), yyvs112.item (yyvsp112)), yyvs33.item (yyvsp33), Void, yyvs78.item (yyvsp78), yyvs98.item (yyvsp98), yyvs104.item (yyvsp104), yyvs91.item (yyvsp91), yyvs45.item (yyvsp45 - 1), yyvs103.item (yyvsp103), yyvs45.item (yyvsp45), yyvs2.item (yyvsp2), yyvs22.item (yyvsp22), last_clients, last_feature_clause, last_class.master_class)
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 14
	yyvsp107 := yyvsp107 + 1
	yyvsp64 := yyvsp64 -1
	yyvsp73 := yyvsp73 -1
	yyvsp5 := yyvsp5 -1
	yyvsp112 := yyvsp112 -1
	yyvsp33 := yyvsp33 -1
	yyvsp78 := yyvsp78 -1
	yyvsp98 := yyvsp98 -1
	yyvsp104 := yyvsp104 -1
	yyvsp91 := yyvsp91 -1
	yyvsp45 := yyvsp45 -2
	yyvsp103 := yyvsp103 -1
	yyvsp2 := yyvsp2 -1
	yyvsp22 := yyvsp22 -1
	if yyvsp107 >= yyvsc107 then
		if yyvs107 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs107")
			end
			create yyspecial_routines107
			yyvsc107 := yyInitial_yyvs_size
			yyvs107 := yyspecial_routines107.make (yyvsc107)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs107")
			end
			yyvsc107 := yyvsc107 + yyInitial_yyvs_size
			yyvs107 := yyspecial_routines107.resize (yyvs107, yyvsc107)
		end
	end
	yyvs107.put (yyval107, yyvsp107)
end
		end

	yy_do_action_282 is
			--|#line 1937 "et_eiffel_parser.y"
		local
			yyval107: ET_QUERY
		do
--|#line 1937 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1937")
end

yyval107 := ast_factory.new_once_function (yyvs64.item (yyvsp64), Void, ast_factory.new_colon_type (yyvs5.item (yyvsp5), yyvs112.item (yyvsp112)), yyvs33.item (yyvsp33), yyvs2.item (yyvsp2 - 1), yyvs78.item (yyvsp78), yyvs98.item (yyvsp98), yyvs104.item (yyvsp104), yyvs91.item (yyvsp91), yyvs45.item (yyvsp45 - 1), yyvs103.item (yyvsp103), yyvs45.item (yyvsp45), yyvs2.item (yyvsp2), yyvs22.item (yyvsp22), last_clients, last_feature_clause, last_class.master_class) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 14
	yyvsp107 := yyvsp107 + 1
	yyvsp64 := yyvsp64 -1
	yyvsp5 := yyvsp5 -1
	yyvsp112 := yyvsp112 -1
	yyvsp33 := yyvsp33 -1
	yyvsp2 := yyvsp2 -2
	yyvsp78 := yyvsp78 -1
	yyvsp98 := yyvsp98 -1
	yyvsp104 := yyvsp104 -1
	yyvsp91 := yyvsp91 -1
	yyvsp45 := yyvsp45 -2
	yyvsp103 := yyvsp103 -1
	yyvsp22 := yyvsp22 -1
	if yyvsp107 >= yyvsc107 then
		if yyvs107 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs107")
			end
			create yyspecial_routines107
			yyvsc107 := yyInitial_yyvs_size
			yyvs107 := yyspecial_routines107.make (yyvsc107)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs107")
			end
			yyvsc107 := yyvsc107 + yyInitial_yyvs_size
			yyvs107 := yyspecial_routines107.resize (yyvs107, yyvsc107)
		end
	end
	yyvs107.put (yyval107, yyvsp107)
end
		end

	yy_do_action_283 is
			--|#line 1940 "et_eiffel_parser.y"
		local
			yyval107: ET_QUERY
		do
--|#line 1940 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1940")
end

			if current_system.is_ise and then current_system.ise_version < ise_5_7_59914 then
				raise_error
			else
				yyval107 := ast_factory.new_once_function (yyvs64.item (yyvsp64), Void, ast_factory.new_colon_type (yyvs5.item (yyvsp5), yyvs112.item (yyvsp112)), yyvs33.item (yyvsp33), Void, yyvs78.item (yyvsp78), yyvs98.item (yyvsp98), yyvs104.item (yyvsp104), yyvs91.item (yyvsp91), yyvs45.item (yyvsp45 - 1), yyvs103.item (yyvsp103), yyvs45.item (yyvsp45), yyvs2.item (yyvsp2), yyvs22.item (yyvsp22), last_clients, last_feature_clause, last_class.master_class)
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 13
	yyvsp107 := yyvsp107 + 1
	yyvsp64 := yyvsp64 -1
	yyvsp5 := yyvsp5 -1
	yyvsp112 := yyvsp112 -1
	yyvsp33 := yyvsp33 -1
	yyvsp78 := yyvsp78 -1
	yyvsp98 := yyvsp98 -1
	yyvsp104 := yyvsp104 -1
	yyvsp91 := yyvsp91 -1
	yyvsp45 := yyvsp45 -2
	yyvsp103 := yyvsp103 -1
	yyvsp2 := yyvsp2 -1
	yyvsp22 := yyvsp22 -1
	if yyvsp107 >= yyvsc107 then
		if yyvs107 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs107")
			end
			create yyspecial_routines107
			yyvsc107 := yyInitial_yyvs_size
			yyvs107 := yyspecial_routines107.make (yyvsc107)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs107")
			end
			yyvsc107 := yyvsc107 + yyInitial_yyvs_size
			yyvs107 := yyspecial_routines107.resize (yyvs107, yyvsc107)
		end
	end
	yyvs107.put (yyval107, yyvsp107)
end
		end

	yy_do_action_284 is
			--|#line 1949 "et_eiffel_parser.y"
		local
			yyval107: ET_QUERY
		do
--|#line 1949 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1949")
end

yyval107 := ast_factory.new_once_function (yyvs64.item (yyvsp64), yyvs73.item (yyvsp73), ast_factory.new_colon_type (yyvs5.item (yyvsp5), yyvs112.item (yyvsp112)), yyvs33.item (yyvsp33), yyvs2.item (yyvsp2 - 1), yyvs78.item (yyvsp78), yyvs98.item (yyvsp98), yyvs104.item (yyvsp104), yyvs91.item (yyvsp91), yyvs45.item (yyvsp45 - 1), yyvs103.item (yyvsp103), yyvs45.item (yyvsp45), yyvs2.item (yyvsp2), yyvs22.item (yyvsp22), last_clients, last_feature_clause, last_class.master_class) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 15
	yyvsp107 := yyvsp107 + 1
	yyvsp64 := yyvsp64 -1
	yyvsp73 := yyvsp73 -1
	yyvsp5 := yyvsp5 -1
	yyvsp112 := yyvsp112 -1
	yyvsp33 := yyvsp33 -1
	yyvsp2 := yyvsp2 -2
	yyvsp78 := yyvsp78 -1
	yyvsp98 := yyvsp98 -1
	yyvsp104 := yyvsp104 -1
	yyvsp91 := yyvsp91 -1
	yyvsp45 := yyvsp45 -2
	yyvsp103 := yyvsp103 -1
	yyvsp22 := yyvsp22 -1
	if yyvsp107 >= yyvsc107 then
		if yyvs107 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs107")
			end
			create yyspecial_routines107
			yyvsc107 := yyInitial_yyvs_size
			yyvs107 := yyspecial_routines107.make (yyvsc107)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs107")
			end
			yyvsc107 := yyvsc107 + yyInitial_yyvs_size
			yyvs107 := yyspecial_routines107.resize (yyvs107, yyvsc107)
		end
	end
	yyvs107.put (yyval107, yyvsp107)
end
		end

	yy_do_action_285 is
			--|#line 1953 "et_eiffel_parser.y"
		local
			yyval107: ET_QUERY
		do
--|#line 1953 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1953")
end

			if current_system.is_ise and then current_system.ise_version < ise_5_7_59914 then
				raise_error
			else
				yyval107 := ast_factory.new_once_function (yyvs64.item (yyvsp64), yyvs73.item (yyvsp73), ast_factory.new_colon_type (yyvs5.item (yyvsp5), yyvs112.item (yyvsp112)), yyvs33.item (yyvsp33), Void, yyvs78.item (yyvsp78), yyvs98.item (yyvsp98), yyvs104.item (yyvsp104), yyvs91.item (yyvsp91), yyvs45.item (yyvsp45 - 1), yyvs103.item (yyvsp103), yyvs45.item (yyvsp45), yyvs2.item (yyvsp2), yyvs22.item (yyvsp22), last_clients, last_feature_clause, last_class.master_class)
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 14
	yyvsp107 := yyvsp107 + 1
	yyvsp64 := yyvsp64 -1
	yyvsp73 := yyvsp73 -1
	yyvsp5 := yyvsp5 -1
	yyvsp112 := yyvsp112 -1
	yyvsp33 := yyvsp33 -1
	yyvsp78 := yyvsp78 -1
	yyvsp98 := yyvsp98 -1
	yyvsp104 := yyvsp104 -1
	yyvsp91 := yyvsp91 -1
	yyvsp45 := yyvsp45 -2
	yyvsp103 := yyvsp103 -1
	yyvsp2 := yyvsp2 -1
	yyvsp22 := yyvsp22 -1
	if yyvsp107 >= yyvsc107 then
		if yyvs107 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs107")
			end
			create yyspecial_routines107
			yyvsc107 := yyInitial_yyvs_size
			yyvs107 := yyspecial_routines107.make (yyvsc107)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs107")
			end
			yyvsc107 := yyvsc107 + yyInitial_yyvs_size
			yyvs107 := yyspecial_routines107.resize (yyvs107, yyvsc107)
		end
	end
	yyvs107.put (yyval107, yyvsp107)
end
		end

	yy_do_action_286 is
			--|#line 1963 "et_eiffel_parser.y"
		local
			yyval107: ET_QUERY
		do
--|#line 1963 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1963")
end

yyval107 := ast_factory.new_deferred_function (yyvs64.item (yyvsp64), Void, ast_factory.new_colon_type (yyvs5.item (yyvsp5), yyvs112.item (yyvsp112)), yyvs33.item (yyvsp33), yyvs2.item (yyvsp2 - 2), yyvs78.item (yyvsp78), yyvs98.item (yyvsp98), yyvs104.item (yyvsp104), yyvs2.item (yyvsp2 - 1), yyvs103.item (yyvsp103), yyvs2.item (yyvsp2), yyvs22.item (yyvsp22), last_clients, last_feature_clause, last_class.master_class) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 12
	yyvsp107 := yyvsp107 + 1
	yyvsp64 := yyvsp64 -1
	yyvsp5 := yyvsp5 -1
	yyvsp112 := yyvsp112 -1
	yyvsp33 := yyvsp33 -1
	yyvsp2 := yyvsp2 -3
	yyvsp78 := yyvsp78 -1
	yyvsp98 := yyvsp98 -1
	yyvsp104 := yyvsp104 -1
	yyvsp103 := yyvsp103 -1
	yyvsp22 := yyvsp22 -1
	if yyvsp107 >= yyvsc107 then
		if yyvs107 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs107")
			end
			create yyspecial_routines107
			yyvsc107 := yyInitial_yyvs_size
			yyvs107 := yyspecial_routines107.make (yyvsc107)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs107")
			end
			yyvsc107 := yyvsc107 + yyInitial_yyvs_size
			yyvs107 := yyspecial_routines107.resize (yyvs107, yyvsc107)
		end
	end
	yyvs107.put (yyval107, yyvsp107)
end
		end

	yy_do_action_287 is
			--|#line 1965 "et_eiffel_parser.y"
		local
			yyval107: ET_QUERY
		do
--|#line 1965 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1965")
end

			if current_system.is_ise and then current_system.ise_version < ise_5_7_59914 then
				raise_error
			else
				yyval107 := ast_factory.new_deferred_function (yyvs64.item (yyvsp64), Void, ast_factory.new_colon_type (yyvs5.item (yyvsp5), yyvs112.item (yyvsp112)), yyvs33.item (yyvsp33), Void, yyvs78.item (yyvsp78), yyvs98.item (yyvsp98), yyvs104.item (yyvsp104), yyvs2.item (yyvsp2 - 1), yyvs103.item (yyvsp103), yyvs2.item (yyvsp2), yyvs22.item (yyvsp22), last_clients, last_feature_clause, last_class.master_class)
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 11
	yyvsp107 := yyvsp107 + 1
	yyvsp64 := yyvsp64 -1
	yyvsp5 := yyvsp5 -1
	yyvsp112 := yyvsp112 -1
	yyvsp33 := yyvsp33 -1
	yyvsp78 := yyvsp78 -1
	yyvsp98 := yyvsp98 -1
	yyvsp104 := yyvsp104 -1
	yyvsp2 := yyvsp2 -2
	yyvsp103 := yyvsp103 -1
	yyvsp22 := yyvsp22 -1
	if yyvsp107 >= yyvsc107 then
		if yyvs107 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs107")
			end
			create yyspecial_routines107
			yyvsc107 := yyInitial_yyvs_size
			yyvs107 := yyspecial_routines107.make (yyvsc107)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs107")
			end
			yyvsc107 := yyvsc107 + yyInitial_yyvs_size
			yyvs107 := yyspecial_routines107.resize (yyvs107, yyvsc107)
		end
	end
	yyvs107.put (yyval107, yyvsp107)
end
		end

	yy_do_action_288 is
			--|#line 1973 "et_eiffel_parser.y"
		local
			yyval107: ET_QUERY
		do
--|#line 1973 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1973")
end

yyval107 := ast_factory.new_deferred_function (yyvs64.item (yyvsp64), yyvs73.item (yyvsp73), ast_factory.new_colon_type (yyvs5.item (yyvsp5), yyvs112.item (yyvsp112)), yyvs33.item (yyvsp33), yyvs2.item (yyvsp2 - 2), yyvs78.item (yyvsp78), yyvs98.item (yyvsp98), yyvs104.item (yyvsp104), yyvs2.item (yyvsp2 - 1), yyvs103.item (yyvsp103), yyvs2.item (yyvsp2), yyvs22.item (yyvsp22), last_clients, last_feature_clause, last_class.master_class) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 13
	yyvsp107 := yyvsp107 + 1
	yyvsp64 := yyvsp64 -1
	yyvsp73 := yyvsp73 -1
	yyvsp5 := yyvsp5 -1
	yyvsp112 := yyvsp112 -1
	yyvsp33 := yyvsp33 -1
	yyvsp2 := yyvsp2 -3
	yyvsp78 := yyvsp78 -1
	yyvsp98 := yyvsp98 -1
	yyvsp104 := yyvsp104 -1
	yyvsp103 := yyvsp103 -1
	yyvsp22 := yyvsp22 -1
	if yyvsp107 >= yyvsc107 then
		if yyvs107 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs107")
			end
			create yyspecial_routines107
			yyvsc107 := yyInitial_yyvs_size
			yyvs107 := yyspecial_routines107.make (yyvsc107)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs107")
			end
			yyvsc107 := yyvsc107 + yyInitial_yyvs_size
			yyvs107 := yyspecial_routines107.resize (yyvs107, yyvsc107)
		end
	end
	yyvs107.put (yyval107, yyvsp107)
end
		end

	yy_do_action_289 is
			--|#line 1976 "et_eiffel_parser.y"
		local
			yyval107: ET_QUERY
		do
--|#line 1976 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1976")
end

			if current_system.is_ise and then current_system.ise_version < ise_5_7_59914 then
				raise_error
			else
				yyval107 := ast_factory.new_deferred_function (yyvs64.item (yyvsp64), yyvs73.item (yyvsp73), ast_factory.new_colon_type (yyvs5.item (yyvsp5), yyvs112.item (yyvsp112)), yyvs33.item (yyvsp33), Void, yyvs78.item (yyvsp78), yyvs98.item (yyvsp98), yyvs104.item (yyvsp104), yyvs2.item (yyvsp2 - 1), yyvs103.item (yyvsp103), yyvs2.item (yyvsp2), yyvs22.item (yyvsp22), last_clients, last_feature_clause, last_class.master_class)
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 12
	yyvsp107 := yyvsp107 + 1
	yyvsp64 := yyvsp64 -1
	yyvsp73 := yyvsp73 -1
	yyvsp5 := yyvsp5 -1
	yyvsp112 := yyvsp112 -1
	yyvsp33 := yyvsp33 -1
	yyvsp78 := yyvsp78 -1
	yyvsp98 := yyvsp98 -1
	yyvsp104 := yyvsp104 -1
	yyvsp2 := yyvsp2 -2
	yyvsp103 := yyvsp103 -1
	yyvsp22 := yyvsp22 -1
	if yyvsp107 >= yyvsc107 then
		if yyvs107 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs107")
			end
			create yyspecial_routines107
			yyvsc107 := yyInitial_yyvs_size
			yyvs107 := yyspecial_routines107.make (yyvsc107)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs107")
			end
			yyvsc107 := yyvsc107 + yyInitial_yyvs_size
			yyvs107 := yyspecial_routines107.resize (yyvs107, yyvsc107)
		end
	end
	yyvs107.put (yyval107, yyvsp107)
end
		end

	yy_do_action_290 is
			--|#line 1985 "et_eiffel_parser.y"
		local
			yyval107: ET_QUERY
		do
--|#line 1985 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1985")
end

yyval107 := new_external_function (yyvs64.item (yyvsp64), Void, ast_factory.new_colon_type (yyvs5.item (yyvsp5), yyvs112.item (yyvsp112)), yyvs33.item (yyvsp33), yyvs2.item (yyvsp2 - 2), yyvs78.item (yyvsp78), yyvs98.item (yyvsp98), yyvs104.item (yyvsp104), ast_factory.new_external_language (yyvs2.item (yyvsp2 - 1), yyvs16.item (yyvsp16)), yyvs65.item (yyvsp65), yyvs103.item (yyvsp103), yyvs2.item (yyvsp2), yyvs22.item (yyvsp22), last_clients, last_feature_clause, last_class.master_class) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 14
	yyvsp107 := yyvsp107 + 1
	yyvsp64 := yyvsp64 -1
	yyvsp5 := yyvsp5 -1
	yyvsp112 := yyvsp112 -1
	yyvsp33 := yyvsp33 -1
	yyvsp2 := yyvsp2 -3
	yyvsp78 := yyvsp78 -1
	yyvsp98 := yyvsp98 -1
	yyvsp104 := yyvsp104 -1
	yyvsp16 := yyvsp16 -1
	yyvsp65 := yyvsp65 -1
	yyvsp103 := yyvsp103 -1
	yyvsp22 := yyvsp22 -1
	if yyvsp107 >= yyvsc107 then
		if yyvs107 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs107")
			end
			create yyspecial_routines107
			yyvsc107 := yyInitial_yyvs_size
			yyvs107 := yyspecial_routines107.make (yyvsc107)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs107")
			end
			yyvsc107 := yyvsc107 + yyInitial_yyvs_size
			yyvs107 := yyspecial_routines107.resize (yyvs107, yyvsc107)
		end
	end
	yyvs107.put (yyval107, yyvsp107)
end
		end

	yy_do_action_291 is
			--|#line 1988 "et_eiffel_parser.y"
		local
			yyval107: ET_QUERY
		do
--|#line 1988 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1988")
end

			if current_system.is_ise and then current_system.ise_version < ise_5_7_59914 then
				raise_error
			else
				yyval107 := new_external_function (yyvs64.item (yyvsp64), Void, ast_factory.new_colon_type (yyvs5.item (yyvsp5), yyvs112.item (yyvsp112)), yyvs33.item (yyvsp33), Void, yyvs78.item (yyvsp78), yyvs98.item (yyvsp98), yyvs104.item (yyvsp104), ast_factory.new_external_language (yyvs2.item (yyvsp2 - 1), yyvs16.item (yyvsp16)), yyvs65.item (yyvsp65), yyvs103.item (yyvsp103), yyvs2.item (yyvsp2), yyvs22.item (yyvsp22), last_clients, last_feature_clause, last_class.master_class)
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 13
	yyvsp107 := yyvsp107 + 1
	yyvsp64 := yyvsp64 -1
	yyvsp5 := yyvsp5 -1
	yyvsp112 := yyvsp112 -1
	yyvsp33 := yyvsp33 -1
	yyvsp78 := yyvsp78 -1
	yyvsp98 := yyvsp98 -1
	yyvsp104 := yyvsp104 -1
	yyvsp2 := yyvsp2 -2
	yyvsp16 := yyvsp16 -1
	yyvsp65 := yyvsp65 -1
	yyvsp103 := yyvsp103 -1
	yyvsp22 := yyvsp22 -1
	if yyvsp107 >= yyvsc107 then
		if yyvs107 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs107")
			end
			create yyspecial_routines107
			yyvsc107 := yyInitial_yyvs_size
			yyvs107 := yyspecial_routines107.make (yyvsc107)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs107")
			end
			yyvsc107 := yyvsc107 + yyInitial_yyvs_size
			yyvs107 := yyspecial_routines107.resize (yyvs107, yyvsc107)
		end
	end
	yyvs107.put (yyval107, yyvsp107)
end
		end

	yy_do_action_292 is
			--|#line 1997 "et_eiffel_parser.y"
		local
			yyval107: ET_QUERY
		do
--|#line 1997 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1997")
end

yyval107 := new_external_function (yyvs64.item (yyvsp64), yyvs73.item (yyvsp73), ast_factory.new_colon_type (yyvs5.item (yyvsp5), yyvs112.item (yyvsp112)), yyvs33.item (yyvsp33), yyvs2.item (yyvsp2 - 2), yyvs78.item (yyvsp78), yyvs98.item (yyvsp98), yyvs104.item (yyvsp104), ast_factory.new_external_language (yyvs2.item (yyvsp2 - 1), yyvs16.item (yyvsp16)), yyvs65.item (yyvsp65), yyvs103.item (yyvsp103), yyvs2.item (yyvsp2), yyvs22.item (yyvsp22), last_clients, last_feature_clause, last_class.master_class) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 15
	yyvsp107 := yyvsp107 + 1
	yyvsp64 := yyvsp64 -1
	yyvsp73 := yyvsp73 -1
	yyvsp5 := yyvsp5 -1
	yyvsp112 := yyvsp112 -1
	yyvsp33 := yyvsp33 -1
	yyvsp2 := yyvsp2 -3
	yyvsp78 := yyvsp78 -1
	yyvsp98 := yyvsp98 -1
	yyvsp104 := yyvsp104 -1
	yyvsp16 := yyvsp16 -1
	yyvsp65 := yyvsp65 -1
	yyvsp103 := yyvsp103 -1
	yyvsp22 := yyvsp22 -1
	if yyvsp107 >= yyvsc107 then
		if yyvs107 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs107")
			end
			create yyspecial_routines107
			yyvsc107 := yyInitial_yyvs_size
			yyvs107 := yyspecial_routines107.make (yyvsc107)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs107")
			end
			yyvsc107 := yyvsc107 + yyInitial_yyvs_size
			yyvs107 := yyspecial_routines107.resize (yyvs107, yyvsc107)
		end
	end
	yyvs107.put (yyval107, yyvsp107)
end
		end

	yy_do_action_293 is
			--|#line 2001 "et_eiffel_parser.y"
		local
			yyval107: ET_QUERY
		do
--|#line 2001 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2001")
end

			if current_system.is_ise and then current_system.ise_version < ise_5_7_59914 then
				raise_error
			else
				yyval107 := new_external_function (yyvs64.item (yyvsp64), yyvs73.item (yyvsp73), ast_factory.new_colon_type (yyvs5.item (yyvsp5), yyvs112.item (yyvsp112)), yyvs33.item (yyvsp33), Void, yyvs78.item (yyvsp78), yyvs98.item (yyvsp98), yyvs104.item (yyvsp104), ast_factory.new_external_language (yyvs2.item (yyvsp2 - 1), yyvs16.item (yyvsp16)), yyvs65.item (yyvsp65), yyvs103.item (yyvsp103), yyvs2.item (yyvsp2), yyvs22.item (yyvsp22), last_clients, last_feature_clause, last_class.master_class)
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 14
	yyvsp107 := yyvsp107 + 1
	yyvsp64 := yyvsp64 -1
	yyvsp73 := yyvsp73 -1
	yyvsp5 := yyvsp5 -1
	yyvsp112 := yyvsp112 -1
	yyvsp33 := yyvsp33 -1
	yyvsp78 := yyvsp78 -1
	yyvsp98 := yyvsp98 -1
	yyvsp104 := yyvsp104 -1
	yyvsp2 := yyvsp2 -2
	yyvsp16 := yyvsp16 -1
	yyvsp65 := yyvsp65 -1
	yyvsp103 := yyvsp103 -1
	yyvsp22 := yyvsp22 -1
	if yyvsp107 >= yyvsc107 then
		if yyvs107 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs107")
			end
			create yyspecial_routines107
			yyvsc107 := yyInitial_yyvs_size
			yyvs107 := yyspecial_routines107.make (yyvsc107)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs107")
			end
			yyvsc107 := yyvsc107 + yyInitial_yyvs_size
			yyvs107 := yyspecial_routines107.resize (yyvs107, yyvsc107)
		end
	end
	yyvs107.put (yyval107, yyvsp107)
end
		end

	yy_do_action_294 is
			--|#line 2013 "et_eiffel_parser.y"
		local
			yyval105: ET_PROCEDURE
		do
--|#line 2013 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2013")
end

yyval105 := ast_factory.new_do_procedure (yyvs64.item (yyvsp64), Void, yyvs2.item (yyvsp2 - 1), yyvs78.item (yyvsp78), yyvs98.item (yyvsp98), yyvs104.item (yyvsp104), yyvs91.item (yyvsp91), yyvs45.item (yyvsp45 - 1), yyvs103.item (yyvsp103), yyvs45.item (yyvsp45), yyvs2.item (yyvsp2), yyvs22.item (yyvsp22), last_clients, last_feature_clause, last_class.master_class) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 11
	yyvsp105 := yyvsp105 + 1
	yyvsp64 := yyvsp64 -1
	yyvsp2 := yyvsp2 -2
	yyvsp78 := yyvsp78 -1
	yyvsp98 := yyvsp98 -1
	yyvsp104 := yyvsp104 -1
	yyvsp91 := yyvsp91 -1
	yyvsp45 := yyvsp45 -2
	yyvsp103 := yyvsp103 -1
	yyvsp22 := yyvsp22 -1
	if yyvsp105 >= yyvsc105 then
		if yyvs105 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs105")
			end
			create yyspecial_routines105
			yyvsc105 := yyInitial_yyvs_size
			yyvs105 := yyspecial_routines105.make (yyvsc105)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs105")
			end
			yyvsc105 := yyvsc105 + yyInitial_yyvs_size
			yyvs105 := yyspecial_routines105.resize (yyvs105, yyvsc105)
		end
	end
	yyvs105.put (yyval105, yyvsp105)
end
		end

	yy_do_action_295 is
			--|#line 2016 "et_eiffel_parser.y"
		local
			yyval105: ET_PROCEDURE
		do
--|#line 2016 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2016")
end

yyval105 := ast_factory.new_do_procedure (yyvs64.item (yyvsp64), yyvs73.item (yyvsp73), yyvs2.item (yyvsp2 - 1), yyvs78.item (yyvsp78), yyvs98.item (yyvsp98), yyvs104.item (yyvsp104), yyvs91.item (yyvsp91), yyvs45.item (yyvsp45 - 1), yyvs103.item (yyvsp103), yyvs45.item (yyvsp45), yyvs2.item (yyvsp2), yyvs22.item (yyvsp22), last_clients, last_feature_clause, last_class.master_class) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 12
	yyvsp105 := yyvsp105 + 1
	yyvsp64 := yyvsp64 -1
	yyvsp73 := yyvsp73 -1
	yyvsp2 := yyvsp2 -2
	yyvsp78 := yyvsp78 -1
	yyvsp98 := yyvsp98 -1
	yyvsp104 := yyvsp104 -1
	yyvsp91 := yyvsp91 -1
	yyvsp45 := yyvsp45 -2
	yyvsp103 := yyvsp103 -1
	yyvsp22 := yyvsp22 -1
	if yyvsp105 >= yyvsc105 then
		if yyvs105 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs105")
			end
			create yyspecial_routines105
			yyvsc105 := yyInitial_yyvs_size
			yyvs105 := yyspecial_routines105.make (yyvsc105)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs105")
			end
			yyvsc105 := yyvsc105 + yyInitial_yyvs_size
			yyvs105 := yyspecial_routines105.resize (yyvs105, yyvsc105)
		end
	end
	yyvs105.put (yyval105, yyvsp105)
end
		end

	yy_do_action_296 is
			--|#line 2020 "et_eiffel_parser.y"
		local
			yyval105: ET_PROCEDURE
		do
--|#line 2020 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2020")
end

yyval105 := ast_factory.new_once_procedure (yyvs64.item (yyvsp64), Void, yyvs2.item (yyvsp2 - 1), yyvs78.item (yyvsp78), yyvs98.item (yyvsp98), yyvs104.item (yyvsp104), yyvs91.item (yyvsp91), yyvs45.item (yyvsp45 - 1), yyvs103.item (yyvsp103), yyvs45.item (yyvsp45), yyvs2.item (yyvsp2), yyvs22.item (yyvsp22), last_clients, last_feature_clause, last_class.master_class) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 11
	yyvsp105 := yyvsp105 + 1
	yyvsp64 := yyvsp64 -1
	yyvsp2 := yyvsp2 -2
	yyvsp78 := yyvsp78 -1
	yyvsp98 := yyvsp98 -1
	yyvsp104 := yyvsp104 -1
	yyvsp91 := yyvsp91 -1
	yyvsp45 := yyvsp45 -2
	yyvsp103 := yyvsp103 -1
	yyvsp22 := yyvsp22 -1
	if yyvsp105 >= yyvsc105 then
		if yyvs105 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs105")
			end
			create yyspecial_routines105
			yyvsc105 := yyInitial_yyvs_size
			yyvs105 := yyspecial_routines105.make (yyvsc105)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs105")
			end
			yyvsc105 := yyvsc105 + yyInitial_yyvs_size
			yyvs105 := yyspecial_routines105.resize (yyvs105, yyvsc105)
		end
	end
	yyvs105.put (yyval105, yyvsp105)
end
		end

	yy_do_action_297 is
			--|#line 2023 "et_eiffel_parser.y"
		local
			yyval105: ET_PROCEDURE
		do
--|#line 2023 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2023")
end

yyval105 := ast_factory.new_once_procedure (yyvs64.item (yyvsp64), yyvs73.item (yyvsp73), yyvs2.item (yyvsp2 - 1), yyvs78.item (yyvsp78), yyvs98.item (yyvsp98), yyvs104.item (yyvsp104), yyvs91.item (yyvsp91), yyvs45.item (yyvsp45 - 1), yyvs103.item (yyvsp103), yyvs45.item (yyvsp45), yyvs2.item (yyvsp2), yyvs22.item (yyvsp22), last_clients, last_feature_clause, last_class.master_class) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 12
	yyvsp105 := yyvsp105 + 1
	yyvsp64 := yyvsp64 -1
	yyvsp73 := yyvsp73 -1
	yyvsp2 := yyvsp2 -2
	yyvsp78 := yyvsp78 -1
	yyvsp98 := yyvsp98 -1
	yyvsp104 := yyvsp104 -1
	yyvsp91 := yyvsp91 -1
	yyvsp45 := yyvsp45 -2
	yyvsp103 := yyvsp103 -1
	yyvsp22 := yyvsp22 -1
	if yyvsp105 >= yyvsc105 then
		if yyvs105 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs105")
			end
			create yyspecial_routines105
			yyvsc105 := yyInitial_yyvs_size
			yyvs105 := yyspecial_routines105.make (yyvsc105)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs105")
			end
			yyvsc105 := yyvsc105 + yyInitial_yyvs_size
			yyvs105 := yyspecial_routines105.resize (yyvs105, yyvsc105)
		end
	end
	yyvs105.put (yyval105, yyvsp105)
end
		end

	yy_do_action_298 is
			--|#line 2027 "et_eiffel_parser.y"
		local
			yyval105: ET_PROCEDURE
		do
--|#line 2027 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2027")
end

yyval105 := ast_factory.new_deferred_procedure (yyvs64.item (yyvsp64), Void, yyvs2.item (yyvsp2 - 2), yyvs78.item (yyvsp78), yyvs98.item (yyvsp98), yyvs104.item (yyvsp104), yyvs2.item (yyvsp2 - 1), yyvs103.item (yyvsp103), yyvs2.item (yyvsp2), yyvs22.item (yyvsp22), last_clients, last_feature_clause, last_class.master_class) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 9
	yyvsp105 := yyvsp105 + 1
	yyvsp64 := yyvsp64 -1
	yyvsp2 := yyvsp2 -3
	yyvsp78 := yyvsp78 -1
	yyvsp98 := yyvsp98 -1
	yyvsp104 := yyvsp104 -1
	yyvsp103 := yyvsp103 -1
	yyvsp22 := yyvsp22 -1
	if yyvsp105 >= yyvsc105 then
		if yyvs105 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs105")
			end
			create yyspecial_routines105
			yyvsc105 := yyInitial_yyvs_size
			yyvs105 := yyspecial_routines105.make (yyvsc105)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs105")
			end
			yyvsc105 := yyvsc105 + yyInitial_yyvs_size
			yyvs105 := yyspecial_routines105.resize (yyvs105, yyvsc105)
		end
	end
	yyvs105.put (yyval105, yyvsp105)
end
		end

	yy_do_action_299 is
			--|#line 2029 "et_eiffel_parser.y"
		local
			yyval105: ET_PROCEDURE
		do
--|#line 2029 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2029")
end

yyval105 := ast_factory.new_deferred_procedure (yyvs64.item (yyvsp64), yyvs73.item (yyvsp73), yyvs2.item (yyvsp2 - 2), yyvs78.item (yyvsp78), yyvs98.item (yyvsp98), yyvs104.item (yyvsp104), yyvs2.item (yyvsp2 - 1), yyvs103.item (yyvsp103), yyvs2.item (yyvsp2), yyvs22.item (yyvsp22), last_clients, last_feature_clause, last_class.master_class) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 10
	yyvsp105 := yyvsp105 + 1
	yyvsp64 := yyvsp64 -1
	yyvsp73 := yyvsp73 -1
	yyvsp2 := yyvsp2 -3
	yyvsp78 := yyvsp78 -1
	yyvsp98 := yyvsp98 -1
	yyvsp104 := yyvsp104 -1
	yyvsp103 := yyvsp103 -1
	yyvsp22 := yyvsp22 -1
	if yyvsp105 >= yyvsc105 then
		if yyvs105 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs105")
			end
			create yyspecial_routines105
			yyvsc105 := yyInitial_yyvs_size
			yyvs105 := yyspecial_routines105.make (yyvsc105)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs105")
			end
			yyvsc105 := yyvsc105 + yyInitial_yyvs_size
			yyvs105 := yyspecial_routines105.resize (yyvs105, yyvsc105)
		end
	end
	yyvs105.put (yyval105, yyvsp105)
end
		end

	yy_do_action_300 is
			--|#line 2032 "et_eiffel_parser.y"
		local
			yyval105: ET_PROCEDURE
		do
--|#line 2032 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2032")
end

yyval105 := new_external_procedure (yyvs64.item (yyvsp64), Void, yyvs2.item (yyvsp2 - 2), yyvs78.item (yyvsp78), yyvs98.item (yyvsp98), yyvs104.item (yyvsp104), ast_factory.new_external_language (yyvs2.item (yyvsp2 - 1), yyvs16.item (yyvsp16)), yyvs65.item (yyvsp65), yyvs103.item (yyvsp103), yyvs2.item (yyvsp2), yyvs22.item (yyvsp22), last_clients, last_feature_clause, last_class.master_class) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 11
	yyvsp105 := yyvsp105 + 1
	yyvsp64 := yyvsp64 -1
	yyvsp2 := yyvsp2 -3
	yyvsp78 := yyvsp78 -1
	yyvsp98 := yyvsp98 -1
	yyvsp104 := yyvsp104 -1
	yyvsp16 := yyvsp16 -1
	yyvsp65 := yyvsp65 -1
	yyvsp103 := yyvsp103 -1
	yyvsp22 := yyvsp22 -1
	if yyvsp105 >= yyvsc105 then
		if yyvs105 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs105")
			end
			create yyspecial_routines105
			yyvsc105 := yyInitial_yyvs_size
			yyvs105 := yyspecial_routines105.make (yyvsc105)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs105")
			end
			yyvsc105 := yyvsc105 + yyInitial_yyvs_size
			yyvs105 := yyspecial_routines105.resize (yyvs105, yyvsc105)
		end
	end
	yyvs105.put (yyval105, yyvsp105)
end
		end

	yy_do_action_301 is
			--|#line 2035 "et_eiffel_parser.y"
		local
			yyval105: ET_PROCEDURE
		do
--|#line 2035 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2035")
end

yyval105 := new_external_procedure (yyvs64.item (yyvsp64), yyvs73.item (yyvsp73), yyvs2.item (yyvsp2 - 2), yyvs78.item (yyvsp78), yyvs98.item (yyvsp98), yyvs104.item (yyvsp104), ast_factory.new_external_language (yyvs2.item (yyvsp2 - 1), yyvs16.item (yyvsp16)), yyvs65.item (yyvsp65), yyvs103.item (yyvsp103), yyvs2.item (yyvsp2), yyvs22.item (yyvsp22), last_clients, last_feature_clause, last_class.master_class) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 12
	yyvsp105 := yyvsp105 + 1
	yyvsp64 := yyvsp64 -1
	yyvsp73 := yyvsp73 -1
	yyvsp2 := yyvsp2 -3
	yyvsp78 := yyvsp78 -1
	yyvsp98 := yyvsp98 -1
	yyvsp104 := yyvsp104 -1
	yyvsp16 := yyvsp16 -1
	yyvsp65 := yyvsp65 -1
	yyvsp103 := yyvsp103 -1
	yyvsp22 := yyvsp22 -1
	if yyvsp105 >= yyvsc105 then
		if yyvs105 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs105")
			end
			create yyspecial_routines105
			yyvsc105 := yyInitial_yyvs_size
			yyvs105 := yyspecial_routines105.make (yyvsc105)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs105")
			end
			yyvsc105 := yyvsc105 + yyInitial_yyvs_size
			yyvs105 := yyspecial_routines105.resize (yyvs105, yyvsc105)
		end
	end
	yyvs105.put (yyval105, yyvsp105)
end
		end

	yy_do_action_302 is
			--|#line 2041 "et_eiffel_parser.y"
		local
			yyval2: ET_KEYWORD
		do
--|#line 2041 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2041")
end

			if current_system.is_ise and then current_system.ise_version < ise_5_7_59914 then
				raise_error
			else
				yyval2 := Void
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp2 := yyvsp2 + 1
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
	yyvs2.put (yyval2, yyvsp2)
end
		end

	yy_do_action_303 is
			--|#line 2049 "et_eiffel_parser.y"
		local
			yyval2: ET_KEYWORD
		do
--|#line 2049 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2049")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
		end

	yy_do_action_304 is
			--|#line 2053 "et_eiffel_parser.y"
		local
			yyval22: ET_SEMICOLON_SYMBOL
		do
--|#line 2053 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2053")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp22 := yyvsp22 + 1
	if yyvsp22 >= yyvsc22 then
		if yyvs22 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs22")
			end
			create yyspecial_routines22
			yyvsc22 := yyInitial_yyvs_size
			yyvs22 := yyspecial_routines22.make (yyvsc22)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs22")
			end
			yyvsc22 := yyvsc22 + yyInitial_yyvs_size
			yyvs22 := yyspecial_routines22.resize (yyvs22, yyvsc22)
		end
	end
	yyvs22.put (yyval22, yyvsp22)
end
		end

	yy_do_action_305 is
			--|#line 2055 "et_eiffel_parser.y"
		local
			yyval22: ET_SEMICOLON_SYMBOL
		do
--|#line 2055 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2055")
end

yyval22 := yyvs22.item (yyvsp22) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs22.put (yyval22, yyvsp22)
end
		end

	yy_do_action_306 is
			--|#line 2059 "et_eiffel_parser.y"
		local
			yyval65: ET_EXTERNAL_ALIAS
		do
--|#line 2059 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2059")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp65 := yyvsp65 + 1
	if yyvsp65 >= yyvsc65 then
		if yyvs65 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs65")
			end
			create yyspecial_routines65
			yyvsc65 := yyInitial_yyvs_size
			yyvs65 := yyspecial_routines65.make (yyvsc65)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs65")
			end
			yyvsc65 := yyvsc65 + yyInitial_yyvs_size
			yyvs65 := yyspecial_routines65.resize (yyvs65, yyvsc65)
		end
	end
	yyvs65.put (yyval65, yyvsp65)
end
		end

	yy_do_action_307 is
			--|#line 2061 "et_eiffel_parser.y"
		local
			yyval65: ET_EXTERNAL_ALIAS
		do
--|#line 2061 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2061")
end

yyval65 := ast_factory.new_external_alias (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp65 := yyvsp65 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp65 >= yyvsc65 then
		if yyvs65 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs65")
			end
			create yyspecial_routines65
			yyvsc65 := yyInitial_yyvs_size
			yyvs65 := yyspecial_routines65.make (yyvsc65)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs65")
			end
			yyvsc65 := yyvsc65 + yyInitial_yyvs_size
			yyvs65 := yyspecial_routines65.resize (yyvs65, yyvsc65)
		end
	end
	yyvs65.put (yyval65, yyvsp65)
end
		end

	yy_do_action_308 is
			--|#line 2065 "et_eiffel_parser.y"
		local
			yyval33: ET_ASSIGNER
		do
--|#line 2065 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2065")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp33 := yyvsp33 + 1
	if yyvsp33 >= yyvsc33 then
		if yyvs33 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs33")
			end
			create yyspecial_routines33
			yyvsc33 := yyInitial_yyvs_size
			yyvs33 := yyspecial_routines33.make (yyvsc33)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs33")
			end
			yyvsc33 := yyvsc33 + yyInitial_yyvs_size
			yyvs33 := yyspecial_routines33.resize (yyvs33, yyvsc33)
		end
	end
	yyvs33.put (yyval33, yyvsp33)
end
		end

	yy_do_action_309 is
			--|#line 2067 "et_eiffel_parser.y"
		local
			yyval33: ET_ASSIGNER
		do
--|#line 2067 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2067")
end

yyval33 := ast_factory.new_assigner (yyvs2.item (yyvsp2), yyvs69.item (yyvsp69)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp33 := yyvsp33 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp69 := yyvsp69 -1
	if yyvsp33 >= yyvsc33 then
		if yyvs33 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs33")
			end
			create yyspecial_routines33
			yyvsc33 := yyInitial_yyvs_size
			yyvs33 := yyspecial_routines33.make (yyvsc33)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs33")
			end
			yyvsc33 := yyvsc33 + yyInitial_yyvs_size
			yyvs33 := yyspecial_routines33.resize (yyvs33, yyvsc33)
		end
	end
	yyvs33.put (yyval33, yyvsp33)
end
		end

	yy_do_action_310 is
			--|#line 2073 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2073 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2073")
end

yyval69 := yyvs13.item (yyvsp13) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp69 := yyvsp69 + 1
	yyvsp13 := yyvsp13 -1
	if yyvsp69 >= yyvsc69 then
		if yyvs69 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs69")
			end
			create yyspecial_routines69
			yyvsc69 := yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.make (yyvsc69)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs69")
			end
			yyvsc69 := yyvsc69 + yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.resize (yyvs69, yyvsc69)
		end
	end
	yyvs69.put (yyval69, yyvsp69)
end
		end

	yy_do_action_311 is
			--|#line 2075 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2075 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2075")
end

yyval69 := ast_factory.new_prefix_not_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp69 := yyvsp69 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp69 >= yyvsc69 then
		if yyvs69 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs69")
			end
			create yyspecial_routines69
			yyvsc69 := yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.make (yyvsc69)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs69")
			end
			yyvsc69 := yyvsc69 + yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.resize (yyvs69, yyvsc69)
		end
	end
	yyvs69.put (yyval69, yyvsp69)
end
		end

	yy_do_action_312 is
			--|#line 2077 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2077 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2077")
end

yyval69 := ast_factory.new_prefix_plus_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp69 := yyvsp69 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp69 >= yyvsc69 then
		if yyvs69 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs69")
			end
			create yyspecial_routines69
			yyvsc69 := yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.make (yyvsc69)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs69")
			end
			yyvsc69 := yyvsc69 + yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.resize (yyvs69, yyvsc69)
		end
	end
	yyvs69.put (yyval69, yyvsp69)
end
		end

	yy_do_action_313 is
			--|#line 2079 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2079 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2079")
end

yyval69 := ast_factory.new_prefix_minus_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp69 := yyvsp69 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp69 >= yyvsc69 then
		if yyvs69 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs69")
			end
			create yyspecial_routines69
			yyvsc69 := yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.make (yyvsc69)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs69")
			end
			yyvsc69 := yyvsc69 + yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.resize (yyvs69, yyvsc69)
		end
	end
	yyvs69.put (yyval69, yyvsp69)
end
		end

	yy_do_action_314 is
			--|#line 2081 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2081 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2081")
end

yyval69 := ast_factory.new_prefix_free_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp69 := yyvsp69 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp69 >= yyvsc69 then
		if yyvs69 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs69")
			end
			create yyspecial_routines69
			yyvsc69 := yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.make (yyvsc69)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs69")
			end
			yyvsc69 := yyvsc69 + yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.resize (yyvs69, yyvsc69)
		end
	end
	yyvs69.put (yyval69, yyvsp69)
end
		end

	yy_do_action_315 is
			--|#line 2083 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2083 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2083")
end

yyval69 := ast_factory.new_infix_plus_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp69 := yyvsp69 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp69 >= yyvsc69 then
		if yyvs69 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs69")
			end
			create yyspecial_routines69
			yyvsc69 := yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.make (yyvsc69)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs69")
			end
			yyvsc69 := yyvsc69 + yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.resize (yyvs69, yyvsc69)
		end
	end
	yyvs69.put (yyval69, yyvsp69)
end
		end

	yy_do_action_316 is
			--|#line 2085 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2085 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2085")
end

yyval69 := ast_factory.new_infix_minus_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp69 := yyvsp69 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp69 >= yyvsc69 then
		if yyvs69 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs69")
			end
			create yyspecial_routines69
			yyvsc69 := yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.make (yyvsc69)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs69")
			end
			yyvsc69 := yyvsc69 + yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.resize (yyvs69, yyvsc69)
		end
	end
	yyvs69.put (yyval69, yyvsp69)
end
		end

	yy_do_action_317 is
			--|#line 2087 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2087 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2087")
end

yyval69 := ast_factory.new_infix_times_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp69 := yyvsp69 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp69 >= yyvsc69 then
		if yyvs69 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs69")
			end
			create yyspecial_routines69
			yyvsc69 := yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.make (yyvsc69)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs69")
			end
			yyvsc69 := yyvsc69 + yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.resize (yyvs69, yyvsc69)
		end
	end
	yyvs69.put (yyval69, yyvsp69)
end
		end

	yy_do_action_318 is
			--|#line 2089 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2089 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2089")
end

yyval69 := ast_factory.new_infix_divide_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp69 := yyvsp69 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp69 >= yyvsc69 then
		if yyvs69 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs69")
			end
			create yyspecial_routines69
			yyvsc69 := yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.make (yyvsc69)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs69")
			end
			yyvsc69 := yyvsc69 + yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.resize (yyvs69, yyvsc69)
		end
	end
	yyvs69.put (yyval69, yyvsp69)
end
		end

	yy_do_action_319 is
			--|#line 2091 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2091 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2091")
end

yyval69 := ast_factory.new_infix_div_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp69 := yyvsp69 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp69 >= yyvsc69 then
		if yyvs69 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs69")
			end
			create yyspecial_routines69
			yyvsc69 := yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.make (yyvsc69)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs69")
			end
			yyvsc69 := yyvsc69 + yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.resize (yyvs69, yyvsc69)
		end
	end
	yyvs69.put (yyval69, yyvsp69)
end
		end

	yy_do_action_320 is
			--|#line 2093 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2093 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2093")
end

yyval69 := ast_factory.new_infix_mod_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp69 := yyvsp69 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp69 >= yyvsc69 then
		if yyvs69 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs69")
			end
			create yyspecial_routines69
			yyvsc69 := yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.make (yyvsc69)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs69")
			end
			yyvsc69 := yyvsc69 + yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.resize (yyvs69, yyvsc69)
		end
	end
	yyvs69.put (yyval69, yyvsp69)
end
		end

	yy_do_action_321 is
			--|#line 2095 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2095 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2095")
end

yyval69 := ast_factory.new_infix_power_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp69 := yyvsp69 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp69 >= yyvsc69 then
		if yyvs69 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs69")
			end
			create yyspecial_routines69
			yyvsc69 := yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.make (yyvsc69)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs69")
			end
			yyvsc69 := yyvsc69 + yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.resize (yyvs69, yyvsc69)
		end
	end
	yyvs69.put (yyval69, yyvsp69)
end
		end

	yy_do_action_322 is
			--|#line 2097 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2097 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2097")
end

yyval69 := ast_factory.new_infix_lt_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp69 := yyvsp69 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp69 >= yyvsc69 then
		if yyvs69 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs69")
			end
			create yyspecial_routines69
			yyvsc69 := yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.make (yyvsc69)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs69")
			end
			yyvsc69 := yyvsc69 + yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.resize (yyvs69, yyvsc69)
		end
	end
	yyvs69.put (yyval69, yyvsp69)
end
		end

	yy_do_action_323 is
			--|#line 2099 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2099 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2099")
end

yyval69 := ast_factory.new_infix_le_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp69 := yyvsp69 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp69 >= yyvsc69 then
		if yyvs69 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs69")
			end
			create yyspecial_routines69
			yyvsc69 := yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.make (yyvsc69)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs69")
			end
			yyvsc69 := yyvsc69 + yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.resize (yyvs69, yyvsc69)
		end
	end
	yyvs69.put (yyval69, yyvsp69)
end
		end

	yy_do_action_324 is
			--|#line 2101 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2101 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2101")
end

yyval69 := ast_factory.new_infix_gt_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp69 := yyvsp69 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp69 >= yyvsc69 then
		if yyvs69 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs69")
			end
			create yyspecial_routines69
			yyvsc69 := yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.make (yyvsc69)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs69")
			end
			yyvsc69 := yyvsc69 + yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.resize (yyvs69, yyvsc69)
		end
	end
	yyvs69.put (yyval69, yyvsp69)
end
		end

	yy_do_action_325 is
			--|#line 2103 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2103 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2103")
end

yyval69 := ast_factory.new_infix_ge_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp69 := yyvsp69 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp69 >= yyvsc69 then
		if yyvs69 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs69")
			end
			create yyspecial_routines69
			yyvsc69 := yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.make (yyvsc69)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs69")
			end
			yyvsc69 := yyvsc69 + yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.resize (yyvs69, yyvsc69)
		end
	end
	yyvs69.put (yyval69, yyvsp69)
end
		end

	yy_do_action_326 is
			--|#line 2105 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2105 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2105")
end

yyval69 := ast_factory.new_infix_and_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp69 := yyvsp69 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp69 >= yyvsc69 then
		if yyvs69 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs69")
			end
			create yyspecial_routines69
			yyvsc69 := yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.make (yyvsc69)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs69")
			end
			yyvsc69 := yyvsc69 + yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.resize (yyvs69, yyvsc69)
		end
	end
	yyvs69.put (yyval69, yyvsp69)
end
		end

	yy_do_action_327 is
			--|#line 2107 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2107 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2107")
end

yyval69 := ast_factory.new_infix_and_then_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp69 := yyvsp69 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp69 >= yyvsc69 then
		if yyvs69 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs69")
			end
			create yyspecial_routines69
			yyvsc69 := yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.make (yyvsc69)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs69")
			end
			yyvsc69 := yyvsc69 + yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.resize (yyvs69, yyvsc69)
		end
	end
	yyvs69.put (yyval69, yyvsp69)
end
		end

	yy_do_action_328 is
			--|#line 2109 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2109 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2109")
end

yyval69 := ast_factory.new_infix_or_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp69 := yyvsp69 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp69 >= yyvsc69 then
		if yyvs69 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs69")
			end
			create yyspecial_routines69
			yyvsc69 := yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.make (yyvsc69)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs69")
			end
			yyvsc69 := yyvsc69 + yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.resize (yyvs69, yyvsc69)
		end
	end
	yyvs69.put (yyval69, yyvsp69)
end
		end

	yy_do_action_329 is
			--|#line 2111 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2111 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2111")
end

yyval69 := ast_factory.new_infix_or_else_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp69 := yyvsp69 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp69 >= yyvsc69 then
		if yyvs69 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs69")
			end
			create yyspecial_routines69
			yyvsc69 := yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.make (yyvsc69)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs69")
			end
			yyvsc69 := yyvsc69 + yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.resize (yyvs69, yyvsc69)
		end
	end
	yyvs69.put (yyval69, yyvsp69)
end
		end

	yy_do_action_330 is
			--|#line 2113 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2113 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2113")
end

yyval69 := ast_factory.new_infix_implies_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp69 := yyvsp69 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp69 >= yyvsc69 then
		if yyvs69 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs69")
			end
			create yyspecial_routines69
			yyvsc69 := yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.make (yyvsc69)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs69")
			end
			yyvsc69 := yyvsc69 + yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.resize (yyvs69, yyvsc69)
		end
	end
	yyvs69.put (yyval69, yyvsp69)
end
		end

	yy_do_action_331 is
			--|#line 2115 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2115 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2115")
end

yyval69 := ast_factory.new_infix_xor_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp69 := yyvsp69 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp69 >= yyvsc69 then
		if yyvs69 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs69")
			end
			create yyspecial_routines69
			yyvsc69 := yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.make (yyvsc69)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs69")
			end
			yyvsc69 := yyvsc69 + yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.resize (yyvs69, yyvsc69)
		end
	end
	yyvs69.put (yyval69, yyvsp69)
end
		end

	yy_do_action_332 is
			--|#line 2117 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2117 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2117")
end

yyval69 := ast_factory.new_infix_free_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp69 := yyvsp69 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp69 >= yyvsc69 then
		if yyvs69 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs69")
			end
			create yyspecial_routines69
			yyvsc69 := yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.make (yyvsc69)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs69")
			end
			yyvsc69 := yyvsc69 + yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.resize (yyvs69, yyvsc69)
		end
	end
	yyvs69.put (yyval69, yyvsp69)
end
		end

	yy_do_action_333 is
			--|#line 2120 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2120 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2120")
end

yyval69 := new_invalid_prefix_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp69 := yyvsp69 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp69 >= yyvsc69 then
		if yyvs69 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs69")
			end
			create yyspecial_routines69
			yyvsc69 := yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.make (yyvsc69)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs69")
			end
			yyvsc69 := yyvsc69 + yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.resize (yyvs69, yyvsc69)
		end
	end
	yyvs69.put (yyval69, yyvsp69)
end
		end

	yy_do_action_334 is
			--|#line 2122 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2122 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2122")
end

yyval69 := new_invalid_prefix_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp69 := yyvsp69 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp69 >= yyvsc69 then
		if yyvs69 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs69")
			end
			create yyspecial_routines69
			yyvsc69 := yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.make (yyvsc69)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs69")
			end
			yyvsc69 := yyvsc69 + yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.resize (yyvs69, yyvsc69)
		end
	end
	yyvs69.put (yyval69, yyvsp69)
end
		end

	yy_do_action_335 is
			--|#line 2124 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2124 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2124")
end

yyval69 := new_invalid_prefix_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp69 := yyvsp69 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp69 >= yyvsc69 then
		if yyvs69 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs69")
			end
			create yyspecial_routines69
			yyvsc69 := yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.make (yyvsc69)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs69")
			end
			yyvsc69 := yyvsc69 + yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.resize (yyvs69, yyvsc69)
		end
	end
	yyvs69.put (yyval69, yyvsp69)
end
		end

	yy_do_action_336 is
			--|#line 2126 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2126 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2126")
end

yyval69 := new_invalid_prefix_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp69 := yyvsp69 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp69 >= yyvsc69 then
		if yyvs69 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs69")
			end
			create yyspecial_routines69
			yyvsc69 := yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.make (yyvsc69)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs69")
			end
			yyvsc69 := yyvsc69 + yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.resize (yyvs69, yyvsc69)
		end
	end
	yyvs69.put (yyval69, yyvsp69)
end
		end

	yy_do_action_337 is
			--|#line 2128 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2128 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2128")
end

yyval69 := new_invalid_prefix_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp69 := yyvsp69 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp69 >= yyvsc69 then
		if yyvs69 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs69")
			end
			create yyspecial_routines69
			yyvsc69 := yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.make (yyvsc69)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs69")
			end
			yyvsc69 := yyvsc69 + yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.resize (yyvs69, yyvsc69)
		end
	end
	yyvs69.put (yyval69, yyvsp69)
end
		end

	yy_do_action_338 is
			--|#line 2130 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2130 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2130")
end

yyval69 := new_invalid_prefix_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp69 := yyvsp69 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp69 >= yyvsc69 then
		if yyvs69 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs69")
			end
			create yyspecial_routines69
			yyvsc69 := yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.make (yyvsc69)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs69")
			end
			yyvsc69 := yyvsc69 + yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.resize (yyvs69, yyvsc69)
		end
	end
	yyvs69.put (yyval69, yyvsp69)
end
		end

	yy_do_action_339 is
			--|#line 2132 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2132 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2132")
end

yyval69 := new_invalid_prefix_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp69 := yyvsp69 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp69 >= yyvsc69 then
		if yyvs69 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs69")
			end
			create yyspecial_routines69
			yyvsc69 := yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.make (yyvsc69)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs69")
			end
			yyvsc69 := yyvsc69 + yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.resize (yyvs69, yyvsc69)
		end
	end
	yyvs69.put (yyval69, yyvsp69)
end
		end

	yy_do_action_340 is
			--|#line 2134 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2134 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2134")
end

yyval69 := new_invalid_prefix_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp69 := yyvsp69 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp69 >= yyvsc69 then
		if yyvs69 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs69")
			end
			create yyspecial_routines69
			yyvsc69 := yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.make (yyvsc69)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs69")
			end
			yyvsc69 := yyvsc69 + yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.resize (yyvs69, yyvsc69)
		end
	end
	yyvs69.put (yyval69, yyvsp69)
end
		end

	yy_do_action_341 is
			--|#line 2136 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2136 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2136")
end

yyval69 := new_invalid_prefix_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp69 := yyvsp69 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp69 >= yyvsc69 then
		if yyvs69 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs69")
			end
			create yyspecial_routines69
			yyvsc69 := yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.make (yyvsc69)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs69")
			end
			yyvsc69 := yyvsc69 + yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.resize (yyvs69, yyvsc69)
		end
	end
	yyvs69.put (yyval69, yyvsp69)
end
		end

	yy_do_action_342 is
			--|#line 2138 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2138 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2138")
end

yyval69 := new_invalid_prefix_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp69 := yyvsp69 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp69 >= yyvsc69 then
		if yyvs69 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs69")
			end
			create yyspecial_routines69
			yyvsc69 := yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.make (yyvsc69)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs69")
			end
			yyvsc69 := yyvsc69 + yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.resize (yyvs69, yyvsc69)
		end
	end
	yyvs69.put (yyval69, yyvsp69)
end
		end

	yy_do_action_343 is
			--|#line 2140 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2140 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2140")
end

yyval69 := new_invalid_prefix_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp69 := yyvsp69 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp69 >= yyvsc69 then
		if yyvs69 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs69")
			end
			create yyspecial_routines69
			yyvsc69 := yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.make (yyvsc69)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs69")
			end
			yyvsc69 := yyvsc69 + yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.resize (yyvs69, yyvsc69)
		end
	end
	yyvs69.put (yyval69, yyvsp69)
end
		end

	yy_do_action_344 is
			--|#line 2142 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2142 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2142")
end

yyval69 := new_invalid_prefix_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp69 := yyvsp69 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp69 >= yyvsc69 then
		if yyvs69 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs69")
			end
			create yyspecial_routines69
			yyvsc69 := yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.make (yyvsc69)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs69")
			end
			yyvsc69 := yyvsc69 + yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.resize (yyvs69, yyvsc69)
		end
	end
	yyvs69.put (yyval69, yyvsp69)
end
		end

	yy_do_action_345 is
			--|#line 2144 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2144 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2144")
end

yyval69 := new_invalid_prefix_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp69 := yyvsp69 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp69 >= yyvsc69 then
		if yyvs69 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs69")
			end
			create yyspecial_routines69
			yyvsc69 := yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.make (yyvsc69)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs69")
			end
			yyvsc69 := yyvsc69 + yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.resize (yyvs69, yyvsc69)
		end
	end
	yyvs69.put (yyval69, yyvsp69)
end
		end

	yy_do_action_346 is
			--|#line 2146 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2146 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2146")
end

yyval69 := new_invalid_prefix_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp69 := yyvsp69 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp69 >= yyvsc69 then
		if yyvs69 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs69")
			end
			create yyspecial_routines69
			yyvsc69 := yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.make (yyvsc69)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs69")
			end
			yyvsc69 := yyvsc69 + yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.resize (yyvs69, yyvsc69)
		end
	end
	yyvs69.put (yyval69, yyvsp69)
end
		end

	yy_do_action_347 is
			--|#line 2148 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2148 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2148")
end

yyval69 := new_invalid_prefix_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp69 := yyvsp69 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp69 >= yyvsc69 then
		if yyvs69 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs69")
			end
			create yyspecial_routines69
			yyvsc69 := yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.make (yyvsc69)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs69")
			end
			yyvsc69 := yyvsc69 + yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.resize (yyvs69, yyvsc69)
		end
	end
	yyvs69.put (yyval69, yyvsp69)
end
		end

	yy_do_action_348 is
			--|#line 2150 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2150 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2150")
end

yyval69 := new_invalid_prefix_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp69 := yyvsp69 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp69 >= yyvsc69 then
		if yyvs69 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs69")
			end
			create yyspecial_routines69
			yyvsc69 := yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.make (yyvsc69)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs69")
			end
			yyvsc69 := yyvsc69 + yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.resize (yyvs69, yyvsc69)
		end
	end
	yyvs69.put (yyval69, yyvsp69)
end
		end

	yy_do_action_349 is
			--|#line 2152 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2152 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2152")
end

yyval69 := new_invalid_infix_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp69 := yyvsp69 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp69 >= yyvsc69 then
		if yyvs69 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs69")
			end
			create yyspecial_routines69
			yyvsc69 := yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.make (yyvsc69)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs69")
			end
			yyvsc69 := yyvsc69 + yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.resize (yyvs69, yyvsc69)
		end
	end
	yyvs69.put (yyval69, yyvsp69)
end
		end

	yy_do_action_350 is
			--|#line 2154 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2154 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2154")
end

yyval69 := new_invalid_infix_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp69 := yyvsp69 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp69 >= yyvsc69 then
		if yyvs69 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs69")
			end
			create yyspecial_routines69
			yyvsc69 := yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.make (yyvsc69)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs69")
			end
			yyvsc69 := yyvsc69 + yyInitial_yyvs_size
			yyvs69 := yyspecial_routines69.resize (yyvs69, yyvsc69)
		end
	end
	yyvs69.put (yyval69, yyvsp69)
end
		end

	yy_do_action_351 is
			--|#line 2158 "et_eiffel_parser.y"
		local
			yyval64: ET_EXTENDED_FEATURE_NAME
		do
--|#line 2158 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2158")
end

yyval64 := yyvs69.item (yyvsp69) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp64 := yyvsp64 + 1
	yyvsp69 := yyvsp69 -1
	if yyvsp64 >= yyvsc64 then
		if yyvs64 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs64")
			end
			create yyspecial_routines64
			yyvsc64 := yyInitial_yyvs_size
			yyvs64 := yyspecial_routines64.make (yyvsc64)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs64")
			end
			yyvsc64 := yyvsc64 + yyInitial_yyvs_size
			yyvs64 := yyspecial_routines64.resize (yyvs64, yyvsc64)
		end
	end
	yyvs64.put (yyval64, yyvsp64)
end
		end

	yy_do_action_352 is
			--|#line 2160 "et_eiffel_parser.y"
		local
			yyval64: ET_EXTENDED_FEATURE_NAME
		do
--|#line 2160 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2160")
end

yyval64 := ast_factory.new_aliased_feature_name (yyvs13.item (yyvsp13), yyvs32.item (yyvsp32)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp64 := yyvsp64 + 1
	yyvsp13 := yyvsp13 -1
	yyvsp32 := yyvsp32 -1
	if yyvsp64 >= yyvsc64 then
		if yyvs64 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs64")
			end
			create yyspecial_routines64
			yyvsc64 := yyInitial_yyvs_size
			yyvs64 := yyspecial_routines64.make (yyvsc64)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs64")
			end
			yyvsc64 := yyvsc64 + yyInitial_yyvs_size
			yyvs64 := yyspecial_routines64.resize (yyvs64, yyvsc64)
		end
	end
	yyvs64.put (yyval64, yyvsp64)
end
		end

	yy_do_action_353 is
			--|#line 2164 "et_eiffel_parser.y"
		local
			yyval32: ET_ALIAS_NAME
		do
--|#line 2164 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2164")
end

yyval32 := ast_factory.new_alias_not_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp32 := yyvsp32 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp32 >= yyvsc32 then
		if yyvs32 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs32")
			end
			create yyspecial_routines32
			yyvsc32 := yyInitial_yyvs_size
			yyvs32 := yyspecial_routines32.make (yyvsc32)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs32")
			end
			yyvsc32 := yyvsc32 + yyInitial_yyvs_size
			yyvs32 := yyspecial_routines32.resize (yyvs32, yyvsc32)
		end
	end
	yyvs32.put (yyval32, yyvsp32)
end
		end

	yy_do_action_354 is
			--|#line 2166 "et_eiffel_parser.y"
		local
			yyval32: ET_ALIAS_NAME
		do
--|#line 2166 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2166")
end

yyval32 := ast_factory.new_alias_plus_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp32 := yyvsp32 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp32 >= yyvsc32 then
		if yyvs32 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs32")
			end
			create yyspecial_routines32
			yyvsc32 := yyInitial_yyvs_size
			yyvs32 := yyspecial_routines32.make (yyvsc32)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs32")
			end
			yyvsc32 := yyvsc32 + yyInitial_yyvs_size
			yyvs32 := yyspecial_routines32.resize (yyvs32, yyvsc32)
		end
	end
	yyvs32.put (yyval32, yyvsp32)
end
		end

	yy_do_action_355 is
			--|#line 2168 "et_eiffel_parser.y"
		local
			yyval32: ET_ALIAS_NAME
		do
--|#line 2168 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2168")
end

yyval32 := ast_factory.new_alias_minus_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp32 := yyvsp32 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp32 >= yyvsc32 then
		if yyvs32 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs32")
			end
			create yyspecial_routines32
			yyvsc32 := yyInitial_yyvs_size
			yyvs32 := yyspecial_routines32.make (yyvsc32)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs32")
			end
			yyvsc32 := yyvsc32 + yyInitial_yyvs_size
			yyvs32 := yyspecial_routines32.resize (yyvs32, yyvsc32)
		end
	end
	yyvs32.put (yyval32, yyvsp32)
end
		end

	yy_do_action_356 is
			--|#line 2170 "et_eiffel_parser.y"
		local
			yyval32: ET_ALIAS_NAME
		do
--|#line 2170 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2170")
end

yyval32 := ast_factory.new_alias_times_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp32 := yyvsp32 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp32 >= yyvsc32 then
		if yyvs32 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs32")
			end
			create yyspecial_routines32
			yyvsc32 := yyInitial_yyvs_size
			yyvs32 := yyspecial_routines32.make (yyvsc32)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs32")
			end
			yyvsc32 := yyvsc32 + yyInitial_yyvs_size
			yyvs32 := yyspecial_routines32.resize (yyvs32, yyvsc32)
		end
	end
	yyvs32.put (yyval32, yyvsp32)
end
		end

	yy_do_action_357 is
			--|#line 2172 "et_eiffel_parser.y"
		local
			yyval32: ET_ALIAS_NAME
		do
--|#line 2172 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2172")
end

yyval32 := ast_factory.new_alias_divide_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp32 := yyvsp32 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp32 >= yyvsc32 then
		if yyvs32 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs32")
			end
			create yyspecial_routines32
			yyvsc32 := yyInitial_yyvs_size
			yyvs32 := yyspecial_routines32.make (yyvsc32)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs32")
			end
			yyvsc32 := yyvsc32 + yyInitial_yyvs_size
			yyvs32 := yyspecial_routines32.resize (yyvs32, yyvsc32)
		end
	end
	yyvs32.put (yyval32, yyvsp32)
end
		end

	yy_do_action_358 is
			--|#line 2174 "et_eiffel_parser.y"
		local
			yyval32: ET_ALIAS_NAME
		do
--|#line 2174 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2174")
end

yyval32 := ast_factory.new_alias_div_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp32 := yyvsp32 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp32 >= yyvsc32 then
		if yyvs32 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs32")
			end
			create yyspecial_routines32
			yyvsc32 := yyInitial_yyvs_size
			yyvs32 := yyspecial_routines32.make (yyvsc32)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs32")
			end
			yyvsc32 := yyvsc32 + yyInitial_yyvs_size
			yyvs32 := yyspecial_routines32.resize (yyvs32, yyvsc32)
		end
	end
	yyvs32.put (yyval32, yyvsp32)
end
		end

	yy_do_action_359 is
			--|#line 2176 "et_eiffel_parser.y"
		local
			yyval32: ET_ALIAS_NAME
		do
--|#line 2176 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2176")
end

yyval32 := ast_factory.new_alias_mod_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp32 := yyvsp32 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp32 >= yyvsc32 then
		if yyvs32 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs32")
			end
			create yyspecial_routines32
			yyvsc32 := yyInitial_yyvs_size
			yyvs32 := yyspecial_routines32.make (yyvsc32)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs32")
			end
			yyvsc32 := yyvsc32 + yyInitial_yyvs_size
			yyvs32 := yyspecial_routines32.resize (yyvs32, yyvsc32)
		end
	end
	yyvs32.put (yyval32, yyvsp32)
end
		end

	yy_do_action_360 is
			--|#line 2178 "et_eiffel_parser.y"
		local
			yyval32: ET_ALIAS_NAME
		do
--|#line 2178 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2178")
end

yyval32 := ast_factory.new_alias_power_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp32 := yyvsp32 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp32 >= yyvsc32 then
		if yyvs32 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs32")
			end
			create yyspecial_routines32
			yyvsc32 := yyInitial_yyvs_size
			yyvs32 := yyspecial_routines32.make (yyvsc32)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs32")
			end
			yyvsc32 := yyvsc32 + yyInitial_yyvs_size
			yyvs32 := yyspecial_routines32.resize (yyvs32, yyvsc32)
		end
	end
	yyvs32.put (yyval32, yyvsp32)
end
		end

	yy_do_action_361 is
			--|#line 2180 "et_eiffel_parser.y"
		local
			yyval32: ET_ALIAS_NAME
		do
--|#line 2180 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2180")
end

yyval32 := ast_factory.new_alias_lt_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp32 := yyvsp32 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp32 >= yyvsc32 then
		if yyvs32 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs32")
			end
			create yyspecial_routines32
			yyvsc32 := yyInitial_yyvs_size
			yyvs32 := yyspecial_routines32.make (yyvsc32)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs32")
			end
			yyvsc32 := yyvsc32 + yyInitial_yyvs_size
			yyvs32 := yyspecial_routines32.resize (yyvs32, yyvsc32)
		end
	end
	yyvs32.put (yyval32, yyvsp32)
end
		end

	yy_do_action_362 is
			--|#line 2182 "et_eiffel_parser.y"
		local
			yyval32: ET_ALIAS_NAME
		do
--|#line 2182 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2182")
end

yyval32 := ast_factory.new_alias_le_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp32 := yyvsp32 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp32 >= yyvsc32 then
		if yyvs32 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs32")
			end
			create yyspecial_routines32
			yyvsc32 := yyInitial_yyvs_size
			yyvs32 := yyspecial_routines32.make (yyvsc32)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs32")
			end
			yyvsc32 := yyvsc32 + yyInitial_yyvs_size
			yyvs32 := yyspecial_routines32.resize (yyvs32, yyvsc32)
		end
	end
	yyvs32.put (yyval32, yyvsp32)
end
		end

	yy_do_action_363 is
			--|#line 2184 "et_eiffel_parser.y"
		local
			yyval32: ET_ALIAS_NAME
		do
--|#line 2184 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2184")
end

yyval32 := ast_factory.new_alias_gt_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp32 := yyvsp32 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp32 >= yyvsc32 then
		if yyvs32 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs32")
			end
			create yyspecial_routines32
			yyvsc32 := yyInitial_yyvs_size
			yyvs32 := yyspecial_routines32.make (yyvsc32)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs32")
			end
			yyvsc32 := yyvsc32 + yyInitial_yyvs_size
			yyvs32 := yyspecial_routines32.resize (yyvs32, yyvsc32)
		end
	end
	yyvs32.put (yyval32, yyvsp32)
end
		end

	yy_do_action_364 is
			--|#line 2186 "et_eiffel_parser.y"
		local
			yyval32: ET_ALIAS_NAME
		do
--|#line 2186 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2186")
end

yyval32 := ast_factory.new_alias_ge_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp32 := yyvsp32 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp32 >= yyvsc32 then
		if yyvs32 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs32")
			end
			create yyspecial_routines32
			yyvsc32 := yyInitial_yyvs_size
			yyvs32 := yyspecial_routines32.make (yyvsc32)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs32")
			end
			yyvsc32 := yyvsc32 + yyInitial_yyvs_size
			yyvs32 := yyspecial_routines32.resize (yyvs32, yyvsc32)
		end
	end
	yyvs32.put (yyval32, yyvsp32)
end
		end

	yy_do_action_365 is
			--|#line 2188 "et_eiffel_parser.y"
		local
			yyval32: ET_ALIAS_NAME
		do
--|#line 2188 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2188")
end

yyval32 := ast_factory.new_alias_and_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp32 := yyvsp32 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp32 >= yyvsc32 then
		if yyvs32 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs32")
			end
			create yyspecial_routines32
			yyvsc32 := yyInitial_yyvs_size
			yyvs32 := yyspecial_routines32.make (yyvsc32)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs32")
			end
			yyvsc32 := yyvsc32 + yyInitial_yyvs_size
			yyvs32 := yyspecial_routines32.resize (yyvs32, yyvsc32)
		end
	end
	yyvs32.put (yyval32, yyvsp32)
end
		end

	yy_do_action_366 is
			--|#line 2190 "et_eiffel_parser.y"
		local
			yyval32: ET_ALIAS_NAME
		do
--|#line 2190 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2190")
end

yyval32 := ast_factory.new_alias_and_then_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp32 := yyvsp32 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp32 >= yyvsc32 then
		if yyvs32 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs32")
			end
			create yyspecial_routines32
			yyvsc32 := yyInitial_yyvs_size
			yyvs32 := yyspecial_routines32.make (yyvsc32)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs32")
			end
			yyvsc32 := yyvsc32 + yyInitial_yyvs_size
			yyvs32 := yyspecial_routines32.resize (yyvs32, yyvsc32)
		end
	end
	yyvs32.put (yyval32, yyvsp32)
end
		end

	yy_do_action_367 is
			--|#line 2192 "et_eiffel_parser.y"
		local
			yyval32: ET_ALIAS_NAME
		do
--|#line 2192 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2192")
end

yyval32 := ast_factory.new_alias_or_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp32 := yyvsp32 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp32 >= yyvsc32 then
		if yyvs32 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs32")
			end
			create yyspecial_routines32
			yyvsc32 := yyInitial_yyvs_size
			yyvs32 := yyspecial_routines32.make (yyvsc32)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs32")
			end
			yyvsc32 := yyvsc32 + yyInitial_yyvs_size
			yyvs32 := yyspecial_routines32.resize (yyvs32, yyvsc32)
		end
	end
	yyvs32.put (yyval32, yyvsp32)
end
		end

	yy_do_action_368 is
			--|#line 2194 "et_eiffel_parser.y"
		local
			yyval32: ET_ALIAS_NAME
		do
--|#line 2194 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2194")
end

yyval32 := ast_factory.new_alias_or_else_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp32 := yyvsp32 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp32 >= yyvsc32 then
		if yyvs32 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs32")
			end
			create yyspecial_routines32
			yyvsc32 := yyInitial_yyvs_size
			yyvs32 := yyspecial_routines32.make (yyvsc32)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs32")
			end
			yyvsc32 := yyvsc32 + yyInitial_yyvs_size
			yyvs32 := yyspecial_routines32.resize (yyvs32, yyvsc32)
		end
	end
	yyvs32.put (yyval32, yyvsp32)
end
		end

	yy_do_action_369 is
			--|#line 2196 "et_eiffel_parser.y"
		local
			yyval32: ET_ALIAS_NAME
		do
--|#line 2196 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2196")
end

yyval32 := ast_factory.new_alias_implies_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp32 := yyvsp32 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp32 >= yyvsc32 then
		if yyvs32 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs32")
			end
			create yyspecial_routines32
			yyvsc32 := yyInitial_yyvs_size
			yyvs32 := yyspecial_routines32.make (yyvsc32)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs32")
			end
			yyvsc32 := yyvsc32 + yyInitial_yyvs_size
			yyvs32 := yyspecial_routines32.resize (yyvs32, yyvsc32)
		end
	end
	yyvs32.put (yyval32, yyvsp32)
end
		end

	yy_do_action_370 is
			--|#line 2198 "et_eiffel_parser.y"
		local
			yyval32: ET_ALIAS_NAME
		do
--|#line 2198 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2198")
end

yyval32 := ast_factory.new_alias_xor_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp32 := yyvsp32 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp32 >= yyvsc32 then
		if yyvs32 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs32")
			end
			create yyspecial_routines32
			yyvsc32 := yyInitial_yyvs_size
			yyvs32 := yyspecial_routines32.make (yyvsc32)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs32")
			end
			yyvsc32 := yyvsc32 + yyInitial_yyvs_size
			yyvs32 := yyspecial_routines32.resize (yyvs32, yyvsc32)
		end
	end
	yyvs32.put (yyval32, yyvsp32)
end
		end

	yy_do_action_371 is
			--|#line 2200 "et_eiffel_parser.y"
		local
			yyval32: ET_ALIAS_NAME
		do
--|#line 2200 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2200")
end

yyval32 := ast_factory.new_alias_dotdot_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp32 := yyvsp32 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp32 >= yyvsc32 then
		if yyvs32 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs32")
			end
			create yyspecial_routines32
			yyvsc32 := yyInitial_yyvs_size
			yyvs32 := yyspecial_routines32.make (yyvsc32)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs32")
			end
			yyvsc32 := yyvsc32 + yyInitial_yyvs_size
			yyvs32 := yyspecial_routines32.resize (yyvs32, yyvsc32)
		end
	end
	yyvs32.put (yyval32, yyvsp32)
end
		end

	yy_do_action_372 is
			--|#line 2202 "et_eiffel_parser.y"
		local
			yyval32: ET_ALIAS_NAME
		do
--|#line 2202 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2202")
end

yyval32 := ast_factory.new_alias_free_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp32 := yyvsp32 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp32 >= yyvsc32 then
		if yyvs32 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs32")
			end
			create yyspecial_routines32
			yyvsc32 := yyInitial_yyvs_size
			yyvs32 := yyspecial_routines32.make (yyvsc32)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs32")
			end
			yyvsc32 := yyvsc32 + yyInitial_yyvs_size
			yyvs32 := yyspecial_routines32.resize (yyvs32, yyvsc32)
		end
	end
	yyvs32.put (yyval32, yyvsp32)
end
		end

	yy_do_action_373 is
			--|#line 2204 "et_eiffel_parser.y"
		local
			yyval32: ET_ALIAS_NAME
		do
--|#line 2204 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2204")
end

yyval32 := ast_factory.new_alias_bracket_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp32 := yyvsp32 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp32 >= yyvsc32 then
		if yyvs32 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs32")
			end
			create yyspecial_routines32
			yyvsc32 := yyInitial_yyvs_size
			yyvs32 := yyspecial_routines32.make (yyvsc32)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs32")
			end
			yyvsc32 := yyvsc32 + yyInitial_yyvs_size
			yyvs32 := yyspecial_routines32.resize (yyvs32, yyvsc32)
		end
	end
	yyvs32.put (yyval32, yyvsp32)
end
		end

	yy_do_action_374 is
			--|#line 2207 "et_eiffel_parser.y"
		local
			yyval32: ET_ALIAS_NAME
		do
--|#line 2207 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2207")
end

yyval32 := new_invalid_alias_name (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp32 := yyvsp32 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp32 >= yyvsc32 then
		if yyvs32 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs32")
			end
			create yyspecial_routines32
			yyvsc32 := yyInitial_yyvs_size
			yyvs32 := yyspecial_routines32.make (yyvsc32)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs32")
			end
			yyvsc32 := yyvsc32 + yyInitial_yyvs_size
			yyvs32 := yyspecial_routines32.resize (yyvs32, yyvsc32)
		end
	end
	yyvs32.put (yyval32, yyvsp32)
end
		end

	yy_do_action_375 is
			--|#line 2213 "et_eiffel_parser.y"
		local
			yyval73: ET_FORMAL_ARGUMENT_LIST
		do
--|#line 2213 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2213")
end

			yyval73 := yyvs73.item (yyvsp73)
			set_start_closure (yyval73)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs73.put (yyval73, yyvsp73)
end
		end

	yy_do_action_376 is
			--|#line 2220 "et_eiffel_parser.y"
		local
			yyval73: ET_FORMAL_ARGUMENT_LIST
		do
--|#line 2220 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2220")
end

yyval73 := new_formal_arguments (yyvs5.item (yyvsp5 - 1), yyvs5.item (yyvsp5), 0) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp73 := yyvsp73 + 1
	yyvsp5 := yyvsp5 -2
	if yyvsp73 >= yyvsc73 then
		if yyvs73 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs73")
			end
			create yyspecial_routines73
			yyvsc73 := yyInitial_yyvs_size
			yyvs73 := yyspecial_routines73.make (yyvsc73)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs73")
			end
			yyvsc73 := yyvsc73 + yyInitial_yyvs_size
			yyvs73 := yyspecial_routines73.resize (yyvs73, yyvsc73)
		end
	end
	yyvs73.put (yyval73, yyvsp73)
end
		end

	yy_do_action_377 is
			--|#line 2222 "et_eiffel_parser.y"
		local
			yyval73: ET_FORMAL_ARGUMENT_LIST
		do
--|#line 2222 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2222")
end

			yyval73 := yyvs73.item (yyvsp73)
			remove_symbol
			remove_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp5 := yyvsp5 -1
	yyvs73.put (yyval73, yyvsp73)
end
		end

	yy_do_action_378 is
			--|#line 2230 "et_eiffel_parser.y"
		local
			yyval5: ET_SYMBOL
		do
--|#line 2230 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2230")
end

			-- Needed to solve ambiguity when parsing:
			--   agent (a).f
			--   agent (a: A) do ... end
			yyval5 := yyvs5.item (yyvsp5)
			add_symbol (yyval5)
			add_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs5.put (yyval5, yyvsp5)
end
		end

	yy_do_action_379 is
			--|#line 2241 "et_eiffel_parser.y"
		local
			yyval73: ET_FORMAL_ARGUMENT_LIST
		do
--|#line 2241 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2241")
end

			yyval73 := new_formal_arguments (last_symbol, yyvs5.item (yyvsp5), counter_value)
			if yyval73 /= Void and yyvs72.item (yyvsp72) /= Void then
				yyval73.put_first (yyvs72.item (yyvsp72))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp73 := yyvsp73 + 1
	yyvsp72 := yyvsp72 -1
	yyvsp5 := yyvsp5 -1
	if yyvsp73 >= yyvsc73 then
		if yyvs73 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs73")
			end
			create yyspecial_routines73
			yyvsc73 := yyInitial_yyvs_size
			yyvs73 := yyspecial_routines73.make (yyvsc73)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs73")
			end
			yyvsc73 := yyvsc73 + yyInitial_yyvs_size
			yyvs73 := yyspecial_routines73.resize (yyvs73, yyvsc73)
		end
	end
	yyvs73.put (yyval73, yyvsp73)
end
		end

	yy_do_action_380 is
			--|#line 2248 "et_eiffel_parser.y"
		local
			yyval73: ET_FORMAL_ARGUMENT_LIST
		do
--|#line 2248 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2248")
end

			yyval73 := new_formal_arguments (last_symbol, yyvs5.item (yyvsp5), counter_value)
			if yyval73 /= Void and yyvs72.item (yyvsp72) /= Void then
				yyval73.put_first (yyvs72.item (yyvsp72))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp73 := yyvsp73 + 1
	yyvsp72 := yyvsp72 -1
	yyvsp5 := yyvsp5 -1
	if yyvsp73 >= yyvsc73 then
		if yyvs73 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs73")
			end
			create yyspecial_routines73
			yyvsc73 := yyInitial_yyvs_size
			yyvs73 := yyspecial_routines73.make (yyvsc73)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs73")
			end
			yyvsc73 := yyvsc73 + yyInitial_yyvs_size
			yyvs73 := yyspecial_routines73.resize (yyvs73, yyvsc73)
		end
	end
	yyvs73.put (yyval73, yyvsp73)
end
		end

	yy_do_action_381 is
			--|#line 2255 "et_eiffel_parser.y"
		local
			yyval73: ET_FORMAL_ARGUMENT_LIST
		do
--|#line 2255 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2255")
end

			yyval73 := yyvs73.item (yyvsp73)
			if yyval73 /= Void and yyvs71.item (yyvsp71) /= Void then
				if not yyval73.is_empty then
					yyvs71.item (yyvsp71).set_declared_type (yyval73.first.type)
					yyval73.put_first (yyvs71.item (yyvsp71))
				end
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp71 := yyvsp71 -1
	yyvs73.put (yyval73, yyvsp73)
end
		end

	yy_do_action_382 is
			--|#line 2265 "et_eiffel_parser.y"
		local
			yyval73: ET_FORMAL_ARGUMENT_LIST
		do
--|#line 2265 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2265")
end

			-- TODO: Syntax error
			yyval73 := yyvs73.item (yyvsp73)
			if yyval73 /= Void and yyvs71.item (yyvsp71) /= Void then
				if not yyval73.is_empty then
					yyvs71.item (yyvsp71).set_declared_type (yyval73.first.type)
					yyval73.put_first (yyvs71.item (yyvsp71))
				end
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp71 := yyvsp71 -1
	yyvs73.put (yyval73, yyvsp73)
end
		end

	yy_do_action_383 is
			--|#line 2276 "et_eiffel_parser.y"
		local
			yyval73: ET_FORMAL_ARGUMENT_LIST
		do
--|#line 2276 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2276")
end

			yyval73 := yyvs73.item (yyvsp73)
			if yyval73 /= Void and yyvs72.item (yyvsp72) /= Void then
				yyval73.put_first (yyvs72.item (yyvsp72))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp72 := yyvsp72 -1
	yyvs73.put (yyval73, yyvsp73)
end
		end

	yy_do_action_384 is
			--|#line 2283 "et_eiffel_parser.y"
		local
			yyval73: ET_FORMAL_ARGUMENT_LIST
		do
--|#line 2283 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2283")
end

			yyval73 := yyvs73.item (yyvsp73)
			if yyval73 /= Void and yyvs72.item (yyvsp72) /= Void then
				yyval73.put_first (yyvs72.item (yyvsp72))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp72 := yyvsp72 -1
	yyvs73.put (yyval73, yyvsp73)
end
		end

	yy_do_action_385 is
			--|#line 2292 "et_eiffel_parser.y"
		local
			yyval71: ET_FORMAL_ARGUMENT
		do
--|#line 2292 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2292")
end

			yyval71 := ast_factory.new_formal_comma_argument (ast_factory.new_argument_name_comma (yyvs13.item (yyvsp13), yyvs5.item (yyvsp5)), dummy_type)
			if yyval71 /= Void then
				increment_counter
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp71 := yyvsp71 + 1
	yyvsp13 := yyvsp13 -1
	yyvsp5 := yyvsp5 -1
	if yyvsp71 >= yyvsc71 then
		if yyvs71 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs71")
			end
			create yyspecial_routines71
			yyvsc71 := yyInitial_yyvs_size
			yyvs71 := yyspecial_routines71.make (yyvsc71)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs71")
			end
			yyvsc71 := yyvsc71 + yyInitial_yyvs_size
			yyvs71 := yyspecial_routines71.resize (yyvs71, yyvsc71)
		end
	end
	yyvs71.put (yyval71, yyvsp71)
end
		end

	yy_do_action_386 is
			--|#line 2301 "et_eiffel_parser.y"
		local
			yyval71: ET_FORMAL_ARGUMENT
		do
--|#line 2301 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2301")
end

			yyval71 := ast_factory.new_formal_comma_argument (yyvs13.item (yyvsp13), dummy_type)
			if yyval71 /= Void then
				increment_counter
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp71 := yyvsp71 + 1
	yyvsp13 := yyvsp13 -1
	if yyvsp71 >= yyvsc71 then
		if yyvs71 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs71")
			end
			create yyspecial_routines71
			yyvsc71 := yyInitial_yyvs_size
			yyvs71 := yyspecial_routines71.make (yyvsc71)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs71")
			end
			yyvsc71 := yyvsc71 + yyInitial_yyvs_size
			yyvs71 := yyspecial_routines71.resize (yyvs71, yyvsc71)
		end
	end
	yyvs71.put (yyval71, yyvsp71)
end
		end

	yy_do_action_387 is
			--|#line 2310 "et_eiffel_parser.y"
		local
			yyval72: ET_FORMAL_ARGUMENT_ITEM
		do
--|#line 2310 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2310")
end

			yyval72 := ast_factory.new_formal_argument (yyvs13.item (yyvsp13), ast_factory.new_colon_type (yyvs5.item (yyvsp5), yyvs112.item (yyvsp112)))
			if yyval72 /= Void then
				increment_counter
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp72 := yyvsp72 + 1
	yyvsp13 := yyvsp13 -1
	yyvsp5 := yyvsp5 -1
	yyvsp112 := yyvsp112 -1
	if yyvsp72 >= yyvsc72 then
		if yyvs72 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs72")
			end
			create yyspecial_routines72
			yyvsc72 := yyInitial_yyvs_size
			yyvs72 := yyspecial_routines72.make (yyvsc72)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs72")
			end
			yyvsc72 := yyvsc72 + yyInitial_yyvs_size
			yyvs72 := yyspecial_routines72.resize (yyvs72, yyvsc72)
		end
	end
	yyvs72.put (yyval72, yyvsp72)
end
		end

	yy_do_action_388 is
			--|#line 2319 "et_eiffel_parser.y"
		local
			yyval72: ET_FORMAL_ARGUMENT_ITEM
		do
--|#line 2319 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2319")
end

			yyval72 := ast_factory.new_formal_argument_semicolon (ast_factory.new_formal_argument (yyvs13.item (yyvsp13), ast_factory.new_colon_type (yyvs5.item (yyvsp5), yyvs112.item (yyvsp112))), yyvs22.item (yyvsp22))
			if yyval72 /= Void then
				increment_counter
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp72 := yyvsp72 + 1
	yyvsp13 := yyvsp13 -1
	yyvsp5 := yyvsp5 -1
	yyvsp112 := yyvsp112 -1
	yyvsp22 := yyvsp22 -1
	if yyvsp72 >= yyvsc72 then
		if yyvs72 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs72")
			end
			create yyspecial_routines72
			yyvsc72 := yyInitial_yyvs_size
			yyvs72 := yyspecial_routines72.make (yyvsc72)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs72")
			end
			yyvsc72 := yyvsc72 + yyInitial_yyvs_size
			yyvs72 := yyspecial_routines72.resize (yyvs72, yyvsc72)
		end
	end
	yyvs72.put (yyval72, yyvsp72)
end
		end

	yy_do_action_389 is
			--|#line 2330 "et_eiffel_parser.y"
		local
			yyval91: ET_LOCAL_VARIABLE_LIST
		do
--|#line 2330 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2330")
end

yyval91 := Void 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp91 := yyvsp91 + 1
	if yyvsp91 >= yyvsc91 then
		if yyvs91 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs91")
			end
			create yyspecial_routines91
			yyvsc91 := yyInitial_yyvs_size
			yyvs91 := yyspecial_routines91.make (yyvsc91)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs91")
			end
			yyvsc91 := yyvsc91 + yyInitial_yyvs_size
			yyvs91 := yyspecial_routines91.resize (yyvs91, yyvsc91)
		end
	end
	yyvs91.put (yyval91, yyvsp91)
end
		end

	yy_do_action_390 is
			--|#line 2332 "et_eiffel_parser.y"
		local
			yyval91: ET_LOCAL_VARIABLE_LIST
		do
--|#line 2332 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2332")
end

yyval91 := new_local_variables (yyvs2.item (yyvsp2), 0) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp91 := yyvsp91 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp91 >= yyvsc91 then
		if yyvs91 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs91")
			end
			create yyspecial_routines91
			yyvsc91 := yyInitial_yyvs_size
			yyvs91 := yyspecial_routines91.make (yyvsc91)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs91")
			end
			yyvsc91 := yyvsc91 + yyInitial_yyvs_size
			yyvs91 := yyspecial_routines91.resize (yyvs91, yyvsc91)
		end
	end
	yyvs91.put (yyval91, yyvsp91)
end
		end

	yy_do_action_391 is
			--|#line 2334 "et_eiffel_parser.y"
		local
			yyval91: ET_LOCAL_VARIABLE_LIST
		do
--|#line 2334 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2334")
end

			yyval91 := yyvs91.item (yyvsp91)
			remove_keyword
			remove_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp91 := yyvsp91 -1
	yyvsp2 := yyvsp2 -1
	yyvs91.put (yyval91, yyvsp91)
end
		end

	yy_do_action_392 is
			--|#line 2334 "et_eiffel_parser.y"
		local
			yyval91: ET_LOCAL_VARIABLE_LIST
		do
--|#line 2334 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2334")
end

			add_keyword (yyvs2.item (yyvsp2))
			add_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp91 := yyvsp91 + 1
	if yyvsp91 >= yyvsc91 then
		if yyvs91 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs91")
			end
			create yyspecial_routines91
			yyvsc91 := yyInitial_yyvs_size
			yyvs91 := yyspecial_routines91.make (yyvsc91)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs91")
			end
			yyvsc91 := yyvsc91 + yyInitial_yyvs_size
			yyvs91 := yyspecial_routines91.resize (yyvs91, yyvsc91)
		end
	end
	yyvs91.put (yyval91, yyvsp91)
end
		end

	yy_do_action_393 is
			--|#line 2347 "et_eiffel_parser.y"
		local
			yyval91: ET_LOCAL_VARIABLE_LIST
		do
--|#line 2347 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2347")
end

			yyval91 := new_local_variables (last_keyword, counter_value)
			if yyvs90.item (yyvsp90) /= Void then
				yyval91.put_first (yyvs90.item (yyvsp90))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp91 := yyvsp91 + 1
	yyvsp90 := yyvsp90 -1
	if yyvsp91 >= yyvsc91 then
		if yyvs91 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs91")
			end
			create yyspecial_routines91
			yyvsc91 := yyInitial_yyvs_size
			yyvs91 := yyspecial_routines91.make (yyvsc91)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs91")
			end
			yyvsc91 := yyvsc91 + yyInitial_yyvs_size
			yyvs91 := yyspecial_routines91.resize (yyvs91, yyvsc91)
		end
	end
	yyvs91.put (yyval91, yyvsp91)
end
		end

	yy_do_action_394 is
			--|#line 2354 "et_eiffel_parser.y"
		local
			yyval91: ET_LOCAL_VARIABLE_LIST
		do
--|#line 2354 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2354")
end

			yyval91 := new_local_variables (last_keyword, counter_value)
			if yyvs90.item (yyvsp90) /= Void then
				yyval91.put_first (yyvs90.item (yyvsp90))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp91 := yyvsp91 + 1
	yyvsp90 := yyvsp90 -1
	if yyvsp91 >= yyvsc91 then
		if yyvs91 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs91")
			end
			create yyspecial_routines91
			yyvsc91 := yyInitial_yyvs_size
			yyvs91 := yyspecial_routines91.make (yyvsc91)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs91")
			end
			yyvsc91 := yyvsc91 + yyInitial_yyvs_size
			yyvs91 := yyspecial_routines91.resize (yyvs91, yyvsc91)
		end
	end
	yyvs91.put (yyval91, yyvsp91)
end
		end

	yy_do_action_395 is
			--|#line 2361 "et_eiffel_parser.y"
		local
			yyval91: ET_LOCAL_VARIABLE_LIST
		do
--|#line 2361 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2361")
end

			yyval91 := yyvs91.item (yyvsp91)
			if yyval91 /= Void and yyvs89.item (yyvsp89) /= Void then
				if not yyval91.is_empty then
					yyvs89.item (yyvsp89).set_declared_type (yyval91.first.type)
					yyval91.put_first (yyvs89.item (yyvsp89))
				end
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp89 := yyvsp89 -1
	yyvs91.put (yyval91, yyvsp91)
end
		end

	yy_do_action_396 is
			--|#line 2371 "et_eiffel_parser.y"
		local
			yyval91: ET_LOCAL_VARIABLE_LIST
		do
--|#line 2371 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2371")
end

			-- TODO: Syntax error
			yyval91 := yyvs91.item (yyvsp91)
			if yyval91 /= Void and yyvs89.item (yyvsp89) /= Void then
				if not yyval91.is_empty then
					yyvs89.item (yyvsp89).set_declared_type (yyval91.first.type)
					yyval91.put_first (yyvs89.item (yyvsp89))
				end
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp89 := yyvsp89 -1
	yyvs91.put (yyval91, yyvsp91)
end
		end

	yy_do_action_397 is
			--|#line 2382 "et_eiffel_parser.y"
		local
			yyval91: ET_LOCAL_VARIABLE_LIST
		do
--|#line 2382 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2382")
end

			yyval91 := yyvs91.item (yyvsp91)
			if yyval91 /= Void and yyvs90.item (yyvsp90) /= Void then
				yyval91.put_first (yyvs90.item (yyvsp90))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp90 := yyvsp90 -1
	yyvs91.put (yyval91, yyvsp91)
end
		end

	yy_do_action_398 is
			--|#line 2389 "et_eiffel_parser.y"
		local
			yyval91: ET_LOCAL_VARIABLE_LIST
		do
--|#line 2389 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2389")
end

			yyval91 := yyvs91.item (yyvsp91)
			if yyval91 /= Void and yyvs90.item (yyvsp90) /= Void then
				yyval91.put_first (yyvs90.item (yyvsp90))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp90 := yyvsp90 -1
	yyvs91.put (yyval91, yyvsp91)
end
		end

	yy_do_action_399 is
			--|#line 2398 "et_eiffel_parser.y"
		local
			yyval89: ET_LOCAL_VARIABLE
		do
--|#line 2398 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2398")
end

			yyval89 := ast_factory.new_local_comma_variable (ast_factory.new_local_name_comma (yyvs13.item (yyvsp13), yyvs5.item (yyvsp5)), dummy_type)
			if yyval89 /= Void then
				increment_counter
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp89 := yyvsp89 + 1
	yyvsp13 := yyvsp13 -1
	yyvsp5 := yyvsp5 -1
	if yyvsp89 >= yyvsc89 then
		if yyvs89 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs89")
			end
			create yyspecial_routines89
			yyvsc89 := yyInitial_yyvs_size
			yyvs89 := yyspecial_routines89.make (yyvsc89)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs89")
			end
			yyvsc89 := yyvsc89 + yyInitial_yyvs_size
			yyvs89 := yyspecial_routines89.resize (yyvs89, yyvsc89)
		end
	end
	yyvs89.put (yyval89, yyvsp89)
end
		end

	yy_do_action_400 is
			--|#line 2407 "et_eiffel_parser.y"
		local
			yyval89: ET_LOCAL_VARIABLE
		do
--|#line 2407 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2407")
end

			yyval89 := ast_factory.new_local_comma_variable (yyvs13.item (yyvsp13), dummy_type)
			if yyval89 /= Void then
				increment_counter
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp89 := yyvsp89 + 1
	yyvsp13 := yyvsp13 -1
	if yyvsp89 >= yyvsc89 then
		if yyvs89 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs89")
			end
			create yyspecial_routines89
			yyvsc89 := yyInitial_yyvs_size
			yyvs89 := yyspecial_routines89.make (yyvsc89)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs89")
			end
			yyvsc89 := yyvsc89 + yyInitial_yyvs_size
			yyvs89 := yyspecial_routines89.resize (yyvs89, yyvsc89)
		end
	end
	yyvs89.put (yyval89, yyvsp89)
end
		end

	yy_do_action_401 is
			--|#line 2416 "et_eiffel_parser.y"
		local
			yyval90: ET_LOCAL_VARIABLE_ITEM
		do
--|#line 2416 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2416")
end

			yyval90 := ast_factory.new_local_variable (yyvs13.item (yyvsp13), ast_factory.new_colon_type (yyvs5.item (yyvsp5), yyvs112.item (yyvsp112)))
			if yyval90 /= Void then
				increment_counter
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp90 := yyvsp90 + 1
	yyvsp13 := yyvsp13 -1
	yyvsp5 := yyvsp5 -1
	yyvsp112 := yyvsp112 -1
	if yyvsp90 >= yyvsc90 then
		if yyvs90 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs90")
			end
			create yyspecial_routines90
			yyvsc90 := yyInitial_yyvs_size
			yyvs90 := yyspecial_routines90.make (yyvsc90)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs90")
			end
			yyvsc90 := yyvsc90 + yyInitial_yyvs_size
			yyvs90 := yyspecial_routines90.resize (yyvs90, yyvsc90)
		end
	end
	yyvs90.put (yyval90, yyvsp90)
end
		end

	yy_do_action_402 is
			--|#line 2425 "et_eiffel_parser.y"
		local
			yyval90: ET_LOCAL_VARIABLE_ITEM
		do
--|#line 2425 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2425")
end

			yyval90 := ast_factory.new_local_variable_semicolon (ast_factory.new_local_variable (yyvs13.item (yyvsp13), ast_factory.new_colon_type (yyvs5.item (yyvsp5), yyvs112.item (yyvsp112))), yyvs22.item (yyvsp22))
			if yyval90 /= Void then
				increment_counter
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp90 := yyvsp90 + 1
	yyvsp13 := yyvsp13 -1
	yyvsp5 := yyvsp5 -1
	yyvsp112 := yyvsp112 -1
	yyvsp22 := yyvsp22 -1
	if yyvsp90 >= yyvsc90 then
		if yyvs90 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs90")
			end
			create yyspecial_routines90
			yyvsc90 := yyInitial_yyvs_size
			yyvs90 := yyspecial_routines90.make (yyvsc90)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs90")
			end
			yyvsc90 := yyvsc90 + yyInitial_yyvs_size
			yyvs90 := yyspecial_routines90.resize (yyvs90, yyvsc90)
		end
	end
	yyvs90.put (yyval90, yyvsp90)
end
		end

	yy_do_action_403 is
			--|#line 2436 "et_eiffel_parser.y"
		local
			yyval1: ANY
		do
--|#line 2436 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2436")
end

add_expression_assertion (yyvs62.item (yyvsp62), Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp1 := yyvsp1 + 1
	yyvsp62 := yyvsp62 -1
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
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_404 is
			--|#line 2438 "et_eiffel_parser.y"
		local
			yyval1: ANY
		do
--|#line 2438 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2438")
end

add_expression_assertion (yyvs62.item (yyvsp62), yyvs22.item (yyvsp22)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 + 1
	yyvsp62 := yyvsp62 -1
	yyvsp22 := yyvsp22 -1
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
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_405 is
			--|#line 2440 "et_eiffel_parser.y"
		local
			yyval1: ANY
		do
--|#line 2440 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2440")
end

add_tagged_assertion (yyvs13.item (yyvsp13), yyvs5.item (yyvsp5), Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 + 1
	yyvsp13 := yyvsp13 -1
	yyvsp5 := yyvsp5 -1
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
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_406 is
			--|#line 2442 "et_eiffel_parser.y"
		local
			yyval1: ANY
		do
--|#line 2442 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2442")
end

add_tagged_assertion (yyvs13.item (yyvsp13), yyvs5.item (yyvsp5), yyvs22.item (yyvsp22)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 + 1
	yyvsp13 := yyvsp13 -1
	yyvsp5 := yyvsp5 -1
	yyvsp22 := yyvsp22 -1
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
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_407 is
			--|#line 2444 "et_eiffel_parser.y"
		local
			yyval1: ANY
		do
--|#line 2444 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2444")
end

add_expression_assertion (yyvs62.item (yyvsp62), Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp62 := yyvsp62 -1
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_408 is
			--|#line 2446 "et_eiffel_parser.y"
		local
			yyval1: ANY
		do
--|#line 2446 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2446")
end

add_expression_assertion (yyvs62.item (yyvsp62), yyvs22.item (yyvsp22)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 -1
	yyvsp22 := yyvsp22 -1
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_409 is
			--|#line 2448 "et_eiffel_parser.y"
		local
			yyval1: ANY
		do
--|#line 2448 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2448")
end

add_tagged_assertion (yyvs13.item (yyvsp13), yyvs5.item (yyvsp5), Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp13 := yyvsp13 -1
	yyvsp5 := yyvsp5 -1
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_410 is
			--|#line 2450 "et_eiffel_parser.y"
		local
			yyval1: ANY
		do
--|#line 2450 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2450")
end

add_tagged_assertion (yyvs13.item (yyvsp13), yyvs5.item (yyvsp5), yyvs22.item (yyvsp22)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp13 := yyvsp13 -1
	yyvsp5 := yyvsp5 -1
	yyvsp22 := yyvsp22 -1
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_411 is
			--|#line 2454 "et_eiffel_parser.y"
		local
			yyval104: ET_PRECONDITIONS
		do
--|#line 2454 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2454")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp104 := yyvsp104 + 1
	if yyvsp104 >= yyvsc104 then
		if yyvs104 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs104")
			end
			create yyspecial_routines104
			yyvsc104 := yyInitial_yyvs_size
			yyvs104 := yyspecial_routines104.make (yyvsc104)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs104")
			end
			yyvsc104 := yyvsc104 + yyInitial_yyvs_size
			yyvs104 := yyspecial_routines104.resize (yyvs104, yyvsc104)
		end
	end
	yyvs104.put (yyval104, yyvsp104)
end
		end

	yy_do_action_412 is
			--|#line 2456 "et_eiffel_parser.y"
		local
			yyval104: ET_PRECONDITIONS
		do
--|#line 2456 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2456")
end

yyval104 := new_preconditions (yyvs2.item (yyvsp2), Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp104 := yyvsp104 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp104 >= yyvsc104 then
		if yyvs104 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs104")
			end
			create yyspecial_routines104
			yyvsc104 := yyInitial_yyvs_size
			yyvs104 := yyspecial_routines104.make (yyvsc104)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs104")
			end
			yyvsc104 := yyvsc104 + yyInitial_yyvs_size
			yyvs104 := yyspecial_routines104.resize (yyvs104, yyvsc104)
		end
	end
	yyvs104.put (yyval104, yyvsp104)
end
		end

	yy_do_action_413 is
			--|#line 2458 "et_eiffel_parser.y"
		local
			yyval104: ET_PRECONDITIONS
		do
--|#line 2458 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2458")
end

yyval104 := new_preconditions (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp104 := yyvsp104 + 1
	yyvsp2 := yyvsp2 -2
	if yyvsp104 >= yyvsc104 then
		if yyvs104 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs104")
			end
			create yyspecial_routines104
			yyvsc104 := yyInitial_yyvs_size
			yyvs104 := yyspecial_routines104.make (yyvsc104)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs104")
			end
			yyvsc104 := yyvsc104 + yyInitial_yyvs_size
			yyvs104 := yyspecial_routines104.resize (yyvs104, yyvsc104)
		end
	end
	yyvs104.put (yyval104, yyvsp104)
end
		end

	yy_do_action_414 is
			--|#line 2460 "et_eiffel_parser.y"
		local
			yyval104: ET_PRECONDITIONS
		do
--|#line 2460 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2460")
end

yyval104 := new_preconditions (yyvs2.item (yyvsp2), Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp104 := yyvsp104 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -1
	if yyvsp104 >= yyvsc104 then
		if yyvs104 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs104")
			end
			create yyspecial_routines104
			yyvsc104 := yyInitial_yyvs_size
			yyvs104 := yyspecial_routines104.make (yyvsc104)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs104")
			end
			yyvsc104 := yyvsc104 + yyInitial_yyvs_size
			yyvs104 := yyspecial_routines104.resize (yyvs104, yyvsc104)
		end
	end
	yyvs104.put (yyval104, yyvsp104)
end
		end

	yy_do_action_415 is
			--|#line 2462 "et_eiffel_parser.y"
		local
			yyval104: ET_PRECONDITIONS
		do
--|#line 2462 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2462")
end

yyval104 := new_preconditions (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp104 := yyvsp104 + 1
	yyvsp2 := yyvsp2 -2
	yyvsp1 := yyvsp1 -1
	if yyvsp104 >= yyvsc104 then
		if yyvs104 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs104")
			end
			create yyspecial_routines104
			yyvsc104 := yyInitial_yyvs_size
			yyvs104 := yyspecial_routines104.make (yyvsc104)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs104")
			end
			yyvsc104 := yyvsc104 + yyInitial_yyvs_size
			yyvs104 := yyspecial_routines104.resize (yyvs104, yyvsc104)
		end
	end
	yyvs104.put (yyval104, yyvsp104)
end
		end

	yy_do_action_416 is
			--|#line 2466 "et_eiffel_parser.y"
		local
			yyval103: ET_POSTCONDITIONS
		do
--|#line 2466 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2466")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp103 := yyvsp103 + 1
	if yyvsp103 >= yyvsc103 then
		if yyvs103 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs103")
			end
			create yyspecial_routines103
			yyvsc103 := yyInitial_yyvs_size
			yyvs103 := yyspecial_routines103.make (yyvsc103)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs103")
			end
			yyvsc103 := yyvsc103 + yyInitial_yyvs_size
			yyvs103 := yyspecial_routines103.resize (yyvs103, yyvsc103)
		end
	end
	yyvs103.put (yyval103, yyvsp103)
end
		end

	yy_do_action_417 is
			--|#line 2468 "et_eiffel_parser.y"
		local
			yyval103: ET_POSTCONDITIONS
		do
--|#line 2468 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2468")
end

yyval103 := new_postconditions (yyvs2.item (yyvsp2), Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp103 := yyvsp103 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp103 >= yyvsc103 then
		if yyvs103 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs103")
			end
			create yyspecial_routines103
			yyvsc103 := yyInitial_yyvs_size
			yyvs103 := yyspecial_routines103.make (yyvsc103)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs103")
			end
			yyvsc103 := yyvsc103 + yyInitial_yyvs_size
			yyvs103 := yyspecial_routines103.resize (yyvs103, yyvsc103)
		end
	end
	yyvs103.put (yyval103, yyvsp103)
end
		end

	yy_do_action_418 is
			--|#line 2470 "et_eiffel_parser.y"
		local
			yyval103: ET_POSTCONDITIONS
		do
--|#line 2470 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2470")
end

yyval103 := new_postconditions (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp103 := yyvsp103 + 1
	yyvsp2 := yyvsp2 -2
	if yyvsp103 >= yyvsc103 then
		if yyvs103 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs103")
			end
			create yyspecial_routines103
			yyvsc103 := yyInitial_yyvs_size
			yyvs103 := yyspecial_routines103.make (yyvsc103)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs103")
			end
			yyvsc103 := yyvsc103 + yyInitial_yyvs_size
			yyvs103 := yyspecial_routines103.resize (yyvs103, yyvsc103)
		end
	end
	yyvs103.put (yyval103, yyvsp103)
end
		end

	yy_do_action_419 is
			--|#line 2472 "et_eiffel_parser.y"
		local
			yyval103: ET_POSTCONDITIONS
		do
--|#line 2472 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2472")
end

yyval103 := new_postconditions (yyvs2.item (yyvsp2), Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp103 := yyvsp103 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -1
	if yyvsp103 >= yyvsc103 then
		if yyvs103 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs103")
			end
			create yyspecial_routines103
			yyvsc103 := yyInitial_yyvs_size
			yyvs103 := yyspecial_routines103.make (yyvsc103)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs103")
			end
			yyvsc103 := yyvsc103 + yyInitial_yyvs_size
			yyvs103 := yyspecial_routines103.resize (yyvs103, yyvsc103)
		end
	end
	yyvs103.put (yyval103, yyvsp103)
end
		end

	yy_do_action_420 is
			--|#line 2474 "et_eiffel_parser.y"
		local
			yyval103: ET_POSTCONDITIONS
		do
--|#line 2474 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2474")
end

yyval103 := new_postconditions (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp103 := yyvsp103 + 1
	yyvsp2 := yyvsp2 -2
	yyvsp1 := yyvsp1 -1
	if yyvsp103 >= yyvsc103 then
		if yyvs103 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs103")
			end
			create yyspecial_routines103
			yyvsc103 := yyInitial_yyvs_size
			yyvs103 := yyspecial_routines103.make (yyvsc103)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs103")
			end
			yyvsc103 := yyvsc103 + yyInitial_yyvs_size
			yyvs103 := yyspecial_routines103.resize (yyvs103, yyvsc103)
		end
	end
	yyvs103.put (yyval103, yyvsp103)
end
		end

	yy_do_action_421 is
			--|#line 2478 "et_eiffel_parser.y"
		local
			yyval86: ET_INVARIANTS
		do
--|#line 2478 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2478")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp86 := yyvsp86 + 1
	if yyvsp86 >= yyvsc86 then
		if yyvs86 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs86")
			end
			create yyspecial_routines86
			yyvsc86 := yyInitial_yyvs_size
			yyvs86 := yyspecial_routines86.make (yyvsc86)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs86")
			end
			yyvsc86 := yyvsc86 + yyInitial_yyvs_size
			yyvs86 := yyspecial_routines86.resize (yyvs86, yyvsc86)
		end
	end
	yyvs86.put (yyval86, yyvsp86)
end
		end

	yy_do_action_422 is
			--|#line 2480 "et_eiffel_parser.y"
		local
			yyval86: ET_INVARIANTS
		do
--|#line 2480 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2480")
end

yyval86 := yyvs86.item (yyvsp86) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs86.put (yyval86, yyvsp86)
end
		end

	yy_do_action_423 is
			--|#line 2484 "et_eiffel_parser.y"
		local
			yyval86: ET_INVARIANTS
		do
--|#line 2484 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2484")
end

yyval86 := new_invariants (yyvs2.item (yyvsp2)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp86 := yyvsp86 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -1
	if yyvsp86 >= yyvsc86 then
		if yyvs86 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs86")
			end
			create yyspecial_routines86
			yyvsc86 := yyInitial_yyvs_size
			yyvs86 := yyspecial_routines86.make (yyvsc86)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs86")
			end
			yyvsc86 := yyvsc86 + yyInitial_yyvs_size
			yyvs86 := yyspecial_routines86.resize (yyvs86, yyvsc86)
		end
	end
	yyvs86.put (yyval86, yyvsp86)
end
		end

	yy_do_action_424 is
			--|#line 2486 "et_eiffel_parser.y"
		local
			yyval86: ET_INVARIANTS
		do
--|#line 2486 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2486")
end

yyval86 := new_invariants (yyvs2.item (yyvsp2)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp86 := yyvsp86 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -2
	if yyvsp86 >= yyvsc86 then
		if yyvs86 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs86")
			end
			create yyspecial_routines86
			yyvsc86 := yyInitial_yyvs_size
			yyvs86 := yyspecial_routines86.make (yyvsc86)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs86")
			end
			yyvsc86 := yyvsc86 + yyInitial_yyvs_size
			yyvs86 := yyspecial_routines86.resize (yyvs86, yyvsc86)
		end
	end
	yyvs86.put (yyval86, yyvsp86)
end
		end

	yy_do_action_425 is
			--|#line 2490 "et_eiffel_parser.y"
		local
			yyval1: ANY
		do
--|#line 2490 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2490")
end

set_start_closure (Void) 
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
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_426 is
			--|#line 2494 "et_eiffel_parser.y"
		local
			yyval92: ET_LOOP_INVARIANTS
		do
--|#line 2494 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2494")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp92 := yyvsp92 + 1
	if yyvsp92 >= yyvsc92 then
		if yyvs92 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs92")
			end
			create yyspecial_routines92
			yyvsc92 := yyInitial_yyvs_size
			yyvs92 := yyspecial_routines92.make (yyvsc92)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs92")
			end
			yyvsc92 := yyvsc92 + yyInitial_yyvs_size
			yyvs92 := yyspecial_routines92.resize (yyvs92, yyvsc92)
		end
	end
	yyvs92.put (yyval92, yyvsp92)
end
		end

	yy_do_action_427 is
			--|#line 2496 "et_eiffel_parser.y"
		local
			yyval92: ET_LOOP_INVARIANTS
		do
--|#line 2496 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2496")
end

yyval92 := yyvs92.item (yyvsp92) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs92.put (yyval92, yyvsp92)
end
		end

	yy_do_action_428 is
			--|#line 2500 "et_eiffel_parser.y"
		local
			yyval92: ET_LOOP_INVARIANTS
		do
--|#line 2500 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2500")
end

yyval92 := new_loop_invariants (yyvs2.item (yyvsp2)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp92 := yyvsp92 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp92 >= yyvsc92 then
		if yyvs92 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs92")
			end
			create yyspecial_routines92
			yyvsc92 := yyInitial_yyvs_size
			yyvs92 := yyspecial_routines92.make (yyvsc92)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs92")
			end
			yyvsc92 := yyvsc92 + yyInitial_yyvs_size
			yyvs92 := yyspecial_routines92.resize (yyvs92, yyvsc92)
		end
	end
	yyvs92.put (yyval92, yyvsp92)
end
		end

	yy_do_action_429 is
			--|#line 2502 "et_eiffel_parser.y"
		local
			yyval92: ET_LOOP_INVARIANTS
		do
--|#line 2502 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2502")
end

yyval92 := new_loop_invariants (yyvs2.item (yyvsp2)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp92 := yyvsp92 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -1
	if yyvsp92 >= yyvsc92 then
		if yyvs92 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs92")
			end
			create yyspecial_routines92
			yyvsc92 := yyInitial_yyvs_size
			yyvs92 := yyspecial_routines92.make (yyvsc92)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs92")
			end
			yyvsc92 := yyvsc92 + yyInitial_yyvs_size
			yyvs92 := yyspecial_routines92.resize (yyvs92, yyvsc92)
		end
	end
	yyvs92.put (yyval92, yyvsp92)
end
		end

	yy_do_action_430 is
			--|#line 2506 "et_eiffel_parser.y"
		local
			yyval115: ET_VARIANT
		do
--|#line 2506 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2506")
end

yyval115 := ast_factory.new_variant (yyvs2.item (yyvsp2), Void, Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp115 := yyvsp115 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp115 >= yyvsc115 then
		if yyvs115 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs115")
			end
			create yyspecial_routines115
			yyvsc115 := yyInitial_yyvs_size
			yyvs115 := yyspecial_routines115.make (yyvsc115)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs115")
			end
			yyvsc115 := yyvsc115 + yyInitial_yyvs_size
			yyvs115 := yyspecial_routines115.resize (yyvs115, yyvsc115)
		end
	end
	yyvs115.put (yyval115, yyvsp115)
end
		end

	yy_do_action_431 is
			--|#line 2508 "et_eiffel_parser.y"
		local
			yyval115: ET_VARIANT
		do
--|#line 2508 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2508")
end

yyval115 := ast_factory.new_variant (yyvs2.item (yyvsp2), Void, yyvs62.item (yyvsp62)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp115 := yyvsp115 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp62 := yyvsp62 -1
	if yyvsp115 >= yyvsc115 then
		if yyvs115 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs115")
			end
			create yyspecial_routines115
			yyvsc115 := yyInitial_yyvs_size
			yyvs115 := yyspecial_routines115.make (yyvsc115)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs115")
			end
			yyvsc115 := yyvsc115 + yyInitial_yyvs_size
			yyvs115 := yyspecial_routines115.resize (yyvs115, yyvsc115)
		end
	end
	yyvs115.put (yyval115, yyvsp115)
end
		end

	yy_do_action_432 is
			--|#line 2510 "et_eiffel_parser.y"
		local
			yyval115: ET_VARIANT
		do
--|#line 2510 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2510")
end

yyval115 := ast_factory.new_variant (yyvs2.item (yyvsp2), ast_factory.new_tag (yyvs13.item (yyvsp13), yyvs5.item (yyvsp5)), yyvs62.item (yyvsp62)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp115 := yyvsp115 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp13 := yyvsp13 -1
	yyvsp5 := yyvsp5 -1
	yyvsp62 := yyvsp62 -1
	if yyvsp115 >= yyvsc115 then
		if yyvs115 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs115")
			end
			create yyspecial_routines115
			yyvsc115 := yyInitial_yyvs_size
			yyvs115 := yyspecial_routines115.make (yyvsc115)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs115")
			end
			yyvsc115 := yyvsc115 + yyInitial_yyvs_size
			yyvs115 := yyspecial_routines115.resize (yyvs115, yyvsc115)
		end
	end
	yyvs115.put (yyval115, yyvsp115)
end
		end

	yy_do_action_433 is
			--|#line 2516 "et_eiffel_parser.y"
		local
			yyval45: ET_COMPOUND
		do
--|#line 2516 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2516")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp45 := yyvsp45 + 1
	if yyvsp45 >= yyvsc45 then
		if yyvs45 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs45")
			end
			create yyspecial_routines45
			yyvsc45 := yyInitial_yyvs_size
			yyvs45 := yyspecial_routines45.make (yyvsc45)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs45")
			end
			yyvsc45 := yyvsc45 + yyInitial_yyvs_size
			yyvs45 := yyspecial_routines45.resize (yyvs45, yyvsc45)
		end
	end
	yyvs45.put (yyval45, yyvsp45)
end
		end

	yy_do_action_434 is
			--|#line 2518 "et_eiffel_parser.y"
		local
			yyval45: ET_COMPOUND
		do
--|#line 2518 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2518")
end

yyval45 := yyvs45.item (yyvsp45) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs45.put (yyval45, yyvsp45)
end
		end

	yy_do_action_435 is
			--|#line 2524 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2524 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2524")
end

yyval112 := new_named_type (Void, yyvs13.item (yyvsp13), Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp112 := yyvsp112 + 1
	yyvsp13 := yyvsp13 -1
	if yyvsp112 >= yyvsc112 then
		if yyvs112 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs112")
			end
			create yyspecial_routines112
			yyvsc112 := yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.make (yyvsc112)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs112")
			end
			yyvsc112 := yyvsc112 + yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.resize (yyvs112, yyvsc112)
		end
	end
	yyvs112.put (yyval112, yyvsp112)
end
		end

	yy_do_action_436 is
			--|#line 2526 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2526 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2526")
end

yyval112 := yyvs112.item (yyvsp112) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs112.put (yyval112, yyvsp112)
end
		end

	yy_do_action_437 is
			--|#line 2530 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2530 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2530")
end

yyval112 := new_named_type (Void, yyvs13.item (yyvsp13), yyvs27.item (yyvsp27)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp112 := yyvsp112 + 1
	yyvsp13 := yyvsp13 -1
	yyvsp27 := yyvsp27 -1
	if yyvsp112 >= yyvsc112 then
		if yyvs112 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs112")
			end
			create yyspecial_routines112
			yyvsc112 := yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.make (yyvsc112)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs112")
			end
			yyvsc112 := yyvsc112 + yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.resize (yyvs112, yyvsc112)
		end
	end
	yyvs112.put (yyval112, yyvsp112)
end
		end

	yy_do_action_438 is
			--|#line 2532 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2532 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2532")
end

yyval112 := new_named_type (yyvs2.item (yyvsp2), yyvs13.item (yyvsp13), yyvs27.item (yyvsp27)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp112 := yyvsp112 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp13 := yyvsp13 -1
	yyvsp27 := yyvsp27 -1
	if yyvsp112 >= yyvsc112 then
		if yyvs112 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs112")
			end
			create yyspecial_routines112
			yyvsc112 := yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.make (yyvsc112)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs112")
			end
			yyvsc112 := yyvsc112 + yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.resize (yyvs112, yyvsc112)
		end
	end
	yyvs112.put (yyval112, yyvsp112)
end
		end

	yy_do_action_439 is
			--|#line 2534 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2534 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2534")
end

yyval112 := new_named_type (yyvs2.item (yyvsp2), yyvs13.item (yyvsp13), yyvs27.item (yyvsp27)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp112 := yyvsp112 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp13 := yyvsp13 -1
	yyvsp27 := yyvsp27 -1
	if yyvsp112 >= yyvsc112 then
		if yyvs112 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs112")
			end
			create yyspecial_routines112
			yyvsc112 := yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.make (yyvsc112)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs112")
			end
			yyvsc112 := yyvsc112 + yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.resize (yyvs112, yyvsc112)
		end
	end
	yyvs112.put (yyval112, yyvsp112)
end
		end

	yy_do_action_440 is
			--|#line 2536 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2536 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2536")
end

yyval112 := new_named_type (yyvs2.item (yyvsp2), yyvs13.item (yyvsp13), yyvs27.item (yyvsp27)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp112 := yyvsp112 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp13 := yyvsp13 -1
	yyvsp27 := yyvsp27 -1
	if yyvsp112 >= yyvsc112 then
		if yyvs112 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs112")
			end
			create yyspecial_routines112
			yyvsc112 := yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.make (yyvsc112)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs112")
			end
			yyvsc112 := yyvsc112 + yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.resize (yyvs112, yyvsc112)
		end
	end
	yyvs112.put (yyval112, yyvsp112)
end
		end

	yy_do_action_441 is
			--|#line 2538 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2538 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2538")
end

			if current_system.is_ise and then current_system.ise_version < ise_6_1_0 then
				raise_error
			else
				yyval112 := new_named_type (yyvs5.item (yyvsp5), yyvs13.item (yyvsp13), yyvs27.item (yyvsp27))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp112 := yyvsp112 + 1
	yyvsp5 := yyvsp5 -1
	yyvsp13 := yyvsp13 -1
	yyvsp27 := yyvsp27 -1
	if yyvsp112 >= yyvsc112 then
		if yyvs112 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs112")
			end
			create yyspecial_routines112
			yyvsc112 := yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.make (yyvsc112)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs112")
			end
			yyvsc112 := yyvsc112 + yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.resize (yyvs112, yyvsc112)
		end
	end
	yyvs112.put (yyval112, yyvsp112)
end
		end

	yy_do_action_442 is
			--|#line 2546 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2546 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2546")
end

			if current_system.is_ise and then current_system.ise_version < ise_6_1_0 then
				raise_error
			else
				yyval112 := new_named_type (yyvs24.item (yyvsp24), yyvs13.item (yyvsp13), yyvs27.item (yyvsp27))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp112 := yyvsp112 + 1
	yyvsp24 := yyvsp24 -1
	yyvsp13 := yyvsp13 -1
	yyvsp27 := yyvsp27 -1
	if yyvsp112 >= yyvsc112 then
		if yyvs112 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs112")
			end
			create yyspecial_routines112
			yyvsc112 := yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.make (yyvsc112)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs112")
			end
			yyvsc112 := yyvsc112 + yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.resize (yyvs112, yyvsc112)
		end
	end
	yyvs112.put (yyval112, yyvsp112)
end
		end

	yy_do_action_443 is
			--|#line 2554 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2554 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2554")
end

yyval112 := yyvs88.item (yyvsp88) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp112 := yyvsp112 + 1
	yyvsp88 := yyvsp88 -1
	if yyvsp112 >= yyvsc112 then
		if yyvs112 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs112")
			end
			create yyspecial_routines112
			yyvsc112 := yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.make (yyvsc112)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs112")
			end
			yyvsc112 := yyvsc112 + yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.resize (yyvs112, yyvsc112)
		end
	end
	yyvs112.put (yyval112, yyvsp112)
end
		end

	yy_do_action_444 is
			--|#line 2556 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2556 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2556")
end

yyval112 := new_bit_n (yyvs13.item (yyvsp13), yyvs14.item (yyvsp14)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp112 := yyvsp112 + 1
	yyvsp13 := yyvsp13 -1
	yyvsp14 := yyvsp14 -1
	if yyvsp112 >= yyvsc112 then
		if yyvs112 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs112")
			end
			create yyspecial_routines112
			yyvsc112 := yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.make (yyvsc112)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs112")
			end
			yyvsc112 := yyvsc112 + yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.resize (yyvs112, yyvsc112)
		end
	end
	yyvs112.put (yyval112, yyvsp112)
end
		end

	yy_do_action_445 is
			--|#line 2558 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2558 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2558")
end

yyval112 := new_bit_feature (yyvs13.item (yyvsp13 - 1), yyvs13.item (yyvsp13))  
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp112 := yyvsp112 + 1
	yyvsp13 := yyvsp13 -2
	if yyvsp112 >= yyvsc112 then
		if yyvs112 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs112")
			end
			create yyspecial_routines112
			yyvsc112 := yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.make (yyvsc112)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs112")
			end
			yyvsc112 := yyvsc112 + yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.resize (yyvs112, yyvsc112)
		end
	end
	yyvs112.put (yyval112, yyvsp112)
end
		end

	yy_do_action_446 is
			--|#line 2560 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2560 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2560")
end

yyval112 := new_tuple_type (Void, yyvs13.item (yyvsp13), yyvs27.item (yyvsp27)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp112 := yyvsp112 + 1
	yyvsp13 := yyvsp13 -1
	yyvsp27 := yyvsp27 -1
	if yyvsp112 >= yyvsc112 then
		if yyvs112 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs112")
			end
			create yyspecial_routines112
			yyvsc112 := yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.make (yyvsc112)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs112")
			end
			yyvsc112 := yyvsc112 + yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.resize (yyvs112, yyvsc112)
		end
	end
	yyvs112.put (yyval112, yyvsp112)
end
		end

	yy_do_action_447 is
			--|#line 2562 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2562 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2562")
end

			if current_system.is_ise and then current_system.ise_version < ise_6_1_0 then
				raise_error
			else
				yyval112 := new_tuple_type (yyvs5.item (yyvsp5), yyvs13.item (yyvsp13), yyvs27.item (yyvsp27))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp112 := yyvsp112 + 1
	yyvsp5 := yyvsp5 -1
	yyvsp13 := yyvsp13 -1
	yyvsp27 := yyvsp27 -1
	if yyvsp112 >= yyvsc112 then
		if yyvs112 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs112")
			end
			create yyspecial_routines112
			yyvsc112 := yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.make (yyvsc112)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs112")
			end
			yyvsc112 := yyvsc112 + yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.resize (yyvs112, yyvsc112)
		end
	end
	yyvs112.put (yyval112, yyvsp112)
end
		end

	yy_do_action_448 is
			--|#line 2570 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2570 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2570")
end

			if current_system.is_ise and then current_system.ise_version < ise_6_1_0 then
				raise_error
			else
				yyval112 := new_tuple_type (yyvs24.item (yyvsp24), yyvs13.item (yyvsp13), yyvs27.item (yyvsp27))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp112 := yyvsp112 + 1
	yyvsp24 := yyvsp24 -1
	yyvsp13 := yyvsp13 -1
	yyvsp27 := yyvsp27 -1
	if yyvsp112 >= yyvsc112 then
		if yyvs112 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs112")
			end
			create yyspecial_routines112
			yyvsc112 := yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.make (yyvsc112)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs112")
			end
			yyvsc112 := yyvsc112 + yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.resize (yyvs112, yyvsc112)
		end
	end
	yyvs112.put (yyval112, yyvsp112)
end
		end

	yy_do_action_449 is
			--|#line 2580 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2580 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2580")
end

yyval112 := new_named_type (Void, yyvs13.item (yyvsp13), yyvs27.item (yyvsp27)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp112 := yyvsp112 + 1
	yyvsp13 := yyvsp13 -1
	yyvsp27 := yyvsp27 -1
	if yyvsp112 >= yyvsc112 then
		if yyvs112 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs112")
			end
			create yyspecial_routines112
			yyvsc112 := yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.make (yyvsc112)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs112")
			end
			yyvsc112 := yyvsc112 + yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.resize (yyvs112, yyvsc112)
		end
	end
	yyvs112.put (yyval112, yyvsp112)
end
		end

	yy_do_action_450 is
			--|#line 2582 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2582 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2582")
end

yyval112 := new_named_type (yyvs2.item (yyvsp2), yyvs13.item (yyvsp13), yyvs27.item (yyvsp27)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp112 := yyvsp112 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp13 := yyvsp13 -1
	yyvsp27 := yyvsp27 -1
	if yyvsp112 >= yyvsc112 then
		if yyvs112 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs112")
			end
			create yyspecial_routines112
			yyvsc112 := yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.make (yyvsc112)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs112")
			end
			yyvsc112 := yyvsc112 + yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.resize (yyvs112, yyvsc112)
		end
	end
	yyvs112.put (yyval112, yyvsp112)
end
		end

	yy_do_action_451 is
			--|#line 2584 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2584 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2584")
end

yyval112 := new_named_type (yyvs2.item (yyvsp2), yyvs13.item (yyvsp13), yyvs27.item (yyvsp27)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp112 := yyvsp112 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp13 := yyvsp13 -1
	yyvsp27 := yyvsp27 -1
	if yyvsp112 >= yyvsc112 then
		if yyvs112 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs112")
			end
			create yyspecial_routines112
			yyvsc112 := yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.make (yyvsc112)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs112")
			end
			yyvsc112 := yyvsc112 + yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.resize (yyvs112, yyvsc112)
		end
	end
	yyvs112.put (yyval112, yyvsp112)
end
		end

	yy_do_action_452 is
			--|#line 2586 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2586 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2586")
end

yyval112 := new_named_type (yyvs2.item (yyvsp2), yyvs13.item (yyvsp13), yyvs27.item (yyvsp27)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp112 := yyvsp112 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp13 := yyvsp13 -1
	yyvsp27 := yyvsp27 -1
	if yyvsp112 >= yyvsc112 then
		if yyvs112 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs112")
			end
			create yyspecial_routines112
			yyvsc112 := yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.make (yyvsc112)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs112")
			end
			yyvsc112 := yyvsc112 + yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.resize (yyvs112, yyvsc112)
		end
	end
	yyvs112.put (yyval112, yyvsp112)
end
		end

	yy_do_action_453 is
			--|#line 2588 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2588 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2588")
end

			if current_system.is_ise and then current_system.ise_version < ise_6_1_0 then
				raise_error
			else
				yyval112 := new_named_type (yyvs5.item (yyvsp5), yyvs13.item (yyvsp13), yyvs27.item (yyvsp27))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp112 := yyvsp112 + 1
	yyvsp5 := yyvsp5 -1
	yyvsp13 := yyvsp13 -1
	yyvsp27 := yyvsp27 -1
	if yyvsp112 >= yyvsc112 then
		if yyvs112 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs112")
			end
			create yyspecial_routines112
			yyvsc112 := yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.make (yyvsc112)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs112")
			end
			yyvsc112 := yyvsc112 + yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.resize (yyvs112, yyvsc112)
		end
	end
	yyvs112.put (yyval112, yyvsp112)
end
		end

	yy_do_action_454 is
			--|#line 2596 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2596 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2596")
end

			if current_system.is_ise and then current_system.ise_version < ise_6_1_0 then
				raise_error
			else
				yyval112 := new_named_type (yyvs24.item (yyvsp24), yyvs13.item (yyvsp13), yyvs27.item (yyvsp27))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp112 := yyvsp112 + 1
	yyvsp24 := yyvsp24 -1
	yyvsp13 := yyvsp13 -1
	yyvsp27 := yyvsp27 -1
	if yyvsp112 >= yyvsc112 then
		if yyvs112 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs112")
			end
			create yyspecial_routines112
			yyvsc112 := yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.make (yyvsc112)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs112")
			end
			yyvsc112 := yyvsc112 + yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.resize (yyvs112, yyvsc112)
		end
	end
	yyvs112.put (yyval112, yyvsp112)
end
		end

	yy_do_action_455 is
			--|#line 2604 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2604 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2604")
end

yyval112 := yyvs88.item (yyvsp88) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp112 := yyvsp112 + 1
	yyvsp88 := yyvsp88 -1
	if yyvsp112 >= yyvsc112 then
		if yyvs112 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs112")
			end
			create yyspecial_routines112
			yyvsc112 := yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.make (yyvsc112)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs112")
			end
			yyvsc112 := yyvsc112 + yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.resize (yyvs112, yyvsc112)
		end
	end
	yyvs112.put (yyval112, yyvsp112)
end
		end

	yy_do_action_456 is
			--|#line 2606 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2606 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2606")
end

yyval112 := new_bit_n (yyvs13.item (yyvsp13), yyvs14.item (yyvsp14)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp112 := yyvsp112 + 1
	yyvsp13 := yyvsp13 -1
	yyvsp14 := yyvsp14 -1
	if yyvsp112 >= yyvsc112 then
		if yyvs112 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs112")
			end
			create yyspecial_routines112
			yyvsc112 := yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.make (yyvsc112)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs112")
			end
			yyvsc112 := yyvsc112 + yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.resize (yyvs112, yyvsc112)
		end
	end
	yyvs112.put (yyval112, yyvsp112)
end
		end

	yy_do_action_457 is
			--|#line 2608 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2608 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2608")
end

yyval112 := new_bit_feature (yyvs13.item (yyvsp13 - 1), yyvs13.item (yyvsp13))  
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp112 := yyvsp112 + 1
	yyvsp13 := yyvsp13 -2
	if yyvsp112 >= yyvsc112 then
		if yyvs112 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs112")
			end
			create yyspecial_routines112
			yyvsc112 := yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.make (yyvsc112)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs112")
			end
			yyvsc112 := yyvsc112 + yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.resize (yyvs112, yyvsc112)
		end
	end
	yyvs112.put (yyval112, yyvsp112)
end
		end

	yy_do_action_458 is
			--|#line 2610 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2610 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2610")
end

yyval112 := new_tuple_type (Void, yyvs13.item (yyvsp13), yyvs27.item (yyvsp27)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp112 := yyvsp112 + 1
	yyvsp13 := yyvsp13 -1
	yyvsp27 := yyvsp27 -1
	if yyvsp112 >= yyvsc112 then
		if yyvs112 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs112")
			end
			create yyspecial_routines112
			yyvsc112 := yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.make (yyvsc112)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs112")
			end
			yyvsc112 := yyvsc112 + yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.resize (yyvs112, yyvsc112)
		end
	end
	yyvs112.put (yyval112, yyvsp112)
end
		end

	yy_do_action_459 is
			--|#line 2612 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2612 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2612")
end

			if current_system.is_ise and then current_system.ise_version < ise_6_1_0 then
				raise_error
			else
				yyval112 := new_tuple_type (yyvs5.item (yyvsp5), yyvs13.item (yyvsp13), yyvs27.item (yyvsp27))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp112 := yyvsp112 + 1
	yyvsp5 := yyvsp5 -1
	yyvsp13 := yyvsp13 -1
	yyvsp27 := yyvsp27 -1
	if yyvsp112 >= yyvsc112 then
		if yyvs112 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs112")
			end
			create yyspecial_routines112
			yyvsc112 := yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.make (yyvsc112)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs112")
			end
			yyvsc112 := yyvsc112 + yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.resize (yyvs112, yyvsc112)
		end
	end
	yyvs112.put (yyval112, yyvsp112)
end
		end

	yy_do_action_460 is
			--|#line 2620 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2620 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2620")
end

			if current_system.is_ise and then current_system.ise_version < ise_6_1_0 then
				raise_error
			else
				yyval112 := new_tuple_type (yyvs24.item (yyvsp24), yyvs13.item (yyvsp13), yyvs27.item (yyvsp27))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp112 := yyvsp112 + 1
	yyvsp24 := yyvsp24 -1
	yyvsp13 := yyvsp13 -1
	yyvsp27 := yyvsp27 -1
	if yyvsp112 >= yyvsc112 then
		if yyvs112 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs112")
			end
			create yyspecial_routines112
			yyvsc112 := yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.make (yyvsc112)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs112")
			end
			yyvsc112 := yyvsc112 + yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.resize (yyvs112, yyvsc112)
		end
	end
	yyvs112.put (yyval112, yyvsp112)
end
		end

	yy_do_action_461 is
			--|#line 2630 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2630 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2630")
end

yyval112 := new_named_type (Void, yyvs13.item (yyvsp13), Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp112 := yyvsp112 + 1
	yyvsp13 := yyvsp13 -1
	if yyvsp112 >= yyvsc112 then
		if yyvs112 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs112")
			end
			create yyspecial_routines112
			yyvsc112 := yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.make (yyvsc112)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs112")
			end
			yyvsc112 := yyvsc112 + yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.resize (yyvs112, yyvsc112)
		end
	end
	yyvs112.put (yyval112, yyvsp112)
end
		end

	yy_do_action_462 is
			--|#line 2632 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2632 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2632")
end

yyval112 := new_named_type (Void, yyvs13.item (yyvsp13), yyvs27.item (yyvsp27)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp112 := yyvsp112 + 1
	yyvsp13 := yyvsp13 -1
	yyvsp27 := yyvsp27 -1
	if yyvsp112 >= yyvsc112 then
		if yyvs112 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs112")
			end
			create yyspecial_routines112
			yyvsc112 := yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.make (yyvsc112)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs112")
			end
			yyvsc112 := yyvsc112 + yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.resize (yyvs112, yyvsc112)
		end
	end
	yyvs112.put (yyval112, yyvsp112)
end
		end

	yy_do_action_463 is
			--|#line 2634 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2634 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2634")
end

yyval112 := new_named_type (yyvs2.item (yyvsp2), yyvs13.item (yyvsp13), yyvs27.item (yyvsp27)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp112 := yyvsp112 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp13 := yyvsp13 -1
	yyvsp27 := yyvsp27 -1
	if yyvsp112 >= yyvsc112 then
		if yyvs112 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs112")
			end
			create yyspecial_routines112
			yyvsc112 := yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.make (yyvsc112)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs112")
			end
			yyvsc112 := yyvsc112 + yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.resize (yyvs112, yyvsc112)
		end
	end
	yyvs112.put (yyval112, yyvsp112)
end
		end

	yy_do_action_464 is
			--|#line 2636 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2636 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2636")
end

yyval112 := new_named_type (yyvs2.item (yyvsp2), yyvs13.item (yyvsp13), yyvs27.item (yyvsp27)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp112 := yyvsp112 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp13 := yyvsp13 -1
	yyvsp27 := yyvsp27 -1
	if yyvsp112 >= yyvsc112 then
		if yyvs112 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs112")
			end
			create yyspecial_routines112
			yyvsc112 := yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.make (yyvsc112)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs112")
			end
			yyvsc112 := yyvsc112 + yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.resize (yyvs112, yyvsc112)
		end
	end
	yyvs112.put (yyval112, yyvsp112)
end
		end

	yy_do_action_465 is
			--|#line 2638 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2638 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2638")
end

yyval112 := new_named_type (yyvs2.item (yyvsp2), yyvs13.item (yyvsp13), yyvs27.item (yyvsp27)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp112 := yyvsp112 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp13 := yyvsp13 -1
	yyvsp27 := yyvsp27 -1
	if yyvsp112 >= yyvsc112 then
		if yyvs112 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs112")
			end
			create yyspecial_routines112
			yyvsc112 := yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.make (yyvsc112)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs112")
			end
			yyvsc112 := yyvsc112 + yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.resize (yyvs112, yyvsc112)
		end
	end
	yyvs112.put (yyval112, yyvsp112)
end
		end

	yy_do_action_466 is
			--|#line 2640 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2640 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2640")
end

			if current_system.is_ise and then current_system.ise_version < ise_6_1_0 then
				raise_error
			else
				yyval112 := new_named_type (yyvs5.item (yyvsp5), yyvs13.item (yyvsp13), yyvs27.item (yyvsp27))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp112 := yyvsp112 + 1
	yyvsp5 := yyvsp5 -1
	yyvsp13 := yyvsp13 -1
	yyvsp27 := yyvsp27 -1
	if yyvsp112 >= yyvsc112 then
		if yyvs112 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs112")
			end
			create yyspecial_routines112
			yyvsc112 := yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.make (yyvsc112)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs112")
			end
			yyvsc112 := yyvsc112 + yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.resize (yyvs112, yyvsc112)
		end
	end
	yyvs112.put (yyval112, yyvsp112)
end
		end

	yy_do_action_467 is
			--|#line 2648 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2648 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2648")
end

			if current_system.is_ise and then current_system.ise_version < ise_6_1_0 then
				raise_error
			else
				yyval112 := new_named_type (yyvs24.item (yyvsp24), yyvs13.item (yyvsp13), yyvs27.item (yyvsp27))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp112 := yyvsp112 + 1
	yyvsp24 := yyvsp24 -1
	yyvsp13 := yyvsp13 -1
	yyvsp27 := yyvsp27 -1
	if yyvsp112 >= yyvsc112 then
		if yyvs112 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs112")
			end
			create yyspecial_routines112
			yyvsc112 := yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.make (yyvsc112)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs112")
			end
			yyvsc112 := yyvsc112 + yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.resize (yyvs112, yyvsc112)
		end
	end
	yyvs112.put (yyval112, yyvsp112)
end
		end

	yy_do_action_468 is
			--|#line 2656 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2656 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2656")
end

yyval112 := yyvs88.item (yyvsp88) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp112 := yyvsp112 + 1
	yyvsp88 := yyvsp88 -1
	if yyvsp112 >= yyvsc112 then
		if yyvs112 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs112")
			end
			create yyspecial_routines112
			yyvsc112 := yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.make (yyvsc112)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs112")
			end
			yyvsc112 := yyvsc112 + yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.resize (yyvs112, yyvsc112)
		end
	end
	yyvs112.put (yyval112, yyvsp112)
end
		end

	yy_do_action_469 is
			--|#line 2658 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2658 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2658")
end

yyval112 := new_bit_n (yyvs13.item (yyvsp13), yyvs14.item (yyvsp14)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp112 := yyvsp112 + 1
	yyvsp13 := yyvsp13 -1
	yyvsp14 := yyvsp14 -1
	if yyvsp112 >= yyvsc112 then
		if yyvs112 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs112")
			end
			create yyspecial_routines112
			yyvsc112 := yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.make (yyvsc112)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs112")
			end
			yyvsc112 := yyvsc112 + yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.resize (yyvs112, yyvsc112)
		end
	end
	yyvs112.put (yyval112, yyvsp112)
end
		end

	yy_do_action_470 is
			--|#line 2660 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2660 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2660")
end

yyval112 := new_bit_feature (yyvs13.item (yyvsp13 - 1), yyvs13.item (yyvsp13))  
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp112 := yyvsp112 + 1
	yyvsp13 := yyvsp13 -2
	if yyvsp112 >= yyvsc112 then
		if yyvs112 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs112")
			end
			create yyspecial_routines112
			yyvsc112 := yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.make (yyvsc112)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs112")
			end
			yyvsc112 := yyvsc112 + yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.resize (yyvs112, yyvsc112)
		end
	end
	yyvs112.put (yyval112, yyvsp112)
end
		end

	yy_do_action_471 is
			--|#line 2662 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2662 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2662")
end

yyval112 := new_tuple_type (Void, yyvs13.item (yyvsp13), yyvs27.item (yyvsp27)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp112 := yyvsp112 + 1
	yyvsp13 := yyvsp13 -1
	yyvsp27 := yyvsp27 -1
	if yyvsp112 >= yyvsc112 then
		if yyvs112 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs112")
			end
			create yyspecial_routines112
			yyvsc112 := yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.make (yyvsc112)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs112")
			end
			yyvsc112 := yyvsc112 + yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.resize (yyvs112, yyvsc112)
		end
	end
	yyvs112.put (yyval112, yyvsp112)
end
		end

	yy_do_action_472 is
			--|#line 2664 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2664 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2664")
end

			if current_system.is_ise and then current_system.ise_version < ise_6_1_0 then
				raise_error
			else
				yyval112 := new_tuple_type (yyvs5.item (yyvsp5), yyvs13.item (yyvsp13), yyvs27.item (yyvsp27))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp112 := yyvsp112 + 1
	yyvsp5 := yyvsp5 -1
	yyvsp13 := yyvsp13 -1
	yyvsp27 := yyvsp27 -1
	if yyvsp112 >= yyvsc112 then
		if yyvs112 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs112")
			end
			create yyspecial_routines112
			yyvsc112 := yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.make (yyvsc112)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs112")
			end
			yyvsc112 := yyvsc112 + yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.resize (yyvs112, yyvsc112)
		end
	end
	yyvs112.put (yyval112, yyvsp112)
end
		end

	yy_do_action_473 is
			--|#line 2672 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2672 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2672")
end

			if current_system.is_ise and then current_system.ise_version < ise_6_1_0 then
				raise_error
			else
				yyval112 := new_tuple_type (yyvs24.item (yyvsp24), yyvs13.item (yyvsp13), yyvs27.item (yyvsp27))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp112 := yyvsp112 + 1
	yyvsp24 := yyvsp24 -1
	yyvsp13 := yyvsp13 -1
	yyvsp27 := yyvsp27 -1
	if yyvsp112 >= yyvsc112 then
		if yyvs112 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs112")
			end
			create yyspecial_routines112
			yyvsc112 := yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.make (yyvsc112)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs112")
			end
			yyvsc112 := yyvsc112 + yyInitial_yyvs_size
			yyvs112 := yyspecial_routines112.resize (yyvs112, yyvsc112)
		end
	end
	yyvs112.put (yyval112, yyvsp112)
end
		end

	yy_do_action_474 is
			--|#line 2682 "et_eiffel_parser.y"
		local
			yyval13: ET_IDENTIFIER
		do
--|#line 2682 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2682")
end

yyval13 := yyvs13.item (yyvsp13) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs13.put (yyval13, yyvsp13)
end
		end

	yy_do_action_475 is
			--|#line 2686 "et_eiffel_parser.y"
		local
			yyval27: ET_ACTUAL_PARAMETER_LIST
		do
--|#line 2686 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2686")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp27 := yyvsp27 + 1
	if yyvsp27 >= yyvsc27 then
		if yyvs27 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs27")
			end
			create yyspecial_routines27
			yyvsc27 := yyInitial_yyvs_size
			yyvs27 := yyspecial_routines27.make (yyvsc27)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs27")
			end
			yyvsc27 := yyvsc27 + yyInitial_yyvs_size
			yyvs27 := yyspecial_routines27.resize (yyvs27, yyvsc27)
		end
	end
	yyvs27.put (yyval27, yyvsp27)
end
		end

	yy_do_action_476 is
			--|#line 2688 "et_eiffel_parser.y"
		local
			yyval27: ET_ACTUAL_PARAMETER_LIST
		do
--|#line 2688 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2688")
end

yyval27 := yyvs27.item (yyvsp27) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs27.put (yyval27, yyvsp27)
end
		end

	yy_do_action_477 is
			--|#line 2692 "et_eiffel_parser.y"
		local
			yyval27: ET_ACTUAL_PARAMETER_LIST
		do
--|#line 2692 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2692")
end

yyval27 := ast_factory.new_actual_parameters (yyvs23.item (yyvsp23), yyvs5.item (yyvsp5), 0) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp27 := yyvsp27 + 1
	yyvsp23 := yyvsp23 -1
	yyvsp5 := yyvsp5 -1
	if yyvsp27 >= yyvsc27 then
		if yyvs27 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs27")
			end
			create yyspecial_routines27
			yyvsc27 := yyInitial_yyvs_size
			yyvs27 := yyspecial_routines27.make (yyvsc27)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs27")
			end
			yyvsc27 := yyvsc27 + yyInitial_yyvs_size
			yyvs27 := yyspecial_routines27.resize (yyvs27, yyvsc27)
		end
	end
	yyvs27.put (yyval27, yyvsp27)
end
		end

	yy_do_action_478 is
			--|#line 2695 "et_eiffel_parser.y"
		local
			yyval27: ET_ACTUAL_PARAMETER_LIST
		do
--|#line 2695 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2695")
end

			yyval27 := yyvs27.item (yyvsp27)
			remove_symbol
			remove_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs27.put (yyval27, yyvsp27)
end
		end

	yy_do_action_479 is
			--|#line 2703 "et_eiffel_parser.y"
		local
			yyval1: ANY
		do
--|#line 2703 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2703")
end

			add_symbol (yyvs23.item (yyvsp23))
			add_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp1 := yyvsp1 + 1
	yyvsp23 := yyvsp23 -1
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
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_480 is
			--|#line 2710 "et_eiffel_parser.y"
		local
			yyval27: ET_ACTUAL_PARAMETER_LIST
		do
--|#line 2710 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2710")
end

			if yyvs112.item (yyvsp112) /= Void then
				yyval27 := ast_factory.new_actual_parameters (last_symbol, yyvs5.item (yyvsp5), counter_value + 1)
				if yyval27 /= Void then
					yyval27.put_first (yyvs112.item (yyvsp112))
				end
			else
				yyval27 := ast_factory.new_actual_parameters (last_symbol, yyvs5.item (yyvsp5), counter_value)
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp27 := yyvsp27 + 1
	yyvsp112 := yyvsp112 -1
	yyvsp5 := yyvsp5 -1
	if yyvsp27 >= yyvsc27 then
		if yyvs27 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs27")
			end
			create yyspecial_routines27
			yyvsc27 := yyInitial_yyvs_size
			yyvs27 := yyspecial_routines27.make (yyvsc27)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs27")
			end
			yyvsc27 := yyvsc27 + yyInitial_yyvs_size
			yyvs27 := yyspecial_routines27.resize (yyvs27, yyvsc27)
		end
	end
	yyvs27.put (yyval27, yyvsp27)
end
		end

	yy_do_action_481 is
			--|#line 2721 "et_eiffel_parser.y"
		local
			yyval27: ET_ACTUAL_PARAMETER_LIST
		do
--|#line 2721 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2721")
end

			yyval27 := yyvs27.item (yyvsp27)
			add_to_actual_parameter_list (yyvs26.item (yyvsp26), yyval27)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp26 := yyvsp26 -1
	yyvs27.put (yyval27, yyvsp27)
end
		end

	yy_do_action_482 is
			--|#line 2726 "et_eiffel_parser.y"
		local
			yyval27: ET_ACTUAL_PARAMETER_LIST
		do
--|#line 2726 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2726")
end

			yyval27 := yyvs27.item (yyvsp27)
			add_to_actual_parameter_list (ast_factory.new_actual_parameter_comma (new_named_type (Void, yyvs13.item (yyvsp13), Void), yyvs5.item (yyvsp5)), yyval27)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp13 := yyvsp13 -1
	yyvsp5 := yyvsp5 -1
	yyvsp1 := yyvsp1 -1
	yyvs27.put (yyval27, yyvsp27)
end
		end

	yy_do_action_483 is
			--|#line 2731 "et_eiffel_parser.y"
		local
			yyval27: ET_ACTUAL_PARAMETER_LIST
		do
--|#line 2731 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2731")
end

			yyval27 := yyvs27.item (yyvsp27)
			add_to_actual_parameter_list (ast_factory.new_actual_parameter_comma (new_tuple_type (Void, yyvs13.item (yyvsp13), Void), yyvs5.item (yyvsp5)), yyval27)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp13 := yyvsp13 -1
	yyvsp5 := yyvsp5 -1
	yyvsp1 := yyvsp1 -1
	yyvs27.put (yyval27, yyvsp27)
end
		end

	yy_do_action_484 is
			--|#line 2738 "et_eiffel_parser.y"
		local
			yyval1: ANY
		do
--|#line 2738 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2738")
end

			increment_counter
		
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
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_485 is
			--|#line 2744 "et_eiffel_parser.y"
		local
			yyval26: ET_ACTUAL_PARAMETER_ITEM
		do
--|#line 2744 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2744")
end

			yyval26 := ast_factory.new_actual_parameter_comma (yyvs112.item (yyvsp112), yyvs5.item (yyvsp5))
			if yyval26 /= Void then
				increment_counter
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp26 := yyvsp26 + 1
	yyvsp112 := yyvsp112 -1
	yyvsp5 := yyvsp5 -1
	if yyvsp26 >= yyvsc26 then
		if yyvs26 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs26")
			end
			create yyspecial_routines26
			yyvsc26 := yyInitial_yyvs_size
			yyvs26 := yyspecial_routines26.make (yyvsc26)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs26")
			end
			yyvsc26 := yyvsc26 + yyInitial_yyvs_size
			yyvs26 := yyspecial_routines26.resize (yyvs26, yyvsc26)
		end
	end
	yyvs26.put (yyval26, yyvsp26)
end
		end

	yy_do_action_486 is
			--|#line 2753 "et_eiffel_parser.y"
		local
			yyval27: ET_ACTUAL_PARAMETER_LIST
		do
--|#line 2753 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2753")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp27 := yyvsp27 + 1
	if yyvsp27 >= yyvsc27 then
		if yyvs27 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs27")
			end
			create yyspecial_routines27
			yyvsc27 := yyInitial_yyvs_size
			yyvs27 := yyspecial_routines27.make (yyvsc27)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs27")
			end
			yyvsc27 := yyvsc27 + yyInitial_yyvs_size
			yyvs27 := yyspecial_routines27.resize (yyvs27, yyvsc27)
		end
	end
	yyvs27.put (yyval27, yyvsp27)
end
		end

	yy_do_action_487 is
			--|#line 2755 "et_eiffel_parser.y"
		local
			yyval27: ET_ACTUAL_PARAMETER_LIST
		do
--|#line 2755 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2755")
end

yyval27 := yyvs27.item (yyvsp27) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs27.put (yyval27, yyvsp27)
end
		end

	yy_do_action_488 is
			--|#line 2759 "et_eiffel_parser.y"
		local
			yyval27: ET_ACTUAL_PARAMETER_LIST
		do
--|#line 2759 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2759")
end

yyval27 := ast_factory.new_actual_parameters (yyvs23.item (yyvsp23), yyvs5.item (yyvsp5), 0) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp27 := yyvsp27 + 1
	yyvsp23 := yyvsp23 -1
	yyvsp5 := yyvsp5 -1
	if yyvsp27 >= yyvsc27 then
		if yyvs27 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs27")
			end
			create yyspecial_routines27
			yyvsc27 := yyInitial_yyvs_size
			yyvs27 := yyspecial_routines27.make (yyvsc27)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs27")
			end
			yyvsc27 := yyvsc27 + yyInitial_yyvs_size
			yyvs27 := yyspecial_routines27.resize (yyvs27, yyvsc27)
		end
	end
	yyvs27.put (yyval27, yyvsp27)
end
		end

	yy_do_action_489 is
			--|#line 2762 "et_eiffel_parser.y"
		local
			yyval27: ET_ACTUAL_PARAMETER_LIST
		do
--|#line 2762 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2762")
end

			yyval27 := yyvs27.item (yyvsp27)
			remove_symbol
			remove_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs27.put (yyval27, yyvsp27)
end
		end

	yy_do_action_490 is
			--|#line 2768 "et_eiffel_parser.y"
		local
			yyval27: ET_ACTUAL_PARAMETER_LIST
		do
--|#line 2768 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2768")
end

			yyval27 := yyvs27.item (yyvsp27)
			remove_symbol
			remove_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs27.put (yyval27, yyvsp27)
end
		end

	yy_do_action_491 is
			--|#line 2776 "et_eiffel_parser.y"
		local
			yyval27: ET_ACTUAL_PARAMETER_LIST
		do
--|#line 2776 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2776")
end

			yyval27 := ast_factory.new_actual_parameters (last_symbol, yyvs5.item (yyvsp5), counter_value + 1)
			add_to_actual_parameter_list (ast_factory.new_labeled_actual_parameter (yyvs13.item (yyvsp13), ast_factory.new_colon_type (yyvs5.item (yyvsp5 - 1), yyvs112.item (yyvsp112))), yyval27)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp27 := yyvsp27 + 1
	yyvsp13 := yyvsp13 -1
	yyvsp5 := yyvsp5 -2
	yyvsp112 := yyvsp112 -1
	if yyvsp27 >= yyvsc27 then
		if yyvs27 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs27")
			end
			create yyspecial_routines27
			yyvsc27 := yyInitial_yyvs_size
			yyvs27 := yyspecial_routines27.make (yyvsc27)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs27")
			end
			yyvsc27 := yyvsc27 + yyInitial_yyvs_size
			yyvs27 := yyspecial_routines27.resize (yyvs27, yyvsc27)
		end
	end
	yyvs27.put (yyval27, yyvsp27)
end
		end

	yy_do_action_492 is
			--|#line 2781 "et_eiffel_parser.y"
		local
			yyval27: ET_ACTUAL_PARAMETER_LIST
		do
--|#line 2781 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2781")
end

			yyval27 := yyvs27.item (yyvsp27)
			add_to_actual_parameter_list (yyvs26.item (yyvsp26), yyvs27.item (yyvsp27))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp26 := yyvsp26 -1
	yyvs27.put (yyval27, yyvsp27)
end
		end

	yy_do_action_493 is
			--|#line 2786 "et_eiffel_parser.y"
		local
			yyval27: ET_ACTUAL_PARAMETER_LIST
		do
--|#line 2786 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2786")
end

			yyval27 := yyvs27.item (yyvsp27)
			add_to_actual_parameter_list (yyvs26.item (yyvsp26), yyvs27.item (yyvsp27))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp26 := yyvsp26 -1
	yyvs27.put (yyval27, yyvsp27)
end
		end

	yy_do_action_494 is
			--|#line 2791 "et_eiffel_parser.y"
		local
			yyval27: ET_ACTUAL_PARAMETER_LIST
		do
--|#line 2791 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2791")
end

			yyval27 := yyvs27.item (yyvsp27)
			if yyval27 /= Void then
				if not yyval27.is_empty then
					add_to_actual_parameter_list (ast_factory.new_labeled_comma_actual_parameter (ast_factory.new_label_comma (yyvs13.item (yyvsp13), yyvs5.item (yyvsp5)), yyval27.first.type), yyval27)
				else
					add_to_actual_parameter_list (ast_factory.new_labeled_comma_actual_parameter (ast_factory.new_label_comma (yyvs13.item (yyvsp13), yyvs5.item (yyvsp5)), Void), yyval27)
				end
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp13 := yyvsp13 -1
	yyvsp5 := yyvsp5 -1
	yyvsp1 := yyvsp1 -1
	yyvs27.put (yyval27, yyvsp27)
end
		end

	yy_do_action_495 is
			--|#line 2802 "et_eiffel_parser.y"
		local
			yyval27: ET_ACTUAL_PARAMETER_LIST
		do
--|#line 2802 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2802")
end

			yyval27 := yyvs27.item (yyvsp27)
			if yyval27 /= Void then
				if not yyval27.is_empty then
					add_to_actual_parameter_list (ast_factory.new_labeled_comma_actual_parameter (ast_factory.new_label_comma (yyvs13.item (yyvsp13), yyvs5.item (yyvsp5)), yyval27.first.type), yyval27)
				else
					add_to_actual_parameter_list (ast_factory.new_labeled_comma_actual_parameter (ast_factory.new_label_comma (yyvs13.item (yyvsp13), yyvs5.item (yyvsp5)), Void), yyval27)
				end
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp13 := yyvsp13 -1
	yyvsp5 := yyvsp5 -1
	yyvsp1 := yyvsp1 -1
	yyvs27.put (yyval27, yyvsp27)
end
		end

	yy_do_action_496 is
			--|#line 2813 "et_eiffel_parser.y"
		local
			yyval27: ET_ACTUAL_PARAMETER_LIST
		do
--|#line 2813 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2813")
end

			yyval27 := yyvs27.item (yyvsp27)
			if yyval27 /= Void then
				if not yyval27.is_empty then
					add_to_actual_parameter_list (ast_factory.new_labeled_comma_actual_parameter (ast_factory.new_label_comma (yyvs13.item (yyvsp13), yyvs5.item (yyvsp5)), yyval27.first.type), yyval27)
				else
					add_to_actual_parameter_list (ast_factory.new_labeled_comma_actual_parameter (ast_factory.new_label_comma (yyvs13.item (yyvsp13), yyvs5.item (yyvsp5)), Void), yyval27)
				end
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp13 := yyvsp13 -1
	yyvsp5 := yyvsp5 -1
	yyvsp1 := yyvsp1 -1
	yyvs27.put (yyval27, yyvsp27)
end
		end

	yy_do_action_497 is
			--|#line 2826 "et_eiffel_parser.y"
		local
			yyval26: ET_ACTUAL_PARAMETER_ITEM
		do
--|#line 2826 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2826")
end

			yyval26 := ast_factory.new_labeled_actual_parameter (yyvs13.item (yyvsp13), ast_factory.new_colon_type (yyvs5.item (yyvsp5), yyvs112.item (yyvsp112)))
			if yyval26 /= Void then
				increment_counter
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp26 := yyvsp26 + 1
	yyvsp13 := yyvsp13 -1
	yyvsp5 := yyvsp5 -1
	yyvsp112 := yyvsp112 -1
	if yyvsp26 >= yyvsc26 then
		if yyvs26 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs26")
			end
			create yyspecial_routines26
			yyvsc26 := yyInitial_yyvs_size
			yyvs26 := yyspecial_routines26.make (yyvsc26)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs26")
			end
			yyvsc26 := yyvsc26 + yyInitial_yyvs_size
			yyvs26 := yyspecial_routines26.resize (yyvs26, yyvsc26)
		end
	end
	yyvs26.put (yyval26, yyvsp26)
end
		end

	yy_do_action_498 is
			--|#line 2835 "et_eiffel_parser.y"
		local
			yyval26: ET_ACTUAL_PARAMETER_ITEM
		do
--|#line 2835 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2835")
end

			yyval26 := ast_factory.new_labeled_actual_parameter_semicolon (ast_factory.new_labeled_actual_parameter (yyvs13.item (yyvsp13), ast_factory.new_colon_type (yyvs5.item (yyvsp5), yyvs112.item (yyvsp112))), yyvs22.item (yyvsp22))
			if yyval26 /= Void then
				increment_counter
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp26 := yyvsp26 + 1
	yyvsp13 := yyvsp13 -1
	yyvsp5 := yyvsp5 -1
	yyvsp112 := yyvsp112 -1
	yyvsp22 := yyvsp22 -1
	if yyvsp26 >= yyvsc26 then
		if yyvs26 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs26")
			end
			create yyspecial_routines26
			yyvsc26 := yyInitial_yyvs_size
			yyvs26 := yyspecial_routines26.make (yyvsc26)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs26")
			end
			yyvsc26 := yyvsc26 + yyInitial_yyvs_size
			yyvs26 := yyspecial_routines26.resize (yyvs26, yyvsc26)
		end
	end
	yyvs26.put (yyval26, yyvsp26)
end
		end

	yy_do_action_499 is
			--|#line 2844 "et_eiffel_parser.y"
		local
			yyval88: ET_LIKE_TYPE
		do
--|#line 2844 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2844")
end

yyval88 := ast_factory.new_like_feature (Void, yyvs2.item (yyvsp2), yyvs13.item (yyvsp13)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp88 := yyvsp88 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp13 := yyvsp13 -1
	if yyvsp88 >= yyvsc88 then
		if yyvs88 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs88")
			end
			create yyspecial_routines88
			yyvsc88 := yyInitial_yyvs_size
			yyvs88 := yyspecial_routines88.make (yyvsc88)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs88")
			end
			yyvsc88 := yyvsc88 + yyInitial_yyvs_size
			yyvs88 := yyspecial_routines88.resize (yyvs88, yyvsc88)
		end
	end
	yyvs88.put (yyval88, yyvsp88)
end
		end

	yy_do_action_500 is
			--|#line 2846 "et_eiffel_parser.y"
		local
			yyval88: ET_LIKE_TYPE
		do
--|#line 2846 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2846")
end

			if current_system.is_ise and then current_system.ise_version < ise_6_1_0 then
				raise_error
			else
				yyval88 := ast_factory.new_like_feature (yyvs5.item (yyvsp5), yyvs2.item (yyvsp2), yyvs13.item (yyvsp13))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp88 := yyvsp88 + 1
	yyvsp5 := yyvsp5 -1
	yyvsp2 := yyvsp2 -1
	yyvsp13 := yyvsp13 -1
	if yyvsp88 >= yyvsc88 then
		if yyvs88 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs88")
			end
			create yyspecial_routines88
			yyvsc88 := yyInitial_yyvs_size
			yyvs88 := yyspecial_routines88.make (yyvsc88)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs88")
			end
			yyvsc88 := yyvsc88 + yyInitial_yyvs_size
			yyvs88 := yyspecial_routines88.resize (yyvs88, yyvsc88)
		end
	end
	yyvs88.put (yyval88, yyvsp88)
end
		end

	yy_do_action_501 is
			--|#line 2854 "et_eiffel_parser.y"
		local
			yyval88: ET_LIKE_TYPE
		do
--|#line 2854 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2854")
end

			if current_system.is_ise and then current_system.ise_version < ise_6_1_0 then
				raise_error
			else
				yyval88 := ast_factory.new_like_feature (yyvs24.item (yyvsp24), yyvs2.item (yyvsp2), yyvs13.item (yyvsp13))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp88 := yyvsp88 + 1
	yyvsp24 := yyvsp24 -1
	yyvsp2 := yyvsp2 -1
	yyvsp13 := yyvsp13 -1
	if yyvsp88 >= yyvsc88 then
		if yyvs88 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs88")
			end
			create yyspecial_routines88
			yyvsc88 := yyInitial_yyvs_size
			yyvs88 := yyspecial_routines88.make (yyvsc88)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs88")
			end
			yyvsc88 := yyvsc88 + yyInitial_yyvs_size
			yyvs88 := yyspecial_routines88.resize (yyvs88, yyvsc88)
		end
	end
	yyvs88.put (yyval88, yyvsp88)
end
		end

	yy_do_action_502 is
			--|#line 2862 "et_eiffel_parser.y"
		local
			yyval88: ET_LIKE_TYPE
		do
--|#line 2862 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2862")
end

yyval88 := ast_factory.new_like_current (Void, yyvs2.item (yyvsp2), yyvs11.item (yyvsp11)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp88 := yyvsp88 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp11 := yyvsp11 -1
	if yyvsp88 >= yyvsc88 then
		if yyvs88 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs88")
			end
			create yyspecial_routines88
			yyvsc88 := yyInitial_yyvs_size
			yyvs88 := yyspecial_routines88.make (yyvsc88)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs88")
			end
			yyvsc88 := yyvsc88 + yyInitial_yyvs_size
			yyvs88 := yyspecial_routines88.resize (yyvs88, yyvsc88)
		end
	end
	yyvs88.put (yyval88, yyvsp88)
end
		end

	yy_do_action_503 is
			--|#line 2864 "et_eiffel_parser.y"
		local
			yyval88: ET_LIKE_TYPE
		do
--|#line 2864 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2864")
end

			if current_system.is_ise and then current_system.ise_version < ise_6_1_0 then
				raise_error
			else
				yyval88 := ast_factory.new_like_current (yyvs5.item (yyvsp5), yyvs2.item (yyvsp2), yyvs11.item (yyvsp11))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp88 := yyvsp88 + 1
	yyvsp5 := yyvsp5 -1
	yyvsp2 := yyvsp2 -1
	yyvsp11 := yyvsp11 -1
	if yyvsp88 >= yyvsc88 then
		if yyvs88 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs88")
			end
			create yyspecial_routines88
			yyvsc88 := yyInitial_yyvs_size
			yyvs88 := yyspecial_routines88.make (yyvsc88)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs88")
			end
			yyvsc88 := yyvsc88 + yyInitial_yyvs_size
			yyvs88 := yyspecial_routines88.resize (yyvs88, yyvsc88)
		end
	end
	yyvs88.put (yyval88, yyvsp88)
end
		end

	yy_do_action_504 is
			--|#line 2872 "et_eiffel_parser.y"
		local
			yyval88: ET_LIKE_TYPE
		do
--|#line 2872 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2872")
end

			if current_system.is_ise and then current_system.ise_version < ise_6_1_0 then
				raise_error
			else
				yyval88 := ast_factory.new_like_current (yyvs24.item (yyvsp24), yyvs2.item (yyvsp2), yyvs11.item (yyvsp11))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp88 := yyvsp88 + 1
	yyvsp24 := yyvsp24 -1
	yyvsp2 := yyvsp2 -1
	yyvsp11 := yyvsp11 -1
	if yyvsp88 >= yyvsc88 then
		if yyvs88 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs88")
			end
			create yyspecial_routines88
			yyvsc88 := yyInitial_yyvs_size
			yyvs88 := yyspecial_routines88.make (yyvsc88)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs88")
			end
			yyvsc88 := yyvsc88 + yyInitial_yyvs_size
			yyvs88 := yyspecial_routines88.resize (yyvs88, yyvsc88)
		end
	end
	yyvs88.put (yyval88, yyvsp88)
end
		end

	yy_do_action_505 is
			--|#line 2880 "et_eiffel_parser.y"
		local
			yyval88: ET_LIKE_TYPE
		do
--|#line 2880 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2880")
end

yyval88 := yyvs106.item (yyvsp106) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp88 := yyvsp88 + 1
	yyvsp106 := yyvsp106 -1
	if yyvsp88 >= yyvsc88 then
		if yyvs88 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs88")
			end
			create yyspecial_routines88
			yyvsc88 := yyInitial_yyvs_size
			yyvs88 := yyspecial_routines88.make (yyvsc88)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs88")
			end
			yyvsc88 := yyvsc88 + yyInitial_yyvs_size
			yyvs88 := yyspecial_routines88.resize (yyvs88, yyvsc88)
		end
	end
	yyvs88.put (yyval88, yyvsp88)
end
		end

	yy_do_action_506 is
			--|#line 2884 "et_eiffel_parser.y"
		local
			yyval106: ET_QUALIFIED_LIKE_IDENTIFIER
		do
--|#line 2884 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2884")
end

			if not current_system.qualified_anchored_types_enabled then
				raise_error
			else
				yyval106 := ast_factory.new_qualified_like_braced_type (Void, yyvs2.item (yyvsp2), ast_factory.new_target_type (yyvs5.item (yyvsp5 - 2), yyvs112.item (yyvsp112), yyvs5.item (yyvsp5 - 1)), ast_factory.new_dot_feature_name (yyvs5.item (yyvsp5), yyvs13.item (yyvsp13)))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp106 := yyvsp106 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp5 := yyvsp5 -3
	yyvsp112 := yyvsp112 -1
	yyvsp13 := yyvsp13 -1
	if yyvsp106 >= yyvsc106 then
		if yyvs106 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs106")
			end
			create yyspecial_routines106
			yyvsc106 := yyInitial_yyvs_size
			yyvs106 := yyspecial_routines106.make (yyvsc106)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs106")
			end
			yyvsc106 := yyvsc106 + yyInitial_yyvs_size
			yyvs106 := yyspecial_routines106.resize (yyvs106, yyvsc106)
		end
	end
	yyvs106.put (yyval106, yyvsp106)
end
		end

	yy_do_action_507 is
			--|#line 2892 "et_eiffel_parser.y"
		local
			yyval106: ET_QUALIFIED_LIKE_IDENTIFIER
		do
--|#line 2892 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2892")
end

			if not current_system.qualified_anchored_types_enabled then
				raise_error
			elseif current_system.is_ise and then current_system.ise_version < ise_6_1_0 then
				raise_error
			else
				yyval106 := ast_factory.new_qualified_like_braced_type (yyvs5.item (yyvsp5 - 3), yyvs2.item (yyvsp2), ast_factory.new_target_type (yyvs5.item (yyvsp5 - 2), yyvs112.item (yyvsp112), yyvs5.item (yyvsp5 - 1)), ast_factory.new_dot_feature_name (yyvs5.item (yyvsp5), yyvs13.item (yyvsp13)))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp106 := yyvsp106 + 1
	yyvsp5 := yyvsp5 -4
	yyvsp2 := yyvsp2 -1
	yyvsp112 := yyvsp112 -1
	yyvsp13 := yyvsp13 -1
	if yyvsp106 >= yyvsc106 then
		if yyvs106 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs106")
			end
			create yyspecial_routines106
			yyvsc106 := yyInitial_yyvs_size
			yyvs106 := yyspecial_routines106.make (yyvsc106)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs106")
			end
			yyvsc106 := yyvsc106 + yyInitial_yyvs_size
			yyvs106 := yyspecial_routines106.resize (yyvs106, yyvsc106)
		end
	end
	yyvs106.put (yyval106, yyvsp106)
end
		end

	yy_do_action_508 is
			--|#line 2902 "et_eiffel_parser.y"
		local
			yyval106: ET_QUALIFIED_LIKE_IDENTIFIER
		do
--|#line 2902 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2902")
end

			if not current_system.qualified_anchored_types_enabled then
				raise_error
			elseif current_system.is_ise and then current_system.ise_version < ise_6_1_0 then
				raise_error
			else
				yyval106 := ast_factory.new_qualified_like_braced_type (yyvs24.item (yyvsp24), yyvs2.item (yyvsp2), ast_factory.new_target_type (yyvs5.item (yyvsp5 - 2), yyvs112.item (yyvsp112), yyvs5.item (yyvsp5 - 1)), ast_factory.new_dot_feature_name (yyvs5.item (yyvsp5), yyvs13.item (yyvsp13)))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp106 := yyvsp106 + 1
	yyvsp24 := yyvsp24 -1
	yyvsp2 := yyvsp2 -1
	yyvsp5 := yyvsp5 -3
	yyvsp112 := yyvsp112 -1
	yyvsp13 := yyvsp13 -1
	if yyvsp106 >= yyvsc106 then
		if yyvs106 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs106")
			end
			create yyspecial_routines106
			yyvsc106 := yyInitial_yyvs_size
			yyvs106 := yyspecial_routines106.make (yyvsc106)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs106")
			end
			yyvsc106 := yyvsc106 + yyInitial_yyvs_size
			yyvs106 := yyspecial_routines106.resize (yyvs106, yyvsc106)
		end
	end
	yyvs106.put (yyval106, yyvsp106)
end
		end

	yy_do_action_509 is
			--|#line 2912 "et_eiffel_parser.y"
		local
			yyval106: ET_QUALIFIED_LIKE_IDENTIFIER
		do
--|#line 2912 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2912")
end

			if not current_system.qualified_anchored_types_enabled then
				raise_error
			else
				yyval106 := ast_factory.new_qualified_like_type (yyvs88.item (yyvsp88), ast_factory.new_dot_feature_name (yyvs5.item (yyvsp5), yyvs13.item (yyvsp13)))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp106 := yyvsp106 + 1
	yyvsp88 := yyvsp88 -1
	yyvsp5 := yyvsp5 -1
	yyvsp13 := yyvsp13 -1
	if yyvsp106 >= yyvsc106 then
		if yyvs106 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs106")
			end
			create yyspecial_routines106
			yyvsc106 := yyInitial_yyvs_size
			yyvs106 := yyspecial_routines106.make (yyvsc106)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs106")
			end
			yyvsc106 := yyvsc106 + yyInitial_yyvs_size
			yyvs106 := yyspecial_routines106.resize (yyvs106, yyvsc106)
		end
	end
	yyvs106.put (yyval106, yyvsp106)
end
		end

	yy_do_action_510 is
			--|#line 2924 "et_eiffel_parser.y"
		local
			yyval45: ET_COMPOUND
		do
--|#line 2924 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2924")
end

yyval45 := ast_factory.new_do_compound (yyvs2.item (yyvsp2), ast_factory.new_compound (0)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp45 := yyvsp45 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp45 >= yyvsc45 then
		if yyvs45 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs45")
			end
			create yyspecial_routines45
			yyvsc45 := yyInitial_yyvs_size
			yyvs45 := yyspecial_routines45.make (yyvsc45)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs45")
			end
			yyvsc45 := yyvsc45 + yyInitial_yyvs_size
			yyvs45 := yyspecial_routines45.resize (yyvs45, yyvsc45)
		end
	end
	yyvs45.put (yyval45, yyvsp45)
end
		end

	yy_do_action_511 is
			--|#line 2926 "et_eiffel_parser.y"
		local
			yyval45: ET_COMPOUND
		do
--|#line 2926 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2926")
end

			yyval45 := ast_factory.new_do_compound (yyvs2.item (yyvsp2), yyvs45.item (yyvsp45))
			remove_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -1
	yyvs45.put (yyval45, yyvsp45)
end
		end

	yy_do_action_512 is
			--|#line 2933 "et_eiffel_parser.y"
		local
			yyval45: ET_COMPOUND
		do
--|#line 2933 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2933")
end

yyval45 := ast_factory.new_once_compound (yyvs2.item (yyvsp2), ast_factory.new_compound (0)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp45 := yyvsp45 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp45 >= yyvsc45 then
		if yyvs45 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs45")
			end
			create yyspecial_routines45
			yyvsc45 := yyInitial_yyvs_size
			yyvs45 := yyspecial_routines45.make (yyvsc45)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs45")
			end
			yyvsc45 := yyvsc45 + yyInitial_yyvs_size
			yyvs45 := yyspecial_routines45.resize (yyvs45, yyvsc45)
		end
	end
	yyvs45.put (yyval45, yyvsp45)
end
		end

	yy_do_action_513 is
			--|#line 2935 "et_eiffel_parser.y"
		local
			yyval45: ET_COMPOUND
		do
--|#line 2935 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2935")
end

			yyval45 := ast_factory.new_once_compound (yyvs2.item (yyvsp2), yyvs45.item (yyvsp45))
			remove_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -1
	yyvs45.put (yyval45, yyvsp45)
end
		end

	yy_do_action_514 is
			--|#line 2942 "et_eiffel_parser.y"
		local
			yyval45: ET_COMPOUND
		do
--|#line 2942 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2942")
end

yyval45 := ast_factory.new_then_compound (yyvs2.item (yyvsp2), ast_factory.new_compound (0)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp45 := yyvsp45 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp45 >= yyvsc45 then
		if yyvs45 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs45")
			end
			create yyspecial_routines45
			yyvsc45 := yyInitial_yyvs_size
			yyvs45 := yyspecial_routines45.make (yyvsc45)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs45")
			end
			yyvsc45 := yyvsc45 + yyInitial_yyvs_size
			yyvs45 := yyspecial_routines45.resize (yyvs45, yyvsc45)
		end
	end
	yyvs45.put (yyval45, yyvsp45)
end
		end

	yy_do_action_515 is
			--|#line 2944 "et_eiffel_parser.y"
		local
			yyval45: ET_COMPOUND
		do
--|#line 2944 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2944")
end

			yyval45 := ast_factory.new_then_compound (yyvs2.item (yyvsp2), yyvs45.item (yyvsp45))
			remove_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -1
	yyvs45.put (yyval45, yyvsp45)
end
		end

	yy_do_action_516 is
			--|#line 2951 "et_eiffel_parser.y"
		local
			yyval45: ET_COMPOUND
		do
--|#line 2951 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2951")
end

yyval45 := ast_factory.new_else_compound (yyvs2.item (yyvsp2), ast_factory.new_compound (0)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp45 := yyvsp45 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp45 >= yyvsc45 then
		if yyvs45 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs45")
			end
			create yyspecial_routines45
			yyvsc45 := yyInitial_yyvs_size
			yyvs45 := yyspecial_routines45.make (yyvsc45)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs45")
			end
			yyvsc45 := yyvsc45 + yyInitial_yyvs_size
			yyvs45 := yyspecial_routines45.resize (yyvs45, yyvsc45)
		end
	end
	yyvs45.put (yyval45, yyvsp45)
end
		end

	yy_do_action_517 is
			--|#line 2953 "et_eiffel_parser.y"
		local
			yyval45: ET_COMPOUND
		do
--|#line 2953 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2953")
end

			yyval45 := ast_factory.new_else_compound (yyvs2.item (yyvsp2), yyvs45.item (yyvsp45))
			remove_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -1
	yyvs45.put (yyval45, yyvsp45)
end
		end

	yy_do_action_518 is
			--|#line 2960 "et_eiffel_parser.y"
		local
			yyval45: ET_COMPOUND
		do
--|#line 2960 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2960")
end

yyval45 := ast_factory.new_rescue_compound (yyvs2.item (yyvsp2), ast_factory.new_compound (0)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp45 := yyvsp45 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp45 >= yyvsc45 then
		if yyvs45 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs45")
			end
			create yyspecial_routines45
			yyvsc45 := yyInitial_yyvs_size
			yyvs45 := yyspecial_routines45.make (yyvsc45)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs45")
			end
			yyvsc45 := yyvsc45 + yyInitial_yyvs_size
			yyvs45 := yyspecial_routines45.resize (yyvs45, yyvsc45)
		end
	end
	yyvs45.put (yyval45, yyvsp45)
end
		end

	yy_do_action_519 is
			--|#line 2962 "et_eiffel_parser.y"
		local
			yyval45: ET_COMPOUND
		do
--|#line 2962 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2962")
end

			yyval45 := ast_factory.new_rescue_compound (yyvs2.item (yyvsp2), yyvs45.item (yyvsp45))
			remove_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -1
	yyvs45.put (yyval45, yyvsp45)
end
		end

	yy_do_action_520 is
			--|#line 2969 "et_eiffel_parser.y"
		local
			yyval45: ET_COMPOUND
		do
--|#line 2969 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2969")
end

yyval45 := ast_factory.new_from_compound (yyvs2.item (yyvsp2), ast_factory.new_compound (0)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp45 := yyvsp45 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp45 >= yyvsc45 then
		if yyvs45 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs45")
			end
			create yyspecial_routines45
			yyvsc45 := yyInitial_yyvs_size
			yyvs45 := yyspecial_routines45.make (yyvsc45)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs45")
			end
			yyvsc45 := yyvsc45 + yyInitial_yyvs_size
			yyvs45 := yyspecial_routines45.resize (yyvs45, yyvsc45)
		end
	end
	yyvs45.put (yyval45, yyvsp45)
end
		end

	yy_do_action_521 is
			--|#line 2971 "et_eiffel_parser.y"
		local
			yyval45: ET_COMPOUND
		do
--|#line 2971 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2971")
end

			yyval45 := ast_factory.new_from_compound (yyvs2.item (yyvsp2), yyvs45.item (yyvsp45))
			remove_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -1
	yyvs45.put (yyval45, yyvsp45)
end
		end

	yy_do_action_522 is
			--|#line 2978 "et_eiffel_parser.y"
		local
			yyval45: ET_COMPOUND
		do
--|#line 2978 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2978")
end

yyval45 := ast_factory.new_loop_compound (yyvs2.item (yyvsp2), ast_factory.new_compound (0)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp45 := yyvsp45 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp45 >= yyvsc45 then
		if yyvs45 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs45")
			end
			create yyspecial_routines45
			yyvsc45 := yyInitial_yyvs_size
			yyvs45 := yyspecial_routines45.make (yyvsc45)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs45")
			end
			yyvsc45 := yyvsc45 + yyInitial_yyvs_size
			yyvs45 := yyspecial_routines45.resize (yyvs45, yyvsc45)
		end
	end
	yyvs45.put (yyval45, yyvsp45)
end
		end

	yy_do_action_523 is
			--|#line 2980 "et_eiffel_parser.y"
		local
			yyval45: ET_COMPOUND
		do
--|#line 2980 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2980")
end

			yyval45 := ast_factory.new_loop_compound (yyvs2.item (yyvsp2), yyvs45.item (yyvsp45))
			remove_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -1
	yyvs45.put (yyval45, yyvsp45)
end
		end

	yy_do_action_524 is
			--|#line 2987 "et_eiffel_parser.y"
		local
			yyval45: ET_COMPOUND
		do
--|#line 2987 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2987")
end

			if yyvs85.item (yyvsp85) /= Void then
				yyval45 := ast_factory.new_compound (counter_value + 1)
				if yyval45 /= Void then
					yyval45.put_first (yyvs85.item (yyvsp85))
				end
			else
				yyval45 := ast_factory.new_compound (counter_value)
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp45 := yyvsp45 + 1
	yyvsp85 := yyvsp85 -1
	if yyvsp45 >= yyvsc45 then
		if yyvs45 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs45")
			end
			create yyspecial_routines45
			yyvsc45 := yyInitial_yyvs_size
			yyvs45 := yyspecial_routines45.make (yyvsc45)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs45")
			end
			yyvsc45 := yyvsc45 + yyInitial_yyvs_size
			yyvs45 := yyspecial_routines45.resize (yyvs45, yyvsc45)
		end
	end
	yyvs45.put (yyval45, yyvsp45)
end
		end

	yy_do_action_525 is
			--|#line 2998 "et_eiffel_parser.y"
		local
			yyval45: ET_COMPOUND
		do
--|#line 2998 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2998")
end

			yyval45 := yyvs45.item (yyvsp45)
			if yyval45 /= Void and yyvs85.item (yyvsp85) /= Void then
				yyval45.put_first (yyvs85.item (yyvsp85))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp45 := yyvsp45 -1
	yyvsp85 := yyvsp85 -1
	yyvs45.put (yyval45, yyvsp45)
end
		end

	yy_do_action_526 is
			--|#line 2998 "et_eiffel_parser.y"
		local
			yyval45: ET_COMPOUND
		do
--|#line 2998 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2998")
end

			if yyvs85.item (yyvsp85) /= Void then
				increment_counter
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp45 := yyvsp45 + 1
	if yyvsp45 >= yyvsc45 then
		if yyvs45 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs45")
			end
			create yyspecial_routines45
			yyvsc45 := yyInitial_yyvs_size
			yyvs45 := yyspecial_routines45.make (yyvsc45)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs45")
			end
			yyvsc45 := yyvsc45 + yyInitial_yyvs_size
			yyvs45 := yyspecial_routines45.resize (yyvs45, yyvsc45)
		end
	end
	yyvs45.put (yyval45, yyvsp45)
end
		end

	yy_do_action_527 is
			--|#line 3019 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3019 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3019")
end

yyval85 := yyvs85.item (yyvsp85) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs85.put (yyval85, yyvsp85)
end
		end

	yy_do_action_528 is
			--|#line 3021 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3021 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3021")
end

yyval85 := yyvs85.item (yyvsp85) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs85.put (yyval85, yyvsp85)
end
		end

	yy_do_action_529 is
			--|#line 3023 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3023 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3023")
end

yyval85 := yyvs85.item (yyvsp85) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs85.put (yyval85, yyvsp85)
end
		end

	yy_do_action_530 is
			--|#line 3025 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3025 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3025")
end

yyval85 := ast_factory.new_assigner_instruction (yyvs37.item (yyvsp37), yyvs5.item (yyvsp5), yyvs62.item (yyvsp62)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp85 := yyvsp85 + 1
	yyvsp37 := yyvsp37 -1
	yyvsp5 := yyvsp5 -1
	yyvsp62 := yyvsp62 -1
	if yyvsp85 >= yyvsc85 then
		if yyvs85 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs85")
			end
			create yyspecial_routines85
			yyvsc85 := yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.make (yyvsc85)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs85")
			end
			yyvsc85 := yyvsc85 + yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.resize (yyvs85, yyvsc85)
		end
	end
	yyvs85.put (yyval85, yyvsp85)
end
		end

	yy_do_action_531 is
			--|#line 3027 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3027 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3027")
end

yyval85 := ast_factory.new_assigner_instruction (yyvs35.item (yyvsp35), yyvs5.item (yyvsp5), yyvs62.item (yyvsp62)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp85 := yyvsp85 + 1
	yyvsp35 := yyvsp35 -1
	yyvsp5 := yyvsp5 -1
	yyvsp62 := yyvsp62 -1
	if yyvsp85 >= yyvsc85 then
		if yyvs85 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs85")
			end
			create yyspecial_routines85
			yyvsc85 := yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.make (yyvsc85)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs85")
			end
			yyvsc85 := yyvsc85 + yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.resize (yyvs85, yyvsc85)
		end
	end
	yyvs85.put (yyval85, yyvsp85)
end
		end

	yy_do_action_532 is
			--|#line 3029 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3029 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3029")
end

yyval85 := ast_factory.new_assignment (yyvs118.item (yyvsp118), yyvs5.item (yyvsp5), yyvs62.item (yyvsp62)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp85 := yyvsp85 + 1
	yyvsp118 := yyvsp118 -1
	yyvsp5 := yyvsp5 -1
	yyvsp62 := yyvsp62 -1
	if yyvsp85 >= yyvsc85 then
		if yyvs85 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs85")
			end
			create yyspecial_routines85
			yyvsc85 := yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.make (yyvsc85)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs85")
			end
			yyvsc85 := yyvsc85 + yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.resize (yyvs85, yyvsc85)
		end
	end
	yyvs85.put (yyval85, yyvsp85)
end
		end

	yy_do_action_533 is
			--|#line 3031 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3031 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3031")
end

yyval85 := ast_factory.new_assignment_attempt (yyvs118.item (yyvsp118), yyvs5.item (yyvsp5), yyvs62.item (yyvsp62)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp85 := yyvsp85 + 1
	yyvsp118 := yyvsp118 -1
	yyvsp5 := yyvsp5 -1
	yyvsp62 := yyvsp62 -1
	if yyvsp85 >= yyvsc85 then
		if yyvs85 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs85")
			end
			create yyspecial_routines85
			yyvsc85 := yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.make (yyvsc85)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs85")
			end
			yyvsc85 := yyvsc85 + yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.resize (yyvs85, yyvsc85)
		end
	end
	yyvs85.put (yyval85, yyvsp85)
end
		end

	yy_do_action_534 is
			--|#line 3033 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3033 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3033")
end

yyval85 := yyvs77.item (yyvsp77) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp85 := yyvsp85 + 1
	yyvsp77 := yyvsp77 -1
	if yyvsp85 >= yyvsc85 then
		if yyvs85 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs85")
			end
			create yyspecial_routines85
			yyvsc85 := yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.make (yyvsc85)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs85")
			end
			yyvsc85 := yyvsc85 + yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.resize (yyvs85, yyvsc85)
		end
	end
	yyvs85.put (yyval85, yyvsp85)
end
		end

	yy_do_action_535 is
			--|#line 3035 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3035 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3035")
end

yyval85 := yyvs84.item (yyvsp84) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp85 := yyvsp85 + 1
	yyvsp84 := yyvsp84 -1
	if yyvsp85 >= yyvsc85 then
		if yyvs85 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs85")
			end
			create yyspecial_routines85
			yyvsc85 := yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.make (yyvsc85)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs85")
			end
			yyvsc85 := yyvsc85 + yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.resize (yyvs85, yyvsc85)
		end
	end
	yyvs85.put (yyval85, yyvsp85)
end
		end

	yy_do_action_536 is
			--|#line 3037 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3037 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3037")
end

yyval85 := ast_factory.new_loop_instruction_old_syntax (yyvs45.item (yyvsp45 - 1), yyvs92.item (yyvsp92), yyvs115.item (yyvsp115), ast_factory.new_conditional (yyvs2.item (yyvsp2 - 1), yyvs62.item (yyvsp62)), yyvs45.item (yyvsp45), yyvs2.item (yyvsp2)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp85 := yyvsp85 + 1
	yyvsp45 := yyvsp45 -2
	yyvsp92 := yyvsp92 -1
	yyvsp115 := yyvsp115 -1
	yyvsp2 := yyvsp2 -2
	yyvsp62 := yyvsp62 -1
	if yyvsp85 >= yyvsc85 then
		if yyvs85 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs85")
			end
			create yyspecial_routines85
			yyvsc85 := yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.make (yyvsc85)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs85")
			end
			yyvsc85 := yyvsc85 + yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.resize (yyvs85, yyvsc85)
		end
	end
	yyvs85.put (yyval85, yyvsp85)
end
		end

	yy_do_action_537 is
			--|#line 3039 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3039 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3039")
end

			if current_system.is_ise and then current_system.ise_version < ise_6_3_7_4554 then
				yyval85 := ast_factory.new_loop_instruction_old_syntax (yyvs45.item (yyvsp45 - 1), yyvs92.item (yyvsp92), Void, ast_factory.new_conditional (yyvs2.item (yyvsp2 - 1), yyvs62.item (yyvsp62)), yyvs45.item (yyvsp45), yyvs2.item (yyvsp2))
			else
				yyval85 := ast_factory.new_loop_instruction (yyvs45.item (yyvsp45 - 1), yyvs92.item (yyvsp92), ast_factory.new_conditional (yyvs2.item (yyvsp2 - 1), yyvs62.item (yyvsp62)), yyvs45.item (yyvsp45), Void, yyvs2.item (yyvsp2))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp85 := yyvsp85 + 1
	yyvsp45 := yyvsp45 -2
	yyvsp92 := yyvsp92 -1
	yyvsp2 := yyvsp2 -2
	yyvsp62 := yyvsp62 -1
	if yyvsp85 >= yyvsc85 then
		if yyvs85 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs85")
			end
			create yyspecial_routines85
			yyvsc85 := yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.make (yyvsc85)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs85")
			end
			yyvsc85 := yyvsc85 + yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.resize (yyvs85, yyvsc85)
		end
	end
	yyvs85.put (yyval85, yyvsp85)
end
		end

	yy_do_action_538 is
			--|#line 3047 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3047 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3047")
end

			if current_system.is_ise and then current_system.ise_version < ise_6_3_7_4554 then
				raise_error
			else
				yyval85 := ast_factory.new_loop_instruction (yyvs45.item (yyvsp45 - 1), yyvs92.item (yyvsp92), ast_factory.new_conditional (yyvs2.item (yyvsp2 - 1), yyvs62.item (yyvsp62)), yyvs45.item (yyvsp45), yyvs115.item (yyvsp115), yyvs2.item (yyvsp2))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp85 := yyvsp85 + 1
	yyvsp45 := yyvsp45 -2
	yyvsp92 := yyvsp92 -1
	yyvsp2 := yyvsp2 -2
	yyvsp62 := yyvsp62 -1
	yyvsp115 := yyvsp115 -1
	if yyvsp85 >= yyvsc85 then
		if yyvs85 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs85")
			end
			create yyspecial_routines85
			yyvsc85 := yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.make (yyvsc85)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs85")
			end
			yyvsc85 := yyvsc85 + yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.resize (yyvs85, yyvsc85)
		end
	end
	yyvs85.put (yyval85, yyvsp85)
end
		end

	yy_do_action_539 is
			--|#line 3060 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3060 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3060")
end

yyval85 := yyvs57.item (yyvsp57) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp85 := yyvsp85 + 1
	yyvsp57 := yyvsp57 -1
	if yyvsp85 >= yyvsc85 then
		if yyvs85 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs85")
			end
			create yyspecial_routines85
			yyvsc85 := yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.make (yyvsc85)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs85")
			end
			yyvsc85 := yyvsc85 + yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.resize (yyvs85, yyvsc85)
		end
	end
	yyvs85.put (yyval85, yyvsp85)
end
		end

	yy_do_action_540 is
			--|#line 3062 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3062 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3062")
end

yyval85 := new_check_instruction (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp85 := yyvsp85 + 1
	yyvsp2 := yyvsp2 -2
	if yyvsp85 >= yyvsc85 then
		if yyvs85 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs85")
			end
			create yyspecial_routines85
			yyvsc85 := yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.make (yyvsc85)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs85")
			end
			yyvsc85 := yyvsc85 + yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.resize (yyvs85, yyvsc85)
		end
	end
	yyvs85.put (yyval85, yyvsp85)
end
		end

	yy_do_action_541 is
			--|#line 3064 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3064 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3064")
end

yyval85 := new_check_instruction (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp85 := yyvsp85 + 1
	yyvsp2 := yyvsp2 -2
	yyvsp1 := yyvsp1 -1
	if yyvsp85 >= yyvsc85 then
		if yyvs85 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs85")
			end
			create yyspecial_routines85
			yyvsc85 := yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.make (yyvsc85)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs85")
			end
			yyvsc85 := yyvsc85 + yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.resize (yyvs85, yyvsc85)
		end
	end
	yyvs85.put (yyval85, yyvsp85)
end
		end

	yy_do_action_542 is
			--|#line 3066 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3066 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3066")
end

yyval85 := yyvs19.item (yyvsp19) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp85 := yyvsp85 + 1
	yyvsp19 := yyvsp19 -1
	if yyvsp85 >= yyvsc85 then
		if yyvs85 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs85")
			end
			create yyspecial_routines85
			yyvsc85 := yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.make (yyvsc85)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs85")
			end
			yyvsc85 := yyvsc85 + yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.resize (yyvs85, yyvsc85)
		end
	end
	yyvs85.put (yyval85, yyvsp85)
end
		end

	yy_do_action_543 is
			--|#line 3068 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3068 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3068")
end

yyval85 := ast_factory.new_null_instruction (yyvs22.item (yyvsp22)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp85 := yyvsp85 + 1
	yyvsp22 := yyvsp22 -1
	if yyvsp85 >= yyvsc85 then
		if yyvs85 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs85")
			end
			create yyspecial_routines85
			yyvsc85 := yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.make (yyvsc85)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs85")
			end
			yyvsc85 := yyvsc85 + yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.resize (yyvs85, yyvsc85)
		end
	end
	yyvs85.put (yyval85, yyvsp85)
end
		end

	yy_do_action_544 is
			--|#line 3074 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3074 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3074")
end

yyval85 := ast_factory.new_bang_instruction (yyvs5.item (yyvsp5 - 1), yyvs112.item (yyvsp112), yyvs5.item (yyvsp5), yyvs118.item (yyvsp118), Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp85 := yyvsp85 + 1
	yyvsp5 := yyvsp5 -2
	yyvsp112 := yyvsp112 -1
	yyvsp118 := yyvsp118 -1
	if yyvsp85 >= yyvsc85 then
		if yyvs85 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs85")
			end
			create yyspecial_routines85
			yyvsc85 := yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.make (yyvsc85)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs85")
			end
			yyvsc85 := yyvsc85 + yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.resize (yyvs85, yyvsc85)
		end
	end
	yyvs85.put (yyval85, yyvsp85)
end
		end

	yy_do_action_545 is
			--|#line 3076 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3076 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3076")
end

yyval85 := ast_factory.new_bang_instruction (yyvs5.item (yyvsp5 - 2), yyvs112.item (yyvsp112), yyvs5.item (yyvsp5 - 1), yyvs118.item (yyvsp118), ast_factory.new_qualified_call (ast_factory.new_dot_feature_name (yyvs5.item (yyvsp5), yyvs13.item (yyvsp13)), yyvs25.item (yyvsp25))) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp85 := yyvsp85 + 1
	yyvsp5 := yyvsp5 -3
	yyvsp112 := yyvsp112 -1
	yyvsp118 := yyvsp118 -1
	yyvsp13 := yyvsp13 -1
	yyvsp25 := yyvsp25 -1
	if yyvsp85 >= yyvsc85 then
		if yyvs85 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs85")
			end
			create yyspecial_routines85
			yyvsc85 := yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.make (yyvsc85)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs85")
			end
			yyvsc85 := yyvsc85 + yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.resize (yyvs85, yyvsc85)
		end
	end
	yyvs85.put (yyval85, yyvsp85)
end
		end

	yy_do_action_546 is
			--|#line 3078 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3078 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3078")
end

yyval85 := ast_factory.new_bang_instruction (yyvs5.item (yyvsp5 - 1), Void, yyvs5.item (yyvsp5), yyvs118.item (yyvsp118), Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp85 := yyvsp85 + 1
	yyvsp5 := yyvsp5 -2
	yyvsp118 := yyvsp118 -1
	if yyvsp85 >= yyvsc85 then
		if yyvs85 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs85")
			end
			create yyspecial_routines85
			yyvsc85 := yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.make (yyvsc85)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs85")
			end
			yyvsc85 := yyvsc85 + yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.resize (yyvs85, yyvsc85)
		end
	end
	yyvs85.put (yyval85, yyvsp85)
end
		end

	yy_do_action_547 is
			--|#line 3080 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3080 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3080")
end

yyval85 := ast_factory.new_bang_instruction (yyvs5.item (yyvsp5 - 2), Void, yyvs5.item (yyvsp5 - 1), yyvs118.item (yyvsp118), ast_factory.new_qualified_call (ast_factory.new_dot_feature_name (yyvs5.item (yyvsp5), yyvs13.item (yyvsp13)), yyvs25.item (yyvsp25))) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp85 := yyvsp85 + 1
	yyvsp5 := yyvsp5 -3
	yyvsp118 := yyvsp118 -1
	yyvsp13 := yyvsp13 -1
	yyvsp25 := yyvsp25 -1
	if yyvsp85 >= yyvsc85 then
		if yyvs85 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs85")
			end
			create yyspecial_routines85
			yyvsc85 := yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.make (yyvsc85)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs85")
			end
			yyvsc85 := yyvsc85 + yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.resize (yyvs85, yyvsc85)
		end
	end
	yyvs85.put (yyval85, yyvsp85)
end
		end

	yy_do_action_548 is
			--|#line 3084 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3084 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3084")
end

yyval85 := ast_factory.new_create_instruction (yyvs2.item (yyvsp2), ast_factory.new_target_type (yyvs5.item (yyvsp5 - 1), yyvs112.item (yyvsp112), yyvs5.item (yyvsp5)), yyvs118.item (yyvsp118), Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp85 := yyvsp85 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp5 := yyvsp5 -2
	yyvsp112 := yyvsp112 -1
	yyvsp118 := yyvsp118 -1
	if yyvsp85 >= yyvsc85 then
		if yyvs85 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs85")
			end
			create yyspecial_routines85
			yyvsc85 := yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.make (yyvsc85)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs85")
			end
			yyvsc85 := yyvsc85 + yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.resize (yyvs85, yyvsc85)
		end
	end
	yyvs85.put (yyval85, yyvsp85)
end
		end

	yy_do_action_549 is
			--|#line 3086 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3086 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3086")
end

yyval85 := ast_factory.new_create_instruction (yyvs2.item (yyvsp2), ast_factory.new_target_type (yyvs5.item (yyvsp5 - 2), yyvs112.item (yyvsp112), yyvs5.item (yyvsp5 - 1)), yyvs118.item (yyvsp118), ast_factory.new_qualified_call (ast_factory.new_dot_feature_name (yyvs5.item (yyvsp5), yyvs13.item (yyvsp13)), yyvs25.item (yyvsp25))) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 8
	yyvsp85 := yyvsp85 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp5 := yyvsp5 -3
	yyvsp112 := yyvsp112 -1
	yyvsp118 := yyvsp118 -1
	yyvsp13 := yyvsp13 -1
	yyvsp25 := yyvsp25 -1
	if yyvsp85 >= yyvsc85 then
		if yyvs85 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs85")
			end
			create yyspecial_routines85
			yyvsc85 := yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.make (yyvsc85)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs85")
			end
			yyvsc85 := yyvsc85 + yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.resize (yyvs85, yyvsc85)
		end
	end
	yyvs85.put (yyval85, yyvsp85)
end
		end

	yy_do_action_550 is
			--|#line 3088 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3088 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3088")
end

yyval85 := ast_factory.new_create_instruction (yyvs2.item (yyvsp2), Void, yyvs118.item (yyvsp118), Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp85 := yyvsp85 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp118 := yyvsp118 -1
	if yyvsp85 >= yyvsc85 then
		if yyvs85 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs85")
			end
			create yyspecial_routines85
			yyvsc85 := yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.make (yyvsc85)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs85")
			end
			yyvsc85 := yyvsc85 + yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.resize (yyvs85, yyvsc85)
		end
	end
	yyvs85.put (yyval85, yyvsp85)
end
		end

	yy_do_action_551 is
			--|#line 3090 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3090 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3090")
end

yyval85 := ast_factory.new_create_instruction (yyvs2.item (yyvsp2), Void, yyvs118.item (yyvsp118), ast_factory.new_qualified_call (ast_factory.new_dot_feature_name (yyvs5.item (yyvsp5), yyvs13.item (yyvsp13)), yyvs25.item (yyvsp25))) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp85 := yyvsp85 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp118 := yyvsp118 -1
	yyvsp5 := yyvsp5 -1
	yyvsp13 := yyvsp13 -1
	yyvsp25 := yyvsp25 -1
	if yyvsp85 >= yyvsc85 then
		if yyvs85 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs85")
			end
			create yyspecial_routines85
			yyvsc85 := yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.make (yyvsc85)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs85")
			end
			yyvsc85 := yyvsc85 + yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.resize (yyvs85, yyvsc85)
		end
	end
	yyvs85.put (yyval85, yyvsp85)
end
		end

	yy_do_action_552 is
			--|#line 3094 "et_eiffel_parser.y"
		local
			yyval54: ET_CREATE_EXPRESSION
		do
--|#line 3094 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3094")
end

yyval54 := ast_factory.new_create_expression (yyvs2.item (yyvsp2), ast_factory.new_target_type (yyvs5.item (yyvsp5 - 1), yyvs112.item (yyvsp112), yyvs5.item (yyvsp5)), Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp54 := yyvsp54 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp5 := yyvsp5 -2
	yyvsp112 := yyvsp112 -1
	if yyvsp54 >= yyvsc54 then
		if yyvs54 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs54")
			end
			create yyspecial_routines54
			yyvsc54 := yyInitial_yyvs_size
			yyvs54 := yyspecial_routines54.make (yyvsc54)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs54")
			end
			yyvsc54 := yyvsc54 + yyInitial_yyvs_size
			yyvs54 := yyspecial_routines54.resize (yyvs54, yyvsc54)
		end
	end
	yyvs54.put (yyval54, yyvsp54)
end
		end

	yy_do_action_553 is
			--|#line 3096 "et_eiffel_parser.y"
		local
			yyval54: ET_CREATE_EXPRESSION
		do
--|#line 3096 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3096")
end

yyval54 := ast_factory.new_create_expression (yyvs2.item (yyvsp2), ast_factory.new_target_type (yyvs5.item (yyvsp5 - 2), yyvs112.item (yyvsp112), yyvs5.item (yyvsp5 - 1)), ast_factory.new_qualified_call (ast_factory.new_dot_feature_name (yyvs5.item (yyvsp5), yyvs13.item (yyvsp13)), yyvs25.item (yyvsp25))) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp54 := yyvsp54 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp5 := yyvsp5 -3
	yyvsp112 := yyvsp112 -1
	yyvsp13 := yyvsp13 -1
	yyvsp25 := yyvsp25 -1
	if yyvsp54 >= yyvsc54 then
		if yyvs54 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs54")
			end
			create yyspecial_routines54
			yyvsc54 := yyInitial_yyvs_size
			yyvs54 := yyspecial_routines54.make (yyvsc54)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs54")
			end
			yyvsc54 := yyvsc54 + yyInitial_yyvs_size
			yyvs54 := yyspecial_routines54.resize (yyvs54, yyvsc54)
		end
	end
	yyvs54.put (yyval54, yyvsp54)
end
		end

	yy_do_action_554 is
			--|#line 3102 "et_eiffel_parser.y"
		local
			yyval77: ET_IF_INSTRUCTION
		do
--|#line 3102 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3102")
end

yyval77 := ast_factory.new_if_instruction (ast_factory.new_conditional (yyvs2.item (yyvsp2 - 1), yyvs62.item (yyvsp62)), yyvs45.item (yyvsp45), Void, Void, yyvs2.item (yyvsp2)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp77 := yyvsp77 + 1
	yyvsp2 := yyvsp2 -2
	yyvsp62 := yyvsp62 -1
	yyvsp45 := yyvsp45 -1
	if yyvsp77 >= yyvsc77 then
		if yyvs77 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs77")
			end
			create yyspecial_routines77
			yyvsc77 := yyInitial_yyvs_size
			yyvs77 := yyspecial_routines77.make (yyvsc77)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs77")
			end
			yyvsc77 := yyvsc77 + yyInitial_yyvs_size
			yyvs77 := yyspecial_routines77.resize (yyvs77, yyvsc77)
		end
	end
	yyvs77.put (yyval77, yyvsp77)
end
		end

	yy_do_action_555 is
			--|#line 3104 "et_eiffel_parser.y"
		local
			yyval77: ET_IF_INSTRUCTION
		do
--|#line 3104 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3104")
end

yyval77 := ast_factory.new_if_instruction (ast_factory.new_conditional (yyvs2.item (yyvsp2 - 1), yyvs62.item (yyvsp62)), yyvs45.item (yyvsp45 - 1), Void, yyvs45.item (yyvsp45), yyvs2.item (yyvsp2)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp77 := yyvsp77 + 1
	yyvsp2 := yyvsp2 -2
	yyvsp62 := yyvsp62 -1
	yyvsp45 := yyvsp45 -2
	if yyvsp77 >= yyvsc77 then
		if yyvs77 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs77")
			end
			create yyspecial_routines77
			yyvsc77 := yyInitial_yyvs_size
			yyvs77 := yyspecial_routines77.make (yyvsc77)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs77")
			end
			yyvsc77 := yyvsc77 + yyInitial_yyvs_size
			yyvs77 := yyspecial_routines77.resize (yyvs77, yyvsc77)
		end
	end
	yyvs77.put (yyval77, yyvsp77)
end
		end

	yy_do_action_556 is
			--|#line 3106 "et_eiffel_parser.y"
		local
			yyval77: ET_IF_INSTRUCTION
		do
--|#line 3106 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3106")
end

yyval77 := ast_factory.new_if_instruction (ast_factory.new_conditional (yyvs2.item (yyvsp2 - 1), yyvs62.item (yyvsp62)), yyvs45.item (yyvsp45), yyvs59.item (yyvsp59), Void, yyvs2.item (yyvsp2)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp77 := yyvsp77 + 1
	yyvsp2 := yyvsp2 -2
	yyvsp62 := yyvsp62 -1
	yyvsp45 := yyvsp45 -1
	yyvsp59 := yyvsp59 -1
	if yyvsp77 >= yyvsc77 then
		if yyvs77 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs77")
			end
			create yyspecial_routines77
			yyvsc77 := yyInitial_yyvs_size
			yyvs77 := yyspecial_routines77.make (yyvsc77)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs77")
			end
			yyvsc77 := yyvsc77 + yyInitial_yyvs_size
			yyvs77 := yyspecial_routines77.resize (yyvs77, yyvsc77)
		end
	end
	yyvs77.put (yyval77, yyvsp77)
end
		end

	yy_do_action_557 is
			--|#line 3108 "et_eiffel_parser.y"
		local
			yyval77: ET_IF_INSTRUCTION
		do
--|#line 3108 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3108")
end

yyval77 := ast_factory.new_if_instruction (ast_factory.new_conditional (yyvs2.item (yyvsp2 - 1), yyvs62.item (yyvsp62)), yyvs45.item (yyvsp45 - 1), yyvs59.item (yyvsp59), yyvs45.item (yyvsp45), yyvs2.item (yyvsp2)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp77 := yyvsp77 + 1
	yyvsp2 := yyvsp2 -2
	yyvsp62 := yyvsp62 -1
	yyvsp45 := yyvsp45 -2
	yyvsp59 := yyvsp59 -1
	if yyvsp77 >= yyvsc77 then
		if yyvs77 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs77")
			end
			create yyspecial_routines77
			yyvsc77 := yyInitial_yyvs_size
			yyvs77 := yyspecial_routines77.make (yyvsc77)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs77")
			end
			yyvsc77 := yyvsc77 + yyInitial_yyvs_size
			yyvs77 := yyspecial_routines77.resize (yyvs77, yyvsc77)
		end
	end
	yyvs77.put (yyval77, yyvsp77)
end
		end

	yy_do_action_558 is
			--|#line 3112 "et_eiffel_parser.y"
		local
			yyval59: ET_ELSEIF_PART_LIST
		do
--|#line 3112 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3112")
end

			yyval59 := yyvs59.item (yyvsp59)
			remove_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs59.put (yyval59, yyvsp59)
end
		end

	yy_do_action_559 is
			--|#line 3119 "et_eiffel_parser.y"
		local
			yyval59: ET_ELSEIF_PART_LIST
		do
--|#line 3119 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3119")
end

			yyval59 := ast_factory.new_elseif_part_list (counter_value)
			if yyval59 /= Void and yyvs58.item (yyvsp58) /= Void then
				yyval59.put_first (yyvs58.item (yyvsp58))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp59 := yyvsp59 + 1
	yyvsp58 := yyvsp58 -1
	if yyvsp59 >= yyvsc59 then
		if yyvs59 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs59")
			end
			create yyspecial_routines59
			yyvsc59 := yyInitial_yyvs_size
			yyvs59 := yyspecial_routines59.make (yyvsc59)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs59")
			end
			yyvsc59 := yyvsc59 + yyInitial_yyvs_size
			yyvs59 := yyspecial_routines59.resize (yyvs59, yyvsc59)
		end
	end
	yyvs59.put (yyval59, yyvsp59)
end
		end

	yy_do_action_560 is
			--|#line 3126 "et_eiffel_parser.y"
		local
			yyval59: ET_ELSEIF_PART_LIST
		do
--|#line 3126 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3126")
end

			yyval59 := yyvs59.item (yyvsp59)
			if yyval59 /= Void and yyvs58.item (yyvsp58) /= Void then
				yyval59.put_first (yyvs58.item (yyvsp58))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp58 := yyvsp58 -1
	yyvs59.put (yyval59, yyvsp59)
end
		end

	yy_do_action_561 is
			--|#line 3135 "et_eiffel_parser.y"
		local
			yyval58: ET_ELSEIF_PART
		do
--|#line 3135 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3135")
end

			yyval58 := ast_factory.new_elseif_part (ast_factory.new_conditional (yyvs2.item (yyvsp2), yyvs62.item (yyvsp62)), yyvs45.item (yyvsp45))
			if yyval58 /= Void then
				increment_counter
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp58 := yyvsp58 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp62 := yyvsp62 -1
	yyvsp45 := yyvsp45 -1
	if yyvsp58 >= yyvsc58 then
		if yyvs58 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs58")
			end
			create yyspecial_routines58
			yyvsc58 := yyInitial_yyvs_size
			yyvs58 := yyspecial_routines58.make (yyvsc58)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs58")
			end
			yyvsc58 := yyvsc58 + yyInitial_yyvs_size
			yyvs58 := yyspecial_routines58.resize (yyvs58, yyvsc58)
		end
	end
	yyvs58.put (yyval58, yyvsp58)
end
		end

	yy_do_action_562 is
			--|#line 3146 "et_eiffel_parser.y"
		local
			yyval84: ET_INSPECT_INSTRUCTION
		do
--|#line 3146 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3146")
end

yyval84 := ast_factory.new_inspect_instruction (ast_factory.new_conditional (yyvs2.item (yyvsp2 - 1), yyvs62.item (yyvsp62)), yyvs117.item (yyvsp117), yyvs45.item (yyvsp45), yyvs2.item (yyvsp2)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp84 := yyvsp84 + 1
	yyvsp2 := yyvsp2 -2
	yyvsp62 := yyvsp62 -1
	yyvsp117 := yyvsp117 -1
	yyvsp45 := yyvsp45 -1
	if yyvsp84 >= yyvsc84 then
		if yyvs84 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs84")
			end
			create yyspecial_routines84
			yyvsc84 := yyInitial_yyvs_size
			yyvs84 := yyspecial_routines84.make (yyvsc84)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs84")
			end
			yyvsc84 := yyvsc84 + yyInitial_yyvs_size
			yyvs84 := yyspecial_routines84.resize (yyvs84, yyvsc84)
		end
	end
	yyvs84.put (yyval84, yyvsp84)
end
		end

	yy_do_action_563 is
			--|#line 3148 "et_eiffel_parser.y"
		local
			yyval84: ET_INSPECT_INSTRUCTION
		do
--|#line 3148 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3148")
end

yyval84 := ast_factory.new_inspect_instruction (ast_factory.new_conditional (yyvs2.item (yyvsp2 - 1), yyvs62.item (yyvsp62)), yyvs117.item (yyvsp117), Void, yyvs2.item (yyvsp2)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp84 := yyvsp84 + 1
	yyvsp2 := yyvsp2 -2
	yyvsp62 := yyvsp62 -1
	yyvsp117 := yyvsp117 -1
	if yyvsp84 >= yyvsc84 then
		if yyvs84 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs84")
			end
			create yyspecial_routines84
			yyvsc84 := yyInitial_yyvs_size
			yyvs84 := yyspecial_routines84.make (yyvsc84)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs84")
			end
			yyvsc84 := yyvsc84 + yyInitial_yyvs_size
			yyvs84 := yyspecial_routines84.resize (yyvs84, yyvsc84)
		end
	end
	yyvs84.put (yyval84, yyvsp84)
end
		end

	yy_do_action_564 is
			--|#line 3152 "et_eiffel_parser.y"
		local
			yyval117: ET_WHEN_PART_LIST
		do
--|#line 3152 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3152")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp117 := yyvsp117 + 1
	if yyvsp117 >= yyvsc117 then
		if yyvs117 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs117")
			end
			create yyspecial_routines117
			yyvsc117 := yyInitial_yyvs_size
			yyvs117 := yyspecial_routines117.make (yyvsc117)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs117")
			end
			yyvsc117 := yyvsc117 + yyInitial_yyvs_size
			yyvs117 := yyspecial_routines117.resize (yyvs117, yyvsc117)
		end
	end
	yyvs117.put (yyval117, yyvsp117)
end
		end

	yy_do_action_565 is
			--|#line 3154 "et_eiffel_parser.y"
		local
			yyval117: ET_WHEN_PART_LIST
		do
--|#line 3154 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3154")
end

			yyval117 := yyvs117.item (yyvsp117)
			remove_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs117.put (yyval117, yyvsp117)
end
		end

	yy_do_action_566 is
			--|#line 3161 "et_eiffel_parser.y"
		local
			yyval117: ET_WHEN_PART_LIST
		do
--|#line 3161 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3161")
end

			yyval117 := ast_factory.new_when_part_list (counter_value)
			if yyval117 /= Void and yyvs116.item (yyvsp116) /= Void then
				yyval117.put_first (yyvs116.item (yyvsp116))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp117 := yyvsp117 + 1
	yyvsp116 := yyvsp116 -1
	if yyvsp117 >= yyvsc117 then
		if yyvs117 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs117")
			end
			create yyspecial_routines117
			yyvsc117 := yyInitial_yyvs_size
			yyvs117 := yyspecial_routines117.make (yyvsc117)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs117")
			end
			yyvsc117 := yyvsc117 + yyInitial_yyvs_size
			yyvs117 := yyspecial_routines117.resize (yyvs117, yyvsc117)
		end
	end
	yyvs117.put (yyval117, yyvsp117)
end
		end

	yy_do_action_567 is
			--|#line 3168 "et_eiffel_parser.y"
		local
			yyval117: ET_WHEN_PART_LIST
		do
--|#line 3168 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3168")
end

			yyval117 := yyvs117.item (yyvsp117)
			if yyval117 /= Void and yyvs116.item (yyvsp116) /= Void then
				yyval117.put_first (yyvs116.item (yyvsp116))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp116 := yyvsp116 -1
	yyvs117.put (yyval117, yyvsp117)
end
		end

	yy_do_action_568 is
			--|#line 3177 "et_eiffel_parser.y"
		local
			yyval116: ET_WHEN_PART
		do
--|#line 3177 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3177")
end

			yyval116 := ast_factory.new_when_part (yyvs41.item (yyvsp41), yyvs45.item (yyvsp45))
			if yyval116 /= Void then
				increment_counter
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp116 := yyvsp116 + 1
	yyvsp41 := yyvsp41 -1
	yyvsp45 := yyvsp45 -1
	if yyvsp116 >= yyvsc116 then
		if yyvs116 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs116")
			end
			create yyspecial_routines116
			yyvsc116 := yyInitial_yyvs_size
			yyvs116 := yyspecial_routines116.make (yyvsc116)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs116")
			end
			yyvsc116 := yyvsc116 + yyInitial_yyvs_size
			yyvs116 := yyspecial_routines116.resize (yyvs116, yyvsc116)
		end
	end
	yyvs116.put (yyval116, yyvsp116)
end
		end

	yy_do_action_569 is
			--|#line 3186 "et_eiffel_parser.y"
		local
			yyval41: ET_CHOICE_LIST
		do
--|#line 3186 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3186")
end

yyval41 := ast_factory.new_choice_list (yyvs2.item (yyvsp2), 0) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp41 := yyvsp41 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp41 >= yyvsc41 then
		if yyvs41 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs41")
			end
			create yyspecial_routines41
			yyvsc41 := yyInitial_yyvs_size
			yyvs41 := yyspecial_routines41.make (yyvsc41)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs41")
			end
			yyvsc41 := yyvsc41 + yyInitial_yyvs_size
			yyvs41 := yyspecial_routines41.resize (yyvs41, yyvsc41)
		end
	end
	yyvs41.put (yyval41, yyvsp41)
end
		end

	yy_do_action_570 is
			--|#line 3188 "et_eiffel_parser.y"
		local
			yyval41: ET_CHOICE_LIST
		do
--|#line 3188 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3188")
end

			yyval41 := yyvs41.item (yyvsp41)
			remove_keyword
			remove_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp41 := yyvsp41 -1
	yyvsp2 := yyvsp2 -1
	yyvs41.put (yyval41, yyvsp41)
end
		end

	yy_do_action_571 is
			--|#line 3188 "et_eiffel_parser.y"
		local
			yyval41: ET_CHOICE_LIST
		do
--|#line 3188 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3188")
end

			add_keyword (yyvs2.item (yyvsp2))
			add_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp41 := yyvsp41 + 1
	if yyvsp41 >= yyvsc41 then
		if yyvs41 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs41")
			end
			create yyspecial_routines41
			yyvsc41 := yyInitial_yyvs_size
			yyvs41 := yyspecial_routines41.make (yyvsc41)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs41")
			end
			yyvsc41 := yyvsc41 + yyInitial_yyvs_size
			yyvs41 := yyspecial_routines41.resize (yyvs41, yyvsc41)
		end
	end
	yyvs41.put (yyval41, yyvsp41)
end
		end

	yy_do_action_572 is
			--|#line 3201 "et_eiffel_parser.y"
		local
			yyval41: ET_CHOICE_LIST
		do
--|#line 3201 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3201")
end

			if yyvs38.item (yyvsp38) /= Void then
				yyval41 := ast_factory.new_choice_list (last_keyword, counter_value + 1)
				if yyval41 /= Void then
					yyval41.put_first (yyvs38.item (yyvsp38))
				end
			else
				yyval41 := ast_factory.new_choice_list (last_keyword, counter_value)
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp41 := yyvsp41 + 1
	yyvsp38 := yyvsp38 -1
	if yyvsp41 >= yyvsc41 then
		if yyvs41 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs41")
			end
			create yyspecial_routines41
			yyvsc41 := yyInitial_yyvs_size
			yyvs41 := yyspecial_routines41.make (yyvsc41)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs41")
			end
			yyvsc41 := yyvsc41 + yyInitial_yyvs_size
			yyvs41 := yyspecial_routines41.resize (yyvs41, yyvsc41)
		end
	end
	yyvs41.put (yyval41, yyvsp41)
end
		end

	yy_do_action_573 is
			--|#line 3212 "et_eiffel_parser.y"
		local
			yyval41: ET_CHOICE_LIST
		do
--|#line 3212 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3212")
end

			yyval41 := ast_factory.new_choice_list (last_keyword, counter_value)
			if yyval41 /= Void and yyvs40.item (yyvsp40) /= Void then
				yyval41.put_first (yyvs40.item (yyvsp40))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp41 := yyvsp41 + 1
	yyvsp40 := yyvsp40 -1
	if yyvsp41 >= yyvsc41 then
		if yyvs41 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs41")
			end
			create yyspecial_routines41
			yyvsc41 := yyInitial_yyvs_size
			yyvs41 := yyspecial_routines41.make (yyvsc41)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs41")
			end
			yyvsc41 := yyvsc41 + yyInitial_yyvs_size
			yyvs41 := yyspecial_routines41.resize (yyvs41, yyvsc41)
		end
	end
	yyvs41.put (yyval41, yyvsp41)
end
		end

	yy_do_action_574 is
			--|#line 3220 "et_eiffel_parser.y"
		local
			yyval41: ET_CHOICE_LIST
		do
--|#line 3220 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3220")
end

			yyval41 := yyvs41.item (yyvsp41)
			if yyval41 /= Void and yyvs40.item (yyvsp40) /= Void then
				yyval41.put_first (yyvs40.item (yyvsp40))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp40 := yyvsp40 -1
	yyvs41.put (yyval41, yyvsp41)
end
		end

	yy_do_action_575 is
			--|#line 3229 "et_eiffel_parser.y"
		local
			yyval40: ET_CHOICE_ITEM
		do
--|#line 3229 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3229")
end

			yyval40 := ast_factory.new_choice_comma (yyvs38.item (yyvsp38), yyvs5.item (yyvsp5))
			if yyval40 /= Void then
				increment_counter
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp40 := yyvsp40 + 1
	yyvsp38 := yyvsp38 -1
	yyvsp5 := yyvsp5 -1
	if yyvsp40 >= yyvsc40 then
		if yyvs40 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs40")
			end
			create yyspecial_routines40
			yyvsc40 := yyInitial_yyvs_size
			yyvs40 := yyspecial_routines40.make (yyvsc40)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs40")
			end
			yyvsc40 := yyvsc40 + yyInitial_yyvs_size
			yyvs40 := yyspecial_routines40.resize (yyvs40, yyvsc40)
		end
	end
	yyvs40.put (yyval40, yyvsp40)
end
		end

	yy_do_action_576 is
			--|#line 3238 "et_eiffel_parser.y"
		local
			yyval38: ET_CHOICE
		do
--|#line 3238 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3238")
end

yyval38 := yyvs39.item (yyvsp39) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp38 := yyvsp38 + 1
	yyvsp39 := yyvsp39 -1
	if yyvsp38 >= yyvsc38 then
		if yyvs38 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs38")
			end
			create yyspecial_routines38
			yyvsc38 := yyInitial_yyvs_size
			yyvs38 := yyspecial_routines38.make (yyvsc38)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs38")
			end
			yyvsc38 := yyvsc38 + yyInitial_yyvs_size
			yyvs38 := yyspecial_routines38.resize (yyvs38, yyvsc38)
		end
	end
	yyvs38.put (yyval38, yyvsp38)
end
		end

	yy_do_action_577 is
			--|#line 3240 "et_eiffel_parser.y"
		local
			yyval38: ET_CHOICE
		do
--|#line 3240 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3240")
end

yyval38 := ast_factory.new_choice_range (yyvs39.item (yyvsp39 - 1), yyvs5.item (yyvsp5), yyvs39.item (yyvsp39)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp38 := yyvsp38 + 1
	yyvsp39 := yyvsp39 -2
	yyvsp5 := yyvsp5 -1
	if yyvsp38 >= yyvsc38 then
		if yyvs38 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs38")
			end
			create yyspecial_routines38
			yyvsc38 := yyInitial_yyvs_size
			yyvs38 := yyspecial_routines38.make (yyvsc38)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs38")
			end
			yyvsc38 := yyvsc38 + yyInitial_yyvs_size
			yyvs38 := yyspecial_routines38.resize (yyvs38, yyvsc38)
		end
	end
	yyvs38.put (yyval38, yyvsp38)
end
		end

	yy_do_action_578 is
			--|#line 3244 "et_eiffel_parser.y"
		local
			yyval39: ET_CHOICE_CONSTANT
		do
--|#line 3244 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3244")
end

yyval39 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp39 := yyvsp39 + 1
	yyvsp14 := yyvsp14 -1
	if yyvsp39 >= yyvsc39 then
		if yyvs39 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs39")
			end
			create yyspecial_routines39
			yyvsc39 := yyInitial_yyvs_size
			yyvs39 := yyspecial_routines39.make (yyvsc39)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs39")
			end
			yyvsc39 := yyvsc39 + yyInitial_yyvs_size
			yyvs39 := yyspecial_routines39.resize (yyvs39, yyvsc39)
		end
	end
	yyvs39.put (yyval39, yyvsp39)
end
		end

	yy_do_action_579 is
			--|#line 3246 "et_eiffel_parser.y"
		local
			yyval39: ET_CHOICE_CONSTANT
		do
--|#line 3246 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3246")
end

yyval39 := yyvs10.item (yyvsp10) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp39 := yyvsp39 + 1
	yyvsp10 := yyvsp10 -1
	if yyvsp39 >= yyvsc39 then
		if yyvs39 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs39")
			end
			create yyspecial_routines39
			yyvsc39 := yyInitial_yyvs_size
			yyvs39 := yyspecial_routines39.make (yyvsc39)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs39")
			end
			yyvsc39 := yyvsc39 + yyInitial_yyvs_size
			yyvs39 := yyspecial_routines39.resize (yyvs39, yyvsc39)
		end
	end
	yyvs39.put (yyval39, yyvsp39)
end
		end

	yy_do_action_580 is
			--|#line 3248 "et_eiffel_parser.y"
		local
			yyval39: ET_CHOICE_CONSTANT
		do
--|#line 3248 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3248")
end

yyval39 := new_choice_attribute_constant (yyvs13.item (yyvsp13)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp39 := yyvsp39 + 1
	yyvsp13 := yyvsp13 -1
	if yyvsp39 >= yyvsc39 then
		if yyvs39 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs39")
			end
			create yyspecial_routines39
			yyvsc39 := yyInitial_yyvs_size
			yyvs39 := yyspecial_routines39.make (yyvsc39)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs39")
			end
			yyvsc39 := yyvsc39 + yyInitial_yyvs_size
			yyvs39 := yyspecial_routines39.resize (yyvs39, yyvsc39)
		end
	end
	yyvs39.put (yyval39, yyvsp39)
end
		end

	yy_do_action_581 is
			--|#line 3250 "et_eiffel_parser.y"
		local
			yyval39: ET_CHOICE_CONSTANT
		do
--|#line 3250 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3250")
end

yyval39 := yyvs110.item (yyvsp110) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp39 := yyvsp39 + 1
	yyvsp110 := yyvsp110 -1
	if yyvsp39 >= yyvsc39 then
		if yyvs39 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs39")
			end
			create yyspecial_routines39
			yyvsc39 := yyInitial_yyvs_size
			yyvs39 := yyspecial_routines39.make (yyvsc39)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs39")
			end
			yyvsc39 := yyvsc39 + yyInitial_yyvs_size
			yyvs39 := yyspecial_routines39.resize (yyvs39, yyvsc39)
		end
	end
	yyvs39.put (yyval39, yyvsp39)
end
		end

	yy_do_action_582 is
			--|#line 3256 "et_eiffel_parser.y"
		local
			yyval57: ET_DEBUG_INSTRUCTION
		do
--|#line 3256 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3256")
end

yyval57 := ast_factory.new_debug_instruction (yyvs95.item (yyvsp95), ast_factory.new_debug_compound (yyvs2.item (yyvsp2 - 1), ast_factory.new_compound (0)), yyvs2.item (yyvsp2)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp57 := yyvsp57 + 1
	yyvsp2 := yyvsp2 -2
	yyvsp95 := yyvsp95 -1
	if yyvsp57 >= yyvsc57 then
		if yyvs57 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs57")
			end
			create yyspecial_routines57
			yyvsc57 := yyInitial_yyvs_size
			yyvs57 := yyspecial_routines57.make (yyvsc57)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs57")
			end
			yyvsc57 := yyvsc57 + yyInitial_yyvs_size
			yyvs57 := yyspecial_routines57.resize (yyvs57, yyvsc57)
		end
	end
	yyvs57.put (yyval57, yyvsp57)
end
		end

	yy_do_action_583 is
			--|#line 3258 "et_eiffel_parser.y"
		local
			yyval57: ET_DEBUG_INSTRUCTION
		do
--|#line 3258 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3258")
end

			yyval57 := ast_factory.new_debug_instruction (yyvs95.item (yyvsp95), ast_factory.new_debug_compound (yyvs2.item (yyvsp2 - 1), yyvs45.item (yyvsp45)), yyvs2.item (yyvsp2))
			remove_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp57 := yyvsp57 + 1
	yyvsp2 := yyvsp2 -2
	yyvsp95 := yyvsp95 -1
	yyvsp1 := yyvsp1 -1
	yyvsp45 := yyvsp45 -1
	if yyvsp57 >= yyvsc57 then
		if yyvs57 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs57")
			end
			create yyspecial_routines57
			yyvsc57 := yyInitial_yyvs_size
			yyvs57 := yyspecial_routines57.make (yyvsc57)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs57")
			end
			yyvsc57 := yyvsc57 + yyInitial_yyvs_size
			yyvs57 := yyspecial_routines57.resize (yyvs57, yyvsc57)
		end
	end
	yyvs57.put (yyval57, yyvsp57)
end
		end

	yy_do_action_584 is
			--|#line 3265 "et_eiffel_parser.y"
		local
			yyval95: ET_MANIFEST_STRING_LIST
		do
--|#line 3265 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3265")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp95 := yyvsp95 + 1
	if yyvsp95 >= yyvsc95 then
		if yyvs95 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs95")
			end
			create yyspecial_routines95
			yyvsc95 := yyInitial_yyvs_size
			yyvs95 := yyspecial_routines95.make (yyvsc95)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs95")
			end
			yyvsc95 := yyvsc95 + yyInitial_yyvs_size
			yyvs95 := yyspecial_routines95.resize (yyvs95, yyvsc95)
		end
	end
	yyvs95.put (yyval95, yyvsp95)
end
		end

	yy_do_action_585 is
			--|#line 3267 "et_eiffel_parser.y"
		local
			yyval95: ET_MANIFEST_STRING_LIST
		do
--|#line 3267 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3267")
end

yyval95 := ast_factory.new_manifest_string_list (yyvs5.item (yyvsp5 - 1), yyvs5.item (yyvsp5), 0) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp95 := yyvsp95 + 1
	yyvsp5 := yyvsp5 -2
	if yyvsp95 >= yyvsc95 then
		if yyvs95 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs95")
			end
			create yyspecial_routines95
			yyvsc95 := yyInitial_yyvs_size
			yyvs95 := yyspecial_routines95.make (yyvsc95)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs95")
			end
			yyvsc95 := yyvsc95 + yyInitial_yyvs_size
			yyvs95 := yyspecial_routines95.resize (yyvs95, yyvsc95)
		end
	end
	yyvs95.put (yyval95, yyvsp95)
end
		end

	yy_do_action_586 is
			--|#line 3269 "et_eiffel_parser.y"
		local
			yyval95: ET_MANIFEST_STRING_LIST
		do
--|#line 3269 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3269")
end

			yyval95 := yyvs95.item (yyvsp95)
			remove_symbol
			remove_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp95 := yyvsp95 -1
	yyvsp5 := yyvsp5 -1
	yyvs95.put (yyval95, yyvsp95)
end
		end

	yy_do_action_587 is
			--|#line 3269 "et_eiffel_parser.y"
		local
			yyval95: ET_MANIFEST_STRING_LIST
		do
--|#line 3269 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3269")
end

			add_symbol (yyvs5.item (yyvsp5))
			add_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp95 := yyvsp95 + 1
	if yyvsp95 >= yyvsc95 then
		if yyvs95 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs95")
			end
			create yyspecial_routines95
			yyvsc95 := yyInitial_yyvs_size
			yyvs95 := yyspecial_routines95.make (yyvsc95)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs95")
			end
			yyvsc95 := yyvsc95 + yyInitial_yyvs_size
			yyvs95 := yyspecial_routines95.resize (yyvs95, yyvsc95)
		end
	end
	yyvs95.put (yyval95, yyvsp95)
end
		end

	yy_do_action_588 is
			--|#line 3282 "et_eiffel_parser.y"
		local
			yyval95: ET_MANIFEST_STRING_LIST
		do
--|#line 3282 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3282")
end

			if yyvs16.item (yyvsp16) /= Void then
				yyval95 := ast_factory.new_manifest_string_list (last_symbol, yyvs5.item (yyvsp5), counter_value + 1)
				if yyval95 /= Void then
					yyval95.put_first (yyvs16.item (yyvsp16))
				end
			else
				yyval95 := ast_factory.new_manifest_string_list (last_symbol, yyvs5.item (yyvsp5), counter_value)
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp95 := yyvsp95 + 1
	yyvsp16 := yyvsp16 -1
	yyvsp5 := yyvsp5 -1
	if yyvsp95 >= yyvsc95 then
		if yyvs95 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs95")
			end
			create yyspecial_routines95
			yyvsc95 := yyInitial_yyvs_size
			yyvs95 := yyspecial_routines95.make (yyvsc95)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs95")
			end
			yyvsc95 := yyvsc95 + yyInitial_yyvs_size
			yyvs95 := yyspecial_routines95.resize (yyvs95, yyvsc95)
		end
	end
	yyvs95.put (yyval95, yyvsp95)
end
		end

	yy_do_action_589 is
			--|#line 3293 "et_eiffel_parser.y"
		local
			yyval95: ET_MANIFEST_STRING_LIST
		do
--|#line 3293 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3293")
end

			yyval95 := yyvs95.item (yyvsp95)
			if yyval95 /= Void and yyvs94.item (yyvsp94) /= Void then
				yyval95.put_first (yyvs94.item (yyvsp94))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp94 := yyvsp94 -1
	yyvs95.put (yyval95, yyvsp95)
end
		end

	yy_do_action_590 is
			--|#line 3302 "et_eiffel_parser.y"
		local
			yyval94: ET_MANIFEST_STRING_ITEM
		do
--|#line 3302 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3302")
end

			yyval94 := ast_factory.new_manifest_string_comma (yyvs16.item (yyvsp16), yyvs5.item (yyvsp5))
			if yyval94 /= Void then
				increment_counter
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp94 := yyvsp94 + 1
	yyvsp16 := yyvsp16 -1
	yyvsp5 := yyvsp5 -1
	if yyvsp94 >= yyvsc94 then
		if yyvs94 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs94")
			end
			create yyspecial_routines94
			yyvsc94 := yyInitial_yyvs_size
			yyvs94 := yyspecial_routines94.make (yyvsc94)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs94")
			end
			yyvsc94 := yyvsc94 + yyInitial_yyvs_size
			yyvs94 := yyspecial_routines94.resize (yyvs94, yyvsc94)
		end
	end
	yyvs94.put (yyval94, yyvsp94)
end
		end

	yy_do_action_591 is
			--|#line 3313 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3313 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3313")
end

yyval85 := new_unqualified_call_instruction (yyvs13.item (yyvsp13), yyvs25.item (yyvsp25)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp85 := yyvsp85 + 1
	yyvsp13 := yyvsp13 -1
	yyvsp25 := yyvsp25 -1
	if yyvsp85 >= yyvsc85 then
		if yyvs85 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs85")
			end
			create yyspecial_routines85
			yyvsc85 := yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.make (yyvsc85)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs85")
			end
			yyvsc85 := yyvsc85 + yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.resize (yyvs85, yyvsc85)
		end
	end
	yyvs85.put (yyval85, yyvsp85)
end
		end

	yy_do_action_592 is
			--|#line 3315 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3315 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3315")
end

yyval85 := ast_factory.new_call_instruction (yyvs62.item (yyvsp62), ast_factory.new_dot_feature_name (yyvs5.item (yyvsp5), yyvs13.item (yyvsp13)), yyvs25.item (yyvsp25)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp85 := yyvsp85 + 1
	yyvsp62 := yyvsp62 -1
	yyvsp5 := yyvsp5 -1
	yyvsp13 := yyvsp13 -1
	yyvsp25 := yyvsp25 -1
	if yyvsp85 >= yyvsc85 then
		if yyvs85 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs85")
			end
			create yyspecial_routines85
			yyvsc85 := yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.make (yyvsc85)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs85")
			end
			yyvsc85 := yyvsc85 + yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.resize (yyvs85, yyvsc85)
		end
	end
	yyvs85.put (yyval85, yyvsp85)
end
		end

	yy_do_action_593 is
			--|#line 3317 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3317 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3317")
end

yyval85 := ast_factory.new_precursor_instruction (False, yyvs4.item (yyvsp4), Void, yyvs25.item (yyvsp25)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp85 := yyvsp85 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp25 := yyvsp25 -1
	if yyvsp85 >= yyvsc85 then
		if yyvs85 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs85")
			end
			create yyspecial_routines85
			yyvsc85 := yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.make (yyvsc85)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs85")
			end
			yyvsc85 := yyvsc85 + yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.resize (yyvs85, yyvsc85)
		end
	end
	yyvs85.put (yyval85, yyvsp85)
end
		end

	yy_do_action_594 is
			--|#line 3319 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3319 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3319")
end

yyval85 := ast_factory.new_precursor_instruction (False, yyvs4.item (yyvsp4), ast_factory.new_precursor_class_name (yyvs5.item (yyvsp5 - 1), yyvs13.item (yyvsp13), yyvs5.item (yyvsp5)), yyvs25.item (yyvsp25)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp85 := yyvsp85 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp5 := yyvsp5 -2
	yyvsp13 := yyvsp13 -1
	yyvsp25 := yyvsp25 -1
	if yyvsp85 >= yyvsc85 then
		if yyvs85 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs85")
			end
			create yyspecial_routines85
			yyvsc85 := yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.make (yyvsc85)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs85")
			end
			yyvsc85 := yyvsc85 + yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.resize (yyvs85, yyvsc85)
		end
	end
	yyvs85.put (yyval85, yyvsp85)
end
		end

	yy_do_action_595 is
			--|#line 3321 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3321 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3321")
end

yyval85 := ast_factory.new_static_call_instruction (yyvs2.item (yyvsp2), ast_factory.new_target_type (yyvs5.item (yyvsp5 - 2), yyvs112.item (yyvsp112), yyvs5.item (yyvsp5 - 1)), ast_factory.new_dot_feature_name (yyvs5.item (yyvsp5), yyvs13.item (yyvsp13)), yyvs25.item (yyvsp25)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp85 := yyvsp85 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp5 := yyvsp5 -3
	yyvsp112 := yyvsp112 -1
	yyvsp13 := yyvsp13 -1
	yyvsp25 := yyvsp25 -1
	if yyvsp85 >= yyvsc85 then
		if yyvs85 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs85")
			end
			create yyspecial_routines85
			yyvsc85 := yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.make (yyvsc85)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs85")
			end
			yyvsc85 := yyvsc85 + yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.resize (yyvs85, yyvsc85)
		end
	end
	yyvs85.put (yyval85, yyvsp85)
end
		end

	yy_do_action_596 is
			--|#line 3323 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3323 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3323")
end

yyval85 := ast_factory.new_static_call_instruction (Void, ast_factory.new_target_type (yyvs5.item (yyvsp5 - 2), yyvs112.item (yyvsp112), yyvs5.item (yyvsp5 - 1)), ast_factory.new_dot_feature_name (yyvs5.item (yyvsp5), yyvs13.item (yyvsp13)), yyvs25.item (yyvsp25)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp85 := yyvsp85 + 1
	yyvsp5 := yyvsp5 -3
	yyvsp112 := yyvsp112 -1
	yyvsp13 := yyvsp13 -1
	yyvsp25 := yyvsp25 -1
	if yyvsp85 >= yyvsc85 then
		if yyvs85 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs85")
			end
			create yyspecial_routines85
			yyvsc85 := yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.make (yyvsc85)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs85")
			end
			yyvsc85 := yyvsc85 + yyInitial_yyvs_size
			yyvs85 := yyspecial_routines85.resize (yyvs85, yyvsc85)
		end
	end
	yyvs85.put (yyval85, yyvsp85)
end
		end

	yy_do_action_597 is
			--|#line 3327 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3327 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3327")
end

yyval62 := new_unqualified_call_expression (yyvs13.item (yyvsp13), yyvs25.item (yyvsp25)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp62 := yyvsp62 + 1
	yyvsp13 := yyvsp13 -1
	yyvsp25 := yyvsp25 -1
	if yyvsp62 >= yyvsc62 then
		if yyvs62 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs62")
			end
			create yyspecial_routines62
			yyvsc62 := yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.make (yyvsc62)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs62")
			end
			yyvsc62 := yyvsc62 + yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.resize (yyvs62, yyvsc62)
		end
	end
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_598 is
			--|#line 3329 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3329 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3329")
end

yyval62 := ast_factory.new_call_expression (yyvs62.item (yyvsp62), ast_factory.new_dot_feature_name (yyvs5.item (yyvsp5), yyvs13.item (yyvsp13)), yyvs25.item (yyvsp25)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp5 := yyvsp5 -1
	yyvsp13 := yyvsp13 -1
	yyvsp25 := yyvsp25 -1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_599 is
			--|#line 3333 "et_eiffel_parser.y"
		local
			yyval37: ET_CALL_EXPRESSION
		do
--|#line 3333 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3333")
end

yyval37 := ast_factory.new_call_expression (yyvs62.item (yyvsp62), ast_factory.new_dot_feature_name (yyvs5.item (yyvsp5), yyvs13.item (yyvsp13)), yyvs25.item (yyvsp25)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp37 := yyvsp37 + 1
	yyvsp62 := yyvsp62 -1
	yyvsp5 := yyvsp5 -1
	yyvsp13 := yyvsp13 -1
	yyvsp25 := yyvsp25 -1
	if yyvsp37 >= yyvsc37 then
		if yyvs37 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs37")
			end
			create yyspecial_routines37
			yyvsc37 := yyInitial_yyvs_size
			yyvs37 := yyspecial_routines37.make (yyvsc37)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs37")
			end
			yyvsc37 := yyvsc37 + yyInitial_yyvs_size
			yyvs37 := yyspecial_routines37.resize (yyvs37, yyvsc37)
		end
	end
	yyvs37.put (yyval37, yyvsp37)
end
		end

	yy_do_action_600 is
			--|#line 3337 "et_eiffel_parser.y"
		local
			yyval110: ET_STATIC_CALL_EXPRESSION
		do
--|#line 3337 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3337")
end

yyval110 := ast_factory.new_static_call_expression (yyvs2.item (yyvsp2), ast_factory.new_target_type (yyvs5.item (yyvsp5 - 2), yyvs112.item (yyvsp112), yyvs5.item (yyvsp5 - 1)), ast_factory.new_dot_feature_name (yyvs5.item (yyvsp5), yyvs13.item (yyvsp13)), yyvs25.item (yyvsp25)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp110 := yyvsp110 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp5 := yyvsp5 -3
	yyvsp112 := yyvsp112 -1
	yyvsp13 := yyvsp13 -1
	yyvsp25 := yyvsp25 -1
	if yyvsp110 >= yyvsc110 then
		if yyvs110 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs110")
			end
			create yyspecial_routines110
			yyvsc110 := yyInitial_yyvs_size
			yyvs110 := yyspecial_routines110.make (yyvsc110)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs110")
			end
			yyvsc110 := yyvsc110 + yyInitial_yyvs_size
			yyvs110 := yyspecial_routines110.resize (yyvs110, yyvsc110)
		end
	end
	yyvs110.put (yyval110, yyvsp110)
end
		end

	yy_do_action_601 is
			--|#line 3339 "et_eiffel_parser.y"
		local
			yyval110: ET_STATIC_CALL_EXPRESSION
		do
--|#line 3339 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3339")
end

yyval110 := ast_factory.new_static_call_expression (Void, ast_factory.new_target_type (yyvs5.item (yyvsp5 - 2), yyvs112.item (yyvsp112), yyvs5.item (yyvsp5 - 1)), ast_factory.new_dot_feature_name (yyvs5.item (yyvsp5), yyvs13.item (yyvsp13)), yyvs25.item (yyvsp25)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp110 := yyvsp110 + 1
	yyvsp5 := yyvsp5 -3
	yyvsp112 := yyvsp112 -1
	yyvsp13 := yyvsp13 -1
	yyvsp25 := yyvsp25 -1
	if yyvsp110 >= yyvsc110 then
		if yyvs110 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs110")
			end
			create yyspecial_routines110
			yyvsc110 := yyInitial_yyvs_size
			yyvs110 := yyspecial_routines110.make (yyvsc110)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs110")
			end
			yyvsc110 := yyvsc110 + yyInitial_yyvs_size
			yyvs110 := yyspecial_routines110.resize (yyvs110, yyvsc110)
		end
	end
	yyvs110.put (yyval110, yyvsp110)
end
		end

	yy_do_action_602 is
			--|#line 3343 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3343 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3343")
end

yyval62 := ast_factory.new_precursor_expression (False, yyvs4.item (yyvsp4), Void, yyvs25.item (yyvsp25)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp62 := yyvsp62 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp25 := yyvsp25 -1
	if yyvsp62 >= yyvsc62 then
		if yyvs62 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs62")
			end
			create yyspecial_routines62
			yyvsc62 := yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.make (yyvsc62)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs62")
			end
			yyvsc62 := yyvsc62 + yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.resize (yyvs62, yyvsc62)
		end
	end
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_603 is
			--|#line 3345 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3345 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3345")
end

yyval62 := ast_factory.new_precursor_expression (False, yyvs4.item (yyvsp4), ast_factory.new_precursor_class_name (yyvs5.item (yyvsp5 - 1), yyvs13.item (yyvsp13), yyvs5.item (yyvsp5)), yyvs25.item (yyvsp25)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp62 := yyvsp62 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp5 := yyvsp5 -2
	yyvsp13 := yyvsp13 -1
	yyvsp25 := yyvsp25 -1
	if yyvsp62 >= yyvsc62 then
		if yyvs62 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs62")
			end
			create yyspecial_routines62
			yyvsc62 := yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.make (yyvsc62)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs62")
			end
			yyvsc62 := yyvsc62 + yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.resize (yyvs62, yyvsc62)
		end
	end
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_604 is
			--|#line 3349 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3349 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3349")
end

yyval62 := new_unqualified_call_expression (yyvs13.item (yyvsp13), yyvs25.item (yyvsp25)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp62 := yyvsp62 + 1
	yyvsp13 := yyvsp13 -1
	yyvsp25 := yyvsp25 -1
	if yyvsp62 >= yyvsc62 then
		if yyvs62 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs62")
			end
			create yyspecial_routines62
			yyvsc62 := yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.make (yyvsc62)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs62")
			end
			yyvsc62 := yyvsc62 + yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.resize (yyvs62, yyvsc62)
		end
	end
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_605 is
			--|#line 3351 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3351 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3351")
end

yyval62 := yyvs18.item (yyvsp18) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp62 := yyvsp62 + 1
	yyvsp18 := yyvsp18 -1
	if yyvsp62 >= yyvsc62 then
		if yyvs62 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs62")
			end
			create yyspecial_routines62
			yyvsc62 := yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.make (yyvsc62)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs62")
			end
			yyvsc62 := yyvsc62 + yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.resize (yyvs62, yyvsc62)
		end
	end
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_606 is
			--|#line 3353 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3353 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3353")
end

yyval62 := yyvs11.item (yyvsp11) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp62 := yyvsp62 + 1
	yyvsp11 := yyvsp11 -1
	if yyvsp62 >= yyvsc62 then
		if yyvs62 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs62")
			end
			create yyspecial_routines62
			yyvsc62 := yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.make (yyvsc62)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs62")
			end
			yyvsc62 := yyvsc62 + yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.resize (yyvs62, yyvsc62)
		end
	end
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_607 is
			--|#line 3355 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3355 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3355")
end

yyval62 := yyvs99.item (yyvsp99) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp62 := yyvsp62 + 1
	yyvsp99 := yyvsp99 -1
	if yyvsp62 >= yyvsc62 then
		if yyvs62 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs62")
			end
			create yyspecial_routines62
			yyvsc62 := yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.make (yyvsc62)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs62")
			end
			yyvsc62 := yyvsc62 + yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.resize (yyvs62, yyvsc62)
		end
	end
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_608 is
			--|#line 3357 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3357 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3357")
end

yyval62 := yyvs62.item (yyvsp62) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_609 is
			--|#line 3359 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3359 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3359")
end

			if current_system.is_ise and then current_system.ise_version < ise_5_7_59914 then
				raise_error
			else
				yyval62 := yyvs35.item (yyvsp35)
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp62 := yyvsp62 + 1
	yyvsp35 := yyvsp35 -1
	if yyvsp62 >= yyvsc62 then
		if yyvs62 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs62")
			end
			create yyspecial_routines62
			yyvsc62 := yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.make (yyvsc62)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs62")
			end
			yyvsc62 := yyvsc62 + yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.resize (yyvs62, yyvsc62)
		end
	end
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_610 is
			--|#line 3367 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3367 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3367")
end

yyval62 := yyvs110.item (yyvsp110) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp62 := yyvsp62 + 1
	yyvsp110 := yyvsp110 -1
	if yyvsp62 >= yyvsc62 then
		if yyvs62 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs62")
			end
			create yyspecial_routines62
			yyvsc62 := yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.make (yyvsc62)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs62")
			end
			yyvsc62 := yyvsc62 + yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.resize (yyvs62, yyvsc62)
		end
	end
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_611 is
			--|#line 3369 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3369 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3369")
end

yyval62 := ast_factory.new_call_expression (yyvs62.item (yyvsp62), ast_factory.new_dot_feature_name (yyvs5.item (yyvsp5), yyvs13.item (yyvsp13)), yyvs25.item (yyvsp25)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp5 := yyvsp5 -1
	yyvsp13 := yyvsp13 -1
	yyvsp25 := yyvsp25 -1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_612 is
			--|#line 3375 "et_eiffel_parser.y"
		local
			yyval25: ET_ACTUAL_ARGUMENT_LIST
		do
--|#line 3375 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3375")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp25 := yyvsp25 + 1
	if yyvsp25 >= yyvsc25 then
		if yyvs25 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs25")
			end
			create yyspecial_routines25
			yyvsc25 := yyInitial_yyvs_size
			yyvs25 := yyspecial_routines25.make (yyvsc25)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs25")
			end
			yyvsc25 := yyvsc25 + yyInitial_yyvs_size
			yyvs25 := yyspecial_routines25.resize (yyvs25, yyvsc25)
		end
	end
	yyvs25.put (yyval25, yyvsp25)
end
		end

	yy_do_action_613 is
			--|#line 3377 "et_eiffel_parser.y"
		local
			yyval25: ET_ACTUAL_ARGUMENT_LIST
		do
--|#line 3377 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3377")
end

yyval25 := ast_factory.new_actual_arguments (yyvs5.item (yyvsp5 - 1), yyvs5.item (yyvsp5), 0) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp25 := yyvsp25 + 1
	yyvsp5 := yyvsp5 -2
	if yyvsp25 >= yyvsc25 then
		if yyvs25 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs25")
			end
			create yyspecial_routines25
			yyvsc25 := yyInitial_yyvs_size
			yyvs25 := yyspecial_routines25.make (yyvsc25)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs25")
			end
			yyvsc25 := yyvsc25 + yyInitial_yyvs_size
			yyvs25 := yyspecial_routines25.resize (yyvs25, yyvsc25)
		end
	end
	yyvs25.put (yyval25, yyvsp25)
end
		end

	yy_do_action_614 is
			--|#line 3379 "et_eiffel_parser.y"
		local
			yyval25: ET_ACTUAL_ARGUMENT_LIST
		do
--|#line 3379 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3379")
end

			yyval25 := yyvs25.item (yyvsp25)
			remove_symbol
			remove_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp25 := yyvsp25 -1
	yyvsp5 := yyvsp5 -1
	yyvs25.put (yyval25, yyvsp25)
end
		end

	yy_do_action_615 is
			--|#line 3379 "et_eiffel_parser.y"
		local
			yyval25: ET_ACTUAL_ARGUMENT_LIST
		do
--|#line 3379 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3379")
end

			add_symbol (yyvs5.item (yyvsp5))
			add_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp25 := yyvsp25 + 1
	if yyvsp25 >= yyvsc25 then
		if yyvs25 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs25")
			end
			create yyspecial_routines25
			yyvsc25 := yyInitial_yyvs_size
			yyvs25 := yyspecial_routines25.make (yyvsc25)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs25")
			end
			yyvsc25 := yyvsc25 + yyInitial_yyvs_size
			yyvs25 := yyspecial_routines25.resize (yyvs25, yyvsc25)
		end
	end
	yyvs25.put (yyval25, yyvsp25)
end
		end

	yy_do_action_616 is
			--|#line 3392 "et_eiffel_parser.y"
		local
			yyval25: ET_ACTUAL_ARGUMENT_LIST
		do
--|#line 3392 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3392")
end

			if yyvs62.item (yyvsp62) /= Void then
				yyval25 := ast_factory.new_actual_arguments (last_symbol, yyvs5.item (yyvsp5), counter_value + 1)
				if yyval25 /= Void then
					yyval25.put_first (yyvs62.item (yyvsp62))
				end
			else
				yyval25 := ast_factory.new_actual_arguments (last_symbol, yyvs5.item (yyvsp5), counter_value)
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp25 := yyvsp25 + 1
	yyvsp62 := yyvsp62 -1
	yyvsp5 := yyvsp5 -1
	if yyvsp25 >= yyvsc25 then
		if yyvs25 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs25")
			end
			create yyspecial_routines25
			yyvsc25 := yyInitial_yyvs_size
			yyvs25 := yyspecial_routines25.make (yyvsc25)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs25")
			end
			yyvsc25 := yyvsc25 + yyInitial_yyvs_size
			yyvs25 := yyspecial_routines25.resize (yyvs25, yyvsc25)
		end
	end
	yyvs25.put (yyval25, yyvsp25)
end
		end

	yy_do_action_617 is
			--|#line 3403 "et_eiffel_parser.y"
		local
			yyval25: ET_ACTUAL_ARGUMENT_LIST
		do
--|#line 3403 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3403")
end

			yyval25 := ast_factory.new_actual_arguments (last_symbol, yyvs5.item (yyvsp5), counter_value)
			if yyval25 /= Void and yyvs63.item (yyvsp63) /= Void then
				yyval25.put_first (yyvs63.item (yyvsp63))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp25 := yyvsp25 + 1
	yyvsp63 := yyvsp63 -1
	yyvsp5 := yyvsp5 -1
	if yyvsp25 >= yyvsc25 then
		if yyvs25 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs25")
			end
			create yyspecial_routines25
			yyvsc25 := yyInitial_yyvs_size
			yyvs25 := yyspecial_routines25.make (yyvsc25)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs25")
			end
			yyvsc25 := yyvsc25 + yyInitial_yyvs_size
			yyvs25 := yyspecial_routines25.resize (yyvs25, yyvsc25)
		end
	end
	yyvs25.put (yyval25, yyvsp25)
end
		end

	yy_do_action_618 is
			--|#line 3411 "et_eiffel_parser.y"
		local
			yyval25: ET_ACTUAL_ARGUMENT_LIST
		do
--|#line 3411 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3411")
end

			yyval25 := yyvs25.item (yyvsp25)
			if yyval25 /= Void and yyvs63.item (yyvsp63) /= Void then
				yyval25.put_first (yyvs63.item (yyvsp63))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp63 := yyvsp63 -1
	yyvs25.put (yyval25, yyvsp25)
end
		end

	yy_do_action_619 is
			--|#line 3420 "et_eiffel_parser.y"
		local
			yyval63: ET_EXPRESSION_ITEM
		do
--|#line 3420 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3420")
end

			yyval63 := ast_factory.new_expression_comma (yyvs62.item (yyvsp62), yyvs5.item (yyvsp5))
			if yyval63 /= Void then
				increment_counter
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp63 := yyvsp63 + 1
	yyvsp62 := yyvsp62 -1
	yyvsp5 := yyvsp5 -1
	if yyvsp63 >= yyvsc63 then
		if yyvs63 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs63")
			end
			create yyspecial_routines63
			yyvsc63 := yyInitial_yyvs_size
			yyvs63 := yyspecial_routines63.make (yyvsc63)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs63")
			end
			yyvsc63 := yyvsc63 + yyInitial_yyvs_size
			yyvs63 := yyspecial_routines63.resize (yyvs63, yyvsc63)
		end
	end
	yyvs63.put (yyval63, yyvsp63)
end
		end

	yy_do_action_620 is
			--|#line 3429 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3429 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3429")
end

yyval62 := new_feature_address (yyvs5.item (yyvsp5), yyvs69.item (yyvsp69)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp62 := yyvsp62 + 1
	yyvsp5 := yyvsp5 -1
	yyvsp69 := yyvsp69 -1
	if yyvsp62 >= yyvsc62 then
		if yyvs62 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs62")
			end
			create yyspecial_routines62
			yyvsc62 := yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.make (yyvsc62)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs62")
			end
			yyvsc62 := yyvsc62 + yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.resize (yyvs62, yyvsc62)
		end
	end
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_621 is
			--|#line 3431 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3431 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3431")
end

yyval62 := ast_factory.new_current_address (yyvs5.item (yyvsp5), yyvs11.item (yyvsp11)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp62 := yyvsp62 + 1
	yyvsp5 := yyvsp5 -1
	yyvsp11 := yyvsp11 -1
	if yyvsp62 >= yyvsc62 then
		if yyvs62 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs62")
			end
			create yyspecial_routines62
			yyvsc62 := yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.make (yyvsc62)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs62")
			end
			yyvsc62 := yyvsc62 + yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.resize (yyvs62, yyvsc62)
		end
	end
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_622 is
			--|#line 3433 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3433 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3433")
end

yyval62 := ast_factory.new_result_address (yyvs5.item (yyvsp5), yyvs18.item (yyvsp18)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp62 := yyvsp62 + 1
	yyvsp5 := yyvsp5 -1
	yyvsp18 := yyvsp18 -1
	if yyvsp62 >= yyvsc62 then
		if yyvs62 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs62")
			end
			create yyspecial_routines62
			yyvsc62 := yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.make (yyvsc62)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs62")
			end
			yyvsc62 := yyvsc62 + yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.resize (yyvs62, yyvsc62)
		end
	end
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_623 is
			--|#line 3435 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3435 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3435")
end

yyval62 := ast_factory.new_expression_address (yyvs5.item (yyvsp5), yyvs99.item (yyvsp99)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp62 := yyvsp62 + 1
	yyvsp5 := yyvsp5 -1
	yyvsp99 := yyvsp99 -1
	if yyvsp62 >= yyvsc62 then
		if yyvs62 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs62")
			end
			create yyspecial_routines62
			yyvsc62 := yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.make (yyvsc62)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs62")
			end
			yyvsc62 := yyvsc62 + yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.resize (yyvs62, yyvsc62)
		end
	end
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_624 is
			--|#line 3442 "et_eiffel_parser.y"
		local
			yyval118: ET_WRITABLE
		do
--|#line 3442 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3442")
end

yyval118 := new_writable (yyvs13.item (yyvsp13)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp118 := yyvsp118 + 1
	yyvsp13 := yyvsp13 -1
	if yyvsp118 >= yyvsc118 then
		if yyvs118 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs118")
			end
			create yyspecial_routines118
			yyvsc118 := yyInitial_yyvs_size
			yyvs118 := yyspecial_routines118.make (yyvsc118)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs118")
			end
			yyvsc118 := yyvsc118 + yyInitial_yyvs_size
			yyvs118 := yyspecial_routines118.resize (yyvs118, yyvsc118)
		end
	end
	yyvs118.put (yyval118, yyvsp118)
end
		end

	yy_do_action_625 is
			--|#line 3444 "et_eiffel_parser.y"
		local
			yyval118: ET_WRITABLE
		do
--|#line 3444 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3444")
end

yyval118 := yyvs18.item (yyvsp18) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp118 := yyvsp118 + 1
	yyvsp18 := yyvsp18 -1
	if yyvsp118 >= yyvsc118 then
		if yyvs118 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs118")
			end
			create yyspecial_routines118
			yyvsc118 := yyInitial_yyvs_size
			yyvs118 := yyspecial_routines118.make (yyvsc118)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs118")
			end
			yyvsc118 := yyvsc118 + yyInitial_yyvs_size
			yyvs118 := yyspecial_routines118.resize (yyvs118, yyvsc118)
		end
	end
	yyvs118.put (yyval118, yyvsp118)
end
		end

	yy_do_action_626 is
			--|#line 3450 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3450 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3450")
end

yyval62 := yyvs62.item (yyvsp62) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_627 is
			--|#line 3452 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3452 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3452")
end

yyval62 := yyvs62.item (yyvsp62) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_628 is
			--|#line 3456 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3456 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3456")
end

yyval62 := ast_factory.new_infix_expression (yyvs62.item (yyvsp62 - 1), ast_factory.new_infix_free_operator (yyvs12.item (yyvsp12)), yyvs62.item (yyvsp62)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 -1
	yyvsp12 := yyvsp12 -1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_629 is
			--|#line 3458 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3458 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3458")
end

yyval62 := ast_factory.new_infix_expression (yyvs62.item (yyvsp62 - 1), ast_factory.new_infix_plus_operator (yyvs20.item (yyvsp20)), yyvs62.item (yyvsp62)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 -1
	yyvsp20 := yyvsp20 -1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_630 is
			--|#line 3460 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3460 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3460")
end

yyval62 := ast_factory.new_infix_expression (yyvs62.item (yyvsp62 - 1), ast_factory.new_infix_minus_operator (yyvs20.item (yyvsp20)), yyvs62.item (yyvsp62)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 -1
	yyvsp20 := yyvsp20 -1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_631 is
			--|#line 3462 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3462 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3462")
end

yyval62 := ast_factory.new_infix_expression (yyvs62.item (yyvsp62 - 1), yyvs20.item (yyvsp20), yyvs62.item (yyvsp62)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 -1
	yyvsp20 := yyvsp20 -1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_632 is
			--|#line 3464 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3464 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3464")
end

yyval62 := ast_factory.new_infix_expression (yyvs62.item (yyvsp62 - 1), yyvs20.item (yyvsp20), yyvs62.item (yyvsp62)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 -1
	yyvsp20 := yyvsp20 -1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_633 is
			--|#line 3466 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3466 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3466")
end

yyval62 := ast_factory.new_infix_expression (yyvs62.item (yyvsp62 - 1), yyvs20.item (yyvsp20), yyvs62.item (yyvsp62)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 -1
	yyvsp20 := yyvsp20 -1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_634 is
			--|#line 3468 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3468 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3468")
end

yyval62 := ast_factory.new_infix_expression (yyvs62.item (yyvsp62 - 1), yyvs20.item (yyvsp20), yyvs62.item (yyvsp62)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 -1
	yyvsp20 := yyvsp20 -1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_635 is
			--|#line 3470 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3470 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3470")
end

yyval62 := ast_factory.new_infix_expression (yyvs62.item (yyvsp62 - 1), yyvs20.item (yyvsp20), yyvs62.item (yyvsp62)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 -1
	yyvsp20 := yyvsp20 -1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_636 is
			--|#line 3472 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3472 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3472")
end

yyval62 := ast_factory.new_infix_expression (yyvs62.item (yyvsp62 - 1), yyvs20.item (yyvsp20), yyvs62.item (yyvsp62)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 -1
	yyvsp20 := yyvsp20 -1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_637 is
			--|#line 3474 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3474 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3474")
end

yyval62 := ast_factory.new_infix_expression (yyvs62.item (yyvsp62 - 1), yyvs20.item (yyvsp20), yyvs62.item (yyvsp62)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 -1
	yyvsp20 := yyvsp20 -1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_638 is
			--|#line 3476 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3476 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3476")
end

yyval62 := ast_factory.new_infix_expression (yyvs62.item (yyvsp62 - 1), yyvs20.item (yyvsp20), yyvs62.item (yyvsp62)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 -1
	yyvsp20 := yyvsp20 -1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_639 is
			--|#line 3478 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3478 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3478")
end

yyval62 := ast_factory.new_infix_expression (yyvs62.item (yyvsp62 - 1), yyvs20.item (yyvsp20), yyvs62.item (yyvsp62)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 -1
	yyvsp20 := yyvsp20 -1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_640 is
			--|#line 3480 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3480 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3480")
end

yyval62 := ast_factory.new_infix_expression (yyvs62.item (yyvsp62 - 1), yyvs15.item (yyvsp15), yyvs62.item (yyvsp62)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 -1
	yyvsp15 := yyvsp15 -1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_641 is
			--|#line 3482 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3482 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3482")
end

yyval62 := ast_factory.new_infix_expression (yyvs62.item (yyvsp62 - 1), yyvs15.item (yyvsp15), yyvs62.item (yyvsp62)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 -1
	yyvsp15 := yyvsp15 -1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_642 is
			--|#line 3484 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3484 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3484")
end

yyval62 := ast_factory.new_infix_expression (yyvs62.item (yyvsp62 - 1), yyvs15.item (yyvsp15), yyvs62.item (yyvsp62)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 -1
	yyvsp15 := yyvsp15 -1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_643 is
			--|#line 3486 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3486 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3486")
end

yyval62 := ast_factory.new_infix_expression (yyvs62.item (yyvsp62 - 1), ast_factory.new_infix_and_then_operator (yyvs15.item (yyvsp15), yyvs2.item (yyvsp2)), yyvs62.item (yyvsp62)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp62 := yyvsp62 -1
	yyvsp15 := yyvsp15 -1
	yyvsp2 := yyvsp2 -1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_644 is
			--|#line 3488 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3488 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3488")
end

yyval62 := ast_factory.new_infix_expression (yyvs62.item (yyvsp62 - 1), ast_factory.new_infix_or_else_operator (yyvs15.item (yyvsp15), yyvs2.item (yyvsp2)), yyvs62.item (yyvsp62)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp62 := yyvsp62 -1
	yyvsp15 := yyvsp15 -1
	yyvsp2 := yyvsp2 -1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_645 is
			--|#line 3490 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3490 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3490")
end

yyval62 := ast_factory.new_infix_expression (yyvs62.item (yyvsp62 - 1), yyvs15.item (yyvsp15), yyvs62.item (yyvsp62)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 -1
	yyvsp15 := yyvsp15 -1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_646 is
			--|#line 3492 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3492 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3492")
end

yyval62 := ast_factory.new_equality_expression (yyvs62.item (yyvsp62 - 1), yyvs5.item (yyvsp5), yyvs62.item (yyvsp62)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 -1
	yyvsp5 := yyvsp5 -1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_647 is
			--|#line 3494 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3494 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3494")
end

yyval62 := ast_factory.new_equality_expression (yyvs62.item (yyvsp62 - 1), yyvs5.item (yyvsp5), yyvs62.item (yyvsp62)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 -1
	yyvsp5 := yyvsp5 -1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_648 is
			--|#line 3496 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3496 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3496")
end

yyval62 := ast_factory.new_object_equality_expression (yyvs62.item (yyvsp62 - 1), yyvs5.item (yyvsp5), yyvs62.item (yyvsp62)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 -1
	yyvsp5 := yyvsp5 -1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_649 is
			--|#line 3498 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3498 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3498")
end

yyval62 := ast_factory.new_object_equality_expression (yyvs62.item (yyvsp62 - 1), yyvs5.item (yyvsp5), yyvs62.item (yyvsp62)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 -1
	yyvsp5 := yyvsp5 -1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_650 is
			--|#line 3502 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3502 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3502")
end

yyval62 := yyvs62.item (yyvsp62) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_651 is
			--|#line 3504 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3504 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3504")
end

yyval62 := yyvs35.item (yyvsp35) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp62 := yyvsp62 + 1
	yyvsp35 := yyvsp35 -1
	if yyvsp62 >= yyvsc62 then
		if yyvs62 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs62")
			end
			create yyspecial_routines62
			yyvsc62 := yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.make (yyvsc62)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs62")
			end
			yyvsc62 := yyvsc62 + yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.resize (yyvs62, yyvsc62)
		end
	end
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_652 is
			--|#line 3506 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3506 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3506")
end

yyval62 := yyvs54.item (yyvsp54) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp62 := yyvsp62 + 1
	yyvsp54 := yyvsp54 -1
	if yyvsp62 >= yyvsc62 then
		if yyvs62 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs62")
			end
			create yyspecial_routines62
			yyvsc62 := yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.make (yyvsc62)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs62")
			end
			yyvsc62 := yyvsc62 + yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.resize (yyvs62, yyvsc62)
		end
	end
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_653 is
			--|#line 3508 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3508 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3508")
end

yyval62 := yyvs96.item (yyvsp96) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp62 := yyvsp62 + 1
	yyvsp96 := yyvsp96 -1
	if yyvsp62 >= yyvsc62 then
		if yyvs62 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs62")
			end
			create yyspecial_routines62
			yyvsc62 := yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.make (yyvsc62)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs62")
			end
			yyvsc62 := yyvsc62 + yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.resize (yyvs62, yyvsc62)
		end
	end
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_654 is
			--|#line 3510 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3510 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3510")
end

yyval62 := new_prefix_plus_expression (yyvs20.item (yyvsp20), yyvs62.item (yyvsp62)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp20 := yyvsp20 -1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_655 is
			--|#line 3512 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3512 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3512")
end

yyval62 := new_prefix_minus_expression (yyvs20.item (yyvsp20), yyvs62.item (yyvsp62)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp20 := yyvsp20 -1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_656 is
			--|#line 3514 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3514 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3514")
end

yyval62 := ast_factory.new_prefix_expression (yyvs15.item (yyvsp15), yyvs62.item (yyvsp62)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp15 := yyvsp15 -1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_657 is
			--|#line 3516 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3516 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3516")
end

yyval62 := ast_factory.new_prefix_expression (ast_factory.new_prefix_free_operator (yyvs12.item (yyvsp12)), yyvs62.item (yyvsp62)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp12 := yyvsp12 -1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_658 is
			--|#line 3518 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3518 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3518")
end

yyval62 := ast_factory.new_old_expression (yyvs2.item (yyvsp2), yyvs62.item (yyvsp62)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp2 := yyvsp2 -1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_659 is
			--|#line 3520 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3520 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3520")
end

			if current_system.is_ise and then current_system.ise_version < ise_6_1_0 then
				raise_error
			else
				yyval62 := new_object_test (yyvs5.item (yyvsp5 - 2), yyvs13.item (yyvsp13), yyvs5.item (yyvsp5 - 1), yyvs112.item (yyvsp112), yyvs5.item (yyvsp5), yyvs62.item (yyvsp62))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp5 := yyvsp5 -3
	yyvsp13 := yyvsp13 -1
	yyvsp112 := yyvsp112 -1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_660 is
			--|#line 3530 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3530 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3530")
end

yyval62 := yyvs62.item (yyvsp62) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_661 is
			--|#line 3532 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3532 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3532")
end

yyval62 := yyvs110.item (yyvsp110) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp62 := yyvsp62 + 1
	yyvsp110 := yyvsp110 -1
	if yyvsp62 >= yyvsc62 then
		if yyvs62 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs62")
			end
			create yyspecial_routines62
			yyvsc62 := yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.make (yyvsc62)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs62")
			end
			yyvsc62 := yyvsc62 + yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.resize (yyvs62, yyvsc62)
		end
	end
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_662 is
			--|#line 3534 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3534 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3534")
end

yyval62 := yyvs62.item (yyvsp62) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_663 is
			--|#line 3536 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3536 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3536")
end

yyval62 := yyvs18.item (yyvsp18) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp62 := yyvsp62 + 1
	yyvsp18 := yyvsp18 -1
	if yyvsp62 >= yyvsc62 then
		if yyvs62 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs62")
			end
			create yyspecial_routines62
			yyvsc62 := yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.make (yyvsc62)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs62")
			end
			yyvsc62 := yyvsc62 + yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.resize (yyvs62, yyvsc62)
		end
	end
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_664 is
			--|#line 3538 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3538 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3538")
end

yyval62 := yyvs11.item (yyvsp11) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp62 := yyvsp62 + 1
	yyvsp11 := yyvsp11 -1
	if yyvsp62 >= yyvsc62 then
		if yyvs62 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs62")
			end
			create yyspecial_routines62
			yyvsc62 := yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.make (yyvsc62)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs62")
			end
			yyvsc62 := yyvsc62 + yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.resize (yyvs62, yyvsc62)
		end
	end
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_665 is
			--|#line 3540 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3540 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3540")
end

yyval62 := yyvs99.item (yyvsp99) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp62 := yyvsp62 + 1
	yyvsp99 := yyvsp99 -1
	if yyvsp62 >= yyvsc62 then
		if yyvs62 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs62")
			end
			create yyspecial_routines62
			yyvsc62 := yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.make (yyvsc62)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs62")
			end
			yyvsc62 := yyvsc62 + yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.resize (yyvs62, yyvsc62)
		end
	end
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_666 is
			--|#line 3542 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3542 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3542")
end

yyval62 := yyvs8.item (yyvsp8) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp62 := yyvsp62 + 1
	yyvsp8 := yyvsp8 -1
	if yyvsp62 >= yyvsc62 then
		if yyvs62 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs62")
			end
			create yyspecial_routines62
			yyvsc62 := yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.make (yyvsc62)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs62")
			end
			yyvsc62 := yyvsc62 + yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.resize (yyvs62, yyvsc62)
		end
	end
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_667 is
			--|#line 3544 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3544 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3544")
end

yyval62 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp62 := yyvsp62 + 1
	yyvsp14 := yyvsp14 -1
	if yyvsp62 >= yyvsc62 then
		if yyvs62 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs62")
			end
			create yyspecial_routines62
			yyvsc62 := yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.make (yyvsc62)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs62")
			end
			yyvsc62 := yyvsc62 + yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.resize (yyvs62, yyvsc62)
		end
	end
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_668 is
			--|#line 3546 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3546 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3546")
end

yyval62 := yyvs17.item (yyvsp17) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp62 := yyvsp62 + 1
	yyvsp17 := yyvsp17 -1
	if yyvsp62 >= yyvsc62 then
		if yyvs62 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs62")
			end
			create yyspecial_routines62
			yyvsc62 := yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.make (yyvsc62)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs62")
			end
			yyvsc62 := yyvsc62 + yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.resize (yyvs62, yyvsc62)
		end
	end
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_669 is
			--|#line 3548 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3548 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3548")
end

yyval62 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp62 := yyvsp62 + 1
	yyvsp14 := yyvsp14 -1
	if yyvsp62 >= yyvsc62 then
		if yyvs62 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs62")
			end
			create yyspecial_routines62
			yyvsc62 := yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.make (yyvsc62)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs62")
			end
			yyvsc62 := yyvsc62 + yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.resize (yyvs62, yyvsc62)
		end
	end
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_670 is
			--|#line 3550 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3550 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3550")
end

yyval62 := yyvs17.item (yyvsp17) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp62 := yyvsp62 + 1
	yyvsp17 := yyvsp17 -1
	if yyvsp62 >= yyvsc62 then
		if yyvs62 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs62")
			end
			create yyspecial_routines62
			yyvsc62 := yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.make (yyvsc62)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs62")
			end
			yyvsc62 := yyvsc62 + yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.resize (yyvs62, yyvsc62)
		end
	end
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_671 is
			--|#line 3552 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3552 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3552")
end

yyval62 := yyvs62.item (yyvsp62) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_672 is
			--|#line 3554 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3554 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3554")
end

yyval62 := yyvs36.item (yyvsp36) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp62 := yyvsp62 + 1
	yyvsp36 := yyvsp36 -1
	if yyvsp62 >= yyvsc62 then
		if yyvs62 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs62")
			end
			create yyspecial_routines62
			yyvsc62 := yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.make (yyvsc62)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs62")
			end
			yyvsc62 := yyvsc62 + yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.resize (yyvs62, yyvsc62)
		end
	end
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_673 is
			--|#line 3556 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3556 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3556")
end

yyval62 := yyvs83.item (yyvsp83) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp62 := yyvsp62 + 1
	yyvsp83 := yyvsp83 -1
	if yyvsp62 >= yyvsc62 then
		if yyvs62 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs62")
			end
			create yyspecial_routines62
			yyvsc62 := yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.make (yyvsc62)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs62")
			end
			yyvsc62 := yyvsc62 + yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.resize (yyvs62, yyvsc62)
		end
	end
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_674 is
			--|#line 3558 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3558 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3558")
end

yyval62 := yyvs21.item (yyvsp21) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp62 := yyvsp62 + 1
	yyvsp21 := yyvsp21 -1
	if yyvsp62 >= yyvsc62 then
		if yyvs62 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs62")
			end
			create yyspecial_routines62
			yyvsc62 := yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.make (yyvsc62)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs62")
			end
			yyvsc62 := yyvsc62 + yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.resize (yyvs62, yyvsc62)
		end
	end
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_675 is
			--|#line 3560 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3560 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3560")
end

yyval62 := yyvs10.item (yyvsp10) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp62 := yyvsp62 + 1
	yyvsp10 := yyvsp10 -1
	if yyvsp62 >= yyvsc62 then
		if yyvs62 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs62")
			end
			create yyspecial_routines62
			yyvsc62 := yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.make (yyvsc62)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs62")
			end
			yyvsc62 := yyvsc62 + yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.resize (yyvs62, yyvsc62)
		end
	end
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_676 is
			--|#line 3562 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3562 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3562")
end

yyval62 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp62 := yyvsp62 + 1
	yyvsp16 := yyvsp16 -1
	if yyvsp62 >= yyvsc62 then
		if yyvs62 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs62")
			end
			create yyspecial_routines62
			yyvsc62 := yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.make (yyvsc62)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs62")
			end
			yyvsc62 := yyvsc62 + yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.resize (yyvs62, yyvsc62)
		end
	end
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_677 is
			--|#line 3564 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3564 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3564")
end

yyval62 := new_once_manifest_string (yyvs2.item (yyvsp2), yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp62 := yyvsp62 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp62 >= yyvsc62 then
		if yyvs62 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs62")
			end
			create yyspecial_routines62
			yyvsc62 := yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.make (yyvsc62)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs62")
			end
			yyvsc62 := yyvsc62 + yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.resize (yyvs62, yyvsc62)
		end
	end
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_678 is
			--|#line 3579 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3579 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3579")
end

yyval62 := yyvs7.item (yyvsp7) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp62 := yyvsp62 + 1
	yyvsp7 := yyvsp7 -1
	if yyvsp62 >= yyvsc62 then
		if yyvs62 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs62")
			end
			create yyspecial_routines62
			yyvsc62 := yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.make (yyvsc62)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs62")
			end
			yyvsc62 := yyvsc62 + yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.resize (yyvs62, yyvsc62)
		end
	end
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_679 is
			--|#line 3581 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3581 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3581")
end

yyval62 := yyvs93.item (yyvsp93) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp62 := yyvsp62 + 1
	yyvsp93 := yyvsp93 -1
	if yyvsp62 >= yyvsc62 then
		if yyvs62 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs62")
			end
			create yyspecial_routines62
			yyvsc62 := yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.make (yyvsc62)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs62")
			end
			yyvsc62 := yyvsc62 + yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.resize (yyvs62, yyvsc62)
		end
	end
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_680 is
			--|#line 3583 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3583 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3583")
end

yyval62 := yyvs111.item (yyvsp111) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp62 := yyvsp62 + 1
	yyvsp111 := yyvsp111 -1
	if yyvsp62 >= yyvsc62 then
		if yyvs62 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs62")
			end
			create yyspecial_routines62
			yyvsc62 := yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.make (yyvsc62)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs62")
			end
			yyvsc62 := yyvsc62 + yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.resize (yyvs62, yyvsc62)
		end
	end
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_681 is
			--|#line 3585 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3585 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3585")
end

yyval62 := yyvs62.item (yyvsp62) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_682 is
			--|#line 3589 "et_eiffel_parser.y"
		local
			yyval35: ET_BRACKET_EXPRESSION
		do
--|#line 3589 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3589")
end

			yyval35 := ast_factory.new_bracket_expression (yyvs62.item (yyvsp62), yyvs23.item (yyvsp23), yyvs34.item (yyvsp34))
			remove_symbol
			remove_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp62 := yyvsp62 -1
	yyvsp23 := yyvsp23 -1
	yyvsp34 := yyvsp34 -1
	yyvs35.put (yyval35, yyvsp35)
end
		end

	yy_do_action_683 is
			--|#line 3589 "et_eiffel_parser.y"
		local
			yyval35: ET_BRACKET_EXPRESSION
		do
--|#line 3589 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3589")
end

			add_symbol (yyvs23.item (yyvsp23))
			add_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp35 := yyvsp35 + 1
	if yyvsp35 >= yyvsc35 then
		if yyvs35 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs35")
			end
			create yyspecial_routines35
			yyvsc35 := yyInitial_yyvs_size
			yyvs35 := yyspecial_routines35.make (yyvsc35)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs35")
			end
			yyvsc35 := yyvsc35 + yyInitial_yyvs_size
			yyvs35 := yyspecial_routines35.resize (yyvs35, yyvsc35)
		end
	end
	yyvs35.put (yyval35, yyvsp35)
end
		end

	yy_do_action_684 is
			--|#line 3602 "et_eiffel_parser.y"
		local
			yyval34: ET_BRACKET_ARGUMENT_LIST
		do
--|#line 3602 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3602")
end

			if yyvs62.item (yyvsp62) /= Void then
				yyval34 := ast_factory.new_bracket_arguments (last_symbol, yyvs5.item (yyvsp5), counter_value + 1)
				if yyval34 /= Void then
					yyval34.put_first (yyvs62.item (yyvsp62))
				end
			else
				yyval34 := ast_factory.new_bracket_arguments (last_symbol, yyvs5.item (yyvsp5), counter_value)
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp34 := yyvsp34 + 1
	yyvsp62 := yyvsp62 -1
	yyvsp5 := yyvsp5 -1
	if yyvsp34 >= yyvsc34 then
		if yyvs34 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs34")
			end
			create yyspecial_routines34
			yyvsc34 := yyInitial_yyvs_size
			yyvs34 := yyspecial_routines34.make (yyvsc34)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs34")
			end
			yyvsc34 := yyvsc34 + yyInitial_yyvs_size
			yyvs34 := yyspecial_routines34.resize (yyvs34, yyvsc34)
		end
	end
	yyvs34.put (yyval34, yyvsp34)
end
		end

	yy_do_action_685 is
			--|#line 3613 "et_eiffel_parser.y"
		local
			yyval34: ET_BRACKET_ARGUMENT_LIST
		do
--|#line 3613 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3613")
end

			yyval34 := ast_factory.new_bracket_arguments (last_symbol, yyvs5.item (yyvsp5), counter_value)
			if yyval34 /= Void and yyvs63.item (yyvsp63) /= Void then
				yyval34.put_first (yyvs63.item (yyvsp63))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp34 := yyvsp34 + 1
	yyvsp63 := yyvsp63 -1
	yyvsp5 := yyvsp5 -1
	if yyvsp34 >= yyvsc34 then
		if yyvs34 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs34")
			end
			create yyspecial_routines34
			yyvsc34 := yyInitial_yyvs_size
			yyvs34 := yyspecial_routines34.make (yyvsc34)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs34")
			end
			yyvsc34 := yyvsc34 + yyInitial_yyvs_size
			yyvs34 := yyspecial_routines34.resize (yyvs34, yyvsc34)
		end
	end
	yyvs34.put (yyval34, yyvsp34)
end
		end

	yy_do_action_686 is
			--|#line 3621 "et_eiffel_parser.y"
		local
			yyval34: ET_BRACKET_ARGUMENT_LIST
		do
--|#line 3621 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3621")
end

			yyval34 := yyvs34.item (yyvsp34)
			if yyval34 /= Void and yyvs63.item (yyvsp63) /= Void then
				yyval34.put_first (yyvs63.item (yyvsp63))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp63 := yyvsp63 -1
	yyvs34.put (yyval34, yyvsp34)
end
		end

	yy_do_action_687 is
			--|#line 3630 "et_eiffel_parser.y"
		local
			yyval99: ET_PARENTHESIZED_EXPRESSION
		do
--|#line 3630 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3630")
end

			remove_symbol
			remove_counter
		 	yyval99 := ast_factory.new_parenthesized_expression (yyvs5.item (yyvsp5 - 1), yyvs62.item (yyvsp62), yyvs5.item (yyvsp5))
		 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp99 := yyvsp99 + 1
	yyvsp5 := yyvsp5 -2
	yyvsp62 := yyvsp62 -1
	if yyvsp99 >= yyvsc99 then
		if yyvs99 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs99")
			end
			create yyspecial_routines99
			yyvsc99 := yyInitial_yyvs_size
			yyvs99 := yyspecial_routines99.make (yyvsc99)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs99")
			end
			yyvsc99 := yyvsc99 + yyInitial_yyvs_size
			yyvs99 := yyspecial_routines99.resize (yyvs99, yyvsc99)
		end
	end
	yyvs99.put (yyval99, yyvsp99)
end
		end

	yy_do_action_688 is
			--|#line 3638 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3638 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3638")
end

yyval62 := ast_factory.new_manifest_type (yyvs5.item (yyvsp5 - 1), yyvs112.item (yyvsp112), yyvs5.item (yyvsp5)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 + 1
	yyvsp5 := yyvsp5 -2
	yyvsp112 := yyvsp112 -1
	if yyvsp62 >= yyvsc62 then
		if yyvs62 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs62")
			end
			create yyspecial_routines62
			yyvsc62 := yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.make (yyvsc62)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs62")
			end
			yyvsc62 := yyvsc62 + yyInitial_yyvs_size
			yyvs62 := yyspecial_routines62.resize (yyvs62, yyvsc62)
		end
	end
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_689 is
			--|#line 3642 "et_eiffel_parser.y"
		local
			yyval93: ET_MANIFEST_ARRAY
		do
--|#line 3642 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3642")
end

yyval93 := ast_factory.new_manifest_array (yyvs5.item (yyvsp5 - 1), yyvs5.item (yyvsp5), 0) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp93 := yyvsp93 + 1
	yyvsp5 := yyvsp5 -2
	if yyvsp93 >= yyvsc93 then
		if yyvs93 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs93")
			end
			create yyspecial_routines93
			yyvsc93 := yyInitial_yyvs_size
			yyvs93 := yyspecial_routines93.make (yyvsc93)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs93")
			end
			yyvsc93 := yyvsc93 + yyInitial_yyvs_size
			yyvs93 := yyspecial_routines93.resize (yyvs93, yyvsc93)
		end
	end
	yyvs93.put (yyval93, yyvsp93)
end
		end

	yy_do_action_690 is
			--|#line 3644 "et_eiffel_parser.y"
		local
			yyval93: ET_MANIFEST_ARRAY
		do
--|#line 3644 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3644")
end

			yyval93 := yyvs93.item (yyvsp93)
			remove_symbol
			remove_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp93 := yyvsp93 -1
	yyvsp5 := yyvsp5 -1
	yyvs93.put (yyval93, yyvsp93)
end
		end

	yy_do_action_691 is
			--|#line 3644 "et_eiffel_parser.y"
		local
			yyval93: ET_MANIFEST_ARRAY
		do
--|#line 3644 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3644")
end

			add_symbol (yyvs5.item (yyvsp5))
			add_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp93 := yyvsp93 + 1
	if yyvsp93 >= yyvsc93 then
		if yyvs93 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs93")
			end
			create yyspecial_routines93
			yyvsc93 := yyInitial_yyvs_size
			yyvs93 := yyspecial_routines93.make (yyvsc93)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs93")
			end
			yyvsc93 := yyvsc93 + yyInitial_yyvs_size
			yyvs93 := yyspecial_routines93.resize (yyvs93, yyvsc93)
		end
	end
	yyvs93.put (yyval93, yyvsp93)
end
		end

	yy_do_action_692 is
			--|#line 3657 "et_eiffel_parser.y"
		local
			yyval93: ET_MANIFEST_ARRAY
		do
--|#line 3657 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3657")
end

			if yyvs62.item (yyvsp62) /= Void then
				yyval93 := ast_factory.new_manifest_array (last_symbol, yyvs5.item (yyvsp5), counter_value + 1)
				if yyval93 /= Void then
					yyval93.put_first (yyvs62.item (yyvsp62))
				end
			else
				yyval93 := ast_factory.new_manifest_array (last_symbol, yyvs5.item (yyvsp5), counter_value)
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp93 := yyvsp93 + 1
	yyvsp62 := yyvsp62 -1
	yyvsp5 := yyvsp5 -1
	if yyvsp93 >= yyvsc93 then
		if yyvs93 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs93")
			end
			create yyspecial_routines93
			yyvsc93 := yyInitial_yyvs_size
			yyvs93 := yyspecial_routines93.make (yyvsc93)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs93")
			end
			yyvsc93 := yyvsc93 + yyInitial_yyvs_size
			yyvs93 := yyspecial_routines93.resize (yyvs93, yyvsc93)
		end
	end
	yyvs93.put (yyval93, yyvsp93)
end
		end

	yy_do_action_693 is
			--|#line 3668 "et_eiffel_parser.y"
		local
			yyval93: ET_MANIFEST_ARRAY
		do
--|#line 3668 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3668")
end

			yyval93 := ast_factory.new_manifest_array (last_symbol, yyvs5.item (yyvsp5), counter_value)
			if yyval93 /= Void and yyvs63.item (yyvsp63) /= Void then
				yyval93.put_first (yyvs63.item (yyvsp63))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp93 := yyvsp93 + 1
	yyvsp63 := yyvsp63 -1
	yyvsp5 := yyvsp5 -1
	if yyvsp93 >= yyvsc93 then
		if yyvs93 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs93")
			end
			create yyspecial_routines93
			yyvsc93 := yyInitial_yyvs_size
			yyvs93 := yyspecial_routines93.make (yyvsc93)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs93")
			end
			yyvsc93 := yyvsc93 + yyInitial_yyvs_size
			yyvs93 := yyspecial_routines93.resize (yyvs93, yyvsc93)
		end
	end
	yyvs93.put (yyval93, yyvsp93)
end
		end

	yy_do_action_694 is
			--|#line 3676 "et_eiffel_parser.y"
		local
			yyval93: ET_MANIFEST_ARRAY
		do
--|#line 3676 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3676")
end

			yyval93 := yyvs93.item (yyvsp93)
			if yyval93 /= Void and yyvs63.item (yyvsp63) /= Void then
				yyval93.put_first (yyvs63.item (yyvsp63))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp63 := yyvsp63 -1
	yyvs93.put (yyval93, yyvsp93)
end
		end

	yy_do_action_695 is
			--|#line 3685 "et_eiffel_parser.y"
		local
			yyval96: ET_MANIFEST_TUPLE
		do
--|#line 3685 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3685")
end

yyval96 := ast_factory.new_manifest_tuple (yyvs23.item (yyvsp23), yyvs5.item (yyvsp5), 0) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp96 := yyvsp96 + 1
	yyvsp23 := yyvsp23 -1
	yyvsp5 := yyvsp5 -1
	if yyvsp96 >= yyvsc96 then
		if yyvs96 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs96")
			end
			create yyspecial_routines96
			yyvsc96 := yyInitial_yyvs_size
			yyvs96 := yyspecial_routines96.make (yyvsc96)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs96")
			end
			yyvsc96 := yyvsc96 + yyInitial_yyvs_size
			yyvs96 := yyspecial_routines96.resize (yyvs96, yyvsc96)
		end
	end
	yyvs96.put (yyval96, yyvsp96)
end
		end

	yy_do_action_696 is
			--|#line 3687 "et_eiffel_parser.y"
		local
			yyval96: ET_MANIFEST_TUPLE
		do
--|#line 3687 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3687")
end

			yyval96 := yyvs96.item (yyvsp96)
			remove_symbol
			remove_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp96 := yyvsp96 -1
	yyvsp23 := yyvsp23 -1
	yyvs96.put (yyval96, yyvsp96)
end
		end

	yy_do_action_697 is
			--|#line 3687 "et_eiffel_parser.y"
		local
			yyval96: ET_MANIFEST_TUPLE
		do
--|#line 3687 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3687")
end

			add_symbol (yyvs23.item (yyvsp23))
			add_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp96 := yyvsp96 + 1
	if yyvsp96 >= yyvsc96 then
		if yyvs96 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs96")
			end
			create yyspecial_routines96
			yyvsc96 := yyInitial_yyvs_size
			yyvs96 := yyspecial_routines96.make (yyvsc96)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs96")
			end
			yyvsc96 := yyvsc96 + yyInitial_yyvs_size
			yyvs96 := yyspecial_routines96.resize (yyvs96, yyvsc96)
		end
	end
	yyvs96.put (yyval96, yyvsp96)
end
		end

	yy_do_action_698 is
			--|#line 3700 "et_eiffel_parser.y"
		local
			yyval96: ET_MANIFEST_TUPLE
		do
--|#line 3700 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3700")
end

			if yyvs62.item (yyvsp62) /= Void then
				yyval96 := ast_factory.new_manifest_tuple (last_symbol, yyvs5.item (yyvsp5), counter_value + 1)
				if yyval96 /= Void then
					yyval96.put_first (yyvs62.item (yyvsp62))
				end
			else
				yyval96 := ast_factory.new_manifest_tuple (last_symbol, yyvs5.item (yyvsp5), counter_value)
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp96 := yyvsp96 + 1
	yyvsp62 := yyvsp62 -1
	yyvsp5 := yyvsp5 -1
	if yyvsp96 >= yyvsc96 then
		if yyvs96 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs96")
			end
			create yyspecial_routines96
			yyvsc96 := yyInitial_yyvs_size
			yyvs96 := yyspecial_routines96.make (yyvsc96)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs96")
			end
			yyvsc96 := yyvsc96 + yyInitial_yyvs_size
			yyvs96 := yyspecial_routines96.resize (yyvs96, yyvsc96)
		end
	end
	yyvs96.put (yyval96, yyvsp96)
end
		end

	yy_do_action_699 is
			--|#line 3711 "et_eiffel_parser.y"
		local
			yyval96: ET_MANIFEST_TUPLE
		do
--|#line 3711 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3711")
end

			yyval96 := ast_factory.new_manifest_tuple (last_symbol, yyvs5.item (yyvsp5), counter_value)
			if yyval96 /= Void and yyvs63.item (yyvsp63) /= Void then
				yyval96.put_first (yyvs63.item (yyvsp63))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp96 := yyvsp96 + 1
	yyvsp63 := yyvsp63 -1
	yyvsp5 := yyvsp5 -1
	if yyvsp96 >= yyvsc96 then
		if yyvs96 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs96")
			end
			create yyspecial_routines96
			yyvsc96 := yyInitial_yyvs_size
			yyvs96 := yyspecial_routines96.make (yyvsc96)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs96")
			end
			yyvsc96 := yyvsc96 + yyInitial_yyvs_size
			yyvs96 := yyspecial_routines96.resize (yyvs96, yyvsc96)
		end
	end
	yyvs96.put (yyval96, yyvsp96)
end
		end

	yy_do_action_700 is
			--|#line 3719 "et_eiffel_parser.y"
		local
			yyval96: ET_MANIFEST_TUPLE
		do
--|#line 3719 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3719")
end

			yyval96 := yyvs96.item (yyvsp96)
			if yyval96 /= Void and yyvs63.item (yyvsp63) /= Void then
				yyval96.put_first (yyvs63.item (yyvsp63))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp63 := yyvsp63 -1
	yyvs96.put (yyval96, yyvsp96)
end
		end

	yy_do_action_701 is
			--|#line 3728 "et_eiffel_parser.y"
		local
			yyval111: ET_STRIP_EXPRESSION
		do
--|#line 3728 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3728")
end

yyval111 := ast_factory.new_strip_expression (yyvs2.item (yyvsp2), yyvs5.item (yyvsp5 - 1), yyvs5.item (yyvsp5), 0) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp111 := yyvsp111 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp5 := yyvsp5 -2
	if yyvsp111 >= yyvsc111 then
		if yyvs111 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs111")
			end
			create yyspecial_routines111
			yyvsc111 := yyInitial_yyvs_size
			yyvs111 := yyspecial_routines111.make (yyvsc111)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs111")
			end
			yyvsc111 := yyvsc111 + yyInitial_yyvs_size
			yyvs111 := yyspecial_routines111.resize (yyvs111, yyvsc111)
		end
	end
	yyvs111.put (yyval111, yyvsp111)
end
		end

	yy_do_action_702 is
			--|#line 3730 "et_eiffel_parser.y"
		local
			yyval111: ET_STRIP_EXPRESSION
		do
--|#line 3730 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3730")
end

			yyval111 := yyvs111.item (yyvsp111)
			remove_keyword
			remove_symbol
			remove_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp111 := yyvsp111 -1
	yyvsp2 := yyvsp2 -1
	yyvsp5 := yyvsp5 -1
	yyvs111.put (yyval111, yyvsp111)
end
		end

	yy_do_action_703 is
			--|#line 3730 "et_eiffel_parser.y"
		local
			yyval111: ET_STRIP_EXPRESSION
		do
--|#line 3730 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3730")
end

			add_keyword (yyvs2.item (yyvsp2))
			add_symbol (yyvs5.item (yyvsp5))
			add_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp111 := yyvsp111 + 1
	if yyvsp111 >= yyvsc111 then
		if yyvs111 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs111")
			end
			create yyspecial_routines111
			yyvsc111 := yyInitial_yyvs_size
			yyvs111 := yyspecial_routines111.make (yyvsc111)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs111")
			end
			yyvsc111 := yyvsc111 + yyInitial_yyvs_size
			yyvs111 := yyspecial_routines111.resize (yyvs111, yyvsc111)
		end
	end
	yyvs111.put (yyval111, yyvsp111)
end
		end

	yy_do_action_704 is
			--|#line 3745 "et_eiffel_parser.y"
		local
			yyval111: ET_STRIP_EXPRESSION
		do
--|#line 3745 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3745")
end

			if yyvs69.item (yyvsp69) /= Void then
				yyval111 := ast_factory.new_strip_expression (last_keyword, last_symbol, yyvs5.item (yyvsp5), counter_value + 1)
				if yyval111 /= Void then
					yyval111.put_first (yyvs69.item (yyvsp69))
				end
			else
				yyval111 := ast_factory.new_strip_expression (last_keyword, last_symbol, yyvs5.item (yyvsp5), counter_value)
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp111 := yyvsp111 + 1
	yyvsp69 := yyvsp69 -1
	yyvsp5 := yyvsp5 -1
	if yyvsp111 >= yyvsc111 then
		if yyvs111 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs111")
			end
			create yyspecial_routines111
			yyvsc111 := yyInitial_yyvs_size
			yyvs111 := yyspecial_routines111.make (yyvsc111)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs111")
			end
			yyvsc111 := yyvsc111 + yyInitial_yyvs_size
			yyvs111 := yyspecial_routines111.resize (yyvs111, yyvsc111)
		end
	end
	yyvs111.put (yyval111, yyvsp111)
end
		end

	yy_do_action_705 is
			--|#line 3756 "et_eiffel_parser.y"
		local
			yyval111: ET_STRIP_EXPRESSION
		do
--|#line 3756 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3756")
end

			yyval111 := ast_factory.new_strip_expression (last_keyword, last_symbol, yyvs5.item (yyvsp5), counter_value)
			if yyval111 /= Void and yyvs70.item (yyvsp70) /= Void then
				yyval111.put_first (yyvs70.item (yyvsp70))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp111 := yyvsp111 + 1
	yyvsp70 := yyvsp70 -1
	yyvsp5 := yyvsp5 -1
	if yyvsp111 >= yyvsc111 then
		if yyvs111 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs111")
			end
			create yyspecial_routines111
			yyvsc111 := yyInitial_yyvs_size
			yyvs111 := yyspecial_routines111.make (yyvsc111)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs111")
			end
			yyvsc111 := yyvsc111 + yyInitial_yyvs_size
			yyvs111 := yyspecial_routines111.resize (yyvs111, yyvsc111)
		end
	end
	yyvs111.put (yyval111, yyvsp111)
end
		end

	yy_do_action_706 is
			--|#line 3764 "et_eiffel_parser.y"
		local
			yyval111: ET_STRIP_EXPRESSION
		do
--|#line 3764 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3764")
end

			yyval111 := yyvs111.item (yyvsp111)
			if yyval111 /= Void and yyvs70.item (yyvsp70) /= Void then
				yyval111.put_first (yyvs70.item (yyvsp70))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp70 := yyvsp70 -1
	yyvs111.put (yyval111, yyvsp111)
end
		end

	yy_do_action_707 is
			--|#line 3773 "et_eiffel_parser.y"
		local
			yyval46: ET_CONSTANT
		do
--|#line 3773 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3773")
end

yyval46 := yyvs8.item (yyvsp8) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp46 := yyvsp46 + 1
	yyvsp8 := yyvsp8 -1
	if yyvsp46 >= yyvsc46 then
		if yyvs46 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs46")
			end
			create yyspecial_routines46
			yyvsc46 := yyInitial_yyvs_size
			yyvs46 := yyspecial_routines46.make (yyvsc46)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs46")
			end
			yyvsc46 := yyvsc46 + yyInitial_yyvs_size
			yyvs46 := yyspecial_routines46.resize (yyvs46, yyvsc46)
		end
	end
	yyvs46.put (yyval46, yyvsp46)
end
		end

	yy_do_action_708 is
			--|#line 3775 "et_eiffel_parser.y"
		local
			yyval46: ET_CONSTANT
		do
--|#line 3775 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3775")
end

yyval46 := yyvs10.item (yyvsp10) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp46 := yyvsp46 + 1
	yyvsp10 := yyvsp10 -1
	if yyvsp46 >= yyvsc46 then
		if yyvs46 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs46")
			end
			create yyspecial_routines46
			yyvsc46 := yyInitial_yyvs_size
			yyvs46 := yyspecial_routines46.make (yyvsc46)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs46")
			end
			yyvsc46 := yyvsc46 + yyInitial_yyvs_size
			yyvs46 := yyspecial_routines46.resize (yyvs46, yyvsc46)
		end
	end
	yyvs46.put (yyval46, yyvsp46)
end
		end

	yy_do_action_709 is
			--|#line 3777 "et_eiffel_parser.y"
		local
			yyval46: ET_CONSTANT
		do
--|#line 3777 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3777")
end

yyval46 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp46 := yyvsp46 + 1
	yyvsp14 := yyvsp14 -1
	if yyvsp46 >= yyvsc46 then
		if yyvs46 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs46")
			end
			create yyspecial_routines46
			yyvsc46 := yyInitial_yyvs_size
			yyvs46 := yyspecial_routines46.make (yyvsc46)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs46")
			end
			yyvsc46 := yyvsc46 + yyInitial_yyvs_size
			yyvs46 := yyspecial_routines46.resize (yyvs46, yyvsc46)
		end
	end
	yyvs46.put (yyval46, yyvsp46)
end
		end

	yy_do_action_710 is
			--|#line 3779 "et_eiffel_parser.y"
		local
			yyval46: ET_CONSTANT
		do
--|#line 3779 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3779")
end

yyval46 := yyvs17.item (yyvsp17) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp46 := yyvsp46 + 1
	yyvsp17 := yyvsp17 -1
	if yyvsp46 >= yyvsc46 then
		if yyvs46 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs46")
			end
			create yyspecial_routines46
			yyvsc46 := yyInitial_yyvs_size
			yyvs46 := yyspecial_routines46.make (yyvsc46)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs46")
			end
			yyvsc46 := yyvsc46 + yyInitial_yyvs_size
			yyvs46 := yyspecial_routines46.resize (yyvs46, yyvsc46)
		end
	end
	yyvs46.put (yyval46, yyvsp46)
end
		end

	yy_do_action_711 is
			--|#line 3781 "et_eiffel_parser.y"
		local
			yyval46: ET_CONSTANT
		do
--|#line 3781 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3781")
end

yyval46 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp46 := yyvsp46 + 1
	yyvsp16 := yyvsp16 -1
	if yyvsp46 >= yyvsc46 then
		if yyvs46 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs46")
			end
			create yyspecial_routines46
			yyvsc46 := yyInitial_yyvs_size
			yyvs46 := yyspecial_routines46.make (yyvsc46)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs46")
			end
			yyvsc46 := yyvsc46 + yyInitial_yyvs_size
			yyvs46 := yyspecial_routines46.resize (yyvs46, yyvsc46)
		end
	end
	yyvs46.put (yyval46, yyvsp46)
end
		end

	yy_do_action_712 is
			--|#line 3783 "et_eiffel_parser.y"
		local
			yyval46: ET_CONSTANT
		do
--|#line 3783 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3783")
end

yyval46 := yyvs7.item (yyvsp7) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp46 := yyvsp46 + 1
	yyvsp7 := yyvsp7 -1
	if yyvsp46 >= yyvsc46 then
		if yyvs46 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs46")
			end
			create yyspecial_routines46
			yyvsc46 := yyInitial_yyvs_size
			yyvs46 := yyspecial_routines46.make (yyvsc46)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs46")
			end
			yyvsc46 := yyvsc46 + yyInitial_yyvs_size
			yyvs46 := yyspecial_routines46.resize (yyvs46, yyvsc46)
		end
	end
	yyvs46.put (yyval46, yyvsp46)
end
		end

	yy_do_action_713 is
			--|#line 3789 "et_eiffel_parser.y"
		local
			yyval36: ET_CALL_AGENT
		do
--|#line 3789 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3789")
end

yyval36 := ast_factory.new_call_agent (yyvs3.item (yyvsp3), Void, yyvs69.item (yyvsp69), yyvs30.item (yyvsp30)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp36 := yyvsp36 + 1
	yyvsp3 := yyvsp3 -1
	yyvsp69 := yyvsp69 -1
	yyvsp30 := yyvsp30 -1
	if yyvsp36 >= yyvsc36 then
		if yyvs36 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs36")
			end
			create yyspecial_routines36
			yyvsc36 := yyInitial_yyvs_size
			yyvs36 := yyspecial_routines36.make (yyvsc36)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs36")
			end
			yyvsc36 := yyvsc36 + yyInitial_yyvs_size
			yyvs36 := yyspecial_routines36.resize (yyvs36, yyvsc36)
		end
	end
	yyvs36.put (yyval36, yyvsp36)
end
		end

	yy_do_action_714 is
			--|#line 3791 "et_eiffel_parser.y"
		local
			yyval36: ET_CALL_AGENT
		do
--|#line 3791 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3791")
end

yyval36 := ast_factory.new_call_agent (yyvs3.item (yyvsp3), yyvs31.item (yyvsp31), ast_factory.new_dot_feature_name (yyvs5.item (yyvsp5), yyvs69.item (yyvsp69)), yyvs30.item (yyvsp30)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp36 := yyvsp36 + 1
	yyvsp3 := yyvsp3 -1
	yyvsp31 := yyvsp31 -1
	yyvsp5 := yyvsp5 -1
	yyvsp69 := yyvsp69 -1
	yyvsp30 := yyvsp30 -1
	if yyvsp36 >= yyvsc36 then
		if yyvs36 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs36")
			end
			create yyspecial_routines36
			yyvsc36 := yyInitial_yyvs_size
			yyvs36 := yyspecial_routines36.make (yyvsc36)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs36")
			end
			yyvsc36 := yyvsc36 + yyInitial_yyvs_size
			yyvs36 := yyspecial_routines36.resize (yyvs36, yyvsc36)
		end
	end
	yyvs36.put (yyval36, yyvsp36)
end
		end

	yy_do_action_715 is
			--|#line 3795 "et_eiffel_parser.y"
		local
			yyval83: ET_INLINE_AGENT
		do
--|#line 3795 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3795")
end

			yyval83 := ast_factory.new_do_function_inline_agent (yyvs3.item (yyvsp3), Void, ast_factory.new_colon_type (yyvs5.item (yyvsp5), yyvs112.item (yyvsp112)), yyvs104.item (yyvsp104), yyvs91.item (yyvsp91), yyvs45.item (yyvsp45 - 1), yyvs103.item (yyvsp103), yyvs45.item (yyvsp45), yyvs2.item (yyvsp2), yyvs30.item (yyvsp30))
			yyval83.set_object_tests (yyvs97.item (yyvsp97))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 12
	yyvsp83 := yyvsp83 + 1
	yyvsp3 := yyvsp3 -1
	yyvsp1 := yyvsp1 -1
	yyvsp5 := yyvsp5 -1
	yyvsp112 := yyvsp112 -1
	yyvsp104 := yyvsp104 -1
	yyvsp91 := yyvsp91 -1
	yyvsp45 := yyvsp45 -2
	yyvsp103 := yyvsp103 -1
	yyvsp2 := yyvsp2 -1
	yyvsp97 := yyvsp97 -1
	yyvsp30 := yyvsp30 -1
	if yyvsp83 >= yyvsc83 then
		if yyvs83 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs83")
			end
			create yyspecial_routines83
			yyvsc83 := yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.make (yyvsc83)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs83")
			end
			yyvsc83 := yyvsc83 + yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.resize (yyvs83, yyvsc83)
		end
	end
	yyvs83.put (yyval83, yyvsp83)
end
		end

	yy_do_action_716 is
			--|#line 3806 "et_eiffel_parser.y"
		local
			yyval83: ET_INLINE_AGENT
		do
--|#line 3806 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3806")
end

			yyval83 := ast_factory.new_do_function_inline_agent (yyvs3.item (yyvsp3), yyvs73.item (yyvsp73), ast_factory.new_colon_type (yyvs5.item (yyvsp5), yyvs112.item (yyvsp112)), yyvs104.item (yyvsp104), yyvs91.item (yyvsp91), yyvs45.item (yyvsp45 - 1), yyvs103.item (yyvsp103), yyvs45.item (yyvsp45), yyvs2.item (yyvsp2), yyvs30.item (yyvsp30))
			yyval83.set_object_tests (yyvs97.item (yyvsp97))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 12
	yyvsp83 := yyvsp83 + 1
	yyvsp3 := yyvsp3 -1
	yyvsp73 := yyvsp73 -1
	yyvsp5 := yyvsp5 -1
	yyvsp112 := yyvsp112 -1
	yyvsp104 := yyvsp104 -1
	yyvsp91 := yyvsp91 -1
	yyvsp45 := yyvsp45 -2
	yyvsp103 := yyvsp103 -1
	yyvsp2 := yyvsp2 -1
	yyvsp97 := yyvsp97 -1
	yyvsp30 := yyvsp30 -1
	if yyvsp83 >= yyvsc83 then
		if yyvs83 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs83")
			end
			create yyspecial_routines83
			yyvsc83 := yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.make (yyvsc83)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs83")
			end
			yyvsc83 := yyvsc83 + yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.resize (yyvs83, yyvsc83)
		end
	end
	yyvs83.put (yyval83, yyvsp83)
end
		end

	yy_do_action_717 is
			--|#line 3813 "et_eiffel_parser.y"
		local
			yyval83: ET_INLINE_AGENT
		do
--|#line 3813 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3813")
end

			yyval83 := ast_factory.new_once_function_inline_agent (yyvs3.item (yyvsp3), Void, ast_factory.new_colon_type (yyvs5.item (yyvsp5), yyvs112.item (yyvsp112)), yyvs104.item (yyvsp104), yyvs91.item (yyvsp91), yyvs45.item (yyvsp45 - 1), yyvs103.item (yyvsp103), yyvs45.item (yyvsp45), yyvs2.item (yyvsp2), yyvs30.item (yyvsp30))
			yyval83.set_object_tests (yyvs97.item (yyvsp97))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 12
	yyvsp83 := yyvsp83 + 1
	yyvsp3 := yyvsp3 -1
	yyvsp1 := yyvsp1 -1
	yyvsp5 := yyvsp5 -1
	yyvsp112 := yyvsp112 -1
	yyvsp104 := yyvsp104 -1
	yyvsp91 := yyvsp91 -1
	yyvsp45 := yyvsp45 -2
	yyvsp103 := yyvsp103 -1
	yyvsp2 := yyvsp2 -1
	yyvsp97 := yyvsp97 -1
	yyvsp30 := yyvsp30 -1
	if yyvsp83 >= yyvsc83 then
		if yyvs83 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs83")
			end
			create yyspecial_routines83
			yyvsc83 := yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.make (yyvsc83)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs83")
			end
			yyvsc83 := yyvsc83 + yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.resize (yyvs83, yyvsc83)
		end
	end
	yyvs83.put (yyval83, yyvsp83)
end
		end

	yy_do_action_718 is
			--|#line 3820 "et_eiffel_parser.y"
		local
			yyval83: ET_INLINE_AGENT
		do
--|#line 3820 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3820")
end

			yyval83 := ast_factory.new_once_function_inline_agent (yyvs3.item (yyvsp3), yyvs73.item (yyvsp73), ast_factory.new_colon_type (yyvs5.item (yyvsp5), yyvs112.item (yyvsp112)), yyvs104.item (yyvsp104), yyvs91.item (yyvsp91), yyvs45.item (yyvsp45 - 1), yyvs103.item (yyvsp103), yyvs45.item (yyvsp45), yyvs2.item (yyvsp2), yyvs30.item (yyvsp30))
			yyval83.set_object_tests (yyvs97.item (yyvsp97))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 12
	yyvsp83 := yyvsp83 + 1
	yyvsp3 := yyvsp3 -1
	yyvsp73 := yyvsp73 -1
	yyvsp5 := yyvsp5 -1
	yyvsp112 := yyvsp112 -1
	yyvsp104 := yyvsp104 -1
	yyvsp91 := yyvsp91 -1
	yyvsp45 := yyvsp45 -2
	yyvsp103 := yyvsp103 -1
	yyvsp2 := yyvsp2 -1
	yyvsp97 := yyvsp97 -1
	yyvsp30 := yyvsp30 -1
	if yyvsp83 >= yyvsc83 then
		if yyvs83 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs83")
			end
			create yyspecial_routines83
			yyvsc83 := yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.make (yyvsc83)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs83")
			end
			yyvsc83 := yyvsc83 + yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.resize (yyvs83, yyvsc83)
		end
	end
	yyvs83.put (yyval83, yyvsp83)
end
		end

	yy_do_action_719 is
			--|#line 3827 "et_eiffel_parser.y"
		local
			yyval83: ET_INLINE_AGENT
		do
--|#line 3827 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3827")
end

			yyval83 := ast_factory.new_external_function_inline_agent (yyvs3.item (yyvsp3), Void, ast_factory.new_colon_type (yyvs5.item (yyvsp5), yyvs112.item (yyvsp112)), yyvs104.item (yyvsp104), ast_factory.new_external_language (yyvs2.item (yyvsp2 - 1), yyvs16.item (yyvsp16)), yyvs65.item (yyvsp65), yyvs103.item (yyvsp103), yyvs2.item (yyvsp2), yyvs30.item (yyvsp30))
			yyval83.set_object_tests (yyvs97.item (yyvsp97))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 12
	yyvsp83 := yyvsp83 + 1
	yyvsp3 := yyvsp3 -1
	yyvsp1 := yyvsp1 -1
	yyvsp5 := yyvsp5 -1
	yyvsp112 := yyvsp112 -1
	yyvsp104 := yyvsp104 -1
	yyvsp2 := yyvsp2 -2
	yyvsp16 := yyvsp16 -1
	yyvsp65 := yyvsp65 -1
	yyvsp103 := yyvsp103 -1
	yyvsp97 := yyvsp97 -1
	yyvsp30 := yyvsp30 -1
	if yyvsp83 >= yyvsc83 then
		if yyvs83 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs83")
			end
			create yyspecial_routines83
			yyvsc83 := yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.make (yyvsc83)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs83")
			end
			yyvsc83 := yyvsc83 + yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.resize (yyvs83, yyvsc83)
		end
	end
	yyvs83.put (yyval83, yyvsp83)
end
		end

	yy_do_action_720 is
			--|#line 3834 "et_eiffel_parser.y"
		local
			yyval83: ET_INLINE_AGENT
		do
--|#line 3834 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3834")
end

			yyval83 := ast_factory.new_external_function_inline_agent (yyvs3.item (yyvsp3), yyvs73.item (yyvsp73), ast_factory.new_colon_type (yyvs5.item (yyvsp5), yyvs112.item (yyvsp112)), yyvs104.item (yyvsp104), ast_factory.new_external_language (yyvs2.item (yyvsp2 - 1), yyvs16.item (yyvsp16)), yyvs65.item (yyvsp65), yyvs103.item (yyvsp103), yyvs2.item (yyvsp2), yyvs30.item (yyvsp30))
			yyval83.set_object_tests (yyvs97.item (yyvsp97))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 12
	yyvsp83 := yyvsp83 + 1
	yyvsp3 := yyvsp3 -1
	yyvsp73 := yyvsp73 -1
	yyvsp5 := yyvsp5 -1
	yyvsp112 := yyvsp112 -1
	yyvsp104 := yyvsp104 -1
	yyvsp2 := yyvsp2 -2
	yyvsp16 := yyvsp16 -1
	yyvsp65 := yyvsp65 -1
	yyvsp103 := yyvsp103 -1
	yyvsp97 := yyvsp97 -1
	yyvsp30 := yyvsp30 -1
	if yyvsp83 >= yyvsc83 then
		if yyvs83 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs83")
			end
			create yyspecial_routines83
			yyvsc83 := yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.make (yyvsc83)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs83")
			end
			yyvsc83 := yyvsc83 + yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.resize (yyvs83, yyvsc83)
		end
	end
	yyvs83.put (yyval83, yyvsp83)
end
		end

	yy_do_action_721 is
			--|#line 3841 "et_eiffel_parser.y"
		local
			yyval83: ET_INLINE_AGENT
		do
--|#line 3841 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3841")
end

			yyval83 := ast_factory.new_do_procedure_inline_agent (yyvs3.item (yyvsp3), Void, yyvs104.item (yyvsp104), yyvs91.item (yyvsp91), yyvs45.item (yyvsp45 - 1), yyvs103.item (yyvsp103), yyvs45.item (yyvsp45), yyvs2.item (yyvsp2), yyvs30.item (yyvsp30))
			yyval83.set_object_tests (yyvs97.item (yyvsp97))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 10
	yyvsp83 := yyvsp83 + 1
	yyvsp3 := yyvsp3 -1
	yyvsp1 := yyvsp1 -1
	yyvsp104 := yyvsp104 -1
	yyvsp91 := yyvsp91 -1
	yyvsp45 := yyvsp45 -2
	yyvsp103 := yyvsp103 -1
	yyvsp2 := yyvsp2 -1
	yyvsp97 := yyvsp97 -1
	yyvsp30 := yyvsp30 -1
	if yyvsp83 >= yyvsc83 then
		if yyvs83 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs83")
			end
			create yyspecial_routines83
			yyvsc83 := yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.make (yyvsc83)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs83")
			end
			yyvsc83 := yyvsc83 + yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.resize (yyvs83, yyvsc83)
		end
	end
	yyvs83.put (yyval83, yyvsp83)
end
		end

	yy_do_action_722 is
			--|#line 3848 "et_eiffel_parser.y"
		local
			yyval83: ET_INLINE_AGENT
		do
--|#line 3848 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3848")
end

			yyval83 := ast_factory.new_do_procedure_inline_agent (yyvs3.item (yyvsp3), yyvs73.item (yyvsp73), yyvs104.item (yyvsp104), yyvs91.item (yyvsp91), yyvs45.item (yyvsp45 - 1), yyvs103.item (yyvsp103), yyvs45.item (yyvsp45), yyvs2.item (yyvsp2), yyvs30.item (yyvsp30))
			yyval83.set_object_tests (yyvs97.item (yyvsp97))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 10
	yyvsp83 := yyvsp83 + 1
	yyvsp3 := yyvsp3 -1
	yyvsp73 := yyvsp73 -1
	yyvsp104 := yyvsp104 -1
	yyvsp91 := yyvsp91 -1
	yyvsp45 := yyvsp45 -2
	yyvsp103 := yyvsp103 -1
	yyvsp2 := yyvsp2 -1
	yyvsp97 := yyvsp97 -1
	yyvsp30 := yyvsp30 -1
	if yyvsp83 >= yyvsc83 then
		if yyvs83 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs83")
			end
			create yyspecial_routines83
			yyvsc83 := yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.make (yyvsc83)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs83")
			end
			yyvsc83 := yyvsc83 + yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.resize (yyvs83, yyvsc83)
		end
	end
	yyvs83.put (yyval83, yyvsp83)
end
		end

	yy_do_action_723 is
			--|#line 3855 "et_eiffel_parser.y"
		local
			yyval83: ET_INLINE_AGENT
		do
--|#line 3855 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3855")
end

			yyval83 := ast_factory.new_once_procedure_inline_agent (yyvs3.item (yyvsp3), Void, yyvs104.item (yyvsp104), yyvs91.item (yyvsp91), yyvs45.item (yyvsp45 - 1), yyvs103.item (yyvsp103), yyvs45.item (yyvsp45), yyvs2.item (yyvsp2), yyvs30.item (yyvsp30))
			yyval83.set_object_tests (yyvs97.item (yyvsp97))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 10
	yyvsp83 := yyvsp83 + 1
	yyvsp3 := yyvsp3 -1
	yyvsp1 := yyvsp1 -1
	yyvsp104 := yyvsp104 -1
	yyvsp91 := yyvsp91 -1
	yyvsp45 := yyvsp45 -2
	yyvsp103 := yyvsp103 -1
	yyvsp2 := yyvsp2 -1
	yyvsp97 := yyvsp97 -1
	yyvsp30 := yyvsp30 -1
	if yyvsp83 >= yyvsc83 then
		if yyvs83 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs83")
			end
			create yyspecial_routines83
			yyvsc83 := yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.make (yyvsc83)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs83")
			end
			yyvsc83 := yyvsc83 + yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.resize (yyvs83, yyvsc83)
		end
	end
	yyvs83.put (yyval83, yyvsp83)
end
		end

	yy_do_action_724 is
			--|#line 3862 "et_eiffel_parser.y"
		local
			yyval83: ET_INLINE_AGENT
		do
--|#line 3862 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3862")
end

			yyval83 := ast_factory.new_once_procedure_inline_agent (yyvs3.item (yyvsp3), yyvs73.item (yyvsp73), yyvs104.item (yyvsp104), yyvs91.item (yyvsp91), yyvs45.item (yyvsp45 - 1), yyvs103.item (yyvsp103), yyvs45.item (yyvsp45), yyvs2.item (yyvsp2), yyvs30.item (yyvsp30))
			yyval83.set_object_tests (yyvs97.item (yyvsp97))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 10
	yyvsp83 := yyvsp83 + 1
	yyvsp3 := yyvsp3 -1
	yyvsp73 := yyvsp73 -1
	yyvsp104 := yyvsp104 -1
	yyvsp91 := yyvsp91 -1
	yyvsp45 := yyvsp45 -2
	yyvsp103 := yyvsp103 -1
	yyvsp2 := yyvsp2 -1
	yyvsp97 := yyvsp97 -1
	yyvsp30 := yyvsp30 -1
	if yyvsp83 >= yyvsc83 then
		if yyvs83 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs83")
			end
			create yyspecial_routines83
			yyvsc83 := yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.make (yyvsc83)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs83")
			end
			yyvsc83 := yyvsc83 + yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.resize (yyvs83, yyvsc83)
		end
	end
	yyvs83.put (yyval83, yyvsp83)
end
		end

	yy_do_action_725 is
			--|#line 3869 "et_eiffel_parser.y"
		local
			yyval83: ET_INLINE_AGENT
		do
--|#line 3869 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3869")
end

			yyval83 := ast_factory.new_external_procedure_inline_agent (yyvs3.item (yyvsp3), Void, yyvs104.item (yyvsp104), ast_factory.new_external_language (yyvs2.item (yyvsp2 - 1), yyvs16.item (yyvsp16)), yyvs65.item (yyvsp65), yyvs103.item (yyvsp103), yyvs2.item (yyvsp2), yyvs30.item (yyvsp30))
			yyval83.set_object_tests (yyvs97.item (yyvsp97))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 10
	yyvsp83 := yyvsp83 + 1
	yyvsp3 := yyvsp3 -1
	yyvsp1 := yyvsp1 -1
	yyvsp104 := yyvsp104 -1
	yyvsp2 := yyvsp2 -2
	yyvsp16 := yyvsp16 -1
	yyvsp65 := yyvsp65 -1
	yyvsp103 := yyvsp103 -1
	yyvsp97 := yyvsp97 -1
	yyvsp30 := yyvsp30 -1
	if yyvsp83 >= yyvsc83 then
		if yyvs83 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs83")
			end
			create yyspecial_routines83
			yyvsc83 := yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.make (yyvsc83)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs83")
			end
			yyvsc83 := yyvsc83 + yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.resize (yyvs83, yyvsc83)
		end
	end
	yyvs83.put (yyval83, yyvsp83)
end
		end

	yy_do_action_726 is
			--|#line 3876 "et_eiffel_parser.y"
		local
			yyval83: ET_INLINE_AGENT
		do
--|#line 3876 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3876")
end

			yyval83 := ast_factory.new_external_procedure_inline_agent (yyvs3.item (yyvsp3), yyvs73.item (yyvsp73), yyvs104.item (yyvsp104), ast_factory.new_external_language (yyvs2.item (yyvsp2 - 1), yyvs16.item (yyvsp16)), yyvs65.item (yyvsp65), yyvs103.item (yyvsp103), yyvs2.item (yyvsp2), yyvs30.item (yyvsp30))
			yyval83.set_object_tests (yyvs97.item (yyvsp97))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 10
	yyvsp83 := yyvsp83 + 1
	yyvsp3 := yyvsp3 -1
	yyvsp73 := yyvsp73 -1
	yyvsp104 := yyvsp104 -1
	yyvsp2 := yyvsp2 -2
	yyvsp16 := yyvsp16 -1
	yyvsp65 := yyvsp65 -1
	yyvsp103 := yyvsp103 -1
	yyvsp97 := yyvsp97 -1
	yyvsp30 := yyvsp30 -1
	if yyvsp83 >= yyvsc83 then
		if yyvs83 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs83")
			end
			create yyspecial_routines83
			yyvsc83 := yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.make (yyvsc83)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs83")
			end
			yyvsc83 := yyvsc83 + yyInitial_yyvs_size
			yyvs83 := yyspecial_routines83.resize (yyvs83, yyvsc83)
		end
	end
	yyvs83.put (yyval83, yyvsp83)
end
		end

	yy_do_action_727 is
			--|#line 3885 "et_eiffel_parser.y"
		local
			yyval73: ET_FORMAL_ARGUMENT_LIST
		do
--|#line 3885 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3885")
end

			yyval73 := yyvs73.item (yyvsp73)
			set_start_closure (yyval73)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs73.put (yyval73, yyvsp73)
end
		end

	yy_do_action_728 is
			--|#line 3892 "et_eiffel_parser.y"
		local
			yyval1: ANY
		do
--|#line 3892 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3892")
end

set_start_closure (Void) 
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
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_729 is
			--|#line 3896 "et_eiffel_parser.y"
		local
			yyval97: ET_OBJECT_TEST_LIST
		do
--|#line 3896 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3896")
end

			if last_object_tests /= Void then
				yyval97 := last_object_tests.cloned_object_test_list
			else
				yyval97 := Void
			end
				-- Clean up after the inline agent has been parsed.
			set_end_closure
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp97 := yyvsp97 + 1
	if yyvsp97 >= yyvsc97 then
		if yyvs97 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs97")
			end
			create yyspecial_routines97
			yyvsc97 := yyInitial_yyvs_size
			yyvs97 := yyspecial_routines97.make (yyvsc97)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs97")
			end
			yyvsc97 := yyvsc97 + yyInitial_yyvs_size
			yyvs97 := yyspecial_routines97.resize (yyvs97, yyvsc97)
		end
	end
	yyvs97.put (yyval97, yyvsp97)
end
		end

	yy_do_action_730 is
			--|#line 3908 "et_eiffel_parser.y"
		local
			yyval31: ET_AGENT_TARGET
		do
--|#line 3908 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3908")
end

yyval31 := new_agent_identifier_target (yyvs13.item (yyvsp13)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp31 := yyvsp31 + 1
	yyvsp13 := yyvsp13 -1
	if yyvsp31 >= yyvsc31 then
		if yyvs31 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs31")
			end
			create yyspecial_routines31
			yyvsc31 := yyInitial_yyvs_size
			yyvs31 := yyspecial_routines31.make (yyvsc31)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs31")
			end
			yyvsc31 := yyvsc31 + yyInitial_yyvs_size
			yyvs31 := yyspecial_routines31.resize (yyvs31, yyvsc31)
		end
	end
	yyvs31.put (yyval31, yyvsp31)
end
		end

	yy_do_action_731 is
			--|#line 3910 "et_eiffel_parser.y"
		local
			yyval31: ET_AGENT_TARGET
		do
--|#line 3910 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3910")
end

yyval31 := yyvs99.item (yyvsp99) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp31 := yyvsp31 + 1
	yyvsp99 := yyvsp99 -1
	if yyvsp31 >= yyvsc31 then
		if yyvs31 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs31")
			end
			create yyspecial_routines31
			yyvsc31 := yyInitial_yyvs_size
			yyvs31 := yyspecial_routines31.make (yyvsc31)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs31")
			end
			yyvsc31 := yyvsc31 + yyInitial_yyvs_size
			yyvs31 := yyspecial_routines31.resize (yyvs31, yyvsc31)
		end
	end
	yyvs31.put (yyval31, yyvsp31)
end
		end

	yy_do_action_732 is
			--|#line 3912 "et_eiffel_parser.y"
		local
			yyval31: ET_AGENT_TARGET
		do
--|#line 3912 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3912")
end

yyval31 := yyvs18.item (yyvsp18) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp31 := yyvsp31 + 1
	yyvsp18 := yyvsp18 -1
	if yyvsp31 >= yyvsc31 then
		if yyvs31 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs31")
			end
			create yyspecial_routines31
			yyvsc31 := yyInitial_yyvs_size
			yyvs31 := yyspecial_routines31.make (yyvsc31)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs31")
			end
			yyvsc31 := yyvsc31 + yyInitial_yyvs_size
			yyvs31 := yyspecial_routines31.resize (yyvs31, yyvsc31)
		end
	end
	yyvs31.put (yyval31, yyvsp31)
end
		end

	yy_do_action_733 is
			--|#line 3914 "et_eiffel_parser.y"
		local
			yyval31: ET_AGENT_TARGET
		do
--|#line 3914 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3914")
end

yyval31 := yyvs11.item (yyvsp11) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp31 := yyvsp31 + 1
	yyvsp11 := yyvsp11 -1
	if yyvsp31 >= yyvsc31 then
		if yyvs31 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs31")
			end
			create yyspecial_routines31
			yyvsc31 := yyInitial_yyvs_size
			yyvs31 := yyspecial_routines31.make (yyvsc31)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs31")
			end
			yyvsc31 := yyvsc31 + yyInitial_yyvs_size
			yyvs31 := yyspecial_routines31.resize (yyvs31, yyvsc31)
		end
	end
	yyvs31.put (yyval31, yyvsp31)
end
		end

	yy_do_action_734 is
			--|#line 3916 "et_eiffel_parser.y"
		local
			yyval31: ET_AGENT_TARGET
		do
--|#line 3916 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3916")
end

yyval31 := ast_factory.new_agent_open_target (yyvs5.item (yyvsp5 - 1), yyvs112.item (yyvsp112), yyvs5.item (yyvsp5)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp31 := yyvsp31 + 1
	yyvsp5 := yyvsp5 -2
	yyvsp112 := yyvsp112 -1
	if yyvsp31 >= yyvsc31 then
		if yyvs31 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs31")
			end
			create yyspecial_routines31
			yyvsc31 := yyInitial_yyvs_size
			yyvs31 := yyspecial_routines31.make (yyvsc31)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs31")
			end
			yyvsc31 := yyvsc31 + yyInitial_yyvs_size
			yyvs31 := yyspecial_routines31.resize (yyvs31, yyvsc31)
		end
	end
	yyvs31.put (yyval31, yyvsp31)
end
		end

	yy_do_action_735 is
			--|#line 3920 "et_eiffel_parser.y"
		local
			yyval30: ET_AGENT_ARGUMENT_OPERAND_LIST
		do
--|#line 3920 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3920")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp30 := yyvsp30 + 1
	if yyvsp30 >= yyvsc30 then
		if yyvs30 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs30")
			end
			create yyspecial_routines30
			yyvsc30 := yyInitial_yyvs_size
			yyvs30 := yyspecial_routines30.make (yyvsc30)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs30")
			end
			yyvsc30 := yyvsc30 + yyInitial_yyvs_size
			yyvs30 := yyspecial_routines30.resize (yyvs30, yyvsc30)
		end
	end
	yyvs30.put (yyval30, yyvsp30)
end
		end

	yy_do_action_736 is
			--|#line 3922 "et_eiffel_parser.y"
		local
			yyval30: ET_AGENT_ARGUMENT_OPERAND_LIST
		do
--|#line 3922 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3922")
end

yyval30 := ast_factory.new_agent_argument_operands (yyvs5.item (yyvsp5 - 1), yyvs5.item (yyvsp5), 0) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp30 := yyvsp30 + 1
	yyvsp5 := yyvsp5 -2
	if yyvsp30 >= yyvsc30 then
		if yyvs30 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs30")
			end
			create yyspecial_routines30
			yyvsc30 := yyInitial_yyvs_size
			yyvs30 := yyspecial_routines30.make (yyvsc30)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs30")
			end
			yyvsc30 := yyvsc30 + yyInitial_yyvs_size
			yyvs30 := yyspecial_routines30.resize (yyvs30, yyvsc30)
		end
	end
	yyvs30.put (yyval30, yyvsp30)
end
		end

	yy_do_action_737 is
			--|#line 3924 "et_eiffel_parser.y"
		local
			yyval30: ET_AGENT_ARGUMENT_OPERAND_LIST
		do
--|#line 3924 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3924")
end

			yyval30 := yyvs30.item (yyvsp30)
			remove_symbol
			remove_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp30 := yyvsp30 -1
	yyvsp5 := yyvsp5 -1
	yyvs30.put (yyval30, yyvsp30)
end
		end

	yy_do_action_738 is
			--|#line 3924 "et_eiffel_parser.y"
		local
			yyval30: ET_AGENT_ARGUMENT_OPERAND_LIST
		do
--|#line 3924 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3924")
end

			add_symbol (yyvs5.item (yyvsp5))
			add_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp30 := yyvsp30 + 1
	if yyvsp30 >= yyvsc30 then
		if yyvs30 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs30")
			end
			create yyspecial_routines30
			yyvsc30 := yyInitial_yyvs_size
			yyvs30 := yyspecial_routines30.make (yyvsc30)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs30")
			end
			yyvsc30 := yyvsc30 + yyInitial_yyvs_size
			yyvs30 := yyspecial_routines30.resize (yyvs30, yyvsc30)
		end
	end
	yyvs30.put (yyval30, yyvsp30)
end
		end

	yy_do_action_739 is
			--|#line 3937 "et_eiffel_parser.y"
		local
			yyval30: ET_AGENT_ARGUMENT_OPERAND_LIST
		do
--|#line 3937 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3937")
end

			if yyvs28.item (yyvsp28) /= Void then
				yyval30 := ast_factory.new_agent_argument_operands (last_symbol, yyvs5.item (yyvsp5), counter_value + 1)
				if yyval30 /= Void then
					yyval30.put_first (yyvs28.item (yyvsp28))
				end
			else
				yyval30 := ast_factory.new_agent_argument_operands (last_symbol, yyvs5.item (yyvsp5), counter_value)
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp30 := yyvsp30 + 1
	yyvsp28 := yyvsp28 -1
	yyvsp5 := yyvsp5 -1
	if yyvsp30 >= yyvsc30 then
		if yyvs30 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs30")
			end
			create yyspecial_routines30
			yyvsc30 := yyInitial_yyvs_size
			yyvs30 := yyspecial_routines30.make (yyvsc30)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs30")
			end
			yyvsc30 := yyvsc30 + yyInitial_yyvs_size
			yyvs30 := yyspecial_routines30.resize (yyvs30, yyvsc30)
		end
	end
	yyvs30.put (yyval30, yyvsp30)
end
		end

	yy_do_action_740 is
			--|#line 3948 "et_eiffel_parser.y"
		local
			yyval30: ET_AGENT_ARGUMENT_OPERAND_LIST
		do
--|#line 3948 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3948")
end

			yyval30 := ast_factory.new_agent_argument_operands (last_symbol, yyvs5.item (yyvsp5), counter_value)
			if yyval30 /= Void and yyvs29.item (yyvsp29) /= Void then
				yyval30.put_first (yyvs29.item (yyvsp29))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp30 := yyvsp30 + 1
	yyvsp29 := yyvsp29 -1
	yyvsp5 := yyvsp5 -1
	if yyvsp30 >= yyvsc30 then
		if yyvs30 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs30")
			end
			create yyspecial_routines30
			yyvsc30 := yyInitial_yyvs_size
			yyvs30 := yyspecial_routines30.make (yyvsc30)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs30")
			end
			yyvsc30 := yyvsc30 + yyInitial_yyvs_size
			yyvs30 := yyspecial_routines30.resize (yyvs30, yyvsc30)
		end
	end
	yyvs30.put (yyval30, yyvsp30)
end
		end

	yy_do_action_741 is
			--|#line 3956 "et_eiffel_parser.y"
		local
			yyval30: ET_AGENT_ARGUMENT_OPERAND_LIST
		do
--|#line 3956 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3956")
end

			yyval30 := yyvs30.item (yyvsp30)
			if yyval30 /= Void and yyvs29.item (yyvsp29) /= Void then
				yyval30.put_first (yyvs29.item (yyvsp29))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp29 := yyvsp29 -1
	yyvs30.put (yyval30, yyvsp30)
end
		end

	yy_do_action_742 is
			--|#line 3965 "et_eiffel_parser.y"
		local
			yyval29: ET_AGENT_ARGUMENT_OPERAND_ITEM
		do
--|#line 3965 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3965")
end

			yyval29 := ast_factory.new_agent_argument_operand_comma (yyvs28.item (yyvsp28), yyvs5.item (yyvsp5))
			if yyval29 /= Void then
				increment_counter
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp29 := yyvsp29 + 1
	yyvsp28 := yyvsp28 -1
	yyvsp5 := yyvsp5 -1
	if yyvsp29 >= yyvsc29 then
		if yyvs29 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs29")
			end
			create yyspecial_routines29
			yyvsc29 := yyInitial_yyvs_size
			yyvs29 := yyspecial_routines29.make (yyvsc29)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs29")
			end
			yyvsc29 := yyvsc29 + yyInitial_yyvs_size
			yyvs29 := yyspecial_routines29.resize (yyvs29, yyvsc29)
		end
	end
	yyvs29.put (yyval29, yyvsp29)
end
		end

	yy_do_action_743 is
			--|#line 3974 "et_eiffel_parser.y"
		local
			yyval28: ET_AGENT_ARGUMENT_OPERAND
		do
--|#line 3974 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3974")
end

yyval28 := yyvs62.item (yyvsp62) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp28 := yyvsp28 + 1
	yyvsp62 := yyvsp62 -1
	if yyvsp28 >= yyvsc28 then
		if yyvs28 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs28")
			end
			create yyspecial_routines28
			yyvsc28 := yyInitial_yyvs_size
			yyvs28 := yyspecial_routines28.make (yyvsc28)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs28")
			end
			yyvsc28 := yyvsc28 + yyInitial_yyvs_size
			yyvs28 := yyspecial_routines28.resize (yyvs28, yyvsc28)
		end
	end
	yyvs28.put (yyval28, yyvsp28)
end
		end

	yy_do_action_744 is
			--|#line 3976 "et_eiffel_parser.y"
		local
			yyval28: ET_AGENT_ARGUMENT_OPERAND
		do
--|#line 3976 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3976")
end

yyval28 := yyvs24.item (yyvsp24) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp28 := yyvsp28 + 1
	yyvsp24 := yyvsp24 -1
	if yyvsp28 >= yyvsc28 then
		if yyvs28 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs28")
			end
			create yyspecial_routines28
			yyvsc28 := yyInitial_yyvs_size
			yyvs28 := yyspecial_routines28.make (yyvsc28)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs28")
			end
			yyvsc28 := yyvsc28 + yyInitial_yyvs_size
			yyvs28 := yyspecial_routines28.resize (yyvs28, yyvsc28)
		end
	end
	yyvs28.put (yyval28, yyvsp28)
end
		end

	yy_do_action_745 is
			--|#line 3978 "et_eiffel_parser.y"
		local
			yyval28: ET_AGENT_ARGUMENT_OPERAND
		do
--|#line 3978 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3978")
end

yyval28 := ast_factory.new_agent_typed_open_argument (yyvs5.item (yyvsp5 - 1), yyvs112.item (yyvsp112), yyvs5.item (yyvsp5), yyvs24.item (yyvsp24)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp28 := yyvsp28 + 1
	yyvsp5 := yyvsp5 -2
	yyvsp112 := yyvsp112 -1
	yyvsp24 := yyvsp24 -1
	if yyvsp28 >= yyvsc28 then
		if yyvs28 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs28")
			end
			create yyspecial_routines28
			yyvsc28 := yyInitial_yyvs_size
			yyvs28 := yyspecial_routines28.make (yyvsc28)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs28")
			end
			yyvsc28 := yyvsc28 + yyInitial_yyvs_size
			yyvs28 := yyspecial_routines28.resize (yyvs28, yyvsc28)
		end
	end
	yyvs28.put (yyval28, yyvsp28)
end
		end

	yy_do_action_746 is
			--|#line 3984 "et_eiffel_parser.y"
		local
			yyval16: ET_MANIFEST_STRING
		do
--|#line 3984 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3984")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_747 is
			--|#line 3986 "et_eiffel_parser.y"
		local
			yyval16: ET_MANIFEST_STRING
		do
--|#line 3986 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3986")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_748 is
			--|#line 3988 "et_eiffel_parser.y"
		local
			yyval16: ET_MANIFEST_STRING
		do
--|#line 3988 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3988")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_749 is
			--|#line 3990 "et_eiffel_parser.y"
		local
			yyval16: ET_MANIFEST_STRING
		do
--|#line 3990 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3990")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_750 is
			--|#line 3992 "et_eiffel_parser.y"
		local
			yyval16: ET_MANIFEST_STRING
		do
--|#line 3992 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3992")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_751 is
			--|#line 3994 "et_eiffel_parser.y"
		local
			yyval16: ET_MANIFEST_STRING
		do
--|#line 3994 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3994")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_752 is
			--|#line 3996 "et_eiffel_parser.y"
		local
			yyval16: ET_MANIFEST_STRING
		do
--|#line 3996 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3996")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_753 is
			--|#line 3998 "et_eiffel_parser.y"
		local
			yyval16: ET_MANIFEST_STRING
		do
--|#line 3998 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3998")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_754 is
			--|#line 4000 "et_eiffel_parser.y"
		local
			yyval16: ET_MANIFEST_STRING
		do
--|#line 4000 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4000")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_755 is
			--|#line 4002 "et_eiffel_parser.y"
		local
			yyval16: ET_MANIFEST_STRING
		do
--|#line 4002 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4002")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_756 is
			--|#line 4004 "et_eiffel_parser.y"
		local
			yyval16: ET_MANIFEST_STRING
		do
--|#line 4004 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4004")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_757 is
			--|#line 4006 "et_eiffel_parser.y"
		local
			yyval16: ET_MANIFEST_STRING
		do
--|#line 4006 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4006")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_758 is
			--|#line 4008 "et_eiffel_parser.y"
		local
			yyval16: ET_MANIFEST_STRING
		do
--|#line 4008 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4008")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_759 is
			--|#line 4010 "et_eiffel_parser.y"
		local
			yyval16: ET_MANIFEST_STRING
		do
--|#line 4010 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4010")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_760 is
			--|#line 4012 "et_eiffel_parser.y"
		local
			yyval16: ET_MANIFEST_STRING
		do
--|#line 4012 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4012")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_761 is
			--|#line 4014 "et_eiffel_parser.y"
		local
			yyval16: ET_MANIFEST_STRING
		do
--|#line 4014 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4014")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_762 is
			--|#line 4016 "et_eiffel_parser.y"
		local
			yyval16: ET_MANIFEST_STRING
		do
--|#line 4016 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4016")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_763 is
			--|#line 4018 "et_eiffel_parser.y"
		local
			yyval16: ET_MANIFEST_STRING
		do
--|#line 4018 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4018")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_764 is
			--|#line 4020 "et_eiffel_parser.y"
		local
			yyval16: ET_MANIFEST_STRING
		do
--|#line 4020 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4020")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_765 is
			--|#line 4022 "et_eiffel_parser.y"
		local
			yyval16: ET_MANIFEST_STRING
		do
--|#line 4022 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4022")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_766 is
			--|#line 4024 "et_eiffel_parser.y"
		local
			yyval16: ET_MANIFEST_STRING
		do
--|#line 4024 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4024")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_767 is
			--|#line 4026 "et_eiffel_parser.y"
		local
			yyval16: ET_MANIFEST_STRING
		do
--|#line 4026 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4026")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_768 is
			--|#line 4028 "et_eiffel_parser.y"
		local
			yyval16: ET_MANIFEST_STRING
		do
--|#line 4028 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4028")
end

abort 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp16 := yyvsp16 + 1
	yyvsp6 := yyvsp6 -1
	if yyvsp16 >= yyvsc16 then
		if yyvs16 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs16")
			end
			create yyspecial_routines16
			yyvsc16 := yyInitial_yyvs_size
			yyvs16 := yyspecial_routines16.make (yyvsc16)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs16")
			end
			yyvsc16 := yyvsc16 + yyInitial_yyvs_size
			yyvs16 := yyspecial_routines16.resize (yyvs16, yyvsc16)
		end
	end
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_769 is
			--|#line 4032 "et_eiffel_parser.y"
		local
			yyval10: ET_CHARACTER_CONSTANT
		do
--|#line 4032 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4032")
end

yyval10 := yyvs10.item (yyvsp10) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs10.put (yyval10, yyvsp10)
end
		end

	yy_do_action_770 is
			--|#line 4034 "et_eiffel_parser.y"
		local
			yyval10: ET_CHARACTER_CONSTANT
		do
--|#line 4034 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4034")
end

abort 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp10 := yyvsp10 + 1
	yyvsp6 := yyvsp6 -1
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
	yyvs10.put (yyval10, yyvsp10)
end
		end

	yy_do_action_771 is
			--|#line 4038 "et_eiffel_parser.y"
		local
			yyval8: ET_BOOLEAN_CONSTANT
		do
--|#line 4038 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4038")
end

yyval8 := yyvs8.item (yyvsp8) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs8.put (yyval8, yyvsp8)
end
		end

	yy_do_action_772 is
			--|#line 4040 "et_eiffel_parser.y"
		local
			yyval8: ET_BOOLEAN_CONSTANT
		do
--|#line 4040 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4040")
end

yyval8 := yyvs8.item (yyvsp8) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs8.put (yyval8, yyvsp8)
end
		end

	yy_do_action_773 is
			--|#line 4044 "et_eiffel_parser.y"
		local
			yyval14: ET_INTEGER_CONSTANT
		do
--|#line 4044 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4044")
end

yyval14 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs14.put (yyval14, yyvsp14)
end
		end

	yy_do_action_774 is
			--|#line 4046 "et_eiffel_parser.y"
		local
			yyval14: ET_INTEGER_CONSTANT
		do
--|#line 4046 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4046")
end

yyval14 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs14.put (yyval14, yyvsp14)
end
		end

	yy_do_action_775 is
			--|#line 4050 "et_eiffel_parser.y"
		local
			yyval14: ET_INTEGER_CONSTANT
		do
--|#line 4050 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4050")
end

yyval14 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs14.put (yyval14, yyvsp14)
end
		end

	yy_do_action_776 is
			--|#line 4052 "et_eiffel_parser.y"
		local
			yyval14: ET_INTEGER_CONSTANT
		do
--|#line 4052 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4052")
end

yyval14 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs14.put (yyval14, yyvsp14)
end
		end

	yy_do_action_777 is
			--|#line 4056 "et_eiffel_parser.y"
		local
			yyval14: ET_INTEGER_CONSTANT
		do
--|#line 4056 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4056")
end

			yyval14 := yyvs14.item (yyvsp14)
			yyval14.set_sign (yyvs20.item (yyvsp20))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp20 := yyvsp20 -1
	yyvs14.put (yyval14, yyvsp14)
end
		end

	yy_do_action_778 is
			--|#line 4061 "et_eiffel_parser.y"
		local
			yyval14: ET_INTEGER_CONSTANT
		do
--|#line 4061 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4061")
end

			yyval14 := yyvs14.item (yyvsp14)
			yyval14.set_sign (yyvs20.item (yyvsp20))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp20 := yyvsp20 -1
	yyvs14.put (yyval14, yyvsp14)
end
		end

	yy_do_action_779 is
			--|#line 4068 "et_eiffel_parser.y"
		local
			yyval14: ET_INTEGER_CONSTANT
		do
--|#line 4068 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4068")
end

			yyval14 := yyvs14.item (yyvsp14)
			yyval14.set_cast_type (ast_factory.new_target_type (yyvs5.item (yyvsp5 - 1), yyvs112.item (yyvsp112), yyvs5.item (yyvsp5)))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp5 := yyvsp5 -2
	yyvsp112 := yyvsp112 -1
	yyvs14.put (yyval14, yyvsp14)
end
		end

	yy_do_action_780 is
			--|#line 4075 "et_eiffel_parser.y"
		local
			yyval17: ET_REAL_CONSTANT
		do
--|#line 4075 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4075")
end

yyval17 := yyvs17.item (yyvsp17) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs17.put (yyval17, yyvsp17)
end
		end

	yy_do_action_781 is
			--|#line 4077 "et_eiffel_parser.y"
		local
			yyval17: ET_REAL_CONSTANT
		do
--|#line 4077 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4077")
end

yyval17 := yyvs17.item (yyvsp17) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs17.put (yyval17, yyvsp17)
end
		end

	yy_do_action_782 is
			--|#line 4081 "et_eiffel_parser.y"
		local
			yyval17: ET_REAL_CONSTANT
		do
--|#line 4081 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4081")
end

yyval17 := yyvs17.item (yyvsp17) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs17.put (yyval17, yyvsp17)
end
		end

	yy_do_action_783 is
			--|#line 4083 "et_eiffel_parser.y"
		local
			yyval17: ET_REAL_CONSTANT
		do
--|#line 4083 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4083")
end

yyval17 := yyvs17.item (yyvsp17) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs17.put (yyval17, yyvsp17)
end
		end

	yy_do_action_784 is
			--|#line 4087 "et_eiffel_parser.y"
		local
			yyval17: ET_REAL_CONSTANT
		do
--|#line 4087 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4087")
end

			yyval17 := yyvs17.item (yyvsp17)
			yyval17.set_sign (yyvs20.item (yyvsp20))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp20 := yyvsp20 -1
	yyvs17.put (yyval17, yyvsp17)
end
		end

	yy_do_action_785 is
			--|#line 4092 "et_eiffel_parser.y"
		local
			yyval17: ET_REAL_CONSTANT
		do
--|#line 4092 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4092")
end

			yyval17 := yyvs17.item (yyvsp17)
			yyval17.set_sign (yyvs20.item (yyvsp20))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp20 := yyvsp20 -1
	yyvs17.put (yyval17, yyvsp17)
end
		end

	yy_do_action_786 is
			--|#line 4099 "et_eiffel_parser.y"
		local
			yyval17: ET_REAL_CONSTANT
		do
--|#line 4099 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4099")
end

			yyval17 := yyvs17.item (yyvsp17)
			yyval17.set_cast_type (ast_factory.new_target_type (yyvs5.item (yyvsp5 - 1), yyvs112.item (yyvsp112), yyvs5.item (yyvsp5)))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp5 := yyvsp5 -2
	yyvsp112 := yyvsp112 -1
	yyvs17.put (yyval17, yyvsp17)
end
		end

	yy_do_action_787 is
			--|#line 4106 "et_eiffel_parser.y"
		local
			yyval13: ET_IDENTIFIER
		do
--|#line 4106 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4106")
end

yyval13 := yyvs13.item (yyvsp13) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs13.put (yyval13, yyvsp13)
end
		end

	yy_do_action_788 is
			--|#line 4108 "et_eiffel_parser.y"
		local
			yyval13: ET_IDENTIFIER
		do
--|#line 4108 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4108")
end

yyval13 := yyvs13.item (yyvsp13) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs13.put (yyval13, yyvsp13)
end
		end

	yy_do_action_789 is
			--|#line 4110 "et_eiffel_parser.y"
		local
			yyval13: ET_IDENTIFIER
		do
--|#line 4110 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4110")
end

				-- TO DO: reserved word `BIT'
			yyval13 := yyvs13.item (yyvsp13)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs13.put (yyval13, yyvsp13)
end
		end

	yy_do_action_790 is
			--|#line 4119 "et_eiffel_parser.y"
		local
			yyval1: ANY
		do
--|#line 4119 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4119")
end

add_counter 
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
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_error_action (yy_act: INTEGER) is
			-- Execute error action.
		do
			if yy_act <= 199 then
				yy_do_error_action_0_199 (yy_act)
			elseif yy_act <= 399 then
				yy_do_error_action_200_399 (yy_act)
			elseif yy_act <= 599 then
				yy_do_error_action_400_599 (yy_act)
			elseif yy_act <= 799 then
				yy_do_error_action_600_799 (yy_act)
			elseif yy_act <= 999 then
				yy_do_error_action_800_999 (yy_act)
			elseif yy_act <= 1199 then
				yy_do_error_action_1000_1199 (yy_act)
			elseif yy_act <= 1399 then
				yy_do_error_action_1200_1399 (yy_act)
			elseif yy_act <= 1599 then
				yy_do_error_action_1400_1599 (yy_act)
			else
					-- Default action.
				report_error ("parse error")
			end
		end

	yy_do_error_action_0_199 (yy_act: INTEGER) is
			-- Execute error action.
		do
			inspect yy_act
			else
					-- Default action.
				report_error ("parse error")
			end
		end

	yy_do_error_action_200_399 (yy_act: INTEGER) is
			-- Execute error action.
		do
			inspect yy_act
			else
					-- Default action.
				report_error ("parse error")
			end
		end

	yy_do_error_action_400_599 (yy_act: INTEGER) is
			-- Execute error action.
		do
			inspect yy_act
			else
					-- Default action.
				report_error ("parse error")
			end
		end

	yy_do_error_action_600_799 (yy_act: INTEGER) is
			-- Execute error action.
		do
			inspect yy_act
			else
					-- Default action.
				report_error ("parse error")
			end
		end

	yy_do_error_action_800_999 (yy_act: INTEGER) is
			-- Execute error action.
		do
			inspect yy_act
			else
					-- Default action.
				report_error ("parse error")
			end
		end

	yy_do_error_action_1000_1199 (yy_act: INTEGER) is
			-- Execute error action.
		do
			inspect yy_act
			else
					-- Default action.
				report_error ("parse error")
			end
		end

	yy_do_error_action_1200_1399 (yy_act: INTEGER) is
			-- Execute error action.
		do
			inspect yy_act
			else
					-- Default action.
				report_error ("parse error")
			end
		end

	yy_do_error_action_1400_1599 (yy_act: INTEGER) is
			-- Execute error action.
		do
			inspect yy_act
			when 1426 then
					-- End-of-file expected action.
				report_eof_expected_error
			else
					-- Default action.
				report_error ("parse error")
			end
		end

feature {NONE} -- Table templates

	yytranslate_template: SPECIAL [INTEGER] is
			-- Template for `yytranslate'
		once
			Result := yyfixed_array (<<
			    0,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,  129,    2,    2,  127,    2,    2,    2,
			  122,  123,  114,  131,  125,  130,  128,  107,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,  124,  136,
			  111,  132,  109,  138,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,  137,    2,  126,  113,    2,    2,    2,    2,    2,

			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,  120,    2,  121,  133,    2,    2,    2,
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
			  105,  106,  108,  110,  112,  115,  116,  117,  118,  119,
			  134,  135, yyDummy>>)
		end

	yyr1_template: SPECIAL [INTEGER] is
			-- Template for `yyr1'
		once
			Result := yyfixed_array (<<
			    0,  347,  347,  170,  348,  348,  349,  169,  169,  169,
			  169,  169,  169,  351,  169,  169,  350,  253,  253,  352,
			  253,  253,  353,  254,  254,  256,  256,  354,  256,  355,
			  260,  262,  261,  255,  255,  255,  357,  255,  358,  257,
			  259,  259,  258,  258,  265,  265,  263,  263,  263,  263,
			  263,  263,  263,  263,  263,  264,  168,  168,  168,  168,
			  278,  278,  279,  279,  248,  248,  248,  359,  249,  249,
			  247,  246,  246,  246,  246,  246,  246,  246,  246,  246,
			  194,  194,  360,  195,  195,  195,  196,  196,  196,  196,
			  196,  196,  196,  196,  196,  196,  196,  196,  197,  197,

			  197,  197,  197,  197,  197,  197,  197,  197,  197,  197,
			  189,  189,  188,  188,  190,  190,  190,  190,  185,  192,
			  192,  191,  191,  191,  193,  193,  193,  193,  193,  193,
			  186,  187,  306,  306,  311,  311,  311,  312,  363,  308,
			  308,  308,  308,  308,  308,  309,  313,  313,  313,  313,
			  313,  314,  314,  314,  314,  310,  310,  328,  328,  364,
			  329,  329,  329,  326,  327,  214,  214,  365,  215,  215,
			  216,  216,  366,  213,  213,  213,  367,  213,  234,  234,
			  234,  173,  368,  173,  174,  174,  174,  174,  171,  172,
			  286,  286,  369,  287,  287,  284,  284,  370,  285,  285,

			  282,  282,  371,  283,  283,  281,  281,  281,  236,  207,
			  207,  206,  208,  208,  372,  204,  204,  204,  373,  204,
			  374,  204,  204,  204,  375,  204,  376,  205,  205,  205,
			  237,  200,  200,  201,  377,  202,  202,  202,  199,  198,
			  198,  340,  340,  378,  341,  341,  339,  232,  232,  231,
			  233,  233,  229,  229,  230,  230,  379,  379,  379,  379,
			  320,  320,  320,  320,  320,  320,  317,  317,  317,  317,
			  317,  317,  321,  321,  321,  321,  321,  321,  321,  321,
			  321,  321,  321,  321,  321,  321,  321,  321,  321,  321,
			  321,  321,  321,  321,  318,  318,  318,  318,  318,  318,

			  318,  318,  280,  280,  330,  330,  228,  228,  156,  156,
			  235,  235,  235,  235,  235,  235,  235,  235,  235,  235,
			  235,  235,  235,  235,  235,  235,  235,  235,  235,  235,
			  235,  235,  235,  235,  235,  235,  235,  235,  235,  235,
			  235,  235,  235,  235,  235,  235,  235,  235,  235,  235,
			  235,  227,  227,  155,  155,  155,  155,  155,  155,  155,
			  155,  155,  155,  155,  155,  155,  155,  155,  155,  155,
			  155,  155,  155,  155,  155,  245,  242,  242,  334,  243,
			  243,  243,  243,  243,  243,  239,  238,  240,  241,  293,
			  293,  293,  380,  294,  294,  294,  294,  294,  294,  290,

			  289,  291,  292,  381,  381,  381,  381,  381,  381,  381,
			  381,  316,  316,  316,  316,  316,  315,  315,  315,  315,
			  315,  277,  277,  276,  276,  382,  296,  296,  295,  295,
			  342,  342,  342,  176,  176,  335,  335,  336,  336,  336,
			  336,  336,  336,  336,  336,  336,  336,  336,  336,  337,
			  337,  337,  337,  337,  337,  337,  337,  337,  337,  337,
			  337,  338,  338,  338,  338,  338,  338,  338,  338,  338,
			  338,  338,  338,  338,  251,  144,  144,  146,  146,  361,
			  145,  145,  145,  145,  362,  141,  147,  147,  148,  148,
			  148,  149,  149,  149,  149,  149,  149,  142,  143,  288,

			  288,  288,  288,  288,  288,  288,  319,  319,  319,  319,
			  177,  177,  178,  178,  179,  179,  180,  180,  181,  181,
			  182,  182,  183,  183,  175,  175,  383,  268,  268,  268,
			  268,  268,  268,  268,  268,  268,  268,  268,  268,  268,
			  268,  268,  268,  268,  269,  269,  269,  269,  271,  271,
			  271,  271,  203,  203,  252,  252,  252,  252,  211,  212,
			  212,  210,  267,  267,  345,  345,  344,  344,  343,  166,
			  166,  384,  167,  167,  167,  165,  163,  163,  164,  164,
			  164,  164,  209,  209,  302,  302,  302,  385,  301,  301,
			  300,  270,  270,  270,  270,  270,  270,  222,  222,  161,

			  331,  331,  219,  219,  218,  218,  218,  218,  218,  218,
			  218,  218,  139,  139,  139,  386,  140,  140,  140,  226,
			  221,  221,  221,  221,  346,  346,  217,  217,  224,  224,
			  224,  224,  224,  224,  224,  224,  224,  224,  224,  224,
			  224,  224,  224,  224,  224,  224,  224,  224,  224,  224,
			  225,  225,  225,  225,  225,  225,  225,  225,  225,  225,
			  223,  223,  223,  223,  223,  223,  223,  223,  223,  223,
			  223,  223,  223,  223,  223,  223,  223,  223,  223,  223,
			  223,  223,  159,  387,  158,  158,  158,  307,  220,  297,
			  297,  388,  298,  298,  298,  303,  303,  389,  304,  304,

			  304,  332,  332,  390,  333,  333,  333,  184,  184,  184,
			  184,  184,  184,  160,  160,  266,  266,  266,  266,  266,
			  266,  266,  266,  266,  266,  266,  266,  244,  391,  305,
			  154,  154,  154,  154,  154,  152,  152,  152,  392,  153,
			  153,  153,  151,  150,  150,  150,  299,  299,  299,  299,
			  299,  299,  299,  299,  299,  299,  299,  299,  299,  299,
			  299,  299,  299,  299,  299,  299,  299,  299,  299,  162,
			  162,  157,  157,  272,  272,  274,  274,  275,  275,  273,
			  322,  322,  324,  324,  325,  325,  323,  250,  250,  250,
			  356, yyDummy>>)
		end

	yytypes1_template: SPECIAL [INTEGER] is
			-- Template for `yytypes1'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 1428)
			yytypes1_template_1 (an_array)
			yytypes1_template_2 (an_array)
			Result := yyfixed_array (an_array)
		end

	yytypes1_template_1 (an_array: ARRAY [INTEGER]) is
			-- Fill chunk #1 of template for `yytypes1'.
		do
			yyarray_subcopy (an_array, <<
			    1,    9,    2,    2,   42,   78,   78,   42,   78,   78,
			    2,   42,   42,    2,   78,   79,   79,    1,   78,   79,
			   79,    1,   23,   76,    2,    2,    2,    2,    2,   22,
			   78,   78,   13,   13,   13,   13,   79,   22,   78,   22,
			   78,   20,   20,    6,    6,   17,   16,   16,   16,   16,
			   16,   16,   16,   16,   16,   16,   16,   16,   16,   16,
			   16,   16,   16,   16,   16,   16,   16,   16,   14,   10,
			    8,    8,    7,    2,    8,   10,   54,   13,   79,   80,
			   81,   82,   14,   14,   16,   17,   17,    5,   76,    2,
			   98,    2,    2,    2,    2,   78,   78,    5,   78,   78,

			   17,   14,   17,   14,    5,   23,    2,   96,    5,    5,
			   13,   82,    2,    2,   74,   75,   76,   13,   16,    2,
			  102,  102,    1,    2,    2,    2,   13,   82,   24,    5,
			   13,   13,   13,    2,    2,    2,    2,   13,   88,  106,
			  112,  112,    5,   96,    2,   82,   13,   13,    5,    5,
			   76,    5,   56,    1,    2,    2,   53,   56,   67,   78,
			   86,    1,    1,   13,  100,  100,  101,  102,  102,   13,
			   13,   13,   13,    2,   13,   13,    2,   13,   23,   27,
			   27,    1,   20,   20,   13,   14,   13,   13,   13,    5,
			   11,   13,   23,   27,    1,    5,    5,   20,   20,    5,

			    5,    5,    2,   21,   18,   17,   15,   14,   12,   11,
			    7,    5,    4,    3,    2,    2,    2,    8,   35,   36,
			   10,   54,   62,   62,   62,   62,   62,   62,   62,   62,
			   62,   63,   13,   83,   14,   93,   16,   96,   96,   99,
			   17,  110,  111,    5,    5,    5,   24,    5,   13,   13,
			    2,    2,    2,   50,   13,   88,   53,   53,    2,    2,
			   55,   56,   53,    1,   67,   67,    1,   53,   86,   86,
			    2,    1,   78,    2,   56,   66,   66,   67,   27,   27,
			   22,  102,  102,   22,  102,  102,  102,  102,   27,    5,
			   11,   13,   27,   27,    5,   11,   13,   27,    5,   24,

			    5,   13,   13,   13,    2,    2,    2,   26,   26,   26,
			   27,   27,   13,   13,   88,  112,  112,   27,   27,   27,
			  112,    5,   13,   13,   13,   27,   13,    5,   62,   62,
			   18,   11,    2,    2,   69,   13,   99,   13,  112,   62,
			   62,   62,    5,   93,    5,    5,   25,    5,    5,   18,
			   11,   31,   69,   73,   73,   13,   99,    5,    1,    5,
			   16,    5,    5,    5,    5,    5,   20,   20,    5,    5,
			   20,   20,   20,   20,   20,   20,   20,   20,   20,   15,
			   15,   15,   15,   12,    5,   23,    5,   96,   25,   62,
			   50,   50,   13,   13,   13,   13,   23,   48,   48,    1,

			   13,   14,   13,   13,   13,    2,   49,   23,   48,   48,
			    1,   67,    5,   44,   55,   44,   55,   56,   51,   52,
			   53,   69,   62,   13,    1,   86,   67,   78,    1,   42,
			    2,   44,   67,    2,   64,   69,   13,  105,  105,  107,
			  107,    1,    2,    2,    2,    2,    2,    2,   61,   87,
			   87,   87,  109,  112,  112,   13,   13,   13,   13,    5,
			   27,    5,   13,   14,    5,   13,   13,   13,   27,   13,
			   13,   13,   27,   27,    5,   27,    5,    5,    5,    5,
			    5,   13,   16,   16,   16,   16,   16,   16,   16,   16,
			   16,   16,   16,   16,   16,   16,   16,   16,   16,   16,

			   16,   16,   16,   16,   16,   16,   16,   16,   16,   16,
			   16,   16,   16,   16,   16,   16,   16,   16,   16,   16,
			   16,   16,    5,    5,   62,   63,   93,    5,   25,   13,
			    5,  112,    5,    5,   30,    5,    2,  104,   71,   71,
			   72,   72,   73,   13,    5,  104,    5,  111,  112,   62,
			   62,   62,   62,   62,   62,   62,   62,   62,   62,   62,
			   62,   62,   62,   62,   62,   62,    2,   62,    2,   62,
			   62,   13,   35,    5,   49,   49,   48,   48,   48,   48,
			    5,   24,    5,   13,   13,   13,    2,    2,    2,   47,
			   47,   47,   48,   48,   50,   50,   13,   13,   88,   48,

			   48,   48,    2,   49,    5,   13,   13,   13,   48,   86,
			    5,   44,   55,   55,   70,   13,   55,   55,   56,    5,
			   53,    5,    5,   22,    5,   62,   13,   78,   86,    2,
			    1,    1,   42,    1,   64,  105,  107,    5,    5,    2,
			   73,   73,    2,  105,  107,    5,    2,   32,  105,  107,
			   87,   87,  109,   87,   61,   87,   87,    2,   87,   87,
			   87,   87,   61,   61,    5,    5,   27,   27,   27,   27,
			    1,    1,    1,   27,   27,   27,    5,    5,  112,    5,
			    1,    1,   25,  112,    5,   14,   17,    5,    5,   93,
			   25,   62,   63,    5,    5,   69,    5,   30,  112,    2,

			    1,    2,    2,   91,   73,   13,   73,    5,   73,    5,
			   73,    5,    5,  112,    2,   91,   69,   70,  111,    5,
			   62,   62,   25,   34,   62,   63,   13,   13,   13,   13,
			    5,   48,    5,   13,   14,    5,   13,   13,   13,   48,
			   13,   13,   13,   48,   48,    5,    5,    5,   48,   49,
			   70,   13,    5,    5,   78,   43,   43,   44,   13,   55,
			   55,    5,   55,    5,  114,  114,   22,   22,    5,    2,
			   78,    1,   42,    1,    5,  105,  107,  105,  107,  112,
			    5,    2,   78,   16,   16,   16,   16,   16,   16,   16,
			   16,   16,   16,   16,   16,   16,   16,   16,   16,   16,

			   16,   16,   16,   16,   16,   69,   70,   87,   87,   69,
			  108,  108,  109,   87,   22,   44,   60,   61,   87,   87,
			    2,   87,    5,    5,   27,   27,   27,   27,   27,    1,
			    1,   22,    5,   13,    5,   13,    5,    5,   25,   25,
			   30,   24,    5,   28,   29,   30,   62,  104,    1,   91,
			   16,    2,    2,   45,   45,  112,  104,   16,   45,   45,
			    5,    5,    5,  111,    5,    5,    5,   34,   48,   48,
			   48,   48,    1,    1,    1,   48,   48,   48,    5,    5,
			   50,    2,   49,    2,    1,    1,    2,    5,   44,    5,
			   44,    5,    5,  114,    5,   22,    1,    2,    1,  105,

			  107,    2,   33,  112,   78,   98,   87,    2,  109,    2,
			   60,   61,   87,    2,   87,   13,   13,   62,   25,  112,
			    5,    5,    5,   30,    2,   91,   13,   89,   89,   90,
			   90,   91,    2,   65,    1,    1,    2,  103,  103,   22,
			    2,   91,   65,  103,  103,   13,   48,   48,   48,   48,
			   48,    1,    1,   22,    5,    1,  112,  113,  114,    1,
			    1,   69,   22,    5,    2,   78,   33,   98,  104,   64,
			   68,   69,   70,   61,    2,   87,    5,   16,   45,   45,
			    5,    5,   91,   91,   91,   91,   16,  103,   22,    5,
			    5,   19,   18,    4,    2,    2,    2,    2,    2,    2, yyDummy>>,
			1, 1000, 0)
		end

	yytypes1_template_2 (an_array: ARRAY [INTEGER]) is
			-- Fill chunk #2 of template for `yytypes1'.
		do
			yyarray_subcopy (an_array, <<
			    2,   35,   37,   45,   45,   57,   62,   62,   13,   77,
			   84,   85,   85,   85,   85,  118,   45,    2,    1,    2,
			   45,   45,   45,   16,   45,   45,  103,   45,   45,   25,
			    1,    5,    5,  114,    1,    5,    7,    2,    8,   10,
			   46,   14,   14,   14,   16,   17,   17,   17,    2,   46,
			   78,   98,    2,   78,  104,    2,    2,   91,    5,   68,
			    2,   24,   65,  103,  103,  112,    2,   24,    5,   13,
			   13,    2,    2,    2,   13,   88,  112,  112,    5,   25,
			   62,   62,    1,    5,    5,   95,    5,   18,   13,  118,
			    2,    1,    5,    5,    2,   92,   92,    5,   25,   45,

			    5,    5,    1,    1,    2,    2,   65,  103,  103,    2,
			    2,    2,  112,   22,   22,   22,   22,   22,   98,  104,
			   78,   98,    2,    2,   91,  103,   16,   45,   45,  103,
			   45,   45,   22,   97,   13,   13,   13,   13,   13,  118,
			   27,   13,   14,   13,   13,   13,   27,    5,    5,   13,
			  117,    1,    2,   45,   45,  112,    5,   95,    2,    1,
			  112,    5,    2,   62,   62,    1,    2,    2,  115,   13,
			   45,   62,   62,   45,   97,   97,  103,   45,   45,   97,
			   97,   97,    5,  104,    2,    2,   91,   98,  104,  103,
			   16,   45,   45,    2,   65,  103,  103,    2,    2,    2,

			   30,   27,   27,   27,   27,    5,   27,   27,   27,  118,
			    5,    5,    2,    2,   45,    2,   41,  116,  117,    1,
			    2,   45,   59,    1,    5,   16,   94,   95,   45,    5,
			   13,   62,   13,   62,    2,   25,   30,   30,    2,    2,
			    2,   30,   30,   30,    2,    2,   91,  103,   16,   45,
			   45,  104,    2,    2,   91,    2,   65,  103,  103,   22,
			  103,   45,   45,   97,   97,   97,   13,    5,   13,   25,
			    1,    2,   41,   45,  117,   45,    2,    2,   45,    2,
			   58,   59,    5,    5,    5,   95,    2,  118,   25,    5,
			    2,   45,   62,   97,   97,   97,  103,   16,   45,   45,

			    2,   65,  103,  103,    2,    2,   91,  103,   16,   45,
			   45,   22,  103,   45,   45,    2,    2,    2,   30,   30,
			   30,   25,   13,   25,   45,    5,   10,   38,   39,   40,
			   41,   13,   14,  110,    2,   62,   59,   13,    5,   62,
			    1,    2,  115,   45,   30,   30,   30,    2,   65,  103,
			  103,   22,  103,   45,   45,  103,   16,   45,   45,    2,
			   65,  103,  103,    2,    2,    2,   22,   22,   22,   25,
			  112,    5,    5,   41,   45,   25,   13,   45,    2,    2,
			   22,  103,   45,   45,    2,    2,    2,    2,   65,  103,
			  103,   22,  103,   45,   45,   22,   22,   22,    5,   39,

			   25,    2,    2,    2,   22,   22,   22,   22,  103,   45,
			   45,    2,    2,    2,   22,   22,   22,    2,    2,    2,
			   22,   22,   22,   22,   22,   22,    1,    1,    1, yyDummy>>,
			1, 429, 1000)
		end

	yytypes2_template: SPECIAL [INTEGER] is
			-- Template for `yytypes2'
		once
			Result := yyfixed_array (<<
			    1,    1,    1,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    3,    4,    5,    5,
			    5,    5,    5,    5,    6,    7,    8,    8,    9,   10,
			   11,   12,   13,   13,   13,   14,   15,   15,   15,   15,
			   15,   16,   16,   16,   16,   16,   16,   16,   16,   16,
			   16,   16,   16,   16,   16,   16,   16,   16,   16,   16,

			   16,   16,   16,   17,   18,   19,   20,   20,   20,   20,
			   20,   20,   20,   20,   20,   21,    6,    6,    6,    2,
			    5,    5,    5,    5,    5,    5,    5,    5,    5,    5,
			   20,   20,    5,    5,    5,    5,   22,   23,   24, yyDummy>>)
		end

	yydefact_template: SPECIAL [INTEGER] is
			-- Template for `yydefact'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 1428)
			yydefact_template_1 (an_array)
			yydefact_template_2 (an_array)
			Result := yyfixed_array (an_array)
		end

	yydefact_template_1 (an_array: ARRAY [INTEGER]) is
			-- Fill chunk #1 of template for `yydefact'.
		do
			yyarray_subcopy (an_array, <<
			   23,   23,   22,   19,    1,   24,   60,    2,  790,  790,
			   61,   64,    3,   62,   21,   27,   29,    0,   18,   36,
			   38,    0,   67,  132,   62,   62,   62,   63,    0,   32,
			  790,  790,  788,  789,  787,    0,   30,   42,  790,   43,
			  790,    0,    0,  768,  770,  782,  746,  765,  764,  763,
			  767,  766,  762,  761,  760,  759,  758,  757,  756,  755,
			  754,  753,  752,  751,  750,  749,  748,  747,  775,  769,
			  771,  772,   52,    0,   47,   48,    0,   46,   39,   44,
			    0,   40,   49,  776,   51,   50,  783,   65,    0,    0,
			  134,    0,    0,    0,    0,   26,   28,    0,   35,   37,

			  785,  778,  784,  777,    0,  697,   53,    0,    0,   55,
			   46,   45,    0,    0,    0,    0,   66,   71,  133,  138,
			  790,  790,    0,    0,    0,    0,   56,   31,    0,    0,
			  486,    0,  474,    0,    0,    0,    0,  435,  443,  505,
			    0,  436,  695,    0,   54,   41,   73,   72,   68,   70,
			   69,    0,  231,    0,  234,  425,  790,  231,  421,   16,
			   23,   15,    0,  475,  146,  151,  147,  136,  137,   59,
			   58,   57,  486,    0,  475,  486,    0,  475,  479,  446,
			  487,    0,    0,    0,  445,  444,  475,  475,  475,    0,
			  502,  499,  479,  437,    0,    0,  552,    0,    0,    0,

			  378,    0,    0,  674,  663,  668,    0,  667,    0,  664,
			  678,  691,  612,  728,    0,    0,    0,  666,  651,  672,
			  675,  652,    0,    0,  662,  671,  681,  660,  650,  626,
			  627,    0,  612,  673,  669,  679,  676,  653,  696,  665,
			  670,  661,  680,    0,    0,    0,    0,    0,  119,    0,
			    0,    0,    0,   74,  110,   92,  790,  232,  220,  226,
			  214,  210,    0,  423,  248,  421,    0,  790,  422,   23,
			   16,   13,    0,  255,  211,  250,  252,  249,  139,  476,
			  155,  148,  152,  156,  149,  153,  150,  154,  448,    0,
			  504,  501,  442,  447,    0,  503,  500,  441,  488,    0,

			    0,  788,  789,  787,    0,    0,    0,    0,    0,    0,
			  489,  490,    0,  435,  455,    0,    0,  439,  440,  438,
			    0,  477,  486,    0,  474,  478,  509,    0,  654,  655,
			  622,  621,    0,    0,  620,  310,  623,  474,    0,  658,
			  656,  657,  689,    0,  615,    0,  602,  378,    0,  732,
			  733,    0,  735,  727,  411,  730,  731,    0,  411,  703,
			  677,    0,    0,    0,    0,    0,    0,    0,  698,  619,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,  683,  699,  700,  604,    0,
			   76,   75,  119,  110,  119,  110,  479,  120,   95,    0,

			   94,   93,  110,  110,  110,   82,   77,  479,  111,   86,
			    0,  421,  182,  218,    0,  224,    0,    0,  235,  236,
			  233,    0,  403,  612,  424,   23,  421,    0,    6,   60,
			   16,  254,  251,    0,  302,  351,  310,  257,  266,  256,
			  260,  253,  197,  202,  159,  192,  167,  145,  198,    0,
			  193,  203,  168,    0,    0,  486,  475,  486,  475,  484,
			  487,  484,  457,  456,  484,  475,  475,  475,  481,  788,
			  789,  787,  493,  492,    0,  449,  480,  485,    0,  484,
			  484,  612,  333,  311,  314,  348,  347,  346,  345,  344,
			  343,  342,  341,  340,  339,  338,  337,  336,  335,  334,

			  313,  312,  349,  350,  332,  330,  329,  327,  331,  328,
			  326,  325,  324,  323,  322,  321,  320,  319,  318,  317,
			  316,  315,    0,  688,    0,    0,  690,  613,    0,    0,
			  376,    0,    0,  738,  713,    0,  412,  389,    0,    0,
			    0,    0,  377,  612,    0,  389,  701,    0,    0,  649,
			  647,  648,  646,  629,  630,  631,  633,  635,  636,  638,
			  637,  639,  632,  634,  645,  642,    0,  641,    0,  640,
			  628,  612,    0,  687,   79,   78,   97,   91,   96,   90,
			  121,    0,    0,  788,  789,  787,    0,    0,    0,    0,
			    0,    0,  122,  123,    0,    0,    0,  110,  104,   88,

			   89,   87,   80,    0,  112,  119,    0,  474,  113,   23,
			  183,    0,    0,  219,  228,  227,    0,  225,  213,  238,
			  237,    0,    0,  404,  405,  407,  612,    0,   23,   16,
			   14,   23,   12,    6,  302,  267,  261,    0,    0,  303,
			  375,  302,   23,  269,  263,    0,    0,  352,  259,  258,
			    0,    0,    0,    0,    0,  199,  193,  144,  194,  203,
			  204,    0,  169,  198,    0,    0,  460,  454,  459,  453,
			    0,    0,    0,  451,  452,  450,  484,  484,  497,    0,
			    0,    0,  553,    0,    0,  779,  786,  692,  693,  694,
			  614,    0,    0,  612,  734,  735,  736,    0,  411,  413,

			  414,  392,    0,    0,  382,  386,  381,  379,  384,  380,
			  383,  385,    0,  411,    0,    0,    0,    0,  702,    0,
			  644,  643,  611,  682,    0,    0,  119,  110,  119,  110,
			  484,  120,  484,  106,  105,  484,  110,  110,  110,  115,
			  788,  789,  787,  126,  125,  114,  118,    0,  111,   81,
			    0,    0,  484,  484,    0,    0,    0,  181,  188,  217,
			  229,  230,  223,  243,  239,    0,  406,  408,  409,   16,
			    0,    6,    5,   11,    0,  271,  265,  268,  262,  308,
			    0,   23,  132,  374,  353,  372,  369,  373,  371,  368,
			  366,  370,  367,  365,  364,  363,  362,  361,  360,  359,

			  358,  357,  356,  355,  354,  205,  206,  196,  201,    0,
			  160,  161,  158,  191,  177,  176,  172,  166,  203,    0,
			  143,  193,    0,    0,  483,  495,  496,  482,  494,    0,
			    0,  498,  491,  506,    0,  612,  616,  617,  618,  603,
			  714,  744,    0,    0,    0,  737,  743,  389,  415,    0,
			  306,  790,  790,  416,  416,  387,  389,  306,  416,  416,
			  208,  704,  705,  706,    0,  684,  685,  686,  109,  103,
			  108,  102,    0,    0,    0,  100,  101,   99,  484,  484,
			  130,   84,   85,   83,    0,    0,   16,  184,  187,  185,
			  186,  189,  241,    0,  240,  410,    6,   16,   10,  270,

			  264,    0,  272,  308,  132,  411,  207,    0,  162,  173,
			    0,    0,    0,  142,  203,  508,  507,  659,  601,    0,
			  742,  739,  740,  741,    0,    0,  400,    0,    0,  393,
			  394,  391,    0,  416,    0,    0,  417,  433,  433,  388,
			    0,    0,  416,  433,  433,  612,  117,  128,  129,  116,
			  127,    0,    0,  131,  124,    6,    0,    0,  242,    9,
			    6,  309,  273,    0,   23,  132,   23,  411,  389,  163,
			  175,  178,  179,  171,  141,    0,  688,  306,  416,  416,
			  399,    0,  396,  395,  398,  397,  307,    0,  543,    0,
			    0,  542,  663,  612,    0,    0,  790,    0,  584,    0, yyDummy>>,
			1, 1000, 0)
		end

	yydefact_template_2 (an_array: ARRAY [INTEGER]) is
			-- Fill chunk #2 of template for `yydefact'.
		do
			yyarray_subcopy (an_array, <<
			    0,  609,    0,  513,  426,  539,    0,    0,  624,  534,
			  535,  526,  527,  529,  528,    0,  511,  418,  419,  790,
			    0,  434,    0,  306,  416,  416,    0,    0,    0,  600,
			    7,  246,  244,  245,    8,    0,  712,  304,  707,  708,
			  304,  709,  774,  773,  711,  710,  781,  780,  304,  304,
			  132,  411,   23,  132,  389,  416,    0,    0,  164,  180,
			  140,  745,  416,  433,  433,  401,  729,    0,    0,  486,
			    0,    0,    0,    0,  461,  468,    0,    0,    0,  602,
			  790,    0,    0,    0,  587,  790,    0,  625,  624,  550,
			  540,    0,    0,    0,  428,  427,    0,    0,  604,    0,

			    0,    0,  420,    0,  729,  729,  416,  433,  433,  729,
			  729,  729,    0,  305,  277,  275,  276,  274,  411,  389,
			  132,  411,  416,    0,    0,    0,  306,  416,  416,    0,
			    0,    0,  402,  735,  486,  475,  788,  787,    0,  546,
			  471,  470,  469,  475,  475,  475,  462,    0,  688,    0,
			    0,    0,  790,  790,  521,    0,  585,    0,  582,    0,
			    0,    0,  541,  531,  530,  429,  430,    0,    0,  612,
			  525,  533,  532,  519,  735,  735,    0,    0,    0,  735,
			  735,  735,    0,  389,  416,    0,    0,  411,  389,    0,
			  306,  416,  416,  304,  416,  433,  433,  729,  729,  729,

			  726,  473,  467,  472,  466,    0,  464,  465,  463,  544,
			    0,  612,  563,  790,    0,  571,    0,  566,  565,    0,
			  554,    0,    0,    0,    0,    0,    0,  586,    0,    0,
			  612,  431,  612,    0,    0,  611,  722,  724,  729,  729,
			  729,  725,  721,  723,  416,    0,    0,    0,  306,  416,
			  416,  389,  416,    0,    0,  304,  416,  433,  433,  298,
			    0,    0,    0,  735,  735,  735,  612,    0,  612,  603,
			    0,  562,    0,  568,  567,  515,  555,  556,    0,    0,
			  559,  558,    0,  590,  588,  589,  583,  548,  551,    0,
			  790,    0,    0,  735,  735,  735,    0,  306,  416,  416,

			  304,  416,  433,  433,  416,    0,    0,    0,  306,  416,
			  416,  299,    0,    0,    0,  304,  304,  304,  720,  716,
			  718,  547,  612,  601,  517,    0,  579,  572,  576,  573,
			  570,  580,  578,  581,  557,    0,  560,  612,    0,  432,
			    0,  537,    0,    0,  719,  715,  717,  304,  416,  433,
			  433,  287,    0,    0,    0,    0,  306,  416,  416,  304,
			  416,  433,  433,  304,  304,  304,  300,  294,  296,  545,
			    0,  575,    0,  574,  561,  600,  612,  523,  538,  536,
			  286,    0,    0,    0,  304,  304,  304,  304,  416,  433,
			  433,  289,    0,    0,    0,  301,  295,  297,    0,  577,

			  549,  304,  304,  304,  291,  279,  283,  288,    0,    0,
			    0,  304,  304,  304,  290,  278,  282,  304,  304,  304,
			  293,  281,  285,  292,  280,  284,    0,    0,    0, yyDummy>>,
			1, 429, 1000)
		end

	yydefgoto_template: SPECIAL [INTEGER] is
			-- Template for `yydefgoto'
		once
			Result := yyfixed_array (<<
			  388,  690,  307,  308,  309,  278,  824,  279,  179,  180,
			  825,  843,  844,  534,  845,  351,  647,  902,  217,  723,
			  218,  219, 1002,  220, 1327, 1328, 1329, 1216, 1330,   11,
			   12,    4,  755,  756,  815,  757, 1003, 1020,  853,  854,
			 1153, 1214, 1021, 1004, 1291, 1040,  589,  590,  591,  408,
			  409,  946,  397,  398,  947,  406,  749,  594,  595,  418,
			  419,  256,  257,  420,  221,  260,  613,  157,  152,  261,
			 1005, 1280, 1222, 1281,  816,  448,  663,  817,  422,  223,
			  224,  225,  226,  227,  228,  229,  230,  231,  434,  933,
			  275,  276,  264,  265,  277,  970,  435,  806,  614,  538,

			  539,  540,  541,  640,  542,  354,  641,  114,  115,   23,
			  116,  232,  137, 1009,    5,    6,   18,   14,   19,   20,
			   78,   15,   16,   36,   79,   80,   81,  233, 1010, 1011,
			 1012, 1013, 1014, 1332,  234,  685,   83,  268,  269,   13,
			   28,  642,  807,  660,  661,  655,  656,  658,  659,  138,
			  927,  928,  929,  930,  703,  931, 1095, 1096,  235,  526,
			  236, 1226, 1227, 1085,  237,  238, 1133,   90,  239,  164,
			  165,  166,  120,  121,  167,  168,  937,  537,  437,  438,
			  139,  439,  440, 1045,  240,   85,   86,  810,  811,  452,
			  812, 1114,  241,  242,  718,  243,  315,  141,  316, 1076,

			  957,  764,  958, 1168, 1217, 1218, 1150, 1015, 1426,  630,
			  631,  161,  429,    9,    8,   30,   31,   17,   38,   40,
			   88,  603,  194,  670,  122,  652,  654,  911,  910,  611,
			  653,  650,  651,  417,  612,  414,  616,  416,  262,  893,
			  441,  849,  424,  263, 1099, 1272, 1157,  528,  572,  343,
			  143,  547,  358,  697, yyDummy>>)
		end

	yypact_template: SPECIAL [INTEGER] is
			-- Template for `yypact'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 1428)
			yypact_template_1 (an_array)
			yypact_template_2 (an_array)
			Result := yyfixed_array (an_array)
		end

	yypact_template_1 (an_array: ARRAY [INTEGER]) is
			-- Fill chunk #1 of template for `yypact'.
		do
			yyarray_subcopy (an_array, <<
			   87,  549, 4486, 1732, -32768, -32768, 1307, -32768, -32768, -32768,
			 -32768, 1334, -32768,  501, -32768, 1381, -32768,  669, -32768, 1332,
			 1287, 4382, 1341, 1044, 1442, 1442, 1442, -32768, 1446, -32768,
			 -32768, -32768, -32768, -32768, -32768, 1336, -32768, -32768, -32768, -32768,
			 -32768,   57,   27, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, 1335, -32768, -32768,   38, 1324, -32768, 1321,
			 4382, -32768, -32768, -32768, -32768, -32768, -32768, -32768,  752, 4804,
			 1420, 1428, 1424, 1418,  669, -32768, -32768, 4382, -32768, -32768,

			 -32768, -32768, -32768, -32768,   66, 1294, -32768, 1394, 4382, -32768,
			 -32768, -32768,  669,  669,  807,  752, -32768, 1360, -32768, 1269,
			 1036, 5117, 1022,  669,  669,  669, -32768, -32768,  392,  376,
			  884,  718, -32768, 1022, 1022, 1022,  654,  875,  978, -32768,
			 1295, -32768, -32768, 4313, -32768, -32768, 1354, 1353, -32768, -32768,
			 -32768, 1500, 1356,  893, -32768, -32768,  944, 1356, 1305, 1393,
			  549, -32768,  789,  875,   15,   11, 1022, -32768, -32768, -32768,
			 -32768, -32768,  884,  631,  875,  884,  313,  875, 1280, -32768,
			 -32768, 2162, 1329, 1328, -32768, -32768,  875,  875,  875,   66,
			 -32768, -32768, 1271, -32768, 1552,  669, 1274, 4313, 4313,  857,

			 -32768, 1490, 4313, -32768, 1268, -32768, 4313, -32768, 4313, 1262,
			 -32768, 1325,  851,  459, 1255, 4804, 1258, -32768, 1257, -32768,
			 -32768, -32768, 4847, 1254, 1248, -32768, -32768, -32768,  984, -32768,
			 -32768, 4213,  270, -32768, -32768, -32768, -32768, -32768, -32768, 1245,
			 -32768, 1244, -32768, 4313, 1500, 1500,  322,  272, 1109,  718,
			 1022, 1022, 1022, 1333, 1090,  978,  944, -32768, 1115,  445,
			  815, -32768,  511, 4313, -32768, 1305, 1350,  944, -32768,  549,
			 -32768, -32768, 1355, 1251, -32768, 1350,  518, -32768, 1401, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,   66,
			 -32768, -32768, -32768, -32768,   66, -32768, -32768, -32768, -32768,  259,

			  249,  728,  832,  638, 1022, 1022, 1022, 1552, 1066, 1066,
			 -32768, -32768, 1243,  875,  811, 1236, 1235, -32768, -32768, -32768,
			 1238, -32768,  582,  718, 1228, -32768, -32768,  669, -32768, -32768,
			 -32768, -32768, 5134, 5112, -32768, -32768, -32768, 1227, 1229, -32768,
			 -32768, -32768, -32768, 4313, 1224, 1022, -32768, 1221,   66, -32768,
			 -32768, 1217,  523, -32768,   50, 2049, -32768, 4313,   44, 1219,
			 -32768,   66, 4313, 4313, 4313, 4313, 4313, 4313, -32768, -32768,
			 4313, 4313, 4313, 4313, 4313, 4313, 4313, 4313, 4313, 4313,
			 4313, 4113, 4013, 4313,  669, -32768, -32768, -32768, 1917, 4891,
			 1333, 1333, 1109, 1090, 1109, 1090, 1211, -32768, -32768, 1462,

			 -32768, -32768, 1090, 1090, 1090, 1326, -32768, 1208, -32768, -32768,
			 1415, 1305, 1212, 1155,  669, 1100,  669,  893, 1207,  511,
			 -32768,  818, 4726,  798, 4313,  549, 1305, 1314, 1158, 1307,
			 -32768, -32768, -32768,  511, 4562, -32768, 1323, -32768, -32768, -32768,
			 -32768,  518,  216, 1310, 1055,  301,  936, -32768, 1216, 1304,
			 1156, 1134, 1301, 1194, 1193,  884,  875,  884,  875, -32768,
			 1185, -32768, 1182, 1173, -32768,  875,  875,  875, -32768, 1181,
			 1180, 1178, -32768, -32768,   66, 1170, -32768, -32768, 1174, -32768,
			 -32768,  270, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,

			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768,   66,  417, 4661, 3913, -32768, -32768, 4313, 1172,
			 -32768, 1171,  511, 1159, -32768,   66, 3813,  639,  669,  669,
			  170,   31, -32768,  307,   66,  455, -32768,  511, 1168,  581,
			  581,  581,  581,  765,  765,   96,   96,   96,  581,  581,
			  581,  581,   96,   96, 4979, 4988, 4313, 4988, 4313, 4531,
			 -32768,  270, 4313, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768,  201,  193,  534,  297,  391, 1022, 1022, 1022, 1415,
			  983,  983, -32768, -32768, 1149, 1163, 1157, 1090,  770, -32768,

			 -32768, -32768, -32768,  669, -32768,  214,  718, 1151, -32768,  549,
			 -32768,  669,  669, -32768,  669, 1147,  669, -32768, -32768, -32768,
			 -32768, 1150, 1150, -32768, 1130, 4647,  745, 1250,  549, -32768,
			 -32768,  549, -32768, 1158, 4418, -32768, -32768,  518,   66, -32768,
			 -32768,   34,  549, -32768, -32768,  669, 5090, -32768, -32768, -32768,
			  511,  511,  511,  511,    9, -32768, 1156, -32768, -32768, 1134,
			 -32768, 1249, -32768, 1216, 1133, 1113, 1132, 1126, 1125, 1122,
			 2162, 1066, 2162, 1121, 1116, 1114, -32768, -32768,  651,  669,
			 1552, 1552, -32768, 1118,  669, -32768, -32768, -32768, -32768, -32768,
			 -32768, 4803, 3713,  270, -32768,  523, -32768, 3213,  905, 4313,

			 4313,  237, 4804,  177, -32768,  758, -32768, -32768, -32768, -32768,
			 -32768, -32768,   66,  905, 4804,  177,  727,  111, -32768, 1094,
			 4988, 4531, 1779, -32768, 4738, 3613, 1109, 1090, 1109, 1090,
			 -32768, 1112, -32768, 1107, 1095, -32768, 1090, 1090, 1090, -32768,
			 1111, 1106, 1104, -32768, -32768, -32768, -32768, 1500, 1103, -32768,
			  246,   54, -32768, -32768, 1205,  435,  284, -32768, 1092, -32768,
			 -32768, -32768, -32768, 1097, -32768, 1093, -32768, -32768, 1079, -32768,
			 1200, 1158, -32768, -32768,  518, -32768, -32768, -32768, -32768, 1127,
			   66,  549, 1044, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,

			 -32768, -32768, -32768, -32768, -32768, 1037,  511, -32768, -32768, 1204,
			 -32768,  511, -32768, -32768, -32768,  117,  859, -32768, 1134, 1186,
			 -32768, 1156,  669,  669, -32768, -32768, -32768, -32768, -32768, 1066,
			 1066, -32768, -32768, -32768, 4313,  270, -32768, -32768, -32768, -32768,
			 -32768, -32768, 1490,  705, 3113, -32768, 4935,  332, 4313,  669,
			  488,  658,  447,  327,  327, 1071,  210,  488,  327,  327,
			 -32768, -32768, -32768, -32768,  669, -32768, -32768, -32768, 1087, 1085,
			 1084, 1080, 1462,  983, 1462, 1075, 1064, 1058, -32768, -32768,
			  587, -32768, -32768, -32768, 1415, 1415, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768,   66, -32768, -32768, 1158, -32768, -32768, -32768,

			 -32768,  511, 1425, 1127, 1044,  905, -32768,  511, -32768, -32768,
			  511,    9, 1161, -32768, 1134, -32768, -32768, -32768, -32768, 1049,
			 -32768, -32768, -32768, -32768, 4804,  177,  499,  669,  669,  669,
			  669, -32768, 4804,  327, 3013, 3013, 3513,  247,  247, -32768,
			 4804,  177,  327,  247,  247,  270, -32768, -32768, -32768, -32768,
			 -32768,  983,  983, -32768, -32768, 1158,  298,   66, -32768, -32768,
			 1158, -32768, -32768, 4614, 4464, 1044,  854,  905,  700, 1047,
			 -32768, 1037,  511, -32768, -32768, 1140,  186,  488,  327,  327,
			 -32768,   66, -32768, -32768, -32768, -32768, -32768, 1138, -32768, 1377,
			   66, -32768,   37,  696, 4313, 4313,  684, 1027, 1006,  538, yyDummy>>,
			1, 1000, 0)
		end

	yypact_template_2 (an_array: ARRAY [INTEGER]) is
			-- Fill chunk #2 of template for `yypact'.
		do
			yyarray_subcopy (an_array, <<
			 3413, 1083, 1081, -32768, 1108, -32768,  997,  984, 2301, -32768,
			 -32768, 1483, -32768, -32768, -32768,  363, -32768, 4313, 4313, 1105,
			 1102, -32768, 1101,  488,  327,  327, 1099, 1098, 1096, -32768,
			 -32768, -32768, -32768, -32768, -32768,   66, -32768,   64, -32768, -32768,
			   64, -32768, -32768, -32768, -32768, -32768, -32768, -32768,   64,   64,
			 1044,  905,  549, 1044,  660,  327, 4804,  177, -32768, -32768,
			 -32768, -32768,  327,  247,  247,  971, -32768,  161,  120,  884,
			  718, 1022, 1022, 1022,  875,  978,  969,  979, 1022, 2913,
			 1598, 4543, 3013,   66,  970, 1074,   66, -32768, -32768,  956,
			 -32768, 3313, 4313, 4313, 4313, -32768,   79,  669, 2433, 3013,

			 4313, 4313, 4313, 3013, -32768, -32768,  327,  247,  247, -32768,
			 -32768, -32768,  962, -32768, -32768, -32768, -32768, -32768,  905,  609,
			 1044,  905,  327, 4804,  177, 1056,  488,  327,  327, 1050,
			 1045, 1013, -32768,  523,  884,  875,  884,  882,  875,  876,
			 -32768, -32768, -32768,  875,  875,  875, -32768,  612,  382,  872,
			  744,  820,  563,  604, -32768,  867, -32768, 4804, -32768, 3013,
			  863,  669, -32768, 4935, 4935, 4313, 4313, 4313,  928,  270,
			 -32768, 4935, 4935, -32768,  523,  523,  951,  945,  942,  523,
			  523,  523,   68,  592,  327, 4804,  177,  905,  448,  912,
			  488,  327,  327,   64,  327,  247,  247, -32768, -32768, -32768,

			 -32768, -32768, -32768, -32768, -32768,  669, -32768, -32768, -32768,  823,
			  669,  270, -32768,  909,  902,  865,  827,  820, -32768, 3013,
			 -32768,  831,  543,  737,  656,  419, 4804, -32768,  828,  612,
			  270, 4935,  -52, 4497, 4313, 2181, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768,  327, 4804,  177,  825,  488,  327,
			  327,  336,  327, 4804,  177,   64,  327,  247,  247, -32768,
			  794,  790,  767,  523,  523,  523,  270,  669,  270, 2793,
			 3013, -32768,  680, -32768, -32768, -32768, -32768, -32768,  759, 4313,
			  737, -32768,  669, -32768, -32768, -32768, -32768,  537, -32768, 4313,
			  202,  123, 4497,  523,  523,  523,  720,  488,  327,  327,

			   64,  327,  247,  247,  327, 4804,  177,  688,  488,  327,
			  327, -32768,  685,  637,  618,   64,   64,   64, -32768, -32768,
			 -32768, -32768,  270, 2673, -32768,   66, -32768,  504,  528,  680,
			 -32768, -32768, -32768, -32768, -32768, 4543, -32768,  270,  669, 4935,
			 3013, -32768,  601,  584, -32768, -32768, -32768,   64,  327,  247,
			  247, -32768,  568,  564,  547,  526,  488,  327,  327,   64,
			  327,  247,  247,   64,   64,   64, -32768, -32768, -32768, -32768,
			  347, -32768,  680, -32768, -32768, 2553,  270, -32768, -32768, -32768,
			 -32768,  364,  349,  346,   64,   64,   64,   64,  327,  247,
			  247, -32768,  312,  289,  269, -32768, -32768, -32768,  204, -32768,

			 -32768,   64,   64,   64, -32768, -32768, -32768, -32768,  226,  206,
			  136,   64,   64,   64, -32768, -32768, -32768,   64,   64,   64,
			 -32768, -32768, -32768, -32768, -32768, -32768,  144,   89, -32768, yyDummy>>,
			1, 429, 1000)
		end

	yypgoto_template: SPECIAL [INTEGER] is
			-- Template for `yypgoto'
		once
			Result := yyfixed_array (<<
			 -205,  873, -32768, -32768, -32768, -154, -145, -136, -148, -293,
			 -167, -32768, -32768, -573,  716, -32768, -32768,  653,  -11,  834,
			 -259, -32768, -32768,  -16, -32768,  183, -32768, -32768,  225, -32768,
			 1129,   10, -32768, -32768,  222,  317, -265,   72, -684, -703,
			 -1162, -1098, -32768, -32768,  260,  569, -32768, -32768, -32768,  935,
			    8, -371, -402, -352, -384,  644,  777, -134, -32768, -32768,
			 -32768, 1369, 1403, 1119,  128, -32768, -350, -32768, -32768, -149,
			 -32768, -32768, -32768,  243, -32768, 1068, -32768,  608,  666, -545,
			 -32768, -32768, -32768, -32768, -744, -32768,  816, -278, -414, -797,
			 -32768, -32768, 1395,   32, 1233,  535,  573, -512, -553, -32768,

			 -32768, -32768, -32768, 1292,  456, -32768, -32768, -32768, -32768, -32768,
			 1387,  -17,  515, -32768, -32768, -103,  947,  977, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768,  333, -32768, -32768, -32768,
			 -32768, -32768, -32768,   35, -920,  -18, -32768, 1373, -224, -32768,
			 1179,  858, -605, 1225, -606, 1223,  830, 1214, -635,  194,
			 -32768, -32768, -32768, -32768, -519,  -41, -32768, -32768, -32768,  960,
			    4, -32768,  256, -32768, 1404, 1260,   46, -752,   56, -32768,
			 -32768, -32768, -32768, -32768, 1033, 1001,  415, -336, -356, 1051,
			 -32768, -383, 1048, -32768,   14, -521, -32768, -32768, -32768, -32768,
			  668,  231, -1196, -32768,  761, -176,  -66, -32768, -32768, -32768,

			 -32768,  853,  519,  181, -32768,  252, -32768, -932, -32768, -560,
			 -32768, -150, -32768, -32768, -32768, -32768, -32768,    7, -32768, -32768,
			 -32768, -32768,   42, -405, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -530, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, yyDummy>>)
		end

	yytable_template: SPECIAL [INTEGER] is
			-- Template for `yytable'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 5236)
			yytable_template_1 (an_array)
			yytable_template_2 (an_array)
			yytable_template_3 (an_array)
			yytable_template_4 (an_array)
			yytable_template_5 (an_array)
			yytable_template_6 (an_array)
			Result := yyfixed_array (an_array)
		end

	yytable_template_1 (an_array: ARRAY [INTEGER]) is
			-- Fill chunk #1 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			   35,  193,  686,   82,   77,   75,  700,  346,  460,  271,
			   74,    7,  859,  274,  311,  593,   21,  253,  159,  634,
			  292,  818,  545,  297,  288,   84,  715,  293,  592,  460,
			  905,  858,  317,  318,  319,  717,  310,  357,  140,  608,
			  576,  425,  578, 1042, 1042,   21,  808,   21,  813,  325,
			  750,  644,  106,  819, 1273, 1221,  671,  272,  649,  672,
			  942,  639,   82,  110,   75,  525,  617, 1089,  883,   74,
			  344,  117, 1289,  773,  680,  681, 1333,  126,  643,   82,
			  110,   75,  536,  132,   84,  648,   74,  132,  536, 1428,
			   82,  110,   75,  118,  136,  146,  147,   74,  117, -625,

			 -625,   84,  103,   34,   33,   32,  169,  170,  171,    3,
			  390,  391,   84,  185,  184,  135,  134,  133,    2,  191,
			  428,  909,  840,  320, 1278, 1167, 1166,  153,  162,  412,
			  102, -174,  101, 1333,  333,  338, 1139, 1341,  132,  131,
			  130,  472,  473,   68, 1427,  814,  332,  283,  176,   76,
			 1419,  280,  967, -174,  709,    1,  291, -174,  780,  296,
			  100, -174,  468,  266,  312, -605,  427,  383,  544,  848,
			 1166,   45,  181, 1374,  535,  105, 1333,  475,  326,  761,
			 1062,  731,  335,   34,   33,   32,  914,  609,  852,  173,
			 1007, 1007, 1137,   33, 1136,  129,  355,  750,   42,   41,

			 1113,  906,  628,  731,  128,  717,  743,  744,   76,  371,
			  851,  898,  912, 1051,  181, 1209, -522,  181,  739,  360,
			 1418,  176,  979,  453, 1087,   76, 1106,  940,  454,  173,
			 -195,  401,  400,  132,  862, 1134,   76, -174, 1025,  701,
			 1417,  978,   34,   33,   32,  335,  423,  525, -390, -522,
			  692,  776, -195, -174,  778,  336, -195, 1024,  645,  436,
			  881,   68,  759,  266,  760,  132,  762,  728,  618,  356,
			 -390,  829,  830,  132,  266,  726,  682,  176,  775,   68,
			  633,  777,  531, 1413,  463,  462, 1019,  173,  411,   45,
			  399,  312,  312,  707,  725,  548,  410, 1287, 1118,  426,

			  176, 1121,  667, 1412,  669,  463,  462,  666,  975,  668,
			  481,  673,  674,  675,  684, -190,   42,   41,   34,   33,
			   32,  132,  627,  457, 1061,  872, 1411,  873,  925, 1194,
			  874,  132,  684,  455,  183,  182,  959,  941, 1007,  752,
			  543, -190,  936,  181,  132,  255,  394,  884,  885,  924,
			  173,  396, 1042, 1305, 1128, 1007,   34,   33,   32, 1007,
			 1403,  701,  847, 1402,  181,  701,  722,  571, 1187,   34,
			   33,   32,   68, 1127,  868,  314,  870,  856, 1401, -386,
			 -386, -386,  596,  295, 1304,   34,   33,   32,  314, 1006,
			 1006,  900,  344, 1256,  132, 1030,  392,  615,  972,  615,

			 1034,  577,  335,  579,  176,  889, 1018,  626,  678, 1042,
			  599,  600,  601,  111,  692, 1007,  436,  436,  899, 1032,
			  173, 1192,  732, 1031,  436, 1101, 1100,  183,  182,  344,
			  127,  712,  711,  294,  399,  410,  399,  410,  255,  255,
			 1191,  145, 1047, 1047,  410,  410,  410,  725,  132, 1057,
			  175, 1301, 1042, -222, -222,  686,  683,   68,  645, -222,
			  972, -510, -510, -222,  132, 1253,  172, -222, 1398,  698,
			 1091, -222,  714,  951,  952, 1007, -222,  701,  713,  771,
			  413,  415,  333, 1250,  701,   45, -510, 1102,  839,  948,
			  950,  932,   68,  969,  332,  431, 1252,  181, -222,  181,

			 1348,  314, 1249,  949,  826,  828,  754,   34,   33,   32,
			 1210, 1360,   42,   41,  949,  335,  735, -474,   27,  423,
			   45,  705,  705,  705,  705,  770, 1007,  827, -474,  350,
			  335,   34,   33,   32,  333, 1124,  827, 1006,  433,  782,
			 1387,  333, 1284, 1299, 1283,  684,  332,   42,   41,   26,
			   25, 1310,   24,  332, 1006, 1213,  887, 1277, 1006, 1388,
			 1200, 1386, 1298,  349, 1165,  412,  734,  733,  950,  968,
			 1309,    3,  779,  596,  596, -514, -514, -514, 1385,  348,
			    2,  347, 1384,   34,   33,   32,  751, 1372,  734,  733,
			   34,   33,   32,  598,  758,  615, 1007,  615, 1379,  615,

			 1186, 1236, 1237, 1358,  598, -514, 1241, 1242, 1243, 1245,
			   34,   33,   32,  880, 1006, 1378, 1213,  436, 1220,  896,
			  436,  701, 1357,  981,  980,  399, 1185,  686,  705, 1371,
			  918, 1054, 1365,  335,  335,  335,  335,  163,  701,  410,
			 1244,  772, 1087,  174,  177,  533,  855,  399,  186,  187,
			  188, 1364,  383,  312,  312,  312,  702, 1184, 1086,  730,
			 -119,  686,  833,  828, 1246, 1338,  254,  835,  701, 1254,
			 1016,  396, -512, -512, 1006, 1001, 1001, 1123,  904,  163,
			  163,  163,  423,  626,   34,   33,   32,  378,  377,  701,
			 1318, 1319, 1320,  372,  371,  370,  313, -512,  216, 1363,

			  335,  290, 1359,   34,   33,   32,  850,  479, 1122,  313,
			 -520,  367,  366,  954,  903, 1119, 1087, 1056,  857,  178,
			 1344, 1345, 1346,  953,  190, 1006,   34,   33,   32,  701,
			 -520, -520, 1306,  751, 1347,  869,  955,  871,  758,  758,
			 1029,   34,   33,   32,  875,  876,  877,  960, 1055,   69,
			 1279,  289,   34,   33,   32,   68, 1213,  436, 1212,  254,
			  254,  393,  395,  464, -474,  402,  403,  404,  399,  410,
			  399,  410,  334, 1334,  189, -474,  919,  832,  410,  410,
			  410, 1317, 1183,  598, 1282, 1188,  352,  831, 1079,  335,
			   34,   33,   32,   68,  335, 1006,   44,  259,  258,  965,

			 1325,  113,  112, 1098, 1316,  915,  916,  273, 1315,  222,
			  183,  182,  312,  312,  456,  458, 1078, 1154,  344,  465,
			  466,  467,  313, 1001,   34,   33,   32,  956,  921, -212,
			  920,  626,  926, -212, 1170,  421,  383, -212, 1173, 1300,
			 1001, -212, 1286, 1203, 1001, 1276, -212,  945,  183,  182,
			  861, 1251,  860,  459, -486,  596,  596,  596,  934,  935,
			  529, 1050, 1215, 1053,  314,  178,  314,  344, -212,  768,
			 1152,  378,  377, -170,  314,  314,    3,  372,  371,  370,
			  333, 1052,  712,  711,  335,    2,  982,  983,  984,  985,
			  436,  956,  332,  335, 1228, -170,  -92,  222,  195, -170,

			 1001,  259,  258, -170,   34,   33,   32,   68, -569,  389,
			  926,  926,  926,  926,  597, 1065, 1271, 1008, 1008,  423,
			  344, 1140,  624, -516, 1077,  597, 1255,  331,  977,   34,
			   33,   32,  149,  148,  596,  596,  986, -443, 1146,  195,
			  622,  255,  621,  536, 1023, 1043, 1043, 1039, 1039, 1120,
			 -165, 1267, 1038, 1038, 1275,  335, 1240,  461, -247, 1239,
			 1001,  330,  183,  182, 1235, 1238, -247, 1044, 1044, 1112,
			 -247,  345, -165,  344, 1234, -247, -165, 1046, 1046,  200,
			 -165, 1202, 1088,  423, 1229,   98, 1201,   99, 1224, 1206,
			 1207, 1208,  421, 1211,  704,  706,  708,  710, 1041, 1041, yyDummy>>,
			1, 1000, 0)
		end

	yytable_template_2 (an_array: ARRAY [INTEGER]) is
			-- Fill chunk #2 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			  423,  626, 1204, 1082, 1205, 1324, 1269,   95,   96,  524,
			 1022, 1001,  192,  328,  329, 1027, 1028, 1155,  339, -474,
			 1160,  178,  340,  389,  341, 1288, 1103, 1199,  549,  550,
			  551,  552,  553,  554,  574,  575,  555,  556,  557,  558,
			  559,  560,  561,  562,  563,  564,  565,  567,  569,  570,
			 -209, 1088, 1142, 1141, -209,  742,  741,  740, -209, 1198,
			 1126, 1321, -209, 1323, 1197, 1008,  598, -209,  598, -157,
			 1193, -157,  888,  890,  626, 1377,   89,  423,  598,  598,
			 1169, 1001, 1008, 1182, 1161,  626, 1008, 1151, 1158, -209,
			  625, -157, 1159, 1156,  132, -157,  727,  729, 1147, -157,

			 1148,  736,  737,  738,  597,  695,  195, 1132, -221, -221,
			 1111,  181, 1110, 1109, -221, 1105, 1104, 1369, -221, -518,
			  716,  385, -221, -216, -216, 1097, -221, 1190, 1084, -216,
			 1088, -221, 1375, -216, 1094, 1130, 1131, -216,  471,  470,
			  469, -216, 1008, 1093, 1230, 1092, -216, 1083,  626, 1232,
			 1174, 1175, 1066, -221, 1060, 1179, 1180, 1181,   -4, 1219,
			 1223, 1225,  860, -215, -215,  282,  285,  287, -216, -215,
			  976, 1400, 1058, -215,  443,  974,  181, -215,  181, 1177,
			 1178, -215,  901, 1075,  -87,  313, -215,  313, 1266, 1248,
			  -89,  524,  445, 1268,  691,  313,  313,  281,  284,  286,

			  913,  -88, 1008,   91,   92,   93,  -90,  939, -215,  907,
			  -96,  -91, 1088,  -97,  897,  895,  894,  891,  892,  886,
			 1270,  -93,  864,  805,  805,  809,  805,  407,  -98,  879,
			 1225,  732,  720,  -94,  721,  412,  878, -107,  724,  834,
			 -438,  823, -440, 1263, 1264, 1265,  396, -439, -441, 1297,
			 1322, -447, -442, 1008, 1043, 1331, 1326, 1308, -448, 1370,
			  442,  822,  254,  820,  769, 1337,  766, 1261, 1262,  938,
			  763, 1115,  761,  943,  944,  745,  753, -135, -135, 1116,
			 1117,  747,  696, -135, 1293, 1294, 1295, -135,  746,  719,
			  716, -135,  694,  693,  -34, -135, -437, 1340,  -34, -444,

			 -135,  -34,  679,  677,  -34,  461,  676,  -34, -445, 1356,
			 -458, 1043, 1331, 1326,  665,  664,  -34,  446,  657,  -34,
			  -34, 1376, -135, 1008, -200,  -34,  646,   10,  629, 1313,
			 1314,  155,  619,  610,  604,  -34,  -34,  580,  -34,  -33,
			  602,  405,  546,  -33,  530,  532,  -33,  527,  987,  -33,
			  523,  522,  -33,  480, 1043, 1331, 1326, 1026,  691,  478,
			  477,  -33,  476,  846,  -33,  -33,  625,  474,  273,  430,
			  -33,  412, -610, -607, 1353, 1354, -608,  359,  361,  805,
			  -33,  -33,  384,  -33,  809, -609,  342,  597,  -25,  597,
			 -606,  724,  -25, 1063, 1064,  -25, -605,  321,  -25,  597,

			  597,  -25,  327,  103,  101,  136,  298,  270,  144,  154,
			  -25,  245,  244,  -25,  -25,  447,  196,  446,  151,  -25,
			  142, 1382, 1383,   39, 1259,  125, 1073, 1072, 1071,  -25,
			  -25,  124,  -25, 1393, 1394,  123,  -23,  445,  444, 1107,
			 1108,  443,  -23,  136,  119,  442,  109,    3,  108,  132,
			 1070, 1069,  964,   94,  -23,  104,    2,  -23,  -23,   27,
			   97, 1409, 1410,  -23,  588,  587,  586,   87,   37, 1274,
			 1125,   22, 1342,  -23,  961,  765, 1033, 1129,  863,  908,
			  107,  636, 1285,  971,  635,  689, 1311,  607,  606,  605,
			  136,  387,  451,  821,  160, -524, -524, -524, -524,  781,

			  917,  450,  150,  449, 1074,  353, 1068, 1059,  432, -524,
			  846,  588,  587,  586,  625, 1067,  158,   29,  136,  973,
			  662, 1176, -524, 1336,  156, -524,  267,  882,  136, -524,
			 -524, 1351,  748, 1049,  585,  584,  583, 1189,  620,  135,
			  134,  133, 1195, 1196,  582,  971, 1366, 1367, 1368,  252,
			  251,  250, 1343,  581, 1373, 1399,  966,  963,  632,  867,
			  923,  962,  337,  131,  130,  838,    0,    0,    0,    0,
			    0,    0,  132,  249,  248,    0,    0,    0, 1380,    0,
			  136,    0, 1135, 1138,    0,    0, 1143, 1144, 1145,    0,
			 1391,  582,    0, 1149, 1395, 1396, 1397,    0,    0, 1247,

			  581,  306,  305,  304,    0,    0, 1257, 1258,    0, 1260,
			 -564,    0, -564,    0,    0, 1404, 1405, 1406, 1407,  129,
			    0,    0,    0,    0,  324,  323,  322,    0,  128,  247,
			    0,    0, 1414, 1415, 1416,    0,    0,    0,  246,    0,
			    0,    0, 1420, 1421, 1422,    0,    0,    0, 1423, 1424,
			 1425,    0,    0,    0,    0,    0,    0,    0,    0, 1296,
			 1080, 1081,    0,    0, 1302, 1303,    0, 1307,    0,  383,
			    0, 1312,    0,    0,  382,  381,  380,    0,  379,    0,
			    0,  300,    0,    0,  625,    0,    0,    0,    0,    0,
			  299,    0,    0,    0,    0,    0,    0,    0,    0,    0,

			    0,    0,    0,    0,  378,  377,  376,  375,  374,  373,
			  372,  371,  370, 1349, 1350,    0, 1352,    0,    0, 1355,
			    0,    0,    0,    0, 1361, 1362,    0,    0,  367,  366,
			  365,  364,  363,  362,    0,    0,    0,    0,    0,  -17,
			    0,    0,    0,  -17,    0,    0,  -17,    0,    0,  -17,
			    0,    0,  -17,    0,    0,    0,    0,  625, 1163, 1164,
			    0,  -17,    0, 1381,  -17,  -17, 1171, 1172,  625,    0,
			  -17,    0, 1389, 1390,    0, 1392,    0,    0,    0,    0,
			  -17,  -17,    0,  -17,    0, -598,    0, -598,    0, -598,
			 -598, -598, -598, -598, -598,    0, -598, -598, -598,    0,

			 -598, -598,    0, 1408, -598, -598,    0,    0, -598, -598,
			 -598,    0, -598, -598,    0,    0,    0,    0, -598,    0,
			 -598, -598, -598,    0,    0, -598, -598, -598,    0,    0,
			    0,  625, 1231, 1233,    0, -598, -598,    0,    0, -598,
			 -598,    0,    0,    0, -598, -598, -598,    0, -598, -598,
			 -598, -598, -598, -598, -598, -598, -598, -598, -598, -598,
			 -598, -598, -598, -598, -598, -598, -598, -598, -598, -598,
			 -598, -598, -598, -598, -598, -598, -598, -598, -598, -598,
			 -598, -598, -598, -598, -598, -598, -598, -598, -598, -598,
			 -598, -598, -598, -598, -598, -598, -598,    0, -598, -598,

			 1292, -598, -598,    0, -598, -598, -598,    0, -598, -598,
			 -598, -598, -598, -598, -598, -598, -598,    0,    0,    0,
			    0,    0,    0, -597,    0, -597,    0, -597, -597, -597,
			 -597, -597, -597,    0, -597, -597, -597,    0, -597, -597,
			    0,    0, -597, -597,    0, 1335, -597, -597, -597,    0,
			 -597, -597,    0,    0,    0, 1339, -597,    0, -597, -597,
			 -597,    0,    0, -597, -597, -597,    0,    0,    0,    0,
			    0,    0,    0, -597, -597,    0,    0, -597, -597,    0,
			    0,    0, -597, -597, -597,    0, -597, -597, -597, -597,
			 -597, -597, -597, -597, -597, -597, -597, -597, -597, -597, yyDummy>>,
			1, 1000, 1000)
		end

	yytable_template_3 (an_array: ARRAY [INTEGER]) is
			-- Fill chunk #3 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			 -597, -597, -597, -597, -597, -597, -597, -597, -597, -597,
			 -597, -597, -597, -597, -597, -597, -597, -597, -597, -597,
			 -597, -597, -597, -597, -597, -597, -597, -597, -597, -597,
			 -597, -597, -597, -597, -597,    0, -597, -597,    0, -597,
			 -597,    0, -597, -597, -597,    0, -597, -597, -597, -597,
			 -597, -597, -597, -597, -597, -310,    0, -310,    0, -310,
			 -310, -310, -310, -310, -310,    0, -310, -310, -310,    0,
			 -310, -310,    0,    0, -310, -310,    0,    0, -310, -310,
			 -310,    0, -310, -310,    0,    0,    0,    0, -310,    0,
			 -310, -310, -310,    0,    0, -310, -310, -310,    0,    0,

			    0,    0,    0,    0,    0, -310, -310,    0,    0, -310,
			 -310,    0,    0,    0, -310, -310, -310,    0, -310, -310,
			 -310, -310, -310, -310, -310, -310, -310, -310, -310, -310,
			 -310, -310, -310, -310, -310, -310, -310, -310, -310, -310,
			 -310, -310, -310, -310, -310, -310, -310, -310, -310, -310,
			 -310, -310, -310, -310, -310, -310, -310, -310, -310, -310,
			 -310, -310, -310, -310, -310, -310, -310,    0, -310, -310,
			    0, -310, -310,    0, -310, -310, -310,    0, -310, -310,
			 -310, -310, -310, -310, -310, -310, -310, -592,    0, -592,
			  136, -592,    0, -592, -592, -592, -592,    0,    0, -592,

			 -592,    0, -592,    0,    0,    0, -592, -592,    0,    0,
			    0,  306,  305,  304,    0, -592,    0,    0,    0,    0,
			 -592,    0, -592, -592,    0,    0,    0, -592, -592,    0,
			    0,    0,    0,    0,  303,  302,  301, -592, -592,    0,
			    0, -592,    0, -599,    0,    0, -592, -592, -592,    0,
			 -592, -592,    0, -592, -592, -592, -592,    0,    0,    0,
			    0,    0, -592, -592, -592, -592, -592, -592, -592, -592,
			 -592, -592, -592, -592, -592, -592, -592, -592, -592, -592,
			 -592, -592, -592, -592, -592, -592, -592,    0,    0,    0,
			    0,  300,    0,    0,    0,    0, -592, -592, -592,    0,

			  299, -592,    0, -592,    0,    0,    0, -612, -592, -612,
			 -592, -612,    0, -612, -612, -612, -612, -592, -598, -612,
			 -612,    0, -612,    0,    0,    0, -612, -612,    0,    0,
			    0,    0,    0,    0,    0, -612,    0,    0,    0,    0,
			 -612,    0, -612, -612,    0,    0,    0, -612, -612,    0,
			    0,    0,    0,    0,    0,    0,    0, -612, -612,    0,
			    0, -612,    0,    0,    0,    0, -612, -612, -612,    0,
			 -612, -612,    0, -612, -612, -612, -612,    0,    0,    0,
			    0,    0, -612, -612, -612, -612, -612, -612, -612, -612,
			 -612, -612, -612, -612, -612, -612, -612, -612, -612, -612,

			 -612, -612, -612, -612, -612, -612, -612,    0,    0,    0,
			    0,    0,    0,    0,    0,    0, -612, -612, -612,    0,
			    0, -612,    0,  344,    0,    0,    0,    0, -612, -612,
			 -612,    0,    0,    0,    0,    0,    0, -612, -612, -591,
			    0, -591,    0, -591,    0, -591, -591, -591, -591,    0,
			    0, -591, -591,    0, -591,    0,    0,    0, -591, -591,
			    0,    0,    0,    0,    0,    0,    0, -591,    0,    0,
			    0,    0, -591,    0, -591, -591,    0,    0,    0, -591,
			 -591,    0,    0,    0,    0,    0,    0,    0,    0, -591,
			 -591,    0,    0, -591,    0,    0,    0,    0, -591, -591,

			 -591,    0, -591, -591,    0, -591, -591, -591, -591,    0,
			    0,    0,    0,    0, -591, -591, -591, -591, -591, -591,
			 -591, -591, -591, -591, -591, -591, -591, -591, -591, -591,
			 -591, -591, -591, -591, -591, -591, -591, -591, -591,    0,
			    0,    0,    0,    0,    0,    0,    0,    0, -591, -591,
			 -591,    0,    0, -591,    0, -591,    0,    0,    0, -595,
			 -591, -595, -591, -595,    0, -595, -595, -595, -595, -591,
			 -597, -595, -595,    0, -595,    0,    0,    0, -595, -595,
			    0,    0,    0,    0,    0,    0,    0, -595,    0,    0,
			    0,    0, -595,    0, -595, -595,    0,    0,    0, -595,

			 -595,    0,    0,    0,    0,    0,    0,    0,    0, -595,
			 -595,    0,    0, -595,    0,    0,    0,    0, -595, -595,
			 -595,    0, -595, -595,    0, -595, -595, -595, -595,    0,
			    0,    0,    0,    0, -595, -595, -595, -595, -595, -595,
			 -595, -595, -595, -595, -595, -595, -595, -595, -595, -595,
			 -595, -595, -595, -595, -595, -595, -595, -595, -595,    0,
			    0,    0,    0,    0,    0,    0,    0,    0, -595, -595,
			 -595,    0,    0, -595,    0, -595,    0,    0,    0, -596,
			 -595, -596, -595, -596,    0, -596, -596, -596, -596, -595,
			    0, -596, -596,    0, -596,    0,    0,    0, -596, -596,

			    0,    0,    0,    0,    0,    0,    0, -596,    0,    0,
			    0,    0, -596,    0, -596, -596,    0,    0,    0, -596,
			 -596,    0,    0,    0,    0,    0,    0,    0,    0, -596,
			 -596,    0,    0, -596,    0,    0,    0,    0, -596, -596,
			 -596,    0, -596, -596,    0, -596, -596, -596, -596,    0,
			    0,    0,    0,    0, -596, -596, -596, -596, -596, -596,
			 -596, -596, -596, -596, -596, -596, -596, -596, -596, -596,
			 -596, -596, -596, -596, -596, -596, -596, -596, -596,    0,
			    0,    0,    0,    0,    0,    0,    0,    0, -596, -596,
			 -596,    0,    0, -596,    0, -596,    0,    0,    0, -594,

			 -596, -594, -596, -594,    0, -594, -594, -594, -594, -596,
			    0, -594, -594,    0, -594,    0,    0,    0, -594, -594,
			    0,    0,    0,    0,    0,    0,    0, -594,    0,    0,
			    0,    0, -594,    0, -594, -594,    0,    0,    0, -594,
			 -594,    0,    0,    0,    0,    0,    0,    0,    0, -594,
			 -594,    0,    0, -594,    0,    0,    0,    0, -594, -594,
			 -594,    0, -594, -594,    0, -594, -594, -594, -594,    0,
			    0,    0,    0,    0, -594, -594, -594, -594, -594, -594,
			 -594, -594, -594, -594, -594, -594, -594, -594, -594, -594,
			 -594, -594, -594, -594, -594, -594, -594, -594, -594,    0,

			    0,    0,    0,    0,    0,    0,    0,    0, -594, -594,
			 -594,    0,    0, -594,    0, -594,    0,    0,    0, -593,
			 -594, -593, -594, -593,    0, -593, -593, -593, -593, -594,
			    0, -593, -593,    0, -593,    0,    0,    0, -593, -593,
			    0,    0,    0,    0,    0,    0,    0, -593,    0,    0,
			    0,    0, -593,    0, -593, -593,    0,    0,    0, -593,
			 -593,    0,    0,    0,    0,    0,    0,    0,    0, -593,
			 -593,    0,    0, -593,    0,    0,    0,    0, -593, -593,
			 -593,    0, -593, -593,    0, -593, -593, -593, -593,    0,
			    0,    0,    0,    0, -593, -593, -593, -593, -593, -593, yyDummy>>,
			1, 1000, 2000)
		end

	yytable_template_4 (an_array: ARRAY [INTEGER]) is
			-- Fill chunk #4 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			 -593, -593, -593, -593, -593, -593, -593, -593, -593, -593,
			 -593, -593, -593, -593, -593, -593, -593, -593, -593, 1000,
			    0,  999,    0,  998,    0,    0,    0,    0, -593, -593,
			 -593,  997,  996, -593,  995, -593,    0,    0,  994,    0,
			 -593,    0, -593,    0,    0,    0,    0,  215,    0, -593,
			    0,    0,    0,    0,  214,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,  213,
			  993,    0,    0,  211,    0,    0,    0,    0,  210,   71,
			   70,    0,   69,  209,    0,   34,   33,   32,  207,    0,
			    0,    0,    0,    0,   67,   66,   65,   64,   63,   62,

			   61,   60,   59,   58,   57,   56,   55,   54,   53,   52,
			   51,   50,   49,   48,   47,   46,  205,  992,  991,    0,
			    0,   73,    0,    0,    0,    0,    0,    0,  203,   44,
			   43,  216,    0,  990,    0,  200,    0,    0,    0,    0,
			  199,    0,  989,    0,    0,    0,    0,  215,    0,  988,
			    0,    0,    0,    0,  214,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,  213,
			  212,    0,    0,  211,    0,    0,    0,    0,  210,   71,
			   70,    0,   69,  209,  208,   34,   33,   32,  207,    0,
			    0,    0,  206,    0,   67,   66,   65,   64,   63,   62,

			   61,   60,   59,   58,   57,   56,   55,   54,   53,   52,
			   51,   50,   49,   48,   47,   46,  205,  204,    0,    0,
			    0,   73,    0,    0,    0,    0,    0,    0,  203,   44,
			   43,  216,  202,  842,    0,  200,  922,    0,    0,    0,
			  199,    0,    0,  198,  197,    0,    0,  215,    0,    0,
			  105,  841,    0,    0,  214,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,  213,
			  212,    0,    0,  211,    0,    0,    0,    0,  210,   71,
			   70,    0,   69,  209,  208,   34,   33,   32,  207,    0,
			    0,    0,  206,    0,   67,   66,   65,   64,   63,   62,

			   61,   60,   59,   58,   57,   56,   55,   54,   53,   52,
			   51,   50,   49,   48,   47,   46,  205,  204,    0,    0,
			    0,   73,    0,    0,    0,    0,    0, 1162,  203,   44,
			   43,  216,  202,  842,    0,  200,    0,    0,    0,    0,
			  199,    0,    0,  198,  197,    0,    0,  215,    0,    0,
			  105,  841,    0,    0,  214,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,  213,
			  212,    0,    0,  211,    0,    0,    0,    0,  210,   71,
			   70,    0,   69,  209,  208,   34,   33,   32,  207,    0,
			    0,    0,  206,    0,   67,   66,   65,   64,   63,   62,

			   61,   60,   59,   58,   57,   56,   55,   54,   53,   52,
			   51,   50,   49,   48,   47,   46,  205,  204,    0,    0,
			    0,   73,    0,    0,    0,    0,    0, 1090,  203,   44,
			   43,  216,  202,  201,    0,  200,    0,    0,    0,    0,
			  199,    0,    0,  198,  197,    0,    0,  215,    0,    0,
			  105,    0,    0,    0,  214,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,  213,
			  212,    0,    0,  211,    0,    0,    0,    0,  210,   71,
			   70,    0,   69,  209,  208,   34,   33,   32,  207,    0,
			    0,    0,  206,    0,   67,   66,   65,   64,   63,   62,

			   61,   60,   59,   58,   57,   56,   55,   54,   53,   52,
			   51,   50,   49,   48,   47,   46,  205,  204,    0,    0,
			    0,   73,    0,    0,    0,    0,    0,    0,  203,   44,
			   43,  216,  202,  201,    0,  200,    0,    0,    0,    0,
			  199,    0,    0,  198,  197,    0,    0,  215,    0,    0,
			  105,    0,    0,    0,  214,    0, 1017,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,  213,
			  212,    0,    0,  211,    0,    0,    0,    0,  210,   71,
			   70,    0,   69,  209,  208,   34,   33,   32,  207,    0,
			    0,    0,  206,    0,   67,   66,   65,   64,   63,   62,

			   61,   60,   59,   58,   57,   56,   55,   54,   53,   52,
			   51,   50,   49,   48,   47,   46,  205,  204,    0,    0,
			    0,   73,    0,    0,    0,    0,    0,    0,  203,   44,
			   43,  216,  202,  201,    0,  200,    0,    0,    0,    0,
			  199,    0,    0,  198,  197,    0,    0,  215,    0,    0,
			  105,    0,    0,    0,  214,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,  213,
			  212,    0,    0,  211,    0,    0,    0,    0,  210,   71,
			   70,    0,   69,  209,  208,   34,   33,   32,  207,    0,
			    0,    0,  206,    0,   67,   66,   65,   64,   63,   62,

			   61,   60,   59,   58,   57,   56,   55,   54,   53,   52,
			   51,   50,   49,   48,   47,   46,  205,  204,    0,    0,
			    0,   73,    0,    0,    0,    0,    0,    0,  203,   44,
			   43,  216,  202,  201,    0,  200,    0,    0,    0,  866,
			  199,    0,    0,  198,  197,    0,    0,  215,    0,    0,
			  105,    0,    0,    0,  214,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,  213,
			  212,    0,    0,  211,    0,    0,    0,    0,  210,   71,
			   70,    0,   69,  209,  208,   34,   33,   32,  207,    0,
			    0,    0,  206,    0,   67,   66,   65,   64,   63,   62,

			   61,   60,   59,   58,   57,   56,   55,   54,   53,   52,
			   51,   50,   49,   48,   47,   46,  205,  204,    0,    0,
			    0,   73,    0,    0,    0,  699,    0,    0,  203,   44,
			   43,  216,  202,  201,    0,  200,  837,    0,    0,    0,
			  199,    0,    0,  198,  197,    0,    0,  215,    0,    0,
			  105,    0,    0,    0,  214,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,  213,
			  212,    0,    0,  211,    0,    0,    0,    0,  210,   71,
			   70,    0,   69,  209,  208,   34,   33,   32,  207,    0,
			    0,    0,  206,    0,   67,   66,   65,   64,   63,   62,

			   61,   60,   59,   58,   57,   56,   55,   54,   53,   52,
			   51,   50,   49,   48,   47,   46,  205,  204,    0,    0,
			    0,   73,    0,    0,    0,    0,    0,    0,  203,   44,
			   43,  216,  202,  201,    0,  200,    0,    0,    0,    0,
			  199,    0,    0,  198,  197,    0,    0,  215,    0,    0,
			  105,    0,    0,    0,  214,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,  213,
			  212,    0,    0,  211,  688,    0,    0,    0,  210,   71,
			   70,    0,   69,  209,  208,   34,   33,   32,  207,    0,
			    0,    0,  206,    0,   67,   66,   65,   64,   63,   62, yyDummy>>,
			1, 1000, 3000)
		end

	yytable_template_5 (an_array: ARRAY [INTEGER]) is
			-- Fill chunk #5 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			   61,   60,   59,   58,   57,   56,   55,   54,   53,   52,
			   51,   50,   49,   48,   47,   46,  205,  204,    0,    0,
			    0,   73,    0,    0,    0,    0,    0,    0,  203,   44,
			   43,  216,  202,  201,    0,  200,    0,    0,    0,    0,
			  199,    0,    0,  198,  197,    0,    0,  215,    0,    0,
			  105,    0,    0,    0,  214,    0,  568,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,  213,
			  212,    0,    0,  211,    0,    0,    0,    0,  210,   71,
			   70,    0,   69,  209,  208,   34,   33,   32,  207,    0,
			    0,    0,  206,    0,   67,   66,   65,   64,   63,   62,

			   61,   60,   59,   58,   57,   56,   55,   54,   53,   52,
			   51,   50,   49,   48,   47,   46,  205,  204,    0,    0,
			    0,   73,    0,    0,    0,  566,    0,    0,  203,   44,
			   43,  216,  202,  201,    0,  200,    0,    0,    0,    0,
			  199,    0,    0,  198,  197,    0,    0,  215,    0,    0,
			  105,    0,    0,    0,  214,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,  213,
			  212,    0,    0,  211,    0,    0,    0,    0,  210,   71,
			   70,    0,   69,  209,  208,   34,   33,   32,  207,    0,
			    0,    0,  206,    0,   67,   66,   65,   64,   63,   62,

			   61,   60,   59,   58,   57,   56,   55,   54,   53,   52,
			   51,   50,   49,   48,   47,   46,  205,  204,    0,    0,
			    0,   73,    0,    0,    0,    0,    0,    0,  203,   44,
			   43,  216,  202,  201,    0,  200,    0,    0,    0,    0,
			  199,    0,    0,  198,  197,    0,    0,  215,    0,    0,
			  105,    0,    0,    0,  214,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,  213,
			  212,    0,    0,  211,    0,    0,    0,    0,  210,   71,
			   70,    0,   69,  209,  208,   34,   33,   32,  207,    0,
			    0,    0,  206,    0,   67,   66,   65,   64,   63,   62,

			   61,   60,   59,   58,   57,   56,   55,   54,   53,   52,
			   51,   50,   49,   48,   47,   46,  205,  204,    0,    0,
			    0,   73,    0,    0,    0,    0,    0,    0,  203,   44,
			   43,  216,  202,  201,    0,  200,    0,    0,    0,  386,
			  199,    0,    0,  198,  197,    0,    0,  215,    0,    0,
			  105,    0,    0,    0,  214,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,  213,
			  212,    0,    0,  211,    0,    0,    0,    0,  210,   71,
			   70,    0,   69,  209,  208,   34,   33,   32,  207,    0,
			   73,    0,  206,    0,   67,   66,   65,   64,   63,   62,

			   61,   60,   59,   58,   57,   56,   55,   54,   53,   52,
			   51,   50,   49,   48,   47,   46,  205,  204,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,  203,   44,
			   43,    0,  202,  201,    0,  200,    0,    0,  433,    0,
			  199,  333,    0,  198,  197,  639,    0,   72,   71,   70,
			  105,   69,    0,  332,   34,   33,   32,   68,    0,    0,
			    0,    0,    0,   67,   66,   65,   64,   63,   62,   61,
			   60,   59,   58,   57,   56,   55,   54,   53,   52,   51,
			   50,   49,   48,   47,   46,   45,    3,    0,    0,    0,
			   34,   33,   32,  -20,    0,    2,    0,  -20,   44,   43,

			  -20,    0,    0,  -20,    0,    0,  -20,    0,    0, 1048,
			    0,    0,   42,   41,    0,  -20,    0,    0,  -20,  -20,
			    0,    0,    0,    0,  -20,    0,    0, 1290,    0, 1036,
			   71,   70,    0,   69,  -20,  -20,    0,  -20,    0,   68,
			  347,    0,  638,  774,    0,   67,   66,   65,   64,   63,
			   62,   61,   60,   59,   58,   57,   56,   55,   54,   53,
			   52,   51,   50,   49,   48,   47,   46,   45,  383,    0,
			    0,    0,    0,  382,  381,  380,    0,  379,    0,    0,
			   44,   43,  433,    0, 1035,  333, 1152,    0,    0,  639,
			    0,    0,    0,    0,   42,   41,    0,  332,    0,    0,

			    0,    0,  383,  378,  377,  376,  375,  374,  373,  372,
			  371,  370,    0,    0,  383,    0,    0,    0,    0,  382,
			  381,  380,    0,  379,    0,    0,    0,  367,  366,  365,
			  364,  363,  362,    0,   34,   33,   32,  378,  377,  376,
			  375,  374,  373,  372,  371,  370,    0,    0,    0,  378,
			  377,  376,  375,  374,  373,  372,  371,  370,    0, 1037,
			    0,  367,  366,  365,  364,  363,  362,    0,    0,    0,
			    0,    0,    0,  367,  366,  365,  364,  363,  362, 1036,
			   71,   70,    0,   69,  347,    0,  638,  637,    0,   68,
			    0,    0,    0,    0,    0,   67,   66,   65,   64,   63,

			   62,   61,   60,   59,   58,   57,   56,   55,   54,   53,
			   52,   51,   50,   49,   48,   47,   46,   45,  383,    0,
			    0,    0,  687,  382,  381,  380,    0,  379,    0,    0,
			   44,   43,  383,    0, 1035,    0,    0,  382,  381,  380,
			    0,  379,    0,    0,   42,   41,    0,    0,    0,    0,
			    0,    0,    0,  378,  377,  376,  375,  374,  373,  372,
			  371,  370,    0,    0,    0,    0,    0,  378,  377,  376,
			  375,  374,  373,  372,  371,  370,    0,  367,  366,  365,
			  364,  363,  362,  767,    0,    0,  369,    0,    0,    0,
			    0,  367,  366,  365,  364,  363,  362,  383,    0,    0,

			    0,    0,  382,  381,  380,    0,  379,    0,    0,  383,
			    0,    0,    0,    0,  382,  381,  380,    0,  379,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,  378,  377,  376,  375,  374,  373,  372,  371,
			  370,    0,    0,    0,  378,  377,  376,  375,  374,  373,
			  372,  371,  370,    0,    0,    0,  367,  366,  365,  364,
			  363,  362,  623,  369,  865,    0,    0,    0,  367,  366,
			  365,  364,  363,  362,  383,    0,    0,    0,    0,  382,
			  381,  380,    0,  379,    0,   67,   66,   65,   64,   63,
			   62,   61,   60,   59,   58,   57,   56,   55,   54,   53,

			   52,   51,   50,   49,   48,   47,   46,    0,    0,  378,
			  377,  376,  375,  374,  373,  372,  371,  370,  383,    0,
			    0,   43,    0,  382,  381,  380,  836,  379,  369,    0,
			    0,    0,    0,  367,  366,  365,  364,  363,  362,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,  378,  377,  376,  375,  374,  373,  372,
			  371,  370,  383,    0,    0,    0,    0,  382,  381,  380,
			    0,  379,  369,  368,    0,    0,    0,  367,  366,  365,
			  364,  363,  362,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,  378,  377,  376, yyDummy>>,
			1, 1000, 4000)
		end

	yytable_template_6 (an_array: ARRAY [INTEGER]) is
			-- Fill chunk #6 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			  375,  374,  373,  372,  371,  370,  383,    0,    0,    0,
			    0,  382,  381,  380,  573,  379,    0,    0,    0,    0,
			    0,  367,  366,  365,  364,  363,  362,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,  378,  377,  376,  375,  374,  373,  372,  371,  370,
			  383,    0,    0,    0,    0,  382,  381,  380,    0,  383,
			    0,    0,    0,    0,  382,  367,  366,  365,  364,  363,
			  362,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,  378,  377,  376,  375,  374,
			  373,  372,  371,  370,  378,  377,  376,  375,  374,  373,

			  372,  371,  370,    0,    0,    0,    0,    0,    0,  367,
			  366,  365,  364,  363,  362,    0,    0,  -16,  367,  366,
			  365,  364,  363,  362,  -23,    0,    0,    0,    0,    0,
			    0,  -23,    0,    0,  -23,    0,    0,  -23,    0,    3,
			    0,    0,    0,  155,    0,    0,    0,    0,    2,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,  -23,  -23,    0,  -23,    0,
			  154,  804,  803,  802,  801,  800,  799,  798,  797,  796,
			  795,  794,  793,  792,  791,  790,  789,  788,  787,  786,
			  785,  784,  783,  521,  520,  519,  518,  517,  516,  515,

			  514,  513,  512,  511,  510,  509,  508,  507,  506,    0,
			    0,  505,  504,  503,  502,  501,  500,  499,  498,  497,
			  496,  495,  494,  493,  492,  491,  490,  489,  488,  487,
			  486,    0,    0,  485,  484,  483,  482, yyDummy>>,
			1, 237, 5000)
		end

	yycheck_template: SPECIAL [INTEGER] is
			-- Template for `yycheck'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 5236)
			yycheck_template_1 (an_array)
			yycheck_template_2 (an_array)
			yycheck_template_3 (an_array)
			yycheck_template_4 (an_array)
			yycheck_template_5 (an_array)
			yycheck_template_6 (an_array)
			Result := yyfixed_array (an_array)
		end

	yycheck_template_1 (an_array: ARRAY [INTEGER]) is
			-- Fill chunk #1 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			   17,  137,  523,   21,   21,   21,  536,  212,  301,  159,
			   21,    1,  715,  162,  181,  399,    9,  151,  121,  433,
			  174,  656,  358,  177,  172,   21,  545,  175,  399,  322,
			  782,  715,  186,  187,  188,  547,  181,  213,  104,  410,
			  392,  265,  394,  963,  964,   38,  651,   40,  653,  194,
			  603,  434,   14,  659, 1216, 1153,  461,  160,  441,  464,
			  857,   27,   80,   80,   80,  343,  416,  999,   14,   80,
			  122,   88,  124,  633,  479,  480, 1272,   94,  434,   97,
			   97,   97,   38,   72,   80,  441,   97,   72,   38,    0,
			  108,  108,  108,   89,   28,  112,  113,  108,  115,   62,

			   63,   97,   75,   72,   73,   74,  123,  124,  125,   22,
			  244,  245,  108,  131,  131,   49,   50,   51,   31,  136,
			  270,    4,  695,  189, 1222,   46,   47,  120,  121,  120,
			  103,   14,   75, 1329,   23,  201, 1068,   14,   72,   73,
			   74,  308,  309,   75,    0,  136,   35,  136,   28,   21,
			   14,  136,  904,   36,  123,   68,  173,   40,  124,  176,
			  103,   44,  307,  156,  181,  128,  269,   71,  124,  699,
			   47,  103,  130, 1335,  124,  137, 1372,  313,  195,  125,
			  977,  583,  199,   72,   73,   74,  821,  411,   11,   28,
			  934,  935,   72,   73,   74,  129,  213,  750,  130,  131,

			  136,  806,  426,  605,  138,  717,  590,  591,   80,  113,
			   33,  771,  818,  965,  172, 1147,   14,  175,  589,  215,
			   14,   28,  925,  289,  104,   97, 1023,   17,  294,   28,
			   14,  249,  249,   72,  123,   74,  108,  120,  941,   29,
			   14,  925,   72,   73,   74,  262,  263,  525,   11,   47,
			  528,  634,   36,  136,  637,  199,   40,  941,  434,  276,
			   14,   75,  612,  256,  614,   72,  616,   74,  417,  213,
			   33,  676,  677,   72,  267,   74,  481,   28,  634,   75,
			  430,  637,  348,   14,  302,  302,   39,   28,  256,  103,
			  248,  308,  309,  123,  572,  361,  254, 1229, 1050,  267,

			   28, 1053,  456,   14,  458,  323,  323,  455,  914,  457,
			  327,  465,  466,  467,  128,   14,  130,  131,   72,   73,
			   74,   72,  425,   74,  138,  730,   14,  732,  847, 1126,
			  735,   72,  128,   74,  130,  131,  896,  856, 1082,  125,
			  357,   40,   15,  301,   72,  151,   74,  752,  753,   17,
			   28,  137, 1272,   17, 1057, 1099,   72,   73,   74, 1103,
			   14,   29,  698,   14,  322,   29,  571,  384, 1120,   72,
			   73,   74,   75, 1057,  726,  181,  728,  713,   14,   72,
			   73,   74,  399,   70,   48,   72,   73,   74,  194,  934,
			  935,  774,  122, 1190,   72,  955,   74,  414,  910,  416,

			  960,  393,  419,  395,   28,  121,  936,  424,  474, 1329,
			  402,  403,  404,   80,  692, 1159,  433,  434,  774,  121,
			   28, 1124,  125,  125,  441,   62,   63,  130,  131,  122,
			   97,  124,  125,  120,  392,  393,  394,  395,  244,  245,
			 1124,  108,  963,  964,  402,  403,  404,  725,   72,  968,
			   74, 1248, 1372,    8,    9,  976,  522,   75,  634,   14,
			  972,   14,   15,   18,   72,   17,   74,   22,  121,  535,
			 1000,   26,   17,  878,  879, 1219,   31,   29,  544,  629,
			  258,  259,   23, 1186,   29,  103,   39, 1017,  693,  873,
			  874,    3,   75,  907,   35,  273,   48,  455,   53,  457,

			 1297,  307, 1186,  874,  671,  672,  609,   72,   73,   74,
			  128, 1308,  130,  131,  885,  532,  125,  126,   17,  536,
			  103,  538,  539,  540,  541,  628, 1270,  672,  137,   70,
			  547,   72,   73,   74,   23, 1054,  681, 1082,   20,  642,
			   14,   23,  123, 1246,  125,  128,   35,  130,  131,   48,
			   49, 1254,   51,   35, 1099,   12,  121,   14, 1103, 1356,
			 1133,   14, 1246,  104, 1094,  120,  584,  584,  952,  905,
			 1254,   22,  638,  590,  591,   12,   13,   14,   14,  120,
			   31,  122,   14,   72,   73,   74,  603,   59,  606,  606,
			   72,   73,   74,  399,  611,  612, 1340,  614,   14,  616,

			 1119, 1174, 1175, 1306,  410,   42, 1179, 1180, 1181,   17,
			   72,   73,   74,  747, 1159,   14,   12,  634,   14,  769,
			  637,   29, 1306,  124,  125,  583,   17, 1148,  645,  125,
			  835,  967,   14,  650,  651,  652,  653,  122,   29,  597,
			   48,  631,  104,  128,  129,  122,  712,  605,  133,  134,
			  135,   14,   71,  670,  671,  672,   17,   48,  120,  125,
			  126, 1182,  679,  830, 1183,  128,  151,  684,   29, 1188,
			  935,  137,   14,   15, 1219,  934,  935,   17,  781,  164,
			  165,  166,  699,  700,   72,   73,   74,  106,  107,   29,
			 1263, 1264, 1265,  112,  113,  114,  181,   39,   18,   14,

			  717,   70,   14,   72,   73,   74,  702,  125,   48,  194,
			   26,  130,  131,  126,  780, 1051,  104,   17,  714,  137,
			 1293, 1294, 1295,  136,   70, 1270,   72,   73,   74,   29,
			   46,   47, 1251,  750,   14,  727,  886,  729,  755,  756,
			  945,   72,   73,   74,  736,  737,  738,  897,   48,   69,
			   13,  120,   72,   73,   74,   75,   12,  774,   14,  244,
			  245,  246,  247,  125,  126,  250,  251,  252,  726,  727,
			  728,  729,  199,   14,  120,  137,  842,  126,  736,  737,
			  738,   14, 1118,  589,  128, 1121,  213,  136,  993,  806,
			   72,   73,   74,   75,  811, 1340,  116,    8,    9,  902,

			  120,   49,   50, 1008,   14,  822,  823,   18,   14,  143,
			  130,  131,  829,  830,  299,  300,  120, 1082,  122,  304,
			  305,  306,  307, 1082,   72,   73,   74,  893,  123,   14,
			  125,  848,  849,   18, 1099,  262,   71,   22, 1103,   14,
			 1099,   26,   14, 1136, 1103,   14,   31,  864,  130,  131,
			  123, 1187,  125,  125,  126,  872,  873,  874,  851,  852,
			  345,  964,   42,  966,  670,  137,  672,  122,   53,  124,
			   43,  106,  107,   14,  680,  681,   22,  112,  113,  114,
			   23,   27,  124,  125,  901,   31,  927,  928,  929,  930,
			  907,  957,   35,  910, 1159,   36,  126,  231,  128,   40,

			 1159,    8,    9,   44,   72,   73,   74,   75,   43,  243,
			  927,  928,  929,  930,  399,  981,   14,  934,  935,  936,
			  122, 1069,  124,   14,  990,  410,   14,   70,  924,   72,
			   73,   74,  125,  126,  951,  952,  932,  126, 1074,  128,
			  122,  747,  124,   38,  940,  963,  964,  963,  964, 1052,
			   14,  128,  963,  964, 1219,  972,   14,  125,   14,   14,
			 1219,  104,  130,  131, 1169,   14,   22,  963,  964, 1035,
			   26,  120,   36,  122,   46,   31,   40,  963,  964,  122,
			   44, 1135,  999, 1000,  121,   38, 1134,   40,  121, 1143,
			 1144, 1145,  419,  121,  538,  539,  540,  541,  963,  964, yyDummy>>,
			1, 1000, 0)
		end

	yycheck_template_2 (an_array: ARRAY [INTEGER]) is
			-- Fill chunk #2 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			 1017, 1018, 1138,  996,  128, 1270, 1211,   30,   31,  343,
			  938, 1270,  137,  197,  198,  943,  944, 1083,  202,  137,
			 1086,  137,  206,  357,  208, 1230, 1019,   14,  362,  363,
			  364,  365,  366,  367,  390,  391,  370,  371,  372,  373,
			  374,  375,  376,  377,  378,  379,  380,  381,  382,  383,
			   14, 1068, 1070, 1070,   18,   72,   73,   74,   22,   14,
			 1056, 1266,   26, 1268,   14, 1082,  872,   31,  874,   14,
			   14,   16,  755,  756, 1091, 1340,   32, 1094,  884,  885,
			 1097, 1340, 1099,  121,  128, 1102, 1103, 1080,   14,   53,
			  424,   36, 1085,  123,   72,   40,  581,  582,  129,   44,

			  121,  586,  587,  588,  589,  532,  128,  136,    8,    9,
			   14, 1069,   14,   14,   14,   14,   14, 1322,   18,   14,
			  547,  137,   22,    8,    9,  128,   26, 1123,  122,   14,
			 1147,   31, 1337,   18,   26, 1063, 1064,   22,   72,   73,
			   74,   26, 1159,   62, 1161,   62,   31,  120, 1165, 1166,
			 1104, 1105,   14,   53,   14, 1109, 1110, 1111,    0, 1152,
			 1153, 1157,  125,    8,    9,  164,  165,  166,   53,   14,
			  121, 1376,  125,   18,   40,   14, 1134,   22, 1136, 1107,
			 1108,   26,   55,  989,  126,  670,   31,  672, 1205, 1185,
			  126,  525,   36, 1210,  528,  680,  681,  164,  165,  166,

			   14,  126, 1219,   24,   25,   26,  126,  136,   53,    5,
			  126,  126, 1229,  126,   14,  136,  123,  125,  121,   14,
			 1213,  126,  128,  650,  651,  652,  653,  137,  125,  125,
			 1226,  125,  566,  126,  568,  120,  125,  125,  572,  121,
			  126,  128,  126, 1197, 1198, 1199,  137,  126,  126, 1245,
			 1267,  126,  126, 1270, 1272, 1272, 1272, 1253,  126, 1325,
			   44,  128,  747,   14,   14, 1282,  136, 1195, 1196,  854,
			  120, 1040,  125,  858,  859,  126,  125,    8,    9, 1048,
			 1049,  124,  123,   14, 1238, 1239, 1240,   18,  125,  121,
			  717,   22,  121,  121,    7,   26,  126, 1290,   11,  126,

			   31,   14,  128,  125,   17,  125,  125,   20,  126, 1305,
			  125, 1329, 1329, 1329,  121,  121,   29,   16,   14,   32,
			   33, 1338,   53, 1340,   14,   38,    3,   20,   14, 1257,
			 1258,   26,  125,  121,  126,   48,   49,  126,   51,    7,
			   14,    8,  123,   11,  123,  128,   14,  123,  933,   17,
			  121,  124,   20,  125, 1372, 1372, 1372,  942,  692,  121,
			  125,   29,  126,  697,   32,   33,  700,  124,   18,   14,
			   38,  120,  128,  128, 1302, 1303,  128,  122,  120,  806,
			   48,   49,  128,   51,  811,  128,   61,  872,    7,  874,
			  128,  725,   11,  978,  979,   14,  128,  126,   17,  884,

			  885,   20,  128,   75,   75,   28,  126,   14,   14,   53,
			   29,   58,   58,   32,   33,   14,  121,   16,   58,   38,
			  126, 1349, 1350,  136, 1193,    7,   49,   50,   51,   48,
			   49,    7,   51, 1361, 1362,    7,   11,   36,   37, 1024,
			 1025,   40,   17,   28,   24,   44,  125,   22,  124,   72,
			   73,   74,   27,    7,   29,  120,   31,   32,   33,   17,
			  124, 1389, 1390,   38,   49,   50,   51,  126,  136, 1217,
			 1055,  137, 1291,   48,  901,  622,  957, 1062,  717,  811,
			   76,  433, 1226,  910,  433,  525, 1255,   72,   73,   74,
			   28,  231,  278,  663,  121,   12,   13,   14,   15,  641,

			  834,  278,  115,  278,  989,  213,  129,  972,  275,   26,
			  844,   49,   50,   51,  848,  138,  121,  136,   28,  911,
			  452, 1106,   39, 1280,  121,   42,  157,  750,   28,   46,
			   47, 1300,  597,  964,   72,   73,   74, 1122,  419,   49,
			   50,   51, 1127, 1128,  129,  972, 1315, 1316, 1317,   49,
			   50,   51, 1292,  138, 1329, 1372,  903,  132,  429,  725,
			  844,  136,   72,   73,   74,  692,   -1,   -1,   -1,   -1,
			   -1,   -1,   72,   73,   74,   -1,   -1,   -1, 1347,   -1,
			   28,   -1, 1067, 1068,   -1,   -1, 1071, 1072, 1073,   -1,
			 1359,  129,   -1, 1078, 1363, 1364, 1365,   -1,   -1, 1184,

			  138,   49,   50,   51,   -1,   -1, 1191, 1192,   -1, 1194,
			   12,   -1,   14,   -1,   -1, 1384, 1385, 1386, 1387,  129,
			   -1,   -1,   -1,   -1,   72,   73,   74,   -1,  138,  129,
			   -1,   -1, 1401, 1402, 1403,   -1,   -1,   -1,  138,   -1,
			   -1,   -1, 1411, 1412, 1413,   -1,   -1,   -1, 1417, 1418,
			 1419,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1, 1244,
			  994,  995,   -1,   -1, 1249, 1250,   -1, 1252,   -1,   71,
			   -1, 1256,   -1,   -1,   76,   77,   78,   -1,   80,   -1,
			   -1,  129,   -1,   -1, 1018,   -1,   -1,   -1,   -1,   -1,
			  138,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,

			   -1,   -1,   -1,   -1,  106,  107,  108,  109,  110,  111,
			  112,  113,  114, 1298, 1299,   -1, 1301,   -1,   -1, 1304,
			   -1,   -1,   -1,   -1, 1309, 1310,   -1,   -1,  130,  131,
			  132,  133,  134,  135,   -1,   -1,   -1,   -1,   -1,    7,
			   -1,   -1,   -1,   11,   -1,   -1,   14,   -1,   -1,   17,
			   -1,   -1,   20,   -1,   -1,   -1,   -1, 1091, 1092, 1093,
			   -1,   29,   -1, 1348,   32,   33, 1100, 1101, 1102,   -1,
			   38,   -1, 1357, 1358,   -1, 1360,   -1,   -1,   -1,   -1,
			   48,   49,   -1,   51,   -1,    6,   -1,    8,   -1,   10,
			   11,   12,   13,   14,   15,   -1,   17,   18,   19,   -1,

			   21,   22,   -1, 1388,   25,   26,   -1,   -1,   29,   30,
			   31,   -1,   33,   34,   -1,   -1,   -1,   -1,   39,   -1,
			   41,   42,   43,   -1,   -1,   46,   47,   48,   -1,   -1,
			   -1, 1165, 1166, 1167,   -1,   56,   57,   -1,   -1,   60,
			   61,   -1,   -1,   -1,   65,   66,   67,   -1,   69,   70,
			   71,   72,   73,   74,   75,   76,   77,   78,   79,   80,
			   81,   82,   83,   84,   85,   86,   87,   88,   89,   90,
			   91,   92,   93,   94,   95,   96,   97,   98,   99,  100,
			  101,  102,  103,  104,  105,  106,  107,  108,  109,  110,
			  111,  112,  113,  114,  115,  116,  117,   -1,  119,  120,

			 1234,  122,  123,   -1,  125,  126,  127,   -1,  129,  130,
			  131,  132,  133,  134,  135,  136,  137,   -1,   -1,   -1,
			   -1,   -1,   -1,    6,   -1,    8,   -1,   10,   11,   12,
			   13,   14,   15,   -1,   17,   18,   19,   -1,   21,   22,
			   -1,   -1,   25,   26,   -1, 1279,   29,   30,   31,   -1,
			   33,   34,   -1,   -1,   -1, 1289,   39,   -1,   41,   42,
			   43,   -1,   -1,   46,   47,   48,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   56,   57,   -1,   -1,   60,   61,   -1,
			   -1,   -1,   65,   66,   67,   -1,   69,   70,   71,   72,
			   73,   74,   75,   76,   77,   78,   79,   80,   81,   82, yyDummy>>,
			1, 1000, 1000)
		end

	yycheck_template_3 (an_array: ARRAY [INTEGER]) is
			-- Fill chunk #3 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			   83,   84,   85,   86,   87,   88,   89,   90,   91,   92,
			   93,   94,   95,   96,   97,   98,   99,  100,  101,  102,
			  103,  104,  105,  106,  107,  108,  109,  110,  111,  112,
			  113,  114,  115,  116,  117,   -1,  119,  120,   -1,  122,
			  123,   -1,  125,  126,  127,   -1,  129,  130,  131,  132,
			  133,  134,  135,  136,  137,    6,   -1,    8,   -1,   10,
			   11,   12,   13,   14,   15,   -1,   17,   18,   19,   -1,
			   21,   22,   -1,   -1,   25,   26,   -1,   -1,   29,   30,
			   31,   -1,   33,   34,   -1,   -1,   -1,   -1,   39,   -1,
			   41,   42,   43,   -1,   -1,   46,   47,   48,   -1,   -1,

			   -1,   -1,   -1,   -1,   -1,   56,   57,   -1,   -1,   60,
			   61,   -1,   -1,   -1,   65,   66,   67,   -1,   69,   70,
			   71,   72,   73,   74,   75,   76,   77,   78,   79,   80,
			   81,   82,   83,   84,   85,   86,   87,   88,   89,   90,
			   91,   92,   93,   94,   95,   96,   97,   98,   99,  100,
			  101,  102,  103,  104,  105,  106,  107,  108,  109,  110,
			  111,  112,  113,  114,  115,  116,  117,   -1,  119,  120,
			   -1,  122,  123,   -1,  125,  126,  127,   -1,  129,  130,
			  131,  132,  133,  134,  135,  136,  137,    6,   -1,    8,
			   28,   10,   -1,   12,   13,   14,   15,   -1,   -1,   18,

			   19,   -1,   21,   -1,   -1,   -1,   25,   26,   -1,   -1,
			   -1,   49,   50,   51,   -1,   34,   -1,   -1,   -1,   -1,
			   39,   -1,   41,   42,   -1,   -1,   -1,   46,   47,   -1,
			   -1,   -1,   -1,   -1,   72,   73,   74,   56,   57,   -1,
			   -1,   60,   -1,   62,   -1,   -1,   65,   66,   67,   -1,
			   69,   70,   -1,   72,   73,   74,   75,   -1,   -1,   -1,
			   -1,   -1,   81,   82,   83,   84,   85,   86,   87,   88,
			   89,   90,   91,   92,   93,   94,   95,   96,   97,   98,
			   99,  100,  101,  102,  103,  104,  105,   -1,   -1,   -1,
			   -1,  129,   -1,   -1,   -1,   -1,  115,  116,  117,   -1,

			  138,  120,   -1,  122,   -1,   -1,   -1,    6,  127,    8,
			  129,   10,   -1,   12,   13,   14,   15,  136,  137,   18,
			   19,   -1,   21,   -1,   -1,   -1,   25,   26,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   34,   -1,   -1,   -1,   -1,
			   39,   -1,   41,   42,   -1,   -1,   -1,   46,   47,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   56,   57,   -1,
			   -1,   60,   -1,   -1,   -1,   -1,   65,   66,   67,   -1,
			   69,   70,   -1,   72,   73,   74,   75,   -1,   -1,   -1,
			   -1,   -1,   81,   82,   83,   84,   85,   86,   87,   88,
			   89,   90,   91,   92,   93,   94,   95,   96,   97,   98,

			   99,  100,  101,  102,  103,  104,  105,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,  115,  116,  117,   -1,
			   -1,  120,   -1,  122,   -1,   -1,   -1,   -1,  127,  128,
			  129,   -1,   -1,   -1,   -1,   -1,   -1,  136,  137,    6,
			   -1,    8,   -1,   10,   -1,   12,   13,   14,   15,   -1,
			   -1,   18,   19,   -1,   21,   -1,   -1,   -1,   25,   26,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   34,   -1,   -1,
			   -1,   -1,   39,   -1,   41,   42,   -1,   -1,   -1,   46,
			   47,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   56,
			   57,   -1,   -1,   60,   -1,   -1,   -1,   -1,   65,   66,

			   67,   -1,   69,   70,   -1,   72,   73,   74,   75,   -1,
			   -1,   -1,   -1,   -1,   81,   82,   83,   84,   85,   86,
			   87,   88,   89,   90,   91,   92,   93,   94,   95,   96,
			   97,   98,   99,  100,  101,  102,  103,  104,  105,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  115,  116,
			  117,   -1,   -1,  120,   -1,  122,   -1,   -1,   -1,    6,
			  127,    8,  129,   10,   -1,   12,   13,   14,   15,  136,
			  137,   18,   19,   -1,   21,   -1,   -1,   -1,   25,   26,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   34,   -1,   -1,
			   -1,   -1,   39,   -1,   41,   42,   -1,   -1,   -1,   46,

			   47,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   56,
			   57,   -1,   -1,   60,   -1,   -1,   -1,   -1,   65,   66,
			   67,   -1,   69,   70,   -1,   72,   73,   74,   75,   -1,
			   -1,   -1,   -1,   -1,   81,   82,   83,   84,   85,   86,
			   87,   88,   89,   90,   91,   92,   93,   94,   95,   96,
			   97,   98,   99,  100,  101,  102,  103,  104,  105,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  115,  116,
			  117,   -1,   -1,  120,   -1,  122,   -1,   -1,   -1,    6,
			  127,    8,  129,   10,   -1,   12,   13,   14,   15,  136,
			   -1,   18,   19,   -1,   21,   -1,   -1,   -1,   25,   26,

			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   34,   -1,   -1,
			   -1,   -1,   39,   -1,   41,   42,   -1,   -1,   -1,   46,
			   47,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   56,
			   57,   -1,   -1,   60,   -1,   -1,   -1,   -1,   65,   66,
			   67,   -1,   69,   70,   -1,   72,   73,   74,   75,   -1,
			   -1,   -1,   -1,   -1,   81,   82,   83,   84,   85,   86,
			   87,   88,   89,   90,   91,   92,   93,   94,   95,   96,
			   97,   98,   99,  100,  101,  102,  103,  104,  105,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  115,  116,
			  117,   -1,   -1,  120,   -1,  122,   -1,   -1,   -1,    6,

			  127,    8,  129,   10,   -1,   12,   13,   14,   15,  136,
			   -1,   18,   19,   -1,   21,   -1,   -1,   -1,   25,   26,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   34,   -1,   -1,
			   -1,   -1,   39,   -1,   41,   42,   -1,   -1,   -1,   46,
			   47,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   56,
			   57,   -1,   -1,   60,   -1,   -1,   -1,   -1,   65,   66,
			   67,   -1,   69,   70,   -1,   72,   73,   74,   75,   -1,
			   -1,   -1,   -1,   -1,   81,   82,   83,   84,   85,   86,
			   87,   88,   89,   90,   91,   92,   93,   94,   95,   96,
			   97,   98,   99,  100,  101,  102,  103,  104,  105,   -1,

			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  115,  116,
			  117,   -1,   -1,  120,   -1,  122,   -1,   -1,   -1,    6,
			  127,    8,  129,   10,   -1,   12,   13,   14,   15,  136,
			   -1,   18,   19,   -1,   21,   -1,   -1,   -1,   25,   26,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   34,   -1,   -1,
			   -1,   -1,   39,   -1,   41,   42,   -1,   -1,   -1,   46,
			   47,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   56,
			   57,   -1,   -1,   60,   -1,   -1,   -1,   -1,   65,   66,
			   67,   -1,   69,   70,   -1,   72,   73,   74,   75,   -1,
			   -1,   -1,   -1,   -1,   81,   82,   83,   84,   85,   86, yyDummy>>,
			1, 1000, 2000)
		end

	yycheck_template_4 (an_array: ARRAY [INTEGER]) is
			-- Fill chunk #4 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			   87,   88,   89,   90,   91,   92,   93,   94,   95,   96,
			   97,   98,   99,  100,  101,  102,  103,  104,  105,    6,
			   -1,    8,   -1,   10,   -1,   -1,   -1,   -1,  115,  116,
			  117,   18,   19,  120,   21,  122,   -1,   -1,   25,   -1,
			  127,   -1,  129,   -1,   -1,   -1,   -1,   34,   -1,  136,
			   -1,   -1,   -1,   -1,   41,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   56,
			   57,   -1,   -1,   60,   -1,   -1,   -1,   -1,   65,   66,
			   67,   -1,   69,   70,   -1,   72,   73,   74,   75,   -1,
			   -1,   -1,   -1,   -1,   81,   82,   83,   84,   85,   86,

			   87,   88,   89,   90,   91,   92,   93,   94,   95,   96,
			   97,   98,   99,  100,  101,  102,  103,  104,  105,   -1,
			   -1,    8,   -1,   -1,   -1,   -1,   -1,   -1,  115,  116,
			  117,   18,   -1,  120,   -1,  122,   -1,   -1,   -1,   -1,
			  127,   -1,  129,   -1,   -1,   -1,   -1,   34,   -1,  136,
			   -1,   -1,   -1,   -1,   41,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   56,
			   57,   -1,   -1,   60,   -1,   -1,   -1,   -1,   65,   66,
			   67,   -1,   69,   70,   71,   72,   73,   74,   75,   -1,
			   -1,   -1,   79,   -1,   81,   82,   83,   84,   85,   86,

			   87,   88,   89,   90,   91,   92,   93,   94,   95,   96,
			   97,   98,   99,  100,  101,  102,  103,  104,   -1,   -1,
			   -1,    8,   -1,   -1,   -1,   -1,   -1,   -1,  115,  116,
			  117,   18,  119,  120,   -1,  122,  123,   -1,   -1,   -1,
			  127,   -1,   -1,  130,  131,   -1,   -1,   34,   -1,   -1,
			  137,  138,   -1,   -1,   41,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   56,
			   57,   -1,   -1,   60,   -1,   -1,   -1,   -1,   65,   66,
			   67,   -1,   69,   70,   71,   72,   73,   74,   75,   -1,
			   -1,   -1,   79,   -1,   81,   82,   83,   84,   85,   86,

			   87,   88,   89,   90,   91,   92,   93,   94,   95,   96,
			   97,   98,   99,  100,  101,  102,  103,  104,   -1,   -1,
			   -1,    8,   -1,   -1,   -1,   -1,   -1,   14,  115,  116,
			  117,   18,  119,  120,   -1,  122,   -1,   -1,   -1,   -1,
			  127,   -1,   -1,  130,  131,   -1,   -1,   34,   -1,   -1,
			  137,  138,   -1,   -1,   41,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   56,
			   57,   -1,   -1,   60,   -1,   -1,   -1,   -1,   65,   66,
			   67,   -1,   69,   70,   71,   72,   73,   74,   75,   -1,
			   -1,   -1,   79,   -1,   81,   82,   83,   84,   85,   86,

			   87,   88,   89,   90,   91,   92,   93,   94,   95,   96,
			   97,   98,   99,  100,  101,  102,  103,  104,   -1,   -1,
			   -1,    8,   -1,   -1,   -1,   -1,   -1,   14,  115,  116,
			  117,   18,  119,  120,   -1,  122,   -1,   -1,   -1,   -1,
			  127,   -1,   -1,  130,  131,   -1,   -1,   34,   -1,   -1,
			  137,   -1,   -1,   -1,   41,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   56,
			   57,   -1,   -1,   60,   -1,   -1,   -1,   -1,   65,   66,
			   67,   -1,   69,   70,   71,   72,   73,   74,   75,   -1,
			   -1,   -1,   79,   -1,   81,   82,   83,   84,   85,   86,

			   87,   88,   89,   90,   91,   92,   93,   94,   95,   96,
			   97,   98,   99,  100,  101,  102,  103,  104,   -1,   -1,
			   -1,    8,   -1,   -1,   -1,   -1,   -1,   -1,  115,  116,
			  117,   18,  119,  120,   -1,  122,   -1,   -1,   -1,   -1,
			  127,   -1,   -1,  130,  131,   -1,   -1,   34,   -1,   -1,
			  137,   -1,   -1,   -1,   41,   -1,   43,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   56,
			   57,   -1,   -1,   60,   -1,   -1,   -1,   -1,   65,   66,
			   67,   -1,   69,   70,   71,   72,   73,   74,   75,   -1,
			   -1,   -1,   79,   -1,   81,   82,   83,   84,   85,   86,

			   87,   88,   89,   90,   91,   92,   93,   94,   95,   96,
			   97,   98,   99,  100,  101,  102,  103,  104,   -1,   -1,
			   -1,    8,   -1,   -1,   -1,   -1,   -1,   -1,  115,  116,
			  117,   18,  119,  120,   -1,  122,   -1,   -1,   -1,   -1,
			  127,   -1,   -1,  130,  131,   -1,   -1,   34,   -1,   -1,
			  137,   -1,   -1,   -1,   41,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   56,
			   57,   -1,   -1,   60,   -1,   -1,   -1,   -1,   65,   66,
			   67,   -1,   69,   70,   71,   72,   73,   74,   75,   -1,
			   -1,   -1,   79,   -1,   81,   82,   83,   84,   85,   86,

			   87,   88,   89,   90,   91,   92,   93,   94,   95,   96,
			   97,   98,   99,  100,  101,  102,  103,  104,   -1,   -1,
			   -1,    8,   -1,   -1,   -1,   -1,   -1,   -1,  115,  116,
			  117,   18,  119,  120,   -1,  122,   -1,   -1,   -1,  126,
			  127,   -1,   -1,  130,  131,   -1,   -1,   34,   -1,   -1,
			  137,   -1,   -1,   -1,   41,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   56,
			   57,   -1,   -1,   60,   -1,   -1,   -1,   -1,   65,   66,
			   67,   -1,   69,   70,   71,   72,   73,   74,   75,   -1,
			   -1,   -1,   79,   -1,   81,   82,   83,   84,   85,   86,

			   87,   88,   89,   90,   91,   92,   93,   94,   95,   96,
			   97,   98,   99,  100,  101,  102,  103,  104,   -1,   -1,
			   -1,    8,   -1,   -1,   -1,   12,   -1,   -1,  115,  116,
			  117,   18,  119,  120,   -1,  122,  123,   -1,   -1,   -1,
			  127,   -1,   -1,  130,  131,   -1,   -1,   34,   -1,   -1,
			  137,   -1,   -1,   -1,   41,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   56,
			   57,   -1,   -1,   60,   -1,   -1,   -1,   -1,   65,   66,
			   67,   -1,   69,   70,   71,   72,   73,   74,   75,   -1,
			   -1,   -1,   79,   -1,   81,   82,   83,   84,   85,   86,

			   87,   88,   89,   90,   91,   92,   93,   94,   95,   96,
			   97,   98,   99,  100,  101,  102,  103,  104,   -1,   -1,
			   -1,    8,   -1,   -1,   -1,   -1,   -1,   -1,  115,  116,
			  117,   18,  119,  120,   -1,  122,   -1,   -1,   -1,   -1,
			  127,   -1,   -1,  130,  131,   -1,   -1,   34,   -1,   -1,
			  137,   -1,   -1,   -1,   41,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   56,
			   57,   -1,   -1,   60,   61,   -1,   -1,   -1,   65,   66,
			   67,   -1,   69,   70,   71,   72,   73,   74,   75,   -1,
			   -1,   -1,   79,   -1,   81,   82,   83,   84,   85,   86, yyDummy>>,
			1, 1000, 3000)
		end

	yycheck_template_5 (an_array: ARRAY [INTEGER]) is
			-- Fill chunk #5 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			   87,   88,   89,   90,   91,   92,   93,   94,   95,   96,
			   97,   98,   99,  100,  101,  102,  103,  104,   -1,   -1,
			   -1,    8,   -1,   -1,   -1,   -1,   -1,   -1,  115,  116,
			  117,   18,  119,  120,   -1,  122,   -1,   -1,   -1,   -1,
			  127,   -1,   -1,  130,  131,   -1,   -1,   34,   -1,   -1,
			  137,   -1,   -1,   -1,   41,   -1,   43,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   56,
			   57,   -1,   -1,   60,   -1,   -1,   -1,   -1,   65,   66,
			   67,   -1,   69,   70,   71,   72,   73,   74,   75,   -1,
			   -1,   -1,   79,   -1,   81,   82,   83,   84,   85,   86,

			   87,   88,   89,   90,   91,   92,   93,   94,   95,   96,
			   97,   98,   99,  100,  101,  102,  103,  104,   -1,   -1,
			   -1,    8,   -1,   -1,   -1,   12,   -1,   -1,  115,  116,
			  117,   18,  119,  120,   -1,  122,   -1,   -1,   -1,   -1,
			  127,   -1,   -1,  130,  131,   -1,   -1,   34,   -1,   -1,
			  137,   -1,   -1,   -1,   41,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   56,
			   57,   -1,   -1,   60,   -1,   -1,   -1,   -1,   65,   66,
			   67,   -1,   69,   70,   71,   72,   73,   74,   75,   -1,
			   -1,   -1,   79,   -1,   81,   82,   83,   84,   85,   86,

			   87,   88,   89,   90,   91,   92,   93,   94,   95,   96,
			   97,   98,   99,  100,  101,  102,  103,  104,   -1,   -1,
			   -1,    8,   -1,   -1,   -1,   -1,   -1,   -1,  115,  116,
			  117,   18,  119,  120,   -1,  122,   -1,   -1,   -1,   -1,
			  127,   -1,   -1,  130,  131,   -1,   -1,   34,   -1,   -1,
			  137,   -1,   -1,   -1,   41,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   56,
			   57,   -1,   -1,   60,   -1,   -1,   -1,   -1,   65,   66,
			   67,   -1,   69,   70,   71,   72,   73,   74,   75,   -1,
			   -1,   -1,   79,   -1,   81,   82,   83,   84,   85,   86,

			   87,   88,   89,   90,   91,   92,   93,   94,   95,   96,
			   97,   98,   99,  100,  101,  102,  103,  104,   -1,   -1,
			   -1,    8,   -1,   -1,   -1,   -1,   -1,   -1,  115,  116,
			  117,   18,  119,  120,   -1,  122,   -1,   -1,   -1,  126,
			  127,   -1,   -1,  130,  131,   -1,   -1,   34,   -1,   -1,
			  137,   -1,   -1,   -1,   41,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   56,
			   57,   -1,   -1,   60,   -1,   -1,   -1,   -1,   65,   66,
			   67,   -1,   69,   70,   71,   72,   73,   74,   75,   -1,
			    8,   -1,   79,   -1,   81,   82,   83,   84,   85,   86,

			   87,   88,   89,   90,   91,   92,   93,   94,   95,   96,
			   97,   98,   99,  100,  101,  102,  103,  104,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  115,  116,
			  117,   -1,  119,  120,   -1,  122,   -1,   -1,   20,   -1,
			  127,   23,   -1,  130,  131,   27,   -1,   65,   66,   67,
			  137,   69,   -1,   35,   72,   73,   74,   75,   -1,   -1,
			   -1,   -1,   -1,   81,   82,   83,   84,   85,   86,   87,
			   88,   89,   90,   91,   92,   93,   94,   95,   96,   97,
			   98,   99,  100,  101,  102,  103,   22,   -1,   -1,   -1,
			   72,   73,   74,    7,   -1,   31,   -1,   11,  116,  117,

			   14,   -1,   -1,   17,   -1,   -1,   20,   -1,   -1,   45,
			   -1,   -1,  130,  131,   -1,   29,   -1,   -1,   32,   33,
			   -1,   -1,   -1,   -1,   38,   -1,   -1,   30,   -1,   65,
			   66,   67,   -1,   69,   48,   49,   -1,   51,   -1,   75,
			  122,   -1,  124,  125,   -1,   81,   82,   83,   84,   85,
			   86,   87,   88,   89,   90,   91,   92,   93,   94,   95,
			   96,   97,   98,   99,  100,  101,  102,  103,   71,   -1,
			   -1,   -1,   -1,   76,   77,   78,   -1,   80,   -1,   -1,
			  116,  117,   20,   -1,  120,   23,   43,   -1,   -1,   27,
			   -1,   -1,   -1,   -1,  130,  131,   -1,   35,   -1,   -1,

			   -1,   -1,   71,  106,  107,  108,  109,  110,  111,  112,
			  113,  114,   -1,   -1,   71,   -1,   -1,   -1,   -1,   76,
			   77,   78,   -1,   80,   -1,   -1,   -1,  130,  131,  132,
			  133,  134,  135,   -1,   72,   73,   74,  106,  107,  108,
			  109,  110,  111,  112,  113,  114,   -1,   -1,   -1,  106,
			  107,  108,  109,  110,  111,  112,  113,  114,   -1,   45,
			   -1,  130,  131,  132,  133,  134,  135,   -1,   -1,   -1,
			   -1,   -1,   -1,  130,  131,  132,  133,  134,  135,   65,
			   66,   67,   -1,   69,  122,   -1,  124,  125,   -1,   75,
			   -1,   -1,   -1,   -1,   -1,   81,   82,   83,   84,   85,

			   86,   87,   88,   89,   90,   91,   92,   93,   94,   95,
			   96,   97,   98,   99,  100,  101,  102,  103,   71,   -1,
			   -1,   -1,   61,   76,   77,   78,   -1,   80,   -1,   -1,
			  116,  117,   71,   -1,  120,   -1,   -1,   76,   77,   78,
			   -1,   80,   -1,   -1,  130,  131,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,  106,  107,  108,  109,  110,  111,  112,
			  113,  114,   -1,   -1,   -1,   -1,   -1,  106,  107,  108,
			  109,  110,  111,  112,  113,  114,   -1,  130,  131,  132,
			  133,  134,  135,  136,   -1,   -1,  125,   -1,   -1,   -1,
			   -1,  130,  131,  132,  133,  134,  135,   71,   -1,   -1,

			   -1,   -1,   76,   77,   78,   -1,   80,   -1,   -1,   71,
			   -1,   -1,   -1,   -1,   76,   77,   78,   -1,   80,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,  106,  107,  108,  109,  110,  111,  112,  113,
			  114,   -1,   -1,   -1,  106,  107,  108,  109,  110,  111,
			  112,  113,  114,   -1,   -1,   -1,  130,  131,  132,  133,
			  134,  135,  136,  125,  126,   -1,   -1,   -1,  130,  131,
			  132,  133,  134,  135,   71,   -1,   -1,   -1,   -1,   76,
			   77,   78,   -1,   80,   -1,   81,   82,   83,   84,   85,
			   86,   87,   88,   89,   90,   91,   92,   93,   94,   95,

			   96,   97,   98,   99,  100,  101,  102,   -1,   -1,  106,
			  107,  108,  109,  110,  111,  112,  113,  114,   71,   -1,
			   -1,  117,   -1,   76,   77,   78,  123,   80,  125,   -1,
			   -1,   -1,   -1,  130,  131,  132,  133,  134,  135,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,  106,  107,  108,  109,  110,  111,  112,
			  113,  114,   71,   -1,   -1,   -1,   -1,   76,   77,   78,
			   -1,   80,  125,  126,   -1,   -1,   -1,  130,  131,  132,
			  133,  134,  135,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,  106,  107,  108, yyDummy>>,
			1, 1000, 4000)
		end

	yycheck_template_6 (an_array: ARRAY [INTEGER]) is
			-- Fill chunk #6 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			  109,  110,  111,  112,  113,  114,   71,   -1,   -1,   -1,
			   -1,   76,   77,   78,  123,   80,   -1,   -1,   -1,   -1,
			   -1,  130,  131,  132,  133,  134,  135,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,  106,  107,  108,  109,  110,  111,  112,  113,  114,
			   71,   -1,   -1,   -1,   -1,   76,   77,   78,   -1,   71,
			   -1,   -1,   -1,   -1,   76,  130,  131,  132,  133,  134,
			  135,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,  106,  107,  108,  109,  110,
			  111,  112,  113,  114,  106,  107,  108,  109,  110,  111,

			  112,  113,  114,   -1,   -1,   -1,   -1,   -1,   -1,  130,
			  131,  132,  133,  134,  135,   -1,   -1,    0,  130,  131,
			  132,  133,  134,  135,    7,   -1,   -1,   -1,   -1,   -1,
			   -1,   14,   -1,   -1,   17,   -1,   -1,   20,   -1,   22,
			   -1,   -1,   -1,   26,   -1,   -1,   -1,   -1,   31,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   48,   49,   -1,   51,   -1,
			   53,   81,   82,   83,   84,   85,   86,   87,   88,   89,
			   90,   91,   92,   93,   94,   95,   96,   97,   98,   99,
			  100,  101,  102,   81,   82,   83,   84,   85,   86,   87,

			   88,   89,   90,   91,   92,   93,   94,   95,   96,   -1,
			   -1,   99,  100,  101,  102,   81,   82,   83,   84,   85,
			   86,   87,   88,   89,   90,   91,   92,   93,   94,   95,
			   96,   -1,   -1,   99,  100,  101,  102, yyDummy>>,
			1, 237, 5000)
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

	yyvs2: SPECIAL [ET_KEYWORD]
			-- Stack for semantic values of type ET_KEYWORD

	yyvsc2: INTEGER
			-- Capacity of semantic value stack `yyvs2'

	yyvsp2: INTEGER
			-- Top of semantic value stack `yyvs2'

	yyspecial_routines2: KL_SPECIAL_ROUTINES [ET_KEYWORD]
			-- Routines that ought to be in SPECIAL [ET_KEYWORD]

	yyvs3: SPECIAL [ET_AGENT_KEYWORD]
			-- Stack for semantic values of type ET_AGENT_KEYWORD

	yyvsc3: INTEGER
			-- Capacity of semantic value stack `yyvs3'

	yyvsp3: INTEGER
			-- Top of semantic value stack `yyvs3'

	yyspecial_routines3: KL_SPECIAL_ROUTINES [ET_AGENT_KEYWORD]
			-- Routines that ought to be in SPECIAL [ET_AGENT_KEYWORD]

	yyvs4: SPECIAL [ET_PRECURSOR_KEYWORD]
			-- Stack for semantic values of type ET_PRECURSOR_KEYWORD

	yyvsc4: INTEGER
			-- Capacity of semantic value stack `yyvs4'

	yyvsp4: INTEGER
			-- Top of semantic value stack `yyvs4'

	yyspecial_routines4: KL_SPECIAL_ROUTINES [ET_PRECURSOR_KEYWORD]
			-- Routines that ought to be in SPECIAL [ET_PRECURSOR_KEYWORD]

	yyvs5: SPECIAL [ET_SYMBOL]
			-- Stack for semantic values of type ET_SYMBOL

	yyvsc5: INTEGER
			-- Capacity of semantic value stack `yyvs5'

	yyvsp5: INTEGER
			-- Top of semantic value stack `yyvs5'

	yyspecial_routines5: KL_SPECIAL_ROUTINES [ET_SYMBOL]
			-- Routines that ought to be in SPECIAL [ET_SYMBOL]

	yyvs6: SPECIAL [ET_POSITION]
			-- Stack for semantic values of type ET_POSITION

	yyvsc6: INTEGER
			-- Capacity of semantic value stack `yyvs6'

	yyvsp6: INTEGER
			-- Top of semantic value stack `yyvs6'

	yyspecial_routines6: KL_SPECIAL_ROUTINES [ET_POSITION]
			-- Routines that ought to be in SPECIAL [ET_POSITION]

	yyvs7: SPECIAL [ET_BIT_CONSTANT]
			-- Stack for semantic values of type ET_BIT_CONSTANT

	yyvsc7: INTEGER
			-- Capacity of semantic value stack `yyvs7'

	yyvsp7: INTEGER
			-- Top of semantic value stack `yyvs7'

	yyspecial_routines7: KL_SPECIAL_ROUTINES [ET_BIT_CONSTANT]
			-- Routines that ought to be in SPECIAL [ET_BIT_CONSTANT]

	yyvs8: SPECIAL [ET_BOOLEAN_CONSTANT]
			-- Stack for semantic values of type ET_BOOLEAN_CONSTANT

	yyvsc8: INTEGER
			-- Capacity of semantic value stack `yyvs8'

	yyvsp8: INTEGER
			-- Top of semantic value stack `yyvs8'

	yyspecial_routines8: KL_SPECIAL_ROUTINES [ET_BOOLEAN_CONSTANT]
			-- Routines that ought to be in SPECIAL [ET_BOOLEAN_CONSTANT]

	yyvs9: SPECIAL [ET_BREAK]
			-- Stack for semantic values of type ET_BREAK

	yyvsc9: INTEGER
			-- Capacity of semantic value stack `yyvs9'

	yyvsp9: INTEGER
			-- Top of semantic value stack `yyvs9'

	yyspecial_routines9: KL_SPECIAL_ROUTINES [ET_BREAK]
			-- Routines that ought to be in SPECIAL [ET_BREAK]

	yyvs10: SPECIAL [ET_CHARACTER_CONSTANT]
			-- Stack for semantic values of type ET_CHARACTER_CONSTANT

	yyvsc10: INTEGER
			-- Capacity of semantic value stack `yyvs10'

	yyvsp10: INTEGER
			-- Top of semantic value stack `yyvs10'

	yyspecial_routines10: KL_SPECIAL_ROUTINES [ET_CHARACTER_CONSTANT]
			-- Routines that ought to be in SPECIAL [ET_CHARACTER_CONSTANT]

	yyvs11: SPECIAL [ET_CURRENT]
			-- Stack for semantic values of type ET_CURRENT

	yyvsc11: INTEGER
			-- Capacity of semantic value stack `yyvs11'

	yyvsp11: INTEGER
			-- Top of semantic value stack `yyvs11'

	yyspecial_routines11: KL_SPECIAL_ROUTINES [ET_CURRENT]
			-- Routines that ought to be in SPECIAL [ET_CURRENT]

	yyvs12: SPECIAL [ET_FREE_OPERATOR]
			-- Stack for semantic values of type ET_FREE_OPERATOR

	yyvsc12: INTEGER
			-- Capacity of semantic value stack `yyvs12'

	yyvsp12: INTEGER
			-- Top of semantic value stack `yyvs12'

	yyspecial_routines12: KL_SPECIAL_ROUTINES [ET_FREE_OPERATOR]
			-- Routines that ought to be in SPECIAL [ET_FREE_OPERATOR]

	yyvs13: SPECIAL [ET_IDENTIFIER]
			-- Stack for semantic values of type ET_IDENTIFIER

	yyvsc13: INTEGER
			-- Capacity of semantic value stack `yyvs13'

	yyvsp13: INTEGER
			-- Top of semantic value stack `yyvs13'

	yyspecial_routines13: KL_SPECIAL_ROUTINES [ET_IDENTIFIER]
			-- Routines that ought to be in SPECIAL [ET_IDENTIFIER]

	yyvs14: SPECIAL [ET_INTEGER_CONSTANT]
			-- Stack for semantic values of type ET_INTEGER_CONSTANT

	yyvsc14: INTEGER
			-- Capacity of semantic value stack `yyvs14'

	yyvsp14: INTEGER
			-- Top of semantic value stack `yyvs14'

	yyspecial_routines14: KL_SPECIAL_ROUTINES [ET_INTEGER_CONSTANT]
			-- Routines that ought to be in SPECIAL [ET_INTEGER_CONSTANT]

	yyvs15: SPECIAL [ET_KEYWORD_OPERATOR]
			-- Stack for semantic values of type ET_KEYWORD_OPERATOR

	yyvsc15: INTEGER
			-- Capacity of semantic value stack `yyvs15'

	yyvsp15: INTEGER
			-- Top of semantic value stack `yyvs15'

	yyspecial_routines15: KL_SPECIAL_ROUTINES [ET_KEYWORD_OPERATOR]
			-- Routines that ought to be in SPECIAL [ET_KEYWORD_OPERATOR]

	yyvs16: SPECIAL [ET_MANIFEST_STRING]
			-- Stack for semantic values of type ET_MANIFEST_STRING

	yyvsc16: INTEGER
			-- Capacity of semantic value stack `yyvs16'

	yyvsp16: INTEGER
			-- Top of semantic value stack `yyvs16'

	yyspecial_routines16: KL_SPECIAL_ROUTINES [ET_MANIFEST_STRING]
			-- Routines that ought to be in SPECIAL [ET_MANIFEST_STRING]

	yyvs17: SPECIAL [ET_REAL_CONSTANT]
			-- Stack for semantic values of type ET_REAL_CONSTANT

	yyvsc17: INTEGER
			-- Capacity of semantic value stack `yyvs17'

	yyvsp17: INTEGER
			-- Top of semantic value stack `yyvs17'

	yyspecial_routines17: KL_SPECIAL_ROUTINES [ET_REAL_CONSTANT]
			-- Routines that ought to be in SPECIAL [ET_REAL_CONSTANT]

	yyvs18: SPECIAL [ET_RESULT]
			-- Stack for semantic values of type ET_RESULT

	yyvsc18: INTEGER
			-- Capacity of semantic value stack `yyvs18'

	yyvsp18: INTEGER
			-- Top of semantic value stack `yyvs18'

	yyspecial_routines18: KL_SPECIAL_ROUTINES [ET_RESULT]
			-- Routines that ought to be in SPECIAL [ET_RESULT]

	yyvs19: SPECIAL [ET_RETRY_INSTRUCTION]
			-- Stack for semantic values of type ET_RETRY_INSTRUCTION

	yyvsc19: INTEGER
			-- Capacity of semantic value stack `yyvs19'

	yyvsp19: INTEGER
			-- Top of semantic value stack `yyvs19'

	yyspecial_routines19: KL_SPECIAL_ROUTINES [ET_RETRY_INSTRUCTION]
			-- Routines that ought to be in SPECIAL [ET_RETRY_INSTRUCTION]

	yyvs20: SPECIAL [ET_SYMBOL_OPERATOR]
			-- Stack for semantic values of type ET_SYMBOL_OPERATOR

	yyvsc20: INTEGER
			-- Capacity of semantic value stack `yyvs20'

	yyvsp20: INTEGER
			-- Top of semantic value stack `yyvs20'

	yyspecial_routines20: KL_SPECIAL_ROUTINES [ET_SYMBOL_OPERATOR]
			-- Routines that ought to be in SPECIAL [ET_SYMBOL_OPERATOR]

	yyvs21: SPECIAL [ET_VOID]
			-- Stack for semantic values of type ET_VOID

	yyvsc21: INTEGER
			-- Capacity of semantic value stack `yyvs21'

	yyvsp21: INTEGER
			-- Top of semantic value stack `yyvs21'

	yyspecial_routines21: KL_SPECIAL_ROUTINES [ET_VOID]
			-- Routines that ought to be in SPECIAL [ET_VOID]

	yyvs22: SPECIAL [ET_SEMICOLON_SYMBOL]
			-- Stack for semantic values of type ET_SEMICOLON_SYMBOL

	yyvsc22: INTEGER
			-- Capacity of semantic value stack `yyvs22'

	yyvsp22: INTEGER
			-- Top of semantic value stack `yyvs22'

	yyspecial_routines22: KL_SPECIAL_ROUTINES [ET_SEMICOLON_SYMBOL]
			-- Routines that ought to be in SPECIAL [ET_SEMICOLON_SYMBOL]

	yyvs23: SPECIAL [ET_BRACKET_SYMBOL]
			-- Stack for semantic values of type ET_BRACKET_SYMBOL

	yyvsc23: INTEGER
			-- Capacity of semantic value stack `yyvs23'

	yyvsp23: INTEGER
			-- Top of semantic value stack `yyvs23'

	yyspecial_routines23: KL_SPECIAL_ROUTINES [ET_BRACKET_SYMBOL]
			-- Routines that ought to be in SPECIAL [ET_BRACKET_SYMBOL]

	yyvs24: SPECIAL [ET_QUESTION_MARK_SYMBOL]
			-- Stack for semantic values of type ET_QUESTION_MARK_SYMBOL

	yyvsc24: INTEGER
			-- Capacity of semantic value stack `yyvs24'

	yyvsp24: INTEGER
			-- Top of semantic value stack `yyvs24'

	yyspecial_routines24: KL_SPECIAL_ROUTINES [ET_QUESTION_MARK_SYMBOL]
			-- Routines that ought to be in SPECIAL [ET_QUESTION_MARK_SYMBOL]

	yyvs25: SPECIAL [ET_ACTUAL_ARGUMENT_LIST]
			-- Stack for semantic values of type ET_ACTUAL_ARGUMENT_LIST

	yyvsc25: INTEGER
			-- Capacity of semantic value stack `yyvs25'

	yyvsp25: INTEGER
			-- Top of semantic value stack `yyvs25'

	yyspecial_routines25: KL_SPECIAL_ROUTINES [ET_ACTUAL_ARGUMENT_LIST]
			-- Routines that ought to be in SPECIAL [ET_ACTUAL_ARGUMENT_LIST]

	yyvs26: SPECIAL [ET_ACTUAL_PARAMETER_ITEM]
			-- Stack for semantic values of type ET_ACTUAL_PARAMETER_ITEM

	yyvsc26: INTEGER
			-- Capacity of semantic value stack `yyvs26'

	yyvsp26: INTEGER
			-- Top of semantic value stack `yyvs26'

	yyspecial_routines26: KL_SPECIAL_ROUTINES [ET_ACTUAL_PARAMETER_ITEM]
			-- Routines that ought to be in SPECIAL [ET_ACTUAL_PARAMETER_ITEM]

	yyvs27: SPECIAL [ET_ACTUAL_PARAMETER_LIST]
			-- Stack for semantic values of type ET_ACTUAL_PARAMETER_LIST

	yyvsc27: INTEGER
			-- Capacity of semantic value stack `yyvs27'

	yyvsp27: INTEGER
			-- Top of semantic value stack `yyvs27'

	yyspecial_routines27: KL_SPECIAL_ROUTINES [ET_ACTUAL_PARAMETER_LIST]
			-- Routines that ought to be in SPECIAL [ET_ACTUAL_PARAMETER_LIST]

	yyvs28: SPECIAL [ET_AGENT_ARGUMENT_OPERAND]
			-- Stack for semantic values of type ET_AGENT_ARGUMENT_OPERAND

	yyvsc28: INTEGER
			-- Capacity of semantic value stack `yyvs28'

	yyvsp28: INTEGER
			-- Top of semantic value stack `yyvs28'

	yyspecial_routines28: KL_SPECIAL_ROUTINES [ET_AGENT_ARGUMENT_OPERAND]
			-- Routines that ought to be in SPECIAL [ET_AGENT_ARGUMENT_OPERAND]

	yyvs29: SPECIAL [ET_AGENT_ARGUMENT_OPERAND_ITEM]
			-- Stack for semantic values of type ET_AGENT_ARGUMENT_OPERAND_ITEM

	yyvsc29: INTEGER
			-- Capacity of semantic value stack `yyvs29'

	yyvsp29: INTEGER
			-- Top of semantic value stack `yyvs29'

	yyspecial_routines29: KL_SPECIAL_ROUTINES [ET_AGENT_ARGUMENT_OPERAND_ITEM]
			-- Routines that ought to be in SPECIAL [ET_AGENT_ARGUMENT_OPERAND_ITEM]

	yyvs30: SPECIAL [ET_AGENT_ARGUMENT_OPERAND_LIST]
			-- Stack for semantic values of type ET_AGENT_ARGUMENT_OPERAND_LIST

	yyvsc30: INTEGER
			-- Capacity of semantic value stack `yyvs30'

	yyvsp30: INTEGER
			-- Top of semantic value stack `yyvs30'

	yyspecial_routines30: KL_SPECIAL_ROUTINES [ET_AGENT_ARGUMENT_OPERAND_LIST]
			-- Routines that ought to be in SPECIAL [ET_AGENT_ARGUMENT_OPERAND_LIST]

	yyvs31: SPECIAL [ET_AGENT_TARGET]
			-- Stack for semantic values of type ET_AGENT_TARGET

	yyvsc31: INTEGER
			-- Capacity of semantic value stack `yyvs31'

	yyvsp31: INTEGER
			-- Top of semantic value stack `yyvs31'

	yyspecial_routines31: KL_SPECIAL_ROUTINES [ET_AGENT_TARGET]
			-- Routines that ought to be in SPECIAL [ET_AGENT_TARGET]

	yyvs32: SPECIAL [ET_ALIAS_NAME]
			-- Stack for semantic values of type ET_ALIAS_NAME

	yyvsc32: INTEGER
			-- Capacity of semantic value stack `yyvs32'

	yyvsp32: INTEGER
			-- Top of semantic value stack `yyvs32'

	yyspecial_routines32: KL_SPECIAL_ROUTINES [ET_ALIAS_NAME]
			-- Routines that ought to be in SPECIAL [ET_ALIAS_NAME]

	yyvs33: SPECIAL [ET_ASSIGNER]
			-- Stack for semantic values of type ET_ASSIGNER

	yyvsc33: INTEGER
			-- Capacity of semantic value stack `yyvs33'

	yyvsp33: INTEGER
			-- Top of semantic value stack `yyvs33'

	yyspecial_routines33: KL_SPECIAL_ROUTINES [ET_ASSIGNER]
			-- Routines that ought to be in SPECIAL [ET_ASSIGNER]

	yyvs34: SPECIAL [ET_BRACKET_ARGUMENT_LIST]
			-- Stack for semantic values of type ET_BRACKET_ARGUMENT_LIST

	yyvsc34: INTEGER
			-- Capacity of semantic value stack `yyvs34'

	yyvsp34: INTEGER
			-- Top of semantic value stack `yyvs34'

	yyspecial_routines34: KL_SPECIAL_ROUTINES [ET_BRACKET_ARGUMENT_LIST]
			-- Routines that ought to be in SPECIAL [ET_BRACKET_ARGUMENT_LIST]

	yyvs35: SPECIAL [ET_BRACKET_EXPRESSION]
			-- Stack for semantic values of type ET_BRACKET_EXPRESSION

	yyvsc35: INTEGER
			-- Capacity of semantic value stack `yyvs35'

	yyvsp35: INTEGER
			-- Top of semantic value stack `yyvs35'

	yyspecial_routines35: KL_SPECIAL_ROUTINES [ET_BRACKET_EXPRESSION]
			-- Routines that ought to be in SPECIAL [ET_BRACKET_EXPRESSION]

	yyvs36: SPECIAL [ET_CALL_AGENT]
			-- Stack for semantic values of type ET_CALL_AGENT

	yyvsc36: INTEGER
			-- Capacity of semantic value stack `yyvs36'

	yyvsp36: INTEGER
			-- Top of semantic value stack `yyvs36'

	yyspecial_routines36: KL_SPECIAL_ROUTINES [ET_CALL_AGENT]
			-- Routines that ought to be in SPECIAL [ET_CALL_AGENT]

	yyvs37: SPECIAL [ET_CALL_EXPRESSION]
			-- Stack for semantic values of type ET_CALL_EXPRESSION

	yyvsc37: INTEGER
			-- Capacity of semantic value stack `yyvs37'

	yyvsp37: INTEGER
			-- Top of semantic value stack `yyvs37'

	yyspecial_routines37: KL_SPECIAL_ROUTINES [ET_CALL_EXPRESSION]
			-- Routines that ought to be in SPECIAL [ET_CALL_EXPRESSION]

	yyvs38: SPECIAL [ET_CHOICE]
			-- Stack for semantic values of type ET_CHOICE

	yyvsc38: INTEGER
			-- Capacity of semantic value stack `yyvs38'

	yyvsp38: INTEGER
			-- Top of semantic value stack `yyvs38'

	yyspecial_routines38: KL_SPECIAL_ROUTINES [ET_CHOICE]
			-- Routines that ought to be in SPECIAL [ET_CHOICE]

	yyvs39: SPECIAL [ET_CHOICE_CONSTANT]
			-- Stack for semantic values of type ET_CHOICE_CONSTANT

	yyvsc39: INTEGER
			-- Capacity of semantic value stack `yyvs39'

	yyvsp39: INTEGER
			-- Top of semantic value stack `yyvs39'

	yyspecial_routines39: KL_SPECIAL_ROUTINES [ET_CHOICE_CONSTANT]
			-- Routines that ought to be in SPECIAL [ET_CHOICE_CONSTANT]

	yyvs40: SPECIAL [ET_CHOICE_ITEM]
			-- Stack for semantic values of type ET_CHOICE_ITEM

	yyvsc40: INTEGER
			-- Capacity of semantic value stack `yyvs40'

	yyvsp40: INTEGER
			-- Top of semantic value stack `yyvs40'

	yyspecial_routines40: KL_SPECIAL_ROUTINES [ET_CHOICE_ITEM]
			-- Routines that ought to be in SPECIAL [ET_CHOICE_ITEM]

	yyvs41: SPECIAL [ET_CHOICE_LIST]
			-- Stack for semantic values of type ET_CHOICE_LIST

	yyvsc41: INTEGER
			-- Capacity of semantic value stack `yyvs41'

	yyvsp41: INTEGER
			-- Top of semantic value stack `yyvs41'

	yyspecial_routines41: KL_SPECIAL_ROUTINES [ET_CHOICE_LIST]
			-- Routines that ought to be in SPECIAL [ET_CHOICE_LIST]

	yyvs42: SPECIAL [ET_CLASS]
			-- Stack for semantic values of type ET_CLASS

	yyvsc42: INTEGER
			-- Capacity of semantic value stack `yyvs42'

	yyvsp42: INTEGER
			-- Top of semantic value stack `yyvs42'

	yyspecial_routines42: KL_SPECIAL_ROUTINES [ET_CLASS]
			-- Routines that ought to be in SPECIAL [ET_CLASS]

	yyvs43: SPECIAL [ET_CLIENT_ITEM]
			-- Stack for semantic values of type ET_CLIENT_ITEM

	yyvsc43: INTEGER
			-- Capacity of semantic value stack `yyvs43'

	yyvsp43: INTEGER
			-- Top of semantic value stack `yyvs43'

	yyspecial_routines43: KL_SPECIAL_ROUTINES [ET_CLIENT_ITEM]
			-- Routines that ought to be in SPECIAL [ET_CLIENT_ITEM]

	yyvs44: SPECIAL [ET_CLIENTS]
			-- Stack for semantic values of type ET_CLIENTS

	yyvsc44: INTEGER
			-- Capacity of semantic value stack `yyvs44'

	yyvsp44: INTEGER
			-- Top of semantic value stack `yyvs44'

	yyspecial_routines44: KL_SPECIAL_ROUTINES [ET_CLIENTS]
			-- Routines that ought to be in SPECIAL [ET_CLIENTS]

	yyvs45: SPECIAL [ET_COMPOUND]
			-- Stack for semantic values of type ET_COMPOUND

	yyvsc45: INTEGER
			-- Capacity of semantic value stack `yyvs45'

	yyvsp45: INTEGER
			-- Top of semantic value stack `yyvs45'

	yyspecial_routines45: KL_SPECIAL_ROUTINES [ET_COMPOUND]
			-- Routines that ought to be in SPECIAL [ET_COMPOUND]

	yyvs46: SPECIAL [ET_CONSTANT]
			-- Stack for semantic values of type ET_CONSTANT

	yyvsc46: INTEGER
			-- Capacity of semantic value stack `yyvs46'

	yyvsp46: INTEGER
			-- Top of semantic value stack `yyvs46'

	yyspecial_routines46: KL_SPECIAL_ROUTINES [ET_CONSTANT]
			-- Routines that ought to be in SPECIAL [ET_CONSTANT]

	yyvs47: SPECIAL [ET_CONSTRAINT_ACTUAL_PARAMETER_ITEM]
			-- Stack for semantic values of type ET_CONSTRAINT_ACTUAL_PARAMETER_ITEM

	yyvsc47: INTEGER
			-- Capacity of semantic value stack `yyvs47'

	yyvsp47: INTEGER
			-- Top of semantic value stack `yyvs47'

	yyspecial_routines47: KL_SPECIAL_ROUTINES [ET_CONSTRAINT_ACTUAL_PARAMETER_ITEM]
			-- Routines that ought to be in SPECIAL [ET_CONSTRAINT_ACTUAL_PARAMETER_ITEM]

	yyvs48: SPECIAL [ET_CONSTRAINT_ACTUAL_PARAMETER_LIST]
			-- Stack for semantic values of type ET_CONSTRAINT_ACTUAL_PARAMETER_LIST

	yyvsc48: INTEGER
			-- Capacity of semantic value stack `yyvs48'

	yyvsp48: INTEGER
			-- Top of semantic value stack `yyvs48'

	yyspecial_routines48: KL_SPECIAL_ROUTINES [ET_CONSTRAINT_ACTUAL_PARAMETER_LIST]
			-- Routines that ought to be in SPECIAL [ET_CONSTRAINT_ACTUAL_PARAMETER_LIST]

	yyvs49: SPECIAL [ET_CONSTRAINT_CREATOR]
			-- Stack for semantic values of type ET_CONSTRAINT_CREATOR

	yyvsc49: INTEGER
			-- Capacity of semantic value stack `yyvs49'

	yyvsp49: INTEGER
			-- Top of semantic value stack `yyvs49'

	yyspecial_routines49: KL_SPECIAL_ROUTINES [ET_CONSTRAINT_CREATOR]
			-- Routines that ought to be in SPECIAL [ET_CONSTRAINT_CREATOR]

	yyvs50: SPECIAL [ET_CONSTRAINT_TYPE]
			-- Stack for semantic values of type ET_CONSTRAINT_TYPE

	yyvsc50: INTEGER
			-- Capacity of semantic value stack `yyvs50'

	yyvsp50: INTEGER
			-- Top of semantic value stack `yyvs50'

	yyspecial_routines50: KL_SPECIAL_ROUTINES [ET_CONSTRAINT_TYPE]
			-- Routines that ought to be in SPECIAL [ET_CONSTRAINT_TYPE]

	yyvs51: SPECIAL [ET_CONVERT_FEATURE]
			-- Stack for semantic values of type ET_CONVERT_FEATURE

	yyvsc51: INTEGER
			-- Capacity of semantic value stack `yyvs51'

	yyvsp51: INTEGER
			-- Top of semantic value stack `yyvs51'

	yyspecial_routines51: KL_SPECIAL_ROUTINES [ET_CONVERT_FEATURE]
			-- Routines that ought to be in SPECIAL [ET_CONVERT_FEATURE]

	yyvs52: SPECIAL [ET_CONVERT_FEATURE_ITEM]
			-- Stack for semantic values of type ET_CONVERT_FEATURE_ITEM

	yyvsc52: INTEGER
			-- Capacity of semantic value stack `yyvs52'

	yyvsp52: INTEGER
			-- Top of semantic value stack `yyvs52'

	yyspecial_routines52: KL_SPECIAL_ROUTINES [ET_CONVERT_FEATURE_ITEM]
			-- Routines that ought to be in SPECIAL [ET_CONVERT_FEATURE_ITEM]

	yyvs53: SPECIAL [ET_CONVERT_FEATURE_LIST]
			-- Stack for semantic values of type ET_CONVERT_FEATURE_LIST

	yyvsc53: INTEGER
			-- Capacity of semantic value stack `yyvs53'

	yyvsp53: INTEGER
			-- Top of semantic value stack `yyvs53'

	yyspecial_routines53: KL_SPECIAL_ROUTINES [ET_CONVERT_FEATURE_LIST]
			-- Routines that ought to be in SPECIAL [ET_CONVERT_FEATURE_LIST]

	yyvs54: SPECIAL [ET_CREATE_EXPRESSION]
			-- Stack for semantic values of type ET_CREATE_EXPRESSION

	yyvsc54: INTEGER
			-- Capacity of semantic value stack `yyvs54'

	yyvsp54: INTEGER
			-- Top of semantic value stack `yyvs54'

	yyspecial_routines54: KL_SPECIAL_ROUTINES [ET_CREATE_EXPRESSION]
			-- Routines that ought to be in SPECIAL [ET_CREATE_EXPRESSION]

	yyvs55: SPECIAL [ET_CREATOR]
			-- Stack for semantic values of type ET_CREATOR

	yyvsc55: INTEGER
			-- Capacity of semantic value stack `yyvs55'

	yyvsp55: INTEGER
			-- Top of semantic value stack `yyvs55'

	yyspecial_routines55: KL_SPECIAL_ROUTINES [ET_CREATOR]
			-- Routines that ought to be in SPECIAL [ET_CREATOR]

	yyvs56: SPECIAL [ET_CREATOR_LIST]
			-- Stack for semantic values of type ET_CREATOR_LIST

	yyvsc56: INTEGER
			-- Capacity of semantic value stack `yyvs56'

	yyvsp56: INTEGER
			-- Top of semantic value stack `yyvs56'

	yyspecial_routines56: KL_SPECIAL_ROUTINES [ET_CREATOR_LIST]
			-- Routines that ought to be in SPECIAL [ET_CREATOR_LIST]

	yyvs57: SPECIAL [ET_DEBUG_INSTRUCTION]
			-- Stack for semantic values of type ET_DEBUG_INSTRUCTION

	yyvsc57: INTEGER
			-- Capacity of semantic value stack `yyvs57'

	yyvsp57: INTEGER
			-- Top of semantic value stack `yyvs57'

	yyspecial_routines57: KL_SPECIAL_ROUTINES [ET_DEBUG_INSTRUCTION]
			-- Routines that ought to be in SPECIAL [ET_DEBUG_INSTRUCTION]

	yyvs58: SPECIAL [ET_ELSEIF_PART]
			-- Stack for semantic values of type ET_ELSEIF_PART

	yyvsc58: INTEGER
			-- Capacity of semantic value stack `yyvs58'

	yyvsp58: INTEGER
			-- Top of semantic value stack `yyvs58'

	yyspecial_routines58: KL_SPECIAL_ROUTINES [ET_ELSEIF_PART]
			-- Routines that ought to be in SPECIAL [ET_ELSEIF_PART]

	yyvs59: SPECIAL [ET_ELSEIF_PART_LIST]
			-- Stack for semantic values of type ET_ELSEIF_PART_LIST

	yyvsc59: INTEGER
			-- Capacity of semantic value stack `yyvs59'

	yyvsp59: INTEGER
			-- Top of semantic value stack `yyvs59'

	yyspecial_routines59: KL_SPECIAL_ROUTINES [ET_ELSEIF_PART_LIST]
			-- Routines that ought to be in SPECIAL [ET_ELSEIF_PART_LIST]

	yyvs60: SPECIAL [ET_EXPORT]
			-- Stack for semantic values of type ET_EXPORT

	yyvsc60: INTEGER
			-- Capacity of semantic value stack `yyvs60'

	yyvsp60: INTEGER
			-- Top of semantic value stack `yyvs60'

	yyspecial_routines60: KL_SPECIAL_ROUTINES [ET_EXPORT]
			-- Routines that ought to be in SPECIAL [ET_EXPORT]

	yyvs61: SPECIAL [ET_EXPORT_LIST]
			-- Stack for semantic values of type ET_EXPORT_LIST

	yyvsc61: INTEGER
			-- Capacity of semantic value stack `yyvs61'

	yyvsp61: INTEGER
			-- Top of semantic value stack `yyvs61'

	yyspecial_routines61: KL_SPECIAL_ROUTINES [ET_EXPORT_LIST]
			-- Routines that ought to be in SPECIAL [ET_EXPORT_LIST]

	yyvs62: SPECIAL [ET_EXPRESSION]
			-- Stack for semantic values of type ET_EXPRESSION

	yyvsc62: INTEGER
			-- Capacity of semantic value stack `yyvs62'

	yyvsp62: INTEGER
			-- Top of semantic value stack `yyvs62'

	yyspecial_routines62: KL_SPECIAL_ROUTINES [ET_EXPRESSION]
			-- Routines that ought to be in SPECIAL [ET_EXPRESSION]

	yyvs63: SPECIAL [ET_EXPRESSION_ITEM]
			-- Stack for semantic values of type ET_EXPRESSION_ITEM

	yyvsc63: INTEGER
			-- Capacity of semantic value stack `yyvs63'

	yyvsp63: INTEGER
			-- Top of semantic value stack `yyvs63'

	yyspecial_routines63: KL_SPECIAL_ROUTINES [ET_EXPRESSION_ITEM]
			-- Routines that ought to be in SPECIAL [ET_EXPRESSION_ITEM]

	yyvs64: SPECIAL [ET_EXTENDED_FEATURE_NAME]
			-- Stack for semantic values of type ET_EXTENDED_FEATURE_NAME

	yyvsc64: INTEGER
			-- Capacity of semantic value stack `yyvs64'

	yyvsp64: INTEGER
			-- Top of semantic value stack `yyvs64'

	yyspecial_routines64: KL_SPECIAL_ROUTINES [ET_EXTENDED_FEATURE_NAME]
			-- Routines that ought to be in SPECIAL [ET_EXTENDED_FEATURE_NAME]

	yyvs65: SPECIAL [ET_EXTERNAL_ALIAS]
			-- Stack for semantic values of type ET_EXTERNAL_ALIAS

	yyvsc65: INTEGER
			-- Capacity of semantic value stack `yyvs65'

	yyvsp65: INTEGER
			-- Top of semantic value stack `yyvs65'

	yyspecial_routines65: KL_SPECIAL_ROUTINES [ET_EXTERNAL_ALIAS]
			-- Routines that ought to be in SPECIAL [ET_EXTERNAL_ALIAS]

	yyvs66: SPECIAL [ET_FEATURE_CLAUSE]
			-- Stack for semantic values of type ET_FEATURE_CLAUSE

	yyvsc66: INTEGER
			-- Capacity of semantic value stack `yyvs66'

	yyvsp66: INTEGER
			-- Top of semantic value stack `yyvs66'

	yyspecial_routines66: KL_SPECIAL_ROUTINES [ET_FEATURE_CLAUSE]
			-- Routines that ought to be in SPECIAL [ET_FEATURE_CLAUSE]

	yyvs67: SPECIAL [ET_FEATURE_CLAUSE_LIST]
			-- Stack for semantic values of type ET_FEATURE_CLAUSE_LIST

	yyvsc67: INTEGER
			-- Capacity of semantic value stack `yyvs67'

	yyvsp67: INTEGER
			-- Top of semantic value stack `yyvs67'

	yyspecial_routines67: KL_SPECIAL_ROUTINES [ET_FEATURE_CLAUSE_LIST]
			-- Routines that ought to be in SPECIAL [ET_FEATURE_CLAUSE_LIST]

	yyvs68: SPECIAL [ET_FEATURE_EXPORT]
			-- Stack for semantic values of type ET_FEATURE_EXPORT

	yyvsc68: INTEGER
			-- Capacity of semantic value stack `yyvs68'

	yyvsp68: INTEGER
			-- Top of semantic value stack `yyvs68'

	yyspecial_routines68: KL_SPECIAL_ROUTINES [ET_FEATURE_EXPORT]
			-- Routines that ought to be in SPECIAL [ET_FEATURE_EXPORT]

	yyvs69: SPECIAL [ET_FEATURE_NAME]
			-- Stack for semantic values of type ET_FEATURE_NAME

	yyvsc69: INTEGER
			-- Capacity of semantic value stack `yyvs69'

	yyvsp69: INTEGER
			-- Top of semantic value stack `yyvs69'

	yyspecial_routines69: KL_SPECIAL_ROUTINES [ET_FEATURE_NAME]
			-- Routines that ought to be in SPECIAL [ET_FEATURE_NAME]

	yyvs70: SPECIAL [ET_FEATURE_NAME_ITEM]
			-- Stack for semantic values of type ET_FEATURE_NAME_ITEM

	yyvsc70: INTEGER
			-- Capacity of semantic value stack `yyvs70'

	yyvsp70: INTEGER
			-- Top of semantic value stack `yyvs70'

	yyspecial_routines70: KL_SPECIAL_ROUTINES [ET_FEATURE_NAME_ITEM]
			-- Routines that ought to be in SPECIAL [ET_FEATURE_NAME_ITEM]

	yyvs71: SPECIAL [ET_FORMAL_ARGUMENT]
			-- Stack for semantic values of type ET_FORMAL_ARGUMENT

	yyvsc71: INTEGER
			-- Capacity of semantic value stack `yyvs71'

	yyvsp71: INTEGER
			-- Top of semantic value stack `yyvs71'

	yyspecial_routines71: KL_SPECIAL_ROUTINES [ET_FORMAL_ARGUMENT]
			-- Routines that ought to be in SPECIAL [ET_FORMAL_ARGUMENT]

	yyvs72: SPECIAL [ET_FORMAL_ARGUMENT_ITEM]
			-- Stack for semantic values of type ET_FORMAL_ARGUMENT_ITEM

	yyvsc72: INTEGER
			-- Capacity of semantic value stack `yyvs72'

	yyvsp72: INTEGER
			-- Top of semantic value stack `yyvs72'

	yyspecial_routines72: KL_SPECIAL_ROUTINES [ET_FORMAL_ARGUMENT_ITEM]
			-- Routines that ought to be in SPECIAL [ET_FORMAL_ARGUMENT_ITEM]

	yyvs73: SPECIAL [ET_FORMAL_ARGUMENT_LIST]
			-- Stack for semantic values of type ET_FORMAL_ARGUMENT_LIST

	yyvsc73: INTEGER
			-- Capacity of semantic value stack `yyvs73'

	yyvsp73: INTEGER
			-- Top of semantic value stack `yyvs73'

	yyspecial_routines73: KL_SPECIAL_ROUTINES [ET_FORMAL_ARGUMENT_LIST]
			-- Routines that ought to be in SPECIAL [ET_FORMAL_ARGUMENT_LIST]

	yyvs74: SPECIAL [ET_FORMAL_PARAMETER]
			-- Stack for semantic values of type ET_FORMAL_PARAMETER

	yyvsc74: INTEGER
			-- Capacity of semantic value stack `yyvs74'

	yyvsp74: INTEGER
			-- Top of semantic value stack `yyvs74'

	yyspecial_routines74: KL_SPECIAL_ROUTINES [ET_FORMAL_PARAMETER]
			-- Routines that ought to be in SPECIAL [ET_FORMAL_PARAMETER]

	yyvs75: SPECIAL [ET_FORMAL_PARAMETER_ITEM]
			-- Stack for semantic values of type ET_FORMAL_PARAMETER_ITEM

	yyvsc75: INTEGER
			-- Capacity of semantic value stack `yyvs75'

	yyvsp75: INTEGER
			-- Top of semantic value stack `yyvs75'

	yyspecial_routines75: KL_SPECIAL_ROUTINES [ET_FORMAL_PARAMETER_ITEM]
			-- Routines that ought to be in SPECIAL [ET_FORMAL_PARAMETER_ITEM]

	yyvs76: SPECIAL [ET_FORMAL_PARAMETER_LIST]
			-- Stack for semantic values of type ET_FORMAL_PARAMETER_LIST

	yyvsc76: INTEGER
			-- Capacity of semantic value stack `yyvs76'

	yyvsp76: INTEGER
			-- Top of semantic value stack `yyvs76'

	yyspecial_routines76: KL_SPECIAL_ROUTINES [ET_FORMAL_PARAMETER_LIST]
			-- Routines that ought to be in SPECIAL [ET_FORMAL_PARAMETER_LIST]

	yyvs77: SPECIAL [ET_IF_INSTRUCTION]
			-- Stack for semantic values of type ET_IF_INSTRUCTION

	yyvsc77: INTEGER
			-- Capacity of semantic value stack `yyvs77'

	yyvsp77: INTEGER
			-- Top of semantic value stack `yyvs77'

	yyspecial_routines77: KL_SPECIAL_ROUTINES [ET_IF_INSTRUCTION]
			-- Routines that ought to be in SPECIAL [ET_IF_INSTRUCTION]

	yyvs78: SPECIAL [ET_INDEXING_LIST]
			-- Stack for semantic values of type ET_INDEXING_LIST

	yyvsc78: INTEGER
			-- Capacity of semantic value stack `yyvs78'

	yyvsp78: INTEGER
			-- Top of semantic value stack `yyvs78'

	yyspecial_routines78: KL_SPECIAL_ROUTINES [ET_INDEXING_LIST]
			-- Routines that ought to be in SPECIAL [ET_INDEXING_LIST]

	yyvs79: SPECIAL [ET_INDEXING_ITEM]
			-- Stack for semantic values of type ET_INDEXING_ITEM

	yyvsc79: INTEGER
			-- Capacity of semantic value stack `yyvs79'

	yyvsp79: INTEGER
			-- Top of semantic value stack `yyvs79'

	yyspecial_routines79: KL_SPECIAL_ROUTINES [ET_INDEXING_ITEM]
			-- Routines that ought to be in SPECIAL [ET_INDEXING_ITEM]

	yyvs80: SPECIAL [ET_INDEXING_TERM]
			-- Stack for semantic values of type ET_INDEXING_TERM

	yyvsc80: INTEGER
			-- Capacity of semantic value stack `yyvs80'

	yyvsp80: INTEGER
			-- Top of semantic value stack `yyvs80'

	yyspecial_routines80: KL_SPECIAL_ROUTINES [ET_INDEXING_TERM]
			-- Routines that ought to be in SPECIAL [ET_INDEXING_TERM]

	yyvs81: SPECIAL [ET_INDEXING_TERM_ITEM]
			-- Stack for semantic values of type ET_INDEXING_TERM_ITEM

	yyvsc81: INTEGER
			-- Capacity of semantic value stack `yyvs81'

	yyvsp81: INTEGER
			-- Top of semantic value stack `yyvs81'

	yyspecial_routines81: KL_SPECIAL_ROUTINES [ET_INDEXING_TERM_ITEM]
			-- Routines that ought to be in SPECIAL [ET_INDEXING_TERM_ITEM]

	yyvs82: SPECIAL [ET_INDEXING_TERM_LIST]
			-- Stack for semantic values of type ET_INDEXING_TERM_LIST

	yyvsc82: INTEGER
			-- Capacity of semantic value stack `yyvs82'

	yyvsp82: INTEGER
			-- Top of semantic value stack `yyvs82'

	yyspecial_routines82: KL_SPECIAL_ROUTINES [ET_INDEXING_TERM_LIST]
			-- Routines that ought to be in SPECIAL [ET_INDEXING_TERM_LIST]

	yyvs83: SPECIAL [ET_INLINE_AGENT]
			-- Stack for semantic values of type ET_INLINE_AGENT

	yyvsc83: INTEGER
			-- Capacity of semantic value stack `yyvs83'

	yyvsp83: INTEGER
			-- Top of semantic value stack `yyvs83'

	yyspecial_routines83: KL_SPECIAL_ROUTINES [ET_INLINE_AGENT]
			-- Routines that ought to be in SPECIAL [ET_INLINE_AGENT]

	yyvs84: SPECIAL [ET_INSPECT_INSTRUCTION]
			-- Stack for semantic values of type ET_INSPECT_INSTRUCTION

	yyvsc84: INTEGER
			-- Capacity of semantic value stack `yyvs84'

	yyvsp84: INTEGER
			-- Top of semantic value stack `yyvs84'

	yyspecial_routines84: KL_SPECIAL_ROUTINES [ET_INSPECT_INSTRUCTION]
			-- Routines that ought to be in SPECIAL [ET_INSPECT_INSTRUCTION]

	yyvs85: SPECIAL [ET_INSTRUCTION]
			-- Stack for semantic values of type ET_INSTRUCTION

	yyvsc85: INTEGER
			-- Capacity of semantic value stack `yyvs85'

	yyvsp85: INTEGER
			-- Top of semantic value stack `yyvs85'

	yyspecial_routines85: KL_SPECIAL_ROUTINES [ET_INSTRUCTION]
			-- Routines that ought to be in SPECIAL [ET_INSTRUCTION]

	yyvs86: SPECIAL [ET_INVARIANTS]
			-- Stack for semantic values of type ET_INVARIANTS

	yyvsc86: INTEGER
			-- Capacity of semantic value stack `yyvs86'

	yyvsp86: INTEGER
			-- Top of semantic value stack `yyvs86'

	yyspecial_routines86: KL_SPECIAL_ROUTINES [ET_INVARIANTS]
			-- Routines that ought to be in SPECIAL [ET_INVARIANTS]

	yyvs87: SPECIAL [ET_KEYWORD_FEATURE_NAME_LIST]
			-- Stack for semantic values of type ET_KEYWORD_FEATURE_NAME_LIST

	yyvsc87: INTEGER
			-- Capacity of semantic value stack `yyvs87'

	yyvsp87: INTEGER
			-- Top of semantic value stack `yyvs87'

	yyspecial_routines87: KL_SPECIAL_ROUTINES [ET_KEYWORD_FEATURE_NAME_LIST]
			-- Routines that ought to be in SPECIAL [ET_KEYWORD_FEATURE_NAME_LIST]

	yyvs88: SPECIAL [ET_LIKE_TYPE]
			-- Stack for semantic values of type ET_LIKE_TYPE

	yyvsc88: INTEGER
			-- Capacity of semantic value stack `yyvs88'

	yyvsp88: INTEGER
			-- Top of semantic value stack `yyvs88'

	yyspecial_routines88: KL_SPECIAL_ROUTINES [ET_LIKE_TYPE]
			-- Routines that ought to be in SPECIAL [ET_LIKE_TYPE]

	yyvs89: SPECIAL [ET_LOCAL_VARIABLE]
			-- Stack for semantic values of type ET_LOCAL_VARIABLE

	yyvsc89: INTEGER
			-- Capacity of semantic value stack `yyvs89'

	yyvsp89: INTEGER
			-- Top of semantic value stack `yyvs89'

	yyspecial_routines89: KL_SPECIAL_ROUTINES [ET_LOCAL_VARIABLE]
			-- Routines that ought to be in SPECIAL [ET_LOCAL_VARIABLE]

	yyvs90: SPECIAL [ET_LOCAL_VARIABLE_ITEM]
			-- Stack for semantic values of type ET_LOCAL_VARIABLE_ITEM

	yyvsc90: INTEGER
			-- Capacity of semantic value stack `yyvs90'

	yyvsp90: INTEGER
			-- Top of semantic value stack `yyvs90'

	yyspecial_routines90: KL_SPECIAL_ROUTINES [ET_LOCAL_VARIABLE_ITEM]
			-- Routines that ought to be in SPECIAL [ET_LOCAL_VARIABLE_ITEM]

	yyvs91: SPECIAL [ET_LOCAL_VARIABLE_LIST]
			-- Stack for semantic values of type ET_LOCAL_VARIABLE_LIST

	yyvsc91: INTEGER
			-- Capacity of semantic value stack `yyvs91'

	yyvsp91: INTEGER
			-- Top of semantic value stack `yyvs91'

	yyspecial_routines91: KL_SPECIAL_ROUTINES [ET_LOCAL_VARIABLE_LIST]
			-- Routines that ought to be in SPECIAL [ET_LOCAL_VARIABLE_LIST]

	yyvs92: SPECIAL [ET_LOOP_INVARIANTS]
			-- Stack for semantic values of type ET_LOOP_INVARIANTS

	yyvsc92: INTEGER
			-- Capacity of semantic value stack `yyvs92'

	yyvsp92: INTEGER
			-- Top of semantic value stack `yyvs92'

	yyspecial_routines92: KL_SPECIAL_ROUTINES [ET_LOOP_INVARIANTS]
			-- Routines that ought to be in SPECIAL [ET_LOOP_INVARIANTS]

	yyvs93: SPECIAL [ET_MANIFEST_ARRAY]
			-- Stack for semantic values of type ET_MANIFEST_ARRAY

	yyvsc93: INTEGER
			-- Capacity of semantic value stack `yyvs93'

	yyvsp93: INTEGER
			-- Top of semantic value stack `yyvs93'

	yyspecial_routines93: KL_SPECIAL_ROUTINES [ET_MANIFEST_ARRAY]
			-- Routines that ought to be in SPECIAL [ET_MANIFEST_ARRAY]

	yyvs94: SPECIAL [ET_MANIFEST_STRING_ITEM]
			-- Stack for semantic values of type ET_MANIFEST_STRING_ITEM

	yyvsc94: INTEGER
			-- Capacity of semantic value stack `yyvs94'

	yyvsp94: INTEGER
			-- Top of semantic value stack `yyvs94'

	yyspecial_routines94: KL_SPECIAL_ROUTINES [ET_MANIFEST_STRING_ITEM]
			-- Routines that ought to be in SPECIAL [ET_MANIFEST_STRING_ITEM]

	yyvs95: SPECIAL [ET_MANIFEST_STRING_LIST]
			-- Stack for semantic values of type ET_MANIFEST_STRING_LIST

	yyvsc95: INTEGER
			-- Capacity of semantic value stack `yyvs95'

	yyvsp95: INTEGER
			-- Top of semantic value stack `yyvs95'

	yyspecial_routines95: KL_SPECIAL_ROUTINES [ET_MANIFEST_STRING_LIST]
			-- Routines that ought to be in SPECIAL [ET_MANIFEST_STRING_LIST]

	yyvs96: SPECIAL [ET_MANIFEST_TUPLE]
			-- Stack for semantic values of type ET_MANIFEST_TUPLE

	yyvsc96: INTEGER
			-- Capacity of semantic value stack `yyvs96'

	yyvsp96: INTEGER
			-- Top of semantic value stack `yyvs96'

	yyspecial_routines96: KL_SPECIAL_ROUTINES [ET_MANIFEST_TUPLE]
			-- Routines that ought to be in SPECIAL [ET_MANIFEST_TUPLE]

	yyvs97: SPECIAL [ET_OBJECT_TEST_LIST]
			-- Stack for semantic values of type ET_OBJECT_TEST_LIST

	yyvsc97: INTEGER
			-- Capacity of semantic value stack `yyvs97'

	yyvsp97: INTEGER
			-- Top of semantic value stack `yyvs97'

	yyspecial_routines97: KL_SPECIAL_ROUTINES [ET_OBJECT_TEST_LIST]
			-- Routines that ought to be in SPECIAL [ET_OBJECT_TEST_LIST]

	yyvs98: SPECIAL [ET_OBSOLETE]
			-- Stack for semantic values of type ET_OBSOLETE

	yyvsc98: INTEGER
			-- Capacity of semantic value stack `yyvs98'

	yyvsp98: INTEGER
			-- Top of semantic value stack `yyvs98'

	yyspecial_routines98: KL_SPECIAL_ROUTINES [ET_OBSOLETE]
			-- Routines that ought to be in SPECIAL [ET_OBSOLETE]

	yyvs99: SPECIAL [ET_PARENTHESIZED_EXPRESSION]
			-- Stack for semantic values of type ET_PARENTHESIZED_EXPRESSION

	yyvsc99: INTEGER
			-- Capacity of semantic value stack `yyvs99'

	yyvsp99: INTEGER
			-- Top of semantic value stack `yyvs99'

	yyspecial_routines99: KL_SPECIAL_ROUTINES [ET_PARENTHESIZED_EXPRESSION]
			-- Routines that ought to be in SPECIAL [ET_PARENTHESIZED_EXPRESSION]

	yyvs100: SPECIAL [ET_PARENT]
			-- Stack for semantic values of type ET_PARENT

	yyvsc100: INTEGER
			-- Capacity of semantic value stack `yyvs100'

	yyvsp100: INTEGER
			-- Top of semantic value stack `yyvs100'

	yyspecial_routines100: KL_SPECIAL_ROUTINES [ET_PARENT]
			-- Routines that ought to be in SPECIAL [ET_PARENT]

	yyvs101: SPECIAL [ET_PARENT_ITEM]
			-- Stack for semantic values of type ET_PARENT_ITEM

	yyvsc101: INTEGER
			-- Capacity of semantic value stack `yyvs101'

	yyvsp101: INTEGER
			-- Top of semantic value stack `yyvs101'

	yyspecial_routines101: KL_SPECIAL_ROUTINES [ET_PARENT_ITEM]
			-- Routines that ought to be in SPECIAL [ET_PARENT_ITEM]

	yyvs102: SPECIAL [ET_PARENT_LIST]
			-- Stack for semantic values of type ET_PARENT_LIST

	yyvsc102: INTEGER
			-- Capacity of semantic value stack `yyvs102'

	yyvsp102: INTEGER
			-- Top of semantic value stack `yyvs102'

	yyspecial_routines102: KL_SPECIAL_ROUTINES [ET_PARENT_LIST]
			-- Routines that ought to be in SPECIAL [ET_PARENT_LIST]

	yyvs103: SPECIAL [ET_POSTCONDITIONS]
			-- Stack for semantic values of type ET_POSTCONDITIONS

	yyvsc103: INTEGER
			-- Capacity of semantic value stack `yyvs103'

	yyvsp103: INTEGER
			-- Top of semantic value stack `yyvs103'

	yyspecial_routines103: KL_SPECIAL_ROUTINES [ET_POSTCONDITIONS]
			-- Routines that ought to be in SPECIAL [ET_POSTCONDITIONS]

	yyvs104: SPECIAL [ET_PRECONDITIONS]
			-- Stack for semantic values of type ET_PRECONDITIONS

	yyvsc104: INTEGER
			-- Capacity of semantic value stack `yyvs104'

	yyvsp104: INTEGER
			-- Top of semantic value stack `yyvs104'

	yyspecial_routines104: KL_SPECIAL_ROUTINES [ET_PRECONDITIONS]
			-- Routines that ought to be in SPECIAL [ET_PRECONDITIONS]

	yyvs105: SPECIAL [ET_PROCEDURE]
			-- Stack for semantic values of type ET_PROCEDURE

	yyvsc105: INTEGER
			-- Capacity of semantic value stack `yyvs105'

	yyvsp105: INTEGER
			-- Top of semantic value stack `yyvs105'

	yyspecial_routines105: KL_SPECIAL_ROUTINES [ET_PROCEDURE]
			-- Routines that ought to be in SPECIAL [ET_PROCEDURE]

	yyvs106: SPECIAL [ET_QUALIFIED_LIKE_IDENTIFIER]
			-- Stack for semantic values of type ET_QUALIFIED_LIKE_IDENTIFIER

	yyvsc106: INTEGER
			-- Capacity of semantic value stack `yyvs106'

	yyvsp106: INTEGER
			-- Top of semantic value stack `yyvs106'

	yyspecial_routines106: KL_SPECIAL_ROUTINES [ET_QUALIFIED_LIKE_IDENTIFIER]
			-- Routines that ought to be in SPECIAL [ET_QUALIFIED_LIKE_IDENTIFIER]

	yyvs107: SPECIAL [ET_QUERY]
			-- Stack for semantic values of type ET_QUERY

	yyvsc107: INTEGER
			-- Capacity of semantic value stack `yyvs107'

	yyvsp107: INTEGER
			-- Top of semantic value stack `yyvs107'

	yyspecial_routines107: KL_SPECIAL_ROUTINES [ET_QUERY]
			-- Routines that ought to be in SPECIAL [ET_QUERY]

	yyvs108: SPECIAL [ET_RENAME_ITEM]
			-- Stack for semantic values of type ET_RENAME_ITEM

	yyvsc108: INTEGER
			-- Capacity of semantic value stack `yyvs108'

	yyvsp108: INTEGER
			-- Top of semantic value stack `yyvs108'

	yyspecial_routines108: KL_SPECIAL_ROUTINES [ET_RENAME_ITEM]
			-- Routines that ought to be in SPECIAL [ET_RENAME_ITEM]

	yyvs109: SPECIAL [ET_RENAME_LIST]
			-- Stack for semantic values of type ET_RENAME_LIST

	yyvsc109: INTEGER
			-- Capacity of semantic value stack `yyvs109'

	yyvsp109: INTEGER
			-- Top of semantic value stack `yyvs109'

	yyspecial_routines109: KL_SPECIAL_ROUTINES [ET_RENAME_LIST]
			-- Routines that ought to be in SPECIAL [ET_RENAME_LIST]

	yyvs110: SPECIAL [ET_STATIC_CALL_EXPRESSION]
			-- Stack for semantic values of type ET_STATIC_CALL_EXPRESSION

	yyvsc110: INTEGER
			-- Capacity of semantic value stack `yyvs110'

	yyvsp110: INTEGER
			-- Top of semantic value stack `yyvs110'

	yyspecial_routines110: KL_SPECIAL_ROUTINES [ET_STATIC_CALL_EXPRESSION]
			-- Routines that ought to be in SPECIAL [ET_STATIC_CALL_EXPRESSION]

	yyvs111: SPECIAL [ET_STRIP_EXPRESSION]
			-- Stack for semantic values of type ET_STRIP_EXPRESSION

	yyvsc111: INTEGER
			-- Capacity of semantic value stack `yyvs111'

	yyvsp111: INTEGER
			-- Top of semantic value stack `yyvs111'

	yyspecial_routines111: KL_SPECIAL_ROUTINES [ET_STRIP_EXPRESSION]
			-- Routines that ought to be in SPECIAL [ET_STRIP_EXPRESSION]

	yyvs112: SPECIAL [ET_TYPE]
			-- Stack for semantic values of type ET_TYPE

	yyvsc112: INTEGER
			-- Capacity of semantic value stack `yyvs112'

	yyvsp112: INTEGER
			-- Top of semantic value stack `yyvs112'

	yyspecial_routines112: KL_SPECIAL_ROUTINES [ET_TYPE]
			-- Routines that ought to be in SPECIAL [ET_TYPE]

	yyvs113: SPECIAL [ET_TYPE_ITEM]
			-- Stack for semantic values of type ET_TYPE_ITEM

	yyvsc113: INTEGER
			-- Capacity of semantic value stack `yyvs113'

	yyvsp113: INTEGER
			-- Top of semantic value stack `yyvs113'

	yyspecial_routines113: KL_SPECIAL_ROUTINES [ET_TYPE_ITEM]
			-- Routines that ought to be in SPECIAL [ET_TYPE_ITEM]

	yyvs114: SPECIAL [ET_TYPE_LIST]
			-- Stack for semantic values of type ET_TYPE_LIST

	yyvsc114: INTEGER
			-- Capacity of semantic value stack `yyvs114'

	yyvsp114: INTEGER
			-- Top of semantic value stack `yyvs114'

	yyspecial_routines114: KL_SPECIAL_ROUTINES [ET_TYPE_LIST]
			-- Routines that ought to be in SPECIAL [ET_TYPE_LIST]

	yyvs115: SPECIAL [ET_VARIANT]
			-- Stack for semantic values of type ET_VARIANT

	yyvsc115: INTEGER
			-- Capacity of semantic value stack `yyvs115'

	yyvsp115: INTEGER
			-- Top of semantic value stack `yyvs115'

	yyspecial_routines115: KL_SPECIAL_ROUTINES [ET_VARIANT]
			-- Routines that ought to be in SPECIAL [ET_VARIANT]

	yyvs116: SPECIAL [ET_WHEN_PART]
			-- Stack for semantic values of type ET_WHEN_PART

	yyvsc116: INTEGER
			-- Capacity of semantic value stack `yyvs116'

	yyvsp116: INTEGER
			-- Top of semantic value stack `yyvs116'

	yyspecial_routines116: KL_SPECIAL_ROUTINES [ET_WHEN_PART]
			-- Routines that ought to be in SPECIAL [ET_WHEN_PART]

	yyvs117: SPECIAL [ET_WHEN_PART_LIST]
			-- Stack for semantic values of type ET_WHEN_PART_LIST

	yyvsc117: INTEGER
			-- Capacity of semantic value stack `yyvs117'

	yyvsp117: INTEGER
			-- Top of semantic value stack `yyvs117'

	yyspecial_routines117: KL_SPECIAL_ROUTINES [ET_WHEN_PART_LIST]
			-- Routines that ought to be in SPECIAL [ET_WHEN_PART_LIST]

	yyvs118: SPECIAL [ET_WRITABLE]
			-- Stack for semantic values of type ET_WRITABLE

	yyvsc118: INTEGER
			-- Capacity of semantic value stack `yyvs118'

	yyvsp118: INTEGER
			-- Top of semantic value stack `yyvs118'

	yyspecial_routines118: KL_SPECIAL_ROUTINES [ET_WRITABLE]
			-- Routines that ought to be in SPECIAL [ET_WRITABLE]

feature {NONE} -- Constants

	yyFinal: INTEGER is 1428
			-- Termination state id

	yyFlag: INTEGER is -32768
			-- Most negative INTEGER

	yyNtbase: INTEGER is 139
			-- Number of tokens

	yyLast: INTEGER is 5236
			-- Upper bound of `yytable' and `yycheck'

	yyMax_token: INTEGER is 371
			-- Maximum token id
			-- (upper bound of `yytranslate'.)

	yyNsyms: INTEGER is 393
			-- Number of symbols
			-- (terminal and nonterminal)

feature -- User-defined features



feature -- Parsing

	yyparse is
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
					yyss.put (yystate, yyssp)
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
