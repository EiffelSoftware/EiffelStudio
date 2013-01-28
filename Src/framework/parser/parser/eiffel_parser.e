note

	description: "Eiffel parsers"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class EIFFEL_PARSER

inherit

	EIFFEL_PARSER_SKELETON

create
	make,
	make_with_factory

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
			yyvsp119 := -1
			yyvsp120 := -1
			yyvsp121 := -1
			yyvsp122 := -1
			yyvsp123 := -1
		end

	yy_clear_value_stacks
			-- Clear objects in semantic value stacks so that
			-- they can be collected by the garbage collector.
		do
			if yyvs1 /= Void and yyspecial_routines1 /= Void then
				yyspecial_routines1.keep_head (yyvs1, 0, yyvsp1 + 1)
			end
			if yyvs2 /= Void and yyspecial_routines2 /= Void then
				yyspecial_routines2.keep_head (yyvs2, 0, yyvsp2 + 1)
			end
			if yyvs3 /= Void and yyspecial_routines3 /= Void then
				yyspecial_routines3.keep_head (yyvs3, 0, yyvsp3 + 1)
			end
			if yyvs4 /= Void and yyspecial_routines4 /= Void then
				yyspecial_routines4.keep_head (yyvs4, 0, yyvsp4 + 1)
			end
			if yyvs5 /= Void and yyspecial_routines5 /= Void then
				yyspecial_routines5.keep_head (yyvs5, 0, yyvsp5 + 1)
			end
			if yyvs6 /= Void and yyspecial_routines6 /= Void then
				yyspecial_routines6.keep_head (yyvs6, 0, yyvsp6 + 1)
			end
			if yyvs7 /= Void and yyspecial_routines7 /= Void then
				yyspecial_routines7.keep_head (yyvs7, 0, yyvsp7 + 1)
			end
			if yyvs8 /= Void and yyspecial_routines8 /= Void then
				yyspecial_routines8.keep_head (yyvs8, 0, yyvsp8 + 1)
			end
			if yyvs9 /= Void and yyspecial_routines9 /= Void then
				yyspecial_routines9.keep_head (yyvs9, 0, yyvsp9 + 1)
			end
			if yyvs10 /= Void and yyspecial_routines10 /= Void then
				yyspecial_routines10.keep_head (yyvs10, 0, yyvsp10 + 1)
			end
			if yyvs11 /= Void and yyspecial_routines11 /= Void then
				yyspecial_routines11.keep_head (yyvs11, 0, yyvsp11 + 1)
			end
			if yyvs12 /= Void and yyspecial_routines12 /= Void then
				yyspecial_routines12.keep_head (yyvs12, 0, yyvsp12 + 1)
			end
			if yyvs13 /= Void and yyspecial_routines13 /= Void then
				yyspecial_routines13.keep_head (yyvs13, 0, yyvsp13 + 1)
			end
			if yyvs14 /= Void and yyspecial_routines14 /= Void then
				yyspecial_routines14.keep_head (yyvs14, 0, yyvsp14 + 1)
			end
			if yyvs15 /= Void and yyspecial_routines15 /= Void then
				yyspecial_routines15.keep_head (yyvs15, 0, yyvsp15 + 1)
			end
			if yyvs16 /= Void and yyspecial_routines16 /= Void then
				yyspecial_routines16.keep_head (yyvs16, 0, yyvsp16 + 1)
			end
			if yyvs17 /= Void and yyspecial_routines17 /= Void then
				yyspecial_routines17.keep_head (yyvs17, 0, yyvsp17 + 1)
			end
			if yyvs18 /= Void and yyspecial_routines18 /= Void then
				yyspecial_routines18.keep_head (yyvs18, 0, yyvsp18 + 1)
			end
			if yyvs19 /= Void and yyspecial_routines19 /= Void then
				yyspecial_routines19.keep_head (yyvs19, 0, yyvsp19 + 1)
			end
			if yyvs20 /= Void and yyspecial_routines20 /= Void then
				yyspecial_routines20.keep_head (yyvs20, 0, yyvsp20 + 1)
			end
			if yyvs21 /= Void and yyspecial_routines21 /= Void then
				yyspecial_routines21.keep_head (yyvs21, 0, yyvsp21 + 1)
			end
			if yyvs22 /= Void and yyspecial_routines22 /= Void then
				yyspecial_routines22.keep_head (yyvs22, 0, yyvsp22 + 1)
			end
			if yyvs23 /= Void and yyspecial_routines23 /= Void then
				yyspecial_routines23.keep_head (yyvs23, 0, yyvsp23 + 1)
			end
			if yyvs24 /= Void and yyspecial_routines24 /= Void then
				yyspecial_routines24.keep_head (yyvs24, 0, yyvsp24 + 1)
			end
			if yyvs25 /= Void and yyspecial_routines25 /= Void then
				yyspecial_routines25.keep_head (yyvs25, 0, yyvsp25 + 1)
			end
			if yyvs26 /= Void and yyspecial_routines26 /= Void then
				yyspecial_routines26.keep_head (yyvs26, 0, yyvsp26 + 1)
			end
			if yyvs27 /= Void and yyspecial_routines27 /= Void then
				yyspecial_routines27.keep_head (yyvs27, 0, yyvsp27 + 1)
			end
			if yyvs28 /= Void and yyspecial_routines28 /= Void then
				yyspecial_routines28.keep_head (yyvs28, 0, yyvsp28 + 1)
			end
			if yyvs29 /= Void and yyspecial_routines29 /= Void then
				yyspecial_routines29.keep_head (yyvs29, 0, yyvsp29 + 1)
			end
			if yyvs30 /= Void and yyspecial_routines30 /= Void then
				yyspecial_routines30.keep_head (yyvs30, 0, yyvsp30 + 1)
			end
			if yyvs31 /= Void and yyspecial_routines31 /= Void then
				yyspecial_routines31.keep_head (yyvs31, 0, yyvsp31 + 1)
			end
			if yyvs32 /= Void and yyspecial_routines32 /= Void then
				yyspecial_routines32.keep_head (yyvs32, 0, yyvsp32 + 1)
			end
			if yyvs33 /= Void and yyspecial_routines33 /= Void then
				yyspecial_routines33.keep_head (yyvs33, 0, yyvsp33 + 1)
			end
			if yyvs34 /= Void and yyspecial_routines34 /= Void then
				yyspecial_routines34.keep_head (yyvs34, 0, yyvsp34 + 1)
			end
			if yyvs35 /= Void and yyspecial_routines35 /= Void then
				yyspecial_routines35.keep_head (yyvs35, 0, yyvsp35 + 1)
			end
			if yyvs36 /= Void and yyspecial_routines36 /= Void then
				yyspecial_routines36.keep_head (yyvs36, 0, yyvsp36 + 1)
			end
			if yyvs37 /= Void and yyspecial_routines37 /= Void then
				yyspecial_routines37.keep_head (yyvs37, 0, yyvsp37 + 1)
			end
			if yyvs38 /= Void and yyspecial_routines38 /= Void then
				yyspecial_routines38.keep_head (yyvs38, 0, yyvsp38 + 1)
			end
			if yyvs39 /= Void and yyspecial_routines39 /= Void then
				yyspecial_routines39.keep_head (yyvs39, 0, yyvsp39 + 1)
			end
			if yyvs40 /= Void and yyspecial_routines40 /= Void then
				yyspecial_routines40.keep_head (yyvs40, 0, yyvsp40 + 1)
			end
			if yyvs41 /= Void and yyspecial_routines41 /= Void then
				yyspecial_routines41.keep_head (yyvs41, 0, yyvsp41 + 1)
			end
			if yyvs42 /= Void and yyspecial_routines42 /= Void then
				yyspecial_routines42.keep_head (yyvs42, 0, yyvsp42 + 1)
			end
			if yyvs43 /= Void and yyspecial_routines43 /= Void then
				yyspecial_routines43.keep_head (yyvs43, 0, yyvsp43 + 1)
			end
			if yyvs44 /= Void and yyspecial_routines44 /= Void then
				yyspecial_routines44.keep_head (yyvs44, 0, yyvsp44 + 1)
			end
			if yyvs45 /= Void and yyspecial_routines45 /= Void then
				yyspecial_routines45.keep_head (yyvs45, 0, yyvsp45 + 1)
			end
			if yyvs46 /= Void and yyspecial_routines46 /= Void then
				yyspecial_routines46.keep_head (yyvs46, 0, yyvsp46 + 1)
			end
			if yyvs47 /= Void and yyspecial_routines47 /= Void then
				yyspecial_routines47.keep_head (yyvs47, 0, yyvsp47 + 1)
			end
			if yyvs48 /= Void and yyspecial_routines48 /= Void then
				yyspecial_routines48.keep_head (yyvs48, 0, yyvsp48 + 1)
			end
			if yyvs49 /= Void and yyspecial_routines49 /= Void then
				yyspecial_routines49.keep_head (yyvs49, 0, yyvsp49 + 1)
			end
			if yyvs50 /= Void and yyspecial_routines50 /= Void then
				yyspecial_routines50.keep_head (yyvs50, 0, yyvsp50 + 1)
			end
			if yyvs51 /= Void and yyspecial_routines51 /= Void then
				yyspecial_routines51.keep_head (yyvs51, 0, yyvsp51 + 1)
			end
			if yyvs52 /= Void and yyspecial_routines52 /= Void then
				yyspecial_routines52.keep_head (yyvs52, 0, yyvsp52 + 1)
			end
			if yyvs53 /= Void and yyspecial_routines53 /= Void then
				yyspecial_routines53.keep_head (yyvs53, 0, yyvsp53 + 1)
			end
			if yyvs54 /= Void and yyspecial_routines54 /= Void then
				yyspecial_routines54.keep_head (yyvs54, 0, yyvsp54 + 1)
			end
			if yyvs55 /= Void and yyspecial_routines55 /= Void then
				yyspecial_routines55.keep_head (yyvs55, 0, yyvsp55 + 1)
			end
			if yyvs56 /= Void and yyspecial_routines56 /= Void then
				yyspecial_routines56.keep_head (yyvs56, 0, yyvsp56 + 1)
			end
			if yyvs57 /= Void and yyspecial_routines57 /= Void then
				yyspecial_routines57.keep_head (yyvs57, 0, yyvsp57 + 1)
			end
			if yyvs58 /= Void and yyspecial_routines58 /= Void then
				yyspecial_routines58.keep_head (yyvs58, 0, yyvsp58 + 1)
			end
			if yyvs59 /= Void and yyspecial_routines59 /= Void then
				yyspecial_routines59.keep_head (yyvs59, 0, yyvsp59 + 1)
			end
			if yyvs60 /= Void and yyspecial_routines60 /= Void then
				yyspecial_routines60.keep_head (yyvs60, 0, yyvsp60 + 1)
			end
			if yyvs61 /= Void and yyspecial_routines61 /= Void then
				yyspecial_routines61.keep_head (yyvs61, 0, yyvsp61 + 1)
			end
			if yyvs62 /= Void and yyspecial_routines62 /= Void then
				yyspecial_routines62.keep_head (yyvs62, 0, yyvsp62 + 1)
			end
			if yyvs63 /= Void and yyspecial_routines63 /= Void then
				yyspecial_routines63.keep_head (yyvs63, 0, yyvsp63 + 1)
			end
			if yyvs64 /= Void and yyspecial_routines64 /= Void then
				yyspecial_routines64.keep_head (yyvs64, 0, yyvsp64 + 1)
			end
			if yyvs65 /= Void and yyspecial_routines65 /= Void then
				yyspecial_routines65.keep_head (yyvs65, 0, yyvsp65 + 1)
			end
			if yyvs66 /= Void and yyspecial_routines66 /= Void then
				yyspecial_routines66.keep_head (yyvs66, 0, yyvsp66 + 1)
			end
			if yyvs67 /= Void and yyspecial_routines67 /= Void then
				yyspecial_routines67.keep_head (yyvs67, 0, yyvsp67 + 1)
			end
			if yyvs68 /= Void and yyspecial_routines68 /= Void then
				yyspecial_routines68.keep_head (yyvs68, 0, yyvsp68 + 1)
			end
			if yyvs69 /= Void and yyspecial_routines69 /= Void then
				yyspecial_routines69.keep_head (yyvs69, 0, yyvsp69 + 1)
			end
			if yyvs70 /= Void and yyspecial_routines70 /= Void then
				yyspecial_routines70.keep_head (yyvs70, 0, yyvsp70 + 1)
			end
			if yyvs71 /= Void and yyspecial_routines71 /= Void then
				yyspecial_routines71.keep_head (yyvs71, 0, yyvsp71 + 1)
			end
			if yyvs72 /= Void and yyspecial_routines72 /= Void then
				yyspecial_routines72.keep_head (yyvs72, 0, yyvsp72 + 1)
			end
			if yyvs73 /= Void and yyspecial_routines73 /= Void then
				yyspecial_routines73.keep_head (yyvs73, 0, yyvsp73 + 1)
			end
			if yyvs74 /= Void and yyspecial_routines74 /= Void then
				yyspecial_routines74.keep_head (yyvs74, 0, yyvsp74 + 1)
			end
			if yyvs75 /= Void and yyspecial_routines75 /= Void then
				yyspecial_routines75.keep_head (yyvs75, 0, yyvsp75 + 1)
			end
			if yyvs76 /= Void and yyspecial_routines76 /= Void then
				yyspecial_routines76.keep_head (yyvs76, 0, yyvsp76 + 1)
			end
			if yyvs77 /= Void and yyspecial_routines77 /= Void then
				yyspecial_routines77.keep_head (yyvs77, 0, yyvsp77 + 1)
			end
			if yyvs78 /= Void and yyspecial_routines78 /= Void then
				yyspecial_routines78.keep_head (yyvs78, 0, yyvsp78 + 1)
			end
			if yyvs79 /= Void and yyspecial_routines79 /= Void then
				yyspecial_routines79.keep_head (yyvs79, 0, yyvsp79 + 1)
			end
			if yyvs80 /= Void and yyspecial_routines80 /= Void then
				yyspecial_routines80.keep_head (yyvs80, 0, yyvsp80 + 1)
			end
			if yyvs81 /= Void and yyspecial_routines81 /= Void then
				yyspecial_routines81.keep_head (yyvs81, 0, yyvsp81 + 1)
			end
			if yyvs82 /= Void and yyspecial_routines82 /= Void then
				yyspecial_routines82.keep_head (yyvs82, 0, yyvsp82 + 1)
			end
			if yyvs83 /= Void and yyspecial_routines83 /= Void then
				yyspecial_routines83.keep_head (yyvs83, 0, yyvsp83 + 1)
			end
			if yyvs84 /= Void and yyspecial_routines84 /= Void then
				yyspecial_routines84.keep_head (yyvs84, 0, yyvsp84 + 1)
			end
			if yyvs85 /= Void and yyspecial_routines85 /= Void then
				yyspecial_routines85.keep_head (yyvs85, 0, yyvsp85 + 1)
			end
			if yyvs86 /= Void and yyspecial_routines86 /= Void then
				yyspecial_routines86.keep_head (yyvs86, 0, yyvsp86 + 1)
			end
			if yyvs87 /= Void and yyspecial_routines87 /= Void then
				yyspecial_routines87.keep_head (yyvs87, 0, yyvsp87 + 1)
			end
			if yyvs88 /= Void and yyspecial_routines88 /= Void then
				yyspecial_routines88.keep_head (yyvs88, 0, yyvsp88 + 1)
			end
			if yyvs89 /= Void and yyspecial_routines89 /= Void then
				yyspecial_routines89.keep_head (yyvs89, 0, yyvsp89 + 1)
			end
			if yyvs90 /= Void and yyspecial_routines90 /= Void then
				yyspecial_routines90.keep_head (yyvs90, 0, yyvsp90 + 1)
			end
			if yyvs91 /= Void and yyspecial_routines91 /= Void then
				yyspecial_routines91.keep_head (yyvs91, 0, yyvsp91 + 1)
			end
			if yyvs92 /= Void and yyspecial_routines92 /= Void then
				yyspecial_routines92.keep_head (yyvs92, 0, yyvsp92 + 1)
			end
			if yyvs93 /= Void and yyspecial_routines93 /= Void then
				yyspecial_routines93.keep_head (yyvs93, 0, yyvsp93 + 1)
			end
			if yyvs94 /= Void and yyspecial_routines94 /= Void then
				yyspecial_routines94.keep_head (yyvs94, 0, yyvsp94 + 1)
			end
			if yyvs95 /= Void and yyspecial_routines95 /= Void then
				yyspecial_routines95.keep_head (yyvs95, 0, yyvsp95 + 1)
			end
			if yyvs96 /= Void and yyspecial_routines96 /= Void then
				yyspecial_routines96.keep_head (yyvs96, 0, yyvsp96 + 1)
			end
			if yyvs97 /= Void and yyspecial_routines97 /= Void then
				yyspecial_routines97.keep_head (yyvs97, 0, yyvsp97 + 1)
			end
			if yyvs98 /= Void and yyspecial_routines98 /= Void then
				yyspecial_routines98.keep_head (yyvs98, 0, yyvsp98 + 1)
			end
			if yyvs99 /= Void and yyspecial_routines99 /= Void then
				yyspecial_routines99.keep_head (yyvs99, 0, yyvsp99 + 1)
			end
			if yyvs100 /= Void and yyspecial_routines100 /= Void then
				yyspecial_routines100.keep_head (yyvs100, 0, yyvsp100 + 1)
			end
			if yyvs101 /= Void and yyspecial_routines101 /= Void then
				yyspecial_routines101.keep_head (yyvs101, 0, yyvsp101 + 1)
			end
			if yyvs102 /= Void and yyspecial_routines102 /= Void then
				yyspecial_routines102.keep_head (yyvs102, 0, yyvsp102 + 1)
			end
			if yyvs103 /= Void and yyspecial_routines103 /= Void then
				yyspecial_routines103.keep_head (yyvs103, 0, yyvsp103 + 1)
			end
			if yyvs104 /= Void and yyspecial_routines104 /= Void then
				yyspecial_routines104.keep_head (yyvs104, 0, yyvsp104 + 1)
			end
			if yyvs105 /= Void and yyspecial_routines105 /= Void then
				yyspecial_routines105.keep_head (yyvs105, 0, yyvsp105 + 1)
			end
			if yyvs106 /= Void and yyspecial_routines106 /= Void then
				yyspecial_routines106.keep_head (yyvs106, 0, yyvsp106 + 1)
			end
			if yyvs107 /= Void and yyspecial_routines107 /= Void then
				yyspecial_routines107.keep_head (yyvs107, 0, yyvsp107 + 1)
			end
			if yyvs108 /= Void and yyspecial_routines108 /= Void then
				yyspecial_routines108.keep_head (yyvs108, 0, yyvsp108 + 1)
			end
			if yyvs109 /= Void and yyspecial_routines109 /= Void then
				yyspecial_routines109.keep_head (yyvs109, 0, yyvsp109 + 1)
			end
			if yyvs110 /= Void and yyspecial_routines110 /= Void then
				yyspecial_routines110.keep_head (yyvs110, 0, yyvsp110 + 1)
			end
			if yyvs111 /= Void and yyspecial_routines111 /= Void then
				yyspecial_routines111.keep_head (yyvs111, 0, yyvsp111 + 1)
			end
			if yyvs112 /= Void and yyspecial_routines112 /= Void then
				yyspecial_routines112.keep_head (yyvs112, 0, yyvsp112 + 1)
			end
			if yyvs113 /= Void and yyspecial_routines113 /= Void then
				yyspecial_routines113.keep_head (yyvs113, 0, yyvsp113 + 1)
			end
			if yyvs114 /= Void and yyspecial_routines114 /= Void then
				yyspecial_routines114.keep_head (yyvs114, 0, yyvsp114 + 1)
			end
			if yyvs115 /= Void and yyspecial_routines115 /= Void then
				yyspecial_routines115.keep_head (yyvs115, 0, yyvsp115 + 1)
			end
			if yyvs116 /= Void and yyspecial_routines116 /= Void then
				yyspecial_routines116.keep_head (yyvs116, 0, yyvsp116 + 1)
			end
			if yyvs117 /= Void and yyspecial_routines117 /= Void then
				yyspecial_routines117.keep_head (yyvs117, 0, yyvsp117 + 1)
			end
			if yyvs118 /= Void and yyspecial_routines118 /= Void then
				yyspecial_routines118.keep_head (yyvs118, 0, yyvsp118 + 1)
			end
			if yyvs119 /= Void and yyspecial_routines119 /= Void then
				yyspecial_routines119.keep_head (yyvs119, 0, yyvsp119 + 1)
			end
			if yyvs120 /= Void and yyspecial_routines120 /= Void then
				yyspecial_routines120.keep_head (yyvs120, 0, yyvsp120 + 1)
			end
			if yyvs121 /= Void and yyspecial_routines121 /= Void then
				yyspecial_routines121.keep_head (yyvs121, 0, yyvsp121 + 1)
			end
			if yyvs122 /= Void and yyspecial_routines122 /= Void then
				yyspecial_routines122.keep_head (yyvs122, 0, yyvsp122 + 1)
			end
			if yyvs123 /= Void and yyspecial_routines123 /= Void then
				yyspecial_routines123.keep_head (yyvs123, 0, yyvsp123 + 1)
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
				if yyvsp1 >= yyvsc1 or yyvs1 = Void or yyspecial_routines1 = Void then
					if yyvs1 = Void or yyspecial_routines1 = Void then
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
				yyspecial_routines1.force (yyvs1, last_detachable_any_value, yyvsp1)
			when 4 then
				yyvsp4 := yyvsp4 + 1
				if yyvsp4 >= yyvsc4 or yyvs4 = Void or yyspecial_routines4 = Void then
					if yyvs4 = Void or yyspecial_routines4 = Void then
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
				yyspecial_routines4.force (yyvs4, last_detachable_symbol_as_value, yyvsp4)
			when 12 then
				yyvsp12 := yyvsp12 + 1
				if yyvsp12 >= yyvsc12 or yyvs12 = Void or yyspecial_routines12 = Void then
					if yyvs12 = Void or yyspecial_routines12 = Void then
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
				yyspecial_routines12.force (yyvs12, last_detachable_keyword_as_value, yyvsp12)
			when 2 then
				yyvsp2 := yyvsp2 + 1
				if yyvsp2 >= yyvsc2 or yyvs2 = Void or yyspecial_routines2 = Void then
					if yyvs2 = Void or yyspecial_routines2 = Void then
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
				yyspecial_routines2.force (yyvs2, last_detachable_id_as_value, yyvsp2)
			when 3 then
				yyvsp3 := yyvsp3 + 1
				if yyvsp3 >= yyvsc3 or yyvs3 = Void or yyspecial_routines3 = Void then
					if yyvs3 = Void or yyspecial_routines3 = Void then
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
				yyspecial_routines3.force (yyvs3, last_detachable_char_as_value, yyvsp3)
			when 5 then
				yyvsp5 := yyvsp5 + 1
				if yyvsp5 >= yyvsc5 or yyvs5 = Void or yyspecial_routines5 = Void then
					if yyvs5 = Void or yyspecial_routines5 = Void then
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
				yyspecial_routines5.force (yyvs5, last_detachable_bool_as_value, yyvsp5)
			when 6 then
				yyvsp6 := yyvsp6 + 1
				if yyvsp6 >= yyvsc6 or yyvs6 = Void or yyspecial_routines6 = Void then
					if yyvs6 = Void or yyspecial_routines6 = Void then
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
				yyspecial_routines6.force (yyvs6, last_detachable_result_as_value, yyvsp6)
			when 7 then
				yyvsp7 := yyvsp7 + 1
				if yyvsp7 >= yyvsc7 or yyvs7 = Void or yyspecial_routines7 = Void then
					if yyvs7 = Void or yyspecial_routines7 = Void then
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
				yyspecial_routines7.force (yyvs7, last_detachable_retry_as_value, yyvsp7)
			when 8 then
				yyvsp8 := yyvsp8 + 1
				if yyvsp8 >= yyvsc8 or yyvs8 = Void or yyspecial_routines8 = Void then
					if yyvs8 = Void or yyspecial_routines8 = Void then
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
				yyspecial_routines8.force (yyvs8, last_detachable_unique_as_value, yyvsp8)
			when 9 then
				yyvsp9 := yyvsp9 + 1
				if yyvsp9 >= yyvsc9 or yyvs9 = Void or yyspecial_routines9 = Void then
					if yyvs9 = Void or yyspecial_routines9 = Void then
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
				yyspecial_routines9.force (yyvs9, last_detachable_current_as_value, yyvsp9)
			when 10 then
				yyvsp10 := yyvsp10 + 1
				if yyvsp10 >= yyvsc10 or yyvs10 = Void or yyspecial_routines10 = Void then
					if yyvs10 = Void or yyspecial_routines10 = Void then
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
				yyspecial_routines10.force (yyvs10, last_detachable_deferred_as_value, yyvsp10)
			when 11 then
				yyvsp11 := yyvsp11 + 1
				if yyvsp11 >= yyvsc11 or yyvs11 = Void or yyspecial_routines11 = Void then
					if yyvs11 = Void or yyspecial_routines11 = Void then
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
				yyspecial_routines11.force (yyvs11, last_detachable_void_as_value, yyvsp11)
			when 15 then
				yyvsp15 := yyvsp15 + 1
				if yyvsp15 >= yyvsc15 or yyvs15 = Void or yyspecial_routines15 = Void then
					if yyvs15 = Void or yyspecial_routines15 = Void then
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
				yyspecial_routines15.force (yyvs15, last_keyword_id_value, yyvsp15)
			when 16 then
				yyvsp16 := yyvsp16 + 1
				if yyvsp16 >= yyvsc16 or yyvs16 = Void or yyspecial_routines16 = Void then
					if yyvs16 = Void or yyspecial_routines16 = Void then
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
				yyspecial_routines16.force (yyvs16, last_detachable_string_as_value, yyvsp16)
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
			yyval1: detachable ANY
		do
			yyvsp1 := yyvsp1 + 1
			if yyvsp1 >= yyvsc1 or yyvs1 = Void or yyspecial_routines1 = Void then
				if yyvs1 = Void or yyspecial_routines1 = Void then
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
			when 119 then
				yyvsp119 := yyvsp119 - 1
			when 120 then
				yyvsp120 := yyvsp120 - 1
			when 121 then
				yyvsp121 := yyvsp121 - 1
			when 122 then
				yyvsp122 := yyvsp122 - 1
			when 123 then
				yyvsp123 := yyvsp123 - 1
			else
				debug ("GEYACC")
					std.error.put_string ("Error in parser: unknown type id: ")
					std.error.put_integer (yy_type_id)
					std.error.put_new_line
				end
				abort
			end
		end

	yy_run_geyacc
			-- You must run geyacc to regenerate this class.
		do
		end

feature {NONE} -- Semantic actions

	yy_do_action (yy_act: INTEGER)
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

	yy_do_action_1_200 (yy_act: INTEGER)
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

	yy_do_action_201_400 (yy_act: INTEGER)
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

	yy_do_action_401_600 (yy_act: INTEGER)
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
			when 567 then
					--|#line <not available> "eiffel.y"
				yy_do_action_567
			when 568 then
					--|#line <not available> "eiffel.y"
				yy_do_action_568
			when 569 then
					--|#line <not available> "eiffel.y"
				yy_do_action_569
			when 570 then
					--|#line <not available> "eiffel.y"
				yy_do_action_570
			when 571 then
					--|#line <not available> "eiffel.y"
				yy_do_action_571
			when 572 then
					--|#line <not available> "eiffel.y"
				yy_do_action_572
			when 573 then
					--|#line <not available> "eiffel.y"
				yy_do_action_573
			when 574 then
					--|#line <not available> "eiffel.y"
				yy_do_action_574
			when 575 then
					--|#line <not available> "eiffel.y"
				yy_do_action_575
			when 576 then
					--|#line <not available> "eiffel.y"
				yy_do_action_576
			when 577 then
					--|#line <not available> "eiffel.y"
				yy_do_action_577
			when 578 then
					--|#line <not available> "eiffel.y"
				yy_do_action_578
			when 579 then
					--|#line <not available> "eiffel.y"
				yy_do_action_579
			when 580 then
					--|#line <not available> "eiffel.y"
				yy_do_action_580
			when 581 then
					--|#line <not available> "eiffel.y"
				yy_do_action_581
			when 582 then
					--|#line <not available> "eiffel.y"
				yy_do_action_582
			when 583 then
					--|#line <not available> "eiffel.y"
				yy_do_action_583
			when 584 then
					--|#line <not available> "eiffel.y"
				yy_do_action_584
			when 585 then
					--|#line <not available> "eiffel.y"
				yy_do_action_585
			when 586 then
					--|#line <not available> "eiffel.y"
				yy_do_action_586
			when 587 then
					--|#line <not available> "eiffel.y"
				yy_do_action_587
			when 588 then
					--|#line <not available> "eiffel.y"
				yy_do_action_588
			when 589 then
					--|#line <not available> "eiffel.y"
				yy_do_action_589
			when 590 then
					--|#line <not available> "eiffel.y"
				yy_do_action_590
			when 591 then
					--|#line <not available> "eiffel.y"
				yy_do_action_591
			when 592 then
					--|#line <not available> "eiffel.y"
				yy_do_action_592
			when 593 then
					--|#line <not available> "eiffel.y"
				yy_do_action_593
			when 594 then
					--|#line <not available> "eiffel.y"
				yy_do_action_594
			when 595 then
					--|#line <not available> "eiffel.y"
				yy_do_action_595
			when 596 then
					--|#line <not available> "eiffel.y"
				yy_do_action_596
			when 597 then
					--|#line <not available> "eiffel.y"
				yy_do_action_597
			when 598 then
					--|#line <not available> "eiffel.y"
				yy_do_action_598
			when 599 then
					--|#line <not available> "eiffel.y"
				yy_do_action_599
			when 600 then
					--|#line <not available> "eiffel.y"
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

	yy_do_action_601_800 (yy_act: INTEGER)
			-- Execute semantic action.
		do
			inspect yy_act
			when 601 then
					--|#line <not available> "eiffel.y"
				yy_do_action_601
			when 602 then
					--|#line <not available> "eiffel.y"
				yy_do_action_602
			when 603 then
					--|#line <not available> "eiffel.y"
				yy_do_action_603
			when 604 then
					--|#line <not available> "eiffel.y"
				yy_do_action_604
			when 605 then
					--|#line <not available> "eiffel.y"
				yy_do_action_605
			when 606 then
					--|#line <not available> "eiffel.y"
				yy_do_action_606
			when 607 then
					--|#line <not available> "eiffel.y"
				yy_do_action_607
			when 608 then
					--|#line <not available> "eiffel.y"
				yy_do_action_608
			when 609 then
					--|#line <not available> "eiffel.y"
				yy_do_action_609
			when 610 then
					--|#line <not available> "eiffel.y"
				yy_do_action_610
			when 611 then
					--|#line <not available> "eiffel.y"
				yy_do_action_611
			when 612 then
					--|#line <not available> "eiffel.y"
				yy_do_action_612
			when 613 then
					--|#line <not available> "eiffel.y"
				yy_do_action_613
			when 614 then
					--|#line <not available> "eiffel.y"
				yy_do_action_614
			when 615 then
					--|#line <not available> "eiffel.y"
				yy_do_action_615
			when 616 then
					--|#line <not available> "eiffel.y"
				yy_do_action_616
			when 617 then
					--|#line <not available> "eiffel.y"
				yy_do_action_617
			when 618 then
					--|#line <not available> "eiffel.y"
				yy_do_action_618
			when 619 then
					--|#line <not available> "eiffel.y"
				yy_do_action_619
			when 620 then
					--|#line <not available> "eiffel.y"
				yy_do_action_620
			when 621 then
					--|#line <not available> "eiffel.y"
				yy_do_action_621
			when 622 then
					--|#line <not available> "eiffel.y"
				yy_do_action_622
			when 623 then
					--|#line <not available> "eiffel.y"
				yy_do_action_623
			when 624 then
					--|#line <not available> "eiffel.y"
				yy_do_action_624
			when 625 then
					--|#line <not available> "eiffel.y"
				yy_do_action_625
			when 626 then
					--|#line <not available> "eiffel.y"
				yy_do_action_626
			when 627 then
					--|#line <not available> "eiffel.y"
				yy_do_action_627
			when 628 then
					--|#line <not available> "eiffel.y"
				yy_do_action_628
			when 629 then
					--|#line <not available> "eiffel.y"
				yy_do_action_629
			else
				debug ("GEYACC")
					std.error.put_string ("Error in parser: unknown rule id: ")
					std.error.put_integer (yy_act)
					std.error.put_new_line
				end
				abort
			end
		end

	yy_do_action_1
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines1 /= Void
			yyvs1 /= Void
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if type_parser or expression_parser or feature_parser or indexing_parser or entity_declaration_parser or invariant_parser then
					raise_error
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
		end

	yy_do_action_2
			--|#line <not available> "eiffel.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if not type_parser or expression_parser or feature_parser or indexing_parser or entity_declaration_parser or invariant_parser then
					raise_error
				end
				type_node := yyvs81.item (yyvsp81)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp81 := yyvsp81 -1
	if yyvsp1 >= yyvsc1 or yyvs1 = Void or yyspecial_routines1 = Void then
		if yyvs1 = Void or yyspecial_routines1 = Void then
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
		end

	yy_do_action_3
			--|#line <not available> "eiffel.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if not feature_parser or type_parser or expression_parser or indexing_parser or entity_declaration_parser or invariant_parser then
					raise_error
				end
				feature_node := yyvs51.item (yyvsp51)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp51 := yyvsp51 -1
	if yyvsp1 >= yyvsc1 or yyvs1 = Void or yyspecial_routines1 = Void then
		if yyvs1 = Void or yyspecial_routines1 = Void then
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
		end

	yy_do_action_4
			--|#line <not available> "eiffel.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if not expression_parser or type_parser or feature_parser or indexing_parser or entity_declaration_parser or invariant_parser then
					raise_error
				end
				expression_node := yyvs48.item (yyvsp48)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp48 := yyvsp48 -1
	if yyvsp1 >= yyvsc1 or yyvs1 = Void or yyspecial_routines1 = Void then
		if yyvs1 = Void or yyspecial_routines1 = Void then
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
		end

	yy_do_action_5
			--|#line <not available> "eiffel.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if not indexing_parser or type_parser or expression_parser or feature_parser or entity_declaration_parser or invariant_parser then
					raise_error
				end
				indexing_node := yyvs105.item (yyvsp105)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp1 := yyvsp1 + 1
	yyvsp105 := yyvsp105 -1
	if yyvsp1 >= yyvsc1 or yyvs1 = Void or yyspecial_routines1 = Void then
		if yyvs1 = Void or yyspecial_routines1 = Void then
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
		end

	yy_do_action_6
			--|#line <not available> "eiffel.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if not invariant_parser or type_parser or expression_parser or feature_parser or indexing_parser or entity_declaration_parser then
					raise_error
				end
				invariant_node := yyvs64.item (yyvsp64)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp64 := yyvsp64 -1
	if yyvsp1 >= yyvsc1 or yyvs1 = Void or yyspecial_routines1 = Void then
		if yyvs1 = Void or yyspecial_routines1 = Void then
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
		end

	yy_do_action_7
			--|#line <not available> "eiffel.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if not entity_declaration_parser or type_parser or expression_parser or feature_parser or indexing_parser or invariant_parser then
					raise_error
				end
				entity_declaration_node := Void
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp1 := yyvsp1 + 1
	yyvsp12 := yyvsp12 -1
	if yyvsp1 >= yyvsc1 or yyvs1 = Void or yyspecial_routines1 = Void then
		if yyvs1 = Void or yyspecial_routines1 = Void then
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
		end

	yy_do_action_8
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines1 /= Void
			yyvs1 /= Void
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if not entity_declaration_parser or type_parser or expression_parser or feature_parser or indexing_parser or invariant_parser then
					raise_error
				end
				entity_declaration_node := yyvs118.item (yyvsp118)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp1 := yyvsp1 -1
	yyvsp12 := yyvsp12 -1
	yyvsp118 := yyvsp118 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
		end

	yy_do_action_9
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines1 /= Void
			yyvs1 /= Void
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs20.item (yyvsp20 - 1) as l_external then
					temp_string_as1 := l_external.second
				else
					temp_string_as1 := Void
				end
				if attached yyvs20.item (yyvsp20) as l_obsolete then
					temp_string_as2 := l_obsolete.second
				else
					temp_string_as2 := Void
				end
				
				root_node := new_class_description (yyvs2.item (yyvsp2), temp_string_as1,
					is_deferred, is_expanded, is_frozen_class, is_external_class, is_partial_class,
					yyvs105.item (yyvsp105 - 1), yyvs105.item (yyvsp105), yyvs103.item (yyvsp103), yyvs111.item (yyvsp111 - 1), yyvs111.item (yyvsp111), yyvs90.item (yyvsp90), yyvs89.item (yyvsp89), yyvs97.item (yyvsp97), yyvs64.item (yyvsp64), suppliers, temp_string_as2, yyvs12.item (yyvsp12))
				if attached root_node as l_root_node then
					l_root_node.set_text_positions (
						formal_generics_end_position,
						conforming_inheritance_end_position,
						non_conforming_inheritance_end_position,
						features_end_position
					)
					if attached yyvs20.item (yyvsp20 - 1) as l_external then
						l_root_node.set_alias_keyword (l_external.first)
					end
					if attached yyvs20.item (yyvsp20) as l_obsolete then
						l_root_node.set_obsolete_keyword (l_obsolete.first)
					end
					l_root_node.set_header_mark (frozen_keyword, expanded_keyword, deferred_keyword, external_keyword)
					l_root_node.set_class_keyword (yyvs12.item (yyvsp12 - 1))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 19
	yyvsp1 := yyvsp1 -4
	yyvsp105 := yyvsp105 -2
	yyvsp12 := yyvsp12 -2
	yyvsp2 := yyvsp2 -1
	yyvsp103 := yyvsp103 -1
	yyvsp20 := yyvsp20 -2
	yyvsp111 := yyvsp111 -2
	yyvsp90 := yyvsp90 -1
	yyvsp89 := yyvsp89 -1
	yyvsp97 := yyvsp97 -1
	yyvsp64 := yyvsp64 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
		end

	yy_do_action_10
			--|#line <not available> "eiffel.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

conforming_inheritance_flag := False; non_conforming_inheritance_flag := False 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp1 := yyvsp1 + 1
	if yyvsp1 >= yyvsc1 or yyvs1 = Void or yyspecial_routines1 = Void then
		if yyvs1 = Void or yyspecial_routines1 = Void then
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
		end

	yy_do_action_11
			--|#line <not available> "eiffel.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

conforming_inheritance_end_position := position; conforming_inheritance_flag := True
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp1 := yyvsp1 + 1
	if yyvsp1 >= yyvsc1 or yyvs1 = Void or yyspecial_routines1 = Void then
		if yyvs1 = Void or yyspecial_routines1 = Void then
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
		end

	yy_do_action_12
			--|#line <not available> "eiffel.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

non_conforming_inheritance_end_position := position
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp1 := yyvsp1 + 1
	if yyvsp1 >= yyvsc1 or yyvs1 = Void or yyspecial_routines1 = Void then
		if yyvs1 = Void or yyspecial_routines1 = Void then
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
		end

	yy_do_action_13
			--|#line <not available> "eiffel.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

features_end_position := position 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp1 := yyvsp1 + 1
	if yyvsp1 >= yyvsc1 or yyvs1 = Void or yyspecial_routines1 = Void then
		if yyvs1 = Void or yyspecial_routines1 = Void then
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
		end

	yy_do_action_14
			--|#line <not available> "eiffel.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

feature_clause_end_position := position 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp1 := yyvsp1 + 1
	if yyvsp1 >= yyvsc1 or yyvs1 = Void or yyspecial_routines1 = Void then
		if yyvs1 = Void or yyspecial_routines1 = Void then
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
		end

	yy_do_action_15
			--|#line <not available> "eiffel.y"
		local
			yyval105: detachable INDEXING_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp105 := yyvsp105 + 1
	if yyvsp105 >= yyvsc105 or yyvs105 = Void or yyspecial_routines105 = Void then
		if yyvs105 = Void or yyspecial_routines105 = Void then
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
	yyspecial_routines105.force (yyvs105, yyval105, yyvsp105)
end
		end

	yy_do_action_16
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines105 /= Void
			yyvs105 /= Void
		local
			yyval105: detachable INDEXING_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs105.item (yyvsp105) as l_list then
					yyval105 := l_list
					l_list.set_indexing_keyword (extract_keyword (yyvs15.item (yyvsp15)))
				end				
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp15 := yyvsp15 -1
	yyvsp1 := yyvsp1 -2
	yyspecial_routines105.force (yyvs105, yyval105, yyvsp105)
end
		end

	yy_do_action_17
			--|#line <not available> "eiffel.y"
		local
			yyval105: detachable INDEXING_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached ast_factory.new_indexing_clause_as (0) as l_list then
					yyval105 := l_list
					l_list.set_indexing_keyword (extract_keyword (yyvs15.item (yyvsp15)))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp105 := yyvsp105 + 1
	yyvsp15 := yyvsp15 -1
	if yyvsp105 >= yyvsc105 or yyvs105 = Void or yyspecial_routines105 = Void then
		if yyvs105 = Void or yyspecial_routines105 = Void then
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
	yyspecial_routines105.force (yyvs105, yyval105, yyvsp105)
end
		end

	yy_do_action_18
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines105 /= Void
			yyvs105 /= Void
		local
			yyval105: detachable INDEXING_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs105.item (yyvsp105) as l_list then
					yyval105 := l_list
					l_list.set_indexing_keyword (extract_keyword (yyvs15.item (yyvsp15)))
				end				
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp15 := yyvsp15 -1
	yyvsp1 := yyvsp1 -2
	yyspecial_routines105.force (yyvs105, yyval105, yyvsp105)
end
		end

	yy_do_action_19
			--|#line <not available> "eiffel.y"
		local
			yyval105: detachable INDEXING_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached ast_factory.new_indexing_clause_as (0) as l_list then
					yyval105 := l_list
					l_list.set_indexing_keyword (extract_keyword (yyvs15.item (yyvsp15)))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp105 := yyvsp105 + 1
	yyvsp15 := yyvsp15 -1
	if yyvsp105 >= yyvsc105 or yyvs105 = Void or yyspecial_routines105 = Void then
		if yyvs105 = Void or yyspecial_routines105 = Void then
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
	yyspecial_routines105.force (yyvs105, yyval105, yyvsp105)
end
		end

	yy_do_action_20
			--|#line <not available> "eiffel.y"
		local
			yyval105: detachable INDEXING_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp105 := yyvsp105 + 1
	if yyvsp105 >= yyvsc105 or yyvs105 = Void or yyspecial_routines105 = Void then
		if yyvs105 = Void or yyspecial_routines105 = Void then
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
	yyspecial_routines105.force (yyvs105, yyval105, yyvsp105)
end
		end

	yy_do_action_21
			--|#line <not available> "eiffel.y"
		local
			yyval105: detachable INDEXING_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached ast_factory.new_indexing_clause_as (0) as l_list then
						yyval105 := l_list
						l_list.set_indexing_keyword (extract_keyword (yyvs15.item (yyvsp15)))
						l_list.set_end_keyword (yyvs12.item (yyvsp12))
				end		
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs12.item (yyvsp12)), token_column (yyvs12.item (yyvsp12)), filename,
						once "Missing `attribute' keyword before `end' keyword."))
				end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp105 := yyvsp105 + 1
	yyvsp15 := yyvsp15 -1
	yyvsp12 := yyvsp12 -1
	if yyvsp105 >= yyvsc105 or yyvs105 = Void or yyspecial_routines105 = Void then
		if yyvs105 = Void or yyspecial_routines105 = Void then
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
	yyspecial_routines105.force (yyvs105, yyval105, yyvsp105)
end
		end

	yy_do_action_22
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines105 /= Void
			yyvs105 /= Void
		local
			yyval105: detachable INDEXING_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs105.item (yyvsp105) as l_list then
					yyval105 := l_list
					if attached yyvs15.item (yyvsp15) as l_indexing then
						l_list.set_indexing_keyword (extract_keyword (l_indexing))
					end
					if attached yyvs12.item (yyvsp12) as l_end then
						l_list.set_end_keyword (l_end)
					end
				end				
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs12.item (yyvsp12)), token_column (yyvs12.item (yyvsp12)), filename,
						once "Missing `attribute' keyword before `end' keyword."))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp15 := yyvsp15 -1
	yyvsp1 := yyvsp1 -2
	yyvsp12 := yyvsp12 -1
	yyspecial_routines105.force (yyvs105, yyval105, yyvsp105)
end
		end

	yy_do_action_23
			--|#line <not available> "eiffel.y"
		local
			yyval105: detachable INDEXING_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval105 := ast_factory.new_indexing_clause_as (counter_value + 1)
				if attached yyval105 as l_list and then attached yyvs58.item (yyvsp58) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp105 := yyvsp105 + 1
	yyvsp58 := yyvsp58 -1
	if yyvsp105 >= yyvsc105 or yyvs105 = Void or yyspecial_routines105 = Void then
		if yyvs105 = Void or yyspecial_routines105 = Void then
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
	yyspecial_routines105.force (yyvs105, yyval105, yyvsp105)
end
		end

	yy_do_action_24
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines105 /= Void
			yyvs105 /= Void
		local
			yyval105: detachable INDEXING_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval105 := yyvs105.item (yyvsp105)
				if attached yyval105 as l_list and then attached yyvs58.item (yyvsp58) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp58 := yyvsp58 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines105.force (yyvs105, yyval105, yyvsp105)
end
		end

	yy_do_action_25
			--|#line <not available> "eiffel.y"
		local
			yyval105: detachable INDEXING_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval105 := ast_factory.new_indexing_clause_as (counter_value + 1)
				if attached yyval105 as l_list and then attached yyvs58.item (yyvsp58) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp105 := yyvsp105 + 1
	yyvsp58 := yyvsp58 -1
	if yyvsp105 >= yyvsc105 or yyvs105 = Void or yyspecial_routines105 = Void then
		if yyvs105 = Void or yyspecial_routines105 = Void then
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
	yyspecial_routines105.force (yyvs105, yyval105, yyvsp105)
end
		end

	yy_do_action_26
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines105 /= Void
			yyvs105 /= Void
		local
			yyval105: detachable INDEXING_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval105 := yyvs105.item (yyvsp105)
				if attached yyval105 as l_list and then attached yyvs58.item (yyvsp58) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp58 := yyvsp58 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines105.force (yyvs105, yyval105, yyvsp105)
end
		end

	yy_do_action_27
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines58 /= Void
			yyvs58 /= Void
		local
			yyval58: detachable INDEX_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval58 := yyvs58.item (yyvsp58) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyspecial_routines58.force (yyvs58, yyval58, yyvsp58)
end
		end

	yy_do_action_28
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines58 /= Void
			yyvs58 /= Void
		local
			yyval58: detachable INDEX_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval58 := yyvs58.item (yyvsp58) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyspecial_routines58.force (yyvs58, yyval58, yyvsp58)
end
		end

	yy_do_action_29
			--|#line <not available> "eiffel.y"
		local
			yyval58: detachable INDEX_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval58 := ast_factory.new_index_as (yyvs2.item (yyvsp2), yyvs87.item (yyvsp87), yyvs4.item (yyvsp4 - 1))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp58 := yyvsp58 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -2
	yyvsp87 := yyvsp87 -1
	if yyvsp58 >= yyvsc58 or yyvs58 = Void or yyspecial_routines58 = Void then
		if yyvs58 = Void or yyspecial_routines58 = Void then
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
	yyspecial_routines58.force (yyvs58, yyval58, yyvsp58)
end
		end

	yy_do_action_30
			--|#line <not available> "eiffel.y"
		local
			yyval58: detachable INDEX_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval58 := ast_factory.new_index_as (Void, yyvs87.item (yyvsp87), Void)
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs87.item (yyvsp87)), token_column (yyvs87.item (yyvsp87)), filename,
						once "Missing `Index' part of `Index_clause'."))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp58 := yyvsp58 + 1
	yyvsp87 := yyvsp87 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp58 >= yyvsc58 or yyvs58 = Void or yyspecial_routines58 = Void then
		if yyvs58 = Void or yyspecial_routines58 = Void then
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
	yyspecial_routines58.force (yyvs58, yyval58, yyvsp58)
end
		end

	yy_do_action_31
			--|#line <not available> "eiffel.y"
		local
			yyval58: detachable INDEX_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval58 := ast_factory.new_index_as (yyvs2.item (yyvsp2), yyvs87.item (yyvsp87), yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp58 := yyvsp58 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -1
	yyvsp87 := yyvsp87 -1
	if yyvsp58 >= yyvsc58 or yyvs58 = Void or yyspecial_routines58 = Void then
		if yyvs58 = Void or yyspecial_routines58 = Void then
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
	yyspecial_routines58.force (yyvs58, yyval58, yyvsp58)
end
		end

	yy_do_action_32
			--|#line <not available> "eiffel.y"
		local
			yyval87: detachable EIFFEL_LIST [ATOMIC_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval87 := ast_factory.new_eiffel_list_atomic_as (counter_value + 1)
				if attached yyval87 as l_list and then attached yyvs31.item (yyvsp31) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp87 := yyvsp87 + 1
	yyvsp31 := yyvsp31 -1
	if yyvsp87 >= yyvsc87 or yyvs87 = Void or yyspecial_routines87 = Void then
		if yyvs87 = Void or yyspecial_routines87 = Void then
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
	yyspecial_routines87.force (yyvs87, yyval87, yyvsp87)
end
		end

	yy_do_action_33
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines87 /= Void
			yyvs87 /= Void
		local
			yyval87: detachable EIFFEL_LIST [ATOMIC_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval87 := yyvs87.item (yyvsp87)
				if attached yyval87 as l_list and then attached yyvs31.item (yyvsp31) as l_val then
					l_list.reverse_extend (l_val)
					ast_factory.reverse_extend_separator (l_list, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp31 := yyvsp31 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines87.force (yyvs87, yyval87, yyvsp87)
end
		end

	yy_do_action_34
			--|#line <not available> "eiffel.y"
		local
			yyval87: detachable EIFFEL_LIST [ATOMIC_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

-- TO DO: remove this TE_SEMICOLON (see: INDEX_AS.index_list /= Void)
				yyval87 := ast_factory.new_eiffel_list_atomic_as (0)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp87 := yyvsp87 + 1
	yyvsp4 := yyvsp4 -1
	if yyvsp87 >= yyvsc87 or yyvs87 = Void or yyspecial_routines87 = Void then
		if yyvs87 = Void or yyspecial_routines87 = Void then
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
	yyspecial_routines87.force (yyvs87, yyval87, yyvsp87)
end
		end

	yy_do_action_35
			--|#line <not available> "eiffel.y"
		local
			yyval87: detachable EIFFEL_LIST [ATOMIC_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval87 := ast_factory.new_eiffel_list_atomic_as (counter_value + 1)
				if attached yyval87 as l_list and then attached yyvs31.item (yyvsp31) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp87 := yyvsp87 + 1
	yyvsp31 := yyvsp31 -1
	if yyvsp87 >= yyvsc87 or yyvs87 = Void or yyspecial_routines87 = Void then
		if yyvs87 = Void or yyspecial_routines87 = Void then
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
	yyspecial_routines87.force (yyvs87, yyval87, yyvsp87)
end
		end

	yy_do_action_36
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines87 /= Void
			yyvs87 /= Void
		local
			yyval87: detachable EIFFEL_LIST [ATOMIC_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval87 := yyvs87.item (yyvsp87)
				if attached yyval87 as l_list and then attached yyvs31.item (yyvsp31) as l_val then
					l_list.reverse_extend (l_val)
					ast_factory.reverse_extend_separator (l_list, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp31 := yyvsp31 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines87.force (yyvs87, yyval87, yyvsp87)
end
		end

	yy_do_action_37
			--|#line <not available> "eiffel.y"
		local
			yyval31: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval31 := yyvs2.item (yyvsp2) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp31 := yyvsp31 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp31 >= yyvsc31 or yyvs31 = Void or yyspecial_routines31 = Void then
		if yyvs31 = Void or yyspecial_routines31 = Void then
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
	yyspecial_routines31.force (yyvs31, yyval31, yyvsp31)
end
		end

	yy_do_action_38
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines31 /= Void
			yyvs31 /= Void
		local
			yyval31: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval31 := yyvs31.item (yyvsp31) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines31.force (yyvs31, yyval31, yyvsp31)
end
		end

	yy_do_action_39
			--|#line <not available> "eiffel.y"
		local
			yyval31: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval31 := ast_factory.new_custom_attribute_as (yyvs43.item (yyvsp43), Void, yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp31 := yyvsp31 + 1
	yyvsp1 := yyvsp1 -2
	yyvsp43 := yyvsp43 -1
	yyvsp12 := yyvsp12 -1
	if yyvsp31 >= yyvsc31 or yyvs31 = Void or yyspecial_routines31 = Void then
		if yyvs31 = Void or yyspecial_routines31 = Void then
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
	yyspecial_routines31.force (yyvs31, yyval31, yyvsp31)
end
		end

	yy_do_action_40
			--|#line <not available> "eiffel.y"
		local
			yyval31: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval31 := ast_factory.new_custom_attribute_as (yyvs43.item (yyvsp43), yyvs80.item (yyvsp80), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp31 := yyvsp31 + 1
	yyvsp1 := yyvsp1 -2
	yyvsp43 := yyvsp43 -1
	yyvsp80 := yyvsp80 -1
	yyvsp12 := yyvsp12 -1
	if yyvsp31 >= yyvsc31 or yyvs31 = Void or yyspecial_routines31 = Void then
		if yyvs31 = Void or yyspecial_routines31 = Void then
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
	yyspecial_routines31.force (yyvs31, yyval31, yyvsp31)
end
		end

	yy_do_action_41
			--|#line <not available> "eiffel.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			is_supplier_recorded := False
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp1 := yyvsp1 + 1
	if yyvsp1 >= yyvsc1 or yyvs1 = Void or yyspecial_routines1 = Void then
		if yyvs1 = Void or yyspecial_routines1 = Void then
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
		end

	yy_do_action_42
			--|#line <not available> "eiffel.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			is_supplier_recorded := True
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp1 := yyvsp1 + 1
	if yyvsp1 >= yyvsc1 or yyvs1 = Void or yyspecial_routines1 = Void then
		if yyvs1 = Void or yyspecial_routines1 = Void then
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
		end

	yy_do_action_43
			--|#line <not available> "eiffel.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			if not il_parser then
				is_supplier_recorded := False
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp1 := yyvsp1 + 1
	if yyvsp1 >= yyvsc1 or yyvs1 = Void or yyspecial_routines1 = Void then
		if yyvs1 = Void or yyspecial_routines1 = Void then
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
		end

	yy_do_action_44
			--|#line <not available> "eiffel.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			if not il_parser then
				is_supplier_recorded := True
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp1 := yyvsp1 + 1
	if yyvsp1 >= yyvsc1 or yyvs1 = Void or yyspecial_routines1 = Void then
		if yyvs1 = Void or yyspecial_routines1 = Void then
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
		end

	yy_do_action_45
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines1 /= Void
			yyvs1 /= Void
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
		end

	yy_do_action_46
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines1 /= Void
			yyvs1 /= Void
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				is_deferred := True
				deferred_keyword := yyvs10.item (yyvsp10)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp10 := yyvsp10 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
		end

	yy_do_action_47
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines1 /= Void
			yyvs1 /= Void
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				is_expanded := True
				expanded_keyword := yyvs12.item (yyvsp12)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -1
	yyvsp12 := yyvsp12 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
		end

	yy_do_action_48
			--|#line <not available> "eiffel.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp1 := yyvsp1 + 1
	if yyvsp1 >= yyvsc1 or yyvs1 = Void or yyspecial_routines1 = Void then
		if yyvs1 = Void or yyspecial_routines1 = Void then
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
		end

	yy_do_action_49
			--|#line <not available> "eiffel.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				is_frozen_class := True
				frozen_keyword := yyvs12.item (yyvsp12)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp1 := yyvsp1 + 1
	yyvsp12 := yyvsp12 -1
	if yyvsp1 >= yyvsc1 or yyvs1 = Void or yyspecial_routines1 = Void then
		if yyvs1 = Void or yyspecial_routines1 = Void then
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
		end

	yy_do_action_50
			--|#line <not available> "eiffel.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp1 := yyvsp1 + 1
	if yyvsp1 >= yyvsc1 or yyvs1 = Void or yyspecial_routines1 = Void then
		if yyvs1 = Void or yyspecial_routines1 = Void then
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
		end

	yy_do_action_51
			--|#line <not available> "eiffel.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if il_parser then
					is_external_class := True
					external_keyword := yyvs12.item (yyvsp12)
				else
						-- Trigger a syntax error.
					raise_error
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp1 := yyvsp1 + 1
	yyvsp12 := yyvsp12 -1
	if yyvsp1 >= yyvsc1 or yyvs1 = Void or yyspecial_routines1 = Void then
		if yyvs1 = Void or yyspecial_routines1 = Void then
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
		end

	yy_do_action_52
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines12 /= Void
			yyvs12 /= Void
		local
			yyval12: detachable KEYWORD_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval12 := yyvs12.item (yyvsp12);
				is_partial_class := false;
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines12.force (yyvs12, yyval12, yyvsp12)
end
		end

	yy_do_action_53
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines12 /= Void
			yyvs12 /= Void
		local
			yyval12: detachable KEYWORD_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			yyval12 := yyvs12.item (yyvsp12);
			is_partial_class := true;
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines12.force (yyvs12, yyval12, yyvsp12)
end
		end

	yy_do_action_54
			--|#line <not available> "eiffel.y"
		local
			yyval20: detachable PAIR [KEYWORD_AS, STRING_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp20 := yyvsp20 + 1
	if yyvsp20 >= yyvsc20 or yyvs20 = Void or yyspecial_routines20 = Void then
		if yyvs20 = Void or yyspecial_routines20 = Void then
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
	yyspecial_routines20.force (yyvs20, yyval20, yyvsp20)
end
		end

	yy_do_action_55
			--|#line <not available> "eiffel.y"
		local
			yyval20: detachable PAIR [KEYWORD_AS, STRING_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval20 := ast_factory.new_keyword_string_pair (yyvs12.item (yyvsp12), yyvs16.item (yyvsp16))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp20 := yyvsp20 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp20 >= yyvsc20 or yyvs20 = Void or yyspecial_routines20 = Void then
		if yyvs20 = Void or yyspecial_routines20 = Void then
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
	yyspecial_routines20.force (yyvs20, yyval20, yyvsp20)
end
		end

	yy_do_action_56
			--|#line <not available> "eiffel.y"
		local
			yyval97: detachable EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp97 := yyvsp97 + 1
	if yyvsp97 >= yyvsc97 or yyvs97 = Void or yyspecial_routines97 = Void then
		if yyvs97 = Void or yyspecial_routines97 = Void then
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
	yyspecial_routines97.force (yyvs97, yyval97, yyvsp97)
end
		end

	yy_do_action_57
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines97 /= Void
			yyvs97 /= Void
		local
			yyval97: detachable EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs97.item (yyvsp97) as l_list then
					if l_list.is_empty then
						yyval97 := Void
					else
						yyval97 := l_list
					end
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyspecial_routines97.force (yyvs97, yyval97, yyvsp97)
end
		end

	yy_do_action_58
			--|#line <not available> "eiffel.y"
		local
			yyval97: detachable EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval97 := ast_factory.new_eiffel_list_feature_clause_as (counter_value + 1)
				if attached yyval97 as l_list and then attached yyvs52.item (yyvsp52) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp97 := yyvsp97 + 1
	yyvsp52 := yyvsp52 -1
	if yyvsp97 >= yyvsc97 or yyvs97 = Void or yyspecial_routines97 = Void then
		if yyvs97 = Void or yyspecial_routines97 = Void then
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
	yyspecial_routines97.force (yyvs97, yyval97, yyvsp97)
end
		end

	yy_do_action_59
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines97 /= Void
			yyvs97 /= Void
		local
			yyval97: detachable EIFFEL_LIST [FEATURE_CLAUSE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval97 := yyvs97.item (yyvsp97)
				if attached yyval97 as l_list and then attached yyvs52.item (yyvsp52) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp52 := yyvsp52 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines97.force (yyvs97, yyval97, yyvsp97)
end
		end

	yy_do_action_60
			--|#line <not available> "eiffel.y"
		local
			yyval52: detachable FEATURE_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval52 := ast_factory.new_feature_clause_as (yyvs38.item (yyvsp38),
				ast_factory.new_eiffel_list_feature_as (0), fclause_pos, feature_clause_end_position) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp52 := yyvsp52 + 1
	yyvsp38 := yyvsp38 -1
	yyvsp1 := yyvsp1 -1
	if yyvsp52 >= yyvsc52 or yyvs52 = Void or yyspecial_routines52 = Void then
		if yyvs52 = Void or yyspecial_routines52 = Void then
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
	yyspecial_routines52.force (yyvs52, yyval52, yyvsp52)
end
		end

	yy_do_action_61
			--|#line <not available> "eiffel.y"
		local
			yyval52: detachable FEATURE_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval52 := ast_factory.new_feature_clause_as (yyvs38.item (yyvsp38), yyvs96.item (yyvsp96), fclause_pos, feature_clause_end_position) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp52 := yyvsp52 + 1
	yyvsp38 := yyvsp38 -1
	yyvsp1 := yyvsp1 -3
	yyvsp96 := yyvsp96 -1
	if yyvsp52 >= yyvsc52 or yyvs52 = Void or yyspecial_routines52 = Void then
		if yyvs52 = Void or yyspecial_routines52 = Void then
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
	yyspecial_routines52.force (yyvs52, yyval52, yyvsp52)
end
		end

	yy_do_action_62
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines38 /= Void
			yyvs38 /= Void
		local
			yyval38: detachable CLIENT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval38 := yyvs38.item (yyvsp38) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp38 := yyvsp38 -1
	yyvsp12 := yyvsp12 -1
	yyspecial_routines38.force (yyvs38, yyval38, yyvsp38)
end
		end

	yy_do_action_63
			--|#line <not available> "eiffel.y"
		local
			yyval38: detachable CLIENT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs12.item (yyvsp12) as l_keyword then
						-- Originally, it was 8, I changed it to 7, delete the following line when fully tested. (Jason)
					l_keyword.set_position (line, column, position, 7)
					fclause_pos := l_keyword
				else
						-- Originally, it was 8, I changed it to 7 (Jason)
					fclause_pos := ast_factory.new_feature_keyword_as (line, column, position, 7, Current)
				end
				
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp38 := yyvsp38 + 1
	if yyvsp38 >= yyvsc38 or yyvs38 = Void or yyspecial_routines38 = Void then
		if yyvs38 = Void or yyspecial_routines38 = Void then
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
	yyspecial_routines38.force (yyvs38, yyval38, yyvsp38)
end
		end

	yy_do_action_64
			--|#line <not available> "eiffel.y"
		local
			yyval38: detachable CLIENT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp38 := yyvsp38 + 1
	if yyvsp38 >= yyvsc38 or yyvs38 = Void or yyspecial_routines38 = Void then
		if yyvs38 = Void or yyspecial_routines38 = Void then
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
	yyspecial_routines38.force (yyvs38, yyval38, yyvsp38)
end
		end

	yy_do_action_65
			--|#line <not available> "eiffel.y"
		local
			yyval38: detachable CLIENT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval38 := ast_factory.new_client_as (yyvs104.item (yyvsp104)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp38 := yyvsp38 + 1
	yyvsp104 := yyvsp104 -1
	if yyvsp38 >= yyvsc38 or yyvs38 = Void or yyspecial_routines38 = Void then
		if yyvs38 = Void or yyspecial_routines38 = Void then
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
	yyspecial_routines38.force (yyvs38, yyval38, yyvsp38)
end
		end

	yy_do_action_66
			--|#line <not available> "eiffel.y"
		local
			yyval104: detachable CLASS_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval104 := ast_factory.new_class_list_as (1)
				if attached yyval104 as l_list and then attached new_none_id as l_none_id then
					l_list.reverse_extend (l_none_id)
					l_list.set_lcurly_symbol (yyvs4.item (yyvsp4 - 1))
					l_list.set_rcurly_symbol (yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp104 := yyvsp104 + 1
	yyvsp4 := yyvsp4 -2
	if yyvsp104 >= yyvsc104 or yyvs104 = Void or yyspecial_routines104 = Void then
		if yyvs104 = Void or yyspecial_routines104 = Void then
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
	yyspecial_routines104.force (yyvs104, yyval104, yyvsp104)
end
		end

	yy_do_action_67
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines104 /= Void
			yyvs104 /= Void
		local
			yyval104: detachable CLASS_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs104.item (yyvsp104) as l_list then
					yyval104 := l_list
					l_list.set_lcurly_symbol (yyvs4.item (yyvsp4 - 1))
					l_list.set_rcurly_symbol (yyvs4.item (yyvsp4))
				end				
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp4 := yyvsp4 -2
	yyvsp1 := yyvsp1 -2
	yyspecial_routines104.force (yyvs104, yyval104, yyvsp104)
end
		end

	yy_do_action_68
			--|#line <not available> "eiffel.y"
		local
			yyval104: detachable CLASS_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval104 := ast_factory.new_class_list_as (counter_value + 1)
				if attached yyval104 as l_list and then attached yyvs2.item (yyvsp2) as l_val then
					l_list.reverse_extend (l_val)
					suppliers.insert_light_supplier_id (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp104 := yyvsp104 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp104 >= yyvsc104 or yyvs104 = Void or yyspecial_routines104 = Void then
		if yyvs104 = Void or yyspecial_routines104 = Void then
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
	yyspecial_routines104.force (yyvs104, yyval104, yyvsp104)
end
		end

	yy_do_action_69
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines104 /= Void
			yyvs104 /= Void
		local
			yyval104: detachable CLASS_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval104 := yyvs104.item (yyvsp104)
				if attached yyval104 as l_list and then attached yyvs2.item (yyvsp2) as l_val then
					l_list.reverse_extend (l_val)
					suppliers.insert_light_supplier_id (l_val)
					ast_factory.reverse_extend_separator (l_list, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines104.force (yyvs104, yyval104, yyvsp104)
end
		end

	yy_do_action_70
			--|#line <not available> "eiffel.y"
		local
			yyval96: detachable EIFFEL_LIST [FEATURE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval96 := ast_factory.new_eiffel_list_feature_as (counter_value + 1)
				if attached yyval96 as l_list and then attached yyvs51.item (yyvsp51) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp96 := yyvsp96 + 1
	yyvsp51 := yyvsp51 -1
	if yyvsp96 >= yyvsc96 or yyvs96 = Void or yyspecial_routines96 = Void then
		if yyvs96 = Void or yyspecial_routines96 = Void then
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
	yyspecial_routines96.force (yyvs96, yyval96, yyvsp96)
end
		end

	yy_do_action_71
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines96 /= Void
			yyvs96 /= Void
		local
			yyval96: detachable EIFFEL_LIST [FEATURE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval96 := yyvs96.item (yyvsp96)
				if attached yyval96 as l_list and then attached yyvs51.item (yyvsp51) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp51 := yyvsp51 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines96.force (yyvs96, yyval96, yyvsp96)
end
		end

	yy_do_action_72
			--|#line <not available> "eiffel.y"
		local
			yyval4: detachable SYMBOL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp4 := yyvsp4 + 1
	if yyvsp4 >= yyvsc4 or yyvs4 = Void or yyspecial_routines4 = Void then
		if yyvs4 = Void or yyspecial_routines4 = Void then
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
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
		end

	yy_do_action_73
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines4 /= Void
			yyvs4 /= Void
		local
			yyval4: detachable SYMBOL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval4 := yyvs4.item (yyvsp4) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines4.force (yyvs4, yyval4, yyvsp4)
end
		end

	yy_do_action_74
			--|#line <not available> "eiffel.y"
		local
			yyval51: detachable FEATURE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval51 := ast_factory.new_feature_as (yyvs98.item (yyvsp98), yyvs34.item (yyvsp34), feature_indexes, position)
				if has_syntax_warning then
					if attached feature_indexes as fi and then fi.has_global_once then
						if attached fi.once_status_index_as as fi_tok then
							report_one_warning (
								create {SYNTAX_WARNING}.make (token_line (fi_tok), token_column (fi_tok), filename,
								once "Specifying once_status in indexing note is Obsolete, please use once (%"PROCESS%")."))
						else
							check indexes_has_once_status_index: False end
						end
					end
				end
				if 
					attached (yyval51) as l_feature_as and then 
					attached l_feature_as.once_as as l_once_as
				then
					if l_once_as.has_key_conflict (yyval51) then
						report_one_error (ast_factory.new_vvok1_error (token_line (l_once_as), token_column (l_once_as), filename, yyval51))
					elseif l_once_as.has_invalid_key (yyval51) then
						if attached l_once_as.invalid_key (yyval51) as l_once_invalid_key then
							report_one_error (ast_factory.new_vvok2_error (token_line (l_once_invalid_key), token_column (l_once_invalid_key), filename, yyval51))
						else
							report_one_error (ast_factory.new_vvok2_error (token_line (l_once_as), token_column (l_once_as), filename, yyval51))
						end
					end
				end

				feature_indexes := Void
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp51 := yyvsp51 + 1
	yyvsp1 := yyvsp1 -3
	yyvsp98 := yyvsp98 -1
	yyvsp34 := yyvsp34 -1
	if yyvsp51 >= yyvsc51 or yyvs51 = Void or yyspecial_routines51 = Void then
		if yyvs51 = Void or yyspecial_routines51 = Void then
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
	yyspecial_routines51.force (yyvs51, yyval51, yyvsp51)
end
		end

	yy_do_action_75
			--|#line <not available> "eiffel.y"
		local
			yyval98: detachable EIFFEL_LIST [FEATURE_NAME]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval98 := ast_factory.new_eiffel_list_feature_name (counter_value + 1)
				if attached yyval98 as l_list and then attached yyvs86.item (yyvsp86) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp98 := yyvsp98 + 1
	yyvsp86 := yyvsp86 -1
	if yyvsp98 >= yyvsc98 or yyvs98 = Void or yyspecial_routines98 = Void then
		if yyvs98 = Void or yyspecial_routines98 = Void then
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
	yyspecial_routines98.force (yyvs98, yyval98, yyvsp98)
end
		end

	yy_do_action_76
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines98 /= Void
			yyvs98 /= Void
		local
			yyval98: detachable EIFFEL_LIST [FEATURE_NAME]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval98 := yyvs98.item (yyvsp98)
				if attached yyval98 as l_list and then attached yyvs86.item (yyvsp86) as l_val then
					l_list.reverse_extend (l_val)
					ast_factory.reverse_extend_separator (l_list, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp86 := yyvsp86 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines98.force (yyvs98, yyval98, yyvsp98)
end
		end

	yy_do_action_77
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines86 /= Void
			yyvs86 /= Void
		local
			yyval86: detachable FEATURE_NAME
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval86 := yyvs86.item (yyvsp86) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines86.force (yyvs86, yyval86, yyvsp86)
end
		end

	yy_do_action_78
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines86 /= Void
			yyvs86 /= Void
		local
			yyval86: detachable FEATURE_NAME
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs86.item (yyvsp86) as l_name then
					yyval86 := l_name
					l_name.set_frozen_keyword (yyvs12.item (yyvsp12))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp12 := yyvsp12 -1
	yyspecial_routines86.force (yyvs86, yyval86, yyvsp86)
end
		end

	yy_do_action_79
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines86 /= Void
			yyvs86 /= Void
		local
			yyval86: detachable FEATURE_NAME
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval86 := yyvs86.item (yyvsp86) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines86.force (yyvs86, yyval86, yyvsp86)
end
		end

	yy_do_action_80
			--|#line <not available> "eiffel.y"
		local
			yyval86: detachable FEATURE_NAME
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs17.item (yyvsp17) as l_alias then
					yyval86 := ast_factory.new_feature_name_alias_as (yyvs2.item (yyvsp2), l_alias.alias_name, has_convert_mark, l_alias.alias_keyword, l_alias.convert_keyword)
				else
					yyval86 := ast_factory.new_feature_name_alias_as (yyvs2.item (yyvsp2), Void, has_convert_mark, Void, Void)
				end
				
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp86 := yyvsp86 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp17 := yyvsp17 -1
	if yyvsp86 >= yyvsc86 or yyvs86 = Void or yyspecial_routines86 = Void then
		if yyvs86 = Void or yyspecial_routines86 = Void then
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
	yyspecial_routines86.force (yyvs86, yyval86, yyvsp86)
end
		end

	yy_do_action_81
			--|#line <not available> "eiffel.y"
		local
			yyval86: detachable FEATURE_NAME
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval86 := ast_factory.new_feature_name_id_as (yyvs2.item (yyvsp2)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp86 := yyvsp86 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp86 >= yyvsc86 or yyvs86 = Void or yyspecial_routines86 = Void then
		if yyvs86 = Void or yyspecial_routines86 = Void then
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
	yyspecial_routines86.force (yyvs86, yyval86, yyvsp86)
end
		end

	yy_do_action_82
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines86 /= Void
			yyvs86 /= Void
		local
			yyval86: detachable FEATURE_NAME
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval86 := yyvs86.item (yyvsp86) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines86.force (yyvs86, yyval86, yyvsp86)
end
		end

	yy_do_action_83
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines86 /= Void
			yyvs86 /= Void
		local
			yyval86: detachable FEATURE_NAME
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval86 := yyvs86.item (yyvsp86) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines86.force (yyvs86, yyval86, yyvsp86)
end
		end

	yy_do_action_84
			--|#line <not available> "eiffel.y"
		local
			yyval86: detachable FEATURE_NAME
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval86 := ast_factory.new_infix_as (yyvs16.item (yyvsp16), yyvs12.item (yyvsp12))
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs12.item (yyvsp12)), token_column (yyvs12.item (yyvsp12)), filename,
						once "Use the alias form of the infix routine."))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp86 := yyvsp86 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp86 >= yyvsc86 or yyvs86 = Void or yyspecial_routines86 = Void then
		if yyvs86 = Void or yyspecial_routines86 = Void then
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
	yyspecial_routines86.force (yyvs86, yyval86, yyvsp86)
end
		end

	yy_do_action_85
			--|#line <not available> "eiffel.y"
		local
			yyval86: detachable FEATURE_NAME
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval86 := ast_factory.new_prefix_as (yyvs16.item (yyvsp16), yyvs12.item (yyvsp12))
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs12.item (yyvsp12)), token_column (yyvs12.item (yyvsp12)), filename,
						once "Use the alias form of the prefix routine."))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp86 := yyvsp86 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp86 >= yyvsc86 or yyvs86 = Void or yyspecial_routines86 = Void then
		if yyvs86 = Void or yyspecial_routines86 = Void then
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
	yyspecial_routines86.force (yyvs86, yyval86, yyvsp86)
end
		end

	yy_do_action_86
			--|#line <not available> "eiffel.y"
		local
			yyval17: detachable ALIAS_TRIPLE
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval17 := ast_factory.new_alias_triple (yyvs12.item (yyvsp12 - 1), yyvs16.item (yyvsp16), yyvs12.item (yyvsp12))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp17 := yyvsp17 + 1
	yyvsp12 := yyvsp12 -2
	yyvsp16 := yyvsp16 -1
	if yyvsp17 >= yyvsc17 or yyvs17 = Void or yyspecial_routines17 = Void then
		if yyvs17 = Void or yyspecial_routines17 = Void then
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
	yyspecial_routines17.force (yyvs17, yyval17, yyvsp17)
end
		end

	yy_do_action_87
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines16 /= Void
			yyvs16 /= Void
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_88
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines16 /= Void
			yyvs16 /= Void
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_89
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines16 /= Void
			yyvs16 /= Void
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_90
			--|#line <not available> "eiffel.y"
		local
			yyval12: detachable KEYWORD_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

has_convert_mark := False 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp12 := yyvsp12 + 1
	if yyvsp12 >= yyvsc12 or yyvs12 = Void or yyspecial_routines12 = Void then
		if yyvs12 = Void or yyspecial_routines12 = Void then
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
	yyspecial_routines12.force (yyvs12, yyval12, yyvsp12)
end
		end

	yy_do_action_91
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines12 /= Void
			yyvs12 /= Void
		local
			yyval12: detachable KEYWORD_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

has_convert_mark := True
				yyval12 := yyvs12.item (yyvsp12)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines12.force (yyvs12, yyval12, yyvsp12)
end
		end

	yy_do_action_92
			--|#line <not available> "eiffel.y"
		local
			yyval12: detachable KEYWORD_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval12 := Void 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp12 := yyvsp12 + 1
	if yyvsp12 >= yyvsc12 or yyvs12 = Void or yyspecial_routines12 = Void then
		if yyvs12 = Void or yyspecial_routines12 = Void then
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
	yyspecial_routines12.force (yyvs12, yyval12, yyvsp12)
end
		end

	yy_do_action_93
			--|#line <not available> "eiffel.y"
		local
			yyval12: detachable KEYWORD_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval12 := extract_keyword (yyvs15.item (yyvsp15)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp12 := yyvsp12 + 1
	yyvsp15 := yyvsp15 -1
	if yyvsp12 >= yyvsc12 or yyvs12 = Void or yyspecial_routines12 = Void then
		if yyvs12 = Void or yyspecial_routines12 = Void then
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
	yyspecial_routines12.force (yyvs12, yyval12, yyvsp12)
end
		end

	yy_do_action_94
			--|#line <not available> "eiffel.y"
		local
			yyval34: detachable BODY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Attribute case
				if attached yyvs19.item (yyvsp19) as l_assigner_mark then
					yyval34 := ast_factory.new_body_as (Void, yyvs81.item (yyvsp81), l_assigner_mark.second, Void, yyvs4.item (yyvsp4), Void, l_assigner_mark.first, yyvs105.item (yyvsp105))
				else
					yyval34 := ast_factory.new_body_as (Void, yyvs81.item (yyvsp81), Void, Void, yyvs4.item (yyvsp4), Void, Void, yyvs105.item (yyvsp105))
				end				
				feature_indexes := yyvs105.item (yyvsp105)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp34 := yyvsp34 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp81 := yyvsp81 -1
	yyvsp19 := yyvsp19 -1
	yyvsp105 := yyvsp105 -1
	if yyvsp34 >= yyvsc34 or yyvs34 = Void or yyspecial_routines34 = Void then
		if yyvs34 = Void or yyspecial_routines34 = Void then
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
	yyspecial_routines34.force (yyvs34, yyval34, yyvsp34)
end
		end

	yy_do_action_95
			--|#line <not available> "eiffel.y"
		local
			yyval34: detachable BODY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Constant case
				if attached yyvs19.item (yyvsp19) as l_assigner_mark then
					yyval34 := ast_factory.new_body_as (Void, yyvs81.item (yyvsp81), l_assigner_mark.second, yyvs39.item (yyvsp39), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4), l_assigner_mark.first, yyvs105.item (yyvsp105))
				else
					yyval34 := ast_factory.new_body_as (Void, yyvs81.item (yyvsp81), Void, yyvs39.item (yyvsp39), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4), Void, yyvs105.item (yyvsp105))
				end
				
				feature_indexes := yyvs105.item (yyvsp105)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp34 := yyvsp34 + 1
	yyvsp4 := yyvsp4 -2
	yyvsp81 := yyvsp81 -1
	yyvsp19 := yyvsp19 -1
	yyvsp39 := yyvsp39 -1
	yyvsp105 := yyvsp105 -1
	if yyvsp34 >= yyvsc34 or yyvs34 = Void or yyspecial_routines34 = Void then
		if yyvs34 = Void or yyspecial_routines34 = Void then
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
	yyspecial_routines34.force (yyvs34, yyval34, yyvsp34)
end
		end

	yy_do_action_96
			--|#line <not available> "eiffel.y"
		local
			yyval34: detachable BODY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Constant case
				if attached yyvs19.item (yyvsp19) as l_assigner_mark then
					yyval34 := ast_factory.new_body_as (Void, yyvs81.item (yyvsp81), l_assigner_mark.second, yyvs39.item (yyvsp39), yyvs4.item (yyvsp4), extract_keyword (yyvs15.item (yyvsp15)), l_assigner_mark.first, yyvs105.item (yyvsp105))
				else
					yyval34 := ast_factory.new_body_as (Void, yyvs81.item (yyvsp81), Void, yyvs39.item (yyvsp39), yyvs4.item (yyvsp4), extract_keyword (yyvs15.item (yyvsp15)), Void, yyvs105.item (yyvsp105))
				end
				
				feature_indexes := yyvs105.item (yyvsp105)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp34 := yyvsp34 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp81 := yyvsp81 -1
	yyvsp19 := yyvsp19 -1
	yyvsp15 := yyvsp15 -1
	yyvsp39 := yyvsp39 -1
	yyvsp105 := yyvsp105 -1
	if yyvsp34 >= yyvsc34 or yyvs34 = Void or yyspecial_routines34 = Void then
		if yyvs34 = Void or yyspecial_routines34 = Void then
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
	yyspecial_routines34.force (yyvs34, yyval34, yyvsp34)
end
		end

	yy_do_action_97
			--|#line <not available> "eiffel.y"
		local
			yyval34: detachable BODY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- procedure without arguments		
				yyval34 := ast_factory.new_body_as (Void, Void, Void, yyvs77.item (yyvsp77), Void, yyvs12.item (yyvsp12), Void, yyvs105.item (yyvsp105))
				feature_indexes := yyvs105.item (yyvsp105)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp34 := yyvsp34 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp105 := yyvsp105 -1
	yyvsp77 := yyvsp77 -1
	if yyvsp34 >= yyvsc34 or yyvs34 = Void or yyspecial_routines34 = Void then
		if yyvs34 = Void or yyspecial_routines34 = Void then
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
	yyspecial_routines34.force (yyvs34, yyval34, yyvsp34)
end
		end

	yy_do_action_98
			--|#line <not available> "eiffel.y"
		local
			yyval34: detachable BODY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Function without arguments
				if attached yyvs19.item (yyvsp19) as l_assigner_mark then
					yyval34 := ast_factory.new_body_as (Void, yyvs81.item (yyvsp81), l_assigner_mark.second, yyvs77.item (yyvsp77), yyvs4.item (yyvsp4), extract_keyword (yyvs15.item (yyvsp15)), l_assigner_mark.first, yyvs105.item (yyvsp105))
				else
					yyval34 := ast_factory.new_body_as (Void, yyvs81.item (yyvsp81), Void, yyvs77.item (yyvsp77), yyvs4.item (yyvsp4), extract_keyword (yyvs15.item (yyvsp15)), Void, yyvs105.item (yyvsp105))
				end
				
				feature_indexes := yyvs105.item (yyvsp105)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp34 := yyvsp34 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp81 := yyvsp81 -1
	yyvsp19 := yyvsp19 -1
	yyvsp15 := yyvsp15 -1
	yyvsp105 := yyvsp105 -1
	yyvsp77 := yyvsp77 -1
	if yyvsp34 >= yyvsc34 or yyvs34 = Void or yyspecial_routines34 = Void then
		if yyvs34 = Void or yyspecial_routines34 = Void then
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
	yyspecial_routines34.force (yyvs34, yyval34, yyvsp34)
end
		end

	yy_do_action_99
			--|#line <not available> "eiffel.y"
		local
			yyval34: detachable BODY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Function without arguments
				if attached yyvs19.item (yyvsp19) as l_assigner_mark then
					yyval34 := ast_factory.new_body_as (Void, yyvs81.item (yyvsp81), l_assigner_mark.second, yyvs77.item (yyvsp77), yyvs4.item (yyvsp4), Void, l_assigner_mark.first, yyvs105.item (yyvsp105))
				else
					yyval34 := ast_factory.new_body_as (Void, yyvs81.item (yyvsp81), Void, yyvs77.item (yyvsp77), yyvs4.item (yyvsp4), Void, Void, yyvs105.item (yyvsp105))
				end
				
				feature_indexes := yyvs105.item (yyvsp105)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp34 := yyvsp34 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp81 := yyvsp81 -1
	yyvsp19 := yyvsp19 -1
	yyvsp105 := yyvsp105 -1
	yyvsp77 := yyvsp77 -1
	if yyvsp34 >= yyvsc34 or yyvs34 = Void or yyspecial_routines34 = Void then
		if yyvs34 = Void or yyspecial_routines34 = Void then
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
	yyspecial_routines34.force (yyvs34, yyval34, yyvsp34)
end
		end

	yy_do_action_100
			--|#line <not available> "eiffel.y"
		local
			yyval34: detachable BODY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- procedure with arguments
				yyval34 := ast_factory.new_body_as (yyvs120.item (yyvsp120), Void, Void, yyvs77.item (yyvsp77), Void, yyvs12.item (yyvsp12), Void, yyvs105.item (yyvsp105))
				feature_indexes := yyvs105.item (yyvsp105)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp34 := yyvsp34 + 1
	yyvsp120 := yyvsp120 -1
	yyvsp12 := yyvsp12 -1
	yyvsp105 := yyvsp105 -1
	yyvsp77 := yyvsp77 -1
	if yyvsp34 >= yyvsc34 or yyvs34 = Void or yyspecial_routines34 = Void then
		if yyvs34 = Void or yyspecial_routines34 = Void then
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
	yyspecial_routines34.force (yyvs34, yyval34, yyvsp34)
end
		end

	yy_do_action_101
			--|#line <not available> "eiffel.y"
		local
			yyval34: detachable BODY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Function with arguments
				if attached yyvs19.item (yyvsp19) as l_assigner_mark then
					yyval34 := ast_factory.new_body_as (yyvs120.item (yyvsp120), yyvs81.item (yyvsp81), l_assigner_mark.second, yyvs77.item (yyvsp77), yyvs4.item (yyvsp4), yyvs12.item (yyvsp12), l_assigner_mark.first, yyvs105.item (yyvsp105))
				else
					yyval34 := ast_factory.new_body_as (yyvs120.item (yyvsp120), yyvs81.item (yyvsp81), Void, yyvs77.item (yyvsp77), yyvs4.item (yyvsp4), yyvs12.item (yyvsp12), Void, yyvs105.item (yyvsp105))
				end				
				feature_indexes := yyvs105.item (yyvsp105)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp34 := yyvsp34 + 1
	yyvsp120 := yyvsp120 -1
	yyvsp4 := yyvsp4 -1
	yyvsp81 := yyvsp81 -1
	yyvsp19 := yyvsp19 -1
	yyvsp12 := yyvsp12 -1
	yyvsp105 := yyvsp105 -1
	yyvsp77 := yyvsp77 -1
	if yyvsp34 >= yyvsc34 or yyvs34 = Void or yyspecial_routines34 = Void then
		if yyvs34 = Void or yyspecial_routines34 = Void then
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
	yyspecial_routines34.force (yyvs34, yyval34, yyvsp34)
end
		end

	yy_do_action_102
			--|#line <not available> "eiffel.y"
		local
			yyval19: detachable PAIR [KEYWORD_AS, ID_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval19 := ast_factory.new_assigner_mark_as (Void, Void)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp19 := yyvsp19 + 1
	if yyvsp19 >= yyvsc19 or yyvs19 = Void or yyspecial_routines19 = Void then
		if yyvs19 = Void or yyspecial_routines19 = Void then
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
	yyspecial_routines19.force (yyvs19, yyval19, yyvsp19)
end
		end

	yy_do_action_103
			--|#line <not available> "eiffel.y"
		local
			yyval19: detachable PAIR [KEYWORD_AS, ID_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval19 := ast_factory.new_assigner_mark_as (extract_keyword (yyvs15.item (yyvsp15)), yyvs2.item (yyvsp2))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp19 := yyvsp19 + 1
	yyvsp15 := yyvsp15 -1
	yyvsp2 := yyvsp2 -1
	if yyvsp19 >= yyvsc19 or yyvs19 = Void or yyspecial_routines19 = Void then
		if yyvs19 = Void or yyspecial_routines19 = Void then
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
	yyspecial_routines19.force (yyvs19, yyval19, yyvsp19)
end
		end

	yy_do_action_104
			--|#line <not available> "eiffel.y"
		local
			yyval39: detachable CONSTANT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval39 := ast_factory.new_constant_as (yyvs31.item (yyvsp31)) 
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp39 := yyvsp39 + 1
	yyvsp31 := yyvsp31 -1
	if yyvsp39 >= yyvsc39 or yyvs39 = Void or yyspecial_routines39 = Void then
		if yyvs39 = Void or yyspecial_routines39 = Void then
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
	yyspecial_routines39.force (yyvs39, yyval39, yyvsp39)
end
		end

	yy_do_action_105
			--|#line <not available> "eiffel.y"
		local
			yyval39: detachable CONSTANT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval39 := ast_factory.new_constant_as (yyvs8.item (yyvsp8)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp39 := yyvsp39 + 1
	yyvsp8 := yyvsp8 -1
	if yyvsp39 >= yyvsc39 or yyvs39 = Void or yyspecial_routines39 = Void then
		if yyvs39 = Void or yyspecial_routines39 = Void then
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
	yyspecial_routines39.force (yyvs39, yyval39, yyvsp39)
end
		end

	yy_do_action_106
			--|#line <not available> "eiffel.y"
		local
			yyval111: detachable PARENT_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval111 := Void 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp111 := yyvsp111 + 1
	if yyvsp111 >= yyvsc111 or yyvs111 = Void or yyspecial_routines111 = Void then
		if yyvs111 = Void or yyspecial_routines111 = Void then
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
	yyspecial_routines111.force (yyvs111, yyval111, yyvsp111)
end
		end

	yy_do_action_107
			--|#line <not available> "eiffel.y"
		local
			yyval111: detachable PARENT_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if not conforming_inheritance_flag then
						-- Conforming inheritance
					if has_syntax_warning then
						report_one_warning (
							create {SYNTAX_WARNING}.make (token_line (yyvs12.item (yyvsp12)), token_column (yyvs12.item (yyvsp12)), filename,
							once "Use `inherit ANY' or do not specify an empty inherit clause"))
					end
					yyval111 := ast_factory.new_eiffel_list_parent_as (0)
					if attached yyval111 as l_inheritance then
						l_inheritance.set_inheritance_tokens (yyvs12.item (yyvsp12), Void, Void, Void)
					end
				else
						-- Raise error as conforming inheritance has already been specified
					if non_conforming_inheritance_flag then
						report_one_error (create {SYNTAX_ERROR}.make (token_line (yyvs12.item (yyvsp12)), token_column (yyvs12.item (yyvsp12)), filename, "Conforming inheritance clause must come before non conforming inheritance clause"))
					else
						report_one_error (create {SYNTAX_ERROR}.make (token_line (yyvs12.item (yyvsp12)), token_column (yyvs12.item (yyvsp12)), filename, "Only one conforming inheritance clause allowed per class"))
					end
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp111 := yyvsp111 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp111 >= yyvsc111 or yyvs111 = Void or yyspecial_routines111 = Void then
		if yyvs111 = Void or yyspecial_routines111 = Void then
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
	yyspecial_routines111.force (yyvs111, yyval111, yyvsp111)
end
		end

	yy_do_action_108
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines111 /= Void
			yyvs111 /= Void
		local
			yyval111: detachable PARENT_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if not conforming_inheritance_flag then
						-- Conforming inheritance
					yyval111 := yyvs111.item (yyvsp111)
					if attached yyval111 as l_inheritance then
						l_inheritance.set_inheritance_tokens (yyvs12.item (yyvsp12), Void, Void, Void)
					end
				else
						-- Raise error as conforming inheritance has already been specified
					if non_conforming_inheritance_flag then
						report_one_error (create {SYNTAX_ERROR}.make (token_line (yyvs12.item (yyvsp12)), token_column (yyvs12.item (yyvsp12)), filename, "Conforming inheritance clause must come before non conforming inheritance clause"))
					else
						report_one_error (create {SYNTAX_ERROR}.make (token_line (yyvs12.item (yyvsp12)), token_column (yyvs12.item (yyvsp12)), filename, "Only one conforming inheritance clause allowed per class"))
					end
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp12 := yyvsp12 -1
	yyvsp1 := yyvsp1 -2
	yyspecial_routines111.force (yyvs111, yyval111, yyvsp111)
end
		end

	yy_do_action_109
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines111 /= Void
			yyvs111 /= Void
		local
			yyval111: detachable PARENT_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval111 := yyvs111.item (yyvsp111)
				if attached yyval111 as l_inheritance then
					l_inheritance.set_inheritance_tokens (yyvs12.item (yyvsp12), yyvs4.item (yyvsp4 - 1), yyvs2.item (yyvsp2), yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 8
	yyvsp111 := yyvsp111 -1
	yyvsp12 := yyvsp12 -1
	yyvsp4 := yyvsp4 -2
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -2
	yyspecial_routines111.force (yyvs111, yyval111, yyvsp111)
end
		end

	yy_do_action_110
			--|#line <not available> "eiffel.y"
		local
			yyval111: detachable PARENT_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Non conforming inheritance
				
				if not non_conforming_inheritance_flag then
						-- Check to make sure Class_identifier is 'NONE'
						-- An error will be thrown if TYPE_AS is not of type NONE_TYPE_AS
					ast_factory.validate_non_conforming_inheritance_type (Current, new_class_type (yyvs2.item (yyvsp2), Void))

						-- Set flag so that no more inheritance clauses can be added as non-conforming is always the last one.
					non_conforming_inheritance_flag := True
				else
						-- Raise error as non conforming inheritance has already been specified
					report_one_error (create {SYNTAX_ERROR}.make (token_line (yyvs12.item (yyvsp12)), token_column (yyvs12.item (yyvsp12)), filename, "Only one non-conforming inheritance clause allowed per class"))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp111 := yyvsp111 + 1
	if yyvsp111 >= yyvsc111 or yyvs111 = Void or yyspecial_routines111 = Void then
		if yyvs111 = Void or yyspecial_routines111 = Void then
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
	yyspecial_routines111.force (yyvs111, yyval111, yyvsp111)
end
		end

	yy_do_action_111
			--|#line <not available> "eiffel.y"
		local
			yyval111: detachable PARENT_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval111 := ast_factory.new_eiffel_list_parent_as (counter_value + 1)
				if attached yyval111 as l_list and then attached yyvs69.item (yyvsp69) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp111 := yyvsp111 + 1
	yyvsp69 := yyvsp69 -1
	if yyvsp111 >= yyvsc111 or yyvs111 = Void or yyspecial_routines111 = Void then
		if yyvs111 = Void or yyspecial_routines111 = Void then
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
	yyspecial_routines111.force (yyvs111, yyval111, yyvsp111)
end
		end

	yy_do_action_112
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines111 /= Void
			yyvs111 /= Void
		local
			yyval111: detachable PARENT_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval111 := yyvs111.item (yyvsp111)
				if attached yyval111 as l_list and then attached yyvs69.item (yyvsp69) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp69 := yyvsp69 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines111.force (yyvs111, yyval111, yyvsp111)
end
		end

	yy_do_action_113
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines69 /= Void
			yyvs69 /= Void
		local
			yyval69: detachable PARENT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval69 := yyvs69.item (yyvsp69) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyspecial_routines69.force (yyvs69, yyval69, yyvsp69)
end
		end

	yy_do_action_114
			--|#line <not available> "eiffel.y"
		local
			yyval83: detachable CLASS_TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval83 := ast_factory.new_class_type_as (yyvs2.item (yyvsp2), yyvs117.item (yyvsp117)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp83 := yyvsp83 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp117 := yyvsp117 -1
	if yyvsp83 >= yyvsc83 or yyvs83 = Void or yyspecial_routines83 = Void then
		if yyvs83 = Void or yyspecial_routines83 = Void then
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
	yyspecial_routines83.force (yyvs83, yyval83, yyvsp83)
end
		end

	yy_do_action_115
			--|#line <not available> "eiffel.y"
		local
			yyval69: detachable PARENT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval69 := ast_factory.new_parent_as (yyvs83.item (yyvsp83), Void, Void, Void, Void, Void, Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp69 := yyvsp69 + 1
	yyvsp83 := yyvsp83 -1
	if yyvsp69 >= yyvsc69 or yyvs69 = Void or yyspecial_routines69 = Void then
		if yyvs69 = Void or yyspecial_routines69 = Void then
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
	yyspecial_routines69.force (yyvs69, yyval69, yyvsp69)
end
		end

	yy_do_action_116
			--|#line <not available> "eiffel.y"
		local
			yyval69: detachable PARENT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval69 := ast_factory.new_parent_as (yyvs83.item (yyvsp83), Void, Void, Void, Void, yyvs102.item (yyvsp102), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp69 := yyvsp69 + 1
	yyvsp83 := yyvsp83 -1
	yyvsp102 := yyvsp102 -1
	yyvsp12 := yyvsp12 -1
	if yyvsp69 >= yyvsc69 or yyvs69 = Void or yyspecial_routines69 = Void then
		if yyvs69 = Void or yyspecial_routines69 = Void then
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
	yyspecial_routines69.force (yyvs69, yyval69, yyvsp69)
end
		end

	yy_do_action_117
			--|#line <not available> "eiffel.y"
		local
			yyval69: detachable PARENT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval69 := ast_factory.new_parent_as (yyvs83.item (yyvsp83), Void, Void, Void, yyvs101.item (yyvsp101), yyvs102.item (yyvsp102), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp69 := yyvsp69 + 1
	yyvsp83 := yyvsp83 -1
	yyvsp101 := yyvsp101 -1
	yyvsp102 := yyvsp102 -1
	yyvsp12 := yyvsp12 -1
	if yyvsp69 >= yyvsc69 or yyvs69 = Void or yyspecial_routines69 = Void then
		if yyvs69 = Void or yyspecial_routines69 = Void then
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
	yyspecial_routines69.force (yyvs69, yyval69, yyvsp69)
end
		end

	yy_do_action_118
			--|#line <not available> "eiffel.y"
		local
			yyval69: detachable PARENT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval69 := ast_factory.new_parent_as (yyvs83.item (yyvsp83), Void, Void, yyvs100.item (yyvsp100), yyvs101.item (yyvsp101), yyvs102.item (yyvsp102), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp69 := yyvsp69 + 1
	yyvsp83 := yyvsp83 -1
	yyvsp100 := yyvsp100 -1
	yyvsp101 := yyvsp101 -1
	yyvsp102 := yyvsp102 -1
	yyvsp12 := yyvsp12 -1
	if yyvsp69 >= yyvsc69 or yyvs69 = Void or yyspecial_routines69 = Void then
		if yyvs69 = Void or yyspecial_routines69 = Void then
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
	yyspecial_routines69.force (yyvs69, yyval69, yyvsp69)
end
		end

	yy_do_action_119
			--|#line <not available> "eiffel.y"
		local
			yyval69: detachable PARENT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval69 := ast_factory.new_parent_as (yyvs83.item (yyvsp83), Void, yyvs93.item (yyvsp93), yyvs100.item (yyvsp100), yyvs101.item (yyvsp101), yyvs102.item (yyvsp102), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp69 := yyvsp69 + 1
	yyvsp83 := yyvsp83 -1
	yyvsp93 := yyvsp93 -1
	yyvsp100 := yyvsp100 -1
	yyvsp101 := yyvsp101 -1
	yyvsp102 := yyvsp102 -1
	yyvsp12 := yyvsp12 -1
	if yyvsp69 >= yyvsc69 or yyvs69 = Void or yyspecial_routines69 = Void then
		if yyvs69 = Void or yyspecial_routines69 = Void then
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
	yyspecial_routines69.force (yyvs69, yyval69, yyvsp69)
end
		end

	yy_do_action_120
			--|#line <not available> "eiffel.y"
		local
			yyval69: detachable PARENT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval69 := ast_factory.new_parent_as (yyvs83.item (yyvsp83), yyvs113.item (yyvsp113), yyvs93.item (yyvsp93), yyvs100.item (yyvsp100), yyvs101.item (yyvsp101), yyvs102.item (yyvsp102), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp69 := yyvsp69 + 1
	yyvsp83 := yyvsp83 -1
	yyvsp113 := yyvsp113 -1
	yyvsp93 := yyvsp93 -1
	yyvsp100 := yyvsp100 -1
	yyvsp101 := yyvsp101 -1
	yyvsp102 := yyvsp102 -1
	yyvsp12 := yyvsp12 -1
	if yyvsp69 >= yyvsc69 or yyvs69 = Void or yyspecial_routines69 = Void then
		if yyvs69 = Void or yyspecial_routines69 = Void then
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
	yyspecial_routines69.force (yyvs69, yyval69, yyvsp69)
end
		end

	yy_do_action_121
			--|#line <not available> "eiffel.y"
		local
			yyval113: detachable RENAME_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval113 := ast_factory.new_rename_clause_as (Void, yyvs12.item (yyvsp12))
				if is_constraint_renaming then
					report_one_error (
						create {SYNTAX_ERROR}.make (token_line (yyvs12.item (yyvsp12)), token_column (yyvs12.item (yyvsp12)), filename,
						"Empty rename clause."))
				else
					report_one_warning (
							create {SYNTAX_WARNING}.make (token_line (yyvs12.item (yyvsp12)), token_column (yyvs12.item (yyvsp12)), filename,
							"Remove empty rename clauses."))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp113 := yyvsp113 + 1
	yyvsp12 := yyvsp12 -1
	if yyvsp113 >= yyvsc113 or yyvs113 = Void or yyspecial_routines113 = Void then
		if yyvs113 = Void or yyspecial_routines113 = Void then
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
	yyspecial_routines113.force (yyvs113, yyval113, yyvsp113)
end
		end

	yy_do_action_122
			--|#line <not available> "eiffel.y"
		local
			yyval113: detachable RENAME_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval113 := ast_factory.new_rename_clause_as (yyvs112.item (yyvsp112), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp113 := yyvsp113 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp1 := yyvsp1 -2
	yyvsp112 := yyvsp112 -1
	if yyvsp113 >= yyvsc113 or yyvs113 = Void or yyspecial_routines113 = Void then
		if yyvs113 = Void or yyspecial_routines113 = Void then
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
	yyspecial_routines113.force (yyvs113, yyval113, yyvsp113)
end
		end

	yy_do_action_123
			--|#line <not available> "eiffel.y"
		local
			yyval112: detachable EIFFEL_LIST [RENAME_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval112 := ast_factory.new_eiffel_list_rename_as (counter_value + 1)
				if attached yyval112 as l_list and then attached yyvs73.item (yyvsp73) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp112 := yyvsp112 + 1
	yyvsp73 := yyvsp73 -1
	if yyvsp112 >= yyvsc112 or yyvs112 = Void or yyspecial_routines112 = Void then
		if yyvs112 = Void or yyspecial_routines112 = Void then
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
	yyspecial_routines112.force (yyvs112, yyval112, yyvsp112)
end
		end

	yy_do_action_124
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines112 /= Void
			yyvs112 /= Void
		local
			yyval112: detachable EIFFEL_LIST [RENAME_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval112 := yyvs112.item (yyvsp112)
				if attached yyval112 as l_list and then attached yyvs73.item (yyvsp73) as l_val then
					l_list.reverse_extend (l_val)
					ast_factory.reverse_extend_separator (l_list, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp73 := yyvsp73 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines112.force (yyvs112, yyval112, yyvsp112)
end
		end

	yy_do_action_125
			--|#line <not available> "eiffel.y"
		local
			yyval73: detachable RENAME_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval73 := ast_factory.new_rename_as (yyvs86.item (yyvsp86 - 1), yyvs86.item (yyvsp86), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp73 := yyvsp73 + 1
	yyvsp86 := yyvsp86 -2
	yyvsp12 := yyvsp12 -1
	if yyvsp73 >= yyvsc73 or yyvs73 = Void or yyspecial_routines73 = Void then
		if yyvs73 = Void or yyspecial_routines73 = Void then
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
	yyspecial_routines73.force (yyvs73, yyval73, yyvsp73)
end
		end

	yy_do_action_126
			--|#line <not available> "eiffel.y"
		local
			yyval93: detachable EXPORT_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp93 := yyvsp93 + 1
	if yyvsp93 >= yyvsc93 or yyvs93 = Void or yyspecial_routines93 = Void then
		if yyvs93 = Void or yyspecial_routines93 = Void then
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
	yyspecial_routines93.force (yyvs93, yyval93, yyvsp93)
end
		end

	yy_do_action_127
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines93 /= Void
			yyvs93 /= Void
		local
			yyval93: detachable EXPORT_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval93 := yyvs93.item (yyvsp93) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines93.force (yyvs93, yyval93, yyvsp93)
end
		end

	yy_do_action_128
			--|#line <not available> "eiffel.y"
		local
			yyval93: detachable EXPORT_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval93 := ast_factory.new_export_clause_as (yyvs92.item (yyvsp92), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp93 := yyvsp93 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp1 := yyvsp1 -2
	yyvsp92 := yyvsp92 -1
	if yyvsp93 >= yyvsc93 or yyvs93 = Void or yyspecial_routines93 = Void then
		if yyvs93 = Void or yyspecial_routines93 = Void then
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
	yyspecial_routines93.force (yyvs93, yyval93, yyvsp93)
end
		end

	yy_do_action_129
			--|#line <not available> "eiffel.y"
		local
			yyval93: detachable EXPORT_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval93 := ast_factory.new_export_clause_as (Void, yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp93 := yyvsp93 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp93 >= yyvsc93 or yyvs93 = Void or yyspecial_routines93 = Void then
		if yyvs93 = Void or yyspecial_routines93 = Void then
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
	yyspecial_routines93.force (yyvs93, yyval93, yyvsp93)
end
		end

	yy_do_action_130
			--|#line <not available> "eiffel.y"
		local
			yyval92: detachable EIFFEL_LIST [EXPORT_ITEM_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval92 := ast_factory.new_eiffel_list_export_item_as (counter_value + 1)
				if attached yyval92 as l_list and then attached yyvs47.item (yyvsp47) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp92 := yyvsp92 + 1
	yyvsp47 := yyvsp47 -1
	if yyvsp92 >= yyvsc92 or yyvs92 = Void or yyspecial_routines92 = Void then
		if yyvs92 = Void or yyspecial_routines92 = Void then
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
	yyspecial_routines92.force (yyvs92, yyval92, yyvsp92)
end
		end

	yy_do_action_131
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines92 /= Void
			yyvs92 /= Void
		local
			yyval92: detachable EIFFEL_LIST [EXPORT_ITEM_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval92 := yyvs92.item (yyvsp92)
				if attached yyval92 as l_list and then attached yyvs47.item (yyvsp47) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp47 := yyvsp47 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines92.force (yyvs92, yyval92, yyvsp92)
end
		end

	yy_do_action_132
			--|#line <not available> "eiffel.y"
		local
			yyval47: detachable EXPORT_ITEM_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					yyval47 := ast_factory.new_export_item_as (ast_factory.new_client_as (yyvs104.item (yyvsp104)), yyvs53.item (yyvsp53))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp47 := yyvsp47 + 1
	yyvsp104 := yyvsp104 -1
	yyvsp53 := yyvsp53 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp47 >= yyvsc47 or yyvs47 = Void or yyspecial_routines47 = Void then
		if yyvs47 = Void or yyspecial_routines47 = Void then
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
	yyspecial_routines47.force (yyvs47, yyval47, yyvsp47)
end
		end

	yy_do_action_133
			--|#line <not available> "eiffel.y"
		local
			yyval53: detachable FEATURE_SET_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp53 := yyvsp53 + 1
	if yyvsp53 >= yyvsc53 or yyvs53 = Void or yyspecial_routines53 = Void then
		if yyvs53 = Void or yyspecial_routines53 = Void then
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
	yyspecial_routines53.force (yyvs53, yyval53, yyvsp53)
end
		end

	yy_do_action_134
			--|#line <not available> "eiffel.y"
		local
			yyval53: detachable FEATURE_SET_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval53 := ast_factory.new_all_as (yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp53 := yyvsp53 + 1
	yyvsp12 := yyvsp12 -1
	if yyvsp53 >= yyvsc53 or yyvs53 = Void or yyspecial_routines53 = Void then
		if yyvs53 = Void or yyspecial_routines53 = Void then
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
	yyspecial_routines53.force (yyvs53, yyval53, yyvsp53)
end
		end

	yy_do_action_135
			--|#line <not available> "eiffel.y"
		local
			yyval53: detachable FEATURE_SET_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval53 := ast_factory.new_feature_list_as (yyvs98.item (yyvsp98)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp53 := yyvsp53 + 1
	yyvsp98 := yyvsp98 -1
	if yyvsp53 >= yyvsc53 or yyvs53 = Void or yyspecial_routines53 = Void then
		if yyvs53 = Void or yyspecial_routines53 = Void then
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
	yyspecial_routines53.force (yyvs53, yyval53, yyvsp53)
end
		end

	yy_do_action_136
			--|#line <not available> "eiffel.y"
		local
			yyval89: detachable CONVERT_FEAT_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp89 := yyvsp89 + 1
	if yyvsp89 >= yyvsc89 or yyvs89 = Void or yyspecial_routines89 = Void then
		if yyvs89 = Void or yyspecial_routines89 = Void then
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
	yyspecial_routines89.force (yyvs89, yyval89, yyvsp89)
end
		end

	yy_do_action_137
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines89 /= Void
			yyvs89 /= Void
		local
			yyval89: detachable CONVERT_FEAT_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			if attached yyvs89.item (yyvsp89) as l_list then
				yyval89 := l_list
				l_list.set_convert_keyword (yyvs12.item (yyvsp12))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp12 := yyvsp12 -1
	yyvsp1 := yyvsp1 -2
	yyspecial_routines89.force (yyvs89, yyval89, yyvsp89)
end
		end

	yy_do_action_138
			--|#line <not available> "eiffel.y"
		local
			yyval89: detachable CONVERT_FEAT_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			yyval89 := ast_factory.new_eiffel_list_convert (counter_value + 1)
			if attached yyval89 as l_list and then attached yyvs40.item (yyvsp40) as l_val then
				l_list.reverse_extend (l_val)
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp89 := yyvsp89 + 1
	yyvsp40 := yyvsp40 -1
	if yyvsp89 >= yyvsc89 or yyvs89 = Void or yyspecial_routines89 = Void then
		if yyvs89 = Void or yyspecial_routines89 = Void then
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
	yyspecial_routines89.force (yyvs89, yyval89, yyvsp89)
end
		end

	yy_do_action_139
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines89 /= Void
			yyvs89 /= Void
		local
			yyval89: detachable CONVERT_FEAT_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			yyval89 := yyvs89.item (yyvsp89)
			if attached yyval89 as l_list and then attached yyvs40.item (yyvsp40) as l_val then
				l_list.reverse_extend (l_val)
				ast_factory.reverse_extend_separator (l_list, yyvs4.item (yyvsp4))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp40 := yyvsp40 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines89.force (yyvs89, yyval89, yyvsp89)
end
		end

	yy_do_action_140
			--|#line <not available> "eiffel.y"
		local
			yyval40: detachable CONVERT_FEAT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				-- True because this is a conversion feature used as a creation
				-- procedure in current class.
			yyval40 := ast_factory.new_convert_feat_as (True, yyvs86.item (yyvsp86), yyvs117.item (yyvsp117), yyvs4.item (yyvsp4 - 3), yyvs4.item (yyvsp4), Void, yyvs4.item (yyvsp4 - 2), yyvs4.item (yyvsp4 - 1))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp40 := yyvsp40 + 1
	yyvsp86 := yyvsp86 -1
	yyvsp4 := yyvsp4 -4
	yyvsp117 := yyvsp117 -1
	if yyvsp40 >= yyvsc40 or yyvs40 = Void or yyspecial_routines40 = Void then
		if yyvs40 = Void or yyspecial_routines40 = Void then
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
	yyspecial_routines40.force (yyvs40, yyval40, yyvsp40)
end
		end

	yy_do_action_141
			--|#line <not available> "eiffel.y"
		local
			yyval40: detachable CONVERT_FEAT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				-- False because this is not a conversion feature used as a creation
				-- procedure.
			yyval40 := ast_factory.new_convert_feat_as (False, yyvs86.item (yyvsp86), yyvs117.item (yyvsp117), Void, Void, yyvs4.item (yyvsp4 - 2), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp40 := yyvsp40 + 1
	yyvsp86 := yyvsp86 -1
	yyvsp4 := yyvsp4 -3
	yyvsp117 := yyvsp117 -1
	if yyvsp40 >= yyvsc40 or yyvs40 = Void or yyspecial_routines40 = Void then
		if yyvs40 = Void or yyspecial_routines40 = Void then
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
	yyspecial_routines40.force (yyvs40, yyval40, yyvsp40)
end
		end

	yy_do_action_142
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines98 /= Void
			yyvs98 /= Void
		local
			yyval98: detachable EIFFEL_LIST [FEATURE_NAME]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval98 := yyvs98.item (yyvsp98) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyspecial_routines98.force (yyvs98, yyval98, yyvsp98)
end
		end

	yy_do_action_143
			--|#line <not available> "eiffel.y"
		local
			yyval98: detachable EIFFEL_LIST [FEATURE_NAME]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval98 := ast_factory.new_eiffel_list_feature_name (counter_value + 1)
				if attached yyval98 as l_list and then attached yyvs86.item (yyvsp86) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp98 := yyvsp98 + 1
	yyvsp86 := yyvsp86 -1
	if yyvsp98 >= yyvsc98 or yyvs98 = Void or yyspecial_routines98 = Void then
		if yyvs98 = Void or yyspecial_routines98 = Void then
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
	yyspecial_routines98.force (yyvs98, yyval98, yyvsp98)
end
		end

	yy_do_action_144
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines98 /= Void
			yyvs98 /= Void
		local
			yyval98: detachable EIFFEL_LIST [FEATURE_NAME]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval98 := yyvs98.item (yyvsp98)
				if attached yyval98 as l_list and then attached yyvs86.item (yyvsp86) as l_val then
					l_list.reverse_extend (l_val)
					ast_factory.reverse_extend_separator (l_list, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp86 := yyvsp86 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines98.force (yyvs98, yyval98, yyvsp98)
end
		end

	yy_do_action_145
			--|#line <not available> "eiffel.y"
		local
			yyval100: detachable UNDEFINE_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp100 := yyvsp100 + 1
	if yyvsp100 >= yyvsc100 or yyvs100 = Void or yyspecial_routines100 = Void then
		if yyvs100 = Void or yyspecial_routines100 = Void then
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
	yyspecial_routines100.force (yyvs100, yyval100, yyvsp100)
end
		end

	yy_do_action_146
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines100 /= Void
			yyvs100 /= Void
		local
			yyval100: detachable UNDEFINE_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval100 := yyvs100.item (yyvsp100) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines100.force (yyvs100, yyval100, yyvsp100)
end
		end

	yy_do_action_147
			--|#line <not available> "eiffel.y"
		local
			yyval100: detachable UNDEFINE_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval100 := ast_factory.new_undefine_clause_as (Void, yyvs12.item (yyvsp12))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp100 := yyvsp100 + 1
	yyvsp12 := yyvsp12 -1
	if yyvsp100 >= yyvsc100 or yyvs100 = Void or yyspecial_routines100 = Void then
		if yyvs100 = Void or yyspecial_routines100 = Void then
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
	yyspecial_routines100.force (yyvs100, yyval100, yyvsp100)
end
		end

	yy_do_action_148
			--|#line <not available> "eiffel.y"
		local
			yyval100: detachable UNDEFINE_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval100 := ast_factory.new_undefine_clause_as (yyvs98.item (yyvsp98), yyvs12.item (yyvsp12))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp100 := yyvsp100 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp98 := yyvsp98 -1
	if yyvsp100 >= yyvsc100 or yyvs100 = Void or yyspecial_routines100 = Void then
		if yyvs100 = Void or yyspecial_routines100 = Void then
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
	yyspecial_routines100.force (yyvs100, yyval100, yyvsp100)
end
		end

	yy_do_action_149
			--|#line <not available> "eiffel.y"
		local
			yyval101: detachable REDEFINE_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp101 := yyvsp101 + 1
	if yyvsp101 >= yyvsc101 or yyvs101 = Void or yyspecial_routines101 = Void then
		if yyvs101 = Void or yyspecial_routines101 = Void then
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
	yyspecial_routines101.force (yyvs101, yyval101, yyvsp101)
end
		end

	yy_do_action_150
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines101 /= Void
			yyvs101 /= Void
		local
			yyval101: detachable REDEFINE_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval101 := yyvs101.item (yyvsp101) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines101.force (yyvs101, yyval101, yyvsp101)
end
		end

	yy_do_action_151
			--|#line <not available> "eiffel.y"
		local
			yyval101: detachable REDEFINE_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval101 := ast_factory.new_redefine_clause_as (Void, yyvs12.item (yyvsp12))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp101 := yyvsp101 + 1
	yyvsp12 := yyvsp12 -1
	if yyvsp101 >= yyvsc101 or yyvs101 = Void or yyspecial_routines101 = Void then
		if yyvs101 = Void or yyspecial_routines101 = Void then
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
	yyspecial_routines101.force (yyvs101, yyval101, yyvsp101)
end
		end

	yy_do_action_152
			--|#line <not available> "eiffel.y"
		local
			yyval101: detachable REDEFINE_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval101 := ast_factory.new_redefine_clause_as (yyvs98.item (yyvsp98), yyvs12.item (yyvsp12))				
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp101 := yyvsp101 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp98 := yyvsp98 -1
	if yyvsp101 >= yyvsc101 or yyvs101 = Void or yyspecial_routines101 = Void then
		if yyvs101 = Void or yyspecial_routines101 = Void then
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
	yyspecial_routines101.force (yyvs101, yyval101, yyvsp101)
end
		end

	yy_do_action_153
			--|#line <not available> "eiffel.y"
		local
			yyval102: detachable SELECT_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp102 := yyvsp102 + 1
	if yyvsp102 >= yyvsc102 or yyvs102 = Void or yyspecial_routines102 = Void then
		if yyvs102 = Void or yyspecial_routines102 = Void then
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
	yyspecial_routines102.force (yyvs102, yyval102, yyvsp102)
end
		end

	yy_do_action_154
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines102 /= Void
			yyvs102 /= Void
		local
			yyval102: detachable SELECT_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval102 := yyvs102.item (yyvsp102) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines102.force (yyvs102, yyval102, yyvsp102)
end
		end

	yy_do_action_155
			--|#line <not available> "eiffel.y"
		local
			yyval102: detachable SELECT_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if non_conforming_inheritance_flag then
					report_one_error (create {SYNTAX_ERROR}.make (token_line (yyvs12.item (yyvsp12)), token_column (yyvs12.item (yyvsp12)),
						filename, "Non-conforming inheritance may not use select clause"))
				end
				yyval102 := ast_factory.new_select_clause_as (Void, yyvs12.item (yyvsp12))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp102 := yyvsp102 + 1
	yyvsp12 := yyvsp12 -1
	if yyvsp102 >= yyvsc102 or yyvs102 = Void or yyspecial_routines102 = Void then
		if yyvs102 = Void or yyspecial_routines102 = Void then
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
	yyspecial_routines102.force (yyvs102, yyval102, yyvsp102)
end
		end

	yy_do_action_156
			--|#line <not available> "eiffel.y"
		local
			yyval102: detachable SELECT_CLAUSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if non_conforming_inheritance_flag and attached yyvs12.item (yyvsp12) as l_keyword then
					report_one_error (create {SYNTAX_ERROR}.make (token_line (yyvs12.item (yyvsp12)), token_column (yyvs12.item (yyvsp12)),
						filename, "Non-conforming inheritance may not use select clause"))
				end
				yyval102 := ast_factory.new_select_clause_as (yyvs98.item (yyvsp98), yyvs12.item (yyvsp12))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp102 := yyvsp102 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp98 := yyvsp98 -1
	if yyvsp102 >= yyvsc102 or yyvs102 = Void or yyspecial_routines102 = Void then
		if yyvs102 = Void or yyspecial_routines102 = Void then
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
	yyspecial_routines102.force (yyvs102, yyval102, yyvsp102)
end
		end

	yy_do_action_157
			--|#line <not available> "eiffel.y"
		local
			yyval120: detachable FORMAL_ARGU_DEC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval120 := ast_factory.new_formal_argu_dec_list_as (Void, yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp120 := yyvsp120 + 1
	yyvsp4 := yyvsp4 -2
	if yyvsp120 >= yyvsc120 or yyvs120 = Void or yyspecial_routines120 = Void then
		if yyvs120 = Void or yyspecial_routines120 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs120")
			end
			create yyspecial_routines120
			yyvsc120 := yyInitial_yyvs_size
			yyvs120 := yyspecial_routines120.make (yyvsc120)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs120")
			end
			yyvsc120 := yyvsc120 + yyInitial_yyvs_size
			yyvs120 := yyspecial_routines120.resize (yyvs120, yyvsc120)
		end
	end
	yyspecial_routines120.force (yyvs120, yyval120, yyvsp120)
end
		end

	yy_do_action_158
			--|#line <not available> "eiffel.y"
		local
			yyval120: detachable FORMAL_ARGU_DEC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval120 := ast_factory.new_formal_argu_dec_list_as (yyvs118.item (yyvsp118), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp120 := yyvsp120 + 1
	yyvsp4 := yyvsp4 -2
	yyvsp1 := yyvsp1 -2
	yyvsp118 := yyvsp118 -1
	if yyvsp120 >= yyvsc120 or yyvs120 = Void or yyspecial_routines120 = Void then
		if yyvs120 = Void or yyspecial_routines120 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs120")
			end
			create yyspecial_routines120
			yyvsc120 := yyInitial_yyvs_size
			yyvs120 := yyspecial_routines120.make (yyvsc120)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs120")
			end
			yyvsc120 := yyvsc120 + yyInitial_yyvs_size
			yyvs120 := yyspecial_routines120.resize (yyvs120, yyvsc120)
		end
	end
	yyspecial_routines120.force (yyvs120, yyval120, yyvsp120)
end
		end

	yy_do_action_159
			--|#line <not available> "eiffel.y"
		local
			yyval118: detachable TYPE_DEC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval118 := ast_factory.new_eiffel_list_type_dec_as (counter_value + 1)
				if attached yyval118 as l_list and then attached yyvs84.item (yyvsp84) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp118 := yyvsp118 + 1
	yyvsp84 := yyvsp84 -1
	if yyvsp118 >= yyvsc118 or yyvs118 = Void or yyspecial_routines118 = Void then
		if yyvs118 = Void or yyspecial_routines118 = Void then
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
	yyspecial_routines118.force (yyvs118, yyval118, yyvsp118)
end
		end

	yy_do_action_160
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines118 /= Void
			yyvs118 /= Void
		local
			yyval118: detachable TYPE_DEC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval118 := yyvs118.item (yyvsp118)
				if attached yyval118 as l_list and then attached yyvs84.item (yyvsp84) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp84 := yyvsp84 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines118.force (yyvs118, yyval118, yyvsp118)
end
		end

	yy_do_action_161
			--|#line <not available> "eiffel.y"
		local
			yyval84: detachable TYPE_DEC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval84 := ast_factory.new_type_dec_as (yyvs21.item (yyvsp21), yyvs81.item (yyvsp81), yyvs4.item (yyvsp4 - 1)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp84 := yyvsp84 + 1
	yyvsp1 := yyvsp1 -2
	yyvsp21 := yyvsp21 -1
	yyvsp4 := yyvsp4 -2
	yyvsp81 := yyvsp81 -1
	if yyvsp84 >= yyvsc84 or yyvs84 = Void or yyspecial_routines84 = Void then
		if yyvs84 = Void or yyspecial_routines84 = Void then
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
	yyspecial_routines84.force (yyvs84, yyval84, yyvsp84)
end
		end

	yy_do_action_162
			--|#line <not available> "eiffel.y"
		local
			yyval21: detachable IDENTIFIER_LIST
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval21 := ast_factory.new_identifier_list (counter_value + 1)
				if attached yyval21 as l_list and then attached yyvs2.item (yyvsp2) as l_val then
					l_list.reverse_extend (l_val.name_id)
					ast_factory.reverse_extend_identifier (l_list, l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp21 := yyvsp21 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp21 >= yyvsc21 or yyvs21 = Void or yyspecial_routines21 = Void then
		if yyvs21 = Void or yyspecial_routines21 = Void then
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
	yyspecial_routines21.force (yyvs21, yyval21, yyvsp21)
end
		end

	yy_do_action_163
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines21 /= Void
			yyvs21 /= Void
		local
			yyval21: detachable IDENTIFIER_LIST
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval21 := yyvs21.item (yyvsp21)
				if attached yyval21 as l_list and then attached yyvs2.item (yyvsp2) as l_val then
					l_list.reverse_extend (l_val.name_id)
					ast_factory.reverse_extend_identifier (l_list, l_val)
					ast_factory.reverse_extend_identifier_separator (l_list, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines21.force (yyvs21, yyval21, yyvsp21)
end
		end

	yy_do_action_164
			--|#line <not available> "eiffel.y"
		local
			yyval21: detachable IDENTIFIER_LIST
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval21 := ast_factory.new_identifier_list (0) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp21 := yyvsp21 + 1
	if yyvsp21 >= yyvsc21 or yyvs21 = Void or yyspecial_routines21 = Void then
		if yyvs21 = Void or yyspecial_routines21 = Void then
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
	yyspecial_routines21.force (yyvs21, yyval21, yyvsp21)
end
		end

	yy_do_action_165
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines21 /= Void
			yyvs21 /= Void
		local
			yyval21: detachable IDENTIFIER_LIST
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval21 := yyvs21.item (yyvsp21) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyspecial_routines21.force (yyvs21, yyval21, yyvsp21)
end
		end

	yy_do_action_166
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines77 /= Void
			yyvs77 /= Void
		local
			yyval77: detachable ROUTINE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs20.item (yyvsp20) as l_pair then
					temp_string_as1 := l_pair.second
					temp_keyword_as := l_pair.first
				else
					temp_string_as1 := Void
					temp_keyword_as := Void
				end
				if attached yyvs18.item (yyvsp18) as l_rescue then
					yyval77 := ast_factory.new_routine_as (temp_string_as1, yyvs74.item (yyvsp74), yyvs119.item (yyvsp119), yyvs76.item (yyvsp76), yyvs46.item (yyvsp46), l_rescue.second, yyvs12.item (yyvsp12), once_manifest_string_counter_value, fbody_pos, temp_keyword_as, l_rescue.first, object_test_locals)
				else
					yyval77 := ast_factory.new_routine_as (temp_string_as1, yyvs74.item (yyvsp74), yyvs119.item (yyvsp119), yyvs76.item (yyvsp76), yyvs46.item (yyvsp46), Void, yyvs12.item (yyvsp12), once_manifest_string_counter_value, fbody_pos, temp_keyword_as, Void, object_test_locals)
				end
				reset_once_manifest_string_counter
				object_test_locals := Void
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 8
	yyvsp20 := yyvsp20 -1
	yyvsp74 := yyvsp74 -1
	yyvsp119 := yyvsp119 -1
	yyvsp76 := yyvsp76 -1
	yyvsp46 := yyvsp46 -1
	yyvsp18 := yyvsp18 -1
	yyvsp12 := yyvsp12 -1
	yyspecial_routines77.force (yyvs77, yyval77, yyvsp77)
end
		end

	yy_do_action_167
			--|#line <not available> "eiffel.y"
		local
			yyval77: detachable ROUTINE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

set_fbody_pos (position) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp77 := yyvsp77 + 1
	if yyvsp77 >= yyvsc77 or yyvs77 = Void or yyspecial_routines77 = Void then
		if yyvs77 = Void or yyspecial_routines77 = Void then
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
	yyspecial_routines77.force (yyvs77, yyval77, yyvsp77)
end
		end

	yy_do_action_168
			--|#line <not available> "eiffel.y"
		local
			yyval76: detachable ROUT_BODY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval76 := yyvs62.item (yyvsp62) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp76 := yyvsp76 + 1
	yyvsp62 := yyvsp62 -1
	if yyvsp76 >= yyvsc76 or yyvs76 = Void or yyspecial_routines76 = Void then
		if yyvs76 = Void or yyspecial_routines76 = Void then
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
	yyspecial_routines76.force (yyvs76, yyval76, yyvsp76)
end
		end

	yy_do_action_169
			--|#line <not available> "eiffel.y"
		local
			yyval76: detachable ROUT_BODY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval76 := yyvs49.item (yyvsp49) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp76 := yyvsp76 + 1
	yyvsp49 := yyvsp49 -1
	if yyvsp76 >= yyvsc76 or yyvs76 = Void or yyspecial_routines76 = Void then
		if yyvs76 = Void or yyspecial_routines76 = Void then
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
	yyspecial_routines76.force (yyvs76, yyval76, yyvsp76)
end
		end

	yy_do_action_170
			--|#line <not available> "eiffel.y"
		local
			yyval76: detachable ROUT_BODY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval76 := yyvs10.item (yyvsp10) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp76 := yyvsp76 + 1
	yyvsp10 := yyvsp10 -1
	if yyvsp76 >= yyvsc76 or yyvs76 = Void or yyspecial_routines76 = Void then
		if yyvs76 = Void or yyspecial_routines76 = Void then
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
	yyspecial_routines76.force (yyvs76, yyval76, yyvsp76)
end
		end

	yy_do_action_171
			--|#line <not available> "eiffel.y"
		local
			yyval49: detachable EXTERNAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs50.item (yyvsp50) as l_language and then l_language.is_built_in then
					if attached yyvs20.item (yyvsp20) as l_name then 
						yyval49 := ast_factory.new_built_in_as (l_language, l_name.second, yyvs12.item (yyvsp12), l_name.first)
					else
						yyval49 := ast_factory.new_built_in_as (l_language, Void, yyvs12.item (yyvsp12), Void)
					end
				elseif attached yyvs20.item (yyvsp20) as l_name then
					yyval49 := ast_factory.new_external_as (yyvs50.item (yyvsp50), l_name.second, yyvs12.item (yyvsp12), l_name.first)
				else
					yyval49 := ast_factory.new_external_as (yyvs50.item (yyvsp50), Void, yyvs12.item (yyvsp12), Void)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp49 := yyvsp49 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp50 := yyvsp50 -1
	yyvsp20 := yyvsp20 -1
	if yyvsp49 >= yyvsc49 or yyvs49 = Void or yyspecial_routines49 = Void then
		if yyvs49 = Void or yyspecial_routines49 = Void then
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
	yyspecial_routines49.force (yyvs49, yyval49, yyvsp49)
end
		end

	yy_do_action_172
			--|#line <not available> "eiffel.y"
		local
			yyval50: detachable EXTERNAL_LANG_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval50 := ast_factory.new_external_lang_as (yyvs16.item (yyvsp16)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp50 := yyvsp50 + 1
	yyvsp16 := yyvsp16 -1
	if yyvsp50 >= yyvsc50 or yyvs50 = Void or yyspecial_routines50 = Void then
		if yyvs50 = Void or yyspecial_routines50 = Void then
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
	yyspecial_routines50.force (yyvs50, yyval50, yyvsp50)
end
		end

	yy_do_action_173
			--|#line <not available> "eiffel.y"
		local
			yyval20: detachable PAIR [KEYWORD_AS, STRING_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp20 := yyvsp20 + 1
	if yyvsp20 >= yyvsc20 or yyvs20 = Void or yyspecial_routines20 = Void then
		if yyvs20 = Void or yyspecial_routines20 = Void then
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
	yyspecial_routines20.force (yyvs20, yyval20, yyvsp20)
end
		end

	yy_do_action_174
			--|#line <not available> "eiffel.y"
		local
			yyval20: detachable PAIR [KEYWORD_AS, STRING_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval20 := ast_factory.new_keyword_string_pair (yyvs12.item (yyvsp12), yyvs16.item (yyvsp16))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp20 := yyvsp20 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp20 >= yyvsc20 or yyvs20 = Void or yyspecial_routines20 = Void then
		if yyvs20 = Void or yyspecial_routines20 = Void then
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
	yyspecial_routines20.force (yyvs20, yyval20, yyvsp20)
end
		end

	yy_do_action_175
			--|#line <not available> "eiffel.y"
		local
			yyval62: detachable INTERNAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval62 := ast_factory.new_do_as (yyvs107.item (yyvsp107), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp62 := yyvsp62 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp107 := yyvsp107 -1
	if yyvsp62 >= yyvsc62 or yyvs62 = Void or yyspecial_routines62 = Void then
		if yyvs62 = Void or yyspecial_routines62 = Void then
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
	yyspecial_routines62.force (yyvs62, yyval62, yyvsp62)
end
		end

	yy_do_action_176
			--|#line <not available> "eiffel.y"
		local
			yyval62: detachable INTERNAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval62 := ast_factory.new_once_as (yyvs12.item (yyvsp12), yyvs115.item (yyvsp115), yyvs107.item (yyvsp107)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp62 := yyvsp62 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp115 := yyvsp115 -1
	yyvsp107 := yyvsp107 -1
	if yyvsp62 >= yyvsc62 or yyvs62 = Void or yyspecial_routines62 = Void then
		if yyvs62 = Void or yyspecial_routines62 = Void then
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
	yyspecial_routines62.force (yyvs62, yyval62, yyvsp62)
end
		end

	yy_do_action_177
			--|#line <not available> "eiffel.y"
		local
			yyval62: detachable INTERNAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval62 := ast_factory.new_attribute_as (yyvs107.item (yyvsp107), extract_keyword (yyvs15.item (yyvsp15))) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp62 := yyvsp62 + 1
	yyvsp15 := yyvsp15 -1
	yyvsp107 := yyvsp107 -1
	if yyvsp62 >= yyvsc62 or yyvs62 = Void or yyspecial_routines62 = Void then
		if yyvs62 = Void or yyspecial_routines62 = Void then
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
	yyspecial_routines62.force (yyvs62, yyval62, yyvsp62)
end
		end

	yy_do_action_178
			--|#line <not available> "eiffel.y"
		local
			yyval119: detachable LOCAL_DEC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp119 := yyvsp119 + 1
	if yyvsp119 >= yyvsc119 or yyvs119 = Void or yyspecial_routines119 = Void then
		if yyvs119 = Void or yyspecial_routines119 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs119")
			end
			create yyspecial_routines119
			yyvsc119 := yyInitial_yyvs_size
			yyvs119 := yyspecial_routines119.make (yyvsc119)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs119")
			end
			yyvsc119 := yyvsc119 + yyInitial_yyvs_size
			yyvs119 := yyspecial_routines119.resize (yyvs119, yyvsc119)
		end
	end
	yyspecial_routines119.force (yyvs119, yyval119, yyvsp119)
end
		end

	yy_do_action_179
			--|#line <not available> "eiffel.y"
		local
			yyval119: detachable LOCAL_DEC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval119 := ast_factory.new_local_dec_list_as (ast_factory.new_eiffel_list_type_dec_as (0), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp119 := yyvsp119 + 1
	yyvsp12 := yyvsp12 -1
	if yyvsp119 >= yyvsc119 or yyvs119 = Void or yyspecial_routines119 = Void then
		if yyvs119 = Void or yyspecial_routines119 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs119")
			end
			create yyspecial_routines119
			yyvsc119 := yyInitial_yyvs_size
			yyvs119 := yyspecial_routines119.make (yyvsc119)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs119")
			end
			yyvsc119 := yyvsc119 + yyInitial_yyvs_size
			yyvs119 := yyspecial_routines119.resize (yyvs119, yyvsc119)
		end
	end
	yyspecial_routines119.force (yyvs119, yyval119, yyvsp119)
end
		end

	yy_do_action_180
			--|#line <not available> "eiffel.y"
		local
			yyval119: detachable LOCAL_DEC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval119 := ast_factory.new_local_dec_list_as (yyvs118.item (yyvsp118), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp119 := yyvsp119 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp1 := yyvsp1 -2
	yyvsp118 := yyvsp118 -1
	if yyvsp119 >= yyvsc119 or yyvs119 = Void or yyspecial_routines119 = Void then
		if yyvs119 = Void or yyspecial_routines119 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs119")
			end
			create yyspecial_routines119
			yyvsc119 := yyInitial_yyvs_size
			yyvs119 := yyspecial_routines119.make (yyvsc119)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs119")
			end
			yyvsc119 := yyvsc119 + yyInitial_yyvs_size
			yyvs119 := yyspecial_routines119.resize (yyvs119, yyvsc119)
		end
	end
	yyspecial_routines119.force (yyvs119, yyval119, yyvsp119)
end
		end

	yy_do_action_181
			--|#line <not available> "eiffel.y"
		local
			yyval107: detachable EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp107 := yyvsp107 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp107 >= yyvsc107 or yyvs107 = Void or yyspecial_routines107 = Void then
		if yyvs107 = Void or yyspecial_routines107 = Void then
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
	yyspecial_routines107.force (yyvs107, yyval107, yyvsp107)
end
		end

	yy_do_action_182
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines107 /= Void
			yyvs107 /= Void
		local
			yyval107: detachable EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval107 := yyvs107.item (yyvsp107) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp1 := yyvsp1 -3
	yyspecial_routines107.force (yyvs107, yyval107, yyvsp107)
end
		end

	yy_do_action_183
			--|#line <not available> "eiffel.y"
		local
			yyval107: detachable EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval107 := ast_factory.new_eiffel_list_instruction_as (counter_value + 1)
				if attached yyval107 as l_list and then attached yyvs60.item (yyvsp60) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp107 := yyvsp107 + 1
	yyvsp60 := yyvsp60 -1
	if yyvsp107 >= yyvsc107 or yyvs107 = Void or yyspecial_routines107 = Void then
		if yyvs107 = Void or yyspecial_routines107 = Void then
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
	yyspecial_routines107.force (yyvs107, yyval107, yyvsp107)
end
		end

	yy_do_action_184
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines107 /= Void
			yyvs107 /= Void
		local
			yyval107: detachable EIFFEL_LIST [INSTRUCTION_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval107 := yyvs107.item (yyvsp107)
				if attached yyval107 as l_list and then attached yyvs60.item (yyvsp60) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp60 := yyvsp60 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines107.force (yyvs107, yyval107, yyvsp107)
end
		end

	yy_do_action_185
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines60 /= Void
			yyvs60 /= Void
		local
			yyval60: detachable INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs60.item (yyvsp60) as l_instructions then
					yyval60 := l_instructions
					l_instructions.set_line_pragma (last_line_pragma)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp1 := yyvsp1 -1
	yyspecial_routines60.force (yyvs60, yyval60, yyvsp60)
end
		end

	yy_do_action_186
			--|#line <not available> "eiffel.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp1 := yyvsp1 + 1
	if yyvsp1 >= yyvsc1 or yyvs1 = Void or yyspecial_routines1 = Void then
		if yyvs1 = Void or yyspecial_routines1 = Void then
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
		end

	yy_do_action_187
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines1 /= Void
			yyvs1 /= Void
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyspecial_routines1.force (yyvs1, yyval1, yyvsp1)
end
		end

	yy_do_action_188
			--|#line <not available> "eiffel.y"
		local
			yyval60: detachable INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval60 := yyvs42.item (yyvsp42) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp60 := yyvsp60 + 1
	yyvsp42 := yyvsp42 -1
	if yyvsp60 >= yyvsc60 or yyvs60 = Void or yyspecial_routines60 = Void then
		if yyvs60 = Void or yyspecial_routines60 = Void then
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
	yyspecial_routines60.force (yyvs60, yyval60, yyvsp60)
end
		end

	yy_do_action_189
			--|#line <not available> "eiffel.y"
		local
			yyval60: detachable INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Call production should be used instead,
					-- but this complicates the grammar.
				if has_type then
					report_one_error (create {SYNTAX_ERROR}.make (token_line (yyvs48.item (yyvsp48)), token_column (yyvs48.item (yyvsp48)),
						filename, "Expression cannot be used as an instruction"))
				elseif yyvs48.item (yyvsp48) /= Void then
					yyval60 := new_call_instruction_from_expression (yyvs48.item (yyvsp48))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp60 := yyvsp60 + 1
	yyvsp48 := yyvsp48 -1
	if yyvsp60 >= yyvsc60 or yyvs60 = Void or yyspecial_routines60 = Void then
		if yyvs60 = Void or yyspecial_routines60 = Void then
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
	yyspecial_routines60.force (yyvs60, yyval60, yyvsp60)
end
		end

	yy_do_action_190
			--|#line <not available> "eiffel.y"
		local
			yyval60: detachable INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval60 := yyvs30.item (yyvsp30) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp60 := yyvsp60 + 1
	yyvsp30 := yyvsp30 -1
	if yyvsp60 >= yyvsc60 or yyvs60 = Void or yyspecial_routines60 = Void then
		if yyvs60 = Void or yyspecial_routines60 = Void then
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
	yyspecial_routines60.force (yyvs60, yyval60, yyvsp60)
end
		end

	yy_do_action_191
			--|#line <not available> "eiffel.y"
		local
			yyval60: detachable INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval60 := yyvs29.item (yyvsp29) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp60 := yyvsp60 + 1
	yyvsp29 := yyvsp29 -1
	if yyvsp60 >= yyvsc60 or yyvs60 = Void or yyspecial_routines60 = Void then
		if yyvs60 = Void or yyspecial_routines60 = Void then
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
	yyspecial_routines60.force (yyvs60, yyval60, yyvsp60)
end
		end

	yy_do_action_192
			--|#line <not available> "eiffel.y"
		local
			yyval60: detachable INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval60 := yyvs75.item (yyvsp75) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp60 := yyvsp60 + 1
	yyvsp75 := yyvsp75 -1
	if yyvsp60 >= yyvsc60 or yyvs60 = Void or yyspecial_routines60 = Void then
		if yyvs60 = Void or yyspecial_routines60 = Void then
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
	yyspecial_routines60.force (yyvs60, yyval60, yyvsp60)
end
		end

	yy_do_action_193
			--|#line <not available> "eiffel.y"
		local
			yyval60: detachable INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval60 := yyvs57.item (yyvsp57) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp60 := yyvsp60 + 1
	yyvsp57 := yyvsp57 -1
	if yyvsp60 >= yyvsc60 or yyvs60 = Void or yyspecial_routines60 = Void then
		if yyvs60 = Void or yyspecial_routines60 = Void then
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
	yyspecial_routines60.force (yyvs60, yyval60, yyvsp60)
end
		end

	yy_do_action_194
			--|#line <not available> "eiffel.y"
		local
			yyval60: detachable INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval60 := yyvs66.item (yyvsp66) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp60 := yyvsp60 + 1
	yyvsp66 := yyvsp66 -1
	if yyvsp60 >= yyvsc60 or yyvs60 = Void or yyspecial_routines60 = Void then
		if yyvs60 = Void or yyspecial_routines60 = Void then
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
	yyspecial_routines60.force (yyvs60, yyval60, yyvsp60)
end
		end

	yy_do_action_195
			--|#line <not available> "eiffel.y"
		local
			yyval60: detachable INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval60 := yyvs59.item (yyvsp59) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp60 := yyvsp60 + 1
	yyvsp59 := yyvsp59 -1
	if yyvsp60 >= yyvsc60 or yyvs60 = Void or yyspecial_routines60 = Void then
		if yyvs60 = Void or yyspecial_routines60 = Void then
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
	yyspecial_routines60.force (yyvs60, yyval60, yyvsp60)
end
		end

	yy_do_action_196
			--|#line <not available> "eiffel.y"
		local
			yyval60: detachable INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval60 := yyvs44.item (yyvsp44) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp60 := yyvsp60 + 1
	yyvsp44 := yyvsp44 -1
	if yyvsp60 >= yyvsc60 or yyvs60 = Void or yyspecial_routines60 = Void then
		if yyvs60 = Void or yyspecial_routines60 = Void then
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
	yyspecial_routines60.force (yyvs60, yyval60, yyvsp60)
end
		end

	yy_do_action_197
			--|#line <not available> "eiffel.y"
		local
			yyval60: detachable INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval60 := yyvs37.item (yyvsp37) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp60 := yyvsp60 + 1
	yyvsp37 := yyvsp37 -1
	if yyvsp60 >= yyvsc60 or yyvs60 = Void or yyspecial_routines60 = Void then
		if yyvs60 = Void or yyspecial_routines60 = Void then
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
	yyspecial_routines60.force (yyvs60, yyval60, yyvsp60)
end
		end

	yy_do_action_198
			--|#line <not available> "eiffel.y"
		local
			yyval60: detachable INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval60 := yyvs56.item (yyvsp56) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp60 := yyvsp60 + 1
	yyvsp56 := yyvsp56 -1
	if yyvsp60 >= yyvsc60 or yyvs60 = Void or yyspecial_routines60 = Void then
		if yyvs60 = Void or yyspecial_routines60 = Void then
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
	yyspecial_routines60.force (yyvs60, yyval60, yyvsp60)
end
		end

	yy_do_action_199
			--|#line <not available> "eiffel.y"
		local
			yyval60: detachable INSTRUCTION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval60 := yyvs7.item (yyvsp7) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp60 := yyvsp60 + 1
	yyvsp7 := yyvsp7 -1
	if yyvsp60 >= yyvsc60 or yyvs60 = Void or yyspecial_routines60 = Void then
		if yyvs60 = Void or yyspecial_routines60 = Void then
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
	yyspecial_routines60.force (yyvs60, yyval60, yyvsp60)
end
		end

	yy_do_action_200
			--|#line <not available> "eiffel.y"
		local
			yyval74: detachable REQUIRE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp74 := yyvsp74 + 1
	if yyvsp74 >= yyvsc74 or yyvs74 = Void or yyspecial_routines74 = Void then
		if yyvs74 = Void or yyspecial_routines74 = Void then
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
	yyspecial_routines74.force (yyvs74, yyval74, yyvsp74)
end
		end

	yy_do_action_201
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines74 /= Void
			yyvs74 /= Void
		local
			yyval74: detachable REQUIRE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				set_id_level (Normal_level)
				yyval74 := ast_factory.new_require_as (yyvs116.item (yyvsp116), yyvs12.item (yyvsp12))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp12 := yyvsp12 -1
	yyvsp116 := yyvsp116 -1
	yyspecial_routines74.force (yyvs74, yyval74, yyvsp74)
end
		end

	yy_do_action_202
			--|#line <not available> "eiffel.y"
		local
			yyval74: detachable REQUIRE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

set_id_level (Assert_level) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp74 := yyvsp74 + 1
	if yyvsp74 >= yyvsc74 or yyvs74 = Void or yyspecial_routines74 = Void then
		if yyvs74 = Void or yyspecial_routines74 = Void then
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
	yyspecial_routines74.force (yyvs74, yyval74, yyvsp74)
end
		end

	yy_do_action_203
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines74 /= Void
			yyvs74 /= Void
		local
			yyval74: detachable REQUIRE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				set_id_level (Normal_level)
				yyval74 := ast_factory.new_require_else_as (yyvs116.item (yyvsp116), yyvs12.item (yyvsp12 - 1), yyvs12.item (yyvsp12))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp12 := yyvsp12 -2
	yyvsp116 := yyvsp116 -1
	yyspecial_routines74.force (yyvs74, yyval74, yyvsp74)
end
		end

	yy_do_action_204
			--|#line <not available> "eiffel.y"
		local
			yyval74: detachable REQUIRE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

set_id_level (Assert_level) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp74 := yyvsp74 + 1
	if yyvsp74 >= yyvsc74 or yyvs74 = Void or yyspecial_routines74 = Void then
		if yyvs74 = Void or yyspecial_routines74 = Void then
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
	yyspecial_routines74.force (yyvs74, yyval74, yyvsp74)
end
		end

	yy_do_action_205
			--|#line <not available> "eiffel.y"
		local
			yyval46: detachable ENSURE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp46 := yyvsp46 + 1
	if yyvsp46 >= yyvsc46 or yyvs46 = Void or yyspecial_routines46 = Void then
		if yyvs46 = Void or yyspecial_routines46 = Void then
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
	yyspecial_routines46.force (yyvs46, yyval46, yyvsp46)
end
		end

	yy_do_action_206
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines46 /= Void
			yyvs46 /= Void
		local
			yyval46: detachable ENSURE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				set_id_level (Normal_level)
				yyval46 := ast_factory.new_ensure_as (yyvs116.item (yyvsp116), yyvs12.item (yyvsp12))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp12 := yyvsp12 -1
	yyvsp116 := yyvsp116 -1
	yyspecial_routines46.force (yyvs46, yyval46, yyvsp46)
end
		end

	yy_do_action_207
			--|#line <not available> "eiffel.y"
		local
			yyval46: detachable ENSURE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

set_id_level (Assert_level) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp46 := yyvsp46 + 1
	if yyvsp46 >= yyvsc46 or yyvs46 = Void or yyspecial_routines46 = Void then
		if yyvs46 = Void or yyspecial_routines46 = Void then
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
	yyspecial_routines46.force (yyvs46, yyval46, yyvsp46)
end
		end

	yy_do_action_208
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines46 /= Void
			yyvs46 /= Void
		local
			yyval46: detachable ENSURE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				set_id_level (Normal_level)
				yyval46 := ast_factory.new_ensure_then_as (yyvs116.item (yyvsp116), yyvs12.item (yyvsp12 - 1), yyvs12.item (yyvsp12))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp12 := yyvsp12 -2
	yyvsp116 := yyvsp116 -1
	yyspecial_routines46.force (yyvs46, yyval46, yyvsp46)
end
		end

	yy_do_action_209
			--|#line <not available> "eiffel.y"
		local
			yyval46: detachable ENSURE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

set_id_level (Assert_level) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp46 := yyvsp46 + 1
	if yyvsp46 >= yyvsc46 or yyvs46 = Void or yyspecial_routines46 = Void then
		if yyvs46 = Void or yyspecial_routines46 = Void then
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
	yyspecial_routines46.force (yyvs46, yyval46, yyvsp46)
end
		end

	yy_do_action_210
			--|#line <not available> "eiffel.y"
		local
			yyval116: detachable EIFFEL_LIST [TAGGED_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp116 := yyvsp116 + 1
	if yyvsp116 >= yyvsc116 or yyvs116 = Void or yyspecial_routines116 = Void then
		if yyvs116 = Void or yyspecial_routines116 = Void then
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
	yyspecial_routines116.force (yyvs116, yyval116, yyvsp116)
end
		end

	yy_do_action_211
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines116 /= Void
			yyvs116 /= Void
		local
			yyval116: detachable EIFFEL_LIST [TAGGED_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs116.item (yyvsp116) as l_list then
					if l_list.is_empty then
						yyval116 := Void
					else
						yyval116 := l_list
					end
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyspecial_routines116.force (yyvs116, yyval116, yyvsp116)
end
		end

	yy_do_action_212
			--|#line <not available> "eiffel.y"
		local
			yyval116: detachable EIFFEL_LIST [TAGGED_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Special list treatment here as we do not want Void
					-- element in `Assertion_list'.
				if attached yyvs79.item (yyvsp79) as l_val then
					yyval116 := ast_factory.new_eiffel_list_tagged_as (counter_value + 1)
					if attached yyval116 as l_list then
						l_list.reverse_extend (l_val)
					end
				else
					yyval116 := ast_factory.new_eiffel_list_tagged_as (counter_value)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp116 := yyvsp116 + 1
	yyvsp79 := yyvsp79 -1
	if yyvsp116 >= yyvsc116 or yyvs116 = Void or yyspecial_routines116 = Void then
		if yyvs116 = Void or yyspecial_routines116 = Void then
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
	yyspecial_routines116.force (yyvs116, yyval116, yyvsp116)
end
		end

	yy_do_action_213
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines116 /= Void
			yyvs116 /= Void
		local
			yyval116: detachable EIFFEL_LIST [TAGGED_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval116 := yyvs116.item (yyvsp116)
				if attached yyval116 as l_list and then attached yyvs79.item (yyvsp79) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp116 := yyvsp116 -1
	yyvsp79 := yyvsp79 -1
	yyspecial_routines116.force (yyvs116, yyval116, yyvsp116)
end
		end

	yy_do_action_214
			--|#line <not available> "eiffel.y"
		local
			yyval116: detachable EIFFEL_LIST [TAGGED_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Only increment counter when clause is not Void.
				if yyvs79.item (yyvsp79) /= Void then
					increment_counter
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp116 := yyvsp116 + 1
	if yyvsp116 >= yyvsc116 or yyvs116 = Void or yyspecial_routines116 = Void then
		if yyvs116 = Void or yyspecial_routines116 = Void then
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
	yyspecial_routines116.force (yyvs116, yyval116, yyvsp116)
end
		end

	yy_do_action_215
			--|#line <not available> "eiffel.y"
		local
			yyval79: detachable TAGGED_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval79 := ast_factory.new_tagged_as (Void, yyvs48.item (yyvsp48), Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp79 := yyvsp79 + 1
	yyvsp48 := yyvsp48 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp79 >= yyvsc79 or yyvs79 = Void or yyspecial_routines79 = Void then
		if yyvs79 = Void or yyspecial_routines79 = Void then
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
	yyspecial_routines79.force (yyvs79, yyval79, yyvsp79)
end
		end

	yy_do_action_216
			--|#line <not available> "eiffel.y"
		local
			yyval79: detachable TAGGED_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval79 := ast_factory.new_tagged_as (yyvs2.item (yyvsp2), yyvs48.item (yyvsp48), yyvs4.item (yyvsp4 - 1)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp79 := yyvsp79 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -2
	yyvsp48 := yyvsp48 -1
	if yyvsp79 >= yyvsc79 or yyvs79 = Void or yyspecial_routines79 = Void then
		if yyvs79 = Void or yyspecial_routines79 = Void then
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
	yyspecial_routines79.force (yyvs79, yyval79, yyvsp79)
end
		end

	yy_do_action_217
			--|#line <not available> "eiffel.y"
		local
			yyval79: detachable TAGGED_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			-- Always create an object here for roundtrip parser.
			-- This "fake" assertion will be filtered out later.
			yyval79 := ast_factory.new_tagged_as (yyvs2.item (yyvsp2), Void, yyvs4.item (yyvsp4 - 1))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp79 := yyvsp79 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -2
	if yyvsp79 >= yyvsc79 or yyvs79 = Void or yyspecial_routines79 = Void then
		if yyvs79 = Void or yyspecial_routines79 = Void then
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
	yyspecial_routines79.force (yyvs79, yyval79, yyvsp79)
end
		end

	yy_do_action_218
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines81 /= Void
			yyvs81 /= Void
		local
			yyval81: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval81 := yyvs81.item (yyvsp81) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines81.force (yyvs81, yyval81, yyvsp81)
end
		end

	yy_do_action_219
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines81 /= Void
			yyvs81 /= Void
		local
			yyval81: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval81 := yyvs81.item (yyvsp81) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines81.force (yyvs81, yyval81, yyvsp81)
end
		end

	yy_do_action_220
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines81 /= Void
			yyvs81 /= Void
		local
			yyval81: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval81 := yyvs81.item (yyvsp81) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines81.force (yyvs81, yyval81, yyvsp81)
end
		end

	yy_do_action_221
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines81 /= Void
			yyvs81 /= Void
		local
			yyval81: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval81 := yyvs81.item (yyvsp81) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines81.force (yyvs81, yyval81, yyvsp81)
end
		end

	yy_do_action_222
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines81 /= Void
			yyvs81 /= Void
		local
			yyval81: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval81 := yyvs81.item (yyvsp81) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines81.force (yyvs81, yyval81, yyvsp81)
end
		end

	yy_do_action_223
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines81 /= Void
			yyvs81 /= Void
		local
			yyval81: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval81 := yyvs81.item (yyvsp81)
				if not is_ignoring_attachment_marks and then attached yyval81 as l_type then
					l_type.set_attachment_mark (extract_keyword (yyvs15.item (yyvsp15)), False, True)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp15 := yyvsp15 -1
	yyspecial_routines81.force (yyvs81, yyval81, yyvsp81)
end
		end

	yy_do_action_224
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines81 /= Void
			yyvs81 /= Void
		local
			yyval81: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval81 := yyvs81.item (yyvsp81)
				if not is_ignoring_attachment_marks and then attached yyval81 as l_type then
					l_type.set_attachment_mark (extract_keyword (yyvs15.item (yyvsp15)), True, False)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp15 := yyvsp15 -1
	yyspecial_routines81.force (yyvs81, yyval81, yyvsp81)
end
		end

	yy_do_action_225
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines81 /= Void
			yyvs81 /= Void
		local
			yyval81: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval81 := yyvs81.item (yyvsp81)
				if not is_ignoring_separate_mark and then attached yyval81 as l_type then
					l_type.set_separate_mark (yyvs12.item (yyvsp12))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp12 := yyvsp12 -1
	yyspecial_routines81.force (yyvs81, yyval81, yyvsp81)
end
		end

	yy_do_action_226
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines81 /= Void
			yyvs81 /= Void
		local
			yyval81: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval81 := yyvs81.item (yyvsp81)
				if not is_ignoring_attachment_marks and then attached yyval81 as l_type then
					l_type.set_attachment_mark (extract_keyword (yyvs15.item (yyvsp15)), False, True)
				end
				if not is_ignoring_separate_mark and then attached yyval81 as l_type then
					l_type.set_separate_mark (yyvs12.item (yyvsp12))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp15 := yyvsp15 -1
	yyvsp12 := yyvsp12 -1
	yyspecial_routines81.force (yyvs81, yyval81, yyvsp81)
end
		end

	yy_do_action_227
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines81 /= Void
			yyvs81 /= Void
		local
			yyval81: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval81 := yyvs81.item (yyvsp81)
				if not is_ignoring_attachment_marks and then attached yyval81 as l_type then
					l_type.set_attachment_mark (extract_keyword (yyvs15.item (yyvsp15)), True, False)
				end
				if not is_ignoring_separate_mark and then attached yyval81 as l_type then
					l_type.set_separate_mark (yyvs12.item (yyvsp12))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp15 := yyvsp15 -1
	yyvsp12 := yyvsp12 -1
	yyspecial_routines81.force (yyvs81, yyval81, yyvsp81)
end
		end

	yy_do_action_228
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines81 /= Void
			yyvs81 /= Void
		local
			yyval81: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval81 := yyvs81.item (yyvsp81) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines81.force (yyvs81, yyval81, yyvsp81)
end
		end

	yy_do_action_229
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines81 /= Void
			yyvs81 /= Void
		local
			yyval81: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval81 := yyvs81.item (yyvsp81) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines81.force (yyvs81, yyval81, yyvsp81)
end
		end

	yy_do_action_230
			--|#line <not available> "eiffel.y"
		local
			yyval81: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval81 := new_class_type (yyvs2.item (yyvsp2), yyvs117.item (yyvsp117)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp81 := yyvsp81 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp117 := yyvsp117 -1
	if yyvsp81 >= yyvsc81 or yyvs81 = Void or yyspecial_routines81 = Void then
		if yyvs81 = Void or yyspecial_routines81 = Void then
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
	yyspecial_routines81.force (yyvs81, yyval81, yyvsp81)
end
		end

	yy_do_action_231
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines81 /= Void
			yyvs81 /= Void
		local
			yyval81: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval81 := yyvs81.item (yyvsp81) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines81.force (yyvs81, yyval81, yyvsp81)
end
		end

	yy_do_action_232
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines81 /= Void
			yyvs81 /= Void
		local
			yyval81: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval81 := yyvs81.item (yyvsp81)
				if not is_ignoring_attachment_marks and then attached yyval81 as l_type then
					l_type.set_attachment_mark (extract_keyword (yyvs15.item (yyvsp15)), True, False)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp15 := yyvsp15 -1
	yyspecial_routines81.force (yyvs81, yyval81, yyvsp81)
end
		end

	yy_do_action_233
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines81 /= Void
			yyvs81 /= Void
		local
			yyval81: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval81 := yyvs81.item (yyvsp81)
				if not is_ignoring_attachment_marks and then attached yyval81 as l_type then
					l_type.set_attachment_mark (extract_keyword (yyvs15.item (yyvsp15)), False, True)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp15 := yyvsp15 -1
	yyspecial_routines81.force (yyvs81, yyval81, yyvsp81)
end
		end

	yy_do_action_234
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines81 /= Void
			yyvs81 /= Void
		local
			yyval81: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval81 := yyvs81.item (yyvsp81)
				if not is_ignoring_separate_mark and then attached yyval81 as l_type then
					l_type.set_separate_mark (yyvs12.item (yyvsp12))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp12 := yyvsp12 -1
	yyspecial_routines81.force (yyvs81, yyval81, yyvsp81)
end
		end

	yy_do_action_235
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines81 /= Void
			yyvs81 /= Void
		local
			yyval81: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval81 := yyvs81.item (yyvsp81)
				if not is_ignoring_attachment_marks and then attached yyval81 as l_type then
					l_type.set_attachment_mark (extract_keyword (yyvs15.item (yyvsp15)), True, False)
				end
				if not is_ignoring_separate_mark and then attached yyval81 as l_type then
					l_type.set_separate_mark (yyvs12.item (yyvsp12))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp15 := yyvsp15 -1
	yyvsp12 := yyvsp12 -1
	yyspecial_routines81.force (yyvs81, yyval81, yyvsp81)
end
		end

	yy_do_action_236
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines81 /= Void
			yyvs81 /= Void
		local
			yyval81: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval81 := yyvs81.item (yyvsp81)
				if not is_ignoring_attachment_marks and then attached yyval81 as l_type then
					l_type.set_attachment_mark (extract_keyword (yyvs15.item (yyvsp15)), False, True)
				end
				if not is_ignoring_separate_mark and then attached yyval81 as l_type then
					l_type.set_separate_mark (yyvs12.item (yyvsp12))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp15 := yyvsp15 -1
	yyvsp12 := yyvsp12 -1
	yyspecial_routines81.force (yyvs81, yyval81, yyvsp81)
end
		end

	yy_do_action_237
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines81 /= Void
			yyvs81 /= Void
		local
			yyval81: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval81 := yyvs81.item (yyvsp81) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines81.force (yyvs81, yyval81, yyvsp81)
end
		end

	yy_do_action_238
			--|#line <not available> "eiffel.y"
		local
			yyval81: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval81 := yyvs82.item (yyvsp82) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp81 := yyvsp81 + 1
	yyvsp82 := yyvsp82 -1
	if yyvsp81 >= yyvsc81 or yyvs81 = Void or yyspecial_routines81 = Void then
		if yyvs81 = Void or yyspecial_routines81 = Void then
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
	yyspecial_routines81.force (yyvs81, yyval81, yyvsp81)
end
		end

	yy_do_action_239
			--|#line <not available> "eiffel.y"
		local
			yyval81: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval81 := ast_factory.new_like_id_as (yyvs2.item (yyvsp2), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp81 := yyvsp81 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp2 := yyvsp2 -1
	if yyvsp81 >= yyvsc81 or yyvs81 = Void or yyspecial_routines81 = Void then
		if yyvs81 = Void or yyspecial_routines81 = Void then
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
	yyspecial_routines81.force (yyvs81, yyval81, yyvsp81)
end
		end

	yy_do_action_240
			--|#line <not available> "eiffel.y"
		local
			yyval81: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval81 := ast_factory.new_like_current_as (yyvs9.item (yyvsp9), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp81 := yyvsp81 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp9 := yyvsp9 -1
	if yyvsp81 >= yyvsc81 or yyvs81 = Void or yyspecial_routines81 = Void then
		if yyvs81 = Void or yyspecial_routines81 = Void then
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
	yyspecial_routines81.force (yyvs81, yyval81, yyvsp81)
end
		end

	yy_do_action_241
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable QUALIFIED_ANCHORED_TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval82 := ast_factory.new_qualified_anchored_type (yyvs81.item (yyvsp81), yyvs4.item (yyvsp4), yyvs2.item (yyvsp2)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp82 := yyvsp82 + 1
	yyvsp81 := yyvsp81 -1
	yyvsp4 := yyvsp4 -1
	yyvsp2 := yyvsp2 -1
	if yyvsp82 >= yyvsc82 or yyvs82 = Void or yyspecial_routines82 = Void then
		if yyvs82 = Void or yyspecial_routines82 = Void then
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
	yyspecial_routines82.force (yyvs82, yyval82, yyvsp82)
end
		end

	yy_do_action_242
			--|#line <not available> "eiffel.y"
		local
			yyval82: detachable QUALIFIED_ANCHORED_TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval82 := ast_factory.new_qualified_anchored_type_with_type (yyvs12.item (yyvsp12), yyvs81.item (yyvsp81), yyvs4.item (yyvsp4), yyvs2.item (yyvsp2)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp82 := yyvsp82 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp81 := yyvsp81 -1
	yyvsp4 := yyvsp4 -1
	yyvsp2 := yyvsp2 -1
	if yyvsp82 >= yyvsc82 or yyvs82 = Void or yyspecial_routines82 = Void then
		if yyvs82 = Void or yyspecial_routines82 = Void then
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
	yyspecial_routines82.force (yyvs82, yyval82, yyvsp82)
end
		end

	yy_do_action_243
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines82 /= Void
			yyvs82 /= Void
		local
			yyval82: detachable QUALIFIED_ANCHORED_TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval82 := yyvs82.item (yyvsp82)
				if attached yyval82 as q and attached yyvs2.item (yyvsp2) as l_id then
					q.extend (yyvs4.item (yyvsp4), l_id)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp4 := yyvsp4 -1
	yyvsp2 := yyvsp2 -1
	yyspecial_routines82.force (yyvs82, yyval82, yyvsp82)
end
		end

	yy_do_action_244
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines81 /= Void
			yyvs81 /= Void
		local
			yyval81: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval81 := yyvs81.item (yyvsp81) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines81.force (yyvs81, yyval81, yyvsp81)
end
		end

	yy_do_action_245
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines81 /= Void
			yyvs81 /= Void
		local
			yyval81: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval81 := yyvs81.item (yyvsp81) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines81.force (yyvs81, yyval81, yyvsp81)
end
		end

	yy_do_action_246
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines81 /= Void
			yyvs81 /= Void
		local
			yyval81: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval81 := yyvs81.item (yyvsp81) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines81.force (yyvs81, yyval81, yyvsp81)
end
		end

	yy_do_action_247
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines81 /= Void
			yyvs81 /= Void
		local
			yyval81: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval81 := yyvs81.item (yyvsp81)
				if not is_ignoring_attachment_marks and then attached yyval81 as l_type then
					l_type.set_attachment_mark (yyvs4.item (yyvsp4), True, False)
				end
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs4.item (yyvsp4)), token_column (yyvs4.item (yyvsp4)), filename,
						once "Use the `attached' keyword instead of !."))
				end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyspecial_routines81.force (yyvs81, yyval81, yyvsp81)
end
		end

	yy_do_action_248
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines81 /= Void
			yyvs81 /= Void
		local
			yyval81: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval81 := yyvs81.item (yyvsp81)
				if not is_ignoring_attachment_marks and then attached yyval81 as l_type then
					l_type.set_attachment_mark (yyvs4.item (yyvsp4), False, True)
				end
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs4.item (yyvsp4)), token_column (yyvs4.item (yyvsp4)), filename,
						once "Use the `detachable' keyword instead of ?."))
				end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyspecial_routines81.force (yyvs81, yyval81, yyvsp81)
end
		end

	yy_do_action_249
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines81 /= Void
			yyvs81 /= Void
		local
			yyval81: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval81 := yyvs81.item (yyvsp81)
				ast_factory.set_expanded_class_type (yyval81, True, yyvs12.item (yyvsp12))
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs12.item (yyvsp12)), token_column (yyvs12.item (yyvsp12)), filename,
						once "Make an expanded version of the base class associated with this type."))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp12 := yyvsp12 -1
	yyspecial_routines81.force (yyvs81, yyval81, yyvsp81)
end
		end

	yy_do_action_250
			--|#line <not available> "eiffel.y"
		local
			yyval81: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval81 := new_bits (yyvs61.item (yyvsp61), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp81 := yyvsp81 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp61 := yyvsp61 -1
	if yyvsp81 >= yyvsc81 or yyvs81 = Void or yyspecial_routines81 = Void then
		if yyvs81 = Void or yyspecial_routines81 = Void then
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
	yyspecial_routines81.force (yyvs81, yyval81, yyvsp81)
end
		end

	yy_do_action_251
			--|#line <not available> "eiffel.y"
		local
			yyval81: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval81 := new_bits_symbol (yyvs2.item (yyvsp2), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp81 := yyvsp81 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp2 := yyvsp2 -1
	if yyvsp81 >= yyvsc81 or yyvs81 = Void or yyspecial_routines81 = Void then
		if yyvs81 = Void or yyspecial_routines81 = Void then
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
	yyspecial_routines81.force (yyvs81, yyval81, yyvsp81)
end
		end

	yy_do_action_252
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines81 /= Void
			yyvs81 /= Void
		local
			yyval81: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval81 := yyvs81.item (yyvsp81)
				if not is_ignoring_attachment_marks and then attached yyval81 as l_type then
					l_type.set_attachment_mark (yyvs4.item (yyvsp4), True, False)
				end
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs4.item (yyvsp4)), token_column (yyvs4.item (yyvsp4)), filename,
						once "Use the `attached' keyword instead of !."))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyspecial_routines81.force (yyvs81, yyval81, yyvsp81)
end
		end

	yy_do_action_253
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines81 /= Void
			yyvs81 /= Void
		local
			yyval81: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval81 := yyvs81.item (yyvsp81)
				if not is_ignoring_attachment_marks and then attached yyval81 as l_type then
					l_type.set_attachment_mark (yyvs4.item (yyvsp4), False, True)
				end
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs4.item (yyvsp4)), token_column (yyvs4.item (yyvsp4)), filename,
						once "Use the `detachable' keyword instead of ?."))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyspecial_routines81.force (yyvs81, yyval81, yyvsp81)
end
		end

	yy_do_action_254
			--|#line <not available> "eiffel.y"
		local
			yyval117: detachable TYPE_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp117 := yyvsp117 + 1
	if yyvsp117 >= yyvsc117 or yyvs117 = Void or yyspecial_routines117 = Void then
		if yyvs117 = Void or yyspecial_routines117 = Void then
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
	yyspecial_routines117.force (yyvs117, yyval117, yyvsp117)
end
		end

	yy_do_action_255
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines117 /= Void
			yyvs117 /= Void
		local
			yyval117: detachable TYPE_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval117 := yyvs117.item (yyvsp117)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines117.force (yyvs117, yyval117, yyvsp117)
end
		end

	yy_do_action_256
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines117 /= Void
			yyvs117 /= Void
		local
			yyval117: detachable TYPE_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs117.item (yyvsp117) as l_list then
					yyval117 := l_list
					l_list.set_positions (yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp4 := yyvsp4 -2
	yyspecial_routines117.force (yyvs117, yyval117, yyvsp117)
end
		end

	yy_do_action_257
			--|#line <not available> "eiffel.y"
		local
			yyval117: detachable TYPE_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached ast_factory.new_eiffel_list_type (0) as l_list then
					yyval117 := l_list
					l_list.set_positions (yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4))
				end	
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp117 := yyvsp117 + 1
	yyvsp4 := yyvsp4 -2
	if yyvsp117 >= yyvsc117 or yyvs117 = Void or yyspecial_routines117 = Void then
		if yyvs117 = Void or yyspecial_routines117 = Void then
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
	yyspecial_routines117.force (yyvs117, yyval117, yyvsp117)
end
		end

	yy_do_action_258
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines117 /= Void
			yyvs117 /= Void
		local
			yyval117: detachable TYPE_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval117 := yyvs117.item (yyvsp117) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyspecial_routines117.force (yyvs117, yyval117, yyvsp117)
end
		end

	yy_do_action_259
			--|#line <not available> "eiffel.y"
		local
			yyval117: detachable TYPE_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval117 := ast_factory.new_eiffel_list_type (counter_value + 1)
				if attached yyval117 as l_list and then attached yyvs81.item (yyvsp81) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp117 := yyvsp117 + 1
	yyvsp81 := yyvsp81 -1
	if yyvsp117 >= yyvsc117 or yyvs117 = Void or yyspecial_routines117 = Void then
		if yyvs117 = Void or yyspecial_routines117 = Void then
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
	yyspecial_routines117.force (yyvs117, yyval117, yyvsp117)
end
		end

	yy_do_action_260
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines117 /= Void
			yyvs117 /= Void
		local
			yyval117: detachable TYPE_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval117 := yyvs117.item (yyvsp117)
				if attached yyval117 as l_list and then attached yyvs81.item (yyvsp81) as l_val then
					l_list.reverse_extend (l_val)
					ast_factory.reverse_extend_separator (l_list, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp81 := yyvsp81 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines117.force (yyvs117, yyval117, yyvsp117)
end
		end

	yy_do_action_261
			--|#line <not available> "eiffel.y"
		local
			yyval81: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval81 := ast_factory.new_class_type_as (yyvs2.item (yyvsp2), Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp81 := yyvsp81 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp81 >= yyvsc81 or yyvs81 = Void or yyspecial_routines81 = Void then
		if yyvs81 = Void or yyspecial_routines81 = Void then
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
	yyspecial_routines81.force (yyvs81, yyval81, yyvsp81)
end
		end

	yy_do_action_262
			--|#line <not available> "eiffel.y"
		local
			yyval81: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached ast_factory.new_eiffel_list_type (0) as l_type_list then
					l_type_list.set_positions (yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4))
					yyval81 := ast_factory.new_class_type_as (yyvs2.item (yyvsp2), l_type_list)
				else
					yyval81 := ast_factory.new_class_type_as (yyvs2.item (yyvsp2), Void)
				end
				remove_counter
				remove_counter2
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp81 := yyvsp81 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -2
	yyvsp4 := yyvsp4 -2
	if yyvsp81 >= yyvsc81 or yyvs81 = Void or yyspecial_routines81 = Void then
		if yyvs81 = Void or yyspecial_routines81 = Void then
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
	yyspecial_routines81.force (yyvs81, yyval81, yyvsp81)
end
		end

	yy_do_action_263
			--|#line <not available> "eiffel.y"
		local
			yyval81: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs117.item (yyvsp117) as l_list then
					l_list.set_positions (yyvs4.item (yyvsp4), last_rsqure.item)
				end
				yyval81 := ast_factory.new_class_type_as (yyvs2.item (yyvsp2), yyvs117.item (yyvsp117))
				last_rsqure.remove
				remove_counter
				remove_counter2
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp81 := yyvsp81 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -2
	yyvsp4 := yyvsp4 -1
	yyvsp117 := yyvsp117 -1
	if yyvsp81 >= yyvsc81 or yyvs81 = Void or yyspecial_routines81 = Void then
		if yyvs81 = Void or yyspecial_routines81 = Void then
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
	yyspecial_routines81.force (yyvs81, yyval81, yyvsp81)
end
		end

	yy_do_action_264
			--|#line <not available> "eiffel.y"
		local
			yyval81: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval81 := ast_factory.new_named_tuple_type_as (
					yyvs2.item (yyvsp2), ast_factory.new_formal_argu_dec_list_as (yyvs118.item (yyvsp118), yyvs4.item (yyvsp4), last_rsqure.item))
				last_rsqure.remove
				remove_counter
				remove_counter2
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp81 := yyvsp81 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp1 := yyvsp1 -2
	yyvsp4 := yyvsp4 -1
	yyvsp118 := yyvsp118 -1
	if yyvsp81 >= yyvsc81 or yyvs81 = Void or yyspecial_routines81 = Void then
		if yyvs81 = Void or yyspecial_routines81 = Void then
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
	yyspecial_routines81.force (yyvs81, yyval81, yyvsp81)
end
		end

	yy_do_action_265
			--|#line <not available> "eiffel.y"
		local
			yyval117: detachable TYPE_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval117 := ast_factory.new_eiffel_list_type (counter_value + 1)
				if attached yyval117 as l_list and then attached yyvs81.item (yyvsp81) as l_val then
					l_list.reverse_extend (l_val)
				end
				last_rsqure.force (yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp117 := yyvsp117 + 1
	yyvsp81 := yyvsp81 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp117 >= yyvsc117 or yyvs117 = Void or yyspecial_routines117 = Void then
		if yyvs117 = Void or yyspecial_routines117 = Void then
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
	yyspecial_routines117.force (yyvs117, yyval117, yyvsp117)
end
		end

	yy_do_action_266
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines117 /= Void
			yyvs117 /= Void
		local
			yyval117: detachable TYPE_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval117 := yyvs117.item (yyvsp117)
				if
					attached yyval117 as l_list and then attached yyvs2.item (yyvsp2) as l_val and then
					attached new_class_type (l_val, Void) as l_class_type
				then
					l_val.to_upper		
					l_list.reverse_extend (l_class_type)
					ast_factory.reverse_extend_separator (l_list, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines117.force (yyvs117, yyval117, yyvsp117)
end
		end

	yy_do_action_267
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines117 /= Void
			yyvs117 /= Void
		local
			yyval117: detachable TYPE_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval117 := yyvs117.item (yyvsp117)
				if attached yyval117 as l_list and then attached yyvs81.item (yyvsp81) as l_val then
					l_list.reverse_extend (l_val)
					ast_factory.reverse_extend_separator (l_list, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp81 := yyvsp81 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines117.force (yyvs117, yyval117, yyvsp117)
end
		end

	yy_do_action_268
			--|#line <not available> "eiffel.y"
		local
			yyval118: detachable TYPE_DEC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval118 := ast_factory.new_eiffel_list_type_dec_as (counter2_value + 1)
				if
					attached yyval118 as l_named_list and then attached yyvs2.item (yyvsp2) as l_name and then
					attached ast_factory.new_identifier_list (counter_value + 1) as l_list and then
					attached ast_factory.new_type_dec_as (l_list, yyvs81.item (yyvsp81), yyvs4.item (yyvsp4 - 1)) as l_type_dec_as
				then
					l_name.to_lower		
					l_list.reverse_extend (l_name.name_id)
					ast_factory.reverse_extend_identifier (l_list, l_name)
					l_named_list.reverse_extend (l_type_dec_as)
				end
				last_rsqure.force (yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp118 := yyvsp118 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -2
	yyvsp81 := yyvsp81 -1
	if yyvsp118 >= yyvsc118 or yyvs118 = Void or yyspecial_routines118 = Void then
		if yyvs118 = Void or yyspecial_routines118 = Void then
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
	yyspecial_routines118.force (yyvs118, yyval118, yyvsp118)
end
		end

	yy_do_action_269
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines118 /= Void
			yyvs118 /= Void
		local
			yyval118: detachable TYPE_DEC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval118 := yyvs118.item (yyvsp118)
				if
					attached yyval118 as l_named_list and then not l_named_list.is_empty and then
					attached yyvs2.item (yyvsp2) as l_name and then
					attached l_named_list.reversed_first.id_list as l_list
				then
					l_name.to_lower		
					l_list.reverse_extend (l_name.name_id)
					ast_factory.reverse_extend_identifier (l_list, l_name)
					ast_factory.reverse_extend_identifier_separator (l_list, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines118.force (yyvs118, yyval118, yyvsp118)
end
		end

	yy_do_action_270
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines118 /= Void
			yyvs118 /= Void
		local
			yyval118: detachable TYPE_DEC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				remove_counter
				yyval118 := yyvs118.item (yyvsp118)
				if
					attached yyval118 as l_named_list and then attached yyvs2.item (yyvsp2) as l_name and then yyvs81.item (yyvsp81) /= Void and then
					attached ast_factory.new_identifier_list (counter_value + 1) as l_list and then
					attached ast_factory.new_type_dec_as (l_list, yyvs81.item (yyvsp81), yyvs4.item (yyvsp4 - 1)) as l_type_dec_as
				then
					l_name.to_lower		
					l_list.reverse_extend (l_name.name_id)
					ast_factory.reverse_extend_identifier (l_list, l_name)
					l_named_list.reverse_extend (l_type_dec_as)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -2
	yyvsp81 := yyvsp81 -1
	yyvsp1 := yyvsp1 -2
	yyspecial_routines118.force (yyvs118, yyval118, yyvsp118)
end
		end

	yy_do_action_271
			--|#line <not available> "eiffel.y"
		local
			yyval103: detachable FORMAL_GENERIC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				-- $$ := Void
				formal_generics_end_position := 0
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp103 := yyvsp103 + 1
	if yyvsp103 >= yyvsc103 or yyvs103 = Void or yyspecial_routines103 = Void then
		if yyvs103 = Void or yyspecial_routines103 = Void then
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
	yyspecial_routines103.force (yyvs103, yyval103, yyvsp103)
end
		end

	yy_do_action_272
			--|#line <not available> "eiffel.y"
		local
			yyval103: detachable FORMAL_GENERIC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				formal_generics_end_position := position
				yyval103 := ast_factory.new_eiffel_list_formal_dec_as (0)
				if attached yyval103 as l_formals then
					l_formals.set_squre_symbols (yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp103 := yyvsp103 + 1
	yyvsp4 := yyvsp4 -2
	if yyvsp103 >= yyvsc103 or yyvs103 = Void or yyspecial_routines103 = Void then
		if yyvs103 = Void or yyspecial_routines103 = Void then
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
	yyspecial_routines103.force (yyvs103, yyval103, yyvsp103)
end
		end

	yy_do_action_273
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines103 /= Void
			yyvs103 /= Void
		local
			yyval103: detachable FORMAL_GENERIC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				formal_generics_end_position := position
				yyval103 := yyvs103.item (yyvsp103)
				if attached yyval103 as l_formals then
					l_formals.transform_class_types_to_formals_and_record_suppliers (ast_factory, suppliers, formal_parameters)
					l_formals.set_squre_symbols (yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp4 := yyvsp4 -2
	yyvsp1 := yyvsp1 -4
	yyspecial_routines103.force (yyvs103, yyval103, yyvsp103)
end
		end

	yy_do_action_274
			--|#line <not available> "eiffel.y"
		local
			yyval103: detachable FORMAL_GENERIC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval103 := ast_factory.new_eiffel_list_formal_dec_as (counter_value + 1)
				if attached yyval103 as l_list and then attached yyvs55.item (yyvsp55) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp103 := yyvsp103 + 1
	yyvsp55 := yyvsp55 -1
	if yyvsp103 >= yyvsc103 or yyvs103 = Void or yyspecial_routines103 = Void then
		if yyvs103 = Void or yyspecial_routines103 = Void then
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
	yyspecial_routines103.force (yyvs103, yyval103, yyvsp103)
end
		end

	yy_do_action_275
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines103 /= Void
			yyvs103 /= Void
		local
			yyval103: detachable FORMAL_GENERIC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval103 := yyvs103.item (yyvsp103)
				if attached yyval103 as l_list and then attached yyvs55.item (yyvsp55) as l_val then
					l_list.reverse_extend (l_val)
					ast_factory.reverse_extend_separator (l_list, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp55 := yyvsp55 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines103.force (yyvs103, yyval103, yyvsp103)
end
		end

	yy_do_action_276
			--|#line <not available> "eiffel.y"
		local
			yyval54: detachable FORMAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs2.item (yyvsp2) as l_id and then {PREDEFINED_NAMES}.none_class_name_id = l_id.name_id then
						-- Trigger an error when constraint is NONE.
						-- Needs to be done manually since current test for
						-- checking that `$2' is not a class name
						-- will fail for NONE, whereas before there were some
						-- syntactic conflict since `NONE' was a keyword and
						-- therefore not part of `TE_ID'.
					raise_error
				else
					yyval54 := ast_factory.new_formal_as (yyvs2.item (yyvsp2), True, False, yyvs12.item (yyvsp12))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp54 := yyvsp54 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp2 := yyvsp2 -1
	if yyvsp54 >= yyvsc54 or yyvs54 = Void or yyspecial_routines54 = Void then
		if yyvs54 = Void or yyspecial_routines54 = Void then
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
	yyspecial_routines54.force (yyvs54, yyval54, yyvsp54)
end
		end

	yy_do_action_277
			--|#line <not available> "eiffel.y"
		local
			yyval54: detachable FORMAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs2.item (yyvsp2) as l_id and then {PREDEFINED_NAMES}.none_class_name_id = l_id.name_id then
						-- Trigger an error when constraint is NONE.
						-- Needs to be done manually since current test for
						-- checking that `$2' is not a class name
						-- will fail for NONE, whereas before there were some
						-- syntactic conflict since `NONE' was a keyword and
						-- therefore not part of `TE_ID'.
					raise_error
				else
					yyval54 := ast_factory.new_formal_as (yyvs2.item (yyvsp2), False, True, yyvs12.item (yyvsp12))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp54 := yyvsp54 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp2 := yyvsp2 -1
	if yyvsp54 >= yyvsc54 or yyvs54 = Void or yyspecial_routines54 = Void then
		if yyvs54 = Void or yyspecial_routines54 = Void then
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
	yyspecial_routines54.force (yyvs54, yyval54, yyvsp54)
end
		end

	yy_do_action_278
			--|#line <not available> "eiffel.y"
		local
			yyval54: detachable FORMAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs2.item (yyvsp2) as l_id and then {PREDEFINED_NAMES}.none_class_name_id = l_id.name_id then
						-- Trigger an error when constraint is NONE.
						-- Needs to be done manually since current test for
						-- checking that `$1' is not a class name
						-- will fail for NONE, whereas before there were some
						-- syntactic conflict since `NONE' was a keyword and
						-- therefore not part of `TE_ID'.
					raise_error
				else
					yyval54 := ast_factory.new_formal_as (yyvs2.item (yyvsp2), False, False, Void)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp54 := yyvsp54 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp54 >= yyvsc54 or yyvs54 = Void or yyspecial_routines54 = Void then
		if yyvs54 = Void or yyspecial_routines54 = Void then
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
	yyspecial_routines54.force (yyvs54, yyval54, yyvsp54)
end
		end

	yy_do_action_279
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines55 /= Void
			yyvs55 /= Void
		local
			yyval55: detachable FORMAL_DEC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs121.item (yyvsp121) as l_constraint then
					if attached l_constraint.creation_constrain as l_creation_constraint then
						yyval55 := ast_factory.new_formal_dec_as (yyvs54.item (yyvsp54), l_constraint.type, l_creation_constraint.feature_list, l_constraint.constrain_symbol, l_creation_constraint.create_keyword, l_creation_constraint.end_keyword)
					else
						yyval55 := ast_factory.new_formal_dec_as (yyvs54.item (yyvsp54), l_constraint.type, Void, l_constraint.constrain_symbol, Void, Void)
					end					
				else
					yyval55 := ast_factory.new_formal_dec_as (yyvs54.item (yyvsp54), Void, Void, Void, Void, Void)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp54 := yyvsp54 -1
	yyvsp121 := yyvsp121 -1
	yyspecial_routines55.force (yyvs55, yyval55, yyvsp55)
end
		end

	yy_do_action_280
			--|#line <not available> "eiffel.y"
		local
			yyval55: detachable FORMAL_DEC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs54.item (yyvsp54) as l_formal then
						-- Needs to be done here, in case current formal is used in
						-- Constraint.
					formal_parameters.extend (l_formal)
					l_formal.set_position (formal_parameters.count)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp55 := yyvsp55 + 1
	if yyvsp55 >= yyvsc55 or yyvs55 = Void or yyspecial_routines55 = Void then
		if yyvs55 = Void or yyspecial_routines55 = Void then
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
	yyspecial_routines55.force (yyvs55, yyval55, yyvsp55)
end
		end

	yy_do_action_281
			--|#line <not available> "eiffel.y"
		local
			yyval121: detachable CONSTRAINT_TRIPLE
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp121 := yyvsp121 + 1
	if yyvsp121 >= yyvsc121 or yyvs121 = Void or yyspecial_routines121 = Void then
		if yyvs121 = Void or yyspecial_routines121 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs121")
			end
			create yyspecial_routines121
			yyvsc121 := yyInitial_yyvs_size
			yyvs121 := yyspecial_routines121.make (yyvsc121)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs121")
			end
			yyvsc121 := yyvsc121 + yyInitial_yyvs_size
			yyvs121 := yyspecial_routines121.resize (yyvs121, yyvsc121)
		end
	end
	yyspecial_routines121.force (yyvs121, yyval121, yyvsp121)
end
		end

	yy_do_action_282
			--|#line <not available> "eiffel.y"
		local
			yyval121: detachable CONSTRAINT_TRIPLE
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- We do not want Void items in this list.
				if
					attached yyvs123.item (yyvsp123) as l_val and then
					attached ast_factory.new_eiffel_list_constraining_type_as (1) as l_list
				then
					l_list.reverse_extend (l_val)
					yyval121 := ast_factory.new_constraint_triple (yyvs4.item (yyvsp4), l_list, yyvs99.item (yyvsp99))
				else
					yyval121 := ast_factory.new_constraint_triple (yyvs4.item (yyvsp4), Void, yyvs99.item (yyvsp99))
				end

			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp121 := yyvsp121 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp123 := yyvsp123 -1
	yyvsp99 := yyvsp99 -1
	if yyvsp121 >= yyvsc121 or yyvs121 = Void or yyspecial_routines121 = Void then
		if yyvs121 = Void or yyspecial_routines121 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs121")
			end
			create yyspecial_routines121
			yyvsc121 := yyInitial_yyvs_size
			yyvs121 := yyspecial_routines121.make (yyvsc121)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs121")
			end
			yyvsc121 := yyvsc121 + yyInitial_yyvs_size
			yyvs121 := yyspecial_routines121.resize (yyvs121, yyvsc121)
		end
	end
	yyspecial_routines121.force (yyvs121, yyval121, yyvsp121)
end
		end

	yy_do_action_283
			--|#line <not available> "eiffel.y"
		local
			yyval121: detachable CONSTRAINT_TRIPLE
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval121 := ast_factory.new_constraint_triple (yyvs4.item (yyvsp4 - 2), yyvs122.item (yyvsp122), yyvs99.item (yyvsp99))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp121 := yyvsp121 + 1
	yyvsp4 := yyvsp4 -3
	yyvsp1 := yyvsp1 -2
	yyvsp122 := yyvsp122 -1
	yyvsp99 := yyvsp99 -1
	if yyvsp121 >= yyvsc121 or yyvs121 = Void or yyspecial_routines121 = Void then
		if yyvs121 = Void or yyspecial_routines121 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs121")
			end
			create yyspecial_routines121
			yyvsc121 := yyInitial_yyvs_size
			yyvs121 := yyspecial_routines121.make (yyvsc121)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs121")
			end
			yyvsc121 := yyvsc121 + yyInitial_yyvs_size
			yyvs121 := yyspecial_routines121.resize (yyvs121, yyvsc121)
		end
	end
	yyspecial_routines121.force (yyvs121, yyval121, yyvsp121)
end
		end

	yy_do_action_284
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines123 /= Void
			yyvs123 /= Void
		local
			yyval123: detachable CONSTRAINING_TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval123 := ast_factory.new_constraining_type (yyvs81.item (yyvsp81), yyvs113.item (yyvsp113), yyvs12.item (yyvsp12))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp123 := yyvsp123 -1
	yyvsp81 := yyvsp81 -1
	yyvsp113 := yyvsp113 -1
	yyvsp12 := yyvsp12 -1
	yyspecial_routines123.force (yyvs123, yyval123, yyvsp123)
end
		end

	yy_do_action_285
			--|#line <not available> "eiffel.y"
		local
			yyval123: detachable CONSTRAINING_TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

is_constraint_renaming := True
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp123 := yyvsp123 + 1
	if yyvsp123 >= yyvsc123 or yyvs123 = Void or yyspecial_routines123 = Void then
		if yyvs123 = Void or yyspecial_routines123 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs123")
			end
			create yyspecial_routines123
			yyvsc123 := yyInitial_yyvs_size
			yyvs123 := yyspecial_routines123.make (yyvsc123)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs123")
			end
			yyvsc123 := yyvsc123 + yyInitial_yyvs_size
			yyvs123 := yyspecial_routines123.resize (yyvs123, yyvsc123)
		end
	end
	yyspecial_routines123.force (yyvs123, yyval123, yyvsp123)
end
		end

	yy_do_action_286
			--|#line <not available> "eiffel.y"
		local
			yyval123: detachable CONSTRAINING_TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

is_constraint_renaming := False
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp123 := yyvsp123 + 1
	if yyvsp123 >= yyvsc123 or yyvs123 = Void or yyspecial_routines123 = Void then
		if yyvs123 = Void or yyspecial_routines123 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs123")
			end
			create yyspecial_routines123
			yyvsc123 := yyInitial_yyvs_size
			yyvs123 := yyspecial_routines123.make (yyvsc123)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs123")
			end
			yyvsc123 := yyvsc123 + yyInitial_yyvs_size
			yyvs123 := yyspecial_routines123.resize (yyvs123, yyvsc123)
		end
	end
	yyspecial_routines123.force (yyvs123, yyval123, yyvsp123)
end
		end

	yy_do_action_287
			--|#line <not available> "eiffel.y"
		local
			yyval123: detachable CONSTRAINING_TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval123 := ast_factory.new_constraining_type (yyvs81.item (yyvsp81), Void, Void)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp123 := yyvsp123 + 1
	yyvsp81 := yyvsp81 -1
	if yyvsp123 >= yyvsc123 or yyvs123 = Void or yyspecial_routines123 = Void then
		if yyvs123 = Void or yyspecial_routines123 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs123")
			end
			create yyspecial_routines123
			yyvsc123 := yyInitial_yyvs_size
			yyvs123 := yyspecial_routines123.make (yyvsc123)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs123")
			end
			yyvsc123 := yyvsc123 + yyInitial_yyvs_size
			yyvs123 := yyspecial_routines123.resize (yyvs123, yyvsc123)
		end
	end
	yyspecial_routines123.force (yyvs123, yyval123, yyvsp123)
end
		end

	yy_do_action_288
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines81 /= Void
			yyvs81 /= Void
		local
			yyval81: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval81 := yyvs81.item (yyvsp81)
				if attached yyvs81.item (yyvsp81) as l_type and then l_type.has_anchor then
					report_one_error (ast_factory.new_vtgc1_error (token_line (l_type), token_column (l_type), filename, l_type))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines81.force (yyvs81, yyval81, yyvsp81)
end
		end

	yy_do_action_289
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines81 /= Void
			yyvs81 /= Void
		local
			yyval81: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval81 := yyvs81.item (yyvsp81)
				if attached yyvs81.item (yyvsp81) as l_type and then l_type.has_anchor then
					report_one_error (ast_factory.new_vtgc1_error (token_line (l_type), token_column (l_type), filename, l_type))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines81.force (yyvs81, yyval81, yyvsp81)
end
		end

	yy_do_action_290
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines81 /= Void
			yyvs81 /= Void
		local
			yyval81: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs81.item (yyvsp81) as l_type then
					report_one_error (ast_factory.new_vtgc1_error (token_line (l_type), token_column (l_type), filename, l_type))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines81.force (yyvs81, yyval81, yyvsp81)
end
		end

	yy_do_action_291
			--|#line <not available> "eiffel.y"
		local
			yyval122: detachable CONSTRAINT_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Special list treatment here as we do not want Void
					-- element in `Assertion_list'.
				if attached yyvs123.item (yyvsp123) as l_val then
					yyval122 := ast_factory.new_eiffel_list_constraining_type_as (counter_value + 1)
					if attached yyval122 as l_list then
						l_list.reverse_extend (l_val)
					end
				else
					yyval122 := ast_factory.new_eiffel_list_constraining_type_as (counter_value)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp122 := yyvsp122 + 1
	yyvsp123 := yyvsp123 -1
	if yyvsp122 >= yyvsc122 or yyvs122 = Void or yyspecial_routines122 = Void then
		if yyvs122 = Void or yyspecial_routines122 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs122")
			end
			create yyspecial_routines122
			yyvsc122 := yyInitial_yyvs_size
			yyvs122 := yyspecial_routines122.make (yyvsc122)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs122")
			end
			yyvsc122 := yyvsc122 + yyInitial_yyvs_size
			yyvs122 := yyspecial_routines122.resize (yyvs122, yyvsc122)
		end
	end
	yyspecial_routines122.force (yyvs122, yyval122, yyvsp122)
end
		end

	yy_do_action_292
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines122 /= Void
			yyvs122 /= Void
		local
			yyval122: detachable CONSTRAINT_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval122 := yyvs122.item (yyvsp122)
				if attached yyval122 as l_list and then attached yyvs123.item (yyvsp123) as l_val then
					l_list.reverse_extend (l_val)
					ast_factory.reverse_extend_separator (l_list, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp122 := yyvsp122 -1
	yyvsp123 := yyvsp123 -1
	yyvsp4 := yyvsp4 -1
	yyspecial_routines122.force (yyvs122, yyval122, yyvsp122)
end
		end

	yy_do_action_293
			--|#line <not available> "eiffel.y"
		local
			yyval122: detachable CONSTRAINT_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Only increment counter when clause is not Void.
				if yyvs123.item (yyvsp123) /= Void then
					increment_counter
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp122 := yyvsp122 + 1
	if yyvsp122 >= yyvsc122 or yyvs122 = Void or yyspecial_routines122 = Void then
		if yyvs122 = Void or yyspecial_routines122 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs122")
			end
			create yyspecial_routines122
			yyvsc122 := yyInitial_yyvs_size
			yyvs122 := yyspecial_routines122.make (yyvsc122)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs122")
			end
			yyvsc122 := yyvsc122 + yyInitial_yyvs_size
			yyvs122 := yyspecial_routines122.resize (yyvs122, yyvsc122)
		end
	end
	yyspecial_routines122.force (yyvs122, yyval122, yyvsp122)
end
		end

	yy_do_action_294
			--|#line <not available> "eiffel.y"
		local
			yyval99: detachable CREATION_CONSTRAIN_TRIPLE
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp99 := yyvsp99 + 1
	if yyvsp99 >= yyvsc99 or yyvs99 = Void or yyspecial_routines99 = Void then
		if yyvs99 = Void or yyspecial_routines99 = Void then
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
	yyspecial_routines99.force (yyvs99, yyval99, yyvsp99)
end
		end

	yy_do_action_295
			--|#line <not available> "eiffel.y"
		local
			yyval99: detachable CREATION_CONSTRAIN_TRIPLE
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval99 := ast_factory.new_creation_constrain_triple (yyvs98.item (yyvsp98), yyvs12.item (yyvsp12 - 1), yyvs12.item (yyvsp12))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp99 := yyvsp99 + 1
	yyvsp12 := yyvsp12 -2
	yyvsp98 := yyvsp98 -1
	if yyvsp99 >= yyvsc99 or yyvs99 = Void or yyspecial_routines99 = Void then
		if yyvs99 = Void or yyspecial_routines99 = Void then
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
	yyspecial_routines99.force (yyvs99, yyval99, yyvsp99)
end
		end

	yy_do_action_296
			--|#line <not available> "eiffel.y"
		local
			yyval57: detachable IF_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval57 := ast_factory.new_if_as (yyvs48.item (yyvsp48), yyvs107.item (yyvsp107), Void, Void, yyvs12.item (yyvsp12), yyvs12.item (yyvsp12 - 2), yyvs12.item (yyvsp12 - 1), Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp57 := yyvsp57 + 1
	yyvsp12 := yyvsp12 -3
	yyvsp48 := yyvsp48 -1
	yyvsp107 := yyvsp107 -1
	if yyvsp57 >= yyvsc57 or yyvs57 = Void or yyspecial_routines57 = Void then
		if yyvs57 = Void or yyspecial_routines57 = Void then
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
	yyspecial_routines57.force (yyvs57, yyval57, yyvsp57)
end
		end

	yy_do_action_297
			--|#line <not available> "eiffel.y"
		local
			yyval57: detachable IF_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval57 := ast_factory.new_if_as (yyvs48.item (yyvsp48), yyvs107.item (yyvsp107 - 1), Void, yyvs107.item (yyvsp107), yyvs12.item (yyvsp12), yyvs12.item (yyvsp12 - 3), yyvs12.item (yyvsp12 - 2), yyvs12.item (yyvsp12 - 1)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp57 := yyvsp57 + 1
	yyvsp12 := yyvsp12 -4
	yyvsp48 := yyvsp48 -1
	yyvsp107 := yyvsp107 -2
	if yyvsp57 >= yyvsc57 or yyvs57 = Void or yyspecial_routines57 = Void then
		if yyvs57 = Void or yyspecial_routines57 = Void then
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
	yyspecial_routines57.force (yyvs57, yyval57, yyvsp57)
end
		end

	yy_do_action_298
			--|#line <not available> "eiffel.y"
		local
			yyval57: detachable IF_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval57 := ast_factory.new_if_as (yyvs48.item (yyvsp48), yyvs107.item (yyvsp107), yyvs91.item (yyvsp91), Void, yyvs12.item (yyvsp12), yyvs12.item (yyvsp12 - 2), yyvs12.item (yyvsp12 - 1), Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp57 := yyvsp57 + 1
	yyvsp12 := yyvsp12 -3
	yyvsp48 := yyvsp48 -1
	yyvsp107 := yyvsp107 -1
	yyvsp91 := yyvsp91 -1
	if yyvsp57 >= yyvsc57 or yyvs57 = Void or yyspecial_routines57 = Void then
		if yyvs57 = Void or yyspecial_routines57 = Void then
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
	yyspecial_routines57.force (yyvs57, yyval57, yyvsp57)
end
		end

	yy_do_action_299
			--|#line <not available> "eiffel.y"
		local
			yyval57: detachable IF_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval57 := ast_factory.new_if_as (yyvs48.item (yyvsp48), yyvs107.item (yyvsp107 - 1), yyvs91.item (yyvsp91), yyvs107.item (yyvsp107), yyvs12.item (yyvsp12), yyvs12.item (yyvsp12 - 3), yyvs12.item (yyvsp12 - 2), yyvs12.item (yyvsp12 - 1)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 8
	yyvsp57 := yyvsp57 + 1
	yyvsp12 := yyvsp12 -4
	yyvsp48 := yyvsp48 -1
	yyvsp107 := yyvsp107 -2
	yyvsp91 := yyvsp91 -1
	if yyvsp57 >= yyvsc57 or yyvs57 = Void or yyspecial_routines57 = Void then
		if yyvs57 = Void or yyspecial_routines57 = Void then
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
	yyspecial_routines57.force (yyvs57, yyval57, yyvsp57)
end
		end

	yy_do_action_300
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines91 /= Void
			yyvs91 /= Void
		local
			yyval91: detachable EIFFEL_LIST [ELSIF_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval91 := yyvs91.item (yyvsp91) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyspecial_routines91.force (yyvs91, yyval91, yyvsp91)
end
		end

	yy_do_action_301
			--|#line <not available> "eiffel.y"
		local
			yyval91: detachable EIFFEL_LIST [ELSIF_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval91 := ast_factory.new_eiffel_list_elseif_as (counter_value + 1)
				if attached yyval91 as l_list and then attached yyvs45.item (yyvsp45) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp91 := yyvsp91 + 1
	yyvsp45 := yyvsp45 -1
	if yyvsp91 >= yyvsc91 or yyvs91 = Void or yyspecial_routines91 = Void then
		if yyvs91 = Void or yyspecial_routines91 = Void then
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
	yyspecial_routines91.force (yyvs91, yyval91, yyvsp91)
end
		end

	yy_do_action_302
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines91 /= Void
			yyvs91 /= Void
		local
			yyval91: detachable EIFFEL_LIST [ELSIF_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval91 := yyvs91.item (yyvsp91)
				if attached yyval91 as l_list and then attached yyvs45.item (yyvsp45) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp45 := yyvsp45 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines91.force (yyvs91, yyval91, yyvsp91)
end
		end

	yy_do_action_303
			--|#line <not available> "eiffel.y"
		local
			yyval45: detachable ELSIF_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval45 := ast_factory.new_elseif_as (yyvs48.item (yyvsp48), yyvs107.item (yyvsp107), yyvs12.item (yyvsp12 - 1), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp45 := yyvsp45 + 1
	yyvsp12 := yyvsp12 -2
	yyvsp48 := yyvsp48 -1
	yyvsp107 := yyvsp107 -1
	if yyvsp45 >= yyvsc45 or yyvs45 = Void or yyspecial_routines45 = Void then
		if yyvs45 = Void or yyspecial_routines45 = Void then
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
	yyspecial_routines45.force (yyvs45, yyval45, yyvsp45)
end
		end

	yy_do_action_304
			--|#line <not available> "eiffel.y"
		local
			yyval59: detachable INSPECT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval59 := ast_factory.new_inspect_as (yyvs48.item (yyvsp48), yyvs88.item (yyvsp88), Void, yyvs12.item (yyvsp12), yyvs12.item (yyvsp12 - 1), Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp59 := yyvsp59 + 1
	yyvsp12 := yyvsp12 -2
	yyvsp48 := yyvsp48 -1
	yyvsp88 := yyvsp88 -1
	if yyvsp59 >= yyvsc59 or yyvs59 = Void or yyspecial_routines59 = Void then
		if yyvs59 = Void or yyspecial_routines59 = Void then
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
	yyspecial_routines59.force (yyvs59, yyval59, yyvsp59)
end
		end

	yy_do_action_305
			--|#line <not available> "eiffel.y"
		local
			yyval59: detachable INSPECT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if yyvs107.item (yyvsp107) /= Void then
					yyval59 := ast_factory.new_inspect_as (yyvs48.item (yyvsp48), yyvs88.item (yyvsp88), yyvs107.item (yyvsp107), yyvs12.item (yyvsp12), yyvs12.item (yyvsp12 - 2), yyvs12.item (yyvsp12 - 1))
				else
					yyval59 := ast_factory.new_inspect_as (yyvs48.item (yyvsp48), yyvs88.item (yyvsp88),
						ast_factory.new_eiffel_list_instruction_as (0), yyvs12.item (yyvsp12), yyvs12.item (yyvsp12 - 2), yyvs12.item (yyvsp12 - 1))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp59 := yyvsp59 + 1
	yyvsp12 := yyvsp12 -3
	yyvsp48 := yyvsp48 -1
	yyvsp88 := yyvsp88 -1
	yyvsp107 := yyvsp107 -1
	if yyvsp59 >= yyvsc59 or yyvs59 = Void or yyspecial_routines59 = Void then
		if yyvs59 = Void or yyspecial_routines59 = Void then
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
	yyspecial_routines59.force (yyvs59, yyval59, yyvsp59)
end
		end

	yy_do_action_306
			--|#line <not available> "eiffel.y"
		local
			yyval88: detachable EIFFEL_LIST [CASE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp88 := yyvsp88 + 1
	if yyvsp88 >= yyvsc88 or yyvs88 = Void or yyspecial_routines88 = Void then
		if yyvs88 = Void or yyspecial_routines88 = Void then
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
	yyspecial_routines88.force (yyvs88, yyval88, yyvsp88)
end
		end

	yy_do_action_307
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines88 /= Void
			yyvs88 /= Void
		local
			yyval88: detachable EIFFEL_LIST [CASE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval88 := yyvs88.item (yyvsp88) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyspecial_routines88.force (yyvs88, yyval88, yyvsp88)
end
		end

	yy_do_action_308
			--|#line <not available> "eiffel.y"
		local
			yyval88: detachable EIFFEL_LIST [CASE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval88 := ast_factory.new_eiffel_list_case_as (counter_value + 1)
				if attached yyval88 as l_list and then attached yyvs36.item (yyvsp36) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp88 := yyvsp88 + 1
	yyvsp36 := yyvsp36 -1
	if yyvsp88 >= yyvsc88 or yyvs88 = Void or yyspecial_routines88 = Void then
		if yyvs88 = Void or yyspecial_routines88 = Void then
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
	yyspecial_routines88.force (yyvs88, yyval88, yyvsp88)
end
		end

	yy_do_action_309
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines88 /= Void
			yyvs88 /= Void
		local
			yyval88: detachable EIFFEL_LIST [CASE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval88 := yyvs88.item (yyvsp88)
				if attached yyval88 as l_list and then attached yyvs36.item (yyvsp36) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp36 := yyvsp36 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines88.force (yyvs88, yyval88, yyvsp88)
end
		end

	yy_do_action_310
			--|#line <not available> "eiffel.y"
		local
			yyval36: detachable CASE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval36 := ast_factory.new_case_as (yyvs108.item (yyvsp108), yyvs107.item (yyvsp107), yyvs12.item (yyvsp12 - 1), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp36 := yyvsp36 + 1
	yyvsp12 := yyvsp12 -2
	yyvsp1 := yyvsp1 -2
	yyvsp108 := yyvsp108 -1
	yyvsp107 := yyvsp107 -1
	if yyvsp36 >= yyvsc36 or yyvs36 = Void or yyspecial_routines36 = Void then
		if yyvs36 = Void or yyspecial_routines36 = Void then
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
	yyspecial_routines36.force (yyvs36, yyval36, yyvsp36)
end
		end

	yy_do_action_311
			--|#line <not available> "eiffel.y"
		local
			yyval108: detachable EIFFEL_LIST [INTERVAL_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval108 := ast_factory.new_eiffel_list_interval_as (counter_value + 1)
				if attached yyval108 as l_list and then attached yyvs63.item (yyvsp63) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp108 := yyvsp108 + 1
	yyvsp63 := yyvsp63 -1
	if yyvsp108 >= yyvsc108 or yyvs108 = Void or yyspecial_routines108 = Void then
		if yyvs108 = Void or yyspecial_routines108 = Void then
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
	yyspecial_routines108.force (yyvs108, yyval108, yyvsp108)
end
		end

	yy_do_action_312
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines108 /= Void
			yyvs108 /= Void
		local
			yyval108: detachable EIFFEL_LIST [INTERVAL_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval108 := yyvs108.item (yyvsp108)
				if attached yyval108 as l_list and then attached yyvs63.item (yyvsp63) as l_val then
					l_list.reverse_extend (l_val)
					ast_factory.reverse_extend_separator (l_list, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp63 := yyvsp63 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines108.force (yyvs108, yyval108, yyvsp108)
end
		end

	yy_do_action_313
			--|#line <not available> "eiffel.y"
		local
			yyval63: detachable INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval63 := ast_factory.new_interval_as (yyvs61.item (yyvsp61), Void, Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp63 := yyvsp63 + 1
	yyvsp61 := yyvsp61 -1
	if yyvsp63 >= yyvsc63 or yyvs63 = Void or yyspecial_routines63 = Void then
		if yyvs63 = Void or yyspecial_routines63 = Void then
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
	yyspecial_routines63.force (yyvs63, yyval63, yyvsp63)
end
		end

	yy_do_action_314
			--|#line <not available> "eiffel.y"
		local
			yyval63: detachable INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval63 := ast_factory.new_interval_as (yyvs61.item (yyvsp61 - 1), yyvs61.item (yyvsp61), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp63 := yyvsp63 + 1
	yyvsp61 := yyvsp61 -2
	yyvsp4 := yyvsp4 -1
	if yyvsp63 >= yyvsc63 or yyvs63 = Void or yyspecial_routines63 = Void then
		if yyvs63 = Void or yyspecial_routines63 = Void then
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
	yyspecial_routines63.force (yyvs63, yyval63, yyvsp63)
end
		end

	yy_do_action_315
			--|#line <not available> "eiffel.y"
		local
			yyval63: detachable INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval63 := ast_factory.new_interval_as (yyvs3.item (yyvsp3), Void, Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp63 := yyvsp63 + 1
	yyvsp3 := yyvsp3 -1
	if yyvsp63 >= yyvsc63 or yyvs63 = Void or yyspecial_routines63 = Void then
		if yyvs63 = Void or yyspecial_routines63 = Void then
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
	yyspecial_routines63.force (yyvs63, yyval63, yyvsp63)
end
		end

	yy_do_action_316
			--|#line <not available> "eiffel.y"
		local
			yyval63: detachable INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval63 := ast_factory.new_interval_as (yyvs3.item (yyvsp3 - 1), yyvs3.item (yyvsp3), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp63 := yyvsp63 + 1
	yyvsp3 := yyvsp3 -2
	yyvsp4 := yyvsp4 -1
	if yyvsp63 >= yyvsc63 or yyvs63 = Void or yyspecial_routines63 = Void then
		if yyvs63 = Void or yyspecial_routines63 = Void then
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
	yyspecial_routines63.force (yyvs63, yyval63, yyvsp63)
end
		end

	yy_do_action_317
			--|#line <not available> "eiffel.y"
		local
			yyval63: detachable INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval63 := ast_factory.new_interval_as (yyvs2.item (yyvsp2), Void, Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp63 := yyvsp63 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp63 >= yyvsc63 or yyvs63 = Void or yyspecial_routines63 = Void then
		if yyvs63 = Void or yyspecial_routines63 = Void then
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
	yyspecial_routines63.force (yyvs63, yyval63, yyvsp63)
end
		end

	yy_do_action_318
			--|#line <not available> "eiffel.y"
		local
			yyval63: detachable INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval63 := ast_factory.new_interval_as (yyvs2.item (yyvsp2 - 1), yyvs2.item (yyvsp2), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp63 := yyvsp63 + 1
	yyvsp2 := yyvsp2 -2
	yyvsp4 := yyvsp4 -1
	if yyvsp63 >= yyvsc63 or yyvs63 = Void or yyspecial_routines63 = Void then
		if yyvs63 = Void or yyspecial_routines63 = Void then
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
	yyspecial_routines63.force (yyvs63, yyval63, yyvsp63)
end
		end

	yy_do_action_319
			--|#line <not available> "eiffel.y"
		local
			yyval63: detachable INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval63 := ast_factory.new_interval_as (yyvs2.item (yyvsp2), yyvs61.item (yyvsp61), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp63 := yyvsp63 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -1
	yyvsp61 := yyvsp61 -1
	if yyvsp63 >= yyvsc63 or yyvs63 = Void or yyspecial_routines63 = Void then
		if yyvs63 = Void or yyspecial_routines63 = Void then
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
	yyspecial_routines63.force (yyvs63, yyval63, yyvsp63)
end
		end

	yy_do_action_320
			--|#line <not available> "eiffel.y"
		local
			yyval63: detachable INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval63 := ast_factory.new_interval_as (yyvs61.item (yyvsp61), yyvs2.item (yyvsp2), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp63 := yyvsp63 + 1
	yyvsp61 := yyvsp61 -1
	yyvsp4 := yyvsp4 -1
	yyvsp2 := yyvsp2 -1
	if yyvsp63 >= yyvsc63 or yyvs63 = Void or yyspecial_routines63 = Void then
		if yyvs63 = Void or yyspecial_routines63 = Void then
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
	yyspecial_routines63.force (yyvs63, yyval63, yyvsp63)
end
		end

	yy_do_action_321
			--|#line <not available> "eiffel.y"
		local
			yyval63: detachable INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval63 := ast_factory.new_interval_as (yyvs2.item (yyvsp2), yyvs3.item (yyvsp3), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp63 := yyvsp63 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -1
	yyvsp3 := yyvsp3 -1
	if yyvsp63 >= yyvsc63 or yyvs63 = Void or yyspecial_routines63 = Void then
		if yyvs63 = Void or yyspecial_routines63 = Void then
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
	yyspecial_routines63.force (yyvs63, yyval63, yyvsp63)
end
		end

	yy_do_action_322
			--|#line <not available> "eiffel.y"
		local
			yyval63: detachable INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval63 := ast_factory.new_interval_as (yyvs3.item (yyvsp3), yyvs2.item (yyvsp2), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp63 := yyvsp63 + 1
	yyvsp3 := yyvsp3 -1
	yyvsp4 := yyvsp4 -1
	yyvsp2 := yyvsp2 -1
	if yyvsp63 >= yyvsc63 or yyvs63 = Void or yyspecial_routines63 = Void then
		if yyvs63 = Void or yyspecial_routines63 = Void then
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
	yyspecial_routines63.force (yyvs63, yyval63, yyvsp63)
end
		end

	yy_do_action_323
			--|#line <not available> "eiffel.y"
		local
			yyval63: detachable INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval63 := ast_factory.new_interval_as (yyvs71.item (yyvsp71), Void, Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp63 := yyvsp63 + 1
	yyvsp71 := yyvsp71 -1
	if yyvsp63 >= yyvsc63 or yyvs63 = Void or yyspecial_routines63 = Void then
		if yyvs63 = Void or yyspecial_routines63 = Void then
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
	yyspecial_routines63.force (yyvs63, yyval63, yyvsp63)
end
		end

	yy_do_action_324
			--|#line <not available> "eiffel.y"
		local
			yyval63: detachable INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval63 := ast_factory.new_interval_as (yyvs71.item (yyvsp71), yyvs2.item (yyvsp2), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp63 := yyvsp63 + 1
	yyvsp71 := yyvsp71 -1
	yyvsp4 := yyvsp4 -1
	yyvsp2 := yyvsp2 -1
	if yyvsp63 >= yyvsc63 or yyvs63 = Void or yyspecial_routines63 = Void then
		if yyvs63 = Void or yyspecial_routines63 = Void then
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
	yyspecial_routines63.force (yyvs63, yyval63, yyvsp63)
end
		end

	yy_do_action_325
			--|#line <not available> "eiffel.y"
		local
			yyval63: detachable INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval63 := ast_factory.new_interval_as (yyvs2.item (yyvsp2), yyvs71.item (yyvsp71), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp63 := yyvsp63 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -1
	yyvsp71 := yyvsp71 -1
	if yyvsp63 >= yyvsc63 or yyvs63 = Void or yyspecial_routines63 = Void then
		if yyvs63 = Void or yyspecial_routines63 = Void then
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
	yyspecial_routines63.force (yyvs63, yyval63, yyvsp63)
end
		end

	yy_do_action_326
			--|#line <not available> "eiffel.y"
		local
			yyval63: detachable INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval63 := ast_factory.new_interval_as (yyvs71.item (yyvsp71 - 1), yyvs71.item (yyvsp71), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp63 := yyvsp63 + 1
	yyvsp71 := yyvsp71 -2
	yyvsp4 := yyvsp4 -1
	if yyvsp63 >= yyvsc63 or yyvs63 = Void or yyspecial_routines63 = Void then
		if yyvs63 = Void or yyspecial_routines63 = Void then
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
	yyspecial_routines63.force (yyvs63, yyval63, yyvsp63)
end
		end

	yy_do_action_327
			--|#line <not available> "eiffel.y"
		local
			yyval63: detachable INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval63 := ast_factory.new_interval_as (yyvs71.item (yyvsp71), yyvs61.item (yyvsp61), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp63 := yyvsp63 + 1
	yyvsp71 := yyvsp71 -1
	yyvsp4 := yyvsp4 -1
	yyvsp61 := yyvsp61 -1
	if yyvsp63 >= yyvsc63 or yyvs63 = Void or yyspecial_routines63 = Void then
		if yyvs63 = Void or yyspecial_routines63 = Void then
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
	yyspecial_routines63.force (yyvs63, yyval63, yyvsp63)
end
		end

	yy_do_action_328
			--|#line <not available> "eiffel.y"
		local
			yyval63: detachable INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval63 := ast_factory.new_interval_as (yyvs61.item (yyvsp61), yyvs71.item (yyvsp71), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp63 := yyvsp63 + 1
	yyvsp61 := yyvsp61 -1
	yyvsp4 := yyvsp4 -1
	yyvsp71 := yyvsp71 -1
	if yyvsp63 >= yyvsc63 or yyvs63 = Void or yyspecial_routines63 = Void then
		if yyvs63 = Void or yyspecial_routines63 = Void then
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
	yyspecial_routines63.force (yyvs63, yyval63, yyvsp63)
end
		end

	yy_do_action_329
			--|#line <not available> "eiffel.y"
		local
			yyval63: detachable INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval63 := ast_factory.new_interval_as (yyvs71.item (yyvsp71), yyvs3.item (yyvsp3), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp63 := yyvsp63 + 1
	yyvsp71 := yyvsp71 -1
	yyvsp4 := yyvsp4 -1
	yyvsp3 := yyvsp3 -1
	if yyvsp63 >= yyvsc63 or yyvs63 = Void or yyspecial_routines63 = Void then
		if yyvs63 = Void or yyspecial_routines63 = Void then
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
	yyspecial_routines63.force (yyvs63, yyval63, yyvsp63)
end
		end

	yy_do_action_330
			--|#line <not available> "eiffel.y"
		local
			yyval63: detachable INTERVAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval63 := ast_factory.new_interval_as (yyvs3.item (yyvsp3), yyvs71.item (yyvsp71), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp63 := yyvsp63 + 1
	yyvsp3 := yyvsp3 -1
	yyvsp4 := yyvsp4 -1
	yyvsp71 := yyvsp71 -1
	if yyvsp63 >= yyvsc63 or yyvs63 = Void or yyspecial_routines63 = Void then
		if yyvs63 = Void or yyspecial_routines63 = Void then
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
	yyspecial_routines63.force (yyvs63, yyval63, yyvsp63)
end
		end

	yy_do_action_331
			--|#line <not available> "eiffel.y"
		local
			yyval66: detachable LOOP_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs85.item (yyvsp85)), token_column (yyvs85.item (yyvsp85)), filename,
						once "Loop variant should appear just before the end keyword of the loop."))
				end
				if attached yyvs22.item (yyvsp22) as l_invariant_pair then
					yyval66 := ast_factory.new_loop_as (Void, yyvs107.item (yyvsp107 - 1), l_invariant_pair.second, yyvs85.item (yyvsp85), yyvs48.item (yyvsp48), yyvs107.item (yyvsp107), yyvs12.item (yyvsp12), yyvs12.item (yyvsp12 - 3), l_invariant_pair.first, yyvs12.item (yyvsp12 - 2), yyvs12.item (yyvsp12 - 1))
				else
					yyval66 := ast_factory.new_loop_as (Void, yyvs107.item (yyvsp107 - 1), Void, yyvs85.item (yyvsp85), yyvs48.item (yyvsp48), yyvs107.item (yyvsp107), yyvs12.item (yyvsp12), yyvs12.item (yyvsp12 - 3), Void, yyvs12.item (yyvsp12 - 2), yyvs12.item (yyvsp12 - 1))
				end
				has_type := False
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 9
	yyvsp66 := yyvsp66 + 1
	yyvsp12 := yyvsp12 -4
	yyvsp107 := yyvsp107 -2
	yyvsp22 := yyvsp22 -1
	yyvsp85 := yyvsp85 -1
	yyvsp48 := yyvsp48 -1
	if yyvsp66 >= yyvsc66 or yyvs66 = Void or yyspecial_routines66 = Void then
		if yyvs66 = Void or yyspecial_routines66 = Void then
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
	yyspecial_routines66.force (yyvs66, yyval66, yyvsp66)
end
		end

	yy_do_action_332
			--|#line <not available> "eiffel.y"
		local
			yyval66: detachable LOOP_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs22.item (yyvsp22) as l_invariant_pair then
					yyval66 := ast_factory.new_loop_as (Void, yyvs107.item (yyvsp107 - 1), l_invariant_pair.second, yyvs85.item (yyvsp85), yyvs48.item (yyvsp48), yyvs107.item (yyvsp107), yyvs12.item (yyvsp12), yyvs12.item (yyvsp12 - 3), l_invariant_pair.first, yyvs12.item (yyvsp12 - 2), yyvs12.item (yyvsp12 - 1))
				else
					yyval66 := ast_factory.new_loop_as (Void, yyvs107.item (yyvsp107 - 1), Void, yyvs85.item (yyvsp85), yyvs48.item (yyvsp48), yyvs107.item (yyvsp107), yyvs12.item (yyvsp12), yyvs12.item (yyvsp12 - 3), Void, yyvs12.item (yyvsp12 - 2), yyvs12.item (yyvsp12 - 1))
				end
				has_type := False
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 9
	yyvsp66 := yyvsp66 + 1
	yyvsp12 := yyvsp12 -4
	yyvsp107 := yyvsp107 -2
	yyvsp22 := yyvsp22 -1
	yyvsp48 := yyvsp48 -1
	yyvsp85 := yyvsp85 -1
	if yyvsp66 >= yyvsc66 or yyvs66 = Void or yyspecial_routines66 = Void then
		if yyvs66 = Void or yyspecial_routines66 = Void then
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
	yyspecial_routines66.force (yyvs66, yyval66, yyvsp66)
end
		end

	yy_do_action_333
			--|#line <not available> "eiffel.y"
		local
			yyval66: detachable LOOP_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs22.item (yyvsp22) as l_invariant_pair then
					if attached yyvs23.item (yyvsp23) as l_until_pair then
						yyval66 := ast_factory.new_loop_as (yyvs106.item (yyvsp106), yyvs107.item (yyvsp107 - 1), l_invariant_pair.second, yyvs85.item (yyvsp85), l_until_pair.second, yyvs107.item (yyvsp107), yyvs12.item (yyvsp12), yyvs12.item (yyvsp12 - 2), l_invariant_pair.first, l_until_pair.first, yyvs12.item (yyvsp12 - 1))
					else
						yyval66 := ast_factory.new_loop_as (yyvs106.item (yyvsp106), yyvs107.item (yyvsp107 - 1), l_invariant_pair.second, yyvs85.item (yyvsp85), Void, yyvs107.item (yyvsp107), yyvs12.item (yyvsp12), yyvs12.item (yyvsp12 - 2), l_invariant_pair.first, Void, yyvs12.item (yyvsp12 - 1))
					end
				else
					if attached yyvs23.item (yyvsp23) as l_until_pair then
						yyval66 := ast_factory.new_loop_as (yyvs106.item (yyvsp106), yyvs107.item (yyvsp107 - 1), Void, yyvs85.item (yyvsp85), l_until_pair.second, yyvs107.item (yyvsp107), yyvs12.item (yyvsp12), yyvs12.item (yyvsp12 - 2), Void, l_until_pair.first, yyvs12.item (yyvsp12 - 1))
					else
						yyval66 := ast_factory.new_loop_as (yyvs106.item (yyvsp106), yyvs107.item (yyvsp107 - 1), Void, yyvs85.item (yyvsp85), Void, yyvs107.item (yyvsp107), yyvs12.item (yyvsp12), yyvs12.item (yyvsp12 - 2), Void, Void, yyvs12.item (yyvsp12 - 1))
					end
				end
				has_type := False
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 9
	yyvsp66 := yyvsp66 + 1
	yyvsp106 := yyvsp106 -1
	yyvsp12 := yyvsp12 -3
	yyvsp107 := yyvsp107 -2
	yyvsp22 := yyvsp22 -1
	yyvsp23 := yyvsp23 -1
	yyvsp85 := yyvsp85 -1
	if yyvsp66 >= yyvsc66 or yyvs66 = Void or yyspecial_routines66 = Void then
		if yyvs66 = Void or yyspecial_routines66 = Void then
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
	yyspecial_routines66.force (yyvs66, yyval66, yyvsp66)
end
		end

	yy_do_action_334
			--|#line <not available> "eiffel.y"
		local
			yyval66: detachable LOOP_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs22.item (yyvsp22) as l_invariant_pair then
					if attached yyvs23.item (yyvsp23) as l_until_pair then
						yyval66 := ast_factory.new_loop_as (yyvs106.item (yyvsp106), Void, l_invariant_pair.second, yyvs85.item (yyvsp85), l_until_pair.second, yyvs107.item (yyvsp107), yyvs12.item (yyvsp12), Void, l_invariant_pair.first, l_until_pair.first, yyvs12.item (yyvsp12 - 1))
					else
						yyval66 := ast_factory.new_loop_as (yyvs106.item (yyvsp106), Void, l_invariant_pair.second, yyvs85.item (yyvsp85), Void, yyvs107.item (yyvsp107), yyvs12.item (yyvsp12), Void, l_invariant_pair.first, Void, yyvs12.item (yyvsp12 - 1))
					end
				else
					if attached yyvs23.item (yyvsp23) as l_until_pair then
						yyval66 := ast_factory.new_loop_as (yyvs106.item (yyvsp106), Void, Void, yyvs85.item (yyvsp85), l_until_pair.second, yyvs107.item (yyvsp107), yyvs12.item (yyvsp12), Void, Void, l_until_pair.first, yyvs12.item (yyvsp12 - 1))
					else
						yyval66 := ast_factory.new_loop_as (yyvs106.item (yyvsp106), Void, Void, yyvs85.item (yyvsp85), Void, yyvs107.item (yyvsp107), yyvs12.item (yyvsp12), Void, Void, Void, yyvs12.item (yyvsp12 - 1))
					end
				end
				has_type := False
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp66 := yyvsp66 + 1
	yyvsp106 := yyvsp106 -1
	yyvsp22 := yyvsp22 -1
	yyvsp23 := yyvsp23 -1
	yyvsp12 := yyvsp12 -2
	yyvsp107 := yyvsp107 -1
	yyvsp85 := yyvsp85 -1
	if yyvsp66 >= yyvsc66 or yyvs66 = Void or yyspecial_routines66 = Void then
		if yyvs66 = Void or yyspecial_routines66 = Void then
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
	yyspecial_routines66.force (yyvs66, yyval66, yyvsp66)
end
		end

	yy_do_action_335
			--|#line <not available> "eiffel.y"
		local
			yyval65: detachable LOOP_EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs22.item (yyvsp22) as l_invariant_pair then
					if attached yyvs23.item (yyvsp23) as l_until_pair then
						yyval65 := ast_factory.new_loop_expr_as (yyvs106.item (yyvsp106), l_invariant_pair.first, l_invariant_pair.second, l_until_pair.first, l_until_pair.second, yyvs12.item (yyvsp12 - 1), True, yyvs48.item (yyvsp48), yyvs85.item (yyvsp85), yyvs12.item (yyvsp12))
					else
						yyval65 := ast_factory.new_loop_expr_as (yyvs106.item (yyvsp106), l_invariant_pair.first, l_invariant_pair.second, Void, Void, yyvs12.item (yyvsp12 - 1), True, yyvs48.item (yyvsp48), yyvs85.item (yyvsp85), yyvs12.item (yyvsp12))
					end
				else
					if attached yyvs23.item (yyvsp23) as l_until_pair then
						yyval65 := ast_factory.new_loop_expr_as (yyvs106.item (yyvsp106), Void, Void, l_until_pair.first, l_until_pair.second, yyvs12.item (yyvsp12 - 1), True, yyvs48.item (yyvsp48), yyvs85.item (yyvsp85), yyvs12.item (yyvsp12))
					else
						yyval65 := ast_factory.new_loop_expr_as (yyvs106.item (yyvsp106), Void, Void, Void, Void, yyvs12.item (yyvsp12 - 1), True, yyvs48.item (yyvsp48), yyvs85.item (yyvsp85), yyvs12.item (yyvsp12))
					end
				end
				has_type := True
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp65 := yyvsp65 + 1
	yyvsp106 := yyvsp106 -1
	yyvsp22 := yyvsp22 -1
	yyvsp23 := yyvsp23 -1
	yyvsp12 := yyvsp12 -2
	yyvsp48 := yyvsp48 -1
	yyvsp85 := yyvsp85 -1
	if yyvsp65 >= yyvsc65 or yyvs65 = Void or yyspecial_routines65 = Void then
		if yyvs65 = Void or yyspecial_routines65 = Void then
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
	yyspecial_routines65.force (yyvs65, yyval65, yyvsp65)
end
		end

	yy_do_action_336
			--|#line <not available> "eiffel.y"
		local
			yyval65: detachable LOOP_EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs22.item (yyvsp22) as l_invariant_pair then
					if attached yyvs23.item (yyvsp23) as l_until_pair then
						yyval65 := ast_factory.new_loop_expr_as (yyvs106.item (yyvsp106), l_invariant_pair.first, l_invariant_pair.second, l_until_pair.first, l_until_pair.second, extract_keyword (yyvs15.item (yyvsp15)), False, yyvs48.item (yyvsp48), yyvs85.item (yyvsp85), yyvs12.item (yyvsp12))
					else
						yyval65 := ast_factory.new_loop_expr_as (yyvs106.item (yyvsp106), l_invariant_pair.first, l_invariant_pair.second, Void, Void, extract_keyword (yyvs15.item (yyvsp15)), False, yyvs48.item (yyvsp48), yyvs85.item (yyvsp85), yyvs12.item (yyvsp12))
					end
				else
					if attached yyvs23.item (yyvsp23) as l_until_pair then
						yyval65 := ast_factory.new_loop_expr_as (yyvs106.item (yyvsp106), Void, Void, l_until_pair.first, l_until_pair.second, extract_keyword (yyvs15.item (yyvsp15)), False, yyvs48.item (yyvsp48), yyvs85.item (yyvsp85), yyvs12.item (yyvsp12))
					else
						yyval65 := ast_factory.new_loop_expr_as (yyvs106.item (yyvsp106), Void, Void, Void, Void, extract_keyword (yyvs15.item (yyvsp15)), False, yyvs48.item (yyvsp48), yyvs85.item (yyvsp85), yyvs12.item (yyvsp12))
					end
				end
				has_type := True
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp65 := yyvsp65 + 1
	yyvsp106 := yyvsp106 -1
	yyvsp22 := yyvsp22 -1
	yyvsp23 := yyvsp23 -1
	yyvsp15 := yyvsp15 -1
	yyvsp48 := yyvsp48 -1
	yyvsp85 := yyvsp85 -1
	yyvsp12 := yyvsp12 -1
	if yyvsp65 >= yyvsc65 or yyvs65 = Void or yyspecial_routines65 = Void then
		if yyvs65 = Void or yyspecial_routines65 = Void then
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
	yyspecial_routines65.force (yyvs65, yyval65, yyvsp65)
end
		end

	yy_do_action_337
			--|#line <not available> "eiffel.y"
		local
			yyval106: detachable ITERATION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				insert_supplier ("ITERABLE", yyvs2.item (yyvsp2))
				insert_supplier ("ITERATION_CURSOR", yyvs2.item (yyvsp2))
				yyval106 := ast_factory.new_iteration_as (extract_keyword (yyvs15.item (yyvsp15)), yyvs48.item (yyvsp48), yyvs12.item (yyvsp12), yyvs2.item (yyvsp2))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp106 := yyvsp106 + 1
	yyvsp15 := yyvsp15 -1
	yyvsp48 := yyvsp48 -1
	yyvsp12 := yyvsp12 -1
	yyvsp2 := yyvsp2 -1
	if yyvsp106 >= yyvsc106 or yyvs106 = Void or yyspecial_routines106 = Void then
		if yyvs106 = Void or yyspecial_routines106 = Void then
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
	yyspecial_routines106.force (yyvs106, yyval106, yyvsp106)
end
		end

	yy_do_action_338
			--|#line <not available> "eiffel.y"
		local
			yyval22: detachable PAIR [KEYWORD_AS, EIFFEL_LIST [TAGGED_AS]]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp22 := yyvsp22 + 1
	if yyvsp22 >= yyvsc22 or yyvs22 = Void or yyspecial_routines22 = Void then
		if yyvs22 = Void or yyspecial_routines22 = Void then
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
	yyspecial_routines22.force (yyvs22, yyval22, yyvsp22)
end
		end

	yy_do_action_339
			--|#line <not available> "eiffel.y"
		local
			yyval22: detachable PAIR [KEYWORD_AS, EIFFEL_LIST [TAGGED_AS]]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval22 := ast_factory.new_invariant_pair (yyvs12.item (yyvsp12), yyvs116.item (yyvsp116)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp22 := yyvsp22 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp116 := yyvsp116 -1
	if yyvsp22 >= yyvsc22 or yyvs22 = Void or yyspecial_routines22 = Void then
		if yyvs22 = Void or yyspecial_routines22 = Void then
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
	yyspecial_routines22.force (yyvs22, yyval22, yyvsp22)
end
		end

	yy_do_action_340
			--|#line <not available> "eiffel.y"
		local
			yyval64: detachable INVARIANT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp64 := yyvsp64 + 1
	if yyvsp64 >= yyvsc64 or yyvs64 = Void or yyspecial_routines64 = Void then
		if yyvs64 = Void or yyspecial_routines64 = Void then
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
	yyspecial_routines64.force (yyvs64, yyval64, yyvsp64)
end
		end

	yy_do_action_341
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines64 /= Void
			yyvs64 /= Void
		local
			yyval64: detachable INVARIANT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				set_id_level (Normal_level)
				yyval64 := ast_factory.new_invariant_as (yyvs116.item (yyvsp116), once_manifest_string_counter_value, yyvs12.item (yyvsp12), object_test_locals)
				reset_once_manifest_string_counter
				object_test_locals := Void
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp12 := yyvsp12 -1
	yyvsp116 := yyvsp116 -1
	yyspecial_routines64.force (yyvs64, yyval64, yyvsp64)
end
		end

	yy_do_action_342
			--|#line <not available> "eiffel.y"
		local
			yyval64: detachable INVARIANT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

set_id_level (Invariant_level) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp64 := yyvsp64 + 1
	if yyvsp64 >= yyvsc64 or yyvs64 = Void or yyspecial_routines64 = Void then
		if yyvs64 = Void or yyspecial_routines64 = Void then
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
	yyspecial_routines64.force (yyvs64, yyval64, yyvsp64)
end
		end

	yy_do_action_343
			--|#line <not available> "eiffel.y"
		local
			yyval23: detachable PAIR [KEYWORD_AS, EXPR_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp23 := yyvsp23 + 1
	if yyvsp23 >= yyvsc23 or yyvs23 = Void or yyspecial_routines23 = Void then
		if yyvs23 = Void or yyspecial_routines23 = Void then
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
	yyspecial_routines23.force (yyvs23, yyval23, yyvsp23)
end
		end

	yy_do_action_344
			--|#line <not available> "eiffel.y"
		local
			yyval23: detachable PAIR [KEYWORD_AS, EXPR_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval23 := ast_factory.new_exit_condition_pair (yyvs12.item (yyvsp12), yyvs48.item (yyvsp48)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp23 := yyvsp23 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp48 := yyvsp48 -1
	if yyvsp23 >= yyvsc23 or yyvs23 = Void or yyspecial_routines23 = Void then
		if yyvs23 = Void or yyspecial_routines23 = Void then
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
	yyspecial_routines23.force (yyvs23, yyval23, yyvsp23)
end
		end

	yy_do_action_345
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable VARIANT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp85 := yyvsp85 + 1
	if yyvsp85 >= yyvsc85 or yyvs85 = Void or yyspecial_routines85 = Void then
		if yyvs85 = Void or yyspecial_routines85 = Void then
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
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_346
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines85 /= Void
			yyvs85 /= Void
		local
			yyval85: detachable VARIANT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval85 := yyvs85.item (yyvsp85) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_347
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable VARIANT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval85 := ast_factory.new_variant_as (yyvs2.item (yyvsp2), yyvs48.item (yyvsp48), yyvs12.item (yyvsp12), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp85 := yyvsp85 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -1
	yyvsp48 := yyvsp48 -1
	if yyvsp85 >= yyvsc85 or yyvs85 = Void or yyspecial_routines85 = Void then
		if yyvs85 = Void or yyspecial_routines85 = Void then
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
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_348
			--|#line <not available> "eiffel.y"
		local
			yyval85: detachable VARIANT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval85 := ast_factory.new_variant_as (Void, yyvs48.item (yyvsp48), yyvs12.item (yyvsp12), Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp85 := yyvsp85 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp48 := yyvsp48 -1
	if yyvsp85 >= yyvsc85 or yyvs85 = Void or yyspecial_routines85 = Void then
		if yyvs85 = Void or yyspecial_routines85 = Void then
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
	yyspecial_routines85.force (yyvs85, yyval85, yyvsp85)
end
		end

	yy_do_action_349
			--|#line <not available> "eiffel.y"
		local
			yyval44: detachable DEBUG_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval44 := ast_factory.new_debug_as (yyvs115.item (yyvsp115), yyvs107.item (yyvsp107), yyvs12.item (yyvsp12 - 1), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp44 := yyvsp44 + 1
	yyvsp12 := yyvsp12 -2
	yyvsp115 := yyvsp115 -1
	yyvsp107 := yyvsp107 -1
	if yyvsp44 >= yyvsc44 or yyvs44 = Void or yyspecial_routines44 = Void then
		if yyvs44 = Void or yyspecial_routines44 = Void then
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
	yyspecial_routines44.force (yyvs44, yyval44, yyvsp44)
end
		end

	yy_do_action_350
			--|#line <not available> "eiffel.y"
		local
			yyval115: detachable KEY_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp115 := yyvsp115 + 1
	if yyvsp115 >= yyvsc115 or yyvs115 = Void or yyspecial_routines115 = Void then
		if yyvs115 = Void or yyspecial_routines115 = Void then
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
	yyspecial_routines115.force (yyvs115, yyval115, yyvsp115)
end
		end

	yy_do_action_351
			--|#line <not available> "eiffel.y"
		local
			yyval115: detachable KEY_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval115 := ast_factory.new_key_list_as (Void, yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp115 := yyvsp115 + 1
	yyvsp4 := yyvsp4 -2
	if yyvsp115 >= yyvsc115 or yyvs115 = Void or yyspecial_routines115 = Void then
		if yyvs115 = Void or yyspecial_routines115 = Void then
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
	yyspecial_routines115.force (yyvs115, yyval115, yyvsp115)
end
		end

	yy_do_action_352
			--|#line <not available> "eiffel.y"
		local
			yyval115: detachable KEY_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval115 := ast_factory.new_key_list_as (yyvs114.item (yyvsp114), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp115 := yyvsp115 + 1
	yyvsp4 := yyvsp4 -2
	yyvsp1 := yyvsp1 -2
	yyvsp114 := yyvsp114 -1
	if yyvsp115 >= yyvsc115 or yyvs115 = Void or yyspecial_routines115 = Void then
		if yyvs115 = Void or yyspecial_routines115 = Void then
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
	yyspecial_routines115.force (yyvs115, yyval115, yyvsp115)
end
		end

	yy_do_action_353
			--|#line <not available> "eiffel.y"
		local
			yyval114: detachable EIFFEL_LIST [STRING_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval114 := ast_factory.new_eiffel_list_string_as (counter_value + 1)
				if attached yyval114 as l_list and then attached yyvs16.item (yyvsp16) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp114 := yyvsp114 + 1
	yyvsp16 := yyvsp16 -1
	if yyvsp114 >= yyvsc114 or yyvs114 = Void or yyspecial_routines114 = Void then
		if yyvs114 = Void or yyspecial_routines114 = Void then
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
	yyspecial_routines114.force (yyvs114, yyval114, yyvsp114)
end
		end

	yy_do_action_354
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines114 /= Void
			yyvs114 /= Void
		local
			yyval114: detachable EIFFEL_LIST [STRING_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval114 := yyvs114.item (yyvsp114)
				if attached yyval114 as l_list and then attached yyvs16.item (yyvsp16) as l_val then
					l_list.reverse_extend (l_val)
					ast_factory.reverse_extend_separator (l_list, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp16 := yyvsp16 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines114.force (yyvs114, yyval114, yyvsp114)
end
		end

	yy_do_action_355
			--|#line <not available> "eiffel.y"
		local
			yyval18: detachable PAIR [KEYWORD_AS, EIFFEL_LIST [INSTRUCTION_AS]]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp18 := yyvsp18 + 1
	if yyvsp18 >= yyvsc18 or yyvs18 = Void or yyspecial_routines18 = Void then
		if yyvs18 = Void or yyspecial_routines18 = Void then
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
	yyspecial_routines18.force (yyvs18, yyval18, yyvsp18)
end
		end

	yy_do_action_356
			--|#line <not available> "eiffel.y"
		local
			yyval18: detachable PAIR [KEYWORD_AS, EIFFEL_LIST [INSTRUCTION_AS]]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if yyvs107.item (yyvsp107) = Void then
					yyval18 := ast_factory.new_keyword_instruction_list_pair (yyvs12.item (yyvsp12), ast_factory.new_eiffel_list_instruction_as (0))
				else
					yyval18 := ast_factory.new_keyword_instruction_list_pair (yyvs12.item (yyvsp12), yyvs107.item (yyvsp107))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp18 := yyvsp18 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp107 := yyvsp107 -1
	if yyvsp18 >= yyvsc18 or yyvs18 = Void or yyspecial_routines18 = Void then
		if yyvs18 = Void or yyspecial_routines18 = Void then
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
	yyspecial_routines18.force (yyvs18, yyval18, yyvsp18)
end
		end

	yy_do_action_357
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := yyvs32.item (yyvsp32) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp48 := yyvsp48 + 1
	yyvsp32 := yyvsp32 -1
	if yyvsp48 >= yyvsc48 or yyvs48 = Void or yyspecial_routines48 = Void then
		if yyvs48 = Void or yyspecial_routines48 = Void then
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
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_358
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines48 /= Void
			yyvs48 /= Void
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := yyvs48.item (yyvsp48) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_359
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := ast_factory.new_expr_call_as (yyvs35.item (yyvsp35)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp48 := yyvsp48 + 1
	yyvsp35 := yyvsp35 -1
	if yyvsp48 >= yyvsc48 or yyvs48 = Void or yyspecial_routines48 = Void then
		if yyvs48 = Void or yyspecial_routines48 = Void then
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
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_360
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := yyvs71.item (yyvsp71) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp48 := yyvsp48 + 1
	yyvsp71 := yyvsp71 -1
	if yyvsp48 >= yyvsc48 or yyvs48 = Void or yyspecial_routines48 = Void then
		if yyvs48 = Void or yyspecial_routines48 = Void then
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
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_361
			--|#line <not available> "eiffel.y"
		local
			yyval30: detachable ASSIGNER_CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval30 := ast_factory.new_assigner_call_as (yyvs48.item (yyvsp48 - 1), yyvs48.item (yyvsp48), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp30 := yyvsp30 + 1
	yyvsp48 := yyvsp48 -2
	yyvsp4 := yyvsp4 -1
	if yyvsp30 >= yyvsc30 or yyvs30 = Void or yyspecial_routines30 = Void then
		if yyvs30 = Void or yyspecial_routines30 = Void then
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
	yyspecial_routines30.force (yyvs30, yyval30, yyvsp30)
end
		end

	yy_do_action_362
			--|#line <not available> "eiffel.y"
		local
			yyval29: detachable ASSIGN_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval29 := ast_factory.new_assign_as (ast_factory.new_access_id_as (yyvs2.item (yyvsp2), Void), yyvs48.item (yyvsp48), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp29 := yyvsp29 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -1
	yyvsp48 := yyvsp48 -1
	if yyvsp29 >= yyvsc29 or yyvs29 = Void or yyspecial_routines29 = Void then
		if yyvs29 = Void or yyspecial_routines29 = Void then
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
	yyspecial_routines29.force (yyvs29, yyval29, yyvsp29)
end
		end

	yy_do_action_363
			--|#line <not available> "eiffel.y"
		local
			yyval29: detachable ASSIGN_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval29 := ast_factory.new_assign_as (yyvs6.item (yyvsp6), yyvs48.item (yyvsp48), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp29 := yyvsp29 + 1
	yyvsp6 := yyvsp6 -1
	yyvsp4 := yyvsp4 -1
	yyvsp48 := yyvsp48 -1
	if yyvsp29 >= yyvsc29 or yyvs29 = Void or yyspecial_routines29 = Void then
		if yyvs29 = Void or yyspecial_routines29 = Void then
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
	yyspecial_routines29.force (yyvs29, yyval29, yyvsp29)
end
		end

	yy_do_action_364
			--|#line <not available> "eiffel.y"
		local
			yyval75: detachable REVERSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval75 := ast_factory.new_reverse_as (ast_factory.new_access_id_as (yyvs2.item (yyvsp2), Void), yyvs48.item (yyvsp48), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp75 := yyvsp75 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp4 := yyvsp4 -1
	yyvsp48 := yyvsp48 -1
	if yyvsp75 >= yyvsc75 or yyvs75 = Void or yyspecial_routines75 = Void then
		if yyvs75 = Void or yyspecial_routines75 = Void then
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
	yyspecial_routines75.force (yyvs75, yyval75, yyvsp75)
end
		end

	yy_do_action_365
			--|#line <not available> "eiffel.y"
		local
			yyval75: detachable REVERSE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval75 := ast_factory.new_reverse_as (yyvs6.item (yyvsp6), yyvs48.item (yyvsp48), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp75 := yyvsp75 + 1
	yyvsp6 := yyvsp6 -1
	yyvsp4 := yyvsp4 -1
	yyvsp48 := yyvsp48 -1
	if yyvsp75 >= yyvsc75 or yyvs75 = Void or yyspecial_routines75 = Void then
		if yyvs75 = Void or yyspecial_routines75 = Void then
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
	yyspecial_routines75.force (yyvs75, yyval75, yyvsp75)
end
		end

	yy_do_action_366
			--|#line <not available> "eiffel.y"
		local
			yyval90: detachable EIFFEL_LIST [CREATE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp90 := yyvsp90 + 1
	if yyvsp90 >= yyvsc90 or yyvs90 = Void or yyspecial_routines90 = Void then
		if yyvs90 = Void or yyspecial_routines90 = Void then
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
	yyspecial_routines90.force (yyvs90, yyval90, yyvsp90)
end
		end

	yy_do_action_367
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines90 /= Void
			yyvs90 /= Void
		local
			yyval90: detachable EIFFEL_LIST [CREATE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval90 := yyvs90.item (yyvsp90) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp1 := yyvsp1 -2
	yyspecial_routines90.force (yyvs90, yyval90, yyvsp90)
end
		end

	yy_do_action_368
			--|#line <not available> "eiffel.y"
		local
			yyval90: detachable EIFFEL_LIST [CREATE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval90 := ast_factory.new_eiffel_list_create_as (counter_value + 1)
				if attached yyval90 as l_list and then attached yyvs41.item (yyvsp41) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp90 := yyvsp90 + 1
	yyvsp41 := yyvsp41 -1
	if yyvsp90 >= yyvsc90 or yyvs90 = Void or yyspecial_routines90 = Void then
		if yyvs90 = Void or yyspecial_routines90 = Void then
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
	yyspecial_routines90.force (yyvs90, yyval90, yyvsp90)
end
		end

	yy_do_action_369
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines90 /= Void
			yyvs90 /= Void
		local
			yyval90: detachable EIFFEL_LIST [CREATE_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval90 := yyvs90.item (yyvsp90)
				if attached yyval90 as l_list and then attached yyvs41.item (yyvsp41) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp41 := yyvsp41 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines90.force (yyvs90, yyval90, yyvsp90)
end
		end

	yy_do_action_370
			--|#line <not available> "eiffel.y"
		local
			yyval41: detachable CREATE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval41 := ast_factory.new_create_as (Void, Void, yyvs12.item (yyvsp12))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp41 := yyvsp41 + 1
	yyvsp12 := yyvsp12 -1
	if yyvsp41 >= yyvsc41 or yyvs41 = Void or yyspecial_routines41 = Void then
		if yyvs41 = Void or yyspecial_routines41 = Void then
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
	yyspecial_routines41.force (yyvs41, yyval41, yyvsp41)
end
		end

	yy_do_action_371
			--|#line <not available> "eiffel.y"
		local
			yyval41: detachable CREATE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval41 := ast_factory.new_create_as (yyvs38.item (yyvsp38), yyvs98.item (yyvsp98), yyvs12.item (yyvsp12))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp41 := yyvsp41 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp38 := yyvsp38 -1
	yyvsp98 := yyvsp98 -1
	if yyvsp41 >= yyvsc41 or yyvs41 = Void or yyspecial_routines41 = Void then
		if yyvs41 = Void or yyspecial_routines41 = Void then
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
	yyspecial_routines41.force (yyvs41, yyval41, yyvsp41)
end
		end

	yy_do_action_372
			--|#line <not available> "eiffel.y"
		local
			yyval41: detachable CREATE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval41 := ast_factory.new_create_as (ast_factory.new_client_as (yyvs104.item (yyvsp104)), Void, yyvs12.item (yyvsp12))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp41 := yyvsp41 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp104 := yyvsp104 -1
	if yyvsp41 >= yyvsc41 or yyvs41 = Void or yyspecial_routines41 = Void then
		if yyvs41 = Void or yyspecial_routines41 = Void then
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
	yyspecial_routines41.force (yyvs41, yyval41, yyvsp41)
end
		end

	yy_do_action_373
			--|#line <not available> "eiffel.y"
		local
			yyval41: detachable CREATE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval41 := ast_factory.new_create_as (Void, Void, yyvs12.item (yyvsp12))
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs12.item (yyvsp12)), token_column (yyvs12.item (yyvsp12)), filename,
						once "Use keyword `create' instead."))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp41 := yyvsp41 + 1
	yyvsp12 := yyvsp12 -1
	if yyvsp41 >= yyvsc41 or yyvs41 = Void or yyspecial_routines41 = Void then
		if yyvs41 = Void or yyspecial_routines41 = Void then
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
	yyspecial_routines41.force (yyvs41, yyval41, yyvsp41)
end
		end

	yy_do_action_374
			--|#line <not available> "eiffel.y"
		local
			yyval41: detachable CREATE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval41 := ast_factory.new_create_as (yyvs38.item (yyvsp38), yyvs98.item (yyvsp98), yyvs12.item (yyvsp12))
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs12.item (yyvsp12)), token_column (yyvs12.item (yyvsp12)), filename,
						once "Use keyword `create' instead."))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp41 := yyvsp41 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp38 := yyvsp38 -1
	yyvsp98 := yyvsp98 -1
	if yyvsp41 >= yyvsc41 or yyvs41 = Void or yyspecial_routines41 = Void then
		if yyvs41 = Void or yyspecial_routines41 = Void then
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
	yyspecial_routines41.force (yyvs41, yyval41, yyvsp41)
end
		end

	yy_do_action_375
			--|#line <not available> "eiffel.y"
		local
			yyval41: detachable CREATE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval41 := ast_factory.new_create_as (ast_factory.new_client_as (yyvs104.item (yyvsp104)), Void, yyvs12.item (yyvsp12))
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs12.item (yyvsp12)), token_column (yyvs12.item (yyvsp12)), filename,
						once "Use keyword `create' instead."))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp41 := yyvsp41 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp104 := yyvsp104 -1
	if yyvsp41 >= yyvsc41 or yyvs41 = Void or yyspecial_routines41 = Void then
		if yyvs41 = Void or yyspecial_routines41 = Void then
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
	yyspecial_routines41.force (yyvs41, yyval41, yyvsp41)
end
		end

	yy_do_action_376
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines78 /= Void
			yyvs78 /= Void
		local
			yyval78: detachable ROUTINE_CREATION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			yyval78 := ast_factory.new_inline_agent_creation_as (
				ast_factory.new_body_as (yyvs120.item (yyvsp120), Void, Void, yyvs77.item (yyvsp77), Void, Void, Void, Void), yyvs110.item (yyvsp110), yyvs12.item (yyvsp12))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp78 := yyvsp78 -1
	yyvsp12 := yyvsp12 -1
	yyvsp120 := yyvsp120 -1
	yyvsp77 := yyvsp77 -1
	yyvsp110 := yyvsp110 -1
	yyspecial_routines78.force (yyvs78, yyval78, yyvsp78)
end
		end

	yy_do_action_377
			--|#line <not available> "eiffel.y"
		local
			yyval78: detachable ROUTINE_CREATION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

add_feature_frame
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp78 := yyvsp78 + 1
	if yyvsp78 >= yyvsc78 or yyvs78 = Void or yyspecial_routines78 = Void then
		if yyvs78 = Void or yyspecial_routines78 = Void then
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
	yyspecial_routines78.force (yyvs78, yyval78, yyvsp78)
end
		end

	yy_do_action_378
			--|#line <not available> "eiffel.y"
		local
			yyval78: detachable ROUTINE_CREATION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

remove_feature_frame
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp78 := yyvsp78 + 1
	if yyvsp78 >= yyvsc78 or yyvs78 = Void or yyspecial_routines78 = Void then
		if yyvs78 = Void or yyspecial_routines78 = Void then
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
	yyspecial_routines78.force (yyvs78, yyval78, yyvsp78)
end
		end

	yy_do_action_379
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines78 /= Void
			yyvs78 /= Void
		local
			yyval78: detachable ROUTINE_CREATION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			yyval78 := ast_factory.new_inline_agent_creation_as (
				ast_factory.new_body_as (yyvs120.item (yyvsp120), yyvs81.item (yyvsp81), Void, yyvs77.item (yyvsp77), yyvs4.item (yyvsp4), Void, Void, Void), yyvs110.item (yyvsp110), yyvs12.item (yyvsp12))
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 8
	yyvsp78 := yyvsp78 -1
	yyvsp12 := yyvsp12 -1
	yyvsp120 := yyvsp120 -1
	yyvsp4 := yyvsp4 -1
	yyvsp81 := yyvsp81 -1
	yyvsp77 := yyvsp77 -1
	yyvsp110 := yyvsp110 -1
	yyspecial_routines78.force (yyvs78, yyval78, yyvsp78)
end
		end

	yy_do_action_380
			--|#line <not available> "eiffel.y"
		local
			yyval78: detachable ROUTINE_CREATION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

add_feature_frame
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp78 := yyvsp78 + 1
	if yyvsp78 >= yyvsc78 or yyvs78 = Void or yyspecial_routines78 = Void then
		if yyvs78 = Void or yyspecial_routines78 = Void then
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
	yyspecial_routines78.force (yyvs78, yyval78, yyvsp78)
end
		end

	yy_do_action_381
			--|#line <not available> "eiffel.y"
		local
			yyval78: detachable ROUTINE_CREATION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

remove_feature_frame
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp78 := yyvsp78 + 1
	if yyvsp78 >= yyvsc78 or yyvs78 = Void or yyspecial_routines78 = Void then
		if yyvs78 = Void or yyspecial_routines78 = Void then
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
	yyspecial_routines78.force (yyvs78, yyval78, yyvsp78)
end
		end

	yy_do_action_382
			--|#line <not available> "eiffel.y"
		local
			yyval78: detachable ROUTINE_CREATION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			yyval78 := ast_factory.new_agent_routine_creation_as (
				Void, yyvs2.item (yyvsp2), yyvs110.item (yyvsp110), False, yyvs12.item (yyvsp12), Void)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp78 := yyvsp78 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp2 := yyvsp2 -1
	yyvsp110 := yyvsp110 -1
	if yyvsp78 >= yyvsc78 or yyvs78 = Void or yyspecial_routines78 = Void then
		if yyvs78 = Void or yyspecial_routines78 = Void then
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
	yyspecial_routines78.force (yyvs78, yyval78, yyvsp78)
end
		end

	yy_do_action_383
			--|#line <not available> "eiffel.y"
		local
			yyval78: detachable ROUTINE_CREATION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			if attached yyvs24.item (yyvsp24) as l_target then
				yyval78 := ast_factory.new_agent_routine_creation_as (l_target.operand, yyvs2.item (yyvsp2), yyvs110.item (yyvsp110), True, yyvs12.item (yyvsp12), yyvs4.item (yyvsp4))
				if attached yyval78 as l_agent then
					l_agent.set_lparan_symbol (l_target.lparan_symbol)
					l_agent.set_rparan_symbol (l_target.rparan_symbol)
				end
			else
				yyval78 := ast_factory.new_agent_routine_creation_as (Void, yyvs2.item (yyvsp2), yyvs110.item (yyvsp110), True, yyvs12.item (yyvsp12), yyvs4.item (yyvsp4))
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp78 := yyvsp78 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp24 := yyvsp24 -1
	yyvsp4 := yyvsp4 -1
	yyvsp2 := yyvsp2 -1
	yyvsp110 := yyvsp110 -1
	if yyvsp78 >= yyvsc78 or yyvs78 = Void or yyspecial_routines78 = Void then
		if yyvs78 = Void or yyspecial_routines78 = Void then
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
	yyspecial_routines78.force (yyvs78, yyval78, yyvsp78)
end
		end

	yy_do_action_384
			--|#line <not available> "eiffel.y"
		local
			yyval120: detachable FORMAL_ARGU_DEC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp120 := yyvsp120 + 1
	if yyvsp120 >= yyvsc120 or yyvs120 = Void or yyspecial_routines120 = Void then
		if yyvs120 = Void or yyspecial_routines120 = Void then
			debug ("GEYACC")
				std.error.put_line ("Create yyvs120")
			end
			create yyspecial_routines120
			yyvsc120 := yyInitial_yyvs_size
			yyvs120 := yyspecial_routines120.make (yyvsc120)
		else
			debug ("GEYACC")
				std.error.put_line ("Resize yyvs120")
			end
			yyvsc120 := yyvsc120 + yyInitial_yyvs_size
			yyvs120 := yyspecial_routines120.resize (yyvs120, yyvsc120)
		end
	end
	yyspecial_routines120.force (yyvs120, yyval120, yyvsp120)
end
		end

	yy_do_action_385
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines120 /= Void
			yyvs120 /= Void
		local
			yyval120: detachable FORMAL_ARGU_DEC_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			yyval120 := yyvs120.item (yyvsp120)
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines120.force (yyvs120, yyval120, yyvsp120)
end
		end

	yy_do_action_386
			--|#line <not available> "eiffel.y"
		local
			yyval24: detachable AGENT_TARGET_TRIPLE
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval24 := ast_factory.new_agent_target_triple (Void, Void, ast_factory.new_operand_as (Void, ast_factory.new_access_id_as (yyvs2.item (yyvsp2), Void), Void)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp24 := yyvsp24 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp24 >= yyvsc24 or yyvs24 = Void or yyspecial_routines24 = Void then
		if yyvs24 = Void or yyspecial_routines24 = Void then
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
	yyspecial_routines24.force (yyvs24, yyval24, yyvsp24)
end
		end

	yy_do_action_387
			--|#line <not available> "eiffel.y"
		local
			yyval24: detachable AGENT_TARGET_TRIPLE
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval24 := ast_factory.new_agent_target_triple (yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4), ast_factory.new_operand_as (Void, Void, yyvs48.item (yyvsp48))) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp24 := yyvsp24 + 1
	yyvsp4 := yyvsp4 -2
	yyvsp1 := yyvsp1 -4
	yyvsp48 := yyvsp48 -1
	if yyvsp24 >= yyvsc24 or yyvs24 = Void or yyspecial_routines24 = Void then
		if yyvs24 = Void or yyspecial_routines24 = Void then
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
	yyspecial_routines24.force (yyvs24, yyval24, yyvsp24)
end
		end

	yy_do_action_388
			--|#line <not available> "eiffel.y"
		local
			yyval24: detachable AGENT_TARGET_TRIPLE
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval24 := ast_factory.new_agent_target_triple (Void, Void, ast_factory.new_operand_as (Void, yyvs6.item (yyvsp6), Void)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp24 := yyvsp24 + 1
	yyvsp6 := yyvsp6 -1
	if yyvsp24 >= yyvsc24 or yyvs24 = Void or yyspecial_routines24 = Void then
		if yyvs24 = Void or yyspecial_routines24 = Void then
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
	yyspecial_routines24.force (yyvs24, yyval24, yyvsp24)
end
		end

	yy_do_action_389
			--|#line <not available> "eiffel.y"
		local
			yyval24: detachable AGENT_TARGET_TRIPLE
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval24 := ast_factory.new_agent_target_triple (Void, Void, ast_factory.new_operand_as (Void, yyvs9.item (yyvsp9), Void)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp24 := yyvsp24 + 1
	yyvsp9 := yyvsp9 -1
	if yyvsp24 >= yyvsc24 or yyvs24 = Void or yyspecial_routines24 = Void then
		if yyvs24 = Void or yyspecial_routines24 = Void then
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
	yyspecial_routines24.force (yyvs24, yyval24, yyvsp24)
end
		end

	yy_do_action_390
			--|#line <not available> "eiffel.y"
		local
			yyval24: detachable AGENT_TARGET_TRIPLE
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval24 := ast_factory.new_agent_target_triple (Void, Void, ast_factory.new_operand_as (yyvs81.item (yyvsp81), Void, Void))
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp24 := yyvsp24 + 1
	yyvsp81 := yyvsp81 -1
	if yyvsp24 >= yyvsc24 or yyvs24 = Void or yyspecial_routines24 = Void then
		if yyvs24 = Void or yyspecial_routines24 = Void then
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
	yyspecial_routines24.force (yyvs24, yyval24, yyvsp24)
end
		end

	yy_do_action_391
			--|#line <not available> "eiffel.y"
		local
			yyval24: detachable AGENT_TARGET_TRIPLE
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

			if attached ast_factory.new_operand_as (Void, Void, Void) as l_temp_operand_as then
				l_temp_operand_as.set_question_mark_symbol (yyvs4.item (yyvsp4))
				yyval24 := ast_factory.new_agent_target_triple (Void, Void, l_temp_operand_as)
			else
				yyval24 := ast_factory.new_agent_target_triple (Void, Void, Void)
			end
		
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp24 := yyvsp24 + 1
	yyvsp4 := yyvsp4 -1
	if yyvsp24 >= yyvsc24 or yyvs24 = Void or yyspecial_routines24 = Void then
		if yyvs24 = Void or yyspecial_routines24 = Void then
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
	yyspecial_routines24.force (yyvs24, yyval24, yyvsp24)
end
		end

	yy_do_action_392
			--|#line <not available> "eiffel.y"
		local
			yyval110: detachable DELAYED_ACTUAL_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp110 := yyvsp110 + 1
	if yyvsp110 >= yyvsc110 or yyvs110 = Void or yyspecial_routines110 = Void then
		if yyvs110 = Void or yyspecial_routines110 = Void then
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
	yyspecial_routines110.force (yyvs110, yyval110, yyvsp110)
end
		end

	yy_do_action_393
			--|#line <not available> "eiffel.y"
		local
			yyval110: detachable DELAYED_ACTUAL_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval110 := ast_factory.new_delayed_actual_list_as (Void, yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp110 := yyvsp110 + 1
	yyvsp4 := yyvsp4 -2
	if yyvsp110 >= yyvsc110 or yyvs110 = Void or yyspecial_routines110 = Void then
		if yyvs110 = Void or yyspecial_routines110 = Void then
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
	yyspecial_routines110.force (yyvs110, yyval110, yyvsp110)
end
		end

	yy_do_action_394
			--|#line <not available> "eiffel.y"
		local
			yyval110: detachable DELAYED_ACTUAL_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval110 := ast_factory.new_delayed_actual_list_as (yyvs109.item (yyvsp109), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp110 := yyvsp110 + 1
	yyvsp4 := yyvsp4 -2
	yyvsp1 := yyvsp1 -2
	yyvsp109 := yyvsp109 -1
	if yyvsp110 >= yyvsc110 or yyvs110 = Void or yyspecial_routines110 = Void then
		if yyvs110 = Void or yyspecial_routines110 = Void then
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
	yyspecial_routines110.force (yyvs110, yyval110, yyvsp110)
end
		end

	yy_do_action_395
			--|#line <not available> "eiffel.y"
		local
			yyval109: detachable EIFFEL_LIST [OPERAND_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval109 := ast_factory.new_eiffel_list_operand_as (counter_value + 1)
				if attached yyval109 as l_list and then attached yyvs68.item (yyvsp68) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp109 := yyvsp109 + 1
	yyvsp68 := yyvsp68 -1
	if yyvsp109 >= yyvsc109 or yyvs109 = Void or yyspecial_routines109 = Void then
		if yyvs109 = Void or yyspecial_routines109 = Void then
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
	yyspecial_routines109.force (yyvs109, yyval109, yyvsp109)
end
		end

	yy_do_action_396
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines109 /= Void
			yyvs109 /= Void
		local
			yyval109: detachable EIFFEL_LIST [OPERAND_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval109 := yyvs109.item (yyvsp109)
				if attached yyval109 as l_list and then attached yyvs68.item (yyvsp68) as l_val then
					l_list.reverse_extend (l_val)
					ast_factory.reverse_extend_separator (l_list, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp68 := yyvsp68 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines109.force (yyvs109, yyval109, yyvsp109)
end
		end

	yy_do_action_397
			--|#line <not available> "eiffel.y"
		local
			yyval68: detachable OPERAND_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval68 := ast_factory.new_operand_as (Void, Void, Void)
				if attached yyval68 as l_actual then
					l_actual.set_question_mark_symbol (yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp68 := yyvsp68 + 1
	yyvsp4 := yyvsp4 -1
	if yyvsp68 >= yyvsc68 or yyvs68 = Void or yyspecial_routines68 = Void then
		if yyvs68 = Void or yyspecial_routines68 = Void then
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
	yyspecial_routines68.force (yyvs68, yyval68, yyvsp68)
end
		end

	yy_do_action_398
			--|#line <not available> "eiffel.y"
		local
			yyval68: detachable OPERAND_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval68 := ast_factory.new_operand_as (yyvs81.item (yyvsp81), Void, Void)
				if attached yyval68 as l_actual then
					l_actual.set_question_mark_symbol (yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp68 := yyvsp68 + 1
	yyvsp81 := yyvsp81 -1
	yyvsp4 := yyvsp4 -1
	if yyvsp68 >= yyvsc68 or yyvs68 = Void or yyspecial_routines68 = Void then
		if yyvs68 = Void or yyspecial_routines68 = Void then
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
	yyspecial_routines68.force (yyvs68, yyval68, yyvsp68)
end
		end

	yy_do_action_399
			--|#line <not available> "eiffel.y"
		local
			yyval68: detachable OPERAND_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval68 := ast_factory.new_operand_as (Void, Void, yyvs48.item (yyvsp48)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp68 := yyvsp68 + 1
	yyvsp48 := yyvsp48 -1
	if yyvsp68 >= yyvsc68 or yyvs68 = Void or yyspecial_routines68 = Void then
		if yyvs68 = Void or yyspecial_routines68 = Void then
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
	yyspecial_routines68.force (yyvs68, yyval68, yyvsp68)
end
		end

	yy_do_action_400
			--|#line <not available> "eiffel.y"
		local
			yyval42: detachable CREATION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval42 := ast_factory.new_bang_creation_as (Void, yyvs25.item (yyvsp25), yyvs27.item (yyvsp27), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4))
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs4.item (yyvsp4 - 1)), token_column (yyvs4.item (yyvsp4 - 1)),
						filename, "Use keyword `create' instead."))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp42 := yyvsp42 + 1
	yyvsp4 := yyvsp4 -2
	yyvsp25 := yyvsp25 -1
	yyvsp27 := yyvsp27 -1
	if yyvsp42 >= yyvsc42 or yyvs42 = Void or yyspecial_routines42 = Void then
		if yyvs42 = Void or yyspecial_routines42 = Void then
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
	yyspecial_routines42.force (yyvs42, yyval42, yyvsp42)
end
		end

	yy_do_action_401
			--|#line <not available> "eiffel.y"
		local
			yyval42: detachable CREATION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval42 := ast_factory.new_bang_creation_as (yyvs81.item (yyvsp81), yyvs25.item (yyvsp25), yyvs27.item (yyvsp27), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4))
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs4.item (yyvsp4 - 1)), token_column (yyvs4.item (yyvsp4 - 1)),
						filename, "Use keyword `create' instead."))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp42 := yyvsp42 + 1
	yyvsp4 := yyvsp4 -2
	yyvsp81 := yyvsp81 -1
	yyvsp25 := yyvsp25 -1
	yyvsp27 := yyvsp27 -1
	if yyvsp42 >= yyvsc42 or yyvs42 = Void or yyspecial_routines42 = Void then
		if yyvs42 = Void or yyspecial_routines42 = Void then
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
	yyspecial_routines42.force (yyvs42, yyval42, yyvsp42)
end
		end

	yy_do_action_402
			--|#line <not available> "eiffel.y"
		local
			yyval42: detachable CREATION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval42 := ast_factory.new_create_creation_as (Void, yyvs25.item (yyvsp25), yyvs27.item (yyvsp27), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp42 := yyvsp42 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp25 := yyvsp25 -1
	yyvsp27 := yyvsp27 -1
	if yyvsp42 >= yyvsc42 or yyvs42 = Void or yyspecial_routines42 = Void then
		if yyvs42 = Void or yyspecial_routines42 = Void then
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
	yyspecial_routines42.force (yyvs42, yyval42, yyvsp42)
end
		end

	yy_do_action_403
			--|#line <not available> "eiffel.y"
		local
			yyval42: detachable CREATION_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval42 := ast_factory.new_create_creation_as (yyvs81.item (yyvsp81), yyvs25.item (yyvsp25), yyvs27.item (yyvsp27), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp42 := yyvsp42 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp81 := yyvsp81 -1
	yyvsp25 := yyvsp25 -1
	yyvsp27 := yyvsp27 -1
	if yyvsp42 >= yyvsc42 or yyvs42 = Void or yyspecial_routines42 = Void then
		if yyvs42 = Void or yyspecial_routines42 = Void then
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
	yyspecial_routines42.force (yyvs42, yyval42, yyvsp42)
end
		end

	yy_do_action_404
			--|#line <not available> "eiffel.y"
		local
			yyval43: detachable CREATION_EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval43 := ast_factory.new_create_creation_expr_as (yyvs81.item (yyvsp81), yyvs27.item (yyvsp27), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp43 := yyvsp43 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp81 := yyvsp81 -1
	yyvsp27 := yyvsp27 -1
	if yyvsp43 >= yyvsc43 or yyvs43 = Void or yyspecial_routines43 = Void then
		if yyvs43 = Void or yyspecial_routines43 = Void then
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
	yyspecial_routines43.force (yyvs43, yyval43, yyvsp43)
end
		end

	yy_do_action_405
			--|#line <not available> "eiffel.y"
		local
			yyval43: detachable CREATION_EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval43 := ast_factory.new_bang_creation_expr_as (yyvs81.item (yyvsp81), yyvs27.item (yyvsp27), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4))
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs4.item (yyvsp4 - 1)), token_column (yyvs4.item (yyvsp4 - 1)),
						filename, "Use keyword `create' instead."))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp43 := yyvsp43 + 1
	yyvsp4 := yyvsp4 -2
	yyvsp81 := yyvsp81 -1
	yyvsp27 := yyvsp27 -1
	if yyvsp43 >= yyvsc43 or yyvs43 = Void or yyspecial_routines43 = Void then
		if yyvs43 = Void or yyspecial_routines43 = Void then
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
	yyspecial_routines43.force (yyvs43, yyval43, yyvsp43)
end
		end

	yy_do_action_406
			--|#line <not available> "eiffel.y"
		local
			yyval25: detachable ACCESS_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval25 := ast_factory.new_access_id_as (yyvs2.item (yyvsp2), Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp25 := yyvsp25 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp25 >= yyvsc25 or yyvs25 = Void or yyspecial_routines25 = Void then
		if yyvs25 = Void or yyspecial_routines25 = Void then
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
	yyspecial_routines25.force (yyvs25, yyval25, yyvsp25)
end
		end

	yy_do_action_407
			--|#line <not available> "eiffel.y"
		local
			yyval25: detachable ACCESS_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval25 := yyvs6.item (yyvsp6) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp25 := yyvsp25 + 1
	yyvsp6 := yyvsp6 -1
	if yyvsp25 >= yyvsc25 or yyvs25 = Void or yyspecial_routines25 = Void then
		if yyvs25 = Void or yyspecial_routines25 = Void then
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
	yyspecial_routines25.force (yyvs25, yyval25, yyvsp25)
end
		end

	yy_do_action_408
			--|#line <not available> "eiffel.y"
		local
			yyval27: detachable ACCESS_INV_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp27 := yyvsp27 + 1
	if yyvsp27 >= yyvsc27 or yyvs27 = Void or yyspecial_routines27 = Void then
		if yyvs27 = Void or yyspecial_routines27 = Void then
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
	yyspecial_routines27.force (yyvs27, yyval27, yyvsp27)
end
		end

	yy_do_action_409
			--|#line <not available> "eiffel.y"
		local
			yyval27: detachable ACCESS_INV_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval27 := ast_factory.new_access_inv_as (yyvs2.item (yyvsp2), yyvs95.item (yyvsp95), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp27 := yyvsp27 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp2 := yyvsp2 -1
	yyvsp95 := yyvsp95 -1
	if yyvsp27 >= yyvsc27 or yyvs27 = Void or yyspecial_routines27 = Void then
		if yyvs27 = Void or yyspecial_routines27 = Void then
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
	yyspecial_routines27.force (yyvs27, yyval27, yyvsp27)
end
		end

	yy_do_action_410
			--|#line <not available> "eiffel.y"
		local
			yyval35: detachable CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval35 := yyvs25.item (yyvsp25) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp35 := yyvsp35 + 1
	yyvsp25 := yyvsp25 -1
	if yyvsp35 >= yyvsc35 or yyvs35 = Void or yyspecial_routines35 = Void then
		if yyvs35 = Void or yyspecial_routines35 = Void then
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
	yyspecial_routines35.force (yyvs35, yyval35, yyvsp35)
end
		end

	yy_do_action_411
			--|#line <not available> "eiffel.y"
		local
			yyval35: detachable CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval35 := yyvs70.item (yyvsp70) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp35 := yyvsp35 + 1
	yyvsp70 := yyvsp70 -1
	if yyvsp35 >= yyvsc35 or yyvs35 = Void or yyspecial_routines35 = Void then
		if yyvs35 = Void or yyspecial_routines35 = Void then
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
	yyspecial_routines35.force (yyvs35, yyval35, yyvsp35)
end
		end

	yy_do_action_412
			--|#line <not available> "eiffel.y"
		local
			yyval35: detachable CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval35 := yyvs71.item (yyvsp71) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp35 := yyvsp35 + 1
	yyvsp71 := yyvsp71 -1
	if yyvsp35 >= yyvsc35 or yyvs35 = Void or yyspecial_routines35 = Void then
		if yyvs35 = Void or yyspecial_routines35 = Void then
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
	yyspecial_routines35.force (yyvs35, yyval35, yyvsp35)
end
		end

	yy_do_action_413
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines35 /= Void
			yyvs35 /= Void
		local
			yyval35: detachable CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval35 := yyvs35.item (yyvsp35) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines35.force (yyvs35, yyval35, yyvsp35)
end
		end

	yy_do_action_414
			--|#line <not available> "eiffel.y"
		local
			yyval37: detachable CHECK_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval37 := ast_factory.new_check_as (yyvs116.item (yyvsp116), yyvs12.item (yyvsp12 - 1), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp37 := yyvsp37 + 1
	yyvsp12 := yyvsp12 -2
	yyvsp116 := yyvsp116 -1
	if yyvsp37 >= yyvsc37 or yyvs37 = Void or yyspecial_routines37 = Void then
		if yyvs37 = Void or yyspecial_routines37 = Void then
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
	yyspecial_routines37.force (yyvs37, yyval37, yyvsp37)
end
		end

	yy_do_action_415
			--|#line <not available> "eiffel.y"
		local
			yyval56: detachable GUARD_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval56 := ast_factory.new_guard_as (yyvs12.item (yyvsp12 - 2), yyvs116.item (yyvsp116), yyvs12.item (yyvsp12 - 1), yyvs107.item (yyvsp107), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp56 := yyvsp56 + 1
	yyvsp12 := yyvsp12 -3
	yyvsp116 := yyvsp116 -1
	yyvsp107 := yyvsp107 -1
	if yyvsp56 >= yyvsc56 or yyvs56 = Void or yyspecial_routines56 = Void then
		if yyvs56 = Void or yyspecial_routines56 = Void then
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
	yyspecial_routines56.force (yyvs56, yyval56, yyvsp56)
end
		end

	yy_do_action_416
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines81 /= Void
			yyvs81 /= Void
		local
			yyval81: detachable TYPE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval81 := yyvs81.item (yyvsp81)
				if attached yyval81 as l_type then
					l_type.set_lcurly_symbol (yyvs4.item (yyvsp4 - 1))
					l_type.set_rcurly_symbol (yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp4 := yyvsp4 -2
	yyspecial_routines81.force (yyvs81, yyval81, yyvsp81)
end
		end

	yy_do_action_417
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := yyvs61.item (yyvsp61); has_type := True 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp48 := yyvsp48 + 1
	yyvsp61 := yyvsp61 -1
	if yyvsp48 >= yyvsc48 or yyvs48 = Void or yyspecial_routines48 = Void then
		if yyvs48 = Void or yyspecial_routines48 = Void then
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
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_418
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := yyvs72.item (yyvsp72); has_type := True 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp48 := yyvsp48 + 1
	yyvsp72 := yyvsp72 -1
	if yyvsp48 >= yyvsc48 or yyvs48 = Void or yyspecial_routines48 = Void then
		if yyvs48 = Void or yyspecial_routines48 = Void then
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
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_419
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines48 /= Void
			yyvs48 /= Void
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := yyvs48.item (yyvsp48) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_420
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines48 /= Void
			yyvs48 /= Void
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := ast_factory.new_bin_tilde_as (yyvs48.item (yyvsp48 - 1), yyvs48.item (yyvsp48), yyvs4.item (yyvsp4)); has_type := True 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp48 := yyvsp48 -1
	yyvsp4 := yyvsp4 -1
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_421
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines48 /= Void
			yyvs48 /= Void
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := ast_factory.new_bin_not_tilde_as (yyvs48.item (yyvsp48 - 1), yyvs48.item (yyvsp48), yyvs4.item (yyvsp4)); has_type := True 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp48 := yyvsp48 -1
	yyvsp4 := yyvsp4 -1
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_422
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines48 /= Void
			yyvs48 /= Void
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := ast_factory.new_bin_eq_as (yyvs48.item (yyvsp48 - 1), yyvs48.item (yyvsp48), yyvs4.item (yyvsp4)); has_type := True 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp48 := yyvsp48 -1
	yyvsp4 := yyvsp4 -1
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_423
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines48 /= Void
			yyvs48 /= Void
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := ast_factory.new_bin_ne_as (yyvs48.item (yyvsp48 - 1), yyvs48.item (yyvsp48), yyvs4.item (yyvsp4)); has_type := True 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp48 := yyvsp48 -1
	yyvsp4 := yyvsp4 -1
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_424
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := yyvs32.item (yyvsp32); has_type := True 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp48 := yyvsp48 + 1
	yyvsp32 := yyvsp32 -1
	if yyvsp48 >= yyvsc48 or yyvs48 = Void or yyspecial_routines48 = Void then
		if yyvs48 = Void or yyspecial_routines48 = Void then
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
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_425
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines48 /= Void
			yyvs48 /= Void
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				check_object_test_expression (yyvs48.item (yyvsp48))
				yyval48 := ast_factory.new_object_test_as (extract_keyword (yyvs15.item (yyvsp15)), Void, yyvs48.item (yyvsp48), Void, Void)
				has_type := True
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp15 := yyvsp15 -1
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_426
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines48 /= Void
			yyvs48 /= Void
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				check_object_test_expression (yyvs48.item (yyvsp48))
				yyval48 := ast_factory.new_object_test_as (extract_keyword (yyvs15.item (yyvsp15)), Void, yyvs48.item (yyvsp48), yyvs12.item (yyvsp12), yyvs2.item (yyvsp2))
				has_type := True
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp15 := yyvsp15 -1
	yyvsp12 := yyvsp12 -1
	yyvsp2 := yyvsp2 -1
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_427
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines48 /= Void
			yyvs48 /= Void
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs81.item (yyvsp81) as l_type then
					l_type.set_lcurly_symbol (yyvs4.item (yyvsp4 - 1))
					l_type.set_rcurly_symbol (yyvs4.item (yyvsp4))
				end
				check_object_test_expression (yyvs48.item (yyvsp48))
				yyval48 := ast_factory.new_object_test_as (extract_keyword (yyvs15.item (yyvsp15)), yyvs81.item (yyvsp81), yyvs48.item (yyvsp48), Void, Void)
				has_type := True
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp15 := yyvsp15 -1
	yyvsp4 := yyvsp4 -2
	yyvsp81 := yyvsp81 -1
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_428
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines48 /= Void
			yyvs48 /= Void
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs81.item (yyvsp81) as l_type then
					l_type.set_lcurly_symbol (yyvs4.item (yyvsp4 - 1))
					l_type.set_rcurly_symbol (yyvs4.item (yyvsp4))
				end
				check_object_test_expression (yyvs48.item (yyvsp48))
				yyval48 := ast_factory.new_object_test_as (extract_keyword (yyvs15.item (yyvsp15)), yyvs81.item (yyvsp81), yyvs48.item (yyvsp48), yyvs12.item (yyvsp12), yyvs2.item (yyvsp2))
				has_type := True
				if attached yyvs2.item (yyvsp2) as l_name and attached yyvs81.item (yyvsp81) as l_type then
					insert_object_test_locals ([l_name, l_type])
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 7
	yyvsp15 := yyvsp15 -1
	yyvsp4 := yyvsp4 -2
	yyvsp81 := yyvsp81 -1
	yyvsp12 := yyvsp12 -1
	yyvsp2 := yyvsp2 -1
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_429
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines48 /= Void
			yyvs48 /= Void
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				check_object_test_expression (yyvs48.item (yyvsp48))
				yyval48 := ast_factory.new_old_syntax_object_test_as (yyvs4.item (yyvsp4 - 2), yyvs2.item (yyvsp2), yyvs81.item (yyvsp81), yyvs48.item (yyvsp48))
				has_type := True
				if attached yyvs2.item (yyvsp2) as l_name and attached yyvs81.item (yyvsp81) as l_type then
					insert_object_test_locals ([l_name, l_type])
				end
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs4.item (yyvsp4 - 2)), token_column (yyvs4.item (yyvsp4 - 2)),
							filename, once "Use the new syntax for object test `attached {T} exp as x'."))

				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp4 := yyvsp4 -3
	yyvsp2 := yyvsp2 -1
	yyvsp81 := yyvsp81 -1
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_430
			--|#line <not available> "eiffel.y"
		local
			yyval32: detachable BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval32 := ast_factory.new_bin_plus_as (yyvs48.item (yyvsp48 - 1), yyvs48.item (yyvsp48), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp32 := yyvsp32 + 1
	yyvsp48 := yyvsp48 -2
	yyvsp4 := yyvsp4 -1
	if yyvsp32 >= yyvsc32 or yyvs32 = Void or yyspecial_routines32 = Void then
		if yyvs32 = Void or yyspecial_routines32 = Void then
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
	yyspecial_routines32.force (yyvs32, yyval32, yyvsp32)
end
		end

	yy_do_action_431
			--|#line <not available> "eiffel.y"
		local
			yyval32: detachable BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval32 := ast_factory.new_bin_minus_as (yyvs48.item (yyvsp48 - 1), yyvs48.item (yyvsp48), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp32 := yyvsp32 + 1
	yyvsp48 := yyvsp48 -2
	yyvsp4 := yyvsp4 -1
	if yyvsp32 >= yyvsc32 or yyvs32 = Void or yyspecial_routines32 = Void then
		if yyvs32 = Void or yyspecial_routines32 = Void then
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
	yyspecial_routines32.force (yyvs32, yyval32, yyvsp32)
end
		end

	yy_do_action_432
			--|#line <not available> "eiffel.y"
		local
			yyval32: detachable BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval32 := ast_factory.new_bin_star_as (yyvs48.item (yyvsp48 - 1), yyvs48.item (yyvsp48), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp32 := yyvsp32 + 1
	yyvsp48 := yyvsp48 -2
	yyvsp4 := yyvsp4 -1
	if yyvsp32 >= yyvsc32 or yyvs32 = Void or yyspecial_routines32 = Void then
		if yyvs32 = Void or yyspecial_routines32 = Void then
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
	yyspecial_routines32.force (yyvs32, yyval32, yyvsp32)
end
		end

	yy_do_action_433
			--|#line <not available> "eiffel.y"
		local
			yyval32: detachable BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval32 := ast_factory.new_bin_slash_as (yyvs48.item (yyvsp48 - 1), yyvs48.item (yyvsp48), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp32 := yyvsp32 + 1
	yyvsp48 := yyvsp48 -2
	yyvsp4 := yyvsp4 -1
	if yyvsp32 >= yyvsc32 or yyvs32 = Void or yyspecial_routines32 = Void then
		if yyvs32 = Void or yyspecial_routines32 = Void then
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
	yyspecial_routines32.force (yyvs32, yyval32, yyvsp32)
end
		end

	yy_do_action_434
			--|#line <not available> "eiffel.y"
		local
			yyval32: detachable BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval32 := ast_factory.new_bin_mod_as (yyvs48.item (yyvsp48 - 1), yyvs48.item (yyvsp48), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp32 := yyvsp32 + 1
	yyvsp48 := yyvsp48 -2
	yyvsp4 := yyvsp4 -1
	if yyvsp32 >= yyvsc32 or yyvs32 = Void or yyspecial_routines32 = Void then
		if yyvs32 = Void or yyspecial_routines32 = Void then
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
	yyspecial_routines32.force (yyvs32, yyval32, yyvsp32)
end
		end

	yy_do_action_435
			--|#line <not available> "eiffel.y"
		local
			yyval32: detachable BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval32 := ast_factory.new_bin_div_as (yyvs48.item (yyvsp48 - 1), yyvs48.item (yyvsp48), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp32 := yyvsp32 + 1
	yyvsp48 := yyvsp48 -2
	yyvsp4 := yyvsp4 -1
	if yyvsp32 >= yyvsc32 or yyvs32 = Void or yyspecial_routines32 = Void then
		if yyvs32 = Void or yyspecial_routines32 = Void then
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
	yyspecial_routines32.force (yyvs32, yyval32, yyvsp32)
end
		end

	yy_do_action_436
			--|#line <not available> "eiffel.y"
		local
			yyval32: detachable BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval32 := ast_factory.new_bin_power_as (yyvs48.item (yyvsp48 - 1), yyvs48.item (yyvsp48), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp32 := yyvsp32 + 1
	yyvsp48 := yyvsp48 -2
	yyvsp4 := yyvsp4 -1
	if yyvsp32 >= yyvsc32 or yyvs32 = Void or yyspecial_routines32 = Void then
		if yyvs32 = Void or yyspecial_routines32 = Void then
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
	yyspecial_routines32.force (yyvs32, yyval32, yyvsp32)
end
		end

	yy_do_action_437
			--|#line <not available> "eiffel.y"
		local
			yyval32: detachable BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval32 := ast_factory.new_bin_and_as (yyvs48.item (yyvsp48 - 1), yyvs48.item (yyvsp48), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp32 := yyvsp32 + 1
	yyvsp48 := yyvsp48 -2
	yyvsp12 := yyvsp12 -1
	if yyvsp32 >= yyvsc32 or yyvs32 = Void or yyspecial_routines32 = Void then
		if yyvs32 = Void or yyspecial_routines32 = Void then
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
	yyspecial_routines32.force (yyvs32, yyval32, yyvsp32)
end
		end

	yy_do_action_438
			--|#line <not available> "eiffel.y"
		local
			yyval32: detachable BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval32 := ast_factory.new_bin_and_then_as (yyvs48.item (yyvsp48 - 1), yyvs48.item (yyvsp48), yyvs12.item (yyvsp12 - 1), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp32 := yyvsp32 + 1
	yyvsp48 := yyvsp48 -2
	yyvsp12 := yyvsp12 -2
	if yyvsp32 >= yyvsc32 or yyvs32 = Void or yyspecial_routines32 = Void then
		if yyvs32 = Void or yyspecial_routines32 = Void then
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
	yyspecial_routines32.force (yyvs32, yyval32, yyvsp32)
end
		end

	yy_do_action_439
			--|#line <not available> "eiffel.y"
		local
			yyval32: detachable BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval32 := ast_factory.new_bin_or_as (yyvs48.item (yyvsp48 - 1), yyvs48.item (yyvsp48), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp32 := yyvsp32 + 1
	yyvsp48 := yyvsp48 -2
	yyvsp12 := yyvsp12 -1
	if yyvsp32 >= yyvsc32 or yyvs32 = Void or yyspecial_routines32 = Void then
		if yyvs32 = Void or yyspecial_routines32 = Void then
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
	yyspecial_routines32.force (yyvs32, yyval32, yyvsp32)
end
		end

	yy_do_action_440
			--|#line <not available> "eiffel.y"
		local
			yyval32: detachable BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval32 := ast_factory.new_bin_or_else_as (yyvs48.item (yyvsp48 - 1), yyvs48.item (yyvsp48),yyvs12.item (yyvsp12 - 1), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp32 := yyvsp32 + 1
	yyvsp48 := yyvsp48 -2
	yyvsp12 := yyvsp12 -2
	if yyvsp32 >= yyvsc32 or yyvs32 = Void or yyspecial_routines32 = Void then
		if yyvs32 = Void or yyspecial_routines32 = Void then
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
	yyspecial_routines32.force (yyvs32, yyval32, yyvsp32)
end
		end

	yy_do_action_441
			--|#line <not available> "eiffel.y"
		local
			yyval32: detachable BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval32 := ast_factory.new_bin_implies_as (yyvs48.item (yyvsp48 - 1), yyvs48.item (yyvsp48), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp32 := yyvsp32 + 1
	yyvsp48 := yyvsp48 -2
	yyvsp12 := yyvsp12 -1
	if yyvsp32 >= yyvsc32 or yyvs32 = Void or yyspecial_routines32 = Void then
		if yyvs32 = Void or yyspecial_routines32 = Void then
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
	yyspecial_routines32.force (yyvs32, yyval32, yyvsp32)
end
		end

	yy_do_action_442
			--|#line <not available> "eiffel.y"
		local
			yyval32: detachable BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval32 := ast_factory.new_bin_xor_as (yyvs48.item (yyvsp48 - 1), yyvs48.item (yyvsp48), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp32 := yyvsp32 + 1
	yyvsp48 := yyvsp48 -2
	yyvsp12 := yyvsp12 -1
	if yyvsp32 >= yyvsc32 or yyvs32 = Void or yyspecial_routines32 = Void then
		if yyvs32 = Void or yyspecial_routines32 = Void then
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
	yyspecial_routines32.force (yyvs32, yyval32, yyvsp32)
end
		end

	yy_do_action_443
			--|#line <not available> "eiffel.y"
		local
			yyval32: detachable BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval32 := ast_factory.new_bin_ge_as (yyvs48.item (yyvsp48 - 1), yyvs48.item (yyvsp48), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp32 := yyvsp32 + 1
	yyvsp48 := yyvsp48 -2
	yyvsp4 := yyvsp4 -1
	if yyvsp32 >= yyvsc32 or yyvs32 = Void or yyspecial_routines32 = Void then
		if yyvs32 = Void or yyspecial_routines32 = Void then
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
	yyspecial_routines32.force (yyvs32, yyval32, yyvsp32)
end
		end

	yy_do_action_444
			--|#line <not available> "eiffel.y"
		local
			yyval32: detachable BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval32 := ast_factory.new_bin_gt_as (yyvs48.item (yyvsp48 - 1), yyvs48.item (yyvsp48), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp32 := yyvsp32 + 1
	yyvsp48 := yyvsp48 -2
	yyvsp4 := yyvsp4 -1
	if yyvsp32 >= yyvsc32 or yyvs32 = Void or yyspecial_routines32 = Void then
		if yyvs32 = Void or yyspecial_routines32 = Void then
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
	yyspecial_routines32.force (yyvs32, yyval32, yyvsp32)
end
		end

	yy_do_action_445
			--|#line <not available> "eiffel.y"
		local
			yyval32: detachable BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval32 := ast_factory.new_bin_le_as (yyvs48.item (yyvsp48 - 1), yyvs48.item (yyvsp48), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp32 := yyvsp32 + 1
	yyvsp48 := yyvsp48 -2
	yyvsp4 := yyvsp4 -1
	if yyvsp32 >= yyvsc32 or yyvs32 = Void or yyspecial_routines32 = Void then
		if yyvs32 = Void or yyspecial_routines32 = Void then
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
	yyspecial_routines32.force (yyvs32, yyval32, yyvsp32)
end
		end

	yy_do_action_446
			--|#line <not available> "eiffel.y"
		local
			yyval32: detachable BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval32 := ast_factory.new_bin_lt_as (yyvs48.item (yyvsp48 - 1), yyvs48.item (yyvsp48), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp32 := yyvsp32 + 1
	yyvsp48 := yyvsp48 -2
	yyvsp4 := yyvsp4 -1
	if yyvsp32 >= yyvsc32 or yyvs32 = Void or yyspecial_routines32 = Void then
		if yyvs32 = Void or yyspecial_routines32 = Void then
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
	yyspecial_routines32.force (yyvs32, yyval32, yyvsp32)
end
		end

	yy_do_action_447
			--|#line <not available> "eiffel.y"
		local
			yyval32: detachable BINARY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval32 := ast_factory.new_bin_free_as (yyvs48.item (yyvsp48 - 1), yyvs2.item (yyvsp2), yyvs48.item (yyvsp48)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp32 := yyvsp32 + 1
	yyvsp48 := yyvsp48 -2
	yyvsp2 := yyvsp2 -1
	if yyvsp32 >= yyvsc32 or yyvs32 = Void or yyspecial_routines32 = Void then
		if yyvs32 = Void or yyspecial_routines32 = Void then
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
	yyspecial_routines32.force (yyvs32, yyval32, yyvsp32)
end
		end

	yy_do_action_448
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := yyvs11.item (yyvsp11); has_type := True 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp48 := yyvsp48 + 1
	yyvsp11 := yyvsp11 -1
	if yyvsp48 >= yyvsc48 or yyvs48 = Void or yyspecial_routines48 = Void then
		if yyvs48 = Void or yyspecial_routines48 = Void then
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
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_449
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := yyvs28.item (yyvsp28); has_type := True 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp48 := yyvsp48 + 1
	yyvsp28 := yyvsp28 -1
	if yyvsp48 >= yyvsc48 or yyvs48 = Void or yyspecial_routines48 = Void then
		if yyvs48 = Void or yyspecial_routines48 = Void then
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
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_450
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := yyvs78.item (yyvsp78); has_type := False 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp48 := yyvsp48 + 1
	yyvsp78 := yyvsp78 -1
	if yyvsp48 >= yyvsc48 or yyvs48 = Void or yyspecial_routines48 = Void then
		if yyvs48 = Void or yyspecial_routines48 = Void then
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
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_451
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines48 /= Void
			yyvs48 /= Void
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := ast_factory.new_un_old_as (yyvs48.item (yyvsp48), yyvs12.item (yyvsp12)); has_type := True 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp12 := yyvsp12 -1
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_452
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval48 := ast_factory.new_un_strip_as (yyvs21.item (yyvsp21), yyvs12.item (yyvsp12), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)); has_type := True
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp48 := yyvsp48 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp4 := yyvsp4 -2
	yyvsp21 := yyvsp21 -1
	if yyvsp48 >= yyvsc48 or yyvs48 = Void or yyspecial_routines48 = Void then
		if yyvs48 = Void or yyspecial_routines48 = Void then
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
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_453
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := ast_factory.new_address_as (yyvs86.item (yyvsp86), yyvs4.item (yyvsp4)); has_type := True 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp48 := yyvsp48 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp86 := yyvsp86 -1
	if yyvsp48 >= yyvsc48 or yyvs48 = Void or yyspecial_routines48 = Void then
		if yyvs48 = Void or yyspecial_routines48 = Void then
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
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_454
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines48 /= Void
			yyvs48 /= Void
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval48 := ast_factory.new_expr_address_as (yyvs48.item (yyvsp48), yyvs4.item (yyvsp4 - 2), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)); has_type := True
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp4 := yyvsp4 -3
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_455
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval48 := ast_factory.new_address_current_as (yyvs9.item (yyvsp9), yyvs4.item (yyvsp4)); has_type := True
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp48 := yyvsp48 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp9 := yyvsp9 -1
	if yyvsp48 >= yyvsc48 or yyvs48 = Void or yyspecial_routines48 = Void then
		if yyvs48 = Void or yyspecial_routines48 = Void then
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
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_456
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval48 := ast_factory.new_address_result_as (yyvs6.item (yyvsp6), yyvs4.item (yyvsp4)); has_type := True
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp48 := yyvsp48 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp6 := yyvsp6 -1
	if yyvsp48 >= yyvsc48 or yyvs48 = Void or yyspecial_routines48 = Void then
		if yyvs48 = Void or yyspecial_routines48 = Void then
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
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_457
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines48 /= Void
			yyvs48 /= Void
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := yyvs48.item (yyvsp48) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_458
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines48 /= Void
			yyvs48 /= Void
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := yyvs48.item (yyvsp48); has_type := True 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_459
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines48 /= Void
			yyvs48 /= Void
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := ast_factory.new_bracket_as (yyvs48.item (yyvsp48), yyvs94.item (yyvsp94), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 6
	yyvsp4 := yyvsp4 -2
	yyvsp1 := yyvsp1 -2
	yyvsp94 := yyvsp94 -1
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_460
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines48 /= Void
			yyvs48 /= Void
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := ast_factory.new_un_minus_as (yyvs48.item (yyvsp48), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_461
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines48 /= Void
			yyvs48 /= Void
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := ast_factory.new_un_plus_as (yyvs48.item (yyvsp48), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp4 := yyvsp4 -1
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_462
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines48 /= Void
			yyvs48 /= Void
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := ast_factory.new_un_not_as (yyvs48.item (yyvsp48), yyvs12.item (yyvsp12)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp12 := yyvsp12 -1
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_463
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines48 /= Void
			yyvs48 /= Void
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := ast_factory.new_un_free_as (yyvs2.item (yyvsp2), yyvs48.item (yyvsp48)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp2 := yyvsp2 -1
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_464
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := ast_factory.new_type_expr_as (yyvs81.item (yyvsp81)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp48 := yyvsp48 + 1
	yyvsp81 := yyvsp81 -1
	if yyvsp48 >= yyvsc48 or yyvs48 = Void or yyspecial_routines48 = Void then
		if yyvs48 = Void or yyspecial_routines48 = Void then
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
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_465
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := yyvs61.item (yyvsp61) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp48 := yyvsp48 + 1
	yyvsp61 := yyvsp61 -1
	if yyvsp48 >= yyvsc48 or yyvs48 = Void or yyspecial_routines48 = Void then
		if yyvs48 = Void or yyspecial_routines48 = Void then
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
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_466
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := yyvs72.item (yyvsp72) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp48 := yyvsp48 + 1
	yyvsp72 := yyvsp72 -1
	if yyvsp48 >= yyvsc48 or yyvs48 = Void or yyspecial_routines48 = Void then
		if yyvs48 = Void or yyspecial_routines48 = Void then
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
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_467
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines2 /= Void
			yyvs2 /= Void
		local
			yyval2: detachable ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs2.item (yyvsp2) as l_free then
					l_free.to_lower
				end
				yyval2 := yyvs2.item (yyvsp2)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
		end

	yy_do_action_468
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines35 /= Void
			yyvs35 /= Void
		local
			yyval35: detachable CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval35 := ast_factory.new_nested_as (yyvs9.item (yyvsp9), yyvs35.item (yyvsp35), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp9 := yyvsp9 -1
	yyvsp4 := yyvsp4 -1
	yyspecial_routines35.force (yyvs35, yyval35, yyvsp35)
end
		end

	yy_do_action_469
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines35 /= Void
			yyvs35 /= Void
		local
			yyval35: detachable CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval35 := ast_factory.new_nested_as (yyvs6.item (yyvsp6), yyvs35.item (yyvsp35), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp6 := yyvsp6 -1
	yyvsp4 := yyvsp4 -1
	yyspecial_routines35.force (yyvs35, yyval35, yyvsp35)
end
		end

	yy_do_action_470
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines35 /= Void
			yyvs35 /= Void
		local
			yyval35: detachable CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval35 := ast_factory.new_nested_as (yyvs25.item (yyvsp25), yyvs35.item (yyvsp35), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp25 := yyvsp25 -1
	yyvsp4 := yyvsp4 -1
	yyspecial_routines35.force (yyvs35, yyval35, yyvsp35)
end
		end

	yy_do_action_471
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines35 /= Void
			yyvs35 /= Void
		local
			yyval35: detachable CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval35 := ast_factory.new_nested_expr_as (yyvs48.item (yyvsp48), yyvs35.item (yyvsp35), yyvs4.item (yyvsp4), yyvs4.item (yyvsp4 - 2), yyvs4.item (yyvsp4 - 1)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp4 := yyvsp4 -3
	yyvsp48 := yyvsp48 -1
	yyspecial_routines35.force (yyvs35, yyval35, yyvsp35)
end
		end

	yy_do_action_472
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines35 /= Void
			yyvs35 /= Void
		local
			yyval35: detachable CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval35 := ast_factory.new_nested_expr_as (ast_factory.new_bracket_as (yyvs48.item (yyvsp48), yyvs94.item (yyvsp94), yyvs4.item (yyvsp4 - 2), yyvs4.item (yyvsp4 - 1)), yyvs35.item (yyvsp35), yyvs4.item (yyvsp4), Void, Void) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 8
	yyvsp48 := yyvsp48 -1
	yyvsp4 := yyvsp4 -3
	yyvsp1 := yyvsp1 -2
	yyvsp94 := yyvsp94 -1
	yyspecial_routines35.force (yyvs35, yyval35, yyvsp35)
end
		end

	yy_do_action_473
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines35 /= Void
			yyvs35 /= Void
		local
			yyval35: detachable CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval35 := ast_factory.new_nested_as (yyvs70.item (yyvsp70), yyvs35.item (yyvsp35), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp70 := yyvsp70 -1
	yyvsp4 := yyvsp4 -1
	yyspecial_routines35.force (yyvs35, yyval35, yyvsp35)
end
		end

	yy_do_action_474
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines35 /= Void
			yyvs35 /= Void
		local
			yyval35: detachable CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval35 := ast_factory.new_nested_as (yyvs71.item (yyvsp71), yyvs35.item (yyvsp35), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp71 := yyvsp71 -1
	yyvsp4 := yyvsp4 -1
	yyspecial_routines35.force (yyvs35, yyval35, yyvsp35)
end
		end

	yy_do_action_475
			--|#line <not available> "eiffel.y"
		local
			yyval70: detachable PRECURSOR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval70 := ast_factory.new_precursor_as (yyvs12.item (yyvsp12), Void, yyvs95.item (yyvsp95)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp70 := yyvsp70 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp95 := yyvsp95 -1
	if yyvsp70 >= yyvsc70 or yyvs70 = Void or yyspecial_routines70 = Void then
		if yyvs70 = Void or yyspecial_routines70 = Void then
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
	yyspecial_routines70.force (yyvs70, yyval70, yyvsp70)
end
		end

	yy_do_action_476
			--|#line <not available> "eiffel.y"
		local
			yyval70: detachable PRECURSOR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached ast_factory.new_class_type_as (yyvs2.item (yyvsp2), Void) as l_temp_class_type_as then
					l_temp_class_type_as.set_lcurly_symbol (yyvs4.item (yyvsp4 - 1))
					l_temp_class_type_as.set_rcurly_symbol (yyvs4.item (yyvsp4))
					yyval70 := ast_factory.new_precursor_as (yyvs12.item (yyvsp12), l_temp_class_type_as, yyvs95.item (yyvsp95))
				else
					yyval70 := ast_factory.new_precursor_as (yyvs12.item (yyvsp12), Void, yyvs95.item (yyvsp95))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp70 := yyvsp70 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp4 := yyvsp4 -2
	yyvsp2 := yyvsp2 -1
	yyvsp95 := yyvsp95 -1
	if yyvsp70 >= yyvsc70 or yyvs70 = Void or yyspecial_routines70 = Void then
		if yyvs70 = Void or yyspecial_routines70 = Void then
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
	yyspecial_routines70.force (yyvs70, yyval70, yyvsp70)
end
		end

	yy_do_action_477
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines71 /= Void
			yyvs71 /= Void
		local
			yyval71: detachable STATIC_ACCESS_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval71 := yyvs71.item (yyvsp71) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines71.force (yyvs71, yyval71, yyvsp71)
end
		end

	yy_do_action_478
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines71 /= Void
			yyvs71 /= Void
		local
			yyval71: detachable STATIC_ACCESS_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval71 := yyvs71.item (yyvsp71) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines71.force (yyvs71, yyval71, yyvsp71)
end
		end

	yy_do_action_479
			--|#line <not available> "eiffel.y"
		local
			yyval71: detachable STATIC_ACCESS_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval71 := ast_factory.new_static_access_as (yyvs81.item (yyvsp81), yyvs2.item (yyvsp2), yyvs95.item (yyvsp95), Void, yyvs4.item (yyvsp4)); 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp71 := yyvsp71 + 1
	yyvsp81 := yyvsp81 -1
	yyvsp4 := yyvsp4 -1
	yyvsp2 := yyvsp2 -1
	yyvsp95 := yyvsp95 -1
	if yyvsp71 >= yyvsc71 or yyvs71 = Void or yyspecial_routines71 = Void then
		if yyvs71 = Void or yyspecial_routines71 = Void then
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
	yyspecial_routines71.force (yyvs71, yyval71, yyvsp71)
end
		end

	yy_do_action_480
			--|#line <not available> "eiffel.y"
		local
			yyval71: detachable STATIC_ACCESS_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval71 := ast_factory.new_static_access_as (yyvs81.item (yyvsp81), yyvs2.item (yyvsp2), yyvs95.item (yyvsp95), yyvs12.item (yyvsp12), yyvs4.item (yyvsp4));
				if has_syntax_warning then
					report_one_warning (
						create {SYNTAX_WARNING}.make (token_line (yyvs12.item (yyvsp12)), token_column (yyvs12.item (yyvsp12)),
							filename, once "Remove the `feature' keyword."))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp71 := yyvsp71 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp81 := yyvsp81 -1
	yyvsp4 := yyvsp4 -1
	yyvsp2 := yyvsp2 -1
	yyvsp95 := yyvsp95 -1
	if yyvsp71 >= yyvsc71 or yyvs71 = Void or yyspecial_routines71 = Void then
		if yyvs71 = Void or yyspecial_routines71 = Void then
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
	yyspecial_routines71.force (yyvs71, yyval71, yyvsp71)
end
		end

	yy_do_action_481
			--|#line <not available> "eiffel.y"
		local
			yyval35: detachable CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval35 := yyvs67.item (yyvsp67) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp35 := yyvsp35 + 1
	yyvsp67 := yyvsp67 -1
	if yyvsp35 >= yyvsc35 or yyvs35 = Void or yyspecial_routines35 = Void then
		if yyvs35 = Void or yyspecial_routines35 = Void then
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
	yyspecial_routines35.force (yyvs35, yyval35, yyvsp35)
end
		end

	yy_do_action_482
			--|#line <not available> "eiffel.y"
		local
			yyval35: detachable CALL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval35 := yyvs26.item (yyvsp26) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp35 := yyvsp35 + 1
	yyvsp26 := yyvsp26 -1
	if yyvsp35 >= yyvsc35 or yyvs35 = Void or yyspecial_routines35 = Void then
		if yyvs35 = Void or yyspecial_routines35 = Void then
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
	yyspecial_routines35.force (yyvs35, yyval35, yyvsp35)
end
		end

	yy_do_action_483
			--|#line <not available> "eiffel.y"
		local
			yyval67: detachable NESTED_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval67 := ast_factory.new_nested_as (yyvs26.item (yyvsp26 - 1), yyvs26.item (yyvsp26), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp67 := yyvsp67 + 1
	yyvsp26 := yyvsp26 -2
	yyvsp4 := yyvsp4 -1
	if yyvsp67 >= yyvsc67 or yyvs67 = Void or yyspecial_routines67 = Void then
		if yyvs67 = Void or yyspecial_routines67 = Void then
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
	yyspecial_routines67.force (yyvs67, yyval67, yyvsp67)
end
		end

	yy_do_action_484
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines67 /= Void
			yyvs67 /= Void
		local
			yyval67: detachable NESTED_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval67 := ast_factory.new_nested_as (yyvs26.item (yyvsp26), yyvs67.item (yyvsp67), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp26 := yyvsp26 -1
	yyvsp4 := yyvsp4 -1
	yyspecial_routines67.force (yyvs67, yyval67, yyvsp67)
end
		end

	yy_do_action_485
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines2 /= Void
			yyvs2 /= Void
		local
			yyval2: detachable ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval2 := yyvs2.item (yyvsp2)
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
		end

	yy_do_action_486
			--|#line <not available> "eiffel.y"
		local
			yyval2: detachable ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs86.item (yyvsp86) as l_infix then
					yyval2 := l_infix.internal_name
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp2 := yyvsp2 + 1
	yyvsp86 := yyvsp86 -1
	if yyvsp2 >= yyvsc2 or yyvs2 = Void or yyspecial_routines2 = Void then
		if yyvs2 = Void or yyspecial_routines2 = Void then
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
		end

	yy_do_action_487
			--|#line <not available> "eiffel.y"
		local
			yyval2: detachable ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs86.item (yyvsp86) as l_prefix then
					yyval2 := l_prefix.internal_name
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp2 := yyvsp2 + 1
	yyvsp86 := yyvsp86 -1
	if yyvsp2 >= yyvsc2 or yyvs2 = Void or yyspecial_routines2 = Void then
		if yyvs2 = Void or yyspecial_routines2 = Void then
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
		end

	yy_do_action_488
			--|#line <not available> "eiffel.y"
		local
			yyval25: detachable ACCESS_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				inspect id_level
				when Normal_level then
					yyval25 := ast_factory.new_access_id_as (yyvs2.item (yyvsp2), yyvs95.item (yyvsp95))
				when Assert_level then
					yyval25 := ast_factory.new_access_assert_as (yyvs2.item (yyvsp2), yyvs95.item (yyvsp95))
				when Invariant_level then
					yyval25 := ast_factory.new_access_inv_as (yyvs2.item (yyvsp2), yyvs95.item (yyvsp95), Void)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp25 := yyvsp25 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp95 := yyvsp95 -1
	if yyvsp25 >= yyvsc25 or yyvs25 = Void or yyspecial_routines25 = Void then
		if yyvs25 = Void or yyspecial_routines25 = Void then
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
	yyspecial_routines25.force (yyvs25, yyval25, yyvsp25)
end
		end

	yy_do_action_489
			--|#line <not available> "eiffel.y"
		local
			yyval26: detachable ACCESS_FEAT_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval26 := ast_factory.new_access_feat_as (yyvs2.item (yyvsp2), yyvs95.item (yyvsp95)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp26 := yyvsp26 + 1
	yyvsp2 := yyvsp2 -1
	yyvsp95 := yyvsp95 -1
	if yyvsp26 >= yyvsc26 or yyvs26 = Void or yyspecial_routines26 = Void then
		if yyvs26 = Void or yyspecial_routines26 = Void then
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
	yyspecial_routines26.force (yyvs26, yyval26, yyvsp26)
end
		end

	yy_do_action_490
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := yyvs31.item (yyvsp31); has_type := True 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp48 := yyvsp48 + 1
	yyvsp31 := yyvsp31 -1
	if yyvsp48 >= yyvsc48 or yyvs48 = Void or yyspecial_routines48 = Void then
		if yyvs48 = Void or yyspecial_routines48 = Void then
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
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_491
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines48 /= Void
			yyvs48 /= Void
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := yyvs48.item (yyvsp48); has_type := True 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_492
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := yyvs80.item (yyvsp80); has_type := True 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp48 := yyvsp48 + 1
	yyvsp80 := yyvsp80 -1
	if yyvsp48 >= yyvsc48 or yyvs48 = Void or yyspecial_routines48 = Void then
		if yyvs48 = Void or yyspecial_routines48 = Void then
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
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_493
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := ast_factory.new_expr_call_as (yyvs9.item (yyvsp9)); has_type := True 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp48 := yyvsp48 + 1
	yyvsp9 := yyvsp9 -1
	if yyvsp48 >= yyvsc48 or yyvs48 = Void or yyspecial_routines48 = Void then
		if yyvs48 = Void or yyspecial_routines48 = Void then
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
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_494
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := ast_factory.new_expr_call_as (yyvs6.item (yyvsp6)); has_type := True 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp48 := yyvsp48 + 1
	yyvsp6 := yyvsp6 -1
	if yyvsp48 >= yyvsc48 or yyvs48 = Void or yyspecial_routines48 = Void then
		if yyvs48 = Void or yyspecial_routines48 = Void then
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
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_495
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := ast_factory.new_expr_call_as (yyvs35.item (yyvsp35)); has_type := False 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp48 := yyvsp48 + 1
	yyvsp35 := yyvsp35 -1
	if yyvsp48 >= yyvsc48 or yyvs48 = Void or yyspecial_routines48 = Void then
		if yyvs48 = Void or yyspecial_routines48 = Void then
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
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_496
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := ast_factory.new_expr_call_as (yyvs43.item (yyvsp43)); has_type := True 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp48 := yyvsp48 + 1
	yyvsp43 := yyvsp43 -1
	if yyvsp48 >= yyvsc48 or yyvs48 = Void or yyspecial_routines48 = Void then
		if yyvs48 = Void or yyspecial_routines48 = Void then
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
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_497
			--|#line <not available> "eiffel.y"
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := yyvs65.item (yyvsp65) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp48 := yyvsp48 + 1
	yyvsp65 := yyvsp65 -1
	if yyvsp48 >= yyvsc48 or yyvs48 = Void or yyspecial_routines48 = Void then
		if yyvs48 = Void or yyspecial_routines48 = Void then
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
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_498
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines48 /= Void
			yyvs48 /= Void
		local
			yyval48: detachable EXPR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval48 := ast_factory.new_paran_as (yyvs48.item (yyvsp48), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)); has_type := True 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp4 := yyvsp4 -2
	yyspecial_routines48.force (yyvs48, yyval48, yyvsp48)
end
		end

	yy_do_action_499
			--|#line <not available> "eiffel.y"
		local
			yyval95: detachable PARAMETER_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end


if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp95 := yyvsp95 + 1
	if yyvsp95 >= yyvsc95 or yyvs95 = Void or yyspecial_routines95 = Void then
		if yyvs95 = Void or yyspecial_routines95 = Void then
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
	yyspecial_routines95.force (yyvs95, yyval95, yyvsp95)
end
		end

	yy_do_action_500
			--|#line <not available> "eiffel.y"
		local
			yyval95: detachable PARAMETER_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval95 := ast_factory.new_parameter_list_as (Void, yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp95 := yyvsp95 + 1
	yyvsp4 := yyvsp4 -2
	if yyvsp95 >= yyvsc95 or yyvs95 = Void or yyspecial_routines95 = Void then
		if yyvs95 = Void or yyspecial_routines95 = Void then
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
	yyspecial_routines95.force (yyvs95, yyval95, yyvsp95)
end
		end

	yy_do_action_501
			--|#line <not available> "eiffel.y"
		local
			yyval95: detachable PARAMETER_LIST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval95 := ast_factory.new_parameter_list_as (yyvs94.item (yyvsp94), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp95 := yyvsp95 + 1
	yyvsp4 := yyvsp4 -2
	yyvsp1 := yyvsp1 -2
	yyvsp94 := yyvsp94 -1
	if yyvsp95 >= yyvsc95 or yyvs95 = Void or yyspecial_routines95 = Void then
		if yyvs95 = Void or yyspecial_routines95 = Void then
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
	yyspecial_routines95.force (yyvs95, yyval95, yyvsp95)
end
		end

	yy_do_action_502
			--|#line <not available> "eiffel.y"
		local
			yyval94: detachable EIFFEL_LIST [EXPR_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval94 := ast_factory.new_eiffel_list_expr_as (counter_value + 1)
				if attached yyval94 as l_list and then attached yyvs48.item (yyvsp48) as l_val then
					l_list.reverse_extend (l_val)
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp94 := yyvsp94 + 1
	yyvsp48 := yyvsp48 -1
	if yyvsp94 >= yyvsc94 or yyvs94 = Void or yyspecial_routines94 = Void then
		if yyvs94 = Void or yyspecial_routines94 = Void then
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
	yyspecial_routines94.force (yyvs94, yyval94, yyvsp94)
end
		end

	yy_do_action_503
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines94 /= Void
			yyvs94 /= Void
		local
			yyval94: detachable EIFFEL_LIST [EXPR_AS]
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval94 := yyvs94.item (yyvsp94)
				if attached yyval94 as l_list and then attached yyvs48.item (yyvsp48) as l_val then
					l_list.reverse_extend (l_val)
					ast_factory.reverse_extend_separator (l_list, yyvs4.item (yyvsp4))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 4
	yyvsp48 := yyvsp48 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	yyspecial_routines94.force (yyvs94, yyval94, yyvsp94)
end
		end

	yy_do_action_504
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines2 /= Void
			yyvs2 /= Void
		local
			yyval2: detachable ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval2 := yyvs2.item (yyvsp2)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
		end

	yy_do_action_505
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines2 /= Void
			yyvs2 /= Void
		local
			yyval2: detachable ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval2 := yyvs2.item (yyvsp2);
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
		end

	yy_do_action_506
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines2 /= Void
			yyvs2 /= Void
		local
			yyval2: detachable ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs2.item (yyvsp2) as l_id then
					l_id.to_upper		
					yyval2 := l_id
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
		end

	yy_do_action_507
			--|#line <not available> "eiffel.y"
		local
			yyval2: detachable ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Keyword used as identifier
				yyval2 := extract_id (yyvs15.item (yyvsp15))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp2 := yyvsp2 + 1
	yyvsp15 := yyvsp15 -1
	if yyvsp2 >= yyvsc2 or yyvs2 = Void or yyspecial_routines2 = Void then
		if yyvs2 = Void or yyspecial_routines2 = Void then
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
		end

	yy_do_action_508
			--|#line <not available> "eiffel.y"
		local
			yyval2: detachable ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Keyword used as identifier
				yyval2 := extract_id (yyvs15.item (yyvsp15))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp2 := yyvsp2 + 1
	yyvsp15 := yyvsp15 -1
	if yyvsp2 >= yyvsc2 or yyvs2 = Void or yyspecial_routines2 = Void then
		if yyvs2 = Void or yyspecial_routines2 = Void then
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
		end

	yy_do_action_509
			--|#line <not available> "eiffel.y"
		local
			yyval2: detachable ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Keyword used as identifier
				yyval2 := extract_id (yyvs15.item (yyvsp15))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp2 := yyvsp2 + 1
	yyvsp15 := yyvsp15 -1
	if yyvsp2 >= yyvsc2 or yyvs2 = Void or yyspecial_routines2 = Void then
		if yyvs2 = Void or yyspecial_routines2 = Void then
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
		end

	yy_do_action_510
			--|#line <not available> "eiffel.y"
		local
			yyval2: detachable ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Keyword used as identifier
				yyval2 := extract_id (yyvs15.item (yyvsp15))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp2 := yyvsp2 + 1
	yyvsp15 := yyvsp15 -1
	if yyvsp2 >= yyvsc2 or yyvs2 = Void or yyspecial_routines2 = Void then
		if yyvs2 = Void or yyspecial_routines2 = Void then
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
		end

	yy_do_action_511
			--|#line <not available> "eiffel.y"
		local
			yyval2: detachable ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Keyword used as identifier
				yyval2 := extract_id (yyvs15.item (yyvsp15))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp2 := yyvsp2 + 1
	yyvsp15 := yyvsp15 -1
	if yyvsp2 >= yyvsc2 or yyvs2 = Void or yyspecial_routines2 = Void then
		if yyvs2 = Void or yyspecial_routines2 = Void then
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
		end

	yy_do_action_512
			--|#line <not available> "eiffel.y"
		local
			yyval2: detachable ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Keyword used as identifier
				yyval2 := extract_id (yyvs15.item (yyvsp15))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp2 := yyvsp2 + 1
	yyvsp15 := yyvsp15 -1
	if yyvsp2 >= yyvsc2 or yyvs2 = Void or yyspecial_routines2 = Void then
		if yyvs2 = Void or yyspecial_routines2 = Void then
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
		end

	yy_do_action_513
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines2 /= Void
			yyvs2 /= Void
		local
			yyval2: detachable ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs2.item (yyvsp2) as l_tuple then
					l_tuple.to_upper
					yyval2 := l_tuple
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
		end

	yy_do_action_514
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines2 /= Void
			yyvs2 /= Void
		local
			yyval2: detachable ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs2.item (yyvsp2) as l_id then
					l_id.to_lower
					yyval2 := l_id
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
		end

	yy_do_action_515
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines2 /= Void
			yyvs2 /= Void
		local
			yyval2: detachable ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs2.item (yyvsp2) as l_tuple then
					l_tuple.to_lower
					yyval2 := l_tuple
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines2.force (yyvs2, yyval2, yyvsp2)
end
		end

	yy_do_action_516
			--|#line <not available> "eiffel.y"
		local
			yyval2: detachable ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Keyword used as identifier
				yyval2 := extract_id (yyvs15.item (yyvsp15))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp2 := yyvsp2 + 1
	yyvsp15 := yyvsp15 -1
	if yyvsp2 >= yyvsc2 or yyvs2 = Void or yyspecial_routines2 = Void then
		if yyvs2 = Void or yyspecial_routines2 = Void then
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
		end

	yy_do_action_517
			--|#line <not available> "eiffel.y"
		local
			yyval2: detachable ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Keyword used as identifier
				yyval2 := extract_id (yyvs15.item (yyvsp15))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp2 := yyvsp2 + 1
	yyvsp15 := yyvsp15 -1
	if yyvsp2 >= yyvsc2 or yyvs2 = Void or yyspecial_routines2 = Void then
		if yyvs2 = Void or yyspecial_routines2 = Void then
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
		end

	yy_do_action_518
			--|#line <not available> "eiffel.y"
		local
			yyval2: detachable ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Keyword used as identifier
				yyval2 := extract_id (yyvs15.item (yyvsp15))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp2 := yyvsp2 + 1
	yyvsp15 := yyvsp15 -1
	if yyvsp2 >= yyvsc2 or yyvs2 = Void or yyspecial_routines2 = Void then
		if yyvs2 = Void or yyspecial_routines2 = Void then
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
		end

	yy_do_action_519
			--|#line <not available> "eiffel.y"
		local
			yyval2: detachable ID_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Keyword used as identifier
				yyval2 := extract_id (yyvs15.item (yyvsp15))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp2 := yyvsp2 + 1
	yyvsp15 := yyvsp15 -1
	if yyvsp2 >= yyvsc2 or yyvs2 = Void or yyspecial_routines2 = Void then
		if yyvs2 = Void or yyspecial_routines2 = Void then
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
		end

	yy_do_action_520
			--|#line <not available> "eiffel.y"
		local
			yyval31: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval31 := yyvs5.item (yyvsp5) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp31 := yyvsp31 + 1
	yyvsp5 := yyvsp5 -1
	if yyvsp31 >= yyvsc31 or yyvs31 = Void or yyspecial_routines31 = Void then
		if yyvs31 = Void or yyspecial_routines31 = Void then
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
	yyspecial_routines31.force (yyvs31, yyval31, yyvsp31)
end
		end

	yy_do_action_521
			--|#line <not available> "eiffel.y"
		local
			yyval31: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval31 := yyvs3.item (yyvsp3) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp31 := yyvsp31 + 1
	yyvsp3 := yyvsp3 -1
	if yyvsp31 >= yyvsc31 or yyvs31 = Void or yyspecial_routines31 = Void then
		if yyvs31 = Void or yyspecial_routines31 = Void then
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
	yyspecial_routines31.force (yyvs31, yyval31, yyvsp31)
end
		end

	yy_do_action_522
			--|#line <not available> "eiffel.y"
		local
			yyval31: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval31 := yyvs61.item (yyvsp61) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp31 := yyvsp31 + 1
	yyvsp61 := yyvsp61 -1
	if yyvsp31 >= yyvsc31 or yyvs31 = Void or yyspecial_routines31 = Void then
		if yyvs31 = Void or yyspecial_routines31 = Void then
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
	yyspecial_routines31.force (yyvs31, yyval31, yyvsp31)
end
		end

	yy_do_action_523
			--|#line <not available> "eiffel.y"
		local
			yyval31: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval31 := yyvs61.item (yyvsp61) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp31 := yyvsp31 + 1
	yyvsp61 := yyvsp61 -1
	if yyvsp31 >= yyvsc31 or yyvs31 = Void or yyspecial_routines31 = Void then
		if yyvs31 = Void or yyspecial_routines31 = Void then
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
	yyspecial_routines31.force (yyvs31, yyval31, yyvsp31)
end
		end

	yy_do_action_524
			--|#line <not available> "eiffel.y"
		local
			yyval31: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval31 := yyvs72.item (yyvsp72) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp31 := yyvsp31 + 1
	yyvsp72 := yyvsp72 -1
	if yyvsp31 >= yyvsc31 or yyvs31 = Void or yyspecial_routines31 = Void then
		if yyvs31 = Void or yyspecial_routines31 = Void then
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
	yyspecial_routines31.force (yyvs31, yyval31, yyvsp31)
end
		end

	yy_do_action_525
			--|#line <not available> "eiffel.y"
		local
			yyval31: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval31 := yyvs72.item (yyvsp72) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp31 := yyvsp31 + 1
	yyvsp72 := yyvsp72 -1
	if yyvsp31 >= yyvsc31 or yyvs31 = Void or yyspecial_routines31 = Void then
		if yyvs31 = Void or yyspecial_routines31 = Void then
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
	yyspecial_routines31.force (yyvs31, yyval31, yyvsp31)
end
		end

	yy_do_action_526
			--|#line <not available> "eiffel.y"
		local
			yyval31: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval31 := yyvs33.item (yyvsp33) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp31 := yyvsp31 + 1
	yyvsp33 := yyvsp33 -1
	if yyvsp31 >= yyvsc31 or yyvs31 = Void or yyspecial_routines31 = Void then
		if yyvs31 = Void or yyspecial_routines31 = Void then
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
	yyspecial_routines31.force (yyvs31, yyval31, yyvsp31)
end
		end

	yy_do_action_527
			--|#line <not available> "eiffel.y"
		local
			yyval31: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval31 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp31 := yyvsp31 + 1
	yyvsp16 := yyvsp16 -1
	if yyvsp31 >= yyvsc31 or yyvs31 = Void or yyspecial_routines31 = Void then
		if yyvs31 = Void or yyspecial_routines31 = Void then
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
	yyspecial_routines31.force (yyvs31, yyval31, yyvsp31)
end
		end

	yy_do_action_528
			--|#line <not available> "eiffel.y"
		local
			yyval31: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval31 := yyvs5.item (yyvsp5) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp31 := yyvsp31 + 1
	yyvsp5 := yyvsp5 -1
	if yyvsp31 >= yyvsc31 or yyvs31 = Void or yyspecial_routines31 = Void then
		if yyvs31 = Void or yyspecial_routines31 = Void then
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
	yyspecial_routines31.force (yyvs31, yyval31, yyvsp31)
end
		end

	yy_do_action_529
			--|#line <not available> "eiffel.y"
		local
			yyval31: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval31 := yyvs3.item (yyvsp3) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp31 := yyvsp31 + 1
	yyvsp3 := yyvsp3 -1
	if yyvsp31 >= yyvsc31 or yyvs31 = Void or yyspecial_routines31 = Void then
		if yyvs31 = Void or yyspecial_routines31 = Void then
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
	yyspecial_routines31.force (yyvs31, yyval31, yyvsp31)
end
		end

	yy_do_action_530
			--|#line <not available> "eiffel.y"
		local
			yyval31: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval31 := yyvs61.item (yyvsp61) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp31 := yyvsp31 + 1
	yyvsp61 := yyvsp61 -1
	if yyvsp31 >= yyvsc31 or yyvs31 = Void or yyspecial_routines31 = Void then
		if yyvs31 = Void or yyspecial_routines31 = Void then
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
	yyspecial_routines31.force (yyvs31, yyval31, yyvsp31)
end
		end

	yy_do_action_531
			--|#line <not available> "eiffel.y"
		local
			yyval31: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval31 := yyvs72.item (yyvsp72) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp31 := yyvsp31 + 1
	yyvsp72 := yyvsp72 -1
	if yyvsp31 >= yyvsc31 or yyvs31 = Void or yyspecial_routines31 = Void then
		if yyvs31 = Void or yyspecial_routines31 = Void then
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
	yyspecial_routines31.force (yyvs31, yyval31, yyvsp31)
end
		end

	yy_do_action_532
			--|#line <not available> "eiffel.y"
		local
			yyval31: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval31 := yyvs33.item (yyvsp33) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp31 := yyvsp31 + 1
	yyvsp33 := yyvsp33 -1
	if yyvsp31 >= yyvsc31 or yyvs31 = Void or yyspecial_routines31 = Void then
		if yyvs31 = Void or yyspecial_routines31 = Void then
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
	yyspecial_routines31.force (yyvs31, yyval31, yyvsp31)
end
		end

	yy_do_action_533
			--|#line <not available> "eiffel.y"
		local
			yyval31: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval31 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp31 := yyvsp31 + 1
	yyvsp16 := yyvsp16 -1
	if yyvsp31 >= yyvsc31 or yyvs31 = Void or yyspecial_routines31 = Void then
		if yyvs31 = Void or yyspecial_routines31 = Void then
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
	yyspecial_routines31.force (yyvs31, yyval31, yyvsp31)
end
		end

	yy_do_action_534
			--|#line <not available> "eiffel.y"
		local
			yyval31: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval31 := yyvs5.item (yyvsp5) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp31 := yyvsp31 + 1
	yyvsp5 := yyvsp5 -1
	if yyvsp31 >= yyvsc31 or yyvs31 = Void or yyspecial_routines31 = Void then
		if yyvs31 = Void or yyspecial_routines31 = Void then
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
	yyspecial_routines31.force (yyvs31, yyval31, yyvsp31)
end
		end

	yy_do_action_535
			--|#line <not available> "eiffel.y"
		local
			yyval31: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval31 := yyvs61.item (yyvsp61) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp31 := yyvsp31 + 1
	yyvsp61 := yyvsp61 -1
	if yyvsp31 >= yyvsc31 or yyvs31 = Void or yyspecial_routines31 = Void then
		if yyvs31 = Void or yyspecial_routines31 = Void then
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
	yyspecial_routines31.force (yyvs31, yyval31, yyvsp31)
end
		end

	yy_do_action_536
			--|#line <not available> "eiffel.y"
		local
			yyval31: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval31 := yyvs61.item (yyvsp61) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp31 := yyvsp31 + 1
	yyvsp61 := yyvsp61 -1
	if yyvsp31 >= yyvsc31 or yyvs31 = Void or yyspecial_routines31 = Void then
		if yyvs31 = Void or yyspecial_routines31 = Void then
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
	yyspecial_routines31.force (yyvs31, yyval31, yyvsp31)
end
		end

	yy_do_action_537
			--|#line <not available> "eiffel.y"
		local
			yyval31: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval31 := yyvs72.item (yyvsp72) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp31 := yyvsp31 + 1
	yyvsp72 := yyvsp72 -1
	if yyvsp31 >= yyvsc31 or yyvs31 = Void or yyspecial_routines31 = Void then
		if yyvs31 = Void or yyspecial_routines31 = Void then
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
	yyspecial_routines31.force (yyvs31, yyval31, yyvsp31)
end
		end

	yy_do_action_538
			--|#line <not available> "eiffel.y"
		local
			yyval31: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval31 := yyvs72.item (yyvsp72) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp31 := yyvsp31 + 1
	yyvsp72 := yyvsp72 -1
	if yyvsp31 >= yyvsc31 or yyvs31 = Void or yyspecial_routines31 = Void then
		if yyvs31 = Void or yyspecial_routines31 = Void then
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
	yyspecial_routines31.force (yyvs31, yyval31, yyvsp31)
end
		end

	yy_do_action_539
			--|#line <not available> "eiffel.y"
		local
			yyval31: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval31 := yyvs3.item (yyvsp3) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp31 := yyvsp31 + 1
	yyvsp3 := yyvsp3 -1
	if yyvsp31 >= yyvsc31 or yyvs31 = Void or yyspecial_routines31 = Void then
		if yyvs31 = Void or yyspecial_routines31 = Void then
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
	yyspecial_routines31.force (yyvs31, yyval31, yyvsp31)
end
		end

	yy_do_action_540
			--|#line <not available> "eiffel.y"
		local
			yyval31: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval31 := yyvs33.item (yyvsp33) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp31 := yyvsp31 + 1
	yyvsp33 := yyvsp33 -1
	if yyvsp31 >= yyvsc31 or yyvs31 = Void or yyspecial_routines31 = Void then
		if yyvs31 = Void or yyspecial_routines31 = Void then
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
	yyspecial_routines31.force (yyvs31, yyval31, yyvsp31)
end
		end

	yy_do_action_541
			--|#line <not available> "eiffel.y"
		local
			yyval31: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval31 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp31 := yyvsp31 + 1
	yyvsp16 := yyvsp16 -1
	if yyvsp31 >= yyvsc31 or yyvs31 = Void or yyspecial_routines31 = Void then
		if yyvs31 = Void or yyspecial_routines31 = Void then
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
	yyspecial_routines31.force (yyvs31, yyval31, yyvsp31)
end
		end

	yy_do_action_542
			--|#line <not available> "eiffel.y"
		local
			yyval31: detachable ATOMIC_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				if attached yyvs16.item (yyvsp16) as l_string then
					l_string.set_is_once_string (True)
					l_string.set_once_string_keyword (yyvs12.item (yyvsp12))
				end
				increment_once_manifest_string_counter
				yyval31 := yyvs16.item (yyvsp16)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp31 := yyvsp31 + 1
	yyvsp12 := yyvsp12 -1
	yyvsp16 := yyvsp16 -1
	if yyvsp31 >= yyvsc31 or yyvs31 = Void or yyspecial_routines31 = Void then
		if yyvs31 = Void or yyspecial_routines31 = Void then
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
	yyspecial_routines31.force (yyvs31, yyval31, yyvsp31)
end
		end

	yy_do_action_543
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines5 /= Void
			yyvs5 /= Void
		local
			yyval5: detachable BOOL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval5 := yyvs5.item (yyvsp5) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines5.force (yyvs5, yyval5, yyvsp5)
end
		end

	yy_do_action_544
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines5 /= Void
			yyvs5 /= Void
		local
			yyval5: detachable BOOL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval5 := yyvs5.item (yyvsp5) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines5.force (yyvs5, yyval5, yyvsp5)
end
		end

	yy_do_action_545
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines3 /= Void
			yyvs3 /= Void
		local
			yyval3: detachable CHAR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval3 := yyvs3.item (yyvsp3) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines3.force (yyvs3, yyval3, yyvsp3)
end
		end

	yy_do_action_546
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines3 /= Void
			yyvs3 /= Void
		local
			yyval3: detachable CHAR_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval3 := ast_factory.new_typed_char_as (yyvs81.item (yyvsp81), yyvs3.item (yyvsp3)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp81 := yyvsp81 -1
	yyspecial_routines3.force (yyvs3, yyval3, yyvsp3)
end
		end

	yy_do_action_547
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines61 /= Void
			yyvs61 /= Void
		local
			yyval61: detachable INTEGER_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval61 := yyvs61.item (yyvsp61) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines61.force (yyvs61, yyval61, yyvsp61)
end
		end

	yy_do_action_548
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines61 /= Void
			yyvs61 /= Void
		local
			yyval61: detachable INTEGER_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval61 := yyvs61.item (yyvsp61) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines61.force (yyvs61, yyval61, yyvsp61)
end
		end

	yy_do_action_549
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines61 /= Void
			yyvs61 /= Void
		local
			yyval61: detachable INTEGER_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval61 := yyvs61.item (yyvsp61) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines61.force (yyvs61, yyval61, yyvsp61)
end
		end

	yy_do_action_550
			--|#line <not available> "eiffel.y"
		local
			yyval61: detachable INTEGER_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval61 := ast_factory.new_integer_value (Current, '+', Void, token_buffer, yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp61 := yyvsp61 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	if yyvsp61 >= yyvsc61 or yyvs61 = Void or yyspecial_routines61 = Void then
		if yyvs61 = Void or yyspecial_routines61 = Void then
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
	yyspecial_routines61.force (yyvs61, yyval61, yyvsp61)
end
		end

	yy_do_action_551
			--|#line <not available> "eiffel.y"
		local
			yyval61: detachable INTEGER_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval61 := ast_factory.new_integer_value (Current, '-', Void, token_buffer, yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp61 := yyvsp61 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	if yyvsp61 >= yyvsc61 or yyvs61 = Void or yyspecial_routines61 = Void then
		if yyvs61 = Void or yyspecial_routines61 = Void then
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
	yyspecial_routines61.force (yyvs61, yyval61, yyvsp61)
end
		end

	yy_do_action_552
			--|#line <not available> "eiffel.y"
		local
			yyval61: detachable INTEGER_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval61 := ast_factory.new_integer_value (Current, '%U', Void, token_buffer, Void)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp61 := yyvsp61 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp61 >= yyvsc61 or yyvs61 = Void or yyspecial_routines61 = Void then
		if yyvs61 = Void or yyspecial_routines61 = Void then
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
	yyspecial_routines61.force (yyvs61, yyval61, yyvsp61)
end
		end

	yy_do_action_553
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines61 /= Void
			yyvs61 /= Void
		local
			yyval61: detachable INTEGER_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval61 := yyvs61.item (yyvsp61) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines61.force (yyvs61, yyval61, yyvsp61)
end
		end

	yy_do_action_554
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines61 /= Void
			yyvs61 /= Void
		local
			yyval61: detachable INTEGER_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval61 := yyvs61.item (yyvsp61) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines61.force (yyvs61, yyval61, yyvsp61)
end
		end

	yy_do_action_555
			--|#line <not available> "eiffel.y"
		local
			yyval61: detachable INTEGER_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval61 := ast_factory.new_integer_value (Current, '%U', yyvs81.item (yyvsp81), token_buffer, Void)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp61 := yyvsp61 + 1
	yyvsp81 := yyvsp81 -1
	yyvsp1 := yyvsp1 -1
	if yyvsp61 >= yyvsc61 or yyvs61 = Void or yyspecial_routines61 = Void then
		if yyvs61 = Void or yyspecial_routines61 = Void then
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
	yyspecial_routines61.force (yyvs61, yyval61, yyvsp61)
end
		end

	yy_do_action_556
			--|#line <not available> "eiffel.y"
		local
			yyval61: detachable INTEGER_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval61 := ast_factory.new_integer_value (Current, '+', yyvs81.item (yyvsp81), token_buffer, yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp61 := yyvsp61 + 1
	yyvsp81 := yyvsp81 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	if yyvsp61 >= yyvsc61 or yyvs61 = Void or yyspecial_routines61 = Void then
		if yyvs61 = Void or yyspecial_routines61 = Void then
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
	yyspecial_routines61.force (yyvs61, yyval61, yyvsp61)
end
		end

	yy_do_action_557
			--|#line <not available> "eiffel.y"
		local
			yyval61: detachable INTEGER_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval61 := ast_factory.new_integer_value (Current, '-', yyvs81.item (yyvsp81), token_buffer, yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp61 := yyvsp61 + 1
	yyvsp81 := yyvsp81 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	if yyvsp61 >= yyvsc61 or yyvs61 = Void or yyspecial_routines61 = Void then
		if yyvs61 = Void or yyspecial_routines61 = Void then
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
	yyspecial_routines61.force (yyvs61, yyval61, yyvsp61)
end
		end

	yy_do_action_558
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines72 /= Void
			yyvs72 /= Void
		local
			yyval72: detachable REAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval72 := yyvs72.item (yyvsp72) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines72.force (yyvs72, yyval72, yyvsp72)
end
		end

	yy_do_action_559
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines72 /= Void
			yyvs72 /= Void
		local
			yyval72: detachable REAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval72 := yyvs72.item (yyvsp72) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines72.force (yyvs72, yyval72, yyvsp72)
end
		end

	yy_do_action_560
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines72 /= Void
			yyvs72 /= Void
		local
			yyval72: detachable REAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval72 := yyvs72.item (yyvsp72) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines72.force (yyvs72, yyval72, yyvsp72)
end
		end

	yy_do_action_561
			--|#line <not available> "eiffel.y"
		local
			yyval72: detachable REAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval72 := ast_factory.new_real_value (Current, False, '%U', Void, token_buffer, Void)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp72 := yyvsp72 + 1
	yyvsp1 := yyvsp1 -1
	if yyvsp72 >= yyvsc72 or yyvs72 = Void or yyspecial_routines72 = Void then
		if yyvs72 = Void or yyspecial_routines72 = Void then
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
	yyspecial_routines72.force (yyvs72, yyval72, yyvsp72)
end
		end

	yy_do_action_562
			--|#line <not available> "eiffel.y"
		local
			yyval72: detachable REAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval72 := ast_factory.new_real_value (Current, True, '+', Void, token_buffer, yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp72 := yyvsp72 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	if yyvsp72 >= yyvsc72 or yyvs72 = Void or yyspecial_routines72 = Void then
		if yyvs72 = Void or yyspecial_routines72 = Void then
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
	yyspecial_routines72.force (yyvs72, yyval72, yyvsp72)
end
		end

	yy_do_action_563
			--|#line <not available> "eiffel.y"
		local
			yyval72: detachable REAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval72 := ast_factory.new_real_value (Current, True, '-', Void, token_buffer, yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp72 := yyvsp72 + 1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	if yyvsp72 >= yyvsc72 or yyvs72 = Void or yyspecial_routines72 = Void then
		if yyvs72 = Void or yyspecial_routines72 = Void then
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
	yyspecial_routines72.force (yyvs72, yyval72, yyvsp72)
end
		end

	yy_do_action_564
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines72 /= Void
			yyvs72 /= Void
		local
			yyval72: detachable REAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval72 := yyvs72.item (yyvsp72) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines72.force (yyvs72, yyval72, yyvsp72)
end
		end

	yy_do_action_565
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines72 /= Void
			yyvs72 /= Void
		local
			yyval72: detachable REAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval72 := yyvs72.item (yyvsp72) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines72.force (yyvs72, yyval72, yyvsp72)
end
		end

	yy_do_action_566
			--|#line <not available> "eiffel.y"
		local
			yyval72: detachable REAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval72 := ast_factory.new_real_value (Current, False, '%U', yyvs81.item (yyvsp81), token_buffer, Void)
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp72 := yyvsp72 + 1
	yyvsp81 := yyvsp81 -1
	yyvsp1 := yyvsp1 -1
	if yyvsp72 >= yyvsc72 or yyvs72 = Void or yyspecial_routines72 = Void then
		if yyvs72 = Void or yyspecial_routines72 = Void then
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
	yyspecial_routines72.force (yyvs72, yyval72, yyvsp72)
end
		end

	yy_do_action_567
			--|#line <not available> "eiffel.y"
		local
			yyval72: detachable REAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval72 := ast_factory.new_real_value (Current, True, '+', yyvs81.item (yyvsp81), token_buffer, yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp72 := yyvsp72 + 1
	yyvsp81 := yyvsp81 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	if yyvsp72 >= yyvsc72 or yyvs72 = Void or yyspecial_routines72 = Void then
		if yyvs72 = Void or yyspecial_routines72 = Void then
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
	yyspecial_routines72.force (yyvs72, yyval72, yyvsp72)
end
		end

	yy_do_action_568
			--|#line <not available> "eiffel.y"
		local
			yyval72: detachable REAL_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval72 := ast_factory.new_real_value (Current, True, '-', yyvs81.item (yyvsp81), token_buffer, yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 3
	yyvsp72 := yyvsp72 + 1
	yyvsp81 := yyvsp81 -1
	yyvsp4 := yyvsp4 -1
	yyvsp1 := yyvsp1 -1
	if yyvsp72 >= yyvsc72 or yyvs72 = Void or yyspecial_routines72 = Void then
		if yyvs72 = Void or yyspecial_routines72 = Void then
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
	yyspecial_routines72.force (yyvs72, yyval72, yyvsp72)
end
		end

	yy_do_action_569
			--|#line <not available> "eiffel.y"
		local
			yyval33: detachable BIT_CONST_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval33 := new_bit_const (yyvs2.item (yyvsp2)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyvsp33 := yyvsp33 + 1
	yyvsp2 := yyvsp2 -1
	if yyvsp33 >= yyvsc33 or yyvs33 = Void or yyspecial_routines33 = Void then
		if yyvs33 = Void or yyspecial_routines33 = Void then
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
	yyspecial_routines33.force (yyvs33, yyval33, yyvsp33)
end
		end

	yy_do_action_570
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines16 /= Void
			yyvs16 /= Void
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_571
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines16 /= Void
			yyvs16 /= Void
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_572
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines16 /= Void
			yyvs16 /= Void
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_573
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines16 /= Void
			yyvs16 /= Void
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_574
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines16 /= Void
			yyvs16 /= Void
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_575
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines16 /= Void
			yyvs16 /= Void
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval16 := yyvs16.item (yyvsp16)
				if attached yyval16 as l_string then
					l_string.set_type (yyvs81.item (yyvsp81))
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp81 := yyvsp81 -1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_576
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines16 /= Void
			yyvs16 /= Void
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_577
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines16 /= Void
			yyvs16 /= Void
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_578
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines16 /= Void
			yyvs16 /= Void
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_579
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines16 /= Void
			yyvs16 /= Void
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_580
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines16 /= Void
			yyvs16 /= Void
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_581
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines16 /= Void
			yyvs16 /= Void
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_582
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines16 /= Void
			yyvs16 /= Void
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_583
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines16 /= Void
			yyvs16 /= Void
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_584
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines16 /= Void
			yyvs16 /= Void
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_585
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines16 /= Void
			yyvs16 /= Void
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_586
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines16 /= Void
			yyvs16 /= Void
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_587
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines16 /= Void
			yyvs16 /= Void
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_588
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines16 /= Void
			yyvs16 /= Void
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_589
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines16 /= Void
			yyvs16 /= Void
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_590
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines16 /= Void
			yyvs16 /= Void
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_591
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines16 /= Void
			yyvs16 /= Void
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_592
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines16 /= Void
			yyvs16 /= Void
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_593
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines16 /= Void
			yyvs16 /= Void
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_594
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines16 /= Void
			yyvs16 /= Void
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_595
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines16 /= Void
			yyvs16 /= Void
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_596
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines16 /= Void
			yyvs16 /= Void
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_597
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines16 /= Void
			yyvs16 /= Void
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_598
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines16 /= Void
			yyvs16 /= Void
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_599
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines16 /= Void
			yyvs16 /= Void
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_600
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines16 /= Void
			yyvs16 /= Void
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Alias names should always be taken in their lower case version
				if attached yyvs16.item (yyvsp16) as l_str_not then
					l_str_not.value.to_lower
					yyval16 := l_str_not
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_601
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines16 /= Void
			yyvs16 /= Void
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Alias names should always be taken in their lower case version
				if attached yyvs16.item (yyvsp16) as l_str_free then
					l_str_free.value.to_lower
					yyval16 := l_str_free
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_602
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines16 /= Void
			yyvs16 /= Void
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_603
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines16 /= Void
			yyvs16 /= Void
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_604
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines16 /= Void
			yyvs16 /= Void
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_605
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines16 /= Void
			yyvs16 /= Void
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_606
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines16 /= Void
			yyvs16 /= Void
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_607
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines16 /= Void
			yyvs16 /= Void
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_608
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines16 /= Void
			yyvs16 /= Void
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_609
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines16 /= Void
			yyvs16 /= Void
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_610
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines16 /= Void
			yyvs16 /= Void
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_611
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines16 /= Void
			yyvs16 /= Void
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_612
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines16 /= Void
			yyvs16 /= Void
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval16 := yyvs16.item (yyvsp16) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_613
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines16 /= Void
			yyvs16 /= Void
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Alias names should always be taken in their lower case version
				if attached yyvs16.item (yyvsp16) as l_str_and then
					l_str_and.value.to_lower
					yyval16 := l_str_and
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_614
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines16 /= Void
			yyvs16 /= Void
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Alias names should always be taken in their lower case version
				if attached yyvs16.item (yyvsp16) as l_str_and_then then
					l_str_and_then.value.to_lower
					yyval16 := l_str_and_then
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_615
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines16 /= Void
			yyvs16 /= Void
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Alias names should always be taken in their lower case version
				if attached yyvs16.item (yyvsp16) as l_str_implies then 
					l_str_implies.value.to_lower
					yyval16 := l_str_implies
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_616
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines16 /= Void
			yyvs16 /= Void
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Alias names should always be taken in their lower case version
				if attached yyvs16.item (yyvsp16) as l_str_or then
					l_str_or.value.to_lower
					yyval16 := l_str_or
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_617
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines16 /= Void
			yyvs16 /= Void
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Alias names should always be taken in their lower case version
				if attached yyvs16.item (yyvsp16) as l_str_or_else then
					l_str_or_else.value.to_lower
					yyval16 := l_str_or_else
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_618
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines16 /= Void
			yyvs16 /= Void
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Alias names should always be taken in their lower case version
				if attached yyvs16.item (yyvsp16) as l_str_xor then
					l_str_xor.value.to_lower
					yyval16 := l_str_xor
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_619
			--|#line <not available> "eiffel.y"
		require
			yyspecial_routines16 /= Void
			yyvs16 /= Void
		local
			yyval16: detachable STRING_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

					-- Alias names should always be taken in their lower case version
				if attached yyvs16.item (yyvsp16) as l_str_free then
					l_str_free.value.to_lower
					yyval16 := l_str_free
				end
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 1
	yyspecial_routines16.force (yyvs16, yyval16, yyvsp16)
end
		end

	yy_do_action_620
			--|#line <not available> "eiffel.y"
		local
			yyval28: detachable ARRAY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				yyval28 := ast_factory.new_array_as (ast_factory.new_eiffel_list_expr_as (0), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4))
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp28 := yyvsp28 + 1
	yyvsp4 := yyvsp4 -2
	if yyvsp28 >= yyvsc28 or yyvs28 = Void or yyspecial_routines28 = Void then
		if yyvs28 = Void or yyspecial_routines28 = Void then
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
	yyspecial_routines28.force (yyvs28, yyval28, yyvsp28)
end
		end

	yy_do_action_621
			--|#line <not available> "eiffel.y"
		local
			yyval28: detachable ARRAY_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval28 := ast_factory.new_array_as (yyvs94.item (yyvsp94), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp28 := yyvsp28 + 1
	yyvsp4 := yyvsp4 -2
	yyvsp1 := yyvsp1 -2
	yyvsp94 := yyvsp94 -1
	if yyvsp28 >= yyvsc28 or yyvs28 = Void or yyspecial_routines28 = Void then
		if yyvs28 = Void or yyspecial_routines28 = Void then
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
	yyspecial_routines28.force (yyvs28, yyval28, yyvsp28)
end
		end

	yy_do_action_622
			--|#line <not available> "eiffel.y"
		local
			yyval80: detachable TUPLE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval80 := ast_factory.new_tuple_as (ast_factory.new_eiffel_list_expr_as (0), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 2
	yyvsp80 := yyvsp80 + 1
	yyvsp4 := yyvsp4 -2
	if yyvsp80 >= yyvsc80 or yyvs80 = Void or yyspecial_routines80 = Void then
		if yyvs80 = Void or yyspecial_routines80 = Void then
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
	yyspecial_routines80.force (yyvs80, yyval80, yyvsp80)
end
		end

	yy_do_action_623
			--|#line <not available> "eiffel.y"
		local
			yyval80: detachable TUPLE_AS
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

yyval80 := ast_factory.new_tuple_as (yyvs94.item (yyvsp94), yyvs4.item (yyvsp4 - 1), yyvs4.item (yyvsp4)) 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 5
	yyvsp80 := yyvsp80 + 1
	yyvsp4 := yyvsp4 -2
	yyvsp1 := yyvsp1 -2
	yyvsp94 := yyvsp94 -1
	if yyvsp80 >= yyvsc80 or yyvs80 = Void or yyspecial_routines80 = Void then
		if yyvs80 = Void or yyspecial_routines80 = Void then
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
	yyspecial_routines80.force (yyvs80, yyval80, yyvsp80)
end
		end

	yy_do_action_624
			--|#line <not available> "eiffel.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

				add_counter
			
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp1 := yyvsp1 + 1
	if yyvsp1 >= yyvsc1 or yyvs1 = Void or yyspecial_routines1 = Void then
		if yyvs1 = Void or yyspecial_routines1 = Void then
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
		end

	yy_do_action_625
			--|#line <not available> "eiffel.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

add_counter 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp1 := yyvsp1 + 1
	if yyvsp1 >= yyvsc1 or yyvs1 = Void or yyspecial_routines1 = Void then
		if yyvs1 = Void or yyspecial_routines1 = Void then
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
		end

	yy_do_action_626
			--|#line <not available> "eiffel.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

add_counter2 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp1 := yyvsp1 + 1
	if yyvsp1 >= yyvsc1 or yyvs1 = Void or yyspecial_routines1 = Void then
		if yyvs1 = Void or yyspecial_routines1 = Void then
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
		end

	yy_do_action_627
			--|#line <not available> "eiffel.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

increment_counter 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp1 := yyvsp1 + 1
	if yyvsp1 >= yyvsc1 or yyvs1 = Void or yyspecial_routines1 = Void then
		if yyvs1 = Void or yyspecial_routines1 = Void then
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
		end

	yy_do_action_628
			--|#line <not available> "eiffel.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

increment_counter2 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp1 := yyvsp1 + 1
	if yyvsp1 >= yyvsc1 or yyvs1 = Void or yyspecial_routines1 = Void then
		if yyvs1 = Void or yyspecial_routines1 = Void then
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
		end

	yy_do_action_629
			--|#line <not available> "eiffel.y"
		local
			yyval1: detachable ANY
		do
--|#line <not available> "eiffel.y"
debug ("GEYACC")
	std.error.put_line ("Executing parser user-code from file 'eiffel.y' at line <not available>")
end

remove_counter 
if yy_parsing_status >= yyContinue then
	yyssp := yyssp - 0
	yyvsp1 := yyvsp1 + 1
	if yyvsp1 >= yyvsc1 or yyvs1 = Void or yyspecial_routines1 = Void then
		if yyvs1 = Void or yyspecial_routines1 = Void then
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
		end

	yy_do_error_action (yy_act: INTEGER)
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
			else
					-- Default action.
				report_error ("parse error")
			end
		end

	yy_do_error_action_0_199 (yy_act: INTEGER)
			-- Execute error action.
		do
			inspect yy_act
			else
					-- Default action.
				report_error ("parse error")
			end
		end

	yy_do_error_action_200_399 (yy_act: INTEGER)
			-- Execute error action.
		do
			inspect yy_act
			else
					-- Default action.
				report_error ("parse error")
			end
		end

	yy_do_error_action_400_599 (yy_act: INTEGER)
			-- Execute error action.
		do
			inspect yy_act
			else
					-- Default action.
				report_error ("parse error")
			end
		end

	yy_do_error_action_600_799 (yy_act: INTEGER)
			-- Execute error action.
		do
			inspect yy_act
			else
					-- Default action.
				report_error ("parse error")
			end
		end

	yy_do_error_action_800_999 (yy_act: INTEGER)
			-- Execute error action.
		do
			inspect yy_act
			else
					-- Default action.
				report_error ("parse error")
			end
		end

	yy_do_error_action_1000_1199 (yy_act: INTEGER)
			-- Execute error action.
		do
			inspect yy_act
			when 1101 then
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
			   85,   86,   87,   88,   89,   90,   91,   92,   93,   94,
			   95,   96,   97,   98,   99,  100,  101,  102,  103,  104,
			  105,  106,  107,  108,  109,  110,  111,  112,  113,  114,
			  115,  116,  117,  118,  119,  120,  121,  122,  123,  124,
			  125,  126,  127,  128,  129,  130,  131,  132,  133,  134,
			  135,  136,  137,  138,  139, yyDummy>>)
		end

	yyr1_template: SPECIAL [INTEGER]
			-- Template for `yyr1'
		once
			Result := yyfixed_array (<<
			    0,  340,  340,  340,  340,  340,  340,  340,  340,  341,
			  345,  346,  347,  348,  349,  309,  309,  309,  309,  309,
			  312,  312,  312,  310,  310,  311,  311,  207,  209,  208,
			  208,  210,  277,  277,  277,  278,  278,  160,  160,  160,
			  160,  354,  355,  352,  353,  344,  344,  344,  356,  356,
			  357,  357,  174,  174,  147,  147,  293,  293,  294,  294,
			  195,  195,  176,  358,  175,  175,  307,  307,  308,  308,
			  292,  292,  140,  140,  194,  297,  297,  276,  276,  275,
			  275,  274,  274,  274,  272,  273,  143,  251,  251,  251,
			  141,  141,  142,  142,  166,  166,  166,  166,  166,  166,

			  166,  166,  145,  145,  177,  177,  319,  319,  319,  319,
			  360,  320,  320,  227,  268,  228,  228,  228,  228,  228,
			  228,  322,  322,  321,  321,  239,  289,  289,  288,  288,
			  287,  287,  185,  196,  196,  196,  282,  282,  281,  281,
			  178,  178,  295,  296,  296,  300,  300,  299,  299,  302,
			  302,  301,  301,  304,  304,  303,  303,  335,  335,  332,
			  332,  269,  148,  148,  149,  149,  243,  361,  242,  242,
			  242,  192,  193,  146,  146,  220,  220,  220,  334,  334,
			  334,  314,  314,  315,  315,  212,  359,  359,  213,  213,
			  213,  213,  213,  213,  213,  213,  213,  213,  213,  213,

			  240,  240,  362,  240,  363,  184,  184,  364,  184,  365,
			  325,  325,  326,  326,  366,  252,  252,  252,  254,  254,
			  254,  254,  257,  257,  257,  257,  257,  257,  261,  261,
			  258,  255,  255,  255,  255,  255,  255,  260,  260,  262,
			  262,  267,  267,  267,  264,  264,  264,  266,  266,  265,
			  265,  265,  265,  265,  328,  328,  327,  327,  329,  330,
			  330,  259,  259,  259,  259,  331,  331,  331,  333,  333,
			  333,  305,  305,  305,  306,  306,  197,  197,  197,  198,
			  369,  337,  337,  337,  339,  370,  371,  339,  263,  263,
			  263,  338,  338,  372,  298,  298,  206,  206,  206,  206,

			  285,  286,  286,  183,  211,  211,  279,  279,  280,  280,
			  171,  316,  316,  221,  221,  221,  221,  221,  221,  221,
			  221,  221,  221,  221,  221,  221,  221,  221,  221,  221,
			  221,  224,  224,  224,  224,  223,  223,  313,  150,  150,
			  222,  222,  373,  151,  151,  271,  271,  270,  270,  182,
			  324,  324,  324,  323,  323,  144,  144,  189,  189,  189,
			  189,  159,  158,  158,  241,  241,  283,  283,  284,  284,
			  179,  179,  179,  179,  179,  179,  244,  374,  375,  244,
			  376,  377,  244,  244,  336,  336,  152,  152,  152,  152,
			  152,  152,  318,  318,  318,  317,  317,  226,  226,  226,

			  180,  180,  180,  180,  181,  181,  154,  154,  156,  156,
			  168,  168,  168,  168,  173,  199,  256,  187,  187,  187,
			  187,  187,  187,  187,  187,  187,  187,  187,  187,  187,
			  164,  164,  164,  164,  164,  164,  164,  164,  164,  164,
			  164,  164,  164,  164,  164,  164,  164,  164,  188,  188,
			  188,  188,  188,  188,  188,  188,  188,  188,  188,  190,
			  190,  190,  190,  190,  191,  191,  191,  204,  170,  170,
			  170,  170,  170,  170,  170,  229,  229,  230,  230,  232,
			  231,  169,  169,  225,  225,  205,  205,  205,  153,  155,
			  186,  186,  186,  186,  186,  186,  186,  186,  186,  291,

			  291,  291,  290,  290,  200,  200,  201,  201,  201,  201,
			  201,  201,  201,  202,  203,  203,  203,  203,  203,  203,
			  163,  163,  163,  163,  163,  163,  163,  163,  161,  161,
			  161,  161,  161,  161,  162,  162,  162,  162,  162,  162,
			  162,  162,  162,  167,  167,  172,  172,  214,  214,  214,
			  215,  215,  216,  217,  217,  218,  219,  219,  233,  233,
			  233,  235,  234,  234,  236,  236,  237,  238,  238,  165,
			  245,  245,  247,  247,  247,  248,  246,  246,  246,  246,
			  246,  246,  246,  246,  246,  246,  246,  246,  246,  246,
			  246,  246,  246,  246,  246,  246,  246,  246,  250,  250,

			  250,  250,  249,  249,  249,  249,  249,  249,  249,  249,
			  249,  249,  249,  249,  249,  249,  249,  249,  249,  249,
			  157,  157,  253,  253,  350,  342,  367,  351,  368,  343, yyDummy>>)
		end

	yytypes1_template: SPECIAL [INTEGER]
			-- Template for `yytypes1'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 1103)
			yytypes1_template_1 (an_array)
			yytypes1_template_2 (an_array)
			Result := yyfixed_array (an_array)
		end

	yytypes1_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yytypes1'.
		do
			yyarray_subcopy (an_array, <<
			    1,   15,   15,   15,   15,   15,   15,   12,   12,   12,
			   12,    2,    2,    2,  105,    1,    1,    1,    1,   12,
			   64,   51,    1,   16,   16,   16,   16,   16,   16,   16,
			   16,   16,   16,   16,   16,   16,   16,   16,   16,   16,
			   16,   16,   16,   16,   16,   16,   16,   15,   15,   12,
			   12,   12,   12,   12,   12,   12,   11,    9,    6,    5,
			    5,    4,    4,    4,    4,    4,    3,    1,    1,    2,
			    4,   12,   12,   12,    2,    4,    4,   25,   28,   31,
			   32,   33,    5,   35,   35,    3,   43,   48,   48,   48,
			   48,   48,    2,    2,    2,   61,   61,   61,   61,   65,

			   70,   71,   71,   71,   72,   72,   72,   72,   78,   16,
			   16,   16,   16,   80,   81,   86,   86,  106,   15,   15,
			   15,   15,   15,   15,   12,   12,   12,   12,    4,    4,
			    2,    2,    2,    2,   81,   81,   81,   81,   81,   81,
			   81,   81,   81,   81,   82,   12,   10,    1,    1,   58,
			  105,    1,   58,  105,    1,   84,  118,    1,   64,   12,
			    2,   86,   86,   86,   86,   86,   98,    4,   48,   48,
			    4,   16,   81,   81,   81,    9,    6,    4,    4,   24,
			    2,    2,   81,  120,  120,   16,   16,   16,   16,   16,
			    4,    4,   95,   16,   16,   16,   16,   16,   16,   16,

			   16,   16,   16,   16,   16,   16,   16,   16,   16,   16,
			   16,   16,    4,    4,   15,   15,    4,    4,   81,   81,
			   81,   81,   15,   15,   15,   15,    2,    2,    2,   81,
			    4,    1,    9,    6,    4,    2,   86,    4,    1,   48,
			   48,    4,   48,    1,    1,   48,    1,    1,   48,    4,
			    4,    4,    4,    4,    4,    4,    4,    4,    4,    4,
			    4,    4,    4,    4,    4,    4,   12,   12,   12,   12,
			    2,   48,   95,    4,    4,    3,    1,    1,    4,    4,
			    4,   16,   12,   22,   12,   81,   81,   12,   81,   81,
			   81,   81,    9,    2,   81,   81,    4,    4,    2,   61,

			   61,   61,   61,   61,   61,   81,   12,   81,   81,   81,
			   81,    4,  117,  117,    1,    4,    4,   12,    1,   12,
			   12,   12,   12,    1,    4,    4,    1,    2,   58,    1,
			    1,    4,    4,    4,   31,   31,   33,    5,    3,    2,
			   58,   61,   72,   72,   72,   72,   72,   72,   16,   81,
			   87,    1,    1,    1,   21,    2,  116,    1,   86,   12,
			   17,    4,    1,   81,   12,   12,    4,    4,   27,    4,
			    1,    4,    4,  110,    4,   78,    2,    4,    1,   26,
			   35,    2,   67,   35,    4,    4,    4,   48,   94,   48,
			   94,    4,   21,    1,   35,    1,   48,   48,   48,   48,

			   48,   48,   48,   48,   48,   48,   48,   48,   48,   48,
			   48,   12,   48,   48,   12,   48,   48,   48,   35,   35,
			    2,    1,    1,    1,    1,  116,   12,   23,   81,   81,
			   81,   81,    4,    4,    4,    4,  117,    1,    1,    2,
			    2,    2,    2,    2,    1,    1,    4,    1,  105,    4,
			    4,    1,    4,   43,  118,    1,    4,   48,    2,   79,
			  116,   16,   16,   16,   16,    1,   15,    4,    4,   12,
			   34,  120,    4,    2,    2,    2,    2,  118,    1,    2,
			    4,    1,   81,   12,   20,   77,    4,   94,    4,   95,
			   27,   81,    4,    1,    4,    1,    4,    4,   21,   94,

			   48,   48,   95,   48,   15,   12,    2,    4,   81,  117,
			    4,    4,  103,  105,   31,    2,   87,    1,   87,   12,
			   80,    4,    1,    4,    4,  116,    1,   12,   12,   98,
			   81,    1,  105,    1,    4,   12,   48,   95,   95,    1,
			   48,    2,  110,    4,   48,   68,   81,  109,   78,   16,
			   77,   78,   95,    1,   26,   67,    4,    1,    4,    4,
			   35,    1,    1,   48,   48,    4,    1,    4,    2,   81,
			  117,  118,    4,    1,   12,   20,    4,   87,    4,    1,
			   12,   81,   21,    4,   48,  116,   15,   19,   77,    4,
			   81,  105,   12,    4,    1,    4,    4,    1,   77,   12,

			   74,  110,    4,   48,   94,    4,   12,   85,   85,   85,
			    1,    4,    4,    4,    4,    1,   16,   20,    1,    1,
			    4,    4,    2,   15,   15,    4,  105,  105,   19,   77,
			    2,    1,    1,    4,   78,   12,   74,   12,  119,    4,
			   48,    2,   12,   12,  117,    1,   81,    1,   12,   12,
			   54,   55,    2,  103,    1,   87,    8,    3,   31,   33,
			    5,   39,   61,   61,   72,   72,   16,  105,   12,    1,
			   39,   77,   12,    4,  109,  110,   74,  116,    1,   15,
			   12,   12,   12,   10,   49,   62,   76,   35,    4,  117,
			  118,    4,    4,    2,  117,    2,    2,   55,    4,    1,

			   12,  111,   15,  105,   77,  105,  105,  105,  116,  118,
			  107,    1,    4,  115,   50,   16,  107,   12,   46,   48,
			    1,    4,    4,  121,    1,    1,    4,    4,    1,    1,
			    1,    1,   77,    1,    1,    4,    1,  107,   20,   12,
			   46,   12,   18,    1,    1,    4,    4,    4,   81,   81,
			   81,   81,  123,  103,    4,    2,    2,   69,   69,   83,
			  111,  111,  105,   12,   12,   12,   12,   12,   12,   12,
			    7,    6,    4,   29,   30,   32,   35,   37,   42,   44,
			   48,   48,   48,   56,    2,   57,   59,   60,   60,   66,
			   71,   75,  106,  107,   16,  114,   46,  116,  107,   12,

			    2,  118,    1,  123,   12,   99,    4,  117,    1,    4,
			   12,   12,   12,   12,   12,   93,  100,  101,  102,  113,
			    1,    1,    1,   48,   48,  107,  115,    6,   25,    2,
			   81,  116,    4,    4,    4,   81,    4,    4,    4,    1,
			    1,   12,   22,    1,    4,    1,  116,    4,  122,  123,
			  113,   98,    1,  111,  111,   98,   98,    1,   98,    4,
			    1,  100,  100,  101,  101,  102,  102,   12,   93,   93,
			   90,    1,   88,    1,   12,   22,  107,   27,   25,   12,
			   12,   48,   48,   25,    4,   48,   48,   48,  107,  107,
			   23,    1,    4,    1,    1,    4,  123,   12,   86,   98,

			    1,   73,   86,  112,    4,   47,   92,  104,  101,  102,
			   12,  100,   12,   89,   12,   12,   41,   90,   12,   12,
			   12,   36,   88,  107,   12,   85,   12,   27,  107,   27,
			   25,   22,   12,  114,    4,  122,   12,    4,    1,  111,
			    4,   12,    1,    4,    1,    1,    1,   12,   53,   98,
			  102,   12,  101,    1,   97,    1,   38,  104,   38,  104,
			    1,    1,  107,    1,    1,    1,   12,   12,   91,    1,
			   48,   12,   12,   27,   23,  107,   99,  122,    1,    1,
			    1,   86,    2,  104,   92,    4,   12,  102,   40,   86,
			   89,    1,   12,   38,   52,   97,   98,   98,   90,   12, yyDummy>>,
			1, 1000, 0)
		end

	yytypes1_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yytypes1'.
		do
			yyarray_subcopy (an_array, <<
			    3,    2,   61,   63,   71,   81,  108,   88,  107,   12,
			   12,   12,   45,   91,   12,   48,   12,   85,   98,  112,
			    4,    1,   12,    4,    4,    4,    1,   64,   38,    1,
			    1,    1,    1,    4,    4,    4,    4,    4,    1,   12,
			  107,   48,    1,    1,  107,   12,  107,   12,    1,    4,
			    1,    4,    4,  105,   38,  104,   51,   96,   97,    3,
			    2,   71,   81,    3,    2,   61,   71,    2,   61,   71,
			   81,    1,    3,    2,   61,   71,   12,   12,   12,   91,
			   85,  107,   85,  104,   89,  117,  117,   12,    1,    1,
			  108,  107,  107,   12,   12,   12,    4,    4,   96,    1,

			    4,    1,    1,    1, yyDummy>>,
			1, 104, 1000)
		end

	yytypes2_template: SPECIAL [INTEGER]
			-- Template for `yytypes2'
		once
			Result := yyfixed_array (<<
			    1,    1,    1,    4,    4,   12,   12,   12,   12,    4,
			    4,    4,    4,    4,    4,    4,    4,    4,    4,    4,
			    4,    4,    4,    4,    2,   12,   12,   12,    4,    4,
			    2,    2,    2,    1,    1,    3,    4,    4,    4,    4,
			    4,    4,    4,    4,    4,    4,    4,    4,    4,    4,
			    4,    5,    5,    6,    7,    8,    9,   10,   11,   12,
			   12,   12,   12,   12,   12,   12,   12,   12,   12,   12,
			   12,   12,   12,   12,   12,   12,   12,   12,   12,   12,
			   12,   12,   12,   12,   12,   12,   12,   12,   12,   12,
			   12,   12,   12,   12,   12,   12,   12,   12,   12,   12,

			   12,   12,   12,   12,   12,   12,   12,   15,   15,   15,
			   15,   15,   15,   15,   15,   15,   16,   16,   16,   16,
			   16,   16,   16,   16,   16,   16,   16,   16,   16,   16,
			   16,   16,   16,   16,   16,   16,   16,   16,   16,   16, yyDummy>>)
		end

	yydefact_template: SPECIAL [INTEGER]
			-- Template for `yydefact'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 1103)
			yydefact_template_1 (an_array)
			yydefact_template_2 (an_array)
			Result := yyfixed_array (an_array)
		end

	yydefact_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yydefact'.
		do
			yyarray_subcopy (an_array, <<
			   15,  624,  624,  519,  518,  517,  516,  625,  340,  625,
			    0,  515,  514,    0,   48,    1,  625,  625,  625,  342,
			    6,    3,    0,  589,  597,  596,  595,  594,  593,  592,
			  591,  590,  588,  587,  586,  585,  584,  583,  582,  581,
			  580,  579,  578,  574,  577,  573,  576,  518,  516,    0,
			    0,    0,  384,    0,  499,    0,  448,  493,  494,  544,
			  543,    0,    0,  625,    0,  625,  545,  561,  552,  569,
			    0,    0,    0,    0,  467,    0,    0,  410,  449,  490,
			  424,  540,  534,  495,  413,  539,  496,  457,    4,  419,
			  458,  491,  485,    0,  499,  535,  417,  465,  536,  497,

			  411,  412,  478,  477,  537,  418,  466,  538,  450,  541,
			  572,  570,  571,  492,  464,  486,  487,  338,  512,  511,
			  510,  509,  508,  507,    0,    0,    0,    0,    0,    0,
			  513,  506,  254,  625,    2,  219,  218,  228,  229,  231,
			  222,  237,  220,  221,  238,   49,   50,    0,   50,   72,
			  629,    0,  627,  629,   43,  627,  629,    0,  625,    0,
			   81,   82,   83,   79,   77,   75,  629,    0,  425,    0,
			    0,  542,    0,    0,  408,  389,  388,  391,  625,    0,
			  485,  392,  390,  385,  377,  601,  600,  599,  598,   85,
			    0,  625,  475,  619,  618,  617,  616,  615,  614,  613,

			  612,  611,  610,  609,  608,  607,  606,  605,  604,  603,
			  602,   84,    0,    0,  511,  510,    0,    0,  245,  244,
			    0,  246,  519,  518,  517,  516,  515,  514,    0,    0,
			  620,    0,  455,  456,    0,   81,  453,  622,    0,    0,
			  451,  625,  462,  563,  551,  460,  562,  550,  461,    0,
			  625,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,  463,  488,    0,    0,  546,  566,  555,    0,    0,
			    0,  575,  625,  343,    0,  233,  223,    0,  232,  224,
			  234,  225,  240,  239,    0,  249,    0,    0,  251,  250,

			  547,  548,  549,  553,  554,    0,    0,  248,  253,  247,
			  252,  625,  255,  230,  626,    0,    0,   51,   46,   52,
			   53,    0,   50,   45,   73,  627,   18,    0,  629,  625,
			   16,   34,    0,    0,   32,   38,  532,  528,  529,   37,
			  629,  530,  531,  558,  559,  560,  564,  565,  533,    0,
			   72,    0,  625,    8,  629,  162,  341,    0,   78,    0,
			   80,  627,   92,    0,    0,    0,    0,    0,  404,  157,
			  625,    0,  625,  382,    0,   54,    0,  500,    0,  482,
			  468,  499,  481,  469,  408,    0,  416,  502,  629,    0,
			  629,  498,    0,    0,  470,    0,  436,  435,  434,  433,

			  432,  431,  430,  443,  445,  444,  446,  422,  423,  421,
			  420,    0,  437,  442,    0,  439,  441,  447,  473,  474,
			  499,  568,  557,  567,  556,  339,    0,    0,  236,  226,
			  235,  227,    0,    0,    0,  257,    0,    0,    0,  241,
			  243,  271,  505,  504,   47,  625,   43,   28,   24,  627,
			   43,   27,   30,    0,  160,    0,  627,   72,  485,  214,
			  629,   89,   88,   87,   90,    0,   93,    0,  625,   15,
			  186,   92,  416,  426,  337,  499,  499,  629,    0,  392,
			  393,    0,  380,    0,  167,  378,  499,  629,    0,  489,
			  405,    0,  627,    0,  454,    0,    0,  452,  629,  629,

			  438,  440,  479,  344,    0,    0,  242,  256,  259,  629,
			    0,  625,  173,   26,   35,   37,   31,   43,   72,   44,
			    0,    0,    0,  215,   72,    0,  211,   91,   86,   76,
			  102,  625,   54,   74,    0,   15,  427,  480,  409,    0,
			  629,  485,  383,  397,  399,  395,  464,  629,   54,   55,
			  200,  392,  476,    0,  483,  484,    0,    0,  621,  623,
			  471,  165,    0,  345,  345,  627,  258,  262,  506,    0,
			  263,  264,  272,   41,    0,   54,  627,   33,   29,   39,
			   44,   72,  163,  217,   72,  213,    0,   20,   97,  187,
			  102,   54,    0,  158,  629,  627,  398,    0,  381,  202,

			  178,  376,  501,  429,  503,  459,    0,  346,    0,    0,
			    0,  627,    0,  627,  265,    0,  174,   10,   43,   40,
			  161,  216,  103,   15,  624,    0,   54,   94,   92,  100,
			  428,    0,    0,  394,  392,  204,  625,  625,    0,    0,
			  348,  485,  336,  335,  260,    0,   72,    0,    0,    0,
			  280,  274,  278,   42,  106,   36,  105,  521,  104,  526,
			  520,   20,  522,  523,  524,  525,  527,   54,   21,  625,
			   20,   99,   15,  387,  396,  379,  625,  201,  625,  186,
			  350,    0,  186,  170,  169,  168,  205,  472,    0,  266,
			  269,  268,  628,  506,  267,  276,  277,  281,  627,  629,

			  625,   11,  624,   96,   98,  629,   95,   54,  203,  629,
			  177,  625,  625,  186,  173,  172,  175,  207,  355,  347,
			  625,  627,    0,  279,    0,    0,    0,  107,    0,  106,
			  625,   16,  101,  180,    0,  351,    0,  176,  171,  209,
			  625,  186,    0,    0,    0,    0,    0,  625,  290,  288,
			  287,  289,  294,  275,  273,    0,  254,  627,   72,  115,
			  629,   12,  629,   22,    0,    0,  186,  350,    0,  625,
			  199,  494,    0,  191,  190,  424,  413,  197,  188,  196,
			  189,    0,  458,  198,  485,  193,  195,  627,  186,  194,
			  412,  192,  338,  629,  353,  629,  625,  206,  356,  166,

			    0,  270,    0,    0,  625,  282,  110,  114,    0,  113,
			  625,  625,  625,  625,  625,  145,  149,  153,    0,  126,
			  108,  625,    0,  625,    0,  338,  186,  407,  408,  406,
			  408,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			  185,  186,  343,  182,  627,    0,  208,  627,  629,  291,
			  286,    0,    0,  625,  112,  148,  156,    0,  152,  129,
			    0,  146,  149,  150,  153,  154,    0,  116,  127,  145,
			  136,    0,    0,    0,  186,    0,    0,  402,  408,  186,
			  414,  365,  363,  408,  408,  361,  364,  362,  184,  338,
			    0,    0,  352,    0,    0,  293,    0,  295,  143,  629,

			    0,  123,    0,  629,  625,  627,  629,  625,  153,    0,
			  117,  149,  625,  625,  370,  373,  627,  629,  186,  304,
			  625,  627,  629,  625,    0,    0,  349,  403,    0,  400,
			  408,  343,  186,  354,  294,    0,  284,  627,  142,  629,
			  627,    0,  122,   66,    0,    0,  128,  134,   72,  135,
			    0,  118,  153,    0,   13,    0,  625,  372,  625,  375,
			    0,  367,    0,    0,    0,  307,  186,  296,    0,    0,
			    0,    0,  415,  401,    0,  345,  283,  292,    0,  109,
			    0,  125,   68,  629,  131,  132,  119,    0,  138,    0,
			  629,  340,   63,  625,  627,  629,  371,  374,  369,  305, yyDummy>>,
			1, 1000, 0)
		end

	yydefact_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yydefact'.
		do
			yyarray_subcopy (an_array, <<
			  315,  317,  313,  311,  323,    0,  629,  309,    0,  186,
			  298,    0,  627,  629,  186,    0,  186,    0,  144,  124,
			  627,    0,  120,  627,    0,    0,  137,   15,   64,  625,
			   60,    0,   57,    0,    0,    0,  627,    0,    0,  297,
			    0,    0,    0,  300,  345,  186,  345,  334,    0,   67,
			    0,  625,  625,    0,   62,   65,  627,  629,   59,  316,
			  322,  330,    0,  321,  318,  319,  325,  320,  314,  328,
			    0,    0,  329,  324,  327,  326,  186,  299,  186,  302,
			    0,    0,    0,   69,  139,    0,    0,    9,  625,   14,
			  312,  310,  303,  332,  331,  333,  141,    0,   71,   61,

			  140,    0,    0,    0, yyDummy>>,
			1, 104, 1000)
		end

	yydefgoto_template: SPECIAL [INTEGER]
			-- Template for `yydefgoto'
		once
			Result := yyfixed_array (<<
			  325,  528,  469,  360,  742,  587,  575,  484,  354,  392,
			  283,  427,  179,   77,  828,  379,  368,   78,  773,  774,
			  334,  335,   79,  658,   80,   81,  470,   82,   83,  380,
			   84,  921,   85,  777,  321,  956,  993,  661,  988,  916,
			  778,   86,  779, 1012,  718,  905,   87,  387,   89,  781,
			   90,   91,  684,  714, 1056,  994,  948,  650,  651,  783,
			  982,  132,  133,   92,   93,   94,  785,  152,  340,  149,
			  328,  786,  787,  788,  341,   95,   96,  302,   97,   98,
			  685, 1003,   20,   99,  789,  382,  545,  757,  758,  100,
			  101,  102,  103,  342,  104,  105,  345,  106,  107,  901,

			  600,  791,  686,  485,  108,  109,  110,  111,  112,  211,
			  189,  464,  459,  113,  569,  135,  114,  136,  137,  138,
			  139,  140,  141,  750,  220,  142,  143,  144,  759,  155,
			  607,  608,  115,  116,  163,  164,  165,  350,  516,  872,
			  922,  990,  913,  870,  917,  968, 1013,  906,  815,  869,
			  388,  192, 1057,  954,  995,  851,  899,  166,  805,  861,
			  862,  863,  864,  865,  866,  512,  653,  907,  983,   14,
			  153,  150,  627,  117,  710,  793, 1006,  547,  373,  701,
			  760,  903,  819,  795,  713,  356,  460,  312,  313,  436,
			  509,  689,  477,  690,  638,  183,  184,  723,  848,  849,

			 1101,   15,  357,  326,  147,  654,  729,  821,  991, 1030,
			   16,  329,  351,  579,  615,  699,  148,  318, 1028,  711,
			  853,  550,  636,  676,  740,  796,  525,  438,  720,  697,
			  803,  896,  935,  158,  375,  551,  548,  634, yyDummy>>)
		end

	yypact_template: SPECIAL [INTEGER]
			-- Template for `yypact'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 1103)
			yypact_template_1 (an_array)
			yypact_template_2 (an_array)
			Result := yyfixed_array (an_array)
		end

	yypact_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yypact'.
		do
			yyarray_subcopy (an_array, <<
			 1359, 1199,  692, -32768, -32768, -32768, -32768,  968,  355, -32768,
			 2318, -32768, -32768, 3713,  158, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768,  647, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, 2687, 2318, 3536,
			  922,  922, 3803,  345,  139, 4166, -32768,  936,  926, -32768,
			 -32768, 3813, 3765,  911, 2839,  902, -32768, -32768, -32768, -32768,
			 2318, 2318,  908, 2318, -32768, 2564, 2441,  906, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768,  892, 4222, -32768,
			 -32768, -32768, -32768, 2318,  769, -32768, -32768, -32768, -32768, -32768,

			  894,  890, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, 2896, -32768, -32768,  515, -32768, 1287,
			  969, -32768, -32768, -32768, 1142, 3055,  462,  713, 1585, 1585,
			 -32768, -32768,  634, 3495, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768,  889, -32768, -32768,  886, -32768,  784,  280,  193,  140,
			 -32768,  248,  608, -32768, 1374,  307, -32768,  248,   75,  536,
			  848, -32768, -32768, -32768, -32768,  855, -32768, 3765,  841, 4016,
			 3713, -32768, 4063,  873,  495, -32768, -32768, -32768,  766,  867,
			  865,  687, -32768, -32768,  839, -32768, -32768, -32768, -32768, -32768,
			  462,  842, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,

			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768,  536,  536, -32768, -32768,  794,  794, -32768, -32768,
			  836, -32768, 3147, 3060, 3408, 3321,  335, 3234,  832,  834,
			 -32768, 2318, -32768, -32768, 2318, -32768, -32768, -32768, 2318, 4136,
			 -32768,  835, -32768, -32768, -32768, -32768, -32768, -32768, -32768,  536,
			 -32768, 2318, 2318, 2318, 2318, 2318, 2318, 2318, 2318, 2318,
			 2318, 2318, 2318, 2318, 2318, 2318, 2195, 2318, 2072, 2318,
			 2318, -32768, -32768,  536,  536, -32768, -32768, -32768,  248,  509,
			  504, -32768,  623,  423, 1142, -32768, -32768, 1142, -32768, -32768,
			 -32768, -32768, -32768, -32768,  847, -32768,  840,  819, -32768, -32768,

			 -32768, -32768, -32768, -32768, -32768,  528,  221, -32768, -32768, -32768,
			 -32768,  828, -32768, -32768, -32768,  248,  248, -32768, -32768, -32768,
			 -32768,  781,  784, -32768, -32768, -32768, -32768,  815, -32768, -32768,
			 -32768, -32768,  477,  463,  800, -32768, -32768, -32768, -32768,  814,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, 2920,
			  459,   43, -32768, -32768, -32768,  795, -32768, 2318, -32768, 4127,
			 -32768, -32768,   92,  806,  248,  248,  248,  248, -32768, -32768,
			 -32768,  536,  805, -32768, 3713,  602,  801, -32768, 2318,  735,
			 -32768,  769, -32768, -32768,  495, 3713, -32768, 4036, -32768, 4098,
			 -32768,  804,  798,  248, -32768, 2318,  448,  448,  448,  448,

			  448, 1102, 1102, 1781, 1781, 1781, 1781, 1781, 1781, 1781,
			 1781, 2318, 3993, 4115, 2318, 4298, 4261, -32768, -32768, -32768,
			  769, -32768, -32768, -32768, -32768, -32768, 2318,   30, -32768, -32768,
			 -32768, -32768,  248,  797,  796, -32768,  791, 3713,  790, -32768,
			 -32768,  783, -32768, -32768, -32768, -32768, 2724, -32768, -32768, -32768,
			 1374, -32768, -32768,   55, -32768,  771, -32768, 4056,  770, 1093,
			 -32768, -32768, -32768, -32768,  736,  647, -32768, 3713,  766,  114,
			 -32768,   39, 2318, -32768, -32768,  769,  769, -32768, 2318,  687,
			 -32768, 1826, -32768, 4063, -32768, -32768,  769, -32768,  536, -32768,
			 -32768,  755, -32768,  751, -32768,  752,  536, -32768, -32768, -32768,

			 3993, 4298, -32768, 4222, 2318, 2318, -32768, -32768,  740, -32768,
			 3666,  750,  622, -32768,  733, -32768, -32768, 1374,  459, -32768,
			  721, 3713,  248, -32768, 1949, 2318, -32768, -32768, -32768, -32768,
			  654, -32768,  602,  570, 3713,  114,  710, -32768, -32768,  731,
			 4222,  403, -32768, -32768, 4222,  730, 2872, -32768,  602, -32768,
			  678,  687, -32768,  725,  735, -32768, 2318, 2318, -32768, -32768,
			 -32768, -32768,  724, 1318, 1318, -32768, -32768, -32768,  351,  269,
			 -32768, -32768, -32768, -32768, 4063,  602, -32768, -32768, -32768, -32768,
			 -32768,  459, -32768, -32768, 4056, -32768,  248,  973, -32768, -32768,
			  654,  602,  248, -32768, -32768, -32768, -32768,  706, -32768,  670,

			  655, -32768, -32768, -32768, -32768,  711, 2318, -32768,  676,  675,
			 3713, -32768, 3713, -32768, -32768,  517, -32768, -32768, 2724, -32768,
			 -32768, -32768, -32768, 1423, 1813, 2847,  602, -32768,  609, -32768,
			 -32768,  679, 1826, -32768,  687, -32768,  693,  684,  563,  536,
			 4222,  664, -32768, -32768, -32768, 3690,   59, 3679,  462,  462,
			 -32768,  660, -32768, -32768,  595, -32768, -32768, -32768, -32768, -32768,
			 -32768,  590, -32768, -32768, -32768, -32768, -32768,  602, -32768, -32768,
			  590, -32768,  114, -32768, -32768, -32768,  693, -32768, -32768, -32768,
			  637, 4087, -32768, -32768, -32768, -32768,  624, -32768, 2318, -32768,
			 -32768, -32768, -32768,  648, -32768, -32768, -32768,  650, -32768, -32768,

			 3906, -32768,  638, -32768, -32768, -32768, -32768,  602, -32768, -32768,
			 -32768, 1808,  653, -32768,  622, -32768, -32768,  584,  586, 4222,
			 -32768, -32768, 1569, -32768,  517,  645,  462, -32768,  462,  595,
			 -32768,  559, -32768, -32768, 1703, -32768, 4087, -32768, -32768, -32768,
			   64, -32768,  620,  572, 3679,  781,  781, -32768, -32768, -32768,
			  579, -32768,  444, -32768, -32768,  631,  634, 1289,  459,  994,
			 -32768, -32768, -32768, -32768, 2318, 2318, -32768,  637,  910,   54,
			 -32768,  391, 3781, -32768, -32768,  661,  657, -32768, -32768, -32768,
			 4222,  652,  651, -32768,  156, -32768, -32768, 1518, -32768, -32768,
			  122, -32768,  192, -32768,  593, -32768,   64, -32768, -32768, -32768,

			  330, -32768, 1674,  551, -32768, -32768, -32768, -32768,  462, -32768,
			  213,  581,  826,   61,  754,  507,  465,  394,  577,  550,
			 -32768, 1082,  559, 3924, 3625,  515, -32768, -32768,  495, -32768,
			  216,   44, 2318, 2318, 1104,  578, 2318, 2318, 2318, 1703,
			  570, -32768,  423, -32768, -32768,  573, -32768, -32768, -32768,  566,
			 -32768,  553,  536, -32768, -32768, -32768, -32768,  536, -32768, -32768,
			  339, -32768,  465, -32768,  394, -32768,  552, -32768, -32768,  507,
			  534,  240,  191,  373, -32768,  233,  546, -32768,  495, -32768,
			 -32768, 4222, 4222,  495,  216, 4222, 4222, 4222, -32768,  515,
			  289, 4087, -32768,  572,  556, -32768,  535, -32768,  544, -32768,

			  462,  542,  514, -32768,  532,  799, -32768,  615,  394,  522,
			 -32768,  465, -32768,  375, 3787, 3787,  768, -32768, -32768, -32768,
			 -32768,  177, -32768,  176, 2318,  429, -32768, -32768,  471, -32768,
			  495,  423, -32768, -32768,  444, 1674, -32768, -32768, -32768, -32768,
			 -32768,  536, -32768, -32768,  781,  339, -32768, -32768,  459, -32768,
			  441, -32768,  394,  536, -32768,  290, -32768, 1456, -32768, 1456,
			  240, -32768,  432, 1202,  373, -32768, -32768, -32768,  168,  255,
			 3671, 2318, -32768, -32768,  376,  206, -32768, -32768,  536, -32768,
			  536, -32768,  414, -32768, -32768, -32768, -32768,  397,  406,  195,
			 -32768,  355, -32768,  899,  352, -32768, -32768, -32768, -32768, -32768, yyDummy>>,
			1, 1000, 0)
		end

	yypact_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yypact'.
		do
			yyarray_subcopy (an_array, <<
			  435,  419,  417,  364,  401,  547, -32768, -32768,  344, -32768,
			 -32768, 2318,  164, -32768, -32768, 1625, -32768,  336, -32768, -32768,
			 -32768,  346, -32768, -32768,  343,  341, -32768,  114,  339, -32768,
			 -32768,  290, -32768, 2011, 1202, 1328, -32768, 1202,  249, -32768,
			  276, 3605,  255, -32768,  206, -32768,  206, -32768,  781, -32768,
			  536, -32768, -32768,  246, -32768, -32768,  334, -32768, -32768, -32768,
			 -32768, -32768,  179, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			  489, 1202, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			  243,  197,  162, -32768, -32768,  167,  128, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768,  127, -32768, -32768,

			 -32768,  151,   97, -32768, yyDummy>>,
			1, 104, 1000)
		end

	yypgoto_template: SPECIAL [INTEGER]
			-- Template for `yypgoto'
		once
			Result := yyfixed_array (<<
			 -326, -32768, -420, -32768, -32768,  527,  400,  521, -339, -32768,
			 -683, -776, -32768, -32768, -458,  607, -352, -32768, -32768, -32768,
			 -401, -32768, -32768, -32768, -635,   34, -32768,  -19, -32768, -180,
			 -644, -32768, -125, -32768, -32768, -855, -32768,  473, -32768, -32768,
			 -32768,  737, -32768, -32768, -32768, -32768, -32768,   31,  487, -32768,
			 -654, -32768, -32768, -32768, 1064, -32768, -32768, -32768, -32768, -32768,
			  762, -174, -306,    3,  703,  -10, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768,  -87, -104, -110, -32768,  -59,  -65,
			 -32768, -32768,   78, -32768, -32768,  574, -32768, -32768, -32768, -32768,
			 -384, -32768, -32768, -32768,  -32,  -84, -32768, -102, -116, -32768,

			 -32768, -32768, -32768, -448, -32768,  -22, -624,   -6, -32768,  709,
			 -32768, -32768, -32768,  614,   23, -669,  -44, -673,  935, -32768,
			  -47,  -13,  -98, -32768,  292,  -43, -675, -32768, -32768, -32768,
			  185, -545,  -18,  -21,  -42, -147, -32768, -368,  438, -32768,
			   90,    2, -32768, -32768,   91, -32768,    6,  101,  222, -32768,
			 -204,  -66,  -45, -32768,    8, -646,   57,  569,   99,  272,
			  159,  267, -775,  266, -727, -32768,  300, -851,  -33, -443,
			 -294,  571, -413, -660,  306,  166,  -64,  378, -403,  274,
			 -747,   24,  198,  107,  229, -211,  470, -32768,  238, -503,
			  382, -451,   -5, -473, -32768,  618, -32768, -32768,   42,  257,

			 -32768, -32768,   -7,  669, -32768, -32768, -32768, -32768, -32768, -118,
			   18,  689, -32768,  393, -32768, -32768, -32768, -109, -32768, -449,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768,
			 -32768, -32768, -32768, -32768, -32768, -32768, -32768, -32768, yyDummy>>)
		end

	yytable_template: SPECIAL [INTEGER]
			-- Template for `yytable'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 4322)
			yytable_template_1 (an_array)
			yytable_template_2 (an_array)
			yytable_template_3 (an_array)
			yytable_template_4 (an_array)
			yytable_template_5 (an_array)
			Result := yyfixed_array (an_array)
		end

	yytable_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			   18,  162,   22,   13,  161,  172,  173,  174,  182,  151,
			  154,  157,  358,  156,  218,  443,  376,  301,  221,  609,
			   17,  533,  236,  300,  452,  160,  532,  171,  272,  338,
			  308,  310,  490,  383,  390,  448,  134,  571,  347,  323,
			  299,   88,  181,  162,  301,  514,  161,  751,  219,  749,
			  300,  535,  346,  748,  498,  180,  231,  715,  238,  570,
			  958,  854,  304,  957,  959,  228,  890,  235,  303,  394,
			  344,  425,  285,  288,  792, -210,  542,  290,  168,  169,
			  782,  294,  518,  305,  588,  229,  534,  908,   61,  304,
			  776,   65,  591,  418,  419,  303,  691, 1103,  505,  775,

			  598,  239,  240,  880,  242,  324,  286,  289,  281,  842,
			  349,  291,  794, -210,  519,  307,  309,   51,  308,  310,
			 -151,  468,  343, -210,  271, -360,  314,  751,  293,  749,
			  298,  523,  348,  748, -210,  337,  952,  909,  162,  467,
			  -25,  161,  875,  629,  626,  504,  879,  442,  601,  577,
			  274, 1102,  466,  939,  327,  974, -210,  339,   -5,  838,
			  355, -151,  160, -210,  855,  856,  281,  858,  191, 1100,
			  228,  370, 1097, 1054,  487,  285,  288, 1055,  671,  792,
			  667,  950,  190,  582,  378,  782,  324, -210,  336, -210,
			  363,  499,  578,  229,  837,  776,  694,  -25,  583,  -25,

			  -25,  -25,  381,  381,  775,  466,  931,  278,  672,  286,
			  289, 1096,  -25,  444,  275,  146,  -25,  514,  145,  704,
			  -25, 1095,  -25, -301, 1025,  987,    2, 1010,    1,  707,
			  -25,  675,  -25,  -25,  393,  967, -308,  428,  -25,  381,
			  430, -301, 1024,  395,  367, 1009,   12,   11,  703,  -25,
			  919,   12,   11,  966, -308,  620, 1094,  706,  621,  732,
			  751,  949,  749,  381,  381,  389,  748,  794,  918,  827,
			  801,  429, -147,  322,  431,  317,  841,  292,   12,   11,
			  282,  420,  396,  397,  398,  399,  400,  401,  402,  403,
			  404,  405,  406,  407,  408,  409,  410,  412,  413,  415,

			  416,  417, 1093,  915,  437, 1087,  614, -159, -147,  293,
			  996,  606,  997, -147,  914,  489,  560,  613,  439,  440,
			  692,  338,  154,    6,    5,  338,    4,    3,    6,    5,
			  347,    4,    3, 1011,  347, 1077,  301,  924,  606,  840,
			  301,  320,  300,  281,  346,  157,  300,  454,  346, -159,
			  790, 1076,  319,  604,  502,    6,    5,  505,    4,    3,
			  458,  479,  344,  478, -159,  481,  344,  473,  474,  475,
			  476, -513,  878,  992,  727,  705,  883,  612,  847, -513,
			  932,  304,  904, -159, 1052,  304, 1051,  303,  457, -159,
			 1049,  303,  338,  -70,  833, 1047,  355,  482,  612,  611,

			 -159,  347,  349, 1039,  504, 1037,  349,  301,  491,  537,
			  538,  -58, 1036,  300,  343,  346, -159,  -70,  343,  213,
			  552, 1035,  -70, 1034,  348,  677,  930,  337,  348,  832,
			 1017,  337,  809,  344,  -56,  506,  762,  546,  151, 1033,
			  -58,  652,  500,   19,  162,  501,  -70,  161,  -70,  515,
			 -162,  456,  304,  515, 1023,  790, 1022,  503,  303,  687,
			  508,  531, 1020,  -56,  -58,  708,  -58, 1016,  160,  188,
			  187,  251,   74,  349,  695,  696,  877,  549,  381,  920,
			  336,  541,  186,  185,  336,  343,  381,  -56,  859,  -56,
			  530,  999,  131,  338,  811,  348,  247,  246,  337, 1080,

			  986, 1082,  347,  536,  573,  324,  434,  433,  301,  540,
			  244,  243,  544,  663,  300,  663,  346,  278,  804,  662,
			  515,  662,  277,  367,  157,  355,  927,  426,  458,  797,
			  972,  929,  490,  971,  344,  563,  564,  424,  423,  665,
			  281,  665,  422,  421,  581,  434,  433,  131, 1085, 1086,
			  652,  336,  755,  304,  756,  584,  457,  590,  831,  303,
			  813,  277,  245,  248,  434,  433,   12,   11,  616,  123,
			  122,  121,  215,  214,  349,  278,  943,  118,  973, 1004,
			  277,  951,  275,  941, 1053,  846,  343,  603,  546,  622,
			  940,  664,  937,  664,  936,  630,  348,  649,   55,  337,

			  934,   53,  800,  282,  660,  926,  660,  912,  -23,  641,
			  810,  910,  897,  648,  895,  892,  589,  666,  763,  666,
			  683,  515,  985,  884,  123,  122,  121,  215,  214,  381,
			  678,  814,  118,  508,  756,  646,  867,  640,  443,  682,
			 -155,  844,  669,    6,    5,  681,    4,    3,  812, 1061,
			 1066, 1069,  336, 1075, -358,  836,  680,  659, -133,  659,
			 -359, -133,  154,  544, -357,  -23,  712,  -23,  -23,  -23,
			  311,  157,  679,  709, -133,  806, -285,   12,   11,  799,
			  -23,  700,  754,  947,  -23,  741,  739, 1004,  -23,  574,
			  -23, -210,  -17,  728,  483,  735,  721,  668,  -23,  722,

			  -23,  -23,  702,  717,  734,  736,  -23,  159,  698,   55,
			 -133,  688,   53,  743, -210, -133,  372,  -23, -133,  719,
			  730,  673,  466,  154,  830,  218,  756, -210, -210,  221,
			  297,  296,  307,  309,  643,  642,  310,  784, -210,  639,
			  802, -179,  443,   12,   11,  637,   68,  635,  633,  -17,
			 -210,  -17,  -17,  -17,    6,    5,  170,    4,    3,  219,
			 -179,  605,  586,  488,  -17,  780, -179,  602,  -17, -210,
			  442,  829,  -17,  593,  -17, -210,  599, -179,  595,  592,
			  580,  576,  -17, -210,  -17,  -17, -210,  572,  565,  559,
			  -17,  270,  558, -179,  981,  823,  824,  852,  191,  556,

			  324,  -17, -210,  852,  852,  857,  852,  860,  369,  527,
			  898,  131,  130,  -72,  871,  902,  873,  524,  521,  511,
			    6,    5,  330,    4,    3,  353,  510, -368,  507,  424,
			  422,  162,  496,  829,  161,  362,  162,  829, 1000,  161,
			  497, -368,  784,  456,  352,  486,  900,  480,  449,  -72,
			  472, -368,  247,  301,  -72,  235, -368,  -72, -130,  300,
			  235,  450,  446,  881,  882,  435,  317,  885,  886,  887,
			  780,  270,  270,  244,  442,  432, 1002, -164,  386,  385,
			 -368,  384, -368,  306,  377, -121,  374,  829,  123,  122,
			  121,  215,  214, -386, -130,  371,  118,  944,  304, -130,

			  852,  366, -130,  361,  303,  953,  955, -121, 1059, 1063,
			  364,  989, 1072,  963,  316,  359,  969,  315,  274, 1005,
			  162, -121,  273,  161,  301,  301, -121,  301,  250, -121,
			  300,  300,  162,  300,  249,  161,  898,  241,  902,  237,
			   12,   11,  270,  270,  160,  270, 1000, 1065, 1068,  852,
			 1074,  852,  230,  170,  213,  970,  235,  162,  -14,  162,
			  161,  301,  161,  827,  212,  170, 1001,  300,   -7,  304,
			  304, 1099,  304,  619,  270,  303,  303,  977,  303,  752,
			  471,  235,  -14,  235, 1002,  625, 1029,  -14,  716, 1062,
			 1005, 1070,  644, 1005,  807,  585,  826,  447,  933,  131, yyDummy>>,
			1, 1000, 0)
		end

	yytable_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			  130,  850, 1015,  761, 1019,  888,  304, 1090,  989,  451,
			  674,  -14,  303,  -14,  445, 1083,  513,    6,    5,  737,
			    4,    3,   22,  455,  753,  818,  817, 1005,  911,  162,
			  -15,  816,  161,  976,  529, 1018, 1060, 1064, 1067, 1058,
			 1073,  868, 1041, 1098,  437,  437,  984,  798, 1079,  -15,
			  465,  998, 1084,  235, 1007,  -15,  655,  493,  125,  495,
			  925,  295,  555,  -15,  835,  -15,  -15,  520,  463, 1027,
			  287,  -15,  825,   21, 1001,  814,  123,  122,  121,  215,
			  214,   22,  -15,  441,  118,  624,  623,    1,  453,  813,
			  270,  812,  270, -212,  811,  554,  617,  810,  670,  270,

			  270,  270,  270,  270,  270,  270,  270,  270,  270,  270,
			  270,  270,  270,  270,  738,  270,  270,  628,  270,  270,
			  270,  255,  254,  253,  252,  251,   74,    0,    0,  526,
			    0,    0,  876,    0,   12,   11,    0,    0,  517,    0,
			    0, -366,    0,    0,    0,  522,  539,  889,    0,    0,
			 -212,    0, -212,    0,    0, -366,  553,  827,    0,    0,
			  270, -212,    0,    0,    0, -366,    0,  561,  562, -212,
			 -366,    0,  131,  130,    0, -212,    0,    0,  566,    0,
			  923,  557,    0, -212, -212,  928, -212,    0,    0,    0,
			    0,    0, -212,  306, -366, -212, -366, -212, -212,  -19,

			    0,    0, -212,  270,  270, -212,  270, -212, -212,  594,
			    0,    6,    5,    0,    4,    3,  597,    0,    0,  297,
			  296,    0,    0,    0,  962,    0,    0,    0,    0,    0,
			    0,  125,   12,   11,    0,   68,    0,   66,  975,  270,
			    0,    0,    0,  270,    0,  170,    0,  270,    0,  123,
			  122,  121,  215,  214,  610,    0,  -19,  118,  -19,  -19,
			  -19,    0,    0,  631,    0,  618,  270,  270,    0,    0,
			    0,  -19, 1008,    0,    0,  -19,    0,    0,    0,  -19,
			    0,  -19,    0,    0,  632,   50,    0,  270,    0,  -19,
			    0,  -19,  -19,    0,    0,    0,    0,  -19,    0,    0,

			  645,    0,  647,    0,    0,    0,  270,    0,  -19,    6,
			    5,    0,    4,    3,    0, 1040,    0,  131,  130,    0,
			 1044,    0, 1046,  269,  268,  267,  266,  265,  264,  263,
			  262,  261,  260,  259,  258,  257,  256,  255,  254,  253,
			  252,  251,   74,  270,    0,  297,  296,    0, -111,    0,
			    0, 1081, -111,    0,    0,    0,    0,    0,   12,   11,
			    0,   68, -111, -111,    0,    0,    0,    0,  725,    0,
			    0,  170, -111,    0,  731, -111,  125, -111,  733,    0,
			    0,    0, 1091,    0, 1092,    0,    0,  724,  284,   12,
			   11,  333,  332,    0,  123,  122,  121,  215,  214,    0,

			    0, -111,  118, -111,   12,   11,   69,   68,   67,   66,
			  744,   50,    0,    0,    0,    0,    0,  170,    0,    0,
			  331,    0,  270,  606,    0,   60,   59,    0,    0,  820,
			   10,  822,    0,    0,    0,    6,    5,    0,    4,    3,
			  333,  332,    9,    0,    0,    0,  808,    8,    0,    7,
			    0,    0,    0,    0,    0,   69,   68,   67,  657,    0,
			    0,    0,  843,    0,  845,    0,    6,    5,    0,    4,
			    3,    2,    0,    1,   60,   59,  839,    0,  656,    0,
			    0,    6,    5,  270,    4,    3,  -65,  -65,    0,    0,
			   46,   45,   44,   43,   42,   41,   40,   39,   38,   37,

			   36,   35,   34,   33,   32,   31,   30,   29,   28,   27,
			   26,   25,   24,   23,    0,    0,    0,  894,  -65,    0,
			    0,  -65,    0,    0,    0,    0,  270,  270,    0,    0,
			    0,    0,    0,  891,    0,    2,  893,    1,    0,   46,
			   45,   44,   43,   42,   41,   40,   39,   38,   37,   36,
			   35,   34,   33,   32,   31,   30,   29,   28,   27,   26,
			   25,   24,   23,  -65,  -65,    0,  -65,  -65,  938,    0,
			    0,    0,  942,    0,    0,  946,    0, -183,    0,    0,
			    0,    0,    0,    0,  270,  270,  961,    0,  270,  270,
			  270,  965,    0,    0,  945, -183, -183, -183,    0,  131,

			  130,    0,    0,    0,    0,  960, -183,    0,  979, -183,
			  964,    0,  747,    0,  746,  131,  130, -183,    0,  745,
			    0,    0, -183, -183, -183,    0,  978,    0,    0,  980,
			  269,  268,  267,  266,  265,  264,  263,  262,  261,  260,
			  259,  258,  257,  256,  255,  254,  253,  252,  251,   74,
			    0,    0, 1021,    0,    0,    0,    0,    0,  125, 1026,
			    0,    0,    0,    0, 1032,    0,    0,    0,    0,    0,
			  124,    0,    0,  270,  306, 1038,  123,  122,  121,  120,
			  119,    0, 1043, 1031,  118,    0,    0,    0,    0,    0,
			    0,    0,  123,  122,  121,  215,  214,    0,    0,    0,

			  118, 1042,    0,    0,  131,  130,    0,    0,    0, 1048,
			    0,    0, 1050,    0,    0,    0, 1045,    0,  270,  746,
			   76,   75,    0,    0,  745, 1071, 1089,   74,   73,   72,
			   71,    0,   70,   12,   11,   69,   68,   67,   66,   65,
			    0,    0,   64,   63,  270, 1088,   62,    0,  772,    0,
			    0,    0,    0,    0,   60,   59,  771,  770,    0,   57,
			    0,   56,    0,  125,    0,   55,    0,   54,   53,   52,
			    0,    0,    0,    0,  769,  124,    0,  768,  767,    0,
			    0,  123,  122,  121,  120,  119,   50,  766,  765,  118,
			  764,    0,    0,    0,    0,    0,    0,   49,  257,  256,

			  255,  254,  253,  252,  251,   74,    0,    0,    0,    0,
			   48,    5,    0,   47,    3,    0,    0,    0,    0,   46,
			   45,   44,   43,   42,   41,   40,   39,   38,   37,   36,
			   35,   34,   33,   32,   31,   30,   29,   28,   27,   26,
			   25,   24,   23,   76,   75,    0,    0,    0,    0,    0,
			   74,   73,   72,   71,  589,   70,   12,   11,   69,   68,
			   67,   66,   65,    0,    0,   64,   63, -181,    0,   62,
			  -17,   61,  668,    0,    0,    0,  543,   60,   59,   58,
			    0,    0,   57,    0,   56, -181, -181, -181,   55,  -17,
			   54,   53,   52,    0,    0,  -17, -181,    0,    0, -181,

			   51,    0,    0,  -17,    0,  -17,  -17, -181,    0,   50,
			    0,  -17, -181, -181, -181,    0,    0,    0,    0,    0,
			   49,    0,  -17,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,   48,    5,    0,   47,    3,    0,    0,
			    0,    0,   46,   45,   44,   43,   42,   41,   40,   39,
			   38,   37,   36,   35,   34,   33,   32,   31,   30,   29,
			   28,   27,   26,   25,   24,   23,   76,   75,    0,    0,
			    0,    0,    0,   74,   73,   72,   71,    0,   70,   12,
			   11,   69,   68,   67,   66,   65,    0,    0,   64,   63,
			    0,    0,   62,    0,   61,  324,    0,    0,    0,    0, yyDummy>>,
			1, 1000, 1000)
		end

	yytable_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			   60,   59,   58,    0,    0,   57,    0,   56,    0,    0,
			    0,   55,    0,   54,   53,   52,    0,    0,    0,    0,
			    0,    0,    0,   51,    0,    0,    0,    0,    0,    0,
			    0,    0,   50,    0,    0,    0,    0,    0,    0,    0,
			    0,   12,   11,   49,    0,    0,   66,    0,    0,    0,
			    0,    0,    0,    0,  170,    0,   48,    5,    0,   47,
			    3,    0,    0,    0,    0,   46,   45,   44,   43,   42,
			   41,   40,   39,   38,   37,   36,   35,   34,   33,   32,
			   31,   30,   29,   28,   27,   26,   25,   24,   23,   76,
			   75,    0,    0,    0,   50,    0,   74,   73,   72,   71,

			    0,   70,   12,   11,   69,   68,   67,   66,   65,    0,
			    0,   64,   63,    0,    0,   62,    0,   61,    6,    5,
			    0,    4,    3,   60,   59,   58,    0,    0,   57,    0,
			   56,    0,    0,    0,   55,    0,   54,   53,   52,    0,
			    0,    0,    0,    0,    0,    0,   51,    0,    0,  414,
			    0,    0,    0,    0,    0,   50,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,   49,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,   48,
			    5,    0,   47,    3,    0,    0,    0,    0,   46,   45,
			   44,   43,   42,   41,   40,   39,   38,   37,   36,   35,

			   34,   33,   32,   31,   30,   29,   28,   27,   26,   25,
			   24,   23,   76,   75,    0,    0,    0,    0,    0,   74,
			   73,   72,   71,    0,   70,   12,   11,   69,   68,   67,
			   66,   65,    0,    0,   64,   63,    0,    0,   62,    0,
			   61,    0,    0,    0,    0,    0,   60,   59,   58,    0,
			    0,   57,    0,   56,    0,    0,    0,   55,    0,   54,
			   53,   52,    0,    0,    0,    0,    0,    0,    0,   51,
			    0,    0,    0,    0,    0,    0,    0,    0,   50,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,   49,
			    0,    0,    0,    0,    0,    0,    0,  411,    0,    0,

			    0,    0,   48,    5,    0,   47,    3,    0,    0,    0,
			    0,   46,   45,   44,   43,   42,   41,   40,   39,   38,
			   37,   36,   35,   34,   33,   32,   31,   30,   29,   28,
			   27,   26,   25,   24,   23,   76,   75,    0,    0,    0,
			    0,    0,   74,   73,   72,   71,    0,   70,   12,   11,
			   69,   68,   67,   66,   65,    0,    0,   64,   63,    0,
			    0,   62,    0,   61,    0,    0,    0,    0,    0,   60,
			   59,   58,    0,    0,   57,    0,   56,    0,    0,    0,
			   55,    0,   54,   53,   52,    0,    0,    0,    0,    0,
			    0,    0,   51,    0,    0,    0,    0,    0,    0,    0,

			    0,   50,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,   49,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,   48,    5,    0,   47,    3,
			    0,    0,    0,    0,   46,   45,   44,   43,   42,   41,
			   40,   39,   38,   37,   36,   35,   34,   33,   32,   31,
			   30,   29,   28,   27,   26,   25,   24,   23,   76,   75,
			    0,    0,    0,    0,    0,   74,   73,   72,   71,    0,
			   70,   12,   11,   69,  247,  246,   66,   65,    0,    0,
			   64,   63,    0,    0,  170,    0,   61,    0,    0,    0,
			    0,    0,   60,   59,   58,    0,    0,   57,    0,   56,

			    0,    0,    0,   55,    0,   54,   53,   52,    0,    0,
			    0,    0,    0,    0,    0,   51,    0,    0,    0,    0,
			    0,    0,    0,    0,   50,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,   49,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,   48,    5,
			    0,    4,    3,    0,    0,    0,    0,   46,   45,   44,
			   43,   42,   41,   40,   39,   38,   37,   36,   35,   34,
			   33,   32,   31,   30,   29,   28,   27,   26,   25,   24,
			   23,   76,   75,    0,    0,    0,    0,    0,   74,   73,
			   72,   71,    0,   70,   12,   11,   69,  244,  243,   66,

			   65,    0,    0,   64,   63,    0,    0,  170,    0,   61,
			    0,    0,    0,    0,    0,   60,   59,   58,    0,    0,
			   57,    0,   56,    0,    0,    0,   55,    0,   54,   53,
			   52,    0,    0,    0,    0,    0,    0,    0,   51,    0,
			    0,    0,    0,    0,    0,    0,    0,   50,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,   49,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,   48,    5,    0,    4,    3,    0,    0,    0,    0,
			   46,   45,   44,   43,   42,   41,   40,   39,   38,   37,
			   36,   35,   34,   33,   32,   31,   30,   29,   28,   27,

			   26,   25,   24,   23,   76,   75,    0,    0,    0,    0,
			    0,   74,   73,   72,   71,    0,   70,   12,   11,   69,
			   68,   67,   66,   65,    0,    0,   64,   63,    0,    0,
			  167,    0,   61,    0,    0,    0,    0,    0,   60,   59,
			   58,  333,  332,   57,    0,   56,    0,    0,    0,   55,
			    0,   54,   53,   52,   12,   11,   69,   68,   67,   66,
			    0,   51,    0,    0,    0,    0,    0,  170,    0,    0,
			   50,    0,    0,    0,    0,   60,   59,    0,    0,    0,
			    0,   49,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,   48,    5,    0,   47,    3,    0,

			    0,    0,    0,   46,   45,   44,   43,   42,   41,   40,
			   39,   38,   37,   36,   35,   34,   33,   32,   31,   30,
			   29,   28,   27,   26,   25,   24,   23,    0,    0,    0,
			    0,    6,    5,    0,    4,    3,    0,    0,    0,    0,
			   46,   45,   44,   43,   42,   41,   40,   39,   38,   37,
			   36,   35,   34,   33,   32,   31,   30,   29,   28,   27,
			   26,   25,   24,   23,  333,  332,    0,    0,  234,   12,
			   11,    0,    0,    0,    0,    0,    0,    0,    0,   69,
			   68,   67,  657,    0,    0,    0,    0,    0,    0,  280,
			  279,    0,  233,    0,    0,  232,    0,    0,   60,   59,

			  278,   55,  656,    0,   53,  277,  276,  275,    0,    0,
			    0,    0,    0,  280,  279,    0,    0,    0,    0,    0,
			    0,    0,  596,    0,  278,    0,    0,    0,    0,  277,
			  276,  275,    0,    0,    0,    0,    0,  280,  279,    0,
			    0,    0,    0,    0,    0,    0,    6,    5,    0,    4,
			    3,    0,    0,  277,  276,  275,    0,    0,    0,    0,
			    0,    0,    0,   46,   45,   44,   43,   42,   41,   40,
			   39,   38,   37,   36,   35,   34,   33,   32,   31,   30,
			   29,   28,   27,   26,   25,   24,   23,    0,   46,   45,
			   44,   43,   42,   41,   40,   39,   38,   37,   36,   35, yyDummy>>,
			1, 1000, 2000)
		end

	yytable_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			   34,   33,   32,   31,   30,   29,   28,   27,   26,   25,
			   24,   23,   46,   45,   44,   43,   42,   41,   40,   39,
			   38,   37,   36,   35,   34,   33,   32,   31,   30,   29,
			   28,   27,   26,   25,   24,   23,   46,   45,   44,   43,
			   42,   41,   40,   39,   38,   37,   36,   35,   34,   33,
			   32,   31,   30,   29,   28,   27,   26,   25,   24,   23,
			 -510,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0, -510,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,   12,   11,    0,    0,    0,
			  131,  130,    0,    0,    0,    0, -510, -510,  170,    0,

			    0,    0, -510,    0, -510, -510, -510,    0, -510,    0,
			    0,  292,    0,    0,    0,    0,    0, -510,    0, -510,
			 -510,    0, -510,    0,    0, -510,    0,    0,    0,    0,
			    0,    0,    0,    0, -510,    0, -510,    0,    0,    0,
			    0,    0, -510, -510,    0,    0,    0, -511, -510,  125,
			 -510,    0, -510, -510,    0,    0,    0, -510, -510, -511,
			    0,  287,    6,    5,    0,    4,    3,  123,  122,  121,
			  215,  214, -510, -510, -510,  118,    0,  131,  130,    0,
			    0,    0,    0, -511, -511,    0,    0,    0,    0, -511,
			    0, -511, -511, -511,    0, -511,    0,    0,    0,    0,

			    0,    0,    0,    0, -511,    0, -511, -511,    0, -511,
			    0,    0, -511,    0,    0,    0,    0,    0,    0,    0,
			    0, -511,    0, -511,    0,    0,    0,    0,    0, -511,
			 -511,    0,    0,    0, -506, -511,  125, -511,    0, -511,
			 -511,    0,    0,    0, -511, -511, -506,    0,  284,    0,
			    0,    0,    0,    0,  123,  122,  121,  215,  214, -511,
			 -511, -511,  118,    0, -506, -506,    0,    0,    0,    0,
			 -506, -506,    0,    0,    0,    0, -506,    0, -506, -506,
			 -506,    0, -506,    0,    0,    0,    0,    0,    0,    0,
			    0, -506,    0, -506, -506,    0, -506,    0,    0, -506,

			    0,    0,    0,    0,    0,    0,    0,    0, -506,    0,
			 -506,    0,    0,    0,    0,    0, -506, -506,    0,    0,
			    0, -507, -506,    0, -506,    0, -506, -506,    0,    0,
			    0, -506, -506, -507,    0,    0,    0,    0,    0,    0,
			    0, -506, -506, -506, -506, -506, -506, -506, -506,    0,
			    0, -507, -507,    0,    0,    0,    0, -507, -507,    0,
			    0,    0,    0, -507,    0, -507, -507, -507,    0, -507,
			    0,    0,    0,    0,    0,    0,    0,    0, -507,    0,
			 -507, -507,    0, -507,    0,    0, -507,    0,    0,    0,
			    0,    0,    0,    0,    0, -507,    0, -507,    0,    0,

			    0,    0,    0, -507, -507,    0,    0,    0, -508, -507,
			    0, -507,    0, -507, -507,    0,    0,    0, -507, -507,
			 -508,    0,    0,    0,    0,    0,    0,    0, -507, -507,
			 -507, -507, -507, -507, -507, -507,    0,    0, -508, -508,
			    0,    0,    0,    0, -508, -508,    0,    0,    0,    0,
			 -508,    0, -508, -508, -508,    0, -508,    0,    0,    0,
			    0,    0,    0,    0,    0, -508,    0, -508, -508,    0,
			 -508,    0,    0, -508,    0,    0,    0,    0,    0,    0,
			    0,    0, -508,    0, -508,    0,    0,    0,    0,    0,
			 -508, -508,    0,    0,    0, -261, -508,    0, -508,    0,

			 -508, -508,    0,    0,    0, -508, -508, -261,    0,    0,
			    0,    0,    0,    0,    0, -508, -508, -508, -508, -508,
			 -508, -508, -508,    0,    0, -261, -261,    0,    0,    0,
			    0,    0, -261,    0,    0,    0,    0, -261,    0, -261,
			 -261, -261,    0, -261,    0,    0,    0,    0,    0,    0,
			    0,    0, -261,    0, -261, -261,    0, -261,    0,    0,
			 -261,    0,    0,    0,    0,    0,    0,    0,    0, -261,
			    0, -261,    0,    0,    0,    0,    0, -261, -261,  170,
			    0,    0,    0, -261,    0, -261,    0, -261, -261,    0,
			    0,    0, -261, -261,    0,    0,    0,    0,    0,    0,

			    0,    0, -261, -261, -261, -261, -261, -261, -261, -261,
			  269,  268,  267,  266,  265,  264,  263,  262,  261,  260,
			  259,  258,  257,  256,  255,  254,  253,  252,  251,   74,
			  269,  268,  267,  266,  265,  264,  263,  262,  261,  260,
			  259,  258,  257,  256,  255,  254,  253,  252,  251,   74,
			    0,    0,   46,   45,   44,   43,   42,   41,   40,   39,
			   38,   37,   36,   35,   34,   33,   32,   31,   30,   29,
			   28,   27,   26,   25,   24,   23,  269,  268,  267,  266,
			  265,  264,  263,  262,  261,  260,  259,  258,  257,  256,
			  255,  254,  253,  252,  251,   74,  568,  130,    0,    0,

			    0,    0,    0,  567,    0,    0,    0, 1078,    0,  693,
			  130,  129,    0,    0,    0,    0,  128,    0,    0,    0,
			  568,  130,    0,    0,  129,    0,    0,  874,    0,  128,
			    0,    0,    0,    0,    0,  129,  127,    0,    0,    0,
			  128,    0,    0,  131,  130,    0,  126,    0,    0,  127,
			    0,    0,    0,    0,    0,  125,    0,    0,  129,  126,
			  127,    0, 1014,  128,    0,    0,    0,  124,  125,    0,
			  126,    0,    0,  123,  122,  121,  120,  119,    0,  125,
			  124,  118,    0,  127,    0,    0,  123,  122,  121,  120,
			  119,  124,    0,  126,  118,  227,  226,  123,  122,  121,

			  120,  119,  125,    0,    0,  118,    0,    0,    0,    0,
			  129,  131,  130,    0,  124,  128,    0,  -64,  -64,    0,
			  123,  122,  121,  120,  119,    0,  834,    0,  118,    0,
			  904,  216,  178,   12,   11,  127,    0,    0,    0,    0,
			    0,    0,    0,  131,  130,  126,  170,    0,    0,  -64,
			    0,  127,  -64,  177,  125,    0,  176,    0,  217,  175,
			    0,  126,    0,  216,    0,   55,  124,    0,   53,    0,
			  125,    0,  225,  224,  121,  223,  222,    0,    0,    0,
			  118,    0,    0,  127,    0,    0,    0,    0,  123,  122,
			  121,  215,  214,  126,  -64,  -64,  118,  -64,  -64,    0,

			    0,    0,  125,    0,    0,    0,    0,    0,    0,    0,
			    6,    5,    0,    4,    3,    0,    0,    0,    0,    0,
			  123,  122,  121,  215,  214,    0,    0,    0,  118,  269,
			  268,  267,  266,  265,  264,  263,  262,  261,  260,  259,
			  258,  257,  256,  255,  254,  253,  252,  251,   74,  726,
			    0,    0,  324,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,  -72,    0,    0,    0,  -72,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,  -72,
			  -72,    0,    0, -306,    0,    0,    0,    0,    0,  -72,
			    0,    0,  -72,    0,  -72,    0,    0,    0,    0,    0, yyDummy>>,
			1, 1000, 3000)
		end

	yytable_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yytable'.
		do
			yyarray_subcopy (an_array, <<
			    0, -306,  265,  264,  263,  262,  261,  260,  259,  258,
			  257,  256,  255,  254,  253,  252,  251,   74,  -72,    0,
			  -72,  269,  268,  267,  266,  265,  264,  263,  262,  261,
			  260,  259,  258,  257,  256,  255,  254,  253,  252,  251,
			   74,  269,  268,  267,  266,  265,  264,  263,  262,  261,
			  260,  259,  258,  257,  256,  255,  254,  253,  252,  251,
			   74,  269,  268,  267,  266,  265,  264,  263,  262,  261,
			  260,  259,  258,  257,  256,  255,  254,  253,  252,  251,
			   74,    0,    0,    0,  492,  365,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,

			    0,    0,  324,  269,  268,  267,  266,  265,  264,  263,
			  262,  261,  260,  259,  258,  257,  256,  255,  254,  253,
			  252,  251,   74,  266,  265,  264,  263,  262,  261,  260,
			  259,  258,  257,  256,  255,  254,  253,  252,  251,   74,
			  494,  269,  268,  267,  266,  265,  264,  263,  262,  261,
			  260,  259,  258,  257,  256,  255,  254,  253,  252,  251,
			   74,    0,    0,    0,    0,    0,    0,    0,    0,    0,
			    0,    0,    0,    0,    0,    0,    0,    0,  391,   46,
			   45,   44,   43,   42,   41,   40,   39,   38,   37,   36,
			   35,   34,   33,   32,   31,   30,   29,   28,   27,   26,

			   25,   24,   23,   46,    0,   44,    0,   42,   41,   40,
			   39,   38,   37,   36,   35,   34,   33,   32,   31,   30,
			   29,   28,   27,   26,   25,   24,   23,  269,  268,  267,
			  266,  265,  264,  263,  262,  261,  260,  259,  258,  257,
			  256,  255,  254,  253,  252,  251,   74,  210,  209,  208,
			  207,  206,  205,  204,  203,  202,  201,  200,  199,  198,
			  197,  196,  195,  194,  462,  193,  461,  268,  267,  266,
			  265,  264,  263,  262,  261,  260,  259,  258,  257,  256,
			  255,  254,  253,  252,  251,   74,  210,  209,  208,  207,
			  206,  205,  204,  203,  202,  201,  200,  199,  198,  197,

			  196,  195,  194,    0,  193,  267,  266,  265,  264,  263,
			  262,  261,  260,  259,  258,  257,  256,  255,  254,  253,
			  252,  251,   74, yyDummy>>,
			1, 323, 4000)
		end

	yycheck_template: SPECIAL [INTEGER]
			-- Template for `yycheck'
		local
			an_array: ARRAY [INTEGER]
		once
			create an_array.make_filled (0, 0, 4322)
			yycheck_template_1 (an_array)
			yycheck_template_2 (an_array)
			yycheck_template_3 (an_array)
			yycheck_template_4 (an_array)
			yycheck_template_5 (an_array)
			Result := yyfixed_array (an_array)
		end

	yycheck_template_1 (an_array: ARRAY [INTEGER])
			-- Fill chunk #1 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			    7,   22,    9,    0,   22,   49,   50,   51,   52,   16,
			   17,   18,  159,   18,   61,  321,  190,  127,   61,  564,
			    2,  470,   64,  127,  350,   22,  469,   49,   94,  154,
			  128,  129,  384,  213,  238,  329,   13,  510,  154,  148,
			  127,   10,   52,   64,  154,  446,   64,  722,   61,  722,
			  154,  471,  154,  722,  393,   52,   63,  681,   65,  510,
			  915,  808,  127,  914,  915,   62,  842,   64,  127,  249,
			  154,  282,  119,  120,  734,    0,  479,  124,   47,   48,
			  734,  125,  450,  127,  532,   62,   47,  862,   45,  154,
			  734,   36,  535,  273,  274,  154,   37,    0,   68,  734,

			  548,   70,   71,   59,   73,   46,  119,  120,  114,  792,
			  154,  124,  736,   59,   59,  128,  129,   74,  216,  217,
			   59,   29,  154,   59,   93,    3,  133,  802,  125,  802,
			  127,  457,  154,  802,   59,  154,  911,  864,  159,   47,
			    0,  159,  825,  591,  587,  115,  102,  321,  551,  517,
			   28,    0,  113,  900,  151,  931,  102,  154,    0,    3,
			  157,  100,  159,   99,  810,  811,  172,  813,   29,   42,
			  167,  178,   44, 1028,  378,  222,  223, 1028,  626,  839,
			  623,  908,   43,  522,  191,  839,   46,  112,  154,  114,
			  167,  395,  518,  170,   38,  839,  647,   57,  524,   59,

			   60,   61,  212,  213,  839,  113,  889,   28,  628,  222,
			  223,   44,   72,  322,   35,   57,   76,  618,   60,  667,
			   80,   59,   82,   59,   29,  952,  112,   59,  114,  672,
			   90,  634,   92,   93,  241,   59,   59,  284,   98,  249,
			  287,   77,   47,  250,   28,   77,   30,   31,  661,  109,
			   59,   30,   31,   77,   77,  581,   59,  670,  584,  707,
			  935,  907,  935,  273,  274,  234,  935,  891,   77,   53,
			  743,  284,   59,   80,  287,   82,   84,   56,   30,   31,
			   88,  278,  251,  252,  253,  254,  255,  256,  257,  258,
			  259,  260,  261,  262,  263,  264,  265,  266,  267,  268,

			  269,  270,   59,   63,  311,   59,   37,    0,   95,  306,
			  956,  105,  958,  100,   74,  381,  496,   48,  315,  316,
			  646,  446,  329,  107,  108,  450,  110,  111,  107,  108,
			  446,  110,  111,   78,  450,   59,  446,  104,  105,  788,
			  450,   61,  446,  349,  446,  352,  450,  352,  450,   42,
			  734,  102,   72,  557,  420,  107,  108,   68,  110,  111,
			  357,  371,  446,  370,   57,  372,  450,  364,  365,  366,
			  367,   36,  830,   83,  700,  669,  834,   47,   48,   44,
			   91,  446,   43,   76,   43,  450,   43,  446,  357,   82,
			   44,  450,  517,   59,    3,   59,  393,  374,   47,   48,

			   93,  517,  446,   59,  115,    4,  450,  517,  385,  475,
			  476,   59,   48,  517,  446,  517,  109,   83,  450,   28,
			  486,    4,   88,    4,  446,  636,  884,  446,  450,   38,
			  975,  450,  758,  517,   59,  432,  730,  481,  445,    4,
			   88,  615,  411,   88,  465,  414,  112,  465,  114,  446,
			   47,   48,  517,  450,   48,  839,   59,  426,  517,  639,
			  437,  468,   48,   88,  112,  676,  114,   91,  465,  124,
			  125,   23,   24,  517,  648,  649,  828,  483,  488,  106,
			  446,  478,  137,  138,  450,  517,  496,  112,  814,  114,
			  467,   59,   30,  618,  100,  517,   33,   34,  517, 1044,

			   59, 1046,  618,  472,  511,   46,   17,   18,  618,  478,
			   33,   34,  481,  623,  618,  625,  618,   28,   74,  623,
			  517,  625,   33,   28,  531,  522,  878,  104,  525,  740,
			   59,  883,  884,  104,  618,  504,  505,   33,   34,  623,
			  546,  625,   33,   34,  521,   17,   18,   30, 1051, 1052,
			  724,  517,  726,  618,  728,  524,  525,  534,  769,  618,
			   95,   33,   75,   76,   17,   18,   30,   31,  574,  107,
			  108,  109,  110,  111,  618,   28,   44,  115,  930,  963,
			   33,   59,   35,   69, 1027,  796,  618,  556,  632,  586,
			   48,  623,   48,  625,   59,  592,  618,   80,   62,  618,

			   44,   65,   30,   88,  623,   59,  625,   73,    0,  606,
			  103,   59,   59,   96,   48,   42,   46,  623,   59,  625,
			   57,  618,  948,   45,  107,  108,  109,  110,  111,  639,
			  637,   81,  115,  610,  808,  612,   59,  606,  944,   76,
			   59,   48,  624,  107,  108,   82,  110,  111,   97, 1033,
			 1034, 1035,  618, 1037,    3,    3,   93,  623,   43,  625,
			    3,   46,  669,  632,    3,   57,   29,   59,   60,   61,
			   36,  678,  109,  678,   59,   44,   97,   30,   31,   59,
			   72,   86,   37,   68,   76,   99,  102, 1071,   80,   67,
			   82,   68,    0,  700,   92,   42,   48,   59,   90,   49,

			   92,   93,  112,   79,  711,  712,   98,   60,   48,   62,
			   95,   47,   65,  720,   91,  100,   29,  109,  103,  688,
			  702,   42,  113,  730,  768,  772,  900,  104,  105,  772,
			   17,   18,  745,  746,   59,   59,  834,  734,  115,   28,
			  747,   57, 1048,   30,   31,   90,   33,   77,   42,   57,
			   57,   59,   60,   61,  107,  108,   43,  110,  111,  772,
			   76,   37,  108,   28,   72,  734,   82,   42,   76,   76,
			  944,  768,   80,   42,   82,   82,   98,   93,   48,   69,
			   59,   48,   90,   90,   92,   93,   93,   37,   48,   37,
			   98,   88,   41,  109,  941,  764,  765,  804,   29,   44,

			   46,  109,  109,  810,  811,  812,  813,  814,   42,   73,
			  852,   30,   31,   59,  821,  857,  823,   47,   47,   36,
			  107,  108,  153,  110,  111,  156,   36,   59,   37,   33,
			   33,  852,   28,  830,  852,  166,  857,  834,  963,  857,
			   42,   73,  839,   48,  155,   44,  853,   42,   48,   95,
			   44,   83,   33,  963,  100,  852,   88,  103,   59,  963,
			  857,   47,   47,  832,  833,   37,   82,  836,  837,  838,
			  839,  168,  169,   33, 1048,   28,  963,   42,   44,   47,
			  112,   45,  114,   89,   42,   59,   47,  884,  107,  108,
			  109,  110,  111,   28,   95,   28,  115,  904,  963,  100,

			  907,   28,  103,   48,  963,  912,  913,   81, 1033, 1034,
			   69,  953, 1037,  920,   28,   67,  923,   28,   28,  963,
			  941,   95,   28,  941, 1034, 1035,  100, 1037,   36,  103,
			 1034, 1035,  953, 1037,   28,  953,  978,   29,  980,   37,
			   30,   31,  239,  240,  941,  242, 1071, 1034, 1035,  956,
			 1037,  958,   41,   43,   28,  924,  953,  978,   59,  980,
			  978, 1071,  980,   53,   28,   43,  963, 1071,    0, 1034,
			 1035, 1089, 1037,  580,  271, 1034, 1035,  935, 1037,  722,
			  362,  978,   83,  980, 1071,   12,  993,   88,  682, 1033,
			 1034, 1035,  610, 1037,  756,  525,  767,  328,  891,   30, yyDummy>>,
			1, 1000, 0)
		end

	yycheck_template_2 (an_array: ARRAY [INTEGER])
			-- Fill chunk #2 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			   31,  803,  971,  729,  980,  839, 1071, 1071, 1050,  340,
			  632,  112, 1071,  114,  325, 1048,  445,  107,  108,  713,
			  110,  111, 1029,  354,  724,  759,  759, 1071,  869, 1050,
			   57,  759, 1050,  934,  465,  978, 1033, 1034, 1035, 1031,
			 1037,  819, 1011, 1088, 1051, 1052,  945,  741, 1042,   76,
			  361,  960, 1050, 1050,  964,   82,  618,  388,   89,  390,
			  875,  126,  488,   90,  772,   92,   93,  453,  359,  991,
			  101,   98,  766,    9, 1071,   81,  107,  108,  109,  110,
			  111, 1088,  109,  321,  115,  112,  113,  114,  351,   95,
			  387,   97,  389,    0,  100,  488,  575,  103,  625,  396,

			  397,  398,  399,  400,  401,  402,  403,  404,  405,  406,
			  407,  408,  409,  410,  714,  412,  413,  590,  415,  416,
			  417,   19,   20,   21,   22,   23,   24,   -1,   -1,  460,
			   -1,   -1,  826,   -1,   30,   31,   -1,   -1,  449,   -1,
			   -1,   59,   -1,   -1,   -1,  456,  477,  841,   -1,   -1,
			   57,   -1,   59,   -1,   -1,   73,  487,   53,   -1,   -1,
			  457,   68,   -1,   -1,   -1,   83,   -1,  498,  499,   76,
			   88,   -1,   30,   31,   -1,   82,   -1,   -1,  509,   -1,
			  874,  492,   -1,   90,   91,  879,   93,   -1,   -1,   -1,
			   -1,   -1,   99,   89,  112,  102,  114,  104,  105,    0,

			   -1,   -1,  109,  500,  501,  112,  503,  114,  115,  540,
			   -1,  107,  108,   -1,  110,  111,  547,   -1,   -1,   17,
			   18,   -1,   -1,   -1,  918,   -1,   -1,   -1,   -1,   -1,
			   -1,   89,   30,   31,   -1,   33,   -1,   35,  932,  536,
			   -1,   -1,   -1,  540,   -1,   43,   -1,  544,   -1,  107,
			  108,  109,  110,  111,  565,   -1,   57,  115,   59,   60,
			   61,   -1,   -1,  594,   -1,  576,  563,  564,   -1,   -1,
			   -1,   72,  966,   -1,   -1,   76,   -1,   -1,   -1,   80,
			   -1,   82,   -1,   -1,  595,   83,   -1,  584,   -1,   90,
			   -1,   92,   93,   -1,   -1,   -1,   -1,   98,   -1,   -1,

			  611,   -1,  613,   -1,   -1,   -1,  603,   -1,  109,  107,
			  108,   -1,  110,  111,   -1, 1009,   -1,   30,   31,   -1,
			 1014,   -1, 1016,    5,    6,    7,    8,    9,   10,   11,
			   12,   13,   14,   15,   16,   17,   18,   19,   20,   21,
			   22,   23,   24,  640,   -1,   17,   18,   -1,   59,   -1,
			   -1, 1045,   63,   -1,   -1,   -1,   -1,   -1,   30,   31,
			   -1,   33,   73,   74,   -1,   -1,   -1,   -1,  699,   -1,
			   -1,   43,   83,   -1,  705,   86,   89,   88,  709,   -1,
			   -1,   -1, 1076,   -1, 1078,   -1,   -1,  698,  101,   30,
			   31,   17,   18,   -1,  107,  108,  109,  110,  111,   -1,

			   -1,  112,  115,  114,   30,   31,   32,   33,   34,   35,
			  721,   83,   -1,   -1,   -1,   -1,   -1,   43,   -1,   -1,
			   46,   -1,  719,  105,   -1,   51,   52,   -1,   -1,  760,
			   71,  762,   -1,   -1,   -1,  107,  108,   -1,  110,  111,
			   17,   18,   83,   -1,   -1,   -1,  757,   88,   -1,   90,
			   -1,   -1,   -1,   -1,   -1,   32,   33,   34,   35,   -1,
			   -1,   -1,  793,   -1,  795,   -1,  107,  108,   -1,  110,
			  111,  112,   -1,  114,   51,   52,  787,   -1,   55,   -1,
			   -1,  107,  108,  780,  110,  111,   30,   31,   -1,   -1,
			  116,  117,  118,  119,  120,  121,  122,  123,  124,  125,

			  126,  127,  128,  129,  130,  131,  132,  133,  134,  135,
			  136,  137,  138,  139,   -1,   -1,   -1,  848,   62,   -1,
			   -1,   65,   -1,   -1,   -1,   -1,  823,  824,   -1,   -1,
			   -1,   -1,   -1,  844,   -1,  112,  847,  114,   -1,  116,
			  117,  118,  119,  120,  121,  122,  123,  124,  125,  126,
			  127,  128,  129,  130,  131,  132,  133,  134,  135,  136,
			  137,  138,  139,  107,  108,   -1,  110,  111,  899,   -1,
			   -1,   -1,  903,   -1,   -1,  906,   -1,   59,   -1,   -1,
			   -1,   -1,   -1,   -1,  881,  882,  917,   -1,  885,  886,
			  887,  922,   -1,   -1,  905,   77,   78,   79,   -1,   30,

			   31,   -1,   -1,   -1,   -1,  916,   88,   -1,  939,   91,
			  921,   -1,   43,   -1,   45,   30,   31,   99,   -1,   50,
			   -1,   -1,  104,  105,  106,   -1,  937,   -1,   -1,  940,
			    5,    6,    7,    8,    9,   10,   11,   12,   13,   14,
			   15,   16,   17,   18,   19,   20,   21,   22,   23,   24,
			   -1,   -1,  983,   -1,   -1,   -1,   -1,   -1,   89,  990,
			   -1,   -1,   -1,   -1,  995,   -1,   -1,   -1,   -1,   -1,
			  101,   -1,   -1,  970,   89, 1006,  107,  108,  109,  110,
			  111,   -1, 1013,  994,  115,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,  107,  108,  109,  110,  111,   -1,   -1,   -1,

			  115, 1012,   -1,   -1,   30,   31,   -1,   -1,   -1, 1020,
			   -1,   -1, 1023,   -1,   -1,   -1,   91,   -1, 1015,   45,
			   17,   18,   -1,   -1,   50, 1036, 1057,   24,   25,   26,
			   27,   -1,   29,   30,   31,   32,   33,   34,   35,   36,
			   -1,   -1,   39,   40, 1041, 1056,   43,   -1,   45,   -1,
			   -1,   -1,   -1,   -1,   51,   52,   53,   54,   -1,   56,
			   -1,   58,   -1,   89,   -1,   62,   -1,   64,   65,   66,
			   -1,   -1,   -1,   -1,   71,  101,   -1,   74,   75,   -1,
			   -1,  107,  108,  109,  110,  111,   83,   84,   85,  115,
			   87,   -1,   -1,   -1,   -1,   -1,   -1,   94,   17,   18,

			   19,   20,   21,   22,   23,   24,   -1,   -1,   -1,   -1,
			  107,  108,   -1,  110,  111,   -1,   -1,   -1,   -1,  116,
			  117,  118,  119,  120,  121,  122,  123,  124,  125,  126,
			  127,  128,  129,  130,  131,  132,  133,  134,  135,  136,
			  137,  138,  139,   17,   18,   -1,   -1,   -1,   -1,   -1,
			   24,   25,   26,   27,   46,   29,   30,   31,   32,   33,
			   34,   35,   36,   -1,   -1,   39,   40,   59,   -1,   43,
			   57,   45,   59,   -1,   -1,   -1,   50,   51,   52,   53,
			   -1,   -1,   56,   -1,   58,   77,   78,   79,   62,   76,
			   64,   65,   66,   -1,   -1,   82,   88,   -1,   -1,   91,

			   74,   -1,   -1,   90,   -1,   92,   93,   99,   -1,   83,
			   -1,   98,  104,  105,  106,   -1,   -1,   -1,   -1,   -1,
			   94,   -1,  109,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,  107,  108,   -1,  110,  111,   -1,   -1,
			   -1,   -1,  116,  117,  118,  119,  120,  121,  122,  123,
			  124,  125,  126,  127,  128,  129,  130,  131,  132,  133,
			  134,  135,  136,  137,  138,  139,   17,   18,   -1,   -1,
			   -1,   -1,   -1,   24,   25,   26,   27,   -1,   29,   30,
			   31,   32,   33,   34,   35,   36,   -1,   -1,   39,   40,
			   -1,   -1,   43,   -1,   45,   46,   -1,   -1,   -1,   -1, yyDummy>>,
			1, 1000, 1000)
		end

	yycheck_template_3 (an_array: ARRAY [INTEGER])
			-- Fill chunk #3 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			   51,   52,   53,   -1,   -1,   56,   -1,   58,   -1,   -1,
			   -1,   62,   -1,   64,   65,   66,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   74,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   83,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   30,   31,   94,   -1,   -1,   35,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   43,   -1,  107,  108,   -1,  110,
			  111,   -1,   -1,   -1,   -1,  116,  117,  118,  119,  120,
			  121,  122,  123,  124,  125,  126,  127,  128,  129,  130,
			  131,  132,  133,  134,  135,  136,  137,  138,  139,   17,
			   18,   -1,   -1,   -1,   83,   -1,   24,   25,   26,   27,

			   -1,   29,   30,   31,   32,   33,   34,   35,   36,   -1,
			   -1,   39,   40,   -1,   -1,   43,   -1,   45,  107,  108,
			   -1,  110,  111,   51,   52,   53,   -1,   -1,   56,   -1,
			   58,   -1,   -1,   -1,   62,   -1,   64,   65,   66,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   74,   -1,   -1,   77,
			   -1,   -1,   -1,   -1,   -1,   83,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   94,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  107,
			  108,   -1,  110,  111,   -1,   -1,   -1,   -1,  116,  117,
			  118,  119,  120,  121,  122,  123,  124,  125,  126,  127,

			  128,  129,  130,  131,  132,  133,  134,  135,  136,  137,
			  138,  139,   17,   18,   -1,   -1,   -1,   -1,   -1,   24,
			   25,   26,   27,   -1,   29,   30,   31,   32,   33,   34,
			   35,   36,   -1,   -1,   39,   40,   -1,   -1,   43,   -1,
			   45,   -1,   -1,   -1,   -1,   -1,   51,   52,   53,   -1,
			   -1,   56,   -1,   58,   -1,   -1,   -1,   62,   -1,   64,
			   65,   66,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   74,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   83,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   94,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,  102,   -1,   -1,

			   -1,   -1,  107,  108,   -1,  110,  111,   -1,   -1,   -1,
			   -1,  116,  117,  118,  119,  120,  121,  122,  123,  124,
			  125,  126,  127,  128,  129,  130,  131,  132,  133,  134,
			  135,  136,  137,  138,  139,   17,   18,   -1,   -1,   -1,
			   -1,   -1,   24,   25,   26,   27,   -1,   29,   30,   31,
			   32,   33,   34,   35,   36,   -1,   -1,   39,   40,   -1,
			   -1,   43,   -1,   45,   -1,   -1,   -1,   -1,   -1,   51,
			   52,   53,   -1,   -1,   56,   -1,   58,   -1,   -1,   -1,
			   62,   -1,   64,   65,   66,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   74,   -1,   -1,   -1,   -1,   -1,   -1,   -1,

			   -1,   83,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   94,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,  107,  108,   -1,  110,  111,
			   -1,   -1,   -1,   -1,  116,  117,  118,  119,  120,  121,
			  122,  123,  124,  125,  126,  127,  128,  129,  130,  131,
			  132,  133,  134,  135,  136,  137,  138,  139,   17,   18,
			   -1,   -1,   -1,   -1,   -1,   24,   25,   26,   27,   -1,
			   29,   30,   31,   32,   33,   34,   35,   36,   -1,   -1,
			   39,   40,   -1,   -1,   43,   -1,   45,   -1,   -1,   -1,
			   -1,   -1,   51,   52,   53,   -1,   -1,   56,   -1,   58,

			   -1,   -1,   -1,   62,   -1,   64,   65,   66,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   74,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   83,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   94,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  107,  108,
			   -1,  110,  111,   -1,   -1,   -1,   -1,  116,  117,  118,
			  119,  120,  121,  122,  123,  124,  125,  126,  127,  128,
			  129,  130,  131,  132,  133,  134,  135,  136,  137,  138,
			  139,   17,   18,   -1,   -1,   -1,   -1,   -1,   24,   25,
			   26,   27,   -1,   29,   30,   31,   32,   33,   34,   35,

			   36,   -1,   -1,   39,   40,   -1,   -1,   43,   -1,   45,
			   -1,   -1,   -1,   -1,   -1,   51,   52,   53,   -1,   -1,
			   56,   -1,   58,   -1,   -1,   -1,   62,   -1,   64,   65,
			   66,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   74,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   83,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   94,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,  107,  108,   -1,  110,  111,   -1,   -1,   -1,   -1,
			  116,  117,  118,  119,  120,  121,  122,  123,  124,  125,
			  126,  127,  128,  129,  130,  131,  132,  133,  134,  135,

			  136,  137,  138,  139,   17,   18,   -1,   -1,   -1,   -1,
			   -1,   24,   25,   26,   27,   -1,   29,   30,   31,   32,
			   33,   34,   35,   36,   -1,   -1,   39,   40,   -1,   -1,
			   43,   -1,   45,   -1,   -1,   -1,   -1,   -1,   51,   52,
			   53,   17,   18,   56,   -1,   58,   -1,   -1,   -1,   62,
			   -1,   64,   65,   66,   30,   31,   32,   33,   34,   35,
			   -1,   74,   -1,   -1,   -1,   -1,   -1,   43,   -1,   -1,
			   83,   -1,   -1,   -1,   -1,   51,   52,   -1,   -1,   -1,
			   -1,   94,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,  107,  108,   -1,  110,  111,   -1,

			   -1,   -1,   -1,  116,  117,  118,  119,  120,  121,  122,
			  123,  124,  125,  126,  127,  128,  129,  130,  131,  132,
			  133,  134,  135,  136,  137,  138,  139,   -1,   -1,   -1,
			   -1,  107,  108,   -1,  110,  111,   -1,   -1,   -1,   -1,
			  116,  117,  118,  119,  120,  121,  122,  123,  124,  125,
			  126,  127,  128,  129,  130,  131,  132,  133,  134,  135,
			  136,  137,  138,  139,   17,   18,   -1,   -1,   29,   30,
			   31,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   32,
			   33,   34,   35,   -1,   -1,   -1,   -1,   -1,   -1,   17,
			   18,   -1,   53,   -1,   -1,   56,   -1,   -1,   51,   52,

			   28,   62,   55,   -1,   65,   33,   34,   35,   -1,   -1,
			   -1,   -1,   -1,   17,   18,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   50,   -1,   28,   -1,   -1,   -1,   -1,   33,
			   34,   35,   -1,   -1,   -1,   -1,   -1,   17,   18,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,  107,  108,   -1,  110,
			  111,   -1,   -1,   33,   34,   35,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,  116,  117,  118,  119,  120,  121,  122,
			  123,  124,  125,  126,  127,  128,  129,  130,  131,  132,
			  133,  134,  135,  136,  137,  138,  139,   -1,  116,  117,
			  118,  119,  120,  121,  122,  123,  124,  125,  126,  127, yyDummy>>,
			1, 1000, 2000)
		end

	yycheck_template_4 (an_array: ARRAY [INTEGER])
			-- Fill chunk #4 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			  128,  129,  130,  131,  132,  133,  134,  135,  136,  137,
			  138,  139,  116,  117,  118,  119,  120,  121,  122,  123,
			  124,  125,  126,  127,  128,  129,  130,  131,  132,  133,
			  134,  135,  136,  137,  138,  139,  116,  117,  118,  119,
			  120,  121,  122,  123,  124,  125,  126,  127,  128,  129,
			  130,  131,  132,  133,  134,  135,  136,  137,  138,  139,
			    0,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   12,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   30,   31,   -1,   -1,   -1,
			   30,   31,   -1,   -1,   -1,   -1,   36,   37,   43,   -1,

			   -1,   -1,   42,   -1,   44,   45,   46,   -1,   48,   -1,
			   -1,   56,   -1,   -1,   -1,   -1,   -1,   57,   -1,   59,
			   60,   -1,   62,   -1,   -1,   65,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   74,   -1,   76,   -1,   -1,   -1,
			   -1,   -1,   82,   83,   -1,   -1,   -1,    0,   88,   89,
			   90,   -1,   92,   93,   -1,   -1,   -1,   97,   98,   12,
			   -1,  101,  107,  108,   -1,  110,  111,  107,  108,  109,
			  110,  111,  112,  113,  114,  115,   -1,   30,   31,   -1,
			   -1,   -1,   -1,   36,   37,   -1,   -1,   -1,   -1,   42,
			   -1,   44,   45,   46,   -1,   48,   -1,   -1,   -1,   -1,

			   -1,   -1,   -1,   -1,   57,   -1,   59,   60,   -1,   62,
			   -1,   -1,   65,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   74,   -1,   76,   -1,   -1,   -1,   -1,   -1,   82,
			   83,   -1,   -1,   -1,    0,   88,   89,   90,   -1,   92,
			   93,   -1,   -1,   -1,   97,   98,   12,   -1,  101,   -1,
			   -1,   -1,   -1,   -1,  107,  108,  109,  110,  111,  112,
			  113,  114,  115,   -1,   30,   31,   -1,   -1,   -1,   -1,
			   36,   37,   -1,   -1,   -1,   -1,   42,   -1,   44,   45,
			   46,   -1,   48,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   57,   -1,   59,   60,   -1,   62,   -1,   -1,   65,

			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   74,   -1,
			   76,   -1,   -1,   -1,   -1,   -1,   82,   83,   -1,   -1,
			   -1,    0,   88,   -1,   90,   -1,   92,   93,   -1,   -1,
			   -1,   97,   98,   12,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,  107,  108,  109,  110,  111,  112,  113,  114,   -1,
			   -1,   30,   31,   -1,   -1,   -1,   -1,   36,   37,   -1,
			   -1,   -1,   -1,   42,   -1,   44,   45,   46,   -1,   48,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   57,   -1,
			   59,   60,   -1,   62,   -1,   -1,   65,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   74,   -1,   76,   -1,   -1,

			   -1,   -1,   -1,   82,   83,   -1,   -1,   -1,    0,   88,
			   -1,   90,   -1,   92,   93,   -1,   -1,   -1,   97,   98,
			   12,   -1,   -1,   -1,   -1,   -1,   -1,   -1,  107,  108,
			  109,  110,  111,  112,  113,  114,   -1,   -1,   30,   31,
			   -1,   -1,   -1,   -1,   36,   37,   -1,   -1,   -1,   -1,
			   42,   -1,   44,   45,   46,   -1,   48,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   57,   -1,   59,   60,   -1,
			   62,   -1,   -1,   65,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   74,   -1,   76,   -1,   -1,   -1,   -1,   -1,
			   82,   83,   -1,   -1,   -1,    0,   88,   -1,   90,   -1,

			   92,   93,   -1,   -1,   -1,   97,   98,   12,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,  107,  108,  109,  110,  111,
			  112,  113,  114,   -1,   -1,   30,   31,   -1,   -1,   -1,
			   -1,   -1,   37,   -1,   -1,   -1,   -1,   42,   -1,   44,
			   45,   46,   -1,   48,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   57,   -1,   59,   60,   -1,   62,   -1,   -1,
			   65,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   74,
			   -1,   76,   -1,   -1,   -1,   -1,   -1,   82,   83,   43,
			   -1,   -1,   -1,   88,   -1,   90,   -1,   92,   93,   -1,
			   -1,   -1,   97,   98,   -1,   -1,   -1,   -1,   -1,   -1,

			   -1,   -1,  107,  108,  109,  110,  111,  112,  113,  114,
			    5,    6,    7,    8,    9,   10,   11,   12,   13,   14,
			   15,   16,   17,   18,   19,   20,   21,   22,   23,   24,
			    5,    6,    7,    8,    9,   10,   11,   12,   13,   14,
			   15,   16,   17,   18,   19,   20,   21,   22,   23,   24,
			   -1,   -1,  116,  117,  118,  119,  120,  121,  122,  123,
			  124,  125,  126,  127,  128,  129,  130,  131,  132,  133,
			  134,  135,  136,  137,  138,  139,    5,    6,    7,    8,
			    9,   10,   11,   12,   13,   14,   15,   16,   17,   18,
			   19,   20,   21,   22,   23,   24,   30,   31,   -1,   -1,

			   -1,   -1,   -1,   37,   -1,   -1,   -1,  102,   -1,   30,
			   31,   45,   -1,   -1,   -1,   -1,   50,   -1,   -1,   -1,
			   30,   31,   -1,   -1,   45,   -1,   -1,  102,   -1,   50,
			   -1,   -1,   -1,   -1,   -1,   45,   70,   -1,   -1,   -1,
			   50,   -1,   -1,   30,   31,   -1,   80,   -1,   -1,   70,
			   -1,   -1,   -1,   -1,   -1,   89,   -1,   -1,   45,   80,
			   70,   -1,   91,   50,   -1,   -1,   -1,  101,   89,   -1,
			   80,   -1,   -1,  107,  108,  109,  110,  111,   -1,   89,
			  101,  115,   -1,   70,   -1,   -1,  107,  108,  109,  110,
			  111,  101,   -1,   80,  115,   30,   31,  107,  108,  109,

			  110,  111,   89,   -1,   -1,  115,   -1,   -1,   -1,   -1,
			   45,   30,   31,   -1,  101,   50,   -1,   30,   31,   -1,
			  107,  108,  109,  110,  111,   -1,   45,   -1,  115,   -1,
			   43,   50,   29,   30,   31,   70,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   30,   31,   80,   43,   -1,   -1,   62,
			   -1,   70,   65,   50,   89,   -1,   53,   -1,   45,   56,
			   -1,   80,   -1,   50,   -1,   62,  101,   -1,   65,   -1,
			   89,   -1,  107,  108,  109,  110,  111,   -1,   -1,   -1,
			  115,   -1,   -1,   70,   -1,   -1,   -1,   -1,  107,  108,
			  109,  110,  111,   80,  107,  108,  115,  110,  111,   -1,

			   -1,   -1,   89,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			  107,  108,   -1,  110,  111,   -1,   -1,   -1,   -1,   -1,
			  107,  108,  109,  110,  111,   -1,   -1,   -1,  115,    5,
			    6,    7,    8,    9,   10,   11,   12,   13,   14,   15,
			   16,   17,   18,   19,   20,   21,   22,   23,   24,   43,
			   -1,   -1,   46,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   59,   -1,   -1,   -1,   63,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   73,
			   74,   -1,   -1,   59,   -1,   -1,   -1,   -1,   -1,   83,
			   -1,   -1,   86,   -1,   88,   -1,   -1,   -1,   -1,   -1, yyDummy>>,
			1, 1000, 3000)
		end

	yycheck_template_5 (an_array: ARRAY [INTEGER])
			-- Fill chunk #5 of template for `yycheck'.
		do
			yyarray_subcopy (an_array, <<
			   -1,   77,    9,   10,   11,   12,   13,   14,   15,   16,
			   17,   18,   19,   20,   21,   22,   23,   24,  112,   -1,
			  114,    5,    6,    7,    8,    9,   10,   11,   12,   13,
			   14,   15,   16,   17,   18,   19,   20,   21,   22,   23,
			   24,    5,    6,    7,    8,    9,   10,   11,   12,   13,
			   14,   15,   16,   17,   18,   19,   20,   21,   22,   23,
			   24,    5,    6,    7,    8,    9,   10,   11,   12,   13,
			   14,   15,   16,   17,   18,   19,   20,   21,   22,   23,
			   24,   -1,   -1,   -1,   48,   69,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,

			   -1,   -1,   46,    5,    6,    7,    8,    9,   10,   11,
			   12,   13,   14,   15,   16,   17,   18,   19,   20,   21,
			   22,   23,   24,    8,    9,   10,   11,   12,   13,   14,
			   15,   16,   17,   18,   19,   20,   21,   22,   23,   24,
			   42,    5,    6,    7,    8,    9,   10,   11,   12,   13,
			   14,   15,   16,   17,   18,   19,   20,   21,   22,   23,
			   24,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,
			   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   42,  116,
			  117,  118,  119,  120,  121,  122,  123,  124,  125,  126,
			  127,  128,  129,  130,  131,  132,  133,  134,  135,  136,

			  137,  138,  139,  116,   -1,  118,   -1,  120,  121,  122,
			  123,  124,  125,  126,  127,  128,  129,  130,  131,  132,
			  133,  134,  135,  136,  137,  138,  139,    5,    6,    7,
			    8,    9,   10,   11,   12,   13,   14,   15,   16,   17,
			   18,   19,   20,   21,   22,   23,   24,  120,  121,  122,
			  123,  124,  125,  126,  127,  128,  129,  130,  131,  132,
			  133,  134,  135,  136,  137,  138,  139,    6,    7,    8,
			    9,   10,   11,   12,   13,   14,   15,   16,   17,   18,
			   19,   20,   21,   22,   23,   24,  120,  121,  122,  123,
			  124,  125,  126,  127,  128,  129,  130,  131,  132,  133,

			  134,  135,  136,   -1,  138,    7,    8,    9,   10,   11,
			   12,   13,   14,   15,   16,   17,   18,   19,   20,   21,
			   22,   23,   24, yyDummy>>,
			1, 323, 4000)
		end

feature {NONE} -- Semantic value stacks

	yyvs1: SPECIAL [detachable ANY]
			-- Stack for semantic values of type detachable ANY

	yyvsc1: INTEGER
			-- Capacity of semantic value stack `yyvs1'

	yyvsp1: INTEGER
			-- Top of semantic value stack `yyvs1'

	yyspecial_routines1: detachable KL_SPECIAL_ROUTINES [detachable ANY] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable ANY]

	yyvs2: SPECIAL [detachable ID_AS]
			-- Stack for semantic values of type detachable ID_AS

	yyvsc2: INTEGER
			-- Capacity of semantic value stack `yyvs2'

	yyvsp2: INTEGER
			-- Top of semantic value stack `yyvs2'

	yyspecial_routines2: detachable KL_SPECIAL_ROUTINES [detachable ID_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable ID_AS]

	yyvs3: SPECIAL [detachable CHAR_AS]
			-- Stack for semantic values of type detachable CHAR_AS

	yyvsc3: INTEGER
			-- Capacity of semantic value stack `yyvs3'

	yyvsp3: INTEGER
			-- Top of semantic value stack `yyvs3'

	yyspecial_routines3: detachable KL_SPECIAL_ROUTINES [detachable CHAR_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable CHAR_AS]

	yyvs4: SPECIAL [detachable SYMBOL_AS]
			-- Stack for semantic values of type detachable SYMBOL_AS

	yyvsc4: INTEGER
			-- Capacity of semantic value stack `yyvs4'

	yyvsp4: INTEGER
			-- Top of semantic value stack `yyvs4'

	yyspecial_routines4: detachable KL_SPECIAL_ROUTINES [detachable SYMBOL_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable SYMBOL_AS]

	yyvs5: SPECIAL [detachable BOOL_AS]
			-- Stack for semantic values of type detachable BOOL_AS

	yyvsc5: INTEGER
			-- Capacity of semantic value stack `yyvs5'

	yyvsp5: INTEGER
			-- Top of semantic value stack `yyvs5'

	yyspecial_routines5: detachable KL_SPECIAL_ROUTINES [detachable BOOL_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable BOOL_AS]

	yyvs6: SPECIAL [detachable RESULT_AS]
			-- Stack for semantic values of type detachable RESULT_AS

	yyvsc6: INTEGER
			-- Capacity of semantic value stack `yyvs6'

	yyvsp6: INTEGER
			-- Top of semantic value stack `yyvs6'

	yyspecial_routines6: detachable KL_SPECIAL_ROUTINES [detachable RESULT_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable RESULT_AS]

	yyvs7: SPECIAL [detachable RETRY_AS]
			-- Stack for semantic values of type detachable RETRY_AS

	yyvsc7: INTEGER
			-- Capacity of semantic value stack `yyvs7'

	yyvsp7: INTEGER
			-- Top of semantic value stack `yyvs7'

	yyspecial_routines7: detachable KL_SPECIAL_ROUTINES [detachable RETRY_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable RETRY_AS]

	yyvs8: SPECIAL [detachable UNIQUE_AS]
			-- Stack for semantic values of type detachable UNIQUE_AS

	yyvsc8: INTEGER
			-- Capacity of semantic value stack `yyvs8'

	yyvsp8: INTEGER
			-- Top of semantic value stack `yyvs8'

	yyspecial_routines8: detachable KL_SPECIAL_ROUTINES [detachable UNIQUE_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable UNIQUE_AS]

	yyvs9: SPECIAL [detachable CURRENT_AS]
			-- Stack for semantic values of type detachable CURRENT_AS

	yyvsc9: INTEGER
			-- Capacity of semantic value stack `yyvs9'

	yyvsp9: INTEGER
			-- Top of semantic value stack `yyvs9'

	yyspecial_routines9: detachable KL_SPECIAL_ROUTINES [detachable CURRENT_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable CURRENT_AS]

	yyvs10: SPECIAL [detachable DEFERRED_AS]
			-- Stack for semantic values of type detachable DEFERRED_AS

	yyvsc10: INTEGER
			-- Capacity of semantic value stack `yyvs10'

	yyvsp10: INTEGER
			-- Top of semantic value stack `yyvs10'

	yyspecial_routines10: detachable KL_SPECIAL_ROUTINES [detachable DEFERRED_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable DEFERRED_AS]

	yyvs11: SPECIAL [detachable VOID_AS]
			-- Stack for semantic values of type detachable VOID_AS

	yyvsc11: INTEGER
			-- Capacity of semantic value stack `yyvs11'

	yyvsp11: INTEGER
			-- Top of semantic value stack `yyvs11'

	yyspecial_routines11: detachable KL_SPECIAL_ROUTINES [detachable VOID_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable VOID_AS]

	yyvs12: SPECIAL [detachable KEYWORD_AS]
			-- Stack for semantic values of type detachable KEYWORD_AS

	yyvsc12: INTEGER
			-- Capacity of semantic value stack `yyvs12'

	yyvsp12: INTEGER
			-- Top of semantic value stack `yyvs12'

	yyspecial_routines12: detachable KL_SPECIAL_ROUTINES [detachable KEYWORD_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable KEYWORD_AS]

	yyvs13: SPECIAL [INTEGER]
			-- Stack for semantic values of type INTEGER

	yyvsc13: INTEGER
			-- Capacity of semantic value stack `yyvs13'

	yyvsp13: INTEGER
			-- Top of semantic value stack `yyvs13'

	yyspecial_routines13: detachable KL_SPECIAL_ROUTINES [INTEGER] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [INTEGER]

	yyvs14: SPECIAL [detachable READABLE_STRING_GENERAL]
			-- Stack for semantic values of type detachable READABLE_STRING_GENERAL

	yyvsc14: INTEGER
			-- Capacity of semantic value stack `yyvs14'

	yyvsp14: INTEGER
			-- Top of semantic value stack `yyvs14'

	yyspecial_routines14: detachable KL_SPECIAL_ROUTINES [detachable READABLE_STRING_GENERAL] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable READABLE_STRING_GENERAL]

	yyvs15: SPECIAL [detachable TUPLE [keyword: detachable KEYWORD_AS; id: detachable ID_AS; line, column: INTEGER; filename: detachable READABLE_STRING_GENERAL]]
			-- Stack for semantic values of type detachable TUPLE [keyword: detachable KEYWORD_AS; id: detachable ID_AS; line, column: INTEGER; filename: detachable READABLE_STRING_GENERAL]

	yyvsc15: INTEGER
			-- Capacity of semantic value stack `yyvs15'

	yyvsp15: INTEGER
			-- Top of semantic value stack `yyvs15'

	yyspecial_routines15: detachable KL_SPECIAL_ROUTINES [detachable TUPLE [keyword: detachable KEYWORD_AS; id: detachable ID_AS; line, column: INTEGER; filename: detachable READABLE_STRING_GENERAL]] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable TUPLE [keyword: detachable KEYWORD_AS; id: detachable ID_AS; line, column: INTEGER; filename: detachable READABLE_STRING_GENERAL]]

	yyvs16: SPECIAL [detachable STRING_AS]
			-- Stack for semantic values of type detachable STRING_AS

	yyvsc16: INTEGER
			-- Capacity of semantic value stack `yyvs16'

	yyvsp16: INTEGER
			-- Top of semantic value stack `yyvs16'

	yyspecial_routines16: detachable KL_SPECIAL_ROUTINES [detachable STRING_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable STRING_AS]

	yyvs17: SPECIAL [detachable ALIAS_TRIPLE]
			-- Stack for semantic values of type detachable ALIAS_TRIPLE

	yyvsc17: INTEGER
			-- Capacity of semantic value stack `yyvs17'

	yyvsp17: INTEGER
			-- Top of semantic value stack `yyvs17'

	yyspecial_routines17: detachable KL_SPECIAL_ROUTINES [detachable ALIAS_TRIPLE] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable ALIAS_TRIPLE]

	yyvs18: SPECIAL [detachable PAIR [KEYWORD_AS, EIFFEL_LIST [INSTRUCTION_AS]]]
			-- Stack for semantic values of type detachable PAIR [KEYWORD_AS, EIFFEL_LIST [INSTRUCTION_AS]]

	yyvsc18: INTEGER
			-- Capacity of semantic value stack `yyvs18'

	yyvsp18: INTEGER
			-- Top of semantic value stack `yyvs18'

	yyspecial_routines18: detachable KL_SPECIAL_ROUTINES [detachable PAIR [KEYWORD_AS, EIFFEL_LIST [INSTRUCTION_AS]]] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable PAIR [KEYWORD_AS, EIFFEL_LIST [INSTRUCTION_AS]]]

	yyvs19: SPECIAL [detachable PAIR [KEYWORD_AS, ID_AS]]
			-- Stack for semantic values of type detachable PAIR [KEYWORD_AS, ID_AS]

	yyvsc19: INTEGER
			-- Capacity of semantic value stack `yyvs19'

	yyvsp19: INTEGER
			-- Top of semantic value stack `yyvs19'

	yyspecial_routines19: detachable KL_SPECIAL_ROUTINES [detachable PAIR [KEYWORD_AS, ID_AS]] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable PAIR [KEYWORD_AS, ID_AS]]

	yyvs20: SPECIAL [detachable PAIR [KEYWORD_AS, STRING_AS]]
			-- Stack for semantic values of type detachable PAIR [KEYWORD_AS, STRING_AS]

	yyvsc20: INTEGER
			-- Capacity of semantic value stack `yyvs20'

	yyvsp20: INTEGER
			-- Top of semantic value stack `yyvs20'

	yyspecial_routines20: detachable KL_SPECIAL_ROUTINES [detachable PAIR [KEYWORD_AS, STRING_AS]] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable PAIR [KEYWORD_AS, STRING_AS]]

	yyvs21: SPECIAL [detachable IDENTIFIER_LIST]
			-- Stack for semantic values of type detachable IDENTIFIER_LIST

	yyvsc21: INTEGER
			-- Capacity of semantic value stack `yyvs21'

	yyvsp21: INTEGER
			-- Top of semantic value stack `yyvs21'

	yyspecial_routines21: detachable KL_SPECIAL_ROUTINES [detachable IDENTIFIER_LIST] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable IDENTIFIER_LIST]

	yyvs22: SPECIAL [detachable PAIR [KEYWORD_AS, EIFFEL_LIST [TAGGED_AS]]]
			-- Stack for semantic values of type detachable PAIR [KEYWORD_AS, EIFFEL_LIST [TAGGED_AS]]

	yyvsc22: INTEGER
			-- Capacity of semantic value stack `yyvs22'

	yyvsp22: INTEGER
			-- Top of semantic value stack `yyvs22'

	yyspecial_routines22: detachable KL_SPECIAL_ROUTINES [detachable PAIR [KEYWORD_AS, EIFFEL_LIST [TAGGED_AS]]] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable PAIR [KEYWORD_AS, EIFFEL_LIST [TAGGED_AS]]]

	yyvs23: SPECIAL [detachable PAIR [KEYWORD_AS, EXPR_AS]]
			-- Stack for semantic values of type detachable PAIR [KEYWORD_AS, EXPR_AS]

	yyvsc23: INTEGER
			-- Capacity of semantic value stack `yyvs23'

	yyvsp23: INTEGER
			-- Top of semantic value stack `yyvs23'

	yyspecial_routines23: detachable KL_SPECIAL_ROUTINES [detachable PAIR [KEYWORD_AS, EXPR_AS]] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable PAIR [KEYWORD_AS, EXPR_AS]]

	yyvs24: SPECIAL [detachable AGENT_TARGET_TRIPLE]
			-- Stack for semantic values of type detachable AGENT_TARGET_TRIPLE

	yyvsc24: INTEGER
			-- Capacity of semantic value stack `yyvs24'

	yyvsp24: INTEGER
			-- Top of semantic value stack `yyvs24'

	yyspecial_routines24: detachable KL_SPECIAL_ROUTINES [detachable AGENT_TARGET_TRIPLE] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable AGENT_TARGET_TRIPLE]

	yyvs25: SPECIAL [detachable ACCESS_AS]
			-- Stack for semantic values of type detachable ACCESS_AS

	yyvsc25: INTEGER
			-- Capacity of semantic value stack `yyvs25'

	yyvsp25: INTEGER
			-- Top of semantic value stack `yyvs25'

	yyspecial_routines25: detachable KL_SPECIAL_ROUTINES [detachable ACCESS_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable ACCESS_AS]

	yyvs26: SPECIAL [detachable ACCESS_FEAT_AS]
			-- Stack for semantic values of type detachable ACCESS_FEAT_AS

	yyvsc26: INTEGER
			-- Capacity of semantic value stack `yyvs26'

	yyvsp26: INTEGER
			-- Top of semantic value stack `yyvs26'

	yyspecial_routines26: detachable KL_SPECIAL_ROUTINES [detachable ACCESS_FEAT_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable ACCESS_FEAT_AS]

	yyvs27: SPECIAL [detachable ACCESS_INV_AS]
			-- Stack for semantic values of type detachable ACCESS_INV_AS

	yyvsc27: INTEGER
			-- Capacity of semantic value stack `yyvs27'

	yyvsp27: INTEGER
			-- Top of semantic value stack `yyvs27'

	yyspecial_routines27: detachable KL_SPECIAL_ROUTINES [detachable ACCESS_INV_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable ACCESS_INV_AS]

	yyvs28: SPECIAL [detachable ARRAY_AS]
			-- Stack for semantic values of type detachable ARRAY_AS

	yyvsc28: INTEGER
			-- Capacity of semantic value stack `yyvs28'

	yyvsp28: INTEGER
			-- Top of semantic value stack `yyvs28'

	yyspecial_routines28: detachable KL_SPECIAL_ROUTINES [detachable ARRAY_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable ARRAY_AS]

	yyvs29: SPECIAL [detachable ASSIGN_AS]
			-- Stack for semantic values of type detachable ASSIGN_AS

	yyvsc29: INTEGER
			-- Capacity of semantic value stack `yyvs29'

	yyvsp29: INTEGER
			-- Top of semantic value stack `yyvs29'

	yyspecial_routines29: detachable KL_SPECIAL_ROUTINES [detachable ASSIGN_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable ASSIGN_AS]

	yyvs30: SPECIAL [detachable ASSIGNER_CALL_AS]
			-- Stack for semantic values of type detachable ASSIGNER_CALL_AS

	yyvsc30: INTEGER
			-- Capacity of semantic value stack `yyvs30'

	yyvsp30: INTEGER
			-- Top of semantic value stack `yyvs30'

	yyspecial_routines30: detachable KL_SPECIAL_ROUTINES [detachable ASSIGNER_CALL_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable ASSIGNER_CALL_AS]

	yyvs31: SPECIAL [detachable ATOMIC_AS]
			-- Stack for semantic values of type detachable ATOMIC_AS

	yyvsc31: INTEGER
			-- Capacity of semantic value stack `yyvs31'

	yyvsp31: INTEGER
			-- Top of semantic value stack `yyvs31'

	yyspecial_routines31: detachable KL_SPECIAL_ROUTINES [detachable ATOMIC_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable ATOMIC_AS]

	yyvs32: SPECIAL [detachable BINARY_AS]
			-- Stack for semantic values of type detachable BINARY_AS

	yyvsc32: INTEGER
			-- Capacity of semantic value stack `yyvs32'

	yyvsp32: INTEGER
			-- Top of semantic value stack `yyvs32'

	yyspecial_routines32: detachable KL_SPECIAL_ROUTINES [detachable BINARY_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable BINARY_AS]

	yyvs33: SPECIAL [detachable BIT_CONST_AS]
			-- Stack for semantic values of type detachable BIT_CONST_AS

	yyvsc33: INTEGER
			-- Capacity of semantic value stack `yyvs33'

	yyvsp33: INTEGER
			-- Top of semantic value stack `yyvs33'

	yyspecial_routines33: detachable KL_SPECIAL_ROUTINES [detachable BIT_CONST_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable BIT_CONST_AS]

	yyvs34: SPECIAL [detachable BODY_AS]
			-- Stack for semantic values of type detachable BODY_AS

	yyvsc34: INTEGER
			-- Capacity of semantic value stack `yyvs34'

	yyvsp34: INTEGER
			-- Top of semantic value stack `yyvs34'

	yyspecial_routines34: detachable KL_SPECIAL_ROUTINES [detachable BODY_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable BODY_AS]

	yyvs35: SPECIAL [detachable CALL_AS]
			-- Stack for semantic values of type detachable CALL_AS

	yyvsc35: INTEGER
			-- Capacity of semantic value stack `yyvs35'

	yyvsp35: INTEGER
			-- Top of semantic value stack `yyvs35'

	yyspecial_routines35: detachable KL_SPECIAL_ROUTINES [detachable CALL_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable CALL_AS]

	yyvs36: SPECIAL [detachable CASE_AS]
			-- Stack for semantic values of type detachable CASE_AS

	yyvsc36: INTEGER
			-- Capacity of semantic value stack `yyvs36'

	yyvsp36: INTEGER
			-- Top of semantic value stack `yyvs36'

	yyspecial_routines36: detachable KL_SPECIAL_ROUTINES [detachable CASE_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable CASE_AS]

	yyvs37: SPECIAL [detachable CHECK_AS]
			-- Stack for semantic values of type detachable CHECK_AS

	yyvsc37: INTEGER
			-- Capacity of semantic value stack `yyvs37'

	yyvsp37: INTEGER
			-- Top of semantic value stack `yyvs37'

	yyspecial_routines37: detachable KL_SPECIAL_ROUTINES [detachable CHECK_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable CHECK_AS]

	yyvs38: SPECIAL [detachable CLIENT_AS]
			-- Stack for semantic values of type detachable CLIENT_AS

	yyvsc38: INTEGER
			-- Capacity of semantic value stack `yyvs38'

	yyvsp38: INTEGER
			-- Top of semantic value stack `yyvs38'

	yyspecial_routines38: detachable KL_SPECIAL_ROUTINES [detachable CLIENT_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable CLIENT_AS]

	yyvs39: SPECIAL [detachable CONSTANT_AS]
			-- Stack for semantic values of type detachable CONSTANT_AS

	yyvsc39: INTEGER
			-- Capacity of semantic value stack `yyvs39'

	yyvsp39: INTEGER
			-- Top of semantic value stack `yyvs39'

	yyspecial_routines39: detachable KL_SPECIAL_ROUTINES [detachable CONSTANT_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable CONSTANT_AS]

	yyvs40: SPECIAL [detachable CONVERT_FEAT_AS]
			-- Stack for semantic values of type detachable CONVERT_FEAT_AS

	yyvsc40: INTEGER
			-- Capacity of semantic value stack `yyvs40'

	yyvsp40: INTEGER
			-- Top of semantic value stack `yyvs40'

	yyspecial_routines40: detachable KL_SPECIAL_ROUTINES [detachable CONVERT_FEAT_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable CONVERT_FEAT_AS]

	yyvs41: SPECIAL [detachable CREATE_AS]
			-- Stack for semantic values of type detachable CREATE_AS

	yyvsc41: INTEGER
			-- Capacity of semantic value stack `yyvs41'

	yyvsp41: INTEGER
			-- Top of semantic value stack `yyvs41'

	yyspecial_routines41: detachable KL_SPECIAL_ROUTINES [detachable CREATE_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable CREATE_AS]

	yyvs42: SPECIAL [detachable CREATION_AS]
			-- Stack for semantic values of type detachable CREATION_AS

	yyvsc42: INTEGER
			-- Capacity of semantic value stack `yyvs42'

	yyvsp42: INTEGER
			-- Top of semantic value stack `yyvs42'

	yyspecial_routines42: detachable KL_SPECIAL_ROUTINES [detachable CREATION_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable CREATION_AS]

	yyvs43: SPECIAL [detachable CREATION_EXPR_AS]
			-- Stack for semantic values of type detachable CREATION_EXPR_AS

	yyvsc43: INTEGER
			-- Capacity of semantic value stack `yyvs43'

	yyvsp43: INTEGER
			-- Top of semantic value stack `yyvs43'

	yyspecial_routines43: detachable KL_SPECIAL_ROUTINES [detachable CREATION_EXPR_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable CREATION_EXPR_AS]

	yyvs44: SPECIAL [detachable DEBUG_AS]
			-- Stack for semantic values of type detachable DEBUG_AS

	yyvsc44: INTEGER
			-- Capacity of semantic value stack `yyvs44'

	yyvsp44: INTEGER
			-- Top of semantic value stack `yyvs44'

	yyspecial_routines44: detachable KL_SPECIAL_ROUTINES [detachable DEBUG_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable DEBUG_AS]

	yyvs45: SPECIAL [detachable ELSIF_AS]
			-- Stack for semantic values of type detachable ELSIF_AS

	yyvsc45: INTEGER
			-- Capacity of semantic value stack `yyvs45'

	yyvsp45: INTEGER
			-- Top of semantic value stack `yyvs45'

	yyspecial_routines45: detachable KL_SPECIAL_ROUTINES [detachable ELSIF_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable ELSIF_AS]

	yyvs46: SPECIAL [detachable ENSURE_AS]
			-- Stack for semantic values of type detachable ENSURE_AS

	yyvsc46: INTEGER
			-- Capacity of semantic value stack `yyvs46'

	yyvsp46: INTEGER
			-- Top of semantic value stack `yyvs46'

	yyspecial_routines46: detachable KL_SPECIAL_ROUTINES [detachable ENSURE_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable ENSURE_AS]

	yyvs47: SPECIAL [detachable EXPORT_ITEM_AS]
			-- Stack for semantic values of type detachable EXPORT_ITEM_AS

	yyvsc47: INTEGER
			-- Capacity of semantic value stack `yyvs47'

	yyvsp47: INTEGER
			-- Top of semantic value stack `yyvs47'

	yyspecial_routines47: detachable KL_SPECIAL_ROUTINES [detachable EXPORT_ITEM_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable EXPORT_ITEM_AS]

	yyvs48: SPECIAL [detachable EXPR_AS]
			-- Stack for semantic values of type detachable EXPR_AS

	yyvsc48: INTEGER
			-- Capacity of semantic value stack `yyvs48'

	yyvsp48: INTEGER
			-- Top of semantic value stack `yyvs48'

	yyspecial_routines48: detachable KL_SPECIAL_ROUTINES [detachable EXPR_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable EXPR_AS]

	yyvs49: SPECIAL [detachable EXTERNAL_AS]
			-- Stack for semantic values of type detachable EXTERNAL_AS

	yyvsc49: INTEGER
			-- Capacity of semantic value stack `yyvs49'

	yyvsp49: INTEGER
			-- Top of semantic value stack `yyvs49'

	yyspecial_routines49: detachable KL_SPECIAL_ROUTINES [detachable EXTERNAL_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable EXTERNAL_AS]

	yyvs50: SPECIAL [detachable EXTERNAL_LANG_AS]
			-- Stack for semantic values of type detachable EXTERNAL_LANG_AS

	yyvsc50: INTEGER
			-- Capacity of semantic value stack `yyvs50'

	yyvsp50: INTEGER
			-- Top of semantic value stack `yyvs50'

	yyspecial_routines50: detachable KL_SPECIAL_ROUTINES [detachable EXTERNAL_LANG_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable EXTERNAL_LANG_AS]

	yyvs51: SPECIAL [detachable FEATURE_AS]
			-- Stack for semantic values of type detachable FEATURE_AS

	yyvsc51: INTEGER
			-- Capacity of semantic value stack `yyvs51'

	yyvsp51: INTEGER
			-- Top of semantic value stack `yyvs51'

	yyspecial_routines51: detachable KL_SPECIAL_ROUTINES [detachable FEATURE_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable FEATURE_AS]

	yyvs52: SPECIAL [detachable FEATURE_CLAUSE_AS]
			-- Stack for semantic values of type detachable FEATURE_CLAUSE_AS

	yyvsc52: INTEGER
			-- Capacity of semantic value stack `yyvs52'

	yyvsp52: INTEGER
			-- Top of semantic value stack `yyvs52'

	yyspecial_routines52: detachable KL_SPECIAL_ROUTINES [detachable FEATURE_CLAUSE_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable FEATURE_CLAUSE_AS]

	yyvs53: SPECIAL [detachable FEATURE_SET_AS]
			-- Stack for semantic values of type detachable FEATURE_SET_AS

	yyvsc53: INTEGER
			-- Capacity of semantic value stack `yyvs53'

	yyvsp53: INTEGER
			-- Top of semantic value stack `yyvs53'

	yyspecial_routines53: detachable KL_SPECIAL_ROUTINES [detachable FEATURE_SET_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable FEATURE_SET_AS]

	yyvs54: SPECIAL [detachable FORMAL_AS]
			-- Stack for semantic values of type detachable FORMAL_AS

	yyvsc54: INTEGER
			-- Capacity of semantic value stack `yyvs54'

	yyvsp54: INTEGER
			-- Top of semantic value stack `yyvs54'

	yyspecial_routines54: detachable KL_SPECIAL_ROUTINES [detachable FORMAL_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable FORMAL_AS]

	yyvs55: SPECIAL [detachable FORMAL_DEC_AS]
			-- Stack for semantic values of type detachable FORMAL_DEC_AS

	yyvsc55: INTEGER
			-- Capacity of semantic value stack `yyvs55'

	yyvsp55: INTEGER
			-- Top of semantic value stack `yyvs55'

	yyspecial_routines55: detachable KL_SPECIAL_ROUTINES [detachable FORMAL_DEC_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable FORMAL_DEC_AS]

	yyvs56: SPECIAL [detachable GUARD_AS]
			-- Stack for semantic values of type detachable GUARD_AS

	yyvsc56: INTEGER
			-- Capacity of semantic value stack `yyvs56'

	yyvsp56: INTEGER
			-- Top of semantic value stack `yyvs56'

	yyspecial_routines56: detachable KL_SPECIAL_ROUTINES [detachable GUARD_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable GUARD_AS]

	yyvs57: SPECIAL [detachable IF_AS]
			-- Stack for semantic values of type detachable IF_AS

	yyvsc57: INTEGER
			-- Capacity of semantic value stack `yyvs57'

	yyvsp57: INTEGER
			-- Top of semantic value stack `yyvs57'

	yyspecial_routines57: detachable KL_SPECIAL_ROUTINES [detachable IF_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable IF_AS]

	yyvs58: SPECIAL [detachable INDEX_AS]
			-- Stack for semantic values of type detachable INDEX_AS

	yyvsc58: INTEGER
			-- Capacity of semantic value stack `yyvs58'

	yyvsp58: INTEGER
			-- Top of semantic value stack `yyvs58'

	yyspecial_routines58: detachable KL_SPECIAL_ROUTINES [detachable INDEX_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable INDEX_AS]

	yyvs59: SPECIAL [detachable INSPECT_AS]
			-- Stack for semantic values of type detachable INSPECT_AS

	yyvsc59: INTEGER
			-- Capacity of semantic value stack `yyvs59'

	yyvsp59: INTEGER
			-- Top of semantic value stack `yyvs59'

	yyspecial_routines59: detachable KL_SPECIAL_ROUTINES [detachable INSPECT_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable INSPECT_AS]

	yyvs60: SPECIAL [detachable INSTRUCTION_AS]
			-- Stack for semantic values of type detachable INSTRUCTION_AS

	yyvsc60: INTEGER
			-- Capacity of semantic value stack `yyvs60'

	yyvsp60: INTEGER
			-- Top of semantic value stack `yyvs60'

	yyspecial_routines60: detachable KL_SPECIAL_ROUTINES [detachable INSTRUCTION_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable INSTRUCTION_AS]

	yyvs61: SPECIAL [detachable INTEGER_AS]
			-- Stack for semantic values of type detachable INTEGER_AS

	yyvsc61: INTEGER
			-- Capacity of semantic value stack `yyvs61'

	yyvsp61: INTEGER
			-- Top of semantic value stack `yyvs61'

	yyspecial_routines61: detachable KL_SPECIAL_ROUTINES [detachable INTEGER_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable INTEGER_AS]

	yyvs62: SPECIAL [detachable INTERNAL_AS]
			-- Stack for semantic values of type detachable INTERNAL_AS

	yyvsc62: INTEGER
			-- Capacity of semantic value stack `yyvs62'

	yyvsp62: INTEGER
			-- Top of semantic value stack `yyvs62'

	yyspecial_routines62: detachable KL_SPECIAL_ROUTINES [detachable INTERNAL_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable INTERNAL_AS]

	yyvs63: SPECIAL [detachable INTERVAL_AS]
			-- Stack for semantic values of type detachable INTERVAL_AS

	yyvsc63: INTEGER
			-- Capacity of semantic value stack `yyvs63'

	yyvsp63: INTEGER
			-- Top of semantic value stack `yyvs63'

	yyspecial_routines63: detachable KL_SPECIAL_ROUTINES [detachable INTERVAL_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable INTERVAL_AS]

	yyvs64: SPECIAL [detachable INVARIANT_AS]
			-- Stack for semantic values of type detachable INVARIANT_AS

	yyvsc64: INTEGER
			-- Capacity of semantic value stack `yyvs64'

	yyvsp64: INTEGER
			-- Top of semantic value stack `yyvs64'

	yyspecial_routines64: detachable KL_SPECIAL_ROUTINES [detachable INVARIANT_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable INVARIANT_AS]

	yyvs65: SPECIAL [detachable LOOP_EXPR_AS]
			-- Stack for semantic values of type detachable LOOP_EXPR_AS

	yyvsc65: INTEGER
			-- Capacity of semantic value stack `yyvs65'

	yyvsp65: INTEGER
			-- Top of semantic value stack `yyvs65'

	yyspecial_routines65: detachable KL_SPECIAL_ROUTINES [detachable LOOP_EXPR_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable LOOP_EXPR_AS]

	yyvs66: SPECIAL [detachable LOOP_AS]
			-- Stack for semantic values of type detachable LOOP_AS

	yyvsc66: INTEGER
			-- Capacity of semantic value stack `yyvs66'

	yyvsp66: INTEGER
			-- Top of semantic value stack `yyvs66'

	yyspecial_routines66: detachable KL_SPECIAL_ROUTINES [detachable LOOP_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable LOOP_AS]

	yyvs67: SPECIAL [detachable NESTED_AS]
			-- Stack for semantic values of type detachable NESTED_AS

	yyvsc67: INTEGER
			-- Capacity of semantic value stack `yyvs67'

	yyvsp67: INTEGER
			-- Top of semantic value stack `yyvs67'

	yyspecial_routines67: detachable KL_SPECIAL_ROUTINES [detachable NESTED_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable NESTED_AS]

	yyvs68: SPECIAL [detachable OPERAND_AS]
			-- Stack for semantic values of type detachable OPERAND_AS

	yyvsc68: INTEGER
			-- Capacity of semantic value stack `yyvs68'

	yyvsp68: INTEGER
			-- Top of semantic value stack `yyvs68'

	yyspecial_routines68: detachable KL_SPECIAL_ROUTINES [detachable OPERAND_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable OPERAND_AS]

	yyvs69: SPECIAL [detachable PARENT_AS]
			-- Stack for semantic values of type detachable PARENT_AS

	yyvsc69: INTEGER
			-- Capacity of semantic value stack `yyvs69'

	yyvsp69: INTEGER
			-- Top of semantic value stack `yyvs69'

	yyspecial_routines69: detachable KL_SPECIAL_ROUTINES [detachable PARENT_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable PARENT_AS]

	yyvs70: SPECIAL [detachable PRECURSOR_AS]
			-- Stack for semantic values of type detachable PRECURSOR_AS

	yyvsc70: INTEGER
			-- Capacity of semantic value stack `yyvs70'

	yyvsp70: INTEGER
			-- Top of semantic value stack `yyvs70'

	yyspecial_routines70: detachable KL_SPECIAL_ROUTINES [detachable PRECURSOR_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable PRECURSOR_AS]

	yyvs71: SPECIAL [detachable STATIC_ACCESS_AS]
			-- Stack for semantic values of type detachable STATIC_ACCESS_AS

	yyvsc71: INTEGER
			-- Capacity of semantic value stack `yyvs71'

	yyvsp71: INTEGER
			-- Top of semantic value stack `yyvs71'

	yyspecial_routines71: detachable KL_SPECIAL_ROUTINES [detachable STATIC_ACCESS_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable STATIC_ACCESS_AS]

	yyvs72: SPECIAL [detachable REAL_AS]
			-- Stack for semantic values of type detachable REAL_AS

	yyvsc72: INTEGER
			-- Capacity of semantic value stack `yyvs72'

	yyvsp72: INTEGER
			-- Top of semantic value stack `yyvs72'

	yyspecial_routines72: detachable KL_SPECIAL_ROUTINES [detachable REAL_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable REAL_AS]

	yyvs73: SPECIAL [detachable RENAME_AS]
			-- Stack for semantic values of type detachable RENAME_AS

	yyvsc73: INTEGER
			-- Capacity of semantic value stack `yyvs73'

	yyvsp73: INTEGER
			-- Top of semantic value stack `yyvs73'

	yyspecial_routines73: detachable KL_SPECIAL_ROUTINES [detachable RENAME_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable RENAME_AS]

	yyvs74: SPECIAL [detachable REQUIRE_AS]
			-- Stack for semantic values of type detachable REQUIRE_AS

	yyvsc74: INTEGER
			-- Capacity of semantic value stack `yyvs74'

	yyvsp74: INTEGER
			-- Top of semantic value stack `yyvs74'

	yyspecial_routines74: detachable KL_SPECIAL_ROUTINES [detachable REQUIRE_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable REQUIRE_AS]

	yyvs75: SPECIAL [detachable REVERSE_AS]
			-- Stack for semantic values of type detachable REVERSE_AS

	yyvsc75: INTEGER
			-- Capacity of semantic value stack `yyvs75'

	yyvsp75: INTEGER
			-- Top of semantic value stack `yyvs75'

	yyspecial_routines75: detachable KL_SPECIAL_ROUTINES [detachable REVERSE_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable REVERSE_AS]

	yyvs76: SPECIAL [detachable ROUT_BODY_AS]
			-- Stack for semantic values of type detachable ROUT_BODY_AS

	yyvsc76: INTEGER
			-- Capacity of semantic value stack `yyvs76'

	yyvsp76: INTEGER
			-- Top of semantic value stack `yyvs76'

	yyspecial_routines76: detachable KL_SPECIAL_ROUTINES [detachable ROUT_BODY_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable ROUT_BODY_AS]

	yyvs77: SPECIAL [detachable ROUTINE_AS]
			-- Stack for semantic values of type detachable ROUTINE_AS

	yyvsc77: INTEGER
			-- Capacity of semantic value stack `yyvs77'

	yyvsp77: INTEGER
			-- Top of semantic value stack `yyvs77'

	yyspecial_routines77: detachable KL_SPECIAL_ROUTINES [detachable ROUTINE_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable ROUTINE_AS]

	yyvs78: SPECIAL [detachable ROUTINE_CREATION_AS]
			-- Stack for semantic values of type detachable ROUTINE_CREATION_AS

	yyvsc78: INTEGER
			-- Capacity of semantic value stack `yyvs78'

	yyvsp78: INTEGER
			-- Top of semantic value stack `yyvs78'

	yyspecial_routines78: detachable KL_SPECIAL_ROUTINES [detachable ROUTINE_CREATION_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable ROUTINE_CREATION_AS]

	yyvs79: SPECIAL [detachable TAGGED_AS]
			-- Stack for semantic values of type detachable TAGGED_AS

	yyvsc79: INTEGER
			-- Capacity of semantic value stack `yyvs79'

	yyvsp79: INTEGER
			-- Top of semantic value stack `yyvs79'

	yyspecial_routines79: detachable KL_SPECIAL_ROUTINES [detachable TAGGED_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable TAGGED_AS]

	yyvs80: SPECIAL [detachable TUPLE_AS]
			-- Stack for semantic values of type detachable TUPLE_AS

	yyvsc80: INTEGER
			-- Capacity of semantic value stack `yyvs80'

	yyvsp80: INTEGER
			-- Top of semantic value stack `yyvs80'

	yyspecial_routines80: detachable KL_SPECIAL_ROUTINES [detachable TUPLE_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable TUPLE_AS]

	yyvs81: SPECIAL [detachable TYPE_AS]
			-- Stack for semantic values of type detachable TYPE_AS

	yyvsc81: INTEGER
			-- Capacity of semantic value stack `yyvs81'

	yyvsp81: INTEGER
			-- Top of semantic value stack `yyvs81'

	yyspecial_routines81: detachable KL_SPECIAL_ROUTINES [detachable TYPE_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable TYPE_AS]

	yyvs82: SPECIAL [detachable QUALIFIED_ANCHORED_TYPE_AS]
			-- Stack for semantic values of type detachable QUALIFIED_ANCHORED_TYPE_AS

	yyvsc82: INTEGER
			-- Capacity of semantic value stack `yyvs82'

	yyvsp82: INTEGER
			-- Top of semantic value stack `yyvs82'

	yyspecial_routines82: detachable KL_SPECIAL_ROUTINES [detachable QUALIFIED_ANCHORED_TYPE_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable QUALIFIED_ANCHORED_TYPE_AS]

	yyvs83: SPECIAL [detachable CLASS_TYPE_AS]
			-- Stack for semantic values of type detachable CLASS_TYPE_AS

	yyvsc83: INTEGER
			-- Capacity of semantic value stack `yyvs83'

	yyvsp83: INTEGER
			-- Top of semantic value stack `yyvs83'

	yyspecial_routines83: detachable KL_SPECIAL_ROUTINES [detachable CLASS_TYPE_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable CLASS_TYPE_AS]

	yyvs84: SPECIAL [detachable TYPE_DEC_AS]
			-- Stack for semantic values of type detachable TYPE_DEC_AS

	yyvsc84: INTEGER
			-- Capacity of semantic value stack `yyvs84'

	yyvsp84: INTEGER
			-- Top of semantic value stack `yyvs84'

	yyspecial_routines84: detachable KL_SPECIAL_ROUTINES [detachable TYPE_DEC_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable TYPE_DEC_AS]

	yyvs85: SPECIAL [detachable VARIANT_AS]
			-- Stack for semantic values of type detachable VARIANT_AS

	yyvsc85: INTEGER
			-- Capacity of semantic value stack `yyvs85'

	yyvsp85: INTEGER
			-- Top of semantic value stack `yyvs85'

	yyspecial_routines85: detachable KL_SPECIAL_ROUTINES [detachable VARIANT_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable VARIANT_AS]

	yyvs86: SPECIAL [detachable FEATURE_NAME]
			-- Stack for semantic values of type detachable FEATURE_NAME

	yyvsc86: INTEGER
			-- Capacity of semantic value stack `yyvs86'

	yyvsp86: INTEGER
			-- Top of semantic value stack `yyvs86'

	yyspecial_routines86: detachable KL_SPECIAL_ROUTINES [detachable FEATURE_NAME] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable FEATURE_NAME]

	yyvs87: SPECIAL [detachable EIFFEL_LIST [ATOMIC_AS]]
			-- Stack for semantic values of type detachable EIFFEL_LIST [ATOMIC_AS]

	yyvsc87: INTEGER
			-- Capacity of semantic value stack `yyvs87'

	yyvsp87: INTEGER
			-- Top of semantic value stack `yyvs87'

	yyspecial_routines87: detachable KL_SPECIAL_ROUTINES [detachable EIFFEL_LIST [ATOMIC_AS]] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable EIFFEL_LIST [ATOMIC_AS]]

	yyvs88: SPECIAL [detachable EIFFEL_LIST [CASE_AS]]
			-- Stack for semantic values of type detachable EIFFEL_LIST [CASE_AS]

	yyvsc88: INTEGER
			-- Capacity of semantic value stack `yyvs88'

	yyvsp88: INTEGER
			-- Top of semantic value stack `yyvs88'

	yyspecial_routines88: detachable KL_SPECIAL_ROUTINES [detachable EIFFEL_LIST [CASE_AS]] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable EIFFEL_LIST [CASE_AS]]

	yyvs89: SPECIAL [detachable CONVERT_FEAT_LIST_AS]
			-- Stack for semantic values of type detachable CONVERT_FEAT_LIST_AS

	yyvsc89: INTEGER
			-- Capacity of semantic value stack `yyvs89'

	yyvsp89: INTEGER
			-- Top of semantic value stack `yyvs89'

	yyspecial_routines89: detachable KL_SPECIAL_ROUTINES [detachable CONVERT_FEAT_LIST_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable CONVERT_FEAT_LIST_AS]

	yyvs90: SPECIAL [detachable EIFFEL_LIST [CREATE_AS]]
			-- Stack for semantic values of type detachable EIFFEL_LIST [CREATE_AS]

	yyvsc90: INTEGER
			-- Capacity of semantic value stack `yyvs90'

	yyvsp90: INTEGER
			-- Top of semantic value stack `yyvs90'

	yyspecial_routines90: detachable KL_SPECIAL_ROUTINES [detachable EIFFEL_LIST [CREATE_AS]] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable EIFFEL_LIST [CREATE_AS]]

	yyvs91: SPECIAL [detachable EIFFEL_LIST [ELSIF_AS]]
			-- Stack for semantic values of type detachable EIFFEL_LIST [ELSIF_AS]

	yyvsc91: INTEGER
			-- Capacity of semantic value stack `yyvs91'

	yyvsp91: INTEGER
			-- Top of semantic value stack `yyvs91'

	yyspecial_routines91: detachable KL_SPECIAL_ROUTINES [detachable EIFFEL_LIST [ELSIF_AS]] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable EIFFEL_LIST [ELSIF_AS]]

	yyvs92: SPECIAL [detachable EIFFEL_LIST [EXPORT_ITEM_AS]]
			-- Stack for semantic values of type detachable EIFFEL_LIST [EXPORT_ITEM_AS]

	yyvsc92: INTEGER
			-- Capacity of semantic value stack `yyvs92'

	yyvsp92: INTEGER
			-- Top of semantic value stack `yyvs92'

	yyspecial_routines92: detachable KL_SPECIAL_ROUTINES [detachable EIFFEL_LIST [EXPORT_ITEM_AS]] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable EIFFEL_LIST [EXPORT_ITEM_AS]]

	yyvs93: SPECIAL [detachable EXPORT_CLAUSE_AS]
			-- Stack for semantic values of type detachable EXPORT_CLAUSE_AS

	yyvsc93: INTEGER
			-- Capacity of semantic value stack `yyvs93'

	yyvsp93: INTEGER
			-- Top of semantic value stack `yyvs93'

	yyspecial_routines93: detachable KL_SPECIAL_ROUTINES [detachable EXPORT_CLAUSE_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable EXPORT_CLAUSE_AS]

	yyvs94: SPECIAL [detachable EIFFEL_LIST [EXPR_AS]]
			-- Stack for semantic values of type detachable EIFFEL_LIST [EXPR_AS]

	yyvsc94: INTEGER
			-- Capacity of semantic value stack `yyvs94'

	yyvsp94: INTEGER
			-- Top of semantic value stack `yyvs94'

	yyspecial_routines94: detachable KL_SPECIAL_ROUTINES [detachable EIFFEL_LIST [EXPR_AS]] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable EIFFEL_LIST [EXPR_AS]]

	yyvs95: SPECIAL [detachable PARAMETER_LIST_AS]
			-- Stack for semantic values of type detachable PARAMETER_LIST_AS

	yyvsc95: INTEGER
			-- Capacity of semantic value stack `yyvs95'

	yyvsp95: INTEGER
			-- Top of semantic value stack `yyvs95'

	yyspecial_routines95: detachable KL_SPECIAL_ROUTINES [detachable PARAMETER_LIST_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable PARAMETER_LIST_AS]

	yyvs96: SPECIAL [detachable EIFFEL_LIST [FEATURE_AS]]
			-- Stack for semantic values of type detachable EIFFEL_LIST [FEATURE_AS]

	yyvsc96: INTEGER
			-- Capacity of semantic value stack `yyvs96'

	yyvsp96: INTEGER
			-- Top of semantic value stack `yyvs96'

	yyspecial_routines96: detachable KL_SPECIAL_ROUTINES [detachable EIFFEL_LIST [FEATURE_AS]] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable EIFFEL_LIST [FEATURE_AS]]

	yyvs97: SPECIAL [detachable EIFFEL_LIST [FEATURE_CLAUSE_AS]]
			-- Stack for semantic values of type detachable EIFFEL_LIST [FEATURE_CLAUSE_AS]

	yyvsc97: INTEGER
			-- Capacity of semantic value stack `yyvs97'

	yyvsp97: INTEGER
			-- Top of semantic value stack `yyvs97'

	yyspecial_routines97: detachable KL_SPECIAL_ROUTINES [detachable EIFFEL_LIST [FEATURE_CLAUSE_AS]] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable EIFFEL_LIST [FEATURE_CLAUSE_AS]]

	yyvs98: SPECIAL [detachable EIFFEL_LIST [FEATURE_NAME]]
			-- Stack for semantic values of type detachable EIFFEL_LIST [FEATURE_NAME]

	yyvsc98: INTEGER
			-- Capacity of semantic value stack `yyvs98'

	yyvsp98: INTEGER
			-- Top of semantic value stack `yyvs98'

	yyspecial_routines98: detachable KL_SPECIAL_ROUTINES [detachable EIFFEL_LIST [FEATURE_NAME]] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable EIFFEL_LIST [FEATURE_NAME]]

	yyvs99: SPECIAL [detachable CREATION_CONSTRAIN_TRIPLE]
			-- Stack for semantic values of type detachable CREATION_CONSTRAIN_TRIPLE

	yyvsc99: INTEGER
			-- Capacity of semantic value stack `yyvs99'

	yyvsp99: INTEGER
			-- Top of semantic value stack `yyvs99'

	yyspecial_routines99: detachable KL_SPECIAL_ROUTINES [detachable CREATION_CONSTRAIN_TRIPLE] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable CREATION_CONSTRAIN_TRIPLE]

	yyvs100: SPECIAL [detachable UNDEFINE_CLAUSE_AS]
			-- Stack for semantic values of type detachable UNDEFINE_CLAUSE_AS

	yyvsc100: INTEGER
			-- Capacity of semantic value stack `yyvs100'

	yyvsp100: INTEGER
			-- Top of semantic value stack `yyvs100'

	yyspecial_routines100: detachable KL_SPECIAL_ROUTINES [detachable UNDEFINE_CLAUSE_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable UNDEFINE_CLAUSE_AS]

	yyvs101: SPECIAL [detachable REDEFINE_CLAUSE_AS]
			-- Stack for semantic values of type detachable REDEFINE_CLAUSE_AS

	yyvsc101: INTEGER
			-- Capacity of semantic value stack `yyvs101'

	yyvsp101: INTEGER
			-- Top of semantic value stack `yyvs101'

	yyspecial_routines101: detachable KL_SPECIAL_ROUTINES [detachable REDEFINE_CLAUSE_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable REDEFINE_CLAUSE_AS]

	yyvs102: SPECIAL [detachable SELECT_CLAUSE_AS]
			-- Stack for semantic values of type detachable SELECT_CLAUSE_AS

	yyvsc102: INTEGER
			-- Capacity of semantic value stack `yyvs102'

	yyvsp102: INTEGER
			-- Top of semantic value stack `yyvs102'

	yyspecial_routines102: detachable KL_SPECIAL_ROUTINES [detachable SELECT_CLAUSE_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable SELECT_CLAUSE_AS]

	yyvs103: SPECIAL [detachable FORMAL_GENERIC_LIST_AS]
			-- Stack for semantic values of type detachable FORMAL_GENERIC_LIST_AS

	yyvsc103: INTEGER
			-- Capacity of semantic value stack `yyvs103'

	yyvsp103: INTEGER
			-- Top of semantic value stack `yyvs103'

	yyspecial_routines103: detachable KL_SPECIAL_ROUTINES [detachable FORMAL_GENERIC_LIST_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable FORMAL_GENERIC_LIST_AS]

	yyvs104: SPECIAL [detachable CLASS_LIST_AS]
			-- Stack for semantic values of type detachable CLASS_LIST_AS

	yyvsc104: INTEGER
			-- Capacity of semantic value stack `yyvs104'

	yyvsp104: INTEGER
			-- Top of semantic value stack `yyvs104'

	yyspecial_routines104: detachable KL_SPECIAL_ROUTINES [detachable CLASS_LIST_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable CLASS_LIST_AS]

	yyvs105: SPECIAL [detachable INDEXING_CLAUSE_AS]
			-- Stack for semantic values of type detachable INDEXING_CLAUSE_AS

	yyvsc105: INTEGER
			-- Capacity of semantic value stack `yyvs105'

	yyvsp105: INTEGER
			-- Top of semantic value stack `yyvs105'

	yyspecial_routines105: detachable KL_SPECIAL_ROUTINES [detachable INDEXING_CLAUSE_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable INDEXING_CLAUSE_AS]

	yyvs106: SPECIAL [detachable ITERATION_AS]
			-- Stack for semantic values of type detachable ITERATION_AS

	yyvsc106: INTEGER
			-- Capacity of semantic value stack `yyvs106'

	yyvsp106: INTEGER
			-- Top of semantic value stack `yyvs106'

	yyspecial_routines106: detachable KL_SPECIAL_ROUTINES [detachable ITERATION_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable ITERATION_AS]

	yyvs107: SPECIAL [detachable EIFFEL_LIST [INSTRUCTION_AS]]
			-- Stack for semantic values of type detachable EIFFEL_LIST [INSTRUCTION_AS]

	yyvsc107: INTEGER
			-- Capacity of semantic value stack `yyvs107'

	yyvsp107: INTEGER
			-- Top of semantic value stack `yyvs107'

	yyspecial_routines107: detachable KL_SPECIAL_ROUTINES [detachable EIFFEL_LIST [INSTRUCTION_AS]] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable EIFFEL_LIST [INSTRUCTION_AS]]

	yyvs108: SPECIAL [detachable EIFFEL_LIST [INTERVAL_AS]]
			-- Stack for semantic values of type detachable EIFFEL_LIST [INTERVAL_AS]

	yyvsc108: INTEGER
			-- Capacity of semantic value stack `yyvs108'

	yyvsp108: INTEGER
			-- Top of semantic value stack `yyvs108'

	yyspecial_routines108: detachable KL_SPECIAL_ROUTINES [detachable EIFFEL_LIST [INTERVAL_AS]] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable EIFFEL_LIST [INTERVAL_AS]]

	yyvs109: SPECIAL [detachable EIFFEL_LIST [OPERAND_AS]]
			-- Stack for semantic values of type detachable EIFFEL_LIST [OPERAND_AS]

	yyvsc109: INTEGER
			-- Capacity of semantic value stack `yyvs109'

	yyvsp109: INTEGER
			-- Top of semantic value stack `yyvs109'

	yyspecial_routines109: detachable KL_SPECIAL_ROUTINES [detachable EIFFEL_LIST [OPERAND_AS]] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable EIFFEL_LIST [OPERAND_AS]]

	yyvs110: SPECIAL [detachable DELAYED_ACTUAL_LIST_AS]
			-- Stack for semantic values of type detachable DELAYED_ACTUAL_LIST_AS

	yyvsc110: INTEGER
			-- Capacity of semantic value stack `yyvs110'

	yyvsp110: INTEGER
			-- Top of semantic value stack `yyvs110'

	yyspecial_routines110: detachable KL_SPECIAL_ROUTINES [detachable DELAYED_ACTUAL_LIST_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable DELAYED_ACTUAL_LIST_AS]

	yyvs111: SPECIAL [detachable PARENT_LIST_AS]
			-- Stack for semantic values of type detachable PARENT_LIST_AS

	yyvsc111: INTEGER
			-- Capacity of semantic value stack `yyvs111'

	yyvsp111: INTEGER
			-- Top of semantic value stack `yyvs111'

	yyspecial_routines111: detachable KL_SPECIAL_ROUTINES [detachable PARENT_LIST_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable PARENT_LIST_AS]

	yyvs112: SPECIAL [detachable EIFFEL_LIST [RENAME_AS]]
			-- Stack for semantic values of type detachable EIFFEL_LIST [RENAME_AS]

	yyvsc112: INTEGER
			-- Capacity of semantic value stack `yyvs112'

	yyvsp112: INTEGER
			-- Top of semantic value stack `yyvs112'

	yyspecial_routines112: detachable KL_SPECIAL_ROUTINES [detachable EIFFEL_LIST [RENAME_AS]] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable EIFFEL_LIST [RENAME_AS]]

	yyvs113: SPECIAL [detachable RENAME_CLAUSE_AS]
			-- Stack for semantic values of type detachable RENAME_CLAUSE_AS

	yyvsc113: INTEGER
			-- Capacity of semantic value stack `yyvs113'

	yyvsp113: INTEGER
			-- Top of semantic value stack `yyvs113'

	yyspecial_routines113: detachable KL_SPECIAL_ROUTINES [detachable RENAME_CLAUSE_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable RENAME_CLAUSE_AS]

	yyvs114: SPECIAL [detachable EIFFEL_LIST [STRING_AS]]
			-- Stack for semantic values of type detachable EIFFEL_LIST [STRING_AS]

	yyvsc114: INTEGER
			-- Capacity of semantic value stack `yyvs114'

	yyvsp114: INTEGER
			-- Top of semantic value stack `yyvs114'

	yyspecial_routines114: detachable KL_SPECIAL_ROUTINES [detachable EIFFEL_LIST [STRING_AS]] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable EIFFEL_LIST [STRING_AS]]

	yyvs115: SPECIAL [detachable KEY_LIST_AS]
			-- Stack for semantic values of type detachable KEY_LIST_AS

	yyvsc115: INTEGER
			-- Capacity of semantic value stack `yyvs115'

	yyvsp115: INTEGER
			-- Top of semantic value stack `yyvs115'

	yyspecial_routines115: detachable KL_SPECIAL_ROUTINES [detachable KEY_LIST_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable KEY_LIST_AS]

	yyvs116: SPECIAL [detachable EIFFEL_LIST [TAGGED_AS]]
			-- Stack for semantic values of type detachable EIFFEL_LIST [TAGGED_AS]

	yyvsc116: INTEGER
			-- Capacity of semantic value stack `yyvs116'

	yyvsp116: INTEGER
			-- Top of semantic value stack `yyvs116'

	yyspecial_routines116: detachable KL_SPECIAL_ROUTINES [detachable EIFFEL_LIST [TAGGED_AS]] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable EIFFEL_LIST [TAGGED_AS]]

	yyvs117: SPECIAL [detachable TYPE_LIST_AS]
			-- Stack for semantic values of type detachable TYPE_LIST_AS

	yyvsc117: INTEGER
			-- Capacity of semantic value stack `yyvs117'

	yyvsp117: INTEGER
			-- Top of semantic value stack `yyvs117'

	yyspecial_routines117: detachable KL_SPECIAL_ROUTINES [detachable TYPE_LIST_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable TYPE_LIST_AS]

	yyvs118: SPECIAL [detachable TYPE_DEC_LIST_AS]
			-- Stack for semantic values of type detachable TYPE_DEC_LIST_AS

	yyvsc118: INTEGER
			-- Capacity of semantic value stack `yyvs118'

	yyvsp118: INTEGER
			-- Top of semantic value stack `yyvs118'

	yyspecial_routines118: detachable KL_SPECIAL_ROUTINES [detachable TYPE_DEC_LIST_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable TYPE_DEC_LIST_AS]

	yyvs119: SPECIAL [detachable LOCAL_DEC_LIST_AS]
			-- Stack for semantic values of type detachable LOCAL_DEC_LIST_AS

	yyvsc119: INTEGER
			-- Capacity of semantic value stack `yyvs119'

	yyvsp119: INTEGER
			-- Top of semantic value stack `yyvs119'

	yyspecial_routines119: detachable KL_SPECIAL_ROUTINES [detachable LOCAL_DEC_LIST_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable LOCAL_DEC_LIST_AS]

	yyvs120: SPECIAL [detachable FORMAL_ARGU_DEC_LIST_AS]
			-- Stack for semantic values of type detachable FORMAL_ARGU_DEC_LIST_AS

	yyvsc120: INTEGER
			-- Capacity of semantic value stack `yyvs120'

	yyvsp120: INTEGER
			-- Top of semantic value stack `yyvs120'

	yyspecial_routines120: detachable KL_SPECIAL_ROUTINES [detachable FORMAL_ARGU_DEC_LIST_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable FORMAL_ARGU_DEC_LIST_AS]

	yyvs121: SPECIAL [detachable CONSTRAINT_TRIPLE]
			-- Stack for semantic values of type detachable CONSTRAINT_TRIPLE

	yyvsc121: INTEGER
			-- Capacity of semantic value stack `yyvs121'

	yyvsp121: INTEGER
			-- Top of semantic value stack `yyvs121'

	yyspecial_routines121: detachable KL_SPECIAL_ROUTINES [detachable CONSTRAINT_TRIPLE] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable CONSTRAINT_TRIPLE]

	yyvs122: SPECIAL [detachable CONSTRAINT_LIST_AS]
			-- Stack for semantic values of type detachable CONSTRAINT_LIST_AS

	yyvsc122: INTEGER
			-- Capacity of semantic value stack `yyvs122'

	yyvsp122: INTEGER
			-- Top of semantic value stack `yyvs122'

	yyspecial_routines122: detachable KL_SPECIAL_ROUTINES [detachable CONSTRAINT_LIST_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable CONSTRAINT_LIST_AS]

	yyvs123: SPECIAL [detachable CONSTRAINING_TYPE_AS]
			-- Stack for semantic values of type detachable CONSTRAINING_TYPE_AS

	yyvsc123: INTEGER
			-- Capacity of semantic value stack `yyvs123'

	yyvsp123: INTEGER
			-- Top of semantic value stack `yyvs123'

	yyspecial_routines123: detachable KL_SPECIAL_ROUTINES [detachable CONSTRAINING_TYPE_AS] note option: stable attribute end
			-- Routines that ought to be in SPECIAL [detachable CONSTRAINING_TYPE_AS]

feature {NONE} -- Constants

	yyFinal: INTEGER = 1103
			-- Termination state id

	yyFlag: INTEGER = -32768
			-- Most negative INTEGER

	yyNtbase: INTEGER = 140
			-- Number of tokens

	yyLast: INTEGER = 4322
			-- Upper bound of `yytable' and `yycheck'

	yyMax_token: INTEGER = 394
			-- Maximum token id
			-- (upper bound of `yytranslate'.)

	yyNsyms: INTEGER = 378
			-- Number of symbols
			-- (terminal and nonterminal)

feature -- User-defined features



note
	copyright:	"Copyright (c) 1984-2011, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EIFFEL_PARSER

