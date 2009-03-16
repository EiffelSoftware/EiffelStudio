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
			elseif yy_act <= 1000 then
				yy_do_action_801_1000 (yy_act)
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
					--|#line 223 "et_eiffel_parser.y"
				yy_do_action_1
			when 2 then
					--|#line 227 "et_eiffel_parser.y"
				yy_do_action_2
			when 3 then
					--|#line 235 "et_eiffel_parser.y"
				yy_do_action_3
			when 4 then
					--|#line 244 "et_eiffel_parser.y"
				yy_do_action_4
			when 5 then
					--|#line 245 "et_eiffel_parser.y"
				yy_do_action_5
			when 6 then
					--|#line 245 "et_eiffel_parser.y"
				yy_do_action_6
			when 7 then
					--|#line 256 "et_eiffel_parser.y"
				yy_do_action_7
			when 8 then
					--|#line 262 "et_eiffel_parser.y"
				yy_do_action_8
			when 9 then
					--|#line 268 "et_eiffel_parser.y"
				yy_do_action_9
			when 10 then
					--|#line 274 "et_eiffel_parser.y"
				yy_do_action_10
			when 11 then
					--|#line 280 "et_eiffel_parser.y"
				yy_do_action_11
			when 12 then
					--|#line 286 "et_eiffel_parser.y"
				yy_do_action_12
			when 13 then
					--|#line 286 "et_eiffel_parser.y"
				yy_do_action_13
			when 14 then
					--|#line 302 "et_eiffel_parser.y"
				yy_do_action_14
			when 15 then
					--|#line 307 "et_eiffel_parser.y"
				yy_do_action_15
			when 16 then
					--|#line 322 "et_eiffel_parser.y"
				yy_do_action_16
			when 17 then
					--|#line 327 "et_eiffel_parser.y"
				yy_do_action_17
			when 18 then
					--|#line 329 "et_eiffel_parser.y"
				yy_do_action_18
			when 19 then
					--|#line 329 "et_eiffel_parser.y"
				yy_do_action_19
			when 20 then
					--|#line 340 "et_eiffel_parser.y"
				yy_do_action_20
			when 21 then
					--|#line 342 "et_eiffel_parser.y"
				yy_do_action_21
			when 22 then
					--|#line 342 "et_eiffel_parser.y"
				yy_do_action_22
			when 23 then
					--|#line 355 "et_eiffel_parser.y"
				yy_do_action_23
			when 24 then
					--|#line 357 "et_eiffel_parser.y"
				yy_do_action_24
			when 25 then
					--|#line 361 "et_eiffel_parser.y"
				yy_do_action_25
			when 26 then
					--|#line 372 "et_eiffel_parser.y"
				yy_do_action_26
			when 27 then
					--|#line 372 "et_eiffel_parser.y"
				yy_do_action_27
			when 28 then
					--|#line 381 "et_eiffel_parser.y"
				yy_do_action_28
			when 29 then
					--|#line 381 "et_eiffel_parser.y"
				yy_do_action_29
			when 30 then
					--|#line 392 "et_eiffel_parser.y"
				yy_do_action_30
			when 31 then
					--|#line 399 "et_eiffel_parser.y"
				yy_do_action_31
			when 32 then
					--|#line 405 "et_eiffel_parser.y"
				yy_do_action_32
			when 33 then
					--|#line 409 "et_eiffel_parser.y"
				yy_do_action_33
			when 34 then
					--|#line 420 "et_eiffel_parser.y"
				yy_do_action_34
			when 35 then
					--|#line 432 "et_eiffel_parser.y"
				yy_do_action_35
			when 36 then
					--|#line 432 "et_eiffel_parser.y"
				yy_do_action_36
			when 37 then
					--|#line 441 "et_eiffel_parser.y"
				yy_do_action_37
			when 38 then
					--|#line 441 "et_eiffel_parser.y"
				yy_do_action_38
			when 39 then
					--|#line 452 "et_eiffel_parser.y"
				yy_do_action_39
			when 40 then
					--|#line 459 "et_eiffel_parser.y"
				yy_do_action_40
			when 41 then
					--|#line 463 "et_eiffel_parser.y"
				yy_do_action_41
			when 42 then
					--|#line 469 "et_eiffel_parser.y"
				yy_do_action_42
			when 43 then
					--|#line 471 "et_eiffel_parser.y"
				yy_do_action_43
			when 44 then
					--|#line 476 "et_eiffel_parser.y"
				yy_do_action_44
			when 45 then
					--|#line 487 "et_eiffel_parser.y"
				yy_do_action_45
			when 46 then
					--|#line 496 "et_eiffel_parser.y"
				yy_do_action_46
			when 47 then
					--|#line 498 "et_eiffel_parser.y"
				yy_do_action_47
			when 48 then
					--|#line 500 "et_eiffel_parser.y"
				yy_do_action_48
			when 49 then
					--|#line 502 "et_eiffel_parser.y"
				yy_do_action_49
			when 50 then
					--|#line 504 "et_eiffel_parser.y"
				yy_do_action_50
			when 51 then
					--|#line 506 "et_eiffel_parser.y"
				yy_do_action_51
			when 52 then
					--|#line 508 "et_eiffel_parser.y"
				yy_do_action_52
			when 53 then
					--|#line 510 "et_eiffel_parser.y"
				yy_do_action_53
			when 54 then
					--|#line 512 "et_eiffel_parser.y"
				yy_do_action_54
			when 55 then
					--|#line 516 "et_eiffel_parser.y"
				yy_do_action_55
			when 56 then
					--|#line 527 "et_eiffel_parser.y"
				yy_do_action_56
			when 57 then
					--|#line 537 "et_eiffel_parser.y"
				yy_do_action_57
			when 58 then
					--|#line 548 "et_eiffel_parser.y"
				yy_do_action_58
			when 59 then
					--|#line 559 "et_eiffel_parser.y"
				yy_do_action_59
			when 60 then
					--|#line 572 "et_eiffel_parser.y"
				yy_do_action_60
			when 61 then
					--|#line 574 "et_eiffel_parser.y"
				yy_do_action_61
			when 62 then
					--|#line 578 "et_eiffel_parser.y"
				yy_do_action_62
			when 63 then
					--|#line 580 "et_eiffel_parser.y"
				yy_do_action_63
			when 64 then
					--|#line 586 "et_eiffel_parser.y"
				yy_do_action_64
			when 65 then
					--|#line 590 "et_eiffel_parser.y"
				yy_do_action_65
			when 66 then
					--|#line 596 "et_eiffel_parser.y"
				yy_do_action_66
			when 67 then
					--|#line 596 "et_eiffel_parser.y"
				yy_do_action_67
			when 68 then
					--|#line 610 "et_eiffel_parser.y"
				yy_do_action_68
			when 69 then
					--|#line 621 "et_eiffel_parser.y"
				yy_do_action_69
			when 70 then
					--|#line 630 "et_eiffel_parser.y"
				yy_do_action_70
			when 71 then
					--|#line 639 "et_eiffel_parser.y"
				yy_do_action_71
			when 72 then
					--|#line 646 "et_eiffel_parser.y"
				yy_do_action_72
			when 73 then
					--|#line 653 "et_eiffel_parser.y"
				yy_do_action_73
			when 74 then
					--|#line 660 "et_eiffel_parser.y"
				yy_do_action_74
			when 75 then
					--|#line 667 "et_eiffel_parser.y"
				yy_do_action_75
			when 76 then
					--|#line 674 "et_eiffel_parser.y"
				yy_do_action_76
			when 77 then
					--|#line 681 "et_eiffel_parser.y"
				yy_do_action_77
			when 78 then
					--|#line 688 "et_eiffel_parser.y"
				yy_do_action_78
			when 79 then
					--|#line 695 "et_eiffel_parser.y"
				yy_do_action_79
			when 80 then
					--|#line 704 "et_eiffel_parser.y"
				yy_do_action_80
			when 81 then
					--|#line 706 "et_eiffel_parser.y"
				yy_do_action_81
			when 82 then
					--|#line 706 "et_eiffel_parser.y"
				yy_do_action_82
			when 83 then
					--|#line 719 "et_eiffel_parser.y"
				yy_do_action_83
			when 84 then
					--|#line 730 "et_eiffel_parser.y"
				yy_do_action_84
			when 85 then
					--|#line 738 "et_eiffel_parser.y"
				yy_do_action_85
			when 86 then
					--|#line 747 "et_eiffel_parser.y"
				yy_do_action_86
			when 87 then
					--|#line 749 "et_eiffel_parser.y"
				yy_do_action_87
			when 88 then
					--|#line 751 "et_eiffel_parser.y"
				yy_do_action_88
			when 89 then
					--|#line 753 "et_eiffel_parser.y"
				yy_do_action_89
			when 90 then
					--|#line 755 "et_eiffel_parser.y"
				yy_do_action_90
			when 91 then
					--|#line 757 "et_eiffel_parser.y"
				yy_do_action_91
			when 92 then
					--|#line 759 "et_eiffel_parser.y"
				yy_do_action_92
			when 93 then
					--|#line 767 "et_eiffel_parser.y"
				yy_do_action_93
			when 94 then
					--|#line 775 "et_eiffel_parser.y"
				yy_do_action_94
			when 95 then
					--|#line 777 "et_eiffel_parser.y"
				yy_do_action_95
			when 96 then
					--|#line 779 "et_eiffel_parser.y"
				yy_do_action_96
			when 97 then
					--|#line 781 "et_eiffel_parser.y"
				yy_do_action_97
			when 98 then
					--|#line 783 "et_eiffel_parser.y"
				yy_do_action_98
			when 99 then
					--|#line 785 "et_eiffel_parser.y"
				yy_do_action_99
			when 100 then
					--|#line 787 "et_eiffel_parser.y"
				yy_do_action_100
			when 101 then
					--|#line 795 "et_eiffel_parser.y"
				yy_do_action_101
			when 102 then
					--|#line 805 "et_eiffel_parser.y"
				yy_do_action_102
			when 103 then
					--|#line 807 "et_eiffel_parser.y"
				yy_do_action_103
			when 104 then
					--|#line 809 "et_eiffel_parser.y"
				yy_do_action_104
			when 105 then
					--|#line 811 "et_eiffel_parser.y"
				yy_do_action_105
			when 106 then
					--|#line 813 "et_eiffel_parser.y"
				yy_do_action_106
			when 107 then
					--|#line 815 "et_eiffel_parser.y"
				yy_do_action_107
			when 108 then
					--|#line 817 "et_eiffel_parser.y"
				yy_do_action_108
			when 109 then
					--|#line 825 "et_eiffel_parser.y"
				yy_do_action_109
			when 110 then
					--|#line 833 "et_eiffel_parser.y"
				yy_do_action_110
			when 111 then
					--|#line 835 "et_eiffel_parser.y"
				yy_do_action_111
			when 112 then
					--|#line 837 "et_eiffel_parser.y"
				yy_do_action_112
			when 113 then
					--|#line 839 "et_eiffel_parser.y"
				yy_do_action_113
			when 114 then
					--|#line 841 "et_eiffel_parser.y"
				yy_do_action_114
			when 115 then
					--|#line 843 "et_eiffel_parser.y"
				yy_do_action_115
			when 116 then
					--|#line 845 "et_eiffel_parser.y"
				yy_do_action_116
			when 117 then
					--|#line 853 "et_eiffel_parser.y"
				yy_do_action_117
			when 118 then
					--|#line 863 "et_eiffel_parser.y"
				yy_do_action_118
			when 119 then
					--|#line 865 "et_eiffel_parser.y"
				yy_do_action_119
			when 120 then
					--|#line 869 "et_eiffel_parser.y"
				yy_do_action_120
			when 121 then
					--|#line 872 "et_eiffel_parser.y"
				yy_do_action_121
			when 122 then
					--|#line 880 "et_eiffel_parser.y"
				yy_do_action_122
			when 123 then
					--|#line 891 "et_eiffel_parser.y"
				yy_do_action_123
			when 124 then
					--|#line 896 "et_eiffel_parser.y"
				yy_do_action_124
			when 125 then
					--|#line 901 "et_eiffel_parser.y"
				yy_do_action_125
			when 126 then
					--|#line 908 "et_eiffel_parser.y"
				yy_do_action_126
			when 127 then
					--|#line 917 "et_eiffel_parser.y"
				yy_do_action_127
			when 128 then
					--|#line 919 "et_eiffel_parser.y"
				yy_do_action_128
			when 129 then
					--|#line 923 "et_eiffel_parser.y"
				yy_do_action_129
			when 130 then
					--|#line 926 "et_eiffel_parser.y"
				yy_do_action_130
			when 131 then
					--|#line 932 "et_eiffel_parser.y"
				yy_do_action_131
			when 132 then
					--|#line 940 "et_eiffel_parser.y"
				yy_do_action_132
			when 133 then
					--|#line 945 "et_eiffel_parser.y"
				yy_do_action_133
			when 134 then
					--|#line 950 "et_eiffel_parser.y"
				yy_do_action_134
			when 135 then
					--|#line 955 "et_eiffel_parser.y"
				yy_do_action_135
			when 136 then
					--|#line 966 "et_eiffel_parser.y"
				yy_do_action_136
			when 137 then
					--|#line 977 "et_eiffel_parser.y"
				yy_do_action_137
			when 138 then
					--|#line 990 "et_eiffel_parser.y"
				yy_do_action_138
			when 139 then
					--|#line 999 "et_eiffel_parser.y"
				yy_do_action_139
			when 140 then
					--|#line 1010 "et_eiffel_parser.y"
				yy_do_action_140
			when 141 then
					--|#line 1012 "et_eiffel_parser.y"
				yy_do_action_141
			when 142 then
					--|#line 1018 "et_eiffel_parser.y"
				yy_do_action_142
			when 143 then
					--|#line 1020 "et_eiffel_parser.y"
				yy_do_action_143
			when 144 then
					--|#line 1022 "et_eiffel_parser.y"
				yy_do_action_144
			when 145 then
					--|#line 1029 "et_eiffel_parser.y"
				yy_do_action_145
			when 146 then
					--|#line 1037 "et_eiffel_parser.y"
				yy_do_action_146
			when 147 then
					--|#line 1044 "et_eiffel_parser.y"
				yy_do_action_147
			when 148 then
					--|#line 1051 "et_eiffel_parser.y"
				yy_do_action_148
			when 149 then
					--|#line 1059 "et_eiffel_parser.y"
				yy_do_action_149
			when 150 then
					--|#line 1066 "et_eiffel_parser.y"
				yy_do_action_150
			when 151 then
					--|#line 1073 "et_eiffel_parser.y"
				yy_do_action_151
			when 152 then
					--|#line 1080 "et_eiffel_parser.y"
				yy_do_action_152
			when 153 then
					--|#line 1089 "et_eiffel_parser.y"
				yy_do_action_153
			when 154 then
					--|#line 1098 "et_eiffel_parser.y"
				yy_do_action_154
			when 155 then
					--|#line 1105 "et_eiffel_parser.y"
				yy_do_action_155
			when 156 then
					--|#line 1112 "et_eiffel_parser.y"
				yy_do_action_156
			when 157 then
					--|#line 1119 "et_eiffel_parser.y"
				yy_do_action_157
			when 158 then
					--|#line 1126 "et_eiffel_parser.y"
				yy_do_action_158
			when 159 then
					--|#line 1135 "et_eiffel_parser.y"
				yy_do_action_159
			when 160 then
					--|#line 1142 "et_eiffel_parser.y"
				yy_do_action_160
			when 161 then
					--|#line 1149 "et_eiffel_parser.y"
				yy_do_action_161
			when 162 then
					--|#line 1156 "et_eiffel_parser.y"
				yy_do_action_162
			when 163 then
					--|#line 1165 "et_eiffel_parser.y"
				yy_do_action_163
			when 164 then
					--|#line 1172 "et_eiffel_parser.y"
				yy_do_action_164
			when 165 then
					--|#line 1183 "et_eiffel_parser.y"
				yy_do_action_165
			when 166 then
					--|#line 1185 "et_eiffel_parser.y"
				yy_do_action_166
			when 167 then
					--|#line 1185 "et_eiffel_parser.y"
				yy_do_action_167
			when 168 then
					--|#line 1198 "et_eiffel_parser.y"
				yy_do_action_168
			when 169 then
					--|#line 1205 "et_eiffel_parser.y"
				yy_do_action_169
			when 170 then
					--|#line 1213 "et_eiffel_parser.y"
				yy_do_action_170
			when 171 then
					--|#line 1222 "et_eiffel_parser.y"
				yy_do_action_171
			when 172 then
					--|#line 1231 "et_eiffel_parser.y"
				yy_do_action_172
			when 173 then
					--|#line 1242 "et_eiffel_parser.y"
				yy_do_action_173
			when 174 then
					--|#line 1244 "et_eiffel_parser.y"
				yy_do_action_174
			when 175 then
					--|#line 1244 "et_eiffel_parser.y"
				yy_do_action_175
			when 176 then
					--|#line 1257 "et_eiffel_parser.y"
				yy_do_action_176
			when 177 then
					--|#line 1259 "et_eiffel_parser.y"
				yy_do_action_177
			when 178 then
					--|#line 1263 "et_eiffel_parser.y"
				yy_do_action_178
			when 179 then
					--|#line 1274 "et_eiffel_parser.y"
				yy_do_action_179
			when 180 then
					--|#line 1274 "et_eiffel_parser.y"
				yy_do_action_180
			when 181 then
					--|#line 1289 "et_eiffel_parser.y"
				yy_do_action_181
			when 182 then
					--|#line 1293 "et_eiffel_parser.y"
				yy_do_action_182
			when 183 then
					--|#line 1298 "et_eiffel_parser.y"
				yy_do_action_183
			when 184 then
					--|#line 1298 "et_eiffel_parser.y"
				yy_do_action_184
			when 185 then
					--|#line 1308 "et_eiffel_parser.y"
				yy_do_action_185
			when 186 then
					--|#line 1312 "et_eiffel_parser.y"
				yy_do_action_186
			when 187 then
					--|#line 1323 "et_eiffel_parser.y"
				yy_do_action_187
			when 188 then
					--|#line 1331 "et_eiffel_parser.y"
				yy_do_action_188
			when 189 then
					--|#line 1342 "et_eiffel_parser.y"
				yy_do_action_189
			when 190 then
					--|#line 1342 "et_eiffel_parser.y"
				yy_do_action_190
			when 191 then
					--|#line 1353 "et_eiffel_parser.y"
				yy_do_action_191
			when 192 then
					--|#line 1357 "et_eiffel_parser.y"
				yy_do_action_192
			when 193 then
					--|#line 1364 "et_eiffel_parser.y"
				yy_do_action_193
			when 194 then
					--|#line 1372 "et_eiffel_parser.y"
				yy_do_action_194
			when 195 then
					--|#line 1379 "et_eiffel_parser.y"
				yy_do_action_195
			when 196 then
					--|#line 1389 "et_eiffel_parser.y"
				yy_do_action_196
			when 197 then
					--|#line 1398 "et_eiffel_parser.y"
				yy_do_action_197
			when 198 then
					--|#line 1409 "et_eiffel_parser.y"
				yy_do_action_198
			when 199 then
					--|#line 1411 "et_eiffel_parser.y"
				yy_do_action_199
			when 200 then
					--|#line 1411 "et_eiffel_parser.y"
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
					--|#line 1424 "et_eiffel_parser.y"
				yy_do_action_201
			when 202 then
					--|#line 1426 "et_eiffel_parser.y"
				yy_do_action_202
			when 203 then
					--|#line 1430 "et_eiffel_parser.y"
				yy_do_action_203
			when 204 then
					--|#line 1432 "et_eiffel_parser.y"
				yy_do_action_204
			when 205 then
					--|#line 1432 "et_eiffel_parser.y"
				yy_do_action_205
			when 206 then
					--|#line 1445 "et_eiffel_parser.y"
				yy_do_action_206
			when 207 then
					--|#line 1447 "et_eiffel_parser.y"
				yy_do_action_207
			when 208 then
					--|#line 1451 "et_eiffel_parser.y"
				yy_do_action_208
			when 209 then
					--|#line 1453 "et_eiffel_parser.y"
				yy_do_action_209
			when 210 then
					--|#line 1453 "et_eiffel_parser.y"
				yy_do_action_210
			when 211 then
					--|#line 1466 "et_eiffel_parser.y"
				yy_do_action_211
			when 212 then
					--|#line 1468 "et_eiffel_parser.y"
				yy_do_action_212
			when 213 then
					--|#line 1472 "et_eiffel_parser.y"
				yy_do_action_213
			when 214 then
					--|#line 1483 "et_eiffel_parser.y"
				yy_do_action_214
			when 215 then
					--|#line 1491 "et_eiffel_parser.y"
				yy_do_action_215
			when 216 then
					--|#line 1500 "et_eiffel_parser.y"
				yy_do_action_216
			when 217 then
					--|#line 1511 "et_eiffel_parser.y"
				yy_do_action_217
			when 218 then
					--|#line 1513 "et_eiffel_parser.y"
				yy_do_action_218
			when 219 then
					--|#line 1520 "et_eiffel_parser.y"
				yy_do_action_219
			when 220 then
					--|#line 1527 "et_eiffel_parser.y"
				yy_do_action_220
			when 221 then
					--|#line 1538 "et_eiffel_parser.y"
				yy_do_action_221
			when 222 then
					--|#line 1538 "et_eiffel_parser.y"
				yy_do_action_222
			when 223 then
					--|#line 1553 "et_eiffel_parser.y"
				yy_do_action_223
			when 224 then
					--|#line 1555 "et_eiffel_parser.y"
				yy_do_action_224
			when 225 then
					--|#line 1557 "et_eiffel_parser.y"
				yy_do_action_225
			when 226 then
					--|#line 1557 "et_eiffel_parser.y"
				yy_do_action_226
			when 227 then
					--|#line 1569 "et_eiffel_parser.y"
				yy_do_action_227
			when 228 then
					--|#line 1569 "et_eiffel_parser.y"
				yy_do_action_228
			when 229 then
					--|#line 1581 "et_eiffel_parser.y"
				yy_do_action_229
			when 230 then
					--|#line 1583 "et_eiffel_parser.y"
				yy_do_action_230
			when 231 then
					--|#line 1585 "et_eiffel_parser.y"
				yy_do_action_231
			when 232 then
					--|#line 1585 "et_eiffel_parser.y"
				yy_do_action_232
			when 233 then
					--|#line 1597 "et_eiffel_parser.y"
				yy_do_action_233
			when 234 then
					--|#line 1597 "et_eiffel_parser.y"
				yy_do_action_234
			when 235 then
					--|#line 1611 "et_eiffel_parser.y"
				yy_do_action_235
			when 236 then
					--|#line 1622 "et_eiffel_parser.y"
				yy_do_action_236
			when 237 then
					--|#line 1634 "et_eiffel_parser.y"
				yy_do_action_237
			when 238 then
					--|#line 1643 "et_eiffel_parser.y"
				yy_do_action_238
			when 239 then
					--|#line 1654 "et_eiffel_parser.y"
				yy_do_action_239
			when 240 then
					--|#line 1656 "et_eiffel_parser.y"
				yy_do_action_240
			when 241 then
					--|#line 1660 "et_eiffel_parser.y"
				yy_do_action_241
			when 242 then
					--|#line 1660 "et_eiffel_parser.y"
				yy_do_action_242
			when 243 then
					--|#line 1673 "et_eiffel_parser.y"
				yy_do_action_243
			when 244 then
					--|#line 1680 "et_eiffel_parser.y"
				yy_do_action_244
			when 245 then
					--|#line 1687 "et_eiffel_parser.y"
				yy_do_action_245
			when 246 then
					--|#line 1696 "et_eiffel_parser.y"
				yy_do_action_246
			when 247 then
					--|#line 1705 "et_eiffel_parser.y"
				yy_do_action_247
			when 248 then
					--|#line 1709 "et_eiffel_parser.y"
				yy_do_action_248
			when 249 then
					--|#line 1715 "et_eiffel_parser.y"
				yy_do_action_249
			when 250 then
					--|#line 1717 "et_eiffel_parser.y"
				yy_do_action_250
			when 251 then
					--|#line 1717 "et_eiffel_parser.y"
				yy_do_action_251
			when 252 then
					--|#line 1730 "et_eiffel_parser.y"
				yy_do_action_252
			when 253 then
					--|#line 1741 "et_eiffel_parser.y"
				yy_do_action_253
			when 254 then
					--|#line 1750 "et_eiffel_parser.y"
				yy_do_action_254
			when 255 then
					--|#line 1761 "et_eiffel_parser.y"
				yy_do_action_255
			when 256 then
					--|#line 1766 "et_eiffel_parser.y"
				yy_do_action_256
			when 257 then
					--|#line 1770 "et_eiffel_parser.y"
				yy_do_action_257
			when 258 then
					--|#line 1778 "et_eiffel_parser.y"
				yy_do_action_258
			when 259 then
					--|#line 1785 "et_eiffel_parser.y"
				yy_do_action_259
			when 260 then
					--|#line 1794 "et_eiffel_parser.y"
				yy_do_action_260
			when 261 then
					--|#line 1801 "et_eiffel_parser.y"
				yy_do_action_261
			when 262 then
					--|#line 1810 "et_eiffel_parser.y"
				yy_do_action_262
			when 263 then
					--|#line 1815 "et_eiffel_parser.y"
				yy_do_action_263
			when 264 then
					--|#line 1822 "et_eiffel_parser.y"
				yy_do_action_264
			when 265 then
					--|#line 1823 "et_eiffel_parser.y"
				yy_do_action_265
			when 266 then
					--|#line 1824 "et_eiffel_parser.y"
				yy_do_action_266
			when 267 then
					--|#line 1825 "et_eiffel_parser.y"
				yy_do_action_267
			when 268 then
					--|#line 1830 "et_eiffel_parser.y"
				yy_do_action_268
			when 269 then
					--|#line 1835 "et_eiffel_parser.y"
				yy_do_action_269
			when 270 then
					--|#line 1841 "et_eiffel_parser.y"
				yy_do_action_270
			when 271 then
					--|#line 1846 "et_eiffel_parser.y"
				yy_do_action_271
			when 272 then
					--|#line 1852 "et_eiffel_parser.y"
				yy_do_action_272
			when 273 then
					--|#line 1858 "et_eiffel_parser.y"
				yy_do_action_273
			when 274 then
					--|#line 1867 "et_eiffel_parser.y"
				yy_do_action_274
			when 275 then
					--|#line 1872 "et_eiffel_parser.y"
				yy_do_action_275
			when 276 then
					--|#line 1878 "et_eiffel_parser.y"
				yy_do_action_276
			when 277 then
					--|#line 1883 "et_eiffel_parser.y"
				yy_do_action_277
			when 278 then
					--|#line 1889 "et_eiffel_parser.y"
				yy_do_action_278
			when 279 then
					--|#line 1895 "et_eiffel_parser.y"
				yy_do_action_279
			when 280 then
					--|#line 1904 "et_eiffel_parser.y"
				yy_do_action_280
			when 281 then
					--|#line 1906 "et_eiffel_parser.y"
				yy_do_action_281
			when 282 then
					--|#line 1908 "et_eiffel_parser.y"
				yy_do_action_282
			when 283 then
					--|#line 1910 "et_eiffel_parser.y"
				yy_do_action_283
			when 284 then
					--|#line 1918 "et_eiffel_parser.y"
				yy_do_action_284
			when 285 then
					--|#line 1920 "et_eiffel_parser.y"
				yy_do_action_285
			when 286 then
					--|#line 1928 "et_eiffel_parser.y"
				yy_do_action_286
			when 287 then
					--|#line 1931 "et_eiffel_parser.y"
				yy_do_action_287
			when 288 then
					--|#line 1940 "et_eiffel_parser.y"
				yy_do_action_288
			when 289 then
					--|#line 1944 "et_eiffel_parser.y"
				yy_do_action_289
			when 290 then
					--|#line 1954 "et_eiffel_parser.y"
				yy_do_action_290
			when 291 then
					--|#line 1957 "et_eiffel_parser.y"
				yy_do_action_291
			when 292 then
					--|#line 1966 "et_eiffel_parser.y"
				yy_do_action_292
			when 293 then
					--|#line 1970 "et_eiffel_parser.y"
				yy_do_action_293
			when 294 then
					--|#line 1980 "et_eiffel_parser.y"
				yy_do_action_294
			when 295 then
					--|#line 1982 "et_eiffel_parser.y"
				yy_do_action_295
			when 296 then
					--|#line 1990 "et_eiffel_parser.y"
				yy_do_action_296
			when 297 then
					--|#line 1993 "et_eiffel_parser.y"
				yy_do_action_297
			when 298 then
					--|#line 2002 "et_eiffel_parser.y"
				yy_do_action_298
			when 299 then
					--|#line 2005 "et_eiffel_parser.y"
				yy_do_action_299
			when 300 then
					--|#line 2014 "et_eiffel_parser.y"
				yy_do_action_300
			when 301 then
					--|#line 2018 "et_eiffel_parser.y"
				yy_do_action_301
			when 302 then
					--|#line 2030 "et_eiffel_parser.y"
				yy_do_action_302
			when 303 then
					--|#line 2033 "et_eiffel_parser.y"
				yy_do_action_303
			when 304 then
					--|#line 2037 "et_eiffel_parser.y"
				yy_do_action_304
			when 305 then
					--|#line 2040 "et_eiffel_parser.y"
				yy_do_action_305
			when 306 then
					--|#line 2044 "et_eiffel_parser.y"
				yy_do_action_306
			when 307 then
					--|#line 2046 "et_eiffel_parser.y"
				yy_do_action_307
			when 308 then
					--|#line 2049 "et_eiffel_parser.y"
				yy_do_action_308
			when 309 then
					--|#line 2052 "et_eiffel_parser.y"
				yy_do_action_309
			when 310 then
					--|#line 2058 "et_eiffel_parser.y"
				yy_do_action_310
			when 311 then
					--|#line 2066 "et_eiffel_parser.y"
				yy_do_action_311
			when 312 then
					--|#line 2070 "et_eiffel_parser.y"
				yy_do_action_312
			when 313 then
					--|#line 2072 "et_eiffel_parser.y"
				yy_do_action_313
			when 314 then
					--|#line 2076 "et_eiffel_parser.y"
				yy_do_action_314
			when 315 then
					--|#line 2078 "et_eiffel_parser.y"
				yy_do_action_315
			when 316 then
					--|#line 2082 "et_eiffel_parser.y"
				yy_do_action_316
			when 317 then
					--|#line 2084 "et_eiffel_parser.y"
				yy_do_action_317
			when 318 then
					--|#line 2090 "et_eiffel_parser.y"
				yy_do_action_318
			when 319 then
					--|#line 2092 "et_eiffel_parser.y"
				yy_do_action_319
			when 320 then
					--|#line 2094 "et_eiffel_parser.y"
				yy_do_action_320
			when 321 then
					--|#line 2096 "et_eiffel_parser.y"
				yy_do_action_321
			when 322 then
					--|#line 2098 "et_eiffel_parser.y"
				yy_do_action_322
			when 323 then
					--|#line 2100 "et_eiffel_parser.y"
				yy_do_action_323
			when 324 then
					--|#line 2102 "et_eiffel_parser.y"
				yy_do_action_324
			when 325 then
					--|#line 2104 "et_eiffel_parser.y"
				yy_do_action_325
			when 326 then
					--|#line 2106 "et_eiffel_parser.y"
				yy_do_action_326
			when 327 then
					--|#line 2108 "et_eiffel_parser.y"
				yy_do_action_327
			when 328 then
					--|#line 2110 "et_eiffel_parser.y"
				yy_do_action_328
			when 329 then
					--|#line 2112 "et_eiffel_parser.y"
				yy_do_action_329
			when 330 then
					--|#line 2114 "et_eiffel_parser.y"
				yy_do_action_330
			when 331 then
					--|#line 2116 "et_eiffel_parser.y"
				yy_do_action_331
			when 332 then
					--|#line 2118 "et_eiffel_parser.y"
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
					--|#line 2137 "et_eiffel_parser.y"
				yy_do_action_341
			when 342 then
					--|#line 2139 "et_eiffel_parser.y"
				yy_do_action_342
			when 343 then
					--|#line 2141 "et_eiffel_parser.y"
				yy_do_action_343
			when 344 then
					--|#line 2143 "et_eiffel_parser.y"
				yy_do_action_344
			when 345 then
					--|#line 2145 "et_eiffel_parser.y"
				yy_do_action_345
			when 346 then
					--|#line 2147 "et_eiffel_parser.y"
				yy_do_action_346
			when 347 then
					--|#line 2149 "et_eiffel_parser.y"
				yy_do_action_347
			when 348 then
					--|#line 2151 "et_eiffel_parser.y"
				yy_do_action_348
			when 349 then
					--|#line 2153 "et_eiffel_parser.y"
				yy_do_action_349
			when 350 then
					--|#line 2155 "et_eiffel_parser.y"
				yy_do_action_350
			when 351 then
					--|#line 2157 "et_eiffel_parser.y"
				yy_do_action_351
			when 352 then
					--|#line 2159 "et_eiffel_parser.y"
				yy_do_action_352
			when 353 then
					--|#line 2161 "et_eiffel_parser.y"
				yy_do_action_353
			when 354 then
					--|#line 2163 "et_eiffel_parser.y"
				yy_do_action_354
			when 355 then
					--|#line 2165 "et_eiffel_parser.y"
				yy_do_action_355
			when 356 then
					--|#line 2167 "et_eiffel_parser.y"
				yy_do_action_356
			when 357 then
					--|#line 2169 "et_eiffel_parser.y"
				yy_do_action_357
			when 358 then
					--|#line 2171 "et_eiffel_parser.y"
				yy_do_action_358
			when 359 then
					--|#line 2175 "et_eiffel_parser.y"
				yy_do_action_359
			when 360 then
					--|#line 2177 "et_eiffel_parser.y"
				yy_do_action_360
			when 361 then
					--|#line 2181 "et_eiffel_parser.y"
				yy_do_action_361
			when 362 then
					--|#line 2183 "et_eiffel_parser.y"
				yy_do_action_362
			when 363 then
					--|#line 2185 "et_eiffel_parser.y"
				yy_do_action_363
			when 364 then
					--|#line 2187 "et_eiffel_parser.y"
				yy_do_action_364
			when 365 then
					--|#line 2189 "et_eiffel_parser.y"
				yy_do_action_365
			when 366 then
					--|#line 2191 "et_eiffel_parser.y"
				yy_do_action_366
			when 367 then
					--|#line 2193 "et_eiffel_parser.y"
				yy_do_action_367
			when 368 then
					--|#line 2195 "et_eiffel_parser.y"
				yy_do_action_368
			when 369 then
					--|#line 2197 "et_eiffel_parser.y"
				yy_do_action_369
			when 370 then
					--|#line 2199 "et_eiffel_parser.y"
				yy_do_action_370
			when 371 then
					--|#line 2201 "et_eiffel_parser.y"
				yy_do_action_371
			when 372 then
					--|#line 2203 "et_eiffel_parser.y"
				yy_do_action_372
			when 373 then
					--|#line 2205 "et_eiffel_parser.y"
				yy_do_action_373
			when 374 then
					--|#line 2207 "et_eiffel_parser.y"
				yy_do_action_374
			when 375 then
					--|#line 2209 "et_eiffel_parser.y"
				yy_do_action_375
			when 376 then
					--|#line 2211 "et_eiffel_parser.y"
				yy_do_action_376
			when 377 then
					--|#line 2213 "et_eiffel_parser.y"
				yy_do_action_377
			when 378 then
					--|#line 2215 "et_eiffel_parser.y"
				yy_do_action_378
			when 379 then
					--|#line 2217 "et_eiffel_parser.y"
				yy_do_action_379
			when 380 then
					--|#line 2219 "et_eiffel_parser.y"
				yy_do_action_380
			when 381 then
					--|#line 2221 "et_eiffel_parser.y"
				yy_do_action_381
			when 382 then
					--|#line 2224 "et_eiffel_parser.y"
				yy_do_action_382
			when 383 then
					--|#line 2230 "et_eiffel_parser.y"
				yy_do_action_383
			when 384 then
					--|#line 2237 "et_eiffel_parser.y"
				yy_do_action_384
			when 385 then
					--|#line 2239 "et_eiffel_parser.y"
				yy_do_action_385
			when 386 then
					--|#line 2247 "et_eiffel_parser.y"
				yy_do_action_386
			when 387 then
					--|#line 2258 "et_eiffel_parser.y"
				yy_do_action_387
			when 388 then
					--|#line 2265 "et_eiffel_parser.y"
				yy_do_action_388
			when 389 then
					--|#line 2272 "et_eiffel_parser.y"
				yy_do_action_389
			when 390 then
					--|#line 2282 "et_eiffel_parser.y"
				yy_do_action_390
			when 391 then
					--|#line 2293 "et_eiffel_parser.y"
				yy_do_action_391
			when 392 then
					--|#line 2300 "et_eiffel_parser.y"
				yy_do_action_392
			when 393 then
					--|#line 2309 "et_eiffel_parser.y"
				yy_do_action_393
			when 394 then
					--|#line 2318 "et_eiffel_parser.y"
				yy_do_action_394
			when 395 then
					--|#line 2327 "et_eiffel_parser.y"
				yy_do_action_395
			when 396 then
					--|#line 2336 "et_eiffel_parser.y"
				yy_do_action_396
			when 397 then
					--|#line 2347 "et_eiffel_parser.y"
				yy_do_action_397
			when 398 then
					--|#line 2349 "et_eiffel_parser.y"
				yy_do_action_398
			when 399 then
					--|#line 2351 "et_eiffel_parser.y"
				yy_do_action_399
			when 400 then
					--|#line 2351 "et_eiffel_parser.y"
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
					--|#line 2364 "et_eiffel_parser.y"
				yy_do_action_401
			when 402 then
					--|#line 2371 "et_eiffel_parser.y"
				yy_do_action_402
			when 403 then
					--|#line 2378 "et_eiffel_parser.y"
				yy_do_action_403
			when 404 then
					--|#line 2388 "et_eiffel_parser.y"
				yy_do_action_404
			when 405 then
					--|#line 2399 "et_eiffel_parser.y"
				yy_do_action_405
			when 406 then
					--|#line 2406 "et_eiffel_parser.y"
				yy_do_action_406
			when 407 then
					--|#line 2415 "et_eiffel_parser.y"
				yy_do_action_407
			when 408 then
					--|#line 2424 "et_eiffel_parser.y"
				yy_do_action_408
			when 409 then
					--|#line 2433 "et_eiffel_parser.y"
				yy_do_action_409
			when 410 then
					--|#line 2442 "et_eiffel_parser.y"
				yy_do_action_410
			when 411 then
					--|#line 2453 "et_eiffel_parser.y"
				yy_do_action_411
			when 412 then
					--|#line 2455 "et_eiffel_parser.y"
				yy_do_action_412
			when 413 then
					--|#line 2457 "et_eiffel_parser.y"
				yy_do_action_413
			when 414 then
					--|#line 2459 "et_eiffel_parser.y"
				yy_do_action_414
			when 415 then
					--|#line 2461 "et_eiffel_parser.y"
				yy_do_action_415
			when 416 then
					--|#line 2463 "et_eiffel_parser.y"
				yy_do_action_416
			when 417 then
					--|#line 2465 "et_eiffel_parser.y"
				yy_do_action_417
			when 418 then
					--|#line 2467 "et_eiffel_parser.y"
				yy_do_action_418
			when 419 then
					--|#line 2471 "et_eiffel_parser.y"
				yy_do_action_419
			when 420 then
					--|#line 2473 "et_eiffel_parser.y"
				yy_do_action_420
			when 421 then
					--|#line 2475 "et_eiffel_parser.y"
				yy_do_action_421
			when 422 then
					--|#line 2477 "et_eiffel_parser.y"
				yy_do_action_422
			when 423 then
					--|#line 2479 "et_eiffel_parser.y"
				yy_do_action_423
			when 424 then
					--|#line 2483 "et_eiffel_parser.y"
				yy_do_action_424
			when 425 then
					--|#line 2485 "et_eiffel_parser.y"
				yy_do_action_425
			when 426 then
					--|#line 2487 "et_eiffel_parser.y"
				yy_do_action_426
			when 427 then
					--|#line 2489 "et_eiffel_parser.y"
				yy_do_action_427
			when 428 then
					--|#line 2491 "et_eiffel_parser.y"
				yy_do_action_428
			when 429 then
					--|#line 2495 "et_eiffel_parser.y"
				yy_do_action_429
			when 430 then
					--|#line 2497 "et_eiffel_parser.y"
				yy_do_action_430
			when 431 then
					--|#line 2501 "et_eiffel_parser.y"
				yy_do_action_431
			when 432 then
					--|#line 2503 "et_eiffel_parser.y"
				yy_do_action_432
			when 433 then
					--|#line 2507 "et_eiffel_parser.y"
				yy_do_action_433
			when 434 then
					--|#line 2511 "et_eiffel_parser.y"
				yy_do_action_434
			when 435 then
					--|#line 2513 "et_eiffel_parser.y"
				yy_do_action_435
			when 436 then
					--|#line 2517 "et_eiffel_parser.y"
				yy_do_action_436
			when 437 then
					--|#line 2519 "et_eiffel_parser.y"
				yy_do_action_437
			when 438 then
					--|#line 2523 "et_eiffel_parser.y"
				yy_do_action_438
			when 439 then
					--|#line 2525 "et_eiffel_parser.y"
				yy_do_action_439
			when 440 then
					--|#line 2527 "et_eiffel_parser.y"
				yy_do_action_440
			when 441 then
					--|#line 2533 "et_eiffel_parser.y"
				yy_do_action_441
			when 442 then
					--|#line 2535 "et_eiffel_parser.y"
				yy_do_action_442
			when 443 then
					--|#line 2541 "et_eiffel_parser.y"
				yy_do_action_443
			when 444 then
					--|#line 2543 "et_eiffel_parser.y"
				yy_do_action_444
			when 445 then
					--|#line 2547 "et_eiffel_parser.y"
				yy_do_action_445
			when 446 then
					--|#line 2549 "et_eiffel_parser.y"
				yy_do_action_446
			when 447 then
					--|#line 2551 "et_eiffel_parser.y"
				yy_do_action_447
			when 448 then
					--|#line 2553 "et_eiffel_parser.y"
				yy_do_action_448
			when 449 then
					--|#line 2555 "et_eiffel_parser.y"
				yy_do_action_449
			when 450 then
					--|#line 2557 "et_eiffel_parser.y"
				yy_do_action_450
			when 451 then
					--|#line 2559 "et_eiffel_parser.y"
				yy_do_action_451
			when 452 then
					--|#line 2567 "et_eiffel_parser.y"
				yy_do_action_452
			when 453 then
					--|#line 2575 "et_eiffel_parser.y"
				yy_do_action_453
			when 454 then
					--|#line 2577 "et_eiffel_parser.y"
				yy_do_action_454
			when 455 then
					--|#line 2579 "et_eiffel_parser.y"
				yy_do_action_455
			when 456 then
					--|#line 2581 "et_eiffel_parser.y"
				yy_do_action_456
			when 457 then
					--|#line 2583 "et_eiffel_parser.y"
				yy_do_action_457
			when 458 then
					--|#line 2585 "et_eiffel_parser.y"
				yy_do_action_458
			when 459 then
					--|#line 2587 "et_eiffel_parser.y"
				yy_do_action_459
			when 460 then
					--|#line 2595 "et_eiffel_parser.y"
				yy_do_action_460
			when 461 then
					--|#line 2605 "et_eiffel_parser.y"
				yy_do_action_461
			when 462 then
					--|#line 2607 "et_eiffel_parser.y"
				yy_do_action_462
			when 463 then
					--|#line 2609 "et_eiffel_parser.y"
				yy_do_action_463
			when 464 then
					--|#line 2611 "et_eiffel_parser.y"
				yy_do_action_464
			when 465 then
					--|#line 2613 "et_eiffel_parser.y"
				yy_do_action_465
			when 466 then
					--|#line 2615 "et_eiffel_parser.y"
				yy_do_action_466
			when 467 then
					--|#line 2617 "et_eiffel_parser.y"
				yy_do_action_467
			when 468 then
					--|#line 2625 "et_eiffel_parser.y"
				yy_do_action_468
			when 469 then
					--|#line 2633 "et_eiffel_parser.y"
				yy_do_action_469
			when 470 then
					--|#line 2635 "et_eiffel_parser.y"
				yy_do_action_470
			when 471 then
					--|#line 2637 "et_eiffel_parser.y"
				yy_do_action_471
			when 472 then
					--|#line 2639 "et_eiffel_parser.y"
				yy_do_action_472
			when 473 then
					--|#line 2641 "et_eiffel_parser.y"
				yy_do_action_473
			when 474 then
					--|#line 2643 "et_eiffel_parser.y"
				yy_do_action_474
			when 475 then
					--|#line 2645 "et_eiffel_parser.y"
				yy_do_action_475
			when 476 then
					--|#line 2653 "et_eiffel_parser.y"
				yy_do_action_476
			when 477 then
					--|#line 2663 "et_eiffel_parser.y"
				yy_do_action_477
			when 478 then
					--|#line 2665 "et_eiffel_parser.y"
				yy_do_action_478
			when 479 then
					--|#line 2667 "et_eiffel_parser.y"
				yy_do_action_479
			when 480 then
					--|#line 2669 "et_eiffel_parser.y"
				yy_do_action_480
			when 481 then
					--|#line 2671 "et_eiffel_parser.y"
				yy_do_action_481
			when 482 then
					--|#line 2673 "et_eiffel_parser.y"
				yy_do_action_482
			when 483 then
					--|#line 2675 "et_eiffel_parser.y"
				yy_do_action_483
			when 484 then
					--|#line 2677 "et_eiffel_parser.y"
				yy_do_action_484
			when 485 then
					--|#line 2685 "et_eiffel_parser.y"
				yy_do_action_485
			when 486 then
					--|#line 2693 "et_eiffel_parser.y"
				yy_do_action_486
			when 487 then
					--|#line 2695 "et_eiffel_parser.y"
				yy_do_action_487
			when 488 then
					--|#line 2697 "et_eiffel_parser.y"
				yy_do_action_488
			when 489 then
					--|#line 2699 "et_eiffel_parser.y"
				yy_do_action_489
			when 490 then
					--|#line 2701 "et_eiffel_parser.y"
				yy_do_action_490
			when 491 then
					--|#line 2703 "et_eiffel_parser.y"
				yy_do_action_491
			when 492 then
					--|#line 2705 "et_eiffel_parser.y"
				yy_do_action_492
			when 493 then
					--|#line 2713 "et_eiffel_parser.y"
				yy_do_action_493
			when 494 then
					--|#line 2723 "et_eiffel_parser.y"
				yy_do_action_494
			when 495 then
					--|#line 2727 "et_eiffel_parser.y"
				yy_do_action_495
			when 496 then
					--|#line 2729 "et_eiffel_parser.y"
				yy_do_action_496
			when 497 then
					--|#line 2733 "et_eiffel_parser.y"
				yy_do_action_497
			when 498 then
					--|#line 2736 "et_eiffel_parser.y"
				yy_do_action_498
			when 499 then
					--|#line 2744 "et_eiffel_parser.y"
				yy_do_action_499
			when 500 then
					--|#line 2751 "et_eiffel_parser.y"
				yy_do_action_500
			when 501 then
					--|#line 2762 "et_eiffel_parser.y"
				yy_do_action_501
			when 502 then
					--|#line 2767 "et_eiffel_parser.y"
				yy_do_action_502
			when 503 then
					--|#line 2772 "et_eiffel_parser.y"
				yy_do_action_503
			when 504 then
					--|#line 2779 "et_eiffel_parser.y"
				yy_do_action_504
			when 505 then
					--|#line 2785 "et_eiffel_parser.y"
				yy_do_action_505
			when 506 then
					--|#line 2794 "et_eiffel_parser.y"
				yy_do_action_506
			when 507 then
					--|#line 2796 "et_eiffel_parser.y"
				yy_do_action_507
			when 508 then
					--|#line 2800 "et_eiffel_parser.y"
				yy_do_action_508
			when 509 then
					--|#line 2803 "et_eiffel_parser.y"
				yy_do_action_509
			when 510 then
					--|#line 2809 "et_eiffel_parser.y"
				yy_do_action_510
			when 511 then
					--|#line 2817 "et_eiffel_parser.y"
				yy_do_action_511
			when 512 then
					--|#line 2822 "et_eiffel_parser.y"
				yy_do_action_512
			when 513 then
					--|#line 2827 "et_eiffel_parser.y"
				yy_do_action_513
			when 514 then
					--|#line 2832 "et_eiffel_parser.y"
				yy_do_action_514
			when 515 then
					--|#line 2843 "et_eiffel_parser.y"
				yy_do_action_515
			when 516 then
					--|#line 2854 "et_eiffel_parser.y"
				yy_do_action_516
			when 517 then
					--|#line 2867 "et_eiffel_parser.y"
				yy_do_action_517
			when 518 then
					--|#line 2876 "et_eiffel_parser.y"
				yy_do_action_518
			when 519 then
					--|#line 2885 "et_eiffel_parser.y"
				yy_do_action_519
			when 520 then
					--|#line 2887 "et_eiffel_parser.y"
				yy_do_action_520
			when 521 then
					--|#line 2889 "et_eiffel_parser.y"
				yy_do_action_521
			when 522 then
					--|#line 2891 "et_eiffel_parser.y"
				yy_do_action_522
			when 523 then
					--|#line 2899 "et_eiffel_parser.y"
				yy_do_action_523
			when 524 then
					--|#line 2907 "et_eiffel_parser.y"
				yy_do_action_524
			when 525 then
					--|#line 2909 "et_eiffel_parser.y"
				yy_do_action_525
			when 526 then
					--|#line 2911 "et_eiffel_parser.y"
				yy_do_action_526
			when 527 then
					--|#line 2913 "et_eiffel_parser.y"
				yy_do_action_527
			when 528 then
					--|#line 2921 "et_eiffel_parser.y"
				yy_do_action_528
			when 529 then
					--|#line 2929 "et_eiffel_parser.y"
				yy_do_action_529
			when 530 then
					--|#line 2933 "et_eiffel_parser.y"
				yy_do_action_530
			when 531 then
					--|#line 2941 "et_eiffel_parser.y"
				yy_do_action_531
			when 532 then
					--|#line 2949 "et_eiffel_parser.y"
				yy_do_action_532
			when 533 then
					--|#line 2957 "et_eiffel_parser.y"
				yy_do_action_533
			when 534 then
					--|#line 2967 "et_eiffel_parser.y"
				yy_do_action_534
			when 535 then
					--|#line 2977 "et_eiffel_parser.y"
				yy_do_action_535
			when 536 then
					--|#line 2989 "et_eiffel_parser.y"
				yy_do_action_536
			when 537 then
					--|#line 2991 "et_eiffel_parser.y"
				yy_do_action_537
			when 538 then
					--|#line 2998 "et_eiffel_parser.y"
				yy_do_action_538
			when 539 then
					--|#line 3000 "et_eiffel_parser.y"
				yy_do_action_539
			when 540 then
					--|#line 3007 "et_eiffel_parser.y"
				yy_do_action_540
			when 541 then
					--|#line 3009 "et_eiffel_parser.y"
				yy_do_action_541
			when 542 then
					--|#line 3016 "et_eiffel_parser.y"
				yy_do_action_542
			when 543 then
					--|#line 3018 "et_eiffel_parser.y"
				yy_do_action_543
			when 544 then
					--|#line 3025 "et_eiffel_parser.y"
				yy_do_action_544
			when 545 then
					--|#line 3027 "et_eiffel_parser.y"
				yy_do_action_545
			when 546 then
					--|#line 3034 "et_eiffel_parser.y"
				yy_do_action_546
			when 547 then
					--|#line 3036 "et_eiffel_parser.y"
				yy_do_action_547
			when 548 then
					--|#line 3043 "et_eiffel_parser.y"
				yy_do_action_548
			when 549 then
					--|#line 3045 "et_eiffel_parser.y"
				yy_do_action_549
			when 550 then
					--|#line 3052 "et_eiffel_parser.y"
				yy_do_action_550
			when 551 then
					--|#line 3063 "et_eiffel_parser.y"
				yy_do_action_551
			when 552 then
					--|#line 3063 "et_eiffel_parser.y"
				yy_do_action_552
			when 553 then
					--|#line 3084 "et_eiffel_parser.y"
				yy_do_action_553
			when 554 then
					--|#line 3086 "et_eiffel_parser.y"
				yy_do_action_554
			when 555 then
					--|#line 3088 "et_eiffel_parser.y"
				yy_do_action_555
			when 556 then
					--|#line 3090 "et_eiffel_parser.y"
				yy_do_action_556
			when 557 then
					--|#line 3092 "et_eiffel_parser.y"
				yy_do_action_557
			when 558 then
					--|#line 3094 "et_eiffel_parser.y"
				yy_do_action_558
			when 559 then
					--|#line 3096 "et_eiffel_parser.y"
				yy_do_action_559
			when 560 then
					--|#line 3098 "et_eiffel_parser.y"
				yy_do_action_560
			when 561 then
					--|#line 3100 "et_eiffel_parser.y"
				yy_do_action_561
			when 562 then
					--|#line 3102 "et_eiffel_parser.y"
				yy_do_action_562
			when 563 then
					--|#line 3104 "et_eiffel_parser.y"
				yy_do_action_563
			when 564 then
					--|#line 3112 "et_eiffel_parser.y"
				yy_do_action_564
			when 565 then
					--|#line 3125 "et_eiffel_parser.y"
				yy_do_action_565
			when 566 then
					--|#line 3127 "et_eiffel_parser.y"
				yy_do_action_566
			when 567 then
					--|#line 3129 "et_eiffel_parser.y"
				yy_do_action_567
			when 568 then
					--|#line 3131 "et_eiffel_parser.y"
				yy_do_action_568
			when 569 then
					--|#line 3133 "et_eiffel_parser.y"
				yy_do_action_569
			when 570 then
					--|#line 3139 "et_eiffel_parser.y"
				yy_do_action_570
			when 571 then
					--|#line 3141 "et_eiffel_parser.y"
				yy_do_action_571
			when 572 then
					--|#line 3143 "et_eiffel_parser.y"
				yy_do_action_572
			when 573 then
					--|#line 3145 "et_eiffel_parser.y"
				yy_do_action_573
			when 574 then
					--|#line 3149 "et_eiffel_parser.y"
				yy_do_action_574
			when 575 then
					--|#line 3151 "et_eiffel_parser.y"
				yy_do_action_575
			when 576 then
					--|#line 3153 "et_eiffel_parser.y"
				yy_do_action_576
			when 577 then
					--|#line 3155 "et_eiffel_parser.y"
				yy_do_action_577
			when 578 then
					--|#line 3159 "et_eiffel_parser.y"
				yy_do_action_578
			when 579 then
					--|#line 3161 "et_eiffel_parser.y"
				yy_do_action_579
			when 580 then
					--|#line 3167 "et_eiffel_parser.y"
				yy_do_action_580
			when 581 then
					--|#line 3169 "et_eiffel_parser.y"
				yy_do_action_581
			when 582 then
					--|#line 3171 "et_eiffel_parser.y"
				yy_do_action_582
			when 583 then
					--|#line 3173 "et_eiffel_parser.y"
				yy_do_action_583
			when 584 then
					--|#line 3177 "et_eiffel_parser.y"
				yy_do_action_584
			when 585 then
					--|#line 3184 "et_eiffel_parser.y"
				yy_do_action_585
			when 586 then
					--|#line 3191 "et_eiffel_parser.y"
				yy_do_action_586
			when 587 then
					--|#line 3200 "et_eiffel_parser.y"
				yy_do_action_587
			when 588 then
					--|#line 3211 "et_eiffel_parser.y"
				yy_do_action_588
			when 589 then
					--|#line 3213 "et_eiffel_parser.y"
				yy_do_action_589
			when 590 then
					--|#line 3217 "et_eiffel_parser.y"
				yy_do_action_590
			when 591 then
					--|#line 3219 "et_eiffel_parser.y"
				yy_do_action_591
			when 592 then
					--|#line 3226 "et_eiffel_parser.y"
				yy_do_action_592
			when 593 then
					--|#line 3233 "et_eiffel_parser.y"
				yy_do_action_593
			when 594 then
					--|#line 3242 "et_eiffel_parser.y"
				yy_do_action_594
			when 595 then
					--|#line 3251 "et_eiffel_parser.y"
				yy_do_action_595
			when 596 then
					--|#line 3253 "et_eiffel_parser.y"
				yy_do_action_596
			when 597 then
					--|#line 3253 "et_eiffel_parser.y"
				yy_do_action_597
			when 598 then
					--|#line 3266 "et_eiffel_parser.y"
				yy_do_action_598
			when 599 then
					--|#line 3277 "et_eiffel_parser.y"
				yy_do_action_599
			when 600 then
					--|#line 3285 "et_eiffel_parser.y"
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
					--|#line 3294 "et_eiffel_parser.y"
				yy_do_action_601
			when 602 then
					--|#line 3303 "et_eiffel_parser.y"
				yy_do_action_602
			when 603 then
					--|#line 3305 "et_eiffel_parser.y"
				yy_do_action_603
			when 604 then
					--|#line 3309 "et_eiffel_parser.y"
				yy_do_action_604
			when 605 then
					--|#line 3311 "et_eiffel_parser.y"
				yy_do_action_605
			when 606 then
					--|#line 3313 "et_eiffel_parser.y"
				yy_do_action_606
			when 607 then
					--|#line 3315 "et_eiffel_parser.y"
				yy_do_action_607
			when 608 then
					--|#line 3321 "et_eiffel_parser.y"
				yy_do_action_608
			when 609 then
					--|#line 3323 "et_eiffel_parser.y"
				yy_do_action_609
			when 610 then
					--|#line 3330 "et_eiffel_parser.y"
				yy_do_action_610
			when 611 then
					--|#line 3332 "et_eiffel_parser.y"
				yy_do_action_611
			when 612 then
					--|#line 3334 "et_eiffel_parser.y"
				yy_do_action_612
			when 613 then
					--|#line 3334 "et_eiffel_parser.y"
				yy_do_action_613
			when 614 then
					--|#line 3347 "et_eiffel_parser.y"
				yy_do_action_614
			when 615 then
					--|#line 3358 "et_eiffel_parser.y"
				yy_do_action_615
			when 616 then
					--|#line 3367 "et_eiffel_parser.y"
				yy_do_action_616
			when 617 then
					--|#line 3378 "et_eiffel_parser.y"
				yy_do_action_617
			when 618 then
					--|#line 3380 "et_eiffel_parser.y"
				yy_do_action_618
			when 619 then
					--|#line 3382 "et_eiffel_parser.y"
				yy_do_action_619
			when 620 then
					--|#line 3384 "et_eiffel_parser.y"
				yy_do_action_620
			when 621 then
					--|#line 3386 "et_eiffel_parser.y"
				yy_do_action_621
			when 622 then
					--|#line 3388 "et_eiffel_parser.y"
				yy_do_action_622
			when 623 then
					--|#line 3392 "et_eiffel_parser.y"
				yy_do_action_623
			when 624 then
					--|#line 3394 "et_eiffel_parser.y"
				yy_do_action_624
			when 625 then
					--|#line 3398 "et_eiffel_parser.y"
				yy_do_action_625
			when 626 then
					--|#line 3402 "et_eiffel_parser.y"
				yy_do_action_626
			when 627 then
					--|#line 3404 "et_eiffel_parser.y"
				yy_do_action_627
			when 628 then
					--|#line 3408 "et_eiffel_parser.y"
				yy_do_action_628
			when 629 then
					--|#line 3410 "et_eiffel_parser.y"
				yy_do_action_629
			when 630 then
					--|#line 3414 "et_eiffel_parser.y"
				yy_do_action_630
			when 631 then
					--|#line 3416 "et_eiffel_parser.y"
				yy_do_action_631
			when 632 then
					--|#line 3418 "et_eiffel_parser.y"
				yy_do_action_632
			when 633 then
					--|#line 3420 "et_eiffel_parser.y"
				yy_do_action_633
			when 634 then
					--|#line 3422 "et_eiffel_parser.y"
				yy_do_action_634
			when 635 then
					--|#line 3424 "et_eiffel_parser.y"
				yy_do_action_635
			when 636 then
					--|#line 3432 "et_eiffel_parser.y"
				yy_do_action_636
			when 637 then
					--|#line 3434 "et_eiffel_parser.y"
				yy_do_action_637
			when 638 then
					--|#line 3440 "et_eiffel_parser.y"
				yy_do_action_638
			when 639 then
					--|#line 3442 "et_eiffel_parser.y"
				yy_do_action_639
			when 640 then
					--|#line 3444 "et_eiffel_parser.y"
				yy_do_action_640
			when 641 then
					--|#line 3444 "et_eiffel_parser.y"
				yy_do_action_641
			when 642 then
					--|#line 3457 "et_eiffel_parser.y"
				yy_do_action_642
			when 643 then
					--|#line 3468 "et_eiffel_parser.y"
				yy_do_action_643
			when 644 then
					--|#line 3476 "et_eiffel_parser.y"
				yy_do_action_644
			when 645 then
					--|#line 3485 "et_eiffel_parser.y"
				yy_do_action_645
			when 646 then
					--|#line 3494 "et_eiffel_parser.y"
				yy_do_action_646
			when 647 then
					--|#line 3496 "et_eiffel_parser.y"
				yy_do_action_647
			when 648 then
					--|#line 3498 "et_eiffel_parser.y"
				yy_do_action_648
			when 649 then
					--|#line 3500 "et_eiffel_parser.y"
				yy_do_action_649
			when 650 then
					--|#line 3507 "et_eiffel_parser.y"
				yy_do_action_650
			when 651 then
					--|#line 3509 "et_eiffel_parser.y"
				yy_do_action_651
			when 652 then
					--|#line 3515 "et_eiffel_parser.y"
				yy_do_action_652
			when 653 then
					--|#line 3517 "et_eiffel_parser.y"
				yy_do_action_653
			when 654 then
					--|#line 3521 "et_eiffel_parser.y"
				yy_do_action_654
			when 655 then
					--|#line 3523 "et_eiffel_parser.y"
				yy_do_action_655
			when 656 then
					--|#line 3525 "et_eiffel_parser.y"
				yy_do_action_656
			when 657 then
					--|#line 3527 "et_eiffel_parser.y"
				yy_do_action_657
			when 658 then
					--|#line 3529 "et_eiffel_parser.y"
				yy_do_action_658
			when 659 then
					--|#line 3531 "et_eiffel_parser.y"
				yy_do_action_659
			when 660 then
					--|#line 3533 "et_eiffel_parser.y"
				yy_do_action_660
			when 661 then
					--|#line 3535 "et_eiffel_parser.y"
				yy_do_action_661
			when 662 then
					--|#line 3537 "et_eiffel_parser.y"
				yy_do_action_662
			when 663 then
					--|#line 3539 "et_eiffel_parser.y"
				yy_do_action_663
			when 664 then
					--|#line 3541 "et_eiffel_parser.y"
				yy_do_action_664
			when 665 then
					--|#line 3543 "et_eiffel_parser.y"
				yy_do_action_665
			when 666 then
					--|#line 3545 "et_eiffel_parser.y"
				yy_do_action_666
			when 667 then
					--|#line 3547 "et_eiffel_parser.y"
				yy_do_action_667
			when 668 then
					--|#line 3549 "et_eiffel_parser.y"
				yy_do_action_668
			when 669 then
					--|#line 3551 "et_eiffel_parser.y"
				yy_do_action_669
			when 670 then
					--|#line 3553 "et_eiffel_parser.y"
				yy_do_action_670
			when 671 then
					--|#line 3555 "et_eiffel_parser.y"
				yy_do_action_671
			when 672 then
					--|#line 3557 "et_eiffel_parser.y"
				yy_do_action_672
			when 673 then
					--|#line 3559 "et_eiffel_parser.y"
				yy_do_action_673
			when 674 then
					--|#line 3561 "et_eiffel_parser.y"
				yy_do_action_674
			when 675 then
					--|#line 3563 "et_eiffel_parser.y"
				yy_do_action_675
			when 676 then
					--|#line 3567 "et_eiffel_parser.y"
				yy_do_action_676
			when 677 then
					--|#line 3569 "et_eiffel_parser.y"
				yy_do_action_677
			when 678 then
					--|#line 3571 "et_eiffel_parser.y"
				yy_do_action_678
			when 679 then
					--|#line 3573 "et_eiffel_parser.y"
				yy_do_action_679
			when 680 then
					--|#line 3577 "et_eiffel_parser.y"
				yy_do_action_680
			when 681 then
					--|#line 3579 "et_eiffel_parser.y"
				yy_do_action_681
			when 682 then
					--|#line 3581 "et_eiffel_parser.y"
				yy_do_action_682
			when 683 then
					--|#line 3583 "et_eiffel_parser.y"
				yy_do_action_683
			when 684 then
					--|#line 3585 "et_eiffel_parser.y"
				yy_do_action_684
			when 685 then
					--|#line 3587 "et_eiffel_parser.y"
				yy_do_action_685
			when 686 then
					--|#line 3589 "et_eiffel_parser.y"
				yy_do_action_686
			when 687 then
					--|#line 3591 "et_eiffel_parser.y"
				yy_do_action_687
			when 688 then
					--|#line 3593 "et_eiffel_parser.y"
				yy_do_action_688
			when 689 then
					--|#line 3595 "et_eiffel_parser.y"
				yy_do_action_689
			when 690 then
					--|#line 3597 "et_eiffel_parser.y"
				yy_do_action_690
			when 691 then
					--|#line 3599 "et_eiffel_parser.y"
				yy_do_action_691
			when 692 then
					--|#line 3607 "et_eiffel_parser.y"
				yy_do_action_692
			when 693 then
					--|#line 3609 "et_eiffel_parser.y"
				yy_do_action_693
			when 694 then
					--|#line 3611 "et_eiffel_parser.y"
				yy_do_action_694
			when 695 then
					--|#line 3613 "et_eiffel_parser.y"
				yy_do_action_695
			when 696 then
					--|#line 3617 "et_eiffel_parser.y"
				yy_do_action_696
			when 697 then
					--|#line 3619 "et_eiffel_parser.y"
				yy_do_action_697
			when 698 then
					--|#line 3621 "et_eiffel_parser.y"
				yy_do_action_698
			when 699 then
					--|#line 3623 "et_eiffel_parser.y"
				yy_do_action_699
			when 700 then
					--|#line 3625 "et_eiffel_parser.y"
				yy_do_action_700
			when 701 then
					--|#line 3627 "et_eiffel_parser.y"
				yy_do_action_701
			when 702 then
					--|#line 3629 "et_eiffel_parser.y"
				yy_do_action_702
			when 703 then
					--|#line 3631 "et_eiffel_parser.y"
				yy_do_action_703
			when 704 then
					--|#line 3633 "et_eiffel_parser.y"
				yy_do_action_704
			when 705 then
					--|#line 3635 "et_eiffel_parser.y"
				yy_do_action_705
			when 706 then
					--|#line 3637 "et_eiffel_parser.y"
				yy_do_action_706
			when 707 then
					--|#line 3639 "et_eiffel_parser.y"
				yy_do_action_707
			when 708 then
					--|#line 3641 "et_eiffel_parser.y"
				yy_do_action_708
			when 709 then
					--|#line 3656 "et_eiffel_parser.y"
				yy_do_action_709
			when 710 then
					--|#line 3658 "et_eiffel_parser.y"
				yy_do_action_710
			when 711 then
					--|#line 3660 "et_eiffel_parser.y"
				yy_do_action_711
			when 712 then
					--|#line 3662 "et_eiffel_parser.y"
				yy_do_action_712
			when 713 then
					--|#line 3666 "et_eiffel_parser.y"
				yy_do_action_713
			when 714 then
					--|#line 3666 "et_eiffel_parser.y"
				yy_do_action_714
			when 715 then
					--|#line 3679 "et_eiffel_parser.y"
				yy_do_action_715
			when 716 then
					--|#line 3690 "et_eiffel_parser.y"
				yy_do_action_716
			when 717 then
					--|#line 3698 "et_eiffel_parser.y"
				yy_do_action_717
			when 718 then
					--|#line 3707 "et_eiffel_parser.y"
				yy_do_action_718
			when 719 then
					--|#line 3715 "et_eiffel_parser.y"
				yy_do_action_719
			when 720 then
					--|#line 3717 "et_eiffel_parser.y"
				yy_do_action_720
			when 721 then
					--|#line 3717 "et_eiffel_parser.y"
				yy_do_action_721
			when 722 then
					--|#line 3730 "et_eiffel_parser.y"
				yy_do_action_722
			when 723 then
					--|#line 3741 "et_eiffel_parser.y"
				yy_do_action_723
			when 724 then
					--|#line 3749 "et_eiffel_parser.y"
				yy_do_action_724
			when 725 then
					--|#line 3758 "et_eiffel_parser.y"
				yy_do_action_725
			when 726 then
					--|#line 3760 "et_eiffel_parser.y"
				yy_do_action_726
			when 727 then
					--|#line 3760 "et_eiffel_parser.y"
				yy_do_action_727
			when 728 then
					--|#line 3773 "et_eiffel_parser.y"
				yy_do_action_728
			when 729 then
					--|#line 3784 "et_eiffel_parser.y"
				yy_do_action_729
			when 730 then
					--|#line 3792 "et_eiffel_parser.y"
				yy_do_action_730
			when 731 then
					--|#line 3801 "et_eiffel_parser.y"
				yy_do_action_731
			when 732 then
					--|#line 3803 "et_eiffel_parser.y"
				yy_do_action_732
			when 733 then
					--|#line 3803 "et_eiffel_parser.y"
				yy_do_action_733
			when 734 then
					--|#line 3818 "et_eiffel_parser.y"
				yy_do_action_734
			when 735 then
					--|#line 3829 "et_eiffel_parser.y"
				yy_do_action_735
			when 736 then
					--|#line 3837 "et_eiffel_parser.y"
				yy_do_action_736
			when 737 then
					--|#line 3846 "et_eiffel_parser.y"
				yy_do_action_737
			when 738 then
					--|#line 3848 "et_eiffel_parser.y"
				yy_do_action_738
			when 739 then
					--|#line 3850 "et_eiffel_parser.y"
				yy_do_action_739
			when 740 then
					--|#line 3852 "et_eiffel_parser.y"
				yy_do_action_740
			when 741 then
					--|#line 3854 "et_eiffel_parser.y"
				yy_do_action_741
			when 742 then
					--|#line 3856 "et_eiffel_parser.y"
				yy_do_action_742
			when 743 then
					--|#line 3862 "et_eiffel_parser.y"
				yy_do_action_743
			when 744 then
					--|#line 3864 "et_eiffel_parser.y"
				yy_do_action_744
			when 745 then
					--|#line 3868 "et_eiffel_parser.y"
				yy_do_action_745
			when 746 then
					--|#line 3879 "et_eiffel_parser.y"
				yy_do_action_746
			when 747 then
					--|#line 3886 "et_eiffel_parser.y"
				yy_do_action_747
			when 748 then
					--|#line 3893 "et_eiffel_parser.y"
				yy_do_action_748
			when 749 then
					--|#line 3900 "et_eiffel_parser.y"
				yy_do_action_749
			when 750 then
					--|#line 3907 "et_eiffel_parser.y"
				yy_do_action_750
			when 751 then
					--|#line 3914 "et_eiffel_parser.y"
				yy_do_action_751
			when 752 then
					--|#line 3921 "et_eiffel_parser.y"
				yy_do_action_752
			when 753 then
					--|#line 3928 "et_eiffel_parser.y"
				yy_do_action_753
			when 754 then
					--|#line 3935 "et_eiffel_parser.y"
				yy_do_action_754
			when 755 then
					--|#line 3942 "et_eiffel_parser.y"
				yy_do_action_755
			when 756 then
					--|#line 3949 "et_eiffel_parser.y"
				yy_do_action_756
			when 757 then
					--|#line 3958 "et_eiffel_parser.y"
				yy_do_action_757
			when 758 then
					--|#line 3965 "et_eiffel_parser.y"
				yy_do_action_758
			when 759 then
					--|#line 3969 "et_eiffel_parser.y"
				yy_do_action_759
			when 760 then
					--|#line 3981 "et_eiffel_parser.y"
				yy_do_action_760
			when 761 then
					--|#line 3983 "et_eiffel_parser.y"
				yy_do_action_761
			when 762 then
					--|#line 3985 "et_eiffel_parser.y"
				yy_do_action_762
			when 763 then
					--|#line 3987 "et_eiffel_parser.y"
				yy_do_action_763
			when 764 then
					--|#line 3989 "et_eiffel_parser.y"
				yy_do_action_764
			when 765 then
					--|#line 3993 "et_eiffel_parser.y"
				yy_do_action_765
			when 766 then
					--|#line 3995 "et_eiffel_parser.y"
				yy_do_action_766
			when 767 then
					--|#line 3997 "et_eiffel_parser.y"
				yy_do_action_767
			when 768 then
					--|#line 3997 "et_eiffel_parser.y"
				yy_do_action_768
			when 769 then
					--|#line 4010 "et_eiffel_parser.y"
				yy_do_action_769
			when 770 then
					--|#line 4021 "et_eiffel_parser.y"
				yy_do_action_770
			when 771 then
					--|#line 4029 "et_eiffel_parser.y"
				yy_do_action_771
			when 772 then
					--|#line 4038 "et_eiffel_parser.y"
				yy_do_action_772
			when 773 then
					--|#line 4047 "et_eiffel_parser.y"
				yy_do_action_773
			when 774 then
					--|#line 4049 "et_eiffel_parser.y"
				yy_do_action_774
			when 775 then
					--|#line 4051 "et_eiffel_parser.y"
				yy_do_action_775
			when 776 then
					--|#line 4057 "et_eiffel_parser.y"
				yy_do_action_776
			when 777 then
					--|#line 4059 "et_eiffel_parser.y"
				yy_do_action_777
			when 778 then
					--|#line 4061 "et_eiffel_parser.y"
				yy_do_action_778
			when 779 then
					--|#line 4063 "et_eiffel_parser.y"
				yy_do_action_779
			when 780 then
					--|#line 4065 "et_eiffel_parser.y"
				yy_do_action_780
			when 781 then
					--|#line 4067 "et_eiffel_parser.y"
				yy_do_action_781
			when 782 then
					--|#line 4069 "et_eiffel_parser.y"
				yy_do_action_782
			when 783 then
					--|#line 4071 "et_eiffel_parser.y"
				yy_do_action_783
			when 784 then
					--|#line 4073 "et_eiffel_parser.y"
				yy_do_action_784
			when 785 then
					--|#line 4075 "et_eiffel_parser.y"
				yy_do_action_785
			when 786 then
					--|#line 4077 "et_eiffel_parser.y"
				yy_do_action_786
			when 787 then
					--|#line 4079 "et_eiffel_parser.y"
				yy_do_action_787
			when 788 then
					--|#line 4081 "et_eiffel_parser.y"
				yy_do_action_788
			when 789 then
					--|#line 4083 "et_eiffel_parser.y"
				yy_do_action_789
			when 790 then
					--|#line 4085 "et_eiffel_parser.y"
				yy_do_action_790
			when 791 then
					--|#line 4087 "et_eiffel_parser.y"
				yy_do_action_791
			when 792 then
					--|#line 4089 "et_eiffel_parser.y"
				yy_do_action_792
			when 793 then
					--|#line 4091 "et_eiffel_parser.y"
				yy_do_action_793
			when 794 then
					--|#line 4093 "et_eiffel_parser.y"
				yy_do_action_794
			when 795 then
					--|#line 4095 "et_eiffel_parser.y"
				yy_do_action_795
			when 796 then
					--|#line 4097 "et_eiffel_parser.y"
				yy_do_action_796
			when 797 then
					--|#line 4099 "et_eiffel_parser.y"
				yy_do_action_797
			when 798 then
					--|#line 4101 "et_eiffel_parser.y"
				yy_do_action_798
			when 799 then
					--|#line 4105 "et_eiffel_parser.y"
				yy_do_action_799
			when 800 then
					--|#line 4107 "et_eiffel_parser.y"
				yy_do_action_800
			else
				debug ("GEYACC")
					std.error.put_string ("Error in parser: unknown rule id: ")
					std.error.put_integer (yy_act)
					std.error.put_new_line
				end
				abort
			end
		end

	yy_do_action_801_1000 (yy_act: INTEGER) is
			-- Execute semantic action.
		do
			inspect yy_act
			when 801 then
					--|#line 4111 "et_eiffel_parser.y"
				yy_do_action_801
			when 802 then
					--|#line 4113 "et_eiffel_parser.y"
				yy_do_action_802
			when 803 then
					--|#line 4117 "et_eiffel_parser.y"
				yy_do_action_803
			when 804 then
					--|#line 4119 "et_eiffel_parser.y"
				yy_do_action_804
			when 805 then
					--|#line 4123 "et_eiffel_parser.y"
				yy_do_action_805
			when 806 then
					--|#line 4125 "et_eiffel_parser.y"
				yy_do_action_806
			when 807 then
					--|#line 4129 "et_eiffel_parser.y"
				yy_do_action_807
			when 808 then
					--|#line 4134 "et_eiffel_parser.y"
				yy_do_action_808
			when 809 then
					--|#line 4141 "et_eiffel_parser.y"
				yy_do_action_809
			when 810 then
					--|#line 4148 "et_eiffel_parser.y"
				yy_do_action_810
			when 811 then
					--|#line 4150 "et_eiffel_parser.y"
				yy_do_action_811
			when 812 then
					--|#line 4154 "et_eiffel_parser.y"
				yy_do_action_812
			when 813 then
					--|#line 4156 "et_eiffel_parser.y"
				yy_do_action_813
			when 814 then
					--|#line 4160 "et_eiffel_parser.y"
				yy_do_action_814
			when 815 then
					--|#line 4165 "et_eiffel_parser.y"
				yy_do_action_815
			when 816 then
					--|#line 4172 "et_eiffel_parser.y"
				yy_do_action_816
			when 817 then
					--|#line 4179 "et_eiffel_parser.y"
				yy_do_action_817
			when 818 then
					--|#line 4181 "et_eiffel_parser.y"
				yy_do_action_818
			when 819 then
					--|#line 4183 "et_eiffel_parser.y"
				yy_do_action_819
			when 820 then
					--|#line 4192 "et_eiffel_parser.y"
				yy_do_action_820
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
			--|#line 223 "et_eiffel_parser.y"
		local
			yyval1: ANY
		do
--|#line 223 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 223")
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
			--|#line 227 "et_eiffel_parser.y"
		local
			yyval1: ANY
		do
--|#line 227 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 227")
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
			--|#line 235 "et_eiffel_parser.y"
		local
			yyval42: ET_CLASS
		do
--|#line 235 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 235")
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
			--|#line 244 "et_eiffel_parser.y"
		local
			yyval1: ANY
		do
--|#line 244 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 244")
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
			--|#line 245 "et_eiffel_parser.y"
		local
			yyval1: ANY
		do
--|#line 245 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 245")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp42 := yyvsp42 -1
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_6 is
			--|#line 245 "et_eiffel_parser.y"
		local
			yyval1: ANY
		do
--|#line 245 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 245")
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
			--|#line 256 "et_eiffel_parser.y"
		local
			yyval42: ET_CLASS
		do
--|#line 256 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 256")
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
			--|#line 262 "et_eiffel_parser.y"
		local
			yyval42: ET_CLASS
		do
--|#line 262 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 262")
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
			--|#line 268 "et_eiffel_parser.y"
		local
			yyval42: ET_CLASS
		do
--|#line 268 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 268")
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
			--|#line 274 "et_eiffel_parser.y"
		local
			yyval42: ET_CLASS
		do
--|#line 274 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 274")
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
			--|#line 280 "et_eiffel_parser.y"
		local
			yyval42: ET_CLASS
		do
--|#line 280 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 280")
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
			--|#line 286 "et_eiffel_parser.y"
		local
			yyval42: ET_CLASS
		do
--|#line 286 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 286")
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
			--|#line 286 "et_eiffel_parser.y"
		local
			yyval42: ET_CLASS
		do
--|#line 286 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 286")
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
			--|#line 302 "et_eiffel_parser.y"
		local
			yyval42: ET_CLASS
		do
--|#line 302 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 302")
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
			--|#line 307 "et_eiffel_parser.y"
		local
			yyval42: ET_CLASS
		do
--|#line 307 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 307")
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
			--|#line 322 "et_eiffel_parser.y"
		local
			yyval1: ANY
		do
--|#line 322 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 322")
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
			--|#line 327 "et_eiffel_parser.y"
		local
			yyval78: ET_INDEXING_LIST
		do
--|#line 327 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 327")
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
			--|#line 329 "et_eiffel_parser.y"
		local
			yyval78: ET_INDEXING_LIST
		do
--|#line 329 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 329")
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
			--|#line 329 "et_eiffel_parser.y"
		local
			yyval78: ET_INDEXING_LIST
		do
--|#line 329 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 329")
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
			--|#line 340 "et_eiffel_parser.y"
		local
			yyval78: ET_INDEXING_LIST
		do
--|#line 340 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 340")
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
			--|#line 342 "et_eiffel_parser.y"
		local
			yyval78: ET_INDEXING_LIST
		do
--|#line 342 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 342")
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
			--|#line 342 "et_eiffel_parser.y"
		local
			yyval78: ET_INDEXING_LIST
		do
--|#line 342 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 342")
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
			--|#line 355 "et_eiffel_parser.y"
		local
			yyval78: ET_INDEXING_LIST
		do
--|#line 355 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 355")
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
			--|#line 357 "et_eiffel_parser.y"
		local
			yyval78: ET_INDEXING_LIST
		do
--|#line 357 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 357")
end

yyval78 := yyvs78.item (yyvsp78) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs78.put (yyval78, yyvsp78)
end
		end

	yy_do_action_25 is
			--|#line 361 "et_eiffel_parser.y"
		local
			yyval78: ET_INDEXING_LIST
		do
--|#line 361 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 361")
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
			--|#line 372 "et_eiffel_parser.y"
		local
			yyval78: ET_INDEXING_LIST
		do
--|#line 372 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 372")
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
			--|#line 372 "et_eiffel_parser.y"
		local
			yyval78: ET_INDEXING_LIST
		do
--|#line 372 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 372")
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
			--|#line 381 "et_eiffel_parser.y"
		local
			yyval78: ET_INDEXING_LIST
		do
--|#line 381 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 381")
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
			--|#line 381 "et_eiffel_parser.y"
		local
			yyval78: ET_INDEXING_LIST
		do
--|#line 381 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 381")
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
			--|#line 392 "et_eiffel_parser.y"
		local
			yyval79: ET_INDEXING_ITEM
		do
--|#line 392 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 392")
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
			--|#line 399 "et_eiffel_parser.y"
		local
			yyval79: ET_INDEXING_ITEM
		do
--|#line 399 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 399")
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
			--|#line 405 "et_eiffel_parser.y"
		local
			yyval79: ET_INDEXING_ITEM
		do
--|#line 405 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 405")
end

yyval79 := ast_factory.new_indexing_semicolon (yyvs79.item (yyvsp79), yyvs22.item (yyvsp22)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp22 := yyvsp22 -1
	yyvs79.put (yyval79, yyvsp79)
end
		end

	yy_do_action_33 is
			--|#line 409 "et_eiffel_parser.y"
		local
			yyval78: ET_INDEXING_LIST
		do
--|#line 409 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 409")
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
			--|#line 420 "et_eiffel_parser.y"
		local
			yyval78: ET_INDEXING_LIST
		do
--|#line 420 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 420")
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
			--|#line 432 "et_eiffel_parser.y"
		local
			yyval78: ET_INDEXING_LIST
		do
--|#line 432 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 432")
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
			--|#line 432 "et_eiffel_parser.y"
		local
			yyval78: ET_INDEXING_LIST
		do
--|#line 432 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 432")
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
			--|#line 441 "et_eiffel_parser.y"
		local
			yyval78: ET_INDEXING_LIST
		do
--|#line 441 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 441")
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
			--|#line 441 "et_eiffel_parser.y"
		local
			yyval78: ET_INDEXING_LIST
		do
--|#line 441 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 441")
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
			--|#line 452 "et_eiffel_parser.y"
		local
			yyval79: ET_INDEXING_ITEM
		do
--|#line 452 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 452")
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
			--|#line 459 "et_eiffel_parser.y"
		local
			yyval79: ET_INDEXING_ITEM
		do
--|#line 459 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 459")
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
			--|#line 463 "et_eiffel_parser.y"
		local
			yyval79: ET_INDEXING_ITEM
		do
--|#line 463 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 463")
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
			--|#line 469 "et_eiffel_parser.y"
		local
			yyval79: ET_INDEXING_ITEM
		do
--|#line 469 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 469")
end

yyval79 := ast_factory.new_indexing_semicolon (yyvs79.item (yyvsp79), yyvs22.item (yyvsp22)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp22 := yyvsp22 -1
	yyvs79.put (yyval79, yyvsp79)
end
		end

	yy_do_action_43 is
			--|#line 471 "et_eiffel_parser.y"
		local
			yyval79: ET_INDEXING_ITEM
		do
--|#line 471 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 471")
end

yyval79 := ast_factory.new_indexing_semicolon (yyvs79.item (yyvsp79), yyvs22.item (yyvsp22)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp22 := yyvsp22 -1
	yyvs79.put (yyval79, yyvsp79)
end
		end

	yy_do_action_44 is
			--|#line 476 "et_eiffel_parser.y"
		local
			yyval82: ET_INDEXING_TERM_LIST
		do
--|#line 476 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 476")
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
			--|#line 487 "et_eiffel_parser.y"
		local
			yyval82: ET_INDEXING_TERM_LIST
		do
--|#line 487 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 487")
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
			--|#line 496 "et_eiffel_parser.y"
		local
			yyval80: ET_INDEXING_TERM
		do
--|#line 496 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 496")
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
			--|#line 498 "et_eiffel_parser.y"
		local
			yyval80: ET_INDEXING_TERM
		do
--|#line 498 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 498")
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
			--|#line 500 "et_eiffel_parser.y"
		local
			yyval80: ET_INDEXING_TERM
		do
--|#line 500 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 500")
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
			--|#line 502 "et_eiffel_parser.y"
		local
			yyval80: ET_INDEXING_TERM
		do
--|#line 502 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 502")
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
			--|#line 504 "et_eiffel_parser.y"
		local
			yyval80: ET_INDEXING_TERM
		do
--|#line 504 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 504")
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
			--|#line 506 "et_eiffel_parser.y"
		local
			yyval80: ET_INDEXING_TERM
		do
--|#line 506 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 506")
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
			--|#line 508 "et_eiffel_parser.y"
		local
			yyval80: ET_INDEXING_TERM
		do
--|#line 508 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 508")
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
			--|#line 510 "et_eiffel_parser.y"
		local
			yyval80: ET_INDEXING_TERM
		do
--|#line 510 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 510")
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
			--|#line 512 "et_eiffel_parser.y"
		local
			yyval80: ET_INDEXING_TERM
		do
--|#line 512 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 512")
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
			--|#line 516 "et_eiffel_parser.y"
		local
			yyval81: ET_INDEXING_TERM_ITEM
		do
--|#line 516 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 516")
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
			--|#line 527 "et_eiffel_parser.y"
		local
			yyval42: ET_CLASS
		do
--|#line 527 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 527")
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
			--|#line 537 "et_eiffel_parser.y"
		local
			yyval42: ET_CLASS
		do
--|#line 537 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 537")
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
			--|#line 548 "et_eiffel_parser.y"
		local
			yyval42: ET_CLASS
		do
--|#line 548 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 548")
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
			--|#line 559 "et_eiffel_parser.y"
		local
			yyval42: ET_CLASS
		do
--|#line 559 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 559")
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
			--|#line 572 "et_eiffel_parser.y"
		local
			yyval2: ET_KEYWORD
		do
--|#line 572 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 572")
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
			--|#line 574 "et_eiffel_parser.y"
		local
			yyval2: ET_KEYWORD
		do
--|#line 574 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 574")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
		end

	yy_do_action_62 is
			--|#line 578 "et_eiffel_parser.y"
		local
			yyval2: ET_KEYWORD
		do
--|#line 578 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 578")
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
			--|#line 580 "et_eiffel_parser.y"
		local
			yyval2: ET_KEYWORD
		do
--|#line 580 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 580")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
		end

	yy_do_action_64 is
			--|#line 586 "et_eiffel_parser.y"
		local
			yyval76: ET_FORMAL_PARAMETER_LIST
		do
--|#line 586 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 586")
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
			--|#line 590 "et_eiffel_parser.y"
		local
			yyval76: ET_FORMAL_PARAMETER_LIST
		do
--|#line 590 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 590")
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
			--|#line 596 "et_eiffel_parser.y"
		local
			yyval76: ET_FORMAL_PARAMETER_LIST
		do
--|#line 596 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 596")
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
			--|#line 596 "et_eiffel_parser.y"
		local
			yyval76: ET_FORMAL_PARAMETER_LIST
		do
--|#line 596 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 596")
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
			--|#line 610 "et_eiffel_parser.y"
		local
			yyval76: ET_FORMAL_PARAMETER_LIST
		do
--|#line 610 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 610")
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
			--|#line 621 "et_eiffel_parser.y"
		local
			yyval76: ET_FORMAL_PARAMETER_LIST
		do
--|#line 621 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 621")
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
			--|#line 630 "et_eiffel_parser.y"
		local
			yyval75: ET_FORMAL_PARAMETER_ITEM
		do
--|#line 630 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 630")
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
			--|#line 639 "et_eiffel_parser.y"
		local
			yyval74: ET_FORMAL_PARAMETER
		do
--|#line 639 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 639")
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
			--|#line 646 "et_eiffel_parser.y"
		local
			yyval74: ET_FORMAL_PARAMETER
		do
--|#line 646 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 646")
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
			--|#line 653 "et_eiffel_parser.y"
		local
			yyval74: ET_FORMAL_PARAMETER
		do
--|#line 653 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 653")
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
			--|#line 660 "et_eiffel_parser.y"
		local
			yyval74: ET_FORMAL_PARAMETER
		do
--|#line 660 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 660")
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
			--|#line 667 "et_eiffel_parser.y"
		local
			yyval74: ET_FORMAL_PARAMETER
		do
--|#line 667 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 667")
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
			--|#line 674 "et_eiffel_parser.y"
		local
			yyval74: ET_FORMAL_PARAMETER
		do
--|#line 674 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 674")
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
			--|#line 681 "et_eiffel_parser.y"
		local
			yyval74: ET_FORMAL_PARAMETER
		do
--|#line 681 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 681")
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
			--|#line 688 "et_eiffel_parser.y"
		local
			yyval74: ET_FORMAL_PARAMETER
		do
--|#line 688 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 688")
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
			--|#line 695 "et_eiffel_parser.y"
		local
			yyval74: ET_FORMAL_PARAMETER
		do
--|#line 695 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 695")
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
			--|#line 704 "et_eiffel_parser.y"
		local
			yyval49: ET_CONSTRAINT_CREATOR
		do
--|#line 704 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 704")
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
			--|#line 706 "et_eiffel_parser.y"
		local
			yyval49: ET_CONSTRAINT_CREATOR
		do
--|#line 706 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 706")
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
			--|#line 706 "et_eiffel_parser.y"
		local
			yyval49: ET_CONSTRAINT_CREATOR
		do
--|#line 706 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 706")
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
			--|#line 719 "et_eiffel_parser.y"
		local
			yyval49: ET_CONSTRAINT_CREATOR
		do
--|#line 719 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 719")
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
			--|#line 730 "et_eiffel_parser.y"
		local
			yyval49: ET_CONSTRAINT_CREATOR
		do
--|#line 730 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 730")
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
			--|#line 738 "et_eiffel_parser.y"
		local
			yyval49: ET_CONSTRAINT_CREATOR
		do
--|#line 738 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 738")
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
			--|#line 747 "et_eiffel_parser.y"
		local
			yyval50: ET_CONSTRAINT_TYPE
		do
--|#line 747 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 747")
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
			--|#line 749 "et_eiffel_parser.y"
		local
			yyval50: ET_CONSTRAINT_TYPE
		do
--|#line 749 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 749")
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
			--|#line 751 "et_eiffel_parser.y"
		local
			yyval50: ET_CONSTRAINT_TYPE
		do
--|#line 751 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 751")
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
			--|#line 753 "et_eiffel_parser.y"
		local
			yyval50: ET_CONSTRAINT_TYPE
		do
--|#line 753 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 753")
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
			--|#line 755 "et_eiffel_parser.y"
		local
			yyval50: ET_CONSTRAINT_TYPE
		do
--|#line 755 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 755")
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

	yy_do_action_91 is
			--|#line 757 "et_eiffel_parser.y"
		local
			yyval50: ET_CONSTRAINT_TYPE
		do
--|#line 757 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 757")
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

	yy_do_action_92 is
			--|#line 759 "et_eiffel_parser.y"
		local
			yyval50: ET_CONSTRAINT_TYPE
		do
--|#line 759 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 759")
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

	yy_do_action_93 is
			--|#line 767 "et_eiffel_parser.y"
		local
			yyval50: ET_CONSTRAINT_TYPE
		do
--|#line 767 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 767")
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

	yy_do_action_94 is
			--|#line 775 "et_eiffel_parser.y"
		local
			yyval50: ET_CONSTRAINT_TYPE
		do
--|#line 775 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 775")
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

	yy_do_action_95 is
			--|#line 777 "et_eiffel_parser.y"
		local
			yyval50: ET_CONSTRAINT_TYPE
		do
--|#line 777 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 777")
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

	yy_do_action_96 is
			--|#line 779 "et_eiffel_parser.y"
		local
			yyval50: ET_CONSTRAINT_TYPE
		do
--|#line 779 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 779")
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

	yy_do_action_97 is
			--|#line 781 "et_eiffel_parser.y"
		local
			yyval50: ET_CONSTRAINT_TYPE
		do
--|#line 781 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 781")
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

	yy_do_action_98 is
			--|#line 783 "et_eiffel_parser.y"
		local
			yyval50: ET_CONSTRAINT_TYPE
		do
--|#line 783 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 783")
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

	yy_do_action_99 is
			--|#line 785 "et_eiffel_parser.y"
		local
			yyval50: ET_CONSTRAINT_TYPE
		do
--|#line 785 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 785")
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
			--|#line 787 "et_eiffel_parser.y"
		local
			yyval50: ET_CONSTRAINT_TYPE
		do
--|#line 787 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 787")
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

	yy_do_action_101 is
			--|#line 795 "et_eiffel_parser.y"
		local
			yyval50: ET_CONSTRAINT_TYPE
		do
--|#line 795 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 795")
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

	yy_do_action_102 is
			--|#line 805 "et_eiffel_parser.y"
		local
			yyval50: ET_CONSTRAINT_TYPE
		do
--|#line 805 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 805")
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

	yy_do_action_103 is
			--|#line 807 "et_eiffel_parser.y"
		local
			yyval50: ET_CONSTRAINT_TYPE
		do
--|#line 807 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 807")
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

	yy_do_action_104 is
			--|#line 809 "et_eiffel_parser.y"
		local
			yyval50: ET_CONSTRAINT_TYPE
		do
--|#line 809 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 809")
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

	yy_do_action_105 is
			--|#line 811 "et_eiffel_parser.y"
		local
			yyval50: ET_CONSTRAINT_TYPE
		do
--|#line 811 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 811")
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

	yy_do_action_106 is
			--|#line 813 "et_eiffel_parser.y"
		local
			yyval50: ET_CONSTRAINT_TYPE
		do
--|#line 813 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 813")
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

	yy_do_action_107 is
			--|#line 815 "et_eiffel_parser.y"
		local
			yyval50: ET_CONSTRAINT_TYPE
		do
--|#line 815 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 815")
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

	yy_do_action_108 is
			--|#line 817 "et_eiffel_parser.y"
		local
			yyval50: ET_CONSTRAINT_TYPE
		do
--|#line 817 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 817")
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
			--|#line 825 "et_eiffel_parser.y"
		local
			yyval50: ET_CONSTRAINT_TYPE
		do
--|#line 825 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 825")
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
			--|#line 833 "et_eiffel_parser.y"
		local
			yyval50: ET_CONSTRAINT_TYPE
		do
--|#line 833 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 833")
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

	yy_do_action_111 is
			--|#line 835 "et_eiffel_parser.y"
		local
			yyval50: ET_CONSTRAINT_TYPE
		do
--|#line 835 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 835")
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

	yy_do_action_112 is
			--|#line 837 "et_eiffel_parser.y"
		local
			yyval50: ET_CONSTRAINT_TYPE
		do
--|#line 837 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 837")
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

	yy_do_action_113 is
			--|#line 839 "et_eiffel_parser.y"
		local
			yyval50: ET_CONSTRAINT_TYPE
		do
--|#line 839 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 839")
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

	yy_do_action_114 is
			--|#line 841 "et_eiffel_parser.y"
		local
			yyval50: ET_CONSTRAINT_TYPE
		do
--|#line 841 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 841")
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

	yy_do_action_115 is
			--|#line 843 "et_eiffel_parser.y"
		local
			yyval50: ET_CONSTRAINT_TYPE
		do
--|#line 843 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 843")
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

	yy_do_action_116 is
			--|#line 845 "et_eiffel_parser.y"
		local
			yyval50: ET_CONSTRAINT_TYPE
		do
--|#line 845 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 845")
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

	yy_do_action_117 is
			--|#line 853 "et_eiffel_parser.y"
		local
			yyval50: ET_CONSTRAINT_TYPE
		do
--|#line 853 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 853")
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

	yy_do_action_118 is
			--|#line 863 "et_eiffel_parser.y"
		local
			yyval48: ET_CONSTRAINT_ACTUAL_PARAMETER_LIST
		do
--|#line 863 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 863")
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

	yy_do_action_119 is
			--|#line 865 "et_eiffel_parser.y"
		local
			yyval48: ET_CONSTRAINT_ACTUAL_PARAMETER_LIST
		do
--|#line 865 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 865")
end

yyval48 := yyvs48.item (yyvsp48) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs48.put (yyval48, yyvsp48)
end
		end

	yy_do_action_120 is
			--|#line 869 "et_eiffel_parser.y"
		local
			yyval48: ET_CONSTRAINT_ACTUAL_PARAMETER_LIST
		do
--|#line 869 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 869")
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

	yy_do_action_121 is
			--|#line 872 "et_eiffel_parser.y"
		local
			yyval48: ET_CONSTRAINT_ACTUAL_PARAMETER_LIST
		do
--|#line 872 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 872")
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

	yy_do_action_122 is
			--|#line 880 "et_eiffel_parser.y"
		local
			yyval48: ET_CONSTRAINT_ACTUAL_PARAMETER_LIST
		do
--|#line 880 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 880")
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

	yy_do_action_123 is
			--|#line 891 "et_eiffel_parser.y"
		local
			yyval48: ET_CONSTRAINT_ACTUAL_PARAMETER_LIST
		do
--|#line 891 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 891")
end

			yyval48 := yyvs48.item (yyvsp48)
			add_to_constraint_actual_parameter_list (yyvs47.item (yyvsp47), yyval48)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp47 := yyvsp47 -1
	yyvs48.put (yyval48, yyvsp48)
end
		end

	yy_do_action_124 is
			--|#line 896 "et_eiffel_parser.y"
		local
			yyval48: ET_CONSTRAINT_ACTUAL_PARAMETER_LIST
		do
--|#line 896 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 896")
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

	yy_do_action_125 is
			--|#line 901 "et_eiffel_parser.y"
		local
			yyval48: ET_CONSTRAINT_ACTUAL_PARAMETER_LIST
		do
--|#line 901 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 901")
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

	yy_do_action_126 is
			--|#line 908 "et_eiffel_parser.y"
		local
			yyval47: ET_CONSTRAINT_ACTUAL_PARAMETER_ITEM
		do
--|#line 908 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 908")
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

	yy_do_action_127 is
			--|#line 917 "et_eiffel_parser.y"
		local
			yyval48: ET_CONSTRAINT_ACTUAL_PARAMETER_LIST
		do
--|#line 917 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 917")
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

	yy_do_action_128 is
			--|#line 919 "et_eiffel_parser.y"
		local
			yyval48: ET_CONSTRAINT_ACTUAL_PARAMETER_LIST
		do
--|#line 919 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 919")
end

yyval48 := yyvs48.item (yyvsp48) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs48.put (yyval48, yyvsp48)
end
		end

	yy_do_action_129 is
			--|#line 923 "et_eiffel_parser.y"
		local
			yyval48: ET_CONSTRAINT_ACTUAL_PARAMETER_LIST
		do
--|#line 923 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 923")
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

	yy_do_action_130 is
			--|#line 926 "et_eiffel_parser.y"
		local
			yyval48: ET_CONSTRAINT_ACTUAL_PARAMETER_LIST
		do
--|#line 926 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 926")
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

	yy_do_action_131 is
			--|#line 932 "et_eiffel_parser.y"
		local
			yyval48: ET_CONSTRAINT_ACTUAL_PARAMETER_LIST
		do
--|#line 932 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 932")
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

	yy_do_action_132 is
			--|#line 940 "et_eiffel_parser.y"
		local
			yyval48: ET_CONSTRAINT_ACTUAL_PARAMETER_LIST
		do
--|#line 940 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 940")
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

	yy_do_action_133 is
			--|#line 945 "et_eiffel_parser.y"
		local
			yyval48: ET_CONSTRAINT_ACTUAL_PARAMETER_LIST
		do
--|#line 945 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 945")
end

			yyval48 := yyvs48.item (yyvsp48)
			add_to_constraint_actual_parameter_list (yyvs47.item (yyvsp47), yyvs48.item (yyvsp48))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp47 := yyvsp47 -1
	yyvs48.put (yyval48, yyvsp48)
end
		end

	yy_do_action_134 is
			--|#line 950 "et_eiffel_parser.y"
		local
			yyval48: ET_CONSTRAINT_ACTUAL_PARAMETER_LIST
		do
--|#line 950 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 950")
end

			yyval48 := yyvs48.item (yyvsp48)
			add_to_constraint_actual_parameter_list (yyvs47.item (yyvsp47), yyvs48.item (yyvsp48))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp47 := yyvsp47 -1
	yyvs48.put (yyval48, yyvsp48)
end
		end

	yy_do_action_135 is
			--|#line 955 "et_eiffel_parser.y"
		local
			yyval48: ET_CONSTRAINT_ACTUAL_PARAMETER_LIST
		do
--|#line 955 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 955")
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

	yy_do_action_136 is
			--|#line 966 "et_eiffel_parser.y"
		local
			yyval48: ET_CONSTRAINT_ACTUAL_PARAMETER_LIST
		do
--|#line 966 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 966")
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

	yy_do_action_137 is
			--|#line 977 "et_eiffel_parser.y"
		local
			yyval48: ET_CONSTRAINT_ACTUAL_PARAMETER_LIST
		do
--|#line 977 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 977")
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

	yy_do_action_138 is
			--|#line 990 "et_eiffel_parser.y"
		local
			yyval47: ET_CONSTRAINT_ACTUAL_PARAMETER_ITEM
		do
--|#line 990 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 990")
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

	yy_do_action_139 is
			--|#line 999 "et_eiffel_parser.y"
		local
			yyval47: ET_CONSTRAINT_ACTUAL_PARAMETER_ITEM
		do
--|#line 999 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 999")
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

	yy_do_action_140 is
			--|#line 1010 "et_eiffel_parser.y"
		local
			yyval98: ET_OBSOLETE
		do
--|#line 1010 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1010")
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

	yy_do_action_141 is
			--|#line 1012 "et_eiffel_parser.y"
		local
			yyval98: ET_OBSOLETE
		do
--|#line 1012 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1012")
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

	yy_do_action_142 is
			--|#line 1018 "et_eiffel_parser.y"
		local
			yyval102: ET_PARENT_LIST
		do
--|#line 1018 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1018")
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

	yy_do_action_143 is
			--|#line 1020 "et_eiffel_parser.y"
		local
			yyval102: ET_PARENT_LIST
		do
--|#line 1020 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1020")
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

	yy_do_action_144 is
			--|#line 1022 "et_eiffel_parser.y"
		local
			yyval102: ET_PARENT_LIST
		do
--|#line 1022 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1022")
end

			yyval102 := yyvs102.item (yyvsp102)
			remove_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs102.put (yyval102, yyvsp102)
end
		end

	yy_do_action_145 is
			--|#line 1029 "et_eiffel_parser.y"
		local
			yyval102: ET_PARENT_LIST
		do
--|#line 1029 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1029")
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

	yy_do_action_146 is
			--|#line 1037 "et_eiffel_parser.y"
		local
			yyval1: ANY
		do
--|#line 1037 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1037")
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

	yy_do_action_147 is
			--|#line 1044 "et_eiffel_parser.y"
		local
			yyval100: ET_PARENT
		do
--|#line 1044 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1044")
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

	yy_do_action_148 is
			--|#line 1051 "et_eiffel_parser.y"
		local
			yyval100: ET_PARENT
		do
--|#line 1051 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1051")
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

	yy_do_action_149 is
			--|#line 1059 "et_eiffel_parser.y"
		local
			yyval100: ET_PARENT
		do
--|#line 1059 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1059")
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

	yy_do_action_150 is
			--|#line 1066 "et_eiffel_parser.y"
		local
			yyval100: ET_PARENT
		do
--|#line 1066 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1066")
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

	yy_do_action_151 is
			--|#line 1073 "et_eiffel_parser.y"
		local
			yyval100: ET_PARENT
		do
--|#line 1073 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1073")
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

	yy_do_action_152 is
			--|#line 1080 "et_eiffel_parser.y"
		local
			yyval100: ET_PARENT
		do
--|#line 1080 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1080")
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

	yy_do_action_153 is
			--|#line 1089 "et_eiffel_parser.y"
		local
			yyval100: ET_PARENT
		do
--|#line 1089 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1089")
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

	yy_do_action_154 is
			--|#line 1098 "et_eiffel_parser.y"
		local
			yyval102: ET_PARENT_LIST
		do
--|#line 1098 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1098")
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

	yy_do_action_155 is
			--|#line 1105 "et_eiffel_parser.y"
		local
			yyval102: ET_PARENT_LIST
		do
--|#line 1105 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1105")
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

	yy_do_action_156 is
			--|#line 1112 "et_eiffel_parser.y"
		local
			yyval102: ET_PARENT_LIST
		do
--|#line 1112 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1112")
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

	yy_do_action_157 is
			--|#line 1119 "et_eiffel_parser.y"
		local
			yyval102: ET_PARENT_LIST
		do
--|#line 1119 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1119")
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

	yy_do_action_158 is
			--|#line 1126 "et_eiffel_parser.y"
		local
			yyval102: ET_PARENT_LIST
		do
--|#line 1126 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1126")
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

	yy_do_action_159 is
			--|#line 1135 "et_eiffel_parser.y"
		local
			yyval102: ET_PARENT_LIST
		do
--|#line 1135 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1135")
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

	yy_do_action_160 is
			--|#line 1142 "et_eiffel_parser.y"
		local
			yyval102: ET_PARENT_LIST
		do
--|#line 1142 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1142")
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

	yy_do_action_161 is
			--|#line 1149 "et_eiffel_parser.y"
		local
			yyval102: ET_PARENT_LIST
		do
--|#line 1149 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1149")
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

	yy_do_action_162 is
			--|#line 1156 "et_eiffel_parser.y"
		local
			yyval102: ET_PARENT_LIST
		do
--|#line 1156 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1156")
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

	yy_do_action_163 is
			--|#line 1165 "et_eiffel_parser.y"
		local
			yyval101: ET_PARENT_ITEM
		do
--|#line 1165 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1165")
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

	yy_do_action_164 is
			--|#line 1172 "et_eiffel_parser.y"
		local
			yyval101: ET_PARENT_ITEM
		do
--|#line 1172 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1172")
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

	yy_do_action_165 is
			--|#line 1183 "et_eiffel_parser.y"
		local
			yyval109: ET_RENAME_LIST
		do
--|#line 1183 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1183")
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

	yy_do_action_166 is
			--|#line 1185 "et_eiffel_parser.y"
		local
			yyval109: ET_RENAME_LIST
		do
--|#line 1185 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1185")
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

	yy_do_action_167 is
			--|#line 1185 "et_eiffel_parser.y"
		local
			yyval109: ET_RENAME_LIST
		do
--|#line 1185 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1185")
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

	yy_do_action_168 is
			--|#line 1198 "et_eiffel_parser.y"
		local
			yyval109: ET_RENAME_LIST
		do
--|#line 1198 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1198")
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

	yy_do_action_169 is
			--|#line 1205 "et_eiffel_parser.y"
		local
			yyval109: ET_RENAME_LIST
		do
--|#line 1205 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1205")
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

	yy_do_action_170 is
			--|#line 1213 "et_eiffel_parser.y"
		local
			yyval109: ET_RENAME_LIST
		do
--|#line 1213 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1213")
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

	yy_do_action_171 is
			--|#line 1222 "et_eiffel_parser.y"
		local
			yyval108: ET_RENAME_ITEM
		do
--|#line 1222 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1222")
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

	yy_do_action_172 is
			--|#line 1231 "et_eiffel_parser.y"
		local
			yyval108: ET_RENAME_ITEM
		do
--|#line 1231 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1231")
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

	yy_do_action_173 is
			--|#line 1242 "et_eiffel_parser.y"
		local
			yyval61: ET_EXPORT_LIST
		do
--|#line 1242 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1242")
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

	yy_do_action_174 is
			--|#line 1244 "et_eiffel_parser.y"
		local
			yyval61: ET_EXPORT_LIST
		do
--|#line 1244 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1244")
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

	yy_do_action_175 is
			--|#line 1244 "et_eiffel_parser.y"
		local
			yyval61: ET_EXPORT_LIST
		do
--|#line 1244 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1244")
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

	yy_do_action_176 is
			--|#line 1257 "et_eiffel_parser.y"
		local
			yyval61: ET_EXPORT_LIST
		do
--|#line 1257 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1257")
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

	yy_do_action_177 is
			--|#line 1259 "et_eiffel_parser.y"
		local
			yyval61: ET_EXPORT_LIST
		do
--|#line 1259 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1259")
end

yyval61 := yyvs61.item (yyvsp61) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs61.put (yyval61, yyvsp61)
end
		end

	yy_do_action_178 is
			--|#line 1263 "et_eiffel_parser.y"
		local
			yyval61: ET_EXPORT_LIST
		do
--|#line 1263 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1263")
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

	yy_do_action_179 is
			--|#line 1274 "et_eiffel_parser.y"
		local
			yyval61: ET_EXPORT_LIST
		do
--|#line 1274 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1274")
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

	yy_do_action_180 is
			--|#line 1274 "et_eiffel_parser.y"
		local
			yyval61: ET_EXPORT_LIST
		do
--|#line 1274 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1274")
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

	yy_do_action_181 is
			--|#line 1289 "et_eiffel_parser.y"
		local
			yyval60: ET_EXPORT
		do
--|#line 1289 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1289")
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

	yy_do_action_182 is
			--|#line 1293 "et_eiffel_parser.y"
		local
			yyval60: ET_EXPORT
		do
--|#line 1293 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1293")
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

	yy_do_action_183 is
			--|#line 1298 "et_eiffel_parser.y"
		local
			yyval60: ET_EXPORT
		do
--|#line 1298 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1298")
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

	yy_do_action_184 is
			--|#line 1298 "et_eiffel_parser.y"
		local
			yyval60: ET_EXPORT
		do
--|#line 1298 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1298")
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

	yy_do_action_185 is
			--|#line 1308 "et_eiffel_parser.y"
		local
			yyval60: ET_EXPORT
		do
--|#line 1308 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1308")
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

	yy_do_action_186 is
			--|#line 1312 "et_eiffel_parser.y"
		local
			yyval68: ET_FEATURE_EXPORT
		do
--|#line 1312 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1312")
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

	yy_do_action_187 is
			--|#line 1323 "et_eiffel_parser.y"
		local
			yyval68: ET_FEATURE_EXPORT
		do
--|#line 1323 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1323")
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

	yy_do_action_188 is
			--|#line 1331 "et_eiffel_parser.y"
		local
			yyval68: ET_FEATURE_EXPORT
		do
--|#line 1331 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1331")
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

	yy_do_action_189 is
			--|#line 1342 "et_eiffel_parser.y"
		local
			yyval44: ET_CLIENTS
		do
--|#line 1342 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1342")
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

	yy_do_action_190 is
			--|#line 1342 "et_eiffel_parser.y"
		local
			yyval44: ET_CLIENTS
		do
--|#line 1342 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1342")
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

	yy_do_action_191 is
			--|#line 1353 "et_eiffel_parser.y"
		local
			yyval44: ET_CLIENTS
		do
--|#line 1353 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1353")
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

	yy_do_action_192 is
			--|#line 1357 "et_eiffel_parser.y"
		local
			yyval44: ET_CLIENTS
		do
--|#line 1357 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1357")
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

	yy_do_action_193 is
			--|#line 1364 "et_eiffel_parser.y"
		local
			yyval44: ET_CLIENTS
		do
--|#line 1364 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1364")
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

	yy_do_action_194 is
			--|#line 1372 "et_eiffel_parser.y"
		local
			yyval44: ET_CLIENTS
		do
--|#line 1372 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1372")
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

	yy_do_action_195 is
			--|#line 1379 "et_eiffel_parser.y"
		local
			yyval44: ET_CLIENTS
		do
--|#line 1379 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1379")
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

	yy_do_action_196 is
			--|#line 1389 "et_eiffel_parser.y"
		local
			yyval43: ET_CLIENT_ITEM
		do
--|#line 1389 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1389")
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

	yy_do_action_197 is
			--|#line 1398 "et_eiffel_parser.y"
		local
			yyval43: ET_CLIENT_ITEM
		do
--|#line 1398 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1398")
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

	yy_do_action_198 is
			--|#line 1409 "et_eiffel_parser.y"
		local
			yyval87: ET_KEYWORD_FEATURE_NAME_LIST
		do
--|#line 1409 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1409")
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

	yy_do_action_199 is
			--|#line 1411 "et_eiffel_parser.y"
		local
			yyval87: ET_KEYWORD_FEATURE_NAME_LIST
		do
--|#line 1411 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1411")
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

	yy_do_action_200 is
			--|#line 1411 "et_eiffel_parser.y"
		local
			yyval87: ET_KEYWORD_FEATURE_NAME_LIST
		do
--|#line 1411 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1411")
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

	yy_do_action_201 is
			--|#line 1424 "et_eiffel_parser.y"
		local
			yyval87: ET_KEYWORD_FEATURE_NAME_LIST
		do
--|#line 1424 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1424")
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

	yy_do_action_202 is
			--|#line 1426 "et_eiffel_parser.y"
		local
			yyval87: ET_KEYWORD_FEATURE_NAME_LIST
		do
--|#line 1426 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1426")
end

yyval87 := yyvs87.item (yyvsp87) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs87.put (yyval87, yyvsp87)
end
		end

	yy_do_action_203 is
			--|#line 1430 "et_eiffel_parser.y"
		local
			yyval87: ET_KEYWORD_FEATURE_NAME_LIST
		do
--|#line 1430 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1430")
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

	yy_do_action_204 is
			--|#line 1432 "et_eiffel_parser.y"
		local
			yyval87: ET_KEYWORD_FEATURE_NAME_LIST
		do
--|#line 1432 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1432")
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

	yy_do_action_205 is
			--|#line 1432 "et_eiffel_parser.y"
		local
			yyval87: ET_KEYWORD_FEATURE_NAME_LIST
		do
--|#line 1432 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1432")
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

	yy_do_action_206 is
			--|#line 1445 "et_eiffel_parser.y"
		local
			yyval87: ET_KEYWORD_FEATURE_NAME_LIST
		do
--|#line 1445 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1445")
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

	yy_do_action_207 is
			--|#line 1447 "et_eiffel_parser.y"
		local
			yyval87: ET_KEYWORD_FEATURE_NAME_LIST
		do
--|#line 1447 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1447")
end

yyval87 := yyvs87.item (yyvsp87) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs87.put (yyval87, yyvsp87)
end
		end

	yy_do_action_208 is
			--|#line 1451 "et_eiffel_parser.y"
		local
			yyval87: ET_KEYWORD_FEATURE_NAME_LIST
		do
--|#line 1451 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1451")
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

	yy_do_action_209 is
			--|#line 1453 "et_eiffel_parser.y"
		local
			yyval87: ET_KEYWORD_FEATURE_NAME_LIST
		do
--|#line 1453 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1453")
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

	yy_do_action_210 is
			--|#line 1453 "et_eiffel_parser.y"
		local
			yyval87: ET_KEYWORD_FEATURE_NAME_LIST
		do
--|#line 1453 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1453")
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

	yy_do_action_211 is
			--|#line 1466 "et_eiffel_parser.y"
		local
			yyval87: ET_KEYWORD_FEATURE_NAME_LIST
		do
--|#line 1466 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1466")
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

	yy_do_action_212 is
			--|#line 1468 "et_eiffel_parser.y"
		local
			yyval87: ET_KEYWORD_FEATURE_NAME_LIST
		do
--|#line 1468 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1468")
end

yyval87 := yyvs87.item (yyvsp87) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs87.put (yyval87, yyvsp87)
end
		end

	yy_do_action_213 is
			--|#line 1472 "et_eiffel_parser.y"
		local
			yyval87: ET_KEYWORD_FEATURE_NAME_LIST
		do
--|#line 1472 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1472")
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

	yy_do_action_214 is
			--|#line 1483 "et_eiffel_parser.y"
		local
			yyval87: ET_KEYWORD_FEATURE_NAME_LIST
		do
--|#line 1483 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1483")
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

	yy_do_action_215 is
			--|#line 1491 "et_eiffel_parser.y"
		local
			yyval87: ET_KEYWORD_FEATURE_NAME_LIST
		do
--|#line 1491 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1491")
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

	yy_do_action_216 is
			--|#line 1500 "et_eiffel_parser.y"
		local
			yyval70: ET_FEATURE_NAME_ITEM
		do
--|#line 1500 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1500")
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

	yy_do_action_217 is
			--|#line 1511 "et_eiffel_parser.y"
		local
			yyval56: ET_CREATOR_LIST
		do
--|#line 1511 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1511")
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

	yy_do_action_218 is
			--|#line 1513 "et_eiffel_parser.y"
		local
			yyval56: ET_CREATOR_LIST
		do
--|#line 1513 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1513")
end

			yyval56 := yyvs56.item (yyvsp56)
			remove_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs56.put (yyval56, yyvsp56)
end
		end

	yy_do_action_219 is
			--|#line 1520 "et_eiffel_parser.y"
		local
			yyval56: ET_CREATOR_LIST
		do
--|#line 1520 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1520")
end

			yyval56 := yyvs56.item (yyvsp56)
			remove_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs56.put (yyval56, yyvsp56)
end
		end

	yy_do_action_220 is
			--|#line 1527 "et_eiffel_parser.y"
		local
			yyval56: ET_CREATOR_LIST
		do
--|#line 1527 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1527")
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

	yy_do_action_221 is
			--|#line 1538 "et_eiffel_parser.y"
		local
			yyval56: ET_CREATOR_LIST
		do
--|#line 1538 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1538")
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

	yy_do_action_222 is
			--|#line 1538 "et_eiffel_parser.y"
		local
			yyval56: ET_CREATOR_LIST
		do
--|#line 1538 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1538")
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

	yy_do_action_223 is
			--|#line 1553 "et_eiffel_parser.y"
		local
			yyval55: ET_CREATOR
		do
--|#line 1553 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1553")
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

	yy_do_action_224 is
			--|#line 1555 "et_eiffel_parser.y"
		local
			yyval55: ET_CREATOR
		do
--|#line 1555 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1555")
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

	yy_do_action_225 is
			--|#line 1557 "et_eiffel_parser.y"
		local
			yyval55: ET_CREATOR
		do
--|#line 1557 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1557")
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

	yy_do_action_226 is
			--|#line 1557 "et_eiffel_parser.y"
		local
			yyval55: ET_CREATOR
		do
--|#line 1557 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1557")
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

	yy_do_action_227 is
			--|#line 1569 "et_eiffel_parser.y"
		local
			yyval55: ET_CREATOR
		do
--|#line 1569 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1569")
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

	yy_do_action_228 is
			--|#line 1569 "et_eiffel_parser.y"
		local
			yyval55: ET_CREATOR
		do
--|#line 1569 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1569")
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

	yy_do_action_229 is
			--|#line 1581 "et_eiffel_parser.y"
		local
			yyval55: ET_CREATOR
		do
--|#line 1581 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1581")
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

	yy_do_action_230 is
			--|#line 1583 "et_eiffel_parser.y"
		local
			yyval55: ET_CREATOR
		do
--|#line 1583 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1583")
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

	yy_do_action_231 is
			--|#line 1585 "et_eiffel_parser.y"
		local
			yyval55: ET_CREATOR
		do
--|#line 1585 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1585")
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

	yy_do_action_232 is
			--|#line 1585 "et_eiffel_parser.y"
		local
			yyval55: ET_CREATOR
		do
--|#line 1585 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1585")
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

	yy_do_action_233 is
			--|#line 1597 "et_eiffel_parser.y"
		local
			yyval55: ET_CREATOR
		do
--|#line 1597 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1597")
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

	yy_do_action_234 is
			--|#line 1597 "et_eiffel_parser.y"
		local
			yyval55: ET_CREATOR
		do
--|#line 1597 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1597")
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

	yy_do_action_235 is
			--|#line 1611 "et_eiffel_parser.y"
		local
			yyval55: ET_CREATOR
		do
--|#line 1611 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1611")
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

	yy_do_action_236 is
			--|#line 1622 "et_eiffel_parser.y"
		local
			yyval55: ET_CREATOR
		do
--|#line 1622 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1622")
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

	yy_do_action_237 is
			--|#line 1634 "et_eiffel_parser.y"
		local
			yyval55: ET_CREATOR
		do
--|#line 1634 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1634")
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

	yy_do_action_238 is
			--|#line 1643 "et_eiffel_parser.y"
		local
			yyval70: ET_FEATURE_NAME_ITEM
		do
--|#line 1643 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1643")
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

	yy_do_action_239 is
			--|#line 1654 "et_eiffel_parser.y"
		local
			yyval53: ET_CONVERT_FEATURE_LIST
		do
--|#line 1654 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1654")
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

	yy_do_action_240 is
			--|#line 1656 "et_eiffel_parser.y"
		local
			yyval53: ET_CONVERT_FEATURE_LIST
		do
--|#line 1656 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1656")
end

yyval53 := yyvs53.item (yyvsp53) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs53.put (yyval53, yyvsp53)
end
		end

	yy_do_action_241 is
			--|#line 1660 "et_eiffel_parser.y"
		local
			yyval53: ET_CONVERT_FEATURE_LIST
		do
--|#line 1660 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1660")
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

	yy_do_action_242 is
			--|#line 1660 "et_eiffel_parser.y"
		local
			yyval53: ET_CONVERT_FEATURE_LIST
		do
--|#line 1660 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1660")
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

	yy_do_action_243 is
			--|#line 1673 "et_eiffel_parser.y"
		local
			yyval53: ET_CONVERT_FEATURE_LIST
		do
--|#line 1673 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1673")
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

	yy_do_action_244 is
			--|#line 1680 "et_eiffel_parser.y"
		local
			yyval53: ET_CONVERT_FEATURE_LIST
		do
--|#line 1680 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1680")
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

	yy_do_action_245 is
			--|#line 1687 "et_eiffel_parser.y"
		local
			yyval53: ET_CONVERT_FEATURE_LIST
		do
--|#line 1687 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1687")
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

	yy_do_action_246 is
			--|#line 1696 "et_eiffel_parser.y"
		local
			yyval52: ET_CONVERT_FEATURE_ITEM
		do
--|#line 1696 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1696")
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

	yy_do_action_247 is
			--|#line 1705 "et_eiffel_parser.y"
		local
			yyval51: ET_CONVERT_FEATURE
		do
--|#line 1705 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1705")
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

	yy_do_action_248 is
			--|#line 1709 "et_eiffel_parser.y"
		local
			yyval51: ET_CONVERT_FEATURE
		do
--|#line 1709 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1709")
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

	yy_do_action_249 is
			--|#line 1715 "et_eiffel_parser.y"
		local
			yyval114: ET_TYPE_LIST
		do
--|#line 1715 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1715")
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

	yy_do_action_250 is
			--|#line 1717 "et_eiffel_parser.y"
		local
			yyval114: ET_TYPE_LIST
		do
--|#line 1717 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1717")
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

	yy_do_action_251 is
			--|#line 1717 "et_eiffel_parser.y"
		local
			yyval114: ET_TYPE_LIST
		do
--|#line 1717 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1717")
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

	yy_do_action_252 is
			--|#line 1730 "et_eiffel_parser.y"
		local
			yyval114: ET_TYPE_LIST
		do
--|#line 1730 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1730")
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

	yy_do_action_253 is
			--|#line 1741 "et_eiffel_parser.y"
		local
			yyval114: ET_TYPE_LIST
		do
--|#line 1741 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1741")
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

	yy_do_action_254 is
			--|#line 1750 "et_eiffel_parser.y"
		local
			yyval113: ET_TYPE_ITEM
		do
--|#line 1750 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1750")
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

	yy_do_action_255 is
			--|#line 1761 "et_eiffel_parser.y"
		local
			yyval67: ET_FEATURE_CLAUSE_LIST
		do
--|#line 1761 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1761")
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

	yy_do_action_256 is
			--|#line 1766 "et_eiffel_parser.y"
		local
			yyval67: ET_FEATURE_CLAUSE_LIST
		do
--|#line 1766 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1766")
end

yyval67 := yyvs67.item (yyvsp67) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs67.put (yyval67, yyvsp67)
end
		end

	yy_do_action_257 is
			--|#line 1770 "et_eiffel_parser.y"
		local
			yyval67: ET_FEATURE_CLAUSE_LIST
		do
--|#line 1770 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1770")
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

	yy_do_action_258 is
			--|#line 1778 "et_eiffel_parser.y"
		local
			yyval67: ET_FEATURE_CLAUSE_LIST
		do
--|#line 1778 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1778")
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

	yy_do_action_259 is
			--|#line 1785 "et_eiffel_parser.y"
		local
			yyval67: ET_FEATURE_CLAUSE_LIST
		do
--|#line 1785 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1785")
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

	yy_do_action_260 is
			--|#line 1794 "et_eiffel_parser.y"
		local
			yyval66: ET_FEATURE_CLAUSE
		do
--|#line 1794 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1794")
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

	yy_do_action_261 is
			--|#line 1801 "et_eiffel_parser.y"
		local
			yyval66: ET_FEATURE_CLAUSE
		do
--|#line 1801 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1801")
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

	yy_do_action_262 is
			--|#line 1810 "et_eiffel_parser.y"
		local
			yyval66: ET_FEATURE_CLAUSE
		do
--|#line 1810 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1810")
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

	yy_do_action_263 is
			--|#line 1815 "et_eiffel_parser.y"
		local
			yyval66: ET_FEATURE_CLAUSE
		do
--|#line 1815 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1815")
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

	yy_do_action_264 is
			--|#line 1822 "et_eiffel_parser.y"
		local
			yyval1: ANY
		do
--|#line 1822 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1822")
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

	yy_do_action_265 is
			--|#line 1823 "et_eiffel_parser.y"
		local
			yyval1: ANY
		do
--|#line 1823 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1823")
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

	yy_do_action_266 is
			--|#line 1824 "et_eiffel_parser.y"
		local
			yyval1: ANY
		do
--|#line 1824 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1824")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp107 := yyvsp107 -1
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_267 is
			--|#line 1825 "et_eiffel_parser.y"
		local
			yyval1: ANY
		do
--|#line 1825 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1825")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp105 := yyvsp105 -1
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_268 is
			--|#line 1830 "et_eiffel_parser.y"
		local
			yyval107: ET_QUERY
		do
--|#line 1830 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1830")
end

			yyval107 := yyvs107.item (yyvsp107)
			register_query (yyval107)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs107.put (yyval107, yyvsp107)
end
		end

	yy_do_action_269 is
			--|#line 1835 "et_eiffel_parser.y"
		local
			yyval107: ET_QUERY
		do
--|#line 1835 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1835")
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

	yy_do_action_270 is
			--|#line 1841 "et_eiffel_parser.y"
		local
			yyval107: ET_QUERY
		do
--|#line 1841 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1841")
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

	yy_do_action_271 is
			--|#line 1846 "et_eiffel_parser.y"
		local
			yyval107: ET_QUERY
		do
--|#line 1846 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1846")
end

			yyval107 := new_query_synonym (yyvs64.item (yyvsp64), yyvs107.item (yyvsp107))
			register_query_synonym (yyval107)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp64 := yyvsp64 -1
	yyvs107.put (yyval107, yyvsp107)
end
		end

	yy_do_action_272 is
			--|#line 1852 "et_eiffel_parser.y"
		local
			yyval107: ET_QUERY
		do
--|#line 1852 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1852")
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

	yy_do_action_273 is
			--|#line 1858 "et_eiffel_parser.y"
		local
			yyval107: ET_QUERY
		do
--|#line 1858 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1858")
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

	yy_do_action_274 is
			--|#line 1867 "et_eiffel_parser.y"
		local
			yyval105: ET_PROCEDURE
		do
--|#line 1867 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1867")
end

			yyval105 := yyvs105.item (yyvsp105)
			register_procedure (yyval105)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs105.put (yyval105, yyvsp105)
end
		end

	yy_do_action_275 is
			--|#line 1872 "et_eiffel_parser.y"
		local
			yyval105: ET_PROCEDURE
		do
--|#line 1872 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1872")
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

	yy_do_action_276 is
			--|#line 1878 "et_eiffel_parser.y"
		local
			yyval105: ET_PROCEDURE
		do
--|#line 1878 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1878")
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

	yy_do_action_277 is
			--|#line 1883 "et_eiffel_parser.y"
		local
			yyval105: ET_PROCEDURE
		do
--|#line 1883 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1883")
end

			yyval105 := new_procedure_synonym (yyvs64.item (yyvsp64), yyvs105.item (yyvsp105))
			register_procedure_synonym (yyval105)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp64 := yyvsp64 -1
	yyvs105.put (yyval105, yyvsp105)
end
		end

	yy_do_action_278 is
			--|#line 1889 "et_eiffel_parser.y"
		local
			yyval105: ET_PROCEDURE
		do
--|#line 1889 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1889")
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

	yy_do_action_279 is
			--|#line 1895 "et_eiffel_parser.y"
		local
			yyval105: ET_PROCEDURE
		do
--|#line 1895 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1895")
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

	yy_do_action_280 is
			--|#line 1904 "et_eiffel_parser.y"
		local
			yyval107: ET_QUERY
		do
--|#line 1904 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1904")
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

	yy_do_action_281 is
			--|#line 1906 "et_eiffel_parser.y"
		local
			yyval107: ET_QUERY
		do
--|#line 1906 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1906")
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

	yy_do_action_282 is
			--|#line 1908 "et_eiffel_parser.y"
		local
			yyval107: ET_QUERY
		do
--|#line 1908 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1908")
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

	yy_do_action_283 is
			--|#line 1910 "et_eiffel_parser.y"
		local
			yyval107: ET_QUERY
		do
--|#line 1910 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1910")
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

	yy_do_action_284 is
			--|#line 1918 "et_eiffel_parser.y"
		local
			yyval107: ET_QUERY
		do
--|#line 1918 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1918")
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

	yy_do_action_285 is
			--|#line 1920 "et_eiffel_parser.y"
		local
			yyval107: ET_QUERY
		do
--|#line 1920 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1920")
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

	yy_do_action_286 is
			--|#line 1928 "et_eiffel_parser.y"
		local
			yyval107: ET_QUERY
		do
--|#line 1928 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1928")
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

	yy_do_action_287 is
			--|#line 1931 "et_eiffel_parser.y"
		local
			yyval107: ET_QUERY
		do
--|#line 1931 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1931")
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

	yy_do_action_288 is
			--|#line 1940 "et_eiffel_parser.y"
		local
			yyval107: ET_QUERY
		do
--|#line 1940 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1940")
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

	yy_do_action_289 is
			--|#line 1944 "et_eiffel_parser.y"
		local
			yyval107: ET_QUERY
		do
--|#line 1944 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1944")
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

	yy_do_action_290 is
			--|#line 1954 "et_eiffel_parser.y"
		local
			yyval107: ET_QUERY
		do
--|#line 1954 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1954")
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

	yy_do_action_291 is
			--|#line 1957 "et_eiffel_parser.y"
		local
			yyval107: ET_QUERY
		do
--|#line 1957 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1957")
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

	yy_do_action_292 is
			--|#line 1966 "et_eiffel_parser.y"
		local
			yyval107: ET_QUERY
		do
--|#line 1966 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1966")
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

	yy_do_action_293 is
			--|#line 1970 "et_eiffel_parser.y"
		local
			yyval107: ET_QUERY
		do
--|#line 1970 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1970")
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

	yy_do_action_294 is
			--|#line 1980 "et_eiffel_parser.y"
		local
			yyval107: ET_QUERY
		do
--|#line 1980 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1980")
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

	yy_do_action_295 is
			--|#line 1982 "et_eiffel_parser.y"
		local
			yyval107: ET_QUERY
		do
--|#line 1982 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1982")
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

	yy_do_action_296 is
			--|#line 1990 "et_eiffel_parser.y"
		local
			yyval107: ET_QUERY
		do
--|#line 1990 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1990")
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

	yy_do_action_297 is
			--|#line 1993 "et_eiffel_parser.y"
		local
			yyval107: ET_QUERY
		do
--|#line 1993 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 1993")
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

	yy_do_action_298 is
			--|#line 2002 "et_eiffel_parser.y"
		local
			yyval107: ET_QUERY
		do
--|#line 2002 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2002")
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

	yy_do_action_299 is
			--|#line 2005 "et_eiffel_parser.y"
		local
			yyval107: ET_QUERY
		do
--|#line 2005 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2005")
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

	yy_do_action_300 is
			--|#line 2014 "et_eiffel_parser.y"
		local
			yyval107: ET_QUERY
		do
--|#line 2014 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2014")
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

	yy_do_action_301 is
			--|#line 2018 "et_eiffel_parser.y"
		local
			yyval107: ET_QUERY
		do
--|#line 2018 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2018")
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

	yy_do_action_302 is
			--|#line 2030 "et_eiffel_parser.y"
		local
			yyval105: ET_PROCEDURE
		do
--|#line 2030 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2030")
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

	yy_do_action_303 is
			--|#line 2033 "et_eiffel_parser.y"
		local
			yyval105: ET_PROCEDURE
		do
--|#line 2033 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2033")
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

	yy_do_action_304 is
			--|#line 2037 "et_eiffel_parser.y"
		local
			yyval105: ET_PROCEDURE
		do
--|#line 2037 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2037")
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

	yy_do_action_305 is
			--|#line 2040 "et_eiffel_parser.y"
		local
			yyval105: ET_PROCEDURE
		do
--|#line 2040 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2040")
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

	yy_do_action_306 is
			--|#line 2044 "et_eiffel_parser.y"
		local
			yyval105: ET_PROCEDURE
		do
--|#line 2044 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2044")
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

	yy_do_action_307 is
			--|#line 2046 "et_eiffel_parser.y"
		local
			yyval105: ET_PROCEDURE
		do
--|#line 2046 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2046")
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

	yy_do_action_308 is
			--|#line 2049 "et_eiffel_parser.y"
		local
			yyval105: ET_PROCEDURE
		do
--|#line 2049 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2049")
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

	yy_do_action_309 is
			--|#line 2052 "et_eiffel_parser.y"
		local
			yyval105: ET_PROCEDURE
		do
--|#line 2052 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2052")
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

	yy_do_action_310 is
			--|#line 2058 "et_eiffel_parser.y"
		local
			yyval2: ET_KEYWORD
		do
--|#line 2058 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2058")
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

	yy_do_action_311 is
			--|#line 2066 "et_eiffel_parser.y"
		local
			yyval2: ET_KEYWORD
		do
--|#line 2066 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2066")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
		end

	yy_do_action_312 is
			--|#line 2070 "et_eiffel_parser.y"
		local
			yyval22: ET_SEMICOLON_SYMBOL
		do
--|#line 2070 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2070")
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

	yy_do_action_313 is
			--|#line 2072 "et_eiffel_parser.y"
		local
			yyval22: ET_SEMICOLON_SYMBOL
		do
--|#line 2072 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2072")
end

yyval22 := yyvs22.item (yyvsp22) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs22.put (yyval22, yyvsp22)
end
		end

	yy_do_action_314 is
			--|#line 2076 "et_eiffel_parser.y"
		local
			yyval65: ET_EXTERNAL_ALIAS
		do
--|#line 2076 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2076")
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

	yy_do_action_315 is
			--|#line 2078 "et_eiffel_parser.y"
		local
			yyval65: ET_EXTERNAL_ALIAS
		do
--|#line 2078 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2078")
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

	yy_do_action_316 is
			--|#line 2082 "et_eiffel_parser.y"
		local
			yyval33: ET_ASSIGNER
		do
--|#line 2082 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2082")
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

	yy_do_action_317 is
			--|#line 2084 "et_eiffel_parser.y"
		local
			yyval33: ET_ASSIGNER
		do
--|#line 2084 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2084")
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

	yy_do_action_318 is
			--|#line 2090 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2090 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2090")
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

	yy_do_action_319 is
			--|#line 2092 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2092 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2092")
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

	yy_do_action_320 is
			--|#line 2094 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2094 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2094")
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

	yy_do_action_321 is
			--|#line 2096 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2096 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2096")
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

	yy_do_action_322 is
			--|#line 2098 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2098 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2098")
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

	yy_do_action_323 is
			--|#line 2100 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2100 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2100")
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

	yy_do_action_324 is
			--|#line 2102 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2102 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2102")
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

	yy_do_action_325 is
			--|#line 2104 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2104 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2104")
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

	yy_do_action_326 is
			--|#line 2106 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2106 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2106")
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

	yy_do_action_327 is
			--|#line 2108 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2108 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2108")
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

	yy_do_action_328 is
			--|#line 2110 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2110 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2110")
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

	yy_do_action_329 is
			--|#line 2112 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2112 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2112")
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

	yy_do_action_330 is
			--|#line 2114 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2114 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2114")
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

	yy_do_action_331 is
			--|#line 2116 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2116 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2116")
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

	yy_do_action_332 is
			--|#line 2118 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2118 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2118")
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

	yy_do_action_333 is
			--|#line 2120 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2120 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2120")
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

	yy_do_action_334 is
			--|#line 2122 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2122 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2122")
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

	yy_do_action_335 is
			--|#line 2124 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2124 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2124")
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

	yy_do_action_336 is
			--|#line 2126 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2126 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2126")
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

	yy_do_action_337 is
			--|#line 2128 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2128 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2128")
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

	yy_do_action_338 is
			--|#line 2130 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2130 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2130")
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

	yy_do_action_339 is
			--|#line 2132 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2132 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2132")
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

	yy_do_action_340 is
			--|#line 2134 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2134 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2134")
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

	yy_do_action_341 is
			--|#line 2137 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2137 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2137")
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
			--|#line 2139 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2139 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2139")
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
			--|#line 2141 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2141 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2141")
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
			--|#line 2143 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2143 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2143")
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
			--|#line 2145 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2145 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2145")
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
			--|#line 2147 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2147 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2147")
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
			--|#line 2149 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2149 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2149")
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
			--|#line 2151 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2151 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2151")
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
			--|#line 2153 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2153 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2153")
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

	yy_do_action_350 is
			--|#line 2155 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2155 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2155")
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

	yy_do_action_351 is
			--|#line 2157 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2157 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2157")
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

	yy_do_action_352 is
			--|#line 2159 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2159 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2159")
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

	yy_do_action_353 is
			--|#line 2161 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2161 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2161")
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

	yy_do_action_354 is
			--|#line 2163 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2163 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2163")
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

	yy_do_action_355 is
			--|#line 2165 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2165 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2165")
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

	yy_do_action_356 is
			--|#line 2167 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2167 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2167")
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

	yy_do_action_357 is
			--|#line 2169 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2169 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2169")
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

	yy_do_action_358 is
			--|#line 2171 "et_eiffel_parser.y"
		local
			yyval69: ET_FEATURE_NAME
		do
--|#line 2171 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2171")
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

	yy_do_action_359 is
			--|#line 2175 "et_eiffel_parser.y"
		local
			yyval64: ET_EXTENDED_FEATURE_NAME
		do
--|#line 2175 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2175")
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

	yy_do_action_360 is
			--|#line 2177 "et_eiffel_parser.y"
		local
			yyval64: ET_EXTENDED_FEATURE_NAME
		do
--|#line 2177 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2177")
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

	yy_do_action_361 is
			--|#line 2181 "et_eiffel_parser.y"
		local
			yyval32: ET_ALIAS_NAME
		do
--|#line 2181 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2181")
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

	yy_do_action_362 is
			--|#line 2183 "et_eiffel_parser.y"
		local
			yyval32: ET_ALIAS_NAME
		do
--|#line 2183 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2183")
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

	yy_do_action_363 is
			--|#line 2185 "et_eiffel_parser.y"
		local
			yyval32: ET_ALIAS_NAME
		do
--|#line 2185 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2185")
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

	yy_do_action_364 is
			--|#line 2187 "et_eiffel_parser.y"
		local
			yyval32: ET_ALIAS_NAME
		do
--|#line 2187 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2187")
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

	yy_do_action_365 is
			--|#line 2189 "et_eiffel_parser.y"
		local
			yyval32: ET_ALIAS_NAME
		do
--|#line 2189 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2189")
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

	yy_do_action_366 is
			--|#line 2191 "et_eiffel_parser.y"
		local
			yyval32: ET_ALIAS_NAME
		do
--|#line 2191 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2191")
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

	yy_do_action_367 is
			--|#line 2193 "et_eiffel_parser.y"
		local
			yyval32: ET_ALIAS_NAME
		do
--|#line 2193 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2193")
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

	yy_do_action_368 is
			--|#line 2195 "et_eiffel_parser.y"
		local
			yyval32: ET_ALIAS_NAME
		do
--|#line 2195 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2195")
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

	yy_do_action_369 is
			--|#line 2197 "et_eiffel_parser.y"
		local
			yyval32: ET_ALIAS_NAME
		do
--|#line 2197 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2197")
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

	yy_do_action_370 is
			--|#line 2199 "et_eiffel_parser.y"
		local
			yyval32: ET_ALIAS_NAME
		do
--|#line 2199 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2199")
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

	yy_do_action_371 is
			--|#line 2201 "et_eiffel_parser.y"
		local
			yyval32: ET_ALIAS_NAME
		do
--|#line 2201 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2201")
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

	yy_do_action_372 is
			--|#line 2203 "et_eiffel_parser.y"
		local
			yyval32: ET_ALIAS_NAME
		do
--|#line 2203 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2203")
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

	yy_do_action_373 is
			--|#line 2205 "et_eiffel_parser.y"
		local
			yyval32: ET_ALIAS_NAME
		do
--|#line 2205 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2205")
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

	yy_do_action_374 is
			--|#line 2207 "et_eiffel_parser.y"
		local
			yyval32: ET_ALIAS_NAME
		do
--|#line 2207 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2207")
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

	yy_do_action_375 is
			--|#line 2209 "et_eiffel_parser.y"
		local
			yyval32: ET_ALIAS_NAME
		do
--|#line 2209 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2209")
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

	yy_do_action_376 is
			--|#line 2211 "et_eiffel_parser.y"
		local
			yyval32: ET_ALIAS_NAME
		do
--|#line 2211 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2211")
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

	yy_do_action_377 is
			--|#line 2213 "et_eiffel_parser.y"
		local
			yyval32: ET_ALIAS_NAME
		do
--|#line 2213 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2213")
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

	yy_do_action_378 is
			--|#line 2215 "et_eiffel_parser.y"
		local
			yyval32: ET_ALIAS_NAME
		do
--|#line 2215 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2215")
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

	yy_do_action_379 is
			--|#line 2217 "et_eiffel_parser.y"
		local
			yyval32: ET_ALIAS_NAME
		do
--|#line 2217 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2217")
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

	yy_do_action_380 is
			--|#line 2219 "et_eiffel_parser.y"
		local
			yyval32: ET_ALIAS_NAME
		do
--|#line 2219 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2219")
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

	yy_do_action_381 is
			--|#line 2221 "et_eiffel_parser.y"
		local
			yyval32: ET_ALIAS_NAME
		do
--|#line 2221 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2221")
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

	yy_do_action_382 is
			--|#line 2224 "et_eiffel_parser.y"
		local
			yyval32: ET_ALIAS_NAME
		do
--|#line 2224 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2224")
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

	yy_do_action_383 is
			--|#line 2230 "et_eiffel_parser.y"
		local
			yyval73: ET_FORMAL_ARGUMENT_LIST
		do
--|#line 2230 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2230")
end

			yyval73 := yyvs73.item (yyvsp73)
			set_start_closure (yyval73)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs73.put (yyval73, yyvsp73)
end
		end

	yy_do_action_384 is
			--|#line 2237 "et_eiffel_parser.y"
		local
			yyval73: ET_FORMAL_ARGUMENT_LIST
		do
--|#line 2237 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2237")
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

	yy_do_action_385 is
			--|#line 2239 "et_eiffel_parser.y"
		local
			yyval73: ET_FORMAL_ARGUMENT_LIST
		do
--|#line 2239 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2239")
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

	yy_do_action_386 is
			--|#line 2247 "et_eiffel_parser.y"
		local
			yyval5: ET_SYMBOL
		do
--|#line 2247 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2247")
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

	yy_do_action_387 is
			--|#line 2258 "et_eiffel_parser.y"
		local
			yyval73: ET_FORMAL_ARGUMENT_LIST
		do
--|#line 2258 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2258")
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

	yy_do_action_388 is
			--|#line 2265 "et_eiffel_parser.y"
		local
			yyval73: ET_FORMAL_ARGUMENT_LIST
		do
--|#line 2265 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2265")
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

	yy_do_action_389 is
			--|#line 2272 "et_eiffel_parser.y"
		local
			yyval73: ET_FORMAL_ARGUMENT_LIST
		do
--|#line 2272 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2272")
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

	yy_do_action_390 is
			--|#line 2282 "et_eiffel_parser.y"
		local
			yyval73: ET_FORMAL_ARGUMENT_LIST
		do
--|#line 2282 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2282")
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

	yy_do_action_391 is
			--|#line 2293 "et_eiffel_parser.y"
		local
			yyval73: ET_FORMAL_ARGUMENT_LIST
		do
--|#line 2293 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2293")
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

	yy_do_action_392 is
			--|#line 2300 "et_eiffel_parser.y"
		local
			yyval73: ET_FORMAL_ARGUMENT_LIST
		do
--|#line 2300 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2300")
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

	yy_do_action_393 is
			--|#line 2309 "et_eiffel_parser.y"
		local
			yyval71: ET_FORMAL_ARGUMENT
		do
--|#line 2309 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2309")
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

	yy_do_action_394 is
			--|#line 2318 "et_eiffel_parser.y"
		local
			yyval71: ET_FORMAL_ARGUMENT
		do
--|#line 2318 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2318")
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

	yy_do_action_395 is
			--|#line 2327 "et_eiffel_parser.y"
		local
			yyval72: ET_FORMAL_ARGUMENT_ITEM
		do
--|#line 2327 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2327")
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

	yy_do_action_396 is
			--|#line 2336 "et_eiffel_parser.y"
		local
			yyval72: ET_FORMAL_ARGUMENT_ITEM
		do
--|#line 2336 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2336")
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

	yy_do_action_397 is
			--|#line 2347 "et_eiffel_parser.y"
		local
			yyval91: ET_LOCAL_VARIABLE_LIST
		do
--|#line 2347 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2347")
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

	yy_do_action_398 is
			--|#line 2349 "et_eiffel_parser.y"
		local
			yyval91: ET_LOCAL_VARIABLE_LIST
		do
--|#line 2349 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2349")
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

	yy_do_action_399 is
			--|#line 2351 "et_eiffel_parser.y"
		local
			yyval91: ET_LOCAL_VARIABLE_LIST
		do
--|#line 2351 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2351")
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

	yy_do_action_400 is
			--|#line 2351 "et_eiffel_parser.y"
		local
			yyval91: ET_LOCAL_VARIABLE_LIST
		do
--|#line 2351 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2351")
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

	yy_do_action_401 is
			--|#line 2364 "et_eiffel_parser.y"
		local
			yyval91: ET_LOCAL_VARIABLE_LIST
		do
--|#line 2364 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2364")
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

	yy_do_action_402 is
			--|#line 2371 "et_eiffel_parser.y"
		local
			yyval91: ET_LOCAL_VARIABLE_LIST
		do
--|#line 2371 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2371")
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

	yy_do_action_403 is
			--|#line 2378 "et_eiffel_parser.y"
		local
			yyval91: ET_LOCAL_VARIABLE_LIST
		do
--|#line 2378 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2378")
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

	yy_do_action_404 is
			--|#line 2388 "et_eiffel_parser.y"
		local
			yyval91: ET_LOCAL_VARIABLE_LIST
		do
--|#line 2388 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2388")
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

	yy_do_action_405 is
			--|#line 2399 "et_eiffel_parser.y"
		local
			yyval91: ET_LOCAL_VARIABLE_LIST
		do
--|#line 2399 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2399")
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

	yy_do_action_406 is
			--|#line 2406 "et_eiffel_parser.y"
		local
			yyval91: ET_LOCAL_VARIABLE_LIST
		do
--|#line 2406 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2406")
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

	yy_do_action_407 is
			--|#line 2415 "et_eiffel_parser.y"
		local
			yyval89: ET_LOCAL_VARIABLE
		do
--|#line 2415 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2415")
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

	yy_do_action_408 is
			--|#line 2424 "et_eiffel_parser.y"
		local
			yyval89: ET_LOCAL_VARIABLE
		do
--|#line 2424 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2424")
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

	yy_do_action_409 is
			--|#line 2433 "et_eiffel_parser.y"
		local
			yyval90: ET_LOCAL_VARIABLE_ITEM
		do
--|#line 2433 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2433")
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

	yy_do_action_410 is
			--|#line 2442 "et_eiffel_parser.y"
		local
			yyval90: ET_LOCAL_VARIABLE_ITEM
		do
--|#line 2442 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2442")
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

	yy_do_action_411 is
			--|#line 2453 "et_eiffel_parser.y"
		local
			yyval1: ANY
		do
--|#line 2453 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2453")
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

	yy_do_action_412 is
			--|#line 2455 "et_eiffel_parser.y"
		local
			yyval1: ANY
		do
--|#line 2455 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2455")
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

	yy_do_action_413 is
			--|#line 2457 "et_eiffel_parser.y"
		local
			yyval1: ANY
		do
--|#line 2457 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2457")
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

	yy_do_action_414 is
			--|#line 2459 "et_eiffel_parser.y"
		local
			yyval1: ANY
		do
--|#line 2459 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2459")
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

	yy_do_action_415 is
			--|#line 2461 "et_eiffel_parser.y"
		local
			yyval1: ANY
		do
--|#line 2461 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2461")
end

add_expression_assertion (yyvs62.item (yyvsp62), Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp62 := yyvsp62 -1
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_416 is
			--|#line 2463 "et_eiffel_parser.y"
		local
			yyval1: ANY
		do
--|#line 2463 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2463")
end

add_expression_assertion (yyvs62.item (yyvsp62), yyvs22.item (yyvsp22)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 -1
	yyvsp22 := yyvsp22 -1
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_417 is
			--|#line 2465 "et_eiffel_parser.y"
		local
			yyval1: ANY
		do
--|#line 2465 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2465")
end

add_tagged_assertion (yyvs13.item (yyvsp13), yyvs5.item (yyvsp5), Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp13 := yyvsp13 -1
	yyvsp5 := yyvsp5 -1
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_418 is
			--|#line 2467 "et_eiffel_parser.y"
		local
			yyval1: ANY
		do
--|#line 2467 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2467")
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

	yy_do_action_419 is
			--|#line 2471 "et_eiffel_parser.y"
		local
			yyval104: ET_PRECONDITIONS
		do
--|#line 2471 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2471")
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

	yy_do_action_420 is
			--|#line 2473 "et_eiffel_parser.y"
		local
			yyval104: ET_PRECONDITIONS
		do
--|#line 2473 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2473")
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

	yy_do_action_421 is
			--|#line 2475 "et_eiffel_parser.y"
		local
			yyval104: ET_PRECONDITIONS
		do
--|#line 2475 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2475")
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

	yy_do_action_422 is
			--|#line 2477 "et_eiffel_parser.y"
		local
			yyval104: ET_PRECONDITIONS
		do
--|#line 2477 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2477")
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

	yy_do_action_423 is
			--|#line 2479 "et_eiffel_parser.y"
		local
			yyval104: ET_PRECONDITIONS
		do
--|#line 2479 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2479")
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

	yy_do_action_424 is
			--|#line 2483 "et_eiffel_parser.y"
		local
			yyval103: ET_POSTCONDITIONS
		do
--|#line 2483 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2483")
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

	yy_do_action_425 is
			--|#line 2485 "et_eiffel_parser.y"
		local
			yyval103: ET_POSTCONDITIONS
		do
--|#line 2485 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2485")
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

	yy_do_action_426 is
			--|#line 2487 "et_eiffel_parser.y"
		local
			yyval103: ET_POSTCONDITIONS
		do
--|#line 2487 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2487")
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

	yy_do_action_427 is
			--|#line 2489 "et_eiffel_parser.y"
		local
			yyval103: ET_POSTCONDITIONS
		do
--|#line 2489 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2489")
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

	yy_do_action_428 is
			--|#line 2491 "et_eiffel_parser.y"
		local
			yyval103: ET_POSTCONDITIONS
		do
--|#line 2491 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2491")
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

	yy_do_action_429 is
			--|#line 2495 "et_eiffel_parser.y"
		local
			yyval86: ET_INVARIANTS
		do
--|#line 2495 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2495")
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

	yy_do_action_430 is
			--|#line 2497 "et_eiffel_parser.y"
		local
			yyval86: ET_INVARIANTS
		do
--|#line 2497 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2497")
end

yyval86 := yyvs86.item (yyvsp86) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs86.put (yyval86, yyvsp86)
end
		end

	yy_do_action_431 is
			--|#line 2501 "et_eiffel_parser.y"
		local
			yyval86: ET_INVARIANTS
		do
--|#line 2501 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2501")
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

	yy_do_action_432 is
			--|#line 2503 "et_eiffel_parser.y"
		local
			yyval86: ET_INVARIANTS
		do
--|#line 2503 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2503")
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

	yy_do_action_433 is
			--|#line 2507 "et_eiffel_parser.y"
		local
			yyval1: ANY
		do
--|#line 2507 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2507")
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

	yy_do_action_434 is
			--|#line 2511 "et_eiffel_parser.y"
		local
			yyval92: ET_LOOP_INVARIANTS
		do
--|#line 2511 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2511")
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

	yy_do_action_435 is
			--|#line 2513 "et_eiffel_parser.y"
		local
			yyval92: ET_LOOP_INVARIANTS
		do
--|#line 2513 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2513")
end

yyval92 := yyvs92.item (yyvsp92) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs92.put (yyval92, yyvsp92)
end
		end

	yy_do_action_436 is
			--|#line 2517 "et_eiffel_parser.y"
		local
			yyval92: ET_LOOP_INVARIANTS
		do
--|#line 2517 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2517")
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

	yy_do_action_437 is
			--|#line 2519 "et_eiffel_parser.y"
		local
			yyval92: ET_LOOP_INVARIANTS
		do
--|#line 2519 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2519")
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

	yy_do_action_438 is
			--|#line 2523 "et_eiffel_parser.y"
		local
			yyval115: ET_VARIANT
		do
--|#line 2523 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2523")
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

	yy_do_action_439 is
			--|#line 2525 "et_eiffel_parser.y"
		local
			yyval115: ET_VARIANT
		do
--|#line 2525 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2525")
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

	yy_do_action_440 is
			--|#line 2527 "et_eiffel_parser.y"
		local
			yyval115: ET_VARIANT
		do
--|#line 2527 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2527")
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

	yy_do_action_441 is
			--|#line 2533 "et_eiffel_parser.y"
		local
			yyval45: ET_COMPOUND
		do
--|#line 2533 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2533")
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

	yy_do_action_442 is
			--|#line 2535 "et_eiffel_parser.y"
		local
			yyval45: ET_COMPOUND
		do
--|#line 2535 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2535")
end

yyval45 := yyvs45.item (yyvsp45) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs45.put (yyval45, yyvsp45)
end
		end

	yy_do_action_443 is
			--|#line 2541 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2541 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2541")
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

	yy_do_action_444 is
			--|#line 2543 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2543 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2543")
end

yyval112 := yyvs112.item (yyvsp112) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs112.put (yyval112, yyvsp112)
end
		end

	yy_do_action_445 is
			--|#line 2547 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2547 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2547")
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

	yy_do_action_446 is
			--|#line 2549 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2549 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2549")
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

	yy_do_action_447 is
			--|#line 2551 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2551 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2551")
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

	yy_do_action_448 is
			--|#line 2553 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2553 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2553")
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

	yy_do_action_449 is
			--|#line 2555 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2555 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2555")
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

	yy_do_action_450 is
			--|#line 2557 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2557 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2557")
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
			--|#line 2559 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2559 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2559")
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

	yy_do_action_452 is
			--|#line 2567 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2567 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2567")
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

	yy_do_action_453 is
			--|#line 2575 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2575 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2575")
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

	yy_do_action_454 is
			--|#line 2577 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2577 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2577")
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

	yy_do_action_455 is
			--|#line 2579 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2579 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2579")
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

	yy_do_action_456 is
			--|#line 2581 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2581 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2581")
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

	yy_do_action_457 is
			--|#line 2583 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2583 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2583")
end

yyval112 := new_tuple_type (yyvs2.item (yyvsp2), yyvs13.item (yyvsp13), yyvs27.item (yyvsp27)) 
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

	yy_do_action_458 is
			--|#line 2585 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2585 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2585")
end

yyval112 := new_tuple_type (yyvs2.item (yyvsp2), yyvs13.item (yyvsp13), yyvs27.item (yyvsp27)) 
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

	yy_do_action_459 is
			--|#line 2587 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2587 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2587")
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
			--|#line 2595 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2595 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2595")
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
			--|#line 2605 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2605 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2605")
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

	yy_do_action_462 is
			--|#line 2607 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2607 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2607")
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

	yy_do_action_463 is
			--|#line 2609 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2609 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2609")
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
			--|#line 2611 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2611 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2611")
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
			--|#line 2613 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2613 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2613")
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
			--|#line 2615 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2615 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2615")
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

	yy_do_action_467 is
			--|#line 2617 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2617 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2617")
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

	yy_do_action_468 is
			--|#line 2625 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2625 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2625")
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

	yy_do_action_469 is
			--|#line 2633 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2633 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2633")
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

	yy_do_action_470 is
			--|#line 2635 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2635 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2635")
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

	yy_do_action_471 is
			--|#line 2637 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2637 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2637")
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

	yy_do_action_472 is
			--|#line 2639 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2639 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2639")
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

	yy_do_action_473 is
			--|#line 2641 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2641 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2641")
end

yyval112 := new_tuple_type (yyvs2.item (yyvsp2), yyvs13.item (yyvsp13), yyvs27.item (yyvsp27)) 
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

	yy_do_action_474 is
			--|#line 2643 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2643 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2643")
end

yyval112 := new_tuple_type (yyvs2.item (yyvsp2), yyvs13.item (yyvsp13), yyvs27.item (yyvsp27)) 
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

	yy_do_action_475 is
			--|#line 2645 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2645 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2645")
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

	yy_do_action_476 is
			--|#line 2653 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2653 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2653")
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

	yy_do_action_477 is
			--|#line 2663 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2663 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2663")
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

	yy_do_action_478 is
			--|#line 2665 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2665 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2665")
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

	yy_do_action_479 is
			--|#line 2667 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2667 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2667")
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

	yy_do_action_480 is
			--|#line 2669 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2669 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2669")
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

	yy_do_action_481 is
			--|#line 2671 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2671 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2671")
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

	yy_do_action_482 is
			--|#line 2673 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2673 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2673")
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

	yy_do_action_483 is
			--|#line 2675 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2675 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2675")
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

	yy_do_action_484 is
			--|#line 2677 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2677 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2677")
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

	yy_do_action_485 is
			--|#line 2685 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2685 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2685")
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

	yy_do_action_486 is
			--|#line 2693 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2693 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2693")
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

	yy_do_action_487 is
			--|#line 2695 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2695 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2695")
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

	yy_do_action_488 is
			--|#line 2697 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2697 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2697")
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

	yy_do_action_489 is
			--|#line 2699 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2699 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2699")
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

	yy_do_action_490 is
			--|#line 2701 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2701 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2701")
end

yyval112 := new_tuple_type (yyvs2.item (yyvsp2), yyvs13.item (yyvsp13), yyvs27.item (yyvsp27)) 
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

	yy_do_action_491 is
			--|#line 2703 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2703 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2703")
end

yyval112 := new_tuple_type (yyvs2.item (yyvsp2), yyvs13.item (yyvsp13), yyvs27.item (yyvsp27)) 
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

	yy_do_action_492 is
			--|#line 2705 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2705 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2705")
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

	yy_do_action_493 is
			--|#line 2713 "et_eiffel_parser.y"
		local
			yyval112: ET_TYPE
		do
--|#line 2713 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2713")
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

	yy_do_action_494 is
			--|#line 2723 "et_eiffel_parser.y"
		local
			yyval13: ET_IDENTIFIER
		do
--|#line 2723 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2723")
end

yyval13 := yyvs13.item (yyvsp13) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs13.put (yyval13, yyvsp13)
end
		end

	yy_do_action_495 is
			--|#line 2727 "et_eiffel_parser.y"
		local
			yyval27: ET_ACTUAL_PARAMETER_LIST
		do
--|#line 2727 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2727")
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

	yy_do_action_496 is
			--|#line 2729 "et_eiffel_parser.y"
		local
			yyval27: ET_ACTUAL_PARAMETER_LIST
		do
--|#line 2729 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2729")
end

yyval27 := yyvs27.item (yyvsp27) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs27.put (yyval27, yyvsp27)
end
		end

	yy_do_action_497 is
			--|#line 2733 "et_eiffel_parser.y"
		local
			yyval27: ET_ACTUAL_PARAMETER_LIST
		do
--|#line 2733 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2733")
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

	yy_do_action_498 is
			--|#line 2736 "et_eiffel_parser.y"
		local
			yyval27: ET_ACTUAL_PARAMETER_LIST
		do
--|#line 2736 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2736")
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

	yy_do_action_499 is
			--|#line 2744 "et_eiffel_parser.y"
		local
			yyval1: ANY
		do
--|#line 2744 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2744")
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

	yy_do_action_500 is
			--|#line 2751 "et_eiffel_parser.y"
		local
			yyval27: ET_ACTUAL_PARAMETER_LIST
		do
--|#line 2751 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2751")
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

	yy_do_action_501 is
			--|#line 2762 "et_eiffel_parser.y"
		local
			yyval27: ET_ACTUAL_PARAMETER_LIST
		do
--|#line 2762 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2762")
end

			yyval27 := yyvs27.item (yyvsp27)
			add_to_actual_parameter_list (yyvs26.item (yyvsp26), yyval27)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp26 := yyvsp26 -1
	yyvs27.put (yyval27, yyvsp27)
end
		end

	yy_do_action_502 is
			--|#line 2767 "et_eiffel_parser.y"
		local
			yyval27: ET_ACTUAL_PARAMETER_LIST
		do
--|#line 2767 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2767")
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

	yy_do_action_503 is
			--|#line 2772 "et_eiffel_parser.y"
		local
			yyval27: ET_ACTUAL_PARAMETER_LIST
		do
--|#line 2772 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2772")
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

	yy_do_action_504 is
			--|#line 2779 "et_eiffel_parser.y"
		local
			yyval1: ANY
		do
--|#line 2779 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2779")
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

	yy_do_action_505 is
			--|#line 2785 "et_eiffel_parser.y"
		local
			yyval26: ET_ACTUAL_PARAMETER_ITEM
		do
--|#line 2785 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2785")
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

	yy_do_action_506 is
			--|#line 2794 "et_eiffel_parser.y"
		local
			yyval27: ET_ACTUAL_PARAMETER_LIST
		do
--|#line 2794 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2794")
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

	yy_do_action_507 is
			--|#line 2796 "et_eiffel_parser.y"
		local
			yyval27: ET_ACTUAL_PARAMETER_LIST
		do
--|#line 2796 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2796")
end

yyval27 := yyvs27.item (yyvsp27) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs27.put (yyval27, yyvsp27)
end
		end

	yy_do_action_508 is
			--|#line 2800 "et_eiffel_parser.y"
		local
			yyval27: ET_ACTUAL_PARAMETER_LIST
		do
--|#line 2800 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2800")
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

	yy_do_action_509 is
			--|#line 2803 "et_eiffel_parser.y"
		local
			yyval27: ET_ACTUAL_PARAMETER_LIST
		do
--|#line 2803 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2803")
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

	yy_do_action_510 is
			--|#line 2809 "et_eiffel_parser.y"
		local
			yyval27: ET_ACTUAL_PARAMETER_LIST
		do
--|#line 2809 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2809")
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

	yy_do_action_511 is
			--|#line 2817 "et_eiffel_parser.y"
		local
			yyval27: ET_ACTUAL_PARAMETER_LIST
		do
--|#line 2817 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2817")
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

	yy_do_action_512 is
			--|#line 2822 "et_eiffel_parser.y"
		local
			yyval27: ET_ACTUAL_PARAMETER_LIST
		do
--|#line 2822 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2822")
end

			yyval27 := yyvs27.item (yyvsp27)
			add_to_actual_parameter_list (yyvs26.item (yyvsp26), yyvs27.item (yyvsp27))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp26 := yyvsp26 -1
	yyvs27.put (yyval27, yyvsp27)
end
		end

	yy_do_action_513 is
			--|#line 2827 "et_eiffel_parser.y"
		local
			yyval27: ET_ACTUAL_PARAMETER_LIST
		do
--|#line 2827 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2827")
end

			yyval27 := yyvs27.item (yyvsp27)
			add_to_actual_parameter_list (yyvs26.item (yyvsp26), yyvs27.item (yyvsp27))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp26 := yyvsp26 -1
	yyvs27.put (yyval27, yyvsp27)
end
		end

	yy_do_action_514 is
			--|#line 2832 "et_eiffel_parser.y"
		local
			yyval27: ET_ACTUAL_PARAMETER_LIST
		do
--|#line 2832 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2832")
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

	yy_do_action_515 is
			--|#line 2843 "et_eiffel_parser.y"
		local
			yyval27: ET_ACTUAL_PARAMETER_LIST
		do
--|#line 2843 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2843")
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

	yy_do_action_516 is
			--|#line 2854 "et_eiffel_parser.y"
		local
			yyval27: ET_ACTUAL_PARAMETER_LIST
		do
--|#line 2854 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2854")
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

	yy_do_action_517 is
			--|#line 2867 "et_eiffel_parser.y"
		local
			yyval26: ET_ACTUAL_PARAMETER_ITEM
		do
--|#line 2867 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2867")
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

	yy_do_action_518 is
			--|#line 2876 "et_eiffel_parser.y"
		local
			yyval26: ET_ACTUAL_PARAMETER_ITEM
		do
--|#line 2876 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2876")
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

	yy_do_action_519 is
			--|#line 2885 "et_eiffel_parser.y"
		local
			yyval88: ET_LIKE_TYPE
		do
--|#line 2885 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2885")
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

	yy_do_action_520 is
			--|#line 2887 "et_eiffel_parser.y"
		local
			yyval88: ET_LIKE_TYPE
		do
--|#line 2887 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2887")
end

yyval88 := ast_factory.new_like_feature (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2), yyvs13.item (yyvsp13)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp88 := yyvsp88 + 1
	yyvsp2 := yyvsp2 -2
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

	yy_do_action_521 is
			--|#line 2889 "et_eiffel_parser.y"
		local
			yyval88: ET_LIKE_TYPE
		do
--|#line 2889 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2889")
end

yyval88 := ast_factory.new_like_feature (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2), yyvs13.item (yyvsp13)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp88 := yyvsp88 + 1
	yyvsp2 := yyvsp2 -2
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

	yy_do_action_522 is
			--|#line 2891 "et_eiffel_parser.y"
		local
			yyval88: ET_LIKE_TYPE
		do
--|#line 2891 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2891")
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

	yy_do_action_523 is
			--|#line 2899 "et_eiffel_parser.y"
		local
			yyval88: ET_LIKE_TYPE
		do
--|#line 2899 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2899")
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

	yy_do_action_524 is
			--|#line 2907 "et_eiffel_parser.y"
		local
			yyval88: ET_LIKE_TYPE
		do
--|#line 2907 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2907")
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

	yy_do_action_525 is
			--|#line 2909 "et_eiffel_parser.y"
		local
			yyval88: ET_LIKE_TYPE
		do
--|#line 2909 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2909")
end

yyval88 := ast_factory.new_like_current (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2), yyvs11.item (yyvsp11)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp88 := yyvsp88 + 1
	yyvsp2 := yyvsp2 -2
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

	yy_do_action_526 is
			--|#line 2911 "et_eiffel_parser.y"
		local
			yyval88: ET_LIKE_TYPE
		do
--|#line 2911 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2911")
end

yyval88 := ast_factory.new_like_current (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2), yyvs11.item (yyvsp11)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp88 := yyvsp88 + 1
	yyvsp2 := yyvsp2 -2
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

	yy_do_action_527 is
			--|#line 2913 "et_eiffel_parser.y"
		local
			yyval88: ET_LIKE_TYPE
		do
--|#line 2913 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2913")
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

	yy_do_action_528 is
			--|#line 2921 "et_eiffel_parser.y"
		local
			yyval88: ET_LIKE_TYPE
		do
--|#line 2921 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2921")
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

	yy_do_action_529 is
			--|#line 2929 "et_eiffel_parser.y"
		local
			yyval88: ET_LIKE_TYPE
		do
--|#line 2929 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2929")
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

	yy_do_action_530 is
			--|#line 2933 "et_eiffel_parser.y"
		local
			yyval106: ET_QUALIFIED_LIKE_IDENTIFIER
		do
--|#line 2933 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2933")
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

	yy_do_action_531 is
			--|#line 2941 "et_eiffel_parser.y"
		local
			yyval106: ET_QUALIFIED_LIKE_IDENTIFIER
		do
--|#line 2941 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2941")
end

			if not current_system.qualified_anchored_types_enabled then
				raise_error
			else
				yyval106 := ast_factory.new_qualified_like_braced_type (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2), ast_factory.new_target_type (yyvs5.item (yyvsp5 - 2), yyvs112.item (yyvsp112), yyvs5.item (yyvsp5 - 1)), ast_factory.new_dot_feature_name (yyvs5.item (yyvsp5), yyvs13.item (yyvsp13)))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp106 := yyvsp106 + 1
	yyvsp2 := yyvsp2 -2
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

	yy_do_action_532 is
			--|#line 2949 "et_eiffel_parser.y"
		local
			yyval106: ET_QUALIFIED_LIKE_IDENTIFIER
		do
--|#line 2949 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2949")
end

			if not current_system.qualified_anchored_types_enabled then
				raise_error
			else
				yyval106 := ast_factory.new_qualified_like_braced_type (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2), ast_factory.new_target_type (yyvs5.item (yyvsp5 - 2), yyvs112.item (yyvsp112), yyvs5.item (yyvsp5 - 1)), ast_factory.new_dot_feature_name (yyvs5.item (yyvsp5), yyvs13.item (yyvsp13)))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp106 := yyvsp106 + 1
	yyvsp2 := yyvsp2 -2
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

	yy_do_action_533 is
			--|#line 2957 "et_eiffel_parser.y"
		local
			yyval106: ET_QUALIFIED_LIKE_IDENTIFIER
		do
--|#line 2957 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2957")
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

	yy_do_action_534 is
			--|#line 2967 "et_eiffel_parser.y"
		local
			yyval106: ET_QUALIFIED_LIKE_IDENTIFIER
		do
--|#line 2967 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2967")
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

	yy_do_action_535 is
			--|#line 2977 "et_eiffel_parser.y"
		local
			yyval106: ET_QUALIFIED_LIKE_IDENTIFIER
		do
--|#line 2977 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2977")
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

	yy_do_action_536 is
			--|#line 2989 "et_eiffel_parser.y"
		local
			yyval45: ET_COMPOUND
		do
--|#line 2989 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2989")
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

	yy_do_action_537 is
			--|#line 2991 "et_eiffel_parser.y"
		local
			yyval45: ET_COMPOUND
		do
--|#line 2991 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2991")
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

	yy_do_action_538 is
			--|#line 2998 "et_eiffel_parser.y"
		local
			yyval45: ET_COMPOUND
		do
--|#line 2998 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 2998")
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

	yy_do_action_539 is
			--|#line 3000 "et_eiffel_parser.y"
		local
			yyval45: ET_COMPOUND
		do
--|#line 3000 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3000")
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

	yy_do_action_540 is
			--|#line 3007 "et_eiffel_parser.y"
		local
			yyval45: ET_COMPOUND
		do
--|#line 3007 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3007")
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

	yy_do_action_541 is
			--|#line 3009 "et_eiffel_parser.y"
		local
			yyval45: ET_COMPOUND
		do
--|#line 3009 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3009")
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

	yy_do_action_542 is
			--|#line 3016 "et_eiffel_parser.y"
		local
			yyval45: ET_COMPOUND
		do
--|#line 3016 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3016")
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

	yy_do_action_543 is
			--|#line 3018 "et_eiffel_parser.y"
		local
			yyval45: ET_COMPOUND
		do
--|#line 3018 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3018")
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

	yy_do_action_544 is
			--|#line 3025 "et_eiffel_parser.y"
		local
			yyval45: ET_COMPOUND
		do
--|#line 3025 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3025")
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

	yy_do_action_545 is
			--|#line 3027 "et_eiffel_parser.y"
		local
			yyval45: ET_COMPOUND
		do
--|#line 3027 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3027")
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

	yy_do_action_546 is
			--|#line 3034 "et_eiffel_parser.y"
		local
			yyval45: ET_COMPOUND
		do
--|#line 3034 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3034")
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

	yy_do_action_547 is
			--|#line 3036 "et_eiffel_parser.y"
		local
			yyval45: ET_COMPOUND
		do
--|#line 3036 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3036")
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

	yy_do_action_548 is
			--|#line 3043 "et_eiffel_parser.y"
		local
			yyval45: ET_COMPOUND
		do
--|#line 3043 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3043")
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

	yy_do_action_549 is
			--|#line 3045 "et_eiffel_parser.y"
		local
			yyval45: ET_COMPOUND
		do
--|#line 3045 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3045")
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

	yy_do_action_550 is
			--|#line 3052 "et_eiffel_parser.y"
		local
			yyval45: ET_COMPOUND
		do
--|#line 3052 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3052")
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

	yy_do_action_551 is
			--|#line 3063 "et_eiffel_parser.y"
		local
			yyval45: ET_COMPOUND
		do
--|#line 3063 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3063")
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

	yy_do_action_552 is
			--|#line 3063 "et_eiffel_parser.y"
		local
			yyval45: ET_COMPOUND
		do
--|#line 3063 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3063")
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

	yy_do_action_553 is
			--|#line 3084 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3084 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3084")
end

yyval85 := yyvs85.item (yyvsp85) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs85.put (yyval85, yyvsp85)
end
		end

	yy_do_action_554 is
			--|#line 3086 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3086 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3086")
end

yyval85 := yyvs85.item (yyvsp85) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs85.put (yyval85, yyvsp85)
end
		end

	yy_do_action_555 is
			--|#line 3088 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3088 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3088")
end

yyval85 := yyvs85.item (yyvsp85) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs85.put (yyval85, yyvsp85)
end
		end

	yy_do_action_556 is
			--|#line 3090 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3090 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3090")
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

	yy_do_action_557 is
			--|#line 3092 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3092 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3092")
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

	yy_do_action_558 is
			--|#line 3094 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3094 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3094")
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

	yy_do_action_559 is
			--|#line 3096 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3096 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3096")
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

	yy_do_action_560 is
			--|#line 3098 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3098 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3098")
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

	yy_do_action_561 is
			--|#line 3100 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3100 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3100")
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

	yy_do_action_562 is
			--|#line 3102 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3102 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3102")
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

	yy_do_action_563 is
			--|#line 3104 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3104 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3104")
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

	yy_do_action_564 is
			--|#line 3112 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3112 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3112")
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

	yy_do_action_565 is
			--|#line 3125 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3125 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3125")
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

	yy_do_action_566 is
			--|#line 3127 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3127 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3127")
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

	yy_do_action_567 is
			--|#line 3129 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3129 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3129")
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

	yy_do_action_568 is
			--|#line 3131 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3131 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3131")
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

	yy_do_action_569 is
			--|#line 3133 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3133 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3133")
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

	yy_do_action_570 is
			--|#line 3139 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3139 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3139")
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

	yy_do_action_571 is
			--|#line 3141 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3141 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3141")
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

	yy_do_action_572 is
			--|#line 3143 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3143 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3143")
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

	yy_do_action_573 is
			--|#line 3145 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3145 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3145")
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

	yy_do_action_574 is
			--|#line 3149 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3149 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3149")
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

	yy_do_action_575 is
			--|#line 3151 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3151 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3151")
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

	yy_do_action_576 is
			--|#line 3153 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3153 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3153")
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

	yy_do_action_577 is
			--|#line 3155 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3155 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3155")
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

	yy_do_action_578 is
			--|#line 3159 "et_eiffel_parser.y"
		local
			yyval54: ET_CREATE_EXPRESSION
		do
--|#line 3159 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3159")
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

	yy_do_action_579 is
			--|#line 3161 "et_eiffel_parser.y"
		local
			yyval54: ET_CREATE_EXPRESSION
		do
--|#line 3161 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3161")
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

	yy_do_action_580 is
			--|#line 3167 "et_eiffel_parser.y"
		local
			yyval77: ET_IF_INSTRUCTION
		do
--|#line 3167 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3167")
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

	yy_do_action_581 is
			--|#line 3169 "et_eiffel_parser.y"
		local
			yyval77: ET_IF_INSTRUCTION
		do
--|#line 3169 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3169")
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

	yy_do_action_582 is
			--|#line 3171 "et_eiffel_parser.y"
		local
			yyval77: ET_IF_INSTRUCTION
		do
--|#line 3171 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3171")
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

	yy_do_action_583 is
			--|#line 3173 "et_eiffel_parser.y"
		local
			yyval77: ET_IF_INSTRUCTION
		do
--|#line 3173 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3173")
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

	yy_do_action_584 is
			--|#line 3177 "et_eiffel_parser.y"
		local
			yyval59: ET_ELSEIF_PART_LIST
		do
--|#line 3177 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3177")
end

			yyval59 := yyvs59.item (yyvsp59)
			remove_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs59.put (yyval59, yyvsp59)
end
		end

	yy_do_action_585 is
			--|#line 3184 "et_eiffel_parser.y"
		local
			yyval59: ET_ELSEIF_PART_LIST
		do
--|#line 3184 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3184")
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

	yy_do_action_586 is
			--|#line 3191 "et_eiffel_parser.y"
		local
			yyval59: ET_ELSEIF_PART_LIST
		do
--|#line 3191 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3191")
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

	yy_do_action_587 is
			--|#line 3200 "et_eiffel_parser.y"
		local
			yyval58: ET_ELSEIF_PART
		do
--|#line 3200 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3200")
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

	yy_do_action_588 is
			--|#line 3211 "et_eiffel_parser.y"
		local
			yyval84: ET_INSPECT_INSTRUCTION
		do
--|#line 3211 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3211")
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

	yy_do_action_589 is
			--|#line 3213 "et_eiffel_parser.y"
		local
			yyval84: ET_INSPECT_INSTRUCTION
		do
--|#line 3213 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3213")
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

	yy_do_action_590 is
			--|#line 3217 "et_eiffel_parser.y"
		local
			yyval117: ET_WHEN_PART_LIST
		do
--|#line 3217 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3217")
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

	yy_do_action_591 is
			--|#line 3219 "et_eiffel_parser.y"
		local
			yyval117: ET_WHEN_PART_LIST
		do
--|#line 3219 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3219")
end

			yyval117 := yyvs117.item (yyvsp117)
			remove_counter
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs117.put (yyval117, yyvsp117)
end
		end

	yy_do_action_592 is
			--|#line 3226 "et_eiffel_parser.y"
		local
			yyval117: ET_WHEN_PART_LIST
		do
--|#line 3226 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3226")
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

	yy_do_action_593 is
			--|#line 3233 "et_eiffel_parser.y"
		local
			yyval117: ET_WHEN_PART_LIST
		do
--|#line 3233 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3233")
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

	yy_do_action_594 is
			--|#line 3242 "et_eiffel_parser.y"
		local
			yyval116: ET_WHEN_PART
		do
--|#line 3242 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3242")
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

	yy_do_action_595 is
			--|#line 3251 "et_eiffel_parser.y"
		local
			yyval41: ET_CHOICE_LIST
		do
--|#line 3251 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3251")
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

	yy_do_action_596 is
			--|#line 3253 "et_eiffel_parser.y"
		local
			yyval41: ET_CHOICE_LIST
		do
--|#line 3253 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3253")
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

	yy_do_action_597 is
			--|#line 3253 "et_eiffel_parser.y"
		local
			yyval41: ET_CHOICE_LIST
		do
--|#line 3253 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3253")
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

	yy_do_action_598 is
			--|#line 3266 "et_eiffel_parser.y"
		local
			yyval41: ET_CHOICE_LIST
		do
--|#line 3266 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3266")
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

	yy_do_action_599 is
			--|#line 3277 "et_eiffel_parser.y"
		local
			yyval41: ET_CHOICE_LIST
		do
--|#line 3277 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3277")
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

	yy_do_action_600 is
			--|#line 3285 "et_eiffel_parser.y"
		local
			yyval41: ET_CHOICE_LIST
		do
--|#line 3285 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3285")
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

	yy_do_action_601 is
			--|#line 3294 "et_eiffel_parser.y"
		local
			yyval40: ET_CHOICE_ITEM
		do
--|#line 3294 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3294")
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

	yy_do_action_602 is
			--|#line 3303 "et_eiffel_parser.y"
		local
			yyval38: ET_CHOICE
		do
--|#line 3303 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3303")
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

	yy_do_action_603 is
			--|#line 3305 "et_eiffel_parser.y"
		local
			yyval38: ET_CHOICE
		do
--|#line 3305 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3305")
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

	yy_do_action_604 is
			--|#line 3309 "et_eiffel_parser.y"
		local
			yyval39: ET_CHOICE_CONSTANT
		do
--|#line 3309 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3309")
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

	yy_do_action_605 is
			--|#line 3311 "et_eiffel_parser.y"
		local
			yyval39: ET_CHOICE_CONSTANT
		do
--|#line 3311 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3311")
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

	yy_do_action_606 is
			--|#line 3313 "et_eiffel_parser.y"
		local
			yyval39: ET_CHOICE_CONSTANT
		do
--|#line 3313 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3313")
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

	yy_do_action_607 is
			--|#line 3315 "et_eiffel_parser.y"
		local
			yyval39: ET_CHOICE_CONSTANT
		do
--|#line 3315 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3315")
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

	yy_do_action_608 is
			--|#line 3321 "et_eiffel_parser.y"
		local
			yyval57: ET_DEBUG_INSTRUCTION
		do
--|#line 3321 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3321")
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

	yy_do_action_609 is
			--|#line 3323 "et_eiffel_parser.y"
		local
			yyval57: ET_DEBUG_INSTRUCTION
		do
--|#line 3323 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3323")
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

	yy_do_action_610 is
			--|#line 3330 "et_eiffel_parser.y"
		local
			yyval95: ET_MANIFEST_STRING_LIST
		do
--|#line 3330 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3330")
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

	yy_do_action_611 is
			--|#line 3332 "et_eiffel_parser.y"
		local
			yyval95: ET_MANIFEST_STRING_LIST
		do
--|#line 3332 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3332")
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

	yy_do_action_612 is
			--|#line 3334 "et_eiffel_parser.y"
		local
			yyval95: ET_MANIFEST_STRING_LIST
		do
--|#line 3334 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3334")
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

	yy_do_action_613 is
			--|#line 3334 "et_eiffel_parser.y"
		local
			yyval95: ET_MANIFEST_STRING_LIST
		do
--|#line 3334 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3334")
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

	yy_do_action_614 is
			--|#line 3347 "et_eiffel_parser.y"
		local
			yyval95: ET_MANIFEST_STRING_LIST
		do
--|#line 3347 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3347")
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

	yy_do_action_615 is
			--|#line 3358 "et_eiffel_parser.y"
		local
			yyval95: ET_MANIFEST_STRING_LIST
		do
--|#line 3358 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3358")
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

	yy_do_action_616 is
			--|#line 3367 "et_eiffel_parser.y"
		local
			yyval94: ET_MANIFEST_STRING_ITEM
		do
--|#line 3367 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3367")
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

	yy_do_action_617 is
			--|#line 3378 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3378 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3378")
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

	yy_do_action_618 is
			--|#line 3380 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3380 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3380")
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

	yy_do_action_619 is
			--|#line 3382 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3382 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3382")
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

	yy_do_action_620 is
			--|#line 3384 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3384 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3384")
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

	yy_do_action_621 is
			--|#line 3386 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3386 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3386")
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

	yy_do_action_622 is
			--|#line 3388 "et_eiffel_parser.y"
		local
			yyval85: ET_INSTRUCTION
		do
--|#line 3388 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3388")
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

	yy_do_action_623 is
			--|#line 3392 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3392 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3392")
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

	yy_do_action_624 is
			--|#line 3394 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3394 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3394")
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

	yy_do_action_625 is
			--|#line 3398 "et_eiffel_parser.y"
		local
			yyval37: ET_CALL_EXPRESSION
		do
--|#line 3398 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3398")
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

	yy_do_action_626 is
			--|#line 3402 "et_eiffel_parser.y"
		local
			yyval110: ET_STATIC_CALL_EXPRESSION
		do
--|#line 3402 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3402")
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

	yy_do_action_627 is
			--|#line 3404 "et_eiffel_parser.y"
		local
			yyval110: ET_STATIC_CALL_EXPRESSION
		do
--|#line 3404 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3404")
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

	yy_do_action_628 is
			--|#line 3408 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3408 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3408")
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

	yy_do_action_629 is
			--|#line 3410 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3410 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3410")
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

	yy_do_action_630 is
			--|#line 3414 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3414 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3414")
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

	yy_do_action_631 is
			--|#line 3416 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3416 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3416")
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

	yy_do_action_632 is
			--|#line 3418 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3418 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3418")
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

	yy_do_action_633 is
			--|#line 3420 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3420 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3420")
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

	yy_do_action_634 is
			--|#line 3422 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3422 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3422")
end

yyval62 := yyvs62.item (yyvsp62) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_635 is
			--|#line 3424 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3424 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3424")
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

	yy_do_action_636 is
			--|#line 3432 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3432 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3432")
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

	yy_do_action_637 is
			--|#line 3434 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3434 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3434")
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

	yy_do_action_638 is
			--|#line 3440 "et_eiffel_parser.y"
		local
			yyval25: ET_ACTUAL_ARGUMENT_LIST
		do
--|#line 3440 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3440")
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

	yy_do_action_639 is
			--|#line 3442 "et_eiffel_parser.y"
		local
			yyval25: ET_ACTUAL_ARGUMENT_LIST
		do
--|#line 3442 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3442")
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

	yy_do_action_640 is
			--|#line 3444 "et_eiffel_parser.y"
		local
			yyval25: ET_ACTUAL_ARGUMENT_LIST
		do
--|#line 3444 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3444")
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

	yy_do_action_641 is
			--|#line 3444 "et_eiffel_parser.y"
		local
			yyval25: ET_ACTUAL_ARGUMENT_LIST
		do
--|#line 3444 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3444")
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

	yy_do_action_642 is
			--|#line 3457 "et_eiffel_parser.y"
		local
			yyval25: ET_ACTUAL_ARGUMENT_LIST
		do
--|#line 3457 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3457")
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

	yy_do_action_643 is
			--|#line 3468 "et_eiffel_parser.y"
		local
			yyval25: ET_ACTUAL_ARGUMENT_LIST
		do
--|#line 3468 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3468")
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

	yy_do_action_644 is
			--|#line 3476 "et_eiffel_parser.y"
		local
			yyval25: ET_ACTUAL_ARGUMENT_LIST
		do
--|#line 3476 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3476")
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

	yy_do_action_645 is
			--|#line 3485 "et_eiffel_parser.y"
		local
			yyval63: ET_EXPRESSION_ITEM
		do
--|#line 3485 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3485")
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

	yy_do_action_646 is
			--|#line 3494 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3494 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3494")
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

	yy_do_action_647 is
			--|#line 3496 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3496 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3496")
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

	yy_do_action_648 is
			--|#line 3498 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3498 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3498")
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

	yy_do_action_649 is
			--|#line 3500 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3500 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3500")
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

	yy_do_action_650 is
			--|#line 3507 "et_eiffel_parser.y"
		local
			yyval118: ET_WRITABLE
		do
--|#line 3507 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3507")
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

	yy_do_action_651 is
			--|#line 3509 "et_eiffel_parser.y"
		local
			yyval118: ET_WRITABLE
		do
--|#line 3509 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3509")
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

	yy_do_action_652 is
			--|#line 3515 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3515 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3515")
end

yyval62 := yyvs62.item (yyvsp62) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_653 is
			--|#line 3517 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3517 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3517")
end

yyval62 := yyvs62.item (yyvsp62) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_654 is
			--|#line 3521 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3521 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3521")
end

yyval62 := ast_factory.new_infix_expression (yyvs62.item (yyvsp62 - 1), ast_factory.new_infix_free_operator (yyvs12.item (yyvsp12)), yyvs62.item (yyvsp62)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 -1
	yyvsp12 := yyvsp12 -1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_655 is
			--|#line 3523 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3523 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3523")
end

yyval62 := ast_factory.new_infix_expression (yyvs62.item (yyvsp62 - 1), ast_factory.new_infix_plus_operator (yyvs20.item (yyvsp20)), yyvs62.item (yyvsp62)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 -1
	yyvsp20 := yyvsp20 -1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_656 is
			--|#line 3525 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3525 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3525")
end

yyval62 := ast_factory.new_infix_expression (yyvs62.item (yyvsp62 - 1), ast_factory.new_infix_minus_operator (yyvs20.item (yyvsp20)), yyvs62.item (yyvsp62)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 -1
	yyvsp20 := yyvsp20 -1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_657 is
			--|#line 3527 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3527 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3527")
end

yyval62 := ast_factory.new_infix_expression (yyvs62.item (yyvsp62 - 1), yyvs20.item (yyvsp20), yyvs62.item (yyvsp62)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 -1
	yyvsp20 := yyvsp20 -1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_658 is
			--|#line 3529 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3529 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3529")
end

yyval62 := ast_factory.new_infix_expression (yyvs62.item (yyvsp62 - 1), yyvs20.item (yyvsp20), yyvs62.item (yyvsp62)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 -1
	yyvsp20 := yyvsp20 -1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_659 is
			--|#line 3531 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3531 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3531")
end

yyval62 := ast_factory.new_infix_expression (yyvs62.item (yyvsp62 - 1), yyvs20.item (yyvsp20), yyvs62.item (yyvsp62)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 -1
	yyvsp20 := yyvsp20 -1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_660 is
			--|#line 3533 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3533 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3533")
end

yyval62 := ast_factory.new_infix_expression (yyvs62.item (yyvsp62 - 1), yyvs20.item (yyvsp20), yyvs62.item (yyvsp62)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 -1
	yyvsp20 := yyvsp20 -1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_661 is
			--|#line 3535 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3535 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3535")
end

yyval62 := ast_factory.new_infix_expression (yyvs62.item (yyvsp62 - 1), yyvs20.item (yyvsp20), yyvs62.item (yyvsp62)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 -1
	yyvsp20 := yyvsp20 -1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_662 is
			--|#line 3537 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3537 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3537")
end

yyval62 := ast_factory.new_infix_expression (yyvs62.item (yyvsp62 - 1), yyvs20.item (yyvsp20), yyvs62.item (yyvsp62)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 -1
	yyvsp20 := yyvsp20 -1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_663 is
			--|#line 3539 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3539 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3539")
end

yyval62 := ast_factory.new_infix_expression (yyvs62.item (yyvsp62 - 1), yyvs20.item (yyvsp20), yyvs62.item (yyvsp62)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 -1
	yyvsp20 := yyvsp20 -1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_664 is
			--|#line 3541 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3541 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3541")
end

yyval62 := ast_factory.new_infix_expression (yyvs62.item (yyvsp62 - 1), yyvs20.item (yyvsp20), yyvs62.item (yyvsp62)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 -1
	yyvsp20 := yyvsp20 -1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_665 is
			--|#line 3543 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3543 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3543")
end

yyval62 := ast_factory.new_infix_expression (yyvs62.item (yyvsp62 - 1), yyvs20.item (yyvsp20), yyvs62.item (yyvsp62)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 -1
	yyvsp20 := yyvsp20 -1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_666 is
			--|#line 3545 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3545 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3545")
end

yyval62 := ast_factory.new_infix_expression (yyvs62.item (yyvsp62 - 1), yyvs15.item (yyvsp15), yyvs62.item (yyvsp62)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 -1
	yyvsp15 := yyvsp15 -1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_667 is
			--|#line 3547 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3547 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3547")
end

yyval62 := ast_factory.new_infix_expression (yyvs62.item (yyvsp62 - 1), yyvs15.item (yyvsp15), yyvs62.item (yyvsp62)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 -1
	yyvsp15 := yyvsp15 -1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_668 is
			--|#line 3549 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3549 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3549")
end

yyval62 := ast_factory.new_infix_expression (yyvs62.item (yyvsp62 - 1), yyvs15.item (yyvsp15), yyvs62.item (yyvsp62)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 -1
	yyvsp15 := yyvsp15 -1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_669 is
			--|#line 3551 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3551 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3551")
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

	yy_do_action_670 is
			--|#line 3553 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3553 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3553")
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

	yy_do_action_671 is
			--|#line 3555 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3555 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3555")
end

yyval62 := ast_factory.new_infix_expression (yyvs62.item (yyvsp62 - 1), yyvs15.item (yyvsp15), yyvs62.item (yyvsp62)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 -1
	yyvsp15 := yyvsp15 -1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_672 is
			--|#line 3557 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3557 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3557")
end

yyval62 := ast_factory.new_equality_expression (yyvs62.item (yyvsp62 - 1), yyvs5.item (yyvsp5), yyvs62.item (yyvsp62)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 -1
	yyvsp5 := yyvsp5 -1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_673 is
			--|#line 3559 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3559 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3559")
end

yyval62 := ast_factory.new_equality_expression (yyvs62.item (yyvsp62 - 1), yyvs5.item (yyvsp5), yyvs62.item (yyvsp62)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 -1
	yyvsp5 := yyvsp5 -1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_674 is
			--|#line 3561 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3561 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3561")
end

yyval62 := ast_factory.new_object_equality_expression (yyvs62.item (yyvsp62 - 1), yyvs5.item (yyvsp5), yyvs62.item (yyvsp62)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 -1
	yyvsp5 := yyvsp5 -1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_675 is
			--|#line 3563 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3563 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3563")
end

yyval62 := ast_factory.new_object_equality_expression (yyvs62.item (yyvsp62 - 1), yyvs5.item (yyvsp5), yyvs62.item (yyvsp62)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 -1
	yyvsp5 := yyvsp5 -1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_676 is
			--|#line 3567 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3567 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3567")
end

yyval62 := yyvs62.item (yyvsp62) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_677 is
			--|#line 3569 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3569 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3569")
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

	yy_do_action_678 is
			--|#line 3571 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3571 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3571")
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

	yy_do_action_679 is
			--|#line 3573 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3573 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3573")
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

	yy_do_action_680 is
			--|#line 3577 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3577 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3577")
end

yyval62 := yyvs62.item (yyvsp62) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_681 is
			--|#line 3579 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3579 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3579")
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

	yy_do_action_682 is
			--|#line 3581 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3581 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3581")
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

	yy_do_action_683 is
			--|#line 3583 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3583 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3583")
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

	yy_do_action_684 is
			--|#line 3585 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3585 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3585")
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

	yy_do_action_685 is
			--|#line 3587 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3587 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3587")
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

	yy_do_action_686 is
			--|#line 3589 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3589 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3589")
end

yyval62 := new_prefix_plus_expression (yyvs20.item (yyvsp20), yyvs62.item (yyvsp62)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp20 := yyvsp20 -1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_687 is
			--|#line 3591 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3591 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3591")
end

yyval62 := new_prefix_minus_expression (yyvs20.item (yyvsp20), yyvs62.item (yyvsp62)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp20 := yyvsp20 -1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_688 is
			--|#line 3593 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3593 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3593")
end

yyval62 := ast_factory.new_prefix_expression (yyvs15.item (yyvsp15), yyvs62.item (yyvsp62)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp15 := yyvsp15 -1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_689 is
			--|#line 3595 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3595 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3595")
end

yyval62 := ast_factory.new_prefix_expression (ast_factory.new_prefix_free_operator (yyvs12.item (yyvsp12)), yyvs62.item (yyvsp62)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp12 := yyvsp12 -1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_690 is
			--|#line 3597 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3597 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3597")
end

yyval62 := ast_factory.new_old_expression (yyvs2.item (yyvsp2), yyvs62.item (yyvsp62)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp2 := yyvsp2 -1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_691 is
			--|#line 3599 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3599 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3599")
end

			if current_system.is_ise and then current_system.ise_version < ise_6_1_0 then
				raise_error
			else
				yyval62 := new_old_object_test (yyvs5.item (yyvsp5 - 2), yyvs13.item (yyvsp13), yyvs5.item (yyvsp5 - 1), yyvs112.item (yyvsp112), yyvs5.item (yyvsp5), yyvs62.item (yyvsp62))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp5 := yyvsp5 -3
	yyvsp13 := yyvsp13 -1
	yyvsp112 := yyvsp112 -1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_692 is
			--|#line 3607 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3607 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3607")
end

yyval62 := ast_factory.new_object_test (yyvs2.item (yyvsp2), Void, yyvs62.item (yyvsp62)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp2 := yyvsp2 -1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_693 is
			--|#line 3609 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3609 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3609")
end

yyval62 := ast_factory.new_object_test (yyvs2.item (yyvsp2), ast_factory.new_target_type (yyvs5.item (yyvsp5 - 1), yyvs112.item (yyvsp112), yyvs5.item (yyvsp5)), yyvs62.item (yyvsp62)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp2 := yyvsp2 -1
	yyvsp5 := yyvsp5 -2
	yyvsp112 := yyvsp112 -1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_694 is
			--|#line 3611 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3611 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3611")
end

yyval62 := new_named_object_test (yyvs2.item (yyvsp2 - 1), Void, yyvs62.item (yyvsp62), yyvs2.item (yyvsp2), yyvs13.item (yyvsp13)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp2 := yyvsp2 -2
	yyvsp13 := yyvsp13 -1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_695 is
			--|#line 3613 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3613 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3613")
end

yyval62 := new_named_object_test (yyvs2.item (yyvsp2 - 1), ast_factory.new_target_type (yyvs5.item (yyvsp5 - 1), yyvs112.item (yyvsp112), yyvs5.item (yyvsp5)), yyvs62.item (yyvsp62), yyvs2.item (yyvsp2), yyvs13.item (yyvsp13)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp2 := yyvsp2 -2
	yyvsp5 := yyvsp5 -2
	yyvsp112 := yyvsp112 -1
	yyvsp13 := yyvsp13 -1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_696 is
			--|#line 3617 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3617 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3617")
end

yyval62 := yyvs62.item (yyvsp62) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_697 is
			--|#line 3619 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3619 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3619")
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

	yy_do_action_698 is
			--|#line 3621 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3621 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3621")
end

yyval62 := yyvs62.item (yyvsp62) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_699 is
			--|#line 3623 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3623 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3623")
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

	yy_do_action_700 is
			--|#line 3625 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3625 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3625")
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

	yy_do_action_701 is
			--|#line 3627 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3627 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3627")
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

	yy_do_action_702 is
			--|#line 3629 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3629 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3629")
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

	yy_do_action_703 is
			--|#line 3631 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3631 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3631")
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

	yy_do_action_704 is
			--|#line 3633 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3633 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3633")
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

	yy_do_action_705 is
			--|#line 3635 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3635 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3635")
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

	yy_do_action_706 is
			--|#line 3637 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3637 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3637")
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

	yy_do_action_707 is
			--|#line 3639 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3639 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3639")
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

	yy_do_action_708 is
			--|#line 3641 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3641 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3641")
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

	yy_do_action_709 is
			--|#line 3656 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3656 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3656")
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

	yy_do_action_710 is
			--|#line 3658 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3658 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3658")
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

	yy_do_action_711 is
			--|#line 3660 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3660 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3660")
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

	yy_do_action_712 is
			--|#line 3662 "et_eiffel_parser.y"
		local
			yyval62: ET_EXPRESSION
		do
--|#line 3662 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3662")
end

yyval62 := yyvs62.item (yyvsp62) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs62.put (yyval62, yyvsp62)
end
		end

	yy_do_action_713 is
			--|#line 3666 "et_eiffel_parser.y"
		local
			yyval35: ET_BRACKET_EXPRESSION
		do
--|#line 3666 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3666")
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

	yy_do_action_714 is
			--|#line 3666 "et_eiffel_parser.y"
		local
			yyval35: ET_BRACKET_EXPRESSION
		do
--|#line 3666 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3666")
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

	yy_do_action_715 is
			--|#line 3679 "et_eiffel_parser.y"
		local
			yyval34: ET_BRACKET_ARGUMENT_LIST
		do
--|#line 3679 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3679")
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

	yy_do_action_716 is
			--|#line 3690 "et_eiffel_parser.y"
		local
			yyval34: ET_BRACKET_ARGUMENT_LIST
		do
--|#line 3690 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3690")
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

	yy_do_action_717 is
			--|#line 3698 "et_eiffel_parser.y"
		local
			yyval34: ET_BRACKET_ARGUMENT_LIST
		do
--|#line 3698 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3698")
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

	yy_do_action_718 is
			--|#line 3707 "et_eiffel_parser.y"
		local
			yyval99: ET_PARENTHESIZED_EXPRESSION
		do
--|#line 3707 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3707")
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

	yy_do_action_719 is
			--|#line 3715 "et_eiffel_parser.y"
		local
			yyval93: ET_MANIFEST_ARRAY
		do
--|#line 3715 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3715")
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

	yy_do_action_720 is
			--|#line 3717 "et_eiffel_parser.y"
		local
			yyval93: ET_MANIFEST_ARRAY
		do
--|#line 3717 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3717")
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

	yy_do_action_721 is
			--|#line 3717 "et_eiffel_parser.y"
		local
			yyval93: ET_MANIFEST_ARRAY
		do
--|#line 3717 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3717")
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

	yy_do_action_722 is
			--|#line 3730 "et_eiffel_parser.y"
		local
			yyval93: ET_MANIFEST_ARRAY
		do
--|#line 3730 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3730")
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

	yy_do_action_723 is
			--|#line 3741 "et_eiffel_parser.y"
		local
			yyval93: ET_MANIFEST_ARRAY
		do
--|#line 3741 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3741")
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

	yy_do_action_724 is
			--|#line 3749 "et_eiffel_parser.y"
		local
			yyval93: ET_MANIFEST_ARRAY
		do
--|#line 3749 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3749")
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

	yy_do_action_725 is
			--|#line 3758 "et_eiffel_parser.y"
		local
			yyval96: ET_MANIFEST_TUPLE
		do
--|#line 3758 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3758")
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

	yy_do_action_726 is
			--|#line 3760 "et_eiffel_parser.y"
		local
			yyval96: ET_MANIFEST_TUPLE
		do
--|#line 3760 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3760")
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

	yy_do_action_727 is
			--|#line 3760 "et_eiffel_parser.y"
		local
			yyval96: ET_MANIFEST_TUPLE
		do
--|#line 3760 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3760")
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

	yy_do_action_728 is
			--|#line 3773 "et_eiffel_parser.y"
		local
			yyval96: ET_MANIFEST_TUPLE
		do
--|#line 3773 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3773")
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

	yy_do_action_729 is
			--|#line 3784 "et_eiffel_parser.y"
		local
			yyval96: ET_MANIFEST_TUPLE
		do
--|#line 3784 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3784")
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

	yy_do_action_730 is
			--|#line 3792 "et_eiffel_parser.y"
		local
			yyval96: ET_MANIFEST_TUPLE
		do
--|#line 3792 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3792")
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

	yy_do_action_731 is
			--|#line 3801 "et_eiffel_parser.y"
		local
			yyval111: ET_STRIP_EXPRESSION
		do
--|#line 3801 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3801")
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

	yy_do_action_732 is
			--|#line 3803 "et_eiffel_parser.y"
		local
			yyval111: ET_STRIP_EXPRESSION
		do
--|#line 3803 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3803")
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

	yy_do_action_733 is
			--|#line 3803 "et_eiffel_parser.y"
		local
			yyval111: ET_STRIP_EXPRESSION
		do
--|#line 3803 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3803")
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

	yy_do_action_734 is
			--|#line 3818 "et_eiffel_parser.y"
		local
			yyval111: ET_STRIP_EXPRESSION
		do
--|#line 3818 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3818")
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

	yy_do_action_735 is
			--|#line 3829 "et_eiffel_parser.y"
		local
			yyval111: ET_STRIP_EXPRESSION
		do
--|#line 3829 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3829")
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

	yy_do_action_736 is
			--|#line 3837 "et_eiffel_parser.y"
		local
			yyval111: ET_STRIP_EXPRESSION
		do
--|#line 3837 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3837")
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

	yy_do_action_737 is
			--|#line 3846 "et_eiffel_parser.y"
		local
			yyval46: ET_CONSTANT
		do
--|#line 3846 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3846")
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

	yy_do_action_738 is
			--|#line 3848 "et_eiffel_parser.y"
		local
			yyval46: ET_CONSTANT
		do
--|#line 3848 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3848")
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

	yy_do_action_739 is
			--|#line 3850 "et_eiffel_parser.y"
		local
			yyval46: ET_CONSTANT
		do
--|#line 3850 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3850")
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

	yy_do_action_740 is
			--|#line 3852 "et_eiffel_parser.y"
		local
			yyval46: ET_CONSTANT
		do
--|#line 3852 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3852")
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

	yy_do_action_741 is
			--|#line 3854 "et_eiffel_parser.y"
		local
			yyval46: ET_CONSTANT
		do
--|#line 3854 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3854")
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

	yy_do_action_742 is
			--|#line 3856 "et_eiffel_parser.y"
		local
			yyval46: ET_CONSTANT
		do
--|#line 3856 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3856")
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

	yy_do_action_743 is
			--|#line 3862 "et_eiffel_parser.y"
		local
			yyval36: ET_CALL_AGENT
		do
--|#line 3862 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3862")
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

	yy_do_action_744 is
			--|#line 3864 "et_eiffel_parser.y"
		local
			yyval36: ET_CALL_AGENT
		do
--|#line 3864 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3864")
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

	yy_do_action_745 is
			--|#line 3868 "et_eiffel_parser.y"
		local
			yyval83: ET_INLINE_AGENT
		do
--|#line 3868 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3868")
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

	yy_do_action_746 is
			--|#line 3879 "et_eiffel_parser.y"
		local
			yyval83: ET_INLINE_AGENT
		do
--|#line 3879 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3879")
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

	yy_do_action_747 is
			--|#line 3886 "et_eiffel_parser.y"
		local
			yyval83: ET_INLINE_AGENT
		do
--|#line 3886 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3886")
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

	yy_do_action_748 is
			--|#line 3893 "et_eiffel_parser.y"
		local
			yyval83: ET_INLINE_AGENT
		do
--|#line 3893 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3893")
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

	yy_do_action_749 is
			--|#line 3900 "et_eiffel_parser.y"
		local
			yyval83: ET_INLINE_AGENT
		do
--|#line 3900 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3900")
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

	yy_do_action_750 is
			--|#line 3907 "et_eiffel_parser.y"
		local
			yyval83: ET_INLINE_AGENT
		do
--|#line 3907 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3907")
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

	yy_do_action_751 is
			--|#line 3914 "et_eiffel_parser.y"
		local
			yyval83: ET_INLINE_AGENT
		do
--|#line 3914 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3914")
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

	yy_do_action_752 is
			--|#line 3921 "et_eiffel_parser.y"
		local
			yyval83: ET_INLINE_AGENT
		do
--|#line 3921 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3921")
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

	yy_do_action_753 is
			--|#line 3928 "et_eiffel_parser.y"
		local
			yyval83: ET_INLINE_AGENT
		do
--|#line 3928 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3928")
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

	yy_do_action_754 is
			--|#line 3935 "et_eiffel_parser.y"
		local
			yyval83: ET_INLINE_AGENT
		do
--|#line 3935 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3935")
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

	yy_do_action_755 is
			--|#line 3942 "et_eiffel_parser.y"
		local
			yyval83: ET_INLINE_AGENT
		do
--|#line 3942 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3942")
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

	yy_do_action_756 is
			--|#line 3949 "et_eiffel_parser.y"
		local
			yyval83: ET_INLINE_AGENT
		do
--|#line 3949 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3949")
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

	yy_do_action_757 is
			--|#line 3958 "et_eiffel_parser.y"
		local
			yyval73: ET_FORMAL_ARGUMENT_LIST
		do
--|#line 3958 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3958")
end

			yyval73 := yyvs73.item (yyvsp73)
			set_start_closure (yyval73)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs73.put (yyval73, yyvsp73)
end
		end

	yy_do_action_758 is
			--|#line 3965 "et_eiffel_parser.y"
		local
			yyval1: ANY
		do
--|#line 3965 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3965")
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

	yy_do_action_759 is
			--|#line 3969 "et_eiffel_parser.y"
		local
			yyval97: ET_OBJECT_TEST_LIST
		do
--|#line 3969 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3969")
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

	yy_do_action_760 is
			--|#line 3981 "et_eiffel_parser.y"
		local
			yyval31: ET_AGENT_TARGET
		do
--|#line 3981 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3981")
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

	yy_do_action_761 is
			--|#line 3983 "et_eiffel_parser.y"
		local
			yyval31: ET_AGENT_TARGET
		do
--|#line 3983 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3983")
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

	yy_do_action_762 is
			--|#line 3985 "et_eiffel_parser.y"
		local
			yyval31: ET_AGENT_TARGET
		do
--|#line 3985 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3985")
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

	yy_do_action_763 is
			--|#line 3987 "et_eiffel_parser.y"
		local
			yyval31: ET_AGENT_TARGET
		do
--|#line 3987 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3987")
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

	yy_do_action_764 is
			--|#line 3989 "et_eiffel_parser.y"
		local
			yyval31: ET_AGENT_TARGET
		do
--|#line 3989 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3989")
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

	yy_do_action_765 is
			--|#line 3993 "et_eiffel_parser.y"
		local
			yyval30: ET_AGENT_ARGUMENT_OPERAND_LIST
		do
--|#line 3993 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3993")
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

	yy_do_action_766 is
			--|#line 3995 "et_eiffel_parser.y"
		local
			yyval30: ET_AGENT_ARGUMENT_OPERAND_LIST
		do
--|#line 3995 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3995")
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

	yy_do_action_767 is
			--|#line 3997 "et_eiffel_parser.y"
		local
			yyval30: ET_AGENT_ARGUMENT_OPERAND_LIST
		do
--|#line 3997 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3997")
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

	yy_do_action_768 is
			--|#line 3997 "et_eiffel_parser.y"
		local
			yyval30: ET_AGENT_ARGUMENT_OPERAND_LIST
		do
--|#line 3997 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 3997")
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

	yy_do_action_769 is
			--|#line 4010 "et_eiffel_parser.y"
		local
			yyval30: ET_AGENT_ARGUMENT_OPERAND_LIST
		do
--|#line 4010 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4010")
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

	yy_do_action_770 is
			--|#line 4021 "et_eiffel_parser.y"
		local
			yyval30: ET_AGENT_ARGUMENT_OPERAND_LIST
		do
--|#line 4021 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4021")
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

	yy_do_action_771 is
			--|#line 4029 "et_eiffel_parser.y"
		local
			yyval30: ET_AGENT_ARGUMENT_OPERAND_LIST
		do
--|#line 4029 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4029")
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

	yy_do_action_772 is
			--|#line 4038 "et_eiffel_parser.y"
		local
			yyval29: ET_AGENT_ARGUMENT_OPERAND_ITEM
		do
--|#line 4038 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4038")
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

	yy_do_action_773 is
			--|#line 4047 "et_eiffel_parser.y"
		local
			yyval28: ET_AGENT_ARGUMENT_OPERAND
		do
--|#line 4047 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4047")
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

	yy_do_action_774 is
			--|#line 4049 "et_eiffel_parser.y"
		local
			yyval28: ET_AGENT_ARGUMENT_OPERAND
		do
--|#line 4049 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4049")
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

	yy_do_action_775 is
			--|#line 4051 "et_eiffel_parser.y"
		local
			yyval28: ET_AGENT_ARGUMENT_OPERAND
		do
--|#line 4051 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4051")
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

	yy_do_action_776 is
			--|#line 4057 "et_eiffel_parser.y"
		local
			yyval16: ET_MANIFEST_STRING
		do
--|#line 4057 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4057")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_777 is
			--|#line 4059 "et_eiffel_parser.y"
		local
			yyval16: ET_MANIFEST_STRING
		do
--|#line 4059 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4059")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_778 is
			--|#line 4061 "et_eiffel_parser.y"
		local
			yyval16: ET_MANIFEST_STRING
		do
--|#line 4061 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4061")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_779 is
			--|#line 4063 "et_eiffel_parser.y"
		local
			yyval16: ET_MANIFEST_STRING
		do
--|#line 4063 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4063")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_780 is
			--|#line 4065 "et_eiffel_parser.y"
		local
			yyval16: ET_MANIFEST_STRING
		do
--|#line 4065 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4065")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_781 is
			--|#line 4067 "et_eiffel_parser.y"
		local
			yyval16: ET_MANIFEST_STRING
		do
--|#line 4067 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4067")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_782 is
			--|#line 4069 "et_eiffel_parser.y"
		local
			yyval16: ET_MANIFEST_STRING
		do
--|#line 4069 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4069")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_783 is
			--|#line 4071 "et_eiffel_parser.y"
		local
			yyval16: ET_MANIFEST_STRING
		do
--|#line 4071 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4071")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_784 is
			--|#line 4073 "et_eiffel_parser.y"
		local
			yyval16: ET_MANIFEST_STRING
		do
--|#line 4073 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4073")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_785 is
			--|#line 4075 "et_eiffel_parser.y"
		local
			yyval16: ET_MANIFEST_STRING
		do
--|#line 4075 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4075")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_786 is
			--|#line 4077 "et_eiffel_parser.y"
		local
			yyval16: ET_MANIFEST_STRING
		do
--|#line 4077 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4077")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_787 is
			--|#line 4079 "et_eiffel_parser.y"
		local
			yyval16: ET_MANIFEST_STRING
		do
--|#line 4079 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4079")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_788 is
			--|#line 4081 "et_eiffel_parser.y"
		local
			yyval16: ET_MANIFEST_STRING
		do
--|#line 4081 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4081")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_789 is
			--|#line 4083 "et_eiffel_parser.y"
		local
			yyval16: ET_MANIFEST_STRING
		do
--|#line 4083 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4083")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_790 is
			--|#line 4085 "et_eiffel_parser.y"
		local
			yyval16: ET_MANIFEST_STRING
		do
--|#line 4085 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4085")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_791 is
			--|#line 4087 "et_eiffel_parser.y"
		local
			yyval16: ET_MANIFEST_STRING
		do
--|#line 4087 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4087")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_792 is
			--|#line 4089 "et_eiffel_parser.y"
		local
			yyval16: ET_MANIFEST_STRING
		do
--|#line 4089 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4089")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_793 is
			--|#line 4091 "et_eiffel_parser.y"
		local
			yyval16: ET_MANIFEST_STRING
		do
--|#line 4091 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4091")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_794 is
			--|#line 4093 "et_eiffel_parser.y"
		local
			yyval16: ET_MANIFEST_STRING
		do
--|#line 4093 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4093")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_795 is
			--|#line 4095 "et_eiffel_parser.y"
		local
			yyval16: ET_MANIFEST_STRING
		do
--|#line 4095 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4095")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_796 is
			--|#line 4097 "et_eiffel_parser.y"
		local
			yyval16: ET_MANIFEST_STRING
		do
--|#line 4097 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4097")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_797 is
			--|#line 4099 "et_eiffel_parser.y"
		local
			yyval16: ET_MANIFEST_STRING
		do
--|#line 4099 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4099")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs16.put (yyval16, yyvsp16)
end
		end

	yy_do_action_798 is
			--|#line 4101 "et_eiffel_parser.y"
		local
			yyval16: ET_MANIFEST_STRING
		do
--|#line 4101 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4101")
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

	yy_do_action_799 is
			--|#line 4105 "et_eiffel_parser.y"
		local
			yyval10: ET_CHARACTER_CONSTANT
		do
--|#line 4105 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4105")
end

yyval10 := yyvs10.item (yyvsp10) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs10.put (yyval10, yyvsp10)
end
		end

	yy_do_action_800 is
			--|#line 4107 "et_eiffel_parser.y"
		local
			yyval10: ET_CHARACTER_CONSTANT
		do
--|#line 4107 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4107")
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

	yy_do_action_801 is
			--|#line 4111 "et_eiffel_parser.y"
		local
			yyval8: ET_BOOLEAN_CONSTANT
		do
--|#line 4111 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4111")
end

yyval8 := yyvs8.item (yyvsp8) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs8.put (yyval8, yyvsp8)
end
		end

	yy_do_action_802 is
			--|#line 4113 "et_eiffel_parser.y"
		local
			yyval8: ET_BOOLEAN_CONSTANT
		do
--|#line 4113 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4113")
end

yyval8 := yyvs8.item (yyvsp8) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs8.put (yyval8, yyvsp8)
end
		end

	yy_do_action_803 is
			--|#line 4117 "et_eiffel_parser.y"
		local
			yyval14: ET_INTEGER_CONSTANT
		do
--|#line 4117 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4117")
end

yyval14 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs14.put (yyval14, yyvsp14)
end
		end

	yy_do_action_804 is
			--|#line 4119 "et_eiffel_parser.y"
		local
			yyval14: ET_INTEGER_CONSTANT
		do
--|#line 4119 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4119")
end

yyval14 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs14.put (yyval14, yyvsp14)
end
		end

	yy_do_action_805 is
			--|#line 4123 "et_eiffel_parser.y"
		local
			yyval14: ET_INTEGER_CONSTANT
		do
--|#line 4123 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4123")
end

yyval14 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs14.put (yyval14, yyvsp14)
end
		end

	yy_do_action_806 is
			--|#line 4125 "et_eiffel_parser.y"
		local
			yyval14: ET_INTEGER_CONSTANT
		do
--|#line 4125 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4125")
end

yyval14 := yyvs14.item (yyvsp14) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs14.put (yyval14, yyvsp14)
end
		end

	yy_do_action_807 is
			--|#line 4129 "et_eiffel_parser.y"
		local
			yyval14: ET_INTEGER_CONSTANT
		do
--|#line 4129 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4129")
end

			yyval14 := yyvs14.item (yyvsp14)
			yyval14.set_sign (yyvs20.item (yyvsp20))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp20 := yyvsp20 -1
	yyvs14.put (yyval14, yyvsp14)
end
		end

	yy_do_action_808 is
			--|#line 4134 "et_eiffel_parser.y"
		local
			yyval14: ET_INTEGER_CONSTANT
		do
--|#line 4134 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4134")
end

			yyval14 := yyvs14.item (yyvsp14)
			yyval14.set_sign (yyvs20.item (yyvsp20))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp20 := yyvsp20 -1
	yyvs14.put (yyval14, yyvsp14)
end
		end

	yy_do_action_809 is
			--|#line 4141 "et_eiffel_parser.y"
		local
			yyval14: ET_INTEGER_CONSTANT
		do
--|#line 4141 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4141")
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

	yy_do_action_810 is
			--|#line 4148 "et_eiffel_parser.y"
		local
			yyval17: ET_REAL_CONSTANT
		do
--|#line 4148 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4148")
end

yyval17 := yyvs17.item (yyvsp17) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs17.put (yyval17, yyvsp17)
end
		end

	yy_do_action_811 is
			--|#line 4150 "et_eiffel_parser.y"
		local
			yyval17: ET_REAL_CONSTANT
		do
--|#line 4150 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4150")
end

yyval17 := yyvs17.item (yyvsp17) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs17.put (yyval17, yyvsp17)
end
		end

	yy_do_action_812 is
			--|#line 4154 "et_eiffel_parser.y"
		local
			yyval17: ET_REAL_CONSTANT
		do
--|#line 4154 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4154")
end

yyval17 := yyvs17.item (yyvsp17) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs17.put (yyval17, yyvsp17)
end
		end

	yy_do_action_813 is
			--|#line 4156 "et_eiffel_parser.y"
		local
			yyval17: ET_REAL_CONSTANT
		do
--|#line 4156 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4156")
end

yyval17 := yyvs17.item (yyvsp17) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs17.put (yyval17, yyvsp17)
end
		end

	yy_do_action_814 is
			--|#line 4160 "et_eiffel_parser.y"
		local
			yyval17: ET_REAL_CONSTANT
		do
--|#line 4160 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4160")
end

			yyval17 := yyvs17.item (yyvsp17)
			yyval17.set_sign (yyvs20.item (yyvsp20))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp20 := yyvsp20 -1
	yyvs17.put (yyval17, yyvsp17)
end
		end

	yy_do_action_815 is
			--|#line 4165 "et_eiffel_parser.y"
		local
			yyval17: ET_REAL_CONSTANT
		do
--|#line 4165 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4165")
end

			yyval17 := yyvs17.item (yyvsp17)
			yyval17.set_sign (yyvs20.item (yyvsp20))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp20 := yyvsp20 -1
	yyvs17.put (yyval17, yyvsp17)
end
		end

	yy_do_action_816 is
			--|#line 4172 "et_eiffel_parser.y"
		local
			yyval17: ET_REAL_CONSTANT
		do
--|#line 4172 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4172")
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

	yy_do_action_817 is
			--|#line 4179 "et_eiffel_parser.y"
		local
			yyval13: ET_IDENTIFIER
		do
--|#line 4179 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4179")
end

yyval13 := yyvs13.item (yyvsp13) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs13.put (yyval13, yyvsp13)
end
		end

	yy_do_action_818 is
			--|#line 4181 "et_eiffel_parser.y"
		local
			yyval13: ET_IDENTIFIER
		do
--|#line 4181 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4181")
end

yyval13 := yyvs13.item (yyvsp13) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs13.put (yyval13, yyvsp13)
end
		end

	yy_do_action_819 is
			--|#line 4183 "et_eiffel_parser.y"
		local
			yyval13: ET_IDENTIFIER
		do
--|#line 4183 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4183")
end

				-- TO DO: reserved word `BIT'
			yyval13 := yyvs13.item (yyvsp13)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvs13.put (yyval13, yyvsp13)
end
		end

	yy_do_action_820 is
			--|#line 4192 "et_eiffel_parser.y"
		local
			yyval1: ANY
		do
--|#line 4192 "et_eiffel_parser.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'et_eiffel_parser.y' at line 4192")
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
			when 1507 then
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
			    2,    2,    2,  131,    2,    2,  129,    2,    2,    2,
			  124,  125,  116,  133,  127,  132,  130,  109,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,  126,  138,
			  113,  134,  111,  140,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,  139,    2,  128,  115,    2,    2,    2,    2,    2,

			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
			    2,    2,    2,  122,    2,  123,  135,    2,    2,    2,
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
			  105,  106,  107,  108,  110,  112,  114,  117,  118,  119,
			  120,  121,  136,  137, yyDummy>>)
		end

	yyr1_template: SPECIAL [INTEGER] is
			-- Template for `yyr1'
		once
			Result := yyfixed_array (<<
			    0,  349,  349,  172,  350,  350,  351,  171,  171,  171,
			  171,  171,  171,  353,  171,  171,  352,  255,  255,  354,
			  255,  255,  355,  256,  256,  258,  258,  356,  258,  357,
			  262,  264,  263,  257,  257,  257,  359,  257,  360,  259,
			  261,  261,  260,  260,  267,  267,  265,  265,  265,  265,
			  265,  265,  265,  265,  265,  266,  170,  170,  170,  170,
			  280,  280,  281,  281,  250,  250,  250,  361,  251,  251,
			  249,  248,  248,  248,  248,  248,  248,  248,  248,  248,
			  196,  196,  362,  197,  197,  197,  198,  198,  198,  198,
			  198,  198,  198,  198,  198,  198,  198,  198,  198,  198,

			  198,  198,  199,  199,  199,  199,  199,  199,  199,  199,
			  199,  199,  199,  199,  199,  199,  199,  199,  191,  191,
			  190,  190,  192,  192,  192,  192,  187,  194,  194,  193,
			  193,  193,  195,  195,  195,  195,  195,  195,  188,  189,
			  308,  308,  313,  313,  313,  314,  365,  310,  310,  310,
			  310,  310,  310,  311,  315,  315,  315,  315,  315,  316,
			  316,  316,  316,  312,  312,  330,  330,  366,  331,  331,
			  331,  328,  329,  216,  216,  367,  217,  217,  218,  218,
			  368,  215,  215,  215,  369,  215,  236,  236,  236,  175,
			  370,  175,  176,  176,  176,  176,  173,  174,  288,  288,

			  371,  289,  289,  286,  286,  372,  287,  287,  284,  284,
			  373,  285,  285,  283,  283,  283,  238,  209,  209,  208,
			  210,  210,  374,  206,  206,  206,  375,  206,  376,  206,
			  206,  206,  377,  206,  378,  207,  207,  207,  239,  202,
			  202,  203,  379,  204,  204,  204,  201,  200,  200,  342,
			  342,  380,  343,  343,  341,  234,  234,  233,  235,  235,
			  231,  231,  232,  232,  381,  381,  381,  381,  322,  322,
			  322,  322,  322,  322,  319,  319,  319,  319,  319,  319,
			  323,  323,  323,  323,  323,  323,  323,  323,  323,  323,
			  323,  323,  323,  323,  323,  323,  323,  323,  323,  323,

			  323,  323,  320,  320,  320,  320,  320,  320,  320,  320,
			  282,  282,  332,  332,  230,  230,  158,  158,  237,  237,
			  237,  237,  237,  237,  237,  237,  237,  237,  237,  237,
			  237,  237,  237,  237,  237,  237,  237,  237,  237,  237,
			  237,  237,  237,  237,  237,  237,  237,  237,  237,  237,
			  237,  237,  237,  237,  237,  237,  237,  237,  237,  229,
			  229,  157,  157,  157,  157,  157,  157,  157,  157,  157,
			  157,  157,  157,  157,  157,  157,  157,  157,  157,  157,
			  157,  157,  157,  247,  244,  244,  336,  245,  245,  245,
			  245,  245,  245,  241,  240,  242,  243,  295,  295,  295,

			  382,  296,  296,  296,  296,  296,  296,  292,  291,  293,
			  294,  383,  383,  383,  383,  383,  383,  383,  383,  318,
			  318,  318,  318,  318,  317,  317,  317,  317,  317,  279,
			  279,  278,  278,  384,  298,  298,  297,  297,  344,  344,
			  344,  178,  178,  337,  337,  338,  338,  338,  338,  338,
			  338,  338,  338,  338,  338,  338,  338,  338,  338,  338,
			  338,  339,  339,  339,  339,  339,  339,  339,  339,  339,
			  339,  339,  339,  339,  339,  339,  339,  340,  340,  340,
			  340,  340,  340,  340,  340,  340,  340,  340,  340,  340,
			  340,  340,  340,  340,  253,  146,  146,  148,  148,  363,

			  147,  147,  147,  147,  364,  143,  149,  149,  150,  150,
			  150,  151,  151,  151,  151,  151,  151,  144,  145,  290,
			  290,  290,  290,  290,  290,  290,  290,  290,  290,  290,
			  321,  321,  321,  321,  321,  321,  179,  179,  180,  180,
			  181,  181,  182,  182,  183,  183,  184,  184,  185,  185,
			  177,  177,  385,  270,  270,  270,  270,  270,  270,  270,
			  270,  270,  270,  270,  270,  270,  270,  270,  270,  270,
			  271,  271,  271,  271,  273,  273,  273,  273,  205,  205,
			  254,  254,  254,  254,  213,  214,  214,  212,  269,  269,
			  347,  347,  346,  346,  345,  168,  168,  386,  169,  169,

			  169,  167,  165,  165,  166,  166,  166,  166,  211,  211,
			  304,  304,  304,  387,  303,  303,  302,  272,  272,  272,
			  272,  272,  272,  223,  223,  163,  333,  333,  221,  221,
			  220,  220,  220,  220,  220,  220,  220,  220,  141,  141,
			  141,  388,  142,  142,  142,  228,  222,  222,  222,  222,
			  348,  348,  219,  219,  225,  225,  225,  225,  225,  225,
			  225,  225,  225,  225,  225,  225,  225,  225,  225,  225,
			  225,  225,  225,  225,  225,  225,  226,  226,  226,  226,
			  227,  227,  227,  227,  227,  227,  227,  227,  227,  227,
			  227,  227,  227,  227,  227,  227,  224,  224,  224,  224,

			  224,  224,  224,  224,  224,  224,  224,  224,  224,  224,
			  224,  224,  224,  161,  389,  160,  160,  160,  309,  299,
			  299,  390,  300,  300,  300,  305,  305,  391,  306,  306,
			  306,  334,  334,  392,  335,  335,  335,  186,  186,  186,
			  186,  186,  186,  162,  162,  268,  268,  268,  268,  268,
			  268,  268,  268,  268,  268,  268,  268,  246,  393,  307,
			  156,  156,  156,  156,  156,  154,  154,  154,  394,  155,
			  155,  155,  153,  152,  152,  152,  301,  301,  301,  301,
			  301,  301,  301,  301,  301,  301,  301,  301,  301,  301,
			  301,  301,  301,  301,  301,  301,  301,  301,  301,  164,

			  164,  159,  159,  274,  274,  276,  276,  277,  277,  275,
			  324,  324,  326,  326,  327,  327,  325,  252,  252,  252,
			  358, yyDummy>>)
		end

	yytypes1_template: SPECIAL [INTEGER] is
			-- Template for `yytypes1'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 1509)
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
			   13,   13,   13,    2,    2,    2,    2,    2,    2,   13,
			   88,  106,  112,  112,    5,   96,    2,   82,   13,   13,
			    5,    5,   76,    5,   56,    1,    2,    2,   53,   56,
			   67,   78,   86,    1,    1,   13,  100,  100,  101,  102,
			  102,   13,   13,   13,   13,    2,   13,   13,    2,   13,
			   23,   27,   27,    1,   20,   20,   13,   14,   13,    2,
			   13,   13,    2,   13,   13,   13,   13,    5,   11,   13,

			   23,   27,    1,    5,    5,   20,   20,    5,    5,    5,
			    2,   21,   18,   17,   15,   14,   12,   11,    7,    5,
			    4,    3,    2,    2,    2,    2,    8,   35,   36,   10,
			   54,   62,   62,   62,   62,   62,   62,   62,   62,   62,
			   63,   13,   83,   14,   93,   16,   96,   96,   99,   17,
			  110,  111,    5,    5,    5,   24,    5,   13,   13,    2,
			    2,    2,    2,    2,   50,   13,   88,   53,   53,    2,
			    2,   55,   56,   53,    1,   67,   67,    1,   53,   86,
			   86,    2,    1,   78,    2,   56,   66,   66,   67,   27,
			   27,   22,  102,  102,   22,  102,  102,  102,  102,   27,

			    5,   11,   13,   27,   27,    5,   11,   13,   27,    5,
			   24,    5,   13,   13,   13,    2,    2,    2,    2,    2,
			   26,   26,   26,   27,   27,   13,   13,   88,  112,  112,
			   27,    5,   11,   13,   27,   27,    5,   11,   13,   27,
			   27,   27,   27,  112,    5,   13,   13,   13,   27,   13,
			    5,   62,   62,   18,   11,    2,    2,   69,   13,   99,
			   13,   13,   13,   13,  112,   62,   62,   62,    5,   93,
			    5,    5,   25,    5,    5,   18,   11,   31,   69,   73,
			   73,   13,   99,    5,    1,    5,   62,    5,   16,    5,
			    5,    5,    5,    5,   20,   20,    5,    5,   20,   20,

			   20,   20,   20,   20,   20,   20,   20,   15,   15,   15,
			   15,   12,    5,   23,    5,   96,   25,   62,   50,   50,
			   13,   13,   13,   13,   23,   48,   48,    1,   13,   14,
			   13,   13,   13,   13,   13,   13,   13,    2,   49,   23,
			   48,   48,    1,   67,    5,   44,   55,   44,   55,   56,
			   51,   52,   53,   69,   62,   13,    1,   86,   67,   78,
			    1,   42,    2,   44,   67,    2,   64,   69,   13,  105,
			  105,  107,  107,    1,    2,    2,    2,    2,    2,    2,
			   61,   87,   87,   87,  109,  112,  112,   13,   13,   13,
			   13,    5,   27,    5,   13,   14,    5,   13,   13,   13,

			   13,   13,   13,   13,   27,   13,   13,   13,   27,   27,
			    5,   27,    5,    5,  112,  112,    5,    5,    5,   13,
			   16,   16,   16,   16,   16,   16,   16,   16,   16,   16,
			   16,   16,   16,   16,   16,   16,   16,   16,   16,   16,
			   16,   16,   16,   16,   16,   16,   16,   16,   16,   16,
			   16,   16,   16,   16,   16,   16,   16,   16,   16,   16,
			    5,    5,   62,   63,   93,    5,   25,   13,    5,  112,
			    5,    5,   30,    5,    2,  104,   71,   71,   72,   72,
			   73,   13,    5,  104,  112,    2,    5,  111,  112,   62,
			   62,   62,   62,   62,   62,   62,   62,   62,   62,   62,

			   62,   62,   62,   62,   62,   62,    2,   62,    2,   62,
			   62,   13,   35,    5,   49,   49,   48,   48,   48,   48,
			    5,   24,    5,   13,   13,   13,    2,    2,    2,    2,
			    2,   47,   47,   47,   48,   48,   50,   50,   13,   13,
			   88,   48,   48,   48,   48,   48,   48,   48,    2,   49,
			    5,   13,   13,   13,   48,   86,    5,   44,   55,   55,
			   70,   13,   55,   55,   56,    5,   53,    5,    5,   22,
			    5,   62,   13,   78,   86,    2,    1,    1,   42,    1,
			   64,  105,  107,    5,    5,    2,   73,   73,    2,  105,
			  107,    5,    2,   32,  105,  107,   87,   87,  109,   87,

			   61,   87,   87,    2,   87,   87,   87,   87,   61,   61,
			    5,    5,   27,   27,   27,   27,    1,    1,    1,   27,
			   27,   27,   27,   27,   27,   27,    5,    5,  112,    5,
			    5,    5,    1,    1,   25,  112,    5,   14,   17,    5,
			    5,   93,   25,   62,   63,    5,    5,   69,    5,   30,
			  112,    2,    1,    2,    2,   91,   73,   13,   73,    5,
			   73,    5,   73,    5,    5,  112,    2,   91,    5,   13,
			   69,   70,  111,    5,   62,   62,   25,   34,   62,   63,
			   13,   13,   13,   13,    5,   48,    5,   13,   14,    5,
			   13,   13,   13,   13,   13,   13,   13,   48,   13,   13,

			   13,   48,   48,    5,    5,    5,   48,   49,   70,   13,
			    5,    5,   78,   43,   43,   44,   13,   55,   55,    5,
			   55,    5,  114,  114,   22,   22,    5,    2,   78,    1,
			   42,    1,    5,  105,  107,  105,  107,  112,    5,    2,
			   78,   16,   16,   16,   16,   16,   16,   16,   16,   16,
			   16,   16,   16,   16,   16,   16,   16,   16,   16,   16,
			   16,   16,   16,   69,   70,   87,   87,   69,  108,  108,
			  109,   87,   22,   44,   60,   61,   87,   87,    2,   87,
			    5,    5,   27,   27,   27,   27,   27,    1,    1,   22,
			    5,    5,    5,   13,    5,   13,    5,    5,   25,   25,

			   30,   24,    5,   28,   29,   30,   62,  104,    1,   91,
			   16,    2,    2,   45,   45,  112,  104,   16,   45,   45,
			    5,   62,    5,    5,    5,  111,    5,    5,    5,   34,
			   48,   48,   48,   48,    1,    1,    1,   48,   48,   48,
			   48,   48,   48,   48,    5,    5,   50,    2,   49,    2,
			    1,    1,    2,    5,   44,    5,   44,    5,    5,  114,
			    5,   22,    1,    2,    1,  105,  107,    2,   33,  112,
			   78,   98,   87,    2,  109,    2,   60,   61,   87,    2,
			   87,   13,   13,   13,   13,   62,   25,  112,    5,    5,
			    5,   30,    2,   91,   13,   89,   89,   90,   90,   91, yyDummy>>,
			1, 1000, 0)
		end

	yytypes1_template_2 (an_array: ARRAY [INTEGER]) is
			-- Fill chunk #2 of template for `yytypes1'.
		do
			yyarray_subcopy (an_array, <<
			    2,   65,    1,    1,    2,  103,  103,   22,    2,   91,
			   65,  103,  103,  112,    2,   13,   48,   48,   48,   48,
			   48,    1,    1,   22,    5,    1,  112,  113,  114,    1,
			    1,   69,   22,    5,    2,   78,   33,   98,  104,   64,
			   68,   69,   70,   61,    2,   87,    5,   16,   45,   45,
			    5,    5,   91,   91,   91,   91,   16,  103,   22,    5,
			    5,   19,   18,    4,    2,    2,    2,    2,    2,    2,
			    2,   35,   37,   45,   45,   57,   62,   62,   13,   77,
			   84,   85,   85,   85,   85,  118,   45,    2,    1,    2,
			   45,   45,   45,   16,   45,   45,  103,   45,   45,    5,

			   13,   25,    1,    5,    5,  114,    1,    5,    7,    2,
			    8,   10,   46,   14,   14,   14,   16,   17,   17,   17,
			    2,   46,   78,   98,    2,   78,  104,    2,    2,   91,
			    5,   68,    2,   24,   65,  103,  103,  112,    2,   24,
			    5,   13,   13,    2,    2,    2,    2,    2,   13,   88,
			  112,  112,    5,   25,   62,   62,    1,    5,    5,   95,
			    5,   18,   13,  118,    2,    1,    5,    5,    2,   92,
			   92,    5,   25,   45,    5,    5,    1,    1,    2,    2,
			   65,  103,  103,    2,    2,    2,  112,   22,   22,   22,
			   22,   22,   98,  104,   78,   98,    2,    2,   91,  103,

			   16,   45,   45,  103,   45,   45,   22,   97,   13,   13,
			   13,   13,  118,   27,   13,   14,   13,   13,   13,   13,
			   13,   13,   13,   27,    5,    5,   13,  117,    1,    2,
			   45,   45,  112,    5,   95,    2,    1,  112,    5,    2,
			   62,   62,    1,    2,    2,  115,   13,   45,   62,   62,
			   45,   97,   97,  103,   45,   45,   97,   97,   97,    5,
			  104,    2,    2,   91,   98,  104,  103,   16,   45,   45,
			    2,   65,  103,  103,    2,    2,    2,   30,   27,   27,
			   27,   27,    5,   27,   27,   27,   27,   27,   27,   27,
			  118,    5,    5,    2,    2,   45,    2,   41,  116,  117,

			    1,    2,   45,   59,    1,    5,   16,   94,   95,   45,
			    5,   13,   62,   13,   62,    2,   25,   30,   30,    2,
			    2,    2,   30,   30,   30,    2,    2,   91,  103,   16,
			   45,   45,  104,    2,    2,   91,    2,   65,  103,  103,
			   22,  103,   45,   45,   97,   97,   97,   13,    5,   13,
			   25,    1,    2,   41,   45,  117,   45,    2,    2,   45,
			    2,   58,   59,    5,    5,    5,   95,    2,  118,   25,
			    5,    2,   45,   62,   97,   97,   97,  103,   16,   45,
			   45,    2,   65,  103,  103,    2,    2,   91,  103,   16,
			   45,   45,   22,  103,   45,   45,    2,    2,    2,   30,

			   30,   30,   25,   13,   25,   45,    5,   10,   38,   39,
			   40,   41,   13,   14,  110,    2,   62,   59,   13,    5,
			   62,    1,    2,  115,   45,   30,   30,   30,    2,   65,
			  103,  103,   22,  103,   45,   45,  103,   16,   45,   45,
			    2,   65,  103,  103,    2,    2,    2,   22,   22,   22,
			   25,  112,    5,    5,   41,   45,   25,   13,   45,    2,
			    2,   22,  103,   45,   45,    2,    2,    2,    2,   65,
			  103,  103,   22,  103,   45,   45,   22,   22,   22,    5,
			   39,   25,    2,    2,    2,   22,   22,   22,   22,  103,
			   45,   45,    2,    2,    2,   22,   22,   22,    2,    2,

			    2,   22,   22,   22,   22,   22,   22,    1,    1,    1, yyDummy>>,
			1, 510, 1000)
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
			    2,    2,    2,    2,    2,    2,    2,    2,    3,    4,
			    5,    5,    5,    5,    5,    5,    6,    7,    8,    8,
			    9,   10,   11,   12,   13,   13,   13,   14,   15,   15,
			   15,   15,   15,   16,   16,   16,   16,   16,   16,   16,
			   16,   16,   16,   16,   16,   16,   16,   16,   16,   16,

			   16,   16,   16,   16,   16,   17,   18,   19,   20,   20,
			   20,   20,   20,   20,   20,   20,   20,   21,    6,    6,
			    6,    2,    5,    5,    5,    5,    5,    5,    5,    5,
			    5,    5,   20,   20,    5,    5,    5,    5,   22,   23,
			   24, yyDummy>>)
		end

	yydefact_template: SPECIAL [INTEGER] is
			-- Template for `yydefact'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 1509)
			yydefact_template_1 (an_array)
			yydefact_template_2 (an_array)
			Result := yyfixed_array (an_array)
		end

	yydefact_template_1 (an_array: ARRAY [INTEGER]) is
			-- Fill chunk #1 of template for `yydefact'.
		do
			yyarray_subcopy (an_array, <<
			   23,   23,   22,   19,    1,   24,   60,    2,  820,  820,
			   61,   64,    3,   62,   21,   27,   29,    0,   18,   36,
			   38,    0,   67,  140,   62,   62,   62,   63,    0,   32,
			  820,  820,  818,  819,  817,    0,   30,   42,  820,   43,
			  820,    0,    0,  798,  800,  812,  776,  795,  794,  793,
			  797,  796,  792,  791,  790,  789,  788,  787,  786,  785,
			  784,  783,  782,  781,  780,  779,  778,  777,  805,  799,
			  801,  802,   52,    0,   47,   48,    0,   46,   39,   44,
			    0,   40,   49,  806,   51,   50,  813,   65,    0,    0,
			  142,    0,    0,    0,    0,   26,   28,    0,   35,   37,

			  815,  808,  814,  807,    0,  727,   53,    0,    0,   55,
			   46,   45,    0,    0,    0,    0,   66,   71,  141,  146,
			  820,  820,    0,    0,    0,    0,   56,   31,    0,    0,
			  506,    0,  494,    0,    0,    0,    0,    0,    0,  443,
			  453,  529,    0,  444,  725,    0,   54,   41,   73,   72,
			   68,   70,   69,    0,  239,    0,  242,  433,  820,  239,
			  429,   16,   23,   15,    0,  495,  154,  159,  155,  144,
			  145,   59,   58,   57,  506,    0,  495,  506,    0,  495,
			  499,  456,  507,    0,    0,    0,  455,  454,  506,    0,
			  495,  506,    0,  495,  495,  495,  495,    0,  524,  519,

			  499,  445,    0,    0,  578,    0,    0,    0,  386,    0,
			    0,  705,  699,  685,    0,  684,    0,  700,  709,  721,
			  638,  758,    0,    0,    0,    0,  702,  681,  703,  706,
			  682,    0,    0,  698,  712,  696,  680,  652,  653,  676,
			    0,  638,  704,  677,  710,  707,  683,  726,  701,  678,
			  697,  711,    0,    0,    0,    0,    0,  127,    0,    0,
			    0,    0,    0,    0,   74,  118,   94,  820,  240,  228,
			  234,  222,  218,    0,  431,  256,  429,    0,  820,  430,
			   23,   16,   13,    0,  263,  219,  258,  260,  257,  147,
			  496,  163,  156,  160,  164,  157,  161,  158,  162,  460,

			    0,  528,  523,  452,  459,    0,  527,  522,  451,  508,
			    0,    0,  818,  819,  817,    0,    0,    0,    0,    0,
			    0,    0,    0,  509,  510,    0,  443,  469,    0,    0,
			  458,    0,  526,  521,  450,  457,    0,  525,  520,  449,
			  447,  448,  446,    0,  497,  506,    0,  494,  498,  535,
			    0,  686,  687,  648,  647,    0,    0,  646,  318,  649,
			  818,  819,  817,    0,    0,  690,  688,  689,  719,    0,
			  641,    0,  628,  386,    0,  762,  763,    0,  765,  757,
			  419,  760,  761,    0,  419,    0,  692,  733,  708,    0,
			    0,    0,    0,    0,    0,    0,  728,  645,    0,    0,

			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,  714,  729,  730,  630,    0,   76,   75,
			  127,  118,  127,  118,  499,  128,   97,    0,   96,   95,
			  127,  118,  127,  118,  118,  118,  118,   82,   77,  499,
			  119,   86,    0,  429,  190,  226,    0,  232,    0,    0,
			  243,  244,  241,    0,  411,  638,  432,   23,  429,    0,
			    6,   60,   16,  262,  259,    0,  310,  359,  318,  265,
			  274,  264,  268,  261,  205,  210,  167,  200,  175,  153,
			  206,    0,  201,  211,  176,    0,    0,  506,  495,  506,
			  495,  504,  507,  504,  471,  470,  504,  506,  495,  506,

			  495,  495,  495,  495,  501,  818,  819,  817,  513,  512,
			    0,  461,  500,  505,    0,    0,    0,  504,  504,  638,
			  341,  319,  322,  356,  355,  354,  353,  352,  351,  350,
			  349,  348,  347,  346,  345,  344,  343,  342,  321,  320,
			  357,  358,  340,  338,  337,  335,  339,  336,  334,  333,
			  332,  331,  330,  329,  328,  327,  326,  325,  324,  323,
			    0,  679,    0,    0,  720,  639,    0,    0,  384,    0,
			    0,  768,  743,    0,  420,  397,    0,    0,    0,    0,
			  385,  638,    0,  397,    0,    0,  731,    0,    0,  675,
			  673,  674,  672,  655,  656,  657,  659,  661,  662,  664,

			  663,  665,  658,  660,  671,  668,    0,  667,    0,  666,
			  654,  638,    0,  718,   79,   78,  101,   93,  100,   92,
			  129,    0,    0,  818,  819,  817,    0,    0,    0,    0,
			    0,    0,    0,    0,  130,  131,    0,    0,    0,  118,
			  110,   99,   91,   98,   90,   88,   89,   87,   80,    0,
			  120,  127,    0,  494,  121,   23,  191,    0,    0,  227,
			  236,  235,    0,  233,  221,  246,  245,    0,    0,  412,
			  413,  415,  638,    0,   23,   16,   14,   23,   12,    6,
			  310,  275,  269,    0,    0,  311,  383,  310,   23,  277,
			  271,    0,    0,  360,  267,  266,    0,    0,    0,    0,

			    0,  207,  201,  152,  202,  211,  212,    0,  177,  206,
			    0,    0,  476,  468,  475,  467,    0,    0,    0,  474,
			  466,  473,  465,  463,  464,  462,  504,  504,  517,    0,
			    0,    0,    0,    0,  579,    0,    0,  809,  816,  722,
			  723,  724,  640,    0,    0,  638,  764,  765,  766,    0,
			  419,  421,  422,  400,    0,    0,  390,  394,  389,  387,
			  392,  388,  391,  393,    0,  419,    0,    0,    0,  694,
			    0,    0,  732,    0,  670,  669,  637,  713,    0,    0,
			  127,  118,  127,  118,  504,  128,  504,  112,  111,  504,
			  127,  118,  127,  118,  118,  118,  118,  123,  818,  819,

			  817,  134,  133,  122,  126,    0,  119,   81,    0,    0,
			  504,  504,    0,    0,    0,  189,  196,  225,  237,  238,
			  231,  251,  247,    0,  414,  416,  417,   16,    0,    6,
			    5,   11,    0,  279,  273,  276,  270,  316,    0,   23,
			  140,  382,  361,  380,  377,  381,  379,  376,  374,  378,
			  375,  373,  372,  371,  370,  369,  368,  367,  366,  365,
			  364,  363,  362,  213,  214,  204,  209,    0,  168,  169,
			  166,  199,  185,  184,  180,  174,  211,    0,  151,  201,
			    0,    0,  503,  515,  516,  502,  514,    0,    0,  518,
			  511,    0,    0,  530,    0,  638,  642,  643,  644,  629,

			  744,  774,    0,    0,    0,  767,  773,  397,  423,    0,
			  314,  820,  820,  424,  424,  395,  397,  314,  424,  424,
			    0,  693,  216,  734,  735,  736,    0,  715,  716,  717,
			  117,  109,  116,  108,    0,    0,    0,  115,  107,  114,
			  106,  104,  105,  103,  504,  504,  138,   84,   85,   83,
			    0,    0,   16,  192,  195,  193,  194,  197,  249,    0,
			  248,  418,    6,   16,   10,  278,  272,    0,  280,  316,
			  140,  419,  215,    0,  170,  181,    0,    0,    0,  150,
			  211,  534,  533,  532,  531,  691,  627,    0,  772,  769,
			  770,  771,    0,    0,  408,    0,    0,  401,  402,  399, yyDummy>>,
			1, 1000, 0)
		end

	yydefact_template_2 (an_array: ARRAY [INTEGER]) is
			-- Fill chunk #2 of template for `yydefact'.
		do
			yyarray_subcopy (an_array, <<
			    0,  424,    0,    0,  425,  441,  441,  396,    0,    0,
			  424,  441,  441,    0,    0,  638,  125,  136,  137,  124,
			  135,    0,    0,  139,  132,    6,    0,    0,  250,    9,
			    6,  317,  281,    0,   23,  140,   23,  419,  397,  171,
			  183,  186,  187,  179,  149,    0,  679,  314,  424,  424,
			  407,    0,  404,  403,  406,  405,  315,    0,  569,    0,
			    0,  568,  699,  638,    0,    0,  820,    0,  610,    0,
			    0,  635,    0,  539,  434,  565,    0,    0,  650,  560,
			  561,  552,  553,  555,  554,    0,  537,  426,  427,  820,
			    0,  442,    0,  314,  424,  424,    0,    0,    0,    0,

			  695,  626,    7,  254,  252,  253,    8,    0,  742,  312,
			  737,  738,  312,  739,  804,  803,  741,  740,  811,  810,
			  312,  312,  140,  419,   23,  140,  397,  424,    0,    0,
			  172,  188,  148,  775,  424,  441,  441,  409,  759,    0,
			    0,  506,    0,    0,    0,    0,    0,    0,  477,  486,
			    0,    0,    0,  628,  820,    0,    0,    0,  613,  820,
			    0,  651,  650,  576,  566,    0,    0,    0,  436,  435,
			    0,    0,  630,    0,    0,    0,  428,    0,  759,  759,
			  424,  441,  441,  759,  759,  759,    0,  313,  285,  283,
			  284,  282,  419,  397,  140,  419,  424,    0,    0,    0,

			  314,  424,  424,    0,    0,    0,  410,  765,  506,  495,
			  818,    0,  572,  489,  488,  487,  506,  495,  506,  495,
			  495,  495,  495,  478,    0,    0,    0,    0,    0,  820,
			  820,  547,    0,  611,    0,  608,    0,    0,    0,  567,
			  557,  556,  437,  438,    0,    0,  638,  551,  559,  558,
			  545,  765,  765,    0,    0,    0,  765,  765,  765,    0,
			  397,  424,    0,    0,  419,  397,    0,  314,  424,  424,
			  312,  424,  441,  441,  759,  759,  759,  756,  493,  485,
			  492,  484,    0,  491,  483,  490,  482,  480,  481,  479,
			  570,    0,  638,  589,  820,    0,  597,    0,  592,  591,

			    0,  580,    0,    0,    0,    0,    0,    0,  612,    0,
			    0,  638,  439,  638,    0,    0,  637,  752,  754,  759,
			  759,  759,  755,  751,  753,  424,    0,    0,    0,  314,
			  424,  424,  397,  424,    0,    0,  312,  424,  441,  441,
			  306,    0,    0,    0,  765,  765,  765,  638,    0,  638,
			  629,    0,  588,    0,  594,  593,  541,  581,  582,    0,
			    0,  585,  584,    0,  616,  614,  615,  609,  574,  577,
			    0,  820,    0,    0,  765,  765,  765,    0,  314,  424,
			  424,  312,  424,  441,  441,  424,    0,    0,    0,  314,
			  424,  424,  307,    0,    0,    0,  312,  312,  312,  750,

			  746,  748,  573,  638,  627,  543,    0,  605,  598,  602,
			  599,  596,  606,  604,  607,  583,    0,  586,  638,    0,
			  440,    0,  563,    0,    0,  749,  745,  747,  312,  424,
			  441,  441,  295,    0,    0,    0,    0,  314,  424,  424,
			  312,  424,  441,  441,  312,  312,  312,  308,  302,  304,
			  571,    0,  601,    0,  600,  587,  626,  638,  549,  564,
			  562,  294,    0,    0,    0,  312,  312,  312,  312,  424,
			  441,  441,  297,    0,    0,    0,  309,  303,  305,    0,
			  603,  575,  312,  312,  312,  299,  287,  291,  296,    0,
			    0,    0,  312,  312,  312,  298,  286,  290,  312,  312,

			  312,  301,  289,  293,  300,  288,  292,    0,    0,    0, yyDummy>>,
			1, 510, 1000)
		end

	yydefgoto_template: SPECIAL [INTEGER] is
			-- Template for `yydefgoto'
		once
			Result := yyfixed_array (<<
			  416,  742,  320,  321,  322,  289,  882,  290,  181,  182,
			  883,  903,  904,  572,  905,  377,  693,  968,  226,  777,
			  227,  228, 1072,  229, 1408, 1409, 1410, 1297, 1411,   11,
			   12,    4,  813,  814,  873,  815, 1073, 1090,  913,  914,
			 1230, 1295, 1091, 1074, 1372, 1112,  631,  632,  633,  440,
			  441, 1016,  425,  426, 1017,  438,  807,  636,  637,  450,
			  451,  267,  268,  452,  230,  271,  659,  159,  154,  272,
			 1075, 1361, 1303, 1362,  874,  480,  709,  875,  454,  232,
			  233,  234,  235,  236,  237,  238,  239,  240,  466, 1001,
			  286,  287,  275,  276,  288, 1040,  467,  864,  660,  576,

			  577,  578,  579,  686,  580,  380,  687,  114,  115,   23,
			  116,  241,  139, 1079,    5,    6,   18,   14,   19,   20,
			   78,   15,   16,   36,   79,   80,   81,  242, 1080, 1081,
			 1082, 1083, 1084, 1413,  243, 1115,   83,  279,  280,   13,
			   28,  688,  865,  706,  707,  701,  702,  704,  705,  140,
			  995,  996,  997,  998,  755,  999, 1169, 1170,  244,  564,
			  245, 1307, 1308, 1159,  246,  247, 1207,   90,  248,  166,
			  167,  168,  120,  121,  169,  170, 1005,  575,  469,  470,
			  141,  471,  472, 1117,  249,   85,   86,  868,  869,  484,
			  870, 1188,  250,  251,  772,  252,  328,  143,  329, 1150,

			 1027,  822, 1028, 1245, 1298, 1299, 1227, 1085, 1507,  676,
			  677,  163,  461,    9,    8,   30,   31,   17,   38,   40,
			   88,  649,  202,  716,  122,  698,  700,  977,  976,  657,
			  699,  696,  697,  449,  658,  446,  662,  448,  273,  959,
			  473,  909,  456,  274, 1173, 1353, 1234,  566,  612,  369,
			  145,  587,  384,  749, yyDummy>>)
		end

	yypact_template: SPECIAL [INTEGER] is
			-- Template for `yypact'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 1509)
			yypact_template_1 (an_array)
			yypact_template_2 (an_array)
			Result := yyfixed_array (an_array)
		end

	yypact_template_1 (an_array: ARRAY [INTEGER]) is
			-- Fill chunk #1 of template for `yypact'.
		do
			yyarray_subcopy (an_array, <<
			   81,  459, 5628, 2095, -32768, -32768, 1414, -32768, -32768, -32768,
			 -32768, 1446, -32768,  378, -32768, 1334, -32768,  762, -32768, 1238,
			  742, 1797, 1453,  981, 1556, 1556, 1556, -32768, 1560, -32768,
			 -32768, -32768, -32768, -32768, -32768, 1442, -32768, -32768, -32768, -32768,
			 -32768,   42,   18, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, 1438, -32768, -32768,   41, 1435, -32768, 1432,
			 1797, -32768, -32768, -32768, -32768, -32768, -32768, -32768, 1231, 2120,
			 1534, 1550, 1546, 1545,  762, -32768, -32768, 1797, -32768, -32768,

			 -32768, -32768, -32768, -32768, 1411, 1422, -32768, 1531, 1797, -32768,
			 -32768, -32768,  762,  762,  719, 1231, -32768, 1486, -32768, 1941,
			 1302, 5607,  971,  762,  762,  762, -32768, -32768, 1015,  982,
			  788,  775, -32768,  928,  885,  971,  971,  971,  925,  770,
			  951, -32768, 1412, -32768, -32768, 4896, -32768, -32768, 1484, 1483,
			 -32768, -32768, -32768, 1617, 1485,  700, -32768, -32768, 1312, 1485,
			 1420, 1520,  459, -32768,  453,  770,   43,   16,  971, -32768,
			 -32768, -32768, -32768, -32768,  788,  900,  770,  788,  893,  770,
			 1399, -32768, -32768, 1739, 1440, 1439, -32768, -32768,  788,  807,
			  770,  788,  794,  770,  770,  770,  770, 1411, -32768, -32768,

			 1382, -32768, 1623,  762, 1379, 4896, 4896,  281, -32768, 1513,
			 4896, -32768, 1377, -32768, 4896, -32768, 4896, 1376, -32768, 1441,
			  942, 1255, 4998, 1381, 2120, 1380, -32768, 1373, -32768, -32768,
			 -32768, 5298, 1370, 1368, -32768, -32768,  954, -32768, -32768, -32768,
			 4794,  297, -32768, -32768, -32768, -32768, -32768, -32768, 1367, -32768,
			 1366, -32768, 4896, 1617, 1617,  829,  749, 1134,  775,  739,
			  738,  971,  971,  971, 1447, 1122,  951, 1312, -32768,  940,
			  488, 1210, -32768,  530, 4896, -32768, 1420, 1475, 1312, -32768,
			  459, -32768, -32768, 1481, 1372, -32768, 1475,  402, -32768, 1078,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,

			 1411, -32768, -32768, -32768, -32768, 1411, -32768, -32768, -32768, -32768,
			  720,  664,  728,  708,  678,  649,  571,  971,  971,  971,
			 1623,  915,  915, -32768, -32768, 1355,  770,  911, 1349, 1351,
			 -32768, 1411, -32768, -32768, -32768, -32768, 1411, -32768, -32768, -32768,
			 -32768, -32768, -32768, 1348, -32768,  366,  775, 1343, -32768, -32768,
			  762, -32768, -32768, -32768, -32768, 5619, 5597, -32768, -32768, -32768,
			  247,  775,  190, 1350, 1345, -32768, -32768, -32768, -32768, 4896,
			 1342,  971, -32768, 1340, 1411, -32768, -32768, 1329,  491, -32768,
			   45, 2729, -32768, 4896,   23, 1513, 1452, 1331, -32768, 1411,
			 4896, 4896, 4896, 4896, 4896, 4896, -32768, -32768, 4896, 4896,

			 4896, 4896, 4896, 4896, 4896, 4896, 4896, 4896, 4896, 4692,
			 4590, 4896,  762, -32768, -32768, -32768, 2594, 5342, 1447, 1447,
			 1134, 1122, 1134, 1122, 1326, -32768, -32768, 1480, -32768, -32768,
			 1134, 1122, 1134, 1122, 1122, 1122, 1122, 1434, -32768, 1319,
			 -32768, -32768, 1473, 1420, 1318, 1896,  762, 1120,  762,  700,
			 1313,  530, -32768,  949, 5177,  922, 4896,  459, 1420, 1421,
			 1150, 1414, -32768, -32768, -32768,  530, 1136, -32768, 1428, -32768,
			 -32768, -32768, -32768,  402,  374, 1416, 1189,   84, 1228, -32768,
			 1206, 1415, 1185, 1118, 1398, 1290, 1283,  788,  770,  788,
			  770, -32768, 1272, -32768, 1274, 1273, -32768,  788,  770,  788,

			  770,  770,  770,  770, -32768, 1271, 1270, 1269, -32768, -32768,
			 1411, 1264, -32768, -32768, 1268, 1267, 1259, -32768, -32768,  297,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 1411,  379, 5112, 4488, -32768, -32768, 4896, 1261, -32768, 1257,
			  530, 1253, -32768, 1411, 4386,  419,  762,  762,  326,  219,
			 -32768,  318, 1411,  252, 1251,  762, -32768,  530, 1242,  919,
			  919,  919,  919, 1058, 1058,   48,   48,   48,  919,  919,

			  919,  919,   48,   48, 5430, 5439, 4896, 5439, 4896, 5483,
			 -32768,  297, 4896, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768,  554,  511,  591,  563,  486,  505,  476,  971,  971,
			  971, 1473,  786,  786, -32768, -32768, 1247, 1246, 1230, 1122,
			  825, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,  762,
			 -32768,  125,  775, 1237, -32768,  459, -32768,  762,  762, -32768,
			  762, 1235,  762, -32768, -32768, -32768, -32768, 1233, 1233, -32768,
			 1215, 5098,  826, 1338,  459, -32768, -32768,  459, -32768, 1150,
			 1009, -32768, -32768,  402, 1411, -32768, -32768,   62,  459, -32768,
			 -32768,  762, 5255, -32768, -32768, -32768,  530,  530,  530,  530,

			  169, -32768, 1185, -32768, -32768, 1118, -32768, 1303, -32768, 1206,
			 1220, 1179, 1218, 1216, 1214, 1212, 1739,  915, 1739, 1211,
			 1197, 1195, 1190, 1187, 1186, 1182, -32768, -32768,  161, 1173,
			 1161,  762, 1623, 1623, -32768, 1159,  762, -32768, -32768, -32768,
			 -32768, -32768, -32768, 5254, 4284,  297, -32768,  491, -32768, 3555,
			  763, 4896, 4896,  245, 2120,  186, -32768,  751, -32768, -32768,
			 -32768, -32768, -32768, -32768, 1411,  763, 2120,  186, 4182, -32768,
			  803,  171, -32768, 1158, 5439, 5483, 2459, -32768, 5189, 4080,
			 1134, 1122, 1134, 1122, -32768, 1152, -32768, 1149, 1146, -32768,
			 1134, 1122, 1134, 1122, 1122, 1122, 1122, -32768, 1132, 1129,

			 1127, -32768, -32768, -32768, -32768, 1617, 1124, -32768,  211,   59,
			 -32768, -32768, 1234,  157,   69, -32768, 1116, -32768, -32768, -32768,
			 -32768, 1123, -32768, 1119, -32768, -32768, 1099, -32768, 1221, 1150,
			 -32768, -32768,  402, -32768, -32768, -32768, -32768, 1111, 1411,  459,
			  981, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, 1020,  530, -32768, -32768, 1229, -32768,  530,
			 -32768, -32768, -32768,  102, 1162, -32768, 1118, 1209, -32768, 1185,
			  762,  762, -32768, -32768, -32768, -32768, -32768,  915,  915, -32768,
			 -32768,  762,  762, -32768, 4896,  297, -32768, -32768, -32768, -32768,

			 -32768, -32768, 1513,  787, 3453, -32768, 5386,  222, 4896,  762,
			  425,  620,  360,  350,  350, 1069,  148,  425,  350,  350,
			 1513, 1181, -32768, -32768, -32768, -32768,  762, -32768, -32768, -32768,
			 1090, 1088, 1087, 1081, 1480,  786, 1480, 1076, 1073, 1072,
			 1059, 1055, 1049, 1042, -32768, -32768,   57, -32768, -32768, -32768,
			 1473, 1473, -32768, -32768, -32768, -32768, -32768, -32768, -32768, 1411,
			 -32768, -32768, 1150, -32768, -32768, -32768, -32768,  530, 1079, 1111,
			  981,  763, -32768,  530, -32768, -32768,  530,  169, 1151, -32768,
			 1118, -32768, -32768, -32768, -32768, -32768, -32768, 1031, -32768, -32768,
			 -32768, -32768, 2120,  186,  661,  762,  762,  762,  762, -32768, yyDummy>>,
			1, 1000, 0)
		end

	yypact_template_2 (an_array: ARRAY [INTEGER]) is
			-- Fill chunk #2 of template for `yypact'.
		do
			yyarray_subcopy (an_array, <<
			 2120,  350, 3672, 3672, 3978,  183,  183, -32768, 2120,  186,
			  350,  183,  183, 1030,  762,  297, -32768, -32768, -32768, -32768,
			 -32768,  786,  786, -32768, -32768, 1150,  415, 1411, -32768, -32768,
			 1150, -32768, -32768, 5065, 2068,  981,  773,  763,  725, 1021,
			 -32768, 1020,  530, -32768, -32768, 1130,  601,  425,  350,  350,
			 -32768, 1411, -32768, -32768, -32768, -32768, -32768, 1125, -32768, 1462,
			 1411, -32768,   72,  628, 4896, 4896,  647, 1019, 1013,  582,
			 3876, 1068, 1066, -32768, 1097, -32768,  995,  954, 2223, -32768,
			 -32768, 1700, -32768, -32768, -32768,  512, -32768, 4896, 4896, 1106,
			 1105, -32768, 1102,  425,  350,  350, 1095, 1091, 1084,  956,

			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, 1411, -32768,  -54,
			 -32768, -32768,  -54, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			  -54,  -54,  981,  763,  459,  981,  603,  350, 2120,  186,
			 -32768, -32768, -32768, -32768,  350,  183,  183,  944, -32768,  357,
			  208,  788,  775,  305,  192,  971,  971,  971,  770,  951,
			  932,  936,  971, 3351, 1570, 2290, 3672, 1411,  898, 1024,
			 1411, -32768, -32768,  894, -32768, 3774, 4896, 4896, 4896, -32768,
			  461,  762, 2863, 3672, 4896, 4896, 4896, 3672, -32768, -32768,
			  350,  183,  183, -32768, -32768, -32768,  873, -32768, -32768, -32768,
			 -32768, -32768,  763,  520,  981,  763,  350, 2120,  186,  994,

			  425,  350,  350,  993,  964,  959, -32768,  491,  788,  770,
			  788,  770,  804, -32768, -32768, -32768,  788,  770,  788,  770,
			  770,  770,  770, -32768,  412,  713,  783,  882,  695,  349,
			  673, -32768,  761, -32768, 2120, -32768, 3672,  750,  762, -32768,
			 5386, 5386, 4896, 4896, 4896,  730,  297, -32768, 5386, 5386,
			 -32768,  491,  491,  840,  812,  808,  491,  491,  491,  226,
			  465,  350, 2120,  186,  763,  306,  765,  425,  350,  350,
			  -54,  350,  183,  183, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768,  762, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			  633,  762,  297, -32768,  758,  731,  717,  714,  695, -32768,

			 3672, -32768,  718,  607,  663,  598,  484, 2120, -32768,  710,
			  412,  297, 5386,  420, 2301, 4896, 1969, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768,  350, 2120,  186,  702,  425,
			  350,  350,  212,  350, 2120,  186,  -54,  350,  183,  183,
			 -32768,  689,  684,  675,  491,  491,  491,  297,  762,  297,
			 3229, 3672, -32768,  342, -32768, -32768, -32768, -32768, -32768,  665,
			 4896,  663, -32768,  762, -32768, -32768, -32768, -32768,  519, -32768,
			 4896,  176,  119, 2301,  491,  491,  491,  629,  425,  350,
			  350,  -54,  350,  183,  183,  350, 2120,  186,  612,  425,
			  350,  350, -32768,  586,  578,  570,  -54,  -54,  -54, -32768,

			 -32768, -32768, -32768,  297, 3107, -32768, 1411, -32768,  439,  498,
			  342, -32768, -32768, -32768, -32768, -32768, 2290, -32768,  297,  762,
			 5386, 3672, -32768,  537,  513, -32768, -32768, -32768,  -54,  350,
			  183,  183, -32768,  503,  455,  444,  441,  425,  350,  350,
			  -54,  350,  183,  183,  -54,  -54,  -54, -32768, -32768, -32768,
			 -32768,  315, -32768,  342, -32768, -32768, 2985,  297, -32768, -32768,
			 -32768, -32768,  401,  384,  368,  -54,  -54,  -54,  -54,  350,
			  183,  183, -32768,  327,  310,  284, -32768, -32768, -32768,   78,
			 -32768, -32768,  -54,  -54,  -54, -32768, -32768, -32768, -32768,  258,
			  200,  134,  -54,  -54,  -54, -32768, -32768, -32768,  -54,  -54,

			  -54, -32768, -32768, -32768, -32768, -32768, -32768,  178,  135, -32768, yyDummy>>,
			1, 510, 1000)
		end

	yypgoto_template: SPECIAL [INTEGER] is
			-- Template for `yypgoto'
		once
			Result := yyfixed_array (<<
			 -204,  927, -32768, -32768, -32768, -152, -163, -137, -121, -309,
			 -161, -32768, -32768, -722,  760, -32768, -32768,  692,   -3,  881,
			 -409, -32768, -32768,  -17, -32768,  204, -32768, -32768,  249, -32768,
			 1193,    9, -32768, -32768,  442,  170, -974,   49, -666, -739,
			 -1237, -1145, -32768, -32768,  285,  622, -32768, -32768, -32768, 1008,
			  502, -356, -451, -120, -415,  545,  838, -140, -32768, -32768,
			 -32768, 1482, 1519, 1191,  118, -32768, -397, -32768, -32768, -130,
			 -32768, -32768, -32768,  278, -32768, 1153, -32768,  653, 1017, -412,
			 -32768, -32768, -32768, -753, -32768, -148, -201, -290, -450, -863,
			 -32768, -32768, 1507, -149, 1352,  580, -198, -570, -612, -32768,

			 -32768, -32768, -32768, 1400,  723, -32768, -32768, -32768, -32768, -32768,
			 1504,  -16, 1316, -32768, -32768, -110, 1064,  916, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768,  147, -32768, -32768, -32768,
			 -32768, -32768, -32768,  -93, -1001,  -21, -32768, 1494, -230, -32768,
			 1344,  931, -597, 1328, -660, 1323,  901, 1320, -672,  -19,
			 -32768, -32768, -32768, -32768, -543,   82, -32768, -32768, -32768, 1044,
			  -15, -32768,  298, -32768, 1523, 1357, -376, -814,  -80, -32768,
			 -32768, -32768, -32768, -32768, 1192, 1029,  394, -353, -341, 1138,
			 -32768, -362, 1135, -32768, -144, -554, -32768, -32768, -32768, -32768,
			  732,  354, -1284, -32768,  827, -207,  -57, -32768, -32768, -32768,

			 -32768,  926,  564,  220, -32768,  288, -32768, -1020, -32768, -591,
			 -32768, -153, -32768, -32768, -32768, -32768, -32768,   10, -32768, -32768,
			 -32768, -32768,  398, -343, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -539, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, yyDummy>>)
		end

	yytable_template: SPECIAL [INTEGER] is
			-- Template for `yytable'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 5723)
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
			   82,   35,  201,  492,   75,   77,   84,  738,  282,  357,
			    7,  161,  635,  264,  383,  680,  372,  771,   74,   21,
			  323,  386,  324,  378,  303,  900,  971,  308,  919, 1086,
			  876,  583, 1114, 1114,  285,  752,  492,  808,  334,  348,
			  767,  339,  340,  341,  342,  877,  457,  142,   21, 1163,
			   21,  663,  283,  299, 1010,  106,  304,  351,  352,   82,
			 1354,  574,  365,   75,  110,   84,  366,  330,  367, 1414,
			  335,  634,  117,  949,  118,  453,   82,   74,  126,  563,
			   75,  110,   84,  574, 1187, 1302,  654,   82,  831,  685,
			  132,   75,  110,   84,   74,  103,  148,  149, -198,  117,

			  866,  918,  871,    3,  690,   74,  975,  171,  172,  173,
			  187,  695,    2,  418,  419,  186, -182,  132,  443,  101,
			 1212,  411,  199,  102, -198,  689, 1414,  359,  460,  458,
			  155,  164,  694, 1422,  266, 1509, -651, -651, -182,   76,
			  343,  382, -182,   34,   33,   32, -182,  100, 1500,  582,
			  717,    1,  364,  718,  294,   68, 1037,  504, 1359,  302,
			  508,  509,  307,  399,  327, 1008, 1243,  325,  277, 1414,
			  459,  573,  785,  333,  732,  733,  338,  753, 1508, 1455,
			  105,  291, 1231,  327, 1134, 1024,  819,  349,  838,  511,
			 -548,  358,  955,  363,  356, 1023,  808,  912,   76, 1247,

			  785,  771, -631, 1250, 1290,  381,  355,  980,  736,  388,
			  185,  184,  908,  655, 1499,   76,  978,  801,  802,  911,
			  192, 1123, 1089, -548, -182,  947,   76,  111,  674, 1386,
			 1180,   34,   33,   32,  266,  266,  178,  429,  964,  992,
			 -182,  753,  428,  485,  127,   34,   33,   32,  486, 1077,
			 1077,  753,  810,  453, 1049,  147, -398,  358,  455,  691,
			 1385,  817, 1309,  818,  424,  820,  132,  972, 1218,  766,
			 1095,  468, 1498,  563,  514,  797,  744,  277, -398,  515,
			  953,  753,  362,   33, 1210,   34,   33,   32,  277,  890,
			 1368,  444,  495,   34,   33,   32,  924,  494, 1494,  889,

			  616,  327,  618,   68,  356,  325,  325,  872, 1192,  679,
			  641, 1195,  643, -494, 1161,  734,  355,  569,  834,  664,
			 1045,  836,  779, 1334, 1493,  495, 1356, 1048,  584, -494,
			  494,   45,  588,  189,  519,  753,  713, 1271,  715,  833,
			  187, 1492,  835, 1094,  761,  186,  720,  673,  722,  723,
			  724,  725, 1114,  354, 1333,   34,   33,   32,   42,   41,
			  225, -540, -540, -540,  993, 1004,  712,  581,  714,  363,
			 -506, 1029,  747, 1009, -536, -536,  719, 1405,  721,  132,
			 1264, 1216, 1484,  887,  888,  175,  180,  353, -203,  770,
			 1202, -540, -394, -394, -394,   27,  611,  907, 1483, -536,

			   34,   33,   32, 1077, 1337,  208, 1042,  776,  640, 1114,
			 -203,  638,  916,   69, -203, 1482,   34,   33,   32,   68,
			 1077,  370,  465,  640, 1077,  356,   26,   25, 1000,   24,
			  661,  132,  661, 1208, 1102,  358,  754,  355, 1479, 1106,
			  672,  934,  370,  935,  764,  763,  936, 1458,  753,  468,
			  468,  759, 1114,  728,  744, 1468,   68,  468, 1467, 1269,
			   44,  270,  269, 1201, 1406, 1088, 1382,  950,  951, 1466,
			  966,  284, 1042,  691,  185,  184,   34,   33,   32, 1119,
			 1119,    3, 1326, 1077,   45, 1277,   34,   33,   32,  779,
			    2,  965,  738,  517,  753, 1129, -230, -230,  863,  863,

			  867,  863, -230,  735,  192,  180, -230, 1244, 1243,  736,
			 -230,   42,   41, 1325, -230, 1429,  750, 1465, 1161, -230,
			 1018, 1020,  829, 1039, 1331,  765, 1441, 1460,  183, 1317,
			 1318, 1165, 1268,  189, 1322, 1323, 1324, 1262, 1104,  178,
			  737,  899, 1103, -230,  370,  812, 1370, 1077, 1176,  753,
			  132, 1459,  792,  356,  358,  885,  884,  886,  455, 1453,
			  757,  757,  757,  757,  828,  355, 1452,  921, 1261,  769,
			  885,  358,  183,  770, 1469,  183, 1175, 1174,  840,  132,
			 1019,  790,  175, 1198, 1446,  132,  183,  782, 1380,  183,
			 1076, 1076, 1445, 1071, 1071, 1019, 1391, 1330, 1077,  192,

			 1444, 1021, 1022,  788,   34,   33,   32, 1020,  787, 1365,
			  444, 1364,  640,  789, -494,  571,  638,  638, 1038, 1294,
			 1197, 1358, 1399, 1400, 1401, -494, 1440,  837,  132, 1242,
			  780,  788,  753,  809, -538, -538,  787,   34,   33,   32,
			   68,  816,  661, 1428,  661,  132,  661,  499, 1439, 1419,
			 1263, 1196, 1425, 1426, 1427,  427,   34,   33,   32, -538,
			  930, 1379,  932,  442,  468,  946,  863,  468, 1077, 1390,
			  937,  867,  939, -546,  962,  757, 1360,  189,   68, 1415,
			  358,  358,  358,  358, 1126, 1294,  830, 1301, 1161, 1398,
			  786,  986,  178, -546, -546,  185,  184,  327, 1397,  327,

			  325,  325,  325, 1396, 1160,  738,   45,  915,  270,  269,
			  183,  445,  447,  327,  327,  893, 1381, 1327,  784, -127,
			  895, 1438, 1335,  132, 1367,  497,  463,  886, 1363,  970,
			  424,  736, 1357,   42,   41,  455,  672, 1296,  132,  910,
			  489, 1133, 1128,  183, 1076, 1352,  985, 1071,  175,  -34,
			 1152,  917,  370,  -34,  753,  358,  -34, 1229,  183,  -34,
			 -595, 1076,  -34, 1348, 1071, 1076,  192,  189, 1071, 1031,
			 1193,  -34, -542, 1127,  -34,  -34, 1315,  178, 1041, 1336,
			  -34,  969,   34,   33,   32,   68,  266, 1051, 1050, 1387,
			  -34,  -34,  809,  -34,  132,    3,  487,  816,  816, 1025,

			 1124,  574, 1251, 1252,    2,  496, -494, 1256, 1257, 1258,
			 1030, 1101,  132,  132,  432,  430,  468, -494,  427,  442,
			  427,  442, 1321,  132, 1076,  422, 1320, 1071,  427,  442,
			  427,  442,  442,  442,  442,  493,   34,   33,   32, 1260,
			  185,  184, 1265, 1291, 1041,  987,  151,  150,  358,   34,
			   33,   32,   68,  358, 1319,  491, -506,  175, 1035, 1153,
			  800,  799,  798, 1013,  981,  982,  337,  180,   34,   33,
			   32,  325,  325, 1310, 1172,  983,  984,  764,  763,  332,
			   39,   34,   33,   32, 1305,  183,  363,  183, 1076, 1118,
			 1118, 1071,  672,  994, 1294,  183, 1293,  183, 1344, 1345,

			 1346, 1280, 1026,  132,  363,  420, 1292,  185,  184,  200,
			 1015, 1332,  989,  192,  988,  640,  336,  640,  638,  638,
			  638, 1002, 1003,  617, 1122,  619, 1125,  180,  923,  331,
			  922,  640,  640,  642, 1282,  644,  645,  646,  647, 1076,
			 1113, 1113, 1071, 1374, 1375, 1376,   95,   96, -224, -224,
			  370,  358,  826,  -94, -224,  203,  189,  468, -224,  132,
			  358,  191, -224,  614,  615,  306, -224,   34,   33,   32,
			 1026, -224,  301, 1276,   34,   33,   32, 1047, 1275,  994,
			  994,  994,  994,  954,  956, 1056, 1078, 1078,  455,  507,
			  506,  505,  411, 1093, 1137, -224, 1259,  198, 1100,   34, yyDummy>>,
			1, 1000, 0)
		end

	yytable_template_2 (an_array: ARRAY [INTEGER]) is
			-- Fill chunk #2 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			   33,   32,  132, 1151,  188,  638,  638, 1274, 1270, 1076,
			  178, 1223, 1071,   89, 1194,  305, 1111, 1111, 1116, 1116,
			 1213,  427,  300, 1233, 1238,  737,  358,  406,  405,  465,
			 1110, 1110,  356,  400,  399,  398,  685,  442, 1235, -453,
			 1149,  203, 1316,  175,  355,  132,  370,  197,  670,  427,
			 1186,  395,  394, 1162,  455, 1092,  132, 1279,  177, 1225,
			 1097, 1098,  444, 1224,  371, 1284,  370, 1286, 1287, 1288,
			 1289,  455,  672,  668, 1281,  667, 1156, 1052, 1053, 1054,
			 1055,  203, 1206,   34,   33,   32,  736, 1278, 1350,  132,
			  -23,  174,  479,  413,  478, 1283,  -23, 1285, 1185, 1177,

			 1232,    3,   98, 1237,   99, 1184, 1034, 1369,  -23, 1183,
			    2,  -23,  -23, 1200,  477,  476, 1179,  -23,  475, 1178,
			 -544, 1215,  474, 1168, 1162, 1171, 1214,  -23, -229, -229,
			 1167,  411, 1166,  373, -229,  684,  832, 1158, -229, 1138,
			 1078, 1157, -229, 1402, 1132, 1404, -229,  922, 1130,  672,
			   -4, -229,  455, 1099, 1046, 1246,  465, 1078,  475,  356,
			  672, 1078,  231,  685, 1228, 1044,  406,  405,  967, 1236,
			  -87,  355,  400,  399,  398, -229, -178,  -89,  427,  442,
			  427,  442, 1267,  -88, 1204, 1205, 1014,  -90,  427,  442,
			  427,  442,  442,  442,  442,  293,  296,  298, -178, 1450,

			  -98,  -91, -178, -165,  -99, -165, -178, 1007, 1162,  -92,
			   34,   33,   32, 1033, 1456, -100,  -93, 1032, -101, 1306,
			 1078,  477, 1311,  979, -220, -165,  672, 1313, -220, -165,
			 1254, 1255, -220, -165,  973,  963, -220,  961,  737, 1300,
			 1304, -220, -173,  957,  960,  -33,  958, 1329,  952,  -33,
			  474, -102,  -33, 1481,  945,  -33,  786,  231,  -33,  944,
			  373,  439,  684,  683, -173, -220, 1347,  -33, -173,  417,
			  -33,  -33, -173,  424,  -95, 1349,  -33,  -96,  356, -113,
			  113,  112,  894,  931, 1078,  933,  -33,  -33,  926,  -33,
			  355,  892, 1306,  938, 1162,  940,  941,  942,  943,  756,

			  758,  760,  762,  891, 1351,   34,   33,   32, 1006,  881,
			 -446, 1378, 1011, 1012, -448, -447, -217,  878, -449, 1389,
			 -217, 1342, 1343, -457, -217, -450, -255,  376, -217,   34,
			   33,   32, 1403, -217, -255, 1078, 1407, 1412, -255, -458,
			 -451,  -25, -459, -255, -452,  -25, -460, 1418,  -25, 1451,
			  880,  -25,  827,  824,  -25,  821,  805, -217,  292,  295,
			  297,  375,  819,  -25,  811,  773,  -25,  -25,   91,   92,
			   93, 1437,  -25,  804,  768,  803,   37,  374,  748,  373,
			  746, 1421,  -25,  -25,  745,  -25,  562, 1394, 1395,  731,
			  730,  729, -445, 1407, 1412, 1057,  727,  493,  726, -472,

			  417, -454, -455, 1457, 1096, 1078,  711,  589,  590,  591,
			  592,  593,  594,  710,  478,  595,  596,  597,  598,  599,
			  600,  601,  602,  603,  604,  605,  607,  609,  610,  703,
			 -208,  692, 1434, 1435,   10,  675, 1407, 1412,  165,  138,
			  665,  656, 1135, 1136,  176,  179,  157,  650,  648,  190,
			  193,  194,  195,  196,  620,  437,  586,  585,  737,  570,
			  137,  136,  135,  134,  133,  568, 1189,  565,  561,  265,
			  518,  516,   29,  671, 1190, 1191,  560,  512,  513, 1463,
			 1464,  510,  165,  165,  165,  132,  131,  130, 1181, 1182,
			  138, 1474, 1475,  284,  444,  462, -636, -633, -634,  326,

			  412,  138,  389, -635,  368,  387, -632, -631,  138,  350,
			  344, 1147, 1146, 1145, 1144, 1143,  103,  101,  326, 1490,
			 1491, 1199,  630,  629,  628,  627,  626,  309, 1203,  630,
			  629,  628,  627,  626,  281,  204,  132, 1142, 1141,  183,
			  156,  138,  129,  254,  253,  146,  153,  653,  652,  651,
			  144,  128,  125,  124,  625,  624,  623,  123,  119,  109,
			  104,  108,  137,  136,  135,  134,  133,   94,   97,  265,
			  265,  421,  423,   27, 1253,  431,  433,  434,  435,  436,
			  562,   87, -590,  743, -590,   22, 1355,  362,  361,  360,
			 1266, 1105, 1423, 1140,  823, 1272, 1273,  415,  925,  107,

			  682,  974, 1139,  681,  622, 1366,  183,  741,  183,  483,
			  879,  622,  482,  621,  183,  162,  183,  481,  839,  152,
			  621,  379, 1131,  774, 1340,  775,  488,  490,  160,  778,
			 1043,  498,  500,  501,  502,  503,  326,  708,  464, 1417,
			  158,  278,  666,  411,  129,  138,  948,  806,  410,  409,
			  408,  138,  407,  128,  678, 1328, 1121, 1480, 1424, 1454,
			  929, 1036, 1338, 1339,  991, 1341,  263,  262,  261,  260,
			  259,  898,  319,  318,  317,  316,  315,    0,  406,  405,
			  404,  403,  402,  401,  400,  399,  398,  567,    0,    0,
			 1392,  132,  258,  257,    0,    0,    0,  347,  346,  345,

			    0,    0,  395,  394,  393,  392,  391,  390,    0,    0,
			    0,    0, -550, -550, -550, -550,    0,    0,    0, 1377,
			    0,    0,    0,    0, 1383, 1384, -550, 1388,    0,    0,
			    0, 1393,    0,    0,    0, 1432,    0,    0,    0, -550,
			    0,    0, -550,  639,    0,    0, -550, -550,  256,    0,
			 1447, 1448, 1449,    0,  311,    0,    0,  255,  639,    0,
			    0,  743,    0,  310,    0,    0,  906,  138,    0,  671,
			    0,    0,    0, 1430, 1431,    0, 1433,    0,    0, 1436,
			    0,    0, 1461,    0, 1442, 1443,    0,    0,  319,  318,
			  317,  316,  315,    0, 1472,    0,  778,    0, 1476, 1477,

			 1478,    0,    0,    0,    0,   73,    0,    0,    0,    0,
			    0,    0,    0,  314,  313,  312,    0,    0,    0, 1485,
			 1486, 1487, 1488, 1462,    0,    0,    0,    0,    0,    0,
			    0,    0, 1470, 1471,    0, 1473, 1495, 1496, 1497,    0,
			    0,    0,    0,    0,    0,    0, 1501, 1502, 1503,    0,
			    0,    0, 1504, 1505, 1506,    0,    0,    0,    0,    0,
			    0,    0,    0, 1489,   72,   71,   70,    0,   69,    0,
			  311,   34,   33,   32,   68,    0,    0,    0,    0,  310,
			   67,   66,   65,   64,   63,   62,   61,   60,   59,   58,
			   57,   56,   55,   54,   53,   52,   51,   50,   49,   48,

			   47,   46,   45,    0, -223, -223,    0,    0,    0,    0,
			 -223,    0,    0,    0, -223,   44,   43,    0, -223,    0,
			    0,  906, -223,    0,    0,  671,    0, -223,    0,   42,
			   41,    0,    0,    0,    0,    0,    0,  781,  783,    0,
			    0,    0,  791,  793,  794,  795,  796,  639,    0, -143,
			 -143, -223,    0,    0,    0, -143,    0,    0,    0, -143,
			    0,    0,    0, -143,    0,    0,    0, -143,    0,    0,
			    0,    0, -143,    0,    0, -618,    0, -618,    0, -618,
			    0, -618, -618, -618, -618,    0,    0, -618, -618,    0,
			 -618,    0,    0,    0, -618, -618, -143,    0,    0,    0, yyDummy>>,
			1, 1000, 1000)
		end

	yytable_template_3 (an_array: ARRAY [INTEGER]) is
			-- Fill chunk #3 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			    0,    0,    0, -618,    0,    0,    0,    0, -618,    0,
			 -618, -618,    0,    0,    0, -618, -618,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0, -618, -618,    0,
			    0, -618,  326, -625,  326,    0, -618, -618, -618,    0,
			 -618, -618,    0, -618, -618, -618,    0,    0,  326,  326,
			    0,    0, -618, -618, -618, -618, -618, -618, -618, -618,
			 -618, -618, -618, -618, -618, -618, -618, -618, -618, -618,
			 -618, -618, -618, -618,    0, -618, -618,    0,    0,    0,
			    0, 1154, 1155,    0,    0,    0, -618, -618, -618,    0,
			    3, -618,    0, -618,    0,    0,    0,    0, -618,    2,

			 -618,    0,  -17,    0,    0,  671,  -17, -618, -624,  -17,
			    0,    0,  -17, 1120,    0,  -17,    0,    0,    0,    0,
			    0,  265,    0,    0,  -17,    0,    0,  -17,  -17,    0,
			    0,    0,    0,  -17,    0, 1108,   71,   70,    0,   69,
			    0,    0,    0,  -17,  -17,   68,  -17,    0,    0,    0,
			    0,   67,   66,   65,   64,   63,   62,   61,   60,   59,
			   58,   57,   56,   55,   54,   53,   52,   51,   50,   49,
			   48,   47,   46,   45,    0,    0,    0,    0,    0,    0,
			    0,    0,  671, 1240, 1241,    0,   44,   43,    0,    0,
			 1107, 1248, 1249,  671,    0,    0,    0,    0,    0,    0,

			   42,   41,    0,   67,   66,   65,   64,   63,   62,   61,
			   60,   59,   58,   57,   56,   55,   54,   53,   52,   51,
			   50,   49,   48,   47,   46,    0,    0,    0,    0, -638,
			    0, -638,    0, -638,    0, -638, -638, -638, -638,   43,
			    0, -638, -638,    0, -638,    0,    0,    0, -638, -638,
			  639,    0,  639,    0,    0,    0,    0, -638,    0,  671,
			 1312, 1314, -638,    0, -638, -638,  639,  639,    0, -638,
			 -638,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0, -638, -638,    0,    0, -638,    0,    0,    0,    0,
			 -638, -638, -638,    0, -638, -638,    0, -638, -638, -638,

			    0,    0,    0,    0,    0,    0, -638, -638, -638, -638,
			 -638, -638, -638, -638, -638, -638, -638, -638, -638, -638,
			 -638, -638, -638, -638, -638, -638, -638, -638,    0, -638,
			 -638, 1371, 1373, 1229,    0,    0,    0,    0,    0,    0,
			 -638, -638, -638,    0,    0, -638,    0,  370,    0,    0,
			    0,    0, -638, -638, -638,    0,    0,    0,    0,    0,
			    0, -638, -638,  411,    0,    0,    0,    0,  410,  409,
			  408,    0,  407,    0,  411, 1148,    0, 1416,    0,  410,
			  409,  408,    0,  407,    0,    0,    0, 1420,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,  406,  405,

			  404,  403,  402,  401,  400,  399,  398,    0,    0,  406,
			  405,  404,  403,  402,  401,  400,  399,  398,    0,    0,
			    0,    0,  395,  394,  393,  392,  391,  390,    0,    0,
			    0,    0,    0,  395,  394,  393,  392,  391,  390,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0, 1209, 1211,    0,    0, 1217,
			 1219, 1220, 1221, 1222, -624, -624,    0, -624, 1226, -624,
			 -624, -624, -624, -624, -624,    0, -624, -624, -624,    0,
			 -624, -624,    0,    0, -624, -624,    0,    0, -624, -624,
			 -624,    0, -624, -624,    0,    0,    0,    0, -624,    0,

			 -624, -624, -624,    0,    0, -624, -624, -624,    0,    0,
			    0, -624,    0,    0,    0,    0,    0, -624, -624,    0,
			    0, -624, -624,    0,    0,    0, -624, -624, -624,    0,
			 -624, -624, -624, -624, -624, -624, -624, -624, -624, -624,
			 -624, -624, -624, -624, -624, -624, -624, -624, -624, -624,
			 -624, -624, -624, -624, -624, -624, -624, -624, -624, -624,
			 -624, -624, -624, -624, -624, -624, -624, -624, -624, -624,
			 -624, -624, -624, -624, -624, -624, -624, -624, -624,    0,
			 -624, -624,    0, -624, -624,    0, -624, -624, -624,    0,
			 -624, -624, -624, -624, -624, -624, -624, -624, -624, -623,

			 -623,    0, -623,    0, -623, -623, -623, -623, -623, -623,
			    0, -623, -623, -623,    0, -623, -623,    0,    0, -623,
			 -623,    0,    0, -623, -623, -623,    0, -623, -623,    0,
			    0,    0,    0, -623,    0, -623, -623, -623,    0,    0,
			 -623, -623, -623,    0,    0,    0, -623,    0,    0,    0,
			    0,    0, -623, -623,    0,    0, -623, -623,    0,    0,
			    0, -623, -623, -623,    0, -623, -623, -623, -623, -623,
			 -623, -623, -623, -623, -623, -623, -623, -623, -623, -623,
			 -623, -623, -623, -623, -623, -623, -623, -623, -623, -623,
			 -623, -623, -623, -623, -623, -623, -623, -623, -623, -623,

			 -623, -623, -623, -623, -623, -623, -623, -623, -623, -623,
			 -623, -623, -623, -623,    0, -623, -623,    0, -623, -623,
			    0, -623, -623, -623,    0, -623, -623, -623, -623, -623,
			 -623, -623, -623, -623, -318, -318,    0, -318,    0, -318,
			 -318, -318, -318, -318, -318,    0, -318, -318, -318,    0,
			 -318, -318,    0,    0, -318, -318,    0,    0, -318, -318,
			 -318,    0, -318, -318,    0,    0,    0,    0, -318,    0,
			 -318, -318, -318,    0,    0, -318, -318, -318,    0,    0,
			    0, -318,    0,    0,    0,    0,    0, -318, -318,    0,
			    0, -318, -318,    0,    0,    0, -318, -318, -318,    0,

			 -318, -318, -318, -318, -318, -318, -318, -318, -318, -318,
			 -318, -318, -318, -318, -318, -318, -318, -318, -318, -318,
			 -318, -318, -318, -318, -318, -318, -318, -318, -318, -318,
			 -318, -318, -318, -318, -318, -318, -318, -318, -318, -318,
			 -318, -318, -318, -318, -318, -318, -318, -318, -318,    0,
			 -318, -318,    0, -318, -318,    0, -318, -318, -318,    0,
			 -318, -318, -318, -318, -318, -318, -318, -318, -318, -617,
			    0, -617,    0, -617,    0, -617, -617, -617, -617,    0,
			    0, -617, -617,    0, -617,    0,    0,    0, -617, -617,
			    0,    0,    0,    0,    0,    0,    0, -617,    0,    0,

			    0,    0, -617,    0, -617, -617,    0,    0,    0, -617,
			 -617,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0, -617, -617,    0,    0, -617,    0,    0,    0,    0,
			 -617, -617, -617,    0, -617, -617,    0, -617, -617, -617,
			    0,    0,    0,    0,    0,    0, -617, -617, -617, -617,
			 -617, -617, -617, -617, -617, -617, -617, -617, -617, -617,
			 -617, -617, -617, -617, -617, -617, -617, -617,    0, -617,
			 -617,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			 -617, -617, -617,    0,    0, -617,    0, -617,    0,    0,
			    0, -621, -617, -621, -617, -621,    0, -621, -621, -621, yyDummy>>,
			1, 1000, 2000)
		end

	yytable_template_4 (an_array: ARRAY [INTEGER]) is
			-- Fill chunk #4 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			 -621, -617, -623, -621, -621,    0, -621,    0,    0,    0,
			 -621, -621,    0,    0,    0,    0,    0,    0,    0, -621,
			    0,    0,    0,    0, -621,    0, -621, -621,    0,    0,
			    0, -621, -621,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0, -621, -621,    0,    0, -621,    0,    0,
			    0,    0, -621, -621, -621,    0, -621, -621,    0, -621,
			 -621, -621,    0,    0,    0,    0,    0,    0, -621, -621,
			 -621, -621, -621, -621, -621, -621, -621, -621, -621, -621,
			 -621, -621, -621, -621, -621, -621, -621, -621, -621, -621,
			    0, -621, -621,    0,    0,    0,    0,    0,    0,    0,

			    0,    0, -621, -621, -621,    0,    0, -621,    0, -621,
			    0,    0,    0, -622, -621, -622, -621, -622,    0, -622,
			 -622, -622, -622, -621,    0, -622, -622,    0, -622,    0,
			    0,    0, -622, -622,    0,    0,    0,    0,    0,    0,
			    0, -622,    0,    0,    0,    0, -622,    0, -622, -622,
			    0,    0,    0, -622, -622,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0, -622, -622,    0,    0, -622,
			    0,    0,    0,    0, -622, -622, -622,    0, -622, -622,
			    0, -622, -622, -622,    0,    0,    0,    0,    0,    0,
			 -622, -622, -622, -622, -622, -622, -622, -622, -622, -622,

			 -622, -622, -622, -622, -622, -622, -622, -622, -622, -622,
			 -622, -622,    0, -622, -622,    0,    0,    0,    0,    0,
			    0,    0,    0,    0, -622, -622, -622,    0,    0, -622,
			    0, -622,    0,    0,    0, -620, -622, -620, -622, -620,
			    0, -620, -620, -620, -620, -622,    0, -620, -620,    0,
			 -620,    0,    0,    0, -620, -620,    0,    0,    0,    0,
			    0,    0,    0, -620,    0,    0,    0,    0, -620,    0,
			 -620, -620,    0,    0,    0, -620, -620,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0, -620, -620,    0,
			    0, -620,    0,    0,    0,    0, -620, -620, -620,    0,

			 -620, -620,    0, -620, -620, -620,    0,    0,    0,    0,
			    0,    0, -620, -620, -620, -620, -620, -620, -620, -620,
			 -620, -620, -620, -620, -620, -620, -620, -620, -620, -620,
			 -620, -620, -620, -620,    0, -620, -620,    0,    0,    0,
			    0,    0,    0,    0,    0,    0, -620, -620, -620,    0,
			    0, -620,    0, -620,    0,    0,    0, -619, -620, -619,
			 -620, -619,    0, -619, -619, -619, -619, -620,    0, -619,
			 -619,    0, -619,    0,    0,    0, -619, -619,    0,    0,
			    0,    0,    0,    0,    0, -619,    0,    0,    0,    0,
			 -619,    0, -619, -619,    0,    0,    0, -619, -619,    0,

			    0,    0,    0,    0,    0,    0,    0,    0,    0, -619,
			 -619,    0,    0, -619,    0,    0,    0,    0, -619, -619,
			 -619,    0, -619, -619,    0, -619, -619, -619,    0,    0,
			    0,    0,    0,    0, -619, -619, -619, -619, -619, -619,
			 -619, -619, -619, -619, -619, -619, -619, -619, -619, -619,
			 -619, -619, -619, -619, -619, -619,    0, -619, -619,    0,
			    0,   73,    0,    0,    0,    0,    0,    0, -619, -619,
			 -619,  225,    0, -619,    0, -619,    0,    0,    0,    0,
			 -619,    0, -619,    0,    0,    0,    0,  224,    0, -619,
			    0,    0,    0,    0,  223,    0,    0,    0,    0,    0,

			    0,    0,    0,    0,    0,  222,    0,    0,    0,    0,
			    0,  221,  220,    0,    0,  219,    0,    0,    0,    0,
			  218,   71,   70,    0,   69,  217,  216,   34,   33,   32,
			  215,    0,    0,    0,  214,    0,   67,   66,   65,   64,
			   63,   62,   61,   60,   59,   58,   57,   56,   55,   54,
			   53,   52,   51,   50,   49,   48,   47,   46,  213,  212,
			    0,    0,    0,   73,    0,    0,    0,    0,    0,    0,
			  211,   44,   43,  225,  210,  902,    0,  208,  990,    0,
			    0,    0,  207,    0,    0,  206,  205,    0,    0,  224,
			    0,    0,  105,  901,    0,    0,  223,    0,    0,    0,

			    0,    0,    0,    0,    0,    0,    0,  222,    0,    0,
			    0,    0,    0,  221,  220,    0,    0,  219,    0,    0,
			    0,    0,  218,   71,   70,    0,   69,  217,  216,   34,
			   33,   32,  215,    0,    0,    0,  214,    0,   67,   66,
			   65,   64,   63,   62,   61,   60,   59,   58,   57,   56,
			   55,   54,   53,   52,   51,   50,   49,   48,   47,   46,
			  213,  212,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,  211,   44,   43,    0,  210,  902, 1070,  208,
			 1069,    0, 1068,    0,  207,    0,    0,  206,  205,    0,
			 1067, 1066,    0, 1065,  105,  901,    0, 1064,    0,    0,

			    0,    0,    0,    0,    0,    0,  224,    0,    0,    0,
			    0,    0,    0,  223,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			  221, 1063,    0,    0,  219,    0,    0,    0,    0,  218,
			   71,   70,    0,   69,  217,    0,   34,   33,   32,    0,
			    0,    0,    0,    0,    0,   67,   66,   65,   64,   63,
			   62,   61,   60,   59,   58,   57,   56,   55,   54,   53,
			   52,   51,   50,   49,   48,   47,   46,    0, 1062, 1061,
			    0,    0,   73,    0,    0,    0,    0,    0, 1239,  211,
			   44,   43,  225,    0, 1060,    0,  208,    0,    0,    0,

			    0,  207,    0, 1059,    0,    0,    0,    0,  224,    0,
			 1058,    0,    0,    0,    0,  223,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,  222,    0,    0,    0,
			    0,    0,  221,  220,    0,    0,  219,    0,    0,    0,
			    0,  218,   71,   70,    0,   69,  217,  216,   34,   33,
			   32,  215,    0,    0,    0,  214,    0,   67,   66,   65,
			   64,   63,   62,   61,   60,   59,   58,   57,   56,   55,
			   54,   53,   52,   51,   50,   49,   48,   47,   46,  213,
			  212,    0,    0,    0,   73,    0,    0,    0,    0,    0,
			 1164,  211,   44,   43,  225,  210,  209,    0,  208,    0,

			    0,    0,    0,  207,    0,    0,  206,  205,    0,    0,
			  224,    0,    0,  105,    0,    0,    0,  223,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,  222,    0,
			    0,    0,    0,    0,  221,  220,    0,    0,  219,    0,
			    0,    0,    0,  218,   71,   70,    0,   69,  217,  216,
			   34,   33,   32,  215,    0,    0,    0,  214,    0,   67,
			   66,   65,   64,   63,   62,   61,   60,   59,   58,   57,
			   56,   55,   54,   53,   52,   51,   50,   49,   48,   47,
			   46,  213,  212,    0,    0,    0,   73,    0,    0,    0,
			    0,    0,    0,  211,   44,   43,  225,  210,  209,    0, yyDummy>>,
			1, 1000, 3000)
		end

	yytable_template_5 (an_array: ARRAY [INTEGER]) is
			-- Fill chunk #5 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			  208,    0,    0,    0,    0,  207,    0,    0,  206,  205,
			    0,    0,  224,    0,    0,  105,    0,    0,    0,  223,
			    0, 1087,    0,    0,    0,    0,    0,    0,    0,    0,
			  222,    0,    0,    0,    0,    0,  221,  220,    0,    0,
			  219,    0,    0,    0,    0,  218,   71,   70,    0,   69,
			  217,  216,   34,   33,   32,  215,    0,    0,    0,  214,
			    0,   67,   66,   65,   64,   63,   62,   61,   60,   59,
			   58,   57,   56,   55,   54,   53,   52,   51,   50,   49,
			   48,   47,   46,  213,  212,    0,    0,    0,   73,    0,
			    0,    0,    0,    0,    0,  211,   44,   43,  225,  210,

			  209,    0,  208,    0,    0,    0,    0,  207,    0,    0,
			  206,  205,    0,    0,  224,    0,    0,  105,    0,    0,
			    0,  223,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,  222,    0,    0,    0,    0,    0,  221,  220,
			    0,    0,  219,    0,    0,    0,    0,  218,   71,   70,
			    0,   69,  217,  216,   34,   33,   32,  215,    0,    0,
			    0,  214,    0,   67,   66,   65,   64,   63,   62,   61,
			   60,   59,   58,   57,   56,   55,   54,   53,   52,   51,
			   50,   49,   48,   47,   46,  213,  212,    0,    0,    0,
			   73,    0,    0,    0,    0,    0,    0,  211,   44,   43,

			  225,  210,  209,    0,  208,    0,    0,    0,  928,  207,
			    0,    0,  206,  205,    0,    0,  224,    0,    0,  105,
			    0,    0,    0,  223,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,  222,    0,    0,    0,    0,    0,
			  221,  220,    0,    0,  219,    0,    0,    0,    0,  218,
			   71,   70,    0,   69,  217,  216,   34,   33,   32,  215,
			    0,    0,    0,  214,    0,   67,   66,   65,   64,   63,
			   62,   61,   60,   59,   58,   57,   56,   55,   54,   53,
			   52,   51,   50,   49,   48,   47,   46,  213,  212,    0,
			    0,    0,   73,    0,    0,    0,    0,    0,    0,  211,

			   44,   43,  225,  210,  920,    0,  208,    0,    0,    0,
			    0,  207,  736,    0,  206,  205,    0,    0,  224,    0,
			    0,  105,    0,    0,    0,  223,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,  222,    0,    0,    0,
			    0,    0,  221,  220,    0,    0,  219,    0,    0,    0,
			    0,  218,   71,   70,    0,   69,  217,  216,   34,   33,
			   32,  215,    0,    0,    0,  214,    0,   67,   66,   65,
			   64,   63,   62,   61,   60,   59,   58,   57,   56,   55,
			   54,   53,   52,   51,   50,   49,   48,   47,   46,  213,
			  212,    0,    0,    0,   73,    0,    0,    0,  751,    0,

			    0,  211,   44,   43,  225,  210,  209,    0,  208,  897,
			    0,    0,    0,  207,    0,    0,  206,  205,    0,    0,
			  224,    0,    0,  105,    0,    0,    0,  223,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,  222,    0,
			    0,    0,    0,    0,  221,  220,    0,    0,  219,    0,
			    0,    0,    0,  218,   71,   70,    0,   69,  217,  216,
			   34,   33,   32,  215,    0,    0,    0,  214,    0,   67,
			   66,   65,   64,   63,   62,   61,   60,   59,   58,   57,
			   56,   55,   54,   53,   52,   51,   50,   49,   48,   47,
			   46,  213,  212,    0,    0,    0,   73,    0,    0,    0,

			    0,    0,    0,  211,   44,   43,  225,  210,  209,    0,
			  208,    0,    0,    0,    0,  207,    0,    0,  206,  205,
			    0,    0,  224,    0,    0,  105,    0,    0,    0,  223,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			  222,    0,    0,    0,    0,    0,  221,  220,    0,    0,
			  219,  740,    0,    0,    0,  218,   71,   70,    0,   69,
			  217,  216,   34,   33,   32,  215,    0,    0,    0,  214,
			    0,   67,   66,   65,   64,   63,   62,   61,   60,   59,
			   58,   57,   56,   55,   54,   53,   52,   51,   50,   49,
			   48,   47,   46,  213,  212,    0,    0,    0,   73,    0,

			    0,    0,    0,    0,    0,  211,   44,   43,  225,  210,
			  209,    0,  208,    0,    0,    0,    0,  207,    0,    0,
			  206,  205,    0,    0,  224,    0,    0,  105,    0,    0,
			    0,  223,    0,  608,    0,    0,    0,    0,    0,    0,
			    0,    0,  222,    0,    0,    0,    0,    0,  221,  220,
			    0,    0,  219,    0,    0,    0,    0,  218,   71,   70,
			    0,   69,  217,  216,   34,   33,   32,  215,    0,    0,
			    0,  214,    0,   67,   66,   65,   64,   63,   62,   61,
			   60,   59,   58,   57,   56,   55,   54,   53,   52,   51,
			   50,   49,   48,   47,   46,  213,  212,    0,    0,    0,

			   73,    0,    0,    0,  606,    0,    0,  211,   44,   43,
			  225,  210,  209,    0,  208,    0,    0,    0,    0,  207,
			    0,    0,  206,  205,    0,    0,  224,    0,    0,  105,
			    0,    0,    0,  223,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,  222,    0,    0,    0,    0,    0,
			  221,  220,    0,    0,  219,    0,    0,    0,    0,  218,
			   71,   70,    0,   69,  217,  216,   34,   33,   32,  215,
			    0,    0,    0,  214,    0,   67,   66,   65,   64,   63,
			   62,   61,   60,   59,   58,   57,   56,   55,   54,   53,
			   52,   51,   50,   49,   48,   47,   46,  213,  212,    0,

			    0,    0,   73,    0,    0,    0,    0,    0,    0,  211,
			   44,   43,  225,  210,  209,    0,  208,    0,    0,    0,
			    0,  207,    0,    0,  206,  205,    0,    0,  224,    0,
			    0,  105,    0,    0,    0,  223,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,  222,    0,    0,    0,
			    0,    0,  221,  220,    0,    0,  219,    0,    0,    0,
			    0,  218,   71,   70,    0,   69,  217,  216,   34,   33,
			   32,  215,    0,    0,    0,  214,    0,   67,   66,   65,
			   64,   63,   62,   61,   60,   59,   58,   57,   56,   55,
			   54,   53,   52,   51,   50,   49,   48,   47,   46,  213,

			  212,    0,    0,    0,   73,    0,    0,    0,    0,    0,
			    0,  211,   44,   43,  225,  210,  209,    0,  208,    0,
			    0,    0,  414,  207,    0,    0,  206,  205,    0,    0,
			  224,    0,    0,  105,    0,    0,    0,  223,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,  222,    0,
			    0,    0,    0,    0,  221,  220,    0,    0,  219,    0,
			    0,    0,    0,  218,   71,   70,    0,   69,  217,  216,
			   34,   33,   32,  215,    0,    0,    0,  214,    0,   67,
			   66,   65,   64,   63,   62,   61,   60,   59,   58,   57,
			   56,   55,   54,   53,   52,   51,   50,   49,   48,   47, yyDummy>>,
			1, 1000, 4000)
		end

	yytable_template_6 (an_array: ARRAY [INTEGER]) is
			-- Fill chunk #6 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			   46,  213,  212,    0,    0,    0,   73,    0,    0,    0,
			    0,    0,    0,  211,   44,   43,  225,  210,  209,    0,
			  208,    0,    0,    0,    0,  207,    0,    0,  206,  205,
			    0,    0,  224,    0,    0,  105,    0,    0,    0,  223,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			  222,    0,    0,    0,    0,    0,  221,  220,    0,    0,
			  219,    0,    0,    0,    0,  218,   71,   70,    0,   69,
			  217,  216,   34,   33,   32,  215,    0,    0,    0,  214,
			    0,   67,   66,   65,   64,   63,   62,   61,   60,   59,
			   58,   57,   56,   55,   54,   53,   52,   51,   50,   49,

			   48,   47,   46,  213,  212,    0,    0,    0,    0,    0,
			 1109,    0,    0,    0,    0,  211,   44,   43,    0,  210,
			  385,    0,  208,    0,    0,    0,    0,  207,    0,    0,
			  206,  205, 1108,   71,   70,    0,   69,  105,    0,    0,
			    0,    0,   68,    0,    0,    0,    0,    0,   67,   66,
			   65,   64,   63,   62,   61,   60,   59,   58,   57,   56,
			   55,   54,   53,   52,   51,   50,   49,   48,   47,   46,
			   45,  411,    0,    0,    0,  739,  410,  409,  408,    0,
			  407,    0,    0,   44,   43,  411,    0, 1107,    0,    0,
			  410,  409,  408,    0,  407,    0,    0,   42,   41,    0,

			    0,    0,    0,    0,    0,    0,  406,  405,  404,  403,
			  402,  401,  400,  399,  398,    0,    0,    0,    0,    0,
			  406,  405,  404,  403,  402,  401,  400,  399,  398,    0,
			  395,  394,  393,  392,  391,  390,  825,    0,    0,  397,
			    0,    0,    0,    0,  395,  394,  393,  392,  391,  390,
			  411,    0,    0,    0,    0,  410,  409,  408,    0,  407,
			    0,    0,  411,    0,    0,    0,    0,  410,  409,  408,
			    0,  407,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,  406,  405,  404,  403,  402,
			  401,  400,  399,  398,    0,    0,    0,  406,  405,  404,

			  403,  402,  401,  400,  399,  398,    0,    0,    0,  395,
			  394,  393,  392,  391,  390,  669,  397,  927,    0,    0,
			    0,  395,  394,  393,  392,  391,  390,  411,    0,    0,
			    0,    0,  410,  409,  408,    0,  407,    0,  862,  861,
			  860,  859,  858,  857,  856,  855,  854,  853,  852,  851,
			  850,  849,  848,  847,  846,  845,  844,  843,  842,  841,
			    0,    0,  406,  405,  404,  403,  402,  401,  400,  399,
			  398,  411,    0,    0,    0,    0,  410,  409,  408,  896,
			  407,  397,    0,    0,    0,    0,  395,  394,  393,  392,
			  391,  390,    0,    0,    0,    0,    0,    0,    0,    0,

			    0,    0,    0,    0,    0,    0,  406,  405,  404,  403,
			  402,  401,  400,  399,  398,  411,    0,    0,    0,    0,
			  410,  409,  408,    0,  407,  397,  396,    0,    0,    0,
			  395,  394,  393,  392,  391,  390,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			  406,  405,  404,  403,  402,  401,  400,  399,  398,  411,
			    0,    0,    0,    0,  410,  409,  408,  613,  407,    0,
			    0,    0,    0,    0,  395,  394,  393,  392,  391,  390,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,  406,  405,  404,  403,  402,  401,

			  400,  399,  398,  411,    0,    0,    0,    0,  410,  409,
			  408,    0,  411,    0,    0,    0,    0,  410,  395,  394,
			  393,  392,  391,  390,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,  406,  405,
			  404,  403,  402,  401,  400,  399,  398,  406,  405,  404,
			  403,  402,  401,  400,  399,  398,  411,    0,    0,    0,
			    0,    0,  395,  394,  393,  392,  391,  390,    0,    0,
			    0,  395,  394,  393,  392,  391,  390,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,  406,  405,  404,  403,  402,  401,  400,  399,  398,

			    0,    0,    0,    0,    0,    0,    0,  -16,    0,    0,
			    0,    0,    0,    0,  -23,  395,  394,  393,  392,  391,
			  390,  -23,    0,    0,  -23,    0,    0,  -23,    0,    3,
			    0,    0,    0,  157,    0,  -20,    0,    0,    2,  -20,
			    0,    0,  -20,    0,    0,  -20,    0,    0,  -20,    0,
			    0,    0,    0,    0,    0,  -23,  -23,  -20,  -23,    0,
			  -20,  -20,  156,    0,    0,    0,  -20,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,  -20,  -20,    0,  -20,
			  559,  558,  557,  556,  555,  554,  553,  552,  551,  550,
			  549,  548,  547,  546,  545,  544,    0,    0,  543,  542,

			  541,  540,  539,  538,  537,  536,  535,  534,  533,  532,
			  531,  530,  529,  528,  527,  526,  525,  524,    0,    0,
			  523,  522,  521,  520, yyDummy>>,
			1, 724, 5000)
		end

	yycheck_template: SPECIAL [INTEGER] is
			-- Template for `yycheck'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make (0, 5723)
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
			   21,   17,  139,  312,   21,   21,   21,  561,  161,  207,
			    1,  121,  427,  153,  221,  465,  220,  587,   21,    9,
			  183,  222,  183,  221,  176,  747,  840,  179,  767, 1003,
			  702,  384, 1033, 1034,  164,  574,  345,  649,  190,  202,
			  583,  193,  194,  195,  196,  705,  276,  104,   38, 1069,
			   40,  448,  162,  174,  917,   14,  177,  205,  206,   80,
			 1297,   38,  210,   80,   80,   80,  214,  188,  216, 1353,
			  191,  427,   88,   14,   89,  273,   97,   80,   94,  369,
			   97,   97,   97,   38,  138, 1230,  442,  108,  679,   27,
			   74,  108,  108,  108,   97,   77,  112,  113,   14,  115,

			  697,  767,  699,   22,  466,  108,    4,  123,  124,  125,
			  131,  473,   31,  253,  254,  131,   14,   74,  267,   77,
			 1140,   73,  138,  105,   40,  466, 1410,  207,  281,  278,
			  120,  121,  473,   14,  153,    0,   64,   65,   36,   21,
			  197,  221,   40,   74,   75,   76,   44,  105,   14,  126,
			  493,   70,  209,  496,  138,   77,  970,  320, 1303,  175,
			  321,  322,  178,  115,  183,   17,   47,  183,  158, 1453,
			  280,  126,  623,  189,  517,  518,  192,   29,    0, 1416,
			  139,  138, 1156,  202, 1047,  128,  127,  203,  126,  326,
			   14,  207,  123,  209,   23,  138,  808,   11,   80, 1173,

			  651,  771,  130, 1177, 1224,  221,   35,  879,  130,  224,
			  132,  133,  751,  443,   14,   97,  876,  632,  633,   33,
			   28, 1035,   39,   47,  122,   14,  108,   80,  458,   17,
			 1093,   74,   75,   76,  253,  254,   28,  258,  829,   17,
			  138,   29,  258,  300,   97,   74,   75,   76,  305, 1002,
			 1003,   29,  127,  451,  993,  108,   11,  273,  274,  466,
			   48,  658, 1236,  660,  139,  662,   74,  864,   76,   17,
			 1009,  287,   14,  563,  331,  631,  566,  267,   33,  336,
			  123,   29,   74,   75,   76,   74,   75,   76,  278,  128,
			 1310,  122,  313,   74,   75,   76,  125,  313,   14,  138,

			  420,  320,  422,   77,   23,  321,  322,  138, 1122,  462,
			  430, 1125,  432,  123,  106,  519,   35,  374,  680,  449,
			  980,  683,  612,   17,   14,  346, 1300,  993,  385,  139,
			  346,  105,  389,   28,  350,   29,  488, 1200,  490,  680,
			  361,   14,  683, 1009,  125,  361,  498,  457,  500,  501,
			  502,  503, 1353,   72,   48,   74,   75,   76,  132,  133,
			   18,   12,   13,   14,  907,   15,  487,  383,  489,  385,
			  123,  962,  570,  916,   14,   15,  497, 1351,  499,   74,
			 1194,   76,   14,  726,  727,   28,  139,  106,   14,  587,
			 1129,   42,   74,   75,   76,   17,  412,  750,   14,   39,

			   74,   75,   76, 1156, 1267,  124,  976,  611,  427, 1410,
			   36,  427,  765,   71,   40,   14,   74,   75,   76,   77,
			 1173,  124,   20,  442, 1177,   23,   48,   49,    3,   51,
			  446,   74,  448,   76, 1025,  451,   17,   35,  123, 1030,
			  456,  784,  124,  786,  126,  127,  789, 1421,   29,  465,
			  466,  125, 1453,  510,  744,   14,   77,  473,   14, 1198,
			  118,    8,    9, 1129,  122, 1004, 1329,  810,  811,   14,
			  832,   18, 1042,  680,  132,  133,   74,   75,   76, 1033,
			 1034,   22,   17, 1236,  105, 1207,   74,   75,   76,  779,
			   31,  832, 1046,  127,   29, 1038,    8,    9,  696,  697,

			  698,  699,   14,  560,   28,  139,   18,   46,   47,  130,
			   22,  132,  133,   48,   26, 1378,  573,   14,  106,   31,
			  935,  936,  675,  973, 1263,  582, 1389,   14,  130, 1251,
			 1252, 1070, 1198,   28, 1256, 1257, 1258,   17,  123,   28,
			  561,  745,  127,   55,  124,  655,  126, 1300, 1087,   29,
			   74,   14,   76,   23,  570,  718,  717,  718,  574,   61,
			  576,  577,  578,  579,  674,   35,  127,  768,   48,  585,
			  733,  587,  174,  771, 1437,  177,   64,   65,  688,   74,
			  936,   76,   28, 1126,   14,   74,  188,   76, 1327,  191,
			 1002, 1003,   14, 1002, 1003,  951, 1335, 1263, 1351,   28,

			   14,  944,  945,  624,   74,   75,   76, 1022,  624,  125,
			  122,  127,  631,  127,  128,  124,  632,  633,  971,   12,
			   17,   14, 1344, 1345, 1346,  139,   14,  684,   74, 1168,
			   76,  652,   29,  649,   14,   15,  652,   74,   75,   76,
			   77,  657,  658,   14,  660,   74,  662,   76, 1387,  130,
			 1193,   48, 1374, 1375, 1376,  257,   74,   75,   76,   39,
			  780, 1327,  782,  265,  680,  805,  864,  683, 1421, 1335,
			  790,  869,  792,   26,  827,  691,   13,   28,   77,   14,
			  696,  697,  698,  699, 1037,   12,  677,   14,  106,   14,
			  127,  895,   28,   46,   47,  132,  133,  716,   14,  718,

			  716,  717,  718,   14,  122, 1259,  105,  764,    8,    9,
			  312,  269,  270,  732,  733,  731,   14, 1260,  127,  128,
			  736, 1387, 1265,   74,   14,   76,  284,  888,  130,  839,
			  139,  130,   14,  132,  133,  751,  752,   42,   74,  754,
			   76,  140,   17,  345, 1156,   14,  894, 1156,   28,    7,
			  122,  766,  124,   11,   29,  771,   14,   43,  360,   17,
			   43, 1173,   20,  130, 1173, 1177,   28,   28, 1177,  967,
			 1123,   29,   14,   48,   32,   33,   46,   28,  976,   14,
			   38,  838,   74,   75,   76,   77,  805,  126,  127, 1332,
			   48,   49,  808,   51,   74,   22,   76,  813,  814,  952,

			   27,   38, 1178, 1179,   31,  127,  128, 1183, 1184, 1185,
			  963, 1015,   74,   74,   76,   76,  832,  139,  420,  421,
			  422,  423,   14,   74, 1236,   76,   14, 1236,  430,  431,
			  432,  433,  434,  435,  436,  127,   74,   75,   76, 1192,
			  132,  133, 1195,  130, 1042,  902,  127,  128,  864,   74,
			   75,   76,   77,  869,   14,  127,  128,   28,  968, 1063,
			   74,   75,   76,  920,  880,  881,   72,  139,   74,   75,
			   76,  887,  888,  123, 1078,  891,  892,  126,  127,   72,
			  138,   74,   75,   76,  123,  487,  902,  489, 1300, 1033,
			 1034, 1300,  908,  909,   12,  497,   14,  499, 1274, 1275,

			 1276, 1210,  959,   74,  920,   76,  123,  132,  133,  139,
			  926, 1264,  125,   28,  127,  934,  122,  936,  934,  935,
			  936,  911,  912,  421, 1034,  423, 1036,  139,  125,  122,
			  127,  950,  951,  431,  130,  433,  434,  435,  436, 1351,
			 1033, 1034, 1351, 1319, 1320, 1321,   30,   31,    8,    9,
			  124,  967,  126,  128,   14,  130,   28,  973,   18,   74,
			  976,   76,   22,  418,  419,   72,   26,   74,   75,   76,
			 1027,   31,   72,   14,   74,   75,   76,  992,   14,  995,
			  996,  997,  998,  813,  814, 1000, 1002, 1003, 1004,   74,
			   75,   76,   73, 1008, 1051,   55,  123,   72, 1014,   74, yyDummy>>,
			1, 1000, 0)
		end

	yycheck_template_2 (an_array: ARRAY [INTEGER]) is
			-- Fill chunk #2 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			   75,   76,   74, 1060,   76, 1021, 1022,   14,   14, 1421,
			   28, 1148, 1421,   32, 1124,  122, 1033, 1034, 1033, 1034,
			 1141,  623,  122,  125,  130, 1046, 1042,  108,  109,   20,
			 1033, 1034,   23,  114,  115,  116,   27,  639,   14,  128,
			 1059,  130, 1246,   28,   35,   74,  124,  122,  126,  651,
			 1107,  132,  133, 1069, 1070, 1006,   74, 1209,   76,  123,
			 1011, 1012,  122,  131,  122, 1217,  124, 1219, 1220, 1221,
			 1222, 1087, 1088,  124, 1211,  126, 1066,  995,  996,  997,
			  998,  130,  138,   74,   75,   76,  130, 1208, 1292,   74,
			   11,   76,   14,  139,   16, 1216,   17, 1218,   14, 1089,

			 1157,   22,   38, 1160,   40,   14,   27, 1311,   29,   14,
			   31,   32,   33, 1128,   36,   37,   14,   38,   40,   14,
			   14, 1142,   44,   26, 1140,  130, 1142,   48,    8,    9,
			   64,   73,   64,  124,   14,  126,  127,  124,   18,   14,
			 1156,  122,   22, 1347,   14, 1349,   26,  127,  127, 1165,
			    0,   31, 1168,  123,  123, 1171,   20, 1173,   40,   23,
			 1176, 1177,  145,   27, 1154,   14,  108,  109,   57, 1159,
			  128,   35,  114,  115,  116,   55,   14,  128,  780,  781,
			  782,  783, 1197,  128, 1135, 1136,    5,  128,  790,  791,
			  792,  793,  794,  795,  796,  166,  167,  168,   36, 1403,

			  128,  128,   40,   14,  128,   16,   44,  138, 1224,  128,
			   74,   75,   76,  134, 1418,  128,  128,  138,  128, 1234,
			 1236,   36, 1238,   14,   14,   36, 1242, 1243,   18,   40,
			 1181, 1182,   22,   44,    5,   14,   26,  138, 1259, 1229,
			 1230,   31,   14,  127,  125,    7,  123, 1262,   14,   11,
			   44,  127,   14, 1457,  127,   17,  127,  240,   20,  127,
			  124,  139,  126,  127,   36,   55, 1282,   29,   40,  252,
			   32,   33,   44,  139,  128, 1291,   38,  128,   23,  127,
			   49,   50,  123,  781, 1300,  783,   48,   49,  130,   51,
			   35,  130, 1307,  791, 1310,  793,  794,  795,  796,  576,

			  577,  578,  579,  130, 1294,   74,   75,   76,  914,  130,
			  128, 1326,  918,  919,  128,  128,   14,   14,  128, 1334,
			   18, 1272, 1273,  128,   22,  128,   14,   72,   26,   74,
			   75,   76, 1348,   31,   22, 1351, 1353, 1353,   26,  128,
			  128,    7,  128,   31,  128,   11,  128, 1363,   14, 1406,
			  130,   17,   14,  138,   20,  122,  126,   55,  166,  167,
			  168,  106,  127,   29,  127,  123,   32,   33,   24,   25,
			   26, 1386,   38,  127,  123,  128,  138,  122,  125,  124,
			  123, 1371,   48,   49,  123,   51,  369, 1338, 1339,  130,
			  123,  123,  128, 1410, 1410, 1001,  127,  127,  127,  127,

			  383,  128,  128, 1419, 1010, 1421,  123,  390,  391,  392,
			  393,  394,  395,  123,   16,  398,  399,  400,  401,  402,
			  403,  404,  405,  406,  407,  408,  409,  410,  411,   14,
			   14,    3, 1383, 1384,   20,   14, 1453, 1453,  122,   28,
			  127,  123, 1048, 1049,  128,  129,   26,  128,   14,  133,
			  134,  135,  136,  137,  128,    8,  125,    5, 1479,  130,
			   49,   50,   51,   52,   53,  125, 1112,  125,  123,  153,
			  127,  123,  138,  456, 1120, 1121,  126,  128,  127, 1430,
			 1431,  126,  166,  167,  168,   74,   75,   76, 1094, 1095,
			   28, 1442, 1443,   18,  122,   14,  130,  130,  130,  183,

			  130,   28,  122,  130,   63,  124,  130,  130,   28,  130,
			  128,   49,   50,   51,   52,   53,   77,   77,  202, 1470,
			 1471, 1127,   49,   50,   51,   52,   53,  128, 1134,   49,
			   50,   51,   52,   53,   14,  123,   74,   75,   76, 1141,
			   55,   28,  131,   60,   60,   14,   60,   74,   75,   76,
			  128,  140,    7,    7,   74,   75,   76,    7,   24,  127,
			  122,  126,   49,   50,   51,   52,   53,    7,  126,  253,
			  254,  255,  256,   17, 1180,  259,  260,  261,  262,  263,
			  563,  128,   12,  566,   14,  139, 1298,   74,   75,   76,
			 1196, 1027, 1372,  131,  668, 1201, 1202,  240,  771,   76,

			  465,  869,  140,  465,  131, 1307, 1208,  563, 1210,  289,
			  709,  131,  289,  140, 1216,  121, 1218,  289,  687,  115,
			  140,  221, 1042,  606, 1270,  608,  310,  311,  121,  612,
			  977,  315,  316,  317,  318,  319,  320,  484,  286, 1361,
			  121,  159,  451,   73,  131,   28,  808,  639,   78,   79,
			   80,   28,   82,  140,  461, 1261, 1034, 1453, 1373, 1410,
			  779,  969, 1268, 1269,  904, 1271,   49,   50,   51,   52,
			   53,  744,   49,   50,   51,   52,   53,   -1,  108,  109,
			  110,  111,  112,  113,  114,  115,  116,  371,   -1,   -1,
			 1336,   74,   75,   76,   -1,   -1,   -1,   74,   75,   76,

			   -1,   -1,  132,  133,  134,  135,  136,  137,   -1,   -1,
			   -1,   -1,   12,   13,   14,   15,   -1,   -1,   -1, 1325,
			   -1,   -1,   -1,   -1, 1330, 1331,   26, 1333,   -1,   -1,
			   -1, 1337,   -1,   -1,   -1, 1381,   -1,   -1,   -1,   39,
			   -1,   -1,   42,  427,   -1,   -1,   46,   47,  131,   -1,
			 1396, 1397, 1398,   -1,  131,   -1,   -1,  140,  442,   -1,
			   -1,  744,   -1,  140,   -1,   -1,  749,   28,   -1,  752,
			   -1,   -1,   -1, 1379, 1380,   -1, 1382,   -1,   -1, 1385,
			   -1,   -1, 1428,   -1, 1390, 1391,   -1,   -1,   49,   50,
			   51,   52,   53,   -1, 1440,   -1,  779,   -1, 1444, 1445,

			 1446,   -1,   -1,   -1,   -1,    8,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   74,   75,   76,   -1,   -1,   -1, 1465,
			 1466, 1467, 1468, 1429,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1, 1438, 1439,   -1, 1441, 1482, 1483, 1484,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1, 1492, 1493, 1494,   -1,
			   -1,   -1, 1498, 1499, 1500,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1, 1469,   67,   68,   69,   -1,   71,   -1,
			  131,   74,   75,   76,   77,   -1,   -1,   -1,   -1,  140,
			   83,   84,   85,   86,   87,   88,   89,   90,   91,   92,
			   93,   94,   95,   96,   97,   98,   99,  100,  101,  102,

			  103,  104,  105,   -1,    8,    9,   -1,   -1,   -1,   -1,
			   14,   -1,   -1,   -1,   18,  118,  119,   -1,   22,   -1,
			   -1,  904,   26,   -1,   -1,  908,   -1,   31,   -1,  132,
			  133,   -1,   -1,   -1,   -1,   -1,   -1,  621,  622,   -1,
			   -1,   -1,  626,  627,  628,  629,  630,  631,   -1,    8,
			    9,   55,   -1,   -1,   -1,   14,   -1,   -1,   -1,   18,
			   -1,   -1,   -1,   22,   -1,   -1,   -1,   26,   -1,   -1,
			   -1,   -1,   31,   -1,   -1,    6,   -1,    8,   -1,   10,
			   -1,   12,   13,   14,   15,   -1,   -1,   18,   19,   -1,
			   21,   -1,   -1,   -1,   25,   26,   55,   -1,   -1,   -1, yyDummy>>,
			1, 1000, 1000)
		end

	yycheck_template_3 (an_array: ARRAY [INTEGER]) is
			-- Fill chunk #3 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			   -1,   -1,   -1,   34,   -1,   -1,   -1,   -1,   39,   -1,
			   41,   42,   -1,   -1,   -1,   46,   47,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   58,   59,   -1,
			   -1,   62,  716,   64,  718,   -1,   67,   68,   69,   -1,
			   71,   72,   -1,   74,   75,   76,   -1,   -1,  732,  733,
			   -1,   -1,   83,   84,   85,   86,   87,   88,   89,   90,
			   91,   92,   93,   94,   95,   96,   97,   98,   99,  100,
			  101,  102,  103,  104,   -1,  106,  107,   -1,   -1,   -1,
			   -1, 1064, 1065,   -1,   -1,   -1,  117,  118,  119,   -1,
			   22,  122,   -1,  124,   -1,   -1,   -1,   -1,  129,   31,

			  131,   -1,    7,   -1,   -1, 1088,   11,  138,  139,   14,
			   -1,   -1,   17,   45,   -1,   20,   -1,   -1,   -1,   -1,
			   -1,  805,   -1,   -1,   29,   -1,   -1,   32,   33,   -1,
			   -1,   -1,   -1,   38,   -1,   67,   68,   69,   -1,   71,
			   -1,   -1,   -1,   48,   49,   77,   51,   -1,   -1,   -1,
			   -1,   83,   84,   85,   86,   87,   88,   89,   90,   91,
			   92,   93,   94,   95,   96,   97,   98,   99,  100,  101,
			  102,  103,  104,  105,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1, 1165, 1166, 1167,   -1,  118,  119,   -1,   -1,
			  122, 1174, 1175, 1176,   -1,   -1,   -1,   -1,   -1,   -1,

			  132,  133,   -1,   83,   84,   85,   86,   87,   88,   89,
			   90,   91,   92,   93,   94,   95,   96,   97,   98,   99,
			  100,  101,  102,  103,  104,   -1,   -1,   -1,   -1,    6,
			   -1,    8,   -1,   10,   -1,   12,   13,   14,   15,  119,
			   -1,   18,   19,   -1,   21,   -1,   -1,   -1,   25,   26,
			  934,   -1,  936,   -1,   -1,   -1,   -1,   34,   -1, 1242,
			 1243, 1244,   39,   -1,   41,   42,  950,  951,   -1,   46,
			   47,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   58,   59,   -1,   -1,   62,   -1,   -1,   -1,   -1,
			   67,   68,   69,   -1,   71,   72,   -1,   74,   75,   76,

			   -1,   -1,   -1,   -1,   -1,   -1,   83,   84,   85,   86,
			   87,   88,   89,   90,   91,   92,   93,   94,   95,   96,
			   97,   98,   99,  100,  101,  102,  103,  104,   -1,  106,
			  107,   30, 1315,   43,   -1,   -1,   -1,   -1,   -1,   -1,
			  117,  118,  119,   -1,   -1,  122,   -1,  124,   -1,   -1,
			   -1,   -1,  129,  130,  131,   -1,   -1,   -1,   -1,   -1,
			   -1,  138,  139,   73,   -1,   -1,   -1,   -1,   78,   79,
			   80,   -1,   82,   -1,   73, 1059,   -1, 1360,   -1,   78,
			   79,   80,   -1,   82,   -1,   -1,   -1, 1370,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  108,  109,

			  110,  111,  112,  113,  114,  115,  116,   -1,   -1,  108,
			  109,  110,  111,  112,  113,  114,  115,  116,   -1,   -1,
			   -1,   -1,  132,  133,  134,  135,  136,  137,   -1,   -1,
			   -1,   -1,   -1,  132,  133,  134,  135,  136,  137,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1, 1139, 1140,   -1,   -1, 1143,
			 1144, 1145, 1146, 1147,    5,    6,   -1,    8, 1152,   10,
			   11,   12,   13,   14,   15,   -1,   17,   18,   19,   -1,
			   21,   22,   -1,   -1,   25,   26,   -1,   -1,   29,   30,
			   31,   -1,   33,   34,   -1,   -1,   -1,   -1,   39,   -1,

			   41,   42,   43,   -1,   -1,   46,   47,   48,   -1,   -1,
			   -1,   52,   -1,   -1,   -1,   -1,   -1,   58,   59,   -1,
			   -1,   62,   63,   -1,   -1,   -1,   67,   68,   69,   -1,
			   71,   72,   73,   74,   75,   76,   77,   78,   79,   80,
			   81,   82,   83,   84,   85,   86,   87,   88,   89,   90,
			   91,   92,   93,   94,   95,   96,   97,   98,   99,  100,
			  101,  102,  103,  104,  105,  106,  107,  108,  109,  110,
			  111,  112,  113,  114,  115,  116,  117,  118,  119,   -1,
			  121,  122,   -1,  124,  125,   -1,  127,  128,  129,   -1,
			  131,  132,  133,  134,  135,  136,  137,  138,  139,    5,

			    6,   -1,    8,   -1,   10,   11,   12,   13,   14,   15,
			   -1,   17,   18,   19,   -1,   21,   22,   -1,   -1,   25,
			   26,   -1,   -1,   29,   30,   31,   -1,   33,   34,   -1,
			   -1,   -1,   -1,   39,   -1,   41,   42,   43,   -1,   -1,
			   46,   47,   48,   -1,   -1,   -1,   52,   -1,   -1,   -1,
			   -1,   -1,   58,   59,   -1,   -1,   62,   63,   -1,   -1,
			   -1,   67,   68,   69,   -1,   71,   72,   73,   74,   75,
			   76,   77,   78,   79,   80,   81,   82,   83,   84,   85,
			   86,   87,   88,   89,   90,   91,   92,   93,   94,   95,
			   96,   97,   98,   99,  100,  101,  102,  103,  104,  105,

			  106,  107,  108,  109,  110,  111,  112,  113,  114,  115,
			  116,  117,  118,  119,   -1,  121,  122,   -1,  124,  125,
			   -1,  127,  128,  129,   -1,  131,  132,  133,  134,  135,
			  136,  137,  138,  139,    5,    6,   -1,    8,   -1,   10,
			   11,   12,   13,   14,   15,   -1,   17,   18,   19,   -1,
			   21,   22,   -1,   -1,   25,   26,   -1,   -1,   29,   30,
			   31,   -1,   33,   34,   -1,   -1,   -1,   -1,   39,   -1,
			   41,   42,   43,   -1,   -1,   46,   47,   48,   -1,   -1,
			   -1,   52,   -1,   -1,   -1,   -1,   -1,   58,   59,   -1,
			   -1,   62,   63,   -1,   -1,   -1,   67,   68,   69,   -1,

			   71,   72,   73,   74,   75,   76,   77,   78,   79,   80,
			   81,   82,   83,   84,   85,   86,   87,   88,   89,   90,
			   91,   92,   93,   94,   95,   96,   97,   98,   99,  100,
			  101,  102,  103,  104,  105,  106,  107,  108,  109,  110,
			  111,  112,  113,  114,  115,  116,  117,  118,  119,   -1,
			  121,  122,   -1,  124,  125,   -1,  127,  128,  129,   -1,
			  131,  132,  133,  134,  135,  136,  137,  138,  139,    6,
			   -1,    8,   -1,   10,   -1,   12,   13,   14,   15,   -1,
			   -1,   18,   19,   -1,   21,   -1,   -1,   -1,   25,   26,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   34,   -1,   -1,

			   -1,   -1,   39,   -1,   41,   42,   -1,   -1,   -1,   46,
			   47,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   58,   59,   -1,   -1,   62,   -1,   -1,   -1,   -1,
			   67,   68,   69,   -1,   71,   72,   -1,   74,   75,   76,
			   -1,   -1,   -1,   -1,   -1,   -1,   83,   84,   85,   86,
			   87,   88,   89,   90,   91,   92,   93,   94,   95,   96,
			   97,   98,   99,  100,  101,  102,  103,  104,   -1,  106,
			  107,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			  117,  118,  119,   -1,   -1,  122,   -1,  124,   -1,   -1,
			   -1,    6,  129,    8,  131,   10,   -1,   12,   13,   14, yyDummy>>,
			1, 1000, 2000)
		end

	yycheck_template_4 (an_array: ARRAY [INTEGER]) is
			-- Fill chunk #4 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			   15,  138,  139,   18,   19,   -1,   21,   -1,   -1,   -1,
			   25,   26,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   34,
			   -1,   -1,   -1,   -1,   39,   -1,   41,   42,   -1,   -1,
			   -1,   46,   47,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   58,   59,   -1,   -1,   62,   -1,   -1,
			   -1,   -1,   67,   68,   69,   -1,   71,   72,   -1,   74,
			   75,   76,   -1,   -1,   -1,   -1,   -1,   -1,   83,   84,
			   85,   86,   87,   88,   89,   90,   91,   92,   93,   94,
			   95,   96,   97,   98,   99,  100,  101,  102,  103,  104,
			   -1,  106,  107,   -1,   -1,   -1,   -1,   -1,   -1,   -1,

			   -1,   -1,  117,  118,  119,   -1,   -1,  122,   -1,  124,
			   -1,   -1,   -1,    6,  129,    8,  131,   10,   -1,   12,
			   13,   14,   15,  138,   -1,   18,   19,   -1,   21,   -1,
			   -1,   -1,   25,   26,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   34,   -1,   -1,   -1,   -1,   39,   -1,   41,   42,
			   -1,   -1,   -1,   46,   47,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   58,   59,   -1,   -1,   62,
			   -1,   -1,   -1,   -1,   67,   68,   69,   -1,   71,   72,
			   -1,   74,   75,   76,   -1,   -1,   -1,   -1,   -1,   -1,
			   83,   84,   85,   86,   87,   88,   89,   90,   91,   92,

			   93,   94,   95,   96,   97,   98,   99,  100,  101,  102,
			  103,  104,   -1,  106,  107,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,  117,  118,  119,   -1,   -1,  122,
			   -1,  124,   -1,   -1,   -1,    6,  129,    8,  131,   10,
			   -1,   12,   13,   14,   15,  138,   -1,   18,   19,   -1,
			   21,   -1,   -1,   -1,   25,   26,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   34,   -1,   -1,   -1,   -1,   39,   -1,
			   41,   42,   -1,   -1,   -1,   46,   47,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   58,   59,   -1,
			   -1,   62,   -1,   -1,   -1,   -1,   67,   68,   69,   -1,

			   71,   72,   -1,   74,   75,   76,   -1,   -1,   -1,   -1,
			   -1,   -1,   83,   84,   85,   86,   87,   88,   89,   90,
			   91,   92,   93,   94,   95,   96,   97,   98,   99,  100,
			  101,  102,  103,  104,   -1,  106,  107,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,  117,  118,  119,   -1,
			   -1,  122,   -1,  124,   -1,   -1,   -1,    6,  129,    8,
			  131,   10,   -1,   12,   13,   14,   15,  138,   -1,   18,
			   19,   -1,   21,   -1,   -1,   -1,   25,   26,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   34,   -1,   -1,   -1,   -1,
			   39,   -1,   41,   42,   -1,   -1,   -1,   46,   47,   -1,

			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   58,
			   59,   -1,   -1,   62,   -1,   -1,   -1,   -1,   67,   68,
			   69,   -1,   71,   72,   -1,   74,   75,   76,   -1,   -1,
			   -1,   -1,   -1,   -1,   83,   84,   85,   86,   87,   88,
			   89,   90,   91,   92,   93,   94,   95,   96,   97,   98,
			   99,  100,  101,  102,  103,  104,   -1,  106,  107,   -1,
			   -1,    8,   -1,   -1,   -1,   -1,   -1,   -1,  117,  118,
			  119,   18,   -1,  122,   -1,  124,   -1,   -1,   -1,   -1,
			  129,   -1,  131,   -1,   -1,   -1,   -1,   34,   -1,  138,
			   -1,   -1,   -1,   -1,   41,   -1,   -1,   -1,   -1,   -1,

			   -1,   -1,   -1,   -1,   -1,   52,   -1,   -1,   -1,   -1,
			   -1,   58,   59,   -1,   -1,   62,   -1,   -1,   -1,   -1,
			   67,   68,   69,   -1,   71,   72,   73,   74,   75,   76,
			   77,   -1,   -1,   -1,   81,   -1,   83,   84,   85,   86,
			   87,   88,   89,   90,   91,   92,   93,   94,   95,   96,
			   97,   98,   99,  100,  101,  102,  103,  104,  105,  106,
			   -1,   -1,   -1,    8,   -1,   -1,   -1,   -1,   -1,   -1,
			  117,  118,  119,   18,  121,  122,   -1,  124,  125,   -1,
			   -1,   -1,  129,   -1,   -1,  132,  133,   -1,   -1,   34,
			   -1,   -1,  139,  140,   -1,   -1,   41,   -1,   -1,   -1,

			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   52,   -1,   -1,
			   -1,   -1,   -1,   58,   59,   -1,   -1,   62,   -1,   -1,
			   -1,   -1,   67,   68,   69,   -1,   71,   72,   73,   74,
			   75,   76,   77,   -1,   -1,   -1,   81,   -1,   83,   84,
			   85,   86,   87,   88,   89,   90,   91,   92,   93,   94,
			   95,   96,   97,   98,   99,  100,  101,  102,  103,  104,
			  105,  106,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,  117,  118,  119,   -1,  121,  122,    6,  124,
			    8,   -1,   10,   -1,  129,   -1,   -1,  132,  133,   -1,
			   18,   19,   -1,   21,  139,  140,   -1,   25,   -1,   -1,

			   -1,   -1,   -1,   -1,   -1,   -1,   34,   -1,   -1,   -1,
			   -1,   -1,   -1,   41,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   58,   59,   -1,   -1,   62,   -1,   -1,   -1,   -1,   67,
			   68,   69,   -1,   71,   72,   -1,   74,   75,   76,   -1,
			   -1,   -1,   -1,   -1,   -1,   83,   84,   85,   86,   87,
			   88,   89,   90,   91,   92,   93,   94,   95,   96,   97,
			   98,   99,  100,  101,  102,  103,  104,   -1,  106,  107,
			   -1,   -1,    8,   -1,   -1,   -1,   -1,   -1,   14,  117,
			  118,  119,   18,   -1,  122,   -1,  124,   -1,   -1,   -1,

			   -1,  129,   -1,  131,   -1,   -1,   -1,   -1,   34,   -1,
			  138,   -1,   -1,   -1,   -1,   41,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   52,   -1,   -1,   -1,
			   -1,   -1,   58,   59,   -1,   -1,   62,   -1,   -1,   -1,
			   -1,   67,   68,   69,   -1,   71,   72,   73,   74,   75,
			   76,   77,   -1,   -1,   -1,   81,   -1,   83,   84,   85,
			   86,   87,   88,   89,   90,   91,   92,   93,   94,   95,
			   96,   97,   98,   99,  100,  101,  102,  103,  104,  105,
			  106,   -1,   -1,   -1,    8,   -1,   -1,   -1,   -1,   -1,
			   14,  117,  118,  119,   18,  121,  122,   -1,  124,   -1,

			   -1,   -1,   -1,  129,   -1,   -1,  132,  133,   -1,   -1,
			   34,   -1,   -1,  139,   -1,   -1,   -1,   41,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   52,   -1,
			   -1,   -1,   -1,   -1,   58,   59,   -1,   -1,   62,   -1,
			   -1,   -1,   -1,   67,   68,   69,   -1,   71,   72,   73,
			   74,   75,   76,   77,   -1,   -1,   -1,   81,   -1,   83,
			   84,   85,   86,   87,   88,   89,   90,   91,   92,   93,
			   94,   95,   96,   97,   98,   99,  100,  101,  102,  103,
			  104,  105,  106,   -1,   -1,   -1,    8,   -1,   -1,   -1,
			   -1,   -1,   -1,  117,  118,  119,   18,  121,  122,   -1, yyDummy>>,
			1, 1000, 3000)
		end

	yycheck_template_5 (an_array: ARRAY [INTEGER]) is
			-- Fill chunk #5 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			  124,   -1,   -1,   -1,   -1,  129,   -1,   -1,  132,  133,
			   -1,   -1,   34,   -1,   -1,  139,   -1,   -1,   -1,   41,
			   -1,   43,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   52,   -1,   -1,   -1,   -1,   -1,   58,   59,   -1,   -1,
			   62,   -1,   -1,   -1,   -1,   67,   68,   69,   -1,   71,
			   72,   73,   74,   75,   76,   77,   -1,   -1,   -1,   81,
			   -1,   83,   84,   85,   86,   87,   88,   89,   90,   91,
			   92,   93,   94,   95,   96,   97,   98,   99,  100,  101,
			  102,  103,  104,  105,  106,   -1,   -1,   -1,    8,   -1,
			   -1,   -1,   -1,   -1,   -1,  117,  118,  119,   18,  121,

			  122,   -1,  124,   -1,   -1,   -1,   -1,  129,   -1,   -1,
			  132,  133,   -1,   -1,   34,   -1,   -1,  139,   -1,   -1,
			   -1,   41,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   52,   -1,   -1,   -1,   -1,   -1,   58,   59,
			   -1,   -1,   62,   -1,   -1,   -1,   -1,   67,   68,   69,
			   -1,   71,   72,   73,   74,   75,   76,   77,   -1,   -1,
			   -1,   81,   -1,   83,   84,   85,   86,   87,   88,   89,
			   90,   91,   92,   93,   94,   95,   96,   97,   98,   99,
			  100,  101,  102,  103,  104,  105,  106,   -1,   -1,   -1,
			    8,   -1,   -1,   -1,   -1,   -1,   -1,  117,  118,  119,

			   18,  121,  122,   -1,  124,   -1,   -1,   -1,  128,  129,
			   -1,   -1,  132,  133,   -1,   -1,   34,   -1,   -1,  139,
			   -1,   -1,   -1,   41,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   52,   -1,   -1,   -1,   -1,   -1,
			   58,   59,   -1,   -1,   62,   -1,   -1,   -1,   -1,   67,
			   68,   69,   -1,   71,   72,   73,   74,   75,   76,   77,
			   -1,   -1,   -1,   81,   -1,   83,   84,   85,   86,   87,
			   88,   89,   90,   91,   92,   93,   94,   95,   96,   97,
			   98,   99,  100,  101,  102,  103,  104,  105,  106,   -1,
			   -1,   -1,    8,   -1,   -1,   -1,   -1,   -1,   -1,  117,

			  118,  119,   18,  121,  122,   -1,  124,   -1,   -1,   -1,
			   -1,  129,  130,   -1,  132,  133,   -1,   -1,   34,   -1,
			   -1,  139,   -1,   -1,   -1,   41,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   52,   -1,   -1,   -1,
			   -1,   -1,   58,   59,   -1,   -1,   62,   -1,   -1,   -1,
			   -1,   67,   68,   69,   -1,   71,   72,   73,   74,   75,
			   76,   77,   -1,   -1,   -1,   81,   -1,   83,   84,   85,
			   86,   87,   88,   89,   90,   91,   92,   93,   94,   95,
			   96,   97,   98,   99,  100,  101,  102,  103,  104,  105,
			  106,   -1,   -1,   -1,    8,   -1,   -1,   -1,   12,   -1,

			   -1,  117,  118,  119,   18,  121,  122,   -1,  124,  125,
			   -1,   -1,   -1,  129,   -1,   -1,  132,  133,   -1,   -1,
			   34,   -1,   -1,  139,   -1,   -1,   -1,   41,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   52,   -1,
			   -1,   -1,   -1,   -1,   58,   59,   -1,   -1,   62,   -1,
			   -1,   -1,   -1,   67,   68,   69,   -1,   71,   72,   73,
			   74,   75,   76,   77,   -1,   -1,   -1,   81,   -1,   83,
			   84,   85,   86,   87,   88,   89,   90,   91,   92,   93,
			   94,   95,   96,   97,   98,   99,  100,  101,  102,  103,
			  104,  105,  106,   -1,   -1,   -1,    8,   -1,   -1,   -1,

			   -1,   -1,   -1,  117,  118,  119,   18,  121,  122,   -1,
			  124,   -1,   -1,   -1,   -1,  129,   -1,   -1,  132,  133,
			   -1,   -1,   34,   -1,   -1,  139,   -1,   -1,   -1,   41,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   52,   -1,   -1,   -1,   -1,   -1,   58,   59,   -1,   -1,
			   62,   63,   -1,   -1,   -1,   67,   68,   69,   -1,   71,
			   72,   73,   74,   75,   76,   77,   -1,   -1,   -1,   81,
			   -1,   83,   84,   85,   86,   87,   88,   89,   90,   91,
			   92,   93,   94,   95,   96,   97,   98,   99,  100,  101,
			  102,  103,  104,  105,  106,   -1,   -1,   -1,    8,   -1,

			   -1,   -1,   -1,   -1,   -1,  117,  118,  119,   18,  121,
			  122,   -1,  124,   -1,   -1,   -1,   -1,  129,   -1,   -1,
			  132,  133,   -1,   -1,   34,   -1,   -1,  139,   -1,   -1,
			   -1,   41,   -1,   43,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   52,   -1,   -1,   -1,   -1,   -1,   58,   59,
			   -1,   -1,   62,   -1,   -1,   -1,   -1,   67,   68,   69,
			   -1,   71,   72,   73,   74,   75,   76,   77,   -1,   -1,
			   -1,   81,   -1,   83,   84,   85,   86,   87,   88,   89,
			   90,   91,   92,   93,   94,   95,   96,   97,   98,   99,
			  100,  101,  102,  103,  104,  105,  106,   -1,   -1,   -1,

			    8,   -1,   -1,   -1,   12,   -1,   -1,  117,  118,  119,
			   18,  121,  122,   -1,  124,   -1,   -1,   -1,   -1,  129,
			   -1,   -1,  132,  133,   -1,   -1,   34,   -1,   -1,  139,
			   -1,   -1,   -1,   41,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   52,   -1,   -1,   -1,   -1,   -1,
			   58,   59,   -1,   -1,   62,   -1,   -1,   -1,   -1,   67,
			   68,   69,   -1,   71,   72,   73,   74,   75,   76,   77,
			   -1,   -1,   -1,   81,   -1,   83,   84,   85,   86,   87,
			   88,   89,   90,   91,   92,   93,   94,   95,   96,   97,
			   98,   99,  100,  101,  102,  103,  104,  105,  106,   -1,

			   -1,   -1,    8,   -1,   -1,   -1,   -1,   -1,   -1,  117,
			  118,  119,   18,  121,  122,   -1,  124,   -1,   -1,   -1,
			   -1,  129,   -1,   -1,  132,  133,   -1,   -1,   34,   -1,
			   -1,  139,   -1,   -1,   -1,   41,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   52,   -1,   -1,   -1,
			   -1,   -1,   58,   59,   -1,   -1,   62,   -1,   -1,   -1,
			   -1,   67,   68,   69,   -1,   71,   72,   73,   74,   75,
			   76,   77,   -1,   -1,   -1,   81,   -1,   83,   84,   85,
			   86,   87,   88,   89,   90,   91,   92,   93,   94,   95,
			   96,   97,   98,   99,  100,  101,  102,  103,  104,  105,

			  106,   -1,   -1,   -1,    8,   -1,   -1,   -1,   -1,   -1,
			   -1,  117,  118,  119,   18,  121,  122,   -1,  124,   -1,
			   -1,   -1,  128,  129,   -1,   -1,  132,  133,   -1,   -1,
			   34,   -1,   -1,  139,   -1,   -1,   -1,   41,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   52,   -1,
			   -1,   -1,   -1,   -1,   58,   59,   -1,   -1,   62,   -1,
			   -1,   -1,   -1,   67,   68,   69,   -1,   71,   72,   73,
			   74,   75,   76,   77,   -1,   -1,   -1,   81,   -1,   83,
			   84,   85,   86,   87,   88,   89,   90,   91,   92,   93,
			   94,   95,   96,   97,   98,   99,  100,  101,  102,  103, yyDummy>>,
			1, 1000, 4000)
		end

	yycheck_template_6 (an_array: ARRAY [INTEGER]) is
			-- Fill chunk #6 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			  104,  105,  106,   -1,   -1,   -1,    8,   -1,   -1,   -1,
			   -1,   -1,   -1,  117,  118,  119,   18,  121,  122,   -1,
			  124,   -1,   -1,   -1,   -1,  129,   -1,   -1,  132,  133,
			   -1,   -1,   34,   -1,   -1,  139,   -1,   -1,   -1,   41,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   52,   -1,   -1,   -1,   -1,   -1,   58,   59,   -1,   -1,
			   62,   -1,   -1,   -1,   -1,   67,   68,   69,   -1,   71,
			   72,   73,   74,   75,   76,   77,   -1,   -1,   -1,   81,
			   -1,   83,   84,   85,   86,   87,   88,   89,   90,   91,
			   92,   93,   94,   95,   96,   97,   98,   99,  100,  101,

			  102,  103,  104,  105,  106,   -1,   -1,   -1,   -1,   -1,
			   45,   -1,   -1,   -1,   -1,  117,  118,  119,   -1,  121,
			  122,   -1,  124,   -1,   -1,   -1,   -1,  129,   -1,   -1,
			  132,  133,   67,   68,   69,   -1,   71,  139,   -1,   -1,
			   -1,   -1,   77,   -1,   -1,   -1,   -1,   -1,   83,   84,
			   85,   86,   87,   88,   89,   90,   91,   92,   93,   94,
			   95,   96,   97,   98,   99,  100,  101,  102,  103,  104,
			  105,   73,   -1,   -1,   -1,   63,   78,   79,   80,   -1,
			   82,   -1,   -1,  118,  119,   73,   -1,  122,   -1,   -1,
			   78,   79,   80,   -1,   82,   -1,   -1,  132,  133,   -1,

			   -1,   -1,   -1,   -1,   -1,   -1,  108,  109,  110,  111,
			  112,  113,  114,  115,  116,   -1,   -1,   -1,   -1,   -1,
			  108,  109,  110,  111,  112,  113,  114,  115,  116,   -1,
			  132,  133,  134,  135,  136,  137,  138,   -1,   -1,  127,
			   -1,   -1,   -1,   -1,  132,  133,  134,  135,  136,  137,
			   73,   -1,   -1,   -1,   -1,   78,   79,   80,   -1,   82,
			   -1,   -1,   73,   -1,   -1,   -1,   -1,   78,   79,   80,
			   -1,   82,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,  108,  109,  110,  111,  112,
			  113,  114,  115,  116,   -1,   -1,   -1,  108,  109,  110,

			  111,  112,  113,  114,  115,  116,   -1,   -1,   -1,  132,
			  133,  134,  135,  136,  137,  138,  127,  128,   -1,   -1,
			   -1,  132,  133,  134,  135,  136,  137,   73,   -1,   -1,
			   -1,   -1,   78,   79,   80,   -1,   82,   -1,   83,   84,
			   85,   86,   87,   88,   89,   90,   91,   92,   93,   94,
			   95,   96,   97,   98,   99,  100,  101,  102,  103,  104,
			   -1,   -1,  108,  109,  110,  111,  112,  113,  114,  115,
			  116,   73,   -1,   -1,   -1,   -1,   78,   79,   80,  125,
			   82,  127,   -1,   -1,   -1,   -1,  132,  133,  134,  135,
			  136,  137,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,

			   -1,   -1,   -1,   -1,   -1,   -1,  108,  109,  110,  111,
			  112,  113,  114,  115,  116,   73,   -1,   -1,   -1,   -1,
			   78,   79,   80,   -1,   82,  127,  128,   -1,   -1,   -1,
			  132,  133,  134,  135,  136,  137,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			  108,  109,  110,  111,  112,  113,  114,  115,  116,   73,
			   -1,   -1,   -1,   -1,   78,   79,   80,  125,   82,   -1,
			   -1,   -1,   -1,   -1,  132,  133,  134,  135,  136,  137,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,  108,  109,  110,  111,  112,  113,

			  114,  115,  116,   73,   -1,   -1,   -1,   -1,   78,   79,
			   80,   -1,   73,   -1,   -1,   -1,   -1,   78,  132,  133,
			  134,  135,  136,  137,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  108,  109,
			  110,  111,  112,  113,  114,  115,  116,  108,  109,  110,
			  111,  112,  113,  114,  115,  116,   73,   -1,   -1,   -1,
			   -1,   -1,  132,  133,  134,  135,  136,  137,   -1,   -1,
			   -1,  132,  133,  134,  135,  136,  137,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,  108,  109,  110,  111,  112,  113,  114,  115,  116,

			   -1,   -1,   -1,   -1,   -1,   -1,   -1,    0,   -1,   -1,
			   -1,   -1,   -1,   -1,    7,  132,  133,  134,  135,  136,
			  137,   14,   -1,   -1,   17,   -1,   -1,   20,   -1,   22,
			   -1,   -1,   -1,   26,   -1,    7,   -1,   -1,   31,   11,
			   -1,   -1,   14,   -1,   -1,   17,   -1,   -1,   20,   -1,
			   -1,   -1,   -1,   -1,   -1,   48,   49,   29,   51,   -1,
			   32,   33,   55,   -1,   -1,   -1,   38,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   48,   49,   -1,   51,
			   83,   84,   85,   86,   87,   88,   89,   90,   91,   92,
			   93,   94,   95,   96,   97,   98,   -1,   -1,  101,  102,

			  103,  104,   83,   84,   85,   86,   87,   88,   89,   90,
			   91,   92,   93,   94,   95,   96,   97,   98,   -1,   -1,
			  101,  102,  103,  104, yyDummy>>,
			1, 724, 5000)
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

	yyFinal: INTEGER is 1509
			-- Termination state id

	yyFlag: INTEGER is -32768
			-- Most negative INTEGER

	yyNtbase: INTEGER is 141
			-- Number of tokens

	yyLast: INTEGER is 5723
			-- Upper bound of `yytable' and `yycheck'

	yyMax_token: INTEGER is 373
			-- Maximum token id
			-- (upper bound of `yytranslate'.)

	yyNsyms: INTEGER is 395
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
