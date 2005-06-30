indexing

	description: "Eiffel parsers"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class EIFFEL_PARSER

inherit

	EIFFEL_PARSER_SKELETON

	SHARED_NAMES_HEAP

create
	make,
	make_with_factory

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
				yyvs2.put (last_id_as_value, yyvsp2)
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
				yyvs3.put (last_location_as_value, yyvsp3)
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
				yyvs4.put (last_bool_as_value, yyvsp4)
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
				yyvs5.put (last_current_as_value, yyvsp5)
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
				yyvs6.put (last_deferred_as_value, yyvsp6)
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
				yyvs7.put (last_result_as_value, yyvsp7)
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
				yyvs8.put (last_retry_as_value, yyvsp8)
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
				yyvs9.put (last_unique_as_value, yyvsp9)
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
				yyvs10.put (last_void_as_value, yyvsp10)
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
					--|#line <not available> "eiffel.y"
				yy_do_action_1
			when 2 then
					--|#line <not available> "eiffel.y"
				yy_do_action_2
			when 3 then
					--|#line <not available> "eiffel.y"
				yy_do_action_3
			when 4 then
					--|#line <not available> "eiffel.y"
				yy_do_action_4
			when 5 then
					--|#line <not available> "eiffel.y"
				yy_do_action_5
			when 6 then
					--|#line <not available> "eiffel.y"
				yy_do_action_6
			when 7 then
					--|#line <not available> "eiffel.y"
				yy_do_action_7
			when 8 then
					--|#line <not available> "eiffel.y"
				yy_do_action_8
			when 9 then
					--|#line <not available> "eiffel.y"
				yy_do_action_9
			when 10 then
					--|#line <not available> "eiffel.y"
				yy_do_action_10
			when 11 then
					--|#line <not available> "eiffel.y"
				yy_do_action_11
			when 12 then
					--|#line <not available> "eiffel.y"
				yy_do_action_12
			when 13 then
					--|#line <not available> "eiffel.y"
				yy_do_action_13
			when 14 then
					--|#line <not available> "eiffel.y"
				yy_do_action_14
			when 15 then
					--|#line <not available> "eiffel.y"
				yy_do_action_15
			when 16 then
					--|#line <not available> "eiffel.y"
				yy_do_action_16
			when 17 then
					--|#line <not available> "eiffel.y"
				yy_do_action_17
			when 18 then
					--|#line <not available> "eiffel.y"
				yy_do_action_18
			when 19 then
					--|#line <not available> "eiffel.y"
				yy_do_action_19
			when 20 then
					--|#line <not available> "eiffel.y"
				yy_do_action_20
			when 21 then
					--|#line <not available> "eiffel.y"
				yy_do_action_21
			when 22 then
					--|#line <not available> "eiffel.y"
				yy_do_action_22
			when 23 then
					--|#line <not available> "eiffel.y"
				yy_do_action_23
			when 24 then
					--|#line <not available> "eiffel.y"
				yy_do_action_24
			when 25 then
					--|#line <not available> "eiffel.y"
				yy_do_action_25
			when 26 then
					--|#line <not available> "eiffel.y"
				yy_do_action_26
			when 27 then
					--|#line <not available> "eiffel.y"
				yy_do_action_27
			when 28 then
					--|#line <not available> "eiffel.y"
				yy_do_action_28
			when 29 then
					--|#line <not available> "eiffel.y"
				yy_do_action_29
			when 30 then
					--|#line <not available> "eiffel.y"
				yy_do_action_30
			when 31 then
					--|#line <not available> "eiffel.y"
				yy_do_action_31
			when 32 then
					--|#line <not available> "eiffel.y"
				yy_do_action_32
			when 33 then
					--|#line <not available> "eiffel.y"
				yy_do_action_33
			when 34 then
					--|#line <not available> "eiffel.y"
				yy_do_action_34
			when 35 then
					--|#line <not available> "eiffel.y"
				yy_do_action_35
			when 36 then
					--|#line <not available> "eiffel.y"
				yy_do_action_36
			when 37 then
					--|#line <not available> "eiffel.y"
				yy_do_action_37
			when 38 then
					--|#line <not available> "eiffel.y"
				yy_do_action_38
			when 39 then
					--|#line <not available> "eiffel.y"
				yy_do_action_39
			when 40 then
					--|#line <not available> "eiffel.y"
				yy_do_action_40
			when 41 then
					--|#line <not available> "eiffel.y"
				yy_do_action_41
			when 42 then
					--|#line <not available> "eiffel.y"
				yy_do_action_42
			when 43 then
					--|#line <not available> "eiffel.y"
				yy_do_action_43
			when 44 then
					--|#line <not available> "eiffel.y"
				yy_do_action_44
			when 45 then
					--|#line <not available> "eiffel.y"
				yy_do_action_45
			when 46 then
					--|#line <not available> "eiffel.y"
				yy_do_action_46
			when 47 then
					--|#line <not available> "eiffel.y"
				yy_do_action_47
			when 48 then
					--|#line <not available> "eiffel.y"
				yy_do_action_48
			when 49 then
					--|#line <not available> "eiffel.y"
				yy_do_action_49
			when 50 then
					--|#line <not available> "eiffel.y"
				yy_do_action_50
			when 51 then
					--|#line <not available> "eiffel.y"
				yy_do_action_51
			when 52 then
					--|#line <not available> "eiffel.y"
				yy_do_action_52
			when 53 then
					--|#line <not available> "eiffel.y"
				yy_do_action_53
			when 54 then
					--|#line <not available> "eiffel.y"
				yy_do_action_54
			when 55 then
					--|#line <not available> "eiffel.y"
				yy_do_action_55
			when 56 then
					--|#line <not available> "eiffel.y"
				yy_do_action_56
			when 57 then
					--|#line <not available> "eiffel.y"
				yy_do_action_57
			when 58 then
					--|#line <not available> "eiffel.y"
				yy_do_action_58
			when 59 then
					--|#line <not available> "eiffel.y"
				yy_do_action_59
			when 60 then
					--|#line <not available> "eiffel.y"
				yy_do_action_60
			when 61 then
					--|#line <not available> "eiffel.y"
				yy_do_action_61
			when 62 then
					--|#line <not available> "eiffel.y"
				yy_do_action_62
			when 63 then
					--|#line <not available> "eiffel.y"
				yy_do_action_63
			when 64 then
					--|#line <not available> "eiffel.y"
				yy_do_action_64
			when 65 then
					--|#line <not available> "eiffel.y"
				yy_do_action_65
			when 66 then
					--|#line <not available> "eiffel.y"
				yy_do_action_66
			when 67 then
					--|#line <not available> "eiffel.y"
				yy_do_action_67
			when 68 then
					--|#line <not available> "eiffel.y"
				yy_do_action_68
			when 69 then
					--|#line <not available> "eiffel.y"
				yy_do_action_69
			when 70 then
					--|#line <not available> "eiffel.y"
				yy_do_action_70
			when 71 then
					--|#line <not available> "eiffel.y"
				yy_do_action_71
			when 72 then
					--|#line <not available> "eiffel.y"
				yy_do_action_72
			when 73 then
					--|#line <not available> "eiffel.y"
				yy_do_action_73
			when 74 then
					--|#line <not available> "eiffel.y"
				yy_do_action_74
			when 75 then
					--|#line <not available> "eiffel.y"
				yy_do_action_75
			when 76 then
					--|#line <not available> "eiffel.y"
				yy_do_action_76
			when 77 then
					--|#line <not available> "eiffel.y"
				yy_do_action_77
			when 78 then
					--|#line <not available> "eiffel.y"
				yy_do_action_78
			when 79 then
					--|#line <not available> "eiffel.y"
				yy_do_action_79
			when 80 then
					--|#line <not available> "eiffel.y"
				yy_do_action_80
			when 81 then
					--|#line <not available> "eiffel.y"
				yy_do_action_81
			when 82 then
					--|#line <not available> "eiffel.y"
				yy_do_action_82
			when 83 then
					--|#line <not available> "eiffel.y"
				yy_do_action_83
			when 84 then
					--|#line <not available> "eiffel.y"
				yy_do_action_84
			when 85 then
					--|#line <not available> "eiffel.y"
				yy_do_action_85
			when 86 then
					--|#line <not available> "eiffel.y"
				yy_do_action_86
			when 87 then
					--|#line <not available> "eiffel.y"
				yy_do_action_87
			when 88 then
					--|#line <not available> "eiffel.y"
				yy_do_action_88
			when 89 then
					--|#line <not available> "eiffel.y"
				yy_do_action_89
			when 90 then
					--|#line <not available> "eiffel.y"
				yy_do_action_90
			when 91 then
					--|#line <not available> "eiffel.y"
				yy_do_action_91
			when 92 then
					--|#line <not available> "eiffel.y"
				yy_do_action_92
			when 93 then
					--|#line <not available> "eiffel.y"
				yy_do_action_93
			when 94 then
					--|#line <not available> "eiffel.y"
				yy_do_action_94
			when 95 then
					--|#line <not available> "eiffel.y"
				yy_do_action_95
			when 96 then
					--|#line <not available> "eiffel.y"
				yy_do_action_96
			when 97 then
					--|#line <not available> "eiffel.y"
				yy_do_action_97
			when 98 then
					--|#line <not available> "eiffel.y"
				yy_do_action_98
			when 99 then
					--|#line <not available> "eiffel.y"
				yy_do_action_99
			when 100 then
					--|#line <not available> "eiffel.y"
				yy_do_action_100
			when 101 then
					--|#line <not available> "eiffel.y"
				yy_do_action_101
			when 102 then
					--|#line <not available> "eiffel.y"
				yy_do_action_102
			when 103 then
					--|#line <not available> "eiffel.y"
				yy_do_action_103
			when 104 then
					--|#line <not available> "eiffel.y"
				yy_do_action_104
			when 105 then
					--|#line <not available> "eiffel.y"
				yy_do_action_105
			when 106 then
					--|#line <not available> "eiffel.y"
				yy_do_action_106
			when 107 then
					--|#line <not available> "eiffel.y"
				yy_do_action_107
			when 108 then
					--|#line <not available> "eiffel.y"
				yy_do_action_108
			when 109 then
					--|#line <not available> "eiffel.y"
				yy_do_action_109
			when 110 then
					--|#line <not available> "eiffel.y"
				yy_do_action_110
			when 111 then
					--|#line <not available> "eiffel.y"
				yy_do_action_111
			when 112 then
					--|#line <not available> "eiffel.y"
				yy_do_action_112
			when 113 then
					--|#line <not available> "eiffel.y"
				yy_do_action_113
			when 114 then
					--|#line <not available> "eiffel.y"
				yy_do_action_114
			when 115 then
					--|#line <not available> "eiffel.y"
				yy_do_action_115
			when 116 then
					--|#line <not available> "eiffel.y"
				yy_do_action_116
			when 117 then
					--|#line <not available> "eiffel.y"
				yy_do_action_117
			when 118 then
					--|#line <not available> "eiffel.y"
				yy_do_action_118
			when 119 then
					--|#line <not available> "eiffel.y"
				yy_do_action_119
			when 120 then
					--|#line <not available> "eiffel.y"
				yy_do_action_120
			when 121 then
					--|#line <not available> "eiffel.y"
				yy_do_action_121
			when 122 then
					--|#line <not available> "eiffel.y"
				yy_do_action_122
			when 123 then
					--|#line <not available> "eiffel.y"
				yy_do_action_123
			when 124 then
					--|#line <not available> "eiffel.y"
				yy_do_action_124
			when 125 then
					--|#line <not available> "eiffel.y"
				yy_do_action_125
			when 126 then
					--|#line <not available> "eiffel.y"
				yy_do_action_126
			when 127 then
					--|#line <not available> "eiffel.y"
				yy_do_action_127
			when 128 then
					--|#line <not available> "eiffel.y"
				yy_do_action_128
			when 129 then
					--|#line <not available> "eiffel.y"
				yy_do_action_129
			when 130 then
					--|#line <not available> "eiffel.y"
				yy_do_action_130
			when 131 then
					--|#line <not available> "eiffel.y"
				yy_do_action_131
			when 132 then
					--|#line <not available> "eiffel.y"
				yy_do_action_132
			when 133 then
					--|#line <not available> "eiffel.y"
				yy_do_action_133
			when 134 then
					--|#line <not available> "eiffel.y"
				yy_do_action_134
			when 135 then
					--|#line <not available> "eiffel.y"
				yy_do_action_135
			when 136 then
					--|#line <not available> "eiffel.y"
				yy_do_action_136
			when 137 then
					--|#line <not available> "eiffel.y"
				yy_do_action_137
			when 138 then
					--|#line <not available> "eiffel.y"
				yy_do_action_138
			when 139 then
					--|#line <not available> "eiffel.y"
				yy_do_action_139
			when 140 then
					--|#line <not available> "eiffel.y"
				yy_do_action_140
			when 141 then
					--|#line <not available> "eiffel.y"
				yy_do_action_141
			when 142 then
					--|#line <not available> "eiffel.y"
				yy_do_action_142
			when 143 then
					--|#line <not available> "eiffel.y"
				yy_do_action_143
			when 144 then
					--|#line <not available> "eiffel.y"
				yy_do_action_144
			when 145 then
					--|#line <not available> "eiffel.y"
				yy_do_action_145
			when 146 then
					--|#line <not available> "eiffel.y"
				yy_do_action_146
			when 147 then
					--|#line <not available> "eiffel.y"
				yy_do_action_147
			when 148 then
					--|#line <not available> "eiffel.y"
				yy_do_action_148
			when 149 then
					--|#line <not available> "eiffel.y"
				yy_do_action_149
			when 150 then
					--|#line <not available> "eiffel.y"
				yy_do_action_150
			when 151 then
					--|#line <not available> "eiffel.y"
				yy_do_action_151
			when 152 then
					--|#line <not available> "eiffel.y"
				yy_do_action_152
			when 153 then
					--|#line <not available> "eiffel.y"
				yy_do_action_153
			when 154 then
					--|#line <not available> "eiffel.y"
				yy_do_action_154
			when 155 then
					--|#line <not available> "eiffel.y"
				yy_do_action_155
			when 156 then
					--|#line <not available> "eiffel.y"
				yy_do_action_156
			when 157 then
					--|#line <not available> "eiffel.y"
				yy_do_action_157
			when 158 then
					--|#line <not available> "eiffel.y"
				yy_do_action_158
			when 159 then
					--|#line <not available> "eiffel.y"
				yy_do_action_159
			when 160 then
					--|#line <not available> "eiffel.y"
				yy_do_action_160
			when 161 then
					--|#line <not available> "eiffel.y"
				yy_do_action_161
			when 162 then
					--|#line <not available> "eiffel.y"
				yy_do_action_162
			when 163 then
					--|#line <not available> "eiffel.y"
				yy_do_action_163
			when 164 then
					--|#line <not available> "eiffel.y"
				yy_do_action_164
			when 165 then
					--|#line <not available> "eiffel.y"
				yy_do_action_165
			when 166 then
					--|#line <not available> "eiffel.y"
				yy_do_action_166
			when 167 then
					--|#line <not available> "eiffel.y"
				yy_do_action_167
			when 168 then
					--|#line <not available> "eiffel.y"
				yy_do_action_168
			when 169 then
					--|#line <not available> "eiffel.y"
				yy_do_action_169
			when 170 then
					--|#line <not available> "eiffel.y"
				yy_do_action_170
			when 171 then
					--|#line <not available> "eiffel.y"
				yy_do_action_171
			when 172 then
					--|#line <not available> "eiffel.y"
				yy_do_action_172
			when 173 then
					--|#line <not available> "eiffel.y"
				yy_do_action_173
			when 174 then
					--|#line <not available> "eiffel.y"
				yy_do_action_174
			when 175 then
					--|#line <not available> "eiffel.y"
				yy_do_action_175
			when 176 then
					--|#line <not available> "eiffel.y"
				yy_do_action_176
			when 177 then
					--|#line <not available> "eiffel.y"
				yy_do_action_177
			when 178 then
					--|#line <not available> "eiffel.y"
				yy_do_action_178
			when 179 then
					--|#line <not available> "eiffel.y"
				yy_do_action_179
			when 180 then
					--|#line <not available> "eiffel.y"
				yy_do_action_180
			when 181 then
					--|#line <not available> "eiffel.y"
				yy_do_action_181
			when 182 then
					--|#line <not available> "eiffel.y"
				yy_do_action_182
			when 183 then
					--|#line <not available> "eiffel.y"
				yy_do_action_183
			when 184 then
					--|#line <not available> "eiffel.y"
				yy_do_action_184
			when 185 then
					--|#line <not available> "eiffel.y"
				yy_do_action_185
			when 186 then
					--|#line <not available> "eiffel.y"
				yy_do_action_186
			when 187 then
					--|#line <not available> "eiffel.y"
				yy_do_action_187
			when 188 then
					--|#line <not available> "eiffel.y"
				yy_do_action_188
			when 189 then
					--|#line <not available> "eiffel.y"
				yy_do_action_189
			when 190 then
					--|#line <not available> "eiffel.y"
				yy_do_action_190
			when 191 then
					--|#line <not available> "eiffel.y"
				yy_do_action_191
			when 192 then
					--|#line <not available> "eiffel.y"
				yy_do_action_192
			when 193 then
					--|#line <not available> "eiffel.y"
				yy_do_action_193
			when 194 then
					--|#line <not available> "eiffel.y"
				yy_do_action_194
			when 195 then
					--|#line <not available> "eiffel.y"
				yy_do_action_195
			when 196 then
					--|#line <not available> "eiffel.y"
				yy_do_action_196
			when 197 then
					--|#line <not available> "eiffel.y"
				yy_do_action_197
			when 198 then
					--|#line <not available> "eiffel.y"
				yy_do_action_198
			when 199 then
					--|#line <not available> "eiffel.y"
				yy_do_action_199
			when 200 then
					--|#line <not available> "eiffel.y"
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
					--|#line <not available> "eiffel.y"
				yy_do_action_201
			when 202 then
					--|#line <not available> "eiffel.y"
				yy_do_action_202
			when 203 then
					--|#line <not available> "eiffel.y"
				yy_do_action_203
			when 204 then
					--|#line <not available> "eiffel.y"
				yy_do_action_204
			when 205 then
					--|#line <not available> "eiffel.y"
				yy_do_action_205
			when 206 then
					--|#line <not available> "eiffel.y"
				yy_do_action_206
			when 207 then
					--|#line <not available> "eiffel.y"
				yy_do_action_207
			when 208 then
					--|#line <not available> "eiffel.y"
				yy_do_action_208
			when 209 then
					--|#line <not available> "eiffel.y"
				yy_do_action_209
			when 210 then
					--|#line <not available> "eiffel.y"
				yy_do_action_210
			when 211 then
					--|#line <not available> "eiffel.y"
				yy_do_action_211
			when 212 then
					--|#line <not available> "eiffel.y"
				yy_do_action_212
			when 213 then
					--|#line <not available> "eiffel.y"
				yy_do_action_213
			when 214 then
					--|#line <not available> "eiffel.y"
				yy_do_action_214
			when 215 then
					--|#line <not available> "eiffel.y"
				yy_do_action_215
			when 216 then
					--|#line <not available> "eiffel.y"
				yy_do_action_216
			when 217 then
					--|#line <not available> "eiffel.y"
				yy_do_action_217
			when 218 then
					--|#line <not available> "eiffel.y"
				yy_do_action_218
			when 219 then
					--|#line <not available> "eiffel.y"
				yy_do_action_219
			when 220 then
					--|#line <not available> "eiffel.y"
				yy_do_action_220
			when 221 then
					--|#line <not available> "eiffel.y"
				yy_do_action_221
			when 222 then
					--|#line <not available> "eiffel.y"
				yy_do_action_222
			when 223 then
					--|#line <not available> "eiffel.y"
				yy_do_action_223
			when 224 then
					--|#line <not available> "eiffel.y"
				yy_do_action_224
			when 225 then
					--|#line <not available> "eiffel.y"
				yy_do_action_225
			when 226 then
					--|#line <not available> "eiffel.y"
				yy_do_action_226
			when 227 then
					--|#line <not available> "eiffel.y"
				yy_do_action_227
			when 228 then
					--|#line <not available> "eiffel.y"
				yy_do_action_228
			when 229 then
					--|#line <not available> "eiffel.y"
				yy_do_action_229
			when 230 then
					--|#line <not available> "eiffel.y"
				yy_do_action_230
			when 231 then
					--|#line <not available> "eiffel.y"
				yy_do_action_231
			when 232 then
					--|#line <not available> "eiffel.y"
				yy_do_action_232
			when 233 then
					--|#line <not available> "eiffel.y"
				yy_do_action_233
			when 234 then
					--|#line <not available> "eiffel.y"
				yy_do_action_234
			when 235 then
					--|#line <not available> "eiffel.y"
				yy_do_action_235
			when 236 then
					--|#line <not available> "eiffel.y"
				yy_do_action_236
			when 237 then
					--|#line <not available> "eiffel.y"
				yy_do_action_237
			when 238 then
					--|#line <not available> "eiffel.y"
				yy_do_action_238
			when 239 then
					--|#line <not available> "eiffel.y"
				yy_do_action_239
			when 240 then
					--|#line <not available> "eiffel.y"
				yy_do_action_240
			when 241 then
					--|#line <not available> "eiffel.y"
				yy_do_action_241
			when 242 then
					--|#line <not available> "eiffel.y"
				yy_do_action_242
			when 243 then
					--|#line <not available> "eiffel.y"
				yy_do_action_243
			when 244 then
					--|#line <not available> "eiffel.y"
				yy_do_action_244
			when 245 then
					--|#line <not available> "eiffel.y"
				yy_do_action_245
			when 246 then
					--|#line <not available> "eiffel.y"
				yy_do_action_246
			when 247 then
					--|#line <not available> "eiffel.y"
				yy_do_action_247
			when 248 then
					--|#line <not available> "eiffel.y"
				yy_do_action_248
			when 249 then
					--|#line <not available> "eiffel.y"
				yy_do_action_249
			when 250 then
					--|#line <not available> "eiffel.y"
				yy_do_action_250
			when 251 then
					--|#line <not available> "eiffel.y"
				yy_do_action_251
			when 252 then
					--|#line <not available> "eiffel.y"
				yy_do_action_252
			when 253 then
					--|#line <not available> "eiffel.y"
				yy_do_action_253
			when 254 then
					--|#line <not available> "eiffel.y"
				yy_do_action_254
			when 255 then
					--|#line <not available> "eiffel.y"
				yy_do_action_255
			when 256 then
					--|#line <not available> "eiffel.y"
				yy_do_action_256
			when 257 then
					--|#line <not available> "eiffel.y"
				yy_do_action_257
			when 258 then
					--|#line <not available> "eiffel.y"
				yy_do_action_258
			when 259 then
					--|#line <not available> "eiffel.y"
				yy_do_action_259
			when 260 then
					--|#line <not available> "eiffel.y"
				yy_do_action_260
			when 261 then
					--|#line <not available> "eiffel.y"
				yy_do_action_261
			when 262 then
					--|#line <not available> "eiffel.y"
				yy_do_action_262
			when 263 then
					--|#line <not available> "eiffel.y"
				yy_do_action_263
			when 264 then
					--|#line <not available> "eiffel.y"
				yy_do_action_264
			when 265 then
					--|#line <not available> "eiffel.y"
				yy_do_action_265
			when 266 then
					--|#line <not available> "eiffel.y"
				yy_do_action_266
			when 267 then
					--|#line <not available> "eiffel.y"
				yy_do_action_267
			when 268 then
					--|#line <not available> "eiffel.y"
				yy_do_action_268
			when 269 then
					--|#line <not available> "eiffel.y"
				yy_do_action_269
			when 270 then
					--|#line <not available> "eiffel.y"
				yy_do_action_270
			when 271 then
					--|#line <not available> "eiffel.y"
				yy_do_action_271
			when 272 then
					--|#line <not available> "eiffel.y"
				yy_do_action_272
			when 273 then
					--|#line <not available> "eiffel.y"
				yy_do_action_273
			when 274 then
					--|#line <not available> "eiffel.y"
				yy_do_action_274
			when 275 then
					--|#line <not available> "eiffel.y"
				yy_do_action_275
			when 276 then
					--|#line <not available> "eiffel.y"
				yy_do_action_276
			when 277 then
					--|#line <not available> "eiffel.y"
				yy_do_action_277
			when 278 then
					--|#line <not available> "eiffel.y"
				yy_do_action_278
			when 279 then
					--|#line <not available> "eiffel.y"
				yy_do_action_279
			when 280 then
					--|#line <not available> "eiffel.y"
				yy_do_action_280
			when 281 then
					--|#line <not available> "eiffel.y"
				yy_do_action_281
			when 282 then
					--|#line <not available> "eiffel.y"
				yy_do_action_282
			when 283 then
					--|#line <not available> "eiffel.y"
				yy_do_action_283
			when 284 then
					--|#line <not available> "eiffel.y"
				yy_do_action_284
			when 285 then
					--|#line <not available> "eiffel.y"
				yy_do_action_285
			when 286 then
					--|#line <not available> "eiffel.y"
				yy_do_action_286
			when 287 then
					--|#line <not available> "eiffel.y"
				yy_do_action_287
			when 288 then
					--|#line <not available> "eiffel.y"
				yy_do_action_288
			when 289 then
					--|#line <not available> "eiffel.y"
				yy_do_action_289
			when 290 then
					--|#line <not available> "eiffel.y"
				yy_do_action_290
			when 291 then
					--|#line <not available> "eiffel.y"
				yy_do_action_291
			when 292 then
					--|#line <not available> "eiffel.y"
				yy_do_action_292
			when 293 then
					--|#line <not available> "eiffel.y"
				yy_do_action_293
			when 294 then
					--|#line <not available> "eiffel.y"
				yy_do_action_294
			when 295 then
					--|#line <not available> "eiffel.y"
				yy_do_action_295
			when 296 then
					--|#line <not available> "eiffel.y"
				yy_do_action_296
			when 297 then
					--|#line <not available> "eiffel.y"
				yy_do_action_297
			when 298 then
					--|#line <not available> "eiffel.y"
				yy_do_action_298
			when 299 then
					--|#line <not available> "eiffel.y"
				yy_do_action_299
			when 300 then
					--|#line <not available> "eiffel.y"
				yy_do_action_300
			when 301 then
					--|#line <not available> "eiffel.y"
				yy_do_action_301
			when 302 then
					--|#line <not available> "eiffel.y"
				yy_do_action_302
			when 303 then
					--|#line <not available> "eiffel.y"
				yy_do_action_303
			when 304 then
					--|#line <not available> "eiffel.y"
				yy_do_action_304
			when 305 then
					--|#line <not available> "eiffel.y"
				yy_do_action_305
			when 306 then
					--|#line <not available> "eiffel.y"
				yy_do_action_306
			when 307 then
					--|#line <not available> "eiffel.y"
				yy_do_action_307
			when 308 then
					--|#line <not available> "eiffel.y"
				yy_do_action_308
			when 309 then
					--|#line <not available> "eiffel.y"
				yy_do_action_309
			when 310 then
					--|#line <not available> "eiffel.y"
				yy_do_action_310
			when 311 then
					--|#line <not available> "eiffel.y"
				yy_do_action_311
			when 312 then
					--|#line <not available> "eiffel.y"
				yy_do_action_312
			when 313 then
					--|#line <not available> "eiffel.y"
				yy_do_action_313
			when 314 then
					--|#line <not available> "eiffel.y"
				yy_do_action_314
			when 315 then
					--|#line <not available> "eiffel.y"
				yy_do_action_315
			when 316 then
					--|#line <not available> "eiffel.y"
				yy_do_action_316
			when 317 then
					--|#line <not available> "eiffel.y"
				yy_do_action_317
			when 318 then
					--|#line <not available> "eiffel.y"
				yy_do_action_318
			when 319 then
					--|#line <not available> "eiffel.y"
				yy_do_action_319
			when 320 then
					--|#line <not available> "eiffel.y"
				yy_do_action_320
			when 321 then
					--|#line <not available> "eiffel.y"
				yy_do_action_321
			when 322 then
					--|#line <not available> "eiffel.y"
				yy_do_action_322
			when 323 then
					--|#line <not available> "eiffel.y"
				yy_do_action_323
			when 324 then
					--|#line <not available> "eiffel.y"
				yy_do_action_324
			when 325 then
					--|#line <not available> "eiffel.y"
				yy_do_action_325
			when 326 then
					--|#line <not available> "eiffel.y"
				yy_do_action_326
			when 327 then
					--|#line <not available> "eiffel.y"
				yy_do_action_327
			when 328 then
					--|#line <not available> "eiffel.y"
				yy_do_action_328
			when 329 then
					--|#line <not available> "eiffel.y"
				yy_do_action_329
			when 330 then
					--|#line <not available> "eiffel.y"
				yy_do_action_330
			when 331 then
					--|#line <not available> "eiffel.y"
				yy_do_action_331
			when 332 then
					--|#line <not available> "eiffel.y"
				yy_do_action_332
			when 333 then
					--|#line <not available> "eiffel.y"
				yy_do_action_333
			when 334 then
					--|#line <not available> "eiffel.y"
				yy_do_action_334
			when 335 then
					--|#line <not available> "eiffel.y"
				yy_do_action_335
			when 336 then
					--|#line <not available> "eiffel.y"
				yy_do_action_336
			when 337 then
					--|#line <not available> "eiffel.y"
				yy_do_action_337
			when 338 then
					--|#line <not available> "eiffel.y"
				yy_do_action_338
			when 339 then
					--|#line <not available> "eiffel.y"
				yy_do_action_339
			when 340 then
					--|#line <not available> "eiffel.y"
				yy_do_action_340
			when 341 then
					--|#line <not available> "eiffel.y"
				yy_do_action_341
			when 342 then
					--|#line <not available> "eiffel.y"
				yy_do_action_342
			when 343 then
					--|#line <not available> "eiffel.y"
				yy_do_action_343
			when 344 then
					--|#line <not available> "eiffel.y"
				yy_do_action_344
			when 345 then
					--|#line <not available> "eiffel.y"
				yy_do_action_345
			when 346 then
					--|#line <not available> "eiffel.y"
				yy_do_action_346
			when 347 then
					--|#line <not available> "eiffel.y"
				yy_do_action_347
			when 348 then
					--|#line <not available> "eiffel.y"
				yy_do_action_348
			when 349 then
					--|#line <not available> "eiffel.y"
				yy_do_action_349
			when 350 then
					--|#line <not available> "eiffel.y"
				yy_do_action_350
			when 351 then
					--|#line <not available> "eiffel.y"
				yy_do_action_351
			when 352 then
					--|#line <not available> "eiffel.y"
				yy_do_action_352
			when 353 then
					--|#line <not available> "eiffel.y"
				yy_do_action_353
			when 354 then
					--|#line <not available> "eiffel.y"
				yy_do_action_354
			when 355 then
					--|#line <not available> "eiffel.y"
				yy_do_action_355
			when 356 then
					--|#line <not available> "eiffel.y"
				yy_do_action_356
			when 357 then
					--|#line <not available> "eiffel.y"
				yy_do_action_357
			when 358 then
					--|#line <not available> "eiffel.y"
				yy_do_action_358
			when 359 then
					--|#line <not available> "eiffel.y"
				yy_do_action_359
			when 360 then
					--|#line <not available> "eiffel.y"
				yy_do_action_360
			when 361 then
					--|#line <not available> "eiffel.y"
				yy_do_action_361
			when 362 then
					--|#line <not available> "eiffel.y"
				yy_do_action_362
			when 363 then
					--|#line <not available> "eiffel.y"
				yy_do_action_363
			when 364 then
					--|#line <not available> "eiffel.y"
				yy_do_action_364
			when 365 then
					--|#line <not available> "eiffel.y"
				yy_do_action_365
			when 366 then
					--|#line <not available> "eiffel.y"
				yy_do_action_366
			when 367 then
					--|#line <not available> "eiffel.y"
				yy_do_action_367
			when 368 then
					--|#line <not available> "eiffel.y"
				yy_do_action_368
			when 369 then
					--|#line <not available> "eiffel.y"
				yy_do_action_369
			when 370 then
					--|#line <not available> "eiffel.y"
				yy_do_action_370
			when 371 then
					--|#line <not available> "eiffel.y"
				yy_do_action_371
			when 372 then
					--|#line <not available> "eiffel.y"
				yy_do_action_372
			when 373 then
					--|#line <not available> "eiffel.y"
				yy_do_action_373
			when 374 then
					--|#line <not available> "eiffel.y"
				yy_do_action_374
			when 375 then
					--|#line <not available> "eiffel.y"
				yy_do_action_375
			when 376 then
					--|#line <not available> "eiffel.y"
				yy_do_action_376
			when 377 then
					--|#line <not available> "eiffel.y"
				yy_do_action_377
			when 378 then
					--|#line <not available> "eiffel.y"
				yy_do_action_378
			when 379 then
					--|#line <not available> "eiffel.y"
				yy_do_action_379
			when 380 then
					--|#line <not available> "eiffel.y"
				yy_do_action_380
			when 381 then
					--|#line <not available> "eiffel.y"
				yy_do_action_381
			when 382 then
					--|#line <not available> "eiffel.y"
				yy_do_action_382
			when 383 then
					--|#line <not available> "eiffel.y"
				yy_do_action_383
			when 384 then
					--|#line <not available> "eiffel.y"
				yy_do_action_384
			when 385 then
					--|#line <not available> "eiffel.y"
				yy_do_action_385
			when 386 then
					--|#line <not available> "eiffel.y"
				yy_do_action_386
			when 387 then
					--|#line <not available> "eiffel.y"
				yy_do_action_387
			when 388 then
					--|#line <not available> "eiffel.y"
				yy_do_action_388
			when 389 then
					--|#line <not available> "eiffel.y"
				yy_do_action_389
			when 390 then
					--|#line <not available> "eiffel.y"
				yy_do_action_390
			when 391 then
					--|#line <not available> "eiffel.y"
				yy_do_action_391
			when 392 then
					--|#line <not available> "eiffel.y"
				yy_do_action_392
			when 393 then
					--|#line <not available> "eiffel.y"
				yy_do_action_393
			when 394 then
					--|#line <not available> "eiffel.y"
				yy_do_action_394
			when 395 then
					--|#line <not available> "eiffel.y"
				yy_do_action_395
			when 396 then
					--|#line <not available> "eiffel.y"
				yy_do_action_396
			when 397 then
					--|#line <not available> "eiffel.y"
				yy_do_action_397
			when 398 then
					--|#line <not available> "eiffel.y"
				yy_do_action_398
			when 399 then
					--|#line <not available> "eiffel.y"
				yy_do_action_399
			when 400 then
					--|#line <not available> "eiffel.y"
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
					--|#line <not available> "eiffel.y"
				yy_do_action_401
			when 402 then
					--|#line <not available> "eiffel.y"
				yy_do_action_402
			when 403 then
					--|#line <not available> "eiffel.y"
				yy_do_action_403
			when 404 then
					--|#line <not available> "eiffel.y"
				yy_do_action_404
			when 405 then
					--|#line <not available> "eiffel.y"
				yy_do_action_405
			when 406 then
					--|#line <not available> "eiffel.y"
				yy_do_action_406
			when 407 then
					--|#line <not available> "eiffel.y"
				yy_do_action_407
			when 408 then
					--|#line <not available> "eiffel.y"
				yy_do_action_408
			when 409 then
					--|#line <not available> "eiffel.y"
				yy_do_action_409
			when 410 then
					--|#line <not available> "eiffel.y"
				yy_do_action_410
			when 411 then
					--|#line <not available> "eiffel.y"
				yy_do_action_411
			when 412 then
					--|#line <not available> "eiffel.y"
				yy_do_action_412
			when 413 then
					--|#line <not available> "eiffel.y"
				yy_do_action_413
			when 414 then
					--|#line <not available> "eiffel.y"
				yy_do_action_414
			when 415 then
					--|#line <not available> "eiffel.y"
				yy_do_action_415
			when 416 then
					--|#line <not available> "eiffel.y"
				yy_do_action_416
			when 417 then
					--|#line <not available> "eiffel.y"
				yy_do_action_417
			when 418 then
					--|#line <not available> "eiffel.y"
				yy_do_action_418
			when 419 then
					--|#line <not available> "eiffel.y"
				yy_do_action_419
			when 420 then
					--|#line <not available> "eiffel.y"
				yy_do_action_420
			when 421 then
					--|#line <not available> "eiffel.y"
				yy_do_action_421
			when 422 then
					--|#line <not available> "eiffel.y"
				yy_do_action_422
			when 423 then
					--|#line <not available> "eiffel.y"
				yy_do_action_423
			when 424 then
					--|#line <not available> "eiffel.y"
				yy_do_action_424
			when 425 then
					--|#line <not available> "eiffel.y"
				yy_do_action_425
			when 426 then
					--|#line <not available> "eiffel.y"
				yy_do_action_426
			when 427 then
					--|#line <not available> "eiffel.y"
				yy_do_action_427
			when 428 then
					--|#line <not available> "eiffel.y"
				yy_do_action_428
			when 429 then
					--|#line <not available> "eiffel.y"
				yy_do_action_429
			when 430 then
					--|#line <not available> "eiffel.y"
				yy_do_action_430
			when 431 then
					--|#line <not available> "eiffel.y"
				yy_do_action_431
			when 432 then
					--|#line <not available> "eiffel.y"
				yy_do_action_432
			when 433 then
					--|#line <not available> "eiffel.y"
				yy_do_action_433
			when 434 then
					--|#line <not available> "eiffel.y"
				yy_do_action_434
			when 435 then
					--|#line <not available> "eiffel.y"
				yy_do_action_435
			when 436 then
					--|#line <not available> "eiffel.y"
				yy_do_action_436
			when 437 then
					--|#line <not available> "eiffel.y"
				yy_do_action_437
			when 438 then
					--|#line <not available> "eiffel.y"
				yy_do_action_438
			when 439 then
					--|#line <not available> "eiffel.y"
				yy_do_action_439
			when 440 then
					--|#line <not available> "eiffel.y"
				yy_do_action_440
			when 441 then
					--|#line <not available> "eiffel.y"
				yy_do_action_441
			when 442 then
					--|#line <not available> "eiffel.y"
				yy_do_action_442
			when 443 then
					--|#line <not available> "eiffel.y"
				yy_do_action_443
			when 444 then
					--|#line <not available> "eiffel.y"
				yy_do_action_444
			when 445 then
					--|#line <not available> "eiffel.y"
				yy_do_action_445
			when 446 then
					--|#line <not available> "eiffel.y"
				yy_do_action_446
			when 447 then
					--|#line <not available> "eiffel.y"
				yy_do_action_447
			when 448 then
					--|#line <not available> "eiffel.y"
				yy_do_action_448
			when 449 then
					--|#line <not available> "eiffel.y"
				yy_do_action_449
			when 450 then
					--|#line <not available> "eiffel.y"
				yy_do_action_450
			when 451 then
					--|#line <not available> "eiffel.y"
				yy_do_action_451
			when 452 then
					--|#line <not available> "eiffel.y"
				yy_do_action_452
			when 453 then
					--|#line <not available> "eiffel.y"
				yy_do_action_453
			when 454 then
					--|#line <not available> "eiffel.y"
				yy_do_action_454
			when 455 then
					--|#line <not available> "eiffel.y"
				yy_do_action_455
			when 456 then
					--|#line <not available> "eiffel.y"
				yy_do_action_456
			when 457 then
					--|#line <not available> "eiffel.y"
				yy_do_action_457
			when 458 then
					--|#line <not available> "eiffel.y"
				yy_do_action_458
			when 459 then
					--|#line <not available> "eiffel.y"
				yy_do_action_459
			when 460 then
					--|#line <not available> "eiffel.y"
				yy_do_action_460
			when 461 then
					--|#line <not available> "eiffel.y"
				yy_do_action_461
			when 462 then
					--|#line <not available> "eiffel.y"
				yy_do_action_462
			when 463 then
					--|#line <not available> "eiffel.y"
				yy_do_action_463
			when 464 then
					--|#line <not available> "eiffel.y"
				yy_do_action_464
			when 465 then
					--|#line <not available> "eiffel.y"
				yy_do_action_465
			when 466 then
					--|#line <not available> "eiffel.y"
				yy_do_action_466
			when 467 then
					--|#line <not available> "eiffel.y"
				yy_do_action_467
			when 468 then
					--|#line <not available> "eiffel.y"
				yy_do_action_468
			when 469 then
					--|#line <not available> "eiffel.y"
				yy_do_action_469
			when 470 then
					--|#line <not available> "eiffel.y"
				yy_do_action_470
			when 471 then
					--|#line <not available> "eiffel.y"
				yy_do_action_471
			when 472 then
					--|#line <not available> "eiffel.y"
				yy_do_action_472
			when 473 then
					--|#line <not available> "eiffel.y"
				yy_do_action_473
			when 474 then
					--|#line <not available> "eiffel.y"
				yy_do_action_474
			when 475 then
					--|#line <not available> "eiffel.y"
				yy_do_action_475
			when 476 then
					--|#line <not available> "eiffel.y"
				yy_do_action_476
			when 477 then
					--|#line <not available> "eiffel.y"
				yy_do_action_477
			when 478 then
					--|#line <not available> "eiffel.y"
				yy_do_action_478
			when 479 then
					--|#line <not available> "eiffel.y"
				yy_do_action_479
			when 480 then
					--|#line <not available> "eiffel.y"
				yy_do_action_480
			when 481 then
					--|#line <not available> "eiffel.y"
				yy_do_action_481
			when 482 then
					--|#line <not available> "eiffel.y"
				yy_do_action_482
			when 483 then
					--|#line <not available> "eiffel.y"
				yy_do_action_483
			when 484 then
					--|#line <not available> "eiffel.y"
				yy_do_action_484
			when 485 then
					--|#line <not available> "eiffel.y"
				yy_do_action_485
			when 486 then
					--|#line <not available> "eiffel.y"
				yy_do_action_486
			when 487 then
					--|#line <not available> "eiffel.y"
				yy_do_action_487
			when 488 then
					--|#line <not available> "eiffel.y"
				yy_do_action_488
			when 489 then
					--|#line <not available> "eiffel.y"
				yy_do_action_489
			when 490 then
					--|#line <not available> "eiffel.y"
				yy_do_action_490
			when 491 then
					--|#line <not available> "eiffel.y"
				yy_do_action_491
			when 492 then
					--|#line <not available> "eiffel.y"
				yy_do_action_492
			when 493 then
					--|#line <not available> "eiffel.y"
				yy_do_action_493
			when 494 then
					--|#line <not available> "eiffel.y"
				yy_do_action_494
			when 495 then
					--|#line <not available> "eiffel.y"
				yy_do_action_495
			when 496 then
					--|#line <not available> "eiffel.y"
				yy_do_action_496
			when 497 then
					--|#line <not available> "eiffel.y"
				yy_do_action_497
			when 498 then
					--|#line <not available> "eiffel.y"
				yy_do_action_498
			when 499 then
					--|#line <not available> "eiffel.y"
				yy_do_action_499
			when 500 then
					--|#line <not available> "eiffel.y"
				yy_do_action_500
			when 501 then
					--|#line <not available> "eiffel.y"
				yy_do_action_501
			when 502 then
					--|#line <not available> "eiffel.y"
				yy_do_action_502
			when 503 then
					--|#line <not available> "eiffel.y"
				yy_do_action_503
			when 504 then
					--|#line <not available> "eiffel.y"
				yy_do_action_504
			when 505 then
					--|#line <not available> "eiffel.y"
				yy_do_action_505
			when 506 then
					--|#line <not available> "eiffel.y"
				yy_do_action_506
			when 507 then
					--|#line <not available> "eiffel.y"
				yy_do_action_507
			when 508 then
					--|#line <not available> "eiffel.y"
				yy_do_action_508
			when 509 then
					--|#line <not available> "eiffel.y"
				yy_do_action_509
			when 510 then
					--|#line <not available> "eiffel.y"
				yy_do_action_510
			when 511 then
					--|#line <not available> "eiffel.y"
				yy_do_action_511
			when 512 then
					--|#line <not available> "eiffel.y"
				yy_do_action_512
			when 513 then
					--|#line <not available> "eiffel.y"
				yy_do_action_513
			when 514 then
					--|#line <not available> "eiffel.y"
				yy_do_action_514
			when 515 then
					--|#line <not available> "eiffel.y"
				yy_do_action_515
			when 516 then
					--|#line <not available> "eiffel.y"
				yy_do_action_516
			when 517 then
					--|#line <not available> "eiffel.y"
				yy_do_action_517
			when 518 then
					--|#line <not available> "eiffel.y"
				yy_do_action_518
			when 519 then
					--|#line <not available> "eiffel.y"
				yy_do_action_519
			when 520 then
					--|#line <not available> "eiffel.y"
				yy_do_action_520
			when 521 then
					--|#line <not available> "eiffel.y"
				yy_do_action_521
			when 522 then
					--|#line <not available> "eiffel.y"
				yy_do_action_522
			when 523 then
					--|#line <not available> "eiffel.y"
				yy_do_action_523
			when 524 then
					--|#line <not available> "eiffel.y"
				yy_do_action_524
			when 525 then
					--|#line <not available> "eiffel.y"
				yy_do_action_525
			when 526 then
					--|#line <not available> "eiffel.y"
				yy_do_action_526
			when 527 then
					--|#line <not available> "eiffel.y"
				yy_do_action_527
			when 528 then
					--|#line <not available> "eiffel.y"
				yy_do_action_528
			when 529 then
					--|#line <not available> "eiffel.y"
				yy_do_action_529
			when 530 then
					--|#line <not available> "eiffel.y"
				yy_do_action_530
			when 531 then
					--|#line <not available> "eiffel.y"
				yy_do_action_531
			when 532 then
					--|#line <not available> "eiffel.y"
				yy_do_action_532
			when 533 then
					--|#line <not available> "eiffel.y"
				yy_do_action_533
			when 534 then
					--|#line <not available> "eiffel.y"
				yy_do_action_534
			when 535 then
					--|#line <not available> "eiffel.y"
				yy_do_action_535
			when 536 then
					--|#line <not available> "eiffel.y"
				yy_do_action_536
			when 537 then
					--|#line <not available> "eiffel.y"
				yy_do_action_537
			when 538 then
					--|#line <not available> "eiffel.y"
				yy_do_action_538
			when 539 then
					--|#line <not available> "eiffel.y"
				yy_do_action_539
			when 540 then
					--|#line <not available> "eiffel.y"
				yy_do_action_540
			when 541 then
					--|#line <not available> "eiffel.y"
				yy_do_action_541
			when 542 then
					--|#line <not available> "eiffel.y"
				yy_do_action_542
			when 543 then
					--|#line <not available> "eiffel.y"
				yy_do_action_543
			when 544 then
					--|#line <not available> "eiffel.y"
				yy_do_action_544
			when 545 then
					--|#line <not available> "eiffel.y"
				yy_do_action_545
			when 546 then
					--|#line <not available> "eiffel.y"
				yy_do_action_546
			when 547 then
					--|#line <not available> "eiffel.y"
				yy_do_action_547
			when 548 then
					--|#line <not available> "eiffel.y"
				yy_do_action_548
			when 549 then
					--|#line <not available> "eiffel.y"
				yy_do_action_549
			when 550 then
					--|#line <not available> "eiffel.y"
				yy_do_action_550
			when 551 then
					--|#line <not available> "eiffel.y"
				yy_do_action_551
			when 552 then
					--|#line <not available> "eiffel.y"
				yy_do_action_552
			when 553 then
					--|#line <not available> "eiffel.y"
				yy_do_action_553
			when 554 then
					--|#line <not available> "eiffel.y"
				yy_do_action_554
			when 555 then
					--|#line <not available> "eiffel.y"
				yy_do_action_555
			when 556 then
					--|#line <not available> "eiffel.y"
				yy_do_action_556
			when 557 then
					--|#line <not available> "eiffel.y"
				yy_do_action_557
			when 558 then
					--|#line <not available> "eiffel.y"
				yy_do_action_558
			when 559 then
					--|#line <not available> "eiffel.y"
				yy_do_action_559
			when 560 then
					--|#line <not available> "eiffel.y"
				yy_do_action_560
			when 561 then
					--|#line <not available> "eiffel.y"
				yy_do_action_561
			when 562 then
					--|#line <not available> "eiffel.y"
				yy_do_action_562
			when 563 then
					--|#line <not available> "eiffel.y"
				yy_do_action_563
			when 564 then
					--|#line <not available> "eiffel.y"
				yy_do_action_564
			when 565 then
					--|#line <not available> "eiffel.y"
				yy_do_action_565
			when 566 then
					--|#line <not available> "eiffel.y"
				yy_do_action_566
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
			--|#line <not available> "eiffel.y"
		local
			yyval1: ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if type_parser or expression_parser or indexing_parser or entity_declaration_parser then
					raise_error
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_2 is
			--|#line <not available> "eiffel.y"
		local
			yyval1: ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if not type_parser or expression_parser or indexing_parser or entity_declaration_parser then
					raise_error
				end
				type_node := yyvs68.item (yyvsp68)
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp68 := yyvsp68 -1
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
			--|#line <not available> "eiffel.y"
		local
			yyval1: ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if not expression_parser or type_parser or indexing_parser or entity_declaration_parser then
					raise_error
				end
				expression_node := yyvs35.item (yyvsp35)
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp35 := yyvsp35 -1
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_4 is
			--|#line <not available> "eiffel.y"
		local
			yyval1: ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if not indexing_parser or type_parser or expression_parser or entity_declaration_parser then
					raise_error
				end
				indexing_node := yyvs86.item (yyvsp86)
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp1 := yyvsp1 + 1
	yyvsp86 := yyvsp86 -1
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
			--|#line <not available> "eiffel.y"
		local
			yyval1: ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if not entity_declaration_parser or type_parser or expression_parser or indexing_parser then
					raise_error
				end
				entity_declaration_node := Void
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_6 is
			--|#line <not available> "eiffel.y"
		local
			yyval1: ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if not entity_declaration_parser or type_parser or expression_parser or indexing_parser then
					raise_error
				end
				remove_counter
				entity_declaration_node := yyvs95.item (yyvsp95)
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp95 := yyvsp95 -1
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_7 is
			--|#line <not available> "eiffel.y"
		local
			yyval1: ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

add_counter 
if yy_parsing_status = yyContinue then
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

	yy_do_action_8 is
			--|#line <not available> "eiffel.y"
		local
			yyval1: ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				root_node := new_class_description (yyvs2.item (yyvsp2), yyvs65.item (yyvsp65 - 1),
					is_deferred, is_expanded, is_separate, is_frozen_class, is_external_class,
					yyvs86.item (yyvsp86 - 1), yyvs86.item (yyvsp86), yyvs82.item (yyvsp82), yyvs90.item (yyvsp90), yyvs75.item (yyvsp75), yyvs74.item (yyvsp74), yyvs80.item (yyvsp80), yyvs50.item (yyvsp50), suppliers, yyvs65.item (yyvsp65), yyvs3.item (yyvsp3))
				if root_node /= Void then
					root_node.set_text_positions (
						formal_generics_end_position,
						inheritance_end_position,
						features_end_position)
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 16
	yyvsp1 := yyvsp1 -3
	yyvsp86 := yyvsp86 -2
	yyvsp2 := yyvsp2 -1
	yyvsp82 := yyvsp82 -1
	yyvsp65 := yyvsp65 -2
	yyvsp90 := yyvsp90 -1
	yyvsp75 := yyvsp75 -1
	yyvsp74 := yyvsp74 -1
	yyvsp80 := yyvsp80 -1
	yyvsp50 := yyvsp50 -1
	yyvsp3 := yyvsp3 -1
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_9 is
			--|#line <not available> "eiffel.y"
		local
			yyval1: ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

inheritance_end_position := position 
if yy_parsing_status = yyContinue then
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

	yy_do_action_10 is
			--|#line <not available> "eiffel.y"
		local
			yyval1: ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

features_end_position := position 
if yy_parsing_status = yyContinue then
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

	yy_do_action_11 is
			--|#line <not available> "eiffel.y"
		local
			yyval86: INDEXING_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
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

	yy_do_action_12 is
			--|#line <not available> "eiffel.y"
		local
			yyval86: INDEXING_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval86 := yyvs86.item (yyvsp86)
				remove_counter
				set_has_old_verbatim_strings_warning (initial_has_old_verbatim_strings_warning)
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp86 := yyvsp86 -1
	yyvsp1 := yyvsp1 -1
	yyvs86.put (yyval86, yyvsp86)
end
		end

	yy_do_action_13 is
			--|#line <not available> "eiffel.y"
		local
			yyval86: INDEXING_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				add_counter
				initial_has_old_verbatim_strings_warning := has_old_verbatim_strings_warning
				set_has_old_verbatim_strings_warning (false)
			
if yy_parsing_status = yyContinue then
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

	yy_do_action_14 is
			--|#line <not available> "eiffel.y"
		local
			yyval86: INDEXING_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp86 := yyvsp86 + 1
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

	yy_do_action_15 is
			--|#line <not available> "eiffel.y"
		local
			yyval86: INDEXING_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
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

	yy_do_action_16 is
			--|#line <not available> "eiffel.y"
		local
			yyval86: INDEXING_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp86 := yyvsp86 + 1
	yyvsp1 := yyvsp1 -1
	yyvsp3 := yyvsp3 -1
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

	yy_do_action_17 is
			--|#line <not available> "eiffel.y"
		local
			yyval86: INDEXING_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval86 := yyvs86.item (yyvsp86)
				remove_counter
				set_has_old_verbatim_strings_warning (initial_has_old_verbatim_strings_warning)
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp86 := yyvsp86 -1
	yyvsp1 := yyvsp1 -1
	yyvsp3 := yyvsp3 -1
	yyvs86.put (yyval86, yyvsp86)
end
		end

	yy_do_action_18 is
			--|#line <not available> "eiffel.y"
		local
			yyval86: INDEXING_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				add_counter
				initial_has_old_verbatim_strings_warning := has_old_verbatim_strings_warning
				set_has_old_verbatim_strings_warning (false)
			
if yy_parsing_status = yyContinue then
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

	yy_do_action_19 is
			--|#line <not available> "eiffel.y"
		local
			yyval86: INDEXING_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval86 := ast_factory.new_indexing_clause_as (counter_value + 1)
				if yyval86 /= Void and yyvs44.item (yyvsp44) /= Void then
					yyval86.reverse_extend (yyvs44.item (yyvsp44))
					yyval86.update_lookup (yyvs44.item (yyvsp44))
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp86 := yyvsp86 + 1
	yyvsp44 := yyvsp44 -1
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

	yy_do_action_20 is
			--|#line <not available> "eiffel.y"
		local
			yyval86: INDEXING_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval86 := yyvs86.item (yyvsp86)
				if yyval86 /= Void and yyvs44.item (yyvsp44) /= Void then
					yyval86.reverse_extend (yyvs44.item (yyvsp44))
					yyval86.update_lookup (yyvs44.item (yyvsp44))
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp86 := yyvsp86 -1
	yyvsp44 := yyvsp44 -1
	yyvs86.put (yyval86, yyvsp86)
end
		end

	yy_do_action_21 is
			--|#line <not available> "eiffel.y"
		local
			yyval86: INDEXING_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

increment_counter 
if yy_parsing_status = yyContinue then
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

	yy_do_action_22 is
			--|#line <not available> "eiffel.y"
		local
			yyval44: INDEX_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			yyval44 := yyvs44.item (yyvsp44)
			remove_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp44 := yyvsp44 -1
	yyvs44.put (yyval44, yyvsp44)
end
		end

	yy_do_action_23 is
			--|#line <not available> "eiffel.y"
		local
			yyval44: INDEX_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

add_counter 
if yy_parsing_status = yyContinue then
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

	yy_do_action_24 is
			--|#line <not available> "eiffel.y"
		local
			yyval44: INDEX_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval44 := ast_factory.new_index_as (yyvs2.item (yyvsp2), yyvs72.item (yyvsp72))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp44 := yyvsp44 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -2
	yyvsp72 := yyvsp72 -1
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

	yy_do_action_25 is
			--|#line <not available> "eiffel.y"
		local
			yyval44: INDEX_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval44 := ast_factory.new_index_as (Void, yyvs72.item (yyvsp72))
				if has_syntax_warning and yyvs72.item (yyvsp72) /= Void then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (yyvs72.item (yyvsp72).start_location.line,
						yyvs72.item (yyvsp72).start_location.column, filename,
						"Missing `Index' part of `Index_clause'."))
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp44 := yyvsp44 + 1
	yyvsp72 := yyvsp72 -1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_26 is
			--|#line <not available> "eiffel.y"
		local
			yyval72: EIFFEL_LIST [ATOMIC_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval72 := ast_factory.new_eiffel_list_atomic_as (counter_value + 1)
				if yyval72 /= Void and yyvs17.item (yyvsp17) /= Void then
					yyval72.reverse_extend (yyvs17.item (yyvsp17))
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp72 := yyvsp72 + 1
	yyvsp17 := yyvsp17 -1
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

	yy_do_action_27 is
			--|#line <not available> "eiffel.y"
		local
			yyval72: EIFFEL_LIST [ATOMIC_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval72 := yyvs72.item (yyvsp72)
				if yyval72 /= Void and yyvs17.item (yyvsp17) /= Void then
					yyval72.reverse_extend (yyvs17.item (yyvsp17))
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp72 := yyvsp72 -1
	yyvsp17 := yyvsp17 -1
	yyvsp1 := yyvsp1 -1
	yyvs72.put (yyval72, yyvsp72)
end
		end

	yy_do_action_28 is
			--|#line <not available> "eiffel.y"
		local
			yyval72: EIFFEL_LIST [ATOMIC_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

increment_counter 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp72 := yyvsp72 + 1
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

	yy_do_action_29 is
			--|#line <not available> "eiffel.y"
		local
			yyval72: EIFFEL_LIST [ATOMIC_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

-- TO DO: remove this TE_SEMICOLON (see: INDEX_AS.index_list /= Void)
				yyval72 := ast_factory.new_eiffel_list_atomic_as (0)
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp72 := yyvsp72 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_30 is
			--|#line <not available> "eiffel.y"
		local
			yyval17: ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval17 := yyvs2.item (yyvsp2) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp17 := yyvsp17 + 1
	yyvsp2 := yyvsp2 -1
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
	yyvs17.put (yyval17, yyvsp17)
end
		end

	yy_do_action_31 is
			--|#line <not available> "eiffel.y"
		local
			yyval17: ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval17 := yyvs17.item (yyvsp17) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs17.put (yyval17, yyvsp17)
end
		end

	yy_do_action_32 is
			--|#line <not available> "eiffel.y"
		local
			yyval17: ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval17 := ast_factory.new_custom_attribute_as (yyvs30.item (yyvsp30), Void) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp17 := yyvsp17 + 1
	yyvsp30 := yyvsp30 -1
	yyvsp3 := yyvsp3 -1
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
	yyvs17.put (yyval17, yyvsp17)
end
		end

	yy_do_action_33 is
			--|#line <not available> "eiffel.y"
		local
			yyval17: ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval17 := ast_factory.new_custom_attribute_as (yyvs30.item (yyvsp30), yyvs67.item (yyvsp67)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp17 := yyvsp17 + 1
	yyvsp30 := yyvsp30 -1
	yyvsp67 := yyvsp67 -1
	yyvsp3 := yyvsp3 -1
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
	yyvs17.put (yyval17, yyvsp17)
end
		end

	yy_do_action_34 is
			--|#line <not available> "eiffel.y"
		local
			yyval1: ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				is_deferred := False
				is_expanded := False
				is_separate := False
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_35 is
			--|#line <not available> "eiffel.y"
		local
			yyval1: ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				is_frozen_class := False
				is_deferred := True
				is_expanded := False
				is_separate := False
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp6 := yyvsp6 -1
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_36 is
			--|#line <not available> "eiffel.y"
		local
			yyval1: ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				is_deferred := False
				is_expanded := True
				is_separate := False
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_37 is
			--|#line <not available> "eiffel.y"
		local
			yyval1: ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				is_deferred := False
				is_expanded := False
				is_separate := True
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_38 is
			--|#line <not available> "eiffel.y"
		local
			yyval1: ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				is_frozen_class := False
			
if yy_parsing_status = yyContinue then
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

	yy_do_action_39 is
			--|#line <not available> "eiffel.y"
		local
			yyval1: ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- I'm adding a few comments line
					-- here because otherwise the generated
					-- parser is very different from the
					-- previous one, since line numbers are
					-- emitted.
				is_frozen_class := True
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_40 is
			--|#line <not available> "eiffel.y"
		local
			yyval1: ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				is_external_class := False
			
if yy_parsing_status = yyContinue then
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

	yy_do_action_41 is
			--|#line <not available> "eiffel.y"
		local
			yyval1: ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if il_parser then
					is_external_class := True
				else
						-- Trigger a syntax error.
					raise_error
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_42 is
			--|#line <not available> "eiffel.y"
		local
			yyval65: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
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

	yy_do_action_43 is
			--|#line <not available> "eiffel.y"
		local
			yyval65: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := yyvs65.item (yyvsp65) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs65.put (yyval65, yyvsp65)
end
		end

	yy_do_action_44 is
			--|#line <not available> "eiffel.y"
		local
			yyval80: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp80 := yyvsp80 + 1
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

	yy_do_action_45 is
			--|#line <not available> "eiffel.y"
		local
			yyval80: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval80 := yyvs80.item (yyvsp80)
				if yyval80 /= Void and then yyval80.is_empty then
					yyval80 := Void
				end
				remove_counter
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp80 := yyvsp80 -1
	yyvs80.put (yyval80, yyvsp80)
end
		end

	yy_do_action_46 is
			--|#line <not available> "eiffel.y"
		local
			yyval80: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

add_counter 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp80 := yyvsp80 + 1
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
			--|#line <not available> "eiffel.y"
		local
			yyval80: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval80 := ast_factory.new_eiffel_list_feature_clause_as (counter_value + 1)
				if yyval80 /= Void and yyvs39.item (yyvsp39) /= Void then
					yyval80.reverse_extend (yyvs39.item (yyvsp39))
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp80 := yyvsp80 + 1
	yyvsp39 := yyvsp39 -1
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
			--|#line <not available> "eiffel.y"
		local
			yyval80: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval80 := yyvs80.item (yyvsp80)
				if yyval80 /= Void and yyvs39.item (yyvsp39) /= Void then
					yyval80.reverse_extend (yyvs39.item (yyvsp39))
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp80 := yyvsp80 -1
	yyvsp39 := yyvsp39 -1
	yyvs80.put (yyval80, yyvsp80)
end
		end

	yy_do_action_49 is
			--|#line <not available> "eiffel.y"
		local
			yyval80: EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

increment_counter 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp80 := yyvsp80 + 1
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
			--|#line <not available> "eiffel.y"
		local
			yyval39: FEATURE_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval39 := ast_factory.new_feature_clause_as (yyvs25.item (yyvsp25),
				ast_factory.new_eiffel_list_feature_as (0), fclause_pos) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp39 := yyvsp39 + 1
	yyvsp25 := yyvsp25 -1
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

	yy_do_action_51 is
			--|#line <not available> "eiffel.y"
		local
			yyval39: FEATURE_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval39 := ast_factory.new_feature_clause_as (yyvs25.item (yyvsp25), yyvs79.item (yyvsp79), fclause_pos)
				remove_counter
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp25 := yyvsp25 -1
	yyvsp79 := yyvsp79 -1
	yyvs39.put (yyval39, yyvsp39)
end
		end

	yy_do_action_52 is
			--|#line <not available> "eiffel.y"
		local
			yyval39: FEATURE_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

add_counter 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp39 := yyvsp39 + 1
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

	yy_do_action_53 is
			--|#line <not available> "eiffel.y"
		local
			yyval25: CLIENT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval25 := yyvs25.item (yyvsp25) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp25 := yyvsp25 -1
	yyvsp1 := yyvsp1 -1
	yyvs25.put (yyval25, yyvsp25)
end
		end

	yy_do_action_54 is
			--|#line <not available> "eiffel.y"
		local
			yyval25: CLIENT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				fclause_pos := ast_factory.new_location_as (line, column, position, 8)
			
if yy_parsing_status = yyContinue then
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

	yy_do_action_55 is
			--|#line <not available> "eiffel.y"
		local
			yyval25: CLIENT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
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

	yy_do_action_56 is
			--|#line <not available> "eiffel.y"
		local
			yyval25: CLIENT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval25 := ast_factory.new_client_as (yyvs83.item (yyvsp83)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp25 := yyvsp25 + 1
	yyvsp83 := yyvsp83 -1
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

	yy_do_action_57 is
			--|#line <not available> "eiffel.y"
		local
			yyval83: EIFFEL_LIST [ID_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval83 := ast_factory.new_eiffel_list_id_as (1)
				if yyval83 /= Void then
					yyval83.reverse_extend (new_none_id)
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp83 := yyvsp83 + 1
	yyvsp1 := yyvsp1 -2
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

	yy_do_action_58 is
			--|#line <not available> "eiffel.y"
		local
			yyval83: EIFFEL_LIST [ID_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval83 := yyvs83.item (yyvsp83)
				remove_counter
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp83 := yyvsp83 -1
	yyvsp1 := yyvsp1 -2
	yyvs83.put (yyval83, yyvsp83)
end
		end

	yy_do_action_59 is
			--|#line <not available> "eiffel.y"
		local
			yyval83: EIFFEL_LIST [ID_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

add_counter 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp83 := yyvsp83 + 1
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

	yy_do_action_60 is
			--|#line <not available> "eiffel.y"
		local
			yyval83: EIFFEL_LIST [ID_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval83 := ast_factory.new_eiffel_list_id_as (counter_value + 1)
				if yyval83 /= Void and yyvs2.item (yyvsp2) /= Void then
					yyval83.reverse_extend (yyvs2.item (yyvsp2))
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp83 := yyvsp83 + 1
	yyvsp2 := yyvsp2 -1
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

	yy_do_action_61 is
			--|#line <not available> "eiffel.y"
		local
			yyval83: EIFFEL_LIST [ID_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval83 := yyvs83.item (yyvsp83)
				if yyval83 /= Void and yyvs2.item (yyvsp2) /= Void then
					yyval83.reverse_extend (yyvs2.item (yyvsp2))
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp83 := yyvsp83 -1
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -1
	yyvs83.put (yyval83, yyvsp83)
end
		end

	yy_do_action_62 is
			--|#line <not available> "eiffel.y"
		local
			yyval83: EIFFEL_LIST [ID_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

increment_counter 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp83 := yyvsp83 + 1
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

	yy_do_action_63 is
			--|#line <not available> "eiffel.y"
		local
			yyval79: EIFFEL_LIST [FEATURE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval79 := ast_factory.new_eiffel_list_feature_as (counter_value + 1)
				if yyval79 /= Void and yyvs38.item (yyvsp38) /= Void then
					yyval79.reverse_extend (yyvs38.item (yyvsp38))
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp79 := yyvsp79 + 1
	yyvsp38 := yyvsp38 -1
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

	yy_do_action_64 is
			--|#line <not available> "eiffel.y"
		local
			yyval79: EIFFEL_LIST [FEATURE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval79 := yyvs79.item (yyvsp79)
				if yyval79 /= Void and yyvs38.item (yyvsp38) /= Void then
					yyval79.reverse_extend (yyvs38.item (yyvsp38))
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp79 := yyvsp79 -1
	yyvsp38 := yyvsp38 -1
	yyvs79.put (yyval79, yyvsp79)
end
		end

	yy_do_action_65 is
			--|#line <not available> "eiffel.y"
		local
			yyval79: EIFFEL_LIST [FEATURE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

increment_counter
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp79 := yyvsp79 + 1
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

	yy_do_action_66 is
			--|#line <not available> "eiffel.y"
		local
			yyval1: ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
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

	yy_do_action_67 is
			--|#line <not available> "eiffel.y"
		local
			yyval1: ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_68 is
			--|#line <not available> "eiffel.y"
		local
			yyval38: FEATURE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Generate a syntax error when `feature_indexes' is not
					-- Void and it applies to synonyms of the current feature
					-- declaration.
				if
					(il_parser and feature_indexes /= Void and
					(yyvs81.item (yyvsp81) /= Void and then yyvs81.item (yyvsp81).count /= 1))
				then
					raise_error
				end
				yyval38 := ast_factory.new_feature_as (yyvs81.item (yyvsp81), yyvs20.item (yyvsp20), feature_indexes, position)
				feature_indexes := Void
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp38 := yyvsp38 -1
	yyvsp81 := yyvsp81 -1
	yyvsp20 := yyvsp20 -1
	yyvsp1 := yyvsp1 -1
	yyvs38.put (yyval38, yyvsp38)
end
		end

	yy_do_action_69 is
			--|#line <not available> "eiffel.y"
		local
			yyval38: FEATURE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

add_counter 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp38 := yyvsp38 + 1
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

	yy_do_action_70 is
			--|#line <not available> "eiffel.y"
		local
			yyval38: FEATURE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

remove_counter 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp38 := yyvsp38 + 1
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

	yy_do_action_71 is
			--|#line <not available> "eiffel.y"
		local
			yyval81: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval81 := ast_factory.new_eiffel_list_feature_name (counter_value + 1)
				if yyval81 /= Void and yyvs71.item (yyvsp71) /= Void then
					yyval81.reverse_extend (yyvs71.item (yyvsp71))
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp81 := yyvsp81 + 1
	yyvsp71 := yyvsp71 -1
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

	yy_do_action_72 is
			--|#line <not available> "eiffel.y"
		local
			yyval81: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval81 := yyvs81.item (yyvsp81)
				if yyval81 /= Void and yyvs71.item (yyvsp71) /= Void then
					yyval81.reverse_extend (yyvs71.item (yyvsp71))
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp81 := yyvsp81 -1
	yyvsp71 := yyvsp71 -1
	yyvsp1 := yyvsp1 -1
	yyvs81.put (yyval81, yyvsp81)
end
		end

	yy_do_action_73 is
			--|#line <not available> "eiffel.y"
		local
			yyval81: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

increment_counter 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp81 := yyvsp81 + 1
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

	yy_do_action_74 is
			--|#line <not available> "eiffel.y"
		local
			yyval71: FEATURE_NAME
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval71 := yyvs71.item (yyvsp71) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs71.put (yyval71, yyvsp71)
end
		end

	yy_do_action_75 is
			--|#line <not available> "eiffel.y"
		local
			yyval1: ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

is_frozen := False 
if yy_parsing_status = yyContinue then
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

	yy_do_action_76 is
			--|#line <not available> "eiffel.y"
		local
			yyval1: ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

is_frozen := True 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_77 is
			--|#line <not available> "eiffel.y"
		local
			yyval71: FEATURE_NAME
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval71 := yyvs71.item (yyvsp71) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs71.put (yyval71, yyvsp71)
end
		end

	yy_do_action_78 is
			--|#line <not available> "eiffel.y"
		local
			yyval71: FEATURE_NAME
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval71 := ast_factory.new_feature_name_alias_as (yyvs2.item (yyvsp2), yyvs65.item (yyvsp65), is_frozen, has_convert_mark) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp71 := yyvsp71 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp65 := yyvsp65 -1
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

	yy_do_action_79 is
			--|#line <not available> "eiffel.y"
		local
			yyval71: FEATURE_NAME
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval71 := ast_factory.new_feature_name_id_as (yyvs2.item (yyvsp2), is_frozen) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp71 := yyvsp71 + 1
	yyvsp2 := yyvsp2 -1
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

	yy_do_action_80 is
			--|#line <not available> "eiffel.y"
		local
			yyval71: FEATURE_NAME
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval71 := yyvs71.item (yyvsp71) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs71.put (yyval71, yyvsp71)
end
		end

	yy_do_action_81 is
			--|#line <not available> "eiffel.y"
		local
			yyval71: FEATURE_NAME
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval71 := yyvs71.item (yyvsp71) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs71.put (yyval71, yyvsp71)
end
		end

	yy_do_action_82 is
			--|#line <not available> "eiffel.y"
		local
			yyval71: FEATURE_NAME
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval71 := ast_factory.new_infix_as (yyvs65.item (yyvsp65), is_frozen, yyvs3.item (yyvsp3)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp71 := yyvsp71 + 1
	yyvsp3 := yyvsp3 -1
	yyvsp65 := yyvsp65 -1
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

	yy_do_action_83 is
			--|#line <not available> "eiffel.y"
		local
			yyval71: FEATURE_NAME
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval71 := ast_factory.new_prefix_as (yyvs65.item (yyvsp65), is_frozen, yyvs3.item (yyvsp3)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp71 := yyvsp71 + 1
	yyvsp3 := yyvsp3 -1
	yyvsp65 := yyvsp65 -1
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

	yy_do_action_84 is
			--|#line <not available> "eiffel.y"
		local
			yyval65: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval65 := yyvs65.item (yyvsp65)
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyvs65.put (yyval65, yyvsp65)
end
		end

	yy_do_action_85 is
			--|#line <not available> "eiffel.y"
		local
			yyval65: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := yyvs65.item (yyvsp65) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs65.put (yyval65, yyvsp65)
end
		end

	yy_do_action_86 is
			--|#line <not available> "eiffel.y"
		local
			yyval65: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := new_not_string 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp65 := yyvsp65 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_87 is
			--|#line <not available> "eiffel.y"
		local
			yyval65: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := new_bracket_string 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp65 := yyvsp65 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_88 is
			--|#line <not available> "eiffel.y"
		local
			yyval1: ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

has_convert_mark := False 
if yy_parsing_status = yyContinue then
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

	yy_do_action_89 is
			--|#line <not available> "eiffel.y"
		local
			yyval1: ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

has_convert_mark := True 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_90 is
			--|#line <not available> "eiffel.y"
		local
			yyval20: BODY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Attribute case
				yyval20 := ast_factory.new_body_as (Void, yyvs68.item (yyvsp68), yyvs2.item (yyvsp2), Void)
				feature_indexes := yyvs86.item (yyvsp86)
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp20 := yyvsp20 + 1
	yyvsp1 := yyvsp1 -1
	yyvsp68 := yyvsp68 -1
	yyvsp2 := yyvsp2 -1
	yyvsp86 := yyvsp86 -1
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
	yyvs20.put (yyval20, yyvsp20)
end
		end

	yy_do_action_91 is
			--|#line <not available> "eiffel.y"
		local
			yyval20: BODY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Constant case
				yyval20 := ast_factory.new_body_as (Void, yyvs68.item (yyvsp68), yyvs2.item (yyvsp2), yyvs26.item (yyvsp26))
				feature_indexes := yyvs86.item (yyvsp86)
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp20 := yyvsp20 + 1
	yyvsp1 := yyvsp1 -2
	yyvsp68 := yyvsp68 -1
	yyvsp2 := yyvsp2 -1
	yyvsp26 := yyvsp26 -1
	yyvsp86 := yyvsp86 -1
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
	yyvs20.put (yyval20, yyvsp20)
end
		end

	yy_do_action_92 is
			--|#line <not available> "eiffel.y"
		local
			yyval20: BODY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- procedure without arguments
				yyval20 := ast_factory.new_body_as (Void, Void, Void, yyvs62.item (yyvsp62))
				feature_indexes := yyvs86.item (yyvsp86)
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp20 := yyvsp20 + 1
	yyvsp1 := yyvsp1 -1
	yyvsp86 := yyvsp86 -1
	yyvsp62 := yyvsp62 -1
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
	yyvs20.put (yyval20, yyvsp20)
end
		end

	yy_do_action_93 is
			--|#line <not available> "eiffel.y"
		local
			yyval20: BODY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Function without arguments
				yyval20 := ast_factory.new_body_as (Void, yyvs68.item (yyvsp68), yyvs2.item (yyvsp2), yyvs62.item (yyvsp62))
				feature_indexes := yyvs86.item (yyvsp86)
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp20 := yyvsp20 + 1
	yyvsp1 := yyvsp1 -2
	yyvsp68 := yyvsp68 -1
	yyvsp2 := yyvsp2 -1
	yyvsp86 := yyvsp86 -1
	yyvsp62 := yyvsp62 -1
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
	yyvs20.put (yyval20, yyvsp20)
end
		end

	yy_do_action_94 is
			--|#line <not available> "eiffel.y"
		local
			yyval20: BODY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- procedure with arguments
				yyval20 := ast_factory.new_body_as (yyvs95.item (yyvsp95), Void, Void, yyvs62.item (yyvsp62))
				feature_indexes := yyvs86.item (yyvsp86)
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp20 := yyvsp20 + 1
	yyvsp95 := yyvsp95 -1
	yyvsp1 := yyvsp1 -1
	yyvsp86 := yyvsp86 -1
	yyvsp62 := yyvsp62 -1
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
	yyvs20.put (yyval20, yyvsp20)
end
		end

	yy_do_action_95 is
			--|#line <not available> "eiffel.y"
		local
			yyval20: BODY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Function with arguments
				yyval20 := ast_factory.new_body_as (yyvs95.item (yyvsp95), yyvs68.item (yyvsp68), yyvs2.item (yyvsp2), yyvs62.item (yyvsp62))
				feature_indexes := yyvs86.item (yyvsp86)
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 7
	yyvsp20 := yyvsp20 + 1
	yyvsp95 := yyvsp95 -1
	yyvsp1 := yyvsp1 -2
	yyvsp68 := yyvsp68 -1
	yyvsp2 := yyvsp2 -1
	yyvsp86 := yyvsp86 -1
	yyvsp62 := yyvsp62 -1
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
	yyvs20.put (yyval20, yyvsp20)
end
		end

	yy_do_action_96 is
			--|#line <not available> "eiffel.y"
		local
			yyval2: ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
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

	yy_do_action_97 is
			--|#line <not available> "eiffel.y"
		local
			yyval2: ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval2 := yyvs2.item (yyvsp2) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs2.put (yyval2, yyvsp2)
end
		end

	yy_do_action_98 is
			--|#line <not available> "eiffel.y"
		local
			yyval26: CONSTANT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval26 := ast_factory.new_constant_as (yyvs17.item (yyvsp17)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp26 := yyvsp26 + 1
	yyvsp17 := yyvsp17 -1
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

	yy_do_action_99 is
			--|#line <not available> "eiffel.y"
		local
			yyval26: CONSTANT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval26 := ast_factory.new_constant_as (yyvs9.item (yyvsp9)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp26 := yyvsp26 + 1
	yyvsp9 := yyvsp9 -1
	yyvsp86 := yyvsp86 -1
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

	yy_do_action_100 is
			--|#line <not available> "eiffel.y"
		local
			yyval90: EIFFEL_LIST [PARENT_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp90 := yyvsp90 + 1
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

	yy_do_action_101 is
			--|#line <not available> "eiffel.y"
		local
			yyval90: EIFFEL_LIST [PARENT_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (line, column, filename,
						"Use `inherit ANY' or do not specify an empty inherit clause"))
				end
				yyval90 := Void
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp90 := yyvsp90 + 1
	yyvsp1 := yyvsp1 -2
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

	yy_do_action_102 is
			--|#line <not available> "eiffel.y"
		local
			yyval90: EIFFEL_LIST [PARENT_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval90 := yyvs90.item (yyvsp90)
				remove_counter
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp90 := yyvsp90 -1
	yyvsp1 := yyvsp1 -1
	yyvs90.put (yyval90, yyvsp90)
end
		end

	yy_do_action_103 is
			--|#line <not available> "eiffel.y"
		local
			yyval90: EIFFEL_LIST [PARENT_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

add_counter 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp90 := yyvsp90 + 1
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

	yy_do_action_104 is
			--|#line <not available> "eiffel.y"
		local
			yyval90: EIFFEL_LIST [PARENT_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval90 := ast_factory.new_eiffel_list_parent_as (counter_value + 1)
				if yyval90 /= Void and yyvs54.item (yyvsp54) /= Void then
					yyval90.reverse_extend (yyvs54.item (yyvsp54))
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp90 := yyvsp90 + 1
	yyvsp54 := yyvsp54 -1
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

	yy_do_action_105 is
			--|#line <not available> "eiffel.y"
		local
			yyval90: EIFFEL_LIST [PARENT_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval90 := yyvs90.item (yyvsp90)
				if yyval90 /= Void and yyvs54.item (yyvsp54) /= Void then
					yyval90.reverse_extend (yyvs54.item (yyvsp54))
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp90 := yyvsp90 -1
	yyvsp54 := yyvsp54 -1
	yyvs90.put (yyval90, yyvsp90)
end
		end

	yy_do_action_106 is
			--|#line <not available> "eiffel.y"
		local
			yyval90: EIFFEL_LIST [PARENT_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

increment_counter 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp90 := yyvsp90 + 1
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

	yy_do_action_107 is
			--|#line <not available> "eiffel.y"
		local
			yyval54: PARENT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval54 := yyvs54.item (yyvsp54)
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs54.put (yyval54, yyvsp54)
end
		end

	yy_do_action_108 is
			--|#line <not available> "eiffel.y"
		local
			yyval54: PARENT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval54 := yyvs54.item (yyvsp54)
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs54.put (yyval54, yyvsp54)
end
		end

	yy_do_action_109 is
			--|#line <not available> "eiffel.y"
		local
			yyval54: PARENT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval54 := ast_factory.new_parent_as (ast_factory.new_class_type_as (yyvs2.item (yyvsp2), yyvs94.item (yyvsp94), False, False), Void, Void, Void, Void, Void, Void)
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp54 := yyvsp54 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp94 := yyvsp94 -1
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

	yy_do_action_110 is
			--|#line <not available> "eiffel.y"
		local
			yyval54: PARENT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval54 := ast_factory.new_parent_as (ast_factory.new_class_type_as (yyvs2.item (yyvsp2), yyvs94.item (yyvsp94), False, False), yyvs91.item (yyvsp91), yyvs77.item (yyvsp77), yyvs81.item (yyvsp81 - 2), yyvs81.item (yyvsp81 - 1), yyvs81.item (yyvsp81), yyvs3.item (yyvsp3))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 8
	yyvsp54 := yyvsp54 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp94 := yyvsp94 -1
	yyvsp91 := yyvsp91 -1
	yyvsp77 := yyvsp77 -1
	yyvsp81 := yyvsp81 -3
	yyvsp3 := yyvsp3 -1
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

	yy_do_action_111 is
			--|#line <not available> "eiffel.y"
		local
			yyval54: PARENT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval54 := ast_factory.new_parent_as (ast_factory.new_class_type_as (yyvs2.item (yyvsp2), yyvs94.item (yyvsp94), False, False), Void, yyvs77.item (yyvsp77), yyvs81.item (yyvsp81 - 2), yyvs81.item (yyvsp81 - 1), yyvs81.item (yyvsp81), yyvs3.item (yyvsp3))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 7
	yyvsp54 := yyvsp54 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp94 := yyvsp94 -1
	yyvsp77 := yyvsp77 -1
	yyvsp81 := yyvsp81 -3
	yyvsp3 := yyvsp3 -1
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

	yy_do_action_112 is
			--|#line <not available> "eiffel.y"
		local
			yyval54: PARENT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval54 := ast_factory.new_parent_as (ast_factory.new_class_type_as (yyvs2.item (yyvsp2), yyvs94.item (yyvsp94), False, False), Void, Void, yyvs81.item (yyvsp81 - 2), yyvs81.item (yyvsp81 - 1), yyvs81.item (yyvsp81), yyvs3.item (yyvsp3))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp54 := yyvsp54 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp94 := yyvsp94 -1
	yyvsp81 := yyvsp81 -3
	yyvsp3 := yyvsp3 -1
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

	yy_do_action_113 is
			--|#line <not available> "eiffel.y"
		local
			yyval54: PARENT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval54 := ast_factory.new_parent_as (ast_factory.new_class_type_as (yyvs2.item (yyvsp2), yyvs94.item (yyvsp94), False, False), Void, Void, Void, yyvs81.item (yyvsp81 - 1), yyvs81.item (yyvsp81), yyvs3.item (yyvsp3))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp54 := yyvsp54 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp94 := yyvsp94 -1
	yyvsp81 := yyvsp81 -2
	yyvsp3 := yyvsp3 -1
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

	yy_do_action_114 is
			--|#line <not available> "eiffel.y"
		local
			yyval54: PARENT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval54 := ast_factory.new_parent_as (ast_factory.new_class_type_as (yyvs2.item (yyvsp2), yyvs94.item (yyvsp94), False, False), Void, Void, Void, Void, yyvs81.item (yyvsp81), yyvs3.item (yyvsp3))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp54 := yyvsp54 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp94 := yyvsp94 -1
	yyvsp81 := yyvsp81 -1
	yyvsp3 := yyvsp3 -1
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

	yy_do_action_115 is
			--|#line <not available> "eiffel.y"
		local
			yyval91: EIFFEL_LIST [RENAME_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp91 := yyvsp91 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_116 is
			--|#line <not available> "eiffel.y"
		local
			yyval91: EIFFEL_LIST [RENAME_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval91 := yyvs91.item (yyvsp91)
				remove_counter
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp91 := yyvsp91 -1
	yyvsp1 := yyvsp1 -1
	yyvs91.put (yyval91, yyvsp91)
end
		end

	yy_do_action_117 is
			--|#line <not available> "eiffel.y"
		local
			yyval91: EIFFEL_LIST [RENAME_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

add_counter 
if yy_parsing_status = yyContinue then
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

	yy_do_action_118 is
			--|#line <not available> "eiffel.y"
		local
			yyval91: EIFFEL_LIST [RENAME_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval91 := ast_factory.new_eiffel_list_rename_as (counter_value + 1)
				if yyval91 /= Void and yyvs58.item (yyvsp58) /= Void then
					yyval91.reverse_extend (yyvs58.item (yyvsp58))
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp91 := yyvsp91 + 1
	yyvsp58 := yyvsp58 -1
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

	yy_do_action_119 is
			--|#line <not available> "eiffel.y"
		local
			yyval91: EIFFEL_LIST [RENAME_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval91 := yyvs91.item (yyvsp91)
				if yyval91 /= Void and yyvs58.item (yyvsp58) /= Void then
					yyval91.reverse_extend (yyvs58.item (yyvsp58))
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp91 := yyvsp91 -1
	yyvsp58 := yyvsp58 -1
	yyvsp1 := yyvsp1 -1
	yyvs91.put (yyval91, yyvsp91)
end
		end

	yy_do_action_120 is
			--|#line <not available> "eiffel.y"
		local
			yyval91: EIFFEL_LIST [RENAME_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

increment_counter 
if yy_parsing_status = yyContinue then
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

	yy_do_action_121 is
			--|#line <not available> "eiffel.y"
		local
			yyval58: RENAME_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval58 := ast_factory.new_rename_as (yyvs71.item (yyvsp71 - 1), yyvs71.item (yyvsp71)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp58 := yyvsp58 + 1
	yyvsp71 := yyvsp71 -2
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_122 is
			--|#line <not available> "eiffel.y"
		local
			yyval77: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp77 := yyvsp77 + 1
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

	yy_do_action_123 is
			--|#line <not available> "eiffel.y"
		local
			yyval77: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval77 := yyvs77.item (yyvsp77) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs77.put (yyval77, yyvsp77)
end
		end

	yy_do_action_124 is
			--|#line <not available> "eiffel.y"
		local
			yyval77: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if yyvs77.item (yyvsp77) /= Void and then yyvs77.item (yyvsp77).is_empty then
					yyval77 := Void
				else
					yyval77 := yyvs77.item (yyvsp77)
				end
				remove_counter
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp77 := yyvsp77 -1
	yyvsp1 := yyvsp1 -1
	yyvs77.put (yyval77, yyvsp77)
end
		end

	yy_do_action_125 is
			--|#line <not available> "eiffel.y"
		local
			yyval77: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

add_counter 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp77 := yyvsp77 + 1
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

	yy_do_action_126 is
			--|#line <not available> "eiffel.y"
		local
			yyval77: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp77 := yyvsp77 + 1
	yyvsp1 := yyvsp1 -2
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

	yy_do_action_127 is
			--|#line <not available> "eiffel.y"
		local
			yyval77: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval77 := ast_factory.new_eiffel_list_export_item_as (counter_value + 1)
				if yyval77 /= Void and yyvs34.item (yyvsp34) /= Void then
					yyval77.reverse_extend (yyvs34.item (yyvsp34))
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp77 := yyvsp77 + 1
	yyvsp34 := yyvsp34 -1
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

	yy_do_action_128 is
			--|#line <not available> "eiffel.y"
		local
			yyval77: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval77 := yyvs77.item (yyvsp77)
				if yyval77 /= Void and yyvs34.item (yyvsp34) /= Void then
					yyval77.reverse_extend (yyvs34.item (yyvsp34))
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp77 := yyvsp77 -1
	yyvsp34 := yyvsp34 -1
	yyvs77.put (yyval77, yyvsp77)
end
		end

	yy_do_action_129 is
			--|#line <not available> "eiffel.y"
		local
			yyval77: EIFFEL_LIST [EXPORT_ITEM_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

increment_counter 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp77 := yyvsp77 + 1
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

	yy_do_action_130 is
			--|#line <not available> "eiffel.y"
		local
			yyval34: EXPORT_ITEM_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if yyvs40.item (yyvsp40) /= Void then
					yyval34 := ast_factory.new_export_item_as (ast_factory.new_client_as (yyvs83.item (yyvsp83)), yyvs40.item (yyvsp40))
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp34 := yyvsp34 + 1
	yyvsp83 := yyvsp83 -1
	yyvsp40 := yyvsp40 -1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_131 is
			--|#line <not available> "eiffel.y"
		local
			yyval40: FEATURE_SET_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp40 := yyvsp40 + 1
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

	yy_do_action_132 is
			--|#line <not available> "eiffel.y"
		local
			yyval40: FEATURE_SET_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval40 := ast_factory.new_all_as 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp40 := yyvsp40 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_133 is
			--|#line <not available> "eiffel.y"
		local
			yyval40: FEATURE_SET_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval40 := ast_factory.new_feature_list_as (yyvs81.item (yyvsp81)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp40 := yyvsp40 + 1
	yyvsp81 := yyvsp81 -1
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

	yy_do_action_134 is
			--|#line <not available> "eiffel.y"
		local
			yyval74: EIFFEL_LIST [CONVERT_FEAT_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp74 := yyvsp74 + 1
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

	yy_do_action_135 is
			--|#line <not available> "eiffel.y"
		local
			yyval74: EIFFEL_LIST [CONVERT_FEAT_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			yyval74 := yyvs74.item (yyvsp74)
			remove_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp74 := yyvsp74 -1
	yyvsp1 := yyvsp1 -1
	yyvs74.put (yyval74, yyvsp74)
end
		end

	yy_do_action_136 is
			--|#line <not available> "eiffel.y"
		local
			yyval74: EIFFEL_LIST [CONVERT_FEAT_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

add_counter 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp74 := yyvsp74 + 1
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

	yy_do_action_137 is
			--|#line <not available> "eiffel.y"
		local
			yyval74: EIFFEL_LIST [CONVERT_FEAT_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			yyval74 := ast_factory.new_eiffel_list_convert (counter_value + 1)
			if yyval74 /= Void and yyvs27.item (yyvsp27) /= Void then
				yyval74.reverse_extend (yyvs27.item (yyvsp27))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp74 := yyvsp74 + 1
	yyvsp27 := yyvsp27 -1
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

	yy_do_action_138 is
			--|#line <not available> "eiffel.y"
		local
			yyval74: EIFFEL_LIST [CONVERT_FEAT_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			yyval74 := yyvs74.item (yyvsp74)
			if yyval74 /= Void and yyvs27.item (yyvsp27) /= Void then
				yyval74.reverse_extend (yyvs27.item (yyvsp27))
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp74 := yyvsp74 -1
	yyvsp27 := yyvsp27 -1
	yyvsp1 := yyvsp1 -1
	yyvs74.put (yyval74, yyvsp74)
end
		end

	yy_do_action_139 is
			--|#line <not available> "eiffel.y"
		local
			yyval74: EIFFEL_LIST [CONVERT_FEAT_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

increment_counter 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp74 := yyvsp74 + 1
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

	yy_do_action_140 is
			--|#line <not available> "eiffel.y"
		local
			yyval27: CONVERT_FEAT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				-- True because this is a conversion feature used as a creation
				-- procedure in current class.
			yyval27 := ast_factory.new_convert_feat_as (True, yyvs71.item (yyvsp71), yyvs94.item (yyvsp94))
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp27 := yyvsp27 + 1
	yyvsp71 := yyvsp71 -1
	yyvsp1 := yyvsp1 -4
	yyvsp94 := yyvsp94 -1
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

	yy_do_action_141 is
			--|#line <not available> "eiffel.y"
		local
			yyval27: CONVERT_FEAT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				-- False because this is not a conversion feature used as a creation
				-- procedure.
			yyval27 := ast_factory.new_convert_feat_as (False, yyvs71.item (yyvsp71), yyvs94.item (yyvsp94))
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp27 := yyvsp27 + 1
	yyvsp71 := yyvsp71 -1
	yyvsp1 := yyvsp1 -3
	yyvsp94 := yyvsp94 -1
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

	yy_do_action_142 is
			--|#line <not available> "eiffel.y"
		local
			yyval81: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			yyval81 := yyvs81.item (yyvsp81)
			remove_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp81 := yyvsp81 -1
	yyvs81.put (yyval81, yyvsp81)
end
		end

	yy_do_action_143 is
			--|#line <not available> "eiffel.y"
		local
			yyval81: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

add_counter 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp81 := yyvsp81 + 1
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

	yy_do_action_144 is
			--|#line <not available> "eiffel.y"
		local
			yyval81: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval81 := ast_factory.new_eiffel_list_feature_name (counter_value + 1)
				if yyval81 /= Void and yyvs71.item (yyvsp71) /= Void then
					yyval81.reverse_extend (yyvs71.item (yyvsp71))
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp81 := yyvsp81 + 1
	yyvsp71 := yyvsp71 -1
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

	yy_do_action_145 is
			--|#line <not available> "eiffel.y"
		local
			yyval81: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval81 := yyvs81.item (yyvsp81)
				if yyval81 /= Void and yyvs71.item (yyvsp71) /= Void then
					yyval81.reverse_extend (yyvs71.item (yyvsp71))
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp81 := yyvsp81 -1
	yyvsp71 := yyvsp71 -1
	yyvsp1 := yyvsp1 -1
	yyvs81.put (yyval81, yyvsp81)
end
		end

	yy_do_action_146 is
			--|#line <not available> "eiffel.y"
		local
			yyval81: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

increment_counter 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp81 := yyvsp81 + 1
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

	yy_do_action_147 is
			--|#line <not available> "eiffel.y"
		local
			yyval81: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp81 := yyvsp81 + 1
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

	yy_do_action_148 is
			--|#line <not available> "eiffel.y"
		local
			yyval81: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval81 := yyvs81.item (yyvsp81) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs81.put (yyval81, yyvsp81)
end
		end

	yy_do_action_149 is
			--|#line <not available> "eiffel.y"
		local
			yyval81: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp81 := yyvsp81 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_150 is
			--|#line <not available> "eiffel.y"
		local
			yyval81: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval81 := yyvs81.item (yyvsp81) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs81.put (yyval81, yyvsp81)
end
		end

	yy_do_action_151 is
			--|#line <not available> "eiffel.y"
		local
			yyval81: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp81 := yyvsp81 + 1
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

	yy_do_action_152 is
			--|#line <not available> "eiffel.y"
		local
			yyval81: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval81 := yyvs81.item (yyvsp81) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs81.put (yyval81, yyvsp81)
end
		end

	yy_do_action_153 is
			--|#line <not available> "eiffel.y"
		local
			yyval81: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp81 := yyvsp81 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_154 is
			--|#line <not available> "eiffel.y"
		local
			yyval81: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval81 := yyvs81.item (yyvsp81) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs81.put (yyval81, yyvsp81)
end
		end

	yy_do_action_155 is
			--|#line <not available> "eiffel.y"
		local
			yyval81: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp81 := yyvsp81 + 1
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

	yy_do_action_156 is
			--|#line <not available> "eiffel.y"
		local
			yyval81: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval81 := yyvs81.item (yyvsp81) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs81.put (yyval81, yyvsp81)
end
		end

	yy_do_action_157 is
			--|#line <not available> "eiffel.y"
		local
			yyval81: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp81 := yyvsp81 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_158 is
			--|#line <not available> "eiffel.y"
		local
			yyval81: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval81 := yyvs81.item (yyvsp81) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs81.put (yyval81, yyvsp81)
end
		end

	yy_do_action_159 is
			--|#line <not available> "eiffel.y"
		local
			yyval95: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp95 := yyvsp95 + 1
	yyvsp1 := yyvsp1 -2
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

	yy_do_action_160 is
			--|#line <not available> "eiffel.y"
		local
			yyval95: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval95 := yyvs95.item (yyvsp95)
				remove_counter
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp95 := yyvsp95 -1
	yyvsp1 := yyvsp1 -2
	yyvs95.put (yyval95, yyvsp95)
end
		end

	yy_do_action_161 is
			--|#line <not available> "eiffel.y"
		local
			yyval95: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

add_counter 
if yy_parsing_status = yyContinue then
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

	yy_do_action_162 is
			--|#line <not available> "eiffel.y"
		local
			yyval95: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval95 := ast_factory.new_eiffel_list_type_dec_as (counter_value + 1)
				if yyval95 /= Void and yyvs69.item (yyvsp69) /= Void then
					yyval95.reverse_extend (yyvs69.item (yyvsp69))
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp95 := yyvsp95 + 1
	yyvsp69 := yyvsp69 -1
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

	yy_do_action_163 is
			--|#line <not available> "eiffel.y"
		local
			yyval95: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval95 := yyvs95.item (yyvsp95)
				if yyval95 /= Void and yyvs69.item (yyvsp69) /= Void then
					yyval95.reverse_extend (yyvs69.item (yyvsp69))
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp95 := yyvsp95 -1
	yyvsp69 := yyvsp69 -1
	yyvs95.put (yyval95, yyvsp95)
end
		end

	yy_do_action_164 is
			--|#line <not available> "eiffel.y"
		local
			yyval95: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

increment_counter 
if yy_parsing_status = yyContinue then
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

	yy_do_action_165 is
			--|#line <not available> "eiffel.y"
		local
			yyval69: TYPE_DEC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval69 := ast_factory.new_type_dec_as (yyvs85.item (yyvsp85), yyvs68.item (yyvsp68)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp69 := yyvsp69 -1
	yyvsp85 := yyvsp85 -1
	yyvsp1 := yyvsp1 -2
	yyvsp68 := yyvsp68 -1
	yyvs69.put (yyval69, yyvsp69)
end
		end

	yy_do_action_166 is
			--|#line <not available> "eiffel.y"
		local
			yyval69: TYPE_DEC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

add_counter 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp69 := yyvsp69 + 1
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

	yy_do_action_167 is
			--|#line <not available> "eiffel.y"
		local
			yyval69: TYPE_DEC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

remove_counter 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp69 := yyvsp69 + 1
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

	yy_do_action_168 is
			--|#line <not available> "eiffel.y"
		local
			yyval85: CONSTRUCT_LIST [INTEGER]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval85 := ast_factory.new_identifier_list (counter_value + 1)
				if yyval85 /= Void and yyvs2.item (yyvsp2) /= Void then
					Names_heap.put (yyvs2.item (yyvsp2))
					yyval85.reverse_extend (Names_heap.found_item)
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp85 := yyvsp85 + 1
	yyvsp2 := yyvsp2 -1
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

	yy_do_action_169 is
			--|#line <not available> "eiffel.y"
		local
			yyval85: CONSTRUCT_LIST [INTEGER]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval85 := yyvs85.item (yyvsp85)
				if yyval85 /= Void and yyvs2.item (yyvsp2) /= Void then
					Names_heap.put (yyvs2.item (yyvsp2))
					yyval85.reverse_extend (Names_heap.found_item)
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp85 := yyvsp85 -1
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -1
	yyvs85.put (yyval85, yyvsp85)
end
		end

	yy_do_action_170 is
			--|#line <not available> "eiffel.y"
		local
			yyval85: CONSTRUCT_LIST [INTEGER]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

increment_counter 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp85 := yyvsp85 + 1
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

	yy_do_action_171 is
			--|#line <not available> "eiffel.y"
		local
			yyval85: CONSTRUCT_LIST [INTEGER]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval85 := ast_factory.new_identifier_list (0) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp85 := yyvsp85 + 1
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

	yy_do_action_172 is
			--|#line <not available> "eiffel.y"
		local
			yyval85: CONSTRUCT_LIST [INTEGER]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval85 := yyvs85.item (yyvsp85)
				remove_counter
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp85 := yyvsp85 -1
	yyvs85.put (yyval85, yyvsp85)
end
		end

	yy_do_action_173 is
			--|#line <not available> "eiffel.y"
		local
			yyval85: CONSTRUCT_LIST [INTEGER]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

add_counter 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp85 := yyvsp85 + 1
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

	yy_do_action_174 is
			--|#line <not available> "eiffel.y"
		local
			yyval62: ROUTINE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval62 := ast_factory.new_routine_as (yyvs65.item (yyvsp65), yyvs59.item (yyvsp59), yyvs95.item (yyvsp95), yyvs61.item (yyvsp61), yyvs33.item (yyvsp33), yyvs87.item (yyvsp87), yyvs3.item (yyvsp3), once_manifest_string_count)
				once_manifest_string_count := 0
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 7
	yyvsp62 := yyvsp62 + 1
	yyvsp65 := yyvsp65 -1
	yyvsp59 := yyvsp59 -1
	yyvsp95 := yyvsp95 -1
	yyvsp61 := yyvsp61 -1
	yyvsp33 := yyvsp33 -1
	yyvsp87 := yyvsp87 -1
	yyvsp3 := yyvsp3 -1
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

	yy_do_action_175 is
			--|#line <not available> "eiffel.y"
		local
			yyval61: ROUT_BODY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval61 := yyvs48.item (yyvsp48) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp61 := yyvsp61 + 1
	yyvsp48 := yyvsp48 -1
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
			--|#line <not available> "eiffel.y"
		local
			yyval61: ROUT_BODY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval61 := yyvs36.item (yyvsp36) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp61 := yyvsp61 + 1
	yyvsp36 := yyvsp36 -1
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
			--|#line <not available> "eiffel.y"
		local
			yyval61: ROUT_BODY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval61 := yyvs6.item (yyvsp6) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp61 := yyvsp61 + 1
	yyvsp6 := yyvsp6 -1
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

	yy_do_action_178 is
			--|#line <not available> "eiffel.y"
		local
			yyval36: EXTERNAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval36 := ast_factory.new_external_as (yyvs37.item (yyvsp37), yyvs65.item (yyvsp65))
				has_externals := True
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp36 := yyvsp36 + 1
	yyvsp1 := yyvsp1 -1
	yyvsp37 := yyvsp37 -1
	yyvsp65 := yyvsp65 -1
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

	yy_do_action_179 is
			--|#line <not available> "eiffel.y"
		local
			yyval37: EXTERNAL_LANG_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval37 := ast_factory.new_external_lang_as (yyvs65.item (yyvsp65)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp37 := yyvsp37 + 1
	yyvsp65 := yyvsp65 -1
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

	yy_do_action_180 is
			--|#line <not available> "eiffel.y"
		local
			yyval65: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
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

	yy_do_action_181 is
			--|#line <not available> "eiffel.y"
		local
			yyval65: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := yyvs65.item (yyvsp65) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs65.put (yyval65, yyvsp65)
end
		end

	yy_do_action_182 is
			--|#line <not available> "eiffel.y"
		local
			yyval48: INTERNAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := ast_factory.new_do_as (yyvs87.item (yyvsp87)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp48 := yyvsp48 + 1
	yyvsp1 := yyvsp1 -1
	yyvsp87 := yyvsp87 -1
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

	yy_do_action_183 is
			--|#line <not available> "eiffel.y"
		local
			yyval48: INTERNAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := ast_factory.new_once_as (yyvs87.item (yyvsp87)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp48 := yyvsp48 + 1
	yyvsp1 := yyvsp1 -1
	yyvsp87 := yyvsp87 -1
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

	yy_do_action_184 is
			--|#line <not available> "eiffel.y"
		local
			yyval95: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
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

	yy_do_action_185 is
			--|#line <not available> "eiffel.y"
		local
			yyval95: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval95 := ast_factory.new_eiffel_list_type_dec_as (0) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp95 := yyvsp95 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_186 is
			--|#line <not available> "eiffel.y"
		local
			yyval95: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval95 := yyvs95.item (yyvsp95)
				remove_counter
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp95 := yyvsp95 -1
	yyvsp1 := yyvsp1 -1
	yyvs95.put (yyval95, yyvsp95)
end
		end

	yy_do_action_187 is
			--|#line <not available> "eiffel.y"
		local
			yyval95: EIFFEL_LIST [TYPE_DEC_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

add_counter 
if yy_parsing_status = yyContinue then
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

	yy_do_action_188 is
			--|#line <not available> "eiffel.y"
		local
			yyval87: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp87 := yyvsp87 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_189 is
			--|#line <not available> "eiffel.y"
		local
			yyval87: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval87 := yyvs87.item (yyvsp87)
				remove_counter
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp87 := yyvsp87 -1
	yyvsp1 := yyvsp1 -1
	yyvs87.put (yyval87, yyvsp87)
end
		end

	yy_do_action_190 is
			--|#line <not available> "eiffel.y"
		local
			yyval87: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

add_counter 
if yy_parsing_status = yyContinue then
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

	yy_do_action_191 is
			--|#line <not available> "eiffel.y"
		local
			yyval87: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval87 := ast_factory.new_eiffel_list_instruction_as (counter_value + 1)
				if yyval87 /= Void and yyvs46.item (yyvsp46) /= Void then
					yyval87.reverse_extend (yyvs46.item (yyvsp46))
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp87 := yyvsp87 + 1
	yyvsp46 := yyvsp46 -1
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

	yy_do_action_192 is
			--|#line <not available> "eiffel.y"
		local
			yyval87: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval87 := yyvs87.item (yyvsp87)
				if yyval87 /= Void and yyvs46.item (yyvsp46) /= Void then
					yyval87.reverse_extend (yyvs46.item (yyvsp46))
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp87 := yyvsp87 -1
	yyvsp46 := yyvsp46 -1
	yyvs87.put (yyval87, yyvsp87)
end
		end

	yy_do_action_193 is
			--|#line <not available> "eiffel.y"
		local
			yyval87: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

increment_counter 
if yy_parsing_status = yyContinue then
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
			--|#line <not available> "eiffel.y"
		local
			yyval46: INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval46 := yyvs46.item (yyvsp46) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs46.put (yyval46, yyvsp46)
end
		end

	yy_do_action_195 is
			--|#line <not available> "eiffel.y"
		local
			yyval1: ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
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

	yy_do_action_196 is
			--|#line <not available> "eiffel.y"
		local
			yyval1: ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs1.put (yyval1, yyvsp1)
end
		end

	yy_do_action_197 is
			--|#line <not available> "eiffel.y"
		local
			yyval46: INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval46 := yyvs29.item (yyvsp29) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp46 := yyvsp46 + 1
	yyvsp29 := yyvsp29 -1
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

	yy_do_action_198 is
			--|#line <not available> "eiffel.y"
		local
			yyval46: INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Call production should be used instead,
					-- but this complicates the grammar.
				yyval46 := new_call_instruction_from_expression (yyvs35.item (yyvsp35))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp46 := yyvsp46 + 1
	yyvsp35 := yyvsp35 -1
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

	yy_do_action_199 is
			--|#line <not available> "eiffel.y"
		local
			yyval46: INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval46 := yyvs16.item (yyvsp16) 
if yy_parsing_status = yyContinue then
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

	yy_do_action_200 is
			--|#line <not available> "eiffel.y"
		local
			yyval46: INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval46 := yyvs15.item (yyvsp15) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp46 := yyvsp46 + 1
	yyvsp15 := yyvsp15 -1
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

	yy_do_action_201 is
			--|#line <not available> "eiffel.y"
		local
			yyval46: INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval46 := yyvs60.item (yyvsp60) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp46 := yyvsp46 + 1
	yyvsp60 := yyvsp60 -1
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

	yy_do_action_202 is
			--|#line <not available> "eiffel.y"
		local
			yyval46: INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval46 := yyvs43.item (yyvsp43) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp46 := yyvsp46 + 1
	yyvsp43 := yyvsp43 -1
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

	yy_do_action_203 is
			--|#line <not available> "eiffel.y"
		local
			yyval46: INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval46 := yyvs45.item (yyvsp45) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp46 := yyvsp46 + 1
	yyvsp45 := yyvsp45 -1
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

	yy_do_action_204 is
			--|#line <not available> "eiffel.y"
		local
			yyval46: INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval46 := yyvs51.item (yyvsp51) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp46 := yyvsp46 + 1
	yyvsp51 := yyvsp51 -1
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

	yy_do_action_205 is
			--|#line <not available> "eiffel.y"
		local
			yyval46: INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval46 := yyvs31.item (yyvsp31) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp46 := yyvsp46 + 1
	yyvsp31 := yyvsp31 -1
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

	yy_do_action_206 is
			--|#line <not available> "eiffel.y"
		local
			yyval46: INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval46 := yyvs24.item (yyvsp24) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp46 := yyvsp46 + 1
	yyvsp24 := yyvsp24 -1
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

	yy_do_action_207 is
			--|#line <not available> "eiffel.y"
		local
			yyval46: INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval46 := yyvs8.item (yyvsp8) 
if yy_parsing_status = yyContinue then
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

	yy_do_action_208 is
			--|#line <not available> "eiffel.y"
		local
			yyval59: REQUIRE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp59 := yyvsp59 + 1
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

	yy_do_action_209 is
			--|#line <not available> "eiffel.y"
		local
			yyval59: REQUIRE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				id_level := Normal_level
				yyval59 := ast_factory.new_require_as (yyvs93.item (yyvsp93))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp93 := yyvsp93 -1
	yyvs59.put (yyval59, yyvsp59)
end
		end

	yy_do_action_210 is
			--|#line <not available> "eiffel.y"
		local
			yyval59: REQUIRE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

id_level := Assert_level 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp59 := yyvsp59 + 1
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

	yy_do_action_211 is
			--|#line <not available> "eiffel.y"
		local
			yyval59: REQUIRE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				id_level := Normal_level
				yyval59 := ast_factory.new_require_else_as (yyvs93.item (yyvsp93))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp1 := yyvsp1 -2
	yyvsp93 := yyvsp93 -1
	yyvs59.put (yyval59, yyvsp59)
end
		end

	yy_do_action_212 is
			--|#line <not available> "eiffel.y"
		local
			yyval59: REQUIRE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

id_level := Assert_level 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp59 := yyvsp59 + 1
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

	yy_do_action_213 is
			--|#line <not available> "eiffel.y"
		local
			yyval33: ENSURE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
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

	yy_do_action_214 is
			--|#line <not available> "eiffel.y"
		local
			yyval33: ENSURE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				id_level := Normal_level
				yyval33 := ast_factory.new_ensure_as (yyvs93.item (yyvsp93))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp93 := yyvsp93 -1
	yyvs33.put (yyval33, yyvsp33)
end
		end

	yy_do_action_215 is
			--|#line <not available> "eiffel.y"
		local
			yyval33: ENSURE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

id_level := Assert_level 
if yy_parsing_status = yyContinue then
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

	yy_do_action_216 is
			--|#line <not available> "eiffel.y"
		local
			yyval33: ENSURE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				id_level := Normal_level
				yyval33 := ast_factory.new_ensure_then_as (yyvs93.item (yyvsp93))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp1 := yyvsp1 -2
	yyvsp93 := yyvsp93 -1
	yyvs33.put (yyval33, yyvsp33)
end
		end

	yy_do_action_217 is
			--|#line <not available> "eiffel.y"
		local
			yyval33: ENSURE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

id_level := Assert_level 
if yy_parsing_status = yyContinue then
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

	yy_do_action_218 is
			--|#line <not available> "eiffel.y"
		local
			yyval93: EIFFEL_LIST [TAGGED_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
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

	yy_do_action_219 is
			--|#line <not available> "eiffel.y"
		local
			yyval93: EIFFEL_LIST [TAGGED_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval93 := yyvs93.item (yyvsp93)
				if yyval93 /= Void and then yyval93.is_empty then
					yyval93 := Void
				end
				remove_counter
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp93 := yyvsp93 -1
	yyvs93.put (yyval93, yyvsp93)
end
		end

	yy_do_action_220 is
			--|#line <not available> "eiffel.y"
		local
			yyval93: EIFFEL_LIST [TAGGED_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

add_counter 
if yy_parsing_status = yyContinue then
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

	yy_do_action_221 is
			--|#line <not available> "eiffel.y"
		local
			yyval93: EIFFEL_LIST [TAGGED_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Special list treatment here as we do not want Void
					-- element in `Assertion_list'.
				if yyvs66.item (yyvsp66) /= Void then
					yyval93 := ast_factory.new_eiffel_list_tagged_as (counter_value + 1)
					if yyval93 /= Void then
						yyval93.reverse_extend (yyvs66.item (yyvsp66))
					end
				else
					yyval93 := ast_factory.new_eiffel_list_tagged_as (counter_value)
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp93 := yyvsp93 + 1
	yyvsp66 := yyvsp66 -1
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

	yy_do_action_222 is
			--|#line <not available> "eiffel.y"
		local
			yyval93: EIFFEL_LIST [TAGGED_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval93 := yyvs93.item (yyvsp93)
				if yyval93 /= Void and yyvs66.item (yyvsp66) /= Void then
					yyval93.reverse_extend (yyvs66.item (yyvsp66))
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp93 := yyvsp93 -1
	yyvsp66 := yyvsp66 -1
	yyvs93.put (yyval93, yyvsp93)
end
		end

	yy_do_action_223 is
			--|#line <not available> "eiffel.y"
		local
			yyval93: EIFFEL_LIST [TAGGED_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Only increment counter when clause is not Void.
				if yyvs66.item (yyvsp66) /= Void then
					increment_counter
				end
			
if yy_parsing_status = yyContinue then
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

	yy_do_action_224 is
			--|#line <not available> "eiffel.y"
		local
			yyval66: TAGGED_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval66 := ast_factory.new_tagged_as (Void, yyvs35.item (yyvsp35)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp66 := yyvsp66 + 1
	yyvsp35 := yyvsp35 -1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_225 is
			--|#line <not available> "eiffel.y"
		local
			yyval66: TAGGED_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval66 := ast_factory.new_tagged_as (yyvs2.item (yyvsp2), yyvs35.item (yyvsp35)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp66 := yyvsp66 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -2
	yyvsp35 := yyvsp35 -1
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

	yy_do_action_226 is
			--|#line <not available> "eiffel.y"
		local
			yyval66: TAGGED_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp66 := yyvsp66 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -2
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

	yy_do_action_227 is
			--|#line <not available> "eiffel.y"
		local
			yyval68: TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval68 := yyvs68.item (yyvsp68) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs68.put (yyval68, yyvsp68)
end
		end

	yy_do_action_228 is
			--|#line <not available> "eiffel.y"
		local
			yyval68: TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval68 := yyvs68.item (yyvsp68) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs68.put (yyval68, yyvsp68)
end
		end

	yy_do_action_229 is
			--|#line <not available> "eiffel.y"
		local
			yyval68: TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval68 := new_class_type (yyvs2.item (yyvsp2), yyvs94.item (yyvsp94), True, False)
				if has_syntax_warning and yyvs2.item (yyvsp2) /= Void then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (yyvs2.item (yyvsp2).line, yyvs2.item (yyvsp2).column, filename,
						"Make an expanded version of the base class associated with this type."))
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp68 := yyvsp68 + 1
	yyvsp1 := yyvsp1 -1
	yyvsp2 := yyvsp2 -1
	yyvsp94 := yyvsp94 -1
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

	yy_do_action_230 is
			--|#line <not available> "eiffel.y"
		local
			yyval68: TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval68 := new_class_type (yyvs2.item (yyvsp2), yyvs94.item (yyvsp94), False, True) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp68 := yyvsp68 + 1
	yyvsp1 := yyvsp1 -1
	yyvsp2 := yyvsp2 -1
	yyvsp94 := yyvsp94 -1
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

	yy_do_action_231 is
			--|#line <not available> "eiffel.y"
		local
			yyval68: TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval68 := ast_factory.new_bits_as (yyvs47.item (yyvsp47)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp68 := yyvsp68 + 1
	yyvsp1 := yyvsp1 -1
	yyvsp47 := yyvsp47 -1
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

	yy_do_action_232 is
			--|#line <not available> "eiffel.y"
		local
			yyval68: TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval68 := ast_factory.new_bits_symbol_as (yyvs2.item (yyvsp2)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp68 := yyvsp68 + 1
	yyvsp1 := yyvsp1 -1
	yyvsp2 := yyvsp2 -1
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

	yy_do_action_233 is
			--|#line <not available> "eiffel.y"
		local
			yyval68: TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval68 := ast_factory.new_like_id_as (yyvs2.item (yyvsp2)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp68 := yyvsp68 + 1
	yyvsp1 := yyvsp1 -1
	yyvsp2 := yyvsp2 -1
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

	yy_do_action_234 is
			--|#line <not available> "eiffel.y"
		local
			yyval68: TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval68 := ast_factory.new_like_current_as (yyvs5.item (yyvsp5)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp68 := yyvsp68 + 1
	yyvsp1 := yyvsp1 -1
	yyvsp5 := yyvsp5 -1
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

	yy_do_action_235 is
			--|#line <not available> "eiffel.y"
		local
			yyval68: TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval68 := new_class_type (yyvs2.item (yyvsp2), yyvs94.item (yyvsp94), False, False) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp68 := yyvsp68 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp94 := yyvsp94 -1
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

	yy_do_action_236 is
			--|#line <not available> "eiffel.y"
		local
			yyval94: EIFFEL_LIST [TYPE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp94 := yyvsp94 + 1
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

	yy_do_action_237 is
			--|#line <not available> "eiffel.y"
		local
			yyval94: EIFFEL_LIST [TYPE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp94 := yyvsp94 + 1
	yyvsp1 := yyvsp1 -2
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

	yy_do_action_238 is
			--|#line <not available> "eiffel.y"
		local
			yyval94: EIFFEL_LIST [TYPE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval94 := yyvs94.item (yyvsp94) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyvs94.put (yyval94, yyvsp94)
end
		end

	yy_do_action_239 is
			--|#line <not available> "eiffel.y"
		local
			yyval94: EIFFEL_LIST [TYPE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

		 	yyval94 := yyvs94.item (yyvsp94)
			remove_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp94 := yyvsp94 -1
	yyvs94.put (yyval94, yyvsp94)
end
		end

	yy_do_action_240 is
			--|#line <not available> "eiffel.y"
		local
			yyval94: EIFFEL_LIST [TYPE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

add_counter 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp94 := yyvsp94 + 1
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

	yy_do_action_241 is
			--|#line <not available> "eiffel.y"
		local
			yyval94: EIFFEL_LIST [TYPE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval94 := ast_factory.new_eiffel_list_type (counter_value + 1)
				if yyval94 /= Void and yyvs68.item (yyvsp68) /= Void then
					yyval94.reverse_extend (yyvs68.item (yyvsp68))
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp94 := yyvsp94 + 1
	yyvsp68 := yyvsp68 -1
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

	yy_do_action_242 is
			--|#line <not available> "eiffel.y"
		local
			yyval94: EIFFEL_LIST [TYPE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval94 := yyvs94.item (yyvsp94)
				if yyval94 /= Void and yyvs68.item (yyvsp68) /= Void then
					yyval94.reverse_extend (yyvs68.item (yyvsp68))
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp94 := yyvsp94 -1
	yyvsp68 := yyvsp68 -1
	yyvsp1 := yyvsp1 -1
	yyvs94.put (yyval94, yyvsp94)
end
		end

	yy_do_action_243 is
			--|#line <not available> "eiffel.y"
		local
			yyval94: EIFFEL_LIST [TYPE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

increment_counter 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp94 := yyvsp94 + 1
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

	yy_do_action_244 is
			--|#line <not available> "eiffel.y"
		local
			yyval82: EIFFEL_LIST [FORMAL_DEC_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				-- $$ := Void
				formal_generics_end_position := 0
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp82 := yyvsp82 + 1
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

	yy_do_action_245 is
			--|#line <not available> "eiffel.y"
		local
			yyval82: EIFFEL_LIST [FORMAL_DEC_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				formal_generics_end_position := position
				 -- $$ := Void
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp82 := yyvsp82 + 1
	yyvsp1 := yyvsp1 -2
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

	yy_do_action_246 is
			--|#line <not available> "eiffel.y"
		local
			yyval82: EIFFEL_LIST [FORMAL_DEC_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				formal_generics_end_position := position
				yyval82 := yyvs82.item (yyvsp82)
				remove_counter
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp82 := yyvsp82 -1
	yyvsp1 := yyvsp1 -2
	yyvs82.put (yyval82, yyvsp82)
end
		end

	yy_do_action_247 is
			--|#line <not available> "eiffel.y"
		local
			yyval82: EIFFEL_LIST [FORMAL_DEC_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

add_counter 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp82 := yyvsp82 + 1
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

	yy_do_action_248 is
			--|#line <not available> "eiffel.y"
		local
			yyval82: EIFFEL_LIST [FORMAL_DEC_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval82 := ast_factory.new_eiffel_list_formal_dec_as (counter_value + 1)
				if yyval82 /= Void and yyvs42.item (yyvsp42) /= Void then
					yyval82.reverse_extend (yyvs42.item (yyvsp42))
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp82 := yyvsp82 + 1
	yyvsp42 := yyvsp42 -1
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

	yy_do_action_249 is
			--|#line <not available> "eiffel.y"
		local
			yyval82: EIFFEL_LIST [FORMAL_DEC_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval82 := yyvs82.item (yyvsp82)
				if yyval82 /= Void and yyvs42.item (yyvsp42) /= Void then
					yyval82.reverse_extend (yyvs42.item (yyvsp42))
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp82 := yyvsp82 -1
	yyvsp42 := yyvsp42 -1
	yyvsp1 := yyvsp1 -1
	yyvs82.put (yyval82, yyvsp82)
end
		end

	yy_do_action_250 is
			--|#line <not available> "eiffel.y"
		local
			yyval82: EIFFEL_LIST [FORMAL_DEC_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

increment_counter 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp82 := yyvsp82 + 1
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

	yy_do_action_251 is
			--|#line <not available> "eiffel.y"
		local
			yyval41: FORMAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if equal (None_classname, yyvs2.item (yyvsp2)) then
						-- Trigger an error when constraint is NONE.
						-- Needs to be done manually since current test for
						-- checking that `$2' is not a class name
						-- will fail for NONE, whereas before there were some
						-- syntactic conflict since `NONE' was a keyword and
						-- therefore not part of `TE_ID'.
					raise_error
				else
					yyval41 := ast_factory.new_formal_as (yyvs2.item (yyvsp2), True, False)
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp41 := yyvsp41 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_252 is
			--|#line <not available> "eiffel.y"
		local
			yyval41: FORMAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if equal (None_classname, yyvs2.item (yyvsp2)) then
						-- Trigger an error when constraint is NONE.
						-- Needs to be done manually since current test for
						-- checking that `$2' is not a class name
						-- will fail for NONE, whereas before there were some
						-- syntactic conflict since `NONE' was a keyword and
						-- therefore not part of `TE_ID'.
					raise_error
				else
					yyval41 := ast_factory.new_formal_as (yyvs2.item (yyvsp2), False, True)
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp41 := yyvsp41 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_253 is
			--|#line <not available> "eiffel.y"
		local
			yyval41: FORMAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if equal (None_classname, yyvs2.item (yyvsp2)) then
						-- Trigger an error when constraint is NONE.
						-- Needs to be done manually since current test for
						-- checking that `$1' is not a class name
						-- will fail for NONE, whereas before there were some
						-- syntactic conflict since `NONE' was a keyword and
						-- therefore not part of `TE_ID'.
					raise_error
				else
					yyval41 := ast_factory.new_formal_as (yyvs2.item (yyvsp2), False, False)
				end
			
if yy_parsing_status = yyContinue then
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

	yy_do_action_254 is
			--|#line <not available> "eiffel.y"
		local
			yyval42: FORMAL_DEC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if yyvs96.item (yyvsp96) /= Void then
					yyval42 := ast_factory.new_formal_dec_as (yyvs41.item (yyvsp41), yyvs96.item (yyvsp96).first, yyvs96.item (yyvsp96).second)
				else
					yyval42 := ast_factory.new_formal_dec_as (yyvs41.item (yyvsp41), Void, Void)
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp41 := yyvsp41 -1
	yyvsp96 := yyvsp96 -1
	yyvs42.put (yyval42, yyvsp42)
end
		end

	yy_do_action_255 is
			--|#line <not available> "eiffel.y"
		local
			yyval42: FORMAL_DEC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if yyvs41.item (yyvsp41) /= Void then
						-- Needs to be done here, in case current formal is used in
						-- Constraint.
					formal_parameters.extend (yyvs41.item (yyvsp41))
					yyvs41.item (yyvsp41).set_position (formal_parameters.count)
				end
			
if yy_parsing_status = yyContinue then
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

	yy_do_action_256 is
			--|#line <not available> "eiffel.y"
		local
			yyval96: PAIR [TYPE_AS, EIFFEL_LIST [FEATURE_NAME]]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
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

	yy_do_action_257 is
			--|#line <not available> "eiffel.y"
		local
			yyval96: PAIR [TYPE_AS, EIFFEL_LIST [FEATURE_NAME]]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				create yyval96
				yyval96.set_first (yyvs68.item (yyvsp68))
				yyval96.set_second (yyvs81.item (yyvsp81))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp96 := yyvsp96 + 1
	yyvsp1 := yyvsp1 -1
	yyvsp68 := yyvsp68 -1
	yyvsp81 := yyvsp81 -1
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

	yy_do_action_258 is
			--|#line <not available> "eiffel.y"
		local
			yyval81: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp81 := yyvsp81 + 1
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

	yy_do_action_259 is
			--|#line <not available> "eiffel.y"
		local
			yyval81: EIFFEL_LIST [FEATURE_NAME]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval81 := yyvs81.item (yyvsp81) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp3 := yyvsp3 -1
	yyvs81.put (yyval81, yyvsp81)
end
		end

	yy_do_action_260 is
			--|#line <not available> "eiffel.y"
		local
			yyval43: IF_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval43 := ast_factory.new_if_as (yyvs35.item (yyvsp35), yyvs87.item (yyvsp87), Void, Void, yyvs3.item (yyvsp3)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp43 := yyvsp43 + 1
	yyvsp1 := yyvsp1 -2
	yyvsp35 := yyvsp35 -1
	yyvsp87 := yyvsp87 -1
	yyvsp3 := yyvsp3 -1
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

	yy_do_action_261 is
			--|#line <not available> "eiffel.y"
		local
			yyval43: IF_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval43 := ast_factory.new_if_as (yyvs35.item (yyvsp35), yyvs87.item (yyvsp87 - 1), Void, yyvs87.item (yyvsp87), yyvs3.item (yyvsp3)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp43 := yyvsp43 + 1
	yyvsp1 := yyvsp1 -2
	yyvsp35 := yyvsp35 -1
	yyvsp87 := yyvsp87 -2
	yyvsp3 := yyvsp3 -1
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

	yy_do_action_262 is
			--|#line <not available> "eiffel.y"
		local
			yyval43: IF_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval43 := ast_factory.new_if_as (yyvs35.item (yyvsp35), yyvs87.item (yyvsp87), yyvs76.item (yyvsp76), Void, yyvs3.item (yyvsp3)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp43 := yyvsp43 + 1
	yyvsp1 := yyvsp1 -2
	yyvsp35 := yyvsp35 -1
	yyvsp87 := yyvsp87 -1
	yyvsp76 := yyvsp76 -1
	yyvsp3 := yyvsp3 -1
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

	yy_do_action_263 is
			--|#line <not available> "eiffel.y"
		local
			yyval43: IF_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval43 := ast_factory.new_if_as (yyvs35.item (yyvsp35), yyvs87.item (yyvsp87 - 1), yyvs76.item (yyvsp76), yyvs87.item (yyvsp87), yyvs3.item (yyvsp3)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 7
	yyvsp43 := yyvsp43 + 1
	yyvsp1 := yyvsp1 -2
	yyvsp35 := yyvsp35 -1
	yyvsp87 := yyvsp87 -2
	yyvsp76 := yyvsp76 -1
	yyvsp3 := yyvsp3 -1
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

	yy_do_action_264 is
			--|#line <not available> "eiffel.y"
		local
			yyval76: EIFFEL_LIST [ELSIF_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			yyval76 := yyvs76.item (yyvsp76)
			remove_counter
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp76 := yyvsp76 -1
	yyvs76.put (yyval76, yyvsp76)
end
		end

	yy_do_action_265 is
			--|#line <not available> "eiffel.y"
		local
			yyval76: EIFFEL_LIST [ELSIF_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

add_counter 
if yy_parsing_status = yyContinue then
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

	yy_do_action_266 is
			--|#line <not available> "eiffel.y"
		local
			yyval76: EIFFEL_LIST [ELSIF_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval76 := ast_factory.new_eiffel_list_elseif_as (counter_value + 1)
				if yyval76 /= Void and yyvs32.item (yyvsp32) /= Void then
					yyval76.reverse_extend (yyvs32.item (yyvsp32))
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp76 := yyvsp76 + 1
	yyvsp32 := yyvsp32 -1
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

	yy_do_action_267 is
			--|#line <not available> "eiffel.y"
		local
			yyval76: EIFFEL_LIST [ELSIF_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval76 := yyvs76.item (yyvsp76)
				if yyval76 /= Void and yyvs32.item (yyvsp32) /= Void then
					yyval76.reverse_extend (yyvs32.item (yyvsp32))
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp76 := yyvsp76 -1
	yyvsp32 := yyvsp32 -1
	yyvs76.put (yyval76, yyvsp76)
end
		end

	yy_do_action_268 is
			--|#line <not available> "eiffel.y"
		local
			yyval76: EIFFEL_LIST [ELSIF_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

increment_counter 
if yy_parsing_status = yyContinue then
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

	yy_do_action_269 is
			--|#line <not available> "eiffel.y"
		local
			yyval32: ELSIF_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval32 := ast_factory.new_elseif_as (yyvs35.item (yyvsp35), yyvs87.item (yyvsp87)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp32 := yyvsp32 + 1
	yyvsp1 := yyvsp1 -2
	yyvsp35 := yyvsp35 -1
	yyvsp87 := yyvsp87 -1
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

	yy_do_action_270 is
			--|#line <not available> "eiffel.y"
		local
			yyval87: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval87 := yyvs87.item (yyvsp87) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs87.put (yyval87, yyvsp87)
end
		end

	yy_do_action_271 is
			--|#line <not available> "eiffel.y"
		local
			yyval45: INSPECT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval45 := ast_factory.new_inspect_as (yyvs35.item (yyvsp35), yyvs73.item (yyvsp73), Void, yyvs3.item (yyvsp3)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp45 := yyvsp45 + 1
	yyvsp1 := yyvsp1 -1
	yyvsp35 := yyvsp35 -1
	yyvsp73 := yyvsp73 -1
	yyvsp3 := yyvsp3 -1
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

	yy_do_action_272 is
			--|#line <not available> "eiffel.y"
		local
			yyval45: INSPECT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if yyvs87.item (yyvsp87) /= Void then
					yyval45 := ast_factory.new_inspect_as (yyvs35.item (yyvsp35), yyvs73.item (yyvsp73), yyvs87.item (yyvsp87), yyvs3.item (yyvsp3))
				else
					yyval45 := ast_factory.new_inspect_as (yyvs35.item (yyvsp35), yyvs73.item (yyvsp73),
						ast_factory.new_eiffel_list_instruction_as (0), yyvs3.item (yyvsp3))
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp45 := yyvsp45 + 1
	yyvsp1 := yyvsp1 -2
	yyvsp35 := yyvsp35 -1
	yyvsp73 := yyvsp73 -1
	yyvsp87 := yyvsp87 -1
	yyvsp3 := yyvsp3 -1
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

	yy_do_action_273 is
			--|#line <not available> "eiffel.y"
		local
			yyval73: EIFFEL_LIST [CASE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp73 := yyvsp73 + 1
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

	yy_do_action_274 is
			--|#line <not available> "eiffel.y"
		local
			yyval73: EIFFEL_LIST [CASE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval73 := yyvs73.item (yyvsp73)
				remove_counter
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp73 := yyvsp73 -1
	yyvs73.put (yyval73, yyvsp73)
end
		end

	yy_do_action_275 is
			--|#line <not available> "eiffel.y"
		local
			yyval73: EIFFEL_LIST [CASE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

add_counter 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp73 := yyvsp73 + 1
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

	yy_do_action_276 is
			--|#line <not available> "eiffel.y"
		local
			yyval73: EIFFEL_LIST [CASE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval73 := ast_factory.new_eiffel_list_case_as (counter_value + 1)
				if yyval73 /= Void and yyvs22.item (yyvsp22) /= Void then
					yyval73.reverse_extend (yyvs22.item (yyvsp22))
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp73 := yyvsp73 + 1
	yyvsp22 := yyvsp22 -1
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

	yy_do_action_277 is
			--|#line <not available> "eiffel.y"
		local
			yyval73: EIFFEL_LIST [CASE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval73 := yyvs73.item (yyvsp73)
				if yyval73 /= Void and yyvs22.item (yyvsp22) /= Void then
					yyval73.reverse_extend (yyvs22.item (yyvsp22))
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp73 := yyvsp73 -1
	yyvsp22 := yyvsp22 -1
	yyvs73.put (yyval73, yyvsp73)
end
		end

	yy_do_action_278 is
			--|#line <not available> "eiffel.y"
		local
			yyval73: EIFFEL_LIST [CASE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

increment_counter 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp73 := yyvsp73 + 1
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

	yy_do_action_279 is
			--|#line <not available> "eiffel.y"
		local
			yyval22: CASE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval22 := ast_factory.new_case_as (yyvs88.item (yyvsp88), yyvs87.item (yyvsp87)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp22 := yyvsp22 -1
	yyvsp1 := yyvsp1 -2
	yyvsp88 := yyvsp88 -1
	yyvsp87 := yyvsp87 -1
	yyvs22.put (yyval22, yyvsp22)
end
		end

	yy_do_action_280 is
			--|#line <not available> "eiffel.y"
		local
			yyval22: CASE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

add_counter 
if yy_parsing_status = yyContinue then
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

	yy_do_action_281 is
			--|#line <not available> "eiffel.y"
		local
			yyval22: CASE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

remove_counter 
if yy_parsing_status = yyContinue then
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

	yy_do_action_282 is
			--|#line <not available> "eiffel.y"
		local
			yyval88: EIFFEL_LIST [INTERVAL_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval88 := ast_factory.new_eiffel_list_interval_as (counter_value + 1)
				if yyval88 /= Void and yyvs49.item (yyvsp49) /= Void then
					yyval88.reverse_extend (yyvs49.item (yyvsp49))
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp88 := yyvsp88 + 1
	yyvsp49 := yyvsp49 -1
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

	yy_do_action_283 is
			--|#line <not available> "eiffel.y"
		local
			yyval88: EIFFEL_LIST [INTERVAL_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval88 := yyvs88.item (yyvsp88)
				if yyval88 /= Void and yyvs49.item (yyvsp49) /= Void then
					yyval88.reverse_extend (yyvs49.item (yyvsp49))
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp88 := yyvsp88 -1
	yyvsp49 := yyvsp49 -1
	yyvsp1 := yyvsp1 -1
	yyvs88.put (yyval88, yyvsp88)
end
		end

	yy_do_action_284 is
			--|#line <not available> "eiffel.y"
		local
			yyval88: EIFFEL_LIST [INTERVAL_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

increment_counter 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp88 := yyvsp88 + 1
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

	yy_do_action_285 is
			--|#line <not available> "eiffel.y"
		local
			yyval49: INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval49 := ast_factory.new_interval_as (yyvs47.item (yyvsp47), Void) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp49 := yyvsp49 + 1
	yyvsp47 := yyvsp47 -1
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

	yy_do_action_286 is
			--|#line <not available> "eiffel.y"
		local
			yyval49: INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval49 := ast_factory.new_interval_as (yyvs47.item (yyvsp47 - 1), yyvs47.item (yyvsp47)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp49 := yyvsp49 + 1
	yyvsp47 := yyvsp47 -2
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_287 is
			--|#line <not available> "eiffel.y"
		local
			yyval49: INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval49 := ast_factory.new_interval_as (yyvs23.item (yyvsp23), Void) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp49 := yyvsp49 + 1
	yyvsp23 := yyvsp23 -1
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

	yy_do_action_288 is
			--|#line <not available> "eiffel.y"
		local
			yyval49: INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval49 := ast_factory.new_interval_as (yyvs23.item (yyvsp23 - 1), yyvs23.item (yyvsp23)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp49 := yyvsp49 + 1
	yyvsp23 := yyvsp23 -2
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_289 is
			--|#line <not available> "eiffel.y"
		local
			yyval49: INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval49 := ast_factory.new_interval_as (yyvs2.item (yyvsp2), Void) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp49 := yyvsp49 + 1
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

	yy_do_action_290 is
			--|#line <not available> "eiffel.y"
		local
			yyval49: INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval49 := ast_factory.new_interval_as (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp49 := yyvsp49 + 1
	yyvsp2 := yyvsp2 -2
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_291 is
			--|#line <not available> "eiffel.y"
		local
			yyval49: INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval49 := ast_factory.new_interval_as (yyvs2.item (yyvsp2), yyvs47.item (yyvsp47)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp49 := yyvsp49 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -1
	yyvsp47 := yyvsp47 -1
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

	yy_do_action_292 is
			--|#line <not available> "eiffel.y"
		local
			yyval49: INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval49 := ast_factory.new_interval_as (yyvs47.item (yyvsp47), yyvs2.item (yyvsp2)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp49 := yyvsp49 + 1
	yyvsp47 := yyvsp47 -1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_293 is
			--|#line <not available> "eiffel.y"
		local
			yyval49: INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval49 := ast_factory.new_interval_as (yyvs2.item (yyvsp2), yyvs23.item (yyvsp23)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp49 := yyvsp49 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -1
	yyvsp23 := yyvsp23 -1
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

	yy_do_action_294 is
			--|#line <not available> "eiffel.y"
		local
			yyval49: INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval49 := ast_factory.new_interval_as (yyvs23.item (yyvsp23), yyvs2.item (yyvsp2)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp49 := yyvsp49 + 1
	yyvsp23 := yyvsp23 -1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_295 is
			--|#line <not available> "eiffel.y"
		local
			yyval49: INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval49 := ast_factory.new_interval_as (yyvs56.item (yyvsp56), Void) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp49 := yyvsp49 + 1
	yyvsp56 := yyvsp56 -1
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

	yy_do_action_296 is
			--|#line <not available> "eiffel.y"
		local
			yyval49: INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval49 := ast_factory.new_interval_as (yyvs56.item (yyvsp56), yyvs2.item (yyvsp2)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp49 := yyvsp49 + 1
	yyvsp56 := yyvsp56 -1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_297 is
			--|#line <not available> "eiffel.y"
		local
			yyval49: INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval49 := ast_factory.new_interval_as (yyvs2.item (yyvsp2), yyvs56.item (yyvsp56)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp49 := yyvsp49 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -1
	yyvsp56 := yyvsp56 -1
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

	yy_do_action_298 is
			--|#line <not available> "eiffel.y"
		local
			yyval49: INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval49 := ast_factory.new_interval_as (yyvs56.item (yyvsp56 - 1), yyvs56.item (yyvsp56)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp49 := yyvsp49 + 1
	yyvsp56 := yyvsp56 -2
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_299 is
			--|#line <not available> "eiffel.y"
		local
			yyval49: INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval49 := ast_factory.new_interval_as (yyvs56.item (yyvsp56), yyvs47.item (yyvsp47)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp49 := yyvsp49 + 1
	yyvsp56 := yyvsp56 -1
	yyvsp1 := yyvsp1 -1
	yyvsp47 := yyvsp47 -1
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

	yy_do_action_300 is
			--|#line <not available> "eiffel.y"
		local
			yyval49: INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval49 := ast_factory.new_interval_as (yyvs47.item (yyvsp47), yyvs56.item (yyvsp56)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp49 := yyvsp49 + 1
	yyvsp47 := yyvsp47 -1
	yyvsp1 := yyvsp1 -1
	yyvsp56 := yyvsp56 -1
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

	yy_do_action_301 is
			--|#line <not available> "eiffel.y"
		local
			yyval49: INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval49 := ast_factory.new_interval_as (yyvs56.item (yyvsp56), yyvs23.item (yyvsp23)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp49 := yyvsp49 + 1
	yyvsp56 := yyvsp56 -1
	yyvsp1 := yyvsp1 -1
	yyvsp23 := yyvsp23 -1
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

	yy_do_action_302 is
			--|#line <not available> "eiffel.y"
		local
			yyval49: INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval49 := ast_factory.new_interval_as (yyvs23.item (yyvsp23), yyvs56.item (yyvsp56)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp49 := yyvsp49 + 1
	yyvsp23 := yyvsp23 -1
	yyvsp1 := yyvsp1 -1
	yyvsp56 := yyvsp56 -1
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

	yy_do_action_303 is
			--|#line <not available> "eiffel.y"
		local
			yyval51: LOOP_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval51 := ast_factory.new_loop_as (yyvs87.item (yyvsp87 - 1), yyvs93.item (yyvsp93), yyvs70.item (yyvsp70), yyvs35.item (yyvsp35), yyvs87.item (yyvsp87), yyvs3.item (yyvsp3))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 9
	yyvsp51 := yyvsp51 + 1
	yyvsp1 := yyvsp1 -3
	yyvsp87 := yyvsp87 -2
	yyvsp93 := yyvsp93 -1
	yyvsp70 := yyvsp70 -1
	yyvsp35 := yyvsp35 -1
	yyvsp3 := yyvsp3 -1
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

	yy_do_action_304 is
			--|#line <not available> "eiffel.y"
		local
			yyval93: EIFFEL_LIST [TAGGED_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
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

	yy_do_action_305 is
			--|#line <not available> "eiffel.y"
		local
			yyval93: EIFFEL_LIST [TAGGED_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval93 := yyvs93.item (yyvsp93) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs93.put (yyval93, yyvsp93)
end
		end

	yy_do_action_306 is
			--|#line <not available> "eiffel.y"
		local
			yyval50: INVARIANT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp50 := yyvsp50 + 1
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

	yy_do_action_307 is
			--|#line <not available> "eiffel.y"
		local
			yyval50: INVARIANT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				id_level := Normal_level
				yyval50 := ast_factory.new_invariant_as (yyvs93.item (yyvsp93), once_manifest_string_count)
				once_manifest_string_count := 0
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp93 := yyvsp93 -1
	yyvs50.put (yyval50, yyvsp50)
end
		end

	yy_do_action_308 is
			--|#line <not available> "eiffel.y"
		local
			yyval50: INVARIANT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

id_level := Invariant_level 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp50 := yyvsp50 + 1
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

	yy_do_action_309 is
			--|#line <not available> "eiffel.y"
		local
			yyval70: VARIANT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp70 := yyvsp70 + 1
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

	yy_do_action_310 is
			--|#line <not available> "eiffel.y"
		local
			yyval70: VARIANT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval70 := ast_factory.new_variant_as (yyvs2.item (yyvsp2), yyvs35.item (yyvsp35)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp70 := yyvsp70 + 1
	yyvsp1 := yyvsp1 -2
	yyvsp2 := yyvsp2 -1
	yyvsp35 := yyvsp35 -1
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

	yy_do_action_311 is
			--|#line <not available> "eiffel.y"
		local
			yyval70: VARIANT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval70 := ast_factory.new_variant_as (Void, yyvs35.item (yyvsp35)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp70 := yyvsp70 + 1
	yyvsp1 := yyvsp1 -1
	yyvsp35 := yyvsp35 -1
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

	yy_do_action_312 is
			--|#line <not available> "eiffel.y"
		local
			yyval31: DEBUG_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval31 := ast_factory.new_debug_as (yyvs92.item (yyvsp92), yyvs87.item (yyvsp87), yyvs3.item (yyvsp3)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp31 := yyvsp31 + 1
	yyvsp1 := yyvsp1 -1
	yyvsp92 := yyvsp92 -1
	yyvsp87 := yyvsp87 -1
	yyvsp3 := yyvsp3 -1
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

	yy_do_action_313 is
			--|#line <not available> "eiffel.y"
		local
			yyval92: EIFFEL_LIST [STRING_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
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

	yy_do_action_314 is
			--|#line <not available> "eiffel.y"
		local
			yyval92: EIFFEL_LIST [STRING_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp92 := yyvsp92 + 1
	yyvsp1 := yyvsp1 -2
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

	yy_do_action_315 is
			--|#line <not available> "eiffel.y"
		local
			yyval92: EIFFEL_LIST [STRING_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval92 := yyvs92.item (yyvsp92)
				remove_counter
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp92 := yyvsp92 -1
	yyvsp1 := yyvsp1 -2
	yyvs92.put (yyval92, yyvsp92)
end
		end

	yy_do_action_316 is
			--|#line <not available> "eiffel.y"
		local
			yyval92: EIFFEL_LIST [STRING_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

add_counter 
if yy_parsing_status = yyContinue then
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

	yy_do_action_317 is
			--|#line <not available> "eiffel.y"
		local
			yyval92: EIFFEL_LIST [STRING_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval92 := ast_factory.new_eiffel_list_string_as (counter_value + 1)
				if yyval92 /= Void and yyvs65.item (yyvsp65) /= Void then
					yyval92.reverse_extend (yyvs65.item (yyvsp65))
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp92 := yyvsp92 + 1
	yyvsp65 := yyvsp65 -1
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

	yy_do_action_318 is
			--|#line <not available> "eiffel.y"
		local
			yyval92: EIFFEL_LIST [STRING_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval92 := yyvs92.item (yyvsp92)
				if yyval92 /= Void and yyvs65.item (yyvsp65) /= Void then
					yyval92.reverse_extend (yyvs65.item (yyvsp65))
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp92 := yyvsp92 -1
	yyvsp65 := yyvsp65 -1
	yyvsp1 := yyvsp1 -1
	yyvs92.put (yyval92, yyvsp92)
end
		end

	yy_do_action_319 is
			--|#line <not available> "eiffel.y"
		local
			yyval92: EIFFEL_LIST [STRING_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

increment_counter 
if yy_parsing_status = yyContinue then
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

	yy_do_action_320 is
			--|#line <not available> "eiffel.y"
		local
			yyval87: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
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

	yy_do_action_321 is
			--|#line <not available> "eiffel.y"
		local
			yyval87: EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval87 := yyvs87.item (yyvsp87)
				if yyval87 = Void then
					yyval87 := ast_factory.new_eiffel_list_instruction_as (0)
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs87.put (yyval87, yyvsp87)
end
		end

	yy_do_action_322 is
			--|#line <not available> "eiffel.y"
		local
			yyval35: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval35 := yyvs18.item (yyvsp18) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp35 := yyvsp35 + 1
	yyvsp18 := yyvsp18 -1
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

	yy_do_action_323 is
			--|#line <not available> "eiffel.y"
		local
			yyval35: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval35 := yyvs35.item (yyvsp35) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs35.put (yyval35, yyvsp35)
end
		end

	yy_do_action_324 is
			--|#line <not available> "eiffel.y"
		local
			yyval35: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval35 := ast_factory.new_expr_call_as (yyvs21.item (yyvsp21)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp35 := yyvsp35 + 1
	yyvsp21 := yyvsp21 -1
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

	yy_do_action_325 is
			--|#line <not available> "eiffel.y"
		local
			yyval16: ASSIGNER_CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := ast_factory.new_assigner_call_as (yyvs35.item (yyvsp35 - 1), yyvs35.item (yyvsp35)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp16 := yyvsp16 + 1
	yyvsp35 := yyvsp35 -2
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_326 is
			--|#line <not available> "eiffel.y"
		local
			yyval15: ASSIGN_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval15 := ast_factory.new_assign_as (ast_factory.new_access_id_as (yyvs2.item (yyvsp2), Void), yyvs35.item (yyvsp35)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp15 := yyvsp15 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -1
	yyvsp35 := yyvsp35 -1
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
	yyvs15.put (yyval15, yyvsp15)
end
		end

	yy_do_action_327 is
			--|#line <not available> "eiffel.y"
		local
			yyval15: ASSIGN_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval15 := ast_factory.new_assign_as (yyvs7.item (yyvsp7), yyvs35.item (yyvsp35)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp15 := yyvsp15 + 1
	yyvsp7 := yyvsp7 -1
	yyvsp1 := yyvsp1 -1
	yyvsp35 := yyvsp35 -1
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
	yyvs15.put (yyval15, yyvsp15)
end
		end

	yy_do_action_328 is
			--|#line <not available> "eiffel.y"
		local
			yyval60: REVERSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval60 := ast_factory.new_reverse_as (ast_factory.new_access_id_as (yyvs2.item (yyvsp2), Void), yyvs35.item (yyvsp35)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp60 := yyvsp60 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -1
	yyvsp35 := yyvsp35 -1
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

	yy_do_action_329 is
			--|#line <not available> "eiffel.y"
		local
			yyval60: REVERSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval60 := ast_factory.new_reverse_as (yyvs7.item (yyvsp7), yyvs35.item (yyvsp35)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp60 := yyvsp60 + 1
	yyvsp7 := yyvsp7 -1
	yyvsp1 := yyvsp1 -1
	yyvsp35 := yyvsp35 -1
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

	yy_do_action_330 is
			--|#line <not available> "eiffel.y"
		local
			yyval75: EIFFEL_LIST [CREATE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp75 := yyvsp75 + 1
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

	yy_do_action_331 is
			--|#line <not available> "eiffel.y"
		local
			yyval75: EIFFEL_LIST [CREATE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval75 := yyvs75.item (yyvsp75)
				remove_counter
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp75 := yyvsp75 -1
	yyvs75.put (yyval75, yyvsp75)
end
		end

	yy_do_action_332 is
			--|#line <not available> "eiffel.y"
		local
			yyval75: EIFFEL_LIST [CREATE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

add_counter 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp75 := yyvsp75 + 1
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

	yy_do_action_333 is
			--|#line <not available> "eiffel.y"
		local
			yyval75: EIFFEL_LIST [CREATE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval75 := ast_factory.new_eiffel_list_create_as (counter_value + 1)
				if yyval75 /= Void and yyvs28.item (yyvsp28) /= Void then
					yyval75.reverse_extend (yyvs28.item (yyvsp28))
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp75 := yyvsp75 + 1
	yyvsp28 := yyvsp28 -1
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

	yy_do_action_334 is
			--|#line <not available> "eiffel.y"
		local
			yyval75: EIFFEL_LIST [CREATE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval75 := yyvs75.item (yyvsp75)
				if yyval75 /= Void and yyvs28.item (yyvsp28) /= Void then
					yyval75.reverse_extend (yyvs28.item (yyvsp28))
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp75 := yyvsp75 -1
	yyvsp28 := yyvsp28 -1
	yyvs75.put (yyval75, yyvsp75)
end
		end

	yy_do_action_335 is
			--|#line <not available> "eiffel.y"
		local
			yyval75: EIFFEL_LIST [CREATE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

increment_counter 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp75 := yyvsp75 + 1
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

	yy_do_action_336 is
			--|#line <not available> "eiffel.y"
		local
			yyval28: CREATE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval28 := ast_factory.new_create_as (Void, Void)
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp28 := yyvsp28 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_337 is
			--|#line <not available> "eiffel.y"
		local
			yyval28: CREATE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval28 := ast_factory.new_create_as (yyvs25.item (yyvsp25), yyvs81.item (yyvsp81))
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp28 := yyvsp28 + 1
	yyvsp1 := yyvsp1 -1
	yyvsp25 := yyvsp25 -1
	yyvsp81 := yyvsp81 -1
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

	yy_do_action_338 is
			--|#line <not available> "eiffel.y"
		local
			yyval28: CREATE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval28 := ast_factory.new_create_as (ast_factory.new_client_as (yyvs83.item (yyvsp83)), Void)
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp28 := yyvsp28 + 1
	yyvsp1 := yyvsp1 -1
	yyvsp83 := yyvsp83 -1
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

	yy_do_action_339 is
			--|#line <not available> "eiffel.y"
		local
			yyval28: CREATE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval28 := ast_factory.new_create_as (Void, Void)
				if has_syntax_warning and yyvs3.item (yyvsp3) /= Void then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (yyvs3.item (yyvsp3).line, yyvs3.item (yyvsp3).column, filename,
						"Use keyword `create' instead."))
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp28 := yyvsp28 + 1
	yyvsp3 := yyvsp3 -1
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

	yy_do_action_340 is
			--|#line <not available> "eiffel.y"
		local
			yyval28: CREATE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval28 := ast_factory.new_create_as (yyvs25.item (yyvsp25), yyvs81.item (yyvsp81))
				if has_syntax_warning and yyvs3.item (yyvsp3) /= Void then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (yyvs3.item (yyvsp3).line, yyvs3.item (yyvsp3).column, filename,
						"Use keyword `create' instead."))
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp28 := yyvsp28 + 1
	yyvsp3 := yyvsp3 -1
	yyvsp25 := yyvsp25 -1
	yyvsp81 := yyvsp81 -1
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

	yy_do_action_341 is
			--|#line <not available> "eiffel.y"
		local
			yyval28: CREATE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval28 := ast_factory.new_create_as (ast_factory.new_client_as (yyvs83.item (yyvsp83)), Void)
				if has_syntax_warning and yyvs3.item (yyvsp3) /= Void then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (yyvs3.item (yyvsp3).line, yyvs3.item (yyvsp3).column, filename,
						"Use keyword `create' instead."))
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp28 := yyvsp28 + 1
	yyvsp3 := yyvsp3 -1
	yyvsp83 := yyvsp83 -1
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

	yy_do_action_342 is
			--|#line <not available> "eiffel.y"
		local
			yyval63: ROUTINE_CREATION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			yyval63 := ast_factory.new_routine_creation_as (
				ast_factory.new_operand_as (Void, Void, Void), yyvs2.item (yyvsp2), yyvs89.item (yyvsp89), False)
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp63 := yyvsp63 + 1
	yyvsp1 := yyvsp1 -1
	yyvsp2 := yyvsp2 -1
	yyvsp89 := yyvsp89 -1
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

	yy_do_action_343 is
			--|#line <not available> "eiffel.y"
		local
			yyval63: ROUTINE_CREATION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			yyval63 := ast_factory.new_routine_creation_as (yyvs53.item (yyvsp53), yyvs2.item (yyvsp2), yyvs89.item (yyvsp89), True)
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp63 := yyvsp63 + 1
	yyvsp1 := yyvsp1 -2
	yyvsp53 := yyvsp53 -1
	yyvsp2 := yyvsp2 -1
	yyvsp89 := yyvsp89 -1
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

	yy_do_action_344 is
			--|#line <not available> "eiffel.y"
		local
			yyval63: ROUTINE_CREATION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			if yyvs64.item (yyvsp64) /= Void then
				yyval63 := yyvs64.item (yyvsp64).first
				if has_syntax_warning and yyvs64.item (yyvsp64).second /= Void then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (yyvs64.item (yyvsp64).second.line,
						yyvs64.item (yyvsp64).second.column, filename, "Use keyword `agent' instead."))
				end
			end
		
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp63 := yyvsp63 + 1
	yyvsp64 := yyvsp64 -1
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

	yy_do_action_345 is
			--|#line <not available> "eiffel.y"
		local
			yyval64: PAIR [ROUTINE_CREATION_AS, LOCATION_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval64 := ast_factory.new_old_routine_creation_as (yyvs2.item (yyvsp2), ast_factory.new_operand_as (Void, Void, Void), yyvs2.item (yyvsp2), yyvs89.item (yyvsp89), False) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp64 := yyvsp64 + 1
	yyvsp1 := yyvsp1 -1
	yyvsp2 := yyvsp2 -1
	yyvsp89 := yyvsp89 -1
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

	yy_do_action_346 is
			--|#line <not available> "eiffel.y"
		local
			yyval64: PAIR [ROUTINE_CREATION_AS, LOCATION_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval64 := ast_factory.new_old_routine_creation_as (yyvs2.item (yyvsp2 - 1), ast_factory.new_operand_as (Void, ast_factory.new_access_id_as (yyvs2.item (yyvsp2 - 1), Void), Void), yyvs2.item (yyvsp2), yyvs89.item (yyvsp89), True) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp64 := yyvsp64 + 1
	yyvsp2 := yyvsp2 -2
	yyvsp1 := yyvsp1 -1
	yyvsp89 := yyvsp89 -1
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

	yy_do_action_347 is
			--|#line <not available> "eiffel.y"
		local
			yyval64: PAIR [ROUTINE_CREATION_AS, LOCATION_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval64 := ast_factory.new_old_routine_creation_as (yyvs35.item (yyvsp35), ast_factory.new_operand_as (Void, Void, yyvs35.item (yyvsp35)), yyvs2.item (yyvsp2), yyvs89.item (yyvsp89), True) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 6
	yyvsp64 := yyvsp64 + 1
	yyvsp1 := yyvsp1 -3
	yyvsp35 := yyvsp35 -1
	yyvsp2 := yyvsp2 -1
	yyvsp89 := yyvsp89 -1
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

	yy_do_action_348 is
			--|#line <not available> "eiffel.y"
		local
			yyval64: PAIR [ROUTINE_CREATION_AS, LOCATION_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval64 := ast_factory.new_old_routine_creation_as (yyvs2.item (yyvsp2), ast_factory.new_operand_as (Void, yyvs7.item (yyvsp7), Void), yyvs2.item (yyvsp2), yyvs89.item (yyvsp89), True) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp64 := yyvsp64 + 1
	yyvsp7 := yyvsp7 -1
	yyvsp1 := yyvsp1 -1
	yyvsp2 := yyvsp2 -1
	yyvsp89 := yyvsp89 -1
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

	yy_do_action_349 is
			--|#line <not available> "eiffel.y"
		local
			yyval64: PAIR [ROUTINE_CREATION_AS, LOCATION_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval64 := ast_factory.new_old_routine_creation_as (yyvs2.item (yyvsp2), ast_factory.new_operand_as (Void, yyvs5.item (yyvsp5), Void), yyvs2.item (yyvsp2), yyvs89.item (yyvsp89), True) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp64 := yyvsp64 + 1
	yyvsp5 := yyvsp5 -1
	yyvsp1 := yyvsp1 -1
	yyvsp2 := yyvsp2 -1
	yyvsp89 := yyvsp89 -1
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

	yy_do_action_350 is
			--|#line <not available> "eiffel.y"
		local
			yyval64: PAIR [ROUTINE_CREATION_AS, LOCATION_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval64 := ast_factory.new_old_routine_creation_as (yyvs68.item (yyvsp68), ast_factory.new_operand_as (yyvs68.item (yyvsp68), Void, Void), yyvs2.item (yyvsp2), yyvs89.item (yyvsp89), True) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp64 := yyvsp64 + 1
	yyvsp1 := yyvsp1 -2
	yyvsp68 := yyvsp68 -1
	yyvsp2 := yyvsp2 -1
	yyvsp89 := yyvsp89 -1
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

	yy_do_action_351 is
			--|#line <not available> "eiffel.y"
		local
			yyval64: PAIR [ROUTINE_CREATION_AS, LOCATION_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval64 := ast_factory.new_old_routine_creation_as (yyvs2.item (yyvsp2), ast_factory.new_operand_as (Void, Void, Void), yyvs2.item (yyvsp2), yyvs89.item (yyvsp89), True) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp64 := yyvsp64 + 1
	yyvsp1 := yyvsp1 -2
	yyvsp2 := yyvsp2 -1
	yyvsp89 := yyvsp89 -1
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
			--|#line <not available> "eiffel.y"
		local
			yyval53: OPERAND_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval53 := ast_factory.new_operand_as (Void, ast_factory.new_access_id_as (yyvs2.item (yyvsp2), Void), Void) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp53 := yyvsp53 + 1
	yyvsp2 := yyvsp2 -1
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

	yy_do_action_353 is
			--|#line <not available> "eiffel.y"
		local
			yyval53: OPERAND_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval53 := ast_factory.new_operand_as (Void, Void, yyvs35.item (yyvsp35)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp53 := yyvsp53 + 1
	yyvsp1 := yyvsp1 -2
	yyvsp35 := yyvsp35 -1
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

	yy_do_action_354 is
			--|#line <not available> "eiffel.y"
		local
			yyval53: OPERAND_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval53 := ast_factory.new_operand_as (Void, yyvs7.item (yyvsp7), Void) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp53 := yyvsp53 + 1
	yyvsp7 := yyvsp7 -1
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

	yy_do_action_355 is
			--|#line <not available> "eiffel.y"
		local
			yyval53: OPERAND_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval53 := ast_factory.new_operand_as (Void, yyvs5.item (yyvsp5), Void) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp53 := yyvsp53 + 1
	yyvsp5 := yyvsp5 -1
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

	yy_do_action_356 is
			--|#line <not available> "eiffel.y"
		local
			yyval53: OPERAND_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval53 := ast_factory.new_operand_as (yyvs68.item (yyvsp68), Void, Void)
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp53 := yyvsp53 + 1
	yyvsp68 := yyvsp68 -1
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

	yy_do_action_357 is
			--|#line <not available> "eiffel.y"
		local
			yyval53: OPERAND_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval53 := Void 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp53 := yyvsp53 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_358 is
			--|#line <not available> "eiffel.y"
		local
			yyval89: EIFFEL_LIST [OPERAND_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp89 := yyvsp89 + 1
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

	yy_do_action_359 is
			--|#line <not available> "eiffel.y"
		local
			yyval89: EIFFEL_LIST [OPERAND_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp89 := yyvsp89 + 1
	yyvsp1 := yyvsp1 -2
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

	yy_do_action_360 is
			--|#line <not available> "eiffel.y"
		local
			yyval89: EIFFEL_LIST [OPERAND_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval89 := yyvs89.item (yyvsp89)
				remove_counter
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp89 := yyvsp89 -1
	yyvsp1 := yyvsp1 -2
	yyvs89.put (yyval89, yyvsp89)
end
		end

	yy_do_action_361 is
			--|#line <not available> "eiffel.y"
		local
			yyval89: EIFFEL_LIST [OPERAND_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

add_counter 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp89 := yyvsp89 + 1
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

	yy_do_action_362 is
			--|#line <not available> "eiffel.y"
		local
			yyval89: EIFFEL_LIST [OPERAND_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval89 := ast_factory.new_eiffel_list_operand_as (counter_value + 1)
				if yyval89 /= Void and yyvs53.item (yyvsp53) /= Void then
					yyval89.reverse_extend (yyvs53.item (yyvsp53))
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp89 := yyvsp89 + 1
	yyvsp53 := yyvsp53 -1
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

	yy_do_action_363 is
			--|#line <not available> "eiffel.y"
		local
			yyval89: EIFFEL_LIST [OPERAND_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval89 := yyvs89.item (yyvsp89)
				if yyval89 /= Void and yyvs53.item (yyvsp53) /= Void then
					yyval89.reverse_extend (yyvs53.item (yyvsp53))
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp89 := yyvsp89 -1
	yyvsp53 := yyvsp53 -1
	yyvsp1 := yyvsp1 -1
	yyvs89.put (yyval89, yyvsp89)
end
		end

	yy_do_action_364 is
			--|#line <not available> "eiffel.y"
		local
			yyval89: EIFFEL_LIST [OPERAND_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

increment_counter 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
	yyvsp89 := yyvsp89 + 1
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

	yy_do_action_365 is
			--|#line <not available> "eiffel.y"
		local
			yyval53: OPERAND_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval53 := ast_factory.new_operand_as (Void, Void, Void) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp53 := yyvsp53 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_366 is
			--|#line <not available> "eiffel.y"
		local
			yyval53: OPERAND_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval53 := ast_factory.new_operand_as (yyvs68.item (yyvsp68), Void, Void) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp53 := yyvsp53 + 1
	yyvsp68 := yyvsp68 -1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_367 is
			--|#line <not available> "eiffel.y"
		local
			yyval53: OPERAND_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval53 := ast_factory.new_operand_as (Void, Void, yyvs35.item (yyvsp35)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp53 := yyvsp53 + 1
	yyvsp35 := yyvsp35 -1
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

	yy_do_action_368 is
			--|#line <not available> "eiffel.y"
		local
			yyval29: CREATION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval29 := ast_factory.new_creation_as (Void, yyvs11.item (yyvsp11), yyvs13.item (yyvsp13))
				if has_syntax_warning and yyvs11.item (yyvsp11) /= Void then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (yyvs11.item (yyvsp11).start_location.line,
						yyvs11.item (yyvsp11).start_location.column, filename, "Use keyword `create' instead."))
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp29 := yyvsp29 + 1
	yyvsp1 := yyvsp1 -2
	yyvsp11 := yyvsp11 -1
	yyvsp13 := yyvsp13 -1
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

	yy_do_action_369 is
			--|#line <not available> "eiffel.y"
		local
			yyval29: CREATION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval29 := ast_factory.new_creation_as (yyvs68.item (yyvsp68), yyvs11.item (yyvsp11), yyvs13.item (yyvsp13))
				if has_syntax_warning and yyvs11.item (yyvsp11) /= Void then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (yyvs11.item (yyvsp11).start_location.line,
						yyvs11.item (yyvsp11).start_location.column, filename, "Use keyword `create' instead."))
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp29 := yyvsp29 + 1
	yyvsp1 := yyvsp1 -2
	yyvsp68 := yyvsp68 -1
	yyvsp11 := yyvsp11 -1
	yyvsp13 := yyvsp13 -1
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

	yy_do_action_370 is
			--|#line <not available> "eiffel.y"
		local
			yyval29: CREATION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval29 := ast_factory.new_creation_as (Void, yyvs11.item (yyvsp11), yyvs13.item (yyvsp13)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp29 := yyvsp29 + 1
	yyvsp1 := yyvsp1 -1
	yyvsp11 := yyvsp11 -1
	yyvsp13 := yyvsp13 -1
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

	yy_do_action_371 is
			--|#line <not available> "eiffel.y"
		local
			yyval29: CREATION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval29 := ast_factory.new_creation_as (yyvs68.item (yyvsp68), yyvs11.item (yyvsp11), yyvs13.item (yyvsp13)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp29 := yyvsp29 + 1
	yyvsp1 := yyvsp1 -1
	yyvsp68 := yyvsp68 -1
	yyvsp11 := yyvsp11 -1
	yyvsp13 := yyvsp13 -1
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

	yy_do_action_372 is
			--|#line <not available> "eiffel.y"
		local
			yyval30: CREATION_EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval30 := ast_factory.new_creation_expr_as (yyvs68.item (yyvsp68), yyvs13.item (yyvsp13)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp30 := yyvsp30 + 1
	yyvsp1 := yyvsp1 -1
	yyvsp68 := yyvsp68 -1
	yyvsp13 := yyvsp13 -1
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

	yy_do_action_373 is
			--|#line <not available> "eiffel.y"
		local
			yyval30: CREATION_EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval30 := ast_factory.new_creation_expr_as (yyvs68.item (yyvsp68), yyvs13.item (yyvsp13))
				if has_syntax_warning and yyvs68.item (yyvsp68) /= Void then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (yyvs68.item (yyvsp68).start_location.line,
						yyvs68.item (yyvsp68).start_location.column, filename, "Use keyword `create' instead."))
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp30 := yyvsp30 + 1
	yyvsp1 := yyvsp1 -2
	yyvsp68 := yyvsp68 -1
	yyvsp13 := yyvsp13 -1
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

	yy_do_action_374 is
			--|#line <not available> "eiffel.y"
		local
			yyval11: ACCESS_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval11 := ast_factory.new_access_id_as (yyvs2.item (yyvsp2), Void) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp11 := yyvsp11 + 1
	yyvsp2 := yyvsp2 -1
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
	yyvs11.put (yyval11, yyvsp11)
end
		end

	yy_do_action_375 is
			--|#line <not available> "eiffel.y"
		local
			yyval11: ACCESS_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval11 := yyvs7.item (yyvsp7) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp11 := yyvsp11 + 1
	yyvsp7 := yyvsp7 -1
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
	yyvs11.put (yyval11, yyvsp11)
end
		end

	yy_do_action_376 is
			--|#line <not available> "eiffel.y"
		local
			yyval13: ACCESS_INV_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
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
	yyvs13.put (yyval13, yyvsp13)
end
		end

	yy_do_action_377 is
			--|#line <not available> "eiffel.y"
		local
			yyval13: ACCESS_INV_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval13 := ast_factory.new_access_inv_as (yyvs2.item (yyvsp2), yyvs78.item (yyvsp78)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp13 := yyvsp13 + 1
	yyvsp1 := yyvsp1 -1
	yyvsp2 := yyvsp2 -1
	yyvsp78 := yyvsp78 -1
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
	yyvs13.put (yyval13, yyvsp13)
end
		end

	yy_do_action_378 is
			--|#line <not available> "eiffel.y"
		local
			yyval21: CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval21 := yyvs11.item (yyvsp11) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp21 := yyvsp21 + 1
	yyvsp11 := yyvsp11 -1
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
	yyvs21.put (yyval21, yyvsp21)
end
		end

	yy_do_action_379 is
			--|#line <not available> "eiffel.y"
		local
			yyval21: CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval21 := yyvs55.item (yyvsp55) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp21 := yyvsp21 + 1
	yyvsp55 := yyvsp55 -1
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
	yyvs21.put (yyval21, yyvsp21)
end
		end

	yy_do_action_380 is
			--|#line <not available> "eiffel.y"
		local
			yyval21: CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval21 := yyvs56.item (yyvsp56) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp21 := yyvsp21 + 1
	yyvsp56 := yyvsp56 -1
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
	yyvs21.put (yyval21, yyvsp21)
end
		end

	yy_do_action_381 is
			--|#line <not available> "eiffel.y"
		local
			yyval21: CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval21 := yyvs21.item (yyvsp21) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs21.put (yyval21, yyvsp21)
end
		end

	yy_do_action_382 is
			--|#line <not available> "eiffel.y"
		local
			yyval24: CHECK_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval24 := ast_factory.new_check_as (yyvs93.item (yyvsp93), yyvs3.item (yyvsp3)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp24 := yyvsp24 + 1
	yyvsp1 := yyvsp1 -1
	yyvsp93 := yyvsp93 -1
	yyvsp3 := yyvsp3 -1
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
	yyvs24.put (yyval24, yyvsp24)
end
		end

	yy_do_action_383 is
			--|#line <not available> "eiffel.y"
		local
			yyval68: TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval68 := yyvs68.item (yyvsp68) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyvs68.put (yyval68, yyvsp68)
end
		end

	yy_do_action_384 is
			--|#line <not available> "eiffel.y"
		local
			yyval35: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval35 := yyvs47.item (yyvsp47) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp35 := yyvsp35 + 1
	yyvsp47 := yyvsp47 -1
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

	yy_do_action_385 is
			--|#line <not available> "eiffel.y"
		local
			yyval35: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval35 := yyvs57.item (yyvsp57) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp35 := yyvsp35 + 1
	yyvsp57 := yyvsp57 -1
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

	yy_do_action_386 is
			--|#line <not available> "eiffel.y"
		local
			yyval35: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval35 := yyvs35.item (yyvsp35) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs35.put (yyval35, yyvsp35)
end
		end

	yy_do_action_387 is
			--|#line <not available> "eiffel.y"
		local
			yyval35: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval35 := yyvs35.item (yyvsp35) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs35.put (yyval35, yyvsp35)
end
		end

	yy_do_action_388 is
			--|#line <not available> "eiffel.y"
		local
			yyval35: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval35 := ast_factory.new_bin_eq_as (yyvs35.item (yyvsp35 - 1), yyvs35.item (yyvsp35)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp35 := yyvsp35 -1
	yyvsp1 := yyvsp1 -1
	yyvs35.put (yyval35, yyvsp35)
end
		end

	yy_do_action_389 is
			--|#line <not available> "eiffel.y"
		local
			yyval35: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval35 := ast_factory.new_bin_ne_as (yyvs35.item (yyvsp35 - 1), yyvs35.item (yyvsp35)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp35 := yyvsp35 -1
	yyvsp1 := yyvsp1 -1
	yyvs35.put (yyval35, yyvsp35)
end
		end

	yy_do_action_390 is
			--|#line <not available> "eiffel.y"
		local
			yyval35: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval35 := yyvs18.item (yyvsp18) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp35 := yyvsp35 + 1
	yyvsp18 := yyvsp18 -1
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

	yy_do_action_391 is
			--|#line <not available> "eiffel.y"
		local
			yyval18: BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval18 := ast_factory.new_bin_plus_as (yyvs35.item (yyvsp35 - 1), yyvs35.item (yyvsp35)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp18 := yyvsp18 + 1
	yyvsp35 := yyvsp35 -2
	yyvsp1 := yyvsp1 -1
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
	yyvs18.put (yyval18, yyvsp18)
end
		end

	yy_do_action_392 is
			--|#line <not available> "eiffel.y"
		local
			yyval18: BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval18 := ast_factory.new_bin_minus_as (yyvs35.item (yyvsp35 - 1), yyvs35.item (yyvsp35)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp18 := yyvsp18 + 1
	yyvsp35 := yyvsp35 -2
	yyvsp1 := yyvsp1 -1
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
	yyvs18.put (yyval18, yyvsp18)
end
		end

	yy_do_action_393 is
			--|#line <not available> "eiffel.y"
		local
			yyval18: BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval18 := ast_factory.new_bin_star_as (yyvs35.item (yyvsp35 - 1), yyvs35.item (yyvsp35)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp18 := yyvsp18 + 1
	yyvsp35 := yyvsp35 -2
	yyvsp1 := yyvsp1 -1
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
	yyvs18.put (yyval18, yyvsp18)
end
		end

	yy_do_action_394 is
			--|#line <not available> "eiffel.y"
		local
			yyval18: BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval18 := ast_factory.new_bin_slash_as (yyvs35.item (yyvsp35 - 1), yyvs35.item (yyvsp35)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp18 := yyvsp18 + 1
	yyvsp35 := yyvsp35 -2
	yyvsp1 := yyvsp1 -1
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
	yyvs18.put (yyval18, yyvsp18)
end
		end

	yy_do_action_395 is
			--|#line <not available> "eiffel.y"
		local
			yyval18: BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval18 := ast_factory.new_bin_mod_as (yyvs35.item (yyvsp35 - 1), yyvs35.item (yyvsp35)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp18 := yyvsp18 + 1
	yyvsp35 := yyvsp35 -2
	yyvsp1 := yyvsp1 -1
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
	yyvs18.put (yyval18, yyvsp18)
end
		end

	yy_do_action_396 is
			--|#line <not available> "eiffel.y"
		local
			yyval18: BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval18 := ast_factory.new_bin_div_as (yyvs35.item (yyvsp35 - 1), yyvs35.item (yyvsp35)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp18 := yyvsp18 + 1
	yyvsp35 := yyvsp35 -2
	yyvsp1 := yyvsp1 -1
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
	yyvs18.put (yyval18, yyvsp18)
end
		end

	yy_do_action_397 is
			--|#line <not available> "eiffel.y"
		local
			yyval18: BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval18 := ast_factory.new_bin_power_as (yyvs35.item (yyvsp35 - 1), yyvs35.item (yyvsp35)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp18 := yyvsp18 + 1
	yyvsp35 := yyvsp35 -2
	yyvsp1 := yyvsp1 -1
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
	yyvs18.put (yyval18, yyvsp18)
end
		end

	yy_do_action_398 is
			--|#line <not available> "eiffel.y"
		local
			yyval18: BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval18 := ast_factory.new_bin_and_as (yyvs35.item (yyvsp35 - 1), yyvs35.item (yyvsp35)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp18 := yyvsp18 + 1
	yyvsp35 := yyvsp35 -2
	yyvsp1 := yyvsp1 -1
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
	yyvs18.put (yyval18, yyvsp18)
end
		end

	yy_do_action_399 is
			--|#line <not available> "eiffel.y"
		local
			yyval18: BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval18 := ast_factory.new_bin_and_then_as (yyvs35.item (yyvsp35 - 1), yyvs35.item (yyvsp35)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp18 := yyvsp18 + 1
	yyvsp35 := yyvsp35 -2
	yyvsp1 := yyvsp1 -2
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
	yyvs18.put (yyval18, yyvsp18)
end
		end

	yy_do_action_400 is
			--|#line <not available> "eiffel.y"
		local
			yyval18: BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval18 := ast_factory.new_bin_or_as (yyvs35.item (yyvsp35 - 1), yyvs35.item (yyvsp35)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp18 := yyvsp18 + 1
	yyvsp35 := yyvsp35 -2
	yyvsp1 := yyvsp1 -1
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
	yyvs18.put (yyval18, yyvsp18)
end
		end

	yy_do_action_401 is
			--|#line <not available> "eiffel.y"
		local
			yyval18: BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval18 := ast_factory.new_bin_or_else_as (yyvs35.item (yyvsp35 - 1), yyvs35.item (yyvsp35)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp18 := yyvsp18 + 1
	yyvsp35 := yyvsp35 -2
	yyvsp1 := yyvsp1 -2
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
	yyvs18.put (yyval18, yyvsp18)
end
		end

	yy_do_action_402 is
			--|#line <not available> "eiffel.y"
		local
			yyval18: BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval18 := ast_factory.new_bin_implies_as (yyvs35.item (yyvsp35 - 1), yyvs35.item (yyvsp35)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp18 := yyvsp18 + 1
	yyvsp35 := yyvsp35 -2
	yyvsp1 := yyvsp1 -1
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
	yyvs18.put (yyval18, yyvsp18)
end
		end

	yy_do_action_403 is
			--|#line <not available> "eiffel.y"
		local
			yyval18: BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval18 := ast_factory.new_bin_xor_as (yyvs35.item (yyvsp35 - 1), yyvs35.item (yyvsp35)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp18 := yyvsp18 + 1
	yyvsp35 := yyvsp35 -2
	yyvsp1 := yyvsp1 -1
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
	yyvs18.put (yyval18, yyvsp18)
end
		end

	yy_do_action_404 is
			--|#line <not available> "eiffel.y"
		local
			yyval18: BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval18 := ast_factory.new_bin_ge_as (yyvs35.item (yyvsp35 - 1), yyvs35.item (yyvsp35)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp18 := yyvsp18 + 1
	yyvsp35 := yyvsp35 -2
	yyvsp1 := yyvsp1 -1
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
	yyvs18.put (yyval18, yyvsp18)
end
		end

	yy_do_action_405 is
			--|#line <not available> "eiffel.y"
		local
			yyval18: BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval18 := ast_factory.new_bin_gt_as (yyvs35.item (yyvsp35 - 1), yyvs35.item (yyvsp35)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp18 := yyvsp18 + 1
	yyvsp35 := yyvsp35 -2
	yyvsp1 := yyvsp1 -1
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
	yyvs18.put (yyval18, yyvsp18)
end
		end

	yy_do_action_406 is
			--|#line <not available> "eiffel.y"
		local
			yyval18: BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval18 := ast_factory.new_bin_le_as (yyvs35.item (yyvsp35 - 1), yyvs35.item (yyvsp35)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp18 := yyvsp18 + 1
	yyvsp35 := yyvsp35 -2
	yyvsp1 := yyvsp1 -1
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
	yyvs18.put (yyval18, yyvsp18)
end
		end

	yy_do_action_407 is
			--|#line <not available> "eiffel.y"
		local
			yyval18: BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval18 := ast_factory.new_bin_lt_as (yyvs35.item (yyvsp35 - 1), yyvs35.item (yyvsp35)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp18 := yyvsp18 + 1
	yyvsp35 := yyvsp35 -2
	yyvsp1 := yyvsp1 -1
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
	yyvs18.put (yyval18, yyvsp18)
end
		end

	yy_do_action_408 is
			--|#line <not available> "eiffel.y"
		local
			yyval18: BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval18 := ast_factory.new_bin_free_as (yyvs35.item (yyvsp35 - 1), yyvs2.item (yyvsp2), yyvs35.item (yyvsp35)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp18 := yyvsp18 + 1
	yyvsp35 := yyvsp35 -2
	yyvsp2 := yyvsp2 -1
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
	yyvs18.put (yyval18, yyvsp18)
end
		end

	yy_do_action_409 is
			--|#line <not available> "eiffel.y"
		local
			yyval35: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval35 := yyvs10.item (yyvsp10) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp35 := yyvsp35 + 1
	yyvsp10 := yyvsp10 -1
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

	yy_do_action_410 is
			--|#line <not available> "eiffel.y"
		local
			yyval35: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval35 := yyvs14.item (yyvsp14) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp35 := yyvsp35 + 1
	yyvsp14 := yyvsp14 -1
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

	yy_do_action_411 is
			--|#line <not available> "eiffel.y"
		local
			yyval35: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval35 := yyvs63.item (yyvsp63) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp35 := yyvsp35 + 1
	yyvsp63 := yyvsp63 -1
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

	yy_do_action_412 is
			--|#line <not available> "eiffel.y"
		local
			yyval35: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval35 := ast_factory.new_un_old_as (yyvs35.item (yyvsp35)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs35.put (yyval35, yyvsp35)
end
		end

	yy_do_action_413 is
			--|#line <not available> "eiffel.y"
		local
			yyval35: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval35 := ast_factory.new_un_strip_as (yyvs85.item (yyvsp85)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp35 := yyvsp35 + 1
	yyvsp1 := yyvsp1 -3
	yyvsp85 := yyvsp85 -1
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

	yy_do_action_414 is
			--|#line <not available> "eiffel.y"
		local
			yyval35: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval35 := ast_factory.new_address_as (yyvs71.item (yyvsp71)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp35 := yyvsp35 + 1
	yyvsp1 := yyvsp1 -1
	yyvsp71 := yyvsp71 -1
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

	yy_do_action_415 is
			--|#line <not available> "eiffel.y"
		local
			yyval35: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval35 := ast_factory.new_expr_address_as (yyvs35.item (yyvsp35)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp1 := yyvsp1 -3
	yyvs35.put (yyval35, yyvsp35)
end
		end

	yy_do_action_416 is
			--|#line <not available> "eiffel.y"
		local
			yyval35: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval35 := ast_factory.new_address_current_as (yyvs5.item (yyvsp5)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp35 := yyvsp35 + 1
	yyvsp1 := yyvsp1 -1
	yyvsp5 := yyvsp5 -1
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

	yy_do_action_417 is
			--|#line <not available> "eiffel.y"
		local
			yyval35: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval35 := ast_factory.new_address_result_as (yyvs7.item (yyvsp7)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp35 := yyvsp35 + 1
	yyvsp1 := yyvsp1 -1
	yyvsp7 := yyvsp7 -1
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

	yy_do_action_418 is
			--|#line <not available> "eiffel.y"
		local
			yyval35: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval35 := yyvs35.item (yyvsp35) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs35.put (yyval35, yyvsp35)
end
		end

	yy_do_action_419 is
			--|#line <not available> "eiffel.y"
		local
			yyval35: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval35 := yyvs35.item (yyvsp35) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs35.put (yyval35, yyvsp35)
end
		end

	yy_do_action_420 is
			--|#line <not available> "eiffel.y"
		local
			yyval35: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval35 := ast_factory.new_bracket_as (yyvs35.item (yyvsp35 - 1), yyvs78.item (yyvsp78))
				remove_counter
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp35 := yyvsp35 -1
	yyvsp1 := yyvsp1 -2
	yyvsp78 := yyvsp78 -1
	yyvs35.put (yyval35, yyvsp35)
end
		end

	yy_do_action_421 is
			--|#line <not available> "eiffel.y"
		local
			yyval35: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

add_counter 
if yy_parsing_status = yyContinue then
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

	yy_do_action_422 is
			--|#line <not available> "eiffel.y"
		local
			yyval35: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval35 := ast_factory.new_un_minus_as (yyvs35.item (yyvsp35)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs35.put (yyval35, yyvsp35)
end
		end

	yy_do_action_423 is
			--|#line <not available> "eiffel.y"
		local
			yyval35: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval35 := ast_factory.new_un_plus_as (yyvs35.item (yyvsp35)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs35.put (yyval35, yyvsp35)
end
		end

	yy_do_action_424 is
			--|#line <not available> "eiffel.y"
		local
			yyval35: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval35 := ast_factory.new_un_not_as (yyvs35.item (yyvsp35)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyvs35.put (yyval35, yyvsp35)
end
		end

	yy_do_action_425 is
			--|#line <not available> "eiffel.y"
		local
			yyval35: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval35 := ast_factory.new_un_free_as (yyvs2.item (yyvsp2), yyvs35.item (yyvsp35)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp2 := yyvsp2 -1
	yyvs35.put (yyval35, yyvsp35)
end
		end

	yy_do_action_426 is
			--|#line <not available> "eiffel.y"
		local
			yyval35: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval35 := ast_factory.new_type_expr_as (yyvs68.item (yyvsp68)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp35 := yyvsp35 + 1
	yyvsp68 := yyvsp68 -1
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

	yy_do_action_427 is
			--|#line <not available> "eiffel.y"
		local
			yyval35: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval35 := yyvs47.item (yyvsp47) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp35 := yyvsp35 + 1
	yyvsp47 := yyvsp47 -1
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

	yy_do_action_428 is
			--|#line <not available> "eiffel.y"
		local
			yyval35: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval35 := yyvs57.item (yyvsp57) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp35 := yyvsp35 + 1
	yyvsp57 := yyvsp57 -1
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

	yy_do_action_429 is
			--|#line <not available> "eiffel.y"
		local
			yyval2: ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if not case_sensitive and yyvs2.item (yyvsp2) /= Void then
					yyvs2.item (yyvsp2).to_lower
				end
				yyval2 := yyvs2.item (yyvsp2)
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
		end

	yy_do_action_430 is
			--|#line <not available> "eiffel.y"
		local
			yyval21: CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval21 := ast_factory.new_nested_as (yyvs5.item (yyvsp5), yyvs21.item (yyvsp21)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp5 := yyvsp5 -1
	yyvsp1 := yyvsp1 -1
	yyvs21.put (yyval21, yyvsp21)
end
		end

	yy_do_action_431 is
			--|#line <not available> "eiffel.y"
		local
			yyval21: CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval21 := ast_factory.new_nested_as (yyvs7.item (yyvsp7), yyvs21.item (yyvsp21)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp7 := yyvsp7 -1
	yyvsp1 := yyvsp1 -1
	yyvs21.put (yyval21, yyvsp21)
end
		end

	yy_do_action_432 is
			--|#line <not available> "eiffel.y"
		local
			yyval21: CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval21 := ast_factory.new_nested_as (yyvs11.item (yyvsp11), yyvs21.item (yyvsp21)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp11 := yyvsp11 -1
	yyvsp1 := yyvsp1 -1
	yyvs21.put (yyval21, yyvsp21)
end
		end

	yy_do_action_433 is
			--|#line <not available> "eiffel.y"
		local
			yyval21: CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval21 := ast_factory.new_nested_expr_as (yyvs35.item (yyvsp35), yyvs21.item (yyvsp21)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp1 := yyvsp1 -3
	yyvsp35 := yyvsp35 -1
	yyvs21.put (yyval21, yyvsp21)
end
		end

	yy_do_action_434 is
			--|#line <not available> "eiffel.y"
		local
			yyval21: CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval21 := ast_factory.new_nested_as (yyvs55.item (yyvsp55), yyvs21.item (yyvsp21)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp55 := yyvsp55 -1
	yyvsp1 := yyvsp1 -1
	yyvs21.put (yyval21, yyvsp21)
end
		end

	yy_do_action_435 is
			--|#line <not available> "eiffel.y"
		local
			yyval21: CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval21 := ast_factory.new_nested_as (yyvs56.item (yyvsp56), yyvs21.item (yyvsp21)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp56 := yyvsp56 -1
	yyvsp1 := yyvsp1 -1
	yyvs21.put (yyval21, yyvsp21)
end
		end

	yy_do_action_436 is
			--|#line <not available> "eiffel.y"
		local
			yyval55: PRECURSOR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval55 := ast_factory.new_precursor_as (yyvs3.item (yyvsp3), Void, yyvs78.item (yyvsp78)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp55 := yyvsp55 + 1
	yyvsp3 := yyvsp3 -1
	yyvsp78 := yyvsp78 -1
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

	yy_do_action_437 is
			--|#line <not available> "eiffel.y"
		local
			yyval55: PRECURSOR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval55 := ast_factory.new_precursor_as (yyvs3.item (yyvsp3), ast_factory.new_class_type_as (yyvs2.item (yyvsp2), Void, False, False), yyvs78.item (yyvsp78)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp55 := yyvsp55 + 1
	yyvsp3 := yyvsp3 -1
	yyvsp1 := yyvsp1 -2
	yyvsp2 := yyvsp2 -1
	yyvsp78 := yyvsp78 -1
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

	yy_do_action_438 is
			--|#line <not available> "eiffel.y"
		local
			yyval56: STATIC_ACCESS_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval56 := yyvs56.item (yyvsp56) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs56.put (yyval56, yyvsp56)
end
		end

	yy_do_action_439 is
			--|#line <not available> "eiffel.y"
		local
			yyval56: STATIC_ACCESS_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval56 := yyvs56.item (yyvsp56) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs56.put (yyval56, yyvsp56)
end
		end

	yy_do_action_440 is
			--|#line <not available> "eiffel.y"
		local
			yyval56: STATIC_ACCESS_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval56 := ast_factory.new_static_access_as (yyvs68.item (yyvsp68), yyvs2.item (yyvsp2), yyvs78.item (yyvsp78)); 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp56 := yyvsp56 + 1
	yyvsp68 := yyvsp68 -1
	yyvsp1 := yyvsp1 -1
	yyvsp2 := yyvsp2 -1
	yyvsp78 := yyvsp78 -1
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

	yy_do_action_441 is
			--|#line <not available> "eiffel.y"
		local
			yyval56: STATIC_ACCESS_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval56 := ast_factory.new_static_access_as (yyvs68.item (yyvsp68), yyvs2.item (yyvsp2), yyvs78.item (yyvsp78));
				if has_syntax_warning and yyvs68.item (yyvsp68) /= Void then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (yyvs68.item (yyvsp68).start_location.line,
							yyvs68.item (yyvsp68).start_location.column, filename, "Remove the `feature' keyword."))
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 5
	yyvsp56 := yyvsp56 + 1
	yyvsp1 := yyvsp1 -2
	yyvsp68 := yyvsp68 -1
	yyvsp2 := yyvsp2 -1
	yyvsp78 := yyvsp78 -1
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

	yy_do_action_442 is
			--|#line <not available> "eiffel.y"
		local
			yyval21: CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval21 := yyvs52.item (yyvsp52) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp21 := yyvsp21 + 1
	yyvsp52 := yyvsp52 -1
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
	yyvs21.put (yyval21, yyvsp21)
end
		end

	yy_do_action_443 is
			--|#line <not available> "eiffel.y"
		local
			yyval21: CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval21 := yyvs12.item (yyvsp12) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp21 := yyvsp21 + 1
	yyvsp12 := yyvsp12 -1
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
	yyvs21.put (yyval21, yyvsp21)
end
		end

	yy_do_action_444 is
			--|#line <not available> "eiffel.y"
		local
			yyval52: NESTED_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval52 := ast_factory.new_nested_as (yyvs12.item (yyvsp12 - 1), yyvs12.item (yyvsp12)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp52 := yyvsp52 + 1
	yyvsp12 := yyvsp12 -2
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_445 is
			--|#line <not available> "eiffel.y"
		local
			yyval52: NESTED_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval52 := ast_factory.new_nested_as (yyvs12.item (yyvsp12), yyvs52.item (yyvsp52)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp12 := yyvsp12 -1
	yyvsp1 := yyvsp1 -1
	yyvs52.put (yyval52, yyvsp52)
end
		end

	yy_do_action_446 is
			--|#line <not available> "eiffel.y"
		local
			yyval2: ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval2 := yyvs2.item (yyvsp2)
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
		end

	yy_do_action_447 is
			--|#line <not available> "eiffel.y"
		local
			yyval2: ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if yyvs71.item (yyvsp71) /= Void then
					yyval2 := yyvs71.item (yyvsp71).internal_name
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp2 := yyvsp2 + 1
	yyvsp71 := yyvsp71 -1
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

	yy_do_action_448 is
			--|#line <not available> "eiffel.y"
		local
			yyval2: ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if yyvs71.item (yyvsp71) /= Void then
					yyval2 := yyvs71.item (yyvsp71).internal_name
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp2 := yyvsp2 + 1
	yyvsp71 := yyvsp71 -1
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

	yy_do_action_449 is
			--|#line <not available> "eiffel.y"
		local
			yyval11: ACCESS_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				inspect id_level
				when Normal_level then
					yyval11 := ast_factory.new_access_id_as (yyvs2.item (yyvsp2), yyvs78.item (yyvsp78))
				when Assert_level then
					yyval11 := ast_factory.new_access_assert_as (yyvs2.item (yyvsp2), yyvs78.item (yyvsp78))
				when Invariant_level then
					yyval11 := ast_factory.new_access_inv_as (yyvs2.item (yyvsp2), yyvs78.item (yyvsp78))
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp11 := yyvsp11 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp78 := yyvsp78 -1
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
	yyvs11.put (yyval11, yyvsp11)
end
		end

	yy_do_action_450 is
			--|#line <not available> "eiffel.y"
		local
			yyval12: ACCESS_FEAT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval12 := ast_factory.new_access_feat_as (yyvs2.item (yyvsp2), yyvs78.item (yyvsp78)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp12 := yyvsp12 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp78 := yyvsp78 -1
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
	yyvs12.put (yyval12, yyvsp12)
end
		end

	yy_do_action_451 is
			--|#line <not available> "eiffel.y"
		local
			yyval35: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval35 := yyvs17.item (yyvsp17) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp35 := yyvsp35 + 1
	yyvsp17 := yyvsp17 -1
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

	yy_do_action_452 is
			--|#line <not available> "eiffel.y"
		local
			yyval35: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval35 := yyvs67.item (yyvsp67) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp35 := yyvsp35 + 1
	yyvsp67 := yyvsp67 -1
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

	yy_do_action_453 is
			--|#line <not available> "eiffel.y"
		local
			yyval35: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval35 := ast_factory.new_expr_call_as (yyvs5.item (yyvsp5)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp35 := yyvsp35 + 1
	yyvsp5 := yyvsp5 -1
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

	yy_do_action_454 is
			--|#line <not available> "eiffel.y"
		local
			yyval35: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval35 := ast_factory.new_expr_call_as (yyvs7.item (yyvsp7)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp35 := yyvsp35 + 1
	yyvsp7 := yyvsp7 -1
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

	yy_do_action_455 is
			--|#line <not available> "eiffel.y"
		local
			yyval35: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval35 := ast_factory.new_expr_call_as (yyvs21.item (yyvsp21)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp35 := yyvsp35 + 1
	yyvsp21 := yyvsp21 -1
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

	yy_do_action_456 is
			--|#line <not available> "eiffel.y"
		local
			yyval35: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval35 := ast_factory.new_expr_call_as (yyvs30.item (yyvsp30)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp35 := yyvsp35 + 1
	yyvsp30 := yyvsp30 -1
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

	yy_do_action_457 is
			--|#line <not available> "eiffel.y"
		local
			yyval35: EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval35 := ast_factory.new_paran_as (yyvs35.item (yyvsp35)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyvs35.put (yyval35, yyvsp35)
end
		end

	yy_do_action_458 is
			--|#line <not available> "eiffel.y"
		local
			yyval78: EIFFEL_LIST [EXPR_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
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

	yy_do_action_459 is
			--|#line <not available> "eiffel.y"
		local
			yyval78: EIFFEL_LIST [EXPR_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp78 := yyvsp78 + 1
	yyvsp1 := yyvsp1 -2
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

	yy_do_action_460 is
			--|#line <not available> "eiffel.y"
		local
			yyval78: EIFFEL_LIST [EXPR_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval78 := yyvs78.item (yyvsp78)
				remove_counter
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp78 := yyvsp78 -1
	yyvsp1 := yyvsp1 -2
	yyvs78.put (yyval78, yyvsp78)
end
		end

	yy_do_action_461 is
			--|#line <not available> "eiffel.y"
		local
			yyval78: EIFFEL_LIST [EXPR_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

add_counter 
if yy_parsing_status = yyContinue then
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

	yy_do_action_462 is
			--|#line <not available> "eiffel.y"
		local
			yyval78: EIFFEL_LIST [EXPR_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval78 := ast_factory.new_eiffel_list_expr_as (counter_value + 1)
				if yyval78 /= Void and yyvs35.item (yyvsp35) /= Void then
					yyval78.reverse_extend (yyvs35.item (yyvsp35))
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp78 := yyvsp78 + 1
	yyvsp35 := yyvsp35 -1
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

	yy_do_action_463 is
			--|#line <not available> "eiffel.y"
		local
			yyval78: EIFFEL_LIST [EXPR_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval78 := yyvs78.item (yyvsp78)
				if yyval78 /= Void and yyvs35.item (yyvsp35) /= Void then
					yyval78.reverse_extend (yyvs35.item (yyvsp35))
				end
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp78 := yyvsp78 -1
	yyvsp35 := yyvsp35 -1
	yyvsp1 := yyvsp1 -1
	yyvs78.put (yyval78, yyvsp78)
end
		end

	yy_do_action_464 is
			--|#line <not available> "eiffel.y"
		local
			yyval78: EIFFEL_LIST [EXPR_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

increment_counter 
if yy_parsing_status = yyContinue then
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

	yy_do_action_465 is
			--|#line <not available> "eiffel.y"
		local
			yyval2: ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if not case_sensitive and yyvs2.item (yyvsp2) /= Void then
					yyvs2.item (yyvsp2).to_upper
				end
				yyval2 := yyvs2.item (yyvsp2)
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
		end

	yy_do_action_466 is
			--|#line <not available> "eiffel.y"
		local
			yyval2: ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Keyword used as identifier
				process_id_as
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (line, column, filename,
							"Use of `assign', possibly a new keyword in future definition of `Eiffel'."))
				end
				if not case_sensitive and last_id_as_value /= Void then
					last_id_as_value.to_upper
				end
				yyval2 := last_id_as_value
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp2 := yyvsp2 + 1
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
	yyvs2.put (yyval2, yyvsp2)
end
		end

	yy_do_action_467 is
			--|#line <not available> "eiffel.y"
		local
			yyval2: ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if not case_sensitive and yyvs2.item (yyvsp2) /= Void then
					yyvs2.item (yyvsp2).to_lower
				end
				yyval2 := yyvs2.item (yyvsp2)
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs2.put (yyval2, yyvsp2)
end
		end

	yy_do_action_468 is
			--|#line <not available> "eiffel.y"
		local
			yyval2: ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Keyword used as identifier
				process_id_as
				if has_syntax_warning then
					Error_handler.insert_warning (
						create {SYNTAX_WARNING}.make (line, column, filename,
							"Use of `assign', possibly a new keyword in future definition of `Eiffel'."))
				end
				if not case_sensitive and last_id_as_value /= Void then
					last_id_as_value.to_lower
				end
				yyval2 := last_id_as_value
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp2 := yyvsp2 + 1
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
	yyvs2.put (yyval2, yyvsp2)
end
		end

	yy_do_action_469 is
			--|#line <not available> "eiffel.y"
		local
			yyval17: ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval17 := yyvs4.item (yyvsp4) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp17 := yyvsp17 + 1
	yyvsp4 := yyvsp4 -1
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
	yyvs17.put (yyval17, yyvsp17)
end
		end

	yy_do_action_470 is
			--|#line <not available> "eiffel.y"
		local
			yyval17: ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval17 := yyvs23.item (yyvsp23) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp17 := yyvsp17 + 1
	yyvsp23 := yyvsp23 -1
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
	yyvs17.put (yyval17, yyvsp17)
end
		end

	yy_do_action_471 is
			--|#line <not available> "eiffel.y"
		local
			yyval17: ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval17 := yyvs47.item (yyvsp47) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp17 := yyvsp17 + 1
	yyvsp47 := yyvsp47 -1
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
	yyvs17.put (yyval17, yyvsp17)
end
		end

	yy_do_action_472 is
			--|#line <not available> "eiffel.y"
		local
			yyval17: ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval17 := yyvs57.item (yyvsp57) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp17 := yyvsp17 + 1
	yyvsp57 := yyvsp57 -1
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
	yyvs17.put (yyval17, yyvsp17)
end
		end

	yy_do_action_473 is
			--|#line <not available> "eiffel.y"
		local
			yyval17: ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval17 := yyvs19.item (yyvsp19) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp17 := yyvsp17 + 1
	yyvsp19 := yyvsp19 -1
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
	yyvs17.put (yyval17, yyvsp17)
end
		end

	yy_do_action_474 is
			--|#line <not available> "eiffel.y"
		local
			yyval17: ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval17 := yyvs65.item (yyvsp65) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp17 := yyvsp17 + 1
	yyvsp65 := yyvsp65 -1
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
	yyvs17.put (yyval17, yyvsp17)
end
		end

	yy_do_action_475 is
			--|#line <not available> "eiffel.y"
		local
			yyval17: ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval17 := yyvs4.item (yyvsp4) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp17 := yyvsp17 + 1
	yyvsp4 := yyvsp4 -1
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
	yyvs17.put (yyval17, yyvsp17)
end
		end

	yy_do_action_476 is
			--|#line <not available> "eiffel.y"
		local
			yyval17: ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval17 := yyvs47.item (yyvsp47) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp17 := yyvsp17 + 1
	yyvsp47 := yyvsp47 -1
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
	yyvs17.put (yyval17, yyvsp17)
end
		end

	yy_do_action_477 is
			--|#line <not available> "eiffel.y"
		local
			yyval17: ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval17 := yyvs47.item (yyvsp47) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp17 := yyvsp17 + 1
	yyvsp47 := yyvsp47 -1
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
	yyvs17.put (yyval17, yyvsp17)
end
		end

	yy_do_action_478 is
			--|#line <not available> "eiffel.y"
		local
			yyval17: ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval17 := yyvs57.item (yyvsp57) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp17 := yyvsp17 + 1
	yyvsp57 := yyvsp57 -1
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
	yyvs17.put (yyval17, yyvsp17)
end
		end

	yy_do_action_479 is
			--|#line <not available> "eiffel.y"
		local
			yyval17: ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval17 := yyvs57.item (yyvsp57) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp17 := yyvsp17 + 1
	yyvsp57 := yyvsp57 -1
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
	yyvs17.put (yyval17, yyvsp17)
end
		end

	yy_do_action_480 is
			--|#line <not available> "eiffel.y"
		local
			yyval17: ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval17 := yyvs23.item (yyvsp23) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp17 := yyvsp17 + 1
	yyvsp23 := yyvsp23 -1
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
	yyvs17.put (yyval17, yyvsp17)
end
		end

	yy_do_action_481 is
			--|#line <not available> "eiffel.y"
		local
			yyval17: ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval17 := yyvs19.item (yyvsp19) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp17 := yyvsp17 + 1
	yyvsp19 := yyvsp19 -1
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
	yyvs17.put (yyval17, yyvsp17)
end
		end

	yy_do_action_482 is
			--|#line <not available> "eiffel.y"
		local
			yyval17: ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval17 := yyvs65.item (yyvsp65) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp17 := yyvsp17 + 1
	yyvsp65 := yyvsp65 -1
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
	yyvs17.put (yyval17, yyvsp17)
end
		end

	yy_do_action_483 is
			--|#line <not available> "eiffel.y"
		local
			yyval17: ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if yyvs65.item (yyvsp65) /= Void then
					yyvs65.item (yyvsp65).set_is_once_string (True)
				end
				once_manifest_string_count := once_manifest_string_count + 1
				yyval17 := yyvs65.item (yyvsp65)
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp17 := yyvsp17 + 1
	yyvsp1 := yyvsp1 -1
	yyvsp65 := yyvsp65 -1
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
	yyvs17.put (yyval17, yyvsp17)
end
		end

	yy_do_action_484 is
			--|#line <not available> "eiffel.y"
		local
			yyval4: BOOL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval4 := yyvs4.item (yyvsp4) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs4.put (yyval4, yyvsp4)
end
		end

	yy_do_action_485 is
			--|#line <not available> "eiffel.y"
		local
			yyval4: BOOL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval4 := yyvs4.item (yyvsp4) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs4.put (yyval4, yyvsp4)
end
		end

	yy_do_action_486 is
			--|#line <not available> "eiffel.y"
		local
			yyval23: CHAR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				check is_character: not token_buffer.is_empty end
				yyval23 := ast_factory.new_character_as (token_buffer.item (1), line, column, position)
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp23 := yyvsp23 + 1
	yyvsp1 := yyvsp1 -1
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
	yyvs23.put (yyval23, yyvsp23)
end
		end

	yy_do_action_487 is
			--|#line <not available> "eiffel.y"
		local
			yyval23: CHAR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				check is_character: not token_buffer.is_empty end
				fixme ("We should handle `Type' instead of ignoring it.")
				yyval23 := ast_factory.new_character_as (token_buffer.item (1), line, column, position)
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp23 := yyvsp23 + 1
	yyvsp68 := yyvsp68 -1
	yyvsp1 := yyvsp1 -1
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
	yyvs23.put (yyval23, yyvsp23)
end
		end

	yy_do_action_488 is
			--|#line <not available> "eiffel.y"
		local
			yyval47: INTEGER_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval47 := yyvs47.item (yyvsp47) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs47.put (yyval47, yyvsp47)
end
		end

	yy_do_action_489 is
			--|#line <not available> "eiffel.y"
		local
			yyval47: INTEGER_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval47 := yyvs47.item (yyvsp47) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs47.put (yyval47, yyvsp47)
end
		end

	yy_do_action_490 is
			--|#line <not available> "eiffel.y"
		local
			yyval47: INTEGER_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval47 := yyvs47.item (yyvsp47) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs47.put (yyval47, yyvsp47)
end
		end

	yy_do_action_491 is
			--|#line <not available> "eiffel.y"
		local
			yyval47: INTEGER_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval47 := new_integer_value ('+', Void, token_buffer) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp47 := yyvsp47 + 1
	yyvsp1 := yyvsp1 -2
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

	yy_do_action_492 is
			--|#line <not available> "eiffel.y"
		local
			yyval47: INTEGER_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval47 := new_integer_value ('-', Void, token_buffer) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp47 := yyvsp47 + 1
	yyvsp1 := yyvsp1 -2
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

	yy_do_action_493 is
			--|#line <not available> "eiffel.y"
		local
			yyval47: INTEGER_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval47 := new_integer_value ('%U', Void, token_buffer) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp47 := yyvsp47 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_494 is
			--|#line <not available> "eiffel.y"
		local
			yyval47: INTEGER_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval47 := yyvs47.item (yyvsp47) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs47.put (yyval47, yyvsp47)
end
		end

	yy_do_action_495 is
			--|#line <not available> "eiffel.y"
		local
			yyval47: INTEGER_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval47 := yyvs47.item (yyvsp47) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs47.put (yyval47, yyvsp47)
end
		end

	yy_do_action_496 is
			--|#line <not available> "eiffel.y"
		local
			yyval47: INTEGER_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval47 := new_integer_value ('%U', yyvs68.item (yyvsp68), token_buffer) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp47 := yyvsp47 + 1
	yyvsp68 := yyvsp68 -1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_497 is
			--|#line <not available> "eiffel.y"
		local
			yyval47: INTEGER_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval47 := new_integer_value ('+', yyvs68.item (yyvsp68), token_buffer) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp47 := yyvsp47 + 1
	yyvsp68 := yyvsp68 -1
	yyvsp1 := yyvsp1 -2
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

	yy_do_action_498 is
			--|#line <not available> "eiffel.y"
		local
			yyval47: INTEGER_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval47 := new_integer_value ('-', yyvs68.item (yyvsp68), token_buffer) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp47 := yyvsp47 + 1
	yyvsp68 := yyvsp68 -1
	yyvsp1 := yyvsp1 -2
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

	yy_do_action_499 is
			--|#line <not available> "eiffel.y"
		local
			yyval57: REAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval57 := yyvs57.item (yyvsp57) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs57.put (yyval57, yyvsp57)
end
		end

	yy_do_action_500 is
			--|#line <not available> "eiffel.y"
		local
			yyval57: REAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval57 := yyvs57.item (yyvsp57) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs57.put (yyval57, yyvsp57)
end
		end

	yy_do_action_501 is
			--|#line <not available> "eiffel.y"
		local
			yyval57: REAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval57 := yyvs57.item (yyvsp57) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs57.put (yyval57, yyvsp57)
end
		end

	yy_do_action_502 is
			--|#line <not available> "eiffel.y"
		local
			yyval57: REAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval57 := new_real_value (False, '%U', Void, token_buffer) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp57 := yyvsp57 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_503 is
			--|#line <not available> "eiffel.y"
		local
			yyval57: REAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval57 := new_real_value (True, '+', Void, token_buffer) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp57 := yyvsp57 + 1
	yyvsp1 := yyvsp1 -2
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

	yy_do_action_504 is
			--|#line <not available> "eiffel.y"
		local
			yyval57: REAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval57 := new_real_value (True, '-', Void, token_buffer) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp57 := yyvsp57 + 1
	yyvsp1 := yyvsp1 -2
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

	yy_do_action_505 is
			--|#line <not available> "eiffel.y"
		local
			yyval57: REAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval57 := yyvs57.item (yyvsp57) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs57.put (yyval57, yyvsp57)
end
		end

	yy_do_action_506 is
			--|#line <not available> "eiffel.y"
		local
			yyval57: REAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval57 := yyvs57.item (yyvsp57) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs57.put (yyval57, yyvsp57)
end
		end

	yy_do_action_507 is
			--|#line <not available> "eiffel.y"
		local
			yyval57: REAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval57 := new_real_value (False, '%U', yyvs68.item (yyvsp68), token_buffer) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp57 := yyvsp57 + 1
	yyvsp68 := yyvsp68 -1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_508 is
			--|#line <not available> "eiffel.y"
		local
			yyval57: REAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval57 := new_real_value (True, '+', yyvs68.item (yyvsp68), token_buffer) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp57 := yyvsp57 + 1
	yyvsp68 := yyvsp68 -1
	yyvsp1 := yyvsp1 -2
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

	yy_do_action_509 is
			--|#line <not available> "eiffel.y"
		local
			yyval57: REAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval57 := new_real_value (True, '-', yyvs68.item (yyvsp68), token_buffer) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 3
	yyvsp57 := yyvsp57 + 1
	yyvsp68 := yyvsp68 -1
	yyvsp1 := yyvsp1 -2
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

	yy_do_action_510 is
			--|#line <not available> "eiffel.y"
		local
			yyval19: BIT_CONST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval19 := ast_factory.new_bit_const_as (yyvs2.item (yyvsp2)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp19 := yyvsp19 + 1
	yyvsp2 := yyvsp2 -1
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
	yyvs19.put (yyval19, yyvsp19)
end
		end

	yy_do_action_511 is
			--|#line <not available> "eiffel.y"
		local
			yyval65: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := yyvs65.item (yyvsp65) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs65.put (yyval65, yyvsp65)
end
		end

	yy_do_action_512 is
			--|#line <not available> "eiffel.y"
		local
			yyval65: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := yyvs65.item (yyvsp65) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs65.put (yyval65, yyvsp65)
end
		end

	yy_do_action_513 is
			--|#line <not available> "eiffel.y"
		local
			yyval65: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := yyvs65.item (yyvsp65) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvs65.put (yyval65, yyvsp65)
end
		end

	yy_do_action_514 is
			--|#line <not available> "eiffel.y"
		local
			yyval65: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := ast_factory.new_string_as ("", line, column, string_position, position + text_count - string_position) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp65 := yyvsp65 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_515 is
			--|#line <not available> "eiffel.y"
		local
			yyval65: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := ast_factory.new_verbatim_string_as ("", verbatim_marker.substring (2, verbatim_marker.count), not has_old_verbatim_strings and then verbatim_marker.item (1) = ']', line, column, string_position, position + text_count - string_position) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp65 := yyvsp65 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_516 is
			--|#line <not available> "eiffel.y"
		local
			yyval65: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				fixme ("We should handle `Type' instead of ignoring it.")
				yyval65 := yyvs65.item (yyvsp65)
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp1 := yyvsp1 -2
	yyvsp68 := yyvsp68 -1
	yyvs65.put (yyval65, yyvsp65)
end
		end

	yy_do_action_517 is
			--|#line <not available> "eiffel.y"
		local
			yyval65: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := ast_factory.new_string_as (cloned_string (token_buffer), line, column, string_position, position + text_count - string_position) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp65 := yyvsp65 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_518 is
			--|#line <not available> "eiffel.y"
		local
			yyval65: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := ast_factory.new_verbatim_string_as (cloned_string (token_buffer), verbatim_marker.substring (2, verbatim_marker.count), not has_old_verbatim_strings and then verbatim_marker.item (1) = ']', line, column, string_position, position + text_count - string_position) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp65 := yyvsp65 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_519 is
			--|#line <not available> "eiffel.y"
		local
			yyval65: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := new_lt_string 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp65 := yyvsp65 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_520 is
			--|#line <not available> "eiffel.y"
		local
			yyval65: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := new_le_string 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp65 := yyvsp65 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_521 is
			--|#line <not available> "eiffel.y"
		local
			yyval65: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := new_gt_string 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp65 := yyvsp65 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_522 is
			--|#line <not available> "eiffel.y"
		local
			yyval65: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := new_ge_string 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp65 := yyvsp65 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_523 is
			--|#line <not available> "eiffel.y"
		local
			yyval65: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := new_minus_string 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp65 := yyvsp65 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_524 is
			--|#line <not available> "eiffel.y"
		local
			yyval65: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := new_plus_string 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp65 := yyvsp65 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_525 is
			--|#line <not available> "eiffel.y"
		local
			yyval65: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := new_star_string 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp65 := yyvsp65 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_526 is
			--|#line <not available> "eiffel.y"
		local
			yyval65: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := new_slash_string 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp65 := yyvsp65 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_527 is
			--|#line <not available> "eiffel.y"
		local
			yyval65: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := new_mod_string 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp65 := yyvsp65 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_528 is
			--|#line <not available> "eiffel.y"
		local
			yyval65: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := new_div_string 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp65 := yyvsp65 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_529 is
			--|#line <not available> "eiffel.y"
		local
			yyval65: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := new_power_string 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp65 := yyvsp65 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_530 is
			--|#line <not available> "eiffel.y"
		local
			yyval65: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := new_bracket_string 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp65 := yyvsp65 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_531 is
			--|#line <not available> "eiffel.y"
		local
			yyval65: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := new_string (cloned_string (token_buffer)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp65 := yyvsp65 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_532 is
			--|#line <not available> "eiffel.y"
		local
			yyval65: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := new_string (cloned_string (token_buffer)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp65 := yyvsp65 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_533 is
			--|#line <not available> "eiffel.y"
		local
			yyval65: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := new_string (cloned_string (token_buffer)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp65 := yyvsp65 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_534 is
			--|#line <not available> "eiffel.y"
		local
			yyval65: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := new_string (cloned_string (token_buffer)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp65 := yyvsp65 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_535 is
			--|#line <not available> "eiffel.y"
		local
			yyval65: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := new_string (cloned_string (token_buffer)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp65 := yyvsp65 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_536 is
			--|#line <not available> "eiffel.y"
		local
			yyval65: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := new_string (cloned_string (token_buffer)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp65 := yyvsp65 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_537 is
			--|#line <not available> "eiffel.y"
		local
			yyval65: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := new_string (cloned_string (token_buffer)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp65 := yyvsp65 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_538 is
			--|#line <not available> "eiffel.y"
		local
			yyval65: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := new_string (cloned_string (token_buffer)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp65 := yyvsp65 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_539 is
			--|#line <not available> "eiffel.y"
		local
			yyval65: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := new_minus_string 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp65 := yyvsp65 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_540 is
			--|#line <not available> "eiffel.y"
		local
			yyval65: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := new_plus_string 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp65 := yyvsp65 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_541 is
			--|#line <not available> "eiffel.y"
		local
			yyval65: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := new_not_string 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp65 := yyvsp65 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_542 is
			--|#line <not available> "eiffel.y"
		local
			yyval65: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := new_string (cloned_lower_string (token_buffer)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp65 := yyvsp65 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_543 is
			--|#line <not available> "eiffel.y"
		local
			yyval65: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := new_lt_string 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp65 := yyvsp65 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_544 is
			--|#line <not available> "eiffel.y"
		local
			yyval65: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := new_le_string 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp65 := yyvsp65 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_545 is
			--|#line <not available> "eiffel.y"
		local
			yyval65: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := new_gt_string 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp65 := yyvsp65 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_546 is
			--|#line <not available> "eiffel.y"
		local
			yyval65: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := new_ge_string 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp65 := yyvsp65 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_547 is
			--|#line <not available> "eiffel.y"
		local
			yyval65: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := new_minus_string 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp65 := yyvsp65 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_548 is
			--|#line <not available> "eiffel.y"
		local
			yyval65: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := new_plus_string 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp65 := yyvsp65 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_549 is
			--|#line <not available> "eiffel.y"
		local
			yyval65: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := new_star_string 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp65 := yyvsp65 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_550 is
			--|#line <not available> "eiffel.y"
		local
			yyval65: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := new_slash_string 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp65 := yyvsp65 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_551 is
			--|#line <not available> "eiffel.y"
		local
			yyval65: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := new_mod_string 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp65 := yyvsp65 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_552 is
			--|#line <not available> "eiffel.y"
		local
			yyval65: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := new_div_string 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp65 := yyvsp65 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_553 is
			--|#line <not available> "eiffel.y"
		local
			yyval65: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := new_power_string 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp65 := yyvsp65 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_554 is
			--|#line <not available> "eiffel.y"
		local
			yyval65: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := new_and_string 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp65 := yyvsp65 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_555 is
			--|#line <not available> "eiffel.y"
		local
			yyval65: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := new_and_then_string 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp65 := yyvsp65 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_556 is
			--|#line <not available> "eiffel.y"
		local
			yyval65: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := new_implies_string 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp65 := yyvsp65 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_557 is
			--|#line <not available> "eiffel.y"
		local
			yyval65: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := new_or_string 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp65 := yyvsp65 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_558 is
			--|#line <not available> "eiffel.y"
		local
			yyval65: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := new_or_else_string 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp65 := yyvsp65 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_559 is
			--|#line <not available> "eiffel.y"
		local
			yyval65: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := new_xor_string 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp65 := yyvsp65 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_560 is
			--|#line <not available> "eiffel.y"
		local
			yyval65: STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval65 := new_string (cloned_lower_string (token_buffer)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 1
	yyvsp65 := yyvsp65 + 1
	yyvsp1 := yyvsp1 -1
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

	yy_do_action_561 is
			--|#line <not available> "eiffel.y"
		local
			yyval14: ARRAY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval14 := ast_factory.new_array_as (ast_factory.new_eiffel_list_expr_as (0)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp14 := yyvsp14 + 1
	yyvsp1 := yyvsp1 -2
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
	yyvs14.put (yyval14, yyvsp14)
end
		end

	yy_do_action_562 is
			--|#line <not available> "eiffel.y"
		local
			yyval14: ARRAY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval14 := ast_factory.new_array_as (yyvs78.item (yyvsp78))
				remove_counter
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp1 := yyvsp1 -2
	yyvsp78 := yyvsp78 -1
	yyvs14.put (yyval14, yyvsp14)
end
		end

	yy_do_action_563 is
			--|#line <not available> "eiffel.y"
		local
			yyval14: ARRAY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

add_counter 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 0
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
	yyvs14.put (yyval14, yyvsp14)
end
		end

	yy_do_action_564 is
			--|#line <not available> "eiffel.y"
		local
			yyval67: TUPLE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval67 := ast_factory.new_tuple_as (ast_factory.new_eiffel_list_expr_as (0)) 
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 2
	yyvsp67 := yyvsp67 + 1
	yyvsp1 := yyvsp1 -2
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

	yy_do_action_565 is
			--|#line <not available> "eiffel.y"
		local
			yyval67: TUPLE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval67 := ast_factory.new_tuple_as (yyvs78.item (yyvsp78))
				remove_counter
			
if yy_parsing_status = yyContinue then
	yyssp := yyssp - 4
	yyvsp1 := yyvsp1 -2
	yyvsp78 := yyvsp78 -1
	yyvs67.put (yyval67, yyvsp67)
end
		end

	yy_do_action_566 is
			--|#line <not available> "eiffel.y"
		local
			yyval67: TUPLE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

add_counter 
if yy_parsing_status = yyContinue then
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
			when 850 then
					-- End-of-file expected action.
				report_eof_expected_error
			else
					-- Default action.
				report_error ("parse error")
			end
		end

feature {NONE} -- Table templates

	yytranslate_template: SPECIAL [INTEGER] is
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
			   85,   86,   87,   88,   89,   90,   91,   92,   93,   94,
			   95,   96,   97,   98,   99,  100,  101,  102,  103,  104,
			  105,  106,  107,  108,  109,  110,  111,  112,  113,  114,
			  115,  116,  117,  118,  119,  120,  121,  122,  123,  124,
			  125,  126,  127,  128,  129,  130,  131, yyDummy>>)
		end

	yyr1_template: SPECIAL [INTEGER] is
		once
			Result := yyfixed_array (<<
			    0,  301,  301,  301,  301,  301,  301,  303,  302,  305,
			  306,  275,  275,  307,  275,  277,  277,  277,  308,  276,
			  276,  309,  182,  310,  183,  183,  242,  242,  312,  242,
			  139,  139,  139,  139,  304,  304,  304,  304,  313,  313,
			  314,  314,  219,  219,  257,  257,  315,  258,  258,  316,
			  172,  172,  317,  153,  318,  152,  152,  271,  271,  319,
			  272,  272,  320,  256,  256,  321,  311,  311,  171,  322,
			  323,  268,  268,  325,  241,  326,  326,  240,  240,  239,
			  239,  239,  237,  238,  227,  228,  228,  228,  327,  327,
			  144,  144,  144,  144,  144,  144,  176,  176,  154,  154,

			  285,  285,  285,  328,  286,  286,  329,  200,  200,  201,
			  201,  201,  201,  201,  201,  287,  287,  330,  288,  288,
			  331,  212,  252,  252,  251,  332,  251,  253,  253,  333,
			  162,  173,  173,  173,  246,  246,  334,  245,  245,  335,
			  155,  155,  259,  336,  260,  260,  337,  262,  262,  261,
			  261,  264,  264,  263,  263,  266,  266,  265,  265,  297,
			  297,  338,  298,  298,  339,  235,  340,  341,  273,  273,
			  342,  274,  274,  343,  216,  215,  215,  215,  169,  170,
			  221,  221,  193,  193,  299,  299,  299,  344,  279,  279,
			  345,  280,  280,  346,  185,  324,  324,  186,  186,  186,

			  186,  186,  186,  186,  186,  186,  186,  186,  213,  213,
			  347,  213,  348,  161,  161,  349,  161,  350,  291,  291,
			  351,  292,  292,  352,  229,  229,  229,  231,  231,  233,
			  233,  233,  233,  233,  233,  232,  294,  294,  294,  295,
			  353,  296,  296,  354,  269,  269,  269,  355,  270,  270,
			  356,  174,  174,  174,  175,  357,  300,  300,  267,  267,
			  181,  181,  181,  181,  249,  358,  250,  250,  359,  160,
			  281,  184,  184,  243,  243,  360,  244,  244,  361,  149,
			  362,  363,  282,  282,  364,  194,  194,  194,  194,  194,
			  194,  194,  194,  194,  194,  194,  194,  194,  194,  194,

			  194,  194,  194,  196,  293,  293,  195,  195,  365,  236,
			  236,  236,  159,  289,  289,  289,  366,  290,  290,  367,
			  278,  278,  166,  166,  166,  138,  137,  137,  214,  214,
			  247,  247,  368,  248,  248,  369,  156,  156,  156,  156,
			  156,  156,  217,  217,  217,  218,  218,  218,  218,  218,
			  218,  218,  199,  199,  199,  199,  199,  199,  283,  283,
			  283,  370,  284,  284,  371,  198,  198,  198,  157,  157,
			  157,  157,  158,  158,  133,  133,  135,  135,  146,  146,
			  146,  146,  151,  234,  164,  164,  164,  164,  164,  164,
			  164,  142,  142,  142,  142,  142,  142,  142,  142,  142,

			  142,  142,  142,  142,  142,  142,  142,  142,  142,  165,
			  165,  165,  165,  165,  165,  165,  165,  165,  165,  165,
			  167,  372,  167,  167,  167,  167,  168,  168,  168,  179,
			  148,  148,  148,  148,  148,  148,  202,  202,  203,  203,
			  205,  204,  147,  147,  197,  197,  180,  180,  180,  132,
			  134,  163,  163,  163,  163,  163,  163,  163,  254,  254,
			  254,  373,  255,  255,  374,  177,  177,  178,  178,  140,
			  140,  140,  140,  140,  140,  141,  141,  141,  141,  141,
			  141,  141,  141,  141,  145,  145,  150,  150,  187,  187,
			  187,  188,  188,  189,  190,  190,  191,  192,  192,  206,

			  206,  206,  208,  207,  207,  209,  209,  210,  211,  211,
			  143,  220,  220,  223,  223,  223,  224,  222,  222,  222,
			  222,  222,  222,  222,  222,  222,  222,  222,  222,  222,
			  222,  222,  222,  222,  222,  222,  222,  222,  222,  226,
			  226,  226,  226,  225,  225,  225,  225,  225,  225,  225,
			  225,  225,  225,  225,  225,  225,  225,  225,  225,  225,
			  225,  136,  136,  375,  230,  230,  376, yyDummy>>)
		end

	yytypes1_template: SPECIAL [INTEGER] is
		once
			Result := yyfixed_array (<<
			    1,    1,    1,    1,    1,    2,    2,   86,    1,    1,
			   86,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,   10,    1,    1,    1,    1,    7,    3,    1,    3,
			    1,    3,    1,    5,    1,    4,    4,    1,    1,    1,
			    1,    1,    1,    1,    2,    1,    1,    1,    1,    1,
			    1,    1,    1,    2,    1,    1,   11,   14,   17,   18,
			   19,    4,   21,   21,   23,   30,   35,   35,   35,   35,
			   35,    2,    2,    2,   47,   47,   47,   47,   55,   56,
			   56,   56,   57,   57,   57,   57,   63,   64,   65,   65,

			   65,   65,   67,   68,   71,   71,    1,    1,    1,    1,
			    1,    2,    2,   68,   68,   68,    1,    6,    1,    1,
			   69,   95,   69,   44,   86,   44,    1,    1,    1,    1,
			    1,    1,    1,   65,    1,    7,    5,    1,    1,    2,
			    2,   53,   68,    1,    1,   78,   65,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,   65,   68,    1,    1,    7,
			    5,    1,    2,   71,   71,   71,    1,   67,   68,   68,
			    1,   14,   68,    2,   68,   35,   35,    1,   35,    1,
			    1,   35,   68,    1,    1,   35,    1,    1,    1,    1,

			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    2,    1,   35,   78,    1,
			    1,    1,    1,    1,    1,    1,    1,    2,    5,    2,
			    2,    1,    1,    2,   47,   47,   47,   47,   47,   47,
			   68,    1,   94,    1,    1,    1,    1,    1,    1,   95,
			    2,   85,   86,    1,    1,    1,   17,   17,   19,    4,
			   23,   30,    2,   44,   47,   57,   57,   57,   57,   57,
			   57,   65,   68,   72,    2,    2,   12,   21,    2,    2,
			   52,   68,   35,    1,   89,    1,    2,    1,   78,    1,
			    2,   21,   35,   35,   78,    1,    1,    1,   78,    1,

			   13,   89,    1,    1,   85,   85,   21,   35,   35,   35,
			   35,   35,   35,   35,   35,   35,   35,   35,   35,   35,
			   35,    1,   35,   35,    1,   35,   35,   35,    2,   21,
			   21,    2,    1,    1,    1,    1,   94,   94,    1,    1,
			    1,   94,   94,    2,    1,    1,   95,   85,   69,   86,
			   72,    3,   67,    1,    1,    1,   89,   89,    1,   78,
			    1,    1,   89,    2,    1,   78,    2,   89,    1,   78,
			    1,   65,    2,    1,    2,   13,    1,    1,    1,   85,
			   78,   35,   35,   89,   78,    1,   68,   94,    1,   82,
			    1,    1,    1,    3,    2,   72,   12,   52,    1,   35,

			   53,   68,   89,   89,   78,    1,   78,    1,   89,   78,
			    2,   21,    1,   94,    1,   82,    1,   65,   85,   68,
			   72,    1,   89,    1,    1,   78,   89,    1,    1,    1,
			   41,   42,    2,   82,   65,    1,   65,    1,    1,   94,
			    2,    2,   42,   82,    1,   65,    1,   90,   89,    1,
			   96,    1,    1,   90,    1,   68,   82,    2,   54,   54,
			   90,   75,   75,    1,   81,   94,   90,    1,    1,   74,
			    3,    1,   28,   75,   81,   81,    1,    1,    1,    1,
			    1,   77,   81,   81,   81,   91,   90,   74,   80,   80,
			    1,   25,   83,   25,   83,   75,    3,   71,   81,   81,

			   81,   91,   81,    1,   77,   81,   81,   81,   81,   81,
			   81,    3,   77,   77,   27,   71,   74,    1,    1,   25,
			   39,   80,    1,   83,   81,   81,   75,   81,   58,   71,
			   91,   34,   77,   83,   81,   81,    3,   81,   74,    1,
			    1,    1,   50,   25,   39,   80,    2,   83,    1,   91,
			    1,   77,    1,   40,   81,   81,    3,   81,    1,    1,
			    1,   50,   86,   25,   83,   38,   79,   38,   80,   83,
			    1,   81,    1,    2,   71,   71,   77,    1,    3,   81,
			   74,   94,   94,   93,   93,    3,   79,    1,   71,   81,
			    1,    1,   91,    1,   65,    3,    1,    1,   35,    2,

			   66,   93,   79,   81,   38,   71,   83,    1,    1,   65,
			   65,    1,    1,    1,   93,    1,    1,    1,    1,   20,
			   95,    1,    1,   35,    1,   93,   81,   86,   68,    1,
			   95,    1,    1,    1,    1,   62,   65,    1,    2,   95,
			    1,   86,   68,    1,   59,    2,    1,    1,   86,    1,
			   62,    2,    1,   59,    1,   95,    9,   17,   26,   86,
			    3,   86,    1,   59,   93,   95,    1,    1,    1,    6,
			   36,   48,   61,   86,   86,   62,   86,   86,   93,   95,
			   87,    1,   37,   65,   87,    1,   33,    3,   62,   87,
			   65,    1,   33,    1,   87,    8,    7,    1,    1,    1,

			    1,    1,    1,    1,   15,   16,   18,   21,   24,   29,
			   31,   35,   35,   35,    2,   43,   45,   46,   46,   51,
			   60,   87,   33,   93,   87,    3,    1,    1,   35,   35,
			   87,    1,   92,   93,    7,   11,    2,   68,    1,   68,
			    1,    1,    1,   87,    1,   93,   35,   35,   73,   73,
			    1,    1,   93,    1,   92,   87,    3,   13,   11,   11,
			    1,   35,   35,   35,   87,    3,    1,    1,   22,   73,
			   87,   93,    1,   70,   65,   92,    3,   13,   13,   11,
			   87,   22,   73,    3,    1,   76,   87,   76,   35,    2,
			    1,   92,    1,   13,    3,   23,    2,   47,   49,   56,

			   68,   88,   73,   87,    3,   87,    3,    1,   32,   76,
			    1,   35,    1,    1,    1,    1,   88,    1,   22,    3,
			   35,   76,   35,    1,   92,   23,    2,   56,   68,   23,
			    2,   47,   56,    2,   47,   56,   68,    1,   23,    2,
			   47,   56,    1,    1,   76,   87,   88,   87,   87,    3,
			    1,    1,    1, yyDummy>>)
		end

	yytypes2_template: SPECIAL [INTEGER] is
		once
			Result := yyfixed_array (<<
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    2,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    2,    2,    1,    1,    1,    1,
			    1,    1,    1,    3,    1,    1,    1,    1,    1,    1,
			    1,    1,    4,    4,    1,    1,    1,    1,    1,    1,
			    1,    5,    1,    6,    1,    1,    1,    3,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    3,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    3,    1,
			    3,    1,    1,    1,    1,    1,    7,    8,    1,    1,

			    1,    1,    9,    1,    1,    1,    1,    1,    1,    1,
			    1,   10,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
			    1,    1, yyDummy>>)
		end

	yydefact_template: SPECIAL [INTEGER] is
		once
			Result := yyfixed_array (<<
			   11,    7,   14,    0,  468,  467,    0,   38,    1,  166,
			   23,  530,  538,  537,  536,  535,  534,  533,  532,  531,
			  529,  528,  527,  526,  525,  524,  523,  522,  521,  520,
			  519,  409,  515,  518,  514,    0,  454,    0,    0,  458,
			    0,    0,    0,  453,    0,  485,  484,  566,    0,    0,
			  563,    0,    0,    0,  510,  517,  502,  486,  493,    0,
			    0,    0,    0,  429,    0,    0,  378,  410,  451,  390,
			  481,  475,  455,  381,  480,  456,  418,    3,  386,  419,
			  387,  446,    0,  458,  476,  384,  427,  477,  379,  380,
			  439,  438,  478,  385,  428,  479,  411,  344,  482,  513,

			  511,  512,  452,  426,  447,  448,    0,    0,    0,  466,
			    0,  465,  236,    2,  227,  228,   39,   40,    0,   40,
			  164,    6,    0,   21,   12,    0,    0,    0,    0,  542,
			  541,  540,  539,   83,  357,  354,  355,    0,    0,  446,
			  358,    0,  356,    0,  461,  436,  483,  560,  559,  558,
			  557,  556,  555,  554,  553,  552,  551,  550,  549,  548,
			  547,  546,  545,  544,  543,   82,    0,    0,    0,  417,
			  416,    0,   79,   80,   81,  414,  564,    0,    0,    0,
			  561,    0,  376,  358,    0,    0,  412,  173,  424,  504,
			  492,  422,    0,  503,  491,  423,    0,  421,    0,    0,

			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,  425,  449,    0,
			    0,  507,  487,  496,    0,    0,    0,  236,  234,  233,
			  236,    0,    0,  232,  231,  488,  489,  490,  494,  495,
			    0,  240,  235,   41,   35,    0,   40,   40,   34,  166,
			  170,  167,   23,   29,    0,    0,   28,   31,  473,  469,
			  470,    0,   30,   22,  471,  472,  499,  500,  501,  505,
			  506,  474,    0,   66,  358,  358,  443,  431,  446,  458,
			  442,    0,    0,  361,  342,    0,    0,  459,    0,    0,
			  358,  430,    0,  464,    0,    0,    0,  383,    0,    0,

			  372,  345,  376,  457,    0,    0,  432,    0,  397,  396,
			  395,  394,  393,  392,  391,  404,  406,  405,  407,  388,
			  389,    0,  398,  403,    0,  400,  402,  408,  358,  434,
			  435,  458,  509,  498,  508,  497,  230,  229,    0,    0,
			  237,    0,    0,  244,   37,   36,  163,    0,    0,   20,
			    0,   32,    0,    0,   67,   25,  351,  348,    0,  450,
			  353,  359,    0,  358,  458,    0,  458,  349,  415,    0,
			  565,  516,  358,  562,  458,  373,    0,    0,  413,  172,
			    0,  399,  401,  346,  440,  238,  243,  239,  247,  180,
			    0,    0,    0,   33,   30,   66,  444,  445,  365,  367,

			  364,  426,    0,  343,  437,  460,  441,    0,  350,  377,
			  358,  433,  420,    0,  245,    0,    0,   42,  169,   66,
			   27,   24,    0,  366,  360,  463,  347,    0,    0,    0,
			  255,  250,  253,    0,  181,    0,  100,  165,    0,  242,
			  251,  252,  256,    0,  246,   43,  103,    9,  363,    0,
			  254,    0,  101,    0,  332,  258,  249,  236,  106,  107,
			  102,  134,    0,  143,  257,  109,    0,  108,  136,   46,
			  339,  336,  335,  331,    0,    0,  149,  157,  117,  153,
			  125,  147,  151,  155,    0,  122,  105,    0,   10,    0,
			   59,  143,  341,  143,  338,    0,  259,  146,  142,  150,

			  158,    0,  154,  126,    0,  148,  151,  152,  155,  156,
			    0,  114,  123,  147,  139,    0,  135,  306,   54,   52,
			   49,   45,   57,    0,  340,  337,  334,    0,  120,    0,
			  116,  129,  124,  143,  155,    0,  113,  151,    0,    0,
			    0,  308,   11,   55,   69,    0,   62,    0,    0,    0,
			    0,    0,  132,   66,  133,    0,  112,  155,    0,  240,
			  240,  220,    0,   53,   56,   65,   51,   75,   48,    0,
			   58,  145,    0,   79,   77,  121,  128,  130,  111,    0,
			  138,    0,    0,  307,    0,    8,   69,   76,   73,   70,
			    0,    0,  119,    0,   78,  110,  141,    0,   66,  446,

			  223,  219,   64,    0,    0,   74,   61,   87,   86,   85,
			   88,  140,  224,   66,    0,   75,   11,    0,  161,  195,
			    0,   89,   84,   66,  226,  222,   72,   42,   96,  159,
			  166,   68,   11,    0,  225,   92,  208,    0,   15,    0,
			  196,   42,   96,  210,  184,   97,   11,   18,   90,  160,
			   94,    0,  212,  220,  187,    0,   15,   98,   15,   42,
			   16,   23,   11,  220,  209,  166,  195,    0,  195,  177,
			  176,  175,  213,   99,   91,   93,    0,   42,  211,  186,
			  183,  190,  180,  179,  182,  215,  320,   17,   95,    0,
			  178,  217,  220,  195,    0,  207,  454,    0,    0,  195,

			  313,  220,    0,    0,  200,  199,  390,  381,  206,  197,
			  205,  198,    0,  419,  446,  202,  203,  193,  195,  204,
			  201,  189,  220,  214,  321,  174,    0,    0,  275,    0,
			  304,  316,  195,    0,  375,  376,  374,  376,    0,    0,
			    0,    0,    0,    0,  194,  216,  329,  327,    0,    0,
			  195,  220,  309,  314,    0,    0,  382,  370,  376,  376,
			  376,  325,  328,  326,  192,  271,  195,  280,  278,  274,
			  265,  305,    0,    0,  319,    0,  312,  371,  368,  376,
			    0,    0,    0,  260,  195,    0,    0,    0,  311,  446,
			    0,    0,  315,  369,  272,  287,  289,  285,  284,  295,

			    0,  281,  277,  270,  262,    0,  261,    0,  268,  264,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,  263,
			    0,    0,  310,  195,  318,  288,  294,  302,    0,  293,
			  290,  291,  297,  292,  286,  300,    0,    0,  301,  296,
			  299,  298,  195,  195,  267,    0,  283,  279,  269,  303,
			    0,    0,    0, yyDummy>>)
		end

	yydefgoto_template: SPECIAL [INTEGER] is
		once
			Result := yyfixed_array (<<
			   66,  735,  276,  300,   67,  704,  705,  256,  257,   68,
			   69,   70,  619,   71,   72,  277,   73,  768,   74,  708,
			  491,  519,  658,  514,  472,  709,   75,  710,  808,  686,
			  531,   76,  293,   78,  712,   79,   80,  670,  682,  565,
			  520,  553,  430,  431,  638,  112,   81,   82,   83,  715,
			  123,  263,  716,  717,  718,  264,   84,   85,  237,   86,
			   87,  671,  798,  542,  719,  280,  400,  141,  458,  459,
			   88,   89,   90,   91,  265,   92,   93,  268,   94,   95,
			  528,  644,  720,  672,  635,   96,   97,  636,   98,  417,
			   99,  100,  101,  165,  133,  594,  610,  600,  102,  386,

			  114,  115,  103,  120,  773,  104,  105,  497,  575,  588,
			  273,  748,  769,  516,  469,  461,  473,  785,  809,  481,
			  513,  532,  145,  294,  566,  488,  521,  474,  498,  505,
			  506,  507,  508,  509,  510,  464,  589,  389,  433,  533,
			  547,  251,  304,    7,  124,  648,  694,  680,  721,  786,
			  801,  284,  402,  447,  460,  485,  530,  732,  775,  583,
			  601,  752,  242,  341,  387,  620,  121,  655,  450,  850,
			    8,    9,  118,  454,  517,   10,  661,  252,  125,  355,
			  350,  119,  244,  489,  545,  544,  543,  523,  569,  586,
			  567,  604,  681,  603,  590,  622,  453,  466,  501,  549,

			  504,  551,  487,  538,  475,  527,  630,  249,  122,  348,
			  347,  305,  665,  689,  743,  653,  663,  692,  722,  584,
			  614,  342,  413,  415,  443,  442,  787,  821,  749,  782,
			  781,  818,  816,  561,  754,  791,  462,  495,  362,  422,
			  307,  288,  369,  181,  177, yyDummy>>)
		end

	yypact_template: SPECIAL [INTEGER] is
		once
			Result := yyfixed_array (<<
			  449,  973, 1892, 1396, -32768, -32768,  325,   35, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768,  809,  371,   61,  261,   29,
			 2033, 2313,  927,  370,  361, -32768, -32768,  929,  325,  325,
			  924,  927,  250,  325, -32768, -32768, -32768, -32768, -32768, 1396,
			 1396,  944, 1396, -32768, 1747, 1630,  942, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768,  917, 2439, -32768, -32768,
			 -32768,  926, 1396,  830, -32768, -32768, -32768, -32768,  931,  930,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,

			 -32768, -32768, -32768,  803, -32768, -32768,  276,  126,  276, -32768,
			  429, -32768,  744, -32768, -32768, -32768, -32768,  833,  895,  233,
			   31, -32768,  250,  511, -32768, 1864,  250,  250,  244, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768,  325, 1396,  923,
			  804,  922, -32768,  276,  901, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768,  920,  250,  244, -32768,
			 -32768, 1396, -32768, -32768, -32768, -32768, -32768, 1396,  897,    7,
			 -32768, 1396,  343,  804,  886, 2344, -32768,  863, -32768, -32768,
			 -32768, -32768,  592, -32768, -32768, -32768,  244, -32768, 1396, 1396,

			 1396, 1396, 1396, 1396, 1396, 1396, 1396, 1396, 1396, 1396,
			 1396, 1279, 1396, 1162, 1396, 1396,  250, -32768, -32768,  244,
			  244, -32768, -32768, -32768,  250,  620,  606,  744, -32768, -32768,
			  744,  878,  873, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			  214,  857, -32768, -32768, -32768,  276,  833,  833, -32768, -32768,
			  185, -32768, -32768, -32768,  568,  533,  811, -32768, -32768, -32768,
			 -32768,    1,  861, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768,  824,  667,  804,  804,  825, -32768, -32768,  830,
			 -32768,  852, 2326,  846, -32768,  244,  842, -32768, 1396,  250,
			  804, -32768, 2284, 2266,  839, 2057,  250, -32768,  843,  250,

			 -32768, -32768,  343,  321,  841,  250, -32768, 1396,  538,  538,
			  538,  538,  538,  974,  974,  896,  896,  896,  896,  896,
			  896, 1396, 2058, 2401, 1396, 2455, 2367, -32768,  804, -32768,
			 -32768,  830, -32768, -32768, -32768, -32768, -32768, -32768,  853,  847,
			 -32768,  821,  325,  816, -32768, -32768, -32768,  835,  827, -32768,
			  832, -32768,  799, 1864, -32768, -32768, -32768, -32768,  244, -32768,
			 -32768, -32768, 1513,  804,  830,  814,  830, -32768, -32768,  831,
			 -32768, -32768,  804, -32768,  830, -32768,  250,  244, -32768, -32768,
			  802, 2058, 2455, -32768, -32768, -32768,  378, -32768,  800,  553,
			  250,  325, 1864, -32768, -32768,  667,  825, -32768,  809, 2439,

			  792,  133,  779, -32768, -32768, -32768, -32768, 1396, -32768, -32768,
			  804, -32768, -32768,  781, -32768,  123, 2080,  521, -32768,  667,
			 -32768, -32768,  780, -32768, -32768, -32768, -32768,  325,  276,  276,
			 -32768,  770, -32768,  762, -32768, 2033,  725, -32768, 1513, -32768,
			 -32768, -32768,  754,  753, -32768, -32768,  519, -32768, -32768,  276,
			 -32768,  123, -32768,  276,  819,  755, -32768,  744,  756,  752,
			 -32768,  726,  504, -32768, -32768,  282,  276, -32768, -32768,  424,
			   89,   89,  715, -32768,  718,  244,  413,  413,  534,  413,
			  397,  665,  660,  602,  712,  703, -32768,  244, -32768,  658,
			  721, -32768,  309, -32768,  309,  504, -32768, 1048, -32768, -32768,

			 -32768,  244, -32768, -32768,  663, -32768,  660, -32768,  602, -32768,
			  688, -32768, -32768,  665,  826,  266, -32768,  683, -32768,  716,
			  274, -32768, -32768,  276, -32768, -32768, -32768,  713,  475,  697,
			 -32768,  391, -32768,  364,  602,  685, -32768,  660,  705,  698,
			  689, -32768,  551,  663, -32768,  658,  681,  675,  244,  670,
			  244,  663, -32768,  667, -32768,  637, -32768,  602,  244, -32768,
			 -32768,  166,  626, -32768, -32768,  438, -32768,  603, -32768,  662,
			 -32768, -32768,  244,  659, -32768, -32768, -32768, -32768, -32768,  616,
			 -32768,  642,  636, -32768, 1396, -32768, -32768, -32768,   40, -32768,
			  244,  276, -32768, 1979, -32768, -32768, -32768,  635, 2386,  445,

			 1161, -32768, -32768,  639,    5, -32768, -32768, -32768, -32768, -32768,
			  618, -32768, -32768, 1045, 1396,  603,  551,  325,  629, -32768,
			   -6, -32768, -32768, 2386, -32768, -32768, -32768,  521,  612, -32768,
			 -32768,  387,  551,  325, -32768, -32768,  578,  250,  222,  625,
			 -32768,  521,  612,  586,  572, -32768, 2009,  563, -32768, -32768,
			 -32768,  543, -32768,  798,  590,  577,  566, -32768,  566,  521,
			 -32768, -32768,  551,  798, -32768, -32768, -32768, 2080, -32768, -32768,
			 -32768, -32768,  548, -32768, -32768, -32768,  544,  521, -32768, -32768,
			 -32768,  554,  553, -32768, -32768,  477,  476, -32768, -32768,  928,
			 -32768, -32768,   46, -32768,  497, -32768,  310, 1396, 1396, -32768,

			  527,  484,  127,  379, -32768, -32768,  536,  523, -32768, -32768,
			 -32768, 2439,  516,  509,  178, -32768, -32768,  654, -32768, -32768,
			 -32768, -32768,   46, -32768, -32768, -32768, 1396, 1396, 2243, 2207,
			  428,  451, -32768,  427, -32768,  343, -32768,   28,   49,  433,
			 1396, 1396, 1396,  928,  387, -32768, 2439, 2439,  455,  240,
			 -32768,  377,  313, -32768, 2080,  341, -32768, -32768,  343,  343,
			   28, 2439, 2439, 2439, -32768, -32768, -32768, -32768,  412, -32768,
			  389, -32768, 1396,  297,  335,  326, -32768, -32768, -32768,  343,
			  281,  613,  240, -32768, -32768,  374,  275,   81, 2439,  149,
			 1396,  296, -32768, -32768, -32768,  324,  308,  293,  181,  232,

			  701, -32768, -32768, -32768, -32768,  106, -32768, 1396,  161, -32768,
			 1396, 2225, 2080,    6,  613,  652,  110,  613,  -26, -32768,
			 1945,   81, 2439, -32768, -32768, -32768, -32768, -32768,   74, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768,  156,  613, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768,   73, -32768, -32768, -32768, -32768,
			   71,   42, -32768, yyDummy>>)
		end

	yypgoto_template: SPECIAL [INTEGER] is
		once
			Result := yyfixed_array (<<
			 -32768, -208,  707, -286, -32768, -32768, -32768, -32768,  418, -32768,
			 -550, -105, -32768, -106, -32768, -127, -599, -32768, -119, -32768,
			 -442, -32768, -32768, -32768, -32768, -32768, -101, -32768, -32768, -32768,
			 -32768, -32768,   -1,  524, -32768, -600, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768,  421,  -24,    0,  -55,   26, -32768,
			 -32768, -32768, -32768, -32768, -32768,  -67,   -7,  -13, -32768,  -53,
			 -102, -32768, -32768, -32768, -32768,  677, -32768, -32768, -32768, -32768,
			 -32768, -394, -32768, -32768, -32768, -110, -112, -32768, -113, -118,
			 -32768, -32768, -32768, -32768, -209, -32768, -32768,  645,  -29,  351,
			 -398,  736, -32768,  439, -32768, -32768, -32768, -32768,  769,   -2,

			  580, -32768,  -37, -32768, -32768,  -35,  -41,  -34,  436, -32768,
			 -237, -32768,  245,  470, -32768, -32768,  528, -32768,  200,  537,
			 -32768,  468,    4, -132,  434, -32768,  469, -162,  465,  547,
			  498,  545, -458,  539, -339, -32768,  394, -32768,  557, -405,
			  415, -279, -32768, -512, -231,    8, -32768, -197,  259,  213,
			  162,    2,  559, -32768,  522, -32768,  406, -32768,  172, -593,
			  373, -32768, -191,   43,  555, -32768, -232, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -304,
			 -32768, -32768,  -94, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -586, -32768, -32768, -32768, -32768, -32768, -32768, -32768,

			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, yyDummy>>)
		end

	yytable_template: SPECIAL [INTEGER] is
		once
			Result := yyfixed_array (<<
			    6,  142,   77,  174,  113,  166,  260,  270,  239,  173,
			  175,  146,  269,  267,  182,  266,  375,  346,  434,  259,
			  258,  349,  215,  239,  261,  248,  379,  192,  192,  493,
			  562, -162,  618,  631,  633,   -4,  336,   57,  139,  337,
			    5,  291,  852,  234,  172,  617,  178,  179,  534,  298,
			   47,  184,  183,  137,  299,  297,  144,  238,  185,  186,
			  664,  188,    5,    4,  140,  492,  494,  -71,  351,  306,
			  678,  851,  238,  240,  842,  632,  143, -162,   42,  557,
			  -71,  217,  227,    5,  230,    4,  616,  218,  272,  713,
			  707,  421,  329,  330, -162, -162,  271,  236,  117,  723,

			  224,  563, -162,  235,  627,  222,    4,  229,  733,  116,
			  233,  418,  236, -218,  296,  437,  395, -162,  235,  286,
			  641,  -71,  250,  -55,  734,  262,  274,  275,  278,  745,
			  215,  215,  744,  215,  659,  281,  490,  282,  564,  706,
			  849, -218,  452,  713,  707,  734,  -55,  807,  226,  225,
			  677,  837,  344,  345,  279,  420,  365,  111,  771,  224,
			    5,    5,  215,  223,  222,  221,  -55,  290,  278,  535,
			  292,  339,  338,  819,  137,  380,  503,  132,  131,  -55,
			  109,  742,  224,    4,    4,  301,  223,  228,  216,  810,
			  130,  129,  429,  706,  279,  555,  278,  308,  309,  310,

			  311,  312,  313,  314,  315,  316,  317,  318,  319,  320,
			  322,  323,  325,  326,  327,  428,  328,  216,  579,  278,
			  278,  343,  279,  734,  331, -168, -266,  215, -266,  339,
			  338, -168,  741, -218,  260,  270,  817,  215,  215,  423,
			  269,  267, -218,  266,  223,  279,  279,  259,  258,  577,
			  411,  239,  261,  215,  215,  215,  215,  215,  215,  215,
			  215,  215,  215,  215,  215,  215,  465,  215,  215,  683,
			  215,  215,  215,  260,  270,  425,  356,  357,    5,  269,
			  267, -282,  266,  359,    5,  278,  259,  258,  138,  366,
			  239,  261,  367,  540,  612,    5,  372,  815,  647,  374,

			  238,    4,  247,  646,  243,  250,  539,    4,  137,  624,
			  111,  363,  814,  727,  499,  500,  272,  502,    4,  634,
			  381,   41,  136,  382,  271,  401,  215,  215,  813,  524,
			  383,  525,  246,  109,   37,  384,  128,  812,   41,  238,
			  236,  -47,  806,  -56,  215,  767,  235,  377,  794,  127,
			  -47,   37,  480,  394,  -47,  272,  774,  135,  278,  111,
			  376,  399,  110,  271,  726,  403,  -56,  134,  404,  299,
			  406,  554,  792,  479,  408,  478,  410,  278,  409,  236,
			  477, -317,  109,  476,  279,  235,  -56,  799,  171,  419,
			  250,  432,  394,  552,  108,    5,  168,  128,  639,  -56,

			  790,  401, -131,  279,  440,  441,  445,  107,  776,  167,
			  127, -131,  426,  111,  774,  738,  110,  772,    4,  827,
			  832,  835,  170,  841,  106,  640, -241,  432, -241,  457,
			  676, -131,  650,  679,  174,  354,  109,  399,   41,  784,
			  173,  804,  457,  799,  232,  231,  174, -143,  108,  757,
			  675,   37,  173,  515,  784, -131,  783,  169, -127,   58,
			  174,  107, -131,    5,  -66, -131,  173,  529,  688,  760,
			 -143,  684,  777,  778,  375,  172,  137, -276,  106, -276,
			 -218, -218, -127,    5,  216,  613,    4,  172,  -66, -127,
			 -143,  -44, -127,  793,  756,  -66,  724,  753,  -66,  546,

			  -44,  172,  730, -143,  -44,  -63,    4,  174,  751,  174,
			  -63,  -19, -323,  173,  -63,  173,  574,  174,  -63,  740,
			  766,    3,  765,  173,  515,    2, -324,  260,  270,  758,
			  759,  174,    1,  269,  267,  755,  266,  173,  529, -322,
			  259,  258, -118,  215,  239, -118,  471,  470,  172,  174,
			  573, -218,  779,  770,  731,  173,  574,  354,  172,  198,
			   63,  -66,  -66,  194,  725,  193, -118,  546,  215,  780,
			  -19,  693,  172, -118,  -19,  -19, -118,  691,  -19,  -66,
			  -19,  416,  -19,  598,  599,  -19,  -66,  803,  191,  195,
			  573,  -66,  640,  238,  -19,  -66,  -19,  -19,  190,  -66,

			  189, -115,  581,  582, -115,  -19,  435,  226,  225,  272,
			  -19,  687,  623,  598,  599,  628,  685,  271,  224, -188,
			 -188, -188, -188,  222,  662, -115,  845,    2,  232,  231,
			  660,  642, -115,  236, -188, -115,  335,  645,  334,  235,
			  669,  668,  647,   58,   57,  847,  848,    5,  667, -188,
			  333,  652,  332, -185, -185,  654,  215, -188, -188, -188,
			  137, -185,  795,  666,  673,  737,  674,  232,  231,  637,
			    4,  649,  643,  215,  215,  629, -185,  587,  621,  239,
			  615,  611,   58,  595,  597,   42,    5,  593,  711,  714,
			  596,  215,  215,  585,  825,  829,  728,  729,  838,  137,

			  477,  739,  736,  591,  578,  354,  215,  215,  215,    4,
			  490,  572,  239,  239,  797,  239,  339,  338,  795, -191,
			 -191, -191, -191,  570,   42,  746,  747,  224,  238,  -60,
			  518,  223,  222,  215, -191,  239,  560,  736,  736,  761,
			  762,  763,  711,  714,  800,  559,  558,  831,  834, -191,
			  840,  479,  556,  550,  548,  536,  215, -191, -191, -191,
			  736,  238,  238,  541,  238,  215,  476,  215,  236,  522,
			  797,  788,  789,  480,  235, -333,  828,  800,  836,  511,
			  800,  796, -333,  -50,  238,  496,  468, -333,  -50,  811,
			  467, -333,  -50,  241,  451, -333,  -50,  463, -104, -104,

			  800,  236,  236,  446,  236,  449,  820,  235,  235,  822,
			  235,  -26,  444,  826,  830,  833, -104,  839,  226,  225,
			 -248,  438,  427, -104,  236,  424,  -26,  -26, -104,  224,
			  235,  283, -104,  223,  222,  221, -104,  796, -362,  226,
			  225,  -26,  -26,  -26,  -26,  -26,  -26,  -26,  126,  -26,
			  414,  358,  412,  -26,  223,  222,  221,  144,  -26,  -26,
			  405, -218, -218,  -26,  -26,  388,  393,  391,  -26, -218,
			  -26,  385,  407,  392,  -26,  -26,  390,  335,  -26, -330,
			  -26, -218,  -26,  333, -218,  -26, -330,  378,  373,  370,
			  364, -330,  361, -137,  -26, -330,  -26,  -26, -137, -330,

			  297,  353, -137,  194,  243,  -26, -137,  340,  190, -171,
			  -26,  204,  203,  202,  201,  200,  199,  198,   63,  -26,
			  -26,  -26,  302,  -26,  -26,  -26,  -26,  -26,  -26,  -26,
			  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,  -26,
			  -26,  -26,  -26,   65,   64,  295,  289,  287,  285, -352,
			   63,   62,   61,   60,  245,   59,  220,  219,   58,   57,
			   56,   55,    5,   54,  703,  216,  197,   52,  196,  180,
			  702,  187,   50,   -5,  137,   49,   48,   47,  592,  176,
			   46,   45,  439,   44,  824,    4,  701,  625,  486,   43,
			  700,  202,  201,  200,  199,  198,   63,  448,  805,  846,

			   42,  699,  764,  698,  484,   41,  606,  697,  456,  626,
			  483,  537,  482,  571,  568,   40,   39,   38,   37,  576,
			  602,  844,  512,  526,  696,  695,  605,  802,  580,  455,
			  352,  371,  609,  690,   35,  397,   34,   33,   32,   31,
			   30,   29,   28,   27,   26,   25,   24,   23,   22,   21,
			   20,   19,   18,   17,   16,   15,   14,   13,   12,   11,
			   65,   64,  436,  651,  657,  396,    0,   63,   62,   61,
			   60,    0,   59,    0,    0,   58,   57,   56,   55,    5,
			   54,   53,    0,  354,   52,    0, -144,   51,    0,   50,
			 -144, -144,   49,   48,   47, -144,    0,   46,   45,    0,

			   44,    0,    4,    0,    0,    0,   43,    0, -144,    0,
			    0,    0,    0,    0,    0, -144,    0,   42,    0,    0,
			 -144,    0,   41,    0, -144,    0,    0,    0, -144,    0,
			    0,    0,   40,   39,   38,   37,    0,    0,    0, -144,
			    0,   36,    0,    0,    0,    0, -144,    0,    0, -144,
			    0,   35,    0,   34,   33,   32,   31,   30,   29,   28,
			   27,   26,   25,   24,   23,   22,   21,   20,   19,   18,
			   17,   16,   15,   14,   13,   12,   11,   65,   64,    0,
			    0,    0,    0,    0,   63,   62,   61,   60,    0,   59,
			    0,    0,   58,   57,   56,   55,    5,   54,   53,    0,

			    0,   52,    0,    0,   51,    0,   50,    0,    0,   49,
			   48,   47,    0,    0,   46,   45,    0,   44,    0,    4,
			    0,    0,    0,   43, -221, -221,    0,  324, -221,    0,
			    0,    0, -221,    0,   42,    0,    0, -221,    0,   41,
			    0,    0,    0,    0, -221,    0,    0, -221,    0,   40,
			   39,   38,   37,    0,    0,    0, -221,    0,   36,    0,
			    0,    0,    0,    0, -221, -221,    0,    0,   35,    0,
			   34,   33,   32,   31,   30,   29,   28,   27,   26,   25,
			   24,   23,   22,   21,   20,   19,   18,   17,   16,   15,
			   14,   13,   12,   11,   65,   64,    0,    0,    0,    0,

			    0,   63,   62,   61,   60,    0,   59,    0,    0,   58,
			   57,   56,   55,    5,   54,   53,    0,    0,   52,    0,
			    0,   51,    0,   50,    0,    0,   49,   48,   47,    0,
			    0,   46,   45,    0,   44,    0,    4,    0,    0,    0,
			   43,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,   42,    0,    0,    0,    0,   41,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,   40,   39,   38,   37,
			    0,    0,    0,    0,    0,   36,    0,    0,    0,  321,
			    0,    0,    0,    0,    0,   35,    0,   34,   33,   32,
			   31,   30,   29,   28,   27,   26,   25,   24,   23,   22,

			   21,   20,   19,   18,   17,   16,   15,   14,   13,   12,
			   11,   65,   64,    0,    0,    0,    0,    0,   63,   62,
			   61,   60,    0,   59,    0,    0,   58,   57,   56,   55,
			    5,   54,   53,    0,    0,   52,    0,    0,   51,    0,
			   50,    0,    0,   49,   48,   47,    0,    0,   46,   45,
			    0,   44,    0,    4,    0,    0,    0,   43,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,   42,    0,
			    0,    0,    0,   41,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,   40,   39,   38,   37,    0,    0,    0,
			    0,    0,   36,    0,    0,    0,    0,    0,    0,    0,

			    0,    0,   35,    0,   34,   33,   32,   31,   30,   29,
			   28,   27,   26,   25,   24,   23,   22,   21,   20,   19,
			   18,   17,   16,   15,   14,   13,   12,   11,   65,   64,
			    0,    0,    0,    0,    0,   63,   62,   61,   60,    0,
			   59,    0,    0,   58,   57,   56,   55,    5,   54,   53,
			    0,    0,   52,    0,    0,   51,    0,   50,    0,    0,
			   49,   48,   47,    0,    0,   46,   45,    0,   44,    0,
			    4,    0,    0,    0,   43,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,   42,    0,    0,    0,    0,
			   41,    0,    0,    0,    0,    0,    0,    0,    0,    0,

			   40,   39,   38,   37,    0,    0,    0,    0,    0,   36,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,  398,
			    0,   34,   33,   32,   31,   30,   29,   28,   27,   26,
			   25,   24,   23,   22,   21,   20,   19,   18,   17,   16,
			   15,   14,   13,   12,   11,   65,   64,    0,    0,    0,
			    0,    0,   63,   62,   61,   60,    0,   59,    0,    0,
			  194,   57,  193,   55,    5,   54,   53,    0,    0,   52,
			    0,    0,   51,    0,   50,    0,    0,   49,   48,   47,
			    0,    0,   46,   45,    0,   44,    0,    4,    0,    0,
			    0,   43,    0,    0,    0,    0,    0,    0,    0,    0,

			    0,    0,   42,    0,    0,    0,    0,   41,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,   40,   39,   38,
			   37,    0,    0,    0,    0,    0,   36,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,   35,    0,   34,   33,
			   32,   31,   30,   29,   28,   27,   26,   25,   24,   23,
			   22,   21,   20,   19,   18,   17,   16,   15,   14,   13,
			   12,   11,   65,   64,    0,    0,    0,    0,    0,   63,
			   62,   61,   60,    0,   59,    0,    0,  190,   57,  189,
			   55,    5,   54,   53,    0,    0,   52,    0,    0,   51,
			    0,   50,    0,    0,   49,   48,   47,    0,    0,   46,

			   45,    0,   44,    0,    4,    0,    0,    0,   43,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,   42,
			    0,    0,    0,    0,   41,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,   40,   39,   38,   37,    0,    0,
			    0,    0,    0,   36,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,   35,    0,   34,   33,   32,   31,   30,
			   29,   28,   27,   26,   25,   24,   23,   22,   21,   20,
			   19,   18,   17,   16,   15,   14,   13,   12,   11,  255,
			  254,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,   58,   57,   56,   55,    5,   54,

			   53,    0,  253,    0,    0,    0,   51,  -13,  -13,    0,
			    0,  137,   48,    0,    0,    0,   46,   45,    0,    0,
			    0,    4,  -13,  -13,  -13,  -13,  -13,  -13,  -13,    0,
			  -13,    0,    0,    0,  -13,    0,    0,    0,    0,  -13,
			  -13,    0,    0,    0,  -13,  -13,    0,    0,    0,  -13,
			  214,  213,  212,  211,  210,  209,  208,  207,  206,  205,
			  204,  203,  202,  201,  200,  199,  198,   63,    0,    0,
			    0,    0,   34,   33,   32,    0,   30,   29,   28,   27,
			   26,   25,   24,   23,   22,   21,   20,   19,   18,   17,
			   16,   15,   14,   13,   12,   11,    0,    0,    0,    0,

			  -13,  -13,  -13,    0,  -13,  -13,  -13,  -13,  -13,  -13,
			  -13,  -13,  -13,  -13,  -13,  -13,  -13,  -13,  -13,  -13,
			  -13,  -13,  -13,  -13,  255,  254,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,   58,
			   57,   56,   55,    0,   54,  843,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,  137,   48,    0,    0,
			    0,   46,   45,    0,    0,    0,   55,  210,  209,  208,
			  207,  206,  205,  204,  203,  202,  201,  200,  199,  198,
			   63,   48,    0,    0,    0,    2,    0,    0,    0,    0,
			   55,  164,  163,  162,  161,  160,  159,  158,  157,  156,

			  155,  154,  153,  152,  151,  150,  149,  148,  608,  147,
			  607,  656,    0,   55,    0,    0,    0,   34,   33,   32,
			    0,   30,   29,   28,   27,   26,   25,   24,   23,   22,
			   21,   20,   19,   18,   17,   16,   15,   14,   13,   12,
			   11,   34,   33,   32,    0,   30,   29,   28,   27,   26,
			   25,   24,   23,   22,   21,   20,   19,   18,   17,   16,
			   15,   14,   13,   12,   11,   34,   33,   32,    0,   30,
			   29,   28,   27,   26,   25,   24,   23,   22,   21,   20,
			   19,   18,   17,   16,   15,   14,   13,   12,   11,   33,
			    0,    0,   30,   29,   28,   27,   26,   25,   24,   23,

			   22,   21,   20,   19,   18,   17,   16,   15,   14,   13,
			   12,   11,  214,  213,  212,  211,  210,  209,  208,  207,
			  206,  205,  204,  203,  202,  201,  200,  199,  198,   63,
			  214,  213,  212,  211,  210,  209,  208,  207,  206,  205,
			  204,  203,  202,  201,  200,  199,  198,   63,  214,  213,
			  212,  211,  210,  209,  208,  207,  206,  205,  204,  203,
			  202,  201,  200,  199,  198,   63,    0,    0,    0,    0,
			    0,  214,  213,  212,  211,  210,  209,  208,  207,  206,
			  205,  204,  203,  202,  201,  200,  199,  198,   63,  214,
			  213,  212,  211,  210,  209,  208,  207,  206,  205,  204,

			  203,  202,  201,  200,  199,  198,   63,  750, -273,  823,
			 -273, -462, -462,    0,    0,    0, -462,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			  368,  214,  213,  212,  211,  210,  209,  208,  207,  206,
			  205,  204,  203,  202,  201,  200,  199,  198,   63,  214,
			  213,  212,  211,  210,  209,  208,  207,  206,  205,  204,
			  203,  202,  201,  200,  199,  198,   63,    0,    0,    0,
			    0,    0,  360,  213,  212,  211,  210,  209,  208,  207,
			  206,  205,  204,  203,  202,  201,  200,  199,  198,   63,
			  303,  214,  213,  212,  211,  210,  209,  208,  207,  206,

			  205,  204,  203,  202,  201,  200,  199,  198,   63,  211,
			  210,  209,  208,  207,  206,  205,  204,  203,  202,  201,
			  200,  199,  198,   63,  354,  164,  163,  162,  161,  160,
			  159,  158,  157,  156,  155,  154,  153,  152,  151,  150,
			  149,  148,    0,  147,  214,  213,  212,  211,  210,  209,
			  208,  207,  206,  205,  204,  203,  202,  201,  200,  199,
			  198,   63,  212,  211,  210,  209,  208,  207,  206,  205,
			  204,  203,  202,  201,  200,  199,  198,   63, yyDummy>>)
		end

	yycheck_template: SPECIAL [INTEGER] is
		once
			Result := yyfixed_array (<<
			    0,   38,    3,   44,    6,   42,  125,  125,  110,   44,
			   44,   40,  125,  125,   51,  125,  302,  249,  416,  125,
			  125,  252,   77,  125,  125,  119,  305,   64,   65,  471,
			  542,    0,   27,  619,   40,    0,  227,   31,   38,  230,
			   34,  168,    0,  110,   44,   40,   48,   49,  506,  181,
			   49,   53,   52,   47,   26,   48,   27,  110,   59,   60,
			  653,   62,   34,   57,   38,  470,  471,   27,   67,  196,
			  663,    0,  125,  110,  100,   81,   47,   46,   72,  537,
			   40,   82,  106,   34,  108,   57,   81,   83,  125,  689,
			  689,  395,  219,  220,   63,   64,  125,  110,   63,  692,

			   26,  543,   71,  110,  616,   31,   57,  107,  701,   74,
			  110,  390,  125,   67,  107,  419,  353,   86,  125,  143,
			  632,   81,  122,   34,   96,  125,  126,  127,  128,  722,
			  185,  186,  718,  188,  646,  137,   47,  138,  543,  689,
			   67,   95,  446,  743,  743,   96,   57,   66,   15,   16,
			  662,   41,  246,  247,  128,  392,  288,   34,  751,   26,
			   34,   34,  217,   30,   31,   32,   77,  167,  168,  508,
			  171,   15,   16,   67,   47,  307,  480,  116,  117,   90,
			   57,    3,   26,   57,   57,  183,   30,   61,   39,   40,
			  129,  130,   69,  743,  168,  534,  196,  198,  199,  200,

			  201,  202,  203,  204,  205,  206,  207,  208,  209,  210,
			  211,  212,  213,  214,  215,   92,  216,   39,  557,  219,
			  220,  245,  196,   96,  224,   40,   65,  282,   67,   15,
			   16,   46,   54,   67,  353,  353,    4,  292,  293,  106,
			  353,  353,   76,  353,   30,  219,  220,  353,  353,  553,
			  377,  353,  353,  308,  309,  310,  311,  312,  313,  314,
			  315,  316,  317,  318,  319,  320,  457,  322,  323,  667,
			  325,  326,  327,  392,  392,  407,  274,  275,   34,  392,
			  392,  100,  392,  279,   34,  285,  392,  392,   27,  289,
			  392,  392,  290,   27,  598,   34,  296,    4,   76,  299,

			  353,   57,   69,   81,   71,  305,   40,   57,   47,  613,
			   34,  285,    4,    3,  476,  477,  353,  479,   57,  623,
			  321,   77,   61,  324,  353,  362,  381,  382,    4,  491,
			  328,  493,   99,   57,   90,  331,   26,   41,   77,  392,
			  353,   67,   67,   34,  399,  105,  353,   26,   67,   39,
			   76,   90,   70,  353,   80,  392,  754,   96,  358,   34,
			   39,  362,   37,  392,   54,  363,   57,  106,  364,   26,
			  366,  533,   46,   91,  372,   93,  376,  377,  374,  392,
			   98,   46,   57,  101,  358,  392,   77,  781,   27,  391,
			  390,  415,  392,   29,   69,   34,   26,   26,  630,   90,

			  103,  438,   38,  377,  428,  429,  435,   82,   67,   39,
			   39,   47,  410,   34,  812,   36,   37,  104,   57,  813,
			  814,  815,   61,  817,   99,   38,   48,  451,   50,  453,
			  661,   67,  641,  665,  475,   38,   57,  438,   77,   65,
			  475,   67,  466,  837,   15,   16,  487,   34,   69,  735,
			  659,   90,  487,  487,   65,   91,   67,   96,   67,   30,
			  501,   82,   98,   34,   67,  101,  501,  501,  677,   36,
			   57,  668,  758,  759,  760,  475,   47,   65,   99,   67,
			  103,  104,   91,   34,   39,   40,   57,  487,   91,   98,
			   77,   67,  101,  779,   67,   98,  693,   46,  101,  523,

			   76,  501,  699,   90,   80,   67,   57,  548,   80,  550,
			   72,    0,    3,  548,   76,  550,  550,  558,   80,    3,
			   65,   72,   67,  558,  558,   76,    3,  646,  646,  737,
			  738,  572,   83,  646,  646,  732,  646,  572,  572,    3,
			  646,  646,   67,  598,  646,   70,   42,   43,  548,  590,
			  550,   67,  760,  750,   27,  590,  590,   38,  558,   21,
			   22,   42,   43,   30,   67,   32,   91,  591,  623,  766,
			   59,   95,  572,   98,   63,   64,  101,  100,   67,   60,
			   69,   28,   71,  584,  584,   74,   67,  784,   64,   65,
			  590,   72,   38,  646,   83,   76,   85,   86,   30,   80,

			   32,   67,  559,  560,   70,   94,   85,   15,   16,  646,
			   99,   67,  613,  614,  614,  617,   68,  646,   26,   65,
			   66,   67,   68,   31,   81,   91,  823,   76,   15,   16,
			   67,  633,   98,  646,   80,  101,   30,  637,   32,  646,
			   63,   64,   76,   30,   31,  842,  843,   34,   71,   95,
			   30,   65,   32,   63,   64,   83,  711,  103,  104,  105,
			   47,   71,  781,   86,  656,  702,  658,   15,   16,   57,
			   57,   46,   94,  728,  729,   46,   86,   74,   60,  781,
			   41,   46,   30,   67,   48,   72,   34,   28,  689,  689,
			   48,  746,  747,   67,  813,  814,  697,  698,  817,   47,

			   98,  703,  702,   41,   67,   38,  761,  762,  763,   57,
			   47,   41,  814,  815,  781,  817,   15,   16,  837,   65,
			   66,   67,   68,   48,   72,  726,  727,   26,  781,   48,
			   72,   30,   31,  788,   80,  837,   47,  737,  738,  740,
			  741,  742,  743,  743,  781,   47,   41,  814,  815,   95,
			  817,   91,   67,   56,   41,   67,  811,  103,  104,  105,
			  760,  814,  815,   80,  817,  820,  101,  822,  781,   48,
			  837,  772,  772,   70,  781,   60,  813,  814,  815,   67,
			  817,  781,   67,   67,  837,   67,   60,   72,   72,  790,
			   38,   76,   76,   49,   41,   80,   80,   42,   42,   43,

			  837,  814,  815,   78,  817,   51,  807,  814,  815,  810,
			  817,    0,   50,  813,  814,  815,   60,  817,   15,   16,
			   50,   41,   41,   67,  837,   46,   15,   16,   72,   26,
			  837,   27,   76,   30,   31,   32,   80,  837,   46,   15,
			   16,   30,   31,   32,   33,   34,   35,   36,   39,   38,
			   50,   26,   50,   42,   30,   31,   32,   27,   47,   48,
			   46,   63,   64,   52,   53,   49,   67,   40,   57,   71,
			   59,   50,   41,   41,   63,   64,   41,   30,   67,   60,
			   69,   83,   71,   30,   86,   74,   67,   46,   45,   50,
			   48,   72,   46,   67,   83,   76,   85,   86,   72,   80,

			   48,   40,   76,   30,   71,   94,   80,   50,   30,   46,
			   99,   15,   16,   17,   18,   19,   20,   21,   22,  108,
			  109,  110,   36,  112,  113,  114,  115,  116,  117,  118,
			  119,  120,  121,  122,  123,  124,  125,  126,  127,  128,
			  129,  130,  131,   15,   16,   48,   26,   46,   26,   26,
			   22,   23,   24,   25,   59,   27,   26,   26,   30,   31,
			   32,   33,   34,   35,   36,   39,   49,   39,   26,   45,
			   42,   27,   44,    0,   47,   47,   48,   49,  572,   50,
			   52,   53,  427,   55,  812,   57,   58,  614,  466,   61,
			   62,   17,   18,   19,   20,   21,   22,  438,  785,  837,

			   72,   73,  743,   75,  465,   77,  591,   79,  451,  615,
			  465,  513,  465,  548,  545,   87,   88,   89,   90,  551,
			  586,  821,  485,  495,   96,   97,  590,  782,  558,  449,
			  261,  295,  593,  682,  106,  358,  108,  109,  110,  111,
			  112,  113,  114,  115,  116,  117,  118,  119,  120,  121,
			  122,  123,  124,  125,  126,  127,  128,  129,  130,  131,
			   15,   16,  417,  642,  646,  358,   -1,   22,   23,   24,
			   25,   -1,   27,   -1,   -1,   30,   31,   32,   33,   34,
			   35,   36,   -1,   38,   39,   -1,   38,   42,   -1,   44,
			   42,   43,   47,   48,   49,   47,   -1,   52,   53,   -1,

			   55,   -1,   57,   -1,   -1,   -1,   61,   -1,   60,   -1,
			   -1,   -1,   -1,   -1,   -1,   67,   -1,   72,   -1,   -1,
			   72,   -1,   77,   -1,   76,   -1,   -1,   -1,   80,   -1,
			   -1,   -1,   87,   88,   89,   90,   -1,   -1,   -1,   91,
			   -1,   96,   -1,   -1,   -1,   -1,   98,   -1,   -1,  101,
			   -1,  106,   -1,  108,  109,  110,  111,  112,  113,  114,
			  115,  116,  117,  118,  119,  120,  121,  122,  123,  124,
			  125,  126,  127,  128,  129,  130,  131,   15,   16,   -1,
			   -1,   -1,   -1,   -1,   22,   23,   24,   25,   -1,   27,
			   -1,   -1,   30,   31,   32,   33,   34,   35,   36,   -1,

			   -1,   39,   -1,   -1,   42,   -1,   44,   -1,   -1,   47,
			   48,   49,   -1,   -1,   52,   53,   -1,   55,   -1,   57,
			   -1,   -1,   -1,   61,   63,   64,   -1,   65,   67,   -1,
			   -1,   -1,   71,   -1,   72,   -1,   -1,   76,   -1,   77,
			   -1,   -1,   -1,   -1,   83,   -1,   -1,   86,   -1,   87,
			   88,   89,   90,   -1,   -1,   -1,   95,   -1,   96,   -1,
			   -1,   -1,   -1,   -1,  103,  104,   -1,   -1,  106,   -1,
			  108,  109,  110,  111,  112,  113,  114,  115,  116,  117,
			  118,  119,  120,  121,  122,  123,  124,  125,  126,  127,
			  128,  129,  130,  131,   15,   16,   -1,   -1,   -1,   -1,

			   -1,   22,   23,   24,   25,   -1,   27,   -1,   -1,   30,
			   31,   32,   33,   34,   35,   36,   -1,   -1,   39,   -1,
			   -1,   42,   -1,   44,   -1,   -1,   47,   48,   49,   -1,
			   -1,   52,   53,   -1,   55,   -1,   57,   -1,   -1,   -1,
			   61,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   72,   -1,   -1,   -1,   -1,   77,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   87,   88,   89,   90,
			   -1,   -1,   -1,   -1,   -1,   96,   -1,   -1,   -1,  100,
			   -1,   -1,   -1,   -1,   -1,  106,   -1,  108,  109,  110,
			  111,  112,  113,  114,  115,  116,  117,  118,  119,  120,

			  121,  122,  123,  124,  125,  126,  127,  128,  129,  130,
			  131,   15,   16,   -1,   -1,   -1,   -1,   -1,   22,   23,
			   24,   25,   -1,   27,   -1,   -1,   30,   31,   32,   33,
			   34,   35,   36,   -1,   -1,   39,   -1,   -1,   42,   -1,
			   44,   -1,   -1,   47,   48,   49,   -1,   -1,   52,   53,
			   -1,   55,   -1,   57,   -1,   -1,   -1,   61,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   72,   -1,
			   -1,   -1,   -1,   77,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   87,   88,   89,   90,   -1,   -1,   -1,
			   -1,   -1,   96,   -1,   -1,   -1,   -1,   -1,   -1,   -1,

			   -1,   -1,  106,   -1,  108,  109,  110,  111,  112,  113,
			  114,  115,  116,  117,  118,  119,  120,  121,  122,  123,
			  124,  125,  126,  127,  128,  129,  130,  131,   15,   16,
			   -1,   -1,   -1,   -1,   -1,   22,   23,   24,   25,   -1,
			   27,   -1,   -1,   30,   31,   32,   33,   34,   35,   36,
			   -1,   -1,   39,   -1,   -1,   42,   -1,   44,   -1,   -1,
			   47,   48,   49,   -1,   -1,   52,   53,   -1,   55,   -1,
			   57,   -1,   -1,   -1,   61,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   72,   -1,   -1,   -1,   -1,
			   77,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,

			   87,   88,   89,   90,   -1,   -1,   -1,   -1,   -1,   96,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  106,
			   -1,  108,  109,  110,  111,  112,  113,  114,  115,  116,
			  117,  118,  119,  120,  121,  122,  123,  124,  125,  126,
			  127,  128,  129,  130,  131,   15,   16,   -1,   -1,   -1,
			   -1,   -1,   22,   23,   24,   25,   -1,   27,   -1,   -1,
			   30,   31,   32,   33,   34,   35,   36,   -1,   -1,   39,
			   -1,   -1,   42,   -1,   44,   -1,   -1,   47,   48,   49,
			   -1,   -1,   52,   53,   -1,   55,   -1,   57,   -1,   -1,
			   -1,   61,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,

			   -1,   -1,   72,   -1,   -1,   -1,   -1,   77,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   87,   88,   89,
			   90,   -1,   -1,   -1,   -1,   -1,   96,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,  106,   -1,  108,  109,
			  110,  111,  112,  113,  114,  115,  116,  117,  118,  119,
			  120,  121,  122,  123,  124,  125,  126,  127,  128,  129,
			  130,  131,   15,   16,   -1,   -1,   -1,   -1,   -1,   22,
			   23,   24,   25,   -1,   27,   -1,   -1,   30,   31,   32,
			   33,   34,   35,   36,   -1,   -1,   39,   -1,   -1,   42,
			   -1,   44,   -1,   -1,   47,   48,   49,   -1,   -1,   52,

			   53,   -1,   55,   -1,   57,   -1,   -1,   -1,   61,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   72,
			   -1,   -1,   -1,   -1,   77,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   87,   88,   89,   90,   -1,   -1,
			   -1,   -1,   -1,   96,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,  106,   -1,  108,  109,  110,  111,  112,
			  113,  114,  115,  116,  117,  118,  119,  120,  121,  122,
			  123,  124,  125,  126,  127,  128,  129,  130,  131,   15,
			   16,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   30,   31,   32,   33,   34,   35,

			   36,   -1,   38,   -1,   -1,   -1,   42,   15,   16,   -1,
			   -1,   47,   48,   -1,   -1,   -1,   52,   53,   -1,   -1,
			   -1,   57,   30,   31,   32,   33,   34,   35,   36,   -1,
			   38,   -1,   -1,   -1,   42,   -1,   -1,   -1,   -1,   47,
			   48,   -1,   -1,   -1,   52,   53,   -1,   -1,   -1,   57,
			    5,    6,    7,    8,    9,   10,   11,   12,   13,   14,
			   15,   16,   17,   18,   19,   20,   21,   22,   -1,   -1,
			   -1,   -1,  108,  109,  110,   -1,  112,  113,  114,  115,
			  116,  117,  118,  119,  120,  121,  122,  123,  124,  125,
			  126,  127,  128,  129,  130,  131,   -1,   -1,   -1,   -1,

			  108,  109,  110,   -1,  112,  113,  114,  115,  116,  117,
			  118,  119,  120,  121,  122,  123,  124,  125,  126,  127,
			  128,  129,  130,  131,   15,   16,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   30,
			   31,   32,   33,   -1,   35,  100,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   47,   48,   -1,   -1,
			   -1,   52,   53,   -1,   -1,   -1,   33,    9,   10,   11,
			   12,   13,   14,   15,   16,   17,   18,   19,   20,   21,
			   22,   48,   -1,   -1,   -1,   76,   -1,   -1,   -1,   -1,
			   33,  112,  113,  114,  115,  116,  117,  118,  119,  120,

			  121,  122,  123,  124,  125,  126,  127,  128,  129,  130,
			  131,  102,   -1,   33,   -1,   -1,   -1,  108,  109,  110,
			   -1,  112,  113,  114,  115,  116,  117,  118,  119,  120,
			  121,  122,  123,  124,  125,  126,  127,  128,  129,  130,
			  131,  108,  109,  110,   -1,  112,  113,  114,  115,  116,
			  117,  118,  119,  120,  121,  122,  123,  124,  125,  126,
			  127,  128,  129,  130,  131,  108,  109,  110,   -1,  112,
			  113,  114,  115,  116,  117,  118,  119,  120,  121,  122,
			  123,  124,  125,  126,  127,  128,  129,  130,  131,  109,
			   -1,   -1,  112,  113,  114,  115,  116,  117,  118,  119,

			  120,  121,  122,  123,  124,  125,  126,  127,  128,  129,
			  130,  131,    5,    6,    7,    8,    9,   10,   11,   12,
			   13,   14,   15,   16,   17,   18,   19,   20,   21,   22,
			    5,    6,    7,    8,    9,   10,   11,   12,   13,   14,
			   15,   16,   17,   18,   19,   20,   21,   22,    5,    6,
			    7,    8,    9,   10,   11,   12,   13,   14,   15,   16,
			   17,   18,   19,   20,   21,   22,   -1,   -1,   -1,   -1,
			   -1,    5,    6,    7,    8,    9,   10,   11,   12,   13,
			   14,   15,   16,   17,   18,   19,   20,   21,   22,    5,
			    6,    7,    8,    9,   10,   11,   12,   13,   14,   15,

			   16,   17,   18,   19,   20,   21,   22,  100,   65,   84,
			   67,   45,   46,   -1,   -1,   -1,   50,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   46,    5,    6,    7,    8,    9,   10,   11,   12,   13,
			   14,   15,   16,   17,   18,   19,   20,   21,   22,    5,
			    6,    7,    8,    9,   10,   11,   12,   13,   14,   15,
			   16,   17,   18,   19,   20,   21,   22,   -1,   -1,   -1,
			   -1,   -1,   46,    6,    7,    8,    9,   10,   11,   12,
			   13,   14,   15,   16,   17,   18,   19,   20,   21,   22,
			   46,    5,    6,    7,    8,    9,   10,   11,   12,   13,

			   14,   15,   16,   17,   18,   19,   20,   21,   22,    8,
			    9,   10,   11,   12,   13,   14,   15,   16,   17,   18,
			   19,   20,   21,   22,   38,  112,  113,  114,  115,  116,
			  117,  118,  119,  120,  121,  122,  123,  124,  125,  126,
			  127,  128,   -1,  130,    5,    6,    7,    8,    9,   10,
			   11,   12,   13,   14,   15,   16,   17,   18,   19,   20,
			   21,   22,    7,    8,    9,   10,   11,   12,   13,   14,
			   15,   16,   17,   18,   19,   20,   21,   22, yyDummy>>)
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

	yyvs2: SPECIAL [ID_AS]
			-- Stack for semantic values of type ID_AS

	yyvsc2: INTEGER
			-- Capacity of semantic value stack `yyvs2'

	yyvsp2: INTEGER
			-- Top of semantic value stack `yyvs2'

	yyspecial_routines2: KL_SPECIAL_ROUTINES [ID_AS]
			-- Routines that ought to be in SPECIAL [ID_AS]

	yyvs3: SPECIAL [LOCATION_AS]
			-- Stack for semantic values of type LOCATION_AS

	yyvsc3: INTEGER
			-- Capacity of semantic value stack `yyvs3'

	yyvsp3: INTEGER
			-- Top of semantic value stack `yyvs3'

	yyspecial_routines3: KL_SPECIAL_ROUTINES [LOCATION_AS]
			-- Routines that ought to be in SPECIAL [LOCATION_AS]

	yyvs4: SPECIAL [BOOL_AS]
			-- Stack for semantic values of type BOOL_AS

	yyvsc4: INTEGER
			-- Capacity of semantic value stack `yyvs4'

	yyvsp4: INTEGER
			-- Top of semantic value stack `yyvs4'

	yyspecial_routines4: KL_SPECIAL_ROUTINES [BOOL_AS]
			-- Routines that ought to be in SPECIAL [BOOL_AS]

	yyvs5: SPECIAL [CURRENT_AS]
			-- Stack for semantic values of type CURRENT_AS

	yyvsc5: INTEGER
			-- Capacity of semantic value stack `yyvs5'

	yyvsp5: INTEGER
			-- Top of semantic value stack `yyvs5'

	yyspecial_routines5: KL_SPECIAL_ROUTINES [CURRENT_AS]
			-- Routines that ought to be in SPECIAL [CURRENT_AS]

	yyvs6: SPECIAL [DEFERRED_AS]
			-- Stack for semantic values of type DEFERRED_AS

	yyvsc6: INTEGER
			-- Capacity of semantic value stack `yyvs6'

	yyvsp6: INTEGER
			-- Top of semantic value stack `yyvs6'

	yyspecial_routines6: KL_SPECIAL_ROUTINES [DEFERRED_AS]
			-- Routines that ought to be in SPECIAL [DEFERRED_AS]

	yyvs7: SPECIAL [RESULT_AS]
			-- Stack for semantic values of type RESULT_AS

	yyvsc7: INTEGER
			-- Capacity of semantic value stack `yyvs7'

	yyvsp7: INTEGER
			-- Top of semantic value stack `yyvs7'

	yyspecial_routines7: KL_SPECIAL_ROUTINES [RESULT_AS]
			-- Routines that ought to be in SPECIAL [RESULT_AS]

	yyvs8: SPECIAL [RETRY_AS]
			-- Stack for semantic values of type RETRY_AS

	yyvsc8: INTEGER
			-- Capacity of semantic value stack `yyvs8'

	yyvsp8: INTEGER
			-- Top of semantic value stack `yyvs8'

	yyspecial_routines8: KL_SPECIAL_ROUTINES [RETRY_AS]
			-- Routines that ought to be in SPECIAL [RETRY_AS]

	yyvs9: SPECIAL [UNIQUE_AS]
			-- Stack for semantic values of type UNIQUE_AS

	yyvsc9: INTEGER
			-- Capacity of semantic value stack `yyvs9'

	yyvsp9: INTEGER
			-- Top of semantic value stack `yyvs9'

	yyspecial_routines9: KL_SPECIAL_ROUTINES [UNIQUE_AS]
			-- Routines that ought to be in SPECIAL [UNIQUE_AS]

	yyvs10: SPECIAL [VOID_AS]
			-- Stack for semantic values of type VOID_AS

	yyvsc10: INTEGER
			-- Capacity of semantic value stack `yyvs10'

	yyvsp10: INTEGER
			-- Top of semantic value stack `yyvs10'

	yyspecial_routines10: KL_SPECIAL_ROUTINES [VOID_AS]
			-- Routines that ought to be in SPECIAL [VOID_AS]

	yyvs11: SPECIAL [ACCESS_AS]
			-- Stack for semantic values of type ACCESS_AS

	yyvsc11: INTEGER
			-- Capacity of semantic value stack `yyvs11'

	yyvsp11: INTEGER
			-- Top of semantic value stack `yyvs11'

	yyspecial_routines11: KL_SPECIAL_ROUTINES [ACCESS_AS]
			-- Routines that ought to be in SPECIAL [ACCESS_AS]

	yyvs12: SPECIAL [ACCESS_FEAT_AS]
			-- Stack for semantic values of type ACCESS_FEAT_AS

	yyvsc12: INTEGER
			-- Capacity of semantic value stack `yyvs12'

	yyvsp12: INTEGER
			-- Top of semantic value stack `yyvs12'

	yyspecial_routines12: KL_SPECIAL_ROUTINES [ACCESS_FEAT_AS]
			-- Routines that ought to be in SPECIAL [ACCESS_FEAT_AS]

	yyvs13: SPECIAL [ACCESS_INV_AS]
			-- Stack for semantic values of type ACCESS_INV_AS

	yyvsc13: INTEGER
			-- Capacity of semantic value stack `yyvs13'

	yyvsp13: INTEGER
			-- Top of semantic value stack `yyvs13'

	yyspecial_routines13: KL_SPECIAL_ROUTINES [ACCESS_INV_AS]
			-- Routines that ought to be in SPECIAL [ACCESS_INV_AS]

	yyvs14: SPECIAL [ARRAY_AS]
			-- Stack for semantic values of type ARRAY_AS

	yyvsc14: INTEGER
			-- Capacity of semantic value stack `yyvs14'

	yyvsp14: INTEGER
			-- Top of semantic value stack `yyvs14'

	yyspecial_routines14: KL_SPECIAL_ROUTINES [ARRAY_AS]
			-- Routines that ought to be in SPECIAL [ARRAY_AS]

	yyvs15: SPECIAL [ASSIGN_AS]
			-- Stack for semantic values of type ASSIGN_AS

	yyvsc15: INTEGER
			-- Capacity of semantic value stack `yyvs15'

	yyvsp15: INTEGER
			-- Top of semantic value stack `yyvs15'

	yyspecial_routines15: KL_SPECIAL_ROUTINES [ASSIGN_AS]
			-- Routines that ought to be in SPECIAL [ASSIGN_AS]

	yyvs16: SPECIAL [ASSIGNER_CALL_AS]
			-- Stack for semantic values of type ASSIGNER_CALL_AS

	yyvsc16: INTEGER
			-- Capacity of semantic value stack `yyvs16'

	yyvsp16: INTEGER
			-- Top of semantic value stack `yyvs16'

	yyspecial_routines16: KL_SPECIAL_ROUTINES [ASSIGNER_CALL_AS]
			-- Routines that ought to be in SPECIAL [ASSIGNER_CALL_AS]

	yyvs17: SPECIAL [ATOMIC_AS]
			-- Stack for semantic values of type ATOMIC_AS

	yyvsc17: INTEGER
			-- Capacity of semantic value stack `yyvs17'

	yyvsp17: INTEGER
			-- Top of semantic value stack `yyvs17'

	yyspecial_routines17: KL_SPECIAL_ROUTINES [ATOMIC_AS]
			-- Routines that ought to be in SPECIAL [ATOMIC_AS]

	yyvs18: SPECIAL [BINARY_AS]
			-- Stack for semantic values of type BINARY_AS

	yyvsc18: INTEGER
			-- Capacity of semantic value stack `yyvs18'

	yyvsp18: INTEGER
			-- Top of semantic value stack `yyvs18'

	yyspecial_routines18: KL_SPECIAL_ROUTINES [BINARY_AS]
			-- Routines that ought to be in SPECIAL [BINARY_AS]

	yyvs19: SPECIAL [BIT_CONST_AS]
			-- Stack for semantic values of type BIT_CONST_AS

	yyvsc19: INTEGER
			-- Capacity of semantic value stack `yyvs19'

	yyvsp19: INTEGER
			-- Top of semantic value stack `yyvs19'

	yyspecial_routines19: KL_SPECIAL_ROUTINES [BIT_CONST_AS]
			-- Routines that ought to be in SPECIAL [BIT_CONST_AS]

	yyvs20: SPECIAL [BODY_AS]
			-- Stack for semantic values of type BODY_AS

	yyvsc20: INTEGER
			-- Capacity of semantic value stack `yyvs20'

	yyvsp20: INTEGER
			-- Top of semantic value stack `yyvs20'

	yyspecial_routines20: KL_SPECIAL_ROUTINES [BODY_AS]
			-- Routines that ought to be in SPECIAL [BODY_AS]

	yyvs21: SPECIAL [CALL_AS]
			-- Stack for semantic values of type CALL_AS

	yyvsc21: INTEGER
			-- Capacity of semantic value stack `yyvs21'

	yyvsp21: INTEGER
			-- Top of semantic value stack `yyvs21'

	yyspecial_routines21: KL_SPECIAL_ROUTINES [CALL_AS]
			-- Routines that ought to be in SPECIAL [CALL_AS]

	yyvs22: SPECIAL [CASE_AS]
			-- Stack for semantic values of type CASE_AS

	yyvsc22: INTEGER
			-- Capacity of semantic value stack `yyvs22'

	yyvsp22: INTEGER
			-- Top of semantic value stack `yyvs22'

	yyspecial_routines22: KL_SPECIAL_ROUTINES [CASE_AS]
			-- Routines that ought to be in SPECIAL [CASE_AS]

	yyvs23: SPECIAL [CHAR_AS]
			-- Stack for semantic values of type CHAR_AS

	yyvsc23: INTEGER
			-- Capacity of semantic value stack `yyvs23'

	yyvsp23: INTEGER
			-- Top of semantic value stack `yyvs23'

	yyspecial_routines23: KL_SPECIAL_ROUTINES [CHAR_AS]
			-- Routines that ought to be in SPECIAL [CHAR_AS]

	yyvs24: SPECIAL [CHECK_AS]
			-- Stack for semantic values of type CHECK_AS

	yyvsc24: INTEGER
			-- Capacity of semantic value stack `yyvs24'

	yyvsp24: INTEGER
			-- Top of semantic value stack `yyvs24'

	yyspecial_routines24: KL_SPECIAL_ROUTINES [CHECK_AS]
			-- Routines that ought to be in SPECIAL [CHECK_AS]

	yyvs25: SPECIAL [CLIENT_AS]
			-- Stack for semantic values of type CLIENT_AS

	yyvsc25: INTEGER
			-- Capacity of semantic value stack `yyvs25'

	yyvsp25: INTEGER
			-- Top of semantic value stack `yyvs25'

	yyspecial_routines25: KL_SPECIAL_ROUTINES [CLIENT_AS]
			-- Routines that ought to be in SPECIAL [CLIENT_AS]

	yyvs26: SPECIAL [CONSTANT_AS]
			-- Stack for semantic values of type CONSTANT_AS

	yyvsc26: INTEGER
			-- Capacity of semantic value stack `yyvs26'

	yyvsp26: INTEGER
			-- Top of semantic value stack `yyvs26'

	yyspecial_routines26: KL_SPECIAL_ROUTINES [CONSTANT_AS]
			-- Routines that ought to be in SPECIAL [CONSTANT_AS]

	yyvs27: SPECIAL [CONVERT_FEAT_AS]
			-- Stack for semantic values of type CONVERT_FEAT_AS

	yyvsc27: INTEGER
			-- Capacity of semantic value stack `yyvs27'

	yyvsp27: INTEGER
			-- Top of semantic value stack `yyvs27'

	yyspecial_routines27: KL_SPECIAL_ROUTINES [CONVERT_FEAT_AS]
			-- Routines that ought to be in SPECIAL [CONVERT_FEAT_AS]

	yyvs28: SPECIAL [CREATE_AS]
			-- Stack for semantic values of type CREATE_AS

	yyvsc28: INTEGER
			-- Capacity of semantic value stack `yyvs28'

	yyvsp28: INTEGER
			-- Top of semantic value stack `yyvs28'

	yyspecial_routines28: KL_SPECIAL_ROUTINES [CREATE_AS]
			-- Routines that ought to be in SPECIAL [CREATE_AS]

	yyvs29: SPECIAL [CREATION_AS]
			-- Stack for semantic values of type CREATION_AS

	yyvsc29: INTEGER
			-- Capacity of semantic value stack `yyvs29'

	yyvsp29: INTEGER
			-- Top of semantic value stack `yyvs29'

	yyspecial_routines29: KL_SPECIAL_ROUTINES [CREATION_AS]
			-- Routines that ought to be in SPECIAL [CREATION_AS]

	yyvs30: SPECIAL [CREATION_EXPR_AS]
			-- Stack for semantic values of type CREATION_EXPR_AS

	yyvsc30: INTEGER
			-- Capacity of semantic value stack `yyvs30'

	yyvsp30: INTEGER
			-- Top of semantic value stack `yyvs30'

	yyspecial_routines30: KL_SPECIAL_ROUTINES [CREATION_EXPR_AS]
			-- Routines that ought to be in SPECIAL [CREATION_EXPR_AS]

	yyvs31: SPECIAL [DEBUG_AS]
			-- Stack for semantic values of type DEBUG_AS

	yyvsc31: INTEGER
			-- Capacity of semantic value stack `yyvs31'

	yyvsp31: INTEGER
			-- Top of semantic value stack `yyvs31'

	yyspecial_routines31: KL_SPECIAL_ROUTINES [DEBUG_AS]
			-- Routines that ought to be in SPECIAL [DEBUG_AS]

	yyvs32: SPECIAL [ELSIF_AS]
			-- Stack for semantic values of type ELSIF_AS

	yyvsc32: INTEGER
			-- Capacity of semantic value stack `yyvs32'

	yyvsp32: INTEGER
			-- Top of semantic value stack `yyvs32'

	yyspecial_routines32: KL_SPECIAL_ROUTINES [ELSIF_AS]
			-- Routines that ought to be in SPECIAL [ELSIF_AS]

	yyvs33: SPECIAL [ENSURE_AS]
			-- Stack for semantic values of type ENSURE_AS

	yyvsc33: INTEGER
			-- Capacity of semantic value stack `yyvs33'

	yyvsp33: INTEGER
			-- Top of semantic value stack `yyvs33'

	yyspecial_routines33: KL_SPECIAL_ROUTINES [ENSURE_AS]
			-- Routines that ought to be in SPECIAL [ENSURE_AS]

	yyvs34: SPECIAL [EXPORT_ITEM_AS]
			-- Stack for semantic values of type EXPORT_ITEM_AS

	yyvsc34: INTEGER
			-- Capacity of semantic value stack `yyvs34'

	yyvsp34: INTEGER
			-- Top of semantic value stack `yyvs34'

	yyspecial_routines34: KL_SPECIAL_ROUTINES [EXPORT_ITEM_AS]
			-- Routines that ought to be in SPECIAL [EXPORT_ITEM_AS]

	yyvs35: SPECIAL [EXPR_AS]
			-- Stack for semantic values of type EXPR_AS

	yyvsc35: INTEGER
			-- Capacity of semantic value stack `yyvs35'

	yyvsp35: INTEGER
			-- Top of semantic value stack `yyvs35'

	yyspecial_routines35: KL_SPECIAL_ROUTINES [EXPR_AS]
			-- Routines that ought to be in SPECIAL [EXPR_AS]

	yyvs36: SPECIAL [EXTERNAL_AS]
			-- Stack for semantic values of type EXTERNAL_AS

	yyvsc36: INTEGER
			-- Capacity of semantic value stack `yyvs36'

	yyvsp36: INTEGER
			-- Top of semantic value stack `yyvs36'

	yyspecial_routines36: KL_SPECIAL_ROUTINES [EXTERNAL_AS]
			-- Routines that ought to be in SPECIAL [EXTERNAL_AS]

	yyvs37: SPECIAL [EXTERNAL_LANG_AS]
			-- Stack for semantic values of type EXTERNAL_LANG_AS

	yyvsc37: INTEGER
			-- Capacity of semantic value stack `yyvs37'

	yyvsp37: INTEGER
			-- Top of semantic value stack `yyvs37'

	yyspecial_routines37: KL_SPECIAL_ROUTINES [EXTERNAL_LANG_AS]
			-- Routines that ought to be in SPECIAL [EXTERNAL_LANG_AS]

	yyvs38: SPECIAL [FEATURE_AS]
			-- Stack for semantic values of type FEATURE_AS

	yyvsc38: INTEGER
			-- Capacity of semantic value stack `yyvs38'

	yyvsp38: INTEGER
			-- Top of semantic value stack `yyvs38'

	yyspecial_routines38: KL_SPECIAL_ROUTINES [FEATURE_AS]
			-- Routines that ought to be in SPECIAL [FEATURE_AS]

	yyvs39: SPECIAL [FEATURE_CLAUSE_AS]
			-- Stack for semantic values of type FEATURE_CLAUSE_AS

	yyvsc39: INTEGER
			-- Capacity of semantic value stack `yyvs39'

	yyvsp39: INTEGER
			-- Top of semantic value stack `yyvs39'

	yyspecial_routines39: KL_SPECIAL_ROUTINES [FEATURE_CLAUSE_AS]
			-- Routines that ought to be in SPECIAL [FEATURE_CLAUSE_AS]

	yyvs40: SPECIAL [FEATURE_SET_AS]
			-- Stack for semantic values of type FEATURE_SET_AS

	yyvsc40: INTEGER
			-- Capacity of semantic value stack `yyvs40'

	yyvsp40: INTEGER
			-- Top of semantic value stack `yyvs40'

	yyspecial_routines40: KL_SPECIAL_ROUTINES [FEATURE_SET_AS]
			-- Routines that ought to be in SPECIAL [FEATURE_SET_AS]

	yyvs41: SPECIAL [FORMAL_AS]
			-- Stack for semantic values of type FORMAL_AS

	yyvsc41: INTEGER
			-- Capacity of semantic value stack `yyvs41'

	yyvsp41: INTEGER
			-- Top of semantic value stack `yyvs41'

	yyspecial_routines41: KL_SPECIAL_ROUTINES [FORMAL_AS]
			-- Routines that ought to be in SPECIAL [FORMAL_AS]

	yyvs42: SPECIAL [FORMAL_DEC_AS]
			-- Stack for semantic values of type FORMAL_DEC_AS

	yyvsc42: INTEGER
			-- Capacity of semantic value stack `yyvs42'

	yyvsp42: INTEGER
			-- Top of semantic value stack `yyvs42'

	yyspecial_routines42: KL_SPECIAL_ROUTINES [FORMAL_DEC_AS]
			-- Routines that ought to be in SPECIAL [FORMAL_DEC_AS]

	yyvs43: SPECIAL [IF_AS]
			-- Stack for semantic values of type IF_AS

	yyvsc43: INTEGER
			-- Capacity of semantic value stack `yyvs43'

	yyvsp43: INTEGER
			-- Top of semantic value stack `yyvs43'

	yyspecial_routines43: KL_SPECIAL_ROUTINES [IF_AS]
			-- Routines that ought to be in SPECIAL [IF_AS]

	yyvs44: SPECIAL [INDEX_AS]
			-- Stack for semantic values of type INDEX_AS

	yyvsc44: INTEGER
			-- Capacity of semantic value stack `yyvs44'

	yyvsp44: INTEGER
			-- Top of semantic value stack `yyvs44'

	yyspecial_routines44: KL_SPECIAL_ROUTINES [INDEX_AS]
			-- Routines that ought to be in SPECIAL [INDEX_AS]

	yyvs45: SPECIAL [INSPECT_AS]
			-- Stack for semantic values of type INSPECT_AS

	yyvsc45: INTEGER
			-- Capacity of semantic value stack `yyvs45'

	yyvsp45: INTEGER
			-- Top of semantic value stack `yyvs45'

	yyspecial_routines45: KL_SPECIAL_ROUTINES [INSPECT_AS]
			-- Routines that ought to be in SPECIAL [INSPECT_AS]

	yyvs46: SPECIAL [INSTRUCTION_AS]
			-- Stack for semantic values of type INSTRUCTION_AS

	yyvsc46: INTEGER
			-- Capacity of semantic value stack `yyvs46'

	yyvsp46: INTEGER
			-- Top of semantic value stack `yyvs46'

	yyspecial_routines46: KL_SPECIAL_ROUTINES [INSTRUCTION_AS]
			-- Routines that ought to be in SPECIAL [INSTRUCTION_AS]

	yyvs47: SPECIAL [INTEGER_AS]
			-- Stack for semantic values of type INTEGER_AS

	yyvsc47: INTEGER
			-- Capacity of semantic value stack `yyvs47'

	yyvsp47: INTEGER
			-- Top of semantic value stack `yyvs47'

	yyspecial_routines47: KL_SPECIAL_ROUTINES [INTEGER_AS]
			-- Routines that ought to be in SPECIAL [INTEGER_AS]

	yyvs48: SPECIAL [INTERNAL_AS]
			-- Stack for semantic values of type INTERNAL_AS

	yyvsc48: INTEGER
			-- Capacity of semantic value stack `yyvs48'

	yyvsp48: INTEGER
			-- Top of semantic value stack `yyvs48'

	yyspecial_routines48: KL_SPECIAL_ROUTINES [INTERNAL_AS]
			-- Routines that ought to be in SPECIAL [INTERNAL_AS]

	yyvs49: SPECIAL [INTERVAL_AS]
			-- Stack for semantic values of type INTERVAL_AS

	yyvsc49: INTEGER
			-- Capacity of semantic value stack `yyvs49'

	yyvsp49: INTEGER
			-- Top of semantic value stack `yyvs49'

	yyspecial_routines49: KL_SPECIAL_ROUTINES [INTERVAL_AS]
			-- Routines that ought to be in SPECIAL [INTERVAL_AS]

	yyvs50: SPECIAL [INVARIANT_AS]
			-- Stack for semantic values of type INVARIANT_AS

	yyvsc50: INTEGER
			-- Capacity of semantic value stack `yyvs50'

	yyvsp50: INTEGER
			-- Top of semantic value stack `yyvs50'

	yyspecial_routines50: KL_SPECIAL_ROUTINES [INVARIANT_AS]
			-- Routines that ought to be in SPECIAL [INVARIANT_AS]

	yyvs51: SPECIAL [LOOP_AS]
			-- Stack for semantic values of type LOOP_AS

	yyvsc51: INTEGER
			-- Capacity of semantic value stack `yyvs51'

	yyvsp51: INTEGER
			-- Top of semantic value stack `yyvs51'

	yyspecial_routines51: KL_SPECIAL_ROUTINES [LOOP_AS]
			-- Routines that ought to be in SPECIAL [LOOP_AS]

	yyvs52: SPECIAL [NESTED_AS]
			-- Stack for semantic values of type NESTED_AS

	yyvsc52: INTEGER
			-- Capacity of semantic value stack `yyvs52'

	yyvsp52: INTEGER
			-- Top of semantic value stack `yyvs52'

	yyspecial_routines52: KL_SPECIAL_ROUTINES [NESTED_AS]
			-- Routines that ought to be in SPECIAL [NESTED_AS]

	yyvs53: SPECIAL [OPERAND_AS]
			-- Stack for semantic values of type OPERAND_AS

	yyvsc53: INTEGER
			-- Capacity of semantic value stack `yyvs53'

	yyvsp53: INTEGER
			-- Top of semantic value stack `yyvs53'

	yyspecial_routines53: KL_SPECIAL_ROUTINES [OPERAND_AS]
			-- Routines that ought to be in SPECIAL [OPERAND_AS]

	yyvs54: SPECIAL [PARENT_AS]
			-- Stack for semantic values of type PARENT_AS

	yyvsc54: INTEGER
			-- Capacity of semantic value stack `yyvs54'

	yyvsp54: INTEGER
			-- Top of semantic value stack `yyvs54'

	yyspecial_routines54: KL_SPECIAL_ROUTINES [PARENT_AS]
			-- Routines that ought to be in SPECIAL [PARENT_AS]

	yyvs55: SPECIAL [PRECURSOR_AS]
			-- Stack for semantic values of type PRECURSOR_AS

	yyvsc55: INTEGER
			-- Capacity of semantic value stack `yyvs55'

	yyvsp55: INTEGER
			-- Top of semantic value stack `yyvs55'

	yyspecial_routines55: KL_SPECIAL_ROUTINES [PRECURSOR_AS]
			-- Routines that ought to be in SPECIAL [PRECURSOR_AS]

	yyvs56: SPECIAL [STATIC_ACCESS_AS]
			-- Stack for semantic values of type STATIC_ACCESS_AS

	yyvsc56: INTEGER
			-- Capacity of semantic value stack `yyvs56'

	yyvsp56: INTEGER
			-- Top of semantic value stack `yyvs56'

	yyspecial_routines56: KL_SPECIAL_ROUTINES [STATIC_ACCESS_AS]
			-- Routines that ought to be in SPECIAL [STATIC_ACCESS_AS]

	yyvs57: SPECIAL [REAL_AS]
			-- Stack for semantic values of type REAL_AS

	yyvsc57: INTEGER
			-- Capacity of semantic value stack `yyvs57'

	yyvsp57: INTEGER
			-- Top of semantic value stack `yyvs57'

	yyspecial_routines57: KL_SPECIAL_ROUTINES [REAL_AS]
			-- Routines that ought to be in SPECIAL [REAL_AS]

	yyvs58: SPECIAL [RENAME_AS]
			-- Stack for semantic values of type RENAME_AS

	yyvsc58: INTEGER
			-- Capacity of semantic value stack `yyvs58'

	yyvsp58: INTEGER
			-- Top of semantic value stack `yyvs58'

	yyspecial_routines58: KL_SPECIAL_ROUTINES [RENAME_AS]
			-- Routines that ought to be in SPECIAL [RENAME_AS]

	yyvs59: SPECIAL [REQUIRE_AS]
			-- Stack for semantic values of type REQUIRE_AS

	yyvsc59: INTEGER
			-- Capacity of semantic value stack `yyvs59'

	yyvsp59: INTEGER
			-- Top of semantic value stack `yyvs59'

	yyspecial_routines59: KL_SPECIAL_ROUTINES [REQUIRE_AS]
			-- Routines that ought to be in SPECIAL [REQUIRE_AS]

	yyvs60: SPECIAL [REVERSE_AS]
			-- Stack for semantic values of type REVERSE_AS

	yyvsc60: INTEGER
			-- Capacity of semantic value stack `yyvs60'

	yyvsp60: INTEGER
			-- Top of semantic value stack `yyvs60'

	yyspecial_routines60: KL_SPECIAL_ROUTINES [REVERSE_AS]
			-- Routines that ought to be in SPECIAL [REVERSE_AS]

	yyvs61: SPECIAL [ROUT_BODY_AS]
			-- Stack for semantic values of type ROUT_BODY_AS

	yyvsc61: INTEGER
			-- Capacity of semantic value stack `yyvs61'

	yyvsp61: INTEGER
			-- Top of semantic value stack `yyvs61'

	yyspecial_routines61: KL_SPECIAL_ROUTINES [ROUT_BODY_AS]
			-- Routines that ought to be in SPECIAL [ROUT_BODY_AS]

	yyvs62: SPECIAL [ROUTINE_AS]
			-- Stack for semantic values of type ROUTINE_AS

	yyvsc62: INTEGER
			-- Capacity of semantic value stack `yyvs62'

	yyvsp62: INTEGER
			-- Top of semantic value stack `yyvs62'

	yyspecial_routines62: KL_SPECIAL_ROUTINES [ROUTINE_AS]
			-- Routines that ought to be in SPECIAL [ROUTINE_AS]

	yyvs63: SPECIAL [ROUTINE_CREATION_AS]
			-- Stack for semantic values of type ROUTINE_CREATION_AS

	yyvsc63: INTEGER
			-- Capacity of semantic value stack `yyvs63'

	yyvsp63: INTEGER
			-- Top of semantic value stack `yyvs63'

	yyspecial_routines63: KL_SPECIAL_ROUTINES [ROUTINE_CREATION_AS]
			-- Routines that ought to be in SPECIAL [ROUTINE_CREATION_AS]

	yyvs64: SPECIAL [PAIR [ROUTINE_CREATION_AS, LOCATION_AS]]
			-- Stack for semantic values of type PAIR [ROUTINE_CREATION_AS, LOCATION_AS]

	yyvsc64: INTEGER
			-- Capacity of semantic value stack `yyvs64'

	yyvsp64: INTEGER
			-- Top of semantic value stack `yyvs64'

	yyspecial_routines64: KL_SPECIAL_ROUTINES [PAIR [ROUTINE_CREATION_AS, LOCATION_AS]]
			-- Routines that ought to be in SPECIAL [PAIR [ROUTINE_CREATION_AS, LOCATION_AS]]

	yyvs65: SPECIAL [STRING_AS]
			-- Stack for semantic values of type STRING_AS

	yyvsc65: INTEGER
			-- Capacity of semantic value stack `yyvs65'

	yyvsp65: INTEGER
			-- Top of semantic value stack `yyvs65'

	yyspecial_routines65: KL_SPECIAL_ROUTINES [STRING_AS]
			-- Routines that ought to be in SPECIAL [STRING_AS]

	yyvs66: SPECIAL [TAGGED_AS]
			-- Stack for semantic values of type TAGGED_AS

	yyvsc66: INTEGER
			-- Capacity of semantic value stack `yyvs66'

	yyvsp66: INTEGER
			-- Top of semantic value stack `yyvs66'

	yyspecial_routines66: KL_SPECIAL_ROUTINES [TAGGED_AS]
			-- Routines that ought to be in SPECIAL [TAGGED_AS]

	yyvs67: SPECIAL [TUPLE_AS]
			-- Stack for semantic values of type TUPLE_AS

	yyvsc67: INTEGER
			-- Capacity of semantic value stack `yyvs67'

	yyvsp67: INTEGER
			-- Top of semantic value stack `yyvs67'

	yyspecial_routines67: KL_SPECIAL_ROUTINES [TUPLE_AS]
			-- Routines that ought to be in SPECIAL [TUPLE_AS]

	yyvs68: SPECIAL [TYPE_AS]
			-- Stack for semantic values of type TYPE_AS

	yyvsc68: INTEGER
			-- Capacity of semantic value stack `yyvs68'

	yyvsp68: INTEGER
			-- Top of semantic value stack `yyvs68'

	yyspecial_routines68: KL_SPECIAL_ROUTINES [TYPE_AS]
			-- Routines that ought to be in SPECIAL [TYPE_AS]

	yyvs69: SPECIAL [TYPE_DEC_AS]
			-- Stack for semantic values of type TYPE_DEC_AS

	yyvsc69: INTEGER
			-- Capacity of semantic value stack `yyvs69'

	yyvsp69: INTEGER
			-- Top of semantic value stack `yyvs69'

	yyspecial_routines69: KL_SPECIAL_ROUTINES [TYPE_DEC_AS]
			-- Routines that ought to be in SPECIAL [TYPE_DEC_AS]

	yyvs70: SPECIAL [VARIANT_AS]
			-- Stack for semantic values of type VARIANT_AS

	yyvsc70: INTEGER
			-- Capacity of semantic value stack `yyvs70'

	yyvsp70: INTEGER
			-- Top of semantic value stack `yyvs70'

	yyspecial_routines70: KL_SPECIAL_ROUTINES [VARIANT_AS]
			-- Routines that ought to be in SPECIAL [VARIANT_AS]

	yyvs71: SPECIAL [FEATURE_NAME]
			-- Stack for semantic values of type FEATURE_NAME

	yyvsc71: INTEGER
			-- Capacity of semantic value stack `yyvs71'

	yyvsp71: INTEGER
			-- Top of semantic value stack `yyvs71'

	yyspecial_routines71: KL_SPECIAL_ROUTINES [FEATURE_NAME]
			-- Routines that ought to be in SPECIAL [FEATURE_NAME]

	yyvs72: SPECIAL [EIFFEL_LIST [ATOMIC_AS]]
			-- Stack for semantic values of type EIFFEL_LIST [ATOMIC_AS]

	yyvsc72: INTEGER
			-- Capacity of semantic value stack `yyvs72'

	yyvsp72: INTEGER
			-- Top of semantic value stack `yyvs72'

	yyspecial_routines72: KL_SPECIAL_ROUTINES [EIFFEL_LIST [ATOMIC_AS]]
			-- Routines that ought to be in SPECIAL [EIFFEL_LIST [ATOMIC_AS]]

	yyvs73: SPECIAL [EIFFEL_LIST [CASE_AS]]
			-- Stack for semantic values of type EIFFEL_LIST [CASE_AS]

	yyvsc73: INTEGER
			-- Capacity of semantic value stack `yyvs73'

	yyvsp73: INTEGER
			-- Top of semantic value stack `yyvs73'

	yyspecial_routines73: KL_SPECIAL_ROUTINES [EIFFEL_LIST [CASE_AS]]
			-- Routines that ought to be in SPECIAL [EIFFEL_LIST [CASE_AS]]

	yyvs74: SPECIAL [EIFFEL_LIST [CONVERT_FEAT_AS]]
			-- Stack for semantic values of type EIFFEL_LIST [CONVERT_FEAT_AS]

	yyvsc74: INTEGER
			-- Capacity of semantic value stack `yyvs74'

	yyvsp74: INTEGER
			-- Top of semantic value stack `yyvs74'

	yyspecial_routines74: KL_SPECIAL_ROUTINES [EIFFEL_LIST [CONVERT_FEAT_AS]]
			-- Routines that ought to be in SPECIAL [EIFFEL_LIST [CONVERT_FEAT_AS]]

	yyvs75: SPECIAL [EIFFEL_LIST [CREATE_AS]]
			-- Stack for semantic values of type EIFFEL_LIST [CREATE_AS]

	yyvsc75: INTEGER
			-- Capacity of semantic value stack `yyvs75'

	yyvsp75: INTEGER
			-- Top of semantic value stack `yyvs75'

	yyspecial_routines75: KL_SPECIAL_ROUTINES [EIFFEL_LIST [CREATE_AS]]
			-- Routines that ought to be in SPECIAL [EIFFEL_LIST [CREATE_AS]]

	yyvs76: SPECIAL [EIFFEL_LIST [ELSIF_AS]]
			-- Stack for semantic values of type EIFFEL_LIST [ELSIF_AS]

	yyvsc76: INTEGER
			-- Capacity of semantic value stack `yyvs76'

	yyvsp76: INTEGER
			-- Top of semantic value stack `yyvs76'

	yyspecial_routines76: KL_SPECIAL_ROUTINES [EIFFEL_LIST [ELSIF_AS]]
			-- Routines that ought to be in SPECIAL [EIFFEL_LIST [ELSIF_AS]]

	yyvs77: SPECIAL [EIFFEL_LIST [EXPORT_ITEM_AS]]
			-- Stack for semantic values of type EIFFEL_LIST [EXPORT_ITEM_AS]

	yyvsc77: INTEGER
			-- Capacity of semantic value stack `yyvs77'

	yyvsp77: INTEGER
			-- Top of semantic value stack `yyvs77'

	yyspecial_routines77: KL_SPECIAL_ROUTINES [EIFFEL_LIST [EXPORT_ITEM_AS]]
			-- Routines that ought to be in SPECIAL [EIFFEL_LIST [EXPORT_ITEM_AS]]

	yyvs78: SPECIAL [EIFFEL_LIST [EXPR_AS]]
			-- Stack for semantic values of type EIFFEL_LIST [EXPR_AS]

	yyvsc78: INTEGER
			-- Capacity of semantic value stack `yyvs78'

	yyvsp78: INTEGER
			-- Top of semantic value stack `yyvs78'

	yyspecial_routines78: KL_SPECIAL_ROUTINES [EIFFEL_LIST [EXPR_AS]]
			-- Routines that ought to be in SPECIAL [EIFFEL_LIST [EXPR_AS]]

	yyvs79: SPECIAL [EIFFEL_LIST [FEATURE_AS]]
			-- Stack for semantic values of type EIFFEL_LIST [FEATURE_AS]

	yyvsc79: INTEGER
			-- Capacity of semantic value stack `yyvs79'

	yyvsp79: INTEGER
			-- Top of semantic value stack `yyvs79'

	yyspecial_routines79: KL_SPECIAL_ROUTINES [EIFFEL_LIST [FEATURE_AS]]
			-- Routines that ought to be in SPECIAL [EIFFEL_LIST [FEATURE_AS]]

	yyvs80: SPECIAL [EIFFEL_LIST [FEATURE_CLAUSE_AS]]
			-- Stack for semantic values of type EIFFEL_LIST [FEATURE_CLAUSE_AS]

	yyvsc80: INTEGER
			-- Capacity of semantic value stack `yyvs80'

	yyvsp80: INTEGER
			-- Top of semantic value stack `yyvs80'

	yyspecial_routines80: KL_SPECIAL_ROUTINES [EIFFEL_LIST [FEATURE_CLAUSE_AS]]
			-- Routines that ought to be in SPECIAL [EIFFEL_LIST [FEATURE_CLAUSE_AS]]

	yyvs81: SPECIAL [EIFFEL_LIST [FEATURE_NAME]]
			-- Stack for semantic values of type EIFFEL_LIST [FEATURE_NAME]

	yyvsc81: INTEGER
			-- Capacity of semantic value stack `yyvs81'

	yyvsp81: INTEGER
			-- Top of semantic value stack `yyvs81'

	yyspecial_routines81: KL_SPECIAL_ROUTINES [EIFFEL_LIST [FEATURE_NAME]]
			-- Routines that ought to be in SPECIAL [EIFFEL_LIST [FEATURE_NAME]]

	yyvs82: SPECIAL [EIFFEL_LIST [FORMAL_DEC_AS]]
			-- Stack for semantic values of type EIFFEL_LIST [FORMAL_DEC_AS]

	yyvsc82: INTEGER
			-- Capacity of semantic value stack `yyvs82'

	yyvsp82: INTEGER
			-- Top of semantic value stack `yyvs82'

	yyspecial_routines82: KL_SPECIAL_ROUTINES [EIFFEL_LIST [FORMAL_DEC_AS]]
			-- Routines that ought to be in SPECIAL [EIFFEL_LIST [FORMAL_DEC_AS]]

	yyvs83: SPECIAL [EIFFEL_LIST [ID_AS]]
			-- Stack for semantic values of type EIFFEL_LIST [ID_AS]

	yyvsc83: INTEGER
			-- Capacity of semantic value stack `yyvs83'

	yyvsp83: INTEGER
			-- Top of semantic value stack `yyvs83'

	yyspecial_routines83: KL_SPECIAL_ROUTINES [EIFFEL_LIST [ID_AS]]
			-- Routines that ought to be in SPECIAL [EIFFEL_LIST [ID_AS]]

	yyvs84: SPECIAL [INTEGER]
			-- Stack for semantic values of type INTEGER

	yyvsc84: INTEGER
			-- Capacity of semantic value stack `yyvs84'

	yyvsp84: INTEGER
			-- Top of semantic value stack `yyvs84'

	yyspecial_routines84: KL_SPECIAL_ROUTINES [INTEGER]
			-- Routines that ought to be in SPECIAL [INTEGER]

	yyvs85: SPECIAL [CONSTRUCT_LIST [INTEGER]]
			-- Stack for semantic values of type CONSTRUCT_LIST [INTEGER]

	yyvsc85: INTEGER
			-- Capacity of semantic value stack `yyvs85'

	yyvsp85: INTEGER
			-- Top of semantic value stack `yyvs85'

	yyspecial_routines85: KL_SPECIAL_ROUTINES [CONSTRUCT_LIST [INTEGER]]
			-- Routines that ought to be in SPECIAL [CONSTRUCT_LIST [INTEGER]]

	yyvs86: SPECIAL [INDEXING_CLAUSE_AS]
			-- Stack for semantic values of type INDEXING_CLAUSE_AS

	yyvsc86: INTEGER
			-- Capacity of semantic value stack `yyvs86'

	yyvsp86: INTEGER
			-- Top of semantic value stack `yyvs86'

	yyspecial_routines86: KL_SPECIAL_ROUTINES [INDEXING_CLAUSE_AS]
			-- Routines that ought to be in SPECIAL [INDEXING_CLAUSE_AS]

	yyvs87: SPECIAL [EIFFEL_LIST [INSTRUCTION_AS]]
			-- Stack for semantic values of type EIFFEL_LIST [INSTRUCTION_AS]

	yyvsc87: INTEGER
			-- Capacity of semantic value stack `yyvs87'

	yyvsp87: INTEGER
			-- Top of semantic value stack `yyvs87'

	yyspecial_routines87: KL_SPECIAL_ROUTINES [EIFFEL_LIST [INSTRUCTION_AS]]
			-- Routines that ought to be in SPECIAL [EIFFEL_LIST [INSTRUCTION_AS]]

	yyvs88: SPECIAL [EIFFEL_LIST [INTERVAL_AS]]
			-- Stack for semantic values of type EIFFEL_LIST [INTERVAL_AS]

	yyvsc88: INTEGER
			-- Capacity of semantic value stack `yyvs88'

	yyvsp88: INTEGER
			-- Top of semantic value stack `yyvs88'

	yyspecial_routines88: KL_SPECIAL_ROUTINES [EIFFEL_LIST [INTERVAL_AS]]
			-- Routines that ought to be in SPECIAL [EIFFEL_LIST [INTERVAL_AS]]

	yyvs89: SPECIAL [EIFFEL_LIST [OPERAND_AS]]
			-- Stack for semantic values of type EIFFEL_LIST [OPERAND_AS]

	yyvsc89: INTEGER
			-- Capacity of semantic value stack `yyvs89'

	yyvsp89: INTEGER
			-- Top of semantic value stack `yyvs89'

	yyspecial_routines89: KL_SPECIAL_ROUTINES [EIFFEL_LIST [OPERAND_AS]]
			-- Routines that ought to be in SPECIAL [EIFFEL_LIST [OPERAND_AS]]

	yyvs90: SPECIAL [EIFFEL_LIST [PARENT_AS]]
			-- Stack for semantic values of type EIFFEL_LIST [PARENT_AS]

	yyvsc90: INTEGER
			-- Capacity of semantic value stack `yyvs90'

	yyvsp90: INTEGER
			-- Top of semantic value stack `yyvs90'

	yyspecial_routines90: KL_SPECIAL_ROUTINES [EIFFEL_LIST [PARENT_AS]]
			-- Routines that ought to be in SPECIAL [EIFFEL_LIST [PARENT_AS]]

	yyvs91: SPECIAL [EIFFEL_LIST [RENAME_AS]]
			-- Stack for semantic values of type EIFFEL_LIST [RENAME_AS]

	yyvsc91: INTEGER
			-- Capacity of semantic value stack `yyvs91'

	yyvsp91: INTEGER
			-- Top of semantic value stack `yyvs91'

	yyspecial_routines91: KL_SPECIAL_ROUTINES [EIFFEL_LIST [RENAME_AS]]
			-- Routines that ought to be in SPECIAL [EIFFEL_LIST [RENAME_AS]]

	yyvs92: SPECIAL [EIFFEL_LIST [STRING_AS]]
			-- Stack for semantic values of type EIFFEL_LIST [STRING_AS]

	yyvsc92: INTEGER
			-- Capacity of semantic value stack `yyvs92'

	yyvsp92: INTEGER
			-- Top of semantic value stack `yyvs92'

	yyspecial_routines92: KL_SPECIAL_ROUTINES [EIFFEL_LIST [STRING_AS]]
			-- Routines that ought to be in SPECIAL [EIFFEL_LIST [STRING_AS]]

	yyvs93: SPECIAL [EIFFEL_LIST [TAGGED_AS]]
			-- Stack for semantic values of type EIFFEL_LIST [TAGGED_AS]

	yyvsc93: INTEGER
			-- Capacity of semantic value stack `yyvs93'

	yyvsp93: INTEGER
			-- Top of semantic value stack `yyvs93'

	yyspecial_routines93: KL_SPECIAL_ROUTINES [EIFFEL_LIST [TAGGED_AS]]
			-- Routines that ought to be in SPECIAL [EIFFEL_LIST [TAGGED_AS]]

	yyvs94: SPECIAL [EIFFEL_LIST [TYPE_AS]]
			-- Stack for semantic values of type EIFFEL_LIST [TYPE_AS]

	yyvsc94: INTEGER
			-- Capacity of semantic value stack `yyvs94'

	yyvsp94: INTEGER
			-- Top of semantic value stack `yyvs94'

	yyspecial_routines94: KL_SPECIAL_ROUTINES [EIFFEL_LIST [TYPE_AS]]
			-- Routines that ought to be in SPECIAL [EIFFEL_LIST [TYPE_AS]]

	yyvs95: SPECIAL [EIFFEL_LIST [TYPE_DEC_AS]]
			-- Stack for semantic values of type EIFFEL_LIST [TYPE_DEC_AS]

	yyvsc95: INTEGER
			-- Capacity of semantic value stack `yyvs95'

	yyvsp95: INTEGER
			-- Top of semantic value stack `yyvs95'

	yyspecial_routines95: KL_SPECIAL_ROUTINES [EIFFEL_LIST [TYPE_DEC_AS]]
			-- Routines that ought to be in SPECIAL [EIFFEL_LIST [TYPE_DEC_AS]]

	yyvs96: SPECIAL [PAIR [TYPE_AS, EIFFEL_LIST [FEATURE_NAME]]]
			-- Stack for semantic values of type PAIR [TYPE_AS, EIFFEL_LIST [FEATURE_NAME]]

	yyvsc96: INTEGER
			-- Capacity of semantic value stack `yyvs96'

	yyvsp96: INTEGER
			-- Top of semantic value stack `yyvs96'

	yyspecial_routines96: KL_SPECIAL_ROUTINES [PAIR [TYPE_AS, EIFFEL_LIST [FEATURE_NAME]]]
			-- Routines that ought to be in SPECIAL [PAIR [TYPE_AS, EIFFEL_LIST [FEATURE_NAME]]]

feature {NONE} -- Constants

	yyFinal: INTEGER is 852
			-- Termination state id

	yyFlag: INTEGER is -32768
			-- Most negative INTEGER

	yyNtbase: INTEGER is 132
			-- Number of tokens

	yyLast: INTEGER is 2477
			-- Upper bound of `yytable' and `yycheck'

	yyMax_token: INTEGER is 386
			-- Maximum token id
			-- (upper bound of `yytranslate'.)

	yyNsyms: INTEGER is 377
			-- Number of symbols
			-- (terminal and nonterminal)

feature -- User-defined features



end -- class EIFFEL_PARSER


--|----------------------------------------------------------------
--| Copyright (C) 1992-2000, Interactive Software Engineering Inc.
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
